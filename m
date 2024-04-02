Return-Path: <linux-kernel+bounces-127348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED47894A23
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A2E285B38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1317592;
	Tue,  2 Apr 2024 03:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wq+KPU+3"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E65317548
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 03:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712029534; cv=none; b=LN9CJ7wWIsdpushjtWmknfaMVSKVbPa8zf1NJ0j9VvfjTCeAuyaXnEQ5U3sfISAoH913k6fGql99Zdn81ri41kOSrrVbbPRVVHc3Y5g+WQId5CNhQKzD8OWdrlhOpF6mftJmil1XMiRkdkRWU1bC0x3SZNoc7qOIQEzeV586mPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712029534; c=relaxed/simple;
	bh=7dgiUriDY4VZjwc2oAQqkax26dA3fiwMlLDWRorrSbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxA2tvSS/lXVwbvGl4URN+EFBSaIRGuDyZXb1sr6CNou5FNLqroPsQWkp97Z7z9qkBUexg4nH0g6gklAw/MxXKFH0UyBGfiQJZ21hGAL6TwltZ3rAmJ3Ov94cwvOSFq2o4rNSR/5PYV7ytg5LCKTmXeC5gJLGAiyMVe0+M813dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wq+KPU+3; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cd42083e-ea53-48bd-aa32-a16fc9f73ffa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712029529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctTsajfD2CFhooWbZgthbVIMHuKKMcgzYtu6va2X7T0=;
	b=Wq+KPU+3aGgby5YAp/hOzF4o4cV84D9KTn5dccOP/qIjuiQLkUs8CP3K5j0bHgNbq15Lp3
	2sfFFbnCYx0+OnTFfwWwo0P5nG5aYQtWfUQGEan35u6dgCBwmlPBnV2XgbnSeLDkmcW732
	jyFSZZHPaihVL3Re3fLjeIRNMeFT0YA=
Date: Tue, 2 Apr 2024 11:45:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] slub: fix slub segmentation
To: Ming Yang <yangming73@huawei.com>, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: zhangliang5@huawei.com, wangzhigang17@huawei.com, liushixin2@huawei.com,
 alex.chen@huawei.com, pengyi.pengyi@huawei.com, xiqi2@huawei.com
References: <20240402031025.1097-1-yangming73@huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240402031025.1097-1-yangming73@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/4/2 11:10, Ming Yang wrote:
> When one of numa nodes runs out of memory and lots of processes still
> booting, slabinfo shows much slub segmentation exits. The following
> shows some of them:
> 
> tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs>
> <num_slabs> <sharedavail>
> kmalloc-512        84309 380800   1024   32    8 :
> tunables    0    0    0 : slabdata  11900  11900      0
> kmalloc-256        65869 365408    512   32    4 :
> tunables    0    0    0 : slabdata  11419  11419      0
> 
> 365408 "kmalloc-256" objects are alloced but only 65869 of them are
> used; While 380800 "kmalloc-512" objects are alloced but only 84309
> of them are used.
> 
> This problem exits in the following senario:
> 1. Multiple numa nodes, e.g. four nodes.
> 2. Lack of memory in any one node.
> 3. Functions which alloc many slub memory in certain numa nodes,
> like alloc_fair_sched_group.
> 
> The slub segmentation generated because of the following reason:
> In function "___slab_alloc" a new slab is attempted to be gotten via
> function "get_partial". If the argument 'node' is assigned but there
> are neither partial memory nor buddy memory in that assigned node, no
> slab could be gotten. And then the program attempt to alloc new slub
> from buddy system, as mentationed before: no buddy memory in that
> assigned node left, a new slub might be alloced from the buddy system
> of other node directly, no matter whether there is free partil memory
> left on other node. As a result slub segmentation generated.
> 
> The key point of above allocation flow is: the slab should be alloced
> from the partial of other node first, instead of the buddy system of
> other node directly.
> 
> In this commit a new slub allocation flow is proposed:
> 1. Attempt to get a slab via function get_partial (first step in
> new_objects lable).
> 2. If no slab is gotten and 'node' is assigned, try to alloc a new
> slab just from the assigned node instead of all node.
> 3. If no slab could be alloced from the assigned node, try to alloc
> slub from partial of other node.
> 4. If the alloctation in step 3 fails, alloc a new slub from buddy
> system of all node.

FYI, there is another patch to the very same problem:

https://lore.kernel.org/all/20240330082335.29710-1-chenjun102@huawei.com/

> 
> Signed-off-by: Ming Yang <yangming73@huawei.com>
> Signed-off-by: Liang Zhang <zhangliang5@huawei.com>
> Signed-off-by: Zhigang Wang <wangzhigang17@huawei.com>
> Reviewed-by: Shixin Liu <liushixin2@huawei.com>
> ---
> This patch can be tested and verified by following steps:
> 1. First, try to run out memory on node0. echo 1000(depending on your memory) > 
> /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages.
> 2. Second, boot 10000(depending on your memory) processes which use setsid 
> systemcall, as the setsid systemcall may likely call function 
> alloc_fair_sched_group.
> 3. Last, check slabinfo, cat /proc/slabinfo.
> 
> Hardware info:
> Memory : 8GiB
> CPU (total #): 120
> numa node: 4
> 
> Test clang code example:
> int main() {
>     void *p = malloc(1024);
>     setsid();
>     while(1);
> }
> 
>  mm/slub.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 1bb2a93cf7..3eb2e7d386 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3522,7 +3522,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	}
>  
>  	slub_put_cpu_ptr(s->cpu_slab);
> +	if (node != NUMA_NO_NODE) {
> +		slab = new_slab(s, gfpflags | __GFP_THISNODE, node);
> +		if (slab)
> +			goto slab_alloced;
> +
> +		slab = get_any_partial(s, &pc);
> +		if (slab)
> +			goto slab_alloced;
> +	}
>  	slab = new_slab(s, gfpflags, node);
> +
> +slab_alloced:
>  	c = slub_get_cpu_ptr(s->cpu_slab);
>  
>  	if (unlikely(!slab)) {

