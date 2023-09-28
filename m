Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6ED7B1F57
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjI1OSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjI1OSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:18:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3418D1A2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:18:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so14195a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695910705; x=1696515505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSyhskKSBMK251ZxkFXgFYWk9PlZTf7or3SVXcV7SyY=;
        b=uiyXBzMTcVYj2pJ2SVEfXeoRUjqRl7sZWRe0m4IjzedUjbBKPaJgb0OMxJHX4A/ud6
         mPHadMwpv2W1o/mAjwrmHrS6mmHSzXXsWPo6J1Ylsa84GNfZ4y4u5xUDno/quUbfd8F/
         wE21QMubzWxDi7qgpvJ2tWFjw7AKE4E81jWAx6V+L8s5Rmq0QuncHE4kVq5e4yzcOixR
         jbV6JsltINJfgvqlyhI1eSLVs5FL0PW5l0xwbivof1/7Pxh+xK7Rk1K1DDR8a6+8bVVR
         CjLRs1Zj88E/84Ut3+kHHts9fXu5Qdy+AKpHPIZ9fNsHWZCdq4UjiTn2OzxjKV25DXln
         AxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695910705; x=1696515505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSyhskKSBMK251ZxkFXgFYWk9PlZTf7or3SVXcV7SyY=;
        b=MhbLhfoVeblK4Vlm56DiyfBpQw9wr0AAS08AgbXDUVPEk5xDNvHNdMQ7YnKJf/dQRX
         jJth/Giu0s7LbX+Vnrto2ozKqHHINTSgI6jW+bAInitjXeG0BnpIRkmRHEEWTE3Pu7b4
         I+6WPcIfkaBOn2zXJYbtB5cFHmF5KoYCi9F7nqngxKRNi/KR1tdM/Pnlm1p/1lRztM5J
         LQ9p7GxanzwBe/hwzOyWnmGxL8aoAxBe3BHhiF2Gjr6+3LCvMgqPeXblViRX4pkgznFT
         T7j9INGVg7jTdocliDX2a/6BuHa4cn+hzveK00lHIbUlkpX/9vKNdy7BpieEC3moBOgr
         2YJg==
X-Gm-Message-State: AOJu0Yynr7vdg4OMKk0/xrGKFjlAxE+cOmBvB0k0sk4lh/clIvgFh+wo
        AFG976UJJpQrLaBK5ffE2TkHv5S8IEHdBGJwgn/Yyw==
X-Google-Smtp-Source: AGHT+IEFP5h6gyUleqhrcBnfEzI2pGQQkA6uduNgmXyE3O4HjtuRG/I79w/ZsrL3yq2XBroaDuXpo5h7zBtxGNqHG4Q=
X-Received: by 2002:a50:d61c:0:b0:51e:16c5:2004 with SMTP id
 x28-20020a50d61c000000b0051e16c52004mr433357edi.6.1695910705390; Thu, 28 Sep
 2023 07:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230928100418.521594-1-yajun.deng@linux.dev>
In-Reply-To: <20230928100418.521594-1-yajun.deng@linux.dev>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 28 Sep 2023 16:18:11 +0200
Message-ID: <CANn89iL9uy58ZrZRPEtrvQ7ckv5hVTq8shx3OesQA6SWoUOP=g@mail.gmail.com>
Subject: Re: [PATCH v6] net/core: Introduce netdev_core_stats_inc()
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
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

On Thu, Sep 28, 2023 at 12:04=E2=80=AFPM Yajun Deng <yajun.deng@linux.dev> =
wrote:
>
> Although there is a kfree_skb_reason() helper function that can be used t=
o
> find the reason why this skb is dropped, but most callers didn't increase
> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>
> For the users, people are more concerned about why the dropped in ip
> is increasing.
>
> Introduce netdev_core_stats_inc() for trace the caller of the dropped
> skb. Also, add __code to netdev_core_stats_alloc(), as it's called
> unlinkly.
>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
> v6: merge netdev_core_stats and netdev_core_stats_inc together
> v5: Access the per cpu pointer before reach the relevant offset.
> v4: Introduce netdev_core_stats_inc() instead of export dev_core_stats_*_=
inc()
> v3: __cold should be added to the netdev_core_stats_alloc().
> v2: use __cold instead of inline in dev_core_stats().
> v1: https://lore.kernel.org/netdev/20230911082016.3694700-1-yajun.deng@li=
nux.dev/
> ---
>  include/linux/netdevice.h | 21 ++++-----------------
>  net/core/dev.c            | 17 +++++++++++++++--
>  2 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 7e520c14eb8c..eb1fa04fbccc 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4002,32 +4002,19 @@ static __always_inline bool __is_skb_forwardable(=
const struct net_device *dev,
>         return false;
>  }
>
> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct ne=
t_device *dev);
> -
> -static inline struct net_device_core_stats __percpu *dev_core_stats(stru=
ct net_device *dev)
> -{
> -       /* This READ_ONCE() pairs with the write in netdev_core_stats_all=
oc() */
> -       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_=
stats);
> -
> -       if (likely(p))
> -               return p;
> -
> -       return netdev_core_stats_alloc(dev);
> -}
> +void netdev_core_stats_inc(struct net_device *dev, u32 offset);
>
>  #define DEV_CORE_STATS_INC(FIELD)                                       =
       \
>  static inline void dev_core_stats_##FIELD##_inc(struct net_device *dev) =
               \
>  {                                                                       =
       \
> -       struct net_device_core_stats __percpu *p;                        =
       \
> -                                                                        =
       \
> -       p =3D dev_core_stats(dev);                                       =
         \
> -       if (p)                                                           =
       \
> -               this_cpu_inc(p->FIELD);                                  =
       \

Note that we were using this_cpu_inc() which implied :
- IRQ safety, and
- a barrier paired with :

net/core/dev.c:10548:                   storage->rx_dropped +=3D
READ_ONCE(core_stats->rx_dropped);
net/core/dev.c:10549:                   storage->tx_dropped +=3D
READ_ONCE(core_stats->tx_dropped);
net/core/dev.c:10550:                   storage->rx_nohandler +=3D
READ_ONCE(core_stats->rx_nohandler);
net/core/dev.c:10551:                   storage->rx_otherhost_dropped
+=3D READ_ONCE(core_stats->rx_otherhost_dropped);


> +       netdev_core_stats_inc(dev,                                       =
       \
> +                       offsetof(struct net_device_core_stats, FIELD));  =
       \
>  }
>  DEV_CORE_STATS_INC(rx_dropped)
>  DEV_CORE_STATS_INC(tx_dropped)
>  DEV_CORE_STATS_INC(rx_nohandler)
>  DEV_CORE_STATS_INC(rx_otherhost_dropped)
> +#undef DEV_CORE_STATS_INC
>
>  static __always_inline int ____dev_forward_skb(struct net_device *dev,
>                                                struct sk_buff *skb,
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 606a366cc209..88a32c392c1d 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10497,7 +10497,8 @@ void netdev_stats_to_stats64(struct rtnl_link_sta=
ts64 *stats64,
>  }
>  EXPORT_SYMBOL(netdev_stats_to_stats64);
>
> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct ne=
t_device *dev)
> +static __cold struct net_device_core_stats __percpu *netdev_core_stats_a=
lloc(
> +               struct net_device *dev)
>  {
>         struct net_device_core_stats __percpu *p;
>
> @@ -10510,7 +10511,19 @@ struct net_device_core_stats __percpu *netdev_co=
re_stats_alloc(struct net_device
>         /* This READ_ONCE() pairs with the cmpxchg() above */
>         return READ_ONCE(dev->core_stats);
>  }
> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> +
> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> +{
> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_all=
oc() */
> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_=
stats);
> +
> +       if (unlikely(!p))
> +               p =3D netdev_core_stats_alloc(dev);
> +
> +       if (p)
> +               (*(unsigned long *)((void *)this_cpu_ptr(p) + offset))++;

While here you are using a ++ operation that :

- is not irq safe
- might cause store-tearing.

I would suggest a preliminary patch converting the "unsigned long" fields i=
n
struct net_device_core_stats to local_t

You might be able tweak this to

unsigned long __percpu *field =3D (unsigned long __percpu) ((u8 *)p + offse=
t);
this_cpu_inc(field);
