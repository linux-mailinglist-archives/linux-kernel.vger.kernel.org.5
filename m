Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918957CEEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjJSEde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjJSEd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:33:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2729122
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 21:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697690000;
        bh=mQ5XTmp0WZ0EPEWae5zMXHWuVc77FJWFD50HtSF9EaI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CujzwvfnVGcmNcNeKFrYx6qEi5pDAqQHqLSjd6yLRttlhWQkGZPxi07OX41KdzdwM
         JLA1ZtEvBvaabEMYPv5rZIOjMpbngy7R3ZsW6TPHg9HB9DkwCnwug0XuXf5TkItSGQ
         GdVHU5R9HGkHZuZ7aTdMd7atInPfGaSWrSvFsvRCBFjO3QQjUEqPwVnzalQVFpE9c0
         fIypi4XeC3yp6pHRx7hcOu0+2cIPcNqvK5MdSbCDEbU48pPnyQt1hvibwtnsoQGt7k
         GsOnILAHORGGJAZ6d+4FhTLTfkOUOaOUebYwN+KxUAxXPDm3RqcjUo75n9K24fSBCD
         qNEKuTArwq4Mw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9vwb6RlWz4xZS;
        Thu, 19 Oct 2023 15:33:19 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] powerpc/smp: Cache CPU has Asymmetric SMP
In-Reply-To: <20231018163751.2423181-2-srikar@linux.vnet.ibm.com>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
 <20231018163751.2423181-2-srikar@linux.vnet.ibm.com>
Date:   Thu, 19 Oct 2023 15:33:16 +1100
Message-ID: <87y1fz5j03.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> Currently cpu feature flag is checked whenever powerpc_smt_flags gets
> called. This is an unnecessary overhead. CPU_FTR_ASYM_SMT is set based
> on the processor and all processors will either have this set or will
> have it unset.

The cpu_has_feature() test is implemented with a static key.

So AFAICS this is just replacing one static key with another?

I see that you use the new static key in subsequent patches. But
couldn't those just use the existing cpu feature test?

Anyway I'd be interested to see how the generated code differs
before/after this.

cheers

> Hence only check for the feature flag once and cache it to be used
> subsequently. This commit will help avoid a branch in powerpc_smt_flags
>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
> Changelog:
> v1->v2: Using static keys instead of a variable.
> Using pr_info_once instead of printk
>
>  arch/powerpc/kernel/smp.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 5826f5108a12..37c41297c9ce 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -988,18 +988,16 @@ static int __init init_thread_group_cache_map(int cpu, int cache_property)
>  }
>  
>  static bool shared_caches;
> +DEFINE_STATIC_KEY_FALSE(powerpc_asym_packing);
>  
>  #ifdef CONFIG_SCHED_SMT
>  /* cpumask of CPUs with asymmetric SMT dependency */
>  static int powerpc_smt_flags(void)
>  {
> -	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
> +	if (static_branch_unlikely(&powerpc_asym_packing))
> +		return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES | SD_ASYM_PACKING;
>  
> -	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
> -		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
> -		flags |= SD_ASYM_PACKING;
> -	}
> -	return flags;
> +	return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
>  }
>  #endif
>  
> @@ -1686,6 +1684,11 @@ static void __init fixup_topology(void)
>  {
>  	int i;
>  
> +	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
> +		pr_info_once("Enabling Asymmetric SMT scheduling\n");
> +		static_branch_enable(&powerpc_asym_packing);
> +	}
> +
>  #ifdef CONFIG_SCHED_SMT
>  	if (has_big_cores) {
>  		pr_info("Big cores detected but using small core scheduling\n");
> -- 
> 2.31.1
