Return-Path: <linux-kernel+bounces-108786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B710880FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C59CAB24AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597812D05C;
	Wed, 20 Mar 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol7/ItQM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFC51E48E;
	Wed, 20 Mar 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930628; cv=none; b=XRdzK1Ei13NYG3HaqFu5uw//kb/v2mlAoP5VoXmeZd6K1d2JSJSytqhnjssS9oAerYNK9ynqHpiYl7iP/BTmQKFz0b5jApfHBsk7KcFwCu2sS/SoPdV+nT1U25nBSYmPuc2LzqcMS/ZuxqVi22DQGaUKgOFVa6sr1gVwbMwfHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930628; c=relaxed/simple;
	bh=Ng5N4KT0SCm8Zb4mwGaTwyWKHKjaLEy2Wm0KyGEcEto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aykgGPaDT4JDYFTpikBAJurw3JalHSw43vsltg4eG46i4KpPnVFG5UP3yIGOe5MCWOa0Gsc0AGVfPNyzGEapA4xlbhjOPyHHf/5UKULFWTiYZFObyjs7wyF+3xKXVW7iY4Iw97YacsutKWL0o1TXwj07gIXd34nbjBXZ0x3azW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol7/ItQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920B6C433C7;
	Wed, 20 Mar 2024 10:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710930628;
	bh=Ng5N4KT0SCm8Zb4mwGaTwyWKHKjaLEy2Wm0KyGEcEto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ol7/ItQM72RsqGXTgcikxJy4dTlaUDho4Kqr5tT+d6X3xM8PArvo61vgr5a1KFSSu
	 QCjmG1YljRplfNm4JTZdB2xsYsks86a1/z/hL8c7Lsw/X3x6RuLLJ/6VQ25cWsSznv
	 HyRsrTEIQPmSvit7T+Fj7A3tTy8+9TLd6vrU0J87HGRbeD+XJrEQVod323EJiUUzk+
	 JIbajnxGaDABod60v59IdWD0zGBcjeSZxM0uVoDsL7UOVz6U2AD8X4NDTAtghd5esM
	 sgVmRO2DateKvrWQrhbbjte8mLladypCMuXXtDYl39pSNLHVqzjS4Z1/41fOyjRmyA
	 Fx6LA7Zqb842g==
Message-ID: <4e251463-8cfb-4cc6-b9b6-ce1dcd7c7052@kernel.org>
Date: Wed, 20 Mar 2024 11:30:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net 0/3] Report RCU QS for busy network kthreads
To: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>,
 Wei Wang <weiwan@google.com>, Alexander Duyck <alexanderduyck@fb.com>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <cover.1710877680.git.yan@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <cover.1710877680.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 19/03/2024 21.44, Yan Zhai wrote:
> This changeset fixes a common problem for busy networking kthreads.
> These threads, e.g. NAPI threads, typically will do:
> 
> * polling a batch of packets
> * if there are more work, call cond_resched() to allow scheduling
> * continue to poll more packets when rx queue is not empty
> 
> We observed this being a problem in production, since it can block RCU
> tasks from making progress under heavy load. Investigation indicates
> that just calling cond_resched() is insufficient for RCU tasks to reach
> quiescent states. This also has the side effect of frequently clearing
> the TIF_NEED_RESCHED flag on voluntary preempt kernels. As a result,
> schedule() will not be called in these circumstances, despite schedule()
> in fact provides required quiescent states. This at least affects NAPI
> threads, napi_busy_loop, and also cpumap kthread.
> 
> By reporting RCU QSes in these kthreads periodically before cond_resched, the
> blocked RCU waiters can correctly progress. Instead of just reporting QS for
> RCU tasks, these code share the same concern as noted in the commit
> d28139c4e967 ("rcu: Apply RCU-bh QSes to RCU-sched and RCU-preempt when safe").
> So report a consolidated QS for safety.
> 
> It is worth noting that, although this problem is reproducible in
> napi_busy_loop, it only shows up when setting the polling interval to as high
> as 2ms, which is far larger than recommended 50us-100us in the documentation.
> So napi_busy_loop is left untouched.
> 
> Lastly, this does not affect RT kernels, which does not enter the scheduler
> through cond_resched(). Without the mentioned side effect, schedule() will
> be called time by time, and clear the RCU task holdouts.
> 
> V4: https://lore.kernel.org/bpf/cover.1710525524.git.yan@cloudflare.com/
> V3: https://lore.kernel.org/lkml/20240314145459.7b3aedf1@kernel.org/t/
> V2: https://lore.kernel.org/bpf/ZeFPz4D121TgvCje@debian.debian/
> V1: https://lore.kernel.org/lkml/Zd4DXTyCf17lcTfq@debian.debian/#t
> 
> changes since v4:
>   * polished comments and docs for the RCU helper as Paul McKenney suggested
> 
> changes since v3:
>   * fixed kernel-doc errors
> 
> changes since v2:
>   * created a helper in rcu header to abstract the behavior
>   * fixed cpumap kthread in addition
> 
> changes since v1:
>   * disable preemption first as Paul McKenney suggested
> 
> Yan Zhai (3):
>    rcu: add a helper to report consolidated flavor QS
>    net: report RCU QS on threaded NAPI repolling
>    bpf: report RCU QS in cpumap kthread
> 
>   include/linux/rcupdate.h | 31 +++++++++++++++++++++++++++++++
>   kernel/bpf/cpumap.c      |  3 +++
>   net/core/dev.c           |  3 +++
>   3 files changed, 37 insertions(+)
> 

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

