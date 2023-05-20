import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_picker/controller/image_picker_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatelessWidget {
  ImagePickerController imageController = Get.put(ImagePickerController());

  ImagePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
        elevation: 1.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(4),
        child: Center(
          child: _createHome(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt_outlined),
        onPressed: () async {
          final ImagePicker imgPicker = ImagePicker();
          final XFile? image =
              await imgPicker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            imageController.imageFile.value = File(image.path);
          }
        },
      ),
    );
  }

  Widget _createHome(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Obx(
        () => imageController.imageFile.value == null
            ? const Icon(Icons.image, size: 100)
            : Image.file(imageController.imageFile.value!,
                fit: BoxFit.scaleDown),
      ),
    );
  }
}
