Return-Path: <linux-kernel+bounces-154404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713C48ADBAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E91A1C213CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7814292;
	Tue, 23 Apr 2024 01:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M4gCv/fz"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97286134C6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713836785; cv=none; b=EI6qVG+igEJPrbMIvaxXvZOe+nOG3xny5elJL8amP6r/kCOsla7gnRBcgaooho9EVrQ2k1X/wHoFqOv7872LeJsU8FiM69/Fr9d/rf3wFLoKqTrsfAeJXqBnpaz5jNk5Gx8leQ2/FqI8vq3Itcfyexrgt9NwY59/r8LDGfYcQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713836785; c=relaxed/simple;
	bh=BxB6dlVnYbWLoAq4KIPxLPfXIZvvx72U5vyiZG2qEkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXvK6fAlZ0EhV7SILDjQhLcqqdOTvE2FUQ2nhGvfRX/pv36+ZFyuoC+GQB/kc2d5jNIt0PgWN835dpbobLN2BS/DghQWlPDn6DQl5CsV/b1UkuNwBt/NVH1v26FYH01zYFsrJ3Dv5+Qyzo7lLFWDNc9/+P/vKJ1hC6CClTXwYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M4gCv/fz; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713836780; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nbp8Po9QugxndSl6Xnhz2pUHpg0EmUfrKyhVksct1oM=;
	b=M4gCv/fzcRSOt5kCQmBCZjZ0UuMipGOgoZKKh7oCUmm0WaBZ1T3KQFXrUSrLUrv8bM922Z484F/Tr2KJzeFReCLmRgeZHCLJhWroGRdihoO2vjOaSiQRGcMyajz4JQxMBX/EkYZFh+0uoH8EYQPfLMaKJ23jJScsbRwJUGBUwDc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W570E4y_1713836777;
Received: from 30.97.56.65(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W570E4y_1713836777)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 09:46:18 +0800
Message-ID: <3045341d-06c2-4fdb-88a1-3f0d473f99ee@linux.alibaba.com>
Date: Tue, 23 Apr 2024 09:46:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] mm: shmem: add anonymous share mTHP counters
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, ryan.roberts@arm.com,
 ying.huang@intel.com, shy828301@gmail.com, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <05d0096e4ec3e572d1d52d33a31a661321ac1551.1713755580.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4xu4iL5pv7T1chyzGC2Vp9q1GwOp3wxb=bYMW-T-pj4dA@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4xu4iL5pv7T1chyzGC2Vp9q1GwOp3wxb=bYMW-T-pj4dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/23 09:17, Barry Song wrote:
> On Mon, Apr 22, 2024 at 3:03 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   include/linux/huge_mm.h | 2 ++
>>   mm/huge_memory.c        | 4 ++++
>>   mm/shmem.c              | 5 ++++-
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 26b6fa98d8ac..67b9c1acad31 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -270,6 +270,8 @@ enum mthp_stat_item {
>>          MTHP_STAT_ANON_SWPOUT,
>>          MTHP_STAT_ANON_SWPOUT_FALLBACK,
>>          MTHP_STAT_ANON_SWPIN_REFAULT,
>> +       MTHP_STAT_SHMEM_ANON_ALLOC,
>> +       MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK,
> 
> not quite sure about this. for 2MB pmd-mapped THP shmem, we count them
> as FILE_THP.
> here we are counting as SHMEM_ANON. To me, SHMEM_ANON is more correct but
> it doesn't align with pmd-mapped THP. David, Ryan, what do you think?

Thanks for reviewing.

IMO, I think both approaches are acceptable, which also reflects the 
dual nature of anonymous shared pages: on the one hand they are 
anonymous pages, and on the other hand, they are backed by a pseudo 
file. From the user's perspective, I prefer to use the term "anonymous 
shmem", which can be distinguished from the real file-backed THP.

Anyway, let's see what others think.

>>          __MTHP_STAT_COUNT
>>   };
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 9e52c0db7580..dc15240c1ab3 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -557,6 +557,8 @@ DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBACK);
>>   DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
>>   DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
>>   DEFINE_MTHP_STAT_ATTR(anon_swpin_refault, MTHP_STAT_ANON_SWPIN_REFAULT);
>> +DEFINE_MTHP_STAT_ATTR(shmem_anon_alloc, MTHP_STAT_SHMEM_ANON_ALLOC);
>> +DEFINE_MTHP_STAT_ATTR(shmem_anon_alloc_fallback, MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK);
>>
>>   static struct attribute *stats_attrs[] = {
>>          &anon_alloc_attr.attr,
>> @@ -564,6 +566,8 @@ static struct attribute *stats_attrs[] = {
>>          &anon_swpout_attr.attr,
>>          &anon_swpout_fallback_attr.attr,
>>          &anon_swpin_refault_attr.attr,
>> +       &shmem_anon_alloc_attr.attr,
>> +       &shmem_anon_alloc_fallback_attr.attr,
>>          NULL,
>>   };
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 8b009e7040b2..4a0aa75ab29c 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1706,11 +1706,14 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>>                          pages = 1 << order;
>>                          index = round_down(index, pages);
>>                          folio = shmem_alloc_hugefolio(gfp, info, index, order);
>> -                       if (folio)
>> +                       if (folio) {
>> +                               count_mthp_stat(order, MTHP_STAT_SHMEM_ANON_ALLOC);
>>                                  goto allocated;
>> +                       }
>>
>>                          if (pages == HPAGE_PMD_NR)
>>                                  count_vm_event(THP_FILE_FALLBACK);
>> +                       count_mthp_stat(order, MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK);
>>                          order = next_order(&orders, order);
>>                  }
>>          } else {
>> --
>> 2.39.3
>>
> 
> Thanks
> Barry

