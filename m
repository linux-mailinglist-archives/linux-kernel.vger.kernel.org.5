Return-Path: <linux-kernel+bounces-44855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEF084282D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2281B23359
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E1A67728;
	Tue, 30 Jan 2024 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cd3AW5qo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1856823C9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629073; cv=none; b=FcHxpNof7pYHNUf5hd3cWI5PDOJk600Kax4YRmuWrpNgGpSYpXaw5mlSzfdysZxrZl3spd0a8ZUZux4Pclkyvp74j7L/Nj503zxXFMyTgrQYLeV6YLB/WtfQFgVMbhLMXf6N3vmnCV4bWLEGM2XpUCAW6lOWlXYk9OABI2vBOJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629073; c=relaxed/simple;
	bh=Q2jU8mI6QU9vdEr3G9SjftB5pMPgeSRDEqdSY3gxRXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F20IZsm3VeKeP7FVD0wZbTRiJwpXRC2NfMgfn3dQf9FK1gPn/eDzUmBjprAmLkL/Z9iWYE+nkHnrAOuotzDFa9GyFhrXdbd8ou/tHOqbIijosI0cQqglneDbXbKIKx0HO7Lzu8ufGXKEmG2EEPzJAZ1bVGeedoAL7d7iZpZjIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cd3AW5qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5D7C43390;
	Tue, 30 Jan 2024 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629073;
	bh=Q2jU8mI6QU9vdEr3G9SjftB5pMPgeSRDEqdSY3gxRXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cd3AW5qo//fBbvgiA5UOeoA+r7UnuS7qLDxV/rgyMxPIO4O5dJgkbV4Nf3pGkSo2q
	 GZ56tTYe6s6/h67q7c9+ObgCd4M8ijV/pHINyyfStPAIwcT5jCLRUAzb5/xE53SuQA
	 6wIQ9tPEapdV51zvv2DTGxHWcMWNmIfF1UIIkNBSD2omk8GbiJvkLs3nncAABAdINL
	 tR+bidQPyl3o1saCQezfODshmEzaWgsHBY+TbexVzP7/dD5OK6HB4JNnL8zczLk7pH
	 37WQkwLVfMDaFcLeJn9Ngk1kKE1n317uMV3kD2bRsUnEYHCBn9gfiUewYT5vAc2bjw
	 vXa83I/GAyBlg==
Date: Tue, 30 Jan 2024 16:37:50 +0100
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
Message-ID: <ZbkXzsUWZUurSiSk@localhost.localdomain>
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

Since you're going to do the atomic_read(&group->migr_state)
within the group->lock, you may as well do the atomic_read(&child->migr_state)
within the child->lock. It won't hurt and simplifies the picture
in the mind. Then you can add the following comment to outline the ordering
expectations:

/*
 * Observing child->migr_state.active means that:
 *
 * 1) Either the child is effectively active, then it's fine to stop here
 *
 * 2) Or we are racing with a CPU going inactive and this childstate is actually
 *    not active anymore but tmigr_inactive_up() hasn't yet called tmigr_update_event()
 *    on it. It's fine to stop here because that pending call will take care
 *    of the rest of the propagation.
 *
 * 3) In any case it's impossible to observe childstate.active when a racing
 *    CPU made it inactive and also called tmigr_update_event() on it. The
 *    group->lock enforces ordering such that ->migr_state changes
 *    in tmigr_inactive_up() are released by group->lock UNLOCK on the
 *    subsequent call to tmigr_update_event() and then acquired by
 *    child->lock LOCK in tmigr_new_timer() -> tmigr_update_event().
 */
 
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

Same here, fetching group->migr_state.active from within the lock simplifies
the mind mapping.

Thanks.

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

