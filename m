Return-Path: <linux-kernel+bounces-141184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704B38A1AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2433B28767E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53F168AEE;
	Thu, 11 Apr 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uSWUGr1w"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91441F962C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850174; cv=none; b=baifW7NYGbofyEP03aawFZSpEwmK+bM7OZ4H5aYtp3D1mcuEuP7iBXrI56oSGQd0eOS4b1N5IG9Tafj9VzlTSns/vMpFmud3KENxtonzSlwJVJ5RicXEO/Cr9Co//afKzLauPgAetX7O3+qbGAnTetIf9mwBQWM5lyw7/bx4mwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850174; c=relaxed/simple;
	bh=PNTIyww3Yjh9XMFowg/nTgO62vsnmR2F+vKnrOQQ+E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MctdgcAZuxFoHrNLQrXeChkSTyMhl1GGUlR4Z13D8uy0/HOXpO87d1kFBQ4r83e66vtZkd52CzLLK6z0LattB7SRQo5ogvqvMbNleV0SL/ZpmFqw9rCYNmDnm/3G9vLtSWy2G+V3kUu934axgPUbkOSsqZQHTIruXZUx9sEXQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uSWUGr1w; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36a224d7414so198005ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850172; x=1713454972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7WWPETmJQxbWvG9OQdVyXT26hRdCxaZ5v08Hz5199Q=;
        b=uSWUGr1wisrlkS/k93m0w7X4mtI6DJzTTpfoJq+E6XD25Di7LpkPm7TUEAiTAXlC6B
         RTk+ksGVgT+wweG6vIf/UxBaEUK41nrG8zfFZzb/ROOZpuvstJibDBn9I1BG7qURZY1f
         e3yohUBleXTlVC7eZpV+k7wjZLLFelQBXtyxsyC/8MYvtR3zv8gt0ZgYbOAssWVeww0N
         YH6GBBlHX8arSlI1SzXHqYNfR2pqplmCOATu2FHTmk2A88GvTu6HEtXtSm552uOq9yJD
         lmJ+umNJcXmYQqOS277Kzq1ebys09fN7Y+XVJ5UodeHD9xtzRw7wVbOBOfF4KeedzOTW
         rUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850172; x=1713454972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7WWPETmJQxbWvG9OQdVyXT26hRdCxaZ5v08Hz5199Q=;
        b=tCgfbgnfTlqHI0Uvi2REUFuD0Ecnv6LfqBjriTDlh1mkiwh4m7N8kr6DkS31xtqN0h
         eZpOh5vi7FiBk5s+o5Dr1vXVQ96czYjpvtjIOz/KKbZ8QGvoCzErh3Ozx9UCLYkWr3Ly
         WPSqEaLVDKgZUR/vkOrjIKP1aOAY7E0SIMtVAHfpW8mQrFn74vNWPH/DxB6wEe0ii7bS
         SGkDouU4F8qapMp0zqT6CpTVSlFBL5iKao3im8lMKIBzWYXUePlGQIihimVkbQEPb2Su
         5Pdw07B8WUp0Lr8VqeYVNVna17fzbgMMVrH9SLCFocNLjKdcp5Cz8fwYb59piUnwDqU0
         Q1Tw==
X-Gm-Message-State: AOJu0YyoMldwO18nSCLQJIeh4/IbwYAoBjFI05py7+6KktYPiK/Sx/WD
	3iUDOm8VPrK7FIh5Ysc8+Lny3n38Kj0YACVeOXFeJefLuJopnJdM2O0HpQR7KjLD67IFElzOm8R
	h
X-Google-Smtp-Source: AGHT+IEX6Gj42GPcolYgmBDZ6+t385rqIeaLejv0ALvsAvYKKW+9At9TcE6Gc/6Vs0vd9dr+2bnpRA==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr164701ioc.2.1712850172497;
        Thu, 11 Apr 2024 08:42:52 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 401/437] drivers/gnss: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:01 -0600
Message-ID: <20240411153126.16201-402-axboe@kernel.dk>
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
 drivers/gnss/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 48f2ee0f78c4..ce66ffb85832 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -119,11 +119,12 @@ static ssize_t gnss_read(struct file *file, char __user *buf,
 
 	return ret;
 }
+FOPS_READ_ITER_HELPER(gnss_read);
 
-static ssize_t gnss_write(struct file *file, const char __user *buf,
-				size_t count, loff_t *pos)
+static ssize_t gnss_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct gnss_device *gdev = file->private_data;
+	struct gnss_device *gdev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	size_t written = 0;
 	int ret;
 
@@ -148,7 +149,7 @@ static ssize_t gnss_write(struct file *file, const char __user *buf,
 		if (n > GNSS_WRITE_BUF_SIZE)
 			n = GNSS_WRITE_BUF_SIZE;
 
-		if (copy_from_user(gdev->write_buf, buf, n)) {
+		if (!copy_from_iter_full(gdev->write_buf, n, from)) {
 			ret = -EFAULT;
 			goto out_unlock;
 		}
@@ -170,7 +171,6 @@ static ssize_t gnss_write(struct file *file, const char __user *buf,
 			break;
 
 		written += ret;
-		buf += ret;
 
 		if (written == count)
 			break;
@@ -203,8 +203,8 @@ static const struct file_operations gnss_fops = {
 	.owner		= THIS_MODULE,
 	.open		= gnss_open,
 	.release	= gnss_release,
-	.read		= gnss_read,
-	.write		= gnss_write,
+	.read_iter	= gnss_read_iter,
+	.write_iter	= gnss_write,
 	.poll		= gnss_poll,
 	.llseek		= no_llseek,
 };
-- 
2.43.0


