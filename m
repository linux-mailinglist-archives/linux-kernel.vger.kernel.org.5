Return-Path: <linux-kernel+bounces-123316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30633890671
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF88E29B7EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9DC3DABF0;
	Thu, 28 Mar 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7FmQspM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803BE374EF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645112; cv=none; b=uCXWyYiekDzLKV2+rhQjMMyTRmaSjstyn3Zt3UVG+3j8Zl8uzSILWnNtlYsfcVP4jejpYfEMRztbMvNClsUqBGjE8XTCQFuHuI+aAZu9fMySGoAHQtImFeljlAzfLEVtR8cE0TPRT+fd7bDMZkVvRwgrpkC5Ys+4T4V4Rqf+kEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645112; c=relaxed/simple;
	bh=KhPInAdx2nEJYM6yTKhhz/EBhNBtCggFtt2VVOVqMv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EraqajV3YOWg/613wXTp2ULvdnhhF1/PdAOO0rzlikmwPtfiHSy5sfWZqWriUPZ+u+H+Gw3i7GRnWV9QP5S8pA9aDMeDQCmgdFkEORRJhEpcoIHLa1FjNRlmCxsh+X5uTvL3OijqgklmvnTXQULmNeyvSRk5TgDt5T/MphdIAag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7FmQspM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DB9C433F1;
	Thu, 28 Mar 2024 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711645112;
	bh=KhPInAdx2nEJYM6yTKhhz/EBhNBtCggFtt2VVOVqMv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7FmQspM9lp+3HWGQh2hR/8dK0LWwbeYQxtgpXKYR7eYfuL95dhk/iRKe5lBpDb2F
	 MHlycOKA+V9nV8wjmWsx7jeFVFRt9fxqhcFp9MM3uKRHyqBuepTfDpXlmrQVlxhVG0
	 ERbXIqHhW/x66k/JeIyInMyc01FT4ohqhTGnqGl+YkoLQCxVuthn4y/gEL/vpieQvo
	 bS63AdHkii3cbRInAEm/X90B/tOoGoYlOkd78xmnk9un1lMIBkcoYN+SaDpCp4l9xa
	 WJf+T7DKk3V4pEcWVxPJoDL4IHtpsw/f3Pl0lB+d1s1o4Z9QPeK0NK3ZNLvvMoKICK
	 e4PA+W+9NCJJQ==
Date: Thu, 28 Mar 2024 17:58:29 +0100
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
Message-ID: <ZgWhteHzLb8Jutp3@localhost.localdomain>
References: <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
 <Zf1sSv/6mQHJuJ8G@lothringen>
 <Zf2GDjekyemQKn7I@lothringen>
 <xhsmhwmppaqls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZgQULtxy0UnoXfGi@localhost.localdomain>
 <xhsmhttkrbvfb.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <xhsmhr0fubgaf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhr0fubgaf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Thu, Mar 28, 2024 at 03:08:08PM +0100, Valentin Schneider a écrit :
> On 27/03/24 15:28, Valentin Schneider wrote:
> > On 27/03/24 13:42, Frederic Weisbecker wrote:
> >> Le Tue, Mar 26, 2024 at 05:46:07PM +0100, Valentin Schneider a écrit :
> >>> > Then with that patch I ran TREE07, just some short iterations:
> >>> >
> >>> > tools/testing/selftests/rcutorture/bin/kvm.sh --configs "10*TREE07" --allcpus --bootargs "rcutorture.onoff_interval=200" --duration 2
> >>> >
> >>> > And the warning triggers very quickly. At least since v6.3 but maybe since
> >>> > earlier. Is this expected behaviour or am I right to assume that
> >>> > for_each_domain()/sched_domain_span() shouldn't return an offline CPU?
> >>> >
> >>> 
> >>> I would very much assume an offline CPU shouldn't show up in a
> >>> sched_domain_span().
> >>> 
> >>> Now, on top of the above, there's one more thing worth noting:
> >>>   cpu_up_down_serialize_trainwrecks()
> >>> 
> >>> This just flushes the cpuset work, so after that the sched_domain topology
> >>> should be sane. However I see it's invoked at the tail end of _cpu_down(),
> >>> IOW /after/ takedown_cpu() has run, which sounds too late. The comments
> >>> around this vs. lock ordering aren't very reassuring however, so I need to
> >>> look into this more.
> >>
> >> Ouch...
> >>
> >>> 
> >>> Maybe as a "quick" test to see if this is the right culprit, you could try
> >>> that with CONFIG_CPUSET=n? Because in that case the sched_domain update is
> >>> ran within sched_cpu_deactivate().
> >>
> >> I just tried and I fear that doesn't help. It still triggers even without
> >> cpusets :-s
> >>
> >
> > What, you mean I can't always blame cgroups? What has the world come to?
> >
> > That's interesting, it means the deferred work item isn't the (only)
> > issue. I'll grab your test patch and try to reproduce on TREE07.
> >
> 
> Unfortunately I haven't been able to trigger your warning with ~20 runs of
> TREE07 & CONFIG_CPUSETS=n, however it does trigger reliably with
> CONFIG_CPUSETS=y, so I'm back to thinking the cpuset work is a likely
> culprit...

Funny, I just checked again and I can still reliably reproduce with:

/tools/testing/selftests/rcutorture/bin/kvm.sh --kconfig "CONFIG_CPUSETS=n CONFIG_PROC_PID_CPUSET=n" --configs "10*TREE07" --allcpus --bootargs "rcutorture.onoff_interval=200" --duration 2

I'm thinking there might be several culprits... ;-)

