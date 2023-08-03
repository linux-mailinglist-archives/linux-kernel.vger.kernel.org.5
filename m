Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5331776E587
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbjHCKWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjHCKVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:21:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CBA4697;
        Thu,  3 Aug 2023 03:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 593E761D2A;
        Thu,  3 Aug 2023 10:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DE2C433C8;
        Thu,  3 Aug 2023 10:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691058012;
        bh=ElkG+hcC9XG6fJkc4gzEPNjvhsoE1OXLBDRo3eu7a6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mWC85wMYOQbdQ39hRQ5y/Bi9l541P+lyhamjO6JpdRxJIZap7GBrtFcWrRzDI/rTf
         lFP1xPwHoAWsQh/ExtILSfocEOxy4WosWTk5DdggQikEZMpDJoRgKUDwmy/JFSpf/O
         a7NSZ/6GMQvpnlnm3Wwj4fG+9+IJWnWbJfjGA1sA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.43
Date:   Thu,  3 Aug 2023 12:19:55 +0200
Message-ID: <2023080355-catchable-overboard-cc82@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023080354-antivirus-villain-c9aa@gregkh>
References: <2023080354-antivirus-villain-c9aa@gregkh>
MIME-Version: 1.0
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

diff --git a/Documentation/ABI/testing/sysfs-module b/Documentation/ABI/testing/sysfs-module
index 08886367d047..62addab47d0c 100644
--- a/Documentation/ABI/testing/sysfs-module
+++ b/Documentation/ABI/testing/sysfs-module
@@ -60,3 +60,14 @@ Description:	Module taint flags:
 			C   staging driver module
 			E   unsigned module
 			==  =====================
+
+What:		/sys/module/grant_table/parameters/free_per_iteration
+Date:		July 2023
+KernelVersion:	6.5 but backported to all supported stable branches
+Contact:	Xen developer discussion <xen-devel@lists.xenproject.org>
+Description:	Read and write number of grant entries to attempt to free per iteration.
+
+		Note: Future versions of Xen and Linux may provide a better
+		interface for controlling the rate of deferred grant reclaim
+		or may not need it at all.
+Users:		Qubes OS (https://www.qubes-os.org)
diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
index 82e29837d589..5a6993795bd2 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -63,31 +63,28 @@ information submitted to the security list and any followup discussions
 of the report are treated confidentially even after the embargo has been
 lifted, in perpetuity.
 
-Coordination
-------------
-
-Fixes for sensitive bugs, such as those that might lead to privilege
-escalations, may need to be coordinated with the private
-<linux-distros@vs.openwall.org> mailing list so that distribution vendors
-are well prepared to issue a fixed kernel upon public disclosure of the
-upstream fix. Distros will need some time to test the proposed patch and
-will generally request at least a few days of embargo, and vendor update
-publication prefers to happen Tuesday through Thursday. When appropriate,
-the security team can assist with this coordination, or the reporter can
-include linux-distros from the start. In this case, remember to prefix
-the email Subject line with "[vs]" as described in the linux-distros wiki:
-<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
+Coordination with other groups
+------------------------------
+
+The kernel security team strongly recommends that reporters of potential
+security issues NEVER contact the "linux-distros" mailing list until
+AFTER discussing it with the kernel security team.  Do not Cc: both
+lists at once.  You may contact the linux-distros mailing list after a
+fix has been agreed on and you fully understand the requirements that
+doing so will impose on you and the kernel community.
+
+The different lists have different goals and the linux-distros rules do
+not contribute to actually fixing any potential security problems.
 
 CVE assignment
 --------------
 
-The security team does not normally assign CVEs, nor do we require them
-for reports or fixes, as this can needlessly complicate the process and
-may delay the bug handling. If a reporter wishes to have a CVE identifier
-assigned ahead of public disclosure, they will need to contact the private
-linux-distros list, described above. When such a CVE identifier is known
-before a patch is provided, it is desirable to mention it in the commit
-message if the reporter agrees.
+The security team does not assign CVEs, nor do we require them for
+reports or fixes, as this can needlessly complicate the process and may
+delay the bug handling.  If a reporter wishes to have a CVE identifier
+assigned, they should find one by themselves, for example by contacting
+MITRE directly.  However under no circumstances will a patch inclusion
+be delayed to wait for a CVE identifier to arrive.
 
 Non-disclosure agreements
 -------------------------
diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 55492fea4427..bbc80eff03f9 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -52,6 +52,9 @@ stable kernels.
 | Allwinner      | A64/R18         | UNKNOWN1        | SUN50I_ERRATUM_UNKNOWN1     |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
+| Ampere         | AmpereOne       | AC03_CPU_38     | AMPERE_ERRATUM_AC03_CPU_38  |
++----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2064142        | ARM64_ERRATUM_2064142       |
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 4274cc6a2f94..08a2a6a3782f 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -58,8 +58,8 @@ Synopsis of kprobe_events
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
-		  (x8/x16/x32/x64), "string", "ustring" and bitfield
-		  are supported.
+		  (x8/x16/x32/x64), "string", "ustring", "symbol", "symstr"
+                  and bitfield are supported.
 
   (\*1) only for the probe on function entry (offs == 0).
   (\*2) only for return probe.
@@ -96,6 +96,10 @@ offset, and container-size (usually 32). The syntax is::
 
 Symbol type('symbol') is an alias of u32 or u64 type (depends on BITS_PER_LONG)
 which shows given pointer in "symbol+offset" style.
+On the other hand, symbol-string type ('symstr') converts the given address to
+"symbol+offset/symbolsize" style and stores it as a null-terminated string.
+With 'symstr' type, you can filter the event with wildcard pattern of the
+symbols, and you don't need to solve symbol name by yourself.
 For $comm, the default type is "string"; any other type is invalid.
 
 .. _user_mem_access:
diff --git a/Makefile b/Makefile
index b569bed80052..69cdd0d2946c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 42
+SUBLEVEL = 43
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 20ee745c118a..d5eb2fbab473 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -376,6 +376,25 @@ menu "Kernel Features"
 
 menu "ARM errata workarounds via the alternatives framework"
 
+config AMPERE_ERRATUM_AC03_CPU_38
+        bool "AmpereOne: AC03_CPU_38: Certain bits in the Virtualization Translation Control Register and Translation Control Registers do not follow RES0 semantics"
+	default y
+	help
+	  This option adds an alternative code sequence to work around Ampere
+	  erratum AC03_CPU_38 on AmpereOne.
+
+	  The affected design reports FEAT_HAFDBS as not implemented in
+	  ID_AA64MMFR1_EL1.HAFDBS, but (V)TCR_ELx.{HA,HD} are not RES0
+	  as required by the architecture. The unadvertised HAFDBS
+	  implementation suffers from an additional erratum where hardware
+	  A/D updates can occur after a PTE has been marked invalid.
+
+	  The workaround forces KVM to explicitly set VTCR_EL2.HA to 0,
+	  which avoids enabling unadvertised hardware Access Flag management
+	  at stage-2.
+
+	  If unsure, say Y.
+
 config ARM64_WORKAROUND_CLEAN_CACHE
 	bool
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 89ac00084f38..8dbf3c21ea22 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -722,6 +722,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		MIDR_FIXED(MIDR_CPU_VAR_REV(1,1), BIT(25)),
 		.cpu_enable = cpu_clear_bf16_from_user_emulation,
 	},
+#endif
+#ifdef CONFIG_AMPERE_ERRATUM_AC03_CPU_38
+	{
+		.desc = "AmpereOne erratum AC03_CPU_38",
+		.capability = ARM64_WORKAROUND_AMPERE_AC03_CPU_38,
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 656f613bacf7..59aaf2e68833 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -871,6 +871,8 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	if (task == current)
 		put_cpu_fpsimd_context();
 
+	task_set_vl(task, type, vl);
+
 	/*
 	 * Free the changed states if they are not in use, SME will be
 	 * reallocated to the correct size on next use and we just
@@ -885,8 +887,6 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	if (free_sme)
 		sme_free(task);
 
-	task_set_vl(task, type, vl);
-
 out:
 	update_tsk_thread_flag(task, vec_vl_inherit_flag(type),
 			       flags & PR_SVE_VL_INHERIT);
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index cdf8e76b0be1..ae5f6b5ac80f 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -595,12 +595,22 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
 		lvls = 2;
 	vtcr |= VTCR_EL2_LVLS_TO_SL0(lvls);
 
+#ifdef CONFIG_ARM64_HW_AFDBM
 	/*
 	 * Enable the Hardware Access Flag management, unconditionally
-	 * on all CPUs. The features is RES0 on CPUs without the support
-	 * and must be ignored by the CPUs.
+	 * on all CPUs. In systems that have asymmetric support for the feature
+	 * this allows KVM to leverage hardware support on the subset of cores
+	 * that implement the feature.
+	 *
+	 * The architecture requires VTCR_EL2.HA to be RES0 (thus ignored by
+	 * hardware) on implementations that do not advertise support for the
+	 * feature. As such, setting HA unconditionally is safe, unless you
+	 * happen to be running on a design that has unadvertised support for
+	 * HAFDBS. Here be dragons.
 	 */
-	vtcr |= VTCR_EL2_HA;
+	if (!cpus_have_final_cap(ARM64_WORKAROUND_AMPERE_AC03_CPU_38))
+		vtcr |= VTCR_EL2_HA;
+#endif /* CONFIG_ARM64_HW_AFDBM */
 
 	/* Set the vmid bits */
 	vtcr |= (get_vmid_bits(mmfr1) == 16) ?
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index f1c0347ec31a..14d31d1b2ff0 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -71,6 +71,7 @@ WORKAROUND_2064142
 WORKAROUND_2077057
 WORKAROUND_2457168
 WORKAROUND_2658417
+WORKAROUND_AMPERE_AC03_CPU_38
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
 WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 51d738ac12e5..e737dc8cd660 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -10,6 +10,7 @@ config LOONGARCH
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
index 093885539e70..684b22f54ccc 100644
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -148,7 +148,7 @@ static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm
 			 * no need to call lu32id to do a new filled operation.
 			 */
 			imm_51_31 = (imm >> 31) & 0x1fffff;
-			if (imm_51_31 != 0 || imm_51_31 != 0x1fffff) {
+			if (imm_51_31 != 0 && imm_51_31 != 0x1fffff) {
 				/* lu32id rd, imm_51_32 */
 				imm_51_32 = (imm >> 32) & 0xfffff;
 				emit_insn(ctx, lu32id, rd, imm_51_32);
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 85d3c3b4b7bd..fe64ad43ba88 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -190,9 +190,43 @@ endif
 cflags-$(CONFIG_CAVIUM_CN63XXP1) += -Wa,-mfix-cn63xxp1
 cflags-$(CONFIG_CPU_BMIPS)	+= -march=mips32 -Wa,-mips32 -Wa,--trap
 
+cflags-$(CONFIG_CPU_LOONGSON2E) += $(call cc-option,-march=loongson2e) -Wa,--trap
+cflags-$(CONFIG_CPU_LOONGSON2F) += $(call cc-option,-march=loongson2f) -Wa,--trap
+cflags-$(CONFIG_CPU_LOONGSON64) += $(call cc-option,-march=loongson3a,-march=mips64r2) -Wa,--trap
+# Some -march= flags enable MMI instructions, and GCC complains about that
+# support being enabled alongside -msoft-float. Thus explicitly disable MMI.
+cflags-$(CONFIG_CPU_LOONGSON2EF) += $(call cc-option,-mno-loongson-mmi)
+cflags-$(CONFIG_CPU_LOONGSON64) += $(call cc-option,-mno-loongson-mmi)
+
 cflags-$(CONFIG_CPU_R4000_WORKAROUNDS)	+= $(call cc-option,-mfix-r4000,)
 cflags-$(CONFIG_CPU_R4400_WORKAROUNDS)	+= $(call cc-option,-mfix-r4400,)
 cflags-$(CONFIG_CPU_DADDI_WORKAROUNDS)	+= $(call cc-option,-mno-daddi,)
+ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
+cflags-$(CONFIG_CPU_NOP_WORKAROUNDS) += -Wa,-mfix-loongson2f-nop
+cflags-$(CONFIG_CPU_JUMP_WORKAROUNDS) += -Wa,-mfix-loongson2f-jump
+endif
+
+#
+# Some versions of binutils, not currently mainline as of 2019/02/04, support
+# an -mfix-loongson3-llsc flag which emits a sync prior to each ll instruction
+# to work around a CPU bug (see __SYNC_loongson3_war in asm/sync.h for a
+# description).
+#
+# We disable this in order to prevent the assembler meddling with the
+# instruction that labels refer to, ie. if we label an ll instruction:
+#
+# 1: ll v0, 0(a0)
+#
+# ...then with the assembler fix applied the label may actually point at a sync
+# instruction inserted by the assembler, and if we were using the label in an
+# exception table the table would no longer contain the address of the ll
+# instruction.
+#
+# Avoid this by explicitly disabling that assembler behaviour. If upstream
+# binutils does not merge support for the flag then we can revisit & remove
+# this later - for now it ensures vendor toolchains don't cause problems.
+#
+cflags-$(CONFIG_CPU_LOONGSON64)	+= $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
 
 # For smartmips configurations, there are hundreds of warnings due to ISA overrides
 # in assembly and header files. smartmips is only supported for MIPS32r1 onwards
diff --git a/arch/mips/loongson2ef/Platform b/arch/mips/loongson2ef/Platform
index c6f7a4b95997..d446b705fba4 100644
--- a/arch/mips/loongson2ef/Platform
+++ b/arch/mips/loongson2ef/Platform
@@ -2,41 +2,6 @@
 # Loongson Processors' Support
 #
 
-cflags-$(CONFIG_CPU_LOONGSON2EF)	+= -Wa,--trap
-cflags-$(CONFIG_CPU_LOONGSON2E) += -march=loongson2e
-cflags-$(CONFIG_CPU_LOONGSON2F) += -march=loongson2f
-#
-# Some versions of binutils, not currently mainline as of 2019/02/04, support
-# an -mfix-loongson3-llsc flag which emits a sync prior to each ll instruction
-# to work around a CPU bug (see __SYNC_loongson3_war in asm/sync.h for a
-# description).
-#
-# We disable this in order to prevent the assembler meddling with the
-# instruction that labels refer to, ie. if we label an ll instruction:
-#
-# 1: ll v0, 0(a0)
-#
-# ...then with the assembler fix applied the label may actually point at a sync
-# instruction inserted by the assembler, and if we were using the label in an
-# exception table the table would no longer contain the address of the ll
-# instruction.
-#
-# Avoid this by explicitly disabling that assembler behaviour. If upstream
-# binutils does not merge support for the flag then we can revisit & remove
-# this later - for now it ensures vendor toolchains don't cause problems.
-#
-cflags-$(CONFIG_CPU_LOONGSON2EF)	+= $(call cc-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
-
-# Enable the workarounds for Loongson2f
-ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
-cflags-$(CONFIG_CPU_NOP_WORKAROUNDS) += -Wa,-mfix-loongson2f-nop
-cflags-$(CONFIG_CPU_JUMP_WORKAROUNDS) += -Wa,-mfix-loongson2f-jump
-endif
-
-# Some -march= flags enable MMI instructions, and GCC complains about that
-# support being enabled alongside -msoft-float. Thus explicitly disable MMI.
-cflags-y += $(call cc-option,-mno-loongson-mmi)
-
 #
 # Loongson Machines' Support
 #
diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
index 473404cae1c4..49c9889e3d56 100644
--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -1,19 +1,3 @@
-#
-# Loongson Processors' Support
-#
-
-
-cflags-$(CONFIG_CPU_LOONGSON64)	+= -Wa,--trap
-
-ifdef CONFIG_CPU_LOONGSON64
-cflags-$(CONFIG_CC_IS_GCC) += -march=loongson3a
-cflags-$(CONFIG_CC_IS_CLANG) += -march=mips64r2
-endif
-
-# Some -march= flags enable MMI instructions, and GCC complains about that
-# support being enabled alongside -msoft-float. Thus explicitly disable MMI.
-cflags-y += $(call cc-option,-mno-loongson-mmi)
-
 #
 # Loongson Machines' Support
 #
diff --git a/arch/powerpc/platforms/pseries/vas.c b/arch/powerpc/platforms/pseries/vas.c
index 880b962afc05..041a25c08066 100644
--- a/arch/powerpc/platforms/pseries/vas.c
+++ b/arch/powerpc/platforms/pseries/vas.c
@@ -744,6 +744,12 @@ static int reconfig_close_windows(struct vas_caps *vcap, int excess_creds,
 		}
 
 		task_ref = &win->vas_win.task_ref;
+		/*
+		 * VAS mmap (coproc_mmap()) and its fault handler
+		 * (vas_mmap_fault()) are called after holding mmap lock.
+		 * So hold mmap mutex after mmap_lock to avoid deadlock.
+		 */
+		mmap_write_lock(task_ref->mm);
 		mutex_lock(&task_ref->mmap_mutex);
 		vma = task_ref->vma;
 		/*
@@ -752,7 +758,6 @@ static int reconfig_close_windows(struct vas_caps *vcap, int excess_creds,
 		 */
 		win->vas_win.status |= flag;
 
-		mmap_write_lock(task_ref->mm);
 		/*
 		 * vma is set in the original mapping. But this mapping
 		 * is done with mmap() after the window is opened with ioctl.
@@ -763,8 +768,8 @@ static int reconfig_close_windows(struct vas_caps *vcap, int excess_creds,
 			zap_page_range(vma, vma->vm_start,
 					vma->vm_end - vma->vm_start);
 
-		mmap_write_unlock(task_ref->mm);
 		mutex_unlock(&task_ref->mmap_mutex);
+		mmap_write_unlock(task_ref->mm);
 		/*
 		 * Close VAS window in the hypervisor, but do not
 		 * free vas_window struct since it may be reused
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 02d15c8dc92e..243f673fa651 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2843,6 +2843,7 @@ int s390_replace_asce(struct gmap *gmap)
 	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
 	if (!page)
 		return -ENOMEM;
+	page->index = 0;
 	table = page_to_virt(page);
 	memcpy(table, gmap->table, 1UL << (CRST_ALLOC_ORDER + PAGE_SHIFT));
 
diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 37d60e72cf26..9e71794839e8 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2002 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
-#include <linux/minmax.h>
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -51,7 +50,7 @@ static struct pollfds all_sigio_fds;
 
 static int write_sigio_thread(void *unused)
 {
-	struct pollfds *fds;
+	struct pollfds *fds, tmp;
 	struct pollfd *p;
 	int i, n, respond_fd;
 	char c;
@@ -78,7 +77,9 @@ static int write_sigio_thread(void *unused)
 					       "write_sigio_thread : "
 					       "read on socket failed, "
 					       "err = %d\n", errno);
-				swap(current_poll, next_poll);
+				tmp = current_poll;
+				current_poll = next_poll;
+				next_poll = tmp;
 				respond_fd = sigio_private[1];
 			}
 			else {
diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 82ba4a564e58..2c6698aa218b 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -36,6 +36,7 @@ KVM_X86_OP(get_segment)
 KVM_X86_OP(get_cpl)
 KVM_X86_OP(set_segment)
 KVM_X86_OP(get_cs_db_l_bits)
+KVM_X86_OP(is_valid_cr0)
 KVM_X86_OP(set_cr0)
 KVM_X86_OP_OPTIONAL(post_set_cr3)
 KVM_X86_OP(is_valid_cr4)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ef8cabfbe854..08a84f801bfe 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1488,9 +1488,10 @@ struct kvm_x86_ops {
 	void (*set_segment)(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg);
 	void (*get_cs_db_l_bits)(struct kvm_vcpu *vcpu, int *db, int *l);
+	bool (*is_valid_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
 	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
 	void (*post_set_cr3)(struct kvm_vcpu *vcpu, unsigned long cr3);
-	bool (*is_valid_cr4)(struct kvm_vcpu *vcpu, unsigned long cr0);
+	bool (*is_valid_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	void (*set_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	int (*set_efer)(struct kvm_vcpu *vcpu, u64 efer);
 	void (*get_idt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5518272061bf..991f38f57caf 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1265,10 +1265,10 @@ static void __threshold_remove_blocks(struct threshold_bank *b)
 	struct threshold_block *pos = NULL;
 	struct threshold_block *tmp = NULL;
 
-	kobject_del(b->kobj);
+	kobject_put(b->kobj);
 
 	list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
-		kobject_del(&pos->kobj);
+		kobject_put(b->kobj);
 }
 
 static void threshold_remove_bank(struct threshold_bank *bank)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d3fdec706f1d..c0a5a4f225d9 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -697,9 +697,10 @@ static bool try_fixup_enqcmd_gp(void)
 }
 
 static bool gp_try_fixup_and_notify(struct pt_regs *regs, int trapnr,
-				    unsigned long error_code, const char *str)
+				    unsigned long error_code, const char *str,
+				    unsigned long address)
 {
-	if (fixup_exception(regs, trapnr, error_code, 0))
+	if (fixup_exception(regs, trapnr, error_code, address))
 		return true;
 
 	current->thread.error_code = error_code;
@@ -759,7 +760,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		goto exit;
 	}
 
-	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc))
+	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc, 0))
 		goto exit;
 
 	if (error_code)
@@ -1357,17 +1358,20 @@ DEFINE_IDTENTRY(exc_device_not_available)
 
 #define VE_FAULT_STR "VE fault"
 
-static void ve_raise_fault(struct pt_regs *regs, long error_code)
+static void ve_raise_fault(struct pt_regs *regs, long error_code,
+			   unsigned long address)
 {
 	if (user_mode(regs)) {
 		gp_user_force_sig_segv(regs, X86_TRAP_VE, error_code, VE_FAULT_STR);
 		return;
 	}
 
-	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code, VE_FAULT_STR))
+	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code,
+				    VE_FAULT_STR, address)) {
 		return;
+	}
 
-	die_addr(VE_FAULT_STR, regs, error_code, 0);
+	die_addr(VE_FAULT_STR, regs, error_code, address);
 }
 
 /*
@@ -1431,7 +1435,7 @@ DEFINE_IDTENTRY(exc_virtualization_exception)
 	 * it successfully, treat it as #GP(0) and handle it.
 	 */
 	if (!tdx_handle_virt_exception(regs, &ve))
-		ve_raise_fault(regs, 0);
+		ve_raise_fault(regs, 0, ve.gla);
 
 	cond_local_irq_disable(regs);
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index fc1649b5931a..0a212fe2cd39 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1763,6 +1763,11 @@ static void sev_post_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 	}
 }
 
+static bool svm_is_valid_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+	return true;
+}
+
 void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -4749,6 +4754,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_segment = svm_set_segment,
 	.get_cpl = svm_get_cpl,
 	.get_cs_db_l_bits = svm_get_cs_db_l_bits,
+	.is_valid_cr0 = svm_is_valid_cr0,
 	.set_cr0 = svm_set_cr0,
 	.post_set_cr3 = sev_post_set_cr3,
 	.is_valid_cr4 = svm_is_valid_cr4,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 07aab8592244..4e972b9b68e5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1461,6 +1461,11 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long old_rflags;
 
+	/*
+	 * Unlike CR0 and CR4, RFLAGS handling requires checking if the vCPU
+	 * is an unrestricted guest in order to mark L2 as needing emulation
+	 * if L1 runs L2 as a restricted guest.
+	 */
 	if (is_unrestricted_guest(vcpu)) {
 		kvm_register_mark_available(vcpu, VCPU_EXREG_RFLAGS);
 		vmx->rflags = rflags;
@@ -2970,6 +2975,15 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct kvm_vmx *kvm_vmx = to_kvm_vmx(vcpu->kvm);
 
+	/*
+	 * KVM should never use VM86 to virtualize Real Mode when L2 is active,
+	 * as using VM86 is unnecessary if unrestricted guest is enabled, and
+	 * if unrestricted guest is disabled, VM-Enter (from L1) with CR0.PG=0
+	 * should VM-Fail and KVM should reject userspace attempts to stuff
+	 * CR0.PG=0 when L2 is active.
+	 */
+	WARN_ON_ONCE(is_guest_mode(vcpu));
+
 	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_TR], VCPU_SREG_TR);
 	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_ES], VCPU_SREG_ES);
 	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_DS], VCPU_SREG_DS);
@@ -3160,6 +3174,17 @@ void ept_save_pdptrs(struct kvm_vcpu *vcpu)
 #define CR3_EXITING_BITS (CPU_BASED_CR3_LOAD_EXITING | \
 			  CPU_BASED_CR3_STORE_EXITING)
 
+static bool vmx_is_valid_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+	if (is_guest_mode(vcpu))
+		return nested_guest_cr0_valid(vcpu, cr0);
+
+	if (to_vmx(vcpu)->nested.vmxon)
+		return nested_host_cr0_valid(vcpu, cr0);
+
+	return true;
+}
+
 void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -3169,7 +3194,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	old_cr0_pg = kvm_read_cr0_bits(vcpu, X86_CR0_PG);
 
 	hw_cr0 = (cr0 & ~KVM_VM_CR0_ALWAYS_OFF);
-	if (is_unrestricted_guest(vcpu))
+	if (enable_unrestricted_guest)
 		hw_cr0 |= KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST;
 	else {
 		hw_cr0 |= KVM_VM_CR0_ALWAYS_ON;
@@ -3197,7 +3222,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	}
 #endif
 
-	if (enable_ept && !is_unrestricted_guest(vcpu)) {
+	if (enable_ept && !enable_unrestricted_guest) {
 		/*
 		 * Ensure KVM has an up-to-date snapshot of the guest's CR3.  If
 		 * the below code _enables_ CR3 exiting, vmx_cache_reg() will
@@ -3328,7 +3353,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	unsigned long hw_cr4;
 
 	hw_cr4 = (cr4_read_shadow() & X86_CR4_MCE) | (cr4 & ~X86_CR4_MCE);
-	if (is_unrestricted_guest(vcpu))
+	if (enable_unrestricted_guest)
 		hw_cr4 |= KVM_VM_CR4_ALWAYS_ON_UNRESTRICTED_GUEST;
 	else if (vmx->rmode.vm86_active)
 		hw_cr4 |= KVM_RMODE_VM_CR4_ALWAYS_ON;
@@ -3348,7 +3373,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	vcpu->arch.cr4 = cr4;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR4);
 
-	if (!is_unrestricted_guest(vcpu)) {
+	if (!enable_unrestricted_guest) {
 		if (enable_ept) {
 			if (!is_paging(vcpu)) {
 				hw_cr4 &= ~X86_CR4_PAE;
@@ -5311,18 +5336,11 @@ static int handle_set_cr0(struct kvm_vcpu *vcpu, unsigned long val)
 		val = (val & ~vmcs12->cr0_guest_host_mask) |
 			(vmcs12->guest_cr0 & vmcs12->cr0_guest_host_mask);
 
-		if (!nested_guest_cr0_valid(vcpu, val))
-			return 1;
-
 		if (kvm_set_cr0(vcpu, val))
 			return 1;
 		vmcs_writel(CR0_READ_SHADOW, orig_val);
 		return 0;
 	} else {
-		if (to_vmx(vcpu)->nested.vmxon &&
-		    !nested_host_cr0_valid(vcpu, val))
-			return 1;
-
 		return kvm_set_cr0(vcpu, val);
 	}
 }
@@ -8112,6 +8130,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.set_segment = vmx_set_segment,
 	.get_cpl = vmx_get_cpl,
 	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
+	.is_valid_cr0 = vmx_is_valid_cr0,
 	.set_cr0 = vmx_set_cr0,
 	.is_valid_cr4 = vmx_is_valid_cr4,
 	.set_cr4 = vmx_set_cr4,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f48ab047b41d..32f589b96d99 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -908,6 +908,22 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 }
 EXPORT_SYMBOL_GPL(load_pdptrs);
 
+static bool kvm_is_valid_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+#ifdef CONFIG_X86_64
+	if (cr0 & 0xffffffff00000000UL)
+		return false;
+#endif
+
+	if ((cr0 & X86_CR0_NW) && !(cr0 & X86_CR0_CD))
+		return false;
+
+	if ((cr0 & X86_CR0_PG) && !(cr0 & X86_CR0_PE))
+		return false;
+
+	return static_call(kvm_x86_is_valid_cr0)(vcpu, cr0);
+}
+
 void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0)
 {
 	/*
@@ -948,20 +964,13 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	unsigned long old_cr0 = kvm_read_cr0(vcpu);
 
-	cr0 |= X86_CR0_ET;
-
-#ifdef CONFIG_X86_64
-	if (cr0 & 0xffffffff00000000UL)
+	if (!kvm_is_valid_cr0(vcpu, cr0))
 		return 1;
-#endif
-
-	cr0 &= ~CR0_RESERVED_BITS;
 
-	if ((cr0 & X86_CR0_NW) && !(cr0 & X86_CR0_CD))
-		return 1;
+	cr0 |= X86_CR0_ET;
 
-	if ((cr0 & X86_CR0_PG) && !(cr0 & X86_CR0_PE))
-		return 1;
+	/* Write to CR0 reserved bits are ignored, even on Intel. */
+	cr0 &= ~CR0_RESERVED_BITS;
 
 #ifdef CONFIG_X86_64
 	if ((vcpu->arch.efer & EFER_LME) && !is_paging(vcpu) &&
@@ -11532,7 +11541,8 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 			return false;
 	}
 
-	return kvm_is_valid_cr4(vcpu, sregs->cr4);
+	return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
+	       kvm_is_valid_cr0(vcpu, sregs->cr0);
 }
 
 static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
diff --git a/block/blk-core.c b/block/blk-core.c
index 24ee7785a5ad..ebb7a1689b26 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1140,8 +1140,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 {
 	if (!list_empty(&plug->cb_list))
 		flush_plug_callbacks(plug, from_schedule);
-	if (!rq_list_empty(plug->mq_list))
-		blk_mq_flush_plug_list(plug, from_schedule);
+	blk_mq_flush_plug_list(plug, from_schedule);
 	/*
 	 * Unconditionally flush out cached requests, even if the unplug
 	 * event came from schedule. Since we know hold references to the
diff --git a/block/blk-mq.c b/block/blk-mq.c
index add013d5bbda..100fb0c3114f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2749,7 +2749,14 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct request *rq;
 
-	if (rq_list_empty(plug->mq_list))
+	/*
+	 * We may have been called recursively midway through handling
+	 * plug->mq_list via a schedule() in the driver's queue_rq() callback.
+	 * To avoid mq_list changing under our feet, clear rq_count early and
+	 * bail out specifically if rq_count is 0 rather than checking
+	 * whether the mq_list is empty.
+	 */
+	if (plug->rq_count == 0)
 		return;
 	plug->rq_count = 0;
 
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 8059baf4ef27..2e1cae53536f 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -998,9 +998,6 @@ static void iort_node_get_rmr_info(struct acpi_iort_node *node,
 	for (i = 0; i < node->mapping_count; i++, map++) {
 		struct acpi_iort_node *parent;
 
-		if (!map->id_count)
-			continue;
-
 		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
 				      map->output_reference);
 		if (parent != iommu)
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 757a98f6d7a2..1696700fd2fb 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -53,6 +53,8 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 {
 	acpi_status status = 0;
 	unsigned long long ppc = 0;
+	s32 qos_value;
+	int index;
 	int ret;
 
 	if (!pr)
@@ -72,17 +74,30 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 		}
 	}
 
+	index = ppc;
+
+	if (pr->performance_platform_limit == index ||
+	    ppc >= pr->performance->state_count)
+		return 0;
+
 	pr_debug("CPU %d: _PPC is %d - frequency %s limited\n", pr->id,
-		       (int)ppc, ppc ? "" : "not");
+		 index, index ? "is" : "is not");
 
-	pr->performance_platform_limit = (int)ppc;
+	pr->performance_platform_limit = index;
 
-	if (ppc >= pr->performance->state_count ||
-	    unlikely(!freq_qos_request_active(&pr->perflib_req)))
+	if (unlikely(!freq_qos_request_active(&pr->perflib_req)))
 		return 0;
 
-	ret = freq_qos_update_request(&pr->perflib_req,
-			pr->performance->states[ppc].core_frequency * 1000);
+	/*
+	 * If _PPC returns 0, it means that all of the available states can be
+	 * used ("no limit").
+	 */
+	if (index == 0)
+		qos_value = FREQ_QOS_MAX_DEFAULT_VALUE;
+	else
+		qos_value = pr->performance->states[index].core_frequency * 1000;
+
+	ret = freq_qos_update_request(&pr->perflib_req, qos_value);
 	if (ret < 0) {
 		pr_warn("Failed to update perflib freq constraint: CPU%d (%d)\n",
 			pr->id, ret);
@@ -165,9 +180,16 @@ void acpi_processor_ppc_init(struct cpufreq_policy *policy)
 		if (!pr)
 			continue;
 
+		/*
+		 * Reset performance_platform_limit in case there is a stale
+		 * value in it, so as to make it match the "no limit" QoS value
+		 * below.
+		 */
+		pr->performance_platform_limit = 0;
+
 		ret = freq_qos_add_request(&policy->constraints,
-					   &pr->perflib_req,
-					   FREQ_QOS_MAX, INT_MAX);
+					   &pr->perflib_req, FREQ_QOS_MAX,
+					   FREQ_QOS_MAX_DEFAULT_VALUE);
 		if (ret < 0)
 			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
 			       cpu, ret);
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 9dd6bffefb48..602472d4e693 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -260,7 +260,7 @@ static u8 ns87560_check_status(struct ata_port *ap)
  *	LOCKING:
  *	Inherited from caller.
  */
-void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+static void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 0eb7f02b3ad5..922ed457db19 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -29,6 +29,7 @@ extern u64 pm_runtime_active_time(struct device *dev);
 #define WAKE_IRQ_DEDICATED_MASK		(WAKE_IRQ_DEDICATED_ALLOCATED | \
 					 WAKE_IRQ_DEDICATED_MANAGED | \
 					 WAKE_IRQ_DEDICATED_REVERSE)
+#define WAKE_IRQ_DEDICATED_ENABLED	BIT(3)
 
 struct wake_irq {
 	struct device *dev;
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index d487a6bac630..afd094dec5ca 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -314,8 +314,10 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
 	return;
 
 enable:
-	if (!can_change_status || !(wirq->status & WAKE_IRQ_DEDICATED_REVERSE))
+	if (!can_change_status || !(wirq->status & WAKE_IRQ_DEDICATED_REVERSE)) {
 		enable_irq(wirq->irq);
+		wirq->status |= WAKE_IRQ_DEDICATED_ENABLED;
+	}
 }
 
 /**
@@ -336,8 +338,10 @@ void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable)
 	if (cond_disable && (wirq->status & WAKE_IRQ_DEDICATED_REVERSE))
 		return;
 
-	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED)
+	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED) {
+		wirq->status &= ~WAKE_IRQ_DEDICATED_ENABLED;
 		disable_irq_nosync(wirq->irq);
+	}
 }
 
 /**
@@ -376,7 +380,7 @@ void dev_pm_arm_wake_irq(struct wake_irq *wirq)
 
 	if (device_may_wakeup(wirq->dev)) {
 		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
-		    !pm_runtime_status_suspended(wirq->dev))
+		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
 			enable_irq(wirq->irq);
 
 		enable_irq_wake(wirq->irq);
@@ -399,7 +403,7 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
 		disable_irq_wake(wirq->irq);
 
 		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
-		    !pm_runtime_status_suspended(wirq->dev))
+		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
 			disable_irq_nosync(wirq->irq);
 	}
 }
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e009f480675d..daec0321cd76 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3850,51 +3850,82 @@ static void wake_lock_waiters(struct rbd_device *rbd_dev, int result)
 	list_splice_tail_init(&rbd_dev->acquiring_list, &rbd_dev->running_list);
 }
 
-static int get_lock_owner_info(struct rbd_device *rbd_dev,
-			       struct ceph_locker **lockers, u32 *num_lockers)
+static bool locker_equal(const struct ceph_locker *lhs,
+			 const struct ceph_locker *rhs)
+{
+	return lhs->id.name.type == rhs->id.name.type &&
+	       lhs->id.name.num == rhs->id.name.num &&
+	       !strcmp(lhs->id.cookie, rhs->id.cookie) &&
+	       ceph_addr_equal_no_type(&lhs->info.addr, &rhs->info.addr);
+}
+
+static void free_locker(struct ceph_locker *locker)
+{
+	if (locker)
+		ceph_free_lockers(locker, 1);
+}
+
+static struct ceph_locker *get_lock_owner_info(struct rbd_device *rbd_dev)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	struct ceph_locker *lockers;
+	u32 num_lockers;
 	u8 lock_type;
 	char *lock_tag;
+	u64 handle;
 	int ret;
 
-	dout("%s rbd_dev %p\n", __func__, rbd_dev);
-
 	ret = ceph_cls_lock_info(osdc, &rbd_dev->header_oid,
 				 &rbd_dev->header_oloc, RBD_LOCK_NAME,
-				 &lock_type, &lock_tag, lockers, num_lockers);
-	if (ret)
-		return ret;
+				 &lock_type, &lock_tag, &lockers, &num_lockers);
+	if (ret) {
+		rbd_warn(rbd_dev, "failed to retrieve lockers: %d", ret);
+		return ERR_PTR(ret);
+	}
 
-	if (*num_lockers == 0) {
+	if (num_lockers == 0) {
 		dout("%s rbd_dev %p no lockers detected\n", __func__, rbd_dev);
+		lockers = NULL;
 		goto out;
 	}
 
 	if (strcmp(lock_tag, RBD_LOCK_TAG)) {
 		rbd_warn(rbd_dev, "locked by external mechanism, tag %s",
 			 lock_tag);
-		ret = -EBUSY;
-		goto out;
+		goto err_busy;
 	}
 
-	if (lock_type == CEPH_CLS_LOCK_SHARED) {
-		rbd_warn(rbd_dev, "shared lock type detected");
-		ret = -EBUSY;
-		goto out;
+	if (lock_type != CEPH_CLS_LOCK_EXCLUSIVE) {
+		rbd_warn(rbd_dev, "incompatible lock type detected");
+		goto err_busy;
 	}
 
-	if (strncmp((*lockers)[0].id.cookie, RBD_LOCK_COOKIE_PREFIX,
-		    strlen(RBD_LOCK_COOKIE_PREFIX))) {
+	WARN_ON(num_lockers != 1);
+	ret = sscanf(lockers[0].id.cookie, RBD_LOCK_COOKIE_PREFIX " %llu",
+		     &handle);
+	if (ret != 1) {
 		rbd_warn(rbd_dev, "locked by external mechanism, cookie %s",
-			 (*lockers)[0].id.cookie);
-		ret = -EBUSY;
-		goto out;
+			 lockers[0].id.cookie);
+		goto err_busy;
 	}
+	if (ceph_addr_is_blank(&lockers[0].info.addr)) {
+		rbd_warn(rbd_dev, "locker has a blank address");
+		goto err_busy;
+	}
+
+	dout("%s rbd_dev %p got locker %s%llu@%pISpc/%u handle %llu\n",
+	     __func__, rbd_dev, ENTITY_NAME(lockers[0].id.name),
+	     &lockers[0].info.addr.in_addr,
+	     le32_to_cpu(lockers[0].info.addr.nonce), handle);
 
 out:
 	kfree(lock_tag);
-	return ret;
+	return lockers;
+
+err_busy:
+	kfree(lock_tag);
+	ceph_free_lockers(lockers, num_lockers);
+	return ERR_PTR(-EBUSY);
 }
 
 static int find_watcher(struct rbd_device *rbd_dev,
@@ -3948,51 +3979,68 @@ static int find_watcher(struct rbd_device *rbd_dev,
 static int rbd_try_lock(struct rbd_device *rbd_dev)
 {
 	struct ceph_client *client = rbd_dev->rbd_client->client;
-	struct ceph_locker *lockers;
-	u32 num_lockers;
+	struct ceph_locker *locker, *refreshed_locker;
 	int ret;
 
 	for (;;) {
+		locker = refreshed_locker = NULL;
+
 		ret = rbd_lock(rbd_dev);
 		if (ret != -EBUSY)
-			return ret;
+			goto out;
 
 		/* determine if the current lock holder is still alive */
-		ret = get_lock_owner_info(rbd_dev, &lockers, &num_lockers);
-		if (ret)
-			return ret;
-
-		if (num_lockers == 0)
+		locker = get_lock_owner_info(rbd_dev);
+		if (IS_ERR(locker)) {
+			ret = PTR_ERR(locker);
+			locker = NULL;
+			goto out;
+		}
+		if (!locker)
 			goto again;
 
-		ret = find_watcher(rbd_dev, lockers);
+		ret = find_watcher(rbd_dev, locker);
 		if (ret)
 			goto out; /* request lock or error */
 
+		refreshed_locker = get_lock_owner_info(rbd_dev);
+		if (IS_ERR(refreshed_locker)) {
+			ret = PTR_ERR(refreshed_locker);
+			refreshed_locker = NULL;
+			goto out;
+		}
+		if (!refreshed_locker ||
+		    !locker_equal(locker, refreshed_locker))
+			goto again;
+
 		rbd_warn(rbd_dev, "breaking header lock owned by %s%llu",
-			 ENTITY_NAME(lockers[0].id.name));
+			 ENTITY_NAME(locker->id.name));
 
 		ret = ceph_monc_blocklist_add(&client->monc,
-					      &lockers[0].info.addr);
+					      &locker->info.addr);
 		if (ret) {
-			rbd_warn(rbd_dev, "blocklist of %s%llu failed: %d",
-				 ENTITY_NAME(lockers[0].id.name), ret);
+			rbd_warn(rbd_dev, "failed to blocklist %s%llu: %d",
+				 ENTITY_NAME(locker->id.name), ret);
 			goto out;
 		}
 
 		ret = ceph_cls_break_lock(&client->osdc, &rbd_dev->header_oid,
 					  &rbd_dev->header_oloc, RBD_LOCK_NAME,
-					  lockers[0].id.cookie,
-					  &lockers[0].id.name);
-		if (ret && ret != -ENOENT)
+					  locker->id.cookie, &locker->id.name);
+		if (ret && ret != -ENOENT) {
+			rbd_warn(rbd_dev, "failed to break header lock: %d",
+				 ret);
 			goto out;
+		}
 
 again:
-		ceph_free_lockers(lockers, num_lockers);
+		free_locker(refreshed_locker);
+		free_locker(locker);
 	}
 
 out:
-	ceph_free_lockers(lockers, num_lockers);
+	free_locker(refreshed_locker);
+	free_locker(locker);
 	return ret;
 }
 
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c56d1c6d8e58..4459cfbdbcb1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1529,22 +1529,18 @@ static struct ublk_device *ublk_get_device_from_id(int idx)
 	return ub;
 }
 
-static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
+static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	int ublksrv_pid = (int)header->data[0];
-	struct ublk_device *ub;
 	struct gendisk *disk;
 	int ret = -EINVAL;
 
 	if (ublksrv_pid <= 0)
 		return -EINVAL;
 
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return -EINVAL;
-
-	wait_for_completion_interruptible(&ub->completion);
+	if (wait_for_completion_interruptible(&ub->completion) != 0)
+		return -EINTR;
 
 	schedule_delayed_work(&ub->monitor_work, UBLK_DAEMON_MONITOR_PERIOD);
 
@@ -1593,21 +1589,20 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 		put_disk(disk);
 out_unlock:
 	mutex_unlock(&ub->mutex);
-	ublk_put_device(ub);
 	return ret;
 }
 
-static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
+static int ublk_ctrl_get_queue_affinity(struct ublk_device *ub,
+		struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
-	struct ublk_device *ub;
 	cpumask_var_t cpumask;
 	unsigned long queue;
 	unsigned int retlen;
 	unsigned int i;
-	int ret = -EINVAL;
-	
+	int ret;
+
 	if (header->len * BITS_PER_BYTE < nr_cpu_ids)
 		return -EINVAL;
 	if (header->len & (sizeof(unsigned long)-1))
@@ -1615,17 +1610,12 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 	if (!header->addr)
 		return -EINVAL;
 
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return -EINVAL;
-
 	queue = header->data[0];
 	if (queue >= ub->dev_info.nr_hw_queues)
-		goto out_put_device;
+		return -EINVAL;
 
-	ret = -ENOMEM;
 	if (!zalloc_cpumask_var(&cpumask, GFP_KERNEL))
-		goto out_put_device;
+		return -ENOMEM;
 
 	for_each_possible_cpu(i) {
 		if (ub->tag_set.map[HCTX_TYPE_DEFAULT].mq_map[i] == queue)
@@ -1643,8 +1633,6 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 	ret = 0;
 out_free_cpumask:
 	free_cpumask_var(cpumask);
-out_put_device:
-	ublk_put_device(ub);
 	return ret;
 }
 
@@ -1765,30 +1753,27 @@ static inline bool ublk_idr_freed(int id)
 	return ptr == NULL;
 }
 
-static int ublk_ctrl_del_dev(int idx)
+static int ublk_ctrl_del_dev(struct ublk_device **p_ub)
 {
-	struct ublk_device *ub;
+	struct ublk_device *ub = *p_ub;
+	int idx = ub->ub_number;
 	int ret;
 
 	ret = mutex_lock_killable(&ublk_ctl_mutex);
 	if (ret)
 		return ret;
 
-	ub = ublk_get_device_from_id(idx);
-	if (ub) {
-		ublk_remove(ub);
-		ublk_put_device(ub);
-		ret = 0;
-	} else {
-		ret = -ENODEV;
-	}
+	ublk_remove(ub);
+
+	/* Mark the reference as consumed */
+	*p_ub = NULL;
+	ublk_put_device(ub);
 
 	/*
 	 * Wait until the idr is removed, then it can be reused after
 	 * DEL_DEV command is returned.
 	 */
-	if (!ret)
-		wait_event(ublk_idr_wq, ublk_idr_freed(idx));
+	wait_event(ublk_idr_wq, ublk_idr_freed(idx));
 	mutex_unlock(&ublk_ctl_mutex);
 
 	return ret;
@@ -1803,50 +1788,36 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 			header->data[0], header->addr, header->len);
 }
 
-static int ublk_ctrl_stop_dev(struct io_uring_cmd *cmd)
+static int ublk_ctrl_stop_dev(struct ublk_device *ub)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
-	struct ublk_device *ub;
-
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return -EINVAL;
-
 	ublk_stop_dev(ub);
 	cancel_work_sync(&ub->stop_work);
 	cancel_work_sync(&ub->quiesce_work);
 
-	ublk_put_device(ub);
 	return 0;
 }
 
-static int ublk_ctrl_get_dev_info(struct io_uring_cmd *cmd)
+static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
+		struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
-	struct ublk_device *ub;
-	int ret = 0;
 
 	if (header->len < sizeof(struct ublksrv_ctrl_dev_info) || !header->addr)
 		return -EINVAL;
 
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return -EINVAL;
-
 	if (copy_to_user(argp, &ub->dev_info, sizeof(ub->dev_info)))
-		ret = -EFAULT;
-	ublk_put_device(ub);
+		return -EFAULT;
 
-	return ret;
+	return 0;
 }
 
-static int ublk_ctrl_get_params(struct io_uring_cmd *cmd)
+static int ublk_ctrl_get_params(struct ublk_device *ub,
+		struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublk_params_header ph;
-	struct ublk_device *ub;
 	int ret;
 
 	if (header->len <= sizeof(ph) || !header->addr)
@@ -1861,10 +1832,6 @@ static int ublk_ctrl_get_params(struct io_uring_cmd *cmd)
 	if (ph.len > sizeof(struct ublk_params))
 		ph.len = sizeof(struct ublk_params);
 
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return -EINVAL;
-
 	mutex_lock(&ub->mutex);
 	if (copy_to_user(argp, &ub->params, ph.len))
 		ret = -EFAULT;
@@ -1872,16 +1839,15 @@ static int ublk_ctrl_get_params(struct io_uring_cmd *cmd)
 		ret = 0;
 	mutex_unlock(&ub->mutex);
 
-	ublk_put_device(ub);
 	return ret;
 }
 
-static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
+static int ublk_ctrl_set_params(struct ublk_device *ub,
+		struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublk_params_header ph;
-	struct ublk_device *ub;
 	int ret = -EFAULT;
 
 	if (header->len <= sizeof(ph) || !header->addr)
@@ -1896,10 +1862,6 @@ static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
 	if (ph.len > sizeof(struct ublk_params))
 		ph.len = sizeof(struct ublk_params);
 
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return -EINVAL;
-
 	/* parameters can only be changed when device isn't live */
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_LIVE) {
@@ -1914,7 +1876,6 @@ static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
 			ub->params.types = 0;
 	}
 	mutex_unlock(&ub->mutex);
-	ublk_put_device(ub);
 
 	return ret;
 }
@@ -1941,17 +1902,13 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 }
 
-static int ublk_ctrl_start_recovery(struct io_uring_cmd *cmd)
+static int ublk_ctrl_start_recovery(struct ublk_device *ub,
+		struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
-	struct ublk_device *ub;
 	int ret = -EINVAL;
 	int i;
 
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return ret;
-
 	mutex_lock(&ub->mutex);
 	if (!ublk_can_use_recovery(ub))
 		goto out_unlock;
@@ -1984,25 +1941,22 @@ static int ublk_ctrl_start_recovery(struct io_uring_cmd *cmd)
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
-	ublk_put_device(ub);
 	return ret;
 }
 
-static int ublk_ctrl_end_recovery(struct io_uring_cmd *cmd)
+static int ublk_ctrl_end_recovery(struct ublk_device *ub,
+		struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	int ublksrv_pid = (int)header->data[0];
-	struct ublk_device *ub;
 	int ret = -EINVAL;
 
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return ret;
-
 	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
 	/* wait until new ubq_daemon sending all FETCH_REQ */
-	wait_for_completion_interruptible(&ub->completion);
+	if (wait_for_completion_interruptible(&ub->completion))
+		return -EINTR;
+
 	pr_devel("%s: All new ubq_daemons(nr: %d) are ready, dev id %d\n",
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
 
@@ -2026,7 +1980,6 @@ static int ublk_ctrl_end_recovery(struct io_uring_cmd *cmd)
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
-	ublk_put_device(ub);
 	return ret;
 }
 
@@ -2034,6 +1987,7 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublk_device *ub = NULL;
 	int ret = -EINVAL;
 
 	if (issue_flags & IO_URING_F_NONBLOCK)
@@ -2048,41 +2002,50 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	if (!capable(CAP_SYS_ADMIN))
 		goto out;
 
-	ret = -ENODEV;
+	if (cmd->cmd_op != UBLK_CMD_ADD_DEV) {
+		ret = -ENODEV;
+		ub = ublk_get_device_from_id(header->dev_id);
+		if (!ub)
+			goto out;
+	}
+
 	switch (cmd->cmd_op) {
 	case UBLK_CMD_START_DEV:
-		ret = ublk_ctrl_start_dev(cmd);
+		ret = ublk_ctrl_start_dev(ub, cmd);
 		break;
 	case UBLK_CMD_STOP_DEV:
-		ret = ublk_ctrl_stop_dev(cmd);
+		ret = ublk_ctrl_stop_dev(ub);
 		break;
 	case UBLK_CMD_GET_DEV_INFO:
-		ret = ublk_ctrl_get_dev_info(cmd);
+		ret = ublk_ctrl_get_dev_info(ub, cmd);
 		break;
 	case UBLK_CMD_ADD_DEV:
 		ret = ublk_ctrl_add_dev(cmd);
 		break;
 	case UBLK_CMD_DEL_DEV:
-		ret = ublk_ctrl_del_dev(header->dev_id);
+		ret = ublk_ctrl_del_dev(&ub);
 		break;
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
-		ret = ublk_ctrl_get_queue_affinity(cmd);
+		ret = ublk_ctrl_get_queue_affinity(ub, cmd);
 		break;
 	case UBLK_CMD_GET_PARAMS:
-		ret = ublk_ctrl_get_params(cmd);
+		ret = ublk_ctrl_get_params(ub, cmd);
 		break;
 	case UBLK_CMD_SET_PARAMS:
-		ret = ublk_ctrl_set_params(cmd);
+		ret = ublk_ctrl_set_params(ub, cmd);
 		break;
 	case UBLK_CMD_START_USER_RECOVERY:
-		ret = ublk_ctrl_start_recovery(cmd);
+		ret = ublk_ctrl_start_recovery(ub, cmd);
 		break;
 	case UBLK_CMD_END_USER_RECOVERY:
-		ret = ublk_ctrl_end_recovery(cmd);
+		ret = ublk_ctrl_end_recovery(ub, cmd);
 		break;
 	default:
+		ret = -ENOTSUPP;
 		break;
 	}
+	if (ub)
+		ublk_put_device(ub);
  out:
 	io_uring_cmd_done(cmd, ret, 0, issue_flags);
 	pr_devel("%s: cmd done ret %d cmd_op %x, dev id %d qid %d\n",
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 55f6ff1e05aa..44f71f2c8cfa 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -356,8 +356,13 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
-	size += recv_data(chip, &buf[TPM_HEADER_SIZE],
-			  expected - TPM_HEADER_SIZE);
+	rc = recv_data(chip, &buf[TPM_HEADER_SIZE],
+		       expected - TPM_HEADER_SIZE);
+	if (rc < 0) {
+		size = rc;
+		goto out;
+	}
+	size += rc;
 	if (size < expected) {
 		dev_err(&chip->dev, "Unable to read remainder of result\n");
 		size = -ETIME;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 818eb2503cdd..d51f90f55c05 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -451,20 +451,6 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 			 (u32) cpu->acpi_perf_data.states[i].control);
 	}
 
-	/*
-	 * The _PSS table doesn't contain whole turbo frequency range.
-	 * This just contains +1 MHZ above the max non turbo frequency,
-	 * with control value corresponding to max turbo ratio. But
-	 * when cpufreq set policy is called, it will call with this
-	 * max frequency, which will cause a reduced performance as
-	 * this driver uses real max turbo frequency as the max
-	 * frequency. So correct this frequency in _PSS table to
-	 * correct max turbo frequency based on the turbo state.
-	 * Also need to convert to MHz as _PSS freq is in MHz.
-	 */
-	if (!global.turbo_disabled)
-		cpu->acpi_perf_data.states[0].core_frequency =
-					policy->cpuinfo.max_freq / 1000;
 	cpu->valid_pss_table = true;
 	pr_debug("_PPC limits will be enforced\n");
 
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fb649683dd3a..07b184382707 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -154,9 +154,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	else
 		rc = cxl_decoder_autoremove(dev, cxld);
 	if (rc) {
-		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
-			cxld->hpa_range.start, cxld->hpa_range.end);
-		return 0;
+		dev_err(dev, "Failed to add decode range: %pr", res);
+		return rc;
 	}
 	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
 		dev_name(&cxld->dev),
diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
index 7002bca792ff..c625bb2b5d56 100644
--- a/drivers/dma-buf/dma-fence-unwrap.c
+++ b/drivers/dma-buf/dma-fence-unwrap.c
@@ -66,18 +66,36 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 {
 	struct dma_fence_array *result;
 	struct dma_fence *tmp, **array;
+	ktime_t timestamp;
 	unsigned int i;
 	size_t count;
 
 	count = 0;
+	timestamp = ns_to_ktime(0);
 	for (i = 0; i < num_fences; ++i) {
-		dma_fence_unwrap_for_each(tmp, &iter[i], fences[i])
-			if (!dma_fence_is_signaled(tmp))
+		dma_fence_unwrap_for_each(tmp, &iter[i], fences[i]) {
+			if (!dma_fence_is_signaled(tmp)) {
 				++count;
+			} else if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
+					    &tmp->flags)) {
+				if (ktime_after(tmp->timestamp, timestamp))
+					timestamp = tmp->timestamp;
+			} else {
+				/*
+				 * Use the current time if the fence is
+				 * currently signaling.
+				 */
+				timestamp = ktime_get();
+			}
+		}
 	}
 
+	/*
+	 * If we couldn't find a pending fence just return a private signaled
+	 * fence with the timestamp of the last signaled one.
+	 */
 	if (count == 0)
-		return dma_fence_get_stub();
+		return dma_fence_allocate_private_stub(timestamp);
 
 	array = kmalloc_array(count, sizeof(*array), GFP_KERNEL);
 	if (!array)
@@ -138,7 +156,7 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 	} while (tmp);
 
 	if (count == 0) {
-		tmp = dma_fence_get_stub();
+		tmp = dma_fence_allocate_private_stub(ktime_get());
 		goto return_tmp;
 	}
 
diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 0de0482cd36e..eef4786aaf86 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -150,16 +150,17 @@ EXPORT_SYMBOL(dma_fence_get_stub);
 
 /**
  * dma_fence_allocate_private_stub - return a private, signaled fence
+ * @timestamp: timestamp when the fence was signaled
  *
  * Return a newly allocated and signaled stub fence.
  */
-struct dma_fence *dma_fence_allocate_private_stub(void)
+struct dma_fence *dma_fence_allocate_private_stub(ktime_t timestamp)
 {
 	struct dma_fence *fence;
 
 	fence = kzalloc(sizeof(*fence), GFP_KERNEL);
 	if (fence == NULL)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	dma_fence_init(fence,
 		       &dma_fence_stub_ops,
@@ -169,7 +170,7 @@ struct dma_fence *dma_fence_allocate_private_stub(void)
 	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
 		&fence->flags);
 
-	dma_fence_signal(fence);
+	dma_fence_signal_timestamp(fence, timestamp);
 
 	return fence;
 }
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 91a4232ee58c..0ba9d04183a6 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -874,7 +874,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 
 	spin_lock_init(&mvpwm->lock);
 
-	return pwmchip_add(&mvpwm->chip);
+	return devm_pwmchip_add(dev, &mvpwm->chip);
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -1112,6 +1112,13 @@ static int mvebu_gpio_probe_syscon(struct platform_device *pdev,
 	return 0;
 }
 
+static void mvebu_gpio_remove_irq_domain(void *data)
+{
+	struct irq_domain *domain = data;
+
+	irq_domain_remove(domain);
+}
+
 static int mvebu_gpio_probe(struct platform_device *pdev)
 {
 	struct mvebu_gpio_chip *mvchip;
@@ -1243,17 +1250,21 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	if (!mvchip->domain) {
 		dev_err(&pdev->dev, "couldn't allocate irq domain %s (DT).\n",
 			mvchip->chip.label);
-		err = -ENODEV;
-		goto err_pwm;
+		return -ENODEV;
 	}
 
+	err = devm_add_action_or_reset(&pdev->dev, mvebu_gpio_remove_irq_domain,
+				       mvchip->domain);
+	if (err)
+		return err;
+
 	err = irq_alloc_domain_generic_chips(
 	    mvchip->domain, ngpios, 2, np->name, handle_level_irq,
 	    IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_LEVEL, 0, 0);
 	if (err) {
 		dev_err(&pdev->dev, "couldn't allocate irq chips %s (DT).\n",
 			mvchip->chip.label);
-		goto err_domain;
+		return err;
 	}
 
 	/*
@@ -1293,13 +1304,6 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-err_domain:
-	irq_domain_remove(mvchip->domain);
-err_pwm:
-	pwmchip_remove(&mvchip->mvpwm->chip);
-
-	return err;
 }
 
 static struct platform_driver mvebu_gpio_driver = {
diff --git a/drivers/gpio/gpio-tps68470.c b/drivers/gpio/gpio-tps68470.c
index aaddcabe9b35..532deaddfd4e 100644
--- a/drivers/gpio/gpio-tps68470.c
+++ b/drivers/gpio/gpio-tps68470.c
@@ -91,13 +91,13 @@ static int tps68470_gpio_output(struct gpio_chip *gc, unsigned int offset,
 	struct tps68470_gpio_data *tps68470_gpio = gpiochip_get_data(gc);
 	struct regmap *regmap = tps68470_gpio->tps68470_regmap;
 
+	/* Set the initial value */
+	tps68470_gpio_set(gc, offset, value);
+
 	/* rest are always outputs */
 	if (offset >= TPS68470_N_REGULAR_GPIO)
 		return 0;
 
-	/* Set the initial value */
-	tps68470_gpio_set(gc, offset, value);
-
 	return regmap_update_bits(regmap, TPS68470_GPIO_CTL_REG_A(offset),
 				 TPS68470_GPIO_MODE_MASK,
 				 TPS68470_GPIO_MODE_OUT_CMOS);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 39c5e14b0252..c0e782a95e72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1262,6 +1262,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
+bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 bool amdgpu_device_aspm_support_quirk(void);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ef0a94c70859..30c97ee37563 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1333,6 +1333,25 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	return true;
 }
 
+/*
+ * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
+ * speed switching. Until we have confirmation from Intel that a specific host
+ * supports it, it's safer that we keep it disabled for all.
+ *
+ * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
+ */
+bool amdgpu_device_pcie_dynamic_switching_supported(void)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		return false;
+#endif
+	return true;
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0af9fb4098e8..eecbd8eeb1f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -472,11 +472,11 @@ static int psp_sw_init(void *handle)
 	return 0;
 
 failed2:
-	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
-			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
-failed1:
 	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
 			      &psp->fence_buf_mc_addr, &psp->fence_buf);
+failed1:
+	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
+			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ce5df7927c21..9b2915764306 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4948,6 +4948,30 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	return 0;
 }
 
+static inline void fill_dc_dirty_rect(struct drm_plane *plane,
+				      struct rect *dirty_rect, int32_t x,
+				      int32_t y, int32_t width, int32_t height,
+				      int *i, bool ffu)
+{
+	WARN_ON(*i >= DC_MAX_DIRTY_RECTS);
+
+	dirty_rect->x = x;
+	dirty_rect->y = y;
+	dirty_rect->width = width;
+	dirty_rect->height = height;
+
+	if (ffu)
+		drm_dbg(plane->dev,
+			"[PLANE:%d] PSR FFU dirty rect size (%d, %d)\n",
+			plane->base.id, width, height);
+	else
+		drm_dbg(plane->dev,
+			"[PLANE:%d] PSR SU dirty rect at (%d, %d) size (%d, %d)",
+			plane->base.id, x, y, width, height);
+
+	(*i)++;
+}
+
 /**
  * fill_dc_dirty_rects() - Fill DC dirty regions for PSR selective updates
  *
@@ -4968,10 +4992,6 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
  * addition, certain use cases - such as cursor and multi-plane overlay (MPO) -
  * implicitly provide damage clips without any client support via the plane
  * bounds.
- *
- * Today, amdgpu_dm only supports the MPO and cursor usecase.
- *
- * TODO: Also enable for FB_DAMAGE_CLIPS
  */
 static void fill_dc_dirty_rects(struct drm_plane *plane,
 				struct drm_plane_state *old_plane_state,
@@ -4982,12 +5002,11 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
 	struct rect *dirty_rects = flip_addrs->dirty_rects;
 	uint32_t num_clips;
+	struct drm_mode_rect *clips;
 	bool bb_changed;
 	bool fb_changed;
 	u32 i = 0;
 
-	flip_addrs->dirty_rect_count = 0;
-
 	/*
 	 * Cursor plane has it's own dirty rect update interface. See
 	 * dcn10_dmub_update_cursor_data and dmub_cmd_update_cursor_info_data
@@ -4995,20 +5014,20 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	if (plane->type == DRM_PLANE_TYPE_CURSOR)
 		return;
 
-	/*
-	 * Today, we only consider MPO use-case for PSR SU. If MPO not
-	 * requested, and there is a plane update, do FFU.
-	 */
+	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
+	clips = drm_plane_get_damage_clips(new_plane_state);
+
 	if (!dm_crtc_state->mpo_requested) {
-		dirty_rects[0].x = 0;
-		dirty_rects[0].y = 0;
-		dirty_rects[0].width = dm_crtc_state->base.mode.crtc_hdisplay;
-		dirty_rects[0].height = dm_crtc_state->base.mode.crtc_vdisplay;
-		flip_addrs->dirty_rect_count = 1;
-		DRM_DEBUG_DRIVER("[PLANE:%d] PSR FFU dirty rect size (%d, %d)\n",
-				 new_plane_state->plane->base.id,
-				 dm_crtc_state->base.mode.crtc_hdisplay,
-				 dm_crtc_state->base.mode.crtc_vdisplay);
+		if (!num_clips || num_clips > DC_MAX_DIRTY_RECTS)
+			goto ffu;
+
+		for (; flip_addrs->dirty_rect_count < num_clips; clips++)
+			fill_dc_dirty_rect(new_plane_state->plane,
+					   &dirty_rects[flip_addrs->dirty_rect_count],
+					   clips->x1, clips->y1,
+					   clips->x2 - clips->x1, clips->y2 - clips->y1,
+					   &flip_addrs->dirty_rect_count,
+					   false);
 		return;
 	}
 
@@ -5019,7 +5038,6 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	 * If plane is moved or resized, also add old bounding box to dirty
 	 * rects.
 	 */
-	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
 	fb_changed = old_plane_state->fb->base.id !=
 		     new_plane_state->fb->base.id;
 	bb_changed = (old_plane_state->crtc_x != new_plane_state->crtc_x ||
@@ -5027,36 +5045,51 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 		      old_plane_state->crtc_w != new_plane_state->crtc_w ||
 		      old_plane_state->crtc_h != new_plane_state->crtc_h);
 
-	DRM_DEBUG_DRIVER("[PLANE:%d] PSR bb_changed:%d fb_changed:%d num_clips:%d\n",
-			 new_plane_state->plane->base.id,
-			 bb_changed, fb_changed, num_clips);
+	drm_dbg(plane->dev,
+		"[PLANE:%d] PSR bb_changed:%d fb_changed:%d num_clips:%d\n",
+		new_plane_state->plane->base.id,
+		bb_changed, fb_changed, num_clips);
 
-	if (num_clips || fb_changed || bb_changed) {
-		dirty_rects[i].x = new_plane_state->crtc_x;
-		dirty_rects[i].y = new_plane_state->crtc_y;
-		dirty_rects[i].width = new_plane_state->crtc_w;
-		dirty_rects[i].height = new_plane_state->crtc_h;
-		DRM_DEBUG_DRIVER("[PLANE:%d] PSR SU dirty rect at (%d, %d) size (%d, %d)\n",
-				 new_plane_state->plane->base.id,
-				 dirty_rects[i].x, dirty_rects[i].y,
-				 dirty_rects[i].width, dirty_rects[i].height);
-		i += 1;
-	}
+	if ((num_clips + (bb_changed ? 2 : 0)) > DC_MAX_DIRTY_RECTS)
+		goto ffu;
 
-	/* Add old plane bounding-box if plane is moved or resized */
 	if (bb_changed) {
-		dirty_rects[i].x = old_plane_state->crtc_x;
-		dirty_rects[i].y = old_plane_state->crtc_y;
-		dirty_rects[i].width = old_plane_state->crtc_w;
-		dirty_rects[i].height = old_plane_state->crtc_h;
-		DRM_DEBUG_DRIVER("[PLANE:%d] PSR SU dirty rect at (%d, %d) size (%d, %d)\n",
-				old_plane_state->plane->base.id,
-				dirty_rects[i].x, dirty_rects[i].y,
-				dirty_rects[i].width, dirty_rects[i].height);
-		i += 1;
+		fill_dc_dirty_rect(new_plane_state->plane, &dirty_rects[i],
+				   new_plane_state->crtc_x,
+				   new_plane_state->crtc_y,
+				   new_plane_state->crtc_w,
+				   new_plane_state->crtc_h, &i, false);
+
+		/* Add old plane bounding-box if plane is moved or resized */
+		fill_dc_dirty_rect(new_plane_state->plane, &dirty_rects[i],
+				   old_plane_state->crtc_x,
+				   old_plane_state->crtc_y,
+				   old_plane_state->crtc_w,
+				   old_plane_state->crtc_h, &i, false);
+	}
+
+	if (num_clips) {
+		for (; i < num_clips; clips++)
+			fill_dc_dirty_rect(new_plane_state->plane,
+					   &dirty_rects[i], clips->x1,
+					   clips->y1, clips->x2 - clips->x1,
+					   clips->y2 - clips->y1, &i, false);
+	} else if (fb_changed && !bb_changed) {
+		fill_dc_dirty_rect(new_plane_state->plane, &dirty_rects[i],
+				   new_plane_state->crtc_x,
+				   new_plane_state->crtc_y,
+				   new_plane_state->crtc_w,
+				   new_plane_state->crtc_h, &i, false);
 	}
 
 	flip_addrs->dirty_rect_count = i;
+	return;
+
+ffu:
+	fill_dc_dirty_rect(new_plane_state->plane, &dirty_rects[0], 0, 0,
+			   dm_crtc_state->base.mode.crtc_hdisplay,
+			   dm_crtc_state->base.mode.crtc_vdisplay,
+			   &flip_addrs->dirty_rect_count, true);
 }
 
 static void update_stream_scaling_settings(const struct drm_display_mode *mode,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 05708684c9f5..d07e1053b36b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -677,7 +677,7 @@ void dm_handle_mst_sideband_msg_ready_event(
 
 			if (retry == 3) {
 				DRM_ERROR("Failed to ack MST event.\n");
-				return;
+				break;
 			}
 
 			drm_dp_mst_hpd_irq_send_new_request(&aconnector->mst_mgr);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index e6854f7270a6..3c50b3ff7954 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1600,6 +1600,10 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
 						   supported_rotations);
 
+	if (dm->adev->ip_versions[DCE_HWIP][0] > IP_VERSION(3, 0, 1) &&
+	    plane->type != DRM_PLANE_TYPE_CURSOR)
+		drm_plane_enable_fb_damage_clips(plane);
+
 	drm_plane_helper_add(plane, &dm_plane_helper_funcs);
 
 #ifdef CONFIG_DRM_AMD_DC_HDR
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 872d06fe1436..3eb8794807d2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -24,6 +24,7 @@
  */
 
 #include "amdgpu_dm_psr.h"
+#include "dc_dmub_srv.h"
 #include "dc.h"
 #include "dm_helpers.h"
 #include "amdgpu_dm.h"
@@ -50,7 +51,7 @@ static bool link_supports_psrsu(struct dc_link *link)
 	    !link->dpcd_caps.psr_info.psr2_su_y_granularity_cap)
 		return false;
 
-	return true;
+	return dc_dmub_check_min_version(dc->ctx->dmub_srv->dmub);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 20a06c04e4a1..e43b4d7dc60e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -108,6 +108,11 @@ static int dcn314_get_active_display_cnt_wa(
 				stream->signal == SIGNAL_TYPE_DVI_SINGLE_LINK ||
 				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK)
 			tmds_present = true;
+
+		/* Checking stream / link detection ensuring that PHY is active*/
+		if (dc_is_dp_signal(stream->signal) && !stream->dpms_off)
+			display_count++;
+
 	}
 
 	for (i = 0; i < dc->link_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index cca014344416..8f9c60ed6f8b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -135,9 +135,7 @@ static const char DC_BUILD_ID[] = "production-build";
  * one or two (in the pipe-split case).
  */
 
-/*******************************************************************************
- * Private functions
- ******************************************************************************/
+/* Private functions */
 
 static inline void elevate_update_type(enum surface_update_type *original, enum surface_update_type new)
 {
@@ -384,16 +382,18 @@ static void dc_perf_trace_destroy(struct dc_perf_trace **perf_trace)
 }
 
 /**
- *  dc_stream_adjust_vmin_vmax:
+ *  dc_stream_adjust_vmin_vmax - look up pipe context & update parts of DRR
+ *  @dc:     dc reference
+ *  @stream: Initial dc stream state
+ *  @adjust: Updated parameters for vertical_total_min and vertical_total_max
  *
  *  Looks up the pipe context of dc_stream_state and updates the
  *  vertical_total_min and vertical_total_max of the DRR, Dynamic Refresh
  *  Rate, which is a power-saving feature that targets reducing panel
  *  refresh rate while the screen is static
  *
- *  @dc:     dc reference
- *  @stream: Initial dc stream state
- *  @adjust: Updated parameters for vertical_total_min and vertical_total_max
+ *  Return: %true if the pipe context is found and adjusted;
+ *          %false if the pipe context is not found.
  */
 bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 		struct dc_stream_state *stream,
@@ -429,18 +429,17 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 }
 
 /**
- *****************************************************************************
- *  Function: dc_stream_get_last_vrr_vtotal
+ * dc_stream_get_last_used_drr_vtotal - Looks up the pipe context of
+ * dc_stream_state and gets the last VTOTAL used by DRR (Dynamic Refresh Rate)
  *
- *  @brief
- *     Looks up the pipe context of dc_stream_state and gets the
- *     last VTOTAL used by DRR (Dynamic Refresh Rate)
+ * @dc: [in] dc reference
+ * @stream: [in] Initial dc stream state
+ * @refresh_rate: [in] new refresh_rate
  *
- *  @param [in] dc: dc reference
- *  @param [in] stream: Initial dc stream state
- *  @param [in] adjust: Updated parameters for vertical_total_min and
- *  vertical_total_max
- *****************************************************************************
+ * Return: %true if the pipe context is found and there is an associated
+ *         timing_generator for the DC;
+ *         %false if the pipe context is not found or there is no
+ *         timing_generator for the DC.
  */
 bool dc_stream_get_last_used_drr_vtotal(struct dc *dc,
 		struct dc_stream_state *stream,
@@ -587,7 +586,10 @@ bool dc_stream_stop_dmcu_crc_win_update(struct dc *dc, struct dc_stream_state *s
  *              once.
  *
  * By default, only CRC0 is configured, and the entire frame is used to
- * calculate the crc.
+ * calculate the CRC.
+ *
+ * Return: %false if the stream is not found or CRC capture is not supported;
+ *         %true if the stream has been configured.
  */
 bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
 			     struct crc_params *crc_window, bool enable, bool continuous)
@@ -656,7 +658,7 @@ bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
  * dc_stream_configure_crc needs to be called beforehand to enable CRCs.
  *
  * Return:
- * false if stream is not found, or if CRCs are not enabled.
+ * %false if stream is not found, or if CRCs are not enabled.
  */
 bool dc_stream_get_crc(struct dc *dc, struct dc_stream_state *stream,
 		       uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb)
@@ -1236,9 +1238,7 @@ static void wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
 	PERF_TRACE();
 }
 
-/*******************************************************************************
- * Public functions
- ******************************************************************************/
+/* Public functions */
 
 struct dc *dc_create(const struct dc_init_data *init_params)
 {
@@ -1505,17 +1505,19 @@ static void program_timing_sync(
 	}
 }
 
-static bool context_changed(
-		struct dc *dc,
-		struct dc_state *context)
+static bool streams_changed(struct dc *dc,
+			    struct dc_stream_state *streams[],
+			    uint8_t stream_count)
 {
 	uint8_t i;
 
-	if (context->stream_count != dc->current_state->stream_count)
+	if (stream_count != dc->current_state->stream_count)
 		return true;
 
 	for (i = 0; i < dc->current_state->stream_count; i++) {
-		if (dc->current_state->streams[i] != context->streams[i])
+		if (dc->current_state->streams[i] != streams[i])
+			return true;
+		if (!streams[i]->link->link_state_valid)
 			return true;
 	}
 
@@ -1745,6 +1747,8 @@ void dc_z10_save_init(struct dc *dc)
 /*
  * Applies given context to HW and copy it into current context.
  * It's up to the user to release the src context afterwards.
+ *
+ * Return: an enum dc_status result code for the operation
  */
 static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *context)
 {
@@ -1911,12 +1915,114 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	return result;
 }
 
+static bool commit_minimal_transition_state(struct dc *dc,
+		struct dc_state *transition_base_context);
+
+/**
+ * dc_commit_streams - Commit current stream state
+ *
+ * @dc: DC object with the commit state to be configured in the hardware
+ * @streams: Array with a list of stream state
+ * @stream_count: Total of streams
+ *
+ * Function responsible for commit streams change to the hardware.
+ *
+ * Return:
+ * Return DC_OK if everything work as expected, otherwise, return a dc_status
+ * code.
+ */
+enum dc_status dc_commit_streams(struct dc *dc,
+				 struct dc_stream_state *streams[],
+				 uint8_t stream_count)
+{
+	int i, j;
+	struct dc_state *context;
+	enum dc_status res = DC_OK;
+	struct dc_validation_set set[MAX_STREAMS] = {0};
+	struct pipe_ctx *pipe;
+	bool handle_exit_odm2to1 = false;
+
+	if (!streams_changed(dc, streams, stream_count))
+		return res;
+
+	DC_LOG_DC("%s: %d streams\n", __func__, stream_count);
+
+	for (i = 0; i < stream_count; i++) {
+		struct dc_stream_state *stream = streams[i];
+		struct dc_stream_status *status = dc_stream_get_status(stream);
+
+		dc_stream_log(dc, stream);
+
+		set[i].stream = stream;
+
+		if (status) {
+			set[i].plane_count = status->plane_count;
+			for (j = 0; j < status->plane_count; j++)
+				set[i].plane_states[j] = status->plane_states[j];
+		}
+	}
+
+	/* Check for case where we are going from odm 2:1 to max
+	 *  pipe scenario.  For these cases, we will call
+	 *  commit_minimal_transition_state() to exit out of odm 2:1
+	 *  first before processing new streams
+	 */
+	if (stream_count == dc->res_pool->pipe_count) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe->next_odm_pipe)
+				handle_exit_odm2to1 = true;
+		}
+	}
+
+	if (handle_exit_odm2to1)
+		res = commit_minimal_transition_state(dc, dc->current_state);
+
+	context = dc_create_state(dc);
+	if (!context)
+		goto context_alloc_fail;
+
+	dc_resource_state_copy_construct_current(dc, context);
+
+	/*
+	 * Previous validation was perfomred with fast_validation = true and
+	 * the full DML state required for hardware programming was skipped.
+	 *
+	 * Re-validate here to calculate these parameters / watermarks.
+	 */
+	res = dc_validate_global_state(dc, context, false);
+	if (res != DC_OK) {
+		DC_LOG_ERROR("DC commit global validation failure: %s (%d)",
+			     dc_status_to_str(res), res);
+		return res;
+	}
+
+	res = dc_commit_state_no_check(dc, context);
+
+context_alloc_fail:
+
+	DC_LOG_DC("%s Finished.\n", __func__);
+
+	return (res == DC_OK);
+}
+
+/* TODO: When the transition to the new commit sequence is done, remove this
+ * function in favor of dc_commit_streams. */
 bool dc_commit_state(struct dc *dc, struct dc_state *context)
 {
 	enum dc_status result = DC_ERROR_UNEXPECTED;
 	int i;
 
-	if (!context_changed(dc, context))
+	/* TODO: Since change commit sequence can have a huge impact,
+	 * we decided to only enable it for DCN3x. However, as soon as
+	 * we get more confident about this change we'll need to enable
+	 * the new sequence for all ASICs. */
+	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
+		result = dc_commit_streams(dc, context->streams, context->stream_count);
+		return result == DC_OK;
+	}
+
+	if (!streams_changed(dc, context->streams, context->stream_count))
 		return DC_OK;
 
 	DC_LOG_DC("%s: %d streams\n",
@@ -2482,8 +2588,11 @@ static enum surface_update_type check_update_surfaces_for_stream(
 
 		if (stream_update->mst_bw_update)
 			su_flags->bits.mst_bw = 1;
-		if (stream_update->crtc_timing_adjust && dc_extended_blank_supported(dc))
-			su_flags->bits.crtc_timing_adjust = 1;
+
+		if (stream_update->stream && stream_update->stream->freesync_on_desktop &&
+			(stream_update->vrr_infopacket || stream_update->allow_freesync ||
+				stream_update->vrr_active_variable))
+			su_flags->bits.fams_changed = 1;
 
 		if (su_flags->raw != 0)
 			overall_type = UPDATE_TYPE_FULL;
@@ -3648,17 +3757,17 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 		}
 	}
 
-	/* For SubVP when adding MPO video we need to add a minimal transition.
+	/* For SubVP when adding or removing planes we need to add a minimal transition
+	 * (even when disabling all planes). Whenever disabling a phantom pipe, we
+	 * must use the minimal transition path to disable the pipe correctly.
 	 */
 	if (cur_stream_status && stream->mall_stream_config.type == SUBVP_MAIN) {
 		/* determine if minimal transition is required due to SubVP*/
-		if (surface_count > 0) {
-			if (cur_stream_status->plane_count > surface_count) {
-				force_minimal_pipe_splitting = true;
-			} else if (cur_stream_status->plane_count < surface_count) {
-				force_minimal_pipe_splitting = true;
-				*is_plane_addition = true;
-			}
+		if (cur_stream_status->plane_count > surface_count) {
+			force_minimal_pipe_splitting = true;
+		} else if (cur_stream_status->plane_count < surface_count) {
+			force_minimal_pipe_splitting = true;
+			*is_plane_addition = true;
 		}
 	}
 
@@ -3675,6 +3784,8 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	enum dc_status ret = DC_ERROR_UNEXPECTED;
 	unsigned int i, j;
 	unsigned int pipe_in_use = 0;
+	bool subvp_in_use = false;
+	bool odm_in_use = false;
 
 	if (!transition_context)
 		return false;
@@ -3687,6 +3798,30 @@ static bool commit_minimal_transition_state(struct dc *dc,
 			pipe_in_use++;
 	}
 
+	/* If SubVP is enabled and we are adding or removing planes from any main subvp
+	 * pipe, we must use the minimal transition.
+	 */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+			subvp_in_use = true;
+			break;
+		}
+	}
+
+	/* If ODM is enabled and we are adding or removing planes from any ODM
+	 * pipe, we must use the minimal transition.
+	 */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream && pipe->next_odm_pipe) {
+			odm_in_use = true;
+			break;
+		}
+	}
+
 	/* When the OS add a new surface if we have been used all of pipes with odm combine
 	 * and mpc split feature, it need use commit_minimal_transition_state to transition safely.
 	 * After OS exit MPO, it will back to use odm and mpc split with all of pipes, we need
@@ -3695,7 +3830,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	 * Reduce the scenarios to use dc_commit_state_no_check in the stage of flip. Especially
 	 * enter/exit MPO when DCN still have enough resources.
 	 */
-	if (pipe_in_use != dc->res_pool->pipe_count) {
+	if (pipe_in_use != dc->res_pool->pipe_count && !subvp_in_use && !odm_in_use) {
 		dc_release_state(transition_context);
 		return true;
 	}
@@ -4430,21 +4565,17 @@ void dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(struct dc *dc)
 		dc->current_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching_shut_down = true;
 }
 
-/*
- *****************************************************************************
- * Function: dc_is_dmub_outbox_supported -
+/**
+ * dc_is_dmub_outbox_supported - Check if DMUB firmware support outbox notification
  *
- * @brief
- *      Checks whether DMUB FW supports outbox notifications, if supported
- *		DM should register outbox interrupt prior to actually enabling interrupts
- *		via dc_enable_dmub_outbox
+ * @dc: [in] dc structure
  *
- *  @param
- *		[in] dc: dc structure
+ * Checks whether DMUB FW supports outbox notifications, if supported DM
+ * should register outbox interrupt prior to actually enabling interrupts
+ * via dc_enable_dmub_outbox
  *
- *  @return
- *		True if DMUB FW supports outbox notifications, False otherwise
- *****************************************************************************
+ * Return:
+ * True if DMUB FW supports outbox notifications, False otherwise
  */
 bool dc_is_dmub_outbox_supported(struct dc *dc)
 {
@@ -4462,21 +4593,17 @@ bool dc_is_dmub_outbox_supported(struct dc *dc)
 	return dc->debug.enable_dmub_aux_for_legacy_ddc;
 }
 
-/*
- *****************************************************************************
- *  Function: dc_enable_dmub_notifications
+/**
+ * dc_enable_dmub_notifications - Check if dmub fw supports outbox
  *
- *  @brief
- *		Calls dc_is_dmub_outbox_supported to check if dmub fw supports outbox
- *		notifications. All DMs shall switch to dc_is_dmub_outbox_supported.
- *		This API shall be removed after switching.
+ * @dc: [in] dc structure
  *
- *  @param
- *		[in] dc: dc structure
+ * Calls dc_is_dmub_outbox_supported to check if dmub fw supports outbox
+ * notifications. All DMs shall switch to dc_is_dmub_outbox_supported.  This
+ * API shall be removed after switching.
  *
- *  @return
- *		True if DMUB FW supports outbox notifications, False otherwise
- *****************************************************************************
+ * Return:
+ * True if DMUB FW supports outbox notifications, False otherwise
  */
 bool dc_enable_dmub_notifications(struct dc *dc)
 {
@@ -4484,18 +4611,11 @@ bool dc_enable_dmub_notifications(struct dc *dc)
 }
 
 /**
- *****************************************************************************
- *  Function: dc_enable_dmub_outbox
- *
- *  @brief
- *		Enables DMUB unsolicited notifications to x86 via outbox
+ * dc_enable_dmub_outbox - Enables DMUB unsolicited notification
  *
- *  @param
- *		[in] dc: dc structure
+ * @dc: [in] dc structure
  *
- *  @return
- *		None
- *****************************************************************************
+ * Enables DMUB unsolicited notifications to x86 via outbox.
  */
 void dc_enable_dmub_outbox(struct dc *dc)
 {
@@ -4596,21 +4716,17 @@ uint8_t get_link_index_from_dpia_port_index(const struct dc *dc,
 }
 
 /**
- *****************************************************************************
- *  Function: dc_process_dmub_set_config_async
+ * dc_process_dmub_set_config_async - Submits set_config command
  *
- *  @brief
- *		Submits set_config command to dmub via inbox message
+ * @dc: [in] dc structure
+ * @link_index: [in] link_index: link index
+ * @payload: [in] aux payload
+ * @notify: [out] set_config immediate reply
  *
- *  @param
- *		[in] dc: dc structure
- *		[in] link_index: link index
- *		[in] payload: aux payload
- *		[out] notify: set_config immediate reply
+ * Submits set_config command to dmub via inbox message.
  *
- *  @return
- *		True if successful, False if failure
- *****************************************************************************
+ * Return:
+ * True if successful, False if failure
  */
 bool dc_process_dmub_set_config_async(struct dc *dc,
 				uint32_t link_index,
@@ -4646,21 +4762,17 @@ bool dc_process_dmub_set_config_async(struct dc *dc,
 }
 
 /**
- *****************************************************************************
- *  Function: dc_process_dmub_set_mst_slots
+ * dc_process_dmub_set_mst_slots - Submits MST solt allocation
  *
- *  @brief
- *		Submits mst slot allocation command to dmub via inbox message
+ * @dc: [in] dc structure
+ * @link_index: [in] link index
+ * @mst_alloc_slots: [in] mst slots to be allotted
+ * @mst_slots_in_use: [out] mst slots in use returned in failure case
  *
- *  @param
- *		[in] dc: dc structure
- *		[in] link_index: link index
- *		[in] mst_alloc_slots: mst slots to be allotted
- *		[out] mst_slots_in_use: mst slots in use returned in failure case
+ * Submits mst slot allocation command to dmub via inbox message
  *
- *	@return
- *		DC_OK if successful, DC_ERROR if failure
- *****************************************************************************
+ * Return:
+ * DC_OK if successful, DC_ERROR if failure
  */
 enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
 				uint32_t link_index,
@@ -4700,19 +4812,12 @@ enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
 }
 
 /**
- *****************************************************************************
- *  Function: dc_process_dmub_dpia_hpd_int_enable
- *
- *  @brief
- *		Submits dpia hpd int enable command to dmub via inbox message
+ * dc_process_dmub_dpia_hpd_int_enable - Submits DPIA DPD interruption
  *
- *  @param
- *		[in] dc: dc structure
- *		[in] hpd_int_enable: 1 for hpd int enable, 0 to disable
+ * @dc: [in] dc structure
+ * @hpd_int_enable: [in] 1 for hpd int enable, 0 to disable
  *
- *	@return
- *		None
- *****************************************************************************
+ * Submits dpia hpd int enable command to dmub via inbox message
  */
 void dc_process_dmub_dpia_hpd_int_enable(const struct dc *dc,
 				uint32_t hpd_int_enable)
@@ -4741,16 +4846,13 @@ void dc_disable_accelerated_mode(struct dc *dc)
 
 
 /**
- *****************************************************************************
- *  dc_notify_vsync_int_state() - notifies vsync enable/disable state
+ *  dc_notify_vsync_int_state - notifies vsync enable/disable state
  *  @dc: dc structure
- *	@stream: stream where vsync int state changed
- *	@enable: whether vsync is enabled or disabled
- *
- *  Called when vsync is enabled/disabled
- *	Will notify DMUB to start/stop ABM interrupts after steady state is reached
+ *  @stream: stream where vsync int state changed
+ *  @enable: whether vsync is enabled or disabled
  *
- *****************************************************************************
+ *  Called when vsync is enabled/disabled Will notify DMUB to start/stop ABM
+ *  interrupts after steady state is reached.
  */
 void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bool enable)
 {
@@ -4792,17 +4894,3 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
 	if (pipe->stream_res.abm && pipe->stream_res.abm->funcs->set_abm_pause)
 		pipe->stream_res.abm->funcs->set_abm_pause(pipe->stream_res.abm, !enable, i, pipe->stream_res.tg->inst);
 }
-/*
- * dc_extended_blank_supported: Decide whether extended blank is supported
- *
- * Extended blank is a freesync optimization feature to be enabled in the future.
- * During the extra vblank period gained from freesync, we have the ability to enter z9/z10.
- *
- * @param [in] dc: Current DC state
- * @return: Indicate whether extended blank is supported (true or false)
- */
-bool dc_extended_blank_supported(struct dc *dc)
-{
-	return dc->debug.extended_blank_optimization && !dc->debug.disable_z10
-		&& dc->caps.zstate_support && dc->caps.is_apu;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f0d05829288b..a26e52abc989 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1444,6 +1444,26 @@ static int acquire_first_split_pipe(
 			split_pipe->plane_res.mpcc_inst = pool->dpps[i]->inst;
 			split_pipe->pipe_idx = i;
 
+			split_pipe->stream = stream;
+			return i;
+		} else if (split_pipe->prev_odm_pipe &&
+				split_pipe->prev_odm_pipe->plane_state == split_pipe->plane_state) {
+			split_pipe->prev_odm_pipe->next_odm_pipe = split_pipe->next_odm_pipe;
+			if (split_pipe->next_odm_pipe)
+				split_pipe->next_odm_pipe->prev_odm_pipe = split_pipe->prev_odm_pipe;
+
+			if (split_pipe->prev_odm_pipe->plane_state)
+				resource_build_scaling_params(split_pipe->prev_odm_pipe);
+
+			memset(split_pipe, 0, sizeof(*split_pipe));
+			split_pipe->stream_res.tg = pool->timing_generators[i];
+			split_pipe->plane_res.hubp = pool->hubps[i];
+			split_pipe->plane_res.ipp = pool->ipps[i];
+			split_pipe->plane_res.dpp = pool->dpps[i];
+			split_pipe->stream_res.opp = pool->opps[i];
+			split_pipe->plane_res.mpcc_inst = pool->dpps[i]->inst;
+			split_pipe->pipe_idx = i;
+
 			split_pipe->stream = stream;
 			return i;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3f277009075f..6409b8d8ff71 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -56,9 +56,7 @@ struct dmub_notification;
 #define MIN_VIEWPORT_SIZE 12
 #define MAX_NUM_EDP 2
 
-/*******************************************************************************
- * Display Core Interfaces
- ******************************************************************************/
+/* Display Core Interfaces */
 struct dc_versions {
 	const char *dc_ver;
 	struct dmcu_version dmcu_version;
@@ -993,9 +991,7 @@ void dc_init_callbacks(struct dc *dc,
 void dc_deinit_callbacks(struct dc *dc);
 void dc_destroy(struct dc **dc);
 
-/*******************************************************************************
- * Surface Interfaces
- ******************************************************************************/
+/* Surface Interfaces */
 
 enum {
 	TRANSFER_FUNC_POINTS = 1025
@@ -1274,12 +1270,23 @@ void dc_post_update_surfaces_to_stream(
 
 #include "dc_stream.h"
 
-/*
- * Structure to store surface/stream associations for validation
+/**
+ * struct dc_validation_set - Struct to store surface/stream associations for validation
  */
 struct dc_validation_set {
+	/**
+	 * @stream: Stream state properties
+	 */
 	struct dc_stream_state *stream;
+
+	/**
+	 * @plane_state: Surface state
+	 */
 	struct dc_plane_state *plane_states[MAX_SURFACES];
+
+	/**
+	 * @plane_count: Total of active planes
+	 */
 	uint8_t plane_count;
 };
 
@@ -1326,15 +1333,12 @@ void dc_resource_state_destruct(struct dc_state *context);
 
 bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
 
-/*
- * TODO update to make it about validation sets
- * Set up streams and links associated to drive sinks
- * The streams parameter is an absolute set of all active streams.
- *
- * After this call:
- *   Phy, Encoder, Timing Generator are programmed and enabled.
- *   New streams are enabled with blank stream; no memory read.
- */
+enum dc_status dc_commit_streams(struct dc *dc,
+				 struct dc_stream_state *streams[],
+				 uint8_t stream_count);
+
+/* TODO: When the transition to the new commit sequence is done, remove this
+ * function in favor of dc_commit_streams. */
 bool dc_commit_state(struct dc *dc, struct dc_state *context);
 
 struct dc_state *dc_create_state(struct dc *dc);
@@ -1342,9 +1346,7 @@ struct dc_state *dc_copy_state(struct dc_state *src_ctx);
 void dc_retain_state(struct dc_state *context);
 void dc_release_state(struct dc_state *context);
 
-/*******************************************************************************
- * Link Interfaces
- ******************************************************************************/
+/* Link Interfaces */
 
 struct dpcd_caps {
 	union dpcd_rev dpcd_rev;
@@ -1446,9 +1448,7 @@ struct hdcp_caps {
 
 uint32_t dc_get_opp_for_plane(struct dc *dc, struct dc_plane_state *plane);
 
-/*******************************************************************************
- * Sink Interfaces - A sink corresponds to a display output device
- ******************************************************************************/
+/* Sink Interfaces - A sink corresponds to a display output device */
 
 struct dc_container_id {
 	// 128bit GUID in binary form
@@ -1520,8 +1520,6 @@ struct dc_sink_init_data {
 	bool converter_disable_audio;
 };
 
-bool dc_extended_blank_supported(struct dc *dc);
-
 struct dc_sink *dc_sink_create(const struct dc_sink_init_data *init_params);
 
 /* Newer interfaces  */
@@ -1531,9 +1529,7 @@ struct dc_cursor {
 };
 
 
-/*******************************************************************************
- * Interrupt interfaces
- ******************************************************************************/
+/* Interrupt interfaces */
 enum dc_irq_source dc_interrupt_to_irq_source(
 		struct dc *dc,
 		uint32_t src_id,
@@ -1545,9 +1541,7 @@ enum dc_irq_source dc_get_hpd_irq_source_at_index(
 
 void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bool enable);
 
-/*******************************************************************************
- * Power Interfaces
- ******************************************************************************/
+/* Power Interfaces */
 
 void dc_set_power_state(
 		struct dc *dc,
@@ -1620,14 +1614,10 @@ enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
 void dc_process_dmub_dpia_hpd_int_enable(const struct dc *dc,
 				uint32_t hpd_int_enable);
 
-/*******************************************************************************
- * DSC Interfaces
- ******************************************************************************/
+/* DSC Interfaces */
 #include "dc_dsc.h"
 
-/*******************************************************************************
- * Disable acc mode Interfaces
- ******************************************************************************/
+/* Disable acc mode Interfaces */
 void dc_disable_accelerated_mode(struct dc *dc);
 
 #endif /* DC_INTERFACE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index a461e9463534..31bb7e782c6b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1026,3 +1026,10 @@ void dc_send_update_cursor_info_to_dmu(
 		dc_send_cmd_to_dmu(pCtx->stream->ctx->dmub_srv, &cmd);
 	}
 }
+
+bool dc_dmub_check_min_version(struct dmub_srv *srv)
+{
+	if (!srv->hw_funcs.is_psrsu_supported)
+		return true;
+	return srv->hw_funcs.is_psrsu_supported(srv);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index d34f5563df2e..9a248ced03b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -89,4 +89,5 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc, struct dc_state *context, b
 void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
 
 void dc_send_update_cursor_info_to_dmu(struct pipe_ctx *pCtx, uint8_t pipe_idx);
+bool dc_dmub_check_min_version(struct dmub_srv *srv);
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 9e6025c98db9..364ff913527d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -41,6 +41,10 @@ struct timing_sync_info {
 struct dc_stream_status {
 	int primary_otg_inst;
 	int stream_enc_inst;
+
+	/**
+	 * @plane_count: Total of planes attached to a single stream
+	 */
 	int plane_count;
 	int audio_inst;
 	struct timing_sync_info timing_sync_info;
@@ -127,6 +131,7 @@ union stream_update_flags {
 		uint32_t dsc_changed : 1;
 		uint32_t mst_bw : 1;
 		uint32_t crtc_timing_adjust : 1;
+		uint32_t fams_changed : 1;
 	} bits;
 
 	uint32_t raw;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 622efa556e7a..4ef632864948 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2036,7 +2036,7 @@ void dcn20_optimize_bandwidth(
 			dc->clk_mgr,
 			context,
 			true);
-	if (dc_extended_blank_supported(dc) && context->bw_ctx.bw.dcn.clk.zstate_support == DCN_ZSTATE_SUPPORT_ALLOW) {
+	if (context->bw_ctx.bw.dcn.clk.zstate_support == DCN_ZSTATE_SUPPORT_ALLOW) {
 		for (i = 0; i < dc->res_pool->pipe_count; ++i) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
@@ -2044,7 +2044,7 @@ void dcn20_optimize_bandwidth(
 				&& pipe_ctx->stream->adjust.v_total_min == pipe_ctx->stream->adjust.v_total_max
 				&& pipe_ctx->stream->adjust.v_total_max > pipe_ctx->stream->timing.v_total)
 					pipe_ctx->plane_res.hubp->funcs->program_extended_blank(pipe_ctx->plane_res.hubp,
-						pipe_ctx->dlg_regs.optimized_min_dst_y_next_start);
+						pipe_ctx->dlg_regs.min_dst_y_next_start);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 25749f7d8836..94894fd6c906 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -292,7 +292,12 @@ void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc)
 
 void optc3_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
 {
-	optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);
+	struct dc *dc = optc->ctx->dc;
+
+	if (dc->caps.dmub_caps.mclk_sw && !dc->debug.disable_fams)
+		dc_dmub_srv_drr_update_cmd(dc, optc->inst, vtotal_min, vtotal_max);
+	else
+		optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);
 }
 
 void optc3_tg_init(struct timing_generator *optc)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index 6360dc9502e7..0f231e42e420 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -103,6 +103,7 @@ static void dcn31_program_det_size(struct hubbub *hubbub, int hubp_inst, unsigne
 	default:
 		break;
 	}
+	DC_LOG_DEBUG("Set DET%d to %d segments\n", hubp_inst, det_size_segments);
 	/* Should never be hit, if it is we have an erroneous hw config*/
 	ASSERT(hubbub2->det0_size + hubbub2->det1_size + hubbub2->det2_size
 			+ hubbub2->det3_size + hubbub2->compbuf_size_segments <= hubbub2->crb_size_segs);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 31cbc5762eab..b9b1e5ac4f53 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -136,6 +136,9 @@
 
 #define DCN3_15_MAX_DET_SIZE 384
 #define DCN3_15_CRB_SEGMENT_SIZE_KB 64
+#define DCN3_15_MAX_DET_SEGS (DCN3_15_MAX_DET_SIZE / DCN3_15_CRB_SEGMENT_SIZE_KB)
+/* Minimum 2 extra segments need to be in compbuf and claimable to guarantee seamless mpo transitions */
+#define MIN_RESERVED_DET_SEGS 2
 
 enum dcn31_clk_src_array_id {
 	DCN31_CLK_SRC_PLL0,
@@ -1636,21 +1639,61 @@ static bool is_dual_plane(enum surface_pixel_format format)
 	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN || format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
 }
 
+static int source_format_to_bpp (enum source_format_class SourcePixelFormat)
+{
+	if (SourcePixelFormat == dm_444_64)
+		return 8;
+	else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16)
+		return 2;
+	else if (SourcePixelFormat == dm_444_8)
+		return 1;
+	else if (SourcePixelFormat == dm_rgbe_alpha)
+		return 5;
+	else if (SourcePixelFormat == dm_420_8)
+		return 3;
+	else if (SourcePixelFormat == dm_420_12)
+		return 6;
+	else
+		return 4;
+}
+
+static bool allow_pixel_rate_crb(struct dc *dc, struct dc_state *context)
+{
+	int i;
+	struct resource_context *res_ctx = &context->res_ctx;
+
+	/*Don't apply for single stream*/
+	if (context->stream_count < 2)
+		return false;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!res_ctx->pipe_ctx[i].stream)
+			continue;
+
+		/*Don't apply if MPO to avoid transition issues*/
+		if (res_ctx->pipe_ctx[i].top_pipe && res_ctx->pipe_ctx[i].top_pipe->plane_state != res_ctx->pipe_ctx[i].plane_state)
+			return false;
+	}
+	return true;
+}
+
 static int dcn315_populate_dml_pipes_from_context(
 	struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes,
 	bool fast_validate)
 {
-	int i, pipe_cnt;
+	int i, pipe_cnt, crb_idx, crb_pipes;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	const int max_usable_det = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - DCN3_15_MIN_COMPBUF_SIZE_KB;
+	int remaining_det_segs = max_usable_det / DCN3_15_CRB_SEGMENT_SIZE_KB;
+	bool pixel_rate_crb = allow_pixel_rate_crb(dc, context);
 
 	DC_FP_START();
 	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 	DC_FP_END();
 
-	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
+	for (i = 0, pipe_cnt = 0, crb_pipes = 0; i < dc->res_pool->pipe_count; i++) {
 		struct dc_crtc_timing *timing;
 
 		if (!res_ctx->pipe_ctx[i].stream)
@@ -1672,6 +1715,23 @@ static int dcn315_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
 		DC_FP_START();
 		dcn31_zero_pipe_dcc_fraction(pipes, pipe_cnt);
+		if (pixel_rate_crb && !pipe->top_pipe && !pipe->prev_odm_pipe) {
+			int bpp = source_format_to_bpp(pipes[pipe_cnt].pipe.src.source_format);
+			/* Ceil to crb segment size */
+			int approx_det_segs_required_for_pstate = dcn_get_approx_det_segs_required_for_pstate(
+					&context->bw_ctx.dml.soc, timing->pix_clk_100hz, bpp, DCN3_15_CRB_SEGMENT_SIZE_KB);
+			if (approx_det_segs_required_for_pstate <= 2 * DCN3_15_MAX_DET_SEGS) {
+				bool split_required = approx_det_segs_required_for_pstate > DCN3_15_MAX_DET_SEGS;
+				split_required = split_required || timing->pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc);
+				split_required = split_required || (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
+				if (split_required)
+					approx_det_segs_required_for_pstate += approx_det_segs_required_for_pstate % 2;
+				pipes[pipe_cnt].pipe.src.det_size_override = approx_det_segs_required_for_pstate;
+				remaining_det_segs -= approx_det_segs_required_for_pstate;
+			} else
+				remaining_det_segs = -1;
+			crb_pipes++;
+		}
 		DC_FP_END();
 
 		if (pipes[pipe_cnt].dout.dsc_enable) {
@@ -1690,16 +1750,54 @@ static int dcn315_populate_dml_pipes_from_context(
 				break;
 			}
 		}
-
 		pipe_cnt++;
 	}
 
+	/* Spread remaining unreserved crb evenly among all pipes*/
+	if (pixel_rate_crb) {
+		for (i = 0, pipe_cnt = 0, crb_idx = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe = &res_ctx->pipe_ctx[i];
+			if (!pipe->stream)
+				continue;
+
+			/* Do not use asymetric crb if not enough for pstate support */
+			if (remaining_det_segs < 0) {
+				pipes[pipe_cnt].pipe.src.det_size_override = 0;
+				continue;
+			}
+
+			if (!pipe->top_pipe && !pipe->prev_odm_pipe) {
+				bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
+						|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
+
+				if (remaining_det_segs > MIN_RESERVED_DET_SEGS)
+					pipes[pipe_cnt].pipe.src.det_size_override += (remaining_det_segs - MIN_RESERVED_DET_SEGS) / crb_pipes +
+							(crb_idx < (remaining_det_segs - MIN_RESERVED_DET_SEGS) % crb_pipes ? 1 : 0);
+				if (pipes[pipe_cnt].pipe.src.det_size_override > 2 * DCN3_15_MAX_DET_SEGS) {
+					/* Clamp to 2 pipe split max det segments */
+					remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override - 2 * (DCN3_15_MAX_DET_SEGS);
+					pipes[pipe_cnt].pipe.src.det_size_override = 2 * DCN3_15_MAX_DET_SEGS;
+				}
+				if (pipes[pipe_cnt].pipe.src.det_size_override > DCN3_15_MAX_DET_SEGS || split_required) {
+					/* If we are splitting we must have an even number of segments */
+					remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override % 2;
+					pipes[pipe_cnt].pipe.src.det_size_override -= pipes[pipe_cnt].pipe.src.det_size_override % 2;
+				}
+				/* Convert segments into size for DML use */
+				pipes[pipe_cnt].pipe.src.det_size_override *= DCN3_15_CRB_SEGMENT_SIZE_KB;
+
+				crb_idx++;
+			}
+			pipe_cnt++;
+		}
+	}
+
 	if (pipe_cnt)
 		context->bw_ctx.dml.ip.det_buffer_size_kbytes =
 				(max_usable_det / DCN3_15_CRB_SEGMENT_SIZE_KB / pipe_cnt) * DCN3_15_CRB_SEGMENT_SIZE_KB;
 	if (context->bw_ctx.dml.ip.det_buffer_size_kbytes > DCN3_15_MAX_DET_SIZE)
 		context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_15_MAX_DET_SIZE;
-	ASSERT(context->bw_ctx.dml.ip.det_buffer_size_kbytes >= DCN3_15_DEFAULT_DET_SIZE);
+
 	dc->config.enable_4to1MPC = false;
 	if (pipe_cnt == 1 && pipe->plane_state && !dc->debug.disable_z9_mpc) {
 		if (is_dual_plane(pipe->plane_state->format)
@@ -1707,7 +1805,9 @@ static int dcn315_populate_dml_pipes_from_context(
 			dc->config.enable_4to1MPC = true;
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes =
 					(max_usable_det / DCN3_15_CRB_SEGMENT_SIZE_KB / 4) * DCN3_15_CRB_SEGMENT_SIZE_KB;
-		} else if (!is_dual_plane(pipe->plane_state->format) && pipe->plane_state->src_rect.width <= 5120) {
+		} else if (!is_dual_plane(pipe->plane_state->format)
+				&& pipe->plane_state->src_rect.width <= 5120
+				&& pipe->stream->timing.pix_clk_100hz < dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)) {
 			/* Limit to 5k max to avoid forced pipe split when there is not enough detile for swath */
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
 			pipes[0].pipe.src.unbounded_req_mode = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 186538e3e3c0..dbe5d2efa4a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -948,10 +948,10 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 {
 	int plane_count;
 	int i;
-	unsigned int optimized_min_dst_y_next_start_us;
+	unsigned int min_dst_y_next_start_us;
 
 	plane_count = 0;
-	optimized_min_dst_y_next_start_us = 0;
+	min_dst_y_next_start_us = 0;
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (context->res_ctx.pipe_ctx[i].plane_state)
 			plane_count++;
@@ -973,19 +973,18 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 		struct dc_stream_status *stream_status = &context->stream_status[0];
+		struct dc_stream_state *current_stream = context->streams[0];
 		int minmum_z8_residency = dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
 		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
 		bool is_pwrseq0 = link->link_index == 0;
+		bool isFreesyncVideo;
 
-		if (dc_extended_blank_supported(dc)) {
-			for (i = 0; i < dc->res_pool->pipe_count; i++) {
-				if (context->res_ctx.pipe_ctx[i].stream == context->streams[0]
-					&& context->res_ctx.pipe_ctx[i].stream->adjust.v_total_min == context->res_ctx.pipe_ctx[i].stream->adjust.v_total_max
-					&& context->res_ctx.pipe_ctx[i].stream->adjust.v_total_min > context->res_ctx.pipe_ctx[i].stream->timing.v_total) {
-						optimized_min_dst_y_next_start_us =
-							context->res_ctx.pipe_ctx[i].dlg_regs.optimized_min_dst_y_next_start_us;
-						break;
-				}
+		isFreesyncVideo = current_stream->adjust.v_total_min == current_stream->adjust.v_total_max;
+		isFreesyncVideo = isFreesyncVideo && current_stream->timing.v_total < current_stream->adjust.v_total_min;
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			if (context->res_ctx.pipe_ctx[i].stream == current_stream && isFreesyncVideo) {
+				min_dst_y_next_start_us = context->res_ctx.pipe_ctx[i].dlg_regs.min_dst_y_next_start_us;
+				break;
 			}
 		}
 
@@ -993,7 +992,7 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 		if (stream_status->plane_count > 1)
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
 
-		if (is_pwrseq0 && (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000))
+		if (is_pwrseq0 && (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || min_dst_y_next_start_us > 5000))
 			return DCN_ZSTATE_SUPPORT_ALLOW;
 		else if (is_pwrseq0 && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
 			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 8e416433184c..19d034341e64 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -483,7 +483,7 @@ void dcn31_calculate_wm_and_dlg_fp(
 		int pipe_cnt,
 		int vlevel)
 {
-	int i, pipe_idx, active_dpp_count = 0;
+	int i, pipe_idx, total_det = 0, active_hubp_count = 0;
 	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 
 	dc_assert_fp_enabled();
@@ -529,7 +529,7 @@ void dcn31_calculate_wm_and_dlg_fp(
 			continue;
 
 		if (context->res_ctx.pipe_ctx[i].plane_state)
-			active_dpp_count++;
+			active_hubp_count++;
 
 		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
 		pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
@@ -547,9 +547,34 @@ void dcn31_calculate_wm_and_dlg_fp(
 	}
 
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
-	/* For 31x apu pstate change is only supported if possible in vactive or if there are no active dpps */
+	/* For 31x apu pstate change is only supported if possible in vactive*/
 	context->bw_ctx.bw.dcn.clk.p_state_change_support =
-			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_vactive || !active_dpp_count;
+			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_vactive;
+	/* If DCN isn't making memory requests we can allow pstate change and lower clocks */
+	if (!active_hubp_count) {
+		context->bw_ctx.bw.dcn.clk.socclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dramclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.fclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+		for (i = 0; i < dc->res_pool->pipe_count; i++)
+			if (context->res_ctx.pipe_ctx[i].stream)
+				context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = 0;
+	}
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+
+		context->res_ctx.pipe_ctx[i].det_buffer_size_kb =
+				get_det_buffer_size_kbytes(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+		if (context->res_ctx.pipe_ctx[i].det_buffer_size_kb > 384)
+			context->res_ctx.pipe_ctx[i].det_buffer_size_kb /= 2;
+		total_det += context->res_ctx.pipe_ctx[i].det_buffer_size_kb;
+		pipe_idx++;
+	}
+	context->bw_ctx.bw.dcn.compbuf_size_kb = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - total_det;
 }
 
 void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
@@ -797,3 +822,19 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	else
 		dml_init_instance(&dc->dml, &dcn3_16_soc, &dcn3_16_ip, DML_PROJECT_DCN31_FPGA);
 }
+
+int dcn_get_max_non_odm_pix_rate_100hz(struct _vcs_dpi_soc_bounding_box_st *soc)
+{
+	return soc->clock_limits[0].dispclk_mhz * 10000.0 / (1.0 + soc->dcn_downspread_percent / 100.0);
+}
+
+int dcn_get_approx_det_segs_required_for_pstate(
+		struct _vcs_dpi_soc_bounding_box_st *soc,
+		int pix_clk_100hz, int bpp, int seg_size_kb)
+{
+	/* Roughly calculate required crb to hide latency. In practice there is slightly
+	 * more buffer available for latency hiding
+	 */
+	return (int)(soc->dram_clock_change_latency_us * pix_clk_100hz * bpp
+					/ 10240000 + seg_size_kb - 1) /	seg_size_kb;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
index fd58b2561ec9..99518f64d83d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
@@ -46,5 +46,9 @@ void dcn31_calculate_wm_and_dlg_fp(
 void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
+int dcn_get_max_non_odm_pix_rate_100hz(struct _vcs_dpi_soc_bounding_box_st *soc);
+int dcn_get_approx_det_segs_required_for_pstate(
+		struct _vcs_dpi_soc_bounding_box_st *soc,
+		int pix_clk_100hz, int bpp, int seg_size_kb);
 
 #endif /* __DCN31_FPU_H__*/
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index cf8f3d690fa6..ebc04b72b284 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -533,7 +533,8 @@ static void CalculateStutterEfficiency(
 static void CalculateSwathAndDETConfiguration(
 		bool ForceSingleDPP,
 		int NumberOfActivePlanes,
-		unsigned int DETBufferSizeInKByte,
+		bool DETSharedByAllDPP,
+		unsigned int DETBufferSizeInKByte[],
 		double MaximumSwathWidthLuma[],
 		double MaximumSwathWidthChroma[],
 		enum scan_direction_class SourceScan[],
@@ -3116,7 +3117,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				v->SurfaceWidthC[k],
 				v->SurfaceHeightY[k],
 				v->SurfaceHeightC[k],
-				v->DETBufferSizeInKByte[0] * 1024,
+				v->DETBufferSizeInKByte[k] * 1024,
 				v->BlockHeight256BytesY[k],
 				v->BlockHeight256BytesC[k],
 				v->SurfaceTiling[k],
@@ -3311,7 +3312,8 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	CalculateSwathAndDETConfiguration(
 			false,
 			v->NumberOfActivePlanes,
-			v->DETBufferSizeInKByte[0],
+			mode_lib->project == DML_PROJECT_DCN315 && v->DETSizeOverride[0],
+			v->DETBufferSizeInKByte,
 			dummy1,
 			dummy2,
 			v->SourceScan,
@@ -3777,14 +3779,16 @@ static noinline void CalculatePrefetchSchedulePerPlane(
 		&v->VReadyOffsetPix[k]);
 }
 
-static void PatchDETBufferSizeInKByte(unsigned int NumberOfActivePlanes, int NoOfDPPThisState[], unsigned int config_return_buffer_size_in_kbytes, unsigned int *DETBufferSizeInKByte)
+static void PatchDETBufferSizeInKByte(unsigned int NumberOfActivePlanes, int NoOfDPPThisState[], unsigned int config_return_buffer_size_in_kbytes, unsigned int DETBufferSizeInKByte[])
 {
 	int i, total_pipes = 0;
 	for (i = 0; i < NumberOfActivePlanes; i++)
 		total_pipes += NoOfDPPThisState[i];
-	*DETBufferSizeInKByte = ((config_return_buffer_size_in_kbytes - DCN3_15_MIN_COMPBUF_SIZE_KB) / 64 / total_pipes) * 64;
-	if (*DETBufferSizeInKByte > DCN3_15_MAX_DET_SIZE)
-		*DETBufferSizeInKByte = DCN3_15_MAX_DET_SIZE;
+	DETBufferSizeInKByte[0] = ((config_return_buffer_size_in_kbytes - DCN3_15_MIN_COMPBUF_SIZE_KB) / 64 / total_pipes) * 64;
+	if (DETBufferSizeInKByte[0] > DCN3_15_MAX_DET_SIZE)
+		DETBufferSizeInKByte[0] = DCN3_15_MAX_DET_SIZE;
+	for (i = 1; i < NumberOfActivePlanes; i++)
+		DETBufferSizeInKByte[i] = DETBufferSizeInKByte[0];
 }
 
 
@@ -4024,7 +4028,8 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	CalculateSwathAndDETConfiguration(
 			true,
 			v->NumberOfActivePlanes,
-			v->DETBufferSizeInKByte[0],
+			mode_lib->project == DML_PROJECT_DCN315 && v->DETSizeOverride[0],
+			v->DETBufferSizeInKByte,
 			v->MaximumSwathWidthLuma,
 			v->MaximumSwathWidthChroma,
 			v->SourceScan,
@@ -4164,6 +4169,10 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						|| (v->PlaneRequiredDISPCLK > v->MaxDispclkRoundedDownToDFSGranularity)) {
 					v->DISPCLK_DPPCLK_Support[i][j] = false;
 				}
+				if (mode_lib->project == DML_PROJECT_DCN315 && v->DETSizeOverride[k] > DCN3_15_MAX_DET_SIZE && v->NoOfDPP[i][j][k] < 2) {
+					v->MPCCombine[i][j][k] = true;
+					v->NoOfDPP[i][j][k] = 2;
+				}
 			}
 			v->TotalNumberOfActiveDPP[i][j] = 0;
 			v->TotalNumberOfSingleDPPPlanes[i][j] = 0;
@@ -4640,12 +4649,13 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				v->ODMCombineEnableThisState[k] = v->ODMCombineEnablePerState[i][k];
 			}
 
-			if (v->NumberOfActivePlanes > 1 && mode_lib->project == DML_PROJECT_DCN315)
-				PatchDETBufferSizeInKByte(v->NumberOfActivePlanes, v->NoOfDPPThisState, v->ip.config_return_buffer_size_in_kbytes, &v->DETBufferSizeInKByte[0]);
+			if (v->NumberOfActivePlanes > 1 && mode_lib->project == DML_PROJECT_DCN315 && !v->DETSizeOverride[0])
+				PatchDETBufferSizeInKByte(v->NumberOfActivePlanes, v->NoOfDPPThisState, v->ip.config_return_buffer_size_in_kbytes, v->DETBufferSizeInKByte);
 			CalculateSwathAndDETConfiguration(
 					false,
 					v->NumberOfActivePlanes,
-					v->DETBufferSizeInKByte[0],
+					mode_lib->project == DML_PROJECT_DCN315 && v->DETSizeOverride[0],
+					v->DETBufferSizeInKByte,
 					v->MaximumSwathWidthLuma,
 					v->MaximumSwathWidthChroma,
 					v->SourceScan,
@@ -6557,7 +6567,8 @@ static void CalculateStutterEfficiency(
 static void CalculateSwathAndDETConfiguration(
 		bool ForceSingleDPP,
 		int NumberOfActivePlanes,
-		unsigned int DETBufferSizeInKByte,
+		bool DETSharedByAllDPP,
+		unsigned int DETBufferSizeInKByteA[],
 		double MaximumSwathWidthLuma[],
 		double MaximumSwathWidthChroma[],
 		enum scan_direction_class SourceScan[],
@@ -6641,6 +6652,10 @@ static void CalculateSwathAndDETConfiguration(
 
 	*ViewportSizeSupport = true;
 	for (k = 0; k < NumberOfActivePlanes; ++k) {
+		unsigned int DETBufferSizeInKByte = DETBufferSizeInKByteA[k];
+
+		if (DETSharedByAllDPP && DPPPerPlane[k])
+			DETBufferSizeInKByte /= DPPPerPlane[k];
 		if ((SourcePixelFormat[k] == dm_444_64 || SourcePixelFormat[k] == dm_444_32 || SourcePixelFormat[k] == dm_444_16 || SourcePixelFormat[k] == dm_mono_16
 				|| SourcePixelFormat[k] == dm_mono_8 || SourcePixelFormat[k] == dm_rgbe)) {
 			if (SurfaceTiling[k] == dm_sw_linear
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index 35d10b4d018b..d7ee26b62a5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -988,8 +988,7 @@ static void dml_rq_dlg_get_dlg_params(
 
 	dlg_vblank_start = interlaced ? (vblank_start / 2) : vblank_start;
 	disp_dlg_regs->min_dst_y_next_start = (unsigned int) (((double) dlg_vblank_start) * dml_pow(2, 2));
-	disp_dlg_regs->optimized_min_dst_y_next_start_us = 0;
-	disp_dlg_regs->optimized_min_dst_y_next_start = disp_dlg_regs->min_dst_y_next_start;
+	disp_dlg_regs->min_dst_y_next_start_us = 0;
 	ASSERT(disp_dlg_regs->min_dst_y_next_start < (unsigned int)dml_pow(2, 18));
 
 	dml_print("DML_DLG: %s: min_ttu_vblank (us)         = %3.2f\n", __func__, min_ttu_vblank);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index bf77e56c3f3e..8a88605827a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -32,7 +32,7 @@
 #include "dml/display_mode_vba.h"
 
 struct _vcs_dpi_ip_params_st dcn3_14_ip = {
-	.VBlankNomDefaultUS = 668,
+	.VBlankNomDefaultUS = 800,
 	.gpuvm_enable = 1,
 	.gpuvm_max_page_table_levels = 1,
 	.hostvm_enable = 1,
@@ -288,6 +288,7 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	bool upscaled = false;
+	const unsigned int max_allowed_vblank_nom = 1023;
 
 	dc_assert_fp_enabled();
 
@@ -301,9 +302,15 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
-		if (dc_extended_blank_supported(dc) && pipe->stream->adjust.v_total_max == pipe->stream->adjust.v_total_min
-			&& pipe->stream->adjust.v_total_min > timing->v_total)
+		if (pipe->stream->adjust.v_total_min != 0)
 			pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
+		else
+			pipes[pipe_cnt].pipe.dest.vtotal = timing->v_total;
+
+		pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
+		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, dcn3_14_ip.VBlankNomDefaultUS);
+		pipes[pipe_cnt].pipe.dest.vblank_nom = max(pipes[pipe_cnt].pipe.dest.vblank_nom, timing->v_sync_width);
+		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, max_allowed_vblank_nom);
 
 		if (pipe->plane_state &&
 				(pipe->plane_state->src_rect.height < pipe->plane_state->dst_rect.height ||
@@ -327,8 +334,6 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
 		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
-		pipes[pipe_cnt].pipe.dest.vblank_nom =
-				dcn3_14_ip.VBlankNomDefaultUS / (timing->h_total / (timing->pix_clk_100hz / 10000.0));
 		pipes[pipe_cnt].pipe.src.dcc_rate = 3;
 		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index 61ee9ba063a7..26561c0f5fbb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -1053,7 +1053,6 @@ static void dml_rq_dlg_get_dlg_params(
 
 	float vba__refcyc_per_req_delivery_pre_l = get_refcyc_per_req_delivery_pre_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
 	float vba__refcyc_per_req_delivery_l = get_refcyc_per_req_delivery_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
-	int blank_lines = 0;
 
 	memset(disp_dlg_regs, 0, sizeof(*disp_dlg_regs));
 	memset(disp_ttu_regs, 0, sizeof(*disp_ttu_regs));
@@ -1077,17 +1076,10 @@ static void dml_rq_dlg_get_dlg_params(
 	min_ttu_vblank = get_min_ttu_vblank_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);	// From VBA
 
 	dlg_vblank_start = interlaced ? (vblank_start / 2) : vblank_start;
-	disp_dlg_regs->optimized_min_dst_y_next_start = disp_dlg_regs->min_dst_y_next_start;
-	disp_dlg_regs->optimized_min_dst_y_next_start_us = 0;
-	disp_dlg_regs->min_dst_y_next_start = (unsigned int) (((double) dlg_vblank_start) * dml_pow(2, 2));
-	blank_lines = (dst->vblank_end + dst->vtotal_min - dst->vblank_start - dst->vstartup_start - 1);
-	if (blank_lines < 0)
-		blank_lines = 0;
-	if (blank_lines != 0) {
-		disp_dlg_regs->optimized_min_dst_y_next_start = vba__min_dst_y_next_start;
-		disp_dlg_regs->optimized_min_dst_y_next_start_us = (disp_dlg_regs->optimized_min_dst_y_next_start * dst->hactive) / (unsigned int) dst->pixel_rate_mhz;
-		disp_dlg_regs->min_dst_y_next_start = disp_dlg_regs->optimized_min_dst_y_next_start;
-	}
+	disp_dlg_regs->min_dst_y_next_start_us =
+		(vba__min_dst_y_next_start * dst->hactive) / (unsigned int) dst->pixel_rate_mhz;
+	disp_dlg_regs->min_dst_y_next_start = vba__min_dst_y_next_start * dml_pow(2, 2);
+
 	ASSERT(disp_dlg_regs->min_dst_y_next_start < (unsigned int)dml_pow(2, 18));
 
 	dml_print("DML_DLG: %s: min_ttu_vblank (us)         = %3.2f\n", __func__, min_ttu_vblank);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index f28caece5f90..c89b761bcb92 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1237,7 +1237,7 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 				       display_e2e_pipe_params_st *pipes,
 				       int pipe_cnt, int vlevel)
 {
-	int i, pipe_idx;
+	int i, pipe_idx, active_hubp_count = 0;
 	bool usr_retraining_support = false;
 	bool unbounded_req_enabled = false;
 
@@ -1282,6 +1282,8 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
+		if (context->res_ctx.pipe_ctx[i].plane_state)
+			active_hubp_count++;
 		pipes[pipe_idx].pipe.dest.vstartup_start = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt,
 				pipe_idx);
 		pipes[pipe_idx].pipe.dest.vupdate_offset = get_vupdate_offset(&context->bw_ctx.dml, pipes, pipe_cnt,
@@ -1303,10 +1305,23 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 
 		if (context->bw_ctx.bw.dcn.clk.dppclk_khz < pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
 			context->bw_ctx.bw.dcn.clk.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
-		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
+		if (context->res_ctx.pipe_ctx[i].plane_state)
+			context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
+		else
+			context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = 0;
 		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
 		pipe_idx++;
 	}
+	/* If DCN isn't making memory requests we can allow pstate change and lower clocks */
+	if (!active_hubp_count) {
+		context->bw_ctx.bw.dcn.clk.socclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dramclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.fclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+	}
 	/*save a original dppclock copy*/
 	context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.dppclk_khz;
 	context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.dispclk_khz;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 64d602e6412f..6af0d5f469ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -618,8 +618,7 @@ struct _vcs_dpi_display_dlg_regs_st {
 	unsigned int refcyc_h_blank_end;
 	unsigned int dlg_vblank_end;
 	unsigned int min_dst_y_next_start;
-	unsigned int optimized_min_dst_y_next_start;
-	unsigned int optimized_min_dst_y_next_start_us;
+	unsigned int min_dst_y_next_start_us;
 	unsigned int refcyc_per_htotal;
 	unsigned int refcyc_x_after_scaler;
 	unsigned int dst_y_after_scaler;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 8e6585dab20e..1070cf870196 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -569,6 +569,10 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.OutputLinkDPRate[mode_lib->vba.NumberOfActivePlanes] = dout->dp_rate;
 		mode_lib->vba.ODMUse[mode_lib->vba.NumberOfActivePlanes] = dst->odm_combine_policy;
 		mode_lib->vba.DETSizeOverride[mode_lib->vba.NumberOfActivePlanes] = src->det_size_override;
+		if (src->det_size_override)
+			mode_lib->vba.DETBufferSizeInKByte[mode_lib->vba.NumberOfActivePlanes] = src->det_size_override;
+		else
+			mode_lib->vba.DETBufferSizeInKByte[mode_lib->vba.NumberOfActivePlanes] = ip->det_buffer_size_kbytes;
 		//TODO: Need to assign correct values to dp_multistream vars
 		mode_lib->vba.OutputMultistreamEn[mode_lib->vba.NumberOfActiveSurfaces] = dout->dp_multistream_en;
 		mode_lib->vba.OutputMultistreamId[mode_lib->vba.NumberOfActiveSurfaces] = dout->dp_multistream_id;
@@ -783,6 +787,8 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 					mode_lib->vba.pipe_plane[k] =
 							mode_lib->vba.NumberOfActivePlanes;
 					mode_lib->vba.DPPPerPlane[mode_lib->vba.NumberOfActivePlanes]++;
+					if (src_k->det_size_override)
+						mode_lib->vba.DETBufferSizeInKByte[mode_lib->vba.NumberOfActivePlanes] = src_k->det_size_override;
 					if (mode_lib->vba.SourceScan[mode_lib->vba.NumberOfActivePlanes]
 							== dm_horz) {
 						mode_lib->vba.ViewportWidth[mode_lib->vba.NumberOfActivePlanes] +=
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index b53468aca4a9..5f17b252e9be 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -350,6 +350,8 @@ struct dmub_srv_hw_funcs {
 
 	bool (*is_supported)(struct dmub_srv *dmub);
 
+	bool (*is_psrsu_supported)(struct dmub_srv *dmub);
+
 	bool (*is_hw_init)(struct dmub_srv *dmub);
 
 	bool (*is_phy_init)(struct dmub_srv *dmub);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 27a4ea7dc74e..d8c05bc45957 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -345,7 +345,7 @@ union dmub_fw_boot_status {
 		uint32_t optimized_init_done : 1; /**< 1 if optimized init done */
 		uint32_t restore_required : 1; /**< 1 if driver should call restore */
 		uint32_t defer_load : 1; /**< 1 if VBIOS data is deferred programmed */
-		uint32_t reserved : 1;
+		uint32_t fams_enabled : 1; /**< 1 if VBIOS data is deferred programmed */
 		uint32_t detection_required: 1; /**<  if detection need to be triggered by driver */
 
 	} bits; /**< status bits */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/Makefile b/drivers/gpu/drm/amd/display/dmub/src/Makefile
index 0589ad4778ee..caf095aca8f3 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/Makefile
+++ b/drivers/gpu/drm/amd/display/dmub/src/Makefile
@@ -22,7 +22,7 @@
 
 DMUB = dmub_srv.o dmub_srv_stat.o dmub_reg.o dmub_dcn20.o dmub_dcn21.o
 DMUB += dmub_dcn30.o dmub_dcn301.o dmub_dcn302.o dmub_dcn303.o
-DMUB += dmub_dcn31.o dmub_dcn315.o dmub_dcn316.o
+DMUB += dmub_dcn31.o dmub_dcn314.o dmub_dcn315.o dmub_dcn316.o
 DMUB += dmub_dcn32.o
 
 AMD_DAL_DMUB = $(addprefix $(AMDDALPATH)/dmub/src/,$(DMUB))
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index c90b9ee42e12..89d24fb7024e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -297,6 +297,11 @@ bool dmub_dcn31_is_supported(struct dmub_srv *dmub)
 	return supported;
 }
 
+bool dmub_dcn31_is_psrsu_supported(struct dmub_srv *dmub)
+{
+	return dmub->fw_version >= DMUB_FW_VERSION(4, 0, 59);
+}
+
 void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
 			  union dmub_gpint_data_register reg)
 {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
index f6db6f89d45d..eb6241094147 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -219,6 +219,8 @@ bool dmub_dcn31_is_hw_init(struct dmub_srv *dmub);
 
 bool dmub_dcn31_is_supported(struct dmub_srv *dmub);
 
+bool dmub_dcn31_is_psrsu_supported(struct dmub_srv *dmub);
+
 void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
 			  union dmub_gpint_data_register reg);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
new file mode 100644
index 000000000000..f161aeb7e7c4
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
@@ -0,0 +1,67 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "../dmub_srv.h"
+#include "dmub_reg.h"
+#include "dmub_dcn314.h"
+
+#include "dcn/dcn_3_1_4_offset.h"
+#include "dcn/dcn_3_1_4_sh_mask.h"
+
+#define DCN_BASE__INST0_SEG0                       0x00000012
+#define DCN_BASE__INST0_SEG1                       0x000000C0
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+#define DCN_BASE__INST0_SEG3                       0x00009000
+#define DCN_BASE__INST0_SEG4                       0x02403C00
+#define DCN_BASE__INST0_SEG5                       0
+
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG##seg
+#define CTX dmub
+#define REGS dmub->regs_dcn31
+#define REG_OFFSET_EXP(reg_name) (BASE(reg##reg_name##_BASE_IDX) + reg##reg_name)
+
+/* Registers. */
+
+const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs = {
+#define DMUB_SR(reg) REG_OFFSET_EXP(reg),
+	{
+		DMUB_DCN31_REGS()
+		DMCUB_INTERNAL_REGS()
+	},
+#undef DMUB_SR
+
+#define DMUB_SF(reg, field) FD_MASK(reg, field),
+	{ DMUB_DCN31_FIELDS() },
+#undef DMUB_SF
+
+#define DMUB_SF(reg, field) FD_SHIFT(reg, field),
+	{ DMUB_DCN31_FIELDS() },
+#undef DMUB_SF
+};
+
+bool dmub_dcn314_is_psrsu_supported(struct dmub_srv *dmub)
+{
+	return dmub->fw_version >= DMUB_FW_VERSION(8, 0, 16);
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
new file mode 100644
index 000000000000..f213bd82c911
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef _DMUB_DCN314_H_
+#define _DMUB_DCN314_H_
+
+#include "dmub_dcn31.h"
+
+extern const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs;
+
+bool dmub_dcn314_is_psrsu_supported(struct dmub_srv *dmub);
+
+#endif /* _DMUB_DCN314_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 92c18bfb98b3..0dab22d79480 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -32,6 +32,7 @@
 #include "dmub_dcn302.h"
 #include "dmub_dcn303.h"
 #include "dmub_dcn31.h"
+#include "dmub_dcn314.h"
 #include "dmub_dcn315.h"
 #include "dmub_dcn316.h"
 #include "dmub_dcn32.h"
@@ -226,12 +227,17 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 	case DMUB_ASIC_DCN314:
 	case DMUB_ASIC_DCN315:
 	case DMUB_ASIC_DCN316:
-		if (asic == DMUB_ASIC_DCN315)
+		if (asic == DMUB_ASIC_DCN314) {
+			dmub->regs_dcn31 = &dmub_srv_dcn314_regs;
+			funcs->is_psrsu_supported = dmub_dcn314_is_psrsu_supported;
+		} else if (asic == DMUB_ASIC_DCN315) {
 			dmub->regs_dcn31 = &dmub_srv_dcn315_regs;
-		else if (asic == DMUB_ASIC_DCN316)
+		} else if (asic == DMUB_ASIC_DCN316) {
 			dmub->regs_dcn31 = &dmub_srv_dcn316_regs;
-		else
+		} else {
 			dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
+			funcs->is_psrsu_supported = dmub_dcn31_is_psrsu_supported;
+		}
 		funcs->reset = dmub_dcn31_reset;
 		funcs->reset_release = dmub_dcn31_reset_release;
 		funcs->backdoor_load = dmub_dcn31_backdoor_load;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 1b7d93709a35..31835d96deef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2081,89 +2081,36 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 	return ret;
 }
 
-static void sienna_cichlid_get_override_pcie_settings(struct smu_context *smu,
-						      uint32_t *gen_speed_override,
-						      uint32_t *lane_width_override)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	*gen_speed_override = 0xff;
-	*lane_width_override = 0xff;
-
-	switch (adev->pdev->device) {
-	case 0x73A0:
-	case 0x73A1:
-	case 0x73A2:
-	case 0x73A3:
-	case 0x73AB:
-	case 0x73AE:
-		/* Bit 7:0: PCIE lane width, 1 to 7 corresponds is x1 to x32 */
-		*lane_width_override = 6;
-		break;
-	case 0x73E0:
-	case 0x73E1:
-	case 0x73E3:
-		*lane_width_override = 4;
-		break;
-	case 0x7420:
-	case 0x7421:
-	case 0x7422:
-	case 0x7423:
-	case 0x7424:
-		*lane_width_override = 3;
-		break;
-	default:
-		break;
-	}
-}
-
-#define MAX(a, b)	((a) > (b) ? (a) : (b))
-
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					 uint32_t pcie_gen_cap,
 					 uint32_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
-	uint32_t gen_speed_override, lane_width_override;
-	uint8_t *table_member1, *table_member2;
-	uint32_t min_gen_speed, max_gen_speed;
-	uint32_t min_lane_width, max_lane_width;
-	uint32_t smu_pcie_arg;
+	u32 smu_pcie_arg;
 	int ret, i;
 
-	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
-	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
-
-	sienna_cichlid_get_override_pcie_settings(smu,
-						  &gen_speed_override,
-						  &lane_width_override);
+	/* PCIE gen speed and lane width override */
+	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
+		if (pcie_table->pcie_gen[NUM_LINK_LEVELS - 1] < pcie_gen_cap)
+			pcie_gen_cap = pcie_table->pcie_gen[NUM_LINK_LEVELS - 1];
 
-	/* PCIE gen speed override */
-	if (gen_speed_override != 0xff) {
-		min_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
-		max_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
-	} else {
-		min_gen_speed = MAX(0, table_member1[0]);
-		max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
-		min_gen_speed = min_gen_speed > max_gen_speed ?
-				max_gen_speed : min_gen_speed;
-	}
-	pcie_table->pcie_gen[0] = min_gen_speed;
-	pcie_table->pcie_gen[1] = max_gen_speed;
+		if (pcie_table->pcie_lane[NUM_LINK_LEVELS - 1] < pcie_width_cap)
+			pcie_width_cap = pcie_table->pcie_lane[NUM_LINK_LEVELS - 1];
 
-	/* PCIE lane width override */
-	if (lane_width_override != 0xff) {
-		min_lane_width = MIN(pcie_width_cap, lane_width_override);
-		max_lane_width = MIN(pcie_width_cap, lane_width_override);
+		/* Force all levels to use the same settings */
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			pcie_table->pcie_gen[i] = pcie_gen_cap;
+			pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
 	} else {
-		min_lane_width = MAX(1, table_member2[0]);
-		max_lane_width = MIN(pcie_width_cap, table_member2[1]);
-		min_lane_width = min_lane_width > max_lane_width ?
-				 max_lane_width : min_lane_width;
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+				pcie_table->pcie_gen[i] = pcie_gen_cap;
+			if (pcie_table->pcie_lane[i] > pcie_width_cap)
+				pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
 	}
-	pcie_table->pcie_lane[0] = min_lane_width;
-	pcie_table->pcie_lane[1] = max_lane_width;
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
 		smu_pcie_arg = (i << 16 |
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 2456f2a72def..47fafb1fa608 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2490,25 +2490,6 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)
 	return ret;
 }
 
-/*
- * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
- * speed switching. Until we have confirmation from Intel that a specific host
- * supports it, it's safer that we keep it disabled for all.
- *
- * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
- * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
- */
-static bool smu_v13_0_is_pcie_dynamic_switching_supported(void)
-{
-#if IS_ENABLED(CONFIG_X86)
-	struct cpuinfo_x86 *c = &cpu_data(0);
-
-	if (c->x86_vendor == X86_VENDOR_INTEL)
-		return false;
-#endif
-	return true;
-}
-
 int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 				     uint32_t pcie_gen_cap,
 				     uint32_t pcie_width_cap)
@@ -2520,7 +2501,7 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
-	if (!smu_v13_0_is_pcie_dynamic_switching_supported()) {
+	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
 		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
 			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
 
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 0c2be8360525..e592c5da70ce 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -353,10 +353,10 @@ EXPORT_SYMBOL(drm_syncobj_replace_fence);
  */
 static int drm_syncobj_assign_null_handle(struct drm_syncobj *syncobj)
 {
-	struct dma_fence *fence = dma_fence_allocate_private_stub();
+	struct dma_fence *fence = dma_fence_allocate_private_stub(ktime_get());
 
-	if (IS_ERR(fence))
-		return PTR_ERR(fence);
+	if (!fence)
+		return -ENOMEM;
 
 	drm_syncobj_replace_fence(syncobj, fence);
 	dma_fence_put(fence);
diff --git a/drivers/gpu/drm/i915/display/intel_dpt.c b/drivers/gpu/drm/i915/display/intel_dpt.c
index a3893aff3861..ea8a08b9c0b1 100644
--- a/drivers/gpu/drm/i915/display/intel_dpt.c
+++ b/drivers/gpu/drm/i915/display/intel_dpt.c
@@ -163,6 +163,8 @@ struct i915_vma *intel_dpt_pin(struct i915_address_space *vm)
 		i915_vma_get(vma);
 	}
 
+	dpt->obj->mm.dirty = true;
+
 	atomic_dec(&i915->gpu_error.pending_fb_pin);
 	intel_runtime_pm_put(&i915->runtime_pm, wakeref);
 
@@ -258,7 +260,7 @@ intel_dpt_create(struct intel_framebuffer *fb)
 		dpt_obj = i915_gem_object_create_stolen(i915, size);
 	if (IS_ERR(dpt_obj) && !HAS_LMEM(i915)) {
 		drm_dbg_kms(&i915->drm, "Allocating dpt from smem\n");
-		dpt_obj = i915_gem_object_create_internal(i915, size);
+		dpt_obj = i915_gem_object_create_shmem(i915, size);
 	}
 	if (IS_ERR(dpt_obj))
 		return ERR_CAST(dpt_obj);
diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index 436598f19522..02fe7ea8c5df 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -1185,8 +1185,10 @@ static int igt_write_huge(struct drm_i915_private *i915,
 	 * times in succession a possibility by enlarging the permutation array.
 	 */
 	order = i915_random_order(count * count, &prng);
-	if (!order)
-		return -ENOMEM;
+	if (!order) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	max_page_size = rounddown_pow_of_two(obj->mm.page_sizes.sg);
 	max = div_u64(max - size, max_page_size);
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 0829eaf2cd4e..895a0e9db1f0 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -89,7 +89,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
 			 * since we've already mapped it once in
 			 * submit_reloc()
 			 */
-			if (WARN_ON(!ptr))
+			if (WARN_ON(IS_ERR_OR_NULL(ptr)))
 				return;
 
 			for (i = 0; i < dwords; i++) {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
index 2fb58b7098e4..3bd2065a9d30 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
@@ -200,7 +200,7 @@ static const struct a6xx_shader_block {
 	SHADER(A6XX_SP_LB_3_DATA, 0x800),
 	SHADER(A6XX_SP_LB_4_DATA, 0x800),
 	SHADER(A6XX_SP_LB_5_DATA, 0x200),
-	SHADER(A6XX_SP_CB_BINDLESS_DATA, 0x2000),
+	SHADER(A6XX_SP_CB_BINDLESS_DATA, 0x800),
 	SHADER(A6XX_SP_CB_LEGACY_DATA, 0x280),
 	SHADER(A6XX_SP_UAV_DATA, 0x80),
 	SHADER(A6XX_SP_INST_TAG, 0x80),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
index e3795995e145..29bb8ee2bc26 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h
@@ -14,19 +14,6 @@
 
 #define	DPU_PERF_DEFAULT_MAX_CORE_CLK_RATE	412500000
 
-/**
- * enum dpu_core_perf_data_bus_id - data bus identifier
- * @DPU_CORE_PERF_DATA_BUS_ID_MNOC: DPU/MNOC data bus
- * @DPU_CORE_PERF_DATA_BUS_ID_LLCC: MNOC/LLCC data bus
- * @DPU_CORE_PERF_DATA_BUS_ID_EBI: LLCC/EBI data bus
- */
-enum dpu_core_perf_data_bus_id {
-	DPU_CORE_PERF_DATA_BUS_ID_MNOC,
-	DPU_CORE_PERF_DATA_BUS_ID_LLCC,
-	DPU_CORE_PERF_DATA_BUS_ID_EBI,
-	DPU_CORE_PERF_DATA_BUS_ID_MAX,
-};
-
 /**
  * struct dpu_core_perf_params - definition of performance parameters
  * @max_per_pipe_ib: maximum instantaneous bandwidth request
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index ac3d1d492a48..f982a827be7c 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -932,13 +932,11 @@ static int wait_fence(struct msm_gpu_submitqueue *queue, uint32_t fence_id,
 	 * retired, so if the fence is not found it means there is nothing
 	 * to wait for
 	 */
-	ret = mutex_lock_interruptible(&queue->idr_lock);
-	if (ret)
-		return ret;
+	spin_lock(&queue->idr_lock);
 	fence = idr_find(&queue->fence_idr, fence_id);
 	if (fence)
 		fence = dma_fence_get_rcu(fence);
-	mutex_unlock(&queue->idr_lock);
+	spin_unlock(&queue->idr_lock);
 
 	if (!fence)
 		return 0;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index d6162561141c..c12a6ac2d384 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -72,9 +72,9 @@ void __msm_gem_submit_destroy(struct kref *kref)
 	unsigned i;
 
 	if (submit->fence_id) {
-		mutex_lock(&submit->queue->idr_lock);
+		spin_lock(&submit->queue->idr_lock);
 		idr_remove(&submit->queue->fence_idr, submit->fence_id);
-		mutex_unlock(&submit->queue->idr_lock);
+		spin_unlock(&submit->queue->idr_lock);
 	}
 
 	dma_fence_put(submit->user_fence);
@@ -866,7 +866,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 
 	submit->nr_cmds = i;
 
-	mutex_lock(&queue->idr_lock);
+	spin_lock(&queue->idr_lock);
 
 	/*
 	 * If using userspace provided seqno fence, validate that the id
@@ -875,8 +875,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	 * after the job is armed
 	 */
 	if ((args->flags & MSM_SUBMIT_FENCE_SN_IN) &&
-			idr_find(&queue->fence_idr, args->fence)) {
-		mutex_unlock(&queue->idr_lock);
+			(!args->fence || idr_find(&queue->fence_idr, args->fence))) {
+		spin_unlock(&queue->idr_lock);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -910,7 +910,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 						    INT_MAX, GFP_KERNEL);
 	}
 
-	mutex_unlock(&queue->idr_lock);
+	spin_unlock(&queue->idr_lock);
 
 	if (submit->fence_id < 0) {
 		ret = submit->fence_id;
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 732295e25683..b39cd332751d 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -500,7 +500,7 @@ struct msm_gpu_submitqueue {
 	struct msm_file_private *ctx;
 	struct list_head node;
 	struct idr fence_idr;
-	struct mutex idr_lock;
+	struct spinlock idr_lock;
 	struct mutex lock;
 	struct kref ref;
 	struct drm_sched_entity *entity;
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index c6929e205b51..0e803125a325 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -200,7 +200,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
 		*id = queue->id;
 
 	idr_init(&queue->fence_idr);
-	mutex_init(&queue->idr_lock);
+	spin_lock_init(&queue->idr_lock);
 	mutex_init(&queue->lock);
 
 	list_add_tail(&queue->node, &ctx->submitqueues);
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index f2c4e9037d6e..f7aeeee6f526 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -499,17 +499,18 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
 		goto out;
 	}
 
-bounce:
-	ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
-	if (ret == -EMULTIHOP) {
+	do {
+		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
+		if (ret != -EMULTIHOP)
+			break;
+
 		ret = ttm_bo_bounce_temp_buffer(bo, &evict_mem, ctx, &hop);
-		if (ret) {
+	} while (!ret);
+
+	if (ret) {
+		ttm_resource_free(bo, &evict_mem);
+		if (ret != -ERESTARTSYS && ret != -EINTR)
 			pr_err("Buffer eviction failed\n");
-			ttm_resource_free(bo, &evict_mem);
-			goto out;
-		}
-		/* try and move to final place now. */
-		goto bounce;
 	}
 out:
 	return ret;
@@ -549,6 +550,12 @@ static bool ttm_bo_evict_swapout_allowable(struct ttm_buffer_object *bo,
 {
 	bool ret = false;
 
+	if (bo->pin_count) {
+		*locked = false;
+		*busy = false;
+		return false;
+	}
+
 	if (bo->base.resv == ctx->resv) {
 		dma_resv_assert_held(bo->base.resv);
 		if (ctx->allow_res_evict)
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 823d0ca1d605..43aa955ec120 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -77,6 +77,13 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
 #define ZEN_CUR_TEMP_TJ_SEL_MASK		GENMASK(17, 16)
 
+/*
+ * AMD's Industrial processor 3255 supports temperature from -40 deg to 105 deg Celsius.
+ * Use the model name to identify 3255 CPUs and set a flag to display negative temperature.
+ * Do not round off to zero for negative Tctl or Tdie values if the flag is set
+ */
+#define AMD_I3255_STR				"3255"
+
 struct k10temp_data {
 	struct pci_dev *pdev;
 	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
@@ -86,6 +93,7 @@ struct k10temp_data {
 	u32 show_temp;
 	bool is_zen;
 	u32 ccd_offset;
+	bool disp_negative;
 };
 
 #define TCTL_BIT	0
@@ -204,12 +212,12 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 		switch (channel) {
 		case 0:		/* Tctl */
 			*val = get_raw_temp(data);
-			if (*val < 0)
+			if (*val < 0 && !data->disp_negative)
 				*val = 0;
 			break;
 		case 1:		/* Tdie */
 			*val = get_raw_temp(data) - data->temp_offset;
-			if (*val < 0)
+			if (*val < 0 && !data->disp_negative)
 				*val = 0;
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
@@ -405,6 +413,11 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	data->pdev = pdev;
 	data->show_temp |= BIT(TCTL_BIT);	/* Always show Tctl */
 
+	if (boot_cpu_data.x86 == 0x17 &&
+	    strstr(boot_cpu_data.x86_model_id, AMD_I3255_STR)) {
+		data->disp_negative = true;
+	}
+
 	if (boot_cpu_data.x86 == 0x15 &&
 	    ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
 	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {
diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index a175f8283695..e64c12d90a04 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -725,7 +725,7 @@ static umode_t nct7802_temp_is_visible(struct kobject *kobj,
 	if (index >= 38 && index < 46 && !(reg & 0x01))		/* PECI 0 */
 		return 0;
 
-	if (index >= 0x46 && (!(reg & 0x02)))			/* PECI 1 */
+	if (index >= 46 && !(reg & 0x02))			/* PECI 1 */
 		return 0;
 
 	return attr->mode;
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index eeb80e34f9ad..de3b609515e0 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -694,10 +694,8 @@ static int iic_probe(struct platform_device *ofdev)
 	int ret;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		dev_err(&ofdev->dev, "failed to allocate device data\n");
+	if (!dev)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(ofdev, dev);
 
diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a2d12a5b1c34..9c5d66bd6dc1 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -970,12 +970,10 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	struct i2c_vendor_data *vendor = id->data;
 	u32 max_fifo_threshold = (vendor->fifodepth / 2) - 1;
 
-	dev = devm_kzalloc(&adev->dev, sizeof(struct nmk_i2c_dev), GFP_KERNEL);
-	if (!dev) {
-		dev_err(&adev->dev, "cannot allocate memory\n");
-		ret = -ENOMEM;
-		goto err_no_mem;
-	}
+	dev = devm_kzalloc(&adev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
 	dev->vendor = vendor;
 	dev->adev = adev;
 	nmk_i2c_of_probe(np, dev);
@@ -996,30 +994,21 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 	dev->virtbase = devm_ioremap(&adev->dev, adev->res.start,
 				resource_size(&adev->res));
-	if (!dev->virtbase) {
-		ret = -ENOMEM;
-		goto err_no_mem;
-	}
+	if (!dev->virtbase)
+		return -ENOMEM;
 
 	dev->irq = adev->irq[0];
 	ret = devm_request_irq(&adev->dev, dev->irq, i2c_irq_handler, 0,
 				DRIVER_NAME, dev);
 	if (ret) {
 		dev_err(&adev->dev, "cannot claim the irq %d\n", dev->irq);
-		goto err_no_mem;
+		return ret;
 	}
 
-	dev->clk = devm_clk_get(&adev->dev, NULL);
+	dev->clk = devm_clk_get_enabled(&adev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
-		dev_err(&adev->dev, "could not get i2c clock\n");
-		ret = PTR_ERR(dev->clk);
-		goto err_no_mem;
-	}
-
-	ret = clk_prepare_enable(dev->clk);
-	if (ret) {
-		dev_err(&adev->dev, "can't prepare_enable clock\n");
-		goto err_no_mem;
+		dev_err(&adev->dev, "could enable i2c clock\n");
+		return PTR_ERR(dev->clk);
 	}
 
 	init_hw(dev);
@@ -1042,22 +1031,15 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 	ret = i2c_add_adapter(adap);
 	if (ret)
-		goto err_no_adap;
+		return ret;
 
 	pm_runtime_put(&adev->dev);
 
 	return 0;
-
- err_no_adap:
-	clk_disable_unprepare(dev->clk);
- err_no_mem:
-
-	return ret;
 }
 
 static void nmk_i2c_remove(struct amba_device *adev)
 {
-	struct resource *res = &adev->res;
 	struct nmk_i2c_dev *dev = amba_get_drvdata(adev);
 
 	i2c_del_adapter(&dev->adap);
@@ -1066,8 +1048,6 @@ static void nmk_i2c_remove(struct amba_device *adev)
 	clear_all_interrupts(dev);
 	/* disable the controller */
 	i2c_clr_bit(dev->virtbase + I2C_CR, I2C_CR_PE);
-	clk_disable_unprepare(dev->clk);
-	release_mem_region(res->start, resource_size(res));
 }
 
 static struct i2c_vendor_data vendor_stn8815 = {
diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index 319d1fa617c8..051b904cb35f 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -443,9 +443,8 @@ static int sh7760_i2c_probe(struct platform_device *pdev)
 		goto out0;
 	}
 
-	id = kzalloc(sizeof(struct cami2c), GFP_KERNEL);
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
-		dev_err(&pdev->dev, "no mem for private data\n");
 		ret = -ENOMEM;
 		goto out0;
 	}
diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 7279ca0eaa2d..d1fa9ff5aeab 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -226,10 +226,8 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (dev == NULL) {
-		dev_err(&interface->dev, "Out of memory\n");
+	if (!dev)
 		goto error;
-	}
 
 	dev->usb_dev = usb_get_dev(interface_to_usbdev(interface));
 	dev->interface = interface;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 94222de1d371..4ed8814efde6 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -796,7 +796,10 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 {
 	struct bnxt_re_qp *qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
+	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
 	struct bnxt_re_dev *rdev = qp->rdev;
+	struct bnxt_qplib_nq *scq_nq = NULL;
+	struct bnxt_qplib_nq *rcq_nq = NULL;
 	unsigned int flags;
 	int rc;
 
@@ -830,6 +833,15 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	ib_umem_release(qp->rumem);
 	ib_umem_release(qp->sumem);
 
+	/* Flush all the entries of notification queue associated with
+	 * given qp.
+	 */
+	scq_nq = qplib_qp->scq->nq;
+	rcq_nq = qplib_qp->rcq->nq;
+	bnxt_re_synchronize_nq(scq_nq);
+	if (scq_nq != rcq_nq)
+		bnxt_re_synchronize_nq(rcq_nq);
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 74d56900387a..1011293547ef 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -387,6 +387,24 @@ static void bnxt_qplib_service_nq(struct tasklet_struct *t)
 	spin_unlock_bh(&hwq->lock);
 }
 
+/* bnxt_re_synchronize_nq - self polling notification queue.
+ * @nq      -     notification queue pointer
+ *
+ * This function will start polling entries of a given notification queue
+ * for all pending  entries.
+ * This function is useful to synchronize notification entries while resources
+ * are going away.
+ */
+
+void bnxt_re_synchronize_nq(struct bnxt_qplib_nq *nq)
+{
+	int budget = nq->budget;
+
+	nq->budget = nq->hwq.max_elements;
+	bnxt_qplib_service_nq(&nq->nq_tasklet);
+	nq->budget = budget;
+}
+
 static irqreturn_t bnxt_qplib_nq_irq(int irq, void *dev_instance)
 {
 	struct bnxt_qplib_nq *nq = dev_instance;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index f859710f9a7f..49d89c080827 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -548,6 +548,7 @@ int bnxt_qplib_process_flush_list(struct bnxt_qplib_cq *cq,
 				  struct bnxt_qplib_cqe *cqe,
 				  int num_cqes);
 void bnxt_qplib_flush_cqn_wq(struct bnxt_qplib_qp *qp);
+void bnxt_re_synchronize_nq(struct bnxt_qplib_nq *nq);
 
 static inline void *bnxt_qplib_get_swqe(struct bnxt_qplib_q *que, u32 *swq_idx)
 {
diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index a41e0d21143a..6544c9c60b7d 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -2693,13 +2693,13 @@ static int irdma_sc_cq_modify(struct irdma_sc_cq *cq,
  */
 void irdma_check_cqp_progress(struct irdma_cqp_timeout *timeout, struct irdma_sc_dev *dev)
 {
-	if (timeout->compl_cqp_cmds != dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS]) {
-		timeout->compl_cqp_cmds = dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS];
+	u64 completed_ops = atomic64_read(&dev->cqp->completed_ops);
+
+	if (timeout->compl_cqp_cmds != completed_ops) {
+		timeout->compl_cqp_cmds = completed_ops;
 		timeout->count = 0;
-	} else {
-		if (dev->cqp_cmd_stats[IRDMA_OP_REQ_CMDS] !=
-		    timeout->compl_cqp_cmds)
-			timeout->count++;
+	} else if (timeout->compl_cqp_cmds != dev->cqp->requested_ops) {
+		timeout->count++;
 	}
 }
 
@@ -2742,7 +2742,7 @@ static int irdma_cqp_poll_registers(struct irdma_sc_cqp *cqp, u32 tail,
 		if (newtail != tail) {
 			/* SUCCESS */
 			IRDMA_RING_MOVE_TAIL(cqp->sq_ring);
-			cqp->dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS]++;
+			atomic64_inc(&cqp->completed_ops);
 			return 0;
 		}
 		udelay(cqp->dev->hw_attrs.max_sleep_count);
@@ -3102,8 +3102,8 @@ int irdma_sc_cqp_init(struct irdma_sc_cqp *cqp,
 	info->dev->cqp = cqp;
 
 	IRDMA_RING_INIT(cqp->sq_ring, cqp->sq_size);
-	cqp->dev->cqp_cmd_stats[IRDMA_OP_REQ_CMDS] = 0;
-	cqp->dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS] = 0;
+	cqp->requested_ops = 0;
+	atomic64_set(&cqp->completed_ops, 0);
 	/* for the cqp commands backlog. */
 	INIT_LIST_HEAD(&cqp->dev->cqp_cmd_head);
 
@@ -3255,7 +3255,7 @@ __le64 *irdma_sc_cqp_get_next_send_wqe_idx(struct irdma_sc_cqp *cqp, u64 scratch
 	if (ret_code)
 		return NULL;
 
-	cqp->dev->cqp_cmd_stats[IRDMA_OP_REQ_CMDS]++;
+	cqp->requested_ops++;
 	if (!*wqe_idx)
 		cqp->polarity = !cqp->polarity;
 	wqe = cqp->sq_base[*wqe_idx].elem;
@@ -3344,6 +3344,9 @@ int irdma_sc_ccq_get_cqe_info(struct irdma_sc_cq *ccq,
 	if (polarity != ccq->cq_uk.polarity)
 		return -ENOENT;
 
+	/* Ensure CEQE contents are read after valid bit is checked */
+	dma_rmb();
+
 	get_64bit_val(cqe, 8, &qp_ctx);
 	cqp = (struct irdma_sc_cqp *)(unsigned long)qp_ctx;
 	info->error = (bool)FIELD_GET(IRDMA_CQ_ERROR, temp);
@@ -3378,7 +3381,7 @@ int irdma_sc_ccq_get_cqe_info(struct irdma_sc_cq *ccq,
 	dma_wmb(); /* make sure shadow area is updated before moving tail */
 
 	IRDMA_RING_MOVE_TAIL(cqp->sq_ring);
-	ccq->dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS]++;
+	atomic64_inc(&cqp->completed_ops);
 
 	return ret_code;
 }
@@ -3990,13 +3993,17 @@ int irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 	u8 polarity;
 
 	aeqe = IRDMA_GET_CURRENT_AEQ_ELEM(aeq);
-	get_64bit_val(aeqe, 0, &compl_ctx);
 	get_64bit_val(aeqe, 8, &temp);
 	polarity = (u8)FIELD_GET(IRDMA_AEQE_VALID, temp);
 
 	if (aeq->polarity != polarity)
 		return -ENOENT;
 
+	/* Ensure AEQE contents are read after valid bit is checked */
+	dma_rmb();
+
+	get_64bit_val(aeqe, 0, &compl_ctx);
+
 	print_hex_dump_debug("WQE: AEQ_ENTRY WQE", DUMP_PREFIX_OFFSET, 16, 8,
 			     aeqe, 16, false);
 
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index c1906cab5c8a..ad54260cb58c 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -190,32 +190,30 @@ enum irdma_cqp_op_type {
 	IRDMA_OP_MANAGE_VF_PBLE_BP		= 25,
 	IRDMA_OP_QUERY_FPM_VAL			= 26,
 	IRDMA_OP_COMMIT_FPM_VAL			= 27,
-	IRDMA_OP_REQ_CMDS			= 28,
-	IRDMA_OP_CMPL_CMDS			= 29,
-	IRDMA_OP_AH_CREATE			= 30,
-	IRDMA_OP_AH_MODIFY			= 31,
-	IRDMA_OP_AH_DESTROY			= 32,
-	IRDMA_OP_MC_CREATE			= 33,
-	IRDMA_OP_MC_DESTROY			= 34,
-	IRDMA_OP_MC_MODIFY			= 35,
-	IRDMA_OP_STATS_ALLOCATE			= 36,
-	IRDMA_OP_STATS_FREE			= 37,
-	IRDMA_OP_STATS_GATHER			= 38,
-	IRDMA_OP_WS_ADD_NODE			= 39,
-	IRDMA_OP_WS_MODIFY_NODE			= 40,
-	IRDMA_OP_WS_DELETE_NODE			= 41,
-	IRDMA_OP_WS_FAILOVER_START		= 42,
-	IRDMA_OP_WS_FAILOVER_COMPLETE		= 43,
-	IRDMA_OP_SET_UP_MAP			= 44,
-	IRDMA_OP_GEN_AE				= 45,
-	IRDMA_OP_QUERY_RDMA_FEATURES		= 46,
-	IRDMA_OP_ALLOC_LOCAL_MAC_ENTRY		= 47,
-	IRDMA_OP_ADD_LOCAL_MAC_ENTRY		= 48,
-	IRDMA_OP_DELETE_LOCAL_MAC_ENTRY		= 49,
-	IRDMA_OP_CQ_MODIFY			= 50,
+	IRDMA_OP_AH_CREATE			= 28,
+	IRDMA_OP_AH_MODIFY			= 29,
+	IRDMA_OP_AH_DESTROY			= 30,
+	IRDMA_OP_MC_CREATE			= 31,
+	IRDMA_OP_MC_DESTROY			= 32,
+	IRDMA_OP_MC_MODIFY			= 33,
+	IRDMA_OP_STATS_ALLOCATE			= 34,
+	IRDMA_OP_STATS_FREE			= 35,
+	IRDMA_OP_STATS_GATHER			= 36,
+	IRDMA_OP_WS_ADD_NODE			= 37,
+	IRDMA_OP_WS_MODIFY_NODE			= 38,
+	IRDMA_OP_WS_DELETE_NODE			= 39,
+	IRDMA_OP_WS_FAILOVER_START		= 40,
+	IRDMA_OP_WS_FAILOVER_COMPLETE		= 41,
+	IRDMA_OP_SET_UP_MAP			= 42,
+	IRDMA_OP_GEN_AE				= 43,
+	IRDMA_OP_QUERY_RDMA_FEATURES		= 44,
+	IRDMA_OP_ALLOC_LOCAL_MAC_ENTRY		= 45,
+	IRDMA_OP_ADD_LOCAL_MAC_ENTRY		= 46,
+	IRDMA_OP_DELETE_LOCAL_MAC_ENTRY		= 47,
+	IRDMA_OP_CQ_MODIFY			= 48,
 
 	/* Must be last entry*/
-	IRDMA_MAX_CQP_OPS			= 51,
+	IRDMA_MAX_CQP_OPS			= 49,
 };
 
 /* CQP SQ WQES */
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 43dfa4761f06..c07ce85d243f 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -191,6 +191,7 @@ static void irdma_set_flush_fields(struct irdma_sc_qp *qp,
 	case IRDMA_AE_AMP_MWBIND_INVALID_RIGHTS:
 	case IRDMA_AE_AMP_MWBIND_BIND_DISABLED:
 	case IRDMA_AE_AMP_MWBIND_INVALID_BOUNDS:
+	case IRDMA_AE_AMP_MWBIND_VALID_STAG:
 		qp->flush_code = FLUSH_MW_BIND_ERR;
 		qp->event_type = IRDMA_QP_EVENT_ACCESS_ERR;
 		break;
@@ -2068,7 +2069,7 @@ void irdma_cqp_ce_handler(struct irdma_pci_f *rf, struct irdma_sc_cq *cq)
 			cqp_request->compl_info.error = info.error;
 
 			if (cqp_request->waiting) {
-				cqp_request->request_done = true;
+				WRITE_ONCE(cqp_request->request_done, true);
 				wake_up(&cqp_request->waitq);
 				irdma_put_cqp_request(&rf->cqp, cqp_request);
 			} else {
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 65e966ad3453..e64205839d03 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -159,8 +159,8 @@ struct irdma_cqp_request {
 	void (*callback_fcn)(struct irdma_cqp_request *cqp_request);
 	void *param;
 	struct irdma_cqp_compl_info compl_info;
+	bool request_done; /* READ/WRITE_ONCE macros operate on it */
 	bool waiting:1;
-	bool request_done:1;
 	bool dynamic:1;
 };
 
diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 4ec9639f1bdb..562531712ea4 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -230,6 +230,9 @@ static int irdma_puda_poll_info(struct irdma_sc_cq *cq,
 	if (valid_bit != cq_uk->polarity)
 		return -ENOENT;
 
+	/* Ensure CQE contents are read after valid bit is checked */
+	dma_rmb();
+
 	if (cq->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
 		ext_valid = (bool)FIELD_GET(IRDMA_CQ_EXTCQE, qword3);
 
@@ -243,6 +246,9 @@ static int irdma_puda_poll_info(struct irdma_sc_cq *cq,
 		if (polarity != cq_uk->polarity)
 			return -ENOENT;
 
+		/* Ensure ext CQE contents are read after ext valid bit is checked */
+		dma_rmb();
+
 		IRDMA_RING_MOVE_HEAD_NOCHECK(cq_uk->cq_ring);
 		if (!IRDMA_RING_CURRENT_HEAD(cq_uk->cq_ring))
 			cq_uk->polarity = !cq_uk->polarity;
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 517d41a1c289..d6cb94dc744c 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -410,6 +410,8 @@ struct irdma_sc_cqp {
 	struct irdma_dcqcn_cc_params dcqcn_params;
 	__le64 *host_ctx;
 	u64 *scratch_array;
+	u64 requested_ops;
+	atomic64_t completed_ops;
 	u32 cqp_id;
 	u32 sq_size;
 	u32 hw_sq_size;
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index dd428d915c17..280d633d4ec4 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1161,7 +1161,7 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 	}
 	wqe_idx = (u32)FIELD_GET(IRDMA_CQ_WQEIDX, qword3);
 	info->qp_handle = (irdma_qp_handle)(unsigned long)qp;
-	info->op_type = (u8)FIELD_GET(IRDMA_CQ_SQ, qword3);
+	info->op_type = (u8)FIELD_GET(IRDMACQ_OP, qword3);
 
 	if (info->q_type == IRDMA_CQE_QTYPE_RQ) {
 		u32 array_idx;
@@ -1527,6 +1527,9 @@ void irdma_uk_clean_cq(void *q, struct irdma_cq_uk *cq)
 		if (polarity != temp)
 			break;
 
+		/* Ensure CQE contents are read after valid bit is checked */
+		dma_rmb();
+
 		get_64bit_val(cqe, 8, &comp_ctx);
 		if ((void *)(unsigned long)comp_ctx == q)
 			set_64bit_val(cqe, 8, 0);
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 7887230c867b..8c7617776e58 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -481,7 +481,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
 	if (cqp_request->dynamic) {
 		kfree(cqp_request);
 	} else {
-		cqp_request->request_done = false;
+		WRITE_ONCE(cqp_request->request_done, false);
 		cqp_request->callback_fcn = NULL;
 		cqp_request->waiting = false;
 
@@ -515,7 +515,7 @@ irdma_free_pending_cqp_request(struct irdma_cqp *cqp,
 {
 	if (cqp_request->waiting) {
 		cqp_request->compl_info.error = true;
-		cqp_request->request_done = true;
+		WRITE_ONCE(cqp_request->request_done, true);
 		wake_up(&cqp_request->waitq);
 	}
 	wait_event_timeout(cqp->remove_wq,
@@ -567,11 +567,11 @@ static int irdma_wait_event(struct irdma_pci_f *rf,
 	bool cqp_error = false;
 	int err_code = 0;
 
-	cqp_timeout.compl_cqp_cmds = rf->sc_dev.cqp_cmd_stats[IRDMA_OP_CMPL_CMDS];
+	cqp_timeout.compl_cqp_cmds = atomic64_read(&rf->sc_dev.cqp->completed_ops);
 	do {
 		irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
 		if (wait_event_timeout(cqp_request->waitq,
-				       cqp_request->request_done,
+				       READ_ONCE(cqp_request->request_done),
 				       msecs_to_jiffies(CQP_COMPL_WAIT_TIME_MS)))
 			break;
 
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 488c906c0432..ac479e81ddee 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -530,15 +530,15 @@ static int set_qp_rss(struct mlx4_ib_dev *dev, struct mlx4_ib_rss *rss_ctx,
 		return (-EOPNOTSUPP);
 	}
 
-	if (ucmd->rx_hash_fields_mask & ~(MLX4_IB_RX_HASH_SRC_IPV4	|
-					  MLX4_IB_RX_HASH_DST_IPV4	|
-					  MLX4_IB_RX_HASH_SRC_IPV6	|
-					  MLX4_IB_RX_HASH_DST_IPV6	|
-					  MLX4_IB_RX_HASH_SRC_PORT_TCP	|
-					  MLX4_IB_RX_HASH_DST_PORT_TCP	|
-					  MLX4_IB_RX_HASH_SRC_PORT_UDP	|
-					  MLX4_IB_RX_HASH_DST_PORT_UDP  |
-					  MLX4_IB_RX_HASH_INNER)) {
+	if (ucmd->rx_hash_fields_mask & ~(u64)(MLX4_IB_RX_HASH_SRC_IPV4	|
+					       MLX4_IB_RX_HASH_DST_IPV4	|
+					       MLX4_IB_RX_HASH_SRC_IPV6	|
+					       MLX4_IB_RX_HASH_DST_IPV6	|
+					       MLX4_IB_RX_HASH_SRC_PORT_TCP |
+					       MLX4_IB_RX_HASH_DST_PORT_TCP |
+					       MLX4_IB_RX_HASH_SRC_PORT_UDP |
+					       MLX4_IB_RX_HASH_DST_PORT_UDP |
+					       MLX4_IB_RX_HASH_INNER)) {
 		pr_debug("RX Hash fields_mask has unsupported mask (0x%llx)\n",
 			 ucmd->rx_hash_fields_mask);
 		return (-EOPNOTSUPP);
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 69bba0ef4a5d..53f43649f7d0 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1393,7 +1393,7 @@ int mthca_alloc_sqp(struct mthca_dev *dev,
 	if (mthca_array_get(&dev->qp_table.qp, mqpn))
 		err = -EBUSY;
 	else
-		mthca_array_set(&dev->qp_table.qp, mqpn, qp->sqp);
+		mthca_array_set(&dev->qp_table.qp, mqpn, qp);
 	spin_unlock_irq(&dev->qp_table.lock);
 
 	if (err)
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index 6899e37810a8..b14c74f7b9b9 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -82,6 +82,7 @@ struct bcm6345_l1_chip {
 };
 
 struct bcm6345_l1_cpu {
+	struct bcm6345_l1_chip	*intc;
 	void __iomem		*map_base;
 	unsigned int		parent_irq;
 	u32			enable_cache[];
@@ -115,17 +116,11 @@ static inline unsigned int cpu_for_irq(struct bcm6345_l1_chip *intc,
 
 static void bcm6345_l1_irq_handle(struct irq_desc *desc)
 {
-	struct bcm6345_l1_chip *intc = irq_desc_get_handler_data(desc);
-	struct bcm6345_l1_cpu *cpu;
+	struct bcm6345_l1_cpu *cpu = irq_desc_get_handler_data(desc);
+	struct bcm6345_l1_chip *intc = cpu->intc;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int idx;
 
-#ifdef CONFIG_SMP
-	cpu = intc->cpus[cpu_logical_map(smp_processor_id())];
-#else
-	cpu = intc->cpus[0];
-#endif
-
 	chained_irq_enter(chip, desc);
 
 	for (idx = 0; idx < intc->n_words; idx++) {
@@ -253,6 +248,7 @@ static int __init bcm6345_l1_init_one(struct device_node *dn,
 	if (!cpu)
 		return -ENOMEM;
 
+	cpu->intc = intc;
 	cpu->map_base = ioremap(res.start, sz);
 	if (!cpu->map_base)
 		return -ENOMEM;
@@ -268,7 +264,7 @@ static int __init bcm6345_l1_init_one(struct device_node *dn,
 		return -EINVAL;
 	}
 	irq_set_chained_handler_and_data(cpu->parent_irq,
-						bcm6345_l1_irq_handle, intc);
+						bcm6345_l1_irq_handle, cpu);
 
 	return 0;
 }
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 973ede0197e3..8956881503d9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -271,13 +271,23 @@ static void vpe_to_cpuid_unlock(struct its_vpe *vpe, unsigned long flags)
 	raw_spin_unlock_irqrestore(&vpe->vpe_lock, flags);
 }
 
+static struct irq_chip its_vpe_irq_chip;
+
 static int irq_to_cpuid_lock(struct irq_data *d, unsigned long *flags)
 {
-	struct its_vlpi_map *map = get_vlpi_map(d);
+	struct its_vpe *vpe = NULL;
 	int cpu;
 
-	if (map) {
-		cpu = vpe_to_cpuid_lock(map->vpe, flags);
+	if (d->chip == &its_vpe_irq_chip) {
+		vpe = irq_data_get_irq_chip_data(d);
+	} else {
+		struct its_vlpi_map *map = get_vlpi_map(d);
+		if (map)
+			vpe = map->vpe;
+	}
+
+	if (vpe) {
+		cpu = vpe_to_cpuid_lock(vpe, flags);
 	} else {
 		/* Physical LPIs are already locked via the irq_desc lock */
 		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
@@ -291,10 +301,18 @@ static int irq_to_cpuid_lock(struct irq_data *d, unsigned long *flags)
 
 static void irq_to_cpuid_unlock(struct irq_data *d, unsigned long flags)
 {
-	struct its_vlpi_map *map = get_vlpi_map(d);
+	struct its_vpe *vpe = NULL;
+
+	if (d->chip == &its_vpe_irq_chip) {
+		vpe = irq_data_get_irq_chip_data(d);
+	} else {
+		struct its_vlpi_map *map = get_vlpi_map(d);
+		if (map)
+			vpe = map->vpe;
+	}
 
-	if (map)
-		vpe_to_cpuid_unlock(map->vpe, flags);
+	if (vpe)
+		vpe_to_cpuid_unlock(vpe, flags);
 }
 
 static struct its_collection *valid_col(struct its_collection *col)
@@ -1431,14 +1449,29 @@ static void wait_for_syncr(void __iomem *rdbase)
 		cpu_relax();
 }
 
-static void direct_lpi_inv(struct irq_data *d)
+static void __direct_lpi_inv(struct irq_data *d, u64 val)
 {
-	struct its_vlpi_map *map = get_vlpi_map(d);
 	void __iomem *rdbase;
 	unsigned long flags;
-	u64 val;
 	int cpu;
 
+	/* Target the redistributor this LPI is currently routed to */
+	cpu = irq_to_cpuid_lock(d, &flags);
+	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
+
+	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
+	gic_write_lpir(val, rdbase + GICR_INVLPIR);
+	wait_for_syncr(rdbase);
+
+	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
+	irq_to_cpuid_unlock(d, flags);
+}
+
+static void direct_lpi_inv(struct irq_data *d)
+{
+	struct its_vlpi_map *map = get_vlpi_map(d);
+	u64 val;
+
 	if (map) {
 		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 
@@ -1451,15 +1484,7 @@ static void direct_lpi_inv(struct irq_data *d)
 		val = d->hwirq;
 	}
 
-	/* Target the redistributor this LPI is currently routed to */
-	cpu = irq_to_cpuid_lock(d, &flags);
-	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
-	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
-	gic_write_lpir(val, rdbase + GICR_INVLPIR);
-
-	wait_for_syncr(rdbase);
-	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
-	irq_to_cpuid_unlock(d, flags);
+	__direct_lpi_inv(d, val);
 }
 
 static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
@@ -3941,18 +3966,10 @@ static void its_vpe_send_inv(struct irq_data *d)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
 
-	if (gic_rdists->has_direct_lpi) {
-		void __iomem *rdbase;
-
-		/* Target the redistributor this VPE is currently known on */
-		raw_spin_lock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
-		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
-		gic_write_lpir(d->parent_data->hwirq, rdbase + GICR_INVLPIR);
-		wait_for_syncr(rdbase);
-		raw_spin_unlock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
-	} else {
+	if (gic_rdists->has_direct_lpi)
+		__direct_lpi_inv(d, d->parent_data->hwirq);
+	else
 		its_vpe_send_cmd(vpe, its_send_inv);
-	}
 }
 
 static void its_vpe_mask_irq(struct irq_data *d)
diff --git a/drivers/md/dm-cache-policy-smq.c b/drivers/md/dm-cache-policy-smq.c
index 54343812223e..c983cf240632 100644
--- a/drivers/md/dm-cache-policy-smq.c
+++ b/drivers/md/dm-cache-policy-smq.c
@@ -855,7 +855,13 @@ struct smq_policy {
 
 	struct background_tracker *bg_work;
 
-	bool migrations_allowed;
+	bool migrations_allowed:1;
+
+	/*
+	 * If this is set the policy will try and clean the whole cache
+	 * even if the device is not idle.
+	 */
+	bool cleaner:1;
 };
 
 /*----------------------------------------------------------------*/
@@ -1136,7 +1142,7 @@ static bool clean_target_met(struct smq_policy *mq, bool idle)
 	 * Cache entries may not be populated.  So we cannot rely on the
 	 * size of the clean queue.
 	 */
-	if (idle) {
+	if (idle || mq->cleaner) {
 		/*
 		 * We'd like to clean everything.
 		 */
@@ -1719,11 +1725,9 @@ static void calc_hotspot_params(sector_t origin_size,
 		*hotspot_block_size /= 2u;
 }
 
-static struct dm_cache_policy *__smq_create(dm_cblock_t cache_size,
-					    sector_t origin_size,
-					    sector_t cache_block_size,
-					    bool mimic_mq,
-					    bool migrations_allowed)
+static struct dm_cache_policy *
+__smq_create(dm_cblock_t cache_size, sector_t origin_size, sector_t cache_block_size,
+	     bool mimic_mq, bool migrations_allowed, bool cleaner)
 {
 	unsigned int i;
 	unsigned int nr_sentinels_per_queue = 2u * NR_CACHE_LEVELS;
@@ -1810,6 +1814,7 @@ static struct dm_cache_policy *__smq_create(dm_cblock_t cache_size,
 		goto bad_btracker;
 
 	mq->migrations_allowed = migrations_allowed;
+	mq->cleaner = cleaner;
 
 	return &mq->policy;
 
@@ -1833,21 +1838,24 @@ static struct dm_cache_policy *smq_create(dm_cblock_t cache_size,
 					  sector_t origin_size,
 					  sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, false, true);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    false, true, false);
 }
 
 static struct dm_cache_policy *mq_create(dm_cblock_t cache_size,
 					 sector_t origin_size,
 					 sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, true, true);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    true, true, false);
 }
 
 static struct dm_cache_policy *cleaner_create(dm_cblock_t cache_size,
 					      sector_t origin_size,
 					      sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, false, false);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    false, false, true);
 }
 
 /*----------------------------------------------------------------*/
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index b26c12856b1d..4b7528dc2fd0 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3254,8 +3254,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	r = md_start(&rs->md);
 	if (r) {
 		ti->error = "Failed to start raid array";
-		mddev_unlock(&rs->md);
-		goto bad_md_start;
+		goto bad_unlock;
 	}
 
 	/* If raid4/5/6 journal mode explicitly requested (only possible with journal dev) -> set it */
@@ -3263,8 +3262,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		r = r5c_journal_mode_set(&rs->md, rs->journal_dev.mode);
 		if (r) {
 			ti->error = "Failed to set raid4/5/6 journal mode";
-			mddev_unlock(&rs->md);
-			goto bad_journal_mode_set;
+			goto bad_unlock;
 		}
 	}
 
@@ -3275,14 +3273,14 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	if (rs_is_raid456(rs)) {
 		r = rs_set_raid456_stripe_cache(rs);
 		if (r)
-			goto bad_stripe_cache;
+			goto bad_unlock;
 	}
 
 	/* Now do an early reshape check */
 	if (test_bit(RT_FLAG_RESHAPE_RS, &rs->runtime_flags)) {
 		r = rs_check_reshape(rs);
 		if (r)
-			goto bad_check_reshape;
+			goto bad_unlock;
 
 		/* Restore new, ctr requested layout to perform check */
 		rs_config_restore(rs, &rs_layout);
@@ -3291,7 +3289,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 			r = rs->md.pers->check_reshape(&rs->md);
 			if (r) {
 				ti->error = "Reshape check failed";
-				goto bad_check_reshape;
+				goto bad_unlock;
 			}
 		}
 	}
@@ -3302,11 +3300,9 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	mddev_unlock(&rs->md);
 	return 0;
 
-bad_md_start:
-bad_journal_mode_set:
-bad_stripe_cache:
-bad_check_reshape:
+bad_unlock:
 	md_stop(&rs->md);
+	mddev_unlock(&rs->md);
 bad:
 	raid_set_free(rs);
 
@@ -3317,7 +3313,9 @@ static void raid_dtr(struct dm_target *ti)
 {
 	struct raid_set *rs = ti->private;
 
+	mddev_lock_nointr(&rs->md);
 	md_stop(&rs->md);
+	mddev_unlock(&rs->md);
 	raid_set_free(rs);
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 829e1bd9bcbf..45daba0eb931 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6269,6 +6269,8 @@ static void __md_stop(struct mddev *mddev)
 
 void md_stop(struct mddev *mddev)
 {
+	lockdep_assert_held(&mddev->reconfig_mutex);
+
 	/* stop the array and free an attached data structures.
 	 * This is called from dm-raid
 	 */
diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index f9ec1753f7c8..be8041068268 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -828,7 +828,7 @@ static const struct dev_pm_ops vpu_core_pm_ops = {
 
 static struct vpu_core_resources imx8q_enc = {
 	.type = VPU_CORE_TYPE_ENC,
-	.fwname = "vpu/vpu_fw_imx8_enc.bin",
+	.fwname = "amphion/vpu/vpu_fw_imx8_enc.bin",
 	.stride = 16,
 	.max_width = 1920,
 	.max_height = 1920,
@@ -843,7 +843,7 @@ static struct vpu_core_resources imx8q_enc = {
 
 static struct vpu_core_resources imx8q_dec = {
 	.type = VPU_CORE_TYPE_DEC,
-	.fwname = "vpu/vpu_fw_imx8_dec.bin",
+	.fwname = "amphion/vpu/vpu_fw_imx8_dec.bin",
 	.stride = 256,
 	.max_width = 8188,
 	.max_height = 8188,
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 91d84df91123..576370f89c75 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1512,6 +1512,11 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
 
 	memcpy(bond_dev->broadcast, slave_dev->broadcast,
 		slave_dev->addr_len);
+
+	if (slave_dev->flags & IFF_POINTOPOINT) {
+		bond_dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		bond_dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	}
 }
 
 /* On bonding slaves other than the currently active slave, suppress
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index fe532d504889..5858cbafbc96 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -989,6 +989,8 @@ static int gs_can_close(struct net_device *netdev)
 	usb_kill_anchored_urbs(&dev->tx_submitted);
 	atomic_set(&dev->active_tx_urbs, 0);
 
+	dev->can.state = CAN_STATE_STOPPED;
+
 	/* reset the device */
 	rc = gs_cmd_reset(dev);
 	if (rc < 0)
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index fb45b598847b..7c3dd71a81bd 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -281,7 +281,7 @@ void qca8k_fdb_flush(struct qca8k_priv *priv)
 }
 
 static int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
-				       const u8 *mac, u16 vid)
+				       const u8 *mac, u16 vid, u8 aging)
 {
 	struct qca8k_fdb fdb = { 0 };
 	int ret;
@@ -298,10 +298,12 @@ static int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
 		goto exit;
 
 	/* Rule exist. Delete first */
-	if (!fdb.aging) {
+	if (fdb.aging) {
 		ret = qca8k_fdb_access(priv, QCA8K_FDB_PURGE, -1);
 		if (ret)
 			goto exit;
+	} else {
+		fdb.aging = aging;
 	}
 
 	/* Add port to fdb portmask */
@@ -328,6 +330,10 @@ static int qca8k_fdb_search_and_del(struct qca8k_priv *priv, u8 port_mask,
 	if (ret < 0)
 		goto exit;
 
+	ret = qca8k_fdb_read(priv, &fdb);
+	if (ret < 0)
+		goto exit;
+
 	/* Rule doesn't exist. Why delete? */
 	if (!fdb.aging) {
 		ret = -EINVAL;
@@ -847,7 +853,11 @@ int qca8k_port_mdb_add(struct dsa_switch *ds, int port,
 	const u8 *addr = mdb->addr;
 	u16 vid = mdb->vid;
 
-	return qca8k_fdb_search_and_insert(priv, BIT(port), addr, vid);
+	if (!vid)
+		vid = QCA8K_PORT_VID_DEF;
+
+	return qca8k_fdb_search_and_insert(priv, BIT(port), addr, vid,
+					   QCA8K_ATU_STATUS_STATIC);
 }
 
 int qca8k_port_mdb_del(struct dsa_switch *ds, int port,
@@ -858,6 +868,9 @@ int qca8k_port_mdb_del(struct dsa_switch *ds, int port,
 	const u8 *addr = mdb->addr;
 	u16 vid = mdb->vid;
 
+	if (!vid)
+		vid = QCA8K_PORT_VID_DEF;
+
 	return qca8k_fdb_search_and_del(priv, BIT(port), addr, vid);
 }
 
diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index 5db0f3495a32..5935be190b9e 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -1641,8 +1641,11 @@ static int atl1e_tso_csum(struct atl1e_adapter *adapter,
 			real_len = (((unsigned char *)ip_hdr(skb) - skb->data)
 					+ ntohs(ip_hdr(skb)->tot_len));
 
-			if (real_len < skb->len)
-				pskb_trim(skb, real_len);
+			if (real_len < skb->len) {
+				err = pskb_trim(skb, real_len);
+				if (err)
+					return err;
+			}
 
 			hdr_len = skb_tcp_all_headers(skb);
 			if (unlikely(skb->len == hdr_len)) {
diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index c8444bcdf527..02aa6fd8ebc2 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -2113,8 +2113,11 @@ static int atl1_tso(struct atl1_adapter *adapter, struct sk_buff *skb,
 
 			real_len = (((unsigned char *)iph - skb->data) +
 				ntohs(iph->tot_len));
-			if (real_len < skb->len)
-				pskb_trim(skb, real_len);
+			if (real_len < skb->len) {
+				err = pskb_trim(skb, real_len);
+				if (err)
+					return err;
+			}
 			hdr_len = skb_tcp_all_headers(skb);
 			if (skb->len == hdr_len) {
 				iph->check = 0;
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 5d39df845265..b12152e2fca0 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1139,7 +1139,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 	    (lancer_chip(adapter) || BE3_chip(adapter) ||
 	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
 		ip = (struct iphdr *)ip_hdr(skb);
-		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
+		if (unlikely(pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len))))
+			goto tx_drop;
 	}
 
 	/* If vlan tag is already inlined in the packet, skip HW VLAN
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 17137de9338c..fcb8b6dc5ab9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -31,6 +31,7 @@
 #include <linux/pci.h>
 #include <linux/pkt_sched.h>
 #include <linux/types.h>
+#include <linux/bitmap.h>
 #include <net/pkt_cls.h>
 
 #define HNAE3_MOD_VERSION "1.0"
@@ -402,7 +403,7 @@ struct hnae3_ae_dev {
 	unsigned long hw_err_reset_req;
 	struct hnae3_dev_specs dev_specs;
 	u32 dev_version;
-	unsigned long caps[BITS_TO_LONGS(HNAE3_DEV_CAPS_MAX_NUM)];
+	DECLARE_BITMAP(caps, HNAE3_DEV_CAPS_MAX_NUM);
 	void *priv;
 };
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
index c797d54f98ca..2ccb0f546079 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
@@ -170,6 +170,20 @@ static const struct hclge_comm_caps_bit_map hclge_vf_cmd_caps[] = {
 	{HCLGE_COMM_CAP_GRO_B, HNAE3_DEV_SUPPORT_GRO_B},
 };
 
+static void
+hclge_comm_capability_to_bitmap(unsigned long *bitmap, __le32 *caps)
+{
+	const unsigned int words = HCLGE_COMM_QUERY_CAP_LENGTH;
+	u32 val[HCLGE_COMM_QUERY_CAP_LENGTH];
+	unsigned int i;
+
+	for (i = 0; i < words; i++)
+		val[i] = __le32_to_cpu(caps[i]);
+
+	bitmap_from_arr32(bitmap, val,
+			  HCLGE_COMM_QUERY_CAP_LENGTH * BITS_PER_TYPE(u32));
+}
+
 static void
 hclge_comm_parse_capability(struct hnae3_ae_dev *ae_dev, bool is_pf,
 			    struct hclge_comm_query_version_cmd *cmd)
@@ -178,11 +192,12 @@ hclge_comm_parse_capability(struct hnae3_ae_dev *ae_dev, bool is_pf,
 				is_pf ? hclge_pf_cmd_caps : hclge_vf_cmd_caps;
 	u32 size = is_pf ? ARRAY_SIZE(hclge_pf_cmd_caps) :
 				ARRAY_SIZE(hclge_vf_cmd_caps);
-	u32 caps, i;
+	DECLARE_BITMAP(caps, HCLGE_COMM_QUERY_CAP_LENGTH * BITS_PER_TYPE(u32));
+	u32 i;
 
-	caps = __le32_to_cpu(cmd->caps[0]);
+	hclge_comm_capability_to_bitmap(caps, cmd->caps);
 	for (i = 0; i < size; i++)
-		if (hnae3_get_bit(caps, caps_map[i].imp_bit))
+		if (test_bit(caps_map[i].imp_bit, caps))
 			set_bit(caps_map[i].local_bit, ae_dev->caps);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index c4aded65e848..09362823140d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -52,7 +52,10 @@ static void hclge_tm_info_to_ieee_ets(struct hclge_dev *hdev,
 
 	for (i = 0; i < HNAE3_MAX_TC; i++) {
 		ets->prio_tc[i] = hdev->tm_info.prio_tc[i];
-		ets->tc_tx_bw[i] = hdev->tm_info.pg_info[0].tc_dwrr[i];
+		if (i < hdev->tm_info.num_tc)
+			ets->tc_tx_bw[i] = hdev->tm_info.pg_info[0].tc_dwrr[i];
+		else
+			ets->tc_tx_bw[i] = 0;
 
 		if (hdev->tm_info.tc_info[i].tc_sch_mode ==
 		    HCLGE_SCH_MODE_SP)
@@ -123,7 +126,8 @@ static u8 hclge_ets_tc_changed(struct hclge_dev *hdev, struct ieee_ets *ets,
 }
 
 static int hclge_ets_sch_mode_validate(struct hclge_dev *hdev,
-				       struct ieee_ets *ets, bool *changed)
+				       struct ieee_ets *ets, bool *changed,
+				       u8 tc_num)
 {
 	bool has_ets_tc = false;
 	u32 total_ets_bw = 0;
@@ -137,6 +141,13 @@ static int hclge_ets_sch_mode_validate(struct hclge_dev *hdev,
 				*changed = true;
 			break;
 		case IEEE_8021QAZ_TSA_ETS:
+			if (i >= tc_num) {
+				dev_err(&hdev->pdev->dev,
+					"tc%u is disabled, cannot set ets bw\n",
+					i);
+				return -EINVAL;
+			}
+
 			/* The hardware will switch to sp mode if bandwidth is
 			 * 0, so limit ets bandwidth must be greater than 0.
 			 */
@@ -176,7 +187,7 @@ static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
 	if (ret)
 		return ret;
 
-	ret = hclge_ets_sch_mode_validate(hdev, ets, changed);
+	ret = hclge_ets_sch_mode_validate(hdev, ets, changed, tc_num);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 0ebc21401b7c..726062e51293 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -692,8 +692,7 @@ static int hclge_dbg_dump_tc(struct hclge_dev *hdev, char *buf, int len)
 	for (i = 0; i < HNAE3_MAX_TC; i++) {
 		sch_mode_str = ets_weight->tc_weight[i] ? "dwrr" : "sp";
 		pos += scnprintf(buf + pos, len - pos, "%u     %4s    %3u\n",
-				 i, sch_mode_str,
-				 hdev->tm_info.pg_info[0].tc_dwrr[i]);
+				 i, sch_mode_str, ets_weight->tc_weight[i]);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 922c0da3660c..150f146fa24f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -785,6 +785,7 @@ static void hclge_tm_tc_info_init(struct hclge_dev *hdev)
 static void hclge_tm_pg_info_init(struct hclge_dev *hdev)
 {
 #define BW_PERCENT	100
+#define DEFAULT_BW_WEIGHT	1
 
 	u8 i;
 
@@ -806,7 +807,7 @@ static void hclge_tm_pg_info_init(struct hclge_dev *hdev)
 		for (k = 0; k < hdev->tm_info.num_tc; k++)
 			hdev->tm_info.pg_info[i].tc_dwrr[k] = BW_PERCENT;
 		for (; k < HNAE3_MAX_TC; k++)
-			hdev->tm_info.pg_info[i].tc_dwrr[k] = 0;
+			hdev->tm_info.pg_info[i].tc_dwrr[k] = DEFAULT_BW_WEIGHT;
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 9954493cd448..62497f5565c5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1839,7 +1839,7 @@ void i40e_dbg_pf_exit(struct i40e_pf *pf)
 void i40e_dbg_init(void)
 {
 	i40e_dbg_root = debugfs_create_dir(i40e_driver_name, NULL);
-	if (!i40e_dbg_root)
+	if (IS_ERR(i40e_dbg_root))
 		pr_info("init of debugfs failed\n");
 }
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index c1f91c55e1ca..22bc57ee2422 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3286,9 +3286,6 @@ static void iavf_adminq_task(struct work_struct *work)
 	u32 val, oldval;
 	u16 pending;
 
-	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
-		goto out;
-
 	if (!mutex_trylock(&adapter->crit_lock)) {
 		if (adapter->state == __IAVF_REMOVE)
 			return;
@@ -3297,10 +3294,13 @@ static void iavf_adminq_task(struct work_struct *work)
 		goto out;
 	}
 
+	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
+		goto unlock;
+
 	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
 	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
 	if (!event.msg_buf)
-		goto out;
+		goto unlock;
 
 	do {
 		ret = iavf_clean_arq_element(hw, &event, &pending);
@@ -3315,7 +3315,6 @@ static void iavf_adminq_task(struct work_struct *work)
 		if (pending != 0)
 			memset(event.msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
 	} while (pending);
-	mutex_unlock(&adapter->crit_lock);
 
 	if (iavf_is_reset_in_progress(adapter))
 		goto freedom;
@@ -3359,6 +3358,8 @@ static void iavf_adminq_task(struct work_struct *work)
 
 freedom:
 	kfree(event.msg_buf);
+unlock:
+	mutex_unlock(&adapter->crit_lock);
 out:
 	/* re-enable Admin queue interrupt cause */
 	iavf_misc_irq_enable(adapter);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index ead6d50fc0ad..8c6e13f87b7d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -1281,16 +1281,21 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 				     ICE_FLOW_FLD_OFF_INVAL);
 	}
 
-	/* add filter for outer headers */
 	fltr_idx = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
+
+	assign_bit(fltr_idx, hw->fdir_perfect_fltr, perfect_filter);
+
+	/* add filter for outer headers */
 	ret = ice_fdir_set_hw_fltr_rule(pf, seg, fltr_idx,
 					ICE_FD_HW_SEG_NON_TUN);
-	if (ret == -EEXIST)
-		/* Rule already exists, free memory and continue */
-		devm_kfree(dev, seg);
-	else if (ret)
+	if (ret == -EEXIST) {
+		/* Rule already exists, free memory and count as success */
+		ret = 0;
+		goto err_exit;
+	} else if (ret) {
 		/* could not write filter, free memory */
 		goto err_exit;
+	}
 
 	/* make tunneled filter HW entries if possible */
 	memcpy(&tun_seg[1], seg, sizeof(*seg));
@@ -1305,18 +1310,13 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 		devm_kfree(dev, tun_seg);
 	}
 
-	if (perfect_filter)
-		set_bit(fltr_idx, hw->fdir_perfect_fltr);
-	else
-		clear_bit(fltr_idx, hw->fdir_perfect_fltr);
-
 	return ret;
 
 err_exit:
 	devm_kfree(dev, tun_seg);
 	devm_kfree(dev, seg);
 
-	return -EOPNOTSUPP;
+	return ret;
 }
 
 /**
@@ -1914,7 +1914,9 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	input->comp_report = ICE_FXD_FLTR_QW0_COMP_REPORT_SW_FAIL;
 
 	/* input struct is added to the HW filter list */
-	ice_fdir_update_list_entry(pf, input, fsp->location);
+	ret = ice_fdir_update_list_entry(pf, input, fsp->location);
+	if (ret)
+		goto release_lock;
 
 	ret = ice_fdir_write_all_fltr(pf, input, true);
 	if (ret)
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2e091a4a065e..d877dc0f87f7 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -317,6 +317,33 @@ static void igc_clean_all_tx_rings(struct igc_adapter *adapter)
 			igc_clean_tx_ring(adapter->tx_ring[i]);
 }
 
+static void igc_disable_tx_ring_hw(struct igc_ring *ring)
+{
+	struct igc_hw *hw = &ring->q_vector->adapter->hw;
+	u8 idx = ring->reg_idx;
+	u32 txdctl;
+
+	txdctl = rd32(IGC_TXDCTL(idx));
+	txdctl &= ~IGC_TXDCTL_QUEUE_ENABLE;
+	txdctl |= IGC_TXDCTL_SWFLUSH;
+	wr32(IGC_TXDCTL(idx), txdctl);
+}
+
+/**
+ * igc_disable_all_tx_rings_hw - Disable all transmit queue operation
+ * @adapter: board private structure
+ */
+static void igc_disable_all_tx_rings_hw(struct igc_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *tx_ring = adapter->tx_ring[i];
+
+		igc_disable_tx_ring_hw(tx_ring);
+	}
+}
+
 /**
  * igc_setup_tx_resources - allocate Tx resources (Descriptors)
  * @tx_ring: tx descriptor ring (for a specific queue) to setup
@@ -5026,6 +5053,7 @@ void igc_down(struct igc_adapter *adapter)
 	/* clear VLAN promisc flag so VFTA will be updated if necessary */
 	adapter->flags &= ~IGC_FLAG_VLAN_PROMISC;
 
+	igc_disable_all_tx_rings_hw(adapter);
 	igc_clean_all_tx_rings(adapter);
 	igc_clean_all_rx_rings(adapter);
 }
@@ -7124,18 +7152,6 @@ void igc_enable_rx_ring(struct igc_ring *ring)
 		igc_alloc_rx_buffers(ring, igc_desc_unused(ring));
 }
 
-static void igc_disable_tx_ring_hw(struct igc_ring *ring)
-{
-	struct igc_hw *hw = &ring->q_vector->adapter->hw;
-	u8 idx = ring->reg_idx;
-	u32 txdctl;
-
-	txdctl = rd32(IGC_TXDCTL(idx));
-	txdctl &= ~IGC_TXDCTL_QUEUE_ENABLE;
-	txdctl |= IGC_TXDCTL_SWFLUSH;
-	wr32(IGC_TXDCTL(idx), txdctl);
-}
-
 void igc_disable_tx_ring(struct igc_ring *ring)
 {
 	igc_disable_tx_ring_hw(ring);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9b8848daeb43..6105419ae2d5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8499,7 +8499,7 @@ static void ixgbe_atr(struct ixgbe_ring *ring,
 		struct ixgbe_adapter *adapter = q_vector->adapter;
 
 		if (unlikely(skb_tail_pointer(skb) < hdr.network +
-			     VXLAN_HEADROOM))
+			     vxlan_headroom(0)))
 			return;
 
 		/* verify the port is recognized as VXLAN */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 3b0a66c0977a..34fa59575fa9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -203,10 +203,8 @@ void npc_config_secret_key(struct rvu *rvu, int blkaddr)
 	struct rvu_hwinfo *hw = rvu->hw;
 	u8 intf;
 
-	if (!hwcap->npc_hash_extract) {
-		dev_info(rvu->dev, "HW does not support secret key configuration\n");
+	if (!hwcap->npc_hash_extract)
 		return;
-	}
 
 	for (intf = 0; intf < hw->npc_intfs; intf++) {
 		rvu_write64(rvu, blkaddr, NPC_AF_INTFX_SECRET_KEY0(intf),
@@ -220,15 +218,54 @@ void npc_config_secret_key(struct rvu *rvu, int blkaddr)
 
 void npc_program_mkex_hash(struct rvu *rvu, int blkaddr)
 {
+	struct npc_mcam_kex_hash *mh = rvu->kpu.mkex_hash;
 	struct hw_cap *hwcap = &rvu->hw->cap;
+	u8 intf, ld, hdr_offset, byte_len;
 	struct rvu_hwinfo *hw = rvu->hw;
-	u8 intf;
+	u64 cfg;
 
-	if (!hwcap->npc_hash_extract) {
-		dev_dbg(rvu->dev, "Field hash extract feature is not supported\n");
+	/* Check if hardware supports hash extraction */
+	if (!hwcap->npc_hash_extract)
 		return;
+
+	/* Check if IPv6 source/destination address
+	 * should be hash enabled.
+	 * Hashing reduces 128bit SIP/DIP fields to 32bit
+	 * so that 224 bit X2 key can be used for IPv6 based filters as well,
+	 * which in turn results in more number of MCAM entries available for
+	 * use.
+	 *
+	 * Hashing of IPV6 SIP/DIP is enabled in below scenarios
+	 * 1. If the silicon variant supports hashing feature
+	 * 2. If the number of bytes of IP addr being extracted is 4 bytes ie
+	 *    32bit. The assumption here is that if user wants 8bytes of LSB of
+	 *    IP addr or full 16 bytes then his intention is not to use 32bit
+	 *    hash.
+	 */
+	for (intf = 0; intf < hw->npc_intfs; intf++) {
+		for (ld = 0; ld < NPC_MAX_LD; ld++) {
+			cfg = rvu_read64(rvu, blkaddr,
+					 NPC_AF_INTFX_LIDX_LTX_LDX_CFG(intf,
+								       NPC_LID_LC,
+								       NPC_LT_LC_IP6,
+								       ld));
+			hdr_offset = FIELD_GET(NPC_HDR_OFFSET, cfg);
+			byte_len = FIELD_GET(NPC_BYTESM, cfg);
+			/* Hashing of IPv6 source/destination address should be
+			 * enabled if,
+			 * hdr_offset == 8 (offset of source IPv6 address) or
+			 * hdr_offset == 24 (offset of destination IPv6)
+			 * address) and the number of byte to be
+			 * extracted is 4. As per hardware configuration
+			 * byte_len should be == actual byte_len - 1.
+			 * Hence byte_len is checked against 3 but nor 4.
+			 */
+			if ((hdr_offset == 8 || hdr_offset == 24) && byte_len == 3)
+				mh->lid_lt_ld_hash_en[intf][NPC_LID_LC][NPC_LT_LC_IP6][ld] = true;
+		}
 	}
 
+	/* Update hash configuration if the field is hash enabled */
 	for (intf = 0; intf < hw->npc_intfs; intf++) {
 		npc_program_mkex_hash_rx(rvu, blkaddr, intf);
 		npc_program_mkex_hash_tx(rvu, blkaddr, intf);
@@ -1864,19 +1901,13 @@ int rvu_npc_exact_init(struct rvu *rvu)
 
 	/* Check exact match feature is supported */
 	npc_const3 = rvu_read64(rvu, blkaddr, NPC_AF_CONST3);
-	if (!(npc_const3 & BIT_ULL(62))) {
-		dev_info(rvu->dev, "%s: No support for exact match support\n",
-			 __func__);
+	if (!(npc_const3 & BIT_ULL(62)))
 		return 0;
-	}
 
 	/* Check if kex profile has enabled EXACT match nibble */
 	cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(NIX_INTF_RX));
-	if (!(cfg & NPC_EXACT_NIBBLE_HIT)) {
-		dev_info(rvu->dev, "%s: NPC exact match nibble not enabled in KEX profile\n",
-			 __func__);
+	if (!(cfg & NPC_EXACT_NIBBLE_HIT))
 		return 0;
-	}
 
 	/* Set capability to true */
 	rvu->hw->cap.npc_exact_match_enabled = true;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
index a1c3d987b804..57a09328d46b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
@@ -70,8 +70,8 @@ static struct npc_mcam_kex_hash npc_mkex_hash_default __maybe_unused = {
 	[NIX_INTF_RX] = {
 		[NPC_LID_LC] = {
 			[NPC_LT_LC_IP6] = {
-				true,
-				true,
+				false,
+				false,
 			},
 		},
 	},
@@ -79,8 +79,8 @@ static struct npc_mcam_kex_hash npc_mkex_hash_default __maybe_unused = {
 	[NIX_INTF_TX] = {
 		[NPC_LID_LC] = {
 			[NPC_LT_LC_IP6] = {
-				true,
-				true,
+				false,
+				false,
 			},
 		},
 	},
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index d1c605777985..7c26394f665e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -207,13 +207,15 @@ void stmmac_dwmac4_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
 void stmmac_dwmac4_set_mac(void __iomem *ioaddr, bool enable)
 {
 	u32 value = readl(ioaddr + GMAC_CONFIG);
+	u32 old_val = value;
 
 	if (enable)
 		value |= GMAC_CONFIG_RE | GMAC_CONFIG_TE;
 	else
 		value &= ~(GMAC_CONFIG_TE | GMAC_CONFIG_RE);
 
-	writel(value, ioaddr + GMAC_CONFIG);
+	if (value != old_val)
+		writel(value, ioaddr + GMAC_CONFIG);
 }
 
 void stmmac_dwmac4_get_mac_addr(void __iomem *ioaddr, unsigned char *addr,
diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 383a9c9f36e5..057d294a273d 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -328,6 +328,13 @@ static int mv3310_power_up(struct phy_device *phydev)
 	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, MV_V2_PORT_CTRL,
 				 MV_V2_PORT_CTRL_PWRDOWN);
 
+	/* Sometimes, the power down bit doesn't clear immediately, and
+	 * a read of this register causes the bit not to clear. Delay
+	 * 100us to allow the PHY to come out of power down mode before
+	 * the next access.
+	 */
+	udelay(100);
+
 	if (phydev->drv->phy_id != MARVELL_PHY_ID_88X3310 ||
 	    priv->firmware_ver < 0x00030000)
 		return ret;
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index b524bd374d68..509ba706781e 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2135,6 +2135,15 @@ static void team_setup_by_port(struct net_device *dev,
 	dev->mtu = port_dev->mtu;
 	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
 	eth_hw_addr_inherit(dev, port_dev);
+
+	if (port_dev->flags & IFF_POINTOPOINT) {
+		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	} else if ((port_dev->flags & (IFF_BROADCAST | IFF_MULTICAST)) ==
+		    (IFF_BROADCAST | IFF_MULTICAST)) {
+		dev->flags |= (IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags &= ~(IFF_POINTOPOINT | IFF_NOARP);
+	}
 }
 
 static int team_dev_type_check_change(struct net_device *dev,
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fae302c5b0a9..075d5d42f5eb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3940,6 +3940,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
+	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -3960,8 +3962,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_unregister_netdev;
 	}
 
-	virtnet_set_queues(vi, vi->curr_queue_pairs);
-
 	/* Assume link up if device can't report link status,
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d4be39b19a6b..0c3eb850fcb7 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -670,6 +670,32 @@ static int vxlan_fdb_append(struct vxlan_fdb *f,
 	return 1;
 }
 
+static bool vxlan_parse_gpe_proto(struct vxlanhdr *hdr, __be16 *protocol)
+{
+	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)hdr;
+
+	/* Need to have Next Protocol set for interfaces in GPE mode. */
+	if (!gpe->np_applied)
+		return false;
+	/* "The initial version is 0. If a receiver does not support the
+	 * version indicated it MUST drop the packet.
+	 */
+	if (gpe->version != 0)
+		return false;
+	/* "When the O bit is set to 1, the packet is an OAM packet and OAM
+	 * processing MUST occur." However, we don't implement OAM
+	 * processing, thus drop the packet.
+	 */
+	if (gpe->oam_flag)
+		return false;
+
+	*protocol = tun_p_to_eth_p(gpe->next_protocol);
+	if (!*protocol)
+		return false;
+
+	return true;
+}
+
 static struct vxlanhdr *vxlan_gro_remcsum(struct sk_buff *skb,
 					  unsigned int off,
 					  struct vxlanhdr *vh, size_t hdrlen,
@@ -696,26 +722,24 @@ static struct vxlanhdr *vxlan_gro_remcsum(struct sk_buff *skb,
 	return vh;
 }
 
-static struct sk_buff *vxlan_gro_receive(struct sock *sk,
-					 struct list_head *head,
-					 struct sk_buff *skb)
+static struct vxlanhdr *vxlan_gro_prepare_receive(struct sock *sk,
+						  struct list_head *head,
+						  struct sk_buff *skb,
+						  struct gro_remcsum *grc)
 {
-	struct sk_buff *pp = NULL;
 	struct sk_buff *p;
 	struct vxlanhdr *vh, *vh2;
 	unsigned int hlen, off_vx;
-	int flush = 1;
 	struct vxlan_sock *vs = rcu_dereference_sk_user_data(sk);
 	__be32 flags;
-	struct gro_remcsum grc;
 
-	skb_gro_remcsum_init(&grc);
+	skb_gro_remcsum_init(grc);
 
 	off_vx = skb_gro_offset(skb);
 	hlen = off_vx + sizeof(*vh);
 	vh = skb_gro_header(skb, hlen, off_vx);
 	if (unlikely(!vh))
-		goto out;
+		return NULL;
 
 	skb_gro_postpull_rcsum(skb, vh, sizeof(struct vxlanhdr));
 
@@ -723,12 +747,12 @@ static struct sk_buff *vxlan_gro_receive(struct sock *sk,
 
 	if ((flags & VXLAN_HF_RCO) && (vs->flags & VXLAN_F_REMCSUM_RX)) {
 		vh = vxlan_gro_remcsum(skb, off_vx, vh, sizeof(struct vxlanhdr),
-				       vh->vx_vni, &grc,
+				       vh->vx_vni, grc,
 				       !!(vs->flags &
 					  VXLAN_F_REMCSUM_NOPARTIAL));
 
 		if (!vh)
-			goto out;
+			return NULL;
 	}
 
 	skb_gro_pull(skb, sizeof(struct vxlanhdr)); /* pull vxlan header */
@@ -745,12 +769,48 @@ static struct sk_buff *vxlan_gro_receive(struct sock *sk,
 		}
 	}
 
-	pp = call_gro_receive(eth_gro_receive, head, skb);
-	flush = 0;
+	return vh;
+}
 
-out:
+static struct sk_buff *vxlan_gro_receive(struct sock *sk,
+					 struct list_head *head,
+					 struct sk_buff *skb)
+{
+	struct sk_buff *pp = NULL;
+	struct gro_remcsum grc;
+	int flush = 1;
+
+	if (vxlan_gro_prepare_receive(sk, head, skb, &grc)) {
+		pp = call_gro_receive(eth_gro_receive, head, skb);
+		flush = 0;
+	}
 	skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
+	return pp;
+}
+
+static struct sk_buff *vxlan_gpe_gro_receive(struct sock *sk,
+					     struct list_head *head,
+					     struct sk_buff *skb)
+{
+	const struct packet_offload *ptype;
+	struct sk_buff *pp = NULL;
+	struct gro_remcsum grc;
+	struct vxlanhdr *vh;
+	__be16 protocol;
+	int flush = 1;
 
+	vh = vxlan_gro_prepare_receive(sk, head, skb, &grc);
+	if (vh) {
+		if (!vxlan_parse_gpe_proto(vh, &protocol))
+			goto out;
+		ptype = gro_find_receive_by_type(protocol);
+		if (!ptype)
+			goto out;
+		pp = call_gro_receive(ptype->callbacks.gro_receive, head, skb);
+		flush = 0;
+	}
+out:
+	skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
 	return pp;
 }
 
@@ -762,6 +822,21 @@ static int vxlan_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
 	return eth_gro_complete(skb, nhoff + sizeof(struct vxlanhdr));
 }
 
+static int vxlan_gpe_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
+{
+	struct vxlanhdr *vh = (struct vxlanhdr *)(skb->data + nhoff);
+	const struct packet_offload *ptype;
+	int err = -ENOSYS;
+	__be16 protocol;
+
+	if (!vxlan_parse_gpe_proto(vh, &protocol))
+		return err;
+	ptype = gro_find_complete_by_type(protocol);
+	if (ptype)
+		err = ptype->callbacks.gro_complete(skb, nhoff + sizeof(struct vxlanhdr));
+	return err;
+}
+
 static struct vxlan_fdb *vxlan_fdb_alloc(struct vxlan_dev *vxlan, const u8 *mac,
 					 __u16 state, __be32 src_vni,
 					 __u16 ndm_flags)
@@ -1572,35 +1647,6 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
 	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
 }
 
-static bool vxlan_parse_gpe_hdr(struct vxlanhdr *unparsed,
-				__be16 *protocol,
-				struct sk_buff *skb, u32 vxflags)
-{
-	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)unparsed;
-
-	/* Need to have Next Protocol set for interfaces in GPE mode. */
-	if (!gpe->np_applied)
-		return false;
-	/* "The initial version is 0. If a receiver does not support the
-	 * version indicated it MUST drop the packet.
-	 */
-	if (gpe->version != 0)
-		return false;
-	/* "When the O bit is set to 1, the packet is an OAM packet and OAM
-	 * processing MUST occur." However, we don't implement OAM
-	 * processing, thus drop the packet.
-	 */
-	if (gpe->oam_flag)
-		return false;
-
-	*protocol = tun_p_to_eth_p(gpe->next_protocol);
-	if (!*protocol)
-		return false;
-
-	unparsed->vx_flags &= ~VXLAN_GPE_USED_BITS;
-	return true;
-}
-
 static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 			  struct vxlan_sock *vs,
 			  struct sk_buff *skb, __be32 vni)
@@ -1702,8 +1748,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	 * used by VXLAN extensions if explicitly requested.
 	 */
 	if (vs->flags & VXLAN_F_GPE) {
-		if (!vxlan_parse_gpe_hdr(&unparsed, &protocol, skb, vs->flags))
+		if (!vxlan_parse_gpe_proto(&unparsed, &protocol))
 			goto drop;
+		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
 		raw_proto = true;
 	}
 
@@ -2584,7 +2631,7 @@ static void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		ndst = &rt->dst;
-		err = skb_tunnel_check_pmtu(skb, ndst, VXLAN_HEADROOM,
+		err = skb_tunnel_check_pmtu(skb, ndst, vxlan_headroom(flags & VXLAN_F_GPE),
 					    netif_is_any_bridge_port(dev));
 		if (err < 0) {
 			goto tx_error;
@@ -2645,7 +2692,8 @@ static void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				goto out_unlock;
 		}
 
-		err = skb_tunnel_check_pmtu(skb, ndst, VXLAN6_HEADROOM,
+		err = skb_tunnel_check_pmtu(skb, ndst,
+					    vxlan_headroom((flags & VXLAN_F_GPE) | VXLAN_F_IPV6),
 					    netif_is_any_bridge_port(dev));
 		if (err < 0) {
 			goto tx_error;
@@ -3034,14 +3082,12 @@ static int vxlan_change_mtu(struct net_device *dev, int new_mtu)
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
 							 dst->remote_ifindex);
-	bool use_ipv6 = !!(vxlan->cfg.flags & VXLAN_F_IPV6);
 
 	/* This check is different than dev->max_mtu, because it looks at
 	 * the lowerdev->mtu, rather than the static dev->max_mtu
 	 */
 	if (lowerdev) {
-		int max_mtu = lowerdev->mtu -
-			      (use_ipv6 ? VXLAN6_HEADROOM : VXLAN_HEADROOM);
+		int max_mtu = lowerdev->mtu - vxlan_headroom(vxlan->cfg.flags);
 		if (new_mtu > max_mtu)
 			return -EINVAL;
 	}
@@ -3419,8 +3465,13 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 	tunnel_cfg.encap_rcv = vxlan_rcv;
 	tunnel_cfg.encap_err_lookup = vxlan_err_lookup;
 	tunnel_cfg.encap_destroy = NULL;
-	tunnel_cfg.gro_receive = vxlan_gro_receive;
-	tunnel_cfg.gro_complete = vxlan_gro_complete;
+	if (vs->flags & VXLAN_F_GPE) {
+		tunnel_cfg.gro_receive = vxlan_gpe_gro_receive;
+		tunnel_cfg.gro_complete = vxlan_gpe_gro_complete;
+	} else {
+		tunnel_cfg.gro_receive = vxlan_gro_receive;
+		tunnel_cfg.gro_complete = vxlan_gro_complete;
+	}
 
 	setup_udp_tunnel_sock(net, sock, &tunnel_cfg);
 
@@ -3684,11 +3735,11 @@ static void vxlan_config_apply(struct net_device *dev,
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 	unsigned short needed_headroom = ETH_HLEN;
-	bool use_ipv6 = !!(conf->flags & VXLAN_F_IPV6);
 	int max_mtu = ETH_MAX_MTU;
+	u32 flags = conf->flags;
 
 	if (!changelink) {
-		if (conf->flags & VXLAN_F_GPE)
+		if (flags & VXLAN_F_GPE)
 			vxlan_raw_setup(dev);
 		else
 			vxlan_ether_setup(dev);
@@ -3713,8 +3764,7 @@ static void vxlan_config_apply(struct net_device *dev,
 
 		dev->needed_tailroom = lowerdev->needed_tailroom;
 
-		max_mtu = lowerdev->mtu - (use_ipv6 ? VXLAN6_HEADROOM :
-					   VXLAN_HEADROOM);
+		max_mtu = lowerdev->mtu - vxlan_headroom(flags);
 		if (max_mtu < ETH_MIN_MTU)
 			max_mtu = ETH_MIN_MTU;
 
@@ -3725,10 +3775,9 @@ static void vxlan_config_apply(struct net_device *dev,
 	if (dev->mtu > max_mtu)
 		dev->mtu = max_mtu;
 
-	if (use_ipv6 || conf->flags & VXLAN_F_COLLECT_METADATA)
-		needed_headroom += VXLAN6_HEADROOM;
-	else
-		needed_headroom += VXLAN_HEADROOM;
+	if (flags & VXLAN_F_COLLECT_METADATA)
+		flags |= VXLAN_F_IPV6;
+	needed_headroom += vxlan_headroom(flags);
 	dev->needed_headroom = needed_headroom;
 
 	memcpy(&vxlan->cfg, conf, sizeof(*conf));
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 827d91e73efa..0af0e965fb57 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -61,65 +61,32 @@ static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
 			    ROCKCHIP_PCIE_AT_OB_REGION_DESC0(region));
 	rockchip_pcie_write(rockchip, 0,
 			    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(region));
-	rockchip_pcie_write(rockchip, 0,
-			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR0(region));
-	rockchip_pcie_write(rockchip, 0,
-			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(region));
 }
 
 static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
-					 u32 r, u32 type, u64 cpu_addr,
-					 u64 pci_addr, size_t size)
+					 u32 r, u64 cpu_addr, u64 pci_addr,
+					 size_t size)
 {
-	u64 sz = 1ULL << fls64(size - 1);
-	int num_pass_bits = ilog2(sz);
-	u32 addr0, addr1, desc0, desc1;
-	bool is_nor_msg = (type == AXI_WRAPPER_NOR_MSG);
+	int num_pass_bits = fls64(size - 1);
+	u32 addr0, addr1, desc0;
 
-	/* The minimal region size is 1MB */
 	if (num_pass_bits < 8)
 		num_pass_bits = 8;
 
-	cpu_addr -= rockchip->mem_res->start;
-	addr0 = ((is_nor_msg ? 0x10 : (num_pass_bits - 1)) &
-		PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
-		(lower_32_bits(cpu_addr) & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
-	addr1 = upper_32_bits(is_nor_msg ? cpu_addr : pci_addr);
-	desc0 = ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN(fn) | type;
-	desc1 = 0;
-
-	if (is_nor_msg) {
-		rockchip_pcie_write(rockchip, 0,
-				    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r));
-		rockchip_pcie_write(rockchip, 0,
-				    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r));
-		rockchip_pcie_write(rockchip, desc0,
-				    ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r));
-		rockchip_pcie_write(rockchip, desc1,
-				    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r));
-	} else {
-		/* PCI bus address region */
-		rockchip_pcie_write(rockchip, addr0,
-				    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r));
-		rockchip_pcie_write(rockchip, addr1,
-				    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r));
-		rockchip_pcie_write(rockchip, desc0,
-				    ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r));
-		rockchip_pcie_write(rockchip, desc1,
-				    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r));
-
-		addr0 =
-		    ((num_pass_bits - 1) & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
-		    (lower_32_bits(cpu_addr) &
-		     PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
-		addr1 = upper_32_bits(cpu_addr);
-	}
+	addr0 = ((num_pass_bits - 1) & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
+		(lower_32_bits(pci_addr) & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
+	addr1 = upper_32_bits(pci_addr);
+	desc0 = ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN(fn) | AXI_WRAPPER_MEM_WRITE;
 
-	/* CPU bus address region */
+	/* PCI bus address region */
 	rockchip_pcie_write(rockchip, addr0,
-			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR0(r));
+			    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r));
 	rockchip_pcie_write(rockchip, addr1,
-			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(r));
+			    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r));
+	rockchip_pcie_write(rockchip, desc0,
+			    ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r));
+	rockchip_pcie_write(rockchip, 0,
+			    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r));
 }
 
 static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
@@ -258,26 +225,20 @@ static void rockchip_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 			    ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar));
 }
 
+static inline u32 rockchip_ob_region(phys_addr_t addr)
+{
+	return (addr >> ilog2(SZ_1M)) & 0x1f;
+}
+
 static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 				     phys_addr_t addr, u64 pci_addr,
 				     size_t size)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *pcie = &ep->rockchip;
-	u32 r;
-
-	r = find_first_zero_bit(&ep->ob_region_map, BITS_PER_LONG);
-	/*
-	 * Region 0 is reserved for configuration space and shouldn't
-	 * be used elsewhere per TRM, so leave it out.
-	 */
-	if (r >= ep->max_regions - 1) {
-		dev_err(&epc->dev, "no free outbound region\n");
-		return -EINVAL;
-	}
+	u32 r = rockchip_ob_region(addr);
 
-	rockchip_pcie_prog_ep_ob_atu(pcie, fn, r, AXI_WRAPPER_MEM_WRITE, addr,
-				     pci_addr, size);
+	rockchip_pcie_prog_ep_ob_atu(pcie, fn, r, addr, pci_addr, size);
 
 	set_bit(r, &ep->ob_region_map);
 	ep->ob_addr[r] = addr;
@@ -292,15 +253,11 @@ static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 	u32 r;
 
-	for (r = 0; r < ep->max_regions - 1; r++)
+	for (r = 0; r < ep->max_regions; r++)
 		if (ep->ob_addr[r] == addr)
 			break;
 
-	/*
-	 * Region 0 is reserved for configuration space and shouldn't
-	 * be used elsewhere per TRM, so leave it out.
-	 */
-	if (r == ep->max_regions - 1)
+	if (r == ep->max_regions)
 		return;
 
 	rockchip_pcie_clear_ep_ob_atu(rockchip, r);
@@ -397,7 +354,8 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 	u32 flags, mme, data, data_mask;
 	u8 msi_count;
-	u64 pci_addr, pci_addr_mask = 0xff;
+	u64 pci_addr;
+	u32 r;
 
 	/* Check MSI enable bit */
 	flags = rockchip_pcie_read(&ep->rockchip,
@@ -431,21 +389,20 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 				       ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
 				       ROCKCHIP_PCIE_EP_MSI_CTRL_REG +
 				       PCI_MSI_ADDRESS_LO);
-	pci_addr &= GENMASK_ULL(63, 2);
 
 	/* Set the outbound region if needed. */
-	if (unlikely(ep->irq_pci_addr != (pci_addr & ~pci_addr_mask) ||
+	if (unlikely(ep->irq_pci_addr != (pci_addr & PCIE_ADDR_MASK) ||
 		     ep->irq_pci_fn != fn)) {
-		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, ep->max_regions - 1,
-					     AXI_WRAPPER_MEM_WRITE,
+		r = rockchip_ob_region(ep->irq_phys_addr);
+		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
 					     ep->irq_phys_addr,
-					     pci_addr & ~pci_addr_mask,
-					     pci_addr_mask + 1);
-		ep->irq_pci_addr = (pci_addr & ~pci_addr_mask);
+					     pci_addr & PCIE_ADDR_MASK,
+					     ~PCIE_ADDR_MASK + 1);
+		ep->irq_pci_addr = (pci_addr & PCIE_ADDR_MASK);
 		ep->irq_pci_fn = fn;
 	}
 
-	writew(data, ep->irq_cpu_addr + (pci_addr & pci_addr_mask));
+	writew(data, ep->irq_cpu_addr + (pci_addr & ~PCIE_ADDR_MASK));
 	return 0;
 }
 
@@ -527,6 +484,8 @@ static int rockchip_pcie_parse_ep_dt(struct rockchip_pcie *rockchip,
 	if (err < 0 || ep->max_regions > MAX_REGION_LIMIT)
 		ep->max_regions = MAX_REGION_LIMIT;
 
+	ep->ob_region_map = 0;
+
 	err = of_property_read_u8(dev->of_node, "max-functions",
 				  &ep->epc->max_functions);
 	if (err < 0)
@@ -547,7 +506,9 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	struct rockchip_pcie *rockchip;
 	struct pci_epc *epc;
 	size_t max_regions;
-	int err;
+	struct pci_epc_mem_window *windows = NULL;
+	int err, i;
+	u32 cfg_msi, cfg_msix_cp;
 
 	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
 	if (!ep)
@@ -594,15 +555,27 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	/* Only enable function 0 by default */
 	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
 
-	err = pci_epc_mem_init(epc, rockchip->mem_res->start,
-			       resource_size(rockchip->mem_res), PAGE_SIZE);
+	windows = devm_kcalloc(dev, ep->max_regions,
+			       sizeof(struct pci_epc_mem_window), GFP_KERNEL);
+	if (!windows) {
+		err = -ENOMEM;
+		goto err_uninit_port;
+	}
+	for (i = 0; i < ep->max_regions; i++) {
+		windows[i].phys_base = rockchip->mem_res->start + (SZ_1M * i);
+		windows[i].size = SZ_1M;
+		windows[i].page_size = SZ_1M;
+	}
+	err = pci_epc_multi_mem_init(epc, windows, ep->max_regions);
+	devm_kfree(dev, windows);
+
 	if (err < 0) {
 		dev_err(dev, "failed to initialize the memory space\n");
 		goto err_uninit_port;
 	}
 
 	ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
-						  SZ_128K);
+						  SZ_1M);
 	if (!ep->irq_cpu_addr) {
 		dev_err(dev, "failed to reserve memory space for MSI\n");
 		err = -ENOMEM;
@@ -611,6 +584,29 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 
 	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
 
+	/*
+	 * MSI-X is not supported but the controller still advertises the MSI-X
+	 * capability by default, which can lead to the Root Complex side
+	 * allocating MSI-X vectors which cannot be used. Avoid this by skipping
+	 * the MSI-X capability entry in the PCIe capabilities linked-list: get
+	 * the next pointer from the MSI-X entry and set that in the MSI
+	 * capability entry (which is the previous entry). This way the MSI-X
+	 * entry is skipped (left out of the linked-list) and not advertised.
+	 */
+	cfg_msi = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
+				     ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
+
+	cfg_msi &= ~ROCKCHIP_PCIE_EP_MSI_CP1_MASK;
+
+	cfg_msix_cp = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
+					 ROCKCHIP_PCIE_EP_MSIX_CAP_REG) &
+					 ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK;
+
+	cfg_msi |= cfg_msix_cp;
+
+	rockchip_pcie_write(rockchip, cfg_msi,
+			    PCIE_EP_CONFIG_BASE + ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
+
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 8e92dc3339ec..fe0333778fd9 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -139,6 +139,7 @@
 
 #define PCIE_RC_RP_ATS_BASE		0x400000
 #define PCIE_RC_CONFIG_NORMAL_BASE	0x800000
+#define PCIE_EP_PF_CONFIG_REGS_BASE	0x800000
 #define PCIE_RC_CONFIG_BASE		0xa00000
 #define PCIE_EP_CONFIG_BASE		0xa00000
 #define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
@@ -157,10 +158,11 @@
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
 
+#define PCIE_ADDR_MASK			0xffffff00
 #define PCIE_CORE_AXI_CONF_BASE		0xc00000
 #define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
 #define   PCIE_CORE_OB_REGION_ADDR0_NUM_BITS	0x3f
-#define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR	0xffffff00
+#define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR	PCIE_ADDR_MASK
 #define PCIE_CORE_OB_REGION_ADDR1	(PCIE_CORE_AXI_CONF_BASE + 0x4)
 #define PCIE_CORE_OB_REGION_DESC0	(PCIE_CORE_AXI_CONF_BASE + 0x8)
 #define PCIE_CORE_OB_REGION_DESC1	(PCIE_CORE_AXI_CONF_BASE + 0xc)
@@ -168,7 +170,7 @@
 #define PCIE_CORE_AXI_INBOUND_BASE	0xc00800
 #define PCIE_RP_IB_ADDR0		(PCIE_CORE_AXI_INBOUND_BASE + 0x0)
 #define   PCIE_CORE_IB_REGION_ADDR0_NUM_BITS	0x3f
-#define   PCIE_CORE_IB_REGION_ADDR0_LO_ADDR	0xffffff00
+#define   PCIE_CORE_IB_REGION_ADDR0_LO_ADDR	PCIE_ADDR_MASK
 #define PCIE_RP_IB_ADDR1		(PCIE_CORE_AXI_INBOUND_BASE + 0x4)
 
 /* Size of one AXI Region (not Region 0) */
@@ -225,6 +227,8 @@
 #define ROCKCHIP_PCIE_EP_CMD_STATUS			0x4
 #define   ROCKCHIP_PCIE_EP_CMD_STATUS_IS		BIT(19)
 #define ROCKCHIP_PCIE_EP_MSI_CTRL_REG			0x90
+#define   ROCKCHIP_PCIE_EP_MSI_CP1_OFFSET		8
+#define   ROCKCHIP_PCIE_EP_MSI_CP1_MASK			GENMASK(15, 8)
 #define   ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET		16
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET		17
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK		GENMASK(19, 17)
@@ -232,14 +236,19 @@
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK		GENMASK(22, 20)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME				BIT(16)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP	BIT(24)
+#define ROCKCHIP_PCIE_EP_MSIX_CAP_REG			0xb0
+#define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_OFFSET		8
+#define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK		GENMASK(15, 8)
 #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR				0x1
-#define ROCKCHIP_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
+#define ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR		0x3
+#define ROCKCHIP_PCIE_EP_FUNC_BASE(fn) \
+	(PCIE_EP_PF_CONFIG_REGS_BASE + (((fn) << 12) & GENMASK(19, 12)))
+#define ROCKCHIP_PCIE_EP_VIRT_FUNC_BASE(fn) \
+	(PCIE_EP_PF_CONFIG_REGS_BASE + 0x10000 + (((fn) << 12) & GENMASK(19, 12)))
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
-	(PCIE_RC_RP_ATS_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
+	(PCIE_CORE_AXI_CONF_BASE + 0x0828 + (fn) * 0x0040 + (bar) * 0x0008)
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
-	(PCIE_RC_RP_ATS_BASE + 0x0844 + (fn) * 0x0040 + (bar) * 0x0008)
-#define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r) \
-	(PCIE_RC_RP_ATS_BASE + 0x0000 + ((r) & 0x1f) * 0x0020)
+	(PCIE_CORE_AXI_CONF_BASE + 0x082c + (fn) * 0x0040 + (bar) * 0x0008)
 #define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK	GENMASK(19, 12)
 #define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
 	(((devfn) << 12) & \
@@ -247,20 +256,21 @@
 #define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK	GENMASK(27, 20)
 #define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
 		(((bus) << 20) & ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK)
+#define PCIE_RC_EP_ATR_OB_REGIONS_1_32 (PCIE_CORE_AXI_CONF_BASE + 0x0020)
+#define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r) \
+		(PCIE_RC_EP_ATR_OB_REGIONS_1_32 + 0x0000 + ((r) & 0x1f) * 0x0020)
 #define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r) \
-		(PCIE_RC_RP_ATS_BASE + 0x0004 + ((r) & 0x1f) * 0x0020)
+		(PCIE_RC_EP_ATR_OB_REGIONS_1_32 + 0x0004 + ((r) & 0x1f) * 0x0020)
 #define ROCKCHIP_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID	BIT(23)
 #define ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK	GENMASK(31, 24)
 #define ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN(devfn) \
 		(((devfn) << 24) & ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK)
 #define ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r) \
-		(PCIE_RC_RP_ATS_BASE + 0x0008 + ((r) & 0x1f) * 0x0020)
-#define ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r)	\
-		(PCIE_RC_RP_ATS_BASE + 0x000c + ((r) & 0x1f) * 0x0020)
-#define ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR0(r) \
-		(PCIE_RC_RP_ATS_BASE + 0x0018 + ((r) & 0x1f) * 0x0020)
-#define ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(r) \
-		(PCIE_RC_RP_ATS_BASE + 0x001c + ((r) & 0x1f) * 0x0020)
+		(PCIE_RC_EP_ATR_OB_REGIONS_1_32 + 0x0008 + ((r) & 0x1f) * 0x0020)
+#define ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r) \
+		(PCIE_RC_EP_ATR_OB_REGIONS_1_32 + 0x000c + ((r) & 0x1f) * 0x0020)
+#define ROCKCHIP_PCIE_AT_OB_REGION_DESC2(r) \
+		(PCIE_RC_EP_ATR_OB_REGIONS_1_32 + 0x0010 + ((r) & 0x1f) * 0x0020)
 
 #define ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG0(fn) \
 		(PCIE_CORE_CTRL_MGMT_BASE + 0x0240 + (fn) * 0x0008)
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 74b8183c305d..07166a4ec27a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -193,12 +193,39 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
-static bool pcie_retrain_link(struct pcie_link_state *link)
+static int pcie_wait_for_retrain(struct pci_dev *pdev)
 {
-	struct pci_dev *parent = link->pdev;
 	unsigned long end_jiffies;
 	u16 reg16;
 
+	/* Wait for Link Training to be cleared by hardware */
+	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
+	do {
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &reg16);
+		if (!(reg16 & PCI_EXP_LNKSTA_LT))
+			return 0;
+		msleep(1);
+	} while (time_before(jiffies, end_jiffies));
+
+	return -ETIMEDOUT;
+}
+
+static int pcie_retrain_link(struct pcie_link_state *link)
+{
+	struct pci_dev *parent = link->pdev;
+	int rc;
+	u16 reg16;
+
+	/*
+	 * Ensure the updated LNKCTL parameters are used during link
+	 * training by checking that there is no ongoing link training to
+	 * avoid LTSSM race as recommended in Implementation Note at the
+	 * end of PCIe r6.0.1 sec 7.5.3.7.
+	 */
+	rc = pcie_wait_for_retrain(parent);
+	if (rc)
+		return rc;
+
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
 	reg16 |= PCI_EXP_LNKCTL_RL;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
@@ -212,15 +239,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
 	}
 
-	/* Wait for link training end. Break out after waiting for timeout */
-	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
-	do {
-		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
-		if (!(reg16 & PCI_EXP_LNKSTA_LT))
-			break;
-		msleep(1);
-	} while (time_before(jiffies, end_jiffies));
-	return !(reg16 & PCI_EXP_LNKSTA_LT);
+	return pcie_wait_for_retrain(parent);
 }
 
 /*
@@ -289,15 +308,15 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 		reg16 &= ~PCI_EXP_LNKCTL_CCC;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
 
-	if (pcie_retrain_link(link))
-		return;
+	if (pcie_retrain_link(link)) {
 
-	/* Training failed. Restore common clock configurations */
-	pci_err(parent, "ASPM: Could not configure common clock\n");
-	list_for_each_entry(child, &linkbus->devices, bus_list)
-		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
+		/* Training failed. Restore common clock configurations */
+		pci_err(parent, "ASPM: Could not configure common clock\n");
+		list_for_each_entry(child, &linkbus->devices, bus_list)
+			pcie_capability_write_word(child, PCI_EXP_LNKCTL,
 					   child_reg[PCI_FUNC(child->devfn)]);
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+	}
 }
 
 /* Convert L0s latency encoding to ns */
diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index b133ae06757a..a922fb11a109 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -158,7 +158,7 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 		phy_set_drvdata(phy, &priv->ports[i]);
 		i++;
 
-		if (i > INNO_PHY_PORT_NUM) {
+		if (i >= INNO_PHY_PORT_NUM) {
 			dev_warn(dev, "Support %d ports in maximum\n", i);
 			of_node_put(child);
 			break;
diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
index 232fd3f1ff1b..d7024a144335 100644
--- a/drivers/phy/mediatek/phy-mtk-dp.c
+++ b/drivers/phy/mediatek/phy-mtk-dp.c
@@ -169,7 +169,7 @@ static int mtk_dp_phy_probe(struct platform_device *pdev)
 
 	regs = *(struct regmap **)dev->platform_data;
 	if (!regs)
-		return dev_err_probe(dev, EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "No data passed, requires struct regmap**\n");
 
 	dp_phy = devm_kzalloc(dev, sizeof(*dp_phy), GFP_KERNEL);
diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index a59063596214..6170f8fd118e 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -110,23 +110,27 @@ struct phy_override_seq {
 /**
  * struct qcom_snps_hsphy - snps hs phy attributes
  *
+ * @dev: device structure
+ *
  * @phy: generic phy
  * @base: iomapped memory space for snps hs phy
  *
- * @cfg_ahb_clk: AHB2PHY interface clock
- * @ref_clk: phy reference clock
- * @iface_clk: phy interface clock
+ * @num_clks: number of clocks
+ * @clks: array of clocks
  * @phy_reset: phy reset control
  * @vregs: regulator supplies bulk data
  * @phy_initialized: if PHY has been initialized correctly
  * @mode: contains the current mode the PHY is in
+ * @update_seq_cfg: tuning parameters for phy init
  */
 struct qcom_snps_hsphy {
+	struct device *dev;
+
 	struct phy *phy;
 	void __iomem *base;
 
-	struct clk *cfg_ahb_clk;
-	struct clk *ref_clk;
+	int num_clks;
+	struct clk_bulk_data *clks;
 	struct reset_control *phy_reset;
 	struct regulator_bulk_data vregs[SNPS_HS_NUM_VREGS];
 
@@ -135,6 +139,34 @@ struct qcom_snps_hsphy {
 	struct phy_override_seq update_seq_cfg[NUM_HSPHY_TUNING_PARAMS];
 };
 
+static int qcom_snps_hsphy_clk_init(struct qcom_snps_hsphy *hsphy)
+{
+	struct device *dev = hsphy->dev;
+
+	hsphy->num_clks = 2;
+	hsphy->clks = devm_kcalloc(dev, hsphy->num_clks, sizeof(*hsphy->clks), GFP_KERNEL);
+	if (!hsphy->clks)
+		return -ENOMEM;
+
+	/*
+	 * TODO: Currently no device tree instantiation of the PHY is using the clock.
+	 * This needs to be fixed in order for this code to be able to use devm_clk_bulk_get().
+	 */
+	hsphy->clks[0].id = "cfg_ahb";
+	hsphy->clks[0].clk = devm_clk_get_optional(dev, "cfg_ahb");
+	if (IS_ERR(hsphy->clks[0].clk))
+		return dev_err_probe(dev, PTR_ERR(hsphy->clks[0].clk),
+				     "failed to get cfg_ahb clk\n");
+
+	hsphy->clks[1].id = "ref";
+	hsphy->clks[1].clk = devm_clk_get(dev, "ref");
+	if (IS_ERR(hsphy->clks[1].clk))
+		return dev_err_probe(dev, PTR_ERR(hsphy->clks[1].clk),
+				     "failed to get ref clk\n");
+
+	return 0;
+}
+
 static inline void qcom_snps_hsphy_write_mask(void __iomem *base, u32 offset,
 						u32 mask, u32 val)
 {
@@ -165,22 +197,13 @@ static int qcom_snps_hsphy_suspend(struct qcom_snps_hsphy *hsphy)
 					   0, USB2_AUTO_RESUME);
 	}
 
-	clk_disable_unprepare(hsphy->cfg_ahb_clk);
 	return 0;
 }
 
 static int qcom_snps_hsphy_resume(struct qcom_snps_hsphy *hsphy)
 {
-	int ret;
-
 	dev_dbg(&hsphy->phy->dev, "Resume QCOM SNPS PHY, mode\n");
 
-	ret = clk_prepare_enable(hsphy->cfg_ahb_clk);
-	if (ret) {
-		dev_err(&hsphy->phy->dev, "failed to enable cfg ahb clock\n");
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -374,16 +397,16 @@ static int qcom_snps_hsphy_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(hsphy->cfg_ahb_clk);
+	ret = clk_bulk_prepare_enable(hsphy->num_clks, hsphy->clks);
 	if (ret) {
-		dev_err(&phy->dev, "failed to enable cfg ahb clock, %d\n", ret);
+		dev_err(&phy->dev, "failed to enable clocks, %d\n", ret);
 		goto poweroff_phy;
 	}
 
 	ret = reset_control_assert(hsphy->phy_reset);
 	if (ret) {
 		dev_err(&phy->dev, "failed to assert phy_reset, %d\n", ret);
-		goto disable_ahb_clk;
+		goto disable_clks;
 	}
 
 	usleep_range(100, 150);
@@ -391,7 +414,7 @@ static int qcom_snps_hsphy_init(struct phy *phy)
 	ret = reset_control_deassert(hsphy->phy_reset);
 	if (ret) {
 		dev_err(&phy->dev, "failed to de-assert phy_reset, %d\n", ret);
-		goto disable_ahb_clk;
+		goto disable_clks;
 	}
 
 	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_CFG0,
@@ -448,8 +471,8 @@ static int qcom_snps_hsphy_init(struct phy *phy)
 
 	return 0;
 
-disable_ahb_clk:
-	clk_disable_unprepare(hsphy->cfg_ahb_clk);
+disable_clks:
+	clk_bulk_disable_unprepare(hsphy->num_clks, hsphy->clks);
 poweroff_phy:
 	regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
 
@@ -461,7 +484,7 @@ static int qcom_snps_hsphy_exit(struct phy *phy)
 	struct qcom_snps_hsphy *hsphy = phy_get_drvdata(phy);
 
 	reset_control_assert(hsphy->phy_reset);
-	clk_disable_unprepare(hsphy->cfg_ahb_clk);
+	clk_bulk_disable_unprepare(hsphy->num_clks, hsphy->clks);
 	regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
 	hsphy->phy_initialized = false;
 
@@ -554,14 +577,15 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
 	if (!hsphy)
 		return -ENOMEM;
 
+	hsphy->dev = dev;
+
 	hsphy->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hsphy->base))
 		return PTR_ERR(hsphy->base);
 
-	hsphy->ref_clk = devm_clk_get(dev, "ref");
-	if (IS_ERR(hsphy->ref_clk))
-		return dev_err_probe(dev, PTR_ERR(hsphy->ref_clk),
-				     "failed to get ref clk\n");
+	ret = qcom_snps_hsphy_clk_init(hsphy);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize clocks\n");
 
 	hsphy->phy_reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(hsphy->phy_reset)) {
diff --git a/drivers/platform/x86/amd/pmf/acpi.c b/drivers/platform/x86/amd/pmf/acpi.c
index 081e84e116e7..3fc5e4547d9f 100644
--- a/drivers/platform/x86/amd/pmf/acpi.c
+++ b/drivers/platform/x86/amd/pmf/acpi.c
@@ -106,6 +106,27 @@ int apmf_get_static_slider_granular(struct amd_pmf_dev *pdev,
 									 data, sizeof(*data));
 }
 
+int apmf_os_power_slider_update(struct amd_pmf_dev *pdev, u8 event)
+{
+	struct os_power_slider args;
+	struct acpi_buffer params;
+	union acpi_object *info;
+	int err = 0;
+
+	args.size = sizeof(args);
+	args.slider_event = event;
+
+	params.length = sizeof(args);
+	params.pointer = (void *)&args;
+
+	info = apmf_if_call(pdev, APMF_FUNC_OS_POWER_SLIDER_UPDATE, &params);
+	if (!info)
+		err = -EIO;
+
+	kfree(info);
+	return err;
+}
+
 static void apmf_sbios_heartbeat_notify(struct work_struct *work)
 {
 	struct amd_pmf_dev *dev = container_of(work, struct amd_pmf_dev, heart_beat.work);
@@ -289,7 +310,7 @@ int apmf_acpi_init(struct amd_pmf_dev *pmf_dev)
 
 	ret = apmf_get_system_params(pmf_dev);
 	if (ret) {
-		dev_err(pmf_dev->dev, "APMF apmf_get_system_params failed :%d\n", ret);
+		dev_dbg(pmf_dev->dev, "APMF apmf_get_system_params failed :%d\n", ret);
 		goto out;
 	}
 
diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index 73d2357e32f8..8a38cd94a605 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -71,7 +71,11 @@ static int amd_pmf_pwr_src_notify_call(struct notifier_block *nb, unsigned long
 			return NOTIFY_DONE;
 	}
 
-	amd_pmf_set_sps_power_limits(pmf);
+	if (is_apmf_func_supported(pmf, APMF_FUNC_STATIC_SLIDER_GRANULAR))
+		amd_pmf_set_sps_power_limits(pmf);
+
+	if (is_apmf_func_supported(pmf, APMF_FUNC_OS_POWER_SLIDER_UPDATE))
+		amd_pmf_power_slider_update_event(pmf);
 
 	return NOTIFY_OK;
 }
@@ -295,7 +299,8 @@ static void amd_pmf_init_features(struct amd_pmf_dev *dev)
 	int ret;
 
 	/* Enable Static Slider */
-	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
+	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR) ||
+	    is_apmf_func_supported(dev, APMF_FUNC_OS_POWER_SLIDER_UPDATE)) {
 		amd_pmf_init_sps(dev);
 		dev->pwr_src_notifier.notifier_call = amd_pmf_pwr_src_notify_call;
 		power_supply_reg_notifier(&dev->pwr_src_notifier);
diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
index 06c30cdc0573..deba88e6e4c8 100644
--- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -21,6 +21,7 @@
 #define APMF_FUNC_SBIOS_HEARTBEAT			4
 #define APMF_FUNC_AUTO_MODE					5
 #define APMF_FUNC_SET_FAN_IDX				7
+#define APMF_FUNC_OS_POWER_SLIDER_UPDATE		8
 #define APMF_FUNC_STATIC_SLIDER_GRANULAR       9
 #define APMF_FUNC_DYN_SLIDER_AC				11
 #define APMF_FUNC_DYN_SLIDER_DC				12
@@ -44,6 +45,14 @@
 #define GET_STT_LIMIT_APU	0x20
 #define GET_STT_LIMIT_HS2	0x21
 
+/* OS slider update notification */
+#define DC_BEST_PERF		0
+#define DC_BETTER_PERF		1
+#define DC_BATTERY_SAVER	3
+#define AC_BEST_PERF		4
+#define AC_BETTER_PERF		5
+#define AC_BETTER_BATTERY	6
+
 /* Fan Index for Auto Mode */
 #define FAN_INDEX_AUTO		0xFFFFFFFF
 
@@ -193,6 +202,11 @@ struct amd_pmf_static_slider_granular {
 	struct apmf_sps_prop_granular prop[POWER_SOURCE_MAX][POWER_MODE_MAX];
 };
 
+struct os_power_slider {
+	u16 size;
+	u8 slider_event;
+} __packed;
+
 struct fan_table_control {
 	bool manual;
 	unsigned long fan_id;
@@ -383,6 +397,7 @@ int amd_pmf_send_cmd(struct amd_pmf_dev *dev, u8 message, bool get, u32 arg, u32
 int amd_pmf_init_metrics_table(struct amd_pmf_dev *dev);
 int amd_pmf_get_power_source(void);
 int apmf_install_handler(struct amd_pmf_dev *pmf_dev);
+int apmf_os_power_slider_update(struct amd_pmf_dev *dev, u8 flag);
 
 /* SPS Layer */
 int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf);
@@ -393,6 +408,7 @@ void amd_pmf_deinit_sps(struct amd_pmf_dev *dev);
 int apmf_get_static_slider_granular(struct amd_pmf_dev *pdev,
 				    struct apmf_static_slider_granular_output *output);
 bool is_pprof_balanced(struct amd_pmf_dev *pmf);
+int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev);
 
 
 int apmf_update_fan_idx(struct amd_pmf_dev *pdev, bool manual, u32 idx);
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index bed762d47a14..fd448844de20 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -119,14 +119,77 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
 	return mode;
 }
 
+int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
+{
+	u8 mode, flag = 0;
+	int src;
+
+	mode = amd_pmf_get_pprof_modes(dev);
+	if (mode < 0)
+		return mode;
+
+	src = amd_pmf_get_power_source();
+
+	if (src == POWER_SOURCE_AC) {
+		switch (mode) {
+		case POWER_MODE_PERFORMANCE:
+			flag |= BIT(AC_BEST_PERF);
+			break;
+		case POWER_MODE_BALANCED_POWER:
+			flag |= BIT(AC_BETTER_PERF);
+			break;
+		case POWER_MODE_POWER_SAVER:
+			flag |= BIT(AC_BETTER_BATTERY);
+			break;
+		default:
+			dev_err(dev->dev, "unsupported platform profile\n");
+			return -EOPNOTSUPP;
+		}
+
+	} else if (src == POWER_SOURCE_DC) {
+		switch (mode) {
+		case POWER_MODE_PERFORMANCE:
+			flag |= BIT(DC_BEST_PERF);
+			break;
+		case POWER_MODE_BALANCED_POWER:
+			flag |= BIT(DC_BETTER_PERF);
+			break;
+		case POWER_MODE_POWER_SAVER:
+			flag |= BIT(DC_BATTERY_SAVER);
+			break;
+		default:
+			dev_err(dev->dev, "unsupported platform profile\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	apmf_os_power_slider_update(dev, flag);
+
+	return 0;
+}
+
 static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
 			       enum platform_profile_option profile)
 {
 	struct amd_pmf_dev *pmf = container_of(pprof, struct amd_pmf_dev, pprof);
+	int ret = 0;
 
 	pmf->current_profile = profile;
 
-	return amd_pmf_set_sps_power_limits(pmf);
+	/* Notify EC about the slider position change */
+	if (is_apmf_func_supported(pmf, APMF_FUNC_OS_POWER_SLIDER_UPDATE)) {
+		ret = amd_pmf_power_slider_update_event(pmf);
+		if (ret)
+			return ret;
+	}
+
+	if (is_apmf_func_supported(pmf, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
+		ret = amd_pmf_set_sps_power_limits(pmf);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 int amd_pmf_init_sps(struct amd_pmf_dev *dev)
@@ -134,10 +197,13 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 	int err;
 
 	dev->current_profile = PLATFORM_PROFILE_BALANCED;
-	amd_pmf_load_defaults_sps(dev);
 
-	/* update SPS balanced power mode thermals */
-	amd_pmf_set_sps_power_limits(dev);
+	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
+		amd_pmf_load_defaults_sps(dev);
+
+		/* update SPS balanced power mode thermals */
+		amd_pmf_set_sps_power_limits(dev);
+	}
 
 	dev->pprof.profile_get = amd_pmf_profile_get;
 	dev->pprof.profile_set = amd_pmf_profile_set;
diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86/msi-laptop.c
index 6b18ec543ac3..f4c6c36e05a5 100644
--- a/drivers/platform/x86/msi-laptop.c
+++ b/drivers/platform/x86/msi-laptop.c
@@ -208,7 +208,7 @@ static ssize_t set_device_state(const char *buf, size_t count, u8 mask)
 		return -EINVAL;
 
 	if (quirks->ec_read_only)
-		return -EOPNOTSUPP;
+		return 0;
 
 	/* read current device state */
 	result = ec_read(MSI_STANDARD_EC_COMMAND_ADDRESS, &rdata);
@@ -838,15 +838,15 @@ static bool msi_laptop_i8042_filter(unsigned char data, unsigned char str,
 static void msi_init_rfkill(struct work_struct *ignored)
 {
 	if (rfk_wlan) {
-		rfkill_set_sw_state(rfk_wlan, !wlan_s);
+		msi_rfkill_set_state(rfk_wlan, !wlan_s);
 		rfkill_wlan_set(NULL, !wlan_s);
 	}
 	if (rfk_bluetooth) {
-		rfkill_set_sw_state(rfk_bluetooth, !bluetooth_s);
+		msi_rfkill_set_state(rfk_bluetooth, !bluetooth_s);
 		rfkill_bluetooth_set(NULL, !bluetooth_s);
 	}
 	if (rfk_threeg) {
-		rfkill_set_sw_state(rfk_threeg, !threeg_s);
+		msi_rfkill_set_state(rfk_threeg, !threeg_s);
 		rfkill_threeg_set(NULL, !threeg_s);
 	}
 }
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 81d283b3cd3b..d030fe2e2964 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -1050,7 +1050,7 @@ dasd_3990_erp_com_rej(struct dasd_ccw_req * erp, char *sense)
 		dev_err(&device->cdev->dev, "An I/O request was rejected"
 			" because writing is inhibited\n");
 		erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
-	} else if (sense[7] & SNS7_INVALID_ON_SEC) {
+	} else if (sense[7] == SNS7_INVALID_ON_SEC) {
 		dev_err(&device->cdev->dev, "An I/O request was rejected on a copy pair secondary device\n");
 		/* suppress dump of sense data for this error */
 		set_bit(DASD_CQR_SUPPRESS_CR, &erp->refers->flags);
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 8fca725b3dae..87890b6efcdc 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -131,6 +131,7 @@ static int dasd_ioctl_resume(struct dasd_block *block)
 	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 
 	dasd_schedule_block_bh(block);
+	dasd_schedule_device_bh(base);
 	return 0;
 }
 
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 4fd221d0cc81..f7b3e6a6975b 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -884,8 +884,8 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 			"initializing enumeration and init completion for Slave %d\n",
 			slave->dev_num);
 
-		init_completion(&slave->enumeration_complete);
-		init_completion(&slave->initialization_complete);
+		reinit_completion(&slave->enumeration_complete);
+		reinit_completion(&slave->initialization_complete);
 
 	} else if ((status == SDW_SLAVE_ATTACHED) &&
 		   (slave->status == SDW_SLAVE_UNATTACHED)) {
@@ -893,7 +893,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 			"signaling enumeration completion for Slave %d\n",
 			slave->dev_num);
 
-		complete(&slave->enumeration_complete);
+		complete_all(&slave->enumeration_complete);
 	}
 	slave->status = status;
 	mutex_unlock(&bus->bus_lock);
@@ -1916,7 +1916,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 				"signaling initialization completion for Slave %d\n",
 				slave->dev_num);
 
-			complete(&slave->initialization_complete);
+			complete_all(&slave->initialization_complete);
 
 			/*
 			 * If the manager became pm_runtime active, the peripherals will be
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 08934d27f709..a51c8a670d38 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -434,7 +434,7 @@ static int qcom_swrm_get_alert_slave_dev_num(struct qcom_swrm_ctrl *ctrl)
 		status = (val >> (dev_num * SWRM_MCP_SLV_STATUS_SZ));
 
 		if ((status & SWRM_MCP_SLV_STATUS_MASK) == SDW_SLAVE_ALERT) {
-			ctrl->status[dev_num] = status;
+			ctrl->status[dev_num] = status & SWRM_MCP_SLV_STATUS_MASK;
 			return dev_num;
 		}
 	}
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 7e8d37c169f0..f389e227aefb 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1584,8 +1584,10 @@ static int ks_wlan_set_encode_ext(struct net_device *dev,
 			commit |= SME_WEP_FLAG;
 		}
 		if (enc->key_len) {
-			memcpy(&key->key_val[0], &enc->key[0], enc->key_len);
-			key->key_len = enc->key_len;
+			int key_len = clamp_val(enc->key_len, 0, IW_ENCODING_TOKEN_MAX);
+
+			memcpy(&key->key_val[0], &enc->key[0], key_len);
+			key->key_len = key_len;
 			commit |= (SME_WEP_VAL1 << index);
 		}
 		break;
diff --git a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
index 2c8d7fdcc5f7..4881b6ea5237 100644
--- a/drivers/staging/media/atomisp/Kconfig
+++ b/drivers/staging/media/atomisp/Kconfig
@@ -13,6 +13,7 @@ config VIDEO_ATOMISP
 	tristate "Intel Atom Image Signal Processor Driver"
 	depends on VIDEO_DEV && INTEL_ATOMISP
 	depends on PMIC_OPREGION
+	select V4L2_FWNODE
 	select IOSF_MBI
 	select VIDEOBUF_VMALLOC
 	select VIDEO_V4L2_SUBDEV_API
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 090345bad223..6353dbe554d3 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -21,6 +21,7 @@
 #include "osdep_intf.h"
 #include "usb_ops.h"
 
+#include <linux/usb.h>
 #include <linux/ieee80211.h>
 
 static const u8 P802_1H_OUI[P80211_OUI_LEN] = {0x00, 0x00, 0xf8};
@@ -55,6 +56,7 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	sint i;
 	struct xmit_buf *pxmitbuf;
 	struct xmit_frame *pxframe;
+	int j;
 
 	memset((unsigned char *)pxmitpriv, 0, sizeof(struct xmit_priv));
 	spin_lock_init(&pxmitpriv->lock);
@@ -117,11 +119,8 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	_init_queue(&pxmitpriv->pending_xmitbuf_queue);
 	pxmitpriv->pallocated_xmitbuf =
 		kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4, GFP_ATOMIC);
-	if (!pxmitpriv->pallocated_xmitbuf) {
-		kfree(pxmitpriv->pallocated_frame_buf);
-		pxmitpriv->pallocated_frame_buf = NULL;
-		return -ENOMEM;
-	}
+	if (!pxmitpriv->pallocated_xmitbuf)
+		goto clean_up_frame_buf;
 	pxmitpriv->pxmitbuf = pxmitpriv->pallocated_xmitbuf + 4 -
 			      ((addr_t)(pxmitpriv->pallocated_xmitbuf) & 3);
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
@@ -129,13 +128,17 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 		INIT_LIST_HEAD(&pxmitbuf->list);
 		pxmitbuf->pallocated_buf =
 			kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ, GFP_ATOMIC);
-		if (!pxmitbuf->pallocated_buf)
-			return -ENOMEM;
+		if (!pxmitbuf->pallocated_buf) {
+			j = 0;
+			goto clean_up_alloc_buf;
+		}
 		pxmitbuf->pbuf = pxmitbuf->pallocated_buf + XMITBUF_ALIGN_SZ -
 				 ((addr_t) (pxmitbuf->pallocated_buf) &
 				 (XMITBUF_ALIGN_SZ - 1));
-		if (r8712_xmit_resource_alloc(padapter, pxmitbuf))
-			return -ENOMEM;
+		if (r8712_xmit_resource_alloc(padapter, pxmitbuf)) {
+			j = 1;
+			goto clean_up_alloc_buf;
+		}
 		list_add_tail(&pxmitbuf->list,
 				 &(pxmitpriv->free_xmitbuf_queue.queue));
 		pxmitbuf++;
@@ -146,6 +149,28 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 	tasklet_setup(&pxmitpriv->xmit_tasklet, r8712_xmit_bh);
 	return 0;
+
+clean_up_alloc_buf:
+	if (j) {
+		/* failure happened in r8712_xmit_resource_alloc()
+		 * delete extra pxmitbuf->pallocated_buf
+		 */
+		kfree(pxmitbuf->pallocated_buf);
+	}
+	for (j = 0; j < i; j++) {
+		int k;
+
+		pxmitbuf--;			/* reset pointer */
+		kfree(pxmitbuf->pallocated_buf);
+		for (k = 0; k < 8; k++)		/* delete xmit urb's */
+			usb_free_urb(pxmitbuf->pxmit_urb[k]);
+	}
+	kfree(pxmitpriv->pallocated_xmitbuf);
+	pxmitpriv->pallocated_xmitbuf = NULL;
+clean_up_frame_buf:
+	kfree(pxmitpriv->pallocated_frame_buf);
+	pxmitpriv->pallocated_frame_buf = NULL;
+	return -ENOMEM;
 }
 
 void _free_xmit_priv(struct xmit_priv *pxmitpriv)
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 132afbf49dde..ceb6b590b310 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -112,6 +112,12 @@ int r8712_xmit_resource_alloc(struct _adapter *padapter,
 	for (i = 0; i < 8; i++) {
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!pxmitbuf->pxmit_urb[i]) {
+			int k;
+
+			for (k = i - 1; k >= 0; k--) {
+				/* handle allocation errors part way through loop */
+				usb_free_urb(pxmitbuf->pxmit_urb[k]);
+			}
 			netdev_err(padapter->pnetdev, "pxmitbuf->pxmit_urb[i] == NULL\n");
 			return -ENOMEM;
 		}
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b6e0cc4571ea..59a559366b61 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2508,8 +2508,10 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 		gsm->has_devices = false;
 	}
 	for (i = NUM_DLCI - 1; i >= 0; i--)
-		if (gsm->dlci[i])
+		if (gsm->dlci[i]) {
 			gsm_dlci_release(gsm->dlci[i]);
+			gsm->dlci[i] = NULL;
+		}
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
 	tty_ldisc_flush(gsm->tty);
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 597019690ae6..4dff2f34e2d0 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -204,8 +204,8 @@ static void n_tty_kick_worker(struct tty_struct *tty)
 	struct n_tty_data *ldata = tty->disc_data;
 
 	/* Did the input worker stop? Restart it */
-	if (unlikely(ldata->no_room)) {
-		ldata->no_room = 0;
+	if (unlikely(READ_ONCE(ldata->no_room))) {
+		WRITE_ONCE(ldata->no_room, 0);
 
 		WARN_RATELIMIT(tty->port->itty == NULL,
 				"scheduling with invalid itty\n");
@@ -1698,7 +1698,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 			if (overflow && room < 0)
 				ldata->read_head--;
 			room = overflow;
-			ldata->no_room = flow && !room;
+			WRITE_ONCE(ldata->no_room, flow && !room);
 		} else
 			overflow = 0;
 
@@ -1729,6 +1729,17 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 	} else
 		n_tty_check_throttle(tty);
 
+	if (unlikely(ldata->no_room)) {
+		/*
+		 * Barrier here is to ensure to read the latest read_tail in
+		 * chars_in_buffer() and to make sure that read_tail is not loaded
+		 * before ldata->no_room is set.
+		 */
+		smp_mb();
+		if (!chars_in_buffer(tty))
+			n_tty_kick_worker(tty);
+	}
+
 	up_read(&tty->termios_rwsem);
 
 	return rcvd;
@@ -2130,7 +2141,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 	ssize_t retval = 0;
 	long timeout;
 	bool packet;
-	size_t tail;
+	size_t old_tail;
 
 	/*
 	 * Is this a continuation of a read started earler?
@@ -2193,7 +2204,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 	}
 
 	packet = tty->ctrl.packet;
-	tail = ldata->read_tail;
+	old_tail = ldata->read_tail;
 
 	add_wait_queue(&tty->read_wait, &wait);
 	while (nr) {
@@ -2282,8 +2293,14 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 		if (time)
 			timeout = time;
 	}
-	if (tail != ldata->read_tail)
+	if (old_tail != ldata->read_tail) {
+		/*
+		 * Make sure no_room is not read in n_tty_kick_worker()
+		 * before setting ldata->read_tail in copy_from_read_buf().
+		 */
+		smp_mb();
 		n_tty_kick_worker(tty);
+	}
 	up_read(&tty->termios_rwsem);
 
 	remove_wait_queue(&tty->read_wait, &wait);
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 75f32f054ebb..84843e204a5e 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -244,7 +244,7 @@ void dw8250_setup_port(struct uart_port *p)
 	struct dw8250_port_data *pd = p->private_data;
 	struct dw8250_data *data = to_dw8250_data(pd);
 	struct uart_8250_port *up = up_to_u8250p(p);
-	u32 reg;
+	u32 reg, old_dlf;
 
 	pd->hw_rs485_support = dw8250_detect_rs485_hw(p);
 	if (pd->hw_rs485_support) {
@@ -270,9 +270,11 @@ void dw8250_setup_port(struct uart_port *p)
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
+	/* Preserve value written by firmware or bootloader  */
+	old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
 	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
 	reg = dw8250_readl_ext(p, DW_UART_DLF);
-	dw8250_writel_ext(p, DW_UART_DLF, 0);
+	dw8250_writel_ext(p, DW_UART_DLF, old_dlf);
 
 	if (reg) {
 		pd->dlf_size = fls(reg);
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index cf9dc2ddfe66..6f6c4e9b7743 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1495,13 +1495,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * Set pm_runtime status as ACTIVE so that wakeup_irq gets
-	 * enabled/disabled from dev_pm_arm_wake_irq during system
-	 * suspend/resume respectively.
-	 */
-	pm_runtime_set_active(&pdev->dev);
-
 	if (port->wakeup_irq > 0) {
 		device_init_wakeup(&pdev->dev, true);
 		ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 7fb6760b5c37..2affd1351ae7 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -832,7 +832,7 @@ static void sifive_serial_console_write(struct console *co, const char *s,
 	local_irq_restore(flags);
 }
 
-static int __init sifive_serial_console_setup(struct console *co, char *options)
+static int sifive_serial_console_setup(struct console *co, char *options)
 {
 	struct sifive_serial_port *ssp;
 	int baud = SIFIVE_DEFAULT_BAUD_RATE;
diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 1dcadef933e3..69a44bd7e5d0 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -3012,12 +3012,14 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
 static int cdns3_gadget_check_config(struct usb_gadget *gadget)
 {
 	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	struct cdns3_endpoint *priv_ep;
 	struct usb_ep *ep;
 	int n_in = 0;
 	int total;
 
 	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
-		if (ep->claimed && (ep->address & USB_DIR_IN))
+		priv_ep = ep_to_cdns3_ep(ep);
+		if ((priv_ep->flags & EP_CLAIMED) && (ep->address & USB_DIR_IN))
 			n_in++;
 	}
 
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 934b3d997702..15e9bd180a1d 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -436,6 +436,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* novation SoundControl XL */
 	{ USB_DEVICE(0x1235, 0x0061), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* Focusrite Scarlett Solo USB */
+	{ USB_DEVICE(0x1235, 0x8211), .driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
+
 	/* Huawei 4G LTE module */
 	{ USB_DEVICE(0x12d1, 0x15bb), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index e999e6079ae0..3ee70ffaf003 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -277,9 +277,9 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	/*
 	 * We're resetting only the device side because, if we're in host mode,
 	 * XHCI driver will reset the host block. If dwc3 was configured for
-	 * host-only mode, then we can return early.
+	 * host-only mode or current role is host, then we can return early.
 	 */
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+	if (dwc->dr_mode == USB_DR_MODE_HOST || dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -1241,22 +1241,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
-	if (dwc->dr_mode == USB_DR_MODE_HOST ||
-	    dwc->dr_mode == USB_DR_MODE_OTG) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
-
-		/*
-		 * Enable Auto retry Feature to make the controller operating in
-		 * Host mode on seeing transaction errors(CRC errors or internal
-		 * overrun scenerios) on IN transfers to reply to the device
-		 * with a non-terminating retry ACK (i.e, an ACK transcation
-		 * packet with Retry=1 & Nump != 0)
-		 */
-		reg |= DWC3_GUCTL_HSTINAUTORETRY;
-
-		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
-	}
-
 	/*
 	 * Must config both number of packets and max burst settings to enable
 	 * RX and/or TX threshold.
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index bb57bc9bc17c..80cc532ba9d5 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -254,9 +254,6 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
 #define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
-/* Global User Control Register */
-#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
-
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 560793545362..ae25ee832ec0 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -233,10 +233,12 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc,
 
 			/*
 			 * A lot of BYT devices lack ACPI resource entries for
-			 * the GPIOs, add a fallback mapping to the reference
+			 * the GPIOs. If the ACPI entry for the GPIO controller
+			 * is present add a fallback mapping to the reference
 			 * design GPIOs which all boards seem to use.
 			 */
-			gpiod_add_lookup_table(&platform_bytcr_gpios);
+			if (acpi_dev_present("INT33FC", NULL, -1))
+				gpiod_add_lookup_table(&platform_bytcr_gpios);
 
 			/*
 			 * These GPIOs will turn on the USB2 PHY. Note that we have to
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 403563c06477..cb0a4e2cdbb7 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1029,6 +1029,10 @@ int usb_add_config(struct usb_composite_dev *cdev,
 		goto done;
 
 	status = bind(config);
+
+	if (status == 0)
+		status = usb_gadget_check_config(cdev->gadget);
+
 	if (status < 0) {
 		while (!list_empty(&config->functions)) {
 			struct usb_function		*f;
diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 2acece16b890..e549022642e5 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -310,13 +310,15 @@ static int gadget_bind(struct usb_gadget *gadget,
 	dev->eps_num = i;
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	/* Matches kref_put() in gadget_unbind(). */
-	kref_get(&dev->count);
-
 	ret = raw_queue_event(dev, USB_RAW_EVENT_CONNECT, 0, NULL);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&gadget->dev, "failed to queue event\n");
+		set_gadget_data(gadget, NULL);
+		return ret;
+	}
 
+	/* Matches kref_put() in gadget_unbind(). */
+	kref_get(&dev->count);
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 99f40611f459..139f471894fb 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -851,7 +851,6 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 	 */
 	if (gadget->connected)
 		ret = usb_gadget_connect_locked(gadget);
-	mutex_unlock(&gadget->udc->connect_lock);
 
 unlock:
 	mutex_unlock(&gadget->udc->connect_lock);
diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 3c7ffb35c35c..a8cadc45c65a 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3695,15 +3695,15 @@ static int tegra_xudc_powerdomain_init(struct tegra_xudc *xudc)
 	int err;
 
 	xudc->genpd_dev_device = dev_pm_domain_attach_by_name(dev, "dev");
-	if (IS_ERR_OR_NULL(xudc->genpd_dev_device)) {
-		err = PTR_ERR(xudc->genpd_dev_device) ? : -ENODATA;
+	if (IS_ERR(xudc->genpd_dev_device)) {
+		err = PTR_ERR(xudc->genpd_dev_device);
 		dev_err(dev, "failed to get device power domain: %d\n", err);
 		return err;
 	}
 
 	xudc->genpd_dev_ss = dev_pm_domain_attach_by_name(dev, "ss");
-	if (IS_ERR_OR_NULL(xudc->genpd_dev_ss)) {
-		err = PTR_ERR(xudc->genpd_dev_ss) ? : -ENODATA;
+	if (IS_ERR(xudc->genpd_dev_ss)) {
+		err = PTR_ERR(xudc->genpd_dev_ss);
 		dev_err(dev, "failed to get SuperSpeed power domain: %d\n", err);
 		return err;
 	}
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 533537ef3c21..360680769494 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -673,7 +673,13 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 	else
 		at91_start_clock(ohci_at91);
 
-	ohci_resume(hcd, false);
+	/*
+	 * According to the comment in ohci_hcd_at91_drv_suspend()
+	 * we need to do a reset if the 48Mhz clock was stopped,
+	 * that is, if ohci_at91->wakeup is clear. Tell ohci_resume()
+	 * to reset in this case by setting its "hibernated" flag.
+	 */
+	ohci_resume(hcd, !ohci_at91->wakeup);
 
 	return 0;
 }
diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index c61fc19ef115..a0921687444b 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -590,6 +590,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	}
 
 	device_init_wakeup(dev, true);
+	dma_set_max_seg_size(dev, UINT_MAX);
 
 	xhci = hcd_to_xhci(hcd);
 	xhci->main_hcd = hcd;
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 5e72d02042ce..2aed88c28ef6 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -293,10 +293,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 			pdev->device == 0x3432)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 
-	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483) {
+	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483)
 		xhci->quirks |= XHCI_LPM_SUPPORT;
-		xhci->quirks |= XHCI_EP_CTX_BROKEN_DCS;
-	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 7a7ab525675b..281690c582cb 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -592,11 +592,8 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
 	struct xhci_ring *ep_ring;
 	struct xhci_command *cmd;
 	struct xhci_segment *new_seg;
-	struct xhci_segment *halted_seg = NULL;
 	union xhci_trb *new_deq;
 	int new_cycle;
-	union xhci_trb *halted_trb;
-	int index = 0;
 	dma_addr_t addr;
 	u64 hw_dequeue;
 	bool cycle_found = false;
@@ -634,27 +631,7 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
 	hw_dequeue = xhci_get_hw_deq(xhci, dev, ep_index, stream_id);
 	new_seg = ep_ring->deq_seg;
 	new_deq = ep_ring->dequeue;
-
-	/*
-	 * Quirk: xHC write-back of the DCS field in the hardware dequeue
-	 * pointer is wrong - use the cycle state of the TRB pointed to by
-	 * the dequeue pointer.
-	 */
-	if (xhci->quirks & XHCI_EP_CTX_BROKEN_DCS &&
-	    !(ep->ep_state & EP_HAS_STREAMS))
-		halted_seg = trb_in_td(xhci, td->start_seg,
-				       td->first_trb, td->last_trb,
-				       hw_dequeue & ~0xf, false);
-	if (halted_seg) {
-		index = ((dma_addr_t)(hw_dequeue & ~0xf) - halted_seg->dma) /
-			 sizeof(*halted_trb);
-		halted_trb = &halted_seg->trbs[index];
-		new_cycle = halted_trb->generic.field[3] & 0x1;
-		xhci_dbg(xhci, "Endpoint DCS = %d TRB index = %d cycle = %d\n",
-			 (u8)(hw_dequeue & 0x1), index, new_cycle);
-	} else {
-		new_cycle = hw_dequeue & 0x1;
-	}
+	new_cycle = hw_dequeue & 0x1;
 
 	/*
 	 * We want to find the pointer, segment and cycle state of the new trb
diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 32df571bb233..51eabc5e8770 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1010,15 +1010,15 @@ static int tegra_xusb_powerdomain_init(struct device *dev,
 	int err;
 
 	tegra->genpd_dev_host = dev_pm_domain_attach_by_name(dev, "xusb_host");
-	if (IS_ERR_OR_NULL(tegra->genpd_dev_host)) {
-		err = PTR_ERR(tegra->genpd_dev_host) ? : -ENODATA;
+	if (IS_ERR(tegra->genpd_dev_host)) {
+		err = PTR_ERR(tegra->genpd_dev_host);
 		dev_err(dev, "failed to get host pm-domain: %d\n", err);
 		return err;
 	}
 
 	tegra->genpd_dev_ss = dev_pm_domain_attach_by_name(dev, "xusb_ss");
-	if (IS_ERR_OR_NULL(tegra->genpd_dev_ss)) {
-		err = PTR_ERR(tegra->genpd_dev_ss) ? : -ENODATA;
+	if (IS_ERR(tegra->genpd_dev_ss)) {
+		err = PTR_ERR(tegra->genpd_dev_ss);
 		dev_err(dev, "failed to get superspeed pm-domain: %d\n", err);
 		return err;
 	}
diff --git a/drivers/usb/misc/ehset.c b/drivers/usb/misc/ehset.c
index 986d6589f053..36b6e9fa7ffb 100644
--- a/drivers/usb/misc/ehset.c
+++ b/drivers/usb/misc/ehset.c
@@ -77,7 +77,7 @@ static int ehset_probe(struct usb_interface *intf,
 	switch (test_pid) {
 	case TEST_SE0_NAK_PID:
 		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
-		if (!ret)
+		if (ret < 0)
 			break;
 		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
 					   USB_RT_PORT, USB_PORT_FEAT_TEST,
@@ -86,7 +86,7 @@ static int ehset_probe(struct usb_interface *intf,
 		break;
 	case TEST_J_PID:
 		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
-		if (!ret)
+		if (ret < 0)
 			break;
 		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
 					   USB_RT_PORT, USB_PORT_FEAT_TEST,
@@ -95,7 +95,7 @@ static int ehset_probe(struct usb_interface *intf,
 		break;
 	case TEST_K_PID:
 		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
-		if (!ret)
+		if (ret < 0)
 			break;
 		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
 					   USB_RT_PORT, USB_PORT_FEAT_TEST,
@@ -104,7 +104,7 @@ static int ehset_probe(struct usb_interface *intf,
 		break;
 	case TEST_PACKET_PID:
 		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
-		if (!ret)
+		if (ret < 0)
 			break;
 		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
 					   USB_RT_PORT, USB_PORT_FEAT_TEST,
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 6692440c1e0a..119641761c3b 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -251,6 +251,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM061K_LTA		0x0123
 #define QUECTEL_PRODUCT_EM061K_LMS		0x0124
 #define QUECTEL_PRODUCT_EC25			0x0125
+#define QUECTEL_PRODUCT_EM060K_128		0x0128
 #define QUECTEL_PRODUCT_EG91			0x0191
 #define QUECTEL_PRODUCT_EG95			0x0195
 #define QUECTEL_PRODUCT_BG96			0x0296
@@ -268,6 +269,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_RM520N			0x0801
 #define QUECTEL_PRODUCT_EC200U			0x0901
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
+#define QUECTEL_PRODUCT_EC200A			0x6005
 #define QUECTEL_PRODUCT_EM061K_LWW		0x6008
 #define QUECTEL_PRODUCT_EM061K_LCN		0x6009
 #define QUECTEL_PRODUCT_EC200T			0x6026
@@ -1197,6 +1199,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x40) },
@@ -1225,6 +1230,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM520N, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, 0x0900, 0xff, 0, 0), /* RM500U-CN */
 	  .driver_info = ZLP },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200A, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 4c6747889a19..24b8772a345e 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -38,16 +38,6 @@ static struct usb_serial_driver vendor##_device = {		\
 	{ USB_DEVICE(0x0a21, 0x8001) }	/* MMT-7305WW */
 DEVICE(carelink, CARELINK_IDS);
 
-/* ZIO Motherboard USB driver */
-#define ZIO_IDS()			\
-	{ USB_DEVICE(0x1CBE, 0x0103) }
-DEVICE(zio, ZIO_IDS);
-
-/* Funsoft Serial USB driver */
-#define FUNSOFT_IDS()			\
-	{ USB_DEVICE(0x1404, 0xcddc) }
-DEVICE(funsoft, FUNSOFT_IDS);
-
 /* Infineon Flashloader driver */
 #define FLASHLOADER_IDS()		\
 	{ USB_DEVICE_INTERFACE_CLASS(0x058b, 0x0041, USB_CLASS_CDC_DATA) }, \
@@ -55,6 +45,11 @@ DEVICE(funsoft, FUNSOFT_IDS);
 	{ USB_DEVICE(0x8087, 0x0801) }
 DEVICE(flashloader, FLASHLOADER_IDS);
 
+/* Funsoft Serial USB driver */
+#define FUNSOFT_IDS()			\
+	{ USB_DEVICE(0x1404, 0xcddc) }
+DEVICE(funsoft, FUNSOFT_IDS);
+
 /* Google Serial USB SubClass */
 #define GOOGLE_IDS()						\
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x18d1,			\
@@ -63,16 +58,21 @@ DEVICE(flashloader, FLASHLOADER_IDS);
 					0x01) }
 DEVICE(google, GOOGLE_IDS);
 
+/* HP4x (48/49) Generic Serial driver */
+#define HP4X_IDS()			\
+	{ USB_DEVICE(0x03f0, 0x0121) }
+DEVICE(hp4x, HP4X_IDS);
+
+/* KAUFMANN RKS+CAN VCP */
+#define KAUFMANN_IDS()			\
+	{ USB_DEVICE(0x16d0, 0x0870) }
+DEVICE(kaufmann, KAUFMANN_IDS);
+
 /* Libtransistor USB console */
 #define LIBTRANSISTOR_IDS()			\
 	{ USB_DEVICE(0x1209, 0x8b00) }
 DEVICE(libtransistor, LIBTRANSISTOR_IDS);
 
-/* ViVOpay USB Serial Driver */
-#define VIVOPAY_IDS()			\
-	{ USB_DEVICE(0x1d5f, 0x1004) }	/* ViVOpay 8800 */
-DEVICE(vivopay, VIVOPAY_IDS);
-
 /* Motorola USB Phone driver */
 #define MOTO_IDS()			\
 	{ USB_DEVICE(0x05c6, 0x3197) },	/* unknown Motorola phone */	\
@@ -101,10 +101,10 @@ DEVICE(nokia, NOKIA_IDS);
 	{ USB_DEVICE(0x09d7, 0x0100) }	/* NovAtel FlexPack GPS */
 DEVICE_N(novatel_gps, NOVATEL_IDS, 3);
 
-/* HP4x (48/49) Generic Serial driver */
-#define HP4X_IDS()			\
-	{ USB_DEVICE(0x03f0, 0x0121) }
-DEVICE(hp4x, HP4X_IDS);
+/* Siemens USB/MPI adapter */
+#define SIEMENS_IDS()			\
+	{ USB_DEVICE(0x908, 0x0004) }
+DEVICE(siemens_mpi, SIEMENS_IDS);
 
 /* Suunto ANT+ USB Driver */
 #define SUUNTO_IDS()			\
@@ -112,45 +112,52 @@ DEVICE(hp4x, HP4X_IDS);
 	{ USB_DEVICE(0x0fcf, 0x1009) } /* Dynastream ANT USB-m Stick */
 DEVICE(suunto, SUUNTO_IDS);
 
-/* Siemens USB/MPI adapter */
-#define SIEMENS_IDS()			\
-	{ USB_DEVICE(0x908, 0x0004) }
-DEVICE(siemens_mpi, SIEMENS_IDS);
+/* ViVOpay USB Serial Driver */
+#define VIVOPAY_IDS()			\
+	{ USB_DEVICE(0x1d5f, 0x1004) }	/* ViVOpay 8800 */
+DEVICE(vivopay, VIVOPAY_IDS);
+
+/* ZIO Motherboard USB driver */
+#define ZIO_IDS()			\
+	{ USB_DEVICE(0x1CBE, 0x0103) }
+DEVICE(zio, ZIO_IDS);
 
 /* All of the above structures mushed into two lists */
 static struct usb_serial_driver * const serial_drivers[] = {
 	&carelink_device,
-	&zio_device,
-	&funsoft_device,
 	&flashloader_device,
+	&funsoft_device,
 	&google_device,
+	&hp4x_device,
+	&kaufmann_device,
 	&libtransistor_device,
-	&vivopay_device,
 	&moto_modem_device,
 	&motorola_tetra_device,
 	&nokia_device,
 	&novatel_gps_device,
-	&hp4x_device,
-	&suunto_device,
 	&siemens_mpi_device,
+	&suunto_device,
+	&vivopay_device,
+	&zio_device,
 	NULL
 };
 
 static const struct usb_device_id id_table[] = {
 	CARELINK_IDS(),
-	ZIO_IDS(),
-	FUNSOFT_IDS(),
 	FLASHLOADER_IDS(),
+	FUNSOFT_IDS(),
 	GOOGLE_IDS(),
+	HP4X_IDS(),
+	KAUFMANN_IDS(),
 	LIBTRANSISTOR_IDS(),
-	VIVOPAY_IDS(),
 	MOTO_IDS(),
 	MOTOROLA_TETRA_IDS(),
 	NOKIA_IDS(),
 	NOVATEL_IDS(),
-	HP4X_IDS(),
-	SUUNTO_IDS(),
 	SIEMENS_IDS(),
+	SUUNTO_IDS(),
+	VIVOPAY_IDS(),
+	ZIO_IDS(),
 	{ },
 };
 MODULE_DEVICE_TABLE(usb, id_table);
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index bd5e5dd70431..3c3bab33e03a 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1258,8 +1258,7 @@ static ssize_t select_usb_power_delivery_show(struct device *dev,
 {
 	struct typec_port *port = to_typec_port(dev);
 	struct usb_power_delivery **pds;
-	struct usb_power_delivery *pd;
-	int ret = 0;
+	int i, ret = 0;
 
 	if (!port->ops || !port->ops->pd_get)
 		return -EOPNOTSUPP;
@@ -1268,11 +1267,11 @@ static ssize_t select_usb_power_delivery_show(struct device *dev,
 	if (!pds)
 		return 0;
 
-	for (pd = pds[0]; pd; pd++) {
-		if (pd == port->pd)
-			ret += sysfs_emit(buf + ret, "[%s] ", dev_name(&pd->dev));
+	for (i = 0; pds[i]; i++) {
+		if (pds[i] == port->pd)
+			ret += sysfs_emit_at(buf, ret, "[%s] ", dev_name(&pds[i]->dev));
 		else
-			ret += sysfs_emit(buf + ret, "%s ", dev_name(&pd->dev));
+			ret += sysfs_emit_at(buf, ret, "%s ", dev_name(&pds[i]->dev));
 	}
 
 	buf[ret - 1] = '\n';
@@ -2259,6 +2258,8 @@ struct typec_port *typec_register_port(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	port->pd = cap->pd;
+
 	ret = device_add(&port->dev);
 	if (ret) {
 		dev_err(parent, "failed to register port (%d)\n", ret);
@@ -2266,7 +2267,7 @@ struct typec_port *typec_register_port(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
-	ret = typec_port_set_usb_power_delivery(port, cap->pd);
+	ret = usb_power_delivery_link_device(port->pd, &port->dev);
 	if (ret) {
 		dev_err(&port->dev, "failed to link pd\n");
 		device_unregister(&port->dev);
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index e1ec725c2819..f13c3b76ad1e 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -498,14 +498,21 @@ static LIST_HEAD(deferred_list);
 static void gnttab_handle_deferred(struct timer_list *);
 static DEFINE_TIMER(deferred_timer, gnttab_handle_deferred);
 
+static atomic64_t deferred_count;
+static atomic64_t leaked_count;
+static unsigned int free_per_iteration = 10;
+module_param(free_per_iteration, uint, 0600);
+
 static void gnttab_handle_deferred(struct timer_list *unused)
 {
-	unsigned int nr = 10;
+	unsigned int nr = READ_ONCE(free_per_iteration);
+	const bool ignore_limit = nr == 0;
 	struct deferred_entry *first = NULL;
 	unsigned long flags;
+	size_t freed = 0;
 
 	spin_lock_irqsave(&gnttab_list_lock, flags);
-	while (nr--) {
+	while ((ignore_limit || nr--) && !list_empty(&deferred_list)) {
 		struct deferred_entry *entry
 			= list_first_entry(&deferred_list,
 					   struct deferred_entry, list);
@@ -515,10 +522,14 @@ static void gnttab_handle_deferred(struct timer_list *unused)
 		list_del(&entry->list);
 		spin_unlock_irqrestore(&gnttab_list_lock, flags);
 		if (_gnttab_end_foreign_access_ref(entry->ref)) {
+			uint64_t ret = atomic64_dec_return(&deferred_count);
+
 			put_free_entry(entry->ref);
-			pr_debug("freeing g.e. %#x (pfn %#lx)\n",
-				 entry->ref, page_to_pfn(entry->page));
+			pr_debug("freeing g.e. %#x (pfn %#lx), %llu remaining\n",
+				 entry->ref, page_to_pfn(entry->page),
+				 (unsigned long long)ret);
 			put_page(entry->page);
+			freed++;
 			kfree(entry);
 			entry = NULL;
 		} else {
@@ -530,21 +541,22 @@ static void gnttab_handle_deferred(struct timer_list *unused)
 		spin_lock_irqsave(&gnttab_list_lock, flags);
 		if (entry)
 			list_add_tail(&entry->list, &deferred_list);
-		else if (list_empty(&deferred_list))
-			break;
 	}
-	if (!list_empty(&deferred_list) && !timer_pending(&deferred_timer)) {
+	if (list_empty(&deferred_list))
+		WARN_ON(atomic64_read(&deferred_count));
+	else if (!timer_pending(&deferred_timer)) {
 		deferred_timer.expires = jiffies + HZ;
 		add_timer(&deferred_timer);
 	}
 	spin_unlock_irqrestore(&gnttab_list_lock, flags);
+	pr_debug("Freed %zu references", freed);
 }
 
 static void gnttab_add_deferred(grant_ref_t ref, struct page *page)
 {
 	struct deferred_entry *entry;
 	gfp_t gfp = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC : GFP_KERNEL;
-	const char *what = KERN_WARNING "leaking";
+	uint64_t leaked, deferred;
 
 	entry = kmalloc(sizeof(*entry), gfp);
 	if (!page) {
@@ -567,10 +579,16 @@ static void gnttab_add_deferred(grant_ref_t ref, struct page *page)
 			add_timer(&deferred_timer);
 		}
 		spin_unlock_irqrestore(&gnttab_list_lock, flags);
-		what = KERN_DEBUG "deferring";
+		deferred = atomic64_inc_return(&deferred_count);
+		leaked = atomic64_read(&leaked_count);
+		pr_debug("deferring g.e. %#x (pfn %#lx) (total deferred %llu, total leaked %llu)\n",
+			 ref, page ? page_to_pfn(page) : -1, deferred, leaked);
+	} else {
+		deferred = atomic64_read(&deferred_count);
+		leaked = atomic64_inc_return(&leaked_count);
+		pr_warn("leaking g.e. %#x (pfn %#lx) (total deferred %llu, total leaked %llu)\n",
+			ref, page ? page_to_pfn(page) : -1, deferred, leaked);
 	}
-	printk("%s g.e. %#x (pfn %#lx)\n",
-	       what, ref, page ? page_to_pfn(page) : -1);
 }
 
 int gnttab_try_end_foreign_access(grant_ref_t ref)
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 58b732dcbfb8..639bf628389b 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -811,6 +811,9 @@ static int xenbus_probe_thread(void *unused)
 
 static int __init xenbus_probe_initcall(void)
 {
+	if (!xen_domain())
+		return -ENODEV;
+
 	/*
 	 * Probe XenBus here in the XS_PV case, and also XS_HVM unless we
 	 * need to wait for the platform PCI device to come up or
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 2044f1e18629..507b44d18572 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -377,6 +377,11 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	}
 	read_unlock(&fs_info->global_root_lock);
 
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
+		num_bytes += btrfs_root_used(&fs_info->block_group_root->root_item);
+		min_items++;
+	}
+
 	/*
 	 * But we also want to reserve enough space so we can do the fallback
 	 * global reserve for an unlink, which is an additional 5 items (see the
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index cacdb2c5d152..26cabffd5971 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1227,12 +1227,23 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	int ret = 0;
 
 	/*
-	 * We need to have subvol_sem write locked, to prevent races between
-	 * concurrent tasks trying to disable quotas, because we will unlock
-	 * and relock qgroup_ioctl_lock across BTRFS_FS_QUOTA_ENABLED changes.
+	 * We need to have subvol_sem write locked to prevent races with
+	 * snapshot creation.
 	 */
 	lockdep_assert_held_write(&fs_info->subvol_sem);
 
+	/*
+	 * Lock the cleaner mutex to prevent races with concurrent relocation,
+	 * because relocation may be building backrefs for blocks of the quota
+	 * root while we are deleting the root. This is like dropping fs roots
+	 * of deleted snapshots/subvolumes, we need the same protection.
+	 *
+	 * This also prevents races between concurrent tasks trying to disable
+	 * quotas, because we will unlock and relock qgroup_ioctl_lock across
+	 * BTRFS_FS_QUOTA_ENABLED changes.
+	 */
+	mutex_lock(&fs_info->cleaner_mutex);
+
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root)
 		goto out;
@@ -1314,6 +1325,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 		btrfs_end_transaction(trans);
 	else if (trans)
 		ret = btrfs_end_transaction(trans);
+	mutex_unlock(&fs_info->cleaner_mutex);
 
 	return ret;
 }
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 682b463a7633..2b776fce1c0f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -814,8 +814,13 @@ btrfs_attach_transaction_barrier(struct btrfs_root *root)
 
 	trans = start_transaction(root, 0, TRANS_ATTACH,
 				  BTRFS_RESERVE_NO_FLUSH, true);
-	if (trans == ERR_PTR(-ENOENT))
-		btrfs_wait_for_commit(root->fs_info, 0);
+	if (trans == ERR_PTR(-ENOENT)) {
+		int ret;
+
+		ret = btrfs_wait_for_commit(root->fs_info, 0);
+		if (ret)
+			return ERR_PTR(ret);
+	}
 
 	return trans;
 }
@@ -919,6 +924,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid)
 	}
 
 	wait_for_commit(cur_trans, TRANS_STATE_COMPLETED);
+	ret = cur_trans->aborted;
 	btrfs_put_transaction(cur_trans);
 out:
 	return ret;
diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
index c47347d2e84e..9560b7bc6009 100644
--- a/fs/ceph/metric.c
+++ b/fs/ceph/metric.c
@@ -208,7 +208,7 @@ static void metric_delayed_work(struct work_struct *work)
 	struct ceph_mds_client *mdsc =
 		container_of(m, struct ceph_mds_client, metric);
 
-	if (mdsc->stopping)
+	if (mdsc->stopping || disable_send_metrics)
 		return;
 
 	if (!m->session || !check_session_state(m->session)) {
diff --git a/fs/file.c b/fs/file.c
index 7893ea161d77..35c62b54c9d6 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1042,10 +1042,8 @@ unsigned long __fdget_pos(unsigned int fd)
 	struct file *file = (struct file *)(v & ~3);
 
 	if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
-		if (file_count(file) > 1) {
-			v |= FDPUT_POS_UNLOCK;
-			mutex_lock(&file->f_pos_lock);
-		}
+		v |= FDPUT_POS_UNLOCK;
+		mutex_lock(&file->f_pos_lock);
 	}
 	return v;
 }
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 25e3c20eb19f..c4e0da6db719 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -221,20 +221,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		jh = transaction->t_checkpoint_list;
 		bh = jh2bh(jh);
 
-		/*
-		 * The buffer may be writing back, or flushing out in the
-		 * last couple of cycles, or re-adding into a new transaction,
-		 * need to check it again until it's unlocked.
-		 */
-		if (buffer_locked(bh)) {
-			get_bh(bh);
-			spin_unlock(&journal->j_list_lock);
-			wait_on_buffer(bh);
-			/* the journal_head may have gone by now */
-			BUFFER_TRACE(bh, "brelse");
-			__brelse(bh);
-			goto retry;
-		}
 		if (jh->b_transaction != NULL) {
 			transaction_t *t = jh->b_transaction;
 			tid_t tid = t->t_tid;
@@ -269,7 +255,22 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			spin_lock(&journal->j_list_lock);
 			goto restart;
 		}
-		if (!buffer_dirty(bh)) {
+		if (!trylock_buffer(bh)) {
+			/*
+			 * The buffer is locked, it may be writing back, or
+			 * flushing out in the last couple of cycles, or
+			 * re-adding into a new transaction, need to check
+			 * it again until it's unlocked.
+			 */
+			get_bh(bh);
+			spin_unlock(&journal->j_list_lock);
+			wait_on_buffer(bh);
+			/* the journal_head may have gone by now */
+			BUFFER_TRACE(bh, "brelse");
+			__brelse(bh);
+			goto retry;
+		} else if (!buffer_dirty(bh)) {
+			unlock_buffer(bh);
 			BUFFER_TRACE(bh, "remove from checkpoint");
 			/*
 			 * If the transaction was released or the checkpoint
@@ -279,6 +280,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			    !transaction->t_checkpoint_list)
 				goto out;
 		} else {
+			unlock_buffer(bh);
 			/*
 			 * We are about to write the buffer, it could be
 			 * raced by some other transaction shrink or buffer
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 34561764e5c9..c5dc0cd6f703 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6269,8 +6269,6 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return status;
-	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid))
-		return status;
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s)
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 677649b34965..c062f7e2ecb5 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -286,8 +286,8 @@ int ovl_permission(struct user_namespace *mnt_userns,
 	int err;
 
 	/* Careful in RCU walk mode */
-	ovl_i_path_real(inode, &realpath);
-	if (!realpath.dentry) {
+	realinode = ovl_i_path_real(inode, &realpath);
+	if (!realinode) {
 		WARN_ON(!(mask & MAY_NOT_BLOCK));
 		return -ECHILD;
 	}
@@ -300,7 +300,6 @@ int ovl_permission(struct user_namespace *mnt_userns,
 	if (err)
 		return err;
 
-	realinode = d_inode(realpath.dentry);
 	old_cred = ovl_override_creds(inode->i_sb);
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 5aa527ca6dbe..1ec0647a2026 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -132,7 +132,7 @@ ssize_t read_from_oldmem(struct iov_iter *iter, size_t count,
 			 u64 *ppos, bool encrypted)
 {
 	unsigned long pfn, offset;
-	size_t nr_bytes;
+	ssize_t nr_bytes;
 	ssize_t read = 0, tmp;
 	int idx;
 
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 81be17845072..1e3e22979604 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -1014,6 +1014,7 @@ int build_ntlmssp_smb3_negotiate_blob(unsigned char **pbuffer,
 }
 
 
+/* See MS-NLMP 2.2.1.3 */
 int build_ntlmssp_auth_blob(unsigned char **pbuffer,
 					u16 *buflen,
 				   struct cifs_ses *ses,
@@ -1048,7 +1049,8 @@ int build_ntlmssp_auth_blob(unsigned char **pbuffer,
 
 	flags = ses->ntlmssp->server_flags | NTLMSSP_REQUEST_TARGET |
 		NTLMSSP_NEGOTIATE_TARGET_INFO | NTLMSSP_NEGOTIATE_WORKSTATION_SUPPLIED;
-
+	/* we only send version information in ntlmssp negotiate, so do not set this flag */
+	flags = flags & ~NTLMSSP_NEGOTIATE_VERSION;
 	tmp = *pbuffer + sizeof(AUTHENTICATE_MESSAGE);
 	sec_blob->NegotiateFlags = cpu_to_le32(flags);
 
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 775cdc0b4f24..be572c3a4dcd 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -584,7 +584,7 @@ static inline signed long dma_fence_wait(struct dma_fence *fence, bool intr)
 }
 
 struct dma_fence *dma_fence_get_stub(void);
-struct dma_fence *dma_fence_allocate_private_stub(void);
+struct dma_fence *dma_fence_allocate_private_stub(ktime_t timestamp);
 u64 dma_fence_context_alloc(unsigned num);
 
 extern const struct dma_fence_ops dma_fence_array_ops;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 4de09163c968..161e91167b9c 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -478,6 +478,11 @@ static inline int pwmchip_remove(struct pwm_chip *chip)
 	return -EINVAL;
 }
 
+static inline int devm_pwmchip_add(struct device *dev, struct pwm_chip *chip)
+{
+	return -EINVAL;
+}
+
 static inline struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 						       unsigned int index,
 						       const char *label)
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index d383c895592a..e4ceef687c1c 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -718,12 +718,8 @@ static inline u32 ipv6_addr_hash(const struct in6_addr *a)
 /* more secured version of ipv6_addr_hash() */
 static inline u32 __ipv6_addr_jhash(const struct in6_addr *a, const u32 initval)
 {
-	u32 v = (__force u32)a->s6_addr32[0] ^ (__force u32)a->s6_addr32[1];
-
-	return jhash_3words(v,
-			    (__force u32)a->s6_addr32[2],
-			    (__force u32)a->s6_addr32[3],
-			    initval);
+	return jhash2((__force const u32 *)a->s6_addr32,
+		      ARRAY_SIZE(a->s6_addr32), initval);
 }
 
 static inline bool ipv6_addr_loopback(const struct in6_addr *a)
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index bca5b01af247..03bcc1ef0d61 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -378,10 +378,15 @@ static inline netdev_features_t vxlan_features_check(struct sk_buff *skb,
 	return features;
 }
 
-/* IP header + UDP + VXLAN + Ethernet header */
-#define VXLAN_HEADROOM (20 + 8 + 8 + 14)
-/* IPv6 header + UDP + VXLAN + Ethernet header */
-#define VXLAN6_HEADROOM (40 + 8 + 8 + 14)
+static inline int vxlan_headroom(u32 flags)
+{
+	/* VXLAN:     IP4/6 header + UDP + VXLAN + Ethernet header */
+	/* VXLAN-GPE: IP4/6 header + UDP + VXLAN */
+	return (flags & VXLAN_F_IPV6 ? sizeof(struct ipv6hdr) :
+				       sizeof(struct iphdr)) +
+	       sizeof(struct udphdr) + sizeof(struct vxlanhdr) +
+	       (flags & VXLAN_F_GPE ? 0 : ETH_HLEN);
+}
 
 static inline struct vxlanhdr *vxlan_hdr(struct sk_buff *skb)
 {
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index b80fcc9ea525..f85743ef6e7d 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -51,13 +51,13 @@ enum blk_zone_type {
  *
  * The Zone Condition state machine in the ZBC/ZAC standards maps the above
  * deinitions as:
- *   - ZC1: Empty         | BLK_ZONE_EMPTY
+ *   - ZC1: Empty         | BLK_ZONE_COND_EMPTY
  *   - ZC2: Implicit Open | BLK_ZONE_COND_IMP_OPEN
  *   - ZC3: Explicit Open | BLK_ZONE_COND_EXP_OPEN
- *   - ZC4: Closed        | BLK_ZONE_CLOSED
- *   - ZC5: Full          | BLK_ZONE_FULL
- *   - ZC6: Read Only     | BLK_ZONE_READONLY
- *   - ZC7: Offline       | BLK_ZONE_OFFLINE
+ *   - ZC4: Closed        | BLK_ZONE_COND_CLOSED
+ *   - ZC5: Full          | BLK_ZONE_COND_FULL
+ *   - ZC6: Read Only     | BLK_ZONE_COND_READONLY
+ *   - ZC7: Offline       | BLK_ZONE_COND_OFFLINE
  *
  * Conditions 0x5 to 0xC are reserved by the current ZBC/ZAC spec and should
  * be considered invalid.
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index bd7b8cf8bc67..f091153bc854 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3477,7 +3477,7 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
 		ctx->syscall_iopoll = 1;
 
 	ctx->compat = in_compat_syscall();
-	if (!capable(CAP_IPC_LOCK))
+	if (!ns_capable_noaudit(&init_user_ns, CAP_IPC_LOCK))
 		ctx->user = get_uid(current_user());
 
 	/*
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 728f434de2bb..21db0df0eb00 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -333,21 +333,43 @@ static __always_inline int __waiter_prio(struct task_struct *task)
 	return prio;
 }
 
+/*
+ * Update the waiter->tree copy of the sort keys.
+ */
 static __always_inline void
 waiter_update_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
 {
-	waiter->prio = __waiter_prio(task);
-	waiter->deadline = task->dl.deadline;
+	lockdep_assert_held(&waiter->lock->wait_lock);
+	lockdep_assert(RB_EMPTY_NODE(&waiter->tree.entry));
+
+	waiter->tree.prio = __waiter_prio(task);
+	waiter->tree.deadline = task->dl.deadline;
+}
+
+/*
+ * Update the waiter->pi_tree copy of the sort keys (from the tree copy).
+ */
+static __always_inline void
+waiter_clone_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
+{
+	lockdep_assert_held(&waiter->lock->wait_lock);
+	lockdep_assert_held(&task->pi_lock);
+	lockdep_assert(RB_EMPTY_NODE(&waiter->pi_tree.entry));
+
+	waiter->pi_tree.prio = waiter->tree.prio;
+	waiter->pi_tree.deadline = waiter->tree.deadline;
 }
 
 /*
- * Only use with rt_mutex_waiter_{less,equal}()
+ * Only use with rt_waiter_node_{less,equal}()
  */
+#define task_to_waiter_node(p)	\
+	&(struct rt_waiter_node){ .prio = __waiter_prio(p), .deadline = (p)->dl.deadline }
 #define task_to_waiter(p)	\
-	&(struct rt_mutex_waiter){ .prio = __waiter_prio(p), .deadline = (p)->dl.deadline }
+	&(struct rt_mutex_waiter){ .tree = *task_to_waiter_node(p) }
 
-static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
-						struct rt_mutex_waiter *right)
+static __always_inline int rt_waiter_node_less(struct rt_waiter_node *left,
+					       struct rt_waiter_node *right)
 {
 	if (left->prio < right->prio)
 		return 1;
@@ -364,8 +386,8 @@ static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
 	return 0;
 }
 
-static __always_inline int rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
-						 struct rt_mutex_waiter *right)
+static __always_inline int rt_waiter_node_equal(struct rt_waiter_node *left,
+						 struct rt_waiter_node *right)
 {
 	if (left->prio != right->prio)
 		return 0;
@@ -385,7 +407,7 @@ static __always_inline int rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
 static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
 				  struct rt_mutex_waiter *top_waiter)
 {
-	if (rt_mutex_waiter_less(waiter, top_waiter))
+	if (rt_waiter_node_less(&waiter->tree, &top_waiter->tree))
 		return true;
 
 #ifdef RT_MUTEX_BUILD_SPINLOCKS
@@ -393,30 +415,30 @@ static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
 	 * Note that RT tasks are excluded from same priority (lateral)
 	 * steals to prevent the introduction of an unbounded latency.
 	 */
-	if (rt_prio(waiter->prio) || dl_prio(waiter->prio))
+	if (rt_prio(waiter->tree.prio) || dl_prio(waiter->tree.prio))
 		return false;
 
-	return rt_mutex_waiter_equal(waiter, top_waiter);
+	return rt_waiter_node_equal(&waiter->tree, &top_waiter->tree);
 #else
 	return false;
 #endif
 }
 
 #define __node_2_waiter(node) \
-	rb_entry((node), struct rt_mutex_waiter, tree_entry)
+	rb_entry((node), struct rt_mutex_waiter, tree.entry)
 
 static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_node *b)
 {
 	struct rt_mutex_waiter *aw = __node_2_waiter(a);
 	struct rt_mutex_waiter *bw = __node_2_waiter(b);
 
-	if (rt_mutex_waiter_less(aw, bw))
+	if (rt_waiter_node_less(&aw->tree, &bw->tree))
 		return 1;
 
 	if (!build_ww_mutex())
 		return 0;
 
-	if (rt_mutex_waiter_less(bw, aw))
+	if (rt_waiter_node_less(&bw->tree, &aw->tree))
 		return 0;
 
 	/* NOTE: relies on waiter->ww_ctx being set before insertion */
@@ -434,48 +456,58 @@ static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_nod
 static __always_inline void
 rt_mutex_enqueue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
-	rb_add_cached(&waiter->tree_entry, &lock->waiters, __waiter_less);
+	lockdep_assert_held(&lock->wait_lock);
+
+	rb_add_cached(&waiter->tree.entry, &lock->waiters, __waiter_less);
 }
 
 static __always_inline void
 rt_mutex_dequeue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
-	if (RB_EMPTY_NODE(&waiter->tree_entry))
+	lockdep_assert_held(&lock->wait_lock);
+
+	if (RB_EMPTY_NODE(&waiter->tree.entry))
 		return;
 
-	rb_erase_cached(&waiter->tree_entry, &lock->waiters);
-	RB_CLEAR_NODE(&waiter->tree_entry);
+	rb_erase_cached(&waiter->tree.entry, &lock->waiters);
+	RB_CLEAR_NODE(&waiter->tree.entry);
 }
 
-#define __node_2_pi_waiter(node) \
-	rb_entry((node), struct rt_mutex_waiter, pi_tree_entry)
+#define __node_2_rt_node(node) \
+	rb_entry((node), struct rt_waiter_node, entry)
 
-static __always_inline bool
-__pi_waiter_less(struct rb_node *a, const struct rb_node *b)
+static __always_inline bool __pi_waiter_less(struct rb_node *a, const struct rb_node *b)
 {
-	return rt_mutex_waiter_less(__node_2_pi_waiter(a), __node_2_pi_waiter(b));
+	return rt_waiter_node_less(__node_2_rt_node(a), __node_2_rt_node(b));
 }
 
 static __always_inline void
 rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 {
-	rb_add_cached(&waiter->pi_tree_entry, &task->pi_waiters, __pi_waiter_less);
+	lockdep_assert_held(&task->pi_lock);
+
+	rb_add_cached(&waiter->pi_tree.entry, &task->pi_waiters, __pi_waiter_less);
 }
 
 static __always_inline void
 rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 {
-	if (RB_EMPTY_NODE(&waiter->pi_tree_entry))
+	lockdep_assert_held(&task->pi_lock);
+
+	if (RB_EMPTY_NODE(&waiter->pi_tree.entry))
 		return;
 
-	rb_erase_cached(&waiter->pi_tree_entry, &task->pi_waiters);
-	RB_CLEAR_NODE(&waiter->pi_tree_entry);
+	rb_erase_cached(&waiter->pi_tree.entry, &task->pi_waiters);
+	RB_CLEAR_NODE(&waiter->pi_tree.entry);
 }
 
-static __always_inline void rt_mutex_adjust_prio(struct task_struct *p)
+static __always_inline void rt_mutex_adjust_prio(struct rt_mutex_base *lock,
+						 struct task_struct *p)
 {
 	struct task_struct *pi_task = NULL;
 
+	lockdep_assert_held(&lock->wait_lock);
+	lockdep_assert(rt_mutex_owner(lock) == p);
 	lockdep_assert_held(&p->pi_lock);
 
 	if (task_has_pi_waiters(p))
@@ -571,9 +603,14 @@ static __always_inline struct rt_mutex_base *task_blocked_on_lock(struct task_st
  * Chain walk basics and protection scope
  *
  * [R] refcount on task
- * [P] task->pi_lock held
+ * [Pn] task->pi_lock held
  * [L] rtmutex->wait_lock held
  *
+ * Normal locking order:
+ *
+ *   rtmutex->wait_lock
+ *     task->pi_lock
+ *
  * Step	Description				Protected by
  *	function arguments:
  *	@task					[R]
@@ -588,27 +625,32 @@ static __always_inline struct rt_mutex_base *task_blocked_on_lock(struct task_st
  *	again:
  *	  loop_sanity_check();
  *	retry:
- * [1]	  lock(task->pi_lock);			[R] acquire [P]
- * [2]	  waiter = task->pi_blocked_on;		[P]
- * [3]	  check_exit_conditions_1();		[P]
- * [4]	  lock = waiter->lock;			[P]
- * [5]	  if (!try_lock(lock->wait_lock)) {	[P] try to acquire [L]
- *	    unlock(task->pi_lock);		release [P]
+ * [1]	  lock(task->pi_lock);			[R] acquire [P1]
+ * [2]	  waiter = task->pi_blocked_on;		[P1]
+ * [3]	  check_exit_conditions_1();		[P1]
+ * [4]	  lock = waiter->lock;			[P1]
+ * [5]	  if (!try_lock(lock->wait_lock)) {	[P1] try to acquire [L]
+ *	    unlock(task->pi_lock);		release [P1]
  *	    goto retry;
  *	  }
- * [6]	  check_exit_conditions_2();		[P] + [L]
- * [7]	  requeue_lock_waiter(lock, waiter);	[P] + [L]
- * [8]	  unlock(task->pi_lock);		release [P]
+ * [6]	  check_exit_conditions_2();		[P1] + [L]
+ * [7]	  requeue_lock_waiter(lock, waiter);	[P1] + [L]
+ * [8]	  unlock(task->pi_lock);		release [P1]
  *	  put_task_struct(task);		release [R]
  * [9]	  check_exit_conditions_3();		[L]
  * [10]	  task = owner(lock);			[L]
  *	  get_task_struct(task);		[L] acquire [R]
- *	  lock(task->pi_lock);			[L] acquire [P]
- * [11]	  requeue_pi_waiter(tsk, waiters(lock));[P] + [L]
- * [12]	  check_exit_conditions_4();		[P] + [L]
- * [13]	  unlock(task->pi_lock);		release [P]
+ *	  lock(task->pi_lock);			[L] acquire [P2]
+ * [11]	  requeue_pi_waiter(tsk, waiters(lock));[P2] + [L]
+ * [12]	  check_exit_conditions_4();		[P2] + [L]
+ * [13]	  unlock(task->pi_lock);		release [P2]
  *	  unlock(lock->wait_lock);		release [L]
  *	  goto again;
+ *
+ * Where P1 is the blocking task and P2 is the lock owner; going up one step
+ * the owner becomes the next blocked task etc..
+ *
+*
  */
 static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 					      enum rtmutex_chainwalk chwalk,
@@ -756,7 +798,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * enabled we continue, but stop the requeueing in the chain
 	 * walk.
 	 */
-	if (rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task))) {
 		if (!detect_deadlock)
 			goto out_unlock_pi;
 		else
@@ -764,13 +806,18 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	}
 
 	/*
-	 * [4] Get the next lock
+	 * [4] Get the next lock; per holding task->pi_lock we can't unblock
+	 * and guarantee @lock's existence.
 	 */
 	lock = waiter->lock;
 	/*
 	 * [5] We need to trylock here as we are holding task->pi_lock,
 	 * which is the reverse lock order versus the other rtmutex
 	 * operations.
+	 *
+	 * Per the above, holding task->pi_lock guarantees lock exists, so
+	 * inverting this lock order is infeasible from a life-time
+	 * perspective.
 	 */
 	if (!raw_spin_trylock(&lock->wait_lock)) {
 		raw_spin_unlock_irq(&task->pi_lock);
@@ -874,17 +921,18 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * or
 	 *
 	 *   DL CBS enforcement advancing the effective deadline.
-	 *
-	 * Even though pi_waiters also uses these fields, and that tree is only
-	 * updated in [11], we can do this here, since we hold [L], which
-	 * serializes all pi_waiters access and rb_erase() does not care about
-	 * the values of the node being removed.
 	 */
 	waiter_update_prio(waiter, task);
 
 	rt_mutex_enqueue(lock, waiter);
 
-	/* [8] Release the task */
+	/*
+	 * [8] Release the (blocking) task in preparation for
+	 * taking the owner task in [10].
+	 *
+	 * Since we hold lock->waiter_lock, task cannot unblock, even if we
+	 * release task->pi_lock.
+	 */
 	raw_spin_unlock(&task->pi_lock);
 	put_task_struct(task);
 
@@ -908,7 +956,12 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		return 0;
 	}
 
-	/* [10] Grab the next task, i.e. the owner of @lock */
+	/*
+	 * [10] Grab the next task, i.e. the owner of @lock
+	 *
+	 * Per holding lock->wait_lock and checking for !owner above, there
+	 * must be an owner and it cannot go away.
+	 */
 	task = get_task_struct(rt_mutex_owner(lock));
 	raw_spin_lock(&task->pi_lock);
 
@@ -921,8 +974,9 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * and adjust the priority of the owner.
 		 */
 		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
+		waiter_clone_prio(waiter, task);
 		rt_mutex_enqueue_pi(task, waiter);
-		rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(lock, task);
 
 	} else if (prerequeue_top_waiter == waiter) {
 		/*
@@ -937,8 +991,9 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 */
 		rt_mutex_dequeue_pi(task, waiter);
 		waiter = rt_mutex_top_waiter(lock);
+		waiter_clone_prio(waiter, task);
 		rt_mutex_enqueue_pi(task, waiter);
-		rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(lock, task);
 	} else {
 		/*
 		 * Nothing changed. No need to do any priority
@@ -1154,6 +1209,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter_update_prio(waiter, task);
+	waiter_clone_prio(waiter, task);
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
@@ -1187,7 +1243,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 		rt_mutex_dequeue_pi(owner, top_waiter);
 		rt_mutex_enqueue_pi(owner, waiter);
 
-		rt_mutex_adjust_prio(owner);
+		rt_mutex_adjust_prio(lock, owner);
 		if (owner->pi_blocked_on)
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
@@ -1234,6 +1290,8 @@ static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 {
 	struct rt_mutex_waiter *waiter;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	raw_spin_lock(&current->pi_lock);
 
 	waiter = rt_mutex_top_waiter(lock);
@@ -1246,7 +1304,7 @@ static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 	 * task unblocks.
 	 */
 	rt_mutex_dequeue_pi(current, waiter);
-	rt_mutex_adjust_prio(current);
+	rt_mutex_adjust_prio(lock, current);
 
 	/*
 	 * As we are waking up the top waiter, and the waiter stays
@@ -1482,7 +1540,7 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 	if (rt_mutex_has_waiters(lock))
 		rt_mutex_enqueue_pi(owner, rt_mutex_top_waiter(lock));
 
-	rt_mutex_adjust_prio(owner);
+	rt_mutex_adjust_prio(lock, owner);
 
 	/* Store the lock on which owner is blocked or NULL */
 	next_lock = task_blocked_on_lock(owner);
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index cb9fdff76a8a..a6974d044593 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -459,7 +459,7 @@ void __sched rt_mutex_adjust_pi(struct task_struct *task)
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
 	waiter = task->pi_blocked_on;
-	if (!waiter || rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (!waiter || rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task))) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		return;
 	}
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index c47e8361bfb5..1162e07cdaea 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -17,27 +17,44 @@
 #include <linux/rtmutex.h>
 #include <linux/sched/wake_q.h>
 
+
+/*
+ * This is a helper for the struct rt_mutex_waiter below. A waiter goes in two
+ * separate trees and they need their own copy of the sort keys because of
+ * different locking requirements.
+ *
+ * @entry:		rbtree node to enqueue into the waiters tree
+ * @prio:		Priority of the waiter
+ * @deadline:		Deadline of the waiter if applicable
+ *
+ * See rt_waiter_node_less() and waiter_*_prio().
+ */
+struct rt_waiter_node {
+	struct rb_node	entry;
+	int		prio;
+	u64		deadline;
+};
+
 /*
  * This is the control structure for tasks blocked on a rt_mutex,
  * which is allocated on the kernel stack on of the blocked task.
  *
- * @tree_entry:		pi node to enqueue into the mutex waiters tree
- * @pi_tree_entry:	pi node to enqueue into the mutex owner waiters tree
+ * @tree:		node to enqueue into the mutex waiters tree
+ * @pi_tree:		node to enqueue into the mutex owner waiters tree
  * @task:		task reference to the blocked task
  * @lock:		Pointer to the rt_mutex on which the waiter blocks
  * @wake_state:		Wakeup state to use (TASK_NORMAL or TASK_RTLOCK_WAIT)
- * @prio:		Priority of the waiter
- * @deadline:		Deadline of the waiter if applicable
  * @ww_ctx:		WW context pointer
+ *
+ * @tree is ordered by @lock->wait_lock
+ * @pi_tree is ordered by rt_mutex_owner(@lock)->pi_lock
  */
 struct rt_mutex_waiter {
-	struct rb_node		tree_entry;
-	struct rb_node		pi_tree_entry;
+	struct rt_waiter_node	tree;
+	struct rt_waiter_node	pi_tree;
 	struct task_struct	*task;
 	struct rt_mutex_base	*lock;
 	unsigned int		wake_state;
-	int			prio;
-	u64			deadline;
 	struct ww_acquire_ctx	*ww_ctx;
 };
 
@@ -105,7 +122,7 @@ static inline bool rt_mutex_waiter_is_top_waiter(struct rt_mutex_base *lock,
 {
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
 
-	return rb_entry(leftmost, struct rt_mutex_waiter, tree_entry) == waiter;
+	return rb_entry(leftmost, struct rt_mutex_waiter, tree.entry) == waiter;
 }
 
 static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *lock)
@@ -113,8 +130,10 @@ static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
 	struct rt_mutex_waiter *w = NULL;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	if (leftmost) {
-		w = rb_entry(leftmost, struct rt_mutex_waiter, tree_entry);
+		w = rb_entry(leftmost, struct rt_mutex_waiter, tree.entry);
 		BUG_ON(w->lock != lock);
 	}
 	return w;
@@ -127,8 +146,10 @@ static inline int task_has_pi_waiters(struct task_struct *p)
 
 static inline struct rt_mutex_waiter *task_top_pi_waiter(struct task_struct *p)
 {
+	lockdep_assert_held(&p->pi_lock);
+
 	return rb_entry(p->pi_waiters.rb_leftmost, struct rt_mutex_waiter,
-			pi_tree_entry);
+			pi_tree.entry);
 }
 
 #define RT_MUTEX_HAS_WAITERS	1UL
@@ -190,8 +211,8 @@ static inline void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
 static inline void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 {
 	debug_rt_mutex_init_waiter(waiter);
-	RB_CLEAR_NODE(&waiter->pi_tree_entry);
-	RB_CLEAR_NODE(&waiter->tree_entry);
+	RB_CLEAR_NODE(&waiter->pi_tree.entry);
+	RB_CLEAR_NODE(&waiter->tree.entry);
 	waiter->wake_state = TASK_NORMAL;
 	waiter->task = NULL;
 }
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 56f139201f24..3ad2cc4823e5 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -96,25 +96,25 @@ __ww_waiter_first(struct rt_mutex *lock)
 	struct rb_node *n = rb_first(&lock->rtmutex.waiters.rb_root);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline struct rt_mutex_waiter *
 __ww_waiter_next(struct rt_mutex *lock, struct rt_mutex_waiter *w)
 {
-	struct rb_node *n = rb_next(&w->tree_entry);
+	struct rb_node *n = rb_next(&w->tree.entry);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline struct rt_mutex_waiter *
 __ww_waiter_prev(struct rt_mutex *lock, struct rt_mutex_waiter *w)
 {
-	struct rb_node *n = rb_prev(&w->tree_entry);
+	struct rb_node *n = rb_prev(&w->tree.entry);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline struct rt_mutex_waiter *
@@ -123,7 +123,7 @@ __ww_waiter_last(struct rt_mutex *lock)
 	struct rb_node *n = rb_last(&lock->rtmutex.waiters.rb_root);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline void
diff --git a/kernel/signal.c b/kernel/signal.c
index d140672185a4..5d45f5da2b36 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -561,6 +561,10 @@ bool unhandled_signal(struct task_struct *tsk, int sig)
 	if (handler != SIG_IGN && handler != SIG_DFL)
 		return false;
 
+	/* If dying, we handle all new signals by ignoring them */
+	if (fatal_signal_pending(tsk))
+		return false;
+
 	/* if ptraced, let the tracer determine */
 	return !tsk->ptrace;
 }
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c264421c4ecd..c49ed619a64d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -529,6 +529,8 @@ struct ring_buffer_per_cpu {
 	rb_time_t			before_stamp;
 	u64				event_stamp[MAX_NEST];
 	u64				read_stamp;
+	/* pages removed since last reset */
+	unsigned long			pages_removed;
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -564,6 +566,7 @@ struct ring_buffer_iter {
 	struct buffer_page		*head_page;
 	struct buffer_page		*cache_reader_page;
 	unsigned long			cache_read;
+	unsigned long			cache_pages_removed;
 	u64				read_stamp;
 	u64				page_stamp;
 	struct ring_buffer_event	*event;
@@ -1967,6 +1970,8 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		to_remove = rb_list_head(to_remove)->next;
 		head_bit |= (unsigned long)to_remove & RB_PAGE_HEAD;
 	}
+	/* Read iterators need to reset themselves when some pages removed */
+	cpu_buffer->pages_removed += nr_removed;
 
 	next_page = rb_list_head(to_remove)->next;
 
@@ -1988,12 +1993,6 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		cpu_buffer->head_page = list_entry(next_page,
 						struct buffer_page, list);
 
-	/*
-	 * change read pointer to make sure any read iterators reset
-	 * themselves
-	 */
-	cpu_buffer->read = 0;
-
 	/* pages are removed, resume tracing and then free the pages */
 	atomic_dec(&cpu_buffer->record_disabled);
 	raw_spin_unlock_irq(&cpu_buffer->reader_lock);
@@ -4385,6 +4384,7 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 
 	iter->cache_reader_page = iter->head_page;
 	iter->cache_read = cpu_buffer->read;
+	iter->cache_pages_removed = cpu_buffer->pages_removed;
 
 	if (iter->head) {
 		iter->read_stamp = cpu_buffer->read_stamp;
@@ -4841,12 +4841,13 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	buffer = cpu_buffer->buffer;
 
 	/*
-	 * Check if someone performed a consuming read to
-	 * the buffer. A consuming read invalidates the iterator
-	 * and we need to reset the iterator in this case.
+	 * Check if someone performed a consuming read to the buffer
+	 * or removed some pages from the buffer. In these cases,
+	 * iterator was invalidated and we need to reset it.
 	 */
 	if (unlikely(iter->cache_read != cpu_buffer->read ||
-		     iter->cache_reader_page != cpu_buffer->reader_page))
+		     iter->cache_reader_page != cpu_buffer->reader_page ||
+		     iter->cache_pages_removed != cpu_buffer->pages_removed))
 		rb_iter_reset(iter);
 
  again:
@@ -5291,6 +5292,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->last_overrun = 0;
 
 	rb_head_page_activate(cpu_buffer);
+	cpu_buffer->pages_removed = 0;
 }
 
 /* Must have disabled the cpu buffer then done a synchronize_rcu */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 27bbe180a2ef..709af9631be4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5627,7 +5627,7 @@ static const char readme_msg[] =
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
-	"\t           <type>\\[<array-size>\\]\n"
+	"\t           symstr, <type>\\[<array-size>\\]\n"
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t    field: <stype> <name>;\n"
 	"\t    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,\n"
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index ac7af03ce837..3d3505286aa7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -113,6 +113,12 @@ enum trace_type {
 #define MEM_FAIL(condition, fmt, ...)					\
 	DO_ONCE_LITE_IF(condition, pr_err, "ERROR: " fmt, ##__VA_ARGS__)
 
+#define FAULT_STRING "(fault)"
+
+#define HIST_STACKTRACE_DEPTH	16
+#define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsigned long))
+#define HIST_STACKTRACE_SKIP	5
+
 /*
  * syscalls are special, and need special handling, this is why
  * they are not included in trace_entries.h
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e67923986496..0447c46ef4d7 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -609,7 +609,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
-	unsigned long file_flags = file->flags;
 	int ret = 0;
 	int disable;
 
@@ -633,6 +632,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				break;
 			disable = file->flags & EVENT_FILE_FL_SOFT_DISABLED;
 			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Disable use of trace_buffered_event */
+			trace_buffered_event_disable();
 		} else
 			disable = !(file->flags & EVENT_FILE_FL_SOFT_MODE);
 
@@ -671,6 +672,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 			if (atomic_inc_return(&file->sm_ref) > 1)
 				break;
 			set_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Enable use of trace_buffered_event */
+			trace_buffered_event_enable();
 		}
 
 		if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
@@ -710,15 +713,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		break;
 	}
 
-	/* Enable or disable use of trace_buffered_event */
-	if ((file_flags & EVENT_FILE_FL_SOFT_DISABLED) !=
-	    (file->flags & EVENT_FILE_FL_SOFT_DISABLED)) {
-		if (file->flags & EVENT_FILE_FL_SOFT_DISABLED)
-			trace_buffered_event_enable();
-		else
-			trace_buffered_event_disable();
-	}
-
 	return ret;
 }
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0f5d16eabd3b..1470af219073 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -479,10 +479,6 @@ DEFINE_HIST_FIELD_FN(u8);
 #define for_each_hist_key_field(i, hist_data)	\
 	for ((i) = (hist_data)->n_vals; (i) < (hist_data)->n_fields; (i)++)
 
-#define HIST_STACKTRACE_DEPTH	16
-#define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsigned long))
-#define HIST_STACKTRACE_SKIP	5
-
 #define HITCOUNT_IDX		0
 #define HIST_KEY_SIZE_MAX	(MAX_FILTER_STR_VAL + HIST_STACKTRACE_SIZE)
 
@@ -3843,6 +3839,9 @@ static int check_synth_field(struct synth_event *event,
 	    && field->is_dynamic)
 		return 0;
 
+	if (strstr(hist_field->type, "long[") && field->is_stack)
+		return 0;
+
 	if (strcmp(field->type, hist_field->type) != 0) {
 		if (field->size != hist_field->size ||
 		    (!field->is_string && field->is_signed != hist_field->is_signed))
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 89083ae1aebe..b0d3876c96ab 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -184,6 +184,14 @@ static int synth_field_is_string(char *type)
 	return false;
 }
 
+static int synth_field_is_stack(char *type)
+{
+	if (strstr(type, "long[") != NULL)
+		return true;
+
+	return false;
+}
+
 static int synth_field_string_size(char *type)
 {
 	char buf[4], *end, *start;
@@ -259,6 +267,8 @@ static int synth_field_size(char *type)
 		size = sizeof(gfp_t);
 	else if (synth_field_is_string(type))
 		size = synth_field_string_size(type);
+	else if (synth_field_is_stack(type))
+		size = 0;
 
 	return size;
 }
@@ -303,6 +313,8 @@ static const char *synth_field_fmt(char *type)
 		fmt = "%x";
 	else if (synth_field_is_string(type))
 		fmt = "%.*s";
+	else if (synth_field_is_stack(type))
+		fmt = "%s";
 
 	return fmt;
 }
@@ -382,6 +394,23 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 			}
+		} else if (se->fields[i]->is_stack) {
+			u32 offset, data_offset, len;
+			unsigned long *p, *end;
+
+			offset = (u32)entry->fields[n_u64];
+			data_offset = offset & 0xffff;
+			len = offset >> 16;
+
+			p = (void *)entry + data_offset;
+			end = (void *)p + len - (sizeof(long) - 1);
+
+			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
+
+			for (; *p && p < end; p++)
+				trace_seq_printf(s, "=> %pS\n", (void *)*p);
+			n_u64++;
+
 		} else {
 			struct trace_print_flags __flags[] = {
 			    __def_gfpflag_names, {-1, NULL} };
@@ -458,6 +487,43 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 	return len;
 }
 
+static unsigned int trace_stack(struct synth_trace_event *entry,
+				 struct synth_event *event,
+				 long *stack,
+				 unsigned int data_size,
+				 unsigned int *n_u64)
+{
+	unsigned int len;
+	u32 data_offset;
+	void *data_loc;
+
+	data_offset = struct_size(entry, fields, event->n_u64);
+	data_offset += data_size;
+
+	for (len = 0; len < HIST_STACKTRACE_DEPTH; len++) {
+		if (!stack[len])
+			break;
+	}
+
+	/* Include the zero'd element if it fits */
+	if (len < HIST_STACKTRACE_DEPTH)
+		len++;
+
+	len *= sizeof(long);
+
+	/* Find the dynamic section to copy the stack into. */
+	data_loc = (void *)entry + data_offset;
+	memcpy(data_loc, stack, len);
+
+	/* Fill in the field that holds the offset/len combo */
+	data_offset |= len << 16;
+	*(u32 *)&entry->fields[*n_u64] = data_offset;
+
+	(*n_u64)++;
+
+	return len;
+}
+
 static notrace void trace_event_raw_event_synth(void *__data,
 						u64 *var_ref_vals,
 						unsigned int *var_ref_idx)
@@ -510,6 +576,12 @@ static notrace void trace_event_raw_event_synth(void *__data,
 					   event->fields[i]->is_dynamic,
 					   data_size, &n_u64);
 			data_size += len; /* only dynamic string increments */
+		} else if (event->fields[i]->is_stack) {
+			long *stack = (long *)(long)var_ref_vals[val_idx];
+
+			len = trace_stack(entry, event, stack,
+					   data_size, &n_u64);
+			data_size += len;
 		} else {
 			struct synth_field *field = event->fields[i];
 			u64 val = var_ref_vals[val_idx];
@@ -572,6 +644,9 @@ static int __set_synth_event_print_fmt(struct synth_event *event,
 		    event->fields[i]->is_dynamic)
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
 				", __get_str(%s)", event->fields[i]->name);
+		else if (event->fields[i]->is_stack)
+			pos += snprintf(buf + pos, LEN_OR_ZERO,
+				", __get_stacktrace(%s)", event->fields[i]->name);
 		else
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
 					", REC->%s", event->fields[i]->name);
@@ -708,7 +783,8 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 		ret = -EINVAL;
 		goto free;
 	} else if (size == 0) {
-		if (synth_field_is_string(field->type)) {
+		if (synth_field_is_string(field->type) ||
+		    synth_field_is_stack(field->type)) {
 			char *type;
 
 			len = sizeof("__data_loc ") + strlen(field->type) + 1;
@@ -739,6 +815,8 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 
 	if (synth_field_is_string(field->type))
 		field->is_string = true;
+	else if (synth_field_is_stack(field->type))
+		field->is_stack = true;
 
 	field->is_signed = synth_field_signed(field->type);
  out:
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index bb2f95d7175c..eef9806bb9b1 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -64,7 +64,7 @@ int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, void *data, void *ent)
 	int len = *(u32 *)data >> 16;
 
 	if (!len)
-		trace_seq_puts(s, "(fault)");
+		trace_seq_puts(s, FAULT_STRING);
 	else
 		trace_seq_printf(s, "\"%s\"",
 				 (const char *)get_loc_data(data, ent));
@@ -76,9 +76,11 @@ const char PRINT_TYPE_FMT_NAME(string)[] = "\\\"%s\\\"";
 /* Fetch type information table */
 static const struct fetch_type probe_fetch_types[] = {
 	/* Special types */
-	__ASSIGN_FETCH_TYPE("string", string, string, sizeof(u32), 1,
+	__ASSIGN_FETCH_TYPE("string", string, string, sizeof(u32), 1, 1,
 			    "__data_loc char[]"),
-	__ASSIGN_FETCH_TYPE("ustring", string, string, sizeof(u32), 1,
+	__ASSIGN_FETCH_TYPE("ustring", string, string, sizeof(u32), 1, 1,
+			    "__data_loc char[]"),
+	__ASSIGN_FETCH_TYPE("symstr", string, string, sizeof(u32), 1, 1,
 			    "__data_loc char[]"),
 	/* Basic types */
 	ASSIGN_FETCH_TYPE(u8,  u8,  0),
@@ -662,16 +664,26 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 
 	ret = -EINVAL;
 	/* Store operation */
-	if (!strcmp(parg->type->name, "string") ||
-	    !strcmp(parg->type->name, "ustring")) {
-		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF &&
-		    code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM &&
-		    code->op != FETCH_OP_DATA && code->op != FETCH_OP_TP_ARG) {
-			trace_probe_log_err(offset + (t ? (t - arg) : 0),
-					    BAD_STRING);
-			goto fail;
+	if (parg->type->is_string) {
+		if (!strcmp(parg->type->name, "symstr")) {
+			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
+			    code->op != FETCH_OP_RETVAL && code->op != FETCH_OP_ARG &&
+			    code->op != FETCH_OP_DEREF && code->op != FETCH_OP_TP_ARG) {
+				trace_probe_log_err(offset + (t ? (t - arg) : 0),
+						    BAD_SYMSTRING);
+				goto fail;
+			}
+		} else {
+			if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF &&
+			    code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM &&
+			    code->op != FETCH_OP_DATA && code->op != FETCH_OP_TP_ARG) {
+				trace_probe_log_err(offset + (t ? (t - arg) : 0),
+						    BAD_STRING);
+				goto fail;
+			}
 		}
-		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
+		if (!strcmp(parg->type->name, "symstr") ||
+		    (code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
 		     code->op == FETCH_OP_DATA) || code->op == FETCH_OP_TP_ARG ||
 		     parg->count) {
 			/*
@@ -679,6 +691,8 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			 * must be kept, and if parg->count != 0, this is an
 			 * array of string pointers instead of string address
 			 * itself.
+			 * For the symstr, it doesn't need to dereference, thus
+			 * it just get the value.
 			 */
 			code++;
 			if (code->op != FETCH_OP_NOP) {
@@ -690,6 +704,8 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		if (!strcmp(parg->type->name, "ustring") ||
 		    code->op == FETCH_OP_UDEREF)
 			code->op = FETCH_OP_ST_USTRING;
+		else if (!strcmp(parg->type->name, "symstr"))
+			code->op = FETCH_OP_ST_SYMSTR;
 		else
 			code->op = FETCH_OP_ST_STRING;
 		code->size = parg->type->size;
@@ -919,8 +935,7 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 	for (i = 0; i < tp->nr_args; i++) {
 		parg = tp->args + i;
 		if (parg->count) {
-			if ((strcmp(parg->type->name, "string") == 0) ||
-			    (strcmp(parg->type->name, "ustring") == 0))
+			if (parg->type->is_string)
 				fmt = ", __get_str(%s[%d])";
 			else
 				fmt = ", REC->%s[%d]";
@@ -928,8 +943,7 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 				pos += snprintf(buf + pos, LEN_OR_ZERO,
 						fmt, parg->name, j);
 		} else {
-			if ((strcmp(parg->type->name, "string") == 0) ||
-			    (strcmp(parg->type->name, "ustring") == 0))
+			if (parg->type->is_string)
 				fmt = ", __get_str(%s)";
 			else
 				fmt = ", REC->%s";
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 3d731aac94d4..f41c330bd60f 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -98,6 +98,7 @@ enum fetch_op {
 	FETCH_OP_ST_UMEM,	/* Mem: .offset, .size */
 	FETCH_OP_ST_STRING,	/* String: .offset, .size */
 	FETCH_OP_ST_USTRING,	/* User String: .offset, .size */
+	FETCH_OP_ST_SYMSTR,	/* Kernel Symbol String: .offset, .size */
 	// Stage 4 (modify) op
 	FETCH_OP_MOD_BF,	/* Bitfield: .basesize, .lshift, .rshift */
 	// Stage 5 (loop) op
@@ -133,7 +134,8 @@ struct fetch_insn {
 struct fetch_type {
 	const char		*name;		/* Name of type */
 	size_t			size;		/* Byte size of type */
-	int			is_signed;	/* Signed flag */
+	bool			is_signed;	/* Signed flag */
+	bool			is_string;	/* String flag */
 	print_type_func_t	print;		/* Print functions */
 	const char		*fmt;		/* Format string */
 	const char		*fmttype;	/* Name in format file */
@@ -177,16 +179,19 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
 #define _ADDR_FETCH_TYPE(t) __ADDR_FETCH_TYPE(t)
 #define ADDR_FETCH_TYPE _ADDR_FETCH_TYPE(BITS_PER_LONG)
 
-#define __ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, _fmttype)	\
-	{.name = _name,				\
+#define __ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, str, _fmttype)	\
+	{.name = _name,					\
 	 .size = _size,					\
-	 .is_signed = sign,				\
+	 .is_signed = (bool)sign,			\
+	 .is_string = (bool)str,			\
 	 .print = PRINT_TYPE_FUNC_NAME(ptype),		\
 	 .fmt = PRINT_TYPE_FMT_NAME(ptype),		\
 	 .fmttype = _fmttype,				\
 	}
+
+/* Non string types can use these macros */
 #define _ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, _fmttype)	\
-	__ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, #_fmttype)
+	__ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, 0, #_fmttype)
 #define ASSIGN_FETCH_TYPE(ptype, ftype, sign)			\
 	_ASSIGN_FETCH_TYPE(#ptype, ptype, ftype, sizeof(ftype), sign, ptype)
 
@@ -431,6 +436,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(ARRAY_TOO_BIG,	"Array number is too big"),		\
 	C(BAD_TYPE,		"Unknown type is specified"),		\
 	C(BAD_STRING,		"String accepts only memory argument"),	\
+	C(BAD_SYMSTRING,	"Symbol String doesn't accept data/userdata"),	\
 	C(BAD_BITFIELD,		"Invalid bitfield"),			\
 	C(ARG_NAME_TOO_LONG,	"Argument name is too long"),		\
 	C(NO_ARG_NAME,		"Argument name is not specified"),	\
diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
index 77dbd9ff9782..2da70be83831 100644
--- a/kernel/trace/trace_probe_kernel.h
+++ b/kernel/trace/trace_probe_kernel.h
@@ -2,8 +2,6 @@
 #ifndef __TRACE_PROBE_KERNEL_H_
 #define __TRACE_PROBE_KERNEL_H_
 
-#define FAULT_STRING "(fault)"
-
 /*
  * This depends on trace_probe.h, but can not include it due to
  * the way trace_probe_tmpl.h is used by trace_kprobe.c and trace_eprobe.c.
@@ -15,16 +13,8 @@ static nokprobe_inline int
 kern_fetch_store_strlen_user(unsigned long addr)
 {
 	const void __user *uaddr =  (__force const void __user *)addr;
-	int ret;
 
-	ret = strnlen_user_nofault(uaddr, MAX_STRING_SIZE);
-	/*
-	 * strnlen_user_nofault returns zero on fault, insert the
-	 * FAULT_STRING when that occurs.
-	 */
-	if (ret <= 0)
-		return strlen(FAULT_STRING) + 1;
-	return ret;
+	return strnlen_user_nofault(uaddr, MAX_STRING_SIZE);
 }
 
 /* Return the length of string -- including null terminal byte */
@@ -44,18 +34,14 @@ kern_fetch_store_strlen(unsigned long addr)
 		len++;
 	} while (c && ret == 0 && len < MAX_STRING_SIZE);
 
-	/* For faults, return enough to hold the FAULT_STRING */
-	return (ret < 0) ? strlen(FAULT_STRING) + 1 : len;
+	return (ret < 0) ? ret : len;
 }
 
-static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base, int len)
+static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base)
 {
-	if (ret >= 0) {
-		*(u32 *)dest = make_data_loc(ret, __dest - base);
-	} else {
-		strscpy(__dest, FAULT_STRING, len);
-		ret = strlen(__dest) + 1;
-	}
+	if (ret < 0)
+		ret = 0;
+	*(u32 *)dest = make_data_loc(ret, __dest - base);
 }
 
 /*
@@ -76,7 +62,7 @@ kern_fetch_store_string_user(unsigned long addr, void *dest, void *base)
 	__dest = get_loc_data(dest, base);
 
 	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
-	set_data_loc(ret, dest, __dest, base, maxlen);
+	set_data_loc(ret, dest, __dest, base);
 
 	return ret;
 }
@@ -107,7 +93,7 @@ kern_fetch_store_string(unsigned long addr, void *dest, void *base)
 	 * probing.
 	 */
 	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
-	set_data_loc(ret, dest, __dest, base, maxlen);
+	set_data_loc(ret, dest, __dest, base);
 
 	return ret;
 }
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index c293a607d536..3e2f5a43b974 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -67,6 +67,37 @@ probe_mem_read(void *dest, void *src, size_t size);
 static nokprobe_inline int
 probe_mem_read_user(void *dest, void *src, size_t size);
 
+static nokprobe_inline int
+fetch_store_symstrlen(unsigned long addr)
+{
+	char namebuf[KSYM_SYMBOL_LEN];
+	int ret;
+
+	ret = sprint_symbol(namebuf, addr);
+	if (ret < 0)
+		return 0;
+
+	return ret + 1;
+}
+
+/*
+ * Fetch a null-terminated symbol string + offset. Caller MUST set *(u32 *)buf
+ * with max length and relative data location.
+ */
+static nokprobe_inline int
+fetch_store_symstring(unsigned long addr, void *dest, void *base)
+{
+	int maxlen = get_loc_len(*(u32 *)dest);
+	void *__dest;
+
+	if (unlikely(!maxlen))
+		return -ENOMEM;
+
+	__dest = get_loc_data(dest, base);
+
+	return sprint_symbol(__dest, addr);
+}
+
 /* From the 2nd stage, routine is same */
 static nokprobe_inline int
 process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
@@ -99,16 +130,22 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 stage3:
 	/* 3rd stage: store value to buffer */
 	if (unlikely(!dest)) {
-		if (code->op == FETCH_OP_ST_STRING) {
+		switch (code->op) {
+		case FETCH_OP_ST_STRING:
 			ret = fetch_store_strlen(val + code->offset);
 			code++;
 			goto array;
-		} else if (code->op == FETCH_OP_ST_USTRING) {
-			ret += fetch_store_strlen_user(val + code->offset);
+		case FETCH_OP_ST_USTRING:
+			ret = fetch_store_strlen_user(val + code->offset);
 			code++;
 			goto array;
-		} else
+		case FETCH_OP_ST_SYMSTR:
+			ret = fetch_store_symstrlen(val + code->offset);
+			code++;
+			goto array;
+		default:
 			return -EILSEQ;
+		}
 	}
 
 	switch (code->op) {
@@ -129,6 +166,10 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 		loc = *(u32 *)dest;
 		ret = fetch_store_string_user(val + code->offset, dest, base);
 		break;
+	case FETCH_OP_ST_SYMSTR:
+		loc = *(u32 *)dest;
+		ret = fetch_store_symstring(val + code->offset, dest, base);
+		break;
 	default:
 		return -EILSEQ;
 	}
@@ -206,13 +247,9 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
 		ret = process_fetch_insn(arg->code, rec, dl, base);
-		if (arg->dynamic) {
-			if (unlikely(ret < 0)) {
-				*dl = make_data_loc(0, dyndata - base);
-			} else {
-				dyndata += ret;
-				maxlen -= ret;
-			}
+		if (arg->dynamic && likely(ret > 0)) {
+			dyndata += ret;
+			maxlen -= ret;
 		}
 	}
 }
diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
index b29595fe3ac5..43f6fb6078db 100644
--- a/kernel/trace/trace_synth.h
+++ b/kernel/trace/trace_synth.h
@@ -18,6 +18,7 @@ struct synth_field {
 	bool is_signed;
 	bool is_string;
 	bool is_dynamic;
+	bool is_stack;
 };
 
 struct synth_event {
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index fb58e86dd117..2ac06a642863 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -170,7 +170,8 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 			 */
 			ret++;
 		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
-	}
+	} else
+		*(u32 *)dest = make_data_loc(0, (void *)dst - base);
 
 	return ret;
 }
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 13d3fa6aa972..490a4179879a 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -214,7 +214,7 @@ static int __kstrncpy(char **dst, const char *name, size_t count, gfp_t gfp)
 {
 	*dst = kstrndup(name, count, gfp);
 	if (!*dst)
-		return -ENOSPC;
+		return -ENOMEM;
 	return count;
 }
 
@@ -671,7 +671,7 @@ static ssize_t trigger_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -719,7 +719,7 @@ static ssize_t trigger_request_platform_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("inserting test platform fw '%s'\n", name);
 	efi_embedded_fw.name = name;
@@ -772,7 +772,7 @@ static ssize_t trigger_async_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -817,7 +817,7 @@ static ssize_t trigger_custom_fallback_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s' using custom fallback mechanism\n", name);
 
@@ -868,7 +868,7 @@ static int test_fw_run_batch_request(void *data)
 
 		test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL);
 		if (!test_buf)
-			return -ENOSPC;
+			return -ENOMEM;
 
 		if (test_fw_config->partial)
 			req->rc = request_partial_firmware_into_buf
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index f7364b9fee93..fad668042f3e 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -30,54 +30,54 @@
 #else
 #define cond_resched()			do {} while (0)
 #endif
-static
-int mtree_insert_index(struct maple_tree *mt, unsigned long index, gfp_t gfp)
+static int __init mtree_insert_index(struct maple_tree *mt,
+				     unsigned long index, gfp_t gfp)
 {
 	return mtree_insert(mt, index, xa_mk_value(index & LONG_MAX), gfp);
 }
 
-static void mtree_erase_index(struct maple_tree *mt, unsigned long index)
+static void __init mtree_erase_index(struct maple_tree *mt, unsigned long index)
 {
 	MT_BUG_ON(mt, mtree_erase(mt, index) != xa_mk_value(index & LONG_MAX));
 	MT_BUG_ON(mt, mtree_load(mt, index) != NULL);
 }
 
-static int mtree_test_insert(struct maple_tree *mt, unsigned long index,
+static int __init mtree_test_insert(struct maple_tree *mt, unsigned long index,
 				void *ptr)
 {
 	return mtree_insert(mt, index, ptr, GFP_KERNEL);
 }
 
-static int mtree_test_store_range(struct maple_tree *mt, unsigned long start,
-				unsigned long end, void *ptr)
+static int __init mtree_test_store_range(struct maple_tree *mt,
+			unsigned long start, unsigned long end, void *ptr)
 {
 	return mtree_store_range(mt, start, end, ptr, GFP_KERNEL);
 }
 
-static int mtree_test_store(struct maple_tree *mt, unsigned long start,
+static int __init mtree_test_store(struct maple_tree *mt, unsigned long start,
 				void *ptr)
 {
 	return mtree_test_store_range(mt, start, start, ptr);
 }
 
-static int mtree_test_insert_range(struct maple_tree *mt, unsigned long start,
-				unsigned long end, void *ptr)
+static int __init mtree_test_insert_range(struct maple_tree *mt,
+			unsigned long start, unsigned long end, void *ptr)
 {
 	return mtree_insert_range(mt, start, end, ptr, GFP_KERNEL);
 }
 
-static void *mtree_test_load(struct maple_tree *mt, unsigned long index)
+static void __init *mtree_test_load(struct maple_tree *mt, unsigned long index)
 {
 	return mtree_load(mt, index);
 }
 
-static void *mtree_test_erase(struct maple_tree *mt, unsigned long index)
+static void __init *mtree_test_erase(struct maple_tree *mt, unsigned long index)
 {
 	return mtree_erase(mt, index);
 }
 
 #if defined(CONFIG_64BIT)
-static noinline void check_mtree_alloc_range(struct maple_tree *mt,
+static noinline void __init check_mtree_alloc_range(struct maple_tree *mt,
 		unsigned long start, unsigned long end, unsigned long size,
 		unsigned long expected, int eret, void *ptr)
 {
@@ -94,7 +94,7 @@ static noinline void check_mtree_alloc_range(struct maple_tree *mt,
 	MT_BUG_ON(mt, result != expected);
 }
 
-static noinline void check_mtree_alloc_rrange(struct maple_tree *mt,
+static noinline void __init check_mtree_alloc_rrange(struct maple_tree *mt,
 		unsigned long start, unsigned long end, unsigned long size,
 		unsigned long expected, int eret, void *ptr)
 {
@@ -112,8 +112,8 @@ static noinline void check_mtree_alloc_rrange(struct maple_tree *mt,
 }
 #endif
 
-static noinline void check_load(struct maple_tree *mt, unsigned long index,
-				void *ptr)
+static noinline void __init check_load(struct maple_tree *mt,
+				       unsigned long index, void *ptr)
 {
 	void *ret = mtree_test_load(mt, index);
 
@@ -122,7 +122,7 @@ static noinline void check_load(struct maple_tree *mt, unsigned long index,
 	MT_BUG_ON(mt, ret != ptr);
 }
 
-static noinline void check_store_range(struct maple_tree *mt,
+static noinline void __init check_store_range(struct maple_tree *mt,
 		unsigned long start, unsigned long end, void *ptr, int expected)
 {
 	int ret = -EINVAL;
@@ -138,7 +138,7 @@ static noinline void check_store_range(struct maple_tree *mt,
 		check_load(mt, i, ptr);
 }
 
-static noinline void check_insert_range(struct maple_tree *mt,
+static noinline void __init check_insert_range(struct maple_tree *mt,
 		unsigned long start, unsigned long end, void *ptr, int expected)
 {
 	int ret = -EINVAL;
@@ -154,8 +154,8 @@ static noinline void check_insert_range(struct maple_tree *mt,
 		check_load(mt, i, ptr);
 }
 
-static noinline void check_insert(struct maple_tree *mt, unsigned long index,
-		void *ptr)
+static noinline void __init check_insert(struct maple_tree *mt,
+					 unsigned long index, void *ptr)
 {
 	int ret = -EINVAL;
 
@@ -163,7 +163,7 @@ static noinline void check_insert(struct maple_tree *mt, unsigned long index,
 	MT_BUG_ON(mt, ret != 0);
 }
 
-static noinline void check_dup_insert(struct maple_tree *mt,
+static noinline void __init check_dup_insert(struct maple_tree *mt,
 				      unsigned long index, void *ptr)
 {
 	int ret = -EINVAL;
@@ -173,13 +173,13 @@ static noinline void check_dup_insert(struct maple_tree *mt,
 }
 
 
-static noinline
-void check_index_load(struct maple_tree *mt, unsigned long index)
+static noinline void __init check_index_load(struct maple_tree *mt,
+					     unsigned long index)
 {
 	return check_load(mt, index, xa_mk_value(index & LONG_MAX));
 }
 
-static inline int not_empty(struct maple_node *node)
+static inline __init int not_empty(struct maple_node *node)
 {
 	int i;
 
@@ -194,8 +194,8 @@ static inline int not_empty(struct maple_node *node)
 }
 
 
-static noinline void check_rev_seq(struct maple_tree *mt, unsigned long max,
-		bool verbose)
+static noinline void __init check_rev_seq(struct maple_tree *mt,
+					  unsigned long max, bool verbose)
 {
 	unsigned long i = max, j;
 
@@ -227,7 +227,7 @@ static noinline void check_rev_seq(struct maple_tree *mt, unsigned long max,
 #endif
 }
 
-static noinline void check_seq(struct maple_tree *mt, unsigned long max,
+static noinline void __init check_seq(struct maple_tree *mt, unsigned long max,
 		bool verbose)
 {
 	unsigned long i, j;
@@ -256,7 +256,7 @@ static noinline void check_seq(struct maple_tree *mt, unsigned long max,
 #endif
 }
 
-static noinline void check_lb_not_empty(struct maple_tree *mt)
+static noinline void __init check_lb_not_empty(struct maple_tree *mt)
 {
 	unsigned long i, j;
 	unsigned long huge = 4000UL * 1000 * 1000;
@@ -275,13 +275,13 @@ static noinline void check_lb_not_empty(struct maple_tree *mt)
 	mtree_destroy(mt);
 }
 
-static noinline void check_lower_bound_split(struct maple_tree *mt)
+static noinline void __init check_lower_bound_split(struct maple_tree *mt)
 {
 	MT_BUG_ON(mt, !mtree_empty(mt));
 	check_lb_not_empty(mt);
 }
 
-static noinline void check_upper_bound_split(struct maple_tree *mt)
+static noinline void __init check_upper_bound_split(struct maple_tree *mt)
 {
 	unsigned long i, j;
 	unsigned long huge;
@@ -306,7 +306,7 @@ static noinline void check_upper_bound_split(struct maple_tree *mt)
 	mtree_destroy(mt);
 }
 
-static noinline void check_mid_split(struct maple_tree *mt)
+static noinline void __init check_mid_split(struct maple_tree *mt)
 {
 	unsigned long huge = 8000UL * 1000 * 1000;
 
@@ -315,7 +315,7 @@ static noinline void check_mid_split(struct maple_tree *mt)
 	check_lb_not_empty(mt);
 }
 
-static noinline void check_rev_find(struct maple_tree *mt)
+static noinline void __init check_rev_find(struct maple_tree *mt)
 {
 	int i, nr_entries = 200;
 	void *val;
@@ -354,7 +354,7 @@ static noinline void check_rev_find(struct maple_tree *mt)
 	rcu_read_unlock();
 }
 
-static noinline void check_find(struct maple_tree *mt)
+static noinline void __init check_find(struct maple_tree *mt)
 {
 	unsigned long val = 0;
 	unsigned long count;
@@ -571,7 +571,7 @@ static noinline void check_find(struct maple_tree *mt)
 	mtree_destroy(mt);
 }
 
-static noinline void check_find_2(struct maple_tree *mt)
+static noinline void __init check_find_2(struct maple_tree *mt)
 {
 	unsigned long i, j;
 	void *entry;
@@ -616,7 +616,7 @@ static noinline void check_find_2(struct maple_tree *mt)
 
 
 #if defined(CONFIG_64BIT)
-static noinline void check_alloc_rev_range(struct maple_tree *mt)
+static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 {
 	/*
 	 * Generated by:
@@ -624,7 +624,7 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 	 * awk -F "-" '{printf "0x%s, 0x%s, ", $1, $2}'
 	 */
 
-	unsigned long range[] = {
+	static const unsigned long range[] = {
 	/*      Inclusive     , Exclusive. */
 		0x565234af2000, 0x565234af4000,
 		0x565234af4000, 0x565234af9000,
@@ -652,7 +652,7 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 		0x7fff58791000, 0x7fff58793000,
 	};
 
-	unsigned long holes[] = {
+	static const unsigned long holes[] = {
 		/*
 		 * Note: start of hole is INCLUSIVE
 		 *        end of hole is EXCLUSIVE
@@ -672,7 +672,7 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 	 * 4. number that should be returned.
 	 * 5. return value
 	 */
-	unsigned long req_range[] = {
+	static const unsigned long req_range[] = {
 		0x565234af9000, /* Min */
 		0x7fff58791000, /* Max */
 		0x1000,         /* Size */
@@ -783,7 +783,7 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 	mtree_destroy(mt);
 }
 
-static noinline void check_alloc_range(struct maple_tree *mt)
+static noinline void __init check_alloc_range(struct maple_tree *mt)
 {
 	/*
 	 * Generated by:
@@ -791,7 +791,7 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 	 * awk -F "-" '{printf "0x%s, 0x%s, ", $1, $2}'
 	 */
 
-	unsigned long range[] = {
+	static const unsigned long range[] = {
 	/*      Inclusive     , Exclusive. */
 		0x565234af2000, 0x565234af4000,
 		0x565234af4000, 0x565234af9000,
@@ -818,7 +818,7 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 		0x7fff5878e000, 0x7fff58791000,
 		0x7fff58791000, 0x7fff58793000,
 	};
-	unsigned long holes[] = {
+	static const unsigned long holes[] = {
 		/* Start of hole, end of hole,  size of hole (+1) */
 		0x565234afb000, 0x565234afc000, 0x1000,
 		0x565234afe000, 0x565235def000, 0x12F1000,
@@ -833,7 +833,7 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 	 * 4. number that should be returned.
 	 * 5. return value
 	 */
-	unsigned long req_range[] = {
+	static const unsigned long req_range[] = {
 		0x565234af9000, /* Min */
 		0x7fff58791000, /* Max */
 		0x1000,         /* Size */
@@ -942,10 +942,10 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 }
 #endif
 
-static noinline void check_ranges(struct maple_tree *mt)
+static noinline void __init check_ranges(struct maple_tree *mt)
 {
 	int i, val, val2;
-	unsigned long r[] = {
+	static const unsigned long r[] = {
 		10, 15,
 		20, 25,
 		17, 22, /* Overlaps previous range. */
@@ -1210,7 +1210,7 @@ static noinline void check_ranges(struct maple_tree *mt)
 		MT_BUG_ON(mt, mt_height(mt) != 4);
 }
 
-static noinline void check_next_entry(struct maple_tree *mt)
+static noinline void __init check_next_entry(struct maple_tree *mt)
 {
 	void *entry = NULL;
 	unsigned long limit = 30, i = 0;
@@ -1234,7 +1234,7 @@ static noinline void check_next_entry(struct maple_tree *mt)
 	mtree_destroy(mt);
 }
 
-static noinline void check_prev_entry(struct maple_tree *mt)
+static noinline void __init check_prev_entry(struct maple_tree *mt)
 {
 	unsigned long index = 16;
 	void *value;
@@ -1278,7 +1278,7 @@ static noinline void check_prev_entry(struct maple_tree *mt)
 	mas_unlock(&mas);
 }
 
-static noinline void check_root_expand(struct maple_tree *mt)
+static noinline void __init check_root_expand(struct maple_tree *mt)
 {
 	MA_STATE(mas, mt, 0, 0);
 	void *ptr;
@@ -1367,13 +1367,13 @@ static noinline void check_root_expand(struct maple_tree *mt)
 	mas_unlock(&mas);
 }
 
-static noinline void check_gap_combining(struct maple_tree *mt)
+static noinline void __init check_gap_combining(struct maple_tree *mt)
 {
 	struct maple_enode *mn1, *mn2;
 	void *entry;
 	unsigned long singletons = 100;
-	unsigned long *seq100;
-	unsigned long seq100_64[] = {
+	static const unsigned long *seq100;
+	static const unsigned long seq100_64[] = {
 		/* 0-5 */
 		74, 75, 76,
 		50, 100, 2,
@@ -1387,7 +1387,7 @@ static noinline void check_gap_combining(struct maple_tree *mt)
 		76, 2, 79, 85, 4,
 	};
 
-	unsigned long seq100_32[] = {
+	static const unsigned long seq100_32[] = {
 		/* 0-5 */
 		61, 62, 63,
 		50, 100, 2,
@@ -1401,11 +1401,11 @@ static noinline void check_gap_combining(struct maple_tree *mt)
 		76, 2, 79, 85, 4,
 	};
 
-	unsigned long seq2000[] = {
+	static const unsigned long seq2000[] = {
 		1152, 1151,
 		1100, 1200, 2,
 	};
-	unsigned long seq400[] = {
+	static const unsigned long seq400[] = {
 		286, 318,
 		256, 260, 266, 270, 275, 280, 290, 398,
 		286, 310,
@@ -1564,7 +1564,7 @@ static noinline void check_gap_combining(struct maple_tree *mt)
 	mt_set_non_kernel(0);
 	mtree_destroy(mt);
 }
-static noinline void check_node_overwrite(struct maple_tree *mt)
+static noinline void __init check_node_overwrite(struct maple_tree *mt)
 {
 	int i, max = 4000;
 
@@ -1577,7 +1577,7 @@ static noinline void check_node_overwrite(struct maple_tree *mt)
 }
 
 #if defined(BENCH_SLOT_STORE)
-static noinline void bench_slot_store(struct maple_tree *mt)
+static noinline void __init bench_slot_store(struct maple_tree *mt)
 {
 	int i, brk = 105, max = 1040, brk_start = 100, count = 20000000;
 
@@ -1593,7 +1593,7 @@ static noinline void bench_slot_store(struct maple_tree *mt)
 #endif
 
 #if defined(BENCH_NODE_STORE)
-static noinline void bench_node_store(struct maple_tree *mt)
+static noinline void __init bench_node_store(struct maple_tree *mt)
 {
 	int i, overwrite = 76, max = 240, count = 20000000;
 
@@ -1612,7 +1612,7 @@ static noinline void bench_node_store(struct maple_tree *mt)
 #endif
 
 #if defined(BENCH_AWALK)
-static noinline void bench_awalk(struct maple_tree *mt)
+static noinline void __init bench_awalk(struct maple_tree *mt)
 {
 	int i, max = 2500, count = 50000000;
 	MA_STATE(mas, mt, 1470, 1470);
@@ -1629,7 +1629,7 @@ static noinline void bench_awalk(struct maple_tree *mt)
 }
 #endif
 #if defined(BENCH_WALK)
-static noinline void bench_walk(struct maple_tree *mt)
+static noinline void __init bench_walk(struct maple_tree *mt)
 {
 	int i, max = 2500, count = 550000000;
 	MA_STATE(mas, mt, 1470, 1470);
@@ -1646,7 +1646,7 @@ static noinline void bench_walk(struct maple_tree *mt)
 #endif
 
 #if defined(BENCH_MT_FOR_EACH)
-static noinline void bench_mt_for_each(struct maple_tree *mt)
+static noinline void __init bench_mt_for_each(struct maple_tree *mt)
 {
 	int i, count = 1000000;
 	unsigned long max = 2500, index = 0;
@@ -1670,7 +1670,7 @@ static noinline void bench_mt_for_each(struct maple_tree *mt)
 #endif
 
 /* check_forking - simulate the kernel forking sequence with the tree. */
-static noinline void check_forking(struct maple_tree *mt)
+static noinline void __init check_forking(struct maple_tree *mt)
 {
 
 	struct maple_tree newmt;
@@ -1709,7 +1709,75 @@ static noinline void check_forking(struct maple_tree *mt)
 	mtree_destroy(&newmt);
 }
 
-static noinline void check_mas_store_gfp(struct maple_tree *mt)
+static noinline void __init check_iteration(struct maple_tree *mt)
+{
+	int i, nr_entries = 125;
+	void *val;
+	MA_STATE(mas, mt, 0, 0);
+
+	for (i = 0; i <= nr_entries; i++)
+		mtree_store_range(mt, i * 10, i * 10 + 9,
+				  xa_mk_value(i), GFP_KERNEL);
+
+	mt_set_non_kernel(99999);
+
+	i = 0;
+	mas_lock(&mas);
+	mas_for_each(&mas, val, 925) {
+		MT_BUG_ON(mt, mas.index != i * 10);
+		MT_BUG_ON(mt, mas.last != i * 10 + 9);
+		/* Overwrite end of entry 92 */
+		if (i == 92) {
+			mas.index = 925;
+			mas.last = 929;
+			mas_store(&mas, val);
+		}
+		i++;
+	}
+	/* Ensure mas_find() gets the next value */
+	val = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, val != xa_mk_value(i));
+
+	mas_set(&mas, 0);
+	i = 0;
+	mas_for_each(&mas, val, 785) {
+		MT_BUG_ON(mt, mas.index != i * 10);
+		MT_BUG_ON(mt, mas.last != i * 10 + 9);
+		/* Overwrite start of entry 78 */
+		if (i == 78) {
+			mas.index = 780;
+			mas.last = 785;
+			mas_store(&mas, val);
+		} else {
+			i++;
+		}
+	}
+	val = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, val != xa_mk_value(i));
+
+	mas_set(&mas, 0);
+	i = 0;
+	mas_for_each(&mas, val, 765) {
+		MT_BUG_ON(mt, mas.index != i * 10);
+		MT_BUG_ON(mt, mas.last != i * 10 + 9);
+		/* Overwrite end of entry 76 and advance to the end */
+		if (i == 76) {
+			mas.index = 760;
+			mas.last = 765;
+			mas_store(&mas, val);
+			mas_next(&mas, ULONG_MAX);
+		}
+		i++;
+	}
+	/* Make sure the next find returns the one after 765, 766-769 */
+	val = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, val != xa_mk_value(76));
+	mas_unlock(&mas);
+	mas_destroy(&mas);
+	mt_set_non_kernel(0);
+}
+
+static noinline void __init check_mas_store_gfp(struct maple_tree *mt)
 {
 
 	struct maple_tree newmt;
@@ -1742,7 +1810,7 @@ static noinline void check_mas_store_gfp(struct maple_tree *mt)
 }
 
 #if defined(BENCH_FORK)
-static noinline void bench_forking(struct maple_tree *mt)
+static noinline void __init bench_forking(struct maple_tree *mt)
 {
 
 	struct maple_tree newmt;
@@ -1784,22 +1852,27 @@ static noinline void bench_forking(struct maple_tree *mt)
 }
 #endif
 
-static noinline void next_prev_test(struct maple_tree *mt)
+static noinline void __init next_prev_test(struct maple_tree *mt)
 {
 	int i, nr_entries;
 	void *val;
 	MA_STATE(mas, mt, 0, 0);
 	struct maple_enode *mn;
-	unsigned long *level2;
-	unsigned long level2_64[] = {707, 1000, 710, 715, 720, 725};
-	unsigned long level2_32[] = {1747, 2000, 1750, 1755, 1760, 1765};
+	static const unsigned long *level2;
+	static const unsigned long level2_64[] = { 707, 1000, 710, 715, 720,
+						   725};
+	static const unsigned long level2_32[] = { 1747, 2000, 1750, 1755,
+						   1760, 1765};
+	unsigned long last_index;
 
 	if (MAPLE_32BIT) {
 		nr_entries = 500;
 		level2 = level2_32;
+		last_index = 0x138e;
 	} else {
 		nr_entries = 200;
 		level2 = level2_64;
+		last_index = 0x7d6;
 	}
 
 	for (i = 0; i <= nr_entries; i++)
@@ -1906,7 +1979,7 @@ static noinline void next_prev_test(struct maple_tree *mt)
 
 	val = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, val != NULL);
-	MT_BUG_ON(mt, mas.index != ULONG_MAX);
+	MT_BUG_ON(mt, mas.index != last_index);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
 
 	val = mas_prev(&mas, 0);
@@ -1960,7 +2033,7 @@ static noinline void next_prev_test(struct maple_tree *mt)
 
 
 /* Test spanning writes that require balancing right sibling or right cousin */
-static noinline void check_spanning_relatives(struct maple_tree *mt)
+static noinline void __init check_spanning_relatives(struct maple_tree *mt)
 {
 
 	unsigned long i, nr_entries = 1000;
@@ -1973,7 +2046,7 @@ static noinline void check_spanning_relatives(struct maple_tree *mt)
 	mtree_store_range(mt, 9365, 9955, NULL, GFP_KERNEL);
 }
 
-static noinline void check_fuzzer(struct maple_tree *mt)
+static noinline void __init check_fuzzer(struct maple_tree *mt)
 {
 	/*
 	 * 1. Causes a spanning rebalance of a single root node.
@@ -2370,7 +2443,7 @@ static noinline void check_fuzzer(struct maple_tree *mt)
 }
 
 /* duplicate the tree with a specific gap */
-static noinline void check_dup_gaps(struct maple_tree *mt,
+static noinline void __init check_dup_gaps(struct maple_tree *mt,
 				    unsigned long nr_entries, bool zero_start,
 				    unsigned long gap)
 {
@@ -2410,7 +2483,7 @@ static noinline void check_dup_gaps(struct maple_tree *mt,
 }
 
 /* Duplicate many sizes of trees.  Mainly to test expected entry values */
-static noinline void check_dup(struct maple_tree *mt)
+static noinline void __init check_dup(struct maple_tree *mt)
 {
 	int i;
 	int big_start = 100010;
@@ -2498,7 +2571,7 @@ static noinline void check_dup(struct maple_tree *mt)
 	}
 }
 
-static noinline void check_bnode_min_spanning(struct maple_tree *mt)
+static noinline void __init check_bnode_min_spanning(struct maple_tree *mt)
 {
 	int i = 50;
 	MA_STATE(mas, mt, 0, 0);
@@ -2517,7 +2590,7 @@ static noinline void check_bnode_min_spanning(struct maple_tree *mt)
 	mt_set_non_kernel(0);
 }
 
-static noinline void check_empty_area_window(struct maple_tree *mt)
+static noinline void __init check_empty_area_window(struct maple_tree *mt)
 {
 	unsigned long i, nr_entries = 20;
 	MA_STATE(mas, mt, 0, 0);
@@ -2602,7 +2675,7 @@ static noinline void check_empty_area_window(struct maple_tree *mt)
 	rcu_read_unlock();
 }
 
-static noinline void check_empty_area_fill(struct maple_tree *mt)
+static noinline void __init check_empty_area_fill(struct maple_tree *mt)
 {
 	const unsigned long max = 0x25D78000;
 	unsigned long size;
@@ -2646,11 +2719,11 @@ static noinline void check_empty_area_fill(struct maple_tree *mt)
 }
 
 static DEFINE_MTREE(tree);
-static int maple_tree_seed(void)
+static int __init maple_tree_seed(void)
 {
-	unsigned long set[] = {5015, 5014, 5017, 25, 1000,
-			       1001, 1002, 1003, 1005, 0,
-			       5003, 5002};
+	unsigned long set[] = { 5015, 5014, 5017, 25, 1000,
+				1001, 1002, 1003, 1005, 0,
+				5003, 5002};
 	void *ptr = &set;
 
 	pr_info("\nTEST STARTING\n\n");
@@ -2702,6 +2775,10 @@ static int maple_tree_seed(void)
 	goto skip;
 #endif
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_iteration(&tree);
+	mtree_destroy(&tree);
+
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_forking(&tree);
 	mtree_destroy(&tree);
@@ -2916,7 +2993,7 @@ static int maple_tree_seed(void)
 	return -EINVAL;
 }
 
-static void maple_tree_harvest(void)
+static void __exit maple_tree_harvest(void)
 {
 
 }
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index dfa237fbd5a3..09feb3f1fcaa 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1118,6 +1118,7 @@ bool ceph_addr_is_blank(const struct ceph_entity_addr *addr)
 		return true;
 	}
 }
+EXPORT_SYMBOL(ceph_addr_is_blank);
 
 int ceph_addr_port(const struct ceph_entity_addr *addr)
 {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 51bfc74805ec..48a6486951cd 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2561,12 +2561,18 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 			ipv6_ifa_notify(0, ift);
 	}
 
-	if ((create || list_empty(&idev->tempaddr_list)) &&
-	    idev->cnf.use_tempaddr > 0) {
+	/* Also create a temporary address if it's enabled but no temporary
+	 * address currently exists.
+	 * However, we get called with valid_lft == 0, prefered_lft == 0, create == false
+	 * as part of cleanup (ie. deleting the mngtmpaddr).
+	 * We don't want that to result in creating a new temporary ip address.
+	 */
+	if (list_empty(&idev->tempaddr_list) && (valid_lft || prefered_lft))
+		create = true;
+
+	if (create && idev->cnf.use_tempaddr > 0) {
 		/* When a new public address is created as described
 		 * in [ADDRCONF], also create a new temporary address.
-		 * Also create a temporary address if it's enabled but
-		 * no temporary address currently exists.
 		 */
 		read_unlock_bh(&idev->lock);
 		ipv6_create_tempaddr(ifp, false);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4ca61e80f4bb..f6f2e6417dcb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2945,9 +2945,9 @@ static void mptcp_check_listen_stop(struct sock *sk)
 		return;
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	tcp_set_state(ssk, TCP_CLOSE);
 	mptcp_subflow_queue_clean(sk, ssk);
 	inet_csk_listen_stop(ssk);
-	tcp_set_state(ssk, TCP_CLOSE);
 	release_sock(ssk);
 }
 
@@ -3746,12 +3746,18 @@ static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
+	struct sock *sk = sock->sk;
 	struct socket *ssock;
 	int err;
 
 	pr_debug("msk=%p", msk);
 
-	lock_sock(sock->sk);
+	lock_sock(sk);
+
+	err = -EINVAL;
+	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
+		goto unlock;
+
 	ssock = __mptcp_nmpc_socket(msk);
 	if (!ssock) {
 		err = -EINVAL;
@@ -3759,16 +3765,16 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	}
 
 	mptcp_token_destroy(msk);
-	inet_sk_state_store(sock->sk, TCP_LISTEN);
-	sock_set_flag(sock->sk, SOCK_RCU_FREE);
+	inet_sk_state_store(sk, TCP_LISTEN);
+	sock_set_flag(sk, SOCK_RCU_FREE);
 
 	err = ssock->ops->listen(ssock, backlog);
-	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
+	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
 	if (!err)
-		mptcp_copy_inaddrs(sock->sk, ssock->sk);
+		mptcp_copy_inaddrs(sk, ssock->sk);
 
 unlock:
-	release_sock(sock->sk);
+	release_sock(sk);
 	return err;
 }
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ecde497368ec..dd57a9ebe113 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3626,8 +3626,6 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN]);
 			return PTR_ERR(chain);
 		}
-		if (nft_chain_is_bound(chain))
-			return -EOPNOTSUPP;
 
 	} else if (nla[NFTA_RULE_CHAIN_ID]) {
 		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID],
@@ -3640,6 +3638,9 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 		return -EINVAL;
 	}
 
+	if (nft_chain_is_bound(chain))
+		return -EOPNOTSUPP;
+
 	if (nla[NFTA_RULE_HANDLE]) {
 		handle = be64_to_cpu(nla_get_be64(nla[NFTA_RULE_HANDLE]));
 		rule = __nft_rule_lookup(chain, handle);
@@ -6504,19 +6505,19 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	if (flags)
 		*nft_set_ext_flags(ext) = flags;
 
+	if (obj) {
+		*nft_set_ext_obj(ext) = obj;
+		obj->use++;
+	}
 	if (ulen > 0) {
 		if (nft_set_ext_check(&tmpl, NFT_SET_EXT_USERDATA, ulen) < 0) {
 			err = -EINVAL;
-			goto err_elem_userdata;
+			goto err_elem_free;
 		}
 		udata = nft_set_ext_userdata(ext);
 		udata->len = ulen - 1;
 		nla_memcpy(&udata->data, nla[NFTA_SET_ELEM_USERDATA], ulen);
 	}
-	if (obj) {
-		*nft_set_ext_obj(ext) = obj;
-		obj->use++;
-	}
 	err = nft_set_elem_expr_setup(ctx, &tmpl, ext, expr_array, num_exprs);
 	if (err < 0)
 		goto err_elem_free;
@@ -6571,10 +6572,9 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 err_element_clash:
 	kfree(trans);
 err_elem_free:
+	nf_tables_set_elem_destroy(ctx, set, elem.priv);
 	if (obj)
 		obj->use--;
-err_elem_userdata:
-	nft_set_elem_destroy(set, elem.priv, true);
 err_parse_data:
 	if (nla[NFTA_SET_ELEM_DATA] != NULL)
 		nft_data_release(&elem.data.val, desc.type);
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index 900e75e8c346..391c18e4b3eb 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -125,15 +125,27 @@ static void nft_immediate_activate(const struct nft_ctx *ctx,
 	return nft_data_hold(&priv->data, nft_dreg_to_type(priv->dreg));
 }
 
+static void nft_immediate_chain_deactivate(const struct nft_ctx *ctx,
+					   struct nft_chain *chain,
+					   enum nft_trans_phase phase)
+{
+	struct nft_ctx chain_ctx;
+	struct nft_rule *rule;
+
+	chain_ctx = *ctx;
+	chain_ctx.chain = chain;
+
+	list_for_each_entry(rule, &chain->rules, list)
+		nft_rule_expr_deactivate(&chain_ctx, rule, phase);
+}
+
 static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 				     const struct nft_expr *expr,
 				     enum nft_trans_phase phase)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
 	const struct nft_data *data = &priv->data;
-	struct nft_ctx chain_ctx;
 	struct nft_chain *chain;
-	struct nft_rule *rule;
 
 	if (priv->dreg == NFT_REG_VERDICT) {
 		switch (data->verdict.code) {
@@ -143,20 +155,17 @@ static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 			if (!nft_chain_binding(chain))
 				break;
 
-			chain_ctx = *ctx;
-			chain_ctx.chain = chain;
-
-			list_for_each_entry(rule, &chain->rules, list)
-				nft_rule_expr_deactivate(&chain_ctx, rule, phase);
-
 			switch (phase) {
 			case NFT_TRANS_PREPARE_ERROR:
 				nf_tables_unbind_chain(ctx, chain);
-				fallthrough;
+				nft_deactivate_next(ctx->net, chain);
+				break;
 			case NFT_TRANS_PREPARE:
+				nft_immediate_chain_deactivate(ctx, chain, phase);
 				nft_deactivate_next(ctx->net, chain);
 				break;
 			default:
+				nft_immediate_chain_deactivate(ctx, chain, phase);
 				nft_chain_del(chain);
 				chain->bound = false;
 				chain->table->use--;
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 5c05c9b990fb..8d73fffd2d09 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -217,29 +217,37 @@ static void *nft_rbtree_get(const struct net *net, const struct nft_set *set,
 
 static int nft_rbtree_gc_elem(const struct nft_set *__set,
 			      struct nft_rbtree *priv,
-			      struct nft_rbtree_elem *rbe)
+			      struct nft_rbtree_elem *rbe,
+			      u8 genmask)
 {
 	struct nft_set *set = (struct nft_set *)__set;
 	struct rb_node *prev = rb_prev(&rbe->node);
-	struct nft_rbtree_elem *rbe_prev = NULL;
+	struct nft_rbtree_elem *rbe_prev;
 	struct nft_set_gc_batch *gcb;
 
 	gcb = nft_set_gc_batch_check(set, NULL, GFP_ATOMIC);
 	if (!gcb)
 		return -ENOMEM;
 
-	/* search for expired end interval coming before this element. */
+	/* search for end interval coming before this element.
+	 * end intervals don't carry a timeout extension, they
+	 * are coupled with the interval start element.
+	 */
 	while (prev) {
 		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
-		if (nft_rbtree_interval_end(rbe_prev))
+		if (nft_rbtree_interval_end(rbe_prev) &&
+		    nft_set_elem_active(&rbe_prev->ext, genmask))
 			break;
 
 		prev = rb_prev(prev);
 	}
 
-	if (rbe_prev) {
+	if (prev) {
+		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
+
 		rb_erase(&rbe_prev->node, &priv->root);
 		atomic_dec(&set->nelems);
+		nft_set_gc_batch_add(gcb, rbe_prev);
 	}
 
 	rb_erase(&rbe->node, &priv->root);
@@ -321,7 +329,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 
 		/* perform garbage collection to avoid bogus overlap reports. */
 		if (nft_set_elem_expired(&rbe->ext)) {
-			err = nft_rbtree_gc_elem(set, priv, rbe);
+			err = nft_rbtree_gc_elem(set, priv, rbe, genmask);
 			if (err < 0)
 				return err;
 
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 9f26fb7d5823..b99e0fe0229c 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -130,6 +130,97 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 	return 0;
 }
 
+static int mqprio_parse_nlattr(struct Qdisc *sch, struct tc_mqprio_qopt *qopt,
+			       struct nlattr *opt,
+			       struct netlink_ext_ack *extack)
+{
+	struct mqprio_sched *priv = qdisc_priv(sch);
+	struct nlattr *tb[TCA_MQPRIO_MAX + 1];
+	struct nlattr *attr;
+	int i, rem, err;
+
+	err = parse_attr(tb, TCA_MQPRIO_MAX, opt, mqprio_policy,
+			 sizeof(*qopt));
+	if (err < 0)
+		return err;
+
+	if (!qopt->hw) {
+		NL_SET_ERR_MSG(extack,
+			       "mqprio TCA_OPTIONS can only contain netlink attributes in hardware mode");
+		return -EINVAL;
+	}
+
+	if (tb[TCA_MQPRIO_MODE]) {
+		priv->flags |= TC_MQPRIO_F_MODE;
+		priv->mode = *(u16 *)nla_data(tb[TCA_MQPRIO_MODE]);
+	}
+
+	if (tb[TCA_MQPRIO_SHAPER]) {
+		priv->flags |= TC_MQPRIO_F_SHAPER;
+		priv->shaper = *(u16 *)nla_data(tb[TCA_MQPRIO_SHAPER]);
+	}
+
+	if (tb[TCA_MQPRIO_MIN_RATE64]) {
+		if (priv->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[TCA_MQPRIO_MIN_RATE64],
+					    "min_rate accepted only when shaper is in bw_rlimit mode");
+			return -EINVAL;
+		}
+		i = 0;
+		nla_for_each_nested(attr, tb[TCA_MQPRIO_MIN_RATE64],
+				    rem) {
+			if (nla_type(attr) != TCA_MQPRIO_MIN_RATE64) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Attribute type expected to be TCA_MQPRIO_MIN_RATE64");
+				return -EINVAL;
+			}
+
+			if (nla_len(attr) != sizeof(u64)) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Attribute TCA_MQPRIO_MIN_RATE64 expected to have 8 bytes length");
+				return -EINVAL;
+			}
+
+			if (i >= qopt->num_tc)
+				break;
+			priv->min_rate[i] = *(u64 *)nla_data(attr);
+			i++;
+		}
+		priv->flags |= TC_MQPRIO_F_MIN_RATE;
+	}
+
+	if (tb[TCA_MQPRIO_MAX_RATE64]) {
+		if (priv->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[TCA_MQPRIO_MAX_RATE64],
+					    "max_rate accepted only when shaper is in bw_rlimit mode");
+			return -EINVAL;
+		}
+		i = 0;
+		nla_for_each_nested(attr, tb[TCA_MQPRIO_MAX_RATE64],
+				    rem) {
+			if (nla_type(attr) != TCA_MQPRIO_MAX_RATE64) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Attribute type expected to be TCA_MQPRIO_MAX_RATE64");
+				return -EINVAL;
+			}
+
+			if (nla_len(attr) != sizeof(u64)) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Attribute TCA_MQPRIO_MAX_RATE64 expected to have 8 bytes length");
+				return -EINVAL;
+			}
+
+			if (i >= qopt->num_tc)
+				break;
+			priv->max_rate[i] = *(u64 *)nla_data(attr);
+			i++;
+		}
+		priv->flags |= TC_MQPRIO_F_MAX_RATE;
+	}
+
+	return 0;
+}
+
 static int mqprio_init(struct Qdisc *sch, struct nlattr *opt,
 		       struct netlink_ext_ack *extack)
 {
@@ -139,9 +230,6 @@ static int mqprio_init(struct Qdisc *sch, struct nlattr *opt,
 	struct Qdisc *qdisc;
 	int i, err = -EOPNOTSUPP;
 	struct tc_mqprio_qopt *qopt = NULL;
-	struct nlattr *tb[TCA_MQPRIO_MAX + 1];
-	struct nlattr *attr;
-	int rem;
 	int len;
 
 	BUILD_BUG_ON(TC_MAX_QUEUE != TC_QOPT_MAX_QUEUE);
@@ -166,55 +254,9 @@ static int mqprio_init(struct Qdisc *sch, struct nlattr *opt,
 
 	len = nla_len(opt) - NLA_ALIGN(sizeof(*qopt));
 	if (len > 0) {
-		err = parse_attr(tb, TCA_MQPRIO_MAX, opt, mqprio_policy,
-				 sizeof(*qopt));
-		if (err < 0)
+		err = mqprio_parse_nlattr(sch, qopt, opt, extack);
+		if (err)
 			return err;
-
-		if (!qopt->hw)
-			return -EINVAL;
-
-		if (tb[TCA_MQPRIO_MODE]) {
-			priv->flags |= TC_MQPRIO_F_MODE;
-			priv->mode = *(u16 *)nla_data(tb[TCA_MQPRIO_MODE]);
-		}
-
-		if (tb[TCA_MQPRIO_SHAPER]) {
-			priv->flags |= TC_MQPRIO_F_SHAPER;
-			priv->shaper = *(u16 *)nla_data(tb[TCA_MQPRIO_SHAPER]);
-		}
-
-		if (tb[TCA_MQPRIO_MIN_RATE64]) {
-			if (priv->shaper != TC_MQPRIO_SHAPER_BW_RATE)
-				return -EINVAL;
-			i = 0;
-			nla_for_each_nested(attr, tb[TCA_MQPRIO_MIN_RATE64],
-					    rem) {
-				if (nla_type(attr) != TCA_MQPRIO_MIN_RATE64)
-					return -EINVAL;
-				if (i >= qopt->num_tc)
-					break;
-				priv->min_rate[i] = *(u64 *)nla_data(attr);
-				i++;
-			}
-			priv->flags |= TC_MQPRIO_F_MIN_RATE;
-		}
-
-		if (tb[TCA_MQPRIO_MAX_RATE64]) {
-			if (priv->shaper != TC_MQPRIO_SHAPER_BW_RATE)
-				return -EINVAL;
-			i = 0;
-			nla_for_each_nested(attr, tb[TCA_MQPRIO_MAX_RATE64],
-					    rem) {
-				if (nla_type(attr) != TCA_MQPRIO_MAX_RATE64)
-					return -EINVAL;
-				if (i >= qopt->num_tc)
-					break;
-				priv->max_rate[i] = *(u64 *)nla_data(attr);
-				i++;
-			}
-			priv->flags |= TC_MQPRIO_F_MAX_RATE;
-		}
 	}
 
 	/* pre-allocate qdisc, attachment can't fail */
diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index d67440de011e..2b236d95a646 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -1960,7 +1960,8 @@ static void tipc_crypto_rcv_complete(struct net *net, struct tipc_aead *aead,
 
 	skb_reset_network_header(*skb);
 	skb_pull(*skb, tipc_ehdr_size(ehdr));
-	pskb_trim(*skb, (*skb)->len - aead->authsize);
+	if (pskb_trim(*skb, (*skb)->len - aead->authsize))
+		goto free_skb;
 
 	/* Validate TIPCv2 message */
 	if (unlikely(!tipc_msg_validate(skb))) {
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 5e000fde8067..a9c5b6594889 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -583,7 +583,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 				 n->capabilities, &n->bc_entry.inputq1,
 				 &n->bc_entry.namedq, snd_l, &n->bc_entry.link)) {
 		pr_warn("Broadcast rcv link creation failed, no memory\n");
-		kfree(n);
+		tipc_node_put(n);
 		n = NULL;
 		goto exit;
 	}
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cb34a62075b1..f93b68a2a839 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9457,6 +9457,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8811, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x8812, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
+	SND_PCI_QUIRK(0x103c, 0x881d, "HP 250 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8847, "HP EliteBook x360 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884b, "HP EliteBook 840 Aero G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
@@ -9580,6 +9581,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1d1f, "ASUS ROG Strix G17 2023 (G713PV)", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402", ALC245_FIXUP_CS35L41_SPI_2),
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 791d8738d1c0..a05d4dafd3d7 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2308,6 +2308,9 @@ static int wm8904_i2c_probe(struct i2c_client *i2c)
 	regmap_update_bits(wm8904->regmap, WM8904_BIAS_CONTROL_0,
 			    WM8904_POBCTRL, 0);
 
+	/* Fill the cache for the ADC test register */
+	regmap_read(wm8904->regmap, WM8904_ADC_TEST_0, &val);
+
 	/* Can leave the device powered off until we need it */
 	regcache_cache_only(wm8904->regmap, true);
 	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 275aba8e0c46..fb6806b2db85 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -751,6 +751,8 @@ static int fsl_spdif_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		regmap_update_bits(regmap, REG_SPDIF_SCR, dmaen, 0);
 		regmap_update_bits(regmap, REG_SPDIF_SIE, intr, 0);
+		regmap_write(regmap, REG_SPDIF_STL, 0x0);
+		regmap_write(regmap, REG_SPDIF_STR, 0x0);
 		break;
 	default:
 		return -EINVAL;
diff --git a/tools/testing/radix-tree/linux/init.h b/tools/testing/radix-tree/linux/init.h
index 1bb0afc21309..81563c3dfce7 100644
--- a/tools/testing/radix-tree/linux/init.h
+++ b/tools/testing/radix-tree/linux/init.h
@@ -1 +1,2 @@
 #define __init
+#define __exit
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index d1ab5f23f4e4..cd96a3ee7bb8 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -13,6 +13,7 @@
 #include "test.h"
 #include <stdlib.h>
 #include <time.h>
+#include "linux/init.h"
 
 #define module_init(x)
 #define module_exit(x)
@@ -58,7 +59,7 @@ struct rcu_reader_struct {
  * check_new_node() - Check the creation of new nodes and error path
  * verification.
  */
-static noinline void check_new_node(struct maple_tree *mt)
+static noinline void __init check_new_node(struct maple_tree *mt)
 {
 
 	struct maple_node *mn, *mn2, *mn3;
@@ -430,7 +431,7 @@ static noinline void check_new_node(struct maple_tree *mt)
 /*
  * Check erasing including RCU.
  */
-static noinline void check_erase(struct maple_tree *mt, unsigned long index,
+static noinline void __init check_erase(struct maple_tree *mt, unsigned long index,
 		void *ptr)
 {
 	MT_BUG_ON(mt, mtree_test_erase(mt, index) != ptr);
@@ -440,24 +441,24 @@ static noinline void check_erase(struct maple_tree *mt, unsigned long index,
 #define erase_check_insert(mt, i) check_insert(mt, set[i], entry[i%2])
 #define erase_check_erase(mt, i) check_erase(mt, set[i], entry[i%2])
 
-static noinline void check_erase_testset(struct maple_tree *mt)
+static noinline void __init check_erase_testset(struct maple_tree *mt)
 {
-	unsigned long set[] = { 5015, 5014, 5017, 25, 1000,
-				1001, 1002, 1003, 1005, 0,
-				6003, 6002, 6008, 6012, 6015,
-				7003, 7002, 7008, 7012, 7015,
-				8003, 8002, 8008, 8012, 8015,
-				9003, 9002, 9008, 9012, 9015,
-				10003, 10002, 10008, 10012, 10015,
-				11003, 11002, 11008, 11012, 11015,
-				12003, 12002, 12008, 12012, 12015,
-				13003, 13002, 13008, 13012, 13015,
-				14003, 14002, 14008, 14012, 14015,
-				15003, 15002, 15008, 15012, 15015,
-			      };
-
-
-	void *ptr = &set;
+	static const unsigned long set[] = { 5015, 5014, 5017, 25, 1000,
+					     1001, 1002, 1003, 1005, 0,
+					     6003, 6002, 6008, 6012, 6015,
+					     7003, 7002, 7008, 7012, 7015,
+					     8003, 8002, 8008, 8012, 8015,
+					     9003, 9002, 9008, 9012, 9015,
+					     10003, 10002, 10008, 10012, 10015,
+					     11003, 11002, 11008, 11012, 11015,
+					     12003, 12002, 12008, 12012, 12015,
+					     13003, 13002, 13008, 13012, 13015,
+					     14003, 14002, 14008, 14012, 14015,
+					     15003, 15002, 15008, 15012, 15015,
+					   };
+
+
+	void *ptr = &check_erase_testset;
 	void *entry[2] = { ptr, mt };
 	void *root_node;
 
@@ -714,7 +715,7 @@ static noinline void check_erase_testset(struct maple_tree *mt)
 int mas_ce2_over_count(struct ma_state *mas_start, struct ma_state *mas_end,
 		      void *s_entry, unsigned long s_min,
 		      void *e_entry, unsigned long e_max,
-		      unsigned long *set, int i, bool null_entry)
+		      const unsigned long *set, int i, bool null_entry)
 {
 	int count = 0, span = 0;
 	unsigned long retry = 0;
@@ -944,8 +945,8 @@ static inline void *mas_range_load(struct ma_state *mas,
 }
 
 #if defined(CONFIG_64BIT)
-static noinline void check_erase2_testset(struct maple_tree *mt,
-		unsigned long *set, unsigned long size)
+static noinline void __init check_erase2_testset(struct maple_tree *mt,
+		const unsigned long *set, unsigned long size)
 {
 	int entry_count = 0;
 	int check = 0;
@@ -1089,11 +1090,11 @@ static noinline void check_erase2_testset(struct maple_tree *mt,
 
 
 /* These tests were pulled from KVM tree modifications which failed. */
-static noinline void check_erase2_sets(struct maple_tree *mt)
+static noinline void __init check_erase2_sets(struct maple_tree *mt)
 {
 	void *entry;
 	unsigned long start = 0;
-	unsigned long set[] = {
+	static const unsigned long set[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140721266458624, 140737488351231,
 ERASE, 140721266458624, 140737488351231,
@@ -1111,7 +1112,7 @@ ERASE, 140253902692352, 140253902864383,
 STORE, 140253902692352, 140253902696447,
 STORE, 140253902696448, 140253902864383,
 		};
-	unsigned long set2[] = {
+	static const unsigned long set2[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140735933583360, 140737488351231,
 ERASE, 140735933583360, 140737488351231,
@@ -1135,7 +1136,7 @@ STORE, 140277094813696, 140277094821887,
 STORE, 140277094821888, 140277094825983,
 STORE, 140735933906944, 140735933911039,
 	};
-	unsigned long set3[] = {
+	static const unsigned long set3[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140735790264320, 140737488351231,
 ERASE, 140735790264320, 140737488351231,
@@ -1178,7 +1179,7 @@ STORE, 47135835840512, 47135835885567,
 STORE, 47135835885568, 47135835893759,
 	};
 
-	unsigned long set4[] = {
+	static const unsigned long set4[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140728251703296, 140737488351231,
 ERASE, 140728251703296, 140737488351231,
@@ -1199,7 +1200,7 @@ ERASE, 47646523277312, 47646523445247,
 STORE, 47646523277312, 47646523400191,
 	};
 
-	unsigned long set5[] = {
+	static const unsigned long set5[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140726874062848, 140737488351231,
 ERASE, 140726874062848, 140737488351231,
@@ -1332,7 +1333,7 @@ STORE, 47884791619584, 47884791623679,
 STORE, 47884791623680, 47884791627775,
 	};
 
-	unsigned long set6[] = {
+	static const unsigned long set6[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140722999021568, 140737488351231,
 ERASE, 140722999021568, 140737488351231,
@@ -1464,7 +1465,7 @@ ERASE, 47430432014336, 47430432022527,
 STORE, 47430432014336, 47430432018431,
 STORE, 47430432018432, 47430432022527,
 	};
-	unsigned long set7[] = {
+	static const unsigned long set7[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140729808330752, 140737488351231,
 ERASE, 140729808330752, 140737488351231,
@@ -1596,7 +1597,7 @@ ERASE, 47439987130368, 47439987138559,
 STORE, 47439987130368, 47439987134463,
 STORE, 47439987134464, 47439987138559,
 	};
-	unsigned long set8[] = {
+	static const unsigned long set8[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140722482974720, 140737488351231,
 ERASE, 140722482974720, 140737488351231,
@@ -1729,7 +1730,7 @@ STORE, 47708488638464, 47708488642559,
 STORE, 47708488642560, 47708488646655,
 	};
 
-	unsigned long set9[] = {
+	static const unsigned long set9[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140736427839488, 140737488351231,
 ERASE, 140736427839488, 140736427839488,
@@ -5595,7 +5596,7 @@ ERASE, 47906195480576, 47906195480576,
 STORE, 94641242615808, 94641242750975,
 	};
 
-	unsigned long set10[] = {
+	static const unsigned long set10[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140736427839488, 140737488351231,
 ERASE, 140736427839488, 140736427839488,
@@ -9459,7 +9460,7 @@ STORE, 139726599680000, 139726599684095,
 ERASE, 47906195480576, 47906195480576,
 STORE, 94641242615808, 94641242750975,
 	};
-	unsigned long set11[] = {
+	static const unsigned long set11[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140732658499584, 140737488351231,
 ERASE, 140732658499584, 140732658499584,
@@ -9485,7 +9486,7 @@ STORE, 140732658565120, 140732658569215,
 STORE, 140732658552832, 140732658565119,
 	};
 
-	unsigned long set12[] = { /* contains 12 values. */
+	static const unsigned long set12[] = { /* contains 12 values. */
 STORE, 140737488347136, 140737488351231,
 STORE, 140732658499584, 140737488351231,
 ERASE, 140732658499584, 140732658499584,
@@ -9512,7 +9513,7 @@ STORE, 140732658552832, 140732658565119,
 STORE, 140014592741375, 140014592741375, /* contrived */
 STORE, 140014592733184, 140014592741376, /* creates first entry retry. */
 	};
-	unsigned long set13[] = {
+	static const unsigned long set13[] = {
 STORE, 140373516247040, 140373516251135,/*: ffffa2e7b0e10d80 */
 STORE, 140373516251136, 140373516255231,/*: ffffa2e7b1195d80 */
 STORE, 140373516255232, 140373516443647,/*: ffffa2e7b0e109c0 */
@@ -9525,7 +9526,7 @@ STORE, 140373518684160, 140373518688254,/*: ffffa2e7b05fec00 */
 STORE, 140373518688256, 140373518692351,/*: ffffa2e7bfbdcd80 */
 STORE, 140373518692352, 140373518696447,/*: ffffa2e7b0749e40 */
 	};
-	unsigned long set14[] = {
+	static const unsigned long set14[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140731667996672, 140737488351231,
 SNULL, 140731668000767, 140737488351231,
@@ -9809,7 +9810,7 @@ SNULL, 139826136543232, 139826136809471,
 STORE, 139826136809472, 139826136842239,
 STORE, 139826136543232, 139826136809471,
 	};
-	unsigned long set15[] = {
+	static const unsigned long set15[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140722061451264, 140737488351231,
 SNULL, 140722061455359, 140737488351231,
@@ -10094,7 +10095,7 @@ STORE, 139906808958976, 139906808991743,
 STORE, 139906808692736, 139906808958975,
 	};
 
-	unsigned long set16[] = {
+	static const unsigned long set16[] = {
 STORE, 94174808662016, 94174809321471,
 STORE, 94174811414528, 94174811426815,
 STORE, 94174811426816, 94174811430911,
@@ -10305,7 +10306,7 @@ STORE, 139921865613312, 139921865617407,
 STORE, 139921865547776, 139921865564159,
 	};
 
-	unsigned long set17[] = {
+	static const unsigned long set17[] = {
 STORE, 94397057224704, 94397057646591,
 STORE, 94397057650688, 94397057691647,
 STORE, 94397057691648, 94397057695743,
@@ -10367,7 +10368,7 @@ STORE, 140720477511680, 140720477646847,
 STORE, 140720478302208, 140720478314495,
 STORE, 140720478314496, 140720478318591,
 	};
-	unsigned long set18[] = {
+	static const unsigned long set18[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140724953673728, 140737488351231,
 SNULL, 140724953677823, 140737488351231,
@@ -10400,7 +10401,7 @@ STORE, 140222970597376, 140222970605567,
 ERASE, 140222970597376, 140222970605567,
 STORE, 140222970597376, 140222970605567,
 	};
-	unsigned long set19[] = {
+	static const unsigned long set19[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140725182459904, 140737488351231,
 SNULL, 140725182463999, 140737488351231,
@@ -10669,7 +10670,7 @@ STORE, 140656836775936, 140656836780031,
 STORE, 140656787476480, 140656791920639,
 ERASE, 140656774639616, 140656779083775,
 	};
-	unsigned long set20[] = {
+	static const unsigned long set20[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140735952392192, 140737488351231,
 SNULL, 140735952396287, 140737488351231,
@@ -10825,7 +10826,7 @@ STORE, 140590386819072, 140590386823167,
 STORE, 140590386823168, 140590386827263,
 SNULL, 140590376591359, 140590376595455,
 	};
-	unsigned long set21[] = {
+	static const unsigned long set21[] = {
 STORE, 93874710941696, 93874711363583,
 STORE, 93874711367680, 93874711408639,
 STORE, 93874711408640, 93874711412735,
@@ -10895,7 +10896,7 @@ ERASE, 140708393312256, 140708393316351,
 ERASE, 140708393308160, 140708393312255,
 ERASE, 140708393291776, 140708393308159,
 	};
-	unsigned long set22[] = {
+	static const unsigned long set22[] = {
 STORE, 93951397134336, 93951397183487,
 STORE, 93951397183488, 93951397728255,
 STORE, 93951397728256, 93951397826559,
@@ -11022,7 +11023,7 @@ STORE, 140551361253376, 140551361519615,
 ERASE, 140551361253376, 140551361519615,
 	};
 
-	unsigned long set23[] = {
+	static const unsigned long set23[] = {
 STORE, 94014447943680, 94014448156671,
 STORE, 94014450253824, 94014450257919,
 STORE, 94014450257920, 94014450266111,
@@ -14346,7 +14347,7 @@ SNULL, 140175956627455, 140175985139711,
 STORE, 140175927242752, 140175956627455,
 STORE, 140175956627456, 140175985139711,
 	};
-	unsigned long set24[] = {
+	static const unsigned long set24[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140735281639424, 140737488351231,
 SNULL, 140735281643519, 140737488351231,
@@ -15508,7 +15509,7 @@ ERASE, 139635393024000, 139635401412607,
 ERASE, 139635384627200, 139635384631295,
 ERASE, 139635384631296, 139635393019903,
 	};
-	unsigned long set25[] = {
+	static const unsigned long set25[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140737488343040, 140737488351231,
 STORE, 140722547441664, 140737488351231,
@@ -22296,7 +22297,7 @@ STORE, 140249652703232, 140249682087935,
 STORE, 140249682087936, 140249710600191,
 	};
 
-	unsigned long set26[] = {
+	static const unsigned long set26[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140729464770560, 140737488351231,
 SNULL, 140729464774655, 140737488351231,
@@ -22320,7 +22321,7 @@ ERASE, 140109040951296, 140109040959487,
 STORE, 140109040955392, 140109040959487,
 ERASE, 140109040955392, 140109040959487,
 	};
-	unsigned long set27[] = {
+	static const unsigned long set27[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140726128070656, 140737488351231,
 SNULL, 140726128074751, 140737488351231,
@@ -22716,7 +22717,7 @@ STORE, 140415509696512, 140415535910911,
 ERASE, 140415537422336, 140415562588159,
 STORE, 140415482433536, 140415509696511,
 	};
-	unsigned long set28[] = {
+	static const unsigned long set28[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140722475622400, 140737488351231,
 SNULL, 140722475626495, 140737488351231,
@@ -22784,7 +22785,7 @@ STORE, 139918413348864, 139918413352959,
 ERASE, 139918413316096, 139918413344767,
 STORE, 93865848528896, 93865848664063,
 	};
-	unsigned long set29[] = {
+	static const unsigned long set29[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140734467944448, 140737488351231,
 SNULL, 140734467948543, 140737488351231,
@@ -23659,7 +23660,7 @@ ERASE, 140143079972864, 140143088361471,
 ERASE, 140143205793792, 140143205797887,
 ERASE, 140143205797888, 140143214186495,
 	};
-	unsigned long set30[] = {
+	static const unsigned long set30[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140733436743680, 140737488351231,
 SNULL, 140733436747775, 140737488351231,
@@ -24541,7 +24542,7 @@ ERASE, 140165225893888, 140165225897983,
 ERASE, 140165225897984, 140165234286591,
 ERASE, 140165058105344, 140165058109439,
 	};
-	unsigned long set31[] = {
+	static const unsigned long set31[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140730890784768, 140737488351231,
 SNULL, 140730890788863, 140737488351231,
@@ -25354,7 +25355,7 @@ ERASE, 140623906590720, 140623914979327,
 ERASE, 140622950277120, 140622950281215,
 ERASE, 140622950281216, 140622958669823,
 	};
-	unsigned long set32[] = {
+	static const unsigned long set32[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140731244212224, 140737488351231,
 SNULL, 140731244216319, 140737488351231,
@@ -26150,7 +26151,7 @@ ERASE, 140400417288192, 140400425676799,
 ERASE, 140400283066368, 140400283070463,
 ERASE, 140400283070464, 140400291459071,
 	};
-	unsigned long set33[] = {
+	static const unsigned long set33[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140734562918400, 140737488351231,
 SNULL, 140734562922495, 140737488351231,
@@ -26292,7 +26293,7 @@ STORE, 140582961786880, 140583003750399,
 ERASE, 140582961786880, 140583003750399,
 	};
 
-	unsigned long set34[] = {
+	static const unsigned long set34[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140731327180800, 140737488351231,
 SNULL, 140731327184895, 140737488351231,
@@ -27173,7 +27174,7 @@ ERASE, 140012522094592, 140012530483199,
 ERASE, 140012033142784, 140012033146879,
 ERASE, 140012033146880, 140012041535487,
 	};
-	unsigned long set35[] = {
+	static const unsigned long set35[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140730536939520, 140737488351231,
 SNULL, 140730536943615, 140737488351231,
@@ -27930,7 +27931,7 @@ ERASE, 140474471936000, 140474480324607,
 ERASE, 140474396430336, 140474396434431,
 ERASE, 140474396434432, 140474404823039,
 	};
-	unsigned long set36[] = {
+	static const unsigned long set36[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140723893125120, 140737488351231,
 SNULL, 140723893129215, 140737488351231,
@@ -28791,7 +28792,7 @@ ERASE, 140121890357248, 140121898745855,
 ERASE, 140121269587968, 140121269592063,
 ERASE, 140121269592064, 140121277980671,
 	};
-	unsigned long set37[] = {
+	static const unsigned long set37[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140722404016128, 140737488351231,
 SNULL, 140722404020223, 140737488351231,
@@ -28917,7 +28918,7 @@ STORE, 139759821246464, 139759888355327,
 ERASE, 139759821246464, 139759888355327,
 ERASE, 139759888355328, 139759955464191,
 	};
-	unsigned long set38[] = {
+	static const unsigned long set38[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140730666221568, 140737488351231,
 SNULL, 140730666225663, 140737488351231,
@@ -29727,7 +29728,7 @@ ERASE, 140613504712704, 140613504716799,
 ERASE, 140613504716800, 140613513105407,
 	};
 
-	unsigned long set39[] = {
+	static const unsigned long set39[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140736271417344, 140737488351231,
 SNULL, 140736271421439, 140737488351231,
@@ -30099,7 +30100,7 @@ STORE, 140325364428800, 140325372821503,
 STORE, 140325356036096, 140325364428799,
 SNULL, 140325364432895, 140325372821503,
 	};
-	unsigned long set40[] = {
+	static const unsigned long set40[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140734309167104, 140737488351231,
 SNULL, 140734309171199, 140737488351231,
@@ -30850,7 +30851,7 @@ ERASE, 140320289300480, 140320289304575,
 ERASE, 140320289304576, 140320297693183,
 ERASE, 140320163409920, 140320163414015,
 	};
-	unsigned long set41[] = {
+	static const unsigned long set41[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140728157171712, 140737488351231,
 SNULL, 140728157175807, 140737488351231,
@@ -31160,7 +31161,7 @@ STORE, 94376135090176, 94376135094271,
 STORE, 94376135094272, 94376135098367,
 SNULL, 94376135094272, 94377208836095,
 	};
-	unsigned long set42[] = {
+	static const unsigned long set42[] = {
 STORE, 314572800, 1388314623,
 STORE, 1462157312, 1462169599,
 STORE, 1462169600, 1462185983,
@@ -33837,7 +33838,7 @@ SNULL, 3798999040, 3799101439,
  */
 	};
 
-	unsigned long set43[] = {
+	static const unsigned long set43[] = {
 STORE, 140737488347136, 140737488351231,
 STORE, 140734187720704, 140737488351231,
 SNULL, 140734187724800, 140737488351231,
@@ -34971,7 +34972,7 @@ void run_check_rcu_slowread(struct maple_tree *mt, struct rcu_test_struct *vals)
 	MT_BUG_ON(mt, !vals->seen_entry3);
 	MT_BUG_ON(mt, !vals->seen_both);
 }
-static noinline void check_rcu_simulated(struct maple_tree *mt)
+static noinline void __init check_rcu_simulated(struct maple_tree *mt)
 {
 	unsigned long i, nr_entries = 1000;
 	unsigned long target = 4320;
@@ -35132,7 +35133,7 @@ static noinline void check_rcu_simulated(struct maple_tree *mt)
 	rcu_unregister_thread();
 }
 
-static noinline void check_rcu_threaded(struct maple_tree *mt)
+static noinline void __init check_rcu_threaded(struct maple_tree *mt)
 {
 	unsigned long i, nr_entries = 1000;
 	struct rcu_test_struct vals;
@@ -35341,7 +35342,7 @@ static void check_dfs_preorder(struct maple_tree *mt)
 /* End of depth first search tests */
 
 /* Preallocation testing */
-static noinline void check_prealloc(struct maple_tree *mt)
+static noinline void __init check_prealloc(struct maple_tree *mt)
 {
 	unsigned long i, max = 100;
 	unsigned long allocated;
@@ -35469,7 +35470,7 @@ static noinline void check_prealloc(struct maple_tree *mt)
 /* End of preallocation testing */
 
 /* Spanning writes, writes that span nodes and layers of the tree */
-static noinline void check_spanning_write(struct maple_tree *mt)
+static noinline void __init check_spanning_write(struct maple_tree *mt)
 {
 	unsigned long i, max = 5000;
 	MA_STATE(mas, mt, 1200, 2380);
@@ -35637,7 +35638,7 @@ static noinline void check_spanning_write(struct maple_tree *mt)
 /* End of spanning write testing */
 
 /* Writes to a NULL area that are adjacent to other NULLs */
-static noinline void check_null_expand(struct maple_tree *mt)
+static noinline void __init check_null_expand(struct maple_tree *mt)
 {
 	unsigned long i, max = 100;
 	unsigned char data_end;
@@ -35698,7 +35699,7 @@ static noinline void check_null_expand(struct maple_tree *mt)
 /* End of NULL area expansions */
 
 /* Checking for no memory is best done outside the kernel */
-static noinline void check_nomem(struct maple_tree *mt)
+static noinline void __init check_nomem(struct maple_tree *mt)
 {
 	MA_STATE(ms, mt, 1, 1);
 
@@ -35733,7 +35734,7 @@ static noinline void check_nomem(struct maple_tree *mt)
 	mtree_destroy(mt);
 }
 
-static noinline void check_locky(struct maple_tree *mt)
+static noinline void __init check_locky(struct maple_tree *mt)
 {
 	MA_STATE(ms, mt, 2, 2);
 	MA_STATE(reader, mt, 2, 2);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7b65003ee8cf..a3108c3cff47 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -151,9 +151,7 @@ check_tools()
 	elif ! iptables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without iptables tool"
 		exit $ksft_skip
-	fi
-
-	if ! ip6tables -V &> /dev/null; then
+	elif ! ip6tables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without ip6tables tool"
 		exit $ksft_skip
 	fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index af4fccd4f5cc..114c4ce719c7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -13,13 +13,15 @@ timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
 do_all_tests=1
+iptables="iptables"
+ip6tables="ip6tables"
 
 add_mark_rules()
 {
 	local ns=$1
 	local m=$2
 
-	for t in iptables ip6tables; do
+	for t in ${iptables} ${ip6tables}; do
 		# just to debug: check we have multiple subflows connection requests
 		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
 
@@ -92,14 +94,14 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-iptables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+# Use the legacy version if available to support old kernel versions
+if iptables-legacy -V &> /dev/null; then
+	iptables="iptables-legacy"
+	ip6tables="ip6tables-legacy"
+elif ! iptables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without iptables tool"
 	exit $ksft_skip
-fi
-
-ip6tables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+elif ! ip6tables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without ip6tables tool"
 	exit $ksft_skip
 fi
@@ -109,10 +111,10 @@ check_mark()
 	local ns=$1
 	local af=$2
 
-	tables=iptables
+	tables=${iptables}
 
 	if [ $af -eq 6 ];then
-		tables=ip6tables
+		tables=${ip6tables}
 	fi
 
 	counters=$(ip netns exec $ns $tables -v -L OUTPUT | grep DROP)
@@ -314,8 +316,8 @@ do_tcpinq_tests()
 {
 	local lret=0
 
-	ip netns exec "$ns1" iptables -F
-	ip netns exec "$ns1" ip6tables -F
+	ip netns exec "$ns1" ${iptables} -F
+	ip netns exec "$ns1" ${ip6tables} -F
 
 	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
 		echo "INFO: TCP_INQ not supported: SKIP"
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 640113f047ef..8123f4d15930 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4032,8 +4032,17 @@ static ssize_t kvm_vcpu_stats_read(struct file *file, char __user *user_buffer,
 			sizeof(vcpu->stat), user_buffer, size, offset);
 }
 
+static int kvm_vcpu_stats_release(struct inode *inode, struct file *file)
+{
+	struct kvm_vcpu *vcpu = file->private_data;
+
+	kvm_put_kvm(vcpu->kvm);
+	return 0;
+}
+
 static const struct file_operations kvm_vcpu_stats_fops = {
 	.read = kvm_vcpu_stats_read,
+	.release = kvm_vcpu_stats_release,
 	.llseek = noop_llseek,
 };
 
@@ -4054,6 +4063,9 @@ static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
 		put_unused_fd(fd);
 		return PTR_ERR(file);
 	}
+
+	kvm_get_kvm(vcpu->kvm);
+
 	file->f_mode |= FMODE_PREAD;
 	fd_install(fd, file);
 
@@ -4658,8 +4670,17 @@ static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
 				sizeof(kvm->stat), user_buffer, size, offset);
 }
 
+static int kvm_vm_stats_release(struct inode *inode, struct file *file)
+{
+	struct kvm *kvm = file->private_data;
+
+	kvm_put_kvm(kvm);
+	return 0;
+}
+
 static const struct file_operations kvm_vm_stats_fops = {
 	.read = kvm_vm_stats_read,
+	.release = kvm_vm_stats_release,
 	.llseek = noop_llseek,
 };
 
@@ -4678,6 +4699,9 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
 		put_unused_fd(fd);
 		return PTR_ERR(file);
 	}
+
+	kvm_get_kvm(kvm);
+
 	file->f_mode |= FMODE_PREAD;
 	fd_install(fd, file);
 
