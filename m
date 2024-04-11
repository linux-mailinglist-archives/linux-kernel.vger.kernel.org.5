Return-Path: <linux-kernel+bounces-140992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F578A19FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18DD1F28485
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182FF3D57A;
	Thu, 11 Apr 2024 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GHZQgN8m"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56851BF6D4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849873; cv=none; b=to4qiHUUSc06Pr5WWKddK4weHlKCEFfe00l387j281APkaoF3UrCtY2Yn+JE1pi5YLKCa3KJqHakc61XGJxoww9Lftg1Z9GPA85OF2k6QX4w4OI9lhvuFTMG2YSi2DPFHa1CUERSca3xX7aa54W0p9MTCVFJrtDV3fkEJai0UxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849873; c=relaxed/simple;
	bh=0J7Q2MvB635C1+FHgq8Eb2Om1kmf6vDfEm5ruRllB+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f759lWunrOSTyTiO8hUsuFEr+FZvNmKHbBvs+2jnshI4yt7aNBXaA7eZq5ukTlMEHduRyIenp5IfRMGMjDWJ9vPomw0os3bBxHf6vhebcpAgDAyuJdoWqILa/G0ziOHhWobo+/m6XTsKLuiYH30drSET0g2jExBGn6yt0S1tNpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GHZQgN8m; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8979739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849870; x=1713454670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJwtdrcwe+OoWl7LuV1eYspYqfyxpFOhMB1I5yXjxxs=;
        b=GHZQgN8mwjr474II1jcVecjVg1txWrK0Pe3NvPzYGxtWDwi2FESGrGR5478eL64AUc
         lIxVxlPLYFCaAg0g2hNwvlPfLiKFCSCVtvFubRSoM9Aw+PcYQDR1oCqEbvrHZ3WCp6Wa
         vPW5yh+sXVBQ7Y8yjR8tR6aoe/I+TvDqqtYMZHvWl3utJMXRWraQ1WE8f6fD+JBuAsdW
         J4KRkd3SIDra4u6YVRT8Mujtc+F6WRU0/L19QIRxcVYjgZDYYJQwoVL414IHJ+vzzzqI
         cJ7feb0R6LBV3zkkO3nn4F2m1Yc8tgwsCgrLkAZS78ADivgWec4H2pQxPicGYf7M9oBi
         iZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849870; x=1713454670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJwtdrcwe+OoWl7LuV1eYspYqfyxpFOhMB1I5yXjxxs=;
        b=G6ISIUCxHMwQuEG9pLeH7hEVvVJMwycJ6lCBiWGMlL/Sgv+syIpDQHAde8xUKf9HJ1
         jX2YOjfgbq4hxXNETZxFSZ4Ww1pp1fuLtQzRS2bcyXoJQksLZ4ZoOBx7YZ2Z70ReXiXE
         ESZlfkrY7PNzbr7nj3aaujVe4NV+F0t8FUCAaYmq2CPAE6UFPV2h87RJLOYMU/Bn1Xz4
         gcnDt8snunHsuiOGBQKO6YbQlhqi8g2z99txyUEeJk4gWd1ycddT0ThbqnKhV1yWpThC
         l9KVcq73GPEq6MuuSOPYa4paVh//owiqoHId1H77IJyRusJimcr41OznvCGm+LVtHefv
         DcRw==
X-Gm-Message-State: AOJu0YwKE57QSFt4D0VFHE1Hio0dse7HD7/9OzGbL4zCOadpB9iDD2+9
	rqGFyOov/ofgQ581Nd6Qc5tBcYWDYmnDEmIZT1IhqpJl+xcFPav3uatAN5YldOLDVJPnZvVvgJH
	p
X-Google-Smtp-Source: AGHT+IFBj/RoCPqgOTqQCHaUq1++Zrbd40bPVjb8YqPBndUz9s014v+utxX83MzoNRrBhe+c7S/eJg==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr226133ioh.0.1712849870666;
        Thu, 11 Apr 2024 08:37:50 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 221/437] misc: ocxl: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:01 -0600
Message-ID: <20240411153126.16201-222-axboe@kernel.dk>
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
 drivers/misc/ocxl/file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index 7eb74711ac96..09ed5f0eee8a 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -352,7 +352,7 @@ static unsigned int afu_poll(struct file *file, struct poll_table_struct *wait)
  */
 static ssize_t append_xsl_error(struct ocxl_context *ctx,
 				struct ocxl_kernel_event_header *header,
-				char __user *buf)
+				struct iov_iter *to)
 {
 	struct ocxl_kernel_event_xsl_fault_error body;
 
@@ -376,7 +376,7 @@ static ssize_t append_xsl_error(struct ocxl_context *ctx,
 
 	header->type = OCXL_AFU_EVENT_XSL_FAULT_ERROR;
 
-	if (copy_to_user(buf, &body, sizeof(body)))
+	if (!copy_to_iter(&body, sizeof(body), to))
 		return -EFAULT;
 
 	return sizeof(body);
@@ -391,11 +391,11 @@ static ssize_t append_xsl_error(struct ocxl_context *ctx,
  *	Body (struct ocxl_kernel_event_*)
  *	Header...
  */
-static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
-			loff_t *off)
+static ssize_t afu_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ocxl_context *ctx = file->private_data;
+	struct ocxl_context *ctx = iocb->ki_filp->private_data;
 	struct ocxl_kernel_event_header header;
+	size_t count = iov_iter_count(to);
 	ssize_t rc;
 	ssize_t used = 0;
 	DEFINE_WAIT(event_wait);
@@ -403,7 +403,7 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 	memset(&header, 0, sizeof(header));
 
 	/* Require offset to be 0 */
-	if (*off != 0)
+	if (iocb->ki_pos != 0)
 		return -EINVAL;
 
 	if (count < (sizeof(struct ocxl_kernel_event_header) +
@@ -420,7 +420,7 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 		if (ctx->status == CLOSED)
 			break;
 
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			finish_wait(&ctx->events_wq, &event_wait);
 			return -EAGAIN;
 		}
@@ -436,7 +436,7 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 	finish_wait(&ctx->events_wq, &event_wait);
 
 	if (has_xsl_error(ctx)) {
-		used = append_xsl_error(ctx, &header, buf + sizeof(header));
+		used = append_xsl_error(ctx, &header, to);
 		if (used < 0)
 			return used;
 	}
@@ -444,7 +444,7 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 	if (!afu_events_pending(ctx))
 		header.flags |= OCXL_KERNEL_EVENT_FLAG_LAST;
 
-	if (copy_to_user(buf, &header, sizeof(header)))
+	if (!copy_to_iter_full(&header, sizeof(header), to))
 		return -EFAULT;
 
 	used += sizeof(header);
@@ -476,7 +476,7 @@ static const struct file_operations ocxl_afu_fops = {
 	.compat_ioctl   = afu_compat_ioctl,
 	.mmap           = afu_mmap,
 	.poll           = afu_poll,
-	.read           = afu_read,
+	.read_iter      = afu_read,
 	.release        = afu_release,
 };
 
-- 
2.43.0


