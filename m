Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300D17D03A6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346599AbjJSVVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346591AbjJSVVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:21:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE2C116;
        Thu, 19 Oct 2023 14:20:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16ECC433C9;
        Thu, 19 Oct 2023 21:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697750456;
        bh=bLsoj1QHXlAuFEsNiR833zXxS4znX+ivgkjA/D35zw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OogAVoRVZP5Ha4u2x4fBDSCqCZ0Xkk3VH9QjkYO62Ozd9qtHWwrQzDzZKcJbEvgQf
         jAtiHv3GGv1OzVUhLQAVAHAGmbEpgY8dMnByH47SpJmztujVMi+TeCW76DBeMO0d+e
         se0yur7ktsv+uSHYhxSHVUdh5zlMT43t/0T7vfRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.136
Date:   Thu, 19 Oct 2023 23:20:44 +0200
Message-ID: <2023101944-finalize-reflux-af0a@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023101944-maritime-crabbing-429f@gregkh>
References: <2023101944-maritime-crabbing-429f@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2cd4d66ab64c..34b093e7f891 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5920,6 +5920,16 @@
 			first trust source as a backend which is initialized
 			successfully during iteration.
 
+	trusted.rng=	[KEYS]
+			Format: <string>
+			The RNG used to generate key material for trusted keys.
+			Can be one of:
+			- "kernel"
+			- the same value as trusted.source: "tpm" or "tee"
+			- "default"
+			If not specified, "default" is used. In this case,
+			the RNG's choice is left to each individual trust source.
+
 	tsc=		Disable clocksource stability checks for TSC.
 			Format: <string>
 			[x86] reliable: mark tsc clocksource as reliable, this
diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 7890b395e629..7f75767a24f1 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2070,6 +2070,14 @@ accept_ra_min_hop_limit - INTEGER
 
 	Default: 1
 
+accept_ra_min_lft - INTEGER
+	Minimum acceptable lifetime value in Router Advertisement.
+
+	RA sections with a lifetime less than this value shall be
+	ignored. Zero lifetimes stay unaffected.
+
+	Default: 0
+
 accept_ra_pinfo - BOOLEAN
 	Learn Prefix Information in Router Advertisement.
 
diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 80d5a5af62a1..99cf34d7c025 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -87,22 +87,26 @@ Key Generation
 Trusted Keys
 ------------
 
-New keys are created from random numbers generated in the trust source. They
-are encrypted/decrypted using a child key in the storage key hierarchy.
-Encryption and decryption of the child key must be protected by a strong
-access control policy within the trust source.
+New keys are created from random numbers. They are encrypted/decrypted using
+a child key in the storage key hierarchy. Encryption and decryption of the
+child key must be protected by a strong access control policy within the
+trust source. The random number generator in use differs according to the
+selected trust source:
 
-  *  TPM (hardware device) based RNG
+  *  TPM: hardware device based RNG
 
-     Strength of random numbers may vary from one device manufacturer to
-     another.
+     Keys are generated within the TPM. Strength of random numbers may vary
+     from one device manufacturer to another.
 
-  *  TEE (OP-TEE based on Arm TrustZone) based RNG
+  *  TEE: OP-TEE based on Arm TrustZone based RNG
 
      RNG is customizable as per platform needs. It can either be direct output
      from platform specific hardware RNG or a software based Fortuna CSPRNG
      which can be seeded via multiple entropy sources.
 
+Users may override this by specifying ``trusted.rng=kernel`` on the kernel
+command-line to override the used RNG with the kernel's random number pool.
+
 Encrypted Keys
 --------------
 
diff --git a/Makefile b/Makefile
index 831bb0749ef6..703a9bd4e714 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 135
+SUBLEVEL = 136
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 135f4b0bf396..5df2188f8839 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -808,7 +808,8 @@ static inline bool system_supports_tlb_range(void)
 		cpus_have_const_cap(ARM64_HAS_TLB_RANGE);
 }
 
-extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
+int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
+bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
 
 static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
 {
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 0e6535aa78c2..515ebe24fd44 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -58,20 +58,23 @@ asmlinkage void call_on_irq_stack(struct pt_regs *regs,
 asmlinkage void asm_exit_to_user_mode(struct pt_regs *regs);
 
 void do_mem_abort(unsigned long far, unsigned long esr, struct pt_regs *regs);
-void do_undefinstr(struct pt_regs *regs);
-void do_bti(struct pt_regs *regs);
+void do_el0_undef(struct pt_regs *regs, unsigned long esr);
+void do_el1_undef(struct pt_regs *regs, unsigned long esr);
+void do_el0_bti(struct pt_regs *regs);
+void do_el1_bti(struct pt_regs *regs, unsigned long esr);
 void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
 			struct pt_regs *regs);
 void do_fpsimd_acc(unsigned long esr, struct pt_regs *regs);
 void do_sve_acc(unsigned long esr, struct pt_regs *regs);
 void do_fpsimd_exc(unsigned long esr, struct pt_regs *regs);
-void do_sysinstr(unsigned long esr, struct pt_regs *regs);
+void do_el0_sys(unsigned long esr, struct pt_regs *regs);
 void do_sp_pc_abort(unsigned long addr, unsigned long esr, struct pt_regs *regs);
 void bad_el0_sync(struct pt_regs *regs, int reason, unsigned long esr);
-void do_cp15instr(unsigned long esr, struct pt_regs *regs);
+void do_el0_cp15(unsigned long esr, struct pt_regs *regs);
 void do_el0_svc(struct pt_regs *regs);
 void do_el0_svc_compat(struct pt_regs *regs);
-void do_ptrauth_fault(struct pt_regs *regs, unsigned long esr);
+void do_el0_fpac(struct pt_regs *regs, unsigned long esr);
+void do_el1_fpac(struct pt_regs *regs, unsigned long esr);
 void do_serror(struct pt_regs *regs, unsigned long esr);
 void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags);
 
diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index aa3d3607d5c8..db7b371b367c 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -26,6 +26,7 @@ enum mitigation_state {
 	SPECTRE_VULNERABLE,
 };
 
+struct pt_regs;
 struct task_struct;
 
 /*
@@ -98,5 +99,6 @@ enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
 u8 spectre_bhb_loop_affected(int scope);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
+bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr);
 #endif	/* __ASSEMBLY__ */
 #endif	/* __ASM_SPECTRE_H */
diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 0eb7709422e2..c34344256762 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -18,7 +18,7 @@
 
 struct pt_regs;
 
-void die(const char *msg, struct pt_regs *regs, int err);
+void die(const char *msg, struct pt_regs *regs, long err);
 
 struct siginfo;
 void arm64_notify_die(const char *str, struct pt_regs *regs,
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 6e5826470bea..1f361e2da516 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -13,17 +13,16 @@
 
 struct pt_regs;
 
-struct undef_hook {
-	struct list_head node;
-	u32 instr_mask;
-	u32 instr_val;
-	u64 pstate_mask;
-	u64 pstate_val;
-	int (*fn)(struct pt_regs *regs, u32 instr);
-};
+#ifdef CONFIG_ARMV8_DEPRECATED
+bool try_emulate_armv8_deprecated(struct pt_regs *regs, u32 insn);
+#else
+static inline bool
+try_emulate_armv8_deprecated(struct pt_regs *regs, u32 insn)
+{
+	return false;
+}
+#endif /* CONFIG_ARMV8_DEPRECATED */
 
-void register_undef_hook(struct undef_hook *hook);
-void unregister_undef_hook(struct undef_hook *hook);
 void force_signal_inject(int signal, int code, unsigned long address, unsigned long err);
 void arm64_notify_segfault(unsigned long addr);
 void arm64_force_sig_fault(int signo, int code, unsigned long far, const char *str);
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index c5da9d1e954a..91eabe56093d 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -17,7 +17,6 @@
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
 #include <asm/traps.h>
-#include <asm/kprobes.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace-events-emulation.h"
@@ -39,226 +38,46 @@ enum insn_emulation_mode {
 enum legacy_insn_status {
 	INSN_DEPRECATED,
 	INSN_OBSOLETE,
-};
-
-struct insn_emulation_ops {
-	const char		*name;
-	enum legacy_insn_status	status;
-	struct undef_hook	*hooks;
-	int			(*set_hw_mode)(bool enable);
+	INSN_UNAVAILABLE,
 };
 
 struct insn_emulation {
-	struct list_head node;
-	struct insn_emulation_ops *ops;
+	const char			*name;
+	enum legacy_insn_status		status;
+	bool				(*try_emulate)(struct pt_regs *regs,
+						       u32 insn);
+	int				(*set_hw_mode)(bool enable);
+
 	int current_mode;
 	int min;
 	int max;
-};
-
-static LIST_HEAD(insn_emulation);
-static int nr_insn_emulated __initdata;
-static DEFINE_RAW_SPINLOCK(insn_emulation_lock);
-static DEFINE_MUTEX(insn_emulation_mutex);
-
-static void register_emulation_hooks(struct insn_emulation_ops *ops)
-{
-	struct undef_hook *hook;
-
-	BUG_ON(!ops->hooks);
-
-	for (hook = ops->hooks; hook->instr_mask; hook++)
-		register_undef_hook(hook);
-
-	pr_notice("Registered %s emulation handler\n", ops->name);
-}
-
-static void remove_emulation_hooks(struct insn_emulation_ops *ops)
-{
-	struct undef_hook *hook;
-
-	BUG_ON(!ops->hooks);
-
-	for (hook = ops->hooks; hook->instr_mask; hook++)
-		unregister_undef_hook(hook);
-
-	pr_notice("Removed %s emulation handler\n", ops->name);
-}
-
-static void enable_insn_hw_mode(void *data)
-{
-	struct insn_emulation *insn = (struct insn_emulation *)data;
-	if (insn->ops->set_hw_mode)
-		insn->ops->set_hw_mode(true);
-}
-
-static void disable_insn_hw_mode(void *data)
-{
-	struct insn_emulation *insn = (struct insn_emulation *)data;
-	if (insn->ops->set_hw_mode)
-		insn->ops->set_hw_mode(false);
-}
-
-/* Run set_hw_mode(mode) on all active CPUs */
-static int run_all_cpu_set_hw_mode(struct insn_emulation *insn, bool enable)
-{
-	if (!insn->ops->set_hw_mode)
-		return -EINVAL;
-	if (enable)
-		on_each_cpu(enable_insn_hw_mode, (void *)insn, true);
-	else
-		on_each_cpu(disable_insn_hw_mode, (void *)insn, true);
-	return 0;
-}
-
-/*
- * Run set_hw_mode for all insns on a starting CPU.
- * Returns:
- *  0 		- If all the hooks ran successfully.
- * -EINVAL	- At least one hook is not supported by the CPU.
- */
-static int run_all_insn_set_hw_mode(unsigned int cpu)
-{
-	int rc = 0;
-	unsigned long flags;
-	struct insn_emulation *insn;
-
-	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
-	list_for_each_entry(insn, &insn_emulation, node) {
-		bool enable = (insn->current_mode == INSN_HW);
-		if (insn->ops->set_hw_mode && insn->ops->set_hw_mode(enable)) {
-			pr_warn("CPU[%u] cannot support the emulation of %s",
-				cpu, insn->ops->name);
-			rc = -EINVAL;
-		}
-	}
-	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
-	return rc;
-}
-
-static int update_insn_emulation_mode(struct insn_emulation *insn,
-				       enum insn_emulation_mode prev)
-{
-	int ret = 0;
-
-	switch (prev) {
-	case INSN_UNDEF: /* Nothing to be done */
-		break;
-	case INSN_EMULATE:
-		remove_emulation_hooks(insn->ops);
-		break;
-	case INSN_HW:
-		if (!run_all_cpu_set_hw_mode(insn, false))
-			pr_notice("Disabled %s support\n", insn->ops->name);
-		break;
-	}
-
-	switch (insn->current_mode) {
-	case INSN_UNDEF:
-		break;
-	case INSN_EMULATE:
-		register_emulation_hooks(insn->ops);
-		break;
-	case INSN_HW:
-		ret = run_all_cpu_set_hw_mode(insn, true);
-		if (!ret)
-			pr_notice("Enabled %s support\n", insn->ops->name);
-		break;
-	}
 
-	return ret;
-}
-
-static void __init register_insn_emulation(struct insn_emulation_ops *ops)
-{
-	unsigned long flags;
-	struct insn_emulation *insn;
-
-	insn = kzalloc(sizeof(*insn), GFP_KERNEL);
-	if (!insn)
-		return;
-
-	insn->ops = ops;
-	insn->min = INSN_UNDEF;
-
-	switch (ops->status) {
-	case INSN_DEPRECATED:
-		insn->current_mode = INSN_EMULATE;
-		/* Disable the HW mode if it was turned on at early boot time */
-		run_all_cpu_set_hw_mode(insn, false);
-		insn->max = INSN_HW;
-		break;
-	case INSN_OBSOLETE:
-		insn->current_mode = INSN_UNDEF;
-		insn->max = INSN_EMULATE;
-		break;
-	}
-
-	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
-	list_add(&insn->node, &insn_emulation);
-	nr_insn_emulated++;
-	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
-
-	/* Register any handlers if required */
-	update_insn_emulation_mode(insn, INSN_UNDEF);
-}
-
-static int emulation_proc_handler(struct ctl_table *table, int write,
-				  void *buffer, size_t *lenp,
-				  loff_t *ppos)
-{
-	int ret = 0;
-	struct insn_emulation *insn = container_of(table->data, struct insn_emulation, current_mode);
-	enum insn_emulation_mode prev_mode = insn->current_mode;
-
-	mutex_lock(&insn_emulation_mutex);
-	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	/*
+	 * sysctl for this emulation + a sentinal entry.
+	 */
+	struct ctl_table sysctl[2];
+};
 
-	if (ret || !write || prev_mode == insn->current_mode)
-		goto ret;
+#define ARM_OPCODE_CONDTEST_FAIL   0
+#define ARM_OPCODE_CONDTEST_PASS   1
+#define ARM_OPCODE_CONDTEST_UNCOND 2
 
-	ret = update_insn_emulation_mode(insn, prev_mode);
-	if (ret) {
-		/* Mode change failed, revert to previous mode. */
-		insn->current_mode = prev_mode;
-		update_insn_emulation_mode(insn, INSN_UNDEF);
-	}
-ret:
-	mutex_unlock(&insn_emulation_mutex);
-	return ret;
-}
+#define	ARM_OPCODE_CONDITION_UNCOND	0xf
 
-static void __init register_insn_emulation_sysctl(void)
+static unsigned int __maybe_unused aarch32_check_condition(u32 opcode, u32 psr)
 {
-	unsigned long flags;
-	int i = 0;
-	struct insn_emulation *insn;
-	struct ctl_table *insns_sysctl, *sysctl;
-
-	insns_sysctl = kcalloc(nr_insn_emulated + 1, sizeof(*sysctl),
-			       GFP_KERNEL);
-	if (!insns_sysctl)
-		return;
-
-	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
-	list_for_each_entry(insn, &insn_emulation, node) {
-		sysctl = &insns_sysctl[i];
-
-		sysctl->mode = 0644;
-		sysctl->maxlen = sizeof(int);
+	u32 cc_bits  = opcode >> 28;
 
-		sysctl->procname = insn->ops->name;
-		sysctl->data = &insn->current_mode;
-		sysctl->extra1 = &insn->min;
-		sysctl->extra2 = &insn->max;
-		sysctl->proc_handler = emulation_proc_handler;
-		i++;
+	if (cc_bits != ARM_OPCODE_CONDITION_UNCOND) {
+		if ((*aarch32_opcode_cond_checks[cc_bits])(psr))
+			return ARM_OPCODE_CONDTEST_PASS;
+		else
+			return ARM_OPCODE_CONDTEST_FAIL;
 	}
-	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
-
-	register_sysctl("abi", insns_sysctl);
+	return ARM_OPCODE_CONDTEST_UNCOND;
 }
 
+#ifdef CONFIG_SWP_EMULATION
 /*
  *  Implement emulation of the SWP/SWPB instructions using load-exclusive and
  *  store-exclusive.
@@ -345,25 +164,6 @@ static int emulate_swpX(unsigned int address, unsigned int *data,
 	return res;
 }
 
-#define ARM_OPCODE_CONDTEST_FAIL   0
-#define ARM_OPCODE_CONDTEST_PASS   1
-#define ARM_OPCODE_CONDTEST_UNCOND 2
-
-#define	ARM_OPCODE_CONDITION_UNCOND	0xf
-
-static unsigned int __kprobes aarch32_check_condition(u32 opcode, u32 psr)
-{
-	u32 cc_bits  = opcode >> 28;
-
-	if (cc_bits != ARM_OPCODE_CONDITION_UNCOND) {
-		if ((*aarch32_opcode_cond_checks[cc_bits])(psr))
-			return ARM_OPCODE_CONDTEST_PASS;
-		else
-			return ARM_OPCODE_CONDTEST_FAIL;
-	}
-	return ARM_OPCODE_CONDTEST_UNCOND;
-}
-
 /*
  * swp_handler logs the id of calling process, dissects the instruction, sanity
  * checks the memory location, calls emulate_swpX for the actual operation and
@@ -436,28 +236,27 @@ static int swp_handler(struct pt_regs *regs, u32 instr)
 	return 0;
 }
 
-/*
- * Only emulate SWP/SWPB executed in ARM state/User mode.
- * The kernel must be SWP free and SWP{B} does not exist in Thumb.
- */
-static struct undef_hook swp_hooks[] = {
-	{
-		.instr_mask	= 0x0fb00ff0,
-		.instr_val	= 0x01000090,
-		.pstate_mask	= PSR_AA32_MODE_MASK,
-		.pstate_val	= PSR_AA32_MODE_USR,
-		.fn		= swp_handler
-	},
-	{ }
-};
+static bool try_emulate_swp(struct pt_regs *regs, u32 insn)
+{
+	/* SWP{B} only exists in ARM state and does not exist in Thumb */
+	if (!compat_user_mode(regs) || compat_thumb_mode(regs))
+		return false;
+
+	if ((insn & 0x0fb00ff0) != 0x01000090)
+		return false;
+
+	return swp_handler(regs, insn) == 0;
+}
 
-static struct insn_emulation_ops swp_ops = {
+static struct insn_emulation insn_swp = {
 	.name = "swp",
 	.status = INSN_OBSOLETE,
-	.hooks = swp_hooks,
+	.try_emulate = try_emulate_swp,
 	.set_hw_mode = NULL,
 };
+#endif /* CONFIG_SWP_EMULATION */
 
+#ifdef CONFIG_CP15_BARRIER_EMULATION
 static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
 {
 	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->pc);
@@ -520,31 +319,29 @@ static int cp15_barrier_set_hw_mode(bool enable)
 	return 0;
 }
 
-static struct undef_hook cp15_barrier_hooks[] = {
-	{
-		.instr_mask	= 0x0fff0fdf,
-		.instr_val	= 0x0e070f9a,
-		.pstate_mask	= PSR_AA32_MODE_MASK,
-		.pstate_val	= PSR_AA32_MODE_USR,
-		.fn		= cp15barrier_handler,
-	},
-	{
-		.instr_mask	= 0x0fff0fff,
-		.instr_val	= 0x0e070f95,
-		.pstate_mask	= PSR_AA32_MODE_MASK,
-		.pstate_val	= PSR_AA32_MODE_USR,
-		.fn		= cp15barrier_handler,
-	},
-	{ }
-};
+static bool try_emulate_cp15_barrier(struct pt_regs *regs, u32 insn)
+{
+	if (!compat_user_mode(regs) || compat_thumb_mode(regs))
+		return false;
+
+	if ((insn & 0x0fff0fdf) == 0x0e070f9a)
+		return cp15barrier_handler(regs, insn) == 0;
+
+	if ((insn & 0x0fff0fff) == 0x0e070f95)
+		return cp15barrier_handler(regs, insn) == 0;
+
+	return false;
+}
 
-static struct insn_emulation_ops cp15_barrier_ops = {
+static struct insn_emulation insn_cp15_barrier = {
 	.name = "cp15_barrier",
 	.status = INSN_DEPRECATED,
-	.hooks = cp15_barrier_hooks,
+	.try_emulate = try_emulate_cp15_barrier,
 	.set_hw_mode = cp15_barrier_set_hw_mode,
 };
+#endif /* CONFIG_CP15_BARRIER_EMULATION */
 
+#ifdef CONFIG_SETEND_EMULATION
 static int setend_set_hw_mode(bool enable)
 {
 	if (!cpu_supports_mixed_endian_el0())
@@ -592,31 +389,221 @@ static int t16_setend_handler(struct pt_regs *regs, u32 instr)
 	return rc;
 }
 
-static struct undef_hook setend_hooks[] = {
-	{
-		.instr_mask	= 0xfffffdff,
-		.instr_val	= 0xf1010000,
-		.pstate_mask	= PSR_AA32_MODE_MASK,
-		.pstate_val	= PSR_AA32_MODE_USR,
-		.fn		= a32_setend_handler,
-	},
-	{
-		/* Thumb mode */
-		.instr_mask	= 0xfffffff7,
-		.instr_val	= 0x0000b650,
-		.pstate_mask	= (PSR_AA32_T_BIT | PSR_AA32_MODE_MASK),
-		.pstate_val	= (PSR_AA32_T_BIT | PSR_AA32_MODE_USR),
-		.fn		= t16_setend_handler,
-	},
-	{}
-};
+static bool try_emulate_setend(struct pt_regs *regs, u32 insn)
+{
+	if (compat_thumb_mode(regs) &&
+	    (insn & 0xfffffff7) == 0x0000b650)
+		return t16_setend_handler(regs, insn) == 0;
+
+	if (compat_user_mode(regs) &&
+	    (insn & 0xfffffdff) == 0xf1010000)
+		return a32_setend_handler(regs, insn) == 0;
+
+	return false;
+}
 
-static struct insn_emulation_ops setend_ops = {
+static struct insn_emulation insn_setend = {
 	.name = "setend",
 	.status = INSN_DEPRECATED,
-	.hooks = setend_hooks,
+	.try_emulate = try_emulate_setend,
 	.set_hw_mode = setend_set_hw_mode,
 };
+#endif /* CONFIG_SETEND_EMULATION */
+
+static struct insn_emulation *insn_emulations[] = {
+#ifdef CONFIG_SWP_EMULATION
+	&insn_swp,
+#endif
+#ifdef CONFIG_CP15_BARRIER_EMULATION
+	&insn_cp15_barrier,
+#endif
+#ifdef CONFIG_SETEND_EMULATION
+	&insn_setend,
+#endif
+};
+
+static DEFINE_MUTEX(insn_emulation_mutex);
+
+static void enable_insn_hw_mode(void *data)
+{
+	struct insn_emulation *insn = (struct insn_emulation *)data;
+	if (insn->set_hw_mode)
+		insn->set_hw_mode(true);
+}
+
+static void disable_insn_hw_mode(void *data)
+{
+	struct insn_emulation *insn = (struct insn_emulation *)data;
+	if (insn->set_hw_mode)
+		insn->set_hw_mode(false);
+}
+
+/* Run set_hw_mode(mode) on all active CPUs */
+static int run_all_cpu_set_hw_mode(struct insn_emulation *insn, bool enable)
+{
+	if (!insn->set_hw_mode)
+		return -EINVAL;
+	if (enable)
+		on_each_cpu(enable_insn_hw_mode, (void *)insn, true);
+	else
+		on_each_cpu(disable_insn_hw_mode, (void *)insn, true);
+	return 0;
+}
+
+/*
+ * Run set_hw_mode for all insns on a starting CPU.
+ * Returns:
+ *  0 		- If all the hooks ran successfully.
+ * -EINVAL	- At least one hook is not supported by the CPU.
+ */
+static int run_all_insn_set_hw_mode(unsigned int cpu)
+{
+	int i;
+	int rc = 0;
+	unsigned long flags;
+
+	/*
+	 * Disable IRQs to serialize against an IPI from
+	 * run_all_cpu_set_hw_mode(), ensuring the HW is programmed to the most
+	 * recent enablement state if the two race with one another.
+	 */
+	local_irq_save(flags);
+	for (i = 0; i < ARRAY_SIZE(insn_emulations); i++) {
+		struct insn_emulation *insn = insn_emulations[i];
+		bool enable = READ_ONCE(insn->current_mode) == INSN_HW;
+		if (insn->set_hw_mode && insn->set_hw_mode(enable)) {
+			pr_warn("CPU[%u] cannot support the emulation of %s",
+				cpu, insn->name);
+			rc = -EINVAL;
+		}
+	}
+	local_irq_restore(flags);
+
+	return rc;
+}
+
+static int update_insn_emulation_mode(struct insn_emulation *insn,
+				       enum insn_emulation_mode prev)
+{
+	int ret = 0;
+
+	switch (prev) {
+	case INSN_UNDEF: /* Nothing to be done */
+		break;
+	case INSN_EMULATE:
+		break;
+	case INSN_HW:
+		if (!run_all_cpu_set_hw_mode(insn, false))
+			pr_notice("Disabled %s support\n", insn->name);
+		break;
+	}
+
+	switch (insn->current_mode) {
+	case INSN_UNDEF:
+		break;
+	case INSN_EMULATE:
+		break;
+	case INSN_HW:
+		ret = run_all_cpu_set_hw_mode(insn, true);
+		if (!ret)
+			pr_notice("Enabled %s support\n", insn->name);
+		break;
+	}
+
+	return ret;
+}
+
+static int emulation_proc_handler(struct ctl_table *table, int write,
+				  void *buffer, size_t *lenp,
+				  loff_t *ppos)
+{
+	int ret = 0;
+	struct insn_emulation *insn = container_of(table->data, struct insn_emulation, current_mode);
+	enum insn_emulation_mode prev_mode = insn->current_mode;
+
+	mutex_lock(&insn_emulation_mutex);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (ret || !write || prev_mode == insn->current_mode)
+		goto ret;
+
+	ret = update_insn_emulation_mode(insn, prev_mode);
+	if (ret) {
+		/* Mode change failed, revert to previous mode. */
+		WRITE_ONCE(insn->current_mode, prev_mode);
+		update_insn_emulation_mode(insn, INSN_UNDEF);
+	}
+ret:
+	mutex_unlock(&insn_emulation_mutex);
+	return ret;
+}
+
+static void __init register_insn_emulation(struct insn_emulation *insn)
+{
+	struct ctl_table *sysctl;
+
+	insn->min = INSN_UNDEF;
+
+	switch (insn->status) {
+	case INSN_DEPRECATED:
+		insn->current_mode = INSN_EMULATE;
+		/* Disable the HW mode if it was turned on at early boot time */
+		run_all_cpu_set_hw_mode(insn, false);
+		insn->max = INSN_HW;
+		break;
+	case INSN_OBSOLETE:
+		insn->current_mode = INSN_UNDEF;
+		insn->max = INSN_EMULATE;
+		break;
+	case INSN_UNAVAILABLE:
+		insn->current_mode = INSN_UNDEF;
+		insn->max = INSN_UNDEF;
+		break;
+	}
+
+	/* Program the HW if required */
+	update_insn_emulation_mode(insn, INSN_UNDEF);
+
+	if (insn->status != INSN_UNAVAILABLE) {
+		sysctl = &insn->sysctl[0];
+
+		sysctl->mode = 0644;
+		sysctl->maxlen = sizeof(int);
+
+		sysctl->procname = insn->name;
+		sysctl->data = &insn->current_mode;
+		sysctl->extra1 = &insn->min;
+		sysctl->extra2 = &insn->max;
+		sysctl->proc_handler = emulation_proc_handler;
+
+		register_sysctl("abi", sysctl);
+	}
+}
+
+bool try_emulate_armv8_deprecated(struct pt_regs *regs, u32 insn)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(insn_emulations); i++) {
+		struct insn_emulation *ie = insn_emulations[i];
+
+		if (ie->status == INSN_UNAVAILABLE)
+			continue;
+
+		/*
+		 * A trap may race with the mode being changed
+		 * INSN_EMULATE<->INSN_HW. Try to emulate the instruction to
+		 * avoid a spurious UNDEF.
+		 */
+		if (READ_ONCE(ie->current_mode) == INSN_UNDEF)
+			continue;
+
+		if (ie->try_emulate(regs, insn))
+			return true;
+	}
+
+	return false;
+}
 
 /*
  * Invoked as core_initcall, which guarantees that the instruction
@@ -624,24 +611,27 @@ static struct insn_emulation_ops setend_ops = {
  */
 static int __init armv8_deprecated_init(void)
 {
-	if (IS_ENABLED(CONFIG_SWP_EMULATION))
-		register_insn_emulation(&swp_ops);
+	int i;
 
-	if (IS_ENABLED(CONFIG_CP15_BARRIER_EMULATION))
-		register_insn_emulation(&cp15_barrier_ops);
+#ifdef CONFIG_SETEND_EMULATION
+	if (!system_supports_mixed_endian_el0()) {
+		insn_setend.status = INSN_UNAVAILABLE;
+		pr_info("setend instruction emulation is not supported on this system\n");
+	}
 
-	if (IS_ENABLED(CONFIG_SETEND_EMULATION)) {
-		if (system_supports_mixed_endian_el0())
-			register_insn_emulation(&setend_ops);
-		else
-			pr_info("setend instruction emulation is not supported on this system\n");
+#endif
+	for (i = 0; i < ARRAY_SIZE(insn_emulations); i++) {
+		struct insn_emulation *ie = insn_emulations[i];
+
+		if (ie->status == INSN_UNAVAILABLE)
+			continue;
+
+		register_insn_emulation(ie);
 	}
 
 	cpuhp_setup_state_nocalls(CPUHP_AP_ARM64_ISNDEP_STARTING,
 				  "arm64/isndep:starting",
 				  run_all_insn_set_hw_mode, NULL);
-	register_insn_emulation_sysctl();
-
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d4ee345ff429..f17d6cdea260 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3106,35 +3106,22 @@ int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt)
 	return rc;
 }
 
-static int emulate_mrs(struct pt_regs *regs, u32 insn)
+bool try_emulate_mrs(struct pt_regs *regs, u32 insn)
 {
 	u32 sys_reg, rt;
 
+	if (compat_user_mode(regs) || !aarch64_insn_is_mrs(insn))
+		return false;
+
 	/*
 	 * sys_reg values are defined as used in mrs/msr instruction.
 	 * shift the imm value to get the encoding.
 	 */
 	sys_reg = (u32)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn) << 5;
 	rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
-	return do_emulate_mrs(regs, sys_reg, rt);
+	return do_emulate_mrs(regs, sys_reg, rt) == 0;
 }
 
-static struct undef_hook mrs_hook = {
-	.instr_mask = 0xffff0000,
-	.instr_val  = 0xd5380000,
-	.pstate_mask = PSR_AA32_MODE_MASK,
-	.pstate_val = PSR_MODE_EL0t,
-	.fn = emulate_mrs,
-};
-
-static int __init enable_mrs_emulation(void)
-{
-	register_undef_hook(&mrs_hook);
-	return 0;
-}
-
-core_initcall(enable_mrs_emulation);
-
 enum mitigation_state arm64_get_meltdown_state(void)
 {
 	if (__meltdown_safe)
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index fc91dad1579a..864423297c00 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -371,11 +371,20 @@ static void noinstr el1_pc(struct pt_regs *regs, unsigned long esr)
 	exit_to_kernel_mode(regs);
 }
 
-static void noinstr el1_undef(struct pt_regs *regs)
+static void noinstr el1_undef(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
-	do_undefinstr(regs);
+	do_el1_undef(regs, esr);
+	local_daif_mask();
+	exit_to_kernel_mode(regs);
+}
+
+static void noinstr el1_bti(struct pt_regs *regs, unsigned long esr)
+{
+	enter_from_kernel_mode(regs);
+	local_daif_inherit(regs);
+	do_el1_bti(regs, esr);
 	local_daif_mask();
 	exit_to_kernel_mode(regs);
 }
@@ -394,7 +403,7 @@ static void noinstr el1_fpac(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
-	do_ptrauth_fault(regs, esr);
+	do_el1_fpac(regs, esr);
 	local_daif_mask();
 	exit_to_kernel_mode(regs);
 }
@@ -417,7 +426,10 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
 		break;
 	case ESR_ELx_EC_SYS64:
 	case ESR_ELx_EC_UNKNOWN:
-		el1_undef(regs);
+		el1_undef(regs, esr);
+		break;
+	case ESR_ELx_EC_BTI:
+		el1_bti(regs, esr);
 		break;
 	case ESR_ELx_EC_BREAKPT_CUR:
 	case ESR_ELx_EC_SOFTSTP_CUR:
@@ -529,7 +541,7 @@ static void noinstr el0_sys(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
 	local_daif_restore(DAIF_PROCCTX);
-	do_sysinstr(esr, regs);
+	do_el0_sys(esr, regs);
 	exit_to_user_mode(regs);
 }
 
@@ -554,11 +566,11 @@ static void noinstr el0_sp(struct pt_regs *regs, unsigned long esr)
 	exit_to_user_mode(regs);
 }
 
-static void noinstr el0_undef(struct pt_regs *regs)
+static void noinstr el0_undef(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
 	local_daif_restore(DAIF_PROCCTX);
-	do_undefinstr(regs);
+	do_el0_undef(regs, esr);
 	exit_to_user_mode(regs);
 }
 
@@ -566,7 +578,7 @@ static void noinstr el0_bti(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
 	local_daif_restore(DAIF_PROCCTX);
-	do_bti(regs);
+	do_el0_bti(regs);
 	exit_to_user_mode(regs);
 }
 
@@ -601,7 +613,7 @@ static void noinstr el0_fpac(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
 	local_daif_restore(DAIF_PROCCTX);
-	do_ptrauth_fault(regs, esr);
+	do_el0_fpac(regs, esr);
 	exit_to_user_mode(regs);
 }
 
@@ -639,7 +651,7 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
 		el0_pc(regs, esr);
 		break;
 	case ESR_ELx_EC_UNKNOWN:
-		el0_undef(regs);
+		el0_undef(regs, esr);
 		break;
 	case ESR_ELx_EC_BTI:
 		el0_bti(regs);
@@ -716,7 +728,7 @@ static void noinstr el0_cp15(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
 	local_daif_restore(DAIF_PROCCTX);
-	do_cp15instr(esr, regs);
+	do_el0_cp15(esr, regs);
 	exit_to_user_mode(regs);
 }
 
@@ -755,7 +767,7 @@ asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
 	case ESR_ELx_EC_CP14_MR:
 	case ESR_ELx_EC_CP14_LS:
 	case ESR_ELx_EC_CP14_64:
-		el0_undef(regs);
+		el0_undef(regs, esr);
 		break;
 	case ESR_ELx_EC_CP15_32:
 	case ESR_ELx_EC_CP15_64:
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 428cfabd11c4..7515ed1f0669 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -521,10 +521,13 @@ bool has_spectre_v4(const struct arm64_cpu_capabilities *cap, int scope)
 	return state != SPECTRE_UNAFFECTED;
 }
 
-static int ssbs_emulation_handler(struct pt_regs *regs, u32 instr)
+bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr)
 {
-	if (user_mode(regs))
-		return 1;
+	const u32 instr_mask = ~(1U << PSTATE_Imm_shift);
+	const u32 instr_val = 0xd500401f | PSTATE_SSBS;
+
+	if ((instr & instr_mask) != instr_val)
+		return false;
 
 	if (instr & BIT(PSTATE_Imm_shift))
 		regs->pstate |= PSR_SSBS_BIT;
@@ -532,19 +535,11 @@ static int ssbs_emulation_handler(struct pt_regs *regs, u32 instr)
 		regs->pstate &= ~PSR_SSBS_BIT;
 
 	arm64_skip_faulting_instruction(regs, 4);
-	return 0;
+	return true;
 }
 
-static struct undef_hook ssbs_emulation_hook = {
-	.instr_mask	= ~(1U << PSTATE_Imm_shift),
-	.instr_val	= 0xd500401f | PSTATE_SSBS,
-	.fn		= ssbs_emulation_handler,
-};
-
 static enum mitigation_state spectre_v4_enable_hw_mitigation(void)
 {
-	static bool undef_hook_registered = false;
-	static DEFINE_RAW_SPINLOCK(hook_lock);
 	enum mitigation_state state;
 
 	/*
@@ -555,13 +550,6 @@ static enum mitigation_state spectre_v4_enable_hw_mitigation(void)
 	if (state != SPECTRE_MITIGATED || !this_cpu_has_cap(ARM64_SSBS))
 		return state;
 
-	raw_spin_lock(&hook_lock);
-	if (!undef_hook_registered) {
-		register_undef_hook(&ssbs_emulation_hook);
-		undef_hook_registered = true;
-	}
-	raw_spin_unlock(&hook_lock);
-
 	if (spectre_v4_mitigations_off()) {
 		sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_DSSBS);
 		set_pstate_ssbs(1);
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 21e69a991bc8..c71074cb2bef 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -181,12 +181,12 @@ static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
 
 #define S_SMP " SMP"
 
-static int __die(const char *str, int err, struct pt_regs *regs)
+static int __die(const char *str, long err, struct pt_regs *regs)
 {
 	static int die_counter;
 	int ret;
 
-	pr_emerg("Internal error: %s: %x [#%d]" S_PREEMPT S_SMP "\n",
+	pr_emerg("Internal error: %s: %016lx [#%d]" S_PREEMPT S_SMP "\n",
 		 str, err, ++die_counter);
 
 	/* trap and error numbers are mostly meaningless on ARM */
@@ -207,7 +207,7 @@ static DEFINE_RAW_SPINLOCK(die_lock);
 /*
  * This function is protected against re-entrancy.
  */
-void die(const char *str, struct pt_regs *regs, int err)
+void die(const char *str, struct pt_regs *regs, long err)
 {
 	int ret;
 	unsigned long flags;
@@ -373,51 +373,22 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
 		regs->pstate &= ~PSR_BTYPE_MASK;
 }
 
-static LIST_HEAD(undef_hook);
-static DEFINE_RAW_SPINLOCK(undef_lock);
-
-void register_undef_hook(struct undef_hook *hook)
+static int user_insn_read(struct pt_regs *regs, u32 *insnp)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&undef_lock, flags);
-	list_add(&hook->node, &undef_hook);
-	raw_spin_unlock_irqrestore(&undef_lock, flags);
-}
-
-void unregister_undef_hook(struct undef_hook *hook)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&undef_lock, flags);
-	list_del(&hook->node);
-	raw_spin_unlock_irqrestore(&undef_lock, flags);
-}
-
-static int call_undef_hook(struct pt_regs *regs)
-{
-	struct undef_hook *hook;
-	unsigned long flags;
 	u32 instr;
-	int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
 	void __user *pc = (void __user *)instruction_pointer(regs);
 
-	if (!user_mode(regs)) {
-		__le32 instr_le;
-		if (get_kernel_nofault(instr_le, (__force __le32 *)pc))
-			goto exit;
-		instr = le32_to_cpu(instr_le);
-	} else if (compat_thumb_mode(regs)) {
+	if (compat_thumb_mode(regs)) {
 		/* 16-bit Thumb instruction */
 		__le16 instr_le;
 		if (get_user(instr_le, (__le16 __user *)pc))
-			goto exit;
+			return -EFAULT;
 		instr = le16_to_cpu(instr_le);
 		if (aarch32_insn_is_wide(instr)) {
 			u32 instr2;
 
 			if (get_user(instr_le, (__le16 __user *)(pc + 2)))
-				goto exit;
+				return -EFAULT;
 			instr2 = le16_to_cpu(instr_le);
 			instr = (instr << 16) | instr2;
 		}
@@ -425,19 +396,12 @@ static int call_undef_hook(struct pt_regs *regs)
 		/* 32-bit ARM instruction */
 		__le32 instr_le;
 		if (get_user(instr_le, (__le32 __user *)pc))
-			goto exit;
+			return -EFAULT;
 		instr = le32_to_cpu(instr_le);
 	}
 
-	raw_spin_lock_irqsave(&undef_lock, flags);
-	list_for_each_entry(hook, &undef_hook, node)
-		if ((instr & hook->instr_mask) == hook->instr_val &&
-			(regs->pstate & hook->pstate_mask) == hook->pstate_val)
-			fn = hook->fn;
-
-	raw_spin_unlock_irqrestore(&undef_lock, flags);
-exit:
-	return fn ? fn(regs, instr) : 1;
+	*insnp = instr;
+	return 0;
 }
 
 void force_signal_inject(int signal, int code, unsigned long address, unsigned long err)
@@ -486,37 +450,64 @@ void arm64_notify_segfault(unsigned long addr)
 	force_signal_inject(SIGSEGV, code, addr, 0);
 }
 
-void do_undefinstr(struct pt_regs *regs)
+void do_el0_undef(struct pt_regs *regs, unsigned long esr)
 {
+	u32 insn;
+
 	/* check for AArch32 breakpoint instructions */
 	if (!aarch32_break_handler(regs))
 		return;
 
-	if (call_undef_hook(regs) == 0)
+	if (user_insn_read(regs, &insn))
+		goto out_err;
+
+	if (try_emulate_mrs(regs, insn))
+		return;
+
+	if (try_emulate_armv8_deprecated(regs, insn))
 		return;
 
-	BUG_ON(!user_mode(regs));
+out_err:
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
-NOKPROBE_SYMBOL(do_undefinstr);
 
-void do_bti(struct pt_regs *regs)
+void do_el1_undef(struct pt_regs *regs, unsigned long esr)
+{
+	u32 insn;
+
+	if (aarch64_insn_read((void *)regs->pc, &insn))
+		goto out_err;
+
+	if (try_emulate_el1_ssbs(regs, insn))
+		return;
+
+out_err:
+	die("Oops - Undefined instruction", regs, esr);
+}
+
+void do_el0_bti(struct pt_regs *regs)
 {
-	BUG_ON(!user_mode(regs));
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
-NOKPROBE_SYMBOL(do_bti);
 
-void do_ptrauth_fault(struct pt_regs *regs, unsigned long esr)
+void do_el1_bti(struct pt_regs *regs, unsigned long esr)
+{
+	die("Oops - BTI", regs, esr);
+}
+
+void do_el0_fpac(struct pt_regs *regs, unsigned long esr)
+{
+	force_signal_inject(SIGILL, ILL_ILLOPN, regs->pc, esr);
+}
+
+void do_el1_fpac(struct pt_regs *regs, unsigned long esr)
 {
 	/*
-	 * Unexpected FPAC exception or pointer authentication failure in
-	 * the kernel: kill the task before it does any more harm.
+	 * Unexpected FPAC exception in the kernel: kill the task before it
+	 * does any more harm.
 	 */
-	BUG_ON(!user_mode(regs));
-	force_signal_inject(SIGILL, ILL_ILLOPN, regs->pc, esr);
+	die("Oops - FPAC", regs, esr);
 }
-NOKPROBE_SYMBOL(do_ptrauth_fault);
 
 #define __user_cache_maint(insn, address, res)			\
 	if (address >= user_addr_max()) {			\
@@ -732,7 +723,7 @@ static const struct sys64_hook cp15_64_hooks[] = {
 	{},
 };
 
-void do_cp15instr(unsigned long esr, struct pt_regs *regs)
+void do_el0_cp15(unsigned long esr, struct pt_regs *regs)
 {
 	const struct sys64_hook *hook, *hook_base;
 
@@ -753,7 +744,7 @@ void do_cp15instr(unsigned long esr, struct pt_regs *regs)
 		hook_base = cp15_64_hooks;
 		break;
 	default:
-		do_undefinstr(regs);
+		do_el0_undef(regs, esr);
 		return;
 	}
 
@@ -768,12 +759,11 @@ void do_cp15instr(unsigned long esr, struct pt_regs *regs)
 	 * EL0. Fall back to our usual undefined instruction handler
 	 * so that we handle these consistently.
 	 */
-	do_undefinstr(regs);
+	do_el0_undef(regs, esr);
 }
-NOKPROBE_SYMBOL(do_cp15instr);
 #endif
 
-void do_sysinstr(unsigned long esr, struct pt_regs *regs)
+void do_el0_sys(unsigned long esr, struct pt_regs *regs)
 {
 	const struct sys64_hook *hook;
 
@@ -788,9 +778,8 @@ void do_sysinstr(unsigned long esr, struct pt_regs *regs)
 	 * back to our usual undefined instruction handler so that we handle
 	 * these consistently.
 	 */
-	do_undefinstr(regs);
+	do_el0_undef(regs, esr);
 }
-NOKPROBE_SYMBOL(do_sysinstr);
 
 static const char *esr_class_str[] = {
 	[0 ... ESR_ELx_EC_MAX]		= "UNRECOGNIZED EC",
@@ -964,7 +953,7 @@ static int bug_handler(struct pt_regs *regs, unsigned long esr)
 {
 	switch (report_bug(regs->pc, regs)) {
 	case BUG_TRAP_TYPE_BUG:
-		die("Oops - BUG", regs, 0);
+		die("Oops - BUG", regs, esr);
 		break;
 
 	case BUG_TRAP_TYPE_WARN:
@@ -1032,7 +1021,7 @@ static int kasan_handler(struct pt_regs *regs, unsigned long esr)
 	 * This is something that might be fixed at some point in the future.
 	 */
 	if (!recover)
-		die("Oops - KASAN", regs, 0);
+		die("Oops - KASAN", regs, esr);
 
 	/* If thread survives, skip over the brk instruction and continue: */
 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 1a89ebdc3acc..0238e6bd0d6c 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -94,6 +94,13 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 #define pte_wrprotect pte_wrprotect
 
+static inline int pte_read(pte_t pte)
+{
+	return (pte_val(pte) & _PAGE_RO) != _PAGE_NA;
+}
+
+#define pte_read pte_read
+
 static inline int pte_write(pte_t pte)
 {
 	return !(pte_val(pte) & _PAGE_RO);
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 2225991c69b5..6ad4714352c7 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -209,7 +209,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 
-	if (pte_young(*ptep))
+	if (!pte_young(*ptep))
 		return 0;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
 	return (old & _PAGE_ACCESSED) != 0;
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index ac75f4ab0dba..7ad1d1b042a6 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -45,7 +45,9 @@ static inline int pte_write(pte_t pte)
 	return pte_val(pte) & _PAGE_RW;
 }
 #endif
+#ifndef pte_read
 static inline int pte_read(pte_t pte)		{ return 1; }
+#endif
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 2e3f1a626a3a..3f471884816a 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -220,7 +220,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
 	/* Set return value. */
 	if (!is_tail_call)
-		emit_mv(RV_REG_A0, RV_REG_A5, ctx);
+		emit_addiw(RV_REG_A0, RV_REG_A5, 0, ctx);
 	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
 		  is_tail_call ? 4 : 0, /* skip TCC init */
 		  ctx);
@@ -413,12 +413,12 @@ static void emit_sext_32_rd(u8 *rd, struct rv_jit_context *ctx)
 	*rd = RV_REG_T2;
 }
 
-static int emit_jump_and_link(u8 rd, s64 rvoff, bool force_jalr,
+static int emit_jump_and_link(u8 rd, s64 rvoff, bool fixed_addr,
 			      struct rv_jit_context *ctx)
 {
 	s64 upper, lower;
 
-	if (rvoff && is_21b_int(rvoff) && !force_jalr) {
+	if (rvoff && fixed_addr && is_21b_int(rvoff)) {
 		emit(rv_jal(rd, rvoff >> 1), ctx);
 		return 0;
 	} else if (in_auipc_jalr_range(rvoff)) {
@@ -439,24 +439,17 @@ static bool is_signed_bpf_cond(u8 cond)
 		cond == BPF_JSGE || cond == BPF_JSLE;
 }
 
-static int emit_call(bool fixed, u64 addr, struct rv_jit_context *ctx)
+static int emit_call(u64 addr, bool fixed_addr, struct rv_jit_context *ctx)
 {
 	s64 off = 0;
 	u64 ip;
-	u8 rd;
-	int ret;
 
 	if (addr && ctx->insns) {
 		ip = (u64)(long)(ctx->insns + ctx->ninsns);
 		off = addr - ip;
 	}
 
-	ret = emit_jump_and_link(RV_REG_RA, off, !fixed, ctx);
-	if (ret)
-		return ret;
-	rd = bpf_to_rv_reg(BPF_REG_0, ctx);
-	emit_mv(rd, RV_REG_A0, ctx);
-	return 0;
+	return emit_jump_and_link(RV_REG_RA, off, fixed_addr, ctx);
 }
 
 int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
@@ -750,7 +743,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	/* JUMP off */
 	case BPF_JMP | BPF_JA:
 		rvoff = rv_offset(i, off, ctx);
-		ret = emit_jump_and_link(RV_REG_ZERO, rvoff, false, ctx);
+		ret = emit_jump_and_link(RV_REG_ZERO, rvoff, true, ctx);
 		if (ret)
 			return ret;
 		break;
@@ -869,17 +862,21 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	/* function call */
 	case BPF_JMP | BPF_CALL:
 	{
-		bool fixed;
+		bool fixed_addr;
 		u64 addr;
 
 		mark_call(ctx);
-		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass, &addr,
-					    &fixed);
+		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
+					    &addr, &fixed_addr);
 		if (ret < 0)
 			return ret;
-		ret = emit_call(fixed, addr, ctx);
+
+		ret = emit_call(addr, fixed_addr, ctx);
 		if (ret)
 			return ret;
+
+		if (insn->src_reg != BPF_PSEUDO_CALL)
+			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
 		break;
 	}
 	/* tail call */
@@ -894,7 +891,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			break;
 
 		rvoff = epilogue_offset(ctx);
-		ret = emit_jump_and_link(RV_REG_ZERO, rvoff, false, ctx);
+		ret = emit_jump_and_link(RV_REG_ZERO, rvoff, true, ctx);
 		if (ret)
 			return ret;
 		break;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 91d8322af413..5d929e413282 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -547,12 +547,17 @@
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
-/* Fam 17h MSRs */
-#define MSR_F17H_IRPERF			0xc00000e9
+/* Zen4 */
+#define MSR_ZEN4_BP_CFG			0xc001102e
+#define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
 
+/* Zen 2 */
 #define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
 #define MSR_ZEN2_SPECTRAL_CHICKEN_BIT	BIT_ULL(1)
 
+/* Fam 17h MSRs */
+#define MSR_F17H_IRPERF			0xc00000e9
+
 /* Fam 16h MSRs */
 #define MSR_F16H_L2I_PERF_CTL		0xc0010230
 #define MSR_F16H_L2I_PERF_CTR		0xc0010231
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 43dd7f281a21..c9e3246bf4f3 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -269,6 +269,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	u8 insn_buff[MAX_PATCH_LEN];
 
 	DPRINTK("alt table %px, -> %px", start, end);
+
+	/*
+	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
+	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
+	 * During the process, KASAN becomes confused seeing partial LA57
+	 * conversion and triggers a false-positive out-of-bound report.
+	 *
+	 * Disable KASAN until the patching is complete.
+	 */
+	kasan_disable_current();
+
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
@@ -336,6 +347,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 next:
 		optimize_nops(instr, a->instrlen);
 	}
+
+	kasan_enable_current();
 }
 
 #if defined(CONFIG_RETPOLINE) && defined(CONFIG_STACK_VALIDATION)
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 0a0230bd5089..39f038956108 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -80,6 +80,10 @@ static const int amd_div0[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x00, 0x0, 0x2f, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0x50, 0x0, 0x5f, 0xf));
 
+static const int amd_erratum_1485[] =
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
+			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
+
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
 {
 	int osvw_id = *erratum++;
@@ -1150,6 +1154,10 @@ static void init_amd(struct cpuinfo_x86 *c)
 		pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full protection.\n");
 		setup_force_cpu_bug(X86_BUG_DIV0);
 	}
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
+	     cpu_has_amd_erratum(c, amd_erratum_1485))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b0c7ae50a8d7..a404dcebc0f9 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -432,6 +432,13 @@ static const struct dmi_system_id lenovo_laptop[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
 		},
 	},
+	{
+		.ident = "Asus ExpertBook B1402CBA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
+		},
+	},
 	{
 		.ident = "LENOVO IdeaPad Flex 5 16ALC7",
 		.matches = {
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 4edfe1f8fff7..96a9c32239c0 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -99,7 +99,7 @@ static int mchp_tc_count_function_write(struct counter_device *counter,
 		priv->qdec_mode = 0;
 		/* Set highest rate based on whether soc has gclk or not */
 		bmr &= ~(ATMEL_TC_QDEN | ATMEL_TC_POSEN);
-		if (priv->tc_cfg->has_gclk)
+		if (!priv->tc_cfg->has_gclk)
 			cmr |= ATMEL_TC_TIMER_CLOCK2;
 		else
 			cmr |= ATMEL_TC_TIMER_CLOCK1;
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 535f021911c5..f2cfefc505a8 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -490,6 +490,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	union idxd_command_reg cmd;
 	DECLARE_COMPLETION_ONSTACK(done);
 	u32 stat;
+	unsigned long flags;
 
 	if (idxd_device_is_halted(idxd)) {
 		dev_warn(&idxd->pdev->dev, "Device is HALTED!\n");
@@ -503,7 +504,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	cmd.operand = operand;
 	cmd.int_req = 1;
 
-	spin_lock(&idxd->cmd_lock);
+	spin_lock_irqsave(&idxd->cmd_lock, flags);
 	wait_event_lock_irq(idxd->cmd_waitq,
 			    !test_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags),
 			    idxd->cmd_lock);
@@ -520,7 +521,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	 * After command submitted, release lock and go to sleep until
 	 * the command completes via interrupt.
 	 */
-	spin_unlock(&idxd->cmd_lock);
+	spin_unlock_irqrestore(&idxd->cmd_lock, flags);
 	wait_for_completion(&done);
 	stat = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
 	spin_lock(&idxd->cmd_lock);
diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index a1517ef1f4a0..0acf6a92a4ad 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -451,9 +451,8 @@ static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
 	mtk_uart_apdma_write(c, VFF_EN, VFF_EN_CLR_B);
 	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_INT_EN_CLR_B);
 
-	synchronize_irq(c->irq);
-
 	spin_unlock_irqrestore(&c->vc.lock, flags);
+	synchronize_irq(c->irq);
 
 	return 0;
 }
diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 21a7bdc88970..58248c8c25a7 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1206,6 +1206,10 @@ static int stm32_mdma_resume(struct dma_chan *c)
 	unsigned long flags;
 	u32 status, reg;
 
+	/* Transfer can be terminated */
+	if (!chan->desc || (stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & STM32_MDMA_CCR_EN))
+		return -EPERM;
+
 	hwdesc = chan->desc->node[chan->curr_hwdesc].hwdesc;
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index d8ef8a53a562..dc5b889828d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -221,7 +221,7 @@ static inline bool amdgpu_bo_in_cpu_visible_vram(struct amdgpu_bo *bo)
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct amdgpu_res_cursor cursor;
 
-	if (bo->tbo.resource->mem_type != TTM_PL_VRAM)
+	if (!bo->tbo.resource || bo->tbo.resource->mem_type != TTM_PL_VRAM)
 		return false;
 
 	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 634640d5c0ff..ffe7479a047d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1023,6 +1023,9 @@ static void disable_vbios_mode_if_required(
 		if (stream == NULL)
 			continue;
 
+		if (stream->apply_seamless_boot_optimization)
+			continue;
+
 		// only looking for first odm pipe
 		if (pipe->prev_odm_pipe)
 			continue;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 59390dc3d1b8..9c30ab106b0a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -158,6 +158,7 @@ static void _dpu_plane_calc_bw(struct drm_plane *plane,
 	const struct dpu_format *fmt = NULL;
 	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
 	int src_width, src_height, dst_height, fps;
+	u64 plane_pixel_rate, plane_bit_rate;
 	u64 plane_prefill_bw;
 	u64 plane_bw;
 	u32 hw_latency_lines;
@@ -180,13 +181,12 @@ static void _dpu_plane_calc_bw(struct drm_plane *plane,
 	scale_factor = src_height > dst_height ?
 		mult_frac(src_height, 1, dst_height) : 1;
 
-	plane_bw =
-		src_width * mode->vtotal * fps * fmt->bpp *
-		scale_factor;
+	plane_pixel_rate = src_width * mode->vtotal * fps;
+	plane_bit_rate = plane_pixel_rate * fmt->bpp;
 
-	plane_prefill_bw =
-		src_width * hw_latency_lines * fps * fmt->bpp *
-		scale_factor * mode->vtotal;
+	plane_bw = plane_bit_rate * scale_factor;
+
+	plane_prefill_bw = plane_bw * hw_latency_lines;
 
 	if ((vbp+vpw) > hw_latency_lines)
 		do_div(plane_prefill_bw, (vbp+vpw));
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 6d9eec98e0d3..854173df6701 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1682,13 +1682,6 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
 		return rc;
 
 	while (--link_train_max_retries) {
-		rc = dp_ctrl_reinitialize_mainlink(ctrl);
-		if (rc) {
-			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n",
-					rc);
-			break;
-		}
-
 		training_step = DP_TRAINING_NONE;
 		rc = dp_ctrl_setup_main_link(ctrl, &training_step);
 		if (rc == 0) {
@@ -1740,6 +1733,12 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
 			/* stop link training before start re training  */
 			dp_ctrl_clear_training_pattern(ctrl);
 		}
+
+		rc = dp_ctrl_reinitialize_mainlink(ctrl);
+		if (rc) {
+			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n", rc);
+			break;
+		}
 	}
 
 	if (ctrl->link->sink_request & DP_TEST_LINK_PHY_TEST_PATTERN)
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index d3ec4d67a9a3..85dec6167e0b 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1079,9 +1079,21 @@ static void dsi_wait4video_done(struct msm_dsi_host *msm_host)
 
 static void dsi_wait4video_eng_busy(struct msm_dsi_host *msm_host)
 {
+	u32 data;
+
 	if (!(msm_host->mode_flags & MIPI_DSI_MODE_VIDEO))
 		return;
 
+	data = dsi_read(msm_host, REG_DSI_STATUS0);
+
+	/* if video mode engine is not busy, its because
+	 * either timing engine was not turned on or the
+	 * DSI controller has finished transmitting the video
+	 * data already, so no need to wait in those cases
+	 */
+	if (!(data & DSI_STATUS0_VIDEO_MODE_ENGINE_BUSY))
+		return;
+
 	if (msm_host->power_on && msm_host->enabled) {
 		dsi_wait4video_done(msm_host);
 		/* delay 4 ms to skip BLLP */
@@ -1905,10 +1917,9 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 	}
 
 	msm_host->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
-	if (msm_host->irq < 0) {
-		ret = msm_host->irq;
-		dev_err(&pdev->dev, "failed to get irq: %d\n", ret);
-		return ret;
+	if (!msm_host->irq) {
+		dev_err(&pdev->dev, "failed to get irq\n");
+		return -EINVAL;
 	}
 
 	/* do not autoenable, will be enabled later */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index ed75622bf708..b91f8d17404d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1632,7 +1632,7 @@ static int vmw_cmd_tex_state(struct vmw_private *dev_priv,
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdSetTextureState);
 	SVGA3dTextureState *last_state = (SVGA3dTextureState *)
-	  ((unsigned long) header + header->size + sizeof(header));
+	  ((unsigned long) header + header->size + sizeof(*header));
 	SVGA3dTextureState *cur_state = (SVGA3dTextureState *)
 		((unsigned long) header + sizeof(*cmd));
 	struct vmw_resource *ctx;
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0ac67dd76574..25fa23593488 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4222,7 +4222,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			goto hid_hw_init_fail;
 	}
 
-	hidpp_connect_event(hidpp);
+	schedule_work(&hidpp->work);
+	flush_work(&hidpp->work);
 
 	if (will_restart) {
 		/* Reset the HID node state */
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6b7da40f99c8..919a338d9181 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1112,7 +1112,7 @@ int bmp280_common_probe(struct device *dev,
 	 * however as it happens, the BMP085 shares the chip ID of BMP180
 	 * so we look for an IRQ if we have that.
 	 */
-	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
+	if (irq > 0 && (chip_id  == BMP180_CHIP_ID)) {
 		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index cf8b92fae1b3..1b6b9530f166 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -57,8 +57,8 @@
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
 
-/* Make sure sleep time is <= 20ms for usleep_range */
-#define DPS310_POLL_SLEEP_US(t)		min(20000, (t) / 8)
+/* Make sure sleep time is <= 30ms for usleep_range */
+#define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
 /* Silently handle error in rate value here */
 #define DPS310_POLL_TIMEOUT_US(rc)	((rc) <= 0 ? 1000000 : 1000000 / (rc))
 
@@ -402,8 +402,8 @@ static int dps310_reset_wait(struct dps310_data *data)
 	if (rc)
 		return rc;
 
-	/* Wait for device chip access: 2.5ms in specification */
-	usleep_range(2500, 12000);
+	/* Wait for device chip access: 15ms in specification */
+	usleep_range(15000, 55000);
 	return 0;
 }
 
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 874a73b3ea9d..f88d8f2ce610 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -76,7 +76,7 @@ static bool ms5611_prom_is_valid(u16 *prom, size_t len)
 
 	crc = (crc >> 12) & 0x000F;
 
-	return crc_orig != 0x0000 && crc == crc_orig;
+	return crc == crc_orig;
 }
 
 static int ms5611_read_prom(struct iio_dev *indio_dev)
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index a3e4913904b7..f159cbb6bb3e 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -1965,6 +1965,9 @@ static int send_fw_act_open_req(struct c4iw_ep *ep, unsigned int atid)
 	int win;
 
 	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
 	req = __skb_put_zero(skb, sizeof(*req));
 	req->op_compl = htonl(WR_OP_V(FW_OFLD_CONNECTION_WR));
 	req->len16_pkd = htonl(FW_WR_LEN16_V(DIV_ROUND_UP(sizeof(*req), 16)));
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 7701204fe542..2938d7040f90 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1266,7 +1266,7 @@ static void srp_finish_req(struct srp_rdma_ch *ch, struct srp_request *req,
 	if (scmnd) {
 		srp_free_req(ch, req, scmnd, 0);
 		scmnd->result = result;
-		scmnd->scsi_done(scmnd);
+		scsi_done(scmnd);
 	}
 }
 
@@ -1984,7 +1984,7 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
 		srp_free_req(ch, req, scmnd,
 			     be32_to_cpu(rsp->req_lim_delta));
 
-		scmnd->scsi_done(scmnd);
+		scsi_done(scmnd);
 	}
 }
 
@@ -2236,7 +2236,7 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 
 err:
 	if (scmnd->result) {
-		scmnd->scsi_done(scmnd);
+		scsi_done(scmnd);
 		ret = 0;
 	} else {
 		ret = SCSI_MLQUEUE_HOST_BUSY;
@@ -2783,7 +2783,6 @@ static int srp_abort(struct scsi_cmnd *scmnd)
 	u32 tag;
 	u16 ch_idx;
 	struct srp_rdma_ch *ch;
-	int ret;
 
 	shost_printk(KERN_ERR, target->scsi_host, "SRP abort called\n");
 
@@ -2797,19 +2796,14 @@ static int srp_abort(struct scsi_cmnd *scmnd)
 	shost_printk(KERN_ERR, target->scsi_host,
 		     "Sending SRP abort for tag %#x\n", tag);
 	if (srp_send_tsk_mgmt(ch, tag, scmnd->device->lun,
-			      SRP_TSK_ABORT_TASK, NULL) == 0)
-		ret = SUCCESS;
-	else if (target->rport->state == SRP_RPORT_LOST)
-		ret = FAST_IO_FAIL;
-	else
-		ret = FAILED;
-	if (ret == SUCCESS) {
+			      SRP_TSK_ABORT_TASK, NULL) == 0) {
 		srp_free_req(ch, req, scmnd, 0);
-		scmnd->result = DID_ABORT << 16;
-		scmnd->scsi_done(scmnd);
+		return SUCCESS;
 	}
+	if (target->rport->state == SRP_RPORT_LOST)
+		return FAST_IO_FAIL;
 
-	return ret;
+	return FAILED;
 }
 
 static int srp_reset_device(struct scsi_cmnd *scmnd)
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 57947874f26f..8341ea7c4eb6 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -254,6 +254,7 @@ static const struct xpad_device {
 	{ 0x1038, 0x1430, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x1038, 0x1431, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x11c9, 0x55f0, "Nacon GC-100XF", 0, XTYPE_XBOX360 },
+	{ 0x11ff, 0x0511, "PXN V900", 0, XTYPE_XBOX360 },
 	{ 0x1209, 0x2882, "Ardwiino Controller", 0, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0004, "Honey Bee Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0301, "PDP AFTERGLOW AX.1", 0, XTYPE_XBOX360 },
@@ -449,6 +450,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries Controllers */
 	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
+	XPAD_XBOX360_VENDOR(0x11ff),		/* PXN V900 */
 	XPAD_XBOX360_VENDOR(0x1209),		/* Ardwiino Controllers */
 	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index c4e0e1886061..6b1b95d58e6b 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -425,6 +425,7 @@ static void powermate_disconnect(struct usb_interface *intf)
 		pm->requires_update = 0;
 		usb_kill_urb(pm->irq);
 		input_unregister_device(pm->input);
+		usb_kill_urb(pm->config);
 		usb_free_urb(pm->irq);
 		usb_free_urb(pm->config);
 		powermate_free_buffers(interface_to_usbdev(intf), pm);
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 2118b2075f43..4e38229404b4 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -2114,6 +2114,7 @@ static int elantech_setup_ps2(struct psmouse *psmouse,
 	psmouse->protocol_handler = elantech_process_byte;
 	psmouse->disconnect = elantech_disconnect;
 	psmouse->reconnect = elantech_reconnect;
+	psmouse->fast_reconnect = NULL;
 	psmouse->pktsize = info->hw_version > 1 ? 6 : 4;
 
 	return 0;
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ffad142801b3..ecc7ca653d75 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1622,6 +1622,7 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 	psmouse->set_rate = synaptics_set_rate;
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
+	psmouse->fast_reconnect = NULL;
 	psmouse->cleanup = synaptics_reset;
 	/* Synaptics can usually stay in sync without extra help */
 	psmouse->resync_time = 0;
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index a0d8528685fe..3db87ee0b70c 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -609,6 +609,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
+	{
+		/* Fujitsu Lifebook E5411 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU CLIENT COMPUTING LIMITED"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E5411"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		/* Gigabyte M912 */
 		.matches = {
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 166d36b2626e..1492f051331a 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -786,6 +786,25 @@ static int goodix_add_acpi_gpio_mappings(struct goodix_ts_data *ts)
 		dev_info(dev, "No ACPI GpioInt resource, assuming that the GPIO order is reset, int\n");
 		ts->irq_pin_access_method = IRQ_PIN_ACCESS_ACPI_GPIO;
 		gpio_mapping = acpi_goodix_int_last_gpios;
+	} else if (ts->gpio_count == 1 && ts->gpio_int_idx == 0) {
+		/*
+		 * On newer devices there is only 1 GpioInt resource and _PS0
+		 * does the whole reset sequence for us.
+		 */
+		acpi_device_fix_up_power(ACPI_COMPANION(dev));
+
+		/*
+		 * Before the _PS0 call the int GPIO may have been in output
+		 * mode and the call should have put the int GPIO in input mode,
+		 * but the GPIO subsys cached state may still think it is
+		 * in output mode, causing gpiochip_lock_as_irq() failure.
+		 *
+		 * Add a mapping for the int GPIO to make the
+		 * gpiod_int = gpiod_get(..., GPIOD_IN) call succeed,
+		 * which will explicitly set the direction to input.
+		 */
+		ts->irq_pin_access_method = IRQ_PIN_ACCESS_NONE;
+		gpio_mapping = acpi_goodix_int_first_gpios;
 	} else {
 		dev_warn(dev, "Unexpected ACPI resources: gpio_count %d, gpio_int_idx %d\n",
 			 ts->gpio_count, ts->gpio_int_idx);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 29538471c528..b3aa6ce9d3d7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3564,13 +3564,6 @@ static int iommu_suspend(void)
 	struct intel_iommu *iommu = NULL;
 	unsigned long flag;
 
-	for_each_active_iommu(iommu, drhd) {
-		iommu->iommu_state = kcalloc(MAX_SR_DMAR_REGS, sizeof(u32),
-					     GFP_KERNEL);
-		if (!iommu->iommu_state)
-			goto nomem;
-	}
-
 	iommu_flush_all();
 
 	for_each_active_iommu(iommu, drhd) {
@@ -3590,12 +3583,6 @@ static int iommu_suspend(void)
 		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 	}
 	return 0;
-
-nomem:
-	for_each_active_iommu(iommu, drhd)
-		kfree(iommu->iommu_state);
-
-	return -ENOMEM;
 }
 
 static void iommu_resume(void)
@@ -3627,9 +3614,6 @@ static void iommu_resume(void)
 
 		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 	}
-
-	for_each_active_iommu(iommu, drhd)
-		kfree(iommu->iommu_state);
 }
 
 static struct syscore_ops iommu_syscore_ops = {
diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 0530db548231..ce58d34b06d0 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -387,17 +387,13 @@ EXPORT_SYMBOL_NS_GPL(mcb_free_dev, MCB);
 
 static int __mcb_bus_add_devices(struct device *dev, void *data)
 {
-	struct mcb_device *mdev = to_mcb_device(dev);
 	int retval;
 
-	if (mdev->is_added)
-		return 0;
-
 	retval = device_attach(dev);
-	if (retval < 0)
+	if (retval < 0) {
 		dev_err(dev, "Error adding device (%d)\n", retval);
-
-	mdev->is_added = true;
+		return retval;
+	}
 
 	return 0;
 }
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index aa6938da0db8..c41cbacc75a2 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -99,8 +99,6 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 	mdev->mem.end = mdev->mem.start + size - 1;
 	mdev->mem.flags = IORESOURCE_MEM;
 
-	mdev->is_added = false;
-
 	ret = mcb_device_register(bus, mdev);
 	if (ret < 0)
 		goto err;
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index 470f8f167744..bc84274ba87a 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -1455,6 +1455,7 @@ static int mtk_jpeg_remove(struct platform_device *pdev)
 {
 	struct mtk_jpeg_dev *jpeg = platform_get_drvdata(pdev);
 
+	cancel_delayed_work_sync(&jpeg->job_timeout_work);
 	pm_runtime_disable(&pdev->dev);
 	video_unregister_device(jpeg->vdev);
 	v4l2_m2m_release(jpeg->m2m_dev);
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 3eba01de9525..08f4c7f66121 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -31,8 +31,6 @@ MODULE_LICENSE("GPL");
 
 #define ENA_MAX_RINGS min_t(unsigned int, ENA_MAX_NUM_IO_QUEUES, num_possible_cpus())
 
-#define ENA_NAPI_BUDGET 64
-
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_IFUP | \
 		NETIF_MSG_TX_DONE | NETIF_MSG_TX_ERR | NETIF_MSG_RX_ERR)
 
@@ -2303,7 +2301,7 @@ static void ena_init_napi_in_range(struct ena_adapter *adapter,
 		netif_napi_add(adapter->netdev,
 			       &napi->napi,
 			       ENA_IS_XDP_INDEX(adapter, i) ? ena_xdp_io_poll : ena_io_poll,
-			       ENA_NAPI_BUDGET);
+			       NAPI_POLL_WEIGHT);
 
 		if (!ENA_IS_XDP_INDEX(adapter, i)) {
 			napi->rx_ring = &adapter->rx_ring[i];
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index b1947fd9a07c..0347c9d3aff3 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -1881,7 +1881,6 @@ bnad_napi_poll_rx(struct napi_struct *napi, int budget)
 	return rcvd;
 }
 
-#define BNAD_NAPI_POLL_QUOTA		64
 static void
 bnad_napi_add(struct bnad *bnad, u32 rx_id)
 {
@@ -1892,7 +1891,7 @@ bnad_napi_add(struct bnad *bnad, u32 rx_id)
 	for (i = 0; i <	bnad->num_rxp_per_rx; i++) {
 		rx_ctrl = &bnad->rx_info[rx_id].rx_ctrl[i];
 		netif_napi_add(bnad->netdev, &rx_ctrl->napi,
-			       bnad_napi_poll_rx, BNAD_NAPI_POLL_QUOTA);
+			       bnad_napi_poll_rx, NAPI_POLL_WEIGHT);
 	}
 }
 
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 8361faf03e42..d0ba5ca862cf 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -68,7 +68,6 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 #define DEFAULT_GMAC_RXQ_ORDER		9
 #define DEFAULT_GMAC_TXQ_ORDER		8
 #define DEFAULT_RX_BUF_ORDER		11
-#define DEFAULT_NAPI_WEIGHT		64
 #define TX_MAX_FRAGS			16
 #define TX_QUEUE_NUM			1	/* max: 6 */
 #define RX_MAX_ALLOC_ORDER		2
@@ -2466,8 +2465,7 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	netdev->max_mtu = 10236 - VLAN_ETH_HLEN;
 
 	port->freeq_refill = 0;
-	netif_napi_add(netdev, &port->napi, gmac_napi_poll,
-		       DEFAULT_NAPI_WEIGHT);
+	netif_napi_add(netdev, &port->napi, gmac_napi_poll, NAPI_POLL_WEIGHT);
 
 	if (is_valid_ether_addr((void *)port->mac_addr)) {
 		memcpy(netdev->dev_addr, port->mac_addr, ETH_ALEN);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 0078ae592616..5eba086690ef 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -28,6 +28,9 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
 	struct vf_macvlans *mv_list;
 	int num_vf_macvlans, i;
 
+	/* Initialize list of VF macvlans */
+	INIT_LIST_HEAD(&adapter->vf_mvs.l);
+
 	num_vf_macvlans = hw->mac.num_rar_entries -
 			  (IXGBE_MAX_PF_MACVLANS + 1 + num_vfs);
 	if (!num_vf_macvlans)
@@ -36,8 +39,6 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
 	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
 			  GFP_KERNEL);
 	if (mv_list) {
-		/* Initialize list of VF macvlans */
-		INIT_LIST_HEAD(&adapter->vf_mvs.l);
 		for (i = 0; i < num_vf_macvlans; i++) {
 			mv_list[i].vf = -1;
 			mv_list[i].free = true;
diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index 051dd3fb5b03..791a209158cd 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -50,7 +50,6 @@
 #define PHY_RETRIES	        1000
 #define ETH_JUMBO_MTU		9000
 #define TX_WATCHDOG		(5 * HZ)
-#define NAPI_WEIGHT		64
 #define BLINK_MS		250
 #define LINK_HZ			HZ
 
@@ -3828,7 +3827,7 @@ static struct net_device *skge_devinit(struct skge_hw *hw, int port,
 		dev->features |= NETIF_F_HIGHDMA;
 
 	skge = netdev_priv(dev);
-	netif_napi_add(dev, &skge->napi, skge_poll, NAPI_WEIGHT);
+	netif_napi_add(dev, &skge->napi, skge_poll, NAPI_POLL_WEIGHT);
 	skge->netdev = dev;
 	skge->hw = hw;
 	skge->msg_enable = netif_msg_init(debug, default_msg);
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index ac0dbf1b9743..a1a182bb47c7 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -63,7 +63,6 @@
 #define TX_DEF_PENDING		63
 
 #define TX_WATCHDOG		(5 * HZ)
-#define NAPI_WEIGHT		64
 #define PHY_RETRIES		1000
 
 #define SKY2_EEPROM_MAGIC	0x9955aabb
@@ -5073,7 +5072,7 @@ static int sky2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	netif_napi_add(dev, &hw->napi, sky2_poll, NAPI_WEIGHT);
+	netif_napi_add(dev, &hw->napi, sky2_poll, NAPI_POLL_WEIGHT);
 
 	err = register_netdev(dev);
 	if (err) {
diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 1d5dd2015453..8f3493e146e5 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -30,7 +30,6 @@
 #define MTK_STAR_WAIT_TIMEOUT			300
 #define MTK_STAR_MAX_FRAME_SIZE			1514
 #define MTK_STAR_SKB_ALIGNMENT			16
-#define MTK_STAR_NAPI_WEIGHT			64
 #define MTK_STAR_HASHTABLE_MC_LIMIT		256
 #define MTK_STAR_HASHTABLE_SIZE_MAX		512
 
@@ -1551,7 +1550,7 @@ static int mtk_star_probe(struct platform_device *pdev)
 	ndev->netdev_ops = &mtk_star_netdev_ops;
 	ndev->ethtool_ops = &mtk_star_ethtool_ops;
 
-	netif_napi_add(ndev, &priv->napi, mtk_star_poll, MTK_STAR_NAPI_WEIGHT);
+	netif_napi_add(ndev, &priv->napi, mtk_star_poll, NAPI_POLL_WEIGHT);
 
 	return devm_register_netdev(dev, ndev);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index fdc4a5a80da4..923be5fb7d21 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3373,13 +3373,14 @@ static int set_feature_rx_fcs(struct net_device *netdev, bool enable)
 	struct mlx5e_channels *chs = &priv->channels;
 	struct mlx5e_params new_params;
 	int err;
+	bool rx_ts_over_crc = !enable;
 
 	mutex_lock(&priv->state_lock);
 
 	new_params = chs->params;
 	new_params.scatter_fcs_en = enable;
 	err = mlx5e_safe_switch_params(priv, &new_params, mlx5e_set_rx_port_ts_wrap,
-				       &new_params.scatter_fcs_en, true);
+				       &rx_ts_over_crc, true);
 	mutex_unlock(&priv->state_lock);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
index d018d2da5949..5e020d0addc6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -245,8 +245,8 @@ const struct mlxsw_sp_nve_ops mlxsw_sp1_nve_vxlan_ops = {
 	.fdb_clear_offload = mlxsw_sp_nve_vxlan_clear_offload,
 };
 
-static bool mlxsw_sp2_nve_vxlan_learning_set(struct mlxsw_sp *mlxsw_sp,
-					     bool learning_en)
+static int mlxsw_sp2_nve_vxlan_learning_set(struct mlxsw_sp *mlxsw_sp,
+					    bool learning_en)
 {
 	char tnpc_pl[MLXSW_REG_TNPC_LEN];
 
diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index d350c1ef9e0b..e7be0710220e 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -56,8 +56,8 @@
 
 #include <asm/irq.h>
 
-#define TX_WORK_PER_LOOP  64
-#define RX_WORK_PER_LOOP  64
+#define TX_WORK_PER_LOOP  NAPI_POLL_WEIGHT
+#define RX_WORK_PER_LOOP  NAPI_POLL_WEIGHT
 
 /*
  * Hardware access:
@@ -5869,7 +5869,7 @@ static int nv_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 	else
 		dev->netdev_ops = &nv_netdev_ops_optimized;
 
-	netif_napi_add(dev, &np->napi, nv_napi_poll, RX_WORK_PER_LOOP);
+	netif_napi_add(dev, &np->napi, nv_napi_poll, NAPI_POLL_WEIGHT);
 	dev->ethtool_ops = &ops;
 	dev->watchdog_timeo = NV_WATCHDOG_TIMEO;
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 4ee72d33e9cb..19733c9a7c25 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1774,6 +1774,8 @@ static int ravb_close(struct net_device *ndev)
 			of_phy_deregister_fixed_link(np);
 	}
 
+	cancel_work_sync(&priv->work);
+
 	if (info->multi_irqs) {
 		free_irq(priv->tx_irqs[RAVB_NC], ndev);
 		free_irq(priv->rx_irqs[RAVB_NC], ndev);
@@ -2382,14 +2384,14 @@ static int ravb_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->refclk);
 
-	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
-			  priv->desc_bat_dma);
 	/* Set reset mode */
 	ravb_write(ndev, CCC_OPC_RESET, CCC);
 	unregister_netdev(ndev);
 	netif_napi_del(&priv->napi[RAVB_NC]);
 	netif_napi_del(&priv->napi[RAVB_BE]);
 	ravb_mdio_release(priv);
+	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
+			  priv->desc_bat_dma);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(priv->rstc);
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index fbd6bd80f51f..305779f9685a 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -113,7 +113,6 @@ static const char emac_version_string[] = "TI DaVinci EMAC Linux v6.1";
 #define EMAC_DEF_RX_NUM_DESC		(128)
 #define EMAC_DEF_MAX_TX_CH		(1) /* Max TX channels configured */
 #define EMAC_DEF_MAX_RX_CH		(1) /* Max RX channels configured */
-#define EMAC_POLL_WEIGHT		(64) /* Default NAPI poll weight */
 
 /* Buffer descriptor parameters */
 #define EMAC_DEF_TX_MAX_SERVICE		(32) /* TX max service BD's */
@@ -1923,7 +1922,7 @@ static int davinci_emac_probe(struct platform_device *pdev)
 
 	ndev->netdev_ops = &emac_netdev_ops;
 	ndev->ethtool_ops = &ethtool_ops;
-	netif_napi_add(ndev, &priv->napi, emac_poll, EMAC_POLL_WEIGHT);
+	netif_napi_add(ndev, &priv->napi, emac_poll, NAPI_POLL_WEIGHT);
 
 	pm_runtime_enable(&pdev->dev);
 	rc = pm_runtime_get_sync(&pdev->dev);
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index a6450055908d..2f00be789a8a 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -24,7 +24,6 @@
 #include "netcp.h"
 
 #define NETCP_SOP_OFFSET	(NET_IP_ALIGN + NET_SKB_PAD)
-#define NETCP_NAPI_WEIGHT	64
 #define NETCP_TX_TIMEOUT	(5 * HZ)
 #define NETCP_PACKET_SIZE	(ETH_FRAME_LEN + ETH_FCS_LEN)
 #define NETCP_MIN_PACKET_SIZE	ETH_ZLEN
@@ -2096,8 +2095,8 @@ static int netcp_create_interface(struct netcp_device *netcp_device,
 	}
 
 	/* NAPI register */
-	netif_napi_add(ndev, &netcp->rx_napi, netcp_rx_poll, NETCP_NAPI_WEIGHT);
-	netif_tx_napi_add(ndev, &netcp->tx_napi, netcp_tx_poll, NETCP_NAPI_WEIGHT);
+	netif_napi_add(ndev, &netcp->rx_napi, netcp_rx_poll, NAPI_POLL_WEIGHT);
+	netif_tx_napi_add(ndev, &netcp->tx_napi, netcp_tx_poll, NAPI_POLL_WEIGHT);
 
 	/* Register the network device */
 	ndev->dev_id		= 0;
diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 5834d3ed6dcf..dc786c3bbccf 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2783,7 +2783,6 @@ static int ca8210_register_ext_clock(struct spi_device *spi)
 	struct device_node *np = spi->dev.of_node;
 	struct ca8210_priv *priv = spi_get_drvdata(spi);
 	struct ca8210_platform_data *pdata = spi->dev.platform_data;
-	int ret = 0;
 
 	if (!np)
 		return -EFAULT;
@@ -2800,18 +2799,8 @@ static int ca8210_register_ext_clock(struct spi_device *spi)
 		dev_crit(&spi->dev, "Failed to register external clk\n");
 		return PTR_ERR(priv->clk);
 	}
-	ret = of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
-	if (ret) {
-		clk_unregister(priv->clk);
-		dev_crit(
-			&spi->dev,
-			"Failed to register external clock as clock provider\n"
-		);
-	} else {
-		dev_info(&spi->dev, "External clock set as clock provider\n");
-	}
 
-	return ret;
+	return of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
 }
 
 /**
@@ -2823,8 +2812,8 @@ static void ca8210_unregister_ext_clock(struct spi_device *spi)
 {
 	struct ca8210_priv *priv = spi_get_drvdata(spi);
 
-	if (!priv->clk)
-		return
+	if (IS_ERR_OR_NULL(priv->clk))
+		return;
 
 	of_clk_del_provider(spi->dev.of_node);
 	clk_unregister(priv->clk);
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 21f41f25a8ab..07c822c30118 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2410,6 +2410,7 @@ static int macsec_upd_txsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.tx_sa = tx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_txsa, &ctx);
@@ -2503,6 +2504,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.rx_sa = rx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_rxsa, &ctx);
diff --git a/drivers/net/phy/mscc/mscc_macsec.c b/drivers/net/phy/mscc/mscc_macsec.c
index c00eef457b85..bec270785c59 100644
--- a/drivers/net/phy/mscc/mscc_macsec.c
+++ b/drivers/net/phy/mscc/mscc_macsec.c
@@ -880,6 +880,9 @@ static int vsc8584_macsec_upd_rxsa(struct macsec_context *ctx)
 {
 	struct macsec_flow *flow;
 
+	if (ctx->sa.update_pn)
+		return -EINVAL;
+
 	flow = vsc8584_macsec_find_flow(ctx, MACSEC_INGR);
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
@@ -929,6 +932,9 @@ static int vsc8584_macsec_upd_txsa(struct macsec_context *ctx)
 {
 	struct macsec_flow *flow;
 
+	if (ctx->sa.update_pn)
+		return -EINVAL;
+
 	flow = vsc8584_macsec_find_flow(ctx, MACSEC_EGR);
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 907f98b1eefe..56f1c334cdd2 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -221,13 +221,18 @@ static int dm9601_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	struct usbnet *dev = netdev_priv(netdev);
 
 	__le16 res;
+	int err;
 
 	if (phy_id) {
 		netdev_dbg(dev->net, "Only internal phy supported\n");
 		return 0;
 	}
 
-	dm_read_shared_word(dev, 1, loc, &res);
+	err = dm_read_shared_word(dev, 1, loc, &res);
+	if (err < 0) {
+		netdev_err(dev->net, "MDIO read error: %d\n", err);
+		return err;
+	}
 
 	netdev_dbg(dev->net,
 		   "dm9601_mdio_read() phy_id=0x%02x, loc=0x%02x, returns=0x%04x\n",
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index e1a5610b1747..f20ddaaa2451 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -41,9 +41,6 @@
 #include <asm/xen/hypercall.h>
 #include <xen/balloon.h>
 
-#define XENVIF_QUEUE_LENGTH 32
-#define XENVIF_NAPI_WEIGHT  64
-
 /* Number of bytes allowed on the internal guest Rx queue. */
 #define XENVIF_RX_QUEUE_BYTES (XEN_NETIF_RX_RING_SIZE/2 * PAGE_SIZE)
 
@@ -528,8 +525,6 @@ struct xenvif *xenvif_alloc(struct device *parent, domid_t domid,
 	dev->features = dev->hw_features | NETIF_F_RXCSUM;
 	dev->ethtool_ops = &xenvif_ethtool_ops;
 
-	dev->tx_queue_len = XENVIF_QUEUE_LENGTH;
-
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = ETH_MAX_MTU - VLAN_ETH_HLEN;
 
@@ -725,7 +720,7 @@ int xenvif_connect_data(struct xenvif_queue *queue,
 	atomic_set(&queue->inflight_packets, 0);
 
 	netif_napi_add(queue->vif->dev, &queue->napi, xenvif_poll,
-			XENVIF_NAPI_WEIGHT);
+			NAPI_POLL_WEIGHT);
 
 	queue->stalled = true;
 
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index ee7f3659b353..cea5ad907235 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -45,8 +45,8 @@ struct target {
 
 /**
  * struct fragment - info about fragment nodes in overlay expanded device tree
- * @target:	target of the overlay operation
  * @overlay:	pointer to the __overlay__ node
+ * @target:	target of the overlay operation
  */
 struct fragment {
 	struct device_node *overlay;
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 40945343c4cc..e2a055ba0b7a 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1177,7 +1177,7 @@ static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
 		u64 delta;
 		int i;
 
-		for (i = 0; i < CMN_DTM_NUM_COUNTERS; i++) {
+		for (i = 0; i < CMN_DT_NUM_COUNTERS; i++) {
 			if (status & (1U << i)) {
 				ret = IRQ_HANDLED;
 				if (WARN_ON(!dtc->counters[i]))
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index ffe39336fcac..17c6931211c6 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1007,17 +1007,20 @@ static int add_setting(struct pinctrl *p, struct pinctrl_dev *pctldev,
 
 static struct pinctrl *find_pinctrl(struct device *dev)
 {
-	struct pinctrl *p;
+	struct pinctrl *entry, *p = NULL;
 
 	mutex_lock(&pinctrl_list_mutex);
-	list_for_each_entry(p, &pinctrl_list, node)
-		if (p->dev == dev) {
-			mutex_unlock(&pinctrl_list_mutex);
-			return p;
+
+	list_for_each_entry(entry, &pinctrl_list, node) {
+		if (entry->dev == dev) {
+			p = entry;
+			kref_get(&p->users);
+			break;
 		}
+	}
 
 	mutex_unlock(&pinctrl_list_mutex);
-	return NULL;
+	return p;
 }
 
 static void pinctrl_free(struct pinctrl *p, bool inlist);
@@ -1126,7 +1129,6 @@ struct pinctrl *pinctrl_get(struct device *dev)
 	p = find_pinctrl(dev);
 	if (p) {
 		dev_dbg(dev, "obtain a copy of previously claimed pinctrl\n");
-		kref_get(&p->users);
 		return p;
 	}
 
diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 9a72999084b3..ba7224a4c352 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -228,6 +228,7 @@ config PINCTRL_RZN1
 	depends on OF
 	depends on ARCH_RZN1 || COMPILE_TEST
 	select GENERIC_PINCONF
+	select PINMUX
 	help
 	  This selects pinctrl driver for Renesas RZ/N1 devices.
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 8c845d263429..be99a78e1bb8 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1076,7 +1076,13 @@ static const struct dev_pm_ops hp_wmi_pm_ops = {
 	.restore  = hp_wmi_resume_handler,
 };
 
-static struct platform_driver hp_wmi_driver = {
+/*
+ * hp_wmi_bios_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver hp_wmi_driver __refdata = {
 	.driver = {
 		.name = "hp-wmi",
 		.pm = &hp_wmi_pm_ops,
diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 76f0d04e17f3..154b1b26d03f 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -787,6 +787,24 @@ static void tlmi_release_attr(void)
 	kset_unregister(tlmi_priv.authentication_kset);
 }
 
+static int tlmi_validate_setting_name(struct kset *attribute_kset, char *name)
+{
+	struct kobject *duplicate;
+
+	if (!strcmp(name, "Reserved"))
+		return -EINVAL;
+
+	duplicate = kset_find_obj(attribute_kset, name);
+	if (duplicate) {
+		pr_debug("Duplicate attribute name found - %s\n", name);
+		/* kset_find_obj() returns a reference */
+		kobject_put(duplicate);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static int tlmi_sysfs_init(void)
 {
 	int i, ret;
@@ -815,10 +833,8 @@ static int tlmi_sysfs_init(void)
 			continue;
 
 		/* check for duplicate or reserved values */
-		if (kset_find_obj(tlmi_priv.attribute_kset, tlmi_priv.setting[i]->display_name) ||
-		    !strcmp(tlmi_priv.setting[i]->display_name, "Reserved")) {
-			pr_debug("duplicate or reserved attribute name found - %s\n",
-				tlmi_priv.setting[i]->display_name);
+		if (tlmi_validate_setting_name(tlmi_priv.attribute_kset,
+					       tlmi_priv.setting[i]->display_name) < 0) {
 			kfree(tlmi_priv.setting[i]->possible_values);
 			kfree(tlmi_priv.setting[i]);
 			tlmi_priv.setting[i] = NULL;
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index dd9f5778f687..18b99240a906 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -50,8 +50,6 @@
 
 #include <asm/unaligned.h>
 
-static void scsi_eh_done(struct scsi_cmnd *scmd);
-
 /*
  * These should *probably* be handled by the host itself.
  * Since it is allowed to sleep, it probably should.
@@ -542,7 +540,8 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
 		/* handler does not care. Drop down to default handling */
 	}
 
-	if (scmd->cmnd[0] == TEST_UNIT_READY && scmd->scsi_done != scsi_eh_done)
+	if (scmd->cmnd[0] == TEST_UNIT_READY &&
+	    scmd->submitter != SUBMITTED_BY_SCSI_ERROR_HANDLER)
 		/*
 		 * nasty: for mid-layer issued TURs, we need to return the
 		 * actual sense data without any recovery attempt.  For eh
@@ -804,7 +803,7 @@ static enum scsi_disposition scsi_eh_completed_normally(struct scsi_cmnd *scmd)
  * scsi_eh_done - Completion function for error handling.
  * @scmd:	Cmd that is done.
  */
-static void scsi_eh_done(struct scsi_cmnd *scmd)
+void scsi_eh_done(struct scsi_cmnd *scmd)
 {
 	struct completion *eh_action;
 
@@ -1104,7 +1103,7 @@ static enum scsi_disposition scsi_send_eh_cmnd(struct scsi_cmnd *scmd,
 	shost->eh_action = &done;
 
 	scsi_log_send(scmd);
-	scmd->scsi_done = scsi_eh_done;
+	scmd->submitter = SUBMITTED_BY_SCSI_ERROR_HANDLER;
 
 	/*
 	 * Lock sdev->state_mutex to avoid that scsi_device_quiesce() can
@@ -1131,6 +1130,7 @@ static enum scsi_disposition scsi_send_eh_cmnd(struct scsi_cmnd *scmd,
 	if (rtn) {
 		if (timeleft > stall_for) {
 			scsi_eh_restore_cmnd(scmd, &ses);
+
 			timeleft -= stall_for;
 			msleep(jiffies_to_msecs(stall_for));
 			goto retry;
@@ -2360,11 +2360,6 @@ void scsi_report_device_reset(struct Scsi_Host *shost, int channel, int target)
 }
 EXPORT_SYMBOL(scsi_report_device_reset);
 
-static void
-scsi_reset_provider_done_command(struct scsi_cmnd *scmd)
-{
-}
-
 /**
  * scsi_ioctl_reset: explicitly reset a host/bus/target/device
  * @dev:	scsi_device to operate on
@@ -2401,7 +2396,7 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
 	scsi_init_command(dev, scmd);
 	scmd->cmnd = scsi_req(rq)->cmd;
 
-	scmd->scsi_done		= scsi_reset_provider_done_command;
+	scmd->submitter = SUBMITTED_BY_SCSI_RESET_IOCTL;
 	memset(&scmd->sdb, 0, sizeof(scmd->sdb));
 
 	scmd->cmd_len			= 0;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 5525e6ffee53..3dbfd15e6fe7 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1576,8 +1576,17 @@ static blk_status_t scsi_prepare_cmd(struct request *req)
 	return scsi_cmd_to_driver(cmd)->init_command(cmd);
 }
 
-static void scsi_mq_done(struct scsi_cmnd *cmd)
+void scsi_done(struct scsi_cmnd *cmd)
 {
+	switch (cmd->submitter) {
+	case SUBMITTED_BY_BLOCK_LAYER:
+		break;
+	case SUBMITTED_BY_SCSI_ERROR_HANDLER:
+		return scsi_eh_done(cmd);
+	case SUBMITTED_BY_SCSI_RESET_IOCTL:
+		return;
+	}
+
 	if (unlikely(blk_should_fake_timeout(scsi_cmd_to_rq(cmd)->q)))
 		return;
 	if (unlikely(test_and_set_bit(SCMD_STATE_COMPLETE, &cmd->state)))
@@ -1585,6 +1594,7 @@ static void scsi_mq_done(struct scsi_cmnd *cmd)
 	trace_scsi_dispatch_cmd_done(cmd);
 	blk_mq_complete_request(scsi_cmd_to_rq(cmd));
 }
+EXPORT_SYMBOL(scsi_done);
 
 static void scsi_mq_put_budget(struct request_queue *q, int budget_token)
 {
@@ -1684,7 +1694,8 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	scsi_set_resid(cmd, 0);
 	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
-	cmd->scsi_done = scsi_mq_done;
+	cmd->submitter = SUBMITTED_BY_BLOCK_LAYER;
+	cmd->scsi_done = scsi_done;
 
 	blk_mq_start_request(req);
 	reason = scsi_dispatch_cmd(cmd);
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 6d9152031a40..b7f963149352 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -84,6 +84,7 @@ void scsi_eh_ready_devs(struct Scsi_Host *shost,
 int scsi_eh_get_sense(struct list_head *work_q,
 		      struct list_head *done_q);
 int scsi_noretry_cmd(struct scsi_cmnd *scmd);
+void scsi_eh_done(struct scsi_cmnd *scmd);
 
 /* scsi_lib.c */
 extern int scsi_maybe_unblock_host(struct scsi_device *sdev);
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 372d64756ed6..3c15f6a9e91c 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -217,12 +217,12 @@ static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
 	return rc;
 }
 
+/* mutex must be held by caller */
 static void destroy_session(struct kref *ref)
 {
 	struct amdtee_session *sess = container_of(ref, struct amdtee_session,
 						   refcount);
 
-	mutex_lock(&session_list_mutex);
 	list_del(&sess->list_node);
 	mutex_unlock(&session_list_mutex);
 	kfree(sess);
@@ -272,7 +272,8 @@ int amdtee_open_session(struct tee_context *ctx,
 	if (arg->ret != TEEC_SUCCESS) {
 		pr_err("open_session failed %d\n", arg->ret);
 		handle_unload_ta(ta_handle);
-		kref_put(&sess->refcount, destroy_session);
+		kref_put_mutex(&sess->refcount, destroy_session,
+			       &session_list_mutex);
 		goto out;
 	}
 
@@ -290,7 +291,8 @@ int amdtee_open_session(struct tee_context *ctx,
 		pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
 		handle_close_session(ta_handle, session_info);
 		handle_unload_ta(ta_handle);
-		kref_put(&sess->refcount, destroy_session);
+		kref_put_mutex(&sess->refcount, destroy_session,
+			       &session_list_mutex);
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -331,7 +333,7 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
 	handle_close_session(ta_handle, session_info);
 	handle_unload_ta(ta_handle);
 
-	kref_put(&sess->refcount, destroy_session);
+	kref_put_mutex(&sess->refcount, destroy_session, &session_list_mutex);
 
 	return 0;
 }
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 69eead8a6015..11c0207ebd7e 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -41,6 +41,7 @@
 #define PHY_PORT_CS1_LINK_STATE_SHIFT	26
 
 #define ICM_TIMEOUT			5000	/* ms */
+#define ICM_RETRIES			3
 #define ICM_APPROVE_TIMEOUT		10000	/* ms */
 #define ICM_MAX_LINK			4
 
@@ -296,10 +297,9 @@ static bool icm_copy(struct tb_cfg_request *req, const struct ctl_pkg *pkg)
 
 static int icm_request(struct tb *tb, const void *request, size_t request_size,
 		       void *response, size_t response_size, size_t npackets,
-		       unsigned int timeout_msec)
+		       int retries, unsigned int timeout_msec)
 {
 	struct icm *icm = tb_priv(tb);
-	int retries = 3;
 
 	do {
 		struct tb_cfg_request *req;
@@ -410,7 +410,7 @@ static int icm_fr_get_route(struct tb *tb, u8 link, u8 depth, u64 *route)
 		return -ENOMEM;
 
 	ret = icm_request(tb, &request, sizeof(request), switches,
-			  sizeof(*switches), npackets, ICM_TIMEOUT);
+			  sizeof(*switches), npackets, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		goto err_free;
 
@@ -463,7 +463,7 @@ icm_fr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -488,7 +488,7 @@ static int icm_fr_approve_switch(struct tb *tb, struct tb_switch *sw)
 	memset(&reply, 0, sizeof(reply));
 	/* Use larger timeout as establishing tunnels can take some time */
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_APPROVE_TIMEOUT);
+			  1, ICM_RETRIES, ICM_APPROVE_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -515,7 +515,7 @@ static int icm_fr_add_switch_key(struct tb *tb, struct tb_switch *sw)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -543,7 +543,7 @@ static int icm_fr_challenge_switch_key(struct tb *tb, struct tb_switch *sw,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -577,7 +577,7 @@ static int icm_fr_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1022,7 +1022,7 @@ icm_tr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, 20000);
+			  1, 10, 2000);
 	if (ret)
 		return ret;
 
@@ -1055,7 +1055,7 @@ static int icm_tr_approve_switch(struct tb *tb, struct tb_switch *sw)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_APPROVE_TIMEOUT);
+			  1, ICM_RETRIES, ICM_APPROVE_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1083,7 +1083,7 @@ static int icm_tr_add_switch_key(struct tb *tb, struct tb_switch *sw)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1112,7 +1112,7 @@ static int icm_tr_challenge_switch_key(struct tb *tb, struct tb_switch *sw,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1146,7 +1146,7 @@ static int icm_tr_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1172,7 +1172,7 @@ static int icm_tr_xdomain_tear_down(struct tb *tb, struct tb_xdomain *xd,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1498,7 +1498,7 @@ icm_ar_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1524,7 +1524,7 @@ static int icm_ar_get_route(struct tb *tb, u8 link, u8 depth, u64 *route)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1545,7 +1545,7 @@ static int icm_ar_get_boot_acl(struct tb *tb, uuid_t *uuids, size_t nuuids)
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1606,7 +1606,7 @@ static int icm_ar_set_boot_acl(struct tb *tb, const uuid_t *uuids,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
@@ -1628,7 +1628,7 @@ icm_icl_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, 20000);
+			  1, ICM_RETRIES, 20000);
 	if (ret)
 		return ret;
 
@@ -2295,7 +2295,7 @@ static int icm_usb4_switch_op(struct tb_switch *sw, u16 opcode, u32 *metadata,
 
 	memset(&reply, 0, sizeof(reply));
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, ICM_TIMEOUT);
+			  1, ICM_RETRIES, ICM_TIMEOUT);
 	if (ret)
 		return ret;
 
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 8cc9e8c55e40..62a132b35ba2 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2552,6 +2552,13 @@ int tb_switch_lane_bonding_enable(struct tb_switch *sw)
 	    !tb_port_is_width_supported(down, 2))
 		return 0;
 
+	/*
+	 * Both lanes need to be in CL0. Here we assume lane 0 already be in
+	 * CL0 and check just for lane 1.
+	 */
+	if (tb_wait_for_port(down->dual_link_port, false) <= 0)
+		return -ENOTCONN;
+
 	ret = tb_port_lane_bonding_enable(up);
 	if (ret) {
 		tb_port_warn(up, "failed to enable lane bonding\n");
diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 068ccbd144b2..d9fb29eb99db 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1125,6 +1125,9 @@ static int cdnsp_gadget_ep_dequeue(struct usb_ep *ep,
 	unsigned long flags;
 	int ret;
 
+	if (request->status != -EINPROGRESS)
+		return 0;
+
 	if (!pep->endpoint.desc) {
 		dev_err(pdev->dev,
 			"%s: can't dequeue to disabled endpoint\n",
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 1b6631cdf5de..1726799367d1 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -131,8 +131,7 @@ void cdns_set_active(struct cdns *cdns, u8 set_active);
 #else /* CONFIG_PM_SLEEP */
 static inline int cdns_resume(struct cdns *cdns)
 { return 0; }
-static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
-{ return 0; }
+static inline void cdns_set_active(struct cdns *cdns, u8 set_active) { }
 static inline int cdns_suspend(struct cdns *cdns)
 { return 0; }
 #endif /* CONFIG_PM_SLEEP */
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4eb453d7e6f8..4bed41ca6b0f 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -150,6 +150,10 @@ int usb_device_supports_lpm(struct usb_device *udev)
 	if (udev->quirks & USB_QUIRK_NO_LPM)
 		return 0;
 
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return 0;
+
 	/* USB 2.1 (and greater) devices indicate LPM support through
 	 * their USB 2.0 Extended Capabilities BOS descriptor.
 	 */
@@ -326,6 +330,10 @@ static void usb_set_lpm_parameters(struct usb_device *udev)
 	if (!udev->lpm_capable || udev->speed < USB_SPEED_SUPER)
 		return;
 
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return;
+
 	hub = usb_hub_to_struct_hub(udev->parent);
 	/* It doesn't take time to transition the roothub into U0, since it
 	 * doesn't have an upstream link.
@@ -2698,13 +2706,17 @@ int usb_authorize_device(struct usb_device *usb_dev)
 static enum usb_ssp_rate get_port_ssp_rate(struct usb_device *hdev,
 					   u32 ext_portstatus)
 {
-	struct usb_ssp_cap_descriptor *ssp_cap = hdev->bos->ssp_cap;
+	struct usb_ssp_cap_descriptor *ssp_cap;
 	u32 attr;
 	u8 speed_id;
 	u8 ssac;
 	u8 lanes;
 	int i;
 
+	if (!hdev->bos)
+		goto out;
+
+	ssp_cap = hdev->bos->ssp_cap;
 	if (!ssp_cap)
 		goto out;
 
@@ -4186,8 +4198,15 @@ static void usb_enable_link_state(struct usb_hcd *hcd, struct usb_device *udev,
 		enum usb3_link_state state)
 {
 	int timeout, ret;
-	__u8 u1_mel = udev->bos->ss_cap->bU1devExitLat;
-	__le16 u2_mel = udev->bos->ss_cap->bU2DevExitLat;
+	__u8 u1_mel;
+	__le16 u2_mel;
+
+	/* Skip if the device BOS descriptor couldn't be read */
+	if (!udev->bos)
+		return;
+
+	u1_mel = udev->bos->ss_cap->bU1devExitLat;
+	u2_mel = udev->bos->ss_cap->bU2DevExitLat;
 
 	/* If the device says it doesn't have *any* exit latency to come out of
 	 * U1 or U2, it's probably lying.  Assume it doesn't implement that link
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 22ea1f4f2d66..db4c7e2c5960 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -141,7 +141,7 @@ static inline int hub_is_superspeedplus(struct usb_device *hdev)
 {
 	return (hdev->descriptor.bDeviceProtocol == USB_HUB_PR_SS &&
 		le16_to_cpu(hdev->descriptor.bcdUSB) >= 0x0310 &&
-		hdev->bos->ssp_cap);
+		hdev->bos && hdev->bos->ssp_cap);
 }
 
 static inline unsigned hub_power_on_good_delay(struct usb_hub *hub)
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 6377b9cf81a5..820ffd86e6e1 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -277,9 +277,46 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	 * XHCI driver will reset the host block. If dwc3 was configured for
 	 * host-only mode or current role is host, then we can return early.
 	 */
-	if (dwc->dr_mode == USB_DR_MODE_HOST || dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
+	/*
+	 * If the dr_mode is host and the dwc->current_dr_role is not the
+	 * corresponding DWC3_GCTL_PRTCAP_HOST, then the dwc3_core_init_mode
+	 * isn't executed yet. Ensure the phy is ready before the controller
+	 * updates the GCTL.PRTCAPDIR or other settings by soft-resetting
+	 * the phy.
+	 *
+	 * Note: GUSB3PIPECTL[n] and GUSB2PHYCFG[n] are port settings where n
+	 * is port index. If this is a multiport host, then we need to reset
+	 * all active ports.
+	 */
+	if (dwc->dr_mode == USB_DR_MODE_HOST) {
+		u32 usb3_port;
+		u32 usb2_port;
+
+		usb3_port = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+		usb3_port |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
+
+		usb2_port = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		usb2_port |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
+
+		/* Small delay for phy reset assertion */
+		usleep_range(1000, 2000);
+
+		usb3_port &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
+
+		usb2_port &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
+
+		/* Wait for clock synchronization */
+		msleep(50);
+		return 0;
+	}
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg |= DWC3_DCTL_CSFTRST;
 	reg &= ~DWC3_DCTL_RUN_STOP;
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index e0c183234283..aabaedb2e069 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1175,7 +1175,8 @@ static int ncm_unwrap_ntb(struct gether *port,
 			  struct sk_buff_head *list)
 {
 	struct f_ncm	*ncm = func_to_ncm(&port->func);
-	__le16		*tmp = (void *) skb->data;
+	unsigned char	*ntb_ptr = skb->data;
+	__le16		*tmp;
 	unsigned	index, index2;
 	int		ndp_index;
 	unsigned	dg_len, dg_len2;
@@ -1188,6 +1189,10 @@ static int ncm_unwrap_ntb(struct gether *port,
 	const struct ndp_parser_opts *opts = ncm->parser_opts;
 	unsigned	crc_len = ncm->is_crc ? sizeof(uint32_t) : 0;
 	int		dgram_counter;
+	int		to_process = skb->len;
+
+parse_ntb:
+	tmp = (__le16 *)ntb_ptr;
 
 	/* dwSignature */
 	if (get_unaligned_le32(tmp) != opts->nth_sign) {
@@ -1234,7 +1239,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 		 * walk through NDP
 		 * dwSignature
 		 */
-		tmp = (void *)(skb->data + ndp_index);
+		tmp = (__le16 *)(ntb_ptr + ndp_index);
 		if (get_unaligned_le32(tmp) != ncm->ndp_sign) {
 			INFO(port->func.config->cdev, "Wrong NDP SIGN\n");
 			goto err;
@@ -1291,11 +1296,11 @@ static int ncm_unwrap_ntb(struct gether *port,
 			if (ncm->is_crc) {
 				uint32_t crc, crc2;
 
-				crc = get_unaligned_le32(skb->data +
+				crc = get_unaligned_le32(ntb_ptr +
 							 index + dg_len -
 							 crc_len);
 				crc2 = ~crc32_le(~0,
-						 skb->data + index,
+						 ntb_ptr + index,
 						 dg_len - crc_len);
 				if (crc != crc2) {
 					INFO(port->func.config->cdev,
@@ -1322,7 +1327,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 							 dg_len - crc_len);
 			if (skb2 == NULL)
 				goto err;
-			skb_put_data(skb2, skb->data + index,
+			skb_put_data(skb2, ntb_ptr + index,
 				     dg_len - crc_len);
 
 			skb_queue_tail(list, skb2);
@@ -1335,10 +1340,17 @@ static int ncm_unwrap_ntb(struct gether *port,
 		} while (ndp_len > 2 * (opts->dgram_item_len * 2));
 	} while (ndp_index);
 
-	dev_consume_skb_any(skb);
-
 	VDBG(port->func.config->cdev,
 	     "Parsed NTB with %d frames\n", dgram_counter);
+
+	to_process -= block_len;
+	if (to_process != 0) {
+		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
+		goto parse_ntb;
+	}
+
+	dev_consume_skb_any(skb);
+
 	return 0;
 err:
 	skb_queue_purge(list);
diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 9cf43731bcd1..c941bfdaa017 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -496,11 +496,13 @@ static int xudc_eptxrx(struct xusb_ep *ep, struct xusb_req *req,
 		/* Get the Buffer address and copy the transmit data.*/
 		eprambase = (u32 __force *)(udc->addr + ep->rambase);
 		if (ep->is_in) {
-			memcpy(eprambase, bufferptr, bytestosend);
+			memcpy_toio((void __iomem *)eprambase, bufferptr,
+				    bytestosend);
 			udc->write_fn(udc->addr, ep->offset +
 				      XUSB_EP_BUF0COUNT_OFFSET, bufferlen);
 		} else {
-			memcpy(bufferptr, eprambase, bytestosend);
+			memcpy_toio((void __iomem *)bufferptr, eprambase,
+				    bytestosend);
 		}
 		/*
 		 * Enable the buffer for transmission.
@@ -514,11 +516,13 @@ static int xudc_eptxrx(struct xusb_ep *ep, struct xusb_req *req,
 		eprambase = (u32 __force *)(udc->addr + ep->rambase +
 			     ep->ep_usb.maxpacket);
 		if (ep->is_in) {
-			memcpy(eprambase, bufferptr, bytestosend);
+			memcpy_toio((void __iomem *)eprambase, bufferptr,
+				    bytestosend);
 			udc->write_fn(udc->addr, ep->offset +
 				      XUSB_EP_BUF1COUNT_OFFSET, bufferlen);
 		} else {
-			memcpy(bufferptr, eprambase, bytestosend);
+			memcpy_toio((void __iomem *)bufferptr, eprambase,
+				    bytestosend);
 		}
 		/*
 		 * Enable the buffer for transmission.
@@ -1020,7 +1024,7 @@ static int __xudc_ep0_queue(struct xusb_ep *ep0, struct xusb_req *req)
 			   udc->addr);
 		length = req->usb_req.actual = min_t(u32, length,
 						     EP0_MAX_PACKET);
-		memcpy(corebuf, req->usb_req.buf, length);
+		memcpy_toio((void __iomem *)corebuf, req->usb_req.buf, length);
 		udc->write_fn(udc->addr, XUSB_EP_BUF0COUNT_OFFSET, length);
 		udc->write_fn(udc->addr, XUSB_BUFFREADY_OFFSET, 1);
 	} else {
@@ -1746,7 +1750,7 @@ static void xudc_handle_setup(struct xusb_udc *udc)
 
 	/* Load up the chapter 9 command buffer.*/
 	ep0rambase = (u32 __force *) (udc->addr + XUSB_SETUP_PKT_ADDR_OFFSET);
-	memcpy(&setup, ep0rambase, 8);
+	memcpy_toio((void __iomem *)&setup, ep0rambase, 8);
 
 	udc->setup = setup;
 	udc->setup.wValue = cpu_to_le16(setup.wValue);
@@ -1833,7 +1837,7 @@ static void xudc_ep0_out(struct xusb_udc *udc)
 			     (ep0->rambase << 2));
 		buffer = req->usb_req.buf + req->usb_req.actual;
 		req->usb_req.actual = req->usb_req.actual + bytes_to_rx;
-		memcpy(buffer, ep0rambase, bytes_to_rx);
+		memcpy_toio((void __iomem *)buffer, ep0rambase, bytes_to_rx);
 
 		if (req->usb_req.length == req->usb_req.actual) {
 			/* Data transfer completed get ready for Status stage */
@@ -1909,7 +1913,7 @@ static void xudc_ep0_in(struct xusb_udc *udc)
 				     (ep0->rambase << 2));
 			buffer = req->usb_req.buf + req->usb_req.actual;
 			req->usb_req.actual = req->usb_req.actual + length;
-			memcpy(ep0rambase, buffer, length);
+			memcpy_toio((void __iomem *)ep0rambase, buffer, length);
 		}
 		udc->write_fn(udc->addr, XUSB_EP_BUF0COUNT_OFFSET, count);
 		udc->write_fn(udc->addr, XUSB_BUFFREADY_OFFSET, 1);
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 15e44045230e..945ed5f3e858 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -772,7 +772,7 @@ static void xhci_giveback_urb_in_irq(struct xhci_hcd *xhci,
 static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
 		struct xhci_ring *ring, struct xhci_td *td)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_segment *seg = td->bounce_seg;
 	struct urb *urb = td->urb;
 	size_t len;
@@ -3521,7 +3521,7 @@ static u32 xhci_td_remainder(struct xhci_hcd *xhci, int transferred,
 static int xhci_align_td(struct xhci_hcd *xhci, struct urb *urb, u32 enqd_len,
 			 u32 *trb_buff_len, struct xhci_segment *seg)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	unsigned int unalign;
 	unsigned int max_pkt;
 	u32 new_buff_len;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 1fd2f6a850eb..5c9d3be136d2 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -611,8 +611,27 @@ static int xhci_init(struct usb_hcd *hcd)
 
 static int xhci_run_finished(struct xhci_hcd *xhci)
 {
+	unsigned long	flags;
+	u32		temp;
+
+	/*
+	 * Enable interrupts before starting the host (xhci 4.2 and 5.5.2).
+	 * Protect the short window before host is running with a lock
+	 */
+	spin_lock_irqsave(&xhci->lock, flags);
+
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Enable interrupts");
+	temp = readl(&xhci->op_regs->command);
+	temp |= (CMD_EIE);
+	writel(temp, &xhci->op_regs->command);
+
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Enable primary interrupter");
+	temp = readl(&xhci->ir_set->irq_pending);
+	writel(ER_IRQ_ENABLE(temp), &xhci->ir_set->irq_pending);
+
 	if (xhci_start(xhci)) {
 		xhci_halt(xhci);
+		spin_unlock_irqrestore(&xhci->lock, flags);
 		return -ENODEV;
 	}
 	xhci->shared_hcd->state = HC_STATE_RUNNING;
@@ -623,6 +642,9 @@ static int xhci_run_finished(struct xhci_hcd *xhci)
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"Finished xhci_run for USB3 roothub");
+
+	spin_unlock_irqrestore(&xhci->lock, flags);
+
 	return 0;
 }
 
@@ -671,19 +693,6 @@ int xhci_run(struct usb_hcd *hcd)
 	temp |= (xhci->imod_interval / 250) & ER_IRQ_INTERVAL_MASK;
 	writel(temp, &xhci->ir_set->irq_control);
 
-	/* Set the HCD state before we enable the irqs */
-	temp = readl(&xhci->op_regs->command);
-	temp |= (CMD_EIE);
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Enable interrupts, cmd = 0x%x.", temp);
-	writel(temp, &xhci->op_regs->command);
-
-	temp = readl(&xhci->ir_set->irq_pending);
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Enabling event ring interrupter %p by writing 0x%x to irq_pending",
-			xhci->ir_set, (unsigned int) ER_IRQ_ENABLE(temp));
-	writel(ER_IRQ_ENABLE(temp), &xhci->ir_set->irq_pending);
-
 	if (xhci->quirks & XHCI_NEC_HOST) {
 		struct xhci_command *command;
 
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 30a89aa8a3e7..5401ae66894e 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -39,7 +39,7 @@ static const struct musb_register_map musb_regmap[] = {
 	{ "IntrUsbE",	MUSB_INTRUSBE,	8 },
 	{ "DevCtl",	MUSB_DEVCTL,	8 },
 	{ "VControl",	0x68,		32 },
-	{ "HWVers",	0x69,		16 },
+	{ "HWVers",	MUSB_HWVERS,	16 },
 	{ "LinkInfo",	MUSB_LINKINFO,	8 },
 	{ "VPLen",	MUSB_VPLEN,	8 },
 	{ "HS_EOF1",	MUSB_HS_EOF1,	8 },
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 9ff7d891b4b7..ef0b1589b10e 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -321,10 +321,16 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 	musb_giveback(musb, urb, status);
 	qh->is_ready = ready;
 
+	/*
+	 * musb->lock had been unlocked in musb_giveback, so qh may
+	 * be freed, need to get it again
+	 */
+	qh = musb_ep_get_qh(hw_ep, is_in);
+
 	/* reclaim resources (and bandwidth) ASAP; deschedule it, and
 	 * invalidate qh as soon as list_empty(&hep->urb_list)
 	 */
-	if (list_empty(&qh->hep->urb_list)) {
+	if (qh && list_empty(&qh->hep->urb_list)) {
 		struct list_head	*head;
 		struct dma_controller	*dma = musb->dma_controller;
 
@@ -2398,6 +2404,7 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		 * and its URB list has emptied, recycle this qh.
 		 */
 		if (ready && list_empty(&qh->hep->urb_list)) {
+			musb_ep_set_qh(qh->hw_ep, is_in, NULL);
 			qh->hep->hcpriv = NULL;
 			list_del(&qh->ring);
 			kfree(qh);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index cb87714fe886..f3fba3d27efa 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2436,7 +2436,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 		ret = do_splice_direct(src_file, &src_off, dst_file,
 				       &dst_off, src_objlen, flags);
 		/* Abort on short copies or on error */
-		if (ret < src_objlen) {
+		if (ret < (long)src_objlen) {
 			dout("Failed partial copy (%zd)\n", ret);
 			goto out;
 		}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 42e449d3f18b..28281c83cf5f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -647,9 +647,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 			ci->i_truncate_seq = truncate_seq;
 
 			/* the MDS should have revoked these caps */
-			WARN_ON_ONCE(issued & (CEPH_CAP_FILE_EXCL |
-					       CEPH_CAP_FILE_RD |
-					       CEPH_CAP_FILE_WR |
+			WARN_ON_ONCE(issued & (CEPH_CAP_FILE_RD |
 					       CEPH_CAP_FILE_LAZYIO));
 			/*
 			 * If we hold relevant caps, or in the case where we're
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 889eaea56a78..6088d73d29ce 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -233,19 +233,18 @@ static void put_quota_format(struct quota_format_type *fmt)
  * All dquots are placed to the end of inuse_list when first created, and this
  * list is used for invalidate operation, which must look at every dquot.
  *
- * When the last reference of a dquot will be dropped, the dquot will be
- * added to releasing_dquots. We'd then queue work item which would call
+ * When the last reference of a dquot is dropped, the dquot is added to
+ * releasing_dquots. We'll then queue work item which will call
  * synchronize_srcu() and after that perform the final cleanup of all the
- * dquots on the list. Both releasing_dquots and free_dquots use the
- * dq_free list_head in the dquot struct. When a dquot is removed from
- * releasing_dquots, a reference count is always subtracted, and if
- * dq_count == 0 at that point, the dquot will be added to the free_dquots.
+ * dquots on the list. Each cleaned up dquot is moved to free_dquots list.
+ * Both releasing_dquots and free_dquots use the dq_free list_head in the dquot
+ * struct.
  *
- * Unused dquots (dq_count == 0) are added to the free_dquots list when freed,
- * and this list is searched whenever we need an available dquot.  Dquots are
- * removed from the list as soon as they are used again, and
- * dqstats.free_dquots gives the number of dquots on the list. When
- * dquot is invalidated it's completely released from memory.
+ * Unused and cleaned up dquots are in the free_dquots list and this list is
+ * searched whenever we need an available dquot. Dquots are removed from the
+ * list as soon as they are used again and dqstats.free_dquots gives the number
+ * of dquots on the list. When dquot is invalidated it's completely released
+ * from memory.
  *
  * Dirty dquots are added to the dqi_dirty_list of quota_info when mark
  * dirtied, and this list is searched when writing dirty dquots back to
@@ -321,6 +320,7 @@ static inline void put_dquot_last(struct dquot *dquot)
 static inline void put_releasing_dquots(struct dquot *dquot)
 {
 	list_add_tail(&dquot->dq_free, &releasing_dquots);
+	set_bit(DQ_RELEASING_B, &dquot->dq_flags);
 }
 
 static inline void remove_free_dquot(struct dquot *dquot)
@@ -328,8 +328,10 @@ static inline void remove_free_dquot(struct dquot *dquot)
 	if (list_empty(&dquot->dq_free))
 		return;
 	list_del_init(&dquot->dq_free);
-	if (!atomic_read(&dquot->dq_count))
+	if (!test_bit(DQ_RELEASING_B, &dquot->dq_flags))
 		dqstats_dec(DQST_FREE_DQUOTS);
+	else
+		clear_bit(DQ_RELEASING_B, &dquot->dq_flags);
 }
 
 static inline void put_inuse(struct dquot *dquot)
@@ -581,12 +583,6 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			continue;
 		/* Wait for dquot users */
 		if (atomic_read(&dquot->dq_count)) {
-			/* dquot in releasing_dquots, flush and retry */
-			if (!list_empty(&dquot->dq_free)) {
-				spin_unlock(&dq_list_lock);
-				goto restart;
-			}
-
 			atomic_inc(&dquot->dq_count);
 			spin_unlock(&dq_list_lock);
 			/*
@@ -605,6 +601,15 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			 * restart. */
 			goto restart;
 		}
+		/*
+		 * The last user already dropped its reference but dquot didn't
+		 * get fully cleaned up yet. Restart the scan which flushes the
+		 * work cleaning up released dquots.
+		 */
+		if (test_bit(DQ_RELEASING_B, &dquot->dq_flags)) {
+			spin_unlock(&dq_list_lock);
+			goto restart;
+		}
 		/*
 		 * Quota now has no users and it has been written on last
 		 * dqput()
@@ -696,6 +701,13 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
 						 dq_dirty);
 
 			WARN_ON(!dquot_active(dquot));
+			/* If the dquot is releasing we should not touch it */
+			if (test_bit(DQ_RELEASING_B, &dquot->dq_flags)) {
+				spin_unlock(&dq_list_lock);
+				flush_delayed_work(&quota_release_work);
+				spin_lock(&dq_list_lock);
+				continue;
+			}
 
 			/* Now we have active dquot from which someone is
  			 * holding reference so we can safely just increase
@@ -809,18 +821,18 @@ static void quota_release_workfn(struct work_struct *work)
 	/* Exchange the list head to avoid livelock. */
 	list_replace_init(&releasing_dquots, &rls_head);
 	spin_unlock(&dq_list_lock);
+	synchronize_srcu(&dquot_srcu);
 
 restart:
-	synchronize_srcu(&dquot_srcu);
 	spin_lock(&dq_list_lock);
 	while (!list_empty(&rls_head)) {
 		dquot = list_first_entry(&rls_head, struct dquot, dq_free);
-		/* Dquot got used again? */
-		if (atomic_read(&dquot->dq_count) > 1) {
-			remove_free_dquot(dquot);
-			atomic_dec(&dquot->dq_count);
-			continue;
-		}
+		WARN_ON_ONCE(atomic_read(&dquot->dq_count));
+		/*
+		 * Note that DQ_RELEASING_B protects us from racing with
+		 * invalidate_dquots() calls so we are safe to work with the
+		 * dquot even after we drop dq_list_lock.
+		 */
 		if (dquot_dirty(dquot)) {
 			spin_unlock(&dq_list_lock);
 			/* Commit dquot before releasing */
@@ -834,7 +846,6 @@ static void quota_release_workfn(struct work_struct *work)
 		}
 		/* Dquot is inactive and clean, now move it to free list */
 		remove_free_dquot(dquot);
-		atomic_dec(&dquot->dq_count);
 		put_dquot_last(dquot);
 	}
 	spin_unlock(&dq_list_lock);
@@ -875,6 +886,7 @@ void dqput(struct dquot *dquot)
 	BUG_ON(!list_empty(&dquot->dq_free));
 #endif
 	put_releasing_dquots(dquot);
+	atomic_dec(&dquot->dq_count);
 	spin_unlock(&dq_list_lock);
 	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
 }
@@ -963,7 +975,7 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 		dqstats_inc(DQST_LOOKUPS);
 	}
 	/* Wait for dq_lock - after this we know that either dquot_release() is
-	 * already finished or it will be canceled due to dq_count > 1 test */
+	 * already finished or it will be canceled due to dq_count > 0 test */
 	wait_on_dquot(dquot);
 	/* Read the dquot / allocate space in quota file */
 	if (!dquot_active(dquot)) {
diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index d89fa2579ac0..4eb64548a74f 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -64,7 +64,7 @@ struct trusted_key_ops {
 	/* Unseal a key. */
 	int (*unseal)(struct trusted_key_payload *p, char *datablob);
 
-	/* Get a randomized key. */
+	/* Optional: Get a randomized key. */
 	int (*get_random)(unsigned char *key, size_t key_len);
 
 	/* Exit key interface. */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 0cf00786a164..e00857c4efc2 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -604,7 +604,7 @@ struct intel_iommu {
 	struct iopf_queue *iopf_queue;
 	unsigned char iopfq_name[16];
 	struct q_inval  *qi;            /* Queued invalidation info */
-	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
+	u32 iommu_state[MAX_SR_DMAR_REGS]; /* Store iommu states between suspend and resume.*/
 
 #ifdef CONFIG_IRQ_REMAP
 	struct ir_table *ir_table;	/* Interrupt remapping info */
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index d1f386430795..b6fb76568b01 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -33,6 +33,7 @@ struct ipv6_devconf {
 	__s32		accept_ra_defrtr;
 	__u32		ra_defrtr_metric;
 	__s32		accept_ra_min_hop_limit;
+	__s32		accept_ra_min_lft;
 	__s32		accept_ra_pinfo;
 	__s32		ignore_routes_with_linkdown;
 #ifdef CONFIG_IPV6_ROUTER_PREF
diff --git a/include/linux/mcb.h b/include/linux/mcb.h
index f6efb16f9d1b..91ec9a83149e 100644
--- a/include/linux/mcb.h
+++ b/include/linux/mcb.h
@@ -63,7 +63,6 @@ static inline struct mcb_bus *to_mcb_bus(struct device *dev)
 struct mcb_device {
 	struct device dev;
 	struct mcb_bus *bus;
-	bool is_added;
 	struct mcb_driver *driver;
 	u16 id;
 	int inst;
diff --git a/include/linux/quota.h b/include/linux/quota.h
index 18ebd39c9487..fc52cd623d29 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -285,7 +285,9 @@ static inline void dqstats_dec(unsigned int type)
 #define DQ_FAKE_B	3	/* no limits only usage */
 #define DQ_READ_B	4	/* dquot was read into memory */
 #define DQ_ACTIVE_B	5	/* dquot is active (dquot_release not called) */
-#define DQ_LASTSET_B	6	/* Following 6 bits (see QIF_) are reserved\
+#define DQ_RELEASING_B	6	/* dquot is in releasing_dquots list waiting
+				 * to be cleaned up */
+#define DQ_LASTSET_B	7	/* Following 6 bits (see QIF_) are reserved\
 				 * for the mask of entries set via SETQUOTA\
 				 * quotactl. They are set under dq_data_lock\
 				 * and the quota format handling dquot can\
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index a0f6668924d3..4bc8ff2a6614 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -56,7 +56,7 @@ static inline bool dquot_is_busy(struct dquot *dquot)
 {
 	if (test_bit(DQ_MOD_B, &dquot->dq_flags))
 		return true;
-	if (atomic_read(&dquot->dq_count) > 1)
+	if (atomic_read(&dquot->dq_count) > 0)
 		return true;
 	return false;
 }
diff --git a/include/net/macsec.h b/include/net/macsec.h
index d6fa6b97f6ef..0dc430332939 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -240,6 +240,7 @@ struct macsec_context {
 	struct macsec_secy *secy;
 	struct macsec_rx_sc *rx_sc;
 	struct {
+		bool update_pn;
 		unsigned char assoc_num;
 		u8 key[MACSEC_MAX_KEY_LEN];
 		union {
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 685249233f2f..e1180771604d 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -65,6 +65,12 @@ struct scsi_pointer {
 #define SCMD_STATE_COMPLETE	0
 #define SCMD_STATE_INFLIGHT	1
 
+enum scsi_cmnd_submitter {
+	SUBMITTED_BY_BLOCK_LAYER = 0,
+	SUBMITTED_BY_SCSI_ERROR_HANDLER = 1,
+	SUBMITTED_BY_SCSI_RESET_IOCTL = 2,
+} __packed;
+
 struct scsi_cmnd {
 	struct scsi_request req;
 	struct scsi_device *device;
@@ -90,6 +96,7 @@ struct scsi_cmnd {
 	unsigned char prot_op;
 	unsigned char prot_type;
 	unsigned char prot_flags;
+	enum scsi_cmnd_submitter submitter;
 
 	unsigned short cmd_len;
 	enum dma_data_direction sc_data_direction;
@@ -165,6 +172,8 @@ static inline struct scsi_driver *scsi_cmd_to_driver(struct scsi_cmnd *cmd)
 	return *(struct scsi_driver **)rq->rq_disk->private_data;
 }
 
+void scsi_done(struct scsi_cmnd *cmd);
+
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
 
 extern void *scsi_kmap_atomic_sg(struct scatterlist *sg, int sg_count,
diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
index 39c6add59a1a..4fa8511b1e35 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -196,6 +196,9 @@ enum {
 	DEVCONF_IOAM6_ENABLED,
 	DEVCONF_IOAM6_ID,
 	DEVCONF_IOAM6_ID_WIDE,
+	DEVCONF_NDISC_EVICT_NOCARRIER,
+	DEVCONF_ACCEPT_UNTRACKED_NA,
+	DEVCONF_ACCEPT_RA_MIN_LFT,
 	DEVCONF_MAX
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ecf4332ff312..a4be7c1c11aa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9570,7 +9570,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 	struct tnum enforce_attach_type_range = tnum_unknown;
 	const struct bpf_prog *prog = env->prog;
 	struct bpf_reg_state *reg;
-	struct tnum range = tnum_range(0, 1);
+	struct tnum range = tnum_range(0, 1), const_0 = tnum_const(0);
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	int err;
 	struct bpf_func_state *frame = env->cur_state->frame[0];
@@ -9608,8 +9608,8 @@ static int check_return_code(struct bpf_verifier_env *env)
 			return -EINVAL;
 		}
 
-		if (!tnum_in(tnum_const(0), reg->var_off)) {
-			verbose_invalid_scalar(env, reg, &range, "async callback", "R0");
+		if (!tnum_in(const_0, reg->var_off)) {
+			verbose_invalid_scalar(env, reg, &const_0, "async callback", "R0");
 			return -EINVAL;
 		}
 		return 0;
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index ee8b3d80f19e..1292bc844945 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -365,10 +365,9 @@ static int pidlist_array_load(struct cgroup *cgrp, enum cgroup_filetype type,
 	}
 	css_task_iter_end(&it);
 	length = n;
-	/* now sort & (if procs) strip out duplicates */
+	/* now sort & strip out duplicates (tgids or recycled thread PIDs) */
 	sort(array, length, sizeof(pid_t), cmppid, NULL);
-	if (type == CGROUP_FILE_PROCS)
-		length = pidlist_uniq(array, length);
+	length = pidlist_uniq(array, length);
 
 	l = cgroup_pidlist_find_create(cgrp, type);
 	if (!l) {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 02c91528127a..2324b7055260 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8725,7 +8725,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	 * PF_KTHREAD should already be set at this point; regardless, make it
 	 * look like a proper per-CPU kthread.
 	 */
-	idle->flags |= PF_KTHREAD | PF_NO_SETAFFINITY;
+	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 6b8d2169d9ea..499a3e286cd0 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -397,7 +397,6 @@ EXPORT_SYMBOL_GPL(play_idle_precise);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
-	current->flags |= PF_IDLE;
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
 	while (1)
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8e108c040cc3..19868cf58877 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5379,9 +5379,13 @@ static int workqueue_apply_unbound_cpumask(void)
 	list_for_each_entry(wq, &workqueues, list) {
 		if (!(wq->flags & WQ_UNBOUND))
 			continue;
+
 		/* creating multiple pwqs breaks ordering guarantee */
-		if (wq->flags & __WQ_ORDERED)
-			continue;
+		if (!list_empty(&wq->pwqs)) {
+			if (wq->flags & __WQ_ORDERED_EXPLICIT)
+				continue;
+			wq->flags &= ~__WQ_ORDERED;
+		}
 
 		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs);
 		if (!ctx) {
diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index 75638404ed57..0f1a3bd09b7b 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -86,7 +86,7 @@ static int __init test_pages(int *total_failures)
 	int failures = 0, num_tests = 0;
 	int i;
 
-	for (i = 0; i <= MAX_ORDER; i++)
+	for (i = 0; i < MAX_ORDER; i++)
 		num_tests += do_alloc_pages_order(i, &failures);
 
 	REPORT_FAILURES_IN_FN();
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9bf085ddbe51..043cdbb2d980 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -454,8 +454,8 @@ int ceph_tcp_connect(struct ceph_connection *con)
 	set_sock_callbacks(sock, con);
 
 	con_sock_state_connecting(con);
-	ret = sock->ops->connect(sock, (struct sockaddr *)&ss, sizeof(ss),
-				 O_NONBLOCK);
+	ret = kernel_connect(sock, (struct sockaddr *)&ss, sizeof(ss),
+			     O_NONBLOCK);
 	if (ret == -EINPROGRESS) {
 		dout("connect %s EINPROGRESS sk_state = %u\n",
 		     ceph_pr_addr(&con->peer_addr),
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 6572174e2115..441f60170c85 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -209,6 +209,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly = {
 	.ra_defrtr_metric	= IP6_RT_PRIO_USER,
 	.accept_ra_from_local	= 0,
 	.accept_ra_min_hop_limit= 1,
+	.accept_ra_min_lft	= 0,
 	.accept_ra_pinfo	= 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	= 1,
@@ -268,6 +269,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mostly = {
 	.ra_defrtr_metric	= IP6_RT_PRIO_USER,
 	.accept_ra_from_local	= 0,
 	.accept_ra_min_hop_limit= 1,
+	.accept_ra_min_lft	= 0,
 	.accept_ra_pinfo	= 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	= 1,
@@ -2734,6 +2736,9 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *opt, int len, bool sllao)
 		return;
 	}
 
+	if (valid_lft != 0 && valid_lft < in6_dev->cnf.accept_ra_min_lft)
+		goto put;
+
 	/*
 	 *	Two things going on here:
 	 *	1) Add routes for on-link prefixes
@@ -5589,6 +5594,7 @@ static inline void ipv6_store_devconf(struct ipv6_devconf *cnf,
 	array[DEVCONF_IOAM6_ENABLED] = cnf->ioam6_enabled;
 	array[DEVCONF_IOAM6_ID] = cnf->ioam6_id;
 	array[DEVCONF_IOAM6_ID_WIDE] = cnf->ioam6_id_wide;
+	array[DEVCONF_ACCEPT_RA_MIN_LFT] = cnf->accept_ra_min_lft;
 }
 
 static inline size_t inet6_ifla6_size(void)
@@ -6782,6 +6788,13 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "accept_ra_min_lft",
+		.data		= &ipv6_devconf.accept_ra_min_lft,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 	{
 		.procname	= "accept_ra_pinfo",
 		.data		= &ipv6_devconf.accept_ra_pinfo,
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 3ab903f7e0f8..856edbe81e11 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1270,6 +1270,14 @@ static void ndisc_router_discovery(struct sk_buff *skb)
 		goto skip_defrtr;
 	}
 
+	lifetime = ntohs(ra_msg->icmph.icmp6_rt_lifetime);
+	if (lifetime != 0 && lifetime < in6_dev->cnf.accept_ra_min_lft) {
+		ND_PRINTK(2, info,
+			  "RA: router lifetime (%ds) is too short: %s\n",
+			  lifetime, skb->dev->name);
+		goto skip_defrtr;
+	}
+
 	/* Do not accept RA with source-addr found on local machine unless
 	 * accept_ra_from_local is set to true.
 	 */
@@ -1282,8 +1290,6 @@ static void ndisc_router_discovery(struct sk_buff *skb)
 		goto skip_defrtr;
 	}
 
-	lifetime = ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	pref = ra_msg->icmph.icmp6_router_pref;
 	/* 10b is handled as if it were 00b (medium) */
@@ -1454,6 +1460,9 @@ static void ndisc_router_discovery(struct sk_buff *skb)
 			if (ri->prefix_len == 0 &&
 			    !in6_dev->cnf.accept_ra_defrtr)
 				continue;
+			if (ri->lifetime != 0 &&
+			    ntohl(ri->lifetime) < in6_dev->cnf.accept_ra_min_lft)
+				continue;
 			if (ri->prefix_len < in6_dev->cnf.accept_ra_rt_info_min_plen)
 				continue;
 			if (ri->prefix_len > in6_dev->cnf.accept_ra_rt_info_max_plen)
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 58100b3c38c9..0c061f94d695 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1441,7 +1441,7 @@ static int bind_mcastif_addr(struct socket *sock, struct net_device *dev)
 	sin.sin_addr.s_addr  = addr;
 	sin.sin_port         = 0;
 
-	return sock->ops->bind(sock, (struct sockaddr*)&sin, sizeof(sin));
+	return kernel_bind(sock, (struct sockaddr *)&sin, sizeof(sin));
 }
 
 static void get_mcast_sockaddr(union ipvs_sockaddr *sa, int *salen,
@@ -1548,7 +1548,7 @@ static int make_receive_sock(struct netns_ipvs *ipvs, int id,
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->bcfg, id);
 	sock->sk->sk_bound_dev_if = dev->ifindex;
-	result = sock->ops->bind(sock, (struct sockaddr *)&mcast_addr, salen);
+	result = kernel_bind(sock, (struct sockaddr *)&mcast_addr, salen);
 	if (result < 0) {
 		pr_err("Error binding to the multicast addr\n");
 		goto error;
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index b1107570eaee..92f70686bee0 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -205,17 +205,13 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
 
 		if (tmp_sock->ssap == ssap && tmp_sock->dsap == dsap) {
 			llcp_sock = tmp_sock;
+			sock_hold(&llcp_sock->sk);
 			break;
 		}
 	}
 
 	read_unlock(&local->sockets.lock);
 
-	if (llcp_sock == NULL)
-		return NULL;
-
-	sock_hold(&llcp_sock->sk);
-
 	return llcp_sock;
 }
 
@@ -348,7 +344,8 @@ static int nfc_llcp_wks_sap(const char *service_name, size_t service_name_len)
 
 static
 struct nfc_llcp_sock *nfc_llcp_sock_from_sn(struct nfc_llcp_local *local,
-					    const u8 *sn, size_t sn_len)
+					    const u8 *sn, size_t sn_len,
+					    bool needref)
 {
 	struct sock *sk;
 	struct nfc_llcp_sock *llcp_sock, *tmp_sock;
@@ -384,6 +381,8 @@ struct nfc_llcp_sock *nfc_llcp_sock_from_sn(struct nfc_llcp_local *local,
 
 		if (memcmp(sn, tmp_sock->service_name, sn_len) == 0) {
 			llcp_sock = tmp_sock;
+			if (needref)
+				sock_hold(&llcp_sock->sk);
 			break;
 		}
 	}
@@ -425,7 +424,8 @@ u8 nfc_llcp_get_sdp_ssap(struct nfc_llcp_local *local,
 		 * to this service name.
 		 */
 		if (nfc_llcp_sock_from_sn(local, sock->service_name,
-					  sock->service_name_len) != NULL) {
+					  sock->service_name_len,
+					  false) != NULL) {
 			mutex_unlock(&local->sdp_lock);
 
 			return LLCP_SAP_MAX;
@@ -833,16 +833,7 @@ static struct nfc_llcp_sock *nfc_llcp_connecting_sock_get(struct nfc_llcp_local
 static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 						  const u8 *sn, size_t sn_len)
 {
-	struct nfc_llcp_sock *llcp_sock;
-
-	llcp_sock = nfc_llcp_sock_from_sn(local, sn, sn_len);
-
-	if (llcp_sock == NULL)
-		return NULL;
-
-	sock_hold(&llcp_sock->sk);
-
-	return llcp_sock;
+	return nfc_llcp_sock_from_sn(local, sn, sn_len, true);
 }
 
 static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
@@ -1307,7 +1298,8 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 			}
 
 			llcp_sock = nfc_llcp_sock_from_sn(local, service_name,
-							  service_name_len);
+							  service_name_len,
+							  true);
 			if (!llcp_sock) {
 				sap = 0;
 				goto add_snl;
@@ -1327,6 +1319,7 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 
 				if (sap == LLCP_SAP_MAX) {
 					sap = 0;
+					nfc_llcp_sock_put(llcp_sock);
 					goto add_snl;
 				}
 
@@ -1344,6 +1337,7 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 
 			pr_debug("%p %d\n", llcp_sock, sap);
 
+			nfc_llcp_sock_put(llcp_sock);
 add_snl:
 			sdp = nfc_llcp_build_sdres_tlv(tid, sap);
 			if (sdp == NULL)
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 7b6cf9a44aea..643dfc90b063 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -908,6 +908,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
 		return -EINVAL;
 	}
 
+	if (protocol >= NFC_PROTO_MAX) {
+		pr_err("the requested nfc protocol is invalid\n");
+		return -EINVAL;
+	}
+
 	if (!(nci_target->supported_protocols & (1 << protocol))) {
 		pr_err("target does not support the requested protocol 0x%x\n",
 		       protocol);
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index 21351f9ef6a0..4ddd1fd6ed23 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -142,7 +142,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 		addrlen = sizeof(sin);
 	}
 
-	ret = sock->ops->bind(sock, addr, addrlen);
+	ret = kernel_bind(sock, addr, addrlen);
 	if (ret) {
 		rdsdebug("bind failed with %d at address %pI6c\n",
 			 ret, &conn->c_laddr);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 09cadd556d1e..3994eeef95a3 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -301,7 +301,7 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
 		addr_len = sizeof(*sin);
 	}
 
-	ret = sock->ops->bind(sock, (struct sockaddr *)&ss, addr_len);
+	ret = kernel_bind(sock, (struct sockaddr *)&ss, addr_len);
 	if (ret < 0) {
 		rdsdebug("could not bind %s listener socket: %d\n",
 			 isv6 ? "IPv6" : "IPv4", ret);
diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
index 84b7ecd8c05c..415131a975b1 100644
--- a/net/smc/smc_stats.h
+++ b/net/smc/smc_stats.h
@@ -93,13 +93,14 @@ do { \
 	typeof(_smc_stats) stats = (_smc_stats); \
 	typeof(_tech) t = (_tech); \
 	typeof(_len) l = (_len); \
-	int _pos = fls64((l) >> 13); \
+	int _pos; \
 	typeof(_rc) r = (_rc); \
 	int m = SMC_BUF_MAX - 1; \
 	this_cpu_inc((*stats).smc[t].key ## _cnt); \
-	if (r <= 0) \
+	if (r <= 0 || l <= 0) \
 		break; \
-	_pos = (_pos < m) ? ((l == 1 << (_pos + 12)) ? _pos - 1 : _pos) : m; \
+	_pos = fls64((l - 1) >> 13); \
+	_pos = (_pos <= m) ? _pos : m; \
 	this_cpu_inc((*stats).smc[t].key ## _pd.buf[_pos]); \
 	this_cpu_add((*stats).smc[t].key ## _bytes, r); \
 } \
@@ -139,9 +140,12 @@ while (0)
 do { \
 	typeof(_len) _l = (_len); \
 	typeof(_tech) t = (_tech); \
-	int _pos = fls((_l) >> 13); \
+	int _pos; \
 	int m = SMC_BUF_MAX - 1; \
-	_pos = (_pos < m) ? ((_l == 1 << (_pos + 12)) ? _pos - 1 : _pos) : m; \
+	if (_l <= 0) \
+		break; \
+	_pos = fls((_l - 1) >> 13); \
+	_pos = (_pos <= m) ? _pos : m; \
 	this_cpu_inc((*(_smc_stats)).smc[t].k ## _rmbsize.buf[_pos]); \
 } \
 while (0)
diff --git a/net/socket.c b/net/socket.c
index 66dde1293c4e..57c2b78b446b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3400,7 +3400,11 @@ static long compat_sock_ioctl(struct file *file, unsigned int cmd,
 
 int kernel_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 {
-	return sock->ops->bind(sock, addr, addrlen);
+	struct sockaddr_storage address;
+
+	memcpy(&address, addr, addrlen);
+
+	return sock->ops->bind(sock, (struct sockaddr *)&address, addrlen);
 }
 EXPORT_SYMBOL(kernel_bind);
 
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 9b9d3ef79cbe..386e5f6e368a 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -16,12 +16,17 @@
 #include <linux/key-type.h>
 #include <linux/module.h>
 #include <linux/parser.h>
+#include <linux/random.h>
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
 #include <linux/static_call.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
 
+static char *trusted_rng = "default";
+module_param_named(rng, trusted_rng, charp, 0);
+MODULE_PARM_DESC(rng, "Select trusted key RNG");
+
 static char *trusted_key_source;
 module_param_named(source, trusted_key_source, charp, 0);
 MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
@@ -35,13 +40,12 @@ static const struct trusted_key_source trusted_key_sources[] = {
 #endif
 };
 
-DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
 DEFINE_STATIC_CALL_NULL(trusted_key_seal, *trusted_key_sources[0].ops->seal);
 DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
 			*trusted_key_sources[0].ops->unseal);
 DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
 			*trusted_key_sources[0].ops->get_random);
-DEFINE_STATIC_CALL_NULL(trusted_key_exit, *trusted_key_sources[0].ops->exit);
+static void (*trusted_key_exit)(void);
 static unsigned char migratable;
 
 enum {
@@ -312,8 +316,14 @@ struct key_type key_type_trusted = {
 };
 EXPORT_SYMBOL_GPL(key_type_trusted);
 
+static int kernel_get_random(unsigned char *key, size_t key_len)
+{
+	return get_random_bytes_wait(key, key_len) ?: key_len;
+}
+
 static int __init init_trusted(void)
 {
+	int (*get_random)(unsigned char *key, size_t key_len);
 	int i, ret = 0;
 
 	for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
@@ -322,19 +332,38 @@ static int __init init_trusted(void)
 			    strlen(trusted_key_sources[i].name)))
 			continue;
 
-		static_call_update(trusted_key_init,
-				   trusted_key_sources[i].ops->init);
+		/*
+		 * We always support trusted.rng="kernel" and "default" as
+		 * well as trusted.rng=$trusted.source if the trust source
+		 * defines its own get_random callback.
+		 */
+		get_random = trusted_key_sources[i].ops->get_random;
+		if (trusted_rng && strcmp(trusted_rng, "default")) {
+			if (!strcmp(trusted_rng, "kernel")) {
+				get_random = kernel_get_random;
+			} else if (strcmp(trusted_rng, trusted_key_sources[i].name) ||
+				   !get_random) {
+				pr_warn("Unsupported RNG. Supported: kernel");
+				if (get_random)
+					pr_cont(", %s", trusted_key_sources[i].name);
+				pr_cont(", default\n");
+				return -EINVAL;
+			}
+		}
+
+		if (!get_random)
+			get_random = kernel_get_random;
+
 		static_call_update(trusted_key_seal,
 				   trusted_key_sources[i].ops->seal);
 		static_call_update(trusted_key_unseal,
 				   trusted_key_sources[i].ops->unseal);
 		static_call_update(trusted_key_get_random,
-				   trusted_key_sources[i].ops->get_random);
-		static_call_update(trusted_key_exit,
-				   trusted_key_sources[i].ops->exit);
+				   get_random);
+		trusted_key_exit = trusted_key_sources[i].ops->exit;
 		migratable = trusted_key_sources[i].ops->migratable;
 
-		ret = static_call(trusted_key_init)();
+		ret = trusted_key_sources[i].ops->init();
 		if (!ret)
 			break;
 	}
@@ -351,7 +380,8 @@ static int __init init_trusted(void)
 
 static void __exit cleanup_trusted(void)
 {
-	static_call_cond(trusted_key_exit)();
+	if (trusted_key_exit)
+		(*trusted_key_exit)();
 }
 
 late_initcall(init_trusted);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 8de572e774dd..6d87f58d1b00 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1725,7 +1725,11 @@ void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
 		/* mic works only when ep packet size is set to wMaxPacketSize */
 		fp->attributes |= UAC_EP_CS_ATTR_FILL_MAX;
 		break;
-
+	case USB_ID(0x3511, 0x2b1e): /* Opencomm2 UC USB Bluetooth dongle */
+		/* mic works only when ep pitch control is not set */
+		if (stream == SNDRV_PCM_STREAM_CAPTURE)
+			fp->attributes &= ~UAC_EP_CS_ATTR_PITCH_CONTROL;
+		break;
 	}
 }
 
