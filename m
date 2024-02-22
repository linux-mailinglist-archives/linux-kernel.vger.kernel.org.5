Return-Path: <linux-kernel+bounces-77174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A669A8601D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A811F29495
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A911493A3;
	Thu, 22 Feb 2024 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0zy/b1Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BF13BAF5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627194; cv=none; b=Rr8ffdtfI0MbPrOEck+X1Nn++VHE0kO3VOiWOl4VWxcfiwdzRturwtSQKuQml+CM04CCDZBUm+wAY7x/1YfaKKTT0ldEY7E0MSrFZJQw070xXz9+PlPCrTHGGO8ziyL2E1pFSjJkOROu7tY2Q8wymlgn4DjEi0c0eFByqx2AaO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627194; c=relaxed/simple;
	bh=kGouo5XDP+/c1NdKS2yBopq/rLDDpdyzpRegRLzF9jA=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=vD3Ta8PUXHe6XCoHALF7KAJAKYAO5Tb/two4XnUrekuc4T+YV4EI2F2s1MBNHL2LXIfh9k6iKjJ1AUIOdHGh8s8UEQc4uYd8PuSePO8dkbz5/kY7bjhvUm7lpG0Ew8O9YNj+di8JQ9VP2cxRBt5JpZe0Gndl0viO17wgLjadIE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0zy/b1Y; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627194; x=1740163194;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=kGouo5XDP+/c1NdKS2yBopq/rLDDpdyzpRegRLzF9jA=;
  b=Y0zy/b1YVWFQDF7r8c/1YUotaI9XSlAUQEvIpbBObu/4/qrKGZdMvoAS
   UQt4YWNLAnmlsVQO8aX0RR2SgB+PfHbxv6BFcXGKr0DDWwnTy2l68Sla6
   2ptN38bE38zQQQmWfC/wlpkxj/Pzp3eD35zOzDj7rbyfEYlVbiFXVGi2B
   bLhTr1x4vjU71STs0PeLkzsdSZ89bfW4vNcP0AP1FNMgNp8bZmj072neA
   zOfHUi9pxEXS8IK5c/wDGbOFn7UMwGuPm+2DbeUeSNnvd0xz1pOPL2UDn
   AcLIbUz9muiEoMG5M20yA7k/i8JbfOmzR6PXL97Kq7+ScV4KxfJp/Krv/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031838"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031838"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975574"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:53 -0800
Subject: [RFC][PATCH 20/34] x86/cpu: Remove superfluous cache alignment assignments
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:53 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183953.97E25EC4@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Now that the boot CPU's ->x86_cache_alignment is authoritative
and is is consistently established, these other copies only
serve to clobber it needlessly.  Remove them.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/common.c |    2 --
 1 file changed, 2 deletions(-)

diff -puN arch/x86/kernel/cpu/common.c~dup-cache-alignment arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~dup-cache-alignment	2024-02-22 10:08:58.260838084 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:08:58.260838084 -0800
@@ -956,7 +956,6 @@ void cpu_detect(struct cpuinfo_x86 *c)
 		if (cap0 & (1<<19)) {
 			if (c == &boot_cpu_data)
 				c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
-			c->x86_cache_alignment = x86_clflush_size();
 		}
 	}
 }
@@ -1834,7 +1833,6 @@ static void identify_cpu(struct cpuinfo_
 	c->cpuid_level = -1;	/* CPUID not detected */
 	c->x86_clflush_size = 32;
 #endif
-	c->x86_cache_alignment = x86_clflush_size();
 	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
 #ifdef CONFIG_X86_VMX_FEATURE_NAMES
 	memset(&c->vmx_capability, 0, sizeof(c->vmx_capability));
_

