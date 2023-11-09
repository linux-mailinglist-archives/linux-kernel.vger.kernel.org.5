Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE997E7349
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345322AbjKIVEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345210AbjKIVEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:04:04 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B1F47B0;
        Thu,  9 Nov 2023 13:03:48 -0800 (PST)
Received: from umang.jain (unknown [103.251.226.64])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 11DF2192B;
        Thu,  9 Nov 2023 22:03:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699563805;
        bh=uYPQ7hFQaREUX9+CG18uLKutd/zJSUltGrMFebeG5Dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mpK9XzlqRkK2sNW9YNs6uyqaQ3pPo051fz/gvUmLd67b4WjdFUvsVo+laR3qIKjHF
         zxjdkuW3LU4Y8s34cnfr7lFuCUb4WPyaL3rUDfD2RHCAx1wX5bP7l/6h+bBiownXDy
         lXuLz/hRDK7m0oYgTzHPra00ymoELFzN0ZUxIe90=
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
        David Plowman <david.plowman@raspberrypi.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 11/15] vc04_services: bcm2835-isp: Allow formats with different colour spaces
Date:   Thu,  9 Nov 2023 16:03:03 -0500
Message-ID: <20231109210309.638594-12-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109210309.638594-1-umang.jain@ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Plowman <david.plowman@raspberrypi.com>

Each supported format now includes a mask showing the allowed colour
spaces, as well as a default colour space for when one was not
specified.

Additionally we translate the colour space to mmal format and pass it
over to the VideoCore.

Signed-off-by: David Plowman <david.plowman@raspberrypi.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../bcm2835-isp/bcm2835-isp-fmts.h            | 180 ++++++++++++------
 .../bcm2835-isp/bcm2835-v4l2-isp.c            |  69 ++++++-
 2 files changed, 193 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h
index 6dcd196fc6a5..5c874cdd2fe7 100644
--- a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h
+++ b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h
@@ -21,10 +21,29 @@ struct bcm2835_isp_fmt {
 	int bytesperline_align;
 	u32 mmal_fmt;
 	int size_multiplier_x2;
-	enum v4l2_colorspace colorspace;
+	u32 colorspace_mask;
+	enum v4l2_colorspace colorspace_default;
 	unsigned int step_size;
 };
 
+#define V4L2_COLORSPACE_MASK(colorspace) BIT(colorspace)
+
+#define V4L2_COLORSPACE_MASK_JPEG V4L2_COLORSPACE_MASK(V4L2_COLORSPACE_JPEG)
+#define V4L2_COLORSPACE_MASK_SMPTE170M V4L2_COLORSPACE_MASK(V4L2_COLORSPACE_SMPTE170M)
+#define V4L2_COLORSPACE_MASK_REC709 V4L2_COLORSPACE_MASK(V4L2_COLORSPACE_REC709)
+#define V4L2_COLORSPACE_MASK_SRGB V4L2_COLORSPACE_MASK(V4L2_COLORSPACE_SRGB)
+#define V4L2_COLORSPACE_MASK_RAW V4L2_COLORSPACE_MASK(V4L2_COLORSPACE_RAW)
+
+/*
+ * The colour spaces we support for YUV outputs. SRGB features here because,
+ * once you assign the default transfer func and so on, it and JPEG effectively
+ * mean the same.
+ */
+#define V4L2_COLORSPACE_MASK_YUV (V4L2_COLORSPACE_MASK_JPEG | \
+				  V4L2_COLORSPACE_MASK_SRGB | \
+				  V4L2_COLORSPACE_MASK_SMPTE170M | \
+				  V4L2_COLORSPACE_MASK_REC709)
+
 static const struct bcm2835_isp_fmt supported_formats[] = {
 	{
 		/* YUV formats */
@@ -33,7 +52,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_I420,
 		.size_multiplier_x2 = 3,
-		.colorspace	    = V4L2_COLORSPACE_SMPTE170M,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_default = V4L2_COLORSPACE_JPEG,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_YVU420,
@@ -41,7 +61,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_YV12,
 		.size_multiplier_x2 = 3,
-		.colorspace	    = V4L2_COLORSPACE_SMPTE170M,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_NV12,
@@ -49,7 +70,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_NV12,
 		.size_multiplier_x2 = 3,
-		.colorspace	    = V4L2_COLORSPACE_SMPTE170M,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_NV21,
@@ -57,7 +79,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_NV21,
 		.size_multiplier_x2 = 3,
-		.colorspace	    = V4L2_COLORSPACE_SMPTE170M,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_YUYV,
@@ -65,7 +88,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_YUYV,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_SMPTE170M,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_UYVY,
@@ -73,7 +97,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_UYVY,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_SMPTE170M,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_YVYU,
@@ -81,7 +106,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_YVYU,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_SMPTE170M,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_VYUY,
@@ -89,7 +115,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_VYUY,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_SMPTE170M,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
 		/* RGB formats */
@@ -98,7 +125,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_RGB24,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_RGB565,
@@ -106,7 +134,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_RGB16,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_BGR24,
@@ -114,7 +143,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BGR24,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_XBGR32,
@@ -122,7 +152,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_BGRA,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_RGBX32,
@@ -130,7 +161,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_RGBA,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
 		/* Bayer formats */
@@ -140,7 +172,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SRGGB8,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SBGGR8,
@@ -148,7 +181,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SBGGR8,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGRBG8,
@@ -156,7 +190,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGRBG8,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGBRG8,
@@ -164,7 +199,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGBRG8,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* 10 bit */
@@ -173,7 +209,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SRGGB10P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SBGGR10P,
@@ -181,7 +218,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SBGGR10P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGRBG10P,
@@ -189,7 +227,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGRBG10P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGBRG10P,
@@ -197,7 +236,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGBRG10P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* 12 bit */
@@ -206,7 +246,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SRGGB12P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SBGGR12P,
@@ -214,7 +255,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SBGGR12P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGRBG12P,
@@ -222,7 +264,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGRBG12P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGBRG12P,
@@ -230,7 +273,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGBRG12P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* 14 bit */
@@ -239,7 +283,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SRGGB14P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SBGGR14P,
@@ -247,7 +292,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SBGGR14P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGRBG14P,
@@ -255,7 +301,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGRBG14P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGBRG14P,
@@ -263,7 +310,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGBRG14P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* 16 bit */
@@ -272,7 +320,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SRGGB16,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SBGGR16,
@@ -280,7 +329,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SBGGR16,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGRBG16,
@@ -288,7 +338,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGRBG16,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGBRG16,
@@ -296,7 +347,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGBRG16,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* Bayer formats unpacked to 16bpp */
@@ -306,7 +358,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SRGGB10,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SBGGR10,
@@ -314,7 +367,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SBGGR10,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGRBG10,
@@ -322,7 +376,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGRBG10,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGBRG10,
@@ -330,7 +385,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGBRG10,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* 12 bit */
@@ -339,7 +395,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SRGGB12,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SBGGR12,
@@ -347,7 +404,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SBGGR12,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGRBG12,
@@ -355,7 +413,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGRBG12,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGBRG12,
@@ -363,7 +422,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGBRG12,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* 14 bit */
@@ -372,7 +432,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SRGGB14,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SBGGR14,
@@ -380,7 +441,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SBGGR14,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGRBG14,
@@ -388,7 +450,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGRBG14,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_PIX_FMT_SGBRG14,
@@ -396,7 +459,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BAYER_SGBRG14,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* Monochrome MIPI formats */
@@ -406,7 +470,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_GREY,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* 10 bit */
@@ -415,7 +480,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_Y10P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* 12 bit */
@@ -424,7 +490,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_Y12P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* 14 bit */
@@ -433,7 +500,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_Y14P,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* 16 bit */
@@ -442,7 +510,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_Y16,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* 10 bit as 16bpp */
@@ -451,7 +520,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_Y10,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* 12 bit as 16bpp */
@@ -460,7 +530,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_Y12,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		/* 14 bit as 16bpp */
@@ -469,7 +540,8 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_Y14,
 		.size_multiplier_x2 = 2,
-		.colorspace	    = V4L2_COLORSPACE_RAW,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_RAW,
+		.colorspace_default = V4L2_COLORSPACE_RAW,
 		.step_size	    = 2,
 	}, {
 		.fourcc		    = V4L2_META_FMT_BCM2835_ISP_STATS,
diff --git a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
index f1ea56b4849e..b6ac1ee8f9f3 100644
--- a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
+++ b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
@@ -74,6 +74,7 @@ struct bcm2835_isp_q_data {
 	unsigned int width;
 	unsigned int height;
 	unsigned int sizeimage;
+	enum v4l2_colorspace colorspace;
 	const struct bcm2835_isp_fmt *fmt;
 };
 
@@ -313,6 +314,43 @@ static void mmal_buffer_cb(struct vchiq_mmal_instance *instance,
 		complete(&dev->frame_cmplt);
 }
 
+struct colorspace_translation {
+	enum v4l2_colorspace v4l2_value;
+	u32 mmal_value;
+};
+
+static u32 translate_color_space(enum v4l2_colorspace color_space)
+{
+	static const struct colorspace_translation translations[] = {
+		{ V4L2_COLORSPACE_DEFAULT, MMAL_COLOR_SPACE_UNKNOWN },
+		{ V4L2_COLORSPACE_SMPTE170M, MMAL_COLOR_SPACE_ITUR_BT601 },
+		{ V4L2_COLORSPACE_SMPTE240M, MMAL_COLOR_SPACE_SMPTE240M },
+		{ V4L2_COLORSPACE_REC709, MMAL_COLOR_SPACE_ITUR_BT709 },
+		/* V4L2_COLORSPACE_BT878 unavailable */
+		{ V4L2_COLORSPACE_470_SYSTEM_M, MMAL_COLOR_SPACE_BT470_2_M },
+		{ V4L2_COLORSPACE_470_SYSTEM_BG, MMAL_COLOR_SPACE_BT470_2_BG },
+		{ V4L2_COLORSPACE_JPEG, MMAL_COLOR_SPACE_JPEG_JFIF },
+		/*
+		 * We don't have an encoding for SRGB as such, but VideoCore
+		 * will do the right thing if it gets "unknown".
+		 */
+		{ V4L2_COLORSPACE_SRGB, MMAL_COLOR_SPACE_UNKNOWN },
+		/* V4L2_COLORSPACE_OPRGB unavailable */
+		/* V4L2_COLORSPACE_BT2020 unavailable */
+		/* V4L2_COLORSPACE_RAW unavailable */
+		/* V4L2_COLORSPACE_DCI_P3 unavailable */
+	};
+
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(translations); i++) {
+		if (color_space == translations[i].v4l2_value)
+			return translations[i].mmal_value;
+	}
+
+	return MMAL_COLOR_SPACE_UNKNOWN;
+}
+
 static void setup_mmal_port_format(struct bcm2835_isp_node *node,
 				   struct vchiq_mmal_port *port)
 {
@@ -326,6 +364,7 @@ static void setup_mmal_port_format(struct bcm2835_isp_node *node,
 	port->es.video.crop.height = q_data->height;
 	port->es.video.crop.x = 0;
 	port->es.video.crop.y = 0;
+	port->es.video.color_space = translate_color_space(q_data->colorspace);
 };
 
 static int setup_mmal_port(struct bcm2835_isp_node *node)
@@ -834,6 +873,9 @@ static int populate_qdata_fmt(struct v4l2_format *f,
 		/* All parameters should have been set correctly by try_fmt */
 		q_data->bytesperline = f->fmt.pix.bytesperline;
 		q_data->sizeimage = f->fmt.pix.sizeimage;
+
+		/* We must indicate which of the allowed colour spaces we have. */
+		q_data->colorspace = f->fmt.pix.colorspace;
 	} else {
 		v4l2_dbg(1, debug, &dev->v4l2_dev,
 			 "%s: Setting meta format for fmt: %08x, size %u\n",
@@ -845,6 +887,9 @@ static int populate_qdata_fmt(struct v4l2_format *f,
 		q_data->height = 0;
 		q_data->bytesperline = 0;
 		q_data->sizeimage = f->fmt.meta.buffersize;
+
+		/* This won't mean anything for metadata, but may as well fill it in. */
+		q_data->colorspace = V4L2_COLORSPACE_DEFAULT;
 	}
 
 	v4l2_dbg(1, debug, &dev->v4l2_dev,
@@ -908,7 +953,7 @@ static int bcm2835_isp_node_g_fmt(struct file *file, void *priv,
 		f->fmt.pix.pixelformat = q_data->fmt->fourcc;
 		f->fmt.pix.bytesperline = q_data->bytesperline;
 		f->fmt.pix.sizeimage = q_data->sizeimage;
-		f->fmt.pix.colorspace = q_data->fmt->colorspace;
+		f->fmt.pix.colorspace = q_data->colorspace;
 	}
 
 	return 0;
@@ -975,13 +1020,32 @@ static int bcm2835_isp_node_try_fmt(struct file *file, void *priv,
 		fmt = get_default_format(node);
 
 	if (!node_is_stats(node)) {
+		int is_rgb;
+
 		f->fmt.pix.width = max(min(f->fmt.pix.width, MAX_DIM),
 				       MIN_DIM);
 		f->fmt.pix.height = max(min(f->fmt.pix.height, MAX_DIM),
 					MIN_DIM);
 
 		f->fmt.pix.pixelformat = fmt->fourcc;
-		f->fmt.pix.colorspace = fmt->colorspace;
+
+		/*
+		 * Fill in the actual colour space when the requested one was
+		 * not supported. This also catches the case when the "default"
+		 * colour space was requested (as that's never in the mask).
+		 */
+		if (!(V4L2_COLORSPACE_MASK(f->fmt.pix.colorspace) & fmt->colorspace_mask))
+			f->fmt.pix.colorspace = fmt->colorspace_default;
+		/* In all cases, we only support the defaults for these: */
+		f->fmt.pix.ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(f->fmt.pix.colorspace);
+		f->fmt.pix.xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(f->fmt.pix.colorspace);
+		/* RAW counts as sRGB here so that we get full range. */
+		is_rgb = f->fmt.pix.colorspace == V4L2_COLORSPACE_SRGB ||
+			f->fmt.pix.colorspace == V4L2_COLORSPACE_RAW;
+		f->fmt.pix.quantization =
+			V4L2_MAP_QUANTIZATION_DEFAULT(is_rgb, f->fmt.pix.colorspace,
+						      f->fmt.pix.ycbcr_enc);
+
 		f->fmt.pix.bytesperline = get_bytesperline(f->fmt.pix.width,
 							   fmt);
 		f->fmt.pix.field = V4L2_FIELD_NONE;
@@ -1307,6 +1371,7 @@ static int register_node(struct bcm2835_isp_dev *dev,
 					       node->q_data.width,
 					       node->q_data.height,
 					       node->q_data.fmt);
+	node->q_data.colorspace = node->q_data.fmt->colorspace_default;
 
 	queue->io_modes = VB2_MMAP | VB2_DMABUF;
 	queue->drv_priv = node;
-- 
2.41.0

