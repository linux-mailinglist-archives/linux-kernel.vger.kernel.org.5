Return-Path: <linux-kernel+bounces-20144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F257827A8A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66DB1F239F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4EE56465;
	Mon,  8 Jan 2024 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrAWE0cc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F755E61
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704752227; x=1736288227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sb4hj88xT5jkWWWK/Y0o9xudiHIS7tyWmiNtkRi0A/I=;
  b=GrAWE0ccHr4mIKMDfPJLcIN0unmTyqXRNCfopxF0YP8/POJzvQdvsp4h
   d1e69SDxHhhsMVZvHv3Zx7Zsrl+sPG2Hh6xPZ/9qafSe5TjKW8lYleE46
   SlcD0eCsu67XMq53pOmNvD/wwEP6jTILx5IZekuPWpvRyk77dLS16wsre
   tT6u6VIMUDDWaCcchWYfbv7RADtWjiuY9yyIpy5qVd7oMNRcyes/ltcc7
   Rr8foDS7v/B2hlBizN4UtPxyzf+fYsk60Cs+A96i2lFbS03dSIUJoSd5h
   NI6Nzm0yRwnDQb9G3ht8r7AYYrRvko02lrglx2HVep4sAxACwpiGL0NZD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4776985"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="4776985"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 14:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="851957205"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="851957205"
Received: from ddraghic-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.212.53])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 14:17:04 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 1475C10944C; Tue,  9 Jan 2024 01:17:02 +0300 (+03)
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
Subject: [PATCHv3] x86/trampoline: Bypass compat mode in trampoline_start64() if not needed
Date: Tue,  9 Jan 2024 01:16:59 +0300
Message-ID: <20240108221659.11167-1-kirill.shutemov@linux.intel.com>
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
 v3:
  - tr_cr4 is 32-bit, use 32-bit XOR to access it (Sean).
  - Use 32-bit TEST instead of AND to check if LA57 different between
    CR4 and tr_cr4 (Sean).
 v2:
  - Fix build with GCC;
---
 arch/x86/realmode/rm/trampoline_64.S | 31 +++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index c9f76fae902e..608f108cba7d 100644
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
+	xorl	tr_cr4(%rip), %eax
+	testl	$X86_CR4_LA57, %eax
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


