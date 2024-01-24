Return-Path: <linux-kernel+bounces-37236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B73183AD2B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C597AB2C3BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A730A7C09F;
	Wed, 24 Jan 2024 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Jv4x0F0g"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9BB77F33
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109588; cv=none; b=f/6DsCJXJSZRRuHjR4kSyEyvcWjEGspG4DY+1IBot69fkaWzq0DkHqX3dfin7HETSDgXMmTvgI6qsXqjVqRTUEQZCJqeMxP7a0z/XEm510sZjNP5GVMRWnC+radVkb9kFxp5qDGBh7eEzNThioAV1N9Tr/9qCOB1woYnJJHm3pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109588; c=relaxed/simple;
	bh=OIusJLxhbXxmyhNGE3F6m6Lh/80U12JwHeDjWP3XY3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8CAXb167PGWWKJTLSp9VACXDoeoG4OUL3foMI1xUpt0qD0Eur5SlLBDY0v6PdaUQBQd95Rq2Vk4czYEeDHuBGDglEcONSLR2Y96xa1PdMKez96cpFy5mM8GBb05RSe9Dm7brEoVWgHv/SzA+jSVt/eF3Nz/n2W4YD2jNUh8tlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Jv4x0F0g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d731314e67so19040255ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706109586; x=1706714386; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GCPTIfro7gjKwSczT715QvfI3dAQ+k5lX6+XNUimdv4=;
        b=Jv4x0F0gAn2ZAubQjaDcY95+9yt9UUUTKgBXbDVpxv3rcQKBcwYG7JVNXbCNiHI17B
         SH1bx4+pNBMsYK8QznFiBPFUIG13UQ+DDv0swfu8X3G2uFk4K09xvdT7CwGgD6+hKaCv
         Aaq8RP/iBEJVBMOlQX6ZQfoEWaMSYOWeKGCsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706109586; x=1706714386;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCPTIfro7gjKwSczT715QvfI3dAQ+k5lX6+XNUimdv4=;
        b=BPMSHMhcgStLjbBgnjXE9WfPEjGWdDJAu7SdildZxlcEqWM0CWWpgpnpWEo1gnUd25
         jOLsttmilcGARiL3m0NDZYdxuiKB7r81wqcLgd9NoNknEb+644omvS7xfz9zBR9hLliN
         rpZO+jMQd9l0k7bjAG7l3sMG5CSaQGW8Q+i8wMZX/f5Qy6I85zeA0qqR6VnfeoOu/glv
         Zx7ePC+RzN3K6Cy4d2MZZyX42uxLhZiZxIqP/9Hfq+Y5aHhICFLffn4vbzSXlXBPiBE1
         g5qgNrEo1rQsXKc1rok/2pkDVU24VF2bqm7FuO9/n0RPWFNj7OUthvBJWpniwgXzwKr7
         pJVQ==
X-Gm-Message-State: AOJu0YxWVHuDvB8bDj5WG3rGlB4lFr51LJYPPSFF8b6WFFioPzdWUGeJ
	uZonVdcBX5NxH77lUtBc3creTU5cqYsnokoYycE0WGK8LKXB7sv2g983lgbRTR8=
X-Google-Smtp-Source: AGHT+IFA6eRfCnUa7nllifPe0kGwNy09ZT1EBgLxXjqWc/wnwS38sfPlHpqeDvHgeYXekHXe/mN89Q==
X-Received: by 2002:a17:903:41d2:b0:1d7:2279:15e9 with SMTP id u18-20020a17090341d200b001d7227915e9mr913512ple.122.1706109586064;
        Wed, 24 Jan 2024 07:19:46 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id jf7-20020a170903268700b001d76b1029c6sm3132620plb.2.2024.01.24.07.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2024 07:19:45 -0800 (PST)
Date: Wed, 24 Jan 2024 07:19:43 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
	alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
	kuba@kernel.org, Wei Wang <weiwan@google.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
Message-ID: <20240124151942.GA6565@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
 <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
 <20240124142008.GA1448@fastly.com>
 <CANn89i+UiCRpu6M-hDga=dSTk1F5MjkgV=kKS6zC31pvOh78DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+UiCRpu6M-hDga=dSTk1F5MjkgV=kKS6zC31pvOh78DQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Jan 24, 2024 at 03:38:19PM +0100, Eric Dumazet wrote:
> On Wed, Jan 24, 2024 at 3:20 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Wed, Jan 24, 2024 at 09:20:09AM +0100, Eric Dumazet wrote:
> > > On Wed, Jan 24, 2024 at 3:54 AM Joe Damato <jdamato@fastly.com> wrote:
> > > >
> > > > Greetings:
> > > >
> > > > TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support to
> > > > epoll with socket fds.") by allowing user applications to enable
> > > > epoll-based busy polling and set a busy poll packet budget on a per epoll
> > > > context basis.
> > > >
> > > > To allow for this, two ioctls have been added for epoll contexts for
> > > > getting and setting a new struct, struct epoll_params.
> > > >
> > > > This makes epoll-based busy polling much more usable for user
> > > > applications than the current system-wide sysctl and hardcoded budget.
> > > >
> > > > Longer explanation:
> > > >
> > > > Presently epoll has support for a very useful form of busy poll based on
> > > > the incoming NAPI ID (see also: SO_INCOMING_NAPI_ID [1]).
> > > >
> > > > This form of busy poll allows epoll_wait to drive NAPI packet processing
> > > > which allows for a few interesting user application designs which can
> > > > reduce latency and also potentially improve L2/L3 cache hit rates by
> > > > deferring NAPI until userland has finished its work.
> > > >
> > > > The documentation available on this is, IMHO, a bit confusing so please
> > > > allow me to explain how one might use this:
> > > >
> > > > 1. Ensure each application thread has its own epoll instance mapping
> > > > 1-to-1 with NIC RX queues. An n-tuple filter would likely be used to
> > > > direct connections with specific dest ports to these queues.
> > > >
> > > > 2. Optionally: Setup IRQ coalescing for the NIC RX queues where busy
> > > > polling will occur. This can help avoid the userland app from being
> > > > pre-empted by a hard IRQ while userland is running. Note this means that
> > > > userland must take care to call epoll_wait and not take too long in
> > > > userland since it now drives NAPI via epoll_wait.
> > > >
> > > > 3. Ensure that all incoming connections added to an epoll instance
> > > > have the same NAPI ID. This can be done with a BPF filter when
> > > > SO_REUSEPORT is used or getsockopt + SO_INCOMING_NAPI_ID when a single
> > > > accept thread is used which dispatches incoming connections to threads.
> > > >
> > > > 4. Lastly, busy poll must be enabled via a sysctl
> > > > (/proc/sys/net/core/busy_poll).
> > > >
> > > > The unfortunate part about step 4 above is that this enables busy poll
> > > > system-wide which affects all user applications on the system,
> > > > including epoll-based network applications which were not intended to
> > > > be used this way or applications where increased CPU usage for lower
> > > > latency network processing is unnecessary or not desirable.
> > > >
> > > > If the user wants to run one low latency epoll-based server application
> > > > with epoll-based busy poll, but would like to run the rest of the
> > > > applications on the system (which may also use epoll) without busy poll,
> > > > this system-wide sysctl presents a significant problem.
> > > >
> > > > This change preserves the system-wide sysctl, but adds a mechanism (via
> > > > ioctl) to enable or disable busy poll for epoll contexts as needed by
> > > > individual applications, making epoll-based busy poll more usable.
> > > >
> > >
> > > I think this description missed the napi_defer_hard_irqs and
> > > gro_flush_timeout settings ?
> >
> > I'm not sure if those settings are strictly related to the change I am
> > proposing which makes epoll-based busy poll something that can be
> > enabled/disabled on a per-epoll context basis and allows the budget to be
> > set as well, but maybe I am missing something? Sorry for my
> > misunderstanding if so.
> >
> > IMHO: a single system-wide busy poll setting is difficult to use
> > properly and it is unforunate that the packet budget is hardcoded. It would
> > be extremely useful to be able to set both of these on a per-epoll basis
> > and I think my suggested change helps to solve this.
> >
> > Please let me know.
> >
> > Re the two settings you noted:
> >
> > I didn't mention those in the interest of brevity, but yes they can be used
> > instead of or in addition to what I've described above.
> >
> > While those settings are very useful, IMHO, they have their own issues
> > because they are system-wide as well. If they were settable per-NAPI, that
> > would make it much easier to use them because they could be enabled for the
> > NAPIs which are being busy-polled by applications that support busy-poll.
> >
> > Imagine you have 3 types of apps running side-by-side:
> >   - A low latency epoll-based busy poll app,
> >   - An app where latency doesn't matter as much, and
> >   - A latency sensitive legacy app which does not yet support epoll-based
> >     busy poll.
> >
> > In the first two cases, the settings you mention would be helpful or not
> > make any difference, but in the third case the system-wide impact might be
> > undesirable because having IRQs fire might be important to keep latency
> > down.
> >
> > If your comment was more that my cover letter should have mentioned these,
> > I can include that in a future cover letter or suggest some kernel
> > documentation which will discuss all of these features and how they relate
> > to each other.
> >
> > >
> > > I would think that if an application really wants to make sure its
> > > thread is the only one
> > > eventually calling napi->poll(), we must make sure NIC interrupts stay masked.
> > >
> > > Current implementations of busy poll always release NAPI_STATE_SCHED bit when
> > > returning to user space.
> > >
> > > It seems you want to make sure the application and only the
> > > application calls the napi->poll()
> > > at chosen times.
> > >
> > > Some kind of contract is needed, and the presence of the hrtimer
> > > (currently only driven from dev->@gro_flush_timeout)
> > > would allow to do that correctly.
> > >
> > > Whenever we 'trust' user space to perform the napi->poll shortly, we
> > > also want to arm the hrtimer to eventually detect
> > > the application took too long, to restart the other mechanisms (NIC irq based)
> >
> > There is another change [1] I've been looking at from a research paper [2]
> > which does something similar to what you've described above -- it keeps
> > IRQs suppressed during busy polling. The paper suggests a performance
> > improvement is measured when using a mechanism like this to keep IRQs off.
> > Please see the paper for more details.
> >
> > I haven't had a chance to reach out to the authors or to tweak this patch
> > to attempt an RFC / submission for it, but it seems fairly promising in my
> > initial synthetic tests.
> >
> > When I tested their patch, as you might expect, no IRQs were generated at
> > all for the NAPIs that were being busy polled, but the rest of the
> > NAPIs and queues were generating IRQs as expected.
> >
> > Regardless of the above patch: I think my proposed change is helpful and
> > the IRQ suppression bit can be handled in a separate change in the future.
> > What do you think?
> >
> > > Note that we added the kthread based napi polling, and we are working
> > > to add a busy polling feature to these kthreads.
> > > allowing to completely mask NIC interrupts and further reduce latencies.
> >
> > I am aware of kthread based NAPI polling, yes, but I was not aware that
> > busy polling was being considered as a feature for them, thanks for the
> > head's up.
> >
> > > Thank you
> >
> > Thanks for your comments - I appreciate your time and attention.
> >
> > Could you let me know if your comments are meant as a n-ack or similar?
> 
> Patch #2 needs the 'why' part, and why would we allow user space to
> ask to poll up to 65535 packets...
> There is a reason we have a warning in place when a driver attempts to
> set a budget bigger than 64.

Sure, thanks for pointing this out.

I am happy to cap the budget to 64 if a user app requests a larger amount
and I can add a netdev_warn when this happens, if you'd like.

The 'why' has two reasons:
  - Increasing the budget for fast NICs can help improve throughput
    under load (i.e. the hardcoded amount might be too low for some users)
  - other poll methods have user-configurable budget amounts
    (SO_BUSY_POLL_BUDGET), so epoll stands out as an edge case where the
    budget is hardcoded.

I hope that reasoning is sufficient and I can include that more explicitly
in the commit message.

FWIW: My reading of SO_BUSY_POLL_BUDGET suggests that any budget amount
up to U16_MAX will be accepted. I probably missed it somewhere, but I
didn't see a warning in this case.

I think in a v2 SO_BUSY_POLL_BUDGET and the epoll ioctl budget should
be capped at the same amount for consistency and I am happy to agree to 64
or 128 or similar as a cap.

Let me know what you think and thanks again for your thoughts and detailed
response.

> You cited recent papers,  I wrote this one specific to linux busy
> polling ( https://netdevconf.info/2.1/papers/BusyPollingNextGen.pdf )

Thanks for sending this link, I'll need to take a closer look, but a quick
read surfaced two things:

  Their use is very limited, since they enforce busy polling
  for all sockets, which is not desirable

We agree on the limited usefulness of system-wide settings ;)

  Another big problem is that Busy Polling was not really
  deployed in production, because it works well when having
  no more than one thread per NIC RX queue.

I've been testing epoll-based busy poll in production with a few different
NICs and application setups and it has been pretty helpful, but I agree
that this is application architecture specific as you allude to in
your next paragraph about the scheduler.

Thanks for linking to the paper.

It would be great if all of this context and information could be put in
one place in the kernel docs. If I have time in the future, I'll propose a
doc change to try to outline all of this.

> Busy polling had been in the pipe, when Wei sent her patches and follow ups.
> 
> cb038357937ee4f589aab2469ec3896dce90f317 net: fix race between napi
> kthread mode and busy poll
> 5fdd2f0e5c64846bf3066689b73fc3b8dddd1c74 net: add sysfs attribute to
> control napi threaded mode
> 29863d41bb6e1d969c62fdb15b0961806942960e net: implement threaded-able
> napi poll loop support

Thanks for letting me know. I think I'd seen these in passing, but hadn't
remembered until you mentioned it now.

> I am saying that I am currently working to implement the kthread busy
> polling implementation,
> after fixing two bugs in SCTP and UDP (making me wondering if busy
> polling is really used these days)

Ah, I see. FWIW, I have so far only been trying to use it for TCP and so
far I haven't hit any bugs.

I was planning to use it with UDP in the future, though, once the TCP
epoll-based busy polling stuff I am working on is done... so thanks in
advance for the bug fixes in UDP.

> I am also considering unifying napi_threaded_poll() and the
> napi_busy_loop(), and seeing your patches
> coming make this work more challenging.

Sorry about that. I am happy to make modifications to my patches if there's
anything I could do which would make your work easier in the future.

Thanks,
Joe

