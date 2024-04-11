Return-Path: <linux-kernel+bounces-140834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99F88A1927
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5431C235F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FD612EBD2;
	Thu, 11 Apr 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ih8rfIvw"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD612D212
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849628; cv=none; b=gidbu3Via9ahotFG4K9UzPX8EIV7NkA+gYiJS1gT8+Rohg16VCFwa89GabpRhg4hDENznFUwFYxCDeAl+DP2V7XP0/CF/lv7t3mD0T/z4O8iqhpCJ7+rfA4S73au8HzMG14iU4JTJKhsxanZ8Cofs6+nZNnCpEd//h6d7vyKoBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849628; c=relaxed/simple;
	bh=VxGIOSbmJNHl57+T+eQDoBv7R+L3GV31kW2p/1LagqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGXP3M3XxXMITLzBiG93Zt/fw8GcRc5Mb657kJoxh47f6Q9w/vvUntKSwc1kFPII6DxIB6jHT/Urz7FJYOWEqxxcY9WJRT85w4prHDK/HSquGd9rr50oI9HFurQub7W4zn2ko1PzLI8H2sksL5Y1gsWX88BYcHa6WMxaImoVBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ih8rfIvw; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso57997939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849626; x=1713454426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYsRXQhQcCZAbXowXwROjWn4Do6HHtwX4uKjJCPFiR8=;
        b=ih8rfIvwE1d0jOVPMG725H5bjgeQuLjxz3/7RQKJgKGONyD4IiJBqIOjpDXQAXVoi8
         GyxfGFyqsWEUxPIdv/7eTANPpcfMfBHgYEcTTcJMlfX0kpdMZsojE49KqF5S7yPSCcam
         lyZObIxeb1ADGT/UXQHOx1GoTPtTK148ysMi0wXwJVXMW1MyAb3/a+uVkdCk75nXmc4w
         Z9KqkstYTZZFxhHOl0kkWc5uTLVWOTHMQhR9y1XquDDRhel/21TY/kiQBFYvw7s+hk4T
         szr8SHjPkv6YPR+mRy/hxTcfTt+NDOc1c9W4eCOHOM+lpppb4TxAEsERhm4Vsm2p/Bqp
         RB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849626; x=1713454426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYsRXQhQcCZAbXowXwROjWn4Do6HHtwX4uKjJCPFiR8=;
        b=nPeFuaMI0cKHytzo3E97cl3K2uhqjOvoMZB65Q6M/Imff++IzMosUkcrPJUMIF5R6q
         SmEMPpi6MLFm5EhzWmJhnAk8Ms2X8f7xKESEs+rDhgEZ393pUsrufu5iXAgr/irKX2ku
         2OPXsuaJhbxlnRV5zsql0pyXXPCIQLSQfFXXCk1m6vgyANMnEsfEy2ovKz5BRXoeLXLd
         GridJCd/mZql35BEJoNy1clR6L0A9oKmAjkupWTGAeK1IzsfIJ2Pa2pTX3cSIcpkQYaa
         1PcgSXBm+znLj115wXHO1SlOITbZ8fscXDfSwfFymmjRwT6ozgfzsjxbSpyeEg4vpzDY
         zwkQ==
X-Gm-Message-State: AOJu0YyCVIGzU2PSOj2135Ln4fFr1UYfcz1jDAvKmQpI/c31hHLrloiH
	rqptZtWcp9uQhz5eQgaNErBR5OAwj4SEI62LueT8SglMsnXTwOESkP2NYkW7fTj5hf4/RnaTRTv
	p
X-Google-Smtp-Source: AGHT+IGqRTth5wBZFEZ7hBquRNqY48DRGmDPsUOCNIK3TNdvzQKIGLrOCmF8aJe8BIqgNAOpFAVl8A==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr175795iov.2.1712849626045;
        Thu, 11 Apr 2024 08:33:46 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 073/437] kcsan: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:33 -0600
Message-ID: <20240411153126.16201-74-axboe@kernel.dk>
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
 kernel/kcsan/debugfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 1d1d1b0e4248..71f444ddc27e 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -220,14 +220,14 @@ static int debugfs_open(struct inode *inode, struct file *file)
 	return single_open(file, show_info, NULL);
 }
 
-static ssize_t
-debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *off)
+static ssize_t debugfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char kbuf[KSYM_NAME_LEN];
 	char *arg;
+	size_t count = iov_iter_count(from);
 	int read_len = count < (sizeof(kbuf) - 1) ? count : (sizeof(kbuf) - 1);
 
-	if (copy_from_user(kbuf, buf, read_len))
+	if (!copy_from_iter_full(kbuf, read_len, from))
 		return -EFAULT;
 	kbuf[read_len] = '\0';
 	arg = strstrip(kbuf);
@@ -260,9 +260,9 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 
 static const struct file_operations debugfs_ops =
 {
-	.read	 = seq_read,
+	.read_iter	 = seq_read_iter,
 	.open	 = debugfs_open,
-	.write	 = debugfs_write,
+	.write_iter	 = debugfs_write,
 	.release = single_release
 };
 
-- 
2.43.0


