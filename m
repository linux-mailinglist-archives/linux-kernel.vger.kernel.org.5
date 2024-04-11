Return-Path: <linux-kernel+bounces-141163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AF48A1AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336361F211E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895A41F4655;
	Thu, 11 Apr 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wQnfcVh4"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D471F39FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850143; cv=none; b=n9FpiaTOmcEzm5qNIhWLSCUMktJ4KwUD6SF9xy6WhQX8hJadc68LXTNJ+aOCSjmBYonX1DV3fII5JoikgS2rVjVHCOb9vwmPbik0oXbA7DoavkdFKRhqLr+ds1pAbTGPTUEls3Up1TpAUjBXWhZq9qIL/o4IpsltZTNYRDouqPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850143; c=relaxed/simple;
	bh=tOLEJwfYjMVxWPttHQjsL6LYe2K9decIhtxo/E4b3BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrnRdb4R1l4mFso5qTpmJLMPIJvvtmzcnANGrVovnpZUKA9sWb46b0f/8Z8F+pcPyCxpOrCgmKo4oVc7e6AhiN68zM594mfEUXQ3RnI0bYsH8i5aDVUItCkeBfw7Lc65Gh8Grf3BGn/67ot+7j7ziMAL6lUi9ZkwNpdO3m5Jx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wQnfcVh4; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69686339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850141; x=1713454941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ye7/s/l6VBfzrFt6AIC3/rqdymJPLbIjlPiBSwPUgUY=;
        b=wQnfcVh4xOUMjgVAky0Y6mk8lte7GCfkYg+drSzdY/aVtmFp5iB/7ogbKiPBlS23jK
         uvXvEz3MIgJRBwEJCGXslpWg1mVudAS9V0QdIUhIrq343jGxNtNSThllbVatoLeoTLmB
         R/WnCd9Rt8v27Ui7HnwPhSd236j/yweTzr5erv8A0g7Fpdp4oVm0K/qwoYIb3a4i/Ekm
         RUKmUFJmNdGFHgtFP7B71lUjVpCUjV2qWI02dREsPoqNWhIXqZNlf11eFllwLLch5Xme
         C0iXTs+l6SHJnOiRLOYiaGcqL5613+Lqsr6LL9QAb+1P/6sI22MhJELVisoialmYgxu4
         sBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850141; x=1713454941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ye7/s/l6VBfzrFt6AIC3/rqdymJPLbIjlPiBSwPUgUY=;
        b=uYtMsCPA1yu+Fp9jp2FKHtWF2l4yMTjQYhH3KP29uAc/LsfiCRHQLXNcCwFjyxo0WZ
         LwWoueoda5bpa/lQi2c7temJavGGsntV5u+9MXYMPiauhYBX/Yp5vaGwJyuIZqYTIsVY
         Ik5+wDGzgig3pAQ4zNBVBFWzJ7h2Hvx/WmDbeNfNNNkVWvYkmJUXh3KzFLMv9F3e0I1A
         NHvq6YE/+PWrehYhQVNrtti8zr3t2kfKpFdr1nYK6XDAfosLPlCfNXjjV5jzCNwXwgEX
         amtkCkM53H/oVC/H0T7jwRtJIVQFc/e5g5ENx3grLHi151dnTN62N3OfkCjTmnb9pl6I
         gjvg==
X-Gm-Message-State: AOJu0YywkZIRU0TngSsjIl553/tQM/iRp7I0T3Y3+s2doNVOhm1fxGZ6
	4c0k6CEl7wq+OhZB7zGTVHmcEwq1JUp+6zBc7IAzjnwuSrYPzYqL1a5slSBsgYdRam+Bi1MTWmz
	/
X-Google-Smtp-Source: AGHT+IFZqQTuYWD0PdITOocs3S7DfocugPp5pCjRxNwk+DSkypfWXLha5cEuHrhLV8tvhZIFRakP/Q==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr209004iop.1.1712850141562;
        Thu, 11 Apr 2024 08:42:21 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 381/437] iio: bno055: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:41 -0600
Message-ID: <20240411153126.16201-382-axboe@kernel.dk>
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
 drivers/iio/imu/bno055/bno055.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 52744dd98e65..729b42e31757 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -1269,10 +1269,9 @@ static int bno055_debugfs_reg_access(struct iio_dev *iio_dev, unsigned int reg,
 		return regmap_write(priv->regmap, reg, writeval);
 }
 
-static ssize_t bno055_show_fw_version(struct file *file, char __user *userbuf,
-				      size_t count, loff_t *ppos)
+static ssize_t bno055_show_fw_version( struct kiocb *iocb, struct iov_iter *to)
 {
-	struct bno055_priv *priv = file->private_data;
+	struct bno055_priv *priv = iocb->ki_filp->private_data;
 	int rev, ver;
 	char *buf;
 	int ret;
@@ -1289,7 +1288,7 @@ static ssize_t bno055_show_fw_version(struct file *file, char __user *userbuf,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 	kfree(buf);
 
 	return ret;
@@ -1297,7 +1296,7 @@ static ssize_t bno055_show_fw_version(struct file *file, char __user *userbuf,
 
 static const struct file_operations bno055_fw_version_ops = {
 	.open = simple_open,
-	.read = bno055_show_fw_version,
+	.read_iter = bno055_show_fw_version,
 	.llseek = default_llseek,
 	.owner = THIS_MODULE,
 };
-- 
2.43.0


