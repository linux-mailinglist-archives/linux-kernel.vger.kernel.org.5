Return-Path: <linux-kernel+bounces-140953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79088A19C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2FC283EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3941C1B5C40;
	Thu, 11 Apr 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="G0KU6SpF"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBA23DABFF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849812; cv=none; b=CRv3xw8oeia4+C5bKFwQDU7Qh0w0TMosnJ9ONg4h0eQwq7RG6RAqpTh71H+NbFG93a0ZOwuW4h+hWQiCE3n0y+K/7/rsmtbE1QRy/Fkqtmp/BX8CX9D+2P44CM4tBh/Zk7GHim50YFBHqww2mGw/O1gIK/5Q0oZNBhFISvbBGiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849812; c=relaxed/simple;
	bh=QuK3dpYaFFx2Mh/ClUhCSjDZok6p++AOpN6yprAnvdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kx/G69Jcxv6iq0tDweZ2KiBY76u1Tv6zVGAqkE6HY6P9sQovRo70th5JDpWLSFvNvcFJRzlXjutLpstUKso5LjCMMooeuWUKFyEiV2N/i6ESc9ZA13BMhfBjr136SQKrwl5OSJmbw2TGAOhAyZ4Vd2xnvsSpUWXcFPQRGMSjpPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=G0KU6SpF; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8960839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849809; x=1713454609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjV/Uh3tcbRSrddjd1Z8mJo7f9wXMqNoZNrlnVY07vI=;
        b=G0KU6SpFggch6VBBuXrDt0Zwo+RLnRPE4emHG3IVi/eRcoPh9wHs2t/JmFtXB94OiC
         msSM1z1Z9oran3lZxRZMczBgnz/d/ODRmGvfeJ1KCrir585gwjuMxQ8VNh4wAwRUPEEv
         4/EjBHynJ3oOnv9hwwdVIY95ytH+yMWQGZD/9uYXl0QTKKqb+CxAkWGyhszqrOjx7QxM
         IXnUg/Zt+OeyC6Sr+9/tW1qa6zA2y4K+/3F8LL0uvVu/zuzPUj7VWOypcUoEUAJ+FSI0
         NjypvPfRNvvd2Mu2ZsrmEQyH3puBG9a+sBn3MUFA2Tf1s9Z3LFRlemUtZv2X28IJMBz4
         fi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849809; x=1713454609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjV/Uh3tcbRSrddjd1Z8mJo7f9wXMqNoZNrlnVY07vI=;
        b=bP1D8rfTBewiIA3bsL+922xKQN2+9hlTbspUKw66Ui8kgYkNYoEsFaVz3G+TTFA604
         sJWybFtfIRqRKPmSotGPcumIVovBxxiPOvaSccNx1P0K44Nc397vJxSIpAXjBZrwBjZP
         CQRra7Nrq+Y2DwahZ0jTUsHoaMOENTbouEzSP5NZ+h6At7tSENJm9ofZTifzKYPOa8Ns
         8MbZIMIRn3Gfsz/nJ+EqVN8fTrn/4rPxB2R9IibrxVa1PWoFzME+KsBRiDyia0LBI+ay
         HABRB7qUscayOXA4SLvXenYYtrWStRmz26S4g8+6M7LMSU327jEsr/8nDk+1IV2JwhJf
         NoUQ==
X-Gm-Message-State: AOJu0YyjJFumdZpSm6XXcZ0cbjmZQBLHx9wMPY29qpyJJCxdUJM5REQ1
	YLNf34S6GC1mIhEEhEmpjELHJqf7oALkqEnrQ5wLOFcI4cnGhKMo2VlGTPRobs8sIeLyCJ4yTay
	D
X-Google-Smtp-Source: AGHT+IEKl7tzo+UNouikvSySi4Sm3yB+IzdkbvPLnw5ufhKakYwKR9ZvaboISqEWVxdgCUbgoaApYQ==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr17838ioc.1.1712849809229;
        Thu, 11 Apr 2024 08:36:49 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 184/437] drivers/mtd: convert to ->read_iter and ->write_iter
Date: Thu, 11 Apr 2024 09:15:24 -0600
Message-ID: <20240411153126.16201-185-axboe@kernel.dk>
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
 drivers/mtd/mtdchar.c   | 52 ++++++++++++++++++------------------
 drivers/mtd/ubi/cdev.c  | 58 ++++++++++++++++++++---------------------
 drivers/mtd/ubi/debug.c | 38 ++++++++++++---------------
 drivers/mtd/ubi/ubi.h   |  4 +--
 drivers/mtd/ubi/upd.c   | 24 ++++++++---------
 5 files changed, 83 insertions(+), 93 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 8dc4f5c493fc..0e3b6674f081 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -124,10 +124,10 @@ static int mtdchar_close(struct inode *inode, struct file *file)
  * alignment requirements are not met in the NAND subdriver.
  */
 
-static ssize_t mtdchar_read(struct file *file, char __user *buf, size_t count,
-			loff_t *ppos)
+static ssize_t mtdchar_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mtd_file_info *mfi = file->private_data;
+	struct mtd_file_info *mfi = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct mtd_info *mtd = mfi->mtd;
 	size_t retlen;
 	size_t total_retlen=0;
@@ -138,9 +138,9 @@ static ssize_t mtdchar_read(struct file *file, char __user *buf, size_t count,
 
 	pr_debug("MTD_read\n");
 
-	if (*ppos + count > mtd->size) {
-		if (*ppos < mtd->size)
-			count = mtd->size - *ppos;
+	if (iocb->ki_pos + count > mtd->size) {
+		if (iocb->ki_pos < mtd->size)
+			count = mtd->size - iocb->ki_pos;
 		else
 			count = 0;
 	}
@@ -157,11 +157,11 @@ static ssize_t mtdchar_read(struct file *file, char __user *buf, size_t count,
 
 		switch (mfi->mode) {
 		case MTD_FILE_MODE_OTP_FACTORY:
-			ret = mtd_read_fact_prot_reg(mtd, *ppos, len,
+			ret = mtd_read_fact_prot_reg(mtd, iocb->ki_pos, len,
 						     &retlen, kbuf);
 			break;
 		case MTD_FILE_MODE_OTP_USER:
-			ret = mtd_read_user_prot_reg(mtd, *ppos, len,
+			ret = mtd_read_user_prot_reg(mtd, iocb->ki_pos, len,
 						     &retlen, kbuf);
 			break;
 		case MTD_FILE_MODE_RAW:
@@ -173,12 +173,12 @@ static ssize_t mtdchar_read(struct file *file, char __user *buf, size_t count,
 			ops.oobbuf = NULL;
 			ops.len = len;
 
-			ret = mtd_read_oob(mtd, *ppos, &ops);
+			ret = mtd_read_oob(mtd, iocb->ki_pos, &ops);
 			retlen = ops.retlen;
 			break;
 		}
 		default:
-			ret = mtd_read(mtd, *ppos, len, &retlen, kbuf);
+			ret = mtd_read(mtd, iocb->ki_pos, len, &retlen, kbuf);
 		}
 		/* Nand returns -EBADMSG on ECC errors, but it returns
 		 * the data. For our userspace tools it is important
@@ -190,8 +190,8 @@ static ssize_t mtdchar_read(struct file *file, char __user *buf, size_t count,
 		 * must be aware of the fact that it deals with NAND
 		 */
 		if (!ret || mtd_is_bitflip_or_eccerr(ret)) {
-			*ppos += retlen;
-			if (copy_to_user(buf, kbuf, retlen)) {
+			iocb->ki_pos += retlen;
+			if (!copy_to_iter_full(kbuf, retlen, to)) {
 				kfree(kbuf);
 				return -EFAULT;
 			}
@@ -199,7 +199,6 @@ static ssize_t mtdchar_read(struct file *file, char __user *buf, size_t count,
 				total_retlen += retlen;
 
 			count -= retlen;
-			buf += retlen;
 			if (retlen == 0)
 				count = 0;
 		}
@@ -214,10 +213,10 @@ static ssize_t mtdchar_read(struct file *file, char __user *buf, size_t count,
 	return total_retlen;
 } /* mtdchar_read */
 
-static ssize_t mtdchar_write(struct file *file, const char __user *buf, size_t count,
-			loff_t *ppos)
+static ssize_t mtdchar_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mtd_file_info *mfi = file->private_data;
+	struct mtd_file_info *mfi = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct mtd_info *mtd = mfi->mtd;
 	size_t size = count;
 	char *kbuf;
@@ -228,11 +227,11 @@ static ssize_t mtdchar_write(struct file *file, const char __user *buf, size_t c
 
 	pr_debug("MTD_write\n");
 
-	if (*ppos >= mtd->size)
+	if (iocb->ki_pos >= mtd->size)
 		return -ENOSPC;
 
-	if (*ppos + count > mtd->size)
-		count = mtd->size - *ppos;
+	if (iocb->ki_pos + count > mtd->size)
+		count = mtd->size - iocb->ki_pos;
 
 	if (!count)
 		return 0;
@@ -244,7 +243,7 @@ static ssize_t mtdchar_write(struct file *file, const char __user *buf, size_t c
 	while (count) {
 		len = min_t(size_t, count, size);
 
-		if (copy_from_user(kbuf, buf, len)) {
+		if (!copy_from_iter_full(kbuf, len, from)) {
 			kfree(kbuf);
 			return -EFAULT;
 		}
@@ -254,7 +253,7 @@ static ssize_t mtdchar_write(struct file *file, const char __user *buf, size_t c
 			ret = -EROFS;
 			break;
 		case MTD_FILE_MODE_OTP_USER:
-			ret = mtd_write_user_prot_reg(mtd, *ppos, len,
+			ret = mtd_write_user_prot_reg(mtd, iocb->ki_pos, len,
 						      &retlen, kbuf);
 			break;
 
@@ -268,13 +267,13 @@ static ssize_t mtdchar_write(struct file *file, const char __user *buf, size_t c
 			ops.ooboffs = 0;
 			ops.len = len;
 
-			ret = mtd_write_oob(mtd, *ppos, &ops);
+			ret = mtd_write_oob(mtd, iocb->ki_pos, &ops);
 			retlen = ops.retlen;
 			break;
 		}
 
 		default:
-			ret = mtd_write(mtd, *ppos, len, &retlen, kbuf);
+			ret = mtd_write(mtd, iocb->ki_pos, len, &retlen, kbuf);
 		}
 
 		/*
@@ -286,10 +285,9 @@ static ssize_t mtdchar_write(struct file *file, const char __user *buf, size_t c
 			break;
 
 		if (!ret) {
-			*ppos += retlen;
+			iocb->ki_pos += retlen;
 			total_retlen += retlen;
 			count -= retlen;
-			buf += retlen;
 		}
 		else {
 			kfree(kbuf);
@@ -1401,8 +1399,8 @@ static int mtdchar_mmap(struct file *file, struct vm_area_struct *vma)
 static const struct file_operations mtd_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= mtdchar_lseek,
-	.read		= mtdchar_read,
-	.write		= mtdchar_write,
+	.read_iter	= mtdchar_read,
+	.write_iter	= mtdchar_write,
 	.unlocked_ioctl	= mtdchar_unlocked_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= mtdchar_compat_ioctl,
diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
index 0d8f04cf03c5..ab99cfff211c 100644
--- a/drivers/mtd/ubi/cdev.c
+++ b/drivers/mtd/ubi/cdev.c
@@ -168,10 +168,10 @@ static int vol_cdev_fsync(struct file *file, loff_t start, loff_t end,
 }
 
 
-static ssize_t vol_cdev_read(struct file *file, __user char *buf, size_t count,
-			     loff_t *offp)
+static ssize_t vol_cdev_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ubi_volume_desc *desc = file->private_data;
+	struct ubi_volume_desc *desc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct ubi_volume *vol = desc->vol;
 	struct ubi_device *ubi = vol->ubi;
 	int err, lnum, off, len,  tbuf_size;
@@ -179,7 +179,7 @@ static ssize_t vol_cdev_read(struct file *file, __user char *buf, size_t count,
 	void *tbuf;
 
 	dbg_gen("read %zd bytes from offset %lld of volume %d",
-		count, *offp, vol->vol_id);
+		count, iocb->ki_pos, vol->vol_id);
 
 	if (vol->updating) {
 		ubi_err(vol->ubi, "updating");
@@ -189,14 +189,14 @@ static ssize_t vol_cdev_read(struct file *file, __user char *buf, size_t count,
 		ubi_err(vol->ubi, "damaged volume, update marker is set");
 		return -EBADF;
 	}
-	if (*offp == vol->used_bytes || count == 0)
+	if (iocb->ki_pos == vol->used_bytes || count == 0)
 		return 0;
 
 	if (vol->corrupted)
 		dbg_gen("read from corrupted volume %d", vol->vol_id);
 
-	if (*offp + count > vol->used_bytes)
-		count_save = count = vol->used_bytes - *offp;
+	if (iocb->ki_pos + count > vol->used_bytes)
+		count_save = count = vol->used_bytes - iocb->ki_pos;
 
 	tbuf_size = vol->usable_leb_size;
 	if (count < tbuf_size)
@@ -206,7 +206,7 @@ static ssize_t vol_cdev_read(struct file *file, __user char *buf, size_t count,
 		return -ENOMEM;
 
 	len = count > tbuf_size ? tbuf_size : count;
-	lnum = div_u64_rem(*offp, vol->usable_leb_size, &off);
+	lnum = div_u64_rem(iocb->ki_pos, vol->usable_leb_size, &off);
 
 	do {
 		cond_resched();
@@ -225,15 +225,14 @@ static ssize_t vol_cdev_read(struct file *file, __user char *buf, size_t count,
 		}
 
 		count -= len;
-		*offp += len;
+		iocb->ki_pos += len;
 
-		err = copy_to_user(buf, tbuf, len);
+		err = !copy_to_iter_full(tbuf, len, to);
 		if (err) {
 			err = -EFAULT;
 			break;
 		}
 
-		buf += len;
 		len = count > tbuf_size ? tbuf_size : count;
 	} while (count);
 
@@ -245,10 +244,10 @@ static ssize_t vol_cdev_read(struct file *file, __user char *buf, size_t count,
  * This function allows to directly write to dynamic UBI volumes, without
  * issuing the volume update operation.
  */
-static ssize_t vol_cdev_direct_write(struct file *file, const char __user *buf,
-				     size_t count, loff_t *offp)
+static ssize_t vol_cdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ubi_volume_desc *desc = file->private_data;
+	struct ubi_volume_desc *desc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ubi_volume *vol = desc->vol;
 	struct ubi_device *ubi = vol->ubi;
 	int lnum, off, len, tbuf_size, err = 0;
@@ -259,19 +258,19 @@ static ssize_t vol_cdev_direct_write(struct file *file, const char __user *buf,
 		return -EPERM;
 
 	dbg_gen("requested: write %zd bytes to offset %lld of volume %u",
-		count, *offp, vol->vol_id);
+		count, iocb->ki_pos, vol->vol_id);
 
 	if (vol->vol_type == UBI_STATIC_VOLUME)
 		return -EROFS;
 
-	lnum = div_u64_rem(*offp, vol->usable_leb_size, &off);
+	lnum = div_u64_rem(iocb->ki_pos, vol->usable_leb_size, &off);
 	if (off & (ubi->min_io_size - 1)) {
 		ubi_err(ubi, "unaligned position");
 		return -EINVAL;
 	}
 
-	if (*offp + count > vol->used_bytes)
-		count_save = count = vol->used_bytes - *offp;
+	if (iocb->ki_pos + count > vol->used_bytes)
+		count_save = count = vol->used_bytes - iocb->ki_pos;
 
 	/* We can write only in fractions of the minimum I/O unit */
 	if (count & (ubi->min_io_size - 1)) {
@@ -294,7 +293,7 @@ static ssize_t vol_cdev_direct_write(struct file *file, const char __user *buf,
 		if (off + len >= vol->usable_leb_size)
 			len = vol->usable_leb_size - off;
 
-		err = copy_from_user(tbuf, buf, len);
+		err = !copy_from_iter_full(tbuf, len, from);
 		if (err) {
 			err = -EFAULT;
 			break;
@@ -311,8 +310,7 @@ static ssize_t vol_cdev_direct_write(struct file *file, const char __user *buf,
 		}
 
 		count -= len;
-		*offp += len;
-		buf += len;
+		iocb->ki_pos += len;
 		len = count > tbuf_size ? tbuf_size : count;
 	}
 
@@ -320,25 +318,25 @@ static ssize_t vol_cdev_direct_write(struct file *file, const char __user *buf,
 	return err ? err : count_save - count;
 }
 
-static ssize_t vol_cdev_write(struct file *file, const char __user *buf,
-			      size_t count, loff_t *offp)
+static ssize_t vol_cdev_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int err = 0;
-	struct ubi_volume_desc *desc = file->private_data;
+	struct ubi_volume_desc *desc = iocb->ki_filp->private_data;
 	struct ubi_volume *vol = desc->vol;
 	struct ubi_device *ubi = vol->ubi;
+	size_t count = iov_iter_count(from);
 
 	if (!vol->updating && !vol->changing_leb)
-		return vol_cdev_direct_write(file, buf, count, offp);
+		return vol_cdev_direct_write(iocb, from);
 
 	if (vol->updating)
-		err = ubi_more_update_data(ubi, vol, buf, count);
+		err = ubi_more_update_data(ubi, vol, from);
 	else
-		err = ubi_more_leb_change_data(ubi, vol, buf, count);
+		err = ubi_more_leb_change_data(ubi, vol, from);
 
 	if (err < 0) {
 		ubi_err(ubi, "cannot accept more %zd bytes of data, error %d",
-			count, err);
+			iov_iter_count(from), err);
 		return err;
 	}
 
@@ -1085,8 +1083,8 @@ const struct file_operations ubi_vol_cdev_operations = {
 	.open           = vol_cdev_open,
 	.release        = vol_cdev_release,
 	.llseek         = vol_cdev_llseek,
-	.read           = vol_cdev_read,
-	.write          = vol_cdev_write,
+	.read_iter      = vol_cdev_read,
+	.write_iter     = vol_cdev_write,
 	.fsync		= vol_cdev_fsync,
 	.unlocked_ioctl = vol_cdev_ioctl,
 	.compat_ioctl   = compat_ptr_ioctl,
diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index d57f52bd2ff3..2b364dd8e92e 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -325,11 +325,11 @@ void ubi_debugfs_exit(void)
 }
 
 /* Read an UBI debugfs file */
-static ssize_t dfs_file_read(struct file *file, char __user *user_buf,
-			     size_t count, loff_t *ppos)
+static ssize_t dfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	unsigned long ubi_num = (unsigned long)file->private_data;
-	struct dentry *dent = file->f_path.dentry;
+	unsigned long ubi_num = (unsigned long)iocb->ki_filp->private_data;
+	struct dentry *dent = iocb->ki_filp->f_path.dentry;
+	size_t count = iov_iter_count(to);
 	struct ubi_device *ubi;
 	struct ubi_debug_info *d;
 	char buf[16];
@@ -354,23 +354,19 @@ static ssize_t dfs_file_read(struct file *file, char __user *user_buf,
 		val = d->emulate_io_failures;
 	else if (dent == d->dfs_emulate_failures) {
 		snprintf(buf, sizeof(buf), "0x%04x\n", d->emulate_failures);
-		count = simple_read_from_buffer(user_buf, count, ppos,
-						buf, strlen(buf));
+		count = simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 		goto out;
 	} else if (dent == d->dfs_emulate_power_cut) {
 		snprintf(buf, sizeof(buf), "%u\n", d->emulate_power_cut);
-		count = simple_read_from_buffer(user_buf, count, ppos,
-						buf, strlen(buf));
+		count = simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 		goto out;
 	} else if (dent == d->dfs_power_cut_min) {
 		snprintf(buf, sizeof(buf), "%u\n", d->power_cut_min);
-		count = simple_read_from_buffer(user_buf, count, ppos,
-						buf, strlen(buf));
+		count = simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 		goto out;
 	} else if (dent == d->dfs_power_cut_max) {
 		snprintf(buf, sizeof(buf), "%u\n", d->power_cut_max);
-		count = simple_read_from_buffer(user_buf, count, ppos,
-						buf, strlen(buf));
+		count = simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 		goto out;
 	} else {
 		count = -EINVAL;
@@ -384,7 +380,7 @@ static ssize_t dfs_file_read(struct file *file, char __user *user_buf,
 	buf[1] = '\n';
 	buf[2] = 0x00;
 
-	count = simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	count = simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 
 out:
 	ubi_put_device(ubi);
@@ -392,11 +388,11 @@ static ssize_t dfs_file_read(struct file *file, char __user *user_buf,
 }
 
 /* Write an UBI debugfs file */
-static ssize_t dfs_file_write(struct file *file, const char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t dfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	unsigned long ubi_num = (unsigned long)file->private_data;
-	struct dentry *dent = file->f_path.dentry;
+	unsigned long ubi_num = (unsigned long)iocb->ki_filp->private_data;
+	struct dentry *dent = iocb->ki_filp->f_path.dentry;
+	size_t count = iov_iter_count(from);
 	struct ubi_device *ubi;
 	struct ubi_debug_info *d;
 	size_t buf_size;
@@ -409,7 +405,7 @@ static ssize_t dfs_file_write(struct file *file, const char __user *user_buf,
 	d = &ubi->dbg;
 
 	buf_size = min_t(size_t, count, (sizeof(buf) - 1));
-	if (copy_from_user(buf, user_buf, buf_size)) {
+	if (!copy_from_iter_full(buf, buf_size, from)) {
 		count = -EFAULT;
 		goto out;
 	}
@@ -467,8 +463,8 @@ static ssize_t dfs_file_write(struct file *file, const char __user *user_buf,
  * detailed_erase_block_info
  */
 static const struct file_operations dfs_fops = {
-	.read   = dfs_file_read,
-	.write  = dfs_file_write,
+	.read_iter   = dfs_file_read,
+	.write_iter  = dfs_file_write,
 	.open	= simple_open,
 	.llseek = no_llseek,
 	.owner  = THIS_MODULE,
@@ -576,7 +572,7 @@ static int eraseblk_count_release(struct inode *inode, struct file *f)
 static const struct file_operations eraseblk_count_fops = {
 	.owner = THIS_MODULE,
 	.open = eraseblk_count_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = eraseblk_count_release,
 };
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 32009a24869e..c932b1d31e6b 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -852,11 +852,11 @@ void ubi_free_volume(struct ubi_device *ubi, struct ubi_volume *vol);
 int ubi_start_update(struct ubi_device *ubi, struct ubi_volume *vol,
 		     long long bytes);
 int ubi_more_update_data(struct ubi_device *ubi, struct ubi_volume *vol,
-			 const void __user *buf, int count);
+			 struct iov_iter *from);
 int ubi_start_leb_change(struct ubi_device *ubi, struct ubi_volume *vol,
 			 const struct ubi_leb_change_req *req);
 int ubi_more_leb_change_data(struct ubi_device *ubi, struct ubi_volume *vol,
-			     const void __user *buf, int count);
+			     struct iov_iter *from);
 
 /* misc.c */
 int ubi_calc_data_len(const struct ubi_device *ubi, const void *buf,
diff --git a/drivers/mtd/ubi/upd.c b/drivers/mtd/ubi/upd.c
index 962f693cf882..6fa6e5b67631 100644
--- a/drivers/mtd/ubi/upd.c
+++ b/drivers/mtd/ubi/upd.c
@@ -253,8 +253,7 @@ static int write_leb(struct ubi_device *ubi, struct ubi_volume *vol, int lnum,
  * ubi_more_update_data - write more update data.
  * @ubi: UBI device description object
  * @vol: volume description object
- * @buf: write data (user-space memory buffer)
- * @count: how much bytes to write
+ * @from: write data (user-space memory buffer)
  *
  * This function writes more data to the volume which is being updated. It may
  * be called arbitrary number of times until all the update data arriveis. This
@@ -263,11 +262,12 @@ static int write_leb(struct ubi_device *ubi, struct ubi_volume *vol, int lnum,
  * negative error code in case of failure.
  */
 int ubi_more_update_data(struct ubi_device *ubi, struct ubi_volume *vol,
-			 const void __user *buf, int count)
+			 struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	int lnum, offs, err = 0, len, to_write = count;
 
-	dbg_gen("write %d of %lld bytes, %lld already passed",
+	dbg_gen("write %zd of %lld bytes, %lld already passed",
 		count, vol->upd_bytes, vol->upd_received);
 
 	if (ubi->ro_mode)
@@ -293,7 +293,7 @@ int ubi_more_update_data(struct ubi_device *ubi, struct ubi_volume *vol,
 		if (len > count)
 			len = count;
 
-		err = copy_from_user(vol->upd_buf + offs, buf, len);
+		err = !copy_from_iter_full(vol->upd_buf + offs, len, from);
 		if (err)
 			return -EFAULT;
 
@@ -314,7 +314,6 @@ int ubi_more_update_data(struct ubi_device *ubi, struct ubi_volume *vol,
 
 		vol->upd_received += len;
 		count -= len;
-		buf += len;
 		lnum += 1;
 	}
 
@@ -328,7 +327,7 @@ int ubi_more_update_data(struct ubi_device *ubi, struct ubi_volume *vol,
 		else
 			len = count;
 
-		err = copy_from_user(vol->upd_buf, buf, len);
+		err = !copy_from_iter_full(vol->upd_buf, len, from);
 		if (err)
 			return -EFAULT;
 
@@ -343,7 +342,6 @@ int ubi_more_update_data(struct ubi_device *ubi, struct ubi_volume *vol,
 		vol->upd_received += len;
 		count -= len;
 		lnum += 1;
-		buf += len;
 	}
 
 	ubi_assert(vol->upd_received <= vol->upd_bytes);
@@ -367,8 +365,7 @@ int ubi_more_update_data(struct ubi_device *ubi, struct ubi_volume *vol,
  * ubi_more_leb_change_data - accept more data for atomic LEB change.
  * @ubi: UBI device description object
  * @vol: volume description object
- * @buf: write data (user-space memory buffer)
- * @count: how much bytes to write
+ * @from: write data (user-space memory buffer)
  *
  * This function accepts more data to the volume which is being under the
  * "atomic LEB change" operation. It may be called arbitrary number of times
@@ -378,11 +375,12 @@ int ubi_more_update_data(struct ubi_device *ubi, struct ubi_volume *vol,
  * of failure.
  */
 int ubi_more_leb_change_data(struct ubi_device *ubi, struct ubi_volume *vol,
-			     const void __user *buf, int count)
+			     struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	int err;
 
-	dbg_gen("write %d of %lld bytes, %lld already passed",
+	dbg_gen("write %zd of %lld bytes, %lld already passed",
 		count, vol->upd_bytes, vol->upd_received);
 
 	if (ubi->ro_mode)
@@ -391,7 +389,7 @@ int ubi_more_leb_change_data(struct ubi_device *ubi, struct ubi_volume *vol,
 	if (vol->upd_received + count > vol->upd_bytes)
 		count = vol->upd_bytes - vol->upd_received;
 
-	err = copy_from_user(vol->upd_buf + vol->upd_received, buf, count);
+	err = !copy_from_iter_full(vol->upd_buf + vol->upd_received, count, from);
 	if (err)
 		return -EFAULT;
 
-- 
2.43.0


