Return-Path: <linux-kernel+bounces-110564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D568860A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2470286F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3F5133422;
	Thu, 21 Mar 2024 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWMwEaDy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3685CB5;
	Thu, 21 Mar 2024 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046372; cv=none; b=RMhTB5+piAfXx1RxBPZSXw03KPvN6cG4HTE74cFlRgWyVk0hfiLx5D5H2PqyHgoxQ3FQuFOukUnCDnoVnQkP6rVFwEGFdBT9L7G9XOFlsOUSriT6e8ucMP+73NiDSnMZ650PVtKNcodh1Ml0P3ZwYCAGkpURcGwZPdUNlXAEHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046372; c=relaxed/simple;
	bh=MyBfF+y10WG9LmGoiSjakD9H78XK+Zvj33y8tL3TICk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avllwYKmiwiz1YCd6SHjZqFlujMjCdxJBkEidEm/MknNID++rs9sQssuYcB19ikyocscgcwc9c20kbzuYdoTu8grFzTK68TJA5X+8zCegnWLThiyX6e4p9S/6LaOUcr8RyV+osWsGb9qjrSJct6M8BmQayjh4G5YiQva7f9Ms44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWMwEaDy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711046368; x=1742582368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MyBfF+y10WG9LmGoiSjakD9H78XK+Zvj33y8tL3TICk=;
  b=FWMwEaDyP0EdmYxx1eub9+UClqv/uTz6T8nEqFCSl1Yq4OCLo4SxM+y5
   Z2s4NlxIz0z7zO0tX+4lB148lmwiFx2aCR6pGjH302NcdkIIiTfonkh5a
   SDKtogcoKQg3VDj+nQLprn9QA2NRPyeE4ALTuUWvta0yaofxuCoQs+zoI
   6I4rnOK4nIjsh473MLmpf1Q4cEBEerPmlEQVrdg6brZVM/v1pyPabqRDf
   WO+S3Onz5TqCKU4ue6WMlPPK5fUpOLDTd3K1pFVJicJaXs6Yd6hVYgVMI
   Pdka1OhVtBWJnk7Uva6wbZTZcnwaGJVILdZSx5EqY3FI6vejt3H9VCcpe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5957714"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="5957714"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 11:39:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="14521346"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.53.135])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 11:39:19 -0700
Date: Thu, 21 Mar 2024 11:39:17 -0700
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
Message-ID: <Zfx+1c6RVO6r176O@aschofie-mobl2>
References: <20240319120026.2246389-1-rrichter@amd.com>
 <20240319120026.2246389-2-rrichter@amd.com>
 <Zfsg3wZpSFVT+Zv2@aschofie-mobl2>
 <Zfxmnfj1K0OTk89U@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfxmnfj1K0OTk89U@rric.localdomain>

On Thu, Mar 21, 2024 at 05:55:57PM +0100, Robert Richter wrote:
> Alison,
> 
> On 20.03.24 10:46:07, Alison Schofield wrote:
> > On Tue, Mar 19, 2024 at 01:00:23PM +0100, Robert Richter wrote:
> > > For configurations that have the kconfig option NUMA_KEEP_MEMINFO
> > > disabled, the SRAT lookup done with numa_fill_memblks() fails
> > > returning NUMA_NO_MEMBLK (-1). An existing SRAT memory range cannot be
> > > found for a CFMWS address range. This causes the addition of a
> > > duplicate numa_memblk with a different node id and a subsequent page
> > > fault and kernel crash during boot.
> > > 
> > > numa_fill_memblks() is implemented and used in the init section only.
> > > The option NUMA_KEEP_MEMINFO is only for the case when NUMA data will
> > > be used outside of init. So fix the SRAT lookup by moving
> > > numa_fill_memblks() out of the NUMA_KEEP_MEMINFO block to make it
> > > always available in the init section.
> > > 
> > > Note that the issue was initially introduced with [1]. But since
> > > phys_to_target_node() was originally used that returned the valid node
> > > 0, an additional numa_memblk was not added. Though, the node id was
> > > wrong too.
> > 
> > Hi Richard,
> > 
> > I recall a bit of wrangling w #defines to make ARM64 and LOONGARCH build.
> > I'm seeing an x86 build error today:
> > 
> > >> arch/x86/mm/numa.c:957:12: error: redefinition of 'numa_fill_memblks'
> >      957 | int __init numa_fill_memblks(u64 start, u64 end)
> > 
> > include/linux/numa.h:40:26: note: previous definition of 'numa_fill_memblks' with type
> > +'int(u64,  u64)' {aka 'int(long long unsigned int,  long long unsigned int)'}
> >       40 | static inline int __init numa_fill_memblks(u64 start, u64 end)
> >          |                          ^~~~~~~~~~~~~~~~~
> > 
> > In addition to what you suggest, would something like this diff below be
> > a useful safety measure to distinguish num_fill_memblks() success (rc:0)
> > and possible non-existence (rc:-1). I don't think it hurts to take a
> > second look using phys_to_target_node() (totall untested)
> > 
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 070a52e4daa8..0c48fe32ced4 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -437,9 +437,16 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >          * found for any portion of the window to cover the entire
> >          * window.
> >          */
> > -       if (!numa_fill_memblks(start, end))
> > +       rc = numa_fill_memblks(start, end);
> > +       if (!rc)
> >                 return 0;
> >  
> > +       if (rc == NUMA_NO_MEMBLK) {
> > +               node = phys_to_target_node(start);
> > +               if (node != NUMA_NO_NODE)
> > +                       return 0;
> > +       }
> > +
> 
> for non-x86 the numa_add_memblk() function looks good in a way that it
> is able to handle presumable overlapping regions. numa_fill_memblks()
> would just fail then and numa_add_memblk() being called. For x86 we
> need numa_fill_memblks() since x86 specific numa_add_memblk() cannot
> handle the overlapping case.
> 
> That said, we do not need the 2nd check. It looks to me that it
> actually breaks non-x86 as the whole block may not be registered (if
> it is larger than anything existing).
> 
> For x86 the 2nd check may never happen if numa_fill_memblks() is
> always enabled (which is this patch for).

Hi Robert, (<-- got it right this time ;))

I wasn't thinking of x86, but rather archs that may not support
numa_fill_memblks() and return NUMA_NO_MEMBLK (-1) per the 
#ifndef numa_fill_memblks in include/linux/numa.h

In those cases, take a second look at phys_to_targe_node() before
blindly adding another memblk. Is that the failure signature you
reported here?

I can wait and see your final patch and how the different archs
will handle it. I'm worried that NUMA_NO_MEMBLK is overloaded and
we need to diffentiate between archs that don't even look for a 
node, versus archs that look but don't find a node.

--Alison




> 
> So we should be good without your change.
> 
> Thanks,
> 
> -Robert
> 
> >         /* No SRAT description. Create a new node. */
> > 
> > --Alison
> > 
> > > 
> > > [1] fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
> > > 
> > > Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> > > Cc: Derick Marks <derick.w.marks@intel.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Alison Schofield <alison.schofield@intel.com>
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > ---
> > >  arch/x86/mm/numa.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > > index 65e9a6e391c0..ce84ba86e69e 100644
> > > --- a/arch/x86/mm/numa.c
> > > +++ b/arch/x86/mm/numa.c
> > > @@ -929,6 +929,8 @@ int memory_add_physaddr_to_nid(u64 start)
> > >  }
> > >  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> > >  
> > > +#endif
> > > +
> > >  static int __init cmp_memblk(const void *a, const void *b)
> > >  {
> > >  	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> > > @@ -1001,5 +1003,3 @@ int __init numa_fill_memblks(u64 start, u64 end)
> > >  	}
> > >  	return 0;
> > >  }
> > > -
> > > -#endif
> > > -- 
> > > 2.39.2
> > > 

