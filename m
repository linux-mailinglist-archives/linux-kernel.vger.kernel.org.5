Return-Path: <linux-kernel+bounces-40101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B2B83DA55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13024292991
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122801B5A2;
	Fri, 26 Jan 2024 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYHi+SUJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB0175AE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273597; cv=none; b=ehawT7u7+NamQ8qEiPiBRYCHFykh96avAGlQA8IcWDEpFjJud/ZraoJokgklh0fMvolYmbTpwUWgkf9kwOtZ1I1LdDWG9jJMlQB83gMOZGDyb0eEh1JDt4ykO2WSKCcCCmR+oGdIbftvOWz2DOxchrhv1SHOJ/6PD7VzgbmCkz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273597; c=relaxed/simple;
	bh=HHQ9uNXBo4a0b5iPNJL1gSJx/JBEMjonGTMJo4OoIdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUZFbmHwphxNzqcO8CgXudzTzXvfEPFaDryRJfrhSOezrPNYjcjYdr3zImRyWlFONlU5iLrxrjxlkJnEFa3qB0t7o7JZnLG7hRnS+lXseFX/lkO9gCXGeY69W65YCbbW6rcPCRcM3s5QWFI3qk9aoCv/2wdDGYMAA6kZvNdA5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYHi+SUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2E5C433C7;
	Fri, 26 Jan 2024 12:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706273596;
	bh=HHQ9uNXBo4a0b5iPNJL1gSJx/JBEMjonGTMJo4OoIdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYHi+SUJFCreUFBbFFHU+jtCipPNSnLLRMTme+fNJy0alPj99zoQrYIzRYK+zYd5V
	 oMGggiLO4MnQkLz+mOY6WFAH9F2CQi9IVKRN6qcpDU92Z3tKE/7a0tl8ovM82sptk7
	 Ttce1sA6ept2UVitpZdEsQcBnzML9WI4tT/uUPyuliZkcvDylljF0GlEe7YBhSYcj+
	 xDp/WfeKSMyWVxopDKQpXZGQmb5PFO6eqYBlUerszn5Jh3fvD+ao84NPp24wwQdFpQ
	 HaEZ4GuEbSmPN5RETJjEotqg73gYjAFVYxvu8CW/FxkMZUjrtxSWxuHQOLHieAltoT
	 2lCvNKtDvWtCQ==
Date: Fri, 26 Jan 2024 13:53:13 +0100
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
Message-ID: <ZbOrOV8kWUd59h9q@lothringen>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115143743.27827-19-anna-maria@linutronix.de>

On Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen wrote:
> + * Protection of the tmigr group state information:
> + * ------------------------------------------------
> + *
> + * The state information with the list of active children and migrator needs to
> + * be protected by a sequence counter. It prevents a race when updates in child
> + * groups are propagated in changed order. The state update is performed
> + * lockless and group wise. The following scenario describes what happens
> + * without updating the sequence counter:
> + *
> + * Therefore, let's take three groups and four CPUs (CPU2 and CPU3 as well
> + * as GRP0:1 will not change during the scenario):
> + *
> + *    LVL 1            [GRP1:0]
> + *                     migrator = GRP0:1
> + *                     active   = GRP0:0, GRP0:1
> + *                   /                \
> + *    LVL 0  [GRP0:0]                  [GRP0:1]
> + *           migrator = CPU0           migrator = CPU2
> + *           active   = CPU0           active   = CPU2
> + *              /         \                /         \
> + *    CPUs     0           1              2           3
> + *             active      idle           active      idle
> + *
> + *
> + * 1. CPU0 goes idle. As the update is performed group wise, in the first step
> + *    only GRP0:0 is updated. The update of GRP1:0 is pending as CPU0 has to
> + *    walk the hierarchy.
> + *
> + *    LVL 1            [GRP1:0]
> + *                     migrator = GRP0:1
> + *                     active   = GRP0:0, GRP0:1
> + *                   /                \
> + *    LVL 0  [GRP0:0]                  [GRP0:1]
> + *       --> migrator = TMIGR_NONE     migrator = CPU2
> + *       --> active   =                active   = CPU2
> + *              /         \                /         \
> + *    CPUs     0           1              2           3
> + *         --> idle        idle           active      idle
> + *
> + * 2. While CPU0 goes idle and continues to update the state, CPU1 comes out of
> + *    idle. CPU1 updates GRP0:0. The update for GRP1:0 is pending as CPU1 also
> + *    has to the hierarchy. Both CPUs (CPU0 and CPU1) now walk the hierarchy to
> + *    perform the needed update from their point of view. The currently visible
> + *    state looks the following:
> + *
> + *    LVL 1            [GRP1:0]
> + *                     migrator = GRP0:1
> + *                     active   = GRP0:0, GRP0:1
> + *                   /                \
> + *    LVL 0  [GRP0:0]                  [GRP0:1]
> + *       --> migrator = CPU1           migrator = CPU2
> + *       --> active   = CPU1           active   = CPU2
> + *              /         \                /         \
> + *    CPUs     0           1              2           3
> + *             idle    --> active         active      idle
> + *
> + * 3. Here is the race condition: CPU1 managed to propagate its changes (from
> + *    step 2) through the hierarchy to GRP1:0 before CPU0 (step 1) did. The
> + *    active members of GRP1:0 remain unchanged after the update since it is
> + *    still valid from CPU1 current point of view:
> + *
> + *    LVL 1            [GRP1:0]
> + *                 --> migrator = GRP0:1
> + *                 --> active   = GRP0:0, GRP0:1
> + *                   /                \
> + *    LVL 0  [GRP0:0]                  [GRP0:1]
> + *           migrator = CPU1           migrator = CPU2
> + *           active   = CPU1           active   = CPU2
> + *              /         \                /         \
> + *    CPUs     0           1              2           3
> + *             idle        active         active      idle

So let's take this scenario and suppose we are at this stage. CPU 1
has propagated the state up to [GRP1:0] and CPU 0 is going to do it
but hasn't yet.

> +static bool tmigr_inactive_up(struct tmigr_group *group,
> +			      struct tmigr_group *child,
> +			      void *ptr)
> +{
> +	union tmigr_state curstate, newstate, childstate;
> +	struct tmigr_walk *data = ptr;
> +	bool walk_done;
> +	u8 childmask;
> +
> +	childmask = data->childmask;
> +	curstate.state = atomic_read(&group->migr_state);

And now suppose CPU 0 arrives here and sees the group->migr_state change
performed by CPU 1. So it's all good, right? The below atomic_cmpxchg()
will success on the first take.

> +	childstate.state = 0;
> +
> +	do {
> +		if (child)
> +			childstate.state = atomic_read(&child->migr_state);

But then how do you guarantee that CPU 0 will load here the version of
child->migr_state modified by CPU 1? What prevents from loading the stale value?
The one that was modified by CPU 0 instead? Nothing because the two above reads
are unordered. As a result, CPU 0 may ignore the fact that CPU 1 is up and
wrongly report GRP0:0 as active up to GRP1:0.

One way to solve this is to change the above atomic_read(&group->migr_state)
into atomic_read_acquire(&group->migr_state). It's cheap and pairs with the
order enforced by the upwards successful cmpxchg calls.

> +
> +		newstate = curstate;
> +		walk_done = true;
> +
> +		/* Reset active bit when the child is no longer active */
> +		if (!childstate.active)
> +			newstate.active &= ~childmask;
> +
> +		if (newstate.migrator == childmask) {
> +			/*
> +			 * Find a new migrator for the group, because the child
> +			 * group is idle!
> +			 */
> +			if (!childstate.active) {
> +				unsigned long new_migr_bit, active = newstate.active;
> +
> +				new_migr_bit = find_first_bit(&active, BIT_CNT);
> +
> +				if (new_migr_bit != BIT_CNT) {
> +					newstate.migrator = BIT(new_migr_bit);
> +				} else {
> +					newstate.migrator = TMIGR_NONE;
> +
> +					/* Changes need to be propagated */
> +					walk_done = false;
> +				}
> +			}
> +		}
> +
> +		newstate.seq++;
> +
> +		WARN_ON_ONCE((newstate.migrator != TMIGR_NONE) && !(newstate.active));
> +
> +	} while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state));

Similarly, I seem to remember that a failing cmpxchg() doesn't imply a full
memory barrier. If it's the case, you may need to reload &group->migr_state
using an acquire barrier. But lemme check that...

Thanks.

