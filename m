Return-Path: <linux-kernel+bounces-132733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76D0899963
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7EE1C21262
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25515FD14;
	Fri,  5 Apr 2024 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiQYRA47"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE80134404
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309151; cv=none; b=FMAMvdA3q25ADOglTnXPzSqRksJr5RcQdZkd56PubOcJ43+4CUslYKJSv1phR2nv/xNp1v1TNHp1SJTg2lrUrqZSAMumv9A9S/EEJQHa/euoH6ZxCBtRfACi5ucUWi4Fz0jPOml82ZaYYMrpxsazJ69wwSrnCqcvrkM+viijsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309151; c=relaxed/simple;
	bh=99rYBllAcI6V0Nzsgwx8A5rtJ3vXXHjfnjEpuMg9HKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axEfyzf2QH65Hk9zoGm0oRptqMR/Ss8bjMqIu2kOphtpRIj7br1KLPGpUY5NWpc8j+PXGq8tnSzPAwAS3dFs0a7hzDJ2Eu6/N9Ez6H149sCGwNhoh84FUus0/lPEpmNb9HhdTwNg7sNJmi2tzvYYVBvbojedvFQ4JT+k3i0B2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiQYRA47; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712309148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LgdcM5lMbBMLvsnXVIs0MYgiAmuaqteAte5G5/RondM=;
	b=PiQYRA47CLnYj34w1jUgJSlA1EBq7PLSuYR0F6ADlqV43EzkUv5DOlW1ix9VOIFIdIXcGd
	3OeuSqW5z6mMHLcy/Z/03cDASrYidzNj7EjIzD/sfdIvcm2nFI3MpfEqCSNQbgTWGiLQbB
	aulddS8rUoHcBaPRMBvnxtKMvay30S8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-fCkXClHbPfeprhY8Oin7Bg-1; Fri, 05 Apr 2024 05:25:47 -0400
X-MC-Unique: fCkXClHbPfeprhY8Oin7Bg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d818a149bbso16272661fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 02:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712309145; x=1712913945;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LgdcM5lMbBMLvsnXVIs0MYgiAmuaqteAte5G5/RondM=;
        b=VpH0eRWhedieJKNd1V11J9NrctFVttzkrGZU8cE6NOEd/qRlncgw4WHEDTKEEhhefw
         h4wTaNzJ0Qk/fdF5C7Jyx6v27FAaEHTqArM+KdAY3tgS5WVkicCYpXftt8/91Xzny7WL
         KLwcmSMimEUENXN5646VRTzTWN3jE8I648XqlAEcUQAH/D70T/mDeK6cLqm9zxV5UfTl
         AgsMpNJo5uXQKx2B8VjvIOGQJ6r7wb2EpP4JvLbIjDX9ECLLS2/wzml54l0naWoTlA6M
         BqHgUiHpvZuAqzO1/HvHOME1c1BYXooEm4eGezjaHLyV1JKvExZfVwfIX0gUtdMu2pYO
         Sudw==
X-Forwarded-Encrypted: i=1; AJvYcCXt/xI6ih2IMLkpXPTangrfpl4N/aE5OF6sb6bcLdQU/Q9n0+VRu0wycIM7mR3FbHZW81/vFN+3feMI7fTRUzv6Ty28f5RV48KYHNRR
X-Gm-Message-State: AOJu0YxdbOMIm26FaAe7ApQfDkLA1ud+cSBqn1YEDQJDI4yPOyCRmPFm
	DYeXhEgpk1K6chRx1E+NEfN5ZI16G7qfbma8+kDTL+wjXzp7kvp82R9YL11DhxcuFFeNtrMvpWd
	7TVNchw0Hx3ZzViFWxJ2W6C9u3nxxXVR87oDzDlaNSB5b8+1ijBJNRehoYSt87A==
X-Received: by 2002:a2e:b811:0:b0:2d8:620b:9838 with SMTP id u17-20020a2eb811000000b002d8620b9838mr607213ljo.46.1712309145634;
        Fri, 05 Apr 2024 02:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELU4ic+i6IbRyUTpfd6zlGD7647m42n4mPwdZh+D0TEUULnycqLipdzXidFvbO17HsPkAvFw==
X-Received: by 2002:a2e:b811:0:b0:2d8:620b:9838 with SMTP id u17-20020a2eb811000000b002d8620b9838mr607195ljo.46.1712309145225;
        Fri, 05 Apr 2024 02:25:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1? (p200300cbc74b5500e1f8a3108fa34ec1.dip0.t-ipconnect.de. [2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1])
        by smtp.gmail.com with ESMTPSA id h22-20020a05600c351600b0041562a58b75sm2228408wmq.13.2024.04.05.02.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 02:25:44 -0700 (PDT)
Message-ID: <af32865e-1362-48f0-a2f1-d6889b685203@redhat.com>
Date: Fri, 5 Apr 2024 11:25:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-2-ryan.roberts@arm.com>
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
In-Reply-To: <20240403114032.1162100-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.04.24 13:40, Ryan Roberts wrote:
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
> shortcut a call __try_to_reclaim_swap() in some cases.
> __try_to_reclaim_swap() gets the folio and (via some other functions)
> calls swap_page_trans_huge_swapped(). So I've removed the problematic
> call site and believe the new logic should be functionally equivalent.
> 
> That said, removing the fast path means that we will take a reference
> and trylock a large folio much more often, which we would like to avoid.
> The next patch will solve this.
> 
> Removing CLUSTER_FLAG_HUGE also means we can remove split_swap_cluster()
> which used to be called during folio splitting, since
> split_swap_cluster()'s only job was to remove the flag.
> 
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

[started to review v5, then saw v6]

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


