Return-Path: <linux-kernel+bounces-70165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEA185943B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35AA91F2137A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D262291E;
	Sun, 18 Feb 2024 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WQOq4yJ4"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0CC184D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 02:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708224744; cv=none; b=rtdmHK5lu+HzMpj2BwCHRE6Xkf1PSN4Zr5GiNlAVeYEtFpO0QwiHIPbATpH4QMRdolKkvF9t7kTTcu8FUo5BrXl/JucQnMvDg0YgobhreHr7cPaRH/BtnGfWQ2/8y4vXAE9rWtICRknxPzeNqjKwqfkNHtrMdub7pS4Kasr5Wug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708224744; c=relaxed/simple;
	bh=qkIEvt0BZRNdHCdZ9zII84LBMUvVdVN+MNWGdSuUQhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ma5kOMIL7uO3L4DEhnggY7Sq66VrLPWLjEGtO8GQXZntlvY2mB5PMP4n+8q1w9xh3dU4qdBwC7e6qhW0NxT+feQfDT0jnNWHwjp02BC/yQ60hSY50Joij40ulQ4MJnaQgMzj0bG8Um+JU1l3njhgc1CjKW6/KHleXeAZawoLnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WQOq4yJ4; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c6fbf221-06f1-43e6-9801-157b2548d31a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708224740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEo9y40FrQbW3MYg4fpLWpV9+DPnE1npkypG6mMinwo=;
	b=WQOq4yJ4wLqqR4VvI1glPgtT8lO4FrpVJUhR3gAAHaPUSMb/qy4Vc1/laptw90Lb1zRsu8
	ANWM/0a+iN4zT8R1k8ZBFyAjCthGc5dM5Foy3hvalbAXe11N6+V2tK4EMiM5Trgf+yzicP
	EiC/tT3vZmtqjIRgnS5n/G8Ixz5dp9g=
Date: Sun, 18 Feb 2024 10:52:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/1] mm/swap: queue reclaimable folio to local rotate
 batch when !folio_test_lru()
Content-Language: en-US
To: Yu Zhao <yuzhao@google.com>
Cc: willy@infradead.org, hannes@cmpxchg.org, yosryahmed@google.com,
 nphamcs@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
References: <20240209115950.3885183-1-chengming.zhou@linux.dev>
 <20240209115950.3885183-2-chengming.zhou@linux.dev>
 <CAOUHufbg6zbqQaw1CPRWKpOv3NR=mi1xb31hG3WFMoZhj406Tw@mail.gmail.com>
 <8123c4be-d696-4e9e-884f-aa12f6099ddb@linux.dev>
 <CAOUHufbVNF_zDm93W2nj+V5G3FrAx7jdcaiO+gdabmG7L_6AOw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAOUHufbVNF_zDm93W2nj+V5G3FrAx7jdcaiO+gdabmG7L_6AOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/15 15:06, Yu Zhao wrote:
> On Wed, Feb 14, 2024 at 4:18 AM Chengming Zhou <chengming.zhou@linux.dev> wrote:
>>
>> On 2024/2/14 15:13, Yu Zhao wrote:
>>> On Fri, Feb 9, 2024 at 6:00 AM <chengming.zhou@linux.dev> wrote:
>>>>
>>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>>
>>>> All LRU move interfaces have a problem that it has no effect if the
>>>> folio is isolated from LRU (in cpu batch or isolated by shrinker).
>>>> Since it can't move/change folio LRU status when it's isolated, mostly
>>>> just clear the folio flag and do nothing in this case.
>>>>
>>>> In our case, a written back and reclaimable folio won't be rotated to
>>>> the tail of inactive list, since it's still in cpu lru_add batch. It
>>>> may cause the delayed reclaim of this folio and evict other folios.
>>>>
>>>> This patch changes to queue the reclaimable folio to cpu rotate batch
>>>> even when !folio_test_lru(), hoping it will likely be handled after
>>>> the lru_add batch which will put folio on the LRU list first, so
>>>> will be rotated to the tail successfully when handle rotate batch.
>>>>
>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>
>>> I don't think the analysis is correct. IIRC, writeback from non
>>> reclaim paths doesn't require isolation and the reclaim path doesn't
>>> use struct folio_batch lru_add.
>>
>> Ah, my bad, I forgot to mention the important context in the message:
>>
>> This is not from the normal reclaim context, it's from zswap writeback
>> reclaim context, which will first set PG_reclaim flag, then submit the
>> async writeback io.
>>
>> If the writeback io complete fast enough, folio_rotate_reclaimable()
>> will be called before that folio put on LRU list (it still in the local
>> lru_add batch, so it's somewhat like isolated too)
>>
>>>
>>> Did you see any performance improvements with this patch? In general,
>>> this kind of patches should have performance numbers to show it really
>>> helps (not just in theory).
>>
>> Right, there are some improvements, the numbers are put in cover letter.
>> But this solution is not good enough, just RFC for discussion. :)
>>
>>                            mm-unstable-hot   zswap-lru-reclaim
>> real                       63.34             62.72
>> user                       1063.20           1060.30
>> sys                        272.04            256.14
>> workingset_refault_anon    2103297.00        1788155.80
>> workingset_refault_file    28638.20          39249.40
>> workingset_activate_anon   746134.00         695435.40
>> workingset_activate_file   4344.60           4255.80
>> workingset_restore_anon    653163.80         605315.60
>> workingset_restore_file    1079.00           883.00
>> workingset_nodereclaim     0.00              0.00
>> pgscan                     12971305.60       12730331.20
>> pgscan_kswapd              0.00              0.00
>> pgscan_direct              12971305.60       12730331.20
>> pgscan_khugepaged          0.00              0.00
>>
>>>
>>> My guess is that you are hitting this problem [1].
>>>
>>> [1] https://lore.kernel.org/linux-mm/20221116013808.3995280-1-yuzhao@google.com/
>>
>> Right, I just see it, it's the same problem. The only difference is that
>> in your case the folio is isolated by shrinker, in my case, the folio is
>> in cpu lru_add batch. Anyway, the result is the same, that folio can't be
>> rotated successfully when writeback complete.
> 
> In that case, a better solution would be to make lru_add add
> (_reclaim() && !_dirty() && !_writeback()) folios at the tail.
> (_rotate() needs to leave _reclaim() set if it fails to rotate.)

Right, this is a solution. But PG_readahead is alias of PG_reclaim,
I'm afraid this would rotate readahead folio to the inactive tail.


