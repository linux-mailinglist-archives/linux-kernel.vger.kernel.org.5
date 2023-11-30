Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967F97FE46D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjK3ACD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK3AB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:01:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940C0137
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:02:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA3CC433C8;
        Thu, 30 Nov 2023 00:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701302524;
        bh=JUfy9PkTGB3gNUUcDpux3gYV9KYIjfLf4mmkshe8UG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ktl/m0o3zGXWl4dRs8Uljd2uSDXRAKuRKGS5gjDqHVy63kq81zh+MAE7mcVDqDvyN
         ql5WfEsMjGTodqmelTMlwpRovOMGK4HL4xNysCvPXN3Rto8Rmjm4zV30i2I0FMm//A
         JVfo6LrJKKsNId8yEJvvp1Vndr6C6HkyN6k+ZcnuRL/7AjZ4hH4JwV3ZtlL/FP0jLt
         rY3PxRlSvGCxPsAW1/xLoXZpjSpT/gaUslTRpMajetq+sXz4btfjc8zDjf0t+C3yNC
         QFgnNanyBxeOyxjviG6bXU9pokZVgnQiewuRe9g/H0BAQIPtcTMqaL/gB/niItqVYh
         f+AJW9ODCZgxA==
Date:   Wed, 29 Nov 2023 16:02:02 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     Souradeep Chakrabarti <schakrabarti@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ
 affinity on HT cores
Message-ID: <20231129160202.6d66459f@kernel.org>
In-Reply-To: <20231129221739.GA20858@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
        <20231121154841.7fc019c8@kernel.org>
        <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
        <20231127100639.5f2f3d3e@kernel.org>
        <20231129221739.GA20858@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 14:17:39 -0800 Souradeep Chakrabarti wrote:
> On Mon, Nov 27, 2023 at 10:06:39AM -0800, Jakub Kicinski wrote:
> > On Mon, 27 Nov 2023 09:36:38 +0000 Souradeep Chakrabarti wrote:  
> > > easier to keep things inside the mana driver code here  
> > 
> > Easier for who? Upstream we care about consistency and maintainability
> > across all drivers.  
> I am refactoring the code and putting some of the changes in topology.h
> and in nodemask.h. I am sharing the proposed change here for those two
> files. Please let me know if they are acceptable.

Thanks, adding Yury <yury.norov@gmail.com> who's the best person 
to comment on the details...

> Added a new helper to iterate on numa nodes with cpu and start from a 
> particular node, instead of first node. This helps when we want to
> iterate from the local numa node.
> 
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 8d07116caaf1..6e4528376164 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -392,6 +392,15 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
>         for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
>  #endif /* MAX_NUMNODES */
> 
> +#if MAX_NUMNODES > 1
> +#define for_each_node_next_mask(node_start, node_next, mask)           \
> +       for ((node_next) = (node_start);                                \
> +            (node_next) < MAX_NUMNODES;                                \
> +            (node_next) = next_node((node_next), (mask)))
> +#else
> +#define for_each_node_next_mask(node_start, node_next, mask)   \
> +       for_each_node_mask(node_next, mask)
> +#endif
>  /*
>   * Bitmasks that are kept for all the nodes.
>   */
> @@ -440,6 +449,8 @@ static inline int num_node_state(enum node_states state)
> 
>  #define for_each_node_state(__node, __state) \
>         for_each_node_mask((__node), node_states[__state])
> +#define for_each_node_next_state(__node_start, __node_next, __state) \
> +       for_each_node_next_mask((__node_start), (__node_next), node_states[__state])
> 
>  #define first_online_node      first_node(node_states[N_ONLINE])
>  #define first_memory_node      first_node(node_states[N_MEMORY])
> @@ -489,7 +500,8 @@ static inline int num_node_state(enum node_states state)
> 
>  #define for_each_node_state(node, __state) \
>         for ( (node) = 0; (node) == 0; (node) = 1)
> -
> +#define for_each_node_next_state(node, next_node, _state) \
> +       for_each_node_state(node, __state)
>  #define first_online_node      0
>  #define first_memory_node      0
>  #define next_online_node(nid)  (MAX_NUMNODES)
> @@ -535,6 +547,8 @@ static inline int node_random(const nodemask_t *maskp)
> 
>  #define for_each_node(node)       for_each_node_state(node, N_POSSIBLE)
>  #define for_each_online_node(node) for_each_node_state(node, N_ONLINE)
> +#define for_each_online_node_next(node, next_node)  \
> +                                 for_each_node_next_state(node, next_node, N_ONLINE)
> 
>  /*
>   * For nodemask scratch area.
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 52f5850730b3..a06b16e5a955 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -43,6 +43,9 @@
>         for_each_online_node(node)                      \
>                 if (nr_cpus_node(node))
> 
> +#define for_each_next_node_with_cpus(node, next_node)  \
> +               for_each_online_node_next(node, next_node)      \
> +               if (nr_cpus_node(next_node))
>  int arch_update_cpu_topology(void);
> 
>  /* Conform to ACPI 2.0 SLIT distance definitions */
> 

