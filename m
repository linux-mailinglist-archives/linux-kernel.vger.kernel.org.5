Return-Path: <linux-kernel+bounces-141104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9413D8A1ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6C5B2B88F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC261635C5;
	Thu, 11 Apr 2024 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dc0tANYm"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21C01635A3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850042; cv=none; b=p6y5DRFv1SvqyQwoTzix4ZDLItbRrIWtRw4BxELz4TGgF6jZXXYf7jCtLe8HXPmPBeu6MilYp7TOB5/84WbIGFPM8zkME1ja8sDHf/8Fdll+9taPJP82xXCTmzz+I1zJw7FfCZbvj1v1jPtT0rFZDsVyS5CRMUEgS0VckV9I/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850042; c=relaxed/simple;
	bh=b9KdXTwnY5Bsusp9rjF77HWJJfTKAnAjeMEMqaegr6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgC97Ana377es7cCjxK7nXuScnySXx2KXKS9qBlYbJJhbSNfqL77WuvVTomdVtU9p6Kt2eWIk8k5rULcHTqA6EN6+4zEMLcJTxXjCQlvBnivPOmY4mQLnr/CTjj8A2E46WQPdg1M+8dMOASob5sX+d2H7CbEtD6JWSkDo54WS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dc0tANYm; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58213539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850039; x=1713454839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGX3+6wa3dg8+QZi5YqDIWtU6E+6HfJk9gO0yHUTJjQ=;
        b=dc0tANYmIi7LrCi5YIjeZOfzgkaCHdxPgniv04Za8+QtSXQVIo314WW49SbQe70WSY
         PHyb4JT3B/2An7D5tYFU1QhCop8p+qeYv3Jh/OaRCf9dC+7pfcsEUb6Jmw6uBtio8MzL
         NCRh9IXWxfdOcnF0NM7Z0n66P3LY3gyoOJu+ZsrMLaHnjsAdFc8qZ8bANmQjzqU/rqQf
         VfU4oJq225BD0SYd9qlHiXzV0HC97NXtR034M6U5Y5FkkvAHQQ3MfLTEyD2zfS/Z+Vjz
         FXtqNu7osXLCMJ8z2cCeezPCA9a6MCBQPWhFxWp1xxbr/crS0bms7OUnyLhw1o8AEgPM
         fC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850039; x=1713454839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGX3+6wa3dg8+QZi5YqDIWtU6E+6HfJk9gO0yHUTJjQ=;
        b=JYarus6SviDBApe4rL6M96q43DMPmqUgLVQD2pnZ3utpcVWD7NRy8pfOUTe1aV2agU
         Sn6vT5da7EjoyoJ5H85Xq9bNMbrAT84B0qb5nnNbVv0z9YoVrKUX4omoDGKz9XJ6Fb4V
         IcacHIk9yYoAjvBHPFjxsUvEcsVUrnN6rbH6dmI7p3E/OrO/fUHn8sMlgJhCaWjjlNZA
         ldZBLx2GFri/uetBKZf6P0Jxq7GZ1CB7SYHRcNy5eStgIg8b3Liaub+5rhELIDyZ+cNv
         gy10IzHYx5lYnmrbi2ZJqHGEx+ijEsm+QIQFy3pvlPNnmHMklxiCdu/5/B/MSjlc33Wg
         ez5g==
X-Gm-Message-State: AOJu0Yz0iOC9PCEyuGsxgFuJQnAg2lqyxKdV4S+14z9hr65bFUp+pwbo
	+niChGxquFWvbROH+M8dfSIr6kLetea6/CfdP1prl5YPWwgp/Ux3FglHsIqvgvPWJc62UAmCzzi
	M
X-Google-Smtp-Source: AGHT+IGNosjGBRxDudoXwRrzcH4kviMCynwJykGr21aYXuwcaZp2AaNZQkyxlwU4zaXA9iftHQD6Lw==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr173723ioh.1.1712850039531;
        Thu, 11 Apr 2024 08:40:39 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 326/437] drivers/net/ethernet/huawei: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:46 -0600
Message-ID: <20240411153126.16201-327-axboe@kernel.dk>
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

From: Bui Quang Minh <minhquangbui99@gmail.com>

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/net/ethernet/huawei/hinic/hinic_debugfs.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_debugfs.c b/drivers/net/ethernet/huawei/hinic/hinic_debugfs.c
index 061952c6c21a..411d005a4a95 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_debugfs.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_debugfs.c
@@ -133,8 +133,7 @@ static int hinic_dbg_get_func_table(struct hinic_dev *nic_dev, int idx)
 	return ret;
 }
 
-static ssize_t hinic_dbg_cmd_read(struct file *filp, char __user *buffer, size_t count,
-				  loff_t *ppos)
+static ssize_t hinic_dbg_cmd_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct hinic_debug_priv *dbg;
 	char ret_buf[20];
@@ -142,7 +141,7 @@ static ssize_t hinic_dbg_cmd_read(struct file *filp, char __user *buffer, size_t
 	u64 out;
 	int ret;
 
-	desc = filp->private_data;
+	desc = iocb->ki_filp->private_data;
 	dbg = container_of(desc, struct hinic_debug_priv, field_id[*desc]);
 
 	switch (dbg->type) {
@@ -166,13 +165,13 @@ static ssize_t hinic_dbg_cmd_read(struct file *filp, char __user *buffer, size_t
 
 	ret = snprintf(ret_buf, sizeof(ret_buf), "0x%llx\n", out);
 
-	return simple_read_from_buffer(buffer, count, ppos, ret_buf, ret);
+	return simple_copy_to_iter(ret_buf, &iocb->ki_pos, ret, to);
 }
 
 static const struct file_operations hinic_dbg_cmd_fops = {
-	.owner = THIS_MODULE,
-	.open  = simple_open,
-	.read  = hinic_dbg_cmd_read,
+	.owner      = THIS_MODULE,
+	.open       = simple_open,
+	.read_iter  = hinic_dbg_cmd_read_iter,
 };
 
 static int create_dbg_files(struct hinic_dev *dev, enum hinic_dbg_type type, void *data,
-- 
2.43.0


