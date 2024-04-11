Return-Path: <linux-kernel+bounces-140867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 476258A1946
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA5A1C20E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5102314EC62;
	Thu, 11 Apr 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PTQ5wNR5"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0113CABC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849681; cv=none; b=D10HNNR8ycuJhSK0vGQiVkSC5xv4uDttpWXDpVJoiFSIVzXt85OvyqLBlK4n5MCGQnHdjfWlXhIIersuTIngB2HQ2S9Jt3zvKp+ati/hv5dGHeoyHOjmEPk9baV+GJjUAyIY7ugIpmzxg7W8I7ouuoTnuShmC4IUrLdNClEXiVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849681; c=relaxed/simple;
	bh=k0bXdrDyin3Wj/PM7UMBJF8YF3HORmVehNxhlkCmRj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPf5nT9Qxd+/i+LPhwqrq1lZvAS/K5HKm17asSrApHhni9n/7eeMERy4/1hP1UUloG54VLVOansvfm+IuyWRvUg56iPhGVFVwlmteJv9QASYb0qj4nckoSM6Yye0JVh6Xhz1Q2vS2DI4Lx4UFfI8eEX7Gy6vrtpdDquyUL1JKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PTQ5wNR5; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso180631139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849678; x=1713454478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZdeOU8iSN+e2UssoppSLiJpH0PIhsTs61PcTzwDqgg=;
        b=PTQ5wNR5wW/NhqirbsQOUi+J9W8BX2yiTGOJu2xeXggNJhSqj/mwM906VC0BwrY1Io
         gRJ3xyvQjLtKvZUhFrLoAibI9ou8jAFLeUGNxkGWDaiQo0AeieJxNMeHcpct4g4MVvTo
         OqczYkLRpb5j8nwMya4UwKos6KsNfuFPiKd0eVMdVrjNeFUcn0qVI6jX8PNAe1rhWu75
         v3jl1g7WN72ynS0SBi3mCAP6Qu2eih62TbSaDWffwOPiBb5F4lrABIvtX/iQjJ9wk1AN
         oeez/NXIL551AJW51+PJ4KtCN83QrumM3p9GdU8SvVaRd8DAZRmkdAGRd2vw8pkxu0iM
         rwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849678; x=1713454478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZdeOU8iSN+e2UssoppSLiJpH0PIhsTs61PcTzwDqgg=;
        b=ZdS3dp519LMp5oE4IhWspZFFEK6eT8COeH/PGvH6e72WhIxTlGDIN42pxKI/ZhAaKp
         sEnz9v6q9FdVc9TqZgBLvvg8lxikpGt90Hiitlp0QHB4dvWzCmbeyhsrWLKGN2vxiJNM
         ioffHppIE43V04ZFfqBszbED/L+SPj77FcVhFmLslkHZGnlHSB273KNsPgzYkp6k2PtZ
         KtTVlERhNnA7CyUpyTpQIZef5YxB1iGskGKuCHoFP6iSs28XdNsWJj+a72Rb7+kz36gm
         nzX3JhA9dnV7kQSkWHR1GG2AZJOy8ekt6K0HVVtNADBggor4PEsJTYrqHyyG6bAA5ECU
         ifAQ==
X-Gm-Message-State: AOJu0YwpymOfGH/NO08RFYTyOZ88G4LRy6PTg0RqIkVM1eoGUavSXOAP
	rZpEN+runTx7I/DtfeyCMSphuH8KgvpQO2npJ3AFWS4omokzL07uuD0y7srA9C4ebqmIs20w4dO
	Z
X-Google-Smtp-Source: AGHT+IEh4c5xpLB+IvAopjnun5XyIknJ3RGicPSat6tXdeRMPFvrECS1ttdRBTkeuWv7ecOFqtJn7g==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr181773iob.1.1712849678641;
        Thu, 11 Apr 2024 08:34:38 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 105/437] drivers/acpi: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:05 -0600
Message-ID: <20240411153126.16201-106-axboe@kernel.dk>
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
 drivers/acpi/acpi_dbg.c      |  6 ++++--
 drivers/acpi/apei/erst-dbg.c | 23 ++++++++++++-----------
 drivers/acpi/ec_sys.c        |  6 ++++--
 drivers/acpi/pfr_update.c    |  3 ++-
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index d50261d05f3a..2ee3bc767693 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -638,6 +638,7 @@ static ssize_t acpi_aml_read(struct file *file, char __user *buf,
 	}
 	return size > 0 ? size : ret;
 }
+FOPS_READ_ITER_HELPER(acpi_aml_read);
 
 static int acpi_aml_write_user(const char __user *buf, int len)
 {
@@ -707,6 +708,7 @@ static ssize_t acpi_aml_write(struct file *file, const char __user *buf,
 	}
 	return size > 0 ? size : ret;
 }
+FOPS_WRITE_ITER_HELPER(acpi_aml_write);
 
 static __poll_t acpi_aml_poll(struct file *file, poll_table *wait)
 {
@@ -722,8 +724,8 @@ static __poll_t acpi_aml_poll(struct file *file, poll_table *wait)
 }
 
 static const struct file_operations acpi_aml_operations = {
-	.read		= acpi_aml_read,
-	.write		= acpi_aml_write,
+	.read_iter	= acpi_aml_read_iter,
+	.write_iter	= acpi_aml_write_iter,
 	.poll		= acpi_aml_poll,
 	.open		= acpi_aml_open,
 	.release	= acpi_aml_release,
diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index 8bc71cdc2270..293fac1a2821 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <acpi/apei.h>
 #include <linux/miscdevice.h>
 
@@ -79,20 +80,20 @@ static long erst_dbg_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	}
 }
 
-static ssize_t erst_dbg_read(struct file *filp, char __user *ubuf,
-			     size_t usize, loff_t *off)
+static ssize_t erst_dbg_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t usize = iov_iter_count(to);
 	int rc, *pos;
 	ssize_t len = 0;
 	u64 id;
 
-	if (*off)
+	if (iocb->ki_pos)
 		return -EINVAL;
 
 	if (mutex_lock_interruptible(&erst_dbg_mutex) != 0)
 		return -EINTR;
 
-	pos = (int *)&filp->private_data;
+	pos = (int *)&iocb->ki_filp->private_data;
 
 retry_next:
 	rc = erst_get_record_id_next(pos, &id);
@@ -141,7 +142,7 @@ static ssize_t erst_dbg_read(struct file *filp, char __user *ubuf,
 		goto out;
 
 	rc = -EFAULT;
-	if (copy_to_user(ubuf, erst_dbg_buf, len))
+	if (!copy_to_iter_full(erst_dbg_buf, len, to))
 		goto out;
 	rc = 0;
 out:
@@ -149,9 +150,9 @@ static ssize_t erst_dbg_read(struct file *filp, char __user *ubuf,
 	return rc ? rc : len;
 }
 
-static ssize_t erst_dbg_write(struct file *filp, const char __user *ubuf,
-			      size_t usize, loff_t *off)
+static ssize_t erst_dbg_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t usize = iov_iter_count(from);
 	int rc;
 	struct cper_record_header *rcd;
 
@@ -175,8 +176,8 @@ static ssize_t erst_dbg_write(struct file *filp, const char __user *ubuf,
 		erst_dbg_buf = p;
 		erst_dbg_buf_len = usize;
 	}
-	rc = copy_from_user(erst_dbg_buf, ubuf, usize);
-	if (rc) {
+	rc = copy_from_iter_full(erst_dbg_buf, usize, from);
+	if (!rc) {
 		rc = -EFAULT;
 		goto out;
 	}
@@ -196,8 +197,8 @@ static const struct file_operations erst_dbg_ops = {
 	.owner		= THIS_MODULE,
 	.open		= erst_dbg_open,
 	.release	= erst_dbg_release,
-	.read		= erst_dbg_read,
-	.write		= erst_dbg_write,
+	.read_iter	= erst_dbg_read,
+	.write_iter	= erst_dbg_write,
 	.unlocked_ioctl	= erst_dbg_ioctl,
 	.llseek		= no_llseek,
 };
diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
index c074a0fae059..47c811cb75f4 100644
--- a/drivers/acpi/ec_sys.c
+++ b/drivers/acpi/ec_sys.c
@@ -60,6 +60,7 @@ static ssize_t acpi_ec_read_io(struct file *f, char __user *buf,
 	}
 	return count;
 }
+FOPS_READ_ITER_HELPER(acpi_ec_read_io);
 
 static ssize_t acpi_ec_write_io(struct file *f, const char __user *buf,
 				size_t count, loff_t *off)
@@ -98,12 +99,13 @@ static ssize_t acpi_ec_write_io(struct file *f, const char __user *buf,
 	}
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(acpi_ec_write_io);
 
 static const struct file_operations acpi_ec_io_ops = {
 	.owner = THIS_MODULE,
 	.open  = simple_open,
-	.read  = acpi_ec_read_io,
-	.write = acpi_ec_write_io,
+	.read_iter  = acpi_ec_read_io_iter,
+	.write_iter = acpi_ec_write_io_iter,
 	.llseek = default_llseek,
 };
 
diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 8b2910995fc1..a7a4d3bb74d3 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -481,10 +481,11 @@ static ssize_t pfru_write(struct file *file, const char __user *buf,
 
 	return ret ?: len;
 }
+FOPS_WRITE_ITER_HELPER(pfru_write);
 
 static const struct file_operations acpi_pfru_fops = {
 	.owner		= THIS_MODULE,
-	.write		= pfru_write,
+	.write_iter	= pfru_write_iter,
 	.unlocked_ioctl = pfru_ioctl,
 	.llseek		= noop_llseek,
 };
-- 
2.43.0


