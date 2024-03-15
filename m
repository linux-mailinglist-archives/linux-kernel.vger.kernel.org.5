Return-Path: <linux-kernel+bounces-103954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92BC87C6FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F50BB214CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CDC6FDC;
	Fri, 15 Mar 2024 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsoa1eW8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1DC6FA9;
	Fri, 15 Mar 2024 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465291; cv=none; b=VBUBYAHd3yomVudftOG4lOC5GKl56nf1XSF3Imds0HYpacS8XCAiK7B2aPNQ/2ujCU94YAbc4g0HpRjcwOBYuLjPPldSlJEbQMIg1So7TOg9+RX4ZNu/t2GbDqvNKja5PxbpnA2uCIhZDaVV9JQYbpKzh9MucRBxcFMGL/AoaE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465291; c=relaxed/simple;
	bh=wLM5tCW9/gIKwMYXR6E47mzHteIj4Ouj1NcOzc5ONHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq758Kf66Cyd8Nt4mO7tEe6qhS4n9VhAFkJIFNWMaMT1CrD8Xr6TpRqVYpU6WFg3P4T71iA0XSKlGcMGxD19bp+B30n33DqRm1iYRBMChVJpdkogjKNwyD7uOE4XBHsd4WwJ4MEutMeyfcSD4xM+OAoxrmZUoEaSQyZjpI9ZOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsoa1eW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD6EC433C7;
	Fri, 15 Mar 2024 01:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710465290;
	bh=wLM5tCW9/gIKwMYXR6E47mzHteIj4Ouj1NcOzc5ONHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tsoa1eW84HhW/qbUtDkteUWQeNfq1d5NJv481ciXQUrDAcQoxNTFntiwCi4sX+IO9
	 ZhCRk8fiZpD0no9vrO1t6DfVkxG2whz1F/OxZlhbtQdK9ZHhd8nYwfd0zVHjANFsni
	 wS2S2WR8hwyQBMjTqqzfYbcTgq04HpKeg33YeD4h4FBdzgm08bw1UGZ/CjyUggRfD2
	 E2SLkfz7iAh4dFN1HK+qH5WoSFkSt/v5RvGI5LpmYUeSd0R6+1O1fZgRUIQYIe7T7o
	 TiwiSKf5kkShcZqp4FNxDYR+fp04WuZ16H/Zf3FUFI4wU7hGOPEnfCE8E00lEdYh/a
	 kTknyyoFcufJQ==
Date: Fri, 15 Mar 2024 02:14:47 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Joel Fernandes <joel@joelfernandes.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	paulmck@kernel.org, mingo@kernel.org, rcu@vger.kernel.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, bigeasy@linutronix.de,
	chenzhongjin@huawei.com, yangjihong1@huawei.com,
	rostedt@goodmis.org, Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH] timer/migration: Remove buggy early return on deactivation
 [was Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]]
Message-ID: <ZfOhB9ZByTZcBy4u@lothringen>
References: <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfIuRMo8oKbR08Af@lothringen>
 <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfLUU+XuQC7W79tf@lothringen>
 <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>
 <ZfNHNvzpqf8DOZd8@boqun-archlinux>
 <de038bee-cecd-4e76-b0f4-5822b68e439d@gmail.com>
 <87v85olez3.ffs@tglx>
 <87sf0sldbi.ffs@tglx>
 <ZfN0wY41pU5UjP8T@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfN0wY41pU5UjP8T@boqun-archlinux>

On Thu, Mar 14, 2024 at 03:05:53PM -0700, Boqun Feng wrote:
> I notice CPU3 didn't have its own non-deferrable timer queued (local or
> global), so could the following happen?
> 
> 	timer_base_try_to_set_idle():
> 	  __get_next_timer_interrupt():
> 	    fetch_next_timer_interrupt():
> 	      // nextevt_local == nextevt_global == basej + NEXT_TIMER_MAX_DELTA
> 	      // tevt->local == tevt->gloabl = KTIME_MAX
> 	    timer_use_tmigr():
> 	      tmigr_cpu_deactivate():
> 	        __tmigr_cpu_deactivate():
> 		  // tmc->cpuevt.ignore untouched still == true
> 		  walk_groups(&tmigr_inactive_up, ...):
> 		    tmigr_inactive_up():
> 		      data->remote = true;
> 		      tmigr_update_events():
> 		        if (child) { // child is NULL
> 			  ...
> 			} else {
> 			  first_childevt = evt = data->evt;
> 
> 			  if (evt->ignore && !remote)
> 			    return true; // no remote tick is picked.
> 			  ...
> 			}

Nice catch! Florian can you try the following?

From b0e335371ed758f68bf4f501246298c98a615b04 Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <frederic@kernel.org>
Date: Fri, 15 Mar 2024 00:21:01 +0100
Subject: [PATCH] timer/migration: Remove buggy early return on deactivation

When a CPU enters into idle and deactivates itself from the timer
migration hierarchy without any global timer of its own to propagate,
the group event of that CPU is set to "ignore" and tmigr_update_events()
accordingly performs an early return without considering timers queued
by other CPUs.

If the hierarchy has a single level, and the CPU is the last one to
enter idle, it will ignore others' global timers, as in the following
layout:

           [GRP0:0]
         migrator = 0
         active   = 0
         nextevt  = T0i
          /         \
         0           1
      active (T0i)  idle (T1)

0) CPU 0 is active thus its event is ignored (the letter 'i') and so are
upper levels' events. CPU 1 is idle and has the timer T1 enqueued.

           [GRP0:0]
         migrator = NONE
         active   = NONE
         nextevt  = T0i
          /         \
         0           1
      idle (T0i)  idle (T1)

1) CPU 0 goes idle without global event queued. Therefore KTIME_MAX is
pushed as its next expiry and its own event kept as "ignore". As a result
tmigr_update_events() ignores T1 and CPU 0 goes to idle with T1
unhandled.

This isn't proper to single level hierarchy though. A similar issue,
although slightly different, may arise on multi-level:

                            [GRP1:0]
                         migrator = GRP0:0
                         active   = GRP0:0
                         nextevt  = T0:0i, T0:1
                         /              \
              [GRP0:0]                  [GRP0:1]
           migrator = 0              migrator = NONE
           active   = 0              active   = NONE
           nextevt  = T0i            nextevt  = T2
           /         \                /         \
          0 (T0i)     1 (T1)         2 (T2)      3
        idle         idle            idle         idle

0) CPU 0 is active thus its event is ignored (the letter 'i') and so are
upper levels' events. CPU 1 is idle and has the timer T1 enqueued.
CPU 2 also has a timer. The expiry order is T0 (ignored) < T1 < T2

                            [GRP1:0]
                         migrator = GRP0:0
                         active   = GRP0:0
                         nextevt  = T0:0i, T0:1
                         /              \
              [GRP0:0]                  [GRP0:1]
           migrator = NONE           migrator = NONE
           active   = NONE           active   = NONE
           nextevt  = T0i            nextevt  = T2
           /         \                /         \
          0 (T0i)     1 (T1)         2 (T2)      3
        idle         idle            idle         idle

1) CPU 0 goes idle without global event queued. Therefore KTIME_MAX is
pushed as its next expiry and its own event kept as "ignore". As a result
tmigr_update_events() ignores T1. The change only propagated up to 1st
level so far.

                            [GRP1:0]
                         migrator = NONE
                         active   = NONE
                         nextevt  = T0:1
                         /              \
              [GRP0:0]                  [GRP0:1]
           migrator = NONE           migrator = NONE
           active   = NONE           active   = NONE
           nextevt  = T0i            nextevt  = T2
           /         \                /         \
          0 (T0i)     1 (T1)         2 (T2)      3
        idle         idle            idle         idle

2) The change now propagates up to the top. tmigr_update_events() finds
that the child event is ignored and thus removes it. The top level next
event is now T2 which is returned to CPU 0 as its next effective expiry
to take account for as the global idle migrator. However T1 has been
ignored along the way, leaving it unhandled.

Fix those issues with removing the buggy related early return. Ignored
child events must not prevent from evaluating the other events within
the same group.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer_migration.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 8f49b6b96dfd..611cd904f035 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -751,26 +751,6 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 
 		first_childevt = evt = data->evt;
 
-		/*
-		 * Walking the hierarchy is required in any case when a
-		 * remote expiry was done before. This ensures to not lose
-		 * already queued events in non active groups (see section
-		 * "Required event and timerqueue update after a remote
-		 * expiry" in the documentation at the top).
-		 *
-		 * The two call sites which are executed without a remote expiry
-		 * before, are not prevented from propagating changes through
-		 * the hierarchy by the return:
-		 *  - When entering this path by tmigr_new_timer(), @evt->ignore
-		 *    is never set.
-		 *  - tmigr_inactive_up() takes care of the propagation by
-		 *    itself and ignores the return value. But an immediate
-		 *    return is required because nothing has to be done in this
-		 *    level as the event could be ignored.
-		 */
-		if (evt->ignore && !remote)
-			return true;
-
 		raw_spin_lock(&group->lock);
 
 		childstate.state = 0;
-- 
2.34.1


