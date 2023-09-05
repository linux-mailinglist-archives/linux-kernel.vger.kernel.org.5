Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B2A7929DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354062AbjIEQ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353668AbjIEHJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:09:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7011B4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:09:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c0d5b16aacso12452735ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 00:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1693897791; x=1694502591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A/t6gia3kis5Pkr4/PDqi3tggIgG29f6OdAUFBmTTOk=;
        b=koepeEpHqKf1XFWEqqdu2qOp6fZ0MfwVwqDyNH1l3KrW8seRRSNjlNsfhYJp681uOd
         Uv2k8/oTFazmUIS5oTCjwNxbZzGxY7kdDXl/Bee4CFVMG8o4oQ2Ymgn1pnp/l1GLbzGv
         WqMTBCCRDhPIHvRGua3P6br1gD+aYaQXNl2rlENnnCUqP99rX4agO+9TKF20mHZBfNT3
         8x3wEV0YTzOz0eqUAnd11progqc9qf/8Gm15uTb6oKW+uPUtchUwQ9jRowiohzO/F1UQ
         54J8w/EFq6uImye+LEbdnDxsjjPTvQVy+iGUXm4MjwQsrHoaPSdweSVL6lFiVjULxyeC
         vGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693897791; x=1694502591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/t6gia3kis5Pkr4/PDqi3tggIgG29f6OdAUFBmTTOk=;
        b=fb2XeJyGXjeCujpkNWve4ubO5Jhw0R0xpZ67FEYRTmKhyCg5RgkDQmwTpz9RJPXDv6
         Ua3olGVM/5K9irVci0oGI8NBf/EwfBVsmyM+YSTJbj8zqBfipPauY5E9OM1RxzjgKd1/
         tz6Ntlug/rqGaAecHGcmezs6uVApNqZ8v1UOcXEzSrtGrbjjZHvTK+6RvGB+a0WFUmgd
         Pnepe/Qv9/2EpKyUClBKMBC71jAcMRmsFzLIFmfFlbTd5pGStJm8dWul5vr+1Hmndnw5
         tTE5NeoW7gwNylhqKmZj47GEL482KDHSTUebId2pPmAz3S9sR8dvLNtC4R+XE5Kzonzd
         x7IQ==
X-Gm-Message-State: AOJu0Yxpl2qUMy7QLxHaPwj7HgemcKjC8sYCGmB6nfJFGI8BUDCKCkfi
        GpLmU0+nYiYzB3Ntsyx5FyGaXA==
X-Google-Smtp-Source: AGHT+IFg5mjDF/xLoT8UBfYSdSyH069wYXbqbw5XRMPo3JKPzr9PBc5B4a/NsjiR4eXCDgNdqiCezQ==
X-Received: by 2002:a17:903:183:b0:1b8:865d:6e1d with SMTP id z3-20020a170903018300b001b8865d6e1dmr12529712plg.51.1693897791009;
        Tue, 05 Sep 2023 00:09:51 -0700 (PDT)
Received: from Vincent-X1Extreme-TW.. (111-251-205-31.dynamic-ip.hinet.net. [111.251.205.31])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902d18100b001bf5c12e9fesm8613213plb.125.2023.09.05.00.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 00:09:50 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        vincent.chen@sifive.com
Subject: [PATCH] clocksource: extend the max_delta_ns of timer-riscv and timer-clint to ULONG_MAX
Date:   Tue,  5 Sep 2023 15:09:45 +0800
Message-Id: <20230905070945.404653-1-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When registering the riscv-timer or clint-timer as a clock_event device,
the driver needs to specify the value of max_delta_ticks. This value
directly influences the max_delta_ns, which represents the maximum time
interval for configuring subsequent clock events. Currently, both
riscv-timer and clint-timer are set with a max_delta_ticks value of
0x7fff_ffff. When the timer operates at a high frequency, this values
limists the system to sleep only for a short time. For the 1GHz case,
the sleep cannot exceed two seconds. To address this limitation, refer to
other timer implementations to extend it to 2^(bit-width of the timer) - 1.
Because the bit-width of $mtimecmp is 64bit, this value becomes ULONG_MAX
(0xffff_ffff_ffff_ffff).

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
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

