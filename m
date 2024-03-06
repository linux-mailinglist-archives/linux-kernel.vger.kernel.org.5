Return-Path: <linux-kernel+bounces-94163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D457873AC8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B406B22985
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69209137C3D;
	Wed,  6 Mar 2024 15:35:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8DE13792E;
	Wed,  6 Mar 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739329; cv=none; b=FbzCANx5bZNeKxO6BZUeJq1vSWB3zUF3siTjfcWnhMlR9iFVf3xDds3gfo1hrobfZ1rIvwSjJ2jChYwdQVD+Y4LrZ65NQpYPc7fBIL2RMGwp37TLd7xxdKV9H2L2ELwefrdfItUIrcMxNff9k2Z+LYZDvRFf/lmPhZ2EugPr68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739329; c=relaxed/simple;
	bh=XzHQ63q+wO8yRhMAcPLJwguwCBW5R4lx0MMXE87Ck+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7mDYKm+4cQlQoPqJ1Wehwm3MjOsrq6FYkY32Nar7PT2v7y5rRP6Q2SHf21hICiKKiShdcuYMk59q7TOCZItjRz+AtOGY+TqXRwkiquBViM9DkrRFv/NS8lRihjycCBya1fs0GhOruU6JUwHhkFDiq+zp+QU/TirjPLCqmLpJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E408BC43390;
	Wed,  6 Mar 2024 15:35:26 +0000 (UTC)
Date: Wed, 6 Mar 2024 10:37:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linke li <lilinke99@qq.com>
Cc: joel@joelfernandes.org, boqun.feng@gmail.com, dave@stgolabs.net,
 frederic@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 paulmck@kernel.org, qiang.zhang1211@gmail.com, quic_neeraju@quicinc.com,
 rcu@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and
 concurrency bug
Message-ID: <20240306103719.1d241b93@gandalf.local.home>
In-Reply-To: <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com>
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
	<tencent_9882B228F292088CDD68F10CF1C228742009@qq.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Mar 2024 14:24:20 +0800
linke li <lilinke99@qq.com> wrote:

> > Anyway, a slightly related/different question:
> > 
> > Should that:
> > WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
> > 
> > Be:
> > WRITE_ONCE(rp->rtort_pipe_count, READ_ONCE(rp->rtort_pipe_count) + 1);
> > 
> > ?  
> 
> Hi, Joel. Sorry, I am not very sure about this. I do a little research on
> it.
> 
> I looked through all code in kernel that looks like this, both kinds are
> used. I also try to compile this file with and without the READ_ONCE in
> WRITE_ONCE using gcc-9. Their binary is just the same. 
> 
> Thus I think in the current compiler version, they do not have a big
> difference, but if the compiler wants to optimize more, maybe the latter
> one is better.

I'm sorry but all these READ_ONCE/WRITE_ONCE() additions that are being
added because there's a fear of the compiler tearing long words, is going to
make the code really ugly and hard to read.

If we take the policy of handling a compiler that can tear reads and writes
of any size word, then we should have proper macros to handle it.

Perhaps READ_SHARED(), WRITE_SHARED(), ADD_SHARED(), SUB_SHARED(). The ONCE
has nothing to do with the reasons for these changes. But at least "SHARED"
can be considered "this variable is shared between different contexts".
Note, this is different than "atomic". It's just to document that this
variable must be loaded or stored in one transaction.

I don't know if Linus even cares about fixing "read/write tearing" which is
why I Cc'd him.

But I'm not going to take any patches that add these macros to fix
compilers that tear words on load and store until we have a set policy on
what to do with them.

-- Steve

