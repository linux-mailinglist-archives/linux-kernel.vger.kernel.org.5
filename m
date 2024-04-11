Return-Path: <linux-kernel+bounces-140870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A148A194B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2694A284CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B814F9F4;
	Thu, 11 Apr 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="09yiS8Cc"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFFA14EC6A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849685; cv=none; b=UJMrpVQGB9hHWRXiQhly1gCNEItTHWwg7aMHWj15rvy+jXb7WVGP/6oE/jkI1CrmYERaouBJiII6q3HUG6KbguJd0FbX4XjyPBsjhRANK8d9nqjkKroU424XmJrSNfQqhlqdPrALGHTVel4rtcbN93Y923fInMKMLV311qo+ZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849685; c=relaxed/simple;
	bh=EvF9GK5fbHclBik/U1ZhjLcyJWbBmhwlfutDJHY9YgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWZ2iYvyfbTp69ovre1/Y0g1v/gWw2ZOYr7PPh4AKLNEZhZbFLY1tdXFCtbgt03yBKCyPjm2AOY0BJyBa9sarUtxOGBhTXX2z/txWnBDt5zoI/l2weIna4vapEecIUTavpSs9UEueg0ji3xu+RkC3tT2NOXmORcOi+4dKYUmSxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=09yiS8Cc; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8913039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849680; x=1713454480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X69VkKRBRS4SFDGlDKAfZ/Z/En9tZp2QBRLJAwyAOQw=;
        b=09yiS8CcWQbJtgcH3fYbx+4F/FAEiTFz0FdSd+JmMMpIxqqgWhZ/IMbmwNFzQN5gUa
         43L7x0kUTPhyBxpVYxJDgjZWAUcI/X8U51OMSj58eB1Q9dbJMr1fQfNL8fBSY5yBo3kJ
         39HlNHnytEbAKqNaZROgQIS78wW3/io148f1KOwFHUIedxLSpz3SihNoKLs7H4D45lON
         6NKQvVNBU3mi8Is8ZZJ31Ur/lqvGMug2mcA6/ZjeGFjztULH5ssqqAvXJDxyQn16fkdn
         nDXhl3UflHPjLdwWI1OfTBJOe2Vaoke+YkYXBkNgqYQe68x1rAVuMxrIE1oVH1VZFD2p
         rCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849680; x=1713454480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X69VkKRBRS4SFDGlDKAfZ/Z/En9tZp2QBRLJAwyAOQw=;
        b=HQuqKSR8n8IGXZJWeKcrh0Od21MEjwxcSO0SvOjIbI1HM7ruywBbn4ppGdt71h0rqG
         V/FolsjA5tDpryz8XEbzkDJwVC+p1EWrPg15ZOp5gFQmAw3uuZQCWPt+Nn5rLYEY185q
         8QY1Oo7xlcF9qh1GW26UX3shvunAW7HnYgQfbLH7CG3m5NgY9D5RqTlqu9TrqGkr0KaF
         9GzeFP/g32fuGLHl7IsnKYh9f4Tj5pZJ/yhE3oKtGelZvtRp+V7ngP99brk2ubln91cm
         P5/5JiZD33hhlbrwi7VWywtb0ZAcH8IgcHyQzYo+XTA+lVF7k7517kCYfTQyC/2GDqIc
         VZDg==
X-Gm-Message-State: AOJu0YwKqM5VtsLAYuKeBUgrt4I3imYDO6MrUM6I935FMXUO8hfrZz8P
	BrkrDsx1Tk0ac2CQdSSA6X4gkvMJBaOcQ6lk9BTZRyK1/ZLbUo7N75E4WBtCuFn5yhdIjHEQODA
	n
X-Google-Smtp-Source: AGHT+IFU9YDLxYgk/NRreQh4oW+aVM5ku7TnNUhdZGYxwT9BiCbmhU5jsiW27zt+ETFg3i2rXgXPgQ==
X-Received: by 2002:a92:2912:0:b0:36a:f9aa:5757 with SMTP id l18-20020a922912000000b0036af9aa5757mr3578832ilg.2.1712849680519;
        Thu, 11 Apr 2024 08:34:40 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 106/437] crypto: hisilicon: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:06 -0600
Message-ID: <20240411153126.16201-107-axboe@kernel.dk>
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
 drivers/crypto/hisilicon/debugfs.c        | 51 +++++++++++------------
 drivers/crypto/hisilicon/hpre/hpre_main.c | 23 +++++-----
 drivers/crypto/hisilicon/qm.c             | 22 +++++-----
 drivers/crypto/hisilicon/sec2/sec_main.c  | 23 +++++-----
 drivers/crypto/hisilicon/zip/zip_main.c   | 23 +++++-----
 5 files changed, 68 insertions(+), 74 deletions(-)

diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index cd67fa348ca7..6dd67b0fcf36 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -137,8 +137,7 @@ static struct hisi_qm *file_to_qm(struct debugfs_file *file)
 	return container_of(debug, struct hisi_qm, debug);
 }
 
-static ssize_t qm_cmd_read(struct file *filp, char __user *buffer,
-			   size_t count, loff_t *pos)
+static ssize_t qm_cmd_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[QM_DBG_READ_LEN];
 	int len;
@@ -146,7 +145,7 @@ static ssize_t qm_cmd_read(struct file *filp, char __user *buffer,
 	len = scnprintf(buf, QM_DBG_READ_LEN, "%s\n",
 			"Please echo help to cmd to get help information");
 
-	return simple_read_from_buffer(buffer, count, pos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static void dump_show(struct hisi_qm *qm, void *info,
@@ -502,14 +501,14 @@ static int qm_cmd_write_dump(struct hisi_qm *qm, const char *cmd_buf)
 	return ret;
 }
 
-static ssize_t qm_cmd_write(struct file *filp, const char __user *buffer,
-			    size_t count, loff_t *pos)
+static ssize_t qm_cmd_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hisi_qm *qm = filp->private_data;
+	struct hisi_qm *qm = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char *cmd_buf, *cmd_buf_tmp;
 	int ret;
 
-	if (*pos)
+	if (iocb->ki_pos)
 		return 0;
 
 	ret = hisi_qm_get_dfx_access(qm);
@@ -527,7 +526,7 @@ static ssize_t qm_cmd_write(struct file *filp, const char __user *buffer,
 		goto put_dfx_access;
 	}
 
-	cmd_buf = memdup_user_nul(buffer, count);
+	cmd_buf = iterdup_nul(from, count);
 	if (IS_ERR(cmd_buf)) {
 		ret = PTR_ERR(cmd_buf);
 		goto put_dfx_access;
@@ -557,8 +556,8 @@ static ssize_t qm_cmd_write(struct file *filp, const char __user *buffer,
 static const struct file_operations qm_cmd_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = qm_cmd_read,
-	.write = qm_cmd_write,
+	.read_iter = qm_cmd_read,
+	.write_iter = qm_cmd_write,
 };
 
 /**
@@ -704,10 +703,9 @@ static int current_qm_write(struct hisi_qm *qm, u32 val)
 	return 0;
 }
 
-static ssize_t qm_debug_read(struct file *filp, char __user *buf,
-			     size_t count, loff_t *pos)
+static ssize_t qm_debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct debugfs_file *file = filp->private_data;
+	struct debugfs_file *file = iocb->ki_filp->private_data;
 	enum qm_debug_file index = file->index;
 	struct hisi_qm *qm = file_to_qm(file);
 	char tbuf[QM_DBG_TMP_BUF_LEN];
@@ -736,7 +734,7 @@ static ssize_t qm_debug_read(struct file *filp, char __user *buf,
 
 	hisi_qm_put_dfx_access(qm);
 	ret = scnprintf(tbuf, QM_DBG_TMP_BUF_LEN, "%u\n", val);
-	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+	return simple_copy_to_iter(tbuf, &iocb->ki_pos, ret, to);
 
 err_input:
 	mutex_unlock(&file->lock);
@@ -744,24 +742,24 @@ static ssize_t qm_debug_read(struct file *filp, char __user *buf,
 	return -EINVAL;
 }
 
-static ssize_t qm_debug_write(struct file *filp, const char __user *buf,
-			      size_t count, loff_t *pos)
+static ssize_t qm_debug_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct debugfs_file *file = filp->private_data;
+	struct debugfs_file *file = iocb->ki_filp->private_data;
 	enum qm_debug_file index = file->index;
 	struct hisi_qm *qm = file_to_qm(file);
+	size_t count = iov_iter_count(from);
 	unsigned long val;
 	char tbuf[QM_DBG_TMP_BUF_LEN];
 	int len, ret;
 
-	if (*pos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	if (count >= QM_DBG_TMP_BUF_LEN)
 		return -ENOSPC;
 
-	len = simple_write_to_buffer(tbuf, QM_DBG_TMP_BUF_LEN - 1, pos, buf,
-				     count);
+	len = simple_copy_from_iter(tbuf, &iocb->ki_pos, QM_DBG_TMP_BUF_LEN - 1,
+					from);
 	if (len < 0)
 		return len;
 
@@ -800,8 +798,8 @@ static ssize_t qm_debug_write(struct file *filp, const char __user *buf,
 static const struct file_operations qm_debug_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = qm_debug_read,
-	.write = qm_debug_write,
+	.read_iter = qm_debug_read,
+	.write_iter = qm_debug_write,
 };
 
 static void dfx_regs_uninit(struct hisi_qm *qm,
@@ -1051,23 +1049,22 @@ static int qm_state_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(qm_state);
 
-static ssize_t qm_status_read(struct file *filp, char __user *buffer,
-			      size_t count, loff_t *pos)
+static ssize_t qm_status_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hisi_qm *qm = filp->private_data;
+	struct hisi_qm *qm = iocb->ki_filp->private_data;
 	char buf[QM_DBG_READ_LEN];
 	int val, len;
 
 	val = atomic_read(&qm->status.flags);
 	len = scnprintf(buf, QM_DBG_READ_LEN, "%s\n", qm_s[val]);
 
-	return simple_read_from_buffer(buffer, count, pos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations qm_status_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = qm_status_read,
+	.read_iter = qm_status_read,
 };
 
 static void qm_create_debugfs_file(struct hisi_qm *qm, struct dentry *dir,
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index d93aa6630a57..b9257a368aa9 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -829,10 +829,9 @@ static void hpre_cluster_inqry_write(struct hpre_debugfs_file *file, u32 val)
 	writel(val, qm->io_base + offset + HPRE_CLUSTER_INQURY);
 }
 
-static ssize_t hpre_ctrl_debug_read(struct file *filp, char __user *buf,
-				    size_t count, loff_t *pos)
+static ssize_t hpre_ctrl_debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hpre_debugfs_file *file = filp->private_data;
+	struct hpre_debugfs_file *file = iocb->ki_filp->private_data;
 	struct hisi_qm *qm = hpre_file_to_qm(file);
 	char tbuf[HPRE_DBGFS_VAL_MAX_LEN];
 	u32 val;
@@ -857,7 +856,7 @@ static ssize_t hpre_ctrl_debug_read(struct file *filp, char __user *buf,
 
 	hisi_qm_put_dfx_access(qm);
 	ret = snprintf(tbuf, HPRE_DBGFS_VAL_MAX_LEN, "%u\n", val);
-	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+	return simple_copy_to_iter(tbuf, &iocb->ki_pos, ret, to);
 
 err_input:
 	spin_unlock_irq(&file->lock);
@@ -865,23 +864,23 @@ static ssize_t hpre_ctrl_debug_read(struct file *filp, char __user *buf,
 	return -EINVAL;
 }
 
-static ssize_t hpre_ctrl_debug_write(struct file *filp, const char __user *buf,
-				     size_t count, loff_t *pos)
+static ssize_t hpre_ctrl_debug_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hpre_debugfs_file *file = filp->private_data;
+	struct hpre_debugfs_file *file = iocb->ki_filp->private_data;
 	struct hisi_qm *qm = hpre_file_to_qm(file);
+	size_t count = iov_iter_count(from);
 	char tbuf[HPRE_DBGFS_VAL_MAX_LEN];
 	unsigned long val;
 	int len, ret;
 
-	if (*pos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	if (count >= HPRE_DBGFS_VAL_MAX_LEN)
 		return -ENOSPC;
 
-	len = simple_write_to_buffer(tbuf, HPRE_DBGFS_VAL_MAX_LEN - 1,
-				     pos, buf, count);
+	len = simple_copy_from_iter(tbuf, &iocb->ki_pos,
+					HPRE_DBGFS_VAL_MAX_LEN - 1, from);
 	if (len < 0)
 		return len;
 
@@ -919,8 +918,8 @@ static ssize_t hpre_ctrl_debug_write(struct file *filp, const char __user *buf,
 static const struct file_operations hpre_ctrl_debug_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = hpre_ctrl_debug_read,
-	.write = hpre_ctrl_debug_write,
+	.read_iter = hpre_ctrl_debug_read,
+	.write_iter = hpre_ctrl_debug_write,
 };
 
 static int hpre_debugfs_atomic64_get(void *data, u64 *val)
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 92f0a1d9b4a6..604cff89f0c8 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3591,10 +3591,9 @@ static int qm_vf_read_qos(struct hisi_qm *qm)
 	return ret;
 }
 
-static ssize_t qm_algqos_read(struct file *filp, char __user *buf,
-			       size_t count, loff_t *pos)
+static ssize_t qm_algqos_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hisi_qm *qm = filp->private_data;
+	struct hisi_qm *qm = iocb->ki_filp->private_data;
 	char tbuf[QM_DBG_READ_LEN];
 	u32 qos_val, ir;
 	int ret;
@@ -3622,7 +3621,7 @@ static ssize_t qm_algqos_read(struct file *filp, char __user *buf,
 	qos_val = ir / QM_QOS_RATE;
 	ret = scnprintf(tbuf, QM_DBG_READ_LEN, "%u\n", qos_val);
 
-	ret = simple_read_from_buffer(buf, count, pos, tbuf, ret);
+	ret = simple_copy_to_iter(tbuf, &iocb->ki_pos, ret, to);
 
 err_get_status:
 	clear_bit(QM_RESETTING, &qm->misc_ctl);
@@ -3665,22 +3664,23 @@ static ssize_t qm_get_qos_value(struct hisi_qm *qm, const char *buf,
 	return 0;
 }
 
-static ssize_t qm_algqos_write(struct file *filp, const char __user *buf,
-			       size_t count, loff_t *pos)
+static ssize_t qm_algqos_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hisi_qm *qm = filp->private_data;
+	struct hisi_qm *qm = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char tbuf[QM_DBG_READ_LEN];
 	unsigned int fun_index;
 	unsigned long val;
 	int len, ret;
 
-	if (*pos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	if (count >= QM_DBG_READ_LEN)
 		return -ENOSPC;
 
-	len = simple_write_to_buffer(tbuf, QM_DBG_READ_LEN - 1, pos, buf, count);
+	len = simple_copy_from_iter(tbuf, &iocb->ki_pos, QM_DBG_READ_LEN - 1,
+					from);
 	if (len < 0)
 		return len;
 
@@ -3722,8 +3722,8 @@ static ssize_t qm_algqos_write(struct file *filp, const char __user *buf,
 static const struct file_operations qm_algqos_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = qm_algqos_read,
-	.write = qm_algqos_write,
+	.read_iter = qm_algqos_read,
+	.write_iter = qm_algqos_write,
 };
 
 /**
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index c290d8937b19..bb168d97de30 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -718,10 +718,9 @@ static int sec_clear_enable_write(struct hisi_qm *qm, u32 val)
 	return 0;
 }
 
-static ssize_t sec_debug_read(struct file *filp, char __user *buf,
-			       size_t count, loff_t *pos)
+static ssize_t sec_debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct sec_debug_file *file = filp->private_data;
+	struct sec_debug_file *file = iocb->ki_filp->private_data;
 	char tbuf[SEC_DBGFS_VAL_MAX_LEN];
 	struct hisi_qm *qm = file->qm;
 	u32 val;
@@ -745,7 +744,7 @@ static ssize_t sec_debug_read(struct file *filp, char __user *buf,
 
 	hisi_qm_put_dfx_access(qm);
 	ret = snprintf(tbuf, SEC_DBGFS_VAL_MAX_LEN, "%u\n", val);
-	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+	return simple_copy_to_iter(tbuf, &iocb->ki_pos, ret, to);
 
 err_input:
 	spin_unlock_irq(&file->lock);
@@ -753,23 +752,23 @@ static ssize_t sec_debug_read(struct file *filp, char __user *buf,
 	return -EINVAL;
 }
 
-static ssize_t sec_debug_write(struct file *filp, const char __user *buf,
-			       size_t count, loff_t *pos)
+static ssize_t sec_debug_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct sec_debug_file *file = filp->private_data;
+	struct sec_debug_file *file = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char tbuf[SEC_DBGFS_VAL_MAX_LEN];
 	struct hisi_qm *qm = file->qm;
 	unsigned long val;
 	int len, ret;
 
-	if (*pos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	if (count >= SEC_DBGFS_VAL_MAX_LEN)
 		return -ENOSPC;
 
-	len = simple_write_to_buffer(tbuf, SEC_DBGFS_VAL_MAX_LEN - 1,
-				     pos, buf, count);
+	len = simple_copy_from_iter(tbuf, &iocb->ki_pos,
+					SEC_DBGFS_VAL_MAX_LEN - 1, from);
 	if (len < 0)
 		return len;
 
@@ -805,8 +804,8 @@ static ssize_t sec_debug_write(struct file *filp, const char __user *buf,
 static const struct file_operations sec_dbg_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = sec_debug_read,
-	.write = sec_debug_write,
+	.read_iter = sec_debug_read,
+	.write_iter = sec_debug_write,
 };
 
 static int sec_debugfs_atomic64_get(void *data, u64 *val)
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index c065fd867161..47319ba13873 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -689,10 +689,9 @@ static int clear_enable_write(struct hisi_qm *qm, u32 val)
 	return  0;
 }
 
-static ssize_t hisi_zip_ctrl_debug_read(struct file *filp, char __user *buf,
-					size_t count, loff_t *pos)
+static ssize_t hisi_zip_ctrl_debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ctrl_debug_file *file = filp->private_data;
+	struct ctrl_debug_file *file = iocb->ki_filp->private_data;
 	struct hisi_qm *qm = file_to_qm(file);
 	char tbuf[HZIP_BUF_SIZE];
 	u32 val;
@@ -714,7 +713,7 @@ static ssize_t hisi_zip_ctrl_debug_read(struct file *filp, char __user *buf,
 
 	hisi_qm_put_dfx_access(qm);
 	ret = scnprintf(tbuf, sizeof(tbuf), "%u\n", val);
-	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+	return simple_copy_to_iter(tbuf, &iocb->ki_pos, ret, to);
 
 err_input:
 	spin_unlock_irq(&file->lock);
@@ -722,23 +721,23 @@ static ssize_t hisi_zip_ctrl_debug_read(struct file *filp, char __user *buf,
 	return -EINVAL;
 }
 
-static ssize_t hisi_zip_ctrl_debug_write(struct file *filp,
-					 const char __user *buf,
-					 size_t count, loff_t *pos)
+static ssize_t hisi_zip_ctrl_debug_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct ctrl_debug_file *file = filp->private_data;
+	struct ctrl_debug_file *file = iocb->ki_filp->private_data;
 	struct hisi_qm *qm = file_to_qm(file);
+	size_t count = iov_iter_count(from);
 	char tbuf[HZIP_BUF_SIZE];
 	unsigned long val;
 	int len, ret;
 
-	if (*pos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	if (count >= HZIP_BUF_SIZE)
 		return -ENOSPC;
 
-	len = simple_write_to_buffer(tbuf, HZIP_BUF_SIZE - 1, pos, buf, count);
+	len = simple_copy_from_iter(tbuf, &iocb->ki_pos, HZIP_BUF_SIZE - 1, from);
 	if (len < 0)
 		return len;
 
@@ -774,8 +773,8 @@ static ssize_t hisi_zip_ctrl_debug_write(struct file *filp,
 static const struct file_operations ctrl_debug_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = hisi_zip_ctrl_debug_read,
-	.write = hisi_zip_ctrl_debug_write,
+	.read_iter = hisi_zip_ctrl_debug_read,
+	.write_iter = hisi_zip_ctrl_debug_write,
 };
 
 static int zip_debugfs_atomic64_set(void *data, u64 val)
-- 
2.43.0


