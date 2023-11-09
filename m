Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9C07E733C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345356AbjKIVDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjKIVDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:03:40 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42FB44A4;
        Thu,  9 Nov 2023 13:03:37 -0800 (PST)
Received: from umang.jain (unknown [103.251.226.64])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0A004124F;
        Thu,  9 Nov 2023 22:03:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699563794;
        bh=Mh31DkmOj8nOlnWumZDplffgxl2AVkvRhZuE0/1Yjnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HM8Gwce6FhFbVLbWEjKZfsRdfd/2tifTiwj8W/p6UfnlhLmh0aT5lAq32lxodjmg6
         CnwK1LGSttYgkMJDRQHzMMAgqW8+WEmUPWmpXzOT0UOREtFL6k1fgFYPrS1+qQ6uYE
         JEJLbM1x+dYVOTaiIK8TE5J5+PXVxDZ6aP35p8Mc=
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
Subject: [PATCH v2 07/15] media: uapi: v4l2-core: Add ISP statistics output V4L2 fourcc type
Date:   Thu,  9 Nov 2023 16:02:59 -0500
Message-ID: <20231109210309.638594-8-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109210309.638594-1-umang.jain@ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naushir Patuck <naush@raspberrypi.com>

Add V4L2_META_FMT_BCM2835_ISP_STATS V4L2 format type.

This new format will be used by the bcm2835-isp device to return
out ISP statistics for 3A.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../userspace-api/media/v4l/meta-formats.rst  |  1 +
 .../v4l/pixfmt-meta-bcm2835-isp-stats.rst     | 32 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
 include/uapi/linux/videodev2.h                |  1 +
 4 files changed, 35 insertions(+)
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-meta-bcm2835-isp-stats.rst

diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
index 919f595576b9..534542f235bc 100644
--- a/Documentation/userspace-api/media/v4l/meta-formats.rst
+++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
@@ -12,6 +12,7 @@ These formats are used for the :ref:`metadata` interface only.
 .. toctree::
     :maxdepth: 1
 
+    pixfmt-meta-bcm2835-isp-stats
     metafmt-d4xx
     metafmt-intel-ipu3
     metafmt-rkisp1
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-bcm2835-isp-stats.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-bcm2835-isp-stats.rst
new file mode 100644
index 000000000000..2219235e0ecb
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/pixfmt-meta-bcm2835-isp-stats.rst
@@ -0,0 +1,32 @@
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
+.. _v4l2-meta-fmt-bcm2835-isp-stats:
+
++*****************************************
+V4L2_META_FMT_BCM2835_ISP_STATS  ('BSTA')
+*****************************************
+
+BCM2835 ISP Statistics
+
+Description
+===========
+
+The BCM2835 ISP hardware calculate image statistics for an input Bayer frame.
+These statistics are obtained from the "bcm2835-isp0-capture3" device node
+using the :c:type:`v4l2_meta_format` interface. They are formatted as described
+by the :c:type:`bcm2835_isp_stats` structure below.
+
+.. code-block:: c
+
+       #define DEFAULT_AWB_REGIONS_X 16
+       #define DEFAULT_AWB_REGIONS_Y 12
+
+       #define NUM_HISTOGRAMS 2
+       #define NUM_HISTOGRAM_BINS 128
+       #define AWB_REGIONS (DEFAULT_AWB_REGIONS_X * DEFAULT_AWB_REGIONS_Y)
+       #define FLOATING_REGIONS 16
+       #define AGC_REGIONS 16
+       #define FOCUS_REGIONS 12
+
+.. kernel-doc:: include/uapi/linux/bcm2835-isp.h
+   :functions: bcm2835_isp_stats_hist bcm2835_isp_stats_region
+                    bcm2835_isp_stats_focus bcm2835_isp_stats
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 7f29886568b8..6f0f0f6526c9 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1463,6 +1463,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_GENERIC_CSI2_20:	descr = "8b Generic Meta, 20b CSI-2"; break;
 	case V4L2_META_FMT_GENERIC_CSI2_24:	descr = "8b Generic Meta, 24b CSI-2"; break;
 	case V4L2_META_FMT_GENERIC_CSI2_2_24:	descr = "2x8b Generic Meta, 24b CSI-2"; break;
+	case V4L2_META_FMT_BCM2835_ISP_STATS: descr = "BCM2835 ISP Image Statistics"; break;
 
 	default:
 		/* Compressed formats */
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 85b60199c618..eddaea8598db 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -836,6 +836,7 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_UVC         v4l2_fourcc('U', 'V', 'C', 'H') /* UVC Payload Header metadata */
 #define V4L2_META_FMT_D4XX        v4l2_fourcc('D', '4', 'X', 'X') /* D4XX Payload Header metadata */
 #define V4L2_META_FMT_VIVID	  v4l2_fourcc('V', 'I', 'V', 'D') /* Vivid Metadata */
+#define V4L2_META_FMT_BCM2835_ISP_STATS v4l2_fourcc('B', 'S', 'T', 'A') /* BCM2835 ISP image statistics output */
 
 /* Vendor specific - used for RK_ISP1 camera sub-system */
 #define V4L2_META_FMT_RK_ISP1_PARAMS	v4l2_fourcc('R', 'K', '1', 'P') /* Rockchip ISP1 3A Parameters */
-- 
2.41.0

