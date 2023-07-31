Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08D77697C5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjGaNga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjGaNg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:36:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628751716
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uvm9aLTRK8GWX6uAp8orX4z7h5TArbDw35kof7K1dJA=; b=OcJKi1YjcH08GPr31EREJcclrx
        F0gm0AAYrjDqGlasJNi3A2Yk/gXMmG/2OWfePZn86b7otTIpud8DOTuRNdOL2ZPm/3J9qik982qWB
        9ggSB7opIb0tI0WCtbhOGYNwasDDq/o60KshPmczi9uayg3AQZx8dHsvcM/A+duUFZCoz8U9e2mCp
        l27FBv6w3Ip/FukZ1VPr4FC5zumzOHUlj6VOJz4PXRqqcHInl8/vRXpt9ynZwSijzW9AvF6Qb3HII
        9OSSxb+tCpsf5TrD/bFhEWM6vrvgMwmWSMdU74/EyKKy0AmpkoYlUjDr/UNOxnpY7k6k+VpAXQvPC
        aibm8Vdg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQT47-00CjW7-3C;
        Mon, 31 Jul 2023 13:36:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 338C83001DD;
        Mon, 31 Jul 2023 15:36:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B412C203EA053; Mon, 31 Jul 2023 15:36:02 +0200 (CEST)
Date:   Mon, 31 Jul 2023 15:36:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bing Huang <huangbing775@126.com>
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, brauner@kernel.org,
        bristot@redhat.com, bsegall@google.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH] sched/topology: Covered all cpus of same node in
 asymmetric node setups
Message-ID: <20230731133602.GI29590@hirez.programming.kicks-ass.net>
References: <20230729222203.5601-1-huangbing775@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729222203.5601-1-huangbing775@126.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 06:22:03AM +0800, Bing Huang wrote:
> in asymmetric node setups, if one cpu'sd spans is empty in some depth,
> others in same node do

Sorry, what?!?

> Signed-off-by: Bing Huang <huangbing@kylinos.cn>
> ---
>  kernel/sched/topology.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 7cfcfe5d27b9..8c5372ad7694 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1045,8 +1045,10 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
>  		 * Domains should always include the CPU they're built on, so
>  		 * check that.
>  		 */
> -		if (!cpumask_test_cpu(i, sched_domain_span(sibling)))
> +		if (!cpumask_test_cpu(i, sched_domain_span(sibling))) {
> +			cpumask_or(covered, covered, cpumask_of_node(cpu_to_node(i)));
>  			continue;
> +		}
>  
>  		/*
>  		 * Usually we build sched_group by sibling's child sched_domain
> -- 
> 2.25.1
> 
