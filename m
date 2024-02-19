Return-Path: <linux-kernel+bounces-71031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77600859FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07753B20AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DAA2420B;
	Mon, 19 Feb 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eIZhqnr7"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64422619
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334952; cv=none; b=dGVCWyN+jpY76PKvdqB5vRJ+rjd1ZK7slTekDTq3C0l3phR+hzHf6r0TQ1euzszi5DTGIyEQ6QJ6XVpj+ajm+V/aJRVcucRqciLtqukc6v8q9CmBT2XLJc1GqHzHv42mxA4xQFuW3ec6kuy/072SEPUllNm2YNh1kqLBIR0VDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334952; c=relaxed/simple;
	bh=8CoylulTAEPvrrxYqutK8C/EWczUJIagkSI2Q6zcuuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u44JsBph6SV3pVw6VGC+DYteQs2OjiljS2CNbA39xY+OiTZStwcmli7bmKClKIdJxbxWsi6jZAfzWUwTU++kxj5bYR1YBzbl6+IRzwtE1DAjxqFFdODexbBu4yDN/kJDQ1Cvy9KjlhhI3P82AazPk8KJxaJo/gQCwYFXGUqop94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eIZhqnr7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso58387b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708334949; x=1708939749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eP/nvuVRApSzC8OZKm0vUFPbTbVhx//KVCst0ly11Aw=;
        b=eIZhqnr7VC/aWmmjaNdmIAqbgRZ6oqvoeiZ9fv4/z2GrTE5cQr2s3i9ssUV+b6TBEi
         WwDsevnQaduadbwAOqR9pSropd5sC+wN5/bdCqoHGq5JxVlzdoovhNNXo+fttqwv9ygV
         rzq53oO+bD++4Cs/mHLnlmmH0Fxxmk41bXLcCFZhoSdTlOUK4Ljxucb8Lrc5iiq1ffqL
         lrEXuV/dZSNG0PnuXQqRJMvoWrzVG43oWOM7Gce5pHCgvtiL6EKKNR8xsU46f1n6mpO2
         njqnCZBDm+7rCa4Bl/0ZqlPXpu4yKQTYYAit5G8MI30/K7uz2Xa3sncdu7tKQjm6Du2N
         /1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708334949; x=1708939749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eP/nvuVRApSzC8OZKm0vUFPbTbVhx//KVCst0ly11Aw=;
        b=Et5sc4oyPiLzNrFTY7wXdCOp4dsD+qkvAQhzr7cntJrGtfnU1napCzgCO0NZXxscOO
         DzhgcPZieCyd1PIr9Nd70N6RCMViNaOfYq4bY6LZEZmNBgkvlgO0h/09YKgZFdF8r3o9
         kH4C+JkaYg0ng942FiMoM+/jLWS4uztA6X3UhMt/EjVgmw8Vb1an5Kp8N2RQxtYgGjpS
         7J2siP8kPMJblwbZa2BIFf9gkjEbz2NPT2OD2LhgV8p1UG94OHmCXsIjstBiXDkUEANB
         KPwIq5c+iCDXFq5+aM3jFr4PSZl1JdjWXrlVsRXio6Gs1H0qwl0M7vj0yJKAEntMjs27
         MzCg==
X-Forwarded-Encrypted: i=1; AJvYcCUzGfUSyEkAUgi0SjXWdjcYvyWyhF1UGgu9Qzy0O4iaaY8fcRmvv9h0JsKVM0bxRKGA9ICeC9T7uNsPjixZqCHP8ByFVMMaB/M0avDo
X-Gm-Message-State: AOJu0YwVza5ZSUd1duPC5zn6HRERJkoehLOo4vWNidILd7Mc6KwcW8uY
	BZeZ5iq564IZlumqzT2PqvH7FmoGFwGGkJcsWN+/zn2lbEOQ+nPn4CzG79Xg4u4=
X-Google-Smtp-Source: AGHT+IEDWc2aeMYUyqp4/+7uxFHY+P3vcz/cOChgNrp3m3uNKEBcxdYHq7qiIwEQVSIz+3pL/G1IUw==
X-Received: by 2002:a62:cec5:0:b0:6e4:6484:1a36 with SMTP id y188-20020a62cec5000000b006e464841a36mr1883032pfg.21.1708334949026;
        Mon, 19 Feb 2024 01:29:09 -0800 (PST)
Received: from [10.4.192.10] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7984f000000b006e0651ec052sm4355808pfq.32.2024.02.19.01.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 01:29:08 -0800 (PST)
Message-ID: <5cf40e33-d1ae-4ac9-9d01-559b86f853a8@bytedance.com>
Date: Mon, 19 Feb 2024 17:29:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>,
 Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
 akpm@linux-foundation.org, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
 <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
 <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/19 16:30, Vlastimil Babka wrote:
> On 2/18/24 20:25, David Rientjes wrote:
>> On Thu, 15 Feb 2024, Jianfeng Wang wrote:
>>
>>> When reading "/proc/slabinfo", the kernel needs to report the number of
>>> free objects for each kmem_cache. The current implementation relies on
>>> count_partial() that counts the number of free objects by scanning each
>>> kmem_cache_node's partial slab list and summing free objects from all
>>> partial slabs in the list. This process must hold per kmem_cache_node
>>> spinlock and disable IRQ. Consequently, it can block slab allocation
>>> requests on other CPU cores and cause timeouts for network devices etc.,
>>> if the partial slab list is long. In production, even NMI watchdog can
>>> be triggered because some slab caches have a long partial list: e.g.,
>>> for "buffer_head", the number of partial slabs was observed to be ~1M
>>> in one kmem_cache_node. This problem was also observed by several

Not sure if this situation is normal? It maybe very fragmented, right?

SLUB completely depend on the timing order to place partial slabs in node,
which maybe suboptimal in some cases. Maybe we could introduce anti-fragment
mechanism like fullness grouping in zsmalloc to have multiple lists based
on fullness grouping? Just some random thoughts... :)

>>> others [1-2] in the past.
>>>
>>> The fix is to maintain a counter of free objects for each kmem_cache.
>>> Then, in get_slabinfo(), use the counter rather than count_partial()
>>> when reporting the number of free objects for a slab cache. per-cpu
>>> counter is used to minimize atomic or lock operation.
>>>
>>> Benchmark: run hackbench on a dual-socket 72-CPU bare metal machine
>>> with 256 GB memory and Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.3 GHz.
>>> The command is "hackbench 18 thread 20000". Each group gets 10 runs.
>>>
>>
>> This seems particularly intrusive for the common path to optimize for 
>> reading of /proc/slabinfo, and that's shown in the benchmark result.
>>
>> Could you discuss the /proc/slabinfo usage model a bit?  It's not clear if 
>> this is being continuously read, or whether even a single read in 
>> isolation is problematic.
>>
>> That said, optimizing for reading /proc/slabinfo at the cost of runtime 
>> performance degradation doesn't sound like the right trade-off.
> 
> It should be possible to make this overhead smaller by restricting the
> counter only to partial list slabs, as [2] did. This would keep it out of
> the fast paths, where it's really not acceptable.
> Note [2] used atomic_long_t and the percpu counters used here should be
> lower overhead. So basically try to get the best of both attemps.

Right, the current count_partial() also only iterate over slabs on the
node partial list, doesn't include slabs on the cpu partial list. So this
new percpu counter should also only include slabs on node partial list.
Then the overhead should be lower.


