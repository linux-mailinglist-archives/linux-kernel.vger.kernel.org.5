Return-Path: <linux-kernel+bounces-141129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBA88A1A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004451F213AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DFC1EB1E8;
	Thu, 11 Apr 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jSVfZBZb"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447D1EB1CB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850084; cv=none; b=BDesfzz0ws+uIdCR8neTv2d2ob1PRhpiCVaNdFHp5FhBtCkcSTIKHhkTVjH1+LPIBnzjk3qvIl7GPDEPpnhNASEYdhv9TaTa9WCCemZ8d4nA0qupwmWwIf2dPyRQ5RSUwbuC0qQLAtyUNHuHsQSrgg8J3/BYFcMqbrioMVJ8BVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850084; c=relaxed/simple;
	bh=gtTdUUKX8s+gnCGRRKXpvazcthFiIvChLczQBNvi4rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbU1JLkD7yMbSDx2MLImysVk3dJx/1zcChXLvpv84gik7DOwYlelo8rMmw4Ew3XVFgKVixPp5aDw07NK8H0knbIXZYizndg8ijG/1gR/o/ZdQhvPP1HfMQs1nWnRCIga9bdk9GGBursHmjjD7ks9g14Y6MZIDASwXvPLsl+LR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jSVfZBZb; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9074639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850082; x=1713454882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw7uLrEpA+GZdNnB4LGe0bmKIXCgrlLuPWP4gZJs1jo=;
        b=jSVfZBZbC8IKZA2vbu3XdYY/WnozZfV8ntRlpP2GRW2yzaeUFYvXe30qRywDcoY9KH
         WzJ5qX2uPV/HW5Wyapgpyml77if+FGSqKSTSFLZoG3rDwsJXJJ9c+DOOd/MTY2XnO2ql
         qnkmRjvEe2Q4bPQuff+DS++QArKX7MLEXrNBWe6uh0xlpCHvfPvCSs1E/8I4p4uEEN97
         /WF3r90VBfamWXEjkl59luAX4L0K1RPE7d5WxQHMunzBUwIx8xqzisrp9Fl580NazllQ
         XuhDQeFMNitCMc7h2JjINnYYkG4E8xWEHqp9AefSGbRRPGNRSP8f428QeveXxeVeFQSa
         nq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850082; x=1713454882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gw7uLrEpA+GZdNnB4LGe0bmKIXCgrlLuPWP4gZJs1jo=;
        b=XvhnTHQNL3XynITzcxkHJpe6Ht0T+lhFaZl6wi+INKgkDAqRlGlqqLOlAV6K4tmRkp
         cll5bCd9wvigLU7QYZVb9cv3v2MSLU6Y9ILj4JgfaWD817OxtTmRWeDGvUqcsrWmUbs+
         fiJrWXW+SeEEXiRGc2zY7doG/DzURFYgIac0A5dqwPtBtMi8SSzxntUdPo/+tnjcLti5
         FUW5W2X93QLP/4q/9DWAO5sqGBgZFsXGzXXoOZdX6+GOulOSHwF6LpUjgWNcJKMD0wZM
         Qzi71o5gUh4cWF5NncUuF4QvRH3GyTxunCTCluJUse3lLuklriA2tjKS81xZqX6Pwwjx
         aKvw==
X-Gm-Message-State: AOJu0YzgUPJG/xRiYrxPY4PqhhBSvdxpjxTIcdzcGH4O6PAP1L4WLKDE
	TASdYIqvIytQNQjiGIqUt/QiklDJb1HNIr799pPjVsniScid+7DzmEm7DEtRaQF8+MOI/Rif6t5
	W
X-Google-Smtp-Source: AGHT+IGsT63S2O8pIAp7OsBEa/KpFFxn2ebWHIH03kSeOiM+90aCAK8C1k1iF76M6qY3XT1h4O7K5w==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr30448ioc.1.1712850082507;
        Thu, 11 Apr 2024 08:41:22 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 350/437] s390: monwriter: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:10 -0600
Message-ID: <20240411153126.16201-351-axboe@kernel.dk>
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
 drivers/s390/char/monwriter.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/monwriter.c b/drivers/s390/char/monwriter.c
index bc5193d81f9c..8baf04d05748 100644
--- a/drivers/s390/char/monwriter.c
+++ b/drivers/s390/char/monwriter.c
@@ -216,10 +216,10 @@ static int monwrite_close(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t monwrite_write(struct file *filp, const char __user *data,
-			      size_t count, loff_t *ppos)
+static ssize_t monwrite_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mon_private *monpriv = filp->private_data;
+	struct mon_private *monpriv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	size_t len, written;
 	void *to;
 	int rc;
@@ -230,7 +230,7 @@ static ssize_t monwrite_write(struct file *filp, const char __user *data,
 			len = min(count - written, monpriv->hdr_to_read);
 			to = (char *) &monpriv->hdr +
 				sizeof(monpriv->hdr) - monpriv->hdr_to_read;
-			if (copy_from_user(to, data + written, len)) {
+			if (!copy_from_iter_full(to, len, from)) {
 				rc = -EFAULT;
 				goto out_error;
 			}
@@ -249,7 +249,7 @@ static ssize_t monwrite_write(struct file *filp, const char __user *data,
 			len = min(count - written, monpriv->data_to_read);
 			to = monpriv->current_buf->data +
 				monpriv->hdr.datalen - monpriv->data_to_read;
-			if (copy_from_user(to, data + written, len)) {
+			if (!copy_from_iter_full(to, len, from)) {
 				rc = -EFAULT;
 				goto out_error;
 			}
@@ -277,7 +277,7 @@ static const struct file_operations monwrite_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = &monwrite_open,
 	.release = &monwrite_close,
-	.write	 = &monwrite_write,
+	.write_iter	 = &monwrite_write,
 	.llseek  = noop_llseek,
 };
 
-- 
2.43.0


