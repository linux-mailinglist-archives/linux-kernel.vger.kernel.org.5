Return-Path: <linux-kernel+bounces-162977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB788B62ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F231F22A25
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F05813AD30;
	Mon, 29 Apr 2024 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HUZ44vPb"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC2513247D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420592; cv=none; b=OV0XylWToOdGloUERsrhRgbQ2LmhXMApHgC5YtojIac8ftgio+kE5z53gaxVaSWevKc6mhjaWUUGWC+3bSCk27FWINdAdKVTV8Cqrw7IAaPt7a9WMNDcFrvZoueYC29aF++qwZljYQh0+cGuLy2vqbiHPbbLX2qdXQVPK63iWXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420592; c=relaxed/simple;
	bh=w0oorwqXbrMrKPsb6M/aRLQrz/nsFuZ0VYTdqgpRW+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5Uu5Ra9Xpylgp24vANB0F5CMewz4IRXPDMtnZrP4LOXFVQqIY4MZVQ0IPbm8lnPx0987EYtMM0s7xz43LPeZ4tgKLFYx6EfbjPRfej1cdTEz3kGv1+FmiMe+nj3qhrXCPfcYOpa5CQyy02sT7xxaFD/pileqpMeJ6Mo967XOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HUZ44vPb; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 12:56:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714420588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxSwxDMr1PsnyOzythgKPWt6orPHRWexAENBx6E26ik=;
	b=HUZ44vPbbhgAmbzwCGAm+Lo/ZtUT67pE2IJvRjQGLyTesQGJJF8P7ZbZZAC09WpbeTFDd/
	BoZpivwMQ+8X6rGu8xamvaiwIXz2b84nGEczaBO/BV+yEpgCy5jK4SpYRDWytUgrdG1C1m
	3xD/xxu3zVQkjqMO4hi9Nq6l9DEzRjY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] memcg: pr_warn_once for unexpected events and
 stats
Message-ID: <tmz7rmypu6whkuz6jkek3oog5p6zioaraujjhve5uxnjoegzmc@vzel5asjhdla>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-6-shakeel.butt@linux.dev>
 <Zi_Ff_iAs_PTph4l@P9FQF9L96D>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi_Ff_iAs_PTph4l@P9FQF9L96D>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 29, 2024 at 09:06:23AM -0700, Roman Gushchin wrote:
> On Fri, Apr 26, 2024 at 05:37:31PM -0700, Shakeel Butt wrote:
> > To reduce memory usage by the memcg events and stats, the kernel uses
> > indirection table and only allocate stats and events which are being
> > used by the memcg code. To make this more robust, let's add warnings
> > where unexpected stats and events indexes are used.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  mm/memcontrol.c | 43 ++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 34 insertions(+), 9 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 103e0e53e20a..36145089dcf5 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -671,9 +671,11 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
> >  		return node_page_state(lruvec_pgdat(lruvec), idx);
> >  
> >  	i = memcg_stats_index(idx);
> > -	if (i >= 0) {
> > +	if (likely(i >= 0)) {
> >  		pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> >  		x = READ_ONCE(pn->lruvec_stats->state[i]);
> > +	} else {
> > +		pr_warn_once("%s: stat item index: %d\n", __func__, idx);
> >  	}
> 
> I think it's generally a CONFIG_DEBUG_VM material. Do we have some extra
> concerns here?
> 
> Having pr_warn_on_once() would be nice here.

No extra concern, just want this indirection table to be up to date in
future.

