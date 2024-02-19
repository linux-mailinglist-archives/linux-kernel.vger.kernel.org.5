Return-Path: <linux-kernel+bounces-71636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5D985A81C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2CD282E82
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF773B18D;
	Mon, 19 Feb 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7kcpoHl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE73308A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358701; cv=none; b=R9GiNHEd5NinyZY901VzvGCbpaq/KDCMIlP2goXg4jZCBa2aerLSZt0mpK9B1VhafxVGHMxtlM3ekbQkanpSoFnVSkOhstFmGVysJkuBDDhjd7TqNQHKpLbfs9J05yQDjux4gZOPMgKp7+GcZp7s0ngRchrEYvQDlAulVQ2tY5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358701; c=relaxed/simple;
	bh=QSQhFzqyHvdSBslDmpugOpRWw2G2U/ioWUEnLCdRQaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2BuZZylYL08JuTRUSHJZsMJrTThN4rDCJ8kayPbRN6fpq6vaXJlsRnwoVLpthQBjGVN1w2szwpo45fxLFqJNTOK6vo8NwGAal6LdZbJOZQarV7yuBb37y0rlCFcmZvbRmvcy4wVxZ+fF84T2I4h50ffgzp7PsJ1Qfo5XvtiXOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7kcpoHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47C0C433C7;
	Mon, 19 Feb 2024 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708358701;
	bh=QSQhFzqyHvdSBslDmpugOpRWw2G2U/ioWUEnLCdRQaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q7kcpoHlgsbbngSSNe5KCyP4JbREt2a3SmvVj1ufDyge68StNJNRgRIjEjZjhPXTq
	 37dCRdT+LKBsXXTPus9E8Vgi0LAmdbCBnl4GbP2JtjDuSmtL8Nfn30V5WtoHqeV2wM
	 E3DVSWYnjKUp0FEv8Bppk+Xg38ZIFbgZuvVcNDkXn8JjeKTgUFymz5VeGlbjO7C4Qi
	 50cIyf+0J4n40e2Tu/JsM6HECwDXcI/ZeJJRGKos8C5lAJqyYYWe6MsEgsRW7ScJWm
	 Ypfq+motK7Q1itoStAtmX8qEV/CcM7VbcF1hHPzyJbz4fYmwK0MirmlaHBfdhSjVlx
	 31f+rM/ReYgZg==
Date: Mon, 19 Feb 2024 17:04:56 +0100
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
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v10 13/20] timers: Add get next timer interrupt
 functionality for remote CPUs
Message-ID: <ZdN8KCTB2smSZb88@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-14-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-14-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:36PM +0100, Anna-Maria Behnsen a écrit :
> +# ifdef CONFIG_SMP
> +/**
> + * fetch_next_timer_interrupt_remote() - Store next timers into @tevt
> + * @basej:	base time jiffies
> + * @basem:	base time clock monotonic
> + * @tevt:	Pointer to the storage for the expiry values
> + * @cpu:	Remote CPU
> + *
> + * Stores the next pending local and global timer expiry values in the
> + * struct pointed to by @tevt. If a queue is empty the corresponding
> + * field is set to KTIME_MAX. If local event expires before global
> + * event, global event is set to KTIME_MAX as well.
> + *
> + * Caller needs to make sure timer base locks are held (use
> + * timer_lock_remote_bases() for this purpose).
> + */
> +void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
> +				       struct timer_events *tevt,
> +				       unsigned int cpu)
> +{
> +	struct timer_base *base_local, *base_global;
> +
> +	/* Preset local / global events */
> +	tevt->local = tevt->global = KTIME_MAX;
> +
> +	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
> +	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
> +
> +	lockdep_assert_held(&base_local->lock);
> +	lockdep_assert_held(&base_global->lock);
> +
> +	fetch_next_timer_interrupt(basej, basem, base_local, base_global, tevt);

If the next timer is global and it is <= jiffies + 1, the result will be
returned in tevt.local only and not on tevt.global. So a remote fetch may miss it.

For this to work on both local and remote fetch, you may need:

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 320eb4ceafa2..64ce9a7760f5 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2004,6 +2007,8 @@ static unsigned long fetch_next_timer_interrupt(unsigned long basej, u64 basem,
 		if (time_before(nextevt, basej))
 			nextevt = basej;
 		tevt->local = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		if (!local_first)
+			tevt->global = tevt->local;
 		return nextevt;
 	}
 

