Return-Path: <linux-kernel+bounces-154011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF25D8AD617
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5FD283A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A901BC58;
	Mon, 22 Apr 2024 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QqX2w+f3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B560F1BC2A;
	Mon, 22 Apr 2024 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818899; cv=none; b=DrGK15qAKXOez+QzW6qoGqqflZ00TxfK9j4492sZFi1eEpx2bgIA0KCFLXhZjyAx47yDEEoKVL+pazlTAvf88kNsOvcTFNVlz4p5SccNv7B55U/5bB9WXRIir0KhL4PdU+cNBDOVzuIZbrgvXpD/CWYdop+C1x96AvM7OE6vtKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818899; c=relaxed/simple;
	bh=Nve2e0URcbhivgmu5Olx+jFaLYTP1uGgib0vU6aow6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuZljaFyQw1aWPEWvMQbCk2V0hOblZEeoRBaT2/2kTNggkMdLfjscaYVkZBGliZgbGiPR8M2QCuHbP/LHKG2AzW9AEMCm3pfaQcqYzO2sY+hmMrmje5EpOSUtd2CCduT8jjvWzGeG2b9zMdQ0uC0fa0ioRbdEb7BiOVFYRNekNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QqX2w+f3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713818898; x=1745354898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nve2e0URcbhivgmu5Olx+jFaLYTP1uGgib0vU6aow6I=;
  b=QqX2w+f32aYXZOaxeUCVbdyN3NbDXkX2Da0YE60qmuIF8G/7Z5Y5b1kI
   PajRHW7OTcVICe6Zp6oac5ZsFL/YXvA9BIbdZZjQi7RbzPjo1cLURQlli
   zS3V7KNMEkzqotYmoxD+UeEhYNu4d6Iqi4l1AW4y/0+j08y1To7fjpgzM
   BbB+RxgPJ857kjb+GUA5Sv7DYWeysl1O3wm5nbbIgY97/9LwoFFO63klb
   BeAYq1PAUROE08T7665e7GtJ54Sxd/TpH8eHFKkqHKUtpIorVRy8WpMcK
   Uj0qD11k2WD/Ny3/zyPS76rwlWDdzZTiT5tsFff4yM7OWdOVmV+9K/4Sm
   A==;
X-CSE-ConnectionGUID: yZC1yBrsSDCyZTe+BhsGgQ==
X-CSE-MsgGUID: ZhnSPWqYTj2RoDWSf0Y+/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="13212106"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="13212106"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:47:21 -0700
X-CSE-ConnectionGUID: wg81OQ8KT867EqJiPcOeGQ==
X-CSE-MsgGUID: Bfxru7XJQtukdQSi9ozkDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="24007380"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.73.120])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:47:20 -0700
Date: Mon, 22 Apr 2024 13:47:18 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Derick Marks <derick.w.marks@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 1/5] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <ZibM1tafKjs674bR@aschofie-mobl2>
References: <20240419140203.1996635-1-rrichter@amd.com>
 <20240419140203.1996635-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419140203.1996635-2-rrichter@amd.com>

On Fri, Apr 19, 2024 at 04:01:59PM +0200, Robert Richter wrote:
> For configurations that have the kconfig option NUMA_KEEP_MEMINFO
> disabled, the SRAT lookup done with numa_fill_memblks() fails
> returning NUMA_NO_MEMBLK (-1). An existing SRAT memory range cannot be
> found for a CFMWS address range. This causes the addition of a
> duplicate numa_memblk with a different node id and a subsequent page
> fault and kernel crash during boot.
> 
> numa_fill_memblks() is implemented and used in the init section only.
> The option NUMA_KEEP_MEMINFO is only for the case when NUMA data will
> be used outside of init. So fix the SRAT lookup by moving
> numa_fill_memblks() out of the NUMA_KEEP_MEMINFO block to make it
> always available in the init section.
> 
> Note that the issue was initially introduced with [1]. But since
> phys_to_target_node() was originally used that returned the valid node
> 0, an additional numa_memblk was not added. Though, the node id was
> wrong too.
> 
> [1] commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
>     CFMWS not in SRAT")
> 
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> Cc: Derick Marks <derick.w.marks@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---

with the assumption that this is passing 0-day builds...

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


>  arch/x86/include/asm/sparsemem.h | 2 +-
>  arch/x86/mm/numa.c               | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
> index 1be13b2dfe8b..1aaa447ef24b 100644
> --- a/arch/x86/include/asm/sparsemem.h
> +++ b/arch/x86/include/asm/sparsemem.h
> @@ -37,9 +37,9 @@ extern int phys_to_target_node(phys_addr_t start);
>  #define phys_to_target_node phys_to_target_node
>  extern int memory_add_physaddr_to_nid(u64 start);
>  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> +#endif
>  extern int numa_fill_memblks(u64 start, u64 end);
>  #define numa_fill_memblks numa_fill_memblks
> -#endif
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_X86_SPARSEMEM_H */
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 65e9a6e391c0..ce84ba86e69e 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -929,6 +929,8 @@ int memory_add_physaddr_to_nid(u64 start)
>  }
>  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
>  
> +#endif
> +
>  static int __init cmp_memblk(const void *a, const void *b)
>  {
>  	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> @@ -1001,5 +1003,3 @@ int __init numa_fill_memblks(u64 start, u64 end)
>  	}
>  	return 0;
>  }
> -
> -#endif
> -- 
> 2.39.2
> 

