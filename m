Return-Path: <linux-kernel+bounces-151142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C72C8AA9B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324BC1F22C37
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C8F54907;
	Fri, 19 Apr 2024 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YPiRhQd7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7947F5F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513779; cv=none; b=ILEca+UAi0+mxdCrtFE2h4woHIr2bU41zijQUTvYT8HW8IPceLZ+bIOdwPtuRYkzrXw+pSP1PgnhRF0CsCNGySTrtn3ZInHyne53TK1JBAfVSmGqeez3PyVWLOs/Ip0KYMMvQ3eN+BTPOhd531xzpc5HBWVj7k5+YlaqoEvZ3CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513779; c=relaxed/simple;
	bh=e9Z9fHaDuuyDcM8MJB7nt0Ow36cEbjSGpuLTk/QCexI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWuaANPYbvZW+PUqOWmKgYdcIutggM5icy7vCV+S466u78p5DTuTP0tXPKww8o4DKUGvA97uV9q4CkxhCHvS3rrBEgT/bFcdF3KgO1T14sX4wIQ4V6rKYqW9POeUe9NFSNvOmvSCOAi7gBgv7YAGP6djx1SJb0FjqPXA013Se8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YPiRhQd7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FMuI+dT3XqFEPP+Emi47R09drJIeCsXDMdFMNlbhnZw=; b=YPiRhQd7N8Gq/P8bfVKWLvNM11
	UPnSghquqOBp5VRkeI1EwLB6aoeBeby+3a3C4jUC5K8h/FfAYIxa5LyhCqsVJeCEAEOp/BnHiykAa
	svEuQqF8R/g77xlnw2kgVzWbwQcIRFOF7uXNF4jQX9g6iv6fRBEQTheA2yKmc+TTPpMRfdJCDK29b
	onB7sDTmWAdZ0PUUS/vKqULejrBSfVwqKNfgEHPihpFjQNgqwpGx2cXYMUtjtDXHP09smFPtoRpk+
	Trx6j1rdMqGJI+0STjDj+Hiq8nQKmq7IuJWofepz4LJHzoNSWaMbEpB9sDSDCHXAhr4iajY8mcNWn
	8v9qm4IA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxjCT-00000007E1p-2QTI;
	Fri, 19 Apr 2024 08:02:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3F0723002E1; Fri, 19 Apr 2024 10:02:25 +0200 (CEST)
Date: Fri, 19 Apr 2024 10:02:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Tianchen Ding <dtcccc@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Abel Wu <wuyun.abel@bytedance.com>
Subject: Re: [PATCH v2 0/2] sched/eevdf: Minor fixes for reweight_entity()
Message-ID: <20240419080225.GA6345@noisy.programming.kicks-ass.net>
References: <20240306022133.81008-1-dtcccc@linux.alibaba.com>
 <ZiIc4mU/RcSPI+WV@chenyu5-mobl2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiIc4mU/RcSPI+WV@chenyu5-mobl2>

On Fri, Apr 19, 2024 at 03:27:30PM +0800, Chen Yu wrote:
> On 2024-03-06 at 10:21:31 +0800, Tianchen Ding wrote:
> > According to the discussion in [1], fix a calculation bug in
> > reweight_entity().
> > 
> > [1] https://lore.kernel.org/all/59585184-d13d-46e0-8d68-42838e97a702@bytedance.com/
> > 
> > v2:
> > Add fixes tag to the 1st patch.
> > 
> > v1: https://lore.kernel.org/all/20240304030042.2690-1-dtcccc@linux.alibaba.com/
> > 
> > Tianchen Ding (2):
> >   sched/eevdf: Always update V if se->on_rq when reweighting
> >   sched/eevdf: Fix miscalculation in reweight_entity() when se is not
> >     curr
> > 
> >  kernel/sched/fair.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.39.3
> >
> 
> Applied this patch set on top of the reweight_entity fix at
> https://lore.kernel.org/lkml/ZiEaKOQwiNEglYtS@chenyu5-mobl2/
> it has passed 100 cycles of trinity test without any issue.
> 
> For the whole serie,
> 
> Tested-by: Chen Yu <yu.c.chen@intel.com>

OK, grabbed these patches (and made some minor edits), now let me go
stare at that other thread again.

