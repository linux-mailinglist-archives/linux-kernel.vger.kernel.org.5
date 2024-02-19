Return-Path: <linux-kernel+bounces-71032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A3A859FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692E41C21281
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BD979D1;
	Mon, 19 Feb 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6piOGVA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234722F03
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335026; cv=none; b=rY62/lhKIhSvzx92GyfbuTGPka9we+M8GZ2Ywmtoi/1nI7rtym2GxQmSe97GXDWVDxCiePexqxul4bAgQ/FEfEvDAXGdx5eddF13IlFNx8tKfd38k+w1CH+n7/T0ViPrjwHD2lsMtdorRBpVLba6kmi6JTii7+bsj5LqyM6k3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335026; c=relaxed/simple;
	bh=0C0PniZU/TYL8qWo4Y3Saq/59fQL2FnsxwXXzDPboM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N47C5IvHnDj8SBGKL4OmjQuG6MlP7PQuLZWldj9db3VglDaCsNC6rQj2hFnru0+dDsrC2w7NtLD7w+Om1afX25QzaVg2Oywl4XfzYhSf7SwVNLGWdjvommgkVlwpLsn8H0UipysV8FHTG/39pcPl8O8Ufg/eh5DL4Rldg2ug2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6piOGVA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708335023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KPNtQLX/ASuH8CsNpvSg+A86gihyZbCbVxAryd4BHq4=;
	b=W6piOGVArrqzhX6rdhkwX3JJ7cS7EqeKIsuNkzdLie4oPecPDOKs6yJyanoQnLBXS+yBkI
	Ow7z1gVuo0OU7zmjrwlMJsqubnxZOnv0ey7IkDqYgIweiBtVrRbjX6DtvWG6RscaaZ/A2e
	3BWffEZzqH4Jps7/D9jUU7d5IYyT+cQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-kSbfClubPRq_LzE4vHV1Pg-1; Mon, 19 Feb 2024 04:30:21 -0500
X-MC-Unique: kSbfClubPRq_LzE4vHV1Pg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d243193975so898151fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708335020; x=1708939820;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPNtQLX/ASuH8CsNpvSg+A86gihyZbCbVxAryd4BHq4=;
        b=nhf97hLMWnJFo80dZbPEfo4j8vFROKgklGaLoudmcGuAuzso2iphSI4NRAIFnw5oTJ
         NRh6zENsEA1omUxz8f/UBH8S+pU8jh1Zhit+6O/B7xt+JuM2D7Bl4wNXJdVr5OjH+i6H
         3cAsm7qWB0Bjqs5/KeSl69RpugqLvELJTlLYn8zWtN7LSbnLb2NhX6esZVR6Ymm97W53
         Xy1G5lfEj2tY+fr7zRkGPMvdv5UPRSfR3eyjWgMHULINGC4OxltZ3eCVoXwBN773iHe+
         XVwHIi4Pyvw3RONIxE/9snEC/elRt6zaB91jgVblyB+WYo7ifT58om7iInWKMNMo93VZ
         glsw==
X-Gm-Message-State: AOJu0Yx8TjHu4pPSQkloMC+DeBDgflh2AClcwfz3j/O21hY0hB/3NKyG
	K5GQ4x81xsPWXqJG3H6Ha6NVNr6tWWOoRm3nPICbQmqrO8FWk78hgcvSjhvSZb2+WOs5R7ZyP6C
	z8pzyIvZPFtAsyPCU71ci35kMbo9ycXoodLvCOoZar/hJUZ6oiTiDyx0x4OzEow==
X-Received: by 2002:a05:651c:2127:b0:2d2:31af:a5a8 with SMTP id a39-20020a05651c212700b002d231afa5a8mr4102835ljq.35.1708335020194;
        Mon, 19 Feb 2024 01:30:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg7Yq5EamispIHV/asAqBi3ILJCiny9xfb8yYl2FcitR66BULSiWjebv3iSA/d8jWc463PSg==
X-Received: by 2002:a05:651c:2127:b0:2d2:31af:a5a8 with SMTP id a39-20020a05651c212700b002d231afa5a8mr4102816ljq.35.1708335019794;
        Mon, 19 Feb 2024 01:30:19 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c379300b0041237b54811sm2293904wmr.0.2024.02.19.01.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 01:30:19 -0800 (PST)
Message-ID: <c7be8f47-7c2a-4585-af91-ee414ceed178@redhat.com>
Date: Mon, 19 Feb 2024 10:30:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/numa, mm: do not promote folios to nodes not set
 N_MEMORY
Content-Language: en-US
To: Byungchul Park <byungchul@sk.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, akpm@linux-foundation.org
References: <20240216114045.24828-1-byungchul@sk.com>
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
In-Reply-To: <20240216114045.24828-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.02.24 12:40, Byungchul Park wrote:
> Changes from v2:
> 	1. Rewrite the comment in code and the commit message becasue it
> 	   turns out that this patch is not the real fix for the oops
> 	   descriped. The real fix goes in another patch below:
> 
> 	   https://lore.kernel.org/lkml/20240216111502.79759-1-byungchul@sk.com/
> 
> Changes from v1:
> 	1. Trim the verbose oops in the commit message. (feedbacked by
> 	   Phil Auld)
> 	2. Rewrite a comment in code. (feedbacked by Phil Auld)
> 
> --->8---
>  From 150af2f78e19217a1d03e47e3ee5279684590fb4 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Fri, 16 Feb 2024 20:18:10 +0900
> Subject: [PATCH v3] sched/numa, mm: do not promote folios to nodes not set N_MEMORY
> 
> A numa node might not have its local memory but CPUs. Promoting a folio
> to the node's local memory is nonsense. So avoid nodes not set N_MEMORY
> from getting promoted.

So there is no bug/panic that can be triggered and this is not a "fix" 
but an optimization?

> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>   kernel/sched/fair.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d7a3c63a2171..7ed9ef3c0134 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1828,6 +1828,13 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>   	int dst_nid = cpu_to_node(dst_cpu);
>   	int last_cpupid, this_cpupid;
>   
> +	/*
> +	 * A node of dst_nid might not have its local memory. Promoting
> +	 * a folio to the node is meaningless.
> +	 */
> +	if (!node_state(dst_nid, N_MEMORY))
> +		return false;
> +
>   	/*
>   	 * The pages in slow memory node should be migrated according
>   	 * to hot/cold instead of private/shared.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


