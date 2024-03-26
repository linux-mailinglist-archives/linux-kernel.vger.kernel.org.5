Return-Path: <linux-kernel+bounces-119642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A073988CB76
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFC71F827E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6424C4C63A;
	Tue, 26 Mar 2024 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS3m6FJy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C51B28D;
	Tue, 26 Mar 2024 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476186; cv=none; b=EyBMCxb1h800IHvA7vNcnSEw3gC05ouKvuE6HASKSadhmA3yzwNPFGeaNpgzJYSB260uWwEvtyf1KfVD/W1bMqd2BmtyyVmAkB38NKwT70o8TYhRBDj/wo0zX3RUuwxAvI3rmTqWwxYYxm82d57PdEr34P4qQLKD1ycKwcbydJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476186; c=relaxed/simple;
	bh=ECUAAK2Nxs/H86gKiGl0W7txBlcNCaLixR40Qr44fhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmJycO8c0psMX4DloXSm20+Q7kdsfKv9Ejf2qE1eN+qVabKPrCP0HMN8j6+zd3zgk4m2Opx9J5puGjwtHIn22dFOYi2zKQQJId5HXkrWEHLW2ouT2f3zf643kGsL+yOk9d6LKDzVptmHZYuJBrvXDsMxl2sumoh9DRkB7aKJQ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS3m6FJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0809AC433F1;
	Tue, 26 Mar 2024 18:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711476186;
	bh=ECUAAK2Nxs/H86gKiGl0W7txBlcNCaLixR40Qr44fhw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fS3m6FJyJInIyCiPC6QB1VIvgS6KX+/WPWDbPUOcKZXnmBogEmK1ve+rdUv4vSDR+
	 OB34KGOHPcZHA9ZtwUKytXgL8JueBGM0UCMj9M/LtR2gANZS4kMJyB0x+ejQUVjE2W
	 lTR18/+tR8TF1YCb0qp8ArWu4rQHgpcFlR6+xoI6z1nqWz955cvJQMG1CaI3Y3we5P
	 Gx6MX2z1DET9n9ahwbYHZGDb0AQxpqQfgUZv7ObzDlNGUoKjqYs3pMzZWYcWmkxmIB
	 ebK9jPjLy+kepfmgAmHHq/e8Oa9j1UtySl7x6xtnx9hf2lDek0rZTg0EQ5BbTJNwLA
	 NJ+hnc3Rx2jWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 60DF4CE129B; Tue, 26 Mar 2024 11:03:05 -0700 (PDT)
Date: Tue, 26 Mar 2024 11:03:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Make stall-tasks directly exit when
 rcutorture tests end
Message-ID: <ed5b00dd-77f8-4b51-b24c-d5bf2d335cc6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240321082850.1756-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321082850.1756-1-qiang.zhang1211@gmail.com>

On Thu, Mar 21, 2024 at 04:28:50PM +0800, Zqiang wrote:
> When the rcutorture tests start to exit, the rcu_torture_cleanup() is
> invoked to stop kthreads and release resources, if the stall-task
> kthreads exist, cpu-stall has started and the rcutorture.stall_cpu
> is set to a larger value, the rcu_torture_cleanup() will be blocked
> for a long time and the hung-task may occur, this commit therefore
> add kthread_should_stop() to the loop of cpu-stall operation, when
> rcutorture tests ends, no need to wait for cpu-stall to end, exit
> directly.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Good eyes!

Queued for testing and further review, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 3f9c3766f52b..6a3cd6ed8b25 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2490,7 +2490,7 @@ static int rcu_torture_stall(void *args)
>  		pr_alert("%s start on CPU %d.\n",
>  			  __func__, raw_smp_processor_id());
>  		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
> -				    stop_at))
> +				    stop_at) && !kthread_should_stop())
>  			if (stall_cpu_block) {
>  #ifdef CONFIG_PREEMPTION
>  				preempt_schedule();
> -- 
> 2.17.1
> 

