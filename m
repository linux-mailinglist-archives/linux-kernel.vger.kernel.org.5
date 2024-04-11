Return-Path: <linux-kernel+bounces-140936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E480E8A19B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978FC287C23
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A861C9ED6;
	Thu, 11 Apr 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="099V+exf"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8901C9EBE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849786; cv=none; b=bL3IXedFeIWPTZc9G7JSEviMEAD+xcdqKEboRRfXAtVG1jA37drEGklhRs6BnIDRZODJcbrOER/5i58IrGaE1nI0p6280ZqbO02O3R610oVpGYgH/eshoSJVG3bD2EDZ2lN3KenOkyHGcm8OYW0pFWrw5IuLL5AqCn7amE62CCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849786; c=relaxed/simple;
	bh=BpbLbOP2afdvtIC9iamDC2khJ9q6WVB0dG51UsiIlNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJD3n/ETJKpJ/FEQlbRRuzDuQEDJ7Uldcxp/cXf0OfKEq4xUg7XdytGYLley5Gc4ssnm/YwvMrfP5b+Ug9hlZxTkngwO3L35tH0rp6Tr45hMsr2t1mgJqJP7EySG8IuJM1WSIT8cLW0je52kXKtHgzf4ehPg48JOgopdO7mh5T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=099V+exf; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58077739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849782; x=1713454582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzFflLsYEL6dEX0b2SgCkx7pDBMhEWrTGXs6PsOZyO8=;
        b=099V+exfwsx5swO8TfrfwPvTCeoM+11acZIE5ugkNYu20ON7DNszD81NPzleRG4c0o
         wFC0zR0wmw58Y7fNa0yVD+i5ziHAGiOwrQfXxgQDx6cQev+nd2EMM0m1T2AaxoxA1jhF
         ZaHFRjgZemb784FfoJFShuFwbf0moLISddoGRmeSeZEdumryw667ZXXJk1Z12VqsOQa4
         PmeLqVbF/KwgUlaI2+a8eIWglAylT8QVPs/5hBOInp/UfAao6TWgwoLno+VYqBYm4a7P
         DThXSCRuSgvRJomQHSb7L3yVVUxhx1w9n7RFTN97Etahd9+S7v1g6kQFlbt2OPjUPDhH
         v2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849782; x=1713454582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzFflLsYEL6dEX0b2SgCkx7pDBMhEWrTGXs6PsOZyO8=;
        b=YPg0kWaNXEyDkbtSApNJNTdUHAzTnOm/No7j7JZ2kYXcPu1IC2IN1FKXRSTX/xErOv
         D3hM95Re7vIlTZDlCW7qMAZaBpw6os27oMC8JgxN9Wnmm19ySx/6MC2r6hhr211nnBnD
         jM03lNgJFT/RRPWJHwj7MDismomXA2gwmSc8B28SdJQhlPsem2LMuwqkmLlHgco2reIW
         LTzEvli9EyhJu6Se/b5cYy9gUkHGdaEoX+Ih9/6NY2/G7l+t06N1zwTFBvSP7vsTav2B
         3xMxQaW5WcZpbKR7XOudU00Uhbrve44UXq2B7uTbpK5R6obsc9s/qbQYHe+kLlhgv/0m
         7ixA==
X-Gm-Message-State: AOJu0Yx4LZIX+VpGt5UyohCIrlasb/YXzwuCHLP7Cxe8V19XAybXIJ60
	GzjzmgL1krRAuMveq7ATBcT7GRw6Ku/3A3JooBJO78Q09SfwkYUP4/I/E1ZDfo5TXtH6ezRwN6s
	q
X-Google-Smtp-Source: AGHT+IFszcf26vQCCbg8hYAeod09OX+GBgldCuTxvYlZ8bIe0UKrtuXkPk9+ZF/HKhcIDoEpxGcT2w==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr185368iov.2.1712849782653;
        Thu, 11 Apr 2024 08:36:22 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 167/437] usb: image: mdc800: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:07 -0600
Message-ID: <20240411153126.16201-168-axboe@kernel.dk>
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
 drivers/usb/image/mdc800.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/image/mdc800.c b/drivers/usb/image/mdc800.c
index 7b7e1554ea20..ec52a144f8d7 100644
--- a/drivers/usb/image/mdc800.c
+++ b/drivers/usb/image/mdc800.c
@@ -677,10 +677,10 @@ static int mdc800_device_release (struct inode* inode, struct file *file)
 /*
  * The Device read callback Function
  */
-static ssize_t mdc800_device_read (struct file *file, char __user *buf, size_t len, loff_t *pos)
+static ssize_t mdc800_device_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t len = iov_iter_count(to);
 	size_t left=len, sts=len; /* single transfer size */
-	char __user *ptr = buf;
 	int retval;
 
 	mutex_lock(&mdc800->io_lock);
@@ -754,12 +754,11 @@ static ssize_t mdc800_device_read (struct file *file, char __user *buf, size_t l
 		else
 		{
 			/* Copy Bytes */
-			if (copy_to_user(ptr, &mdc800->out [mdc800->out_ptr],
-						sts)) {
+			if (!copy_to_iter_full(&mdc800->out [mdc800->out_ptr],
+						sts, to)) {
 				mutex_unlock(&mdc800->io_lock);
 				return -EFAULT;
 			}
-			ptr+=sts;
 			left-=sts;
 			mdc800->out_ptr+=sts;
 		}
@@ -936,7 +935,7 @@ static ssize_t mdc800_device_write (struct file *file, const char __user *buf, s
 	mutex_unlock(&mdc800->io_lock);
 	return i;
 }
-
+FOPS_WRITE_ITER_HELPER(mdc800_device_write);
 
 /***************************************************************************
 	Init and Cleanup this driver (Structs and types)
@@ -946,8 +945,8 @@ static ssize_t mdc800_device_write (struct file *file, const char __user *buf, s
 static const struct file_operations mdc800_device_ops =
 {
 	.owner =	THIS_MODULE,
-	.read =		mdc800_device_read,
-	.write =	mdc800_device_write,
+	.read_iter =	mdc800_device_read,
+	.write_iter =	mdc800_device_write_iter,
 	.open =		mdc800_device_open,
 	.release =	mdc800_device_release,
 	.llseek =	noop_llseek,
-- 
2.43.0


