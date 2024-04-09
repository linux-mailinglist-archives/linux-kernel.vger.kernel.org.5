Return-Path: <linux-kernel+bounces-136752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 345C289D7DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4069B24940
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074FB12D746;
	Tue,  9 Apr 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ae1dSzXS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DDA129E80
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662230; cv=none; b=FUUvb2zzX3enpVUcf4muYIdXjmgNoZDqn+qTZaRHV1K0JTDUepX/MKf3EAEmmdo4GC0wWVplPQwi+s5ZHeSiinnh/7Uc8eGQ3fdowMukStq8tO0OJsIH+tZrRZwCIgptrBE90WcFnpj2qRfb0Dziguf4lYwwRrfwTPShZ4RgBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662230; c=relaxed/simple;
	bh=jhoSJK9vAOf7tdZhp/qhOuJmkQkVmgSEyhKVV1fOBC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiHU/oCDriAlMirMUZoRMO+53qSMRtr498DxIPM9CXACSyUZIkEr1j9AOysH+9Ls6bZ95CS19heXbiNnltNbyZPOsl0p5m5DnRLl0FJRMSBhDyU1ytwA/PO5LuzlWtjYXtBo13C3/6l76JMQiUIdTcXE4SJTKrXA4dAH+QIsZFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ae1dSzXS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712662229; x=1744198229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jhoSJK9vAOf7tdZhp/qhOuJmkQkVmgSEyhKVV1fOBC8=;
  b=ae1dSzXS8PI4Jp2RcZPBh9UIV2MDySjgM/HlBW6D+q6CKSRBgPp8kmaf
   KHTy5wS8BQc8qFMhNWKBY4Fxsuo6EMM6Tgk9VoZg4UW04S5AA+nrwVF30
   QL/1gjI0L4qL+Ie6yZqBfBopXX1EFzmG9TZTEiIMrrQx2DqSYB0z2+/Ci
   DiXS5ifM8yaNHSun8eZQttgMANuQ57r+snbNu//oK21BeW8xzy3ShdvJC
   liEyHkO7SSA4HW24cAtjyzG9H4KY2xxkeg65SBd4QX/q72Fou4Qnhv+Px
   jHZdzPfW2Omj/0tugqWCS6M1XXznl49Dl+VEhxuuNGOI2OMvfGlsfNzVv
   g==;
X-CSE-ConnectionGUID: htZmv5kFSGK73oCF7CX9Jg==
X-CSE-MsgGUID: cC71c1hFSM2JoQK/5iaTnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="30460357"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="30460357"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 04:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937093327"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093327"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 04:30:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A9B078D1; Tue,  9 Apr 2024 14:30:17 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
Date: Tue,  9 Apr 2024 14:29:57 +0300
Message-ID: <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on setup, TDX guests might be allowed to clear CR4.MCE.
Attempt to clear it leads to #VE.

Use alternatives to keep the flag during kexec for TDX guests.

The change doesn't affect non-TDX-guest environments.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1bb25f5..8e2037d78a1f 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -5,6 +5,8 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/stringify.h>
+#include <asm/alternative.h>
 #include <asm/page_types.h>
 #include <asm/kexec.h>
 #include <asm/processor-flags.h>
@@ -145,11 +147,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Machine check exception on TDX guest, if it was enabled before.
+	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
 	 */
 	movl	$X86_CR4_PAE, %eax
 	testq	$X86_CR4_LA57, %r13
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
+1:
+	testq	$X86_CR4_MCE, %r13
+	jz	1f
+	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
 1:
 	movq	%rax, %cr4
 
-- 
2.43.0


