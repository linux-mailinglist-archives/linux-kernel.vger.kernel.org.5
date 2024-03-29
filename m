Return-Path: <linux-kernel+bounces-124040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8783F891179
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF187B21C40
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281293FE23;
	Fri, 29 Mar 2024 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQZei34w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4983B3BBE8;
	Fri, 29 Mar 2024 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678189; cv=none; b=Fz6L1oe8GxC0paBzCXdHqMPCa5aUSUFVQkVz6xdQIw9QzNxYLBvxXh9H3EwKnzkDPEHhCHQyjkzkeEzTvCPNW1bbqUOhPuX8wXikaB9AuuYxgxHYGXstRVDMNHMWnG9UatHnK8j6ic+pQ4H9DTJ0XwjL0OKoaQdV4rGgIB8cghA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678189; c=relaxed/simple;
	bh=m/LrRS8Kqm0y+dXApdmaiqcIdS4WVMKaG8fq+VQ4pUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EjeiGTq+vLCuaPA3yqoO0p45f1MSl2rWlAjhqN91AnMlUgfmEHoMg1M171CCPJ339Tm7Ux3G7DH/q1b+Zkva+k3HbULSRmX2VXFz1M+WSNb7FgRVZuqrCDcG6mbIaGlJfoN3Eq9L88zBcsE3XKwGjSZoTLdN90j8xpMcpSaUOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQZei34w; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711678187; x=1743214187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m/LrRS8Kqm0y+dXApdmaiqcIdS4WVMKaG8fq+VQ4pUo=;
  b=hQZei34wH1QAEqUyYsPXghRocne3YVjZiUgEWWf+0ZUfngPi79j2v5c0
   K9Mi+F6IsQXsHUBfJitsTeHdB3dOr1EfvpuY3L64ACgMA7NldkPIcUJ/L
   pIap1AvtispDbSaiwV0W3v1TYEKWn44/NxtxkwfPz7V1sO2pCpBEeb2Z4
   JiFe+bJSdQZl2MMkxVKjQWmL7XcDkdx+R6M42n0AE9L5z9G8y00W2kaWq
   RjUUx2Dke77V5ZkCiF5xkS0bQFeRYkOPbQKZ8EUIUX6uWyWCzwTmpbz8M
   bGZCLXYCue/nZ9Pu93kRSW9SnSXW0C5mWM5lc99fm6u9HY0mqg/9ciWfE
   g==;
X-CSE-ConnectionGUID: mZfG+bePTYeuOwPgzbAbKQ==
X-CSE-MsgGUID: tz4t4HAbSF2uA/ysPlmyZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6700086"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6700086"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:09:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17301414"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 28 Mar 2024 19:09:46 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dm-devel@redhat.com
Cc: ebiggers@kernel.org,
	luto@kernel.org,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@kernel.org,
	x86@kernel.org,
	herbert@gondor.apana.org.au,
	ardb@kernel.org,
	elliott@hpe.com,
	dan.j.williams@intel.com,
	bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com,
	chang.seok.bae@intel.com,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Sangwhan Moon <sxm@google.com>
Subject: [PATCH v9 08/14] x86/PM/keylocker: Restore the wrapping key on the resume from ACPI S3/4
Date: Thu, 28 Mar 2024 18:53:40 -0700
Message-Id: <20240329015346.635933-9-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329015346.635933-1-chang.seok.bae@intel.com>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary use case for the feature is bare metal dm-crypt. The key
needs to be restored properly on wakeup, as dm-crypt does not prompt
for the key on resume from suspend. Even if the prompt performs for
unlocking the volume, where the hibernation image is stored, it still
expects to reuse the key handles within the hibernation image once it
is loaded.

== Wrapping-key Restore ==

To meet dm-crypt's expectations, the key handles in the suspend-image has
to remain valid after resuming from an S-state. However, when the system
enters ACPI S3 or S4 sleep states, the wrapping key is discarded.

Key Locker provides a mechanism to back up the wrapping key in
non-volatile storage. Therefore, upon boot, request a backup of the
wrapping key and copy it back to each CPU upon wakeup. If the backup
mechanism is unavailable, disable the feature unless CONFIG_SUSPEND=n.

== Restore Failure ==

In the event of a key restore failure, the kernel proceeds with an
initialized wrapping key state. This action invalidates any key handles
present in the suspend-image, leading to I/O errors in dm-crypt
operations.

However, data integrity remains intact, and access is restored with new
handles created by the new wrapping key at the next boot. At least,
manage a feature-specific flag to communicate with the crypto
implementation, ensuring to stop using AES instructions upon the key
restore failure, instead of abruptly disabling the feature.

== Off-states ==

While the backup may persist in non-volatile media across S5 and G3 "off"
states, it is neither architecturally guaranteed nor expected by
dm-crypt. Therefore, a reboot can address this scenario with a new
wrapping key, as dm-crypt prompts for the key whenever the volume is
started.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Sangwhan Moon <sxm@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
Changes from v8:
* Rebase on the previous patch (patch7) changes, separating the wrapping
  key restoration code from the initial load. Previously, the
  identify_cpu() -> setup_keylocker() sequence in the hotplug path could
  hit __init code, leading to an explosion. This change removes the
  initialization code from the hotplug path. (Sangwhan Moon)
* Turn copy_keylocker() to return bool for simplification.
* Rename the flag for clarity: 'valid_kl' -> 'valid_wrapping_key'.
* Don't export symbol for valid_keylocker(), as AES-KL will be built-in.
  (see patch14 for detail).
* Tweak code comments and the changelog.
* Revoke the review tag as the code change is significant.

Changes from v6:
* Limit the symbol export only when needed.
* Improve the coding style -- reduce an indent after
  'if() { ... return; }'. (Eric Biggers)
* Fix the coding style -- reduce an indent after if() {...return;}.
  (Eric Biggers) Tweak the comment along with that.
* Improve the function prototype, instead of using a macro. (Eric
  Biggers and Dave Hansen)
* Update the documentation:
  - Massage the changelog to clarify the problem-and-solution by
    sections
  - Clarify the comment about the key restore failure.

Changes from v5:
* Fix the 'valid_kl' flag not to be set when the feature is disabled.
  (Reported by Marvin Hsu marvin.hsu@intel.com) Add the function
  comment about this.
* Improve the error handling in setup_keylocker(). All the error cases
  fall through the end that disables the feature. Otherwise, all the
  successful cases return immediately.

Changes from v4:
* Update the changelog and title. (Rafael Wysocki)

Changes from v3:
* Fix the build issue with !X86_KEYLOCKER. (Eric Biggers)

Changes from RFC v2:
* Change the backup key failure handling. (Dan Williams)

Changes from RFC v1:
* Folded the warning message into the if condition check. (Rafael
  Wysocki)
* Rebase on the changes of the previous patches.
* Added error code for key restoration failures.
* Moved the restore helper.
* Added function descriptions.
---
 arch/x86/include/asm/keylocker.h | 10 ++++
 arch/x86/kernel/cpu/common.c     |  4 +-
 arch/x86/kernel/keylocker.c      | 88 ++++++++++++++++++++++++++++++++
 arch/x86/power/cpu.c             |  2 +
 4 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
index 1213d273c369..c93102101c41 100644
--- a/arch/x86/include/asm/keylocker.h
+++ b/arch/x86/include/asm/keylocker.h
@@ -28,5 +28,15 @@ struct iwkey {
 #define KEYLOCKER_CPUID_EBX_WIDE	BIT(2)
 #define KEYLOCKER_CPUID_EBX_BACKUP	BIT(4)
 
+#ifdef CONFIG_X86_KEYLOCKER
+void setup_keylocker(void);
+void restore_keylocker(void);
+extern bool valid_keylocker(void);
+#else
+static inline void setup_keylocker(void) { }
+static inline void restore_keylocker(void) { }
+static inline bool valid_keylocker(void) { return false; }
+#endif
+
 #endif /*__ASSEMBLY__ */
 #endif /* _ASM_KEYLOCKER_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5c1e6d6be267..bfbb1ca64664 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -62,6 +62,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/fred.h>
+#include <asm/keylocker.h>
 #include <asm/uv/uv.h>
 #include <asm/ia32.h>
 #include <asm/set_memory.h>
@@ -1826,10 +1827,11 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Disable the PN if appropriate */
 	squash_the_stupid_serial_number(c);
 
-	/* Set up SMEP/SMAP/UMIP */
+	/* Setup various Intel-specific CPU security features */
 	setup_smep(c);
 	setup_smap(c);
 	setup_umip(c);
+	setup_keylocker();
 
 	/* Enable FSGSBASE instructions if available. */
 	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
index 0d6b715baf1e..d5d11d0263b7 100644
--- a/arch/x86/kernel/keylocker.c
+++ b/arch/x86/kernel/keylocker.c
@@ -9,10 +9,24 @@
 
 #include <asm/fpu/api.h>
 #include <asm/keylocker.h>
+#include <asm/msr.h>
 #include <asm/processor.h>
 
 static struct iwkey wrapping_key __initdata;
 
+/*
+ * This flag is set when a wrapping key is successfully loaded. If a key
+ * restoration fails, it is reset. This state is exported to the crypto
+ * library, indicating whether Key Locker is usable. Thus, the feature
+ * can be soft-disabled based on this flag.
+ */
+static bool valid_wrapping_key;
+
+bool valid_keylocker(void)
+{
+	return valid_wrapping_key;
+}
+
 static void __init generate_keylocker_data(void)
 {
 	get_random_bytes(&wrapping_key.integrity_key, sizeof(wrapping_key.integrity_key));
@@ -37,9 +51,69 @@ static void __init load_keylocker(struct work_struct *unused)
 	kernel_fpu_end();
 }
 
+/**
+ * copy_keylocker - Copy the wrapping key from the backup.
+ *
+ * Returns:	true if successful, otherwise false.
+ */
+static bool copy_keylocker(void)
+{
+	u64 status;
+
+	wrmsrl(MSR_IA32_COPY_IWKEY_TO_LOCAL, 1);
+	rdmsrl(MSR_IA32_IWKEY_COPY_STATUS, status);
+	return !!(status & BIT(0));
+}
+
+/*
+ * On wakeup, APs copy a wrapping key after the boot CPU verifies a valid
+ * backup status through restore_keylocker(). Subsequently, they adhere
+ * to the error handling protocol by invalidating the flag.
+ */
+void setup_keylocker(void)
+{
+	if (!valid_wrapping_key)
+		return;
+
+	cr4_set_bits(X86_CR4_KEYLOCKER);
+
+	if (copy_keylocker())
+		return;
+
+	pr_err_once("x86/keylocker: Invalid copy status.\n");
+	valid_wrapping_key = false;
+}
+
+/* The boot CPU restores the wrapping key in the first place on wakeup. */
+void restore_keylocker(void)
+{
+	u64 backup_status;
+
+	if (!valid_wrapping_key)
+		return;
+
+	rdmsrl(MSR_IA32_IWKEY_BACKUP_STATUS, backup_status);
+	if (backup_status & BIT(0)) {
+		if (copy_keylocker())
+			return;
+		pr_err("x86/keylocker: Invalid copy state.\n");
+	} else {
+		pr_err("x86/keylocker: The key backup access failed with %s.\n",
+		       (backup_status & BIT(2)) ? "read error" : "invalid status");
+	}
+
+	/*
+	 * Invalidate the feature via this flag to indicate that the
+	 * crypto code should voluntarily stop using the feature, rather
+	 * than abruptly disabling it.
+	 */
+	valid_wrapping_key = false;
+}
+
 static int __init init_keylocker(void)
 {
 	u32 eax, ebx, ecx, edx;
+	bool backup_available;
 
 	if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER))
 		goto disable;
@@ -59,9 +133,23 @@ static int __init init_keylocker(void)
 		goto clear_cap;
 	}
 
+	/*
+	 * The backup is critical for restoring the wrapping key upon
+	 * wakeup.
+	 */
+	backup_available = !!(ebx & KEYLOCKER_CPUID_EBX_BACKUP);
+	if (!backup_available && IS_ENABLED(CONFIG_SUSPEND)) {
+		pr_debug("x86/keylocker: No key backup with possible S3/4.\n");
+		goto clear_cap;
+	}
+
 	generate_keylocker_data();
 	schedule_on_each_cpu(load_keylocker);
 	destroy_keylocker_data();
+	valid_wrapping_key = true;
+
+	if (backup_available)
+		wrmsrl(MSR_IA32_BACKUP_IWKEY_TO_PLATFORM, 1);
 
 	pr_info_once("x86/keylocker: Enabled.\n");
 	return 0;
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 63230ff8cf4f..e99be45354cd 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -27,6 +27,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cpu_device_id.h>
 #include <asm/microcode.h>
+#include <asm/keylocker.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -264,6 +265,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	x86_platform.restore_sched_clock_state();
 	cache_bp_restore();
 	perf_restore_debug_store();
+	restore_keylocker();
 
 	c = &cpu_data(smp_processor_id());
 	if (cpu_has(c, X86_FEATURE_MSR_IA32_FEAT_CTL))
-- 
2.34.1


