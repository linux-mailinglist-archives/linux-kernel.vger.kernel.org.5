Return-Path: <linux-kernel+bounces-79878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1C18627DB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F322827AC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABAE4D5AC;
	Sat, 24 Feb 2024 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gAwDfk+J"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059F24CDEB
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810545; cv=none; b=LOikOgRXJAeUaDr1GOMauL7T4ZFaGX0LP294reexzmQlmnZlKDxuKbWRFnOsI+Gdu48uOl6kjrM6sLEbBHm3JsuAljQya/CSJHGvzclIiBx8Mp8NlCmE+DLXhd3zvBt5L5hIdGpAMVGWuIqa+NccjPlNvbLczdAL3i89U1N2uJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810545; c=relaxed/simple;
	bh=DDvFIvd266t25XjZaAkwl5Ki0yVc8NNt6fZe1aG2SRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4UaZUQrPYCENKHwGWX8HWIuANBtJ0rhR30u3lKNcW42L9AYq4r18oAMkBlLGYjKBn+AV7gl4tyOBF64kqVRNhnSNvhtUKGlZSevFi0qrV9ecWODXmYEZGbY/i6u38j/sFXLt+oewZug6UYOAqvRlTRaTiRoRbtEzr+7emP3Rmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gAwDfk+J; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4129e978a5fso3538075e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708810542; x=1709415342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XfyUUPIObrJI/AdJkHzfZnrS5Mew7GMKv0WrMYMijQA=;
        b=gAwDfk+Jox5WIYSmny8f5fzRoM1PdH90g1oEmChrwyOVvbcg8iCjb+XprU94er8cjR
         h2bHgf8AKLPUfL6NqXzwuYkm/fWSkVVDlgtHlOcaBT2RQR0kuJmc5F9qU5e0xx0fD0R8
         0WlLfYfQgKWW8qE6RA1AigDSO/iIhe/u0uTSeVOf7poO9wxhEO3GZXxhQhTEziaMRq5o
         g1RDlIesea8mP11AAaWypYp5FhJ5qFiHDV1Fv1I6LTVrzrjsn5J8oNBbrwK1JK+HAKh4
         73R70gyfwzrDSAvKYpZe9RgfjtOKdk3AtaWzq5NLw5jJZ5JbY/W51WIPIoNKmzSKOUHi
         VTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708810542; x=1709415342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfyUUPIObrJI/AdJkHzfZnrS5Mew7GMKv0WrMYMijQA=;
        b=sIA8dA4qWm9PtNHno/1dhUftCWnc2maktAypK+ebZcNlmHTyVEa2V8hGE9g734HJWX
         IYV6BPuQXpsVmNwaeb6SoshMr7e6vToMZ0z9KcnjcXyxNzXsetDmShSpTMqvG8JLEf12
         6PCUssES0YFHs7y7MMydhb0oqlW9xQkSobm1je6JVs0Wz+1bjeZ7gbN+esop3NxKTHHG
         UBmVhzgkMxw2S4vv+CNGNq/fIZIkFqnOGpb6tPm+PLcrLqd6zc03sAuLGzmlUsQyEeD5
         AFALwLhF5BNacZary8IRptYXdhuOJrRZntNjQPaITzWraDO1qmCVDyF5i3IvREyMrEGK
         wIYw==
X-Forwarded-Encrypted: i=1; AJvYcCWMVPEoDauv9U0kVoMHI2h+5COCRdUKzSa0Tk7DTUm4yanG+H346Vj6LAmZfuoaT6pGDADlWsBAWAu8Z5Hqi/qzr576aQJn52f753O5
X-Gm-Message-State: AOJu0Yyr0zDbcGg+6NaFUHggEXW0NV/3OzwkzmAJB9YRnOF96A2443kS
	NOUtwGwbZokUED+4h5nBykZNJqnF94bvOvLOQojq9Rj+rCVXBUJ6
X-Google-Smtp-Source: AGHT+IHRXkPpZgMScDvUKW2hl6gXaSeJDpy0KyrAjMC1XYbCNqWWEU+e/zerWBbZqhXcOpN2zNh5ow==
X-Received: by 2002:a05:600c:1d22:b0:412:90e4:6a1d with SMTP id l34-20020a05600c1d2200b0041290e46a1dmr2663360wms.41.1708810542090;
        Sat, 24 Feb 2024 13:35:42 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c5cc-b000-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c5cc:b000::e63])
        by smtp.googlemail.com with ESMTPSA id d33-20020a05600c4c2100b004129f87a2c6sm757065wmp.1.2024.02.24.13.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 13:35:41 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	patrice.chotard@foss.st.com,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2] clocksource/drivers/arm_global_timer: Simplify prescaler register access
Date: Sat, 24 Feb 2024 22:35:29 +0100
Message-ID: <20240224213529.2601333-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.44.0
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
Changes from v1 at [0]:
- use FIELD_FIT() to check whether psv overflows the register
- update the description accordingly


[0] https://lore.kernel.org/lkml/20240221214348.2299636-1-martin.blumenstingl@googlemail.com/


 drivers/clocksource/arm_global_timer.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 8dd1e46b7176..49b094a20717 100644
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
@@ -247,7 +245,7 @@ static void gt_write_presc(u32 psv)
 
 	reg = readl(gt_base + GT_CONTROL);
 	reg &= ~GT_CONTROL_PRESCALER_MASK;
-	reg |= psv << GT_CONTROL_PRESCALER_SHIFT;
+	reg |= FIELD_PREP(GT_CONTROL_PRESCALER_MASK, psv);
 	writel(reg, gt_base + GT_CONTROL);
 }
 
@@ -256,8 +254,7 @@ static u32 gt_read_presc(void)
 	u32 reg;
 
 	reg = readl(gt_base + GT_CONTROL);
-	reg &= GT_CONTROL_PRESCALER_MASK;
-	return reg >> GT_CONTROL_PRESCALER_SHIFT;
+	return FIELD_GET(GT_CONTROL_PRESCALER_MASK, reg);
 }
 
 static void __init gt_delay_timer_init(void)
@@ -272,9 +269,9 @@ static int __init gt_clocksource_init(void)
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
-		if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
+		if (psv < 0 || !FIELD_FIT(GT_CONTROL_PRESCALER_MASK, psv))
 			return NOTIFY_BAD;
 
 		/*
-- 
2.44.0


