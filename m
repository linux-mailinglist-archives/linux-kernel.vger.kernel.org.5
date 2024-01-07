Return-Path: <linux-kernel+bounces-18855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA27826409
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17601C20D2A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45897134CC;
	Sun,  7 Jan 2024 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUZPqRDq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F06134BA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704630542; x=1736166542;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VCDNpS4klszuxogddz8jC2xyn6frhvJkBET0nHWruIE=;
  b=fUZPqRDqDMXVLv6CgyEGiAj0YrfDxo4nv9pRVxVf7FjBtv/XGNE28o37
   dk/GxU+xu6iTcU48wbZcoFITBRMOP3cjyGEJp7cmdGNz21+GUTUDFt6kJ
   G7k7txN60mmc4d0MunMaJ93o8LGlgmMoRapHCx7xxoszjiy2qfhUzghC3
   fhPL3EJE4MxObALO586xWusRxKLO//6Z2/fqrg8RfUDnFoKw0Whg0lSab
   3XNBxId+LkoxFO7vLVuXy88U3f7QjvF/jZsMNB3UUg6BIlSArmzCq3Wpe
   KHMnoQnpvoE9tLMSAapTssl4/ucXgAPEpCHm8fmAWy0dWN5tLH72xu8bJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="4523779"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="4523779"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 04:29:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="809972489"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="809972489"
Received: from hoffbaue-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.211.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 04:28:57 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id E8AC0109E5C; Sun,  7 Jan 2024 15:28:54 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCHv2] x86/trampoline: Bypass compat mode in trampoline_start64() if not needed
Date: Sun,  7 Jan 2024 15:28:47 +0300
Message-ID: <20240107122847.27740-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trampoline_start64() vector is used when a secondary CPU starts in
64-bit mode. The current implementation directly enters compatibility
mode. It is necessary to disable paging and re-enable it in the correct
paging mode: either 4- or 5-level, depending on the configuration.

The X86S[1] ISA does not support compatibility mode in ring 0, and
paging cannot be disabled.

The trampoline_start64() function is reworked to only enter compatibility
mode if it is necessary to change the paging mode. If the CPU is already
in the desired paging mode, it will proceed in long mode.

This change will allow a secondary CPU to boot on an X86S machine as
long as the CPU is already in the correct paging mode.

In the future, there will be a mechanism to switch between paging modes
without disabling paging.

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/envisioning-future-simplified-architecture.html

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>

---
 v2:
  - Fix build with GCC;
---
 arch/x86/realmode/rm/trampoline_64.S | 31 +++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index c9f76fae902e..c07354542188 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -37,13 +37,15 @@
 	.text
 	.code16
 
-.macro LOCK_AND_LOAD_REALMODE_ESP lock_pa=0
+.macro LOCK_AND_LOAD_REALMODE_ESP lock_pa=0 lock_rip=0
 	/*
 	 * Make sure only one CPU fiddles with the realmode stack
 	 */
 .Llock_rm\@:
 	.if \lock_pa
         lock btsl       $0, pa_tr_lock
+	.elseif \lock_rip
+        lock btsl       $0, tr_lock(%rip)
 	.else
         lock btsl       $0, tr_lock
 	.endif
@@ -220,6 +222,33 @@ SYM_CODE_START(trampoline_start64)
 	lidt	tr_idt(%rip)
 	lgdt	tr_gdt64(%rip)
 
+	/* Check if paging mode has to be changed */
+	movq	%cr4, %rax
+	xorq	tr_cr4(%rip), %rax
+	andq	$X86_CR4_LA57, %rax
+	jnz	.L_switch_paging
+
+	/* Paging mode is correct proceed in 64-bit mode */
+
+	LOCK_AND_LOAD_REALMODE_ESP lock_rip=1
+
+	movw	$__KERNEL_DS, %dx
+	movl	%edx, %ss
+	addl	$pa_real_mode_base, %esp
+	movl	%edx, %ds
+	movl	%edx, %es
+	movl	%edx, %fs
+	movl	%edx, %gs
+
+	movl	$pa_trampoline_pgd, %eax
+	movq	%rax, %cr3
+
+	jmpq	*tr_start(%rip)
+.L_switch_paging:
+	/*
+	 * To switch between 4- and 5-level paging modes, it is necessary
+	 * to disable paging. This must be done in the compatibility mode.
+	 */
 	ljmpl	*tr_compat(%rip)
 SYM_CODE_END(trampoline_start64)
 
-- 
2.41.0


