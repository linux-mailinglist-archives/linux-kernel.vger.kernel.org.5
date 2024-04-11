Return-Path: <linux-kernel+bounces-141095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F94E8A1A76
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478DD2857A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167DF502B8;
	Thu, 11 Apr 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SUh8+stY"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE41DFFB0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850028; cv=none; b=RnBExgMxVS4ry/ZjyYA0VSNeGGHn6AS/s3QwiqIElZg0P1x3fBYnDbNHcyiQB8kKkR/9iSQ8hQe5vqVuhWVwqNYemfo5l+RVB6tez0oopluEJHPGDQv0fXPa0rL0yPc1JpqdFkgKwqn/6l3LtaddWO2z+ZTLGqTb+qiShxt4DxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850028; c=relaxed/simple;
	bh=oC6a0Gd10K11/+ufORoDT+9yN42tBtp9STpMEhhv5Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stwdZidQka4+ezBsCIoKKIGnN+3E5zv+fvx6wpivlRdIU1QN6xVEy47KvVP/MoOpMj809YKCqZNGuKgJpwc9+nOrtUG/itL7oaRATI57j5BQF4b6COggcqcns2aEH5gxyTbzVJD7r6LakthEd7HgCz8WFRBXSkEyKmmtf2MwhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SUh8+stY; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58195939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850025; x=1713454825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI6DXs9QWs+QKUxT680gRKpCLBxQaneIFwEC/MVVBUY=;
        b=SUh8+stYs9I26GrykjsnoyddwfYk8cXGZvbiN6cjqHfaPIj2bU/WSDnzmpWjVNw2lm
         yKEG14oy+nG8G7uzpWv03bh6G3IIPdMcfssytEdx28IITmaCd7hZEIBr79OGLRZDPS3X
         0JfC0FSxbtreA9JY961UsVVk6zL8Mpkptafm2U/j68d1wyZyI4Hs0WQI4Z1BZCvTfFEy
         6mdyeRmE2UJ+MtHBtDKRnQzaJ1CxtL0RsWOCyQXsMa1BirQx8/rooQRbZMPbXRMMziDk
         SuM7dB6cBUUa19QRQszEm02QNqVogLOTNBEGK0Hm5r2KLSazA9U7H8tVTg/OCZf05rl/
         T7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850025; x=1713454825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HI6DXs9QWs+QKUxT680gRKpCLBxQaneIFwEC/MVVBUY=;
        b=SX+47ai5he7xY+PP8mMQoa5reJ6+IoBwwcZIBWMPw9B5r2UaSvErRDZWQxwCrLE2JC
         bxzm3ABd/QGnA7HPq8NfSM06ZzlPLBRBDVe1m/7MWf8+mHLKZ86L19hcTLBpmZLt8iXJ
         w5JeuYYJJBUS4cPGrMGsH3lZ46HyhZWHrJX+UGX/pNSwuMWdyEaBozjKHI1VnVdw1Nlj
         bhS4SIbnb8ZgDWYyFJ/3d6v1m0VOgNGd38bIzTc2YIL67dp7EDwMSrgaeoVzlfCvefMI
         B835bA5joatUGZus9+t0HqVf7zLsi0MMLZSJNaVlNtqF2ci5AFGJtaVkEHmHhGt9QWv/
         BvtA==
X-Gm-Message-State: AOJu0Yw8/cACEJr9gCVXoaXfwYLwQ1hZKZ8X3mJJD4eHhoB7x5G8TROP
	KdD4elwG9q5SfuziVzyXcfRwAuP0Kpmwe9pWDHp1xkMXfWsI5Z3LlCsJU3tI2diKrxDXcO/Vp9G
	O
X-Google-Smtp-Source: AGHT+IH/14r27JPZAqqjnrVa5KnOGgW40oeIj0gDzwnFc/6nVFDqX15xZM/aAtU0KXnQkNI7dR2sfw==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr198488iov.2.1712850025382;
        Thu, 11 Apr 2024 08:40:25 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 317/437] drivers/net/wwan: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:37 -0600
Message-ID: <20240411153126.16201-318-axboe@kernel.dk>
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
 drivers/net/wwan/iosm/iosm_ipc_trace.c | 21 ++++++-------
 drivers/net/wwan/wwan_core.c           | 26 ++++++++--------
 drivers/net/wwan/wwan_hwsim.c          | 42 ++++++++++++--------------
 3 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_trace.c b/drivers/net/wwan/iosm/iosm_ipc_trace.c
index eeecfa3d10c5..8374bd4826bc 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_trace.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_trace.c
@@ -70,10 +70,9 @@ static struct rchan_callbacks relay_callbacks = {
 };
 
 /* Copy the trace control mode to user buffer */
-static ssize_t ipc_trace_ctrl_file_read(struct file *filp, char __user *buffer,
-					size_t count, loff_t *ppos)
+static ssize_t ipc_trace_ctrl_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iosm_trace *ipc_trace = filp->private_data;
+	struct iosm_trace *ipc_trace = iocb->ki_filp->private_data;
 	char buf[16];
 	int len;
 
@@ -81,19 +80,19 @@ static ssize_t ipc_trace_ctrl_file_read(struct file *filp, char __user *buffer,
 	len = snprintf(buf, sizeof(buf), "%d\n", ipc_trace->mode);
 	mutex_unlock(&ipc_trace->trc_mutex);
 
-	return simple_read_from_buffer(buffer, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 /* Open and close the trace channel depending on user input */
-static ssize_t ipc_trace_ctrl_file_write(struct file *filp,
-					 const char __user *buffer,
-					 size_t count, loff_t *ppos)
+static ssize_t ipc_trace_ctrl_file_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct iosm_trace *ipc_trace = filp->private_data;
+	struct iosm_trace *ipc_trace = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long val;
 	int ret;
 
-	ret = kstrtoul_from_user(buffer, count, 10, &val);
+	ret = kstrtoul_from_iter(from, count, 10, &val);
 	if (ret)
 		return ret;
 
@@ -122,8 +121,8 @@ static ssize_t ipc_trace_ctrl_file_write(struct file *filp,
 
 static const struct file_operations ipc_trace_fops = {
 	.open = simple_open,
-	.write = ipc_trace_ctrl_file_write,
-	.read  = ipc_trace_ctrl_file_read,
+	.write_iter = ipc_trace_ctrl_file_write,
+	.read_iter  = ipc_trace_ctrl_file_read,
 };
 
 /**
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 17431f1b1a0c..1007d0255427 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -684,15 +684,15 @@ static int wwan_port_fops_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t wwan_port_fops_read(struct file *filp, char __user *buf,
-				   size_t count, loff_t *ppos)
+static ssize_t wwan_port_fops_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wwan_port *port = filp->private_data;
+	struct wwan_port *port = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct sk_buff *skb;
 	size_t copied;
 	int ret;
 
-	ret = wwan_wait_rx(port, !!(filp->f_flags & O_NONBLOCK));
+	ret = wwan_wait_rx(port, !!(iocb->ki_filp->f_flags & O_NONBLOCK));
 	if (ret)
 		return ret;
 
@@ -701,7 +701,7 @@ static ssize_t wwan_port_fops_read(struct file *filp, char __user *buf,
 		return -EIO;
 
 	copied = min_t(size_t, count, skb->len);
-	if (copy_to_user(buf, skb->data, copied)) {
+	if (!copy_to_iter_full(skb->data, copied, to)) {
 		kfree_skb(skb);
 		return -EFAULT;
 	}
@@ -716,15 +716,15 @@ static ssize_t wwan_port_fops_read(struct file *filp, char __user *buf,
 	return copied;
 }
 
-static ssize_t wwan_port_fops_write(struct file *filp, const char __user *buf,
-				    size_t count, loff_t *offp)
+static ssize_t wwan_port_fops_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct sk_buff *skb, *head = NULL, *tail = NULL;
-	struct wwan_port *port = filp->private_data;
+	struct wwan_port *port = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	size_t frag_len, remain = count;
 	int ret;
 
-	ret = wwan_wait_tx(port, !!(filp->f_flags & O_NONBLOCK));
+	ret = wwan_wait_tx(port, !!(iocb->ki_filp->f_flags & O_NONBLOCK));
 	if (ret)
 		return ret;
 
@@ -747,7 +747,7 @@ static ssize_t wwan_port_fops_write(struct file *filp, const char __user *buf,
 			tail = skb;
 		}
 
-		if (copy_from_user(skb_put(skb, frag_len), buf + count - remain, frag_len)) {
+		if (!copy_from_iter_full(skb_put(skb, frag_len), frag_len, from)) {
 			ret = -EFAULT;
 			goto freeskb;
 		}
@@ -759,7 +759,7 @@ static ssize_t wwan_port_fops_write(struct file *filp, const char __user *buf,
 		}
 	} while (remain -= frag_len);
 
-	ret = wwan_port_op_tx(port, head, !!(filp->f_flags & O_NONBLOCK));
+	ret = wwan_port_op_tx(port, head, !!(iocb->ki_filp->f_flags & O_NONBLOCK));
 	if (!ret)
 		return count;
 
@@ -897,8 +897,8 @@ static const struct file_operations wwan_port_fops = {
 	.owner = THIS_MODULE,
 	.open = wwan_port_fops_open,
 	.release = wwan_port_fops_release,
-	.read = wwan_port_fops_read,
-	.write = wwan_port_fops_write,
+	.read_iter = wwan_port_fops_read,
+	.write_iter = wwan_port_fops_write,
 	.poll = wwan_port_fops_poll,
 	.unlocked_ioctl = wwan_port_fops_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
index b02befd1b6fb..7bf9a275b3c0 100644
--- a/drivers/net/wwan/wwan_hwsim.c
+++ b/drivers/net/wwan/wwan_hwsim.c
@@ -364,11 +364,10 @@ static void wwan_hwsim_dev_del_work(struct work_struct *work)
 	wwan_hwsim_dev_del(dev);
 }
 
-static ssize_t wwan_hwsim_debugfs_portdestroy_write(struct file *file,
-						    const char __user *usrbuf,
-						    size_t count, loff_t *ppos)
+static ssize_t wwan_hwsim_debugfs_portdestroy_write(struct kiocb *iocb,
+						    struct iov_iter *from)
 {
-	struct wwan_hwsim_port *port = file->private_data;
+	struct wwan_hwsim_port *port = iocb->ki_filp->private_data;
 
 	/* We can not delete port here since it will cause a deadlock due to
 	 * waiting this callback to finish in the debugfs_remove() call. So,
@@ -376,20 +375,19 @@ static ssize_t wwan_hwsim_debugfs_portdestroy_write(struct file *file,
 	 */
 	queue_work(wwan_wq, &port->del_work);
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations wwan_hwsim_debugfs_portdestroy_fops = {
-	.write = wwan_hwsim_debugfs_portdestroy_write,
+	.write_iter = wwan_hwsim_debugfs_portdestroy_write,
 	.open = simple_open,
 	.llseek = noop_llseek,
 };
 
-static ssize_t wwan_hwsim_debugfs_portcreate_write(struct file *file,
-						   const char __user *usrbuf,
-						   size_t count, loff_t *ppos)
+static ssize_t wwan_hwsim_debugfs_portcreate_write(struct kiocb *iocb,
+						   struct iov_iter *from)
 {
-	struct wwan_hwsim_dev *dev = file->private_data;
+	struct wwan_hwsim_dev *dev = iocb->ki_filp->private_data;
 	struct wwan_hwsim_port *port;
 
 	port = wwan_hwsim_port_new(dev);
@@ -400,20 +398,19 @@ static ssize_t wwan_hwsim_debugfs_portcreate_write(struct file *file,
 	list_add_tail(&port->list, &dev->ports);
 	spin_unlock(&dev->ports_lock);
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations wwan_hwsim_debugfs_portcreate_fops = {
-	.write = wwan_hwsim_debugfs_portcreate_write,
+	.write_iter = wwan_hwsim_debugfs_portcreate_write,
 	.open = simple_open,
 	.llseek = noop_llseek,
 };
 
-static ssize_t wwan_hwsim_debugfs_devdestroy_write(struct file *file,
-						   const char __user *usrbuf,
-						   size_t count, loff_t *ppos)
+static ssize_t wwan_hwsim_debugfs_devdestroy_write(struct kiocb *iocb,
+						   struct iov_iter *from)
 {
-	struct wwan_hwsim_dev *dev = file->private_data;
+	struct wwan_hwsim_dev *dev = iocb->ki_filp->private_data;
 
 	/* We can not delete device here since it will cause a deadlock due to
 	 * waiting this callback to finish in the debugfs_remove() call. So,
@@ -421,18 +418,17 @@ static ssize_t wwan_hwsim_debugfs_devdestroy_write(struct file *file,
 	 */
 	queue_work(wwan_wq, &dev->del_work);
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations wwan_hwsim_debugfs_devdestroy_fops = {
-	.write = wwan_hwsim_debugfs_devdestroy_write,
+	.write_iter = wwan_hwsim_debugfs_devdestroy_write,
 	.open = simple_open,
 	.llseek = noop_llseek,
 };
 
-static ssize_t wwan_hwsim_debugfs_devcreate_write(struct file *file,
-						  const char __user *usrbuf,
-						  size_t count, loff_t *ppos)
+static ssize_t wwan_hwsim_debugfs_devcreate_write(struct kiocb *iocb,
+						  struct iov_iter *from)
 {
 	struct wwan_hwsim_dev *dev;
 
@@ -444,11 +440,11 @@ static ssize_t wwan_hwsim_debugfs_devcreate_write(struct file *file,
 	list_add_tail(&dev->list, &wwan_hwsim_devs);
 	spin_unlock(&wwan_hwsim_devs_lock);
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations wwan_hwsim_debugfs_devcreate_fops = {
-	.write = wwan_hwsim_debugfs_devcreate_write,
+	.write_iter = wwan_hwsim_debugfs_devcreate_write,
 	.open = simple_open,
 	.llseek = noop_llseek,
 };
-- 
2.43.0


