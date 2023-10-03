Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC107B6557
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbjJCJVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239588AbjJCJVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:21:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AFBDC9;
        Tue,  3 Oct 2023 02:20:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FB58C15;
        Tue,  3 Oct 2023 02:21:34 -0700 (PDT)
Received: from [10.34.100.116] (e126645.nice.arm.com [10.34.100.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FB313F5A1;
        Tue,  3 Oct 2023 02:20:53 -0700 (PDT)
Message-ID: <69092c13-604c-74ec-b325-658527d069f4@arm.com>
Date:   Tue, 3 Oct 2023 11:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 2/2] sched/topology: change behaviour of sysctl
 sched_energy_aware based on the platform
Content-Language: en-US
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        qperret@google.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, pauld@redhat.com, lukasz.luba@arm.com,
        linux-doc@vger.kernel.org, bsegall@google.com, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        vschneid@redhat.com
References: <20230929155209.667764-1-sshegde@linux.vnet.ibm.com>
 <20230929155209.667764-3-sshegde@linux.vnet.ibm.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230929155209.667764-3-sshegde@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shrikanth,
Some NITs about the commit message:

On 9/29/23 17:52, Shrikanth Hegde wrote:
> sysctl sched_energy_aware is available for the admin to disable/enable
> energy aware scheduling(EAS). EAS is enabled only if few conditions are
> met by the platform. They are, asymmetric CPU capacity, no SMT,
> schedutil CPUfreq governor, frequency invariant load tracking etc.
> A platform may boot without EAS capability, but could gain such
> capability at runtime For example, changing/registering the CPUfreq

Missing dot I think: 'runtime. For example,'

> governor to schedutil.
> 
> At present, though platform doesn't support EAS, this sysctl returns 1
> and it ends up calling build_perf_domains on write to 1 and
> NOP when writing to 0. That is confusing and un-necessary.

I'm not sure I fully understand the sentence:
- it sounds that the user is writing a value to either 1/0
   (I think the user is writing 1/0 to the sysctl)
- aren't the sched domain rebuilt even when writing 0 to the sysctl ?
   I'm not sure I understand to what the NOP is referring to exactly.

What about:
Platforms without EAS capability currently advertise this sysctl.
Its effects (i.e. rebuilding sched-domains) is unnecessary on
such platforms and its presence can be confusing.

> 
> Desired behavior would be to, have this sysctl to enable/disable the EAS

Unnecessary comma I think

> on supported platform. On Non supported platform write to the sysctl

Non supported  -> non-supported

> would return not supported error and read of the sysctl would return
> empty. So> sched_energy_aware returns empty - EAS is not possible at this moment
> This will include EAS capable platforms which have at least one EAS
> condition false during startup, e.g. using a Performance CPUfreq governor

Just a remark, using the performance governor is not exactly a condition
disabling EAS, it is more 'not using the schedutil CPUfreq governor'

> sched_energy_aware returns 0 - EAS is supported but disabled by admin.
> sched_energy_aware returns 1 - EAS is supported and enabled.
> 
> User can find out the reason why EAS is not possible by checking
> info messages. sched_is_eas_possible returns true if the platform
> can do EAS at this moment.
> 
> Depends on [PATCH v5 1/2] sched/topology: Remove EM_MAX_COMPLEXITY limit
> to be applied first.

I think it's implied as the 2 patches are sent together.

Otherwise:
Tested-by: Pierre Gondois <pierre.gondois@arm.com>

> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> ---
>   Documentation/admin-guide/sysctl/kernel.rst |   3 +-
>   kernel/sched/topology.c                     | 112 +++++++++++++-------
>   2 files changed, 76 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index cf33de56da27..d89ac2bd8dc4 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1182,7 +1182,8 @@ automatically on platforms where it can run (that is,
>   platforms with asymmetric CPU topologies and having an Energy
>   Model available). If your platform happens to meet the
>   requirements for EAS but you do not want to use it, change
> -this value to 0.
> +this value to 0. On Non-EAS platforms, write operation fails and
> +read doesn't return anything.
> 
>   task_delayacct
>   ===============
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index e0b9920e7e3e..a654d0186ac0 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -212,6 +212,70 @@ static unsigned int sysctl_sched_energy_aware = 1;
>   static DEFINE_MUTEX(sched_energy_mutex);
>   static bool sched_energy_update;
> 
> +extern struct cpufreq_governor schedutil_gov;
> +static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
> +{
> +	bool any_asym_capacity = false;
> +	struct cpufreq_policy *policy;
> +	struct cpufreq_governor *gov;
> +	int i;
> +
> +	/* EAS is enabled for asymmetric CPU capacity topologies. */
> +	for_each_cpu(i, cpu_mask) {
> +		if (per_cpu(sd_asym_cpucapacity, i)) {
> +			any_asym_capacity = true;
> +			break;
> +		}
> +	}
> +	if (!any_asym_capacity) {
> +		if (sched_debug()) {
> +			pr_info("rd %*pbl: Checking EAS, CPUs do not have asymmetric capacities\n",
> +				cpumask_pr_args(cpu_mask));
> +		}
> +		return false;
> +	}
> +
> +	/* EAS definitely does *not* handle SMT */
> +	if (sched_smt_active()) {
> +		if (sched_debug()) {
> +			pr_info("rd %*pbl: Checking EAS, SMT is not supported\n",
> +				cpumask_pr_args(cpu_mask));
> +		}
> +		return false;
> +	}
> +
> +	if (!arch_scale_freq_invariant()) {
> +		if (sched_debug()) {
> +			pr_info("rd %*pbl: Checking EAS: frequency-invariant load tracking not yet supported",
> +				cpumask_pr_args(cpu_mask));
> +		}
> +		return false;
> +	}
> +
> +	/* Do not attempt EAS if schedutil is not being used. */
> +	for_each_cpu(i, cpu_mask) {
> +		policy = cpufreq_cpu_get(i);
> +		if (!policy) {
> +			if (sched_debug()) {
> +				pr_info("rd %*pbl: Checking EAS, cpufreq policy not set for CPU: %d",
> +					cpumask_pr_args(cpu_mask), i);
> +			}
> +			return false;
> +		}
> +		gov = policy->governor;
> +		cpufreq_cpu_put(policy);
> +		if (gov != &schedutil_gov) {
> +			if (sched_debug()) {
> +				pr_info("rd %*pbl: Checking EAS, schedutil is mandatory\n",
> +					cpumask_pr_args(cpu_mask));
> +			}
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
>   void rebuild_sched_domains_energy(void)
>   {
>   	mutex_lock(&sched_energy_mutex);
> @@ -231,6 +295,15 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>   		return -EPERM;
> 
>   	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +	if (!sched_is_eas_possible(cpu_active_mask)) {
> +		if (write) {
> +			return -EOPNOTSUPP;
> +		} else {
> +			*lenp = 0;
> +			return 0;
> +		}
> +	}
> +
>   	if (!ret && write) {
>   		state = static_branch_unlikely(&sched_energy_present);
>   		if (state != sysctl_sched_energy_aware)
> @@ -351,61 +424,24 @@ static void sched_energy_set(bool has_eas)
>    *    4. schedutil is driving the frequency of all CPUs of the rd;
>    *    5. frequency invariance support is present;
>    */
> -extern struct cpufreq_governor schedutil_gov;
>   static bool build_perf_domains(const struct cpumask *cpu_map)
>   {
>   	int i;
>   	struct perf_domain *pd = NULL, *tmp;
>   	int cpu = cpumask_first(cpu_map);
>   	struct root_domain *rd = cpu_rq(cpu)->rd;
> -	struct cpufreq_policy *policy;
> -	struct cpufreq_governor *gov;
> 
>   	if (!sysctl_sched_energy_aware)
>   		goto free;
> 
> -	/* EAS is enabled for asymmetric CPU capacity topologies. */
> -	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
> -		if (sched_debug()) {
> -			pr_info("rd %*pbl: CPUs do not have asymmetric capacities\n",
> -					cpumask_pr_args(cpu_map));
> -		}
> -		goto free;
> -	}
> -
> -	/* EAS definitely does *not* handle SMT */
> -	if (sched_smt_active()) {
> -		pr_warn("rd %*pbl: Disabling EAS, SMT is not supported\n",
> -			cpumask_pr_args(cpu_map));
> -		goto free;
> -	}
> -
> -	if (!arch_scale_freq_invariant()) {
> -		if (sched_debug()) {
> -			pr_warn("rd %*pbl: Disabling EAS: frequency-invariant load tracking not yet supported",
> -				cpumask_pr_args(cpu_map));
> -		}
> +	if (!sched_is_eas_possible(cpu_map))
>   		goto free;
> -	}
> 
>   	for_each_cpu(i, cpu_map) {
>   		/* Skip already covered CPUs. */
>   		if (find_pd(pd, i))
>   			continue;
> 
> -		/* Do not attempt EAS if schedutil is not being used. */
> -		policy = cpufreq_cpu_get(i);
> -		if (!policy)
> -			goto free;
> -		gov = policy->governor;
> -		cpufreq_cpu_put(policy);
> -		if (gov != &schedutil_gov) {
> -			if (rd->pd)
> -				pr_warn("rd %*pbl: Disabling EAS, schedutil is mandatory\n",
> -						cpumask_pr_args(cpu_map));
> -			goto free;
> -		}
> -
>   		/* Create the new pd and add it to the local list. */
>   		tmp = pd_init(i);
>   		if (!tmp)
> --
> 2.39.3
> 
