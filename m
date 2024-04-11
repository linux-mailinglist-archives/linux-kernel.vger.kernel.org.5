Return-Path: <linux-kernel+bounces-140958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265408A19CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03981F21B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5353E1B7590;
	Thu, 11 Apr 2024 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jfk00Jsz"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7D1B680C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849820; cv=none; b=FJa9AZp1XF4fDGo355Wre1g510FxJVq0cYy0LCUKpEVdS/lYoQ2m/cbvSZMKrk1AIcSSrhLemw33+kC62V7fFGJAn7dlNdlnkfl+0UtxlXOTBhy4IJRrBCFpj0r4JhdtXIle/lwaGmfklcV1BPfnKl0DsLabMT3KriJh1gDD9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849820; c=relaxed/simple;
	bh=O7lZ/hhLmBQ7iZ9zpUnKqu87tUwBAsVmNJtxcuJqXS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VypCEdO3f0igdoN7obHKS2TpGXleRHxi/CbY1R+b7XLxL5fn1SNT57F8D9l/jgqfHIgI7td/H8sjc/Thpv/3DSBn+rhWNXRjbajcNahkk8/r8zSFLeRBr7/WZIlSHORWAAaQgwc0tEVv5FD6El8Tx+lLdxuFnBlJA+60PSiMzvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jfk00Jsz; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8964339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849818; x=1713454618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMmAvR/fEaupoAUATuQL+LXaXxKdjFUmcU+pS5j3aQM=;
        b=jfk00JsztQkZ0oTR/ZugWu8mN1UfHQliO8Vz2ObkbQura8PdgaYcqvKeAnUhzpUv9o
         sNDFK3kHxs4B2SUaoM91mrjuA7ZlyreIjxP68nHWdDuMDGMzssIMi/oDVh6pQ9wqmIU5
         dIf170V7dSVOggL/+9LxpU1wx3UlAOCTmHIDsC/9E+/lBQCZTmlcgblJV6JLHZD0AZ0w
         H93ZemfqAULMoXKI1C7c/RVYBE9jXUJA9itsINekT44FZ79NtXq9W4+vrFahdJo1g9+a
         Yja4cbOvjpyB8J+vugLL1SF/6XNG3chAgugTL+m6KQbmjGf3lGHJYhebW6cKsqpN2VAI
         9K7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849818; x=1713454618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMmAvR/fEaupoAUATuQL+LXaXxKdjFUmcU+pS5j3aQM=;
        b=SDXFA0C7Al3GKxNy7i1PYq3BNVayyn95g8z0t5CN8aFrXhkR638b9OKmfXMjAjuVix
         kG5zD4frmD7+nE8ngUxr/WnSTohNW0KvJu6jtiSJ9V4YLm4+kzXRhYhsSiiluYU+/+Kb
         wlmgFGSw8hVt0b5T4vFGh17T92ek+r5Aak4QC0Z536CsdjE9RmKqqKA9R5y7GjAtAF+A
         PRe6WRQKQcLnRZ3jKSeehPOpUSVt+JN5cyIsyiXKeNl1wGOtISCVVZGh1JdoKYRsyNTk
         9zDh8brh7a0UVwik2B5PEqNk9fHDT7exRewLfXjzZsrS6v3df1zFZSlSSwGUDiGxwHhS
         XvDw==
X-Gm-Message-State: AOJu0YycPguTfX3Nh0vqeqIWaz2qufw/7CQUq1LlQvrBl85g/IweX4ef
	dZV7EkZK8YbAFLt9TIR9saLqpYBlPKkDONwxgSLSeKj8fVW4jN7vGR1T5QPDz1MJ8vUYFcKVEvO
	D
X-Google-Smtp-Source: AGHT+IEY0ef6J/nJCsO51GHWZB/gDmrRUuk9I+hMPeWKmkwlwDMev9yXPHFZrRnqXXfnlbNgZ897ng==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr223899ioh.0.1712849817966;
        Thu, 11 Apr 2024 08:36:57 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 190/437] scsi: megaraid: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:30 -0600
Message-ID: <20240411153126.16201-191-axboe@kernel.dk>
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
 drivers/scsi/megaraid/megaraid_sas_debugfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_debugfs.c b/drivers/scsi/megaraid/megaraid_sas_debugfs.c
index c69760775efa..d0b8626eebd8 100644
--- a/drivers/scsi/megaraid/megaraid_sas_debugfs.c
+++ b/drivers/scsi/megaraid/megaraid_sas_debugfs.c
@@ -45,15 +45,14 @@
 struct dentry *megasas_debugfs_root;
 
 static ssize_t
-megasas_debugfs_read(struct file *filp, char __user *ubuf, size_t cnt,
-		      loff_t *ppos)
+megasas_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct megasas_debugfs_buffer *debug = filp->private_data;
+	struct megasas_debugfs_buffer *debug = iocb->ki_filp->private_data;
 
 	if (!debug || !debug->buf)
 		return 0;
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, debug->buf, debug->len);
+	return simple_copy_to_iter(debug->buf, &iocb->ki_pos, debug->len, to);
 }
 
 static int
@@ -92,7 +91,7 @@ megasas_debugfs_release(struct inode *inode, struct file *file)
 static const struct file_operations megasas_debugfs_raidmap_fops = {
 	.owner		= THIS_MODULE,
 	.open           = megasas_debugfs_raidmap_open,
-	.read           = megasas_debugfs_read,
+	.read_iter      = megasas_debugfs_read,
 	.release        = megasas_debugfs_release,
 };
 
-- 
2.43.0


