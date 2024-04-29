Return-Path: <linux-kernel+bounces-162966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED868B62CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEB228397E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E8413B2BC;
	Mon, 29 Apr 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sgWt1An2"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2787839FD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420001; cv=none; b=OHFfxGSv1Y5xHDbkHWBPLx8Io2NKVR/4fLMlw6gEC15PRbF51hu1qMCwWMjcJ6zmvwx4feq5mqmVs2Rtp/28LthSgw5EoK5/6SZ1y1OZhm2hCVVS6q2o8uZx11xxLikK9HL/CTA5BdZUrdoBJuNrljngxnq+/tSzyNL63yT4pb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420001; c=relaxed/simple;
	bh=a0MCZvyt3kJaAOrmL3OAu/2EhxYaFMLR5UetA8zD4NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6bB0TAzDCB2jBX9TxQNdquMan9c1NtEKGYVuVhJuETezWKVhqVetI/zg0mdspBhWPlmiPNI6IalUIXf5O0laSqmrKJZn69Q9EFIFY75GyKQ56u2GUQw8yq2V4zmPPm61Cw9ASAR6yQZOdsnOS1bSm+dRIUIkeRuiD4AqxQUcvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sgWt1An2; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 12:46:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714419996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y1WEB6RzCqCuX7Z+BbEKtZP6s+NxySx/uW1PWUvKOFE=;
	b=sgWt1An2hPV1lyHHvEXOIJtMsZZlCWBtR2Rb4kypKeBamwx3dIlZyBHzI1a2c+l826ZZXr
	Pn205wwwOjaAvRHFCqLFJU9A7zWx27uVJvOrKyVic7BvVQ6SPQrIGME921+LD9smTvsmRP
	i4iBTSQrlmze93ONreGziI4zAbBKGrg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] memcg: dynamically allocate lruvec_stats
Message-ID: <fs26xbxmaylxwpv35pb3aak2ilb352glnabsi3wq4havqzlg4j@62cltkwiup4z>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-3-shakeel.butt@linux.dev>
 <Zi_BsznrtoC1N_lq@P9FQF9L96D>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi_BsznrtoC1N_lq@P9FQF9L96D>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 29, 2024 at 08:50:11AM -0700, Roman Gushchin wrote:
> On Fri, Apr 26, 2024 at 05:37:28PM -0700, Shakeel Butt wrote:
[...]
> > +unsigned long lruvec_page_state_local(struct lruvec *lruvec,
> > +				      enum node_stat_item idx)
> > +{
> > +	struct mem_cgroup_per_node *pn;
> > +	long x = 0;
> > +
> > +	if (mem_cgroup_disabled())
> > +		return node_page_state(lruvec_pgdat(lruvec), idx);
> > +
> > +	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> > +	x = READ_ONCE(pn->lruvec_stats->state_local[idx]);
> > +#ifdef CONFIG_SMP
> > +	if (x < 0)
> > +		x = 0;
> > +#endif
> 
> Not directly related to your change, but do we still need it? And if yes,
> do we really care about !CONFIG_SMP case enough to justify these #ifdefs?
> 

That's a good question and I think this is still needed. Particularly on
large machines with large number of CPUs, we can have a situation where
the flusher is flushing the CPU 100 and in parallel some workload
allocated a lot of pages on, let's say, CPU 0 and freed on CPU 200.

> > +	return x;
> > +}
> > +
> >  /* Subset of vm_event_item to report for memcg event stats */
> >  static const unsigned int memcg_vm_event_stat[] = {
> >  	PGPGIN,
> > @@ -5492,18 +5546,25 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
> >  	if (!pn)
> >  		return 1;
> >  
> > +	pn->lruvec_stats = kzalloc_node(sizeof(struct lruvec_stats), GFP_KERNEL,
> > +					node);
> 
> Why not GFP_KERNEL_ACCOUNT?
> 

Previously struct lruvec_stats was part of struct mem_cgroup_per_node
and we use GFP_KERNEL to allocate struct mem_cgroup_per_node. I kept the
behavior same and if we want to switch to GFP_KERNEL_ACCOUNT, I think it
should be a separate patch.

Thanks for the review.
Shakeel

