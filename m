Return-Path: <linux-kernel+bounces-95403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540BF874D3D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DDA284591
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E31129A77;
	Thu,  7 Mar 2024 11:18:35 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF2386AE9;
	Thu,  7 Mar 2024 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810314; cv=none; b=V/CWA+JIZjgd3GYoYKZWOU2kde3xFVra2GR8m53urh0p/YSOdWGrpeEDtwHDZvgCSSZMwtG/x2wjU2HJCTekmcJCI052KuOu+/LiGTUhTxXbztSwxpe71gW0hFf5NTx1SqiDna6ZnNkaE+NK/GnWBvoRmxeCk3LdSY7a2I7kUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810314; c=relaxed/simple;
	bh=z7uHi44jazTy+1QLYDTQDu8HlqDYjCoKrSPOoXI9JVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvyJiEAsCCOv7lBtAZx5QtaQJs+Ra8AHoLLaFLSLann5FjwH18kOsEa3k0eWGhuAvjARr3GZW67tJA0Si35qxLwa6/qG2AqLH43CL26mvW8WS7cfajDTxiu8i3eVXzA05nMGfElvv0HB4JXPFLDLrBvQ4rIgao+tbPd3DtO2+Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from mgb4.digiteq.red (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id C2D554B87E;
	Thu,  7 Mar 2024 12:18:23 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v2 1/2] media: mgb4: Add support for YUV image formats
Date: Thu,  7 Mar 2024 13:18:21 +0100
Message-ID: <20240307121822.1852-2-tumic@gpxsee.org>
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

Recent mgb4 firmwares support YUV in addition to the RGB image format. Enable
YUV in the driver when the FW supports it.

Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
---
 drivers/media/pci/mgb4/mgb4_io.h   |   7 ++
 drivers/media/pci/mgb4/mgb4_vin.c  | 116 ++++++++++++++++++++++++-----
 drivers/media/pci/mgb4/mgb4_vout.c | 116 ++++++++++++++++++++++++-----
 3 files changed, 203 insertions(+), 36 deletions(-)

diff --git a/drivers/media/pci/mgb4/mgb4_io.h b/drivers/media/pci/mgb4/mgb4_io.h
index 8698db1be4a9..204613a6685c 100644
--- a/drivers/media/pci/mgb4/mgb4_io.h
+++ b/drivers/media/pci/mgb4/mgb4_io.h
@@ -30,4 +30,11 @@ static inline struct mgb4_frame_buffer *to_frame_buffer(struct vb2_v4l2_buffer *
 	return container_of(vbuf, struct mgb4_frame_buffer, vb);
 }
 
+static inline bool has_yuv(struct mgb4_regs *video)
+{
+	u32 status = mgb4_read_reg(video, 0xD0);
+
+	return (status & (1U << 8));
+}
+
 #endif
diff --git a/drivers/media/pci/mgb4/mgb4_vin.c b/drivers/media/pci/mgb4/mgb4_vin.c
index 2cd78c539889..19692e4dfb59 100644
--- a/drivers/media/pci/mgb4/mgb4_vin.c
+++ b/drivers/media/pci/mgb4/mgb4_vin.c
@@ -186,8 +186,11 @@ static int queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
 		       struct device *alloc_devs[])
 {
 	struct mgb4_vin_dev *vindev = vb2_get_drv_priv(q);
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+	u32 config = mgb4_read_reg(video, vindev->config->regs.config);
+	u32 pixelsize = (config & (1U << 16)) ? 2 : 4;
 	unsigned int size = (vindev->timings.bt.width + vindev->padding)
-	 * vindev->timings.bt.height * 4;
+			    * vindev->timings.bt.height * pixelsize;
 
 	/*
 	 * If I/O reconfiguration is in process, do not allow to start
@@ -220,9 +223,12 @@ static int buffer_init(struct vb2_buffer *vb)
 static int buffer_prepare(struct vb2_buffer *vb)
 {
 	struct mgb4_vin_dev *vindev = vb2_get_drv_priv(vb->vb2_queue);
+	struct mgb4_regs *video = &vindev->mgbdev->video;
 	struct device *dev = &vindev->mgbdev->pdev->dev;
+	u32 config = mgb4_read_reg(video, vindev->config->regs.config);
+	u32 pixelsize = (config & (1U << 16)) ? 2 : 4;
 	unsigned int size = (vindev->timings.bt.width + vindev->padding)
-	 * vindev->timings.bt.height * 4;
+			    * vindev->timings.bt.height * pixelsize;
 
 	if (vb2_plane_size(vb, 0) < size) {
 		dev_err(dev, "buffer too small (%lu < %u)\n",
@@ -359,22 +365,33 @@ static int vidioc_querycap(struct file *file, void *priv,
 static int vidioc_enum_fmt(struct file *file, void *priv,
 			   struct v4l2_fmtdesc *f)
 {
-	if (f->index != 0)
-		return -EINVAL;
+	struct mgb4_vin_dev *vindev = video_drvdata(file);
+	struct mgb4_regs *video = &vindev->mgbdev->video;
 
-	f->pixelformat = V4L2_PIX_FMT_ABGR32;
+	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
 
-	return 0;
+	if (f->index == 0) {
+		f->pixelformat = V4L2_PIX_FMT_ABGR32;
+		return 0;
+	} else if (f->index == 1 && has_yuv(video)) {
+		f->pixelformat = V4L2_PIX_FMT_YUYV;
+		return 0;
+	} else {
+		return -EINVAL;
+	}
 }
 
 static int vidioc_enum_frameintervals(struct file *file, void *priv,
 				      struct v4l2_frmivalenum *ival)
 {
 	struct mgb4_vin_dev *vindev = video_drvdata(file);
+	struct mgb4_regs *video = &vindev->mgbdev->video;
 
 	if (ival->index != 0)
 		return -EINVAL;
-	if (ival->pixel_format != V4L2_PIX_FMT_ABGR32)
+	if (!(ival->pixel_format == V4L2_PIX_FMT_ABGR32 ||
+	      ((has_yuv(video) && ival->pixel_format == V4L2_PIX_FMT_YUYV))))
 		return -EINVAL;
 	if (ival->width != vindev->timings.bt.width ||
 	    ival->height != vindev->timings.bt.height)
@@ -393,13 +410,32 @@ static int vidioc_enum_frameintervals(struct file *file, void *priv,
 static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 {
 	struct mgb4_vin_dev *vindev = video_drvdata(file);
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+	u32 config = mgb4_read_reg(video, vindev->config->regs.config);
+
+	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
 
-	f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
 	f->fmt.pix.width = vindev->timings.bt.width;
 	f->fmt.pix.height = vindev->timings.bt.height;
 	f->fmt.pix.field = V4L2_FIELD_NONE;
-	f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
-	f->fmt.pix.bytesperline = (f->fmt.pix.width + vindev->padding) * 4;
+
+	if (config & (1U << 16)) {
+		f->fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
+		if (config & (1U << 20)) {
+			f->fmt.pix.colorspace = V4L2_COLORSPACE_REC709;
+		} else {
+			if (config & (1U << 19))
+				f->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
+			else
+				f->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
+		}
+		f->fmt.pix.bytesperline = (f->fmt.pix.width + vindev->padding) * 2;
+	} else {
+		f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
+		f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
+		f->fmt.pix.bytesperline = (f->fmt.pix.width + vindev->padding) * 4;
+	}
 	f->fmt.pix.sizeimage = f->fmt.pix.bytesperline * f->fmt.pix.height;
 
 	return 0;
@@ -408,14 +444,33 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 {
 	struct mgb4_vin_dev *vindev = video_drvdata(file);
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+	u32 pixelsize;
+
+	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
 
-	f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
 	f->fmt.pix.width = vindev->timings.bt.width;
 	f->fmt.pix.height = vindev->timings.bt.height;
 	f->fmt.pix.field = V4L2_FIELD_NONE;
-	f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
-	f->fmt.pix.bytesperline = max(f->fmt.pix.width * 4,
-				      ALIGN_DOWN(f->fmt.pix.bytesperline, 4));
+
+	if (has_yuv(video) && f->fmt.pix.pixelformat == V4L2_PIX_FMT_YUYV) {
+		pixelsize = 2;
+		if (!(f->fmt.pix.colorspace == V4L2_COLORSPACE_REC709 ||
+		      f->fmt.pix.colorspace == V4L2_COLORSPACE_SMPTE170M))
+			f->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
+	} else {
+		pixelsize = 4;
+		f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
+		f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
+	}
+
+	if (f->fmt.pix.bytesperline > f->fmt.pix.width * pixelsize
+	    && f->fmt.pix.bytesperline < f->fmt.pix.width * pixelsize * 2)
+		f->fmt.pix.bytesperline = ALIGN(f->fmt.pix.bytesperline,
+						pixelsize);
+	else
+		f->fmt.pix.bytesperline = f->fmt.pix.width * pixelsize;
 	f->fmt.pix.sizeimage = f->fmt.pix.bytesperline * f->fmt.pix.height;
 
 	return 0;
@@ -425,13 +480,39 @@ static int vidioc_s_fmt(struct file *file, void *priv, struct v4l2_format *f)
 {
 	struct mgb4_vin_dev *vindev = video_drvdata(file);
 	struct mgb4_regs *video = &vindev->mgbdev->video;
+	u32 config, pixelsize;
+	int ret;
 
 	if (vb2_is_busy(&vindev->queue))
 		return -EBUSY;
 
-	vidioc_try_fmt(file, priv, f);
+	ret = vidioc_try_fmt(file, priv, f);
+	if (ret < 0)
+		return ret;
+
+	config = mgb4_read_reg(video, vindev->config->regs.config);
+	if (f->fmt.pix.pixelformat == V4L2_PIX_FMT_YUYV) {
+		pixelsize = 2;
+		config |= 1U << 16;
+
+		if (f->fmt.pix.colorspace == V4L2_COLORSPACE_REC709) {
+			config |= 1U << 20;
+			config |= 1U << 19;
+		} else if (f->fmt.pix.colorspace == V4L2_COLORSPACE_SMPTE170M) {
+			config &= ~(1U << 20);
+			config |= 1U << 19;
+		} else {
+			config &= ~(1U << 20);
+			config &= ~(1U << 19);
+		}
+	} else {
+		pixelsize = 4;
+		config &= ~(1U << 16);
+	}
+	mgb4_write_reg(video, vindev->config->regs.config, config);
 
-	vindev->padding = (f->fmt.pix.bytesperline - (f->fmt.pix.width * 4)) / 4;
+	vindev->padding = (f->fmt.pix.bytesperline - (f->fmt.pix.width
+			   * pixelsize)) / pixelsize;
 	mgb4_write_reg(video, vindev->config->regs.padding, vindev->padding);
 	set_loopback_padding(vindev, vindev->padding);
 
@@ -467,7 +548,8 @@ static int vidioc_enum_framesizes(struct file *file, void *fh,
 {
 	struct mgb4_vin_dev *vindev = video_drvdata(file);
 
-	if (fsize->index != 0 || fsize->pixel_format != V4L2_PIX_FMT_ABGR32)
+	if (fsize->index != 0 || !(fsize->pixel_format == V4L2_PIX_FMT_ABGR32 ||
+				   fsize->pixel_format == V4L2_PIX_FMT_YUYV))
 		return -EINVAL;
 
 	fsize->discrete.width = vindev->timings.bt.width;
diff --git a/drivers/media/pci/mgb4/mgb4_vout.c b/drivers/media/pci/mgb4/mgb4_vout.c
index 241353ee77a5..243fbeaaceb9 100644
--- a/drivers/media/pci/mgb4/mgb4_vout.c
+++ b/drivers/media/pci/mgb4/mgb4_vout.c
@@ -59,7 +59,11 @@ static int queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
 		       struct device *alloc_devs[])
 {
 	struct mgb4_vout_dev *voutdev = vb2_get_drv_priv(q);
-	unsigned int size;
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+	u32 config = mgb4_read_reg(video, voutdev->config->regs.config);
+	u32 pixelsize = (config & (1U << 16)) ? 2 : 4;
+	unsigned int size = (voutdev->width + voutdev->padding) * voutdev->height
+			    * pixelsize;
 
 	/*
 	 * If I/O reconfiguration is in process, do not allow to start
@@ -69,8 +73,6 @@ static int queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
 	if (test_bit(0, &voutdev->mgbdev->io_reconfig))
 		return -EBUSY;
 
-	size = (voutdev->width + voutdev->padding) * voutdev->height * 4;
-
 	if (*nplanes)
 		return sizes[0] < size ? -EINVAL : 0;
 	*nplanes = 1;
@@ -93,9 +95,11 @@ static int buffer_prepare(struct vb2_buffer *vb)
 {
 	struct mgb4_vout_dev *voutdev = vb2_get_drv_priv(vb->vb2_queue);
 	struct device *dev = &voutdev->mgbdev->pdev->dev;
-	unsigned int size;
-
-	size = (voutdev->width + voutdev->padding) * voutdev->height * 4;
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+	u32 config = mgb4_read_reg(video, voutdev->config->regs.config);
+	u32 pixelsize = (config & (1U << 16)) ? 2 : 4;
+	unsigned int size = (voutdev->width + voutdev->padding) * voutdev->height
+			    * pixelsize;
 
 	if (vb2_plane_size(vb, 0) < size) {
 		dev_err(dev, "buffer too small (%lu < %u)\n",
@@ -194,24 +198,53 @@ static int vidioc_querycap(struct file *file, void *priv,
 static int vidioc_enum_fmt(struct file *file, void *priv,
 			   struct v4l2_fmtdesc *f)
 {
-	if (f->index != 0)
-		return -EINVAL;
+	struct mgb4_vin_dev *voutdev = video_drvdata(file);
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
 
-	f->pixelformat = V4L2_PIX_FMT_ABGR32;
+	if (f->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
+		return -EINVAL;
 
-	return 0;
+	if (f->index == 0) {
+		f->pixelformat = V4L2_PIX_FMT_ABGR32;
+		return 0;
+	} else if (f->index == 1 && has_yuv(video)) {
+		f->pixelformat = V4L2_PIX_FMT_YUYV;
+		return 0;
+	} else {
+		return -EINVAL;
+	}
 }
 
 static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 {
 	struct mgb4_vout_dev *voutdev = video_drvdata(file);
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+	u32 config = mgb4_read_reg(video, voutdev->config->regs.config);
+
+	if (f->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
+		return -EINVAL;
 
-	f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
 	f->fmt.pix.width = voutdev->width;
 	f->fmt.pix.height = voutdev->height;
 	f->fmt.pix.field = V4L2_FIELD_NONE;
-	f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
-	f->fmt.pix.bytesperline = (f->fmt.pix.width + voutdev->padding) * 4;
+
+	if (config & (1U << 16)) {
+		f->fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
+		if (config & (1U << 20)) {
+			f->fmt.pix.colorspace = V4L2_COLORSPACE_REC709;
+		} else {
+			if (config & (1U << 19))
+				f->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
+			else
+				f->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
+		}
+		f->fmt.pix.bytesperline = (f->fmt.pix.width + voutdev->padding) * 2;
+	} else {
+		f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
+		f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
+		f->fmt.pix.bytesperline = (f->fmt.pix.width + voutdev->padding) * 4;
+	}
+
 	f->fmt.pix.sizeimage = f->fmt.pix.bytesperline * f->fmt.pix.height;
 
 	return 0;
@@ -220,14 +253,33 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 {
 	struct mgb4_vout_dev *voutdev = video_drvdata(file);
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+	u32 pixelsize;
+
+	if (f->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
+		return -EINVAL;
 
-	f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
 	f->fmt.pix.width = voutdev->width;
 	f->fmt.pix.height = voutdev->height;
 	f->fmt.pix.field = V4L2_FIELD_NONE;
-	f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
-	f->fmt.pix.bytesperline = max(f->fmt.pix.width * 4,
-				      ALIGN_DOWN(f->fmt.pix.bytesperline, 4));
+
+	if (has_yuv(video) && f->fmt.pix.pixelformat == V4L2_PIX_FMT_YUYV) {
+		pixelsize = 2;
+		if (!(f->fmt.pix.colorspace == V4L2_COLORSPACE_REC709 ||
+		      f->fmt.pix.colorspace == V4L2_COLORSPACE_SMPTE170M))
+			f->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
+	} else {
+		pixelsize = 4;
+		f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
+		f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
+	}
+
+	if (f->fmt.pix.bytesperline > f->fmt.pix.width * pixelsize
+	    && f->fmt.pix.bytesperline < f->fmt.pix.width * pixelsize * 2)
+		f->fmt.pix.bytesperline = ALIGN(f->fmt.pix.bytesperline,
+						pixelsize);
+	else
+		f->fmt.pix.bytesperline = f->fmt.pix.width * pixelsize;
 	f->fmt.pix.sizeimage = f->fmt.pix.bytesperline * f->fmt.pix.height;
 
 	return 0;
@@ -237,13 +289,39 @@ static int vidioc_s_fmt(struct file *file, void *priv, struct v4l2_format *f)
 {
 	struct mgb4_vout_dev *voutdev = video_drvdata(file);
 	struct mgb4_regs *video = &voutdev->mgbdev->video;
+	u32 config, pixelsize;
+	int ret;
 
 	if (vb2_is_busy(&voutdev->queue))
 		return -EBUSY;
 
-	vidioc_try_fmt(file, priv, f);
+	ret = vidioc_try_fmt(file, priv, f);
+	if (ret < 0)
+		return ret;
+
+	config = mgb4_read_reg(video, voutdev->config->regs.config);
+	if (f->fmt.pix.pixelformat == V4L2_PIX_FMT_YUYV) {
+		pixelsize = 2;
+		config |= 1U << 16;
+
+		if (f->fmt.pix.colorspace == V4L2_COLORSPACE_REC709) {
+			config |= 1U << 20;
+			config |= 1U << 19;
+		} else if (f->fmt.pix.colorspace == V4L2_COLORSPACE_SMPTE170M) {
+			config &= ~(1U << 20);
+			config |= 1U << 19;
+		} else {
+			config &= ~(1U << 20);
+			config &= ~(1U << 19);
+		}
+	} else {
+		pixelsize = 4;
+		config &= ~(1U << 16);
+	}
+	mgb4_write_reg(video, voutdev->config->regs.config, config);
 
-	voutdev->padding = (f->fmt.pix.bytesperline - (f->fmt.pix.width * 4)) / 4;
+	voutdev->padding = (f->fmt.pix.bytesperline - (f->fmt.pix.width
+			    * pixelsize)) / pixelsize;
 	mgb4_write_reg(video, voutdev->config->regs.padding, voutdev->padding);
 
 	return 0;
-- 
2.44.0


