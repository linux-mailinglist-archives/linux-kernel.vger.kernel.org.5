Return-Path: <linux-kernel+bounces-67733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082FE856FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB521C214F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88A413B7A1;
	Thu, 15 Feb 2024 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2aW9GdI"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB841420A8
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034841; cv=none; b=AeGf4k/QNvfSjEHASR3vYLNxG4q0LDen2m31GR2TfZYNHh6qMkoC4E8jz/WO3Ae5bvlE/9CukduuC3TSeweLub2uePYEOVxbvPeUgIyOfBfG0C72V/OSoNQB2OwMFtuU9t6aPv/a7yV15z58vdq7WsN1yd0NvchVr8yvZBQ18+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034841; c=relaxed/simple;
	bh=05jIvIGWXrLnGJcrSrayKp/38O6IX2DmixejxBCN9Sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lwotiphj3tWlHt3O0xk5tFW0UcrBAm/3wKdbG97OJZVKm6QzVRqkgKq67ATzwnYjsN7WIv1sP2DDAsO3Jf/NSnGURARKqo92874sLEBO4oMW1B1gSKyyp0wZhU6hPEetkvReJ++xccFGDK2rfHgi7NEtxmhlwxFI0a56XgIwY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2aW9GdI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3566c0309fso170171166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708034837; x=1708639637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=21uIqFQMa/yVZznf8kmpsHONHVQ5nJQEZM8RZ+UmyrU=;
        b=e2aW9GdIYOkz8dO4i6MuV2z18mrBAmc9HZlDrMoxiiKIUPBzwgHibwk+2t4p1YheBN
         NvZsGy+fLl4QfrF9GPjDmZom7ei2JR2Ay1mpf33It2LtC31M4ni967AzCqJOT7nl94oJ
         7hqLTeZPjprbDF6jd1UUFbcqqfnaGW+HPCc2u60G0zZe/etYAc6SiGp+ohHWIDLZ9nVV
         V6J0z/oszze148Lv9h+TRS8Re11lZNuLt2NrpcK9NukmihGyRwhxkr74clFSZ+ZdBkBz
         cYam4rBk/Lt//E+EowPJbsYrg/Ku4EbPOohEiwWXGlHyI6VhyfGDvNOhNGENFqDioIx3
         MOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708034837; x=1708639637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21uIqFQMa/yVZznf8kmpsHONHVQ5nJQEZM8RZ+UmyrU=;
        b=GqSFe95O6QXsxs8PkMN6GZzv0Z6504emQ9/K8LitEqIuuPfDGPFyb1ebuceYAUIIct
         /mApDJCP0EfiWhIr9BfVZyf6Jb6cxUTkzmtXscOrVp0fePsJ4LyOAjG27xOiRNT/3WI9
         Z244VH42GiK1r14wOJvh6Y0i6e6w2C6/gsEoJIDywmBgwyi7zIeP65ycXVFU3py2Jcnp
         TRjNRJAGY1VQeWh8elOgBmr4rnioco40/KiywEpEyzfvtBVEoHjEbj/Sq5OJ8KVECzni
         c+bAtGHIwLwlC+tfJzTDilf3rFZTxVuoft3RzA8g+bYGwu8sj55BYq1ksmj+ChrQO+sr
         KRlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCIg5y0GnZozCRORkJxVlRiw5kU9Mp441xp7+nP1IyUDHz+LYtMtKf2jQLbY7WwfgzK+N1EDZK6zs3Y6JZUE/3PH7Xm5gZpqBZsJ1v
X-Gm-Message-State: AOJu0YxAMyMcbQVRUh4f+hnBNU77ghNdVDxvXQSJptzUlGVCOUQC7Apj
	OVxC8ELdk1gjRjRIhLfVgUxomKJ7XJHqZIT/zJXLQrQAiAVtietO
X-Google-Smtp-Source: AGHT+IHgDXQY8gMquNY6IZAlhBgxcOSmHelzr1+pZBlo3xkDM+cA9ECVhYbvw90kNcX2+3RpK9D+VA==
X-Received: by 2002:a17:907:104c:b0:a3d:2fb7:98fe with SMTP id oy12-20020a170907104c00b00a3d2fb798femr2124907ejb.32.1708034837034;
        Thu, 15 Feb 2024 14:07:17 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906a19100b00a3d0e9bdc35sm948123ejy.68.2024.02.15.14.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:07:16 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH] Staging: vc04_services: bcm2835-camera: fixed several brace coding style checks
Date: Thu, 15 Feb 2024 23:06:47 +0100
Message-Id: <20240215220647.4096-1-mo.c.weber@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed coding style checks raised by checkpatch

Signed-off-by: Moritz C. Weber <mo.c.weber@gmail.com>
---
 .../bcm2835-camera/bcm2835-camera.c           | 62 +++++++++----------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index e6e89784d..1ef7a2118 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -350,12 +350,11 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
 			if (is_capturing(dev)) {
 				v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 					 "Grab another frame");
-				vchiq_mmal_port_parameter_set(
-					instance,
-					dev->capture.camera_port,
-					MMAL_PARAMETER_CAPTURE,
-					&dev->capture.frame_count,
-					sizeof(dev->capture.frame_count));
+				vchiq_mmal_port_parameter_set(instance,
+							      dev->capture.camera_port,
+							      MMAL_PARAMETER_CAPTURE,
+							      &dev->capture.frame_count,
+							      sizeof(dev->capture.frame_count));
 			}
 			if (vchiq_mmal_submit_buffer(instance, port,
 						     &buf->mmal))
@@ -406,12 +405,11 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
 	    is_capturing(dev)) {
 		v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 			 "Grab another frame as buffer has EOS");
-		vchiq_mmal_port_parameter_set(
-			instance,
-			dev->capture.camera_port,
-			MMAL_PARAMETER_CAPTURE,
-			&dev->capture.frame_count,
-			sizeof(dev->capture.frame_count));
+		vchiq_mmal_port_parameter_set(instance,
+					      dev->capture.camera_port,
+					      MMAL_PARAMETER_CAPTURE,
+					      #N(#O(#O(#O(#O(&dev->capture.frame_count,
+					      sizeof(dev->capture.frame_count));
 	}
 }
 
@@ -420,11 +418,11 @@ static int enable_camera(struct bcm2835_mmal_dev *dev)
 	int ret;
 
 	if (!dev->camera_use_count) {
-		ret = vchiq_mmal_port_parameter_set(
-			dev->instance,
-			&dev->component[COMP_CAMERA]->control,
-			MMAL_PARAMETER_CAMERA_NUM, &dev->camera_num,
-			sizeof(dev->camera_num));
+		ret = vchiq_mmal_port_parameter_set(dev->instance,
+						    &dev->component[COMP_CAMERA]->control,
+						    MMAL_PARAMETER_CAMERA_NUM,
+						    &dev->camera_num,
+						    **sizeof(dev->camera_num));
 		if (ret < 0) {
 			v4l2_err(&dev->v4l2_dev,
 				 "Failed setting camera num, ret %d\n", ret);
@@ -468,11 +466,11 @@ static int disable_camera(struct bcm2835_mmal_dev *dev)
 				 "Failed disabling camera, ret %d\n", ret);
 			return -EINVAL;
 		}
-		vchiq_mmal_port_parameter_set(
-			dev->instance,
-			&dev->component[COMP_CAMERA]->control,
-			MMAL_PARAMETER_CAMERA_NUM, &i,
-			sizeof(i));
+		vchiq_mmal_port_parameter_set(dev->instance,
+					      &dev->component[COMP_CAMERA]->control,
+					      MMAL_PARAMETER_CAMERA_NUM,
+					      &i,
+					      sizeof(i));
 	}
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 		 "Camera refcount now %d\n", dev->camera_use_count);
@@ -786,9 +784,8 @@ static int vidioc_overlay(struct file *file, void *f, unsigned int on)
 			ret = vchiq_mmal_port_connect_tunnel(dev->instance, src,
 							     NULL);
 		if (ret >= 0)
-			ret = vchiq_mmal_component_disable(
-					dev->instance,
-					dev->component[COMP_PREVIEW]);
+			ret = vchiq_mmal_component_disable(dev->instance,
+							   dev->component[COMP_PREVIEW]);
 
 		disable_camera(dev);
 		return ret;
@@ -1006,7 +1003,6 @@ static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
 	return 0;
 }
 
-
 static int mmal_setup_video_component(struct bcm2835_mmal_dev *dev,
 				      struct v4l2_format *f)
 {
@@ -1042,8 +1038,8 @@ static int mmal_setup_video_component(struct bcm2835_mmal_dev *dev,
 
 	if (overlay_enabled) {
 		ret = vchiq_mmal_port_connect_tunnel(dev->instance,
-				preview_port,
-				&dev->component[COMP_PREVIEW]->input[0]);
+						     preview_port,
+						     &dev->component[COMP_PREVIEW]->input[0]);
 		if (ret)
 			return ret;
 
@@ -1720,11 +1716,11 @@ static int mmal_init(struct bcm2835_mmal_dev *dev)
 	{
 		unsigned int enable = 1;
 
-		vchiq_mmal_port_parameter_set(
-			dev->instance,
-			&dev->component[COMP_VIDEO_ENCODE]->control,
-			MMAL_PARAMETER_VIDEO_IMMUTABLE_INPUT,
-			&enable, sizeof(enable));
+		vchiq_mmal_port_parameter_set(dev->instance,
+					      &dev->component[COMP_VIDEO_ENCODE]->control,
+					      MMAL_PARAMETER_VIDEO_IMMUTABLE_INPUT,
+					      &enable,
+					      sizeof(enable));
 
 		vchiq_mmal_port_parameter_set(dev->instance,
 					      &dev->component[COMP_VIDEO_ENCODE]->control,
-- 
2.30.2


