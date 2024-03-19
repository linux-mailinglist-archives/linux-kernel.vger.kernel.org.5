Return-Path: <linux-kernel+bounces-106900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552D487F52C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EA21F21DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD41657D7;
	Tue, 19 Mar 2024 01:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQdl4HDZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C5657BF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812944; cv=none; b=pzbFSFZ2nhyuDTAT0x5t1UXcv4+UN0CuBEzcbitXKiZqa+hAeioe6GE0n2QrKJ4ZD+scvX+cO4MBnbNVBYAr6vEpC6AEZy3knoyKsuXMqcvJQnmoa0nTG3UhOA+34eboQHm+iXNCDFTMIewXWK30vInz1OHcz61aYtld5DcK7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812944; c=relaxed/simple;
	bh=xaBDCWG/HU1lwB4kGooE2OZgFghxRiDJBIv/7/4jW88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AjO+augTJlLjP00413rohVu2LAfGlu//hJQ+8Xx3KhHde/9MlJuC7FMx6TDcZxuu7bwJeILEbFUwRbwoKfIZMQFzWTm1ZaLc3Jr6tFo97TxxxCKRctBnI5t9CSxJ8r1HEzkDZLc6p2hZ3u0vVyAFC0WSmYXu7KJEA44zpAStowI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQdl4HDZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710812942; x=1742348942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xaBDCWG/HU1lwB4kGooE2OZgFghxRiDJBIv/7/4jW88=;
  b=iQdl4HDZNunFdZFQhvosmzuewoBV/kFV1+DY+mvo99l1OuTdi8gsvmzF
   4DobtzglGiHJA4oNM8ORAkvPxPrmpwnvfplhuRm0PwOBmu7fX10u+L2Qe
   ORfM3rNt3MuDC6ZqAzpI4Y4uCCwO4xbWeFSAw1OYOmy2s9sxU3spKMDFP
   ZDlzYhjAR8vAl/C42nq05UDwBlqkFGbg+4tlc3pwMC4g3ExpFVx7s4eFX
   AGjsjtWjmxJ0nk2fD2FyNy/Ynz8loZH4Nshlf4fUBUbrHEJ6qf8l2pTyX
   joNwKinqX7gHCzFzMCtJgPH+p8egSaHnvuEfHn5OAs4umf6qdQMnt7vWt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5776892"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5776892"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 18:49:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13697336"
Received: from server.sh.intel.com ([10.239.53.117])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 18:48:58 -0700
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
Subject: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in relocate_kernel()
Date: Tue, 19 Mar 2024 01:48:45 +0000
Message-Id: <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710811610.git.kai.huang@intel.com>
References: <cover.1710811610.git.kai.huang@intel.com>
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

Similarly, for TDX after stopping all remote cpus with cache flushed, to
support kexec, the kernel needs to flush cache for the last running cpu.

Make the WBINVD in the relocate_kernel() unconditional to cover both SME
and TDX.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Young <dyoung@redhat.com>
---
 arch/x86/include/asm/kexec.h         |  3 +--
 arch/x86/kernel/machine_kexec_64.c   |  3 +--
 arch/x86/kernel/relocate_kernel_64.S | 13 +++----------
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 91ca9a9ee3a2..9754794242ad 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -127,8 +127,7 @@ unsigned long
 relocate_kernel(unsigned long indirection_page,
 		unsigned long page_list,
 		unsigned long start_address,
-		unsigned int preserve_context,
-		unsigned int host_mem_enc_active);
+		unsigned int preserve_context);
 #endif
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index bc0a5348b4a6..b9a632479b36 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -357,8 +357,7 @@ void machine_kexec(struct kimage *image)
 	image->start = relocate_kernel((unsigned long)image->head,
 				       (unsigned long)page_list,
 				       image->start,
-				       image->preserve_context,
-				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
+				       image->preserve_context);
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1bb25f5..66b628686dbc 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -50,7 +50,6 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	 * %rsi page_list
 	 * %rdx start address
 	 * %rcx preserve_context
-	 * %r8  host_mem_enc_active
 	 */
 
 	/* Save the CPU context, used for jumping back */
@@ -78,9 +77,6 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	pushq $0
 	popfq
 
-	/* Save SME active flag */
-	movq	%r8, %r12
-
 	/*
 	 * get physical address of control page now
 	 * this is impossible after page table switch
@@ -160,14 +156,11 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%r9, %cr3
 
 	/*
-	 * If SME is active, there could be old encrypted cache line
-	 * entries that will conflict with the now unencrypted memory
-	 * used by kexec. Flush the caches before copying the kernel.
+	 * The kernel could leave caches in incoherent state on SME/TDX
+	 * capable platforms.  Just do unconditional cache flush to avoid
+	 * silent memory corruption to the new kernel for these platforms.
 	 */
-	testq	%r12, %r12
-	jz 1f
 	wbinvd
-1:
 
 	movq	%rcx, %r11
 	call	swap_pages
-- 
2.34.1


