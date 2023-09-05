Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E344E7926D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348100AbjIEQS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354746AbjIEOD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:03:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45F7A1A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:03:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C071C11FB;
        Tue,  5 Sep 2023 07:04:02 -0700 (PDT)
Received: from [10.34.100.102] (e126645.nice.arm.com [10.34.100.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBD2C3F67D;
        Tue,  5 Sep 2023 07:03:22 -0700 (PDT)
Message-ID: <b81e3d8f-88e3-e7b5-0dbc-78268193db7e@arm.com>
Date:   Tue, 5 Sep 2023 16:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Content-Language: en-US
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        peterz@infradead.org, mingo@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org, yu.c.chen@intel.com
References: <20230901065249.137242-1-sshegde@linux.vnet.ibm.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230901065249.137242-1-sshegde@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shrikanth,
I tried the patch (on a platform using the cppc_cpufreq driver). The platform
normally has EAS enabled, but the patch removed the sched_energy_aware sysctl.
It seemed the following happened (in the below order):

1. sched_energy_aware_sysctl_init()
Doesn't set sysctl_sched_energy_aware as cpufreq_freq_invariance isn't set
and arch_scale_freq_invariant() returns false

2. cpufreq_register_driver()
Sets cpufreq_freq_invariance during cpufreq initialization sched_energy_set()

3. sched_energy_set()
Is called with has_eas=0 since build_perf_domains() doesn't see the platform
as EAS compatible. Indeed sysctl_sched_energy_aware=0.
So with sysctl_sched_energy_aware=0 and has_eas=0, sched_energy_aware sysctl
is not enabled even though EAS should be possible.


On 9/1/23 08:52, Shrikanth Hegde wrote:
> Currently sysctl_sched_energy_aware doesn't alter the said behaviour on
> some of the architectures. IIUC its meant to either force rebuild the
> perf domains or cleanup the perf domains by echoing 1 or 0 respectively.

There is a definition of the sysctl at:
Documentation/admin-guide/sysctl/kernel.rst::sched_energy_aware

Also a personal comment about the commit message (FWIW), I think it should
be a bit more impersonal and factual. The commit message seems to describe
the code rather than the desired behaviour.

> 
> perf domains are not built when there is SMT, or when there is no
> Asymmetric CPU topologies or when there is no frequency invariance.
> Since such cases EAS is not set and perf domains are not built. By
> changing the values of sysctl_sched_energy_aware, its not possible to
> force build the perf domains. Hence remove this sysctl on such platforms
> that dont support it. Some of the settings can be changed later
> such as smt_active by offlining the CPU's, In those cases if
> build_perf_domains returns true, re-enable the sysctl.
> 
> Anytime, when sysctl_sched_energy_aware is changed sched_energy_update
> is set when building the perf domains. Making use of that to find out if
> the change is happening by sysctl or dynamic system change.
> 
> Taking different cases:
> Case1. system while booting has EAS capability, sysctl will be set 1. Hence
> perf domains will be built if needed. On changing the sysctl to 0, since
> sched_energy_update is true, perf domains would be freed and sysctl will
> not be removed. later sysctl is changed to 1, enabling the perf domains
> rebuild again. Since sysctl is already there, it will skip register.
> 
> Case2. System while booting doesn't have EAS Capability. Later after system
> change it becomes capable of EAS. sched_energy_update is false. Though
> sysctl is 0, will go ahead and try to enable eas. This is the current
> behaviour. if has_eas  is true, then sysctl will be registered. After
> that any sysctl change is same as Case1.
> 
> Case3. System becomes not capable of EAS due to system change. Here since
> sched_energy_update is false, build_perf_domains return has_eas as false
> due to one of the checks and Since this is dynamic change remove the sysctl.
> Any further change which enables EAS is Case2
> 
> Note: This hasn't been tested on platform which supports EAS. If the
> change can be verified on that it would really help. This has been
> tested on power10 which doesn't support EAS. sysctl_sched_energy_aware
> is removed with patch.
> 
> changes since v1:
> Chen Yu had pointed out that this will not destroy the perf domains on
> architectures where EAS is supported by changing the sysctl. This patch
> addresses that.
> [v1] Link: https://lore.kernel.org/lkml/20230829065040.920629-1-sshegde@linux.vnet.ibm.com/#t
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> ---
>   kernel/sched/topology.c | 45 +++++++++++++++++++++++++++++++++--------
>   1 file changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 05a5bc678c08..4d16269ac21a 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -208,7 +208,8 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
> 
>   #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
>   DEFINE_STATIC_KEY_FALSE(sched_energy_present);
> -static unsigned int sysctl_sched_energy_aware = 1;
> +static unsigned int sysctl_sched_energy_aware;
> +static struct ctl_table_header *sysctl_eas_header;

The variables around the presence/absence of EAS are:
- sched_energy_present:
EAS is up and running

- sysctl_sched_energy_aware:
The user wants to use EAS (or not). Doesn't mean EAS can run on the
platform.

- sched_energy_set/partition_sched_domains_locked's "has_eas":
Local variable. Represent whether EAS can run on the platform.

IMO it would be simpler to (un)register sched_energy_aware sysctl
in partition_sched_domains_locked(), based on the value of "has_eas".
This would allow to let all the logic as it is right now, inside
build_perf_domains(), and then advertise sched_energy_aware sysctl
if EAS can run on the platform.
sched_energy_aware_sysctl_init() would be deleted then.


>   static DEFINE_MUTEX(sched_energy_mutex);
>   static bool sched_energy_update;
> 
> @@ -226,6 +227,7 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>   		void *buffer, size_t *lenp, loff_t *ppos)
>   {
>   	int ret, state;
> +	int prev_val = sysctl_sched_energy_aware;
> 
>   	if (write && !capable(CAP_SYS_ADMIN))
>   		return -EPERM;
> @@ -233,8 +235,11 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>   	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>   	if (!ret && write) {
>   		state = static_branch_unlikely(&sched_energy_present);
> -		if (state != sysctl_sched_energy_aware)
> +		if (state != sysctl_sched_energy_aware && prev_val != sysctl_sched_energy_aware) {
> +			if (sysctl_sched_energy_aware && !state)
> +				pr_warn("Attempt to build energy domains when EAS is disabled\n");
>   			rebuild_sched_domains_energy();
> +		}
>   	}
> 
>   	return ret;
> @@ -255,7 +260,14 @@ static struct ctl_table sched_energy_aware_sysctls[] = {
> 
>   static int __init sched_energy_aware_sysctl_init(void)
>   {
> -	register_sysctl_init("kernel", sched_energy_aware_sysctls);
> +	int cpu = cpumask_first(cpu_active_mask);
> +
> +	if (sched_smt_active() || !per_cpu(sd_asym_cpucapacity, cpu) ||
> +	    !arch_scale_freq_invariant())
> +		return 0;
> +
> +	sysctl_eas_header = register_sysctl("kernel", sched_energy_aware_sysctls);
> +	sysctl_sched_energy_aware = 1;
>   	return 0;
>   }
> 
> @@ -336,10 +348,28 @@ static void sched_energy_set(bool has_eas)
>   		if (sched_debug())
>   			pr_info("%s: stopping EAS\n", __func__);
>   		static_branch_disable_cpuslocked(&sched_energy_present);
> +#ifdef CONFIG_PROC_SYSCTL
> +		/*
> +		 * if the architecture supports EAS and forcefully
> +		 * perf domains are destroyed, there should be a sysctl
> +		 * to enable it later. If this was due to dynamic system
> +		 * change such as SMT<->NON_SMT then remove sysctl.
> +		 */
> +		if (sysctl_eas_header && !sched_energy_update) {
> +			unregister_sysctl_table(sysctl_eas_header);
> +			sysctl_eas_header = NULL;
> +		}
> +#endif
> +		sysctl_sched_energy_aware = 0;
>   	} else if (has_eas && !static_branch_unlikely(&sched_energy_present)) {
>   		if (sched_debug())
>   			pr_info("%s: starting EAS\n", __func__);
>   		static_branch_enable_cpuslocked(&sched_energy_present);
> +#ifdef CONFIG_PROC_SYSCTL
> +		if (!sysctl_eas_header)
> +			sysctl_eas_header = register_sysctl("kernel", sched_energy_aware_sysctls);
> +#endif
> +		sysctl_sched_energy_aware = 1;
>   	}
>   }
> 
> @@ -380,15 +410,14 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
>   	struct cpufreq_policy *policy;
>   	struct cpufreq_governor *gov;
> 
> -	if (!sysctl_sched_energy_aware)
> +	if (!sysctl_sched_energy_aware && sched_energy_update)
>   		goto free;
> 
>   	/* EAS is enabled for asymmetric CPU capacity topologies. */
>   	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
> -		if (sched_debug()) {
> -			pr_info("rd %*pbl: CPUs do not have asymmetric capacities\n",
> -					cpumask_pr_args(cpu_map));
> -		}
> +		if (sched_debug())
> +			pr_info("rd %*pbl: Disabling EAS,  CPUs do not have asymmetric capacities\n",
> +				cpumask_pr_args(cpu_map));
>   		goto free;
>   	}
> 
> --
> 2.31.1
> 
> 

Regards,
Pierre
