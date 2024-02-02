Return-Path: <linux-kernel+bounces-50508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED98F847A08
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635CB1F25BF3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8ED8063A;
	Fri,  2 Feb 2024 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp8fxriP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB015E5CF;
	Fri,  2 Feb 2024 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903910; cv=none; b=Ckd+P8VQGKDnl9N5DEasicPTsK012Emzr5jJDInOPbCQv/M51T5SM563YsSYnrU86EPq5yt5YpWmT1eB89kZtAtu0HlVcZAl/wo4rU6TIi2s4BeQ3tlRizXEP8NtWSRIwHVYv1Jxn/ABTr7e4KCMsx47xSRPhjRWn69KHqh+NlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903910; c=relaxed/simple;
	bh=QXqBLZTBwDvHVnz+ZkulQjlUzUelopqjAIOf9+JsdIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a72p801rX2ckYr12gW6rxDMyTiLCUqtYY0T1vYogSVOTssOKB4fxLGp4oYKvGtjHIL3W7t8YlkzaIDRBjmZ8rJ//SzOo5680fb0HZuJBQZEo6Aj6TPsrzycvnmcdyArEMMvXBkpDzNAZcn31Oz5931mTJD9pbVqZ3dqvzgastxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp8fxriP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B860CC433C7;
	Fri,  2 Feb 2024 19:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903910;
	bh=QXqBLZTBwDvHVnz+ZkulQjlUzUelopqjAIOf9+JsdIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yp8fxriPipHveAtkSZWGL4RYByuF3BQFT06IyAs7nyBIsT8OdaQrFq+owBOAvMbD2
	 XIvpHdlWNA3Ym1PoHP61IYhLoQ8C/LUruHXsVxUs4Aiy3SAT2JZrD5he6+jm9kOohn
	 lP5JId8vOiM8t7jyTVu3Y82p57PSejAqER8KXv13ZAbEtsBL079++hZzlgBD3Z0oXN
	 xSSVf5jES+8T8/6vtwZLjp4lm5F9SErYxI6J64XiLhqXoEq0WYZe4T9TA5jAH1PpN/
	 am9dygBObjWHmlAK3fbUKAYnxPFk9Hj5P7a1U9Ju9ifbH0pkX7eNpx9jjckeXefCSa
	 l9/uCK76NGK7A==
Date: Fri, 2 Feb 2024 11:58:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 linux-api@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
 alexander.duyck@gmail.com, Wei Wang <weiwan@google.com>, Amritha Nambiar
 <amritha.nambiar@intel.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
Message-ID: <20240202115828.6fd125bf@kernel.org>
In-Reply-To: <20240202193332.GA8932@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
	<CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
	<5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
	<20240202032806.GA8708@fastly.com>
	<f0b4d813-d7cb-428b-9c41-a2d86684f3f1@intel.com>
	<20240202102239.274ca9bb@kernel.org>
	<20240202193332.GA8932@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 11:33:33 -0800 Joe Damato wrote:
> On Fri, Feb 02, 2024 at 10:22:39AM -0800, Jakub Kicinski wrote:
> > On Fri, 2 Feb 2024 11:23:28 -0600 Samudrala, Sridhar wrote:  
> > > I think you should be able to get this functionality via the netdev-genl 
> > > API to get napi parameters. It returns ifindex as one of the parameters 
> > > and you should able to get the name from ifindex.
> > > 
> > > $ ./cli.py --spec netdev.yaml --do napi-get --json='{"id": 593}'
> > > {'id': 593, 'ifindex': 12, 'irq': 291, 'pid': 3727}  
> > 
> > FWIW we also have a C library to access those. Out of curiosity what's
> > the programming language you'd use in user space, Joe?  
> 
> I am using C from user space. 

Ah, great! Here comes the advert.. :)

  make -C tools/net/ynl/

will generate the C lib for you. tools/net/ynl/generated/netdev-user.h
will have the full API. There are some samples in
tools/net/ynl/samples/. And basic info also here:
https://docs.kernel.org/next/userspace-api/netlink/intro-specs.html#ynl-lib

You should be able to convert Sridhar's cli.py into an equivalent 
in C in ~10 LoC.

> Curious what you think about
> SIOCGIFNAME_BY_NAPI_ID, Jakub? I think it would be very useful, but not
> sure if such an extension would be accepted. I can send an RFC, if you'd
> like to take a look and consider it. I know you are busy and I don't want
> to add too much noise to the list if I can help it :)

Nothing wrong with it in particular, but we went with the netlink API
because all the objects are related. There are interrupts, NAPI
instances, queues, page pools etc. and we need to show all sort of
attributes, capabilities, stats as well as the linking. So getsockopts
may not scale, or we'd need to create a monster mux getsockopt?
Plus with some luck the netlink API will send you notifications of
things changing.

> Here's a brief description of what I'm doing, which others might find
> helpful:
> 
> 1. Machine has multiple NICs. Each NIC has 1 queue per busy poll app
> thread, plus a few extra queues for other non busy poll usage.
> 
> 2. A custom RSS context is created to distribute flows to the busy poll
> queues. This context is created for each NIC. The default context directs
> flows to the non-busy poll queues.
> 
> 3. Each NIC has n-tuple filters inserted to direct incoming connections
> with certain destination ports (e.g. 80, 443) to the custom RSS context.
> All other incoming connections will land in the default context and go to
> the other queues.
> 
> 4. IRQs for the busy poll queues are pinned to specific CPUs which are NUMA
> local to the NIC.
> 
> 5. IRQ coalescing values are setup with busy poll in mind, so IRQs are
> deferred as much as possible with the assumption userland will drive NAPI
> via epoll_wait. This is done per queue (using ethtool --per-queue and a
> queue mask). This is where napi_defer_hard_irqs and gro_flush_timeout
> could help even more. IRQ deferral is only needed for the busy poll queues.

Did you see SO_PREFER_BUSY_POLL by any chance? (In combination with
gro_flush_timeout IIRC). We added it a while back with Bjorn, it seems
like a great idea to me at the time but I'm unclear if anyone uses it 
in production..

> 6. userspace app config has NICs with their NUMA local CPUs listed, for
> example like this:
> 
>    - eth0: 0,1,2,3
>    - eth1: 4,5,6,7
> 
> The app reads that configuration in when it starts. Ideally, these are the
> same CPUs the IRQs are pinned to in step 4, but hopefully the coalesce
> settings let IRQs be deferred quite a bit so busy poll can take over.

FWIW if the driver you're using annotates things right you'll also get
the NAPI <> IRQ mapping via the netdev netlink. Hopefully that
simplifies the pinning setup.

> 7. App threads are created and sockets are opened with REUSEPORT. Notably:
> when the sockets are created, SO_BINDTODEVICE is used* (see below for
> longer explanation about this).
> 
> 8. cbpf reusport program inserted to distribute incoming connections to
> threads based on skb->queue_mapping. skb->queue_mapping values are not
> unique (e.g. each NIC will have queue_mapping==0), this is why BINDTODEVICE
> is needed. Again, see below.
> 
> 9. worker thread epoll contexts are set to busy poll by the ioctl I've
> submit in my patches.
> 
> The first time a worker thread receives a connection, it:
> 
> 1. calls SO_INCOMING_NAPI_ID to get the NAPI ID associated with the
> connection it received.
> 
> 2. Takes that NAPI ID and calls SIOCGIFNAME_BY_NAPI_ID to figure out which
> NIC the connection came in on.
> 
> 3. Looks for an un-unsed CPU from the list it read in at configuration time
> that is associated with that NIC and then pins itself to that CPU. That CPU
> is removed from the list so other threads can't take it.
> 
> All future incoming connections with the same NAPI ID will be distributed
> to app threads which are pinned in the appropriate place and are doing busy
> polling.
> 
> So, as you can see, SIOCGIFNAME_BY_NAPI_ID makes this implementation very
> simple.
> 
> I plan to eventually add some information to the kernel networking
> documentation to capture some more details of the above, which I think
> might be helpful for others.

Sounds very sensible & neat indeed. And makes sense to describe this 
in the docs, that should hopefully put more people on the right path :)

> Another potential solution to avoid the above might be use an eBPF program
> and to build a hash that maps NAPI IDs to thread IDs and write a more
> complicated eBPF program to distribute connections that way. This seemed
> cool, but involved a lot more work so I went with the SO_BINDTODEVICE +
> SIOCGIFNAME_BY_NAPI_ID method instead which was pretty simple (C code wise)
> and easy to implement.

Interesting!

