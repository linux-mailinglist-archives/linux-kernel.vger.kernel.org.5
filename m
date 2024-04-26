Return-Path: <linux-kernel+bounces-160602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FED8B3FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADFC4B2434D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099EF22F02;
	Fri, 26 Apr 2024 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFbmnsb8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E17D2231F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714158537; cv=none; b=OtnxDTLqP/Ywx7tuXHslJJi1+9v82OdK5eeOHWDwgnQ7PF2lGp1VeOoaUbUVYNzvJr/Y1ioOZWSSM4+V8JgEhOhnkO9T/xQbSRU7EimCR1xGBODXXzL7oB5mjRbUud92tS+02wjh5Quy6IXYR3DIAA5dbG5hp4KQ71LCDBWvb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714158537; c=relaxed/simple;
	bh=UxFDFQsrWXV4pp01Sln049I887nsiZ03hyswuHyMSig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oa5wCBCJmAw0PzOeRS/+DJ4Dtk+EDNWhGCqTzHTxOKtcrPJuJEXY7LVU8SI7ZlWcNy4/ZZlKLE8HMDnJckoZE18IoqARmPadLa9BHimJuBM16ruKKbYZ0H1EHg4igm9UbYPDzFv4lT0n/BHEksXY+0gDZ+n/ijkX+16iqoP/bq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFbmnsb8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714158534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EqymC4N1I5xnwiJ3V4c/ehB/KNavulLMGbF+wl7/oH4=;
	b=dFbmnsb8SSgK+iD/8cJPzsh6nA0OlwnMxZfk62D0hjn3rQ2IXtyy6OTR3W2NSqGNdcG6wy
	tm1mdmYQz7G4Y54TybtFwP7+rJMkzJoaBvA2IX5XGxaLWjsz08wQNKsTvm52noEVt7yCS4
	/3ad3GI/meNiGHM4EQwzGZ7m/awV4v4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-5PSYJFlbONuQzhYlx0uGiw-1; Fri, 26 Apr 2024 15:08:49 -0400
X-MC-Unique: 5PSYJFlbONuQzhYlx0uGiw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-419f572bdbdso10059635e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714158528; x=1714763328;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqymC4N1I5xnwiJ3V4c/ehB/KNavulLMGbF+wl7/oH4=;
        b=Ncr2lo0k4TniBY5xOiQBwB2Ls5cTB1/LQfxLvc+rff1wLbTpl2qWbUEUp2TQDBluO4
         7IywHvnYCek7pruFQczmKbu0D/03/zFj6tPygbdf6IJ4QkraTzT2wUyim1uhz8f7vf0c
         o81zuo8/pFBGs6CcPMXTJH7JQkBrNGaTqPnmmFrmg3Txno9RWay8xkICa32bGqWk2eEA
         EU5SJ9Z5QLbws6SwfS7Ufa6o1C1yrc95kwQDcjk+O4C70lEDtsP6ZZOECo+GuRpTuW+9
         MWKbJKq/IRl2WoccLTHmNA/87cz+zwLzGeqEcXWAKDMqCVVYwLmOG7Q36fnKIhr4O+Ub
         F+FA==
X-Forwarded-Encrypted: i=1; AJvYcCXA/KTOFQ2FMb92tliaD45JYqApNZe4xHu1H1LFPxihrVCOs1HMu1vKdTJSnYE1CpU28pd19/ZXo4DiihfJBtS6ozadgdiY9vDKxfLJ
X-Gm-Message-State: AOJu0Yz8MCR/z9Ki/Ty71e8x73NHmgCDUCDbR5y5Ro0bxIqvSKAxpmXx
	SX319k8R0TCLmdhhTHnCHJIqM1RJcJMX8Jg3aAbgAzw67SVA/lgIAzWxF92RrYz5kwq8Lnuz56x
	h/mSPDEm60VgHw+szhKGAaInPmMXDXkjKGB09614VeMVp08yTMVAnhb4mr+C7mw==
X-Received: by 2002:a05:600c:1911:b0:41a:8055:8b89 with SMTP id j17-20020a05600c191100b0041a80558b89mr3100067wmq.6.1714158528470;
        Fri, 26 Apr 2024 12:08:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn9ghvM5IIb9vzOAT3wgOf7S+IUgcSYF25UPVL+0bIqUVbmXDKa7jf6fcE/z6Np6M3huuacA==
X-Received: by 2002:a05:600c:1911:b0:41a:8055:8b89 with SMTP id j17-20020a05600c191100b0041a80558b89mr3100051wmq.6.1714158527972;
        Fri, 26 Apr 2024 12:08:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:6100:20f2:6848:5b74:ca82? (p200300cbc726610020f268485b74ca82.dip0.t-ipconnect.de. [2003:cb:c726:6100:20f2:6848:5b74:ca82])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c3b8600b0041892e839bcsm32170985wms.33.2024.04.26.12.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 12:08:47 -0700 (PDT)
Message-ID: <e274ad3b-bbeb-49b0-81bf-24fd33106f05@redhat.com>
Date: Fri, 26 Apr 2024 21:08:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20240426190253.541419-1-zi.yan@sent.com>
Content-Language: en-US
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
In-Reply-To: <20240426190253.541419-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.04.24 21:02, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> In __folio_remove_rmap(), a large folio is added to deferred split list
> if any page in a folio loses its final mapping. But it is possible that
> the folio is fully unmapped and adding it to deferred split list is
> unnecessary.
> 
> For PMD-mapped THPs, that was not really an issue, because removing the
> last PMD mapping in the absence of PTE mappings would not have added the
> folio to the deferred split queue.
> 
> However, for PTE-mapped THPs, which are now more prominent due to mTHP,
> they are always added to the deferred split queue. One side effect
> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can be
> unintentionally increased, making it look like there are many partially
> mapped folios -- although the whole folio is fully unmapped stepwise.
> 
> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THPs
> where possible starting from commit b06dc281aa99 ("mm/rmap: introduce
> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-mapped
> folio is unmapped in one go and can avoid being added to deferred split
> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will still be
> noise when we cannot batch-unmap a complete PTE-mapped folio in one go
> -- or where this type of batching is not implemented yet, e.g., migration.
> 
> To avoid the unnecessary addition, folio->_nr_pages_mapped is checked
> to tell if the whole folio is unmapped. If the folio is already on
> deferred split list, it will be skipped, too.
> 
> Note: commit 98046944a159 ("mm: huge_memory: add the missing
> folio_test_pmd_mappable() for THP split statistics") tried to exclude
> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/rmap.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2608c40dffad..a9bd64ebdd9a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1495,6 +1495,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>   {
>   	atomic_t *mapped = &folio->_nr_pages_mapped;
>   	int last, nr = 0, nr_pmdmapped = 0;
> +	bool partially_mapped = false;
>   	enum node_stat_item idx;
>   
>   	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
> @@ -1515,6 +1516,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>   					nr++;
>   			}
>   		} while (page++, --nr_pages > 0);
> +
> +		partially_mapped = !!nr && !!atomic_read(mapped);

Nit: The && should remove the need for both !!.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


