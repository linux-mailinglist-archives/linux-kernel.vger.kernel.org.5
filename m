Return-Path: <linux-kernel+bounces-37099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB82C83AB86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7554C282F48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FFD7A72A;
	Wed, 24 Jan 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="cNG4crII"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8B7A708
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106014; cv=none; b=a1EvBrWIcb3q9U603LCYjE1DdQWhIv4JgrMLAdkPWr7XNl6KAs+Q1s4iwdo/doDq17wajLiJ7e8UAEUz8FcsEHT24h8jceV41xH3PpVHHQ+a2vRSRiMwjLdzg8Tz81F6sM1DWYsNk0b6N2J6HVFOh2Oe/T2vbMceDwBZUqBEGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106014; c=relaxed/simple;
	bh=32ajrXEpJCpzfiURjAU5lvekwD7FZGC0UyD+iu1X1I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyBiXstLUQdkbzuPsF1+LQ8dxTKJBOyge3D6X/t42p893MQEZlHcXzh/JpByNexK/nmHX/MM7y2ONNqBJ932z67ezH0aGs8P0CAIg41VRUj27CUpi1ycFGOSmzQYy3scjtxRZ5qv4K4h4i8eCWWm8YB2xbEsTYJ4iFMRWnvvJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=cNG4crII; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d427518d52so39851325ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706106012; x=1706710812; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gg2BcXy7cgtvZNtasijxfGct5xlHGGIYWWGbAFbSaMg=;
        b=cNG4crIImI6pmIYQJgdVL+idIeKezkX8z+Bsrazk+/Il/KtN8+qLHWP8TMYbA+jgVe
         wQ6DA/B1uOR9qVeXYJMfitKBoXZEpD5peq2ptc5lp+PD2HyDRvcJCxFzIwxx5zzz0sMb
         OfOHbhztIGMePAypV7LYBoFCsV2MCAzPmJ6s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706106012; x=1706710812;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gg2BcXy7cgtvZNtasijxfGct5xlHGGIYWWGbAFbSaMg=;
        b=MJTBF1rfoXDiImk4T8I8va102+fkULwP4do8yo9xKL9NXWfFpjUZiOcgqYOcdB3olp
         W2+OCdEFgnScEWq0/gBREDd1dhRq99/Bdn+6e37a04xEc4l5bWtvQfpGC3svxMNn11Ie
         MzEGbZmLD1TPZ7AaJFWU/KO+k5z+4jziFRjy57kdWU74JQJbhPSoquiNd0RCBH+I4AsU
         6h7u9zzPPHyNXRcrVvSsgKTMCNNNEBkz0tWGfI769y6zsIbsb1lV0z4qAX15q2sGdDJn
         QuUDRhAcbjho0WHjUf7AxthdvARbC5QDs1+odfw+kTFx6UB7OG7yS8RLULrWxEWbHGPi
         xUVg==
X-Gm-Message-State: AOJu0YyRxAnoD+6gOCwBoSR+mrZIKPM12K7EOrc5JMNbDMKu2LMtsE15
	uyju9WatXzcumQYJLYHJrAXltcmjpiIS88snIppKwFOwlZBqpsEeQTwNk6VAThg=
X-Google-Smtp-Source: AGHT+IH8BdIXPQbdY/OM/ulZfsAMAltsxRdF8J64YduL7ISA+tBc81NdI+aNU6ialBz8AQFkZBzuwg==
X-Received: by 2002:a17:903:2307:b0:1d5:be4d:1afb with SMTP id d7-20020a170903230700b001d5be4d1afbmr1409670plh.14.1706106012530;
        Wed, 24 Jan 2024 06:20:12 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001d5e340d979sm10510559plw.6.2024.01.24.06.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2024 06:20:12 -0800 (PST)
Date: Wed, 24 Jan 2024 06:20:09 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
	alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
	kuba@kernel.org, Wei Wang <weiwan@google.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
Message-ID: <20240124142008.GA1448@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
 <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Jan 24, 2024 at 09:20:09AM +0100, Eric Dumazet wrote:
> On Wed, Jan 24, 2024 at 3:54 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > Greetings:
> >
> > TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support to
> > epoll with socket fds.") by allowing user applications to enable
> > epoll-based busy polling and set a busy poll packet budget on a per epoll
> > context basis.
> >
> > To allow for this, two ioctls have been added for epoll contexts for
> > getting and setting a new struct, struct epoll_params.
> >
> > This makes epoll-based busy polling much more usable for user
> > applications than the current system-wide sysctl and hardcoded budget.
> >
> > Longer explanation:
> >
> > Presently epoll has support for a very useful form of busy poll based on
> > the incoming NAPI ID (see also: SO_INCOMING_NAPI_ID [1]).
> >
> > This form of busy poll allows epoll_wait to drive NAPI packet processing
> > which allows for a few interesting user application designs which can
> > reduce latency and also potentially improve L2/L3 cache hit rates by
> > deferring NAPI until userland has finished its work.
> >
> > The documentation available on this is, IMHO, a bit confusing so please
> > allow me to explain how one might use this:
> >
> > 1. Ensure each application thread has its own epoll instance mapping
> > 1-to-1 with NIC RX queues. An n-tuple filter would likely be used to
> > direct connections with specific dest ports to these queues.
> >
> > 2. Optionally: Setup IRQ coalescing for the NIC RX queues where busy
> > polling will occur. This can help avoid the userland app from being
> > pre-empted by a hard IRQ while userland is running. Note this means that
> > userland must take care to call epoll_wait and not take too long in
> > userland since it now drives NAPI via epoll_wait.
> >
> > 3. Ensure that all incoming connections added to an epoll instance
> > have the same NAPI ID. This can be done with a BPF filter when
> > SO_REUSEPORT is used or getsockopt + SO_INCOMING_NAPI_ID when a single
> > accept thread is used which dispatches incoming connections to threads.
> >
> > 4. Lastly, busy poll must be enabled via a sysctl
> > (/proc/sys/net/core/busy_poll).
> >
> > The unfortunate part about step 4 above is that this enables busy poll
> > system-wide which affects all user applications on the system,
> > including epoll-based network applications which were not intended to
> > be used this way or applications where increased CPU usage for lower
> > latency network processing is unnecessary or not desirable.
> >
> > If the user wants to run one low latency epoll-based server application
> > with epoll-based busy poll, but would like to run the rest of the
> > applications on the system (which may also use epoll) without busy poll,
> > this system-wide sysctl presents a significant problem.
> >
> > This change preserves the system-wide sysctl, but adds a mechanism (via
> > ioctl) to enable or disable busy poll for epoll contexts as needed by
> > individual applications, making epoll-based busy poll more usable.
> >
> 
> I think this description missed the napi_defer_hard_irqs and
> gro_flush_timeout settings ?

I'm not sure if those settings are strictly related to the change I am
proposing which makes epoll-based busy poll something that can be
enabled/disabled on a per-epoll context basis and allows the budget to be
set as well, but maybe I am missing something? Sorry for my
misunderstanding if so.

IMHO: a single system-wide busy poll setting is difficult to use
properly and it is unforunate that the packet budget is hardcoded. It would
be extremely useful to be able to set both of these on a per-epoll basis
and I think my suggested change helps to solve this.

Please let me know.

Re the two settings you noted:

I didn't mention those in the interest of brevity, but yes they can be used
instead of or in addition to what I've described above.

While those settings are very useful, IMHO, they have their own issues
because they are system-wide as well. If they were settable per-NAPI, that
would make it much easier to use them because they could be enabled for the
NAPIs which are being busy-polled by applications that support busy-poll.

Imagine you have 3 types of apps running side-by-side:
  - A low latency epoll-based busy poll app,
  - An app where latency doesn't matter as much, and
  - A latency sensitive legacy app which does not yet support epoll-based
    busy poll.

In the first two cases, the settings you mention would be helpful or not
make any difference, but in the third case the system-wide impact might be
undesirable because having IRQs fire might be important to keep latency
down.

If your comment was more that my cover letter should have mentioned these,
I can include that in a future cover letter or suggest some kernel
documentation which will discuss all of these features and how they relate
to each other.

> 
> I would think that if an application really wants to make sure its
> thread is the only one
> eventually calling napi->poll(), we must make sure NIC interrupts stay masked.
> 
> Current implementations of busy poll always release NAPI_STATE_SCHED bit when
> returning to user space.
>
> It seems you want to make sure the application and only the
> application calls the napi->poll()
> at chosen times.
> 
> Some kind of contract is needed, and the presence of the hrtimer
> (currently only driven from dev->@gro_flush_timeout)
> would allow to do that correctly.
> 
> Whenever we 'trust' user space to perform the napi->poll shortly, we
> also want to arm the hrtimer to eventually detect
> the application took too long, to restart the other mechanisms (NIC irq based)

There is another change [1] I've been looking at from a research paper [2]
which does something similar to what you've described above -- it keeps
IRQs suppressed during busy polling. The paper suggests a performance
improvement is measured when using a mechanism like this to keep IRQs off.
Please see the paper for more details.

I haven't had a chance to reach out to the authors or to tweak this patch
to attempt an RFC / submission for it, but it seems fairly promising in my
initial synthetic tests.

When I tested their patch, as you might expect, no IRQs were generated at
all for the NAPIs that were being busy polled, but the rest of the
NAPIs and queues were generating IRQs as expected.

Regardless of the above patch: I think my proposed change is helpful and
the IRQ suppression bit can be handled in a separate change in the future.
What do you think?

> Note that we added the kthread based napi polling, and we are working
> to add a busy polling feature to these kthreads.
> allowing to completely mask NIC interrupts and further reduce latencies.

I am aware of kthread based NAPI polling, yes, but I was not aware that
busy polling was being considered as a feature for them, thanks for the
head's up.

> Thank you

Thanks for your comments - I appreciate your time and attention.

Could you let me know if your comments are meant as a n-ack or similar?

I am unsure if you were suggesting that per-epoll context based busy
polling is unneeded/unnecessary from your perspective - or if it was more
of a hint that I should be including more context somewhere in the kernel
documentation as part of this change :)

Again, IMHO, allowing epoll based busy polling to be configured on a
per-epoll context basis (both the usecs and the packet budget) really help
to make epoll-based busy polling much more usable by user apps.

Thanks,
Joe

[1]: https://gitlab.uwaterloo.ca/p5cai/netstack-exp/-/raw/master/kernel-polling-5.15.79-base.patch?ref_type=heads
[2]: https://dl.acm.org/doi/pdf/10.1145/3626780

