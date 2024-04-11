Return-Path: <linux-kernel+bounces-140803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7CE8A1907
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5131C2343A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F85E5A0E6;
	Thu, 11 Apr 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KDtbZxij"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559495914A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849566; cv=none; b=X2ho2Ceb1wmP8DYHQoDNGqhPBBO7iO8a9j1RL1AishlCZp6C/nywTzME+BVHOI5U8YTgVncdMzKFoUbJ5CNih1H7kl0WAl5X97zQFEB5BmNKwgaq1VYgfCP7nl1+jQjNf34eQDMK45HrBlvKbqR+jbjDbbLHpr9r62fhpSXu9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849566; c=relaxed/simple;
	bh=c8so3z+nMTH3xQVm4vaEiirsE21WQyNbfRNWgJE/Pew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogcD9z2skpGnmGCOXmmq/xE6a7Ew9Yav/96Jc5O/uZj4QCus/0dw260Ohk9AYMPWtNuS/3QWX/1D1UOSGIQxlP3TDi+DgGZ5TqzzAoqmhId5gCei862uajQvGUQIJpylPoYFuHlf33+9m1m8X9plemw1INX41oCXc6iFP1qh2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KDtbZxij; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69501339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849564; x=1713454364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW/6FxH4sDmaE071qUZ36An1TE18slX4h4IRYxxJV2k=;
        b=KDtbZxijYe5MfpIvgNMU+6TtKpDKGelEqX4Ahuh7r1ZfFsUQnNBDGKrRBzXAif6BiK
         +RMn9mxitiflDgk96w3V5lS+mQz58m9fJKnXChdUUuKujZMCP9J+BQf7kRw8+9DS74kJ
         QmHBOVKa3Vi8NAUcSgxen0o+SH3EFCx7hnpZmt3pRlbdprLHjJoEBsz6rAAjYXRHM13b
         tph+EgKqUGkDO8PZJ2AT4iKrdQYp0x7X8ym6ZzuR1wBJYmJOcM0plxSgK1ChCxLwfTWA
         P0yqDFCtVTNALLPLRrBvydI112e9cyfufCtuQMOph8TAzbCdx6AQK0nTgaZVGlKuCsFu
         sBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849564; x=1713454364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TW/6FxH4sDmaE071qUZ36An1TE18slX4h4IRYxxJV2k=;
        b=fRNwMe407cl9J1NuCuhn9R5PtEiLNqmkYHHk6ZJRPRKOkufnbv2TA0xqSj/H9DfVQr
         MGbOC2hwbc68bMwvl/ftO33VjXhH1VAkWMgMBPq9wInO983qLd9kforUsEgNg6LSMd2t
         aWg+2z1Ul8ACYIRbmgepq9ZUxkozZMchJbUsn865Vc+r0DrhBnDS0eDxmhwrK+KObVdO
         ikOGtwEtsEOLHMmCyXEaZfegtiScINr5ekOOe/XPiywHF/BMgd6cJhZNjJRoSHC7MeJZ
         8m7OfSE79uv5eriOaTBr4N9rRWWImHingzGaAPoUzku870FhVqqbS4q7qoHcaelWm7bl
         AaIg==
X-Gm-Message-State: AOJu0Yx20sXkJaackIUYUIJSqCt8Aj0B7HvBDfJmGjhPIXnbnjKoQ8Zg
	9NWdT3ZZtNA84lKohGhMkScnlaLcovZqIPWR4y/UklLPhk8IC7FIWDrRilzj6y2s8j0bOcO02+3
	I
X-Google-Smtp-Source: AGHT+IHySu5mfm3sqOp1muAigguVwFOuAsm1zA8rvy4IKy/GqhDSZFrEiz+ZUbssc5gcmRQoscyukA==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr184810iop.1.1712849564324;
        Thu, 11 Apr 2024 08:32:44 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 043/437] ecryptfs: miscdev: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:03 -0600
Message-ID: <20240411153126.16201-44-axboe@kernel.dk>
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
 fs/ecryptfs/miscdev.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/ecryptfs/miscdev.c b/fs/ecryptfs/miscdev.c
index 4e62c3cef70f..6ea67a64e2ff 100644
--- a/fs/ecryptfs/miscdev.c
+++ b/fs/ecryptfs/miscdev.c
@@ -309,6 +309,7 @@ ecryptfs_miscdev_read(struct file *file, char __user *buf, size_t count,
 	mutex_unlock(&daemon->mux);
 	return rc;
 }
+FOPS_READ_ITER_HELPER(ecryptfs_miscdev_read);
 
 /**
  * ecryptfs_miscdev_response - miscdevess response to message previously sent to daemon
@@ -342,22 +343,20 @@ static int ecryptfs_miscdev_response(struct ecryptfs_daemon *daemon, char *data,
 
 /**
  * ecryptfs_miscdev_write - handle write to daemon miscdev handle
- * @file: File for misc dev handle
- * @buf: Buffer containing user data
- * @count: Amount of data in @buf
- * @ppos: Pointer to offset in file (ignored)
+ * @iocb: Metadata for IO
+ * @from: Buffer containing user data
  *
  * Returns the number of bytes read from @buf
  */
 static ssize_t
-ecryptfs_miscdev_write(struct file *file, const char __user *buf,
-		       size_t count, loff_t *ppos)
+ecryptfs_miscdev_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	__be32 counter_nbo;
 	u32 seq;
 	size_t packet_size, packet_size_length;
 	char *data;
 	unsigned char packet_size_peek[ECRYPTFS_MAX_PKT_LEN_SIZE];
+	size_t count = iov_iter_count(from);
 	ssize_t rc;
 
 	if (count == 0) {
@@ -372,8 +371,8 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 		return -EINVAL;
 	}
 
-	if (copy_from_user(packet_size_peek, &buf[PKT_LEN_OFFSET],
-			   sizeof(packet_size_peek))) {
+	if (!copy_from_iter_full(packet_size_peek, sizeof(packet_size_peek),
+				 from)) {
 		printk(KERN_WARNING "%s: Error while inspecting packet size\n",
 		       __func__);
 		return -EFAULT;
@@ -395,7 +394,7 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 	}
 
 memdup:
-	data = memdup_user(buf, count);
+	data = iterdup(from, count);
 	if (IS_ERR(data)) {
 		printk(KERN_ERR "%s: memdup_user returned error [%ld]\n",
 		       __func__, PTR_ERR(data));
@@ -416,7 +415,7 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 		}
 		memcpy(&counter_nbo, &data[PKT_CTR_OFFSET], PKT_CTR_SIZE);
 		seq = be32_to_cpu(counter_nbo);
-		rc = ecryptfs_miscdev_response(file->private_data,
+		rc = ecryptfs_miscdev_response(iocb->ki_filp->private_data,
 				&data[PKT_LEN_OFFSET + packet_size_length],
 				packet_size, seq);
 		if (rc) {
@@ -442,13 +441,12 @@ ecryptfs_miscdev_write(struct file *file, const char __user *buf,
 	return rc;
 }
 
-
 static const struct file_operations ecryptfs_miscdev_fops = {
 	.owner   = THIS_MODULE,
 	.open    = ecryptfs_miscdev_open,
 	.poll    = ecryptfs_miscdev_poll,
-	.read    = ecryptfs_miscdev_read,
-	.write   = ecryptfs_miscdev_write,
+	.read_iter    = ecryptfs_miscdev_read_iter,
+	.write_iter   = ecryptfs_miscdev_write,
 	.release = ecryptfs_miscdev_release,
 	.llseek  = noop_llseek,
 };
-- 
2.43.0


