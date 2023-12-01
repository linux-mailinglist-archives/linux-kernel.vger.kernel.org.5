Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B02801217
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379039AbjLARvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLARvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:51:09 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8F5AD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:51:15 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso75a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701453073; x=1702057873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3pnThC3OPQt1u7swR/CEmmm2L1BbqHWt2vccyU+wqY=;
        b=dFnb0GoWAqwCCJgSyyNchhPslfWB1/pjpjSaF7b3RaPqQkAlf8xrITTLEF+WWgGI4t
         fASC1mMdLnQQ9/xQu56JXkMlcQzF7whgRuX80ZsDwxmYJtTCRhjTuWVj9uT1gwbwE3Eu
         d3oLDOuN33ic1mD5qvdgXQ+13E22lROqJ+zGIz6SlPe9BQ6g9jTMnBaST8vWsjTlTOWZ
         12vo0Bwinsodc4bCxJnqprKV8U7Qlcv9lrLEjE4JSx7XPj3egtAvuRUhdHkh5yKj+cpT
         FvPKoufQOvhqjQ5wTcL4SNgs8b3JYjG7/NDxYHlkVdJEYPp2yPUffjJDREfM9nTjEUYQ
         NVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701453073; x=1702057873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3pnThC3OPQt1u7swR/CEmmm2L1BbqHWt2vccyU+wqY=;
        b=NgehJbMPqvzxp8okSaQJ0Zxm3njzvxjvCpEldReh4FWuxV3ZTcvHW5BZ3BsUOOPSlh
         Zyl5syxKpIOPyb+wu4mSoNigAmL+oQTASk4uDoGfgBXsdfdAz59SjTVicHFFLFilBoCQ
         TCtTlV6fMa7SPZ7qgwd10ibvHC4NbAsIvE5vxZonN7xKgTVDmhVARaBRPHst28o7d+Ct
         mQXpU2sAXKwIm02KTBG1tCbNYkef1I7tiOWJ/FYdOB24CxaaD4+8rMEQ1B1t4MxTKRfc
         nl5aIURVwEp4/jggmGDDKk7TcebB0kgn/fY23EjeRKVzph+fwA30ONcSVU+RKkHTgpuT
         FVmQ==
X-Gm-Message-State: AOJu0YzuEzax1pAFh9wIBEZivkV84pDdDtd4yHEoNUqXwSuxRGdHtjaQ
        dK1W5bAbgC4jV1PkQQrW5k9v3OXJWUL7Ybd4bDd3lg==
X-Google-Smtp-Source: AGHT+IF+QIR6TaWoGuTkiAnwgaJjp4j91us2yyByWB+XCzNBr5ZqeJ+yZO8B/pZ5Twzrl27VU8eKH2lxWwExO89XVXc=
X-Received: by 2002:a50:aacf:0:b0:54b:321:ef1a with SMTP id
 r15-20020a50aacf000000b0054b0321ef1amr152058edc.6.1701453073216; Fri, 01 Dec
 2023 09:51:13 -0800 (PST)
MIME-Version: 1.0
References: <ZWobMUp22oTpP3FW@debian.debian>
In-Reply-To: <ZWobMUp22oTpP3FW@debian.debian>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 1 Dec 2023 18:51:02 +0100
Message-ID: <CANn89iLLnXVBvajLA-FLwBSN4uRNZKJYAvwvKEymGsvOQQJs1A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] packet: add a generic drop reason for receive
To:     Yan Zhai <yan@cloudflare.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Weongyo Jeong <weongyo.linux@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Jesper Brouer <jesper@cloudflare.com>
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

On Fri, Dec 1, 2023 at 6:43=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote:
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
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  include/net/dropreason-core.h |  6 ++++++
>  net/packet/af_packet.c        | 22 +++++++++++++---------
>  2 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.=
h
> index 3c70ad53a49c..278e4c7d465c 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -86,6 +86,7 @@
>         FN(IPV6_NDISC_NS_OTHERHOST)     \
>         FN(QUEUE_PURGE)                 \
>         FN(TC_ERROR)                    \
> +       FN(PACKET_SOCK_ERROR)           \
>         FNe(MAX)
>
>  /**
> @@ -378,6 +379,11 @@ enum skb_drop_reason {
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
> index a84e00b5904b..0a7c05d8fe9f 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2128,6 +2128,7 @@ static int packet_rcv(struct sk_buff *skb, struct n=
et_device *dev,
>         int skb_len =3D skb->len;
>         unsigned int snaplen, res;
>         bool is_drop_n_account =3D false;

Why keeping is_drop_n_account  then ?


> +       enum skb_drop_reason drop_reason =3D SKB_CONSUMED;
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
> @@ -2227,10 +2232,7 @@ static int packet_rcv(struct sk_buff *skb, struct =
net_device *dev,
>                 skb->len =3D skb_len;
>         }
>  drop:
> -       if (!is_drop_n_account)

Because after your patch it will be set but never read.

> -               consume_skb(skb);
> -       else
> -               kfree_skb(skb);
> +       kfree_skb_reason(skb, drop_reason);
>         return 0;
>  }
>
> @@ -2253,6 +2255,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct =
net_device *dev,
>         bool is_drop_n_account =3D false;

Same remark here.

>         unsigned int slot_id =3D 0;
>         int vnet_hdr_sz =3D 0;
> +       enum skb_drop_reason drop_reason =3D SKB_CONSUMED;
>
>         /* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_AL=
IGNMENT.
>          * We may add members to them until current aligned size without =
forcing
> @@ -2355,6 +2358,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct=
 net_device *dev,
>                         vnet_hdr_sz =3D 0;
>                 }
>         }
> +
> +       /* skb will only be "consumed" not "dropped" before this */
> +       drop_reason =3D SKB_DROP_REASON_PACKET_SOCK_ERROR;
> +
>         spin_lock(&sk->sk_receive_queue.lock);
>         h.raw =3D packet_current_rx_frame(po, skb,
>                                         TP_STATUS_KERNEL, (macoff+snaplen=
));
> @@ -2498,10 +2505,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct=
 net_device *dev,
>                 skb->len =3D skb_len;
>         }
>  drop:
> -       if (!is_drop_n_account)
> -               consume_skb(skb);
> -       else
> -               kfree_skb(skb);
> +       kfree_skb_reason(skb, drop_reason);
>         return 0;
>
>  drop_n_account:
> @@ -2510,7 +2514,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct =
net_device *dev,
>         is_drop_n_account =3D true;
>
>         sk->sk_data_ready(sk);
> -       kfree_skb(copy_skb);
> +       kfree_skb_reason(copy_skb, drop_reason);
>         goto drop_n_restore;
>  }
>
> --
> 2.30.2
>
