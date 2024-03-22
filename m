Return-Path: <linux-kernel+bounces-112036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E628887472
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827231C21DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528737FBDC;
	Fri, 22 Mar 2024 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmzxdeE2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840F81E53A;
	Fri, 22 Mar 2024 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711143060; cv=none; b=nzb34XmbTfo/1ipd/GTgkxpQ+FUrmCzreAmzgUxMUBIUgvtS79JkCFkU7kS+6rjs73Sumv+kUl9xqWWhSdNbXl7EooC4Dbzzz8Z+MXwkacY6p96UoGLN4SZBx2FH3mbldjz5UoCrCzeeHXVvnqRilC2f9EjEm1a2lr9hTpgQqxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711143060; c=relaxed/simple;
	bh=ECEO3PjP3QStSZLb8LE77MInaomRvbZCiEaNdgA8l2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3Kje5hgzTpdeaTLpdehnauOzmekFp374msH9VTlE1a7faCSfzkjgGlyxh840wl51YPjbFOCpqxBuPdl4Y/CPDqu+Eb8BUU4rJCHoomVjlzF/FvFRoEKN6M7/oX/JhOFryKcPsr5pOf2j/6pelFtxafl10h7zGUdQmd1rQ7kYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmzxdeE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A92C43390;
	Fri, 22 Mar 2024 21:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711143060;
	bh=ECEO3PjP3QStSZLb8LE77MInaomRvbZCiEaNdgA8l2M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WmzxdeE2HW1827vkrRyC/M2mxciIaLWNMBukRXveZutUoMVLwh40y+WXLWV5QLWrS
	 N/FuVAvJy74rD80I6YsZ+SA7ekThHUUKjUtrdNaULmKAvdzlTx89VUc9w/WzZTjB6P
	 ayGWnmSr+jQrbbuTe8UxhfCujK7ehaN+Tvc4P1dTTCkNjkrDxleqC7zZXbMN4/woxF
	 rcxwAfA1uo9ApZSbNo22+ThVQ1JCaO/LYIf2QSzQWnClGhcDXrvyiRZSu0DwC9Bg1V
	 N8fC6Lyxzh06UOKBX2OhQrlLT5moAV07lViGObdX9DpfsBx4EvDKMGkTNloxMXjqhV
	 VGpOMxgg14InQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 968DFCE04C1; Fri, 22 Mar 2024 14:30:59 -0700 (PDT)
Date: Fri, 22 Mar 2024 14:30:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH v5 net 1/3] rcu: add a helper to report consolidated
 flavor QS
Message-ID: <123ca494-dc8c-47cc-a6d5-3c529bc7f549@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1710877680.git.yan@cloudflare.com>
 <90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com>
 <20240322112413.1UZFdBq5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322112413.1UZFdBq5@linutronix.de>

On Fri, Mar 22, 2024 at 12:24:13PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-03-19 13:44:34 [-0700], Yan Zhai wrote:
> > index 16f519914415..17d7ed5f3ae6 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -247,6 +247,37 @@ do { \
> >  	cond_resched(); \
> >  } while (0)
> >  
> > +/**
> > + * rcu_softirq_qs_periodic - Report RCU and RCU-Tasks quiescent states
> > + * @old_ts: jiffies at start of processing.
> > + *
> > + * This helper is for long-running softirq handlers, such as NAPI threads in
> > + * networking. The caller should initialize the variable passed in as @old_ts
> > + * at the beginning of the softirq handler. When invoked frequently, this macro
> > + * will invoke rcu_softirq_qs() every 100 milliseconds thereafter, which will
> > + * provide both RCU and RCU-Tasks quiescent states. Note that this macro
> > + * modifies its old_ts argument.
> > + *
> > + * Because regions of code that have disabled softirq act as RCU read-side
> > + * critical sections, this macro should be invoked with softirq (and
> > + * preemption) enabled.
> > + *
> > + * The macro is not needed when CONFIG_PREEMPT_RT is defined. RT kernels would
> > + * have more chance to invoke schedule() calls and provide necessary quiescent
> > + * states. As a contrast, calling cond_resched() only won't achieve the same
> > + * effect because cond_resched() does not provide RCU-Tasks quiescent states.
> > + */
> 
> Paul, so CONFIG_PREEMPTION is affected but CONFIG_PREEMPT_RT is not.
> Why does RT have more scheduling points?

In RT, isn't BH-disabled code preemptible?  But yes, this would not help
RCU Tasks.

> The RCU-Tasks thread is starving and yet there is no wake-up, correct?
> Shouldn't cond_resched() take care of RCU-Tasks's needs, too?
> This function is used by napi_threaded_poll() which is not invoked in
> softirq it is a simple thread which does disable BH but this is it. Any
> pending softirqs are served before the cond_resched().
> 
> This napi_threaded_poll() case _basically_ a busy thread doing a lot of
> work and delaying RCU-Tasks as far as I understand. The same may happen
> to other busy-worker which have cond_resched() between works, such as
> the kworker. Therefore I would expect to have some kind of timeout at
> which point NEED_RESCHED is set so that cond_resched() can do its work.

A NEED_RESCHED with a cond_resched() would still be counted as a
preemption.  If we were intending to keep cond_resched(), I would
be thinking in terms of changing that, but only for Tasks RCU.

Given no cond_resched(), I would be thinking in terms of removing
the check for CONFIG_PREEMPT_RT.

Thoughts?

							Thanx, Paul

> > +#define rcu_softirq_qs_periodic(old_ts) \
> > +do { \
> > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
> > +	    time_after(jiffies, (old_ts) + HZ / 10)) { \
> > +		preempt_disable(); \
> > +		rcu_softirq_qs(); \
> > +		preempt_enable(); \
> > +		(old_ts) = jiffies; \
> > +	} \
> > +} while (0)
> > +
> >  /*
> >   * Infrastructure to implement the synchronize_() primitives in
> >   * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
> 
> Sebastian

