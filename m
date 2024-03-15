Return-Path: <linux-kernel+bounces-104259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5949787CB59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170AC283E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5629E18AED;
	Fri, 15 Mar 2024 10:28:14 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C31118639;
	Fri, 15 Mar 2024 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498493; cv=none; b=roC6U6HQuMc3oOeJpuro438jd5PJ+PrQYmfjb9esMLF9Q9Y9TGJY0T9Fke5zHuDx01fDlAuHSD2KeBfnbtJPQrBUF5g0WLxkJ+cHZAGN3GOC6LmUuPfai8GyHvOxLvhynUs7glGFvLsx3a/qlcDZr89jEEVWjZfkP5iGdMiW+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498493; c=relaxed/simple;
	bh=Iv0x2jG6fkJKU7Yp76qxZKkJ2e7AMpTyhB8i6Zc2IcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOWSWn0FYjXEfNTA6DdGjzUYPA5BUS6r2ObH/yxb0xsZni+W1dHOELklzNvlaURX9jbV4hLDMzfnob40XHMrSsLhClsGjOFaJ62U6maBGWjQ+Ts8CNmNCR/ouFT0HMuFVk2SoksFHeybfwZRB5LUyoOEKz7OSYWNUUBWsTxgR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tx0nW4NnSz4f3khP;
	Fri, 15 Mar 2024 18:27:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 647841A0EA9;
	Fri, 15 Mar 2024 18:28:05 +0800 (CST)
Received: from [10.67.110.48] (unknown [10.67.110.48])
	by APP1 (Coremail) with SMTP id cCh0CgCHoguxIvRlMGMUHA--.35833S2;
	Fri, 15 Mar 2024 18:28:05 +0800 (CST)
Message-ID: <65f4c948-06fd-4c15-b9b8-0c8d23568e13@huaweicloud.com>
Date: Fri, 15 Mar 2024 18:28:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] slab: Introduce dedicated bucket allocator
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Xiu Jianfeng <xiujianfeng@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Jann Horn <jannh@google.com>,
 Matteo Rizzo <matteorizzo@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20240305100933.it.923-kees@kernel.org>
 <b5f9f094-51d3-445a-b19b-99fc1cd7cac1@huaweicloud.com>
 <202403071227.D29DE5F8C4@keescook>
From: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
In-Reply-To: <202403071227.D29DE5F8C4@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCHoguxIvRlMGMUHA--.35833S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXryxCF1UJFW5tr4xWF15Jwb_yoW5Aw17pr
	WrXF92ya1UJr1UAFyvvw18Wr1F9a1SgF45J3s0gw1rZrnIyw1Ivr1jy343ZF97CryDta1U
	XrWqy3Wfuwn8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/



On 2024/03/08 4:31, Kees Cook wrote:
> On Wed, Mar 06, 2024 at 09:47:36AM +0800, GONG, Ruiqi wrote:
>>
>>
>> On 2024/03/05 18:10, Kees Cook wrote:
>>> Hi,
>>>
>>> Repeating the commit logs for patch 4 here:
>>>
>>>     Dedicated caches are available For fixed size allocations via
>>>     kmem_cache_alloc(), but for dynamically sized allocations there is only
>>>     the global kmalloc API's set of buckets available. This means it isn't
>>>     possible to separate specific sets of dynamically sized allocations into
>>>     a separate collection of caches.
>>>
>>>     This leads to a use-after-free exploitation weakness in the Linux
>>>     kernel since many heap memory spraying/grooming attacks depend on using
>>>     userspace-controllable dynamically sized allocations to collide with
>>>     fixed size allocations that end up in same cache.
>>>
>>>     While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
>>>     against these kinds of "type confusion" attacks, including for fixed
>>>     same-size heap objects, we can create a complementary deterministic
>>>     defense for dynamically sized allocations.
>>>
>>>     In order to isolate user-controllable sized allocations from system
>>>     allocations, introduce kmem_buckets_create(), which behaves like
>>>     kmem_cache_create(). (The next patch will introduce kmem_buckets_alloc(),
>>>     which behaves like kmem_cache_alloc().)
>>
>> So can I say the vision here would be to make all the kernel interfaces
>> that handles user space input to use separated caches? Which looks like
>> creating a "grey zone" in the middle of kernel space (trusted) and user
>> space (untrusted) memory. I've also thought that maybe hardening on the
>> "border" could be more efficient and targeted than a mitigation that
>> affects globally, e.g. CONFIG_RANDOM_KMALLOC_CACHES.
> 
> I think it ends up having a similar effect, yes. The more copies that
> move to memdup_user(), the more coverage is created. The main point is to
> just not share caches between different kinds of allocations. The most
> abused version of this is the userspace size-controllable allocations,
> which this targets. 

I agree. Currently if we want to fulfill a more strict separation
between user-space manageable memory and other memory in kernel space,
technically speaking for fixed size allocations we could transform them
into using dedicated caches (i.e. kmem_cache_create()), but for dynamic
size allocations I don't think of any solution. With the APIs provided
by this patch set, we've got something that works.


> ... The existing caches (which could still be used for
> type confusion attacks when the sizes are sufficiently similar) have a
> good chance of being mitigated by CONFIG_RANDOM_KMALLOC_CACHES already,
> so this proposed change is just complementary, IMO.

Maybe in the future we could require that all user-kernel interfaces
that make use of SLAB caches should use either kmem_cache_create() or
kmem_buckets_create()? ;)

> 
> -Kees
> 


