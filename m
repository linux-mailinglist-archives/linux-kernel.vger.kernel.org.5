Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89E17A5D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjISJLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjISJLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A30E6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695114661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fcHdjnvsZl7BjaN6uuW5yFHe3gIRLmoYmXk7ZuAeIGM=;
        b=DJGyWRHbbic97mLpI1gy1P0MC7+jYeWJ2khPvVkRFMYfnLxujqIU3IZgB1Q2kr6CPNDDSm
        HB5aym4SoxOTuIRACbspnZzX0HxHzsir6lr83KHRcwipVx5sbFWP538FdsEeqmVkKdeVjD
        jvZtxRmyqIGYd1HeipEPBVYcpvC/BaA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-1HTzO1IjPCmjem-Rnq7s6Q-1; Tue, 19 Sep 2023 05:10:59 -0400
X-MC-Unique: 1HTzO1IjPCmjem-Rnq7s6Q-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2a7a6393ba6so8740721fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695114658; x=1695719458;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcHdjnvsZl7BjaN6uuW5yFHe3gIRLmoYmXk7ZuAeIGM=;
        b=SWVbBE2OPuXhf0PNd4G1JCtO6agWGC6byMpcDih/gx8D39Tn3bLZEw78qcOUskOVnP
         70+XGkkmNejeoA/HqSU4ieyMArhow8tSQPEH/dcZmR5LYYHN+8/hI5N/W1tTQGNT+tEu
         kv8y+fpoaT+P2GQUxgGGHJQI59CoYG9/7upPlQrvk4YTfpg1+NMuLPgyW2ydz0ID3u1A
         6R+XFqIRxh/lQfSnO0kfHs1wYFowY8rfp2TysA6XFuT4bx0w6rrM5O9qgaE/Rfq6RvCj
         FefAuUnYswKa9XyZKPlkF0nf2frpbqegOy63V/Dk15g+c9EDo/Sb0j39TN55gOHiuGAb
         qCQg==
X-Gm-Message-State: AOJu0YxmUshobiW8qUImd5Evlq7x56VBNo+0vV2kmdrjcRPmEY/6BFu3
        IVaG1v9+Tr8ehfrLsD+YRo1S1GMbWmBNXMXjwjBWRRW1NaB9PLXg7y7RbcCg+OVu/LQIYU+fFkY
        q5RCPIEr48vh0M6TubqeQePY9
X-Received: by 2002:a2e:9cc1:0:b0:2b6:cd7f:5ea8 with SMTP id g1-20020a2e9cc1000000b002b6cd7f5ea8mr8870057ljj.1.1695114658063;
        Tue, 19 Sep 2023 02:10:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzNCtHxx1G8D5dQquuh1yRTdbin+4OnUI2A5JfldJjIBc1M1fbe4bXylu2CK7kCzoyts753Q==
X-Received: by 2002:a2e:9cc1:0:b0:2b6:cd7f:5ea8 with SMTP id g1-20020a2e9cc1000000b002b6cd7f5ea8mr8870037ljj.1.1695114657663;
        Tue, 19 Sep 2023 02:10:57 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it. [146.241.241.221])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906394500b0099bc038eb2bsm7488645eje.58.2023.09.19.02.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:10:57 -0700 (PDT)
Message-ID: <37c2c3163c053138da40be6713914c8bb103dada.camel@redhat.com>
Subject: Re: [PATCH net-next v4] net/core: Introduce netdev_core_stats_inc()
 for trace
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Date:   Tue, 19 Sep 2023 11:10:56 +0200
In-Reply-To: <20230918024055.221900-1-yajun.deng@linux.dev>
References: <20230918024055.221900-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-18 at 10:40 +0800, Yajun Deng wrote:
> Although there is a kfree_skb_reason() helper function that can be used t=
o
> find the reason why this skb is dropped, but most callers didn't increase
> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>=20
> For the users, people are more concerned about why the dropped in ip
> is increasing.
>=20
> Introduce netdev_core_stats_inc() for trace. Also, move dev_core_stats()
> and netdev_core_stats_alloc() to dev.c, as they are not called externally=
.
>=20
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
> v4: Introduce netdev_core_stats_inc() instead of export dev_core_stats_*_=
inc()
> v3: __cold should be added to the netdev_core_stats_alloc().
> v2: use __cold instead of inline in dev_core_stats().
> v1: https://lore.kernel.org/netdev/20230911082016.3694700-1-yajun.deng@li=
nux.dev/
> ---
>  include/linux/netdevice.h | 21 ++++-----------------
>  net/core/dev.c            | 26 ++++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 19 deletions(-)
>=20
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0896aaa91dd7..cddd4873b5b0 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3980,32 +3980,19 @@ static __always_inline bool __is_skb_forwardable(=
const struct net_device *dev,
>  	return false;
>  }
> =20
> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct ne=
t_device *dev);
> -
> -static inline struct net_device_core_stats __percpu *dev_core_stats(stru=
ct net_device *dev)
> -{
> -	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() *=
/
> -	struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_stats)=
;
> -
> -	if (likely(p))
> -		return p;
> -
> -	return netdev_core_stats_alloc(dev);
> -}
> +void netdev_core_stats_inc(struct net_device *dev, u32 offset);
> =20
>  #define DEV_CORE_STATS_INC(FIELD)						\
>  static inline void dev_core_stats_##FIELD##_inc(struct net_device *dev)	=
	\
>  {										\
> -	struct net_device_core_stats __percpu *p;				\
> -										\
> -	p =3D dev_core_stats(dev);						\
> -	if (p)									\
> -		this_cpu_inc(p->FIELD);						\
> +	netdev_core_stats_inc(dev,						\
> +			offsetof(struct net_device_core_stats, FIELD));		\
>  }
>  DEV_CORE_STATS_INC(rx_dropped)
>  DEV_CORE_STATS_INC(tx_dropped)
>  DEV_CORE_STATS_INC(rx_nohandler)
>  DEV_CORE_STATS_INC(rx_otherhost_dropped)
> +#undef DEV_CORE_STATS_INC
> =20
>  static __always_inline int ____dev_forward_skb(struct net_device *dev,
>  					       struct sk_buff *skb,
> diff --git a/net/core/dev.c b/net/core/dev.c
> index ccff2b6ef958..f4cccdf05450 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10475,7 +10475,8 @@ void netdev_stats_to_stats64(struct rtnl_link_sta=
ts64 *stats64,
>  }
>  EXPORT_SYMBOL(netdev_stats_to_stats64);
> =20
> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct ne=
t_device *dev)
> +static __cold struct net_device_core_stats __percpu *netdev_core_stats_a=
lloc(
> +		struct net_device *dev)
>  {
>  	struct net_device_core_stats __percpu *p;
> =20
> @@ -10488,7 +10489,28 @@ struct net_device_core_stats __percpu *netdev_co=
re_stats_alloc(struct net_device
>  	/* This READ_ONCE() pairs with the cmpxchg() above */
>  	return READ_ONCE(dev->core_stats);
>  }
> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> +
> +static inline struct net_device_core_stats __percpu *netdev_core_stats(
> +		struct net_device *dev)
> +{
> +	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() *=
/
> +	struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_stats)=
;
> +
> +	if (likely(p))
> +		return p;
> +
> +	return netdev_core_stats_alloc(dev);
> +}
> +
> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> +{
> +	struct net_device_core_stats __percpu *p;
> +
> +	p =3D netdev_core_stats(dev);
> +	if (p)
> +		this_cpu_inc(*(unsigned long *)((void *)p + offset));

The above is causing a lot of compile warning, as it's discarding the
(required) __percpu annotation.

You need to first access the per cpu pointer and then reach for the
relevant offset.

Cheers,

Paolo

