Return-Path: <linux-kernel+bounces-41438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1963083F10E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57CFAB215C5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33161F610;
	Sat, 27 Jan 2024 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS1aeVR/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5BB1B5A2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706396090; cv=none; b=BweTKEpWHoXFzYthx6+Bx1wJKcHFlTC02baHOxqynKm7fiUHZ8I3tDwADXICXl8OmSzJdu0wEuXN36YtS+mCYF3CMpathuZtVRVt3Q1qcdEXX/0Rltl+z3Tyibkgi4S7lRQTcOieLi5HyVbQC7D7dLRMTPbCGPT6RtcgsBHc57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706396090; c=relaxed/simple;
	bh=370I368JkEbf62IfBIhLWjkUe3JoHqmbaGLHUsRzWC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbtJxrRbTuuHhAAecAX4HKOBVfqToKJk66ufKatOjdjDFzvZQPEAxXzCtD5Wia1eYvS2tQraR3oCsLD2JDWv0zJ+rHWjU/h/pyP64SGwwOeyEZau9m6DsUxHySpX0YmrPWcj01N0O5KCwRqkP/InLAhBUgRdR7oUsiRiFukx8Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS1aeVR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B5DC433F1;
	Sat, 27 Jan 2024 22:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706396089;
	bh=370I368JkEbf62IfBIhLWjkUe3JoHqmbaGLHUsRzWC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PS1aeVR/n42M1nk6sozs9oDvVvNPkI0dzOfqWPoe1F9jWCRiTPSXGMCQ0Zs2rJDNF
	 p9roPhxObuboqnI6f4nKBdN+dNKHEadHb0epQJ1BJDkl8v54l0RPBFe6U0fQXZz+wi
	 8TXkwmcwCPxqCWNTCTqcnfyblcouLrY9UNIwBw0iLBWev3ydGWOqteCZLOZ1UinfV+
	 AqcN1iYe60TTfUSI8MiEfYx9iWcuVAnVQokqpMXyDp0C4Efw50ijnhNUhIt7HpbCNf
	 BiWxN7IyO5SHFvwnq4G89ifDSieBrfmAmcYKVdL4XWD01SPhb8dUnVBSnBKa76bHUT
	 88Nzw0R8rMuUw==
Date: Sat, 27 Jan 2024 23:54:46 +0100
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
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v10 18/20] timers: Implement the hierarchical pull model
Message-ID: <ZbWJtkAj9z0S9xsH@pavilion.home>
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
> +	childstate.state = 0;
> +
> +	do {

So I got the confirmation from Boqun (+Cc) and Paul that a failing cmpxchg
may not order the load of the old value against subsequent loads. And
that may apply to atomic_try_cmpxchg() as well.

Therefore you not only need to turn group->migr_state read into
an atomic_read_acquire() but you also need to do this on each iteration
of this loop. For example you can move the read_acquire right here.

Thanks.

> +		if (child)
> +			childstate.state = atomic_read(&child->migr_state);
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

