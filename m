Return-Path: <linux-kernel+bounces-20313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ED8827D26
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04E31F244C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DE4567E;
	Tue,  9 Jan 2024 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="asguh6I+"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11291539F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 8 Jan 2024 18:59:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704769173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=az2DbloPvptLGPocf4LwwB3VnB6zIJOBfZxKs8IGge4=;
	b=asguh6I+FXzW5501V/WBdY7tt240i1gZsdScbLKwUFArc0vqJ0JccSkhU18TwzFFsAH5FG
	eSqZA4hgx20YzUqTBRVoKWJ6ACi/LMgAy2mV5GxGIXdiNCmwe6ArM6oUIFsfLScV2gyKET
	GEya9crCs5+sOySE1K5jxrgYrp7woIg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Sukadev Bhattiprolu <quic_sukadev@quicinc.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@surriel.com>, Roman Gushchin <guro@fb.com>,
	Vlastimil Babka <vbabka@suse.cz>, Joonsoo Kim <js1304@gmail.com>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,page_alloc,cma: configurable CMA utilization
Message-ID: <ZZy2j0vxkfQfiEK-@P9FQF9L96D>
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
 <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
 <20230131201001.GA8585@hu-sbhattip-lv.qualcomm.com>
 <Y9mraBHucYdnHXiS@P9FQF9L96D.corp.robot.car>
 <20230201040628.GA3767@hu-cgoldswo-sd.qualcomm.com>
 <Y9r6LtMOPHfxr7UL@google.com>
 <b9b5b669-0318-93c8-c6a0-dbbb797320f2@quicinc.com>
 <ZZiZVnJpOpt1DAq1@P9FQF9L96D.corp.robot.car>
 <ca270573-5527-6df0-3fed-17e8c54b4f89@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca270573-5527-6df0-3fed-17e8c54b4f89@quicinc.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 08, 2024 at 12:15:05PM -0800, Sukadev Bhattiprolu wrote:
> 
> On 1/5/2024 4:05 PM, Roman Gushchin wrote:
> > I'm not sure there is a "one size fits all" solution here. 
> agree - that's why we are thinking a configurable cma utilization would be
> useful.
> > There are two distinctive cases:
> > 1) A relatively small cma area used for a specific purpose. This is how cma
> >    was used until recently. And it was barely used by the kernel for non-cma
> >    allocations.
> > 2) A relatively large cma area which is used to allocate gigantic hugepages
> >    and as an anti-fragmentation mechanism in general (basically as a movable
> >    zone). In this case it might be preferable to use cma for movable
> >    allocations, because the space for non-movable allocations might be limited.
> >
> > I see two options here:
> > 1) introduce per-cma area flags which will define the usage policy
> Could you please elaborate on this - how would we use the per-cma flags
> when allocating pages?

I mean potentially we can add some per-cma area configuration options which will
define the "priority" of using the memory from this cma area.

> > 2) redesign the page allocator to better take care of fragmentation at 1Gb scale
> >
> > The latter is obviously not a small endeavour.
> > The fundamentally missing piece is a notion of an anti-fragmentation cost.
> > E.g. how much work does it makes sense to put into page migration
> > before "polluting" a new large block of memory with an unmovable folio.
> 
> Stepping back, we are trying to solve for a situation where system:
>         - has lot of movable allocs in zone normal
>         - has lot of idle memory in CMA region
>         - but is low on memory for unmovable allocs, leading to oom-kills
> 
> On devices where cma region is mostly idle, allocating movable pages from
> the cma region would have lesser overhead?

It's not that easy: imagine booting up a small system with a cma area reserved
for some hardware-related operations. This is pretty much what cma was initially
designed. How to not fill the cma area up with the page cache?

Thanks!

