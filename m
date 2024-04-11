Return-Path: <linux-kernel+bounces-140914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AE18A1994
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70AB91C2442A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791E9184138;
	Thu, 11 Apr 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ehr5vuED"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF5180A83
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849752; cv=none; b=eZwxsWuhVj2IJ88aULbZF+mupPV+5m8wsqIO2jFDDkuI0RKGQXdTk5TVWXwDawk9yfeWyZjv9jW6+2bnR7AtnsBs/s/qbX7eFeeKF0zt/1yizEwBEYsx+T4vGk03QmxunPq5q4CKwDuB51JuOoI0gNTY9S+1JcJI2Iw44+Ngkno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849752; c=relaxed/simple;
	bh=89HQQocie0vw01Sr+dLWuwYgc/vjWHUmHHqlbkiBAkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iV+MOxo49grq41BJXuDOtXMtYJtC26rss2oARR9+ygdTg2pGyO2Vr/sd2AXIykaq5elGlA0eG67zw8yFbzHoZyGBPBWVGR08UtZ2HJmbXJ3xgYjFxGt1qyUQ0YuQ1eKU0a61eDBCRgQVoUqWQ87IsOarkibQk/k6FVrveU77PP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ehr5vuED; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ea0a6856d7so1700556a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849749; x=1713454549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkPTmdYa0NVAfZgA4fYak80NgcdUuBNPKt68PwI0710=;
        b=Ehr5vuEDh5bXewJUoE3XJKxBZVXGwtw+Z4aRxBoUCCbwXHRK/bjG5BKE6gau2usQck
         3eAfk5d1sTXUA+D8BCare7V1ZplTL9xMWo/52MzLr6ud4oRnFhWB7AAfHR+p1Ngl/Sr4
         O6B9mHLvovGbA/AuUI8KzDS4K9Pl2odTNndsV1mER2JMNyX/cKoZgSWsxRCqXyhDDjZP
         +Fwyn8lN8Wxh3T/ink1VmNSArEvT02TY89Ru9mxw3pB9n5Xx7UbzWQvAI83zAgEf5yzy
         bfPuIKhUazZAShby44d8S+UO0B/dQgaKu4pS95Zt3hDl9xZcC1xCwg8PchwUb1cfwcBx
         xOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849749; x=1713454549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkPTmdYa0NVAfZgA4fYak80NgcdUuBNPKt68PwI0710=;
        b=qv5wKN5qyf0UaoqpEGe4/dR5d93qsPV75ZIrDBWdOmNo1DtveM9gDOLj9ceJwJyFmq
         b0u8RYHnyhbGLL5KodJKwh6zPKzEoz9R0UUH5hKRZ1muAub9krerMRIbehjeohUJlXno
         zBcmrRO2mDboXnYD+3bFwAXsIjlvCYbfbhCtRmob/OMIwwReueXrEKd7qXdy3srHk/LS
         gZMm1m+Cnt2Gbxo9UeD+diS3mgkzVYxE9yj8oUodJkMGYjpXii7XtUpX4x6P9XlFXGuC
         KfD443t05k2SocytwSoW1VOb9G1lphM/+FiR0ZYFLzYQopoGktNm+sJ0CsUF96Zhaemr
         MIIQ==
X-Gm-Message-State: AOJu0YyHwyR7eSQiPsN5AoS3+oiKxpPk39T99AIjZD7TDuL504Py/4Yx
	VceTv7DOke9ikRuvmgwwSS+QwVMev2FOAbd/bEEcBen63TpOn1DnUBgEk/PWk5Ipps4pmAfpTmU
	e
X-Google-Smtp-Source: AGHT+IG8214VbyUlYg7XKe57Uj75uMdl4GEfTYEL2hYMaipL5RndjMlcSeUPIGaXXOp2+9FTDAxYdg==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr181783iov.2.1712849729470;
        Thu, 11 Apr 2024 08:35:29 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 136/437] drm: switch drm_read() to be iterator based
Date: Thu, 11 Apr 2024 09:14:36 -0600
Message-ID: <20240411153126.16201-137-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First step of converting the GPU drivers to using read/write iterators,
convert the common file read helper to be iter based.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 drivers/gpu/drm/drm_file.c              | 22 ++++++++++------------
 drivers/gpu/drm/gma500/psb_drv.c        |  2 +-
 drivers/gpu/drm/i915/i915_driver.c      |  2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  2 +-
 drivers/gpu/drm/radeon/radeon_drv.c     |  2 +-
 drivers/gpu/drm/tegra/drm.c             |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  2 +-
 drivers/gpu/drm/xe/xe_device.c          |  2 +-
 include/drm/drm_accel.h                 |  2 +-
 include/drm/drm_file.h                  |  3 +--
 include/drm/drm_gem.h                   |  2 +-
 include/drm/drm_gem_dma_helper.h        |  2 +-
 13 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 80b9642f2bc4..d2369e852702 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2863,7 +2863,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
 	.unlocked_ioctl = amdgpu_drm_ioctl,
 	.mmap = drm_gem_mmap,
 	.poll = drm_poll,
-	.read = drm_read,
+	.read_iter = drm_read,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = amdgpu_kms_compat_ioctl,
 #endif
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 638ffa4444f5..c5965b5a1afc 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -110,7 +110,7 @@ bool drm_dev_needs_global_mutex(struct drm_device *dev)
  *             .unlocked_ioctl = drm_ioctl,
  *             .compat_ioctl = drm_compat_ioctl, // NULL if CONFIG_COMPAT=n
  *             .poll = drm_poll,
- *             .read = drm_read,
+ *             .read_iter = drm_read,
  *             .llseek = no_llseek,
  *             .mmap = drm_gem_mmap,
  *     };
@@ -515,18 +515,16 @@ EXPORT_SYMBOL(drm_release_noglobal);
 
 /**
  * drm_read - read method for DRM file
- * @filp: file pointer
- * @buffer: userspace destination pointer for the read
- * @count: count in bytes to read
- * @offset: offset to read
+ * @iocb: metadata for IO
+ * @to: userspace destination pointer for the read
  *
  * This function must be used by drivers as their &file_operations.read
  * method if they use DRM events for asynchronous signalling to userspace.
  * Since events are used by the KMS API for vblank and page flip completion this
  * means all modern display drivers must use it.
  *
- * @offset is ignored, DRM events are read like a pipe. Polling support is
- * provided by drm_poll().
+ * offset in @iocb is ignored, DRM events are read like a pipe. Polling support
+ * is provided by drm_poll().
  *
  * This function will only ever read a full event. Therefore userspace must
  * supply a big enough buffer to fit any event to ensure forward progress. Since
@@ -538,11 +536,11 @@ EXPORT_SYMBOL(drm_release_noglobal);
  * Number of bytes read (always aligned to full events, and can be 0) or a
  * negative error code on failure.
  */
-ssize_t drm_read(struct file *filp, char __user *buffer,
-		 size_t count, loff_t *offset)
+ssize_t drm_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct drm_file *file_priv = filp->private_data;
+	struct drm_file *file_priv = iocb->ki_filp->private_data;
 	struct drm_device *dev = file_priv->minor->dev;
+	size_t count = iov_iter_count(to);
 	ssize_t ret;
 
 	ret = mutex_lock_interruptible(&file_priv->event_read_lock);
@@ -565,7 +563,7 @@ ssize_t drm_read(struct file *filp, char __user *buffer,
 			if (ret)
 				break;
 
-			if (filp->f_flags & O_NONBLOCK) {
+			if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 				ret = -EAGAIN;
 				break;
 			}
@@ -591,7 +589,7 @@ ssize_t drm_read(struct file *filp, char __user *buffer,
 				break;
 			}
 
-			if (copy_to_user(buffer + ret, e->event, length)) {
+			if (!copy_to_iter_full(e->event, length, to)) {
 				if (ret == 0)
 					ret = -EFAULT;
 				goto put_back_event;
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 8b64f61ffaf9..7489d64bea98 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -497,7 +497,7 @@ static const struct file_operations psb_gem_fops = {
 	.compat_ioctl = drm_compat_ioctl,
 	.mmap = drm_gem_mmap,
 	.poll = drm_poll,
-	.read = drm_read,
+	.read_iter = drm_read,
 };
 
 static const struct drm_driver driver = {
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 4b9233c07a22..a8328ee685e8 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1729,7 +1729,7 @@ static const struct file_operations i915_driver_fops = {
 	.unlocked_ioctl = drm_ioctl,
 	.mmap = i915_gem_mmap,
 	.poll = drm_poll,
-	.read = drm_read,
+	.read_iter = drm_read,
 	.compat_ioctl = i915_ioc32_compat_ioctl,
 	.llseek = noop_llseek,
 #ifdef CONFIG_PROC_FS
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index a947e1d5f309..6b626d62781c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1269,7 +1269,7 @@ nouveau_driver_fops = {
 	.unlocked_ioctl = nouveau_drm_ioctl,
 	.mmap = drm_gem_mmap,
 	.poll = drm_poll,
-	.read = drm_read,
+	.read_iter = drm_read,
 #if defined(CONFIG_COMPAT)
 	.compat_ioctl = nouveau_compat_ioctl,
 #endif
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 7bf08164140e..7011ef3475a7 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -516,7 +516,7 @@ static const struct file_operations radeon_driver_kms_fops = {
 	.unlocked_ioctl = radeon_drm_ioctl,
 	.mmap = drm_gem_mmap,
 	.poll = drm_poll,
-	.read = drm_read,
+	.read_iter = drm_read,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = radeon_kms_compat_ioctl,
 #endif
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 03d1c76aec2d..f455aa8339a3 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -798,7 +798,7 @@ static const struct file_operations tegra_drm_fops = {
 	.unlocked_ioctl = drm_ioctl,
 	.mmap = tegra_drm_mmap,
 	.poll = drm_poll,
-	.read = drm_read,
+	.read_iter = drm_read,
 	.compat_ioctl = drm_compat_ioctl,
 	.llseek = noop_llseek,
 };
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index c7d90f96d16a..fb68d49cff51 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1605,7 +1605,7 @@ static const struct file_operations vmwgfx_driver_fops = {
 	.unlocked_ioctl = vmw_unlocked_ioctl,
 	.mmap = drm_gem_mmap,
 	.poll = drm_poll,
-	.read = drm_read,
+	.read_iter = drm_read,
 #if defined(CONFIG_COMPAT)
 	.compat_ioctl = vmw_compat_ioctl,
 #endif
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index d32ff3857e65..98ae007febe9 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -143,7 +143,7 @@ static const struct file_operations xe_driver_fops = {
 	.unlocked_ioctl = drm_ioctl,
 	.mmap = drm_gem_mmap,
 	.poll = drm_poll,
-	.read = drm_read,
+	.read_iter = drm_read,
 	.compat_ioctl = drm_compat_ioctl,
 	.llseek = noop_llseek,
 #ifdef CONFIG_PROC_FS
diff --git a/include/drm/drm_accel.h b/include/drm/drm_accel.h
index f4d3784b1dce..c757e0b1db46 100644
--- a/include/drm/drm_accel.h
+++ b/include/drm/drm_accel.h
@@ -26,7 +26,7 @@
 	.unlocked_ioctl	= drm_ioctl,\
 	.compat_ioctl	= drm_compat_ioctl,\
 	.poll		= drm_poll,\
-	.read		= drm_read,\
+	.read_iter	= drm_read,\
 	.llseek		= noop_llseek, \
 	.mmap		= drm_gem_mmap
 
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index ab230d3af138..19917ff0090c 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -436,8 +436,7 @@ void drm_file_update_pid(struct drm_file *);
 
 int drm_open(struct inode *inode, struct file *filp);
 int drm_open_helper(struct file *filp, struct drm_minor *minor);
-ssize_t drm_read(struct file *filp, char __user *buffer,
-		 size_t count, loff_t *offset);
+ssize_t drm_read(struct kiocb *iocb, struct iov_iter *to);
 int drm_release(struct inode *inode, struct file *filp);
 int drm_release_noglobal(struct inode *inode, struct file *filp);
 __poll_t drm_poll(struct file *filp, struct poll_table_struct *wait);
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 2ebec3984cd4..29fe86ce8266 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -445,7 +445,7 @@ struct drm_gem_object {
 	.unlocked_ioctl	= drm_ioctl,\
 	.compat_ioctl	= drm_compat_ioctl,\
 	.poll		= drm_poll,\
-	.read		= drm_read,\
+	.read_iter	= drm_read,\
 	.llseek		= noop_llseek,\
 	.mmap		= drm_gem_mmap
 
diff --git a/include/drm/drm_gem_dma_helper.h b/include/drm/drm_gem_dma_helper.h
index a827bde494f6..907acd2b89fa 100644
--- a/include/drm/drm_gem_dma_helper.h
+++ b/include/drm/drm_gem_dma_helper.h
@@ -264,7 +264,7 @@ unsigned long drm_gem_dma_get_unmapped_area(struct file *filp,
 		.unlocked_ioctl	= drm_ioctl,\
 		.compat_ioctl	= drm_compat_ioctl,\
 		.poll		= drm_poll,\
-		.read		= drm_read,\
+		.read_iter	= drm_read,\
 		.llseek		= noop_llseek,\
 		.mmap		= drm_gem_mmap,\
 		DRM_GEM_DMA_UNMAPPED_AREA_FOPS \
-- 
2.43.0


