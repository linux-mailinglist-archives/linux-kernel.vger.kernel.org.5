Return-Path: <linux-kernel+bounces-163084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E198A8B64FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0248DB21B01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EAE190686;
	Mon, 29 Apr 2024 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ixxDWaYp"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE81779BD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427971; cv=none; b=XQY6Id57g32SuctaX0FvQsM8XuENyIpvVQ56Li9B5bMd6yBw2GJjxrVUfuaAWUsYu6xbGcTxUGaNDMVNHTITa0wkM2Hul+JfpfrESY3P9hEch2w81Sw3Wk5S5EFsS5X/6xEhLMLvbZOX97ovm4Mx7JerEMkhc9lM9AgizHZldOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427971; c=relaxed/simple;
	bh=Sm/QhYaANzS96GQWMRGXzHvIopnHpQxaOfBEBSIv3tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ76zaC+CG1/15+wh68J9McIVUX6noUXrjXOP/EFRUih9uFrHKHBgPbKxlqDC5fZYOruk4wvn8tkUk1CN3GJdOStCXFdAnX6PwjuNAi4vDLo6TMntwaPm/qQDGLiDpAyEQ/s9ypcemSeraxz6QoPwv7+EY8oYH/W3IxTkuommR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ixxDWaYp; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 14:59:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714427967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2oq8GpknbuUizjxkKnYJjGUQCiIjEtDOZULkmvv0Vfs=;
	b=ixxDWaYpir3Wna7zhULD0rDFlZCTLryAoW7WU11UVrwuHqwNsrvNiRagbc6zExkzSrcFzK
	IKfT0T/zXOd2uOg4/R6TnRAOMeZ59JeTJyWRoWhzm3thd3XZq7KC0lQUSUcOwDEs06tvF2
	wQ2ttgJn8cCQ2VMbm5P1Pr4rGyoxPnE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] memcg: dynamically allocate lruvec_stats
Message-ID: <fxdydsynztkijk666x6rjjnokykigop5e77erb6jvflsxr32sx@tezn4jgjsp5v>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-3-shakeel.butt@linux.dev>
 <Zi_BsznrtoC1N_lq@P9FQF9L96D>
 <fs26xbxmaylxwpv35pb3aak2ilb352glnabsi3wq4havqzlg4j@62cltkwiup4z>
 <ZjAK32S2eG_sI-kv@P9FQF9L96D>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjAK32S2eG_sI-kv@P9FQF9L96D>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 29, 2024 at 02:02:23PM -0700, Roman Gushchin wrote:
> On Mon, Apr 29, 2024 at 12:46:32PM -0700, Shakeel Butt wrote:
> > On Mon, Apr 29, 2024 at 08:50:11AM -0700, Roman Gushchin wrote:
> > > On Fri, Apr 26, 2024 at 05:37:28PM -0700, Shakeel Butt wrote:
> > [...]
> > 
> > > > +	return x;
> > > > +}
> > > > +
> > > >  /* Subset of vm_event_item to report for memcg event stats */
> > > >  static const unsigned int memcg_vm_event_stat[] = {
> > > >  	PGPGIN,
> > > > @@ -5492,18 +5546,25 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
> > > >  	if (!pn)
> > > >  		return 1;
> > > >  
> > > > +	pn->lruvec_stats = kzalloc_node(sizeof(struct lruvec_stats), GFP_KERNEL,
> > > > +					node);
> > > 
> > > Why not GFP_KERNEL_ACCOUNT?
> > > 
> > 
> > Previously struct lruvec_stats was part of struct mem_cgroup_per_node
> > and we use GFP_KERNEL to allocate struct mem_cgroup_per_node. I kept the
> > behavior same and if we want to switch to GFP_KERNEL_ACCOUNT, I think it
> > should be a separate patch.
> 
> Agree. Here is the patch:

Awesome, I will pull this in my v3 post.

> 
> --
> 
> From fd6854c0b272c5314bce6c9dee7d3c8f8cee3a86 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <roman.gushchin@linux.dev>
> Date: Mon, 29 Apr 2024 13:57:26 -0700
> Subject: [PATCH] mm: memcg: account memory used for memcg vmstats and lruvec
>  stats
> 
> The percpu memory used by memcg's memory statistics is already accounted.
> For consistency, let's enable accounting for vmstats and lruvec stats
> as well.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

> ---
>  mm/memcontrol.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d11536ef59ef..2fe25d49cfaa 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5661,8 +5661,8 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  	if (!pn)
>  		return 1;
>  
> -	pn->lruvec_stats = kzalloc_node(sizeof(struct lruvec_stats), GFP_KERNEL,
> -					node);
> +	pn->lruvec_stats = kzalloc_node(sizeof(struct lruvec_stats),
> +					GFP_KERNEL_ACCOUNT, node);
>  	if (!pn->lruvec_stats)
>  		goto fail;
>  
> @@ -5733,7 +5733,8 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>  		goto fail;
>  	}
>  
> -	memcg->vmstats = kzalloc(sizeof(struct memcg_vmstats), GFP_KERNEL);
> +	memcg->vmstats = kzalloc(sizeof(struct memcg_vmstats),
> +				 GFP_KERNEL_ACCOUNT);
>  	if (!memcg->vmstats)
>  		goto fail;
>  
> -- 
> 2.43.2
> 

