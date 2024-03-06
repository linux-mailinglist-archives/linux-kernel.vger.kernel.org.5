Return-Path: <linux-kernel+bounces-94384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FCD873E5C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDC61F21440
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B3713DB99;
	Wed,  6 Mar 2024 18:18:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4265D48F;
	Wed,  6 Mar 2024 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749102; cv=none; b=bkI9Nm9uIy5aoi+a5uRw2r0J5x2XTzZNkgQzisatZ3tpYJP67Apz87cBFSiVtcVDvt0zV84SI7fdgtGU4HzWDFTECUbvSBnIYz4dviFQqlsEaiaSMziG2D3KnjJjozeHq7Pas+gq1+csGtl5RhAjw5dker6DgPepNhSSKN0aESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749102; c=relaxed/simple;
	bh=mauWxPEgozeSMabTexkNXZEChb8JRyo2zdyWL8MlYAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvrTqEjBdcFSSarBSDS0h6tf8CDKRYXJOrF8I8Prnps0yzPLXhjANAQh/oWSl08j8FpBbSiaG+SiuMsywZeSgErFthcSDLj+HQJtW5Sep10IoEQ3Xf+eks1F7uB5zqWP37vN2JXvKQT2B0He+hHwhp/nvTF0ylYzxNxpib79LFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526CFC433C7;
	Wed,  6 Mar 2024 18:18:20 +0000 (UTC)
Date: Wed, 6 Mar 2024 13:20:12 -0500
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
Message-ID: <20240306132012.54a9ec01@gandalf.local.home>
In-Reply-To: <140c2d21-1d52-4c46-bbdd-f7b4b7eabbff@paulmck-laptop>
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
	<tencent_9882B228F292088CDD68F10CF1C228742009@qq.com>
	<20240306103719.1d241b93@gandalf.local.home>
	<27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
	<20240306130103.6da71ddf@gandalf.local.home>
	<140c2d21-1d52-4c46-bbdd-f7b4b7eabbff@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 10:09:48 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > Perhaps we need a way to annotate them, like we have with __rcu. "__shared"?
> > 
> > Then all accesses to that variable must be wrapped with a READ_ONCE() or
> > WRITE_ONCE()? I mean, if this can cause legitimate bugs, we should probably
> > address it like we do with locking and RCU.  
> 
> If we want that, just mark the field "volatile", as in "jiffies".

I already know Linus's view on "volatile" variables ;-)

> 
> And one of the strengths of READ_ONCE() and WRITE_ONCE() is that they
> allow non-volatile access where it is safe.  For example, if you hold the
> lock protecting all stores to that variable, you still need WRITE_ONCE()
> but not READ_ONCE().  In initialization and cleanup code, you don't
> need either.

I guess the current static analyzers just look to see where READ_ONCE() or
WRITE_ONCE() is used and checks to see if other places have them properly
used. I'm guessing that's where the OP patch came from.

Sounds like we just need a ADD_ONCE() or INC_ONCE() then. Because I am not
taking a

	WRITE_ONCE(a, READ_ONCE(a) + 1);

patch that replaces a simple "a++".

-- Steve


