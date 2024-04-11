Return-Path: <linux-kernel+bounces-140974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8358A19DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C551C2155C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4551978C9C;
	Thu, 11 Apr 2024 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="twjH1zcd"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C7278C72
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849846; cv=none; b=qeCDyPqpyRSDuCSgdwayFhzHwqDjv/TbP7NlxVa1SHInEBl8R/ZJ2O17Rllq9iGp/PoPZWyul51Dd0eOEBq5degJ89g6yEHazBqSu+EKnO5qYs9A+M2udvtoGAGgAP+ERt12maehi/EleK8GxxIEuZhBj3r82ZyBbDfAER2/quk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849846; c=relaxed/simple;
	bh=c4VQjDpBziD9iQRRsEw79UZ23vGA/d6lw6QGoXIK980=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgirqUH+qYLcu2gQH/QlQaZC8aEwfgSFWrC8PjYrJYvVyJiF23Qj4o5om+D4SIicRS9t/qfbKkPhL5YwYwYrLTnfXprkjU2CjxCgtp0vpqej1hccJaeJEQ/ia0Zptj30WmVF4kg5GiP7/YfLuNiVJezPhxWvp6Qs7ZgSnWq7KkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=twjH1zcd; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36a224d7414so185645ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849843; x=1713454643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVcA11oiqqKckOIJKSAr7zcRS6dozXsd/egI2hKWTf0=;
        b=twjH1zcdKWU+4js0Og3OMdhLNmmY668O1FaSR+xkEG+TFonttdI7McQ3cQ7Mqrt5ma
         qJTSsJ+MF9FXVlfOFn6WbKb0v+RPLY39+vwpjGakI8pa0Mtti41LcNxbS5SRZjojbAqM
         yIcQSGwOj0S2ohzbcE/A2dczBwD+EVMeb+vRZ157rXCpCHndeeoNEo/N1keFePqCm9m9
         kcqxiHJBKiulznydUh56E/4N1Cbwu9j1gWDhHIo7rY2zupm8JFAerhrjJrcEZ3cdUJnR
         FKmlMjDKxJEitwoEihYG13/ISWsoieOJhbEqm23/fv2Shlo/02enaPefa66nH/ffKVmP
         OdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849843; x=1713454643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVcA11oiqqKckOIJKSAr7zcRS6dozXsd/egI2hKWTf0=;
        b=fw00/4hXPjItGJ7VKVSchFISQVDwhxjeqeMBIcfXEmknSgANmCjjfGWylD5xUMnFBJ
         dpe4ajoo5MO1JcIABKrOObC+bObw6yO3RFC2yhkJtw08F64+g8JoV5WI7QBHEzc/72dL
         R/EyJCpQ3/TMy+DTucfXjydlvdD6J75ybEme517/hj6vvXvTIcptIbvdmkgxtS5gjgEL
         Mk/Xa1fPI+Cb9bWAT3wf8U+mV1AuiiLNm/056jVHQH/9pM7T7vZuvUfEBKSWfM5HE/f0
         LegoGwIe5kOM0/PwdkcW1l1Lmo5HajpiAv02g1EUFDvKiwlT7iHc4D/6AMFxw67Mke2d
         mYqw==
X-Gm-Message-State: AOJu0YwCjRUn3RqkJmReyl4mMBxVhmr3zeMke/Jy++9OP2cPBuuTQtnB
	marppPK3neHRYK42vjfFnxiJm6ZUyRQoGZ+92Y50+PXaNUX1F1TYC5vJsFz3a7rCy24XNKTn+39
	i
X-Google-Smtp-Source: AGHT+IH0WMBZqOc3AZXqlMmX8eArsu9N275SgHnwH2q/eBuc5sPcd0b9N1yWQQcnV2NSgg9OR4td5A==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr152171ioc.2.1712849843372;
        Thu, 11 Apr 2024 08:37:23 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 205/437] drivers/xen: convert to ->read_iter and ->write_iter
Date: Thu, 11 Apr 2024 09:15:45 -0600
Message-ID: <20240411153126.16201-206-axboe@kernel.dk>
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
 drivers/xen/evtchn.c                     | 25 ++++++++++++------------
 drivers/xen/mcelog.c                     | 17 ++++++++--------
 drivers/xen/xenbus/xenbus_dev_frontend.c | 24 +++++++++++------------
 drivers/xen/xenfs/super.c                |  7 +++----
 drivers/xen/xenfs/xenstored.c            | 11 +++++------
 drivers/xen/xenfs/xensyms.c              |  2 +-
 6 files changed, 42 insertions(+), 44 deletions(-)

diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index f6a2216c2c87..06af1a458e44 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -51,6 +51,7 @@
 #include <linux/cpu.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
+#include <linux/uio.h>
 
 #include <xen/xen.h>
 #include <xen/events.h>
@@ -197,12 +198,12 @@ static irqreturn_t evtchn_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static ssize_t evtchn_read(struct file *file, char __user *buf,
-			   size_t count, loff_t *ppos)
+static ssize_t evtchn_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int rc;
 	unsigned int c, p, bytes1 = 0, bytes2 = 0;
-	struct per_user_data *u = file->private_data;
+	struct per_user_data *u = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 
 	/* Whole number of ports. */
 	count &= ~(sizeof(evtchn_port_t)-1);
@@ -227,7 +228,7 @@ static ssize_t evtchn_read(struct file *file, char __user *buf,
 
 		mutex_unlock(&u->ring_cons_mutex);
 
-		if (file->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
 		rc = wait_event_interruptible(u->evtchn_wait,
@@ -256,9 +257,9 @@ static ssize_t evtchn_read(struct file *file, char __user *buf,
 
 	rc = -EFAULT;
 	smp_rmb(); /* Ensure that we see the port before we copy it. */
-	if (copy_to_user(buf, evtchn_ring_entry(u, c), bytes1) ||
+	if (!copy_to_iter_full(evtchn_ring_entry(u, c), bytes1, to) ||
 	    ((bytes2 != 0) &&
-	     copy_to_user(&buf[bytes1], &u->ring[0], bytes2)))
+	     !copy_to_iter_full(&u->ring[0], bytes2, to)))
 		goto unlock_out;
 
 	WRITE_ONCE(u->ring_cons, c + (bytes1 + bytes2) / sizeof(evtchn_port_t));
@@ -269,12 +270,12 @@ static ssize_t evtchn_read(struct file *file, char __user *buf,
 	return rc;
 }
 
-static ssize_t evtchn_write(struct file *file, const char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t evtchn_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int rc, i;
 	evtchn_port_t *kbuf = (evtchn_port_t *)__get_free_page(GFP_KERNEL);
-	struct per_user_data *u = file->private_data;
+	struct per_user_data *u = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 
 	if (kbuf == NULL)
 		return -ENOMEM;
@@ -290,7 +291,7 @@ static ssize_t evtchn_write(struct file *file, const char __user *buf,
 		count = PAGE_SIZE;
 
 	rc = -EFAULT;
-	if (copy_from_user(kbuf, buf, count) != 0)
+	if (!copy_from_iter_full(kbuf, count, from) != 0)
 		goto out;
 
 	mutex_lock(&u->bind_mutex);
@@ -687,8 +688,8 @@ static int evtchn_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations evtchn_fops = {
 	.owner   = THIS_MODULE,
-	.read    = evtchn_read,
-	.write   = evtchn_write,
+	.read_iter    = evtchn_read,
+	.write_iter   = evtchn_write,
 	.unlocked_ioctl = evtchn_ioctl,
 	.poll    = evtchn_poll,
 	.fasync  = evtchn_fasync,
diff --git a/drivers/xen/mcelog.c b/drivers/xen/mcelog.c
index e9ac3b8c4167..610b5f746ca4 100644
--- a/drivers/xen/mcelog.c
+++ b/drivers/xen/mcelog.c
@@ -103,10 +103,10 @@ static int xen_mce_chrdev_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t xen_mce_chrdev_read(struct file *filp, char __user *ubuf,
-				size_t usize, loff_t *off)
+static ssize_t xen_mce_chrdev_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	char __user *buf = ubuf;
+	size_t usize = iov_iter_count(to);
+	ssize_t copied;
 	unsigned num;
 	int i, err;
 
@@ -116,15 +116,16 @@ static ssize_t xen_mce_chrdev_read(struct file *filp, char __user *ubuf,
 
 	/* Only supports full reads right now */
 	err = -EINVAL;
-	if (*off != 0 || usize < XEN_MCE_LOG_LEN*sizeof(struct xen_mce))
+	if (iocb->ki_pos != 0 || usize < XEN_MCE_LOG_LEN*sizeof(struct xen_mce))
 		goto out;
 
 	err = 0;
+	copied = 0;
 	for (i = 0; i < num; i++) {
 		struct xen_mce *m = &xen_mcelog.entry[i];
 
-		err |= copy_to_user(buf, m, sizeof(*m));
-		buf += sizeof(*m);
+		err |= !copy_to_iter_full(m, sizeof(*m), to);
+		copied += sizeof(*m);
 	}
 
 	memset(xen_mcelog.entry, 0, num * sizeof(struct xen_mce));
@@ -136,7 +137,7 @@ static ssize_t xen_mce_chrdev_read(struct file *filp, char __user *ubuf,
 out:
 	mutex_unlock(&mcelog_lock);
 
-	return err ? err : buf - ubuf;
+	return err ? err : copied;
 }
 
 static __poll_t xen_mce_chrdev_poll(struct file *file, poll_table *wait)
@@ -179,7 +180,7 @@ static long xen_mce_chrdev_ioctl(struct file *f, unsigned int cmd,
 static const struct file_operations xen_mce_chrdev_ops = {
 	.open			= xen_mce_chrdev_open,
 	.release		= xen_mce_chrdev_release,
-	.read			= xen_mce_chrdev_read,
+	.read_iter		= xen_mce_chrdev_read,
 	.poll			= xen_mce_chrdev_poll,
 	.unlocked_ioctl		= xen_mce_chrdev_ioctl,
 	.llseek			= no_llseek,
diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index 6f56640092a9..3da823abfdc0 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -122,11 +122,10 @@ struct xenbus_file_priv {
 };
 
 /* Read out any raw xenbus messages queued up. */
-static ssize_t xenbus_file_read(struct file *filp,
-			       char __user *ubuf,
-			       size_t len, loff_t *ppos)
+static ssize_t xenbus_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct xenbus_file_priv *u = filp->private_data;
+	struct xenbus_file_priv *u = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	struct read_buffer *rb;
 	ssize_t i;
 	int ret;
@@ -135,7 +134,7 @@ static ssize_t xenbus_file_read(struct file *filp,
 again:
 	while (list_empty(&u->read_buffers)) {
 		mutex_unlock(&u->reply_mutex);
-		if (filp->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
 		ret = wait_event_interruptible(u->read_waitq,
@@ -150,7 +149,7 @@ static ssize_t xenbus_file_read(struct file *filp,
 	while (i < len) {
 		size_t sz = min_t(size_t, len - i, rb->len - rb->cons);
 
-		ret = copy_to_user(ubuf + i, &rb->msg[rb->cons], sz);
+		ret = !copy_to_iter_full(&rb->msg[rb->cons], sz, to);
 
 		i += sz - ret;
 		rb->cons += sz - ret;
@@ -547,11 +546,10 @@ static int xenbus_write_watch(unsigned msg_type, struct xenbus_file_priv *u)
 	return rc;
 }
 
-static ssize_t xenbus_file_write(struct file *filp,
-				const char __user *ubuf,
-				size_t len, loff_t *ppos)
+static ssize_t xenbus_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct xenbus_file_priv *u = filp->private_data;
+	struct xenbus_file_priv *u = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	uint32_t msg_type;
 	int rc = len;
 	int ret;
@@ -585,7 +583,7 @@ static ssize_t xenbus_file_write(struct file *filp,
 		goto out;
 	}
 
-	ret = copy_from_user(u->u.buffer + u->len, ubuf, len);
+	ret = !copy_from_iter_full(u->u.buffer + u->len, len, from);
 
 	if (ret != 0) {
 		rc = -EFAULT;
@@ -695,8 +693,8 @@ static __poll_t xenbus_file_poll(struct file *file, poll_table *wait)
 }
 
 const struct file_operations xen_xenbus_fops = {
-	.read = xenbus_file_read,
-	.write = xenbus_file_write,
+	.read_iter = xenbus_file_read,
+	.write_iter = xenbus_file_write,
 	.open = xenbus_file_open,
 	.release = xenbus_file_release,
 	.poll = xenbus_file_poll,
diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
index d7d64235010d..54e4e4702572 100644
--- a/drivers/xen/xenfs/super.c
+++ b/drivers/xen/xenfs/super.c
@@ -28,19 +28,18 @@
 MODULE_DESCRIPTION("Xen filesystem");
 MODULE_LICENSE("GPL");
 
-static ssize_t capabilities_read(struct file *file, char __user *buf,
-				 size_t size, loff_t *off)
+static ssize_t capabilities_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *tmp = "";
 
 	if (xen_initial_domain())
 		tmp = "control_d\n";
 
-	return simple_read_from_buffer(buf, size, off, tmp, strlen(tmp));
+	return simple_copy_to_iter(tmp, &iocb->ki_pos, strlen(tmp), to);
 }
 
 static const struct file_operations capabilities_file_ops = {
-	.read = capabilities_read,
+	.read_iter = capabilities_read,
 	.llseek = default_llseek,
 };
 
diff --git a/drivers/xen/xenfs/xenstored.c b/drivers/xen/xenfs/xenstored.c
index f59235f9f8a2..c4e8692deac2 100644
--- a/drivers/xen/xenfs/xenstored.c
+++ b/drivers/xen/xenfs/xenstored.c
@@ -9,11 +9,10 @@
 
 #include "xenfs.h"
 
-static ssize_t xsd_read(struct file *file, char __user *buf,
-			    size_t size, loff_t *off)
+static ssize_t xsd_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	const char *str = (const char *)file->private_data;
-	return simple_read_from_buffer(buf, size, off, str, strlen(str));
+	const char *str = (const char *)iocb->ki_filp->private_data;
+	return simple_copy_to_iter(str, &iocb->ki_pos, strlen(str), to);
 }
 
 static int xsd_release(struct inode *inode, struct file *file)
@@ -49,7 +48,7 @@ static int xsd_kva_mmap(struct file *file, struct vm_area_struct *vma)
 const struct file_operations xsd_kva_file_ops = {
 	.open = xsd_kva_open,
 	.mmap = xsd_kva_mmap,
-	.read = xsd_read,
+	.read_iter = xsd_read,
 	.release = xsd_release,
 };
 
@@ -64,6 +63,6 @@ static int xsd_port_open(struct inode *inode, struct file *file)
 
 const struct file_operations xsd_port_file_ops = {
 	.open = xsd_port_open,
-	.read = xsd_read,
+	.read_iter = xsd_read,
 	.release = xsd_release,
 };
diff --git a/drivers/xen/xenfs/xensyms.c b/drivers/xen/xenfs/xensyms.c
index b799bc759c15..ec30aa09620f 100644
--- a/drivers/xen/xenfs/xensyms.c
+++ b/drivers/xen/xenfs/xensyms.c
@@ -146,7 +146,7 @@ static int xensyms_release(struct inode *inode, struct file *file)
 
 const struct file_operations xensyms_ops = {
 	.open = xensyms_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = xensyms_release
 };
-- 
2.43.0


