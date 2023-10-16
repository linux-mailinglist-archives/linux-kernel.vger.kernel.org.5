Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6447CADC6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjJPPkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjJPPkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:40:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAB2EE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:40:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so15251a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697470818; x=1698075618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea6BXTL4g5xvVBXKvzhfzkGwCYvmtfqSddcw/YIlLoM=;
        b=SYBfDWTTCAlNRcOn/GEQxiDAENFT1hOhNWjHetgYM7oOBztNEtVnrHmPvkIG698+ty
         9YHezOM/kCu/E6vGDFQxpSdCoe4J1SsOHFeji5DnoLfmyHaSVwo2KIlIKZd01BlDoLRe
         RavSCtI4eiHksK2Ua4eFMWXwQXbccv95IC7rVBNhtRb8og9HVqfNJsfIeMx4SViqz8Nr
         yqO/0eVc7ZcjvQPXQe0+O1/uHtwGmf/qqtLkkc37A0R0JqdNz+gu15ZSfCrGkEp6yOgG
         jUV0MVKUzgaxuzqMP5GtDTHbFE4IlAZs04kfXXupVUpnXZL+gUjujlP3h99JAb0AvE6s
         qRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697470818; x=1698075618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ea6BXTL4g5xvVBXKvzhfzkGwCYvmtfqSddcw/YIlLoM=;
        b=hhdqCQ11erqEI20d45OXtK67ZrUfrI/A0aDBzPMVAKnK2+74j5MH0/g2znwmCOrSrp
         c3eaDBTseaNnWOrWzvUPgkspko0lCbNFdnJ8IwO1pOE+3e0FOvAp+VnVth5+cJZ6W3tB
         BswfU0NORcADg4VnXrHVYEqZtHPHcLEnFlqh/81DtV+Pq2KQdDm91AgWIdx4tZzyUFBA
         AaRULzI09w4tKc/Uml2mU4h4cdvaN6zKPINye8QgGbZXkflGrG1oLxT7/mi4uSBqQMEc
         IJr2FeN3g2opHAz2KcpbaUbsPuGvQ3exz7hGZgpZpf1WejQIcCUTb9XWLPv52+ZvPr/F
         Sk9Q==
X-Gm-Message-State: AOJu0Yyt7WmFdheryaJ/VIsB/Q2dWRAA3vqrPXKKC63qC3SWnEtgV1rP
        3PJbgvb2vLuTWItBG2X9zXHuCr/HrXY6f7wqETrr4Q==
X-Google-Smtp-Source: AGHT+IFNKq3yTk1wylHelFdQm7j+wkpOk6Od+3a7/A/jHAvIXGfaaXWeujRWLmEXROVIwkX+iRk3kvf2P/yiMWzqGfw=
X-Received: by 2002:aa7:d619:0:b0:53e:91c6:b6f5 with SMTP id
 c25-20020aa7d619000000b0053e91c6b6f5mr142498edr.4.1697470817959; Mon, 16 Oct
 2023 08:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231016125934.1970789-1-vschneid@redhat.com>
In-Reply-To: <20231016125934.1970789-1-vschneid@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 16 Oct 2023 17:40:04 +0200
Message-ID: <CANn89i+pQ3j+rb2SjFWjCU7BEges3TADDes5+csEr1JJamtzPQ@mail.gmail.com>
Subject: Re: [RFC PATCH] tcp/dcpp: Un-pin tw_timer
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 3:00=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:
>
> The TCP timewait timer is proving to be problematic for setups where sche=
duler
> CPU isolation is achieved at runtime via cpusets (as opposed to staticall=
y via
> isolcpus=3Ddomains).
>
> What happens there is a CPU goes through tcp_time_wait(), arming the time=
_wait
> timer, then gets isolated. TCP_TIMEWAIT_LEN later, the timer fires, causi=
ng
> interference for the now-isolated CPU. This is conceptually similar to th=
e issue
> described in
>   e02b93124855 ("workqueue: Unbind kworkers before sending them to exit()=
")
>
> Making the timer un-pinned would resolve this, as it would be queued onto
> HK_FLAG_TIMER CPUs. It would Unfortunately go against
>   ed2e92394589 ("tcp/dccp: fix timewait races in timer handling")
> as we'd need to arm the timer after the *hashdance() to not have it fire =
before
> we've finished setting up the timewait_socket.
>
> However, looking into this, I cannot grok what race is fixed by having th=
e timer
> *armed* before the hashdance.

That was because :

1) the timer could expire before we had a chance to set refcnt to
a non zero value. I guess this is fine if we use an extra atomic decrement.

OR

2) another cpu could find the TW and delete it (trying to cancel the
tw_timer) before
   we could arm the timer.  ( inet_twsk_deschedule_put() is using
del_timer_sync() followed by inet_twsk_kill())

Thus the tw timer would be armed for 60 seconds, then we would have to
wait for the timer to really
get rid of the tw structure.

I think you also need to change inet_twsk_deschedule_put() logic ?

>
> [this next segment is brought to you by Cunningham's Law]
>

I guess this is not really relevant to the potential issue.

> Using [1] as an example, inet_twsk_schedule() only arms the timer and inc=
rements
> the deathrow refcount, which by itself does not affect
> __inet_lookup_established(). AFAICT it only comes in handy if:
> 1) A CPU ends up livelocking in __inet_lookup_established() (cf. [1], tho=
ugh per
>    inet_twsk_alloc() I don't see how a timewait socket can hit the
>    forever-looping conditions with how the sk_hash and addr/port pairs ar=
e copied)
> 2) the initialization context can be interrupted by NET_RX (it can, cf.
>    cfac7f836a71 ("tcp/dccp: block bh before arming time_wait timer"))
>
> In this scenario, we need the timer to fire to go through
>   inet_twsk_kill()
>     sk_nulls_del_node_init_rcu()
> and break out of the loop.
>
> Keep softirqs disabled, but make the timer un-pinned and arm it after the
> hashdance. Remote CPUs may start using the timewait socket before the tim=
er is
> armed, but their execution of __inet_lookup_established() won't prevent t=
he
> arming of the timer.

OK, I guess we can live with the following race :

CPU0

   allocates a tw, insert it in hash table

CPU1:                               finds the TW and removes it (timer
cancel does nothing)

CPU0
   arms a TW timer, lasting

>
> This partially reverts
>   ed2e92394589 ("tcp/dccp: fix timewait races in timer handling")
> and
>   ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait hashda=
nce")
>
> Link: [1] https://lore.kernel.org/lkml/56941035.9040000@fastly.com/
> Link: https://lore.kernel.org/all/ZPhpfMjSiHVjQkTk@localhost.localdomain/
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  net/dccp/minisocks.c          | 18 ++++++++++--------
>  net/ipv4/inet_timewait_sock.c |  9 ++++-----
>  net/ipv4/tcp_minisocks.c      | 18 ++++++++++--------
>  3 files changed, 24 insertions(+), 21 deletions(-)
>
> diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
> index 64d805b27adde..188a29a1aef49 100644
> --- a/net/dccp/minisocks.c
> +++ b/net/dccp/minisocks.c
> @@ -53,16 +53,18 @@ void dccp_time_wait(struct sock *sk, int state, int t=
imeo)
>                 if (state =3D=3D DCCP_TIME_WAIT)
>                         timeo =3D DCCP_TIMEWAIT_LEN;
>
> -               /* tw_timer is pinned, so we need to make sure BH are dis=
abled
> -                * in following section, otherwise timer handler could ru=
n before
> -                * we complete the initialization.
> -                */
> -               local_bh_disable();
> -               inet_twsk_schedule(tw, timeo);
> -               /* Linkage updates.
> -                * Note that access to tw after this point is illegal.
> +               /* tw_timer is armed after the hashdance and recount upda=
te, so
> +                * we need to make sure BH are disabled in following sect=
ion to
> +                * ensure the timer is armed before we handle any further=
 skb's.
>                  */
> +              local_bh_disable();
> +
> +               // Linkage updates
>                 inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
> +               inet_twsk_schedule(tw, timeo);
> +               // Access to tw after this point is illegal.
> +               inet_twsk_put(tw);
> +
>                 local_bh_enable();
>         } else {
>                 /* Sorry, if we're out of memory, just CLOSE this
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index dd37a5bf68811..ba59c2c6ef4a2 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -152,16 +152,15 @@ void inet_twsk_hashdance(struct inet_timewait_sock =
*tw, struct sock *sk,
>
>         spin_unlock(lock);
>
> -       /* tw_refcnt is set to 3 because we have :
> +       /* tw_refcnt is set to 4 because we have :
>          * - one reference for bhash chain.
>          * - one reference for ehash chain.
>          * - one reference for timer.
> +        * - One reference for ourself (our caller will release it).
>          * We can use atomic_set() because prior spin_lock()/spin_unlock(=
)
>          * committed into memory all tw fields.
> -        * Also note that after this point, we lost our implicit referenc=
e
> -        * so we are not allowed to use tw anymore.
>          */
> -       refcount_set(&tw->tw_refcnt, 3);
> +       refcount_set(&tw->tw_refcnt, 4);
>  }
>  EXPORT_SYMBOL_GPL(inet_twsk_hashdance);
>
> @@ -207,7 +206,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const stru=
ct sock *sk,
>                 tw->tw_prot         =3D sk->sk_prot_creator;
>                 atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie=
));
>                 twsk_net_set(tw, sock_net(sk));
> -               timer_setup(&tw->tw_timer, tw_timer_handler, TIMER_PINNED=
);
> +               timer_setup(&tw->tw_timer, tw_timer_handler, 0);
>                 /*
>                  * Because we use RCU lookups, we should not set tw_refcn=
t
>                  * to a non null value before everything is setup for thi=
s
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index b98d476f1594b..269d4aa14a49e 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -324,16 +324,18 @@ void tcp_time_wait(struct sock *sk, int state, int =
timeo)
>                 if (state =3D=3D TCP_TIME_WAIT)
>                         timeo =3D TCP_TIMEWAIT_LEN;
>
> -               /* tw_timer is pinned, so we need to make sure BH are dis=
abled
> -                * in following section, otherwise timer handler could ru=
n before
> -                * we complete the initialization.
> -                */
> -               local_bh_disable();
> -               inet_twsk_schedule(tw, timeo);
> -               /* Linkage updates.
> -                * Note that access to tw after this point is illegal.
> +               /* tw_timer is armed after the hashdance and recount upda=
te, so
> +                * we need to make sure BH are disabled in following sect=
ion to
> +                * ensure the timer is armed before we handle any further=
 skb's.
>                  */
> +              local_bh_disable();
> +
> +               // Linkage updates.
>                 inet_twsk_hashdance(tw, sk, net->ipv4.tcp_death_row.hashi=
nfo);
> +               inet_twsk_schedule(tw, timeo);
> +               // Access to tw after this point is illegal.
> +               inet_twsk_put(tw);
> +
>                 local_bh_enable();
>         } else {
>                 /* Sorry, if we're out of memory, just CLOSE this
> --
> 2.39.3
>
