Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3EE7CB280
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjJPS1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJPS1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:27:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07115E1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:27:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so8177191a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697480837; x=1698085637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kb9SubRaEoUIylL4DNY5Xv/ATtzdMT7B3T3lbsOCFSw=;
        b=Fxh3OEPpVrhXN/xHJQ6g07KTtmFfijds/o6sb6nz/xErJWTBQ26ILQE7zBfs7SK9zV
         /VFvha3f9h6fLbWHC7eXcIm9m0YbA3NseM6tKfb+2H1zjio5aBkCom6TbwzBOvdRPTuk
         ST/xrK2i+fiNk9DSi+MEU+Unvxr8V9pUqrzxLvIxjO2Ktr5dtxUaizw8roKgCWghVjq9
         YwGcH0sXO2QjGLxcTEpXTknx2ikwV5yux1PbGc9LhExfu9zS9VU/RyGFr8D9myVtrEMb
         Q19hb8aNM37zIQT6Av4cSSZlU6yZyMkDbWOB18bu6vNHCZwCEKtNg4WjHC18Pktb8x29
         CErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480837; x=1698085637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kb9SubRaEoUIylL4DNY5Xv/ATtzdMT7B3T3lbsOCFSw=;
        b=wBCSdAH/WeNH+DmQNB9AK3h8MJnTjihrpX27MeIVX6ncL02HICIJngxSQzIDIIpDgp
         zGKz80Vtg/v5cGCB8fNmUJifPnCCcI9TalYQOQXZgpRN4o15rKh5xy99nXb35UCDP5Li
         wYewK0ZEGlnXDMMjrV7Od/pRNUzp+r9qPTkzHTfskCqRMkKPnNaZqFR4RSlsa3B7pY2k
         feuwuJnFuEppLujwUMAfOUmlNniH56h+X7iHA4b5reOHudwcDfaSOnA7qA+sZGofVcom
         PoiiiKlNWxe50h+PC6mezF33+/0aLFmFg9Uo66xIK0Q1qmi3kx/fuDgDTKQ2dtXKvY7h
         AiMw==
X-Gm-Message-State: AOJu0YzuaYP9+lRHrP1MkpzvI97WQ95SFGw5e1lkhgxSHAXEa7JOh9N9
        5U0jjMo4AF+c++byMnCc3bIh6fyuMNeGyl3ZYY3Npw==
X-Google-Smtp-Source: AGHT+IEQdYe/xZgPwgaTIyxFlobq2ZBO2NiSQKBCo2frWb0kJdJPZWrx8DCkc8xcZgoUSinrqhgQ9BPCNACc81tkAuo=
X-Received: by 2002:a05:6402:51d4:b0:53d:eca8:8775 with SMTP id
 r20-20020a05640251d400b0053deca88775mr34017edd.26.1697480837407; Mon, 16 Oct
 2023 11:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <ZS1/qtr0dZJ35VII@debian.debian>
In-Reply-To: <ZS1/qtr0dZJ35VII@debian.debian>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Mon, 16 Oct 2023 13:27:06 -0500
Message-ID: <CAO3-PboE=a_Z03bo10nmgdm3aHstxA_t4rtpAGekFzQAM+JOyA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] ipv6: avoid atomic fragment on GSO packets
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 1:23=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> GSO packets can contain a trailing segment that is smaller than
> gso_size. When examining the dst MTU for such packet, if its gso_size is
> too large, then all segments would be fragmented. However, there is a
> good chance the trailing segment has smaller actual size than both
> gso_size as well as the MTU, which leads to an "atomic fragment". It is
> considered harmful in RFC-8021. An Existing report from APNIC also shows
> that atomic fragments are more likely to be dropped even it is
> equivalent to a no-op [1].
>
> Refactor __ip6_finish_output code to separate GSO and non-GSO packet
> processing. It mirrors __ip_finish_output logic now. Add an extra check
> in GSO handling to avoid atomic fragments. Lastly, drop dst_allfrag
> check, which is no longer true since commit 9d289715eb5c ("ipv6: stop
> sending PTB packets for MTU < 1280").
>
> Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]
> Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 proc=
essing")
> Suggested-by: Florian Westphal <fw@strlen.de>
> Reported-by: David Wragg <dwragg@cloudflare.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
Forgot to add v1 thread:
https://lore.kernel.org/lkml/20231002171146.GB9274@breakpoint.cc/. It
was wrongly implemented though without considering max_frag_size for
non-GSO packets though, so not really useful in fact.

>  net/ipv6/ip6_output.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index a471c7e91761..1de6f3c11655 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -162,7 +162,14 @@ ip6_finish_output_gso_slowpath_drop(struct net *net,=
 struct sock *sk,
>                 int err;
>
>                 skb_mark_not_on_list(segs);
> -               err =3D ip6_fragment(net, sk, segs, ip6_finish_output2);
> +               /* Last gso segment might be smaller than actual MTU. Add=
ing
> +                * a fragment header to it would produce an "atomic fragm=
ent",
> +                * which is considered harmful (RFC-8021)
> +                */
> +               err =3D segs->len > mtu ?
> +                       ip6_fragment(net, sk, segs, ip6_finish_output2) :
> +                       ip6_finish_output2(net, sk, segs);
> +
>                 if (err && ret =3D=3D 0)
>                         ret =3D err;
>         }
> @@ -170,10 +177,19 @@ ip6_finish_output_gso_slowpath_drop(struct net *net=
, struct sock *sk,
>         return ret;
>  }
>
> +static int ip6_finish_output_gso(struct net *net, struct sock *sk,
> +                                struct sk_buff *skb, unsigned int mtu)
> +{
> +       if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
> +           !skb_gso_validate_network_len(skb, mtu))
> +               return ip6_finish_output_gso_slowpath_drop(net, sk, skb, =
mtu);
> +
> +       return ip6_finish_output2(net, sk, skb);
> +}
> +
>  static int __ip6_finish_output(struct net *net, struct sock *sk, struct =
sk_buff *skb)
>  {
>         unsigned int mtu;
> -
>  #if defined(CONFIG_NETFILTER) && defined(CONFIG_XFRM)
>         /* Policy lookup after SNAT yielded a new policy */
>         if (skb_dst(skb)->xfrm) {
> @@ -183,17 +199,14 @@ static int __ip6_finish_output(struct net *net, str=
uct sock *sk, struct sk_buff
>  #endif
>
>         mtu =3D ip6_skb_dst_mtu(skb);
> -       if (skb_is_gso(skb) &&
> -           !(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
> -           !skb_gso_validate_network_len(skb, mtu))
> -               return ip6_finish_output_gso_slowpath_drop(net, sk, skb, =
mtu);
> +       if (skb_is_gso(skb))
> +               return ip6_finish_output_gso(net, sk, skb, mtu);
>
> -       if ((skb->len > mtu && !skb_is_gso(skb)) ||
> -           dst_allfrag(skb_dst(skb)) ||
> +       if (skb->len > mtu ||
>             (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max=
_size))
>                 return ip6_fragment(net, sk, skb, ip6_finish_output2);
> -       else
> -               return ip6_finish_output2(net, sk, skb);
> +
> +       return ip6_finish_output2(net, sk, skb);
>  }
>
>  static int ip6_finish_output(struct net *net, struct sock *sk, struct sk=
_buff *skb)
> --
> 2.30.2
>
