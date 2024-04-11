Return-Path: <linux-kernel+bounces-140574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0378A1657
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30F7B22996
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D220C14D703;
	Thu, 11 Apr 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHuIqJ+U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABB81EB26
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843716; cv=none; b=gIdWtlFKIFII86cAVPfo2Ri/31SsWQg2e0HnqvUfWHF7JVENFowMjYpmhgy11ARBEcnezIw2J1Vd4ZRkwS0XRIf0brNguvkZVuCIEVoHYaakH57HNtzP5mXedjhlfUctVVKQJsb9kAUdH5TNGoGul7YusaicqcG7eLUTARA8E6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843716; c=relaxed/simple;
	bh=FnqCp3oLSzyZRxDlKxUOLxebMPK/bCBJJvh62VIdg64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpYQmmKujB6CNf8q+uyRDzHWezvy9hSd/kg3gz8/K8Dh9/McWh2aFKCEA6CCiouAkOfRh1ZkFvdUxATpuP3Ex23OIO+07G0D90t7G0492vvQCKdg9Auq6vw1kZnmoWjAYnVQCYCbErGAQbyZ2bCx/xLhmXRzeuN+idR1KBZkXcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHuIqJ+U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712843714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q4rQfc9RC+GxIPpSYuDb9Zohke1bO5Mw3DCJlzz/elI=;
	b=FHuIqJ+UQ4+wR/VgAiO/hmm4nSVzlIQdQMOzAgDR+AAfjF3UQa+fgaqHwqZ3lCKp8jd/zM
	10PvG93TUYpg4sLx+fxBrmTJNWFo4u0ve25SIxdDBzqse5ZGBWPbUzlh8Fpy1itkCYE/f7
	NiOV47SL3hJJlWGE2m/P8PT8Die9bf4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-rbRhs3UBOjy7Vsl7QcTlNA-1; Thu, 11 Apr 2024 09:55:12 -0400
X-MC-Unique: rbRhs3UBOjy7Vsl7QcTlNA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-416e58bdc1eso9705885e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712843710; x=1713448510;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q4rQfc9RC+GxIPpSYuDb9Zohke1bO5Mw3DCJlzz/elI=;
        b=Di2s3qIhlNRnu5SDZoRFYPUnY6b5vzZciB3H8DI6nvEhWbjda4DH8AP9RwdWBpwwsz
         SxS/60y3xUgNeuPau2x9mJXR60vWK2cWuL7sc5E6vMRAiks992PLGE6CsaaWerrA9lZX
         o3ZaSoBRpNWiEzCFgymrvpA742yJka/KEOMtauARllQpCbYcgVTxJh33Zih8aKO2g4Ic
         EOrh3Rveo/cDUaw+QB8MW+6957NPwdG5Y6QgShEn4aSbZCRnifYDxWMvnPDYMs2lk4V3
         O58QOLs512ID1E/gY4I62yUISccw/1CHeAFbgDGwIc3o8P4rgX+sHQ3YYBAGKTYsuLya
         XvHQ==
X-Forwarded-Encrypted: i=1; AJvYcCViqFydXLbR0eMSyWNJWZ+sZ7GlvIrliLa8wySKqXpZ43J13oLsIFWGstsLh3Q1DW1eAMMHcAR5C5rcHLw2WE9ki9yL79zpaTC1mxXf
X-Gm-Message-State: AOJu0YxOZl8+Gp84ckmKUkKZcPsvcbLJzbPmaLBYHZHA8Er9ClQJTPzq
	Oemh9ipqj+Hin+dCXv1NcYw+C9FhSqhkyV6NZH+Fz82Bm6PHl0bJxwVxnhG3ywd0x1tgtE00INI
	TJ/m4ok3X8uzpwLl2qXxUZ9d8OSHxwAYrqPBANpiOMb34fQrCSGZHlc6ZqsmSbA==
X-Received: by 2002:a05:600c:350b:b0:414:868d:1cbe with SMTP id h11-20020a05600c350b00b00414868d1cbemr4187125wmq.9.1712843710565;
        Thu, 11 Apr 2024 06:55:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKSDi7X3QL2QbvPpewEeJnlqRvZcaDm1VDyCN6nct1KHFwN7/NczBgJ/46K62jPNhExOpX1g==
X-Received: by 2002:a05:600c:350b:b0:414:868d:1cbe with SMTP id h11-20020a05600c350b00b00414868d1cbemr4187111wmq.9.1712843710113;
        Thu, 11 Apr 2024 06:55:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:4300:430f:1c83:1abc:1d66? (p200300cbc7244300430f1c831abc1d66.dip0.t-ipconnect.de. [2003:cb:c724:4300:430f:1c83:1abc:1d66])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d4312000000b003455e5d2569sm1900594wrq.0.2024.04.11.06.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 06:55:09 -0700 (PDT)
Message-ID: <dfbd9a2e-ad91-4182-80cf-f373a5633e72@redhat.com>
Date: Thu, 11 Apr 2024 15:55:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] mm/madvise: optimize lazyfreeing with mTHP in
 madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240408042437.10951-1-ioworker0@gmail.com>
 <20240408042437.10951-2-ioworker0@gmail.com>
 <38c4add8-53a2-49ca-9f1b-f62c2ee3e764@arm.com>
 <013334d5-62d2-4256-8045-168893a0a0cf@redhat.com>
 <a59496b6-ffdf-40ce-b030-283cc911203e@arm.com>
 <CAK1f24=hf2aBRMF5rSwyBxYa3pf7Cq9Y-wpuJ_HDyRxRrbM8sA@mail.gmail.com>
 <a167a357-e780-4572-a613-ae1166a34538@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a167a357-e780-4572-a613-ae1166a34538@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.04.24 15:51, Ryan Roberts wrote:
> On 11/04/2024 13:23, Lance Yang wrote:
>> On Thu, Apr 11, 2024 at 7:27 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> On 11/04/2024 12:20, David Hildenbrand wrote:
>>>> On 11.04.24 13:11, Ryan Roberts wrote:
>>>>> On 08/04/2024 05:24, Lance Yang wrote:
>>>>>> This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
>>>>>> (Inspired by David Hildenbrand[2]). We aim to avoid unnecessary folio
>>>>>> splitting if the large folio is fully mapped within the target range.
>>>>>>
>>>>>> If a large folio is locked or shared, or if we fail to split it, we just
>>>>>> leave it in place and advance to the next PTE in the range. But note that
>>>>>> the behavior is changed; previously, any failure of this sort would cause
>>>>>> the entire operation to give up. As large folios become more common,
>>>>>> sticking to the old way could result in wasted opportunities.
>>>>>>
>>>>>> On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios of
>>>>>> the same size results in the following runtimes for madvise(MADV_FREE) in
>>>>>> seconds (shorter is better):
>>>>>>
>>>>>> Folio Size |   Old    |   New    | Change
>>>>>> ------------------------------------------
>>>>>>         4KiB | 0.590251 | 0.590259 |    0%
>>>>>>        16KiB | 2.990447 | 0.185655 |  -94%
>>>>>>        32KiB | 2.547831 | 0.104870 |  -95%
>>>>>>        64KiB | 2.457796 | 0.052812 |  -97%
>>>>>>       128KiB | 2.281034 | 0.032777 |  -99%
>>>>>>       256KiB | 2.230387 | 0.017496 |  -99%
>>>>>>       512KiB | 2.189106 | 0.010781 |  -99%
>>>>>>      1024KiB | 2.183949 | 0.007753 |  -99%
>>>>>>      2048KiB | 0.002799 | 0.002804 |    0%
>>>>>>
>>>>>> [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm.com
>>>>>> [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redhat.com
>>>>>>
>>>>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>>>>> ---
>>>>>>    include/linux/pgtable.h |  34 +++++++++
>>>>>>    mm/internal.h           |  12 +++-
>>>>>>    mm/madvise.c            | 149 ++++++++++++++++++++++------------------
>>>>>>    mm/memory.c             |   4 +-
>>>>>>    4 files changed, 129 insertions(+), 70 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>> index 0f4b2faa1d71..4dd442787420 100644
>>>>>> --- a/include/linux/pgtable.h
>>>>>> +++ b/include/linux/pgtable.h
>>>>>> @@ -489,6 +489,40 @@ static inline pte_t ptep_get_and_clear(struct mm_struct
>>>>>> *mm,
>>>>>>    }
>>>>>>    #endif
>>>>>>    +#ifndef mkold_clean_ptes
>>>>>> +/**
>>>>>> + * mkold_clean_ptes - Mark PTEs that map consecutive pages of the same folio
>>>>>> + *        as old and clean.
>>>>>> + * @mm: Address space the pages are mapped into.
>>>>>> + * @addr: Address the first page is mapped at.
>>>>>> + * @ptep: Page table pointer for the first entry.
>>>>>> + * @nr: Number of entries to mark old and clean.
>>>>>> + *
>>>>>> + * May be overridden by the architecture; otherwise, implemented by
>>>>>> + * get_and_clear/modify/set for each pte in the range.
>>>>>> + *
>>>>>> + * Note that PTE bits in the PTE range besides the PFN can differ. For example,
>>>>>> + * some PTEs might be write-protected.
>>>>>> + *
>>>>>> + * Context: The caller holds the page table lock.  The PTEs map consecutive
>>>>>> + * pages that belong to the same folio.  The PTEs are all in the same PMD.
>>>>>> + */
>>>>>> +static inline void mkold_clean_ptes(struct mm_struct *mm, unsigned long addr,
>>>>>> +                    pte_t *ptep, unsigned int nr)
>>>>>
>>
>> Thanks for the suggestions, Ryan, David!
>>
>>>>> Just thinking out loud, I wonder if it would be cleaner to convert mkold_ptes()
>>>>> (which I added as part of swap-out) to something like:
>>
>> Yeah, this is definitely cleaner than before.
>>
>>>>>
>>>>> clear_young_dirty_ptes(struct mm_struct *mm, unsigned long addr,
>>>>>                 pte_t *ptep, unsigned int nr,
>>>>>                 bool clear_young, bool clear_dirty);
>>>>>
>>>>> Then we can use the same function for both use cases and also have the ability
>>>>> to only clear dirty in future if we ever need it. The other advantage is that we
>>>>> only need to plumb a single function down the arm64 arch code. As it currently
>>>>> stands, those 2 functions would be duplicating most of their code.
>>
>> Agreed. It's indeed a good idea to use a single function for both use cases.
>>
>>>>
>>>> Yes. Maybe better use proper __bitwise flags, the compiler should be smart
>>>> enough to optimize either way.
>>
>> Nice. I'll use the __bitwise flags as the input.
>>
>>>
>>> Agreed. I was also thinking perhaps it makes sense to start using output bitwise
>>> flags for folio_pte_batch() since this patch set takes us up to 3 optional bool
>>> pointers for different things. Might be cleaner to have input flags to tell it
>>> what we care about and output flags to highlight those things. I guess the
>>> compiler should be able to optimize in the same way.
>>>
>>
>> Should I start using output bitwise flags for folio_pte_batch() in
>> this patch set?
> 
> I don't think its crucial (yet). I'd leave it as you have done it for now,
> unless David shouts.

Let's do that separately, and investigate if the compiler actually is 
smart enough ... :)

-- 
Cheers,

David / dhildenb


