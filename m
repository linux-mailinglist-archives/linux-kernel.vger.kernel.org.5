Return-Path: <linux-kernel+bounces-109249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859BF8816C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB79328275C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9F26A8BA;
	Wed, 20 Mar 2024 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAmFQNll"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CDA4436E;
	Wed, 20 Mar 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956773; cv=none; b=BzPEUqtPuPdK6/7gdHycvQeaJuI7Ykr2/wAY1YlBVA6FqnGnUnDUdth49q8DF4Ox+3fjJVr5xTOlC/07IjjMcBHRgNriB8JPXyC2oV7IqSC5pmbivtXNEeihHva0IdV2iQzG5ypJx+DF2L34zzvm4JfIEfHMHUdxGHkfHkoVaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956773; c=relaxed/simple;
	bh=4tUKS+lrAbbNWp2JU9fdGghW7+U5wKN3OA2hFRyNMmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNQ09pxIcBT4cAtRyPJA45QQOTdvhfH83uaCpRVUbJjKr2oAUR5ppj4fV+BfsLLCqBowXt2IOTtEFMR45ikcc9JD3XYjcOy4uXEvTnkhdDJSmeEMGLTo3Tb1dU5mpCzx7MzAPw1uPz285VMY6xLhqdBL67FTSJXOw/eeI3b52tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAmFQNll; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710956770; x=1742492770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4tUKS+lrAbbNWp2JU9fdGghW7+U5wKN3OA2hFRyNMmI=;
  b=GAmFQNllaZrQmclA0nTO5yLEmWzQRqdJ4DW4fn8Kcv2LVRRAbodwKk4G
   6DX1lQget9UiyMl+orS8Yy4avUx5vrI627p7terxlzImRv0z8jCNj/FhG
   X5yiboTcVVy3hj3urpyHcI8ZtD+7ISvEgKxdeUz3Q9SME1P4RDVYpqyh5
   qAkgLZxyaT64J1cvrX5aMsD5fnWPxy/ZOsifnnnbMbv2tnT2w2e6Ewi+V
   Wuzr4p/5yjE7ycTtrxNm7gRgRBKtDPbJSYDnnvNcb9otTZzOqXRy+DYH+
   rU66QROYmB4pWMlFiN90bLkMPtxpoMgOincndGCUWkwUI2QbSp7jHrgrF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6023981"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="6023981"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 10:46:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="37336134"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.72.188])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 10:46:09 -0700
Date: Wed, 20 Mar 2024 10:46:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Dan Williams <dan.j.williams@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Derick Marks <derick.w.marks@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 1/3] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <Zfsg3wZpSFVT+Zv2@aschofie-mobl2>
References: <20240319120026.2246389-1-rrichter@amd.com>
 <20240319120026.2246389-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319120026.2246389-2-rrichter@amd.com>

On Tue, Mar 19, 2024 at 01:00:23PM +0100, Robert Richter wrote:
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

Hi Richard,

I recall a bit of wrangling w #defines to make ARM64 and LOONGARCH build.
I'm seeing an x86 build error today:

>> arch/x86/mm/numa.c:957:12: error: redefinition of 'numa_fill_memblks'
     957 | int __init numa_fill_memblks(u64 start, u64 end)

include/linux/numa.h:40:26: note: previous definition of 'numa_fill_memblks' with type
+'int(u64,  u64)' {aka 'int(long long unsigned int,  long long unsigned int)'}
      40 | static inline int __init numa_fill_memblks(u64 start, u64 end)
         |                          ^~~~~~~~~~~~~~~~~

In addition to what you suggest, would something like this diff below be
a useful safety measure to distinguish num_fill_memblks() success (rc:0)
and possible non-existence (rc:-1). I don't think it hurts to take a
second look using phys_to_target_node() (totall untested)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 070a52e4daa8..0c48fe32ced4 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -437,9 +437,16 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
         * found for any portion of the window to cover the entire
         * window.
         */
-       if (!numa_fill_memblks(start, end))
+       rc = numa_fill_memblks(start, end);
+       if (!rc)
                return 0;
 
+       if (rc == NUMA_NO_MEMBLK) {
+               node = phys_to_target_node(start);
+               if (node != NUMA_NO_NODE)
+                       return 0;
+       }
+
        /* No SRAT description. Create a new node. */

--Alison

> 
> [1] fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
> 
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> Cc: Derick Marks <derick.w.marks@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  arch/x86/mm/numa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
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

