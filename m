Return-Path: <linux-kernel+bounces-93204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359AB872C52
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6689F1C21D83
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148ED7499;
	Wed,  6 Mar 2024 01:48:02 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC219F;
	Wed,  6 Mar 2024 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689681; cv=none; b=ltvzjAyvrKwiuAumv5EA4dGf5KqVbFWbPs3Qfy2t9wA/y3hf7qadvibzA+bt32BfS0t8/adCBpCTOVFQZ4UulL/3n+EbHRo+/WcKNGA3ugqc6UJQeRVRKLzZDaHocVI/AjgGlrFEXMvbZ/0H4WpM5S2IN4PDFBOPYHyZnPwTisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689681; c=relaxed/simple;
	bh=+hFi36aMqZWsnXpT6JPl1HGKgU1leSL6Y0XDL6EU6VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYseDzZY//AJFtUH969m2MLKDO9xFFyg7dje/7cLdvvxxKz0+HdCcNK0sz0zAKXvoUQhIVN83o52+PQ7Auf9FxYUkNzceLn9cmiGAYAP8KIqiEWFVm/8mSGyWMsERkUZUkYeAz3HfPqv/vIY3BYsLtE0YTALkN79bOhP+xTffgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TqFgT3B7zz4f3kFd;
	Wed,  6 Mar 2024 09:47:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D77871A016E;
	Wed,  6 Mar 2024 09:47:54 +0800 (CST)
Received: from [10.67.110.48] (unknown [10.67.110.48])
	by APP4 (Coremail) with SMTP id gCh0CgBXqGo3y+dl7_isGA--.28780S2;
	Wed, 06 Mar 2024 09:47:54 +0800 (CST)
Message-ID: <b5f9f094-51d3-445a-b19b-99fc1cd7cac1@huaweicloud.com>
Date: Wed, 6 Mar 2024 09:47:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] slab: Introduce dedicated bucket allocator
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Xiu Jianfeng <xiujianfeng@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Jann Horn <jannh@google.com>,
 Matteo Rizzo <matteorizzo@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20240305100933.it.923-kees@kernel.org>
From: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
In-Reply-To: <20240305100933.it.923-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXqGo3y+dl7_isGA--.28780S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zry3Xr4rGw18uFyxZw4rAFb_yoW8WFyxpF
	Z5XryIya1UJr17Aa4kZw18Wr1F9a1xGF45G390gw1rZrnxA3Z29r1jy3y3ZFWfCryDt3WU
	Xryq9w1S9wn8AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/



On 2024/03/05 18:10, Kees Cook wrote:
> Hi,
> 
> Repeating the commit logs for patch 4 here:
> 
>     Dedicated caches are available For fixed size allocations via
>     kmem_cache_alloc(), but for dynamically sized allocations there is only
>     the global kmalloc API's set of buckets available. This means it isn't
>     possible to separate specific sets of dynamically sized allocations into
>     a separate collection of caches.
> 
>     This leads to a use-after-free exploitation weakness in the Linux
>     kernel since many heap memory spraying/grooming attacks depend on using
>     userspace-controllable dynamically sized allocations to collide with
>     fixed size allocations that end up in same cache.
> 
>     While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
>     against these kinds of "type confusion" attacks, including for fixed
>     same-size heap objects, we can create a complementary deterministic
>     defense for dynamically sized allocations.
> 
>     In order to isolate user-controllable sized allocations from system
>     allocations, introduce kmem_buckets_create(), which behaves like
>     kmem_cache_create(). (The next patch will introduce kmem_buckets_alloc(),
>     which behaves like kmem_cache_alloc().)

So can I say the vision here would be to make all the kernel interfaces
that handles user space input to use separated caches? Which looks like
creating a "grey zone" in the middle of kernel space (trusted) and user
space (untrusted) memory. I've also thought that maybe hardening on the
"border" could be more efficient and targeted than a mitigation that
affects globally, e.g. CONFIG_RANDOM_KMALLOC_CACHES.


