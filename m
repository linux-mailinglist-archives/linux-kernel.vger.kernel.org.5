Return-Path: <linux-kernel+bounces-39981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC58A83D80E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92ABE29500D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBD81758E;
	Fri, 26 Jan 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ef9/3oji"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2D17575
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263524; cv=none; b=EBjc7v4FQil4ApIc3BH02bTfZgwOd547/mg0G1laTgywd87GF7DuIDl2WCmUhix3zcnx0loH+ye1AvsIN0sYrdtI0YpcJae1PmRCRy1UFHc5HDi2rraGG0zR1z6ouzUjjBRGsMmlxcedw+QMbJYwvbPm6NAKNVkU8D2wHETmwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263524; c=relaxed/simple;
	bh=fl3YeLbuz5mlJiHETON3omawEKtmByjZuVupy44duG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5gcrSFexIzY9TwLi1Nu+7VIHjt/WmpkbvnFDVT5JSglRi+g6IgXlMspNVp1OeDgMbcTuMdJFtMbY6RE3K2JTwQD1vLkcqirzVjyTjDI97fuSZXM5UW08lq2S5ysWCDndZiElXGwYAAgErm+TxubA8AD3/QxIpyLl/hlFzA2mnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ef9/3oji; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706263523; x=1737799523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fl3YeLbuz5mlJiHETON3omawEKtmByjZuVupy44duG8=;
  b=Ef9/3ojieLEumbuME1Wbb7FCgYn8U6NNOgcG7+CYGVFPhMbkN7acoXSg
   nNLfcJ/cSJLWTQg9U+c/z9b28W3WAOHEntcLb/wJq04FoYsRPJRSOCU/g
   4w2BDNXLFg53QXvg6I2A9MWcH/VjPAMIOR5GAXhzqk+QblMQKtkVx+Roi
   PcG/dBnFrvUN7//whdKlfnoXl7Mfqv6EDezV9MJjPFe2YXLrx7D5kqv8Y
   5sUNsUqqsVBA9h3QFICTjwA8GABQ+i3m7DkwYstRv/AOYiwZPsS0aJob6
   7ZylUWRIn3OegFwOXkC437ppiSrIkiKICVwgWp2I1SUSbwyquAY9yWNgK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2271376"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2271376"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 02:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="1118227922"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1118227922"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jan 2024 02:05:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4301D431; Fri, 26 Jan 2024 12:01:07 +0200 (EET)
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
	Kai Huang <kai.huang@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCHv4] x86/trampoline: Bypass compat mode in trampoline_start64() if not needed
Date: Fri, 26 Jan 2024 12:01:01 +0200
Message-ID: <20240126100101.689090-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
Reviewed-by: Kai Huang <kai.huang@intel.com>
Cc: Sean Christopherson <seanjc@google.com>

---
 v4:
  - Establish CS on jumping to tr_start (Andi);
 v3:
  - tr_cr4 is 32-bit, use 32-bit XOR to access it (Sean).
  - Use 32-bit TEST instead of AND to check if LA57 different between
    CR4 and tr_cr4 (Sean).
 v2:
  - Fix build with GCC;
---
 arch/x86/realmode/rm/trampoline_64.S | 33 +++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index c9f76fae902e..14d9c7daf90f 100644
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
@@ -220,6 +222,35 @@ SYM_CODE_START(trampoline_start64)
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
+	pushq	$__KERNEL_CS
+	pushq	tr_start(%rip)
+	lretq
+.L_switch_paging:
+	/*
+	 * To switch between 4- and 5-level paging modes, it is necessary
+	 * to disable paging. This must be done in the compatibility mode.
+	 */
 	ljmpl	*tr_compat(%rip)
 SYM_CODE_END(trampoline_start64)
 
-- 
2.43.0


