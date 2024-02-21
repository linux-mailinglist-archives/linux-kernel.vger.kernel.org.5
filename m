Return-Path: <linux-kernel+bounces-75561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44FF85EB28
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F6C1C20C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA74126F11;
	Wed, 21 Feb 2024 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CZA9S1H7"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55173A29E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551846; cv=none; b=hpax0KkHrUmThR18ov2/z35sqzLOkP2g6tWd0LB3bjAYWWBQAJuKjvsvWMrptckj390x/eXXvvLAhu+cVa40jZUTXYz/vBUzV/WB+sH5hFQDZnza01uZQHqof/f0dqlZJgWKF/svSDK3vu3zqyD7tgfyYcyIjysLTYLzfi4dwSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551846; c=relaxed/simple;
	bh=/Vaq0hzz7E5UnsTDdsN3MScHnohVQe3Pml/n8qH6Tgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pzl0eizpn81OuswWGYupxoqq7VLeozF2rvR8+5ED47Si5uvaAHpxCkvb9D0BLnw08w2xiMtcN3pGig3J9Upkpw5qxLU2IpItZlLLzGSgT2yw12nftPcQui7yVbme//GGBQNa2wdnDsHc2AMAXLTfamrEel/s8/nxbQGcSfkrnkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CZA9S1H7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d2b354c72so3353268f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708551843; x=1709156643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gYJRtMoIKJFVH+z/bQCTO72nDr9l+UhUGSu3vRcRBJw=;
        b=CZA9S1H7YBYUSxJoZK1aeqYSUyPBoTpRA/czjf864pWy7DQr/8F/wbyR8LwsWeckNF
         A7pllDgjvRniQ5rN5rSLJul+4kHq94AaOjnFow7HOFNAMbZ3kC1KXY992kqzeuY88+fJ
         NO6NTksRH+neB6i6zBuOTxyV787vVIJzmwAB4lXhmZv4t2MXY4iE9mBPLN10I0qjbgbk
         K/HR3I2PwSpCLdGjLzGcjjnXPJDHcIRvnGioN3Mnn8UqYOdxZdMGq7HurnnlDpaIgSmB
         TRXLeqwNxT12B61P5nzG5xy7X2EWD8hXgp8j8cmB47jGDUlfKBBC9hzYHaxp9X4XmM6J
         Eyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551843; x=1709156643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYJRtMoIKJFVH+z/bQCTO72nDr9l+UhUGSu3vRcRBJw=;
        b=Sl+NZFU/m5mMNLKbCZY204imuSa+QNLKuuP06J4tzzyNuQBTFbBkqn69VK2twi/MVK
         SyXaL6YihkiOlc6yuWxseObVbGizdqErIyBMG16y7IlLLMbNpiLw3YZst2b0WD6+6kcs
         mJcq6l3mDz1RVgORsro26TIW3YBy7yOodQSKKPy1yzBgvmbHGL9HEEMQ50IiU7AciAjp
         mgjX1GWFsDTyfnqH3EENzMXshF4cH355CCfZ831tquG9N49nUIZ8KcqEYdx428zRwtTV
         zUf2lH60F08Rl4tgLq6MG3kUZiUmItnTvrdr1VJw+j+UXV0ROLXC6VdmiyZNjkX8+Nrt
         sI/w==
X-Forwarded-Encrypted: i=1; AJvYcCVq9B3wjWS8C1kQyD/guyK2X1v6/o8hayJiRCcS8gmiYQ3twdaQD70PNHqDO3XJplIqgN1JMi44zooBUlkEmbFfZKql0+F74MMy/dMC
X-Gm-Message-State: AOJu0YzP/hnn6BWu/CWB73/4mjtRModSbHHk/kT4bLvHE5h8CFNzoeuR
	Vpho9i1QmhPgCUqWwUBzPrQFQBFVQqcnlow8Z2GfsG0uaR1MDT9B
X-Google-Smtp-Source: AGHT+IGRxW4BiwFmPDduFWwDS+y14jjIZGwpxNkLGKAqBL8CVe54qT3cRn6tIitS6iXRRC/drR9O4w==
X-Received: by 2002:a5d:5f92:0:b0:33d:82a9:206e with SMTP id dr18-20020a5d5f92000000b0033d82a9206emr2206781wrb.28.1708551842773;
        Wed, 21 Feb 2024 13:44:02 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-bda0-ec00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:bda0:ec00::e63])
        by smtp.googlemail.com with ESMTPSA id h7-20020a056000000700b0033ce214a97csm18021982wrx.17.2024.02.21.13.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:44:02 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	patrice.chotard@foss.st.com,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1] clocksource/drivers/arm_global_timer: Simplify prescaler register access
Date: Wed, 21 Feb 2024 22:43:48 +0100
Message-ID: <20240221214348.2299636-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use GENMASK() to define the prescaler mask and make the whole driver use
the mask (together with helpers such as FIELD_GET and FIELD_PREP)
instead of needed an additional shift and max value constant.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clocksource/arm_global_timer.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 8dd1e46b7176..1eb91fa00657 100644
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
+		if (psv < 0 || psv > FIELD_GET(GT_CONTROL_PRESCALER_MASK, ~0))
 			return NOTIFY_BAD;
 
 		/*
-- 
2.43.2


