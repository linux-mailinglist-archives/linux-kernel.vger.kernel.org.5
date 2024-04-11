Return-Path: <linux-kernel+bounces-140945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3876F8A1A11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC96B29A37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EE720FAB8;
	Thu, 11 Apr 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YTu+tNEF"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7525120FA95
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849799; cv=none; b=ji9U7pJRHz72uWdyBcFml5lfZ7rtCPD6tdsW35UUzNkN080vIKdcMXM2ht5V11ise7+NxBXNSmlZ8usdd/ghfxIJhV7KL1L5REFhDMu+v/KxGDqc0Lck/hjRM7A+v2nIWKsBqgvNVb5mAY/AQA+ItPMHTNoistW3nb1hAIiMMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849799; c=relaxed/simple;
	bh=dyBk2apMX/ifFP/+4yS2H6tcLaTw3coX+GcPJfP+YjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQ3s3AqMxKztSytLos1IzgpCeXWVSYpJPySsFxyAJ2i/Y7peY3y01jcCLBeto84Is71MlqjYgW1rknIADgOTmztNHgw1qwoyLuNgS8ntsJ9ez6prJZtQIciFIF0I+wq3bNMpZYAzA0Vqv4Gz7mFLQWWYHl59oNbtGhzzPVe0tsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YTu+tNEF; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69578139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849797; x=1713454597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lqcg6ZDAbIKmotLYf6+iLqPjbdjurOpU09d8FxULCvI=;
        b=YTu+tNEFE2wsa1kp+JugsbhuddBlzoFDNUx0lQaQ/uM6Dpi4xEM4xqtAt1DUEa/Ir0
         mWmxzBk/Ydg3tk1MggrfaCvDeNsuNhGVd80Pa85Un6l5pRu2PmkEVkseN/LFZoCrNeRN
         Xk88QMG257tfbnO+/yS6at0fNXWyI3qJanYde8ZonkmkkMMQN2WnblNWE2VwN41YtUed
         hh8IS9Fyq+6OzQ+IYCeymkS0CZxJtEFyIa8A3DNZjfrHdskYR64uMIJHa8rk8rTRfgE7
         nqu+QkPvrD7BxO3yWX4w6eSghglnfPkPUzi6HrbGIl6kVC8vqlQ0M/MNKUi1EONvwt3b
         KPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849797; x=1713454597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lqcg6ZDAbIKmotLYf6+iLqPjbdjurOpU09d8FxULCvI=;
        b=p763CLrl7aDUNZjVQHajLSZ5YwSpqx+H5v3rvHUnmYj4xBDtqqaXAyCXcuPlFjOOfY
         uNvUjyFFSuk/k/u6UDKAXJL/OTTJEU1uyXaONs6wJWZ4y8l6AFuqQk570KNgmWvIUwa5
         wVTvd0kp4FBxHAIUhDmbYbr1gvJyEuHE3Tq2iuk8/27EHFImPaLl8b+BbPj+X30XeKwH
         DyvETkE3WBZ1Pd8OiiCMRwlTWYKbnAaJYb+GzHtCtqAByN8a/7P/3udoWrYoT/9BGRgY
         v/rF9rRiTMfmy504vCJ+AUxLJ4Uly11uYc0Dee6CReekGSMJ3qh5UPvjSrE/x4ILRQpy
         Q1Ew==
X-Gm-Message-State: AOJu0Yxf34CvwzrJ3Mv1TLSV23jWs5nSHavA2rhvrmad7OyqVgOsn/ip
	mbzsGiciJfaJAB65jc9xELGJJd+jDUuXjHvccKHLqg8OzdR0L56ETovuU1xTYzgCDjWoWWc2B/U
	2
X-Google-Smtp-Source: AGHT+IHf80KPyeEU/ju64U+CWV89mltOJW1S+O3V1TjChNaS4Udvvz2tGKlaS2VLZCzK55y6KFqftQ==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr218547iof.0.1712849797224;
        Thu, 11 Apr 2024 08:36:37 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 176/437] soc: fsl: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:16 -0600
Message-ID: <20240411153126.16201-177-axboe@kernel.dk>
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
 drivers/soc/fsl/dpaa2-console.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/fsl/dpaa2-console.c b/drivers/soc/fsl/dpaa2-console.c
index 6dbc77db7718..c0ababa17763 100644
--- a/drivers/soc/fsl/dpaa2-console.c
+++ b/drivers/soc/fsl/dpaa2-console.c
@@ -189,12 +189,12 @@ static int dpaa2_console_close(struct inode *node, struct file *fp)
 	return 0;
 }
 
-static ssize_t dpaa2_console_read(struct file *fp, char __user *buf,
-				  size_t count, loff_t *f_pos)
+static ssize_t dpaa2_console_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct console_data *cd = fp->private_data;
+	struct console_data *cd = iocb->ki_filp->private_data;
 	size_t bytes = dpaa2_console_size(cd);
 	size_t bytes_end = cd->end_addr - cd->cur_ptr;
+	size_t count = iov_iter_count(to);
 	size_t written = 0;
 	void *kbuf;
 	int err;
@@ -214,18 +214,17 @@ static ssize_t dpaa2_console_read(struct file *fp, char __user *buf,
 
 	if (bytes > bytes_end) {
 		memcpy_fromio(kbuf, cd->cur_ptr, bytes_end);
-		if (copy_to_user(buf, kbuf, bytes_end)) {
+		if (!copy_to_iter_full(kbuf, bytes_end, to)) {
 			err = -EFAULT;
 			goto err_free_buf;
 		}
-		buf += bytes_end;
 		cd->cur_ptr = cd->start_addr;
 		bytes -= bytes_end;
 		written += bytes_end;
 	}
 
 	memcpy_fromio(kbuf, cd->cur_ptr, bytes);
-	if (copy_to_user(buf, kbuf, bytes)) {
+	if (!copy_to_iter_full(kbuf, bytes, to)) {
 		err = -EFAULT;
 		goto err_free_buf;
 	}
@@ -245,7 +244,7 @@ static const struct file_operations dpaa2_mc_console_fops = {
 	.owner          = THIS_MODULE,
 	.open           = dpaa2_mc_console_open,
 	.release        = dpaa2_console_close,
-	.read           = dpaa2_console_read,
+	.read_iter      = dpaa2_console_read,
 };
 
 static struct miscdevice dpaa2_mc_console_dev = {
@@ -258,7 +257,7 @@ static const struct file_operations dpaa2_aiop_console_fops = {
 	.owner          = THIS_MODULE,
 	.open           = dpaa2_aiop_console_open,
 	.release        = dpaa2_console_close,
-	.read           = dpaa2_console_read,
+	.read_iter      = dpaa2_console_read,
 };
 
 static struct miscdevice dpaa2_aiop_console_dev = {
-- 
2.43.0


