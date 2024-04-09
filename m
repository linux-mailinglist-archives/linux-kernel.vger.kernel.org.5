Return-Path: <linux-kernel+bounces-136544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4679E89D569
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C68B2249B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43FC7E774;
	Tue,  9 Apr 2024 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S0Vw1Qcy"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301368529E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654488; cv=none; b=MoBL09LRqD/ovYsVKQ0MI+MJpTbSRmDkxq1pEx1qdDyziUbadSeqrMmHsBKRRk4ai8qQr6RUvoJ8GebLGv7LvwOfS9nhKbqRiwApVnIbHk/+hwU3H7y23HeUje62WpcE34XG3csiWWEpfk/WUjtqn2EplvTIkVFUd0M7sZAQ0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654488; c=relaxed/simple;
	bh=kpgut7r9SoPwQ6L0e+kvqRpyFcrLlcU6aHU3tKj4qGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbOZo6OrpMwBT4YYeGer1zhuDrqRl56XKt/NGPvTrW9q3CPeTU4M+GAsNbaKzbXlJXcX5qMr4ZYHhicjgzZq2WDe7ben9b3TSEVwd4rmGDeLhBybMd8P0U/mHngKm7YR/8dCXOsrEEqpGc0/hJUQk4duD4rZzbMrr5ujzJwaafs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S0Vw1Qcy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YeC5R0Uay0C5dvbf+qarJuNA6Yc3zpuLXDofRbawIic=; b=S0Vw1Qcy2xbOmQLr3rSK5ilD4q
	HNqv5Mbrk9qTSeb2fxO+ZEO9HdHeckXYZq2yk1LmmSDmr5PMuQVl9WJ4CAHJ/mZvPsT4VPF8daYE7
	yRavlZarzT063qFyiI0kzrXdpaWsojrTot8ukdvVz2dUdNXSuW7YmUfvGX2L5RR9Bj1t//p9MUJkr
	MwV7UZ6GPHjAeIZ37A/M5NTLto6pihqEhSIS5hlxiyGoE56UywfDdEvVruBA0yEK8zQoZHC4K4Hqo
	1rrpNmj150gpscZJoxTJQW8NoWfxLU/n/Ox5KoN7C43AiVCnyQfQ2MIAvmdK25DawFfka9UUxC2XL
	t8kCKdrQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru7f6-00000007WWC-20I6;
	Tue, 09 Apr 2024 09:21:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 28434300600; Tue,  9 Apr 2024 11:21:04 +0200 (CEST)
Date: Tue, 9 Apr 2024 11:21:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Honglei Wang <wanghonglei@didichuxing.com>,
	Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <20240409092104.GA2665@noisy.programming.kicks-ass.net>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <20240408115833.GF21904@noisy.programming.kicks-ass.net>
 <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>

On Mon, Apr 08, 2024 at 09:11:39PM +0800, Chen Yu wrote:
> On 2024-04-08 at 13:58:33 +0200, Peter Zijlstra wrote:
> > On Thu, Feb 29, 2024 at 05:00:18PM +0800, Abel Wu wrote:
> > 
> > > > According to the log, vruntime is 18435852013561943404, the
> > > > cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 = 2677,
> > > > thus:
> > > > s64 delta = (s64)(18435852013561943404 - 763383370431) = -10892823530978643
> > > >      delta * 2677 = 7733399554989275921
> > > > that is to say, the multiply result overflow the s64, which turns the
> > > > negative value into a positive value, thus eligible check fails.
> > > 
> > > Indeed.
> > 
> > From the data presented it looks like min_vruntime is wrong and needs
> > update. If you can readily reproduce this, dump the vruntime of all
> > tasks on the runqueue and see if min_vruntime is indeed correct.
> >
> 
> This was the dump of all the entities on the tree, from left to right,

Oh, my bad, I thought it was the pick path.

> and also from top down in middle order traverse, when this issue happens:
> 
> [  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:2048 cfs_rq->min_vruntime:763383370431
> [  514.535935][ T8390] current on_rq se 0xc5851400, deadline:18435852013562231446
> 			min_vruntime:18437121115753667698 vruntime:18435852013561943404, load:629
> 
> 
> [  514.536772][ T8390] Traverse rb-tree from left to right
> [  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible  <-- leftmost se
> [  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> 
> [  514.538539][ T8390] Traverse rb-tree from topdown
> [  514.538877][ T8390]  middle se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible   <-- root se
> [  514.539605][ T8390]  middle se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> 
> The tree looks like:
> 
>           se (0xec1234e0)
>                   |
>                   |
>                   ----> se (0xec4fcf20)
> 
> 
> The root se 0xec1234e0 is also the leftmost se, its min_vruntime and
> vruntime are both 763383370431, which is aligned with
> cfs_rq->min_vruntime. It seems that the cfs_rq's min_vruntime gets
> updated correctly, because it is monotonic increasing.

Right.

> My guess is that, for some reason, one newly forked se in a newly
> created task group, in the rb-tree has not been picked for a long
> time(maybe not eligible). Its vruntime stopped at the negative
> value(near (unsigned long)(-(1LL << 20)) for a long time, its vruntime
> is long behind the cfs_rq->vruntime, thus the overflow happens.

I'll have to do the math again, but that's something in the order of not
picking a task in about a day, that would be 'bad' :-)

Is there any sane way to reproduce this, and how often does it happen?

