Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985C28094DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjLGVpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjLGVpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:45:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC08171C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:45:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93726C433C8;
        Thu,  7 Dec 2023 21:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701985522;
        bh=ppvsN0Qt+Uj98booU8p5G/LMRKy2P70PPnbZOdvnNYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DQmrBGkzgUUj51ar9SYzQ6MY/lJnPuG1Yj7d1qgXr8YSv6a/ba+AdM//x/WErP82k
         /0QF+auhJvpNO5DVM94hy7HLKAOigUhCZroj8Xa9Hd52t6+Cp/kvqv76GQyfZauvpy
         /0J461uc4YRpog/5jurWKIvWNyllI49vaP2RZGLw=
Date:   Thu, 7 Dec 2023 13:45:21 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 3/6] lib/group_cpus: optimize inner loop in
 grp_spread_init_one()
Message-Id: <20231207134521.c921cb0bb1ab7487d78aeb07@linux-foundation.org>
In-Reply-To: <20231207203900.859776-4-yury.norov@gmail.com>
References: <20231207203900.859776-1-yury.norov@gmail.com>
        <20231207203900.859776-4-yury.norov@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Dec 2023 12:38:57 -0800 Yury Norov <yury.norov@gmail.com> wrote:

> The loop starts from the beginning every time we switch to the next
> sibling mask. This is the Schlemiel the Painter's style of coding
> because we know for sure that nmsk is clear up to current CPU, and we
> can just continue from the next CPU.
> 
> Also, we can do it nicer if leverage the dedicated for_each() iterator.
> 
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -30,13 +30,13 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>  
>  		/* If the cpu has siblings, use them first */
>  		siblmsk = topology_sibling_cpumask(cpu);
> -		for (sibl = -1; cpus_per_grp > 0; ) {
> -			sibl = cpumask_next(sibl, siblmsk);
> -			if (sibl >= nr_cpu_ids)
> -				break;

I assume this test goes away because the iterator takes care of it?

> +		sibl = cpu + 1;
> +
> +		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
>  			__cpumask_clear_cpu(sibl, nmsk);
>  			__cpumask_set_cpu(sibl, irqmsk);
> -			cpus_per_grp--;
> +			if (cpus_per_grp-- == 0)
> +				return;
>  		}
>  	}
>  }

