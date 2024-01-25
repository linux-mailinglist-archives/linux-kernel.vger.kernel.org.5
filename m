Return-Path: <linux-kernel+bounces-38724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B790983C4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41761C22FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF6467743;
	Thu, 25 Jan 2024 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8zKiN/b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B766B5B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193062; cv=none; b=m+MqHYuaDIXeGi0YelKx4O79yJtezKGj9Dd5Kk28zwDzSbACIicPeSz5LJWCiLlQDtHMibVTWuvqtwSwK+lPXzOBUBg6UGGwHhSEXCmz7H50MuN87NAEAfyLCfx5h35xLMoahX9sgN92z/InXYnRLOU80NyCe/uOXMFRHrgq4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193062; c=relaxed/simple;
	bh=Jxb0QFGJU2Vow9inN+qsbk60x49TTOXd/mh4ta1O2DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEjqi0b0T4PCrgCHgN/K1C1yz5M962/cPYXH76Hywb2A108kB6DYtLZNu9jKoRkC6XJs0lf+LZ+3vDA3loTTuKVwvgzAHZHW6FsJHer++jc4SSoJ131Tn9zbNsntLfsramLEWP2Lk2B6eFzOHPNjDuXOYwrO7ctxeq0k6fVfGwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8zKiN/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2C0C433C7;
	Thu, 25 Jan 2024 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706193061;
	bh=Jxb0QFGJU2Vow9inN+qsbk60x49TTOXd/mh4ta1O2DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q8zKiN/bIGZTA6ggfRw1O5Q74VIiT0KvNo1JLp7aiGDsmkdnbF6vW+ykgFaCffBYt
	 WZ69Y7Pz9I3fdwEmpT405oB5kjT8R5LzGOwSedQMjPn6m1ACbRzhZ+rtBR0DLWP8hm
	 9qoFcXQZM+fCCs4mWkdJ3DDWfSBLxWzs1MJI5gY5Q54TcHfkxCMrxkyeobYQn0pv6i
	 ChVhKe0/shxLz+yAJLQ+Hz/LnuA/XR1mi7ByAul9/lfesZn5YK1DKtwy+6M9zFVFhG
	 u8P/4UU2gflYN1+wZhGJvn7eN+bBrNdiO7XOFSXKBB6jtpExOqY2lMj9oYi0cjm08O
	 dISzcT5/VSK9w==
Date: Thu, 25 Jan 2024 15:30:58 +0100
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
Message-ID: <ZbJwol4QoSgz0QlH@lothringen>
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
> +/**
> + * tmigr_quick_check() - Quick forecast of next tmigr event when CPU wants to
> + *			 go idle
> + *
> + * Returns KTIME_MAX, when it is probable that nothing has to be done (not the
> + * only one in the level 0 group; and if it is the only one in level 0 group,
> + * but there are more than a single group active in top level)
> + *
> + * Returns first expiry of the top level group, when it is the only one in level
> + * 0 and top level also only has a single active child.
> + */
> +u64 tmigr_quick_check(void)
> +{
> +	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> +	struct tmigr_group *topgroup;
> +	struct list_head lvllist;
> +
> +	if (tmigr_is_not_available(tmc))
> +		return KTIME_MAX;

Offline CPUs are supposed to handle their own global timers.

So instead of returning KTIME_MAX here, shouldn't we pass instead
tevt->global as a parameter and return that value?

Otherwise the quick check will simply ignore the next global event of this CPU
if it's before the next local event.

> +
> +	if (WARN_ON_ONCE(tmc->idle))
> +		return KTIME_MAX;

Same here I guess...

> +
> +	if (!tmigr_check_migrator_and_lonely(tmc->tmgroup, tmc->childmask))
> +		return KTIME_MAX;

This one makes sense.

> +
> +	for (int i = tmigr_hierarchy_levels; i > 0 ; i--) {
> +		lvllist = tmigr_level_list[i - 1];
> +		if (list_is_singular(&lvllist)) {
> +			topgroup = list_first_entry(&lvllist, struct
> tmigr_group, list);

Is it safe against concurrent allocation failure in hotplug?

If the list is seen singular, then concurrently a CPU comes up and creates/add
a new group. The current CPU actually fetches it instead of the current group
because it's not singular anymore. But then some higher level group
allocation fails and the newly added first entry is removed.

list_is_singular() looks safe. But list_first_entry isn't. You can create
list_first_entry_rcu:

#define list_first_entry_rcu(ptr, type, member) \
	list_entry_rcu((ptr)->next, type, member)

Protected inside rcu_read_lock() until the below READ_ONCE().

And then use list_del_rcu/list_add_rcu/kfree_rcu on the update side.

Isn't it possible to walk through group->parent instead?

> +
> +			if (tmigr_check_lonely(topgroup))
> +				return READ_ONCE(topgroup->next_expiry);
> +		} else {
> +			continue;
> +		}
> +	}
> +
> +	return KTIME_MAX;

I'm less sure about that return value.

Thanks.

