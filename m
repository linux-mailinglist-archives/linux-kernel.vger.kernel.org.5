Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B397179C308
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbjILCfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbjILCfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:35:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6928E1048B8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694474885; x=1726010885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bqP0Il+KP9ktuev/OAY3TtppS1gH4Re3PyzXmCZnwLA=;
  b=htfKpe1hiICmwyU1np7QsEBEJOwMYBZxDQ5OAlMR9QInAOdu5e1yW2X3
   syoGZBij4Bt6EqvMO44PODS0SBpoyhMpSps8FM3u3H/7bUQbGeEDSITAP
   bmrM5Jg2LzJ2KIjaV4WHpqUoIKqos6aTb8w9jgRX+WFqT743axbbHtVkk
   Wntedk08YK0LTam0hYEPiuohGRVtETMFXnhiqX82KPiB2eveBxKhJRaND
   MRNSwMF8eW060eyuTh49rYOMl4pLDpciuXV5J/ffoDqVW8HdoTA5wfNlv
   nBdk4R4pZsbcEgNJeAih8aAfCsC34lCWrMewQSZe+0wlo+KwHNka/1rDZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="444663321"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="444663321"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 16:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="772769867"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="772769867"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 16:14:15 -0700
Date:   Mon, 11 Sep 2023 16:16:24 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ben Segall <bsegall@google.com>,
        Caleb Callaway <caleb.callaway@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sched: Restore the SD_ASYM_PACKING flag in the DIE
 domain
Message-ID: <20230911231624.GA16338@ranerica-svr.sc.intel.com>
References: <20230815035747.11529-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815035747.11529-1-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 08:57:47PM -0700, Ricardo Neri wrote:
> Commit 8f2d6c41e5a6 ("x86/sched: Rewrite topology setup") dropped the
> SD_ASYM_PACKING flag in the DIE domain added in commit 044f0e27dec6
> ("x86/sched: Add the SD_ASYM_PACKING flag to the die domain of hybrid
> processors"). Restore it on hybrid processors.
> 
> The die-level domain does not depend on any build configuration and now
> x86_sched_itmt_flags() is always needed. Remove the build dependency on
> CONFIG_SCHED_[SMT|CLUSTER|MC].
> 
> Cc: Ben Segall <bsegall@google.com>
> Cc: Caleb Callaway <caleb.callaway@intel.com>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: 8f2d6c41e5a6 ("x86/sched: Rewrite topology setup")
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: Caleb Callaway <caleb.callaway@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  arch/x86/kernel/smpboot.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index d7667a29acf3..944008c72754 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -579,7 +579,6 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>  }
>  
>  
> -#if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_CLUSTER) || defined(CONFIG_SCHED_MC)
>  static inline int x86_sched_itmt_flags(void)
>  {
>  	return sysctl_sched_itmt_enabled ? SD_ASYM_PACKING : 0;
> @@ -603,7 +602,12 @@ static int x86_cluster_flags(void)
>  	return cpu_cluster_flags() | x86_sched_itmt_flags();
>  }
>  #endif
> -#endif
> +
> +static int x86_die_flags(void)
> +{
> +	return cpu_feature_enabled(X86_FEATURE_HYBRID_CPU) ?
> +	       x86_sched_itmt_flags() : 0;
> +}
>  
>  /*
>   * Set if a package/die has multiple NUMA nodes inside.
> @@ -640,7 +644,7 @@ static void __init build_sched_topology(void)
>  	 */
>  	if (!x86_has_numa_in_package) {
>  		x86_topology[i++] = (struct sched_domain_topology_level){
> -			cpu_cpu_mask, SD_INIT_NAME(DIE)
> +			cpu_cpu_mask, x86_die_flags, SD_INIT_NAME(DIE)
>  		};
>  	}
>  

Hi, just checking if there are any comments on this patch?
