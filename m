Return-Path: <linux-kernel+bounces-37057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5605F83AAC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A50291D48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8B277F05;
	Wed, 24 Jan 2024 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajuBn643"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B3963116
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102120; cv=none; b=qBQOizrHQ7RAVuFBiLWSBZVx7HaBrp8to2UmDzqte8J+PYYuB4zUQdTlpPd8AZUOBtu+RS7nwxL/epuolCBBAOEjdQkxGDn4qa7Fi8Sv/w+PfNcEnIDEXjmIVa0cOzVoA5XTqV2F63JDmgCjmMsRah/EM9sBdiDY3CDe9Zw1kVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102120; c=relaxed/simple;
	bh=1aG00z85N8OdrjfdrwaynQrPMyFIqlBHlOtO7kt7xqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+FUHIRwmrHow6OzkaoKGGh227nzlNgaBgl/lzDkHg1n8ivJUhFJl50+UC66suVbRsoiGK0CtUcuPjHLMQHQW53qHcPiftCPF6QHWhdpqGh2/CtSOWgvCsBqoZvHVm7HAx2SSHEc/0d8+Z3gSPn3QVTfnOeSbsp6xPUjEiHtDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajuBn643; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706102119; x=1737638119;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1aG00z85N8OdrjfdrwaynQrPMyFIqlBHlOtO7kt7xqQ=;
  b=ajuBn6433q8RWgg0rUWS+UBneu8LTJBL5TtRO8ZBlYzqS6GFyvfloLBd
   cstRP9fN1HpFa28DXKmSj0JRBYKy5XukXz9YiplKTEb3yIFrUuVeki4k7
   WCkbi2jmNbj0YKKlcPsMlCummVjLkEXMpJggePMNZOirsDb/86Ujzf6h1
   0N/VYbQOdEGA3qMKKguVMEu+s03yQgz+hHyc87/gXM7BPJfyflHN3DQp2
   MwMxY1B7v4d2ax5DOeiB+fP/gKeqNt7PeaVXBIY3QspOs90/7cH/av8pO
   /O98+vR45G/toJdTc/RH6PcCEThcLbzBTxTQ8sYzKsteXu1kUWVX8fzE1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8599487"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8599487"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 05:15:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="735926693"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="735926693"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2024 05:15:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BCC909F; Wed, 24 Jan 2024 15:15:12 +0200 (EET)
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
Subject: [PATCHv3, RESEND] x86/trampoline: Bypass compat mode in trampoline_start64() if not needed
Date: Wed, 24 Jan 2024 15:15:10 +0200
Message-ID: <20240124131510.496803-1-kirill.shutemov@linux.intel.com>
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
2.43.0


