Return-Path: <linux-kernel+bounces-77173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476DA8601D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFD728AB15
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEEF149393;
	Thu, 22 Feb 2024 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVvH0HT5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7360140372
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627194; cv=none; b=JahPKSN0VZq3GpZCzOQODPzEt9ThSsKq7srtCh4mKh454t+Gi0UNxtT+GLJLHgSRMah2Bw8TABxoHM+Spga33KvCFtOoldDsv4N5xeXUpGwRXLwfuFITdsv+nejvo3/yVLihxw74LWMtRZspzal7qk+dBgy5Vv0udLln3tnsIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627194; c=relaxed/simple;
	bh=lVSBkQ+5G44BZu5dX85c0yqtBnGNPsKMRwhEBPumIA8=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=cp4P7gzJj52hFDGOCF854WZcyxPfGmR0bxpWHi6kzQFKiFOiCBHACIMd5hwdUilJC6HoXowXuI36Pz1JhxvxbYq8Squ01OcZyM486rF6Lif4Z6eOzRFs48fWrk+c7lircczl6qaG3bUTmlHJz2n0omP1SiXbpPa+RWIGB5XxsYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVvH0HT5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627193; x=1740163193;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=lVSBkQ+5G44BZu5dX85c0yqtBnGNPsKMRwhEBPumIA8=;
  b=IVvH0HT5ijKUg7MA6/qPZlzP9TCpjvpT6AH0x7VLswbz9gGtWB8qbPrw
   JKjx9UYHoCPf0wc6UkSS/jiVnya/MQHw0Poyvr4HbNBzLrHoqgzM7eCDj
   AmyixkCd8Ye29FzblJ+v8VRAS8gSgOWcnuxo1VMQMriWYTRVvYOYxCmhh
   +2PmfwZtWfPg2fKU1SHDTHXJTZxWiWt+h6pz2u7crDOihVKc3JhpGh+La
   eq3kb9LBch2w1nBxHnaqzFAcEmPcQ2adoN3usJnzOdwtQUXxtEcTQ5Buz
   jkoNvtBGe0SBruu9JAsdy5j5/jJ2Z9c5MJ7b5UeJIdeHySNnYKCfVMqsE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031831"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031831"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975561"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:52 -0800
Subject: [RFC][PATCH 19/34] x86/cpu: Introduce cache alignment multiplier
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:51 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183951.6BCC4D89@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The kernel currently tracks two different but similar-sounding values:

	x86_clflush_size
and
	x86_cache_alignment

x86_clflush_size is literally the size of the cacheline which is also
the architectural granularity at which CLFLUSH operates.

But some weirdo CPUs like the Pentium 4 do some operations across
two cachelines.  Their CLFLUSH still works at 'x86_clflush_size'
but they need some operations aligned to that double cacheline to
work well, thus 'x86_cache_alignment'.

Introduce and use a 'bsp_addr_config' field for these systems.

Note that the Intel Family 15 code actually did this in two different
sites, one for 32-bit and one for 64-bit.  Unify them.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/processor.h |    7 +++++++
 b/arch/x86/kernel/cpu/centaur.c    |    2 +-
 b/arch/x86/kernel/cpu/common.c     |    3 +++
 b/arch/x86/kernel/cpu/intel.c      |   10 ++++------
 4 files changed, 15 insertions(+), 7 deletions(-)

diff -puN arch/x86/include/asm/processor.h~x86_cache_alignment_mult arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~x86_cache_alignment_mult	2024-02-22 10:08:57.732817356 -0800
+++ b/arch/x86/include/asm/processor.h	2024-02-22 10:08:57.740817669 -0800
@@ -172,6 +172,13 @@ struct x86_addr_config {
 	 * platforms that use memory encryption.
 	 */
 	u8 phys_addr_reduction_bits;
+
+	/*
+	 * "x86_clflush_size" is the size of an actual cacheline.
+	 * Allow systems to specify a multiplier where alignment
+	 * will take place at a more coarse granularity.
+	 */
+	u8 cache_align_mult;
 };
 
 /*
diff -puN arch/x86/kernel/cpu/centaur.c~x86_cache_alignment_mult arch/x86/kernel/cpu/centaur.c
--- a/arch/x86/kernel/cpu/centaur.c~x86_cache_alignment_mult	2024-02-22 10:08:57.732817356 -0800
+++ b/arch/x86/kernel/cpu/centaur.c	2024-02-22 10:08:57.740817669 -0800
@@ -216,7 +216,7 @@ static void init_centaur(struct cpuinfo_
 static void bsp_init_centaur(struct cpuinfo_x86 *c)
 {
 	if (c->x86 == 0x6 && c->x86_model >= 0xf)
-		c->x86_cache_alignment = x86_clflush_size() * 2;
+		bsp_addr_config.cache_align_mult = 2;
 }
 
 #ifdef CONFIG_X86_32
diff -puN arch/x86/kernel/cpu/common.c~x86_cache_alignment_mult arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~x86_cache_alignment_mult	2024-02-22 10:08:57.736817513 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:08:57.740817669 -0800
@@ -1124,7 +1124,10 @@ void get_cpu_address_sizes(struct cpuinf
 		}
 	}
 	c->x86_cache_bits = x86_config.phys_bits;
+
 	c->x86_cache_alignment = x86_clflush_size();
+	if (bsp_addr_config.cache_align_mult)
+		c->x86_cache_alignment *= bsp_addr_config.cache_align_mult;
 
 	/* Do this last to avoid affecting ->x86_cache_bits. */
 	x86_config.phys_bits -= bsp_addr_config.phys_addr_reduction_bits;
diff -puN arch/x86/kernel/cpu/intel.c~x86_cache_alignment_mult arch/x86/kernel/cpu/intel.c
--- a/arch/x86/kernel/cpu/intel.c~x86_cache_alignment_mult	2024-02-22 10:08:57.736817513 -0800
+++ b/arch/x86/kernel/cpu/intel.c	2024-02-22 10:08:57.740817669 -0800
@@ -236,10 +236,6 @@ static void early_init_intel(struct cpui
 
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
-#else
-	/* Netburst reports 64 bytes clflush size, but does IO in 128 bytes */
-	if (c->x86 == 15 && c->x86_cache_alignment == 64)
-		c->x86_cache_alignment = 128;
 #endif
 
 	/*
@@ -418,6 +414,10 @@ static void bsp_init_intel(struct cpuinf
 		WARN_ON_ONCE(keyid_bits);
 		bsp_addr_config.phys_addr_reduction_bits = 4;
 	}
+
+	/* Netburst reports 64 bytes clflush size, but does IO in 128 bytes */
+	if (c->x86 == 15)
+		bsp_addr_config.cache_align_mult = 2;
 }
 
 #ifdef CONFIG_X86_32
@@ -659,8 +659,6 @@ static void init_intel(struct cpuinfo_x8
 		set_cpu_bug(c, X86_BUG_MONITOR);
 
 #ifdef CONFIG_X86_64
-	if (c->x86 == 15)
-		c->x86_cache_alignment = x86_clflush_size() * 2;
 	if (c->x86 == 6)
 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 #else
_

