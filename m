Return-Path: <linux-kernel+bounces-77449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA12860570
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0653E287662
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1872F12D218;
	Thu, 22 Feb 2024 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqTBSYdN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FF073F13;
	Thu, 22 Feb 2024 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639758; cv=none; b=seOMFzM/zS2i9hpY9wkfcR5fbZ+DfvHWUnUN189jd5tT8O5Zn69jLHBHJjPcgjgexTxdGHxHnnDOh0CDKTr0CjGa97xNx8Sswefn4BG4mERiDi4eNxixCVqgdHLso+u3qL/m0Wx3K/+0KtIx0I/3LygsFNpLGgMSH3o0kk7lJUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639758; c=relaxed/simple;
	bh=l1/ezjl9EYeaWVpvN0u8fT88/5VTm9AGnH7HjTwqtiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW6968JHGNxijWuiskLJRTvu6YW9vs8zhQbHmr6/bdA7wyKlalaPKsiG96m4Z0UzKpMiCtiYx38gxzifCB1UxuX+vR2NzIjsEmkheqSYcoKpbEmM2h/ngUbL2Nd3iMajroA7rpSEbL5JMLCGVVdp/8cophHUf8DOpmN7k+TU534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqTBSYdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA03CC433C7;
	Thu, 22 Feb 2024 22:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708639757;
	bh=l1/ezjl9EYeaWVpvN0u8fT88/5VTm9AGnH7HjTwqtiA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FqTBSYdNMC4OQYqaJNjwK3wxZ25TIuDMcorlmS0nUEcfuuGpReshtX7RZ1r4iRuBM
	 n2RpmlN0ygdXZrJ0AA6MmmHlz69lUbAtFIp7ro+Q4vB+Zh9sz7FZeNt5tBZ1ilUa9h
	 zGgImhskFv1Xle+tJM5LYJvJL6RaThfi+fTkMdZ+TXo1pDCD2CES1hFfS5NlxtDvkU
	 Aq3RrfI/hpRzt9fSfSzn/owXvjSZ2SnW9M9inNyFh3QFEroqPXWQQpw5yxjmg3EgJP
	 fTHSyLUWWlB8hBuQBVe6Qz8GXTsDNJfq36eSel7hFteSHKh4sMPPV7uoZY31xEkbNE
	 D+gBTCVY/0kfA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 87292CE0738; Thu, 22 Feb 2024 14:09:17 -0800 (PST)
Date: Thu, 22 Feb 2024 14:09:17 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v2 0/6] RCU tasks fixes for v6.9
Message-ID: <cf84fb44-9620-40bc-a68d-051edf6823b8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <Zdd7x4Rmy_-WDqfl@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zdd7x4Rmy_-WDqfl@localhost.localdomain>

On Thu, Feb 22, 2024 at 05:52:23PM +0100, Frederic Weisbecker wrote:
> Le Fri, Feb 16, 2024 at 05:27:35PM -0800, Boqun Feng a écrit :
> > Hi,
> > 
> > This series contains the fixes of RCU tasks for v6.9. You can also find
> > the series at:
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git rcu-tasks.2024.02.14a
> > 
> > Changes since v1:
> > 
> > *	Update with Paul's rework on "Eliminate deadlocks involving
> > 	do_exit() and RCU task"
> > 
> > The detailed list of changes:
> > 
> > Paul E. McKenney (6):
> >   rcu-tasks: Repair RCU Tasks Trace quiescence check
> >   rcu-tasks: Add data to eliminate RCU-tasks/do_exit() deadlocks
> >   rcu-tasks: Initialize data to eliminate RCU-tasks/do_exit() deadlocks
> >   rcu-tasks: Maintain lists to eliminate RCU-tasks/do_exit() deadlocks
> >   rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
> 
> Food for later thoughts and further improvements: would it make sense to
> call exit_rcu_tasks_start() on fork() instead and rely solely on
> each CPUs' rtp_exit_list instead of the tasklist?

It might well.

One big advantage of doing that is the ability to incrementally traverse
the tasks.  But is there some good way of doing that to the full task
lists?  If so, everyone could benefit.

							Thanx, Paul

> Thanks.
> 
> >   rcu-tasks: Maintain real-time response in rcu_tasks_postscan()
> > 
> >  include/linux/rcupdate.h |   4 +-
> >  include/linux/sched.h    |   2 +
> >  init/init_task.c         |   1 +
> >  kernel/fork.c            |   1 +
> >  kernel/rcu/tasks.h       | 110 ++++++++++++++++++++++++++++++---------
> >  5 files changed, 90 insertions(+), 28 deletions(-)
> > 
> > -- 
> > 2.43.0
> > 
> > 
> 

