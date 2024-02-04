Return-Path: <linux-kernel+bounces-51923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371868490F2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66F31F22B60
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3382C68D;
	Sun,  4 Feb 2024 22:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBlQUPA1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B62C684
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 22:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084178; cv=none; b=MaFNnrx5ZU5w+e5h/gIS8grTGY4wPp++pHImCWzB+MFJamWf0Yv7pAVCcMtcLaDjDM4EeE2YvtfIo4jPtgeKxJ1VoM5cpG2d/110Av9+jn2udgZS9lWYGlxPL9YGCjBDysEpIOLaGQxFS9/mBCuPOhkdnth3OHXvP75VZ5BmxSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084178; c=relaxed/simple;
	bh=raJu7dy8N0SEcpEQinY+IE0c30OP1YDerbzHf89qjCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc8QGXjdLZt3vAxFiX42lfSYVZT+/Tj4t8NJWfgeYKDSiCYY2WPwbS+mGWJRbUzJuuWgNzgTi6tVQBWLqicm9/fc+8OOJacCRJv/aUiKwfkGVIG+pJrhdpO94Qmpwov2BrE9k/2JSk0NoVelUPI9wpVM+hs+agB7rSInGt2/Kc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBlQUPA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AC2C433C7;
	Sun,  4 Feb 2024 22:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707084177;
	bh=raJu7dy8N0SEcpEQinY+IE0c30OP1YDerbzHf89qjCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oBlQUPA1M0Xmg8IuVSwLR88ukABAPhSUb0LyfaRBgYI4jmUaJObNvwTqnNN+SzsVY
	 mIawHOxTRlMZzTpBxMxWR+6nOEOAOKioGvPdltcAMyIrS5TLhG/8MfWASwUaN+/PZf
	 oH3s7GuiESVDKXbr7LN98yYWBLGsCHy9QwFZbSu6DmqTWDQEV08oZ/GJxrtIR1QmAl
	 Tk297TWqX+ZGzz/BgDCMB3lS6i+neGqwIeH6L+EOeKqD6okfrJCPZySbD7yAhzgAJ3
	 L3zrwEhuL8E+Is5EOdrpSN0BZAdS//PxV8cZ/btu8gyhzjouA//uubZeu/b59bhK7B
	 rWgZxnpXdOUOg==
Date: Sun, 4 Feb 2024 23:02:54 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v10 18/20] timers: Implement the hierarchical pull model
Message-ID: <ZcAJjhZKlcUDxzKc@pavilion.home>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-19-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a écrit :
> +/*
> + * Returns true, if there is nothing to be propagated to the next level
> + *
> + * @data->firstexp is set to expiry of first gobal event of the (top level of
> + * the) hierarchy, but only when hierarchy is completely idle.
> + *
> + * This is the only place where the group event expiry value is set.
> + */
> +static
> +bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
> +			 struct tmigr_walk *data, union tmigr_state childstate,
> +			 union tmigr_state groupstate)
> +{
> +	struct tmigr_event *evt, *first_childevt;
> +	bool walk_done, remote = data->remote;
> +	bool leftmost_change = false;
> +	u64 nextexp;
> +
> +	if (child) {
> +		raw_spin_lock(&child->lock);
> +		raw_spin_lock_nested(&group->lock, SINGLE_DEPTH_NESTING);
> +
> +		if (childstate.active) {
> +			walk_done = true;
> +			goto unlock;
> +		}
> +
> +		first_childevt = tmigr_next_groupevt(child);
> +		nextexp = child->next_expiry;
> +		evt = &child->groupevt;
> +	} else {
> +		nextexp = data->nextexp;
> +
> +		first_childevt = evt = data->evt;
> +
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
> +		 */
> +		if (evt->ignore && !remote)
> +			return true;
> +
> +		raw_spin_lock(&group->lock);
> +	}
> +
> +	if (nextexp == KTIME_MAX) {
> +		evt->ignore = true;
> +
> +		/*
> +		 * When the next child event could be ignored (nextexp is
> +		 * KTIME_MAX) and there was no remote timer handling before or
> +		 * the group is already active, there is no need to walk the
> +		 * hierarchy even if there is a parent group.
> +		 *
> +		 * The other way round: even if the event could be ignored, but
> +		 * if a remote timer handling was executed before and the group
> +		 * is not active, walking the hierarchy is required to not miss
> +		 * an enqueued timer in the non active group. The enqueued timer
> +		 * of the group needs to be propagated to a higher level to
> +		 * ensure it is handled.
> +		 */
> +		if (!remote || groupstate.active) {
> +			walk_done = true;
> +			goto unlock;
> +		}
> +	} else {
> +		/*
> +		 * An update of @evt->cpu and @evt->ignore flag is required only
> +		 * when @child is set (the child is equal or higher than lvl0),
> +		 * but it doesn't matter if it is written once more to the per
> +		 * CPU event; make the update unconditional.
> +		 */
> +		evt->cpu = first_childevt->cpu;
> +		evt->ignore = false;
> +	}
> +
> +	walk_done = !group->parent;
> +
> +	/*
> +	 * If the child event is already queued in the group, remove it from the
> +	 * queue when the expiry time changed only.
> +	 */
> +	if (timerqueue_node_queued(&evt->nextevt)) {
> +		if (evt->nextevt.expires == nextexp)
> +			goto check_toplvl;
> +
> +		leftmost_change = timerqueue_getnext(&group->events) == &evt->nextevt;
> +		if (!timerqueue_del(&group->events, &evt->nextevt))
> +			WRITE_ONCE(group->next_expiry, KTIME_MAX);
> +	}
> +
> +	evt->nextevt.expires = nextexp;
> +
> +	if (timerqueue_add(&group->events, &evt->nextevt)) {
> +		leftmost_change = true;
> +		WRITE_ONCE(group->next_expiry, nextexp);
> +	}
> +
> +check_toplvl:
> +	if (walk_done && (groupstate.migrator == TMIGR_NONE)) {
> +		/*
> +		 * Nothing to do when first event didn't changed and update was
> +		 * done during remote timer handling.
> +		 */
> +		if (remote && !leftmost_change)

So if the first timer in the list hasn't changed, and that first timer belongs
to another CPU (and another group) than the tmc for which we are remotely
handling timers and re-propagating timers up, then data->firstexp will be
after the leftmost timer expiration (data->firstexp could even be KTIME_MAX
in the worst case), and so will be tmc->wakeup for the caller of
tmigr_handle_remote()?

Thanks.


> +			goto unlock;
> +		/*
> +		 * The top level group is idle and it has to be ensured the
> +		 * global timers are handled in time. (This could be optimized
> +		 * by keeping track of the last global scheduled event and only
> +		 * arming it on the CPU if the new event is earlier. Not sure if
> +		 * its worth the complexity.)
> +		 */
> +		data->firstexp = tmigr_next_groupevt_expires(group);
> +	}
> +
> +unlock:
> +	raw_spin_unlock(&group->lock);
> +
> +	if (child)
> +		raw_spin_unlock(&child->lock);
> +
> +	return walk_done;
> +}

