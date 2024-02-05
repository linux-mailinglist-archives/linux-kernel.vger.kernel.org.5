Return-Path: <linux-kernel+bounces-52266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D0E849612
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF4E2843B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2932A12E6F;
	Mon,  5 Feb 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F8fWMFda"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E29312E5C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124199; cv=none; b=Np4BEHeN2SKZZOMzWGXAH47BqIEyFlW3jzpjj3Uh61Dk5VVtJWF7BFZsQtuVvOy1jIXIJVlD9QmezH/Hc8nKUt5Lwp7h4GyxtaNG34B9quLgIoi/+O3YcUxtjCUlfdumH2t1qxUaUYRJZp9ZMBlPHiv1HIN3lKSt4go4+DOIanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124199; c=relaxed/simple;
	bh=MKFpjqjfYm4un77V+TdHhTxUxZjb3jjcEpEIhy9OMOg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gobQvsMv8IR3wrHrKS3ueUQCnDM5za6R3uf1s+npoJCWRtM7SkdpTbs/LKiIbWBZ8zsI4V609lHkEzGUcyQ5L9QP+tnnquahSsOoQ2rYOsXHNhqXlIlf2yyGQegRWtx2roGhEa7wJAP4h4Mr7r0sDWj+omGHaf4wbyH3Fmdlz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F8fWMFda; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707124194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhxb5dmwj+zBjovPcZizdw/GjpdxEbz8KzJs8VAi2LU=;
	b=F8fWMFdaE00IekCFhGVK7459OpbK1CyWGXZLC/Rg7BQAmW/DCF9tA6ACZaVTqOp77KNkcy
	Yz2JfszubKe2hrWmyefcbVkezQ1V3i8QmwBKosMv63sfU0Zku58u1CByDafiS+kNd5pRfy
	LxPMiCH5osyM5YZ4vg9W/R4Sq2/4XAE=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v5 7/7] hugetlb: parallelize 1G hugetlb initialization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <277e0eed-918f-414f-b19d-219bd155ac14@linux.dev>
Date: Mon, 5 Feb 2024 17:09:15 +0800
Cc: David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 ligang.bdlg@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A148F29-68B2-4365-872C-E6AB599C55F6@linux.dev>
References: <20240126152411.1238072-1-gang.li@linux.dev>
 <20240126152411.1238072-8-gang.li@linux.dev>
 <f8c89a25-e7f2-4f3c-a99a-a1945e18e026@linux.dev>
 <277e0eed-918f-414f-b19d-219bd155ac14@linux.dev>
To: Gang Li <gang.li@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Feb 5, 2024, at 16:26, Gang Li <gang.li@linux.dev> wrote:
>=20
>=20
>=20
> On 2024/2/5 15:28, Muchun Song wrote:
>> On 2024/1/26 23:24, Gang Li wrote:
>>> @@ -3390,8 +3390,6 @@ static void __init =
prep_and_add_bootmem_folios(struct hstate *h,
>>>       /* Send list for bulk vmemmap optimization processing */
>>>       hugetlb_vmemmap_optimize_folios(h, folio_list);
>>> -    /* Add all new pool pages to free lists in one lock cycle */
>>> -    spin_lock_irqsave(&hugetlb_lock, flags);
>>>       list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
>>>           if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
>>>               /*
>>> @@ -3404,23 +3402,27 @@ static void __init =
prep_and_add_bootmem_folios(struct hstate *h,
>>>                       HUGETLB_VMEMMAP_RESERVE_PAGES,
>>>                       pages_per_huge_page(h));
>>>           }
>>> +        /* Subdivide locks to achieve better parallel performance =
*/
>>> +        spin_lock_irqsave(&hugetlb_lock, flags);
>>>           __prep_account_new_huge_page(h, folio_nid(folio));
>>>           enqueue_hugetlb_folio(h, folio);
>>> +        spin_unlock_irqrestore(&hugetlb_lock, flags);
>>>       }
>>> -    spin_unlock_irqrestore(&hugetlb_lock, flags);
>>>   }
>>>   /*
>>>    * Put bootmem huge pages into the standard lists after mem_map is =
up.
>>>    * Note: This only applies to gigantic (order > MAX_PAGE_ORDER) =
pages.
>>>    */
>>> -static void __init gather_bootmem_prealloc(void)
>>> +static void __init gather_bootmem_prealloc_node(unsigned long =
start, unsigned long end, void *arg)
>>> +
>>>   {
>>> +    int nid =3D start;
>> Sorry for so late to notice an issue here. I have seen a comment from
>> PADATA, whcih says:
>>     @max_threads: Max threads to use for the job, actual number may =
be less
>>                   depending on task size and minimum chunk size.
>> PADATA will not guarantee gather_bootmem_prealloc_node() will be =
called
>> ->max_threads times (You have initialized it to the number of NUMA =
nodes in
>> gather_bootmem_prealloc). Therefore, we should add a loop here to =
initialize
>> multiple nodes, namely (@end - @start) here. Otherwise, we will miss
>> initializing some nodes.
>> Thanks.
>>=20
> In padata_do_multithreaded:
>=20
> ```
> /* Ensure at least one thread when size < min_chunk. */
> nworks =3D max(job->size / max(job->min_chunk, job->align), 1ul);
> nworks =3D min(nworks, job->max_threads);
>=20
> ps.nworks      =3D padata_work_alloc_mt(nworks, &ps, &works);
> ```
>=20
> So we have works <=3D max_threads, but >=3D size/min_chunk.

Given a 4-node system, the current implementation will schedule
4 threads to call gather_bootmem_prealloc() respectively, and
there is no problems here. But what if PADATA schedules 2
threads and each thread aims to handle 2 nodes? I think
it is possible for PADATA in the future, because it does not
break any semantics exposed to users. The comment about @min_chunk:

	The minimum chunk size in job-specific units. This
	allows the client to communicate the minimum amount
	of work that's appropriate for one worker thread to
	do at once.

It only defines the minimum chunk size but not maximum size,
so it is possible to let each ->thread_fn handle multiple
minimum chunk size. Right? Therefore, I am not concerned
about the current implementation of PADATA but that of future.

Maybe a separate patch is acceptable since it is an improving
patch instead of a fix one (at least there is no bug currently).

Thanks.


