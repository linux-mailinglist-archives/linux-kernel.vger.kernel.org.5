Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AB47E818C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbjKJS3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346576AbjKJS1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:27:00 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82C324488
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:31:05 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-545557de8e6so21834a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699608664; x=1700213464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksKC5N5S1VwyLBs8puatXQ5O6wSMGiBfXyqCMNWeYS0=;
        b=GLlmWqNxmYnB2EqluZiCz+8D0g4pXZpw8oYS4Pu0rDkOkG4mLp7P5dywjCL3MKM8pF
         GNkSz/bI+hDLcu9gkjtcRhFDSezB6SoINxEs5bpMs6i/BuhPG7KiV0iRXWRj//SkXL3R
         U7zazpVKD3PYbMXUgXKcH+w9SSKZR6BW5+z3mIMOFeDmSjMf6qqGP/llZIDnV6HZLqrJ
         1lQfsYZdAkOfLs3qG/17zNkep1NQPWneAP150QFMn52QFDW/21AdwIs5ujKRQZaXzqLv
         1LSG/8uO89HG6EQm09Hnb7UEWCuS9EEkeD7C66JxPy/atUuWNtDUi7cWbNPLa8F/cHL5
         XErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699608664; x=1700213464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksKC5N5S1VwyLBs8puatXQ5O6wSMGiBfXyqCMNWeYS0=;
        b=bov072VQinn1u7oP45qLP3l55zMgxLFTX4f6DE2FTuoFOrHFn/7+K1AXiJLajefTOo
         +0OX4At9im71RyteLqvUQije+DIB/PFInPV7t8xORJwKGkiMtf9XC8xku2gsEYGGGMaX
         GzZgPuQfPclp9szaSQqapwgbiJjtXG9tX67y9aOrvvJ9cskBdeLBwXqatGAVOqGHNmmw
         2E+boxI2Y4mz/po0tSjFOt7eqjSOZnP0qjMrMc3p+wBJ+sz36+WjPTFxs3mK4Htx3Zq1
         XTF7B+Et8v43XXGZo8Ix9ECvV5x2VvWV41H+TdziFim1uMsfDZ52G3iZGKQVd6kCXI2P
         1oqA==
X-Gm-Message-State: AOJu0YyntVH7YKFe8sXXuEJTY+5QdL73j8beR6hHekBsvcgzgmUggTCW
        Rqeb/aBklXCnyCtxGt8OE5d69LyIlwxAOSVGt0CPjA==
X-Google-Smtp-Source: AGHT+IGcsfjTyKWdpxswyD/khdOvVcyNQpeNRxwBtmA6S2pZzXcxgaiSZg7dqCQNUa8KOrtv0uaK5Oi+Gtl9Nk9nbpA=
X-Received: by 2002:a05:6402:1484:b0:544:466b:3b20 with SMTP id
 e4-20020a056402148400b00544466b3b20mr299720edv.5.1699608663758; Fri, 10 Nov
 2023 01:31:03 -0800 (PST)
MIME-Version: 1.0
References: <ZU3EZKQ3dyLE6T8z@debian.debian>
In-Reply-To: <ZU3EZKQ3dyLE6T8z@debian.debian>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 10 Nov 2023 10:30:49 +0100
Message-ID: <CANn89iKZYsWGT1weXZ6W7_z28dqJwTZeg+2_Lw+x+6spUHp8Eg@mail.gmail.com>
Subject: Re: [PATCH net-next] packet: add a generic drop reason for receive
To:     Yan Zhai <yan@cloudflare.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Weongyo Jeong <weongyo.linux@gmail.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Brouer <jesper@cloudflare.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 6:49=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
> from consume_skb to kfree_skb to improve error handling. However, this
> could bring a lot of noises when we monitor real packet drops in
> kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
> can be freed, not actual packets.
>
> Adding a generic drop reason to allow distinguish these "clone drops".
>
> [1]: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=3DZah28QwZ_5RU-xcxLFU=
K2Zj08A8MrLk9jzg@mail.gmail.com/
> Fixes: da37845fdce2 ("packet: uses kfree_skb() for errors.")
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  include/net/dropreason-core.h |  6 ++++++
>  net/packet/af_packet.c        | 16 +++++++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.=
h
> index 845dce805de7..6ff543fe8a8b 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -81,6 +81,7 @@
>         FN(IPV6_NDISC_NS_OTHERHOST)     \
>         FN(QUEUE_PURGE)                 \
>         FN(TC_ERROR)                    \
> +       FN(PACKET_SOCK_ERROR)           \
>         FNe(MAX)
>
>  /**
> @@ -348,6 +349,11 @@ enum skb_drop_reason {
>         SKB_DROP_REASON_QUEUE_PURGE,
>         /** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
>         SKB_DROP_REASON_TC_ERROR,
> +       /**
> +        * @SKB_DROP_REASON_PACKET_SOCK_ERROR: generic packet socket erro=
rs
> +        * after its filter matches an incoming packet.
> +        */
> +       SKB_DROP_REASON_PACKET_SOCK_ERROR,
>         /**
>          * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>          * shouldn't be used as a real 'reason' - only for tracing code g=
en
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index a84e00b5904b..94b8a9d8e038 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2128,6 +2128,7 @@ static int packet_rcv(struct sk_buff *skb, struct n=
et_device *dev,
>         int skb_len =3D skb->len;
>         unsigned int snaplen, res;
>         bool is_drop_n_account =3D false;
> +       enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_NOT_SPECIFIE=
D;
>
>         if (skb->pkt_type =3D=3D PACKET_LOOPBACK)
>                 goto drop;
> @@ -2161,6 +2162,10 @@ static int packet_rcv(struct sk_buff *skb, struct =
net_device *dev,
>         res =3D run_filter(skb, sk, snaplen);
>         if (!res)
>                 goto drop_n_restore;
> +
> +       /* skb will only be "consumed" not "dropped" before this */
> +       drop_reason =3D SKB_DROP_REASON_PACKET_SOCK_ERROR;
> +
>         if (snaplen > res)
>                 snaplen =3D res;
>
> @@ -2230,7 +2235,7 @@ static int packet_rcv(struct sk_buff *skb, struct n=
et_device *dev,
>         if (!is_drop_n_account)
>                 consume_skb(skb);
>         else
> -               kfree_skb(skb);
> +               kfree_skb_reason(skb, drop_reason);
>         return 0;


1) Note that net-next is currently closed.

2) Now we have 0e84afe8ebfb ("net: dropreason: add SKB_CONSUMED reason")

it is time we replace the various constructs which do not help readability:

if (something)
     consume_skb(skb);
else
     kfree_skb_reason(skb, drop_reason);

By:

kfree_skb_reason(skb, drop_reason);

(By using drop_reason =3D=3D SKB_CONSUMED when appropriate)
