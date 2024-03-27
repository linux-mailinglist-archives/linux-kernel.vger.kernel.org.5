Return-Path: <linux-kernel+bounces-121298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3238588E792
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1572CB27CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0CA146D7B;
	Wed, 27 Mar 2024 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geDSCJnN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F4146D64
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543345; cv=none; b=OywzTR4LAxqH4PmiT4Dz1xdJ3hQDpsVoqhOh07Su/4+ZEaJMYYTm5xIKKeGRXpI75QIWWg6kl7XmUtiUfFqFPtUTrigi8jQp9KEa+0ASlW0j9PLZAAwpPlIWqX7K/KLgWYJEdt8UnMZyKGrOLElvz70W/4xzb9sgdEzdZrFbGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543345; c=relaxed/simple;
	bh=fIUWXJRrxbtYXLlSLOpvxXJLHkM+ks7iBm6J3zBbb3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW3qCNTZNo634tUUu0MRidyvZ9pwH88bvrEAxSmwYZQ5p5j7Le2E+zz5PUnNVCw79G4pNOC6LgYo0t5NwqaCAMNLia5tEtLWMvgzBP65jfBfs0eHxgs15cKtK7iQez4RgtH31Qd83X7Cb+jqyw+iTGxvRgmszRI2yuSp9wLYFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geDSCJnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804BEC433C7;
	Wed, 27 Mar 2024 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711543345;
	bh=fIUWXJRrxbtYXLlSLOpvxXJLHkM+ks7iBm6J3zBbb3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geDSCJnNZPAPoorLnoR/kJHCntkR91w2/ZmB+UdHCYY2jMce7bYFtuhaoQYpDj5ha
	 UfhU5VefCdAdiipbGWDmfAGmHv9fdZPj8vJsVbKzJ9NLP/OTgTzXUiki/PJH+BR5L7
	 edOf4S8w0PfQ3deJSVcztt3zytaN32fKVr8Pir+wwN98qBtkqcxpH5pHF2KlcKMlv2
	 5cZYZyIUP7aIo+qtKKsqXIsLLBkaz/1iQBRyxqYPW8A6o5XGU+UYSTrCvTkpHoENld
	 QPihyCh3ERFG3qw+U5js0R2Bh6jlNAu+23UV2fYy9My+6U7Dnl2s+mUZm/TGIGswTk
	 3DwTwymT8Sa4Q==
Date: Wed, 27 Mar 2024 13:42:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Alex Shi <alexs@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: for_each_domain()/sched_domain_span() has offline CPUs (was Re:
 [PATCH 2/2] timers: Fix removed self-IPI on global timer's enqueue in
 nohz_full)
Message-ID: <ZgQULtxy0UnoXfGi@localhost.localdomain>
References: <20240318230729.15497-3-frederic@kernel.org>
 <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
 <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
 <Zf1sSv/6mQHJuJ8G@lothringen>
 <Zf2GDjekyemQKn7I@lothringen>
 <xhsmhwmppaqls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhwmppaqls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Tue, Mar 26, 2024 at 05:46:07PM +0100, Valentin Schneider a écrit :
> > Then with that patch I ran TREE07, just some short iterations:
> >
> > tools/testing/selftests/rcutorture/bin/kvm.sh --configs "10*TREE07" --allcpus --bootargs "rcutorture.onoff_interval=200" --duration 2
> >
> > And the warning triggers very quickly. At least since v6.3 but maybe since
> > earlier. Is this expected behaviour or am I right to assume that
> > for_each_domain()/sched_domain_span() shouldn't return an offline CPU?
> >
> 
> I would very much assume an offline CPU shouldn't show up in a
> sched_domain_span().
> 
> Now, on top of the above, there's one more thing worth noting:
>   cpu_up_down_serialize_trainwrecks()
> 
> This just flushes the cpuset work, so after that the sched_domain topology
> should be sane. However I see it's invoked at the tail end of _cpu_down(),
> IOW /after/ takedown_cpu() has run, which sounds too late. The comments
> around this vs. lock ordering aren't very reassuring however, so I need to
> look into this more.

Ouch...

> 
> Maybe as a "quick" test to see if this is the right culprit, you could try
> that with CONFIG_CPUSET=n? Because in that case the sched_domain update is
> ran within sched_cpu_deactivate().

I just tried and I fear that doesn't help. It still triggers even without
cpusets :-s

Thanks.

