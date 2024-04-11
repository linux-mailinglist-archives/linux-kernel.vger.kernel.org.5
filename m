Return-Path: <linux-kernel+bounces-141112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9308A1A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8461C2113B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9B34D9FC;
	Thu, 11 Apr 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="adTeoNPW"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA27165FB7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850057; cv=none; b=cAycBxrCg62qtjjJWihzPcZSliFzHMkASSN+CFownz8yGaneoOB9p0VivgcgoQ/dXSxXq8+2zFMVxVdPESzpiT/jZHHu8Zxu5+SxsnilKw173sOkO6JUpEzT1uWdpF75vPxTULRIkDTfbghQpUDkBgjZ3ouwNSXnphJiduUKNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850057; c=relaxed/simple;
	bh=dSZBw99ta5Nr1a13mvK1ZGND4ae/gIyhUdEiU+c7xUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyWPrnWRneFt51TrzIvn8q9M1yaPftCEbajQY3aexxmDNJ6P1exQRJIF7yKjKHhgSIEvsSYy2+jNUgKbx887c0CpSDxCPrPAERNKWshhxa5WaSBvusy8NH6t5XNe48oEWreyjXFeJPErJkYASKWfgEQLRR09zkGjf3Vi0RvKgQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=adTeoNPW; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a224d7414so193975ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850055; x=1713454855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WG6Uk3x+Muh3L7mgjThqbpYc52vRkmDdJEdQ/c/cVsE=;
        b=adTeoNPWGEm/JTu9YTr5iF5OmOXep0P8UstvXGrVqPH4avK71RniLrV6Ns1Mkleolz
         Gy4N5Fw5fOzxE4inq9sM6zRRgGmQcfNDJzR2i5PXYMMOrUOWg9EPqPT0/OnIn7n8Ic8X
         x1w8tBz9RBf1TtPtg9jAMkNeSXNJFUcfpu94KcD+Ky2s/e9IvQEk6Sxxwy+XzrKL6HuS
         gO5Koh+Kbb3yt3F7SmKaDk2eXZkJUky0zrAL8y5cQxiJg1RS2Lav0vLIAuPv8Tb4hlfG
         tsIVuxu55SW94/yYOCmhhGPoF57d//cRuwG6/xyzXrA5+3e56a37W5lk2jlEEazk5qHg
         sPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850055; x=1713454855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WG6Uk3x+Muh3L7mgjThqbpYc52vRkmDdJEdQ/c/cVsE=;
        b=SROZiWD6hjPCLdYDbz0vzRKYjxl5kkNY6LqPkPxZbH+/Q7ny+8j4lFacvRVD8pC1gO
         Tju7NVnS2xn/0uAHGMLQSqvsvTBWivAzlZSyk5NLSTLHTGhRQC9OrlCaWOvBtw5lhQMd
         sfdeIfhnM9NTMI3L6Qas1b5Y9dXh62kcZOS6qNn+XKR//amlFz66m0fMtTp4f5xghAxM
         ORoTC0Yku0Eola4FpDGP0GVyL53J1Qxx2tLH56zVQ6GT/1GqmHprkrnVlJH5UUdvc37j
         lZ8Yrdeu8E00TjgEYpEQQOcgDDwcArj9W8YRq/RlSiJlHQR74qcAJeMWa5dkgdAfKClj
         dBIQ==
X-Gm-Message-State: AOJu0YxI0wfDDDbA9GDKtuK/yE73TfbjfgeOVx4ZWGHEH18DYuCLl5kS
	8cri9GIfEOVFtHcjm5f4/Qk19cgZI1bPfgmta++uymgAZjaeehtlswcQrIY+hRX/5S9XSlBTUzx
	t
X-Google-Smtp-Source: AGHT+IFbBuAax4Ybs72CdsdcvVSbbKVaw4G9DFm2gFE3sWkb4Grv1+Jv+bQdiI/QNOMrCbns7miDEQ==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr200064iob.1.1712850054481;
        Thu, 11 Apr 2024 08:40:54 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 334/437] arch/mips: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:54 -0600
Message-ID: <20240411153126.16201-335-axboe@kernel.dk>
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
 arch/mips/kernel/rtlx.c   |  6 ++++--
 arch/mips/kernel/vpe.c    | 14 +++++++-------
 arch/mips/mm/sc-debugfs.c | 16 +++++++---------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index 18c509c59f33..6e3bf6d4c64b 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -369,6 +369,7 @@ static ssize_t file_read(struct file *file, char __user *buffer, size_t count,
 
 	return rtlx_read(minor, buffer, count);
 }
+FOPS_READ_ITER_HELPER(file_read);
 
 static ssize_t file_write(struct file *file, const char __user *buffer,
 			  size_t count, loff_t *ppos)
@@ -390,13 +391,14 @@ static ssize_t file_write(struct file *file, const char __user *buffer,
 
 	return rtlx_write(minor, buffer, count);
 }
+FOPS_WRITE_ITER_HELPER(file_write);
 
 const struct file_operations rtlx_fops = {
 	.owner =   THIS_MODULE,
 	.open =    file_open,
 	.release = file_release,
-	.write =   file_write,
-	.read =    file_read,
+	.write_iter =   file_write_iter,
+	.read_iter = file_read_iter,
 	.poll =    file_poll,
 	.llseek =  noop_llseek,
 };
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 737d0d4fdcd3..55db91fba7b0 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -834,13 +834,13 @@ static int vpe_release(struct inode *inode, struct file *filp)
 #endif
 }
 
-static ssize_t vpe_write(struct file *file, const char __user *buffer,
-			 size_t count, loff_t *ppos)
+static ssize_t vpe_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	size_t ret = count;
 	struct vpe *v;
 
-	if (iminor(file_inode(file)) != VPE_MODULE_MINOR)
+	if (iminor(file_inode(iocb->ki_filp)) != VPE_MODULE_MINOR)
 		return -ENODEV;
 
 	v = get_vpe(aprp_cpu_index());
@@ -853,19 +853,19 @@ static ssize_t vpe_write(struct file *file, const char __user *buffer,
 		return -ENOMEM;
 	}
 
-	count -= copy_from_user(v->pbuffer + v->len, buffer, count);
-	if (!count)
+	ret !copy_from_iter_full(v->pbuffer + v->len, count, from);
+	if (!ret)
 		return -EFAULT;
 
 	v->len += count;
-	return ret;
+	return count;
 }
 
 const struct file_operations vpe_fops = {
 	.owner = THIS_MODULE,
 	.open = vpe_open,
 	.release = vpe_release,
-	.write = vpe_write,
+	.write_iter = vpe_write,
 	.llseek = noop_llseek,
 };
 
diff --git a/arch/mips/mm/sc-debugfs.c b/arch/mips/mm/sc-debugfs.c
index 80ff3947157d..d85e8b95d9b5 100644
--- a/arch/mips/mm/sc-debugfs.c
+++ b/arch/mips/mm/sc-debugfs.c
@@ -10,8 +10,7 @@
 #include <linux/debugfs.h>
 #include <linux/init.h>
 
-static ssize_t sc_prefetch_read(struct file *file, char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t sc_prefetch_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	bool enabled = bc_prefetch_is_enabled();
 	char buf[3];
@@ -20,17 +19,16 @@ static ssize_t sc_prefetch_read(struct file *file, char __user *user_buf,
 	buf[1] = '\n';
 	buf[2] = 0;
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
-static ssize_t sc_prefetch_write(struct file *file,
-				 const char __user *user_buf,
-				 size_t count, loff_t *ppos)
+static ssize_t sc_prefetch_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	bool enabled;
 	int err;
 
-	err = kstrtobool_from_user(user_buf, count, &enabled);
+	err = kstrtobool_from_iter(from, count, &enabled);
 	if (err)
 		return err;
 
@@ -45,8 +43,8 @@ static ssize_t sc_prefetch_write(struct file *file,
 static const struct file_operations sc_prefetch_fops = {
 	.open = simple_open,
 	.llseek = default_llseek,
-	.read = sc_prefetch_read,
-	.write = sc_prefetch_write,
+	.read_iter = sc_prefetch_read,
+	.write_iter = sc_prefetch_write,
 };
 
 static int __init sc_debugfs_init(void)
-- 
2.43.0


