Return-Path: <linux-kernel+bounces-96731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283B08760BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336A1B2102D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0EA53372;
	Fri,  8 Mar 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnugW44w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA893BBDB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709889469; cv=none; b=bH7mj4dd5sKQmwfk/NdfJUkf2PIgpeOxQgJcrg/5oCPJMW69dSOpnQNx0P0S/4dY1r5r0N+ISgaO/JD1oXS0/bccTxDHIfN5Hf11IATnwBNuxVxQKUTi+tpwiBZnDfSYEKUX3nkBKwwmxHWeqLfZXnV2OACoV7p5LXYAiDGNwMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709889469; c=relaxed/simple;
	bh=rf70pbWFHmC1a6HB79Dq3e3BPkCDNW7mcgTLRHhvi+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzDFbqxrx4I/4Wa9/vXzekLJrTnoVc3k8NSDwDBDQeanu9DA8eIqkyT+VzKprPbJhnGbtGaDo1NabcbYH9cc2ZgY0nDtXA1PYOS65/jZX8aULn0FA6wa7dRLFdPAjYicTpAlcEBlYlq1AefLxC5sHbg0VgAEHkW623xJl+IKdNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnugW44w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709889466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wc+jNLqpJRpURM3WZTz0J0zaE28YHJQ7oRCZDhshZ8w=;
	b=AnugW44wm1/zXI71kqNIaE5O4XLP5DwftJX1nj8HV3sGM8Bmv4k2oQ+mZ3QHBd6r/QPVjV
	TcLOd3/CEXJU7JmLgbpYzaYoF6pjy8N9uk0+E+0EiSKHOdr1xi1gTEbArNe+lUnLinF5e6
	5uaGyLKOBjlfanQ15p4+S9rkYkGC324=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-FrwnlGKgP5Oi5lmsnpAqkA-1; Fri, 08 Mar 2024 04:17:44 -0500
X-MC-Unique: FrwnlGKgP5Oi5lmsnpAqkA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33e1dcb31a8so650217f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709889463; x=1710494263;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc+jNLqpJRpURM3WZTz0J0zaE28YHJQ7oRCZDhshZ8w=;
        b=u6TcfbucZd1uEQtpLdCPwpFHOgZbJguY+wtFacq4cHNEdRbXW7TIrSECBUx0gt5K5a
         93idfxkoBqiKRFlpzugJ4RYNck6w4sBYmWPplOI9WnQjejv6T8o3FOVi4wsBarz6qh4w
         z4H4ipCivEiGUr4MCNUyIxIxXaDiba9kjlsXuMKt6R+JgBXEKxHVsgEws1F+W4sBtRg/
         DO54r1h6AfH4Tq05rBD1gHcT1FAMigeGQ+ApKn5xpOnC7iobmku0QKdpRpIkLoQybwBT
         5peR8j0lBcmX6rdSHovpapB3UijBQ/OPNwlZv/QDJYdLbsUMM1BL5bEBj5AQfC3tXoP0
         CRKw==
X-Forwarded-Encrypted: i=1; AJvYcCXsbq4t926crZF0Bq/IXrnWfmu6iHRDBcr5iQuwd+dsKzZSBvbvW3ZnlMbvv/WCdJ6rdujEfJ9j/G4RqmHm97BGq7xYNBTyyR8YWWM0
X-Gm-Message-State: AOJu0YyVlvjsVmVgTIUPZjmHYsBuvHwtoVM29Q2GeGX4Ke2pd8Pzcrou
	39n7UVCjR0z6BNYyIKU2RN2ZdEBDoBmxjoD2fqw2NbrmVBEYE3sE4IPBEtmoijZyeLyd1BpMLPw
	kX+A6a9SMcMpemLQl7zQJY87rIO8JUhoXbxz0VZpbUyrD0oSHd0HSSYDcFsDqIw==
X-Received: by 2002:adf:f7cc:0:b0:33e:7001:b80 with SMTP id a12-20020adff7cc000000b0033e70010b80mr2144977wrq.68.1709889463622;
        Fri, 08 Mar 2024 01:17:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqrB/Wr7d6c5l6BA1N9F9yZh5GCQNss8QEYQHaGYCgv+XMRDZap2yJ1HZG3tWOGhvlzlPStg==
X-Received: by 2002:adf:f7cc:0:b0:33e:7001:b80 with SMTP id a12-20020adff7cc000000b0033e70010b80mr2144951wrq.68.1709889463117;
        Fri, 08 Mar 2024 01:17:43 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6c68.dip0.t-ipconnect.de. [91.12.108.104])
        by smtp.gmail.com with ESMTPSA id q2-20020adfea02000000b0033e7a102cfesm125654wrm.64.2024.03.08.01.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 01:17:42 -0800 (PST)
Message-ID: <17925693-574c-4dda-9c2c-171acace93cf@redhat.com>
Date: Fri, 8 Mar 2024 10:17:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: prohibit the last subpage from reusing the entire
 large folio
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, minchan@kernel.org,
 fengwei.yin@intel.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
 peterx@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com,
 songmuchun@bytedance.com, wangkefeng.wang@huawei.com, xiehuan09@gmail.com,
 zokeefe@google.com, chrisl@kernel.org, yuzhao@google.com,
 Barry Song <v-songbaohua@oppo.com>, Lance Yang <ioworker0@gmail.com>
References: <20240308085653.124180-1-21cnbao@gmail.com>
 <4392e407-b9cf-4785-a926-3eb143708260@redhat.com>
 <CAGsJ_4zvsW-h24s9PGn-U-6=HO-U7hjWfNiNe5O6ZX-cwnkT3w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4zvsW-h24s9PGn-U-6=HO-U7hjWfNiNe5O6ZX-cwnkT3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.03.24 10:07, Barry Song wrote:
> On Fri, Mar 8, 2024 at 10:03 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.03.24 09:56, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> In a Copy-on-Write (CoW) scenario, the last subpage will reuse the entire
>>> large folio, resulting in the waste of (nr_pages - 1) pages. This wasted
>>> memory remains allocated until it is either unmapped or memory
>>> reclamation occurs.
>>>
>>> The following small program can serve as evidence of this behavior
>>>
>>>    main()
>>>    {
>>>    #define SIZE 1024 * 1024 * 1024UL
>>>            void *p = malloc(SIZE);
>>>            memset(p, 0x11, SIZE);
>>>            if (fork() == 0)
>>>                    _exit(0);
>>>            memset(p, 0x12, SIZE);
>>>            printf("done\n");
>>>            while(1);
>>>    }
>>>
>>> For example, using a 1024KiB mTHP by:
>>>    echo always > /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/enabled
>>>
>>> (1) w/o the patch, it takes 2GiB,
>>>
>>> Before running the test program,
>>>    / # free -m
>>>                   total        used        free      shared  buff/cache   available
>>>    Mem:            5754          84        5692           0          17        5669
>>>    Swap:              0           0           0
>>>
>>>    / # /a.out &
>>>    / # done
>>>
>>> After running the test program,
>>>    / # free -m
>>>                    total        used        free      shared  buff/cache   available
>>>    Mem:            5754        2149        3627           0          19        3605
>>>    Swap:              0           0           0
>>>
>>> (2) w/ the patch, it takes 1GiB only,
>>>
>>> Before running the test program,
>>>    / # free -m
>>>                    total        used        free      shared  buff/cache   available
>>>    Mem:            5754          89        5687           0          17        5664
>>>    Swap:              0           0           0
>>>
>>>    / # /a.out &
>>>    / # done
>>>
>>> After running the test program,
>>>    / # free -m
>>>                   total        used        free      shared  buff/cache   available
>>>    Mem:            5754        1122        4655           0          17        4632
>>>    Swap:              0           0           0
>>>
>>> This patch migrates the last subpage to a small folio and immediately
>>> returns the large folio to the system. It benefits both memory availability
>>> and anti-fragmentation.
>>>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Lance Yang <ioworker0@gmail.com>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> ---
>>>    mm/memory.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index e17669d4f72f..0200bfc15f94 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3523,6 +3523,14 @@ static bool wp_can_reuse_anon_folio(struct folio *folio,
>>>                folio_unlock(folio);
>>>                return false;
>>>        }
>>> +     /*
>>> +      * If the last subpage reuses the entire large folio, it would
>>> +      * result in a waste of (nr_pages - 1) pages
>>> +      */
>>> +     if (folio_ref_count(folio) == 1 && folio_test_large(folio)) {
>>> +             folio_unlock(folio);
>>> +             return false;
>>> +     }
>>>        /*
>>>         * Ok, we've got the only folio reference from our mapping
>>>         * and the folio is locked, it's dark out, and we're wearing
>>
>>
>> Why not simply:
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index e17669d4f72f7..46d286bd450c6 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3498,6 +3498,10 @@ static vm_fault_t wp_page_shared(struct vm_fault
>> *vmf, struct folio *folio)
>>    static bool wp_can_reuse_anon_folio(struct folio *folio,
>>                                       struct vm_area_struct *vma)
>>    {
>> +
>> +       if (folio_test_large(folio))
>> +               return false;
>> +
>>           /*
>>            * We have to verify under folio lock: these early checks are
>>            * just an optimization to avoid locking the folio and freeing
>>
>> We could only possibly succeed if we are the last one mapping a PTE
>> either way. No we simply give up right away for the time being.
> 
> nice !

.. of course, adding a comment like

"We could currently only reuse a subpage of a large folio if no other 
subpages of the large folios are still mapped. However, let's just 
consistently not reuse subpages even if we could reuse in that scenario, 
and give back a large folio a bit sooner."

The !fotk() case would be more tricky to handle, because the folio has 
PAE set and may be pinned or we might race with pinning. So this here is 
the low hanging fruit.

-- 
Cheers,

David / dhildenb


