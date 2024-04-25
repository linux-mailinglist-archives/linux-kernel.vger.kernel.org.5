Return-Path: <linux-kernel+bounces-158780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A318B24D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C3F1C223F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062CB14A633;
	Thu, 25 Apr 2024 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CI1gmBoJ"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036C414A62E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058122; cv=none; b=DNmF5+66DRrLko525GsH79W3ub2NAcdT3aiARZRfQrnLZ3uSB5X9u8zINEibelUXCIXdfCgzpPZu/EEj6/HVXsOi9tGpCHY6GWAsxCQglPnrdhxrYxGqZJ9o832b1SfNEjbVUb2wht47/6ikG9/4jAhWIjRG++zeKVExMV4GO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058122; c=relaxed/simple;
	bh=HJQucwaCmek8dkLX1V1brbSeNsUowbJOgC0qPVIeT5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldQvJURcL4c/bovWV0AuZ3ggwaFDftd4Xld+T2iPDsVcYC982F/gpnRD0N3CxjOmxz2v8ulAdUJ+j5rcTjXWF3CfHc/pXQQskNi9WYnThcXc6rKQT9ltjiIyGfofjvevQIqT8/y63q4S+3n/QywocmtnMM2EIruBzwjftk+jWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CI1gmBoJ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5c34b253-b476-494a-96c9-fe3c95b9b74d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714058114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZyCEiDB794H0D6y6L88y3ywwU1X/3LX93YpO6CxtZCE=;
	b=CI1gmBoJCJOchdIwbeCtHlv2TeilpTqx6HUFllreyv5TaDQSTi+lbYa52P3VU4EYR/Z14I
	dDurtOEmT4AWAdWa8tbmbIOeh5VIr8vN8b+TlctZFFO8QLX0g/kavySs4ktjKupVj5mRz/
	erJA9+yE9FPyfRtVFJLD3lSXeh5HFbA=
Date: Thu, 25 Apr 2024 23:14:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] slub: Fixes freepointer encoding for single free
To: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
References: <Zij_fGjRS_rK-65r@archlinux>
 <f9c133a9-8886-4c86-a24f-4778997547f2@linux.dev>
 <bbf2063f-54d4-43f0-84b3-1ea789470914@clip-os.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <bbf2063f-54d4-43f0-84b3-1ea789470914@clip-os.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/4/25 23:02, Nicolas Bouchinet wrote:
> Hy,
> 
> First of all, thanks a lot for your time.
> 
> On 4/25/24 10:36, Chengming Zhou wrote:
>> On 2024/4/24 20:47, Nicolas Bouchinet wrote:
>>> From: Nicolas Bouchinet<nicolas.bouchinet@ssi.gouv.fr>
>>>
>>> Commit 284f17ac13fe ("mm/slub: handle bulk and single object freeing
>>> separately") splits single and bulk object freeing in two functions
>>> slab_free() and slab_free_bulk() which leads slab_free() to call
>>> slab_free_hook() directly instead of slab_free_freelist_hook().
>> Right.
>>
>>> If `init_on_free` is set, slab_free_hook() zeroes the object.
>>> Afterward, if `slub_debug=F` and `CONFIG_SLAB_FREELIST_HARDENED` are
>>> set, the do_slab_free() slowpath executes freelist consistency
>>> checks and try to decode a zeroed freepointer which leads to a
>>> "Freepointer corrupt" detection in check_object().
>> IIUC, the "freepointer" can be checked on the free path only when
>> it's outside the object memory. Here slab_free_hook() zeroed the
>> freepointer and caused the problem.
>>
>> But why we should zero the memory outside the object_size? It seems
>> more reasonable to only zero the object_size when init_on_free is set?
> 
> The original purpose was to avoid leaking information through the object and its metadata / tracking information as described in init_on_free initial Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options").
> 
> I have to admit I didn't read the entire lore about the original patchset yet, though it could be interesting to know a bit more the threat models, specifically regarding the object metadata init.

Thank you for the reference! I also don't get why it needs to zero
the metadata and tracking information.

> 
> The patch could also be optimized a bit by restricting set_freepointer() call to the `CONFIG_SLAB_FREELIST_HARDENED` option value.
> 

Yeah. Maybe memcg_alloc_abort_single() needs this too.

Thanks.

> Thanks again, Nicolas
> 
>>
>> Thanks.
>>
>>> Object's freepointer thus needs to be properly set using
>>> set_freepointer() after init_on_free.
>>>
>>> To reproduce, set `slub_debug=FU init_on_free=1 log_level=7` on the
>>> command line of a kernel build with `CONFIG_SLAB_FREELIST_HARDENED=y`.
>>>
>>> dmesg sample log:
>>> [   10.708715] =============================================================================
>>> [   10.710323] BUG kmalloc-rnd-05-32 (Tainted: G    B           T ): Freepointer corrupt
>>> [   10.712695] -----------------------------------------------------------------------------
>>> [   10.712695]
>>> [   10.712695] Slab 0xffffd8bdc400d580 objects=32 used=4 fp=0xffff9d9a80356f80 flags=0x200000000000a00(workingset|slab|node=0|zone=2)
>>> [   10.716698] Object 0xffff9d9a80356600 @offset=1536 fp=0x7ee4f480ce0ecd7c
>>> [   10.716698]
>>> [   10.716698] Bytes b4 ffff9d9a803565f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> [   10.720703] Object   ffff9d9a80356600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> [   10.720703] Object   ffff9d9a80356610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> [   10.724696] Padding  ffff9d9a8035666c: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> [   10.724696] Padding  ffff9d9a8035667c: 00 00 00 00                                      ....
>>> [   10.724696] FIX kmalloc-rnd-05-32: Object at 0xffff9d9a80356600 not freed
>>>
>>> Signed-off-by: Nicolas Bouchinet<nicolas.bouchinet@ssi.gouv.fr>
>>> ---
>>>   mm/slub.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index 3aa12b9b323d9..71dbff9ad8f17 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -4342,10 +4342,16 @@ static __fastpath_inline
>>>   void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>>>              unsigned long addr)
>>>   {
>>> +    bool init = false;
>>> +
>>>       memcg_slab_free_hook(s, slab, &object, 1);
>>> +    init = slab_want_init_on_free(s);
>>>   -    if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
>>> +    if (likely(slab_free_hook(s, object, init))) {
>>> +        if (init)
>>> +            set_freepointer(s, object, NULL);
>>>           do_slab_free(s, slab, object, object, 1, addr);
>>> +    }
>>>   }
>>>     static __fastpath_inline

