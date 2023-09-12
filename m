Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C3779C4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjILEYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjILEYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:24:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2403D10DD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:23:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c3a2ea2816so72165ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694492616; x=1695097416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e86HSJwRGcmJDcBfAyZUWM/kB+djN8bXOhlNPzJ2TvY=;
        b=rl0BeNTTjKy1alqEb8IaLKpDZAN+2wg+rg7rHpnpC6Kh4TFS+KldhfQQ+XUYXMmVJM
         xRhH95K+ysgzAZQjhdD6No3tkmAbzrUG4E6P9D9/oYDMYDyCWy3OJDBv+9hXCZqJTVoV
         5Vcge3ThzKT2C/15BT/htBnoUgUP62dWtDprvceScOx5ymZjropH9iYcDX3jvzYSQ0iX
         f8JEE3AmiuEm91TZ8DQCyJ2snAlxpyDZpJBIEWXhjMBCClSzNJVT65I1DqFD6Bh2G0AT
         dg4P9k8NZCt6wfsOgwt3miMt5sNWi/6ZIJ9GOh23Xt3+lDbTSSl2r2L84qR8AcUJJGYW
         7fYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694492616; x=1695097416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e86HSJwRGcmJDcBfAyZUWM/kB+djN8bXOhlNPzJ2TvY=;
        b=rKJ3kYfTrbm5UkZJm+WtfU3HQT/cQDskBB7uc7E0/n76YJ7DzPkOpDOKEC84bOFec/
         f//XvionaK6D6xUnWLU8Q2JbXkTuOkB2ges0p+mLK6NxQ2c3Jpxp3N7Bcs38IWYquHm9
         PjlHMUR5PYmhcmk1wZ6QgBplGoqQeu66ffBkGNCykHPjNKtDk9uZJGnSXQLbiCR6WnOs
         qB9EWuFZ2i/V/zyyiiNPs3jtNEGktHKYujTIzJaLscnE6EIkeZUJy0FYPFczCspX7vTp
         LB6j4s08zyHEc1fsLZgqxIpP9B1p9zrAUqx8id91+IjbFAq5+7Sx0jAaPBtrkUB0RexN
         o+Dg==
X-Gm-Message-State: AOJu0YxEelmXlc9PmGu1+jUthZh5WanU34BdJfqegiwNfzoDtM57Lc5o
        Ax9aiFGCDOqZVPAftiY2qe0bnyhD7H+BPPXPthER3g==
X-Google-Smtp-Source: AGHT+IFvIC6HsjLpFz4Q6lIOwbhumvid2z3YBaaTD9wl9JQPyj/Ib85J15uaWKUQoY/kymlDQXEfO6X4yMqqbou0XGQ=
X-Received: by 2002:a17:902:c40b:b0:1c0:7dec:e5b2 with SMTP id
 k11-20020a170902c40b00b001c07dece5b2mr171793plk.4.1694492616154; Mon, 11 Sep
 2023 21:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
In-Reply-To: <20230911082016.3694700-1-yajun.deng@linux.dev>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 12 Sep 2023 06:23:24 +0200
Message-ID: <CANn89i+W1iAQmOhunLbqpvHu8EUO6uawv6Uvx7qimyBa_PBNCg@mail.gmail.com>
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:20=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev> =
wrote:
>
> Although there is a kfree_skb_reason() helper function that can be used
> to find the reason for dropped packets, but most callers didn't increase
> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>
> For the users, people are more concerned about why the dropped in ifconfi=
g
> is increasing. So we can export dev_core_stats_rx_dropped_inc sets,
> which users would trace them know why rx_dropped is increasing.
>
> Export dev_core_stats_{rx_dropped, tx_dropped, rx_nohandler,
> rx_otherhost_dropped}_inc for trace. Also, move dev_core_stats()
> and netdev_core_stats_alloc() in dev.c, because they are not called
> externally.
>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Okay, but it seems you forgot to say which tree was targeted by this patch.

Documentation/process/maintainer-netdev.rst

I would guess net-next, but patch authors are supposed to be explicit.

> ---
>  include/linux/netdevice.h | 32 +++++---------------------------
>  net/core/dev.c            | 30 ++++++++++++++++++++++++++++--
>  2 files changed, 33 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0896aaa91dd7..879b01c85ba4 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3954,6 +3954,11 @@ int dev_forward_skb_nomtu(struct net_device *dev, =
struct sk_buff *skb);
>  bool is_skb_forwardable(const struct net_device *dev,
>                         const struct sk_buff *skb);
>
> +void dev_core_stats_rx_dropped_inc(struct net_device *dev);
> +void dev_core_stats_tx_dropped_inc(struct net_device *dev);
> +void dev_core_stats_rx_nohandler_inc(struct net_device *dev);
> +void dev_core_stats_rx_otherhost_dropped_inc(struct net_device *dev);
> +
>  static __always_inline bool __is_skb_forwardable(const struct net_device=
 *dev,
>                                                  const struct sk_buff *sk=
b,
>                                                  const bool check_mtu)
> @@ -3980,33 +3985,6 @@ static __always_inline bool __is_skb_forwardable(c=
onst struct net_device *dev,
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
> -
> -#define DEV_CORE_STATS_INC(FIELD)                                       =
       \
> -static inline void dev_core_stats_##FIELD##_inc(struct net_device *dev) =
               \
> -{                                                                       =
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
> -}
> -DEV_CORE_STATS_INC(rx_dropped)
> -DEV_CORE_STATS_INC(tx_dropped)
> -DEV_CORE_STATS_INC(rx_nohandler)
> -DEV_CORE_STATS_INC(rx_otherhost_dropped)
> -
>  static __always_inline int ____dev_forward_skb(struct net_device *dev,
>                                                struct sk_buff *skb,
>                                                const bool check_mtu)
> diff --git a/net/core/dev.c b/net/core/dev.c
> index ccff2b6ef958..32ba730405b4 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10475,7 +10475,7 @@ void netdev_stats_to_stats64(struct rtnl_link_sta=
ts64 *stats64,
>  }
>  EXPORT_SYMBOL(netdev_stats_to_stats64);
>
> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct ne=
t_device *dev)
> +static struct net_device_core_stats __percpu *netdev_core_stats_alloc(st=
ruct net_device *dev)
>  {
>         struct net_device_core_stats __percpu *p;
>
> @@ -10488,7 +10488,33 @@ struct net_device_core_stats __percpu *netdev_co=
re_stats_alloc(struct net_device
>         /* This READ_ONCE() pairs with the cmpxchg() above */
>         return READ_ONCE(dev->core_stats);
>  }
> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> +
> +static inline struct net_device_core_stats __percpu *dev_core_stats(stru=
ct net_device *dev)

Please remove this inline attritbute. Consider using __cold instead.

> +{
> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_all=
oc() */
> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_=
stats);
> +
> +       if (likely(p))
> +               return p;
> +
> +       return netdev_core_stats_alloc(dev);
> +}
> +
> +#define DEV_CORE_STATS_INC(FIELD)                              \
> +void dev_core_stats_##FIELD##_inc(struct net_device *dev)      \
> +{                                                              \
> +       struct net_device_core_stats __percpu *p;               \
> +                                                               \
> +       p =3D dev_core_stats(dev);                                \
> +       if (p)                                                  \
> +               this_cpu_inc(p->FIELD);                         \
> +}                                                              \
> +EXPORT_SYMBOL(dev_core_stats_##FIELD##_inc)
> +
> +DEV_CORE_STATS_INC(rx_dropped);
> +DEV_CORE_STATS_INC(tx_dropped);
> +DEV_CORE_STATS_INC(rx_nohandler);
> +DEV_CORE_STATS_INC(rx_otherhost_dropped);

#undef DEV_CORE_STATS_INC

>
>  /**
>   *     dev_get_stats   - get network device statistics
> --
> 2.25.1
>
