Return-Path: <linux-kernel+bounces-141091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966A58A1A70
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C342853B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14301DED80;
	Thu, 11 Apr 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PXWHTLRn"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C73A1DDD0A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850022; cv=none; b=e+oioAkUyneiuu31WhmU6SVaU9JlXLy9KYu1Z2z0ewbdwdbd365k4L0WwqRYxu7b+CUOfmR6yZFbMAjY3jdb3pNPvC3fhty8Pp5grf1h7zO+8QwKPjFGH6lEoXsy56Yv4K+WTCFsOJvo8UTQYdcP1WEmrlOHRl0HRuwkJOYsOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850022; c=relaxed/simple;
	bh=mnQjR+29ACbgwAY9h7aFa5xs7m/mD2V4HibbKVoxIyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntZEfteegP3oP4yR6xU3z34WDA/i6GPGKvcU/sLECZJ/kwsC+ntOuZpQx5qUQW0OG40xeBfkfFZu96D0ew2NkRsqOkAZHE/CP0zgNDQI/Dyn+7F1/CwHg6OvY0zUMv90APy1Qwb1DBC9meso48UU9uWM6PlXaO4hIwk769Jymyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PXWHTLRn; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a34b68277so117985ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850019; x=1713454819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BF8EfNalKjE+Vd3fS/YbOv7IUIKv9MR0GBhWfWxE7cM=;
        b=PXWHTLRnv0AwoHj3QhIi2/mcxyY+pDQASi2/Eb5wZ9NIiHbW6BJmgVGE6YLjvo6cnc
         W4WwW8ov4x7IAEOdTsxLjuC+VXexghuBvHGHfGP+5eM1TTZZxgKJM6haKxaklD3ah82A
         A2mvScP7Ny5NIbY6Gq+E369LqXHkOP77u6EfJEufhuEve5oyHCimQ7c+z3f56Ush+iiZ
         m3woKM9wrUSYvvXNSij34U1iCsqXiOUTJlmCJwvFWl1vHpjSS+Gk2oQeKTijacqUT6YY
         QqDnSNbMWQ3TdwXjYU8BM3gXBfTrk4VEi+j57I8W1FvBObs+DDiHZntqbb0+y7XtbI46
         hSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850019; x=1713454819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BF8EfNalKjE+Vd3fS/YbOv7IUIKv9MR0GBhWfWxE7cM=;
        b=B1DlwQLuRFkl6vdaC5r9Abj2iluOKXVXE79d92fmJO7HIvWNnZmibUyEkpmYMWFV8Z
         KYdER/WaBEQa9fU3oTt/SlLQo1oIs2HuBMtj4ptHNnVO/GuOmN7JxUwoI8mhDgEWthzu
         WQAtVffwYh/Qu1epDF/O2ri/yJh9Piz8EJt76MCYM+K1cWIo6s7A5HS6DDDYVpSWoIqY
         EobSPHApI5gCLM2RBhdMl8kjbZQRwOroZnow7Oj9XWp0lLpHQ9pJGtt+//Dm/OJqsvII
         3v7O8gJZyKCIyZqXf6/h2iVljNyVZS4wn52c6tiz9ao+s63znawY7GuGXOC7VenCZyNg
         2ivQ==
X-Gm-Message-State: AOJu0Yy7xaZ6OOs8UdEPpu1xSGyK3FgmCnPvvRs3bjIsmkcge7pZIZPC
	JSVV+aN5NdF+U16F6IAX8NIC7yKB4osCijkQHRDV1v9Z2015IOz3pPvd7JstJs7XAhZJ0oTDSJx
	A
X-Google-Smtp-Source: AGHT+IG+OcmEIUT79aDjGFU1tmEXf+pLUI9seL8wSRpbRGrjgeVFY64GwY+wzo91p9cEHv2meRvKKQ==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr198619iob.1.1712850019634;
        Thu, 11 Apr 2024 08:40:19 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 313/437] drivers/net/wireless/st: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:33 -0600
Message-ID: <20240411153126.16201-314-axboe@kernel.dk>
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
 drivers/net/wireless/st/cw1200/debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/debug.c b/drivers/net/wireless/st/cw1200/debug.c
index 8686929c70df..425fc06a9d38 100644
--- a/drivers/net/wireless/st/cw1200/debug.c
+++ b/drivers/net/wireless/st/cw1200/debug.c
@@ -332,15 +332,15 @@ static int cw1200_counters_show(struct seq_file *seq, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(cw1200_counters);
 
-static ssize_t cw1200_wsm_dumps(struct file *file,
-	const char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t cw1200_wsm_dumps(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct cw1200_common *priv = file->private_data;
+	struct cw1200_common *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[1];
 
 	if (!count)
 		return -EINVAL;
-	if (copy_from_user(buf, user_buf, 1))
+	if (!copy_from_iter_full(buf, 1, from))
 		return -EFAULT;
 
 	if (buf[0] == '1')
@@ -353,7 +353,7 @@ static ssize_t cw1200_wsm_dumps(struct file *file,
 
 static const struct file_operations fops_wsm_dumps = {
 	.open = simple_open,
-	.write = cw1200_wsm_dumps,
+	.write_iter = cw1200_wsm_dumps,
 	.llseek = default_llseek,
 };
 
-- 
2.43.0


