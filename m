Return-Path: <linux-kernel+bounces-140983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 453AE8A19EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476D21C21048
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25271BE3EE;
	Thu, 11 Apr 2024 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3Ozb8xI+"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A4824B1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849859; cv=none; b=bqV2UJwBWZJY30UC7mfnT3wS/AsRWfJ2q5KC/w2XRE2+RgIkp0pRxhKtwtATlRRpqX5HvEaxfmrRmfZ6cs3hH4y7gsaueScfg5CC7xYG6R7xixJI3scjKSUmyJv9GRdJeV3DoaXojLVon5h7oCha/pSFizHV8IMwdFe6IVe9rqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849859; c=relaxed/simple;
	bh=sF5CnpUgy1jnJz8h8X7hCF8xIhL0U1ovl4Q04fzjlSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1LzzwswE+bDKiyOKYDbFfUJIoe/1yHDCA78t9zCXW+BMNAirUBBdQKJmx9zXNtjF0ee2gtFWjkHq0BVbGG41tYxj/XBPE44dOiQOOS2Y9IDVtlcVYqgUhAoEOUjN2GQmw2Peu3U8JGu81BqZnLFbIrPieKZFnST+iCAwLQaMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3Ozb8xI+; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170543839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849856; x=1713454656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsFGX0TYl3O1OSJSeVzEizUpvXJtnGL1+uYUf77M1nU=;
        b=3Ozb8xI+hxmahmERtsyWFoxiWw89WVLFPy9JW8qq0qhTf9KrcRI8oUE8a4KH2rildy
         UNXLqr++qxNol2DjbmblUj1hajJuBkpGFLKqt8OtICTX0bzEu5V9s7a/AjGDLfW5vyth
         a+hR/wrvPPqhIlBBcEi2EXsyQuDFyh9sEBv76QLWpBclX8UTO8GObLa++9zs13jVU7wP
         q8SO9LrY83Z62uy7PbZY/oiWAMtL6Hz2QLIPZPc7gUMTrUQmamwV8mzM4okQ12Bt6fe6
         YooNjzkpK9mDececZLnYmmKmHg95+HfzqGhSMIBwYHyHINLsSrBnNo5bopDOvvTxic8m
         HQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849856; x=1713454656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsFGX0TYl3O1OSJSeVzEizUpvXJtnGL1+uYUf77M1nU=;
        b=upYT7DIYFANibfgerVQkLHQXbIpAA4JnxPGIUP+GmPcgtDcJXyQ0W6VzUZ3yLeH2Wf
         tXT7l0sicuQsItJNhS67bQg4zD/DPelvKt/oLvtdteXNsI7wc7lwCWPIhGVXJcaMzdUP
         mMDxbqp8YjIzAiCdwtzJRwwf/OgZ03Eg2JHBQEiKrYyN7RaBCCPWgv/v4d5ImdOOESJa
         Yq74JihIy5PqhFS6iHTiJ5AcUhOZYejOQnqN0h/PTcnCILCftMyCX5sEBU+ZAVnMnAtt
         3qJsqYwMQJuPzbyeFKnTxzVjltNmwusqyDikli6VNuQikhJGfR4MqM2ZJ6F4tT22X9ZV
         u71Q==
X-Gm-Message-State: AOJu0YwBMVLGXXHQzITDj7PYWPkkkI+BvUJcPB8yiYdhlOl/tFfpyzXb
	SuWwHba1Px6GkolCR2eOBzxV/Gcrccadqsdf9HfoYnYKNtG2lW6wmjfr4CWR9OZyhqnyzdWztp8
	U
X-Google-Smtp-Source: AGHT+IEQ0qgle4KJlGoYgug2VFdto2t72uKs/ssKrgEqzUoFAI3nRkJ5TyBiUnhjFRmIr0tRrmh2rg==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr184463ioj.2.1712849855019;
        Thu, 11 Apr 2024 08:37:35 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 212/437] misc: bcm_vk: convert to iterators
Date: Thu, 11 Apr 2024 09:15:52 -0600
Message-ID: <20240411153126.16201-213-axboe@kernel.dk>
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
 drivers/misc/bcm-vk/bcm_vk.h     |  6 ++----
 drivers/misc/bcm-vk/bcm_vk_dev.c |  4 ++--
 drivers/misc/bcm-vk/bcm_vk_msg.c | 23 ++++++++++-------------
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index 386884c2a263..efc91635fa42 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -487,10 +487,8 @@ static inline bool bcm_vk_msgq_marker_valid(struct bcm_vk *vk)
 }
 
 int bcm_vk_open(struct inode *inode, struct file *p_file);
-ssize_t bcm_vk_read(struct file *p_file, char __user *buf, size_t count,
-		    loff_t *f_pos);
-ssize_t bcm_vk_write(struct file *p_file, const char __user *buf,
-		     size_t count, loff_t *f_pos);
+ssize_t bcm_vk_read(struct kiocb *iocb, struct iov_iter *to);
+ssize_t bcm_vk_write(struct kiocb *iocb, struct iov_iter *from);
 __poll_t bcm_vk_poll(struct file *p_file, struct poll_table_struct *wait);
 int bcm_vk_release(struct inode *inode, struct file *p_file);
 void bcm_vk_release_data(struct kref *kref);
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index d4a96137728d..1fadb7b2dec1 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1258,8 +1258,8 @@ static long bcm_vk_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 static const struct file_operations bcm_vk_fops = {
 	.owner = THIS_MODULE,
 	.open = bcm_vk_open,
-	.read = bcm_vk_read,
-	.write = bcm_vk_write,
+	.read_iter = bcm_vk_read,
+	.write_iter = bcm_vk_write,
 	.poll = bcm_vk_poll,
 	.release = bcm_vk_release,
 	.mmap = bcm_vk_mmap,
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index 1f42d1d5a630..31418a677ecd 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -13,6 +13,7 @@
 #include <linux/sizes.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
+#include <linux/uio.h>
 
 #include "bcm_vk.h"
 #include "bcm_vk_msg.h"
@@ -998,18 +999,16 @@ int bcm_vk_open(struct inode *inode, struct file *p_file)
 	return rc;
 }
 
-ssize_t bcm_vk_read(struct file *p_file,
-		    char __user *buf,
-		    size_t count,
-		    loff_t *f_pos)
+ssize_t bcm_vk_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t rc = -ENOMSG;
-	struct bcm_vk_ctx *ctx = p_file->private_data;
+	struct bcm_vk_ctx *ctx = iocb->ki_filp->private_data;
 	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk,
 					 miscdev);
 	struct device *dev = &vk->pdev->dev;
 	struct bcm_vk_msg_chan *chan = &vk->to_h_msg_chan;
 	struct bcm_vk_wkent *entry = NULL, *iter;
+	size_t count = iov_iter_count(to);
 	u32 q_num;
 	u32 rsp_length;
 
@@ -1047,7 +1046,7 @@ ssize_t bcm_vk_read(struct file *p_file,
 		/* retrieve the passed down msg_id */
 		set_msg_id(&entry->to_h_msg[0], entry->usr_msg_id);
 		rsp_length = entry->to_h_blks * VK_MSGQ_BLK_SIZE;
-		if (copy_to_user(buf, entry->to_h_msg, rsp_length) == 0)
+		if (!copy_to_iter_full(entry->to_h_msg, rsp_length, to))
 			rc = rsp_length;
 
 		bcm_vk_free_wkent(dev, entry);
@@ -1060,7 +1059,7 @@ ssize_t bcm_vk_read(struct file *p_file,
 		 */
 		set_msg_id(&tmp_msg, entry->usr_msg_id);
 		tmp_msg.size = entry->to_h_blks - 1;
-		if (copy_to_user(buf, &tmp_msg, VK_MSGQ_BLK_SIZE) != 0) {
+		if (!copy_to_iter_full(&tmp_msg, VK_MSGQ_BLK_SIZE, to)) {
 			dev_err(dev, "Error return 1st block in -EMSGSIZE\n");
 			rc = -EFAULT;
 		}
@@ -1068,17 +1067,15 @@ ssize_t bcm_vk_read(struct file *p_file,
 	return rc;
 }
 
-ssize_t bcm_vk_write(struct file *p_file,
-		     const char __user *buf,
-		     size_t count,
-		     loff_t *f_pos)
+ssize_t bcm_vk_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	ssize_t rc;
-	struct bcm_vk_ctx *ctx = p_file->private_data;
+	struct bcm_vk_ctx *ctx = iocb->ki_filp->private_data;
 	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk,
 					 miscdev);
 	struct bcm_vk_msgq __iomem *msgq;
 	struct device *dev = &vk->pdev->dev;
+	size_t count = iov_iter_count(from);
 	struct bcm_vk_wkent *entry;
 	u32 sgl_extra_blks;
 	u32 q_num;
@@ -1107,7 +1104,7 @@ ssize_t bcm_vk_write(struct file *p_file,
 	}
 
 	/* now copy msg from user space, and then formulate the work entry */
-	if (copy_from_user(&entry->to_v_msg[0], buf, count)) {
+	if (!copy_from_iter_full(&entry->to_v_msg[0], count, from)) {
 		rc = -EFAULT;
 		goto write_free_ent;
 	}
-- 
2.43.0


