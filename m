Return-Path: <linux-kernel+bounces-141035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B958C8A1A28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E2D1C21EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534361CCF1D;
	Thu, 11 Apr 2024 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ptijERZZ"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BA1CCEE9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849938; cv=none; b=WmIqQbbTBBScAyNzSa8D33oSuF4esfeE4g2CfAwnA1QdkX3hHsfGo138RA3qWjRpf2Lbeq5Hlklh8k9eO8R6zguL+61AGWx5NkycRBbmlpZkq64ZevDOm5wmNvFqCOrVtVaX+st+y/D3B176IJXRLz/j8BqOi/SZ3Gptf81pfVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849938; c=relaxed/simple;
	bh=uz1UIVkUObBVPUP9l685tSTHjPvXyiUur4zY67F/rRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6ZRWMiqirBnmWAWn6sJXgQ6PPd3uz+DQlfnNziBXZE0BTURb77gho9HYOpvOD825+yj0pLli3Rx7A3fGiDvz2zsinceseZy7VNR6tUaSfSTCdm8SXyJYGtvBJ3/I6r03TmKbArghHj1XaKtwmBAa7wcR0awG766GRiH8vx5hb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ptijERZZ; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9004539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849936; x=1713454736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugjaLLgj3DqyxTYX0rLANZyd9K+HJWGaprm3UVS6Ptk=;
        b=ptijERZZ+hNLqe7LeHiB8K1IT+KyBGs9RBTsV7aZ1doEdSBNPMhFA3PWOOe3hsB7aO
         lzFWYEdlJ8t/pNRhEMzrpnPP6HV/xTvYvDN8kTg3wdNon8a8EW/M2X8hZVLa1DLDgyzO
         yaXqLqhUrDRLekoFiLpdCjZFKIlh0+mbAARWuR2apfJbVGMdh2nd+Pquvho+++4Aztzy
         XnO4LE8PP4ujqRcMm4ZEqFvhX99Uhubo4imMQ050O9sL0/GL+t9Dq9WfNxPEncFb7fDU
         W0ls6EtkH2HZGHtmFNnWNwDZWCjC48mkfARmaqEsGzzPVXMznTKq9+tGh8ouAhCMGpZQ
         LDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849936; x=1713454736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugjaLLgj3DqyxTYX0rLANZyd9K+HJWGaprm3UVS6Ptk=;
        b=BGUXwFO67qOUY4BHMCvsVGSkFtXyGUfSIVPP9MFSJnIF85qJtUDbEgY1kj/zNuMWMM
         b76g2Tc4CFvNDl4fXZcR2yFr0bCKIGjRPVViRDRsR7pkFvSEG2aXo3hrrtuz6XjB/yIW
         XOBNQTXe+jrojuw7cuKRTvENtdLHwIm2DdmI/h/YZ7Taw86An1YyjddUAwTkqRPi7e1X
         fH0uNnVzZgYPuTzYHfagTYElzm02vxWAKTHm8rdN7SU11BIvMao7hQxA4d4H/l4JMduB
         I/esc155pT9V2JmM4wQ93JmiMNMoq5+TcGgHl8p5Smb5Bh9ev0VfM6nrI2TEN5lEN71K
         oetg==
X-Gm-Message-State: AOJu0Ywp+pTw8Nvu01+l19JaBZ1PpKfO0ToFSn8doc8xuzZLXlhkys9v
	DcDMQog+WcsxLs7NmFGVNU493xfO2U0YK3bSrWiH5MrOV4KptgGqgBvgxKDGRQ31H9zHmexywGC
	N
X-Google-Smtp-Source: AGHT+IHe+5XMhbQ2lmBmBEPOkYPj32y9j/v2NNNtoHb5dH3ecr3shfz+1m8qD3fCNMO7Iwb7JBA3JQ==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr188442ioj.2.1712849936220;
        Thu, 11 Apr 2024 08:38:56 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 261/437] watchdog: wafer5823wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:41 -0600
Message-ID: <20240411153126.16201-262-axboe@kernel.dk>
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
 drivers/watchdog/wafer5823wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/wafer5823wdt.c b/drivers/watchdog/wafer5823wdt.c
index a8a1ed215e1e..64d6317f058f 100644
--- a/drivers/watchdog/wafer5823wdt.c
+++ b/drivers/watchdog/wafer5823wdt.c
@@ -91,9 +91,9 @@ static void wafwdt_stop(void)
 	inb_p(wdt_stop);
 }
 
-static ssize_t wafwdt_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t wafwdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	/* See if we got the magic character 'V' and reload the timer */
 	if (count) {
 		if (!nowayout) {
@@ -106,7 +106,7 @@ static ssize_t wafwdt_write(struct file *file, const char __user *buf,
 			   character */
 			for (i = 0; i != count; i++) {
 				char c;
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -228,7 +228,7 @@ static int wafwdt_notify_sys(struct notifier_block *this, unsigned long code,
 static const struct file_operations wafwdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= wafwdt_write,
+	.write_iter	= wafwdt_write,
 	.unlocked_ioctl	= wafwdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= wafwdt_open,
-- 
2.43.0


