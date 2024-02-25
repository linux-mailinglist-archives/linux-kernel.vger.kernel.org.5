Return-Path: <linux-kernel+bounces-80125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC42862AF2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759111F21854
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB8D17551;
	Sun, 25 Feb 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SsA9qhLH"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D51429F
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874039; cv=none; b=Y2fY4dRPF1PoGcH+yz3EM6SVKPt4/3qaU2/VsV9gvXd6v9fPwyCJ05WpAj63CIrKj2ouEuGlyeoDvxbzdaeebqleLuWnlEnHrlhQyKH+ld4Quz8Cdsd78proCMZtSbj0Mh5idfOrprAki2CDDVLlO5TvANfEYSX/xvlqKnd41hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874039; c=relaxed/simple;
	bh=34fqCyhh3jqb4x7nW9o9+UwmXajc9gCRDRf8jM7y+IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHY4bPNDXH3LK/U0QMrTM5Cw9lH7MZnbXREO/dyqkvwOy+mUFmxraiXY21cFr8AAc4Nk+2CKv58ZjaTZj+U1nQG5xKJudsVKIXdYDujBvRzicTY1lVFf3guQwtfGIcOgrOX8ZF5mmB5U83pH+TsFGMs7FYjwhuPudMEJYNLhM9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SsA9qhLH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-564fe0273e4so1869652a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 07:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708874036; x=1709478836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRqUqyxM5BwYZ552SwBc1mEqP/KlJT+duufn8/IdCwI=;
        b=SsA9qhLHYGx8UzUziXrHHe1EskwMizR+bphY1PFueEBUqoCz/uDBfC+Na9SiBoCk0l
         MLUXfp7B0EFibQ1R/afHCkbI2mjPYdgNQ1lT0A76G95fBBE1prndGEzeBrjYuj75UTdJ
         ylzcI1dXD0JbNcJs5mlCalG5kHojD9UvQFmezCAEN7W0xR3OIhahuZYtqkZ1Ni2HgKoS
         f7mNPOjXmqdQv7zrz3spe5/0l/L9scvCwQOjRH3qa8QNFja7bWRbC3rR9GbTkGOw1508
         6XmB178PdtSytoGiPJ93Pxz6PU2Iz3dvlRFDGtvNNv5SmgEW6K9UAGbDIyVSqXcUcOg9
         SfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708874036; x=1709478836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRqUqyxM5BwYZ552SwBc1mEqP/KlJT+duufn8/IdCwI=;
        b=mxSdmHV40llMLqUQ7bXK4gDHqeaxK5v0v4leP4RtiXqBQeyj5OXiIHzDVb+J7IHUYD
         IAXoqokZYLLfMpXBXEHBp2X0StjdFhW7BVj9xk8pQw3Dq3Wmizkz+YKBg5u0yVbTs2Wp
         CiQt8kGj3odSaIIWOutKfBTaFsBfZMvA9uAuHhsAb5YUgrGlu20C34ik0PJeuo4daN5h
         51DNqwmuM18fQJF8RxJP8ekN6ZyxXbXHjB0JKmw9fBgEVrt8t+ddI/m7nONTDKMPMMn1
         F2SM/x/vaAyjkw48PczS6lUOqVZCDjbbDvDET02BahiU8OtchUK6U76K3kna5ea2zBrA
         2tFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZsx/6gukg32iilNSGrP/hZwx7VKgVo44AeNNE1xgorn1b+ZEuMZNeSp6ogc1k6nr2Opt/69UirTqcNKgZ5OzP/KXEC3Ud6wUs4W4w
X-Gm-Message-State: AOJu0YxCGrloBiIQywWB1RwT1i3E4rImosWH9OPwnIyRwa7DKijyGvpp
	9gvuJKZU2D/vNokslW4yvRfMKYvXDa7FdYzcLClSQB18qIbBPihDvO7KU34o
X-Google-Smtp-Source: AGHT+IH/nJnTUXso9xp8HekK1IjRVINalYAkwjwR4Jk7//muUbYijeHEbdBfJgf96o6NZ6fJ/+967A==
X-Received: by 2002:aa7:da09:0:b0:565:cd29:dd30 with SMTP id r9-20020aa7da09000000b00565cd29dd30mr1166096eds.30.1708874035965;
        Sun, 25 Feb 2024 07:13:55 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-94e3-d600-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:94e3:d600::e63])
        by smtp.googlemail.com with ESMTPSA id f5-20020a50d545000000b005651ae4ac91sm1588450edj.41.2024.02.25.07.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:13:55 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	patrice.chotard@foss.st.com,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 3/3] clocksource/drivers/arm_global_timer: Simplify prescaler register access
Date: Sun, 25 Feb 2024 16:13:36 +0100
Message-ID: <20240225151336.2728533-4-martin.blumenstingl@googlemail.com>
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

Use GENMASK() to define the prescaler mask and make the whole driver use
the mask (together with helpers such as FIELD_{GET,PREP,FIT}) instead of
needing an additional shift and max value constant.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clocksource/arm_global_timer.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 257599d682f0..8a82b60b467b 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -9,6 +9,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/bitfield.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
@@ -31,10 +32,7 @@
 #define GT_CONTROL_COMP_ENABLE		BIT(1)	/* banked */
 #define GT_CONTROL_IRQ_ENABLE		BIT(2)	/* banked */
 #define GT_CONTROL_AUTO_INC		BIT(3)	/* banked */
-#define GT_CONTROL_PRESCALER_SHIFT      8
-#define GT_CONTROL_PRESCALER_MAX        0xFF
-#define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << \
-					 GT_CONTROL_PRESCALER_SHIFT)
+#define GT_CONTROL_PRESCALER_MASK	GENMASK(15, 8)
 
 #define GT_INT_STATUS	0x0c
 #define GT_INT_STATUS_EVENT_FLAG	BIT(0)
@@ -248,7 +246,7 @@ static void gt_write_presc(u32 psv)
 
 	reg = readl(gt_base + GT_CONTROL);
 	reg &= ~GT_CONTROL_PRESCALER_MASK;
-	reg |= psv << GT_CONTROL_PRESCALER_SHIFT;
+	reg |= FIELD_PREP(GT_CONTROL_PRESCALER_MASK, psv);
 	writel(reg, gt_base + GT_CONTROL);
 }
 
@@ -257,8 +255,7 @@ static u32 gt_read_presc(void)
 	u32 reg;
 
 	reg = readl(gt_base + GT_CONTROL);
-	reg &= GT_CONTROL_PRESCALER_MASK;
-	return reg >> GT_CONTROL_PRESCALER_SHIFT;
+	return FIELD_GET(GT_CONTROL_PRESCALER_MASK, reg);
 }
 
 static void __init gt_delay_timer_init(void)
@@ -273,9 +270,9 @@ static int __init gt_clocksource_init(void)
 	writel(0, gt_base + GT_COUNTER0);
 	writel(0, gt_base + GT_COUNTER1);
 	/* set prescaler and enable timer on all the cores */
-	writel(((CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) <<
-		GT_CONTROL_PRESCALER_SHIFT)
-	       | GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
+	writel(FIELD_PREP(GT_CONTROL_PRESCALER_MASK,
+			  CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) |
+	       GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
 
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	sched_clock_register(gt_sched_clock_read, 64, gt_target_rate);
@@ -301,7 +298,7 @@ static int gt_clk_rate_change_cb(struct notifier_block *nb,
 		psv--;
 
 		/* prescaler within legal range? */
-		if (psv > GT_CONTROL_PRESCALER_MAX)
+		if (!FIELD_FIT(GT_CONTROL_PRESCALER_MASK, psv))
 			return NOTIFY_BAD;
 
 		/*
-- 
2.44.0


