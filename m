Return-Path: <linux-kernel+bounces-141167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB928A1ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A52F286141
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A01F4FD3;
	Thu, 11 Apr 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zR8cbVEC"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7991F4FB9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850151; cv=none; b=WLNvnl5w49MOjtHMNe+ztji01VtPSRK4o/baHB/ns1fji3JOEpSbdYEsT8A24Z17UNhzRnIeMWc4LAyBxoYMSouIl3cKCq15mMaRCEzDfHB6YvEsyYr38O15mPkZv3XhWkv+gGv/pp7ulyoCKOdL24scgR7hm7U18zp+Lg9LBYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850151; c=relaxed/simple;
	bh=yHI+BWKfxlzjtD09azAbAJ+Mhk3rpeNr2iRrEofPK/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPOd+cIMNddsofo1aDl2nM8OLDnsbjlxx+0go/2WI9MS0SC41Vf0DsWRkd0R6OMhnLItkiQfPwwqLqn7+yVydrnj/VN/xYvRcs+f4kpMgDT54EkZrwNGbkwRVnB3JT/lfaa3uoXuUYBcPnBIV1PZ9NHMr2lco4oLbitWShvdREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zR8cbVEC; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69688039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850148; x=1713454948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WprLLrhZ1kxKSEWAUekqBTwheyCz8FjrA6ZS3/IHQR0=;
        b=zR8cbVECcphIdh4xro/V8NDOPfcC9dHMBy9AwSKccVpyBswl4E2a6tA80QZWeXG/9S
         cs++PebO4bJ849sFOKrFTOYWNbdQ1354IGc40UQ5I0fqd1dzhWZ1LkwJOH/sQIatsn/L
         VXlRlNKDKYvEmxLiqqa493A+1NFV9hyevIhwHllEr2W0eI5khJSJJKqMQwV6q9AKasfC
         wJhB0wIdGA0YjPJcbqAfoQo6ulGljluafVxM3jHgX8n8VusnCfrMZTMEjujXVlGFTakM
         Z2ubj1z1HRkphfiEhV/G6OPkfoYQeuDEip5lJMu09Q+f4/xZYKxhEC19imM+m9slrGrx
         UDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850148; x=1713454948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WprLLrhZ1kxKSEWAUekqBTwheyCz8FjrA6ZS3/IHQR0=;
        b=O410ZfzRrx5H2jMjYnFVonqxmmBMYe6GvGdTzLJzySuIl193ej2Zh2Ru3oWFV7bIsZ
         L0OBnkMJYxKVqfZ22LYOJIVtg1a4hJNo1u6K2jSn2rOdBr5z7Zz8ruSwdVGc6kb9zE2O
         uZsz+4AJoWRkviuqb6308UhF467nQ+oL34aCnSE0O70aAOADrY6mUwxvwco/Ll+f3GRs
         pHB9A7KgwJIc3rFcq3r6+eM6+hvmyMwPz0DJMLkgZ4WfgJhzdK8Ju5TB5L1cSamlvXuT
         gRpyVQwQa+32IyAKXH7WmIp2MAtzH9yOtakPlDDc10Q6ZVDRPjPQ1bmY5lLZDb+yl3vU
         PJGw==
X-Gm-Message-State: AOJu0YwXelYfZ8yufLXjtlq5nH+dbjWHaQWhqy/iHf0ifptROvK1Yfw2
	oUSWsN96bM0BtcPa8JVOiQ3fMasYVJXEnbWvIHdhZ+GThXUeDMxfJJGqOXZyP9aKWVa0rgpQzMX
	E
X-Google-Smtp-Source: AGHT+IFueRfS9bGXz/c5C96P9J6ykQa1ovLOhtEUXogObPI/65tXV/zTNeHvMFSz/IW7zUbUSHBc4A==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr55388iob.2.1712850146799;
        Thu, 11 Apr 2024 08:42:26 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 384/437] stm class: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:44 -0600
Message-ID: <20240411153126.16201-385-axboe@kernel.dk>
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
 drivers/hwtracing/stm/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 534fbefc7f6a..c66f1864adcd 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -615,11 +615,11 @@ stm_write(struct stm_device *stm, struct stm_output *output,
 	return err;
 }
 
-static ssize_t stm_char_write(struct file *file, const char __user *buf,
-			      size_t count, loff_t *ppos)
+static ssize_t stm_char_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct stm_file *stmf = file->private_data;
+	struct stm_file *stmf = iocb->ki_filp->private_data;
 	struct stm_device *stm = stmf->stm;
+	size_t count = iov_iter_count(from);
 	char *kbuf;
 	int err;
 
@@ -649,7 +649,7 @@ static ssize_t stm_char_write(struct file *file, const char __user *buf,
 	if (!kbuf)
 		return -ENOMEM;
 
-	err = copy_from_user(kbuf, buf, count);
+	err = !copy_from_iter_full(kbuf, count, from);
 	if (err) {
 		kfree(kbuf);
 		return -EFAULT;
@@ -835,7 +835,7 @@ stm_char_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 static const struct file_operations stm_fops = {
 	.open		= stm_char_open,
 	.release	= stm_char_release,
-	.write		= stm_char_write,
+	.write_iter	= stm_char_write,
 	.mmap		= stm_char_mmap,
 	.unlocked_ioctl	= stm_char_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
-- 
2.43.0


