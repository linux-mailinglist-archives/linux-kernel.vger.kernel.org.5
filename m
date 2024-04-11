Return-Path: <linux-kernel+bounces-141164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D828A1AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41319286183
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631921F467E;
	Thu, 11 Apr 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ctVuKTKt"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C91F4663
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850146; cv=none; b=QXD6dAjtRUqQkUkT30tPhoIl0sby+ZRO2LvJU6Yxr9lHr75dZjoVfhD3wSRwxnfhrtfojhnFrGynjyiJPLQCK51HhFrjHtjWxLH7apvsImAf9vMCbn7UChshkF3nwPUTp2Xype1EFM2Mno0d6tFxJTQjTjLlUuDFtHUrRz8o0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850146; c=relaxed/simple;
	bh=IDGb24kMGja+j+TYx75TYQo8/QmrAkf6f7BvaTCpkJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuAXgXleJ81wExqROXJJy/rGXJlr6sHsAf+iFxBuzH3AaVtH7m5EV1+MOrQ8OpWAxMfebfKhWkrmaKOWYKy+uDD3QDQ2R4heQ8pERZy45v6wZ5jP1EuEM4IcjUAUpnjXTH4gkh7D8GDvfVC82IF9bzvb5B9bp63SyYtQ225/0ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ctVuKTKt; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16257439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850143; x=1713454943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbYgBuBD3bA17O2i940OxA+oPiB7duhWuBNJGzGmG5Q=;
        b=ctVuKTKtUZOzIYmwVFjCD9qQssb4/A/S1ij1IPisj0Z0N6t3STGssCuU8RCwSjl/3N
         ryu75sgbH2FNJenuJBgy67mAdj1KR5+Swp915Y/3Ob2TIjU2opnxnorj/YQ1ZPrFbZo4
         Xv5DNDiSTSCFEqixO7IYYJ99ja+8FwdDy1+d4P3sqBEY3LOparCnK/FHCd699J5D7yEW
         +pfFFhB1zDzuyEMqBpTq2NsoPSYcjq6mvGyrbEs5GB0YhHEMLRnsoEkeGJNzpVyyqfKJ
         DTKE1vOM8vnEbkhcCEu9NFfqNgC+lMQmQJVKJSuNLVEqiO/zDtgSb52SPa4A5mQib/Td
         vXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850143; x=1713454943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbYgBuBD3bA17O2i940OxA+oPiB7duhWuBNJGzGmG5Q=;
        b=U2pdQo16+ltnuirp3FGmEfXHobAfGyEGFDp3tFZW4+we207PVZzBN9AdCgdoPpqo1l
         x2IfNjWfRnMdVBECnvIzhdHos9nJdo7zIctyDX8ySymybBtDo2PAMdO/lRYg8JrbvPth
         gS7BwTgO27i8n5m+eaWYEDJke6uIL0kVt8mzJ7dnnox1uAeucsnFMRRUG1aiDL+Wj+wm
         Mnf9WIyQa7ida7ivq3iJrBI5BWJwCbU+qCJ8q1Je0xA6pPfuVI+KozROxwAmB9bcUelA
         mVag0YmzBo0zaAjxQQLUX9hA/JYkg/js+LdMtDgForZ/EUZbh2Ds/Xy3JfuAXYmw8qFp
         rkxw==
X-Gm-Message-State: AOJu0Ywd+6YTtJQQAW5KPGl8lenax1bIVH9+HEpOX5qi+rM6yUhAS9+R
	pgNMpnrzFipj2PbLqJEFaQ2VMqkND0nzn11QWa1sLYjkAzIjDha8BBCUDJ6+OIGwKGEyadYdjjD
	g
X-Google-Smtp-Source: AGHT+IEPG2nviL1dv0eaGbUj+JW4+fUGlyVL2WLWEq+0KCLVnZ+UNRqojL1BCJKTKmrAeLP+mGxaVQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr204082iov.2.1712850143311;
        Thu, 11 Apr 2024 08:42:23 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 382/437] iio: gyro/adis16136: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:42 -0600
Message-ID: <20240411153126.16201-383-axboe@kernel.dk>
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
 drivers/iio/gyro/adis16136.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index c95cf41be34b..3fa17f582444 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -65,10 +65,9 @@ struct adis16136 {
 
 #ifdef CONFIG_DEBUG_FS
 
-static ssize_t adis16136_show_serial(struct file *file,
-		char __user *userbuf, size_t count, loff_t *ppos)
+static ssize_t adis16136_show_serial(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct adis16136 *adis16136 = file->private_data;
+	struct adis16136 *adis16136 = iocb->ki_filp->private_data;
 	uint16_t lot1, lot2, lot3, serial;
 	char buf[20];
 	size_t len;
@@ -94,12 +93,12 @@ static ssize_t adis16136_show_serial(struct file *file,
 	len = snprintf(buf, sizeof(buf), "%.4x%.4x%.4x-%.4x\n", lot1, lot2,
 		lot3, serial);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations adis16136_serial_fops = {
 	.open = simple_open,
-	.read = adis16136_show_serial,
+	.read_iter = adis16136_show_serial,
 	.llseek = default_llseek,
 	.owner = THIS_MODULE,
 };
-- 
2.43.0


