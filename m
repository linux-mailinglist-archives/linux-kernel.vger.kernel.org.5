Return-Path: <linux-kernel+bounces-140939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 781CC8A19B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C6A1F21A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4031CB338;
	Thu, 11 Apr 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hfJkVsVW"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F711CB30E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849789; cv=none; b=l7i6hQd1Ai6j9MGQ68Lbu81HZsZ5hGoXpByeSHjK2lq6a14gdNcoQNfb0oCNYfWLEUuOcOqxVPx5NK1s4dko+lGcpB6pAzqrD9gWBSMRwOX99xpv02Kk4xMStpmD+s8EhDAjWXsCYN3AEH+nfGlpl+bShaIOm6LwtQfi6Hizm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849789; c=relaxed/simple;
	bh=guuW7TgbDIQpuCOftV0Fuj4SBIiQpBazY0xbSs421/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AG4zDhLfu6S/tN+/BrYrM24ci8x23y2UYT7JZh9YlpsIzGCH/KIaHphsGpPwS5Qwmry1WxY2XRnHTjlxQSPRndH+2zlVn+/4WmzxbV19USZS+UC7aqbAeSdbu6MuUN/4+qpvtgDbsbhZMJu3Jxeg2c1cpkijl4qNdALTbgVEhsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hfJkVsVW; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69573839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849787; x=1713454587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLj3v5JToNx3nijiVkgXX/l/0GFAghw4iIT2lUEkeYc=;
        b=hfJkVsVWB1f22JGAm2CkAHPEr8c7o8zvwL/A8g2z50Bmc+fGLbe7apHotJiMqtpeXo
         BCgozHdVsdPFxZq+ENbq6tuRzdQUtFN5wQR1h9jbI1Zm8magrvbBTBrbpUaiBZaoVnuV
         9BMranHlvVkTIh/6+M1TKNx9h598M6Mt3bBtGzNItPJ5nE6sMjExZUMafXDU0WJKS4IG
         AFjKsMV+72xJQHERGRmyIGAFNuSfncWxVYRh37JbWrU80dCyj4gDpY0nQitOPYQktDhJ
         I1em7hOpo2qXxRaqpCLb0ZsN/KCL8sLIgidZVlNny3CWI3g5pq5y8vNZ148tR+zk3eGh
         ybrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849787; x=1713454587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLj3v5JToNx3nijiVkgXX/l/0GFAghw4iIT2lUEkeYc=;
        b=mgc/ZsFhbglAASCyMDN26eeHke+Km27L85Jr9b5Mv5O7SqyegsSZNuoaPJ/k+oXL6m
         nz3RzeaZiHgfMAuAbxl/cyaCv9jCwCcWf/gPl8a9zDsfElLVKf0tCv29RMF0AcPyjEHO
         PbARedo2/Z1UvOn0HCVWXImawpqzwMQFPPtJJDGZqQzEwHPZUrIS4/LPlef6bp75SLLu
         BtAgQWqC6HFbf9NO4hiFThaSAcRPRROYR0EScD9HyFpkmvl0WfbDmLPpUl4+0EtEQbG5
         deaLTbt0wo6aI3HXdSaa5tsIyy1azW6EEHlbZiRZNitZsIUX8HBHC4POWKLIfzjvS7Gx
         LFjg==
X-Gm-Message-State: AOJu0YyLfX08Zkgp/FGblWoGX5KNNxd51fO1vXWD1fLfxTUrcmNf5+95
	IjmsWIrVX8PkkRld+Zcsot8vyA6Gkjda8FGVuNLw1B4PAmvn5sTAZUpBYD/ShRcppYLo3vq5ej3
	a
X-Google-Smtp-Source: AGHT+IHSa6415qB75QXv1hj7N42foCQyvwRp1qwmFtqINRrNAxfIKP6yL4WCw63eIZKSwLW0JEPG/A==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr194722iop.1.1712849787037;
        Thu, 11 Apr 2024 08:36:27 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 170/437] usb: mtu3: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:10 -0600
Message-ID: <20240411153126.16201-171-axboe@kernel.dk>
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
 drivers/usb/mtu3/mtu3_debugfs.c | 40 ++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
index f0de99858353..da73f486bfea 100644
--- a/drivers/usb/mtu3/mtu3_debugfs.c
+++ b/drivers/usb/mtu3/mtu3_debugfs.c
@@ -272,7 +272,7 @@ static int mtu3_ep_open(struct inode *inode, struct file *file)
 
 static const struct file_operations mtu3_ep_fops = {
 	.open = mtu3_ep_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -311,18 +311,18 @@ static int mtu3_probe_open(struct inode *inode, struct file *file)
 	return single_open(file, mtu3_probe_show, inode->i_private);
 }
 
-static ssize_t mtu3_probe_write(struct file *file, const char __user *ubuf,
-				size_t count, loff_t *ppos)
+static ssize_t mtu3_probe_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	const char *file_name = file_dentry(file)->d_iname;
-	struct seq_file *sf = file->private_data;
+	const char *file_name = file_dentry(iocb->ki_filp)->d_iname;
+	struct seq_file *sf = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct mtu3 *mtu = sf->private;
 	const struct debugfs_reg32 *regs;
 	char buf[32];
 	u32 val;
 	int i;
 
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(&buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	if (kstrtou32(buf, 0, &val))
@@ -341,8 +341,8 @@ static ssize_t mtu3_probe_write(struct file *file, const char __user *ubuf,
 
 static const struct file_operations mtu3_probe_fops = {
 	.open = mtu3_probe_open,
-	.write = mtu3_probe_write,
-	.read = seq_read,
+	.write_iter = mtu3_probe_write,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -443,14 +443,14 @@ static int ssusb_mode_open(struct inode *inode, struct file *file)
 	return single_open(file, ssusb_mode_show, inode->i_private);
 }
 
-static ssize_t ssusb_mode_write(struct file *file, const char __user *ubuf,
-				size_t count, loff_t *ppos)
+static ssize_t ssusb_mode_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *sf = file->private_data;
+	struct seq_file *sf = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ssusb_mtk *ssusb = sf->private;
 	char buf[16];
 
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(&buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	if (!strncmp(buf, "host", 4) && !ssusb->is_host) {
@@ -467,8 +467,8 @@ static ssize_t ssusb_mode_write(struct file *file, const char __user *ubuf,
 
 static const struct file_operations ssusb_mode_fops = {
 	.open = ssusb_mode_open,
-	.write = ssusb_mode_write,
-	.read = seq_read,
+	.write_iter = ssusb_mode_write,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -489,16 +489,16 @@ static int ssusb_vbus_open(struct inode *inode, struct file *file)
 	return single_open(file, ssusb_vbus_show, inode->i_private);
 }
 
-static ssize_t ssusb_vbus_write(struct file *file, const char __user *ubuf,
-				size_t count, loff_t *ppos)
+static ssize_t ssusb_vbus_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *sf = file->private_data;
+	struct seq_file *sf = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ssusb_mtk *ssusb = sf->private;
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 	char buf[16];
 	bool enable;
 
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(&buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	if (kstrtobool(buf, &enable)) {
@@ -513,8 +513,8 @@ static ssize_t ssusb_vbus_write(struct file *file, const char __user *ubuf,
 
 static const struct file_operations ssusb_vbus_fops = {
 	.open = ssusb_vbus_open,
-	.write = ssusb_vbus_write,
-	.read = seq_read,
+	.write_iter = ssusb_vbus_write,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-- 
2.43.0


