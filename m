Return-Path: <linux-kernel+bounces-141133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C28A1AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AECB28B8A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11CD1EBAB9;
	Thu, 11 Apr 2024 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uY5XPIkL"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF3B1EBA9C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850091; cv=none; b=k09QiwAVSi7fC++jwFHRtfQuzp4/FFYkEgJFnL7O9Y0lN2VkbbfnsRAlprnkUKbgbnfE4h3rvxwQSvEeOy++yaaah4i5DFIAUEngsuiHHANEZlbClPFQ192MXSIvESgbnjTxIDYGSp9zfd4CgyDxtEd/7pl6Apq2sJj4VA0L5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850091; c=relaxed/simple;
	bh=SPTYduIfH9p1qgicSrY0/kgQ5zph5BcuFxjiCI5eHrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyvFsM76WkudO/5ihOA3N0Wa1N9wwRq2YzO8vtEVdRLo3Wmqssf6IXcOkjx2vIpUFXptghgpBl82AgCfdsGFaoOJ2BLL6X3qSiQhlTm84w/UH72kmRGDLffmHcjT0t6fcynuDK4EPu+vwSK7o0w/VEXCtScn3gsGxs7uj/tX5HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uY5XPIkL; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36a224d7414so194975ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850089; x=1713454889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0opaX+8vRYcNzgWaP8rJvrsIYshzJ+i+ilu4pihK1VU=;
        b=uY5XPIkLo1ACgYXJ29Ia0TKq1jNe1MbQ/UcVsAO1UQDZrbkgTGbU8nDME42KGhUN3E
         ks9E0zhqk1JWaqgeHzS6yUv0a4olZ0R2MVyrW49r8QNPwV9ttoopYbciZXUpqCPbqIFR
         hVRHJuvpwZ/8OgdRai7Xb0mMBpqf8rbVZ276/QzfdNLxK0SDBsmeMEyzzc7n7WUvC6f4
         LicNdcECucWENcQh+7KCYX8IuTsrqmcF2r1mEJNnP2gfPYR6+q6vJX84+ISpCJDbnafC
         m7LFNrIFm2bDhe2GOq2taNJEWzx8J7xcJ+N8PomiyMlQGCJoZB0y7PiQuSTOqCTSnYwq
         eegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850089; x=1713454889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0opaX+8vRYcNzgWaP8rJvrsIYshzJ+i+ilu4pihK1VU=;
        b=RPygfJaQVdA748N+wLzsi4CpzXME5sb1CUvqbiKAvGdGzVEzt4Axq3Irh6B1ZXQCjf
         XvL/R1ZRl6dmwGF9yGKgaYPBbjwR1eZgaigpawvsn0/Cm4Ig01XZZOOBC8Cn+6bgjcCq
         SuxAj8xDXT0udmX5w8MKhp7AEuH0yAwAP1pe3EhWmpICeGT6fPD9Z9sRI5XS6N+/voUE
         2RG9/Lkhmp5M1QnfVXuZhAWpfo1maL/s1VBo0cj5Cb7BxKdA/OHYcRBLx86CO5sXvK+E
         Zx05F1tM+97C491Ja6pcb8kZwq7uNduktIiwcEPomm23yrRbvx5aBuNzjOTcbBhU/Mt+
         utag==
X-Gm-Message-State: AOJu0YznkY/gSztnr3D8HVswrdCcAb7QnvytOd3kim4NBA/qNWk+aO5Q
	Ys2ep3ZCjCVAj25P5RmYKWJFZzAN6mcWvfLrENF5znNlALgaBpcD1VmYRYSUBFZtY2HTgro3rWV
	0
X-Google-Smtp-Source: AGHT+IHAtDAxWuexCXOLLZYck5wWY4tysTa0I2u04M+TcmbYGQ9VRExVQYpJcraVe6qDU447kCLgtg==
X-Received: by 2002:a92:d812:0:b0:369:bf80:e367 with SMTP id y18-20020a92d812000000b00369bf80e367mr6255000ilm.3.1712850088780;
        Thu, 11 Apr 2024 08:41:28 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 354/437] arch/sh: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:14 -0600
Message-ID: <20240411153126.16201-355-axboe@kernel.dk>
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
 arch/sh/mm/tlb-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/tlb-debugfs.c b/arch/sh/mm/tlb-debugfs.c
index 11c6148283f3..2ebb9db3ffa5 100644
--- a/arch/sh/mm/tlb-debugfs.c
+++ b/arch/sh/mm/tlb-debugfs.c
@@ -142,7 +142,7 @@ static int tlb_debugfs_open(struct inode *inode, struct file *file)
 static const struct file_operations tlb_debugfs_fops = {
 	.owner		= THIS_MODULE,
 	.open		= tlb_debugfs_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-- 
2.43.0


