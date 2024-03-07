Return-Path: <linux-kernel+bounces-94945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A83874703
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B5A1C21C5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEFC16426;
	Thu,  7 Mar 2024 03:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dePuzdOv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A8813FF5;
	Thu,  7 Mar 2024 03:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709783931; cv=none; b=EVUDGin7xr649hAz9zI0B1eAUmJ5Vb9hcvsosqWlokrEUlXWJRQVcNM+GhpW6u+F78hQj8qlQ0/AZNODU6LGZlMbixwPunosNUzMqwEFR0gFd9QuNKDTmj7dFEHH1laGzuWs2eqPbi+7hNPvCsZIyRvc2+6kb7F5mmNJoVzD9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709783931; c=relaxed/simple;
	bh=0TJXdgdBtAlqCZeCOaVcYTRM1lqRL/9UgdNdraEbWe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/5DCKQhl1As4xll70u8m7RKuCILjKS03C+4YbLFQEw/Uj2VYa+rfyFbJcgGX+3uCbrtSLZ9CQ+wnsbWmOog/XMHSUNx6dKAuwkhntwN1fDgESJylhw4hPlKz2PT1rfq2cUWCvFV0eXlaiErw3XvF9xDN8NtfWfFpiCel/HkomI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dePuzdOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E39AC43394;
	Thu,  7 Mar 2024 03:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709783930;
	bh=0TJXdgdBtAlqCZeCOaVcYTRM1lqRL/9UgdNdraEbWe0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dePuzdOvoOg4rColoeij5qOOc2JOQppIIL4FuaKi8qvLf3WKZVDcOI4AcVEk5XHDc
	 zZh9jcM5521nQcONIadAtSd2+kalmGdcugkhCBYQk9WISwEdfyBAgN9DoQMn56cvQ5
	 D9vtoY4bt3XjaDFWWOxjUHf5Ia9lxru92MXUo1DATJRf+m6bBElWy9TwhD4BaHw+hk
	 engbq9+8uADCL3wLSv5I1ivOqMCo3Fi3EETxG6h/3rEXrUvdbtSLyJHvrtYb8nmLSX
	 Ny26qzw+yHFxWW9oW3a28pdFivNP57gyQFLtZ95scIZNNNaYNITTY9aGcUPT2SlIKV
	 zHCYQUzQNYf6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2DC5DCE10B8; Wed,  6 Mar 2024 19:58:50 -0800 (PST)
Date: Wed, 6 Mar 2024 19:58:50 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linke li <lilinke99@qq.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcutorture: Reuse value read using READ_ONCE instead
 of re-reading it
Message-ID: <b01c476a-64ee-4030-8bc9-3807704efacc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <tencent_5D8919B7D1F21906868DE81406015360270A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5D8919B7D1F21906868DE81406015360270A@qq.com>

On Wed, Mar 06, 2024 at 10:05:20AM +0800, linke li wrote:
> rp->rtort_pipe_count is modified concurrently by rcu_torture_writer(). To
> prevent a data race, reuse i which is read using READ_ONCE before instead
> of re-reading it.
> 
> Signed-off-by: linke li <lilinke99@qq.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---

Thank you both!

This topic got quite a bit of discussion [1], with the result that I
took your patch, but edited your commit log.  Could you please take a
look below and let me know if I messed anything up?

							Thanx, Paul

[1] https://lore.kernel.org/all/20240306103719.1d241b93@gandalf.local.home/

------------------------------------------------------------------------

commit e3038bbf5d746fd4c72975b792abbb63fa3f3421
Author: linke li <lilinke99@qq.com>
Date:   Wed Mar 6 19:51:10 2024 -0800

    rcutorture: Re-use value stored to ->rtort_pipe_count instead of re-reading
    
    Currently, the rcu_torture_pipe_update_one() writes the value (i + 1)
    to rp->rtort_pipe_count, then immediately re-reads it in order to compare
    it to RCU_TORTURE_PIPE_LEN.  This re-read is pointless because no other
    update to rp->rtort_pipe_count can occur at this point.  This commit
    therefore instead re-uses the (i + 1) value stored in the comparison
    instead of re-reading rp->rtort_pipe_count.
    
    Signed-off-by: linke li <lilinke99@qq.com>
    Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0cb5452ecd945..dd7d5ba457409 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -467,7 +467,7 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
 	atomic_inc(&rcu_torture_wcount[i]);
 	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
 	ASSERT_EXCLUSIVE_WRITER(rp->rtort_pipe_count);
-	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
+	if (i + 1 >= RCU_TORTURE_PIPE_LEN) {
 		rp->rtort_mbtest = 0;
 		return true;
 	}

