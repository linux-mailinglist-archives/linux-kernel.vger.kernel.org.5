Return-Path: <linux-kernel+bounces-140908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05428A1989
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE4C285DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A1716130D;
	Thu, 11 Apr 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RCrX26Fc"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17B15FA8A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849744; cv=none; b=gx6GqPLYmGV3UNkutqStAt4uwnITYTrvnR+XfU6stQqq5zeAzdeyzqXBOiORoBQp0Z6wcuShMShWlAIpqE3cG5u3xDBzXrOd2DnAWHFu89hM44NwGYQyXB6SkkbvqVA44XifW6jjbuleR3UmtqPvKjUmcA8DkEEyHJKWRapagek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849744; c=relaxed/simple;
	bh=gL5rAXowAGRcXaVBOvm9G+t3o9spcMoINLf7As2dKXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuaTC2V4N3h/FtGUdszkLoJpJVGeX1FwnZCgrCew3kOTBwOwnhbeB4hrUOGfYDmfhDUtuP2TpznwRU80iAeCkBAT+v5ZmiiDcjDDzHrVUt4Q1p/iQT+9G7WQwlh2o2p2Tnpy3Xdzn4H2EZYaLRH1F8Q/rbqW85P98b0RjmUa7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RCrX26Fc; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170506539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849742; x=1713454542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3VjsqHvsbMOxlKPUgYkeLDi3mwVEdCEjMoi0qF7dVw=;
        b=RCrX26Fcm4dDMrZ3Nl+s6iV1UfNZ1mZYbC0k7Re7+gMJz7Mj8Rx+ZdDMXMIjlYux/u
         +nHjwHn+DZ0MBuQriQ5oQEBtNhwBbe1Qcl51puwI0vRkasmT13dDHw4Nuhd16tfcFcy2
         QawY0FTak29sHPqOeuPEAiNoIpeBlneJtihhFcFsDTMHam2skNIqLlAMBdYGnMtJp+wq
         IuxmDzSdADAmvDq7lsNjkXONWIhEaF844H5rtdJJcg8vK7eyyhBgAQx5dENdjDtEQG6I
         uoNJGGghIWS2ARPKocuGjg8n9xaYfEPAck+L6PHtHCQPvsxgzJePrK2rMdo742DHPH7s
         sgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849742; x=1713454542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3VjsqHvsbMOxlKPUgYkeLDi3mwVEdCEjMoi0qF7dVw=;
        b=ivD0orqdGGUA+jwPiC9YJ+Wu6H+788FOnGJMkOEycHUyIAD68DlKvczQXFxuac5cTl
         R7vs5xs+zExNyYU2bqWB8XxQKd81uf+hd+Cj07jaJOeGA+7qglwk8I77RnB1zYQ/op1+
         pjQZOAMAbWbLBO2KpgnZxVIPHy1Yc3LSDxrcctj43MsyQz3ycYBidqwrxh3VUxdq5Bdj
         qY8eyk05+81eqJpmKIztJOGpIt/27BB0Hy75etCrmHXqJ1ba0Rk+NwHngEMqu8waBwTF
         P+pFfbzWcVLr4sNeHgC/wVlGVmuVx7/hnmR95i6lGSG6z3fmyeRKYhhBh6id1c/qSGFk
         ThJw==
X-Gm-Message-State: AOJu0YzEWV2kZjFGfA8zpb37ZgVnr0roLkon6qmsIm/W7lYWRIxhsC7N
	nnEPjprXhyqQMlj7Fn+EWcpYTYwN4uxWYsPlwwOUf/kS4B9lAHyPHNrAptdtsDXEYGZ8F7o9Eol
	U
X-Google-Smtp-Source: AGHT+IExv45aBJtRiiUt52E8nPqCRI2CwS9qZlU4Uaf/CSootiAOJ7f/Q3WvQJwhWEeB2UqgoGKl9w==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr14189ioc.1.1712849742432;
        Thu, 11 Apr 2024 08:35:42 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 144/437] drm/bridge: it6505: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:44 -0600
Message-ID: <20240411153126.16201-145-axboe@kernel.dk>
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
 drivers/gpu/drm/bridge/ite-it6505.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 27334173e911..3f280f85d49d 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3208,14 +3208,14 @@ static void it6505_parse_dt(struct it6505 *it6505)
 			     it6505->max_dpi_pixel_clock);
 }
 
-static ssize_t receive_timing_debugfs_show(struct file *file, char __user *buf,
-					   size_t len, loff_t *ppos)
+static ssize_t receive_timing_debugfs_show(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	struct it6505 *it6505 = file->private_data;
+	struct it6505 *it6505 = iocb->ki_filp->private_data;
 	struct drm_display_mode *vid;
 	u8 read_buf[READ_BUFFER_SIZE];
 	u8 *str = read_buf, *end = read_buf + READ_BUFFER_SIZE;
-	ssize_t ret, count;
+	ssize_t count;
 
 	if (!it6505)
 		return -ENODEV;
@@ -3243,9 +3243,7 @@ static ssize_t receive_timing_debugfs_show(struct file *file, char __user *buf,
 			 vid->vtotal - vid->vsync_end);
 
 	count = str - read_buf;
-	ret = simple_read_from_buffer(buf, len, ppos, read_buf, count);
-
-	return ret;
+	return simple_copy_to_iter(read_buf, &iocb->ki_pos, count, to);
 }
 
 static int force_power_on_off_debugfs_write(void *data, u64 value)
@@ -3307,7 +3305,7 @@ static int enable_drv_hold_debugfs_write(void *data, u64 drv_hold)
 static const struct file_operations receive_timing_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = receive_timing_debugfs_show,
+	.read_iter = receive_timing_debugfs_show,
 	.llseek = default_llseek,
 };
 
-- 
2.43.0


