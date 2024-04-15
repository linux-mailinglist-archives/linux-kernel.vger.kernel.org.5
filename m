Return-Path: <linux-kernel+bounces-145476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BCB8A56A7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CFA1C2194B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311B779B99;
	Mon, 15 Apr 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPWwpNWg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCDD76046
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195652; cv=none; b=lMHG9C0l+0MeDY85rOvQHhHioVEh+KSahSWOmANmOULBbvlRNdCKXXCaSmOcTB07sGo7DiaGBYbvgp4H1MlqMOf6FUEszp7qr3ixCjDavpLxyAFii6R6IdBFTY1VIFoY+aqDoX3a35nn7fIT4f54JGQod8TnLwOfQMWUVFmsGQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195652; c=relaxed/simple;
	bh=L6Gez7CxEDlyOU9QqscpmIdIPzj7z+iAbmHKl3EfHRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJHt1TjACSJW+9vSeqZjX5yOKKveoM+6YUdEgX1W1TFdq28cFYqiahVFkH9hYMsGXA9WdlCrWZBl0U1FVuJQft9bsh/sv+i77CgUhTV1JAByc79Y8miBTC94xAVU4xC/s9Tk6x7hVLIGLuP7ci9JnMv825+nrAweVkuT5GX1ygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPWwpNWg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713195647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ntJhwg/SSS9hu2Q3dPswHvoSiul2gBFf+8KKqKAPnWQ=;
	b=WPWwpNWgTZdaIkMS/n0n9g7Hlzpc2ECPqWNg75fRiPOdTBQhnj8Xd6Yhpcp37KkDbZSpmZ
	KXSFSKMx45LyWD9MSb7oTGwcFNcQFodXrlLNJwz66hFVEl0zMQB8rSxSLr9ZWLPeTCafcJ
	AEDgM8ouLec04O/LjFBRZiYpQ6ZkMo8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-c8anE1FKP_qumymQKiFbJw-1; Mon, 15 Apr 2024 11:40:46 -0400
X-MC-Unique: c8anE1FKP_qumymQKiFbJw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-416aea853e3so12121605e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713195645; x=1713800445;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ntJhwg/SSS9hu2Q3dPswHvoSiul2gBFf+8KKqKAPnWQ=;
        b=w1cCE8LNiPWh4pJfWBSpkJ9epTl3U/9kLq8wgOrOATZXPAVxh32QipjPStDO2SBTay
         GQfCLiHbol6R+v0fxNJ7E6cM6ZsyUi3RHFwVhACBQBprxx0BH9/0W1UOoX0nxEB7cK0v
         qWXx7/x5dD/Xprlo9oQWxG/OuWc1ELrNg4FHQBsA+iZ2+tghSSWHx+2yLW0y2PHwENZ7
         EaNYGTlXjCKNtOpZuea6DkMIAnBeZmIys83hCB2dgsNaKlmVcjQe2biVGp1B0m+kS1pr
         xgfTLSYA68CogkdykI9Q+oV1qxZIzEobM3ND/n28l+ehJBCJInKaghpQ2Uy3W0AHNWX3
         3wPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYqOQATp5AuAHaLcyeCxYwyu+OkTByrarnBob0eE8taRtd2p3U18RQHp1zwZH7PKc9oVixKQnxx6LWOHt/g48DGoFSjkqBhCYQ98/a
X-Gm-Message-State: AOJu0YyCk72g0sZCDJy2MiXU/CHiu1MKB9DWoTgWQoILSzkUMcmUcxKu
	1VcPPPd7EdzHR/YBh5NTaKc5WcPNv7qkG6CoVLYpIo28LgRMzMrEwEGSDTJRRZanMQnvr5Qs8X1
	iE+94+UowA4YeabQTPjZlPaEhuMMtC4FnUHHlGWxWo/TXlAfOUC0X6b7g3dIN+g==
X-Received: by 2002:a05:600c:314c:b0:417:e4ad:d809 with SMTP id h12-20020a05600c314c00b00417e4add809mr7124075wmo.25.1713195644810;
        Mon, 15 Apr 2024 08:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYpuxWeOJFNO+X6LBXeZns8qa31H5PqGOemV0QKwJMTQfL/Gcn2rBh9A+ZRyNa5xZkYhxfGA==
X-Received: by 2002:a05:600c:314c:b0:417:e4ad:d809 with SMTP id h12-20020a05600c314c00b00417e4add809mr7124060wmo.25.1713195644390;
        Mon, 15 Apr 2024 08:40:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:d800:568a:6ea7:5272:797c? (p200300cbc706d800568a6ea75272797c.dip0.t-ipconnect.de. [2003:cb:c706:d800:568a:6ea7:5272:797c])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c310d00b004185d1a4512sm4923790wmo.13.2024.04.15.08.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:40:44 -0700 (PDT)
Message-ID: <60049ec1-df14-4c3f-b3dd-5d771c2ceac4@redhat.com>
Date: Mon, 15 Apr 2024 17:40:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
References: <20240411153232.169560-1-zi.yan@sent.com>
 <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <2C698A64-268C-4E43-9EDE-6238B656A391@nvidia.com>
 <bc8effda-6ff4-458d-a3ee-0d6f25cd41e0@redhat.com>
 <BBA893A5-1463-482E-8475-384BAD1AC6FD@nvidia.com>
 <CAHbLzkrg7HpEf1_g4qpeGAR68dUKosSGihhnLRNcONnGVWdCJQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHbLzkrg7HpEf1_g4qpeGAR68dUKosSGihhnLRNcONnGVWdCJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.04.24 00:29, Yang Shi wrote:
> On Fri, Apr 12, 2024 at 2:06 PM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 12 Apr 2024, at 15:32, David Hildenbrand wrote:
>>
>>> On 12.04.24 16:35, Zi Yan wrote:
>>>> On 11 Apr 2024, at 11:46, David Hildenbrand wrote:
>>>>
>>>>> On 11.04.24 17:32, Zi Yan wrote:
>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>
>>>>>> In __folio_remove_rmap(), a large folio is added to deferred split list
>>>>>> if any page in a folio loses its final mapping. It is possible that
>>>>>> the folio is unmapped fully, but it is unnecessary to add the folio
>>>>>> to deferred split list at all. Fix it by checking folio mapcount before
>>>>>> adding a folio to deferred split list.
>>>>>>
>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>> ---
>>>>>>     mm/rmap.c | 9 ++++++---
>>>>>>     1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>> index 2608c40dffad..d599a772e282 100644
>>>>>> --- a/mm/rmap.c
>>>>>> +++ b/mm/rmap.c
>>>>>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>>>>                     enum rmap_level level)
>>>>>>     {
>>>>>>             atomic_t *mapped = &folio->_nr_pages_mapped;
>>>>>> -  int last, nr = 0, nr_pmdmapped = 0;
>>>>>> +  int last, nr = 0, nr_pmdmapped = 0, mapcount = 0;
>>>>>>             enum node_stat_item idx;
>>>>>>             __folio_rmap_sanity_checks(folio, page, nr_pages, level);
>>>>>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>>>>                             break;
>>>>>>                     }
>>>>>>    -                atomic_sub(nr_pages, &folio->_large_mapcount);
>>>>>> +          mapcount = atomic_sub_return(nr_pages,
>>>>>> +                                       &folio->_large_mapcount) + 1;
>>>>>
>>>>> That becomes a new memory barrier on some archs. Rather just re-read it below. Re-reading should be fine here.
>>>>
>>>> Would atomic_sub_return_relaxed() work? Originally I was using atomic_read(mapped)
>>>> below, but to save an atomic op, I chose to read mapcount here.
>>>
>>> Some points:
>>>
>>> (1) I suggest reading about atomic get/set vs. atomic RMW vs. atomic
>>> RMW that return a value -- and how they interact with memory barriers.
>>> Further, how relaxed variants are only optimized on some architectures.
>>>
>>> atomic_read() is usually READ_ONCE(), which is just an "ordinary" memory
>>> access that should not be refetched. Usually cheaper than most other stuff
>>> that involves atomics.
>>
>> I should have checked the actual implementation instead of being fooled
>> by the name. Will read about it. Thanks.
>>
>>>
>>> (2) We can either use folio_large_mapcount() == 0 or !atomic_read(mapped)
>>> to figure out if the folio is now completely unmapped.
>>>
>>> (3) There is one fundamental issue: if we are not batch-unmapping the whole
>>> thing, we will still add the folios to the deferred split queue. Migration
>>> would still do that, or if there are multiple VMAs covering a folio.
>>>
>>> (4) We should really avoid making common operations slower only to make
>>> some unreliable stats less unreliable.
>>>
>>>
>>> We should likely do something like the following, which might even be a bit
>>> faster in some cases because we avoid a function call in case we unmap
>>> individual PTEs by checking _deferred_list ahead of time
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 2608c40dffad..356598b3dc3c 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>                   * page of the folio is unmapped and at least one page
>>>                   * is still mapped.
>>>                   */
>>> -               if (folio_test_large(folio) && folio_test_anon(folio))
>>> -                       if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
>>> -                               deferred_split_folio(folio);
>>> +               if (folio_test_large(folio) && folio_test_anon(folio) &&
>>> +                   (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped) &&
>>> +                   atomic_read(mapped) &&
>>> +                   data_race(list_empty(&folio->_deferred_list)))
>>
>> data_race() might not be needed, as Ryan pointed out[1]
>>
>>> +                       deferred_split_folio(folio);
>>>          }
>>>
>>> I also thought about handling the scenario where we unmap the whole
>>> think in smaller chunks. We could detect "!atomic_read(mapped)" and
>>> detect that it is on the deferred split list, and simply remove it
>>> from that list incrementing an THP_UNDO_DEFERRED_SPLIT_PAGE event.
>>>
>>> But it would be racy with concurrent remapping of the folio (might happen with
>>> anon folios in corner cases I guess).
>>>
>>> What we can do is the following, though:
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index dc30139590e6..f05cba1807f2 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3133,6 +3133,8 @@ void folio_undo_large_rmappable(struct folio *folio)
>>>          ds_queue = get_deferred_split_queue(folio);
>>>          spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>>          if (!list_empty(&folio->_deferred_list)) {
>>> +               if (folio_test_pmd_mappable(folio))
>>> +                       count_vm_event(THP_UNDO_DEFERRED_SPLIT_PAGE);
>>>                  ds_queue->split_queue_len--;
>>>                  list_del_init(&folio->_deferred_list);
>>>          }
>>>
>>> Adding the right event of course.
>>>
>>>
>>> Then it's easy to filter out these "temporarily added to the list, but never split
>>> before the folio was freed" cases.
>>
>> So instead of making THP_DEFERRED_SPLIT_PAGE precise, use
>> THP_DEFERRED_SPLIT_PAGE - THP_UNDO_DEFERRED_SPLIT_PAGE instead? That should work.
> 
> It is definitely possible that the THP on the deferred split queue are
> freed instead of split. For example, 1M is unmapped for a 2M THP, then
> later the remaining 1M is unmapped, or the process exits before memory
> pressure happens. So how come we can tell it is "temporarily added to
> list"? Then THP_DEFERRED_SPLIT_PAGE - THP_UNDO_DEFERRED_SPLIT_PAGE
> actually just counts how many pages are still on deferred split queue.

Not quite I think. I don't think we have a counter that counts how many 
large folios on the deferred list were split. I think we only have 
THP_SPLIT_PAGE.

We could have
* THP_DEFERRED_SPLIT_PAGE
* THP_UNDO_DEFERRED_SPLIT_PAGE
* THP_PERFORM_DEFERRED_SPLIT_PAGE

Maybe that would catch more cases (not sure if all, though). Then, you 
could tell how many are still on that list. THP_DEFERRED_SPLIT_PAGE - 
THP_UNDO_DEFERRED_SPLIT_PAGE - THP_PERFORM_DEFERRED_SPLIT_PAGE.

That could give one a clearer picture how deferred split interacts with 
actual splitting (possibly under memory pressure), the whole reason why 
deferred splitting was added after all.

> It may be useful. However the counter is typically used to estimate
> how many THP are partially unmapped during a period of time.

I'd say it's a bit of an abuse of that counter; well, or interpreting 
something into the counter that that counter never reliably represented.

I can easily write a program that keeps sending your counter to infinity 
simply by triggering that behavior in a loop, so it's all a bit shaky.

Something like Ryans script makes more sense, where you get a clearer 
picture of what's mapped where and how. Because that information can be 
much more valuable than just knowing if it's mapped fully or partially 
(again, relevant for handling with memory waste).

-- 
Cheers,

David / dhildenb


