Return-Path: <linux-kernel+bounces-34679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA478838611
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C911C25142
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26D720F1;
	Tue, 23 Jan 2024 03:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hDdILOnH"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A0A1FAD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705980797; cv=none; b=MuIF7YNy4pO8QtnzsrFmcXqg+uySr1KuaXH4ngW1u8oOV5zGj0TeYKigHOUFg5xt9/9Su/dqTSX+C+rk+k+Xhj3XNBj1iagWoKkEyzYNhGSaHYZOsMjcOChus40bWoHzXcVqjlD7h2cIiD2mREa34vFcA5nf5xgTv3k/uXf5zSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705980797; c=relaxed/simple;
	bh=dY0b4QbqepYoiunrDJoruXQx54evIQWDoFF8FO6Rtd8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GkPltXN/5rQlv+BTexdT5BTG91qzmnYlkEcMnuyoinOBpfbSTLF5YUlqn+rFcx2MOU4Jl3P+od/CsvClxZJF4M9s9+LEuH71iaMuX3+O0ph04Qpja9NL4aAl2l249tOjnUzEn71uppTQ7N7zrAKyRCEPd29aBK3hQWRwLb4+tAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hDdILOnH; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705980793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGyLFiCSPKnOgt2WMLCtOYKgq5Jt8mMSuChCnDpw3sE=;
	b=hDdILOnHa8NAGzybj5naIfs7XhsW6yGVUI0mLp3wSur97OZeZCcTf+GNMtuTZh9YvMngVg
	jH6zVoGsuSW/BEOdpXQ62XSPAsc29ZSZAoayO48d+pFWjEx09xuqfulfmjMrTs6gFDJW82
	zNGhPQjLUXBQ+TnbaAac7FitvyZV7dE=
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
In-Reply-To: <829fb129-f643-4960-a2da-cd38e5ee8f39@linux.dev>
Date: Tue, 23 Jan 2024 11:32:28 +0800
Cc: David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Gang Li <ligang.bdlg@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C79B8BB3-C1F8-4DFA-A084-C4B47486681F@linux.dev>
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-7-gang.li@linux.dev>
 <ddf37da4-4cbc-478a-be9b-3060b0aebc90@linux.dev>
 <14e38e95-2bc6-4571-b502-4e3954b4bcc4@linux.dev>
 <849D7EA4-BCF4-4587-8A78-F3B35B63EAE9@linux.dev>
 <829fb129-f643-4960-a2da-cd38e5ee8f39@linux.dev>
To: Gang Li <gang.li@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Jan 23, 2024, at 10:12, Gang Li <gang.li@linux.dev> wrote:
>=20
> On 2024/1/22 19:30, Muchun Song wrote:
>>> On Jan 22, 2024, at 18:12, Gang Li <gang.li@linux.dev> wrote:
>>>=20
>>> On 2024/1/22 15:10, Muchun Song wrote:> On 2024/1/18 20:39, Gang Li =
wrote:
>>>>> +static void __init hugetlb_alloc_node(unsigned long start, =
unsigned long end, void *arg)
>>>>>   {
>>>>> -    unsigned long i;
>>>>> +    struct hstate *h =3D (struct hstate *)arg;
>>>>> +    int i, num =3D end - start;
>>>>> +    nodemask_t node_alloc_noretry;
>>>>> +    unsigned long flags;
>>>>> +    int next_node =3D 0;
>>>> This should be first_online_node which may be not zero.
>>>=20
>>> That's right. Thanks!
>>>=20
>>>>> -    for (i =3D 0; i < h->max_huge_pages; ++i) {
>>>>> -        if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
>>>>> +    /* Bit mask controlling how hard we retry per-node =
allocations.*/
>>>>> +    nodes_clear(node_alloc_noretry);
>>>>> +
>>>>> +    for (i =3D 0; i < num; ++i) {
>>>>> +        struct folio *folio =3D alloc_pool_huge_folio(h, =
&node_states[N_MEMORY],
>>>>> +                        &node_alloc_noretry, &next_node);
>>>>> +        if (!folio)
>>>>>               break;
>>>>> +        spin_lock_irqsave(&hugetlb_lock, flags);
>>>>> I suspect there will more contention on this lock when =
parallelizing.
>>>=20
>>> In the worst case, there are only 'numa node number' of threads in
>>> contention. And in my testing, it doesn't degrade performance, but
>>> rather improves performance due to the reduced granularity.
>> So, the performance does not change if you move the lock out of
>> loop?
>>=20
>=20
> If we move the lock out of loop, then multi-threading becomes =
single-threading, which definitely reduces performance.

No. I mean batching the pages into pool list just like =
prep_and_add_allocated_folios
does.

>=20
> ```
> +       spin_lock_irqsave(&hugetlb_lock, flags);
>        for (i =3D 0; i < num; ++i) {
>                struct folio *folio =3D alloc_pool_huge_folio(h, =
&node_states[N_MEMORY],
>                                                &node_alloc_noretry, =
&next_node);
>                if (!folio)
>                        break;
> -               spin_lock_irqsave(&hugetlb_lock, flags);
>                __prep_account_new_huge_page(h, folio_nid(folio));
>                enqueue_hugetlb_folio(h, folio);
> -               spin_unlock_irqrestore(&hugetlb_lock, flags);
>                cond_resched();
>        }
> +       spin_unlock_irqrestore(&hugetlb_lock, flags);
> }
> ```



