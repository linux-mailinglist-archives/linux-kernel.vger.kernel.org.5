Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A47AF88F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjI0DS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjI0DQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:16:19 -0400
Received: from out-209.mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702B283F8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 19:38:00 -0700 (PDT)
Message-ID: <0ab15605-7522-786f-00f2-c06077da1168@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695782278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rzy/yzJGX3vmZN6LvPzIURfZfV+Wu7k4Zhqp+zRpEvo=;
        b=vPkjuV+maDyWuWd101llsu2JyGnwUSULUJB/OcMI4sx1ihqKc6iyTu/kNxZuEOPhQEM6k/
        PZnRtvbkqdeijgki11/JnTXxCM4cJ8ErLWfxq+0lqodOV9jkJL9hS+M/q28tmQcE3V4E8p
        HQwt0lXk1+9Wy1d5T0t33JJk6bjvSNQ=
Date:   Wed, 27 Sep 2023 10:37:49 +0800
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5] net/core: Introduce netdev_core_stats_inc()
 for trace
Content-Language: en-US
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20230919135517.286766-1-yajun.deng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20230919135517.286766-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, MAINTAINERS,

Kindly ping...

Thanks


On 2023/9/19 21:55, Yajun Deng wrote:
> Although there is a kfree_skb_reason() helper function that can be used to
> find the reason why this skb is dropped, but most callers didn't increase
> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>
> For the users, people are more concerned about why the dropped in ip
> is increasing.
>
> Introduce netdev_core_stats_inc() for trace. Also, move dev_core_stats()
> and netdev_core_stats_alloc() to dev.c, as they are not called externally.
>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
> v5: Access the per cpu pointer before reach the relevant offset.
> v4: Introduce netdev_core_stats_inc() instead of export dev_core_stats_*_inc()
> v3: __cold should be added to the netdev_core_stats_alloc().
> v2: use __cold instead of inline in dev_core_stats().
> v1: https://lore.kernel.org/netdev/20230911082016.3694700-1-yajun.deng@linux.dev/
> ---
>   include/linux/netdevice.h | 21 ++++-----------------
>   net/core/dev.c            | 26 ++++++++++++++++++++++++--
>   2 files changed, 28 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index db3d8429d50d..4c258d44c7d2 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4001,32 +4001,19 @@ static __always_inline bool __is_skb_forwardable(const struct net_device *dev,
>   	return false;
>   }
>   
> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev);
> -
> -static inline struct net_device_core_stats __percpu *dev_core_stats(struct net_device *dev)
> -{
> -	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
> -	struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
> -
> -	if (likely(p))
> -		return p;
> -
> -	return netdev_core_stats_alloc(dev);
> -}
> +void netdev_core_stats_inc(struct net_device *dev, u32 offset);
>   
>   #define DEV_CORE_STATS_INC(FIELD)						\
>   static inline void dev_core_stats_##FIELD##_inc(struct net_device *dev)		\
>   {										\
> -	struct net_device_core_stats __percpu *p;				\
> -										\
> -	p = dev_core_stats(dev);						\
> -	if (p)									\
> -		this_cpu_inc(p->FIELD);						\
> +	netdev_core_stats_inc(dev,						\
> +			offsetof(struct net_device_core_stats, FIELD));		\
>   }
>   DEV_CORE_STATS_INC(rx_dropped)
>   DEV_CORE_STATS_INC(tx_dropped)
>   DEV_CORE_STATS_INC(rx_nohandler)
>   DEV_CORE_STATS_INC(rx_otherhost_dropped)
> +#undef DEV_CORE_STATS_INC
>   
>   static __always_inline int ____dev_forward_skb(struct net_device *dev,
>   					       struct sk_buff *skb,
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 606a366cc209..4bc0161bc0d6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10497,7 +10497,8 @@ void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
>   }
>   EXPORT_SYMBOL(netdev_stats_to_stats64);
>   
> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
> +static __cold struct net_device_core_stats __percpu *netdev_core_stats_alloc(
> +		struct net_device *dev)
>   {
>   	struct net_device_core_stats __percpu *p;
>   
> @@ -10510,7 +10511,28 @@ struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device
>   	/* This READ_ONCE() pairs with the cmpxchg() above */
>   	return READ_ONCE(dev->core_stats);
>   }
> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> +
> +static inline struct net_device_core_stats __percpu *netdev_core_stats(
> +		struct net_device *dev)
> +{
> +	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
> +	struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
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
> +	p = netdev_core_stats(dev);
> +	if (p)
> +		(*(unsigned long *)((void *)this_cpu_ptr(p) + offset))++;
> +}
> +EXPORT_SYMBOL_GPL(netdev_core_stats_inc);
>   
>   /**
>    *	dev_get_stats	- get network device statistics
