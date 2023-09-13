Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF5479DE3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbjIMCUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjIMCUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:20:47 -0400
Received: from out-226.mta1.migadu.com (out-226.mta1.migadu.com [95.215.58.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C018170A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 19:20:43 -0700 (PDT)
Message-ID: <b0278635-2c6f-c316-f7ff-64c6978dac95@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694571641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8wsciRXxC4ZkB77LojSqC5l3QSYtqdqHx5TpDtcjbg=;
        b=luS8ZCIIDr1Q7HVRMIMRCuClOJm+JpXL7F3OdTGcEpMru6cqNBfyvjBF2mai+fCnUGUo1u
        +i1RAmE3gJKihn6E9zU7Nn60IWl+2jcAI+SSj2fEE4+TgGgZPYiXHbKGgIrurlQyQEU7GX
        fEoxe6HEPQ5Ff6NT+5xhxsmYKWcBlCk=
Date:   Wed, 13 Sep 2023 10:20:32 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
 <CANn89i+W1iAQmOhunLbqpvHu8EUO6uawv6Uvx7qimyBa_PBNCg@mail.gmail.com>
 <f3e84a37-3218-0d52-e7ed-2d215fed58e3@intel.com>
 <CANn89i+AwmpjM-bNuYRS26v-GRrVoucewxgmkvv25PNM4VWPGA@mail.gmail.com>
 <39c906f6-910d-01c7-404a-8fe6a161ef2e@intel.com>
 <CANn89i+QSPoXphaLzfKCqCHxjsD20ifr8YPJM_fZ_H5kFZ7dwQ@mail.gmail.com>
 <8bc6c1cd-50bb-44ef-5979-3bb50a70afcb@intel.com>
 <CANn89iL6HVvRegORfP49prJV4EJU2-AbD4YXB-eo_vwU1JG1ew@mail.gmail.com>
 <CANn89iKbn97Rbjc+3uZMpUi0tqCuhj88UdFZhhnqpC6nJRLC=A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <CANn89iKbn97Rbjc+3uZMpUi0tqCuhj88UdFZhhnqpC6nJRLC=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/9/13 02:05, Eric Dumazet wrote:
> On Tue, Sep 12, 2023 at 8:03 PM Eric Dumazet <edumazet@google.com> wrote:
>
>> Sure, this was what was suggested (perhaps not _very_ precisely, but
>> the general idea was pretty clear).
>> v2 seems ok, right ?
>>
>> It seems we are all on the same page.
>>
>> +static __cold struct net_device_core_stats __percpu
>> *dev_core_stats(struct net_device *dev)
>> +{
>> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
>> +       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
>> +
>> +       if (likely(p))
>> +               return p;
>> +
>> +       return netdev_core_stats_alloc(dev);
>> +}
>> +
>> +#define DEV_CORE_STATS_INC(FIELD)                              \
>> +void dev_core_stats_##FIELD##_inc(struct net_device *dev)      \
>> +{                                                              \
>> +       struct net_device_core_stats __percpu *p;               \
>> +                                                               \
>> +       p = dev_core_stats(dev);                                \
>> +       if (p)                                                  \
>> +               this_cpu_inc(p->FIELD);                         \
>> +}                                                              \
>> +EXPORT_SYMBOL(dev_core_stats_##FIELD##_inc)
> Oh well, I just read the patch, and it seems wrong indeed.
>
> netdev_core_stats_alloc() is the one that can be cold.

Okay, I would add __cold to netdev_core_stats_alloc() in v3.

Olek suggest that define a new dev_core_stats_inc() function.

I hope to see the suggestion in another reply.

