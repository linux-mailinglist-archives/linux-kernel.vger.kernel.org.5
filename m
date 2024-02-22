Return-Path: <linux-kernel+bounces-77163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 241158601CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5516E1C2564E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F40873F10;
	Thu, 22 Feb 2024 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6TUSdZ1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D571742
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627180; cv=none; b=a0ZHfg7l9yosAEn/sQ+YqDMg1Q5ZFJOVwDyW31bS/FwFseoiQ7dctCW0miIkSSIVDumT+EoINHeGUdpPQrXWFaCwyjvzn9qfz5PAPcjO8hx/ejkb7xjPKimhjJCY6pStBhfzA1s/FaImuw6pejAMetz4FbLG41DB2kzgIDlAsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627180; c=relaxed/simple;
	bh=LjZ3XkjG0M1tVloJWQZTp9CLqyaMld5LilwFQntGdmY=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=TAGh8khGUqAdkSDjfVvQg8u6UlSuDLXszCMs0UGYGbAvT+icWPohvNiVP96XyWUXqFmIy/yw8ReozMx4hHcckc6QuOxiQdWJISmjgnWGRq9t4QDkVqx8xkWsT6gUWc15Tr6Y49GCWLJsJQr0zCs00V9nHYEizD1GM7W0t9+F5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6TUSdZ1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627180; x=1740163180;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=LjZ3XkjG0M1tVloJWQZTp9CLqyaMld5LilwFQntGdmY=;
  b=T6TUSdZ1wxGN7ot4dagJvl6U5WnF4EB2IOsI0Y+dCQk0uCxECB/lleXi
   eVjsNxuK44KaP1iNbHqIGrwjGZQA/B55sh/GWydY1fkyTMZgbsLHX/CZk
   hWiOcOT/o/1JhvQC7j2yuFznOSKaiRzQGSm5OqCmvcRqc4GSjBnxLrb0d
   aJ5tnRT//D4KPSv7eVz1GdwxtYBkE1WSs6ZVq0/x39oV4w7v/nUl7FTv8
   U3Kr54EdI4vTI4f9Wzx6s5oDlIGfetLc/brZbcBgLfiKvLowGE4UNAonF
   uBNC/qPNgdlCwx19v9Knsv7oLDXo9iZGF3SSi0hki8wlZ2JVUTBrdxqvy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031750"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031750"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975461"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:39 -0800
Subject: [RFC][PATCH 09/34] x86/cpu: Introduce address configuration structure
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:38 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183938.662DD27C@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Right now, 'boot_cpu_data' is established in a very ad hoc way.  Random
bits of the initialization code write random things to it, either
blowing away state or tweaking it as they see fit.  It's madness.

Add some more structure to the process.

Introduce an "address configuration" structure just for the boot CPU.
This will be used to establish system-wide address space configuration.
It is written while bringing up the boot CPU and then read *ONCE* to
establish the configuration.

Also introduce the first field: phys_addr_reduction_bits.  This field
will be used by memory encryption hardware that reduces the actual
usable address bits beneath what the hardware enumerates.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/processor.h |   14 ++++++++++++++
 b/arch/x86/kernel/cpu/common.c     |    3 +++
 b/arch/x86/kernel/setup.c          |    2 ++
 3 files changed, 19 insertions(+)

diff -puN arch/x86/include/asm/processor.h~bsp-addr-info arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~bsp-addr-info	2024-02-22 10:08:52.824624673 -0800
+++ b/arch/x86/include/asm/processor.h	2024-02-22 10:08:52.828624830 -0800
@@ -163,6 +163,19 @@ struct cpuinfo_x86 {
 	unsigned		initialized : 1;
 } __randomize_layout;
 
+/*
+ * Must be written by the time ->c_bsp_init() completes.
+ * Consumed in get_cpu_address_sizes().
+ */
+struct x86_addr_config {
+	/*
+	 * How many bits of the expected or enumerated physical
+	 * address space are unavailable?  Typically set on
+	 * platforms that use memory encryption.
+	 */
+	u8 phys_addr_reduction_bits;
+};
+
 #define X86_VENDOR_INTEL	0
 #define X86_VENDOR_CYRIX	1
 #define X86_VENDOR_AMD		2
@@ -182,6 +195,7 @@ struct cpuinfo_x86 {
  */
 extern struct cpuinfo_x86	boot_cpu_data;
 extern struct cpuinfo_x86	new_cpu_data;
+extern struct x86_addr_config	bsp_addr_config;
 
 extern __u32			cpu_caps_cleared[NCAPINTS + NBUGINTS];
 extern __u32			cpu_caps_set[NCAPINTS + NBUGINTS];
diff -puN arch/x86/kernel/cpu/common.c~bsp-addr-info arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~bsp-addr-info	2024-02-22 10:08:52.824624673 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:08:52.828624830 -0800
@@ -1125,6 +1125,9 @@ void get_cpu_address_sizes(struct cpuinf
 	}
 	c->x86_cache_bits = c->x86_phys_bits;
 	c->x86_cache_alignment = x86_clflush_size();
+
+	/* Do this last to avoid affecting ->x86_cache_bits. */
+	c->x86_phys_bits -= bsp_addr_config.phys_addr_reduction_bits;
 }
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
diff -puN arch/x86/kernel/setup.c~bsp-addr-info arch/x86/kernel/setup.c
--- a/arch/x86/kernel/setup.c~bsp-addr-info	2024-02-22 10:08:52.824624673 -0800
+++ b/arch/x86/kernel/setup.c	2024-02-22 10:08:52.828624830 -0800
@@ -131,6 +131,8 @@ struct ist_info ist_info;
 struct cpuinfo_x86 boot_cpu_data __read_mostly;
 EXPORT_SYMBOL(boot_cpu_data);
 
+struct x86_addr_config bsp_addr_config;
+
 #if !defined(CONFIG_X86_PAE) || defined(CONFIG_X86_64)
 __visible unsigned long mmu_cr4_features __ro_after_init;
 #else
_

