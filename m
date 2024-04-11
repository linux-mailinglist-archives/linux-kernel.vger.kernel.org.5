Return-Path: <linux-kernel+bounces-140796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4638A1902
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DCD1F2061E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9816D5645E;
	Thu, 11 Apr 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x3a0h8Ow"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94C17BD5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849557; cv=none; b=nb9k9o69j7mYvlWc03imHkq2DWFvIY5jhSmlv3vX7Wz9gyEKyOchs2W32S0O4t0VALd3bfOHRG4qminD/qzihaMsSjSFhawB68b/X5ukh5ulixz28cZxXdGQdbH/8eq1x/5ADZHf8P9niVfFgMg/IIhCBmt51FFz75utIOdhx7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849557; c=relaxed/simple;
	bh=6nXHrJxwgebxvbIYQmXJeHY8zamN//PeVWbXFLxfhZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKzQHf2tnC/jbQ5mr/dGIbAiaJPP/dnOnku4+K5mhPsxVKLItxdF9FmMzBPbWxD7D0CKx9O4Ynusf00orezo5GFPhKQSQUmta1m4S2+oqn6G3eXNfPCogAMwWjAA0snDj5udnvI9AfrteJaKgn63JPUg1UfhVwXLctf+v6RtSiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x3a0h8Ow; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8859539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849554; x=1713454354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRZlShq2GjuAkYR6CqTxKx160jv8ehLkEKbZcc7NPRA=;
        b=x3a0h8Ow0E5oI90+yMNeo3tUtBaf+srnVGMj7ampdtiykVwpcjRuAUPEKjcp79Ll3r
         b0eAvBF34EGHgOXo9+d1dUa3YUMD0fYiVXWR+I8vjF3MtqaON52tmAfI6UZPCLUzt7Jy
         Zoh21kfWvO2PeicCQl4CnMmYdoW/oesgYcCJ3Q/LZwXMpuax54rQrycRQ828lim66Pyx
         DJ484IlyqPWtTN4isE61KPYUQxECdb8I957PaJxdJ6CcxsxW3/viSD+UrVnRabMSJ010
         VQ86Z29enh4llBTifI9Pad5p8B+GtA4M6WQj8AlEXFEaVQb/y1i+izx8N/XgdVPHrI7H
         57tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849554; x=1713454354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRZlShq2GjuAkYR6CqTxKx160jv8ehLkEKbZcc7NPRA=;
        b=i43cpbqOgj48vReL48yzFgTmMHH59/RuKBFfbwTQ4PMI9LQYgDDTXQEXFZZyYZ65iS
         8R4YC24OmaBTjCzpm2FkUzAK6eonSsM0n1+yKfhQtVdnW2s5ITUeIkUeRE3Ev6IPv0QU
         qT5SGOAKSJOZJ+9lzwRW7BS/SN1OksQBlZBf9uW6+wzPhDg6vFF7tD+NqD7MK1oDjjhJ
         kFcRCYLPV2soVlB7Mt+uQXl6U5Nd70I3SVVmhnm7rhmJpci93MgYWVcsNs0oLqITep15
         CRDi0IaVGC9SF5+OoGgWkET+1tte/didJo72pAv8u3gqnuBF5d/Oql9s/2yJjdQCI14b
         cpMw==
X-Gm-Message-State: AOJu0YwgETqb93K2yTo7fD97cFIO0wTauIH4mgn2qSRj8WTqbF2+ZLDg
	f61In/qC5VJGUiEEQG52hZ970+yR0PP66ITLciLmuJRVbK+a4n7KUc8Z4mlRTTG2efJhbc2fbUH
	F
X-Google-Smtp-Source: AGHT+IFuxpPSrBf1tMH8EwZa8jOJ2lAJ6UhOZNqDIiUUZBKs1IeLqGXKrVCNCB1w23aH7zn5IL2MVg==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr170355ioj.2.1712849554011;
        Thu, 11 Apr 2024 08:32:34 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 038/437] debugfs: convert to ->read_iter()
Date: Thu, 11 Apr 2024 09:12:58 -0600
Message-ID: <20240411153126.16201-39-axboe@kernel.dk>
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
 arch/powerpc/kernel/dawr.c           |  10 ++-
 drivers/base/regmap/regmap-debugfs.c |  32 ++++++---
 drivers/misc/mei/debugfs.c           |  12 ++--
 fs/debugfs/file.c                    | 104 ++++++++++++++++++---------
 include/linux/debugfs.h              |  24 +++----
 kernel/sched/debug.c                 |   9 ++-
 6 files changed, 114 insertions(+), 77 deletions(-)

diff --git a/arch/powerpc/kernel/dawr.c b/arch/powerpc/kernel/dawr.c
index 909a05cd2809..03ab57564a18 100644
--- a/arch/powerpc/kernel/dawr.c
+++ b/arch/powerpc/kernel/dawr.c
@@ -59,9 +59,7 @@ static void disable_dawrs_cb(void *info)
 		set_dawr(i, &null_brk);
 }
 
-static ssize_t dawr_write_file_bool(struct file *file,
-				    const char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t dawr_write_file_bool(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct arch_hw_breakpoint null_brk = {0};
 	size_t rc;
@@ -72,7 +70,7 @@ static ssize_t dawr_write_file_bool(struct file *file,
 	    set_dawr(0, &null_brk) != H_SUCCESS)
 		return -ENODEV;
 
-	rc = debugfs_write_file_bool(file, user_buf, count, ppos);
+	rc = debugfs_write_file_bool(iocb, from);
 	if (rc)
 		return rc;
 
@@ -84,8 +82,8 @@ static ssize_t dawr_write_file_bool(struct file *file,
 }
 
 static const struct file_operations dawr_enable_fops = {
-	.read =		debugfs_read_file_bool,
-	.write =	dawr_write_file_bool,
+	.read_iter =	debugfs_read_file_bool,
+	.write_iter =	dawr_write_file_bool,
 	.open =		simple_open,
 	.llseek =	default_llseek,
 };
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index fb84cda92a75..571b5c00a28e 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -456,9 +456,9 @@ static int regmap_access_show(struct seq_file *s, void *ignored)
 
 DEFINE_SHOW_ATTRIBUTE(regmap_access);
 
-static ssize_t regmap_cache_only_write_file(struct file *file,
-					    const char __user *user_buf,
-					    size_t count, loff_t *ppos)
+static ssize_t __regmap_cache_only_write_file(struct file *file,
+					      const char __user *user_buf,
+					      size_t count, loff_t *ppos)
 {
 	struct regmap *map = container_of(file->private_data,
 					  struct regmap, cache_only);
@@ -497,15 +497,21 @@ static ssize_t regmap_cache_only_write_file(struct file *file,
 	return count;
 }
 
+static ssize_t regmap_cache_only_write_file(struct kiocb *iocb,
+					    struct iov_iter *from)
+{
+	return vfs_write_iter(iocb, from, __regmap_cache_only_write_file);
+}
+
 static const struct file_operations regmap_cache_only_fops = {
 	.open = simple_open,
-	.read = debugfs_read_file_bool,
-	.write = regmap_cache_only_write_file,
+	.read_iter = debugfs_read_file_bool,
+	.write_iter = regmap_cache_only_write_file,
 };
 
-static ssize_t regmap_cache_bypass_write_file(struct file *file,
-					      const char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t __regmap_cache_bypass_write_file(struct file *file,
+						const char __user *user_buf,
+						size_t count, loff_t *ppos)
 {
 	struct regmap *map = container_of(file->private_data,
 					  struct regmap, cache_bypass);
@@ -537,10 +543,16 @@ static ssize_t regmap_cache_bypass_write_file(struct file *file,
 	return count;
 }
 
+static ssize_t regmap_cache_bypass_write_file(struct kiocb *iocb,
+					      struct iov_iter *from)
+{
+	return vfs_write_iter(iocb, from, __regmap_cache_bypass_write_file);
+}
+
 static const struct file_operations regmap_cache_bypass_fops = {
 	.open = simple_open,
-	.read = debugfs_read_file_bool,
-	.write = regmap_cache_bypass_write_file,
+	.read_iter = debugfs_read_file_bool,
+	.write_iter = regmap_cache_bypass_write_file,
 };
 
 void regmap_debugfs_init(struct regmap *map)
diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
index 3b098d4c8e3d..b2e9fa911817 100644
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@ -133,17 +133,15 @@ static int mei_dbgfs_devstate_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(mei_dbgfs_devstate);
 
-static ssize_t mei_dbgfs_write_allow_fa(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t mei_dbgfs_write_allow_fa(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct mei_device *dev;
 	int ret;
 
-	dev = container_of(file->private_data,
+	dev = container_of(iocb->ki_filp->private_data,
 			   struct mei_device, allow_fixed_address);
 
-	ret = debugfs_write_file_bool(file, user_buf, count, ppos);
+	ret = debugfs_write_file_bool(iocb, from);
 	if (ret < 0)
 		return ret;
 	dev->override_fixed_address = true;
@@ -152,8 +150,8 @@ static ssize_t mei_dbgfs_write_allow_fa(struct file *file,
 
 static const struct file_operations mei_dbgfs_allow_fa_fops = {
 	.open = simple_open,
-	.read = debugfs_read_file_bool,
-	.write = mei_dbgfs_write_allow_fa,
+	.read_iter = debugfs_read_file_bool,
+	.write_iter = mei_dbgfs_write_allow_fa,
 	.llseek = generic_file_llseek,
 };
 
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index c6f4a9a98b85..c6ff9084bc0f 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -26,21 +26,19 @@
 
 struct poll_table_struct;
 
-static ssize_t default_read_file(struct file *file, char __user *buf,
-				 size_t count, loff_t *ppos)
+static ssize_t default_read_file_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
 }
 
-static ssize_t default_write_file(struct file *file, const char __user *buf,
-				   size_t count, loff_t *ppos)
+static ssize_t default_write_file_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	return count;
+	return iov_iter_count(from);
 }
 
 const struct file_operations debugfs_noop_file_operations = {
-	.read =		default_read_file,
-	.write =	default_write_file,
+	.read_iter =	default_read_file_iter,
+	.write_iter =	default_write_file_iter,
 	.open =		simple_open,
 	.llseek =	noop_llseek,
 };
@@ -872,8 +870,9 @@ void debugfs_create_atomic_t(const char *name, umode_t mode,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_atomic_t);
 
-ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t __debugfs_read_file_bool(struct file *file,
+					char __user *user_buf, size_t count,
+					loff_t *ppos)
 {
 	char buf[2];
 	bool val;
@@ -893,10 +892,16 @@ ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
 	buf[1] = '\n';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
 }
+
+ssize_t debugfs_read_file_bool(struct kiocb *iocb, struct iov_iter *to)
+{
+	return vfs_read_iter(iocb, to, __debugfs_read_file_bool);
+}
 EXPORT_SYMBOL_GPL(debugfs_read_file_bool);
 
-ssize_t debugfs_write_file_bool(struct file *file, const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t __debugfs_write_file_bool(struct file *file,
+					 const char __user *user_buf,
+					 size_t count, loff_t *ppos)
 {
 	bool bv;
 	int r;
@@ -914,23 +919,28 @@ ssize_t debugfs_write_file_bool(struct file *file, const char __user *user_buf,
 
 	return count;
 }
+
+ssize_t debugfs_write_file_bool(struct kiocb *iocb, struct iov_iter *from)
+{
+	return vfs_write_iter(iocb, from, __debugfs_write_file_bool);
+}
 EXPORT_SYMBOL_GPL(debugfs_write_file_bool);
 
 static const struct file_operations fops_bool = {
-	.read =		debugfs_read_file_bool,
-	.write =	debugfs_write_file_bool,
+	.read_iter =	debugfs_read_file_bool,
+	.write_iter =	debugfs_write_file_bool,
 	.open =		simple_open,
 	.llseek =	default_llseek,
 };
 
 static const struct file_operations fops_bool_ro = {
-	.read =		debugfs_read_file_bool,
+	.read_iter =	debugfs_read_file_bool,
 	.open =		simple_open,
 	.llseek =	default_llseek,
 };
 
 static const struct file_operations fops_bool_wo = {
-	.write =	debugfs_write_file_bool,
+	.write_iter =	debugfs_write_file_bool,
 	.open =		simple_open,
 	.llseek =	default_llseek,
 };
@@ -957,8 +967,8 @@ void debugfs_create_bool(const char *name, umode_t mode, struct dentry *parent,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_bool);
 
-ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t __debugfs_read_file_str(struct file *file, char __user *user_buf,
+				       size_t count, loff_t *ppos)
 {
 	struct dentry *dentry = F_DENTRY(file);
 	char *str, *copy = NULL;
@@ -991,10 +1001,15 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(debugfs_create_str);
 
-static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+ssize_t debugfs_read_file_str(struct kiocb *iocb, struct iov_iter *to)
+{
+	return vfs_read_iter(iocb, to, __debugfs_read_file_str);
+}
+
+static ssize_t __debugfs_write_file_str(struct file *file,
+					const char __user *user_buf,
+					size_t count, loff_t *ppos)
 {
 	struct dentry *dentry = F_DENTRY(file);
 	char *old, *new = NULL;
@@ -1044,21 +1059,26 @@ static ssize_t debugfs_write_file_str(struct file *file, const char __user *user
 	return r;
 }
 
+static ssize_t debugfs_write_file_str(struct kiocb *iocb, struct iov_iter *from)
+{
+	return vfs_write_iter(iocb, from, __debugfs_write_file_str);
+}
+
 static const struct file_operations fops_str = {
-	.read =		debugfs_read_file_str,
-	.write =	debugfs_write_file_str,
+	.read_iter =	debugfs_read_file_str,
+	.write_iter =	debugfs_write_file_str,
 	.open =		simple_open,
 	.llseek =	default_llseek,
 };
 
 static const struct file_operations fops_str_ro = {
-	.read =		debugfs_read_file_str,
+	.read_iter =	debugfs_read_file_str,
 	.open =		simple_open,
 	.llseek =	default_llseek,
 };
 
 static const struct file_operations fops_str_wo = {
-	.write =	debugfs_write_file_str,
+	.write_iter =	debugfs_write_file_str,
 	.open =		simple_open,
 	.llseek =	default_llseek,
 };
@@ -1083,9 +1103,10 @@ void debugfs_create_str(const char *name, umode_t mode,
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_str,
 				   &fops_str_ro, &fops_str_wo);
 }
+EXPORT_SYMBOL_GPL(debugfs_create_str);
 
-static ssize_t read_file_blob(struct file *file, char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t __read_file_blob(struct file *file, char __user *user_buf,
+				size_t count, loff_t *ppos)
 {
 	struct debugfs_blob_wrapper *blob = file->private_data;
 	struct dentry *dentry = F_DENTRY(file);
@@ -1100,8 +1121,13 @@ static ssize_t read_file_blob(struct file *file, char __user *user_buf,
 	return r;
 }
 
-static ssize_t write_file_blob(struct file *file, const char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t read_file_blob(struct kiocb *iocb, struct iov_iter *to)
+{
+	return vfs_read_iter(iocb, to, __read_file_blob);
+}
+
+static ssize_t __write_file_blob(struct file *file, const char __user *user_buf,
+				 size_t count, loff_t *ppos)
 {
 	struct debugfs_blob_wrapper *blob = file->private_data;
 	struct dentry *dentry = F_DENTRY(file);
@@ -1117,9 +1143,14 @@ static ssize_t write_file_blob(struct file *file, const char __user *user_buf,
 	return r;
 }
 
+static ssize_t write_file_blob(struct kiocb *iocb, struct iov_iter *from)
+{
+	return vfs_write_iter(iocb, from, __write_file_blob);
+}
+
 static const struct file_operations fops_blob = {
-	.read =		read_file_blob,
-	.write =	write_file_blob,
+	.read_iter =	read_file_blob,
+	.write_iter =	write_file_blob,
 	.open =		simple_open,
 	.llseek =	default_llseek,
 };
@@ -1197,8 +1228,8 @@ static int u32_array_open(struct inode *inode, struct file *file)
 	return nonseekable_open(inode, file);
 }
 
-static ssize_t u32_array_read(struct file *file, char __user *buf, size_t len,
-			      loff_t *ppos)
+static ssize_t __u32_array_read(struct file *file, char __user *buf, size_t len,
+				loff_t *ppos)
 {
 	size_t size = strlen(file->private_data);
 
@@ -1206,6 +1237,11 @@ static ssize_t u32_array_read(struct file *file, char __user *buf, size_t len,
 					file->private_data, size);
 }
 
+static ssize_t u32_array_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	return vfs_read_iter(iocb, to, __u32_array_read);
+}
+
 static int u32_array_release(struct inode *inode, struct file *file)
 {
 	kfree(file->private_data);
@@ -1217,7 +1253,7 @@ static const struct file_operations u32_array_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = u32_array_open,
 	.release = u32_array_release,
-	.read	 = u32_array_read,
+	.read_iter = u32_array_read,
 	.llseek  = no_llseek,
 };
 
@@ -1341,7 +1377,7 @@ static const struct file_operations debugfs_devm_entry_ops = {
 	.owner = THIS_MODULE,
 	.open = debugfs_devm_entry_open,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek
 };
 
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index c9c65b132c0f..ad417d079ec9 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -162,14 +162,11 @@ void debugfs_create_devm_seqfile(struct device *dev, const char *name,
 
 bool debugfs_initialized(void);
 
-ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
-			       size_t count, loff_t *ppos);
+ssize_t debugfs_read_file_bool(struct kiocb *iocb, struct iov_iter *to);
 
-ssize_t debugfs_write_file_bool(struct file *file, const char __user *user_buf,
-				size_t count, loff_t *ppos);
+ssize_t debugfs_write_file_bool(struct kiocb *iocb, struct iov_iter *from);
 
-ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
-			      size_t count, loff_t *ppos);
+ssize_t debugfs_read_file_str(struct kiocb *iocb, struct iov_iter *to);
 
 /**
  * struct debugfs_cancellation - cancellation data
@@ -376,23 +373,20 @@ static inline void debugfs_create_devm_seqfile(struct device *dev,
 {
 }
 
-static inline ssize_t debugfs_read_file_bool(struct file *file,
-					     char __user *user_buf,
-					     size_t count, loff_t *ppos)
+static inline ssize_t debugfs_read_file_bool(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
 	return -ENODEV;
 }
 
-static inline ssize_t debugfs_write_file_bool(struct file *file,
-					      const char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static inline ssize_t debugfs_write_file_bool(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
 	return -ENODEV;
 }
 
-static inline ssize_t debugfs_read_file_str(struct file *file,
-					    char __user *user_buf,
-					    size_t count, loff_t *ppos)
+static inline ssize_t debugfs_read_file_str(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
 	return -ENODEV;
 }
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a5834d..686a21ea1791 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -284,8 +284,7 @@ __read_mostly bool sched_debug_verbose;
 static struct dentry           *sd_dentry;
 
 
-static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
-				  size_t cnt, loff_t *ppos)
+static ssize_t sched_verbose_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	ssize_t result;
 	bool orig;
@@ -294,7 +293,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
 	mutex_lock(&sched_domains_mutex);
 
 	orig = sched_debug_verbose;
-	result = debugfs_write_file_bool(filp, ubuf, cnt, ppos);
+	result = debugfs_write_file_bool(iocb, from);
 
 	if (sched_debug_verbose && !orig)
 		update_sched_domain_debugfs();
@@ -313,8 +312,8 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
 #endif
 
 static const struct file_operations sched_verbose_fops = {
-	.read =         debugfs_read_file_bool,
-	.write =        sched_verbose_write,
+	.read_iter =         debugfs_read_file_bool,
+	.write_iter =        sched_verbose_write,
 	.open =         simple_open,
 	.llseek =       default_llseek,
 };
-- 
2.43.0


