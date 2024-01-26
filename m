Return-Path: <linux-kernel+bounces-40141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB383DB20
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9173D1F230FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886A31B94C;
	Fri, 26 Jan 2024 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIxe4RCx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC331B599
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706276686; cv=none; b=fBeSrTrxJI2hVNlqHDJ7L5ExUcF7hzLi70qHmnCg8RPuY3qJf6q8xGl2SjuYn0y0u0BwZarAhz0zmdQLaQLs4ygKfLe0vwr4Tn+/BxjH+tCNMZE9oMGtyKOdmlDCkzKexfnEXjsuHiN7b9K1veQFlpDutHGoTP4vynbb/AO5J4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706276686; c=relaxed/simple;
	bh=nsXQorC8j+BZ4N0IBxG+fCtItGzvSrcJ0orVYy/bv60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OFEUzQ56B6uKjQq3Eu9X9ssjTe07TqeD64K4I7kH0m6rN9yXdFfyyQ7jiPPQw07FbgFl6ESOHuoiOUn8ixGgaEuD5pDaNGiPfequy9ZOOPecD961PncajCsDQU+xFzqHm3ysns2q5Cuk4hcXFU2/NjTSnolQ3nONiX1A43Ii5ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIxe4RCx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706276684; x=1737812684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nsXQorC8j+BZ4N0IBxG+fCtItGzvSrcJ0orVYy/bv60=;
  b=GIxe4RCxL7EfQOi2nIalvDbRENTeOYbA6j/vVLmqn7LpS4HlAkurPii6
   jVbs3SHkyl+NhL0GJzqqnFnXqdZBMVEqtIb+W5Nm5sdi9sC/tlhxcqTT1
   JPQOIOGn7mBH3KeMsm6Qk2XQ44RhAXsvgv3Ukxjw//rwVBFnuEuYAHZCH
   llEkUwCrxU8JknA/KMnmnwQt43y55eutRvM6LVxdCFXfNHRucu6+jPCMS
   XVYeT8HHYhi2L5KHAb/4ACra+2rhPZ/Ca1eUKA8RZbckuKhLRssL47AqH
   3dzOOX6AA47A+jtz641BiaPMCBroBa6oe6O6kHkQoq9MwmOTvJSMq+FDX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9840166"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9840166"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 05:44:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="910338889"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="910338889"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2024 05:44:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E1ECE431; Fri, 26 Jan 2024 15:42:50 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC] Randomness on confidential computing platforms
Date: Fri, 26 Jan 2024 15:42:30 +0200
Message-ID: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Problem Statement

Currently Linux RNG uses the random inputs obtained from x86
RDRAND/RDSEED instructions (if present) during early initialization
stage (by mixing the obtained input into the random pool via
_mix_pool_bytes()), as well as for seeding/reseeding ChaCha-based CRNG.
When the calls to both RDRAND/RDSEED fail (including RDRAND internal
retries), the timing-based fallbacks are used in the latter case, and
during the early boot case this source of entropy input is simply
skipped. Overall Linux RNG has many other sources of entropy that it
uses (also depending on what HW is used), but the dominating one is
interrupts.

In a Confidential Computing Guest threat model, given the absence of any
special trusted HW for the secure entropy input, RDRAND/RDSEED
instructions is the only entropy source that is unobservable outside of
Confidential Computing Guest TCB. However, with enough pressure on these
instructions from multiple cores (see Intel SDM, Volume 1, Section
7.3.17, “Random Number Generator Instructions”), they can be made to
fail on purpose and force the Confidential Computing Guest Linux RNG to
use only Host/VMM controlled entropy sources.

Solution options

There are several possible solutions to this problem and the intention
of this RFC is to initiate a joined discussion. Here are some options
that has been considered:

1. Do nothing and accept the risk.
2. Force endless looping on RDRAND/RDSEED instructions when run in a
   Confidential Computing Guest (this patch). This option turns the
   attack against the quality of cryptographic randomness provided by
   Confidential Computing Guest’s Linux RNG into a DoS attack against
   the Confidential Computing Guest itself (DoS attack is out of scope
   for the Confidential Computing threat model).
3. Panic after enough re-tries of RDRAND/RDSEED instructions fail.
   Another DoS variant against the Guest.
4. Exit to the host/VMM with an error indication after a Confidential
   Computing Guest failed to obtain random input from RDRAND/RDSEED
   instructions after reasonable number of retries. This option allows
   host/VMM to take some correction action for cases when the load on
   RDRAND/RDSEED instructions has been put by another actor, i.e. the
   other guest VM. The exit to host/VMM in such cases can be made
   transparent for the Confidential Computing Guest in the TDX case with
   the assistance of the TDX module component.
5. Anything other better option?

The patch below implements the second option. I believe the problem is
common for Intel TDX and AMD SEV. The patch cover both.
---
 arch/x86/boot/compressed/kaslr.c  |  6 ++++++
 arch/x86/boot/compressed/mem.c    | 26 -------------------------
 arch/x86/boot/compressed/misc.h   |  3 +++
 arch/x86/boot/compressed/sev.c    |  5 +++++
 arch/x86/boot/compressed/sev.h    |  2 ++
 arch/x86/boot/compressed/tdx.c    | 32 ++++++++++++++++++++++++++-----
 arch/x86/boot/compressed/tdx.h    |  2 ++
 arch/x86/coco/core.c              |  2 ++
 arch/x86/include/asm/archrandom.h | 22 ++++++++++++++++-----
 include/linux/cc_platform.h       | 11 +++++++++++
 10 files changed, 75 insertions(+), 36 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index dec961c6d16a..a7bba37c7539 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -23,6 +23,7 @@
 #include "error.h"
 #include "../string.h"
 #include "efi.h"
+#include "sev.h"
 
 #include <generated/compile.h>
 #include <linux/module.h>
@@ -304,6 +305,11 @@ static void handle_mem_options(void)
 	return;
 }
 
+bool rd_loop(void)
+{
+	return early_is_tdx_guest() || sev_enabled();
+}
+
 /*
  * In theory, KASLR can put the kernel anywhere in the range of [16M, MAXMEM)
  * on 64-bit, and [16M, KERNEL_IMAGE_SIZE) on 32-bit.
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index dbba332e4a12..84a9d9ad98b2 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -6,32 +6,6 @@
 #include "sev.h"
 #include <asm/shared/tdx.h>
 
-/*
- * accept_memory() and process_unaccepted_memory() called from EFI stub which
- * runs before decompressor and its early_tdx_detect().
- *
- * Enumerate TDX directly from the early users.
- */
-static bool early_is_tdx_guest(void)
-{
-	static bool once;
-	static bool is_tdx;
-
-	if (!IS_ENABLED(CONFIG_INTEL_TDX_GUEST))
-		return false;
-
-	if (!once) {
-		u32 eax, sig[3];
-
-		cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax,
-			    &sig[0], &sig[2],  &sig[1]);
-		is_tdx = !memcmp(TDX_IDENT, sig, sizeof(sig));
-		once = true;
-	}
-
-	return is_tdx;
-}
-
 void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index bc2f0f17fb90..3fd0aba836e7 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -255,4 +255,7 @@ static inline bool init_unaccepted_memory(void) { return false; }
 extern struct efi_unaccepted_memory *unaccepted_table;
 void accept_memory(phys_addr_t start, phys_addr_t end);
 
+#define rd_loop rd_loop
+extern bool rd_loop(void);
+
 #endif /* BOOT_COMPRESSED_MISC_H */
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 454acd7a2daf..5e7fb31e630b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -125,6 +125,11 @@ static bool fault_in_kernel_space(unsigned long address)
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
+bool sev_enabled(void)
+{
+	return sev_status & MSR_AMD64_SEV_ENABLED;
+}
+
 bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
index fc725a981b09..ec99e0390324 100644
--- a/arch/x86/boot/compressed/sev.h
+++ b/arch/x86/boot/compressed/sev.h
@@ -10,11 +10,13 @@
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
+bool sev_enabled(void);
 bool sev_snp_enabled(void);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 
 #else
 
+static inline bool sev_enabled(void) { return false; }
 static inline bool sev_snp_enabled(void) { return false; }
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 8451d6a1030c..90dcfb9e82bf 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -61,13 +61,35 @@ static inline void tdx_outw(u16 value, u16 port)
 	tdx_io_out(2, port, value);
 }
 
+/*
+ * accept_memory() and process_unaccepted_memory() called from EFI stub which
+ * runs before decompressor and its early_tdx_detect().
+ *
+ * Enumerate TDX directly from the early users.
+ */
+bool early_is_tdx_guest(void)
+{
+	static bool once;
+	static bool is_tdx;
+
+	if (!IS_ENABLED(CONFIG_INTEL_TDX_GUEST))
+		return false;
+
+	if (!once) {
+		u32 eax, sig[3];
+
+		cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax,
+			    &sig[0], &sig[2],  &sig[1]);
+		is_tdx = !memcmp(TDX_IDENT, sig, sizeof(sig));
+		once = true;
+	}
+
+	return is_tdx;
+}
+
 void early_tdx_detect(void)
 {
-	u32 eax, sig[3];
-
-	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
-
-	if (memcmp(TDX_IDENT, sig, sizeof(sig)))
+	if (!early_is_tdx_guest())
 		return;
 
 	/* Use hypercalls instead of I/O instructions */
diff --git a/arch/x86/boot/compressed/tdx.h b/arch/x86/boot/compressed/tdx.h
index 9055482cd35c..6c097de8392e 100644
--- a/arch/x86/boot/compressed/tdx.h
+++ b/arch/x86/boot/compressed/tdx.h
@@ -5,8 +5,10 @@
 #include <linux/types.h>
 
 #ifdef CONFIG_INTEL_TDX_GUEST
+bool early_is_tdx_guest(void);
 void early_tdx_detect(void);
 #else
+bool early_is_tdx_guest(void) { return false; }
 static inline void early_tdx_detect(void) { };
 #endif
 
diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index f07c3bb7deab..655d881a9cfa 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -22,6 +22,7 @@ static bool noinstr intel_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
 	case CC_ATTR_MEM_ENCRYPT:
+	case CC_ATTR_GUEST_RAND_LOOP:
 		return true;
 	default:
 		return false;
@@ -72,6 +73,7 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
 		return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENABLED);
 
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
+	case CC_ATTR_GUEST_RAND_LOOP:
 		return sev_status & MSR_AMD64_SEV_ENABLED;
 
 	case CC_ATTR_GUEST_STATE_ENCRYPT:
diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index 02bae8e0758b..63368227c9d6 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -10,6 +10,7 @@
 #ifndef ASM_X86_ARCHRANDOM_H
 #define ASM_X86_ARCHRANDOM_H
 
+#include <linux/cc_platform.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 
@@ -17,6 +18,13 @@
 
 /* Unconditional execution of RDRAND and RDSEED */
 
+#ifndef rd_loop
+static inline bool rd_loop(void)
+{
+	return cc_platform_has(CC_ATTR_GUEST_RAND_LOOP);
+}
+#endif
+
 static inline bool __must_check rdrand_long(unsigned long *v)
 {
 	bool ok;
@@ -27,17 +35,21 @@ static inline bool __must_check rdrand_long(unsigned long *v)
 			     : CC_OUT(c) (ok), [out] "=r" (*v));
 		if (ok)
 			return true;
-	} while (--retry);
+	} while (rd_loop() || --retry);
 	return false;
 }
 
 static inline bool __must_check rdseed_long(unsigned long *v)
 {
 	bool ok;
-	asm volatile("rdseed %[out]"
-		     CC_SET(c)
-		     : CC_OUT(c) (ok), [out] "=r" (*v));
-	return ok;
+	do {
+		asm volatile("rdseed %[out]"
+			     CC_SET(c)
+			     : CC_OUT(c) (ok), [out] "=r" (*v));
+		if (ok)
+			return ok;
+	} while (rd_loop());
+	return false;
 }
 
 /*
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index d08dd65b5c43..e554e8919eb0 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -80,6 +80,17 @@ enum cc_attr {
 	 * using AMD SEV-SNP features.
 	 */
 	CC_ATTR_GUEST_SEV_SNP,
+
+	/**
+	 * @CC_ATTR_GUEST_RAND_LOOP: Make RDRAND/RDSEED loop forever to
+	 * harden the random number generation.
+	 *
+	 * The platform/OS is running as a guest/virtual machine and
+	 * harden the random number generation.
+	 *
+	 * Examples include TDX guest & SEV.
+	 */
+	CC_ATTR_GUEST_RAND_LOOP,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.43.0


