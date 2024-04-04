Return-Path: <linux-kernel+bounces-132192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A4A89912B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6874228270B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2C013C66F;
	Thu,  4 Apr 2024 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLXsDW5K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226E913C3FE;
	Thu,  4 Apr 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269145; cv=none; b=R2qa2Y39qYrevBI7xMoPUs4C5NlndG7v1nxIRx9Z2OiRHNDRZDb4oENTyxRyJE/T1Cg2leA4IppGv8QNzFOmTWGLozMvyRFA3oAyQjwCOPN1r3FKneZUzv2sitj3MMtff1hRRNGgXn4hYIrWhXR2YopyHbNVcXrUoZcBDb79gFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269145; c=relaxed/simple;
	bh=1kpkiFXb3c+FOQ+yAMlxh/XD3CMvGXT8U3rVBr+8CZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcuMoKzXGxsSRsHfmqOsmYWINgpc16QiadMt+3/OvY51SmHXJZsZIt3z3qAaglszul2ME4QsrvmpOiz3yxyiOGQSJZTc37dyz04XF8K/oZQlaTVadUTgYxcYajpisDLZ4MbGz3PbqGPcXshi0GzWee3HR4XV+8QzU8UgZ+5Z4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLXsDW5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C41C43394;
	Thu,  4 Apr 2024 22:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712269144;
	bh=1kpkiFXb3c+FOQ+yAMlxh/XD3CMvGXT8U3rVBr+8CZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TLXsDW5K0fwXugPWxJk+/Zxyr1QVVs+JJeVrnD/+odlWOgqI0nCZq7pKsD4cknVx1
	 Rx/WikDVfFw4+/Olv+anx1WXrEdJzKPZlE7B7U6LZfcdt9Dta5UV0Zx5rvODRsPHh3
	 la33hh98GCjIp93ApvRCqB4uGdmeRjqt88ntQOrY2uwdPX/UW4V+hbFV20pK8Z1oXE
	 n+57B4EGsn8tPq+u25Nmq0vISvTjn8y5ELD2uMG/6rNnjBIUJlzN9XsbutySdzWDAQ
	 Zq6cQhUVrtDVA3CGeVAuHxG2d90AB/iJjulk9M5ru3zMtaBJN4mK33sBBHx9Fu9Al9
	 xvcvyozBkUMvw==
Date: Fri, 5 Apr 2024 00:19:01 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Joel Fernandes <joel@joelfernandes.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	paulmck@kernel.org, mingo@kernel.org, rcu@vger.kernel.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, bigeasy@linutronix.de,
	chenzhongjin@huawei.com, yangjihong1@huawei.com,
	rostedt@goodmis.org, Justin Chen <justin.chen@broadcom.com>
Subject: Re: [PATCH] timers/migration: Return early on deactivation
Message-ID: <Zg8nVbKHPhUJfmgc@pavilion.home>
References: <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>
 <ZfNHNvzpqf8DOZd8@boqun-archlinux>
 <de038bee-cecd-4e76-b0f4-5822b68e439d@gmail.com>
 <87v85olez3.ffs@tglx>
 <87sf0sldbi.ffs@tglx>
 <ZfN0wY41pU5UjP8T@boqun-archlinux>
 <ZfOhB9ZByTZcBy4u@lothringen>
 <87zfulrlnn.fsf@somnus>
 <ZgMDcGOagCjfIB3i@localhost.localdomain>
 <87bk6pvzql.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bk6pvzql.fsf@somnus>

Le Thu, Apr 04, 2024 at 06:50:26PM +0200, Anna-Maria Behnsen a écrit :
> Commit 4b6f4c5a67c0 ("timer/migration: Remove buggy early return on
> deactivation") removed the logic to return early in tmigr_update_events()
> on deactivation. With this the problem with a not properly updated first
> global event in a hierarchy containing only a single group was fixed.
> 
> But when having a look at this code path with a hierarchy with more than a
> single level, now unnecessary work is done (example is partially copied
> from the message of the commit mentioned above):
> 
>                             [GRP1:0]
>                          migrator = GRP0:0
>                          active   = GRP0:0
>                          nextevt  = T0:0i, T0:1
>                          /              \
>               [GRP0:0]                  [GRP0:1]
>            migrator = 0              migrator = NONE
>            active   = 0              active   = NONE
>            nextevt  = T0i, T1        nextevt  = T2
>            /         \                /         \
>           0 (T0i)     1 (T1)         2 (T2)      3
>       active         idle            idle       idle
> 
> 0) CPU 0 is active thus its event is ignored (the letter 'i') and so are
> upper levels' events. CPU 1 is idle and has the timer T1 enqueued.
> CPU 2 also has a timer. The expiry order is T0 (ignored) < T1 < T2
> 
>                             [GRP1:0]
>                          migrator = GRP0:0
>                          active   = GRP0:0
>                          nextevt  = T0:0i, T0:1
>                          /              \
>               [GRP0:0]                  [GRP0:1]
>            migrator = NONE           migrator = NONE
>            active   = NONE           active   = NONE
>            nextevt  = T1             nextevt  = T2
>            /         \                /         \
>           0 (T0i)     1 (T1)         2 (T2)      3
>         idle         idle            idle         idle
> 
> 1) CPU 0 goes idle without global event queued. Therefore KTIME_MAX is
> pushed as its next expiry and its own event kept as "ignore". Without this
> early return the following steps happen in tmigr_update_events() when
> child = null and group = GRP0:0 :
> 
>   lock(GRP0:0->lock);
>   timerqueue_del(GRP0:0, T0i);
>   unlock(GRP0:0->lock);
> 
> 
>                             [GRP1:0]
>                          migrator = NONE
>                          active   = NONE
>                          nextevt  = T0:0, T0:1
>                          /              \
>               [GRP0:0]                  [GRP0:1]
>            migrator = NONE           migrator = NONE
>            active   = NONE           active   = NONE
>            nextevt  = T1             nextevt  = T2
>            /         \                /         \
>           0 (T0i)     1 (T1)         2 (T2)      3
>         idle         idle            idle         idle
> 
> 2) The change now propagates up to the top. Then tmigr_update_events()
> updates the group event of GRP0:0 and executes the following steps
> (child = GRP0:0 and group = GRP0:0):
> 
>   lock(GRP0:0->lock);
>   lock(GRP1:0->lock);
>   evt = tmigr_next_groupevt(GRP0:0); -> this removes the ignored events
> 					in GRP0:0
>   ... update GRP1:0 group event and timerqueue ...
>   unlock(GRP1:0->lock);
>   unlock(GRP0:0->lock);
> 
> So the dance in 1) with locking the GRP0:0->lock and removing the T0i from
> the timerqueue is redundand as this is done nevertheless in 2) when
> tmigr_next_groupevt(GRP0:0) is executed.
> 
> Revert commit 4b6f4c5a67c0 ("timer/migration: Remove buggy early return on
> deactivation") and add a condition into return path to skip the return
> only, when hierarchy contains a single group.
> 
> Fixes: 4b6f4c5a67c0 ("timer/migration: Remove buggy early return on deactivation")
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Just some comment nits:

> ---
>  kernel/time/timer_migration.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -751,6 +751,31 @@ bool tmigr_update_events(struct tmigr_gr
>  
>  		first_childevt = evt = data->evt;
>  
> +		/*
> +		 * Walking the hierarchy is required in any case when a
> +		 * remote expiry was done before. This ensures to not lose
> +		 * already queued events in non active groups (see section
> +		 * "Required event and timerqueue update after a remote
> +		 * expiry" in the documentation at the top).
> +		 *
> +		 * The two call sites which are executed without a remote expiry
> +		 * before, are not prevented from propagating changes through
> +		 * the hierarchy by the return:
> +		 *  - When entering this path by tmigr_new_timer(), @evt->ignore
> +		 *    is never set.
> +		 *  - tmigr_inactive_up() takes care of the propagation by
> +		 *    itself and ignores the return value. But an immediate
> +		 *    return is required because nothing has to be done in this
> +		 *    level as the event could be ignored.

It's not exactly required, it's an optimization. How about:

"""
But an immediate return is possible if there is a parent, sparing group
locking at this level, because the upper walking call to the parent will
take care about removing this event from within the group and update
next_expiry accordingly.
"""

> +		 *
> +		 * But, if the hierarchy has only a single level so @group is
> +		 * the top level group, make sure first event information of the
> +		 * group is updated properly and also handled properly, so skip
> +		 * this fast return path.

"""
However if there is no parent, ie: the hierarchy has only a single level so
@group is the top level group, make sure the first event information of the
group is updated properly and also handled properly, so skip
this fast return path.
"""

Thanks.

> +		 */
> +		if (evt->ignore && !remote && group->parent)
> +			return true;
> +
>  		raw_spin_lock(&group->lock);
>  
>  		childstate.state = 0;

