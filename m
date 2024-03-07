Return-Path: <linux-kernel+bounces-95782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A15875287
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D46285342
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6684812F36F;
	Thu,  7 Mar 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsMrYSfz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BFE12E1DF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823526; cv=none; b=gny0wduf45d7JMOu4E7Ux4TLwhwQ4PSuCYoNRphnBKi7VaBcyw925T9Lr9fr12zxf3vUpzP44WAmJ7WwpOA8OZ0Pd8WYwCTQzteVFZm2/UiNO1xJRxwD5VVhWNkLDzRHvKCL763NPrtd2jxNje2+/e2KKwQ3vlcALW9RbJRsFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823526; c=relaxed/simple;
	bh=bRwkokDS4X5pAkXvoBBZzDn4X9fxWeuq1dmvqw1T8KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5y7y0xxcVi+mD9nvl9hakjVr0wK+oSqQKdHDJv3Y7ryBTiZtqcfvWZ0m2HQWF0Tx/FXQ7fb8JOLYgFlRtNQDaAj974naRR5Nw2y5gNyw6PjFLzba6rXUnDYlDZ0+yVOst39cJ1udJrmRct0zmdQS5KcDAwMpF/9FMst2MeTsIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsMrYSfz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709823523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fftuhXiA4rsEkGB1zq8wXeIHs3V2fXdxTIfwFilKrwE=;
	b=bsMrYSfzCtdCPJUrrs4voEokcTRScN5ZyCs5foul5jVVP+RxE0DtTlCD636u6JIZJcXsTH
	yCtIDtkaRTDT1GcRWJjNShSassf15LlmfA7ylUwgWm9AsK6ImHAoGa+WtlQl7zNUeWGB1D
	vApgDD61IQJ58B3S9iKeu95d9jHttDg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-PAQM_Dv6NoqIRcQfBr9Qrg-1; Thu, 07 Mar 2024 09:58:41 -0500
X-MC-Unique: PAQM_Dv6NoqIRcQfBr9Qrg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33e6fd52037so161596f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709823520; x=1710428320;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fftuhXiA4rsEkGB1zq8wXeIHs3V2fXdxTIfwFilKrwE=;
        b=CYT2T2D21kfVS+N8sMbKlAusg7iOCbXgv+5z62ttP6kUIVhi2RYuQKBubxqfTOwlDk
         LZuAyENONajNC88/bI7nqzV1kgtU0esBNFlw2cGicAPDFnE0xCAKhYKPrYnq905b8zio
         4NqB3q0ewy0r5OwlV3lcTlabshJEOOKUKNDUUCsAfZHWd2rMn5FOWmGLZNGXewLMUV+p
         39vetdXAEfxHgFHpbNvpMz/dNzG0wb83mSbZukNVfFMXb70Ec9L3O3rNCgc4mkTesTdN
         khxZHwKe2DFT72Yp5LD+SIH4OyS8P6HSN7HKGFOm0tEqClsV8utvPuytQMvQoCCRT5fn
         uMXA==
X-Forwarded-Encrypted: i=1; AJvYcCUmxcEKXjFq/ALFSNxk2VPnE9MoEFcycYrVn9J5tm9wQoqDbbfuarTNEZMIdUUtf5QYKnnC2MmGPxJVKS8OhWJ8K/rIZ07IKpfoxYHQ
X-Gm-Message-State: AOJu0Yx8V0hRxd2lM+nem8dU/5KjHFTZ4NeLD1+8NIstWU37D3SLnnAD
	nOGAKuNS1Gts8i7CEWVgtnVsNz6By9NhEiSkZLDH31OfK5sMwe81gmxLYg8vdiMRGki+JO9IjR3
	jeLbm6WHItZP7eWlwHAhe6GDA9qd29/4XAYI7g5bil4z/yPfd6rUW4rAmZRjEmA==
X-Received: by 2002:a05:600c:35d1:b0:412:e56e:b4f5 with SMTP id r17-20020a05600c35d100b00412e56eb4f5mr8234740wmq.8.1709823520532;
        Thu, 07 Mar 2024 06:58:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYffwqZK9owJYaFIVPQBLMZY1HpjcTS8bSLKCxzKRndCOQ8iyE3zEmVFYDCfz5pX9zc22RUA==
X-Received: by 2002:a05:600c:35d1:b0:412:e56e:b4f5 with SMTP id r17-20020a05600c35d100b00412e56eb4f5mr8234717wmq.8.1709823520042;
        Thu, 07 Mar 2024 06:58:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:6400:4867:4ed0:9726:a0c9? (p200300cbc74d640048674ed09726a0c9.dip0.t-ipconnect.de. [2003:cb:c74d:6400:4867:4ed0:9726:a0c9])
        by smtp.gmail.com with ESMTPSA id iv20-20020a05600c549400b0041313d4c852sm648897wmb.19.2024.03.07.06.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 06:58:39 -0800 (PST)
Message-ID: <63801377-2648-4c3b-b534-3cc5835f5cf6@redhat.com>
Date: Thu, 7 Mar 2024 15:58:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-US
To: Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 Vishal Moola <vishal.moola@gmail.com>, akpm@linux-foundation.org,
 zokeefe@google.com, shy828301@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240307061425.21013-1-ioworker0@gmail.com>
 <CAGsJ_4xcRvZGdpPh1qcFTnTnDUbwz6WreQ=L_UO+oU2iFm9EPg@mail.gmail.com>
 <CAK1f24k2G_DSEjuqqqPyY0f7+btpYbjfoyMH7btLfP8nkasCTQ@mail.gmail.com>
 <CAGsJ_4xREM-P1mFqeM-s3-cJ9czb6PXwizb-3hOhwaF6+QM5QA@mail.gmail.com>
 <03458c20-5544-411b-9b8d-b4600a9b802f@arm.com>
 <CAGsJ_4zp1MXTjG=4gBO+J3owg7sHDgDJ8Ut51i1RBSnKnK0BfQ@mail.gmail.com>
 <501c9f77-1459-467a-8619-78e86b46d300@arm.com>
 <8f84c7d6-982a-4933-a7a7-3f640df64991@redhat.com>
 <e6bc142e-113d-4034-b92c-746b951a27ed@redhat.com>
 <d24f8553-33f2-4ae7-a06d-badaf9462d84@arm.com>
 <db46212b-000d-4e8e-87d2-90dbf0a6236a@redhat.com>
 <CAK1f24k8MgR-3sqpqZmg=aTF5Sh4if2o7qeW9zfGpGCSbHR2PA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24k8MgR-3sqpqZmg=aTF5Sh4if2o7qeW9zfGpGCSbHR2PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.03.24 15:41, Lance Yang wrote:
> Hey Barry, Ryan, David,
> 
> Thanks a lot for taking the time to explain and provide suggestions!
> I really appreciate your time!
> 
> IIUC, here's what we need to do for v3:
> 
> If folio_likely_mapped_shared() is true, or if we cannot acquire
> the folio lock, we simply skip the batched PTEs. Then, we compare
> the number of batched PTEs against folio_mapcount(). Finally,
> batch-update the access and dirty only.
> 
> I'm not sure if I've understood correctly, could you please confirm?
> 
> Thanks,
> Lance
> 
> On Thu, Mar 7, 2024 at 7:17 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 07.03.24 12:13, Ryan Roberts wrote:
>>> On 07/03/2024 10:54, David Hildenbrand wrote:
>>>> On 07.03.24 11:54, David Hildenbrand wrote:
>>>>> On 07.03.24 11:50, Ryan Roberts wrote:
>>>>>> On 07/03/2024 09:33, Barry Song wrote:
>>>>>>> On Thu, Mar 7, 2024 at 10:07 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>>
>>>>>>>> On 07/03/2024 08:10, Barry Song wrote:
>>>>>>>>> On Thu, Mar 7, 2024 at 9:00 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hey Barry,
>>>>>>>>>>
>>>>>>>>>> Thanks for taking time to review!
>>>>>>>>>>
>>>>>>>>>> On Thu, Mar 7, 2024 at 3:00 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Thu, Mar 7, 2024 at 7:15 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>> [...]
>>>>>>>>>>>> +static inline bool can_mark_large_folio_lazyfree(unsigned long addr,
>>>>>>>>>>>> +                                                struct folio *folio,
>>>>>>>>>>>> pte_t *start_pte)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +       int nr_pages = folio_nr_pages(folio);
>>>>>>>>>>>> +       fpb_t flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>>>>>>>>>>> +
>>>>>>>>>>>> +       for (int i = 0; i < nr_pages; i++)
>>>>>>>>>>>> +               if (page_mapcount(folio_page(folio, i)) != 1)
>>>>>>>>>>>> +                       return false;
>>>>>>>>>>>
>>>>>>>>>>> we have moved to folio_estimated_sharers though it is not precise, so
>>>>>>>>>>> we don't do
>>>>>>>>>>> this check with lots of loops and depending on the subpage's mapcount.
>>>>>>>>>>
>>>>>>>>>> If we don't check the subpage’s mapcount, and there is a cow folio
>>>>>>>>>> associated
>>>>>>>>>> with this folio and the cow folio has smaller size than this folio,
>>>>>>>>>> should we still
>>>>>>>>>> mark this folio as lazyfree?
>>>>>>>>>
>>>>>>>>> I agree, this is true. However, we've somehow accepted the fact that
>>>>>>>>> folio_likely_mapped_shared
>>>>>>>>> can result in false negatives or false positives to balance the
>>>>>>>>> overhead.  So I really don't know :-)
>>>>>>>>>
>>>>>>>>> Maybe David and Vishal can give some comments here.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> BTW, do we need to rebase our work against David's changes[1]?
>>>>>>>>>>> [1]
>>>>>>>>>>> https://lore.kernel.org/linux-mm/20240227201548.857831-1-david@redhat.com/
>>>>>>>>>>
>>>>>>>>>> Yes, we should rebase our work against David’s changes.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> +
>>>>>>>>>>>> +       return nr_pages == folio_pte_batch(folio, addr, start_pte,
>>>>>>>>>>>> +                                        ptep_get(start_pte), nr_pages,
>>>>>>>>>>>> flags, NULL);
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>>      static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>>>>>>>>>>>                                     unsigned long end, struct mm_walk *walk)
>>>>>>>>>>>>
>>>>>>>>>>>> @@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd_t *pmd,
>>>>>>>>>>>> unsigned long addr,
>>>>>>>>>>>>                      */
>>>>>>>>>>>>                     if (folio_test_large(folio)) {
>>>>>>>>>>>>                             int err;
>>>>>>>>>>>> +                       unsigned long next_addr, align;
>>>>>>>>>>>>
>>>>>>>>>>>> -                       if (folio_estimated_sharers(folio) != 1)
>>>>>>>>>>>> -                               break;
>>>>>>>>>>>> -                       if (!folio_trylock(folio))
>>>>>>>>>>>> -                               break;
>>>>>>>>>>>> +                       if (folio_estimated_sharers(folio) != 1 ||
>>>>>>>>>>>> +                           !folio_trylock(folio))
>>>>>>>>>>>> +                               goto skip_large_folio;
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I don't think we can skip all the PTEs for nr_pages, as some of them
>>>>>>>>>>> might be
>>>>>>>>>>> pointing to other folios.
>>>>>>>>>>>
>>>>>>>>>>> for example, for a large folio with 16PTEs, you do MADV_DONTNEED(15-16),
>>>>>>>>>>> and write the memory of PTE15 and PTE16, you get page faults, thus PTE15
>>>>>>>>>>> and PTE16 will point to two different small folios. We can only skip
>>>>>>>>>>> when we
>>>>>>>>>>> are sure nr_pages == folio_pte_batch() is sure.
>>>>>>>>>>
>>>>>>>>>> Agreed. Thanks for pointing that out.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> +
>>>>>>>>>>>> +                       align = folio_nr_pages(folio) * PAGE_SIZE;
>>>>>>>>>>>> +                       next_addr = ALIGN_DOWN(addr + align, align);
>>>>>>>>>>>> +
>>>>>>>>>>>> +                       /*
>>>>>>>>>>>> +                        * If we mark only the subpages as lazyfree, or
>>>>>>>>>>>> +                        * cannot mark the entire large folio as lazyfree,
>>>>>>>>>>>> +                        * then just split it.
>>>>>>>>>>>> +                        */
>>>>>>>>>>>> +                       if (next_addr > end || next_addr - addr !=
>>>>>>>>>>>> align ||
>>>>>>>>>>>> +                           !can_mark_large_folio_lazyfree(addr, folio,
>>>>>>>>>>>> pte))
>>>>>>>>>>>> +                               goto split_large_folio;
>>>>>>>>>>>> +
>>>>>>>>>>>> +                       /*
>>>>>>>>>>>> +                        * Avoid unnecessary folio splitting if the large
>>>>>>>>>>>> +                        * folio is entirely within the given range.
>>>>>>>>>>>> +                        */
>>>>>>>>>>>> +                       folio_clear_dirty(folio);
>>>>>>>>>>>> +                       folio_unlock(folio);
>>>>>>>>>>>> +                       for (; addr != next_addr; pte++, addr +=
>>>>>>>>>>>> PAGE_SIZE) {
>>>>>>>>>>>> +                               ptent = ptep_get(pte);
>>>>>>>>>>>> +                               if (pte_young(ptent) ||
>>>>>>>>>>>> pte_dirty(ptent)) {
>>>>>>>>>>>> +                                       ptent = ptep_get_and_clear_full(
>>>>>>>>>>>> +                                               mm, addr, pte,
>>>>>>>>>>>> tlb->fullmm);
>>>>>>>>>>>> +                                       ptent = pte_mkold(ptent);
>>>>>>>>>>>> +                                       ptent = pte_mkclean(ptent);
>>>>>>>>>>>> +                                       set_pte_at(mm, addr, pte, ptent);
>>>>>>>>>>>> +                                       tlb_remove_tlb_entry(tlb, pte,
>>>>>>>>>>>> addr);
>>>>>>>>>>>> +                               }
>>>>>>>>>>>
>>>>>>>>>>> Can we do this in batches? for a CONT-PTE mapped large folio, you are
>>>>>>>>>>> unfolding
>>>>>>>>>>> and folding again. It seems quite expensive.
>>>>>>>>
>>>>>>>> I'm not convinced we should be doing this in batches. We want the initial
>>>>>>>> folio_pte_batch() to be as loose as possible regarding permissions so that we
>>>>>>>> reduce our chances of splitting folios to the min. (e.g. ignore SW bits like
>>>>>>>> soft dirty, etc). I think it might be possible that some PTEs are RO and other
>>>>>>>> RW too (e.g. due to cow - although with the current cow impl, probably not.
>>>>>>>> But
>>>>>>>> its fragile to assume that). Anyway, if we do an initial batch that ignores
>>>>>>>> all
>>>>>>>
>>>>>>> You are correct. I believe this scenario could indeed occur. For instance,
>>>>>>> if process A forks process B and then unmaps itself, leaving B as the
>>>>>>> sole process owning the large folio.  The current wp_page_reuse() function
>>>>>>> will reuse PTE one by one while the specific subpage is written.
>>>>>>
>>>>>> Hmm - I thought it would only reuse if the total mapcount for the folio was 1.
>>>>>> And since it is a large folio with each page mapped once in proc B, I thought
>>>>>> every subpage write would cause a copy except the last one? I haven't looked at
>>>>>> the code for a while. But I had it in my head that this is an area we need to
>>>>>> improve for mTHP.
>>>>>
>>>>> wp_page_reuse() will currently reuse a PTE part of a large folio only if
>>>>> a single PTE remains mapped (refcount == 0).
>>>>
>>>> ^ == 1
>>>
>>> Ahh yes. That's what I meant. I got the behacviour vagulely right though.
>>>
>>> Anyway, regardless, I'm not sure we want to batch here. Or if we do, we want to
>>> batch function that will only clear access and dirty.
>>
>> We likely want to detect a folio batch the "usual" way (as relaxed as
>> possible), then do all the checks (#pte == folio_mapcount() under folio
>> lock), and finally batch-update the access and dirty only.

Something like:

1) We might want to factor out the existing single-pte case and extend 
it to handle multiple PTEs (nr_pages). For the existing code, we would 
pass in "nr_pages".

For example, instead of "folio_mapcount(folio) != 1" you'd check 
"folio_mapcount(folio) != nr_pages" in there. And we'd need functions to 
abstract working on multiple ptes.

2) We'd add something like wrprotect_ptes(), that does the mkold+clean 
on multiple PTEs.

Naming suggestion for such a function requested :)

3) Then, we might want to extend folio_pte_batch() by an *any_young and 
*any_dirty parameter that will get optimized out for other users. So you 
get that information right when scanning.


Just a rough idea, devil is in the detail. But likely trying to abstrct 
the code to handle "multiple pages of the same folio" should come just 
naturally like we used to do for fork() and munmap() so far.

-- 
Cheers,

David / dhildenb


