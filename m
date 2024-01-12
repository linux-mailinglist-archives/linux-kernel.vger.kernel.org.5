Return-Path: <linux-kernel+bounces-24897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B15A82C45F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7995F1C2231B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB7517540;
	Fri, 12 Jan 2024 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Azs5GhsS"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDCC1AABB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Jan 2024 09:10:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705079451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McdqJF13JJY95fe2wVB3NPXE39DtpV52lmmGUDjCt/8=;
	b=Azs5GhsSQc0JX1eVWdKhQOMnykKCEd0TUAy5wBRqscrGBpynqnH9NrztgOh9i4qcO4ySG5
	JCfXydZMdgx15mjGt63BsD9HBndIph9DkxlorF1HV18ImX9uxbRs2qO3pyfDiSz8yEtYsx
	2tt8hW1AI1BDy8SQGP2BvUcqYYj+by0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.high
Message-ID: <ZaFyiTFC-ped0IdA@P9FQF9L96D.corp.robot.car>
References: <20240111132902.389862-1-hannes@cmpxchg.org>
 <ZaAsbwFP-ttYNwIe@P9FQF9L96D>
 <20240111192807.GA424308@cmpxchg.org>
 <ZaFxn7JC8FeR-Si0@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaFxn7JC8FeR-Si0@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 12, 2024 at 06:06:39PM +0100, Michal Hocko wrote:
> On Thu 11-01-24 14:28:07, Johannes Weiner wrote:
> [...]
> > @@ -2867,11 +2882,17 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  		}
> >  	} while ((memcg = parent_mem_cgroup(memcg)));
> >  
> > +	/*
> > +	 * Reclaim is set up above to be called from the userland
> > +	 * return path. But also attempt synchronous reclaim to avoid
> > +	 * excessive overrun while the task is still inside the
> > +	 * kernel. If this is successful, the return path will see it
> > +	 * when it rechecks the overage and simply bail out.
> > +	 */
> >  	if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
> >  	    !(current->flags & PF_MEMALLOC) &&
> > -	    gfpflags_allow_blocking(gfp_mask)) {
> > +	    gfpflags_allow_blocking(gfp_mask))
> >  		mem_cgroup_handle_over_high(gfp_mask);
> 
> Have you lost the check for the dying task here?

It was moved into mem_cgroup_handle_over_high()'s body.

