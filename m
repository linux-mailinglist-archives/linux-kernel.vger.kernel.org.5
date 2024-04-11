Return-Path: <linux-kernel+bounces-141018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF10C8A1A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07271C20A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E191C7891;
	Thu, 11 Apr 2024 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="l/6us2eA"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F441C6614
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849910; cv=none; b=iHJAGSmOt9loMg3EmG1YNKJd6M6qFxssSY301uLXREY0V00dHpcShlMwzomGvUlVse5ovcu2RJQkK3jegfegobY0vdtwD1uqM0laP3qNP2AQw3fgzLwkh4+SJRmHSwI8p1vH5Cy4aq5fdj5mZf2o79bo3eR3+gX1gbjqzIRCtlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849910; c=relaxed/simple;
	bh=+IwXRNokeWhuKQAbLUvjR7gXm5aqUPimPCYVp+GDpH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3r27vlCwIY0qeOIUF8Qcjcxx9eBIscvxxNUkCIE0NZelQVpnSBe6GlV2tViqEfXwQdQg+rZ780oOtW/mxdNFk9j6OT10eLsbIHS7ZgKXjXAfRIChUIysOo4SPofKMOfIYa//kqw/ijRkIxDEnDmeUEFD8PRanBDDbpJAV+YhJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=l/6us2eA; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16197739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849908; x=1713454708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wBNOT3qBs3L+vPl85zEaCnmdS1VUYoqA6qMqegfI90=;
        b=l/6us2eATqk53WQ76S6+qcXtvHXbhNVv7QpFVxgZEhLSj1UAncR58rijRR3QCPUjgK
         LDd5QU+PcZZrIdLMKqxgVlpMx9UeBXPb4e/c00uC6RfU0rVLPPX7+rJd7kRBm3EIbrKy
         OmYUH/zOskFHtDh7r7auZ0m27DFDgbQKV++YyYDgjG7VEj14PqCCvclEKcnM0V5SszV9
         pvauRhC+nm98OdCVD9vpXIh7iYPsjz3kbgaai60cZkkrepUPkSw+3DMoCtzdfGMqwvsg
         XTwriL1iFTZVyE4ayHP25yCqtWD7FDYaPnH8KhGPEyYgo38G4O7vncxiyoiHTi9wn0rd
         DsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849908; x=1713454708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wBNOT3qBs3L+vPl85zEaCnmdS1VUYoqA6qMqegfI90=;
        b=GhFN6wWA2ZuhIuppuyqDnjyoVtvhgkf49EGIN3+T1MzZhLCbXRBMkvsqWcwfXPVTDI
         DsxBKMBG3S+piioKMVF0Z34y33pZkKP3dDJ72ilB580uXMhBiLdt/oBCG432TLsBwwWp
         bytsW8Lv/rQuOL7U5qIPEeo3gTO06xKBsrLDPODYdW4XIamx9LdlaXJM6u3SahV4TsnF
         WP07Nu+bgLUwsNjtLiAzViRsPTbPQiWklW0J/LHKeKOE5X0P8YybCRV/mzLA4+1L4mLs
         hGRwkSW2lTsVTuFvCE4kaetxtzYVAWU6oS0hXsfgnBw7fwFfrjLQL6GFdtPovydsxRDy
         90rw==
X-Gm-Message-State: AOJu0Yz817U6NGZXRNeXSUhrdfkEmmDHMRI3LwLQ6fDjn7y9dxUMg1hu
	Z+7Y9HG8impvUfzjPM1tXv/X8y3YKqmMrtC+zMs10qUa9KOmNUuVGIDgkcNB6apYwl/4Ol3Ruxu
	x
X-Google-Smtp-Source: AGHT+IE/oCPwP51bVh8500g6VRMlGGJDRvP9V4RPf/6KCltUvCCQGADu8MDv2+0V4UJo1Ewu/sYiWg==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr192183iov.2.1712849908351;
        Thu, 11 Apr 2024 08:38:28 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 245/437] watchdog: mei_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:25 -0600
Message-ID: <20240411153126.16201-246-axboe@kernel.dk>
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
 drivers/watchdog/mei_wdt.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index c7a7235e6224..c930fb5b8fe1 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -491,10 +491,9 @@ static void mei_wdt_notif(struct mei_cl_device *cldev)
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 
-static ssize_t mei_dbgfs_read_activation(struct file *file, char __user *ubuf,
-					size_t cnt, loff_t *ppos)
+static ssize_t mei_dbgfs_read_activation(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mei_wdt *wdt = file->private_data;
+	struct mei_wdt *wdt = iocb->ki_filp->private_data;
 	const size_t bufsz = 32;
 	char buf[32];
 	ssize_t pos;
@@ -504,31 +503,30 @@ static ssize_t mei_dbgfs_read_activation(struct file *file, char __user *ubuf,
 		__mei_wdt_is_registered(wdt) ? "activated" : "deactivated");
 	mutex_unlock(&wdt->reg_lock);
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static const struct file_operations dbgfs_fops_activation = {
 	.open    = simple_open,
-	.read    = mei_dbgfs_read_activation,
+	.read_iter = mei_dbgfs_read_activation,
 	.llseek  = generic_file_llseek,
 };
 
-static ssize_t mei_dbgfs_read_state(struct file *file, char __user *ubuf,
-				    size_t cnt, loff_t *ppos)
+static ssize_t mei_dbgfs_read_state(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mei_wdt *wdt = file->private_data;
+	struct mei_wdt *wdt = iocb->ki_filp->private_data;
 	char buf[32];
 	ssize_t pos;
 
 	pos = scnprintf(buf, sizeof(buf), "state: %s\n",
 			mei_wdt_state_str(wdt->state));
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static const struct file_operations dbgfs_fops_state = {
 	.open = simple_open,
-	.read = mei_dbgfs_read_state,
+	.read_iter = mei_dbgfs_read_state,
 	.llseek = generic_file_llseek,
 };
 
-- 
2.43.0


