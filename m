Return-Path: <linux-kernel+bounces-140823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE1C8A191D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49291281A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD2984A41;
	Thu, 11 Apr 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FYOkGVCo"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B45083CC3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849611; cv=none; b=EWOi2a3MRBcLeNyrvFnJKNt5GCGsMCz8hcXfEgZPMoAVvi0ytn6UKEdwb2OWj3bdNyM2GfXYnrC0WJBw4LU8kqjlxsbrAgFgoB6L5cTexXeUrK+5WkHD0BGU7nmO2PZVgCGD3JwEohQNGVeNz2X/os98Si7EvcO4Ocz6qjlw9Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849611; c=relaxed/simple;
	bh=mAjnOUYwQgY7c9GKXk9aZtZsZwOobLurLzG7cVDEafk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9jTBeiqL7fl6LxHpvUHq+ACHUCvM1ws0q/CdBwJi75wz7oC+3PS13fDnjUfBu/lrR+7aISXKLKWYvDJdxqBZh8UPaRZfZ7mSKb3Zc/jM8hr+eitrgwPIWMzApxLxPIlYFaUehie0OU9PQzzUdgaKRP5XCS6fGRZTnQIsLWE8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FYOkGVCo; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8884239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849609; x=1713454409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NgsNMGYsm9mjIoRDFXaNCR+1NCn61XzJP11ylFSsSA=;
        b=FYOkGVCo2BN528p6mKvxiH71WNuOYZGpf7ZS8WFNOMqCEoNZfwdYC+n9TrIK2NQn3x
         zEQA8P+yM4eQVTpIK9J+EubXT6G/xvheGPJBeRvz3GOu7fiv5x74CmkIN9QTyY0MRZWx
         9+m4lrhwpVYOwinPPDg4cEfglNJi+diqDnY9VJjUQYO/Y1RTxeE46E3965y56RJpdJmV
         eOs0GaWOMai4/6DS950J+BS1op8fva33etLzpS2PxdMt42kMPOS5Ig10mfQqCjYbigcN
         60feU5+GTVbMknoxmqqCUH8LdIdtg0GUz+/ARoAXxH4YKTzQM7OgTS+qcsiH5ZfQpZwV
         l+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849609; x=1713454409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NgsNMGYsm9mjIoRDFXaNCR+1NCn61XzJP11ylFSsSA=;
        b=AY7AWpVUSsQ3rAPJPb+oFdBrH7+K+5jt/ZEC0e2la9o4Zjux7otwYmaCQkWg+0xAZT
         +oZCG9aMmofaZ7BF9FCPPP92M1AU9IPObJ70cIvbn2aL/+DBncbO61VCa7kfnwnIldp6
         IOgizY+7Hv0ewRMYHazt7VB32CeHt/xIrAfBkwujPvF4ly1omcSRpkPyLBHeXE82Kz+6
         5npQU0vZKeuFe5qNeWOIGcIfdnbF6aqxmTmkJRUSfLujf96WeH96zqIr1Z2ew0Xk6OIZ
         49c30IV2mga+maD9nVrih6Xnofl2NvQ/gW6UG7ksGuhSmo7fHbuNftWr42jym4NdVOHZ
         dTQA==
X-Gm-Message-State: AOJu0YyFyNLGsnxlyHa3Lei0vlb+/yh7VSWhoEKC5gGDHmyILjyTL90z
	xnw+orGaOgTte2rtFb33LITrvPhVTOMy75F9BMqgwPLRU/fvo0e3tSIbGj0I9Pe8uMrWFark/Fb
	2
X-Google-Smtp-Source: AGHT+IFGXx/di4kVlRbFD6KGdw3G99QahH+quihhsmvNhTMdV8D6ZXiZggxnhDt6+mArSpkn/d4EjA==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr173509ioj.2.1712849609331;
        Thu, 11 Apr 2024 08:33:29 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 063/437] sound/oss/dmasound: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:23 -0600
Message-ID: <20240411153126.16201-64-axboe@kernel.dk>
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
 sound/oss/dmasound/dmasound_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index 164335d3c200..c702a8c5c668 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -1334,15 +1334,15 @@ static int state_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t state_read(struct file *file, char __user *buf, size_t count,
-			  loff_t *ppos)
+static ssize_t state_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	int n = state.len - state.ptr;
 	if (n > count)
 		n = count;
 	if (n <= 0)
 		return 0;
-	if (copy_to_user(buf, &state.buf[state.ptr], n))
+	if (!copy_to_iter_full(&state.buf[state.ptr], n, to))
 		return -EFAULT;
 	state.ptr += n;
 	return n;
@@ -1351,7 +1351,7 @@ static ssize_t state_read(struct file *file, char __user *buf, size_t count,
 static const struct file_operations state_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= state_read,
+	.read_iter	= state_read,
 	.open		= state_open,
 	.release	= state_release,
 };
-- 
2.43.0


