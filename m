Return-Path: <linux-kernel+bounces-140910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408ED8A198E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F615287459
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0CF16DEB3;
	Thu, 11 Apr 2024 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r3DjbFjr"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52465161301
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849746; cv=none; b=UUV00mka+8bBoeM593Wvxgwh9inWOnFVgm1zRnqW2eidrwnneDiDg1v1Cw5h4XYlr3s0dSCF9L9+5KWCsT7RxkhYBjQi5llsKRmBll3xaU+HUz020VHs3hUQnhbBUM+f3qSYA42LM9r1lNoJjNJsAuSX6MgbYGOD3pRSMpb2Ms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849746; c=relaxed/simple;
	bh=lFWKPmtADZ77fK4ueBYj9oz0C6yf67EywTWQwCps9UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsMz6vJPOPIwBpmZw/jjUBbVqoAfEsUHsbjK2EeTiMf+x7lA/LtMgwGpQ0C3OufLrQSGGP1OkEFrTvB9/rnHSyjTeRHS/kRguKuLtjqbG+US+DV+iOyuQeafkG8V63T/1zJrqh7sNeJGLbdq0uv+E5SMD9mbhO+B9CAR6KxEK2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r3DjbFjr; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16150739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849744; x=1713454544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6mqJFUy2iUjIxDPhjI3lLEspk5VVjXPoCyQkSzQDwo=;
        b=r3DjbFjrBt6yGwH+hg/z8ES1Q8tTQPLNmHRSOHV+7ZjWgQZhSZdzJ550Pq39oMKaMl
         qSq2r9a/omp3d7VnhCjzSMjghj5pfywM9qUE0h24aKxvG0j0abs5BkcN+n/uLFbNC4Uc
         KdB+qKoeAY/GkVFTLWcEZnKlYBafR3pheY1kYMCrIRg1T4S3BNVr2mHyvnkk6viDKOVv
         mEcsypP4OmxKJ79t/MpR0IZqYzZV0aYw6pqbTzxdv9/GbWd2xz7LK1ibYzVUBjgnNyvv
         Dk/wq4y4eS+z5BPloHBANNROxu+kqLliO3IpJ3pfCWmJ7E8nrr6a1Sf4bNwVSfcDCY2o
         LzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849744; x=1713454544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6mqJFUy2iUjIxDPhjI3lLEspk5VVjXPoCyQkSzQDwo=;
        b=kqaFKapDgwv0jSermPJ88JWKFsb9FjBOhwD32pyBy5FI7kW4V8MmITvVRhDARmK1gj
         ZcEWpAG2wsS/9zJCd1nSZGLZfGuLlodTXtzMi0iawt5tU9pP+3Ds4S5kGZ1ldwJeXL47
         H8od6P93EDcHqorUzc8M8RUa+kd4ZsxbFkSokj0KHVdIlKY9S0SnCQ4udK6QhJTufm6S
         6SUEi9Dk4CBBoY65hvYLWspN1bqQAJU1gRoFJROm7jOdUhVcgDLYRvqUZT9eXLSh/+nu
         xZD7qn8pgRTykq7Uj3x0t4npNoWyiSV1DsuA3/qMkukAILHtGflCQ+TaUOX0/PmSiiZe
         oDjw==
X-Gm-Message-State: AOJu0YzyKdZo/s7K/eNMmtoMqNQgYAeJALFwP+sI+EW8aPQrqnyuM08h
	oeJ+oOhPUiqxP3KAvAjjOWdSOJEByVchUCBtmYtfZKHpGFzrq3AXEcC04fYLgms0Cm01hkFbGKI
	k
X-Google-Smtp-Source: AGHT+IEKVU5p0lHw7ZbqDjprrXcw8tYzsPT3YOqu+wDxZN8OtyLpvHMqI1us2mx4quV/CJL6eoFcmA==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr182837iov.2.1712849744086;
        Thu, 11 Apr 2024 08:35:44 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 145/437] drm/imagination: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:45 -0600
Message-ID: <20240411153126.16201-146-axboe@kernel.dk>
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
 drivers/gpu/drm/imagination/pvr_fw_trace.c | 2 +-
 drivers/gpu/drm/imagination/pvr_params.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.c b/drivers/gpu/drm/imagination/pvr_fw_trace.c
index 31199e45b72e..ff5827dd6390 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_trace.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_trace.c
@@ -438,7 +438,7 @@ static int fw_trace_release(struct inode *inode, struct file *file)
 static const struct file_operations pvr_fw_trace_fops = {
 	.owner = THIS_MODULE,
 	.open = fw_trace_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = fw_trace_release,
 };
diff --git a/drivers/gpu/drm/imagination/pvr_params.c b/drivers/gpu/drm/imagination/pvr_params.c
index b91759f362c5..4fe0105ca0c9 100644
--- a/drivers/gpu/drm/imagination/pvr_params.c
+++ b/drivers/gpu/drm/imagination/pvr_params.c
@@ -119,8 +119,8 @@ static struct {
 		.owner = THIS_MODULE,                      \
 		.open = __pvr_device_param_##name_##_open, \
 		.release = simple_attr_release,            \
-		.read = simple_attr_read,                  \
-		.write = simple_attr_write,                \
+		.read_iter = simple_attr_read_iter,        \
+		.write_iter = simple_attr_write_iter,      \
 		.llseek = generic_file_llseek,             \
 	},
 	PVR_DEVICE_PARAMS
-- 
2.43.0


