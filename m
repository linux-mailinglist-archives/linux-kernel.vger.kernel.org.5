Return-Path: <linux-kernel+bounces-80124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF173862AF1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1231C20E63
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572B615E90;
	Sun, 25 Feb 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CiL1t7/b"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA414280
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874038; cv=none; b=jztS/6OmAhvBB3ZJ0vJBDJ7t2mtiMcLhdDLeqcB5ajOQOqaUz3kiTjv5WgufLHkAAth5FjcfLlJA5Vxq2vH2lKD9qoP/vutemAuTC9zN46/PQFh1DzPyRLRCqI4k0NXK7qqjpYzsHboMZV7sW7gR/OhgdMmszJImQylqQo6ddlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874038; c=relaxed/simple;
	bh=Hx29924sE0D29O6GTIthI9cssCctI7+xzhDTwYRmHCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cI1en+SxQdLqkS8Tb8pTW31sgcmdpbaTyFZJJVu6SUjkBQcvvLqDse8IEtLNpHRjhWbLqyTHQW7D/z9i216xWILODZ8L3+3/OJ5lhvFCWbLxv6Lsfj9vxEKYox+CsYYIeQIGZjho2+9jdgq65z03Fjd5/1BA+9S6Xuz6OdGbhXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CiL1t7/b; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso2957081a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 07:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708874035; x=1709478835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqzAK/rpa5OgHPM2K5eydECFHp0Pspegr4Gfp32qYnk=;
        b=CiL1t7/b3aOtrvrvtKm2tCsCnnl3VawjruKuhP/0ZDW4tGx95mTeUbx8TbTvzY3qhi
         oiy5aqLgwgaux4mEbxE7pY8CBp865g0DGEk4J/xpia2m9JuA3JE8MNCq4KKVAcv3A/sV
         oH4vk+95y/1TN8oqnW5xOGX4nrIWwKVLQQsCudBH2giW25I+Puhw60JjN1c2tct6GHA2
         Vr56D14eRq1EKEPA4xcyD+KJ+ftoLtgmFmLU83Wg906dSy5Jc591dDS5bQqYFRv0KIO4
         O3adkqTyzKOlQqykKzjLwFqZup3e7oYfTr652l5fq4Ewxf/VO5jS4Lx9EuPt8VdA3rjn
         Yfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708874035; x=1709478835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqzAK/rpa5OgHPM2K5eydECFHp0Pspegr4Gfp32qYnk=;
        b=q/ASk/UuIt8nOjE6TYH++2/y03BSzV3xWxaHWusslrorXO2CcvAvPmln489cq2hzFw
         5ehKRLpMh11jfGnGCFDfkOpVB25bd6NMEsKWuVG5u746SX38RElR4ifT8+uGXF2trx6V
         apIKRafeyPE5bclUnp7yhWIAwG4rkT297H6xtqXrgQPZPgwhNiwNXfMDimKo0rgmq+eY
         PurcLqctrxXEIzcjp6L3644Wzx69lU7l7kAp7O+VQUKBRN8C0HoxWS9DuBTl7miDjSeX
         Dekg7NYwghZ1UNwklvvJApcrakmqRce/cFrcbzLDL+nh2J4CdgSkDjX3ebcXGBKy7g46
         m43Q==
X-Forwarded-Encrypted: i=1; AJvYcCVox+1tnUKm8bC5LPyKEGJQfMxCQ5NIoFZ9wem37L6i0efD3AaN+BDbw93UHu/R7pSfwhHkSCUUzK8zySfph8Ecf8yhYAs0yuOp3/ds
X-Gm-Message-State: AOJu0YxhF6RpFLqjE3Vqm/4fbyY358CCQIQ2/7J/SsCNQxSsmPtPkcO+
	Qninyi0+Jqg7kifIwmYtlWlTV0fGpe1A1wYF0sAQMvzaUdfB0xuY
X-Google-Smtp-Source: AGHT+IGkQ09BVgHI1DnowCCqKMkEwUFloLKHKWTtL/sGl3j4U7VUMrYUG75/56+rg5mzCYn+UJBPZg==
X-Received: by 2002:a05:6402:2c7:b0:565:8e3a:5add with SMTP id b7-20020a05640202c700b005658e3a5addmr3081349edx.15.1708874035054;
        Sun, 25 Feb 2024 07:13:55 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-94e3-d600-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:94e3:d600::e63])
        by smtp.googlemail.com with ESMTPSA id f5-20020a50d545000000b005651ae4ac91sm1588450edj.41.2024.02.25.07.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:13:54 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	patrice.chotard@foss.st.com,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 2/3] clocksource/drivers/arm_global_timer: Guard against division by zero
Date: Sun, 25 Feb 2024 16:13:35 +0100
Message-ID: <20240225151336.2728533-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240225151336.2728533-1-martin.blumenstingl@googlemail.com>
References: <20240225151336.2728533-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The result of the division of new_rate by gt_target_rate can be zero (if
new_rate is smaller than gt_target_rate). Using that result as divisor
without checking can result in a division by zero error. Guard against
this by checking for a zero value earlier.
While here, also change the psv variable to an unsigned long to make
sure we don't overflow the datatype as all other types involved are also
unsiged long.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clocksource/arm_global_timer.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index fb3ffd54c822..257599d682f0 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -291,18 +291,17 @@ static int gt_clk_rate_change_cb(struct notifier_block *nb,
 	switch (event) {
 	case PRE_RATE_CHANGE:
 	{
-		int psv;
+		unsigned long psv;
 
-		psv = DIV_ROUND_CLOSEST(ndata->new_rate,
-					gt_target_rate);
-
-		if (abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)
+		psv = DIV_ROUND_CLOSEST(ndata->new_rate, gt_target_rate);
+		if (!psv ||
+		    abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)
 			return NOTIFY_BAD;
 
 		psv--;
 
 		/* prescaler within legal range? */
-		if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
+		if (psv > GT_CONTROL_PRESCALER_MAX)
 			return NOTIFY_BAD;
 
 		/*
-- 
2.44.0


