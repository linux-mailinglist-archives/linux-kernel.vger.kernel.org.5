Return-Path: <linux-kernel+bounces-140705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7678A1800
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C788B24667
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9F6E567;
	Thu, 11 Apr 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cI0mTFyI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61626EAF0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847629; cv=none; b=nAm3l8y+3nLvmRmOofWd4ODUAuGdY5/VUfL2cMvJoeRfqRmFCBidw5V36jwgl7ydJDN3Kl92W1wJA3ofOZWJb0crtD5NfUts/BC6jk2hbrDWWxOfOphdTUlMb7jLFAXJ0M50C3RW9NoeW523RnOXTGFKbjOIReeiXZ3cviyVQTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847629; c=relaxed/simple;
	bh=ed2IvFngNHDU0Di22/rRxs5B3eDZtbet3VhCQGQdjeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T91dylyft43x39mQST/OE8NfyEEVaAQBc6L1LdDCayeE9/yfUBzFU8I2Kbp9EjZ9Fda7g2Vkz+X9EyjrjbKt4tU4bE02PU3FYncslE3uLSXgpb9bwdke1lyHbiwJXhmXNTzAf4TBcQRz2JytmuQSQ5p7vZLYIAaguQsYFlDjjuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cI0mTFyI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712847627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sq04QCIHSO2/rjx13aYOGeEQxe2Gyi/wBqeQq9TfDNg=;
	b=cI0mTFyIUjP0LZyR3sWuFd2gL4DEjF+vtQ515ua/Ey9vEYuGjrhypGk72T81JRA+PALQPf
	KscUO38wtVJx+TUF0VVKSFyHzCh8CiubjkeuUKBcn+qp2EJl2ZjzEvFjKzxg0xEeiEuTFq
	gaGNxHd2XbZPo9i+fI27N/Ju2/IW9Ew=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-Xi7oZsxxN0qV8QP_GQSzDw-1; Thu, 11 Apr 2024 11:00:25 -0400
X-MC-Unique: Xi7oZsxxN0qV8QP_GQSzDw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-516cfff88deso4889215e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712847624; x=1713452424;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sq04QCIHSO2/rjx13aYOGeEQxe2Gyi/wBqeQq9TfDNg=;
        b=LeWBKBsAjZau1Bf50fR7zTzxc+ayNjOgf3B4jNxLhwc/aM4wGwc98J7/5VNieFGbGT
         A30KsgNWhf/tb/PdcXFQEvBElFRtDH2KHIWxXkV9pCb+7LmslnYFcF/qwzlYJkPydkvy
         AyleqaNMdQ67oxvW8H0UvRulBxr4K/l7VcW9xBEo9HbxxOUuZRVni8TIZMvkO94UxHxV
         wSrm/weWsUhGdkh3g7oK93y5qH0IM/NqoprXjK/oiMPkzVfPtbTjKXtnJgx4PODK4T/K
         RYHO3bPdoWysbtym4sXrXio9x0I7RIJHrlYJ6FFsZzvQhB4+2k4o77H7Xxuh3JhB02Mw
         Hr+g==
X-Forwarded-Encrypted: i=1; AJvYcCWx49OcQueYH7LJk1+oVQxnFIrbcQgpwAMplJ7OQQt6npkQ5tig+wFe7Dix89o9JS/kE6NmF6DujQj4ygdaDWCV+VeaW0FgnfeBMnl0
X-Gm-Message-State: AOJu0Yyo3Ac9e3ZcgxRkEH2NEz8ATZXJHUmHJ0Ot7NatOASuPrZ9/XsR
	BoQzMvMp/Q3cPl0bh/M1+GAUM8mY7IXJRkOOcZwRTeLuD6a2yKflz+T3FcpQCtq4WPgsZwVxcWd
	+WJv6PdHbebeFy7OhnacfjVY2mgP+9xdA5vwbpkKED5YncOf3TPYefTVOQDgKLQ==
X-Received: by 2002:a05:6512:ad0:b0:518:6d46:a39e with SMTP id n16-20020a0565120ad000b005186d46a39emr1048022lfu.42.1712847624260;
        Thu, 11 Apr 2024 08:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnvf09190Wa6fQ8E3ycep+zG/BHglEbtRd1UZD5VmxzDozsM+O/c0H8xHubfEfCUC4vdiPSQ==
X-Received: by 2002:a05:6512:ad0:b0:518:6d46:a39e with SMTP id n16-20020a0565120ad000b005186d46a39emr1047978lfu.42.1712847623722;
        Thu, 11 Apr 2024 08:00:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:4300:430f:1c83:1abc:1d66? (p200300cbc7244300430f1c831abc1d66.dip0.t-ipconnect.de. [2003:cb:c724:4300:430f:1c83:1abc:1d66])
        by smtp.gmail.com with ESMTPSA id g2-20020adff3c2000000b00343300a4eb8sm1972637wrp.49.2024.04.11.08.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 08:00:23 -0700 (PDT)
Message-ID: <a5a55919-46bc-4107-a0fc-14dc404e8c90@redhat.com>
Date: Thu, 11 Apr 2024 17:00:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: swap_pte_batch: add an output argument to
 reture if all swap entries are exclusive
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com,
 hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com, linux-kernel@vger.kernel.org
References: <20240409082631.187483-1-21cnbao@gmail.com>
 <20240409082631.187483-4-21cnbao@gmail.com>
 <744f795b-7ce8-40ab-911b-60906aa4fed1@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
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
In-Reply-To: <744f795b-7ce8-40ab-911b-60906aa4fed1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.04.24 16:54, Ryan Roberts wrote:
> On 09/04/2024 09:26, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> Add a boolean argument named any_shared. If any of the swap entries are
>> non-exclusive, set any_shared to true. The function do_swap_page() can
>> then utilize this information to determine whether the entire large
>> folio can be reused.
>>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> ---
>>   mm/internal.h | 9 ++++++++-
>>   mm/madvise.c  | 2 +-
>>   mm/memory.c   | 2 +-
>>   3 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 9d3250b4a08a..cae39c372bfc 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -238,7 +238,8 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
>>    *
>>    * Return: the number of table entries in the batch.
>>    */
>> -static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
>> +static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte,
>> +				bool *any_shared)
> 
> Please update the docs in the comment above this for the new param; follow
> folio_pte_batch()'s docs as a template.
> 
>>   {
>>   	pte_t expected_pte = pte_next_swp_offset(pte);
>>   	const pte_t *end_ptep = start_ptep + max_nr;
>> @@ -248,12 +249,18 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
>>   	VM_WARN_ON(!is_swap_pte(pte));
>>   	VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));
>>   
>> +	if (any_shared)
>> +		*any_shared |= !pte_swp_exclusive(pte);
> 
> This is different from the approach in folio_pte_batch(). It inits *any_shared
> to false and does NOT include the value of the first pte. I think that's odd,
> personally and I prefer your approach. I'm not sure if there was a good reason
> that David chose the other approach?

Because in my case calling code does

nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr, flags,
		     &any_writable);

..

if (any_writable)
	pte = pte_mkwrite(pte, src_vma);

..

and later checks in another function pte_write().

So if the common pattern is that the original PTE will be used for 
checks, then it doesn't make sense to unnecessary checks+setting for the 
first PTE.

-- 
Cheers,

David / dhildenb


