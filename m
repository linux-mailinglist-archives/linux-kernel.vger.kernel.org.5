Return-Path: <linux-kernel+bounces-86438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48CE86C55A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68069290080
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849F35E3D8;
	Thu, 29 Feb 2024 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ey5GCIHi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4D5DF36
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199231; cv=none; b=dukNUKGvef+DazvNOWxOxjVySKxbpd3AiCstpOP9UMXJUHiiJouSuwJw5bSKaUQyrENzCh6drqkKWpk0Odp59dNheNbCDRrXqEMc2ND9y954r30GrCbjfMpIAbbPGggBvwbsgZHzzTmyzpT44veyaAQ5noZzQCEyUUh3Ov85clg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199231; c=relaxed/simple;
	bh=0dPMcog9lZNrsCGQo+h+pxVSvS6laozyMU3c9j4dWrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuL0OjH6sbJQKz67Drw564WQu8Za5y02U/w3RF6/1Kl11t0AxiPa/O2FuiMhF8xhwP9qOGZOSY/vLBjgtK1wrThib4zRhwfk1Y7RrnRixUlI3uFl78wWcNY8uKY/PX1Vn3VumP0VgtPfQTKM15ybtnHPtKVWatyMNoBYxMn0OlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ey5GCIHi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709199229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=prefAyBiswb2rkdRNkhVYEjSOkqtek6XfQCd+pZ1+gI=;
	b=ey5GCIHi7/iX3rCEF9pZM9tzMfXQBK/oPpZj97BGcSUqxezI8xQ+rp0tnjY13SdCF/AqJA
	5V9UOp5YSv3KlmeJdHaF8WBrxPPXb5o1YOBkZgtJlEr7bpiBenc2luYE37U4rTIae5rRzM
	XzyPfFiPi3z361BcJKHIQWUXHxPYj/k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-3DmkRyntMBaAAyMlGq6kdw-1; Thu, 29 Feb 2024 04:33:47 -0500
X-MC-Unique: 3DmkRyntMBaAAyMlGq6kdw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-412baedf8a6so2734745e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199226; x=1709804026;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prefAyBiswb2rkdRNkhVYEjSOkqtek6XfQCd+pZ1+gI=;
        b=NKSCmxPNiUelH7BpKrMWi1CYL3iXGGD/Kn/Y6EXQpdnwCfi7dL+s2MR6mNqTIaaCj/
         4Fu5SDp/ZT39uhu0zFQxkYq/1LZVvqUIsQHAkL7JCq3qgM52w3+p2G0ajzBmEzV338MZ
         1Olmgq2R7BqOkqvHpQZ96R6mHcocsu66+J8EjZ0NCIxdbuLoYXI/2Ajt2JdTpce7dwiu
         gvZMl4uKXCJhmP0YPvqRhDEdJ9V5wYb/x1vkbB66CswNfyF8Ceo6xVcSDV8Yqn/H4Gjw
         c28Dcjo7yZlFdF5hRdTwN0GYdP1ohodSTz7x9BO6z1Rb+p2X6QFqKWlsk3R/9YPTWvY8
         1egg==
X-Forwarded-Encrypted: i=1; AJvYcCVhcmYcgK2dsEBi4pRFcPwjh8yXbZtWEO3mKaZGReQskHlKGfx50wE4to59GWdLrRkjCv/Q2YXsvoYWw0mkgjSNanfJ7wPSCuVi9Iry
X-Gm-Message-State: AOJu0YzPUtlcyEdczbAuD3th8/+CpDeRw23bYjdUM1CieB7bLwNoHSNF
	ZXYe+YKVfObjDN8QJGbg9+a7bwhPO69SPNaUKb8SB974XlLw7GOWKygYr0Hfny8aDRB1DJgw+Ff
	7+HH5+0sa3ck5sxjBaLpMClC0ouGV5MNlKGoPaBzJKJJZ1vz0w07mE7fd961rxA==
X-Received: by 2002:adf:fd8f:0:b0:33e:d17:76b with SMTP id d15-20020adffd8f000000b0033e0d17076bmr1148224wrr.7.1709199226185;
        Thu, 29 Feb 2024 01:33:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHcKOOvPkmwcaE1L+/DihFaD9dENh0bBvEIbitWgvYAlReZ1BVBp5+9ybFpCKsI5ZaLYbmyg==
X-Received: by 2002:adf:fd8f:0:b0:33e:d17:76b with SMTP id d15-20020adffd8f000000b0033e0d17076bmr1148198wrr.7.1709199225768;
        Thu, 29 Feb 2024 01:33:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:fa00:74f2:89da:ed65:8b50? (p200300cbc707fa0074f289daed658b50.dip0.t-ipconnect.de. [2003:cb:c707:fa00:74f2:89da:ed65:8b50])
        by smtp.gmail.com with ESMTPSA id i10-20020adff30a000000b0033b6e26f0f9sm1237401wro.42.2024.02.29.01.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 01:33:45 -0800 (PST)
Message-ID: <54053f0d-024b-4064-8d82-235cc71b61f8@redhat.com>
Date: Thu, 29 Feb 2024 10:33:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v8 0/8] Reduce TLB flushes by 94% by improving
 folio migration
Content-Language: en-US
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: kernel_team@skhynix.com, akpm@linux-foundation.org, ying.huang@intel.com,
 vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
 willy@infradead.org, peterz@infradead.org, luto@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, rjgolo@gmail.com
References: <20240226030613.22366-1-byungchul@sk.com>
 <20240229092810.GC64252@system.software.com>
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
In-Reply-To: <20240229092810.GC64252@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.02.24 10:28, Byungchul Park wrote:
> On Mon, Feb 26, 2024 at 12:06:05PM +0900, Byungchul Park wrote:
>> Hi everyone,
>>
>> While I'm working with a tiered memory system e.g. CXL memory, I have
>> been facing migration overhead esp. TLB shootdown on promotion or
>> demotion between different tiers. Yeah.. most TLB shootdowns on
>> migration through hinting fault can be avoided thanks to Huang Ying's
>> work, commit 4d4b6d66db ("mm,unmap: avoid flushing TLB in batch if PTE
>> is inaccessible"). See the following link:
>>
>> https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
>>
>> However, it's only for ones using hinting fault. I thought it'd be much
>> better if we have a general mechanism to reduce the number of TLB
>> flushes and TLB misses, that we can ultimately apply to any type of
>> migration, I tried it only for tiering for now tho.
>>
>> I'm suggesting a mechanism called MIGRC that stands for 'Migration Read
>> Copy', to reduce TLB flushes by keeping source and destination of folios
>> participated in the migrations until all TLB flushes required are done,
>> only if those folios are not mapped with write permission PTE entries.
>>
>> To achieve that:
>>
>>     1. For the folios that map only to non-writable TLB entries, prevent
>>        TLB flush at migration by keeping both source and destination
>>        folios, which will be handled later at a better time.
>>
>>     2. When any non-writable TLB entry changes to writable e.g. through
>>        fault handler, give up migrc mechanism so as to perform TLB flush
>>        required right away.
>>
>> I observed a big improvement of TLB flushes # and TLB misses # at the
>> following evaluation using XSBench like:
>>
>>     1. itlb flush was reduced by 93.9%.
>>     2. dtlb thread was reduced by 43.5%.
>>     3. stlb flush was reduced by 24.9%.
> 
> Hi guys,

Hi,

> 
> The TLB flush reduction is 25% ~ 94%, IMO, it's unbelievable.

Can't we find at least one benchmark that shows an actual improvement on 
some system?

Staring at the number TLB flushes is nice, but if it does not affect 
actual performance of at least one benchmark why do we even care?

"12 files changed, 597 insertions(+), 59 deletions(-)"

is not negligible and needs proper review.

That review needs motivation. The current numbers do not seem to be 
motivating enough :)

-- 
Cheers,

David / dhildenb


