Return-Path: <linux-kernel+bounces-140876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FF78A1954
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D5B1C20A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C155152DE3;
	Thu, 11 Apr 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0eVsB3z7"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D415217E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849693; cv=none; b=nBucsPytVoJsOKXT5fHFIYqK/Qoy5iuWnJPpCp3Q0hFDN49pO/ehsSn+eIxpwf4kJzR97utEdB65ayGmslyyGtnCTqXo6If3gsSFAM9SghxL0NPScjnZQUMH41ByjWE9QAQ9dDAttP8HGIQ19oGqfL4GEoCfCUlfl5H33+JQBec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849693; c=relaxed/simple;
	bh=SKTBmh2UAE3xmKMgSJomMq0Xvh6N6ZhuZZ/9LC3Ayvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cliN3/5a2z95dxiuwH+z1d8B5b7wgrkw1vMcnbUJ9cf7u9lM5lR+NpXIK7AT2XGwlIR4V/ixlfM/dCWy51HTQ03cA/l1ge38h8ZcoKx5DNrl/NdQyoBZ0CHNUAfXLsPqWaFpxDpQ4N8bj5vfFBVV9LpiqOcYS2/ZTaV/meOK1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0eVsB3z7; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36a34b68277so108565ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849690; x=1713454490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6/a+TEI2ObX1b5gx++9Hl7E/Le33FV4tiF1Hiyv8hg=;
        b=0eVsB3z77n5mKWFLWHdVAzs8l7lr0oGOyvhCRSKGLoLCY4wYIpVEnRHSMwDdHZZgD1
         FSTnl28322T3D7DkClw3UQ5vuYfZEUbmDQOHgwVj7X+WlNPys1oYd9xeRro9++5J+tHj
         hK3S9Raa8AnMU742oNO5odzDS9TmWzYPhlyG4jbIaSyohTe6BJZcJU+450VKsC85P7ZS
         JjPy7Q8TXDTRi40SO7x/UV2JtYyNKk8apVn3uWedWdSfxxVOJRZHKiLurhkgX4MrcDI3
         AAt6PDEy/nl3fU1zbY+RVy5kIclGdb2CcHASgm8fdQgTLNkguKM9i3cD0xcKeOtY8JTQ
         AvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849690; x=1713454490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6/a+TEI2ObX1b5gx++9Hl7E/Le33FV4tiF1Hiyv8hg=;
        b=RwBohwM0AgRQtaHV/Vhx+e5vh9pmdPyLFmELcHhPsXCRX8D3s8yV1xWcdYY1OL/nAI
         +pnXnBSQG2sR3EKsh8n/UbGFfCaop+/5tjz62K9IE3P1GFRPSxMX5e2j/7rGZoFVlo6q
         gvJNP8FG45t7/yiO7RlkQfj7sdBy481PSXlDALjH9fB6R8OEq3AefmCrsEN2PPhljBpX
         j2dZNQrV94biVReOSIo1weHXnOp3HWpCVprfJHkG9z/DxshtwuhSlUJXlPI+e+PMvbS2
         ZEWoZLY6iZyG8rcSLDlPx6YDENL3lDqebFxtCi5n790C7dmWafFKymRNWhRVvb1Ja2YX
         3niw==
X-Gm-Message-State: AOJu0Ywn6K8hFe8PzYTjPCIygPvubkcSwjxU1CqqFgLr/7O2fUrhyPqX
	ujpRCBAUKS+dozv8LrbjhKtAeVxJNBX266D4YvfufcDgGn7nf8otMsQmp6V//bwG/3bj2gEK9Lv
	P
X-Google-Smtp-Source: AGHT+IGnP0NKuusN3kNsO0TBsYgIfX883hCofwyd+y1wKdj8rMT/EwrD5lyD/Qlar4eaUE+9wZAi5g==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr145806ioc.2.1712849689992;
        Thu, 11 Apr 2024 08:34:49 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 112/437] drivers/bluetooth: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:12 -0600
Message-ID: <20240411153126.16201-113-axboe@kernel.dk>
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
 drivers/bluetooth/btmrvl_debugfs.c | 57 +++++++++++------------
 drivers/bluetooth/btusb.c          | 20 ++++----
 drivers/bluetooth/hci_vhci.c       | 73 ++++++++++++++----------------
 3 files changed, 70 insertions(+), 80 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index 32329a2e526f..e78343575146 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -18,13 +18,13 @@ struct btmrvl_debugfs_data {
 	struct dentry *status_dir;
 };
 
-static ssize_t btmrvl_hscfgcmd_write(struct file *file,
-			const char __user *ubuf, size_t count, loff_t *ppos)
+static ssize_t btmrvl_hscfgcmd_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct btmrvl_private *priv = file->private_data;
+	struct btmrvl_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	long result, ret;
 
-	ret = kstrtol_from_user(ubuf, count, 10, &result);
+	ret = kstrtol_from_iter(from, count, 10, &result);
 	if (ret)
 		return ret;
 
@@ -38,33 +38,32 @@ static ssize_t btmrvl_hscfgcmd_write(struct file *file,
 	return count;
 }
 
-static ssize_t btmrvl_hscfgcmd_read(struct file *file, char __user *userbuf,
-						size_t count, loff_t *ppos)
+static ssize_t btmrvl_hscfgcmd_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct btmrvl_private *priv = file->private_data;
+	struct btmrvl_private *priv = iocb->ki_filp->private_data;
 	char buf[16];
 	int ret;
 
 	ret = snprintf(buf, sizeof(buf) - 1, "%d\n",
 						priv->btmrvl_dev.hscfgcmd);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, ret, to);
 }
 
 static const struct file_operations btmrvl_hscfgcmd_fops = {
-	.read	= btmrvl_hscfgcmd_read,
-	.write	= btmrvl_hscfgcmd_write,
+	.read_iter	= btmrvl_hscfgcmd_read,
+	.write_iter	= btmrvl_hscfgcmd_write,
 	.open	= simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t btmrvl_pscmd_write(struct file *file, const char __user *ubuf,
-						size_t count, loff_t *ppos)
+static ssize_t btmrvl_pscmd_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct btmrvl_private *priv = file->private_data;
+	struct btmrvl_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	long result, ret;
 
-	ret = kstrtol_from_user(ubuf, count, 10, &result);
+	ret = kstrtol_from_iter(from, count, 10, &result);
 	if (ret)
 		return ret;
 
@@ -79,32 +78,31 @@ static ssize_t btmrvl_pscmd_write(struct file *file, const char __user *ubuf,
 
 }
 
-static ssize_t btmrvl_pscmd_read(struct file *file, char __user *userbuf,
-						size_t count, loff_t *ppos)
+static ssize_t btmrvl_pscmd_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct btmrvl_private *priv = file->private_data;
+	struct btmrvl_private *priv = iocb->ki_filp->private_data;
 	char buf[16];
 	int ret;
 
 	ret = snprintf(buf, sizeof(buf) - 1, "%d\n", priv->btmrvl_dev.pscmd);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, ret, to);
 }
 
 static const struct file_operations btmrvl_pscmd_fops = {
-	.read = btmrvl_pscmd_read,
-	.write = btmrvl_pscmd_write,
+	.read_iter = btmrvl_pscmd_read,
+	.write_iter = btmrvl_pscmd_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t btmrvl_hscmd_write(struct file *file, const char __user *ubuf,
-						size_t count, loff_t *ppos)
+static ssize_t btmrvl_hscmd_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct btmrvl_private *priv = file->private_data;
+	struct btmrvl_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	long result, ret;
 
-	ret = kstrtol_from_user(ubuf, count, 10, &result);
+	ret = kstrtol_from_iter(from, count, 10, &result);
 	if (ret)
 		return ret;
 
@@ -117,21 +115,20 @@ static ssize_t btmrvl_hscmd_write(struct file *file, const char __user *ubuf,
 	return count;
 }
 
-static ssize_t btmrvl_hscmd_read(struct file *file, char __user *userbuf,
-						size_t count, loff_t *ppos)
+static ssize_t btmrvl_hscmd_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct btmrvl_private *priv = file->private_data;
+	struct btmrvl_private *priv = iocb->ki_filp->private_data;
 	char buf[16];
 	int ret;
 
 	ret = snprintf(buf, sizeof(buf) - 1, "%d\n", priv->btmrvl_dev.hscmd);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, ret, to);
 }
 
 static const struct file_operations btmrvl_hscmd_fops = {
-	.read	= btmrvl_hscmd_read,
-	.write	= btmrvl_hscmd_write,
+	.read_iter	= btmrvl_hscmd_read,
+	.write_iter	= btmrvl_hscmd_write,
 	.open	= simple_open,
 	.llseek = default_llseek,
 };
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 06e915b57283..7dbcd00ed4ed 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4161,27 +4161,25 @@ static int btusb_shutdown_qca(struct hci_dev *hdev)
 	return 0;
 }
 
-static ssize_t force_poll_sync_read(struct file *file, char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t force_poll_sync_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct btusb_data *data = file->private_data;
+	struct btusb_data *data = iocb->ki_filp->private_data;
 	char buf[3];
 
 	buf[0] = data->poll_sync ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
-static ssize_t force_poll_sync_write(struct file *file,
-				     const char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t force_poll_sync_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct btusb_data *data = file->private_data;
+	struct btusb_data *data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	bool enable;
 	int err;
 
-	err = kstrtobool_from_user(user_buf, count, &enable);
+	err = kstrtobool_from_iter(from, count, &enable);
 	if (err)
 		return err;
 
@@ -4199,8 +4197,8 @@ static ssize_t force_poll_sync_write(struct file *file,
 
 static const struct file_operations force_poll_sync_fops = {
 	.open		= simple_open,
-	.read		= force_poll_sync_read,
-	.write		= force_poll_sync_write,
+	.read_iter	= force_poll_sync_read,
+	.write_iter	= force_poll_sync_write,
 	.llseek		= default_llseek,
 };
 
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 572d68d52965..0d310a7d78f4 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -109,16 +109,15 @@ static bool vhci_wakeup(struct hci_dev *hdev)
 	return data->wakeup;
 }
 
-static ssize_t force_suspend_read(struct file *file, char __user *user_buf,
-				  size_t count, loff_t *ppos)
+static ssize_t force_suspend_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct vhci_data *data = file->private_data;
+	struct vhci_data *data = iocb->ki_filp->private_data;
 	char buf[3];
 
 	buf[0] = data->suspended ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
 static void vhci_suspend_work(struct work_struct *work)
@@ -132,15 +131,14 @@ static void vhci_suspend_work(struct work_struct *work)
 		hci_resume_dev(data->hdev);
 }
 
-static ssize_t force_suspend_write(struct file *file,
-				   const char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t force_suspend_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct vhci_data *data = file->private_data;
+	struct vhci_data *data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	bool enable;
 	int err;
 
-	err = kstrtobool_from_user(user_buf, count, &enable);
+	err = kstrtobool_from_iter(from, count, &enable);
 	if (err)
 		return err;
 
@@ -156,32 +154,30 @@ static ssize_t force_suspend_write(struct file *file,
 
 static const struct file_operations force_suspend_fops = {
 	.open		= simple_open,
-	.read		= force_suspend_read,
-	.write		= force_suspend_write,
+	.read_iter	= force_suspend_read,
+	.write_iter	= force_suspend_write,
 	.llseek		= default_llseek,
 };
 
-static ssize_t force_wakeup_read(struct file *file, char __user *user_buf,
-				 size_t count, loff_t *ppos)
+static ssize_t force_wakeup_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct vhci_data *data = file->private_data;
+	struct vhci_data *data = iocb->ki_filp->private_data;
 	char buf[3];
 
 	buf[0] = data->wakeup ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
-static ssize_t force_wakeup_write(struct file *file,
-				  const char __user *user_buf, size_t count,
-				  loff_t *ppos)
+static ssize_t force_wakeup_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct vhci_data *data = file->private_data;
+	struct vhci_data *data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	bool enable;
 	int err;
 
-	err = kstrtobool_from_user(user_buf, count, &enable);
+	err = kstrtobool_from_iter(from, count, &enable);
 	if (err)
 		return err;
 
@@ -195,8 +191,8 @@ static ssize_t force_wakeup_write(struct file *file,
 
 static const struct file_operations force_wakeup_fops = {
 	.open		= simple_open,
-	.read		= force_wakeup_read,
-	.write		= force_wakeup_write,
+	.read_iter	= force_wakeup_read,
+	.write_iter	= force_wakeup_write,
 	.llseek		= default_llseek,
 };
 
@@ -227,27 +223,25 @@ static int msft_opcode_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(msft_opcode_fops, msft_opcode_get, msft_opcode_set,
 			 "%llu\n");
 
-static ssize_t aosp_capable_read(struct file *file, char __user *user_buf,
-				 size_t count, loff_t *ppos)
+static ssize_t aosp_capable_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct vhci_data *vhci = file->private_data;
+	struct vhci_data *vhci = iocb->ki_filp->private_data;
 	char buf[3];
 
 	buf[0] = vhci->aosp_capable ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
-static ssize_t aosp_capable_write(struct file *file,
-				  const char __user *user_buf, size_t count,
-				  loff_t *ppos)
+static ssize_t aosp_capable_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct vhci_data *vhci = file->private_data;
+	struct vhci_data *vhci = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	bool enable;
 	int err;
 
-	err = kstrtobool_from_user(user_buf, count, &enable);
+	err = kstrtobool_from_iter(from, count, &enable);
 	if (err)
 		return err;
 
@@ -264,8 +258,8 @@ static ssize_t aosp_capable_write(struct file *file,
 
 static const struct file_operations aosp_capable_fops = {
 	.open		= simple_open,
-	.read		= aosp_capable_read,
-	.write		= aosp_capable_write,
+	.read_iter	= aosp_capable_read,
+	.write_iter	= aosp_capable_write,
 	.llseek		= default_llseek,
 };
 
@@ -320,10 +314,10 @@ static inline void force_devcd_timeout(struct hci_dev *hdev,
 #endif
 }
 
-static ssize_t force_devcd_write(struct file *file, const char __user *user_buf,
-				 size_t count, loff_t *ppos)
+static ssize_t force_devcd_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct vhci_data *data = file->private_data;
+	struct vhci_data *data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct hci_dev *hdev = data->hdev;
 	struct sk_buff *skb = NULL;
 	struct devcoredump_test_data dump_data;
@@ -334,7 +328,7 @@ static ssize_t force_devcd_write(struct file *file, const char __user *user_buf,
 	    count > sizeof(dump_data))
 		return -EINVAL;
 
-	if (copy_from_user(&dump_data, user_buf, count))
+	if (!copy_from_iter_full(&dump_data, count, from))
 		return -EFAULT;
 
 	data_size = count - offsetof(struct devcoredump_test_data, data);
@@ -377,7 +371,7 @@ static ssize_t force_devcd_write(struct file *file, const char __user *user_buf,
 
 static const struct file_operations force_devcoredump_fops = {
 	.open		= simple_open,
-	.write		= force_devcd_write,
+	.write_iter	= force_devcd_write,
 };
 
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
@@ -608,6 +602,7 @@ static ssize_t vhci_read(struct file *file,
 
 	return ret;
 }
+FOPS_READ_ITER_HELPER(vhci_read);
 
 static ssize_t vhci_write(struct kiocb *iocb, struct iov_iter *from)
 {
@@ -684,7 +679,7 @@ static int vhci_release(struct inode *inode, struct file *file)
 
 static const struct file_operations vhci_fops = {
 	.owner		= THIS_MODULE,
-	.read		= vhci_read,
+	.read_iter	= vhci_read_iter,
 	.write_iter	= vhci_write,
 	.poll		= vhci_poll,
 	.open		= vhci_open,
-- 
2.43.0


