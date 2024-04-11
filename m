Return-Path: <linux-kernel+bounces-140898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CF38A1976
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0451C21D38
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7790815D5BE;
	Thu, 11 Apr 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YjbadL7m"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DCE15CD6F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849728; cv=none; b=eN/ziaNGBvoMBHqVmcg/eBR0lxN5p5AJiZ3W8EiznH5PyUedXKDomLzb1k43ofH5uKE2Vj4Mr4Sn+dna3bLpquAMs+G1sW51gWmqW7XR5ocadAZyHFMzuf8Iq/44nVl/T/Wq5ZdcviNVo24OZwLC2plsDLYCG801DktY37r43a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849728; c=relaxed/simple;
	bh=ssup9qt/ICCASL1SFBzGfBbAkeGL58Pz4K18lf7AAl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+rJtXXCURKXfcqb6ssNZIRLRnR/FhXp6ldIGCyUTvr/mtBzetUmkuaguS4snFtwKwWZzcqfJ0PnGYODZQolTy3PwI+HfrxZky2GcAFWseiU+fgTKMcDhmBBDGPVxF/UlMCXeIWVmoj50WO/RbEOwRAyERRiRkk0bLHd9wVZJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YjbadL7m; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8931039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849726; x=1713454526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INWt24tzF3oG6vZUKJt2dqYimd+64Zr7cvlVF8UI7Kc=;
        b=YjbadL7m8iMzS9u4FhG3FDvY3ODh5GmQK6oFFA62nka3hD8K7op3OSGBnrPAo/5DjE
         Ja21mSGldcTu4dGgi7fY9cyVqREIIHT8d76Qj5TGvhbV25XClLnnMm9vZX3RwX95vhq3
         G5x8QqAUdCGIXjbCSYjcWYHDOgnp3CJED6A+wJK4h8c7dIA3iVU8t05HGI/mMbNi4IR5
         VZqSQJlmktBSK9kg5kMSezwbRupYUucly+sHhC9zW5D/wFDzJlQ9Ki2TAI/K9XW2Hj8S
         3AFKDeW9lS4+vTTdIzKC1jZxNAF3/mUaesAuR+SV7Rhz5vm0DnoEaZRvz3VkOgM1TiLl
         38yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849726; x=1713454526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INWt24tzF3oG6vZUKJt2dqYimd+64Zr7cvlVF8UI7Kc=;
        b=f+xCGEBYY9nhsn4RGVMKEzgjxeMHZYL2p3Q494+d5ujts0PydtbV6cQ94fK2pP3BpL
         L3GGmGIARAicOgyaWt3B8kcwU42wJxFXnEmi4a+w4msqkvgf1s8uNeuxvtuJ2jXealez
         kBbsFY2hqKA0JWI1p2x/xhjM0cR0UJY9ZqewHsCZTnlbc2rRmnYVmTGpd9+XlnfLRdbp
         rGzsszinubWqidlF+nL6Ac1Zss36AJ2Cq8MbAuL5wnDkp0cIC0tu3jjzK//xxB3V/VG+
         sFYhExkPzAEvWnY49khbqZA9yD7yKU22C6sbekORq7eKuwBClIwDaTfTn5XzAr0lBb3A
         IL+A==
X-Gm-Message-State: AOJu0YyE3QHbSY45AaPjURiHzG5zQrfPJF4XMvepXCziatDAIXgOaQl1
	Ip/Cr0t8BxTfPE1+vKC/54205ZUN1vX7hwPhPAXeZARaTolPGCbljZrnRmTJeTwBI0QTC+yKbQc
	O
X-Google-Smtp-Source: AGHT+IFrOKStBDjxYlQEGj+QLQh2x1gKfxSfAUPBoliG+L4bqxC/ruyDwEVGkXB+AD3Ld7stgIhrow==
X-Received: by 2002:a92:2912:0:b0:36a:f9aa:5757 with SMTP id l18-20020a922912000000b0036af9aa5757mr3580734ilg.2.1712849725716;
        Thu, 11 Apr 2024 08:35:25 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 134/437] drivers/regulator: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:34 -0600
Message-ID: <20240411153126.16201-135-axboe@kernel.dk>
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
 drivers/regulator/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dabac9772741..92fad0d0fb9c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1810,11 +1810,10 @@ static void unset_regulator_supplies(struct regulator_dev *rdev)
 }
 
 #ifdef CONFIG_DEBUG_FS
-static ssize_t constraint_flags_read_file(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t constraint_flags_read_file(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	const struct regulator *regulator = file->private_data;
+	const struct regulator *regulator = iocb->ki_filp->private_data;
 	const struct regulation_constraints *c = regulator->rdev->constraints;
 	char *buf;
 	ssize_t ret;
@@ -1842,9 +1841,8 @@ static ssize_t constraint_flags_read_file(struct file *file,
 			c->pull_down,
 			c->over_current_protection);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, ret, to);
 	kfree(buf);
-
 	return ret;
 }
 
@@ -1853,7 +1851,7 @@ static ssize_t constraint_flags_read_file(struct file *file,
 static const struct file_operations constraint_flags_fops = {
 #ifdef CONFIG_DEBUG_FS
 	.open = simple_open,
-	.read = constraint_flags_read_file,
+	.read_iter = constraint_flags_read_file,
 	.llseek = default_llseek,
 #endif
 };
-- 
2.43.0


