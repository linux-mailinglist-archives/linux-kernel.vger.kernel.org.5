Return-Path: <linux-kernel+bounces-141140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006F28A1AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE7B1F225F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B22C1ED745;
	Thu, 11 Apr 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="E3oiHP3S"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411DC1ECE9B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850107; cv=none; b=Rr+17pu8z1WGK77CylzRplODR6yTNQGY3Wd238sSArx26j+Xvge7HesaEPz9DffTf2u1NzExHHUalZsY5KpsN3ervKq1GjEYirQTdWZ7VSf3vpfdUmYQlE6qXXpd8oQnYOhVvGFP9SkZiQuzkIykIzXZ14wQOm6Bfv7ZYuC9tSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850107; c=relaxed/simple;
	bh=erK2BM1EXWu8fh0GVCQPxgDC/O8W8kwBJDQytB0f6WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MILNC2XDD2tkFSQHnoi+qHPg2M0Vc4HzTAvUhw5oogQX5Ir1EwQxRmFxfc3zv6yDwz8c8W9SEYirr29n5GZ4e0qvSrZKU6O2oN6fM7gUJsExmcf50ED0y+W13nVMntcfaSVW/REgBQvNLr/G9K0j1AGEAE4+0bfZ9HPZZokIt9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=E3oiHP3S; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a34b68277so121235ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850105; x=1713454905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0/MNPvZYsE3TLDRaRWepSsrve407yXns6KhuDOnqm0=;
        b=E3oiHP3SfYDhASgJe+z2ltV5Bn0CqkqpJXgY5e0jsG+jFUMD9mpPG18MrAOkVu7DRT
         mxIm9Wn3OokYnYH1atGY8iEGnyRyevmn4CVSwT0gfsnth6P/mqv/HyIrq6lY6ILXQpUL
         hY6JGupCj8F7iTtfDH84Yyo6O9h/nlG/gC/M6HUHcc+aQDBZdHqqiYMsjzIZYT4L7b/Z
         k5tfuxFgxv1GbcukIL8MC0a3dsp0CNUaDe1ALF1r64JMXR6jLo0KS4hulxT2P8kz9StQ
         vFgXRqsD/ePW0LJ6UXa0Ngk4nlxUVvS9ZgpdznJ6XT2/lKiAvm5SO0mRTX0KwjvYc2Jw
         MKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850105; x=1713454905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0/MNPvZYsE3TLDRaRWepSsrve407yXns6KhuDOnqm0=;
        b=LeUxXtzeDZ96ypNXT4mpzjl/N0ZhKjhJsFiUk6NAMT8LuewV1G6gagbVmMQa31hpzA
         jjLoPX9c5I8YriPKrN3WN1NKMsy7+4rwOUcjqF8Bs67oxa9XniZx1nj1t+/iAH9Sb4Yk
         DrL0++ra0Ic3hD6D7jXOmm0uJ0bZj5IsnLfMM/nXKg2VVlMXDamJMNW2WN2UF1qlVtJJ
         NJnz8vJcXPvWvK3qSG643IDDc6ae99vZiR3hSzGFlx0YCNXPyf5nidc5n4nYcH500it2
         wlIi1vLlIj0yOmdUUIjzqB5xYNdyb8zpWBQjwwYtMHtxjnRtdBaGFBdmEJ/K10wyBI0H
         rMMw==
X-Gm-Message-State: AOJu0YwwfhebJQtkRWrg1qw/SXRls28BrTZf7mBYbjjl+RF1hor73JlG
	Swthh0IphcXBc7AG5KistnFpngZrCvKCe2cb1h71KqZxmk9e2tCJVZK/6Bp9FisNbhztandD+Qf
	c
X-Google-Smtp-Source: AGHT+IFaBsxCYQV/5GJPT46EUxKlAoKzT1TtuvBEx8YvJmGvLl1AkbHtdrf2m12HHK0iX10cDYZJ2w==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr201259iob.0.1712850105192;
        Thu, 11 Apr 2024 08:41:45 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 361/437] hwmon: mr75203: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:21 -0600
Message-ID: <20240411153126.16201-362-axboe@kernel.dk>
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
 drivers/hwmon/mr75203.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 50a8b9c3f94d..a2de0954b4e6 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -182,26 +182,24 @@ struct pvt_device {
 	u32			ip_freq;
 };
 
-static ssize_t pvt_ts_coeff_j_read(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t pvt_ts_coeff_j_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct pvt_device *pvt = file->private_data;
+	struct pvt_device *pvt = iocb->ki_filp->private_data;
 	unsigned int len;
 	char buf[13];
 
 	len = scnprintf(buf, sizeof(buf), "%d\n", pvt->ts_coeff.j);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t pvt_ts_coeff_j_write(struct file *file,
-				    const char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t pvt_ts_coeff_j_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct pvt_device *pvt = file->private_data;
+	struct pvt_device *pvt = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 
-	ret = kstrtos32_from_user(user_buf, count, 0, &pvt->ts_coeff.j);
+	ret = kstrtos32_from_iter(from, count, 0, &pvt->ts_coeff.j);
 	if (ret)
 		return ret;
 
@@ -209,8 +207,8 @@ static ssize_t pvt_ts_coeff_j_write(struct file *file,
 }
 
 static const struct file_operations pvt_ts_coeff_j_fops = {
-	.read = pvt_ts_coeff_j_read,
-	.write = pvt_ts_coeff_j_write,
+	.read_iter = pvt_ts_coeff_j_read,
+	.write_iter = pvt_ts_coeff_j_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
-- 
2.43.0


