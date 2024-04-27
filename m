Return-Path: <linux-kernel+bounces-160841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6198B4371
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 03:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 688AEB21FCD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A064F2E852;
	Sat, 27 Apr 2024 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dgOep0XN"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED62D03B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 01:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714180700; cv=none; b=gppy6JUb+RdP43wBlW0KfsKb3OjKIi3xd9Y7iBDPuL+z2w44Noe3uAQi9YThJ7NkXt11j6OjOhtnQt6QVKK+ltFfNhdCePq7cf55fOX4Sqo6zVNbuDHdtFzegnwFAINsDW9Qz98Pbyo5jxm6ulWfsFcx+eP+hnq/mG0jArkMUXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714180700; c=relaxed/simple;
	bh=PQ9kSUdxKpcoVtjr3Xzztl1OBwFz5xRRUt4ftMTSovk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtaVxhBVYol9dDNmNz23rWuc+It0obJGNiO79LeFZzxXYkrxqMeya2xe2OGDqwepSnvcFymEe2uC6WlIKWTrmINGRqeGw+kZJF8GVxaoRVFHK1k/Q9mvyrYFBy3HQbEd1X5Rissatvyl/fQ4ZIOyPFuDG9PTL3iU1dbATEKO/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dgOep0XN; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Apr 2024 18:18:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714180696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KyQAvNmH8cK+YgrZdteZGkEfU1LsqfdtvT92BFP4zs=;
	b=dgOep0XNlHGarvM2anPP/ocidn8aiFauFWMVL/4H+jO07miUU7fqfv5JREfQWrhxIbJNch
	USGIoyNCjOMiZoftkwWiZRd68UzI59DYglctp7HxWO1n4Y/jmFQ/NxOkZ2mD17TqSFe77+
	8GmQ9urU6LOMfEywqhlZXcewZn0q3Ac=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] memcg: pr_warn_once for unexpected events and
 stats
Message-ID: <dsxeqlmrxyxfi2i7yzhdrukwiczh7sjcwfobaytdgkckjez36b@u6ooikkgyyf4>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-6-shakeel.butt@linux.dev>
 <CAJD7tkZJBBOfhHXfweJu367ov0GnppLTiUMLdoq=TcWnqu2q5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZJBBOfhHXfweJu367ov0GnppLTiUMLdoq=TcWnqu2q5w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 05:58:16PM -0700, Yosry Ahmed wrote:
> On Fri, Apr 26, 2024 at 5:38 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
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
> >                 return node_page_state(lruvec_pgdat(lruvec), idx);
> >
> >         i = memcg_stats_index(idx);
> > -       if (i >= 0) {
> > +       if (likely(i >= 0)) {
> >                 pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> >                 x = READ_ONCE(pn->lruvec_stats->state[i]);
> > +       } else {
> > +               pr_warn_once("%s: stat item index: %d\n", __func__, idx);
> >         }
> 
> Can we make these more compact by using WARN_ON_ONCE() instead:
> 
> if (WARN_ON_ONCE(i < 0))
>          return 0;
> 
> I guess the advantage of using pr_warn_once() is that we get to print
> the exact stat index, but the stack trace from WARN_ON_ONCE() should
> make it obvious in most cases AFAICT.
> 
> No strong opinions either way.

One reason I used pr_warn_once() over WARN_ON_ONCE() is the syzbot
trigger. No need to trip the bot over this error condition.

