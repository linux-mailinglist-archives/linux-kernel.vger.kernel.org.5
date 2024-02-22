Return-Path: <linux-kernel+bounces-77157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A768601C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDE61F27E54
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFC16AF9D;
	Thu, 22 Feb 2024 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJgXYgLr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B126548FF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627172; cv=none; b=P2Fu7thFCNcO0Bs1kjTNS9v/BgfUZD+EWc+to3cQeKmA6jVD5kuukbw2a0tZNVdqWSbgq9WlNo4o94/dlKJS0SVz+6/PIcHz+30Kagy0OyVRoBp3wyWt6S9NTp6RE83ZKji5bRgdO3mk/YKmwG761r95NqRUKhgr5QcXmPIJmUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627172; c=relaxed/simple;
	bh=reS7y9hoRcSiyLDxW0i1cvzSnB6X77odpIXVmZj0hO4=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=qkAYQ4ivATkMts+FGPm2koNvE72OMD/hOG6w8Szyb037WZEF/lWPIWa66lBf81pRJntNoLF0has93vETaJP9l1xaUbeIiE9mD8lfwsCQjpgA+sv7asMpXyrsj1qGx9TVLUfgJPlDsEpxmxcwzl9SEgoZYcy2nWwvPKDxzUbLbAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJgXYgLr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627172; x=1740163172;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=reS7y9hoRcSiyLDxW0i1cvzSnB6X77odpIXVmZj0hO4=;
  b=SJgXYgLr8wewQQzMBKjs0KtCdD2lgB3k/CIaNQ0Uk4+sHaRVK2n6zi1x
   2cIeOsCmCKs3uQSBfprkfFMpASEGDbD/VrLogRUbZltUzGnyh5X8qA1DO
   Z6UtJ+3xiIxSIfeP8qtdcWoWb1kMJZ3xo0ZbM16ZeY2bfg6AEMt2Tzn7n
   uOx8OxnWYDRCxy6FP3gtnVIiWf4gpr/RDWq7jqtC6E8PfLrDZngdEpNkx
   cyu0ek6jCFvKU+5Up2Sfc7WzV4KzU5c/4Awcxv9elkIv3e7vZSMw5/1Oa
   N6nv/UJZ50z8zPw1k75rV6/ge3Xq/DhEoxqGZTGxPh9fe78uuvyNSstsf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031700"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031700"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975391"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:31 -0800
Subject: [RFC][PATCH 03/34] x86/pci: Assume that clflush size is always provided
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:30 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183930.18D74E8B@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The early boot code always sets _some_ clflush size.  Use that fact
to avoid handling the case where it is not set.

There may have been a time when the Xen PV call in here way too
early.  But it calls get_cpu_address_sizes() before calling here
now.  It should also be safe.

Note: This series will eventually return sane defaults even very
early in boot.  I believe this is safe now, but it becomes *really*
safe later on.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/pci/common.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff -puN arch/x86/pci/common.c~x86-pci-clflush-size arch/x86/pci/common.c
--- a/arch/x86/pci/common.c~x86-pci-clflush-size	2024-02-22 10:08:49.356488521 -0800
+++ b/arch/x86/pci/common.c	2024-02-22 10:08:49.356488521 -0800
@@ -480,22 +480,9 @@ void pcibios_scan_root(int busnum)
 
 void __init pcibios_set_cache_line_size(void)
 {
-	struct cpuinfo_x86 *c = &boot_cpu_data;
-
-	/*
-	 * Set PCI cacheline size to that of the CPU if the CPU has reported it.
-	 * (For older CPUs that don't support cpuid, we se it to 32 bytes
-	 * It's also good for 386/486s (which actually have 16)
-	 * as quite a few PCI devices do not support smaller values.
-	 */
-	if (c->x86_clflush_size > 0) {
-		pci_dfl_cache_line_size = c->x86_clflush_size >> 2;
-		printk(KERN_DEBUG "PCI: pci_cache_line_size set to %d bytes\n",
-			pci_dfl_cache_line_size << 2);
-	} else {
- 		pci_dfl_cache_line_size = 32 >> 2;
-		printk(KERN_DEBUG "PCI: Unknown cacheline size. Setting to 32 bytes\n");
-	}
+	pci_dfl_cache_line_size = boot_cpu_data.x86_clflush_size >> 2;
+	printk(KERN_DEBUG "PCI: pci_cache_line_size set to %d bytes\n",
+		pci_dfl_cache_line_size << 2);
 }
 
 int __init pcibios_init(void)
_

