Return-Path: <linux-kernel+bounces-141098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08698A1A79
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBAA1C2316B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1544F1E2472;
	Thu, 11 Apr 2024 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q8EE2IZ9"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84451E2445
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850033; cv=none; b=jU02NINGj1P/B3hTrW5SggbF5YFqQEn2nxJMwAdfQl6wbVXAB4RkeHB8O9QykhFaau9xMIJ1wuexh5q3hXX8IbrzgEX9ANkIBKva771BduXu/WR+dXeCHpO+0B2UJdEYSgJnVqxINXZEPTEUWc8zNCnE5M1T3291tV3htCJl3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850033; c=relaxed/simple;
	bh=DtbXY7Nbzt2l7tRam0s8F010xFLosfo6cG8JlTrgnPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtSIhHz0nLxU6c40Vc3rnbkGwGCJ6EE0m0ip6KcSBhhJJkh/2qDLW+L7+xfCnGkB/6GnPd8Oczd9vwIvOFlpBr0nAtp+D1Pp6FcQe44XBHcjMJKCJeSMvFBcD7svk1yR22CWttB2Pr2u/3emnoPhbh9Rgfqf/MqotO11hvjHTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q8EE2IZ9; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16236139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850030; x=1713454830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WClei6ULlpsgOoTLr0NwCdIDuB43qLDVv4pP2GKw6E8=;
        b=Q8EE2IZ9znW3+iUdvywD4c/+J3ZeWNhJweXK/oGqadFEhrBHXyHfuj4T/u14Y738V5
         a2/05VCzLv2J6zksZS5nf2BTUyN/k9WcTjRkxHVWMmiQfjOo8EsXl5uMRLt2dFWZcp6I
         yrgUm4GBk+6Nnw13XHY97iWKJ5ch+ThmZwaPxVcyRL56d6z8C/8aoXcxpcEOSqAnJvl5
         9yY3acOHoz6ozHRLcIq378+vJ3SP0/RGMchGJfirJH9LgrPIyBdcNWAvr3ZCut6sR5Cm
         1P4cTLTR4fH0ujEnjtBFASN8bSUdDyUcRTjO0Dxzag1yJNpjL0y5DBT9vbH76ibVM+WB
         0Rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850030; x=1713454830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WClei6ULlpsgOoTLr0NwCdIDuB43qLDVv4pP2GKw6E8=;
        b=Xr7GyvrHeSBeQxZ4CfNj9+bGKlgSXpZs/LRZGHGfGa67k8ZAFUpXfwBgrvRTQbf7dE
         wkqNJGPByJRnzr5viy2jXlnnSHw8kmBytq/hQPy17dsiG4OUl0PLwSdUlrHAjQRzHgmt
         v3rlJ83QmAp8rqqTL2HD+xHkNOJTf/3VoNs7GMvAYPH2+IPPX89bWWUkREewTvVEIhYR
         RC45NWHsFKeBpW95/+XxweUX64KbqiGBMQtXgVfFtdrTULwyHTMEM9NJ64wZ6n0qDE0I
         JMSpMT0Hsi2+fSpteXws3s0THSeJ+MsvTF3HLopI8PkcK//Axwn2CBvyBLGPwTpLUrjB
         rBfA==
X-Gm-Message-State: AOJu0Yzul1zyX8nTy7by/EGmrToWVr/Vx+TrBeXjrN3eBTHnymlrHCA4
	HC7aSAfHllyLW4L7tKqlgXb0tuBnWi0YpwnzAGl1QrYYk3Kq3Cl5HsTAhJmA/Fz9vHwIRgbe+GF
	p
X-Google-Smtp-Source: AGHT+IG0CzTwRrpHGEZ0NGQwIy0whTQ09dzWBKuH495u98ALOlpBtt2b9dTXcaLZJ3BARHA6qDTC7A==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr173239ioh.1.1712850030523;
        Thu, 11 Apr 2024 08:40:30 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 320/437] drivers/net/brocade-bnad: ensure the copied buf is NULL terminated
Date: Thu, 11 Apr 2024 09:17:40 -0600
Message-ID: <20240411153126.16201-321-axboe@kernel.dk>
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

From: Bui Quang Minh <minhquangbui99@gmail.com>

Currently, we allocate a nbytes-sized kernel buffer and copy nbytes from
userspace to that buffer. Later, we use scanf on this buffer but we don't
ensure that the string is terminated inside the buffer, this can lead to
OOB read when using scanf. Fix this issue by using memdup_user_nul instead
of memdup_user.

Fixes: 7afc5dbde091 ("bna: Add debugfs interface.")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
index 7246e13dd559..97291bfbeea5 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -312,7 +312,7 @@ bnad_debugfs_write_regrd(struct file *file, const char __user *buf,
 	void *kern_buf;
 
 	/* Copy the user space buf */
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
@@ -372,7 +372,7 @@ bnad_debugfs_write_regwr(struct file *file, const char __user *buf,
 	void *kern_buf;
 
 	/* Copy the user space buf */
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
-- 
2.43.0


