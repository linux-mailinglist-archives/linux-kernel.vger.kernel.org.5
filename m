Return-Path: <linux-kernel+bounces-71199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F1085A1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE1B9B2349D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF832D05F;
	Mon, 19 Feb 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcDMNwAv"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A062C1A4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341796; cv=none; b=eUgUorJ2ge64X8dRE9L20rENFLXmsakA83OkV4e1dEeBja8x5QZEqVpW2HJy9QnacEJWaI/8XplTc4x6fLOyalwgydbfQwU07mK06n4jgQ1trulIN20NE6xcKAhioR7lMzXE+zyu74uMap2fZIFcp6sb0IlvRXq4NbiGcuY7fU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341796; c=relaxed/simple;
	bh=WJhan3UP9Z7GAaBjgIiNA/IqDSv3J6aKXJJ9PHj+wuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SvLnVLmTvMHGFQBFm06xtdsaEbAI9JEPHSEi7btHuQXlwLrZV5KeVhRW3l26HIVqSvXptmNmV93oAwmfoDROR4L1Piv9NPqWHCaNi9FGjbuIX5QCa0td9yPKKjVEpWlegUDOB1pSemFjFfbR1oQe9HE/zQxcihaPYZu6SmYEBmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcDMNwAv; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3122b70439so498989166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708341793; x=1708946593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuW0tA1+gOLBqnUIoohkzCyIMBvVnloNgoNFu8SX/5U=;
        b=BcDMNwAvpAQuQBhFKoX8J/LsyIaXWH/r5Zf4A7hjGDKwykBlOONppCi97gLWrEHMxr
         eZvzJhSEfGwoAcKKNkLmLfLn/HywEAeYL7xKguEcTCrCpX67mH4JyAS2pm9xrSeAyxOl
         GzAzOhz1w0hHbfW7DUfYPoQi23NDns3dasiOlP21uhf2qsH8n4EAg2tNXSzxhNR7yjeb
         tTP85Bx3ueGPOzL8/xiMJFQfAnJGbT7FdWC2BwYNFTMvzgZM66hCgIr4Rp0K1J95KKwq
         yYY+uEcaOSlNVuWRQxU+bjQy8R4QZE2m0ND/tSRBLQ2R/ji7WKEh1H+mk6n7rLSn7jJY
         4Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708341793; x=1708946593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuW0tA1+gOLBqnUIoohkzCyIMBvVnloNgoNFu8SX/5U=;
        b=mZYHspwBdXrl1trSeRzztm2PSm5oIK3Dh99Qm4tLtSr4S13EZ7dNrvPLRuCKNJeCRa
         FTKKQyJiBP4deFWOYobxkrtry4WaddBgmjCCuKSlNZDB4jR2KIKk9e2RbBSmj+pHFAqI
         OiK7AZXeJNIikStskUCwlcjT0NUxcupkdMsx+3AywbvBn5OeyhaPxJsFUMZwojFWRAaK
         vbE5AuIsAykNKmTDD7FtaEFAD+VnvfbeAAUJHWoKEa8m9Qw4vmR/YdWdZogz7jS5E11D
         0LOyllV+R6oWm6eRVvf94BveKf+9NgSLPt7CZn8WQoHPHd6rLMdpGRjOzN9g8kUR5DIR
         Duww==
X-Forwarded-Encrypted: i=1; AJvYcCXiU7FGXgsMp45gBFXArug83Jy0b7cj0NKbl2PLhNnhet+BTtjA1bXXRg8n4L2PlW+9tY2BZ8EuXm9JgsfAlondEVr13v+Xof4lZp7i
X-Gm-Message-State: AOJu0YyW0OpRP1P6v9IrjabbmxCq7u24ijG8m+9gZSJrVq5U79k0Zygm
	Iu87K7ZET9NHCvMTRee/EtLYM5B0qa0Guk1z86ooh2i5H2BDsnvp
X-Google-Smtp-Source: AGHT+IGSD3jTvmpSu9lWqJy92v3b8wbBP8Kn6inBcfLvx/7Fp4KrXtljJvlVnzhlgszKc5IkdfBLKg==
X-Received: by 2002:a17:906:a1cd:b0:a3d:6eb4:9768 with SMTP id bx13-20020a170906a1cd00b00a3d6eb49768mr7088156ejb.46.1708341793096;
        Mon, 19 Feb 2024 03:23:13 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id ti12-20020a170907c20c00b00a3d581658bfsm2826495ejc.24.2024.02.19.03.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:23:12 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH v3 2/2] Staging: vc04_services: bcm2835-camera: fix brace code style check
Date: Mon, 19 Feb 2024 12:22:34 +0100
Message-Id: <20240219112234.8673-3-mo.c.weber@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240219112234.8673-1-mo.c.weber@gmail.com>
References: <236d985c-1835-410f-b0b5-cacbd5fbf930@moroto.mountain>
 <20240219112234.8673-1-mo.c.weber@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reformat function parameters to fix checkpatch check:
Increase readability and consistency

Signed-off-by: Moritz C. Weber <mo.c.weber@gmail.com>
---
 .../bcm2835-camera/bcm2835-camera.c           | 60 +++++++++----------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index e6ff5ea04..c3ba490e5 100644
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
+					      &dev->capture.frame_count,
+					      sizeof(dev->capture.frame_count));
 	}
 }
 
@@ -420,11 +418,10 @@ static int enable_camera(struct bcm2835_mmal_dev *dev)
 	int ret;
 
 	if (!dev->camera_use_count) {
-		ret = vchiq_mmal_port_parameter_set(
-			dev->instance,
-			&dev->component[COMP_CAMERA]->control,
-			MMAL_PARAMETER_CAMERA_NUM, &dev->camera_num,
-			sizeof(dev->camera_num));
+		ret = vchiq_mmal_port_parameter_set(dev->instance,
+						    &dev->component[COMP_CAMERA]->control,
+						    MMAL_PARAMETER_CAMERA_NUM, &dev->camera_num,
+						    sizeof(dev->camera_num));
 		if (ret < 0) {
 			v4l2_err(&dev->v4l2_dev,
 				 "Failed setting camera num, ret %d\n", ret);
@@ -468,11 +465,11 @@ static int disable_camera(struct bcm2835_mmal_dev *dev)
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
@@ -786,9 +783,8 @@ static int vidioc_overlay(struct file *file, void *f, unsigned int on)
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
@@ -1041,8 +1037,8 @@ static int mmal_setup_video_component(struct bcm2835_mmal_dev *dev,
 
 	if (overlay_enabled) {
 		ret = vchiq_mmal_port_connect_tunnel(dev->instance,
-				preview_port,
-				&dev->component[COMP_PREVIEW]->input[0]);
+						     preview_port,
+						     &dev->component[COMP_PREVIEW]->input[0]);
 		if (ret)
 			return ret;
 
@@ -1719,11 +1715,11 @@ static int mmal_init(struct bcm2835_mmal_dev *dev)
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


