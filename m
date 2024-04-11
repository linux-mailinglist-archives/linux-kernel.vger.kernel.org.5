Return-Path: <linux-kernel+bounces-140998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E2D8A1A06
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292C81F284FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0271C1AFA;
	Thu, 11 Apr 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="doNXXIkE"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432B1C1255
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849880; cv=none; b=OcO5V2UvUnj9wacLZCMzobtZDY/+6ufjzjQ5v34WHhoPOW53YAZVPI+GM/dbC5+RJFXi3cF/tpzV7LSyLn/qdWawWM5TAPUnNT4HM1GrEzvcCur+kgLUK+JGOBkj2P2ZTDBw6ut7VLYxmOi6HHMw8wsDqLRtL+xTzZPSeGY4cTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849880; c=relaxed/simple;
	bh=MWdx3rz/sc91IFygSSCDHGaPSdRdKiYNqKCQ44OvdrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6VylRBexR5L0wpCyvgeTZydcdAs5CwoDbFelgNc0lGQ58giKAbM+L8cKCuh9OM+K17UpUZOAE7te1AekvIrFUGXEMUYg/efeXo4dOfm8UWa9ZOqmtWJChFLDITS/RUjwso1Qhz7INW1MxmM2Llgom1x/k0fRc/VxYKs9RJzUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=doNXXIkE; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9829539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849878; x=1713454678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n97IIU2zaCdKoY8yB2Fau470KNN6tacDcLkGNstggiw=;
        b=doNXXIkE7FA2IUyI3/BIKnlLjR1tFOJHypamEOBiJ4sJ6MyGyns7155h5DFx6mkhFd
         YqhhpOvRxxeUKbShSxqEbaaHdDGnQgUWGUbH30bsRvvwUWwxFLl2FrGPAJz2Aa23RjSz
         teW82eFNKBAlN07bkoU6krO1Uo2rKxgW/dERN4VXu+o74Nmf3IJDdSSXp645KnrXGFCN
         GKySDEQp6IaQaYoFe01bfkWJ4XV2Ee5mYhQ91BwlJLBC0RuCashrt9MQssh9u0j/vmk7
         zJxU4AGJXc6TWLZ9AhwjOcqRDjpQzUhgQBV6GCeMbeYtypLvlgJlcdkr2xmWwIEYokAp
         +Zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849878; x=1713454678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n97IIU2zaCdKoY8yB2Fau470KNN6tacDcLkGNstggiw=;
        b=nQ9lLmeGXNGz6nFjiEt0aiT8rGWuCB/O95tfHdXy2wWqRmVUgbNDpIg+LeG0waj/eS
         HWtEHDKli79QeExd488LPaRJdve5j/CJKgFTnvAFkH0USGSCjgczKUh54VGMh9AdUr6Z
         BaexkNjqtt1ZeFo4ZZQ3dAe+4nmUiftb25lDbSWAm9ArEbRipDIirB3jcdd5cU/zDrAa
         mydx1Rc8hafMkfabcD9JpUtZ81+XBj0Ludh3WLiRSP/LIQSBJ6BFJB1zcgzMUvHpg2r2
         7T9AmLi53LvqAmbz2n7/N6RyAB2B45Z1BzRysfBNOYgQ62yqCTbqF+mezSEM6qliU1cU
         Ycng==
X-Gm-Message-State: AOJu0YwZDkl3jiKHr7Usk5P+izTsx99zFg7G3MIu8RkSCe8O2ULJXnFb
	alCLeaUSCht2iWK/I2rjHZPQbuDnZnPznrTPEi8cwONguZZbMXYQW1o2rIXNls8jTeo/qkV0Gif
	J
X-Google-Smtp-Source: AGHT+IEEt7GpWqA55B96X34ugI8NwzS71hc8dTUzlAD24YEBQal9bya9EZfArtI2kAzT2mgGpC4vww==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr223226iof.0.1712849877852;
        Thu, 11 Apr 2024 08:37:57 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 226/437] drivers/misc/mei: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:06 -0600
Message-ID: <20240411153126.16201-227-axboe@kernel.dk>
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
 drivers/misc/mei/main.c | 53 ++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 79e6f3c1341f..2bab5b317b99 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -159,20 +159,19 @@ static int mei_release(struct inode *inode, struct file *file)
 /**
  * mei_read - the read function.
  *
- * @file: pointer to file structure
- * @ubuf: pointer to user buffer
- * @length: buffer length
- * @offset: data offset in buffer
+ * @iocb: metadata for IO
+ * @to: pointer to user buffer
  *
  * Return: >=0 data length on success , <0 on error
  */
-static ssize_t mei_read(struct file *file, char __user *ubuf,
-			size_t length, loff_t *offset)
+static ssize_t mei_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct mei_cl *cl = file->private_data;
 	struct mei_device *dev;
 	struct mei_cl_cb *cb = NULL;
-	bool nonblock = !!(file->f_flags & O_NONBLOCK);
+	bool nonblock = !!(iocb->ki_filp->f_flags & O_NONBLOCK);
+	size_t length = iov_iter_count(to);
 	ssize_t rets;
 
 	if (WARN_ON(!cl || !cl->dev))
@@ -192,17 +191,12 @@ static ssize_t mei_read(struct file *file, char __user *ubuf,
 		goto out;
 	}
 
-	if (ubuf == NULL) {
-		rets = -EMSGSIZE;
-		goto out;
-	}
-
 	cb = mei_cl_read_cb(cl, file);
 	if (cb)
 		goto copy_buffer;
 
-	if (*offset > 0)
-		*offset = 0;
+	if (iocb->ki_pos > 0)
+		iocb->ki_pos = 0;
 
 	rets = mei_cl_read_start(cl, length, file);
 	if (rets && rets != -EBUSY) {
@@ -245,31 +239,31 @@ static ssize_t mei_read(struct file *file, char __user *ubuf,
 	}
 
 	cl_dbg(dev, cl, "buf.size = %zu buf.idx = %zu offset = %lld\n",
-	       cb->buf.size, cb->buf_idx, *offset);
-	if (*offset >= cb->buf_idx) {
+	       cb->buf.size, cb->buf_idx, iocb->ki_pos);
+	if (iocb->ki_pos  >= cb->buf_idx) {
 		rets = 0;
 		goto free;
 	}
 
 	/* length is being truncated to PAGE_SIZE,
 	 * however buf_idx may point beyond that */
-	length = min_t(size_t, length, cb->buf_idx - *offset);
+	length = min_t(size_t, length, cb->buf_idx - iocb->ki_pos);
 
-	if (copy_to_user(ubuf, cb->buf.data + *offset, length)) {
+	if (!copy_to_iter(cb->buf.data + iocb->ki_pos, length, to)) {
 		dev_dbg(dev->dev, "failed to copy data to userland\n");
 		rets = -EFAULT;
 		goto free;
 	}
 
 	rets = length;
-	*offset += length;
+	iocb->ki_pos += length;
 	/* not all data was read, keep the cb */
-	if (*offset < cb->buf_idx)
+	if (iocb->ki_pos < cb->buf_idx)
 		goto out;
 
 free:
 	mei_cl_del_rd_completed(cl, cb);
-	*offset = 0;
+	iocb->ki_pos = 0;
 
 out:
 	cl_dbg(dev, cl, "end mei read rets = %zd\n", rets);
@@ -301,17 +295,16 @@ static u8 mei_cl_vtag_by_fp(const struct mei_cl *cl, const struct file *fp)
 /**
  * mei_write - the write function.
  *
- * @file: pointer to file structure
- * @ubuf: pointer to user buffer
- * @length: buffer length
- * @offset: data offset in buffer
+ * @iocb: metadata for IO
+ * @from: pointer to user buffer
  *
  * Return: >=0 data length on success , <0 on error
  */
-static ssize_t mei_write(struct file *file, const char __user *ubuf,
-			 size_t length, loff_t *offset)
+static ssize_t mei_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	struct file *file = iocb->ki_filp;
 	struct mei_cl *cl = file->private_data;
+	size_t length = iov_iter_count(from);
 	struct mei_cl_cb *cb;
 	struct mei_device *dev;
 	ssize_t rets;
@@ -377,7 +370,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 	}
 	cb->vtag = mei_cl_vtag_by_fp(cl, file);
 
-	rets = copy_from_user(cb->buf.data, ubuf, length);
+	rets = !copy_from_iter_full(cb->buf.data, length, from);
 	if (rets) {
 		dev_dbg(dev->dev, "failed to copy data from userland\n");
 		rets = -EFAULT;
@@ -1167,12 +1160,12 @@ ATTRIBUTE_GROUPS(mei);
  */
 static const struct file_operations mei_fops = {
 	.owner = THIS_MODULE,
-	.read = mei_read,
+	.read_iter = mei_read,
 	.unlocked_ioctl = mei_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 	.open = mei_open,
 	.release = mei_release,
-	.write = mei_write,
+	.write_iter = mei_write,
 	.poll = mei_poll,
 	.fsync = mei_fsync,
 	.fasync = mei_fasync,
-- 
2.43.0


