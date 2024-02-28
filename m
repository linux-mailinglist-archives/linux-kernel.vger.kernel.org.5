Return-Path: <linux-kernel+bounces-84974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0386AE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759FB1F23349
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F0B1369BF;
	Wed, 28 Feb 2024 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zxc6yBkh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78A373503
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121061; cv=none; b=ViIA4S3LtwFQmdUkYXX3Uy5tUh+PBMIpqGoD0K2P/B37GsUKNNrl8p7w0bmtNoMEKWlQNHT3B9ZqJsfYr5qr/TypYsGM6YGQz8fSYqgLKRGa4v/7CY1LA9WEcbWgR3naAYeYGT8UxYKQAZaP1T9Y5CAiv47KGgCuFbv3x4dPAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121061; c=relaxed/simple;
	bh=NUqRZXSlaPreveGzpaaoGjZfPnYAgtt8dJUE8yNdqGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BVKvMI3h3Aro9MvAufxujG2P+MxgnYL+iDCYQdeTZKnIfBDhXS4ufMfY6d1OYZuswKjqQKuj8XRlfE5L7Aulp/4FXY9Cjr6LaZN6FA5MCqxO1smvqzgbduPJoV+oDt+MAZSzGBGn39p6oY0Ky8JforHz86jW35Nh57XgPTYWU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zxc6yBkh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709121057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+waIFhwixtYlk9hyKlLzfQD0m8wRi5/b3f1cwvn4VQ=;
	b=Zxc6yBkh4JP9qWBqR5O1oXFrf05g8Kx3Z/aPm3ss9zQcZnDRYlT+4TSLEexa0JSrdKBoJB
	aHMw6tLSwbn6/Du9YAaXtmiIOd2aREmWDetpChaWqTF2ctVNWFqB/wDGn0WaNuX4kfWQ8y
	tN0NLJfx/OQCp6qGU7+PRZvCDsslldo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-UnvNNv9uOLuFGzF_EAdwFw-1; Wed, 28 Feb 2024 06:50:56 -0500
X-MC-Unique: UnvNNv9uOLuFGzF_EAdwFw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3ecd8d3a8dso253121266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:50:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709121055; x=1709725855;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+waIFhwixtYlk9hyKlLzfQD0m8wRi5/b3f1cwvn4VQ=;
        b=kDzYlecw+47jFEfFwd4I25ElbKxoVwPzyMkEGulDg30tiVL+aoKMSDuJnXdrzANaro
         rzKHgv0otrzPNu8ZNEPYXyi1Hpsg2AQE+D38N29+cARNFZBJYzcyi059vIqNsl0GDGsz
         07HgMQ3N6csUDVuz4IUUMFvzL6fAGtE90kKv05erce+e/U+TnPS5mihRAJGYqoLHZDbT
         pmfsIWQzNDKHfq43+PF8B65OWlZbHfKhi15Fop5VrK8Pajlq1pSrJcBz16XD57b2sWl4
         JhsfIjy4GaKJtxSjwLcinXMU/wFHXyvtpZaGO0x5ZXQG/c6vcQZ3mmOFOGoEMdUBDF3m
         eWuA==
X-Forwarded-Encrypted: i=1; AJvYcCU48rTVso5titndAllbdYX+WNX56+h6E9y27Z8Zflkwq85Inqbny09lhXkKoqHPqv2qZKDOfBguQhMhcrtpu5J2MpqInrVNH8eB1uRT
X-Gm-Message-State: AOJu0YzDPDrKIhvRZPAgO2iseBNpkuIUIqPToFDdoQ5MGfdw9Zct3QHO
	K6HGSs7PTl+tAgYU78n1JoHx1h7Vt+0Dj1GLDhOrIOJf4WyOM+bvcxgAjVmmduG/It3/WPopzSj
	IhRZgbN1hX9PuYCR/09PcYUex8HbWU4Z6TK6G+OOvoqpS4QXbAlqS5tSenkYmRg==
X-Received: by 2002:a17:906:38c2:b0:a43:2255:2241 with SMTP id r2-20020a17090638c200b00a4322552241mr6733859ejd.53.1709121055201;
        Wed, 28 Feb 2024 03:50:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQvZvyolhRnqLocsVj00UxJ4E1FTjOFdA2kV4qae3vZfPoEtr8rbrzi4ifxNrCaNvgxSYuzw==
X-Received: by 2002:a17:906:38c2:b0:a43:2255:2241 with SMTP id r2-20020a17090638c200b00a4322552241mr6733843ejd.53.1709121054834;
        Wed, 28 Feb 2024 03:50:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id vx6-20020a170907a78600b00a3edde33e7esm1765156ejc.99.2024.02.28.03.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 03:50:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5EB1A112E709; Wed, 28 Feb 2024 12:50:53 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: paulmck@kernel.org, Eric Dumazet <edumazet@google.com>
Cc: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang
 <weiwan@google.com>, Alexander Duyck <alexanderduyck@fb.com>, Hannes
 Frederic Sowa <hannes@stressinduktion.org>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
In-Reply-To: <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
References: <Zd4DXTyCf17lcTfq@debian.debian>
 <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 28 Feb 2024 12:50:53 +0100
Message-ID: <87edcwerj6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Tue, Feb 27, 2024 at 05:44:17PM +0100, Eric Dumazet wrote:
>> On Tue, Feb 27, 2024 at 4:44=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wr=
ote:
>> >
>> > We noticed task RCUs being blocked when threaded NAPIs are very busy in
>> > production: detaching any BPF tracing programs, i.e. removing a ftrace
>> > trampoline, will simply block for very long in rcu_tasks_wait_gp. This
>> > ranges from hundreds of seconds to even an hour, severely harming any
>> > observability tools that rely on BPF tracing programs. It can be
>> > easily reproduced locally with following setup:
>> >
>> > ip netns add test1
>> > ip netns add test2
>> >
>> > ip -n test1 link add veth1 type veth peer name veth2 netns test2
>> >
>> > ip -n test1 link set veth1 up
>> > ip -n test1 link set lo up
>> > ip -n test2 link set veth2 up
>> > ip -n test2 link set lo up
>> >
>> > ip -n test1 addr add 192.168.1.2/31 dev veth1
>> > ip -n test1 addr add 1.1.1.1/32 dev lo
>> > ip -n test2 addr add 192.168.1.3/31 dev veth2
>> > ip -n test2 addr add 2.2.2.2/31 dev lo
>> >
>> > ip -n test1 route add default via 192.168.1.3
>> > ip -n test2 route add default via 192.168.1.2
>> >
>> > for i in `seq 10 210`; do
>> >  for j in `seq 10 210`; do
>> >     ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport =
5201
>> >  done
>> > done
>> >
>> > ip netns exec test2 ethtool -K veth2 gro on
>> > ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threaded'
>> > ip netns exec test1 ethtool -K veth1 tso off
>> >
>> > Then run an iperf3 client/server and a bpftrace script can trigger it:
>> >
>> > ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
>> > ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t 1=
00 >/dev/null&
>> > bpftrace -e 'kfunc:__napi_poll{@=3Dcount();} interval:s:1{exit();}'
>> >
>> > Above reproduce for net-next kernel with following RCU and preempt
>> > configuraitons:
>> >
>> > # RCU Subsystem
>> > CONFIG_TREE_RCU=3Dy
>> > CONFIG_PREEMPT_RCU=3Dy
>> > # CONFIG_RCU_EXPERT is not set
>> > CONFIG_SRCU=3Dy
>> > CONFIG_TREE_SRCU=3Dy
>> > CONFIG_TASKS_RCU_GENERIC=3Dy
>> > CONFIG_TASKS_RCU=3Dy
>> > CONFIG_TASKS_RUDE_RCU=3Dy
>> > CONFIG_TASKS_TRACE_RCU=3Dy
>> > CONFIG_RCU_STALL_COMMON=3Dy
>> > CONFIG_RCU_NEED_SEGCBLIST=3Dy
>> > # end of RCU Subsystem
>> > # RCU Debugging
>> > # CONFIG_RCU_SCALE_TEST is not set
>> > # CONFIG_RCU_TORTURE_TEST is not set
>> > # CONFIG_RCU_REF_SCALE_TEST is not set
>> > CONFIG_RCU_CPU_STALL_TIMEOUT=3D21
>> > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D0
>> > # CONFIG_RCU_TRACE is not set
>> > # CONFIG_RCU_EQS_DEBUG is not set
>> > # end of RCU Debugging
>> >
>> > CONFIG_PREEMPT_BUILD=3Dy
>> > # CONFIG_PREEMPT_NONE is not set
>> > CONFIG_PREEMPT_VOLUNTARY=3Dy
>> > # CONFIG_PREEMPT is not set
>> > CONFIG_PREEMPT_COUNT=3Dy
>> > CONFIG_PREEMPTION=3Dy
>> > CONFIG_PREEMPT_DYNAMIC=3Dy
>> > CONFIG_PREEMPT_RCU=3Dy
>> > CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
>> > CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=3Dy
>> > CONFIG_PREEMPT_NOTIFIERS=3Dy
>> > # CONFIG_DEBUG_PREEMPT is not set
>> > # CONFIG_PREEMPT_TRACER is not set
>> > # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
>> >
>> > An interesting observation is that, while tasks RCUs are blocked,
>> > related NAPI thread is still being scheduled (even across cores)
>> > regularly. Looking at the gp conditions, I am inclining to cond_resched
>> > after each __napi_poll being the problem: cond_resched enters the
>> > scheduler with PREEMPT bit, which does not account as a gp for tasks
>> > RCUs. Meanwhile, since the thread has been frequently resched, the
>> > normal scheduling point (no PREEMPT bit, accounted as a task RCU gp)
>> > seems to have very little chance to kick in. Given the nature of "busy
>> > polling" program, such NAPI thread won't have task->nvcsw or task->on_=
rq
>> > updated (other gp conditions), the result is that such NAPI thread is
>> > put on RCU holdouts list for indefinitely long time.
>> >
>> > This is simply fixed by mirroring the ksoftirqd behavior: after
>> > NAPI/softirq work, raise a RCU QS to help expedite the RCU period. No
>> > more blocking afterwards for the same setup.
>> >
>> > Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop supp=
ort")
>> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
>> > ---
>> >  net/core/dev.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/net/core/dev.c b/net/core/dev.c
>> > index 275fd5259a4a..6e41263ff5d3 100644
>> > --- a/net/core/dev.c
>> > +++ b/net/core/dev.c
>> > @@ -6773,6 +6773,10 @@ static int napi_threaded_poll(void *data)
>> >                                 net_rps_action_and_irq_enable(sd);
>> >                         }
>> >                         skb_defer_free_flush(sd);
>
> Please put a comment here stating that RCU readers cannot cross
> this point.
>
> I need to add lockdep to rcu_softirq_qs() to catch placing this in an
> RCU read-side critical section.  And a header comment noting that from
> an RCU perspective, it acts as a momentary enabling of preemption.

OK, so one question here: for XDP, we're basically treating
local_bh_disable/enable() as the RCU critical section, cf the discussion
we had a few years ago that led to this being documented[0]. So why is
it OK to have the rcu_softirq_qs() inside the bh disable/enable pair,
but not inside an rcu_read_lock() section?

Also, looking at the patch in question:

>> > +                       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>> > +                               rcu_softirq_qs();
>> > +
>> >                         local_bh_enable();

Why does that local_bh_enable() not accomplish the same thing as the qs?

-Toke

[0] https://lore.kernel.org/bpf/20210624160609.292325-6-toke@redhat.com/


