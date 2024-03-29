Return-Path: <linux-kernel+bounces-124039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3550891176
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593D3290775
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30A03CF51;
	Fri, 29 Mar 2024 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLuu5WxX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AE43B791;
	Fri, 29 Mar 2024 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678188; cv=none; b=hsJXvUNcGW5SqkVN7rTZsFUbqp+E07RFGcj751M46SmewURCQeXMhHmpexYyfFBWMRg/7OQh+Sbso0xfxleXgPYemN2wANM384BI/xJAqtWbbMoRt6IKAxsMWjry3GlSM69UztbfV8oRWt6fB1rXlulKYSa5y55tdH1SDc341Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678188; c=relaxed/simple;
	bh=bKJ53VcpCk0oPkHnmZyx6yPAdxMIyd4w8zm9xu5vvYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StfOZaQnvFQsPmxZ+oYEHWlJw2R2cWePxIVqe8zMmu5ZJNftAbPc+efUzfyBVRQcRVpcRFW8FfBu1dASmj02FowPls7AP9tsOLH6MqT1daiO7bbsc1rZ2/x0n+7zrt1dq5irWmDKDgoi3BR32S6YXdzbPDs+vMd5tYkrcelgkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLuu5WxX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711678186; x=1743214186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bKJ53VcpCk0oPkHnmZyx6yPAdxMIyd4w8zm9xu5vvYk=;
  b=YLuu5WxXwS9W4ex9AJzo56ozGgCvxqo4DLdpWLpbG3u25cNWh24yjPMS
   hjreh8ukb/oLH/ItqEU3cOpYSFMrjSMunj6jcMAP6ZTrITY1jj/fNIbfL
   FKReAdQ4jn3n5LVYZ2aNh3K8VkPP6gmDO5dFlZ4ve1zJMvNBwP3l86TT8
   cM2Abj/iisMWoEPPSC4pH5Kv39RhTtPx8MwCsghtDHfulLbWTn4aW4QoY
   Cc9IDFDPK2NV+TRChKo4ttVO9krgIR4A+b7sgnzRBF0LMYhb7Vv3xbWP3
   H91OgFI66zHus9wn3E43qxFBueD4+sT8Qq121+vgeGrvqt9Z5ZYABoLKT
   g==;
X-CSE-ConnectionGUID: pFTEoLtbTqWjseADfWY3ew==
X-CSE-MsgGUID: DxZVAY0ZQj2jCHmPvMeAWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6700070"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6700070"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:09:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17301407"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 28 Mar 2024 19:09:45 -0700
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
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v9 07/14] x86/cpu/keylocker: Load a wrapping key at boot time
Date: Thu, 28 Mar 2024 18:53:39 -0700
Message-Id: <20240329015346.635933-8-chang.seok.bae@intel.com>
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

The wrapping key is an entity to encode a clear text key into a key
handle. This key is a pivot in protecting user keys. So the value has
to be randomized before being loaded in the software-invisible CPU
state.

The wrapping key needs to be established before the first user. Given
that the only proposed Linux use case for Key Locker is dm-crypt, the
feature could be lazily enabled before the first dm-crypt user arrives.

But there is no precedent for late enabling of CPU features and it
adds maintenance burden without demonstrative benefit outside of
minimizing the visibility of Key Locker to userspace.

Therefore, generate random bytes and load them at boot time, involving
clobbering XMM registers. Perform this process under arch_initcall(),
ensuring that it occurs after FPU initialization. Finally, flush out
random bytes after loading.

Given that the Linux Key Locker support is only intended for bare
metal dm-crypt use, and that switching wrapping key per virtual machine
is impractical, explicitly skip this setup in the X86_FEATURE_HYPERVISOR
case.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
Changes from v8:
* Invoke the setup code via arch_initcall(). The move was due to the
  upstream changes. Commit b81fac906a8f ("x86/fpu: Move FPU
  initialization into arch_cpu_finalize_init()") delays the FPU setup.
* Tweak code comments and the changelog.
* Revoke the review tag as the code change is significant.

Changes from v6:
* Switch to use 'static inline' for the empty functions, instead of
  macro that disallows type checks. (Eric Biggers and Dave Hansen)
* Use memzero_explicit() to wipe out the key data instead of writing
  the poison value over there. (Robert Elliott)
* Massage the changelog for the better readability.

Changes from v5:
* Call out the disabling when the feature is available on a virtual
  machine. Then, it will turn off the feature flag

Changes from RFC v2:
* Make bare metal only.
* Clean up the code (e.g. dynamically allocate the key cache).
  (Dan Williams)
* Massage the changelog.
* Move out the LOADIWKEY wrapper and the Key Locker CPUID defines.
---
 arch/x86/kernel/Makefile    |  1 +
 arch/x86/kernel/keylocker.c | 77 +++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 arch/x86/kernel/keylocker.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 74077694da7d..d105e5785b90 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -137,6 +137,7 @@ obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 obj-$(CONFIG_TRACING)			+= tracepoint.o
 obj-$(CONFIG_SCHED_MC_PRIO)		+= itmt.o
 obj-$(CONFIG_X86_UMIP)			+= umip.o
+obj-$(CONFIG_X86_KEYLOCKER)		+= keylocker.o
 
 obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
new file mode 100644
index 000000000000..0d6b715baf1e
--- /dev/null
+++ b/arch/x86/kernel/keylocker.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Setup Key Locker feature and support the wrapping key management.
+ */
+
+#include <linux/random.h>
+#include <linux/string.h>
+
+#include <asm/fpu/api.h>
+#include <asm/keylocker.h>
+#include <asm/processor.h>
+
+static struct iwkey wrapping_key __initdata;
+
+static void __init generate_keylocker_data(void)
+{
+	get_random_bytes(&wrapping_key.integrity_key, sizeof(wrapping_key.integrity_key));
+	get_random_bytes(&wrapping_key.encryption_key, sizeof(wrapping_key.encryption_key));
+}
+
+static void __init destroy_keylocker_data(void)
+{
+	memzero_explicit(&wrapping_key, sizeof(wrapping_key));
+}
+
+/*
+ * For loading the wrapping key into each CPU, the feature bit is set
+ * in the control register and FPU context management is performed.
+ */
+static void __init load_keylocker(struct work_struct *unused)
+{
+	cr4_set_bits(X86_CR4_KEYLOCKER);
+
+	kernel_fpu_begin();
+	load_xmm_iwkey(&wrapping_key);
+	kernel_fpu_end();
+}
+
+static int __init init_keylocker(void)
+{
+	u32 eax, ebx, ecx, edx;
+
+	if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER))
+		goto disable;
+
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
+		pr_debug("x86/keylocker: Not compatible with a hypervisor.\n");
+		goto clear_cap;
+	}
+
+	cr4_set_bits(X86_CR4_KEYLOCKER);
+
+	/* AESKLE depends on CR4.KEYLOCKER */
+	cpuid_count(KEYLOCKER_CPUID, 0, &eax, &ebx, &ecx, &edx);
+	if (!(ebx & KEYLOCKER_CPUID_EBX_AESKLE) ||
+	    !(eax & KEYLOCKER_CPUID_EAX_SUPERVISOR)) {
+		pr_debug("x86/keylocker: Not fully supported.\n");
+		goto clear_cap;
+	}
+
+	generate_keylocker_data();
+	schedule_on_each_cpu(load_keylocker);
+	destroy_keylocker_data();
+
+	pr_info_once("x86/keylocker: Enabled.\n");
+	return 0;
+
+clear_cap:
+	setup_clear_cpu_cap(X86_FEATURE_KEYLOCKER);
+	pr_info_once("x86/keylocker: Disabled.\n");
+disable:
+	cr4_clear_bits(X86_CR4_KEYLOCKER);
+	return -ENODEV;
+}
+
+arch_initcall(init_keylocker);
-- 
2.34.1


