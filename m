Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4927BC50B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbjJGGe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343532AbjJGGeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:34:25 -0400
Received: from out-199.mta1.migadu.com (out-199.mta1.migadu.com [IPv6:2001:41d0:203:375::c7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FEFBB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 23:34:23 -0700 (PDT)
Message-ID: <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696660461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=164fi8WKatcYnfdByz89GCJp0d9PaeaJodq2iuqS8u0=;
        b=gmKLb+XRWZ3H2t9zK/hB3r8ubUwhoaxP3uJ3qI1/Ze1ffLT4pKEU4v8QxLlcJRiLOXUViG
        OztTEgC6nco6eCtKBIoyLIh6CQzDyREQ4NG3yDCwxktbv8COYARr80X2I7l2PZPK93y3gR
        fB+E9mpDVEA7AZPppMV3Ry4GDy7Ky4U=
Date:   Sat, 7 Oct 2023 14:34:11 +0800
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
 <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/7 13:29, Eric Dumazet wrote:
> On Sat, Oct 7, 2023 at 7:06 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>> Although there is a kfree_skb_reason() helper function that can be used to
>> find the reason why this skb is dropped, but most callers didn't increase
>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>>
> ...
>
>> +
>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
>> +{
>> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
>> +       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
>> +       unsigned long *field;
>> +
>> +       if (unlikely(!p))
>> +               p = netdev_core_stats_alloc(dev);
>> +
>> +       if (p) {
>> +               field = (unsigned long *)((void *)this_cpu_ptr(p) + offset);
>> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);
> This is broken...
>
> As I explained earlier, dev_core_stats_xxxx(dev) can be called from
> many different contexts:
>
> 1) process contexts, where preemption and migration are allowed.
> 2) interrupt contexts.
>
> Adding WRITE_ONCE()/READ_ONCE() is not solving potential races.
>
> I _think_ I already gave you how to deal with this ?


Yes, I replied in v6.

https://lore.kernel.org/all/e25b5f3c-bd97-56f0-de86-b93a3172870d@linux.dev/

> Please try instead:
>
> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> +{
> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
> +       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
> +       unsigned long __percpu *field;
> +
> +       if (unlikely(!p)) {
> +               p = netdev_core_stats_alloc(dev);
> +               if (!p)
> +                       return;
> +       }
> +       field = (__force unsigned long __percpu *)((__force void *)p + offset);
> +       this_cpu_inc(*field);
> +}


This wouldn't trace anything even the rx_dropped is in increasing. It 
needs to add an extra operation, such as:

pr_info, ++, trace_xxx... . I don't know what's going on.

If this is adopted, I need to send two patches, one is  introduce 
netdev_core_stats_inc, another is add an tracepoint , like:


+void netdev_core_stats_inc(struct net_device *dev, u32 offset)
+{
+       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
+       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
+       unsigned long __percpu *field;
+
+       if (unlikely(!p)) {
+               p = netdev_core_stats_alloc(dev);
+               if (!p)
+                       return;
+       }
+	trace_netdev_core_stats_inc(dev, offset);
+       field = (__force unsigned long __percpu *)((__force void *)p + offset);
+       this_cpu_inc(*field);
+}


--- a/include/trace/events/net.h
+++ b/include/trace/events/net.h

+TRACE_EVENT(netdev_core_stats_inc,
+
+       TP_PROTO(struct net_device *dev,
+                u32 offset),
+
+       TP_ARGS(dev, offset),
+
+       TP_STRUCT__entry(
+               __string(       name,           dev->name )
+               __string(       driver, netdev_drivername(dev))
+               __field(        u32,            offset          )
+       ),
+
+       TP_fast_assign(
+               __assign_str(name, dev->name);
+               __assign_str(driver, netdev_drivername(dev));
+               __entry->offset = offset;
+       ),
+
+       TP_printk("dev=%s driver=%s offset=%u",
+               __get_str(name), __get_str(driver), __entry->offset)
+);


We can trace netdev_core_stats_inc by tracepoint or kprobe.

