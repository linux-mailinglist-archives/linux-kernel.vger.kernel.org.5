Return-Path: <linux-kernel+bounces-156344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BCD8B0191
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F298C284638
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FE7156F2C;
	Wed, 24 Apr 2024 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tbA1ITQ7"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01D156C73
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713939020; cv=none; b=Cf2fEoudKeMpF+Ww2ruj1YKRpZ6u5tPI8nfDjCNDI+Gyxy646wz/RWTJuOFnzCyHFmBWjFALp6P30eiPtRbcH3dG02KmlktllU3tyL+MylQspJv/riVqpQjpptiZGjMfVJX0+2PsHH3BlCFpvKxQj8chL25KVxlinIIBJZFhXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713939020; c=relaxed/simple;
	bh=iepwPMFV2Y8AxOlDOJoQU7DjU3/vVTr6VfAN666ZhBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAIfPg4YSE3qUFnWtFRY84KDOXKsV3TcZkdzlCQgOWvkqZzgSx/MOQZkdbMS/LwfRV+D/Gb/N9oN6uKftaVruVmubikrjEgLq17K11h2dIV/uS8La9zFRUnuGnEubhwYYy34I6I6Xe1z9p2rX94skdy9I3Nex7syhXwFVaJGKgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tbA1ITQ7; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713939012; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UgkEafpjB4FkcGXYRGgNcZe1C+yfzAPApUHISBw8ick=;
	b=tbA1ITQ7JOi4N3i5flMh6w+j1dMDnvZ1WLJNw01aR7lge1LVRC+2dv2ARfCyk1BJXPLT8EiGQSppRtsNCY6kL0CYfbshfojf+6hatBdC4/EcXIzRbed9sTZ+vr/duJN0LxeQotuiAaDLXvTsCkH11awgwAyKXbyjwZuMCfOzcZ0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W5BPSdR_1713939009;
Received: from 30.97.56.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5BPSdR_1713939009)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 14:10:10 +0800
Message-ID: <fb2052ab-74d1-48f7-975b-15abc2a078e2@linux.alibaba.com>
Date: Wed, 24 Apr 2024 14:10:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] mm: shmem: add anonymous share mTHP counters
To: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 wangkefeng.wang@huawei.com, ryan.roberts@arm.com, ying.huang@intel.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <05d0096e4ec3e572d1d52d33a31a661321ac1551.1713755580.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4xu4iL5pv7T1chyzGC2Vp9q1GwOp3wxb=bYMW-T-pj4dA@mail.gmail.com>
 <ce6be451-7c5a-402f-8340-be40699829c2@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ce6be451-7c5a-402f-8340-be40699829c2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/23 19:37, David Hildenbrand wrote:
> On 23.04.24 03:17, Barry Song wrote:
>> On Mon, Apr 22, 2024 at 3:03 PM Baolin Wang
>> <baolin.wang@linux.alibaba.com> wrote:
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>   include/linux/huge_mm.h | 2 ++
>>>   mm/huge_memory.c        | 4 ++++
>>>   mm/shmem.c              | 5 ++++-
>>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 26b6fa98d8ac..67b9c1acad31 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -270,6 +270,8 @@ enum mthp_stat_item {
>>>          MTHP_STAT_ANON_SWPOUT,
>>>          MTHP_STAT_ANON_SWPOUT_FALLBACK,
>>>          MTHP_STAT_ANON_SWPIN_REFAULT,
>>> +       MTHP_STAT_SHMEM_ANON_ALLOC,
>>> +       MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK,
>>
>> not quite sure about this. for 2MB pmd-mapped THP shmem, we count them
>> as FILE_THP.
>> here we are counting as SHMEM_ANON. To me, SHMEM_ANON is more correct but
>> it doesn't align with pmd-mapped THP. David, Ryan, what do you think?
> 
> The term "anonymous share" in the patch subject is weird to begin with 
> ;) Easy to confuse with anonymous cow-shared memory. Let's just call it 
> "anonymous shmem", which it is under the hood.

Sure.

> ... regarding the question: if we add FILE_ALLOC and friends, at least 
> initially, we wouldn't account other large pagecache folios.
> 
> ... likely we should add that then as well so the counter matches the 
> actual name?
> 
> If we later realize that we need separate FILE vs. SHMEM vs. WHATEVER 
> counters, we can always add more fine-grained counters later. Doing it 
> consistently w.r.t. traditional THPs first sounds reasonable.

Um, once we expose it to userspace through the sysfs interface, the 
sysfs interface should be explicit as much as possible and avoid 
confusing users, otherwise it will be difficult to change this kind of 
interface in the future. Personally, I prefer to Ryan's suggestion.

