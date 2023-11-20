Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A976D7F0B87
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 06:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjKTFSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 00:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTFSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 00:18:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85B0E3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 21:18:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BB1C433C8;
        Mon, 20 Nov 2023 05:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700457508;
        bh=jTkec1My+k2Nb+O4UyEnt0cpJFuDZeq1tJWMDiq4ZQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eggb3mR8aFO270UnAPvPxXNK9dURaVGSEnvuJL0OaqP7qG0qQk3bzuJgFdodeV+ba
         wkt379fxHlgiLH7v9+DD14voxmI2JOmcR6XW0jqiJdDCCpLxpBkmxNU2Fj5QPQ9vtn
         rcWX727W7UGM0VqFPD9ulNQNeF4/kyCXQyClx7RSlatND7UUB5IiePk1bcKGoGR7v6
         5hl7lAxCO9BMYZLYp7EzL1UTuK33YhBt6gG4JbfiOZCTyVqexkYq+QKadEzDafSnQE
         YO4OqKe8BAA/WCPi+imGNvf7W8Us57Yi/oLYj1EQCVmoRIdHdGIbZnP7ADaMhq4E3M
         Mx/KP8bk8KJqw==
Date:   Mon, 20 Nov 2023 14:18:24 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mattwu@163.com
Subject: Re: [PATCH v1] lib: objpool: fix head overrun on RK3588 SBC
Message-Id: <20231120141824.86bda7ae184baf331e3175d9@kernel.org>
In-Reply-To: <20231114115148.298821-1-wuqiang.matt@bytedance.com>
References: <20231114115148.298821-1-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 19:51:48 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> objpool overrun stress with test_objpool on OrangePi5+ SBC triggered the
> following kernel warnings:
> 
>     WARNING: CPU: 6 PID: 3115 at lib/objpool.c:168 objpool_push+0xc0/0x100
> 
> This message is from objpool.c:168:
> 
>     WARN_ON_ONCE(tail - head > pool->nr_objs);
> 
> The overrun test case is to validate the case that pre-allocated objects
> are insufficient: 8 objects are pre-allocated for each node and consumer
> thread per node tries to grab 16 objects in a row. The testing system is
> OrangePI 5+, with RK3588, a big.LITTLE SOC with 4x A76 and 4x A55. When
> disabling either all 4 big or 4 little cores, the overrun tests run well,
> and once with big and little cores mixed together, the overrun test would
> always cause an overrun loop. It's likely the memory timing differences
> of big and little cores cause this trouble. Here are the debugging data
> of objpool_try_get_slot after try_cmpxchg_release:
> 
>     objpool_pop: cpu: 4/0 0:0 head: 278/279 tail:278 last:276/278
> 
> The local copies of 'head' and 'last' were 278 and 276, and reloading of
> 'slot->head' and 'slot->last' got 279 and 278. After try_cmpxchg_release
> 'slot->head' became 'head + 1', which is correct. But what's wrong here
> is the stale value of 'last', and that stale value of 'last' finally led
> the overrun of 'head'.

Ah, good catch! So even if the ring size is enough, the head/tail update
value is not updated locally, it can cause the overrun!

> 
> Memory updating of 'last' and 'head' are performed in push() and pop()
> independently, which could be the culprit leading this out of order
> visibility of 'last' and 'head'. So for objpool_try_get_slot(), it's
> not enough only checking the condition of 'head != slot', the implicit
> condition 'last - head <= nr_objs' must also be explicitly asserted to
> guarantee 'last' is always behind 'head' before the object retrieving.

Indeed. Thanks for the investigation!

> 
> This patch will check and try reloading of 'head' and 'last' to ensure
> 'last' is behind 'head' at the time of object retrieving. Performance
> testings show the average impact is about 0.1% for X86_64 and 1.12% for
> ARM64. Here are the results:
> 
>     OS: Debian 10 X86_64, Linux 6.6rc
>     HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s
>                       1T         2T         4T         8T        16T
>     native:     49543304   99277826  199017659  399070324  795185848
>     objpool:    29909085   59865637  119692073  239750369  478005250
>     objpool+:   29879313   59230743  119609856  239067773  478509029
>                      32T        48T        64T        96T       128T
>     native:   1596927073 2390099988 2929397330 3183875848 3257546602
>     objpool:   957553042 1435814086 1680872925 2043126796 2165424198
>     objpool+:  956476281 1434491297 1666055740 2041556569 2157415622
> 
>     OS: Debian 11 AARCH64, Linux 6.6rc
>     HW: Kunpeng-920 96 cores/2 sockets/4 NUMA nodes, DDR4 2933 MT/s
>                       1T         2T         4T         8T        16T
>     native:     30890508   60399915  123111980  242257008  494002946
>     objpool:    14742531   28883047   57739948  115886644  232455421
>     objpool+:   14107220   29032998   57286084  113730493  232232850
>                      24T        32T        48T        64T        96T
>     native:    746406039 1000174750 1493236240 1998318364 2942911180
>     objpool:   349164852  467284332  702296756  934459713 1387898285
>     objpool+:  348388180  462750976  696606096  927865887 1368402195
> 

OK, looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

And let me pick it. 

> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>

BTW, this is a real bugfix, so it should have Fixes tag :)

Fixes: b4edb8d2d464 ("lib: objpool added: ring-array based lockless MPMC")

Thank you!

> ---
>  lib/objpool.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/lib/objpool.c b/lib/objpool.c
> index ce0087f64400..cfdc02420884 100644
> --- a/lib/objpool.c
> +++ b/lib/objpool.c
> @@ -201,6 +201,23 @@ static inline void *objpool_try_get_slot(struct objpool_head *pool, int cpu)
>  	while (head != READ_ONCE(slot->last)) {
>  		void *obj;
>  
> +		/*
> +		 * data visibility of 'last' and 'head' could be out of
> +		 * order since memory updating of 'last' and 'head' are
> +		 * performed in push() and pop() independently
> +		 *
> +		 * before any retrieving attempts, pop() must guarantee
> +		 * 'last' is behind 'head', that is to say, there must
> +		 * be available objects in slot, which could be ensured
> +		 * by condition 'last != head && last - head <= nr_objs'
> +		 * that is equivalent to 'last - head - 1 < nr_objs' as
> +		 * 'last' and 'head' are both unsigned int32
> +		 */
> +		if (READ_ONCE(slot->last) - head - 1 >= pool->nr_objs) {
> +			head = READ_ONCE(slot->head);
> +			continue;
> +		}
> +
>  		/* obj must be retrieved before moving forward head */
>  		obj = READ_ONCE(slot->entries[head & slot->mask]);
>  
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
