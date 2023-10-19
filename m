Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C620D7CF1A5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbjJSHtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjJSHtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:49:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED386112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=52ez8nSrgRe3BDw+KtrmWbkQdWoUUpNLS1BD5WCW5VY=; b=oB0C2SqM/ERV6YhikduJIrED1I
        3dNNNUf4ZYh3apNYcLw+ANjwon7ECj9BiRr4A/7ZzDrbLU+tdr988zt6h9yhnHDOZvMGKVe5ZRQ3c
        66SZtxwBk6Uxn8pVMV1+kJSU2Yjx7qPJKgnwJ9tyU4dalyVu6GM7B1ZAkeYQgxb2y620GsfAGUfbX
        hIe+UEBZVoSFF+deFTreep2ab+u83EzmGe8U+XIFz/smO8qw6WxVSxMdy6O8sa7ODViclVDENG4q+
        MRP2grYUxp+z7EJKAMm8kEq4b64lF9v6LVbmS4msinqn6lRqPJXz8QOzT2SfaC73tD567ByDEOmf7
        FnvrFs3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtNlc-009guo-2J;
        Thu, 19 Oct 2023 07:48:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62F60300392; Thu, 19 Oct 2023 09:48:28 +0200 (CEST)
Date:   Thu, 19 Oct 2023 09:48:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] powerpc/smp: Enable Asym packing for cores on
 shared processor
Message-ID: <20231019074828.GM33217@noisy.programming.kicks-ass.net>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
 <20231018163751.2423181-3-srikar@linux.vnet.ibm.com>
 <87v8b35ir3.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8b35ir3.fsf@mail.lhotse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 03:38:40PM +1100, Michael Ellerman wrote:
> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> > If there are shared processor LPARs, underlying Hypervisor can have more
> > virtual cores to handle than actual physical cores.
> >
> > Starting with Power 9, a core has 2 nearly independent thread groups.
> 
> You need to be clearer here that you're talking about "big cores", not
> SMT4 cores as seen on bare metal systems.

What is a 'big core' ? I'm thinking big.LITTLE, but I didn't think Power
went that route (yet?).. help?

> > On a shared processors LPARs, it helps to pack threads to lesser number
> > of cores so that the overall system performance and utilization
> > improves. PowerVM schedules at a core level. Hence packing to fewer
> > cores helps.
> >
> > For example: Lets says there are two 8-core Shared LPARs that are
> > actually sharing a 8 Core shared physical pool, each running 8 threads
> > each. Then Consolidating 8 threads to 4 cores on each LPAR would help
> > them to perform better. This is because each of the LPAR will get
> > 100% time to run applications and there will no switching required by
> > the Hypervisor.
> >
> > To achieve this, enable SD_ASYM_PACKING flag at CACHE, MC and DIE level.
> 
> .. when the system is running in shared processor mode and has big cores.
> 
> cheers
> 
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index 37c41297c9ce..498c2d51fc20 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -1009,9 +1009,20 @@ static int powerpc_smt_flags(void)
> >   */
> >  static int powerpc_shared_cache_flags(void)
> >  {
> > +	if (static_branch_unlikely(&powerpc_asym_packing))
> > +		return SD_SHARE_PKG_RESOURCES | SD_ASYM_PACKING;
> > +
> >  	return SD_SHARE_PKG_RESOURCES;
> >  }
> >  
> > +static int powerpc_shared_proc_flags(void)
> > +{
> > +	if (static_branch_unlikely(&powerpc_asym_packing))
> > +		return SD_ASYM_PACKING;
> > +
> > +	return 0;
> > +}

Can you leave the future reader a clue in the form of a comment around
here perhaps? Explaining *why* things are as they are etc..

> > +
> >  /*
> >   * We can't just pass cpu_l2_cache_mask() directly because
> >   * returns a non-const pointer and the compiler barfs on that.
> > @@ -1048,8 +1059,8 @@ static struct sched_domain_topology_level powerpc_topology[] = {
> >  	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
> >  #endif
> >  	{ shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
> > -	{ cpu_mc_mask, SD_INIT_NAME(MC) },
> > -	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
> > +	{ cpu_mc_mask, powerpc_shared_proc_flags, SD_INIT_NAME(MC) },
> > +	{ cpu_cpu_mask, powerpc_shared_proc_flags, SD_INIT_NAME(DIE) },
> >  	{ NULL, },
> >  };
> >  
> > @@ -1687,6 +1698,8 @@ static void __init fixup_topology(void)
> >  	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
> >  		pr_info_once("Enabling Asymmetric SMT scheduling\n");
> >  		static_branch_enable(&powerpc_asym_packing);
> > +	} else if (is_shared_processor() && has_big_cores) {
> > +		static_branch_enable(&powerpc_asym_packing);
> >  	}
> >  
> >  #ifdef CONFIG_SCHED_SMT
> > -- 
> > 2.31.1
