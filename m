Return-Path: <linux-kernel+bounces-140377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5678A1382
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AEE7B22F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FDB14AD0E;
	Thu, 11 Apr 2024 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6ajJduk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E9E148855
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835990; cv=none; b=pcXzAHAnnpeMgvWveiVepNuvuVQzGcuRasgs0OWIQIRrjCCxwIQkgomeZ5MbWS9E+dVE7hCIkpFnLQgdT1s+apur9+sghNe4BQ9BVqPjGfvc/ZOHxMjy4yy7s4b27QuJyPQcbnhBZIt1yL6DFcWuUpaG1TR93IsPv0eVeJi9Q0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835990; c=relaxed/simple;
	bh=NJZKOQ22+TeCoQAVwyELEiSz7drtvH7DsI3prLSghWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cIfpNjTo+cTqa4HiBUiooK8VUWpRESkTRckmugjLGQShlg0cb+nLhR219ddU/HGoOoJlhPZh559UtZ21G6514eXbq3ZWbgALe+QbwoVwPy4byIcVLKmg5VA93SCct12FWUZVwzAC6aHI2XZdAhZPrxUb6V0/jA15kq2ZagwSS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6ajJduk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712835987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sMT8mnobgsA82h0fUMd7QWWkeoNZj0+Qn3WbiaKWaW4=;
	b=N6ajJdukx3iCv3g46yoIlakEs6sU8N3c2hFNtTunGXZXhMj7c+bjfDAo3VDquukNZu7wRo
	KGVtyPuF3uVoFVcvzSbG4Ng3L+RYkCYu/ppU1aVwfzoXJ9PsfwcOnezKZDPDh2dlZTEXAh
	Y40Qrdhqa6HSzz3y5yKYJl06+wixJaM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-E5MA_mSoOb-l4BpAwM09gg-1; Thu, 11 Apr 2024 07:46:26 -0400
X-MC-Unique: E5MA_mSoOb-l4BpAwM09gg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-346c08df987so311094f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712835985; x=1713440785;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMT8mnobgsA82h0fUMd7QWWkeoNZj0+Qn3WbiaKWaW4=;
        b=abuRCgpnEw35AK29jovcohM5aOOHdxccasgyYkWcQAQPAe3FblB4MNMecQhB7Zfcz2
         yIqcXPlQ9RQzIakDpEtxpSMTtA0rmNwfMhfxZ3qzSNDAPihaXoXUxlZR4bhrXdf0K8DK
         Jsempm/jnsc/AuvQWbDcFG0PIha2CwPVHJoqxFvCks5Qv+GM0l3dIXxiPANnFEoa1svP
         ml693ns0oEi6ee1IuUUD5ArxjNdYPPvVS70yghwwpX1LkQpKfk6dspN7JKd1gNXYnzrh
         N6Dpj7C9ACwc/cVxArzZq9BwRqfO59ljk1SYhZR5tEapaFcPw3CGAp42BIsDAdsDnQ15
         VXoA==
X-Forwarded-Encrypted: i=1; AJvYcCWe6OMR4KsIZmdm8n1JTe/CLHfIgXKnMJGs6Q3CH8YipKq2v9GzOCV5gXTsjoJ+UHWffSE+3h72XailtbaPoICAFNarCsln2Ofu/LZ8
X-Gm-Message-State: AOJu0YzCDj1cOO9GwdvqUNXLlVwSNNGFW+4UXXD0xSxSGMbADh3AwnMr
	DcEdYgmDigy+/HkT0HxvY7dJ2cVmqy1yJSVD9N018kSCHVRgRnj//dH/+/RQ8S3utvF+OBX/okr
	3WTFpesrKJmoA7qad2PURqqEHJjCuaAA3dQpDWQiG9IMKnXwhNs1iqiZRpZU/QQ==
X-Received: by 2002:adf:fcce:0:b0:342:d5ac:c712 with SMTP id f14-20020adffcce000000b00342d5acc712mr2234697wrs.7.1712835985364;
        Thu, 11 Apr 2024 04:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5GOE1tq6QJxm9V4xN8Js0M0XUPDK42uzTYnh3Yq4evI00NNoKkTyfvuskIC/BZXbY0ay0dA==
X-Received: by 2002:adf:fcce:0:b0:342:d5ac:c712 with SMTP id f14-20020adffcce000000b00342d5acc712mr2234673wrs.7.1712835984964;
        Thu, 11 Apr 2024 04:46:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:4300:430f:1c83:1abc:1d66? (p200300cbc7244300430f1c831abc1d66.dip0.t-ipconnect.de. [2003:cb:c724:4300:430f:1c83:1abc:1d66])
        by smtp.gmail.com with ESMTPSA id h7-20020a5d4fc7000000b00341ba91c1f5sm1575244wrw.102.2024.04.11.04.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 04:46:24 -0700 (PDT)
Message-ID: <47686d5e-efd3-4431-b72c-620f749faeaa@redhat.com>
Date: Thu, 11 Apr 2024 13:46:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] mm/ksm: rename get_ksm_page_flags() to
 ksm_get_folio_flags
To: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, zik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, hughd@google.com,
 chrisw@sous-sol.org
References: <20240411061713.1847574-1-alexs@kernel.org>
 <20240411061713.1847574-10-alexs@kernel.org>
 <192aaa5c-3ff3-40c1-b12a-b674518bf5de@redhat.com>
 <add08bec-f474-476e-a985-9017dbb33a88@gmail.com>
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
In-Reply-To: <add08bec-f474-476e-a985-9017dbb33a88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.04.24 13:42, Alex Shi wrote:
> 
> 
> On 4/11/24 3:51 PM, David Hildenbrand wrote:
>> On 11.04.24 08:17, alexs@kernel.org wrote:
>>> From: David Hildenbrand <david@redhat.com>
>>>
>>> As we are removing get_ksm_page_flags(), make the flags match the new
>>> function name.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> Reviewed-by: Alex Shi <alexs@kernel.org>
>>> ---
>>
>> s/get_ksm_page_flags()/get_ksm_page_flags/ in title, otherwise LGTM.
>>
> 
> Uh, for this trivial issue, do I need to sent a new version? or left to maintainer for a quick fix?

I'm sure Andrew can fix that up :)

-- 
Cheers,

David / dhildenb


