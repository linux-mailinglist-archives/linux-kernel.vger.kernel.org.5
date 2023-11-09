Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711AB7E734C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbjKIVEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345281AbjKIVEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:04:08 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB8349C9;
        Thu,  9 Nov 2023 13:03:51 -0800 (PST)
Received: from umang.jain (unknown [103.251.226.64])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C66576EF;
        Thu,  9 Nov 2023 22:03:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699563808;
        bh=sTZwjAPZQBasibelnMmyXY/yI6VlmvAZneMtzwqTaxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EL37U8T9Nfm5C9Y/keayN8Tu1S23YpGln4X/CzuubejzVZs7RziSupsCOLSAjcWlW
         EC7PXjdmHHwiDURADP76eacFnbHMeTPSe39CcLwWcaAQeUiC5CAx4ZSwUE8hXXB9T/
         +HCsRAcNN+66soZueNo+R5SiVxfOSszdJcEweGx4=
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
Subject: [PATCH v2 12/15] vc04_services: bcm2835-isp: Permit all sRGB colour spaces on ISP outputs
Date:   Thu,  9 Nov 2023 16:03:04 -0500
Message-ID: <20231109210309.638594-13-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109210309.638594-1-umang.jain@ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Plowman <david.plowman@raspberrypi.com>

bcm2835-isp outputs actually support all colour spaces that are
fundamentally sRGB underneath, regardless of whether an RGB or YUV output
format is actually requested.

Signed-off-by: David Plowman <david.plowman@raspberrypi.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../bcm2835-isp/bcm2835-isp-fmts.h            | 45 ++++++++++---------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h
index 5c874cdd2fe7..30c14a44f399 100644
--- a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h
+++ b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h
@@ -35,14 +35,19 @@ struct bcm2835_isp_fmt {
 #define V4L2_COLORSPACE_MASK_RAW V4L2_COLORSPACE_MASK(V4L2_COLORSPACE_RAW)
 
 /*
- * The colour spaces we support for YUV outputs. SRGB features here because,
- * once you assign the default transfer func and so on, it and JPEG effectively
- * mean the same.
+ * All three colour spaces JPEG, SMPTE170M and REC709 are fundamentally sRGB
+ * underneath (as near as makes no difference to us), just with different YCbCr
+ * encodings. Therefore the ISP can generate sRGB on its main output and any of
+ * the others on its low resolution output. Applications should, when using both
+ * outputs, program the colour spaces on them to be the same, matching whatever
+ * is requested for the low resolution output, even if the main output is
+ * producing an RGB format. In turn this requires us to allow all these colour
+ * spaces for every YUV/RGB output format.
  */
-#define V4L2_COLORSPACE_MASK_YUV (V4L2_COLORSPACE_MASK_JPEG | \
-				  V4L2_COLORSPACE_MASK_SRGB | \
-				  V4L2_COLORSPACE_MASK_SMPTE170M | \
-				  V4L2_COLORSPACE_MASK_REC709)
+#define V4L2_COLORSPACE_MASK_ALL_SRGB (V4L2_COLORSPACE_MASK_JPEG |	\
+				       V4L2_COLORSPACE_MASK_SRGB |	\
+				       V4L2_COLORSPACE_MASK_SMPTE170M |	\
+				       V4L2_COLORSPACE_MASK_REC709)
 
 static const struct bcm2835_isp_fmt supported_formats[] = {
 	{
@@ -52,7 +57,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_I420,
 		.size_multiplier_x2 = 3,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_JPEG,
 		.step_size	    = 2,
 	}, {
@@ -61,7 +66,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_YV12,
 		.size_multiplier_x2 = 3,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
@@ -70,7 +75,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_NV12,
 		.size_multiplier_x2 = 3,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
@@ -79,7 +84,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_NV21,
 		.size_multiplier_x2 = 3,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
@@ -88,7 +93,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_YUYV,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
@@ -97,7 +102,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_UYVY,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
@@ -106,7 +111,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_YVYU,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
@@ -115,7 +120,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_VYUY,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_YUV,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SMPTE170M,
 		.step_size	    = 2,
 	}, {
@@ -125,7 +130,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_RGB24,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
@@ -134,7 +139,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_RGB16,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
@@ -143,7 +148,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 32,
 		.mmal_fmt	    = MMAL_ENCODING_BGR24,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
@@ -152,7 +157,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_BGRA,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
@@ -161,7 +166,7 @@ static const struct bcm2835_isp_fmt supported_formats[] = {
 		.bytesperline_align = 64,
 		.mmal_fmt	    = MMAL_ENCODING_RGBA,
 		.size_multiplier_x2 = 2,
-		.colorspace_mask    = V4L2_COLORSPACE_MASK_SRGB,
+		.colorspace_mask    = V4L2_COLORSPACE_MASK_ALL_SRGB,
 		.colorspace_default = V4L2_COLORSPACE_SRGB,
 		.step_size	    = 1,
 	}, {
-- 
2.41.0

