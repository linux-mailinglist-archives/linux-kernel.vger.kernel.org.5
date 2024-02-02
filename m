Return-Path: <linux-kernel+bounces-49147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E10846685
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F8D1C26BC8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07055D313;
	Fri,  2 Feb 2024 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kLsPps1E"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6139EEAF2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706844493; cv=none; b=L4PejwS37nffbz5CeKWjhWMOCq+Gh2B0ZsQcXNc2B72KQdLg27OUZx/mGDxqlhlQEPe/86+iSSdhLegqrkyFXRBUvhE+H/BugPoPCqOQOoc9bG5gogEZm8Tqt3m/44Gnx6sN8mdNait+P0SZcgDjCaIde14jld9a3IFzJ9RyoQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706844493; c=relaxed/simple;
	bh=tRsSz0rRGQGEurlNUDrfhHIIFpo2AzDD0v9zjA3NQHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNpOWE77ICvs5tSn+bK/YGshf0Zk2np3hi7Kc5uBmuRBpBsq2yRvCV22FPSJWOt9vYG98j7zwipMCqn6rxpCrij7wVsslxOnJCWvTMAFyuQ1PPaJttl+Z8jHrddnR7lqdiIxAszlTjETMxKWy7QaGo1iE3b14Tgtg344rJat9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kLsPps1E; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7881b1843so13900895ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 19:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706844491; x=1707449291; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfF4/s9dcpinrBOfbHzFC1zqyW5aEfZvc1NtOczCj0U=;
        b=kLsPps1ErIzsvaqGg5DraR+HHXd6GzlmvgpnnYOn4fExgH5VbpgsQspjRm3Af+0x+0
         kTo9EisynNWzjUtoVCMT/0GM9dNYD8YbYSMQ+rIUmG7/OnqeJ2AJPlZQ2Cr4ed2c3Lcs
         51KlUBfSwETLf85psFR7gk37zDSgYAp8uP6v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706844491; x=1707449291;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfF4/s9dcpinrBOfbHzFC1zqyW5aEfZvc1NtOczCj0U=;
        b=eBp3sKXzQPxc1EiHrqlvHqBC7p1JHrpdxboUg64Bk6lT7+qQ4R5Pfl38At+jFRL921
         4AdsQxJzd9xzPmcqERPLX9ZTXyNext4plLsvL/zri2ZZhdKinGy7TuinjAIijW+uZIZA
         IzlaFYEOebLNQ9jdrxYblOzpE0MKF47SZ2uypCEzVzxuLsCxtlVtWKIBZl2HPusBxIHC
         oXUZ/BFm4D8hHyEvrK8/mPfcAjDBviXfaASCFj/xyBVKDSCYum+PnCDNNQFigyIIr1ss
         auTM0sBP90vcJ+vhzrqqn0mAgGgIB4SnIT+Oz5Rrq26jBuYLdK6ZwnzoGfbm2SoU0J9T
         EVnQ==
X-Gm-Message-State: AOJu0Ywz4Jdgn9nwcZM3gn/Y3MFQOugrY5Fdx+WJDKJf7yfB3Hl1wZ/C
	2muFPQBgmaqWf5dtkss6Nz8JGJAlR+hwOL+0OO96lBjOuxWAf/UBYU0DIzIorEU=
X-Google-Smtp-Source: AGHT+IEDDqwj2U559sryBjaL/MexHTgUqHLuC2vNU8AmZ7xKqpKvYdvTBaNe2TTPjNNOHcqlAx7eGg==
X-Received: by 2002:a17:902:e812:b0:1d8:fb17:a1fe with SMTP id u18-20020a170902e81200b001d8fb17a1femr1210673plg.48.1706844490595;
        Thu, 01 Feb 2024 19:28:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW47KZ1SfG40xqflewdxwUw3bVZfHLvv+EKuax55tIOa8B2y1KX4ptYyUNOyE2hvPLjlffr9yJXKXyp/PUXL/Xp+AUyCcm1a2Ods6KudB4WOTol/zmG/6BeJHGdMeJTJ2G3lZr6f4GkanMbD1baOao/plBvBiOGULGv4umGBIw4WHFXqYqqiHqFw0gCa62AX/YmCtX4tbrVNX7KXbSp4t2RWWZhmSKwfeHclrEk/3OK6krCwRcZHTQyGkrcK9ZkMgcpu8fgZJcjnqd/u6RePY5GeIy8LSoAvYwDzK5qLbC1Juh1iB3JtCxGte89ToEkzkCcJxtRFjaKT+1B2H13d/tzBoxLKeu6Fh4UJUuvmGr+uWw/3swMRdmAIMryw3bL5F/9xHiCm4Uwu7B4RQcgXA==
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902eb0500b001d8f81ecea1sm538319plb.172.2024.02.01.19.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2024 19:28:09 -0800 (PST)
Date: Thu, 1 Feb 2024 19:28:07 -0800
From: Joe Damato <jdamato@fastly.com>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, linux-api@vger.kernel.org, brauner@kernel.org,
	davem@davemloft.net, alexander.duyck@gmail.com, kuba@kernel.org,
	Wei Wang <weiwan@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
Message-ID: <20240202032806.GA8708@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
 <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
 <5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Tue, Jan 30, 2024 at 12:54:50PM -0600, Samudrala, Sridhar wrote:
> 
> 
> On 1/24/2024 2:20 AM, Eric Dumazet wrote:
> >On Wed, Jan 24, 2024 at 3:54 AM Joe Damato <jdamato@fastly.com> wrote:
> >>
> >>Greetings:
> >>
> >>TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support to
> >>epoll with socket fds.") by allowing user applications to enable
> >>epoll-based busy polling and set a busy poll packet budget on a per epoll
> >>context basis.
> >>
> >>To allow for this, two ioctls have been added for epoll contexts for
> >>getting and setting a new struct, struct epoll_params.
> >>
> >>This makes epoll-based busy polling much more usable for user
> >>applications than the current system-wide sysctl and hardcoded budget.
> 
> Agree. looking forward to see this patch series accepted soon.
> 
> >>
> >>Longer explanation:
> >>
> >>Presently epoll has support for a very useful form of busy poll based on
> >>the incoming NAPI ID (see also: SO_INCOMING_NAPI_ID [1]).
> >>
> >>This form of busy poll allows epoll_wait to drive NAPI packet processing
> >>which allows for a few interesting user application designs which can
> >>reduce latency and also potentially improve L2/L3 cache hit rates by
> >>deferring NAPI until userland has finished its work.
> >>
> >>The documentation available on this is, IMHO, a bit confusing so please
> >>allow me to explain how one might use this:
> >>
> >>1. Ensure each application thread has its own epoll instance mapping
> >>1-to-1 with NIC RX queues. An n-tuple filter would likely be used to
> >>direct connections with specific dest ports to these queues.
> >>
> >>2. Optionally: Setup IRQ coalescing for the NIC RX queues where busy
> >>polling will occur. This can help avoid the userland app from being
> >>pre-empted by a hard IRQ while userland is running. Note this means that
> >>userland must take care to call epoll_wait and not take too long in
> >>userland since it now drives NAPI via epoll_wait.
> >>
> >>3. Ensure that all incoming connections added to an epoll instance
> >>have the same NAPI ID. This can be done with a BPF filter when
> >>SO_REUSEPORT is used or getsockopt + SO_INCOMING_NAPI_ID when a single
> >>accept thread is used which dispatches incoming connections to threads.
> >>
> >>4. Lastly, busy poll must be enabled via a sysctl
> >>(/proc/sys/net/core/busy_poll).
> >>
> >>The unfortunate part about step 4 above is that this enables busy poll
> >>system-wide which affects all user applications on the system,
> >>including epoll-based network applications which were not intended to
> >>be used this way or applications where increased CPU usage for lower
> >>latency network processing is unnecessary or not desirable.
> >>
> >>If the user wants to run one low latency epoll-based server application
> >>with epoll-based busy poll, but would like to run the rest of the
> >>applications on the system (which may also use epoll) without busy poll,
> >>this system-wide sysctl presents a significant problem.
> >>
> >>This change preserves the system-wide sysctl, but adds a mechanism (via
> >>ioctl) to enable or disable busy poll for epoll contexts as needed by
> >>individual applications, making epoll-based busy poll more usable.
> >>
> >
> >I think this description missed the napi_defer_hard_irqs and
> >gro_flush_timeout settings ?
> >
> >I would think that if an application really wants to make sure its
> >thread is the only one
> >eventually calling napi->poll(), we must make sure NIC interrupts stay masked.
> >
> >Current implementations of busy poll always release NAPI_STATE_SCHED bit when
> >returning to user space.
> >
> >It seems you want to make sure the application and only the
> >application calls the napi->poll()
> >at chosen times.
> >
> >Some kind of contract is needed, and the presence of the hrtimer
> >(currently only driven from dev->@gro_flush_timeout)
> >would allow to do that correctly.
> >
> >Whenever we 'trust' user space to perform the napi->poll shortly, we
> >also want to arm the hrtimer to eventually detect
> >the application took too long, to restart the other mechanisms (NIC irq based)
> >
> >Note that we added the kthread based napi polling, and we are working
> >to add a busy polling feature to these kthreads.
> >allowing to completely mask NIC interrupts and further reduce latencies.
> 
> 
> Good to know that you are looking into enabling busy polling for napi
> kthreads.
> We have something similar in our ice OOT driver that is implemented and we
> call it 'independent pollers' as in this mode, busy polling will not be app
> dependent or triggered by an application.
> Here is a link to the slides we presented at netdev 0x16 driver workshop.
> https://netdevconf.info/0x16/slides/48/netdev0x16_driver_workshop_ADQ.pdf
> 
> We haven't yet submitted the patches upstream as there is no kernel
> interface to configure napi specific timeouts.
> With the recent per-queue and per-napi netlink APIs that are accepted
> upstream
> https://lore.kernel.org/netdev/170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com/
> 
> we are thinking of making timeout as a per-napi parameter and can be used as
> an interface to enable napi kthread based busy polling.

I know I am replying to a stale thread on the patches I've submit (there is
a v5 now [1]), but I just looked at your message - sorry I didn't reply
sooner.

The per-queue and per-napi netlink APIs look extremely useful, thanks for
pointing this out.

In my development tree, I had added SIOCGIFNAME_BY_NAPI_ID which works
similar to SIOCGIFNAME: it takes a NAPI ID and returns the IF name. This is
useful on machines with multiple NICs where each NIC could be located in
one of many different NUMA zones.

The idea was that apps would use SO_INCOMING_NAPI_ID, distribute the NAPI
ID to a worker thread which could then use SIOCGIFNAME_BY_NAPI_ID to
compute which NIC the connection came in on. The app would then (via
configuration) know where to pin that worker thread; ideally somewhere NUMA
local to the NIC.

I had assumed that such a change would be rejected, but I figured I'd send
an RFC for it after the per epoll context stuff was done and see if anyone
thought SIOCGIFNAME_BY_NAPI_ID would be useful for them, as well.

> I think even the per-device napi_defer_hard_irqs and gro_flush_timeout
> should become per-napi parameters.

I agree.

I had been contemplating implementing this until I tried a different method
similar to an academic paper I was reading [2][3]. I think per-device
defer_hard_irqs and gro_flush_timeout would be extremely useful and a
better approach than the one I'm currently using.

Is this something you are currently working? I may try implementing this,
but didn't want to duplicate effort if you are already working on this.

Thanks,
Joe

[1]: https://lore.kernel.org/all/20240131180811.23566-1-jdamato@fastly.com/
[2]: https://dl.acm.org/doi/pdf/10.1145/3626780
[3]: https://gitlab.uwaterloo.ca/p5cai/netstack-exp/-/blob/master/kernel-polling-5.15.79-base.patch?ref_type=heads

