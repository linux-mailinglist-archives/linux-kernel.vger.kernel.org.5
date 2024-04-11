Return-Path: <linux-kernel+bounces-140990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD28A1A07
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3CCEB2D780
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E401BF6F5;
	Thu, 11 Apr 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vmfFPwWU"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432131BF6DD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849871; cv=none; b=W7Y0TgxRQ0ib/3l5wmj1W3TGV8G4HlIuPiIGEj2dEjg5JKojKUxsp2EsGQhiYw2ex7Kv9/Tqk+9Vg2qVPZskouuA9RS2Tcv7OwA6s6vuDQ5jNPtMmNdQ6Fc8rsN/2m3OhFCoF5MJs6wyrAJ6lI281LUWsQN4hv0GlQKkhEDV8bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849871; c=relaxed/simple;
	bh=Vz6vYIbHFmvE5P5GLeQq8JWnIBczfO2XcZE527zR1EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKoI64SncUm0OpIVC+nuDxXkn83uuwZ+zKhLEREByNxYw/r8QkL7jmGUtvVXPn/qhU9GbbabxfHhiDkWHVzAKk99JWrOr1StuA4WLP575QwuEFz/mxcjRe7Skv2Z6p0rqfANoJI1ve4FvI9p2nm+x8+7vQ8mYSCfGpW+kbB+7Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vmfFPwWU; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36a224d7414so186375ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849869; x=1713454669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7jqrmre/JH0aJ6hz13hdPTdjED5/S1D26qp0iqqT6Q=;
        b=vmfFPwWUMc8h9CDcC7i5ON8/SXnxL888FzqN784vmj0XXcivNwj880AZXYEUWqOUBw
         Ov/0rM02im03WH6eOsdabGL/R78egWWyuTsr7PvVqKCas1Dohp++gH8CYdtKlOH0jrMN
         qkTOuKpSMeRVqJX/itL7a9EUvXZTpUGIvsQqtjMErf5g1mrQiOit0ofmhrm1fUSGrk/u
         bZBvC5iUWeXl54L5dUqjWEjuCwv/+l5YvWkgCsCsUKuQ/w2bmOkU37St+QbERN3nxMs7
         pR05ye72mN5sDYwKz9PPT5SLYbfK0xmyb7zMEJ6G49W+l33G1TUcGcOGmjgdt8ajdMTC
         dTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849869; x=1713454669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7jqrmre/JH0aJ6hz13hdPTdjED5/S1D26qp0iqqT6Q=;
        b=HuYX9njyASQruemTQmwEBdhtlZycN1+djBOCqVRztONnp3Pky9ABBWyDt7F4EgUmbe
         BkVNcTa3iVhyJDuI5seffgn3yMnjjStKhO5qMUBi3i6YI+LqB0xQ+laJgbAqYPrfYmM4
         eY0ET067pP8IQzT2NBgl5JLb2s/KZ/LpJXwXcRNnQnooGJ9SG79RBFR1KTL7rZt+DMcS
         nHwRVe5uoVTZ2YSx0I1+cYbF9Cxd9q4JOlVRNWCdBAG1axbTZpHGOK8X9ubqNNedAyt5
         sK76/vvte+f03k30GnaQvLiO6dWWCdAM1dbGbc4AHOnxMWLl77cdbJg8F2QZARJEkUgW
         AO/w==
X-Gm-Message-State: AOJu0Yxoq8CYivrbjd2RuVYRYj2Rt+4mY85H0pXKNqNmWmEhOifQvsWw
	goEBt+OYUVzV+qrXzNviibThaOuuC9Me4pB6sWK6bftIReJXhTxkoMs39vGDJdmNcEjUEanGZU3
	I
X-Google-Smtp-Source: AGHT+IHGyjzpCpmpERvO+y1YG62BhKCqPdd3pDVquqdAN1vOiKsyChQGg38rkfuT2lP4pO7AkQYogA==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr192068iob.1.1712849869060;
        Thu, 11 Apr 2024 08:37:49 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 220/437] misc: cxl: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:00 -0600
Message-ID: <20240411153126.16201-221-axboe@kernel.dk>
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
 drivers/misc/cxl/api.c  |  7 +++----
 drivers/misc/cxl/cxl.h  |  2 +-
 drivers/misc/cxl/file.c | 23 +++++++++++------------
 include/misc/cxl.h      |  3 +--
 4 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index d85c56530863..54e1f5b917e2 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -375,10 +375,9 @@ __poll_t cxl_fd_poll(struct file *file, struct poll_table_struct *poll)
 	return afu_poll(file, poll);
 }
 EXPORT_SYMBOL_GPL(cxl_fd_poll);
-ssize_t cxl_fd_read(struct file *file, char __user *buf, size_t count,
-			loff_t *off)
+ssize_t cxl_fd_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return afu_read(file, buf, count, off);
+	return afu_read(iocb, to);
 }
 EXPORT_SYMBOL_GPL(cxl_fd_read);
 
@@ -410,7 +409,7 @@ struct file *cxl_get_fd(struct cxl_context *ctx, struct file_operations *fops,
 	if (fops) {
 		PATCH_FOPS(open);
 		PATCH_FOPS(poll);
-		PATCH_FOPS(read);
+		PATCH_FOPS(read_iter);
 		PATCH_FOPS(release);
 		PATCH_FOPS(unlocked_ioctl);
 		PATCH_FOPS(compat_ioctl);
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 6ad0ab892675..6b6738b28f69 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -1045,7 +1045,7 @@ int afu_release(struct inode *inode, struct file *file);
 long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int afu_mmap(struct file *file, struct vm_area_struct *vm);
 __poll_t afu_poll(struct file *file, struct poll_table_struct *poll);
-ssize_t afu_read(struct file *file, char __user *buf, size_t count, loff_t *off);
+ssize_t afu_read(struct kiocb *iocb, struct iov_iter *to);
 extern const struct file_operations afu_fops;
 
 struct cxl *cxl_guest_init_adapter(struct device_node *np, struct platform_device *dev);
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 012e11b959bc..c911bd785f26 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -385,7 +385,7 @@ __poll_t afu_poll(struct file *file, struct poll_table_struct *poll)
 }
 
 static ssize_t afu_driver_event_copy(struct cxl_context *ctx,
-				     char __user *buf,
+				     struct iov_iter *to,
 				     struct cxl_event *event,
 				     struct cxl_event_afu_driver_reserved *pl)
 {
@@ -403,14 +403,13 @@ static ssize_t afu_driver_event_copy(struct cxl_context *ctx,
 	}
 
 	/* Copy event header */
-	if (copy_to_user(buf, event, sizeof(struct cxl_event_header))) {
+	if (!copy_to_iter_full(event, sizeof(struct cxl_event_header), to)) {
 		ctx->afu_driver_ops->event_delivered(ctx, pl, -EFAULT);
 		return -EFAULT;
 	}
 
 	/* Copy event data */
-	buf += sizeof(struct cxl_event_header);
-	if (copy_to_user(buf, &pl->data, pl->data_size)) {
+	if (!copy_to_iter_full(&pl->data, pl->data_size, to)) {
 		ctx->afu_driver_ops->event_delivered(ctx, pl, -EFAULT);
 		return -EFAULT;
 	}
@@ -419,11 +418,11 @@ static ssize_t afu_driver_event_copy(struct cxl_context *ctx,
 	return event->header.size;
 }
 
-ssize_t afu_read(struct file *file, char __user *buf, size_t count,
-			loff_t *off)
+ssize_t afu_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct cxl_context *ctx = file->private_data;
+	struct cxl_context *ctx = iocb->ki_filp->private_data;
 	struct cxl_event_afu_driver_reserved *pl = NULL;
+	size_t count = iov_iter_count(to);
 	struct cxl_event event;
 	unsigned long flags;
 	int rc;
@@ -447,7 +446,7 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 			goto out;
 		}
 
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			rc = -EAGAIN;
 			goto out;
 		}
@@ -505,9 +504,9 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 	spin_unlock_irqrestore(&ctx->lock, flags);
 
 	if (event.header.type == CXL_EVENT_AFU_DRIVER)
-		return afu_driver_event_copy(ctx, buf, &event, pl);
+		return afu_driver_event_copy(ctx, to, &event, pl);
 
-	if (copy_to_user(buf, &event, event.header.size))
+	if (!copy_to_iter_full(&event, event.header.size, to))
 		return -EFAULT;
 	return event.header.size;
 
@@ -525,7 +524,7 @@ const struct file_operations afu_fops = {
 	.owner		= THIS_MODULE,
 	.open           = afu_open,
 	.poll		= afu_poll,
-	.read		= afu_read,
+	.read_iter	= afu_read,
 	.release        = afu_release,
 	.unlocked_ioctl = afu_ioctl,
 	.compat_ioctl   = afu_compat_ioctl,
@@ -536,7 +535,7 @@ static const struct file_operations afu_master_fops = {
 	.owner		= THIS_MODULE,
 	.open           = afu_master_open,
 	.poll		= afu_poll,
-	.read		= afu_read,
+	.read_iter	= afu_read,
 	.release        = afu_release,
 	.unlocked_ioctl = afu_ioctl,
 	.compat_ioctl   = afu_compat_ioctl,
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index d8044299d654..3758f9c8f83f 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -196,8 +196,7 @@ int cxl_fd_release(struct inode *inode, struct file *file);
 long cxl_fd_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int cxl_fd_mmap(struct file *file, struct vm_area_struct *vm);
 __poll_t cxl_fd_poll(struct file *file, struct poll_table_struct *poll);
-ssize_t cxl_fd_read(struct file *file, char __user *buf, size_t count,
-			   loff_t *off);
+ssize_t cxl_fd_read(struct kiocb *iocb, struct iov_iter *to);
 
 /*
  * For EEH, a driver may want to assert a PERST will reload the same image
-- 
2.43.0


