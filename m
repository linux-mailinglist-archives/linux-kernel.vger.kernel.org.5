Return-Path: <linux-kernel+bounces-140913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3BB8A1993
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD81C2833A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABAB181CE6;
	Thu, 11 Apr 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O7sEni3l"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B417F36B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849751; cv=none; b=al0jLqQeNKtdG0lvkdekInq7sms4x72FtaZGLSr45OWfKYsHaktLF0Rba/Qrmu4AxUsJ2tgiMlGeHPk+r/8l/0v2XraQkJb3pMnxI5ItMF2KEG3At8h+g+TQp25SAB204TSJc+q9kGJpldkD2f9bwVEvQDSHCqRlARlUlHrIw9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849751; c=relaxed/simple;
	bh=8CsQmi6ECG3WEyVFlzKKPArXbUAF18VIgC/ow/w19TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+Q7zbzMzmoztus8DD1mTRSqGu1uEozVLTSD2rQjq8JzqC9/rgpM51S0EMLb8LciAC2HEfszfXH/KHzx5iCUjuZ3AbwA+1qtne1iqYnIFlcNTVU/Wx3exiBu68/jt536OKS9iwT7XxGL2lKlh68EdgyzK4cxaKI1QQBFgfNwiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O7sEni3l; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16152439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849749; x=1713454549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sr138yPBoYRmU0mMQ0v7pdiShQVQtzPKpOmz3dkCeRc=;
        b=O7sEni3lIugjxyaD8WKjMqpq9iOnhk079ShrnsIa9Hp+WgGi7nILmdq6S7PiI5qtO6
         ldnYpGHJPkl3boJVckohzglTKPKk5rNrW0gayEOYRxbZmZyeKc3edoe8nO8AIJo1uoVf
         9d/LgQLbf02a7R75P+SWNtDdIJu5iwvlJNFqKhqtiZEjl3qDhvRStOHYb7eEZDhuF0cJ
         UPaH3Szp/fXfm9/9q/HsPxNYrRpIpQDJaPXa1CpN7rd4X26sSwV5VCn+50dEstneft5V
         1Wln8Y1ZOH7HpYdmCQ1anQQjvrs6aluWAKhoycBYraSmKUc7EQnjeJVf+uaA3W+pwcwM
         qImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849749; x=1713454549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sr138yPBoYRmU0mMQ0v7pdiShQVQtzPKpOmz3dkCeRc=;
        b=holt4vEHWSnapaSv59EU8GEzEKuSvK7fMI29lNbGob5dug3APRHMY1l+NMb3APZNJt
         xsjtchOekNMqPkmXVRoB0AMcICYYB2r+eZIj33FJvDJuL5Mq1X2iJRDeXibA5sJn6LcS
         CtSgFVFdG3NYGdEl740jsS15Rmw1QGVKPzhrNOlCzFPXWr0rjjAS1TvCYMs0M+qXj6pq
         xB0j77rb1FSo1hHScuU+WC791EeuEADIzLtjyIdiKKYtE6bzkrcR8X0JQH/OBTAgNow2
         xuEUDV/CG+6Fhi8FvBg7ElB3PfBcGXNFrBjT1FuJ5+tqdfKxJWMeHpK8WBsNKx+gkXFh
         th7g==
X-Gm-Message-State: AOJu0YwUe1Vw++A9maC/CUYaKCGTMU/Zi+izoIBNrS3gXLsNGiTfy9yX
	pgeto/oBWTru3dEPiMT3xxEn0Y/fKydu/docyF7FVIMSzeoTVFlZ6sVz/uL2s/P/Mh/rVic2n/Y
	M
X-Google-Smtp-Source: AGHT+IGn8Xc1vMYhe5ncYuCoNCLuQTTiKxh6YJCR8PhtRg1GiGPw35DqDqcpAo/2IbinqMs8u5PBjA==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr183266iov.2.1712849749057;
        Thu, 11 Apr 2024 08:35:49 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 148/437] drm: armada: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:48 -0600
Message-ID: <20240411153126.16201-149-axboe@kernel.dk>
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
 drivers/gpu/drm/armada/armada_debugfs.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_debugfs.c b/drivers/gpu/drm/armada/armada_debugfs.c
index 29f4b52e3c8d..eaa0384a3bd4 100644
--- a/drivers/gpu/drm/armada/armada_debugfs.c
+++ b/drivers/gpu/drm/armada/armada_debugfs.c
@@ -48,22 +48,23 @@ static int armada_debugfs_crtc_reg_open(struct inode *inode, struct file *file)
 			   inode->i_private);
 }
 
-static int armada_debugfs_crtc_reg_write(struct file *file,
-	const char __user *ptr, size_t len, loff_t *off)
+static int armada_debugfs_crtc_reg_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	struct armada_crtc *dcrtc;
 	unsigned long reg, mask, val;
 	char buf[32];
 	int ret;
 	u32 v;
 
-	if (*off != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	if (len > sizeof(buf) - 1)
 		len = sizeof(buf) - 1;
 
-	ret = strncpy_from_user(buf, ptr, len);
+	ret = strncpy_from_iter(from, ptr, len);
 	if (ret < 0)
 		return ret;
 	buf[len] = '\0';
@@ -85,8 +86,8 @@ static int armada_debugfs_crtc_reg_write(struct file *file,
 static const struct file_operations armada_debugfs_crtc_reg_fops = {
 	.owner = THIS_MODULE,
 	.open = armada_debugfs_crtc_reg_open,
-	.read = seq_read,
-	.write = armada_debugfs_crtc_reg_write,
+	.read_iter = seq_read_iter,
+	.write_iter = armada_debugfs_crtc_reg_write,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-- 
2.43.0


