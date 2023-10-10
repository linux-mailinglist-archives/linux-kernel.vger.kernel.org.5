Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDA17BFB7F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjJJMd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjJJMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:33:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C54B0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:33:23 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S4Zw61yY1zNnx2;
        Tue, 10 Oct 2023 20:29:26 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 20:33:21 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <mark.rutland@arm.com>, <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
        <wanghuiqiang@huawei.com>, <wangwudi@hisilicon.com>,
        <guohanjun@huawei.com>, <yangyicong@hisilicon.com>,
        <linuxarm@huawei.com>
Subject: [RFC PATCH 1/3] clocksource/drivers/arm_arch_timer: Split the function of __arch_timer_setup()
Date:   Tue, 10 Oct 2023 20:30:31 +0800
Message-ID: <20231010123033.23258-2-yangyicong@huawei.com>
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

Currently we use __arch_timer_setup() to setup and register clockevents
device for both cp15 and memory-mapped timer. However there's not too
much in common of the setups for cp15 and memory-mapped timer. So split
the setup function for cp15 and memory-mapped timer into separate
functions. This will also allows future extension for platform timers.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/clocksource/arm_arch_timer.c | 105 ++++++++++++++-------------
 1 file changed, 54 insertions(+), 51 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 7dd2c615bce2..2e20a8ec50ca 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -849,65 +849,68 @@ static u64 __arch_timer_check_delta(void)
 	return CLOCKSOURCE_MASK(arch_counter_get_width());
 }
 
-static void __arch_timer_setup(unsigned type,
-			       struct clock_event_device *clk)
+static void __arch_timer_setup_cp15(struct clock_event_device *clk)
 {
+	typeof(clk->set_next_event) sne;
 	u64 max_delta;
 
 	clk->features = CLOCK_EVT_FEAT_ONESHOT;
 
-	if (type == ARCH_TIMER_TYPE_CP15) {
-		typeof(clk->set_next_event) sne;
-
-		arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
-
-		if (arch_timer_c3stop)
-			clk->features |= CLOCK_EVT_FEAT_C3STOP;
-		clk->name = "arch_sys_timer";
-		clk->rating = 450;
-		clk->cpumask = cpumask_of(smp_processor_id());
-		clk->irq = arch_timer_ppi[arch_timer_uses_ppi];
-		switch (arch_timer_uses_ppi) {
-		case ARCH_TIMER_VIRT_PPI:
-			clk->set_state_shutdown = arch_timer_shutdown_virt;
-			clk->set_state_oneshot_stopped = arch_timer_shutdown_virt;
-			sne = erratum_handler(set_next_event_virt);
-			break;
-		case ARCH_TIMER_PHYS_SECURE_PPI:
-		case ARCH_TIMER_PHYS_NONSECURE_PPI:
-		case ARCH_TIMER_HYP_PPI:
-			clk->set_state_shutdown = arch_timer_shutdown_phys;
-			clk->set_state_oneshot_stopped = arch_timer_shutdown_phys;
-			sne = erratum_handler(set_next_event_phys);
-			break;
-		default:
-			BUG();
-		}
-
-		clk->set_next_event = sne;
-		max_delta = __arch_timer_check_delta();
-	} else {
-		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
-		clk->name = "arch_mem_timer";
-		clk->rating = 400;
-		clk->cpumask = cpu_possible_mask;
-		if (arch_timer_mem_use_virtual) {
-			clk->set_state_shutdown = arch_timer_shutdown_virt_mem;
-			clk->set_state_oneshot_stopped = arch_timer_shutdown_virt_mem;
-			clk->set_next_event =
-				arch_timer_set_next_event_virt_mem;
-		} else {
-			clk->set_state_shutdown = arch_timer_shutdown_phys_mem;
-			clk->set_state_oneshot_stopped = arch_timer_shutdown_phys_mem;
-			clk->set_next_event =
-				arch_timer_set_next_event_phys_mem;
-		}
+	arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
 
-		max_delta = CLOCKSOURCE_MASK(56);
+	if (arch_timer_c3stop)
+		clk->features |= CLOCK_EVT_FEAT_C3STOP;
+	clk->name = "arch_sys_timer";
+	clk->rating = 450;
+	clk->cpumask = cpumask_of(smp_processor_id());
+	clk->irq = arch_timer_ppi[arch_timer_uses_ppi];
+	switch (arch_timer_uses_ppi) {
+	case ARCH_TIMER_VIRT_PPI:
+		clk->set_state_shutdown = arch_timer_shutdown_virt;
+		clk->set_state_oneshot_stopped = arch_timer_shutdown_virt;
+		sne = erratum_handler(set_next_event_virt);
+		break;
+	case ARCH_TIMER_PHYS_SECURE_PPI:
+	case ARCH_TIMER_PHYS_NONSECURE_PPI:
+	case ARCH_TIMER_HYP_PPI:
+		clk->set_state_shutdown = arch_timer_shutdown_phys;
+		clk->set_state_oneshot_stopped = arch_timer_shutdown_phys;
+		sne = erratum_handler(set_next_event_phys);
+		break;
+	default:
+		BUG();
 	}
 
+	clk->set_next_event = sne;
+	max_delta = __arch_timer_check_delta();
+
 	clk->set_state_shutdown(clk);
+	clockevents_config_and_register(clk, arch_timer_rate, 0xf, max_delta);
+}
+
+static void __arch_timer_setup_mem(struct clock_event_device *clk)
+{
+	u64 max_delta;
 
+	clk->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ;
+	clk->name = "arch_mem_timer";
+	clk->rating = 400;
+	clk->cpumask = cpu_possible_mask;
+	if (arch_timer_mem_use_virtual) {
+		clk->set_state_shutdown = arch_timer_shutdown_virt_mem;
+		clk->set_state_oneshot_stopped = arch_timer_shutdown_virt_mem;
+		clk->set_next_event =
+			arch_timer_set_next_event_virt_mem;
+	} else {
+		clk->set_state_shutdown = arch_timer_shutdown_phys_mem;
+		clk->set_state_oneshot_stopped = arch_timer_shutdown_phys_mem;
+		clk->set_next_event =
+			arch_timer_set_next_event_phys_mem;
+	}
+
+	max_delta = CLOCKSOURCE_MASK(56);
+
+	clk->set_state_shutdown(clk);
 	clockevents_config_and_register(clk, arch_timer_rate, 0xf, max_delta);
 }
 
@@ -1004,7 +1007,7 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	struct clock_event_device *clk = this_cpu_ptr(arch_timer_evt);
 	u32 flags;
 
-	__arch_timer_setup(ARCH_TIMER_TYPE_CP15, clk);
+	__arch_timer_setup_cp15(clk);
 
 	flags = check_ppi_trigger(arch_timer_ppi[arch_timer_uses_ppi]);
 	enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], flags);
@@ -1294,7 +1297,7 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
 
 	arch_timer_mem->base = base;
 	arch_timer_mem->evt.irq = irq;
-	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &arch_timer_mem->evt);
+	__arch_timer_setup_mem(&arch_timer_mem->evt);
 
 	if (arch_timer_mem_use_virtual)
 		func = arch_timer_handler_virt_mem;
-- 
2.24.0

