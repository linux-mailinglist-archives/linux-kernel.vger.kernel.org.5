Return-Path: <linux-kernel+bounces-140795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77B08A1900
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018211C20F06
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EACD3FBAC;
	Thu, 11 Apr 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wXofiwEv"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068E17C6D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849554; cv=none; b=Ky88Pi7zxuLtQbRUnl+Zy7vQ9kzaovPa8ZZKLO87LZT8JpCq+/fEMfF1hOWn/VGjGkWmykgmGQYGR9tAGD4fH4j7VicbbhQXPGki9k9qu1uYCwDGzmDoy/dha6zkqRrQ3DGWDj1UjIKBeO+Ry4+klVsdZAbQsNfjpAKzEGyB94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849554; c=relaxed/simple;
	bh=KzkEJHtse1ucBqXFsqrNxKHzxInSZccfjdoqVXDjAsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHRJK89c43aUb5yQPz2VgadwE2cjji0i5MclPhy5yYgtrwI3rvNfmC+g8XL9XqeKpT44Bnw8+2nvMgBrpxDyLJYk7elv36EH8jfYGU3Lh/fjmu9EQRgGthOrZ2Bu8NVn4gf5QyXoCTAb7hJsPatEAwoT5G0aXLTxMBn3Rg3GYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wXofiwEv; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8857939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849550; x=1713454350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM+GUVsNLtfnxAZegRp/5CycyHTgzU7o1O95e3WojGs=;
        b=wXofiwEvA6R99d648QBrRoND958/AmbtzO96sywJ3F8aOwQZHzOES7sPgbBgCwO9ki
         H00YFqCVAUkvW4XSFmr8d3r2rDjOY1Nojabqz7+ZJsSqw45MT7IXWN4+qQfIy2JHlXsV
         jMim7qkVATKIonDcuhayDsBv7w2BP/XTCrT1cgvD36Dh1fcHafuAIE5VMlFCFURNZO80
         wNWj12UNS7R2l6dXxeBBw+Gvcebi2kX0QhH27edxKWnJvF24UfuMRSxlmQrzolwzi0qI
         GgdAQy3GBKgFE7J6/ebszHfyQ5Kk1Mepaq60EuZqxj7qDXwtqe/5J5xcKKqC2m6EoD3b
         BNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849550; x=1713454350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZM+GUVsNLtfnxAZegRp/5CycyHTgzU7o1O95e3WojGs=;
        b=Vv0Dtg6tf4vMB15LxhlfGPD0ajYmc0gnfN/fWyyMPxwm2FGgQFDku/f/fJag+/JlJf
         xSwQweRHjmNrtsdTCXWyH1Ettzx0v+bB716WzdpEnTnESWBzi11xaV0vjHPRMh3RaUdD
         NlL6kiuMV7Czr/X+ohLChriI93dyS2Gw57MrP9axfgF/ZQ4wUz0cKNyF1T2x9niMGJy/
         MCQHzpZhjKSbxbPmF+MLFpIR1hkAfR8oMXyY4WB2PqueL26vuEQ7p6LV5lTbbvWPmVGl
         EQz5nfnI0yMAAOekT7fP3woDTuLjpPV1mk0ucPgwRReL8A5kZvRsr+bbKrlnz1Gr1E3j
         SceQ==
X-Gm-Message-State: AOJu0YyL0/J572irAtkAvXdcRSi8BHrNjkxWHnzTn5wXX+8q6xIKQIRz
	qwxMLkGxDNjCygFBy/PaPCOwR5iZpijjWHYgNfY7hyM7uObUiTSR0KEuLqaCRdDlN/e1OhfvDeu
	j
X-Google-Smtp-Source: AGHT+IHr/Ugo0Ngqx1M+1YcqtgDA8fmxTu4yxvXhn8eqT5DyAdEc17cVSy0vocIKAKDdKxlqkHyU0w==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr4167ioc.1.1712849550185;
        Thu, 11 Apr 2024 08:32:30 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 036/437] char/xilinx_hwicap: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:56 -0600
Message-ID: <20240411153126.16201-37-axboe@kernel.dk>
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
 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 31 ++++++++++------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 4f6c3cb8aa41..fc5b8d18234d 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -349,10 +349,10 @@ static int hwicap_initialize_hwicap(struct hwicap_drvdata *drvdata)
 	return 0;
 }
 
-static ssize_t
-hwicap_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+static ssize_t hwicap_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hwicap_drvdata *drvdata = file->private_data;
+	struct hwicap_drvdata *drvdata = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	ssize_t bytes_to_read = 0;
 	u32 *kbuf;
 	u32 words;
@@ -372,7 +372,7 @@ hwicap_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			drvdata->read_buffer_in_use;
 
 		/* Return the data currently in the read buffer. */
-		if (copy_to_user(buf, drvdata->read_buffer, bytes_to_read)) {
+		if (!copy_to_iter_full(drvdata->read_buffer, bytes_to_read, to)) {
 			status = -EFAULT;
 			goto error;
 		}
@@ -417,7 +417,7 @@ hwicap_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		}
 
 		/* If we fail to return the data to the user, then bail out. */
-		if (copy_to_user(buf, kbuf, bytes_to_read)) {
+		if (!copy_to_iter_full(kbuf, bytes_to_read, to)) {
 			free_page((unsigned long)kbuf);
 			status = -EFAULT;
 			goto error;
@@ -434,11 +434,10 @@ hwicap_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	return status;
 }
 
-static ssize_t
-hwicap_write(struct file *file, const char __user *buf,
-		size_t count, loff_t *ppos)
+static ssize_t hwicap_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hwicap_drvdata *drvdata = file->private_data;
+	struct hwicap_drvdata *drvdata = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	ssize_t written = 0;
 	ssize_t left = count;
 	u32 *kbuf;
@@ -475,16 +474,15 @@ hwicap_write(struct file *file, const char __user *buf,
 		if (drvdata->write_buffer_in_use) {
 			memcpy(kbuf, drvdata->write_buffer,
 					drvdata->write_buffer_in_use);
-			if (copy_from_user(
+			if (!copy_from_iter_full(
 			    (((char *)kbuf) + drvdata->write_buffer_in_use),
-			    buf + written,
-			    len - (drvdata->write_buffer_in_use))) {
+			    len - (drvdata->write_buffer_in_use), from)) {
 				free_page((unsigned long)kbuf);
 				status = -EFAULT;
 				goto error;
 			}
 		} else {
-			if (copy_from_user(kbuf, buf + written, len)) {
+			if (!copy_from_iter_full(kbuf, len, from)) {
 				free_page((unsigned long)kbuf);
 				status = -EFAULT;
 				goto error;
@@ -508,8 +506,7 @@ hwicap_write(struct file *file, const char __user *buf,
 		left -= len;
 	}
 	if ((left > 0) && (left < 4)) {
-		if (!copy_from_user(drvdata->write_buffer,
-						buf + written, left)) {
+		if (copy_from_iter_full(drvdata->write_buffer, left, from)) {
 			drvdata->write_buffer_in_use = left;
 			written += left;
 			left = 0;
@@ -589,8 +586,8 @@ static int hwicap_release(struct inode *inode, struct file *file)
 
 static const struct file_operations hwicap_fops = {
 	.owner = THIS_MODULE,
-	.write = hwicap_write,
-	.read = hwicap_read,
+	.write_iter = hwicap_write,
+	.read_iter = hwicap_read,
 	.open = hwicap_open,
 	.release = hwicap_release,
 	.llseek = noop_llseek,
-- 
2.43.0


