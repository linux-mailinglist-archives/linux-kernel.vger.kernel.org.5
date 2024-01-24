Return-Path: <linux-kernel+bounces-37193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95C483AC72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55EC91F22093
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446FC86AF2;
	Wed, 24 Jan 2024 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2reVHgE9"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167A2F26
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107115; cv=none; b=qM3E4kwJ1E0WK+DckQGug79puDlBeSRSMW2+X+Or/3PsA387ofRDpRbKTADn5ebwdekIqolY/AewdL4MfULA/c7kOXVWgxSauJxuN7jO+naBUZlxmHsUVxgkxPo7tlCUxas2+1f0gNH1U+E20mm6JsoIkC09Z94OYh+8mfK7iAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107115; c=relaxed/simple;
	bh=ZbWnbtWyoZNqnhXQdjvsYNKzRaoSAHCPcpKDwFaElw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bp2eR6sCv9+BQ51HaGml9smiWsSFAe5DgHJ2jzroGDZB9cOojfajcRd2zvaB3QgdaM4hR1o6L4U1x/kqevSUxe5baBu5wXbHR3sAuuoB1f4jbFqV0SlaSOmHQ9NVPAO14/LwvsJp67eAuMjaCfHET5j0OaL2o2BiMai5f9vtCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2reVHgE9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso16560a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706107111; x=1706711911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI2XazdUmRYBQ7l9aiPWaZwPS0yDwP9OAgAwE0uydxY=;
        b=2reVHgE9PJsGyXtbeT7vRZdPGvES5S7VRUcjOjcb3uA3l1AmZiU1VQnjP8owg/2Z0R
         AQ7ALNme6SALYD1gznY8EpP3Ezrf3lPAQm22s1/MhuEQc0rXkVICMOSNwJS6XXlRwi1R
         l+eMMJkx7J+bRll6QkpBLjIyjQ2k5FI+VfmXOOgDACVVtof4M5JUsN6rrKXxchh6aHo5
         DwHkb0wu/XPzWo4c59N472fOmtFnwlT1J6TKr5nIh6rEpFtOMfT7UUg059t474v4qPqr
         3wA2exdgy+sVCYtggk5po0CoCy61Csoywbl1ZNOlNxJYsOvcSCLbJi405gwKZ0oaU6nO
         /Tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706107111; x=1706711911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OI2XazdUmRYBQ7l9aiPWaZwPS0yDwP9OAgAwE0uydxY=;
        b=FYNwVydAEH6iGs+jvQQcFuQtWY68EyY8gP3v5r3cj4A36/4KfnAEHgH+IYfOa4aNfQ
         +fHask101S9FxIzPX+JP/xeR3QgcTgbibJMDyLQEs1rxCqstpPkMG4/nuUZHjuXrySaq
         jT/QrgJz1y7iBlbkIr8iSMce06iAX65DJawefj/5Mf5XV3J9ZzB8w++gKFtNeg5qvNt7
         wP6GvBJZ0nJUGv9BFACL28AKjSwJxxwztSTskgcJTj/zQmAJezD+fPHD9TCwnOEODxwO
         68e3DYLwy3xN9DYlX85qMMm4pUQgeTFwX2Ux4SNfP3I1X/Qb/Cd49rqRXLqWB6+wHnnW
         NL1w==
X-Gm-Message-State: AOJu0Yw6LrLPUPBvWZg32UO0NtA2FV1Zc6+7m8tGNjeW1rp+Ccso/QTl
	zhN7C6zh7Y9zmsEK+fpOlj8PyL+gts0kGyHAlhL4KgpXC1nHktws19hpoAARPpUCZruy7GuHNTz
	pkn1I0W+QkV/8Phu1ujwc5CHoqfKHjWdySpwe
X-Google-Smtp-Source: AGHT+IHBWDLFccGGTaeb6uzn1TbCnzo4W4c2GRN7GYO+V1E8Vx4O3nM/NfI/MJil/T6GysJT0LuX6AJT6DGkR7Ha274=
X-Received: by 2002:a05:6402:b88:b0:55a:7f4e:1d62 with SMTP id
 cf8-20020a0564020b8800b0055a7f4e1d62mr166510edb.4.1706107111056; Wed, 24 Jan
 2024 06:38:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124025359.11419-1-jdamato@fastly.com> <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
 <20240124142008.GA1448@fastly.com>
In-Reply-To: <20240124142008.GA1448@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jan 2024 15:38:19 +0100
Message-ID: <CANn89i+UiCRpu6M-hDga=dSTk1F5MjkgV=kKS6zC31pvOh78DQ@mail.gmail.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org, 
	brauner@kernel.org, davem@davemloft.net, alexander.duyck@gmail.com, 
	sridhar.samudrala@intel.com, kuba@kernel.org, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 3:20=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Wed, Jan 24, 2024 at 09:20:09AM +0100, Eric Dumazet wrote:
> > On Wed, Jan 24, 2024 at 3:54=E2=80=AFAM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> > > Greetings:
> > >
> > > TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll suppo=
rt to
> > > epoll with socket fds.") by allowing user applications to enable
> > > epoll-based busy polling and set a busy poll packet budget on a per e=
poll
> > > context basis.
> > >
> > > To allow for this, two ioctls have been added for epoll contexts for
> > > getting and setting a new struct, struct epoll_params.
> > >
> > > This makes epoll-based busy polling much more usable for user
> > > applications than the current system-wide sysctl and hardcoded budget=
.
> > >
> > > Longer explanation:
> > >
> > > Presently epoll has support for a very useful form of busy poll based=
 on
> > > the incoming NAPI ID (see also: SO_INCOMING_NAPI_ID [1]).
> > >
> > > This form of busy poll allows epoll_wait to drive NAPI packet process=
ing
> > > which allows for a few interesting user application designs which can
> > > reduce latency and also potentially improve L2/L3 cache hit rates by
> > > deferring NAPI until userland has finished its work.
> > >
> > > The documentation available on this is, IMHO, a bit confusing so plea=
se
> > > allow me to explain how one might use this:
> > >
> > > 1. Ensure each application thread has its own epoll instance mapping
> > > 1-to-1 with NIC RX queues. An n-tuple filter would likely be used to
> > > direct connections with specific dest ports to these queues.
> > >
> > > 2. Optionally: Setup IRQ coalescing for the NIC RX queues where busy
> > > polling will occur. This can help avoid the userland app from being
> > > pre-empted by a hard IRQ while userland is running. Note this means t=
hat
> > > userland must take care to call epoll_wait and not take too long in
> > > userland since it now drives NAPI via epoll_wait.
> > >
> > > 3. Ensure that all incoming connections added to an epoll instance
> > > have the same NAPI ID. This can be done with a BPF filter when
> > > SO_REUSEPORT is used or getsockopt + SO_INCOMING_NAPI_ID when a singl=
e
> > > accept thread is used which dispatches incoming connections to thread=
s.
> > >
> > > 4. Lastly, busy poll must be enabled via a sysctl
> > > (/proc/sys/net/core/busy_poll).
> > >
> > > The unfortunate part about step 4 above is that this enables busy pol=
l
> > > system-wide which affects all user applications on the system,
> > > including epoll-based network applications which were not intended to
> > > be used this way or applications where increased CPU usage for lower
> > > latency network processing is unnecessary or not desirable.
> > >
> > > If the user wants to run one low latency epoll-based server applicati=
on
> > > with epoll-based busy poll, but would like to run the rest of the
> > > applications on the system (which may also use epoll) without busy po=
ll,
> > > this system-wide sysctl presents a significant problem.
> > >
> > > This change preserves the system-wide sysctl, but adds a mechanism (v=
ia
> > > ioctl) to enable or disable busy poll for epoll contexts as needed by
> > > individual applications, making epoll-based busy poll more usable.
> > >
> >
> > I think this description missed the napi_defer_hard_irqs and
> > gro_flush_timeout settings ?
>
> I'm not sure if those settings are strictly related to the change I am
> proposing which makes epoll-based busy poll something that can be
> enabled/disabled on a per-epoll context basis and allows the budget to be
> set as well, but maybe I am missing something? Sorry for my
> misunderstanding if so.
>
> IMHO: a single system-wide busy poll setting is difficult to use
> properly and it is unforunate that the packet budget is hardcoded. It wou=
ld
> be extremely useful to be able to set both of these on a per-epoll basis
> and I think my suggested change helps to solve this.
>
> Please let me know.
>
> Re the two settings you noted:
>
> I didn't mention those in the interest of brevity, but yes they can be us=
ed
> instead of or in addition to what I've described above.
>
> While those settings are very useful, IMHO, they have their own issues
> because they are system-wide as well. If they were settable per-NAPI, tha=
t
> would make it much easier to use them because they could be enabled for t=
he
> NAPIs which are being busy-polled by applications that support busy-poll.
>
> Imagine you have 3 types of apps running side-by-side:
>   - A low latency epoll-based busy poll app,
>   - An app where latency doesn't matter as much, and
>   - A latency sensitive legacy app which does not yet support epoll-based
>     busy poll.
>
> In the first two cases, the settings you mention would be helpful or not
> make any difference, but in the third case the system-wide impact might b=
e
> undesirable because having IRQs fire might be important to keep latency
> down.
>
> If your comment was more that my cover letter should have mentioned these=
,
> I can include that in a future cover letter or suggest some kernel
> documentation which will discuss all of these features and how they relat=
e
> to each other.
>
> >
> > I would think that if an application really wants to make sure its
> > thread is the only one
> > eventually calling napi->poll(), we must make sure NIC interrupts stay =
masked.
> >
> > Current implementations of busy poll always release NAPI_STATE_SCHED bi=
t when
> > returning to user space.
> >
> > It seems you want to make sure the application and only the
> > application calls the napi->poll()
> > at chosen times.
> >
> > Some kind of contract is needed, and the presence of the hrtimer
> > (currently only driven from dev->@gro_flush_timeout)
> > would allow to do that correctly.
> >
> > Whenever we 'trust' user space to perform the napi->poll shortly, we
> > also want to arm the hrtimer to eventually detect
> > the application took too long, to restart the other mechanisms (NIC irq=
 based)
>
> There is another change [1] I've been looking at from a research paper [2=
]
> which does something similar to what you've described above -- it keeps
> IRQs suppressed during busy polling. The paper suggests a performance
> improvement is measured when using a mechanism like this to keep IRQs off=
.
> Please see the paper for more details.
>
> I haven't had a chance to reach out to the authors or to tweak this patch
> to attempt an RFC / submission for it, but it seems fairly promising in m=
y
> initial synthetic tests.
>
> When I tested their patch, as you might expect, no IRQs were generated at
> all for the NAPIs that were being busy polled, but the rest of the
> NAPIs and queues were generating IRQs as expected.
>
> Regardless of the above patch: I think my proposed change is helpful and
> the IRQ suppression bit can be handled in a separate change in the future=
.
> What do you think?
>
> > Note that we added the kthread based napi polling, and we are working
> > to add a busy polling feature to these kthreads.
> > allowing to completely mask NIC interrupts and further reduce latencies=
.
>
> I am aware of kthread based NAPI polling, yes, but I was not aware that
> busy polling was being considered as a feature for them, thanks for the
> head's up.
>
> > Thank you
>
> Thanks for your comments - I appreciate your time and attention.
>
> Could you let me know if your comments are meant as a n-ack or similar?

Patch #2 needs the 'why' part, and why would we allow user space to
ask to poll up to 65535 packets...
There is a reason we have a warning in place when a driver attempts to
set a budget bigger than 64.

You cited recent papers,  I wrote this one specific to linux busy
polling ( https://netdevconf.info/2.1/papers/BusyPollingNextGen.pdf )

Busy polling had been in the pipe, when Wei sent her patches and follow ups=
.

cb038357937ee4f589aab2469ec3896dce90f317 net: fix race between napi
kthread mode and busy poll
5fdd2f0e5c64846bf3066689b73fc3b8dddd1c74 net: add sysfs attribute to
control napi threaded mode
29863d41bb6e1d969c62fdb15b0961806942960e net: implement threaded-able
napi poll loop support

I am saying that I am currently working to implement the kthread busy
polling implementation,
after fixing two bugs in SCTP and UDP (making me wondering if busy
polling is really used these days)

I am also considering unifying napi_threaded_poll() and the
napi_busy_loop(), and seeing your patches
coming make this work more challenging.

