Return-Path: <linux-kernel+bounces-12662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1498481F899
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50A028865F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06338466;
	Thu, 28 Dec 2023 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcCKsvfT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C53679CB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703768340; x=1735304340;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+eXzxuR0pHiDls2fQHe9OlVg3qaFTNYjViRLmdU/tM0=;
  b=NcCKsvfTBI5PElsSE/oVssckKKe5l3gvXjGqhCeH4N7+wX0RmdnVS+7C
   U7Bs4BcoYHTvyRXWqfTSFPmK54NBhhlRN+RaDPNhjqP7R+8IdDnrMCCX/
   11LH0K/nW6O0QWZWQAvY8/jDG6s8t7Jd6s28h82c/hVdVQ7myMDO4S5S0
   nHZ4cWkaYhKhlotieWet90mLYiHP/sdnvg8msKUBs9nsmSiVGVarPZalQ
   x1pHAKGtkN1mkf/S1uVyCNpi0OMZsrSsvxwjJPHJrBY892EOiXIPKNxau
   CA5PIWJ6xJxLJ2WWm7oOwZqQOLJqnY52MmB1bN8sm+NR0v2xOXX1JeFYu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="386978786"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="386978786"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 04:58:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="812788717"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="812788717"
Received: from fjohanne-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.35.92])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 04:58:54 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id BEA4210A536; Thu, 28 Dec 2023 15:58:51 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86/pat: Simplifying the PAT programming protocol
Date: Thu, 28 Dec 2023 15:58:47 +0300
Message-ID: <20231228125847.12842-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
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
Cc: Juergen Gross <jgross@suse.com>
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
index de10800cd4dd..7cac1b56c5e7 100644
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
2.41.0


