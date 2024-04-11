Return-Path: <linux-kernel+bounces-140903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BEC8A197F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8AFE284348
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBBE15E5DD;
	Thu, 11 Apr 2024 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cf/dyM1A"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941E15E5A6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849738; cv=none; b=YDMLWnSPNKWQiaCC//n8hIfOYylf/4d4mY2pLs92ZXdqjZM2885ZlUAWh5erCNGOPnPPKR18JC2aGwucMQWaz9BTmZmRhGYU3miW/wJYMyEThqHjVsP1nmv0zn3eHayxOqEHt7jF2i+vt2W3CvJrS2AlmX8n0zRIM/IhYN/a7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849738; c=relaxed/simple;
	bh=61+yP587Hv2kZVBiri1uo5BZsd5AYeB9pXWF/VlKRBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGvApy/bdOVxY7q/oG0/HaysizE5I4EROQ10a95PCemW9YCiEoQa12FlDgyyFobJeGWi0ofg8uhWyOFQieD46xOWkcCLDfh597YC7+/8mEQMjVNLAgJ7GsXjIXqHD5anTD4TCv8ooqMGzdz5kXm8NIiw1dJUY0XJFqL2ZzMxV5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cf/dyM1A; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58054939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849736; x=1713454536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gqaET9MvKn3yE81Z3PAaugQfwNy0GdjyrdNXBZOf+I=;
        b=cf/dyM1AU+jYgQAWy/dRisDdx0Vb/GqnYKNsT7yiapWtCP3X73Qx3LZblYGe40nYLE
         jnb49W4wprIno1P7dfkVJZmLItCTKbJg5+O/PkI1AGREjjUyvRFbehuHQ5RnrJZmLQmW
         TX2uIIDkiErn/uC1q1XnpXGZyxMCRjwl2lsyy4iPTp8SyM6Pu33PoXV4ozh2+A6fZBla
         AXzqr8M8Aql2Tz65ArhJIpdU1EfuKGs2VFQv34U+Gqr9SoKC806Mtaut5T+n7XEeKbuo
         4SprD/z6ATZ1Fn9zOE0+L9bX6Wms9G7C9iSvCnoNEFG/x2PlWvr9/QlfFf4wH/IqfnSp
         bFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849736; x=1713454536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gqaET9MvKn3yE81Z3PAaugQfwNy0GdjyrdNXBZOf+I=;
        b=aSyUIphxzDtkwo9hWVisXp6EutejOXkU2J+0ptzdvNlWRY4p6i9NsaEQEAwZiMV0Fc
         2pVoxp7AEhe8OITGpV3FLe6Vnn0agFlFqZRdjvHn31948fhHnvYWBb8MWikH06zue482
         mQdaV6UMGH1hr2Ra/KRGKS5qI7I5feaKTgcl8qIloJtOuYcq7K03oqjJjToLNzotot78
         VAaZ9jTtnWm91hcixgaB5DsTNm9PoDVN6VcHu6etkv3Vknrw/AYqBAF1cZ+7zDD6HFjL
         cJ0w56rCKcXtqhZ8f4O/g/zNgTo0wG98YSY4ardPyqpaf1LPEktlYZL0WDZnknkjNhSI
         XFlA==
X-Gm-Message-State: AOJu0YzSQJb5hrNT/ykwOKpygC53Wxxl8JGw10eY4elVm9tk4vNmY3LO
	oBDI13oylqJqVAyb+nyVNtone180H1BwCx8Ahz8o43T00c/kUnwdtYFo4Dl5esmm4zhanektbYu
	e
X-Google-Smtp-Source: AGHT+IEDRNpZ9D+Nf1nP2L50ri7PlIzV0hsNxUHJbc3FxrgGyJblu0i2jiMi8AVPB6YAQ9nC5+F27w==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr182239iov.2.1712849735917;
        Thu, 11 Apr 2024 08:35:35 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 141/437] drm: nouveau: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:41 -0600
Message-ID: <20240411153126.16201-142-axboe@kernel.dk>
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

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/gpu/drm/nouveau/dispnv50/crc.c    | 13 ++++++-------
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 12 ++++++------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc.c b/drivers/gpu/drm/nouveau/dispnv50/crc.c
index 9c942fbd836d..a7859e3cb39d 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/crc.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/crc.c
@@ -648,11 +648,9 @@ nv50_crc_debugfs_flip_threshold_open(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-nv50_crc_debugfs_flip_threshold_set(struct file *file,
-				    const char __user *ubuf, size_t len,
-				    loff_t *offp)
+nv50_crc_debugfs_flip_threshold_set(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct nv50_head *head = m->private;
 	struct nv50_head_atom *armh;
 	struct drm_crtc *crtc = &head->base.base;
@@ -660,9 +658,10 @@ nv50_crc_debugfs_flip_threshold_set(struct file *file,
 	struct nv50_crc *crc = &head->crc;
 	const struct nv50_crc_func *func =
 		nv50_disp(crtc->dev)->core->func->crc;
+	size_t len = iov_iter_count(from);
 	int value, ret;
 
-	ret = kstrtoint_from_user(ubuf, len, 10, &value);
+	ret = kstrtoint_from_iter(from, len, 10, &value);
 	if (ret)
 		return ret;
 
@@ -697,8 +696,8 @@ nv50_crc_debugfs_flip_threshold_set(struct file *file,
 static const struct file_operations nv50_crc_flip_threshold_fops = {
 	.owner = THIS_MODULE,
 	.open = nv50_crc_debugfs_flip_threshold_open,
-	.read = seq_read,
-	.write = nv50_crc_debugfs_flip_threshold_set,
+	.read_iter = seq_read_iter,
+	.write_iter = nv50_crc_debugfs_flip_threshold_set,
 	.release = single_release,
 };
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index e83db051e851..02cfac6f6c39 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -139,14 +139,14 @@ nouveau_debugfs_pstate_get(struct seq_file *m, void *data)
 }
 
 static ssize_t
-nouveau_debugfs_pstate_set(struct file *file, const char __user *ubuf,
-			   size_t len, loff_t *offp)
+nouveau_debugfs_pstate_set(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct drm_device *drm = m->private;
 	struct nouveau_debugfs *debugfs = nouveau_debugfs(drm);
 	struct nvif_control_pstate_user_v0 args = { .pwrsrc = -EINVAL };
 	char buf[32] = {}, *tmp, *cur = buf;
+	size_t len = iov_iter_count(from);
 	long value, ret;
 
 	if (!debugfs)
@@ -155,7 +155,7 @@ nouveau_debugfs_pstate_set(struct file *file, const char __user *ubuf,
 	if (len >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, ubuf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 
 	if ((tmp = strchr(buf, '\n')))
@@ -244,8 +244,8 @@ nouveau_debugfs_gpuva(struct seq_file *m, void *data)
 static const struct file_operations nouveau_pstate_fops = {
 	.owner = THIS_MODULE,
 	.open = nouveau_debugfs_pstate_open,
-	.read = seq_read,
-	.write = nouveau_debugfs_pstate_set,
+	.read_iter = seq_read_iter,
+	.write_iter = nouveau_debugfs_pstate_set,
 	.release = single_release,
 };
 
-- 
2.43.0


