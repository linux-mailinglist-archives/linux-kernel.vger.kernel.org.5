Return-Path: <linux-kernel+bounces-141031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C508A1A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CEB4B2D527
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CBF1CC4A3;
	Thu, 11 Apr 2024 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0PAaLGLv"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7A1CC484
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849930; cv=none; b=X13FipSDUtkSYRe+/iXWXoGS1ATfakZvroDzzjpCUgO4MpnZ7S6qTr6Iu0YZD4DLv7XSVNWPOBteH4LHH/M4GZTeiI0mc7Pj0lxqnuSQwr2jpT9+MinmuRKIPjTbx0yf4t+VFPVFJQFTslLWl997V26cI09pROUVTVml7vKmu9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849930; c=relaxed/simple;
	bh=7iJXfU5jCucGr+eEvpvjiL4pcU31bePF+ueSaFrtxy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DB9r2UP7pVThlJU9MBtc++UIIIXZ3/szaWN2xAVhyAYsuYRdGdMck2bmMBBbVSEC7DjmouYkkW1yNgBGk8CF6bqA5FYTI1AQOetD2RL19nzloa1QwSq/Ep8XL8QHeBL0SbTSttxZvXAjtXBxwNV0EigKAHnxyn77N4mYwcij7hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0PAaLGLv; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58143939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849928; x=1713454728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhMJhyVPdOsvYcqKap6p1ZAiSgbrC/XhXzgpPRTiZdk=;
        b=0PAaLGLvGLKSUBGZ6pgX9PW9Hz6GYJdjvddYAo5O5sTLm/UFVDC9vSUaXAkqo3z7yO
         vZNmoMZNoTFH+ZaVcLm6CK31oW7W0rVkOpvnST44ECOPm0us3UPRPg0mlWnEicIT45QI
         o41FRJBRv8N2w/SSOPlz3QjccUexqdgN8ga8B6/jNqip3lMozT6l4qC9VDssZrqqiZQM
         EgUjSzMHnEvghAPH8dMLW7gPBikbJJLsu99OAgUBi5clQSdmQI3bcvnCt1V6OM+6Ty2G
         i0CWwhmFbBhzwUl1rBdXjPL0xDI0xf9tlYBbcfBdNwmY4w3JKkOhc+BMaMZP1p2LC/n0
         A9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849928; x=1713454728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhMJhyVPdOsvYcqKap6p1ZAiSgbrC/XhXzgpPRTiZdk=;
        b=fWRHBEWQtSqGqNVWKgM8TWHUPQs12tFopEgtydfJRwLzvFZps3cY47hy1QuPHC7V2F
         uiNkO8a3Y/G0FSRwqDf+02y/G1MM5OLFIb31CtWIsFl/qkd55swtJ8flc3sq8601eErP
         GOWZ6EhUhoxWTAikTUZOGoQNCK3lD7fritjthWmmJRZtLK3+/+PbyUpFaY9F2Gi+V8Ad
         qI1UX/1lZUNVAc768dY7YbXl1vXNriAq+1ArQIUAtVDc6RnoiHb7j4oCtM40e/MKEQHw
         7I8LK4qgJbHVPj4/Yw5NwzQc0sZ8T3cIvcXDa1eD1pgSgOeJ8eARV0sZjFH6Er3mCohg
         JUvg==
X-Gm-Message-State: AOJu0YyYAKuC/lFjtr8/DJr2zD6zgDyvIQkw7NW8Uq9InupdPaDzmBtr
	22EdtUq940eQxrdVvQo034vHVnZ77DkYoWzUsPCtL6oV+c+Vue3tVtR+jJUy0eZiz6Yrh+3AnRh
	w
X-Google-Smtp-Source: AGHT+IGeAKw+iJTqtazdA9um32b5fcrxRWLXpIqGQADo0c9PhtnRjWE1tw2jEDQa9GEpjP7J3A8I0g==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr168396ioh.1.1712849928048;
        Thu, 11 Apr 2024 08:38:48 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 257/437] watchdog: sch311x_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:37 -0600
Message-ID: <20240411153126.16201-258-axboe@kernel.dk>
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
 drivers/watchdog/sch311x_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sch311x_wdt.c b/drivers/watchdog/sch311x_wdt.c
index 409d49880170..2d93a0353e79 100644
--- a/drivers/watchdog/sch311x_wdt.c
+++ b/drivers/watchdog/sch311x_wdt.c
@@ -218,9 +218,9 @@ static void sch311x_wdt_get_status(int *status)
  *	/dev/watchdog handling
  */
 
-static ssize_t sch311x_wdt_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t sch311x_wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	if (count) {
 		if (!nowayout) {
 			size_t i;
@@ -229,7 +229,7 @@ static ssize_t sch311x_wdt_write(struct file *file, const char __user *buf,
 
 			for (i = 0; i != count; i++) {
 				char c;
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					sch311x_wdt_expect_close = 42;
@@ -335,7 +335,7 @@ static int sch311x_wdt_close(struct inode *inode, struct file *file)
 static const struct file_operations sch311x_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= sch311x_wdt_write,
+	.write_iter	= sch311x_wdt_write,
 	.unlocked_ioctl	= sch311x_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= sch311x_wdt_open,
-- 
2.43.0


