Return-Path: <linux-kernel+bounces-119651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E8488CB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3741F33C24
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBCE8664A;
	Tue, 26 Mar 2024 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNIeew0y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37FC8627B;
	Tue, 26 Mar 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476383; cv=none; b=c9QR4VRRmvqZffs64gxqMzccKZtZE5T7nJWPtlfFULI+cqjZrmrratfuB7+coPUACW4hHEfxzIddTIvjKJ+3wZi0phpRV86nOZoahF5zZsELmAtbl4Ra55mdagcyaNEYLoi3y2UUKJQpP22n+aPLgU4yMmBqs+byauK8IXEe26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476383; c=relaxed/simple;
	bh=R+ckB3TYv6IwSf20f1+w+thE5azs2bxJD7LoIcuqpXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK50oVYtPfUD32ggzQVnr5jom9F8HrsI6IkM+YAImGh4P1v2lSXELHQmE7Z4A4vDdXm0nlCm1qf0ZNQvqz5yrusmAUBPISmiY6NXEAg8Ss5pMWiY0PhAZCexxwEDfvLMj8ONlXOER4pVDw4vWN66dOlbkuTk8Ic4UWaMB8BW7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNIeew0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F1DC433F1;
	Tue, 26 Mar 2024 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711476383;
	bh=R+ckB3TYv6IwSf20f1+w+thE5azs2bxJD7LoIcuqpXs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kNIeew0yhEd9NtCJTXqE5tv9mSD+gUCgCjmGZT6wPwtlUecV9zJPATOOjwkFd7FW9
	 BBUNZMYoMtM5vbiaxqdBc5GHqIk0Jc1ZaHM30U37r0eDAcJwkP6roONUmq2ODCDhJk
	 3l4AaBpRC7jSQ953fc/vDqJ5yJrUG813hNeKm8Sikx1+qbiL/KK4iNC/Z0R3uoDdzL
	 1Qpy2pSx+KzjgS5aQPdbgAudcBejKTbDp0yt75O3eBzujZbuq7aiQdB2iA7rnPvk+z
	 yNH2H4ca566y+6riRawOsPelRLv6NfMGAGasePf9pIRkI15oPeHGAD5+Z8NFXNmxas
	 Km9TBNW00Mm5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C1D2CCE129B; Tue, 26 Mar 2024 11:06:22 -0700 (PDT)
Date: Tue, 26 Mar 2024 11:06:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] rcu-tasks: Update show_rcu_tasks_trace_gp_kthread buffer
 size
Message-ID: <a6ad8ae1-40bf-41d0-a31c-30f4a5155b24@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240326174839.487582-1-kiryushin@ancud.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326174839.487582-1-kiryushin@ancud.ru>

On Tue, Mar 26, 2024 at 08:48:39PM +0300, Nikita Kiryushin wrote:
> There is a possibility of buffer overflow in
> show_rcu_tasks_trace_gp_kthread() if counters, passed
> to sprintf() are huge. Counter numbers, needed for this
> are unrealistically high, but buffer overflow is still
> possible.
> 
> Update used buffer size for maximum needed size for
> current format string.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: edf3775f0ad6 ("rcu-tasks: Add count for idle tasks on offline CPUs")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>

Good catch!  Applied for testing and further review.

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 147b5945d67a..13ac514489c0 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1992,7 +1992,7 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
>  #if !defined(CONFIG_TINY_RCU)
>  void show_rcu_tasks_trace_gp_kthread(void)
>  {
> -	char buf[64];
> +	char buf[87];
>  
>  	sprintf(buf, "N%lu h:%lu/%lu/%lu",
>  		data_race(n_trc_holdouts),
> -- 
> 2.34.1
> 

