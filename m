Return-Path: <linux-kernel+bounces-55009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E620084B634
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBAE2889DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B16130AEE;
	Tue,  6 Feb 2024 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLrDsUfi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771E12FF97
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225692; cv=none; b=icDe9x9TzyGe19ptH1A3ZV/uI8GZYPPJRaj4vcWm+nPwfVEyoYqQTiLtiPxra0RWOn8/QKURkLWaX5lCsKNkQie4OdpnQSggFZkghYROJXZVJXjxMzTQzTqVu9iREySQTkZdJsIhmgm1cQLKT5ItkxZWYAeQzcvhLUpYojE7G0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225692; c=relaxed/simple;
	bh=pf/4xNO0RcnqY1rxVEJcpesVWyWSGe2XC88PsXg6PCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOAgJbTL0fzVdNsp+3SOWZI9i5wie+6frBmfKSiE5FD4f5u2Z3P28lXJ83hl0ewrxSZz5Rkkg4mPP74XsDdIjQNfOWhVswjXDP4L43Im53ENDKAOth6TqK5njF0wSgYBd+Rhe6/y2/2fFmU5vOe7LQybksPuSSKJ/xfH8KJtXeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLrDsUfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DF3C433C7;
	Tue,  6 Feb 2024 13:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707225691;
	bh=pf/4xNO0RcnqY1rxVEJcpesVWyWSGe2XC88PsXg6PCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLrDsUfipJQVF2oMPJHA3LAQiC13qm+HrNRGpxrhmSbe30OFfcnn2EAFywxwkbAms
	 pcNDXEM5kUU7PcrpUMPxQZHhtt8vnIRoMgEZPA2HHqtvGJrH7f8nQJ//MSLWdEW8vY
	 Xeia7QruC7tJtvFvW0Xn8OVBP704Rg8zadLYlWJiycMVmvSwVNKC2xDgD52Jme7mXf
	 Vp4IWKUG4/MiGyPkLpg8moAohgKs+pAcdkgz9fFw8PIfnLXA+QcOUPRnZRf5vhjjJ9
	 SnVSXrm2wNmE9579pIEFRUhG2bkAG1sooO68fypGPMz1Ni9vP60NHG1bhpcfD4Xwjd
	 TI8tQNJksKI1A==
Date: Tue, 6 Feb 2024 14:21:28 +0100
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
Message-ID: <ZcIyWJxeLy4GaTbM@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZcAQZ8-gbEYaQflu@pavilion.home>
 <87eddp3ju0.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eddp3ju0.fsf@somnus>

Le Tue, Feb 06, 2024 at 12:36:55PM +0100, Anna-Maria Behnsen a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a écrit :
> >> +/*
> >> + * Returns true, if there is nothing to be propagated to the next level
> >> + *
> >> + * @data->firstexp is set to expiry of first gobal event of the (top level of
> >> + * the) hierarchy, but only when hierarchy is completely idle.
> >> + *
> >> + * This is the only place where the group event expiry value is set.
> >> + */
> >> +static
> >> +bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
> >> +			 struct tmigr_walk *data, union tmigr_state childstate,
> >> +			 union tmigr_state groupstate)
> >> +{
> >> +	struct tmigr_event *evt, *first_childevt;
> >> +	bool walk_done, remote = data->remote;
> >> +	bool leftmost_change = false;
> >> +	u64 nextexp;
> >> +
> >> +	if (child) {
> >> +		raw_spin_lock(&child->lock);
> >> +		raw_spin_lock_nested(&group->lock, SINGLE_DEPTH_NESTING);
> >> +
> >> +		if (childstate.active) {
> >> +			walk_done = true;
> >> +			goto unlock;
> >> +		}
> >> +
> >> +		first_childevt = tmigr_next_groupevt(child);
> >> +		nextexp = child->next_expiry;
> >> +		evt = &child->groupevt;
> >> +	} else {
> >> +		nextexp = data->nextexp;
> >> +
> >> +		first_childevt = evt = data->evt;
> >> +
> >> +		/*
> >> +		 * Walking the hierarchy is required in any case when a
> >> +		 * remote expiry was done before. This ensures to not lose
> >> +		 * already queued events in non active groups (see section
> >> +		 * "Required event and timerqueue update after a remote
> >> +		 * expiry" in the documentation at the top).
> >> +		 *
> >> +		 * The two call sites which are executed without a remote expiry
> >> +		 * before, are not prevented from propagating changes through
> >> +		 * the hierarchy by the return:
> >> +		 *  - When entering this path by tmigr_new_timer(), @evt->ignore
> >> +		 *    is never set.
> >> +		 *  - tmigr_inactive_up() takes care of the propagation by
> >> +		 *    itself and ignores the return value. But an immediate
> >> +		 *    return is required because nothing has to be done in this
> >> +		 *    level as the event could be ignored.
> >> +		 */
> >> +		if (evt->ignore && !remote)
> >> +			return true;
> >> +
> >> +		raw_spin_lock(&group->lock);
> >> +	}
> >> +
> >> +	if (nextexp == KTIME_MAX) {
> >> +		evt->ignore = true;
> >> +
> >> +		/*
> >> +		 * When the next child event could be ignored (nextexp is
> >> +		 * KTIME_MAX) and there was no remote timer handling before or
> >> +		 * the group is already active, there is no need to walk the
> >> +		 * hierarchy even if there is a parent group.
> >> +		 *
> >> +		 * The other way round: even if the event could be ignored, but
> >> +		 * if a remote timer handling was executed before and the group
> >> +		 * is not active, walking the hierarchy is required to not miss
> >> +		 * an enqueued timer in the non active group. The enqueued timer
> >> +		 * of the group needs to be propagated to a higher level to
> >> +		 * ensure it is handled.
> >> +		 */
> >> +		if (!remote || groupstate.active) {
> >> +			walk_done = true;
> >> +			goto unlock;
> >
> > So if the current tmc going inactive was the migrator for the whole hierarchy
> > and it is reaching here the top-level, this assumes that if none of this tmc's
> > groups have a timer, then it can just return. But what if the top level has
> > timers from other children? Who is going to handle them then?
> >
> > Should this be "goto check_toplvl" instead?
> >
> 
> Simply replacing this goto will not work. Then we chould end up with a
> 'data->firstexp' set even if we do not want to have it (when remote is
> not set).

Hmm, but the (groupstate.migrator == TMIGR_NONE) condition should prevent that,
no?

> 
> There is another issue in here. When the event could be ignored and it
> is propagated because of e.g. remote timer handling, then the timerqueue
> dance is done nevertheless. It's not a big problem (as the ignore flag
> is set and event is removed of queue when revisting the timer queue),
> but its obviously more work than it is required to have.

Right. I guess it doesn't hurt to delete it from the timerqueue if present and
then update group->next_expiry accordingly. But it's certainly not useful
to requeue it :-)

Thanks.

> 
> Thanks
> 
> >> +		}
> >> +	} else {
> >> +		/*
> >> +		 * An update of @evt->cpu and @evt->ignore flag is required only
> >> +		 * when @child is set (the child is equal or higher than lvl0),
> >> +		 * but it doesn't matter if it is written once more to the per
> >> +		 * CPU event; make the update unconditional.
> >> +		 */
> >> +		evt->cpu = first_childevt->cpu;
> >> +		evt->ignore = false;
> >> +	}
> >> +
> >> +	walk_done = !group->parent;
> >> +
> >> +	/*
> >> +	 * If the child event is already queued in the group, remove it from the
> >> +	 * queue when the expiry time changed only.
> >> +	 */
> >> +	if (timerqueue_node_queued(&evt->nextevt)) {
> >> +		if (evt->nextevt.expires == nextexp)
> >> +			goto check_toplvl;
> >> +
> >> +		leftmost_change = timerqueue_getnext(&group->events) == &evt->nextevt;
> >> +		if (!timerqueue_del(&group->events, &evt->nextevt))
> >> +			WRITE_ONCE(group->next_expiry, KTIME_MAX);
> >> +	}
> >> +
> >> +	evt->nextevt.expires = nextexp;
> >> +
> >> +	if (timerqueue_add(&group->events, &evt->nextevt)) {
> >> +		leftmost_change = true;
> >> +		WRITE_ONCE(group->next_expiry, nextexp);
> >> +	}
> >> +
> >> +check_toplvl:
> >> +	if (walk_done && (groupstate.migrator == TMIGR_NONE)) {
> >> +		/*
> >> +		 * Nothing to do when first event didn't changed and update was
> >> +		 * done during remote timer handling.
> >> +		 */
> >> +		if (remote && !leftmost_change)
> >> +			goto unlock;
> >> +		/*
> >> +		 * The top level group is idle and it has to be ensured the
> >> +		 * global timers are handled in time. (This could be optimized
> >> +		 * by keeping track of the last global scheduled event and only
> >> +		 * arming it on the CPU if the new event is earlier. Not sure if
> >> +		 * its worth the complexity.)
> >> +		 */
> >> +		data->firstexp = tmigr_next_groupevt_expires(group);
> >> +	}
> >> +
> >> +unlock:
> >> +	raw_spin_unlock(&group->lock);
> >> +
> >> +	if (child)
> >> +		raw_spin_unlock(&child->lock);
> >> +
> >> +	return walk_done;
> >> +}

