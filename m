Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367F8807847
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379068AbjLFS6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378756AbjLFS6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:58:38 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B824684
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B/13hdmqNR23VolDYTjF35n+60xsd3OI19AsLPEeAsM=; b=nFENwXmbHLBNEliqj1iolE2GRH
        3AhlLrfAaz6ImwVamFKO8jxuGzIh5+5TSxmnWkMVn3ouIEPi+gWu40wSHmfz0HNisAXzWYn/6ImX6
        br1bMeJBv0O6sk7CBo5m1w3aay7lb5juveDUtECS/XQ3yboe+Gaz9hI7rj97amWR9Ydqk+MHEI+9M
        s6VXUkVgxNMgtbP+c4VH/NqdE+Tc8EvwWvOyzEl7Ub5TBqV1xkD59zo5d4FKzAGDtkzfj/jOsGVym
        kGh12NAsjLwP07OF9rpDio8M87zus49tvvx7nZpmAl3qbuQl6sGr9UgS+sqLDGERM2NcSWctZw91+
        wRtKsgEg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAx6T-005Euo-2F;
        Wed, 06 Dec 2023 18:58:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58F1630057E; Wed,  6 Dec 2023 19:58:37 +0100 (CET)
Date:   Wed, 6 Dec 2023 19:58:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mintu Patel <mintupatel89@gmail.com>
Cc:     badolevishal1116@gmail.com, chinmoyghosh2001@gmail.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, vimal.kumar32@gmail.com, will@kernel.org
Subject: Re: [PATCH v2] rt_spin_lock: To list the correct owner of
 rt_spin_lock
Message-ID: <20231206185837.GB9899@noisy.programming.kicks-ass.net>
References: <20220619142038.1274-1-mintupatel89@gmail.com>
 <20220627161136.3468-1-mintupatel89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627161136.3468-1-mintupatel89@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:41:38PM +0530, Mintu Patel wrote:
>    rt_spin_lock is actually mutex on RT Kernel so it goes for contention
>    for lock. Currently owners of rt_spin_lock are decided before actual
>    acquiring of lock. This patch would depict the correct owner of
>    rt_spin_lock. The patch would help in solving crashes and deadlock
>    due to race condition of lock
> 
> acquiring rt_spin_lock        acquired the lock       released the lock
>                     <-------->                <------->
>                     contention period         Held period
> 
> Thread1                             Thread2
> _try_to_take_rt_mutex+0x95c+0x74    enqueue_task_dl+0x8cc/0x8dc
> rt_spin_lock_slowlock_locked+0xac+2 rt_mutex_setprio+0x28c/0x574
> rt_spin_lock_slowlock+0x5c/0x90     task_blocks_rt_mutex+0x240/0x310
> rt_spin_lock+0x58/0x5c              rt_spin_lock_slowlock_locked+0xac/0x2
> driverA_acquire_lock+0x28/0x56      rt_spin_lock_slowlock+0x5c/0x90
> 				    rt_spin_lock+0x58/0x5c
>                                     driverB_acquire_lock+0x48/0x6c
> 
> As per above call traces sample, Thread1 acquired the rt_spin_lock and
> went to critical section on the other hand Thread2 kept trying to acquire
> the same rt_spin_lock held by Thread1 ie contention period is too high.
> Finally Thread2 entered to dl queue due to high held time of the lock by
> Thread1. The below patch would help us to know the correct owner of
> rt_spin_lock and point us the driver's critical section. Respective
> driver need to be debugged for longer held period of lock.
> 
>    ex: cat /sys/kernel/debug/tracing/trace
> 
>    kworker/u13:0-150   [003] .....11   202.761025: rt_spinlock_acquire:
> Process: kworker/u13:0 is acquiring lock: &kbdev->hwaccess_lock
>    kworker/u13:0-150   [003] .....11   202.761039: rt_spinlock_acquired:
> Process: kworker/u13:0 has acquired lock: &kbdev->hwaccess_lock
>    kworker/u13:0-150   [003] .....11   202.761042: rt_spinlock_released:
> Process: kworker/u13:0 has released lock: &kbdev->hwaccess_lock
> 

The above is word salad and makes no sense. No other lock has special
tracing like this, so rt_lock doesn't need it either.


