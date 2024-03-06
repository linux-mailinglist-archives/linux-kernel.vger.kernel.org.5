Return-Path: <linux-kernel+bounces-94500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFF18740B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62851F22FA6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAD7140380;
	Wed,  6 Mar 2024 19:45:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5223113F00A;
	Wed,  6 Mar 2024 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754322; cv=none; b=GJq3WUJg40WP4u1d4ctzMuOnJp5echoUzidsBu91VHyHeQuko2B2n8suXKTDv3/xrXrUOgNrAYPBEpHg8xTZwZT3voElf08wjSmdzKTZyiiyDrAvJ/CZnVmzf6G1dtT7hzsj37tSxoH2OOYkOeuxqvLofrcO63tR0N2dLkBfi4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754322; c=relaxed/simple;
	bh=GoeNgILuYzw3RIt3lassJRpXKSoD4VrJVLzn63ESTBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARprUo6dFrxlMTxAzX3+UBQLVLg82YLAaA+TE4yVOjNUabWcXonOInQjOLCZWYxSyhaU3nB8u7Nvx/WGlijnkKj6KT3EsKQ8MS4+zJWx262WSfrSfVyuZPXtECs52+vjKMX5XvCuAit/uWesIa5yLu53Xrnua2uCyr3IFuKrOdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5201BC433C7;
	Wed,  6 Mar 2024 19:45:20 +0000 (UTC)
Date: Wed, 6 Mar 2024 14:47:13 -0500
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
Message-ID: <20240306144713.2e1709ad@gandalf.local.home>
In-Reply-To: <CAHk-=whvyzsbqLkw4kwEC-KzAMKFuy5VuMtJFn-mCerSYoRnqw@mail.gmail.com>
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
	<tencent_9882B228F292088CDD68F10CF1C228742009@qq.com>
	<20240306103719.1d241b93@gandalf.local.home>
	<27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
	<20240306130103.6da71ddf@gandalf.local.home>
	<CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
	<20240306135504.2b3872ef@gandalf.local.home>
	<CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
	<CAHk-=whvyzsbqLkw4kwEC-KzAMKFuy5VuMtJFn-mCerSYoRnqw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 11:27:04 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 6 Mar 2024 at 11:01, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > In some individual tracing C file where it has a comment above it how
> > it's braindamaged and unsafe and talking about why it's ok in that
> > particular context? Go wild.  
> 
> Actually, I take that back.
> 
> Even in a random C file, the naming makes no sense. There's no "once" about it.
> 
> So if you want to do something like
> 
>    #define UNSAFE_INCREMENTISH(x) (WRITE_ONCE(a, READ_ONCE(a) + 1))
> 
> then that's fine, I guess. Because that's what the operation is.
> 
> It's not safe, and it's not an increment, but it _approximates_ an
> increment most of the time. So UNSAFE_INCREMENTISH() pretty much
> perfectly describes what it is doing.
> 
> Note that you'll also almost certainly end up with worse code
> generation, ie don't expect to see a single "inc" instruction (or "add
> $1") for the above.
> 
> Because at least for gcc, the volatiles involved with those "ONCE"
> operations end up often generating much worse code, so rather than an
> "inc" instruction, you'll almost certainly get "load+add+store" and
> the inevitable code expansion and extra register use.
> 
> I really don't know what you want to do, but it smells bad. A big
> comment about why you'd want that "incrementish" operation will be
> needed.
> 
> To me, this smells like "Steven did something fundamentally wrong
> again, some tool is now complaining about it, and Steven doesn't want
> to fix the problem but instead paper over it again".
> 
> Not a good look.
> 
> But I don't have a link to the original report, and I'm not thrilled
> enough about this to go looking for it.

Well, it's not the above, and I was afraid you would even think that.

Here's the back story. I received the following patch:

  https://lore.kernel.org/all/tencent_BA1473492BC618B473864561EA3AB1418908@qq.com/

I didn't like it. My reply was:

	> -	rbwork->wait_index++;
	> +	WRITE_ONCE(rbwork->wait_index, READ_ONCE(rbwork->wait_index) + 1);

	I mean the above is really ugly. If this is the new thing to do, we need
	better macros.

	If anything, just convert it to an atomic_t.

Then because I'm a reviewer of RCU patches, I saw the same fix for RCU
(this thread):

  https://lore.kernel.org/all/tencent_B51A9DA220288A95A435E3435A0443BEB007@qq.com/

Where it was recommended to do the same WRITE_ONCE(a, READ_ONCE(a) + 1),
and this is when I Cc'd you into the conversation to get your view of the
situation.

Sounds like my original gut feeling that this is a non-issue is proving to
be correct.

I even argued against using the _ONCE() macros. If WRITE_ONCE(a, READ_ONCE(a) + 1)
is a valid operation, I sure as hell don't want it in my code, but I would
be OK if it had a macro wrapper. Which you seem to be against, so I'm
against it too.

-- Steve

