Return-Path: <linux-kernel+bounces-164525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223AF8B7EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510521C2250F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35FF1802BA;
	Tue, 30 Apr 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rDrUoMeL"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F924176FBE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498687; cv=none; b=bUFD4KOaQjM9CnG2lqh4KXf3uLOEak2hyCxP+Gso8knuMmod1NSXJmmkskL4L/V3oemkaTVeg+OQ0k+rVoPmuyh9gwJHcYLNeB70EntkICC3VaVMO2BhX4DifeZBYp3FYZXdr1qPRV/zCESUfSkL976LLwDyj9f9ag80OxU262M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498687; c=relaxed/simple;
	bh=34hSQktGxkqeDbt0S9syRNAZLeXfMJ0uxs0JRY/gk8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4Yorxpx5Y7niMo8NAnXA1CKm2HjsXBUlTbH1udcmLLUZ0Anr4gLvRD8piuZNHWXTr9Z8dyRExknypAZETOqoIUw8znzsk4y7OhZryC9ZsQrci4XWyN5nuEG31RtfFkACNB+ykhNtGT+9HwiThRJObpWvD5OK5GnuQHKmzoP/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rDrUoMeL; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 30 Apr 2024 10:37:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714498682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sr9nAHajNUvj1PVNKEpFomcU/dFMtEZKQEJ8f6m4Zfw=;
	b=rDrUoMeLRwW5XtWb2NqmZp0dC97hSR3bbGx2xYGI39cSLga69nPg3LpplAl0w+cJxThFx6
	WI1A3VQgRrOsw5bnc/FxOyfo65mOpbXHHZ+EBs+BATV4HwfB15BkyCHrop8b9mqQbIcK/E
	BreOvq9mKhCanQS2tkm8jD/prSys/Hw=
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
Message-ID: <u3okwix7ovvzzfossbmfalwpq23qa3bmv3secg7tpjk7ghyemq@w3ngvr526rc2>
References: <20240430060612.2171650-1-shakeel.butt@linux.dev>
 <20240430060612.2171650-5-shakeel.butt@linux.dev>
 <CAJD7tkZnXY+Nbip8e6c7WC4qoYC21x=MHop_hT4NqYLKL8Fp6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZnXY+Nbip8e6c7WC4qoYC21x=MHop_hT4NqYLKL8Fp6Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 30, 2024 at 01:41:38AM -0700, Yosry Ahmed wrote:
> On Mon, Apr 29, 2024 at 11:06 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
[...]
> > +
> > +#define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> > +#define NR_MEMCG_STATS (NR_MEMCG_NODE_STAT_ITEMS + ARRAY_SIZE(memcg_stat_items))
> > +static int8_t mem_cgroup_stats_index[MEMCG_NR_STAT] __read_mostly;
> 
> NR_MEMCG_STATS and MEMCG_NR_STAT are awfully close and have different
> meanings. I think we should come up with better names (sorry nothing
> comes to mind) or add a comment to make the difference more obvious.
> 

How about the following comment?

/*
 * Please note that NR_MEMCG_STATS represents the number of memcg stats
 * we store in memory while MEMCG_NR_STAT represents the max enum value
 * of the memcg stats.
 */

> > +
> > +static void init_memcg_stats(void)
> > +{
> > +       int8_t i, j = 0;
> > +
> > +       /* Switch to short once this failure occurs. */
> > +       BUILD_BUG_ON(NR_MEMCG_STATS >= 127 /* INT8_MAX */);
> 
> Should we use S8_MAX here too?
> 

Yes. Andrew, can you please add the above comment and replacement of
127 with S8_MAX in the patch?

[...]
> >
> > -       pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> > -       x = READ_ONCE(pn->lruvec_stats->state[idx]);
> > +       i = memcg_stats_index(idx);
> > +       if (i >= 0) {
> 
> nit: we could return here if (i < 0) like you did in
> memcg_page_state() and others below, less indentation. Same for
> lruvec_page_state_local().
> 

I have fixed this in the following patch which adds warnings.


Thanks for the reviews.

