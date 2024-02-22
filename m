Return-Path: <linux-kernel+bounces-77176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEB88601DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BBB5B295AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF2E14CAB1;
	Thu, 22 Feb 2024 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KoBNdgtp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A321493AB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627197; cv=none; b=eRTmVLn5YpnBv/ckSqMVYL8ze8UqiF4/THiXh9HXkb1y3Mwo3K5YcF6YLA+Ag8s0i1AZv6Sh86eiCCsTuRuzOnFmsXwNPkmNZr5d1/1J3n/ScDwrsWUqTxGu9tZ6ZsoHyHDuy2yC83tdcr7ErrXcziwe3XMHQFC9/u4bHxLzB8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627197; c=relaxed/simple;
	bh=v85h6zmWNcl6pvDbPStk269PNzaerYIPB3bTofH0JD8=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=TYTHKU2YHt6Y4dxt5D+9OvWdoku2zzidA9rTLHCLGwOOw5sDKL4R7Dj8T6ggpfarrKWvIb5NXLhFa/bgKpX1W1VR6gjLG1d4OOxkh+k9V1Q/lcgqheIFLvDJMCFrdQLHfkAiUw2jpoxEiYBDLnojBoqL6tRiIzx8kMezhw5amG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KoBNdgtp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627197; x=1740163197;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=v85h6zmWNcl6pvDbPStk269PNzaerYIPB3bTofH0JD8=;
  b=KoBNdgtpJA5rD/teT1upwOP5lmK88rJQK0i326jkoffDMv/vhKLrNs4y
   rUONFB3DioZkppMzrGUUWD19QOttMufx+2TqvZzwl0hypEifPWaVmowqg
   TDbp5JM+D+RgmZlqARMSXgzm2Kz7gH41RIOLBfwO1gDTvbu6OU1C5GNVj
   YRrxvt6qLSXfYKXWh2ewcOA1E8aU477sWa+O+e4KgA4cMHrvgv8JreEUN
   2hkA5mq+uD+jBRFjKOBpBc5+z4Van/RyyWomAXdpgiROOpSXILh6oqIBV
   A+i6Qgwd6uMDYg5dFi9GYb2/JYPEa3b16F0kD4b7EfBnuU1FN8TFSERAP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031854"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031854"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975605"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:56 -0800
Subject: [RFC][PATCH 22/34] x86/cpu: Move CLFLUSH size into global config
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:55 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183955.292E89F8@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

x86_clflush_size is maintained per-cpu despite being global configuration.

Move it to 'x86_config'.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/processor.h |    4 ++--
 b/arch/x86/kernel/cpu/common.c     |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/x86/include/asm/processor.h~bsp-clflush_size arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~bsp-clflush_size	2024-02-22 10:08:59.208875301 -0800
+++ b/arch/x86/include/asm/processor.h	2024-02-22 10:08:59.212875458 -0800
@@ -148,7 +148,6 @@ struct cpuinfo_x86 {
 	u64			ppin;
 	/* cpuid returned max cores value: */
 	u16			x86_max_cores;
-	u16			x86_clflush_size;
 	/* number of cores as seen by the OS: */
 	u16			booted_cores;
 	/* Index into per_cpu list: */
@@ -191,6 +190,7 @@ struct x86_sys_config {
 	/* Address bits supported by all processors */
 	u8	phys_bits;
 	u8	virt_bits;
+	u16	clflush_size;
 };
 
 extern struct x86_sys_config x86_config;
@@ -812,7 +812,7 @@ static inline u8 x86_virt_bits(void)
 
 static inline u8 x86_clflush_size(void)
 {
-	return boot_cpu_data.x86_clflush_size;
+	return x86_config.clflush_size;
 }
 
 #endif /* _ASM_X86_PROCESSOR_H */
diff -puN arch/x86/kernel/cpu/common.c~bsp-clflush_size arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~bsp-clflush_size	2024-02-22 10:08:59.208875301 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:08:59.212875458 -0800
@@ -1136,7 +1136,7 @@ void get_cpu_address_sizes(struct cpuinf
 				x86_config.phys_bits = 36;
 		}
 	}
-	c->x86_clflush_size = detect_clflush_size(c);
+	x86_config.clflush_size = detect_clflush_size(c);
 
 	c->x86_cache_bits = x86_config.phys_bits;
 
_

