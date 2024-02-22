Return-Path: <linux-kernel+bounces-76358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AFB85F61F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAAA1F25DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56D940BEA;
	Thu, 22 Feb 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0p5hm1l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB626405D8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599060; cv=none; b=qZvnEdsRZC/WQyaTFemEUoz3XqaNP5znmnCvVIY3gh2d5Qpa4r98Zfkgfyri0p7HVLihIN8CIzfvqGvE3fKSd5lw0yNua6qV1nBlMsrnLwUHUhNaYNjFp2rLzoRL/yel3f9BwhcAQdIsDsmyIdfZVg3Zwd8RO58e24Z7F6mdCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599060; c=relaxed/simple;
	bh=EVQhz28HZUN188e0eL+Dyc0cihFu/SgKCWEgr94uD6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7/WkE8m+pOSe2GiTgrBMFw5WGADz6onVCl+a2scaI7V3+a1qn80wIbOY4njJvJI+KEGbG4gcOV2iWFYlmD5kfn2sis9n6OdtR7rA9tVNcDMd9l/hGdwMttdef/F0fvPz5ywLDbk92UjYeYy6zItUkmBmLWdoEV+RhC3PXNkTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0p5hm1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3786CC433C7;
	Thu, 22 Feb 2024 10:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708599059;
	bh=EVQhz28HZUN188e0eL+Dyc0cihFu/SgKCWEgr94uD6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0p5hm1lD1ToRpGsDkIWAaGWCkl7OvuZ7r8FZJv737CbeBogXUWcxkkyBz3d3Vuy/
	 QouUxOn9Zd7RxOAr6AP1ZGs6OC92qbF+QFFI4LPmkabsmMbbqSI6JvcwoAnpdsaTuk
	 PB9hwv30pzs0rhSq7QDE0RE29CSPUotchDQTHQYPxZaBXp8fcR8jk8DiyKycUjobrN
	 ueIA0FWPaIh+Gum7noWDYHFnSbI6IQPO7jF5n+sRC5EmDy0ng8WxiU7iHp8ljGKUTm
	 kQZKVn9TV8QbTFB9NNZT71/QsGK5m8eE5dx+V+nmtHdkTDmS0tiwXt0RAwOV1pd04c
	 qU+C8q75eY8dA==
Date: Thu, 22 Feb 2024 11:50:56 +0100
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
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v11b 18/20] timers: Implement the hierarchical pull model
Message-ID: <ZdcnEGQK0VO39QT+@lothringen>
References: <20240221090548.36600-19-anna-maria@linutronix.de>
 <20240222103710.32582-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222103710.32582-1-anna-maria@linutronix.de>

On Thu, Feb 22, 2024 at 11:37:10AM +0100, Anna-Maria Behnsen wrote:
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
> +	curstate.state = atomic_read_acquire(&group->migr_state);
> +	childstate.state = 0;
> +
> +	for (;;) {
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
> +		if (atomic_try_cmpxchg(&group->migr_state, &curstate.state,
> +				       newstate.state))
> +			break;
> +		/*
> +		 * Add memory barrier to make sure child and group states order
> +		 * of read is preserved. This barrier is only required when
> +		 * atomic_try_cmpxchg() failed.
> +		 */
> +		smp_mb__after_atomic();

Ideally memory barrier comments should tell:

1) What it orders (you did)
2) What it pairs with (the acquire)

And also the acquire barrier should be commented as well accordingly. This all
of course can be done in a further patch (I might lose track beyond 11c)

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

