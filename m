Return-Path: <linux-kernel+bounces-106899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CAD87F52B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253E7282697
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D6C657B0;
	Tue, 19 Mar 2024 01:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6AMwDdo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4552E651AC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812940; cv=none; b=IM8eNuP558ESbWNICkXlKlBo4oPMNzW/I/zioBSPyqertqztGLtmkGu1rUo/4A4Fv1Iu+OSdRDbZsTky9B/BOiM2OvXnw2pHgEKX60znNWaP6X1Z90ecjRBSgctTy6ozx+LYrR7XezraX0O8u92T5P5D2NYq2vs0tTz+HYBs8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812940; c=relaxed/simple;
	bh=FlX7CgjifVeRrQ/QQNoSfgHgX0lV/1ajjGELuX3hAgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=msOw8tZ/P/ekBMxJjkj7FOev/TMXVgQBYQzqpKn9lOM55Rgf+oiwezxvQYOyKFyinF9Dj33Nt78lkJF9BXPCJ/EitdyxXa27ivhsvGS6I2ENJOvhSMWWT83AZP/02/OantdL/CSJPwIbd5Bacd2PfafKJ/WcZpBWzb1kxKsbsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6AMwDdo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710812938; x=1742348938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FlX7CgjifVeRrQ/QQNoSfgHgX0lV/1ajjGELuX3hAgc=;
  b=N6AMwDdoMvcY4K6ojIsH2BY8ivkMOJg0FxOashOPMU2WIaJ84U5xVMiB
   DX2/B6aGE8Mc3w6HqHGK101h3fdLJQCaQqFf8SSCoI/BY0mgOEBmZ005z
   vOHRxnCYgTXoCUgAsZv2UM0bSv4lXcAT96ynwQZEnA2Yiwx2SH5x58imP
   6LnTxoJdyfhGunxuHPiIkNTpvhjjoTJjzGTA+/yGa2uUOISro2Zj1JVgb
   QYcXh/V+PfriAJ3UIsUB+jEq93vf4VrClc9bsJtaAGle9rxjnS/x0CWIk
   cseJCyy0J18LS5uBx0xfIWPjcsEhIx9trqKUAPHktU02MbrL0AydN6/+L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5776877"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5776877"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 18:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13697326"
Received: from server.sh.intel.com ([10.239.53.117])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 18:48:54 -0700
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
Subject: [PATCH v2 1/5] x86/kexec: do unconditional WBINVD in stop_this_cpu()
Date: Tue, 19 Mar 2024 01:48:44 +0000
Message-Id: <0b7223b39510a51fdb164a847deab5778de25fb2.1710811610.git.kai.huang@intel.com>
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

TL;DR:

Change to do unconditional WBINVD in stop_this_cpu() to cover kexec
support for both AMD SME and Intel TDX, despite there _was_ some issue
preventing doing so but now has got fixed.

Long version:

Both SME and TDX can leave caches in incoherent state due to memory
encryption.  During kexec, the caches must be flushed before jumping to
the second kernel to avoid silent memory corruption to the second kernel.

Currently, for SME the kernel only does WBINVD in stop_this_cpu() when
the kernel determines the hardware supports SME.  To support TDX, one
option is to extend that specific check to cover both SME and TDX.

However, instead of sprinkling around vendor-specific checks, it's
better to just do unconditional WBINVD.  Kexec() is a slow path, and it
is acceptable to have an additional WBINVD in order to have simple
and easy to maintain code.

Note:

Historically, there _was_ an issue preventing doing unconditional WBINVD
but that has been fixed.

When SME kexec() support was initially added in commit

  bba4ed011a52: ("x86/mm, kexec: Allow kexec to be used with SME")

WBINVD was done unconditionally.  However since then some issues were
reported that different Intel systems would hang or reset due to that
commit.

To try to fix, a later commit

  f23d74f6c66c: ("x86/mm: Rework wbinvd, hlt operation in stop_this_cpu()")

then changed to only do WBINVD when hardware supports SME.

While this commit made the reported issues go away, it didn't pinpoint
the root cause.  Also, it didn't handle a corner case[*] correctly, which
resulted in the reveal of the root cause and the final fix by commit

  1f5e7eb7868e: ("x86/smp: Make stop_other_cpus() more robust")

See [1][2] for more information.

Further testing of doing unconditional WBINVD based on the above fix on
the problematic machines (that issues were originally reported)
confirmed the issues couldn't be reproduced.

See [3][4] for more information.

Therefore, it is safe to do unconditional WBINVD now.

[*] The commit didn't check whether the CPUID leaf is available or not.
Making unsupported CPUID leaf on Intel returns garbage resulting in
unintended WBINVD which caused some issue (followed by the analysis and
the reveal of the final root cause).  The corner case was independently
fixed by commit

  9b040453d444: ("x86/smp: Dont access non-existing CPUID leaf")

[1]: https://lore.kernel.org/lkml/CALu+AoQKmeixJdkO07t7BtttN7v3RM4_aBKi642bQ3fTBbSAVg@mail.gmail.com/T/#m300f3f9790850b5daa20a71abcc200ae8d94a12a
[2]: https://lore.kernel.org/lkml/CALu+AoQKmeixJdkO07t7BtttN7v3RM4_aBKi642bQ3fTBbSAVg@mail.gmail.com/T/#ma7263a7765483db0dabdeef62a1110940e634846
[3]: https://lore.kernel.org/lkml/CALu+AoQKmeixJdkO07t7BtttN7v3RM4_aBKi642bQ3fTBbSAVg@mail.gmail.com/T/#mc043191f2ff860d649c8466775dc61ac1e0ae320
[4]: https://lore.kernel.org/lkml/CALu+AoQKmeixJdkO07t7BtttN7v3RM4_aBKi642bQ3fTBbSAVg@mail.gmail.com/T/#md23f1a8f6afcc59fa2b0ac1967f18e418e24347c

Signed-off-by: Kai Huang <kai.huang@intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/process.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b8441147eb5e..b375f069dd2a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -813,19 +813,14 @@ void __noreturn stop_this_cpu(void *dummy)
 	mcheck_cpu_clear(c);
 
 	/*
-	 * Use wbinvd on processors that support SME. This provides support
-	 * for performing a successful kexec when going from SME inactive
-	 * to SME active (or vice-versa). The cache must be cleared so that
-	 * if there are entries with the same physical address, both with and
-	 * without the encryption bit, they don't race each other when flushed
-	 * and potentially end up with the wrong entry being committed to
-	 * memory.
+	 * The kernel could leave caches in incoherent state on SME/TDX
+	 * capable platforms.  Flush cache to avoid silent memory
+	 * corruption for these platforms.
 	 *
-	 * Test the CPUID bit directly because the machine might've cleared
-	 * X86_FEATURE_SME due to cmdline options.
+	 * stop_this_cpu() is not a fast path, just do unconditional
+	 * WBINVD for simplicity.
 	 */
-	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
-		native_wbinvd();
+	native_wbinvd();
 
 	/*
 	 * This brings a cache line back and dirties it, but
-- 
2.34.1


