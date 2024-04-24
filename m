Return-Path: <linux-kernel+bounces-156236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3008B0018
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954EDB23753
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6006A142E6E;
	Wed, 24 Apr 2024 03:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XZdKxFjH"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EE8139CEB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 03:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930514; cv=none; b=SDg3Bshqg4Q86iqezbpdbXb+o2O9pNELvq3s0HzikiS527TzkaEb4CQyABDPwxtol/NAK2ptDT8pPe0pv0o5Jo6AEmU25FOJV7z16F2unTCcSXFZyroxPbXVyzWs88YopLk9Ji7/5+DKtP9P4wm/WyOP6mQz8qSRPbETQ01STBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930514; c=relaxed/simple;
	bh=PVtuPBs5eGsKOVbPHJb9cT/9z2T7nRtaF3A2ljCMW4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrHssoXRJo8lH8LWIIG0z/6z/4vWBX6wMlWlID0M9JTiHKKvWN1fFubPn2kKyrQsQvGcFboc2WcTaOms1JPccaxb91Pv+dVmpvLrUKNBqTY+p1ieW5SzMmBM+ojMW0yMRi3cymDDPqdy3SgRcycHIzAtKyrY2+nQvfQ41g+lMEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XZdKxFjH; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713930508; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=i+3UguXcbzDLCETmEYwCVhpdB29rZwyImQLfXWWDzHk=;
	b=XZdKxFjHn1SsTcDMj04oKltGqSP3EfVbmwcRsw/WndNlFTHaWJo9iDffSvWysjFG4bF/5FiHQYihPDRBo8ZTVIbtIUJq48NVhIhokfONyGTchyCAgq60As2atZtYe1rOi45hC90fsmmMXzOyWTWftKWHEXAv9Nk9+uRVsrqM0bU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W5AlpPR_1713930504;
Received: from 30.97.56.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5AlpPR_1713930504)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 11:48:26 +0800
Message-ID: <8e0a34df-3a02-40a6-a09d-3b4a25ec7fcf@linux.alibaba.com>
Date: Wed, 24 Apr 2024 11:48:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] mm: shmem: add anonymous share mTHP counters
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <05d0096e4ec3e572d1d52d33a31a661321ac1551.1713755580.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4xu4iL5pv7T1chyzGC2Vp9q1GwOp3wxb=bYMW-T-pj4dA@mail.gmail.com>
 <3045341d-06c2-4fdb-88a1-3f0d473f99ee@linux.alibaba.com>
 <5f147c9d-ba00-4757-b88e-38b45fffb8d3@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <5f147c9d-ba00-4757-b88e-38b45fffb8d3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/23 19:39, Ryan Roberts wrote:
> On 23/04/2024 02:46, Baolin Wang wrote:
>>
>>
>> On 2024/4/23 09:17, Barry Song wrote:
>>> On Mon, Apr 22, 2024 at 3:03 PM Baolin Wang
>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>    include/linux/huge_mm.h | 2 ++
>>>>    mm/huge_memory.c        | 4 ++++
>>>>    mm/shmem.c              | 5 ++++-
>>>>    3 files changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index 26b6fa98d8ac..67b9c1acad31 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -270,6 +270,8 @@ enum mthp_stat_item {
>>>>           MTHP_STAT_ANON_SWPOUT,
>>>>           MTHP_STAT_ANON_SWPOUT_FALLBACK,
>>>>           MTHP_STAT_ANON_SWPIN_REFAULT,
>>>> +       MTHP_STAT_SHMEM_ANON_ALLOC,
>>>> +       MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK,
>>>
>>> not quite sure about this. for 2MB pmd-mapped THP shmem, we count them
>>> as FILE_THP.
>>> here we are counting as SHMEM_ANON. To me, SHMEM_ANON is more correct but
>>> it doesn't align with pmd-mapped THP. David, Ryan, what do you think?
>>
>> Thanks for reviewing.
>>
>> IMO, I think both approaches are acceptable, which also reflects the dual nature
>> of anonymous shared pages: on the one hand they are anonymous pages, and on the
>> other hand, they are backed by a pseudo file. From the user's perspective, I
>> prefer to use the term "anonymous shmem", which can be distinguished from the
>> real file-backed THP.
>>
>> Anyway, let's see what others think.
> 
>  From a quick look at the code, it looks like the shmem alloc/fallback/charge
> events are all lumped in with FILE_THP. But the instantaneous "how many are
> allocated" and "how many are mapped" have their own NR_SHMEM_THPS and
> NR_SHMEM_PMDMAPPED counters? So its a bit inconsistent today.
> 
> My preference would be to add these to be consistent with the anon stats:
> 
> MTHP_STAT_SHMEM_FAULT_ALLOC,
> MTHP_STAT_SHMEM_FAULT_FALLBACK,
> MTHP_STAT_SHMEM_FAULT_FALLBACK_CHARGE,
> 
> But it looks like these aren't always allocated due to faults? So perhaps:
> 
> MTHP_STAT_SHMEM_ALLOC,
> MTHP_STAT_SHMEM_FALLBACK,
> MTHP_STAT_SHMEM_FALLBACK_CHARGE,

This looks good to me.

> If I've understood the code correctly (I know nothing about shmem), the
> allocation can be for both mmap(SHARED|ANON) and for tmpfs? So "SHMEM_ANON"

This is allowed, but the 'fd' for tmpfs will be ignored (see 
ksys_mmap_pgoff()), which is same with anonymous shmem.

> probably isn't quite right?
> 
> 
>>
>>>>           __MTHP_STAT_COUNT
>>>>    };
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 9e52c0db7580..dc15240c1ab3 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -557,6 +557,8 @@ DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback,
>>>> MTHP_STAT_ANON_ALLOC_FALLBACK);
>>>>    DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
>>>>    DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
>>>>    DEFINE_MTHP_STAT_ATTR(anon_swpin_refault, MTHP_STAT_ANON_SWPIN_REFAULT);
>>>> +DEFINE_MTHP_STAT_ATTR(shmem_anon_alloc, MTHP_STAT_SHMEM_ANON_ALLOC);
>>>> +DEFINE_MTHP_STAT_ATTR(shmem_anon_alloc_fallback,
>>>> MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK);
>>>>
>>>>    static struct attribute *stats_attrs[] = {
>>>>           &anon_alloc_attr.attr,
>>>> @@ -564,6 +566,8 @@ static struct attribute *stats_attrs[] = {
>>>>           &anon_swpout_attr.attr,
>>>>           &anon_swpout_fallback_attr.attr,
>>>>           &anon_swpin_refault_attr.attr,
>>>> +       &shmem_anon_alloc_attr.attr,
>>>> +       &shmem_anon_alloc_fallback_attr.attr,
>>>>           NULL,
>>>>    };
>>>>
>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>> index 8b009e7040b2..4a0aa75ab29c 100644
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -1706,11 +1706,14 @@ static struct folio *shmem_alloc_and_add_folio(struct
>>>> vm_fault *vmf,
>>>>                           pages = 1 << order;
>>>>                           index = round_down(index, pages);
>>>>                           folio = shmem_alloc_hugefolio(gfp, info, index, order);
>>>> -                       if (folio)
>>>> +                       if (folio) {
>>>> +                               count_mthp_stat(order,
>>>> MTHP_STAT_SHMEM_ANON_ALLOC);
> 
> is there any reason why this can't go next to the existing PMD-size stat?

No, will move to the existing PMD-size stat.

