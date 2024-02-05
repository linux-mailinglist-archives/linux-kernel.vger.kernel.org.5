Return-Path: <linux-kernel+bounces-53885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC2984A7A0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660AC1F2AF8B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD77129A82;
	Mon,  5 Feb 2024 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkkDVeH/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D441292E3;
	Mon,  5 Feb 2024 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163416; cv=none; b=jZdHohbj4ysbUxFVCDGpbrqDDgRVS9F4ToBaIsRTcSxpvGB6WnXySSkunPqeTmuHqOEhESVVt0hawq1Ra58zX0lykB1wY+iwPtdlMLkt4v4HfOA/fzUOCm20QezKWWUmiucqnBQmAoAsUVZOhw2+ZgpzfGqpNETH9W7vdkpXKY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163416; c=relaxed/simple;
	bh=4eZQWX6W/aYg6ERcF31vLpr9leduea34fMM6jYOWiz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV1TbiRRHAoJWm/2K3WWR+CNkOCnmcbZVQJYprvaBZftPM3CP8qd0Gge5ciWZJODMBHZUEk7bPg2/Gtbnhde6stGg1pS2Ti8Iukt2woDoOwjcLSRJxkdoSLWbwNCa365dOEROXb1yY9lCWHbVW/uH4cahPEkDm7WG/jlaC739cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkkDVeH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E30C433C7;
	Mon,  5 Feb 2024 20:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707163415;
	bh=4eZQWX6W/aYg6ERcF31vLpr9leduea34fMM6jYOWiz0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NkkDVeH/dIz2ktshCpJBJNpZa2Zmcy8Ftdfmtxu/qnvvsw2YtCwimeSk7gGMT5XlV
	 ASLc8mT1/uYmlIG053uc8ekPQXOOyQajn6sADUbL/3H/xcKhklAhf/8boApDBu2NuI
	 awlbhSPajP05uUVHAWf3lOvcEIL7CQpHBIf56qA+o+fxueW6Uo6bhbKpsbNVvSInKI
	 36bQvBz6pdrr60lBHP78+/X6kmjJbOIBYRrTfTxr6AFwEJY37NZPKmD33I/uCLHGKq
	 6ishGzLNJQUQb1FoL4UNvsU6/zNgOZvxSCwyJvx11WKAhUJgJBJ+1hc5Xjj4OKEtBE
	 GvdLi3pydaXMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 69A21CE1C10; Mon,  5 Feb 2024 12:03:33 -0800 (PST)
Date: Mon, 5 Feb 2024 12:03:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Zhengxu Chen <zhxchen17@meta.com>,
	Danielle Costantino <dcostantino@meta.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Feng Tang <feng.tang@intel.com>, Waiman Long <longman@redhat.com>,
	John Stultz <jstultz@google.com>, x86@kernel.org
Subject: Re: [PATCH 5/8] tsc: Check for sockets instead of CPUs to make code
 match comment
Message-ID: <1781cc76-aeee-427b-bc9e-b3d2b8f184f3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240129235646.3171983-1-boqun.feng@gmail.com>
 <20240129235646.3171983-6-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129235646.3171983-6-boqun.feng@gmail.com>

On Mon, Jan 29, 2024 at 03:56:38PM -0800, Boqun Feng wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> The unsynchronized_tsc() eventually checks num_possible_cpus(), and
> if the system is non-Intel and the number of possible CPUs is greater
> than one, assumes that TSCs are unsynchronized.  This despite the
> comment saying "assume multi socket systems are not synchronized",
> that is, socket rather than CPU.  This behavior was preserved by
> commit 8fbbc4b45ce3 ("x86: merge tsc_init and clocksource code") and
> by the previous relevant commit 7e69f2b1ead2 ("clocksource: Remove the
> update callback").
> 
> The clocksource drivers were added by commit 5d0cf410e94b ("Time: i386
> Clocksource Drivers") back in 2006, and the comment still said "socket"
> rather than "CPU".
> 
> Therefore, bravely (and perhaps foolishly) make the code match the
> comment.
> 
> Note that it is possible to bypass both code and comment by booting
> with tsc=reliable, but this also disables the clocksource watchdog,
> which is undesirable when trust in the TSC is strictly limited.
> 
> Reported-by: Zhengxu Chen <zhxchen17@meta.com>
> Reported-by: Danielle Costantino <dcostantino@meta.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: John Stultz <jstultz@google.com>
> Cc: <x86@kernel.org>

Hello, Boqun,

Please drop this one, as I never got an ack from the maintainers, and
quite possibly for good reason.  ;-)

							Thanx, Paul

> ---
>  arch/x86/kernel/tsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 15f97c0abc9d..d45084c6a15e 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1287,7 +1287,7 @@ int unsynchronized_tsc(void)
>  	 */
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
>  		/* assume multi socket systems are not synchronized: */
> -		if (num_possible_cpus() > 1)
> +		if (nr_online_nodes > 1)
>  			return 1;
>  	}
>  
> -- 
> 2.43.0
> 

