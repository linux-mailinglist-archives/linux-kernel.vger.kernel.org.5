Return-Path: <linux-kernel+bounces-18430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED67B825D50
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DA35B23686
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2294415BE;
	Sat,  6 Jan 2024 00:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vll94vkZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F815AC
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 00:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Jan 2024 16:05:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704499547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=srTL0MzvVyILIQT7wSMgJAQ4spYLZ+uATUXyxB8CAMI=;
	b=vll94vkZ7KCGoBy+DSm2FGUHPLe7uhWa3M5e9kWbXYOTD8wmghLtEkDJ497An8g38hEFWT
	F7BBQ117s76HZew4lbfxYsV3hDPrEv9RDt/I+rBMrjSQtudAdFO1zCvXlY15F4GcT+6nHX
	ZqR93w+S8bwZB3wIqz6zI+dGjyZy4y0=
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
Message-ID: <ZZiZVnJpOpt1DAq1@P9FQF9L96D.corp.robot.car>
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
 <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
 <20230131201001.GA8585@hu-sbhattip-lv.qualcomm.com>
 <Y9mraBHucYdnHXiS@P9FQF9L96D.corp.robot.car>
 <20230201040628.GA3767@hu-cgoldswo-sd.qualcomm.com>
 <Y9r6LtMOPHfxr7UL@google.com>
 <b9b5b669-0318-93c8-c6a0-dbbb797320f2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b5b669-0318-93c8-c6a0-dbbb797320f2@quicinc.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 05, 2024 at 03:46:55PM -0800, Sukadev Bhattiprolu wrote:
> 
> On 2/1/2023 3:47 PM, Minchan Kim wrote:
> >
> > I like this patch for different reason but for the specific problem you
> > mentioned, How about making reclaimer/compaction aware of the problem:
> >
> > IOW, when the GFP_KERNEL/DMA allocation happens but not enough memory
> > in the zones, let's migrates movable pages in those zones into CMA
> > area/movable zone if they are plenty of free memory.
> 
> Hi Minchan,
> 
> Coming back to this thread after a while.
> 
> If the CMA region is usually free, allocating pages first in the non-CMA
> region and then moving them into the CMA region would be extra work since
> it would happen most of the time. In such cases, wouldn't it be better to
> allocate from the CMA region itself?

I'm not sure there is a "one size fits all" solution here. There are two
distinctive cases:
1) A relatively small cma area used for a specific purpose. This is how cma
   was used until recently. And it was barely used by the kernel for non-cma
   allocations.
2) A relatively large cma area which is used to allocate gigantic hugepages
   and as an anti-fragmentation mechanism in general (basically as a movable
   zone). In this case it might be preferable to use cma for movable
   allocations, because the space for non-movable allocations might be limited.

I see two options here:
1) introduce per-cma area flags which will define the usage policy
2) redesign the page allocator to better take care of fragmentation at 1Gb scale

The latter is obviously not a small endeavour.
The fundamentally missing piece is a notion of an anti-fragmentation cost.
E.g. how much work does it makes sense to put into page migration
before "polluting" a new large block of memory with an unmovable folio.

Thanks!

