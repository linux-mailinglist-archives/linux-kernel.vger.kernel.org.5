Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0F78E9EE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343720AbjHaKKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjHaKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:10:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8001BCFA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:10:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8223C15;
        Thu, 31 Aug 2023 03:11:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C0533F64C;
        Thu, 31 Aug 2023 03:10:30 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     dianders@chromium.org, keescook@chromium.org, mark.rutland@arm.com,
        sumit.garg@linaro.org, swboyd@chromium.org
Subject: [PATCH] lkdtm/bugs: add test for panic() with stuck secondary CPUs
Date:   Thu, 31 Aug 2023 11:10:26 +0100
Message-Id: <20230831101026.3122590-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon a panic() the kernel will use either smp_send_stop() or
crash_smp_send_stop() to attempt to stop secondary CPUs via an IPI,
which may or may not be an NMI. Generally it's preferable that this is an
NMI so that CPUs can be stopped in as many situations as possible, but
it's not always possible to provide an NMI, and there are cases where
CPUs may be unable to handle the NMI regardless.

This patch adds a test for panic() where all other CPUs are stuck with
interrupts disabled, which can be used to check whether the kernel
gracefully handles CPUs failing to respond to a stop, and whe NMIs stops
work.

For example, on arm64 *without* an NMI, this results in:

| # echo PANIC_STOP_IRQOFF > /sys/kernel/debug/provoke-crash/DIRECT
| lkdtm: Performing direct entry PANIC_STOP_IRQOFF
| Kernel panic - not syncing: panic stop irqoff test
| CPU: 2 PID: 24 Comm: migration/2 Not tainted 6.5.0-rc3-00077-ge6c782389895-dirty #4
| Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
| Stopper: multi_cpu_stop+0x0/0x1a0 <- stop_machine_cpuslocked+0x158/0x1a4
| Call trace:
|  dump_backtrace+0x94/0xec
|  show_stack+0x18/0x24
|  dump_stack_lvl+0x74/0xc0
|  dump_stack+0x18/0x24
|  panic+0x358/0x3e8
|  lkdtm_PANIC+0x0/0x18
|  multi_cpu_stop+0x9c/0x1a0
|  cpu_stopper_thread+0x84/0x118
|  smpboot_thread_fn+0x224/0x248
|  kthread+0x114/0x118
|  ret_from_fork+0x10/0x20
| SMP: stopping secondary CPUs
| SMP: failed to stop secondary CPUs 0-3
| Kernel Offset: 0x401cf3490000 from 0xffff800080000000
| PHYS_OFFSET: 0x40000000
| CPU features: 0x00000000,68c167a1,cce6773f
| Memory Limit: none
| ---[ end Kernel panic - not syncing: panic stop irqoff test ]---

On arm64 *with* an NMI, this results in:

| # echo PANIC_STOP_IRQOFF > /sys/kernel/debug/provoke-crash/DIRECT
| lkdtm: Performing direct entry PANIC_STOP_IRQOFF
| Kernel panic - not syncing: panic stop irqoff test
| CPU: 1 PID: 19 Comm: migration/1 Not tainted 6.5.0-rc3-00077-ge6c782389895-dirty #4
| Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
| Stopper: multi_cpu_stop+0x0/0x1a0 <- stop_machine_cpuslocked+0x158/0x1a4
| Call trace:
|  dump_backtrace+0x94/0xec
|  show_stack+0x18/0x24
|  dump_stack_lvl+0x74/0xc0
|  dump_stack+0x18/0x24
|  panic+0x358/0x3e8
|  lkdtm_PANIC+0x0/0x18
|  multi_cpu_stop+0x9c/0x1a0
|  cpu_stopper_thread+0x84/0x118
|  smpboot_thread_fn+0x224/0x248
|  kthread+0x114/0x118
|  ret_from_fork+0x10/0x20
| SMP: stopping secondary CPUs
| Kernel Offset: 0x55a9c0bc0000 from 0xffff800080000000
| PHYS_OFFSET: 0x40000000
| CPU features: 0x00000000,68c167a1,fce6773f
| Memory Limit: none
| ---[ end Kernel panic - not syncing: panic stop irqoff test ]---

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org
Cc: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/misc/lkdtm/bugs.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

I've tested this with the arm64 NMI IPI patches:

  https://lore.kernel.org/linux-arm-kernel/20230830191314.1618136-1-dianders@chromium.org/

Specifically, with the patch that uses an NMI for IPI_CPU_STOP and
IPI_CPU_CRASH_STOP:

  https://lore.kernel.org/linux-arm-kernel/20230830121115.v12.5.Ifadbfd45b22c52edcb499034dd4783d096343260@changeid/

Mark.

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 3c95600ab2f71..368da8b83cd1c 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -6,12 +6,14 @@
  * test source files.
  */
 #include "lkdtm.h"
+#include <linux/cpu.h>
 #include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
-#include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <linux/stop_machine.h>
+#include <linux/uaccess.h>
 
 #if IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_UML)
 #include <asm/desc.h>
@@ -73,6 +75,30 @@ static void lkdtm_PANIC(void)
 	panic("dumptest");
 }
 
+static int panic_stop_irqoff_fn(void *arg)
+{
+	atomic_t *v = arg;
+
+	/*
+	 * Trigger the panic after all other CPUs have entered this function,
+	 * so that they are guaranteed to have IRQs disabled.
+	 */
+	if (atomic_inc_return(v) == num_online_cpus())
+		panic("panic stop irqoff test");
+
+	for (;;)
+		cpu_relax();
+}
+
+static void lkdtm_PANIC_STOP_IRQOFF(void)
+{
+	atomic_t v = ATOMIC_INIT(0);
+
+	cpus_read_lock();
+	stop_machine(panic_stop_irqoff_fn, &v, cpu_online_mask);
+	cpus_read_unlock();
+}
+
 static void lkdtm_BUG(void)
 {
 	BUG();
@@ -598,6 +624,7 @@ static noinline void lkdtm_CORRUPT_PAC(void)
 
 static struct crashtype crashtypes[] = {
 	CRASHTYPE(PANIC),
+	CRASHTYPE(PANIC_STOP_IRQOFF),
 	CRASHTYPE(BUG),
 	CRASHTYPE(WARNING),
 	CRASHTYPE(WARNING_MESSAGE),
-- 
2.30.2

