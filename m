Return-Path: <linux-kernel+bounces-141082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922718A1A62
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33841C22DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092F61DA018;
	Thu, 11 Apr 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vWllT8Zg"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE97B1D9FE9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850012; cv=none; b=s/PWN94aKPR0qmqR+P0xoRBvvp1U3OI05xN+LAvkRkFuJiym+0CapfdR8Lgi6WB0bwxz74AtSdndTPt4DfxfJnR4KxrM3SsWn+TaZ0liMUzrPNlHRYF2l3Waj3qPRatr0IPZI/3/iyujC+/eXbOM+gP1/v4WDPBk6tX64QSq0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850012; c=relaxed/simple;
	bh=81o1xwCWI7QUW1NUuq50pKwEnOx+bczsgQ9nD2Ts4AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRkhmglFEfHKMW6LfriX6rkysJUVEsLZVPwJdby2aSWsVBDmR0cL2oZK8o0u5WK54KzB2QImvEZB8zbY7AjkoMGvirYjtngRoXnv5iLyLEIewWv4mYEc16GHAptEbwBIuWuE3auEJ+SSNc5J3iGAkwzCSMy2fIN4O2MCunVeoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vWllT8Zg; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9873139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850009; x=1713454809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuDxFagP4f8c7YjTC6jiq88QiKjLYnfBuV0irVWBJJc=;
        b=vWllT8ZgEssssroL1Bv/gqM0YyNkEO9kn/0LyQaBO9qUEtTXSdMcshdwltnjn6Bc+i
         dGllg9eoPauT92GhFoo79Vx1cVFt54ZPAONPi9Ki8BWjZy83sUW4Vf86M5YjmDc+D35v
         PWbAjHShnMEAxQ9ZH3Xq7oGX0Xq34mV3kSiSWVlSiZrDZJWya4mY3ZGm5xkqSVnjim86
         swzmYFOwLXBGrr1on3crD0elkU/WOcAg7cM36fFHI1PSKJh/R74YGTKrLmIT1Nm2fMrG
         83gyeW6nlHAKyfSWnk2NDcIzy1FpUzUyvl0RBegVtjQh205dDkVgzYigjw1BuI+W9dLz
         tSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850009; x=1713454809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuDxFagP4f8c7YjTC6jiq88QiKjLYnfBuV0irVWBJJc=;
        b=O0rirjHO2gGmQj6vEiOh2S2/wyhudL+YtYS4mmb5YnMP9vcrgNKOuzHViYrpCYT7M2
         6n9/kz2/6fkPoBWL73oDthWuLTJmTjcFJW6snXd9frbsVKLsxU+fi+dvIV2IO0i6oypV
         vzn5cWvZUVaX4eVVoASbGZ3RdhDg2WbvI8RCOUn7q483iZuv3RXH3NKIT21elrflPDbk
         FVbzgag2EWS6z1Rbz8cztR9yi3Vch2jnNc3fOWxUSWE6ziZxdb9IVT8vyZRmEz5gOfAf
         2cZ6lQ519PemQzEgChjFtGSuiQyzylVw2HDqW8/7tHlkMoQkxwcH9xrDga6peJdmkKzT
         Ww0g==
X-Gm-Message-State: AOJu0YzyWjMYos+//WERXM9OaSB/OD0tTmyLxA0bOJXZaA8dOqLa0KMi
	Lrocv7j6OLYBh65J6PrPXRQPq1HOaGejDzYCuGKgYkiLsg3hJIR/JjVdeXtf0tOu0lNJLXpUT3v
	y
X-Google-Smtp-Source: AGHT+IFPNVfBXRzQzx98zmJ5Pt44LWa+UlZ3eOHDpmIIQmaoBxTcBLh0IHeBoHo9WoLUxUjsaExnIw==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr229498iof.0.1712850008720;
        Thu, 11 Apr 2024 08:40:08 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 306/437] drivers/net/wireless/broadcom: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:26 -0600
Message-ID: <20240411153126.16201-307-axboe@kernel.dk>
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
 drivers/net/wireless/broadcom/b43/debugfs.c   | 30 +++++++++---------
 .../net/wireless/broadcom/b43legacy/debugfs.c | 31 +++++++++----------
 .../broadcom/brcm80211/brcmfmac/core.c        | 10 +++---
 .../broadcom/brcm80211/brcmsmac/debug.c       |  2 +-
 4 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/debugfs.c b/drivers/net/wireless/broadcom/b43/debugfs.c
index efa98444e3fb..bd82fc337500 100644
--- a/drivers/net/wireless/broadcom/b43/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43/debugfs.c
@@ -487,8 +487,7 @@ static ssize_t loctls_read_file(struct b43_wldev *dev,
 
 #undef fappend
 
-static ssize_t b43_debugfs_read(struct file *file, char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t b43_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct b43_wldev *dev;
 	struct b43_debugfs_fops *dfops;
@@ -497,11 +496,12 @@ static ssize_t b43_debugfs_read(struct file *file, char __user *userbuf,
 	char *buf;
 	const size_t bufsize = 1024 * 16; /* 16 kiB buffer */
 	const size_t buforder = get_order(bufsize);
+	size_t count = iov_iter_count(to);
 	int err = 0;
 
 	if (!count)
 		return 0;
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 	if (!dev)
 		return -ENODEV;
 
@@ -511,7 +511,7 @@ static ssize_t b43_debugfs_read(struct file *file, char __user *userbuf,
 		goto out_unlock;
 	}
 
-	dfops = container_of(debugfs_real_fops(file),
+	dfops = container_of(debugfs_real_fops(iocb->ki_filp),
 			     struct b43_debugfs_fops, fops);
 	if (!dfops->read) {
 		err = -ENOSYS;
@@ -536,10 +536,9 @@ static ssize_t b43_debugfs_read(struct file *file, char __user *userbuf,
 		dfile->buffer = buf;
 	}
 
-	ret = simple_read_from_buffer(userbuf, count, ppos,
-				      dfile->buffer,
-				      dfile->data_len);
-	if (*ppos >= dfile->data_len) {
+	ret = simple_copy_to_iter(dfile->buffer, &iocb->ki_pos, dfile->data_len,
+				  to);
+	if (iocb->ki_pos >= dfile->data_len) {
 		free_pages((unsigned long)dfile->buffer, buforder);
 		dfile->buffer = NULL;
 		dfile->data_len = 0;
@@ -550,12 +549,11 @@ static ssize_t b43_debugfs_read(struct file *file, char __user *userbuf,
 	return err ? err : ret;
 }
 
-static ssize_t b43_debugfs_write(struct file *file,
-				 const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t b43_debugfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct b43_wldev *dev;
 	struct b43_debugfs_fops *dfops;
+	size_t count = iov_iter_count(from);
 	char *buf;
 	int err = 0;
 
@@ -563,7 +561,7 @@ static ssize_t b43_debugfs_write(struct file *file,
 		return 0;
 	if (count > PAGE_SIZE)
 		return -E2BIG;
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 	if (!dev)
 		return -ENODEV;
 
@@ -573,7 +571,7 @@ static ssize_t b43_debugfs_write(struct file *file,
 		goto out_unlock;
 	}
 
-	dfops = container_of(debugfs_real_fops(file),
+	dfops = container_of(debugfs_real_fops(iocb->ki_filp),
 			     struct b43_debugfs_fops, fops);
 	if (!dfops->write) {
 		err = -ENOSYS;
@@ -585,7 +583,7 @@ static ssize_t b43_debugfs_write(struct file *file,
 		err = -ENOMEM;
 		goto out_unlock;
 	}
-	if (copy_from_user(buf, userbuf, count)) {
+	if (!copy_from_iter_full(buf, count, from)) {
 		err = -EFAULT;
 		goto out_freepage;
 	}
@@ -608,8 +606,8 @@ static ssize_t b43_debugfs_write(struct file *file,
 		.write	= _write,				\
 		.fops	= {					\
 			.open	= simple_open,			\
-			.read	= b43_debugfs_read,		\
-			.write	= b43_debugfs_write,		\
+			.read_iter	= b43_debugfs_read,	\
+			.write_iter	= b43_debugfs_write,	\
 			.llseek = generic_file_llseek,		\
 		},						\
 		.file_struct_offset = offsetof(struct b43_dfsentry, \
diff --git a/drivers/net/wireless/broadcom/b43legacy/debugfs.c b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
index 6b0e8d117061..3746e2fab874 100644
--- a/drivers/net/wireless/broadcom/b43legacy/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
@@ -184,8 +184,7 @@ static int restart_write_file(struct b43legacy_wldev *dev, const char *buf, size
 
 #undef fappend
 
-static ssize_t b43legacy_debugfs_read(struct file *file, char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t b43legacy_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct b43legacy_wldev *dev;
 	struct b43legacy_debugfs_fops *dfops;
@@ -194,11 +193,12 @@ static ssize_t b43legacy_debugfs_read(struct file *file, char __user *userbuf,
 	char *buf;
 	const size_t bufsize = 1024 * 16; /* 16 KiB buffer */
 	const size_t buforder = get_order(bufsize);
+	size_t count = iov_iter_count(to);
 	int err = 0;
 
 	if (!count)
 		return 0;
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 	if (!dev)
 		return -ENODEV;
 
@@ -208,7 +208,7 @@ static ssize_t b43legacy_debugfs_read(struct file *file, char __user *userbuf,
 		goto out_unlock;
 	}
 
-	dfops = container_of(debugfs_real_fops(file),
+	dfops = container_of(debugfs_real_fops(iocb->ki_filp),
 			     struct b43legacy_debugfs_fops, fops);
 	if (!dfops->read) {
 		err = -ENOSYS;
@@ -238,10 +238,9 @@ static ssize_t b43legacy_debugfs_read(struct file *file, char __user *userbuf,
 		dfile->buffer = buf;
 	}
 
-	ret = simple_read_from_buffer(userbuf, count, ppos,
-				      dfile->buffer,
-				      dfile->data_len);
-	if (*ppos >= dfile->data_len) {
+	ret = simple_copy_to_iter(dfile->buffer, &iocb->ki_pos,
+				  dfile->data_len, to);
+	if (iocb->ki_pos >= dfile->data_len) {
 		free_pages((unsigned long)dfile->buffer, buforder);
 		dfile->buffer = NULL;
 		dfile->data_len = 0;
@@ -252,12 +251,12 @@ static ssize_t b43legacy_debugfs_read(struct file *file, char __user *userbuf,
 	return err ? err : ret;
 }
 
-static ssize_t b43legacy_debugfs_write(struct file *file,
-				 const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t b43legacy_debugfs_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
 	struct b43legacy_wldev *dev;
 	struct b43legacy_debugfs_fops *dfops;
+	size_t count = iov_iter_count(from);
 	char *buf;
 	int err = 0;
 
@@ -265,7 +264,7 @@ static ssize_t b43legacy_debugfs_write(struct file *file,
 		return 0;
 	if (count > PAGE_SIZE)
 		return -E2BIG;
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 	if (!dev)
 		return -ENODEV;
 
@@ -275,7 +274,7 @@ static ssize_t b43legacy_debugfs_write(struct file *file,
 		goto out_unlock;
 	}
 
-	dfops = container_of(debugfs_real_fops(file),
+	dfops = container_of(debugfs_real_fops(iocb->ki_filp),
 			     struct b43legacy_debugfs_fops, fops);
 	if (!dfops->write) {
 		err = -ENOSYS;
@@ -287,7 +286,7 @@ static ssize_t b43legacy_debugfs_write(struct file *file,
 		err = -ENOMEM;
 		goto out_unlock;
 	}
-	if (copy_from_user(buf, userbuf, count)) {
+	if (!copy_from_iter_full(buf, count, from)) {
 		err = -EFAULT;
 		goto out_freepage;
 	}
@@ -315,8 +314,8 @@ static ssize_t b43legacy_debugfs_write(struct file *file,
 		.write	= _write,				\
 		.fops	= {					\
 			.open	= simple_open,				\
-			.read	= b43legacy_debugfs_read,		\
-			.write	= b43legacy_debugfs_write,		\
+			.read_iter	= b43legacy_debugfs_read,	\
+			.write_iter	= b43legacy_debugfs_write,	\
 			.llseek = generic_file_llseek,			\
 		},						\
 		.file_struct_offset = offsetof(struct b43legacy_dfsentry, \
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index bf91b1e1368f..d02dd7944bad 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1165,13 +1165,13 @@ static void brcmf_core_bus_reset(struct work_struct *work)
 	brcmf_bus_reset(drvr->bus_if);
 }
 
-static ssize_t bus_reset_write(struct file *file, const char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t bus_reset_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct brcmf_pub *drvr = file->private_data;
+	struct brcmf_pub *drvr = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u8 value;
 
-	if (kstrtou8_from_user(user_buf, count, 0, &value))
+	if (kstrtou8_from_iter(from, count, 0, &value))
 		return -EINVAL;
 
 	if (value != 1)
@@ -1185,7 +1185,7 @@ static ssize_t bus_reset_write(struct file *file, const char __user *user_buf,
 static const struct file_operations bus_reset_fops = {
 	.open	= simple_open,
 	.llseek	= no_llseek,
-	.write	= bus_reset_write,
+	.write_iter	= bus_reset_write,
 };
 
 static int brcmf_bus_started(struct brcmf_pub *drvr, struct cfg80211_ops *ops)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
index 6d776ef6ff54..cfc7ff6d3503 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
@@ -182,7 +182,7 @@ static const struct file_operations brcms_debugfs_def_ops = {
 	.owner = THIS_MODULE,
 	.open = brcms_debugfs_entry_open,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek
 };
 
-- 
2.43.0


