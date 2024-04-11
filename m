Return-Path: <linux-kernel+bounces-140861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FD48A193C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC881C221EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8928413A3E5;
	Thu, 11 Apr 2024 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3DP67A3L"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944EF13A242
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849670; cv=none; b=HLqvwz0sXhnQPd9TfvydeVrlh6E+uzJi/mYMScZxoGigThi0fPtTIUJp3IJon3P+XbwPOyjYXf7ws6lZxuGBrZS9BqvFXYRgpohNG7uuctNPx3Py8FoBEl3TubfvW0x78H8jGOTuBBJI0GXAzj9VQ9jHn6v1ogftVW51WdxbB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849670; c=relaxed/simple;
	bh=D2gX1Yo2kaknxa6HlOQaS/IuzMCcbuETGQKREZ0ah9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqMnMAZ0CbuxBB6HtMPn10oaRZIefrPEG2pidu+CtMPy9f9Qg2L9gFPYr+f325WFn3319gTGxI2scU/+9k4gI96EQySG2yBcrj5gzLif+DYmbo18NkGM/ALnOoD6Cwd7V/BnDwR7rXEgwqJi9RAi67Q2xeTzDwLSR8/BXPZLz9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3DP67A3L; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69533639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849668; x=1713454468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQyRbapRDHKkd6lSiAZILxLe7t//FFdqCDBswhYBpjw=;
        b=3DP67A3LzBPFENk1aRc3pyQVPMfsWsh66VVgPKK7Tc8VaPznX6YZNJALV2msdgLOml
         2OjH9sXnSgA/etcS/f08fOn7bGV6ZLS7Y0p+FdDYcKUv8oOTPZeTSPaJDbiXEJMWNgaI
         3l/Mw8QMozpNrhwgPZBw9RvK0d1I5ZC1Ugc4w87bXGloGHIjT7iL91i4s5zIudazwfh/
         xLtXywQSR9Csm6fK3ciNwz6EPMVEMc/r+9I94gq/xI+TQiX75W1Ox0jkjbfB03Xm8H0K
         PHxoOBuRb2JKeE9rQ1HuoSp/JWXwImcpLv9u6W/1viCbhs+maCccyd2BRT0a8gA/SlHp
         s8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849668; x=1713454468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQyRbapRDHKkd6lSiAZILxLe7t//FFdqCDBswhYBpjw=;
        b=h4odM5IWwPsyUBFLTnUKXfv12JwmVPrCMHQdX5vu6W0o854st6UdLLdfqLGmTnJBly
         Gx6Rq5aPNk1KWo2kBFSgwEzHQ+MYWWERqkvPSRjeZwpsaWjx5sjcYIZKBVYjkSsijKXW
         8DMlG0MP4tDJJid6uLhZ0n9iWHLqbfZrKOurqgLC+fmN7IUpJDJoPRwIYs01mMaCVXl6
         tRT6XEI5RYQNARUq6p6Mjh27fqj1+ip+FWUDMcK80SOoHDgajZav7N8NH3QGHQQ88fTR
         cEfaH3YT1x818FOZ+53NgRMbaVkw5LR1hYcpUDMxq1Pt3d0I9dPEfwH7Ax1Jb8WxE6fl
         pbYA==
X-Gm-Message-State: AOJu0YwsbPGJYayA944w+vCrq3W/Q8jIp/NoOWZwAPZbKBcYRjVjzaNl
	4Th1g5Plpn/dJsh/zDXEaxVkPnhcHKnUzoq08e5bJtfi0BM+cDn4ppJ9uaR1nk02+nO++i5PUOL
	2
X-Google-Smtp-Source: AGHT+IGLsauauvSziZcIxLMgCuedyXt2r/Hj+GU316EuXRp6vcA8YHrdwOaB4/g8O4vAeRbbPWwePA==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr211692iof.0.1712849668496;
        Thu, 11 Apr 2024 08:34:28 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 098/437] drbd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:58 -0600
Message-ID: <20240411153126.16201-99-axboe@kernel.dk>
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
 drivers/block/drbd/drbd_debugfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 12460b584bcb..b23baa80eb37 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -457,7 +457,7 @@ static int in_flight_summary_release(struct inode *inode, struct file *file)
 static const struct file_operations in_flight_summary_fops = {
 	.owner		= THIS_MODULE,
 	.open		= in_flight_summary_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= in_flight_summary_release,
 };
@@ -565,7 +565,7 @@ static int callback_history_release(struct inode *inode, struct file *file)
 static const struct file_operations connection_callback_history_fops = {
 	.owner		= THIS_MODULE,
 	.open		= callback_history_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= callback_history_release,
 };
@@ -612,7 +612,7 @@ static int connection_oldest_requests_release(struct inode *inode, struct file *
 static const struct file_operations connection_oldest_requests_fops = {
 	.owner		= THIS_MODULE,
 	.open		= connection_oldest_requests_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= connection_oldest_requests_release,
 };
@@ -757,7 +757,7 @@ static int device_ ## name ## _release(struct inode *inode, struct file *file)	\
 static const struct file_operations device_ ## name ## _fops = {		\
 	.owner		= THIS_MODULE,						\
 	.open		= device_ ## name ## _open,				\
-	.read		= seq_read,						\
+	.read_iter	= seq_read_iter,					\
 	.llseek		= seq_lseek,						\
 	.release	= device_ ## name ## _release,				\
 };
@@ -859,7 +859,7 @@ static const struct file_operations drbd_version_fops = {
 	.owner = THIS_MODULE,
 	.open = drbd_version_open,
 	.llseek = seq_lseek,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.release = single_release,
 };
 
-- 
2.43.0


