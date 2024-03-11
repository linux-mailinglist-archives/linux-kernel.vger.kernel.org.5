Return-Path: <linux-kernel+bounces-99463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EBC8788C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D258128101B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402EC56773;
	Mon, 11 Mar 2024 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+l/Spf3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D57056760;
	Mon, 11 Mar 2024 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184800; cv=none; b=HK8Gv79RQd1r8io7CKm2AtQQ/JZtaczJd2+Ja8byMfDGRBEtXxdE7Uf0VuC5jNQrdRROWCA1x4dOoxeFV0sRdN5DPgmw09jk5XUv20VIsNojpHGNLu5IjLyhaTHbGyvdaDW5H2NP/lZy9C2HqKdwgEDJOuMR0dTvjKr3/8l1rM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184800; c=relaxed/simple;
	bh=W0QwnwhwBVdu31x4nz8XwRx+ENapwWcKDdC+Mp/Nmuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo1NBc3MrOX9E68eKS8j5IF8lKU1gQ2yxBRzzHfA3e0hkLv81gPmuPCXCBQ/+sMO3WJNoQOPW6PDNnEjjA/KY9Gltnths9xiLNWbLNQs1CWMll97qF7V62vBGCye+krMaXX0ZsLBwmmr0rrMR3BbCfUCGLku7P+m9uAerYqXUn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+l/Spf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A484C433F1;
	Mon, 11 Mar 2024 19:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710184800;
	bh=W0QwnwhwBVdu31x4nz8XwRx+ENapwWcKDdC+Mp/Nmuk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=S+l/Spf3o/TjHQz6wvvV5qGRkOn6Xf1YXRVSw1ohbude9MQjByfGa+JMCGzsWUYJM
	 MauoBQMW1M+W6v6ozgZQWpxg62CP8RJNtZrAPVi2k4cKTvfAJ9sgb9Tmtg9Y+2WukN
	 DJJXsYwJEN/Fj7i5Fma55smmn/88gBAw/H+m6Uxr1i6hduSXLNBYFBwtcsyCSeFTBV
	 RzaIMY4TXYVRgAhQjVfHnrzUttzEYoQJNCsdbii5Ic9Zg8/A/eqzsOEx74ulxweDnR
	 7B8h4oVVpugby0r6E2Lkpk3VhPHe1qmCKSHCLUFgGrlivgyIqP18OTnZAscB9/HIoN
	 DfN6IhFC2sWbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D9BFBCE0B68; Mon, 11 Mar 2024 12:19:59 -0700 (PDT)
Date: Mon, 11 Mar 2024 12:19:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v6 0/6] Reduce synchronize_rcu() latency(v6)
Message-ID: <e055993f-9a1b-4c92-b093-7babed9ba58b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240308173409.335345-1-urezki@gmail.com>
 <63e54cb9-fd08-43c3-9f42-3627198634e8@paulmck-laptop>
 <Ze7ER232fPpvGssC@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze7ER232fPpvGssC@pc636>

On Mon, Mar 11, 2024 at 09:43:51AM +0100, Uladzislau Rezki wrote:
> On Fri, Mar 08, 2024 at 01:51:29PM -0800, Paul E. McKenney wrote:
> > On Fri, Mar 08, 2024 at 06:34:03PM +0100, Uladzislau Rezki (Sony) wrote:
> > > This is v6. It is based on the Paul's "dev" branch:
> > > 
> > > HEAD: f1bfe538c7970283040a7188a291aca9f18f0c42
> > > 
> > > please note, that patches should be applied from scratch,
> > > i.e. the v5 has to be dropped from the "dev".
> > > 
> > > v5 -> v6:
> > >  - Fix a race due to realising a wait-head from the gp-kthread;
> > >  - Use our own private workqueue with WQ_MEM_RECLAIM to have
> > >    at least one execution context.
> > > 
> > > v5: https://lore.kernel.org/lkml/20240220183115.74124-1-urezki@gmail.com/
> > > v4: https://lore.kernel.org/lkml/ZZ2bi5iPwXLgjB-f@google.com/T/
> > > v3: https://lore.kernel.org/lkml/cd45b0b5-f86b-43fb-a5f3-47d340cd4f9f@paulmck-laptop/T/
> > > v2: https://lore.kernel.org/all/20231030131254.488186-1-urezki@gmail.com/T/
> > > v1: https://lore.kernel.org/lkml/20231025140915.590390-1-urezki@gmail.com/T/
> > 
> > Queued in place of your earlier series, thank you!
> > 
> Thank you!
> 
> >
> > Not urgent, but which rcutorture scenario should be pressed into service
> > testing this?
> > 
> I tested with setting '5*TREE01 5*TREE02 5*TREE03 5*TREE04' apart of that
> i used some private test cases. The rcutree.rcu_normal_wake_from_gp=1 has
> to be passed also.
> 
> Also, "rcuscale" can be used to stress the "cur_ops->sync()" path:
> 
> <snip>
> #! /usr/bin/env bash
> 
> LOOPS=1
> 
> for (( i=0; i<$LOOPS; i++ )); do
>         tools/testing/selftests/rcutorture/bin/kvm.sh --memory 10G --torture rcuscale \
>     --allcpus \
>       --kconfig CONFIG_NR_CPUS=64 \
>       --kconfig CONFIG_RCU_NOCB_CPU=y \
>       --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
>       --kconfig CONFIG_RCU_LAZY=n \
>       --bootargs "rcuscale.nwriters=200 rcuscale.nreaders=220 rcuscale.minruntime=50000 \
>                          torture.disable_onoff_at_boot rcutree.rcu_normal_wake_from_gp=1" --trust-make
>         echo "Done $i"
> done
> <snip>

Very good, thank you!

Of those five options (TREE01, TREE02, TREE03, TREE04, and rcuscale),
which one should be changed so that my own testing automatically covers
the rcutree.rcu_normal_wake_from_gp=1 case?  I would guess that we should
leave out TREE03, since it covers tall rcu_node trees.  TREE01 looks
closest to the ChromeOS/Android use case, but you tell me!

And it might be time to rework the test cases to better align with
the use cases.  For example, I created TREE10 to cover Meta's fleet.
But ChromeOS and Android have relatively small numbers of CPUs, so it
should be possible to rework things a bit to make one of the existing
tests cover that case, while modifying other tests to take up any
situations that these changes exclude.

Thoughts?

							Thanx, Paul

