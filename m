Return-Path: <linux-kernel+bounces-94379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C6F873E25
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D8AB2106B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB5713DBB2;
	Wed,  6 Mar 2024 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hljfIf2/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE613BAD4;
	Wed,  6 Mar 2024 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748589; cv=none; b=WxpQTAlbF4ok2xbw6ozZkPDRlS6JSDmZO3KPJuqBcpJpEr5iIQY61j4zZlqqXqFQyv/TbeVxU5HAzaAMd9ReJOGwpFv/dVDFkx8tVv/gurdPHc2shtlAA/nZq0IIMzEnBvKS5sgHKf83NlGkxLyswM7Q7Hrcbp/9tyq0ZIqawZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748589; c=relaxed/simple;
	bh=8Ae4gydWwAgQ+0E0yvwrx/M9dvLJX6S+fctOFdDeRTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5frFIj2zXdJ6TrylBEZlI0MXY93tBkWkAN5vUpSLTxpsd3EykLyyLSFApDnOmhqsstX1X89t+qxDmqTZWnqtptz+Fdo8GyTj5Z3BqiszkaXenEMjUMSpoe5Jlettw+y1540wbZPCVaFxzr9g+vWhQJHH97iusKQfz4qzZ9uttI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hljfIf2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1528CC433C7;
	Wed,  6 Mar 2024 18:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709748589;
	bh=8Ae4gydWwAgQ+0E0yvwrx/M9dvLJX6S+fctOFdDeRTE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hljfIf2/cMtBNiF6xqCq8bHhoUxAQ89x2gpVAZCZjwopIm0T9WM1Up0ILPGeVXhH4
	 DUWjbE6U+Z1mvHXTUQHRdh26+1/1d34JdubaqBQUpRmi2MuYM+eeQ2OmxPnVcKq/tg
	 S9Ne1oUgK3rYX0QxJS/cOzoV9uhyX7m8kydjmFqJ4mItahLXoQuyEXHlP7URlo3Ahe
	 JoIhFeNIcKebfqeGoGF0nGjBxPqgDuSQ28TyE80Ik2fC2UqrIVV/9Js9sRNkhno45g
	 SyEItKEfHAORGSEYwsXzXmketchlOZLe4rwKDHbss9JzE+0d7XiP1Wvn8hulPTV2HP
	 lP/q38Lk+/TDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AF098CE0EDF; Wed,  6 Mar 2024 10:09:48 -0800 (PST)
Date: Wed, 6 Mar 2024 10:09:48 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linke li <lilinke99@qq.com>, joel@joelfernandes.org,
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org,
	jiangshanlai@gmail.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	qiang.zhang1211@gmail.com, quic_neeraju@quicinc.com,
	rcu@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
Message-ID: <140c2d21-1d52-4c46-bbdd-f7b4b7eabbff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com>
 <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
 <20240306130103.6da71ddf@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306130103.6da71ddf@gandalf.local.home>

On Wed, Mar 06, 2024 at 01:01:03PM -0500, Steven Rostedt wrote:
> On Wed, 6 Mar 2024 09:36:16 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > If we take the policy of handling a compiler that can tear reads and writes
> > > of any size word, then we should have proper macros to handle it.  
> > 
> > Those are in fact READ_ONCE() and WRITE_ONCE() when given machine-word
> > sized/aligned variables.
> 
> IIRC, the original purpose of READ_ONCE() and WRITE_ONCE() was to make sure
> that the compiler only reads or writes the variable "once". Hence the name.
> That way after a load, you don't need to worry that the content of the
> variable you read isn't going to be read again from the original location
> because the compiler decided to save stack space and registers.
> 
> But that macro has now been extended for other purposes.

If I remember correctly, some 32-bit system had 64-bit PTEs that it
wanted to use WRITE_ONCE() on.  Does Linux still support that system?
If not, maybe it is time to remove that extension.

> > > Perhaps READ_SHARED(), WRITE_SHARED(), ADD_SHARED(), SUB_SHARED(). The ONCE
> > > has nothing to do with the reasons for these changes. But at least "SHARED"
> > > can be considered "this variable is shared between different contexts".
> > > Note, this is different than "atomic". It's just to document that this
> > > variable must be loaded or stored in one transaction.  
> > 
> > We already have READ_ONCE() and WRITE_ONCE().  An ADD_SHARED() might
> > be useful, though compilers are starting to learn how to emit good code
> > for things like WRITE_ONCE(a, READ_ONCE(a) + 1).
> 
> Well, if we keep the _ONCE() naming, it should be ADD_ONCE(). Because
> 
>   WRITE_ONCE(a, READ_ONCE(a) + 1)
> 
> is an abomination and should only be present in obfuscation contests.

I have no problem with replacing that sort of thing with ADD_ONCE().

> > But such things should also be documented and added to LKMM.
> > 
> > > I don't know if Linus even cares about fixing "read/write tearing" which is
> > > why I Cc'd him.  
> > 
> > I am sure that whatever his views, he will not suffer in silence.  ;-)
> > 
> > > But I'm not going to take any patches that add these macros to fix
> > > compilers that tear words on load and store until we have a set policy on
> > > what to do with them.  
> > 
> > Maintainer's choice!
> > 
> > For RCU, I want the code to just work with future compiler optimizations
> > as well as with current ones.  This stuff is fun enough without giving
> > the compiler opportunities for more mischief!
> 
> I'm not against the changes. I'm against the ugliness of the changes.
> Should we just create a ADD_ONCE() macro?

Works for me!  We should also update tools/memory-model/linux-kernel.defs
to allow it to be used in litmus tests.  (I can help with that.)

Plus of course documentation.

> If the approach is now to find all places that access a variable between
> different contexts, and create READ_ONCE()/WRITE_ONCE() around them, I'm
> fine with it.

I don't know that the entire kernel is going that far, but RCU has had
that philosophy for a very long time.  Yes, KCSAN sometimes finds places
where we slipped up, but those get fixed.

> Perhaps we need a way to annotate them, like we have with __rcu. "__shared"?
> 
> Then all accesses to that variable must be wrapped with a READ_ONCE() or
> WRITE_ONCE()? I mean, if this can cause legitimate bugs, we should probably
> address it like we do with locking and RCU.

If we want that, just mark the field "volatile", as in "jiffies".

And one of the strengths of READ_ONCE() and WRITE_ONCE() is that they
allow non-volatile access where it is safe.  For example, if you hold the
lock protecting all stores to that variable, you still need WRITE_ONCE()
but not READ_ONCE().  In initialization and cleanup code, you don't
need either.

							Thanx, Paul

