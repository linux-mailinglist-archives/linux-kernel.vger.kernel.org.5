Return-Path: <linux-kernel+bounces-156530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9638B03F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11BF1C2323F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BE2158852;
	Wed, 24 Apr 2024 08:15:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755E71420DF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946538; cv=none; b=G5rKoaynE9zoGbe1kkJWELoR5ltl2vO0Rpk/0+wdPuNjyk+3yK7ENZjZRZax8EmWBkl6AxWkP6BjdD4KJ5I620Tj3S/RWqjeVS9Ua3z2c7twEhXmYibX7FZXyBtMyvD8WNz6sK6DA7skFuxCEHOyRqO/6/d+cjqaUiWr7jYy4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946538; c=relaxed/simple;
	bh=t6A7FwupU41uLyUWfgUbQndg5gFkN3irKoyrRmKumQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFYA5fgz+HurL8x4P9AsFqMGpBlLazRo+u552GEghbH34qF7WEfwf/juIV/TxNm0GVTZq0+Bat6tWz0idvUvF+y9z+egez53fti04VpTwbsAx8q7udJYiKgGf/2ohILpc45Grkx4LkDfCLKCxU1TGrEx4C8S4pqiBCQONL7KMg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 276DA339;
	Wed, 24 Apr 2024 01:16:03 -0700 (PDT)
Received: from [10.57.74.127] (unknown [10.57.74.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 740D73F64C;
	Wed, 24 Apr 2024 01:15:33 -0700 (PDT)
Message-ID: <5edfe6b3-8f00-46c4-8ddb-d1add845541d@arm.com>
Date: Wed, 24 Apr 2024 09:15:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] mm: shmem: add anonymous share mTHP counters
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 wangkefeng.wang@huawei.com, ying.huang@intel.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <05d0096e4ec3e572d1d52d33a31a661321ac1551.1713755580.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4xu4iL5pv7T1chyzGC2Vp9q1GwOp3wxb=bYMW-T-pj4dA@mail.gmail.com>
 <ce6be451-7c5a-402f-8340-be40699829c2@redhat.com>
 <fb2052ab-74d1-48f7-975b-15abc2a078e2@linux.alibaba.com>
 <140d4efa-28a0-449a-9570-9d44c23b55d1@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <140d4efa-28a0-449a-9570-9d44c23b55d1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/04/2024 08:11, David Hildenbrand wrote:
> On 24.04.24 08:10, Baolin Wang wrote:
>>
>>
>> On 2024/4/23 19:37, David Hildenbrand wrote:
>>> On 23.04.24 03:17, Barry Song wrote:
>>>> On Mon, Apr 22, 2024 at 3:03 PM Baolin Wang
>>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> ---
>>>>>    include/linux/huge_mm.h | 2 ++
>>>>>    mm/huge_memory.c        | 4 ++++
>>>>>    mm/shmem.c              | 5 ++++-
>>>>>    3 files changed, 10 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>> index 26b6fa98d8ac..67b9c1acad31 100644
>>>>> --- a/include/linux/huge_mm.h
>>>>> +++ b/include/linux/huge_mm.h
>>>>> @@ -270,6 +270,8 @@ enum mthp_stat_item {
>>>>>           MTHP_STAT_ANON_SWPOUT,
>>>>>           MTHP_STAT_ANON_SWPOUT_FALLBACK,
>>>>>           MTHP_STAT_ANON_SWPIN_REFAULT,
>>>>> +       MTHP_STAT_SHMEM_ANON_ALLOC,
>>>>> +       MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK,
>>>>
>>>> not quite sure about this. for 2MB pmd-mapped THP shmem, we count them
>>>> as FILE_THP.
>>>> here we are counting as SHMEM_ANON. To me, SHMEM_ANON is more correct but
>>>> it doesn't align with pmd-mapped THP. David, Ryan, what do you think?
>>>
>>> The term "anonymous share" in the patch subject is weird to begin with
>>> ;) Easy to confuse with anonymous cow-shared memory. Let's just call it
>>> "anonymous shmem", which it is under the hood.
>>
>> Sure.
>>
>>> ... regarding the question: if we add FILE_ALLOC and friends, at least
>>> initially, we wouldn't account other large pagecache folios.
>>>
>>> ... likely we should add that then as well so the counter matches the
>>> actual name?
>>>
>>> If we later realize that we need separate FILE vs. SHMEM vs. WHATEVER
>>> counters, we can always add more fine-grained counters later. Doing it
>>> consistently w.r.t. traditional THPs first sounds reasonable.
>>
>> Um, once we expose it to userspace through the sysfs interface, the
>> sysfs interface should be explicit as much as possible and avoid
>> confusing users, otherwise it will be difficult to change this kind of
>> interface in the future. Personally, I prefer to Ryan's suggestion.
> 
> Inconsistency is confusing. As long as you avoid that, I don't particularly care.

This is a good point. We have been careful to make sure the 2M ANON mTHP stats
match the existing PMD-size stats. So we should definitely make sure that any
future 2M FILE mTHP stats match too, which I guess means counting both SHMEM and
FILE events.

So perhaps it makes more sense to add FILE counters to start with. If we need
the SHMEM-specific counters, we could add them later?

I'm happy to go with the crowd on this...

