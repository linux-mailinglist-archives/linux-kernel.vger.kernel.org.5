Return-Path: <linux-kernel+bounces-100708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A12A0879C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3E82866AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB2A14264A;
	Tue, 12 Mar 2024 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nvxxlLir"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AEE7BB0A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710271523; cv=none; b=m2MPLh+2pyGF1miPA9f+GPfHkz1kv3DxMn8/Dd/2MRYxcr6HqvE8+6nlunBCouzx0VSe1OLT7Q+wQNN8wv1gdQMi8Qsck/Yzc+MFSMc6wrz7bnFE80qfE9APzIPwLzrIQXT8/YzVeKp9RZNeX/4jHQ3Y6IO902D0Y0YIjAnf2JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710271523; c=relaxed/simple;
	bh=fs2JqTkeVhbTOJnRKJDW1DTPhU/mIIt/BnLnniKqQfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNfhmdd3gDmWce8WbU4jSbXf17h6MOPCJkdKmEhq50geOfa0Stzv8scxw6TTLPS0sryaLMTlZ3p2xwCyaNPwVljRHIedSaAJYrozKpdLdH5GO9epLR7+hlimxXZuuuqj2PawF33Ppu5Uc6UK88KIIf++/feUsuJ3PkrmJnrolN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nvxxlLir; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a21b920209so170718eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710271521; x=1710876321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XTNA6eQOgVZeDaw5GSB+YIN/6xC4LtEXiiAUCgqLZn8=;
        b=nvxxlLir7Ca1ZRjj2R1ShAkuq6Vwypgwmf9zA4wJc0eEIlOKWsuoQlT58AEO2P9Nkp
         +ClFdu0agLWJB/SiKUPforU4gSGb37UbMT7jyC14aIPMDOwpETbMq83FFUHnXPmtefcl
         8vD8vcO6AMbAgG6hzeG7S8ck+Jh1H9J3j4aEty1MLOHqlAHCwdNmayT4EhzsOrfNuGDn
         YlSqXNueGI5KouqvnHnKzPKt8TioJ6eX/BvpaC+M+P7aj4Z1ipWIhWx6jnnU6oLCPypc
         KrgPC4/aRayix7qGvvDVew1sQnjXZj9ssnqbxRhEmNbntLTLhm6b5aW3YTdBXrketYsE
         hVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710271521; x=1710876321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTNA6eQOgVZeDaw5GSB+YIN/6xC4LtEXiiAUCgqLZn8=;
        b=bWhWEzWiNP724ptUEpDEhpQPF7Ktvqu9HXvtrPh3y1NT48lTib76mSCiKof8ydbU3b
         QLhI4qvHt6rLjc7qZ1GY1dm8/49v/riw68E2GeKouvDjMwWZ0tC/ZATJv0oCq2+dfKEL
         Sm4jkIh2czie6Ye+2YtbZQXJPKIEXUJ/FVjGLc6sO0NOBA38CArvHz2riMm7XE1B2azB
         fLEqHn2NuD7mkMn3WaaSOQXtUqn8NRfZVmCgOa2YjLQWuhOz0eO4M7VWlEmt/WbXZsR8
         51FF9jz7mE67jOQ42o7KVm8+eUIfDirJ4ZfjpPaEmLVlhwB2GYQxe9zLAa+JlOXvHgUA
         ksng==
X-Forwarded-Encrypted: i=1; AJvYcCUbx01K3Q593IT7iZh2/mOR8/RBUyTbQrfb5HKRUjLM3vnfABKa0kJLCPz0N670uaJIr45zl072wOWC4GdqHqQBnNpwJxJTU2Y4fCnB
X-Gm-Message-State: AOJu0YxCGLNTMOnwUWv7rWxyCD+Oh/IpD6jo0bAZc3U9rz6aDaKUBPpG
	fW4AbJY/nkd0RHo4ro/+Q0UjGlRMqe9AghWeW8J1YUsJ96cCIdUXkjEPfhMHSsI=
X-Google-Smtp-Source: AGHT+IFiOD7raCGAFJ0jxa2JFYqQhVuwra5l6CJlnVTYYffky42xgWMsOYtz4U8W+MEtKqq5d39gvw==
X-Received: by 2002:a05:6358:720e:b0:17e:4fc7:d95 with SMTP id h14-20020a056358720e00b0017e4fc70d95mr1605796rwa.17.1710271521355;
        Tue, 12 Mar 2024 12:25:21 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id p1-20020a63c141000000b005dc389409c1sm6331177pgi.93.2024.03.12.12.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 12:25:20 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH] clocksource/drivers/timer-sun4i: Partially convert to a platform driver
Date: Tue, 12 Mar 2024 12:25:06 -0700
Message-ID: <20240312192519.1602493-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a
platform driver") broke the MMIO timer on the Allwinner D1 SoC because
the IRQ domain is no longer available when timer_probe() is called:

  [    0.000000] irq: no irq domain found for interrupt-controller@10000000 !
  [    0.000000] Failed to map interrupt for /soc/timer@2050000
  [    0.000000] Failed to initialize '/soc/timer@2050000': -22

Fix this by wrapping the timer initialization in a platform driver.
builtin_platform_driver_probe() must be used because the driver uses
timer_of_init(), which is marked as __init. Only convert the sun8i
variants of the hardware, because some older SoCs still need the timer
probed early for sched_clock().

Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/clocksource/timer-sun4i.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index 7bdcc60ad43c..728dac2baa84 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 
 #include "timer-of.h"
 
@@ -218,9 +219,24 @@ static int __init sun4i_timer_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
-TIMER_OF_DECLARE(sun8i_a23, "allwinner,sun8i-a23-timer",
-		 sun4i_timer_init);
-TIMER_OF_DECLARE(sun8i_v3s, "allwinner,sun8i-v3s-timer",
-		 sun4i_timer_init);
 TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
 		       sun4i_timer_init);
+
+static int __init sun4i_timer_probe(struct platform_device *pdev)
+{
+	return sun4i_timer_init(dev_of_node(&pdev->dev));
+}
+
+static const struct of_device_id sun4i_timer_of_match[] = {
+	{ .compatible = "allwinner,sun8i-a23-timer" },
+	{ .compatible = "allwinner,sun8i-v3s-timer" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver sun4i_timer_driver = {
+	.driver	= {
+		.name		= "sun4i-timer",
+		.of_match_table	= sun4i_timer_of_match,
+	},
+};
+builtin_platform_driver_probe(sun4i_timer_driver, sun4i_timer_probe);
-- 
2.43.1


