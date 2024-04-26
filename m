Return-Path: <linux-kernel+bounces-159606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCC88B30E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D7A1F23D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9CE13AD01;
	Fri, 26 Apr 2024 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0R954f8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72F13AA35
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114666; cv=none; b=GqRXYXwVaeFBHnwiYjSw1Ir6CH9qeDmaRq13IDrDtW10JmPfIS9+UCR3cULrws0Uek15y0SdAXIuxvqCmkJuy+8mCawxyYCwpdHKHrER6+l+tTQ9rSkJQODq6djQam1FUveeZtQ0KsuEf+wpeXobAQSJUNAE0dPms+pBuoKKMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114666; c=relaxed/simple;
	bh=s4WFvLqL/FlFXDjXnJP+t8dQbIFZqMAVv435zFp0leY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mz4dt5SVXu+JADnhydkWkHf6C80oTuLAN/DaE9tBF6aUubL23WKCyacdANvqVQ/PeDUhuNqpuIt0mcl/AJh56mGMeSDY22LK9V4/y/IKEfiAnqArKFgEkh8d//+97jWmtQRxZGNcSauivIESaLuN2DkN8YAz7Z6uIQQtsXR4Oec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0R954f8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714114663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S9YgOSSzhWQrtdlbF1hJCE17T/mb2rDP4iaqnDMJfb0=;
	b=Q0R954f8JSm6naLMuOt9mF9Mlzpyqz8YvZyWvmRs8ndXH3NBkf/E+E6Qms4628ugaNCYbo
	i2h8ndrNRDSEIXeK9Tjn1GCaaKDEDgsQ9tjo2kYy9ota5jOy7P04qyaRxjAYZ2jJ7gN1+B
	UbGBrxDz2XX8flopYlz05Mg7hUX+KOc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-jcsXWqXKPMCSmKxAYGi4Jg-1; Fri, 26 Apr 2024 02:57:39 -0400
X-MC-Unique: jcsXWqXKPMCSmKxAYGi4Jg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34bf4e9ae01so1088768f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714114658; x=1714719458;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S9YgOSSzhWQrtdlbF1hJCE17T/mb2rDP4iaqnDMJfb0=;
        b=ThmNy8OXxqEdQAItTVzzTlHV3KRTAqY/ITcERUMde0HLbfg4RHjqVNb81WzIO5XZc4
         9kDVNzyHa7ORTsq0ltzwDcwJSMrLzmQdFz43Xu55nLwnfL9IuoNW9Ohe3fC8kC/inlQ8
         l4YuUlLXNSFCDpUwO9EgE/GAagpwqWd9udp8upr7vQ8tZlJfrv21IGu4TVpZfG9MVvZL
         Uuf+eddGgHOYvtDzjG+6TPhXTQsy9wFLdzWUrF3WxaDMZ+yx1fM2/2CJha9YqJTi4Cwx
         ZjoqZciIkZ3rVsIMn+PJt0PyOZL2KMD73XU7zYt9FCRqyReK8MNyeQgsNpU3T7ER+BOc
         fECQ==
X-Gm-Message-State: AOJu0Yw0+z65651g1u6GdaQ0DMM4/GZAWTJhZfHMFopEENqM/nAKeBNQ
	DmsmaEwDgmSd9lhQLJksco/k9NVom24XvkmU+xFYMyFregMltw5hfy3zdpVVb3IBzLGCQtbAOOU
	YESdPzB4ITBaLjZVldKUM+WEbTrg2SVfBjtCmENKY/mibEAF+ZeIz7eFX/hi1dw==
X-Received: by 2002:a5d:4dc1:0:b0:349:ffed:792d with SMTP id f1-20020a5d4dc1000000b00349ffed792dmr1495855wru.30.1714114658404;
        Thu, 25 Apr 2024 23:57:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiGcMtO3pvrqLzxCKrJCX59NpN1TNY/wPfeqt9MvGmQf29twl4GqizB6+lEhzfbJ8yP/FB2w==
X-Received: by 2002:a5d:4dc1:0:b0:349:ffed:792d with SMTP id f1-20020a5d4dc1000000b00349ffed792dmr1495838wru.30.1714114657964;
        Thu, 25 Apr 2024 23:57:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:6100:20f2:6848:5b74:ca82? (p200300cbc726610020f268485b74ca82.dip0.t-ipconnect.de. [2003:cb:c726:6100:20f2:6848:5b74:ca82])
        by smtp.gmail.com with ESMTPSA id e24-20020a5d5958000000b0034c0fefd7d2sm3255775wri.23.2024.04.25.23.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 23:57:37 -0700 (PDT)
Message-ID: <c04f5611-162c-441c-b94c-79032f09e015@redhat.com>
Date: Fri, 26 Apr 2024 08:57:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/khugepaged: replace page_mapcount() check by
 folio_likely_mapped_shared()
To: John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20240424122630.495788-1-david@redhat.com>
 <73de5556-e574-4ed7-a7fb-c4648e46206b@nvidia.com>
 <ZinZSDTMXjPjAHLe@casper.infradead.org>
 <18b9acc9-9dc8-4857-83d1-952c94b69e01@nvidia.com>
 <7273b0d6-06e7-4741-b77b-b49949c46d63@redhat.com>
 <1a406a5f-1336-4051-a722-04b9ea2f54df@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1a406a5f-1336-4051-a722-04b9ea2f54df@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.04.24 03:23, John Hubbard wrote:
> On 4/25/24 1:06 AM, David Hildenbrand wrote:
>> On 25.04.24 07:40, John Hubbard wrote:
>>> On 4/24/24 9:17 PM, Matthew Wilcox wrote:
>>>> On Wed, Apr 24, 2024 at 09:00:50PM -0700, John Hubbard wrote:
> ...
>> We'll talk more about all that at LSF/MM in the mapcount session. A spoiler:
> 
> Looking forward to it. And as an aside, this year it feels like the mm
> code is changing relatively fast. So many large and small improvements
> have happened or are in progress.

Yes, it's happening on a very fast pace (and it's hard for me to get 
reasonable work done while still keeping reviewing that much ...).

I'll note, that replacing a page-based interface by a folio-based 
interface should not be shocking news in 2024, and that the issues with 
mapcounts for large folios have been a recurring topic at LSF/MM and on 
the mailing list.

> 
> 
>>
>> page_mapcount() in the context of large folios:
>> * Is a misunderstood function (e.g., page_mapcount() vs page_count()
>>     checks, mapped = !page_mapcount() checks).
>> * Is a misleading function (e.g., page_mapped() == folio_mapped() but
>>     page_mapcount() != folio_mapcount())
>>
>> We could just rename it to "folio_precise_page_mapcount()", but then, once we tackle the subpage mapcount optimizations (initially using a separate kernel config toggle), we'll have to teach each caller about an alternative that gets the job done, and it's not that easy to prevent further reuse around the kernel.
>>
>> If you look at linux-next, we're down to 5 page_mapcount() calls in fs/proc/, so I'll relocate it to fs/proc/internal.h to prevent any further use - once the s390x change lands in the next merge window.
>>
>> Regarding the subpage mapcount optimizations, I can further add:
>> * (un)map performance improvements for PTE-mapped THP
>> * Preparation for folio_order() > PMD_ORDER, where the current scheme
>>     won't scale and needs further adjustments/complexity to even keep it
>>     working
>> * Preparation for hugetlb-like vmemmap optimizations until we have
>>     memdescs / dynamically allocated folios
>> * (Paving the way for partially mapping hugetlb folios that faced
>>      similar issues? Not sure if that ever gets real, though)
>>
>> Is this patch ahead of its time? LSF/MM is just around the corner, and I'm planning on posting the other relevant patches in the next months.
> 
> I think so, yes. There is a lot of context required to understand the
> motivation, and more required in order to figure out if it is safe,
> and if it still provides "good" behavior.

I think the motivation for removing page_mapcount() should be very clear 
at this point: a single remaining user in mm/ should be warranted, and 
the faster it is gone the better.

[case in point: I even have another potential user [1] in my mailbox 
that should be using a folio interface, well, or PG_anon_exclusive :) ]

[1] https://lore.kernel.org/all/Zirw0uINbP6GxFiK@bender.morinfr.org/T/#u

Regarding removing subpage mapcounts I agree: I added too many details 
that made it look harder to understand :P

> 
> I still think it's mostly harmless, though, so being ahead of its time
> is not necessarily an indictment. :)

I didn't express my thought clearly: LSF/MM is just around the corner 
and the discussion we are having here is the perfect preparation for 
that session! :)

I don't particularly care if we merge this patch now or after the next 
merge window along with the remaining page_mapcount() removal.

Discussing the impact of this change is the important piece. :)

[...]

>> Thanks for having a look!
>>
>> I'm only a bit concerned about folio_likely_mapped_shared() "false negatives" (detecting exclusive although shared), until we have a more precise folio_likely_mapped_shared() variant to not unexpectedly waste memory.
>>
>> Imagine someone would be setting "khugepaged_max_ptes_shared=0", and then we have an area where (I think this is the extreme case):
>>
>> * We map 256 subpages of a 2M folio that are shared 256 times with a
>>     child process.
>> * We don't map the first subpage.
>> * One PTE maps another page and is pte_write().
>> * 255 PTEs are pte_none().
>>
>> folio_likely_mapped_shared() would return "false".
>>
>> But then my thinking is:
>> * We are already wasting 256 subpages that are free in the 2M folio.
>>     Sure, we might be able to relaim it when deferred splitting.
>> * Why would someone set khugepaged_max_ptes_shared=0 but leave
>>     khugepaged_max_ptes_none set that high that we would allow 255
>>     pte_none?
>> * If the child is a short-living subprocess, we don't really care
>> * Any futher writes to unbacked/R/O PTEs in that PMD area would COW and
>>     consume memory.
>>
>> So I had to use more and more "ifs" to construct a scenario where we might end up wasting 1M of memory, at which point I decided "this is really a corner case" and likely not worth the worry.
>>
>> If we run into real issues, though, it will be easy to just inline page_mapcount() here to resolve it; but the less special-casing the better.
>>
> 
> OK. I'll need to think through some more of these cases. And meanwhile, I
> was poking around from the other direction: just injection test it by
> pasting in "true" or "false", in place of calling folio_likely_mapped_shared().
> And see what changes.

Highly appreciated!

> 
> The "true" test lets me fail several khugepaged selftests, while the "false"
> test just increases the counter in /proc/vmstat.
> 
> That's more of a black box way of poking at it, just to have another facet
> of testing. Because it is good to ensure that we really do have test
> coverage if we're changing the code. Anyway, just ideas.

Yes, all makes sense.

I'm very interested if there are valid concerns that the "false 
negatives" are unacceptable: it would be another case for why we really 
want to make folio_likely_mapped_shared() precise. For me it's clear 
that we want to make it precise, but so far I am not convinced that it 
is absolutely required in the khugepaged context.

Thanks!

-- 
Cheers,

David / dhildenb


