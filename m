Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BB27E7353
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345291AbjKIVEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345432AbjKIVET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:04:19 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AD94C02;
        Thu,  9 Nov 2023 13:03:57 -0800 (PST)
Received: from umang.jain (unknown [103.251.226.64])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 45C0117E1;
        Thu,  9 Nov 2023 22:03:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699563813;
        bh=vvjY/3+5X/Bu7WIIVIpITXXXTBylWdPZo0Po7C08w/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VTAQLDNa+QzwoR0AUhBMppyGPNUPjt+E7gELzZpdP1YO5JdiqBl8dnZetP57X6v6/
         VEdJLCkei6FEKi+y9QR9L+NvcZjqSIR1ZyaJvabw31VuAneAlLqiDETQqwcNl1FEbt
         q55cg9BYmqkKa7o1MiP+rq5Jc4Z6haT/S930PrOI=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 14/15] docs: admin-guide: media: bcm2835-isp: Add documentation for bcm2835-isp
Date:   Thu,  9 Nov 2023 16:03:06 -0500
Message-ID: <20231109210309.638594-15-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109210309.638594-1-umang.jain@ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naushir Patuck <naush@raspberrypi.com>

Document device nodes, frame buffer formats and initial set of
configuraiton that can be set from userspace to configure the pipeline.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../admin-guide/media/bcm2835-isp.rst         | 127 ++++++++++++++++++
 .../userspace-api/media/drivers/index.rst     |   1 +
 2 files changed, 128 insertions(+)
 create mode 100644 Documentation/admin-guide/media/bcm2835-isp.rst

diff --git a/Documentation/admin-guide/media/bcm2835-isp.rst b/Documentation/admin-guide/media/bcm2835-isp.rst
new file mode 100644
index 000000000000..e1c19f78435e
--- /dev/null
+++ b/Documentation/admin-guide/media/bcm2835-isp.rst
@@ -0,0 +1,127 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+BCM2835 ISP Driver
+==================
+
+Introduction
+------------
+
+The BCM2835 Image Sensor Pipeline (ISP) is a fixed function hardware pipeline
+for performing image processing operations.  Images are fed to the input
+of the ISP through memory frame buffers.  These images may be in various YUV,
+RGB, or Bayer formats.  A typical use case would have Bayer images obtained from
+an image sensor by the BCM2835 Unicam peripheral, written to a memory
+frame buffer, and finally fed into the input of the ISP.  Two concurrent output
+images may be generated in YUV or RGB format at different resolutions.
+Statistics output is also generated for Bayer input images.
+
+The bcm2835-isp driver exposes the following media pads as V4L2 device nodes:
+
+.. tabularcolumns:: |l|l|l|l|
+
+.. cssclass: longtable
+
+.. flat-table::
+
+    * - *Pad*
+      - *Direction*
+      - *Purpose*
+      - *Formats*
+
+    * - "bcm2835-isp0-output0"
+      - sink
+      - Accepts Bayer, RGB or YUV format frame buffers as input to the ISP HW
+        pipeline.
+      - :ref:`RAW8 <V4L2-PIX-FMT-SRGGB8>`,
+        :ref:`RAW10P <V4L2-PIX-FMT-SRGGB10P>`,
+        :ref:`RAW12P <V4L2-PIX-FMT-SRGGB12P>`,
+        :ref:`RAW14P <V4L2-PIX-FMT-SRGGB14P>`,
+        :ref:`RAW16 <V4L2-PIX-FMT-SRGGB16>`,
+        :ref:`RGB24/BGR24 <V4L2-PIX-FMT-RGB24>`,
+        :ref:`YUYV <V4L2-PIX-FMT-YUYV>`,
+        :ref:`YVYU <V4L2-PIX-FMT-YVYU>`,
+        :ref:`UYVY <V4L2-PIX-FMT-UYVY>`,
+        :ref:`VYUY <V4L2-PIX-FMT-VYUY>`,
+        :ref:`YUV420/YVU420 <V4L2-PIX-FMT-YUV420>`
+
+    * - "bcm2835-isp0-capture1"
+      - source
+      - High resolution YUV or RGB processed output from the ISP.
+      - :ref:`RGB565 <V4L2-PIX-FMT-RGB565>`,
+        :ref:`RGB24/BGR24 <V4L2-PIX-FMT-RGB24>`,
+        :ref:`ABGR32 <V4L2-PIX-FMT-ABGR32>`,
+        :ref:`YUYV <V4L2-PIX-FMT-YUYV>`,
+        :ref:`YVYU <V4L2-PIX-FMT-YVYU>`,
+        :ref:`UYVY <V4L2-PIX-FMT-UYVY>`,
+        :ref:`VYUY <V4L2-PIX-FMT-VYUY>`.
+        :ref:`YUV420/YVU420 <V4L2-PIX-FMT-YUV420>`,
+        :ref:`NV12/NV21 <V4L2-PIX-FMT-NV12>`,
+
+    * - "bcm2835-isp0-capture2"
+      - source
+      - Low resolution YUV processed output from the ISP. The output of
+        this pad cannot have a resolution larger than the "bcm2835-isp0-capture1" pad in any dimension.
+      - :ref:`YUYV <V4L2-PIX-FMT-YUYV>`,
+        :ref:`YVYU <V4L2-PIX-FMT-YVYU>`,
+        :ref:`UYVY <V4L2-PIX-FMT-UYVY>`,
+        :ref:`VYUY <V4L2-PIX-FMT-VYUY>`.
+        :ref:`YUV420/YVU420 <V4L2-PIX-FMT-YUV420>`,
+        :ref:`NV12/NV21 <V4L2-PIX-FMT-NV12>`,
+
+    * - "bcm2835-isp0-capture1"
+      - source
+      - Image statistics calculated from the input image provided on the
+        "bcm2835-isp0-output0" pad.  Statistics are only available for Bayer
+        format input images.
+      - :ref:`v4l2-meta-fmt-bcm2835-isp-stats`.
+
+Pipeline Configuration
+----------------------
+
+The ISP pipeline can be configure through user-space by calling
+:ref:`VIDIOC_S_EXT_CTRLS <VIDIOC_G_EXT_CTRLS>` on the “bcm2835-isp0-output0”
+node with the appropriate parameters as shown in the table below.
+
+.. tabularcolumns:: |p{2cm}|p{5.0cm}|
+
+.. cssclass: longtable
+
+.. flat-table::
+
+    * - *id*
+      - *Parameter*
+
+    * - ``V4L2_CID_USER_BCM2835_ISP_CC_MATRIX``
+      - struct :c:type:`bcm2835_isp_custom_ccm`
+
+    * - ``V4L2_CID_USER_BCM2835_ISP_LENS_SHADING``
+      - struct :c:type:`bcm2835_isp_lens_shading`
+
+    * - ``V4L2_CID_USER_BCM2835_ISP_BLACK_LEVEL``
+      - struct :c:type:`bcm2835_isp_black_level`
+
+    * - ``V4L2_CID_USER_BCM2835_ISP_GEQ``
+      - struct :c:type:`bcm2835_isp_geq`
+
+    * - ``V4L2_CID_USER_BCM2835_ISP_GAMMA``
+      - struct :c:type:`bcm2835_isp_gamma`
+
+    * - ``V4L2_CID_USER_BCM2835_ISP_DENOISE``
+      - struct :c:type:`bcm2835_isp_denoise`
+
+    * - ``V4L2_CID_USER_BCM2835_ISP_SHARPEN``
+      - struct :c:type:`bcm2835_isp_sharpen`
+
+    * - ``V4L2_CID_USER_BCM2835_ISP_DPC``
+      - struct :c:type:`bcm2835_isp_dpc`
+
+++++++++++++++++++++++++
+Configuration Parameters
+++++++++++++++++++++++++
+
+.. kernel-doc:: include/uapi/linux/bcm2835-isp.h
+   :functions: bcm2835_isp_rational bcm2835_isp_ccm bcm2835_isp_custom_ccm
+                bcm2835_isp_gain_format bcm2835_isp_lens_shading
+                bcm2835_isp_black_level bcm2835_isp_geq bcm2835_isp_gamma
+                bcm2835_isp_denoise bcm2835_isp_sharpen
+                bcm2835_isp_dpc_mode bcm2835_isp_dpc
diff --git a/Documentation/userspace-api/media/drivers/index.rst b/Documentation/userspace-api/media/drivers/index.rst
index 1726f8ec86fa..05e20a4e1d53 100644
--- a/Documentation/userspace-api/media/drivers/index.rst
+++ b/Documentation/userspace-api/media/drivers/index.rst
@@ -33,6 +33,7 @@ For more details see the file COPYING in the source distribution of Linux.
 
 	aspeed-video
 	camera-sensor
+	bcm2835-isp
 	ccs
 	cx2341x-uapi
 	dw100
-- 
2.41.0

