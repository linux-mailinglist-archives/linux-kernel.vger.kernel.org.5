Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4CE7FC8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376382AbjK1VIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376336AbjK1VHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:07:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC8A271C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:07:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C50C433CA;
        Tue, 28 Nov 2023 21:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205631;
        bh=WC3ZNUMc0KkG5elTrcbpJ6cdL4mgiViegpDo+7f1EXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZJQ5F91PLk6eUEWuGCwlzTMAENuJOuXGC0uW05U53XKkjO+sm23IyxEHbHp6k+Cs
         tknxXMIXkrkHv5oHLvr+ajdz3pystdtsYbr++/EI9yb7mo0axZYoMMbFE1wmd7QGOq
         Vr8y9K7R1rMCUjgreeV0w1GaLUuTlKiG4IxRkWFViIt1ayQK1h9HeGnw1wi8U73+1Y
         paUPSRBPl5sVnvUZr2/3hliy1l5I5sRTTUjrxfGHbQYXhON4cjJKuHDDf/7OD7/i7q
         tde3Y+rjpKd/14YpwNYQm+U6OBAOWIx60kVNwODj+4/tb3IPxAF6KnKxHLpsyIbtbh
         jknyedAt8iA/A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bibo Mao <maobibo@loongson.cn>, WANG Xuerui <git@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        yangtiezhu@loongson.cn, peterz@infradead.org,
        loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 22/40] LoongArch: Implement constant timer shutdown interface
Date:   Tue, 28 Nov 2023 16:05:28 -0500
Message-ID: <20231128210615.875085-22-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bibo Mao <maobibo@loongson.cn>

[ Upstream commit d43f37b73468c172bc89ac4824a1511b411f0778 ]

When a cpu is hot-unplugged, it is put in idle state and the function
arch_cpu_idle_dead() is called. The timer interrupt for this processor
should be disabled, otherwise there will be pending timer interrupt for
the unplugged cpu, so that vcpu is prevented from giving up scheduling
when system is running in vm mode.

This patch implements the timer shutdown interface so that the constant
timer will be properly disabled when a CPU is hot-unplugged.

Reviewed-by: WANG Xuerui <git@xen0n.name>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/time.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 3064af94db9c2..e7015f7b70e37 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -58,14 +58,16 @@ static int constant_set_state_oneshot(struct clock_event_device *evt)
 	return 0;
 }
 
-static int constant_set_state_oneshot_stopped(struct clock_event_device *evt)
+static int constant_set_state_periodic(struct clock_event_device *evt)
 {
+	unsigned long period;
 	unsigned long timer_config;
 
 	raw_spin_lock(&state_lock);
 
-	timer_config = csr_read64(LOONGARCH_CSR_TCFG);
-	timer_config &= ~CSR_TCFG_EN;
+	period = const_clock_freq / HZ;
+	timer_config = period & CSR_TCFG_VAL;
+	timer_config |= (CSR_TCFG_PERIOD | CSR_TCFG_EN);
 	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
 
 	raw_spin_unlock(&state_lock);
@@ -73,16 +75,14 @@ static int constant_set_state_oneshot_stopped(struct clock_event_device *evt)
 	return 0;
 }
 
-static int constant_set_state_periodic(struct clock_event_device *evt)
+static int constant_set_state_shutdown(struct clock_event_device *evt)
 {
-	unsigned long period;
 	unsigned long timer_config;
 
 	raw_spin_lock(&state_lock);
 
-	period = const_clock_freq / HZ;
-	timer_config = period & CSR_TCFG_VAL;
-	timer_config |= (CSR_TCFG_PERIOD | CSR_TCFG_EN);
+	timer_config = csr_read64(LOONGARCH_CSR_TCFG);
+	timer_config &= ~CSR_TCFG_EN;
 	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
 
 	raw_spin_unlock(&state_lock);
@@ -90,11 +90,6 @@ static int constant_set_state_periodic(struct clock_event_device *evt)
 	return 0;
 }
 
-static int constant_set_state_shutdown(struct clock_event_device *evt)
-{
-	return 0;
-}
-
 static int constant_timer_next_event(unsigned long delta, struct clock_event_device *evt)
 {
 	unsigned long timer_config;
@@ -161,7 +156,7 @@ int constant_clockevent_init(void)
 	cd->rating = 320;
 	cd->cpumask = cpumask_of(cpu);
 	cd->set_state_oneshot = constant_set_state_oneshot;
-	cd->set_state_oneshot_stopped = constant_set_state_oneshot_stopped;
+	cd->set_state_oneshot_stopped = constant_set_state_shutdown;
 	cd->set_state_periodic = constant_set_state_periodic;
 	cd->set_state_shutdown = constant_set_state_shutdown;
 	cd->set_next_event = constant_timer_next_event;
-- 
2.42.0

