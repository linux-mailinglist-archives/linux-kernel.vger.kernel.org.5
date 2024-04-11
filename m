Return-Path: <linux-kernel+bounces-141021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB27A8A1A33
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA881B28D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DB51C8234;
	Thu, 11 Apr 2024 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HaIkyjC0"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE01C820E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849917; cv=none; b=gc46Fp5WkaZzZX1cSONeiBQT1X/ndhCY1wylChL2MA+Pjh9JHPjQptt9Yy6sif2kqXvAN8FBtt3As+/eObtP03UBbVJWy16ZGcT+/0ndAEfvlIXv3sPB1VP6mmpnUq+NMYNH3hy4S5BADMyJunJ5ckZ8UlmBvqeFyAqikUHdC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849917; c=relaxed/simple;
	bh=9llkeOK29Lea4aDs2Og1dKys9kjegYcBXnNLhMvi5Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAr3YkocX2mfJhbf9H2t9mMxMoe864EaYukEWfddLL6BktfOivGmCajG2BA8JjDY8mJfHUPeDtnn1cUrhrVAStb9aWq9nt901Gk9BY1Hf1SCTCmusa92UXVizOli+uw2rq99HbdioBu4ihNqHvz3MLjYofw0m+HGTcU7q+1OZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HaIkyjC0; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58137139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849915; x=1713454715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5usfOwW+TdAOAtqFSdSFLDeFIH/am800/p+fFXMWAh0=;
        b=HaIkyjC0t/yr15CR9mR6ICr7XlEvdac2JNHQb+djyVk1+es4uUc3F2eKmdjaDL0nXB
         ZewrZNN/DWCLaT8YqCOpWVLH010vx+XmvqUTtHcz6+plK1UrwQQUxlrmdgqKOu0LpCM9
         qWJTleWaNFeUh22P6zpcB37VSIzBEwtOpuf4eMiqYTCi0ASEaFGTq+9TdHTslf3i0eCA
         HuWcePCC34yPIl23oJR2VMbTGxG0oaXLHekm+8Le43cmTyK9hqAfUe4PiescAiuv8+uD
         wdX5xS2TbMu2HnY4xEsnGGAW9/N0z4BhN0ruBMyGN+wnf+f55+Ev/QM2nQ1PfmxgjBld
         bf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849915; x=1713454715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5usfOwW+TdAOAtqFSdSFLDeFIH/am800/p+fFXMWAh0=;
        b=kXfxUh/k0Txeww2qQkLyHIUohTIg4FmN3Hr8+M1VW5ML+5+WAx5caF6E9RBYtu9cNU
         zt+J2merWlosC4lSYGu/gHHVetPOeTHsyZp3EYNq68zK2qqAg6nQehRFy3DM7dlRlGYV
         tn6Lc7t0adxf9YVI624H8zWjwPyY7/fhwFFOjE6xDSEG2w8skbStzo0jDBp/ofV8ZwHr
         8EWw1BIsyuqPmNnQ5MTFTC4YgO5CqGNR8xUEMdSei7hCNMVjwKzxvlDd5IZKPA2MxHdC
         hHFkv+wop7lA5H5MdvSvCJSSSMbkNhsn2l9zEIWl/L0alyHldlUFSlqh/nQYQt0rShu+
         dRsA==
X-Gm-Message-State: AOJu0Yy1YsmF2wAgKqmq47pqNSLiRTTY/QiT4tp9LFKfjx9hEKKLB3hX
	DneGPb0Xmgz+IkQFzHO4OK6wF7bQiLvWIUMd6px8fRaB49tJfjS3iJqhSBf+0Sy9cLlz5/4bfp0
	3
X-Google-Smtp-Source: AGHT+IGQkgCgv9qCzf2YKDbhAobuqMXjNVkpDK/dn3kzh8sS5SZ8uxlrwyRSQiA7GwFUxrV5JAOMbA==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr192635iov.2.1712849915313;
        Thu, 11 Apr 2024 08:38:35 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 250/437] watchdog: rdc321x_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:30 -0600
Message-ID: <20240411153126.16201-251-axboe@kernel.dk>
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
 drivers/watchdog/rdc321x_wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/rdc321x_wdt.c b/drivers/watchdog/rdc321x_wdt.c
index 6176f4343fc5..de3210a342ff 100644
--- a/drivers/watchdog/rdc321x_wdt.c
+++ b/drivers/watchdog/rdc321x_wdt.c
@@ -184,9 +184,9 @@ static long rdc321x_wdt_ioctl(struct file *file, unsigned int cmd,
 	return 0;
 }
 
-static ssize_t rdc321x_wdt_write(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t rdc321x_wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	if (!count)
 		return -EIO;
 
@@ -201,7 +201,7 @@ static const struct file_operations rdc321x_wdt_fops = {
 	.unlocked_ioctl	= rdc321x_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= rdc321x_wdt_open,
-	.write		= rdc321x_wdt_write,
+	.write_iter	= rdc321x_wdt_write,
 	.release	= rdc321x_wdt_release,
 };
 
-- 
2.43.0


