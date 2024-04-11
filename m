Return-Path: <linux-kernel+bounces-140778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BF48A18EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A272868CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47FC4AEC3;
	Thu, 11 Apr 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Zv/ZZfuW"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185D481B4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849528; cv=none; b=bZD7de3TluMBqbKYM2kPnTZDfEwUGNxX6gdJ9rbKbg4f1gTrkoiOgnJQeZhIrYFdoa8QdPUGMbJFj53jk7UMQTBJjMR46yUgg5UiXkGHXSpOFOjNS6mzGBXxhGcuwzXxUQG4HZ/EA3wsx3kKmB7gEjJTHe7ASHRZ4kG4yIdCiQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849528; c=relaxed/simple;
	bh=mBIHrHSx0t1Gu8X++/2wE1bS/peUOddMrWDqDawEdEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoeFadHmWNuIMSASKhOFGBPdrgAdLLHe+SRO1h9xbg5t0JIlHORLz2NpPVECyfGrhWE6BG/H3W5kRwcKXIeiE7D5QqZB8MSUl8CN6Rplhuj+Eim5csBvoZfdTmJkPYxb6lDBqESY9rp4voSeTn9a4Kr3HOaJQ8FB7DxXQFEpgRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Zv/ZZfuW; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16098339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849525; x=1713454325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2l6h/jCu8YubbMk7Y4sKs4D1pQIix1cvMgP8JlWQTk=;
        b=Zv/ZZfuWIAN1bizlDPK9Rp3QqEQjaHS4CaOWNjxl9m6NXwAbmKQ+x+FDezO6peu9To
         wFVD1IPGvDEe8BgNtNr/nuvI3Ms36/5JpRzzfUuEhtrrLRY1u+wowzbnE7cbTQw5JR/W
         pMlQZKCS76+8wjqJnxEFFBgJAIdsKWwCEpEI6NM3Jp7fcKS+EN06LAI8+Mj/l4DsiYAb
         VnSTphDAOCZZwJySpXnmj7xA13cdpVxdJJcBZbPy7P++4t3rI3vskuT+zH1vjd8oH/zI
         j6/Qrr4C6Hp7NMyiM1psWjtdF1mu/vTWNk5hnfIWgb17F6fBWnSoe8EaF0gxvjJ4ReVF
         rXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849525; x=1713454325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2l6h/jCu8YubbMk7Y4sKs4D1pQIix1cvMgP8JlWQTk=;
        b=hqp1o0Z2Ffv6GbolUL3WorKODdAWgJosDigrVoRwir0HVuJStaifJxwNE1TWAaDHAI
         PKTuHRWU3PzPZBawwxrDu1hXd4p0I5tA1qULjMoKaQ25JZYQZ+IuIBs5GKwPBzdNbyki
         VXboGbZb0E+l2Il/4TntEA+jYRIa/L+LW0QOrAmtQB7gusPtK6Vfydt9qWbs4QguB/+V
         DtKt6OX8wPMy2x5RVIAFzxld7FDjWErc/fzZZVyw8SybDHJq7u5bwWoPQXklxe0vW1id
         ekFa1YUwm/wcjihV7hwRu0xnaHPpOW6qCQXaxC4Wc3UDfPV8yEiiOkgN9BhtWnljwwwp
         MvfA==
X-Gm-Message-State: AOJu0YyvbFMjLr4hLtnsvY1crGK9Ex39Ip070nFauGh83WGxjeaKsowJ
	TMk81NGN17PLkHpT12bDUB0r0ReZCUVbhPNYpnEMnx2czyJUAV4sU3LQxplHwojWrsUAMfPsFqu
	Z
X-Google-Smtp-Source: AGHT+IEn9kx7aES2I5uP8b+SHKHJtQQRCy1KF63sdUmtkcYEPlFtiKWDcG5UMW2RZJn7sbd1CorbQA==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr148153ioh.1.1712849524925;
        Thu, 11 Apr 2024 08:32:04 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 021/437] char/ipmi: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:41 -0600
Message-ID: <20240411153126.16201-22-axboe@kernel.dk>
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
 drivers/char/ipmi/bt-bmc.c            | 27 +++++++++++++--------------
 drivers/char/ipmi/ipmb_dev_int.c      | 19 ++++++++++---------
 drivers/char/ipmi/ipmi_watchdog.c     | 16 ++++++++--------
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 23 ++++++++++++-----------
 drivers/char/ipmi/ssif_bmc.c          | 25 ++++++++++++++-----------
 5 files changed, 57 insertions(+), 53 deletions(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index 7450904e330a..d8b2e513ed2a 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -15,6 +15,7 @@
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
+#include <linux/uio.h>
 
 /*
  * This is a BMC device used to communicate to the host
@@ -172,17 +173,17 @@ static int bt_bmc_open(struct inode *inode, struct file *file)
  *    Length  NetFn/LUN  Seq     Cmd     Data
  *
  */
-static ssize_t bt_bmc_read(struct file *file, char __user *buf,
-			   size_t count, loff_t *ppos)
+static ssize_t bt_bmc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct bt_bmc *bt_bmc = file_bt_bmc(file);
+	struct bt_bmc *bt_bmc = file_bt_bmc(iocb->ki_filp);
+	size_t count = iov_iter_count(to);
 	u8 len;
 	int len_byte = 1;
 	u8 kbuffer[BT_BMC_BUFFER_SIZE];
 	ssize_t ret = 0;
 	ssize_t nread;
 
-	WARN_ON(*ppos);
+	WARN_ON(iocb->ki_pos);
 
 	if (wait_event_interruptible(bt_bmc->queue,
 				     bt_inb(bt_bmc, BT_CTRL) & BT_CTRL_H2B_ATN))
@@ -215,12 +216,11 @@ static ssize_t bt_bmc_read(struct file *file, char __user *buf,
 
 		bt_readn(bt_bmc, kbuffer + len_byte, nread);
 
-		if (copy_to_user(buf, kbuffer, nread + len_byte)) {
+		if (!copy_to_iter_full(kbuffer, nread + len_byte, to)) {
 			ret = -EFAULT;
 			break;
 		}
 		len -= nread;
-		buf += nread + len_byte;
 		ret += nread + len_byte;
 		len_byte = 0;
 	}
@@ -238,10 +238,10 @@ static ssize_t bt_bmc_read(struct file *file, char __user *buf,
  *    Byte 1  Byte 2     Byte 3  Byte 4  Byte 5  Byte 6:N
  *    Length  NetFn/LUN  Seq     Cmd     Code    Data
  */
-static ssize_t bt_bmc_write(struct file *file, const char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t bt_bmc_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct bt_bmc *bt_bmc = file_bt_bmc(file);
+	struct bt_bmc *bt_bmc = file_bt_bmc(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	u8 kbuffer[BT_BMC_BUFFER_SIZE];
 	ssize_t ret = 0;
 	ssize_t nwritten;
@@ -252,7 +252,7 @@ static ssize_t bt_bmc_write(struct file *file, const char __user *buf,
 	if (count < 5)
 		return -EINVAL;
 
-	WARN_ON(*ppos);
+	WARN_ON(iocb->ki_pos);
 
 	/*
 	 * There's no interrupt for clearing bmc busy so we have to
@@ -275,7 +275,7 @@ static ssize_t bt_bmc_write(struct file *file, const char __user *buf,
 
 	while (count) {
 		nwritten = min_t(ssize_t, count, sizeof(kbuffer));
-		if (copy_from_user(&kbuffer, buf, nwritten)) {
+		if (!copy_from_iter_full(&kbuffer, nwritten, from)) {
 			ret = -EFAULT;
 			break;
 		}
@@ -283,7 +283,6 @@ static ssize_t bt_bmc_write(struct file *file, const char __user *buf,
 		bt_writen(bt_bmc, kbuffer, nwritten);
 
 		count -= nwritten;
-		buf += nwritten;
 		ret += nwritten;
 	}
 
@@ -338,8 +337,8 @@ static __poll_t bt_bmc_poll(struct file *file, poll_table *wait)
 static const struct file_operations bt_bmc_fops = {
 	.owner		= THIS_MODULE,
 	.open		= bt_bmc_open,
-	.read		= bt_bmc_read,
-	.write		= bt_bmc_write,
+	.read_iter	= bt_bmc_read,
+	.write_iter	= bt_bmc_write,
 	.release	= bt_bmc_release,
 	.poll		= bt_bmc_poll,
 	.unlocked_ioctl	= bt_bmc_ioctl,
diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 49100845fcb7..5344095e32a0 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -71,11 +71,11 @@ static inline struct ipmb_dev *to_ipmb_dev(struct file *file)
 	return container_of(file->private_data, struct ipmb_dev, miscdev);
 }
 
-static ssize_t ipmb_read(struct file *file, char __user *buf, size_t count,
-			loff_t *ppos)
+static ssize_t ipmb_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ipmb_dev *ipmb_dev = to_ipmb_dev(file);
+	struct ipmb_dev *ipmb_dev = to_ipmb_dev(iocb->ki_filp);
 	struct ipmb_request_elem *queue_elem;
+	size_t count = iov_iter_count(to);
 	struct ipmb_msg msg;
 	ssize_t ret = 0;
 
@@ -86,7 +86,7 @@ static ssize_t ipmb_read(struct file *file, char __user *buf, size_t count,
 	while (list_empty(&ipmb_dev->request_queue)) {
 		spin_unlock_irq(&ipmb_dev->lock);
 
-		if (file->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
 		ret = wait_event_interruptible(ipmb_dev->wait_queue,
@@ -107,7 +107,7 @@ static ssize_t ipmb_read(struct file *file, char __user *buf, size_t count,
 	spin_unlock_irq(&ipmb_dev->lock);
 
 	count = min_t(size_t, count, msg.len + 1);
-	if (copy_to_user(buf, &msg, count))
+	if (!copy_to_iter_full(&msg, count, to))
 		ret = -EFAULT;
 
 	return ret < 0 ? ret : count;
@@ -176,6 +176,7 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
 
 	return ret < 0 ? ret : count;
 }
+FOPS_WRITE_ITER_HELPER(ipmb_write);
 
 static __poll_t ipmb_poll(struct file *file, poll_table *wait)
 {
@@ -193,10 +194,10 @@ static __poll_t ipmb_poll(struct file *file, poll_table *wait)
 }
 
 static const struct file_operations ipmb_fops = {
-	.owner	= THIS_MODULE,
-	.read	= ipmb_read,
-	.write	= ipmb_write,
-	.poll	= ipmb_poll,
+	.owner		= THIS_MODULE,
+	.read_iter	= ipmb_read,
+	.write_iter	= ipmb_write_iter,
+	.poll		= ipmb_poll,
 };
 
 /* Called with ipmb_dev->lock held. */
diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index 9a459257489f..001a6b522ce4 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -37,6 +37,7 @@
 #include <linux/delay.h>
 #include <linux/atomic.h>
 #include <linux/sched/signal.h>
+#include <linux/uio.h>
 
 #ifdef CONFIG_X86
 /*
@@ -777,12 +778,11 @@ static ssize_t ipmi_write(struct file *file,
 	}
 	return len;
 }
+FOPS_WRITE_ITER_HELPER(ipmi_write);
 
-static ssize_t ipmi_read(struct file *file,
-			 char        __user *buf,
-			 size_t      count,
-			 loff_t      *ppos)
+static ssize_t ipmi_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	int          rv = 0;
 	wait_queue_entry_t wait;
 
@@ -795,7 +795,7 @@ static ssize_t ipmi_read(struct file *file,
 	 */
 	spin_lock_irq(&ipmi_read_lock);
 	if (!data_to_read) {
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			rv = -EAGAIN;
 			goto out;
 		}
@@ -821,7 +821,7 @@ static ssize_t ipmi_read(struct file *file,
 	spin_unlock_irq(&ipmi_read_lock);
 
 	if (rv == 0) {
-		if (copy_to_user(buf, &data_to_read, 1))
+		if (!copy_to_iter_full(&data_to_read, 1, to))
 			rv = -EFAULT;
 		else
 			rv = 1;
@@ -895,9 +895,9 @@ static int ipmi_close(struct inode *ino, struct file *filep)
 
 static const struct file_operations ipmi_wdog_fops = {
 	.owner   = THIS_MODULE,
-	.read    = ipmi_read,
+	.read_iter    = ipmi_read,
 	.poll    = ipmi_poll,
-	.write   = ipmi_write,
+	.write_iter   = ipmi_write_iter,
 	.unlocked_ioctl = ipmi_unlocked_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open    = ipmi_open,
diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
index cf670e891966..1cd9b4c1fec9 100644
--- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
+++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
@@ -16,6 +16,7 @@
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/uio.h>
 
 #include "kcs_bmc_client.h"
 
@@ -317,15 +318,15 @@ static __poll_t kcs_bmc_ipmi_poll(struct file *filp, poll_table *wait)
 	return mask;
 }
 
-static ssize_t kcs_bmc_ipmi_read(struct file *filp, char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t kcs_bmc_ipmi_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct kcs_bmc_ipmi *priv = to_kcs_bmc(filp);
+	struct kcs_bmc_ipmi *priv = to_kcs_bmc(iocb->ki_filp);
+	size_t count = iov_iter_count(to);
 	bool data_avail;
 	size_t data_len;
 	ssize_t ret;
 
-	if (!(filp->f_flags & O_NONBLOCK))
+	if (!(iocb->ki_filp->f_flags & O_NONBLOCK))
 		wait_event_interruptible(priv->queue,
 					 priv->data_in_avail);
 
@@ -356,7 +357,7 @@ static ssize_t kcs_bmc_ipmi_read(struct file *filp, char __user *buf,
 		goto out_unlock;
 	}
 
-	if (copy_to_user(buf, priv->kbuffer, data_len)) {
+	if (!copy_to_iter_full(priv->kbuffer, data_len, to)) {
 		ret = -EFAULT;
 		goto out_unlock;
 	}
@@ -379,10 +380,10 @@ static ssize_t kcs_bmc_ipmi_read(struct file *filp, char __user *buf,
 	return ret;
 }
 
-static ssize_t kcs_bmc_ipmi_write(struct file *filp, const char __user *buf,
-			     size_t count, loff_t *ppos)
+static ssize_t kcs_bmc_ipmi_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct kcs_bmc_ipmi *priv = to_kcs_bmc(filp);
+	struct kcs_bmc_ipmi *priv = to_kcs_bmc(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	ssize_t ret;
 
 	/* a minimum response size '3' : netfn + cmd + ccode */
@@ -391,7 +392,7 @@ static ssize_t kcs_bmc_ipmi_write(struct file *filp, const char __user *buf,
 
 	mutex_lock(&priv->mutex);
 
-	if (copy_from_user(priv->kbuffer, buf, count)) {
+	if (!copy_from_iter_full(priv->kbuffer, count, from)) {
 		ret = -EFAULT;
 		goto out_unlock;
 	}
@@ -459,8 +460,8 @@ static int kcs_bmc_ipmi_release(struct inode *inode, struct file *filp)
 static const struct file_operations kcs_bmc_ipmi_fops = {
 	.owner          = THIS_MODULE,
 	.open           = kcs_bmc_ipmi_open,
-	.read           = kcs_bmc_ipmi_read,
-	.write          = kcs_bmc_ipmi_write,
+	.read_iter      = kcs_bmc_ipmi_read,
+	.write_iter     = kcs_bmc_ipmi_write,
 	.release        = kcs_bmc_ipmi_release,
 	.poll           = kcs_bmc_ipmi_poll,
 	.unlocked_ioctl = kcs_bmc_ipmi_ioctl,
diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
index 56346fb32872..9a907c84d182 100644
--- a/drivers/char/ipmi/ssif_bmc.c
+++ b/drivers/char/ipmi/ssif_bmc.c
@@ -130,9 +130,10 @@ static const char *state_to_string(enum ssif_state state)
 }
 
 /* Handle SSIF message that will be sent to user */
-static ssize_t ssif_bmc_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+static ssize_t ssif_bmc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ssif_bmc_ctx *ssif_bmc = to_ssif_bmc(file);
+	struct ssif_bmc_ctx *ssif_bmc = to_ssif_bmc(iocb->ki_filp);
+	size_t count = iov_iter_count(to);
 	struct ipmi_ssif_msg msg;
 	unsigned long flags;
 	ssize_t ret;
@@ -140,7 +141,7 @@ static ssize_t ssif_bmc_read(struct file *file, char __user *buf, size_t count,
 	spin_lock_irqsave(&ssif_bmc->lock, flags);
 	while (!ssif_bmc->request_available) {
 		spin_unlock_irqrestore(&ssif_bmc->lock, flags);
-		if (file->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 		ret = wait_event_interruptible(ssif_bmc->wait_queue,
 					       ssif_bmc->request_available);
@@ -162,17 +163,19 @@ static ssize_t ssif_bmc_read(struct file *file, char __user *buf, size_t count,
 		ssif_bmc->request_available = false;
 		spin_unlock_irqrestore(&ssif_bmc->lock, flags);
 
-		ret = copy_to_user(buf, &msg, count);
+		ret = -EFAULT;
+		if (copy_to_iter_full(&msg, count, to))
+			ret = 0;
 	}
 
 	return (ret < 0) ? ret : count;
 }
 
 /* Handle SSIF message that is written by user */
-static ssize_t ssif_bmc_write(struct file *file, const char __user *buf, size_t count,
-			      loff_t *ppos)
+static ssize_t ssif_bmc_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ssif_bmc_ctx *ssif_bmc = to_ssif_bmc(file);
+	struct ssif_bmc_ctx *ssif_bmc = to_ssif_bmc(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	struct ipmi_ssif_msg msg;
 	unsigned long flags;
 	ssize_t ret;
@@ -180,7 +183,7 @@ static ssize_t ssif_bmc_write(struct file *file, const char __user *buf, size_t
 	if (count > sizeof(struct ipmi_ssif_msg))
 		return -EINVAL;
 
-	if (copy_from_user(&msg, buf, count))
+	if (!copy_from_iter_full(&msg, count, from))
 		return -EFAULT;
 
 	if (!msg.len || count < sizeof_field(struct ipmi_ssif_msg, len) + msg.len)
@@ -189,7 +192,7 @@ static ssize_t ssif_bmc_write(struct file *file, const char __user *buf, size_t
 	spin_lock_irqsave(&ssif_bmc->lock, flags);
 	while (ssif_bmc->response_in_progress) {
 		spin_unlock_irqrestore(&ssif_bmc->lock, flags);
-		if (file->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 		ret = wait_event_interruptible(ssif_bmc->wait_queue,
 					       !ssif_bmc->response_in_progress);
@@ -275,8 +278,8 @@ static int ssif_bmc_release(struct inode *inode, struct file *file)
 static const struct file_operations ssif_bmc_fops = {
 	.owner		= THIS_MODULE,
 	.open		= ssif_bmc_open,
-	.read		= ssif_bmc_read,
-	.write		= ssif_bmc_write,
+	.read_iter	= ssif_bmc_read,
+	.write_iter	= ssif_bmc_write,
 	.release	= ssif_bmc_release,
 	.poll		= ssif_bmc_poll,
 };
-- 
2.43.0


