Return-Path: <linux-kernel+bounces-102922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CBF87B86C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A800D1F23F89
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D15C618;
	Thu, 14 Mar 2024 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="obQF8Otv"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E75C61C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400793; cv=none; b=LbQBlEyN+EA4V3iDE0yIWcY/mdO6OgViXosmpJq4diI9qUF8t7xWPfUfFSca4i6FkJ5k8XbqUXILo9I9fGqODMwPy8SiduluoaueAW1lhG71yU3JxKBmJ9b1RC64bSSpGte1e5lb3A3+1pOwkN1x6J4oaPGT6I340sqtD57cv6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400793; c=relaxed/simple;
	bh=0M2cm1Jc/VWt/XHwW7EsdJ2bfFGKjawM2McxQYObnbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oH2SwYzkFvhttBKRcS+I8OvG4f//l6iDbmLJE39dW+7r+5gSlJwOOBuYTrVnjE8D7j9em8Ol5mFRHnBs+eXYQtQ8YAiUZYA+Tb8nkvSfyMYg6jWoCgRoFLFYtkuqgpZJB5Rk5nsTog1YqPtbglOnDSPWSuwU2LJ3ePX0Ch7H5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=obQF8Otv; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710400788; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4VyEpQvKnzsnbyb4g0kdtIVt+NLI3n4kn6UGAi3EzQw=;
	b=obQF8OtvyLgn6rupQl7YTWHf8HXuFUiZlEFZfeLzds9l7qH+6eOiA8H5iIE2pJETSQs8TIX6iOUxuyjFHzWVe9tc+1NaKTijvoUe//+aRxUV1xdH2WLgnReFt9qdlqhUEF0lxNt3NanL8+VgCqPIPomAjW5TK8gbRlKRgg1DXwA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W2RhI75_1710400786;
Received: from 30.97.56.71(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W2RhI75_1710400786)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 15:19:47 +0800
Message-ID: <ea5d5bb6-32a5-4161-95cd-3dc916576bf7@linux.alibaba.com>
Date: Thu, 14 Mar 2024 15:19:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/compaction: add and use
 for_each_populated_zone_pgdat() helper
To: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
 jhubbard@nvidia.com, vbabka@suse.cz, mgorman@suse.de, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, dave@stgolabs.net, p.raghav@samsung.com,
 da.gomez@samsung.com
References: <20240314005436.2962962-1-mcgrof@kernel.org>
 <20240314005436.2962962-3-mcgrof@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240314005436.2962962-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/14 08:54, Luis Chamberlain wrote:
> We can just wrap most of the work done on fragmentation_score_node()
> into a pgdat helper for populated zones. Add the helper and use it.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   include/linux/mmzone.h | 8 ++++++++
>   mm/compaction.c        | 9 ++-------
>   2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index a497f189d988..1fd74c7100ec 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1597,6 +1597,14 @@ extern struct zone *next_zone(struct zone *zone);
>   			; /* do nothing */		\
>   		else
>   
> +#define for_each_populated_zone_pgdat(zone, pgdat)	\
> +	for (zone = pgdat->node_zones;			\
> +	     zone;					\
> +	     zone = next_zone(zone))			\
> +		if (!populated_zone(zone))		\
> +			; /* do nothing */		\
> +		else

I think this will break the original logics, since the next_zone() will 
iterate over all memory zones, instead of only the memory zones of the 
specified node.

>   static inline struct zone *zonelist_zone(struct zoneref *zoneref)
>   {
>   	return zoneref->zone;
> diff --git a/mm/compaction.c b/mm/compaction.c
> index b961db601df4..023a09d0786d 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2151,16 +2151,11 @@ static unsigned int fragmentation_score_zone_weighted(struct zone *zone)
>   static unsigned int fragmentation_score_node(pg_data_t *pgdat)
>   {
>   	unsigned int score = 0;
> +	struct zone *zone;
>   	int zoneid;
>   
> -	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
> -		struct zone *zone;
> -
> -		zone = &pgdat->node_zones[zoneid];
> -		if (!populated_zone(zone))
> -			continue;
> +	for_each_populated_zone_pgdat(zone, pgdat)
>   		score += fragmentation_score_zone_weighted(zone);
> -	}
>   
>   	return score;
>   }

