Return-Path: <linux-kernel+bounces-132552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612D0899687
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C191F22DD0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154DA37142;
	Fri,  5 Apr 2024 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2ay7Q47"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE11364D2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302119; cv=none; b=a0Zps9S4XSNnAFiDjRaoOIKHBm1kh2a1Rh2HrEpRBa+Vqxy78KDdkDgz9xEKyBXx4yMHexvD57BJvtjR4v4nXpv/zxxi5d2wRoiIEuTpWbB4tlJJFXkftwe9p4apwIR4R3SQrBcpckpWk4QXOI22ouOs/u3gKUYSvh1dQjzxiEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302119; c=relaxed/simple;
	bh=P1vIwmHzFZpAH/IbSjNsKHPKCXgppogvNvEMvp1eEDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCM5IesF9gdDwbPqN6O9n8bNn/6ExYqISvk8OpybmN6SPdkIkBmWFUuPrTtOq56MQY+lXoPHWDnGEt3rfrEJkawoLz0A56kt04ihetYa+v025CiO9JcVvD2w3plgnLebYTWyBsSx7v6c/dmiQdC0C54McZBXmCi7GzxoiofI5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2ay7Q47; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712302116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=82z78k3qbBNXb5WziufgS3SHGhfcfQ7Rm3h2BYxo3yc=;
	b=G2ay7Q47QB4AYBQSH4doqvQi3ZyGYeDI1BNFZZXcE0BR2hAvtTJgnzGyGj9Qpk4HWdf7Hh
	6psLYFwBpFrXjfVzsHkfa7pJCQnIbBTo75S4ofZVODmoeWX9u9990XnWF6yCa43xwC2OdM
	byT4cFMbkswh/W1Hnp244LtCylHiz58=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-1gnxgLSDMqK55rr1HPclYQ-1; Fri, 05 Apr 2024 03:28:34 -0400
X-MC-Unique: 1gnxgLSDMqK55rr1HPclYQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d86005189eso11073371fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712302113; x=1712906913;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82z78k3qbBNXb5WziufgS3SHGhfcfQ7Rm3h2BYxo3yc=;
        b=oAObPFVsAVtwHSkui2ASSlUERsXOZOwQcOrd1mQJLFAv/RAEnUd1yJbDnMuYC2BrU6
         0ImRosS1Th7Dm4GVfL8IoP3qIHP60IcQxk7//smF5CwDPJHcfntIC0HAmipd9cvCSpeh
         W/MjRWZZ6OSL75dKqYx706UHnCKoU25zOo+wXNLvti0C22kSC95eEDwyOuUJKAqbwEd6
         WgL7JhAwEZix3CXd9w7AVd/7nIXNiPSjsYkspbZnXBkbNXZ98BX7uWzSVNicAGjd9rzf
         rWA941Zrkh0OPFH7IFZ9CHK6PgGbgZRwEA9eU1PcoeSd8rXYlJ0/NYbmX7PxysSb886Q
         HGow==
X-Forwarded-Encrypted: i=1; AJvYcCVKSf7rCLpQgN4nwMPypjDA9nVFc4QjK1CUIxGfUYQLDyEAL1zRLp4jVYBlxlqxFGIGDqrE8VrKsx4xWhFy/oIEVq8nGsJxtiOsQE3e
X-Gm-Message-State: AOJu0Yx+NGvS3EvgExOME5GqGqAOPtHpuGAksyzpjpR+mNaLUtvaa5dU
	TuaNgyXNyI/qrCQdDJ07ipQqWReGyXgYnCZ3CI7UawNUT4OwepKh7vuYqXXZDKRe/gW8+5DC8Zt
	vXhwJoqE41pmnARgceexPmuAxKsxnKBxIBbmZPt6KwWD8hJLvDe8eUhFmxxfdFg==
X-Received: by 2002:a2e:8958:0:b0:2d2:4783:872a with SMTP id b24-20020a2e8958000000b002d24783872amr591985ljk.29.1712302113084;
        Fri, 05 Apr 2024 00:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxRT4V7Z+YFyaty0n7nO97PULTc5vJFcQU4EWZVLOkXFwVFzyC1ZQsiOhRX2Blhk7uWNk3gA==
X-Received: by 2002:a2e:8958:0:b0:2d2:4783:872a with SMTP id b24-20020a2e8958000000b002d24783872amr591977ljk.29.1712302112661;
        Fri, 05 Apr 2024 00:28:32 -0700 (PDT)
Received: from [192.168.3.108] (p4ff2306b.dip0.t-ipconnect.de. [79.242.48.107])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c488a00b004161ea7ed6dsm5266303wmp.38.2024.04.05.00.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 00:28:32 -0700 (PDT)
Message-ID: <a23738db-5966-4a37-9500-2e06cadcae8b@redhat.com>
Date: Fri, 5 Apr 2024 09:28:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] mm/ksm: use ksm_get_folio in
 scan_get_next_rmap_item
To: alexs@kernel.org, Matthew Wilcox <willy@infradead.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Izik Eidus <izik.eidus@ravellosystems.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ryncsn@gmail.com
Cc: Hugh Dickins <hughd@google.com>, Chris Wright <chrisw@sous-sol.org>
References: <20240325124904.398913-1-alexs@kernel.org>
 <20240325124904.398913-7-alexs@kernel.org>
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
In-Reply-To: <20240325124904.398913-7-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.03.24 13:48, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> Save a compound calls.
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Chris Wright <chrisw@sous-sol.org>
> ---
>   mm/ksm.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index aa80fbf3a8e0..95a487a21eed 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2611,14 +2611,14 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   		 */
>   		if (!ksm_merge_across_nodes) {
>   			struct ksm_stable_node *stable_node, *next;
> -			struct page *page;
> +			struct folio *folio;
>   
>   			list_for_each_entry_safe(stable_node, next,
>   						 &migrate_nodes, list) {
> -				page = get_ksm_page(stable_node,
> -						    GET_KSM_PAGE_NOLOCK);
> -				if (page)
> -					put_page(page);
> +				folio = ksm_get_folio(stable_node,
> +						      GET_KSM_PAGE_NOLOCK);
> +				if (folio)
> +					folio_put(folio);
>   				cond_resched();
>   			}
>   		}

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


