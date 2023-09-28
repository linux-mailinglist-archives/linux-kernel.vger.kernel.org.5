Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657C87B1250
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjI1GGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjI1GGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:06:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CE199;
        Wed, 27 Sep 2023 23:06:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b2b53e17feso327861466b.3;
        Wed, 27 Sep 2023 23:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695881176; x=1696485976; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TGpUFaLfaaSllZ7CWKk+QI4sn9XcFVatmo3TMonjq5c=;
        b=GV87FQ1W4WeoQEFKSVYqGzCohMid+jS95vtNZYrx3cmTPVU9yQDG/YDwoK+ZrQAI8z
         McqLoGCnPDyL3VObwbB3vkLz5rkT8giXUiOHF0eRnnNmhYx24zcHStgo6a8b1bsLPpoE
         41+dEK3tIL0RTd9fRezUyiv24+OU2ToZzBaRP7CQ8xEUuSo4v611YxjF44ITDhEoDyxd
         JIa/7yMD+Pod09xqJuy+nbSzd4syvPkqdUl4ZlCmjpFSFOsCulEeJE7FVBuqxyvcij2f
         YrA6E9gSKfIr0TXENMVAVKPBqFGihJ5ak6ws3qb7+HNvyQ+dBNr2FbRkbIsOkiF/dKo3
         4phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695881176; x=1696485976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGpUFaLfaaSllZ7CWKk+QI4sn9XcFVatmo3TMonjq5c=;
        b=fRrZOFXtEz0af2DAmmr439WleZDpODvhj7p4SW0ckbCGsG0w+VCBew8aIIEAv8Mtkp
         ry/dy4ktCRlywj3lk6Qt5m45reCvTierWeUK68SKEdpDbQZmuP7t2grOlsAtRmQNdUSa
         BttM/1DKamHxWU0EWSQyDIXeS4S+G3OHlbpZfSdPElpxM58LBjGroV+8a+dY7LkO/rhg
         hnThMtcKA32I88m7doQQAV3CMO8LsCidiNnfdk++aOO0Yuu7hWTmaBgJ3YnU6eQIMtr7
         O23p0AZxAp05r+YGAnGOFDU8MhbIhJSy9GSi73PAK6i6cdcM4l43frSnD5SwhILXjG/G
         GvZA==
X-Gm-Message-State: AOJu0YwpFctLlwmZPhiDMe44rbQx/GitNyvXypLJ9P+WdTmIiQGFCwkB
        ey7k5mYJ7DrdxN2Oc4wTSxGWJeB8aWE=
X-Google-Smtp-Source: AGHT+IE3YfH/wn9WpyaNFGWQVilUtmvnlYiuOXCT6kIQyI7K87BGo2x0aO+Y//gkDHBn5VT1maVoPA==
X-Received: by 2002:a17:906:cc5a:b0:9aa:2c5b:6591 with SMTP id mm26-20020a170906cc5a00b009aa2c5b6591mr291165ejb.9.1695881176195;
        Wed, 27 Sep 2023 23:06:16 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id zg22-20020a170907249600b009a5f1d15642sm10256169ejb.158.2023.09.27.23.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 23:06:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id DB01427C0054;
        Thu, 28 Sep 2023 02:06:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 28 Sep 2023 02:06:12 -0400
X-ME-Sender: <xms:1BcVZSmaJ1e_IlmAFDf_4YBqGN5g0Ia7KkbjImd5wrwjWf_NpfCjGw>
    <xme:1BcVZZ2VH6TutTKog4YPfDixlO1w9ug0iNrZIySfoP1MoBB3X7Dq2g6lezdPdnojQ
    RFsb3erb0mGgX7ToQ>
X-ME-Received: <xmr:1BcVZQoa-ktDV5DZLE2nrcYcXUabwE78R9LE6jhdA06D5MHFbDEvNWVxqJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:1BcVZWl-_f5Hv8lRF4rvHtNQ6Hv5hK5UBj7EXQC2Q-79WLubFFN7bg>
    <xmx:1BcVZQ3tkCQrO8wK96gDhqqXrig2oM7WDX7KSVzdyAP6HNkLDzKY2A>
    <xmx:1BcVZds4kRVsopHaoGYrvumNkjPtA5zWeGa4fFJv_8cq_xIxi9yvRw>
    <xmx:1BcVZY7oKvlyM3cq4mdlAOS78a61Bhn7Dbp2eVQ4cM0_diPzFzG8tQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Sep 2023 02:06:11 -0400 (EDT)
Date:   Wed, 27 Sep 2023 23:06:09 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        John Ogness <john.ogness@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [RFC PATCH] srcu: Use try-lock lockdep annotation for NMI-safe
 access.
Message-ID: <ZRUX0YUrXfepRGKE@Boquns-Mac-mini.home>
References: <20230927160231.XRCDDSK4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230927160231.XRCDDSK4@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 06:02:31PM +0200, Sebastian Andrzej Siewior wrote:
> It is claimed that srcu_read_lock_nmisafe() NMI-safe. However it
> triggers a lockdep if used from NMI because lockdep expects a deadlock
> since nothing disables NMIs while the lock is acquired.
> 
> Use a try-lock annotation for srcu_read_lock_nmisafe() to avoid lockdep
> complains if used from NMI.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> The splat:
> | ================================
> | WARNING: inconsistent lock state
> | 6.6.0-rc3-rt5+ #85 Not tainted
> | --------------------------------
> | inconsistent {INITIAL USE} -> {IN-NMI} usage.
> | swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
> | ffffffff828e6c90 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x3a/0x50
> | {INITIAL USE} state was registered at:
> …
> |        CPU0
> |        ----
> |   lock(console_srcu);
> |   <Interrupt>
> |     lock(console_srcu);
> |
> |  *** DEADLOCK ***
> |
> 
> My guess is that trylock annotation should not apply to
> rcu_lock_acquire(). This would distinguish it from from non-NMI safe
> srcu_read_lock_nmisafe() and NMI check in rcu_read_unlock() is only
> there to survive if accidentally used in-NMI.

I think this is a "side-effect" of commit f0f44752f5f6 ("rcu: Annotate
SRCU's update-side lockdep dependencies"). In verify_lock_unused(), i.e.
the checking for NMI lock usages, the logic is that

1)	read lock usages in NMI conflicts with write lock usage in
	normal context (i.e. LOCKF_USED)

2)	write lock usage in NMI conflicts with read and write lock usage
	in normal context (i.e. LOCKF_USED | LOCKF_USED_READ)

before that commit, only read-side of SRCU is annotated, in other words,
SRCU only has read lock usage from lockdep PoV, but after that commit,
we annotate synchronize_srcu() as a write lock usage, so that we can
detect deadlocks between *normal* srcu_read_lock() and
synchronize_srcu(), however the side effect is now SRCU has a write lock
usage from lockdep PoV.

Actually in the above commit, I explicitly leave
srcu_read_lock_nmisafe() alone since its locking rules may be different
compared to srcu_read_lock(). In lockdep terms, srcu_read_lock_nmisafe()
is a !check read lock and srcu_read_lock() is a check read lock. Maybe
instead of using the trylock trick, we change lockdep to igore !check
locks for NMI context detection? Untested code as below:

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e85b5ad3e206..1af8d44e5eb4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5727,8 +5727,9 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
                return;

        if (unlikely(!lockdep_enabled())) {
+               /* Only do NMI context checking if it's a check lock */
                /* XXX allow trylock from NMI ?!? */
-               if (lockdep_nmi() && !trylock) {
+               if (check && lockdep_nmi() && !trylock) {
                        struct held_lock hlock;

                        hlock.acquire_ip = ip;

Peter, thoughts?

Of course, either way, we need

Fixes: f0f44752f5f6 ("rcu: Annotate SRCU's update-side lockdep dependencies")

Regards,
Boqun

> 
>  include/linux/rcupdate.h | 6 ++++++
>  include/linux/srcu.h     | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 5e5f920ade909..44aab5c0bd2c1 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -303,6 +303,11 @@ static inline void rcu_lock_acquire(struct lockdep_map *map)
>  	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
>  }
>  
> +static inline void rcu_try_lock_acquire(struct lockdep_map *map)
> +{
> +	lock_acquire(map, 0, 1, 2, 0, NULL, _THIS_IP_);
> +}
> +
>  static inline void rcu_lock_release(struct lockdep_map *map)
>  {
>  	lock_release(map, _THIS_IP_);
> @@ -317,6 +322,7 @@ int rcu_read_lock_any_held(void);
>  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  
>  # define rcu_lock_acquire(a)		do { } while (0)
> +# define rcu_try_lock_acquire(a)	do { } while (0)
>  # define rcu_lock_release(a)		do { } while (0)
>  
>  static inline int rcu_read_lock_held(void)
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 127ef3b2e6073..236610e4a8fa5 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -229,7 +229,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
>  
>  	srcu_check_nmi_safety(ssp, true);
>  	retval = __srcu_read_lock_nmisafe(ssp);
> -	rcu_lock_acquire(&ssp->dep_map);
> +	rcu_try_lock_acquire(&ssp->dep_map);
>  	return retval;
>  }
>  
> -- 
> 2.40.1
> 
