Return-Path: <linux-kernel+bounces-140922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9448A19A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AD5282B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C7519DF7C;
	Thu, 11 Apr 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iIYb3LtL"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5BB19DF59
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849765; cv=none; b=nstzbgCif0oUTYiTZPYNXEHyrLHNKy9u3hl2LhmkRByVJ70zW5MG8+u42NJEQNnZIG3TNyRp6ZSvE7i6flTw1OekIa8PGhi6TQOQHGQ8BwW6+FXV8rdX0xNzMdaXr+mes21RNuOOzeTw04V0zdJBm1b4IVsDgo90AqiQgfmtC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849765; c=relaxed/simple;
	bh=zvqzV0PY1jqn8kHPAOt92hGay/kXiDLTVikdvgd4zXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0qKNkS49D/St2tIYWyvrPPC2IxUvs2g/bD/e/nLSMgJ6FLCTcZqBGE/9Yb/pN9j0fMfJFjUoVcdC8BZwKhVWlrju42XVKSShzYHbrMEZQPokrDHcRHv9fS7Ww+CRDsxGzKpnjoPwLY/J9w9HhSYWLi3M3oSSmsuQe+CIvHrLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iIYb3LtL; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58070739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849763; x=1713454563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S/KbBS/htLgbe+dCG/wp90qXPsCpm6GnNXMIBTtTxs=;
        b=iIYb3LtL11BMy73aq1Dol1OZjpD6bS5v0QkYMt4pOc3UGvk8KQT5PU+sCcBwfV1doo
         UjkmPKWdeCrrkBn69E48Y/raBxVVjjnFF4bqLLyNQLumpBmW1yRTB1gQaxAcJmm8TSid
         MNWVDfuhtdofmmFSMf7gp66sgKWr0u8S8Lakn+P5mvkoiE/pxccfGzMwZha+2by7gUug
         sP0MIDO0IkMd6lB3Ztkw3PtpsFpDA1JT3fTajElZWLGJEz2bpeWmQzbalQ1zx0jv9E07
         ifs8H5VJBLAgKxV3ApmQo1cvdl5AZ7uuLphLd/jnnK4CS2TyiqT3cdRSjCT3ZrDtdqtl
         v3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849763; x=1713454563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0S/KbBS/htLgbe+dCG/wp90qXPsCpm6GnNXMIBTtTxs=;
        b=PTHQE6Rqqd01L9ccx77hJnOlZoW+9ZGsLAnUxsXF8zBHi5crjd9xG0FZ9J8SULlcgA
         jAe3kdnW6yfsUNDGUxz//csAjGTeX/aarU0CUIVG5iEqYIehGwO/xVOXz9tLLhPrt1d1
         XAicWkyOqnYu4Nd/WqpScWVaxbpHnyoeHK0o3LUMcUBAMujWBajV7oSz3srs8sFzqehu
         7BqUgDp+xZyoebrIuh2OckN/sAz5+4HhoD4ltgS4BhcZGzePiqJUaIMxKDlNh/SxA/Xh
         QuVf7aMdqA/t7uFAY78PlyCQPvIbbzjxybnltPJxY4+x47xmf9mliBt32Rl9+7A9DGH0
         +Png==
X-Gm-Message-State: AOJu0YxyaZsbl1qNnrqiAPFhQB9GNcNSTNVxvN1iW3O5H37LFbJYQL5t
	SKT0a0VrdOgMCxyjqEREFYIY4nCWe+UQT4PEekzHvrl7JshsOicB9zvKrslaQmacxMhbV2/tWQO
	w
X-Google-Smtp-Source: AGHT+IFhgvpq5dTFXW9hWNErVKSMYtXinSYRZpe9YEaMHIrJTs76iU8YGt4ieMfnAjYVf2rUKQErPA==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr184156iov.2.1712849762662;
        Thu, 11 Apr 2024 08:36:02 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 155/437] HID: usbhid: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:55 -0600
Message-ID: <20240411153126.16201-156-axboe@kernel.dk>
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
 drivers/hid/usbhid/hiddev.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 59cf3ddfdf78..19b3e663cf3d 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -308,7 +308,7 @@ static int hiddev_open(struct inode *inode, struct file *file)
 /*
  * "write" file op
  */
-static ssize_t hiddev_write(struct file * file, const char __user * buffer, size_t count, loff_t *ppos)
+static ssize_t hiddev_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return -EINVAL;
 }
@@ -316,10 +316,11 @@ static ssize_t hiddev_write(struct file * file, const char __user * buffer, size
 /*
  * "read" file op
  */
-static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t count, loff_t *ppos)
+static ssize_t hiddev_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	DEFINE_WAIT(wait);
-	struct hiddev_list *list = file->private_data;
+	struct hiddev_list *list = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	int event_size;
 	int retval;
 
@@ -347,7 +348,7 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 					retval = -EIO;
 					break;
 				}
-				if (file->f_flags & O_NONBLOCK) {
+				if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 					retval = -EAGAIN;
 					break;
 				}
@@ -379,7 +380,7 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 
 					event.hid = list->buffer[list->tail].usage_code;
 					event.value = list->buffer[list->tail].value;
-					if (copy_to_user(buffer + retval, &event, sizeof(struct hiddev_event))) {
+					if (!copy_to_iter_full(&event, sizeof(struct hiddev_event), to)) {
 						mutex_unlock(&list->thread_lock);
 						return -EFAULT;
 					}
@@ -389,7 +390,7 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 				if (list->buffer[list->tail].field_index != HID_FIELD_INDEX_NONE ||
 				    (list->flags & HIDDEV_FLAG_REPORT) != 0) {
 
-					if (copy_to_user(buffer + retval, list->buffer + list->tail, sizeof(struct hiddev_usage_ref))) {
+					if (!copy_to_iter_full(list->buffer + list->tail, sizeof(struct hiddev_usage_ref), to)) {
 						mutex_unlock(&list->thread_lock);
 						return -EFAULT;
 					}
@@ -846,8 +847,8 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations hiddev_fops = {
 	.owner =	THIS_MODULE,
-	.read =		hiddev_read,
-	.write =	hiddev_write,
+	.read_iter =	hiddev_read,
+	.write_iter =	hiddev_write,
 	.poll =		hiddev_poll,
 	.open =		hiddev_open,
 	.release =	hiddev_release,
-- 
2.43.0


