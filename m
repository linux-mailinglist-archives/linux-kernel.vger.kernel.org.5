Return-Path: <linux-kernel+bounces-110578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F688860D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBE82851D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D97133997;
	Thu, 21 Mar 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiODZc85"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657AF13340B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711047814; cv=none; b=HLIDdyhZIsiu/PQ5FlUu+wCHt4jvYI0B9VaAeLi4OcJ6wM5qS3zbOfBWidwhSu/mPAb3Bff8A3nc4o8jJ+bGfJZ6WLYszC+Bkcvoy0L68i/CsHz7raeI00pb/GPyPWCVpQpnHZgX4Q44Mp+SNc0l4hlKXenVD8dTA4tLxIT6b+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711047814; c=relaxed/simple;
	bh=pJHnReQ6Xh0mCqJV5CGBW+LQ+PGgJSyTORk8N1iun5M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mavpYBpBxThMoU5S0mBJmAXL1HciJ8Fy7OUGeH7bowIP6jxUECmR5IhOfxJqizv2KPqsGvvz+C1FrR7YQd05AlHXM70+NrEIkAtElnbIjyNUesxMqLC4Ki3DqtoX6kQVomZ9XIVUFCSff1HzZ17zgzVw4yZoCJIpqC6IcosIEBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MiODZc85; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711047811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OIFXRiruadAHJd1Slw6Ruw6/JY4Em10PlDVSnLQgW98=;
	b=MiODZc85Hwfek1x/lqgth1ielGiEt0Z3QyW4MwNvTn8REHIi5PjY+QgBKehrYS566B0Erb
	DBi3dFbZR2H4oPdGG5JT9zZecgrcQ706UlLfKehifrc4SMZpIlvA6EXsx6sJPF3pgX/D6F
	b/rwfTm+JGQekNZpjGFr/jfD78+wsUw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-47dctvnYP0GmR4TcDvMKBw-1; Thu, 21 Mar 2024 15:03:28 -0400
X-MC-Unique: 47dctvnYP0GmR4TcDvMKBw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4140c602765so2329895e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711047807; x=1711652607;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIFXRiruadAHJd1Slw6Ruw6/JY4Em10PlDVSnLQgW98=;
        b=HA+Hu2GYGa7gnWcO2t/MoxsolhPzsPj+hggWfPhuog5Ia0NkZdbziKbbEpz5FmslX8
         F3r8Q3bxRu27DIluIdUFZW/ZMjLb7PWx/ScDy5eNhB8MxArS8o/BlgSVltJqgDjdEWak
         +++7Errxu5u8yKFIvIhG6ao8M0pOrOuMeG81itbsChmpjfnB/+v02shHz2t9+Q+3W/Tp
         W65VzZUBVWVmrhkgCvdCYLRaU6PagyNu/u7kVsKH5n0UYohnXI2hdjJA5iC7O4sgC0EF
         iP7YVrHH0YfdrGQjoHYLVbSFdakj7UPpFT/WdbgicmLGHWnghZrnDVT+XxYXPXJ8kYzU
         cOtw==
X-Forwarded-Encrypted: i=1; AJvYcCW+hIqN/OMeJ4gqF3+lFR5DcSJ39SBDoLymvAnULH+oykiZCyYsOTcSSFk3dkBveYKfco4Ezhl3Uvud+JPI1PtJCHk7zkogXDkMbdWH
X-Gm-Message-State: AOJu0YzcNpkXUzBRiRhsLoZt1OD8MTZC86qFC4koYigf7N+PeDjh7n6i
	aUQ+PCqO4UeSzPxZsnvSfdJMpg7+TidyNbQzQJop85pABRX4cOQlgVeLO6DMJDEkls4FeEeSU/0
	UXJpTDdEyHugwypggrlYhJVAUuor/93xaecv4IO+ikYewvlB/Eks0ru0U1DeZNw==
X-Received: by 2002:a05:600c:3ba4:b0:414:6ed1:19c9 with SMTP id n36-20020a05600c3ba400b004146ed119c9mr36864wms.1.1711047806962;
        Thu, 21 Mar 2024 12:03:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA+dQbSOia0TRyXlLXHGi2/CvzSo5MOn+f3YbI3D9nJIwhUOns3494W0fUEuzJyzxd/T9maQ==
X-Received: by 2002:a05:600c:3ba4:b0:414:6ed1:19c9 with SMTP id n36-20020a05600c3ba400b004146ed119c9mr36816wms.1.1711047805636;
        Thu, 21 Mar 2024 12:03:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-130.dyn.eolo.it. [146.241.249.130])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b004131310a29fsm618682wmq.15.2024.03.21.12.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 12:03:25 -0700 (PDT)
Message-ID: <47a0e30caff2a49d152aed521ef5e512fd11ae99.camel@redhat.com>
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
Date: Thu, 21 Mar 2024 20:03:23 +0100
In-Reply-To: <xhsmhjzmxg40f.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20240219095729.2339914-1-vschneid@redhat.com>
	 <20240219095729.2339914-2-vschneid@redhat.com>
	 <CANn89i+3-zgAkWukFavu1wgf1XG+K9U4BhJWw7H+QKwsfYL4WA@mail.gmail.com>
	 <xhsmho7cbf33q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	 <CANn89iJpwUpAROOq7+ttwTMCZu0=XhS4dgwcs44t-gb7-_ejRg@mail.gmail.com>
	 <xhsmhjzmxg40f.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
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

On Wed, 2024-02-21 at 17:45 +0100, Valentin Schneider wrote:
> On 20/02/24 18:42, Eric Dumazet wrote:
> > On Tue, Feb 20, 2024 at 6:38=E2=80=AFPM Valentin Schneider <vschneid@re=
dhat.com> wrote:
> > > Hm so that would indeed prevent a concurrent inet_twsk_schedule() fro=
m
> > > re-arming the timer, but in case the calls are interleaved like so:
> > >=20
> > >                              tcp_time_wait()
> > >                                inet_twsk_hashdance()
> > >   inet_twsk_deschedule_put()
> > >     timer_shutdown_sync()
> > >                                inet_twsk_schedule()
> > >=20
> > > inet_twsk_hashdance() will have left the refcounts including a count =
for
> > > the timer, and we won't arm the timer to clear it via the timer callb=
ack
> > > (via inet_twsk_kill()) - the patch in its current form relies on the =
timer
> > > being re-armed for that.
> > >=20
> > > I don't know if there's a cleaner way to do this, but we could catch =
that
> > > in inet_twsk_schedule() and issue the inet_twsk_kill() directly if we=
 can
> > > tell the timer has been shutdown:
> > > ---
> > > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_s=
ock.c
> > > index 61a053fbd329c..c272da5046bb4 100644
> > > --- a/net/ipv4/inet_timewait_sock.c
> > > +++ b/net/ipv4/inet_timewait_sock.c
> > > @@ -227,7 +227,7 @@ void inet_twsk_deschedule_put(struct inet_timewai=
t_sock *tw)
> > >          * have already gone through {tcp,dcpp}_time_wait(), and we c=
an safely
> > >          * call inet_twsk_kill().
> > >          */
> > > -       if (del_timer_sync(&tw->tw_timer))
> > > +       if (timer_shutdown_sync(&tw->tw_timer))
> > >                 inet_twsk_kill(tw);
> > >         inet_twsk_put(tw);
> > >  }
> > > @@ -267,6 +267,10 @@ void __inet_twsk_schedule(struct inet_timewait_s=
ock *tw, int timeo, bool rearm)
> > >                                                      LINUX_MIB_TIMEWA=
ITED);
> > >                 BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
> >=20
> > Would not a shutdown timer return a wrong mod_timer() value here ?
> >=20
> > Instead of BUG_ON(), simply release the refcount ?
> >=20
>=20
> Unfortunately a shutdown timer would return the same as a non-shutdown on=
e:
>=20
>  * Return:
>  * * %0 - The timer was inactive and started or was in shutdown
>  *	  state and the operation was discarded
>=20
> and now that you've pointed this out, I realize it's racy to check the
> state of the timer after the mod_timer():
>=20
>   BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
>                                                         inet_twsk_desched=
ule_put()
>                                                           timer_shutdown_=
sync()
>                                                           inet_twsk_kill(=
)
>   if (!tw->tw_timer.function)
>     inet_twsk_kill()
>=20
>=20
> I've looked into messing about with the return values of mod_timer() to g=
et
> the info that the timer was shutdown, but the only justification for this
> is that here we rely on the timer_base lock to serialize
> inet_twsk_schedule() vs inet_twsk_deschedule_put().
>=20
> AFAICT the alternative is adding local serialization like so, which I'm n=
ot
> the biggest fan of but couldn't think of a neater approach:
> ---
> diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait=
_sock.h
> index f28da08a37b4e..39bb0c148d4ee 100644
> --- a/include/net/inet_timewait_sock.h
> +++ b/include/net/inet_timewait_sock.h
> @@ -75,6 +75,7 @@ struct inet_timewait_sock {
>  	struct timer_list	tw_timer;
>  	struct inet_bind_bucket	*tw_tb;
>  	struct inet_bind2_bucket	*tw_tb2;
> +	struct spinlock      tw_timer_lock;
>  };
>  #define tw_tclass tw_tos
> =20
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index 61a053fbd329c..2471516f9c61d 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -193,6 +193,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const stru=
ct sock *sk,
>  		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
>  		twsk_net_set(tw, sock_net(sk));
>  		timer_setup(&tw->tw_timer, tw_timer_handler, 0);
> +		spin_lock_init(&tw->tw_timer_lock);
>  		/*
>  		 * Because we use RCU lookups, we should not set tw_refcnt
>  		 * to a non null value before everything is setup for this
> @@ -227,8 +228,11 @@ void inet_twsk_deschedule_put(struct inet_timewait_s=
ock *tw)
>  	 * have already gone through {tcp,dcpp}_time_wait(), and we can safely
>  	 * call inet_twsk_kill().
>  	 */
> -	if (del_timer_sync(&tw->tw_timer))
> +	spin_lock(&tw->tw_timer_lock);
> +	if (timer_shutdown_sync(&tw->tw_timer))
>  		inet_twsk_kill(tw);
> +	spin_unlock(&tw->tw_timer_lock);
> +
>  	inet_twsk_put(tw);
>  }
>  EXPORT_SYMBOL(inet_twsk_deschedule_put);
> @@ -262,11 +266,25 @@ void __inet_twsk_schedule(struct inet_timewait_sock=
 *tw, int timeo, bool rearm)
> =20
>  	if (!rearm) {
>  		bool kill =3D timeo <=3D 4*HZ;
> +		bool pending;
> =20
>  		__NET_INC_STATS(twsk_net(tw), kill ? LINUX_MIB_TIMEWAITKILLED :
>  						     LINUX_MIB_TIMEWAITED);
> +		spin_lock(&tw->tw_timer_lock);
>  		BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
> +		pending =3D timer_pending(&tw->tw_timer);
>  		refcount_inc(&tw->tw_dr->tw_refcount);
> +
> +		/*
> +		 * If the timer didn't become pending under tw_timer_lock, then
> +		 * it means it has been shutdown by inet_twsk_deschedule_put()
> +		 * prior to this invocation. All that remains is to clean up the
> +		 * timewait.
> +		 */
> +		if (!pending)
> +			inet_twsk_kill(tw);
> +
> +		spin_unlock(&tw->tw_timer_lock);
>  	} else {
>  		mod_timer_pending(&tw->tw_timer, jiffies + timeo);
>  	}

I understand that adding another lock here is a no-go.

I'm wondering if we could move the inet_twsk_schedule() under the ehash
lock, to avoid the need for acquiring the additional tw reference and
thus avoid the ref leak when inet_twsk_deschedule_put() clashes with
tcp_time_wait().

Something alike the following (completely untested!!!):

WDYT?
---
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_s=
ock.h
index f28da08a37b4..d696d10dc8ae 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -93,8 +93,10 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct =
sock *sk,
 					   struct inet_timewait_death_row *dr,
 					   const int state);
=20
-void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
-			 struct inet_hashinfo *hashinfo);
+void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
+				  struct sock *sk,
+				  struct inet_hashinfo *hashinfo,
+				  int timeo);
=20
 void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo,
 			  bool rearm);
diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
index 64d805b27add..8e108a89d8e4 100644
--- a/net/dccp/minisocks.c
+++ b/net/dccp/minisocks.c
@@ -58,11 +58,10 @@ void dccp_time_wait(struct sock *sk, int state, int tim=
eo)
 		 * we complete the initialization.
 		 */
 		local_bh_disable();
-		inet_twsk_schedule(tw, timeo);
 		/* Linkage updates.
 		 * Note that access to tw after this point is illegal.
 		 */
-		inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
+		inet_twsk_hashdance_schedule(tw, sk, &dccp_hashinfo, timeo);
 		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index e8de45d34d56..dd314b06c0cd 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -97,8 +97,10 @@ static void inet_twsk_add_node_rcu(struct inet_timewait_=
sock *tw,
  * Essentially we whip up a timewait bucket, copy the relevant info into i=
t
  * from the SK, and mess with hash chains and list linkage.
  */
-void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
-			   struct inet_hashinfo *hashinfo)
+void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
+				  struct sock *sk,
+				  struct inet_hashinfo *hashinfo,
+				  int timeo)
 {
 	const struct inet_sock *inet =3D inet_sk(sk);
 	const struct inet_connection_sock *icsk =3D inet_csk(sk);
@@ -135,6 +137,8 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw,=
 struct sock *sk,
 	if (__sk_nulls_del_node_init_rcu(sk))
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
=20
+	inet_twsk_schedule(tw, timeo);
+
 	spin_unlock(lock);
=20
 	/* tw_refcnt is set to 3 because we have :
@@ -148,7 +152,7 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw,=
 struct sock *sk,
 	 */
 	refcount_set(&tw->tw_refcnt, 3);
 }
-EXPORT_SYMBOL_GPL(inet_twsk_hashdance);
+EXPORT_SYMBOL_GPL(inet_twsk_hashdance_schedule);
=20
 static void tw_timer_handler(struct timer_list *t)
 {
@@ -217,7 +221,7 @@ EXPORT_SYMBOL_GPL(inet_twsk_alloc);
  */
 void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
 {
-	if (del_timer_sync(&tw->tw_timer))
+	if (timer_shutdown_sync(&tw->tw_timer))
 		inet_twsk_kill(tw);
 	inet_twsk_put(tw);
 }
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index f0761f060a83..8d5ec48a1837 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -343,11 +343,10 @@ void tcp_time_wait(struct sock *sk, int state, int ti=
meo)
 		 * we complete the initialization.
 		 */
 		local_bh_disable();
-		inet_twsk_schedule(tw, timeo);
 		/* Linkage updates.
 		 * Note that access to tw after this point is illegal.
 		 */
-		inet_twsk_hashdance(tw, sk, net->ipv4.tcp_death_row.hashinfo);
+		inet_twsk_hashdance_schedule(tw, sk, net->ipv4.tcp_death_row.hashinfo, t=
imeo);
 		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this


