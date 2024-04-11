Return-Path: <linux-kernel+bounces-140959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758338A19D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FC91F22658
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC3D1B832D;
	Thu, 11 Apr 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dDnCc6yI"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091F1B6805
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849822; cv=none; b=uLSVr73ih+Ov4QZBKGVlXy3X4+uVHIf800XGAxyTXwiqXlIrUEbk4ydwPoIxed7edtxnftn38q5ti8lTWMFt+T2O64iGlcvR6lfR21pvpqB9BUs6DuAVm1DGoFLzsPEdQ9ZCgRLKMLvScQHQLYFepBmDYBhBkYEZuU9EIn8T0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849822; c=relaxed/simple;
	bh=d6VpjgzfajIj1UcUZFcEqQw0jsECoDaer/iWlPGCZqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrIjt3xFgjeB7DmUI6fh4qjQwHuELW7ra+lcnnNTAKLNo3PL/Qaq3SW7u1fyHYOFHP1ijulYd9HvOX+WC8ynYyaKPy6WMUiLy6TVrY3ueoX3rLVzJ9GycdLU4FXMt9X/2dRAhjl2GVDA09ikJq4AMTG3rryaNsLcBtHQ2JCQ2DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dDnCc6yI; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16175039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849818; x=1713454618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaaiZmQRVLgjZ85lQORx1zhxx+qF5nkcdoRvFYzJZYo=;
        b=dDnCc6yIt+pAt3iHsk30ldlENfXtHUT3OZEtjP4ol6lLuh3WJ56wFk2Q5GGF0ZCkOf
         GfxtEAAhvIpymv6EGutVb1S3Sb6v+W/TT9Wcdy+g51RlGzjzFGAa1fM2UWDdHrNzUijn
         BjCKMA9JI2ZDNA6SJAlaHAsGg6UzezutCJhE2zYgujsO4NtLPpOyjbM/CZJzf0M2aktu
         GYYUuyRiKw2THGhdPQuBD84DVAm9AZGELGsEcnQOcaB0FeTLsCWY7owgJygDhchu9d8+
         aDcZqDenORmkSru/tBj1fIcnmjldO+17ub/e/DcYWoML9cBqFn2O4h9uyws18tKX/pRW
         GZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849818; x=1713454618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaaiZmQRVLgjZ85lQORx1zhxx+qF5nkcdoRvFYzJZYo=;
        b=TBbjDscb2csvhboPRs0xcUqFnkJBn6ZrFUQ9ozgw4Td5SCcQx2tHVliQdD7pqUK10q
         pnUNDvsvcte41hYXVLUZ0gGByUgiKje5tt9uSquTBcaB2vF2ThrxCwqlvfBcWeiEZDl+
         hXeUFW/9jqbHDm5TH3lctM1NyAdgX1J3Hcqs/WlgG0G95Z+UEqmT3VYkOtx9dGs2xaYn
         NpwezR3jylB0F4jW1SYVbXv/F/7Sj9STfJkKNKsYRxZ23SI64aK4s9LmdQv6f2peYPBN
         avA76lrPFjsicN4NKixRIwEiDnThmxxZRljjm07Ks/lbDUGFCgzTZvk+a6NZbC4qyyeP
         7xSQ==
X-Gm-Message-State: AOJu0YyZ0ubzhV4CAueQOcCKQKERxfbjAIHS8qfFTj3j/J340T8IEVvs
	lOAoqDNMYtYxcmBNk/J4Vlf+qtFp23B9oUfU4qybbwR2TDe9dGOJvTiFkvhFKbC6WXbRHgH27vz
	U
X-Google-Smtp-Source: AGHT+IHhcKO6ZHqR6gk//G+IVVL+I9XABi8txlOILR1cPBIOqHy1f6onAHF+XsEMjm66OuibsGCLYA==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr187090iov.2.1712849817223;
        Thu, 11 Apr 2024 08:36:57 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 189/437] scsi: lpfc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:29 -0600
Message-ID: <20240411153126.16201-190-axboe@kernel.dk>
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
 drivers/scsi/lpfc/lpfc_debugfs.c | 427 ++++++++++++++-----------------
 1 file changed, 187 insertions(+), 240 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index a2d2b02b3418..bc75753d6c4a 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -2146,11 +2146,11 @@ lpfc_debugfs_lockstat_open(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-lpfc_debugfs_lockstat_write(struct file *file, const char __user *buf,
-			    size_t nbytes, loff_t *ppos)
+lpfc_debugfs_lockstat_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
+	size_t nbytes = iov_iter_count(from);
 	struct lpfc_sli4_hdw_queue *qp;
 	char mybuf[64];
 	char *pbuf;
@@ -2161,7 +2161,7 @@ lpfc_debugfs_lockstat_write(struct file *file, const char __user *buf,
 
 	bsize = min(nbytes, (sizeof(mybuf) - 1));
 
-	if (copy_from_user(mybuf, buf, bsize))
+	if (!copy_from_iter_full(mybuf, bsize, from))
 		return -EFAULT;
 	pbuf = &mybuf[0];
 
@@ -2371,12 +2371,10 @@ lpfc_debugfs_dumpHostSlim_open(struct inode *inode, struct file *file)
 	return rc;
 }
 
-static ssize_t
-lpfc_debugfs_dif_err_read(struct file *file, char __user *buf,
-	size_t nbytes, loff_t *ppos)
+static ssize_t lpfc_debugfs_dif_err_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct dentry *dent = file->f_path.dentry;
-	struct lpfc_hba *phba = file->private_data;
+	struct dentry *dent = iocb->ki_filp->f_path.dentry;
+	struct lpfc_hba *phba = iocb->ki_filp->private_data;
 	char cbuf[32];
 	uint64_t tmp = 0;
 	int cnt = 0;
@@ -2410,22 +2408,22 @@ lpfc_debugfs_dif_err_read(struct file *file, char __user *buf,
 		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
 			 "0547 Unknown debugfs error injection entry\n");
 
-	return simple_read_from_buffer(buf, nbytes, ppos, &cbuf, cnt);
+	return simple_copy_to_iter(&cbuf, &iocb->ki_pos, cnt, to);
 }
 
 static ssize_t
-lpfc_debugfs_dif_err_write(struct file *file, const char __user *buf,
-	size_t nbytes, loff_t *ppos)
+lpfc_debugfs_dif_err_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct dentry *dent = file->f_path.dentry;
-	struct lpfc_hba *phba = file->private_data;
+	struct dentry *dent = iocb->ki_filp->f_path.dentry;
+	struct lpfc_hba *phba = iocb->ki_filp->private_data;
+	size_t nbytes = iov_iter_count(from);
 	char dstbuf[33];
 	uint64_t tmp = 0;
 	int size;
 
 	memset(dstbuf, 0, 33);
 	size = (nbytes < 32) ? nbytes : 32;
-	if (copy_from_user(dstbuf, buf, size))
+	if (!copy_from_iter_full(dstbuf, size, from))
 		return -EFAULT;
 
 	if (dent == phba->debug_InjErrLBA) {
@@ -2537,10 +2535,8 @@ lpfc_debugfs_lseek(struct file *file, loff_t off, int whence)
 
 /**
  * lpfc_debugfs_read - Read a debugfs file
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the data to.
- * @nbytes: The number of bytes to read.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @to: The buffer to copy the data to.
  *
  * Description:
  * This routine reads data from from the buffer indicated in the private_data
@@ -2552,13 +2548,12 @@ lpfc_debugfs_lseek(struct file *file, loff_t off, int whence)
  * than @nbytes if the end of the file was reached) or a negative error value.
  **/
 static ssize_t
-lpfc_debugfs_read(struct file *file, char __user *buf,
-		  size_t nbytes, loff_t *ppos)
+lpfc_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 
-	return simple_read_from_buffer(buf, nbytes, ppos, debug->buffer,
-				       debug->len);
+	return simple_copy_to_iter(debug->buffer, &iocb->ki_pos, debug->len,
+					to);
 }
 
 /**
@@ -2586,10 +2581,8 @@ lpfc_debugfs_release(struct inode *inode, struct file *file)
 
 /**
  * lpfc_debugfs_multixripools_write - Clear multi-XRI pools statistics
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the user data from.
- * @nbytes: The number of bytes to get.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @from: The buffer to copy the user data from.
  *
  * Description:
  * This routine clears multi-XRI pools statistics when buf contains "clear".
@@ -2600,10 +2593,10 @@ lpfc_debugfs_release(struct inode *inode, struct file *file)
  * space.
  **/
 static ssize_t
-lpfc_debugfs_multixripools_write(struct file *file, const char __user *buf,
-				 size_t nbytes, loff_t *ppos)
+lpfc_debugfs_multixripools_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
+	size_t nbytes = iov_iter_count(from);
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
 	char mybuf[64];
 	char *pbuf;
@@ -2617,7 +2610,7 @@ lpfc_debugfs_multixripools_write(struct file *file, const char __user *buf,
 
 	memset(mybuf, 0, sizeof(mybuf));
 
-	if (copy_from_user(mybuf, buf, nbytes))
+	if (!copy_from_iter_full(mybuf, nbytes, from))
 		return -EFAULT;
 	pbuf = &mybuf[0];
 
@@ -2680,12 +2673,12 @@ lpfc_debugfs_nvmestat_open(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-lpfc_debugfs_nvmestat_write(struct file *file, const char __user *buf,
-			    size_t nbytes, loff_t *ppos)
+lpfc_debugfs_nvmestat_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_vport *vport = (struct lpfc_vport *)debug->i_private;
 	struct lpfc_hba   *phba = vport->phba;
+	size_t nbytes = iov_iter_count(from);
 	struct lpfc_nvmet_tgtport *tgtp;
 	char mybuf[64];
 	char *pbuf;
@@ -2698,7 +2691,7 @@ lpfc_debugfs_nvmestat_write(struct file *file, const char __user *buf,
 
 	memset(mybuf, 0, sizeof(mybuf));
 
-	if (copy_from_user(mybuf, buf, nbytes))
+	if (!copy_from_iter_full(mybuf, nbytes, from))
 		return -EFAULT;
 	pbuf = &mybuf[0];
 
@@ -2768,17 +2761,17 @@ lpfc_debugfs_scsistat_open(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-lpfc_debugfs_scsistat_write(struct file *file, const char __user *buf,
-			    size_t nbytes, loff_t *ppos)
+lpfc_debugfs_scsistat_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_vport *vport = (struct lpfc_vport *)debug->i_private;
+	size_t nbytes = iov_iter_count(from);
 	struct lpfc_hba *phba = vport->phba;
 	char mybuf[6] = {0};
 	int i;
 
-	if (copy_from_user(mybuf, buf, (nbytes >= sizeof(mybuf)) ?
-				       (sizeof(mybuf) - 1) : nbytes))
+	if (!copy_from_iter_full(mybuf, (nbytes >= sizeof(mybuf)) ?
+				       (sizeof(mybuf) - 1) : nbytes, from))
 		return -EFAULT;
 
 	if ((strncmp(&mybuf[0], "reset", strlen("reset")) == 0) ||
@@ -2822,12 +2815,12 @@ lpfc_debugfs_ioktime_open(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-lpfc_debugfs_ioktime_write(struct file *file, const char __user *buf,
-			   size_t nbytes, loff_t *ppos)
+lpfc_debugfs_ioktime_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_vport *vport = (struct lpfc_vport *)debug->i_private;
 	struct lpfc_hba   *phba = vport->phba;
+	size_t nbytes = iov_iter_count(from);
 	char mybuf[64];
 	char *pbuf;
 
@@ -2836,7 +2829,7 @@ lpfc_debugfs_ioktime_write(struct file *file, const char __user *buf,
 
 	memset(mybuf, 0, sizeof(mybuf));
 
-	if (copy_from_user(mybuf, buf, nbytes))
+	if (!copy_from_iter_full(mybuf, nbytes, from))
 		return -EFAULT;
 	pbuf = &mybuf[0];
 
@@ -2949,11 +2942,11 @@ lpfc_debugfs_nvmeio_trc_open(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-lpfc_debugfs_nvmeio_trc_write(struct file *file, const char __user *buf,
-			      size_t nbytes, loff_t *ppos)
+lpfc_debugfs_nvmeio_trc_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
+	size_t nbytes = iov_iter_count(from);
 	int i;
 	unsigned long sz;
 	char mybuf[64];
@@ -2964,7 +2957,7 @@ lpfc_debugfs_nvmeio_trc_write(struct file *file, const char __user *buf,
 
 	memset(mybuf, 0, sizeof(mybuf));
 
-	if (copy_from_user(mybuf, buf, nbytes))
+	if (!copy_from_iter_full(mybuf, nbytes, from))
 		return -EFAULT;
 	pbuf = &mybuf[0];
 
@@ -3054,12 +3047,12 @@ lpfc_debugfs_hdwqstat_open(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-lpfc_debugfs_hdwqstat_write(struct file *file, const char __user *buf,
-			    size_t nbytes, loff_t *ppos)
+lpfc_debugfs_hdwqstat_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_vport *vport = (struct lpfc_vport *)debug->i_private;
 	struct lpfc_hba   *phba = vport->phba;
+	size_t nbytes = iov_iter_count(from);
 	struct lpfc_hdwq_stat *c_stat;
 	char mybuf[64];
 	char *pbuf;
@@ -3070,7 +3063,7 @@ lpfc_debugfs_hdwqstat_write(struct file *file, const char __user *buf,
 
 	memset(mybuf, 0, sizeof(mybuf));
 
-	if (copy_from_user(mybuf, buf, nbytes))
+	if (!copy_from_iter_full(mybuf, nbytes, from))
 		return -EFAULT;
 	pbuf = &mybuf[0];
 
@@ -3139,9 +3132,10 @@ lpfc_debugfs_hdwqstat_write(struct file *file, const char __user *buf,
  * This routine returns 0 when successful, it returns proper error code
  * back to the user space in error conditions.
  */
-static int lpfc_idiag_cmd_get(const char __user *buf, size_t nbytes,
+static int lpfc_idiag_cmd_get(struct iov_iter *from,
 			      struct lpfc_idiag_cmd *idiag_cmd)
 {
+	size_t nbytes = iov_iter_count(from);
 	char mybuf[64];
 	char *pbuf, *step_str;
 	int i;
@@ -3151,7 +3145,7 @@ static int lpfc_idiag_cmd_get(const char __user *buf, size_t nbytes,
 	memset(idiag_cmd, 0, sizeof(*idiag_cmd));
 	bsize = min(nbytes, (sizeof(mybuf)-1));
 
-	if (copy_from_user(mybuf, buf, bsize))
+	if (!copy_from_iter_full(mybuf, bsize, from))
 		return -EFAULT;
 	pbuf = &mybuf[0];
 	step_str = strsep(&pbuf, "\t ");
@@ -3273,10 +3267,8 @@ lpfc_idiag_cmd_release(struct inode *inode, struct file *file)
 
 /**
  * lpfc_idiag_pcicfg_read - idiag debugfs read pcicfg
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the data to.
- * @nbytes: The number of bytes to read.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @to: The buffer to copy the data to.
  *
  * Description:
  * This routine reads data from the @phba pci config space according to the
@@ -3289,11 +3281,9 @@ lpfc_idiag_cmd_release(struct inode *inode, struct file *file)
  * This function returns the amount of data that was read (this could be less
  * than @nbytes if the end of the file was reached) or a negative error value.
  **/
-static ssize_t
-lpfc_idiag_pcicfg_read(struct file *file, char __user *buf, size_t nbytes,
-		       loff_t *ppos)
+static ssize_t lpfc_idiag_pcicfg_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
 	int offset_label, offset, len = 0, index = LPFC_PCI_CFG_RD_SIZE;
 	int where, count;
@@ -3316,7 +3306,7 @@ lpfc_idiag_pcicfg_read(struct file *file, char __user *buf, size_t nbytes,
 		return 0;
 	pbuffer = debug->buffer;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	if (idiag.cmd.opcode == LPFC_IDIAG_CMD_PCICFG_RD) {
@@ -3349,7 +3339,7 @@ lpfc_idiag_pcicfg_read(struct file *file, char __user *buf, size_t nbytes,
 		len = 0;
 		break;
 	}
-	return simple_read_from_buffer(buf, nbytes, ppos, pbuffer, len);
+	return simple_copy_to_iter(pbuffer, &iocb->ki_pos, len, to);
 
 pcicfg_browse:
 
@@ -3389,15 +3379,13 @@ lpfc_idiag_pcicfg_read(struct file *file, char __user *buf, size_t nbytes,
 	} else
 		idiag.offset.last_rd = 0;
 
-	return simple_read_from_buffer(buf, nbytes, ppos, pbuffer, len);
+	return simple_copy_to_iter(pbuffer, &iocb->ki_pos, len, to);
 }
 
 /**
  * lpfc_idiag_pcicfg_write - Syntax check and set up idiag pcicfg commands
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the user data from.
- * @nbytes: The number of bytes to get.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @from: The buffer to copy the user data from.
  *
  * This routine get the debugfs idiag command struct from user space and
  * then perform the syntax check for PCI config space read or write command
@@ -3411,11 +3399,11 @@ lpfc_idiag_pcicfg_read(struct file *file, char __user *buf, size_t nbytes,
  * space.
  */
 static ssize_t
-lpfc_idiag_pcicfg_write(struct file *file, const char __user *buf,
-			size_t nbytes, loff_t *ppos)
+lpfc_idiag_pcicfg_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
+	size_t nbytes = iov_iter_count(from);
 	uint32_t where, value, count;
 	uint32_t u32val;
 	uint16_t u16val;
@@ -3430,7 +3418,7 @@ lpfc_idiag_pcicfg_write(struct file *file, const char __user *buf,
 	/* This is a user write operation */
 	debug->op = LPFC_IDIAG_OP_WR;
 
-	rc = lpfc_idiag_cmd_get(buf, nbytes, &idiag.cmd);
+	rc = lpfc_idiag_cmd_get(from, &idiag.cmd);
 	if (rc < 0)
 		return rc;
 
@@ -3571,10 +3559,8 @@ lpfc_idiag_pcicfg_write(struct file *file, const char __user *buf,
 
 /**
  * lpfc_idiag_baracc_read - idiag debugfs pci bar access read
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the data to.
- * @nbytes: The number of bytes to read.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @to: The buffer to copy the data to.
  *
  * Description:
  * This routine reads data from the @phba pci bar memory mapped space
@@ -3584,11 +3570,9 @@ lpfc_idiag_pcicfg_write(struct file *file, const char __user *buf,
  * This function returns the amount of data that was read (this could be less
  * than @nbytes if the end of the file was reached) or a negative error value.
  **/
-static ssize_t
-lpfc_idiag_baracc_read(struct file *file, char __user *buf, size_t nbytes,
-		       loff_t *ppos)
+static ssize_t lpfc_idiag_baracc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
 	int offset_label, offset, offset_run, len = 0, index;
 	int bar_num, acc_range, bar_size;
@@ -3611,7 +3595,7 @@ lpfc_idiag_baracc_read(struct file *file, char __user *buf, size_t nbytes,
 		return 0;
 	pbuffer = debug->buffer;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	if (idiag.cmd.opcode == LPFC_IDIAG_CMD_BARACC_RD) {
@@ -3652,7 +3636,7 @@ lpfc_idiag_baracc_read(struct file *file, char __user *buf, size_t nbytes,
 	} else
 		goto baracc_browse;
 
-	return simple_read_from_buffer(buf, nbytes, ppos, pbuffer, len);
+	return simple_copy_to_iter(pbuffer, &iocb->ki_pos, len, to);
 
 baracc_browse:
 
@@ -3713,15 +3697,13 @@ lpfc_idiag_baracc_read(struct file *file, char __user *buf, size_t nbytes,
 			idiag.offset.last_rd = offset;
 	}
 
-	return simple_read_from_buffer(buf, nbytes, ppos, pbuffer, len);
+	return simple_copy_to_iter(pbuffer, &iocb->ki_pos, len, to);
 }
 
 /**
  * lpfc_idiag_baracc_write - Syntax check and set up idiag bar access commands
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the user data from.
- * @nbytes: The number of bytes to get.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @from: The buffer to copy the user data from.
  *
  * This routine get the debugfs idiag command struct from user space and
  * then perform the syntax check for PCI bar memory mapped space read or
@@ -3736,12 +3718,12 @@ lpfc_idiag_baracc_read(struct file *file, char __user *buf, size_t nbytes,
  * space.
  */
 static ssize_t
-lpfc_idiag_baracc_write(struct file *file, const char __user *buf,
-			size_t nbytes, loff_t *ppos)
+lpfc_idiag_baracc_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
 	uint32_t bar_num, bar_size, offset, value, acc_range;
+	size_t nbytes = iov_iter_count(from);
 	struct pci_dev *pdev;
 	void __iomem *mem_mapped_bar;
 	uint32_t if_type;
@@ -3755,7 +3737,7 @@ lpfc_idiag_baracc_write(struct file *file, const char __user *buf,
 	/* This is a user write operation */
 	debug->op = LPFC_IDIAG_OP_WR;
 
-	rc = lpfc_idiag_cmd_get(buf, nbytes, &idiag.cmd);
+	rc = lpfc_idiag_cmd_get(from, &idiag.cmd);
 	if (rc < 0)
 		return rc;
 
@@ -4024,10 +4006,8 @@ __lpfc_idiag_print_eq(struct lpfc_queue *qp, char *eqtype,
 
 /**
  * lpfc_idiag_queinfo_read - idiag debugfs read queue information
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the data to.
- * @nbytes: The number of bytes to read.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @to: The buffer to copy the data to.
  *
  * Description:
  * This routine reads data from the @phba SLI4 PCI function queue information,
@@ -4040,11 +4020,9 @@ __lpfc_idiag_print_eq(struct lpfc_queue *qp, char *eqtype,
  * This function returns the amount of data that was read (this could be less
  * than @nbytes if the end of the file was reached) or a negative error value.
  **/
-static ssize_t
-lpfc_idiag_queinfo_read(struct file *file, char __user *buf, size_t nbytes,
-			loff_t *ppos)
+static ssize_t lpfc_idiag_queinfo_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
 	char *pbuffer;
 	int max_cnt, rc, x, len = 0;
@@ -4057,7 +4035,7 @@ lpfc_idiag_queinfo_read(struct file *file, char __user *buf, size_t nbytes,
 	pbuffer = debug->buffer;
 	max_cnt = LPFC_QUE_INFO_GET_BUF_SIZE - 256;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	spin_lock_irq(&phba->hbalock);
@@ -4152,14 +4130,14 @@ lpfc_idiag_queinfo_read(struct file *file, char __user *buf, size_t nbytes,
 	}
 
 	spin_unlock_irq(&phba->hbalock);
-	return simple_read_from_buffer(buf, nbytes, ppos, pbuffer, len);
+	return simple_copy_to_iter(pbuffer, &iocb->ki_pos, len, to);
 
 too_big:
 	len +=  scnprintf(pbuffer + len,
 		LPFC_QUE_INFO_GET_BUF_SIZE - len, "Truncated ...\n");
 out:
 	spin_unlock_irq(&phba->hbalock);
-	return simple_read_from_buffer(buf, nbytes, ppos, pbuffer, len);
+	return simple_copy_to_iter(pbuffer, &iocb->ki_pos, len, to);
 }
 
 /**
@@ -4249,11 +4227,9 @@ lpfc_idiag_queacc_read_qe(char *pbuffer, int len, struct lpfc_queue *pque,
  * This function returns the amount of data that was read (this could be less
  * than @nbytes if the end of the file was reached) or a negative error value.
  **/
-static ssize_t
-lpfc_idiag_queacc_read(struct file *file, char __user *buf, size_t nbytes,
-		       loff_t *ppos)
+static ssize_t lpfc_idiag_queacc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	uint32_t last_index, index, count;
 	struct lpfc_queue *pque = NULL;
 	char *pbuffer;
@@ -4268,7 +4244,7 @@ lpfc_idiag_queacc_read(struct file *file, char __user *buf, size_t nbytes,
 		return 0;
 	pbuffer = debug->buffer;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	if (idiag.cmd.opcode == LPFC_IDIAG_CMD_QUEACC_RD) {
@@ -4285,7 +4261,7 @@ lpfc_idiag_queacc_read(struct file *file, char __user *buf, size_t nbytes,
 	/* Read a single entry from the queue */
 	len = lpfc_idiag_queacc_read_qe(pbuffer, len, pque, index);
 
-	return simple_read_from_buffer(buf, nbytes, ppos, pbuffer, len);
+	return simple_copy_to_iter(pbuffer, &iocb->ki_pos, len, to);
 
 que_browse:
 
@@ -4305,15 +4281,13 @@ lpfc_idiag_queacc_read(struct file *file, char __user *buf, size_t nbytes,
 		index = 0;
 	idiag.offset.last_rd = index;
 
-	return simple_read_from_buffer(buf, nbytes, ppos, pbuffer, len);
+	return simple_copy_to_iter(pbuffer, &iocb->ki_pos, len, to);
 }
 
 /**
  * lpfc_idiag_queacc_write - Syntax check and set up idiag queacc commands
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the user data from.
- * @nbytes: The number of bytes to get.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @from: The buffer to copy the user data from.
  *
  * This routine get the debugfs idiag command struct from user space and then
  * perform the syntax check for port queue read (dump) or write (set) command
@@ -4327,12 +4301,12 @@ lpfc_idiag_queacc_read(struct file *file, char __user *buf, size_t nbytes,
  * space.
  **/
 static ssize_t
-lpfc_idiag_queacc_write(struct file *file, const char __user *buf,
-			size_t nbytes, loff_t *ppos)
+lpfc_idiag_queacc_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
 	uint32_t qidx, quetp, queid, index, count, offset, value;
+	size_t nbytes = iov_iter_count(from);
 	uint32_t *pentry;
 	struct lpfc_queue *pque, *qp;
 	int rc;
@@ -4340,7 +4314,7 @@ lpfc_idiag_queacc_write(struct file *file, const char __user *buf,
 	/* This is a user write operation */
 	debug->op = LPFC_IDIAG_OP_WR;
 
-	rc = lpfc_idiag_cmd_get(buf, nbytes, &idiag.cmd);
+	rc = lpfc_idiag_cmd_get(from, &idiag.cmd);
 	if (rc < 0)
 		return rc;
 
@@ -4608,10 +4582,8 @@ lpfc_idiag_drbacc_read_reg(struct lpfc_hba *phba, char *pbuffer,
 
 /**
  * lpfc_idiag_drbacc_read - idiag debugfs read port doorbell
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the data to.
- * @nbytes: The number of bytes to read.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @to: the buffer to write to
  *
  * Description:
  * This routine reads data from the @phba device doorbell register according
@@ -4623,11 +4595,9 @@ lpfc_idiag_drbacc_read_reg(struct lpfc_hba *phba, char *pbuffer,
  * This function returns the amount of data that was read (this could be less
  * than @nbytes if the end of the file was reached) or a negative error value.
  **/
-static ssize_t
-lpfc_idiag_drbacc_read(struct file *file, char __user *buf, size_t nbytes,
-		       loff_t *ppos)
+static ssize_t lpfc_idiag_drbacc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
 	uint32_t drb_reg_id, i;
 	char *pbuffer;
@@ -4642,7 +4612,7 @@ lpfc_idiag_drbacc_read(struct file *file, char __user *buf, size_t nbytes,
 		return 0;
 	pbuffer = debug->buffer;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	if (idiag.cmd.opcode == LPFC_IDIAG_CMD_DRBACC_RD)
@@ -4658,15 +4628,13 @@ lpfc_idiag_drbacc_read(struct file *file, char __user *buf, size_t nbytes,
 		len = lpfc_idiag_drbacc_read_reg(phba,
 						 pbuffer, len, drb_reg_id);
 
-	return simple_read_from_buffer(buf, nbytes, ppos, pbuffer, len);
+	return simple_copy_to_iter(pbuffer, &iocb->ki_pos, len, to);
 }
 
 /**
  * lpfc_idiag_drbacc_write - Syntax check and set up idiag drbacc commands
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the user data from.
- * @nbytes: The number of bytes to get.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @from: The buffer to copy the user data from.
  *
  * This routine get the debugfs idiag command struct from user space and then
  * perform the syntax check for port doorbell register read (dump) or write
@@ -4680,11 +4648,11 @@ lpfc_idiag_drbacc_read(struct file *file, char __user *buf, size_t nbytes,
  * space.
  **/
 static ssize_t
-lpfc_idiag_drbacc_write(struct file *file, const char __user *buf,
-			size_t nbytes, loff_t *ppos)
+lpfc_idiag_drbacc_write( struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
+	size_t nbytes = iov_iter_count(from);
 	uint32_t drb_reg_id, value, reg_val = 0;
 	void __iomem *drb_reg;
 	int rc;
@@ -4692,7 +4660,7 @@ lpfc_idiag_drbacc_write(struct file *file, const char __user *buf,
 	/* This is a user write operation */
 	debug->op = LPFC_IDIAG_OP_WR;
 
-	rc = lpfc_idiag_cmd_get(buf, nbytes, &idiag.cmd);
+	rc = lpfc_idiag_cmd_get(from, &idiag.cmd);
 	if (rc < 0)
 		return rc;
 
@@ -4828,10 +4796,8 @@ lpfc_idiag_ctlacc_read_reg(struct lpfc_hba *phba, char *pbuffer,
 
 /**
  * lpfc_idiag_ctlacc_read - idiag debugfs read port and device control register
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the data to.
- * @nbytes: The number of bytes to read.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @to: The buffer to copy the data to.
  *
  * Description:
  * This routine reads data from the @phba port and device registers according
@@ -4842,10 +4808,9 @@ lpfc_idiag_ctlacc_read_reg(struct lpfc_hba *phba, char *pbuffer,
  * than @nbytes if the end of the file was reached) or a negative error value.
  **/
 static ssize_t
-lpfc_idiag_ctlacc_read(struct file *file, char __user *buf, size_t nbytes,
-		       loff_t *ppos)
+lpfc_idiag_ctlacc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
 	uint32_t ctl_reg_id, i;
 	char *pbuffer;
@@ -4860,7 +4825,7 @@ lpfc_idiag_ctlacc_read(struct file *file, char __user *buf, size_t nbytes,
 		return 0;
 	pbuffer = debug->buffer;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	if (idiag.cmd.opcode == LPFC_IDIAG_CMD_CTLACC_RD)
@@ -4876,15 +4841,13 @@ lpfc_idiag_ctlacc_read(struct file *file, char __user *buf, size_t nbytes,
 		len = lpfc_idiag_ctlacc_read_reg(phba,
 						 pbuffer, len, ctl_reg_id);
 
-	return simple_read_from_buffer(buf, nbytes, ppos, pbuffer, len);
+	return simple_copy_to_iter(pbuffer, &iocb->ki_pos, len, to);
 }
 
 /**
  * lpfc_idiag_ctlacc_write - Syntax check and set up idiag ctlacc commands
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the user data from.
- * @nbytes: The number of bytes to get.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @from: The buffer to copy the user data from.
  *
  * This routine get the debugfs idiag command struct from user space and then
  * perform the syntax check for port and device control register read (dump)
@@ -4895,11 +4858,11 @@ lpfc_idiag_ctlacc_read(struct file *file, char __user *buf, size_t nbytes,
  * space.
  **/
 static ssize_t
-lpfc_idiag_ctlacc_write(struct file *file, const char __user *buf,
-			size_t nbytes, loff_t *ppos)
+lpfc_idiag_ctlacc_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
+	size_t nbytes = iov_iter_count(from);
 	uint32_t ctl_reg_id, value, reg_val = 0;
 	void __iomem *ctl_reg;
 	int rc;
@@ -4907,7 +4870,7 @@ lpfc_idiag_ctlacc_write(struct file *file, const char __user *buf,
 	/* This is a user write operation */
 	debug->op = LPFC_IDIAG_OP_WR;
 
-	rc = lpfc_idiag_cmd_get(buf, nbytes, &idiag.cmd);
+	rc = lpfc_idiag_cmd_get(from, &idiag.cmd);
 	if (rc < 0)
 		return rc;
 
@@ -5022,10 +4985,8 @@ lpfc_idiag_mbxacc_get_setup(struct lpfc_hba *phba, char *pbuffer)
 
 /**
  * lpfc_idiag_mbxacc_read - idiag debugfs read on mailbox access
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the data to.
- * @nbytes: The number of bytes to read.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @to: The buffer to copy the user data to.
  *
  * Description:
  * This routine reads data from the @phba driver mailbox access debugfs setup
@@ -5035,11 +4996,9 @@ lpfc_idiag_mbxacc_get_setup(struct lpfc_hba *phba, char *pbuffer)
  * This function returns the amount of data that was read (this could be less
  * than @nbytes if the end of the file was reached) or a negative error value.
  **/
-static ssize_t
-lpfc_idiag_mbxacc_read(struct file *file, char __user *buf, size_t nbytes,
-		       loff_t *ppos)
+static ssize_t lpfc_idiag_mbxacc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
 	char *pbuffer;
 	int len = 0;
@@ -5053,7 +5012,7 @@ lpfc_idiag_mbxacc_read(struct file *file, char __user *buf, size_t nbytes,
 		return 0;
 	pbuffer = debug->buffer;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	if ((idiag.cmd.opcode != LPFC_IDIAG_CMD_MBXACC_DP) &&
@@ -5062,15 +5021,13 @@ lpfc_idiag_mbxacc_read(struct file *file, char __user *buf, size_t nbytes,
 
 	len = lpfc_idiag_mbxacc_get_setup(phba, pbuffer);
 
-	return simple_read_from_buffer(buf, nbytes, ppos, pbuffer, len);
+	return simple_copy_to_iter(pbuffer, &iocb->ki_pos, len, to);
 }
 
 /**
  * lpfc_idiag_mbxacc_write - Syntax check and set up idiag mbxacc commands
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the user data from.
- * @nbytes: The number of bytes to get.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @from: The buffer to copy the user data from.
  *
  * This routine get the debugfs idiag command struct from user space and then
  * perform the syntax check for driver mailbox command (dump) and sets up the
@@ -5081,17 +5038,17 @@ lpfc_idiag_mbxacc_read(struct file *file, char __user *buf, size_t nbytes,
  * space.
  **/
 static ssize_t
-lpfc_idiag_mbxacc_write(struct file *file, const char __user *buf,
-			size_t nbytes, loff_t *ppos)
+lpfc_idiag_mbxacc_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	uint32_t mbx_dump_map, mbx_dump_cnt, mbx_word_cnt, mbx_mbox_cmd;
+	size_t nbytes = iov_iter_count(from);
 	int rc;
 
 	/* This is a user write operation */
 	debug->op = LPFC_IDIAG_OP_WR;
 
-	rc = lpfc_idiag_cmd_get(buf, nbytes, &idiag.cmd);
+	rc = lpfc_idiag_cmd_get(from, &idiag.cmd);
 	if (rc < 0)
 		return rc;
 
@@ -5341,10 +5298,8 @@ lpfc_idiag_extacc_drivr_get(struct lpfc_hba *phba, char *pbuffer, int len)
 
 /**
  * lpfc_idiag_extacc_write - Syntax check and set up idiag extacc commands
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the user data from.
- * @nbytes: The number of bytes to get.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @from: The buffer to copy the user data from.
  *
  * This routine get the debugfs idiag command struct from user space and then
  * perform the syntax check for extent information access commands and sets
@@ -5355,17 +5310,17 @@ lpfc_idiag_extacc_drivr_get(struct lpfc_hba *phba, char *pbuffer, int len)
  * space.
  **/
 static ssize_t
-lpfc_idiag_extacc_write(struct file *file, const char __user *buf,
-			size_t nbytes, loff_t *ppos)
+lpfc_idiag_extacc_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
+	size_t nbytes = iov_iter_count(from);
 	uint32_t ext_map;
 	int rc;
 
 	/* This is a user write operation */
 	debug->op = LPFC_IDIAG_OP_WR;
 
-	rc = lpfc_idiag_cmd_get(buf, nbytes, &idiag.cmd);
+	rc = lpfc_idiag_cmd_get(from, &idiag.cmd);
 	if (rc < 0)
 		return rc;
 
@@ -5387,10 +5342,8 @@ lpfc_idiag_extacc_write(struct file *file, const char __user *buf,
 
 /**
  * lpfc_idiag_extacc_read - idiag debugfs read access to extent information
- * @file: The file pointer to read from.
- * @buf: The buffer to copy the data to.
- * @nbytes: The number of bytes to read.
- * @ppos: The position in the file to start reading from.
+ * @iocb: Metadata for IO
+ * @to: The buffer to copy the user data to.
  *
  * Description:
  * This routine reads data from the proper extent information according to
@@ -5400,11 +5353,9 @@ lpfc_idiag_extacc_write(struct file *file, const char __user *buf,
  * This function returns the amount of data that was read (this could be less
  * than @nbytes if the end of the file was reached) or a negative error value.
  **/
-static ssize_t
-lpfc_idiag_extacc_read(struct file *file, char __user *buf, size_t nbytes,
-		       loff_t *ppos)
+static ssize_t lpfc_idiag_extacc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
 	char *pbuffer;
 	uint32_t ext_map;
@@ -5418,7 +5369,7 @@ lpfc_idiag_extacc_read(struct file *file, char __user *buf, size_t nbytes,
 	if (!debug->buffer)
 		return 0;
 	pbuffer = debug->buffer;
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 	if (idiag.cmd.opcode != LPFC_IDIAG_CMD_EXTACC_RD)
 		return 0;
@@ -5431,7 +5382,7 @@ lpfc_idiag_extacc_read(struct file *file, char __user *buf, size_t nbytes,
 	if (ext_map & LPFC_EXT_ACC_DRIVR)
 		len = lpfc_idiag_extacc_drivr_get(phba, pbuffer, len);
 
-	return simple_read_from_buffer(buf, nbytes, ppos, pbuffer, len);
+	return simple_copy_to_iter(pbuffer, &iocb->ki_pos, len, to);
 }
 
 static int
@@ -5458,11 +5409,9 @@ lpfc_cgn_buffer_open(struct inode *inode, struct file *file)
 	return rc;
 }
 
-static ssize_t
-lpfc_cgn_buffer_read(struct file *file, char __user *buf, size_t nbytes,
-		     loff_t *ppos)
+static ssize_t lpfc_cgn_buffer_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lpfc_debug *debug = file->private_data;
+	struct lpfc_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
 	char *buffer = debug->buffer;
 	uint32_t *ptr;
@@ -5512,7 +5461,7 @@ lpfc_cgn_buffer_read(struct file *file, char __user *buf, size_t nbytes,
 			 "%08x %08x %08x %08x\n",
 			 *ptr, *(ptr + 1), *(ptr + 2), *(ptr + 3));
 out:
-	return simple_read_from_buffer(buf, nbytes, ppos, buffer, len);
+	return simple_copy_to_iter(buffer, &iocb->ki_pos, len, to);
 }
 
 static int
@@ -5551,10 +5500,9 @@ lpfc_rx_monitor_open(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-lpfc_rx_monitor_read(struct file *file, char __user *buf, size_t nbytes,
-		     loff_t *ppos)
+lpfc_rx_monitor_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lpfc_rx_monitor_debug *debug = file->private_data;
+	struct lpfc_rx_monitor_debug *debug = iocb->ki_filp->private_data;
 	struct lpfc_hba *phba = (struct lpfc_hba *)debug->i_private;
 	char *buffer = debug->buffer;
 
@@ -5567,8 +5515,7 @@ lpfc_rx_monitor_read(struct file *file, char __user *buf, size_t nbytes,
 				       LPFC_MAX_RXMONITOR_ENTRY);
 	}
 
-	return simple_read_from_buffer(buf, nbytes, ppos, buffer,
-				       strlen(buffer));
+	return simple_copy_to_iter(buffer, &iocb->ki_pos, strlen(buffer), to);
 }
 
 static int
@@ -5587,7 +5534,7 @@ static const struct file_operations lpfc_debugfs_op_disc_trc = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_debugfs_disc_trc_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_debugfs_read,
+	.read_iter =    lpfc_debugfs_read,
 	.release =      lpfc_debugfs_release,
 };
 
@@ -5596,7 +5543,7 @@ static const struct file_operations lpfc_debugfs_op_nodelist = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_debugfs_nodelist_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_debugfs_read,
+	.read_iter =    lpfc_debugfs_read,
 	.release =      lpfc_debugfs_release,
 };
 
@@ -5605,8 +5552,8 @@ static const struct file_operations lpfc_debugfs_op_multixripools = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_debugfs_multixripools_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_debugfs_read,
-	.write =	lpfc_debugfs_multixripools_write,
+	.read_iter =    lpfc_debugfs_read,
+	.write_iter =	lpfc_debugfs_multixripools_write,
 	.release =      lpfc_debugfs_release,
 };
 
@@ -5615,7 +5562,7 @@ static const struct file_operations lpfc_debugfs_op_hbqinfo = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_debugfs_hbqinfo_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_debugfs_read,
+	.read_iter =    lpfc_debugfs_read,
 	.release =      lpfc_debugfs_release,
 };
 
@@ -5625,8 +5572,8 @@ static const struct file_operations lpfc_debugfs_op_lockstat = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_debugfs_lockstat_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_debugfs_read,
-	.write =        lpfc_debugfs_lockstat_write,
+	.read_iter =    lpfc_debugfs_read,
+	.write_iter =   lpfc_debugfs_lockstat_iter,
 	.release =      lpfc_debugfs_release,
 };
 #endif
@@ -5636,7 +5583,7 @@ static const struct file_operations lpfc_debugfs_ras_log = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_debugfs_ras_log_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_debugfs_read,
+	.read_iter =    lpfc_debugfs_read,
 	.release =      lpfc_debugfs_ras_log_release,
 };
 
@@ -5645,7 +5592,7 @@ static const struct file_operations lpfc_debugfs_op_dumpHBASlim = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_debugfs_dumpHBASlim_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_debugfs_read,
+	.read_iter =    lpfc_debugfs_read,
 	.release =      lpfc_debugfs_release,
 };
 
@@ -5654,7 +5601,7 @@ static const struct file_operations lpfc_debugfs_op_dumpHostSlim = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_debugfs_dumpHostSlim_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_debugfs_read,
+	.read_iter =    lpfc_debugfs_read,
 	.release =      lpfc_debugfs_release,
 };
 
@@ -5663,8 +5610,8 @@ static const struct file_operations lpfc_debugfs_op_nvmestat = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_debugfs_nvmestat_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_debugfs_read,
-	.write =	lpfc_debugfs_nvmestat_write,
+	.read_iter =    lpfc_debugfs_read,
+	.write_iter =	lpfc_debugfs_nvmestat_write,
 	.release =      lpfc_debugfs_release,
 };
 
@@ -5673,8 +5620,8 @@ static const struct file_operations lpfc_debugfs_op_scsistat = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_debugfs_scsistat_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_debugfs_read,
-	.write =	lpfc_debugfs_scsistat_write,
+	.read_iter =    lpfc_debugfs_read,
+	.write_iter =	lpfc_debugfs_scsistat_write,
 	.release =      lpfc_debugfs_release,
 };
 
@@ -5683,8 +5630,8 @@ static const struct file_operations lpfc_debugfs_op_ioktime = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_debugfs_ioktime_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_debugfs_read,
-	.write =	lpfc_debugfs_ioktime_write,
+	.read_iter =    lpfc_debugfs_read,
+	.write_iter =	lpfc_debugfs_ioktime_write,
 	.release =      lpfc_debugfs_release,
 };
 
@@ -5693,8 +5640,8 @@ static const struct file_operations lpfc_debugfs_op_nvmeio_trc = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_debugfs_nvmeio_trc_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_debugfs_read,
-	.write =	lpfc_debugfs_nvmeio_trc_write,
+	.read_iter =    lpfc_debugfs_read,
+	.write_iter =	lpfc_debugfs_nvmeio_trc_write,
 	.release =      lpfc_debugfs_release,
 };
 
@@ -5703,8 +5650,8 @@ static const struct file_operations lpfc_debugfs_op_hdwqstat = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_debugfs_hdwqstat_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_debugfs_read,
-	.write =	lpfc_debugfs_hdwqstat_write,
+	.read_iter =    lpfc_debugfs_read,
+	.write_iter =	lpfc_debugfs_hdwqstat_write,
 	.release =      lpfc_debugfs_release,
 };
 
@@ -5713,8 +5660,8 @@ static const struct file_operations lpfc_debugfs_op_dif_err = {
 	.owner =	THIS_MODULE,
 	.open =		simple_open,
 	.llseek =	lpfc_debugfs_lseek,
-	.read =		lpfc_debugfs_dif_err_read,
-	.write =	lpfc_debugfs_dif_err_write,
+	.read_iter =	lpfc_debugfs_dif_err_read,
+	.write_iter =	lpfc_debugfs_dif_err_write,
 	.release =	lpfc_debugfs_dif_err_release,
 };
 
@@ -5723,7 +5670,7 @@ static const struct file_operations lpfc_debugfs_op_slow_ring_trc = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_debugfs_slow_ring_trc_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_debugfs_read,
+	.read_iter =    lpfc_debugfs_read,
 	.release =      lpfc_debugfs_release,
 };
 
@@ -5738,8 +5685,8 @@ static const struct file_operations lpfc_idiag_op_pciCfg = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_idiag_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_idiag_pcicfg_read,
-	.write =        lpfc_idiag_pcicfg_write,
+	.read_iter =    lpfc_idiag_pcicfg_read,
+	.write_iter =   lpfc_idiag_pcicfg_write,
 	.release =      lpfc_idiag_cmd_release,
 };
 
@@ -5748,8 +5695,8 @@ static const struct file_operations lpfc_idiag_op_barAcc = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_idiag_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_idiag_baracc_read,
-	.write =        lpfc_idiag_baracc_write,
+	.read_iter =    lpfc_idiag_baracc_read,
+	.write_iter =   lpfc_idiag_baracc_write,
 	.release =      lpfc_idiag_cmd_release,
 };
 
@@ -5757,7 +5704,7 @@ static const struct file_operations lpfc_idiag_op_barAcc = {
 static const struct file_operations lpfc_idiag_op_queInfo = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_idiag_open,
-	.read =         lpfc_idiag_queinfo_read,
+	.read_iter =    lpfc_idiag_queinfo_read,
 	.release =      lpfc_idiag_release,
 };
 
@@ -5766,8 +5713,8 @@ static const struct file_operations lpfc_idiag_op_queAcc = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_idiag_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_idiag_queacc_read,
-	.write =        lpfc_idiag_queacc_write,
+	.read_iter =    lpfc_idiag_queacc_read,
+	.write_iter =   lpfc_idiag_queacc_write,
 	.release =      lpfc_idiag_cmd_release,
 };
 
@@ -5776,8 +5723,8 @@ static const struct file_operations lpfc_idiag_op_drbAcc = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_idiag_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_idiag_drbacc_read,
-	.write =        lpfc_idiag_drbacc_write,
+	.read_iter =    lpfc_idiag_drbacc_read,
+	.write_iter =   lpfc_idiag_drbacc_write,
 	.release =      lpfc_idiag_cmd_release,
 };
 
@@ -5786,8 +5733,8 @@ static const struct file_operations lpfc_idiag_op_ctlAcc = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_idiag_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_idiag_ctlacc_read,
-	.write =        lpfc_idiag_ctlacc_write,
+	.read_iter =    lpfc_idiag_ctlacc_read,
+	.write_iter =   lpfc_idiag_ctlacc_write,
 	.release =      lpfc_idiag_cmd_release,
 };
 
@@ -5796,8 +5743,8 @@ static const struct file_operations lpfc_idiag_op_mbxAcc = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_idiag_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_idiag_mbxacc_read,
-	.write =        lpfc_idiag_mbxacc_write,
+	.read_iter =    lpfc_idiag_mbxacc_read,
+	.write_iter =   lpfc_idiag_mbxacc_write,
 	.release =      lpfc_idiag_cmd_release,
 };
 
@@ -5806,8 +5753,8 @@ static const struct file_operations lpfc_idiag_op_extAcc = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_idiag_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_idiag_extacc_read,
-	.write =        lpfc_idiag_extacc_write,
+	.read_iter =    lpfc_idiag_extacc_read,
+	.write_iter =   lpfc_idiag_extacc_write,
 	.release =      lpfc_idiag_cmd_release,
 };
 #undef lpfc_cgn_buffer_op
@@ -5815,7 +5762,7 @@ static const struct file_operations lpfc_cgn_buffer_op = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_cgn_buffer_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_cgn_buffer_read,
+	.read_iter =    lpfc_cgn_buffer_read,
 	.release =      lpfc_cgn_buffer_release,
 };
 
@@ -5824,7 +5771,7 @@ static const struct file_operations lpfc_rx_monitor_op = {
 	.owner =        THIS_MODULE,
 	.open =         lpfc_rx_monitor_open,
 	.llseek =       lpfc_debugfs_lseek,
-	.read =         lpfc_rx_monitor_read,
+	.read_iter =    lpfc_rx_monitor_read,
 	.release =      lpfc_rx_monitor_release,
 };
 #endif
-- 
2.43.0


