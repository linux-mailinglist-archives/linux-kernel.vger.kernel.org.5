Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4E37BD42A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbjJIHTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjJIHTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:19:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD1BA4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 00:19:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so11739a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 00:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696835952; x=1697440752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G4lnIm/L/2jfjUpl8BGvD5ApP4hc/7MaXZs13qmiX4=;
        b=wZQwOMnT3SVMeaeyCon8U4P6CWLcCmxgvIYd/DazndX/EgQFSfV9uOTikaOSOEhHGM
         +BgxW7oorkWQR/ocPjEMwqQwpIrj8sDyTT/vLXiOHnaQgQUyfelrz6KxTmtiL5oO9O0r
         h43YIPeBTvyb8qHoiyKz9n/qqKy5IGlHb1IzKhmnr7KYy6s980EHL0M03GrJfCaRE7px
         JQ+18sD+Lj/60Cue5LnRJOXaFJnZQgngF/QymwS33cVlOJAePn8Vj8gMgosQO6ydK8wE
         OsRcp5OkrWyGBaJcQ0MuLt41XSKe3B41ev35y+tDFZBfjp19UqkOotAf2rb+PgjPuDE6
         rasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696835952; x=1697440752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G4lnIm/L/2jfjUpl8BGvD5ApP4hc/7MaXZs13qmiX4=;
        b=k1h18zGZhQhEnouk+CPlNFTxHlDxdXaW4QRoVeyIOvX44oV6BDIAOlJE805JRdknMI
         rsJ7o2vXNKJWHhGt+QZUnQXGyE/ilLwl7QYbVDSu007KL2gBY57ltOrq6oHniYqJ6G2r
         qT/6VV8byzXCtZmdjqdbjkln9eymDCi2xSrkorkytq0f4kTXCcaIlKDrNjTdTcbx7ldb
         mjMWF1h6HYTit4BqzSFX9gG80RGL1Cii/aczZtf7TJ0p7O+fILFMauu4EyNbw2Mig7NH
         NYX3fcU7K58LSbuGO1XDnHo60wV9qh2amcc96SNE4O5yhECLstIfo2Hg1EuamE8rPvl0
         XX7Q==
X-Gm-Message-State: AOJu0YzqBRcm8eTL2shTZlu8GigUBbB8mGMaVtrE6A1CZNGGCS8Hq2T6
        qP5nxo3hCRO3c71f5mi2OEF7xEdbd9ldGdGhHYYhMw==
X-Google-Smtp-Source: AGHT+IE+jq9PyYLsYHpsrvCUuH0lJPTbZB/gGk8VPqkFRBMyIAGs6DNDsRIAtLDoPdM/SUAadTJzmjrpa3ookyfrHnU=
X-Received: by 2002:a50:cd5c:0:b0:538:47bb:3e88 with SMTP id
 d28-20020a50cd5c000000b0053847bb3e88mr350456edj.6.1696835952079; Mon, 09 Oct
 2023 00:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231007105019.GA20662@breakpoint.cc> <20231009021108.3203928-1-guodongtai@kylinos.cn>
In-Reply-To: <20231009021108.3203928-1-guodongtai@kylinos.cn>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 9 Oct 2023 09:18:58 +0200
Message-ID: <CANn89i+OL_kPwmHEW-KBGdd-prAGC3NaQG4MNq4ZEvWpw7Q-7A@mail.gmail.com>
Subject: Re: [PATCH v2] tcp: cleanup secure_{tcp, tcpv6}_ts_off
To:     George Guo <guodongtai@kylinos.cn>
Cc:     fw@strlen.de, davem@davemloft.net, dongtai.guo@linux.dev,
        dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com
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

On Mon, Oct 9, 2023 at 5:12=E2=80=AFAM George Guo <guodongtai@kylinos.cn> w=
rote:
>
> Correct secure_tcp_ts_off and secure_tcpv6_ts_off call parameter order
>

I do not think this patch is correct.

We have to exchange saddr/daddr from an incoming packet in order to compute
a hash if the function expects saddr to be the local host address, and
daddr being the remote peer address.

For instance, tcp_v4_connect() uses :

WRITE_ONCE(tp->tsoffset,
                          secure_tcp_ts_off(net, inet->inet_saddr,
                                                        inet->inet_daddr));

While when receiving a packet from the other peer, it correctly swaps
saddr/daddr

tcp_v4_init_ts_off(const struct net *net, const struct sk_buff *skb)
{
 return secure_tcp_ts_off(net, ip_hdr(skb)->daddr, ip_hdr(skb)->saddr);
}


> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  net/ipv4/syncookies.c | 4 ++--
>  net/ipv4/tcp_ipv4.c   | 2 +-
>  net/ipv6/syncookies.c | 4 ++--
>  net/ipv6/tcp_ipv6.c   | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index dc478a0574cb..537f368a0b66 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -360,8 +360,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>
>         if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
>                 tsoff =3D secure_tcp_ts_off(sock_net(sk),
> -                                         ip_hdr(skb)->daddr,
> -                                         ip_hdr(skb)->saddr);
> +                                         ip_hdr(skb)->saddr,
> +                                         ip_hdr(skb)->daddr);
>                 tcp_opt.rcv_tsecr -=3D tsoff;
>         }
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index a441740616d7..54717d261693 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -104,7 +104,7 @@ static u32 tcp_v4_init_seq(const struct sk_buff *skb)
>
>  static u32 tcp_v4_init_ts_off(const struct net *net, const struct sk_buf=
f *skb)
>  {
> -       return secure_tcp_ts_off(net, ip_hdr(skb)->daddr, ip_hdr(skb)->sa=
ddr);
> +       return secure_tcp_ts_off(net, ip_hdr(skb)->saddr, ip_hdr(skb)->da=
ddr);
>  }
>
>  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index 5014aa663452..9af484a4d518 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -162,8 +162,8 @@ struct sock *cookie_v6_check(struct sock *sk, struct =
sk_buff *skb)
>
>         if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
>                 tsoff =3D secure_tcpv6_ts_off(sock_net(sk),
> -                                           ipv6_hdr(skb)->daddr.s6_addr3=
2,
> -                                           ipv6_hdr(skb)->saddr.s6_addr3=
2);
> +                                           ipv6_hdr(skb)->saddr.s6_addr3=
2,
> +                                           ipv6_hdr(skb)->daddr.s6_addr3=
2);
>                 tcp_opt.rcv_tsecr -=3D tsoff;
>         }
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index bfe7d19ff4fd..7e2f924725c6 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -119,8 +119,8 @@ static u32 tcp_v6_init_seq(const struct sk_buff *skb)
>
>  static u32 tcp_v6_init_ts_off(const struct net *net, const struct sk_buf=
f *skb)
>  {
> -       return secure_tcpv6_ts_off(net, ipv6_hdr(skb)->daddr.s6_addr32,
> -                                  ipv6_hdr(skb)->saddr.s6_addr32);
> +       return secure_tcpv6_ts_off(net, ipv6_hdr(skb)->saddr.s6_addr32,
> +                                  ipv6_hdr(skb)->daddr.s6_addr32);
>  }
>
>  static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
> --
> 2.34.1
>
