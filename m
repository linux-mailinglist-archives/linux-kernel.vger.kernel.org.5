Return-Path: <linux-kernel+bounces-162653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEC48B5E98
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D108E284789
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA4574400;
	Mon, 29 Apr 2024 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lVsWtbiK"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D583A18
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406790; cv=none; b=qqU/StYvyAR1Dj8BQYxaip+DGNyyXb/ZuxQlj7pJfwc1bnOnjG7hpACyU8vOIF3sDmv7hy3e6TAkzlRkIObblMqK5nrNxumKAj4nYfJnfEgJTwh5kBjLVaRibOIRRWH4b9fbfk8XIa3Am2c5T6XDNFM5YYK2eL1I/mvwtOMygs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406790; c=relaxed/simple;
	bh=uPC1BgfoZ/0CNcgBlxO1uJXrO4xZEvVHlQ6M555k1V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsinA2viHyuXG6XYmfpyRVUhnVq1PmZ58gv56NdpgwzRn6T9feTwSjuVSt3IyRcE2LMfArbev3DA1tI7ctvgn+PsHxa+fLSqGfKnWEygKoCeUWFTz4yMcuSeSUrXosRkDnjWj/mepYt20E3HJdo2KvAfREYFHMBBzCTk/UB0Bsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lVsWtbiK; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 09:06:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714406787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2nXwXohL2J0wPP0PlowVYkLxMx+ryb/FZdWBx8UgrY=;
	b=lVsWtbiK/0p4r9CmGvVnCV6zeaDp1O564nKflx9dr53zJ7/KNLSKPHL4kLZgSDTToYH7Yo
	vyIq9SIsJw1b/CYQKvjAmTWYJg7bAPBXISxpqdKoUOEBLkDIdn0l4v/Sqv+FmY028v9hJt
	0o5LZ9J1li3JG2PkWrpsS42DxUfVMOg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] memcg: pr_warn_once for unexpected events and
 stats
Message-ID: <Zi_Ff_iAs_PTph4l@P9FQF9L96D>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-6-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427003733.3898961-6-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 05:37:31PM -0700, Shakeel Butt wrote:
> To reduce memory usage by the memcg events and stats, the kernel uses
> indirection table and only allocate stats and events which are being
> used by the memcg code. To make this more robust, let's add warnings
> where unexpected stats and events indexes are used.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/memcontrol.c | 43 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 103e0e53e20a..36145089dcf5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -671,9 +671,11 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
>  		return node_page_state(lruvec_pgdat(lruvec), idx);
>  
>  	i = memcg_stats_index(idx);
> -	if (i >= 0) {
> +	if (likely(i >= 0)) {
>  		pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
>  		x = READ_ONCE(pn->lruvec_stats->state[i]);
> +	} else {
> +		pr_warn_once("%s: stat item index: %d\n", __func__, idx);
>  	}

I think it's generally a CONFIG_DEBUG_VM material. Do we have some extra
concerns here?

Having pr_warn_on_once() would be nice here.

