Return-Path: <linux-kernel+bounces-141076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D773F8A1A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6650C1F2744B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3D21D6386;
	Thu, 11 Apr 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Hf10zh8d"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D31D7811
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850005; cv=none; b=SHLTbRnV0tqsWHZsI/IULjBt3HoQdhDYbCisidakFexF8d8dIl5LOGrRWKJ0+CUTi5KKjMw82OKOwC6TtlyTnDDOJ23Jw5AbdXaVNtRIMb6uXd67l6U1XKfU7K65wsIRRODswTZlQz5AvRXY437+A9GA4o5rRbenu2EwDNpzccY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850005; c=relaxed/simple;
	bh=IPrP+cE2axHvqXnrSIZipP5xO1MrQzdDIIUpapITT0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFKvU3TjUWpsgROTpYUJG+TWf/u2URYkTA382yWbH+Qi1/+B/yOOS/Zkv2cJls0u8NDieg/kCgSAZlzHoMpbwae2rXrjmLfkP0xbUKFePAy8yI+dwG/gspndtvxZI7L4cSFGOHJVk/2PRjvgfisSsRJMY/6sbXBpQ70/gF3I804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Hf10zh8d; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69647039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850001; x=1713454801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRVEqZuKkvquICX1CJ1Ou2maDurlGxTuFPytSBLP/g4=;
        b=Hf10zh8dN+0n1nf9k2XZ0kqNi9NZHIWbli6WcGTBzXBfvqmCUZss6NYMQj+s4ijtJ0
         B3koXevvr9YzktcIl7SSPVK70N2YGvAlhHzcbAuFz2JiXEAUH/I7yzRBF/KR1XmH5p1t
         O2Q9JbfA962FI4doDg5t5/nD4Tdk2NI35lIoTVLZ+IaafCDS/CdcgpByTAstXnw8Y5gR
         eJ2k2kOiDGhraS/R7qLf+0GRFnsKkAyUAIFqrfflUQKqLL8KImVKtMaSVqA1HcE9OpWC
         dMuRXU5C+Er09Wy7UVtR8a88/Ymvq/Mt7lS5EqGsyuJRW8hD9jbQO2ij1f1iYh6foeMK
         MXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850001; x=1713454801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRVEqZuKkvquICX1CJ1Ou2maDurlGxTuFPytSBLP/g4=;
        b=h+ulfRW/vK7pyDUWDa4DBSPAcrSRKYdRhyPRSzrRVziJE4zcpnC/LvCOgp2c9HutE2
         ue7L9kVdZ9FIZUfMArrXS1sllMzm1tEUBpmL8O4enfjcqsxh1UsoR+oKzOKbr9prygCQ
         lfCxh6MWdaSsEp9jDfNeO258vA3mzF7V28Z4xLLKrCXvic2mILYg8ypSTLrlGDag8o1p
         VdgRrZeW+7ab5NEOl9Jsy+5GQ0pdw4gCtPGKP16IpdGbN5gUnqu0AermxvQrU6be02NS
         DRc3W3vbE7gssOO/Q7b+sUFRlxP0VR9miwyygc+b98spsUtuaTwDjQPPtU8GugE/hcA+
         L2UA==
X-Gm-Message-State: AOJu0YzcQpxJjfJ+tvSHAuLhCEfxJoxrNkBryfPisGVSp8BXqev/ANUT
	emkYwWRlNXlOXoxC6gAh10gterVCiG4/Pz46FCzXm3JhnrMtKphfeGLszHLTXfVXYfEC392AAGe
	J
X-Google-Smtp-Source: AGHT+IGl1pPTyFIzZldUrR25WxHkRKBwK2rRPZicOkCKBd6KYoGFzHGg+XhTJEiVrImE0aeiKeKm4g==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr50534iob.2.1712850000801;
        Thu, 11 Apr 2024 08:40:00 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 300/437] drivers/net/wireless/ath/carl9170: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:20 -0600
Message-ID: <20240411153126.16201-301-axboe@kernel.dk>
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
 drivers/net/wireless/ath/carl9170/debug.c | 25 +++++++++++------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/debug.c b/drivers/net/wireless/ath/carl9170/debug.c
index bb40889d7c72..1116f7c8ef61 100644
--- a/drivers/net/wireless/ath/carl9170/debug.c
+++ b/drivers/net/wireless/ath/carl9170/debug.c
@@ -59,10 +59,10 @@ struct carl9170_debugfs_fops {
 	enum carl9170_device_state req_dev_state;
 };
 
-static ssize_t carl9170_debugfs_read(struct file *file, char __user *userbuf,
-				     size_t count, loff_t *ppos)
+static ssize_t carl9170_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct carl9170_debugfs_fops *dfops;
+	size_t count = iov_iter_count(to);
 	struct ar9170 *ar;
 	char *buf = NULL, *res_buf = NULL;
 	ssize_t ret = 0;
@@ -71,11 +71,11 @@ static ssize_t carl9170_debugfs_read(struct file *file, char __user *userbuf,
 	if (!count)
 		return 0;
 
-	ar = file->private_data;
+	ar = iocb->ki_filp->private_data;
 
 	if (!ar)
 		return -ENODEV;
-	dfops = container_of(debugfs_real_fops(file),
+	dfops = container_of(debugfs_real_fops(iocb->ki_filp),
 			     struct carl9170_debugfs_fops, fops);
 
 	if (!dfops->read)
@@ -97,8 +97,7 @@ static ssize_t carl9170_debugfs_read(struct file *file, char __user *userbuf,
 	res_buf = dfops->read(ar, buf, dfops->read_bufsize, &ret);
 
 	if (ret > 0)
-		err = simple_read_from_buffer(userbuf, count, ppos,
-					      res_buf, ret);
+		err = simple_copy_to_iter(res_buf, &iocb->ki_pos, ret, to);
 	else
 		err = ret;
 
@@ -110,10 +109,10 @@ static ssize_t carl9170_debugfs_read(struct file *file, char __user *userbuf,
 	return err;
 }
 
-static ssize_t carl9170_debugfs_write(struct file *file,
-	const char __user *userbuf, size_t count, loff_t *ppos)
+static ssize_t carl9170_debugfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct carl9170_debugfs_fops *dfops;
+	size_t count = iov_iter_count(from);
 	struct ar9170 *ar;
 	char *buf = NULL;
 	int err = 0;
@@ -124,11 +123,11 @@ static ssize_t carl9170_debugfs_write(struct file *file,
 	if (count > PAGE_SIZE)
 		return -E2BIG;
 
-	ar = file->private_data;
+	ar = iocb->ki_filp->private_data;
 
 	if (!ar)
 		return -ENODEV;
-	dfops = container_of(debugfs_real_fops(file),
+	dfops = container_of(debugfs_real_fops(iocb->ki_filp),
 			     struct carl9170_debugfs_fops, fops);
 
 	if (!dfops->write)
@@ -138,7 +137,7 @@ static ssize_t carl9170_debugfs_write(struct file *file,
 	if (!buf)
 		return -ENOMEM;
 
-	if (copy_from_user(buf, userbuf, count)) {
+	if (!copy_from_iter_full(buf, count, from)) {
 		err = -EFAULT;
 		goto out_free;
 	}
@@ -175,8 +174,8 @@ static const struct carl9170_debugfs_fops carl_debugfs_##name ##_ops = {\
 	.req_dev_state = _dstate,					\
 	.fops = {							\
 		.open	= simple_open,					\
-		.read	= carl9170_debugfs_read,			\
-		.write	= carl9170_debugfs_write,			\
+		.read_iter	= carl9170_debugfs_read,		\
+		.write_iter	= carl9170_debugfs_write,		\
 		.owner	= THIS_MODULE					\
 	},								\
 }
-- 
2.43.0


