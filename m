Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35B67EAF81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjKNLt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:49:28 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 672EEE8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:49:24 -0800 (PST)
Received: from loongson.cn (unknown [10.2.5.213])
        by gateway (Coremail) with SMTP id _____8CxNvHCXlNlvfA5AA--.48113S3;
        Tue, 14 Nov 2023 19:49:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxni_CXlNlnuRBAA--.13313S2;
        Tue, 14 Nov 2023 19:49:22 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Implement stable timer shutdown interface
Date:   Tue, 14 Nov 2023 19:46:56 +0800
Message-Id: <20231114114656.1003841-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxni_CXlNlnuRBAA--.13313S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw45uFW3JFW3XF18Xry5GFX_yoW8Zw4Dpw
        srCFnxKrWYk3ZagFyDtr4kZr98J3409wsFya4DKay8CFyYqr1fGFs7trWqvF4avryFgayx
        J3W0vw1qqa17JabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cpu is hotplug out, cpu is in idle state and function
arch_cpu_idle_dead is called. Timer interrupt for this processor should
be disabled, else there will be timer interrupt for the dead cpu. Also
this prevents vcpu to schedule out during halt-polling flow when system
is running in vm mode, since there is pending timer interrupt.

This patch adds detailed implementation for timer shutdown interface, so
that timer will be disabled when cpu is plug-out.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kernel/time.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 3064af94db9c..2920770e30a9 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -58,7 +58,7 @@ static int constant_set_state_oneshot(struct clock_event_device *evt)
 	return 0;
 }
 
-static int constant_set_state_oneshot_stopped(struct clock_event_device *evt)
+static int constant_set_state_shutdown(struct clock_event_device *evt)
 {
 	unsigned long timer_config;
 
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

base-commit: 9bacdd8996c77c42ca004440be610692275ff9d0
-- 
2.39.3

