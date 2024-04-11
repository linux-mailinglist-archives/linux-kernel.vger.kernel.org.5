Return-Path: <linux-kernel+bounces-140681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E838A17B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06861F21AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0C2175A5;
	Thu, 11 Apr 2024 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1ebhBZf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651AD17597
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846562; cv=none; b=VpufA9WuQrPeFcFueKQrVbhAzl18VGoL8TuK223Bpicy8lheYP9i+SO4le0yXptLXUMR0PniS6PZhYsgyp8wOVlRjvo08fHIN8ZSzomPDo85D/VX6tdStu0xiUUjgUGVYIoTuzYU4pNoDRRM3mDGdOSfgGhnl3NTXWNvWaBWrmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846562; c=relaxed/simple;
	bh=hrhz/USwERHALa6+SBN9WWCsmlCQIoogct0iuq5Dlhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2MoOWe26Rg9I+Ol1VLxuFouUwXv1QgOC9jbka5y4w/r0MCPzl/JSLMjsy2FTXVHWJJ7ENqiXXafUV9JjPni/+v+k4xDS0bw0m4ovOWS0AsdEU/umHfv9C6tHQbf1SxKqeU6NpeYp6Gmj9EXsIiZGxNDUAkrJlxvVMA8xDAlxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1ebhBZf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712846560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cloIlrEPu5CFbR7EQF76WzlwXlJdZg7c2NcoqjaKdiQ=;
	b=P1ebhBZfMYgLGsfWVrtaXrEOQtoyFqolbF3JBd+sWwji5w8vMXulEu5d4xHGgRwuovC9xI
	CbXboeMAl5P47WNCxjh/F3T1IzCLeRqB09U7EgyHo8lQk5jXOujnEi1QWbKeN66iyDv4JO
	C1GGJUmAxS56nImYfJFQDvyLKqCOMds=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-yXFlqu0cO6egkwxn9JHmZw-1; Thu, 11 Apr 2024 10:42:38 -0400
X-MC-Unique: yXFlqu0cO6egkwxn9JHmZw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-417df7b0265so2363515e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712846557; x=1713451357;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cloIlrEPu5CFbR7EQF76WzlwXlJdZg7c2NcoqjaKdiQ=;
        b=NEFql2lksdEs8d/n0932eJZnkwpmm19r7oUxVI9CvWEYMSD8qzoByc9UsFuvfhDhPB
         SCYs8dkKUwy7BhMUwt/TlYYoX5wCT11X4/KV7tVxaN2sDHzxKgtqv7U539aZ9y0RGgKx
         aETknCkEWcDb8g595FtXgvj4O9gUVoENLaQD6+qIErDM6pwvr/a0DVJF4Y/5b3wwcmou
         P9JxbE/N8WVVSYpTuC+jX0RweiWc3Fz0MtSYOMgo4EaxIyZwp/PZv8zsMu97ZiDmhQkL
         bbC6XTp9V1baY9etsj02ubRq/NuPEjw6JMryGsxiL21FFgLA285/EFg/Z7lzHIzU2mz5
         MIDg==
X-Forwarded-Encrypted: i=1; AJvYcCUnWQKUF/ln1ZFXEjdTOweomm8F3w0nt3/Zv2JmHaRwcf409Sxh4atHc17+DK6c+pmXu+8hLrGS26TbFX8/BgCtvFuEwLS+0oUu4d9R
X-Gm-Message-State: AOJu0YyzzkKsGwE/hpDTRtqFuh3gqLke9F8MqECCwn6AecGL4qq5EU8n
	Tc8bItRRdep4TqK2JhI/j9CERM27YStWi5c1imen5I07yiUWbbrPdpQx6gm47zZYdVVOls2fGI4
	v5+jvfDgIPSqqne3q2DupCmV45o3bTnqo/Gz51OH2Hiy6b1ZEzlq7M9G86RWdFA==
X-Received: by 2002:a05:600c:5027:b0:417:e358:5df1 with SMTP id n39-20020a05600c502700b00417e3585df1mr825831wmr.28.1712846557554;
        Thu, 11 Apr 2024 07:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK5oou2/4vbged3W2QjfE/RRcyinj5H+f/bQL8bOjViCYZAYG7ioO7xG6xgo4gh2+fmDa1RA==
X-Received: by 2002:a05:600c:5027:b0:417:e358:5df1 with SMTP id n39-20020a05600c502700b00417e3585df1mr825818wmr.28.1712846557153;
        Thu, 11 Apr 2024 07:42:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:4300:430f:1c83:1abc:1d66? (p200300cbc7244300430f1c831abc1d66.dip0.t-ipconnect.de. [2003:cb:c724:4300:430f:1c83:1abc:1d66])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c321300b004167b0819aasm7036068wmp.0.2024.04.11.07.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 07:42:36 -0700 (PDT)
Message-ID: <30c6934c-d7a1-4ed2-91a9-34b282a0b839@redhat.com>
Date: Thu, 11 Apr 2024 16:42:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] mm/madvise: optimize lazyfreeing with mTHP in
 madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240408042437.10951-1-ioworker0@gmail.com>
 <20240408042437.10951-2-ioworker0@gmail.com>
 <38c4add8-53a2-49ca-9f1b-f62c2ee3e764@arm.com>
 <CAK1f24kh-vN3_6ZLUZWXu_g1UOPBuoVXq2jsnx_GBbGFXyXRFQ@mail.gmail.com>
 <3cda8e87-7095-4aad-beb1-6a420912df34@arm.com>
 <CAK1f24k6mhQZwws7fjvL0ynme4FtjqBM3T6ZYuFPytH0fG=v6w@mail.gmail.com>
 <8d674b15-ef74-4d96-bc27-8794f744517c@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8d674b15-ef74-4d96-bc27-8794f744517c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.04.24 16:39, Ryan Roberts wrote:
> On 11/04/2024 15:07, Lance Yang wrote:
>> On Thu, Apr 11, 2024 at 9:48 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> [...]
>>>
>>>>>> +
>>>>>> +             if (!folio_trylock(folio))
>>>>>> +                     continue;
>>>>>
>>>>> This is still wrong. This should all be protected by the "if
>>>>> (folio_test_swapcache(folio) || folio_test_dirty(folio))" as it was previously
>>>>> so that you only call folio_trylock() if that condition is true. You are
>>>>> unconditionally locking here, then unlocking, then relocking below if the
>>>>> condition is met. Just put everything inside the condition and lock once.
>>>>
>>>> I'm not sure if it's safe to call folio_mapcount() without holding the
>>>> folio lock.
>>>>
>>>> As mentioned earlier by David in the v2[1]
>>>>> What could work for large folios is making sure that #ptes that map the
>>>>> folio here correspond to the folio_mapcount(). And folio_mapcount()
>>>>> should be called under folio lock, to avoid racing with swapout/migration.
>>>>
>>>> [1] https://lore.kernel.org/all/5cc05529-eb80-410e-bc26-233b0ba0b21f@redhat.com/
>>>
>>> But I'm not suggesting that you should call folio_mapcount() without the lock.
>>> I'm proposing this:
>>>
>>>                  if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
>>>                          if (!folio_trylock(folio))
>>>                                  continue;
>>>                          /*
>>> -                        * If folio is shared with others, we mustn't clear
>>> -                        * the folio's dirty flag.
>>> +                        * If we have a large folio at this point, we know it is
>>> +                        * fully mapped so if its mapcount is the same as its
>>> +                        * number of pages, it must be exclusive.
>>>                           */
>>> -                       if (folio_mapcount(folio) != 1) {
>>> +                       if (folio_mapcount(folio) != folio_nr_pages(folio)) {
>>>                                  folio_unlock(folio);
>>>                                  continue;
>>>                          }
>>
>> IIUC, if the folio is clean and not in the swapcache, we still need to
>> compare the number of batched PTEs against folio_mapcount().
> 
> Why? That's not how the old code worked. In fact the comment says that the
> reason for the exclusive check is to avoid marking a dirty *folio* as clean if
> shared; that would be bad because we could throw away data that others relied
> upon. It's perfectly safe to clear the dirty flag from the *pte* even if it is
> shared; the ptes are private to the process so that won't affect sharers.
> 
> You should just follow the pattern already estabilished by the original code.
> The only difference is that because the folio is now (potentially) large, you
> have to change the way to detect exclusivity.

+1

-- 
Cheers,

David / dhildenb


