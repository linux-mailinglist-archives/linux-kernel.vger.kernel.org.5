Return-Path: <linux-kernel+bounces-37049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB2083AA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33511C2610C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5077655;
	Wed, 24 Jan 2024 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A05A0igJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD357765E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101617; cv=none; b=EITvvkoD2irmoVlsYcwGEM5dLUMRjR203UwdYXFUth7DtuwWPFzVuoOVz+V+u4VM+9sltJc+DSIYPgzmoOuS1oOHwxZdWXg3nwvYQyX3bXqzSlNG01bqRWesEG4C54mUDGuU5i9eROplsn7hsif27Eh8jPOZZn1DO+oYgP8PXnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101617; c=relaxed/simple;
	bh=dujYRm0zmFA26MfiC8o/r8uHHYPjm22iKpWqpqVW4s4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTeM8QyRwDn/EDhf+UlwEtHFVIAo14R4RHu7i8UWXzBjZkpqxoTuvjFv33YGXt7lFFvaEVnL/UByQqU8xgc5oqpTcKOTfrGMLv9haXh+Qej+u5GEE5SpjPRib5pfpuCWTbrMCMcFPhyGw3Vaq2C0I44bg/DN+Dz1ytKBtaYqF9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A05A0igJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706101617; x=1737637617;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dujYRm0zmFA26MfiC8o/r8uHHYPjm22iKpWqpqVW4s4=;
  b=A05A0igJYy5Ev2rG+NRD2rZRcipT4HegVmHZLqHw5XywOMozcCr4zPY0
   RZh8oEy210/5qOVE5z/ZD2mPCa06KrUoThCgrpDLgvI6pWQHj4EwDTkDb
   4a0DN8AtFGEErBat+aDQ//rbDqVJA9M4iJ/h148mnc+0XPQU7ABSh7scx
   yOgU8K/xv9eYM6ZJ+RdZT3ntYdgIMowc62nLoZF2dJ77PhyGlzcaYPbuN
   Lr++s5YBII3/rxKhpP6FUyc82oA+lVypbQ31yqjL++ULc8oZTWSOrt5gG
   I2oSFUeIJ/tKELaK9hrSSTvTB3/ZgIOLU3hG9x4HOUPBglKOchFJH6Q5R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1727545"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1727545"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 05:06:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="905590853"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="905590853"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jan 2024 05:06:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 1675B5E8; Wed, 24 Jan 2024 15:06:51 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH, RESEND] x86/pat: Simplifying the PAT programming protocol
Date: Wed, 24 Jan 2024 15:06:50 +0200
Message-ID: <20240124130650.496056-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The programming protocol for the PAT MSR follows the MTRR programming
protocol. However, this protocol is cumbersome and requires disabling
caching (CR0.CD=1), which is not possible on some platforms.

Specifically, a TDX guest is not allowed to set CR0.CD. It triggers
a #VE exception.

Turned out the requirement to follow the MTRR programming protocol for
PAT programming is unnecessarily strict. The new Intel Software
Developer Manual[1] (December 2023) relaxes this requirement. Please
refer to the section titled "Programming the PAT" for more information.

The AMD documentation does not link PAT programming to MTRR.

The kernel only needs to flush the TLB after updating the PAT MSR. The
set_memory code already takes care of flushing the TLB and cache when
changing the memory type of a page.

[1] http://www.intel.com/sdm

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/cpu/cacheinfo.c | 7 ++++---
 arch/x86/mm/pat/memtype.c       | 9 +++------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index c131c412db89..78afad50a7c0 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1118,15 +1118,16 @@ static void cache_cpu_init(void)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	cache_disable();
 
-	if (memory_caching_control & CACHE_MTRR)
+	if (memory_caching_control & CACHE_MTRR) {
+		cache_disable();
 		mtrr_generic_set_state();
+		cache_enable();
+	}
 
 	if (memory_caching_control & CACHE_PAT)
 		pat_cpu_init();
 
-	cache_enable();
 	local_irq_restore(flags);
 }
 
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 0904d7e8e126..0d72183b5dd0 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -240,6 +240,8 @@ void pat_cpu_init(void)
 	}
 
 	wrmsrl(MSR_IA32_CR_PAT, pat_msr_val);
+
+	__flush_tlb_all();
 }
 
 /**
@@ -296,13 +298,8 @@ void __init pat_bp_init(void)
 	/*
 	 * Xen PV doesn't allow to set PAT MSR, but all cache modes are
 	 * supported.
-	 * When running as TDX guest setting the PAT MSR won't work either
-	 * due to the requirement to set CR0.CD when doing so. Rely on
-	 * firmware to have set the PAT MSR correctly.
 	 */
-	if (pat_disabled ||
-	    cpu_feature_enabled(X86_FEATURE_XENPV) ||
-	    cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+	if (pat_disabled || cpu_feature_enabled(X86_FEATURE_XENPV)) {
 		init_cache_modes(pat_msr_val);
 		return;
 	}
-- 
2.43.0


