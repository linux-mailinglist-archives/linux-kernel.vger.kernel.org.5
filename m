Return-Path: <linux-kernel+bounces-50541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06C5847A75
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C1F1C25EC1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453D381742;
	Fri,  2 Feb 2024 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GCXNu06B"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2081725
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706905430; cv=none; b=HFDwB//sOIyOX8qL1VHCk5b1cpaby0uFHMvZfR3sIN2U+waVABrMgp4YK7iiR2WXJbZn11J8SnkrxNE1LXd2qVDdga0gLYb1SNXc4FAVUXzcNGV4ahPW0Z409syY+W784ZR7kwwuYOlRphsaFblBZExfvJVI2N0cOahlLxp3TeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706905430; c=relaxed/simple;
	bh=kHh/Fwi+zgGR85Gonsy9nCSLc26QR0hWZ/EbYVLS86Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvDiYbbg8wIjkLmFF8jI26Yt1W7FsRwhzlyYLFBRZuovsMZlhe1gscHtcnr8eH7u4CVoShJeVtUifQ64U+ACiq/IovpIWQv9m2D43QMbEVYvL+BdMvMHvBjtnlphK/KyU5HjPxDkXUXICzMNFqitePBBwHAIoJXIEYUHLiN6IUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GCXNu06B; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d8aadc624dso19720085ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 12:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706905428; x=1707510228; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGhLoepqPTEf7fOGkK9tuzMrdf1LkUJ0F04BvVx/aiI=;
        b=GCXNu06BRb5o288k9j76q2LpYuWBNK8xWVRfV1q8m5n5FPJaeJ8PImkXqKTOPoBIt8
         4KQBOz+pPNNE//PYPiceapmQWmGitw4q7Ywxr5Q1CSzSeYvwf8Vz/xk5evVK68jbKaw+
         R7cFd6JVEw3qu+C9bZ+xdgD/0x6NlmTVDB7A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706905428; x=1707510228;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGhLoepqPTEf7fOGkK9tuzMrdf1LkUJ0F04BvVx/aiI=;
        b=fhCWFEhgK3fF7o/7rMN64BSwGYGAHt5HvPLyu+6ib3OPrj4KyjrQk0wpK98dzModB9
         4FwOxZgMiRVrQXEUkWDA41ipmF58R78ZSFKrEKD56FA+hgQQxM6ffWw8YVuDW0+rp3yt
         zz53W2mWasyTF+lPiQ4yFZ/wHbal/uoXQPwHxNW8a6SRVDkqkTk2ms9FsYik1vYke4R7
         zdQ8soJq5tOOMmcKF0WgAD/IGMBfjTt1a9izZ4MR/Quh9UeZlpXe8/V7OQaz3W0ofb0c
         md+P47PvTmdgSPz8tuSNdKe9jYidkymVH0P6RsUhn8I4eLzGQN3nowdURKs5jnTtuETn
         kdSg==
X-Gm-Message-State: AOJu0Yxvly55+RP08/xD6kbv7tApmY9hHNKO2S9D3I1SsfnU76+FXbmD
	LEs+0m7DoGWtkOjZ6m9p1cdk8fptcegtZgM7+4WggBc4gGFPuU3i+1jaCUsk0D4=
X-Google-Smtp-Source: AGHT+IHeA3z/fTGd19l6o022GvzdVCVu3LbORSy1WAiGDts+qleaBHwb9krLrA1bSTwU9coQQOyP+A==
X-Received: by 2002:a17:903:41cd:b0:1d5:b275:30a3 with SMTP id u13-20020a17090341cd00b001d5b27530a3mr3642973ple.24.1706905427819;
        Fri, 02 Feb 2024 12:23:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV//NKyNno7BailUBDkzV+sl7OvHgakIe5TltmvP2n5Iw4NmztPotCGc6VMrwYZnStsutDZT+rczzoDCVLFYytIFzvTKsUzoox2w3oVh8DpvUiCcWa1w86S55ULTIpWxMviGil3unvaCsyeBnMKsDqvl605aiRuy3khHQhY+UZ4cU1KKrXFW/QnUJNBfWK02bsk5xE7tyvDeqHEBwI85TDUFjebtMKkm/emiFdcxigGvC4QIVhPd2PpVqYOc1JPGPHA7u0Qt+KKKJuJc26kDOTvLlz0rFATm1vl9rvDZYlagNXCarUjwwEPZTEA2f7VjRUXorre1kz1Ae3kPr7j0RlKLtKrNW7LBIaYamQoPEbSF9oZvKUa2Jrv0xKNhrvzAMsAj9ITFN64YWyvlHqf+uiAoYo=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902b78900b001d987771271sm199754pls.123.2024.02.02.12.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2024 12:23:47 -0800 (PST)
Date: Fri, 2 Feb 2024 12:23:44 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, linux-api@vger.kernel.org, brauner@kernel.org,
	davem@davemloft.net, alexander.duyck@gmail.com,
	Wei Wang <weiwan@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
Message-ID: <20240202202344.GA9283@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
 <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
 <5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
 <20240202032806.GA8708@fastly.com>
 <f0b4d813-d7cb-428b-9c41-a2d86684f3f1@intel.com>
 <20240202102239.274ca9bb@kernel.org>
 <20240202193332.GA8932@fastly.com>
 <20240202115828.6fd125bf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202115828.6fd125bf@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Fri, Feb 02, 2024 at 11:58:28AM -0800, Jakub Kicinski wrote:
> On Fri, 2 Feb 2024 11:33:33 -0800 Joe Damato wrote:
> > On Fri, Feb 02, 2024 at 10:22:39AM -0800, Jakub Kicinski wrote:
> > > On Fri, 2 Feb 2024 11:23:28 -0600 Samudrala, Sridhar wrote:  
> > > > I think you should be able to get this functionality via the netdev-genl 
> > > > API to get napi parameters. It returns ifindex as one of the parameters 
> > > > and you should able to get the name from ifindex.
> > > > 
> > > > $ ./cli.py --spec netdev.yaml --do napi-get --json='{"id": 593}'
> > > > {'id': 593, 'ifindex': 12, 'irq': 291, 'pid': 3727}  
> > > 
> > > FWIW we also have a C library to access those. Out of curiosity what's
> > > the programming language you'd use in user space, Joe?  
> > 
> > I am using C from user space. 
> 
> Ah, great! Here comes the advert.. :)
> 
>   make -C tools/net/ynl/
> 
> will generate the C lib for you. tools/net/ynl/generated/netdev-user.h
> will have the full API. There are some samples in
> tools/net/ynl/samples/. And basic info also here:
> https://docs.kernel.org/next/userspace-api/netlink/intro-specs.html#ynl-lib
> 
> You should be able to convert Sridhar's cli.py into an equivalent 
> in C in ~10 LoC.
> 
> > Curious what you think about
> > SIOCGIFNAME_BY_NAPI_ID, Jakub? I think it would be very useful, but not
> > sure if such an extension would be accepted. I can send an RFC, if you'd
> > like to take a look and consider it. I know you are busy and I don't want
> > to add too much noise to the list if I can help it :)
> 
> Nothing wrong with it in particular, but we went with the netlink API
> because all the objects are related. There are interrupts, NAPI
> instances, queues, page pools etc. and we need to show all sort of
> attributes, capabilities, stats as well as the linking. So getsockopts
> may not scale, or we'd need to create a monster mux getsockopt?
> Plus with some luck the netlink API will send you notifications of
> things changing.

Yes this all makes sense. The notification on changes would be excellent,
especially if NAPI IDs get changed for some reason  (e.g. the queue count
is adjusted or the queues are rebuilt by the driver for some reason like a
timeout, etc).

I think the issue I'm solving with SIOCGIFNAME_BY_NAPI_ID is related, but
different.

In my case, SIOCGIFNAME_BY_NAPI_ID identifies which NIC a specific fd from
accept arrived from.

AFAICT, the netlink API wouldn't be able to help me answer that question. I
could use SIOCGIFNAME_BY_NAPI_ID to tell me which NIC the fd is from and
then use netlink to figure out which CPU to bind to (for example), but I
think SIOCGIFNAME_BY_NAPI_ID is still needed.

I'll send an RFC about for that shortly, hope that's OK.

> > Here's a brief description of what I'm doing, which others might find
> > helpful:
> > 
> > 1. Machine has multiple NICs. Each NIC has 1 queue per busy poll app
> > thread, plus a few extra queues for other non busy poll usage.
> > 
> > 2. A custom RSS context is created to distribute flows to the busy poll
> > queues. This context is created for each NIC. The default context directs
> > flows to the non-busy poll queues.
> > 
> > 3. Each NIC has n-tuple filters inserted to direct incoming connections
> > with certain destination ports (e.g. 80, 443) to the custom RSS context.
> > All other incoming connections will land in the default context and go to
> > the other queues.
> > 
> > 4. IRQs for the busy poll queues are pinned to specific CPUs which are NUMA
> > local to the NIC.
> > 
> > 5. IRQ coalescing values are setup with busy poll in mind, so IRQs are
> > deferred as much as possible with the assumption userland will drive NAPI
> > via epoll_wait. This is done per queue (using ethtool --per-queue and a
> > queue mask). This is where napi_defer_hard_irqs and gro_flush_timeout
> > could help even more. IRQ deferral is only needed for the busy poll queues.
> 
> Did you see SO_PREFER_BUSY_POLL by any chance? (In combination with
> gro_flush_timeout IIRC). We added it a while back with Bjorn, it seems
> like a great idea to me at the time but I'm unclear if anyone uses it 
> in production..

I have seen it while reading the code, yes. I think maybe I missed
something about its interaction with gro_flush_timeout. In my use case,
the machine has no traffic until after the app is started.

In this case, I haven't needed to worry about regular NAPI monopolizing the
CPU and preventing busy poll from working.

Maybe I am missing something more nuanced, though? I'll have another look
at the code, just incase.

> 
> > 6. userspace app config has NICs with their NUMA local CPUs listed, for
> > example like this:
> > 
> >    - eth0: 0,1,2,3
> >    - eth1: 4,5,6,7
> > 
> > The app reads that configuration in when it starts. Ideally, these are the
> > same CPUs the IRQs are pinned to in step 4, but hopefully the coalesce
> > settings let IRQs be deferred quite a bit so busy poll can take over.
> 
> FWIW if the driver you're using annotates things right you'll also get
> the NAPI <> IRQ mapping via the netdev netlink. Hopefully that
> simplifies the pinning setup.

I looked last night after I learned about the netlink interface. It does
not look like the driver I am using does, but I can fix that fairly easily,
I think.

I'll try to send a patch for this next week.

> > 7. App threads are created and sockets are opened with REUSEPORT. Notably:
> > when the sockets are created, SO_BINDTODEVICE is used* (see below for
> > longer explanation about this).
> > 
> > 8. cbpf reusport program inserted to distribute incoming connections to
> > threads based on skb->queue_mapping. skb->queue_mapping values are not
> > unique (e.g. each NIC will have queue_mapping==0), this is why BINDTODEVICE
> > is needed. Again, see below.
> > 
> > 9. worker thread epoll contexts are set to busy poll by the ioctl I've
> > submit in my patches.
> > 
> > The first time a worker thread receives a connection, it:
> > 
> > 1. calls SO_INCOMING_NAPI_ID to get the NAPI ID associated with the
> > connection it received.
> > 
> > 2. Takes that NAPI ID and calls SIOCGIFNAME_BY_NAPI_ID to figure out which
> > NIC the connection came in on.
> > 
> > 3. Looks for an un-unsed CPU from the list it read in at configuration time
> > that is associated with that NIC and then pins itself to that CPU. That CPU
> > is removed from the list so other threads can't take it.
> > 
> > All future incoming connections with the same NAPI ID will be distributed
> > to app threads which are pinned in the appropriate place and are doing busy
> > polling.
> > 
> > So, as you can see, SIOCGIFNAME_BY_NAPI_ID makes this implementation very
> > simple.
> > 
> > I plan to eventually add some information to the kernel networking
> > documentation to capture some more details of the above, which I think
> > might be helpful for others.
> 
> Sounds very sensible & neat indeed. And makes sense to describe this 
> in the docs, that should hopefully put more people on the right path :)
> 
> > Another potential solution to avoid the above might be use an eBPF program
> > and to build a hash that maps NAPI IDs to thread IDs and write a more
> > complicated eBPF program to distribute connections that way. This seemed
> > cool, but involved a lot more work so I went with the SO_BINDTODEVICE +
> > SIOCGIFNAME_BY_NAPI_ID method instead which was pretty simple (C code wise)
> > and easy to implement.
> 
> Interesting!

