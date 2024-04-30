Return-Path: <linux-kernel+bounces-164787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E1D8B82D6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8971F23B37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD4E44C8C;
	Tue, 30 Apr 2024 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sEmKXuMs"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1A129E72
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518051; cv=none; b=tTThTwEHMSu/wKguApADxOS+sTxT1AIA0DkGHYu5KZxt3M92BJRsUPx35EqiB1+/xPR19KiUn6AgExw9YI0Am0N812AoqXrIQiWEEeKFJwhCgEeZ5G1guV+OX262DUk9CWcWppSQ73+4slpL2BY3KQpiu2o3SuOpw+1+wt1Nlxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518051; c=relaxed/simple;
	bh=a7tAcJXwom+s+uXCOJcRVhUgJEZG/cOxHfzIa0V0PO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTJ3LMcSVqDp/4LBIQ9OUO097mPrOVYGWc+GxmF9yTAMmCp7dtS3wlNqkPboYy0FRG2YrUxj+fDo1G6wpys3AF/Ex6xlZgwV0Kx0ARq9Pv5u299TeaWkvS8LG6uAqXQVoJO4poR4Dxv8SVkgtxWrFJx851ttVaeU7vcrldyMIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sEmKXuMs; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 30 Apr 2024 16:00:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714518046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUW4oNFaD0o6Bd2QS09RU7OZsgb/vrqxqdIPqn7qFTM=;
	b=sEmKXuMs/tKb6YFbpFESPjYFZZneT4newThJeg2ABphFxrhnt/dYKudgLEjR8CmGYem0HV
	5pxkQ+/qWntvBI7Mxgy0YzGMKozzD0M80LEqFnTeTBUm3lw3mzdr3UYNBhDt/WRj3Sixkz
	9RlUVI277LiDMnD31IAQvgoqF0I6cyY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	"T . J . Mercier" <tjmercier@google.com>, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] memcg: reduce memory for the lruvec and memcg
 stats
Message-ID: <gmel2s2pysaavfetoqit3zq7grcrsbbfqh7sitg577yip7knwh@bufhf7ymlyd7>
References: <20240430060612.2171650-1-shakeel.butt@linux.dev>
 <20240430060612.2171650-5-shakeel.butt@linux.dev>
 <CAJD7tkZnXY+Nbip8e6c7WC4qoYC21x=MHop_hT4NqYLKL8Fp6Q@mail.gmail.com>
 <u3okwix7ovvzzfossbmfalwpq23qa3bmv3secg7tpjk7ghyemq@w3ngvr526rc2>
 <CAJD7tkZh-bLHQhaPsU7h1WUmK3xwHVoacVcR=P55i+7d0FzfFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZh-bLHQhaPsU7h1WUmK3xwHVoacVcR=P55i+7d0FzfFw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 30, 2024 at 10:41:01AM -0700, Yosry Ahmed wrote:
> On Tue, Apr 30, 2024 at 10:38 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Tue, Apr 30, 2024 at 01:41:38AM -0700, Yosry Ahmed wrote:
> > > On Mon, Apr 29, 2024 at 11:06 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > [...]
> > > > +
> > > > +#define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> > > > +#define NR_MEMCG_STATS (NR_MEMCG_NODE_STAT_ITEMS + ARRAY_SIZE(memcg_stat_items))
> > > > +static int8_t mem_cgroup_stats_index[MEMCG_NR_STAT] __read_mostly;
> > >
> > > NR_MEMCG_STATS and MEMCG_NR_STAT are awfully close and have different
> > > meanings. I think we should come up with better names (sorry nothing
> > > comes to mind) or add a comment to make the difference more obvious.
> > >
> >
> > How about the following comment?
> 
> The comment LGTM. I prefer renaming them though if someone can come up
> with better names.
> 

I will be posting v4 and will change the name (still thinking about the
name) becasuse:

> > > > +static void init_memcg_stats(void)
> > > > +{
> > > > +       int8_t i, j = 0;
> > > > +
> > > > +       /* Switch to short once this failure occurs. */
> > > > +       BUILD_BUG_ON(NR_MEMCG_STATS >= 127 /* INT8_MAX */);

The above should be MEMCG_NR_STAT instead of NR_MEMCG_STATS.

