Return-Path: <linux-kernel+bounces-141150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F918A1AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57AA2B2B583
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9601F01C1;
	Thu, 11 Apr 2024 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jeW7ahlJ"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A881EECAB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850123; cv=none; b=SuWRZBZJXQkgKIwE88w8iAIylurhPnuKp7rpXr619hPGZOi7KVCwhH0pTCsGPFPKJWD/SCRvetEHtw5dL5NCCavtzNtV5OEzzOQZ99pjHJexY6mBzkQVa8GldwAUdjBLEj8dMPzssBYUgXKJIEMkdgZuKFfagQEgStTImbZ3b7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850123; c=relaxed/simple;
	bh=gRj3REPoA5J9HsD4yzFt3MvjoJNkfnc4hJl5gPoxlr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpLrtpMeIgP8vbiJbdmw4LFvf96aJzR0mz9oGHaRbD3D5+nSxceJUy/4mvd20gP8EbWJMcoP8suimbmOXM3yIjSTVhq6Fg/YeXB3gCOHeEIQfan52qSF+o+51BNobkx5QOs4OapC8kvlcBPhTCFfzAb9uzWIvA9yH/gZGnenNMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jeW7ahlJ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9924539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850121; x=1713454921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPnDG3DXkPCynbQxIlcUx2qxDqxsFsce5uHZ8HouiIU=;
        b=jeW7ahlJtIq0AlBG1m1btscws5vyvf1pNQdaRh2TYEfVw6o3AyXjAHmM4gbi5RLoZa
         /c6ai3yzq3XdIqd8VlvmSFH81lFIH1Cl6Hz63gxcAxBZpSqbNp77u/GBtIT9eKhxrnH6
         bYdde0KUZVClZZtXQf2NqJcelCS4dTM9Gpd1fL1bX/p8NtAd4xv1NnLLBQTY9LN8G73U
         jjYzSxmtMjplcdoHx9LREpt+U5yaq7elzHXRJTCuQLJswJUfgrdOUdJ9nC4xkJcMmY8c
         BrRBajxwC3fCTbUh3KbaN9beLcvWmfzbR7sguSP1QPgBhTYVcEi4RuYticlCP60a5p/6
         OfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850121; x=1713454921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPnDG3DXkPCynbQxIlcUx2qxDqxsFsce5uHZ8HouiIU=;
        b=mkIlAk5WJhdAnnQFXB7falSFndqM0VrWM+4CJqqxqJhH8BYSTI86C7P8keT7womKlZ
         FnVhv/tG0TEZl2R3utzaRW9MWlO3fxlj5Z/R6XVHcicvohrdqStxq2sHPFSB4OFdEvza
         IYxRDZVW6NhqlZb/kry6OHmfZBRExSH0oIQ+wCs0QaxyKVlouwDsHvOjAoB+gQ18xIN8
         R031+6HS4bV+lB4a/2bKhgAryIk7mthz/YXaEHlQdkXXEwKgCnSAzafR5RXGtS5KpzOK
         4IRwXVRqkZoJ343moSciBI8CdQFFA5FFVMxME7NVMZ+IhjQTYvHWNde4nwRGajl5MAN9
         OW9A==
X-Gm-Message-State: AOJu0YxKqzNRivmAaznl0gzN/G2Opk9QXgJf5c+ZbhcsAMMBDietm0D4
	79mc31eWYDPC8/p3iNaKKVMo4rBgACAqjFYqUFfDLYvmvFTeUzFrO5Ep/atLNcAsL/UF0cV5aHf
	z
X-Google-Smtp-Source: AGHT+IGJqD7wNAL8W0OIYu6VilN4aUmcCBVyd2ztnCHrOMzZ+if+qEPAJg2NfVfdZWu5ENOBxjolww==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr208200iop.1.1712850120802;
        Thu, 11 Apr 2024 08:42:00 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 369/437] drivers/mmc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:29 -0600
Message-ID: <20240411153126.16201-370-axboe@kernel.dk>
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
 drivers/mmc/core/block.c    | 10 ++++------
 drivers/mmc/core/debugfs.c  | 11 +++++------
 drivers/mmc/core/mmc_test.c | 12 ++++++------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 90c51b12148e..490cf789de72 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2933,13 +2933,11 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 	return err;
 }
 
-static ssize_t mmc_ext_csd_read(struct file *filp, char __user *ubuf,
-				size_t cnt, loff_t *ppos)
+static ssize_t mmc_ext_csd_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	char *buf = filp->private_data;
+	char *buf = iocb->ki_filp->private_data;
 
-	return simple_read_from_buffer(ubuf, cnt, ppos,
-				       buf, EXT_CSD_STR_LEN);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, EXT_CSD_STR_LEN, to);
 }
 
 static int mmc_ext_csd_release(struct inode *inode, struct file *file)
@@ -2950,7 +2948,7 @@ static int mmc_ext_csd_release(struct inode *inode, struct file *file)
 
 static const struct file_operations mmc_dbg_ext_csd_fops = {
 	.open		= mmc_ext_csd_open,
-	.read		= mmc_ext_csd_read,
+	.read_iter	= mmc_ext_csd_read,
 	.release	= mmc_ext_csd_release,
 	.llseek		= default_llseek,
 };
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 1642ea72d22c..37aa1529f4f8 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -283,21 +283,20 @@ static int mmc_err_stats_open(struct inode *inode, struct file *file)
 	return single_open(file, mmc_err_stats_show, inode->i_private);
 }
 
-static ssize_t mmc_err_stats_write(struct file *filp, const char __user *ubuf,
-				   size_t cnt, loff_t *ppos)
+static ssize_t mmc_err_stats_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mmc_host *host = filp->f_mapping->host->i_private;
+	struct mmc_host *host = iocb->ki_filp->f_mapping->host->i_private;
 
 	pr_debug("%s: Resetting MMC error statistics\n", __func__);
 	memset(host->err_stats, 0, sizeof(host->err_stats));
 
-	return cnt;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations mmc_err_stats_fops = {
 	.open	= mmc_err_stats_open,
-	.read	= seq_read,
-	.write	= mmc_err_stats_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= mmc_err_stats_write,
 	.release = single_release,
 };
 
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 8f7f587a0025..6bbec9154f8a 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3097,16 +3097,16 @@ static int mtf_test_open(struct inode *inode, struct file *file)
 	return single_open(file, mtf_test_show, inode->i_private);
 }
 
-static ssize_t mtf_test_write(struct file *file, const char __user *buf,
-	size_t count, loff_t *pos)
+static ssize_t mtf_test_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *sf = file->private_data;
+	struct seq_file *sf = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct mmc_card *card = sf->private;
 	struct mmc_test_card *test;
 	long testcase;
 	int ret;
 
-	ret = kstrtol_from_user(buf, count, 10, &testcase);
+	ret = kstrtol_from_iter(from, count, 10, &testcase);
 	if (ret)
 		return ret;
 
@@ -3148,8 +3148,8 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 
 static const struct file_operations mmc_test_fops_test = {
 	.open		= mtf_test_open,
-	.read		= seq_read,
-	.write		= mtf_test_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= mtf_test_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-- 
2.43.0


