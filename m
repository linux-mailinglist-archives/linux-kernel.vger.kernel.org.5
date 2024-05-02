Return-Path: <linux-kernel+bounces-166137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B211D8B96B1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDB41F214C5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE2046B9F;
	Thu,  2 May 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gdbcl+B9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46F59147
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639514; cv=none; b=ufM9FdB2o/he0IF7U0xfbUgDIrdhT4n6v5+FbAlOmzKimeuwNUCrjx0/C2+ZDEoG6nn7fxADDo3sWSbHzBGhYPZnIO4TWgaNXIDyK/M2nrbcBsowNHHNHf62cv0JY9NUSmX0O6bRzckVwoiYc/bjOUA5X81lwAwt4XjMOY5UGVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639514; c=relaxed/simple;
	bh=4E8utQNKBoQ5tzMCgjoTU2IXv0ph4OwfGKexiKxaTB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlUgYHj9MVT/wPMHIVoEDHZ8YE+BMvBiouXOq5KskH5CzL2lvSrQ+ANMflhb6WsfF5NIhshY+KLDAlx9tpdw8dHPR84LRikao/Z1uF2zmgDur9N/MSCRITypdHCAoV4d1b3Yzn4fyg9ESzwkXDwbvXTwV6iss/xIbCOuLE0Go5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gdbcl+B9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TMs6qFbAXOgZbfTIfvzW4Fje5xMDforyGhdiIfliBIE=; b=gdbcl+B967rG+mexLhZjkUct+0
	qokcmFEoZNRMFGIxrZghtvyKN7tTr8it6YnJARHbLM00GAOB9RxLh+FjgXhy+zAgDC0TCY10mE8+d
	qyn/+MZ4HX6+hE/2zd1fX1zW+FyaaKOkkCJUw/RXp0NhuOs75WSbVv4PMwhZWg28xzkqcGrt5M6RW
	i/Y59qzNh6K6fR+xXx9/Clk5AUsfxFD6Pl4rEWv82Ufkj7Xyg/qBXYGvG7f4Wy49KztIYo0SgT9ic
	h4X+KgaJjgoHUYZBM1IxPRxAAnipTLxY7v7G2KZndGD7xqyANp5iPBDg9Uzf6q8xPpja0EvO07Hxf
	IBbGYtGA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2S3s-00000001HWh-3ZEV;
	Thu, 02 May 2024 08:45:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7A87230057A; Thu,  2 May 2024 10:45:04 +0200 (CEST)
Date: Thu, 2 May 2024 10:45:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [PATCH V6 2/6] sched/deadline: Deferrable dl server
Message-ID: <20240502084504.GX30852@noisy.programming.kicks-ass.net>
References: <cover.1712337227.git.bristot@kernel.org>
 <7b9c206e914ef257a2534199f25938ffafa3e59e.1712337227.git.bristot@kernel.org>
 <20240410174749.GC30852@noisy.programming.kicks-ass.net>
 <c4c6575d-5ea0-44ba-bbdc-eadad77dea81@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4c6575d-5ea0-44ba-bbdc-eadad77dea81@redhat.com>

On Thu, May 02, 2024 at 10:35:02AM +0200, Daniel Bristot de Oliveira wrote:
> On 4/10/24 19:47, Peter Zijlstra wrote:
> >> +static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
> >> +{
> >> +	struct rq *rq = rq_of_dl_se(dl_se);
> >> +	enum hrtimer_restart restart = 0;
> >> +	struct rq_flags rf;
> >> +	u64 fw;
> >> +
> >> +	rq_lock(rq, &rf);
> > 	guard(rq_lock)(rq, &rf);
> 
> this is the way I found to get the &rf... inspired on sched_rr_get_interval():
> 
>         scoped_guard (rq_lock, rq) {
>                 struct rq_flags *rf = &scope.rf;
> 
> is that right?
> 
Yeah, it's a bit ugly, but yes.

