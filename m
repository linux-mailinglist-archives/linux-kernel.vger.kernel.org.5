Return-Path: <linux-kernel+bounces-141099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6678A1A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D31B1C23235
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BBF1E3137;
	Thu, 11 Apr 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MIpgOX+3"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490FF1E2469
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850034; cv=none; b=RvvYSHCKyYeHuQuhT/CLWF9iN+7FtKmwPZZJYHuhzjzOvAFjt6F12SMol6qkKG34JQOL74TzSMnbTyX4YN1O1mUukJdc2nFbJ+VjsgH5aNeK9roTdUpeI0TdM15HBdbDenwI2Fm9zgUOLDIaAH5cDxxfb3IofYx+MEf/8r5usjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850034; c=relaxed/simple;
	bh=I8dXB4IwiX0IwvNcDtJ4Kp6Q4HUSfbarUFatjYcceNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCV4asYAtToncOb2y+m4zk2VP10fdcQ+KQAScCqV68pCsgU/pxO0+kC5ezlcMIdmJ9AkW7Rf5IwwoqlAW+p+/cMRAXUQSGQ7e9ao4TlHgG0HrW1G05VaEuhSLtfTta1VRbm+oRv7mbwds1tXQjewvdB+IiXLLrZoZOXRPzyHqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MIpgOX+3; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a34b68277so118835ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850032; x=1713454832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNYlDh++hWQKeJgeJ1TbZWHR3S/TzYrOtOOXTxHryuI=;
        b=MIpgOX+3+tnRLptRgnPm4wwpKYhBBGEZQC0Fw7JTHSUsCyRmH2TOobGeXNz+q+pYPC
         XdL8eXgFT6eo28qL6M1rZ7jMuCcA4b6a0AIDWm2KB3dZktG0Shb80hke5E7jZWD6CYTa
         HgMz5BAHvas3tyfVJEPhXu0qvoW7Y4wsoTLTVhBBALfctCWIIDHEzUzZQCLv0OUrMB+X
         jyZkizS6K2qq3TMQswGzYBRTF6LHwcAAUXm80EQslf5bbkHUULKtNrSCh3SI3WkmB7Oq
         GhbPCX03tFasZja6t6qMVeF0Gb1zUFhjxPh9HSAthd5ZMujkokt70M3ft6sKQSiqNi00
         Gq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850032; x=1713454832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNYlDh++hWQKeJgeJ1TbZWHR3S/TzYrOtOOXTxHryuI=;
        b=f3YHEVy8qn5cLknShJk7ujszp5FZaj+KuEuBo6sfHMDfrRNJajzmRZDRLRwzk4EJ82
         bnX3QiYoWnmJpzQ+s5f4A+6rB/cX4UYfp0ZNIPYFhwddzRBgKzD19pxZrJkOY8GROWdl
         OEb/Vc8xceduyfY+zIcdJUjXwzI+Xh3o/fFQGHDNp2OEZK+brE+jez6KlVRdT5Jj3shA
         BcnBv59KaIQd1CR7nb57sOwXoV+2PleKJr6UU04oEPnEhgbZQPZBy9Fo6RKOWxLTrSum
         Vw7y3MzsPzLfZm/hSGuPZh/U3lAZHK2GDRdx0OO3QD6/fHiGbdZXsj75cF/qnzRDcsPF
         J80A==
X-Gm-Message-State: AOJu0YyFZOZuWg6rdR2/5NM/Au0ScbidRmd2oDj4bOZA4l9V6ZgpBorr
	KFlY/Cy5NrnDvuR/JMtO7A3FXVl6Ons/2d+z6N4q50ND2rjzrFNqiOR+M35MrUBWco7xcV6rSVS
	D
X-Google-Smtp-Source: AGHT+IHUAKRjI2tZze6ZIASuYQzzXyv3oo0j6+1bpYH1XDW1sQnBFM7c9lZDEJ9xnbLbcWXOwkvqFA==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr198535iob.0.1712850032141;
        Thu, 11 Apr 2024 08:40:32 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 321/437] drivers/net/brocade-bnad: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:41 -0600
Message-ID: <20240411153126.16201-322-axboe@kernel.dk>
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
 .../net/ethernet/brocade/bna/bnad_debugfs.c   | 47 +++++++++----------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
index 97291bfbeea5..88451f739f1f 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -229,16 +229,15 @@ bnad_debugfs_lseek(struct file *file, loff_t offset, int orig)
 }
 
 static ssize_t
-bnad_debugfs_read(struct file *file, char __user *buf,
-		  size_t nbytes, loff_t *pos)
+bnad_debugfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct bnad_debug_info *debug = file->private_data;
+	struct bnad_debug_info *debug = iocb->ki_filp->private_data;
 
 	if (!debug || !debug->debug_buffer)
 		return 0;
 
-	return simple_read_from_buffer(buf, nbytes, pos,
-				debug->debug_buffer, debug->buffer_len);
+	return simple_copy_to_iter(debug->debug_buffer, &iocb->ki_pos,
+				   debug->buffer_len, to);
 }
 
 #define BFA_REG_CT_ADDRSZ	(0x40000)
@@ -275,18 +274,18 @@ bna_reg_offset_check(struct bfa_ioc *ioc, u32 offset, u32 len)
 }
 
 static ssize_t
-bnad_debugfs_read_regrd(struct file *file, char __user *buf,
-			size_t nbytes, loff_t *pos)
+bnad_debugfs_read_regrd_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct bnad_debug_info *regrd_debug = file->private_data;
+	struct bnad_debug_info *regrd_debug = iocb->ki_filp->private_data;
 	struct bnad *bnad = (struct bnad *)regrd_debug->i_private;
 	ssize_t rc;
+	loff_t *pos = &iocb->ki_pos;
+	size_t nbytes = iov_iter_count(to);
 
 	if (!bnad->regdata)
 		return 0;
 
-	rc = simple_read_from_buffer(buf, nbytes, pos,
-			bnad->regdata, bnad->reglen);
+	rc = simple_copy_to_iter(bnad->regdata, pos, bnad->reglen, to);
 
 	if ((*pos + nbytes) >= bnad->reglen) {
 		kfree(bnad->regdata);
@@ -298,10 +297,9 @@ bnad_debugfs_read_regrd(struct file *file, char __user *buf,
 }
 
 static ssize_t
-bnad_debugfs_write_regrd(struct file *file, const char __user *buf,
-		size_t nbytes, loff_t *ppos)
+bnad_debugfs_write_regrd_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct bnad_debug_info *regrd_debug = file->private_data;
+	struct bnad_debug_info *regrd_debug = iocb->ki_filp->private_data;
 	struct bnad *bnad = (struct bnad *)regrd_debug->i_private;
 	struct bfa_ioc *ioc = &bnad->bna.ioceth.ioc;
 	int rc, i;
@@ -310,9 +308,10 @@ bnad_debugfs_write_regrd(struct file *file, const char __user *buf,
 	void __iomem *rb, *reg_addr;
 	unsigned long flags;
 	void *kern_buf;
+	size_t nbytes = iov_iter_count(from);
 
 	/* Copy the user space buf */
-	kern_buf = memdup_user_nul(buf, nbytes);
+	kern_buf = iterdup_nul(from, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
@@ -359,10 +358,9 @@ bnad_debugfs_write_regrd(struct file *file, const char __user *buf,
 }
 
 static ssize_t
-bnad_debugfs_write_regwr(struct file *file, const char __user *buf,
-		size_t nbytes, loff_t *ppos)
+bnad_debugfs_write_regwr_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct bnad_debug_info *debug = file->private_data;
+	struct bnad_debug_info *debug = iocb->ki_filp->private_data;
 	struct bnad *bnad = (struct bnad *)debug->i_private;
 	struct bfa_ioc *ioc = &bnad->bna.ioceth.ioc;
 	int rc;
@@ -370,9 +368,10 @@ bnad_debugfs_write_regwr(struct file *file, const char __user *buf,
 	void __iomem *reg_addr;
 	unsigned long flags;
 	void *kern_buf;
+	size_t nbytes = iov_iter_count(from);
 
 	/* Copy the user space buf */
-	kern_buf = memdup_user_nul(buf, nbytes);
+	kern_buf = iterdup_nul(from, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
@@ -434,7 +433,7 @@ static const struct file_operations bnad_debugfs_op_fwtrc = {
 	.owner		=	THIS_MODULE,
 	.open		=	bnad_debugfs_open_fwtrc,
 	.llseek		=	bnad_debugfs_lseek,
-	.read		=	bnad_debugfs_read,
+	.read_iter	=	bnad_debugfs_read_iter,
 	.release	=	bnad_debugfs_buffer_release,
 };
 
@@ -442,7 +441,7 @@ static const struct file_operations bnad_debugfs_op_fwsave = {
 	.owner		=	THIS_MODULE,
 	.open		=	bnad_debugfs_open_fwsave,
 	.llseek		=	bnad_debugfs_lseek,
-	.read		=	bnad_debugfs_read,
+	.read_iter	=	bnad_debugfs_read_iter,
 	.release	=	bnad_debugfs_buffer_release,
 };
 
@@ -450,8 +449,8 @@ static const struct file_operations bnad_debugfs_op_regrd = {
 	.owner		=       THIS_MODULE,
 	.open		=	bnad_debugfs_open_reg,
 	.llseek		=	bnad_debugfs_lseek,
-	.read		=	bnad_debugfs_read_regrd,
-	.write		=	bnad_debugfs_write_regrd,
+	.read_iter	=	bnad_debugfs_read_regrd_iter,
+	.write_iter	=	bnad_debugfs_write_regrd_iter,
 	.release	=	bnad_debugfs_release,
 };
 
@@ -459,7 +458,7 @@ static const struct file_operations bnad_debugfs_op_regwr = {
 	.owner		=	THIS_MODULE,
 	.open		=	bnad_debugfs_open_reg,
 	.llseek		=	bnad_debugfs_lseek,
-	.write		=	bnad_debugfs_write_regwr,
+	.write_iter	=	bnad_debugfs_write_regwr_iter,
 	.release	=	bnad_debugfs_release,
 };
 
@@ -467,7 +466,7 @@ static const struct file_operations bnad_debugfs_op_drvinfo = {
 	.owner		=	THIS_MODULE,
 	.open		=	bnad_debugfs_open_drvinfo,
 	.llseek		=	bnad_debugfs_lseek,
-	.read		=	bnad_debugfs_read,
+	.read_iter	=	bnad_debugfs_read_iter,
 	.release	=	bnad_debugfs_buffer_release,
 };
 
-- 
2.43.0


