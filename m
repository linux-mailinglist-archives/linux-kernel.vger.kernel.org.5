Return-Path: <linux-kernel+bounces-94478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC2387405D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503251F24BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162B413F44E;
	Wed,  6 Mar 2024 19:27:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E313E7F8;
	Wed,  6 Mar 2024 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753261; cv=none; b=AP7V9MBnqENoyLvdgoeFIi1OIsuWIrvq7TTl4EAtERGN4i5zJBk6WvZHiUCe47+FCSQQix60+VWMA8K5qrCwIYAnD1duZvXEfEPcDPQk6u8T1E4fTl4NbngCx98nwW26aHWwQhv0ymLRh5EhFGmuxLiYmvmK7ZztYmgUAiq9V3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753261; c=relaxed/simple;
	bh=HTU+jL9vOuCHuBXKseXN19zfCWcmKm8VdJ5lvTYj6QM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=it9nPQb5MyiTXwEtOoq19ld/9m2geaBiYeybUW3jvmB3OYNSUOhtz9bxlCfBCOnDAKfok7VS4BkgcuF5AxXidRnWV/k4tgv0KqfS7Su2Jx9XG2NpvBzS9AJlx57WbkSIT1TTMordPUvXPF+BRtWHfup7Yc0cKiC5LgGXo77KoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B192C433F1;
	Wed,  6 Mar 2024 19:27:39 +0000 (UTC)
Date: Wed, 6 Mar 2024 14:27:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linke li <lilinke99@qq.com>,
 joel@joelfernandes.org, boqun.feng@gmail.com, dave@stgolabs.net,
 frederic@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 qiang.zhang1211@gmail.com, quic_neeraju@quicinc.com, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and
 concurrency bug
Message-ID: <20240306142738.7b66a716@rorschach.local.home>
In-Reply-To: <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
	<tencent_9882B228F292088CDD68F10CF1C228742009@qq.com>
	<20240306103719.1d241b93@gandalf.local.home>
	<27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
	<20240306130103.6da71ddf@gandalf.local.home>
	<CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
	<20240306135504.2b3872ef@gandalf.local.home>
	<CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 11:01:55 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 6 Mar 2024 at 10:53, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Now, are you OK with an addition of ADD_ONCE() and/or INC_ONCE()? So that we
> > don't have to look at:
> >
> >         WRITE_ONCE(a, READ_ONCE(a) + 1);
> >
> > ?  
> 
> In a generic header file under include/linux/?
> 
> Absolutely not. The above is a completely broken operation. There is
> no way in hell we should expose it as a general helper.
> 
> So there is no way we'd add that kind of sh*t-for-brains operation in
> (for example) our <asm/rwonce.h> header file next to the normal
> READ/WRITE_ONCE defines.
> 
> In some individual tracing C file where it has a comment above it how
> it's braindamaged and unsafe and talking about why it's ok in that
> particular context? Go wild.

Note this has nothing to do with tracing. This thread is in RCU. I just
happen to receive the same patch "fix" for my code.

> 
> But honestly, I do not see when a ADD_ONCE() would ever be a valid
> thing to do, and *if* it's a valid thing to do, why you'd do it with
> READ_ONCE and WRITE_ONCE.
> 
> If you don't care about races, just do a simple "++" and be done with
> it. The end result is random.

That was my feeling. But when I saw this going into RCU, I was thinking
there was a more fundamental problem here.

> 
> Adding a "ADD_ONCE()" macro doesn't make it one whit less random. It
> just makes a broken concept even uglier.
> 
> So honestly, I think the ADD_ONCE macro not only needs to be in some
> tracing-specific C file, the comment needs to be pretty damn big too.
> Because as a random number generator, it's not even a very good one.
> So you need to explain *why* you want a particularly bad random number
> generator in the first place.

Again, this has nothing to do with tracing. The code here is solely in
RCU. I did receive a patch in the tracing code, but that had to deal
with wakeups of readers with respect to writers which is a common thing
across the kernel and is not anything tracing specific.

I wasn't about to take the patch to my code, but when I saw the same
changes in RCU, then I thought this might be something I need to worry
about.

-- Steve


