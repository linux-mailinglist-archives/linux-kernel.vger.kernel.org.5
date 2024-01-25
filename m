Return-Path: <linux-kernel+bounces-37898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777F283B75C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC061C228FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BFE5680;
	Thu, 25 Jan 2024 02:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KS+yS4LU"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52567C40
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706150971; cv=none; b=fFRkXhTL146PowFVJRHHij2o7JEX8hlQ/N7lvAD1VFFfshOXmg/Kw9gpRUCpSmxyoiXACh3zhkG7Xo0ffMRpZfZgi9fmw1L9lO5zxLUAfw9+73cHwgJdblpLa3JS6iR63nJbsZeh9P8UH83z0YkwmwPRKFKXd2ij4rDeWA43d/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706150971; c=relaxed/simple;
	bh=mA84InfAeflycJVNhHYtGCw1ONGe5mPh0fh/2Glz61s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F0pXzHKHUER1UED0emOEn0gAwsbPCJbg80EiQTpkAJSG6pHeTIm0u/8kKCgXksFHZefe4LEk63qyTYIgiPt1yxDOecm1GSv0/IR6JMaBMI5Pl6JbQ0SEiVq+/KPPE2hmIQijkmUI4x3DnzpBNP9W6KRbSVvWsTOMFqUbpAPuy+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KS+yS4LU; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706150966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwsarYtc65ZqJXc3lE3aa+W1phHFbIgO40X0wtYLRo0=;
	b=KS+yS4LUqFCySJno7hRFFp99pES4d6VNrKzI075A0N39NatmyhGGz4OSqkMR3SC3zmtFUS
	YBEAZImygyNrTym6CwOYWq5xMbYQJQYSKvmKyoKfr2WmwsHcFUJQ47KkCE/Hr/KooGQR9F
	+9n3PoyLFWVUxSS8RTOJOldAjdp6sSo=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v4 7/7] hugetlb: parallelize 1G hugetlb initialization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ef5b09e9-8cfb-4e74-89d4-5ebde12361cf@linux.dev>
Date: Thu, 25 Jan 2024 10:48:48 +0800
Cc: Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 ligang.bdlg@bytedance.com,
 David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <15E775EC-8E4B-4145-8931-067DF60E55F1@linux.dev>
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-8-gang.li@linux.dev>
 <da1258e3-f828-4bbc-a2c2-8fe1ef808c9a@linux.dev>
 <ef5b09e9-8cfb-4e74-89d4-5ebde12361cf@linux.dev>
To: Gang Li <gang.li@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Jan 24, 2024, at 18:52, Gang Li <gang.li@linux.dev> wrote:
>=20
> On 2024/1/24 17:23, Muchun Song wrote:
>> On 2024/1/18 20:39, Gang Li wrote:
>>> Optimizing the initialization speed of 1G huge pages through
>>> parallelization.
>>>=20
>>> 1G hugetlbs are allocated from bootmem, a process that is already
>>> very fast and does not currently require optimization. Therefore,
>>> we focus on parallelizing only the initialization phase in
>>> `gather_bootmem_prealloc`.
>>>=20
>>> Here are some test results:
>>>          test          no patch(ms)   patched(ms)   saved
>>>   ------------------- -------------- ------------- --------
>>>    256c2t(4 node) 1G           4745          2024   57.34%
>> What does "256c2t" mean?
>=20
> A machine with 256 core and 2T memory.

A little confusing. I thought 256c2 is a number in hexadecimal.
The unit of memory should be capital T. We should add a simple
explanation about this.

>=20
>>>    128c1t(2 node) 1G           3358          1712   49.02%
>>>        12t        1G          77000         18300   76.23%

I am curious how many NUMA nodes does this system have? I suspect
it should not be one.

>>>=20
>>> Signed-off-by: Gang Li <gang.li@linux.dev>
>>> Tested-by: David Rientjes <rientjes@google.com>
>>> ---
>>>   include/linux/hugetlb.h |  2 +-
>>>   mm/hugetlb.c            | 42 =
+++++++++++++++++++++++++++++++++--------
>>>   2 files changed, 35 insertions(+), 9 deletions(-)
>>>=20
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index c1ee640d87b1..77b30a8c6076 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -178,7 +178,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, =
struct vm_area_struct *vma,
>>>   struct address_space *hugetlb_page_mapping_lock_write(struct page =
*hpage);
>>>   extern int sysctl_hugetlb_shm_group;
>>> -extern struct list_head huge_boot_pages;
>>> +extern struct list_head huge_boot_pages[MAX_NUMNODES];
>>>   /* arch callbacks */
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 9b348ba418f5..2f4b77630ada 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -69,7 +69,7 @@ static bool hugetlb_cma_folio(struct folio *folio, =
unsigned int order)
>>>   #endif
>>>   static unsigned long hugetlb_cma_size __initdata;
>>> -__initdata LIST_HEAD(huge_boot_pages);
>>> +__initdata struct list_head huge_boot_pages[MAX_NUMNODES];
>>>   /* for command line parsing */
>>>   static struct hstate * __initdata parsed_hstate;
>>> @@ -3301,7 +3301,7 @@ int alloc_bootmem_huge_page(struct hstate *h, =
int nid)
>>>   int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>>>   {
>>>       struct huge_bootmem_page *m =3D NULL; /* initialize for clang =
*/
>>> -    int nr_nodes, node;
>>> +    int nr_nodes, node =3D nid;
>> Why not use nid directly in the following list_add()?
>=20
> `node` may be changed in `for_each_node_mask_to_alloc`.

Got it.

>=20
>>>       /* do node specific alloc */
>>>       if (nid !=3D NUMA_NO_NODE) {
>>> @@ -3339,7 +3339,7 @@ int __alloc_bootmem_huge_page(struct hstate =
*h, int nid)
>>>           huge_page_size(h) - PAGE_SIZE);
>>>       /* Put them into a private list first because mem_map is not =
up yet */
>>>       INIT_LIST_HEAD(&m->list);
>>> -    list_add(&m->list, &huge_boot_pages);
>>> +    list_add(&m->list, &huge_boot_pages[node]);
>>>       m->hstate =3D h;
>>>       return 1;
>>>   }
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
>>> +        /* Subdivide locks to achieve better parallel performance *
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
>>> +static void __init __gather_bootmem_prealloc(unsigned long start, =
unsigned long end, void *arg)
>> This function name could be gather_bootmem_prealloc_node.
>=20
> LGTM.
>=20
>>> +
>>>   {
>>> +    int nid =3D start;
>>>       LIST_HEAD(folio_list);
>>>       struct huge_bootmem_page *m;
>>>       struct hstate *h =3D NULL, *prev_h =3D NULL;
>>> -    list_for_each_entry(m, &huge_boot_pages, list) {
>>> +    list_for_each_entry(m, &huge_boot_pages[nid], list) {
>>>           struct page *page =3D virt_to_page(m);
>>>           struct folio *folio =3D (void *)page;
>>> @@ -3453,6 +3455,22 @@ static void __init =
gather_bootmem_prealloc(void)
>>>       prep_and_add_bootmem_folios(h, &folio_list);
>>>   }
>>> +static void __init gather_bootmem_prealloc(void)
>>> +{
>>> +    struct padata_mt_job job =3D {
>>> +        .thread_fn    =3D __gather_bootmem_prealloc,
>>> +        .fn_arg        =3D NULL,
>>> +        .start        =3D 0,
>>> +        .size        =3D num_node_state(N_MEMORY),
>>> +        .align        =3D 1,
>>> +        .min_chunk    =3D 1,
>>> +        .max_threads    =3D num_node_state(N_MEMORY),
>>> +        .numa_aware    =3D true,
>>> +    };
>>> +
>>> +    padata_do_multithreaded(&job);
>>> +}
>>> +
>>>   static void __init hugetlb_hstate_alloc_pages_onenode(struct =
hstate *h, int nid)
>>>   {
>>>       unsigned long i;
>>> @@ -3602,6 +3620,14 @@ static void __init =
hugetlb_hstate_alloc_pages(struct hstate *h)
>>>           return;
>>>       }
>>> +    /* hugetlb_hstate_alloc_pages will be called many times, init =
huge_boot_pages once*/
>> s/init/initialize/g
>> And you miss a black right before "*/".
>=20
> OK
>=20
>>> +    if (huge_boot_pages[0].next =3D=3D NULL) {
>> It it not intuitive. I'd like to use a 'initialied' variable
>=20
> Would it make the code look a bit redundant?

What is redundant?

>=20
>> to indicate whether it has been initialized. BTW, it can be
>> marked as __initdata.
>>=20
>=20
> OK



