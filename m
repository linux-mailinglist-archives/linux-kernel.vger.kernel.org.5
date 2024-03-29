Return-Path: <linux-kernel+bounces-125260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E417B8922F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44911C23FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF68136E01;
	Fri, 29 Mar 2024 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDbRbDvt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827B134735;
	Fri, 29 Mar 2024 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734215; cv=none; b=IlaUpTHwN4jqN3wnT1dB+j5rLst9iBBqlzrBmjpZxMCpaZDHuSCBzz2Cq5BddZdZtLdofDn2moUV72tIeHXtdyV6EI7ZsI8XTH5bL9rMSq+sIn7lFA/ZMAGo33V6mKN9dryHC23ZQEzXntj655PwhARrl+dmWRjIF82aaS8MjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734215; c=relaxed/simple;
	bh=i7ypJ+h9Bw+WA9umKwnPpvNeTvx1AFolPnPPaG1KPlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naQTjwNaloEphCWYkd74bCrKht2c6XLjp9y1M/3HCBQVo2qSTUSzkSTCyuI546cWL/rEcUhgaFguOnaCGJ3oG07hBc2XuYTIAu1AcqR/hG2dKxluYqHcMH11XW2QCh0qq4+17DeGjXY7mE3FCBu7NodnY7Ou74WUArmpl3lzf3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDbRbDvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2525BC43390;
	Fri, 29 Mar 2024 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711734215;
	bh=i7ypJ+h9Bw+WA9umKwnPpvNeTvx1AFolPnPPaG1KPlY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FDbRbDvtrWVzbVluRY9xqDd86vF2Hw4E8XTZXXbd7UF+Rq5CARUVXAEiBZrP2CRD3
	 nVA+VB37mCCvd/swJiRSjsuX/GNjZ03BupMizhW+Rwkta0Kon+23YVfZt2U/7xAcQH
	 VhLaUZe2JkcTDn49GzTKtbwVXm422j+1XLrBfaRkn8WYQN3OE+bASor1Fj4WpTmeyI
	 OBg5Xyink4NwiQdrgtbJLGZAYZiCQIgeWf1rHmiqeeXCHgtuBha6YwgZXrm60biuWN
	 g+SgucBDdi0nfL4ZoXWdVJ8bD2V/9AfdgUlKNAjkWd5AusiBlTlKHqpa+OHiDVf8OY
	 lDQ77v7gnQbog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9B63FCE0EE1; Fri, 29 Mar 2024 10:43:33 -0700 (PDT)
Date: Fri, 29 Mar 2024 10:43:33 -0700
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
Subject: Re: [PATCH] rcu: Fix buffer overlow in print_cpu_stall_info()
Message-ID: <e3d3a612-4751-48ac-82c1-8bf61e8f3cd1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240328181914.869332-1-kiryushin@ancud.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328181914.869332-1-kiryushin@ancud.ru>

On Thu, Mar 28, 2024 at 09:19:14PM +0300, Nikita Kiryushin wrote:
> rcuc info output in print_cpu_stall_info() contains
> posiible buffer overflow in the case of huge jiffies
> difference. The situation seems improbable, but, buffer
> overflow, still. Also, unsigned jiffies difference printed
> as (signed) %ld (which can be a bad format, if the values
> are huge).
> 
> Change sprintf to snprintf and change %ld to %lu in format.

Good catch!!!

However, the signed output is intentional.  The idea is that if the
timekeeping code is confused enough to run the jiffies counter backwards,
we see a small negative number rather than a huge positive number.
For example, -132 is immediately obvious, while the 64-bit unsigned
equivalent of 18446744073709551484 might not be.

would you like to resend keeping the buffer-overflow fix but leaving
out the signed-to-unsigned conversion?

							Thanx, Paul

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 245a62982502 ("rcu: Dump rcuc kthread status for CPUs not reporting quiescent state")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
>  kernel/rcu/tree_stall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 5d666428546b..d4542c6e7c60 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -504,7 +504,7 @@ static void print_cpu_stall_info(int cpu)
>  			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
>  	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
>  	if (rcuc_starved)
> -		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
> +		snprintf(buf, sizeof(buf), " rcuc=%lu jiffies(starved)", j);
>  	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
>  	       cpu,
>  	       "O."[!!cpu_online(cpu)],
> -- 
> 2.34.1
> 

