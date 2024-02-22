Return-Path: <linux-kernel+bounces-77159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0FF8601C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46970289139
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E036E5F7;
	Thu, 22 Feb 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4S1+zlp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD816AFAA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627175; cv=none; b=Bl83jQofFexjUd+mMP0iZsx8Ls/47PAuXK7lSr4idH0pu8yQZYlwP8+Wn6gdJiNt554hvj19jSjG+bnMgGS8vwq/Wt+6PRzegwxEq5PFpC/E8npTCFh9vnjAvZpxaokZ5L4EmMBpk4aaNZS36buuSo4TUl6QArTQ3WDxcFovuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627175; c=relaxed/simple;
	bh=X3vgXtdWjBUY02JYo3ZQjlayem/luTu4o10k7E40aB4=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=dNYWqd2LqRb+XLiEs+6la4XBil+ehH34lWW+jpJXEGnj8TJTFaJ1p9LypkxAznOjPSozs1U8pel+599cxG7EsFBLkN1uAJUVUayDxv4DtlH8sYZazZviKnIa+GvWGPkJ3+WmVKCft/USXW3zBcdtD3xZodw+4cG2H1OC3eNyDUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4S1+zlp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627174; x=1740163174;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=X3vgXtdWjBUY02JYo3ZQjlayem/luTu4o10k7E40aB4=;
  b=Z4S1+zlpZZOg/0Gv+EfBiTMWjbrP2W7s4zbrNcIQHr/cBPyV9VVocmw4
   Mby7WOVDoz7BqdjV1p7GfjkGgP2Al/hvLSKnCvvAMsNP5xeGEWv7wZgch
   dPl6+W+3HT4LmEtnO2LE0uys2BlYQDnGBrMAjXundvxfz00SSCx1l4TaA
   vpwmodebCuzDJAYZp1JmqLll1Uv4q1V3UWZkUwG6RsHNyzW7hhVeWyzfw
   NepY7uj2WeTz/DFYtveaNAJrQxVIey2zm1VwJPUTmWR3kICssj2PDBqHE
   xFMTtHjNAq0YdHJvj13Y/lE3qG0nKLP6rxh3frSCg3zs95fumjSVI4fmL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031716"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031716"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975409"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:34 -0800
Subject: [RFC][PATCH 05/34] x86/cpu: Move /proc per-cpu ->x86_phys_bits reference to global one
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:33 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183933.953C8BFF@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

This is one of the few references to the per-cpu version of
->x86_phys_bits.  It is theoretically possible to have this value vary
from CPU to CPU.  But in practice nobody builds systems that way.

Continue outputting the value in /proc, but read it from the global
configuration.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/x86/kernel/cpu/proc.c~proc-global-x86-phys-bits arch/x86/kernel/cpu/proc.c
--- a/arch/x86/kernel/cpu/proc.c~proc-global-x86-phys-bits	2024-02-22 10:08:50.584536732 -0800
+++ b/arch/x86/kernel/cpu/proc.c	2024-02-22 10:08:50.584536732 -0800
@@ -133,7 +133,7 @@ static int show_cpuinfo(struct seq_file
 	seq_printf(m, "clflush size\t: %u\n", c->x86_clflush_size);
 	seq_printf(m, "cache_alignment\t: %d\n", c->x86_cache_alignment);
 	seq_printf(m, "address sizes\t: %u bits physical, %u bits virtual\n",
-		   c->x86_phys_bits, c->x86_virt_bits);
+		   x86_phys_bits(), c->x86_virt_bits);
 
 	seq_puts(m, "power management:");
 	for (i = 0; i < 32; i++) {
_

