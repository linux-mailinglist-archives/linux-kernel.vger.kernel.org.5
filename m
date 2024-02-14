Return-Path: <linux-kernel+bounces-65341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71763854B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF641C21B24
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56945A7AC;
	Wed, 14 Feb 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeTYbYvG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218905A113
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921273; cv=none; b=VVsWGteF8X3x5wITMFtlm4h/ePbQEnyKQxJjKqO1VpHprsgU+Nq3cs9l5P8kamg4t0va2qkgGPJtdMwvMGNKePWYf8UIQjH0zhDtKOK+m8FmV/6Z4M+xPY5NQ6WyN2tJ6/eaBVkx5dS9NivU9NBkrYudlgq347PGEGrckWNaUnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921273; c=relaxed/simple;
	bh=KCrba6UK8EXlGRdj4QcMTPo/ycuCLzV9fFa2r0rSgzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unB1zixjc5m5xZvzjd6Kl/usLyiPgj+xfelPHc1mLvLfrGdmWJw1DN8Hi64TcmW8qWGXiCYHeNSNeL6ba2gzN0GUO6RGans++sPtqtSpuaQbjL1wHS9AUIGKgZJp5jNRSptouqsaMR4UloIzNBgXxyHl10vlgbAh9nZC9+kAepQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TeTYbYvG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707921270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G/CXa47vCO+On1sBQqAHOelo6CVXqbmEV9d4ZtRHY98=;
	b=TeTYbYvGUePa6NQsmimUXb6BMYQSROUgDd4rPG5mWpOAfbP5ILPxSMozQcEvdlNl1TTR2u
	Q+oV2t2pe+lbzXJTWGHY+T9bgiKHeaaw8uhExTpR4r/vyUoQjdTjBvxPGCSsKpTS34RB92
	2v42p/+peDEwn0cdMWOxAB3RjgGY+eE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-WDHGPvKsO7uY9qPAM9YZzg-1; Wed, 14 Feb 2024 09:34:29 -0500
X-MC-Unique: WDHGPvKsO7uY9qPAM9YZzg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ce7272575so450256f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707921267; x=1708526067;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/CXa47vCO+On1sBQqAHOelo6CVXqbmEV9d4ZtRHY98=;
        b=nyxbZxeSCr5j5hdq46SDokfC4YavZhnhzb10mTEqFLTuuIloFRAEYqWbCh4SNjwHM5
         02GbG2AEBKPdKTsR1HOvpM+O9gVINzDYoHEN3iKNtvpQNbrqY5KZGHUUErnSAvm1uHZ7
         DtRL04lGwPeImupt13wGpF8c9oEzd1WW4G73gq2E/k4bkTRJE9ulPHP2Ry5dp7PaXpug
         gzXCoOgFz4drfbdoWFsIEpS8k2pFBOw/+6uWIsaHkIVaKkX2tcq3Z2js8Q1GWl35RIj/
         YjG2AFGsB2zMAO7ZvtwSXYu78c3YbHFWHZQrR80g2wnURe4L2sKvV07jFyNcLCeEDYEI
         pP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUa2q4jvMegtYr3n1tIUEnVTQa05oM1MpHKxnNLA+IvD/mneKuHcUyRF62Hpq20oRM+7MbhI/E9OiKSHcW3Gjf2QPra8HmgAxy+2WRH
X-Gm-Message-State: AOJu0Yy366+2xwbKv1yLEERA0foU8FHbf/zbaj3Uv/kAYv1iWG0XDvpT
	rPJ8YE30G6f11kSblcslporWfCAjWOlCmRXsu0LIMhrr5aR//IONykGJi4TGmP1FxryH1gwaopH
	uZlKXj83K0/f9B9DTKUW1dZ7UiyGxpDY0TN4jpOA1yhlDPBR0aWIPW8BM3o78ag==
X-Received: by 2002:adf:f348:0:b0:33c:d310:73cb with SMTP id e8-20020adff348000000b0033cd31073cbmr2177959wrp.19.1707921267013;
        Wed, 14 Feb 2024 06:34:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGInr2x1NzVvLC2uIezN5JQPtd0nNudiXofTvJruw4LRJIm3hT9JpHwbZqb4yeZEp1zbWu6A==
X-Received: by 2002:adf:f348:0:b0:33c:d310:73cb with SMTP id e8-20020adff348000000b0033cd31073cbmr2177925wrp.19.1707921266559;
        Wed, 14 Feb 2024 06:34:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMvvxAKDVB8PSUDgeu8gEZRhpU4IfTbtJg2qjYk9caDBC+a/2k4y3rwQTzCMKl3epXawgxcC5j0/vOLf/t1liYsAriI6pp6SdEvZex2dtMRgPIOKsZdoPNMA0KQSyB3W7QT17h3yV1CPu4jYBEs2dsvIeZ5SAisEk5g/ypWCYywDjaVp92aOfTHOSvxWny4z3JSU2RAYoEHrI0RAfF0V2Mf7BlUiKflY/psSslnFgU+JJ0SKvypy/ohvirnxEKPyk2jYSv2p8GwiQ+GlgqsLxe5iJdIAZGcaxKieeDq/sKLrvoykfy3jV5WPrG+EN3JH9J7IlJzU90RvVh1V4=
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id f5-20020a056000128500b0033cf2063052sm1076695wrx.111.2024.02.14.06.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 06:34:25 -0800 (PST)
Message-ID: <f2ad5918-7e36-4a7c-a619-c6807cfca5ec@redhat.com>
Date: Wed, 14 Feb 2024 15:34:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix swap entry values of tail pages of
 THP
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>,
 Charan Teja Kalla <quic_charante@quicinc.com>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org, vbabka@suse.cz,
 dhowells@redhat.com, surenb@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 # see patch description <stable@vger.kernel.org>,
 Huang Ying <ying.huang@intel.com>
References: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
 <a683e199-ce8a-4534-a21e-65f2528415a6@redhat.com>
 <8620c1a0-e091-46e9-418a-db66e621b9c4@quicinc.com>
 <845ca78f-913b-4a92-8b40-ff772a7ad333@redhat.com>
 <bc1a5e36-1983-1a39-4d06-8062993a4ca4@quicinc.com>
 <ZczLoOqdpMJpkO5N@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZczLoOqdpMJpkO5N@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.02.24 15:18, Matthew Wilcox wrote:
> On Wed, Feb 14, 2024 at 12:04:10PM +0530, Charan Teja Kalla wrote:
>>> 1) Is it broken in 5.15? Did you actually try to reproduce or is this
>>>     just a guess?
>>>
>>
>> We didn't run the tests with THP enabled on 5.15, __so we didn't
>> encounter this issue__ on older to 6.1 kernels.
>>
>> I mentioned that issue exists is based on my understanding after code
>> walk through. To be specific, I just looked to the
>> migrate_pages()->..->migrate_page_move_mapping() &
>> __split_huge_page_tail() where the ->private field of thp sub-pages is
>> not filled with swap entry. If it could have set, I think these are the
>> only places where it would have done, per my understanding. CMIW.
> 
> I think you have a misunderstanding.  David's patch cfeed8ffe55b (part
> of 6.6) _stopped_ us using the tail ->private entries.  So in 6.1, these
> tail pages should already have page->private set, and I don't understand
> what you're fixing.

I think the issue is, that migrate_page_move_mapping() / 
folio_migrate_mapping() would update ->private for a folio in the 
swapcache (head page)

	newfolio->private = folio_get_private(folio);

but not the ->private of the tail pages.

So once you migrate a THP that is in the swapcache, ->private of the 
tail pages would not be migrated and, therefore, be stale/wrong.

Even before your patch that was the case.

Looking at migrate_page_move_mapping(), we had:

	if (PageSwapBacked(page)) {
		__SetPageSwapBacked(newpage);
		if (PageSwapCache(page)) {
			SetPageSwapCache(newpage);
			set_page_private(newpage, page_private(page));
		}
	} else {
		VM_BUG_ON_PAGE(PageSwapCache(page), page);
	}


I don't immediately see where the tail pages would similarly get updated 
(via set_page_private).

With my patch the problem is gone, because the tail page entries don't 
have to be migrated, because they are unused.


Maybe this was an oversight from THP_SWAP -- 38d8b4e6bdc8 ("mm, THP, 
swap: delay splitting THP during swap out").

It did update __add_to_swap_cache():

for (i = 0; i < nr; i++) {
         set_page_private(page + i, entry.val + i);
         error = radix_tree_insert(&address_space->page_tree,
                                   idx + i, page + i);
         if (unlikely(error))
                 break;
}

and similarly __delete_from_swap_cache().

But I don't see any updates to migration code.

Now, it could be that THP migration was added later (post 2017), in that 
case the introducing commit would not have been 38d8b4e6bdc8.

-- 
Cheers,

David / dhildenb


