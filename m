Return-Path: <linux-kernel+bounces-141101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3358A1A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EEF1C23340
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354731635AA;
	Thu, 11 Apr 2024 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b0/M1RmD"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C6D4C601
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850039; cv=none; b=VO8Mn6f36tyNYu4vTE03YuBHYolwlR0hEbpQlZ6dpjB+ihtM5hqyUCg+EjjGVM731nH2T7yxtd/FEhOtiBV4pGM15OfIPmOUMzuAFl+eJcQFYdEtOk3x41MYuROQKswfeV2nw2BTMbtUq82Q/yIIrqUMLM4bw/6Mu6xjv3Z8o/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850039; c=relaxed/simple;
	bh=I+sj5vVgdY0extT9pyDmhTNvVk/D351FuFUjnQiEyjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a28+Ev/xDGJQC40Ib7l7L9qyE/QllhR3LmIYob5J+C5sY0Kqsgi3Oz+UzGIY7mbVuG9qEO1llUtaJxYPfgdbaXOdd8bf5E2esFKywCsI69TVykN8DCYV1GKX/4cMh2fzq3TdWMJbZu3wSzZo/OfbTlPfnFLhtwU9qg/+dfPALRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b0/M1RmD; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36a34b68277so119095ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850036; x=1713454836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrQjAUuOjy9NNVtrz6WAy9mNFgnOw/l75kQoVjJmnEk=;
        b=b0/M1RmDVB1xTpdIDgZMHXdFp4GrAUFC31I/e1P0eIbo0B9AXuOz+2ZTQRTX/6hQbr
         Q7zPNyfwjx6xjrQq1JvYzXgl5gHUjg+oWqTOwJhNVV4ZyQCH+Q27+PUsiQgRg+hHDEGO
         xmWE2kcacBH0m8/MsOj7HYpPUWgv0exFB1KJs8MzC0mn0IAFUMAVBL1RSi7szGmEe81x
         UXGvpOxbiu2GzeSpkArkjKKUD7KysRFQd9zFSbHpXhR9PEeNYb9ip1ByYL1rRooxdJw1
         a0iACd/AUcNRP4YrD0lOz4PQqRFA0QVlXVMc6+qhhD+pDIInvTR1vhbVG/uS7HeCt/Lp
         wPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850036; x=1713454836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrQjAUuOjy9NNVtrz6WAy9mNFgnOw/l75kQoVjJmnEk=;
        b=bWC2pRvqDmt3idgIwiFbd2Nj9hhYLXWM9tiolB3pJZ+DtkN7nb4DLSRea59hqGJBSu
         sssXrHBpiZkMphXymtOB3myiSDRTVRQLAvzl8KS18tCd5TnPuz+qtzUwpZGRjTzA9dtq
         tFZwDAzh9+cW2uySp1QxktWAAQRCX4qumudISeTiR2M7OHKBmt7EqmM0Ro0rh4/IT87s
         LFnivQ8pl1IdHTBO9nBtPp+ugxqkjqqn6KL/U8PgzetPL8PCor+UfGD5LdsuGYaXvC3Y
         NMutnjCHJZjNvcYf7Az6imX1av2M1SZoKMYFG9M0U46FSpvPxONuFp2OgEFlD+Xkxzbs
         ePKQ==
X-Gm-Message-State: AOJu0YyGTI3KvRe6kkdzMxKImYqPCzuTL11nrx2azjyWc7sEx8AESPBA
	O5hbeI6MoORiwmDDiCsbV6P7FwL1W8TMgJe4cs3+W4f/+3ThcZDk2dc6yhS8li9sGJIbhpz/RQA
	R
X-Google-Smtp-Source: AGHT+IEP/XZEUN6s+PTr/rM66dAw4hYPHq4Xrjqo0p0/0C74uUnda2VM7YZPLGg/iwpgA4FdHqavsA==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr199269iob.1.1712850036241;
        Thu, 11 Apr 2024 08:40:36 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 324/437] drivers/net/ethernet/chelsio: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:44 -0600
Message-ID: <20240411153126.16201-325-axboe@kernel.dk>
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

From: Bui Quang Minh <minhquangbui99@gmail.com>

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 .../ethernet/chelsio/cxgb4/cxgb4_debugfs.c    | 321 +++++++++---------
 drivers/net/ethernet/chelsio/cxgb4/l2t.c      |   2 +-
 2 files changed, 164 insertions(+), 159 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
index 14e0d989c3ba..a3b94ceea07d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
@@ -227,11 +227,11 @@ static int cim_la_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations cim_la_fops = {
-	.owner   = THIS_MODULE,
-	.open    = cim_la_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release_private
+	.owner     = THIS_MODULE,
+	.open      = cim_la_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release_private
 };
 
 static int cim_pif_la_show(struct seq_file *seq, void *v, int idx)
@@ -270,11 +270,11 @@ static int cim_pif_la_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations cim_pif_la_fops = {
-	.owner   = THIS_MODULE,
-	.open    = cim_pif_la_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release_private
+	.owner     = THIS_MODULE,
+	.open      = cim_pif_la_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release_private
 };
 
 static int cim_ma_la_show(struct seq_file *seq, void *v, int idx)
@@ -316,11 +316,11 @@ static int cim_ma_la_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations cim_ma_la_fops = {
-	.owner   = THIS_MODULE,
-	.open    = cim_ma_la_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release_private
+	.owner     = THIS_MODULE,
+	.open      = cim_ma_la_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release_private
 };
 
 static int cim_qcfg_show(struct seq_file *seq, void *v)
@@ -409,11 +409,11 @@ static int cim_ibq_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations cim_ibq_fops = {
-	.owner   = THIS_MODULE,
-	.open    = cim_ibq_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release_private
+	.owner     = THIS_MODULE,
+	.open      = cim_ibq_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release_private
 };
 
 static int cim_obq_open(struct inode *inode, struct file *file)
@@ -438,11 +438,11 @@ static int cim_obq_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations cim_obq_fops = {
-	.owner   = THIS_MODULE,
-	.open    = cim_obq_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release_private
+	.owner     = THIS_MODULE,
+	.open      = cim_obq_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release_private
 };
 
 struct field_desc {
@@ -660,16 +660,16 @@ static int tp_la_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t tp_la_write(struct file *file, const char __user *buf,
-			   size_t count, loff_t *pos)
+static ssize_t tp_la_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	int err;
 	char s[32];
 	unsigned long val;
+	size_t count = iov_iter_count(from);
 	size_t size = min(sizeof(s) - 1, count);
-	struct adapter *adap = file_inode(file)->i_private;
+	struct adapter *adap = file_inode(iocb->ki_filp)->i_private;
 
-	if (copy_from_user(s, buf, size))
+	if (!copy_from_iter_full(s, size, from))
 		return -EFAULT;
 	s[size] = '\0';
 	err = kstrtoul(s, 0, &val);
@@ -684,12 +684,12 @@ static ssize_t tp_la_write(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations tp_la_fops = {
-	.owner   = THIS_MODULE,
-	.open    = tp_la_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release_private,
-	.write   = tp_la_write
+	.owner      = THIS_MODULE,
+	.open       = tp_la_open,
+	.read_iter  = seq_read_iter,
+	.llseek     = seq_lseek,
+	.release    = seq_release_private,
+	.write_iter = tp_la_write_iter
 };
 
 static int ulprx_la_show(struct seq_file *seq, void *v, int idx)
@@ -720,11 +720,11 @@ static int ulprx_la_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations ulprx_la_fops = {
-	.owner   = THIS_MODULE,
-	.open    = ulprx_la_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release_private
+	.owner     = THIS_MODULE,
+	.open      = ulprx_la_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release_private
 };
 
 /* Show the PM memory stats.  These stats include:
@@ -799,23 +799,22 @@ static int pm_stats_open(struct inode *inode, struct file *file)
 	return single_open(file, pm_stats_show, inode->i_private);
 }
 
-static ssize_t pm_stats_clear(struct file *file, const char __user *buf,
-			      size_t count, loff_t *pos)
+static ssize_t pm_stats_clear(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct adapter *adap = file_inode(file)->i_private;
+	struct adapter *adap = file_inode(iocb->ki_filp)->i_private;
 
 	t4_write_reg(adap, PM_RX_STAT_CONFIG_A, 0);
 	t4_write_reg(adap, PM_TX_STAT_CONFIG_A, 0);
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations pm_stats_debugfs_fops = {
-	.owner   = THIS_MODULE,
-	.open    = pm_stats_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-	.write   = pm_stats_clear
+	.owner      = THIS_MODULE,
+	.open       = pm_stats_open,
+	.read_iter  = seq_read_iter,
+	.llseek     = seq_lseek,
+	.release    = single_release,
+	.write_iter = pm_stats_clear
 };
 
 static int tx_rate_show(struct seq_file *seq, void *v)
@@ -1134,11 +1133,11 @@ static int devlog_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations devlog_fops = {
-	.owner   = THIS_MODULE,
-	.open    = devlog_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release_private
+	.owner     = THIS_MODULE,
+	.open      = devlog_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release_private
 };
 
 /* Show Firmware Mailbox Command/Reply Log
@@ -1232,11 +1231,11 @@ static int mboxlog_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations mboxlog_fops = {
-	.owner   = THIS_MODULE,
-	.open    = mboxlog_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
+	.owner     = THIS_MODULE,
+	.open      = mboxlog_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release,
 };
 
 static int mbox_show(struct seq_file *seq, void *v)
@@ -1275,8 +1274,7 @@ static int mbox_open(struct inode *inode, struct file *file)
 	return single_open(file, mbox_show, inode->i_private);
 }
 
-static ssize_t mbox_write(struct file *file, const char __user *buf,
-			  size_t count, loff_t *pos)
+static ssize_t mbox_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	int i;
 	char c = '\n', s[256];
@@ -1286,10 +1284,11 @@ static ssize_t mbox_write(struct file *file, const char __user *buf,
 	struct adapter *adap;
 	void __iomem *addr;
 	void __iomem *ctrl;
+	size_t count = iov_iter_count(from);
 
 	if (count > sizeof(s) - 1 || !count)
 		return -EINVAL;
-	if (copy_from_user(s, buf, count))
+	if (!copy_from_iter_full(s, count, from))
 		return -EFAULT;
 	s[count] = '\0';
 
@@ -1298,7 +1297,7 @@ static ssize_t mbox_write(struct file *file, const char __user *buf,
 		   &data[7], &c) < 8 || c != '\n')
 		return -EINVAL;
 
-	ino = file_inode(file);
+	ino = file_inode(iocb->ki_filp);
 	mbox = (uintptr_t)ino->i_private & 7;
 	adap = ino->i_private - mbox;
 	addr = adap->regs + PF_REG(mbox, CIM_PF_MAILBOX_DATA_A);
@@ -1315,12 +1314,12 @@ static ssize_t mbox_write(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations mbox_debugfs_fops = {
-	.owner   = THIS_MODULE,
-	.open    = mbox_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-	.write   = mbox_write
+	.owner      = THIS_MODULE,
+	.open       = mbox_open,
+	.read_iter  = seq_read_iter,
+	.llseek     = seq_lseek,
+	.release    = single_release,
+	.write_iter = mbox_write_iter
 };
 
 static int mps_trc_show(struct seq_file *seq, void *v)
@@ -1408,8 +1407,7 @@ static unsigned int xdigit2int(unsigned char c)
  * must be anchored at 0.  An omitted mask is taken as a mask of 1s, an omitted
  * anchor is taken as 0.
  */
-static ssize_t mps_trc_write(struct file *file, const char __user *buf,
-			     size_t count, loff_t *pos)
+static ssize_t mps_trc_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	int i, enable, ret;
 	u32 *data, *mask;
@@ -1419,8 +1417,9 @@ static ssize_t mps_trc_write(struct file *file, const char __user *buf,
 	char *s, *p, *word, *end;
 	struct adapter *adap;
 	u32 j;
+	size_t count = iov_iter_count(from);
 
-	ino = file_inode(file);
+	ino = file_inode(iocb->ki_filp);
 	trcidx = (uintptr_t)ino->i_private & 3;
 	adap = ino->i_private - trcidx;
 
@@ -1432,7 +1431,7 @@ static ssize_t mps_trc_write(struct file *file, const char __user *buf,
 	p = s = kzalloc(count + 1, GFP_USER);
 	if (!s)
 		return -ENOMEM;
-	if (copy_from_user(s, buf, count)) {
+	if (!copy_from_iter_full(s, count, from)) {
 		count = -EFAULT;
 		goto out;
 	}
@@ -1608,20 +1607,20 @@ inval:				count = -EINVAL;
 }
 
 static const struct file_operations mps_trc_debugfs_fops = {
-	.owner   = THIS_MODULE,
-	.open    = mps_trc_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-	.write   = mps_trc_write
+	.owner      = THIS_MODULE,
+	.open       = mps_trc_open,
+	.read_iter  = seq_read_iter,
+	.llseek     = seq_lseek,
+	.release    = single_release,
+	.write_iter = mps_trc_write_iter
 };
 
-static ssize_t flash_read(struct file *file, char __user *buf, size_t count,
-			  loff_t *ppos)
+static ssize_t flash_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	loff_t pos = *ppos;
-	loff_t avail = file_inode(file)->i_size;
-	struct adapter *adap = file->private_data;
+	loff_t pos = iocb->ki_pos;
+	loff_t avail = file_inode(iocb->ki_filp)->i_size;
+	struct adapter *adap = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 
 	if (pos < 0)
 		return -EINVAL;
@@ -1643,23 +1642,22 @@ static ssize_t flash_read(struct file *file, char __user *buf, size_t count,
 			return ret;
 
 		len -= ofst;
-		if (copy_to_user(buf, data + ofst, len))
+		if (!copy_to_iter_full(data + ofst, len, to))
 			return -EFAULT;
 
-		buf += len;
 		pos += len;
 		count -= len;
 	}
-	count = pos - *ppos;
-	*ppos = pos;
+	count = pos - iocb->ki_pos;
+	iocb->ki_pos = pos;
 	return count;
 }
 
 static const struct file_operations flash_debugfs_fops = {
-	.owner   = THIS_MODULE,
-	.open    = mem_open,
-	.read    = flash_read,
-	.llseek  = default_llseek,
+	.owner     = THIS_MODULE,
+	.open      = mem_open,
+	.read_iter = flash_read_iter,
+	.llseek    = default_llseek,
 };
 
 static inline void tcamxy2valmask(u64 x, u64 y, u8 *addr, u64 *mask)
@@ -1928,11 +1926,11 @@ static int mps_tcam_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations mps_tcam_debugfs_fops = {
-	.owner   = THIS_MODULE,
-	.open    = mps_tcam_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
+	.owner     = THIS_MODULE,
+	.open      = mps_tcam_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release,
 };
 
 /* Display various sensor information.
@@ -2005,11 +2003,11 @@ static int rss_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations rss_debugfs_fops = {
-	.owner   = THIS_MODULE,
-	.open    = rss_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release_private
+	.owner     = THIS_MODULE,
+	.open      = rss_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release_private
 };
 
 /* RSS Configuration.
@@ -2194,17 +2192,17 @@ static int rss_key_open(struct inode *inode, struct file *file)
 	return single_open(file, rss_key_show, inode->i_private);
 }
 
-static ssize_t rss_key_write(struct file *file, const char __user *buf,
-			     size_t count, loff_t *pos)
+static ssize_t rss_key_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	int i, j;
 	u32 key[10];
 	char s[100], *p;
-	struct adapter *adap = file_inode(file)->i_private;
+	struct adapter *adap = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 
 	if (count > sizeof(s) - 1)
 		return -EINVAL;
-	if (copy_from_user(s, buf, count))
+	if (!copy_from_iter_full(s, count, from))
 		return -EFAULT;
 	for (i = count; i > 0 && isspace(s[i - 1]); i--)
 		;
@@ -2224,12 +2222,12 @@ static ssize_t rss_key_write(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations rss_key_debugfs_fops = {
-	.owner   = THIS_MODULE,
-	.open    = rss_key_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-	.write   = rss_key_write
+	.owner      = THIS_MODULE,
+	.open       = rss_key_open,
+	.read_iter  = seq_read_iter,
+	.llseek     = seq_lseek,
+	.release    = single_release,
+	.write_iter = rss_key_write_iter
 };
 
 /* PF RSS Configuration.
@@ -2308,11 +2306,11 @@ static int rss_pf_config_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations rss_pf_config_debugfs_fops = {
-	.owner   = THIS_MODULE,
-	.open    = rss_pf_config_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release_private
+	.owner     = THIS_MODULE,
+	.open      = rss_pf_config_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release_private
 };
 
 /* VF RSS Configuration.
@@ -2371,11 +2369,11 @@ static int rss_vf_config_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations rss_vf_config_debugfs_fops = {
-	.owner   = THIS_MODULE,
-	.open    = rss_vf_config_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release_private
+	.owner     = THIS_MODULE,
+	.open      = rss_vf_config_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release_private
 };
 
 #ifdef CONFIG_CHELSIO_T4_DCB
@@ -2559,11 +2557,11 @@ static int dcb_info_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations dcb_info_debugfs_fops = {
-	.owner   = THIS_MODULE,
-	.open    = dcb_info_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
+	.owner     = THIS_MODULE,
+	.open      = dcb_info_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release,
 };
 #endif /* CONFIG_CHELSIO_T4_DCB */
 
@@ -3243,11 +3241,11 @@ static int sge_qinfo_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations sge_qinfo_debugfs_fops = {
-	.owner   = THIS_MODULE,
-	.open    = sge_qinfo_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
+	.owner     = THIS_MODULE,
+	.open      = sge_qinfo_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release,
 };
 
 int mem_open(struct inode *inode, struct file *file)
@@ -3265,15 +3263,15 @@ int mem_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t mem_read(struct file *file, char __user *buf, size_t count,
-			loff_t *ppos)
+static ssize_t mem_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	loff_t pos = *ppos;
-	loff_t avail = file_inode(file)->i_size;
-	unsigned int mem = (uintptr_t)file->private_data & 0x7;
-	struct adapter *adap = file->private_data - mem;
+	loff_t pos = iocb->ki_pos;
+	loff_t avail = file_inode(iocb->ki_filp)->i_size;
+	unsigned int mem = (uintptr_t)iocb->ki_filp->private_data & 0x7;
+	struct adapter *adap = iocb->ki_filp->private_data - mem;
 	__be32 *data;
 	int ret;
+	size_t count = iov_iter_count(to);
 
 	if (pos < 0)
 		return -EINVAL;
@@ -3293,20 +3291,20 @@ static ssize_t mem_read(struct file *file, char __user *buf, size_t count,
 		kvfree(data);
 		return ret;
 	}
-	ret = copy_to_user(buf, data, count);
+	ret = !copy_to_iter_full(data, count, to);
 
 	kvfree(data);
 	if (ret)
 		return -EFAULT;
 
-	*ppos = pos + count;
+	iocb->ki_pos = pos + count;
 	return count;
 }
 static const struct file_operations mem_debugfs_fops = {
-	.owner   = THIS_MODULE,
-	.open    = simple_open,
-	.read    = mem_read,
-	.llseek  = default_llseek,
+	.owner     = THIS_MODULE,
+	.open      = simple_open,
+	.read_iter = mem_read_iter,
+	.llseek    = default_llseek,
 };
 
 static int tid_info_show(struct seq_file *seq, void *v)
@@ -3401,11 +3399,10 @@ static void add_debugfs_mem(struct adapter *adap, const char *name,
 				 size_mb << 20);
 }
 
-static ssize_t blocked_fl_read(struct file *filp, char __user *ubuf,
-			       size_t count, loff_t *ppos)
+static ssize_t blocked_fl_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	int len;
-	const struct adapter *adap = filp->private_data;
+	const struct adapter *adap = iocb->ki_filp->private_data;
 	char *buf;
 	ssize_t size = (adap->sge.egr_sz + 3) / 4 +
 			adap->sge.egr_sz / 32 + 2; /* includes ,/\n/\0 */
@@ -3417,23 +3414,31 @@ static ssize_t blocked_fl_read(struct file *filp, char __user *ubuf,
 	len = snprintf(buf, size - 1, "%*pb\n",
 		       adap->sge.egr_sz, adap->sge.blocked_fl);
 	len += sprintf(buf + len, "\n");
-	size = simple_read_from_buffer(ubuf, count, ppos, buf, len);
+	size = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 	return size;
 }
 
-static ssize_t blocked_fl_write(struct file *filp, const char __user *ubuf,
-				size_t count, loff_t *ppos)
+static ssize_t blocked_fl_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	int err;
 	unsigned long *t;
-	struct adapter *adap = filp->private_data;
+	struct adapter *adap = iocb->ki_filp->private_data;
+	void *kern_buf;
+	size_t count = iov_iter_count(from);
 
 	t = bitmap_zalloc(adap->sge.egr_sz, GFP_KERNEL);
 	if (!t)
 		return -ENOMEM;
 
-	err = bitmap_parse_user(ubuf, count, t, adap->sge.egr_sz);
+	kern_buf = kzalloc(count + 1, GFP_KERNEL);
+	if (!kern_buf)
+		return -ENOMEM;
+
+	if (!copy_from_iter_full(kern_buf, count, from))
+		return -EFAULT;
+
+	err = bitmap_parse(kern_buf, UINT_MAX, t, adap->sge.egr_sz);
 	if (err) {
 		bitmap_free(t);
 		return err;
@@ -3445,11 +3450,11 @@ static ssize_t blocked_fl_write(struct file *filp, const char __user *ubuf,
 }
 
 static const struct file_operations blocked_fl_fops = {
-	.owner   = THIS_MODULE,
-	.open    = simple_open,
-	.read    = blocked_fl_read,
-	.write   = blocked_fl_write,
-	.llseek  = generic_file_llseek,
+	.owner      = THIS_MODULE,
+	.open       = simple_open,
+	.read_iter  = blocked_fl_read_iter,
+	.write_iter = blocked_fl_write_iter,
+	.llseek     = generic_file_llseek,
 };
 
 static void mem_region_show(struct seq_file *seq, const char *name,
diff --git a/drivers/net/ethernet/chelsio/cxgb4/l2t.c b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
index 1e5f5b1a22a6..c4564a14b6ee 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/l2t.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
@@ -756,7 +756,7 @@ static int l2t_seq_open(struct inode *inode, struct file *file)
 const struct file_operations t4_l2t_fops = {
 	.owner = THIS_MODULE,
 	.open = l2t_seq_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
-- 
2.43.0


