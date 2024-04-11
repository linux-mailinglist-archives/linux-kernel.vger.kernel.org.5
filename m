Return-Path: <linux-kernel+bounces-140878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7178A1957
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951611F2159F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE90153567;
	Thu, 11 Apr 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="N/i8nAnv"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9B9152E04
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849696; cv=none; b=sMZYQW7HC8VKBNr6422ZmTrSVeyoAYO4Qfo2/CgbtmTPToaztg5whNR4XDQ/lCUvGhWRJmR/9jnN8/wyKpKHr6xsFkWAHgwh5vnzgtC3Gn6NmuynOBO5RDtmTkOGsbMs0Kc+/JzkZasGLdOYZaQGCFJ+quUF+nkTmBJxbxRFfis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849696; c=relaxed/simple;
	bh=nXG6kmHwiCRrbEqLKviUTLqC6axTR20XWmy6QjwpAc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0JhJcXoiEBgCBY3zABDgKf1a25llTJf7KllrsMWkLugkaqXwVSbDFcVpI2jsg4E6h3KWMiZAv9jKpu1HYM/NvAS67SDMdawN4dezHvOtwKJUAiaeLAz/GGH77N9BI6Ck2tL2CQGenU9/PcWrfprwYb9ZDNX15B/UfyT2sAavPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=N/i8nAnv; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8919639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849694; x=1713454494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5CU/zKW6n1HMZWhlDK5mPBQ7RFUZIy9M1CWJFuC0s4=;
        b=N/i8nAnvhkEZyyAWXSXnNhIAHKW7l5KvG4rFba+nAFUsNBVCh8Hb/YfM/dkUopXMGn
         YhyzZ6sd1K8Jcvd5/YH+jlsJoPAKqJIDCvL2lNKjy56kHbdoxFODO2F07F+qSCI0J5UB
         iEJqcZiEsve79sB0HMlysLp2HDgg2ChN5I9Oktoduvm8bLejbyVehgzKxnyetqawyBnv
         pc1eg20+UnVt/uVEGe/WtlZeO+yOaW7S+Ovvo9Fm9nYMmQqRHdcRc6PC/zMK3K2SfndN
         WQPjGt3juD+BNw3suLQB4Bz6R6UqgKc/gseSgd4sUxHxWn2TlyWcMMo4M5VqOQwzwwmS
         Ro6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849694; x=1713454494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5CU/zKW6n1HMZWhlDK5mPBQ7RFUZIy9M1CWJFuC0s4=;
        b=kGrpwXKF4VV744d+T0Rm2GXE0aCkPgZaoo4P6+I5y++OehLthY3KQ1ALnk8U/EiMpj
         qADwD8sG3Tg4GEmo5gkJDgFtSW7Va7FUHqTmKE6oucEHm9dZlejTTGibB5JQ+Xbs1J06
         UUjcN/+oMlHL+d+7AcVYJCW+bz7ExWSLlbnZO3C6rVHa935mCs0jJKOjcfOaWUZXxnw6
         2890niMWC/pEMB6kN4/OU6Je3bvV9wSbunhsnrUT3d4hpjMvCucfDZ/7J2MhfehUr63q
         IAulVn+QtVtO1QHTY3/J3suOrBp4XRDiFdsTMVN7QLdH8XKj5KSFKRYfpGiEu+v9tDNE
         XXcQ==
X-Gm-Message-State: AOJu0Yz781kHB+72RrCEOFgKrJMTnoETVFVSoctF2+dX26ux7Atc1myW
	jGTTX/nNWF0xqCBA8MbWhHjqG5gTuvzV9LxrjkdgrjDDWSi3yj8+u9v35dN9ZFG3zs6ysitD/kA
	M
X-Google-Smtp-Source: AGHT+IEI1DOAvTPk+XTInq1BBJ2Q6LYW1F0iuRSAV2ebh5YEShM+SIMT+8m+Y6OY1L5JZeddst91qQ==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr219075ioh.0.1712849693826;
        Thu, 11 Apr 2024 08:34:53 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 114/437] fs/efivars: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:14 -0600
Message-ID: <20240411153126.16201-115-axboe@kernel.dk>
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
 fs/efivarfs/file.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 7e9961639802..b53246e728a5 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -12,13 +12,13 @@
 
 #include "internal.h"
 
-static ssize_t efivarfs_file_write(struct file *file,
-		const char __user *userbuf, size_t count, loff_t *ppos)
+static ssize_t efivarfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct efivar_entry *var = file->private_data;
+	struct efivar_entry *var = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	void *data;
 	u32 attributes;
-	struct inode *inode = file->f_mapping->host;
+	struct inode *inode = iocb->ki_filp->f_mapping->host;
 	unsigned long datasize = count - sizeof(attributes);
 	ssize_t bytes;
 	bool set = false;
@@ -26,13 +26,13 @@ static ssize_t efivarfs_file_write(struct file *file,
 	if (count < sizeof(attributes))
 		return -EINVAL;
 
-	if (copy_from_user(&attributes, userbuf, sizeof(attributes)))
+	if (!copy_from_iter_full(&attributes, sizeof(attributes), from))
 		return -EFAULT;
 
 	if (attributes & ~(EFI_VARIABLE_MASK))
 		return -EINVAL;
 
-	data = memdup_user(userbuf + sizeof(attributes), datasize);
+	data = iterdup(from, datasize);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
@@ -46,8 +46,8 @@ static ssize_t efivarfs_file_write(struct file *file,
 
 	if (bytes == -ENOENT) {
 		drop_nlink(inode);
-		d_delete(file->f_path.dentry);
-		dput(file->f_path.dentry);
+		d_delete(iocb->ki_filp->f_path.dentry);
+		dput(iocb->ki_filp->f_path.dentry);
 	} else {
 		inode_lock(inode);
 		i_size_write(inode, datasize + sizeof(attributes));
@@ -63,17 +63,16 @@ static ssize_t efivarfs_file_write(struct file *file,
 	return bytes;
 }
 
-static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
-		size_t count, loff_t *ppos)
+static ssize_t efivarfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct efivar_entry *var = file->private_data;
+	struct efivar_entry *var = iocb->ki_filp->private_data;
 	unsigned long datasize = 0;
 	u32 attributes;
 	void *data;
 	ssize_t size = 0;
 	int err;
 
-	while (!__ratelimit(&file->f_cred->user->ratelimit))
+	while (!__ratelimit(&iocb->ki_filp->f_cred->user->ratelimit))
 		msleep(50);
 
 	err = efivar_entry_size(var, &datasize);
@@ -98,8 +97,8 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 		goto out_free;
 
 	memcpy(data, &attributes, sizeof(attributes));
-	size = simple_read_from_buffer(userbuf, count, ppos,
-				       data, datasize + sizeof(attributes));
+	size = simple_copy_to_iter(data, &iocb->ki_pos,
+				   datasize + sizeof(attributes), to);
 out_free:
 	kfree(data);
 
@@ -108,7 +107,7 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 
 const struct file_operations efivarfs_file_operations = {
 	.open	= simple_open,
-	.read	= efivarfs_file_read,
-	.write	= efivarfs_file_write,
+	.read_iter	= efivarfs_file_read,
+	.write_iter	= efivarfs_file_write,
 	.llseek	= no_llseek,
 };
-- 
2.43.0


