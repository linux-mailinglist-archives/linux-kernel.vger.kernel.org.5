Return-Path: <linux-kernel+bounces-111367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D04886B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F10B21464
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06F63FB04;
	Fri, 22 Mar 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIaW3AN1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D853C3F9E8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107150; cv=none; b=g1T2qLnUfLC1PZUrMkkRfa3xqwlXXxReKc3bXpsGoeeL3tv79BdVEO3+8GL80WGCKwIF7gid2L55UfdXSM+Ij4FNFoZL0xRR8kz1sYUFU7CbfX7N458sL7Kr2uAfqfVSTk231oNJOqBvKbhZ0kgwg1QBRHLIsuH9Ouk7f35BUZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107150; c=relaxed/simple;
	bh=k6zj8z9Rrp81UsD4Gh99VLU0ZbSsNvTIc9e+d/fvotE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzQZSaQ7lywOTtQl7MHIAykPBijhf2ImYMkJD5yVSLz35MjmEfbtBHfiXDpm5pVtd7F8IdIS7mqYjvnqTihmRijOK5aJPGPpnknXSh/20jRTG5U6O0UG0mw5isd90sxiRkDKDcF55pKzNEp6ALfuFSIi/FdemyE+5xapgNEoxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIaW3AN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5811C433F1;
	Fri, 22 Mar 2024 11:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711107150;
	bh=k6zj8z9Rrp81UsD4Gh99VLU0ZbSsNvTIc9e+d/fvotE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BIaW3AN1tmz44SXKZXvVUG3faepTjy2MFXOHyIUUGaz3AjWCVic6zCzukyUzk+/xA
	 CQ3L/jByEJz/7AVKxcP84QFyhuzVBLE+vYrmvm9teG+YJQ15o7wtQFxm2t4dIB+ez1
	 Pynw7G6OOQW6/wCb6QDSKlmDpnv77MdlD75HqH8QRB2HDfdmuIcFF4Jx/uv6ULwSsc
	 a2pVgnGt9SEYJYp4EBJF8IQwaSo6tzuvBfxSvNvIjmOOqa92iyLaUBLp8Qf+e9Bghi
	 YCnjy8KFZuFcPtBj81EmlXfTMWoOf7QnnRyiR1i6Q1OonFmBctA+GzjxWpY9a9L6Bz
	 XOzBFRF2t0ldg==
Date: Fri, 22 Mar 2024 12:32:26 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Alex Shi <alexs@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH 2/2] timers: Fix removed self-IPI on global timer's
 enqueue in nohz_full
Message-ID: <Zf1sSv/6mQHJuJ8G@lothringen>
References: <20240318230729.15497-1-frederic@kernel.org>
 <20240318230729.15497-3-frederic@kernel.org>
 <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
 <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>

On Thu, Mar 21, 2024 at 05:47:59AM -0700, Paul E. McKenney wrote:
> >   We should probably just remove this warning. This remote tick is my most horrible
> >   hackery anyway.
> 
> Would it make sense to increase it to somewhere around the timeout for
> RCU CPU stall warnings, softlockup, and so on?

We can also do that yes.

> 
> > _ The hrtimer enqueue to an offline CPU warning:
> > 
> > 	[ 1054.265335] WARNING: CPU: 8 PID: 150 at kernel/time/hrtimer.c:1091 enqueue_hrtimer+0x6f/0x80
> > 	[ 1054.269166] Modules linked in:
> > 	[ 1054.270077] CPU: 8 PID: 150 Comm: rcu_torture_rea Not tainted 6.8.0-11407-ge990136580ab-dirty #21
> > 	[ 1054.272768] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
> > 	[ 1054.275893] RIP: 0010:enqueue_hrtimer+0x6f/0x80
> > 	[ 1054.277252] Code: a3 05 b5 ff b7 01 73 bd 48 8b 05 44 c5 b5 01 48 85 c0 74 0c 48 8b 78 08 48 89 ee e8 7b b5 ff ff 48 8b 03 f6 40 10 10 75 a5 90 <0f> 0b 90 eb 9f 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
> > 	[ 1054.282448] RSP: 0000:ffffb1480056fd70 EFLAGS: 00010046
> > 	[ 1054.283931] RAX: ffff95b7df2616c0 RBX: ffff95b7df261700 RCX: ffff95b7df2616c0
> > 	[ 1054.286091] RDX: 0000000000000001 RSI: ffff95b7df261700 RDI: ffffb1480056fde0
> > 	[ 1054.288095] RBP: ffffb1480056fde0 R08: 0000000000000001 R09: 000000000000fc03
> > 	[ 1054.290189] R10: 0000000000000001 R11: ffff95b7c1271c80 R12: 0000000000000040
> > 	[ 1054.292592] R13: ffff95b7df261700 R14: ffff95b7df261700 R15: ffff95b7df2616c0
> > 	[ 1054.294622] FS:  0000000000000000(0000) GS:ffff95b7df400000(0000) knlGS:0000000000000000
> > 	[ 1054.296884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 	[ 1054.298497] CR2: 0000000000000000 CR3: 000000001822c000 CR4: 00000000000006f0
> > 	[ 1054.300475] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > 	[ 1054.302516] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > 	[ 1054.304580] Call Trace:
> > 	[ 1054.305354]  <TASK>
> > 	[ 1054.306009]  ? __warn+0x77/0x120
> > 	[ 1054.306973]  ? enqueue_hrtimer+0x6f/0x80
> > 	[ 1054.308177]  ? report_bug+0xf1/0x1d0
> > 	[ 1054.310200]  ? handle_bug+0x40/0x70
> > 	[ 1054.311252]  ? exc_invalid_op+0x13/0x70
> > 	[ 1054.312437]  ? asm_exc_invalid_op+0x16/0x20
> > 	[ 1054.313738]  ? enqueue_hrtimer+0x6f/0x80
> > 	[ 1054.314994]  hrtimer_start_range_ns+0x258/0x2f0
> > 	[ 1054.316531]  ? __pfx_rcu_torture_reader+0x10/0x10
> > 	[ 1054.317983]  schedule_hrtimeout_range_clock+0x95/0x120
> > 	[ 1054.319604]  ? __pfx_hrtimer_wakeup+0x10/0x10
> > 	[ 1054.320957]  torture_hrtimeout_ns+0x50/0x70
> > 	[ 1054.322211]  rcu_torture_reader+0x1be/0x280
> > 	[ 1054.323455]  ? __pfx_rcu_torture_timer+0x10/0x10
> > 	[ 1054.329888]  ? kthread+0xc4/0xf0
> > 	[ 1054.330880]  ? __pfx_rcu_torture_reader+0x10/0x10
> > 	[ 1054.332334]  kthread+0xc4/0xf0
> > 	[ 1054.333305]  ? __pfx_kthread+0x10/0x10
> > 	[ 1054.334466]  ret_from_fork+0x2b/0x40
> > 	[ 1054.335551]  ? __pfx_kthread+0x10/0x10
> > 	[ 1054.336690]  ret_from_fork_asm+0x1a/0x30
> > 	[ 1054.337878]  </TASK>
> > 
> >   I don't know how it happened. This is where I'm investigating now.
> 
> It seems that rcutorture is the gift that keeps on giving?  ;-)

Right. Also I just managed to reproduce that hrtimer issue on v6.8:

[ 1484.955213] WARNING: CPU: 6 PID: 162 at kernel/time/hrtimer.c:1088 enqueue_hrtimer+0x6f/0x80
[ 1484.962513] Modules linked in:
[ 1484.966476] CPU: 6 PID: 162 Comm: rcu_torture_rea Not tainted 6.8.0 #25
[ 1484.972975] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 1484.977653] RIP: 0010:enqueue_hrtimer+0x6f/0x80
[ 1484.978679] Code: a3 05 75 6a b7 01 73 bd 48 8b 05 e4 47 b5 01 48 85 c0 74 0c 48 8b 78 08 48 89 ee e8 eb bd ff ff 48 8b 03 f6 40 10 10 75 a5 90 <0f> 0b 90 eb 9f 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[ 1484.983136] RSP: 0000:ffffa553805cfd70 EFLAGS: 00010046
[ 1484.984386] RAX: ffff8c395f260440 RBX: ffff8c395f260480 RCX: ffff8c395f260440
[ 1484.986121] RDX: 0000000000000000 RSI: ffff8c395f260480 RDI: ffffa553805cfde0
[ 1484.987704] RBP: ffffa553805cfde0 R08: 0000000000000001 R09: 000000000000fc03
[ 1484.989513] R10: 0000000000000001 R11: ffff8c3941248e40 R12: 0000000000000040
[ 1484.991116] R13: ffff8c395f260480 R14: ffff8c395f260480 R15: ffff8c395f260440
[ 1484.992835] FS:  0000000000000000(0000) GS:ffff8c395f380000(0000) knlGS:0000000000000000
[ 1484.994683] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1484.995985] CR2: 0000000000000000 CR3: 000000001a62c000 CR4: 00000000000006f0
[ 1484.997789] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1484.999376] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1485.001177] Call Trace:
[ 1485.002388]  <TASK>
[ 1485.002923]  ? __warn+0x78/0x120
[ 1485.003641]  ? enqueue_hrtimer+0x6f/0x80
[ 1485.004641]  ? report_bug+0xf1/0x1d0
[ 1485.005537]  ? handle_bug+0x40/0x70
[ 1485.006318]  ? exc_invalid_op+0x13/0x70
[ 1485.007167]  ? asm_exc_invalid_op+0x16/0x20
[ 1485.008117]  ? enqueue_hrtimer+0x6f/0x80
[ 1485.009131]  hrtimer_start_range_ns+0x258/0x2f0
[ 1485.010153]  ? __pfx_rcu_torture_reader+0x10/0x10
[ 1485.011185]  schedule_hrtimeout_range_clock+0x96/0x120
[ 1485.012394]  ? __pfx_hrtimer_wakeup+0x10/0x10
[ 1485.013502]  stutter_wait+0x7f/0x90
[ 1485.014319]  rcu_torture_reader+0x10e/0x280
[ 1485.015240]  ? __pfx_rcu_torture_timer+0x10/0x10
[ 1485.016317]  ? kthread+0xc6/0xf0
[ 1485.017169]  ? __pfx_rcu_torture_reader+0x10/0x10
[ 1485.018215]  kthread+0xc6/0xf0
[ 1485.018899]  ? __pfx_kthread+0x10/0x10
[ 1485.019703]  ret_from_fork+0x2b/0x40
[ 1485.020546]  ? __pfx_kthread+0x10/0x10
[ 1485.021428]  ret_from_fork_asm+0x1b/0x30
[ 1485.022295]  </TASK>

This happens within the following loop

	for_each_domain(cpu, sd) {
		for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
			if (cpu == i)
				continue;

			if (!idle_cpu(i))
				return i;
		}
	}

An offline CPU is returned from there. Which is not supposed to happen
as it's within an RCU read side. But I can't manage to find where those
rq->sd things are modified when a CPU is offlining. The code path is hard
to follow. Adding some scheduler people involved in topology just in case.
Investigation continues...

Thanks.

