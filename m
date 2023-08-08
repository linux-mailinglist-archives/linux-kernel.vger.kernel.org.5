Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49A3773FC8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjHHQww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjHHQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:52:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED5F4C16C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RTlZ1zVsINh+tbpFVrmHDFwtRXh33HPJxOrLYnYfxQo=; b=IMAiU47iGRk6sZInYRIiSez5UA
        PCwBNk60giuyJZTfHK3CfKfRBqhFOhftryUADZnOVQuoytDwze4XRH4GyKnJ3c/vKHSS17K65Ikd6
        KXQauWL6MxEiQYE/fhFO9Tm1negR9K2shtqHdsIiQy6YebvYJ/2pohFz3PTUikKNzU04idLiqryEk
        h9f5i/wzIGMH5qS7OtvIkGDxzbQuZu3WDk2YMRHgpHw7gEAbhqHWhOQqcONKs0BqXLrVhW8scD7Jw
        piiOCHvXmGCAGK3KGK1dtRFh/BmFL2Vcx6S8cRJXgrzkdNnGREyPXyP6oqadodG3PgzLOuJbOv5lV
        xdEuT0Vg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTK4s-004ime-19;
        Tue, 08 Aug 2023 10:36:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3EE830026C;
        Tue,  8 Aug 2023 12:36:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 979AA203D9A2A; Tue,  8 Aug 2023 12:36:37 +0200 (CEST)
Date:   Tue, 8 Aug 2023 12:36:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Stultz <jstultz@google.com>, Jason@zx2c4.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Li Zhijian <zhijianx.li@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com
Subject: Re: [RFC][PATCH 1/3] test-ww_mutex: Use prng instead of rng to avoid
 hangs at bootup
Message-ID: <20230808103637.GA212435@hirez.programming.kicks-ass.net>
References: <20230808062658.391595-1-jstultz@google.com>
 <20230808062658.391595-2-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808062658.391595-2-jstultz@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 06:26:41AM +0000, John Stultz wrote:
> Booting w/ qemu without kvm, I noticed we'd sometimes seem to get
> stuck in get_random_u32_below(). This seems potentially to be
> entropy exhaustion (with the test module linked statically, it
> runs pretty early in the bootup).
> 
> I'm not 100% sure on this, but this patch switches to use the
> prng instead since we don't need true randomness, just mixed up
> orders for testing ww_mutex lock acquisitions.
> 
> With this patch, I no longer see hangs in get_random_u32_below()
> 
> Feedback would be appreciated!

Jason, I thought part of the 'recent' random rework was avoiding the
exhaustion problem, could you please give an opinion on the below?

> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  kernel/locking/test-ww_mutex.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index 93cca6e69860..9bceba65858a 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -9,7 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/kthread.h>
>  #include <linux/module.h>
> -#include <linux/random.h>
> +#include <linux/prandom.h>
>  #include <linux/slab.h>
>  #include <linux/ww_mutex.h>
>  
> @@ -386,6 +386,19 @@ struct stress {
>  	int nlocks;
>  };
>  
> +struct rnd_state rng;
> +DEFINE_SPINLOCK(rng_lock);
> +
> +static inline u32 prandom_u32_below(u32 ceil)
> +{
> +	u32 ret;
> +
> +	spin_lock(&rng_lock);
> +	ret = prandom_u32_state(&rng) % ceil;
> +	spin_unlock(&rng_lock);
> +	return ret;
> +}
> +
>  static int *get_random_order(int count)
>  {
>  	int *order;
> @@ -399,7 +412,7 @@ static int *get_random_order(int count)
>  		order[n] = n;
>  
>  	for (n = count - 1; n > 1; n--) {
> -		r = get_random_u32_below(n + 1);
> +		r = prandom_u32_below(n + 1);
>  		if (r != n) {
>  			tmp = order[n];
>  			order[n] = order[r];
> @@ -625,6 +638,8 @@ static int __init test_ww_mutex_init(void)
>  
>  	printk(KERN_INFO "Beginning ww mutex selftests\n");
>  
> +	prandom_seed_state(&rng, get_random_u64());
> +
>  	wq = alloc_workqueue("test-ww_mutex", WQ_UNBOUND, 0);
>  	if (!wq)
>  		return -ENOMEM;
> -- 
> 2.41.0.640.ga95def55d0-goog
> 
