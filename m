Return-Path: <linux-kernel+bounces-121630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D5388EB48
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9892A1F304B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DB2130A59;
	Wed, 27 Mar 2024 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grXSKXef"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8626AC5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556997; cv=none; b=FpM63bp5BoffQT7NslcaUFGfVOjuFj3El7L5yqhQs1iRGIHXwLeZhIv8xu36OdZP/iHsaveE2Z9lJqYwme+ZLOdKxkKgiy28pxo5+GWMx5dafWwSMadoh4PcRozaPaUy6uvLbH8wsZNrf0HN6evmsshJXMYRSPIzkvfKljZ9ttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556997; c=relaxed/simple;
	bh=RGEswW5Ce6vNo5M85hhGX5qXpWrqs+b9fbLWpHzi4Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBz6nQsdKoIuUmkBid+2sgY3wdmvYnlRJcXsAJzCUriuTuSyGOphuUkOr7vw/N0q5xWsIxk0d4BuiPoftR4+rGxzjTVXgBsD6fv2Z6/yz5SUmdJ9xHE24H2e2pIroC5+Td1o7w6ljVD9xmEV78WpnAGq9ctXKzKsbN4jvTctHiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grXSKXef; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711556994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M4rxMpnXMLbpb7ThAdJkaBiDjEcFmPFeT+FHTkLwy/4=;
	b=grXSKXef4HSvcf5jsaTwbxOWAe20HvsHXW7iPWpU3YsWjMOgj71icldjeANO1TnazlvUDk
	01wB4Hdh/eLuCwsWzw+PkG15L3L7KSBURG+oHHsSghHk3Ktjb5cCQjJgLEFdPS8IQexibu
	GmC/6yV1cjVASjCVp/kVnzqKEbDR4KM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-DRUTmFIRPqiw-vKIvQKKRQ-1; Wed, 27 Mar 2024 12:29:53 -0400
X-MC-Unique: DRUTmFIRPqiw-vKIvQKKRQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso209575e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711556992; x=1712161792;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4rxMpnXMLbpb7ThAdJkaBiDjEcFmPFeT+FHTkLwy/4=;
        b=wdPQc6UfWz4PlzLOGpLiBLzxwwW7w4DWbJdWe8ZWg4srbUZ1QVBbYDtDA1n+Aar3YI
         GNF0HaXIzwpQHPWhGkWa8NTpSECQCB0sM+GzRIGGXHzTfLvqWcMQZY2QtYenxU4iTcKS
         b0g4yS+3/qFhmgaGZj2SWem6bglRkYCkvbk3Eveoy9lIv1A3Of7+Q7PNArV+sk0wglTT
         wxZRm2y1iBx4qcNlzIpg06N3OI6Aerm8dS6Y8uAg2ryLVSCRLZd4yaxSdzm6fBeZ4TWd
         D6I10yspFTR6yCH5Bz2T8AuKrnhDzOeAudRxEAu0FyntkaD3KbPoV8bwaApHlWKWV2t0
         Pj9g==
X-Forwarded-Encrypted: i=1; AJvYcCX+nYQOm4qEvXYAugb5WgJihqowZqou2gm6AmQT7PgHRrWhV0cZfyV3p6Ng9uMhZbrkfZmtwuY32qx0T98ySTb3iKEnmeOtxdw2rkRK
X-Gm-Message-State: AOJu0YwsGZWm+SXot4QFQpVy7nfI6TRmiwvShMxLk4m9LSFJb6U+xKHO
	MA3Llvw8aviyPZFJ/yOZeLapZXGj9geFNy59M6tZw59Mqnzd5MLDqCrZhe5XOMlHSRnct0r5+5A
	NnFn0PjBetHXJt+MLv5uI4QQNHDlRhzBOmT4RJ2Hwc8ipui8knCG2IBAqrlDx1w==
X-Received: by 2002:a05:600c:470b:b0:414:5e9b:804b with SMTP id v11-20020a05600c470b00b004145e9b804bmr74167wmo.10.1711556992191;
        Wed, 27 Mar 2024 09:29:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSCXZ53JROr0nCITgw1WUov2ckvtk7AUci8w0b/kf7R2Msj3EdctXAR1ScBqukw9FowgXiRw==
X-Received: by 2002:a05:600c:470b:b0:414:5e9b:804b with SMTP id v11-20020a05600c470b00b004145e9b804bmr74140wmo.10.1711556991728;
        Wed, 27 Mar 2024 09:29:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8a00:362b:7e34:a3bc:9ddf? (p200300cbc7088a00362b7e34a3bc9ddf.dip0.t-ipconnect.de. [2003:cb:c708:8a00:362b:7e34:a3bc:9ddf])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b0041490467febsm2607327wmo.38.2024.03.27.09.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 09:29:51 -0700 (PDT)
Message-ID: <b34e01dd-1c30-4f90-95b3-d58ef68b6ed1@redhat.com>
Date: Wed, 27 Mar 2024 17:29:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] mm/migrate: split source folio if it is on deferred
 split list
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Yin, Fengwei" <fengwei.yin@intel.com>, SeongJae Park <sj@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240326150031.569387-1-zi.yan@sent.com>
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
In-Reply-To: <20240326150031.569387-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.03.24 16:00, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> If the source folio is on deferred split list, it is likely some subpages
> are not used. Split it before migration to avoid migrating unused subpages.
> 
> Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")
> did not check if a THP is on deferred split list before migration, thus,
> the destination THP is never put on deferred split list even if the source
> THP might be. The opportunity of reclaiming free pages in a partially
> mapped THP during deferred list scanning is lost, but no other harmful
> consequence is present[1].
> 
>  From v5:
> 1. Fixed an error in migrate_misplaced_folio() reported by Baolin Wang[3].
> 
>  From v4:
> 1. Simplify _deferred_list check without locking and do not count as
>     migration failures. (per Matthew Wilcox)
> 
>  From v3:
> 1. Guarded deferred list code behind CONFIG_TRANSPARENT_HUGEPAGE to avoid
>     compilation error (per SeongJae Park).
> 
>  From v2:
> 1. Split the source folio instead of migrating it (per Matthew Wilcox)[2].
> 
>  From v1:
> 1. Used dst to get correct deferred split list after migration
>     (per Ryan Roberts).
> 
> [1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C817C@nvidia.com/
> [2]: https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infradead.org/
> [3]: https://lore.kernel.org/linux-mm/df9a644c-a007-46ac-98e3-61d4014fcfff@linux.alibaba.com/
> 
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/migrate.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 1dbe5bd927de..a31aa75d223d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1652,6 +1652,29 @@ static int migrate_pages_batch(struct list_head *from,
>   
>   			cond_resched();
>   
> +			/*
> +			 * The rare folio on the deferred split list should
> +			 * be split now. It should not count as a failure.
> +			 * Only check it without removing it from the list.
> +			 * Since the folio can be on deferred_split_scan()
> +			 * local list and removing it can cause the local list
> +			 * corruption. Folio split process below can handle it
> +			 * with the help of folio_ref_freeze().
> +			 *
> +			 * nr_pages > 2 is needed to avoid checking order-1
> +			 * page cache folios. They exist, in contrast to
> +			 * non-existent order-1 anonymous folios, and do not
> +			 * use _deferred_list.
> +			 */
> +			if (nr_pages > 2 &&
> +			   !list_empty(&folio->_deferred_list)) {
> +				if (try_split_folio(folio, split_folios) == 0) {
> +					stats->nr_thp_split += is_thp;
> +					stats->nr_split++;
> +					continue;
> +				}
> +			}
> +
>   			/*
>   			 * Large folio migration might be unsupported or
>   			 * the allocation might be failed so we should retry

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


