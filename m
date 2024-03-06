Return-Path: <linux-kernel+bounces-94450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E722E874000
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056CA1C22FE8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692255FDCC;
	Wed,  6 Mar 2024 18:53:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B8713DBB7;
	Wed,  6 Mar 2024 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709751194; cv=none; b=WiBbbdmxY5z5Jfrk2A1Pz9jyDS3oCh37GlxJk2StQ8y1Rtvmf74dsNEWqAEX5CBI20S8wBbNIX6q1uzDysKBOw7MvlaalSw5TGDb5YGzjOldXMqsCEugvg2NNUIvpkh8VENmI6lleyMDx0WikpvApgczMxcXONL71rhStZn1OCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709751194; c=relaxed/simple;
	bh=pTxcLZycLySNRRWtPcoZMpgtrgApnpFDXfUYU2x8wHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WG0HxpT4cjIHtPtli5s2g7DoP8G5fuRToJgrlPfWASwKkyif5pFb0dVAtErZ9qN5fM3IxQxXthtK5N5ePwfxwsTC1XoqloCUd6VFUudAYU0utCdnK+kgrGFql8Bt+xjsONw9A39+mKTj+sWXS71LaFrd7qwaS/RdicByrjGQjM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD8AC433F1;
	Wed,  6 Mar 2024 18:53:11 +0000 (UTC)
Date: Wed, 6 Mar 2024 13:55:04 -0500
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
Message-ID: <20240306135504.2b3872ef@gandalf.local.home>
In-Reply-To: <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
	<tencent_9882B228F292088CDD68F10CF1C228742009@qq.com>
	<20240306103719.1d241b93@gandalf.local.home>
	<27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
	<20240306130103.6da71ddf@gandalf.local.home>
	<CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 10:43:25 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

Thanks for the history lesson ;-)

> So yes, READ_ONCE/WRITE_ONCE do control "tearing", but realistically,
> it was always only about the "complex values" kind of tearing that the
> old ACCESS_ONCE() model silently and incorrectly allowed.

Now, are you OK with an addition of ADD_ONCE() and/or INC_ONCE()? So that we
don't have to look at:

	WRITE_ONCE(a, READ_ONCE(a) + 1);

?

-- Steve

