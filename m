Return-Path: <linux-kernel+bounces-76493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D8485F7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F9C1F23F29
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938965FBA2;
	Thu, 22 Feb 2024 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SuYUAoe5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF53F9ED
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604299; cv=none; b=PkaE6zoW26L76yVCeeraEvNygFoyzUApt89w1LfE0wZZ98IBR4jTNRPe4IFMRf4c8Qv7XWukbByaWyYoQlZaDGg3ddoUtgv8Rt2wHWWdfA2j3WJbi0O5F/H/PJE4AGJEUHw/tM7iI/OUyi8R4yvZLb+2f3RmENrjBZzWX6Dswmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604299; c=relaxed/simple;
	bh=heY5PyFX66DGVo8eroTOK+ti0ayulXHdi5EoXeD5eoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFLGgXzgRB8BLhavUuFOQn0aCheO4AZrpSVWORV1pF8ptj2gSLqVgxwaly9+Ewh06CblxYPWekodFcb0wVPn7CDnWq4LnO5sJtcfdOTIZjrxUdqEKqpGMq2CkAXoDsDU4RcUjoPGbBpTOSkhyDbpS1wmId9NGPDubGOB6otN1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SuYUAoe5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708604297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EdnZ/tISf7uhavPmNsJeywz3qi5pqyubnDXQIOuEkHw=;
	b=SuYUAoe5PDQkE2mqgshSN5wVKKvGMX7P+lqDz5bZyiM+LDkYenotNanZEqR0057Il3FUoc
	UivbQRnnRlcZO/9753R4gw2AtKcKDoc+eIx2/0kT4IT3U/MDs1pjsI+7hjI9uhsKd8EIWP
	ZAJfI2vTfggJ1N9d6O+RBxUtRkhGT1o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-xBEEGttEM5qPGASn_pJG6g-1; Thu, 22 Feb 2024 07:18:13 -0500
X-MC-Unique: xBEEGttEM5qPGASn_pJG6g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d19ac07c5so805934f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708604292; x=1709209092;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdnZ/tISf7uhavPmNsJeywz3qi5pqyubnDXQIOuEkHw=;
        b=eMpgsZutElpGjLiXAYi69+VgLoGNYqmzIYGqMzJ3d/JtHrWLR2HkWlYTJSnSZjaYF1
         ANfusEGw8GWfqAdP8/fwxUjoxXkq/vQQH9Kpcc1sn0OnVBLXophcFJA09XLIkVq0v8DS
         x9VrMHzkNiHl9ibwMEqTmmaJpgxd6FRr8eZV5vIvZZCTfx/rCwo7KeL309xpumGj+x5k
         oNTKCNEMcn68gK5Gi9Ss/D2rM5K2F8k7yvjf4iDNoGJHJ59PdXgD51sPHCogm9wX6X6Q
         oGSJ9AUKRO0gUWZyoBcV9a9bibePb/aIBkRdBn8PlfI24VoczqNMnQ3/27URrfdH+gyO
         zunQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbRW2tz+EIGjodbdq82G2KexSPcVgwWtzfGpDcjv26V8F8XpBur1DonWLwNQWOUZeBRWkRPBVJJDEl92wKWzAnY214g6S4UksumYTq
X-Gm-Message-State: AOJu0YxPRja1guU5RIlsXEJJTlyfXoOBp2byWUUK1W2kFlkCMp1TkJPH
	c+8M+KRxUnNv6WOpa5kgWnkOF/TQ5rod87zUSujNDHFQ+G2oDWET3IKMVI46VL19Z5vDNQw8hpq
	T3PF0sL1BM4F4Rb5ElOaoaQHQ76GIZdFlCEPrDV+bodS0SsajiCifuSWVSKTH0w==
X-Received: by 2002:a05:6000:dce:b0:33d:8d4c:fd36 with SMTP id dw14-20020a0560000dce00b0033d8d4cfd36mr976465wrb.14.1708604292616;
        Thu, 22 Feb 2024 04:18:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtcaE3zpcInLE0a2czLvpKNM24d6BsU/jdibnw8kBZbCm/3ojumosvk4ijTb/QirO0/Z/JEg==
X-Received: by 2002:a05:6000:dce:b0:33d:8d4c:fd36 with SMTP id dw14-20020a0560000dce00b0033d8d4cfd36mr976447wrb.14.1708604292127;
        Thu, 22 Feb 2024 04:18:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:8b00:ed48:6d18:2152:1cda? (p200300cbc70f8b00ed486d1821521cda.dip0.t-ipconnect.de. [2003:cb:c70f:8b00:ed48:6d18:2152:1cda])
        by smtp.gmail.com with ESMTPSA id bj13-20020a0560001e0d00b0033d926bf7b5sm1847887wrb.76.2024.02.22.04.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 04:18:11 -0800 (PST)
Message-ID: <1547a955-cee6-40e1-8231-0bd1229de0f3@redhat.com>
Date: Thu, 22 Feb 2024 13:18:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/util.c: Added page count to __vm_enough_memory failure
 warning
Content-Language: en-US
To: Matthew Cassell <mcassell411@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240221160235.1771-1-mcassell411@gmail.com>
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
In-Reply-To: <20240221160235.1771-1-mcassell411@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.02.24 17:02, Matthew Cassell wrote:
> Commit 44b414c8715c5dcf53288 ("mm/util.c: add warning if __vm_enough_memory
> fails") adds debug information which gives the process id and executable name
> should __vm_enough_memory() fail. Adding the number of pages to the failure
> message would benefit application developers and system administrators in
> debugging overambitious memory requests by providing a point of reference to
> the amount of memory causing __vm_enough_memory() to fail.
> 
> 1. Set appropriate kernel tunable to reach code path for failure
>     message:
> 
> 	# echo 2 > /proc/sys/vm/overcommit_memory
> 
> 2. Test program to generate failure - requests 1 gibibyte per iteration:
> 
> 	#include <stdlib.h>
> 	#include <stdio.h>
> 
> 	int main(int argc, char **argv) {
> 		for(;;) {
> 			if(malloc(1<<30) == NULL)
> 				break;
> 
> 			printf("allocated 1 GiB\n");
> 		}
> 
> 		return 0;
> 	}
> 
> 3. Output:
> 
> 	Before:
> 
> 	__vm_enough_memory: pid: 1218, comm: a.out, not enough
> memory for the allocation
> 
> 	After:
> 
> 	__vm_enough_memory: pid: 1141, comm: a.out, pages: 262145, not
> enough memory for the allocation
> 
> Signed-off-by: Matthew Cassell <mcassell411@gmail.com>
> ---
>   mm/util.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 5a6a9802583b..c0afb56f16ea 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -976,8 +976,8 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
>   	if (percpu_counter_read_positive(&vm_committed_as) < allowed)
>   		return 0;
>   error:
> -	pr_warn_ratelimited("%s: pid: %d, comm: %s, not enough memory for the allocation\n",
> -			    __func__, current->pid, current->comm);
> +	pr_warn_ratelimited("%s: pid: %d, comm: %s, pages: %ld, not enough memory for the allocation\n",
> +			    __func__, current->pid, current->comm, pages);
>   	vm_unacct_memory(pages);
>   
>   	return -ENOMEM;

I wonder if "bytes"/"kbytes" instead of pages would be more appropriate 
here.

Often, this will fail due to mmap() [where we pass a size from user 
space] and also "vm.overcommit_kbytes" is not in pages.

-- 
Cheers,

David / dhildenb


