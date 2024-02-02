Return-Path: <linux-kernel+bounces-50485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4AA8479BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43230288536
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78EE80635;
	Fri,  2 Feb 2024 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="h6Zev5TR"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF4715E5DF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902418; cv=none; b=kY8o9bKC4FewW9NGd2tu4iiQNerK1mYfKisqzUIjninyfNmA1iJKsQuzmXhj2YS6mMvFKr9YhacRNYC77imrEbINfWrdG8+Ar3W6b2WtziK1RXSemMygHW/99ByZwro9TjM16ItPVICidFuH510uXu9ck+xwMXJd9ImclSCvZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902418; c=relaxed/simple;
	bh=g5laj1QoN1MXh7BixilutgP9/I3f00BIUMkyQH12L3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajx42nuaX3Cx5aMDFxBeCIA4I/lGCl9HaDu18wHH4KATAeQ+BT6YX8EdOJgCefzdCsjBcQAX5mxxbmnjcdU8ZwA+iosPwnSELjMcugsPQQMdY65ELEWyW/i2iW8v7HhHixg7EBiffmdrdJwB7zR8l0uSrZ+y2rq7KcdGVWfQ1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=h6Zev5TR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d928a8dee8so24894635ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 11:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706902416; x=1707507216; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KErE+eM+LxAwLxLNMiUIg4MJhZ5E9f0uXY9rL9Fh7Q0=;
        b=h6Zev5TRQ2S/YncrFG+OgypuivlD1m4Lg2krVyX4Fby3/gKx6E3AWnmoaY0ScDwGTK
         9L6pQowxoweIylu6t0RQI2iwbI+nb62ZLKqAox7Ah2mbNhukuUVYd2M7TOUrJg8G3Ebv
         FWFYde4RS7v4Pq/jYf65od9hjU41pAfACP5A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706902416; x=1707507216;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KErE+eM+LxAwLxLNMiUIg4MJhZ5E9f0uXY9rL9Fh7Q0=;
        b=itpl8HkpgGygBHiuD5Z1wlYMgaI0wa62bXs2mQ6HtiPBPOkKLssa1vF2C1dXoO1f7w
         RLkcLYeRPT6QCpuHAVIk88QPWnzueYymR8c6dbwEmpVnWdMDHHIVmcMSFp5v3H5xGqOc
         tRN7UCPw/Wpwo69dXtuNrxb0Z+oEWH/vDje5VnLE8rnOoBZkSIxIu2s16JhHpBqqFS/z
         z8vzj+I+911OSW+/n/Ks4L/ByzT7q3nVinMCIGckCIY5Rn34rKMPrjiv0XGFmhMkU3Tm
         SmWBAqd2I/Nmnzrcfpb/kdTTdwX9cAiyWDMFmFBkCg/IqCUNfskp8N3CNerqzS3OOjdB
         j2lg==
X-Gm-Message-State: AOJu0YxNxFYqkspRQ9Upc+U5DMKJUKjo5zPn4NbAcdcHl0LG6Y9prxaj
	T+i8+Yp1skIhnfMn0PVgLEm2gXv/LM2TTKMv6MSbcSY5VZ5bZLmt7xmSbrBjr6w=
X-Google-Smtp-Source: AGHT+IFv4qNl8SNji62srAX3kFavpZDwiJS6BoBx2bU2XJFetB3InzWLxuoGMnd76IaFWec2cW2TWw==
X-Received: by 2002:a17:902:dac4:b0:1d7:836d:7b3f with SMTP id q4-20020a170902dac400b001d7836d7b3fmr5007690plx.9.1706902416270;
        Fri, 02 Feb 2024 11:33:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVhIpX68iycwXEcrOOaq99njkKXjdrAac4ET9sMwPQ9rZ742NRaDVbEFcCFnvyWVzMJ8PXA5CJBoyAwoVXIN5hcJIppSJTn6IuZRN88KaUO1ByKQE9P5RzZP2yb//jeIR52AkioRFI8SBhVa2EJm6GlV/E0dzUrB6D5ZNu7krUtNCCPUCz0dvfnMcKb7FkCCaZBVgi5ZLc0cbmHJHB2milnrKnGUjZtFwmRF+es13EFf2hMFUZwvIiprRI6bBO4ksJ3cqyeS3Z+Ui1/fzlC/h1lxWgJ5reFN7jWMgf1BNpTOK5+sth/p+3uZY8OzcK3J0KqXWbI04EEub0Cm62uUUq5IPSe7jQZDQpzwMCk+kaxiluWBgK8m0b/d23JbiTepu2BUTFojxa5ETlZorUdkkFPBRc=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id u19-20020a170903305300b001d92a58330csm1960387pla.145.2024.02.02.11.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2024 11:33:35 -0800 (PST)
Date: Fri, 2 Feb 2024 11:33:33 -0800
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
Message-ID: <20240202193332.GA8932@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
 <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
 <5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
 <20240202032806.GA8708@fastly.com>
 <f0b4d813-d7cb-428b-9c41-a2d86684f3f1@intel.com>
 <20240202102239.274ca9bb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202102239.274ca9bb@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Fri, Feb 02, 2024 at 10:22:39AM -0800, Jakub Kicinski wrote:
> On Fri, 2 Feb 2024 11:23:28 -0600 Samudrala, Sridhar wrote:
> > > I know I am replying to a stale thread on the patches I've submit (there is
> > > a v5 now [1]), but I just looked at your message - sorry I didn't reply
> > > sooner.
> > > 
> > > The per-queue and per-napi netlink APIs look extremely useful, thanks for
> > > pointing this out.
> > > 
> > > In my development tree, I had added SIOCGIFNAME_BY_NAPI_ID which works
> > > similar to SIOCGIFNAME: it takes a NAPI ID and returns the IF name. This is
> > > useful on machines with multiple NICs where each NIC could be located in
> > > one of many different NUMA zones.
> > > 
> > > The idea was that apps would use SO_INCOMING_NAPI_ID, distribute the NAPI
> > > ID to a worker thread which could then use SIOCGIFNAME_BY_NAPI_ID to
> > > compute which NIC the connection came in on. The app would then (via
> > > configuration) know where to pin that worker thread; ideally somewhere NUMA
> > > local to the NIC.
> > > 
> > > I had assumed that such a change would be rejected, but I figured I'd send
> > > an RFC for it after the per epoll context stuff was done and see if anyone
> > > thought SIOCGIFNAME_BY_NAPI_ID would be useful for them, as well.  
> > 
> > I think you should be able to get this functionality via the netdev-genl 
> > API to get napi parameters. It returns ifindex as one of the parameters 
> > and you should able to get the name from ifindex.
> > 
> > $ ./cli.py --spec netdev.yaml --do napi-get --json='{"id": 593}'
> > {'id': 593, 'ifindex': 12, 'irq': 291, 'pid': 3727}
> 
> FWIW we also have a C library to access those. Out of curiosity what's
> the programming language you'd use in user space, Joe?

I am using C from user space. Curious what you think about
SIOCGIFNAME_BY_NAPI_ID, Jakub? I think it would be very useful, but not
sure if such an extension would be accepted. I can send an RFC, if you'd
like to take a look and consider it. I know you are busy and I don't want
to add too much noise to the list if I can help it :)

Here's a brief description of what I'm doing, which others might find
helpful:

1. Machine has multiple NICs. Each NIC has 1 queue per busy poll app
thread, plus a few extra queues for other non busy poll usage.

2. A custom RSS context is created to distribute flows to the busy poll
queues. This context is created for each NIC. The default context directs
flows to the non-busy poll queues.

3. Each NIC has n-tuple filters inserted to direct incoming connections
with certain destination ports (e.g. 80, 443) to the custom RSS context.
All other incoming connections will land in the default context and go to
the other queues.

4. IRQs for the busy poll queues are pinned to specific CPUs which are NUMA
local to the NIC.

5. IRQ coalescing values are setup with busy poll in mind, so IRQs are
deferred as much as possible with the assumption userland will drive NAPI
via epoll_wait. This is done per queue (using ethtool --per-queue and a
queue mask). This is where napi_defer_hard_irqs and gro_flush_timeout
could help even more. IRQ deferral is only needed for the busy poll queues.

6. userspace app config has NICs with their NUMA local CPUs listed, for
example like this:

   - eth0: 0,1,2,3
   - eth1: 4,5,6,7

The app reads that configuration in when it starts. Ideally, these are the
same CPUs the IRQs are pinned to in step 4, but hopefully the coalesce
settings let IRQs be deferred quite a bit so busy poll can take over.

7. App threads are created and sockets are opened with REUSEPORT. Notably:
when the sockets are created, SO_BINDTODEVICE is used* (see below for
longer explanation about this).

8. cbpf reusport program inserted to distribute incoming connections to
threads based on skb->queue_mapping. skb->queue_mapping values are not
unique (e.g. each NIC will have queue_mapping==0), this is why BINDTODEVICE
is needed. Again, see below.

9. worker thread epoll contexts are set to busy poll by the ioctl I've
submit in my patches.

The first time a worker thread receives a connection, it:

1. calls SO_INCOMING_NAPI_ID to get the NAPI ID associated with the
connection it received.

2. Takes that NAPI ID and calls SIOCGIFNAME_BY_NAPI_ID to figure out which
NIC the connection came in on.

3. Looks for an un-unsed CPU from the list it read in at configuration time
that is associated with that NIC and then pins itself to that CPU. That CPU
is removed from the list so other threads can't take it.

All future incoming connections with the same NAPI ID will be distributed
to app threads which are pinned in the appropriate place and are doing busy
polling.

So, as you can see, SIOCGIFNAME_BY_NAPI_ID makes this implementation very
simple.

I plan to eventually add some information to the kernel networking
documentation to capture some more details of the above, which I think
might be helpful for others.

Thanks,
Joe

* Longer explanation about SO_BINDTODEVICE (only relevant if you have
mulitple NICs):

It turns out that reuseport groups in the kernel are bounded by a few
attributes, port being one of them but also ifindex. Since multiple NICs
can have queue_mapping == 0, reusport groups need to be constructed in
userland with care if there are multiple NICs. This is required because
each epoll context can only do epoll busy poll on a single NAPI ID. So,
even if multiple NICs have queue_mapping == 0, the queues will have
different NAPI IDs and incoming connections must be distributed to threads
uniquely based on NAPI ID.

I am doing this by creating listen sockets for each NIC, one NIC at a time.
When the listen socket is created, SO_BINDTODEVICE is used on the socket
before calling listen.

In the kernel, this results in all listen sockets with the same ifindex to
form a reuseport group. So, if I have 2 NICs and 1 listen port (say port
80), this results in 2 reuseport groups -- one for nic0 port 80 and one for
nic1 port 80, because of SO_BINDTODEVICE.

The reuseport cbpf filter is inserted for each reuseport group, and then
the skb->queue_mapping based listen socket selection will work as expected
distributing NAPI IDs to app threads without breaking epoll busy poll.

Without the above, you can run into an issue where two connections with the
same queue_mapping (but from different NICs) can land in the same epoll
context, which breaks busy poll.

Another potential solution to avoid the above might be use an eBPF program
and to build a hash that maps NAPI IDs to thread IDs and write a more
complicated eBPF program to distribute connections that way. This seemed
cool, but involved a lot more work so I went with the SO_BINDTODEVICE +
SIOCGIFNAME_BY_NAPI_ID method instead which was pretty simple (C code wise)
and easy to implement.

