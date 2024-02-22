Return-Path: <linux-kernel+bounces-76312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AC285F583
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2F11F26393
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C4239FF0;
	Thu, 22 Feb 2024 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpc1IHFM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55738FB9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597274; cv=none; b=YaIX+RC5ej9oPAlQwkWUebZv9DdaSYxjZrDVlwJImU1iEUKCBZvBzSRjWjJmVI+mgZgBcdhnK0eJ8BFVdeUNndbp3Uf7H4/uwhbFStprxADqzdGmI6imXp+zFmx7FUf1czs2wXkVReRW69OdxRNjymtV9XYQXmNDZo6dF6GutsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597274; c=relaxed/simple;
	bh=PtIGk5S46KOiNJqZcIIQF1M5p8ykG2K5Ec0HJBPx/vE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EyK5kfpy9fhntY83/uuUNasR1Ju7rKHLE1F39FWECRDM7LJuse3e/8ikjmWtaxKIBYzvw9aAU36GN9ceTKzAmIUwtHgEv2EnO0okQSZ3A0YlsHGa5Zohg6Po8YyKHzZZFooprKWr+WSkERz9ouV5BzhiqsdzGTkdsCKE8XbrZBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpc1IHFM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708597272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lcwqmq+d6xKT8k1pc3qQTHCV2WC3c9SdtMQAG9J3Qr8=;
	b=bpc1IHFMi13EPfr9p66/W4zcaNmaZlcMXY4aTZqWO20ZW6ACShrkdXDalF4rylE6QFDRNC
	NCBrq1bK0IyL3lUS3qeaog2McTgY6iZfNgB7nhATZeEL1ZDO9g6J/re0esV/sWP1xb4ssa
	Tua7zSlp4BNcHoExsplP1n+iWXnRaC8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-caB5u68FNsicmtRet2THUg-1; Thu, 22 Feb 2024 05:21:10 -0500
X-MC-Unique: caB5u68FNsicmtRet2THUg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-512add274bfso1111716e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597250; x=1709202050;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lcwqmq+d6xKT8k1pc3qQTHCV2WC3c9SdtMQAG9J3Qr8=;
        b=ftMZuxARjjW047r0IRxqXAKa0rOtgaRf2apUnLqklMuUq6RdiU2qWRJTRTf36vyUGq
         r7/53Y5cyvUidmcDI6JJ+PkpsIFp+MtQE2HIDntiYOBW/aT1aX4ktzLufaJT14yVj5ml
         2ovR3r5vgid2w1u2tHay+1nPh0tt3j+Jr+I4HueEw9pejfnlpGWiTF4A0RbiJgBVSStp
         EN63pS3QkO4uliHHH+6bMGg6wVvrFNJCCRSfE4JebGdMm/wA9pPWSEgacZHUHsM2HXen
         oMHLjW3JqVVDOqyOpkExRq6sRGuq+J9u5mpPWDGm090r3XHrvMYvI3I+k5SkPFGNjbhW
         t/mA==
X-Gm-Message-State: AOJu0YzpMEsIGhI8NelXSFWH99Jff1XjJU6sg6kgCIZ/5Uoj7IJ2trms
	5RVIuM4YFzqrJLnQ/mclb/d9EOPKjxXHe/zw0XBQbtHtdpxqX5apmbCYZ1M7/BQbqQxSfDGLryR
	pZny20pbKUFGHJsbYp7rcLXUx8c1KmLB2Gdq8d/qOpfw5JCJEZnA/8H4/orxlFQ==
X-Received: by 2002:ac2:4893:0:b0:512:9e78:998c with SMTP id x19-20020ac24893000000b005129e78998cmr8731716lfc.9.1708597250164;
        Thu, 22 Feb 2024 02:20:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZGHDJwTeoaSkxVBGscC/OhuKuPQZf4f5Gqv2aI1oHCnc5cOR7OlCp5eekB6/sFE3drryEiQ==
X-Received: by 2002:ac2:4893:0:b0:512:9e78:998c with SMTP id x19-20020ac24893000000b005129e78998cmr8731700lfc.9.1708597249777;
        Thu, 22 Feb 2024 02:20:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:8b00:ed48:6d18:2152:1cda? (p200300cbc70f8b00ed486d1821521cda.dip0.t-ipconnect.de. [2003:cb:c70f:8b00:ed48:6d18:2152:1cda])
        by smtp.gmail.com with ESMTPSA id a10-20020a05600c224a00b004128da16dddsm185325wmm.15.2024.02.22.02.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:20:49 -0800 (PST)
Message-ID: <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
Date: Thu, 22 Feb 2024 11:20:48 +0100
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
From: David Hildenbrand <david@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20231025144546.577640-2-ryan.roberts@arm.com>
 <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
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
In-Reply-To: <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.02.24 11:19, David Hildenbrand wrote:
> On 25.10.23 16:45, Ryan Roberts wrote:
>> As preparation for supporting small-sized THP in the swap-out path,
>> without first needing to split to order-0, Remove the CLUSTER_FLAG_HUGE,
>> which, when present, always implies PMD-sized THP, which is the same as
>> the cluster size.
>>
>> The only use of the flag was to determine whether a swap entry refers to
>> a single page or a PMD-sized THP in swap_page_trans_huge_swapped().
>> Instead of relying on the flag, we now pass in nr_pages, which
>> originates from the folio's number of pages. This allows the logic to
>> work for folios of any order.
>>
>> The one snag is that one of the swap_page_trans_huge_swapped() call
>> sites does not have the folio. But it was only being called there to
>> avoid bothering to call __try_to_reclaim_swap() in some cases.
>> __try_to_reclaim_swap() gets the folio and (via some other functions)
>> calls swap_page_trans_huge_swapped(). So I've removed the problematic
>> call site and believe the new logic should be equivalent.
> 
> That is the  __try_to_reclaim_swap() -> folio_free_swap() ->
> folio_swapped() -> swap_page_trans_huge_swapped() call chain I assume.
> 
> The "difference" is that you will now (1) get another temporary
> reference on the folio and (2) (try)lock the folio every time you
> discard a single PTE of a (possibly) large THP.
> 

Thinking about it, your change will not only affect THP, but any call to 
free_swap_and_cache().

Likely that's not what we want. :/

-- 
Cheers,

David / dhildenb


