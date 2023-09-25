Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25347AE27B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjIYXfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjIYXf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:35:27 -0400
Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B891AC;
        Mon, 25 Sep 2023 16:35:16 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 38PNYkes229124; Tue, 26 Sep 2023 08:34:47 +0900
X-Iguazu-Qid: 2rWgJRkMWWk6YqYDxI
X-Iguazu-QSIG: v=2; s=0; t=1695684886; q=2rWgJRkMWWk6YqYDxI; m=Q1w+1ZFSkmh4JQRQIUhikIDS4J4EZgDLy05Vl7jPN/w=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1123) id 38PNYglr4193045
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Sep 2023 08:34:43 +0900
X-SA-MID: 8623336
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/5] documentation: media: add documentation for Toshiba Visconti Video Input Interface driver
Date:   Tue, 26 Sep 2023 08:28:05 +0900
X-TSB-HOP2: ON
Message-Id: <20230925232806.950683-5-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925232806.950683-1-yuji2.ishikawa@toshiba.co.jp>
References: <20230925232806.950683-1-yuji2.ishikawa@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added basic description of Video Input Interface driver of
Toshiba Visconti architecture.
It includes hardware organization, structure of the driver
and description of vendor specific V4L2 controls
to configure the embedded image signal processor.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
---
Changelog v3:
- Newly add documentation to describe SW and HW

Changelog v4:
- no change

Changelog v5:
- no change

Changelog v6:
- add description of CSI2RX subdevice
- add ordering of ioctl(S_FMT) and ioctl(S_EXT_CTRLS)

Changelog v7:
- no change

Changelog v8:
- add usage of V4L2_CTRL_TYPE_VISCONTI_ISP

 .../driver-api/media/drivers/index.rst        |   1 +
 .../media/drivers/visconti-viif.rst           | 462 ++++++++++++++++++
 .../media/v4l/vidioc-g-ext-ctrls.rst          |   4 +
 .../media/v4l/vidioc-queryctrl.rst            |   5 +
 4 files changed, 472 insertions(+)
 create mode 100644 Documentation/driver-api/media/drivers/visconti-viif.rst

diff --git a/Documentation/driver-api/media/drivers/index.rst b/Documentation/driver-api/media/drivers/index.rst
index c4123a16b5f9..5592bd99ae5c 100644
--- a/Documentation/driver-api/media/drivers/index.rst
+++ b/Documentation/driver-api/media/drivers/index.rst
@@ -24,6 +24,7 @@ Video4Linux (V4L) drivers
 	sh_mobile_ceu_camera
 	tuners
 	vimc-devel
+	visconti-viif
 	zoran
 	ccs/ccs
 
diff --git a/Documentation/driver-api/media/drivers/visconti-viif.rst b/Documentation/driver-api/media/drivers/visconti-viif.rst
new file mode 100644
index 000000000000..fd2480cbde46
--- /dev/null
+++ b/Documentation/driver-api/media/drivers/visconti-viif.rst
@@ -0,0 +1,462 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================
+Visconti Video Input Interface (VIIF) Driver
+============================================
+
+Overview
+========
+
+The Visconti VIIF Hardware
+--------------------------
+
+The Visconti Video Input Interface (VIIF) hardware is  a proprietary videocapture device of Toshiba.
+Following function modules are integrated:
+
+* MIPI CSI2 receiver (CSI2RX)
+* L1 Image Signal Processor (L1ISP)
+
+  * Correction, enhancement, adjustment on RAW pictures.
+
+* L2 Image Signal Processor (L2ISP)
+
+  * Lens distortion correction
+  * Scaling
+  * Cropping
+
+* Video DMAC
+
+  * format picture (RGB, YUV, Grayscale, ...)
+  * write picture into DRAM
+
+Visconti5 SoC has two VIIF hardware instances.
+
+software architecture
+---------------------
+
+The Visconti VIIF driver is composed of following components:
+
+* (image sensor driver)
+* MIPI CSI2 receiver subdevice driver
+
+  * corresponding to CSI2RX
+
+* Visconti ISP subdevice driver
+
+  * corresponding to L1ISP, L2ISP (Lens distortion correction, Scaling)
+
+* Visconti Capture V4L2 device driver
+
+  * corresponding to L2ISP (Cropping) and Video DMAC
+  * multiple output videobuf queues
+
+    * main path0 (RGB, YUV, Grayscale, ...)
+    * main path1 (RGB, YUV, Grayscale, ...)
+    * sub path (RAW picture)
+
+::
+
+  +-----------+      +-----------+     +----------------+       +-------------------------+
+  | Sensor    |      | CSI2RX    |     | ISP            |       | Capture MAIN PATH0      |
+  | subdevice | ---- | subdevice | --- | subdevice      | --+-- | V4L2 device             |
+  | (IMX219)  |      | (CSI2RX)  |     | (L1ISP, L2ISP) |   |   | (L2ISP crop, VideoDMAC) |
+  +-----------+      +-----------+     +----------------+   |   +-------------------------+
+                                                            |
+                                                            |   +-------------------------+
+                                                            |   | Capture MAIN PATH1      |
+                                                            +-- | V4L2 device             |
+                                                            |   | (L2ISP crop, VideoDMAC) |
+                                                            |   +-------------------------+
+                                                            |
+                                                            |   +-------------------------+
+                                                            |   | Capture SUB PATH        |
+                                                            +-- | V4L2 device             |
+                                                                | (VideoDMAC)             |
+                                                                +-------------------------+
+
+
+The VIIF driver provides following device nodes for Visconti5 SoC:
+
+* VIIF0
+
+  * /dev/media0
+  * /dev/video0 (main path0)
+  * /dev/video1 (main path1)
+  * /dev/video2 (sub path)
+
+* VIIF1
+
+  * /dev/media1
+  * /dev/video3 (main path0)
+  * /dev/video4 (main path1)
+  * /dev/video5 (sub path)
+
+Use of coherent memory
+----------------------
+
+Visconti5 SoC has two independent DDR SDRAM controllers.
+Each controller is mapped to 36bit address space.
+
+Accelerator bus masters have two paths to access memory;
+one is directly connected to SDRAM controller,
+the another is connected via a cache coherency bus
+which keeps coherency among CPUs.
+
+From acclerators and CPUs, the address map is following:
+
+* 0x0_8000_0000 DDR0 direct access
+* 0x4_8000_0000 DDR0 coherency bus
+* 0x8_8000_0000 DDR1 direct access
+* 0xC_8000_0000 DDR1 coherency bus
+
+The base address can be specified with "memory" and "reserved-memory" elements
+in a device tree description.
+It's not recommended to mix direct address and coherent address.
+
+The Visconti5 VIIF driver always use only direct address to configure Video DMACs of the hardware.
+This design is to avoid great performance loss at coherency bus caused by massive memory access.
+You should not put the dma_coherent attribute to viif element in device tree.
+Cache operations are done automatically by videobuf2 driver.
+
+Tested environment
+------------------
+
+The Visconti VIIF driver was tested with following items:
+
+* IMX219 image sensor
+* IMX335 image sensor
+
+IOCTLs
+======
+
+Following public IOCTLs are supported
+
+* VIDIOC_QUERYCAP
+* VIDIOC_ENUM_FMT
+* VIDIOC_TRY_FMT
+* VIDIOC_S_FMT
+* VIDIOC_G_FMT
+* VIDIOC_ENUM_FRAMESIZES
+* VIDIOC_G_EXT_CTRLS
+* VIDIOC_S_EXT_CTRLS
+* VIDIOC_REQBUFS
+* VIDIOC_QUERYBUF
+* VIDIOC_QBUF
+* VIDIOC_EXPBUF
+* VIDIOC_DQBUF
+* VIDIOC_CREATE_BUFS
+* VIDIOC_PREPARE_BUF
+* VIDIOC_STREAMON
+* VIDIOC_STREAMOFF
+
+Vendor specific v4l2 controls
+(except for V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE and
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE) should be called
+after ioctl(S_FMT) because setting the frame format may affect
+valid range of parameters of the controls.
+
+Vendor specific v4l2 controls
+=============================
+
+.. _V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE:
+
+V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE
+--------------------------------------------
+
+This control sets the format to pack multiple RAW pixel values into a word.
+
+This control accepts a __u32 value defined as `enum viif_rawpack_mode`.
+
+This control should be set before ioctl(S_FMT) and should not be changed after that.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE
+--------------------------------------------
+
+This control sets L1ISP preprocessing mode for RAW input images.
+
+This control accepts a `struct viif_l1_input_mode_config` instance.
+
+This control should be set before ioctl(S_FMT) and should not be changed after that.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF
+-----------------------------------------------
+
+This control sets parameters to yield Y value from RGB pixel values.
+
+This control accepts a `struct viif_l1_rgb_to_y_coef_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE
+-----------------------------------------
+
+This control sets rules of generating analog gains for each feature in L1ISP.
+Related features are:
+
+* Optical Black Clamp Correction (OBCC)
+* Defect Pixel Correction (DPC)
+* RAW Color Noise Reduction (RCNR)
+* Lens Shading Correction (LSC)
+* Color matrix correction (MPRO)
+* Image quality adjustment (VPRO)
+
+The base gain is set with V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG control.
+
+This control accepts a `struct viif_l1_ag_mode_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG
+------------------------------------
+
+This control sets base analog gain commonly used in L1ISP features.
+Analog gain for each L1ISP feature is generated
+from the base analog gain and a configuration via V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE control.
+
+This control accepts a `struct viif_l1_ag_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE
+--------------------------------------
+
+This controls sets parameters for HDR Expansion feature.
+
+This control accepts a `struct viif_l1_hdre_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION
+------------------------------------------------
+
+This control sets black level parameters for L1ISP inputs.
+
+This control accepts a `struct viif_l1_img_extraction_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC
+-------------------------------------
+
+This control sets parameters for Defect Pixel Correction.
+
+This control accepts a `struct viif_l1_dpc_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE
+------------------------------------------------------
+
+This control sets parameters for white balance.
+
+This control accepts a `struct viif_l1_preset_white_balance_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION
+-----------------------------------------------------------
+
+This control sets parameters for RAW color noise reduction (RCNR) feature.
+
+This control accepts a `struct viif_l1_raw_color_noise_reduction_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS
+--------------------------------------
+
+This control sets parameters for HDR synthesis.
+
+This control accepts a `struct viif_l1_hdrs_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION
+--------------------------------------------------------
+
+This control sets parameters for black level correction feature.
+
+This control accepts a `struct viif_l1_black_level_correction_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC
+-------------------------------------
+
+This control sets parameters for Lens Shading Correction feature.
+L1ISP supports 2 correction methods:
+
+* parabola shading
+* grid shading
+
+This control accepts a `struct viif_l1_lsc_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS
+----------------------------------------------
+
+This controls sets parameter for the MAIN PROCESS feature which is composed of:
+
+* demosaic
+* color matrix correction
+
+This control accepts a `struct viif_l1_main_process_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB
+-------------------------------------
+
+This control sets parameter for auto white balance feature.
+
+This control accepts a `struct viif_l1_awb_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN
+-------------------------------------------
+
+This control requests enable/disable of lock for AWB gain.
+
+This control accepts a u32 value; 0 for disable lock, 1 for enable lock.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC
+--------------------------------------
+
+This control sets parameter for HDR Compression feature.
+
+This control accepts a `struct viif_l1_hdrc_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM
+------------------------------------------
+
+This control sets parameter for HDR Compression Local Tone Mapping feature.
+
+This control accepts a `struct viif_l1_hdrc_ltm_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA
+---------------------------------------
+
+This control sets parameter for gamma correction at L1ISP.
+
+This control accepts a `struct viif_l1_gamma_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT
+--------------------------------------------------------
+
+This control sets parameter for VPRO feature which is composed of:
+
+* luminance adjustment:
+
+ * brightness adjustment
+ * linear contrast adjusment
+ * nonlinear contrast adjustment
+ * luminance noise reduction
+ * edge enhancement
+
+* chroma adjustment:
+
+ * chroma suppression
+ * color level adjustment
+ * chroma noise reduction
+ * coring suppression
+ * edge chroma suppression
+ * color noise reduction
+
+This control accepts a `struct viif_l1_img_quality_adjustment_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION
+----------------------------------------------------
+
+This control sets parameter for average luminance statistics feature.
+
+This control accepts a `struct viif_l1_avg_lum_generation_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST
+----------------------------------------
+
+This control sets parameter for the lens undistortion feature of L2ISP.
+Lens undistortion parameters are defined as either or combination of polinomial parameter and grid table.
+
+This control accepts a `struct viif_l2_undist_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI
+-------------------------------------
+
+This control sets dimensions of intermediate images and scaling parameter of L2ISP.
+If you want to crop the output image,
+you should set crop parameter to the corresponding source pad of the ISP subdevice with media-ctl tool.
+
+This control accepts a `struct viif_l2_roi_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA:
+
+V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA
+---------------------------------------
+
+This control sets gamma parameter for L2ISP.
+
+This control accepts a `struct viif_l2_gamma_config` instance.
+
+.. _V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS:
+
+V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS
+----------------------------------------------------
+
+This control provides CSI2 receiver calibration status.
+
+This control fills a `struct viif_csi2rx_cal_status` instance with current status.
+
+.. _V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS:
+
+V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS
+--------------------------------------------
+
+This control provides CSI2 receiver error description.
+
+This control fills a `struct viif_csi2rx_err_status` instance with accumerated error status.
+Note that internal accumerated status is cleared after reading.
+
+.. _V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS:
+
+V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS
+----------------------------------------------
+
+This control provides status information for the last captured frame.
+
+This control fills a `struct viif_l1_info` instance with current status.
+
+.. _V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS:
+
+V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS
+------------------------------------------
+
+This control provides error information since the last read of this control.
+
+This control fills a `struct viif_reported_errors` instance with accumerated error status.
+Note that internal accumerated status is cleared after reading.
+
+Structures
+==========
+
+.. kernel-doc:: include/uapi/linux/visconti_viif.h
+
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
index f9f73530a6be..2f0e4f955167 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
@@ -295,6 +295,10 @@ still cause this situation.
       - ``p_av1_film_grain``
       - A pointer to a struct :c:type:`v4l2_ctrl_av1_film_grain`. Valid if this control is
         of type ``V4L2_CTRL_TYPE_AV1_FILM_GRAIN``.
+    * - void *
+      - ``ptr``
+      - A pointer to Visconti ISP control specific structure. Valid if this control is
+        of type ``V4L2_CTRL_TYPE_VISCONTI_ISP``
     * - void *
       - ``ptr``
       - A pointer to a compound type which can be an N-dimensional array
diff --git a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
index 4d38acafe8e1..cd57fac8bbf9 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
@@ -549,6 +549,11 @@ See also the examples in :ref:`control`.
       - n/a
       - A struct :c:type:`v4l2_ctrl_av1_film_grain`, containing AV1 Film Grain
         parameters for stateless video decoders.
+    * - ``V4L2_CTRL_TYPE_VISCONTI_ISP``
+      - n/a
+      - n/a
+      - n/a
+      - Structs specific for Visconti ISP configuration controls.
 
 .. raw:: latex
 
-- 
2.34.1


