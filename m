Return-Path: <linux-kernel+bounces-50250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEA0847654
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBEE1F26DEF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCFC145B2D;
	Fri,  2 Feb 2024 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQqL0XZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E59A14AD0D;
	Fri,  2 Feb 2024 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895606; cv=none; b=P0Dm+jXz29WCS+eLKicJfKauHTKrXcnt/Zz1HH/rk8OkQzzgOgyabFuVgcoTvrdMQwhhQR9kc1PRRjwbMq+KeqlOV9uGiQ0xOzo4a9IVmK9uf/cd/L1DFnAsxFYfsvFKIhglAZiHMtM3NCIjmp7UUb6cRgjfq9GqyEqcEV/P0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895606; c=relaxed/simple;
	bh=LWCXHnt0lI6HVMyiY0mIILlqRl10sJ4sbWNqFpBGrAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJvRicPMKUanuxQ4VHHPw0cZ+yZMe/d1PUu8408K5wxNLeL7yl7IW7d2pWLP8sop2LS8c6g/Jk6iNinr9uUEUhN9PzEV9asQcuaHHd/GS1hJojurJIYeoCcV38RmDxhtWVX9gu0zRu8sgFkwNfbDkl+OUnxqOn0LzROFZvBppaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQqL0XZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CD7C433C7;
	Fri,  2 Feb 2024 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706895605;
	bh=LWCXHnt0lI6HVMyiY0mIILlqRl10sJ4sbWNqFpBGrAY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pQqL0XZC4AgnGCUAheM2US7kN8E2taVhPfq2xU1Td4ADM8+U7e58s9xamhw8em+eH
	 CIvs/tw2mbO+vBHXzIvqtbGMT2GSasmvGRtTNOypaefvph7TJc3Vzs3fdq/bmscbUD
	 ngreHIIXBbGkOwvhUNdGtWW5b4ocUXLNDBDBV5FwZaf0So+l4ggS2dM9RvO6cMow2A
	 1InJBbLJtp4aAr8Psn6JgbozjyuGusl6a4MZAsoXy5poJm7cYLwGO0Q4YswrrdBWmw
	 CY7dPmVt8N7JLs02cBhqk8F2ZTLTkUkilUmN1UM4iblnDjcvl4MuTqmr8U9ofWvEf8
	 eddTFVShUG8oQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 662A9CE2250; Fri,  2 Feb 2024 09:40:05 -0800 (PST)
Date: Fri, 2 Feb 2024 09:40:05 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <c5d5ad66-da86-447b-8014-820d2c67382d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
 <c6ce8816-c4ff-4668-8cbb-88285330057d@huaweicloud.com>
 <25fd8537-5a27-4b62-9bf9-1ee7ca59b5b8@paulmck-laptop>
 <Zb0evDquygkDI_8P@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb0evDquygkDI_8P@slm.duckdns.org>

On Fri, Feb 02, 2024 at 06:56:28AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Feb 02, 2024 at 08:35:51AM -0800, Paul E. McKenney wrote:
> > Good point, and if this sort of thing happens frequently, perhaps there
> > should be an easy way of doing this.  One crude hack that might come
> > pretty close would be to redefine the barrier() macro to be smp_mb().
> > 
> > But as noted earlier, -ENOREPRODUCE on today's -next.  I will try the
> > next several -next releases.  But if they all get -ENOREPRODUCE, I owe
> > everyone on CC an apology for having sent this report out before trying
> > next-20240202.  :-/
> 
> I think I saw that problem too but could reproduce it with or without the
> workqueue changes, so I did the lazy thing "oh well, somebody is gonna fix
> that" and just tested as-is. It's a bit worrying that ppl don't seem to
> already know what the culprit is. Hmm... I can't reproduce it anymore
> either.

Glad that it is not just me!  I think...  ;-)

> So, there is some chance that this may really be a subtle breakage. If you
> ever see it happening again, triggering sysrq-t and capturing the dmesg
> output (network should still work fine, so these shouldn't be too difficult)
> may help. sysrq-t has workqueue state dump at the end which should clearly
> indicate if anything is stalled in workqueue.

Good point, if it does recur, I could try it on bare metal.

> That said, another data point. In my test setup, I use the earlyprintk boot
> option which enables console output way before than workqueue becomes
> operational, so having on console output at all is highly unlikely to be
> indicative of workqueue problem. My memory is hazy but it seems like I can
> no longer reproduce the problem on the same git commit. Maybe it was a
> problem on the qemu side?

It might have been a qemu issue, but I am using the same qemu. 

No idea!

But I will try earlyprintk if this happens again.

							Thanx, Paul

