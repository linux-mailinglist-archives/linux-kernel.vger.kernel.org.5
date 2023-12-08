Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207B880AA87
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574582AbjLHRSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjLHRSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:18:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB0310F8;
        Fri,  8 Dec 2023 09:17:29 -0800 (PST)
Date:   Fri, 08 Dec 2023 17:17:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702055847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MUwAfDDP+Ir0VGafvxpXC052xsv9qGSEoyS2RCUsCjk=;
        b=Oh9OlzmBO0cvqRdZygtIwHgSZCaY/0dY7hZIIfDG3XFJHWq73KwSJMKJSKKYMaMQQPqhxK
        yaiMaoiJYfCvCWXGjW3E6x5klQh4+MPgJLGkEvrgBZ9T+kVPwR860dY3KROxXYyeeGwmx+
        frhJC3iK8lLdsjySewIR9qN2JaTfaevTQazh7lIQv+IFEWMDEIyerTPf+NOPQvO//aIzZ0
        LVjiZUlRIhzlE4BH/MUKUIVDkSZiQzSYvXlyeWXn1lItNmNVJQlFSJf6Zn1GiXdbsDLnnj
        2a7ysKnm71eT9JHFEFo3elTaTh7OSJnxfZzMBmYpfMg8jGDRxKPScSIQQ3RmBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702055847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MUwAfDDP+Ir0VGafvxpXC052xsv9qGSEoyS2RCUsCjk=;
        b=kPyPQhYfOq1LGFtq5riZ6EuJFfDbMLyXXx8idEYXUWfilVc4sDI2LsQIq3TPLijpttmOxA
        9pVBRL45jfpOlRDA==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Add skeleton to enable TDX on demand
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205584700.398.5220953085614493966.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     6162b310bc219d18bac970dbd441d7743097d1b9
Gitweb:        https://git.kernel.org/tip/6162b310bc219d18bac970dbd441d7743097d1b9
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:26 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 09:12:10 -08:00

x86/virt/tdx: Add skeleton to enable TDX on demand

There are essentially two steps to get the TDX module ready:
1) Get each CPU ready to run TDX
2) Set up the shared TDX module data structures

Introduce and export (to KVM) the infrastructure to do both of these
pieces at runtime.

== Per-CPU TDX Initialization ==

Track the initialization status of each CPU with a per-cpu variable.
This avoids failures in the case of KVM module reloads and handles cases
where CPUs come online later.

Generally, the per-cpu SEAMCALLs happen first.  But there's actually one
global call that has to happen before _any_ others (TDH_SYS_INIT).  It's
analogous to the boot CPU having to do a bit of extra work just because
it happens to be the first one.  Track if _any_ CPU has done this call
and then only actually do it during the first per-cpu init.

== Shared TDX Initialization ==

Create the global state function (tdx_enable()) as a simple placeholder.
The TODO list will be pared down as functionality is added.

Use a state machine protected by mutex to make sure the work in
tdx_enable() will only be done once.  This avoids failures if the KVM
module is reloaded.

A CPU must be made ready to run TDX before it can participate in
initializing the shared parts of the module.  Any caller of tdx_enable()
need to ensure that it can never run on a CPU which is not ready to
run TDX.  It needs to be wary of CPU hotplug, preemption and the
VMX enabling state of any CPU on which it might run.

== Why runtime instead of boot time? ==

The TDX module can be initialized only once in its lifetime.  Instead
of always initializing it at boot time, this implementation chooses an
"on demand" approach to initialize TDX until there is a real need (e.g
when requested by KVM).  This approach has below pros:

1) It avoids consuming the memory that must be allocated by kernel and
given to the TDX module as metadata (~1/256th of the TDX-usable memory),
and also saves the CPU cycles of initializing the TDX module (and the
metadata) when TDX is not used at all.

2) The TDX module design allows it to be updated while the system is
running.  The update procedure shares quite a few steps with this "on
demand" initialization mechanism.  The hope is that much of "on demand"
mechanism can be shared with a future "update" mechanism.  A boot-time
TDX module implementation would not be able to share much code with the
update mechanism.

3) Making SEAMCALL requires VMX to be enabled.  Currently, only the KVM
code mucks with VMX enabling.  If the TDX module were to be initialized
separately from KVM (like at boot), the boot code would need to be
taught how to muck with VMX enabling and KVM would need to be taught how
to cope with that.  Making KVM itself responsible for TDX initialization
lets the rest of the kernel stay blissfully unaware of VMX.

[ dhansen: completely reorder/rewrite changelog ]

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-6-dave.hansen%40intel.com
---
 arch/x86/include/asm/tdx.h  |   4 +-
 arch/x86/virt/vmx/tdx/tdx.c | 167 +++++++++++++++++++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h |  30 ++++++-
 3 files changed, 201 insertions(+)
 create mode 100644 arch/x86/virt/vmx/tdx/tdx.h

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 2c0f416..c54948e 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -111,8 +111,12 @@ static inline u64 sc_retry(sc_func_t func, u64 fn,
 #define seamcall(_fn, _args)		sc_retry(__seamcall, (_fn), (_args))
 #define seamcall_ret(_fn, _args)	sc_retry(__seamcall_ret, (_fn), (_args))
 #define seamcall_saved_ret(_fn, _args)	sc_retry(__seamcall_saved_ret, (_fn), (_args))
+int tdx_cpu_enable(void);
+int tdx_enable(void);
 #else
 static inline void tdx_init(void) { }
+static inline int tdx_cpu_enable(void) { return -ENODEV; }
+static inline int tdx_enable(void)  { return -ENODEV; }
 #endif	/* CONFIG_INTEL_TDX_HOST */
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 262b9b6..ecb0df8 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -12,15 +12,25 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/printk.h>
+#include <linux/cpu.h>
+#include <linux/spinlock.h>
+#include <linux/percpu-defs.h>
+#include <linux/mutex.h>
 #include <asm/msr-index.h>
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
 #include <asm/tdx.h>
+#include "tdx.h"
 
 static u32 tdx_global_keyid __ro_after_init;
 static u32 tdx_guest_keyid_start __ro_after_init;
 static u32 tdx_nr_guest_keyids __ro_after_init;
 
+static DEFINE_PER_CPU(bool, tdx_lp_initialized);
+
+static enum tdx_module_status_t tdx_module_status;
+static DEFINE_MUTEX(tdx_module_lock);
+
 typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
 
 static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
@@ -65,6 +75,163 @@ static inline int sc_retry_prerr(sc_func_t func, sc_err_func_t err_func,
 #define seamcall_prerr_ret(__fn, __args)					\
 	sc_retry_prerr(__seamcall_ret, seamcall_err_ret, (__fn), (__args))
 
+/*
+ * Do the module global initialization once and return its result.
+ * It can be done on any cpu.  It's always called with interrupts
+ * disabled.
+ */
+static int try_init_module_global(void)
+{
+	struct tdx_module_args args = {};
+	static DEFINE_RAW_SPINLOCK(sysinit_lock);
+	static bool sysinit_done;
+	static int sysinit_ret;
+
+	lockdep_assert_irqs_disabled();
+
+	raw_spin_lock(&sysinit_lock);
+
+	if (sysinit_done)
+		goto out;
+
+	/* RCX is module attributes and all bits are reserved */
+	args.rcx = 0;
+	sysinit_ret = seamcall_prerr(TDH_SYS_INIT, &args);
+
+	/*
+	 * The first SEAMCALL also detects the TDX module, thus
+	 * it can fail due to the TDX module is not loaded.
+	 * Dump message to let the user know.
+	 */
+	if (sysinit_ret == -ENODEV)
+		pr_err("module not loaded\n");
+
+	sysinit_done = true;
+out:
+	raw_spin_unlock(&sysinit_lock);
+	return sysinit_ret;
+}
+
+/**
+ * tdx_cpu_enable - Enable TDX on local cpu
+ *
+ * Do one-time TDX module per-cpu initialization SEAMCALL (and TDX module
+ * global initialization SEAMCALL if not done) on local cpu to make this
+ * cpu be ready to run any other SEAMCALLs.
+ *
+ * Always call this function via IPI function calls.
+ *
+ * Return 0 on success, otherwise errors.
+ */
+int tdx_cpu_enable(void)
+{
+	struct tdx_module_args args = {};
+	int ret;
+
+	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
+		return -ENODEV;
+
+	lockdep_assert_irqs_disabled();
+
+	if (__this_cpu_read(tdx_lp_initialized))
+		return 0;
+
+	/*
+	 * The TDX module global initialization is the very first step
+	 * to enable TDX.  Need to do it first (if hasn't been done)
+	 * before the per-cpu initialization.
+	 */
+	ret = try_init_module_global();
+	if (ret)
+		return ret;
+
+	ret = seamcall_prerr(TDH_SYS_LP_INIT, &args);
+	if (ret)
+		return ret;
+
+	__this_cpu_write(tdx_lp_initialized, true);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_cpu_enable);
+
+static int init_tdx_module(void)
+{
+	/*
+	 * TODO:
+	 *
+	 *  - Build the list of TDX-usable memory regions.
+	 *  - Get TDX module "TD Memory Region" (TDMR) global metadata.
+	 *  - Construct a list of TDMRs to cover all TDX-usable memory
+	 *    regions.
+	 *  - Configure the TDMRs and the global KeyID to the TDX module.
+	 *  - Configure the global KeyID on all packages.
+	 *  - Initialize all TDMRs.
+	 *
+	 *  Return error before all steps are done.
+	 */
+	return -EINVAL;
+}
+
+static int __tdx_enable(void)
+{
+	int ret;
+
+	ret = init_tdx_module();
+	if (ret) {
+		pr_err("module initialization failed (%d)\n", ret);
+		tdx_module_status = TDX_MODULE_ERROR;
+		return ret;
+	}
+
+	pr_info("module initialized\n");
+	tdx_module_status = TDX_MODULE_INITIALIZED;
+
+	return 0;
+}
+
+/**
+ * tdx_enable - Enable TDX module to make it ready to run TDX guests
+ *
+ * This function assumes the caller has: 1) held read lock of CPU hotplug
+ * lock to prevent any new cpu from becoming online; 2) done both VMXON
+ * and tdx_cpu_enable() on all online cpus.
+ *
+ * This function can be called in parallel by multiple callers.
+ *
+ * Return 0 if TDX is enabled successfully, otherwise error.
+ */
+int tdx_enable(void)
+{
+	int ret;
+
+	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
+		return -ENODEV;
+
+	lockdep_assert_cpus_held();
+
+	mutex_lock(&tdx_module_lock);
+
+	switch (tdx_module_status) {
+	case TDX_MODULE_UNINITIALIZED:
+		ret = __tdx_enable();
+		break;
+	case TDX_MODULE_INITIALIZED:
+		/* Already initialized, great, tell the caller. */
+		ret = 0;
+		break;
+	default:
+		/* Failed to initialize in the previous attempts */
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&tdx_module_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tdx_enable);
+
 static __init int record_keyid_partitioning(u32 *tdx_keyid_start,
 					    u32 *nr_tdx_keyids)
 {
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
new file mode 100644
index 0000000..a3c5227
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _X86_VIRT_TDX_H
+#define _X86_VIRT_TDX_H
+
+/*
+ * This file contains both macros and data structures defined by the TDX
+ * architecture and Linux defined software data structures and functions.
+ * The two should not be mixed together for better readability.  The
+ * architectural definitions come first.
+ */
+
+/*
+ * TDX module SEAMCALL leaf functions
+ */
+#define TDH_SYS_INIT		33
+#define TDH_SYS_LP_INIT		35
+
+/*
+ * Do not put any hardware-defined TDX structure representations below
+ * this comment!
+ */
+
+/* Kernel defined TDX module status during module initialization. */
+enum tdx_module_status_t {
+	TDX_MODULE_UNINITIALIZED,
+	TDX_MODULE_INITIALIZED,
+	TDX_MODULE_ERROR
+};
+
+#endif
