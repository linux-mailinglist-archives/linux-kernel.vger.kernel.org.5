Return-Path: <linux-kernel+bounces-91336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66055870FB2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988511C22229
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4257B3D8;
	Mon,  4 Mar 2024 22:02:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9D079DCA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589763; cv=none; b=KD05FI0PoD0OIMNyV+0nKVJq1OO0cBlmJej7vNo3M2ULaV7O8Tp/HUYL0Vk1r+qTmQdLkVovCiyhI/nZBDCyazkFM4vtXjqSYj0wyoF8b4PimAMlP3p3mR/rY8LdEYOjBfnrsgSbWJzV9gxMlFGLFv2RKA5ItaIuzMI15DVEDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589763; c=relaxed/simple;
	bh=yHRiuOxJeocwzxWF/cwYC5tgDXtkYyQV5fYMYDHP9OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gl8UT5uM1Xb1CxBpFrXHHAiME9q9dZou9cJbaneY1NgrFYw+GmfV7t8BYD64TBNj1BPCdMzDokd7CfutT1PB12pX4aCMxqSeqz3U6jCsUXlgeskCYMWhr1mcyHG72sazAmHzXHeyvGZamzoocDA3bY1Q+fQYa/Rzq2x1RylwN3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3AD02F4;
	Mon,  4 Mar 2024 14:03:16 -0800 (PST)
Received: from [10.57.68.92] (unknown [10.57.68.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 923EF3F73F;
	Mon,  4 Mar 2024 14:02:37 -0800 (PST)
Message-ID: <db0e8bed-584a-4b42-a5fc-5b20dfa3897c@arm.com>
Date: Mon, 4 Mar 2024 22:02:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org,
 yuzhao@google.com, hanchuanhua@oppo.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, ying.huang@intel.com, xiang@kernel.org,
 mhocko@suse.com, shy828301@gmail.com, wangkefeng.wang@huawei.com,
 Barry Song <v-songbaohua@oppo.com>, Hugh Dickins <hughd@google.com>
References: <20240304103757.235352-1-21cnbao@gmail.com>
 <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
 <37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com>
 <CAGsJ_4yJ3yCyN_KgBO8W+jFx8RN6_JhS9OwX3FH6X_gpU7g62w@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4yJ3yCyN_KgBO8W+jFx8RN6_JhS9OwX3FH6X_gpU7g62w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/03/2024 21:04, Barry Song wrote:
> On Tue, Mar 5, 2024 at 1:41 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 04.03.24 13:20, Ryan Roberts wrote:
>>> Hi Barry,
>>>
>>> On 04/03/2024 10:37, Barry Song wrote:
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> page_vma_mapped_walk() within try_to_unmap_one() races with other
>>>> PTEs modification such as break-before-make, while iterating PTEs
>>>> of a large folio, it will only begin to acquire PTL after it gets
>>>> a valid(present) PTE. break-before-make intermediately sets PTEs
>>>> to pte_none. Thus, a large folio's PTEs might be partially skipped
>>>> in try_to_unmap_one().
>>>
>>> I just want to check my understanding here - I think the problem occurs for
>>> PTE-mapped, PMD-sized folios as well as smaller-than-PMD-size large folios? Now
>>> that I've had a look at the code and have a better understanding, I think that
>>> must be the case? And therefore this problem exists independently of my work to
>>> support swap-out of mTHP? (From your previous report I was under the impression
>>> that it only affected mTHP).
>>>
>>> Its just that the problem is becoming more pronounced because with mTHP,
>>> PTE-mapped large folios are much more common?
>>
>> That is my understanding.
>>
>>>
>>>> For example, for an anon folio, after try_to_unmap_one(), we may
>>>> have PTE0 present, while PTE1 ~ PTE(nr_pages - 1) are swap entries.
>>>> So folio will be still mapped, the folio fails to be reclaimed.
>>>> What’s even more worrying is, its PTEs are no longer in a unified
>>>> state. This might lead to accident folio_split() afterwards. And
>>>> since a part of PTEs are now swap entries, accessing them will
>>>> incur page fault - do_swap_page.
>>>> It creates both anxiety and more expense. While we can't avoid
>>>> userspace's unmap to break up unified PTEs such as CONT-PTE for
>>>> a large folio, we can indeed keep away from kernel's breaking up
>>>> them due to its code design.
>>>> This patch is holding PTL from PTE0, thus, the folio will either
>>>> be entirely reclaimed or entirely kept. On the other hand, this
>>>> approach doesn't increase PTL contention. Even w/o the patch,
>>>> page_vma_mapped_walk() will always get PTL after it sometimes
>>>> skips one or two PTEs because intermediate break-before-makes
>>>> are short, according to test. Of course, even w/o this patch,
>>>> the vast majority of try_to_unmap_one still can get PTL from
>>>> PTE0. This patch makes the number 100%.
>>>> The other option is that we can give up in try_to_unmap_one
>>>> once we find PTE0 is not the first entry we get PTL, we call
>>>> page_vma_mapped_walk_done() to end the iteration at this case.
>>>> This will keep the unified PTEs while the folio isn't reclaimed.
>>>> The result is quite similar with small folios with one PTE -
>>>> either entirely reclaimed or entirely kept.
>>>> Reclaiming large folios by holding PTL from PTE0 seems a better
>>>> option comparing to giving up after detecting PTL begins from
>>>> non-PTE0.
>>>>
>>
>> I'm sure that wall of text can be formatted in a better way :) . Also, I
>> think we can drop some of the details,
>>
>> If you need some inspiration, I can give it a shot.
>>
>>>> Cc: Hugh Dickins <hughd@google.com>
>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>
>>> Do we need a Fixes tag?

It seems my original question has snowballed a bit. I was conflating this change
with other reports Barry has made where the kernel was panicking (I think?).
Given we are not seeing any incorrect functional behaviour that this change
fixes, I agree we don't need a Fixes tag here.


