Return-Path: <linux-kernel+bounces-31719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257748332F4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77E4B22D9E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 06:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C756020F5;
	Sat, 20 Jan 2024 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V29DH/y3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017FE1FBC;
	Sat, 20 Jan 2024 06:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705732697; cv=none; b=BdJo3Hr7ar0rfO4aggaVyEqLDkAuS6S+H7WfA7FrlCvOiSrAeBWnCm5XhcAvNUnBFxCVLri5saln78WV4A/NgvetmM2XGvyIzCF880hZ2H/RFkR4DJikYKlLZZGC7SoLjjO/e10kdlM7fFzAZuXnVGbQVCcw81HLYlmhEji9PBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705732697; c=relaxed/simple;
	bh=rT2EYcgKsz++dhLpBSL3G3IRaXCglKctuUgczSDQ2lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH7BV+ap+56C2J721e+9c/s8WI+fkqUiY5lXtb7BFGBt5/jBhW7O3hDibXN0FyI0bNEuokurteBDYtlWkyMw2ws8jH+Xknl2IKC9H/OVOoRGKOs/lATVoB+GQ76E7ewETTL5ScduwwEicmyjmwdyofnylLCLl8VP6rKYSEnZneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V29DH/y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CD8C433C7;
	Sat, 20 Jan 2024 06:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705732696;
	bh=rT2EYcgKsz++dhLpBSL3G3IRaXCglKctuUgczSDQ2lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V29DH/y30pXGqHh8JSQBJ0EgkPZh7vDDmHGPKIHsHPhqLD2jCWFq085hfGbYviiZS
	 w4MuZMx8/zeUOHM0yCVWsyaQCoR+SNjp9eilB20RyYRLznt2nnQCEVqGeQnzaypI5Y
	 /DXAETBuqnZFb+WNerJu7v6gU3QBN9tbvyyzGack=
Date: Sat, 20 Jan 2024 07:38:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	Huacai Chen <chenhuacai@loongson.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] mips/smp: Call rcu_cpu_starting() earlier
Message-ID: <2024012047-prompter-driveway-c418@gregkh>
References: <2024011935-snowman-regain-b820@gregkh>
 <20240119163811.3884999-1-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119163811.3884999-1-stefan.wiehler@nokia.com>

On Fri, Jan 19, 2024 at 05:38:11PM +0100, Stefan Wiehler wrote:
> rcu_cpu_starting() must be called before clockevents_register_device() to avoid
> the following lockdep splat triggered by calling list_add() when
> CONFIG_PROVE_RCU_LIST=y:
> 
>   WARNING: suspicious RCU usage
>   ...
>   -----------------------------
>   kernel/locking/lockdep.c:3680 RCU-list traversed in non-reader section!!
> 
>   other info that might help us debug this:
> 
>   RCU used illegally from offline CPU!
>   rcu_scheduler_active = 1, debug_locks = 1
>   no locks held by swapper/1/0.
>   ...
>   Call Trace:
>   [<ffffffff8012a434>] show_stack+0x64/0x158
>   [<ffffffff80a93d98>] dump_stack_lvl+0x90/0xc4
>   [<ffffffff801c9e9c>] __lock_acquire+0x1404/0x2940
>   [<ffffffff801cbf3c>] lock_acquire+0x14c/0x448
>   [<ffffffff80aa4260>] _raw_spin_lock_irqsave+0x50/0x88
>   [<ffffffff8021e0c8>] clockevents_register_device+0x60/0x1e8
>   [<ffffffff80130ff0>] r4k_clockevent_init+0x220/0x3a0
>   [<ffffffff801339d0>] start_secondary+0x50/0x3b8
> 
> raw_smp_processor_id() is required in order to avoid calling into lockdep
> before RCU has declared the CPU to be watched for readers.
> 
> See also commit 29368e093921 ("x86/smpboot:  Move rcu_cpu_starting() earlier"),
> commit de5d9dae150c ("s390/smp: move rcu_cpu_starting() earlier") and commit
> 99f070b62322 ("powerpc/smp: Call rcu_cpu_starting() earlier").
> 
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/kernel/smp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

What is the git commit id of this change in Linus's tree?  What
kernel(s) should this be applied to?

thanks,

greg k-h

