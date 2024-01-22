Return-Path: <linux-kernel+bounces-32931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59C8836216
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBB41C250A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC08481DD;
	Mon, 22 Jan 2024 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PMEggpjE"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7BE46425
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923088; cv=none; b=hEcdnQDD8lbOOiT7GOMGcXkY6Qb4v6VJLGYrLIA1CiN8JXQQq5VA85mFfDQzk9/mTCjfifBHBuR1srXnl/wRnX/oPkGS+8rdLEklyjivt0qmvdSPdu6cYOpt7DIVvglaRRBWhPdh25sVSieCcuZ1X0NLB4hWLL2Zdso2xrqkoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923088; c=relaxed/simple;
	bh=a5aWRSqDic3RGuhp7PJTTAFqYVrXgPZUgnQH0v0MQeo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CgWdAGMCa/R9Hz6MjKaEOsZsKkBE0JttFeZDdE2PQoj2ANye+S3oui3mZ7bZxxU9VVIxWzrEDcuJSnsMNSeJCbXNsMkCM97jr5MLVUfG2qrBmsUh1QLwVQ7tsyZS9/u/yQDH0xCCUOZAAQz5i9J/y+EmjpVtjSDSmeQ+//3ZrlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PMEggpjE; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705923083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4RSY4mP4w+4iqUvb0NCuJ+3jjeweVzC37FLV3OpmyE=;
	b=PMEggpjEinAWwbzcD5dsOZTBv+LWhJWHnECOalXLXbkco2R5QUmojHUGekv7iVGWCNdlqJ
	1iokj5dqbZHDfE82iyZcqQ1BH/iID1dNGsBM/Kg6MD+/NJT/7I2kgWfpTiiDj0cViSHQs5
	JgDKLshkJryYN29JnEWUDaj5dkfRdBs=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v4 6/7] hugetlb: parallelize 2M hugetlb allocation and
 initialization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <14e38e95-2bc6-4571-b502-4e3954b4bcc4@linux.dev>
Date: Mon, 22 Jan 2024 19:30:39 +0800
Cc: David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 ligang.bdlg@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <849D7EA4-BCF4-4587-8A78-F3B35B63EAE9@linux.dev>
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-7-gang.li@linux.dev>
 <ddf37da4-4cbc-478a-be9b-3060b0aebc90@linux.dev>
 <14e38e95-2bc6-4571-b502-4e3954b4bcc4@linux.dev>
To: Gang Li <gang.li@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Jan 22, 2024, at 18:12, Gang Li <gang.li@linux.dev> wrote:
>=20
> On 2024/1/22 15:10, Muchun Song wrote:> On 2024/1/18 20:39, Gang Li =
wrote:
>>> +static void __init hugetlb_alloc_node(unsigned long start, unsigned =
long end, void *arg)
>>>   {
>>> -    unsigned long i;
>>> +    struct hstate *h =3D (struct hstate *)arg;
>>> +    int i, num =3D end - start;
>>> +    nodemask_t node_alloc_noretry;
>>> +    unsigned long flags;
>>> +    int next_node =3D 0;
>> This should be first_online_node which may be not zero.
>=20
> That's right. Thanks!
>=20
>>> -    for (i =3D 0; i < h->max_huge_pages; ++i) {
>>> -        if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
>>> +    /* Bit mask controlling how hard we retry per-node =
allocations.*/
>>> +    nodes_clear(node_alloc_noretry);
>>> +
>>> +    for (i =3D 0; i < num; ++i) {
>>> +        struct folio *folio =3D alloc_pool_huge_folio(h, =
&node_states[N_MEMORY],
>>> +                        &node_alloc_noretry, &next_node);
>>> +        if (!folio)
>>>               break;
>>> +        spin_lock_irqsave(&hugetlb_lock, flags);
>> > I suspect there will more contention on this lock when =
parallelizing.
>=20
> In the worst case, there are only 'numa node number' of threads in
> contention. And in my testing, it doesn't degrade performance, but
> rather improves performance due to the reduced granularity.

So, the performance does not change if you move the lock out of
loop?

>=20
>> I want to know why you chose to drop prep_and_add_allocated_folios()
>> call in the original hugetlb_pages_alloc_boot()?
>=20
> Splitting him to parallelize hugetlb_vmemmap_optimize_folios.

Unfortunately, HVO should be enabled before pages go to the pool list.

>=20
>>> +static unsigned long __init hugetlb_pages_alloc_boot(struct hstate =
*h)
>>> +{
>>> +    struct padata_mt_job job =3D {
>>> +        .fn_arg        =3D h,
>>> +        .align        =3D 1,
>>> +        .numa_aware    =3D true
>>> +    };
>>> +
>>> +    job.thread_fn    =3D hugetlb_alloc_node;
>>> +    job.start    =3D 0;
>>> +    job.size    =3D h->max_huge_pages;
>>> +    job.min_chunk    =3D h->max_huge_pages / =
num_node_state(N_MEMORY) / 2;
>>> +    job.max_threads    =3D num_node_state(N_MEMORY) * 2;
>> I am curious the magic number of 2 used in assignments of ->min_chunk
>> and ->max_threads, does it from your experiment? I thinke it should
>> be a comment here.
>=20
> This is tested and I can perform more detailed tests and provide data.
>=20
>> And I am also sceptical about the optimization for a small amount of
>> allocation of hugepages. Given 4 hugepags needed to be allocated on =
UMA
>> system, job.min_chunk will be 2, job.max_threads will be 2. Then, 2
>> workers will be scheduled, however each worker will just allocate 2 =
pages,
>> how much the cost of scheduling? What if allocate 4 pages in single
>> worker? Do you have any numbers on parallelism vs non-parallelism in
>> a small allocation case? If we cannot gain from this case, I think we =
shold
>> assign a reasonable value to ->min_chunk based on experiment.
>> Thanks.
>>=20
>=20
> That's a good suggestion, I'll run some tests and choose the best
> values.
>=20
>=20


