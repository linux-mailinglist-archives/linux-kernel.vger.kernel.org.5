Return-Path: <linux-kernel+bounces-145433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D648A5617
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA741F2274F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B76763F8;
	Mon, 15 Apr 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UifWs3O7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1117602B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194000; cv=none; b=MlNnjpICUkNLjkXNJ8gF3eK0wJgp+HB0SkVWTJrKunQ7qTRB23fRutNfhTGuXv5SBo8++9bSES9j0Hd0F76R97YS80v0ad9Q0QtkKtbImqumAMlXMaEdB9kcGUYLPOZjtpXjz5CzOY6Ep3Iyc9J6Wjg7u7GXtsBSskuQDeAZr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194000; c=relaxed/simple;
	bh=qXJOIKsH2LqlPch+CyyvhJkG9+3I3bqP5ksLs/ZkTE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvb5XdeMBpWsWaqR90+RGISzUVU7z162SJNfoqw/G5nOYEORj+DoKRL2AvsVAdbC1TJIfxNI4vinFEh38IH6OsJVf082HF17bddGOUnT0wfQDCmYsOWf9DUxZNt7QbvygeL+FVAL+7PvLTw648/stNdniPz7CqREn65EfyU8WvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UifWs3O7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713193998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U5V2/IPdbVemRFSaFXpBbw8BTi79cJQSk0FhNqmrP7g=;
	b=UifWs3O7dElVjhRmeXoD7RvN13Z0Snuch5QLqwSLIrIIF9gm7Xk6FcIuk70TPj0CZOzZfl
	wpS87bciYpwHdWthvY6C2eEeXFcsI+CdqbSVxfl6eWLSJNPhmwWx3waxV6a/HR9nwRCKvZ
	vjjulCV+803XLjbfQEIoe1y51cRwPFI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-AlncZa8BPB-sqk0_Ka-RGg-1; Mon, 15 Apr 2024 11:13:16 -0400
X-MC-Unique: AlncZa8BPB-sqk0_Ka-RGg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34619c30076so2469960f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193995; x=1713798795;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5V2/IPdbVemRFSaFXpBbw8BTi79cJQSk0FhNqmrP7g=;
        b=mgRa+UQnYTdog1BK47ZofrfGjhGB0aYDkzM4YvswoCaq3A7Y+j3rYFYm3FxkRNiQCw
         6d6FCt8uVaGFUlW253KMwGBunJJ8jkZg3/E+SEG9zLX9BTQc4cOnG1mmhWAeabtwsYJZ
         bBIQjPvr3VP7B1MjGbH8ADDnJsfWulnYStDKokRcdn/mluOlbqGEpNcKhdDSjGfmU/WZ
         KMzdVHTDtB1UNjMuMsRN0imIuypj281eBv9EfdNCFKyHYfuTFDU/XS4byIUF0TO+YWrU
         7FojnyoASz9iDsNucHBT8uaR4WWG3cORBqOTNkjMjl7HczYPb9MyiE0ElAYXUqPVyy2E
         1LAA==
X-Forwarded-Encrypted: i=1; AJvYcCV211DK+12GTIETheXryka6DsebnVShKT8Cib9PTOgyUWdja1O+QP4qRBiOl/b66/6SnYYRPz13Kldm+x2bcDxidly4ggdBtzP5F1ua
X-Gm-Message-State: AOJu0YwCmcGRLcBYoYYH18rcibRi0ksra7y29lxvSaU0JCoXM8JMtLSS
	ZiUMNXDT1CVEXfsL6tIYq7YCK+45KwM5jk0aJJQk5S4xeZGOw7SDzAu7BrC1VQk220uuvm5m/wo
	OyxdijPdkv5c0syFeJV5GRbyStaUKZ0J7FA7jjCFuXhUoSYRe/ZfqAsjXpke8ug==
X-Received: by 2002:adf:ee04:0:b0:343:9934:a28e with SMTP id y4-20020adfee04000000b003439934a28emr5970766wrn.35.1713193995130;
        Mon, 15 Apr 2024 08:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqMeEM6DbqyHxTvGWYpGoQkFzPjCgdAw4TvSMmU8s7vb5q48BBbW7qM77gdNJecL462t+pGA==
X-Received: by 2002:adf:ee04:0:b0:343:9934:a28e with SMTP id y4-20020adfee04000000b003439934a28emr5970750wrn.35.1713193994735;
        Mon, 15 Apr 2024 08:13:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:d800:568a:6ea7:5272:797c? (p200300cbc706d800568a6ea75272797c.dip0.t-ipconnect.de. [2003:cb:c706:d800:568a:6ea7:5272:797c])
        by smtp.gmail.com with ESMTPSA id z4-20020a5d6404000000b00343b09729easm12390017wru.69.2024.04.15.08.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:13:14 -0700 (PDT)
Message-ID: <5b1f986d-e8e2-4ca0-8377-6325076c84fa@redhat.com>
Date: Mon, 15 Apr 2024 17:13:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Yang Shi <shy828301@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20240411153232.169560-1-zi.yan@sent.com>
 <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <2C698A64-268C-4E43-9EDE-6238B656A391@nvidia.com>
 <bc8effda-6ff4-458d-a3ee-0d6f25cd41e0@redhat.com>
 <BBA893A5-1463-482E-8475-384BAD1AC6FD@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <BBA893A5-1463-482E-8475-384BAD1AC6FD@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.04.24 23:06, Zi Yan wrote:
> On 12 Apr 2024, at 15:32, David Hildenbrand wrote:
> 
>> On 12.04.24 16:35, Zi Yan wrote:
>>> On 11 Apr 2024, at 11:46, David Hildenbrand wrote:
>>>
>>>> On 11.04.24 17:32, Zi Yan wrote:
>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>
>>>>> In __folio_remove_rmap(), a large folio is added to deferred split list
>>>>> if any page in a folio loses its final mapping. It is possible that
>>>>> the folio is unmapped fully, but it is unnecessary to add the folio
>>>>> to deferred split list at all. Fix it by checking folio mapcount before
>>>>> adding a folio to deferred split list.
>>>>>
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>> ---
>>>>>     mm/rmap.c | 9 ++++++---
>>>>>     1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 2608c40dffad..d599a772e282 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>>>     		enum rmap_level level)
>>>>>     {
>>>>>     	atomic_t *mapped = &folio->_nr_pages_mapped;
>>>>> -	int last, nr = 0, nr_pmdmapped = 0;
>>>>> +	int last, nr = 0, nr_pmdmapped = 0, mapcount = 0;
>>>>>     	enum node_stat_item idx;
>>>>>      	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
>>>>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>>>     			break;
>>>>>     		}
>>>>>    -		atomic_sub(nr_pages, &folio->_large_mapcount);
>>>>> +		mapcount = atomic_sub_return(nr_pages,
>>>>> +					     &folio->_large_mapcount) + 1;
>>>>
>>>> That becomes a new memory barrier on some archs. Rather just re-read it below. Re-reading should be fine here.
>>>
>>> Would atomic_sub_return_relaxed() work? Originally I was using atomic_read(mapped)
>>> below, but to save an atomic op, I chose to read mapcount here.
>>
>> Some points:
>>
>> (1) I suggest reading about atomic get/set vs. atomic RMW vs. atomic
>> RMW that return a value -- and how they interact with memory barriers.
>> Further, how relaxed variants are only optimized on some architectures.
>>
>> atomic_read() is usually READ_ONCE(), which is just an "ordinary" memory
>> access that should not be refetched. Usually cheaper than most other stuff
>> that involves atomics.
> 
> I should have checked the actual implementation instead of being fooled
> by the name. Will read about it. Thanks.
> 
>>
>> (2) We can either use folio_large_mapcount() == 0 or !atomic_read(mapped)
>> to figure out if the folio is now completely unmapped.
>>
>> (3) There is one fundamental issue: if we are not batch-unmapping the whole
>> thing, we will still add the folios to the deferred split queue. Migration
>> would still do that, or if there are multiple VMAs covering a folio.
>>
>> (4) We should really avoid making common operations slower only to make
>> some unreliable stats less unreliable.
>>
>>
>> We should likely do something like the following, which might even be a bit
>> faster in some cases because we avoid a function call in case we unmap
>> individual PTEs by checking _deferred_list ahead of time
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 2608c40dffad..356598b3dc3c 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>                   * page of the folio is unmapped and at least one page
>>                   * is still mapped.
>>                   */
>> -               if (folio_test_large(folio) && folio_test_anon(folio))
>> -                       if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
>> -                               deferred_split_folio(folio);
>> +               if (folio_test_large(folio) && folio_test_anon(folio) &&
>> +                   (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped) &&
>> +                   atomic_read(mapped) &&
>> +                   data_race(list_empty(&folio->_deferred_list)))
> 
> data_race() might not be needed, as Ryan pointed out[1]

Right, I keep getting confused by that. Likely we should add data_race() 
only if we get actual reports.

-- 
Cheers,

David / dhildenb


