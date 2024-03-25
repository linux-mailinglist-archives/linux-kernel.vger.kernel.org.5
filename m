Return-Path: <linux-kernel+bounces-117346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B3C88AC4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3BDBA7F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4080682D8F;
	Mon, 25 Mar 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1U1RgMy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C02C28F5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379733; cv=none; b=AVVaVmOmCrrrMB8Jk99nqpvaJohj++kofJHBVusUjKxcEYl5FLzMoxv24cg7gYo34/VN/eh/y8PJkkqtW0MrLH0UVbEsvSeMYmK8MY1KnL2eoguilemO1svOR/EQiBpAdJAWk4PHsenKH8i4GdkOinoL8mKGh6YGWkzkjimX4m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379733; c=relaxed/simple;
	bh=kPlMSaMqo39hTPJCm+rG6l2qBNgpVeSsC7Q20ufapqs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QLLl4MQW944jEhrzRiaIUdqQafP14n12jDqjMAnaTiKvobMBCOLODfhKGQQPuwF85v+Te+DFUozqNmu/47Htph9NmFHi8ZQ1tcC3r3r2K50hwICknqoyAyC5isCG8yqMGyVeyb9GXkJaUuIETxCfSV23ezpsaZvlYDtfA5cIQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1U1RgMy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711379730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k81rqq4hzeq4pWvLawuIvbOKMKqt9JCn+dSEFmJ+o2Q=;
	b=A1U1RgMylqiE4tMU7/VgKDAfS6U48jUyixkq9fWaoqjJE7+fHP3G4ICShR9Eag1s/Ak/+f
	ZpN49AHQig9it3i4pb6NKkobgVKiWSPP8Pd+JN0FF+ycIMSSZyCrMULjLLgBLBsoG5Zjia
	yoo3n/2igAh0JCyUeN2D4/wpch2TJRc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-SkoXz3YhPkGyLjBf_Astqw-1; Mon, 25 Mar 2024 11:15:29 -0400
X-MC-Unique: SkoXz3YhPkGyLjBf_Astqw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ec826d427so431955f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711379727; x=1711984527;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k81rqq4hzeq4pWvLawuIvbOKMKqt9JCn+dSEFmJ+o2Q=;
        b=r3cK6wdIGpaFF3jobZWsDBozWr81il9QSAoHgzWwjIHX8i7MkHSTgjSDPSJq9+HNgo
         uu1PPgiaHdP8C9HpTALStL0KZKyS0tIiSYVXTbDzk3keV6EdozuRvdhSmaAtvsoxpofR
         9w+bwtl4JpI5qlJP10WN3MB2iY7MnNT7aQIPv3rU/VFDr6CbJ3Y5I5WjecdfCX/HATk5
         AtIzN5N3WiLOcMueK/7ArHbMX4QzvI5Uc5GYl/fPtdU1tnMBvDf1rRqe4liU9gLpKBM4
         FcNpwizsTry1cZbO7mdXHNc7Y40aTuLi1zsgNaUHL5jYLkLb/bABp76kLfTIJRIM7LhT
         QwNw==
X-Forwarded-Encrypted: i=1; AJvYcCUTPb/kzEQUF70FRzUuqhYjguAEMArvTretYcYcbwWQZNfHDMYdwLCxz7j1sMyHVh5WdJv12TJGkUaS2D+8yVIMJYcaT0GKG28Z8R1X
X-Gm-Message-State: AOJu0YyMVVqAyH5gB3q6aOlR1LXQpu6mrPORjdkaKPMMHmF3QOB1NtQm
	ExWfNMmFE0JAbCGGGVgWJFbXAkP1wHkRDb0KP7srPKCdZcjONhVSWp6/oA6W4q7yNCHimvY+b0W
	MO+CTyrMgMH0BNOQWOvnch4cFFt4kfubWq5BWPcvT03f0dD1LNc4+RT3x/gx0oQ==
X-Received: by 2002:a5d:6147:0:b0:33e:cf2f:b0 with SMTP id y7-20020a5d6147000000b0033ecf2f00b0mr4916004wrt.3.1711379727672;
        Mon, 25 Mar 2024 08:15:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrc5zYv8VaDd+lWJa2+ZgmiNoBLCeQqToQYtu3I9B/QwbhTDXB0KOTKHOwhAIon9Sw1JN/Fg==
X-Received: by 2002:a5d:6147:0:b0:33e:cf2f:b0 with SMTP id y7-20020a5d6147000000b0033ecf2f00b0mr4915976wrt.3.1711379727276;
        Mon, 25 Mar 2024 08:15:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-229-40.dyn.eolo.it. [146.241.229.40])
        by smtp.gmail.com with ESMTPSA id df4-20020a5d5b84000000b0033e7b433498sm9747308wrb.111.2024.03.25.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:15:26 -0700 (PDT)
Message-ID: <e06f2c8537347a861dc27d100155cb721f7cf079.camel@redhat.com>
Subject: Re: [PATCH v3 1/1] tcp/dcpp: Un-pin tw_timer
From: Paolo Abeni <pabeni@redhat.com>
To: Valentin Schneider <vschneid@redhat.com>, Eric Dumazet
 <edumazet@google.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-rt-users@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,
 mleitner@redhat.com, David Ahern <dsahern@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Tomas Glozar <tglozar@redhat.com>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>
Date: Mon, 25 Mar 2024 16:15:25 +0100
In-Reply-To: <xhsmh1q82c7bt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20240219095729.2339914-1-vschneid@redhat.com>
	 <20240219095729.2339914-2-vschneid@redhat.com>
	 <CANn89i+3-zgAkWukFavu1wgf1XG+K9U4BhJWw7H+QKwsfYL4WA@mail.gmail.com>
	 <xhsmho7cbf33q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	 <CANn89iJpwUpAROOq7+ttwTMCZu0=XhS4dgwcs44t-gb7-_ejRg@mail.gmail.com>
	 <xhsmhjzmxg40f.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	 <47a0e30caff2a49d152aed521ef5e512fd11ae99.camel@redhat.com>
	 <xhsmh1q82c7bt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-22 at 21:58 +0100, Valentin Schneider wrote:
> On 21/03/24 20:03, Paolo Abeni wrote:
> > Something alike the following (completely untested!!!):
> >=20
> > WDYT?
>=20
> Thanks for the suggestion! I've been preempted by other things and haven'=
t
> had time to think more about this, so I really appreciate it :)
>=20
> > ---
> > diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewa=
it_sock.h
> > index f28da08a37b4..d696d10dc8ae 100644
> > --- a/include/net/inet_timewait_sock.h
> > +++ b/include/net/inet_timewait_sock.h
> > @@ -93,8 +93,10 @@ struct inet_timewait_sock *inet_twsk_alloc(const str=
uct sock *sk,
> >  					   struct inet_timewait_death_row *dr,
> >  					   const int state);
> > =20
> > -void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *s=
k,
> > -			 struct inet_hashinfo *hashinfo);
> > +void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
> > +				  struct sock *sk,
> > +				  struct inet_hashinfo *hashinfo,
> > +				  int timeo);
> > =20
> >  void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo,
> >  			  bool rearm);
> > diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
> > index 64d805b27add..8e108a89d8e4 100644
> > --- a/net/dccp/minisocks.c
> > +++ b/net/dccp/minisocks.c
> > @@ -58,11 +58,10 @@ void dccp_time_wait(struct sock *sk, int state, int=
 timeo)
> >  		 * we complete the initialization.
> >  		 */
> >  		local_bh_disable();
> > -		inet_twsk_schedule(tw, timeo);
> >  		/* Linkage updates.
> >  		 * Note that access to tw after this point is illegal.
> >  		 */
> > -		inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
> > +		inet_twsk_hashdance_schedule(tw, sk, &dccp_hashinfo, timeo);
> >  		local_bh_enable();
> >  	} else {
> >  		/* Sorry, if we're out of memory, just CLOSE this
> > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_soc=
k.c
> > index e8de45d34d56..dd314b06c0cd 100644
> > --- a/net/ipv4/inet_timewait_sock.c
> > +++ b/net/ipv4/inet_timewait_sock.c
> > @@ -97,8 +97,10 @@ static void inet_twsk_add_node_rcu(struct inet_timew=
ait_sock *tw,
> >   * Essentially we whip up a timewait bucket, copy the relevant info in=
to it
> >   * from the SK, and mess with hash chains and list linkage.
> >   */
> > -void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *s=
k,
> > -			   struct inet_hashinfo *hashinfo)
> > +void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
> > +				  struct sock *sk,
> > +				  struct inet_hashinfo *hashinfo,
> > +				  int timeo)
> >  {
> >  	const struct inet_sock *inet =3D inet_sk(sk);
> >  	const struct inet_connection_sock *icsk =3D inet_csk(sk);
> > @@ -135,6 +137,8 @@ void inet_twsk_hashdance(struct inet_timewait_sock =
*tw, struct sock *sk,
> >  	if (__sk_nulls_del_node_init_rcu(sk))
> >  		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> > =20
> > +	inet_twsk_schedule(tw, timeo);
> > +
> >  	spin_unlock(lock);
> >=20
>=20
> That arms the timer before the refcounts are set up in the tail end of
> the hashdance, which is what we have upstream ATM.
>=20
> Unfortunately this relies on the timer being TIMER_PINNED and having
> softirqs disabled: the timer can only be enqueued on the local CPU, and i=
t
> can't fire until softirqs are enabled, so refcounts can safely be updated
> after it is armed because it can't fire.
>=20
> For dynamic CPU isolation we want to make this timer not-pinned, so that =
it
> can be scheduled on housekeeping CPUs. However that means the
> local_bh_disable() won't prevent the timer from firing, and that means th=
e
> refcounts need to be written to before it is armed.

Ouch, right you are, I underlooked that.


> Using the ehash lock is clever though, and the first thing inet_twsk_kill=
()
> does is grabbing it... Maybe something like the below? It (should) preven=
t
> this interleaving race:
>=20
>                              tcp_time_wait()
>                                inet_twsk_hashdance()
>   inet_twsk_deschedule_put()
>     del_timer_sync()
>                                inet_twsk_schedule()
>=20
> whether it is sane is another thing :-)

[...]

That looks safe to me but, compared to the current code, will need an
additional WMB in tcp_time_wait() and will take the hash lock
unconditionally in inet_twsk_deschedule_put(). The latter should not be
fast-path, I'm unsure if the whole thing be acceptable from performance
perspective??? Eric WDYT?

Thanks,

Paolo


