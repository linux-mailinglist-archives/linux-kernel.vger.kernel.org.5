Return-Path: <linux-kernel+bounces-163948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE288B7677
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ACAAB22C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B8B172798;
	Tue, 30 Apr 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpYqt1EW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70368171666
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481834; cv=none; b=awrD7QJxn/rJPtVgkqPaz8SmL4Q4dAR5QhBSJuzazokLf0CKkmav25NkdRnZOffGAFwuyoIMgvO1R67+zS7u8Boe8woSQwfif+YyizSUyTy3ULkVXRGpauB1FomggnT84isRlGXB455nRfqTVRZTErlViEmL0cki3nCUkVt7Tuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481834; c=relaxed/simple;
	bh=GNB0r3YZq7BtghesKQkk1nzVaDSGh6Yeyn7IYZynCUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K70eYVbGGDLc4vRlbjX8lZp8RASMWWbKuHz+9a62ptHp+Op6wVb00g2uTDL9rkl1Iaxje9sgWp6TTECftVgkoI0ilyUOHFqrKVjhhy9O5UzNKkx4NxoBPNcrIHXnhvuPCUTTUwRPLKyMZJ1OsgwSzV4TY8GJbvBfAwv747ir1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpYqt1EW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714481832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tdmWCPpmVqkWt86tR0W6U1iJvD4JBKCQgQGu1erF8SY=;
	b=dpYqt1EWfnVLnvEgJ2CXUJsmaQOuX9OxjsEHoxSnfkswjprX05f2FnweEuILwbAYbsJ10T
	mgMcKtE6tpa7lGtT9ASjOwat82CbtjQcQzHMSHJ9qq8JgrygUy7ja7nDQCQUwnh3wsOYBw
	pANSrgO5JfQ7OoOmg1PCzUjqL2OU/lg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-d478Hn_KPAWC8M9C12Cn2A-1; Tue, 30 Apr 2024 08:57:09 -0400
X-MC-Unique: d478Hn_KPAWC8M9C12Cn2A-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d87ba1f5e0so50363431fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481827; x=1715086627;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdmWCPpmVqkWt86tR0W6U1iJvD4JBKCQgQGu1erF8SY=;
        b=YH3RfUotMz8pb0Xt1f5GKtjn1ov3OjXuF/LAjqxZgpKK8b7GJ/II9Tbmy5YjrJZs2R
         PqfXFF2Gs6Vb6KMpfnp7WjFxi147ReUdVVg6nneKUmLDnzlwWqjQnx9DhvEXN7I3O4eh
         F1Hg7m0Ia1HKuRuWEfQ341MGhGq9yg0Rvrym/4490j4M95s3WBbNcGljfpZqSVv34JOT
         RiNmlNibt8UzoIPawAMWpu3r7bUTv5pn4G/QbQT0xzDLwJHeTuTV7iWuxNsnkQTdV+Fj
         S/M3KolB7ohHdvF2rjy8O9r6MVa36r6nEAgfXe9mNBB0R9qIA7UaqOi94EO4oXJ40xqz
         3UNw==
X-Forwarded-Encrypted: i=1; AJvYcCWL0BFuWx/q2+1gzIBDwvURoxkgsidvF5NhvKBeUjsUOOI1xU2BKdqVJj+7SQ9TrW1yQDdVNCz+GWj2jGWW+YiKXzHZxbnFtCljdulJ
X-Gm-Message-State: AOJu0Yzdcz2zEp2MlkRZDl90p5Z+62AXz3bML9Nxls1CW6w9ssP2RRMR
	2qMlabZYN6W0Nw/ezviJGSSiJQspy9p29gEgo3xcstgW4FIgEAPEUbhqnD4LEh39OMsmZ2x3/gO
	aMhJ9JE4xBUu0M5QH3bBpbx+AEiSn1mIzQc0HWdM73yXt7SMnWsJd0nBmOCy96w==
X-Received: by 2002:a05:651c:1203:b0:2df:b800:5bff with SMTP id i3-20020a05651c120300b002dfb8005bffmr1950518lja.7.1714481827491;
        Tue, 30 Apr 2024 05:57:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA9aBhSm3Z+YoODJcL3qGk7/YolGF5A4cU9eyC5WpAQQZTSVCRHwNLK+yS5LAnJY/RSv4gIQ==
X-Received: by 2002:a05:651c:1203:b0:2df:b800:5bff with SMTP id i3-20020a05651c120300b002dfb8005bffmr1950507lja.7.1714481827073;
        Tue, 30 Apr 2024 05:57:07 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id r6-20020a2eb606000000b002d6eee825bbsm3933124ljn.133.2024.04.30.05.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 05:57:06 -0700 (PDT)
Message-ID: <2e074a0b-7ab6-4381-9216-31f68a738a07@redhat.com>
Date: Tue, 30 Apr 2024 14:57:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm/ksm: rename mm_slot_cache to ksm_slot_cache
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 izik.eidus@ravellosystems.com
References: <20240428100619.3332036-1-alexs@kernel.org>
 <20240428100619.3332036-3-alexs@kernel.org>
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
In-Reply-To: <20240428100619.3332036-3-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.04.24 12:06, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> To distinguish ksm_mm_slot and mm_slot for better code readability,
> rename mm_slot_cache as ksm_slot_cache. No function change.
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>   mm/ksm.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 6efa33c48381..22d2132f83a4 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -247,7 +247,7 @@ static struct ksm_scan ksm_scan = {
>   
>   static struct kmem_cache *rmap_item_cache;
>   static struct kmem_cache *stable_node_cache;
> -static struct kmem_cache *mm_slot_cache;
> +static struct kmem_cache *ksm_slot_cache;
>   
>   /* Default number of pages to scan per batch */
>   #define DEFAULT_PAGES_TO_SCAN 100
> @@ -502,8 +502,8 @@ static int __init ksm_slab_init(void)
>   	if (!stable_node_cache)
>   		goto out_free1;
>   
> -	mm_slot_cache = KSM_KMEM_CACHE(ksm_mm_slot, 0);
> -	if (!mm_slot_cache)
> +	ksm_slot_cache = KSM_KMEM_CACHE(ksm_mm_slot, 0);
> +	if (!ksm_slot_cache)
>   		goto out_free2;
>   
>   	return 0;
> @@ -518,10 +518,10 @@ static int __init ksm_slab_init(void)
>   
>   static void __init ksm_slab_free(void)
>   {
> -	kmem_cache_destroy(mm_slot_cache);
> +	kmem_cache_destroy(ksm_slot_cache);
>   	kmem_cache_destroy(stable_node_cache);
>   	kmem_cache_destroy(rmap_item_cache);
> -	mm_slot_cache = NULL;
> +	ksm_slot_cache = NULL;
>   }
>   
>   static __always_inline bool is_stable_node_chain(struct ksm_stable_node *chain)
> @@ -1244,7 +1244,7 @@ static int unmerge_and_remove_all_rmap_items(void)
>   			list_del(&ksm_slot->slot.mm_node);
>   			spin_unlock(&ksm_mmlist_lock);
>   
> -			mm_slot_free(mm_slot_cache, ksm_slot);
> +			mm_slot_free(ksm_slot_cache, ksm_slot);
>   			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
>   			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>   			mmdrop(mm);
> @@ -2713,7 +2713,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   		list_del(&ksm_slot->slot.mm_node);
>   		spin_unlock(&ksm_mmlist_lock);
>   
> -		mm_slot_free(mm_slot_cache, ksm_slot);
> +		mm_slot_free(ksm_slot_cache, ksm_slot);
>   		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
>   		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>   		mmap_read_unlock(mm);
> @@ -2972,7 +2972,7 @@ int __ksm_enter(struct mm_struct *mm)
>   	struct mm_slot *slot;
>   	int needs_wakeup;
>   
> -	ksm_slot = mm_slot_alloc(mm_slot_cache);
> +	ksm_slot = mm_slot_alloc(ksm_slot_cache);

Similarly, this makes the code more confusion. The pattern in khugepaged 
is similarly:

mm_slot = mm_slot_alloc(mm_slot_cache);

I don't think we want these renamings.

E.g., "ksm_mm_slot_cache" might be a bit better than "mm_slot_cache". 
But then, we are in KSM code ... so I don't really see an improvement.

-- 
Cheers,

David / dhildenb


