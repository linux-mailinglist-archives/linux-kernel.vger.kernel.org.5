Return-Path: <linux-kernel+bounces-104215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 178C287CAD2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4DD1F21C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A8417C6C;
	Fri, 15 Mar 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C3aFG4x4"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D751759F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710495589; cv=none; b=dIyya6f9MjoG2dC8AiPNaS0tdMb5gNk9p74ypHXLMqon+fFvDF/Ud6vzn44csI7ZjAriVC/qS0DFo56PAeetMZjo8NsPDuX9d8+0tR25obWNT/gxoCoZ9HgoNy3ArVsQ18+NPjPFTg5NSGf8oDh4qSovIkIrUQ4mcAb4Apsanhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710495589; c=relaxed/simple;
	bh=J8ElAc5vWbxiOARtFToRBrhnfwqtndNYCZKY+Hxo2Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3PH1pB4zMv+xVEW/MfVC3iAOqFrfk4ZEWF4u49bUqDNGYWnVMZaRJrzaqohmzSBXUvVshc3vG+WsLoFtP5MzwFQXRcsOimfpMrbbel0b7nWjiup7gXpWQ5/R4n0GeMiHDoNbz6NzcMoopo96/S9ZlJzXAHM+IG/Z6d4KcWXOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C3aFG4x4; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710495578; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CckLzddbXrBA7tLsEPMXeJY8BUpksVSkSO2q/7+hZh8=;
	b=C3aFG4x4tNEvGPHs1KxnXwdn/ijgYtHBcxTkoe6NKiiY6DWl/YP8qacGSBe/2Qq7ydeT8N4OdaAwNUsP/LRS/AcFrEY5PzCp+nJqQV7f2fWGc6tEIvgB3y8XGwj1NT7AsGWkgVtTKPU7UAAxUmwFgiUfl8JmIzMSWJOEP8EIeWg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W2W4c5I_1710495576;
Received: from 30.97.56.65(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W2W4c5I_1710495576)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 17:39:37 +0800
Message-ID: <f65a6c7c-7dc6-4d57-9b65-a15a978d0d52@linux.alibaba.com>
Date: Fri, 15 Mar 2024 17:39:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/compaction: add and use
 for_each_populated_zone_pgdat() helper
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, jhubbard@nvidia.com, vbabka@suse.cz,
 mgorman@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dave@stgolabs.net, p.raghav@samsung.com, da.gomez@samsung.com
References: <20240314005436.2962962-1-mcgrof@kernel.org>
 <20240314005436.2962962-3-mcgrof@kernel.org>
 <ea5d5bb6-32a5-4161-95cd-3dc916576bf7@linux.alibaba.com>
 <ZfPe22p9U8PiRB0W@bombadil.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZfPe22p9U8PiRB0W@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/15 13:38, Luis Chamberlain wrote:
> On Thu, Mar 14, 2024 at 03:19:45PM +0800, Baolin Wang wrote:
>>
>>
>> On 2024/3/14 08:54, Luis Chamberlain wrote:
>>> We can just wrap most of the work done on fragmentation_score_node()
>>> into a pgdat helper for populated zones. Add the helper and use it.
>>>
>>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>>> ---
>>>    include/linux/mmzone.h | 8 ++++++++
>>>    mm/compaction.c        | 9 ++-------
>>>    2 files changed, 10 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index a497f189d988..1fd74c7100ec 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -1597,6 +1597,14 @@ extern struct zone *next_zone(struct zone *zone);
>>>    			; /* do nothing */		\
>>>    		else
>>> +#define for_each_populated_zone_pgdat(zone, pgdat)	\
>>> +	for (zone = pgdat->node_zones;			\
>>> +	     zone;					\
>>> +	     zone = next_zone(zone))			\
>>> +		if (!populated_zone(zone))		\
>>> +			; /* do nothing */		\
>>> +		else
>>
>> I think this will break the original logics, since the next_zone() will
>> iterate over all memory zones, instead of only the memory zones of the
>> specified node.
> 
> Definitely, thanks, so we'd need something like this in addition:
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 34b729fc751b..bd11d33ea14d 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1568,6 +1568,7 @@ static inline struct pglist_data *NODE_DATA(int nid)
>   extern struct pglist_data *first_online_pgdat(void);
>   extern struct pglist_data *next_online_pgdat(struct pglist_data *pgdat);
>   extern struct zone *next_zone(struct zone *zone);
> +extern struct zone *next_zone_pgdat(struct zone *zone, struct pglist_data *pgdat);
>   
>   /**
>    * for_each_online_pgdat - helper macro to iterate over all online nodes
> @@ -1600,7 +1601,7 @@ extern struct zone *next_zone(struct zone *zone);
>   #define for_each_populated_zone_pgdat(zone, pgdat)	\
>   	for (zone = pgdat->node_zones;			\
>   	     zone;					\
> -	     zone = next_zone(zone))			\
> +	     zone = next_zone_pgdat(zone, pgdat))	\
>   		if (!populated_zone(zone))		\
>   			; /* do nothing */		\
>   		else
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 015126803017..96434f6fc1ad 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2152,7 +2152,6 @@ static unsigned int fragmentation_score_node(pg_data_t *pgdat)
>   {
>   	unsigned int score = 0;
>   	struct zone *zone;
> -	int zoneid;
>   
>   	for_each_populated_zone_pgdat(zone, pgdat)
>   		score += fragmentation_score_zone_weighted(zone);
> diff --git a/mm/mmzone.c b/mm/mmzone.c
> index c01896eca736..043a6dc16c05 100644
> --- a/mm/mmzone.c
> +++ b/mm/mmzone.c
> @@ -43,6 +43,18 @@ struct zone *next_zone(struct zone *zone)
>   	return zone;
>   }
>   
> +/*
> + * next_zone_pgdat - helper magic for for_each_zone() per node
> + */
> +struct zone *next_zone_pgdat(struct zone *zone, struct pglist_data *pgdat)
> +{
> +	if (!zone || !pgdat)
> +		return NULL;

Seems unnecessary, you already accessed them before calling 
next_zone_pgdat(). Otherwise, looks good to me.

> +	if (zone < pgdat->node_zones + MAX_NR_ZONES - 1)
> +		return ++zone;
> +	return NULL;
> +}
> +
>   static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
>   {
>   #ifdef CONFIG_NUMA

