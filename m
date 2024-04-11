Return-Path: <linux-kernel+bounces-140886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE838A1961
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1404C1C23C58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BFB159917;
	Thu, 11 Apr 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HtAZPJOE"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B11598F5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849709; cv=none; b=M/Lel0dVrzq221bM3txJUD1lHbwjzWqEwNJSH3ZIafr5z8Zim94keZo3L4flXG7zfftOo3qyVSQbxlNVBAQKOb0IGKdCQZ1xXprm5ManDFlHx1tU1l9mTQ77a3iEV82X6863FiBXhZZgB4a+doJo/6dOcpaAJq3ZI2ajD+EIqK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849709; c=relaxed/simple;
	bh=AxBLQiacTScg+7JrtvelA4l3j2Xi/pndV3VG6rn4ajg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1OR7HDXmv6B7t4IcSKr1myHNt0nrq9EVSBjTANG8DysjdIewLBWt7T7HeZqQi32c3bPenNDxJq62WDAqD/LJFIWN3YCkQbtbj8QTfi1/SYScnvqNBRBR7sOpi1TBcKGXqP8myRz3L6X3HJuX6Ja7u+HjrvT/FDR7hbbdK4jedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HtAZPJOE; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso180632439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849707; x=1713454507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMnl20njZNAJZk66Lt1b3svShUeqokDg3NT6wbzcJjI=;
        b=HtAZPJOE89aCXw1rd0YQst978sA6DhMC40C2if8ldzypNsYF6UCAHQxNIt8ctYoeqA
         hl8/fenP3Aw9fhbInjiuGeRvoGnKbiIHKabsqMgdYc0RX3btQayb9m/4BIbdN3zZRlor
         STAjEEcNBDcBsLuWIIe0Moeojlam8AQx/7zzJ4K82Tvm0uYV8ObtS8pzJipCnFzQb1Ky
         zny8GEeGbcsBWXjFoCnCBs1krPdFPzFFYSIPi5xtgt8MDilBVxOCUu+FfqZhuLTcV8fD
         hCpmfZmPTwByFI9MsSKQAhf6/0mToxlndPjdZ7SZ4t9Hkn2O8Y2ixmwdo6Hnrwsncxi1
         LCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849707; x=1713454507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMnl20njZNAJZk66Lt1b3svShUeqokDg3NT6wbzcJjI=;
        b=f7vZy0cjKh4k0pcaZJLdSS8MxngyZXoCaB475mY2wjsj9P2URqreFal6A0NGwAlkjY
         iLUf9l/27IZ3gboTfEwBjd214mr0y8XGrtVhdYMV+KsNQefEbvBiwUjOEzRm6yX2lrLl
         2frkBrEpa16VfxtNWl8jSNju20hvc0PDVY8rlcB/appVLsRlF0Bx9Lp2J6+g/ed16uXM
         S5zEI0ZwsEiw3ui9ORSBk0qiZ0lSjlKehaEVxVoNfLtgfV+gLbi5BuqCCWmdRLEPRpjP
         zT8NzwKiELZGFNdS8e6yx0vjqpTuoIMe/Nx0AYm2G0yacx40y7GHek1s7Jxfld77L2kf
         lMVg==
X-Gm-Message-State: AOJu0YyWljzxorJlGVjRe7EZ8gPDwHiaVbEYUEEJ1ioLbXuOCT9yLHfu
	fvAl6HOL2MA/wyiN+7BbBSJQal/swlu6eWSNuscaY5vWnTxOn3S7IQoimN/0wqnRHhALtlPmPcT
	E
X-Google-Smtp-Source: AGHT+IHiPo3WkFVSvzxSedySVJ9KIjgRG07NSZG1cDnLkyPA3jikmbHV1mp2RuY2XNPDx9hJC3A0tw==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr183298iob.1.1712849706926;
        Thu, 11 Apr 2024 08:35:06 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 122/437] drivers/pci: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:22 -0600
Message-ID: <20240411153126.16201-123-axboe@kernel.dk>
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
 drivers/pci/pcie/aer_inject.c  |  9 +++++----
 drivers/pci/switch/switchtec.c | 33 ++++++++++++++++-----------------
 drivers/pci/vgaarb.c           | 21 +++++++++++----------
 3 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 2dab275d252f..869abe6a82ab 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/uio.h>
 #include <linux/uaccess.h>
 #include <linux/stddef.h>
 #include <linux/device.h>
@@ -483,9 +484,9 @@ static int aer_inject(struct aer_error_inj *einj)
 	return ret;
 }
 
-static ssize_t aer_inject_write(struct file *filp, const char __user *ubuf,
-				size_t usize, loff_t *off)
+static ssize_t aer_inject_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t usize = iov_iter_count(from);
 	struct aer_error_inj einj;
 	int ret;
 
@@ -496,7 +497,7 @@ static ssize_t aer_inject_write(struct file *filp, const char __user *ubuf,
 		return -EINVAL;
 
 	memset(&einj, 0, sizeof(einj));
-	if (copy_from_user(&einj, ubuf, usize))
+	if (!copy_from_iter_full(&einj, usize, from))
 		return -EFAULT;
 
 	ret = aer_inject(&einj);
@@ -504,7 +505,7 @@ static ssize_t aer_inject_write(struct file *filp, const char __user *ubuf,
 }
 
 static const struct file_operations aer_inject_fops = {
-	.write = aer_inject_write,
+	.write_iter = aer_inject_write,
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
 };
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 5a4adf6c04cf..db6f578e854c 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -15,6 +15,7 @@
 #include <linux/wait.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/nospec.h>
+#include <linux/uio.h>
 
 MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCIe Management Driver");
 MODULE_VERSION("0.1");
@@ -503,11 +504,11 @@ static int lock_mutex_and_test_alive(struct switchtec_dev *stdev)
 	return 0;
 }
 
-static ssize_t switchtec_dev_write(struct file *filp, const char __user *data,
-				   size_t size, loff_t *off)
+static ssize_t switchtec_dev_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct switchtec_user *stuser = filp->private_data;
+	struct switchtec_user *stuser = iocb->ki_filp->private_data;
 	struct switchtec_dev *stdev = stuser->stdev;
+	size_t size = iov_iter_count(from);
 	int rc;
 
 	if (size < sizeof(stuser->cmd) ||
@@ -525,7 +526,7 @@ static ssize_t switchtec_dev_write(struct file *filp, const char __user *data,
 		goto out;
 	}
 
-	rc = copy_from_user(&stuser->cmd, data, sizeof(stuser->cmd));
+	rc = !copy_from_iter_full(&stuser->cmd, sizeof(stuser->cmd), from);
 	if (rc) {
 		rc = -EFAULT;
 		goto out;
@@ -537,8 +538,7 @@ static ssize_t switchtec_dev_write(struct file *filp, const char __user *data,
 		goto out;
 	}
 
-	data += sizeof(stuser->cmd);
-	rc = copy_from_user(&stuser->data, data, size - sizeof(stuser->cmd));
+	rc = !copy_from_iter_full(&stuser->data, size - sizeof(stuser->cmd), from);
 	if (rc) {
 		rc = -EFAULT;
 		goto out;
@@ -555,11 +555,11 @@ static ssize_t switchtec_dev_write(struct file *filp, const char __user *data,
 	return size;
 }
 
-static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
-				  size_t size, loff_t *off)
+static ssize_t switchtec_dev_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct switchtec_user *stuser = filp->private_data;
+	struct switchtec_user *stuser = iocb->ki_filp->private_data;
 	struct switchtec_dev *stdev = stuser->stdev;
+	size_t size = iov_iter_count(to);
 	int rc;
 
 	if (size < sizeof(stuser->cmd) ||
@@ -579,7 +579,7 @@ static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
 
 	mutex_unlock(&stdev->mrpc_mutex);
 
-	if (filp->f_flags & O_NONBLOCK) {
+	if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 		if (!stuser->cmd_done)
 			return -EAGAIN;
 	} else {
@@ -603,16 +603,15 @@ static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
 		return -EBADE;
 	}
 
-	rc = copy_to_user(data, &stuser->return_code,
-			  sizeof(stuser->return_code));
+	rc = !copy_to_iter_full(&stuser->return_code,
+				sizeof(stuser->return_code), to);
 	if (rc) {
 		mutex_unlock(&stdev->mrpc_mutex);
 		return -EFAULT;
 	}
 
-	data += sizeof(stuser->return_code);
-	rc = copy_to_user(data, &stuser->data,
-			  size - sizeof(stuser->return_code));
+	rc = !copy_to_iter_full(&stuser->data,
+				size - sizeof(stuser->return_code), to);
 	if (rc) {
 		mutex_unlock(&stdev->mrpc_mutex);
 		return -EFAULT;
@@ -1247,8 +1246,8 @@ static const struct file_operations switchtec_fops = {
 	.owner = THIS_MODULE,
 	.open = switchtec_dev_open,
 	.release = switchtec_dev_release,
-	.write = switchtec_dev_write,
-	.read = switchtec_dev_read,
+	.write_iter = switchtec_dev_write,
+	.read_iter = switchtec_dev_read,
 	.poll = switchtec_dev_poll,
 	.unlocked_ioctl = switchtec_dev_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 78748e8d2dba..a5051fae9bcb 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -31,6 +31,7 @@
 #include <linux/console.h>
 #include <linux/acpi.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <linux/vgaarb.h>
 
 static void vga_arbiter_notify_clients(void);
@@ -1088,10 +1089,10 @@ static int vga_pci_str_to_vars(char *buf, int count, unsigned int *domain,
 	return 1;
 }
 
-static ssize_t vga_arb_read(struct file *file, char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t vga_arb_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct vga_arb_private *priv = file->private_data;
+	struct vga_arb_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct vga_device *vgadev;
 	struct pci_dev *pdev;
 	unsigned long flags;
@@ -1141,7 +1142,7 @@ static ssize_t vga_arb_read(struct file *file, char __user *buf,
 	/* Copy that to user */
 	if (len > count)
 		len = count;
-	rc = copy_to_user(buf, lbuf, len);
+	rc = !copy_to_iter_full(lbuf, len, to);
 	kfree(lbuf);
 	if (rc)
 		return -EFAULT;
@@ -1152,10 +1153,10 @@ static ssize_t vga_arb_read(struct file *file, char __user *buf,
  * TODO: To avoid parsing inside kernel and to improve the speed we may
  * consider use ioctl here
  */
-static ssize_t vga_arb_write(struct file *file, const char __user *buf,
-			     size_t count, loff_t *ppos)
+static ssize_t vga_arb_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct vga_arb_private *priv = file->private_data;
+	struct vga_arb_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct vga_arb_user_card *uc = NULL;
 	struct pci_dev *pdev;
 
@@ -1169,7 +1170,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 
 	if (count >= sizeof(kbuf))
 		return -EINVAL;
-	if (copy_from_user(kbuf, buf, count))
+	if (!copy_from_iter_full(kbuf, count, from))
 		return -EFAULT;
 	curr_pos = kbuf;
 	kbuf[count] = '\0';
@@ -1523,8 +1524,8 @@ static struct notifier_block pci_notifier = {
 };
 
 static const struct file_operations vga_arb_device_fops = {
-	.read = vga_arb_read,
-	.write = vga_arb_write,
+	.read_iter = vga_arb_read,
+	.write_iter = vga_arb_write,
 	.poll = vga_arb_fpoll,
 	.open = vga_arb_open,
 	.release = vga_arb_release,
-- 
2.43.0


