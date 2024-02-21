Return-Path: <linux-kernel+bounces-75133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EB385E3AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2511C21542
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84283A07;
	Wed, 21 Feb 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpTyxtcF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6182882D9B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533944; cv=none; b=eRUsMN6h3PY8bQ208FBkBOWHFnmOk2IW8Xg0ovuMf+iykbBF+V2ydupFlIIkIomitC0Cm0cMEV6wiPKFSy6dUUlJPgOVZTV6G1qnYe8L8qfHngXpMcbRbkonMDx0vIu3B4DQMGHmSKXUiD0RsqArIZDhZ2dZ4q9uhET7VLgxYVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533944; c=relaxed/simple;
	bh=PiK6GLh5Bbli9ksKDaj+Hoj+StNAExwyesgIoPSxmmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ECcRQvFHn5DzthSEM2unwjTWFpSgM1tOIL6Yyis3ANaup74rj++x4oWlZqqv10tUeI3JjY53ymEq/bYPAuahV0wcFpMVi81smu6b2j1dPn5UYOfWO51rMd+n9x5UI3Nw1VodD2a0UEDlbYRC801eadyuW3FMwSduE04B+ADn/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpTyxtcF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708533941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Aa0856KKiSIs4J8EHY0Puegx6vd1lMlKDsy7EPPIWE=;
	b=cpTyxtcF5EchStDgKFTvIQsj6jTFLjq3BSva/XRzccz21ybKD7adsG5ZYUEXetkdxvJttC
	xJPnl+aw62iDDj+bYVx3CweSXOETZ8/qqcZIxHHyX6aVDbuUuPtlLEGOTwM6k3DLdVRSP8
	ULGynDAW6mgEnVx9/TxasEP+fSDVvSI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-TQv-iCTJPsW0mov5tNxeZA-1; Wed, 21 Feb 2024 11:45:39 -0500
X-MC-Unique: TQv-iCTJPsW0mov5tNxeZA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso34012015e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708533938; x=1709138738;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Aa0856KKiSIs4J8EHY0Puegx6vd1lMlKDsy7EPPIWE=;
        b=cUpFo9KQxzaE4QDJRqjK5p0Wewyx820MVCU//V8Gvxq2AW2Sy3GnavbyXuCZK6jR8w
         gA+sjDUZWZwRTaaOKmPvMS/9oZ2ewAQhMGNeSvqtuOZJcZIdrm+oqUXMqpTtaXyiY8XZ
         1sh8J5aH8XpkRFrPXaCUJW8voi9qVTmXaijHKmWEjLeO9suZwF+fLMA/U19ZpGuz0/1t
         XJ4tvy6lM6KhkUUW560716NhOPKz3iQAMPV3lH7tClw/BKEiMGWIc0zFabV7gJFEjhyi
         zN2julD50raeUfn1mlqvZhuvP88JQ5YUF5y9S0hE2ZGZYty9FxLXZfniyEcJ0ZwJw1aX
         EwOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNuVQL9eW3q3m3xRlMpWSDIZLnAS1IK3I2AEdwltkF+vR6S7f8PgckCXmYyY6NjFrFhjbSEW+tDdJLsP+7elsJIkWQck/hxcPgL+9Z
X-Gm-Message-State: AOJu0Yyp4Zu6FzGeKPU/AaqmvWmlnsIULA9gIVd/Dqr4IDn7yixDO8m2
	fzievFkPWB14sH8fKrUUnUfB92KraJk+W1jmofnGhJ9dsru4+SSl2CxZDyjAKi/gw5x5kDgtFmP
	819IdVGvr+MebNvfKi/6ymSq6KFvgLHkh0kUYhFvMedbv2LBK8ynsl+CeTDyb1g==
X-Received: by 2002:a05:600c:444a:b0:411:c8a7:7b09 with SMTP id v10-20020a05600c444a00b00411c8a77b09mr32788wmn.10.1708533938254;
        Wed, 21 Feb 2024 08:45:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWNC9F/v+b8Zz5OO/sN9jdb2v+iFDyGNJnulQT9iuh/19ax1wa9bZTXvgr4iAAWnO9GFiDvA==
X-Received: by 2002:a05:600c:444a:b0:411:c8a7:7b09 with SMTP id v10-20020a05600c444a00b00411c8a77b09mr32762wmn.10.1708533937888;
        Wed, 21 Feb 2024 08:45:37 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ay17-20020a05600c1e1100b004127876647fsm1867978wmb.41.2024.02.21.08.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:45:37 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, mleitner@redhat.com, David Ahern
 <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/1] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <CANn89iJpwUpAROOq7+ttwTMCZu0=XhS4dgwcs44t-gb7-_ejRg@mail.gmail.com>
References: <20240219095729.2339914-1-vschneid@redhat.com>
 <20240219095729.2339914-2-vschneid@redhat.com>
 <CANn89i+3-zgAkWukFavu1wgf1XG+K9U4BhJWw7H+QKwsfYL4WA@mail.gmail.com>
 <xhsmho7cbf33q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CANn89iJpwUpAROOq7+ttwTMCZu0=XhS4dgwcs44t-gb7-_ejRg@mail.gmail.com>
Date: Wed, 21 Feb 2024 17:45:36 +0100
Message-ID: <xhsmhjzmxg40f.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/02/24 18:42, Eric Dumazet wrote:
> On Tue, Feb 20, 2024 at 6:38=E2=80=AFPM Valentin Schneider <vschneid@redh=
at.com> wrote:
>> Hm so that would indeed prevent a concurrent inet_twsk_schedule() from
>> re-arming the timer, but in case the calls are interleaved like so:
>>
>>                              tcp_time_wait()
>>                                inet_twsk_hashdance()
>>   inet_twsk_deschedule_put()
>>     timer_shutdown_sync()
>>                                inet_twsk_schedule()
>>
>> inet_twsk_hashdance() will have left the refcounts including a count for
>> the timer, and we won't arm the timer to clear it via the timer callback
>> (via inet_twsk_kill()) - the patch in its current form relies on the tim=
er
>> being re-armed for that.
>>
>> I don't know if there's a cleaner way to do this, but we could catch that
>> in inet_twsk_schedule() and issue the inet_twsk_kill() directly if we can
>> tell the timer has been shutdown:
>> ---
>> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock=
c
>> index 61a053fbd329c..c272da5046bb4 100644
>> --- a/net/ipv4/inet_timewait_sock.c
>> +++ b/net/ipv4/inet_timewait_sock.c
>> @@ -227,7 +227,7 @@ void inet_twsk_deschedule_put(struct inet_timewait_s=
ock *tw)
>>          * have already gone through {tcp,dcpp}_time_wait(), and we can =
safely
>>          * call inet_twsk_kill().
>>          */
>> -       if (del_timer_sync(&tw->tw_timer))
>> +       if (timer_shutdown_sync(&tw->tw_timer))
>>                 inet_twsk_kill(tw);
>>         inet_twsk_put(tw);
>>  }
>> @@ -267,6 +267,10 @@ void __inet_twsk_schedule(struct inet_timewait_sock=
 *tw, int timeo, bool rearm)
>>                                                      LINUX_MIB_TIMEWAITE=
D);
>>                 BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
>
> Would not a shutdown timer return a wrong mod_timer() value here ?
>
> Instead of BUG_ON(), simply release the refcount ?
>

Unfortunately a shutdown timer would return the same as a non-shutdown one:

 * Return:
 * * %0 - The timer was inactive and started or was in shutdown
 *	  state and the operation was discarded

and now that you've pointed this out, I realize it's racy to check the
state of the timer after the mod_timer():

  BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
                                                        inet_twsk_deschedul=
e_put()
                                                          timer_shutdown_sy=
nc()
                                                          inet_twsk_kill()
  if (!tw->tw_timer.function)
    inet_twsk_kill()


I've looked into messing about with the return values of mod_timer() to get
the info that the timer was shutdown, but the only justification for this
is that here we rely on the timer_base lock to serialize
inet_twsk_schedule() vs inet_twsk_deschedule_put().

AFAICT the alternative is adding local serialization like so, which I'm not
the biggest fan of but couldn't think of a neater approach:
---
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_s=
ock.h
index f28da08a37b4e..39bb0c148d4ee 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -75,6 +75,7 @@ struct inet_timewait_sock {
 	struct timer_list	tw_timer;
 	struct inet_bind_bucket	*tw_tb;
 	struct inet_bind2_bucket	*tw_tb2;
+	struct spinlock      tw_timer_lock;
 };
 #define tw_tclass tw_tos
=20
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 61a053fbd329c..2471516f9c61d 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -193,6 +193,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct=
 sock *sk,
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));
 		timer_setup(&tw->tw_timer, tw_timer_handler, 0);
+		spin_lock_init(&tw->tw_timer_lock);
 		/*
 		 * Because we use RCU lookups, we should not set tw_refcnt
 		 * to a non null value before everything is setup for this
@@ -227,8 +228,11 @@ void inet_twsk_deschedule_put(struct inet_timewait_soc=
k *tw)
 	 * have already gone through {tcp,dcpp}_time_wait(), and we can safely
 	 * call inet_twsk_kill().
 	 */
-	if (del_timer_sync(&tw->tw_timer))
+	spin_lock(&tw->tw_timer_lock);
+	if (timer_shutdown_sync(&tw->tw_timer))
 		inet_twsk_kill(tw);
+	spin_unlock(&tw->tw_timer_lock);
+
 	inet_twsk_put(tw);
 }
 EXPORT_SYMBOL(inet_twsk_deschedule_put);
@@ -262,11 +266,25 @@ void __inet_twsk_schedule(struct inet_timewait_sock *=
tw, int timeo, bool rearm)
=20
 	if (!rearm) {
 		bool kill =3D timeo <=3D 4*HZ;
+		bool pending;
=20
 		__NET_INC_STATS(twsk_net(tw), kill ? LINUX_MIB_TIMEWAITKILLED :
 						     LINUX_MIB_TIMEWAITED);
+		spin_lock(&tw->tw_timer_lock);
 		BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
+		pending =3D timer_pending(&tw->tw_timer);
 		refcount_inc(&tw->tw_dr->tw_refcount);
+
+		/*
+		 * If the timer didn't become pending under tw_timer_lock, then
+		 * it means it has been shutdown by inet_twsk_deschedule_put()
+		 * prior to this invocation. All that remains is to clean up the
+		 * timewait.
+		 */
+		if (!pending)
+			inet_twsk_kill(tw);
+
+		spin_unlock(&tw->tw_timer_lock);
 	} else {
 		mod_timer_pending(&tw->tw_timer, jiffies + timeo);
 	}


