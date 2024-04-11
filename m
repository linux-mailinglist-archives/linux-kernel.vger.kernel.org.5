Return-Path: <linux-kernel+bounces-141201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4281E8A1AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F213C288E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9FA1FEA83;
	Thu, 11 Apr 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YfIXjguY"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB53B1FE089
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850201; cv=none; b=H5xVNMZXDpYeyPAuXGdoDwS310//Dlqo5AANn9SA9jKm62QKWEiJrg/BGLnGDAbfVnRhbvbhHRHNI/itD8TMCzy8zpYQbtll4+ERf9PH3OjppXpoP0fLx0kC9G6F4w6NdseTkAd6C3sf18OUn+C/OYxsYAuDFQ3dXZm7h5hrols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850201; c=relaxed/simple;
	bh=pFz0z3RTvzcYWyJJDDd7qXVfAelAzL6d+fj9NFAZSWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHYPv5yEB7mJWEtc4IifULO+uozIIIQAuCIaRyM1e4ZHwokE1w0cjOQ0+d2DBsccnmngESt6Xet+y1ZW0KTVD2CSLiu8zYDPE5YHBG20fRbfGNH+RLGgfFqL5/fZZ/4nk8jVzhqgxLhAJ9H43SI8eECSPo+EFvOqNgLc2Dlhisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YfIXjguY; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36a224d7414so198705ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850199; x=1713454999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27Y0LjgrOEk2pZUqQVf1nxtJXMKcYQaQhsDOa8CbZNw=;
        b=YfIXjguY77DjsT2ic3AV0/vidgn1f1SzdX3ihh03Y/y35E0aq8/v2DB+PxdAe46ftm
         F02dvaE0poyTEOCn7+1HGuJCVk2jaGZVmUHr2bT65hAQkhHRVM32TnHmSzdppahk+ulf
         y3ujQMHzJnlv2FBXlKzCVOSXWgDoO3WoX2fC9u+xw7U/MISbVTn4faywGup7EP8HLfhY
         eiyywyT6YmxbIlsIo4/HJW3ik2I7qL8hxVUyHeMRTDjAC1qGIoe9nCvkY8e6enuYv6/6
         sDrMgNiNgZnmJWvo91eInq3UwxLQWm6SltaM5Mvw4616zkxSe4CfSWklJIluMaWK/olp
         Dw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850199; x=1713454999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27Y0LjgrOEk2pZUqQVf1nxtJXMKcYQaQhsDOa8CbZNw=;
        b=tEQWAoqOmwPUj95jkPQYkpPVorb7URMxIwFS485ORlpPBCRAwS0KfDH7qXYLFKiAKA
         SABNiSfdJ4YOXtBHGAj8SAls/ic6hZyKbPMJ+FeT0/lL1xE0wvaNjxVy/Ua2IxINVf5M
         UgFO/A+Wr6uOfToKGaMPV7+2KoPE4o2WDMNu78GQWw6BrUKpSljRavwHUxYZhN39aB3U
         UFtCwAbbfEBDdpwnyodPYs2bted1PdkZdQxI3+0ievdlvShnJHlWLRtEdekmn7mC8qci
         e3THGx13wo7zTqc4hscZMIPeyJrClYquVmhBJq30TaZNikRSXnXH47oyILeAoiI/fo15
         cd1w==
X-Gm-Message-State: AOJu0YzQQh6BhZ3Vs/CtGpxHZAb6MQMSxQg9He3J/CrZXX561eNsbUy7
	4Lfn1QhPZjjPQIAOM05nrEjthyMINSh/Yq9Sfs4gpwhJsuA/J9dBvwRmTb1edca920XMqrDor2I
	q
X-Google-Smtp-Source: AGHT+IHT6neKqFhoRM/P2xZloPUTwGOYL6ROaS6svhjsV5YmpIy9T0peuakr+42w4os4JcPNTS2iSw==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr206446iob.1.1712850198743;
        Thu, 11 Apr 2024 08:43:18 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 417/437] media/platform: mediatek: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:17 -0600
Message-ID: <20240411153126.16201-418-axboe@kernel.dk>
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
 drivers/media/platform/mediatek/vpu/mtk_vpu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/mediatek/vpu/mtk_vpu.c b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
index 724ae7c2ab3b..ab285cf4bfef 100644
--- a/drivers/media/platform/mediatek/vpu/mtk_vpu.c
+++ b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
@@ -648,14 +648,13 @@ static void vpu_init_ipi_handler(void *data, unsigned int len, void *priv)
 }
 
 #ifdef CONFIG_DEBUG_FS
-static ssize_t vpu_debug_read(struct file *file, char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t vpu_debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[256];
 	unsigned int len;
 	unsigned int running, pc, vpu_to_host, host_to_vpu, wdt, idle, ra, sp;
 	int ret;
-	struct device *dev = file->private_data;
+	struct device *dev = iocb->ki_filp->private_data;
 	struct mtk_vpu *vpu = dev_get_drvdata(dev);
 
 	ret = vpu_clock_enable(vpu);
@@ -692,12 +691,12 @@ static ssize_t vpu_debug_read(struct file *file, char __user *user_buf,
 		len = snprintf(buf, sizeof(buf), "VPU not running\n");
 	}
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations vpu_debug_fops = {
 	.open = simple_open,
-	.read = vpu_debug_read,
+	.read_iter = vpu_debug_read,
 };
 #endif /* CONFIG_DEBUG_FS */
 
-- 
2.43.0


