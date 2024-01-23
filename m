Return-Path: <linux-kernel+bounces-34974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12187838A16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF6E282EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EB45A0EB;
	Tue, 23 Jan 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FtGeokez"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462635A0E1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001459; cv=none; b=VK4TmMSzNDpwGtWdHbSvvN0nIdWf930TWQUyvL5kXq1EV2LDO7DCc3FkpwGuNTD+9NV7q2arPDjSXuD6koey0Zbr1Ei5XJbcyiflkhH/vfVH75w8CeUkcLE3FrXn6qpxAwTEZs6mt2kkraiWvIFDOlfJsSeI4EFw2Af+6Zcsytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001459; c=relaxed/simple;
	bh=vMa2hStUb/HBHEAOmVVBt9+phjXe3qp/wDiYbJU4sDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHkNHm4/Yqrz8+Mcc0wb19MyieY/rO02q747Ug1tLqDYkWOkeWygTeAsvnMw4TjWR1Urs94tmtmR39tDP8Z+LndKkkU4Q+0+uRMSW0h97eyFhm34lfruhKt93iOReyYjz6d1AybWQjIDpzyaV5GyVdwsu3Wy8t63x3y8nEe9+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FtGeokez; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cf1f4f6c3dso1943593a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706001456; x=1706606256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUofm+ew+Pio2petyAhks6Ox3YcBrjMrAFlRRu8MTNM=;
        b=FtGeokezO2CUvVljfkucoRaoAOyu+Z0z4uR1wE8XBmsIgKk4UDm1rlO+aBXIlpwp9z
         SvlFU4Q0sSx0t9ATp6HJ4W9COS5MzdkTzxoFT/nFOjz1RKEwXGRYNV2XRup8XUa1PMe3
         9q3JFJP2DT+ix9vZ/DlafgvwLz0+IOGQuhHnAmu0viLReYjOKiTlwhhyuQIYLL8cZ05D
         alX3tcGcAUXYnK5466rQPKVKqcAQHoMKT+ygOPU83+VHgvcwXHenmeaDxXDkzvAqS3fA
         uiEbBckR/mUYlQVuamPjmq1LLuH4SD+BUq0TE2lwVdzLae3kXHsXl+O3Otb6OUEDAY1G
         hFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706001456; x=1706606256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUofm+ew+Pio2petyAhks6Ox3YcBrjMrAFlRRu8MTNM=;
        b=gPXOqQaAYqcuqxqJvnZiEeTKV9y+ObjcggdzDt7vINItQPO3rxRt6P9qylx5CSIp/8
         zsYfKy8OCJmOFXEL8siAkL/JaMBW3/vYiLWu+DIKvrpzOOfJrH1s5aSrw/BVxgvTYIfA
         qD4ALBBu6XVBJeZP+TFZ0Bol2uZcigVQpi+4gfbWwJXjBL+/x3l3uXM8hyFotQBKsujr
         Sso5JUkyTjdNVm19bFo2WPAvgcFWijLWGMwbOwSlcMRaBliDvhkrBxChhwxCWVAf4qIP
         2rYS2GN0ic53uVK304DcsNAcgE/rlrozjWHUwgI4PFgg6uCsT0AB8gIk/X/WFIGeP6HW
         WwyQ==
X-Gm-Message-State: AOJu0YycgICBT2zS4Qjk8jMt7mV6yorf6znk4Xbc7AORyCq/9Qaf/P+l
	Thv1h4MIsIJ/ZGViyAHrfB1udEOa4gUZTeQATO2hd2fty7PQVl6yQmLYyJJ4Rog=
X-Google-Smtp-Source: AGHT+IG4RfqW8JyEOUwbE/yAxGB8roRfEGq+y6WPhU1adbIWKyE4aKVODNKSfoY5U8n2iQea6YKh7A==
X-Received: by 2002:a05:6a20:47ca:b0:199:a934:db77 with SMTP id ey10-20020a056a2047ca00b00199a934db77mr2675981pzb.61.1706001456550;
        Tue, 23 Jan 2024 01:17:36 -0800 (PST)
Received: from [10.254.236.83] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902e9c400b001d706e373a9sm8274921plk.292.2024.01.23.01.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 01:17:36 -0800 (PST)
Message-ID: <85f44b37-982f-4363-804b-7572a8e503cf@bytedance.com>
Date: Tue, 23 Jan 2024 17:17:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/slub: directly load freelist from cpu partial slab
 in the likely case
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>,
 "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
 <20240117-slab-misc-v1-1-fd1c49ccbe70@bytedance.com>
 <76641777-1918-2b29-b6aa-bda9b5467aa3@gentwo.org>
 <412b8618-0941-4d9d-85df-ee480695e7f7@bytedance.com>
 <a2132c63-99a5-7fa2-9f2a-cccf6b40fe9e@linux.com>
 <e81d914b-8718-4dbb-a2d8-d5298fe66d1a@bytedance.com>
 <ac0ce290-58a7-42b2-a7e4-72e241717c63@suse.cz>
 <36964450-f45a-4f35-a187-dc493246ef59@bytedance.com>
 <0974c3b7-a964-44b6-a588-e08c6f79eec9@suse.cz>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <0974c3b7-a964-44b6-a588-e08c6f79eec9@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/23 16:24, Vlastimil Babka wrote:
> On 1/23/24 03:51, Chengming Zhou wrote:
>> On 2024/1/23 01:13, Vlastimil Babka wrote:
>>> On 1/19/24 04:53, Chengming Zhou wrote:
>>>> On 2024/1/19 06:14, Christoph Lameter (Ampere) wrote:
>>>>> On Thu, 18 Jan 2024, Chengming Zhou wrote:
>>>>>
>>>>>> So get_freelist() has two cases to handle: cpu slab and cpu partial list slab.
>>>>>> The latter is NOT frozen, so need to remove "VM_BUG_ON(!new.frozen)" from it.
>>>>>
>>>>> Right so keep the check if it is the former?
>>>>>
>>>>
>>>> Ok, I get it. Maybe like this:
>>>
>>> I think that's just too ugly for a VM_BUG_ON(). I'd just remove the check
>>> and be done with that.
>>
>> Ok with me.
>>
>>>
>>> I have a somewhat different point. You reused get_freelist() but in fact
>>> it's more like freeze_slab(), but that one uses slab_update_freelist() and
>>> we are under the local_lock so we want the cheaper __slab_update_freelist(),
>>> which get_freelist() has and I guess that's why you reused that one.
>>
>> Right, we already have the lock_lock, so reuse get_freelist().
>>
>>>
>>> However get_freelist() also assumes it can return NULL if the freelist is
>>> empty. If that's possible to happen on the percpu partial list, we should
>>> not "goto load_freelist;" but rather create a new label above that, above
>>> the "if (!freelist) {" block that handles the case.
>>>
>>> If that's not possible to happen (needs careful audit) and we have guarantee
>>
>> Yes, it's not possible for now.
>>
>>> that slabs on percpu partial list must have non-empty freelist, then we
>>> probably instead want a new __freeze_slab() variant that is like
>>> freeze_slab(), but uses __slab_update_freelist() and probably also has
>>> VM_BUG_ON(!freelist) before returning it?
>>>
>>
>> Instead of introducing another new function, how about still reusing get_freelist()
>> and VM_BUG_ON(!freelist) after calling it? I feel this is simpler.
> 
> Could you measure if introducing new function that sets new.frozen = 1; has
> any performance benefit? If not, we can reuse get_freelist() as you say.
> Thanks!
> 

I just tested using the new function: __freeze_slab() that uses __slab_update_freelist()
and sets new.frozen = 1, but found the performance is a little worse than reusing
get_freelist().

The reason I think maybe more code memory footprint? I don't look deep into that.

Anyway it looks better to reuse get_freelist(), I will update a version later.

Thanks!

