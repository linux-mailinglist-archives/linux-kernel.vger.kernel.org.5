Return-Path: <linux-kernel+bounces-141147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCE98A1AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6364E1F23E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471B81EF509;
	Thu, 11 Apr 2024 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2HZvsMGk"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BF31EECAB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850117; cv=none; b=ViqbNK97ZkNSaVfJHU5RNNBg34pu3VIvUmJU0ZqscICb3pjHwvYbuPS3TsDvgJn5C3EjFs+mPqKvjm8BvyBijB+CaCT6FNZJziNRnFTR2ptOgU3AG0fkHzUoKC3nx9/tZNKY7xQmnOp5WcK8Lb47EPhIYhpcnJrbnHkPlf8E1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850117; c=relaxed/simple;
	bh=y59MzRpX118ustdZIEz22Rwf88iXR2a6PZXY50jryVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qs/8/PQldc9L7AhuzRkdIIFHARUfC+wv1/dkmbqi0X+x79SxWvmFFALIBHrCzTuEo5tDaa5lbHbOl9lsya5Tx28unTNLBzRxyoYRPEU0RLKSSmUSDrYvTUw3iq+KGJ1a6f38OCwKYS3GG/sh/q8tI6YS8qnp1u5sUcH8m8AK2B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2HZvsMGk; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69680239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850115; x=1713454915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oA14u6pH0QLWbvdHYR0iPO+22zrCROZFLdY7s2QKWXU=;
        b=2HZvsMGk4KJyXcRBAEYk/wL8nkRZDDW+bRCWl2ADqG4p634f7bJmumn/6lh7iGbpjT
         OzA50X4CnqBXLbPILKhcIHK/aOVLIYunXXgm2qccsOMVA6mUTvLwwY13GGHQ5JXQXiZd
         qiYNLYGCqOct/lhxNYQsL6EUq/fWlBNCo5WCSdo56Tqd8ImDtR2eigKpscPaPefFBzIi
         LfmNMmr4Lwbe5uvbxy9lhezXPk3K70XzdWu3pk+QPa+GRBjnzLiGSjGShCyd2fiiwXgw
         8Odmkf8ouwsN32H1lkgPFCxbnUS1TedkdRDHl+YU2iucKAPTyC/JXyU7bTIyz36RZEqr
         F3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850115; x=1713454915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oA14u6pH0QLWbvdHYR0iPO+22zrCROZFLdY7s2QKWXU=;
        b=WJlagOGRWJ+4vuCudN/xKkFYFxJOF8wWammG2qb5yJPzX63x+7ZDYaEywEs7DerLAJ
         S8x7PkVt5NE3b20+m6TOjV5HfqjXmaAw1478Wl791MQaL5XBc8l7TBQ0Cm/62YvKI3k5
         vx2jZpIHEd/VwHCs+8c8kMZRGCLLYGHFVY6QqqKh/nIYoN+leto5fyn1JLqZCQ2/dAer
         s7gABzlxqf2lHNpjjoGXXRksWIkBmD49c4zYEZdPSsBGzXAV/Ke6ReLFrchWdp4Lbc8o
         Mk3DxWNuro+WOapvQeMNT9w48cvwnezuQQXN2xmhFIYMQDvILzj2L349m92D5D3aal0/
         4QGA==
X-Gm-Message-State: AOJu0Yzdp0CpxwQw/peSEJg2t6ThVoMz0chm/rCyX10SsuX92x7zf1U+
	tdj2DkoX6a9SUbYmrFLmbGAjuKh+Kf43dWobvCy8NweChqYxxWwbdE/suO4Z2pycJLRCGyoOjH2
	4
X-Google-Smtp-Source: AGHT+IFwSfB0/78vsfTpCy/J098dnlsSEN1qTqWzABRe70udhwPXHqvMHltr0pyB4IJoQUf3sy+oLA==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr207975iop.1.1712850114864;
        Thu, 11 Apr 2024 08:41:54 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 366/437] hwmon: q54sj108a2: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:26 -0600
Message-ID: <20240411153126.16201-367-axboe@kernel.dk>
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
 drivers/hwmon/pmbus/q54sj108a2.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
index a235c1cdf4fe..12634ede2c50 100644
--- a/drivers/hwmon/pmbus/q54sj108a2.c
+++ b/drivers/hwmon/pmbus/q54sj108a2.c
@@ -70,11 +70,10 @@ static struct pmbus_driver_info q54sj108a2_info[] = {
 	},
 };
 
-static ssize_t q54sj108a2_debugfs_read(struct file *file, char __user *buf,
-				       size_t count, loff_t *ppos)
+static ssize_t q54sj108a2_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int rc;
-	int *idxp = file->private_data;
+	int *idxp = iocb->ki_filp->private_data;
 	int idx = *idxp;
 	struct q54sj108a2_data *psu = to_psu(idxp, idx);
 	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
@@ -169,18 +168,18 @@ static ssize_t q54sj108a2_debugfs_read(struct file *file, char __user *buf,
 	data[rc] = '\n';
 	rc += 2;
 
-	return simple_read_from_buffer(buf, count, ppos, data, rc);
+	return simple_copy_to_iter(data, &iocb->ki_pos, rc, to);
 }
 
-static ssize_t q54sj108a2_debugfs_write(struct file *file, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t q54sj108a2_debugfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	u8 flash_key[4];
 	u8 dst_data;
 	ssize_t rc;
-	int *idxp = file->private_data;
+	int *idxp = iocb->ki_filp->private_data;
 	int idx = *idxp;
 	struct q54sj108a2_data *psu = to_psu(idxp, idx);
+	size_t count = iov_iter_count(from);
 
 	rc = i2c_smbus_write_byte_data(psu->client, PMBUS_WRITE_PROTECT, 0);
 	if (rc)
@@ -188,7 +187,7 @@ static ssize_t q54sj108a2_debugfs_write(struct file *file, const char __user *bu
 
 	switch (idx) {
 	case Q54SJ108A2_DEBUGFS_OPERATION:
-		rc = kstrtou8_from_user(buf, count, 0, &dst_data);
+		rc = kstrtou8_from_iter(from, count, 0, &dst_data);
 		if (rc < 0)
 			return rc;
 
@@ -218,7 +217,7 @@ static ssize_t q54sj108a2_debugfs_write(struct file *file, const char __user *bu
 
 		break;
 	case Q54SJ108A2_DEBUGFS_VOOV_RESPONSE:
-		rc = kstrtou8_from_user(buf, count, 0, &dst_data);
+		rc = kstrtou8_from_iter(from, count, 0, &dst_data);
 		if (rc < 0)
 			return rc;
 
@@ -228,7 +227,7 @@ static ssize_t q54sj108a2_debugfs_write(struct file *file, const char __user *bu
 
 		break;
 	case Q54SJ108A2_DEBUGFS_IOOC_RESPONSE:
-		rc = kstrtou8_from_user(buf, count, 0, &dst_data);
+		rc = kstrtou8_from_iter(from, count, 0, &dst_data);
 		if (rc < 0)
 			return rc;
 
@@ -244,7 +243,7 @@ static ssize_t q54sj108a2_debugfs_write(struct file *file, const char __user *bu
 
 		break;
 	case Q54SJ108A2_DEBUGFS_BLACKBOX_SET_OFFSET:
-		rc = kstrtou8_from_user(buf, count, 0, &dst_data);
+		rc = kstrtou8_from_iter(from, count, 0, &dst_data);
 		if (rc < 0)
 			return rc;
 
@@ -262,8 +261,8 @@ static ssize_t q54sj108a2_debugfs_write(struct file *file, const char __user *bu
 
 static const struct file_operations q54sj108a2_fops = {
 	.llseek = noop_llseek,
-	.read = q54sj108a2_debugfs_read,
-	.write = q54sj108a2_debugfs_write,
+	.read_iter = q54sj108a2_debugfs_read,
+	.write_iter = q54sj108a2_debugfs_write,
 	.open = simple_open,
 };
 
-- 
2.43.0


