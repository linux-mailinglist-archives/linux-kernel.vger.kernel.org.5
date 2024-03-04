Return-Path: <linux-kernel+bounces-89966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FD586F853
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762761C208B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6299110F9;
	Mon,  4 Mar 2024 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nB6jyWDz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24561362
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 01:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709517116; cv=none; b=U5t3BKczjCOJuRHcqwCKhg8c0Bezky1Hxp2nWSQX1qTpxcIkE2i2SiFUQffWyPtOm3zU7OIQaDZs7zOvZs+kNT8Un45xq9a5RwSvCsK+SXoWqykCeI2ozi9ClKwdOgASBFXn6H2GsiNRpnXFeS3mfNatdVebR8q43/U2lIdjdtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709517116; c=relaxed/simple;
	bh=BCLPYf9pYMiAg1zSZ7/AMXpacdKq7f33SgpfQANAkY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RxQTbxLWZPnqm3f4FNUGj5i1y57i1SjF462B0qKrXCitUf+s335AtnmvwvuMv+NiEmavkTenXEZFNOtYsNP9V6vFwLRI/9hGbWBSL8B2onMUNucYuxF9aJ+9fnWG/QX3Kjn1D6HI7Ca9+k2FtTk2cTxNF8jCuHhMit55c2V69+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nB6jyWDz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709517115; x=1741053115;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=BCLPYf9pYMiAg1zSZ7/AMXpacdKq7f33SgpfQANAkY0=;
  b=nB6jyWDz6lc287DmByu4nCohA0cUAEM7znGrB2Wn0h9/p1eonMAfmuK4
   F9FQDGBhffiR5Aa66cpn77n/Osf0QY7CD1mV+9YhssD2mKRs1b867VGcy
   xeAfjwWs5UtrP9zc87vt2LUko3Nm59Cfhcv8Kx+n6fERvoDEbb3gCFQgW
   I3LvZX34cBIa8YnUQwQQ4nD5oK12bJIRRuKu5/nZaW/3pVHKhzhcuEUwI
   vtnekKsqw/HR1tattI9ch/giKZwBS3xY6EpWTBplcTgSM5HPUPJWt/T+w
   JuEXGsUMnA+2ee4CeZZJUJclP8coxLQW2ZEhfhxg1b8dV7UeR+2fegxFX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4117144"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4117144"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 17:51:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8773042"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 17:51:49 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Donet Tom <donettom@linux.ibm.com>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Dave Hansen
 <dave.hansen@linux.intel.com>,  Mel Gorman <mgorman@suse.de>,  Ben
 Widawsky <ben.widawsky@intel.com>,  Feng Tang <feng.tang@intel.com>,
  Andrea Arcangeli <aarcange@redhat.com>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Rik van Riel
 <riel@surriel.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Mike Kravetz <mike.kravetz@oracle.com>,  Vlastimil
 Babka <vbabka@suse.cz>,  Dan Williams <dan.j.williams@intel.com>,  Hugh
 Dickins <hughd@google.com>,  Kefeng Wang <wangkefeng.wang@huawei.com>,
  Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/3] mm/mempolicy: Use the already fetched local variable
In-Reply-To: <875xy3ltys.fsf@kernel.org> (Aneesh Kumar K. V.'s message of
	"Sun, 03 Mar 2024 11:47:47 +0530")
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
	<20240218133851.22c22b55460e866a099be5ce@linux-foundation.org>
	<63a0f7c4-3c3f-4097-9a24-d1e3fc7b6030@linux.ibm.com>
	<20240219172130.82a16c1ebecbf8ba86a8987d@linux-foundation.org>
	<21f343fa-84a7-4539-91e2-6fc963dbfb62@kernel.org>
	<87frxnps8w.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<7097ff95-6077-4744-a770-b90d224c0c9b@kernel.org>
	<b599bfe5-1c4d-4750-b0d6-a086e1c8a34c@kernel.org>
	<8734tnppls.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZdRq9EM1mDFXBiiO@tiehlicka> <875xy3ltys.fsf@kernel.org>
Date: Mon, 04 Mar 2024 09:49:54 +0800
Message-ID: <87sf16bwal.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> Michal Hocko <mhocko@suse.com> writes:
>
>> On Tue 20-02-24 15:22:07, Huang, Ying wrote:
>> [...]
>>> This isn't an issue now, because mpol_misplaced() are always called with
>>> PTL held.  And, we can still keep thiscpu local variable.
>>
>> yes, this is the case but it would be better if we made that assumption
>> official by lockdep_assert_held
>>
>
> How about this folded into this patch?
>
> 2 files changed, 12 insertions(+), 4 deletions(-)
> mm/memory.c    |  6 ++++--
> mm/mempolicy.c | 10 ++++++++--
>
> modified   mm/memory.c
> @@ -4879,9 +4879,11 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> -int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
> +int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
>  		      unsigned long addr, int page_nid, int *flags)
>  {
> +	struct vm_area_struct *vma = vmf->vma;
> +
>  	folio_get(folio);
>  
>  	/* Record the current PID acceesing VMA */
> @@ -4893,7 +4895,7 @@ int numa_migrate_prep(struct folio *folio, struct vm_area_struct *vma,
>  		*flags |= TNF_FAULT_LOCAL;
>  	}
>  
> -	return mpol_misplaced(folio, vma, addr);
> +	return mpol_misplaced(folio, vmf, addr);
>  }
>  
>  static vm_fault_t do_numa_page(struct vm_fault *vmf)
> modified   mm/mempolicy.c
> @@ -2495,18 +2495,24 @@ static inline bool mpol_preferred_should_numa_migrate(int exec_node, int folio_n
>   * Return: NUMA_NO_NODE if the page is in a node that is valid for this
>   * policy, or a suitable node ID to allocate a replacement folio from.
>   */
> -int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
> +int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
>  		   unsigned long addr)
>  {
>  	struct mempolicy *pol;
>  	pgoff_t ilx;
>  	struct zoneref *z;
>  	int curnid = folio_nid(folio);
> +	struct vm_area_struct *vma = vmf->vma;
>  	int thiscpu = raw_smp_processor_id();
> -	int thisnid = cpu_to_node(thiscpu);
> +	int thisnid = numa_node_id();
>  	int polnid = NUMA_NO_NODE;
>  	int ret = NUMA_NO_NODE;
>  
> +	/*
> +	 * Make sure ptl is held so that we don't preempt and we
> +	 * have a stable smp processor id
> +	 */
> +	lockdep_assert_held(vmf->ptl);
>  	pol = get_vma_policy(vma, addr, folio_order(folio), &ilx);
>  	if (!(pol->flags & MPOL_F_MOF))
>  		goto out;
>
> [back]
>  

LGTM, Thanks!

--
Best Regards,
Huang, Ying

