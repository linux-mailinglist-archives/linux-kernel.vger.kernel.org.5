Return-Path: <linux-kernel+bounces-95401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 752FB874D3C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF91285A2C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170091292F8;
	Thu,  7 Mar 2024 11:18:35 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FED88529C;
	Thu,  7 Mar 2024 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810313; cv=none; b=eb91Qq8QThDTuvPAXF8/ge85EvrvpVs6VUOthGaAYB1Gp+oXnmBqJ1pFOa4EPJiNz4XLqMEO1SXa7lzvnnggyIuTKepraiQd6KFNgNwuC5rzpa04pxORqUWak6acR3Y9THT7xQnEQ+LRlyW3nRKuk4M3xjc1VkbqoengVq3Zcy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810313; c=relaxed/simple;
	bh=tW2cj51zm+X0EkL/9ymA6cqw8VzH1mJwGqNvymaEzVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2yhIVb03AI/FHAJJhq/3M4awFQqMN5PK99pM25qYMfV6rpx1IjpiTngg93y7BMpOFu+QdUjYcf9iE4zHtTpnfApjLBPd1rzEvN1/scl4BFpmLpRtt5KYhqcpb++6FD4v1Za1hjEDc0hVADgyGHBIUu2/P8kjFIVbS0ZcTwYuuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from mgb4.digiteq.red (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id CF0D84CB43;
	Thu,  7 Mar 2024 12:18:23 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v2 2/2] media: mgb4: Add support for V4L2_CAP_TIMEPERFRAME
Date: Thu,  7 Mar 2024 13:18:22 +0100
Message-ID: <20240307121822.1852-3-tumic@gpxsee.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307121822.1852-1-tumic@gpxsee.org>
References: <20240307121822.1852-1-tumic@gpxsee.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Recent mgb4 firmwares have support for setting a variable framerate independent
of the signal framerate. Add/fix (the mgb4 driver already did promote
V4L2_CAP_TIMEPERFRAME, but it didn't work) support for V4L2_CAP_TIMEPERFRAME to
the driver to enable this feature.

Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
---
 Documentation/admin-guide/media/mgb4.rst |   8 +-
 drivers/media/pci/mgb4/mgb4_core.c       |   2 +-
 drivers/media/pci/mgb4/mgb4_core.h       |   2 +
 drivers/media/pci/mgb4/mgb4_io.h         |  23 ++-
 drivers/media/pci/mgb4/mgb4_sysfs_out.c  |   9 +-
 drivers/media/pci/mgb4/mgb4_vin.c        |  89 +++++++---
 drivers/media/pci/mgb4/mgb4_vin.h        |   3 +-
 drivers/media/pci/mgb4/mgb4_vout.c       | 206 +++++++++++++++++++++--
 drivers/media/pci/mgb4/mgb4_vout.h       |   5 +-
 9 files changed, 302 insertions(+), 45 deletions(-)

diff --git a/Documentation/admin-guide/media/mgb4.rst b/Documentation/admin-guide/media/mgb4.rst
index 2977f74d7e26..044c2cc174a8 100644
--- a/Documentation/admin-guide/media/mgb4.rst
+++ b/Documentation/admin-guide/media/mgb4.rst
@@ -228,8 +228,12 @@ Common FPDL3/GMSL output parameters
     open.*
 
 **frame_rate** (RW):
-    Output video frame rate in frames per second. The default frame rate is
-    60Hz.
+    Output video signal frame rate limit. Due to the limited output pixel clock
+    steps, the card can not always generate a frame rate perfectly matching
+    the value required by the connected display. Using this parameter one can
+    limit the frame rate by "crippling" the signal so that the lines are not
+    equal but the signal appears like having the exact frame rate to
+    the connected display. The default frame rate limit value is 60Hz.
 
 **hsync_polarity** (RW):
     HSYNC signal polarity.
diff --git a/drivers/media/pci/mgb4/mgb4_core.c b/drivers/media/pci/mgb4/mgb4_core.c
index 5bfb8a06202e..9c6294009069 100644
--- a/drivers/media/pci/mgb4/mgb4_core.c
+++ b/drivers/media/pci/mgb4/mgb4_core.c
@@ -302,7 +302,7 @@ static int init_i2c(struct mgb4_dev *mgbdev)
 	/* create dummy clock required by the xiic-i2c adapter */
 	snprintf(clk_name, sizeof(clk_name), "xiic-i2c.%d", id);
 	mgbdev->i2c_clk = clk_hw_register_fixed_rate(NULL, clk_name, NULL,
-						     0, 125000000);
+						     0, MGB4_HW_FREQ);
 	if (IS_ERR(mgbdev->i2c_clk)) {
 		dev_err(dev, "failed to register I2C clock\n");
 		return PTR_ERR(mgbdev->i2c_clk);
diff --git a/drivers/media/pci/mgb4/mgb4_core.h b/drivers/media/pci/mgb4/mgb4_core.h
index 2a946e46aec1..b52cd67270b5 100644
--- a/drivers/media/pci/mgb4/mgb4_core.h
+++ b/drivers/media/pci/mgb4/mgb4_core.h
@@ -13,6 +13,8 @@
 #include <linux/dmaengine.h>
 #include "mgb4_regs.h"
 
+#define MGB4_HW_FREQ 125000000
+
 #define MGB4_VIN_DEVICES  2
 #define MGB4_VOUT_DEVICES 2
 
diff --git a/drivers/media/pci/mgb4/mgb4_io.h b/drivers/media/pci/mgb4/mgb4_io.h
index 204613a6685c..c921f011140b 100644
--- a/drivers/media/pci/mgb4/mgb4_io.h
+++ b/drivers/media/pci/mgb4/mgb4_io.h
@@ -8,10 +8,7 @@
 #define __MGB4_IO_H__
 
 #include <media/v4l2-dev.h>
-
-#define MGB4_DEFAULT_WIDTH     1280
-#define MGB4_DEFAULT_HEIGHT    640
-#define MGB4_DEFAULT_PERIOD    (125000000 / 60)
+#include "mgb4_core.h"
 
 /* Register access error indication */
 #define MGB4_ERR_NO_REG        0xFFFFFFFE
@@ -20,6 +17,9 @@
 #define MGB4_ERR_QUEUE_EMPTY   0xFFFFFFFC
 #define MGB4_ERR_QUEUE_FULL    0xFFFFFFFB
 
+#define MGB4_PERIOD(numerator, denominator) \
+	((u32)((MGB4_HW_FREQ * (u64)(numerator)) / (u64)(denominator)))
+
 struct mgb4_frame_buffer {
 	struct vb2_v4l2_buffer vb;
 	struct list_head list;
@@ -30,11 +30,24 @@ static inline struct mgb4_frame_buffer *to_frame_buffer(struct vb2_v4l2_buffer *
 	return container_of(vbuf, struct mgb4_frame_buffer, vb);
 }
 
-static inline bool has_yuv(struct mgb4_regs *video)
+static inline bool has_yuv_and_timeperframe(struct mgb4_regs *video)
 {
 	u32 status = mgb4_read_reg(video, 0xD0);
 
 	return (status & (1U << 8));
 }
 
+#define has_yuv(video) has_yuv_and_timeperframe(video)
+#define has_timeperframe(video) has_yuv_and_timeperframe(video)
+
+static inline u32 pixel_size(struct v4l2_dv_timings *timings)
+{
+	struct v4l2_bt_timings *bt = &timings->bt;
+
+	u32 height = bt->height + bt->vfrontporch + bt->vsync + bt->vbackporch;
+	u32 width = bt->width + bt->hfrontporch + bt->hsync + bt->hbackporch;
+
+	return width * height;
+}
+
 #endif
diff --git a/drivers/media/pci/mgb4/mgb4_sysfs_out.c b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
index 9f6e81c57726..5b4ed504d3c7 100644
--- a/drivers/media/pci/mgb4/mgb4_sysfs_out.c
+++ b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
@@ -229,9 +229,12 @@ static ssize_t frame_rate_show(struct device *dev,
 	struct video_device *vdev = to_video_device(dev);
 	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
 	u32 period = mgb4_read_reg(&voutdev->mgbdev->video,
-				   voutdev->config->regs.frame_period);
+				   voutdev->config->regs.frame_limit);
 
-	return sprintf(buf, "%u\n", 125000000 / period);
+	if (!period)
+		return -EIO;
+
+	return sprintf(buf, "%u\n", MGB4_HW_FREQ / period);
 }
 
 /*
@@ -252,7 +255,7 @@ static ssize_t frame_rate_store(struct device *dev,
 		return ret;
 
 	mgb4_write_reg(&voutdev->mgbdev->video,
-		       voutdev->config->regs.frame_period, 125000000 / val);
+		       voutdev->config->regs.frame_limit, MGB4_HW_FREQ / val);
 
 	return count;
 }
diff --git a/drivers/media/pci/mgb4/mgb4_vin.c b/drivers/media/pci/mgb4/mgb4_vin.c
index 19692e4dfb59..560c94d21924 100644
--- a/drivers/media/pci/mgb4/mgb4_vin.c
+++ b/drivers/media/pci/mgb4/mgb4_vin.c
@@ -34,8 +34,8 @@ ATTRIBUTE_GROUPS(mgb4_fpdl3_in);
 ATTRIBUTE_GROUPS(mgb4_gmsl_in);
 
 static const struct mgb4_vin_config vin_cfg[] = {
-	{0, 0, 0, 6, {0x10, 0x00, 0x04, 0x08, 0x1C, 0x14, 0x18, 0x20, 0x24, 0x28}},
-	{1, 1, 1, 7, {0x40, 0x30, 0x34, 0x38, 0x4C, 0x44, 0x48, 0x50, 0x54, 0x58}}
+	{0, 0, 0, 6, {0x10, 0x00, 0x04, 0x08, 0x1C, 0x14, 0x18, 0x20, 0x24, 0x28, 0xE8}},
+	{1, 1, 1, 7, {0x40, 0x30, 0x34, 0x38, 0x4C, 0x44, 0x48, 0x50, 0x54, 0x58, 0xEC}}
 };
 
 static const struct i2c_board_info fpdl3_deser_info[] = {
@@ -387,6 +387,7 @@ static int vidioc_enum_frameintervals(struct file *file, void *priv,
 {
 	struct mgb4_vin_dev *vindev = video_drvdata(file);
 	struct mgb4_regs *video = &vindev->mgbdev->video;
+	struct v4l2_dv_timings timings;
 
 	if (ival->index != 0)
 		return -EINVAL;
@@ -397,12 +398,15 @@ static int vidioc_enum_frameintervals(struct file *file, void *priv,
 	    ival->height != vindev->timings.bt.height)
 		return -EINVAL;
 
-	ival->type = V4L2_FRMIVAL_TYPE_CONTINUOUS;
-	ival->stepwise.min.denominator = 60;
-	ival->stepwise.min.numerator = 1;
-	ival->stepwise.max.denominator = 1;
-	ival->stepwise.max.numerator = 1;
-	ival->stepwise.step = ival->stepwise.max;
+	get_timings(vindev, &timings);
+
+	ival->type = V4L2_FRMIVAL_TYPE_STEPWISE;
+	ival->stepwise.max.denominator = MGB4_HW_FREQ;
+	ival->stepwise.max.numerator = 0xFFFFFFFF;
+	ival->stepwise.min.denominator = timings.bt.pixelclock;
+	ival->stepwise.min.numerator = pixel_size(&timings);
+	ival->stepwise.step.denominator = MGB4_HW_FREQ;
+	ival->stepwise.step.numerator = 1;
 
 	return 0;
 }
@@ -570,27 +574,66 @@ static int vidioc_g_input(struct file *file, void *priv, unsigned int *i)
 	return 0;
 }
 
-static int vidioc_parm(struct file *file, void *priv,
-		       struct v4l2_streamparm *parm)
+static int vidioc_g_parm(struct file *file, void *priv,
+			 struct v4l2_streamparm *parm)
 {
 	struct mgb4_vin_dev *vindev = video_drvdata(file);
 	struct mgb4_regs *video = &vindev->mgbdev->video;
-	const struct mgb4_vin_regs *regs = &vindev->config->regs;
-	struct v4l2_fract timeperframe = {
-		.numerator = mgb4_read_reg(video, regs->frame_period),
-		.denominator = 125000000,
-	};
+	struct v4l2_fract *tpf = &parm->parm.output.timeperframe;
+	struct v4l2_dv_timings timings;
+	u32 timer;
 
 	if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 		return -EINVAL;
 
 	parm->parm.capture.readbuffers = 2;
-	parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
-	parm->parm.capture.timeperframe = timeperframe;
+
+	if (has_timeperframe(video)) {
+		timer = mgb4_read_reg(video, vindev->config->regs.timer);
+		if (timer < 0xFFFF) {
+			get_timings(vindev, &timings);
+			tpf->numerator = pixel_size(&timings);
+			tpf->denominator = timings.bt.pixelclock;
+		} else {
+			tpf->numerator = timer;
+			tpf->denominator = MGB4_HW_FREQ;
+		}
+
+		parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+	}
 
 	return 0;
 }
 
+static int vidioc_s_parm(struct file *file, void *priv,
+			 struct v4l2_streamparm *parm)
+{
+	struct mgb4_vin_dev *vindev = video_drvdata(file);
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+	struct v4l2_fract *tpf = &parm->parm.output.timeperframe;
+	struct v4l2_dv_timings timings;
+	u32 period, timer;
+
+	if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	if (has_timeperframe(video)) {
+		timer = tpf->denominator ?
+			MGB4_PERIOD(tpf->numerator, tpf->denominator) : 0;
+		if (timer) {
+			get_timings(vindev, &timings);
+			period = MGB4_PERIOD(pixel_size(&timings),
+					     timings.bt.pixelclock);
+			if (timer < period)
+				timer = 0;
+		}
+
+		mgb4_write_reg(video, vindev->config->regs.timer, timer);
+	}
+
+	return vidioc_g_parm(file, priv, parm);
+}
+
 static int vidioc_s_dv_timings(struct file *file, void *fh,
 			       struct v4l2_dv_timings *timings)
 {
@@ -674,8 +717,8 @@ static const struct v4l2_ioctl_ops video_ioctl_ops = {
 	.vidioc_expbuf = vb2_ioctl_expbuf,
 	.vidioc_streamon = vb2_ioctl_streamon,
 	.vidioc_streamoff = vb2_ioctl_streamoff,
-	.vidioc_g_parm = vidioc_parm,
-	.vidioc_s_parm = vidioc_parm,
+	.vidioc_g_parm = vidioc_g_parm,
+	.vidioc_s_parm = vidioc_s_parm,
 	.vidioc_dv_timings_cap = vidioc_dv_timings_cap,
 	.vidioc_enum_dv_timings = vidioc_enum_dv_timings,
 	.vidioc_g_dv_timings = vidioc_g_dv_timings,
@@ -858,10 +901,16 @@ static void debugfs_init(struct mgb4_vin_dev *vindev)
 	vindev->regs[7].offset = vindev->config->regs.signal2;
 	vindev->regs[8].name = "PADDING_PIXELS";
 	vindev->regs[8].offset = vindev->config->regs.padding;
+	if (has_timeperframe(video)) {
+		vindev->regs[9].name = "TIMER";
+		vindev->regs[9].offset = vindev->config->regs.timer;
+		vindev->regset.nregs = 10;
+	} else {
+		vindev->regset.nregs = 9;
+	}
 
 	vindev->regset.base = video->membase;
 	vindev->regset.regs = vindev->regs;
-	vindev->regset.nregs = ARRAY_SIZE(vindev->regs);
 
 	debugfs_create_regset32("registers", 0444, vindev->debugfs,
 				&vindev->regset);
diff --git a/drivers/media/pci/mgb4/mgb4_vin.h b/drivers/media/pci/mgb4/mgb4_vin.h
index 0249b400ad4d..9693bd0ce180 100644
--- a/drivers/media/pci/mgb4/mgb4_vin.h
+++ b/drivers/media/pci/mgb4/mgb4_vin.h
@@ -25,6 +25,7 @@ struct mgb4_vin_regs {
 	u32 signal;
 	u32 signal2;
 	u32 padding;
+	u32 timer;
 };
 
 struct mgb4_vin_config {
@@ -59,7 +60,7 @@ struct mgb4_vin_dev {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
 	struct debugfs_regset32 regset;
-	struct debugfs_reg32 regs[9];
+	struct debugfs_reg32 regs[sizeof(struct mgb4_vin_regs) / 4];
 #endif
 };
 
diff --git a/drivers/media/pci/mgb4/mgb4_vout.c b/drivers/media/pci/mgb4/mgb4_vout.c
index 243fbeaaceb9..c312dfb5f127 100644
--- a/drivers/media/pci/mgb4/mgb4_vout.c
+++ b/drivers/media/pci/mgb4/mgb4_vout.c
@@ -16,6 +16,7 @@
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/videobuf2-dma-sg.h>
+#include <media/v4l2-dv-timings.h>
 #include "mgb4_core.h"
 #include "mgb4_dma.h"
 #include "mgb4_sysfs.h"
@@ -23,12 +24,16 @@
 #include "mgb4_cmt.h"
 #include "mgb4_vout.h"
 
+#define DEFAULT_WIDTH     1280
+#define DEFAULT_HEIGHT    640
+#define DEFAULT_LIMIT     (MGB4_HW_FREQ / 60)
+
 ATTRIBUTE_GROUPS(mgb4_fpdl3_out);
 ATTRIBUTE_GROUPS(mgb4_gmsl_out);
 
 static const struct mgb4_vout_config vout_cfg[] = {
-	{0, 0, 8, {0x78, 0x60, 0x64, 0x68, 0x74, 0x6C, 0x70, 0x7c}},
-	{1, 1, 9, {0x98, 0x80, 0x84, 0x88, 0x94, 0x8c, 0x90, 0x9c}}
+	{0, 0, 8, {0x78, 0x60, 0x64, 0x68, 0x74, 0x6C, 0x70, 0x7C, 0xE0}},
+	{1, 1, 9, {0x98, 0x80, 0x84, 0x88, 0x94, 0x8C, 0x90, 0x9C, 0xE4}}
 };
 
 static const struct i2c_board_info fpdl3_ser_info[] = {
@@ -40,6 +45,49 @@ static const struct mgb4_i2c_kv fpdl3_i2c[] = {
 	{0x05, 0xFF, 0x04}, {0x06, 0xFF, 0x01}, {0xC2, 0xFF, 0x80}
 };
 
+static const struct v4l2_dv_timings_cap video_timings_cap = {
+	.type = V4L2_DV_BT_656_1120,
+	.bt = {
+		.min_width = 320,
+		.max_width = 4096,
+		.min_height = 240,
+		.max_height = 2160,
+		.min_pixelclock = 1843200, /* 320 x 240 x 24Hz */
+		.max_pixelclock = 530841600, /* 4096 x 2160 x 60Hz */
+		.standards = V4L2_DV_BT_STD_CEA861 | V4L2_DV_BT_STD_DMT |
+			V4L2_DV_BT_STD_CVT | V4L2_DV_BT_STD_GTF,
+		.capabilities = V4L2_DV_BT_CAP_PROGRESSIVE |
+			V4L2_DV_BT_CAP_CUSTOM,
+	},
+};
+
+static void get_timings(struct mgb4_vout_dev *voutdev,
+			struct v4l2_dv_timings *timings)
+{
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+	const struct mgb4_vout_regs *regs = &voutdev->config->regs;
+
+	u32 hsync = mgb4_read_reg(video, regs->hsync);
+	u32 vsync = mgb4_read_reg(video, regs->vsync);
+	u32 resolution = mgb4_read_reg(video, regs->resolution);
+
+	memset(timings, 0, sizeof(*timings));
+	timings->type = V4L2_DV_BT_656_1120;
+	timings->bt.width = resolution >> 16;
+	timings->bt.height = resolution & 0xFFFF;
+	if (hsync & (1U << 31))
+		timings->bt.polarities |= V4L2_DV_HSYNC_POS_POL;
+	if (vsync & (1U << 31))
+		timings->bt.polarities |= V4L2_DV_VSYNC_POS_POL;
+	timings->bt.pixelclock = voutdev->freq * 1000;
+	timings->bt.hsync = (hsync & 0x00FF0000) >> 16;
+	timings->bt.vsync = (vsync & 0x00FF0000) >> 16;
+	timings->bt.hbackporch = (hsync & 0x0000FF00) >> 8;
+	timings->bt.hfrontporch = hsync & 0x000000FF;
+	timings->bt.vbackporch = (vsync & 0x0000FF00) >> 8;
+	timings->bt.vfrontporch = vsync & 0x000000FF;
+}
+
 static void return_all_buffers(struct mgb4_vout_dev *voutdev,
 			       enum vb2_buffer_state state)
 {
@@ -345,11 +393,134 @@ static int vidioc_enum_output(struct file *file, void *priv,
 		return -EINVAL;
 
 	out->type = V4L2_OUTPUT_TYPE_ANALOG;
+	out->capabilities = V4L2_OUT_CAP_DV_TIMINGS;
 	strscpy(out->name, "MGB4", sizeof(out->name));
 
 	return 0;
 }
 
+static int vidioc_enum_frameintervals(struct file *file, void *priv,
+				      struct v4l2_frmivalenum *ival)
+{
+	struct mgb4_vout_dev *voutdev = video_drvdata(file);
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+	struct v4l2_dv_timings timings;
+
+	if (ival->index != 0)
+		return -EINVAL;
+	if (!(ival->pixel_format == V4L2_PIX_FMT_ABGR32 ||
+	      ((has_yuv(video) && ival->pixel_format == V4L2_PIX_FMT_YUYV))))
+		return -EINVAL;
+	if (ival->width != voutdev->width || ival->height != voutdev->height)
+		return -EINVAL;
+
+	get_timings(voutdev, &timings);
+
+	ival->type = V4L2_FRMIVAL_TYPE_STEPWISE;
+	ival->stepwise.max.denominator = MGB4_HW_FREQ;
+	ival->stepwise.max.numerator = 0xFFFFFFFF;
+	ival->stepwise.min.denominator = timings.bt.pixelclock;
+	ival->stepwise.min.numerator = pixel_size(&timings);
+	ival->stepwise.step.denominator = MGB4_HW_FREQ;
+	ival->stepwise.step.numerator = 1;
+
+	return 0;
+}
+
+static int vidioc_g_parm(struct file *file, void *priv,
+			 struct v4l2_streamparm *parm)
+{
+	struct mgb4_vout_dev *voutdev = video_drvdata(file);
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+	struct v4l2_fract *tpf = &parm->parm.output.timeperframe;
+	struct v4l2_dv_timings timings;
+	u32 timer;
+
+	if (parm->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
+		return -EINVAL;
+
+	parm->parm.output.writebuffers = 2;
+
+	if (has_timeperframe(video)) {
+		timer = mgb4_read_reg(video, voutdev->config->regs.timer);
+		if (timer < 0xFFFF) {
+			get_timings(voutdev, &timings);
+			tpf->numerator = pixel_size(&timings);
+			tpf->denominator = timings.bt.pixelclock;
+		} else {
+			tpf->numerator = timer;
+			tpf->denominator = MGB4_HW_FREQ;
+		}
+
+		parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+	}
+
+	return 0;
+}
+
+static int vidioc_s_parm(struct file *file, void *priv,
+			 struct v4l2_streamparm *parm)
+{
+	struct mgb4_vout_dev *voutdev = video_drvdata(file);
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+	struct v4l2_fract *tpf = &parm->parm.output.timeperframe;
+	struct v4l2_dv_timings timings;
+	u32 timer, period;
+
+	if (parm->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
+		return -EINVAL;
+
+	if (has_timeperframe(video)) {
+		timer = tpf->denominator ?
+			MGB4_PERIOD(tpf->numerator, tpf->denominator) : 0;
+		if (timer) {
+			get_timings(voutdev, &timings);
+			period = MGB4_PERIOD(pixel_size(&timings),
+					     timings.bt.pixelclock);
+			if (timer < period)
+				timer = 0;
+		}
+
+		mgb4_write_reg(video, voutdev->config->regs.timer, timer);
+	}
+
+	return vidioc_g_parm(file, priv, parm);
+}
+
+static int vidioc_g_dv_timings(struct file *file, void *fh,
+			       struct v4l2_dv_timings *timings)
+{
+	struct mgb4_vout_dev *voutdev = video_drvdata(file);
+
+	get_timings(voutdev, timings);
+
+	return 0;
+}
+
+static int vidioc_s_dv_timings(struct file *file, void *fh,
+			       struct v4l2_dv_timings *timings)
+{
+	struct mgb4_vout_dev *voutdev = video_drvdata(file);
+
+	get_timings(voutdev, timings);
+
+	return 0;
+}
+
+static int vidioc_enum_dv_timings(struct file *file, void *fh,
+				  struct v4l2_enum_dv_timings *timings)
+{
+	return v4l2_enum_dv_timings_cap(timings, &video_timings_cap, NULL, NULL);
+}
+
+static int vidioc_dv_timings_cap(struct file *file, void *fh,
+				 struct v4l2_dv_timings_cap *cap)
+{
+	*cap = video_timings_cap;
+
+	return 0;
+}
+
 static const struct v4l2_ioctl_ops video_ioctl_ops = {
 	.vidioc_querycap = vidioc_querycap,
 	.vidioc_enum_fmt_vid_out = vidioc_enum_fmt,
@@ -357,8 +528,15 @@ static const struct v4l2_ioctl_ops video_ioctl_ops = {
 	.vidioc_s_fmt_vid_out = vidioc_s_fmt,
 	.vidioc_g_fmt_vid_out = vidioc_g_fmt,
 	.vidioc_enum_output = vidioc_enum_output,
+	.vidioc_enum_frameintervals = vidioc_enum_frameintervals,
 	.vidioc_g_output = vidioc_g_output,
 	.vidioc_s_output = vidioc_s_output,
+	.vidioc_g_parm = vidioc_g_parm,
+	.vidioc_s_parm = vidioc_s_parm,
+	.vidioc_dv_timings_cap = vidioc_dv_timings_cap,
+	.vidioc_enum_dv_timings = vidioc_enum_dv_timings,
+	.vidioc_g_dv_timings = vidioc_g_dv_timings,
+	.vidioc_s_dv_timings = vidioc_s_dv_timings,
 	.vidioc_reqbufs = vb2_ioctl_reqbufs,
 	.vidioc_create_bufs = vb2_ioctl_create_bufs,
 	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
@@ -501,13 +679,13 @@ static void fpga_init(struct mgb4_vout_dev *voutdev)
 
 	mgb4_write_reg(video, regs->config, 0x00000011);
 	mgb4_write_reg(video, regs->resolution,
-		       (MGB4_DEFAULT_WIDTH << 16) | MGB4_DEFAULT_HEIGHT);
-	mgb4_write_reg(video, regs->hsync, 0x00102020);
-	mgb4_write_reg(video, regs->vsync, 0x40020202);
-	mgb4_write_reg(video, regs->frame_period, MGB4_DEFAULT_PERIOD);
+		       (DEFAULT_WIDTH << 16) | DEFAULT_HEIGHT);
+	mgb4_write_reg(video, regs->hsync, 0x00283232);
+	mgb4_write_reg(video, regs->vsync, 0x40141F1E);
+	mgb4_write_reg(video, regs->frame_limit, DEFAULT_LIMIT);
 	mgb4_write_reg(video, regs->padding, 0x00000000);
 
-	voutdev->freq = mgb4_cmt_set_vout_freq(voutdev, 70000 >> 1) << 1;
+	voutdev->freq = mgb4_cmt_set_vout_freq(voutdev, 61150 >> 1) << 1;
 
 	mgb4_write_reg(video, regs->config,
 		       (voutdev->config->id + MGB4_VIN_DEVICES) << 2 | 1 << 4);
@@ -533,14 +711,20 @@ static void debugfs_init(struct mgb4_vout_dev *voutdev)
 	voutdev->regs[3].offset = voutdev->config->regs.hsync;
 	voutdev->regs[4].name = "VIDEO_PARAMS_2";
 	voutdev->regs[4].offset = voutdev->config->regs.vsync;
-	voutdev->regs[5].name = "FRAME_PERIOD";
-	voutdev->regs[5].offset = voutdev->config->regs.frame_period;
-	voutdev->regs[6].name = "PADDING";
+	voutdev->regs[5].name = "FRAME_LIMIT";
+	voutdev->regs[5].offset = voutdev->config->regs.frame_limit;
+	voutdev->regs[6].name = "PADDING_PIXELS";
 	voutdev->regs[6].offset = voutdev->config->regs.padding;
+	if (has_timeperframe(video)) {
+		voutdev->regs[7].name = "TIMER";
+		voutdev->regs[7].offset = voutdev->config->regs.timer;
+		voutdev->regset.nregs = 8;
+	} else {
+		voutdev->regset.nregs = 7;
+	}
 
 	voutdev->regset.base = video->membase;
 	voutdev->regset.regs = voutdev->regs;
-	voutdev->regset.nregs = ARRAY_SIZE(voutdev->regs);
 
 	debugfs_create_regset32("registers", 0444, voutdev->debugfs,
 				&voutdev->regset);
diff --git a/drivers/media/pci/mgb4/mgb4_vout.h b/drivers/media/pci/mgb4/mgb4_vout.h
index b163dee711fd..adc8fe1e7ae6 100644
--- a/drivers/media/pci/mgb4/mgb4_vout.h
+++ b/drivers/media/pci/mgb4/mgb4_vout.h
@@ -19,10 +19,11 @@ struct mgb4_vout_regs {
 	u32 config;
 	u32 status;
 	u32 resolution;
-	u32 frame_period;
+	u32 frame_limit;
 	u32 hsync;
 	u32 vsync;
 	u32 padding;
+	u32 timer;
 };
 
 struct mgb4_vout_config {
@@ -55,7 +56,7 @@ struct mgb4_vout_dev {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
 	struct debugfs_regset32 regset;
-	struct debugfs_reg32 regs[7];
+	struct debugfs_reg32 regs[sizeof(struct mgb4_vout_regs) / 4];
 #endif
 };
 
-- 
2.44.0


