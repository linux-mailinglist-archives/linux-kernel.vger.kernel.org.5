Return-Path: <linux-kernel+bounces-140954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF008A19CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AB01F21A73
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC831B5C50;
	Thu, 11 Apr 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xy9GfMuR"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A133DAC03
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849814; cv=none; b=ecDiHMiMdlEtwvsjvqjkL984WFYh66M261vMQvzZPeP1ue7N4OOESOg0eWb0GMSiM+iH1HYUkJehGugRyUOzb5CP3r/glPxG2KmURN7zHgywQq1xpwkXXseARAbgdZoTUfchjieKGTFOekEnOg3e64J5Rt8NWVlwq84j0IToImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849814; c=relaxed/simple;
	bh=CBMg4hLBtzUqDlU4Be8FlKvPn5MyY9zwPHlF0/XAwN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFTVzLaS9gStoqE2ahj+pPXRNceMnriLKu/iud8zfVG8cOgSqQuTME+VQQhBngKcDy3TKleuUyUaKn4sivnjRoAfJOQ1MQk5UiOnhbOit3pL7yL9BE4qWoVzWCO6rhci1PnQ3YbEo7mJ7me2nhSEDnxnVuw6V/U7b1RztQIJpSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xy9GfMuR; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16173039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849810; x=1713454610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H43tdm6qXVY7UF8KlBQbACCpMF5pPhva70Q2Qo/15+U=;
        b=xy9GfMuRQUlmuqwi6cX7RCAuHhoomC5Oyg5iZB7MVTBj+C1Uk8ipYYxBoGivXbbN/J
         hwN2iCd0oRKWTEuEzvl4fA2atyKxL87TQMzI+IDj8NSWZfiCa6+dZUC33KblT9cwP6dA
         ZYZTo7Wt/s2fCankU+h9DnTedDK40Rr/rg2rRknVo5xZQdRSi9NkVZeLCGPSLoCUvvpv
         TMue9AEN2GScbJFnzbBLrdyDaOBIz7Qu63OBqeEs9NsP+kzSPtUL8jT3YF8Aj8XpUwGV
         vMAmkkcpv8OxFHgK7iPwkSU9IVqnuGitQZuOCJIH+Tl8ktoXmgRxdsfK7Cxneqiyqwv5
         l/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849810; x=1713454610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H43tdm6qXVY7UF8KlBQbACCpMF5pPhva70Q2Qo/15+U=;
        b=BnirhbN9tNaxiGtDz2EPdZKnLkFWgw27hCBecCu8BQo9QQgytPO5BP0BHs2h9JAeBc
         wG5Bmp7NEljFB/AGPWQkbtWM2Z9WMq0qbqdKkKB9QCWgWdDOnGduOaW3ycwSFcu8qh0R
         vHy5AjYzbbjkS21IlXnsmR5Iw5xEvU9uvsB/n+pWVq8013E2JGNktHEUfpEI4Y2CDaNZ
         Dfc4oLVc/EEqdCQGBNZoRbGG3VnyQ+AP2MqLQGE7rEdofxrflcuJs3FIT6WWuGbxQiMJ
         B1gZbKXIVvW0tnVgxOcgrxaRsYUQI70QKZ55Y/r0YVvSGP0VU/HGl0vWNSqpC6V50Vg1
         eKfQ==
X-Gm-Message-State: AOJu0YxjWAbvvlRFYXqMmIpuBJzYpHbzTWjHn2oiNQkixNrJ6S8RRuj+
	j64IzjOUjuSgEPFypKxlv7IFOaF0mDvdjQx5gcz0wbVXS1c6Ix00HgScRkXs9LI5cAX1AvetbT4
	O
X-Google-Smtp-Source: AGHT+IHevWHDLKSNkMYGkAdh49/6+nBkaiIRtq0YdbJwllt1Yy/dEBC5kR3B8KifSuRC7CjjXFBctg==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr162857ioh.1.1712849810029;
        Thu, 11 Apr 2024 08:36:50 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 185/437] scsi: bfa: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:25 -0600
Message-ID: <20240411153126.16201-186-axboe@kernel.dk>
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
 drivers/scsi/bfa/bfad_debugfs.c | 51 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_debugfs.c b/drivers/scsi/bfa/bfad_debugfs.c
index 52db147d9979..f9e1842e3a59 100644
--- a/drivers/scsi/bfa/bfad_debugfs.c
+++ b/drivers/scsi/bfa/bfad_debugfs.c
@@ -167,17 +167,15 @@ bfad_debugfs_lseek(struct file *file, loff_t offset, int orig)
 				debug->buffer_len);
 }
 
-static ssize_t
-bfad_debugfs_read(struct file *file, char __user *buf,
-			size_t nbytes, loff_t *pos)
+static ssize_t bfad_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct bfad_debug_info *debug = file->private_data;
+	struct bfad_debug_info *debug = iocb->ki_filp->private_data;
 
 	if (!debug || !debug->debug_buffer)
 		return 0;
 
-	return simple_read_from_buffer(buf, nbytes, pos,
-				debug->debug_buffer, debug->buffer_len);
+	return simple_copy_to_iter(debug->debug_buffer, &iocb->ki_pos,
+					debug->buffer_len, to);
 }
 
 #define BFA_REG_CT_ADDRSZ	(0x40000)
@@ -210,22 +208,21 @@ bfad_reg_offset_check(struct bfa_s *bfa, u32 offset, u32 len)
 	return BFA_STATUS_OK;
 }
 
-static ssize_t
-bfad_debugfs_read_regrd(struct file *file, char __user *buf,
-		size_t nbytes, loff_t *pos)
+static ssize_t bfad_debugfs_read_regrd(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct bfad_debug_info *regrd_debug = file->private_data;
+	struct bfad_debug_info *regrd_debug = iocb->ki_filp->private_data;
 	struct bfad_port_s *port = (struct bfad_port_s *)regrd_debug->i_private;
+	size_t nbytes = iov_iter_count(to);
 	struct bfad_s *bfad = port->bfad;
 	ssize_t rc;
 
 	if (!bfad->regdata)
 		return 0;
 
-	rc = simple_read_from_buffer(buf, nbytes, pos,
-			bfad->regdata, bfad->reglen);
+	rc = simple_copy_to_iter(bfad->regdata, &iocb->ki_pos, bfad->reglen,
+					to);
 
-	if ((*pos + nbytes) >= bfad->reglen) {
+	if ((iocb->ki_pos + nbytes) >= bfad->reglen) {
 		kfree(bfad->regdata);
 		bfad->regdata = NULL;
 		bfad->reglen = 0;
@@ -235,11 +232,11 @@ bfad_debugfs_read_regrd(struct file *file, char __user *buf,
 }
 
 static ssize_t
-bfad_debugfs_write_regrd(struct file *file, const char __user *buf,
-		size_t nbytes, loff_t *ppos)
+bfad_debugfs_write_regrd(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct bfad_debug_info *regrd_debug = file->private_data;
+	struct bfad_debug_info *regrd_debug = iocb->ki_filp->private_data;
 	struct bfad_port_s *port = (struct bfad_port_s *)regrd_debug->i_private;
+	size_t nbytes  = iov_iter_count(from);
 	struct bfad_s *bfad = port->bfad;
 	struct bfa_s *bfa = &bfad->bfa;
 	struct bfa_ioc_s *ioc = &bfa->ioc;
@@ -250,7 +247,7 @@ bfad_debugfs_write_regrd(struct file *file, const char __user *buf,
 	unsigned long flags;
 	void *kern_buf;
 
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = iterdup(from, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
@@ -304,11 +301,11 @@ bfad_debugfs_write_regrd(struct file *file, const char __user *buf,
 }
 
 static ssize_t
-bfad_debugfs_write_regwr(struct file *file, const char __user *buf,
-		size_t nbytes, loff_t *ppos)
+bfad_debugfs_write_regwr(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct bfad_debug_info *debug = file->private_data;
+	struct bfad_debug_info *debug = iocb->ki_filp->private_data;
 	struct bfad_port_s *port = (struct bfad_port_s *)debug->i_private;
+	size_t nbytes = iov_iter_count(from);
 	struct bfad_s *bfad = port->bfad;
 	struct bfa_s *bfa = &bfad->bfa;
 	struct bfa_ioc_s *ioc = &bfa->ioc;
@@ -317,7 +314,7 @@ bfad_debugfs_write_regwr(struct file *file, const char __user *buf,
 	unsigned long flags;
 	void *kern_buf;
 
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = iterdup(from, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
@@ -382,7 +379,7 @@ static const struct file_operations bfad_debugfs_op_drvtrc = {
 	.owner		=	THIS_MODULE,
 	.open		=	bfad_debugfs_open_drvtrc,
 	.llseek		=	bfad_debugfs_lseek,
-	.read		=	bfad_debugfs_read,
+	.read_iter	=	bfad_debugfs_read,
 	.release	=	bfad_debugfs_release,
 };
 
@@ -390,7 +387,7 @@ static const struct file_operations bfad_debugfs_op_fwtrc = {
 	.owner		=	THIS_MODULE,
 	.open		=	bfad_debugfs_open_fwtrc,
 	.llseek		=	bfad_debugfs_lseek,
-	.read		=	bfad_debugfs_read,
+	.read_iter	=	bfad_debugfs_read,
 	.release	=	bfad_debugfs_release_fwtrc,
 };
 
@@ -398,7 +395,7 @@ static const struct file_operations bfad_debugfs_op_fwsave = {
 	.owner		=	THIS_MODULE,
 	.open		=	bfad_debugfs_open_fwsave,
 	.llseek		=	bfad_debugfs_lseek,
-	.read		=	bfad_debugfs_read,
+	.read_iter	=	bfad_debugfs_read,
 	.release	=	bfad_debugfs_release_fwtrc,
 };
 
@@ -406,8 +403,8 @@ static const struct file_operations bfad_debugfs_op_regrd = {
 	.owner		=	THIS_MODULE,
 	.open		=	bfad_debugfs_open_reg,
 	.llseek		=	bfad_debugfs_lseek,
-	.read		=	bfad_debugfs_read_regrd,
-	.write		=	bfad_debugfs_write_regrd,
+	.read_iter	=	bfad_debugfs_read_regrd,
+	.write_iter	=	bfad_debugfs_write_regrd,
 	.release	=	bfad_debugfs_release,
 };
 
@@ -415,7 +412,7 @@ static const struct file_operations bfad_debugfs_op_regwr = {
 	.owner		=	THIS_MODULE,
 	.open		=	bfad_debugfs_open_reg,
 	.llseek		=	bfad_debugfs_lseek,
-	.write		=	bfad_debugfs_write_regwr,
+	.write_iter	=	bfad_debugfs_write_regwr,
 	.release	=	bfad_debugfs_release,
 };
 
-- 
2.43.0


