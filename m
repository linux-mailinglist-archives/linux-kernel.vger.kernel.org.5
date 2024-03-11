Return-Path: <linux-kernel+bounces-99676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4873D878BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EB31F21BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90A65917D;
	Mon, 11 Mar 2024 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCpIijKg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADBA58AAC;
	Mon, 11 Mar 2024 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201339; cv=none; b=u7w10IYzYefBFNJXeK+Y93aLlUyztrY4nSU8jNvepm0MyoKY5t67q2vKI3NfK/+RPfTo99P/ESBkMtCyIGoOX3oZS+VjZxdqzcTUZskCZHqxzds+pDtygvneuOJub1Ip7fZl/FN0oB0e5V27FE+J4AZ+Qx2nDfMN8hIrTLiW0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201339; c=relaxed/simple;
	bh=BuwxzEM/Bxcww15ApUyz1+fwftuGUlKv1u90MSb2jyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ro3PQcBDB4r/Q15JMucJo/1L+dzMLnX/ExTBf+DF8g41brGlK8zNyVQqxBEfK9j3ae1kPNP7uAF6Ztih4o994XfQOK8nSTqUhzpUKHIPlUD/wxhwkHpe6fZiIqUdVFTkTCakm0AQTbiPRG44CFh3Eu9C3xycqXPVXER4r8awfG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCpIijKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1F9C433F1;
	Mon, 11 Mar 2024 23:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710201338;
	bh=BuwxzEM/Bxcww15ApUyz1+fwftuGUlKv1u90MSb2jyc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RCpIijKgQgoTSA/YgO5HGnRv3Hf9/Bg6Rr/EDvLtzPQgyI+KITZQdfzApLBYH/2PR
	 s+tHpIkNnd8px5/X+EeLzzDUEUxl4H6mHKD7AvraOplbNr9dli6MZME3EdEtvGdXmW
	 pYgwXcM/XGtMTZLpBDr1vnz9eKE2woypzmXew2bH20+gC0+Ppn9o7pbtmBsRmcFH9m
	 loWPfwQV4KR5r0ugMkELBAZyXvtHC01/1dYPOrTKg+8ho4iv3F+9jgD25U1TOI/DHW
	 /G2XFIzJ6EOA4Z8DOgLJP87E7bD9F/NFCdNPVlq5ocwS+QZGfqhDQkih2/FSDmDMwq
	 k0zzq9tzTDy1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0244FCE1A25; Mon, 11 Mar 2024 16:55:37 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:55:37 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Brouer <jesper@cloudflare.com>
Subject: Re: [PATCH v2] net: raise RCU qs after each threaded NAPI poll
Message-ID: <aa4909dd-98f2-4185-833d-666c640786c6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZeFPz4D121TgvCje@debian.debian>
 <CAO3-PboqKqjqrAScqzu6aB8d+fOq97_Wuz8b7d5uoMKT-+-WvQ@mail.gmail.com>
 <CANn89iLCv0f3vBYt8W+_ZDuNeOY1jDLDBfMbOj7Hzi8s0xQCZA@mail.gmail.com>
 <CAO3-PboZwTiSmVxVFFfAm94o+LgK=rnm1vbJvMhzSGep+RYzaQ@mail.gmail.com>
 <ed57b5fa-8b44-48de-904e-fe8da1939292@paulmck-laptop>
 <CAO3-Pbp0Pxbbgmjf03wKo6MDrQYE7uiL+mUnheT9UA9Pjj5bUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3-Pbp0Pxbbgmjf03wKo6MDrQYE7uiL+mUnheT9UA9Pjj5bUQ@mail.gmail.com>

On Mon, Mar 11, 2024 at 05:58:16PM -0500, Yan Zhai wrote:
> On Fri, Mar 1, 2024 at 4:29 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Mar 01, 2024 at 11:30:29AM -0600, Yan Zhai wrote:
> > > Hi Eric,
> > >
> > > On Fri, Mar 1, 2024 at 2:30 AM Eric Dumazet <edumazet@google.com> wrote:
> > > >
> > > > I could not see the reason for 1sec (HZ) delays.
> > > >
> > > > Would calling rcu_softirq_qs() every ~10ms instead be a serious issue ?
> > > >
> > > The trouble scenarios are often when we need to detach an ad-hoc BPF
> > > tracing program, or restart a monitoring service. It is fine as long
> > > as they do not block for 10+ seconds or even completely stall under
> > > heavy traffic. Raising a QS every few ms or HZ both work in such
> > > cases.
> > >
> > > > In anycase, if this all about rcu_tasks, I would prefer using a macro
> > > > defined in kernel/rcu/tasks.h
> > > > instead of having a hidden constant in a networking core function.
> > >
> > > Paul E. McKenney was suggesting either current form or
> > >
> > >          local_bh_enable();
> > >          if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > >                  rcu_softirq_qs_enable(local_bh_enable());
> > >          else
> > >                  local_bh_enable();
> > >
> > > With an interval it might have to be
> > > "rcu_softirq_qs_enable(local_bh_enable(), &next_qs);" to avoid an
> > > unnecessary extern/static var. Will it make more sense to you?
> >
> > I was thinking in terms of something like this (untested):
> >
> >         #define rcu_softirq_qs_enable(enable_stmt, oldj) \
> >         do { \
> >                 if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
> >                     time_after(oldj + HZ / 10, jiffies) { \
> >                         rcu_softirq_qs(); \
> >                         (oldj) = jiffies; \
> >                 } \
> >                 do  { enable_stmt; } while (0) \
> >         } while (0)
> >
> > Then the call could be "rcu_softirq_qs_enable(local_bh_enable(), last_qs)",
> > where last_qs is initialized by the caller to jiffies.
> >
> > The reason for putting "enable_stmt;" into anothor do-while loop is
> > in case someone typos an "else" as the first part of the "enable_stmt"
> > argument.
> >
> > Would that work?
> >
> Thanks Paul, just got time to continue this thread as I was
> travelling. I think it is probably better to move
> preempt_disable/enable into the macro to avoid the friction. And also
> since this can affect NAPI thread, NAPI busy loop and XDP cpu map
> thread (+Jesper who reminded me about this), let me send a v3 later to
> cover all of those places.

OK, looking forward to seeing what you come up with.

							Thanx, Paul

