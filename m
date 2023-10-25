Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABEE7D6A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbjJYLzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbjJYLzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:55:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC665129;
        Wed, 25 Oct 2023 04:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I6U4cMAF+dRQvQ4QB4nnl2voztgx7oKwkMlBlghU/+4=; b=i7e/GIkirCK3eMrF1Pc/JShL2T
        jDeHz4PgvI28zCGWCfM/azocWWYqV9X6M49ANkRpZLWdKau34PCzf2Ul3K0T7X7Y6X5oD97pOu8+/
        m1EDR5zg+J8icTnYY0ikCFep4W3RfKCyLzcUv6LOq8mOrAztmpeLa3idMiIQU3W4swChebqjoGePo
        7FKb9COKfG3Z/cPUR7URWf+5tniJVYnuGLVZJ1xw4lieDsXqXD5AQawmnEs44dQ+znx6bgGiwUpxE
        Ui0t4ctoZVBEjH1HV4cVAYRWOeK03xabavg5zvMzQ4IU+8mfbuL7bHPL7nVc7wQP+EdAGMBv8yS4M
        yxvnrWbQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qvcTR-008aR7-1W; Wed, 25 Oct 2023 11:54:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id AEA6C30047C; Wed, 25 Oct 2023 13:54:56 +0200 (CEST)
Date:   Wed, 25 Oct 2023 13:54:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
        lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v3 4/6] energy_model: use a fixed reference frequency
Message-ID: <20231025115456.GD31201@noisy.programming.kicks-ass.net>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-5-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018162540.667646-5-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 06:25:38PM +0200, Vincent Guittot wrote:
> The last item of a performance domain is not always the performance point
> that has been used to compute CPU's capacity. This can lead to different
> target frequency compared with other part of the system like schedutil and
> would result in wrong energy estimation.
> 
> A new arch_scale_freq_ref() is available to return a fixed and coherent
> frequency reference that can be used when computing the CPU's frequency
> for an level of utilization. Use this function to get this reference
> frequency.
> 
> Energy model is never used without defining arch_scale_freq_ref() but
> can be compiled. Define a default arch_scale_freq_ref() returning 0
> in such case.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> ---
>  include/linux/energy_model.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index b9caa01dfac4..1b0c8490d4bd 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -204,6 +204,14 @@ struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
>  	return ps;
>  }
>  
> +#ifndef arch_scale_freq_ref
> +static __always_inline
> +unsigned int arch_scale_freq_ref(int cpu)
> +{
> +	return 0;
> +}
> +#endif

Hmm, did I not see the exact same thing in cpufreq.h two patches ago?
