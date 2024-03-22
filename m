Return-Path: <linux-kernel+bounces-112023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90971887449
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B7F2841CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3F37FBD1;
	Fri, 22 Mar 2024 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQcvxP3+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C027D7F7FD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711141105; cv=none; b=UGw7aJdgbO/vlETvgAJuwCBj2+ZFpYGM10tst6EBalbHeSFZuhPkWCweIK+Hdw0BQ2xpQiJcxQhfEjcTe1svQo8yzSvN0dafc2E7cDrpKW7BMc7ISufLXv0WS6Ts7+wOiaRuWNaTBnl8poSA+I0CG/dxW24NAJFZU4clcjOcjd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711141105; c=relaxed/simple;
	bh=oRijrCqkfvuJbaioVMlF9qQNlL9D7RaKBKPjPirF8R0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QHKJEX/Tu4u2eC6SjbtLJDpR0EMZMXBxG1DxGCuy+8QkFv0Mige84VDhEWNvIFYYMuJBwMrTgT/Vxt7JL9KYweE0h/Gm0bBLgEBc+QOi4HUolxglTyXmBBcJqwzq1+QX/GffbTRLVpvB+Vgn/cjY8cq/dLfUGKrKqU/3FHEhLio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQcvxP3+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711141101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ueWoGIECvU3muzYVe58YZeiZCfKfcFXEZXrDyAApJrE=;
	b=IQcvxP3+d7TfnmYPiitx/h4DziJf9vICTp6loJ5PaKF6QUxVDrzsF7FbtiWT/0lSxgD6Yg
	2DmodpWmJ0NxPn/OnPek8H3edY6gFmkvcLktv+QqNvqSz0fk/BB6jrGVDULcEWrGJBGkEI
	FRK6Czhit/HdGwL9WRSbTiibUTmZy9I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-yIlCiZRfOzy47XyFLSE_hw-1; Fri, 22 Mar 2024 16:58:20 -0400
X-MC-Unique: yIlCiZRfOzy47XyFLSE_hw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69174e4acfcso30372726d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711141100; x=1711745900;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueWoGIECvU3muzYVe58YZeiZCfKfcFXEZXrDyAApJrE=;
        b=DPjpJ1nUml5WyYeKzwDCs0lDSzFXMzqFDywh3yxVU18b/WSMLTaQYVlgySulHAPQSS
         AI9mkIbPozydunPCVhyqCEINFbC+rhj8ZWPDDX8Fc09H+CTUCMBakNe0EMTc225nKDTV
         MizdQLWPUSOyc3BkadPerAzKL0KJPdTeVnSus8NoXNnSyU5vYAj60or1+xsyo63LwVfR
         4tnXQTOoKXIQjEUFABCyT94niJ20Gc0sAKWgd8tAfP1PkgcXU1/gTwlYcfCnSvuHdjNa
         I9XJ+aWw0/C4K21fX2GOc3P6rOVc8NR1un8ZszcwS0qTaHNQIq+E2KIR5flCP/Vy1uY8
         p11Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBRYUIXnYbWDHAqNJ4LPuhA/u0B1UHPpTQKm4hctvxRHu4F2Zjn7zaNee27MzQc5PWQiK99A/G5LvbVFcQNy3DT1esy7v1v7eq3dAG
X-Gm-Message-State: AOJu0YzvdHkJmzX+VzqLgXkkUEG385QWUdfZh6qOsNYLOW8N/W7Xz6cI
	CQe9tseJApE+WZAW2T7w6Md4QdH7LKK6qIPTyc1j6N7R2gM8htzadD7YXwF+ub5r+4sCJTzi9Ns
	qh0/2hacm/9VRjsU3PzfbI0ACPMDj3Bb0Kjfs7iCUet059FwkeOh/yonuHbne0A==
X-Received: by 2002:a05:6214:2425:b0:696:706c:ed4c with SMTP id gy5-20020a056214242500b00696706ced4cmr624776qvb.44.1711141099885;
        Fri, 22 Mar 2024 13:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIc7MPCSOxFAGygw4UTL+OZC1CHViTfCZING4P6wzWNzvYnub16EIR/2COXuCM1mn83Kmoew==
X-Received: by 2002:a05:6214:2425:b0:696:706c:ed4c with SMTP id gy5-20020a056214242500b00696706ced4cmr624752qvb.44.1711141099470;
        Fri, 22 Mar 2024 13:58:19 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id kk11-20020a056214508b00b00690df461ecbsm1440758qvb.10.2024.03.22.13.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 13:58:18 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 mleitner@redhat.com, David Ahern <dsahern@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Tomas Glozar <tglozar@redhat.com>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/1] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <47a0e30caff2a49d152aed521ef5e512fd11ae99.camel@redhat.com>
References: <20240219095729.2339914-1-vschneid@redhat.com>
 <20240219095729.2339914-2-vschneid@redhat.com>
 <CANn89i+3-zgAkWukFavu1wgf1XG+K9U4BhJWw7H+QKwsfYL4WA@mail.gmail.com>
 <xhsmho7cbf33q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CANn89iJpwUpAROOq7+ttwTMCZu0=XhS4dgwcs44t-gb7-_ejRg@mail.gmail.com>
 <xhsmhjzmxg40f.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <47a0e30caff2a49d152aed521ef5e512fd11ae99.camel@redhat.com>
Date: Fri, 22 Mar 2024 21:58:14 +0100
Message-ID: <xhsmh1q82c7bt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21/03/24 20:03, Paolo Abeni wrote:
> On Wed, 2024-02-21 at 17:45 +0100, Valentin Schneider wrote:
>> @@ -262,11 +266,25 @@ void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo, bool rearm)
>>  
>>  	if (!rearm) {
>>  		bool kill = timeo <= 4*HZ;
>> +		bool pending;
>>  
>>  		__NET_INC_STATS(twsk_net(tw), kill ? LINUX_MIB_TIMEWAITKILLED :
>>  						     LINUX_MIB_TIMEWAITED);
>> +		spin_lock(&tw->tw_timer_lock);
>>  		BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
>> +		pending = timer_pending(&tw->tw_timer);
>>  		refcount_inc(&tw->tw_dr->tw_refcount);
>> +
>> +		/*
>> +		 * If the timer didn't become pending under tw_timer_lock, then
>> +		 * it means it has been shutdown by inet_twsk_deschedule_put()
>> +		 * prior to this invocation. All that remains is to clean up the
>> +		 * timewait.
>> +		 */
>> +		if (!pending)
>> +			inet_twsk_kill(tw);
>> +
>> +		spin_unlock(&tw->tw_timer_lock);
>>  	} else {
>>  		mod_timer_pending(&tw->tw_timer, jiffies + timeo);
>>  	}
>
> I understand that adding another lock here is a no-go.
>
> I'm wondering if we could move the inet_twsk_schedule() under the ehash
> lock, to avoid the need for acquiring the additional tw reference and
> thus avoid the ref leak when inet_twsk_deschedule_put() clashes with
> tcp_time_wait().
>
> Something alike the following (completely untested!!!):
>
> WDYT?

Thanks for the suggestion! I've been preempted by other things and haven't
had time to think more about this, so I really appreciate it :)

> ---
> diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
> index f28da08a37b4..d696d10dc8ae 100644
> --- a/include/net/inet_timewait_sock.h
> +++ b/include/net/inet_timewait_sock.h
> @@ -93,8 +93,10 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
>  					   struct inet_timewait_death_row *dr,
>  					   const int state);
>  
> -void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
> -			 struct inet_hashinfo *hashinfo);
> +void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
> +				  struct sock *sk,
> +				  struct inet_hashinfo *hashinfo,
> +				  int timeo);
>  
>  void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo,
>  			  bool rearm);
> diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
> index 64d805b27add..8e108a89d8e4 100644
> --- a/net/dccp/minisocks.c
> +++ b/net/dccp/minisocks.c
> @@ -58,11 +58,10 @@ void dccp_time_wait(struct sock *sk, int state, int timeo)
>  		 * we complete the initialization.
>  		 */
>  		local_bh_disable();
> -		inet_twsk_schedule(tw, timeo);
>  		/* Linkage updates.
>  		 * Note that access to tw after this point is illegal.
>  		 */
> -		inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
> +		inet_twsk_hashdance_schedule(tw, sk, &dccp_hashinfo, timeo);
>  		local_bh_enable();
>  	} else {
>  		/* Sorry, if we're out of memory, just CLOSE this
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> index e8de45d34d56..dd314b06c0cd 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -97,8 +97,10 @@ static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
>   * Essentially we whip up a timewait bucket, copy the relevant info into it
>   * from the SK, and mess with hash chains and list linkage.
>   */
> -void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
> -			   struct inet_hashinfo *hashinfo)
> +void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
> +				  struct sock *sk,
> +				  struct inet_hashinfo *hashinfo,
> +				  int timeo)
>  {
>  	const struct inet_sock *inet = inet_sk(sk);
>  	const struct inet_connection_sock *icsk = inet_csk(sk);
> @@ -135,6 +137,8 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
>  	if (__sk_nulls_del_node_init_rcu(sk))
>  		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>  
> +	inet_twsk_schedule(tw, timeo);
> +
>  	spin_unlock(lock);
>

That arms the timer before the refcounts are set up in the tail end of
the hashdance, which is what we have upstream ATM.

Unfortunately this relies on the timer being TIMER_PINNED and having
softirqs disabled: the timer can only be enqueued on the local CPU, and it
can't fire until softirqs are enabled, so refcounts can safely be updated
after it is armed because it can't fire.

For dynamic CPU isolation we want to make this timer not-pinned, so that it
can be scheduled on housekeeping CPUs. However that means the
local_bh_disable() won't prevent the timer from firing, and that means the
refcounts need to be written to before it is armed.

As a worst-case example, under PREEMPT_RT local_bh_disable() and
spin_lock() keep the context preemptible, so we could have:

inet_twsk_hashdance_schedule()            tw_timer_handler()
  inet_twsk_schedule()
  <this context gets preempted for a while>
                                            inet_twsk_kill()
  refcount_set()                                           


Using the ehash lock is clever though, and the first thing inet_twsk_kill()
does is grabbing it... Maybe something like the below? It (should) prevent
this interleaving race:

                             tcp_time_wait()
                               inet_twsk_hashdance()
  inet_twsk_deschedule_put()
    del_timer_sync()
                               inet_twsk_schedule()

whether it is sane is another thing :-)

---
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index f28da08a37b4e..d696d10dc8aec 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -93,8 +93,10 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 					   struct inet_timewait_death_row *dr,
 					   const int state);
 
-void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
-			 struct inet_hashinfo *hashinfo);
+void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
+				  struct sock *sk,
+				  struct inet_hashinfo *hashinfo,
+				  int timeo);
 
 void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo,
 			  bool rearm);
diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
index 64d805b27adde..8e108a89d8e4b 100644
--- a/net/dccp/minisocks.c
+++ b/net/dccp/minisocks.c
@@ -58,11 +58,10 @@ void dccp_time_wait(struct sock *sk, int state, int timeo)
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
index 5befa4de5b241..879747600e7b5 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -44,14 +44,14 @@ void inet_twsk_bind_unhash(struct inet_timewait_sock *tw,
 	__sock_put((struct sock *)tw);
 }
 
-/* Must be called with locally disabled BHs. */
-static void inet_twsk_kill(struct inet_timewait_sock *tw)
+static void __inet_twsk_kill(struct inet_timewait_sock *tw, spinlock_t *lock)
+__releases(lock)
 {
 	struct inet_hashinfo *hashinfo = tw->tw_dr->hashinfo;
-	spinlock_t *lock = inet_ehash_lockp(hashinfo, tw->tw_hash);
 	struct inet_bind_hashbucket *bhead, *bhead2;
 
-	spin_lock(lock);
+	lockdep_assert_held(lock);
+
 	sk_nulls_del_node_init_rcu((struct sock *)tw);
 	spin_unlock(lock);
 
@@ -71,6 +71,16 @@ static void inet_twsk_kill(struct inet_timewait_sock *tw)
 	inet_twsk_put(tw);
 }
 
+/* Must be called with locally disabled BHs. */
+static void inet_twsk_kill(struct inet_timewait_sock *tw)
+{
+	struct inet_hashinfo *hashinfo = tw->tw_dr->hashinfo;
+	spinlock_t *lock = inet_ehash_lockp(hashinfo, tw->tw_hash);
+
+	spin_lock(lock);
+	__inet_twsk_kill(tw, lock);
+}
+
 void inet_twsk_free(struct inet_timewait_sock *tw)
 {
 	struct module *owner = tw->tw_prot->owner;
@@ -97,8 +107,10 @@ static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
  * Essentially we whip up a timewait bucket, copy the relevant info into it
  * from the SK, and mess with hash chains and list linkage.
  */
-void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
-			   struct inet_hashinfo *hashinfo)
+void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
+				  struct sock *sk,
+				  struct inet_hashinfo *hashinfo,
+				  int timeo)
 {
 	const struct inet_sock *inet = inet_sk(sk);
 	const struct inet_connection_sock *icsk = inet_csk(sk);
@@ -135,20 +147,22 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 	if (__sk_nulls_del_node_init_rcu(sk))
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 
-	spin_unlock(lock);
 
 	/* tw_refcnt is set to 3 because we have :
 	 * - one reference for bhash chain.
 	 * - one reference for ehash chain.
 	 * - one reference for timer.
-	 * We can use atomic_set() because prior spin_lock()/spin_unlock()
-	 * committed into memory all tw fields.
-	 * Also note that after this point, we lost our implicit reference
-	 * so we are not allowed to use tw anymore.
+	 * XXX: write blurb about ensure storeing happen before the refcount is udpated
 	 */
+	smp_wmb();
 	refcount_set(&tw->tw_refcnt, 3);
+
+	inet_twsk_schedule(tw, timeo);
+
+	spin_unlock(lock);
+
 }
-EXPORT_SYMBOL_GPL(inet_twsk_hashdance);
+EXPORT_SYMBOL_GPL(inet_twsk_hashdance_schedule);
 
 static void tw_timer_handler(struct timer_list *t)
 {
@@ -217,8 +231,16 @@ EXPORT_SYMBOL_GPL(inet_twsk_alloc);
  */
 void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
 {
-	if (del_timer_sync(&tw->tw_timer))
-		inet_twsk_kill(tw);
+	struct inet_hashinfo *hashinfo = tw->tw_dr->hashinfo;
+	spinlock_t *lock = inet_ehash_lockp(hashinfo, tw->tw_hash);
+
+	spin_lock(lock);
+	if (timer_shutdown_sync(&tw->tw_timer)) {
+		/* releases @lock */
+		__inet_twsk_kill(tw, lock);
+	} else {
+		spin_unlock(lock);
+	}
 	inet_twsk_put(tw);
 }
 EXPORT_SYMBOL(inet_twsk_deschedule_put);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9e85f2a0bddd4..6621a395fd8e5 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -343,11 +343,10 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		 * we complete the initialization.
 		 */
 		local_bh_disable();
-		inet_twsk_schedule(tw, timeo);
 		/* Linkage updates.
 		 * Note that access to tw after this point is illegal.
 		 */
-		inet_twsk_hashdance(tw, sk, net->ipv4.tcp_death_row.hashinfo);
+		inet_twsk_hashdance_schedule(tw, sk, net->ipv4.tcp_death_row.hashinfo, timeo);
 		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this


