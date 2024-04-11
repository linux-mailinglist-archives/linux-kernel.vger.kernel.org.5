Return-Path: <linux-kernel+bounces-141042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C01CB8A1A30
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6391F21F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707011CEC0D;
	Thu, 11 Apr 2024 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Wzc4i2zq"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808ED1CEBF7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849950; cv=none; b=P7l/pk2jjgbOB1+OKnXOYmFavmK84gNyyg/Qdj7FT+3GcdFfocp5zQ0KLYNqNeWz3p2qWIH1HopIVL96vAesnSye1y8Icbes4Y0crLmFkyw6xsG6s3Lb061NnQE7F4BmT85DMsgRnoLZgbFxagzSBtwKYOWxz6UWERgR0+Y8rBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849950; c=relaxed/simple;
	bh=SbLNY+YyvJ/n6VTS+ylql2LpwNRyjmAEGcM8JUKgiKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIkJTpeDy6Agr2hyvuFGfuy0ncKPhsdzWaVLIXpCUHY6LhURX16NGQpFCUbZigYqIgraAGoFnPTSeUeGuMwviW3N7+puUiFyR7UVL+v4UAKTr8MyWiegA/+LtrnqjVXYUltN258oAXlf5BjV5ZHlnx9lsaBr9B0x2FW9MzQpbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Wzc4i2zq; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170571239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849948; x=1713454748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpLqbHCHiRrmIVcljtjWUdMhXXoiWWwTkINzbnINGFE=;
        b=Wzc4i2zq5l1S/VOE/RRMXDXDbW7C/ODbUMpnG8gpRbyhRg53TyHaVYS5Fn5bqwPRum
         5drh5V0JqIwlaT+iz/hPxN0rvGVaTFQVDvst12738qpPKB/+DeuKOYzlC6hdsco4AeM9
         TtpxqTtt3nAaT0lgq+i6QhmOQtkWEf0r+ewZhUKLk2RZdzkYPRmwZGiDJSqcJp3oCzAG
         WaSTbmzo8QKSjcWMMHVWtQMwouD/oh9VAzWS7v1nLtliqZbvtJMyQbAalzDsw67lYzTX
         7jFFiFbPR5EeilblU1iAojoZQmVMybgqoRPtalbSQEKvXXfMfYaiCn8TbcjRF3XdD82V
         1haA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849948; x=1713454748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpLqbHCHiRrmIVcljtjWUdMhXXoiWWwTkINzbnINGFE=;
        b=JTXCwM/3vNt9dYf+jJRvYdxeXqqcMe/gts2X7y4eW6gi4gZnfpz6HtPVgnoWq830mQ
         exvz+CvfbytfiXe5x5qOZdFsKOFjeNISSWrQS6DuZOkj4BH0iRF/WE216F6iENb1Kl3a
         ai0nqpCY0W82i0/hLFxIszoAU6MGtlBemGgdgnj30ROI5yNQaGYPmVQK0vDsAjN1/1et
         xG+DacpS6miRYXHmd2P5AHaaua1gw/k/cZlDAWUj0rc3Mj9uSue9j2G8kong4/rK8fUp
         NqNJiZ6BpXtxoIlTDnbCiZmNEZmT9ID5FYexRnOo8LPoQDOTIWRMsoI4Xb7bzXCkZKRL
         +/wQ==
X-Gm-Message-State: AOJu0YzwzQFBSKFO7/2W62IvWf1B3ClM8EeTF6xZnGsUIJg5S1+4c+hI
	LkEX0i5haUgZT/CUiClYn63KpL6SL9g/H8Dnxlj0gskuGjVV3Kgqlach+vz1GUHy+bucfAZb0p3
	G
X-Google-Smtp-Source: AGHT+IFcVo3i3o/k5twA0Rsb+cYBtE2c3K44//46cCuLHDOULy4stZ5TI90lUoAvBGpM6sfP9x7/8w==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr188822ioj.2.1712849947944;
        Thu, 11 Apr 2024 08:39:07 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 269/437] watchdog: mixcomwd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:49 -0600
Message-ID: <20240411153126.16201-270-axboe@kernel.dk>
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
 drivers/watchdog/mixcomwd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/mixcomwd.c b/drivers/watchdog/mixcomwd.c
index d387bad377c4..c980e542c31b 100644
--- a/drivers/watchdog/mixcomwd.c
+++ b/drivers/watchdog/mixcomwd.c
@@ -166,9 +166,10 @@ static int mixcomwd_release(struct inode *inode, struct file *file)
 }
 
 
-static ssize_t mixcomwd_write(struct file *file, const char __user *data,
-						size_t len, loff_t *ppos)
+static ssize_t mixcomwd_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
+
 	if (len) {
 		if (!nowayout) {
 			size_t i;
@@ -178,7 +179,7 @@ static ssize_t mixcomwd_write(struct file *file, const char __user *data,
 
 			for (i = 0; i != len; i++) {
 				char c;
-				if (get_user(c, data + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -225,7 +226,7 @@ static long mixcomwd_ioctl(struct file *file,
 static const struct file_operations mixcomwd_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= mixcomwd_write,
+	.write_iter	= mixcomwd_write,
 	.unlocked_ioctl	= mixcomwd_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= mixcomwd_open,
-- 
2.43.0


