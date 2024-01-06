Return-Path: <linux-kernel+bounces-18439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C2B825D85
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 02:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F32B1C23ABB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BE8137B;
	Sat,  6 Jan 2024 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULgII3CR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D6610E6
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704502882; x=1736038882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wmlcIE799KGQUnfz1DYFtpYVFNSZFElEdlaTVp14/gc=;
  b=ULgII3CRg99wOUO95ctWkqCjvV+fj8AFllkkDhw16tXSKLy9R+9q+KY5
   YNzXNB3v5CbOQnHzZXmkOOA0sILRy3BPl9u0CFmykjAcoZ3PlMCEokZ90
   +FxIVy6gQqDNd12nFl9gzszCHzCoKLrwJaJ52hvcCZv+zk7kpJzTuvJbC
   4cfqvPfmPu+/ypH4c/KNsz5n6Ue2FvG9N3SMP/a+7zD290MW6bX0gByDV
   qUvhg5gerkB3UgD8qxqOgaB/nVE5gcHPddOB8ehK0XnQ4ofs8BljZSXXO
   VcihSccOoMP4sKw4GvX20/A995S/aaXEhZ1X49LyFF58msQJbDRyXZP1h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="377770416"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="377770416"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 17:01:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="29259174"
Received: from mflierl-xps15.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.36.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 17:01:19 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 221D110A57B; Sat,  6 Jan 2024 04:01:16 +0300 (+03)
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
Subject: [PATCH] x86/trampoline: Bypass compat mode in trampoline_start64() if not needed
Date: Sat,  6 Jan 2024 04:01:06 +0300
Message-ID: <20240106010106.25772-1-kirill.shutemov@linux.intel.com>
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
 arch/x86/realmode/rm/trampoline_64.S | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index c9f76fae902e..70c6dff658e6 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -220,6 +220,33 @@ SYM_CODE_START(trampoline_start64)
 	lidt	tr_idt(%rip)
 	lgdt	tr_gdt64(%rip)
 
+	/* Check if paging mode has to be changed */
+	movq	%cr4, %rax
+	xorq	pa_tr_cr4, %rax
+	andq	$X86_CR4_LA57, %rax
+	jnz	.L_switch_paging
+
+	/* Paging mode is correct proceed in 64-bit mode */
+
+	LOCK_AND_LOAD_REALMODE_ESP lock_pa=1
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


