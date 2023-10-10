Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA177BFB81
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjJJMdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjJJMd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:33:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB719B6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:33:23 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S4ZvL17YfztTHX;
        Tue, 10 Oct 2023 20:28:46 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 20:33:22 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <mark.rutland@arm.com>, <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
        <wanghuiqiang@huawei.com>, <wangwudi@hisilicon.com>,
        <guohanjun@huawei.com>, <yangyicong@hisilicon.com>,
        <linuxarm@huawei.com>
Subject: [RFC PATCH 2/3] clocksource/drivers/arm_arch_timer: Extend and export arch_timer_mem_register()
Date:   Tue, 10 Oct 2023 20:30:32 +0800
Message-ID: <20231010123033.23258-3-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231010123033.23258-1-yangyicong@huawei.com>
References: <20231010123033.23258-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Currently the memory-mapped timer will be probed by the GTDT table on
ACPI based systems, and the timer interrupt can only be the GSI (SPI
interrupt for arm64) per ACPI spec. However the generic timer
specification doesn't restrict the interrupt type and per BSA Spec
section 3.8.1 (DEN0094C 1.0C) the timer interrupt can also be a LPI
interrupt.

So this patch extends and exports the arch_timer_mem_register() function
to allow other drivers registers a generic timer using LPI interrupt
and probed by other means rather than GTDT. Note that the GTDT timer
still has a higher priority, if a GTDT timer is registered, we'll block
later registration of other timers.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/clocksource/arm_arch_timer.c | 26 +++++++++++++++++---------
 include/clocksource/arm_arch_timer.h |  2 ++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 2e20a8ec50ca..6e9445192ca4 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -66,7 +66,7 @@ struct arch_timer {
 	struct clock_event_device evt;
 };
 
-static struct arch_timer *arch_timer_mem __ro_after_init;
+static struct arch_timer *arch_timer_mem;
 
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
@@ -888,15 +888,16 @@ static void __arch_timer_setup_cp15(struct clock_event_device *clk)
 	clockevents_config_and_register(clk, arch_timer_rate, 0xf, max_delta);
 }
 
-static void __arch_timer_setup_mem(struct clock_event_device *clk)
+static void __arch_timer_setup_mem(struct clock_event_device *clk,
+				   bool irq_virtual, const char *name)
 {
 	u64 max_delta;
 
 	clk->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ;
-	clk->name = "arch_mem_timer";
+	clk->name = name;
 	clk->rating = 400;
 	clk->cpumask = cpu_possible_mask;
-	if (arch_timer_mem_use_virtual) {
+	if (irq_virtual) {
 		clk->set_state_shutdown = arch_timer_shutdown_virt_mem;
 		clk->set_state_oneshot_stopped = arch_timer_shutdown_virt_mem;
 		clk->set_next_event =
@@ -1286,25 +1287,30 @@ static int __init arch_timer_register(void)
 	return err;
 }
 
-static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
+int arch_timer_mem_register(void __iomem *base, unsigned int irq,
+			    bool irq_virtual, const char *name)
 {
 	int ret;
 	irq_handler_t func;
 
+	/* If we've already register a memory timer, fail the registration */
+	if (arch_timer_mem)
+		return -EEXIST;
+
 	arch_timer_mem = kzalloc(sizeof(*arch_timer_mem), GFP_KERNEL);
 	if (!arch_timer_mem)
 		return -ENOMEM;
 
 	arch_timer_mem->base = base;
 	arch_timer_mem->evt.irq = irq;
-	__arch_timer_setup_mem(&arch_timer_mem->evt);
+	__arch_timer_setup_mem(&arch_timer_mem->evt, irq_virtual, name);
 
-	if (arch_timer_mem_use_virtual)
+	if (irq_virtual)
 		func = arch_timer_handler_virt_mem;
 	else
 		func = arch_timer_handler_phys_mem;
 
-	ret = request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &arch_timer_mem->evt);
+	ret = request_irq(irq, func, IRQF_TIMER, name, &arch_timer_mem->evt);
 	if (ret) {
 		pr_err("Failed to request mem timer irq\n");
 		kfree(arch_timer_mem);
@@ -1313,6 +1319,7 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(arch_timer_mem_register);
 
 static const struct of_device_id arch_timer_of_match[] __initconst = {
 	{ .compatible   = "arm,armv7-timer",    },
@@ -1560,7 +1567,8 @@ arch_timer_mem_frame_register(struct arch_timer_mem_frame *frame)
 		return -ENXIO;
 	}
 
-	ret = arch_timer_mem_register(base, irq);
+	ret = arch_timer_mem_register(base, irq, arch_timer_mem_use_virtual,
+				      "arch_mem_timer");
 	if (ret) {
 		iounmap(base);
 		return ret;
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index cbbc9a6dc571..d0fa2065586c 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -89,6 +89,8 @@ extern u32 arch_timer_get_rate(void);
 extern u64 (*arch_timer_read_counter)(void);
 extern struct arch_timer_kvm_info *arch_timer_get_kvm_info(void);
 extern bool arch_timer_evtstrm_available(void);
+extern int arch_timer_mem_register(void __iomem *base, unsigned int irq,
+				   bool irq_virtual, const char *name);
 
 #else
 
-- 
2.24.0

