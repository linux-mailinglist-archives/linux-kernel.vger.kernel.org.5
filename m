Return-Path: <linux-kernel+bounces-94337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F21873D94
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2A21F258C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCB9135418;
	Wed,  6 Mar 2024 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qruIQzZz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ACA13BADD;
	Wed,  6 Mar 2024 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709746577; cv=none; b=Rc3+MU9ZnE7wgNRTeDTDxeQyeqxpBe/EL7x3eUMYvuPrrFDYCM0mRltNj29m+UF9qg9ZBPotao7XoiLof7BVFIQ+asj26/TVmIv4HcFb+l/9M0reN3KOTENMLKqCQvL+D1h5VnGKSq0Sz5k6SBDtnHdoSiRMCbbKt2atHmjBlPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709746577; c=relaxed/simple;
	bh=SoKhrv7TCAml/sTUIT/yA1E9NjEjozs4Pb57o3IJ3k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBBdtuTZxKVl0qeG03ahe3i39KfaSjuMb7aGbrEwRIVwhG4Sy8F8dG/k+wUy70VjoeeO/kBKxSNzuSdQgNL/PbLdGM5tzuhMA44Jn9RL4eySuyLa248dmsmjl0Krh1e1SQQKKQPvNw501Cw7OpbyKxU3oBw+vfK4xdAfB7hVWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qruIQzZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CB8C433C7;
	Wed,  6 Mar 2024 17:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709746577;
	bh=SoKhrv7TCAml/sTUIT/yA1E9NjEjozs4Pb57o3IJ3k8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qruIQzZzhcPk7gPzR+ECnFFxc3qJIxBr0ze/ST1d7ZL+ogYlnptpzG1R8HCZN+cL2
	 OpSZXORD3h+arp8/7eD59sYLfJ4CyMjzWTnjgZY3dhIjVeLeozoYO4ht1Cqiv2ZbrD
	 SzXjLzjs4CvtsIBpMOV8zWe4tbsxH+9XKPO1ASdx1N0KGqtIc38Od+b8w7r51Ray+H
	 U2SR4pceNlsoL5bj9CIgHoVW7/0mm9QOLldIQMJTZ1kMMF7iPUENy2fxXtW6QX+a5O
	 KVLRaFpJvgXDPxsBENV8chIJzgzOu/n9pu7J7QkPzqqd/V5tkCEIFs3dxhRIdasnPJ
	 xrTkSAw9RZ7fA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8BD1BCE12BB; Wed,  6 Mar 2024 09:36:16 -0800 (PST)
Date: Wed, 6 Mar 2024 09:36:16 -0800
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
Message-ID: <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com>
 <20240306103719.1d241b93@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306103719.1d241b93@gandalf.local.home>

On Wed, Mar 06, 2024 at 10:37:19AM -0500, Steven Rostedt wrote:
> On Tue,  5 Mar 2024 14:24:20 +0800
> linke li <lilinke99@qq.com> wrote:
> 
> > > Anyway, a slightly related/different question:
> > > 
> > > Should that:
> > > WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
> > > 
> > > Be:
> > > WRITE_ONCE(rp->rtort_pipe_count, READ_ONCE(rp->rtort_pipe_count) + 1);
> > > 
> > > ?  
> > 
> > Hi, Joel. Sorry, I am not very sure about this. I do a little research on
> > it.
> > 
> > I looked through all code in kernel that looks like this, both kinds are
> > used. I also try to compile this file with and without the READ_ONCE in
> > WRITE_ONCE using gcc-9. Their binary is just the same. 
> > 
> > Thus I think in the current compiler version, they do not have a big
> > difference, but if the compiler wants to optimize more, maybe the latter
> > one is better.
> 
> I'm sorry but all these READ_ONCE/WRITE_ONCE() additions that are being
> added because there's a fear of the compiler tearing long words, is going to
> make the code really ugly and hard to read.

There are quite a few other things to fear besides tearing.  The compiler
can and does invent and fuse normal loads, and it can and does fuse
normal stores.  And there really are compilers that tear stores of
certain constants on systems with short immediate fields.

I would argue that use of normal C-language loads and stores should be
accompanied by comments saying why the compiler cannot mess things up.
But maintainer's choice.  Those maintainers who keep a close personal
relationship with the ever-growing list of optimizations should have
no problem working out which use cases are safe for normal C-language
loads and stores.  Me, I would really rather play it safe, especially
in the innards of something like RCU.  ;-)

> If we take the policy of handling a compiler that can tear reads and writes
> of any size word, then we should have proper macros to handle it.

Those are in fact READ_ONCE() and WRITE_ONCE() when given machine-word
sized/aligned variables.

> Perhaps READ_SHARED(), WRITE_SHARED(), ADD_SHARED(), SUB_SHARED(). The ONCE
> has nothing to do with the reasons for these changes. But at least "SHARED"
> can be considered "this variable is shared between different contexts".
> Note, this is different than "atomic". It's just to document that this
> variable must be loaded or stored in one transaction.

We already have READ_ONCE() and WRITE_ONCE().  An ADD_SHARED() might
be useful, though compilers are starting to learn how to emit good code
for things like WRITE_ONCE(a, READ_ONCE(a) + 1).

But such things should also be documented and added to LKMM.

> I don't know if Linus even cares about fixing "read/write tearing" which is
> why I Cc'd him.

I am sure that whatever his views, he will not suffer in silence.  ;-)

> But I'm not going to take any patches that add these macros to fix
> compilers that tear words on load and store until we have a set policy on
> what to do with them.

Maintainer's choice!

For RCU, I want the code to just work with future compiler optimizations
as well as with current ones.  This stuff is fun enough without giving
the compiler opportunities for more mischief!

							Thanx, Paul

