Return-Path: <linux-kernel+bounces-101913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E7987ACAB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83161F2FF0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B83585293;
	Wed, 13 Mar 2024 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQqDBVDF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB11684FA0;
	Wed, 13 Mar 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348053; cv=none; b=AhtZFDoSezyu4V0jkaUsdEfklkHMDRP6LvgSdLtUHEI6QRYSMcVPntq1jFt+s4EQNp1YGbcR6F11eLD1rloA6RxaSN5sHR97Gas+KDVCQHi8c2fzywwAPiMleHM7gGIbqNfWDUdMXBP935LnadVrBp9Pm98GQnno2G6QERBcR64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348053; c=relaxed/simple;
	bh=3AcXl/lCK2tXUlYXxRKfkB2LzrpM5KjRSduOs29irpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwCPErpvNDEqJ3uHkjGq6ZdjFZh2fwL4UooxporNZb49iV+1Ys7V1hQnCuYSSRO4xr+otUSAAp5DTKWrfDidc5ZCjZ5SUlH6rmqLmv2IlTtmAOTrDzhElKCJaPpAbvETOV62OFkMF73Bmgyrj5q5pUdAyovVsRkwXQywPX3gXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQqDBVDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1276C433A6;
	Wed, 13 Mar 2024 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348052;
	bh=3AcXl/lCK2tXUlYXxRKfkB2LzrpM5KjRSduOs29irpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQqDBVDF2joumvx4hntU1DzYF7yGvMs7ZugtBMurhb2Yab7MUCjXtA3Njqnlkho8A
	 cfg55t8/0r40rM9VR3gACBfNZb7Gh3zxKRhjU1ptvsHhGVazRzFLFtXFATn8UuhN0m
	 5Li1daqCUt7pXseg5qwV2IlS74WUqNTZObSXtOiw8f0GWuYCuBK+DgiDoaLDghYFU5
	 QWVlJ5WFqCIiSJuNPugWGL426tPfvjvESwKPF7qJFIaTiu0bPY/f9/HANoGYkZJkFe
	 uHlwGK4Qk86Cus6QhRXPYuZ1QRHE48+bqr03d5TBfRoDK8u5J4pAyQgahNugKBj4OQ
	 oja3TD2S5fPjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1 45/71] x86/rfds: Mitigate Register File Data Sampling (RFDS)
Date: Wed, 13 Mar 2024 12:39:31 -0400
Message-ID: <20240313163957.615276-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit 8076fcde016c9c0e0660543e67bff86cb48a7c9c upstream.

RFDS is a CPU vulnerability that may allow userspace to infer kernel
stale data previously used in floating point registers, vector registers
and integer registers. RFDS only affects certain Intel Atom processors.

Intel released a microcode update that uses VERW instruction to clear
the affected CPU buffers. Unlike MDS, none of the affected cores support
SMT.

Add RFDS bug infrastructure and enable the VERW based mitigation by
default, that clears the affected buffers just before exiting to
userspace. Also add sysfs reporting and cmdline parameter
"reg_file_data_sampling" to control the mitigation.

For details see:
Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  1 +
 .../admin-guide/kernel-parameters.txt         | 21 +++++
 arch/x86/Kconfig                              | 11 +++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  8 ++
 arch/x86/kernel/cpu/bugs.c                    | 78 ++++++++++++++++++-
 arch/x86/kernel/cpu/common.c                  | 38 ++++++++-
 drivers/base/cpu.c                            |  8 ++
 include/linux/cpu.h                           |  2 +
 9 files changed, 162 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 13c01b641dc70..78c26280c473b 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -519,6 +519,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/mds
 		/sys/devices/system/cpu/vulnerabilities/meltdown
 		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
+		/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling
 		/sys/devices/system/cpu/vulnerabilities/retbleed
 		/sys/devices/system/cpu/vulnerabilities/spec_store_bypass
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4ad60e127e048..2dfe75104e7de 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1107,6 +1107,26 @@
 			The filter can be disabled or changed to another
 			driver later using sysfs.
 
+	reg_file_data_sampling=
+			[X86] Controls mitigation for Register File Data
+			Sampling (RFDS) vulnerability. RFDS is a CPU
+			vulnerability which may allow userspace to infer
+			kernel data values previously stored in floating point
+			registers, vector registers, or integer registers.
+			RFDS only affects Intel Atom processors.
+
+			on:	Turns ON the mitigation.
+			off:	Turns OFF the mitigation.
+
+			This parameter overrides the compile time default set
+			by CONFIG_MITIGATION_RFDS. Mitigation cannot be
+			disabled when other VERW based mitigations (like MDS)
+			are enabled. In order to disable RFDS mitigation all
+			VERW based mitigations need to be disabled.
+
+			For details see:
+			Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
+
 	driver_async_probe=  [KNL]
 			List of driver names to be probed asynchronously. *
 			matches with all driver names. If * is specified, the
@@ -3262,6 +3282,7 @@
 					       nospectre_bhb [ARM64]
 					       nospectre_v1 [X86,PPC]
 					       nospectre_v2 [X86,PPC,S390,ARM64]
+					       reg_file_data_sampling=off [X86]
 					       retbleed=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
 					       spectre_v2_user=off [X86]
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2f7af61b49b6c..5caa023e98397 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2565,6 +2565,17 @@ config GDS_FORCE_MITIGATION
 
 	  If in doubt, say N.
 
+config MITIGATION_RFDS
+	bool "RFDS Mitigation"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Register File Data Sampling (RFDS) by default.
+	  RFDS is a hardware vulnerability which affects Intel Atom CPUs. It
+	  allows unprivileged speculative access to stale data previously
+	  stored in floating point, vector and integer registers.
+	  See also <file:Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst>
+
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b60f24b30cb90..b97a70aa4de90 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -477,4 +477,5 @@
 /* BUG word 2 */
 #define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* AMD SRSO bug */
 #define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* AMD DIV0 speculation bug */
+#define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* CPU is vulnerable to Register File Data Sampling */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ec955ab2ff034..005e41dc7ee5a 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -168,6 +168,14 @@
 						 * CPU is not vulnerable to Gather
 						 * Data Sampling (GDS).
 						 */
+#define ARCH_CAP_RFDS_NO		BIT(27)	/*
+						 * Not susceptible to Register
+						 * File Data Sampling.
+						 */
+#define ARCH_CAP_RFDS_CLEAR		BIT(28)	/*
+						 * VERW clears CPU Register
+						 * File.
+						 */
 
 #define ARCH_CAP_XAPIC_DISABLE		BIT(21)	/*
 						 * IA32_XAPIC_DISABLE_STATUS MSR
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c66f6eb40afb1..c68789fdc123b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -479,6 +479,57 @@ static int __init mmio_stale_data_parse_cmdline(char *str)
 }
 early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"Register File Data Sampling: " fmt
+
+enum rfds_mitigations {
+	RFDS_MITIGATION_OFF,
+	RFDS_MITIGATION_VERW,
+	RFDS_MITIGATION_UCODE_NEEDED,
+};
+
+/* Default mitigation for Register File Data Sampling */
+static enum rfds_mitigations rfds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_VERW : RFDS_MITIGATION_OFF;
+
+static const char * const rfds_strings[] = {
+	[RFDS_MITIGATION_OFF]			= "Vulnerable",
+	[RFDS_MITIGATION_VERW]			= "Mitigation: Clear Register File",
+	[RFDS_MITIGATION_UCODE_NEEDED]		= "Vulnerable: No microcode",
+};
+
+static void __init rfds_select_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off()) {
+		rfds_mitigation = RFDS_MITIGATION_OFF;
+		return;
+	}
+	if (rfds_mitigation == RFDS_MITIGATION_OFF)
+		return;
+
+	if (x86_read_arch_cap_msr() & ARCH_CAP_RFDS_CLEAR)
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+	else
+		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
+}
+
+static __init int rfds_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
+		return 0;
+
+	if (!strcmp(str, "off"))
+		rfds_mitigation = RFDS_MITIGATION_OFF;
+	else if (!strcmp(str, "on"))
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+
+	return 0;
+}
+early_param("reg_file_data_sampling", rfds_parse_cmdline);
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "" fmt
 
@@ -512,6 +563,11 @@ static void __init md_clear_update_mitigation(void)
 		mmio_mitigation = MMIO_MITIGATION_VERW;
 		mmio_select_mitigation();
 	}
+	if (rfds_mitigation == RFDS_MITIGATION_OFF &&
+	    boot_cpu_has_bug(X86_BUG_RFDS)) {
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+		rfds_select_mitigation();
+	}
 out:
 	if (boot_cpu_has_bug(X86_BUG_MDS))
 		pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
@@ -521,6 +577,8 @@ static void __init md_clear_update_mitigation(void)
 		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
 	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
 		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
+	if (boot_cpu_has_bug(X86_BUG_RFDS))
+		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
 }
 
 static void __init md_clear_select_mitigation(void)
@@ -528,11 +586,12 @@ static void __init md_clear_select_mitigation(void)
 	mds_select_mitigation();
 	taa_select_mitigation();
 	mmio_select_mitigation();
+	rfds_select_mitigation();
 
 	/*
-	 * As MDS, TAA and MMIO Stale Data mitigations are inter-related, update
-	 * and print their mitigation after MDS, TAA and MMIO Stale Data
-	 * mitigation selection is done.
+	 * As these mitigations are inter-related and rely on VERW instruction
+	 * to clear the microarchitural buffers, update and print their status
+	 * after mitigation selection is done for each of these vulnerabilities.
 	 */
 	md_clear_update_mitigation();
 }
@@ -2596,6 +2655,11 @@ static ssize_t mmio_stale_data_show_state(char *buf)
 			  sched_smt_active() ? "vulnerable" : "disabled");
 }
 
+static ssize_t rfds_show_state(char *buf)
+{
+	return sysfs_emit(buf, "%s\n", rfds_strings[rfds_mitigation]);
+}
+
 static char *stibp_state(void)
 {
 	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled))
@@ -2757,6 +2821,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_SRSO:
 		return srso_show_state(buf);
 
+	case X86_BUG_RFDS:
+		return rfds_show_state(buf);
+
 	default:
 		break;
 	}
@@ -2831,4 +2898,9 @@ ssize_t cpu_show_spec_rstack_overflow(struct device *dev, struct device_attribut
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_SRSO);
 }
+
+ssize_t cpu_show_reg_file_data_sampling(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_RFDS);
+}
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 454cdf3418624..758938c94b41e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1248,6 +1248,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define SRSO		BIT(5)
 /* CPU is affected by GDS */
 #define GDS		BIT(6)
+/* CPU is affected by Register File Data Sampling */
+#define RFDS		BIT(7)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
@@ -1275,9 +1277,18 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS),
 	VULNBL_INTEL_STEPPINGS(LAKEFIELD,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
 	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS),
-	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE_P,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE_S,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE_N,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO | RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_GOLDMONT,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_GOLDMONT_D,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_GOLDMONT_PLUS, X86_STEPPING_ANY,		RFDS),
 
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
@@ -1311,6 +1322,24 @@ static bool arch_cap_mmio_immune(u64 ia32_cap)
 		ia32_cap & ARCH_CAP_SBDR_SSDP_NO);
 }
 
+static bool __init vulnerable_to_rfds(u64 ia32_cap)
+{
+	/* The "immunity" bit trumps everything else: */
+	if (ia32_cap & ARCH_CAP_RFDS_NO)
+		return false;
+
+	/*
+	 * VMMs set ARCH_CAP_RFDS_CLEAR for processors not in the blacklist to
+	 * indicate that mitigation is needed because guest is running on a
+	 * vulnerable hardware or may migrate to such hardware:
+	 */
+	if (ia32_cap & ARCH_CAP_RFDS_CLEAR)
+		return true;
+
+	/* Only consult the blacklist when there is no enumeration: */
+	return cpu_matches(cpu_vuln_blacklist, RFDS);
+}
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_cap = x86_read_arch_cap_msr();
@@ -1419,6 +1448,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 			setup_force_cpu_bug(X86_BUG_SRSO);
 	}
 
+	if (vulnerable_to_rfds(ia32_cap))
+		setup_force_cpu_bug(X86_BUG_RFDS);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index dab70a65377c8..31da94afe4f3d 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -589,6 +589,12 @@ ssize_t __weak cpu_show_spec_rstack_overflow(struct device *dev,
 	return sysfs_emit(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_reg_file_data_sampling(struct device *dev,
+					       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
@@ -602,6 +608,7 @@ static DEVICE_ATTR(mmio_stale_data, 0444, cpu_show_mmio_stale_data, NULL);
 static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
 static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
 static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
+static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -617,6 +624,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_retbleed.attr,
 	&dev_attr_gather_data_sampling.attr,
 	&dev_attr_spec_rstack_overflow.attr,
+	&dev_attr_reg_file_data_sampling.attr,
 	NULL
 };
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 008bfa68cfabc..4b06b1f1e267a 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -74,6 +74,8 @@ extern ssize_t cpu_show_spec_rstack_overflow(struct device *dev,
 					     struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_gds(struct device *dev,
 			    struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
+					       struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
-- 
2.43.0


