Return-Path: <linux-kernel+bounces-134383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7B889B0DD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2091C20F24
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1372D627;
	Sun,  7 Apr 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJNZJcQc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E892C6BA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493922; cv=none; b=dpBFW9hk2la2E/V45NPHkM9PZrS3P9NJM9ivOitOYcXjQyBT0/Pxr+prJPNixYIZYBcremzoIuEOszBK43fUXwsPMH7nkSLpXhWQWwRzonwOtK5ojKSR8V78bJ4flOmvV9Ookx1suaI6BS4zuRvLwIrE3jQVZNGamojzGS6EuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493922; c=relaxed/simple;
	bh=V9JifYapbpBofohz95Yw5R+vy9sccP6hFMfQiefdsIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=np6zm6AiN3Ee2Ug80qzPqoZQ1AV+sf3Hjmo7LJQgfVshL24OGCXvArj2S3xfRk+gmjKS67+FI4vRp4GkF//G+vdXkkyZQS3iluK0v3zKU5Bsca8Djis6men6jqdnrB/Tdgp8yDmOeIsrBEM927AgAqKHjMsRSEXUjqwn+IzoOu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJNZJcQc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712493922; x=1744029922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V9JifYapbpBofohz95Yw5R+vy9sccP6hFMfQiefdsIE=;
  b=eJNZJcQcsXJcjTAhGbDFaBBZOl+CMnU8GGh7NWSfhsledhhCACaX03xE
   ivXtC3yzor85LsKRngTaA/XSpxagrFPs0Iu0pDnrAerY3I6f7ElD8GpXr
   hz70sCmFm9UCVtC1qMc6zTlji/oFcupzh09XbKHqeAv8Rr0LzFvglfTDi
   lMVpYpGqJhdEE6EcTZoChFBus1ag/UHwUdBjgY9RXthhZb74TCp6S2sFC
   AJrBa/SWpv7hj7SYebdIn8lHOU5wJpTzCOR9kxiHCVO3Z63n9Wx3deu7/
   Ot1vBvZdsWLSmcyLP7DJVmZEO9e8xUOYpMpSDVBs6DlTVnVWjO4fvWBm1
   g==;
X-CSE-ConnectionGUID: dT4N7HDSS2uah2jQS3N9Jg==
X-CSE-MsgGUID: hKAdgr+TTHqsaFDoebCx6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="11564064"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="11564064"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 05:45:21 -0700
X-CSE-ConnectionGUID: fQ/sMBkhS0a4+bxYj3wcTQ==
X-CSE-MsgGUID: 3QdrJ/49SVK9QBfWe/t+Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="20185677"
Received: from mirtanji-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.251.14.88])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 05:45:17 -0700
From: Kai Huang <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	bp@alien8.de,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com,
	ashish.kalra@amd.com,
	chao.gao@intel.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: [PATCH v3 2/5] x86/kexec: do unconditional WBINVD for bare-metal in relocate_kernel()
Date: Mon,  8 Apr 2024 00:44:55 +1200
Message-ID: <5aca124fe0ca1c97bf4a2e925b3905485bf5b255.1712493366.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1712493366.git.kai.huang@intel.com>
References: <cover.1712493366.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both SME and TDX can leave caches in incoherent state due to memory
encryption.  During kexec, the caches must be flushed before jumping to
the second kernel to avoid silent memory corruption to the second kernel.

During kexec, the WBINVD in stop_this_cpu() flushes caches for all
remote cpus when they are being stopped.  For SME, the WBINVD in
relocate_kernel() flushes the cache for the last running cpu (which is
executing the kexec).

Similarly, to support kexec for TDX host, after stopping all remote cpus
with cache flushed, the kernel needs to flush cache for the last running
cpu.

Use the existing WBINVD in relocate_kernel() to cover TDX host as well.

However, instead of sprinkling around vendor-specific checks, just do
unconditional WBINVD to cover both SME and TDX.  Kexec is not a fast path
so having one additional WBINVD for platforms w/o SME/TDX is acceptable.

But only do WBINVD for bare-metal because TDX guests and SEV-ES/SEV-SNP
guests will get unexpected (and yet unnecessary) #VE which the kernel is
unable to handle at this stage.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Young <dyoung@redhat.com>
---

v2 -> v3:
 - Change to only do WBINVD for bare metal

---
 arch/x86/include/asm/kexec.h         |  2 +-
 arch/x86/kernel/machine_kexec_64.c   |  2 +-
 arch/x86/kernel/relocate_kernel_64.S | 14 +++++++++-----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 91ca9a9ee3a2..455f8a6c66a9 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -128,7 +128,7 @@ relocate_kernel(unsigned long indirection_page,
 		unsigned long page_list,
 		unsigned long start_address,
 		unsigned int preserve_context,
-		unsigned int host_mem_enc_active);
+		unsigned int bare_metal);
 #endif
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index b180d8e497c3..a454477b7b4c 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -358,7 +358,7 @@ void machine_kexec(struct kimage *image)
 				       (unsigned long)page_list,
 				       image->start,
 				       image->preserve_context,
-				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
+				       !boot_cpu_has(X86_FEATURE_HYPERVISOR));
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1bb25f5..3e04c5e5687f 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -50,7 +50,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	 * %rsi page_list
 	 * %rdx start address
 	 * %rcx preserve_context
-	 * %r8  host_mem_enc_active
+	 * %r8  bare_metal
 	 */
 
 	/* Save the CPU context, used for jumping back */
@@ -78,7 +78,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	pushq $0
 	popfq
 
-	/* Save SME active flag */
+	/* Save the bare_metal */
 	movq	%r8, %r12
 
 	/*
@@ -160,9 +160,13 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%r9, %cr3
 
 	/*
-	 * If SME is active, there could be old encrypted cache line
-	 * entries that will conflict with the now unencrypted memory
-	 * used by kexec. Flush the caches before copying the kernel.
+	 * The kernel could leave caches in incoherent state on SME/TDX
+	 * capable platforms.  Just do unconditional WBINVD to avoid
+	 * silent memory corruption to the new kernel for these platforms.
+	 *
+	 * But only do WBINVD for bare-metal because TDX guests and
+	 * SEV-ES/SEV-SNP guests will get #VE which the kernel is unable
+	 * to handle at this stage.
 	 */
 	testq	%r12, %r12
 	jz 1f
-- 
2.43.2


