Return-Path: <linux-kernel+bounces-118562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8907388BCA4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8F31F3454D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0E01078B;
	Tue, 26 Mar 2024 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2JcxKas"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC5EEA8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442418; cv=none; b=or/ulhWcCBOQHPRt5oXjZ6j3fPKalEadCWYv2Monab6cYsRNSMIYzt6wj02Afz6JcgrZbRLxeR2mOVu6kj+VFPXIs4kLzMcl1m5G3/Qu6AzMutqfyDXDqAINkefOOPEdwgL8a3uS3XRHWIe+zP/DVp1D8yJ4yxXD67Nx+w+tBD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442418; c=relaxed/simple;
	bh=7Bdvz7LgWpP8b6fXpCGiw0T2Cn2hmF5O8YCyH5UwDHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hL+eBe0FNLMGygnbmzPaSGdkMq/H78PikNtMGl9akZ3o3aVVhiOug67hypX8xnNSn11TNVApgEEizNHCjxxiNv3ZTOKtErX1xSTTnUnlMob/9e/18PsVAztmtizosUboTGPLJzmcaZbPgBf0OZ9UGPsi7kp3dUq+psgzneC7KwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2JcxKas; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711442415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nkOCJRiI1ZAz+I9vckhDTlAHc7dV2Q9WRexZvpmK/f8=;
	b=a2JcxKasBV9la3Pl0aYaVLX5kVicuae92utM7mKeJ75/l1HiiFxZJ6DRRatf9CeKHAdkPU
	LxmluLl35akQOfWksqUs595snfjq+ZbIfmabvZ2jWa2yWwyEtyPOA0EWdYe2CMZSq1zS65
	pP8vqoFGktOo1XrKmycyUdkujqGShY0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-QBG1fBGrPauzArgcPEbbTg-1; Tue, 26 Mar 2024 04:40:14 -0400
X-MC-Unique: QBG1fBGrPauzArgcPEbbTg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4147faf154cso13897805e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711442413; x=1712047213;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkOCJRiI1ZAz+I9vckhDTlAHc7dV2Q9WRexZvpmK/f8=;
        b=Deu9d3cIQNG5WqwChlEW34E7SIYHh7oq6X/XQKppeloE8F/nBtRfYde0d7QfZR12ld
         2NMbMrp9k7x3TZS1RCxokb9hwhtyZmpEawi4CM5kZ+AqCx5vxefuMuD6cqaQdXrnVFtj
         rLRtRSk60HhBxwFu+e6nunQHEV5tJk4SNWnMrYpTi85+an6glLcRiuZjcUX5qA1Ix+3h
         IxGKuh065qEClmysNjSbOHUcZHg8M1SAlAmm9LDl7CaxBZhcFE61GnfjXoMu2AbsHTrU
         ntQqhYMHAp2rVL3hFWsGHKRwDVt6PQ+10OomTTwThGz1Uu0Ja6YOSmxQam9f0ahpZJUp
         fYLg==
X-Gm-Message-State: AOJu0YztZ6oLb7DCAjsucI73BvhDQ9KZ5QhzDQsynWps9n2B3DhxsiRc
	VwG0nu76EsheGQyyRDRE0ne1RtktXR7cTg3n57Y7R4lXSGeu9epD0OzW/05r5LgWkt0o3FRsipv
	qoB4Ru846+cgj4ROu2eUhUJii5mcTckMdZttOIqGno3apDdoKZ5qJlrdLwdN0Fg==
X-Received: by 2002:a05:600c:4ec6:b0:414:8c26:161a with SMTP id g6-20020a05600c4ec600b004148c26161amr2546254wmq.33.1711442412809;
        Tue, 26 Mar 2024 01:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvj7cYfPwuOLqGX3PFKhfHILC3MOJFCuEjbabRqt8r40Ezkm6U+FSpLRhHKPDvfKl2PNkXwQ==
X-Received: by 2002:a05:600c:4ec6:b0:414:8c26:161a with SMTP id g6-20020a05600c4ec600b004148c26161amr2546229wmq.33.1711442412281;
        Tue, 26 Mar 2024 01:40:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0041330d49604sm10942408wmq.45.2024.03.26.01.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 01:40:11 -0700 (PDT)
Message-ID: <9e61e85b-afa8-49fe-a9fb-f17d6ca39903@redhat.com>
Date: Tue, 26 Mar 2024 09:40:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] mm: merge folio_is_secretmem() into
 folio_fast_pin_allowed()
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Miklos Szeredi <mszeredi@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 xingwei lee <xrivendell7@gmail.com>, yue sun <samsun1006219@gmail.com>
References: <20240325134114.257544-1-david@redhat.com>
 <20240325134114.257544-4-david@redhat.com> <ZgJrjVvwWnWEZC-7@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZgJrjVvwWnWEZC-7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.03.24 07:30, Mike Rapoport wrote:
> On Mon, Mar 25, 2024 at 02:41:14PM +0100, David Hildenbrand wrote:
>> folio_is_secretmem() is currently only used during GUP-fast, and using
>> it in wrong context where concurrent truncation might happen, could be
>> problematic.
>>
>> Nowadays, folio_fast_pin_allowed() performs similar checks during
>> GUP-fast and contains a lot of careful handling -- READ_ONCE( -- ), sanity

Re-reading my stuff ...

s/( -- )/() --/

>> checks -- lockdep_assert_irqs_disabled() --  and helpful comments on how
>> this handling is safe and correct.
>>
>> So let's merge folio_is_secretmem() into folio_fast_pin_allowed(), still
>> avoiding checking the actual mapping only if really required.

s/avoiding//

>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> 

Thanks!

> A few comments below, no strong feelings about them.
> 
>> ---
>>   include/linux/secretmem.h | 21 ++-------------------
>>   mm/gup.c                  | 33 +++++++++++++++++++++------------
>>   2 files changed, 23 insertions(+), 31 deletions(-)
>>
>> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
>> index 6996f1f53f14..e918f96881f5 100644
>> --- a/include/linux/secretmem.h
>> +++ b/include/linux/secretmem.h
>> @@ -6,25 +6,8 @@
>>   
>>   extern const struct address_space_operations secretmem_aops;
>>   
>> -static inline bool folio_is_secretmem(struct folio *folio)
>> +static inline bool secretmem_mapping(struct address_space *mapping)
>>   {
>> -	struct address_space *mapping;
>> -
>> -	/*
>> -	 * Using folio_mapping() is quite slow because of the actual call
>> -	 * instruction.
>> -	 * We know that secretmem pages are not compound and LRU so we can
>> -	 * save a couple of cycles here.
>> -	 */
>> -	if (folio_test_large(folio) || folio_test_lru(folio))
>> -		return false;
>> -
>> -	mapping = (struct address_space *)
>> -		((unsigned long)folio->mapping & ~PAGE_MAPPING_FLAGS);
>> -
>> -	if (!mapping || mapping != folio->mapping)
>> -		return false;
>> -
>>   	return mapping->a_ops == &secretmem_aops;
>>   }
>>   
>> @@ -38,7 +21,7 @@ static inline bool vma_is_secretmem(struct vm_area_struct *vma)
>>   	return false;
>>   }
>>   
>> -static inline bool folio_is_secretmem(struct folio *folio)
>> +static inline bool secretmem_mapping(struct address_space *mapping)
>>   {
>>   	return false;
>>   }
>> diff --git a/mm/gup.c b/mm/gup.c
>> index e7510b6ce765..69d8bc8e4451 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2472,6 +2472,8 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>>    * This call assumes the caller has pinned the folio, that the lowest page table
>>    * level still points to this folio, and that interrupts have been disabled.
>>    *
>> + * GUP-fast must reject all secretmem folios.
>> + *
>>    * Writing to pinned file-backed dirty tracked folios is inherently problematic
>>    * (see comment describing the writable_file_mapping_allowed() function). We
>>    * therefore try to avoid the most egregious case of a long-term mapping doing
>> @@ -2484,22 +2486,32 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>>   static bool folio_fast_pin_allowed(struct folio *folio, unsigned int flags)
> 
> Now when this function checks for gup in general, maybe it's worth to
> rename it to, say, folio_fast_gup_allowed.

Had the exact the same thought, so I'll do it!

Not sure about "fast gup" vs. "gup fast" vs. "lockless gup", it's all 
inconsistent and we should likely clean that up.

Likely, we should just prefix all relevant functions with "gup_fast". 
I'll call this "gup_fast_folio_allowed" for now.

The first description of the function becomes: "Used in the GUP-fast 
path to determine whether GUP is permitted to work on a specific folio."

> 
>>   {
>>   	struct address_space *mapping;
>> +	bool check_secretmem = false;
>> +	bool reject_file_backed = false;
>>   	unsigned long mapping_flags;
>>   
>>   	/*
>>   	 * If we aren't pinning then no problematic write can occur. A long term
>>   	 * pin is the most egregious case so this is the one we disallow.
>>   	 */
>> -	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) !=
>> +	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) ==
>>   	    (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))
>> -		return true;
>> +		reject_file_backed = true;
>> +
>> +	/* We hold a folio reference, so we can safely access folio fields. */
>>   
>> -	/* The folio is pinned, so we can safely access folio fields. */
>> +	/* secretmem folios are only order-0 folios and never LRU folios. */
> 
> Nit:                           ^ always

ack


Thanks for the review!

-- 
Cheers,

David / dhildenb


