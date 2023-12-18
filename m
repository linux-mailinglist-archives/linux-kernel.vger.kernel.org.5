Return-Path: <linux-kernel+bounces-3785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B02817194
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE86A1C24395
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6B51D142;
	Mon, 18 Dec 2023 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Iahy7gFh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D71D14D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uFJ2605CdR44/XATM5rlpd2IZaTWAyrutYxnwM/vGXM=;
  b=Iahy7gFhzIhfgRv+zKq1ojbyVLXoC8qQCVkOGMpevAY3fwu2bagkKoxJ
   X4jxH0jFHMy5f2T2jnLrFBkCy7FHMTvGndSjlBDfT7PCSIJ0nxXHrxcKr
   K9I/8uUJwQQGwDBVu7Zd4R/9cvU7Ouk4VxinFrHe7eTjlUddLOWOBgUf5
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,285,1695679200"; 
   d="scan'208";a="142912801"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 14:58:47 +0100
Date: Mon, 18 Dec 2023 14:58:47 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Peter Zijlstra <peterz@infradead.org>
cc: Ingo Molnar <mingo@redhat.com>, 
    Vincent Guittot <vincent.guittot@linaro.org>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, 
    linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
In-Reply-To: <20231009102949.GC14330@noisy.programming.kicks-ass.net>
Message-ID: <b8ab29de-1775-46e-dd75-cdf98be8b0@inria.fr>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien> <20231003215159.GJ1539@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041358420.3108@hadrien> <20231004120544.GA6307@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041822170.3108@hadrien>
 <20231004174801.GE19999@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041958380.3108@hadrien> <20231009102949.GC14330@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello,

I have looked further into the NUMA balancing issue.

The context is that there are 2N threads running on 2N cores, one thread
gets NUMA balanced to the other socket, leaving N+1 threads on one socket
and N-1 threads on the other socket.  This condition typically persists
for one or more seconds.

Previously, I reported this on a 4-socket machine, but it can also occur
on a 2-socket machine, with other tests from the NAS benchmark suite
(sp.B, bt.B, etc).

Since there are N+1 threads on one of the sockets, it would seem that load
balancing would quickly kick in to bring some thread back to socket with
only N-1 threads.  This doesn't happen, though, because actually most of
the threads have some NUMA effects such that they have a preferred node.
So there is a high chance that an attempt to steal will fail, because both
threads have a preference for the socket.

At this point, the only hope is active balancing.  However, triggering
active balancing requires the success of the following condition in
imbalanced_active_balance:

        if ((env->migration_type == migrate_task) &&
            (sd->nr_balance_failed > sd->cache_nice_tries+2))

sd->nr_balance_failed does not increase because the core is idle.  When a
core is idle, it comes to the load_balance function from schedule() though
newidle_balance.  newidle_balance always sends in the flag CPU_NEWLY_IDLE,
even if the core has been idle for a long time.

Changing newidle_balance to use CPU_IDLE rather than CPU_NEWLY_IDLE when
the core was already idle before the call to schedule() is not enough
though, because there is also the constraint on the migration type.  That
turns out to be (mostly?) migrate_util.  Removing the following
code from find_busiest_queue:

                        /*
                         * Don't try to pull utilization from a CPU with one
                         * running task. Whatever its utilization, we will fail
                         * detach the task.
                         */
                        if (nr_running <= 1)
                                continue;

and changing the above test to:

        if ((env->migration_type == migrate_task || env->migration_type == migrate_util) &&
            (sd->nr_balance_failed > sd->cache_nice_tries+2))

seems to solve the problem.

I will test this on more applications.  But let me know if the above
solution seems completely inappropriate.  Maybe it violates some other
constraints.

I have no idea why this problem became more visible with EEVDF.  It seems
to have to do with the time slices all turning out to be the same.  I got
the same behavior in 6.5 by overwriting the timeslice calculation to
always return 1.  But I don't see the connection between the timeslice and
the behavior of the idle task.

thanks,
julia

