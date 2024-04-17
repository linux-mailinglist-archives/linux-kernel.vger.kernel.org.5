Return-Path: <linux-kernel+bounces-148235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374FA8A7FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6D61C20F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411F913173A;
	Wed, 17 Apr 2024 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UWZrSbZ5"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249227F470
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346283; cv=none; b=mFVHMY4sj2HnX/86Z9AetWKqbVtSeXd79+q25tDzv5zfDBl89CszpJTpPrEZ8Wv9O0EipxvtOtwZIoj8YbuIgQVVid+sqLTTiUzhqtYDn3ETU4wSNGmpzJ9XLXge1+YRnjWAL4WPVJj09zVNtwZYRxPudOvYLS40c5RjI3Yp1AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346283; c=relaxed/simple;
	bh=T5PMdj1yX+zNxZbjv85K+u85HxfXuO5/2rlbKUV1+1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IlfLfhb+ueFh5vIj/TwEeKpMOtHi4ga1Vy8CfwSDWwp4WQoHK4YadAu2HFgB99qSq+dIl8vXln7VOyxjWYUtPylTskCkHqoiBkYwBvNfUI7WyG9UVb4zZquGJN1RdlP42KWphxTGW7PZ1m97DUFQcfIY0cHCjHmGlBm6XRK3oow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UWZrSbZ5; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-479de65e08fso1311381137.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713346281; x=1713951081; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7CjWqPeCtoYXLSOyHKwESdFH4pcoLP/COUIU8rpmac=;
        b=UWZrSbZ5SiqVbrDz2AcDuHLqelpi0IVDY7x+4EzMwVaWxrAuCXbN//Jh53Fytuaq/8
         xfKGSOK6k8YX7Knbb446SPoYUzbA3L66vqoE7azRUgw746lzxk9AdhKzSZRFn31vXgJX
         rsXeDIRyoUB+zP2qp8mKtb5ZLeMyfm+7ttsaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713346281; x=1713951081;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7CjWqPeCtoYXLSOyHKwESdFH4pcoLP/COUIU8rpmac=;
        b=lXSrwxEumTznwqHSHcG0srL/kdltAU+kjoKM07U8Oc1xRHdMmpvtk1aJ90L1a2c3tb
         bXzNibSpA60/NCK1nZZRS9hbLk1ZSqaPU37iAX3DsjTxAANGFuER+6sIGb6QNlY7bfxV
         kE6ER/F90tjY7jSPnG/xO7MM1YYQBQyVrueRSWAUrhWrPh02vQmQXgHh6QSoLVoD1bRe
         Hy0gszC+LEH6HiBuwv7yHcbNVjTLxTEjojyHDy0Ejcqxw4Ko2brN1axdtK6fdzrUSeJW
         mYguaFZMR1uzAjPWr6p4Az9kKtXWfr2M8rvebsEPnLpofFW1Y0fqGJIgvOSnEtoevE27
         Mcfw==
X-Forwarded-Encrypted: i=1; AJvYcCWFPGbsjqlpPBFR9Rn8GLeZGb8znBcETc8tOTpvIXbvyHYtlhS049pmTEfPn2GC695acT+mm+DA+vrqYPvgS4mtsa8i/r95UZaGD6kR
X-Gm-Message-State: AOJu0YxF+0ze0Tdt+bll7KRkUIinFYO5R7/W/3MjJewH9BJBnyNOnuzy
	ekmdh76iOf9hcq5ecnQDmrCcvxNYps806bsDkVlEwHodJgJagJte0JIr/OYrQ8vE+NK7dBMGpuI
	BnyPx
X-Google-Smtp-Source: AGHT+IHt2OKybMIi0lFPRHpTUZ2DZUoX/9eUQlnhGpsvIPR/HnFGcB9zL6JGULz/JGj+zfkwgSPYEQ==
X-Received: by 2002:a05:6102:151e:b0:47b:995f:5716 with SMTP id f30-20020a056102151e00b0047b995f5716mr4759331vsv.26.1713346280900;
        Wed, 17 Apr 2024 02:31:20 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id i15-20020a0cd84f000000b006a045780b77sm495444qvj.51.2024.04.17.02.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 02:31:20 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 17 Apr 2024 09:30:44 +0000
Subject: [PATCH] media: vivid: Enforce a monotonic sequence number
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-vivid-seq-v1-1-0e56ea08b682@chromium.org>
X-B4-Tracking: v=1; b=H4sIAMOWH2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0Nz3bLMsswU3eLUQt0Ug9QkAxOTRAML0zQloPqCotS0zAqwWdGxtbU
 AzU5fflsAAAA=
To: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Make sure that the sequence number is at least one unit bigger than the
previous one.

This solves situations where the sequence number calculation does not
have enough accuracy and repeats a sequence number.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
We have seen some examples where the sequence number has been
duplicated. This should not happen.
---
 drivers/media/test-drivers/vivid/vivid-kthread-cap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/test-drivers/vivid/vivid-kthread-cap.c b/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
index 42048727d7ff..6375e6484a4b 100644
--- a/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
@@ -665,7 +665,7 @@ static int vivid_thread_vid_cap(void *data)
 {
 	struct vivid_dev *dev = data;
 	u64 numerators_since_start;
-	u64 buffers_since_start;
+	u64 buffers_since_start = ~0;
 	u64 next_jiffies_since_start;
 	unsigned long jiffies_since_start;
 	unsigned long cur_jiffies;
@@ -691,6 +691,7 @@ static int vivid_thread_vid_cap(void *data)
 	vivid_cap_update_frame_period(dev);
 
 	for (;;) {
+		u64 tmp;
 		try_to_freeze();
 		if (kthread_should_stop())
 			break;
@@ -719,9 +720,10 @@ static int vivid_thread_vid_cap(void *data)
 		/* Calculate the number of jiffies since we started streaming */
 		jiffies_since_start = cur_jiffies - dev->jiffies_vid_cap;
 		/* Get the number of buffers streamed since the start */
-		buffers_since_start = (u64)jiffies_since_start * denominator +
-				      (HZ * numerator) / 2;
-		do_div(buffers_since_start, HZ * numerator);
+		tmp = (u64)jiffies_since_start * denominator +
+		      (HZ * numerator) / 2;
+		do_div(tmp, HZ * numerator);
+		buffers_since_start = max(tmp, buffers_since_start + 1);
 
 		/*
 		 * After more than 0xf0000000 (rounded down to a multiple of
@@ -746,7 +748,7 @@ static int vivid_thread_vid_cap(void *data)
 		 * Calculate the number of 'numerators' streamed since we started,
 		 * including the current buffer.
 		 */
-		numerators_since_start = ++buffers_since_start * numerator;
+		numerators_since_start = (buffers_since_start + 1) * numerator;
 
 		/* And the number of jiffies since we started */
 		jiffies_since_start = jiffies - dev->jiffies_vid_cap;

---
base-commit: 836e2548524d2dfcb5acaf3be78f203b6b4bde6f
change-id: 20240417-vivid-seq-d0eb044a085f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


