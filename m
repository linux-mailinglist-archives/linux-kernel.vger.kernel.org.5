Return-Path: <linux-kernel+bounces-140831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972578A1925
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05EB1C235AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F074C12BF2E;
	Thu, 11 Apr 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B65VB4p9"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E471292EC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849623; cv=none; b=fPA8wI+86BsqwAQN4/J2upqwjMmS+da03yIm45rFhWde4OOhrlKT4o31H/qz4ajza+j65JWVAetw6Yn2+NJk8E5nFm2ilwkXlCPcmW16Q/MdSbOEfmGOuI71ZpF5Exz6odG5CO2y98cylKSbhUyx1buR1uJnmCpmwzSiNKmLqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849623; c=relaxed/simple;
	bh=WNAX5SJpcq0j8O2B8qpl0MAxfztr0WzIybgaYGlBzBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqH4ZjBHbWC+n/EWtHlxixiTpWIfRvjDzHlzaMCfb+pZsVdTEDILZVXBWaf8MH6qmrhw+YZWTJTquMQTGWnTei8CKt4ohn0IpryIqEvrT9blpXsIGbrciX+yV8A5dKwNntdWPGPUAl8sqpGJeh4aBVUxNI+2BA1pxnfS6cWKmG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B65VB4p9; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9735939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849621; x=1713454421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVT7B+DWzQgD/wpg5m/fC11AaNvArZbFf8tVIDElahQ=;
        b=B65VB4p9vR/R/xo+QAZh1l64Ezt1Z/xtd7TgBj4MqcjkjyDYf6qhtfEKuPvYt1SQpd
         q7YCAa5PidZ77VjZr1LCG3NELFzMVS23W5m1ZvhfBqdnLwxuOTVPSEVDoNXTty1dCuWS
         YUNlmITQk4h1UV5nX3pvFMm2rGrhM2Po10pybXHrt1lpHeR5lxrQO8KRFBpIddrcMuUn
         x0QX+AzSnrMszjJjJgKzf2LFyNJ2YwLLjAvSY43lI4eNuu5t9+BRQhSHAQHRHwp9lOMm
         FmTFv/nFs7LCbagAXtsLtcsBHYoe7dNpbctQgHJbWsNM2ux0jU1TybhEb6XLvkU2g0Mx
         LdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849621; x=1713454421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVT7B+DWzQgD/wpg5m/fC11AaNvArZbFf8tVIDElahQ=;
        b=PawWsHPdT7WvK3nFTEnpHfZTUGFdT/65PMD/gm0dmcegMgD3iiZqB9j8nCFYOnpHdZ
         B1sfeZAhU4UMA8TK5TKKJ4AaZu+ykG4geBMcYQJPgMlU62aIO52A6Y6aczj67fX6/vvI
         geH7pST4WkVMiLxiXrtejc6GuF2ZfgdIC1OAPB8W0AN2BmGMZYgeCWUEK4NyKxTGw4e9
         Cjk7gOhJf/I7l25wQHxwRZKrMI6HlgdJjx7jmahIQIysC4azH0cbCDJhhtO1Lx9Ksaoy
         BqlBOW/k9gqxiXB3rhhhzTkw3laJ3G2V22uYmuHHZ6eKfs5h7EBgD0L6AAKGJUkFj+gX
         EJCA==
X-Gm-Message-State: AOJu0YySTbhIoOyjbZhlTbXEsjIPfqbT9xqIU8AFLoo9m8KcCwzIocg6
	qaAyYAVIY8ac9+5SM2iX5NAOrP7/CA5rA0MYlAaxHDw+qfQwJnlvYns4xdm+gfT10fNnRIRMkfH
	c
X-Google-Smtp-Source: AGHT+IGsQpJIEk0JpLHIp2BKx3R2XxDhfoEWKjBehBQCOQy5is92YOU5mFa+l0f9ryCan+BXK9sApQ==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr208672iof.0.1712849620845;
        Thu, 11 Apr 2024 08:33:40 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 070/437] perf: convert events to read/write iterators
Date: Thu, 11 Apr 2024 09:13:30 -0600
Message-ID: <20240411153126.16201-71-axboe@kernel.dk>
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
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..2c94801bef4b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5688,6 +5688,7 @@ perf_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 
 	return ret;
 }
+FOPS_READ_ITER_HELPER(perf_read);
 
 static __poll_t perf_poll(struct file *file, poll_table *wait)
 {
@@ -6669,7 +6670,7 @@ static int perf_fasync(int fd, struct file *filp, int on)
 static const struct file_operations perf_fops = {
 	.llseek			= no_llseek,
 	.release		= perf_release,
-	.read			= perf_read,
+	.read_iter		= perf_read_iter,
 	.poll			= perf_poll,
 	.unlocked_ioctl		= perf_ioctl,
 	.compat_ioctl		= perf_compat_ioctl,
-- 
2.43.0


