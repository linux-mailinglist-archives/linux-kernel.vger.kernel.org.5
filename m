Return-Path: <linux-kernel+bounces-77168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120268601D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73031B28AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC9713792C;
	Thu, 22 Feb 2024 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcaNhyrb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D112D20E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627187; cv=none; b=U3WJf2Q69u1ObdDMxB8LfbJAacf6kDSK9HjviHpncmdGz6TM/O+8yREYHCrWkISKO9ZVFN3x/bfv+8/YdwWLSq/csH8NQy7xsI2TrpHBqS73yiQMSU+VC1+pwpJH75SVVhsJyDs0Nukf/rvU9Qc0inacM86gHT2W/ZNhFb9icc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627187; c=relaxed/simple;
	bh=MxDsNdC/Re/7k1BR0zpTGqTAJuSw/SegugBpbmZ6QI8=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=K3UiVI9/ZGf9Gy4apX77bpfJuXmWWX9/Ffp2hh9wG6iH/14jeag+6AshZAsXcRe5KJ4kPh1PMT+9lbckSmenNBZjIfr/2QN628YorhrpyicQRcpoInu9mNoIEEIOxtQ+HO0A3bmMxp6ww9Z6FBnnxqNKkTz9tUNZ/udILWJlrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcaNhyrb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627186; x=1740163186;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=MxDsNdC/Re/7k1BR0zpTGqTAJuSw/SegugBpbmZ6QI8=;
  b=FcaNhyrblZD/yxmmP1MJ/1bCBooha2xJU+c0BlVlTryNcSbp5mAfYOMI
   sIqktRSMzmCkAj0HnTbWh8mS3XfYP9Tp5SLy1o2D62x1ydc7IMT3C0Otp
   yLP1Y0CD29fbCD50o70DV3PRMUXmDLitvrG5sn5SwUqLvS2J2a7nF4y6d
   S4Jc3l9EOh7ypH0E7UvIZc2h2pwmEFYysYRb9zDTNTQpBc22SwSiArcF0
   2KhlMNtV2qvLlniEyXwTu49gYtFLWV068vBVqsLANnnUVAO8n5Zkr/Lyi
   gHjhHD6bbHVt4Hc9jDBDcIF4MxGXPIhKIJB/qnL8OWAVx3XU3wJPMxhk6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031792"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031792"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975510"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:46 -0800
Subject: [RFC][PATCH 14/34] x86/cpu: Remove default physical address space settings
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:45 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183945.877FCD8C@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

At this point, the secondary CPUs' c->x86_phys_bits should be unused.  The boot
CPU values were also established long before reaching here.  This can only
serve to sow chaos.  Remove the twiddling.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/common.c |    2 --
 1 file changed, 2 deletions(-)

diff -puN arch/x86/kernel/cpu/common.c~no-default-bit-setting-phys arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~no-default-bit-setting-phys	2024-02-22 10:08:55.256720151 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:08:55.260720308 -0800
@@ -1827,12 +1827,10 @@ static void identify_cpu(struct cpuinfo_
 	c->topo.l2c_id = BAD_APICID;
 #ifdef CONFIG_X86_64
 	c->x86_clflush_size = 64;
-	c->x86_phys_bits = 36;
 	c->x86_virt_bits = 48;
 #else
 	c->cpuid_level = -1;	/* CPUID not detected */
 	c->x86_clflush_size = 32;
-	c->x86_phys_bits = 32;
 	c->x86_virt_bits = 32;
 #endif
 	c->x86_cache_alignment = x86_clflush_size();
_

