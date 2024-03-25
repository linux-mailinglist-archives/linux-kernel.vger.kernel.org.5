Return-Path: <linux-kernel+bounces-116599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3871889EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B41C2A4D25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72262157487;
	Mon, 25 Mar 2024 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcnCP8Hd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9768F15F3F5;
	Mon, 25 Mar 2024 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348893; cv=none; b=Bd9vEP7DOT7qDCuoduFrcE0PMOWwr3JCW4x9wC0AT99wC7SbzWyQSTIiXcNM6T4PJG+FFzy8GQplsFQpyiD4oGTGjjVyNZmM/H3cbIYSjgBNy1x9/D08td039bjN+rQg3n32fSENaBF0Uyhfqtn/v4+AyXappcIp8T1BMWWBaUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348893; c=relaxed/simple;
	bh=tRyxc+NjWa10JwJq5Oo62d3MoJ/4i/AwqfqN12/XrkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hySxjraNHZdVf7LXVJ4vAERUQmMC1R2XsCa7gyRR8SXbMvDsXM3fdvN+lyyXfY4HPBMcFi2Im1g4OwYYkQUUk9ng79KygkRgvXyyM34m5ZUfuk8xThm8mh0tprCKbEnKCbMyzXQdIwhrgdRod5djMlXUiYiNubdFN/oq28LFMf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcnCP8Hd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348891; x=1742884891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tRyxc+NjWa10JwJq5Oo62d3MoJ/4i/AwqfqN12/XrkQ=;
  b=ZcnCP8Hdj6Yunb/uBCTaem/QbJJ8IgqxvJCAsf5tHn3HTDQj+VY9Tie0
   OyyKUvdpkZP3ijhc3fUQ1T81sdsUTRHQamG+mCS4H9fNoJI12lHr1P+lA
   ADVREu1dGSZahXZbw4xs9SrmNscn7bY5BHw0wcZDzHMxbfFFGjJGTR27D
   bLgah26ik1UPYqhWr4M+XZBiKC1353O2jIQso2ZrxoRVZLgno2OjKn7E9
   RY21KbPVDVYwjCMyHd4CgiohCAgya8x2pq8y64oYlkHpPMiQ542j+IjJ/
   YBlMJcSQiVyrxLZm2/116ixLRMA+d2abSlihRmDKN607KZSWuWd8v7Jpi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17065225"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="17065225"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:41:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="38629602"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.211.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:41:24 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH V2 08/19] x86/vdso: Make delta calculation overflow safe
Date: Mon, 25 Mar 2024 08:40:12 +0200
Message-Id: <20240325064023.2997-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325064023.2997-1-adrian.hunter@intel.com>
References: <20240325064023.2997-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Kernel timekeeping is designed to keep the change in cycles (since the last
timer interrupt) below max_cycles, which prevents multiplication overflow
when converting cycles to nanoseconds. However, if timer interrupts stop,
the calculation will eventually overflow.

Add protection against that. Select GENERIC_VDSO_OVERFLOW_PROTECT so that
max_cycles is made available in the VDSO data page. Check against
max_cycles, falling back to a slower higher precision calculation. Take
advantage of the opportunity to move masking and negative motion check
into the slow path.

The result is a calculation that has similar performance as before. Newer
machines showed performance benefit, whereas older Skylake-based hardware
such as Intel Kaby Lake was seen <1% worse.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/Kconfig                         |  1 +
 arch/x86/include/asm/vdso/gettimeofday.h | 29 +++++++++++++++++-------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 03483b23a009..3a70ebb558e7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -168,6 +168,7 @@ config X86
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_TIME_NS
+	select GENERIC_VDSO_OVERFLOW_PROTECT
 	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
 	select HARDIRQS_SW_RESEND
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 5727dedd3549..0ef36190abe6 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -319,18 +319,31 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
  */
 static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles, u64 base)
 {
+	u64 delta = cycles - vd->cycle_last;
+
 	/*
+	 * Negative motion and deltas which can cause multiplication
+	 * overflow require special treatment. This check covers both as
+	 * negative motion is guaranteed to be greater than @vd::max_cycles
+	 * due to unsigned comparison.
+	 *
 	 * Due to the MSB/Sign-bit being used as invalid marker (see
-	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX.
+	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX,
+	 * but that case is also unlikely and will also take the unlikely path
+	 * here.
 	 */
-	u64 delta = (cycles - vd->cycle_last) & S64_MAX;
+	if (unlikely(delta > vd->max_cycles)) {
+		/*
+		 * Due to the above mentioned TSC wobbles, filter out
+		 * negative motion.  Per the above masking, the effective
+		 * sign bit is now bit 62.
+		 */
+		if (delta & (1ULL << 62))
+			return base >> vd->shift;
 
-	/*
-	 * Due to the above mentioned TSC wobbles, filter out negative motion.
-	 * Per the above masking, the effective sign bit is now bit 62.
-	 */
-	if (unlikely(delta & (1ULL << 62)))
-		return base >> vd->shift;
+		/* Handle multiplication overflow gracefully */
+		return mul_u64_u32_add_u64_shr(delta & S64_MAX, vd->mult, base, vd->shift);
+	}
 
 	return ((delta * vd->mult) + base) >> vd->shift;
 }
-- 
2.34.1


