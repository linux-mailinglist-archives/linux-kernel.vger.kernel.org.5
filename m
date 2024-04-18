Return-Path: <linux-kernel+bounces-149999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA9F8A98EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C259A1C21D37
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ED715F326;
	Thu, 18 Apr 2024 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i671CCdt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CAF15F308
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440904; cv=none; b=RcnZgcYKvTvndhj13Az4Zfur3HL03zKe7CjDHy4Z/gzzMI14+JbKslCMmp0ucNtsDxHhkPcjgYYZ9HsDbWfz+9aNJP7zlwF1shk4+Ocv77qKSGKN5SpNKG2lFQMImZbbhPEeLaH18O+vm8yaDk9qgSHBZUkz8SlUETLv2N8VkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440904; c=relaxed/simple;
	bh=ykXR/fRz1OakvAPClPg0U4WJBoRddkdqNXxZh+paK44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5bHupk4bMo9y9ZV3tglCM1mmUd/Tf9ps6LUMBB+zOWe0dycrd2qdZOAy7QBJiGYk+TDSWRz+P9JUh0ff4yYJMgkPb+7JF3THzR+AwWlb72GYRmCT58ofD/E1IYiSaTtNdtjJtfX/gY3pynCesSDF1s4T8YkdkQNaM+bW2py1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i671CCdt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713440903; x=1744976903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ykXR/fRz1OakvAPClPg0U4WJBoRddkdqNXxZh+paK44=;
  b=i671CCdtSPF77BUW++gS36DXBEp7yLDc0o7T0YpdQhULctBQYMART4ud
   +RVNdqi//qqBkXr36fWehi+r7IBhF/3tF3hW7gavBhnRQfhChExAHDtqy
   l5iOmIqONj4dLdBDcNPEH9gMgKh3iN/u2m1W9Rix70CvU1D/SZ9Gvw9lE
   Pa83ZbA8uEpbfNiTTwGe8s67We+7sNhsK0WM6tG3hGYCEIxA2riZ4dqq5
   eMJTV9TSCEQs0aXwRGvLOkWAgNV5G7ZN0badZ3HJdVaneeEYZ6Tf0UYzP
   l05yanT0MtVUL6f/JgDGzsRc0Y1mVm/HrhsXyc9ljzXv4viS1ncnQh5AM
   g==;
X-CSE-ConnectionGUID: nOKFV4LBQF2yXqCmHws14g==
X-CSE-MsgGUID: pOlNHluTTASzBJcYOvMM+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12769358"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12769358"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:48:23 -0700
X-CSE-ConnectionGUID: FoHeTw3cRf2dc4uJ6NmGZA==
X-CSE-MsgGUID: Yv9zGPd3QGKNGBUO1g5IHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23019881"
Received: from vgannu-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.134.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:48:18 -0700
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
Subject: [PATCH v4 1/5] x86/kexec: do unconditional WBINVD for bare-metal in stop_this_cpu()
Date: Thu, 18 Apr 2024 23:48:01 +1200
Message-ID: <327899e13c4dbbfbe8ca95cab83ba229d17fb74b.1713439632.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713439632.git.kai.huang@intel.com>
References: <cover.1713439632.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR:

Change to do unconditional WBINVD in stop_this_cpu() for bare metal
to cover kexec support for both AMD SME and Intel TDX, despite there
_was_ some issue preventing from doing so but now has it got fixed.

Long version:

Both AMD SME and Intel TDX can leave caches in an incoherent state due
to memory encryption, which can lead to silent memory corruption during
kexec.  To address this issue, it is necessary to flush the caches
before jumping to the second kernel.

Currently, the kernel only performs WBINVD in stop_this_cpu() when SME
is supported by hardware.  To support TDX, instead of adding one more
vendor-specific check, it is proposed to perform unconditional WBINVD.
Kexec() is a slow path, and the additional WBINVD is acceptable for the
sake of simplicity and maintainability.

It is important to note that WBINVD should only be done for bare-metal
scenarios, as TDX guests and SEV-ES/SEV-SNP guests may not handle the
unexpected exception (#VE or #VC) caused by WBINVD.

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
the root cause.  Also, it forgot to handle a corner case[*], which
resulted in the reveal of the root cause and the final fix by commit

  1f5e7eb7868e: ("x86/smp: Make stop_other_cpus() more robust")

See [1][2] for more information.

Further testing of doing unconditional WBINVD based on the above fix on
the problematic machines (that issues were originally reported)
confirmed the issues couldn't be reproduced.

See [3][4] for more information.

Therefore, it is safe to do unconditional WBINVD for bare-metal now.

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

v3 -> v4:
 - Update part of changelog based on Kirill's version (with minor tweak).
 - Use "exception (#VE or #VC)" for TDX and SEV-ES/SEV-SNP in changelog
   and comments.  (Kirill, Tom)
 - Point out "WBINVD is not necessary for TDX and SEV-ES/SEV-SNP guests"
   in the comment.  (Tom)

v2 -> v3:
 - Change to only do WBINVD for bare metal

---
 arch/x86/kernel/process.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b8441147eb5e..d3c904bfe874 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -813,18 +813,17 @@ void __noreturn stop_this_cpu(void *dummy)
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
+	 * stop_this_cpu() isn't a fast path, just do WBINVD for bare-metal
+	 * to cover both SME and TDX.  It isn't necessary to perform WBINVD
+	 * in a guest and performing one could result in an exception (#VE
+	 * or #VC) for a TDX or SEV-ES/SEV-SNP guest that the guest may
+	 * not be able to handle (e.g., TDX guest panics if it sees #VE).
 	 */
-	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		native_wbinvd();
 
 	/*
-- 
2.43.2


