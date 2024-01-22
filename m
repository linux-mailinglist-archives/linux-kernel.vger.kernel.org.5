Return-Path: <linux-kernel+bounces-33751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459C6836E91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D04BB2AA3E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339013DB8D;
	Mon, 22 Jan 2024 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vfju6/uT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98C3D99F;
	Mon, 22 Jan 2024 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943251; cv=none; b=Vbl8vNUryzhRAzZI8+kG9Oltg2/As6XVu5aBY6lg58yA/Q++cVDUB5Q1eAvz15X4s8FLmwOyx7v3C6unR0l/+h0Y1ZGn9cR66Boj5I8Y/nRlzz4DNd3O3x7t0oXWE6VywUX5X0ih4tSPfxzJu9QQ2l3w8IzCqpJOzt3M7LyrKB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943251; c=relaxed/simple;
	bh=+JZz32rW4JTCFtXIffKZnVlpE+3nMpJ5etJGZvkKUt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xbj4sI4LXUMBKJkV6F+rrjLFIWTZe2Spjc9AoZpeXAgOhsQup+L/tVaRQvbx9e0JJS4ZqdRmFHLR2P90mKLH6IYbSyAbmEXA2bYsC65HqHSMICUB3bp71jGs/8yJpEWwixH5FPtGX0edRpgxAHyQV4U/nG5a4vxrX2VKc5odcPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vfju6/uT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E083C433F1;
	Mon, 22 Jan 2024 17:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705943251;
	bh=+JZz32rW4JTCFtXIffKZnVlpE+3nMpJ5etJGZvkKUt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vfju6/uTQDFy/inOO9Cv8BylCzmPH+WOUs2vKtKq+86zr9Iic/k0ivgFtFVKMEoBM
	 z/wP15XKNngZzQbsiw/FTySNTZfYIYbriqSONjALL2bQb8cM7jRUX5vWnq1tqOl0Ha
	 WSwmIc1v5GQXReigkzAOvcuAWPZ8G3J2UJ5usaUw=
Date: Mon, 22 Jan 2024 09:07:28 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Stefan Wiehler <stefan.wiehler@nokia.com>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	Huacai Chen <chenhuacai@loongson.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] mips/smp: Call rcu_cpu_starting() earlier
Message-ID: <2024012219-retiring-superbowl-1570@gregkh>
References: <2024011935-snowman-regain-b820@gregkh>
 <20240119163811.3884999-1-stefan.wiehler@nokia.com>
 <2024012047-prompter-driveway-c418@gregkh>
 <b3ddf95a-7f4a-4f15-b701-c37cfe95a4cb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ddf95a-7f4a-4f15-b701-c37cfe95a4cb@gmail.com>

On Sun, Jan 21, 2024 at 08:52:55AM -0800, Florian Fainelli wrote:
> 
> 
> On 1/19/2024 10:38 PM, Greg Kroah-Hartman wrote:
> > On Fri, Jan 19, 2024 at 05:38:11PM +0100, Stefan Wiehler wrote:
> > > rcu_cpu_starting() must be called before clockevents_register_device() to avoid
> > > the following lockdep splat triggered by calling list_add() when
> > > CONFIG_PROVE_RCU_LIST=y:
> > > 
> > >    WARNING: suspicious RCU usage
> > >    ...
> > >    -----------------------------
> > >    kernel/locking/lockdep.c:3680 RCU-list traversed in non-reader section!!
> > > 
> > >    other info that might help us debug this:
> > > 
> > >    RCU used illegally from offline CPU!
> > >    rcu_scheduler_active = 1, debug_locks = 1
> > >    no locks held by swapper/1/0.
> > >    ...
> > >    Call Trace:
> > >    [<ffffffff8012a434>] show_stack+0x64/0x158
> > >    [<ffffffff80a93d98>] dump_stack_lvl+0x90/0xc4
> > >    [<ffffffff801c9e9c>] __lock_acquire+0x1404/0x2940
> > >    [<ffffffff801cbf3c>] lock_acquire+0x14c/0x448
> > >    [<ffffffff80aa4260>] _raw_spin_lock_irqsave+0x50/0x88
> > >    [<ffffffff8021e0c8>] clockevents_register_device+0x60/0x1e8
> > >    [<ffffffff80130ff0>] r4k_clockevent_init+0x220/0x3a0
> > >    [<ffffffff801339d0>] start_secondary+0x50/0x3b8
> > > 
> > > raw_smp_processor_id() is required in order to avoid calling into lockdep
> > > before RCU has declared the CPU to be watched for readers.
> > > 
> > > See also commit 29368e093921 ("x86/smpboot:  Move rcu_cpu_starting() earlier"),
> > > commit de5d9dae150c ("s390/smp: move rcu_cpu_starting() earlier") and commit
> > > 99f070b62322 ("powerpc/smp: Call rcu_cpu_starting() earlier").
> > > 
> > > Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> > > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > > ---
> > >   arch/mips/kernel/smp.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > What is the git commit id of this change in Linus's tree?  What
> > kernel(s) should this be applied to?
> 
> The upstream commit is 55702ec9603ebeffb15e6f7b113623fe1d8872f4 ("mips/smp:
> Call rcutree_report_cpu_starting() earlier") and this change from Stefan
> should be applied to both the 6.1 stable and 6.6 stable branches. Thanks!

Thanks, now queued up.

greg k-h

