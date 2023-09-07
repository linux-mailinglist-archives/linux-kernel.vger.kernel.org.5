Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C8E797B96
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbjIGSWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbjIGSV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:21:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A5979D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:21:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7E21175D;
        Thu,  7 Sep 2023 06:35:04 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A0BA13F766;
        Thu,  7 Sep 2023 06:34:25 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, maz@kernel.org, tglx@linutronix.de
Subject: [PATCH] clocksource/drivers/arm_arch_timer: Initialize evtstrm after finalizing cpucaps
Date:   Thu,  7 Sep 2023 14:34:10 +0100
Message-Id: <20230907133410.3817800-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We attempt to initialize each CPU's arch_timer event stream in
arch_timer_evtstrm_enable(), which we call from the
arch_timer_starting_cpu() cpu hotplug callback which is registered early
in boot. As this is registered before we initialize the system cpucaps,
the test for ARM64_HAS_ECV will always be false for CPUs present at boot
time, and will only be taken into account for CPUs onlined late
(including those which are hotplugged out and in again).

Due to this, CPUs present and boot time may not use the intended divider
and scale factor to generate the event stream, and may differ from other
CPUs.

Correct this by only initializing the event stream after cpucaps have been
finalized, registering a separate CPU hotplug callback for the event stream
configuration. Since the caps must be finalized by this point, use
spus_have_final_cap() to verify this.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/arm_arch_timer.c | 31 +++++++++++++++++++++++-----
 include/linux/cpuhotplug.h           |  1 +
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index e733a2a1927a4..8f7eae19c6fac 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -910,7 +910,7 @@ static void arch_timer_evtstrm_enable(unsigned int divider)
 
 #ifdef CONFIG_ARM64
 	/* ECV is likely to require a large divider. Use the EVNTIS flag. */
-	if (cpus_have_const_cap(ARM64_HAS_ECV) && divider > 15) {
+	if (cpus_have_final_cap(ARM64_HAS_ECV) && divider > 15) {
 		cntkctl |= ARCH_TIMER_EVT_INTERVAL_SCALE;
 		divider -= 8;
 	}
@@ -948,6 +948,30 @@ static void arch_timer_configure_evtstream(void)
 	arch_timer_evtstrm_enable(max(0, lsb));
 }
 
+static int arch_timer_evtstrm_starting_cpu(unsigned int cpu)
+{
+	arch_timer_configure_evtstream();
+	return 0;
+}
+
+static int arch_timer_evtstrm_dying_cpu(unsigned int cpu)
+{
+	cpumask_clear_cpu(smp_processor_id(), &evtstrm_available);
+	return 0;
+}
+
+static int __init arch_timer_evtstrm_register(void)
+{
+	if (!arch_timer_evt || !evtstrm_enable)
+		return 0;
+
+	return cpuhp_setup_state(CPUHP_AP_ARM_ARCH_TIMER_EVTSTRM_STARTING,
+				 "clockevents/arm/arch_timer_evtstrm:starting",
+				 arch_timer_evtstrm_starting_cpu,
+				 arch_timer_evtstrm_dying_cpu);
+}
+core_initcall(arch_timer_evtstrm_register);
+
 static void arch_counter_set_user_access(void)
 {
 	u32 cntkctl = arch_timer_get_cntkctl();
@@ -1009,8 +1033,6 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	}
 
 	arch_counter_set_user_access();
-	if (evtstrm_enable)
-		arch_timer_configure_evtstream();
 
 	return 0;
 }
@@ -1157,8 +1179,6 @@ static int arch_timer_dying_cpu(unsigned int cpu)
 {
 	struct clock_event_device *clk = this_cpu_ptr(arch_timer_evt);
 
-	cpumask_clear_cpu(smp_processor_id(), &evtstrm_available);
-
 	arch_timer_stop(clk);
 	return 0;
 }
@@ -1272,6 +1292,7 @@ static int __init arch_timer_register(void)
 
 out_free:
 	free_percpu(arch_timer_evt);
+	arch_timer_evt = NULL;
 out:
 	return err;
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 25b6e6e6ba6bc..6726ba52361f1 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -173,6 +173,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_L2X0_STARTING,
 	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
+	CPUHP_AP_ARM_ARCH_TIMER_EVTSTRM_STARTING,
 	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 	CPUHP_AP_JCORE_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
-- 
2.30.2

