Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7317B2270
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjI1Qc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjI1Qcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:32:55 -0400
Received: from out-197.mta0.migadu.com (out-197.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8BEBF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:32:53 -0700 (PDT)
Message-ID: <a94ca1e1-d29a-5d98-bf39-97c7a1f25372@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695918771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aQNi1mC/izOSusenC5e0FzCnoHgYl2k/8yWq7CFqMaw=;
        b=bnIzyU8kg1mVUs1LxL6r0w7GvDxkEiiVBwY6dTWXig9Q87mppri4IBtjcwcX4dbCuIZbDN
        KsNh0eujqGmIZ+fLan/m4MMA+SezSiY6sLKEJndUVPDAaeihu1u9CHjrUPbc6jVNdaRvaX
        gbT8ksM2Vgk1lAxzHw4LxQ606rSkX/k=
Date:   Fri, 29 Sep 2023 00:32:36 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v6] net/core: Introduce netdev_core_stats_inc()
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20230928100418.521594-1-yajun.deng@linux.dev>
 <CANn89iL9uy58ZrZRPEtrvQ7ckv5hVTq8shx3OesQA6SWoUOP=g@mail.gmail.com>
 <c43a3dde-fa4d-4a87-6f96-397813db5bd6@linux.dev>
 <CANn89i+iT11qzCidTrHHRMQiYR-nXtbPNAUJGaEg0NQMCq_8CA@mail.gmail.com>
 <5d8e302c-a28d-d4f4-eb91-4b54eb89490b@linux.dev>
 <CANn89i+XQ_LKvr5LHd2QUgTMfZh9Nd1yQTYfRORHUt2_BCkxcg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <CANn89i+XQ_LKvr5LHd2QUgTMfZh9Nd1yQTYfRORHUt2_BCkxcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/9/29 00:23, Eric Dumazet wrote:
> On Thu, Sep 28, 2023 at 6:16 PM Yajun Deng <yajun.deng@linux.dev> wrote:
>>
>> On 2023/9/28 23:44, Eric Dumazet wrote:
>>> On Thu, Sep 28, 2023 at 5:40 PM Yajun Deng <yajun.deng@linux.dev> wrote:
>>>> On 2023/9/28 22:18, Eric Dumazet wrote:
>>>>> On Thu, Sep 28, 2023 at 12:04 PM Yajun Deng <yajun.deng@linux.dev> wrote:
>>>>>> Although there is a kfree_skb_reason() helper function that can be used to
>>>>>> find the reason why this skb is dropped, but most callers didn't increase
>>>>>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>>>>>>
>>>>>> For the users, people are more concerned about why the dropped in ip
>>>>>> is increasing.
>>>>>>
>>>>>> Introduce netdev_core_stats_inc() for trace the caller of the dropped
>>>>>> skb. Also, add __code to netdev_core_stats_alloc(), as it's called
>>>>>> unlinkly.
>>>>>>
>>>>>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>>>>>> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>>>> ---
>>>>>> v6: merge netdev_core_stats and netdev_core_stats_inc together
>>>>>> v5: Access the per cpu pointer before reach the relevant offset.
>>>>>> v4: Introduce netdev_core_stats_inc() instead of export dev_core_stats_*_inc()
>>>>>> v3: __cold should be added to the netdev_core_stats_alloc().
>>>>>> v2: use __cold instead of inline in dev_core_stats().
>>>>>> v1: https://lore.kernel.org/netdev/20230911082016.3694700-1-yajun.deng@linux.dev/
>>>>>> ---
>>>>>>     include/linux/netdevice.h | 21 ++++-----------------
>>>>>>     net/core/dev.c            | 17 +++++++++++++++--
>>>>>>     2 files changed, 19 insertions(+), 19 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>>>> index 7e520c14eb8c..eb1fa04fbccc 100644
>>>>>> --- a/include/linux/netdevice.h
>>>>>> +++ b/include/linux/netdevice.h
>>>>>> @@ -4002,32 +4002,19 @@ static __always_inline bool __is_skb_forwardable(const struct net_device *dev,
>>>>>>            return false;
>>>>>>     }
>>>>>>
>>>>>> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev);
>>>>>> -
>>>>>> -static inline struct net_device_core_stats __percpu *dev_core_stats(struct net_device *dev)
>>>>>> -{
>>>>>> -       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
>>>>>> -       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
>>>>>> -
>>>>>> -       if (likely(p))
>>>>>> -               return p;
>>>>>> -
>>>>>> -       return netdev_core_stats_alloc(dev);
>>>>>> -}
>>>>>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset);
>>>>>>
>>>>>>     #define DEV_CORE_STATS_INC(FIELD)                                              \
>>>>>>     static inline void dev_core_stats_##FIELD##_inc(struct net_device *dev)                \
>>>>>>     {                                                                              \
>>>>>> -       struct net_device_core_stats __percpu *p;                               \
>>>>>> -                                                                               \
>>>>>> -       p = dev_core_stats(dev);                                                \
>>>>>> -       if (p)                                                                  \
>>>>>> -               this_cpu_inc(p->FIELD);                                         \
>>>>> Note that we were using this_cpu_inc() which implied :
>>>>> - IRQ safety, and
>>>>> - a barrier paired with :
>>>>>
>>>>> net/core/dev.c:10548:                   storage->rx_dropped +=
>>>>> READ_ONCE(core_stats->rx_dropped);
>>>>> net/core/dev.c:10549:                   storage->tx_dropped +=
>>>>> READ_ONCE(core_stats->tx_dropped);
>>>>> net/core/dev.c:10550:                   storage->rx_nohandler +=
>>>>> READ_ONCE(core_stats->rx_nohandler);
>>>>> net/core/dev.c:10551:                   storage->rx_otherhost_dropped
>>>>> += READ_ONCE(core_stats->rx_otherhost_dropped);
>>>>>
>>>>>
>>>>>> +       netdev_core_stats_inc(dev,                                              \
>>>>>> +                       offsetof(struct net_device_core_stats, FIELD));         \
>>>>>>     }
>>>>>>     DEV_CORE_STATS_INC(rx_dropped)
>>>>>>     DEV_CORE_STATS_INC(tx_dropped)
>>>>>>     DEV_CORE_STATS_INC(rx_nohandler)
>>>>>>     DEV_CORE_STATS_INC(rx_otherhost_dropped)
>>>>>> +#undef DEV_CORE_STATS_INC
>>>>>>
>>>>>>     static __always_inline int ____dev_forward_skb(struct net_device *dev,
>>>>>>                                                   struct sk_buff *skb,
>>>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>>>> index 606a366cc209..88a32c392c1d 100644
>>>>>> --- a/net/core/dev.c
>>>>>> +++ b/net/core/dev.c
>>>>>> @@ -10497,7 +10497,8 @@ void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
>>>>>>     }
>>>>>>     EXPORT_SYMBOL(netdev_stats_to_stats64);
>>>>>>
>>>>>> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
>>>>>> +static __cold struct net_device_core_stats __percpu *netdev_core_stats_alloc(
>>>>>> +               struct net_device *dev)
>>>>>>     {
>>>>>>            struct net_device_core_stats __percpu *p;
>>>>>>
>>>>>> @@ -10510,7 +10511,19 @@ struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device
>>>>>>            /* This READ_ONCE() pairs with the cmpxchg() above */
>>>>>>            return READ_ONCE(dev->core_stats);
>>>>>>     }
>>>>>> -EXPORT_SYMBOL(netdev_core_stats_alloc);
>>>>>> +
>>>>>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
>>>>>> +{
>>>>>> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
>>>>>> +       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
>>>>>> +
>>>>>> +       if (unlikely(!p))
>>>>>> +               p = netdev_core_stats_alloc(dev);
>>>>>> +
>>>>>> +       if (p)
>>>>>> +               (*(unsigned long *)((void *)this_cpu_ptr(p) + offset))++;
>>>>> While here you are using a ++ operation that :
>>>>>
>>>>> - is not irq safe
>>>>> - might cause store-tearing.
>>>>>
>>>>> I would suggest a preliminary patch converting the "unsigned long" fields in
>>>>> struct net_device_core_stats to local_t
>>>> Do you mean it needs to revert the commit 6510ea973d8d ("net: Use
>>>> this_cpu_inc() to increment
>>>>
>>>> net->core_stats") first? But it would allocate memory which breaks on
>>>> PREEMPT_RT.
>>> I think I provided an (untested) alternative.
>>>
>>> unsigned long __percpu *field = (__force unsigned long __percpu *)
>>> ((__force u8 *)p + offset);
>>> this_cpu_inc(field);
>> unsigned long __percpu *field = (__force unsigned long __percpu *)
>> ((__force u8 *)p + offset);
>> this_cpu_inc(*(int *)field);
>>
>> This would compiler success. But I didn't test it.
>> This cold look complex.
> Why exactly ? Not very different from the cast you already had.
Okay, I'll test it.
>
>> Shoud I base v3? Export dev_core_stats_*_inc() intead of introduce netdev_core_stats_inc().
>> That would be easy.
> Well, you tell me, but this does not look incremental to me.
>
> I do not think we need 4 different (and maybe more to come if struct
> net_device_core_stats
> grows in the future) functions for some hardly used path.
