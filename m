Return-Path: <linux-kernel+bounces-77175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A08601D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AB028BA9C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8891493BD;
	Thu, 22 Feb 2024 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oj0twNyG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE614938E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627196; cv=none; b=tjufXbFUmDQRFQzjZf2CTK+M4pWV8xFfhXDLGPgyinMSMLoguKV84s1N8FM5E8f/93FHnqgfvD1jljjJWAy/hkMti+2bTFplzhx+4pJGyaeqkPSKAQaOJXX+GNhLH1rMgS6sU9n4vqo0K06TKROJgrQc2jriqa4jDE4S8kd0vy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627196; c=relaxed/simple;
	bh=nx/rpbn5tIj5Y+XhodSjBqWfpjIWIvV6is8OneYevSs=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=Uu1QYc3UnCBO3ZOFRNsMTYDc1IzZ3ktQwkAQssJLX8GVl2JrrKP2B7a/mZyqsSKV+s1Nv0iD2HMcKpMnkpZMjIJRA6E5GnGnHuzuSQtqXABbUbMMJaMaIOHoLYLg5mnI/SCHefbpbhfgtnCpi8HDk5uEfgNK84aFU8G9DZzPWAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oj0twNyG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627195; x=1740163195;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=nx/rpbn5tIj5Y+XhodSjBqWfpjIWIvV6is8OneYevSs=;
  b=Oj0twNyGf8Qgta8Naju5WFdpqHOinqn/x7Lbqb8unDinzAeW+PyxLSj+
   3JkTAl8HMYn3EHhgeiVYnwJe5i3OOUgI0LPtF6TmMil/XXK+LUn59qkKO
   gkN4fc/xlmuQsrepRc7PjS3mPLEEqvbclGoHSXXS7iP4Samz8P4+uzCky
   89qBsQB/5U/AUTVBzuZYPCSZlyX18/fSyQgGBK8H31fI50zgUwUvYTFG0
   6mnsHcfcW3I7dXSbPGMCCruUObWVMn6JEZvArL1uzW56xavqJT4Jy6UzR
   lLRMGcd+6I49SY5Ne6dG1UfHIpZCWr0xPoFsC+584rLruPyn2cjzaqxbL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031846"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031846"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975588"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:55 -0800
Subject: [RFC][PATCH 21/34] x86/cpu: Consolidate CLFLUSH size setting.
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:54 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183954.9A6E5428@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Right now, cpu_detect() establishes ->x86_clflush_size on each CPU
that.  supports CLFLUSH.  As you might have guessed, that per-cpu
value is no longer used.

Move the setting to get_cpu_address_sizes() which is only called
on the boot CPU.  Consolidate all of the ->x86_clflush_size logic
into a single helper.

This removes the (cap0 & (1<<19) aka X86_FEATURE_CLFLUSH check before
reading the CLFLUSH size out of CPUID[1].  Those bits are presumably
either 0 or have actual data about CLFLUSH in them.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/common.c |   35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff -puN arch/x86/kernel/cpu/common.c~later-clflush_size-detect arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~later-clflush_size-detect	2024-02-22 10:08:58.728856457 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:08:58.732856614 -0800
@@ -935,6 +935,27 @@ static void get_cpu_vendor(struct cpuinf
 	this_cpu = &default_cpu;
 }
 
+static u16 detect_clflush_size(struct cpuinfo_x86 *c)
+{
+	u16 clflush_size = 0;
+
+	if (c->cpuid_level >= 0x00000001) {
+		u32 eax, ebx, ecx, edx;
+
+		cpuid(0x00000001, &eax, &ebx, &ecx, &edx);
+
+		clflush_size = ((ebx >> 8) & 0xff) * 8;
+	}
+
+	if (clflush_size)
+		return clflush_size;
+
+	/* Return some mostly sane defaults: */
+	if (IS_ENABLED(CONFIG_X86_64))
+		return 64;
+	return 32;
+}
+
 void cpu_detect(struct cpuinfo_x86 *c)
 {
 	/* Get vendor name */
@@ -952,11 +973,6 @@ void cpu_detect(struct cpuinfo_x86 *c)
 		c->x86		= x86_family(tfms);
 		c->x86_model	= x86_model(tfms);
 		c->x86_stepping	= x86_stepping(tfms);
-
-		if (cap0 & (1<<19)) {
-			if (c == &boot_cpu_data)
-				c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
-		}
 	}
 }
 
@@ -1111,17 +1127,17 @@ void get_cpu_address_sizes(struct cpuinf
 		if (IS_ENABLED(CONFIG_X86_64)) {
 			x86_config.phys_bits = 36;
 			x86_config.virt_bits = 48;
-			c->x86_clflush_size = 64;
 		} else {
 			x86_config.phys_bits = 32;
 			x86_config.virt_bits = 32;
-			c->x86_clflush_size = 32;
 
 			if (cpu_has(c, X86_FEATURE_PAE) ||
 			    cpu_has(c, X86_FEATURE_PSE36))
 				x86_config.phys_bits = 36;
 		}
 	}
+	c->x86_clflush_size = detect_clflush_size(c);
+
 	c->x86_cache_bits = x86_config.phys_bits;
 
 	c->x86_cache_alignment = x86_clflush_size();
@@ -1827,11 +1843,8 @@ static void identify_cpu(struct cpuinfo_
 	c->topo.cu_id = 0xff;
 	c->topo.llc_id = BAD_APICID;
 	c->topo.l2c_id = BAD_APICID;
-#ifdef CONFIG_X86_64
-	c->x86_clflush_size = 64;
-#else
+#ifndef CONFIG_X86_64
 	c->cpuid_level = -1;	/* CPUID not detected */
-	c->x86_clflush_size = 32;
 #endif
 	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
 #ifdef CONFIG_X86_VMX_FEATURE_NAMES
_

