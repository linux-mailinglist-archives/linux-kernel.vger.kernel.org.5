Return-Path: <linux-kernel+bounces-94357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1324A873DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FB11C22C20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B39913C9C9;
	Wed,  6 Mar 2024 17:59:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36013BAE8;
	Wed,  6 Mar 2024 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747953; cv=none; b=cSxOgyjkcIMAgJ1WXMudwcYOWp/ulDSK+FiJwXByuD2e/uJxyBXHM6DNaDfYln9km7S7q9D4bLTMdCLS3RdCQnTglPmugzabZbGt/FZjayaZiGfmLVGuen9yra4AE0xAyWM3bQFgXcfpAmgt8YmaX4fWVR3AMavwtA7kN73bfOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747953; c=relaxed/simple;
	bh=HDO+XgS2uhz8t0fGGsGDxAX/o5QGbVirBj1RmpOGOKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoZ9BaEGAb51wyuHZHMubB5f+scq0VGGV3eAlD5LWNuAyDw36sm8wZZQp21asXbSveIk3pSGcoohlwhzqXljJfLrZ4s5VDM8IyDADlHRz7R7DHEYJEq8Wh+Vt9SVLnmj+6gjsJfsMjbLWD7Ha/5bTlXmh9QnK77Cht9ESULnX/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE63EC433F1;
	Wed,  6 Mar 2024 17:59:11 +0000 (UTC)
Date: Wed, 6 Mar 2024 13:01:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linke li <lilinke99@qq.com>, joel@joelfernandes.org,
 boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org,
 jiangshanlai@gmail.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 qiang.zhang1211@gmail.com, quic_neeraju@quicinc.com, rcu@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and
 concurrency bug
Message-ID: <20240306130103.6da71ddf@gandalf.local.home>
In-Reply-To: <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
	<tencent_9882B228F292088CDD68F10CF1C228742009@qq.com>
	<20240306103719.1d241b93@gandalf.local.home>
	<27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 09:36:16 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > If we take the policy of handling a compiler that can tear reads and writes
> > of any size word, then we should have proper macros to handle it.  
> 
> Those are in fact READ_ONCE() and WRITE_ONCE() when given machine-word
> sized/aligned variables.

IIRC, the original purpose of READ_ONCE() and WRITE_ONCE() was to make sure
that the compiler only reads or writes the variable "once". Hence the name.
That way after a load, you don't need to worry that the content of the
variable you read isn't going to be read again from the original location
because the compiler decided to save stack space and registers.

But that macro has now been extended for other purposes.

> 
> > Perhaps READ_SHARED(), WRITE_SHARED(), ADD_SHARED(), SUB_SHARED(). The ONCE
> > has nothing to do with the reasons for these changes. But at least "SHARED"
> > can be considered "this variable is shared between different contexts".
> > Note, this is different than "atomic". It's just to document that this
> > variable must be loaded or stored in one transaction.  
> 
> We already have READ_ONCE() and WRITE_ONCE().  An ADD_SHARED() might
> be useful, though compilers are starting to learn how to emit good code
> for things like WRITE_ONCE(a, READ_ONCE(a) + 1).

Well, if we keep the _ONCE() naming, it should be ADD_ONCE(). Because

  WRITE_ONCE(a, READ_ONCE(a) + 1)

is an abomination and should only be present in obfuscation contests.

> 
> But such things should also be documented and added to LKMM.
> 
> > I don't know if Linus even cares about fixing "read/write tearing" which is
> > why I Cc'd him.  
> 
> I am sure that whatever his views, he will not suffer in silence.  ;-)
> 
> > But I'm not going to take any patches that add these macros to fix
> > compilers that tear words on load and store until we have a set policy on
> > what to do with them.  
> 
> Maintainer's choice!
> 
> For RCU, I want the code to just work with future compiler optimizations
> as well as with current ones.  This stuff is fun enough without giving
> the compiler opportunities for more mischief!

I'm not against the changes. I'm against the ugliness of the changes.
Should we just create a ADD_ONCE() macro?

If the approach is now to find all places that access a variable between
different contexts, and create READ_ONCE()/WRITE_ONCE() around them, I'm
fine with it.

Perhaps we need a way to annotate them, like we have with __rcu. "__shared"?

Then all accesses to that variable must be wrapped with a READ_ONCE() or
WRITE_ONCE()? I mean, if this can cause legitimate bugs, we should probably
address it like we do with locking and RCU.

-- Steve



