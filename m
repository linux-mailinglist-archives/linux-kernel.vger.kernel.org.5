Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9857576442F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjG0DMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjG0DMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:12:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F8E2719
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 20:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690427524; x=1721963524;
  h=message-id:subject:from:to:cc:in-reply-to:references:
   content-transfer-encoding:mime-version:date;
  bh=gUXQh0L7to9XJTvlI2sRmh/KmnYhINJXjMcWDfXjFfY=;
  b=iQXsW0dao+PQ1hmnIUz5lBUD40Wh9B4mlJEMb64TRZU5D3cqAuXrRNbE
   UvBAi6mPgH+PR4NaX3QAb/JG/1BYQlJy5EHc/oFHYDn+WzWhosZAiWe9V
   c0VSNcZ0kJqiZ1gJIG+0Ef+Wy28kPzqcXY2Q1YjFqWC8S+pdnrTWo4G2c
   psgGOoB34/At2fCDY8ngf8Xt95GfYSDyo2Ret2ix0gz6kPpGcfH3K7uQr
   w8yJIkKdvBfckcxhFgOE1/VaK8r+n+Pd1zDAGLLPQJgP+v0lsG+1rmog/
   Ct/ImtCl2y1bLaj1+o22HIbAhdcSfzMCCIp6RKjplzwR+vbZwpSWSlnMZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="370865574"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="370865574"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 20:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="676944342"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="676944342"
Received: from misbashe-mobl.gar.corp.intel.com (HELO [10.214.146.193]) ([10.214.146.193])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 20:11:52 -0700
Message-ID: <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, peterz@infradead.org
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        hdanton@sina.com, ionela.voinescu@arm.com, juri.lelli@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
        naveen.n.rao@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com,
        rostedt@goodmis.org, srikar@linux.vnet.ibm.com,
        srinivas.pandruvada@linux.intel.com, v-songbaohua@oppo.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, x86@kernel.org,
        yangyicong@hisilicon.com, yu.c.chen@intel.com
In-Reply-To: <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
         <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Wed, 26 Jul 2023 20:11:18 -0700
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-17 at 20:28 +0530, Shrikanth Hegde wrote:
> From: Tim Chen <tim.c.chen@linux.intel.com>
>=20
> For SMT4, any group with more than 2 tasks will be marked as
> group_smt_balance. Retain the behaviour of group_has_spare by marking
> the busiest group as the group which has the least number of idle_cpus.
>=20
> Also, handle rounding effect of adding (ncores_local + ncores_busy)
> when the local is fully idle and busy group has more than 2 tasks.
> Local group should try to pull at least 1 task in this case.
>=20
> Originally-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 932e7b78894a..9502013abe33 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9532,7 +9532,7 @@ static inline long sibling_imbalance(struct lb_env =
*env,
>  	imbalance /=3D ncores_local + ncores_busiest;
>=20
>  	/* Take advantage of resource in an empty sched group */
> -	if (imbalance =3D=3D 0 && local->sum_nr_running =3D=3D 0 &&
> +	if (imbalance <=3D 1 && local->sum_nr_running =3D=3D 0 &&
>  	    busiest->sum_nr_running > 1)
>  		imbalance =3D 2;
>=20
> @@ -9720,6 +9720,17 @@ static bool update_sd_pick_busiest(struct lb_env *=
env,
>  		break;
>=20
>  	case group_smt_balance:
> +		/* no idle cpus on both groups handled by group_fully_busy below */
> +		if (sgs->idle_cpus !=3D 0 || busiest->idle_cpus !=3D 0) {
> +			if (sgs->idle_cpus > busiest->idle_cpus)
> +				return false;
> +			if (sgs->idle_cpus < busiest->idle_cpus)
> +				return true;
> +			if (sgs->sum_nr_running <=3D busiest->sum_nr_running)
> +				return false;
> +		}
> +		break;
> +
>  	case group_fully_busy:
>  		/*
>  		 * Select the fully busy group with highest avg_load. In

Thanks for the fix up patch.

Acked-by: Tim Chen <tim.c.chen@linux.intel.com>
