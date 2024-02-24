Return-Path: <linux-kernel+bounces-79371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C59862149
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7211F25434
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2209D4A03;
	Sat, 24 Feb 2024 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZKecjUV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC5263D9;
	Sat, 24 Feb 2024 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708735386; cv=none; b=tsuGMjJ7fVMcvbkOOeC/oZOWjV9p1SIdOtldRyszeVgT24seCzkJVa7WVWNnmjPs0ARebkzPbuv9+f8YBLIrB38EMMq/3TxvJ4B5jTDYbH8B8DDDsUJZiwgX2yXNUca/8S9YM7VZ0ZX1uIm5gdLDukRl0/iUmFfIHxND0kiqdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708735386; c=relaxed/simple;
	bh=m73mINAcBZK7KFtefy5Xad/poSVabUB+gIm8dOx4+qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxQsWy3esTQpJg9klmxdI68uvzlH34vp72u+OeBgwlNAbytaWDRq4rqq2Qraz3pKNjMzBsNVZ9vKY2V5NcNII4gvi0/qPRzsffANuCq7q0B23NJmOiaszuz/jj0crPORPk3o3+Z2+m2rkyJ4ipmJ0k0uns4ORp6/LzYN2DPdKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZKecjUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC19C433F1;
	Sat, 24 Feb 2024 00:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708735385;
	bh=m73mINAcBZK7KFtefy5Xad/poSVabUB+gIm8dOx4+qo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rZKecjUV+6koNQRARM3ZkeptSR9GT33A4dL2+HzQZH7eTwLEudSRt+U3iVIL3bp3w
	 gLd02m/ckOh8eZecdrA5RaHmkar+gAoUF0eLM6v2dv7z+XpW7RrA34F0Z0g4hdBFg/
	 VL4YMYvzKtAT9+F5mcyH9trNoKXkmaJeiFksDZcY1G+WfAgC1AxE+9Y3fFfBVpZuH0
	 d89dcNpLWwIVk5odteqqALf3YEwdrn/dS9TcBcaN2w3oX8c+kFGUgn7Li6X1841F0s
	 THBlFs6W30YFWwfBI0IWIXA9I2wuvYSl9lAu7z9DKayUT3XM9EHzgVYgJa/bSj3Wi1
	 VkrKPbYAUZnoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EC45CCE1113; Fri, 23 Feb 2024 16:43:04 -0800 (PST)
Date: Fri, 23 Feb 2024 16:43:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v2 0/6] RCU tasks fixes for v6.9
Message-ID: <8f992601-153e-4cc1-8e7e-6684823cd590@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <Zdd7x4Rmy_-WDqfl@localhost.localdomain>
 <cf84fb44-9620-40bc-a68d-051edf6823b8@paulmck-laptop>
 <ZdiOot2RJm1VuzSJ@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdiOot2RJm1VuzSJ@lothringen>

On Fri, Feb 23, 2024 at 01:25:06PM +0100, Frederic Weisbecker wrote:
> On Thu, Feb 22, 2024 at 02:09:17PM -0800, Paul E. McKenney wrote:
> > On Thu, Feb 22, 2024 at 05:52:23PM +0100, Frederic Weisbecker wrote:
> > > Le Fri, Feb 16, 2024 at 05:27:35PM -0800, Boqun Feng a écrit :
> > > > Hi,
> > > > 
> > > > This series contains the fixes of RCU tasks for v6.9. You can also find
> > > > the series at:
> > > > 
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git rcu-tasks.2024.02.14a
> > > > 
> > > > Changes since v1:
> > > > 
> > > > *	Update with Paul's rework on "Eliminate deadlocks involving
> > > > 	do_exit() and RCU task"
> > > > 
> > > > The detailed list of changes:
> > > > 
> > > > Paul E. McKenney (6):
> > > >   rcu-tasks: Repair RCU Tasks Trace quiescence check
> > > >   rcu-tasks: Add data to eliminate RCU-tasks/do_exit() deadlocks
> > > >   rcu-tasks: Initialize data to eliminate RCU-tasks/do_exit() deadlocks
> > > >   rcu-tasks: Maintain lists to eliminate RCU-tasks/do_exit() deadlocks
> > > >   rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
> > > 
> > > Food for later thoughts and further improvements: would it make sense to
> > > call exit_rcu_tasks_start() on fork() instead and rely solely on
> > > each CPUs' rtp_exit_list instead of the tasklist?
> > 
> > It might well.
> > 
> > One big advantage of doing that is the ability to incrementally traverse
> > the tasks.  But is there some good way of doing that to the full task
> > lists?  If so, everyone could benefit.
> 
> What do you mean by incrementally? You mean being able to cond_resched()
> in the middle of the tasks iteration? Yeah not sure that's possible...

I do indeed mean doing cond_resched() mid-stream.

One way to make this happen would be to do something like this:

struct task_struct_anchor {
	struct list_head tsa_list;
	struct list_head tsa_adjust_list;
	atomic_t tsa_ref;  // Or use an appropriate API.
	bool tsa_is_anchor;
}

Each task structure would contain one of these, though there are a
number of ways to conserve space if needed.

These anchors would be placed perhaps every 1,000 tasks or so.  When a
traversal encountered one, it could atomic_inc_not_zero() the reference
count, and if that succeeded, exit the RCU read-side critical section and
do a cond_resched().  It could then enter a new RCU read-side critical
section, drop the reference, and continue.

A traveral might container_of() its way from ->tsa_list to the
task_struct_anchor structure, then if ->tsa_is_anchor is false,
container_of() its way to the enclosing task structure.

How to maintain proper spacing of the anchors?

One way is to make the traversals do the checking.  If the space between a
pair of anchors was to large or too small, it could add the first of the
pair to a list to be adjusted.  This list could periodically be processed,
perhaps with more urgency if a huge gap had opened up.

Freeing an anchor requires decrementing the reference count, waiting for
it to go to zero, removing the anchor, waiting for a grace period (perhaps
asynchronously), and only then freeing the anchor.

Anchors cannot be moved, only added or removed.

So it is possible.  But is it reasonable?  ;-)

							Thanx, Paul

> > > Thanks.
> > > 
> > > >   rcu-tasks: Maintain real-time response in rcu_tasks_postscan()
> > > > 
> > > >  include/linux/rcupdate.h |   4 +-
> > > >  include/linux/sched.h    |   2 +
> > > >  init/init_task.c         |   1 +
> > > >  kernel/fork.c            |   1 +
> > > >  kernel/rcu/tasks.h       | 110 ++++++++++++++++++++++++++++++---------
> > > >  5 files changed, 90 insertions(+), 28 deletions(-)
> > > > 
> > > > -- 
> > > > 2.43.0
> > > > 
> > > > 
> > > 

