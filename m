Return-Path: <linux-kernel+bounces-140811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BFB8A190F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528331F218E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63C469D05;
	Thu, 11 Apr 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wofaxCjC"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7EA6CDB3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849592; cv=none; b=ZOAOLP4TvlR90dndX1kt0ed7hP0nho3eFF+hnSFz808KmnYCPa1i/DLZETTiSEhONmyV1Ly3I+B/ek9QM2R7vfE+CsTqqHbZlxy4++e74z92U0heFRsJvqC1wXM+bXT1LTBWsfSor2msY8KV1fGg4Za4wpZ2QjfMBZ98+9ILD2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849592; c=relaxed/simple;
	bh=sTP8rsrKxUZBohRj1v3SSYyY04HA7Nmsipa22jIW3Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9sUOmsBDaUtZgFymBaCHqcYPWJW32Z+Y2Ady06QnmI4DlJEpQXpoUC1O3PQhVB/4UXm/cRps6o6cFofoUcPZNVPgc4yVBdwF+MC+CXWAw+MKW9KVyUJvFs1FcFzhcFvgNCD+/zx4gUa1/2OP2Ds/H1MvT3KrwFLcBvmQkS9uPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wofaxCjC; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170444339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849588; x=1713454388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4S4qyslAavPK8ZPFMWkHgRsl95Bjo1/MpiDGtaiWSMU=;
        b=wofaxCjClRkcrY8mZBFmFL8z2gz55753GhZFxD0h6h9f+KzjBHpuRGQ0naoqlh8YUS
         v8GnkCiIjeEAoVjG2cm3ghwzpFYNGSNc7CcKgKZ/EMZzgqPnFr2T30gcIgOESuIqBTk9
         vE7/0tvy3OxSjCFtG5/artWtx9bSWln9A/3mT8eDhGCyOovJbJf0HTd0JbeRgXM2jyPm
         I7aosk+WWCm2porx5B6XBn8xmPf/E/hFPI1nSEE0yFA8uHdoskPkr4yklHWeRxo5mqC1
         iAmsSVSkfJutrwC5OeLJDrkQD2Bt/ySU+8y+z+qQMDo1NRAPeuT1rcZ4LkyAN/uCojR3
         yjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849588; x=1713454388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4S4qyslAavPK8ZPFMWkHgRsl95Bjo1/MpiDGtaiWSMU=;
        b=Az+FbPsuVOODVRkiMFGZCazWHuyXa+wkL6R2YN9WDq4FZtaV+rrg4IFmrFbc6gKrnS
         xTEiT5ZyvYwn0eCPoYsl4NuRZ2Z91WTal9TxS+q1kfajl7ST5QFqnqG/X7LlGkW3uMTN
         jL517+hD2UU5jva35xF+caMdodxcIBqCyxfWKc302rHtouagGbpf2fbKT9BBlu2dVolm
         R0sHOFMzhZvjuYALoyvvqj3sMzAJ1LsCzuULG1JbejhjxBMmML56eugzJXtdmW6uedcT
         26pg05Fvxcs6N/nROVLZJ+UhbyEZhgg5nJ6CEADIFoLXmRP+Y/9jw+gSWE8pUGcJVNsS
         whAg==
X-Gm-Message-State: AOJu0Yyce99lfgaty8CZ6yKJ4Ys1xtomlI/zNGyzTT1WF1ClAs62AtF8
	q+eKP2rLwrMVfXIk8qK/YRu/8zEjXc2X7YoTO02RMMjKfmy2NS/EfYAQkWZWyEUrCFAhCKkPaH4
	y
X-Google-Smtp-Source: AGHT+IFDznKLj7AbuI+y5QWIcZ8ghthMmNGsTTAO78MLXp8ZB/1JY2P3Xe0s2Zpgwk3zOX+ZDe+ksg==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr213962ioh.0.1712849588298;
        Thu, 11 Apr 2024 08:33:08 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 051/437] Bluetooth: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:11 -0600
Message-ID: <20240411153126.16201-52-axboe@kernel.dk>
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
 net/bluetooth/6lowpan.c     |  12 ++-
 net/bluetooth/hci_debugfs.c | 150 ++++++++++++++++--------------------
 net/bluetooth/selftest.c    |   9 +--
 net/bluetooth/smp.c         |   9 +--
 4 files changed, 80 insertions(+), 100 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 27520a8a486f..74e8ce90f12b 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1079,19 +1079,17 @@ static int lowpan_enable_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(lowpan_enable_fops, lowpan_enable_get,
 			 lowpan_enable_set, "%llu\n");
 
-static ssize_t lowpan_control_write(struct file *fp,
-				    const char __user *user_buffer,
-				    size_t count,
-				    loff_t *position)
+static ssize_t lowpan_control_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char buf[32];
+	size_t count = iov_iter_count(from);
 	size_t buf_size = min(count, sizeof(buf) - 1);
 	int ret;
 	bdaddr_t addr;
 	u8 addr_type;
 	struct l2cap_conn *conn = NULL;
 
-	if (copy_from_user(buf, user_buffer, buf_size))
+	if (!copy_to_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	buf[buf_size] = '\0';
@@ -1173,8 +1171,8 @@ static int lowpan_control_open(struct inode *inode, struct file *file)
 
 static const struct file_operations lowpan_control_fops = {
 	.open		= lowpan_control_open,
-	.read		= seq_read,
-	.write		= lowpan_control_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= lowpan_control_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index ce3ff2fa72e5..736c265e3ddf 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -32,31 +32,28 @@
 #include "hci_debugfs.h"
 
 #define DEFINE_QUIRK_ATTRIBUTE(__name, __quirk)				      \
-static ssize_t __name ## _read(struct file *file,			      \
-				char __user *user_buf,			      \
-				size_t count, loff_t *ppos)		      \
+static ssize_t __name ## _read(struct kiocb *iocb, struct iov_iter *to)	      \
 {									      \
-	struct hci_dev *hdev = file->private_data;			      \
+	struct hci_dev *hdev = iocb->ki_filp->private_data;		      \
 	char buf[3];							      \
 									      \
 	buf[0] = test_bit(__quirk, &hdev->quirks) ? 'Y' : 'N';		      \
 	buf[1] = '\n';							      \
 	buf[2] = '\0';							      \
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);	      \
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);	      \
 }									      \
 									      \
-static ssize_t __name ## _write(struct file *file,			      \
-				 const char __user *user_buf,		      \
-				 size_t count, loff_t *ppos)		      \
+static ssize_t __name ## _write(struct kiocb *iocb, struct iov_iter *from)    \
 {									      \
-	struct hci_dev *hdev = file->private_data;			      \
+	struct hci_dev *hdev = iocb->ki_filp->private_data;		      \
+	size_t count = iov_iter_count(from);				      \
 	bool enable;							      \
 	int err;							      \
 									      \
 	if (test_bit(HCI_UP, &hdev->flags))				      \
 		return -EBUSY;						      \
 									      \
-	err = kstrtobool_from_user(user_buf, count, &enable);		      \
+	err = kstrtobool_from_iter(from, count, &enable);		      \
 	if (err)							      \
 		return err;						      \
 									      \
@@ -70,8 +67,8 @@ static ssize_t __name ## _write(struct file *file,			      \
 									      \
 static const struct file_operations __name ## _fops = {			      \
 	.open		= simple_open,					      \
-	.read		= __name ## _read,				      \
-	.write		= __name ## _write,				      \
+	.read_iter	= __name ## _read,				      \
+	.write_iter	= __name ## _write,				      \
 	.llseek		= default_llseek,				      \
 }									      \
 
@@ -274,39 +271,37 @@ static int conn_info_max_age_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(conn_info_max_age_fops, conn_info_max_age_get,
 			  conn_info_max_age_set, "%llu\n");
 
-static ssize_t use_debug_keys_read(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t use_debug_keys_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hci_dev *hdev = file->private_data;
+	struct hci_dev *hdev = iocb->ki_filp->private_data;
 	char buf[3];
 
 	buf[0] = hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS) ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
 static const struct file_operations use_debug_keys_fops = {
 	.open		= simple_open,
-	.read		= use_debug_keys_read,
+	.read_iter	= use_debug_keys_read,
 	.llseek		= default_llseek,
 };
 
-static ssize_t sc_only_mode_read(struct file *file, char __user *user_buf,
-				 size_t count, loff_t *ppos)
+static ssize_t sc_only_mode_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hci_dev *hdev = file->private_data;
+	struct hci_dev *hdev = iocb->ki_filp->private_data;
 	char buf[3];
 
 	buf[0] = hci_dev_test_flag(hdev, HCI_SC_ONLY) ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
 static const struct file_operations sc_only_mode_fops = {
 	.open		= simple_open,
-	.read		= sc_only_mode_read,
+	.read_iter	= sc_only_mode_read,
 	.llseek		= default_llseek,
 };
 
@@ -428,21 +423,20 @@ static int voice_setting_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(voice_setting_fops, voice_setting_get,
 			  NULL, "0x%4.4llx\n");
 
-static ssize_t ssp_debug_mode_read(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t ssp_debug_mode_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hci_dev *hdev = file->private_data;
+	struct hci_dev *hdev = iocb->ki_filp->private_data;
 	char buf[3];
 
 	buf[0] = hdev->ssp_debug_mode ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
 static const struct file_operations ssp_debug_mode_fops = {
 	.open		= simple_open,
-	.read		= ssp_debug_mode_read,
+	.read_iter	= ssp_debug_mode_read,
 	.llseek		= default_llseek,
 };
 
@@ -500,28 +494,25 @@ static int auto_accept_delay_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
 			  auto_accept_delay_set, "%llu\n");
 
-static ssize_t force_bredr_smp_read(struct file *file,
-				    char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t force_bredr_smp_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hci_dev *hdev = file->private_data;
+	struct hci_dev *hdev = iocb->ki_filp->private_data;
 	char buf[3];
 
 	buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP) ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
-static ssize_t force_bredr_smp_write(struct file *file,
-				     const char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t force_bredr_smp_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hci_dev *hdev = file->private_data;
+	struct hci_dev *hdev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	bool enable;
 	int err;
 
-	err = kstrtobool_from_user(user_buf, count, &enable);
+	err = kstrtobool_from_iter(from, count, &enable);
 	if (err)
 		return err;
 
@@ -534,8 +525,8 @@ static ssize_t force_bredr_smp_write(struct file *file,
 
 static const struct file_operations force_bredr_smp_fops = {
 	.open		= simple_open,
-	.read		= force_bredr_smp_read,
-	.write		= force_bredr_smp_write,
+	.read_iter	= force_bredr_smp_read,
+	.write_iter	= force_bredr_smp_write,
 	.llseek		= default_llseek,
 };
 
@@ -745,31 +736,29 @@ static int static_address_show(struct seq_file *f, void *p)
 
 DEFINE_SHOW_ATTRIBUTE(static_address);
 
-static ssize_t force_static_address_read(struct file *file,
-					 char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t force_static_address_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hci_dev *hdev = file->private_data;
+	struct hci_dev *hdev = iocb->ki_filp->private_data;
 	char buf[3];
 
 	buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
-static ssize_t force_static_address_write(struct file *file,
-					  const char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t force_static_address_write(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct hci_dev *hdev = file->private_data;
+	struct hci_dev *hdev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	bool enable;
 	int err;
 
 	if (hdev_is_powered(hdev))
 		return -EBUSY;
 
-	err = kstrtobool_from_user(user_buf, count, &enable);
+	err = kstrtobool_from_iter(from, count, &enable);
 	if (err)
 		return err;
 
@@ -783,8 +772,8 @@ static ssize_t force_static_address_write(struct file *file,
 
 static const struct file_operations force_static_address_fops = {
 	.open		= simple_open,
-	.read		= force_static_address_read,
-	.write		= force_static_address_write,
+	.read_iter	= force_static_address_read,
+	.write_iter	= force_static_address_write,
 	.llseek		= default_llseek,
 };
 
@@ -1147,29 +1136,26 @@ DEFINE_DEBUGFS_ATTRIBUTE(auth_payload_timeout_fops,
 			  auth_payload_timeout_get,
 			  auth_payload_timeout_set, "%llu\n");
 
-static ssize_t force_no_mitm_read(struct file *file,
-				  char __user *user_buf,
-				  size_t count, loff_t *ppos)
+static ssize_t force_no_mitm_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hci_dev *hdev = file->private_data;
+	struct hci_dev *hdev = iocb->ki_filp->private_data;
 	char buf[3];
 
 	buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_NO_MITM) ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
-static ssize_t force_no_mitm_write(struct file *file,
-				   const char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t force_no_mitm_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hci_dev *hdev = file->private_data;
+	struct hci_dev *hdev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	size_t buf_size = min(count, (sizeof(buf) - 1));
 	bool enable;
 
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	buf[buf_size] = '\0';
@@ -1186,8 +1172,8 @@ static ssize_t force_no_mitm_write(struct file *file,
 
 static const struct file_operations force_no_mitm_fops = {
 	.open		= simple_open,
-	.read		= force_no_mitm_read,
-	.write		= force_no_mitm_write,
+	.read_iter	= force_no_mitm_read,
+	.write_iter	= force_no_mitm_write,
 	.llseek		= default_llseek,
 };
 
@@ -1273,22 +1259,21 @@ void hci_debugfs_create_conn(struct hci_conn *conn)
 	conn->debugfs = debugfs_create_dir(name, hdev->debugfs);
 }
 
-static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
-			     size_t count, loff_t *ppos)
+static ssize_t dut_mode_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hci_dev *hdev = file->private_data;
+	struct hci_dev *hdev = iocb->ki_filp->private_data;
 	char buf[3];
 
 	buf[0] = hci_dev_test_flag(hdev, HCI_DUT_MODE) ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
-static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t dut_mode_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hci_dev *hdev = file->private_data;
+	struct hci_dev *hdev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct sk_buff *skb;
 	bool enable;
 	int err;
@@ -1296,7 +1281,7 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	if (!test_bit(HCI_UP, &hdev->flags))
 		return -ENETDOWN;
 
-	err = kstrtobool_from_user(user_buf, count, &enable);
+	err = kstrtobool_from_iter(from, count, &enable);
 	if (err)
 		return err;
 
@@ -1324,31 +1309,30 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 
 static const struct file_operations dut_mode_fops = {
 	.open		= simple_open,
-	.read		= dut_mode_read,
-	.write		= dut_mode_write,
+	.read_iter	= dut_mode_read,
+	.write_iter	= dut_mode_write,
 	.llseek		= default_llseek,
 };
 
-static ssize_t vendor_diag_read(struct file *file, char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t vendor_diag_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hci_dev *hdev = file->private_data;
+	struct hci_dev *hdev = iocb->ki_filp->private_data;
 	char buf[3];
 
 	buf[0] = hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
-static ssize_t vendor_diag_write(struct file *file, const char __user *user_buf,
-				 size_t count, loff_t *ppos)
+static ssize_t vendor_diag_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hci_dev *hdev = file->private_data;
+	struct hci_dev *hdev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	bool enable;
 	int err;
 
-	err = kstrtobool_from_user(user_buf, count, &enable);
+	err = kstrtobool_from_iter(from, count, &enable);
 	if (err)
 		return err;
 
@@ -1380,8 +1364,8 @@ static ssize_t vendor_diag_write(struct file *file, const char __user *user_buf,
 
 static const struct file_operations vendor_diag_fops = {
 	.open		= simple_open,
-	.read		= vendor_diag_read,
-	.write		= vendor_diag_write,
+	.read_iter	= vendor_diag_read,
+	.write_iter	= vendor_diag_write,
 	.llseek		= default_llseek,
 };
 
diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
index f49604d44b87..e8f3e5d63c01 100644
--- a/net/bluetooth/selftest.c
+++ b/net/bluetooth/selftest.c
@@ -183,16 +183,15 @@ static int __init test_ecdh_sample(struct crypto_kpp *tfm, const u8 priv_a[32],
 
 static char test_ecdh_buffer[32];
 
-static ssize_t test_ecdh_read(struct file *file, char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t test_ecdh_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return simple_read_from_buffer(user_buf, count, ppos, test_ecdh_buffer,
-				       strlen(test_ecdh_buffer));
+	return simple_copy_to_iter(test_ecdh_buffer, &iocb->ki_pos,
+				   strlen(test_ecdh_buffer), to);
 }
 
 static const struct file_operations test_ecdh_fops = {
 	.open		= simple_open,
-	.read		= test_ecdh_read,
+	.read_iter	= test_ecdh_read,
 	.llseek		= default_llseek,
 };
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1e7ea3a4b7ef..fcd35201712b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3729,16 +3729,15 @@ static int __init test_h6(struct crypto_shash *tfm_cmac)
 
 static char test_smp_buffer[32];
 
-static ssize_t test_smp_read(struct file *file, char __user *user_buf,
-			     size_t count, loff_t *ppos)
+static ssize_t test_smp_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return simple_read_from_buffer(user_buf, count, ppos, test_smp_buffer,
-				       strlen(test_smp_buffer));
+	return simple_copy_to_iter(test_smp_buffer, &iocb->ki_pos,
+				   strlen(test_smp_buffer), to);
 }
 
 static const struct file_operations test_smp_fops = {
 	.open		= simple_open,
-	.read		= test_smp_read,
+	.read_iter	= test_smp_read,
 	.llseek		= default_llseek,
 };
 
-- 
2.43.0


