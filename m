Return-Path: <linux-kernel+bounces-77156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851548601C2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386221F27A99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784106AF80;
	Thu, 22 Feb 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CoSQBoF7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3765E548EA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627171; cv=none; b=UcN9lLeTtZnPyt2R9Jhn+GLKTlKDOWXlnAlrFv2/eFeRSuHcR7Yod3G84Lm5fC1SIGlqEWZweVAeJ+D3eRf+MjXzSDf/kSLbam2j5hnmqGcvMva+KUUgsBGMXEfVd3/Ro04kI9Z39kSRFc/oNQsPbglrcM0aXbNbqjPaMBYd8nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627171; c=relaxed/simple;
	bh=BPPylVdwVb0qsjnFOdjrkJjwVsPFVOkQjGFT9BiJDoA=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=bGtf2uxpZI+m2mQf0LvOZA4rbU131H1YrbCTxl5/kvP/ZUsWfCKOJ0/H86asBrsJ8gKXaqbcUTFDy2s/D2KEmEpEVnXu8mxKa+bmSw9RHp/bA9LS0qOCBUqoBKrbC9NxDBV6QV3P+ytmM3dlGoDc+plzjtGhA2uvd6AKo87qZ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CoSQBoF7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627171; x=1740163171;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=BPPylVdwVb0qsjnFOdjrkJjwVsPFVOkQjGFT9BiJDoA=;
  b=CoSQBoF7OJhhgetU9+kqSkODrwERp43kUg8OpMLShjc2ue8GPE4+3Bwj
   bZzh6ERdae+jQiCZnTppWst0keM/wcCPO4LxFnLS6E1Uun7RF79fT03PJ
   feQPrpt7T1CBZnDN73UeBzJoInMFRJGLG+gE3+kOC0WTRI0g33UDEkZCm
   gkNXlfRPEEeyCyoMBHWjMdkaJSIKVBR9BX8/P+HFPNSydE6PwcSCEWPDc
   X2t4qy1gyA9/oXlv4bwRXwqs1s6ufCslEy4KrHF2kyYDpdUq9c6VOA7VE
   EyZTveECGEwNCNz+sIdQ9rBa6IuCLymiEt/WfueV8gOkJY2qftlAvH/oh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031690"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031690"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975371"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:30 -0800
Subject: [RFC][PATCH 02/34] x86/xen: Remove early "debug" physical address lookups
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>,jgross@suse.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:29 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183929.E17C1B9C@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The __pa() facility is subject to debugging checks if CONFIG_DEBUG_VIRTUAL=y.
One of those debugging checks is whether the physical address is valid
on the platform.  That information is normally available via CPUID.  But
the __pa() code currently looks it up in 'boot_cpu_data' which is not
fully set up in early Xen PV boot.

The Xen PV code currently tries to get this info with
get_cpu_address_sizes() which also depends on 'boot_cpu_data' to be at
least somewhat set up.  The result is that the c->x86_phys_bits gets a
sane value, but not one that has anything to do with the hardware.  In
other words, the CONFIG_DEBUG_VIRTUAL checks are performed with what
amounts to garbage inputs.

Garbage checks are worse than no check at all.  Move over to the
"nodebug" variant to axe the checks.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>
---

 b/arch/x86/xen/enlighten_pv.c |    2 +-
 b/arch/x86/xen/mmu_pv.c       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/x86/xen/enlighten_pv.c~xen-no-early-__pa arch/x86/xen/enlighten_pv.c
--- a/arch/x86/xen/enlighten_pv.c~xen-no-early-__pa	2024-02-22 10:08:48.868469363 -0800
+++ b/arch/x86/xen/enlighten_pv.c	2024-02-22 10:08:48.872469519 -0800
@@ -1452,7 +1452,7 @@ asmlinkage __visible void __init xen_sta
 	boot_params.hdr.type_of_loader = (9 << 4) | 0;
 	boot_params.hdr.ramdisk_image = initrd_start;
 	boot_params.hdr.ramdisk_size = xen_start_info->mod_len;
-	boot_params.hdr.cmd_line_ptr = __pa(xen_start_info->cmd_line);
+	boot_params.hdr.cmd_line_ptr = __pa_nodebug(xen_start_info->cmd_line);
 	boot_params.hdr.hardware_subarch = X86_SUBARCH_XEN;
 
 	if (!xen_initial_domain()) {
diff -puN arch/x86/xen/mmu_pv.c~xen-no-early-__pa arch/x86/xen/mmu_pv.c
--- a/arch/x86/xen/mmu_pv.c~xen-no-early-__pa	2024-02-22 10:08:48.872469519 -0800
+++ b/arch/x86/xen/mmu_pv.c	2024-02-22 10:08:48.872469519 -0800
@@ -2006,7 +2006,7 @@ void __init xen_reserve_special_pages(vo
 {
 	phys_addr_t paddr;
 
-	memblock_reserve(__pa(xen_start_info), PAGE_SIZE);
+	memblock_reserve(__pa_nodebug(xen_start_info), PAGE_SIZE);
 	if (xen_start_info->store_mfn) {
 		paddr = PFN_PHYS(mfn_to_pfn(xen_start_info->store_mfn));
 		memblock_reserve(paddr, PAGE_SIZE);
_

