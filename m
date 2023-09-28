Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A007B15FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjI1IYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1IYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D137192
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695889435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TM7F2V+whzsqECetEhOwq9nYpakVVR6ES249GfF2OOE=;
        b=LdPPCiPZ8PtIcYZ+tJ3J46jdif1hnX9tf+Fw7wVb/F9M9cUeOsVRmFwM6oHEkmWydCcaG4
        08P84VGEmd0SIVj2rQ61G9O07xKxMnvSFktQV/uWtlYcEy/vMkrAkfqC6TWERQaKyutbYW
        +/D6O4xWfCQbene/4nrluRrZZWb2Iww=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-07kxruJ8Nemwv_hQpsF5XQ-1; Thu, 28 Sep 2023 04:23:54 -0400
X-MC-Unique: 07kxruJ8Nemwv_hQpsF5XQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae660b4e41so283602066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695889433; x=1696494233;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TM7F2V+whzsqECetEhOwq9nYpakVVR6ES249GfF2OOE=;
        b=PK4OTlrm0JTiQIQyJg008M4+3TA4C0ot2H0oliTS9WMOK9NgIFWhU1RrAADQCFbQLB
         xFhu2bEgC4bpduCKwe5KpQ2eyPKf6cCBjkThO08Ir1iQ3dMXU5zyOeLApCmbic42n8Js
         8UGWhCAdRjDriR7mOar1J3Il34J7cO5o7PMa2k1V9qY8a8Zy4W57wc8w3I51A1RzubLx
         kPqu64Q/mE25VfUW3nZXrKDElE/Hti/gBGNBtcCB0XjnL4nk26Vj6XT8pE17PvK/MRfy
         QKTY2TRAk2orjUHjenQDOmREJKjyfGeNillOX5rwD81eO0juKYUrzDTmEjP3xQni1ht7
         Tfkw==
X-Gm-Message-State: AOJu0YxzMm06PjeSo+8QNccB6DHECZXIKKU+qTuJthUvY+ZPlshmQ2Fr
        l7+P+dZ9xFM4evhPoXlmPSFJPEgLr4FpsTNqSh5ZH/0HUtvRyXVVvo5muZCqyfoIJQcUPhuRSNI
        8WnuySspyIDmjeNZzV12D4q7I
X-Received: by 2002:a17:906:2258:b0:9ad:e66a:413f with SMTP id 24-20020a170906225800b009ade66a413fmr522600ejr.3.1695889432886;
        Thu, 28 Sep 2023 01:23:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPuTntWZq4jrbubxAaZ/VaidO22QNmhzvK8g+giZ+Tt7KVFKqUVF9torBrPsxrDdQaKls0VQ==
X-Received: by 2002:a17:906:2258:b0:9ad:e66a:413f with SMTP id 24-20020a170906225800b009ade66a413fmr522583ejr.3.1695889432534;
        Thu, 28 Sep 2023 01:23:52 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-183.dyn.eolo.it. [146.241.233.183])
        by smtp.gmail.com with ESMTPSA id ck17-20020a170906c45100b00992e14af9c3sm10557001ejb.143.2023.09.28.01.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:23:51 -0700 (PDT)
Message-ID: <619e3735d99c8642b7b84a151515c2fee99ff694.camel@redhat.com>
Subject: Re: [PATCH net-next v5] net/core: Introduce netdev_core_stats_inc()
 for trace
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Date:   Thu, 28 Sep 2023 10:23:50 +0200
In-Reply-To: <20230919135517.286766-1-yajun.deng@linux.dev>
References: <20230919135517.286766-1-yajun.deng@linux.dev>
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

On Tue, 2023-09-19 at 21:55 +0800, Yajun Deng wrote:
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
> v5: Access the per cpu pointer before reach the relevant offset.
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
> index db3d8429d50d..4c258d44c7d2 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4001,32 +4001,19 @@ static __always_inline bool __is_skb_forwardable(=
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
> index 606a366cc209..4bc0161bc0d6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10497,7 +10497,8 @@ void netdev_stats_to_stats64(struct rtnl_link_sta=
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
> @@ -10510,7 +10511,28 @@ struct net_device_core_stats __percpu *netdev_co=
re_stats_alloc(struct net_device
>  	/* This READ_ONCE() pairs with the cmpxchg() above */
>  	return READ_ONCE(dev->core_stats);
>  }
> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> +
> +static inline struct net_device_core_stats __percpu *netdev_core_stats(
> +		struct net_device *dev)

I'm sorry for the delayed feedback - conference and traveling in the
way.

It looks like the 'inline' keyword above is a left-over of a previous
revision? The compiler should generate the same code even without it,
right? If so, it should be better drop it.

Cheers,

Paolo

