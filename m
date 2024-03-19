Return-Path: <linux-kernel+bounces-108177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8454A880721
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62EC1C21011
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11E551C5B;
	Tue, 19 Mar 2024 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjNvqjWu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9B101D4;
	Tue, 19 Mar 2024 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710886103; cv=none; b=MkH+XCXF3Sbv+dcMXFqYsvkRt3ItPjAN+a0Yi/cn+3zpnTORXMBVriu2hcrwIf0gbgY0bkZ5M7V7ltlcQv8aZW19gQYkrJXCPbIcW1+VJM3rDE/sP9KJAd/9RNwKjhIFrfW+QyraWYItKAZNJxKUX0b1EqDhHzWBciIT6ahgI/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710886103; c=relaxed/simple;
	bh=WcCaSmpe1k7crBhFeryrbsZ45VTv5HnczafsdmzvbAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE4+2budFzj4XWw3vLyZmWOYlwL8yR4KBlJqnOFqdD3/tFYkwNnli3c3TSjUWj8TJk08/n8PX1a2b/hTT12GQLuRkBthaupIgZoAuVGAIjhlGeC9/O/MBTh/5f3ng5cmPcrfgkcTqInUQte7PemEExCczN3UhS4htY5TklxF7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjNvqjWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3622FC433C7;
	Tue, 19 Mar 2024 22:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710886102;
	bh=WcCaSmpe1k7crBhFeryrbsZ45VTv5HnczafsdmzvbAc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pjNvqjWu7SS1lVhwfopRltqQj2f2HQwzEpTwOzD/by69cdGPVzBWtYZ9zRVLlPLwo
	 KBcwTfy2Csatl/iTFZR8GuqQVhlFfEvyXkLPmEXmu+8olSgr+54GNGpWqZpXS+DtIy
	 FkVuAX2fEyAflnXW8s/zgI+CBoKbbQd4+zD1289I47d9NIoZ93DwvLf6RQYIOqzcP8
	 S2erPo8Ui55ejoLYfP6PoqnjPlrBXQcMyqqSUGzTdJ4igufxDNYtGZt7ERkGLCRZBB
	 E8kZ/TkCXfYTI25BiRCd8IpWGtvAq0eDjxl4mLIYf0SY9tjfI2a4bfkLkdIv6UH0k9
	 fCKlpbs77LjQQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5159ECE16D7; Tue, 19 Mar 2024 15:08:19 -0700 (PDT)
Date: Tue, 19 Mar 2024 15:08:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v5 net 1/3] rcu: add a helper to report consolidated
 flavor QS
Message-ID: <7d86bfd6-353f-425b-ab69-ae5e3309f5bb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1710877680.git.yan@cloudflare.com>
 <90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com>
 <6149ecfc-2a3b-4bea-a79f-ef5be0a36cd7@paulmck-laptop>
 <CAO3-PbotP8pRFRC4jX+qgPjmVkRJCfSPGD3ipxa8+ph7vGVr6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3-PbotP8pRFRC4jX+qgPjmVkRJCfSPGD3ipxa8+ph7vGVr6g@mail.gmail.com>

On Tue, Mar 19, 2024 at 05:00:24PM -0500, Yan Zhai wrote:
> Hi Paul,
> 
> On Tue, Mar 19, 2024 at 4:31 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Mar 19, 2024 at 01:44:34PM -0700, Yan Zhai wrote:
> > > When under heavy load, network processing can run CPU-bound for many
> > > tens of seconds. Even in preemptible kernels (non-RT kernel), this can
> > > block RCU Tasks grace periods, which can cause trace-event removal to
> > > take more than a minute, which is unacceptably long.
> > >
> > > This commit therefore creates a new helper function that passes through
> > > both RCU and RCU-Tasks quiescent states every 100 milliseconds. This
> > > hard-coded value suffices for current workloads.
> > >
> > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> >
> > If you would like me to take this one via -rcu, I would be happy to take
> > it.  If it would be easier for you to push these as a group though
> > networking:
> >
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Since the whole series aims at fixing net problems, going through net
> is probably more consistent.

Very good!  I will let you push it along.

> Also, thank you for your help through the series!

No, thank you!  I had just been asked to find this slowdown when you
posted the patch.  So it worked out extremely well for me!  ;-)

							Thanx, Paul

> Yan
> 
> > > ---
> > > v4->v5: adjusted kernel docs and commit message
> > > v3->v4: kernel docs error
> > >
> > > ---
> > >  include/linux/rcupdate.h | 31 +++++++++++++++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> > >
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 16f519914415..17d7ed5f3ae6 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -247,6 +247,37 @@ do { \
> > >       cond_resched(); \
> > >  } while (0)
> > >
> > > +/**
> > > + * rcu_softirq_qs_periodic - Report RCU and RCU-Tasks quiescent states
> > > + * @old_ts: jiffies at start of processing.
> > > + *
> > > + * This helper is for long-running softirq handlers, such as NAPI threads in
> > > + * networking. The caller should initialize the variable passed in as @old_ts
> > > + * at the beginning of the softirq handler. When invoked frequently, this macro
> > > + * will invoke rcu_softirq_qs() every 100 milliseconds thereafter, which will
> > > + * provide both RCU and RCU-Tasks quiescent states. Note that this macro
> > > + * modifies its old_ts argument.
> > > + *
> > > + * Because regions of code that have disabled softirq act as RCU read-side
> > > + * critical sections, this macro should be invoked with softirq (and
> > > + * preemption) enabled.
> > > + *
> > > + * The macro is not needed when CONFIG_PREEMPT_RT is defined. RT kernels would
> > > + * have more chance to invoke schedule() calls and provide necessary quiescent
> > > + * states. As a contrast, calling cond_resched() only won't achieve the same
> > > + * effect because cond_resched() does not provide RCU-Tasks quiescent states.
> > > + */
> > > +#define rcu_softirq_qs_periodic(old_ts) \
> > > +do { \
> > > +     if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
> > > +         time_after(jiffies, (old_ts) + HZ / 10)) { \
> > > +             preempt_disable(); \
> > > +             rcu_softirq_qs(); \
> > > +             preempt_enable(); \
> > > +             (old_ts) = jiffies; \
> > > +     } \
> > > +} while (0)
> > > +
> > >  /*
> > >   * Infrastructure to implement the synchronize_() primitives in
> > >   * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
> > > --
> > > 2.30.2
> > >
> > >

