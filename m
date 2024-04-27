Return-Path: <linux-kernel+bounces-161091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E0B8B46EB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74B4282814
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C04200DD;
	Sat, 27 Apr 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zAdegb8u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FAA1EA90;
	Sat, 27 Apr 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714233299; cv=none; b=Uc7eVeHPODzdwhXjC/09zOgCDK5TlLmGZNTaQDh2F5X5Q/6rtnmFizGXiAbFzT+fWUH725XATuYT5XRpo9nT7pBD4nOQ8Dv5tH2Mo94/spxCQX1HMxccYQWRVIz5k74G7viwyVSa0dLgkhO75RYnlvIJJ2hpb/OJlir7Siomzto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714233299; c=relaxed/simple;
	bh=fadEK4C+CmNqmFKM8ACfLXFwmyjlOk5pt9t2Ap20JNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzwIRnKXvzxc8bKiyLBnmcs7YdSVFV2o9np6q9uOeOBoH4LV7PLykjHiUG645ea9bLsH43uuDCd7/rwkxYrnYs/NiX03/4LpHIpOJU6GuJPoNXAXnbeIHNyKSKnhW0Ej8TpaClBAdgQW37SFCXsZBnmc/iAOrEO/FBdDgvs/zkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zAdegb8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FE7C113CE;
	Sat, 27 Apr 2024 15:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714233299;
	bh=fadEK4C+CmNqmFKM8ACfLXFwmyjlOk5pt9t2Ap20JNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zAdegb8uE91ZBewELqvMdYDeanYtrg8LCx4Qoncx1oOmibda/PiwMuX5Yk9Wi8uMN
	 ESXAxUuavc8XTjFpMDADGcaKLMHyBTjiPctyWgmsGi8wwP9BmrpZUgAKod9lzKqsKL
	 xowKqEXWTig2EPQusQGrtPm7mxa/iP+NY+KUH/BM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.157
Date: Sat, 27 Apr 2024 17:54:48 +0200
Message-ID: <2024042748-stunt-reanalyze-0be0@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024042748-unleaded-fracture-1ab8@gregkh>
References: <2024042748-unleaded-fracture-1ab8@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index 6a1cbd7de38d..6f59a364f84c 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -241,10 +241,3 @@ following flags are defined:
     all of an inode's dirty data on last close. Exports that behave this
     way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
     waiting for writeback when closing such files.
-
-  EXPORT_OP_ASYNC_LOCK - Indicates a capable filesystem to do async lock
-    requests from lockd. Only set EXPORT_OP_ASYNC_LOCK if the filesystem has
-    it's own ->lock() functionality as core posix_lock_file() implementation
-    has no async lock request handling yet. For more information about how to
-    indicate an async lock request from a ->lock() file_operations struct, see
-    fs/locks.c and comment for the function vfs_lock_file().
diff --git a/Makefile b/Makefile
index 30680c037e1d..013b68ef0c3f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 156
+SUBLEVEL = 157
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index a3bacd79507a..f0779d0f349d 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -211,9 +211,6 @@ bool kernel_page_present(struct page *page)
 	pte_t *ptep;
 	unsigned long addr = (unsigned long)page_address(page);
 
-	if (!can_set_direct_map())
-		return true;
-
 	pgdp = pgd_offset_k(addr);
 	if (pgd_none(READ_ONCE(*pgdp)))
 		return false;
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 08cfc26ee7c6..f779facd8246 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -732,6 +732,7 @@ struct kvm_vcpu_arch {
 
 	int cpuid_nent;
 	struct kvm_cpuid_entry2 *cpuid_entries;
+	bool is_amd_compatible;
 
 	u64 reserved_gpa_bits;
 	int maxphyaddr;
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b30b32b288dd..247545b57dff 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1629,7 +1629,8 @@ static void __init bhi_select_mitigation(void)
 		return;
 
 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
+	    !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
 		spec_ctrl_disable_kernel_rrsba();
 		if (rrsba_disabled)
 			return;
@@ -2783,11 +2784,13 @@ static const char *spectre_bhi_state(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_BHI))
 		return "; BHI: Not affected";
-	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_HW))
+	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_HW))
 		return "; BHI: BHI_DIS_S";
-	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
+	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
-	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) && rrsba_disabled)
+	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
+		 !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE) &&
+		 rrsba_disabled)
 		return "; BHI: Retpoline";
 	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
 		return "; BHI: Vulnerable, KVM: SW loop";
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index defda61f372d..2161676577f2 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -44,7 +44,10 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_F16C,			X86_FEATURE_XMM2,     },
 	{ X86_FEATURE_AES,			X86_FEATURE_XMM2      },
 	{ X86_FEATURE_SHA_NI,			X86_FEATURE_XMM2      },
+	{ X86_FEATURE_GFNI,			X86_FEATURE_XMM2      },
 	{ X86_FEATURE_FMA,			X86_FEATURE_AVX       },
+	{ X86_FEATURE_VAES,			X86_FEATURE_AVX       },
+	{ X86_FEATURE_VPCLMULQDQ,		X86_FEATURE_AVX       },
 	{ X86_FEATURE_AVX2,			X86_FEATURE_AVX,      },
 	{ X86_FEATURE_AVX512F,			X86_FEATURE_AVX,      },
 	{ X86_FEATURE_AVX512IFMA,		X86_FEATURE_AVX512F   },
@@ -56,9 +59,6 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512VL,			X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512VBMI,		X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_VBMI2,		X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_GFNI,			X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_VAES,			X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_VPCLMULQDQ,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_VNNI,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_BITALG,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_4VNNIW,		X86_FEATURE_AVX512F   },
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 537e826205ce..6222aa3221f5 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -189,6 +189,7 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 	kvm_update_pv_runtime(vcpu);
 
+	vcpu->arch.is_amd_compatible = guest_cpuid_is_amd_or_hygon(vcpu);
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
 	vcpu->arch.reserved_gpa_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu);
 
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index c99edfff7f82..3c0b2dddc989 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -121,6 +121,16 @@ static inline bool guest_cpuid_is_intel(struct kvm_vcpu *vcpu)
 	return best && is_guest_vendor_intel(best->ebx, best->ecx, best->edx);
 }
 
+static inline bool guest_cpuid_is_amd_compatible(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.is_amd_compatible;
+}
+
+static inline bool guest_cpuid_is_intel_compatible(struct kvm_vcpu *vcpu)
+{
+	return !guest_cpuid_is_amd_compatible(vcpu);
+}
+
 static inline int guest_cpuid_family(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best;
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index b5b20078a413..8d0eaad7a759 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2419,7 +2419,8 @@ int kvm_apic_local_deliver(struct kvm_lapic *apic, int lvt_type)
 		trig_mode = reg & APIC_LVT_LEVEL_TRIGGER;
 
 		r = __apic_accept_irq(apic, mode, vector, 1, trig_mode, NULL);
-		if (r && lvt_type == APIC_LVTPC)
+		if (r && lvt_type == APIC_LVTPC &&
+		    guest_cpuid_is_intel_compatible(apic->vcpu))
 			kvm_lapic_set_reg(apic, APIC_LVTPC, reg | APIC_LVT_MASKED);
 		return r;
 	}
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4724289c8a7f..acb9193fc06a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4351,7 +4351,7 @@ static void reset_rsvds_bits_mask(struct kvm_vcpu *vcpu,
 				context->root_level, is_efer_nx(context),
 				guest_can_use_gbpages(vcpu),
 				is_cr4_pse(context),
-				guest_cpuid_is_amd_or_hygon(vcpu));
+				guest_cpuid_is_amd_compatible(vcpu));
 }
 
 static void
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 57a1484e257f..f781ba5d421d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3107,7 +3107,7 @@ static void kvmclock_sync_fn(struct work_struct *work)
 static bool can_set_mci_status(struct kvm_vcpu *vcpu)
 {
 	/* McStatusWrEn enabled? */
-	if (guest_cpuid_is_amd_or_hygon(vcpu))
+	if (guest_cpuid_is_amd_compatible(vcpu))
 		return !!(vcpu->arch.msr_hwcr & BIT_ULL(18));
 
 	return false;
diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index 7b2016534162..b70489d998d7 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -573,7 +573,7 @@ static u_long get_word(struct vc_data *vc)
 	}
 	attr_ch = get_char(vc, (u_short *)tmp_pos, &spk_attr);
 	buf[cnt++] = attr_ch;
-	while (tmpx < vc->vc_cols - 1) {
+	while (tmpx < vc->vc_cols - 1 && cnt < sizeof(buf) - 1) {
 		tmp_pos += 2;
 		tmpx++;
 		ch = get_char(vc, (u_short *)tmp_pos, &temp);
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 7547c4ed265c..11d65e23f1b6 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1678,8 +1678,10 @@ static size_t binder_get_object(struct binder_proc *proc,
 	size_t object_size = 0;
 
 	read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
-	if (offset > buffer->data_size || read_size < sizeof(*hdr))
+	if (offset > buffer->data_size || read_size < sizeof(*hdr) ||
+	    !IS_ALIGNED(offset, sizeof(u32)))
 		return 0;
+
 	if (u) {
 		if (copy_from_user(object, u + offset, read_size))
 			return 0;
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 84397af4fb33..a05b5bca6425 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -37,7 +37,11 @@ static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
 static LIST_HEAD(clk_notifier_list);
 
-static struct hlist_head *all_lists[] = {
+/* List of registered clks that use runtime PM */
+static HLIST_HEAD(clk_rpm_list);
+static DEFINE_MUTEX(clk_rpm_list_lock);
+
+static const struct hlist_head *all_lists[] = {
 	&clk_root_list,
 	&clk_orphan_list,
 	NULL,
@@ -59,6 +63,7 @@ struct clk_core {
 	struct clk_hw		*hw;
 	struct module		*owner;
 	struct device		*dev;
+	struct hlist_node	rpm_node;
 	struct device_node	*of_node;
 	struct clk_core		*parent;
 	struct clk_parent_map	*parents;
@@ -129,6 +134,89 @@ static void clk_pm_runtime_put(struct clk_core *core)
 	pm_runtime_put_sync(core->dev);
 }
 
+/**
+ * clk_pm_runtime_get_all() - Runtime "get" all clk provider devices
+ *
+ * Call clk_pm_runtime_get() on all runtime PM enabled clks in the clk tree so
+ * that disabling unused clks avoids a deadlock where a device is runtime PM
+ * resuming/suspending and the runtime PM callback is trying to grab the
+ * prepare_lock for something like clk_prepare_enable() while
+ * clk_disable_unused_subtree() holds the prepare_lock and is trying to runtime
+ * PM resume/suspend the device as well.
+ *
+ * Context: Acquires the 'clk_rpm_list_lock' and returns with the lock held on
+ * success. Otherwise the lock is released on failure.
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+static int clk_pm_runtime_get_all(void)
+{
+	int ret;
+	struct clk_core *core, *failed;
+
+	/*
+	 * Grab the list lock to prevent any new clks from being registered
+	 * or unregistered until clk_pm_runtime_put_all().
+	 */
+	mutex_lock(&clk_rpm_list_lock);
+
+	/*
+	 * Runtime PM "get" all the devices that are needed for the clks
+	 * currently registered. Do this without holding the prepare_lock, to
+	 * avoid the deadlock.
+	 */
+	hlist_for_each_entry(core, &clk_rpm_list, rpm_node) {
+		ret = clk_pm_runtime_get(core);
+		if (ret) {
+			failed = core;
+			pr_err("clk: Failed to runtime PM get '%s' for clk '%s'\n",
+			       dev_name(failed->dev), failed->name);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	hlist_for_each_entry(core, &clk_rpm_list, rpm_node) {
+		if (core == failed)
+			break;
+
+		clk_pm_runtime_put(core);
+	}
+	mutex_unlock(&clk_rpm_list_lock);
+
+	return ret;
+}
+
+/**
+ * clk_pm_runtime_put_all() - Runtime "put" all clk provider devices
+ *
+ * Put the runtime PM references taken in clk_pm_runtime_get_all() and release
+ * the 'clk_rpm_list_lock'.
+ */
+static void clk_pm_runtime_put_all(void)
+{
+	struct clk_core *core;
+
+	hlist_for_each_entry(core, &clk_rpm_list, rpm_node)
+		clk_pm_runtime_put(core);
+	mutex_unlock(&clk_rpm_list_lock);
+}
+
+static void clk_pm_runtime_init(struct clk_core *core)
+{
+	struct device *dev = core->dev;
+
+	if (dev && pm_runtime_enabled(dev)) {
+		core->rpm_enabled = true;
+
+		mutex_lock(&clk_rpm_list_lock);
+		hlist_add_head(&core->rpm_node, &clk_rpm_list);
+		mutex_unlock(&clk_rpm_list_lock);
+	}
+}
+
 /***           locking             ***/
 static void clk_prepare_lock(void)
 {
@@ -1252,9 +1340,6 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 	if (core->flags & CLK_IGNORE_UNUSED)
 		return;
 
-	if (clk_pm_runtime_get(core))
-		return;
-
 	if (clk_core_is_prepared(core)) {
 		trace_clk_unprepare(core);
 		if (core->ops->unprepare_unused)
@@ -1263,8 +1348,6 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 			core->ops->unprepare(core->hw);
 		trace_clk_unprepare_complete(core);
 	}
-
-	clk_pm_runtime_put(core);
 }
 
 static void __init clk_disable_unused_subtree(struct clk_core *core)
@@ -1280,9 +1363,6 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
 		clk_core_prepare_enable(core->parent);
 
-	if (clk_pm_runtime_get(core))
-		goto unprepare_out;
-
 	flags = clk_enable_lock();
 
 	if (core->enable_count)
@@ -1307,8 +1387,6 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 
 unlock_out:
 	clk_enable_unlock(flags);
-	clk_pm_runtime_put(core);
-unprepare_out:
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
 		clk_core_disable_unprepare(core->parent);
 }
@@ -1324,12 +1402,22 @@ __setup("clk_ignore_unused", clk_ignore_unused_setup);
 static int __init clk_disable_unused(void)
 {
 	struct clk_core *core;
+	int ret;
 
 	if (clk_ignore_unused) {
 		pr_warn("clk: Not disabling unused clocks\n");
 		return 0;
 	}
 
+	pr_info("clk: Disabling unused clocks\n");
+
+	ret = clk_pm_runtime_get_all();
+	if (ret)
+		return ret;
+	/*
+	 * Grab the prepare lock to keep the clk topology stable while iterating
+	 * over clks.
+	 */
 	clk_prepare_lock();
 
 	hlist_for_each_entry(core, &clk_root_list, child_node)
@@ -1346,6 +1434,8 @@ static int __init clk_disable_unused(void)
 
 	clk_prepare_unlock();
 
+	clk_pm_runtime_put_all();
+
 	return 0;
 }
 late_initcall_sync(clk_disable_unused);
@@ -3652,9 +3742,6 @@ static int __clk_core_init(struct clk_core *core)
 	}
 
 	clk_core_reparent_orphans_nolock();
-
-
-	kref_init(&core->ref);
 out:
 	clk_pm_runtime_put(core);
 unlock:
@@ -3883,6 +3970,22 @@ static void clk_core_free_parent_map(struct clk_core *core)
 	kfree(core->parents);
 }
 
+/* Free memory allocated for a struct clk_core */
+static void __clk_release(struct kref *ref)
+{
+	struct clk_core *core = container_of(ref, struct clk_core, ref);
+
+	if (core->rpm_enabled) {
+		mutex_lock(&clk_rpm_list_lock);
+		hlist_del(&core->rpm_node);
+		mutex_unlock(&clk_rpm_list_lock);
+	}
+
+	clk_core_free_parent_map(core);
+	kfree_const(core->name);
+	kfree(core);
+}
+
 static struct clk *
 __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 {
@@ -3903,6 +4006,8 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 		goto fail_out;
 	}
 
+	kref_init(&core->ref);
+
 	core->name = kstrdup_const(init->name, GFP_KERNEL);
 	if (!core->name) {
 		ret = -ENOMEM;
@@ -3915,9 +4020,8 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 	}
 	core->ops = init->ops;
 
-	if (dev && pm_runtime_enabled(dev))
-		core->rpm_enabled = true;
 	core->dev = dev;
+	clk_pm_runtime_init(core);
 	core->of_node = np;
 	if (dev && dev->driver)
 		core->owner = dev->driver->owner;
@@ -3957,12 +4061,10 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 	hw->clk = NULL;
 
 fail_create_clk:
-	clk_core_free_parent_map(core);
 fail_parents:
 fail_ops:
-	kfree_const(core->name);
 fail_name:
-	kfree(core);
+	kref_put(&core->ref, __clk_release);
 fail_out:
 	return ERR_PTR(ret);
 }
@@ -4042,18 +4144,6 @@ int of_clk_hw_register(struct device_node *node, struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(of_clk_hw_register);
 
-/* Free memory allocated for a clock. */
-static void __clk_release(struct kref *ref)
-{
-	struct clk_core *core = container_of(ref, struct clk_core, ref);
-
-	lockdep_assert_held(&prepare_lock);
-
-	clk_core_free_parent_map(core);
-	kfree_const(core->name);
-	kfree(core);
-}
-
 /*
  * Empty clk_ops for unregistered clocks. These are used temporarily
  * after clk_unregister() was called on a clock and until last clock
@@ -4106,7 +4196,7 @@ static void clk_core_evict_parent_cache_subtree(struct clk_core *root,
 /* Remove this clk from all parent caches */
 static void clk_core_evict_parent_cache(struct clk_core *core)
 {
-	struct hlist_head **lists;
+	const struct hlist_head **lists;
 	struct clk_core *root;
 
 	lockdep_assert_held(&prepare_lock);
diff --git a/drivers/comedi/drivers/vmk80xx.c b/drivers/comedi/drivers/vmk80xx.c
index 9a1d146b7ebb..07d10373b954 100644
--- a/drivers/comedi/drivers/vmk80xx.c
+++ b/drivers/comedi/drivers/vmk80xx.c
@@ -642,33 +642,22 @@ static int vmk80xx_find_usb_endpoints(struct comedi_device *dev)
 	struct vmk80xx_private *devpriv = dev->private;
 	struct usb_interface *intf = comedi_to_usb_interface(dev);
 	struct usb_host_interface *iface_desc = intf->cur_altsetting;
-	struct usb_endpoint_descriptor *ep_desc;
-	int i;
-
-	if (iface_desc->desc.bNumEndpoints != 2)
-		return -ENODEV;
-
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
-		ep_desc = &iface_desc->endpoint[i].desc;
-
-		if (usb_endpoint_is_int_in(ep_desc) ||
-		    usb_endpoint_is_bulk_in(ep_desc)) {
-			if (!devpriv->ep_rx)
-				devpriv->ep_rx = ep_desc;
-			continue;
-		}
+	struct usb_endpoint_descriptor *ep_rx_desc, *ep_tx_desc;
+	int ret;
 
-		if (usb_endpoint_is_int_out(ep_desc) ||
-		    usb_endpoint_is_bulk_out(ep_desc)) {
-			if (!devpriv->ep_tx)
-				devpriv->ep_tx = ep_desc;
-			continue;
-		}
-	}
+	if (devpriv->model == VMK8061_MODEL)
+		ret = usb_find_common_endpoints(iface_desc, &ep_rx_desc,
+						&ep_tx_desc, NULL, NULL);
+	else
+		ret = usb_find_common_endpoints(iface_desc, NULL, NULL,
+						&ep_rx_desc, &ep_tx_desc);
 
-	if (!devpriv->ep_rx || !devpriv->ep_tx)
+	if (ret)
 		return -ENODEV;
 
+	devpriv->ep_rx = ep_rx_desc;
+	devpriv->ep_tx = ep_tx_desc;
+
 	if (!usb_endpoint_maxp(devpriv->ep_rx) || !usb_endpoint_maxp(devpriv->ep_tx))
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0e4554950e07..b2192b21691e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2306,6 +2306,37 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
 }
 
+/* Validate operation parameters to prevent potential abuse */
+static int amdgpu_vm_verify_parameters(struct amdgpu_device *adev,
+					  struct amdgpu_bo *bo,
+					  uint64_t saddr,
+					  uint64_t offset,
+					  uint64_t size)
+{
+	uint64_t tmp, lpfn;
+
+	if (saddr & AMDGPU_GPU_PAGE_MASK
+	    || offset & AMDGPU_GPU_PAGE_MASK
+	    || size & AMDGPU_GPU_PAGE_MASK)
+		return -EINVAL;
+
+	if (check_add_overflow(saddr, size, &tmp)
+	    || check_add_overflow(offset, size, &tmp)
+	    || size == 0 /* which also leads to end < begin */)
+		return -EINVAL;
+
+	/* make sure object fit at this offset */
+	if (bo && offset + size > amdgpu_bo_size(bo))
+		return -EINVAL;
+
+	/* Ensure last pfn not exceed max_pfn */
+	lpfn = (saddr + size - 1) >> AMDGPU_GPU_PAGE_SHIFT;
+	if (lpfn >= adev->vm_manager.max_pfn)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * amdgpu_vm_bo_map - map bo inside a vm
  *
@@ -2332,21 +2363,14 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 	struct amdgpu_bo *bo = bo_va->base.bo;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	uint64_t eaddr;
+	int r;
 
-	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
-		return -EINVAL;
-	if (saddr + size <= saddr || offset + size <= offset)
-		return -EINVAL;
-
-	/* make sure object fit at this offset */
-	eaddr = saddr + size - 1;
-	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
-	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
-		return -EINVAL;
+	r = amdgpu_vm_verify_parameters(adev, bo, saddr, offset, size);
+	if (r)
+		return r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
+	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
 
 	tmp = amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
 	if (tmp) {
@@ -2399,17 +2423,9 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	uint64_t eaddr;
 	int r;
 
-	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
-		return -EINVAL;
-	if (saddr + size <= saddr || offset + size <= offset)
-		return -EINVAL;
-
-	/* make sure object fit at this offset */
-	eaddr = saddr + size - 1;
-	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
-	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
-		return -EINVAL;
+	r = amdgpu_vm_verify_parameters(adev, bo, saddr, offset, size);
+	if (r)
+		return r;
 
 	/* Allocate all the needed memory */
 	mapping = kmalloc(sizeof(*mapping), GFP_KERNEL);
@@ -2423,7 +2439,7 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	}
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
+	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
 
 	mapping->start = saddr;
 	mapping->last = eaddr;
@@ -2510,10 +2526,14 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *before, *after, *tmp, *next;
 	LIST_HEAD(removed);
 	uint64_t eaddr;
+	int r;
+
+	r = amdgpu_vm_verify_parameters(adev, NULL, saddr, 0, size);
+	if (r)
+		return r;
 
-	eaddr = saddr + size - 1;
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
+	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
 
 	/* Allocate all the needed memory */
 	before = kzalloc(sizeof(*before), GFP_KERNEL);
diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
index e8c445eb1100..f63ceb8d3e4e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bios.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
@@ -23,6 +23,7 @@
  */
 
 #include "nouveau_drv.h"
+#include "nouveau_bios.h"
 #include "nouveau_reg.h"
 #include "dispnv04/hw.h"
 #include "nouveau_encoder.h"
@@ -1675,7 +1676,7 @@ apply_dcb_encoder_quirks(struct drm_device *dev, int idx, u32 *conn, u32 *conf)
 	 */
 	if (nv_match_device(dev, 0x0201, 0x1462, 0x8851)) {
 		if (*conn == 0xf2005014 && *conf == 0xffffffff) {
-			fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 1, 1, 1);
+			fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 1, 1, DCB_OUTPUT_B);
 			return false;
 		}
 	}
@@ -1761,26 +1762,26 @@ fabricate_dcb_encoder_table(struct drm_device *dev, struct nvbios *bios)
 #ifdef __powerpc__
 	/* Apple iMac G4 NV17 */
 	if (of_machine_is_compatible("PowerMac4,5")) {
-		fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 0, all_heads, 1);
-		fabricate_dcb_output(dcb, DCB_OUTPUT_ANALOG, 1, all_heads, 2);
+		fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 0, all_heads, DCB_OUTPUT_B);
+		fabricate_dcb_output(dcb, DCB_OUTPUT_ANALOG, 1, all_heads, DCB_OUTPUT_C);
 		return;
 	}
 #endif
 
 	/* Make up some sane defaults */
 	fabricate_dcb_output(dcb, DCB_OUTPUT_ANALOG,
-			     bios->legacy.i2c_indices.crt, 1, 1);
+			     bios->legacy.i2c_indices.crt, 1, DCB_OUTPUT_B);
 
 	if (nv04_tv_identify(dev, bios->legacy.i2c_indices.tv) >= 0)
 		fabricate_dcb_output(dcb, DCB_OUTPUT_TV,
 				     bios->legacy.i2c_indices.tv,
-				     all_heads, 0);
+				     all_heads, DCB_OUTPUT_A);
 
 	else if (bios->tmds.output0_script_ptr ||
 		 bios->tmds.output1_script_ptr)
 		fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS,
 				     bios->legacy.i2c_indices.panel,
-				     all_heads, 1);
+				     all_heads, DCB_OUTPUT_B);
 }
 
 static int
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
index c51bac76174c..9fe5b6a36ab9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
@@ -221,8 +221,11 @@ nv50_instobj_acquire(struct nvkm_memory *memory)
 	void __iomem *map = NULL;
 
 	/* Already mapped? */
-	if (refcount_inc_not_zero(&iobj->maps))
+	if (refcount_inc_not_zero(&iobj->maps)) {
+		/* read barrier match the wmb on refcount set */
+		smp_rmb();
 		return iobj->map;
+	}
 
 	/* Take the lock, and re-check that another thread hasn't
 	 * already mapped the object in the meantime.
@@ -249,6 +252,8 @@ nv50_instobj_acquire(struct nvkm_memory *memory)
 			iobj->base.memory.ptrs = &nv50_instobj_fast;
 		else
 			iobj->base.memory.ptrs = &nv50_instobj_slow;
+		/* barrier to ensure the ptrs are written before refcount is set */
+		smp_wmb();
 		refcount_set(&iobj->maps, 1);
 	}
 
diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index eb43503ec97b..6134432e4918 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -261,8 +261,6 @@ static int visionox_rm69299_remove(struct mipi_dsi_device *dsi)
 	struct visionox_rm69299 *ctx = mipi_dsi_get_drvdata(dsi);
 
 	mipi_dsi_detach(ctx->dsi);
-	mipi_dsi_device_unregister(ctx->dsi);
-
 	drm_panel_remove(&ctx->panel);
 	return 0;
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 8c8ee87fd3ac..23c2dc943caf 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -246,10 +246,10 @@ struct vmw_framebuffer_bo {
 
 
 static const uint32_t __maybe_unused vmw_primary_plane_formats[] = {
-	DRM_FORMAT_XRGB1555,
-	DRM_FORMAT_RGB565,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_XRGB1555,
 };
 
 static const uint32_t __maybe_unused vmw_cursor_plane_formats[] = {
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 504e1adf1997..c8a7fe5fbc23 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1033,23 +1033,26 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
 	}
 }
 
-static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id)
+static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id,
+						enum ib_cm_state old_state)
 {
 	struct cm_id_private *cm_id_priv;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	pr_err("%s: cm_id=%p timed out. state=%d refcnt=%d\n", __func__,
-	       cm_id, cm_id->state, refcount_read(&cm_id_priv->refcount));
+	pr_err("%s: cm_id=%p timed out. state %d -> %d, refcnt=%d\n", __func__,
+	       cm_id, old_state, cm_id->state, refcount_read(&cm_id_priv->refcount));
 }
 
 static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 {
 	struct cm_id_private *cm_id_priv;
+	enum ib_cm_state old_state;
 	struct cm_work *work;
 	int ret;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	spin_lock_irq(&cm_id_priv->lock);
+	old_state = cm_id->state;
 retest:
 	switch (cm_id->state) {
 	case IB_CM_LISTEN:
@@ -1158,7 +1161,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 						  msecs_to_jiffies(
 						  CM_DESTROY_ID_WAIT_TIMEOUT));
 		if (!ret) /* timeout happened */
-			cm_destroy_id_wait_timeout(cm_id);
+			cm_destroy_id_wait_timeout(cm_id, old_state);
 	} while (!ret);
 
 	while ((work = cm_dequeue_work(cm_id_priv)) != NULL)
diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index f6f2df855c2e..108284180775 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -166,7 +166,8 @@ static int process_pma_cmd(struct mlx5_ib_dev *dev, u32 port_num,
 		mdev = dev->mdev;
 		mdev_port_num = 1;
 	}
-	if (MLX5_CAP_GEN(dev->mdev, num_ports) == 1) {
+	if (MLX5_CAP_GEN(dev->mdev, num_ports) == 1 &&
+	    !mlx5_core_mp_enabled(mdev)) {
 		/* set local port to one for Function-Per-Port HCA. */
 		mdev = dev->mdev;
 		mdev_port_num = 1;
diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 8e0f9c489cab..f6ef782ce75c 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -35,6 +35,8 @@ void rxe_dealloc(struct ib_device *ib_dev)
 
 	if (rxe->tfm)
 		crypto_free_shash(rxe->tfm);
+
+	mutex_destroy(&rxe->usdev_lock);
 }
 
 /* initialize rxe device parameters */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 91586d8afcaa..2809338a5c3a 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -115,7 +115,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ADP_P, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ADP_N, MEI_ME_PCH15_CFG)},
 
-	{MEI_PCI_DEVICE(MEI_DEV_ID_RPL_S, MEI_ME_PCH15_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_RPL_S, MEI_ME_PCH15_SPS_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_MTL_M, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_S, MEI_ME_PCH15_CFG)},
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index f291d1e70f80..86db6a18c837 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -415,6 +415,20 @@ static void mt7530_pll_setup(struct mt7530_priv *priv)
 	core_set(priv, CORE_TRGMII_GSW_CLK_CG, REG_GSWCK_EN);
 }
 
+/* If port 6 is available as a CPU port, always prefer that as the default,
+ * otherwise don't care.
+ */
+static struct dsa_port *
+mt753x_preferred_default_local_cpu_port(struct dsa_switch *ds)
+{
+	struct dsa_port *cpu_dp = dsa_to_port(ds, 6);
+
+	if (dsa_port_is_cpu(cpu_dp))
+		return cpu_dp;
+
+	return NULL;
+}
+
 /* Setup port 6 interface mode and TRGMII TX circuit */
 static int
 mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
@@ -1232,6 +1246,13 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
 		mt7530_rmw(priv, MT7530_MFC, CPU_MASK, CPU_EN | CPU_PORT(port));
 
+	/* Add the CPU port to the CPU port bitmap for MT7531. Trapped frames
+	 * will be forwarded to the CPU port that is affine to the inbound user
+	 * port.
+	 */
+	if (priv->id == ID_MT7531)
+		mt7530_set(priv, MT7531_CFC, MT7531_CPU_PMAP(BIT(port)));
+
 	/* CPU port gets connected to all user ports of
 	 * the switch.
 	 */
@@ -2389,8 +2410,6 @@ mt7530_setup(struct dsa_switch *ds)
 		     SYS_CTRL_PHY_RST | SYS_CTRL_SW_RST |
 		     SYS_CTRL_REG_RST);
 
-	mt7530_pll_setup(priv);
-
 	/* Lower Tx driving for TRGMII path */
 	for (i = 0; i < NUM_TRGMII_CTRL; i++)
 		mt7530_write(priv, MT7530_TRGMII_TD_ODT(i),
@@ -2408,6 +2427,9 @@ mt7530_setup(struct dsa_switch *ds)
 
 	priv->p6_interface = PHY_INTERFACE_MODE_NA;
 
+	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_40MHZ)
+		mt7530_pll_setup(priv);
+
 	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
@@ -2437,6 +2459,9 @@ mt7530_setup(struct dsa_switch *ds)
 			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
 	}
 
+	/* Allow mirroring frames received on the local port (monitor port). */
+	mt7530_set(priv, MT753X_AGC, LOCAL_EN);
+
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
 	ret = mt7530_setup_vlan0(priv);
 	if (ret)
@@ -2507,16 +2532,8 @@ static int
 mt7531_setup_common(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
-	struct dsa_port *cpu_dp;
 	int ret, i;
 
-	/* BPDU to CPU port */
-	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
-		mt7530_rmw(priv, MT7531_CFC, MT7531_CPU_PMAP_MASK,
-			   BIT(cpu_dp->index));
-		break;
-	}
-
 	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
@@ -2553,6 +2570,9 @@ mt7531_setup_common(struct dsa_switch *ds)
 			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
 	}
 
+	/* Allow mirroring frames received on the local port (monitor port). */
+	mt7530_set(priv, MT753X_AGC, LOCAL_EN);
+
 	/* Flush the FDB table */
 	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
 	if (ret < 0)
@@ -2567,7 +2587,7 @@ mt7531_setup(struct dsa_switch *ds)
 	struct mt7530_priv *priv = ds->priv;
 	struct mt7530_dummy_poll p;
 	u32 val, id;
-	int ret;
+	int ret, i;
 
 	/* Reset whole chip through gpio pin or memory-mapped registers for
 	 * different type of hardware
@@ -2627,18 +2647,25 @@ mt7531_setup(struct dsa_switch *ds)
 	priv->p5_interface = PHY_INTERFACE_MODE_NA;
 	priv->p6_interface = PHY_INTERFACE_MODE_NA;
 
-	/* Enable PHY core PLL, since phy_device has not yet been created
-	 * provided for phy_[read,write]_mmd_indirect is called, we provide
-	 * our own mt7531_ind_mmd_phy_[read,write] to complete this
-	 * function.
+	/* Enable Energy-Efficient Ethernet (EEE) and PHY core PLL, since
+	 * phy_device has not yet been created provided for
+	 * phy_[read,write]_mmd_indirect is called, we provide our own
+	 * mt7531_ind_mmd_phy_[read,write] to complete this function.
 	 */
 	val = mt7531_ind_c45_phy_read(priv, MT753X_CTRL_PHY_ADDR,
 				      MDIO_MMD_VEND2, CORE_PLL_GROUP4);
-	val |= MT7531_PHY_PLL_BYPASS_MODE;
+	val |= MT7531_RG_SYSPLL_DMY2 | MT7531_PHY_PLL_BYPASS_MODE;
 	val &= ~MT7531_PHY_PLL_OFF;
 	mt7531_ind_c45_phy_write(priv, MT753X_CTRL_PHY_ADDR, MDIO_MMD_VEND2,
 				 CORE_PLL_GROUP4, val);
 
+	/* Disable EEE advertisement on the switch PHYs. */
+	for (i = MT753X_CTRL_PHY_ADDR;
+	     i < MT753X_CTRL_PHY_ADDR + MT7530_NUM_PHYS; i++) {
+		mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
+					 0);
+	}
+
 	mt7531_setup_common(ds);
 
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
@@ -3376,6 +3403,7 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
 static const struct dsa_switch_ops mt7530_switch_ops = {
 	.get_tag_protocol	= mtk_get_tag_protocol,
 	.setup			= mt753x_setup,
+	.preferred_default_local_cpu_port = mt753x_preferred_default_local_cpu_port,
 	.get_strings		= mt7530_get_strings,
 	.get_ethtool_stats	= mt7530_get_ethtool_stats,
 	.get_sset_count		= mt7530_get_sset_count,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 299a26ad5809..4a013680ce64 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -32,6 +32,10 @@ enum mt753x_id {
 #define SYSC_REG_RSTCTRL		0x34
 #define  RESET_MCM			BIT(2)
 
+/* Register for ARL global control */
+#define MT753X_AGC			0xc
+#define  LOCAL_EN			BIT(7)
+
 /* Registers to mac forward control for unknown frames */
 #define MT7530_MFC			0x10
 #define  BC_FFP(x)			(((x) & 0xff) << 24)
@@ -54,6 +58,7 @@ enum mt753x_id {
 #define  MT7531_MIRROR_PORT_GET(x)	(((x) >> 16) & MIRROR_MASK)
 #define  MT7531_MIRROR_PORT_SET(x)	(((x) & MIRROR_MASK) << 16)
 #define  MT7531_CPU_PMAP_MASK		GENMASK(7, 0)
+#define  MT7531_CPU_PMAP(x)		FIELD_PREP(MT7531_CPU_PMAP_MASK, x)
 
 #define MT753X_MIRROR_REG(id)		(((id) == ID_MT7531) ? \
 					 MT7531_CFC : MT7530_MFC)
@@ -668,6 +673,7 @@ enum mt7531_clk_skew {
 #define  RG_SYSPLL_DDSFBK_EN		BIT(12)
 #define  RG_SYSPLL_BIAS_EN		BIT(11)
 #define  RG_SYSPLL_BIAS_LPF_EN		BIT(10)
+#define  MT7531_RG_SYSPLL_DMY2		BIT(6)
 #define  MT7531_PHY_PLL_OFF		BIT(5)
 #define  MT7531_PHY_PLL_BYPASS_MODE	BIT(4)
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index f94d6d322df4..4bd57b79a023 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2535,6 +2535,8 @@ static void am65_cpsw_unregister_devlink(struct am65_cpsw_common *common)
 
 static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 {
+	struct am65_cpsw_rx_chn *rx_chan = &common->rx_chns;
+	struct am65_cpsw_tx_chn *tx_chan = common->tx_chns;
 	struct device *dev = common->dev;
 	struct devlink_port *dl_port;
 	struct am65_cpsw_port *port;
@@ -2553,6 +2555,22 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 		return ret;
 	}
 
+	/* The DMA Channels are not guaranteed to be in a clean state.
+	 * Reset and disable them to ensure that they are back to the
+	 * clean state and ready to be used.
+	 */
+	for (i = 0; i < common->tx_ch_num; i++) {
+		k3_udma_glue_reset_tx_chn(tx_chan[i].tx_chn, &tx_chan[i],
+					  am65_cpsw_nuss_tx_cleanup);
+		k3_udma_glue_disable_tx_chn(tx_chan[i].tx_chn);
+	}
+
+	for (i = 0; i < AM65_CPSW_MAX_RX_FLOWS; i++)
+		k3_udma_glue_reset_rx_chn(rx_chan->rx_chn, i, rx_chan,
+					  am65_cpsw_nuss_rx_cleanup, !!i);
+
+	k3_udma_glue_disable_rx_chn(rx_chan->rx_chn);
+
 	ret = am65_cpsw_nuss_register_devlink(common);
 	if (ret)
 		return ret;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 42bf0a3ec632..f0e34b2b072e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2096,14 +2096,16 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 					    tun_is_little_endian(tun), true,
 					    vlan_hlen)) {
 			struct skb_shared_info *sinfo = skb_shinfo(skb);
-			pr_err("unexpected GSO type: "
-			       "0x%x, gso_size %d, hdr_len %d\n",
-			       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
-			       tun16_to_cpu(tun, gso.hdr_len));
-			print_hex_dump(KERN_ERR, "tun: ",
-				       DUMP_PREFIX_NONE,
-				       16, 1, skb->head,
-				       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+
+			if (net_ratelimit()) {
+				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
+					   sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
+					   tun16_to_cpu(tun, gso.hdr_len));
+				print_hex_dump(KERN_ERR, "tun: ",
+					       DUMP_PREFIX_NONE,
+					       16, 1, skb->head,
+					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+			}
 			WARN_ON_ONCE(1);
 			return -EINVAL;
 		}
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index a111154a9046..c16f18cfeed7 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -360,10 +360,8 @@ int ccw_device_set_online(struct ccw_device *cdev)
 
 	spin_lock_irq(cdev->ccwlock);
 	ret = ccw_device_online(cdev);
-	spin_unlock_irq(cdev->ccwlock);
-	if (ret == 0)
-		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
-	else {
+	if (ret) {
+		spin_unlock_irq(cdev->ccwlock);
 		CIO_MSG_EVENT(0, "ccw_device_online returned %d, "
 			      "device 0.%x.%04x\n",
 			      ret, cdev->private->dev_id.ssid,
@@ -372,7 +370,12 @@ int ccw_device_set_online(struct ccw_device *cdev)
 		put_device(&cdev->dev);
 		return ret;
 	}
-	spin_lock_irq(cdev->ccwlock);
+	/* Wait until a final state is reached */
+	while (!dev_fsm_final_state(cdev)) {
+		spin_unlock_irq(cdev->ccwlock);
+		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+		spin_lock_irq(cdev->ccwlock);
+	}
 	/* Check if online processing was successful */
 	if ((cdev->private->state != DEV_STATE_ONLINE) &&
 	    (cdev->private->state != DEV_STATE_W4SENSE)) {
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 45e810c6ea3b..9c77ec3a8dcd 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -679,8 +679,8 @@ static void qdio_handle_activate_check(struct qdio_irq *irq_ptr,
 	lgr_info_log();
 }
 
-static void qdio_establish_handle_irq(struct qdio_irq *irq_ptr, int cstat,
-				      int dstat)
+static int qdio_establish_handle_irq(struct qdio_irq *irq_ptr, int cstat,
+				     int dstat, int dcc)
 {
 	DBF_DEV_EVENT(DBF_INFO, irq_ptr, "qest irq");
 
@@ -688,15 +688,18 @@ static void qdio_establish_handle_irq(struct qdio_irq *irq_ptr, int cstat,
 		goto error;
 	if (dstat & ~(DEV_STAT_DEV_END | DEV_STAT_CHN_END))
 		goto error;
+	if (dcc == 1)
+		return -EAGAIN;
 	if (!(dstat & DEV_STAT_DEV_END))
 		goto error;
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ESTABLISHED);
-	return;
+	return 0;
 
 error:
 	DBF_ERROR("%4x EQ:error", irq_ptr->schid.sch_no);
 	DBF_ERROR("ds: %2x cs:%2x", dstat, cstat);
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
+	return -EIO;
 }
 
 /* qdio interrupt handler */
@@ -705,7 +708,7 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 {
 	struct qdio_irq *irq_ptr = cdev->private->qdio_data;
 	struct subchannel_id schid;
-	int cstat, dstat;
+	int cstat, dstat, rc, dcc;
 
 	if (!intparm || !irq_ptr) {
 		ccw_device_get_schid(cdev, &schid);
@@ -725,10 +728,12 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 	qdio_irq_check_sense(irq_ptr, irb);
 	cstat = irb->scsw.cmd.cstat;
 	dstat = irb->scsw.cmd.dstat;
+	dcc   = scsw_cmd_is_valid_cc(&irb->scsw) ? irb->scsw.cmd.cc : 0;
+	rc    = 0;
 
 	switch (irq_ptr->state) {
 	case QDIO_IRQ_STATE_INACTIVE:
-		qdio_establish_handle_irq(irq_ptr, cstat, dstat);
+		rc = qdio_establish_handle_irq(irq_ptr, cstat, dstat, dcc);
 		break;
 	case QDIO_IRQ_STATE_CLEANUP:
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
@@ -742,12 +747,25 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 		if (cstat || dstat)
 			qdio_handle_activate_check(irq_ptr, intparm, cstat,
 						   dstat);
+		else if (dcc == 1)
+			rc = -EAGAIN;
 		break;
 	case QDIO_IRQ_STATE_STOPPED:
 		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
+
+	if (rc == -EAGAIN) {
+		DBF_DEV_EVENT(DBF_INFO, irq_ptr, "qint retry");
+		rc = ccw_device_start(cdev, &irq_ptr->ccw, intparm, 0, 0);
+		if (!rc)
+			return;
+		DBF_ERROR("%4x RETRY ERR", irq_ptr->schid.sch_no);
+		DBF_ERROR("rc:%4x", rc);
+		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
+	}
+
 	wake_up(&cdev->private->wait_q);
 }
 
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 62a132b35ba2..fdfed54e62f3 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2669,22 +2669,29 @@ void tb_switch_unconfigure_link(struct tb_switch *sw)
 {
 	struct tb_port *up, *down;
 
-	if (sw->is_unplugged)
-		return;
 	if (!tb_route(sw) || tb_switch_is_icm(sw))
 		return;
 
+	/*
+	 * Unconfigure downstream port so that wake-on-connect can be
+	 * configured after router unplug. No need to unconfigure upstream port
+	 * since its router is unplugged.
+	 */
 	up = tb_upstream_port(sw);
-	if (tb_switch_is_usb4(up->sw))
-		usb4_port_unconfigure(up);
-	else
-		tb_lc_unconfigure_port(up);
-
 	down = up->remote;
 	if (tb_switch_is_usb4(down->sw))
 		usb4_port_unconfigure(down);
 	else
 		tb_lc_unconfigure_port(down);
+
+	if (sw->is_unplugged)
+		return;
+
+	up = tb_upstream_port(sw);
+	if (tb_switch_is_usb4(up->sw))
+		usb4_port_unconfigure(up);
+	else
+		tb_lc_unconfigure_port(up);
 }
 
 static void tb_switch_credits_init(struct tb_switch *sw)
@@ -2926,7 +2933,26 @@ static int tb_switch_set_wake(struct tb_switch *sw, unsigned int flags)
 	return tb_lc_set_wake(sw, flags);
 }
 
-int tb_switch_resume(struct tb_switch *sw)
+static void tb_switch_check_wakes(struct tb_switch *sw)
+{
+	if (device_may_wakeup(&sw->dev)) {
+		if (tb_switch_is_usb4(sw))
+			usb4_switch_check_wakes(sw);
+	}
+}
+
+/**
+ * tb_switch_resume() - Resume a switch after sleep
+ * @sw: Switch to resume
+ * @runtime: Is this resume from runtime suspend or system sleep
+ *
+ * Resumes and re-enumerates router (and all its children), if still plugged
+ * after suspend. Don't enumerate device router whose UID was changed during
+ * suspend. If this is resume from system sleep, notifies PM core about the
+ * wakes occurred during suspend. Disables all wakes, except USB4 wake of
+ * upstream port for USB4 routers that shall be always enabled.
+ */
+int tb_switch_resume(struct tb_switch *sw, bool runtime)
 {
 	struct tb_port *port;
 	int err;
@@ -2971,6 +2997,9 @@ int tb_switch_resume(struct tb_switch *sw)
 	if (err)
 		return err;
 
+	if (!runtime)
+		tb_switch_check_wakes(sw);
+
 	/* Disable wakes */
 	tb_switch_set_wake(sw, 0);
 
@@ -3000,7 +3029,8 @@ int tb_switch_resume(struct tb_switch *sw)
 			 */
 			if (tb_port_unlock(port))
 				tb_port_warn(port, "failed to unlock port\n");
-			if (port->remote && tb_switch_resume(port->remote->sw)) {
+			if (port->remote &&
+			    tb_switch_resume(port->remote->sw, runtime)) {
 				tb_port_warn(port,
 					     "lost during suspend, disconnecting\n");
 				tb_sw_set_unplugged(port->remote->sw);
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 0c3e1d14cddc..8bf45da1012e 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1491,7 +1491,7 @@ static int tb_resume_noirq(struct tb *tb)
 	/* remove any pci devices the firmware might have setup */
 	tb_switch_reset(tb->root_switch);
 
-	tb_switch_resume(tb->root_switch);
+	tb_switch_resume(tb->root_switch, false);
 	tb_free_invalid_tunnels(tb);
 	tb_free_unplugged_children(tb->root_switch);
 	tb_restore_children(tb->root_switch);
@@ -1617,7 +1617,7 @@ static int tb_runtime_resume(struct tb *tb)
 	struct tb_tunnel *tunnel, *n;
 
 	mutex_lock(&tb->lock);
-	tb_switch_resume(tb->root_switch);
+	tb_switch_resume(tb->root_switch, true);
 	tb_free_invalid_tunnels(tb);
 	tb_restore_children(tb->root_switch);
 	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index db0d3d37772f..a739cbf2be1b 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -740,7 +740,7 @@ int tb_switch_configure(struct tb_switch *sw);
 int tb_switch_add(struct tb_switch *sw);
 void tb_switch_remove(struct tb_switch *sw);
 void tb_switch_suspend(struct tb_switch *sw, bool runtime);
-int tb_switch_resume(struct tb_switch *sw);
+int tb_switch_resume(struct tb_switch *sw, bool runtime);
 int tb_switch_reset(struct tb_switch *sw);
 void tb_sw_set_unplugged(struct tb_switch *sw);
 struct tb_port *tb_switch_find_port(struct tb_switch *sw,
@@ -1043,6 +1043,7 @@ static inline struct tb_retimer *tb_to_retimer(struct device *dev)
 	return NULL;
 }
 
+void usb4_switch_check_wakes(struct tb_switch *sw);
 int usb4_switch_setup(struct tb_switch *sw);
 int usb4_switch_read_uid(struct tb_switch *sw, u64 *uid);
 int usb4_switch_drom_read(struct tb_switch *sw, unsigned int address, void *buf,
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 36547afa1896..44eb9c658866 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -175,15 +175,18 @@ static inline int usb4_switch_op_data(struct tb_switch *sw, u16 opcode,
 				tx_dwords, rx_data, rx_dwords);
 }
 
-static void usb4_switch_check_wakes(struct tb_switch *sw)
+/**
+ * usb4_switch_check_wakes() - Check for wakes and notify PM core about them
+ * @sw: Router whose wakes to check
+ *
+ * Checks wakes occurred during suspend and notify the PM core about them.
+ */
+void usb4_switch_check_wakes(struct tb_switch *sw)
 {
 	struct tb_port *port;
 	bool wakeup = false;
 	u32 val;
 
-	if (!device_may_wakeup(&sw->dev))
-		return;
-
 	if (tb_route(sw)) {
 		if (tb_sw_read(sw, &val, TB_CFG_SWITCH, ROUTER_CS_6, 1))
 			return;
@@ -248,8 +251,6 @@ int usb4_switch_setup(struct tb_switch *sw)
 	u32 val = 0;
 	int ret;
 
-	usb4_switch_check_wakes(sw);
-
 	if (!tb_route(sw))
 		return 0;
 
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 12ce150b0ad4..b2eadbac013e 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -217,7 +217,6 @@ static bool pmz_receive_chars(struct uart_pmac_port *uap)
 {
 	struct tty_port *port;
 	unsigned char ch, r1, drop, flag;
-	int loops = 0;
 
 	/* Sanity check, make sure the old bug is no longer happening */
 	if (uap->port.state == NULL) {
@@ -298,24 +297,11 @@ static bool pmz_receive_chars(struct uart_pmac_port *uap)
 		if (r1 & Rx_OVR)
 			tty_insert_flip_char(port, 0, TTY_OVERRUN);
 	next_char:
-		/* We can get stuck in an infinite loop getting char 0 when the
-		 * line is in a wrong HW state, we break that here.
-		 * When that happens, I disable the receive side of the driver.
-		 * Note that what I've been experiencing is a real irq loop where
-		 * I'm getting flooded regardless of the actual port speed.
-		 * Something strange is going on with the HW
-		 */
-		if ((++loops) > 1000)
-			goto flood;
 		ch = read_zsreg(uap, R0);
 		if (!(ch & Rx_CH_AV))
 			break;
 	}
 
-	return true;
- flood:
-	pmz_interrupt_control(uap, 0);
-	pmz_error("pmz: rx irq flood !\n");
 	return true;
 }
 
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 38c2e6089e4c..0d99ba64ea52 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -485,7 +485,6 @@ static ssize_t wdm_write
 static int service_outstanding_interrupt(struct wdm_device *desc)
 {
 	int rv = 0;
-	int used;
 
 	/* submit read urb only if the device is waiting for it */
 	if (!desc->resp_count || !--desc->resp_count)
@@ -500,10 +499,7 @@ static int service_outstanding_interrupt(struct wdm_device *desc)
 		goto out;
 	}
 
-	used = test_and_set_bit(WDM_RESPONDING, &desc->flags);
-	if (used)
-		goto out;
-
+	set_bit(WDM_RESPONDING, &desc->flags);
 	spin_unlock_irq(&desc->iuspin);
 	rv = usb_submit_urb(desc->response, GFP_KERNEL);
 	spin_lock_irq(&desc->iuspin);
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 1f2e2a39b70f..2d87a4681e67 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -295,8 +295,10 @@ static void usb_port_shutdown(struct device *dev)
 {
 	struct usb_port *port_dev = to_usb_port(dev);
 
-	if (port_dev->child)
+	if (port_dev->child) {
 		usb_disable_usb2_hardware_lpm(port_dev->child);
+		usb_unlocked_disable_lpm(port_dev->child);
+	}
 }
 
 static const struct dev_pm_ops usb_port_pm_ops = {
diff --git a/drivers/usb/dwc2/hcd_ddma.c b/drivers/usb/dwc2/hcd_ddma.c
index 6a4aa71da103..d6fa02d851e4 100644
--- a/drivers/usb/dwc2/hcd_ddma.c
+++ b/drivers/usb/dwc2/hcd_ddma.c
@@ -897,13 +897,15 @@ static int dwc2_cmpl_host_isoc_dma_desc(struct dwc2_hsotg *hsotg,
 	struct dwc2_dma_desc *dma_desc;
 	struct dwc2_hcd_iso_packet_desc *frame_desc;
 	u16 frame_desc_idx;
-	struct urb *usb_urb = qtd->urb->priv;
+	struct urb *usb_urb;
 	u16 remain = 0;
 	int rc = 0;
 
 	if (!qtd->urb)
 		return -EINVAL;
 
+	usb_urb = qtd->urb->priv;
+
 	dma_sync_single_for_cpu(hsotg->dev, qh->desc_list_dma + (idx *
 				sizeof(struct dwc2_dma_desc)),
 				sizeof(struct dwc2_dma_desc),
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index e93b0eb74c08..00995d65b54c 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -888,7 +888,7 @@ static int ncm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		if (alt > 1)
 			goto fail;
 
-		if (ncm->port.in_ep->enabled) {
+		if (ncm->netdev) {
 			DBG(cdev, "reset ncm\n");
 			ncm->netdev = NULL;
 			gether_disconnect(&ncm->port);
@@ -1373,7 +1373,7 @@ static void ncm_disable(struct usb_function *f)
 
 	DBG(cdev, "ncm deactivated\n");
 
-	if (ncm->port.in_ep->enabled) {
+	if (ncm->netdev) {
 		ncm->netdev = NULL;
 		gether_disconnect(&ncm->port);
 	}
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 1a3e5a9414f0..b5ee8518fcc7 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -255,6 +255,10 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM061K_LMS		0x0124
 #define QUECTEL_PRODUCT_EC25			0x0125
 #define QUECTEL_PRODUCT_EM060K_128		0x0128
+#define QUECTEL_PRODUCT_EM060K_129		0x0129
+#define QUECTEL_PRODUCT_EM060K_12a		0x012a
+#define QUECTEL_PRODUCT_EM060K_12b		0x012b
+#define QUECTEL_PRODUCT_EM060K_12c		0x012c
 #define QUECTEL_PRODUCT_EG91			0x0191
 #define QUECTEL_PRODUCT_EG95			0x0195
 #define QUECTEL_PRODUCT_BG96			0x0296
@@ -1218,6 +1222,18 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_129, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_129, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_129, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12a, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12a, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12a, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12b, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12b, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12b, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12c, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12c, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12c, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x40) },
@@ -1360,6 +1376,12 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1083, 0xff),	/* Telit FE990 (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a0, 0xff),	/* Telit FN20C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a4, 0xff),	/* Telit FN20C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a9, 0xff),	/* Telit FN20C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
@@ -2052,6 +2074,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(LONGCHEER_VENDOR_ID, 0x9803, 0xff),
 	  .driver_info = RSVD(4) },
+	{ USB_DEVICE(LONGCHEER_VENDOR_ID, 0x9b05),	/* Longsung U8300 */
+	  .driver_info = RSVD(4) | RSVD(5) },
+	{ USB_DEVICE(LONGCHEER_VENDOR_ID, 0x9b3c),	/* Longsung U9300 */
+	  .driver_info = RSVD(0) | RSVD(4) },
 	{ USB_DEVICE(LONGCHEER_VENDOR_ID, ZOOM_PRODUCT_4597) },
 	{ USB_DEVICE(LONGCHEER_VENDOR_ID, IBALL_3_5G_CONNECT) },
 	{ USB_DEVICE(HAIER_VENDOR_ID, HAIER_PRODUCT_CE100) },
@@ -2272,15 +2298,29 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },		/* Fibocom FG150 AT */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0111, 0xff) },			/* Fibocom FM160 (MBIM mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0115, 0xff),			/* Fibocom FM135 (laptop MBIM) */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a3, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
 	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a04, 0xff) },			/* Fibocom FM650-CN (ECM mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a05, 0xff) },			/* Fibocom FM650-CN (NCM mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a06, 0xff) },			/* Fibocom FM650-CN (RNDIS mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a07, 0xff) },			/* Fibocom FM650-CN (MBIM mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
+	{ USB_DEVICE(0x33f8, 0x0104),						/* Rolling RW101-GL (laptop RMNET) */
+	  .driver_info = RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a2, 0xff) },			/* Rolling RW101-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a3, 0xff) },			/* Rolling RW101-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a4, 0xff),			/* Rolling RW101-GL (laptop MBIM) */
+	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0115, 0xff),			/* Rolling RW135-GL (laptop MBIM) */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 5a98c5da1225..8d8b45599236 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1046,6 +1046,9 @@ __btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
+	ret = btrfs_record_root_in_trans(trans, node->root);
+	if (ret)
+		return ret;
 	ret = btrfs_update_delayed_inode(trans, node->root, path, node);
 	return ret;
 }
diff --git a/fs/ksmbd/ksmbd_netlink.h b/fs/ksmbd/ksmbd_netlink.h
index ecffcb8a1557..dc30cd0f6acd 100644
--- a/fs/ksmbd/ksmbd_netlink.h
+++ b/fs/ksmbd/ksmbd_netlink.h
@@ -166,7 +166,8 @@ struct ksmbd_share_config_response {
 	__u16	force_uid;
 	__u16	force_gid;
 	__s8	share_name[KSMBD_REQ_MAX_SHARE_NAME];
-	__u32	reserved[112];		/* Reserved room */
+	__u32	reserved[111];		/* Reserved room */
+	__u32	payload_sz;
 	__u32	veto_list_sz;
 	__s8	____payload[];
 };
diff --git a/fs/ksmbd/mgmt/share_config.c b/fs/ksmbd/mgmt/share_config.c
index 328a412259dc..a2f0a2edceb8 100644
--- a/fs/ksmbd/mgmt/share_config.c
+++ b/fs/ksmbd/mgmt/share_config.c
@@ -158,7 +158,12 @@ static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
 	share->name = kstrdup(name, GFP_KERNEL);
 
 	if (!test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
-		share->path = kstrdup(ksmbd_share_config_path(resp),
+		int path_len = PATH_MAX;
+
+		if (resp->payload_sz)
+			path_len = resp->payload_sz - resp->veto_list_sz;
+
+		share->path = kstrndup(ksmbd_share_config_path(resp), path_len,
 				      GFP_KERNEL);
 		if (share->path)
 			share->path_sz = strlen(share->path);
diff --git a/fs/ksmbd/smb2ops.c b/fs/ksmbd/smb2ops.c
index c69943d96565..d0db9f32c423 100644
--- a/fs/ksmbd/smb2ops.c
+++ b/fs/ksmbd/smb2ops.c
@@ -229,6 +229,11 @@ void init_smb3_0_server(struct ksmbd_conn *conn)
 	    conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
 
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
+	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
+	     conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION))
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 }
@@ -276,11 +281,6 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
 			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
-	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
-	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
-	     conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION))
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
-
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 14cd86a14012..86b1fb43104e 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5581,8 +5581,9 @@ static int smb2_rename(struct ksmbd_work *work,
 	if (!file_info->ReplaceIfExists)
 		flags = RENAME_NOREPLACE;
 
-	smb_break_all_levII_oplock(work, fp, 0);
 	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
+	if (!rc)
+		smb_break_all_levII_oplock(work, fp, 0);
 out:
 	kfree(new_name);
 	return rc;
diff --git a/fs/ksmbd/transport_ipc.c b/fs/ksmbd/transport_ipc.c
index 2c9662e32799..d62ebbff1e0f 100644
--- a/fs/ksmbd/transport_ipc.c
+++ b/fs/ksmbd/transport_ipc.c
@@ -65,6 +65,7 @@ struct ipc_msg_table_entry {
 	struct hlist_node	ipc_table_hlist;
 
 	void			*response;
+	unsigned int		msg_sz;
 };
 
 static struct delayed_work ipc_timer_work;
@@ -274,6 +275,7 @@ static int handle_response(int type, void *payload, size_t sz)
 		}
 
 		memcpy(entry->response, payload, sz);
+		entry->msg_sz = sz;
 		wake_up_interruptible(&entry->wait);
 		ret = 0;
 		break;
@@ -452,6 +454,34 @@ static int ipc_msg_send(struct ksmbd_ipc_msg *msg)
 	return ret;
 }
 
+static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
+{
+	unsigned int msg_sz = entry->msg_sz;
+
+	if (entry->type == KSMBD_EVENT_RPC_REQUEST) {
+		struct ksmbd_rpc_command *resp = entry->response;
+
+		msg_sz = sizeof(struct ksmbd_rpc_command) + resp->payload_sz;
+	} else if (entry->type == KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST) {
+		struct ksmbd_spnego_authen_response *resp = entry->response;
+
+		msg_sz = sizeof(struct ksmbd_spnego_authen_response) +
+				resp->session_key_len + resp->spnego_blob_len;
+	} else if (entry->type == KSMBD_EVENT_SHARE_CONFIG_REQUEST) {
+		struct ksmbd_share_config_response *resp = entry->response;
+
+		if (resp->payload_sz) {
+			if (resp->payload_sz < resp->veto_list_sz)
+				return -EINVAL;
+
+			msg_sz = sizeof(struct ksmbd_share_config_response) +
+					resp->payload_sz;
+		}
+	}
+
+	return entry->msg_sz != msg_sz ? -EINVAL : 0;
+}
+
 static void *ipc_msg_send_request(struct ksmbd_ipc_msg *msg, unsigned int handle)
 {
 	struct ipc_msg_table_entry entry;
@@ -476,6 +506,13 @@ static void *ipc_msg_send_request(struct ksmbd_ipc_msg *msg, unsigned int handle
 	ret = wait_event_interruptible_timeout(entry.wait,
 					       entry.response != NULL,
 					       IPC_WAIT_TIMEOUT);
+	if (entry.response) {
+		ret = ipc_validate_msg(&entry);
+		if (ret) {
+			kvfree(entry.response);
+			entry.response = NULL;
+		}
+	}
 out:
 	down_write(&ipc_msg_table_lock);
 	hash_del(&entry.ipc_table_hlist);
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 55c0a0331188..4e30f3c50970 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -470,7 +470,9 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 	    struct nlm_host *host, struct nlm_lock *lock, int wait,
 	    struct nlm_cookie *cookie, int reclaim)
 {
+#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	struct inode		*inode = nlmsvc_file_inode(file);
+#endif
 	struct nlm_block	*block = NULL;
 	int			error;
 	int			mode;
@@ -484,7 +486,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 				(long long)lock->fl.fl_end,
 				wait);
 
-	if (!exportfs_lock_op_is_async(inode->i_sb->s_export_op)) {
+	if (nlmsvc_file_file(file)->f_op->lock) {
 		async_block = wait;
 		wait = 0;
 	}
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 40b5b226e504..d07176eee935 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7420,7 +7420,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_blocked_lock *nbl = NULL;
 	struct file_lock *file_lock = NULL;
 	struct file_lock *conflock = NULL;
-	struct super_block *sb;
 	__be32 status = 0;
 	int lkflg;
 	int err;
@@ -7442,7 +7441,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		dprintk("NFSD: nfsd4_lock: permission denied!\n");
 		return status;
 	}
-	sb = cstate->current_fh.fh_dentry->d_sb;
 
 	if (lock->lk_is_new) {
 		if (nfsd4_has_session(cstate))
@@ -7494,8 +7492,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fp = lock_stp->st_stid.sc_file;
 	switch (lock->lk_type) {
 		case NFS4_READW_LT:
-			if (nfsd4_has_session(cstate) ||
-			    exportfs_lock_op_is_async(sb->s_export_op))
+			if (nfsd4_has_session(cstate))
 				fl_flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_READ_LT:
@@ -7507,8 +7504,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			fl_type = F_RDLCK;
 			break;
 		case NFS4_WRITEW_LT:
-			if (nfsd4_has_session(cstate) ||
-			    exportfs_lock_op_is_async(sb->s_export_op))
+			if (nfsd4_has_session(cstate))
 				fl_flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_WRITE_LT:
@@ -7536,7 +7532,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * for file locks), so don't attempt blocking lock notifications
 	 * on those filesystems:
 	 */
-	if (!exportfs_lock_op_is_async(sb->s_export_op))
+	if (nf->nf_file->f_op->lock)
 		fl_flags &= ~FL_SLEEP;
 
 	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 81394e22d0a0..eb7de9e2a384 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -243,7 +243,7 @@ nilfs_filetype_table[NILFS_FT_MAX] = {
 
 #define S_SHIFT 12
 static unsigned char
-nilfs_type_by_mode[S_IFMT >> S_SHIFT] = {
+nilfs_type_by_mode[(S_IFMT >> S_SHIFT) + 1] = {
 	[S_IFREG >> S_SHIFT]	= NILFS_FT_REG_FILE,
 	[S_IFDIR >> S_SHIFT]	= NILFS_FT_DIR,
 	[S_IFCHR >> S_SHIFT]	= NILFS_FT_CHRDEV,
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index d019d6ac6ad0..fd55a4a04d6d 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -440,6 +440,8 @@ struct kernfs_node *sysfs_break_active_protection(struct kobject *kobj,
 	kn = kernfs_find_and_get(kobj->sd, attr->name);
 	if (kn)
 		kernfs_break_active_protection(kn);
+	else
+		kobject_put(kobj);
 	return kn;
 }
 EXPORT_SYMBOL_GPL(sysfs_break_active_protection);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index df15d4d445dd..74a26cabc084 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -321,7 +321,12 @@ enum bpf_type_flag {
 	 */
 	MEM_RDONLY		= BIT(1 + BPF_BASE_TYPE_BITS),
 
-	__BPF_TYPE_LAST_FLAG	= MEM_RDONLY,
+	/* MEM was "allocated" from a different helper, and cannot be mixed
+	 * with regular non-MEM_ALLOC'ed MEM types.
+	 */
+	MEM_ALLOC		= BIT(2 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	= MEM_ALLOC,
 };
 
 /* Max number of base types. */
@@ -405,7 +410,7 @@ enum bpf_return_type {
 	RET_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
 	RET_PTR_TO_TCP_SOCK_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
 	RET_PTR_TO_SOCK_COMMON_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
-	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_ALLOC_MEM,
+	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_ALLOC_MEM,
 	RET_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
 
 	/* This must be the last entry. Its purpose is to ensure the enum is
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3d04b48e502d..c0993b079ab5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -541,8 +541,8 @@ bpf_prog_offload_replace_insn(struct bpf_verifier_env *env, u32 off,
 void
 bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt);
 
-int check_ctx_reg(struct bpf_verifier_env *env,
-		  const struct bpf_reg_state *reg, int regno);
+int check_ptr_off_reg(struct bpf_verifier_env *env,
+		      const struct bpf_reg_state *reg, int regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		   u32 regno, u32 mem_size);
 
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 6525f4b7eb97..218fc5c54e90 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -222,23 +222,9 @@ struct export_operations {
 						  atomic attribute updates
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
-#define EXPORT_OP_ASYNC_LOCK		(0x40) /* fs can do async lock request */
 	unsigned long	flags;
 };
 
-/**
- * exportfs_lock_op_is_async() - export op supports async lock operation
- * @export_ops:	the nfs export operations to check
- *
- * Returns true if the nfs export_operations structure has
- * EXPORT_OP_ASYNC_LOCK in their flags set
- */
-static inline bool
-exportfs_lock_op_is_async(const struct export_operations *export_ops)
-{
-	return export_ops->flags & EXPORT_OP_ASYNC_LOCK;
-}
-
 extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 				    int *max_len, struct inode *parent);
 extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
diff --git a/include/net/dsa.h b/include/net/dsa.h
index bec439c4a085..e57d6e65f27e 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -705,6 +705,14 @@ struct dsa_switch_ops {
 			       struct phy_device *phy);
 	void	(*port_disable)(struct dsa_switch *ds, int port);
 
+	/*
+	 * Compatibility between device trees defining multiple CPU ports and
+	 * drivers which are not OK to use by default the numerically smallest
+	 * CPU port of a switch for its local ports. This can return NULL,
+	 * meaning "don't know/don't care".
+	 */
+	struct dsa_port *(*preferred_default_local_cpu_port)(struct dsa_switch *ds);
+
 	/*
 	 * Port's MAC EEE settings
 	 */
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 2ba326f9e004..c47baa623ba5 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -26,6 +26,9 @@
 #if defined(CONFIG_NF_CONNTRACK) || defined(CONFIG_NF_CONNTRACK_MODULE)
 #include <net/netns/conntrack.h>
 #endif
+#if IS_ENABLED(CONFIG_NF_FLOW_TABLE)
+#include <net/netns/flow_table.h>
+#endif
 #include <net/netns/nftables.h>
 #include <net/netns/xfrm.h>
 #include <net/netns/mpls.h>
@@ -138,6 +141,9 @@ struct net {
 #if defined(CONFIG_NF_TABLES) || defined(CONFIG_NF_TABLES_MODULE)
 	struct netns_nftables	nft;
 #endif
+#if IS_ENABLED(CONFIG_NF_FLOW_TABLE)
+	struct netns_ft ft;
+#endif
 #endif
 #ifdef CONFIG_WEXT_CORE
 	struct sk_buff_head	wext_nlevents;
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index dabd84fa3fd3..8e98fb8edff8 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -318,7 +318,7 @@ int nf_flow_rule_route_ipv6(struct net *net, const struct flow_offload *flow,
 int nf_flow_table_offload_init(void);
 void nf_flow_table_offload_exit(void);
 
-static inline __be16 nf_flow_pppoe_proto(const struct sk_buff *skb)
+static inline __be16 __nf_flow_pppoe_proto(const struct sk_buff *skb)
 {
 	__be16 proto;
 
@@ -334,4 +334,35 @@ static inline __be16 nf_flow_pppoe_proto(const struct sk_buff *skb)
 	return 0;
 }
 
+static inline bool nf_flow_pppoe_proto(struct sk_buff *skb, __be16 *inner_proto)
+{
+	if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
+		return false;
+
+	*inner_proto = __nf_flow_pppoe_proto(skb);
+
+	return true;
+}
+
+#define NF_FLOW_TABLE_STAT_INC(net, count) __this_cpu_inc((net)->ft.stat->count)
+#define NF_FLOW_TABLE_STAT_DEC(net, count) __this_cpu_dec((net)->ft.stat->count)
+#define NF_FLOW_TABLE_STAT_INC_ATOMIC(net, count)	\
+	this_cpu_inc((net)->ft.stat->count)
+#define NF_FLOW_TABLE_STAT_DEC_ATOMIC(net, count)	\
+	this_cpu_dec((net)->ft.stat->count)
+
+#ifdef CONFIG_NF_FLOW_TABLE_PROCFS
+int nf_flow_table_init_proc(struct net *net);
+void nf_flow_table_fini_proc(struct net *net);
+#else
+static inline int nf_flow_table_init_proc(struct net *net)
+{
+	return 0;
+}
+
+static inline void nf_flow_table_fini_proc(struct net *net)
+{
+}
+#endif /* CONFIG_NF_FLOW_TABLE_PROCFS */
+
 #endif /* _NF_FLOW_TABLE_H */
diff --git a/include/net/netns/flow_table.h b/include/net/netns/flow_table.h
new file mode 100644
index 000000000000..1c5fc657e267
--- /dev/null
+++ b/include/net/netns/flow_table.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NETNS_FLOW_TABLE_H
+#define __NETNS_FLOW_TABLE_H
+
+struct nf_flow_table_stat {
+	unsigned int count_wq_add;
+	unsigned int count_wq_del;
+	unsigned int count_wq_stats;
+};
+
+struct netns_ft {
+	struct nf_flow_table_stat __percpu *stat;
+};
+#endif
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index b8fd13303ee7..6959255ccfa9 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -587,7 +587,7 @@ TRACE_EVENT(rpcgss_context,
 		__field(unsigned int, timeout)
 		__field(u32, window_size)
 		__field(int, len)
-		__string(acceptor, data)
+		__string_len(acceptor, data, len)
 	),
 
 	TP_fast_assign(
@@ -596,7 +596,7 @@ TRACE_EVENT(rpcgss_context,
 		__entry->timeout = timeout;
 		__entry->window_size = window_size;
 		__entry->len = len;
-		strncpy(__get_str(acceptor), data, len);
+		__assign_str(acceptor, data);
 	),
 
 	TP_printk("win_size=%u expiry=%lu now=%lu timeout=%u acceptor=%.*s",
diff --git a/init/main.c b/init/main.c
index f27e8510b155..3f3dc2a8bd86 100644
--- a/init/main.c
+++ b/init/main.c
@@ -640,6 +640,8 @@ static void __init setup_command_line(char *command_line)
 	if (!saved_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
 
+	len = xlen + strlen(command_line) + 1;
+
 	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!static_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5d4bea53ac1f..a0c7e13e0ab4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5447,6 +5447,46 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 #endif
 };
 
+/* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
+static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
+					const struct btf *btf,
+					const struct btf_type *t, int rec)
+{
+	const struct btf_type *member_type;
+	const struct btf_member *member;
+	u32 i;
+
+	if (!btf_type_is_struct(t))
+		return false;
+
+	for_each_member(i, t, member) {
+		const struct btf_array *array;
+
+		member_type = btf_type_skip_modifiers(btf, member->type, NULL);
+		if (btf_type_is_struct(member_type)) {
+			if (rec >= 3) {
+				bpf_log(log, "max struct nesting depth exceeded\n");
+				return false;
+			}
+			if (!__btf_type_is_scalar_struct(log, btf, member_type, rec + 1))
+				return false;
+			continue;
+		}
+		if (btf_type_is_array(member_type)) {
+			array = btf_type_array(member_type);
+			if (!array->nelems)
+				return false;
+			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
+			if (!btf_type_is_scalar(member_type))
+				return false;
+			continue;
+		}
+		if (!btf_type_is_scalar(member_type))
+			return false;
+	}
+	return true;
+}
+
 static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    const struct btf *btf, u32 func_id,
 				    struct bpf_reg_state *regs,
@@ -5455,6 +5495,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	enum bpf_prog_type prog_type = env->prog->type == BPF_PROG_TYPE_EXT ?
 		env->prog->aux->dst_prog->type : env->prog->type;
 	struct bpf_verifier_log *log = &env->log;
+	bool is_kfunc = btf_is_kernel(btf);
 	const char *func_name, *ref_tname;
 	const struct btf_type *t, *ref_t;
 	const struct btf_param *args;
@@ -5507,7 +5548,20 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
-		if (btf_is_kernel(btf)) {
+		if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
+			/* If function expects ctx type in BTF check that caller
+			 * is passing PTR_TO_CTX.
+			 */
+			if (reg->type != PTR_TO_CTX) {
+				bpf_log(log,
+					"arg#%d expected pointer to ctx, but got %s\n",
+					i, btf_type_str(t));
+				return -EINVAL;
+			}
+			if (check_ptr_off_reg(env, reg, regno))
+				return -EINVAL;
+		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
+			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
 			const struct btf_type *reg_ref_t;
 			const struct btf *reg_btf;
 			const char *reg_ref_tname;
@@ -5523,14 +5577,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			if (reg->type == PTR_TO_BTF_ID) {
 				reg_btf = reg->btf;
 				reg_ref_id = reg->btf_id;
-			} else if (reg2btf_ids[base_type(reg->type)]) {
+			} else {
 				reg_btf = btf_vmlinux;
 				reg_ref_id = *reg2btf_ids[base_type(reg->type)];
-			} else {
-				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s but R%d is not a pointer to btf_id\n",
-					func_name, i,
-					btf_type_str(ref_t), ref_tname, regno);
-				return -EINVAL;
 			}
 
 			reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id,
@@ -5546,22 +5595,24 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					reg_ref_tname);
 				return -EINVAL;
 			}
-		} else if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
-			/* If function expects ctx type in BTF check that caller
-			 * is passing PTR_TO_CTX.
-			 */
-			if (reg->type != PTR_TO_CTX) {
-				bpf_log(log,
-					"arg#%d expected pointer to ctx, but got %s\n",
-					i, btf_type_str(t));
-				return -EINVAL;
-			}
-			if (check_ctx_reg(env, reg, regno))
-				return -EINVAL;
 		} else if (ptr_to_mem_ok) {
 			const struct btf_type *resolve_ret;
 			u32 type_size;
 
+			if (is_kfunc) {
+				/* Permit pointer to mem, but only when argument
+				 * type is pointer to scalar, or struct composed
+				 * (recursively) of scalars.
+				 */
+				if (!btf_type_is_scalar(ref_t) &&
+				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0)) {
+					bpf_log(log,
+						"arg#%d pointer type %s %s must point to scalar or struct with scalar\n",
+						i, btf_type_str(ref_t), ref_tname);
+					return -EINVAL;
+				}
+			}
+
 			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
 			if (IS_ERR(resolve_ret)) {
 				bpf_log(log,
@@ -5574,6 +5625,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			if (check_mem_reg(env, reg, regno, type_size))
 				return -EINVAL;
 		} else {
+			bpf_log(log, "reg type unsupported for arg#%d %sfunction %s#%d\n", i,
+				is_kfunc ? "kernel " : "", func_name, func_id);
 			return -EINVAL;
 		}
 	}
@@ -5623,7 +5676,7 @@ int btf_check_kfunc_arg_match(struct bpf_verifier_env *env,
 			      const struct btf *btf, u32 func_id,
 			      struct bpf_reg_state *regs)
 {
-	return btf_check_func_arg_match(env, btf, func_id, regs, false);
+	return btf_check_func_arg_match(env, btf, func_id, regs, true);
 }
 
 /* Convert BTF of a function into bpf_reg_state if possible
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 008ddb694c8a..67b325427022 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -573,6 +573,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 
 	if (type & MEM_RDONLY)
 		strncpy(prefix, "rdonly_", 16);
+	if (type & MEM_ALLOC)
+		strncpy(prefix, "alloc_", 16);
 
 	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
@@ -3980,16 +3982,17 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
-int check_ctx_reg(struct bpf_verifier_env *env,
-		  const struct bpf_reg_state *reg, int regno)
+static int __check_ptr_off_reg(struct bpf_verifier_env *env,
+			       const struct bpf_reg_state *reg, int regno,
+			       bool fixed_off_ok)
 {
-	/* Access to ctx or passing it to a helper is only allowed in
-	 * its original, unmodified form.
+	/* Access to this pointer-typed register or passing it to a helper
+	 * is only allowed in its original, unmodified form.
 	 */
 
-	if (reg->off) {
-		verbose(env, "dereference of modified ctx ptr R%d off=%d disallowed\n",
-			regno, reg->off);
+	if (!fixed_off_ok && reg->off) {
+		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
+			reg_type_str(env, reg->type), regno, reg->off);
 		return -EACCES;
 	}
 
@@ -3997,13 +4000,20 @@ int check_ctx_reg(struct bpf_verifier_env *env,
 		char tn_buf[48];
 
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-		verbose(env, "variable ctx access var_off=%s disallowed\n", tn_buf);
+		verbose(env, "variable %s access var_off=%s disallowed\n",
+			reg_type_str(env, reg->type), tn_buf);
 		return -EACCES;
 	}
 
 	return 0;
 }
 
+int check_ptr_off_reg(struct bpf_verifier_env *env,
+		      const struct bpf_reg_state *reg, int regno)
+{
+	return __check_ptr_off_reg(env, reg, regno, false);
+}
+
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
@@ -4447,7 +4457,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return -EACCES;
 		}
 
-		err = check_ctx_reg(env, reg, regno);
+		err = check_ptr_off_reg(env, reg, regno);
 		if (err < 0)
 			return err;
 
@@ -5149,6 +5159,7 @@ static const struct bpf_reg_types mem_types = {
 		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
 		PTR_TO_MEM,
+		PTR_TO_MEM | MEM_ALLOC,
 		PTR_TO_BUF,
 	},
 };
@@ -5166,7 +5177,7 @@ static const struct bpf_reg_types int_ptr_types = {
 static const struct bpf_reg_types fullsock_types = { .types = { PTR_TO_SOCKET } };
 static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
-static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM } };
+static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
 static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
 static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
 static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
@@ -5266,12 +5277,6 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 				kernel_type_name(btf_vmlinux, *arg_btf_id));
 			return -EACCES;
 		}
-
-		if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
-			verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
-				regno);
-			return -EACCES;
-		}
 	}
 
 	return 0;
@@ -5326,10 +5331,33 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	if (err)
 		return err;
 
-	if (type == PTR_TO_CTX) {
-		err = check_ctx_reg(env, reg, regno);
+	switch ((u32)type) {
+	case SCALAR_VALUE:
+	/* Pointer types where reg offset is explicitly allowed: */
+	case PTR_TO_PACKET:
+	case PTR_TO_PACKET_META:
+	case PTR_TO_MAP_KEY:
+	case PTR_TO_MAP_VALUE:
+	case PTR_TO_MEM:
+	case PTR_TO_MEM | MEM_RDONLY:
+	case PTR_TO_MEM | MEM_ALLOC:
+	case PTR_TO_BUF:
+	case PTR_TO_BUF | MEM_RDONLY:
+	case PTR_TO_STACK:
+		/* Some of the argument types nevertheless require a
+		 * zero register offset.
+		 */
+		if (arg_type == ARG_PTR_TO_ALLOC_MEM)
+			goto force_off_check;
+		break;
+	/* All the rest must be rejected: */
+	default:
+force_off_check:
+		err = __check_ptr_off_reg(env, reg, regno,
+					  type == PTR_TO_BTF_ID);
 		if (err < 0)
 			return err;
+		break;
 	}
 
 skip_type_check:
@@ -9561,7 +9589,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			return err;
 	}
 
-	err = check_ctx_reg(env, &regs[ctx_reg], ctx_reg);
+	err = check_ptr_off_reg(env, &regs[ctx_reg], ctx_reg);
 	if (err < 0)
 		return err;
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 5d713a7d7e87..af57705e1fef 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1564,10 +1564,17 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	jump_label_lock();
 	preempt_disable();
 
-	/* Ensure it is not in reserved area nor out of text */
-	if (!(core_kernel_text((unsigned long) p->addr) ||
-	    is_module_text_address((unsigned long) p->addr)) ||
-	    in_gate_area_no_mm((unsigned long) p->addr) ||
+	/* Ensure the address is in a text area, and find a module if exists. */
+	*probed_mod = NULL;
+	if (!core_kernel_text((unsigned long) p->addr)) {
+		*probed_mod = __module_text_address((unsigned long) p->addr);
+		if (!(*probed_mod)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+	/* Ensure it is not in reserved area. */
+	if (in_gate_area_no_mm((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
@@ -1577,8 +1584,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		goto out;
 	}
 
-	/* Check if are we probing a module */
-	*probed_mod = __module_text_address((unsigned long) p->addr);
+	/* Get module refcount and reject __init functions for loaded modules. */
 	if (*probed_mod) {
 		/*
 		 * We must hold a refcount of the probed module while updating
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index dfdbcf1da216..106f9813841a 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1161,10 +1161,8 @@ register_snapshot_trigger(char *glob, struct event_trigger_ops *ops,
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
-	int ret = tracing_alloc_snapshot_instance(file->tr);
-
-	if (ret < 0)
-		return ret;
+	if (tracing_alloc_snapshot_instance(file->tr) != 0)
+		return 0;
 
 	return register_trigger(glob, ops, data, file);
 }
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 54bfcdf69273..f3d49343f7db 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -30,7 +30,7 @@ br_netif_receive_skb(struct net *net, struct sock *sk, struct sk_buff *skb)
 	return netif_receive_skb(skb);
 }
 
-static int br_pass_frame_up(struct sk_buff *skb)
+static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
 {
 	struct net_device *indev, *brdev = BR_INPUT_SKB_CB(skb)->brdev;
 	struct net_bridge *br = netdev_priv(brdev);
@@ -65,6 +65,8 @@ static int br_pass_frame_up(struct sk_buff *skb)
 	br_multicast_count(br, NULL, skb, br_multicast_igmp_type(skb),
 			   BR_MCAST_DIR_TX);
 
+	BR_INPUT_SKB_CB(skb)->promisc = promisc;
+
 	return NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
 		       dev_net(indev), NULL, skb, indev, NULL,
 		       br_netif_receive_skb);
@@ -82,6 +84,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	struct net_bridge_mcast *brmctx;
 	struct net_bridge_vlan *vlan;
 	struct net_bridge *br;
+	bool promisc;
 	u16 vid = 0;
 	u8 state;
 
@@ -102,7 +105,9 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	if (p->flags & BR_LEARNING)
 		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0);
 
-	local_rcv = !!(br->dev->flags & IFF_PROMISC);
+	promisc = !!(br->dev->flags & IFF_PROMISC);
+	local_rcv = promisc;
+
 	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest)) {
 		/* by definition the broadcast is also a multicast address */
 		if (is_broadcast_ether_addr(eth_hdr(skb)->h_dest)) {
@@ -165,7 +170,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		unsigned long now = jiffies;
 
 		if (test_bit(BR_FDB_LOCAL, &dst->flags))
-			return br_pass_frame_up(skb);
+			return br_pass_frame_up(skb, false);
 
 		if (now != dst->used)
 			dst->used = now;
@@ -178,7 +183,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	}
 
 	if (local_rcv)
-		return br_pass_frame_up(skb);
+		return br_pass_frame_up(skb, promisc);
 
 out:
 	return 0;
@@ -350,6 +355,8 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 				goto forward;
 		}
 
+		BR_INPUT_SKB_CB(skb)->promisc = false;
+
 		/* The else clause should be hit when nf_hook():
 		 *   - returns < 0 (drop/error)
 		 *   - returns = 0 (stolen/nf_queue)
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 8a114a500046..9981e0dfdd4d 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -584,11 +584,17 @@ static unsigned int br_nf_local_in(void *priv,
 				   struct sk_buff *skb,
 				   const struct nf_hook_state *state)
 {
+	bool promisc = BR_INPUT_SKB_CB(skb)->promisc;
 	struct nf_conntrack *nfct = skb_nfct(skb);
 	const struct nf_ct_hook *ct_hook;
 	struct nf_conn *ct;
 	int ret;
 
+	if (promisc) {
+		nf_reset_ct(skb);
+		return NF_ACCEPT;
+	}
+
 	if (!nfct || skb->pkt_type == PACKET_HOST)
 		return NF_ACCEPT;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index ff10ddeeb50f..fe61d3b8d0cc 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -547,6 +547,7 @@ struct br_input_skb_cb {
 #endif
 	u8 proxyarp_replied:1;
 	u8 src_port_isolated:1;
+	u8 promisc:1;
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 	u8 vlan_filtered:1;
 #endif
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 83743e95939b..fbdb1ad448c3 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -293,18 +293,24 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
 				    const struct nf_hook_state *state)
 {
-	enum ip_conntrack_info ctinfo;
+	bool promisc = BR_INPUT_SKB_CB(skb)->promisc;
+	struct nf_conntrack *nfct = skb_nfct(skb);
 	struct nf_conn *ct;
 
-	if (skb->pkt_type == PACKET_HOST)
+	if (promisc) {
+		nf_reset_ct(skb);
+		return NF_ACCEPT;
+	}
+
+	if (!nfct || skb->pkt_type == PACKET_HOST)
 		return NF_ACCEPT;
 
 	/* nf_conntrack_confirm() cannot handle concurrent clones,
 	 * this happens for broad/multicast frames with e.g. macvlan on top
 	 * of the bridge device.
 	 */
-	ct = nf_ct_get(skb, &ctinfo);
-	if (!ct || nf_ct_is_confirmed(ct) || nf_ct_is_template(ct))
+	ct = container_of(nfct, struct nf_conn, ct_general);
+	if (nf_ct_is_confirmed(ct) || nf_ct_is_template(ct))
 		return NF_ACCEPT;
 
 	/* let inet prerouting call conntrack again */
diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 9751bee3fb2f..543834e31298 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -386,6 +386,24 @@ static int dsa_tree_setup_default_cpu(struct dsa_switch_tree *dst)
 	return 0;
 }
 
+static struct dsa_port *
+dsa_switch_preferred_default_local_cpu_port(struct dsa_switch *ds)
+{
+	struct dsa_port *cpu_dp;
+
+	if (!ds->ops->preferred_default_local_cpu_port)
+		return NULL;
+
+	cpu_dp = ds->ops->preferred_default_local_cpu_port(ds);
+	if (!cpu_dp)
+		return NULL;
+
+	if (WARN_ON(!dsa_port_is_cpu(cpu_dp) || cpu_dp->ds != ds))
+		return NULL;
+
+	return cpu_dp;
+}
+
 /* Perform initial assignment of CPU ports to user ports and DSA links in the
  * fabric, giving preference to CPU ports local to each switch. Default to
  * using the first CPU port in the switch tree if the port does not have a CPU
@@ -393,12 +411,16 @@ static int dsa_tree_setup_default_cpu(struct dsa_switch_tree *dst)
  */
 static int dsa_tree_setup_cpu_ports(struct dsa_switch_tree *dst)
 {
-	struct dsa_port *cpu_dp, *dp;
+	struct dsa_port *preferred_cpu_dp, *cpu_dp, *dp;
 
 	list_for_each_entry(cpu_dp, &dst->ports, list) {
 		if (!dsa_port_is_cpu(cpu_dp))
 			continue;
 
+		preferred_cpu_dp = dsa_switch_preferred_default_local_cpu_port(cpu_dp->ds);
+		if (preferred_cpu_dp && preferred_cpu_dp != cpu_dp)
+			continue;
+
 		list_for_each_entry(dp, &dst->ports, list) {
 			/* Prefer a local CPU port */
 			if (dp->ds != cpu_dp->ds)
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 4f645d51c257..f02ebe460965 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -728,6 +728,15 @@ config NF_FLOW_TABLE
 
 	  To compile it as a module, choose M here.
 
+config NF_FLOW_TABLE_PROCFS
+	bool "Supply flow table statistics in procfs"
+	default y
+	depends on PROC_FS
+	depends on SYSCTL
+	help
+	  This option enables for the flow table offload statistics
+	  to be shown in procfs under net/netfilter/nf_flowtable.
+
 config NETFILTER_XTABLES
 	tristate "Netfilter Xtables support (required for ip_tables)"
 	default m if NETFILTER_ADVANCED=n
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index aab20e575ecd..3f77f20ae39e 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -124,6 +124,7 @@ obj-$(CONFIG_NFT_FWD_NETDEV)	+= nft_fwd_netdev.o
 obj-$(CONFIG_NF_FLOW_TABLE)	+= nf_flow_table.o
 nf_flow_table-objs		:= nf_flow_table_core.o nf_flow_table_ip.o \
 				   nf_flow_table_offload.o
+nf_flow_table-$(CONFIG_NF_FLOW_TABLE_PROCFS) += nf_flow_table_procfs.o
 
 obj-$(CONFIG_NF_FLOW_TABLE_INET) += nf_flow_table_inet.o
 
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index e78cdd73ef62..beb0e84b5f42 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -606,14 +606,74 @@ void nf_flow_table_free(struct nf_flowtable *flow_table)
 }
 EXPORT_SYMBOL_GPL(nf_flow_table_free);
 
+static int nf_flow_table_init_net(struct net *net)
+{
+	net->ft.stat = alloc_percpu(struct nf_flow_table_stat);
+	return net->ft.stat ? 0 : -ENOMEM;
+}
+
+static void nf_flow_table_fini_net(struct net *net)
+{
+	free_percpu(net->ft.stat);
+}
+
+static int nf_flow_table_pernet_init(struct net *net)
+{
+	int ret;
+
+	ret = nf_flow_table_init_net(net);
+	if (ret < 0)
+		return ret;
+
+	ret = nf_flow_table_init_proc(net);
+	if (ret < 0)
+		goto out_proc;
+
+	return 0;
+
+out_proc:
+	nf_flow_table_fini_net(net);
+	return ret;
+}
+
+static void nf_flow_table_pernet_exit(struct list_head *net_exit_list)
+{
+	struct net *net;
+
+	list_for_each_entry(net, net_exit_list, exit_list) {
+		nf_flow_table_fini_proc(net);
+		nf_flow_table_fini_net(net);
+	}
+}
+
+static struct pernet_operations nf_flow_table_net_ops = {
+	.init = nf_flow_table_pernet_init,
+	.exit_batch = nf_flow_table_pernet_exit,
+};
+
 static int __init nf_flow_table_module_init(void)
 {
-	return nf_flow_table_offload_init();
+	int ret;
+
+	ret = register_pernet_subsys(&nf_flow_table_net_ops);
+	if (ret < 0)
+		return ret;
+
+	ret = nf_flow_table_offload_init();
+	if (ret)
+		goto out_offload;
+
+	return 0;
+
+out_offload:
+	unregister_pernet_subsys(&nf_flow_table_net_ops);
+	return ret;
 }
 
 static void __exit nf_flow_table_module_exit(void)
 {
 	nf_flow_table_offload_exit();
+	unregister_pernet_subsys(&nf_flow_table_net_ops);
 }
 
 module_init(nf_flow_table_module_init);
diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow_table_inet.c
index 280fdd32965f..6783ea220f8f 100644
--- a/net/netfilter/nf_flow_table_inet.c
+++ b/net/netfilter/nf_flow_table_inet.c
@@ -21,7 +21,8 @@ nf_flow_offload_inet_hook(void *priv, struct sk_buff *skb,
 		proto = veth->h_vlan_encapsulated_proto;
 		break;
 	case htons(ETH_P_PPP_SES):
-		proto = nf_flow_pppoe_proto(skb);
+		if (!nf_flow_pppoe_proto(skb, &proto))
+			return NF_ACCEPT;
 		break;
 	default:
 		proto = skb->protocol;
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 28026467b54c..f3227f931696 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -156,7 +156,7 @@ static void nf_flow_tuple_encap(struct sk_buff *skb,
 		tuple->encap[i].proto = skb->protocol;
 		break;
 	case htons(ETH_P_PPP_SES):
-		phdr = (struct pppoe_hdr *)skb_mac_header(skb);
+		phdr = (struct pppoe_hdr *)skb_network_header(skb);
 		tuple->encap[i].id = ntohs(phdr->sid);
 		tuple->encap[i].proto = skb->protocol;
 		break;
@@ -246,10 +246,11 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
 	return NF_STOLEN;
 }
 
-static bool nf_flow_skb_encap_protocol(const struct sk_buff *skb, __be16 proto,
+static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
 				       u32 *offset)
 {
 	struct vlan_ethhdr *veth;
+	__be16 inner_proto;
 
 	switch (skb->protocol) {
 	case htons(ETH_P_8021Q):
@@ -260,7 +261,8 @@ static bool nf_flow_skb_encap_protocol(const struct sk_buff *skb, __be16 proto,
 		}
 		break;
 	case htons(ETH_P_PPP_SES):
-		if (nf_flow_pppoe_proto(skb) == proto) {
+		if (nf_flow_pppoe_proto(skb, &inner_proto) &&
+		    inner_proto == proto) {
 			*offset += PPPOE_SES_HLEN;
 			return true;
 		}
@@ -289,7 +291,7 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
 			skb_reset_network_header(skb);
 			break;
 		case htons(ETH_P_PPP_SES):
-			skb->protocol = nf_flow_pppoe_proto(skb);
+			skb->protocol = __nf_flow_pppoe_proto(skb);
 			skb_pull(skb, PPPOE_SES_HLEN);
 			skb_reset_network_header(skb);
 			break;
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 336f282a221f..6ac1ebe17456 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -953,17 +953,22 @@ static void flow_offload_work_stats(struct flow_offload_work *offload)
 static void flow_offload_work_handler(struct work_struct *work)
 {
 	struct flow_offload_work *offload;
+	struct net *net;
 
 	offload = container_of(work, struct flow_offload_work, work);
+	net = read_pnet(&offload->flowtable->net);
 	switch (offload->cmd) {
 		case FLOW_CLS_REPLACE:
 			flow_offload_work_add(offload);
+			NF_FLOW_TABLE_STAT_DEC_ATOMIC(net, count_wq_add);
 			break;
 		case FLOW_CLS_DESTROY:
 			flow_offload_work_del(offload);
+			NF_FLOW_TABLE_STAT_DEC_ATOMIC(net, count_wq_del);
 			break;
 		case FLOW_CLS_STATS:
 			flow_offload_work_stats(offload);
+			NF_FLOW_TABLE_STAT_DEC_ATOMIC(net, count_wq_stats);
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -975,12 +980,18 @@ static void flow_offload_work_handler(struct work_struct *work)
 
 static void flow_offload_queue_work(struct flow_offload_work *offload)
 {
-	if (offload->cmd == FLOW_CLS_REPLACE)
+	struct net *net = read_pnet(&offload->flowtable->net);
+
+	if (offload->cmd == FLOW_CLS_REPLACE) {
+		NF_FLOW_TABLE_STAT_INC(net, count_wq_add);
 		queue_work(nf_flow_offload_add_wq, &offload->work);
-	else if (offload->cmd == FLOW_CLS_DESTROY)
+	} else if (offload->cmd == FLOW_CLS_DESTROY) {
+		NF_FLOW_TABLE_STAT_INC(net, count_wq_del);
 		queue_work(nf_flow_offload_del_wq, &offload->work);
-	else
+	} else {
+		NF_FLOW_TABLE_STAT_INC(net, count_wq_stats);
 		queue_work(nf_flow_offload_stats_wq, &offload->work);
+	}
 }
 
 static struct flow_offload_work *
diff --git a/net/netfilter/nf_flow_table_procfs.c b/net/netfilter/nf_flow_table_procfs.c
new file mode 100644
index 000000000000..159b033a43e6
--- /dev/null
+++ b/net/netfilter/nf_flow_table_procfs.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <net/netfilter/nf_flow_table.h>
+
+static void *nf_flow_table_cpu_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct net *net = seq_file_net(seq);
+	int cpu;
+
+	if (*pos == 0)
+		return SEQ_START_TOKEN;
+
+	for (cpu = *pos - 1; cpu < nr_cpu_ids; ++cpu) {
+		if (!cpu_possible(cpu))
+			continue;
+		*pos = cpu + 1;
+		return per_cpu_ptr(net->ft.stat, cpu);
+	}
+
+	return NULL;
+}
+
+static void *nf_flow_table_cpu_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct net *net = seq_file_net(seq);
+	int cpu;
+
+	for (cpu = *pos; cpu < nr_cpu_ids; ++cpu) {
+		if (!cpu_possible(cpu))
+			continue;
+		*pos = cpu + 1;
+		return per_cpu_ptr(net->ft.stat, cpu);
+	}
+	(*pos)++;
+	return NULL;
+}
+
+static void nf_flow_table_cpu_seq_stop(struct seq_file *seq, void *v)
+{
+}
+
+static int nf_flow_table_cpu_seq_show(struct seq_file *seq, void *v)
+{
+	const struct nf_flow_table_stat *st = v;
+
+	if (v == SEQ_START_TOKEN) {
+		seq_puts(seq, "wq_add   wq_del   wq_stats\n");
+		return 0;
+	}
+
+	seq_printf(seq, "%8d %8d %8d\n",
+		   st->count_wq_add,
+		   st->count_wq_del,
+		   st->count_wq_stats
+		);
+	return 0;
+}
+
+static const struct seq_operations nf_flow_table_cpu_seq_ops = {
+	.start	= nf_flow_table_cpu_seq_start,
+	.next	= nf_flow_table_cpu_seq_next,
+	.stop	= nf_flow_table_cpu_seq_stop,
+	.show	= nf_flow_table_cpu_seq_show,
+};
+
+int nf_flow_table_init_proc(struct net *net)
+{
+	struct proc_dir_entry *pde;
+
+	pde = proc_create_net("nf_flowtable", 0444, net->proc_net_stat,
+			      &nf_flow_table_cpu_seq_ops,
+			      sizeof(struct seq_net_private));
+	return pde ? 0 : -ENOMEM;
+}
+
+void nf_flow_table_fini_proc(struct net *net)
+{
+	remove_proc_entry("nf_flowtable", net->proc_net_stat);
+}
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 113c1ebe4a5b..3999b89793fc 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2821,7 +2821,7 @@ static const struct nft_expr_type *__nft_expr_type_get(u8 family,
 {
 	const struct nft_expr_type *type, *candidate = NULL;
 
-	list_for_each_entry(type, &nf_tables_expressions, list) {
+	list_for_each_entry_rcu(type, &nf_tables_expressions, list) {
 		if (!nla_strcmp(nla, type->name)) {
 			if (!type->family && !candidate)
 				candidate = type;
@@ -2853,9 +2853,13 @@ static const struct nft_expr_type *nft_expr_type_get(struct net *net,
 	if (nla == NULL)
 		return ERR_PTR(-EINVAL);
 
+	rcu_read_lock();
 	type = __nft_expr_type_get(family, nla);
-	if (type != NULL && try_module_get(type->owner))
+	if (type != NULL && try_module_get(type->owner)) {
+		rcu_read_unlock();
 		return type;
+	}
+	rcu_read_unlock();
 
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
@@ -7041,7 +7045,7 @@ static const struct nft_object_type *__nft_obj_type_get(u32 objtype, u8 family)
 {
 	const struct nft_object_type *type;
 
-	list_for_each_entry(type, &nf_tables_objects, list) {
+	list_for_each_entry_rcu(type, &nf_tables_objects, list) {
 		if (type->family != NFPROTO_UNSPEC &&
 		    type->family != family)
 			continue;
@@ -7057,9 +7061,13 @@ nft_obj_type_get(struct net *net, u32 objtype, u8 family)
 {
 	const struct nft_object_type *type;
 
+	rcu_read_lock();
 	type = __nft_obj_type_get(objtype, family);
-	if (type != NULL && try_module_get(type->owner))
+	if (type != NULL && try_module_get(type->owner)) {
+		rcu_read_unlock();
 		return type;
+	}
+	rcu_read_unlock();
 
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 58eca2616273..2299ced939c4 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1994,6 +1994,8 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 		rules_fx = rules_f0;
 
 		nft_pipapo_for_each_field(f, i, m) {
+			bool last = i == m->field_count - 1;
+
 			if (!pipapo_match_field(f, start, rules_fx,
 						match_start, match_end))
 				break;
@@ -2006,16 +2008,18 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 
 			match_start += NFT_PIPAPO_GROUPS_PADDED_SIZE(f);
 			match_end += NFT_PIPAPO_GROUPS_PADDED_SIZE(f);
-		}
 
-		if (i == m->field_count) {
-			priv->dirty = true;
-			pipapo_drop(m, rulemap);
-			return;
+			if (last && f->mt[rulemap[i].to].e == e) {
+				priv->dirty = true;
+				pipapo_drop(m, rulemap);
+				return;
+			}
 		}
 
 		first_rule += rules_f0;
 	}
+
+	WARN_ON_ONCE(1); /* elem_priv not found */
 }
 
 /**
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 628d97c195a7..f66f86704901 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2565,7 +2565,9 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 					WRITE_ONCE(u->oob_skb, NULL);
 					consume_skb(skb);
 				}
-			} else if (!(flags & MSG_PEEK)) {
+			} else if (flags & MSG_PEEK) {
+				skb = NULL;
+			} else {
 				skb_unlink(skb, &sk->sk_receive_queue);
 				WRITE_ONCE(u->oob_skb, NULL);
 				if (!WARN_ON_ONCE(skb_unref(skb)))
@@ -2644,18 +2646,16 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		last = skb = skb_peek(&sk->sk_receive_queue);
 		last_len = last ? last->len : 0;
 
+again:
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 		if (skb) {
 			skb = manage_oob(skb, sk, flags, copied);
-			if (!skb) {
+			if (!skb && copied) {
 				unix_state_unlock(sk);
-				if (copied)
-					break;
-				goto redo;
+				break;
 			}
 		}
 #endif
-again:
 		if (skb == NULL) {
 			if (copied >= target)
 				goto unlock;
diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index b1ede6249866..b7c8f29c09a9 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -18,7 +18,7 @@ echo 'sched:*' > set_event
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
@@ -29,7 +29,7 @@ echo 1 > events/sched/enable
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
@@ -40,7 +40,7 @@ echo 0 > events/sched/enable
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -ne 0 ]; then
     fail "any of scheduler events should not be recorded"
 fi

