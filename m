Return-Path: <linux-kernel+bounces-68945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0892585823C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41732849BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3721912FB31;
	Fri, 16 Feb 2024 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THHLRs8N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210228E23
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100228; cv=none; b=O9vgS2Fw45QF8JISyWGAweK2CmQrgmZPdtqgRMS/8XV8TkWzKXxhs5ptXyqi8SdB0N4Qa1k5dAHmStf3MjLPH3z5Oiy9hJjcdu3q01QC5MWGz8OJJcHAjiOLMlw4ZttJAnI1bmfg4p5hkdIJbJhF/4nkQDdyaRrLlo2IIl488BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100228; c=relaxed/simple;
	bh=4wQ9xEhcqjXCYBLgPpJSEIssZci3ilI2sZ3GH8xRJOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQ5xgO79QAWfVgQT4fjU71i7XviTjolPYNkjycynV/sR4syqncfslLpGcBo9WHru34DZi+eWCr8yeFs4Y5zO3n1thc9PuTkFrcGq5he/tOMk8JhC4ob1+OFF1FNvSNWie0kITUEOJLxmcqmvYpC7cjvYrOCAcpHBXYFiszQ2Pdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=THHLRs8N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708100225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c6+7atygW7QOnkGJLSuMLDIxvn9DIzwdT1QSyiTLJNA=;
	b=THHLRs8NcYzyKlEFk8vjjPu9AYE7hwphwlrOq3F3snVvWK3Z/2Mq7w3CU2Q4j0ApoO7fQC
	ab5oS3fEveHRnGS6ETwzOP2pYlFwmjA8Smc1VkmpVeU1bdHOpI0/hIPEuh43M/UuS0Os8L
	2x8E91YzI//3qZMJYtE4tc1YaWh5hOI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-WKso7JfbMkSTlk3ap3tTSA-1; Fri, 16 Feb 2024 11:17:04 -0500
X-MC-Unique: WKso7JfbMkSTlk3ap3tTSA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-411ac839dc5so11511615e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708100223; x=1708705023;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6+7atygW7QOnkGJLSuMLDIxvn9DIzwdT1QSyiTLJNA=;
        b=W8BnPmcwd9t6DtnfAsVG7Z4IXqesI18ThxaUWkdbc0O1L9sjYyfofRM9x+GQOCCyTw
         TZJoSWNmub71MvTX/UFEul6Cad1fM2u9UaAvd4W2WlNQQ76BdTljWzB8acBaiPga2YyG
         5yZhqgPHfKldJq0Uyot1KawmutAEFmQCt0lBtnPMOLxRSJySNbP63ddLHM+HYn3Gr7DB
         Bc3byoc4xOp1ZYG5463TPc2wv5ktF2lgSTGY01vhMoXBNsOJeKhVWGMUhye482a8pqUl
         /I3nCuLPyFY0ljGzbPnS1KzCrOka/4QmXoXQt9i93O1bsXLnlCs7H/XWIp0Oe0n/qmil
         PiDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAy+DYp+vkLy/PWOsXB6ZhWmL/NDwQXdClpTt3EX+vL/LMeUMgIgiQzeAidll+2J/80JfqHu44nwJFNR5zwUSRkzjUaNCKZmL+BQuc
X-Gm-Message-State: AOJu0Yyh8whyJT4JRaUowF5SzgiCyV+5+84l2tYbBt9EqoIffx8kPrnj
	WnSGG0JbL0n1G78PYX5c9ylvhuLNqRYGEXV19BVqa/QiC6ClgGtBa8KZrYUvL9UKzeC8BSaEvmB
	WcbuJIrXwdHKDGn6TLEUnx7zDqnpZFALWz+zzyo2glIIKmLEELnlQwtkXLScxHw==
X-Received: by 2002:a05:600c:1c1e:b0:412:1615:7343 with SMTP id j30-20020a05600c1c1e00b0041216157343mr4367152wms.5.1708100222917;
        Fri, 16 Feb 2024 08:17:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY2ktOfjymj6X1+czeKaqGXtMp53zw558F+DnAgKuEALM2JWjcOjKlnalz2uom4G6GaaT7Tw==
X-Received: by 2002:a05:600c:1c1e:b0:412:1615:7343 with SMTP id j30-20020a05600c1c1e00b0041216157343mr4366088wms.5.1708100192759;
        Fri, 16 Feb 2024 08:16:32 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id e25-20020a05600c219900b0040fe4b733f4sm2719927wme.26.2024.02.16.08.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 08:16:32 -0800 (PST)
Message-ID: <6ad329f6-6e1b-411b-a5d7-be1c8fd89d96@redhat.com>
Date: Fri, 16 Feb 2024 17:16:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
 Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>,
 Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Yosry Ahmed <yosryahmed@google.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206182559.32264-1-ryncsn@gmail.com>
 <1d259a51-46e6-4d3b-9455-38dbcc17b168@redhat.com>
 <CAMgjq7Cy3njsQzGi5Wa_JaM4NaO4eDGO5D8cY+KEB0ERd_JrGw@mail.gmail.com>
 <4c651673-132f-4cd8-997e-175f586fd2e6@redhat.com>
 <CAMgjq7CtLrzkO0kBEsqRDyu+GoGbzdgii3_dj7pfo-3-maQU8A@mail.gmail.com>
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
In-Reply-To: <CAMgjq7CtLrzkO0kBEsqRDyu+GoGbzdgii3_dj7pfo-3-maQU8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> (4) relock the folio. (we do that already, might not want to fail)
>>
>> (4) take the PTE lock. If the PTE did not change, turn it into a present
>> PTE entry. Otherwise, cleanup.
> 
> Very interesting idea!
> 
> I'm just not sure what actual benefit it brings. The only concern
> about reusing swapcache_prepare so far is repeated page faults that
> may hurt performance or statistics, this issue is basically gone after
> adding a schedule().

I think you know that slapping in random schedule() calls is not a 
proper way to wait for an event to happen :) It's pretty much 
unpredictable how long the schedule() will take and if there even is 
anything to schedule to!

With what I propose, just like with page migration, you really do wait 
for the event (page read and unlocked, only the PTE has to be updated) 
to happen before you try anything else.

Now, the difference is most likely that the case here happens much less 
frequently than page migration. Still, you could have all threads 
faulting one the same page and all would do the same dance here.

> 
> We can't drop all the operations around swap cache and map anyway. It
> doesn't know if it should skip the swapcache until swapcache lookup
> and swap count look up are all done. So I think it can be done more
> naturally here with a special value, making things simpler, robust,
> and improving performance a bit more.
> 

The issue will always be that someone can zap the PTE concurrently, 
which would free up the swap cache. With what I propose, that cannot 
happen in the sync swapin case we are discussing here.

If someone where to zap the PTE in the meantime, it would only remove 
the special non-swap entry, indicating to swapin code that concurrent 
zapping happened. The swapin code would handle the swapcache freeing 
instead, after finishing reading the content.

So the swapcache would not get freed concurrently anymore if I am not wrong.

At least the theory, I didn't prototype it yet.

> And in another series [1] I'm working on making shmem make use of
> cache bypassed swapin as well, following this approach I'll have to
> implement another shmem map based synchronization too.
> 

I'd have to look further into that, if something like that could 
similarly apply to shmem. But yes, it's no using PTEs, so a PTE-based 
sync mechanism does definitely not apply..

> After all it's only a rare race, I think a simpler solution might be better.

I'm not sure that simpler means better here. Simpler might be better for 
a backport, though.

The "use schedule() to wait" looks odd, maybe it's a common primitive 
that I simply didn't stumble over yet. (I doubt it but it could be possible)

-- 
Cheers,

David / dhildenb


