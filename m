Return-Path: <linux-kernel+bounces-76311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5CB85F580
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13321285A35
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E7D39FDC;
	Thu, 22 Feb 2024 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtTxxUvY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A417BB7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597169; cv=none; b=gG03JqDhYTZSvWuNliPyGeiJO8ZHwX24X5TO8PpvsCyAStX0Ob8HhsANq80eJzx66toze1JdhcJr9XPHE+gPubFRCjEepFNiJxoPC7ZTTQlSdMLNtHSmLQ9yatnB+Bxc5xUfsGqxmK1apnPsHDOYgFsCZ0bZAKHvINcbH7Goc/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597169; c=relaxed/simple;
	bh=Kc0q/2VU//xboB0VLVYzl5beipgTJCTZ9HufFwQW4YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVkBoe89P5mzqfpNWbTZQ2wkDLirIzNVa3YvBQKyQea/x308GfJLty3LyFdOJyFSbKpSsUUYupWsdBeb5NLcpWtDxmV0a9NewpwgzrhoXFdbdF+l8A6SZdDXCpa3Fwt50U+hLDRBs43i5PxTNjcrtrEpf5ZCpmUcfqrIrGwI3UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtTxxUvY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708597166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aN2CoCAXzjDD0pifuFrV69E7GpRNjCsHr9lhDc//c14=;
	b=dtTxxUvY6vQkI5PL4lFjjLTxP0Su276GJ28o1N01QetiZoqkaqWYS7twRUeNzour7HsUji
	Xa0GWSbSAS05nVI4irdNwG5DO9AujhG3wbsLP5bT4mzeYkoUflkFeGEcdid2P3ILokOGSU
	FUInxR4sZoY7iYfZJ7pdOX4LJr1FQXQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-iaBqRFKzNaiBkn4q8NGqoA-1; Thu, 22 Feb 2024 05:19:25 -0500
X-MC-Unique: iaBqRFKzNaiBkn4q8NGqoA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d25a02f48fso10523261fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597163; x=1709201963;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN2CoCAXzjDD0pifuFrV69E7GpRNjCsHr9lhDc//c14=;
        b=Vws89wcNuS/4GHm44i4roo5gsNuBXnD8aBcj8gQ9bJW9OT0hYHIKW+SwAo8xrfgl6Q
         m77VPaUaJdyEc3TrOfZ8yLJ4q3YuUyngzSxpyM2iUB053+mN7EacmUpT+OKeOfdSnL+9
         IUTjm2Xjx3vtw5QpzHOSnPEwK+9t9Ka0sQwC+GjrapEv8LVoDPfWP5wa37gG7LtST/J6
         TfHeKuR8HfstOlOIpYwldU7Y6QF1YXfmQg9KGkyTjORhV2dQs2Jkaadse/8JdLt7jS+L
         HHzxEPp4Td+MqhnpbxqbqKMjiMPEUkSy5Ytoxlu4DqRaOhFDuBaYCv5KEhZEvCxgcmmk
         EdbQ==
X-Gm-Message-State: AOJu0Yx9e030c30U6tx/KbJisNpv1BPkoQzB4dlZh+uR+dTv6dEEZnjb
	XpTD5ao+8ot9K5Opt6m1DYeZU2jtHEwR5xfnqjIIG1upX9NOUU+tqsSeazXegv82ZCdDPA8ApBa
	pC0I/0OE9URraeQRpVUmrf2iBfkLcHC3Gg1DAc2In3emvnnL3J7akEVk2iNDdTA==
X-Received: by 2002:a2e:964a:0:b0:2d2:532f:bdf2 with SMTP id z10-20020a2e964a000000b002d2532fbdf2mr2827529ljh.51.1708597163756;
        Thu, 22 Feb 2024 02:19:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBLRHY/USPLYOTCgsVmAMVFjziJJbZ7u64lgCEmUSGCDYG3txCczGdqjeNiGjsPvptaXoZpA==
X-Received: by 2002:a2e:964a:0:b0:2d2:532f:bdf2 with SMTP id z10-20020a2e964a000000b002d2532fbdf2mr2827506ljh.51.1708597163260;
        Thu, 22 Feb 2024 02:19:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:8b00:ed48:6d18:2152:1cda? (p200300cbc70f8b00ed486d1821521cda.dip0.t-ipconnect.de. [2003:cb:c70f:8b00:ed48:6d18:2152:1cda])
        by smtp.gmail.com with ESMTPSA id a10-20020a05600c224a00b004128da16dddsm185325wmm.15.2024.02.22.02.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:19:22 -0800 (PST)
Message-ID: <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
Date: Thu, 22 Feb 2024 11:19:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20231025144546.577640-2-ryan.roberts@arm.com>
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
In-Reply-To: <20231025144546.577640-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.10.23 16:45, Ryan Roberts wrote:
> As preparation for supporting small-sized THP in the swap-out path,
> without first needing to split to order-0, Remove the CLUSTER_FLAG_HUGE,
> which, when present, always implies PMD-sized THP, which is the same as
> the cluster size.
> 
> The only use of the flag was to determine whether a swap entry refers to
> a single page or a PMD-sized THP in swap_page_trans_huge_swapped().
> Instead of relying on the flag, we now pass in nr_pages, which
> originates from the folio's number of pages. This allows the logic to
> work for folios of any order.
> 
> The one snag is that one of the swap_page_trans_huge_swapped() call
> sites does not have the folio. But it was only being called there to
> avoid bothering to call __try_to_reclaim_swap() in some cases.
> __try_to_reclaim_swap() gets the folio and (via some other functions)
> calls swap_page_trans_huge_swapped(). So I've removed the problematic
> call site and believe the new logic should be equivalent.

That is the  __try_to_reclaim_swap() -> folio_free_swap() -> 
folio_swapped() -> swap_page_trans_huge_swapped() call chain I assume.

The "difference" is that you will now (1) get another temporary 
reference on the folio and (2) (try)lock the folio every time you 
discard a single PTE of a (possibly) large THP.

-- 
Cheers,

David / dhildenb


