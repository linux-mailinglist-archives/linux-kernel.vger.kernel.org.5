Return-Path: <linux-kernel+bounces-140782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00AA8A18F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2C11C22F28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F014F5FD;
	Thu, 11 Apr 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b0INj07D"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B24D59E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849533; cv=none; b=NIWpsG76UmHQRqxIePlj4au1IpKgDyQF0afK1JDW1IVdpUp61oGE4Vfr6RwO8ziqCtvNG0NdLq48SQqOYsf5XnNDG2O9XqcmAmiHEp9EQJCPxLChd9o6b+EBHqTo61dGopmnl16ZVC2/JRKepvWaEjOupsqtB9OWmV4tN/G2jyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849533; c=relaxed/simple;
	bh=SzIlWvqYCnlTet5gr/Tc5LnJFfs+akMvm3OzizTAikE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ES2JhilLymbPOEx5Hpg8m5hfYGOua9O5iGQzX1dBS+Osjk4+4Ozow63ekHmUEtF7q8ISovzpNT3LqW7tRjOaaVRmVxSqAbN0AZ/tPwGisUzGpGzkAMBBqlEeGf9cwLWx/B3rxbzBwSPZmpiTzrtIsOl+iAYn2TEuNaWi1tz45B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b0INj07D; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69486739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849531; x=1713454331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AQorYsUBJJg+lN24NJvdf2Zg9AjBizq3/2LSD+5mik=;
        b=b0INj07Dy03ub55rrQhPNNpCepls/6cLlBQm3wBCysM/JA6vmfcAEWEmf6ft9mTwRT
         fiIoD59w3CkWLFQ+qrzPrrs0MVulMHezjAN6HS4XGiOvP8NecJ+Rbw9Cx8VAl1b4paSC
         J3WpbHEPQAJdDKbnZwhDgeYgtZ8lrVDKRiWhAHgNtJd0o+iYJAzgG7H5o6JLM9iIloqQ
         rghOegyST+GQLEmBrol5cRFUwP2t562lDHa5I7PNEACbrBzWkcV2syU+96+9QQ/W73U4
         MIpujoT9fHsMuHZeDBhIoHGuKtH0m4NNpH/+CAV18ijOmsKSv350PzXZOXMpIhnoekcL
         8GUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849531; x=1713454331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AQorYsUBJJg+lN24NJvdf2Zg9AjBizq3/2LSD+5mik=;
        b=G6RLWFvv3VTDiPeVlpRF3ikwmyEZsYEdgJB7DQ16OWkeCw1IeC9fRQyYyN07OUzj/t
         82fRhDgyeUufP41JZEWvjUAKDRCZjO0nD1Cef+b2/T5nRjfnm0WR/3qoyh7Gwha9P4/1
         mWW0I0lFBKGiE7valF6pPIpyt/DdeuYGh6EOl+HhMwL4HMPRsSWzQRwYgHAXAWwcHcwE
         dAWSC5xYAWSTJZVuaLjnMOUagLo15aG+b5FxJhn5lN4ZdMUGhdd/7pmx7cIJdoHLaPZ6
         uw2XpwuH35H8EExJQxYj5sVc6fPXnQcGU6hZ+f4JApWQHK4pPrzDKseNvvGLQlJtG9B6
         9imQ==
X-Gm-Message-State: AOJu0YwUFP7YZf0lUWBt2GgMQzfI0r71ll/ySIfiTP33VSPDU5cyGUH5
	BS9O7wLm0EkqN/iRGjil2MH0amK54erEhmldTsNMFx113thS7j3TlqFNIvUNElYfaJb39cmJYer
	D
X-Google-Smtp-Source: AGHT+IEAQdAET2G9jFQV5s5JIv6IGJlKcgAe3k1XevwTzuzOZ/jeblflatm8M0UOcNIl9x0lKu61Kg==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr31179iob.2.1712849530943;
        Thu, 11 Apr 2024 08:32:10 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 025/437] char/mwave: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:45 -0600
Message-ID: <20240411153126.16201-26-axboe@kernel.dk>
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
 drivers/char/mwave/mwavedd.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/char/mwave/mwavedd.c b/drivers/char/mwave/mwavedd.c
index 11272d605ecd..34b00a663d22 100644
--- a/drivers/char/mwave/mwavedd.c
+++ b/drivers/char/mwave/mwavedd.c
@@ -411,25 +411,14 @@ static long mwave_ioctl(struct file *file, unsigned int iocmd,
 }
 
 
-static ssize_t mwave_read(struct file *file, char __user *buf, size_t count,
-                          loff_t * ppos)
+static ssize_t mwave_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	PRINTK_5(TRACE_MWAVE,
-		"mwavedd::mwave_read entry file %p, buf %p, count %zx ppos %p\n",
-		file, buf, count, ppos);
-
 	return -EINVAL;
 }
 
 
-static ssize_t mwave_write(struct file *file, const char __user *buf,
-                           size_t count, loff_t * ppos)
+static ssize_t mwave_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	PRINTK_5(TRACE_MWAVE,
-		"mwavedd::mwave_write entry file %p, buf %p,"
-		" count %zx ppos %p\n",
-		file, buf, count, ppos);
-
 	return -EINVAL;
 }
 
@@ -481,8 +470,8 @@ static int register_serial_portandirq(unsigned int port, int irq)
 
 static const struct file_operations mwave_fops = {
 	.owner		= THIS_MODULE,
-	.read		= mwave_read,
-	.write		= mwave_write,
+	.read_iter	= mwave_read,
+	.write_iter	= mwave_write,
 	.unlocked_ioctl	= mwave_ioctl,
 	.open		= mwave_open,
 	.release	= mwave_close,
-- 
2.43.0


