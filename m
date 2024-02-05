Return-Path: <linux-kernel+bounces-53918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D0B84A802
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEB81C27918
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3DA134CF0;
	Mon,  5 Feb 2024 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiKrwrLE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE3134CFA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707165005; cv=none; b=QMwDfklegbYE+mhuExeLT96ovdaWgPBoQ0WP7h7NBxAwlSNoflFnCK5NJVSESERX6sSiwWXsDI+dj0Eat+azy0nNSCGb599eyEH+fmttvooaAkYzp03GCrKwSG6a9M1+6BOyxVSWYRvA0He4oJ2vkWSJdbVr5gjgVvdTCAMmd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707165005; c=relaxed/simple;
	bh=07agzmr6NqNZglfhH/E1LwthUvc6l8GOAhAuKPHzoi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+2TZSJuKFtrhasMJhX9idk6DWpN1CRTXjc/06HnM/xSzKWBDLjqzgOPrcc1h7DvZIHH4/EIEcJ0z7dDyzrAwk7Sb5toqZy4Cj3igItf69Q7y/E2YJGIIh824nRB/NjhFjoqUSxgEWgF3TDRog+C7bc9UqlAKZPbQB96UlXjCAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiKrwrLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02ECC433F1;
	Mon,  5 Feb 2024 20:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707165005;
	bh=07agzmr6NqNZglfhH/E1LwthUvc6l8GOAhAuKPHzoi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HiKrwrLE5Ue6s/XaevZHXak9dRGV7UIBpzYEC+eL+15Ue/BotHAsbHTP2oI8CQym3
	 G42gvfa9L5oochT9qYdXom2aVKhx9bMnXKVGzLMpj1e/1h8Ba9sqt9Rpcaz3pI7zcT
	 55kQwRKKYTUePa6qZFh143Nxu8VJ1zbkiJaDi1WViU3VV9NUfLPhVgPC3RLDuYUFBj
	 OIJ7jsJQwMRCzPvL1BtXZedgS6xcndlzmPQFvPme9oT2dNHEgv3GNYpvzj6yKmVV5z
	 xAY3HcukX+xLXSSo84TAgeETsIOEsPqQD6q/0oAbSHQHqJnW919p5YshnKM0yFJXE5
	 +Z005qF6yq9jg==
Date: Mon, 5 Feb 2024 21:30:02 +0100
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
Message-ID: <ZcFFSgjcDcuz7Swv@pavilion.home>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZbuzMeKlCgebhJZ-@localhost.localdomain>
 <87bk90i2ja.fsf@somnus>
 <ZbvYJysR7gnaQiNg@localhost.localdomain>
 <87y1c3lxec.fsf@somnus>
 <87y1bzqbsx.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y1bzqbsx.fsf@somnus>

Le Mon, Feb 05, 2024 at 02:29:34PM +0100, Anna-Maria Behnsen a écrit :
> Anna-Maria Behnsen <anna-maria@linutronix.de> writes:
> 
> > Frederic Weisbecker <frederic@kernel.org> writes:
> >
> >> Le Thu, Feb 01, 2024 at 05:15:37PM +0100, Anna-Maria Behnsen a écrit :
> >>> Frederic Weisbecker <frederic@kernel.org> writes:
> >>> 
> >>> > Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a écrit :
> >>> > Heh, I was about to say that it's impossible that timer_base_is_idle()
> >>> > at this stage but actually if we run in nohz_full...
> >>> >
> >>> > It happens so that nohz_full is deactivated until rcutree_online_cpu()
> >>> > which calls tick_dep_clear() but it's a pure coincidence that might
> >>> > disappear one day. So yes, let's keep it that way.
> >>> 
> >>> I instrumented the code (with NOHZ FULL and NOHZ_IDLE) to make sure the
> >>> timer migration hierarchy state 'idle' is in sync with the timer base
> >>> 'idle'. And this was one part where it was possible that it runs out of
> >>> sync as I remember correctly. But if I understood you correctly, this
> >>> shouldn't happen at the moment?
> >>
> >> Well, it's not supposed to :-)
> >
> > Hmm, let me double check this and run the tests on the instrumented
> > version...
> 
> I added a prinkt() to verify what I think I remember. I was able to see
> the prints. So it seems, that the coincidence that nohz_full is
> deactivated until rcutree_online_cpu() already disappeared.

Nice, then I guess it can become a WARN_ON.

Thanks.

> 
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -1672,6 +1672,8 @@ static int tmigr_cpu_online(unsigned int
>  	tmc->idle = timer_base_is_idle();
>  	if (!tmc->idle)
>  		__tmigr_cpu_activate(tmc);
> +	else
> +		printk("TIMER BASE IS IDLE\n");
>  	tmc->online = true;
>  	raw_spin_unlock_irq(&tmc->lock);
>  	return 0;
> 
> Thanks,
> 
>         Anna-Maria
> 

