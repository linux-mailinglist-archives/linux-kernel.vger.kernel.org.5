Return-Path: <linux-kernel+bounces-100795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3F8879D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E897A283060
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD8914372C;
	Tue, 12 Mar 2024 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4B7fDkT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E43FE4B;
	Tue, 12 Mar 2024 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278142; cv=none; b=RfxnVzJQKNsvTiOLMZVbadc+uL3NQfocF+aUEZcsQ54bYOFNAmJAPTKLC4Msl9+0tfo73e/M9CS9SDHeE3pyMIR5YiACj58wzdXmQIEEqhCbyBlhIGGx2oovJRN8f8GKCF2ZanvnyLxT1OEuhfKUE415TWJKW1FjmMQy7q6d4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278142; c=relaxed/simple;
	bh=fWDd+5msU0BfCFa5Mc1s8n6dwpCV8l+LsPPJhSxZJck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZrLW2BXmHlCRWkhD04vQCsvyexWs+D1/MeKaUNGXxduy81UIXRdKht8XjZLy9YrtKZuFQD1mQvcXDhdTpT4JzJxX4WpVscRArnLisQqoiK++uZP8TcmR2wWsdeGMx+DUHo54hGp8zyVmNt1Y2yQ5RhhYb+r9ovPkIAUb4iaJMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4B7fDkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE7FC433C7;
	Tue, 12 Mar 2024 21:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710278141;
	bh=fWDd+5msU0BfCFa5Mc1s8n6dwpCV8l+LsPPJhSxZJck=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=a4B7fDkTpLuAimTDV4ARFBUjjZsu+qiegh/jBc3Qz4RylXs31L2qebG5DFmNR2/qf
	 ARTzMS2ldoWtksTO2wPnxTgodme40yyRs+2QPZlUxu3+nqOYp54LCAe6eVUExecotn
	 H05bP3bBBFMSQ38hKC1zl74PC9HESgeZV3Wkmca9S2+nEmzDUYx4k4BePo6xQrnV/T
	 wJ169izLpDFM5rewS8ygZzjGNZGT7KwZw894qYkLcyHxwGXBv2qkpZqJzRoB9O0K6f
	 BykVM9HcWGmFH8zUh6e47zxFpqcCXa8GQvyG/LcNce55fwoK+Y+qOoybC9E7piGL54
	 vD+QmwO9kCdWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 78777CE0C4C; Tue, 12 Mar 2024 14:15:41 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:15:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org,
	joel@joelfernandes.org, neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, bigeasy@linutronix.de,
	anna-maria@linutronix.de, chenzhongjin@huawei.com,
	yangjihong1@huawei.com, rostedt@goodmis.org
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]
Message-ID: <f324cf7f-f5ff-4f19-b6ee-3a47870766b8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZetHwrCb0KXE0xFI@tardis>
 <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDCjBFfyWpTK-I1@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfDCjBFfyWpTK-I1@pavilion.home>

On Tue, Mar 12, 2024 at 10:01:00PM +0100, Frederic Weisbecker wrote:
> Le Tue, Mar 12, 2024 at 01:32:03PM -0700, Florian Fainelli a écrit :
> > Hi Boqun,
> > 
> > On 3/8/24 09:15, Boqun Feng wrote:
> > > Hi Linus,
> > > 
> > > Please pull this for the RCU changes of v6.9:
> > > 
> > > The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:
> > > 
> > >    Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git tags/rcu.next.v6.9
> > > 
> > > for you to fetch changes up to 3add00be5fe5810d7aa5ec3af8b6a245ef33144b:
> > > 
> > >    Merge branches 'rcu-doc.2024.02.14a', 'rcu-nocb.2024.02.14a', 'rcu-exp.2024.02.14a', 'rcu-tasks.2024.02.26a' and 'rcu-misc.2024.02.14a' into rcu.2024.02.26a (2024-02-26 17:37:25 -0800)
> > > 
> > > 
> > > Two merge conflicts were detected by linux-next:
> > > 
> > > * https://lore.kernel.org/lkml/20240226135745.12ac854d@canb.auug.org.au/
> > > * https://lore.kernel.org/lkml/20240227125522.2bdbe6be@canb.auug.org.au/
> > > 
> > > These conflict resolutions from linux-next look good to me, plus I made
> > > my own resolutions at branch merge/rcu.2024.02.27a for your reference.
> > > 
> > > 
> > > Some highlights of the changes:
> > > 
> > > * Eliminates deadlocks involving do_exit() and RCU tasks, by Paul:
> > >    Instead of SRCU read side critical sections, now a percpu list is used
> > >    in do_exit() for scaning yet-to-exit tasks.
> > > 
> > > * Fixes a deadlock due to the dependency between workqueue and RCU
> > >    expedited grace period, reported by Anna-Maria Behnsen and Thomas
> > >    Gleixner and fixed by Frederic: Now RCU expedited always uses its own
> > >    kthread worker instead of a workqueue.
> > 
> > At least one device in my test farm (ARM 32-bit) has consistently shown a
> > very long boot, and some others are intermittently affected. This
> > consistently looks like this on most of my devices:
> > 
> > [    2.450351] bcmgenet f0480000.ethernet: GENET 5.0 EPHY: 0x0000
> > [    2.547562] ata1: SATA link down (SStatus 0 SControl 300)
> > [  162.107264] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
> > 
> > this gets flagged by my boot script as a boot failure since we exceeded the
> > 30 seconds timeout given to boot a kernel to a prompt.
> > 
> > It has been somewhat difficult to get a reliable bisection going on, but
> > what I am sure of is that e5a3878c947ceef7b6ab68fdc093f3848059842c~1 does
> > not expose the problem for 10 consecutive boots, while I *might* see it at
> > e5a3878c947ceef7b6ab68fdc093f3848059842c and beyond.
> > 
> > Any clues what is going on here?
> 
> I understand it doesn't reliably reproduce. But is there any chance you could
> test that alone?
> 
>      0bb11a372fc8 (rcu-tasks: Maintain real-time response in rcu_tasks_postscan())
> 
> And if it reproduces there try a bisection?
> 
> git bisect bad 0bb11a372fc8d7006b4d0f42a2882939747bdbff
> git bisect good 41bccc98fb7931d63d03f326a746ac4d429c1dd3

Good point!

Is this kernel built with CONFIG_PREEMPT_RT=y and CONFIG_TASKS_RCU=y?
Either way, is there also a large number of tasks exiting at this point
during boot?

							Thanx, Paul

