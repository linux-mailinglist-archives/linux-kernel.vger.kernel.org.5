Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A9A774537
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjHHSid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjHHSiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:38:15 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BD3122609
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:51:27 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-cfcebc33d04so5851875276.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691513478; x=1692118278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=babUiTuTO3XII8RrX4Z4hMs56Oti8JO2J40Ktf1kYkA=;
        b=Wo81nnqHn1n2mtZlqJocCex/W0I68S4Mt/SbC7c9bDH+T2DAT2TRQThtjq1lehtZAj
         RJQuMgLcrCq5lPe5zhM0V2RVLnpSGqbnkUrC8lJifFuLcHtUn1cW49dWKoSSBLqL8TTv
         H2bpZ0c/w+ldCGlUo5Or2uZdEU5Ac61sH/2kvhbKczGVOdl1e6uxyJ0O1HKZCYamVXki
         FoYrgg89EAGBErR9M2Ey42fk98KqDexZ9VVNGuM68ebf8eg0vkq/iNIjBzDenH09IBqu
         D3YKM6BD1ib3jV31u9OAZ6SMSle/W4rOwVuHdEodglT4d/kWe2L3rSv2KGUDZ69AqHS7
         BGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513478; x=1692118278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=babUiTuTO3XII8RrX4Z4hMs56Oti8JO2J40Ktf1kYkA=;
        b=il6JdXOtjFu8BxRhqGxeUEaCyqrh928JCOLCz8aCHlpaH/QInpNp+eWmc8T7IQ4n8i
         Cvw1a6x/uNZFcOod4aFyygRN3IJGcjAWkrKUKMzd3lj7u9BodEpE8NBK457+EJr4pRNb
         1ULK9MrrigEp7eixCC/lcro9Coz3XzhvI7aiBGXNMI37WwzFf4/ILfKoFeNqmp50qbmZ
         X/wyTz3Pls7q7Bch3muEMa9WMaxwkM3O9nZEQ2eibmSNJrLhMpH24fTlDcd3U9MvT3/X
         cmx9fgJp/a14TG6CYWls0ch5QdFFRaw1rt242jxgl0jNOIkqs4W19hH7tEVn7tT3MyYe
         4UYw==
X-Gm-Message-State: AOJu0YwSjFPdUS/TnRXeWQo0pHdQ4VdCgWNWCzDbMZGndYVNY7ytv+pR
        I6RtpvonjFXIUgj5F27g4Qnph4hnN5RGGM9RWjI=
X-Google-Smtp-Source: AGHT+IFaXi9wHjqFoxKys/6UFY5qNlD7CLWDafnLI9w3DlsPiqN5DMlgGYl4JYbjmS0etpmgbEqP0A==
X-Received: by 2002:a17:903:22cd:b0:1b9:f7dc:b4f6 with SMTP id y13-20020a17090322cd00b001b9f7dcb4f6mr11455373plg.44.1691470322938;
        Mon, 07 Aug 2023 21:52:02 -0700 (PDT)
Received: from Vincent-X1Extreme-TW.. (111-251-205-117.dynamic-ip.hinet.net. [111.251.205.117])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090282c500b001b7f40a8959sm7837131plz.76.2023.08.07.21.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 21:52:02 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        vincent.chen@sifive.com
Subject: [PATCH] [RFC PATCH v1] clocksource: entend the max_delta_ns of timer-riscv andtimer-clint to ULONG_MAX
Date:   Tue,  8 Aug 2023 12:51:45 +0800
Message-Id: <20230808045145.3552312-1-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincentc Chen <vincent.chen@sifive.com>

When registering the riscv-timer or clint-timer as a clock_event device,
the driver needs to specify the value of max_delta_ticks. This value
directly influences the max_delta_ns, which signifies the maximum time
interval for configuring subsequent clock events. Currently, both
riscv-timer and clint-timer are set with a max_delta_ticks value of
0x7fff_ffff. When the timer operates at a high frequency, such as 1GHz,
this causes the system only can sleep for a short time. For the 1GHz
case, the sleep cannot exceed two seconds. To address this limitation,
refer to other timer implementations to extend it to 2^(bit-width of the
timer) - 1. Because the bit-width of $mtimecmp is 64bit, so this value
becomes ULONG_MAX (0xffff_ffff_ffff_ffff).

Signed-off-by: Vincentc Chen <vincent.chen@sifive.com>
---
 drivers/clocksource/timer-clint.c | 2 +-
 drivers/clocksource/timer-riscv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 9a55e733ae99..09fd292eb83d 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -131,7 +131,7 @@ static int clint_timer_starting_cpu(unsigned int cpu)
 	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
 
 	ce->cpumask = cpumask_of(cpu);
-	clockevents_config_and_register(ce, clint_timer_freq, 100, 0x7fffffff);
+	clockevents_config_and_register(ce, clint_timer_freq, 100, ULONG_MAX);
 
 	enable_percpu_irq(clint_timer_irq,
 			  irq_get_trigger_type(clint_timer_irq));
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index da3071b387eb..b25c91d41968 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -94,7 +94,7 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 	ce->irq = riscv_clock_event_irq;
 	if (riscv_timer_cannot_wake_cpu)
 		ce->features |= CLOCK_EVT_FEAT_C3STOP;
-	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
+	clockevents_config_and_register(ce, riscv_timebase, 100, ULONG_MAX);
 
 	enable_percpu_irq(riscv_clock_event_irq,
 			  irq_get_trigger_type(riscv_clock_event_irq));
-- 
2.34.1

