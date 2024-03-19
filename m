Return-Path: <linux-kernel+bounces-108156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172C78806C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487C71C2225B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E091D405CC;
	Tue, 19 Mar 2024 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuBgZmDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18121405FF;
	Tue, 19 Mar 2024 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883979; cv=none; b=aJqAX7/u5kGNz03YljcwC6sniTqRwHThI7rrxUPmr1mR/WbqjBtpy6twkTJR1FgicFjGwnuGBYGRWlRagWZUH7X0k8bG2E3qj5PARTvdEHBC1kCgJ0OXffKEkts2nag1s+85XbcConBXDz2kRrofCAa1woTFO1EZkAbyTm2hako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883979; c=relaxed/simple;
	bh=Z0VLowaW1cMKEukbDvZbKOTvPsbt5jpTUoOXaf3vRa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeFYnl9hI5vr0feYNJydO2bFJN77EVFyuV+Orv7+9AbGQPPWwlhQ4YHtefj0jDpOJ4c0dyGtoBB0GzaLAhezmFISLUxn3veZTr8h1gDnND1yW3m8uuSLRuexeK5WbzFmVv8ytvBjx1cmmdEyIQd7M69jNZWyU/MLhtKWaRCp/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuBgZmDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C8AC433F1;
	Tue, 19 Mar 2024 21:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710883978;
	bh=Z0VLowaW1cMKEukbDvZbKOTvPsbt5jpTUoOXaf3vRa0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AuBgZmDGLT6z0xuFCkeF0czQP2q9f5XlukF8labTvW6pmjWe5rff92CzWtGRZhGck
	 P8T0RLcmANKwLqelJX4KLiZsMcC8WIOLpfNrQGhB/gFdHEP9pmttLMuVwZ/HmPV1QX
	 QAA0kTbyRrsT8y9Cg6xm6igbtkg5o5UqfFzpsVkXOWvyIcQ7MkyyuKvzJhONQHqFRc
	 1vWStuF2pPEOwavmy1lyxUsnlYkmXZjHg41pHoyiE5m/FYMAOa05kwMM5C32VR0RnD
	 3S7227aFhwDvXBckZnvxydf0MmDCCSzwZgmKOttEomrGbJnK0H6+bwI0XKPHgHWhBo
	 Y9pkrycapFwtQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AE739CE16D7; Tue, 19 Mar 2024 14:32:56 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:32:56 -0700
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
Subject: Re: [PATCH v5 net 3/3] bpf: report RCU QS in cpumap kthread
Message-ID: <ea38b306-c5d3-461e-9920-9e3b0bc9951d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1710877680.git.yan@cloudflare.com>
 <c17b9f1517e19d813da3ede5ed33ee18496bb5d8.1710877680.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c17b9f1517e19d813da3ede5ed33ee18496bb5d8.1710877680.git.yan@cloudflare.com>

On Tue, Mar 19, 2024 at 01:44:40PM -0700, Yan Zhai wrote:
> When there are heavy load, cpumap kernel threads can be busy polling
> packets from redirect queues and block out RCU tasks from reaching
> quiescent states. It is insufficient to just call cond_resched() in such
> context. Periodically raise a consolidated RCU QS before cond_resched
> fixes the problem.
> 
> Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/bpf/cpumap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 9ee8da477465..a8e34416e960 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -263,6 +263,7 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
>  static int cpu_map_kthread_run(void *data)
>  {
>  	struct bpf_cpu_map_entry *rcpu = data;
> +	unsigned long last_qs = jiffies;
>  
>  	complete(&rcpu->kthread_running);
>  	set_current_state(TASK_INTERRUPTIBLE);
> @@ -288,10 +289,12 @@ static int cpu_map_kthread_run(void *data)
>  			if (__ptr_ring_empty(rcpu->queue)) {
>  				schedule();
>  				sched = 1;
> +				last_qs = jiffies;
>  			} else {
>  				__set_current_state(TASK_RUNNING);
>  			}
>  		} else {
> +			rcu_softirq_qs_periodic(last_qs);
>  			sched = cond_resched();
>  		}
>  
> -- 
> 2.30.2
> 
> 

