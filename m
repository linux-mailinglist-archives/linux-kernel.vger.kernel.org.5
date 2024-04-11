Return-Path: <linux-kernel+bounces-141165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681DD8A1AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873581C21B02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A721F39FD;
	Thu, 11 Apr 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mzFPBlmW"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB2B1F466F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850147; cv=none; b=krJGxTEwkweLjgOo7DWDHJMS4vzQ6NFLvEbttSn3skXkUYIiHOI/lKN09nuGOSZzSSAdJdatqdyHtkGf5dwt7Hiw2yzVZqXzzbzERbWtQSUB9upK9kOH9QdUVBAu+3HP2RDTzSyEaAdIMdSUhB3K7wo3O6ae3junbmSXtl4LEYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850147; c=relaxed/simple;
	bh=aNu+jLadLlEy6P+YIRlQiFPKaB7BJx77FMD90tmAsuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kgbpz8BJtqvLSveDhn2jwCIYmT6XOW+0TesyhGsUUPTouTJfdobkCx7NQfuuaISumn1dPGQOfr5iQMDa7om+vDysxn/YAbSI0EjbTrZ4IXj98zBhFkJZU6315ROswezLfrvgLPILBP3asvoBKYLdIoTY5zTiOShZSrHfqLMJ2OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mzFPBlmW; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58262739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850145; x=1713454945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tEFH/u9+JWlfvIX+gNTm10LEYRS9fx7XAyz358goT0=;
        b=mzFPBlmW/ZZ6FsctVFza6qF3bISM8X3p7CKymVP1xISZMOwyYpvC2/vL2ABkCwPr0t
         TPh8USKZ4gmmMlmSUMVDu/3bYh93mpedI97gQjAsze10ueic+9A5FjfONkbpT5rVDrDP
         sNzNf0kmth9wsfB8Zwnr2C6nkLs/5YmzoLDdUheUJe8603nL5/KTeMV5dUhyDnzX0tpy
         B0GQOaQSs5fDp2vYIni9GwnPpj+duxYHNiq32bCE8d0IYHkQ1IqDNRMrpRFDTuBTRYpt
         Irs4dWzNibFzDZr1kOxuOqniXh065/I11El5PkKzreOpq4WMyRNlOqIkNoyQuyn9kpdt
         cd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850145; x=1713454945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tEFH/u9+JWlfvIX+gNTm10LEYRS9fx7XAyz358goT0=;
        b=HtKI+6A1vKfC+0HqxQHRD5lwqRKE8A2fA9dxfVCmLvNhDUv8V+fTk98g58qPrzU1C3
         AkgiyH+T/jKQgEmgU7xzUSKZdytbWOlh+Xr8pAp5dsJaVZeXSCJS54ljPxGpncCFjvdM
         tH3SekuyKAnTjpVMvVidX+NQrezds6MT9im9x25ox9ElzGw+uuPEJrlpKJtOcxnYthAC
         mlvZbuPLcQ4dswrjQuTbmSfawjD4ikzKxnJOMN41LnM4gWqANjeeKxmTHAEeF4jr25Qx
         jb0Zx2KKHNqfQlnOIgmgNBFrfzLmWrsneQw1VYYLCIw5x9QPxhjBOXHDkImVPgKmIgDY
         unMw==
X-Gm-Message-State: AOJu0Yxyha0kfoNWazUOkJTyO0eJT9alBsEMneOGLEjKNY7RMyDruVYS
	gsYQ++UJ8T1XZvepQXrbNKx7FJFtMJGku4lx67rFBeCWv6Fqm3EOmq32r2YL62+zFi5PyIIiGmg
	Q
X-Google-Smtp-Source: AGHT+IHjjhsuNDYBWtKXp//xtql/aLPERftB3oNwLJpf9sH7Tz9p8jnEM9k3J+XYBkxwqSt0TEy/4Q==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr204162iov.2.1712850145067;
        Thu, 11 Apr 2024 08:42:25 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 383/437] intel_th: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:43 -0600
Message-ID: <20240411153126.16201-384-axboe@kernel.dk>
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
 drivers/hwtracing/intel_th/msu.c | 46 +++++++++++++++-----------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 9621efe0e95c..a48d7ca8209a 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1429,8 +1429,8 @@ static struct page *msc_buffer_get_page(struct msc *msc, unsigned long pgoff)
  * @offset:	running offset
  */
 struct msc_win_to_user_struct {
-	char __user	*buf;
-	unsigned long	offset;
+	struct iov_iter	*to;
+	struct kiocb	*iocb;
 };
 
 /**
@@ -1442,11 +1442,11 @@ struct msc_win_to_user_struct {
 static unsigned long msc_win_to_user(void *data, void *src, size_t len)
 {
 	struct msc_win_to_user_struct *u = data;
-	unsigned long ret;
-
-	ret = copy_to_user(u->buf + u->offset, src, len);
-	u->offset += len - ret;
+	size_t ret;
 
+	ret = copy_to_iter(src, len, u->to);
+	if (ret > 0)
+		u->iocb->ki_pos += ret;
 	return ret;
 }
 
@@ -1483,20 +1483,20 @@ static int intel_th_msc_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t
-msc_single_to_user(struct msc *msc, char __user *buf, loff_t off, size_t len)
+static ssize_t msc_single_to_user(struct msc *msc, struct kiocb *iocb,
+				  struct iov_iter *to)
 {
+	size_t len = iov_iter_count(to);
 	unsigned long size = msc->nr_pages << PAGE_SHIFT, rem = len;
-	unsigned long start = off, tocopy = 0;
+	unsigned long start = iocb->ki_pos, tocopy = 0;
 
 	if (msc->single_wrap) {
 		start += msc->single_sz;
 		if (start < size) {
 			tocopy = min(rem, size - start);
-			if (copy_to_user(buf, msc->base + start, tocopy))
+			if (!copy_to_iter_full(msc->base + start, tocopy, to))
 				return -EFAULT;
 
-			buf += tocopy;
 			rem -= tocopy;
 			start += tocopy;
 		}
@@ -1504,7 +1504,7 @@ msc_single_to_user(struct msc *msc, char __user *buf, loff_t off, size_t len)
 		start &= size - 1;
 		if (rem) {
 			tocopy = min(rem, msc->single_sz - start);
-			if (copy_to_user(buf, msc->base + start, tocopy))
+			if (!copy_to_iter_full(msc->base + start, tocopy, to))
 				return -EFAULT;
 
 			rem -= tocopy;
@@ -1513,19 +1513,19 @@ msc_single_to_user(struct msc *msc, char __user *buf, loff_t off, size_t len)
 		return len - rem;
 	}
 
-	if (copy_to_user(buf, msc->base + start, rem))
+	if (!copy_to_iter_full(msc->base + start, rem, to))
 		return -EFAULT;
 
 	return len;
 }
 
-static ssize_t intel_th_msc_read(struct file *file, char __user *buf,
-				 size_t len, loff_t *ppos)
+static ssize_t intel_th_msc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct msc_iter *iter = file->private_data;
+	struct msc_iter *iter = iocb->ki_filp->private_data;
 	struct msc *msc = iter->msc;
+	size_t len = iov_iter_count(to);
 	size_t size;
-	loff_t off = *ppos;
+	loff_t off = iocb->ki_pos;
 	ssize_t ret = 0;
 
 	if (!atomic_inc_unless_negative(&msc->user_count))
@@ -1546,18 +1546,16 @@ static ssize_t intel_th_msc_read(struct file *file, char __user *buf,
 		len = size - off;
 
 	if (msc->mode == MSC_MODE_SINGLE) {
-		ret = msc_single_to_user(msc, buf, off, len);
+		ret = msc_single_to_user(msc, iocb, to);
 		if (ret >= 0)
-			*ppos += ret;
+			iocb->ki_pos += ret;
 	} else if (msc->mode == MSC_MODE_MULTI) {
 		struct msc_win_to_user_struct u = {
-			.buf	= buf,
-			.offset	= 0,
+			.to	= to,
+			.iocb	= iocb,
 		};
 
 		ret = msc_buffer_iterate(iter, len, &u, msc_win_to_user);
-		if (ret >= 0)
-			*ppos = iter->offset;
 	} else {
 		ret = -EINVAL;
 	}
@@ -1667,7 +1665,7 @@ static int intel_th_msc_mmap(struct file *file, struct vm_area_struct *vma)
 static const struct file_operations intel_th_msc_fops = {
 	.open		= intel_th_msc_open,
 	.release	= intel_th_msc_release,
-	.read		= intel_th_msc_read,
+	.read_iter	= intel_th_msc_read,
 	.mmap		= intel_th_msc_mmap,
 	.llseek		= no_llseek,
 	.owner		= THIS_MODULE,
-- 
2.43.0


