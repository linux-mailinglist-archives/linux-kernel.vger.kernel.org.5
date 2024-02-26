Return-Path: <linux-kernel+bounces-81438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D568675F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304DA28205A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75F67F7F7;
	Mon, 26 Feb 2024 13:04:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B867F7F9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952658; cv=none; b=ZIFtibPnpyb0L8QqD5tEQTaG32XlozMJ0eotgvOsJW029jKGiq6RBWxZl8GGTr8xpDv3QCxsyMSxkBUoiJK36KIN0OWWiu5/P0rSfUnT8wfNGvUYktHWEt9Jp9KBLSMZ/plzEXo8VSVJyZra15qEu8xXkxA/bpw2CC2PVadfiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952658; c=relaxed/simple;
	bh=NLg6QYanoeqzWqGaHoMhjzpszT/KgDkGZ09M4+9jIsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8XSfCA9A4VP239N8uCUh+j/TIZSz17jWmxbgTqZ0O0b6jNGKSG7zHzIpmMgHm/CDrzbQAtM3BojnGO7Ll4Lnbjt1EHAwlQAunvj0zDClSww+uzK1MoxxUz9guJpQ8UlNr5OO2e4APVw1lA2iZCze4gqpEI18zZiHE5iLmwI4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70626DA7;
	Mon, 26 Feb 2024 05:04:54 -0800 (PST)
Received: from [10.57.67.4] (unknown [10.57.67.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 291613F762;
	Mon, 26 Feb 2024 05:04:13 -0800 (PST)
Message-ID: <318be511-06de-423e-8216-af869f27f849@arm.com>
Date: Mon, 26 Feb 2024 13:04:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, David Hildenbrand <david@redhat.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 minchan@kernel.org, peterx@redhat.com, shy828301@gmail.com,
 songmuchun@bytedance.com, wangkefeng.wang@huawei.com, zokeefe@google.com,
 fengwei.yin@intel.com
References: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
 <20240226083714.26187-1-ioworker0@gmail.com>
 <9bcf5141-7376-441e-bbe3-779956ef28b9@redhat.com>
 <CAK1f24mdwjz2J5VmeYSDwb4jMbrXUVCSF_0pOcWSVt1cfa0FhQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAK1f24mdwjz2J5VmeYSDwb4jMbrXUVCSF_0pOcWSVt1cfa0FhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/02/2024 08:55, Lance Yang wrote:
> Hey David,
> 
> Thanks for your suggestion!
> 
> On Mon, Feb 26, 2024 at 4:41 PM David Hildenbrand <david@redhat.com> wrote:
>>
> [...]
>>> On Mon, Feb 26, 2024 at 12:00 PM Barry Song <21cnbao@gmail.com> wrote:
>>> [...]
>>>> On Mon, Feb 26, 2024 at 1:33 AM Lance Yang <ioworker0@gmail.com> wrote:
>>> [...]
> [...]
>>> +static inline bool pte_range_cont_mapped(pte_t *pte, unsigned long nr)
>>> +{
>>> +     pte_t pte_val;
>>> +     unsigned long pfn = pte_pfn(pte);
>>> +     for (int i = 0; i < nr; i++) {
>>> +             pte_val = ptep_get(pte + i);
>>> +             if (pte_none(pte_val) || pte_pfn(pte_val) != (pfn + i))
>>> +                     return false;
>>> +     }
>>> +     return true;
>>> +}
>>
>> I dislike the "cont mapped" terminology.
>>
>> Maybe folio_pte_batch() does what you want?
> 
> folio_pte_batch() is a good choice. Appreciate it!

Agreed, folio_pte_batch() is likely to be widely useful for this change and
others, so suggest exporting it from memory.c and reusing as is if possible.

> 
> Best,
> Lance
> 
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>


