Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3934792EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243032AbjIETbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbjIETbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:31:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81F7CF6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693942258; x=1725478258;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=zUOk16uSP2T6YbhQY+oXHAFeCMv4lYDusKdYAsDqpag=;
  b=cryPvaqDbRi+sm1oWFdBX+f4zo9JBx4ZaiWzIt7wHGmF5kq/SHQZ9gTT
   7dz+IgSFBxMcjxJ+9p3akJIBcNLkkKoyFYgQ0TPokS5UoPJfHYh2M5oU3
   a1CibGL4lSWKmpx9dYpF+uxiPiX51FncrtIF9Rp3C0TYRwOVFKcKuPUea
   OTRufEbiYJL6dbf14cde/ZUOQkMnURSv8stk8gqGCo5GAMMGfLUvoBhpy
   6ohYIRQ3OwV2czJ/2oWGzThzJVlkCjm9rTFtObcbkROirXN5P8lNCDbDC
   SUM/dfBW0RrajzISIRtI6V9Gm2Ur0eUo/sepxugqCav6ZRex3De1znM4i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="379604255"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="379604255"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 12:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="717976621"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="717976621"
Received: from dpdesmon-mobl.amr.corp.intel.com (HELO [10.209.18.208]) ([10.209.18.208])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 12:30:51 -0700
Message-ID: <925bbda25461035fdec1bebf8487f84f9a3852a7.camel@linux.intel.com>
Subject: Re: [PATCH] sched/fair: optimize should_we_balance for higher SMT
 systems
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org, yu.c.chen@intel.com,
        ricardo.neri-calderon@linux.intel.com, iamjoonsoo.kim@lge.com,
        juri.lelli@redhat.com, rocking@linux.alibaba.com,
        joshdon@google.com
Date:   Tue, 05 Sep 2023 12:30:51 -0700
In-Reply-To: <20230902081204.232218-1-sshegde@linux.vnet.ibm.com>
References: <20230902081204.232218-1-sshegde@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-09-02 at 13:42 +0530, Shrikanth Hegde wrote:
>=20
>=20
> Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole co=
re for load balance")
> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0b7445cd5af9..6e31923293bb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6619,6 +6619,7 @@ static void dequeue_task_fair(struct rq *rq, struct=
 task_struct *p, int flags)
>  /* Working cpumask for: load_balance, load_balance_newidle. */
>  static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
>  static DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
> +static DEFINE_PER_CPU(cpumask_var_t, should_we_balance_tmpmask);
>=20
>  #ifdef CONFIG_NO_HZ_COMMON
>=20
> @@ -10913,6 +10914,7 @@ static int active_load_balance_cpu_stop(void *dat=
a);
>=20
>  static int should_we_balance(struct lb_env *env)
>  {
> +	struct cpumask *swb_cpus =3D this_cpu_cpumask_var_ptr(should_we_balance=
_tmpmask);
>  	struct sched_group *sg =3D env->sd->groups;
>  	int cpu, idle_smt =3D -1;
>=20
> @@ -10936,8 +10938,9 @@ static int should_we_balance(struct lb_env *env)
>  		return 1;
>  	}
>=20
> +	cpumask_copy(swb_cpus, group_balance_mask(sg));
>  	/* Try to find first idle CPU */
> -	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
> +	for_each_cpu_and(cpu, swb_cpus, env->cpus) {
>  		if (!idle_cpu(cpu))
>  			continue;
>=20
> @@ -10949,6 +10952,14 @@ static int should_we_balance(struct lb_env *env)
>  		if (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && !is_core_idle(cpu)) {
>  			if (idle_smt =3D=3D -1)
>  				idle_smt =3D cpu;
> +			/*
> +			 * If the core is not idle, and first SMT sibling which is
> +			 * idle has been found, then its not needed to check other
> +			 * SMT siblings for idleness
> +			 */
> +#ifdef CONFIG_SCHED_SMT
> +			cpumask_andnot(swb_cpus, swb_cpus, cpu_smt_mask(cpu));
> +#endif
>  			continue;
>  		}
>=20
> @@ -12914,6 +12925,8 @@ __init void init_sched_fair_class(void)
>  	for_each_possible_cpu(i) {
>  		zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i), GFP_KERNEL, cp=
u_to_node(i));
>  		zalloc_cpumask_var_node(&per_cpu(select_rq_mask,    i), GFP_KERNEL, cp=
u_to_node(i));
> +		zalloc_cpumask_var_node(&per_cpu(should_we_balance_tmpmask, i),
> +					GFP_KERNEL, cpu_to_node(i));

Shrianth,

Wonder if we can avoid allocating the=20
should_we_balance_tmpmask for SMT2 case to save memory
for system with large number of cores.

The new mask and logic I think is only needed for more than 2 threads in a =
core.

Tim
>=20
>  #ifdef CONFIG_CFS_BANDWIDTH
>  		INIT_CSD(&cpu_rq(i)->cfsb_csd, __cfsb_csd_unthrottle, cpu_rq(i));
> --
> 2.31.1
>=20

