Return-Path: <linux-kernel+bounces-141196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BAE8A1AED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C78286AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6F81FCA1F;
	Thu, 11 Apr 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qU79kmWG"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847CD1FC9F1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850192; cv=none; b=Ze5UnRNa6+Fqw5Uu2SnFz82naPG5dGOovDQi0m3Z5QPA/3bNQGBdciFGHVkYNYP45HV5ITU9yQNL5vNTgerGZ8wyLy0ueq02twiNaQqg9FhfgmSwBry6bn1A+nFKNKYdZs9d1QDRQfSkIpimO1bXtXTals6l6F69nVCUDcfosLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850192; c=relaxed/simple;
	bh=6c0bsQdUKNELtBoJ1n4BCYauIzEH/WGV3FjGySdOV98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRQjv6A9pCXsY0OnJzD7iL6eaXuP9j6Y89ygLZ8fHHjr7e+Ax7zgpDFU0G3ATio/jcbxoS/VpaONLuwU7Pnjhoyi9qxrLlVl+s1FWNPWj87dWdqX5VG0l4xM6hQBU8PElaz3adYbbfDLGmuWLusp//LzUQk85WH0vz5u6hvyG4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qU79kmWG; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58281039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850190; x=1713454990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxtsbSAsWFvgfi8sLtUfkAejAklUWuKKJB2Jeed05Ok=;
        b=qU79kmWGOe/S6kfsTPOHgQ+hkVTgaw5qLlG9oUxjRL1twzAvaJcuK5tHoh9/1k+vhu
         S0YBtMFy8uDc5+/mq6qhx9XNajRsNW4VbED9OCPU5KXx9mMmxnvOsXeFWRIeoWlhxesV
         wwf44XnkYwObkMCy0BDfbPqjjvYnN9xhDiWFbIF2gXUUo9husfzavyXKDVpAx9ChqbXl
         aSGyQ10ZHpU+W0AOw8oPaUxCO51VT1OSjEA8wjvjr0blZnEIagu4eq7PF4lcS2S5ib1L
         Xf1pN/DbrJ6gt6olf6c271rYQxZM8IPeGgZQKOwATXGNs+GNJDCht/vKrmYVNsNAQI8X
         myZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850190; x=1713454990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxtsbSAsWFvgfi8sLtUfkAejAklUWuKKJB2Jeed05Ok=;
        b=FPQDgvNLJm6axvmrzzZJjjGgW164B5YYacTiAZ5kttQz1z+uMUhJKszdRAVkFP5ndr
         K2RE5T/1E3qF+ShEPHigf4GiFD2uPx9G9Nd5pYhCMRRAvS7zZFsrI604dkSxgwc1EFBf
         KTW5YfkdJILuKC4Gq/THXVYtxR8q2OyiAbcJAxeqr61+oEs7EJ4sYaLZ3fttX9aR7QUZ
         TX1O9iOcvHndnEyfXghqg+OQY5P94AbX3YcoZ8OvqB1x/CoRP3zerJZz/OBG3My9a30z
         sP1Bqh71KtlWCXXxRcDcAct+3sJxy0whEJJ/Dkids5iQMaNT1S+WY5Kd18Eh4piSoXgE
         Pv+w==
X-Gm-Message-State: AOJu0YwfPQ3cdefvQwUkuyaR7lBu0wD5HbV6o15PrLvhUmHeMc1eua6z
	maJ0WdCSZbicrRV1NDrKRVsd0z6qzH2CyU+I5m6/FTOvdClVm6G2jMtgfWuP68Np//8De8KOZcd
	1
X-Google-Smtp-Source: AGHT+IGjHQnR0aw++p5MgoK5qszV7RixhwzJpphgI2d6YIh6DwLIJjgRDcT+WSdN0xNOZ4kQlM9cMQ==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr180967ioh.1.1712850190360;
        Thu, 11 Apr 2024 08:43:10 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 412/437] hv: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:12 -0600
Message-ID: <20240411153126.16201-413-axboe@kernel.dk>
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
 drivers/hv/hv_utils_transport.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/hv/hv_utils_transport.c b/drivers/hv/hv_utils_transport.c
index 832885198643..fa93ac3800ae 100644
--- a/drivers/hv/hv_utils_transport.c
+++ b/drivers/hv/hv_utils_transport.c
@@ -24,13 +24,13 @@ static void hvt_reset(struct hvutil_transport *hvt)
 		hvt->on_reset();
 }
 
-static ssize_t hvt_op_read(struct file *file, char __user *buf,
-			   size_t count, loff_t *ppos)
+static ssize_t hvt_op_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	struct hvutil_transport *hvt;
 	int ret;
 
-	hvt = container_of(file->f_op, struct hvutil_transport, fops);
+	hvt = container_of(iocb->ki_filp->f_op, struct hvutil_transport, fops);
 
 	if (wait_event_interruptible(hvt->outmsg_q, hvt->outmsg_len > 0 ||
 				     hvt->mode != HVUTIL_TRANSPORT_CHARDEV))
@@ -53,7 +53,7 @@ static ssize_t hvt_op_read(struct file *file, char __user *buf,
 		goto out_unlock;
 	}
 
-	if (!copy_to_user(buf, hvt->outmsg, hvt->outmsg_len))
+	if (copy_to_iter_full(hvt->outmsg, hvt->outmsg_len, to))
 		ret = hvt->outmsg_len;
 	else
 		ret = -EFAULT;
@@ -71,16 +71,16 @@ static ssize_t hvt_op_read(struct file *file, char __user *buf,
 	return ret;
 }
 
-static ssize_t hvt_op_write(struct file *file, const char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t hvt_op_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct hvutil_transport *hvt;
 	u8 *inmsg;
 	int ret;
 
-	hvt = container_of(file->f_op, struct hvutil_transport, fops);
+	hvt = container_of(iocb->ki_filp->f_op, struct hvutil_transport, fops);
 
-	inmsg = memdup_user(buf, count);
+	inmsg = iterdup(from, count);
 	if (IS_ERR(inmsg))
 		return PTR_ERR(inmsg);
 
@@ -285,8 +285,8 @@ struct hvutil_transport *hvutil_transport_init(const char *name,
 	hvt->mdev.name = name;
 
 	hvt->fops.owner = THIS_MODULE;
-	hvt->fops.read = hvt_op_read;
-	hvt->fops.write = hvt_op_write;
+	hvt->fops.read_iter = hvt_op_read;
+	hvt->fops.write_iter = hvt_op_write;
 	hvt->fops.poll = hvt_op_poll;
 	hvt->fops.open = hvt_op_open;
 	hvt->fops.release = hvt_op_release;
-- 
2.43.0


