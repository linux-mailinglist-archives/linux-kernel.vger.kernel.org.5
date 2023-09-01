Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A6078FEAF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344182AbjIAOAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIAOAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:00:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024DE10EC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23EA7CE23A0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 13:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5931C433CA;
        Fri,  1 Sep 2023 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693576794;
        bh=yAwUPzOrWH4shkflWMSqld45TrqZ1FzcaWesFYjjXnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/sGK5KomfdYJHa7siMkKhrPtuNkRH2/f0YhyeCK6a6xz49C5fJR1qfzFMDHS2WOG
         tUCbN0EyT89U1z3ecSft1cQFZpEpOiW+3oZ+WRK9OehXa00zlkKJVbIWTfAnMaeHB/
         qRRSQwgkrpU41mcz14rpG2u3qQTAeX4oFLDrfrzn0tMBs1PDe+0sFE1FPFp42mE2vL
         4VMky/evuWA6pqNsFXnxZqKiBNoGSFz6MAlhR5HKijc5aaL14L+7x8/oUIb2VkA8qX
         OWxc4YQuCoV+XroMTtmyutqsyzwQGTI2C2SmmUzLld12/2caF+Daw5h0lI9IGXI0Q7
         lJa+OpgHI3XOQ==
Date:   Fri, 1 Sep 2023 15:59:32 +0200
From:   Simon Horman <horms@kernel.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH net-next 3/3] sock: Throttle pressure-aware sockets
 under pressure
Message-ID: <20230901135932.GH140739@kernel.org>
References: <20230901062141.51972-1-wuyun.abel@bytedance.com>
 <20230901062141.51972-4-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901062141.51972-4-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 02:21:28PM +0800, Abel Wu wrote:
> A socket is pressure-aware when its protocol has pressure defined, that
> is sk_has_memory_pressure(sk) != NULL, e.g. TCP. These protocols might
> want to limit the usage of socket memory depending on both the state of
> global & memcg pressure through sk_under_memory_pressure(sk).
> 
> While for allocation, memcg pressure will be simply ignored when usage
> is under global limit (sysctl_mem[0]). This behavior has different impacts
> on different cgroup modes. In cgroupv2 socket and other purposes share a
> same memory limit, thus allowing sockmem to burst under memcg reclaiming
> pressure could lead to longer stall, sometimes even OOM. While cgroupv1
> has no such worries.
> 
> As a cloud service provider, we encountered a problem in our production
> environment during the transition from cgroup v1 to v2 (partly due to the
> heavy taxes of accounting socket memory in v1). Say one workload behaves
> fine in cgroupv1 with memcg limit configured to 10GB memory and another
> 1GB tcpmem, but will suck (or even be OOM-killed) in v2 with 11GB memory
> due to burst memory usage on socket, since there is no specific limit for
> socket memory in cgroupv2 and relies largely on workloads doing traffic
> control themselves.
> 
> It's rational for the workloads to build some traffic control to better
> utilize the resources they bought, but from kernel's point of view it's
> also reasonable to suppress the allocation of socket memory once there is
> a shortage of free memory, given that performance degradation is better
> than failure.
> 
> As per the above, this patch aims to be more conservative on allocation
> for the pressure-aware sockets under global and/or memcg pressure. While
> OTOH throttling on incoming traffic could hurt latency badly possibly
> due to SACKed segs get dropped from the OFO queue. See a related commit
> 720ca52bcef22 ("net-memcg: avoid stalls when under memory pressure").
> This patch preserves this decision by throttling RX allocation only at
> critical pressure level when it hardly makes sense to continue receive
> data.
> 
> No functional change intended for pressure-unaware protocols.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

...

> @@ -3087,8 +3100,20 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
>  	if (sk_has_memory_pressure(sk)) {
>  		u64 alloc;
>  
> -		if (!sk_under_memory_pressure(sk))
> +		/* Be more conservative if the socket's memcg (or its
> +		 * parents) is under reclaim pressure, try to possibly
> +		 * avoid further memstall.
> +		 */
> +		if (under_memcg_pressure)
> +			goto suppress_allocation;
> +
> +		if (!sk_under_global_memory_pressure(sk))
>  			return 1;
> +
> +		/* Trying to be fair among all the sockets of same
> +		 * protocal under global memory pressure, by allowing

nit: checkpatch.pl --codespell says, protocal -> protocol

> +		 * the ones that under average usage to raise.
> +		 */
>  		alloc = sk_sockets_allocated_read_positive(sk);
>  		if (sk_prot_mem_limits(sk, 2) > alloc *
>  		    sk_mem_pages(sk->sk_wmem_queued +
> -- 
> 2.37.3
> 
> 
