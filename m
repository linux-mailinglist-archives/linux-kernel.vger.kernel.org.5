Return-Path: <linux-kernel+bounces-150007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0AC8A9901
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D201C2235A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD6315F417;
	Thu, 18 Apr 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYb5vAg3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB7115F311
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440994; cv=none; b=utTbsppDw9b3ClrNg36ENLGbidMZ8eOG5qOwbQO7wkw7uYb6YMONKMp8ahoif6Fjg7yLeexAcyZSOy7iCzRlbhideXoKUpJNpFVFU3dWu6xtSKhLt0YL77MWZfP1jfZOKWvRgUTyWTQ1W8akzy6vo2CDmW5QsRltS/ID4YAMPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440994; c=relaxed/simple;
	bh=oDakGs6VuVCmOsfEPVCbadU2m+jcQ6dLdKUr05Kv/mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoMxsSr4ExGK4ZmjUa2ZEP5YsYlhwcIujFoljJwREvmRGMbP9qggpeIVpIQj/O7Znjm4rCyvyAZNa40Qn+B2rIH111XU1bRtMUZD4c68Msz/BWx8ty8erQpPICTMAXozNQy5r+mCk6VIUifmo8Nf5yviRnCJO9iRzOxeMUgIJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYb5vAg3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713440991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V8/aQld94UzLvlQOPHbYtcJg5juetjrvjETslid99FE=;
	b=UYb5vAg3aqvwyywvNlDsWnrCptnqXaqra/OeoP2o71rbstRR7qNpoBpmlIQA2vSBmuBTCX
	AkCMII1n4Q6G+7diX6oqB/miTsdNSR5PJJGIpEWPlvSNzuAG1LMum/bHUV85fLMVesYRvs
	nXxSTyiB6tjAe805Fa65kNnDHD56xAs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-iF72yxawNNuxcAh_ARqT2A-1; Thu, 18 Apr 2024 07:49:49 -0400
X-MC-Unique: iF72yxawNNuxcAh_ARqT2A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4183b895ef1so3596075e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713440988; x=1714045788;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8/aQld94UzLvlQOPHbYtcJg5juetjrvjETslid99FE=;
        b=M4/h1ErcBapgfLvykapbSGgvu0EYdvrtpAk4PpADu5FxiYdq4qLpNQtksRGoL6JVJG
         SB6b6t5kwe5rgc6ouQ+U8/O3e6Yf8ncARLywwiRgSN/g6VdVTozoGUdclkUFUIByal6J
         vsNxRWCV7mLI3m/1mi5FX7Ro2/3bNPrB9TSdgLHeX5Tvg4bHDz4p9o9km0OyuiyBcyro
         OVELBHSUYT60VeW/paqhB4FF0A/CHxYQeS0+Jey7cTEegUsQh6MVRw/T1V6F6C5mfjBv
         eXPEkzkodieVzXmbFXWmbRjWttWKAIzTCI/D9czGuRYIMTIS0ITJYulew51WIpKzKhVx
         Abzg==
X-Forwarded-Encrypted: i=1; AJvYcCUIAQo+8nG5zdXwqok9DJVnXbPjWyKLEmRdJAfypZ1xQ/itzIl8yu+vjW52510NP+VlzYPBapUoR1eWu29Xi29t8XOITu3t5HLCcHDg
X-Gm-Message-State: AOJu0YzEV6w5+DTrnRF/YEQALa/0YNUWms4J22FGG5AAsHMGg3rzQJfp
	A/yh3HuL7WsFyPxzsDLuA7X4/AJTTZCLdWS2/G992ZXZm2n2jUikyoG/QUn3NHlpMsfVE9RbWQ/
	mC3rrIQOJ8gEoSV1scFmsTz3Xl/+FdsKHJIn6+Hkc56szrYqXdj+aXPpBM+zA1w==
X-Received: by 2002:a05:600c:1c91:b0:416:34c0:de9 with SMTP id k17-20020a05600c1c9100b0041634c00de9mr2444312wms.29.1713440988678;
        Thu, 18 Apr 2024 04:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqgqQ3za1EXSURtOq9OHiqKrZ6jbAQ3F9YMHY3AB9QOCUv9Rem8Ber/zitOUCR7OWCSrpNwg==
X-Received: by 2002:a05:600c:1c91:b0:416:34c0:de9 with SMTP id k17-20020a05600c1c9100b0041634c00de9mr2444293wms.29.1713440988260;
        Thu, 18 Apr 2024 04:49:48 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b0041496734318sm6310440wms.24.2024.04.18.04.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 04:49:47 -0700 (PDT)
Message-ID: <c96e46b6-ef66-447d-8aaa-14e2f1d99d1b@redhat.com>
Date: Thu, 18 Apr 2024 13:49:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] virtio_balloon: introduce memory allocation stall
 counter
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240418062602.1291391-1-pizhenwei@bytedance.com>
 <20240418062602.1291391-3-pizhenwei@bytedance.com>
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
In-Reply-To: <20240418062602.1291391-3-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.04.24 08:26, zhenwei pi wrote:
> Memory allocation stall counter represents the performance/latency of
> memory allocation, expose this counter to the host side by virtio
> balloon device via out-of-bound way.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/virtio/virtio_balloon.c     | 20 +++++++++++++++++++-
>   include/uapi/linux/virtio_balloon.h |  6 ++++--
>   2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index fd19934a847f..e88e6573afa5 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -321,7 +321,7 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
>   	unsigned long events[NR_VM_EVENT_ITEMS];
>   	struct sysinfo i;
>   	unsigned int idx = 0;
> -	long available;
> +	long available, stall = 0;
>   	unsigned long caches;
>   
>   	all_vm_events(events);
> @@ -338,6 +338,24 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL, events[OOM_KILL]);
> +
> +	/* sum all the stall events */
> +#ifdef CONFIG_ZONE_DMA
> +	stall += events[ALLOCSTALL_DMA];
> +#endif
> +#ifdef CONFIG_ZONE_DMA32
> +	stall += events[ALLOCSTALL_DMA32];
> +#endif
> +#ifdef CONFIG_HIGHMEM
> +	stall += events[ALLOCSTALL_HIGH];
> +#endif
> +#ifdef CONFIG_ZONE_DEVICE
> +	stall += events[ALLOCSTALL_DEVICE];
> +#endif

Naive me would think that ALLOCSTALL_DEVICE is always 0. :)

Likely we should just do:

for (zid = 0; zid < MAX_NR_ZONES; zid++)
	stall += events[ALLOCSTALL_NORMAL - ZONE_NORMAL + zid];

(see isolate_lru_folios() -> __count_zid_vm_events(), where we realy on 
the same ordering)

Apart form that, LGTM.

-- 
Cheers,

David / dhildenb


