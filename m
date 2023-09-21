Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AA47A98D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjIURxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjIURxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:53:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA5FB66354
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:34:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42EF116F3;
        Thu, 21 Sep 2023 09:17:16 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3BC6B3F59C;
        Thu, 21 Sep 2023 09:16:38 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     dianders@chromium.org, keescook@chromium.org, mark.rutland@arm.com,
        sumit.garg@linaro.org, swboyd@chromium.org
Subject: [PATCH v2] lkdtm/bugs: add test for panic() with stuck secondary CPUs
Date:   Thu, 21 Sep 2023 17:16:34 +0100
Message-Id: <20230921161634.4063233-1-mark.rutland@arm.com>
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

Upon a panic() the kernel will use either smp_send_stop() or
crash_smp_send_stop() to attempt to stop secondary CPUs via an IPI,
which may or may not be an NMI. Generally it's preferable that this is an
NMI so that CPUs can be stopped in as many situations as possible, but
it's not always possible to provide an NMI, and there are cases where
CPUs may be unable to handle the NMI regardless.

This patch adds a test for panic() where all other CPUs are stuck with
interrupts disabled, which can be used to check whether the kernel
gracefully handles CPUs failing to respond to a stop, and whether NMIs
actually work to stop CPUs.

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
| Kernel Offset: 0x401cf3490000 from 0xffff80008000000c0
| PHYS_OFFSET: 0x40000000
| CPU features: 0x00000000,68c167a1,cce6773f
| Memory Limit: none
| ---[ end Kernel panic - not syncing: panic stop irqoff test ]---

Note the "failed to stop secondary CPUs 0-3" message.

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

Note the absence of a "failed to stop secondary CPUs" message, since we
don't log anything when secondary CPUs are successfully stopped.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org
Cc: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/misc/lkdtm/bugs.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

Since v1 [1]:
* Improve commit message
* Clarify comment in panic_stop_irqoff_fn()
* Drop cpus_read_{lock,unlock}()
* Fold in tags

[1] https://lore.kernel.org/all/20230831101026.3122590-1-mark.rutland@arm.com/

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index c66cc05a68c45..b080eb2335eba 100644
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
@@ -73,6 +75,31 @@ static void lkdtm_PANIC(void)
 	panic("dumptest");
 }
 
+static int panic_stop_irqoff_fn(void *arg)
+{
+	atomic_t *v = arg;
+
+	/*
+	 * As stop_machine() disables interrupts, all CPUs within this function
+	 * have interrupts disabled and cannot take a regular IPI.
+	 *
+	 * The last CPU which enters here will trigger a panic, and as all CPUs
+	 * cannot take a regular IPI, we'll only be able to stop secondaries if
+	 * smp_send_stop() or crash_smp_send_stop() uses an NMI.
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
+	stop_machine(panic_stop_irqoff_fn, &v, cpu_online_mask);
+}
+
 static void lkdtm_BUG(void)
 {
 	BUG();
@@ -638,6 +665,7 @@ static noinline void lkdtm_CORRUPT_PAC(void)
 
 static struct crashtype crashtypes[] = {
 	CRASHTYPE(PANIC),
+	CRASHTYPE(PANIC_STOP_IRQOFF),
 	CRASHTYPE(BUG),
 	CRASHTYPE(WARNING),
 	CRASHTYPE(WARNING_MESSAGE),
-- 
2.30.2

