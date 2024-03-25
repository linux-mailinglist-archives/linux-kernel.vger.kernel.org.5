Return-Path: <linux-kernel+bounces-116718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C09688A2D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1B92CAA79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776ED131732;
	Mon, 25 Mar 2024 10:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d4DGGD/0"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147B130E33
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356590; cv=none; b=Vm7HNfgBLp5K+VhGHn3gWXmXa3VK3LIKtkAjA+Uo3aDUAOzQmRNcZviIp2YbXK6l5j4WLMWjh/jZ76Z1W/8JVF7BLfOOo1hwq5+j+oZfmJ7y7S5e7oIgUIl2LPku2/PIXbl70HVGMmMRvgcJjCjk26b2MsARftki0Y47yezcSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356590; c=relaxed/simple;
	bh=CFAG7+wlYVs5oJppka+9s3oZCklww89MXPrxQ18qng0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzYsMyjZq2yg7gbFCR2mGvV55Mg46WQ+ZeC2Pq8G5bz1Uc157yjfI7vIAgfB8qt0FxJMCdOT0d0psvK3O0BtRYiTxVOwVsf0nUl4PAz8k1ZqFX+hKMX3hkGhzvTz38To15dqumiPlSdR5GE50wZ2fZ6vg/K57MvdNKVD6uEw3p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d4DGGD/0; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a5141311-38bf-421e-9058-6c278840fb97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711356585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hwizfNeXGbqaYoJ0zaeiEJXlDodJ6zA25sJH9WWamY=;
	b=d4DGGD/0jmAkwc124lEMo7hWFIjmDSPWuEh4bFbbcEQ6o4p8/dLDthUsYVYY/YnXxNkOpG
	B0WTUJJ5MEUXrnbUqsh40GCRackd1ASgEmXSWkoDxRroxrk5QOnnBskCC20OBSKh5zCwck
	mCETFLbZneItEiObIuvpmsi70V7nr4I=
Date: Mon, 25 Mar 2024 16:49:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/slub: mark racy accesses on slab->slabs
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>, linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <tencent_909E215498A54E4E100E456A92A7F13DAD06@qq.com>
 <8b146695-4ff5-4f9a-ab64-6cbed4168f98@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <8b146695-4ff5-4f9a-ab64-6cbed4168f98@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/25 16:48, Vlastimil Babka wrote:
> On 3/21/24 4:48 AM, linke li wrote:
>> The reads of slab->slabs are racy because it may be changed by
>> put_cpu_partial concurrently. In slabs_cpu_partial_show() and 
>> show_slab_objects(), slab->slabs is only used for showing information.
>>
>> Data-racy reads from shared variables that are used only for diagnostic
>> purposes should typically use data_race(), since it is normally not a
>> problem if the values are off by a little.
>>
>> This patch is aimed at reducing the number of benign races reported by
>> KCSAN in order to focus future debugging effort on harmful races.
>>
>> Signed-off-by: linke li <lilinke99@qq.com>
>> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> 
> Chengming provided feedback to v1 but not offered a Reviewed-by: AFAICS? Or
> maybe will offer it now? :)

Ah, right.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> 
> Vlastimil
> 
>> ---
>>  mm/slub.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 2ef88bbf56a3..0d700f6ca547 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -6052,7 +6052,7 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
>>  				else if (flags & SO_OBJECTS)
>>  					WARN_ON_ONCE(1);
>>  				else
>> -					x = slab->slabs;
>> +					x = data_race(slab->slabs);
>>  				total += x;
>>  				nodes[node] += x;
>>  			}
>> @@ -6257,7 +6257,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
>>  		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
>>  
>>  		if (slab)
>> -			slabs += slab->slabs;
>> +			slabs += data_race(slab->slabs);
>>  	}
>>  #endif
>>  
>> @@ -6271,7 +6271,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
>>  
>>  		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
>>  		if (slab) {
>> -			slabs = READ_ONCE(slab->slabs);
>> +			slabs = data_race(slab->slabs);
>>  			objects = (slabs * oo_objects(s->oo)) / 2;
>>  			len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
>>  					     cpu, objects, slabs);
> 

