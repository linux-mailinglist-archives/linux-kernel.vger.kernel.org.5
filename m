Return-Path: <linux-kernel+bounces-141106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3C28A1A83
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29191F209B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96AD1E49AF;
	Thu, 11 Apr 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WxQWaIEe"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAE1E4995
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850047; cv=none; b=O/hLbJecwW18gOQU6Kr5VvzDWxCc1q/jhww+f/dcUDlQsqutlkEp0Z6L58a0tpl8ej8emYuVrwm7cPSNR0Ve0rQrtqTcCDSGhaFNsGfNQXIa1t/1L+UyvhDbdHB3BePXRV4ihwqPjYwTJ+qhwOCgMhNogU09ylD/lrU/A4TF2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850047; c=relaxed/simple;
	bh=ZQsCXQIo1u77C+Y636NSLzJQXLfnlx2gRIv95MTZKJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYmuEoaF7QQQn+sHH/woP8/0+DyqI8rsNkE9mUbpjNetq2zyeQkW0YfjwRkuKGeCv9vF1xaxo5X1QGPFH8I9gcv3O92hTUe0tagydr5g92yT/17jlDxUus72hDySvvnZiAuYjCOYrCLXgLyAVL3+yUJXcE/MQRt87FlnwH8Hlz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WxQWaIEe; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36a224d7414so193605ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850044; x=1713454844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8E038ft6BAVgNypkOETbM+2jlodebro2Q9vT1YOFtic=;
        b=WxQWaIEeKw0hx7fiI3hz2pWQnSvAlT8QJ5Ifyl7iqqOqVEWkN8KCW0M2Bb2cpwD84B
         s7Z1vVFIlqU/JuAYT/1Xl0qUx9uju4sBGn23aaPZnYBmIx453C60l6k65K814BuUDNdo
         SKyawTwvCaa8WGnKUPsWarmsls4ew8erKtW+lOey9uXAfHmMUaa41W1is3nRBI+rrkRc
         QnztRQEgCYi6vRh57AzbvfXL+kP9GoXrnnELUiXXsR70pdpW2fATQPvX7c66WEOow+PS
         mnMEQv2IXGheWiDcATxF+GUwevmKd5TwNZhmez57dYEsRf+O4W8pRrrAE8eOBeAuJPV2
         gV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850044; x=1713454844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8E038ft6BAVgNypkOETbM+2jlodebro2Q9vT1YOFtic=;
        b=qseU7gDMib7maKdWij4/7mzav6B3EUUU3m+IaWRKgFrNmVWtN9b/XuGLxAKWyY4Dfk
         FYcR8ZyaffRxoVWvHPZIf2rruRqeDKhoPqYwwzyhx4MrZ4VoF3mdCebSWdJZ1szNXxly
         dm2Brvbi2oJfb/4ac8ZUCpMl5syBbBXQBcqpLZ6rYMp4iftXNyjGm31M2sP5JwC1WncD
         Z9Stl0KaKbfKiRFrrspwSFmXDYwWIaSNglEf9VGz7a14ugBekBpdyRrSRsZUUhxPgW2X
         ox+zjtV23hIAG5ZVko4tfgKJIvD5pwfTZL/01BTOejp07H+0Gab7RIOlRPY6vMfn+qi2
         ZqAg==
X-Gm-Message-State: AOJu0YzJi6cKmO42d90X2QKTGt3XL5zUn2j6WTKCuivGyxrbdXD74RpM
	winyocQrcBed32meeKtf4SMHAq3BRo/ppFnLlBoZ6bSCDDLv8VWVdzAz6IeWDGaq7WvxFz0Wo/G
	U
X-Google-Smtp-Source: AGHT+IFXwsra0bGxPW3Je+zPe/7OBMSYiRabPsITdpsQ5dFXUGXvJIR9StmjAnp0RH7JgZHHVsZqaw==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr159843ioc.2.1712850044318;
        Thu, 11 Apr 2024 08:40:44 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 328/437] drivers/net/ethernet/marvell/octeontx2: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:48 -0600
Message-ID: <20240411153126.16201-329-axboe@kernel.dk>
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
 .../marvell/octeontx2/af/rvu_debugfs.c        | 159 ++++++++----------
 1 file changed, 73 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 2500f5ba4f5a..be3b071743f5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -209,8 +209,8 @@ static int rvu_dbg_open_##name(struct inode *inode, struct file *file) \
 static const struct file_operations rvu_dbg_##name##_fops = { \
 	.owner		= THIS_MODULE, \
 	.open		= rvu_dbg_open_##name, \
-	.read		= seq_read, \
-	.write		= rvu_dbg_##write_op, \
+	.read_iter	= seq_read_iter, \
+	.write_iter	= rvu_dbg_##write_op, \
 	.llseek		= seq_lseek, \
 	.release	= single_release, \
 }
@@ -219,8 +219,8 @@ static const struct file_operations rvu_dbg_##name##_fops = { \
 static const struct file_operations rvu_dbg_##name##_fops = { \
 	.owner = THIS_MODULE, \
 	.open = simple_open, \
-	.read = rvu_dbg_##read_op, \
-	.write = rvu_dbg_##write_op \
+	.read_iter = rvu_dbg_##read_op, \
+	.write_iter = rvu_dbg_##write_op \
 }
 
 static void print_nix_qsize(struct seq_file *filp, struct rvu_pfvf *pfvf);
@@ -572,11 +572,10 @@ static void rvu_dbg_mcs_init(struct rvu *rvu)
 
 #define LMT_MAPTBL_ENTRY_SIZE 16
 /* Dump LMTST map table */
-static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
-					       char __user *buffer,
-					       size_t count, loff_t *ppos)
+static ssize_t rvu_dbg_lmtst_map_table_display(struct kiocb *iocb,
+					       struct iov_iter *to)
 {
-	struct rvu *rvu = filp->private_data;
+	struct rvu *rvu = iocb->ki_filp->private_data;
 	u64 lmt_addr, val, tbl_base;
 	int pf, vf, num_vfs, hw_vfs;
 	void __iomem *lmt_map_base;
@@ -585,9 +584,10 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
 	int index = 0;
 	char *buf;
 	int ret;
+	size_t count = iov_iter_count(to);
 
 	/* don't allow partial reads */
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	buf = kzalloc(buf_size, GFP_KERNEL);
@@ -649,15 +649,15 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
 	off +=	scnprintf(&buf[off], buf_size - 1 - off, "\n");
 
 	ret = min(off, count);
-	if (copy_to_user(buffer, buf, ret))
-		ret = -EFAULT;
+	if (!copy_to_iter_full(buf, ret, to))
+		return -EFAULT;
 	kfree(buf);
 
 	iounmap(lmt_map_base);
 	if (ret < 0)
 		return ret;
 
-	*ppos = ret;
+	iocb->ki_pos = ret;
 	return ret;
 }
 
@@ -731,22 +731,21 @@ static int get_max_column_width(struct rvu *rvu)
 }
 
 /* Dumps current provisioning status of all RVU block LFs */
-static ssize_t rvu_dbg_rsrc_attach_status(struct file *filp,
-					  char __user *buffer,
-					  size_t count, loff_t *ppos)
+static ssize_t rvu_dbg_rsrc_attach_status(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
 	int index, off = 0, flag = 0, len = 0, i = 0;
-	struct rvu *rvu = filp->private_data;
-	int bytes_not_copied = 0;
+	struct rvu *rvu = iocb->ki_filp->private_data;
 	struct rvu_block block;
 	int pf, vf, pcifunc;
 	int buf_size = 2048;
 	int lf_str_size;
 	char *lfs;
 	char *buf;
+	bool ret;
 
 	/* don't allow partial reads */
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	buf = kzalloc(buf_size, GFP_KERNEL);
@@ -771,12 +770,13 @@ static ssize_t rvu_dbg_rsrc_attach_status(struct file *filp,
 		}
 
 	off += scnprintf(&buf[off], buf_size - 1 - off, "\n");
-	bytes_not_copied = copy_to_user(buffer + (i * off), buf, off);
-	if (bytes_not_copied)
+	iov_iter_advance(to, i * off);
+	ret = !copy_to_iter_full(buf, off, to);
+	if (ret)
 		goto out;
 
 	i++;
-	*ppos += off;
+	iocb->ki_pos += off;
 	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
 		for (vf = 0; vf <= rvu->hw->total_vfs; vf++) {
 			off = 0;
@@ -813,14 +813,13 @@ static ssize_t rvu_dbg_rsrc_attach_status(struct file *filp,
 			if (flag) {
 				off +=	scnprintf(&buf[off],
 						  buf_size - 1 - off, "\n");
-				bytes_not_copied = copy_to_user(buffer +
-								(i * off),
-								buf, off);
-				if (bytes_not_copied)
+				iov_iter_advance(to, i * off);
+				ret = !copy_to_iter_full(buf, off, to);
+				if (ret)
 					goto out;
 
 				i++;
-				*ppos += off;
+				iocb->ki_pos += off;
 			}
 		}
 	}
@@ -828,10 +827,10 @@ static ssize_t rvu_dbg_rsrc_attach_status(struct file *filp,
 out:
 	kfree(lfs);
 	kfree(buf);
-	if (bytes_not_copied)
+	if (!ret)
 		return -EFAULT;
 
-	return *ppos;
+	return iocb->ki_pos;
 }
 
 RVU_DEBUG_FOPS(rsrc_status, rsrc_attach_status, NULL);
@@ -986,23 +985,26 @@ static int rvu_dbg_qsize_display(struct seq_file *filp, void *unsused,
 	return 0;
 }
 
-static ssize_t rvu_dbg_qsize_write(struct file *filp,
-				   const char __user *buffer, size_t count,
-				   loff_t *ppos, int blktype)
+static ssize_t rvu_dbg_qsize_write(struct kiocb *iocb, struct iov_iter *from,
+				   int blktype)
 {
 	char *blk_string = (blktype == BLKTYPE_NPA) ? "npa" : "nix";
-	struct seq_file *seqfile = filp->private_data;
+	struct seq_file *seqfile = iocb->ki_filp->private_data;
 	char *cmd_buf, *cmd_buf_tmp, *subtoken;
 	struct rvu *rvu = seqfile->private;
 	struct dentry *current_dir;
 	int blkaddr;
 	u16 pcifunc;
 	int ret, lf;
+	size_t count = iov_iter_count(from);
 
-	cmd_buf = memdup_user(buffer, count + 1);
-	if (IS_ERR(cmd_buf))
+	cmd_buf = kmalloc(count + 1, GFP_KERNEL);
+	if (!cmd_buf)
 		return -ENOMEM;
 
+	if (!copy_from_iter_full(cmd_buf, count, from))
+		return -EFAULT;
+
 	cmd_buf[count] = '\0';
 
 	cmd_buf_tmp = strchr(cmd_buf, '\n');
@@ -1025,7 +1027,7 @@ static ssize_t rvu_dbg_qsize_write(struct file *filp,
 	if (blktype == BLKTYPE_NPA) {
 		blkaddr = BLKADDR_NPA;
 	} else {
-		current_dir = filp->f_path.dentry->d_parent;
+		current_dir = iocb->ki_filp->f_path.dentry->d_parent;
 		blkaddr = (!strcmp(current_dir->d_name.name, "nix1") ?
 				   BLKADDR_NIX1 : BLKADDR_NIX0);
 	}
@@ -1044,12 +1046,10 @@ static ssize_t rvu_dbg_qsize_write(struct file *filp,
 	return ret ? ret : count;
 }
 
-static ssize_t rvu_dbg_npa_qsize_write(struct file *filp,
-				       const char __user *buffer,
-				       size_t count, loff_t *ppos)
+static ssize_t rvu_dbg_npa_qsize_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	return rvu_dbg_qsize_write(filp, buffer, count, ppos,
-					    BLKTYPE_NPA);
+	return rvu_dbg_qsize_write(iocb, from, BLKTYPE_NPA);
 }
 
 static int rvu_dbg_npa_qsize_display(struct seq_file *filp, void *unused)
@@ -1292,16 +1292,14 @@ static int write_npa_ctx(struct rvu *rvu, bool all,
 }
 
 static int parse_cmd_buffer_ctx(char *cmd_buf, size_t *count,
-				const char __user *buffer, int *npalf,
+				struct iov_iter *from, int *npalf,
 				int *id, bool *all)
 {
-	int bytes_not_copied;
 	char *cmd_buf_tmp;
 	char *subtoken;
 	int ret;
 
-	bytes_not_copied = copy_from_user(cmd_buf, buffer, *count);
-	if (bytes_not_copied)
+	if (!copy_from_iter_full(cmd_buf, *count, from))
 		return -EFAULT;
 
 	cmd_buf[*count] = '\0';
@@ -1329,24 +1327,25 @@ static int parse_cmd_buffer_ctx(char *cmd_buf, size_t *count,
 	return ret;
 }
 
-static ssize_t rvu_dbg_npa_ctx_write(struct file *filp,
-				     const char __user *buffer,
-				     size_t count, loff_t *ppos, int ctype)
+static ssize_t rvu_dbg_npa_ctx_write(struct kiocb *iocb,
+				     struct iov_iter *from,
+				     int ctype)
 {
 	char *cmd_buf, *ctype_string = (ctype == NPA_AQ_CTYPE_AURA) ?
 					"aura" : "pool";
-	struct seq_file *seqfp = filp->private_data;
+	struct seq_file *seqfp = iocb->ki_filp->private_data;
 	struct rvu *rvu = seqfp->private;
 	int npalf, id = 0, ret;
 	bool all = false;
+	size_t count = iov_iter_count(from);
 
-	if ((*ppos != 0) || !count)
+	if (iocb->ki_pos != 0 || !count)
 		return -EINVAL;
 
 	cmd_buf = kzalloc(count + 1, GFP_KERNEL);
 	if (!cmd_buf)
 		return count;
-	ret = parse_cmd_buffer_ctx(cmd_buf, &count, buffer,
+	ret = parse_cmd_buffer_ctx(cmd_buf, &count, from,
 				   &npalf, &id, &all);
 	if (ret < 0) {
 		dev_info(rvu->dev,
@@ -1361,12 +1360,10 @@ static ssize_t rvu_dbg_npa_ctx_write(struct file *filp,
 	return ret ? ret : count;
 }
 
-static ssize_t rvu_dbg_npa_aura_ctx_write(struct file *filp,
-					  const char __user *buffer,
-					  size_t count, loff_t *ppos)
+static ssize_t rvu_dbg_npa_aura_ctx_write(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	return rvu_dbg_npa_ctx_write(filp, buffer, count, ppos,
-				     NPA_AQ_CTYPE_AURA);
+	return rvu_dbg_npa_ctx_write(iocb, from, NPA_AQ_CTYPE_AURA);
 }
 
 static int rvu_dbg_npa_aura_ctx_display(struct seq_file *filp, void *unused)
@@ -1376,12 +1373,10 @@ static int rvu_dbg_npa_aura_ctx_display(struct seq_file *filp, void *unused)
 
 RVU_DEBUG_SEQ_FOPS(npa_aura_ctx, npa_aura_ctx_display, npa_aura_ctx_write);
 
-static ssize_t rvu_dbg_npa_pool_ctx_write(struct file *filp,
-					  const char __user *buffer,
-					  size_t count, loff_t *ppos)
+static ssize_t rvu_dbg_npa_pool_ctx_write(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	return rvu_dbg_npa_ctx_write(filp, buffer, count, ppos,
-				     NPA_AQ_CTYPE_POOL);
+	return rvu_dbg_npa_ctx_write(iocb, from, NPA_AQ_CTYPE_POOL);
 }
 
 static int rvu_dbg_npa_pool_ctx_display(struct seq_file *filp, void *unused)
@@ -2021,19 +2016,19 @@ static int write_nix_queue_ctx(struct rvu *rvu, bool all, int nixlf,
 	return 0;
 }
 
-static ssize_t rvu_dbg_nix_queue_ctx_write(struct file *filp,
-					   const char __user *buffer,
-					   size_t count, loff_t *ppos,
+static ssize_t rvu_dbg_nix_queue_ctx_write(struct kiocb *iocb,
+					   struct iov_iter *from,
 					   int ctype)
 {
-	struct seq_file *m = filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct nix_hw *nix_hw = m->private;
 	struct rvu *rvu = nix_hw->rvu;
 	char *cmd_buf, *ctype_string;
 	int nixlf, id = 0, ret;
 	bool all = false;
+	size_t count = iov_iter_count(from);
 
-	if ((*ppos != 0) || !count)
+	if (iocb->ki_pos != 0 || !count)
 		return -EINVAL;
 
 	switch (ctype) {
@@ -2055,7 +2050,7 @@ static ssize_t rvu_dbg_nix_queue_ctx_write(struct file *filp,
 	if (!cmd_buf)
 		return count;
 
-	ret = parse_cmd_buffer_ctx(cmd_buf, &count, buffer,
+	ret = parse_cmd_buffer_ctx(cmd_buf, &count, from,
 				   &nixlf, &id, &all);
 	if (ret < 0) {
 		dev_info(rvu->dev,
@@ -2071,12 +2066,10 @@ static ssize_t rvu_dbg_nix_queue_ctx_write(struct file *filp,
 	return ret ? ret : count;
 }
 
-static ssize_t rvu_dbg_nix_sq_ctx_write(struct file *filp,
-					const char __user *buffer,
-					size_t count, loff_t *ppos)
+static ssize_t rvu_dbg_nix_sq_ctx_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	return rvu_dbg_nix_queue_ctx_write(filp, buffer, count, ppos,
-					    NIX_AQ_CTYPE_SQ);
+	return rvu_dbg_nix_queue_ctx_write(iocb, from, NIX_AQ_CTYPE_SQ);
 }
 
 static int rvu_dbg_nix_sq_ctx_display(struct seq_file *filp, void *unused)
@@ -2086,12 +2079,10 @@ static int rvu_dbg_nix_sq_ctx_display(struct seq_file *filp, void *unused)
 
 RVU_DEBUG_SEQ_FOPS(nix_sq_ctx, nix_sq_ctx_display, nix_sq_ctx_write);
 
-static ssize_t rvu_dbg_nix_rq_ctx_write(struct file *filp,
-					const char __user *buffer,
-					size_t count, loff_t *ppos)
+static ssize_t rvu_dbg_nix_rq_ctx_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	return rvu_dbg_nix_queue_ctx_write(filp, buffer, count, ppos,
-					    NIX_AQ_CTYPE_RQ);
+	return rvu_dbg_nix_queue_ctx_write(iocb, from, NIX_AQ_CTYPE_RQ);
 }
 
 static int rvu_dbg_nix_rq_ctx_display(struct seq_file *filp, void  *unused)
@@ -2101,12 +2092,10 @@ static int rvu_dbg_nix_rq_ctx_display(struct seq_file *filp, void  *unused)
 
 RVU_DEBUG_SEQ_FOPS(nix_rq_ctx, nix_rq_ctx_display, nix_rq_ctx_write);
 
-static ssize_t rvu_dbg_nix_cq_ctx_write(struct file *filp,
-					const char __user *buffer,
-					size_t count, loff_t *ppos)
+static ssize_t rvu_dbg_nix_cq_ctx_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	return rvu_dbg_nix_queue_ctx_write(filp, buffer, count, ppos,
-					    NIX_AQ_CTYPE_CQ);
+	return rvu_dbg_nix_queue_ctx_write(iocb, from, NIX_AQ_CTYPE_CQ);
 }
 
 static int rvu_dbg_nix_cq_ctx_display(struct seq_file *filp, void *unused)
@@ -2153,12 +2142,10 @@ static void print_nix_qsize(struct seq_file *filp, struct rvu_pfvf *pfvf)
 				     "sq");
 }
 
-static ssize_t rvu_dbg_nix_qsize_write(struct file *filp,
-				       const char __user *buffer,
-				       size_t count, loff_t *ppos)
+static ssize_t rvu_dbg_nix_qsize_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	return rvu_dbg_qsize_write(filp, buffer, count, ppos,
-				   BLKTYPE_NIX);
+	return rvu_dbg_qsize_write(iocb, from, BLKTYPE_NIX);
 }
 
 static int rvu_dbg_nix_qsize_display(struct seq_file *filp, void *unused)
-- 
2.43.0


