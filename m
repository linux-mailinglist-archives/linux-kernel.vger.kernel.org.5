Return-Path: <linux-kernel+bounces-141174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324DF8A1AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF181F234A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37E1F6F2E;
	Thu, 11 Apr 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KFUqv9od"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849811F6F02
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850158; cv=none; b=FjZxu896rhvnfS7Al7+52f1oh+vwRYSOiPD6+4A9fddj7C3uE2dXnxJjIQcEGmzTOm4mB3SFeCXhiOyVQ6EMDXN1O4GAXewmuNBhfpoEnGK6F5kgNbBbkHVd1dSMH+eijgjhkPeBg+G8vBfZ5sR0MtHroscmW7K3OHlGY1rNTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850158; c=relaxed/simple;
	bh=Ns+bBSHgrTXmj1SSwEbwfZzxFWa9rERHnmbAfYSKc7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z34RhabtvnK1fOBc4LCXYNu31lsLVmQ+KdhrL//hZMRg7SfvmbK/2WBca0ttcyVMxDpHwfeBaoBEerxQNxoNeJA78tgcfdVSxJkoCfr/iKWoClGPUpcmbCsZlziMDDJt/Fa4JUKcYQgyqvAd86Zjs/wGniib6i/7dBtHWPLLm9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KFUqv9od; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9935139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850156; x=1713454956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20vecyLBIH0cjHhN+kgNwf6a7WaRA+wJVBbxynnYORc=;
        b=KFUqv9odqmjNWBjmmYk2vdsFmAPk4EyQBUPhw3dJt4VO93ja1r8y93ZLdLU5Xn1QHB
         fC98A2vJN8wqIZGhCkjEMPRGJK6n4jAnLTzPIdYEV4fbMPV76iwJL6xyt3zNvAVp/yI6
         yDc+RPh3PBjqOQdlcp2WGkv6eS+NQWfTv64szX8iZwp55ZGvcd1e497/klSN5OijUWQQ
         0xUR5u2de7kau6k7el4O75GwOn98o1t3ydRG8BPtnw3rZCilGNu/Bzqy7E2eQLtTuYSE
         FS2DmSvEt/WzoFS5BeFtjVfa6WHHMdSCtL3JIccOFWKbUbombP4XAWVH4hrw1Ys7CQ3r
         mRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850156; x=1713454956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20vecyLBIH0cjHhN+kgNwf6a7WaRA+wJVBbxynnYORc=;
        b=sYn70/r2JGao7JK7uuUeAXmBdT62bpWBR2ILY2lh6AUl9ZDEWVi+O1pV/gTudbd7ff
         Ojkj6x/k10Hcv0vAVO3gYocygVp2tya4pSbLM6iOyylZG/4BMUMj0PFusxInkosMFYUp
         6QZJzybqKB7Ce5SOexHVu63zQeqSDZM22J56TgoJ0JJ8XWqQdSVK/x7yS2Ltd2dXjPkO
         +jKNDZ6RPNDap9cMtpVXhH8owrLhdHmqsZml2bkKsS+H1mAqx1pzYsxBn5Owqepx91o0
         aYDheSYD2cbu0JHAbp/0MAQOuSVA1FpL1izMh5bgjk0eFMfQNhgzHiDMj8H9CBNK4BoW
         skCw==
X-Gm-Message-State: AOJu0YzGXuVvFzwidHPEpKxzOqtgCOLF/EchqFpA48AtIcMhcGZIx1AX
	oyfx2zGzKZwwttddkmpek8pLehCTHWEY72BOOKvvjfijZ+/UGhov5Ku5BQtcxXwTNvvfN2biTAG
	C
X-Google-Smtp-Source: AGHT+IFSnwMc7q4qiOpR4cgfomgh26CNXyK66p/ZcKo/AkIznzFMaESLCWdPKNByF9cTgMz7i4Q2iQ==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr55672iob.2.1712850156355;
        Thu, 11 Apr 2024 08:42:36 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 391/437] EDAC/i5100: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:51 -0600
Message-ID: <20240411153126.16201-392-axboe@kernel.dk>
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
 drivers/edac/i5100_edac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index d470afe65001..d35064a74fe2 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -924,20 +924,19 @@ static void i5100_do_inject(struct mem_ctl_info *mci)
 }
 
 #define to_mci(k) container_of(k, struct mem_ctl_info, dev)
-static ssize_t inject_enable_write(struct file *file, const char __user *data,
-		size_t count, loff_t *ppos)
+static ssize_t inject_enable_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct device *dev = file->private_data;
+	struct device *dev = iocb->ki_filp->private_data;
 	struct mem_ctl_info *mci = to_mci(dev);
 
 	i5100_do_inject(mci);
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations i5100_inject_enable_fops = {
 	.open = simple_open,
-	.write = inject_enable_write,
+	.write_iter = inject_enable_write,
 	.llseek = generic_file_llseek,
 };
 
-- 
2.43.0


