Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F67A49A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbjIRMaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241867AbjIRMBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:01:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90B7C1B8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:00:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FC311FB;
        Mon, 18 Sep 2023 05:00:55 -0700 (PDT)
Received: from [10.34.100.121] (e126645.nice.arm.com [10.34.100.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F9E33F67D;
        Mon, 18 Sep 2023 05:00:15 -0700 (PDT)
Message-ID: <39cb0a07-0a73-00cb-50a0-731eb68d4ce8@arm.com>
Date:   Mon, 18 Sep 2023 14:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Content-Language: en-US
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     dietmar.eggemann@arm.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
References: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
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

On 9/13/23 13:48, Shrikanth Hegde wrote:
> sysctl_sched_energy_aware is available for the admin to disable/enable
> energy aware scheduling(EAS). EAS is enabled only if few conditions are
> met by the platform. They are, asymmetric CPU capacity, no SMT,
> valid cpufreq policy, frequency invariant load tracking. It is possible
> platform when booting may not have EAS capability, but can do that after.

I think:
"A platform may not boot without EAS capability, but could gain such capability
at runtime (and vice versa)."

> For example, changing/registering the cpufreq policy.
> 
> At present, though platform doesn't support EAS, this sysctl is still
> present and it ends up calling rebuild of sched domain on write to 1 and
> NOP when writing to 0. That is confusing and un-necessary.

Maybe:
"Platforms without EAS capability still have this sysctl. Its effects
are unnecessary on such platforms (rebuilding sched-domains) and its presence
can be confusing."

> 
> Desired behaviour can be, have the sysctl only when the platform can do
> EAS. i.e when platform becomes capable enable the sysctl and when it can't
> remove the sysctl. On Supported platform using this sysctl, admin should be
> able to enable/disable EAS.

Maybe just:
"Dynamically hide/show sysctl_sched_energy_aware by re-evaluating EAS capability
conditions."

> 
> Update the sysctl guide as well.
> 
> Different Scenarios:
> Scenario 1: System while booting has EAS capability.
> Expected: sysctl will be present and admin can enable/disable EAS by writing
> 1 or 0 respectively. This operation shouldn't remove the sysctl specially when
> disabling as sysctl would be needed to enable it later.
> Scenario 2: System becomes capable of EAS later
> Expected: At boot, sysctl will not be present. Once eas is enabled by passing
> all the checks, perf domains will be built and sysctl will be enabled. Any
> further change to sysctl should be treated same as Scenario 1.
> Scenario 3: system becomes not capable of EAS.
> Expected: Since EAS is going to be disabled now, remove the sysctl in this
> scenario. If it becomes capable of EAS later again, that would be Scenario 2.

I don't think detailing all the possible scenarios above is necessary here.

> 
> v2->v3:
> Chen Yu and Pierre Gondois both pointed out that if platform becomes
> capable of EAS later, this patch was not allowing that to happen.
> Addressed that by using a variable to indicate the sysctl change
> and re-worded the commit message with desired behaviour,
> v1->v2:
> Chen Yu had pointed out that this will not destroy the perf domains on
> architectures where EAS is supported by changing the sysctl.
> [v1] Link: https://lore.kernel.org/lkml/20230829065040.920629-1-sshegde@linux.vnet.ibm.com/
> [v2] Link: https://lore.kernel.org/lkml/20230901065249.137242-1-sshegde@linux.vnet.ibm.com/
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> ---
>   Documentation/admin-guide/sysctl/kernel.rst |  3 +-
>   kernel/sched/topology.c                     | 49 +++++++++++++++++----
>   2 files changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 3800fab1619b..455e12f1331b 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1134,7 +1134,8 @@ automatically on platforms where it can run (that is,
>   platforms with asymmetric CPU topologies and having an Energy
>   Model available). If your platform happens to meet the
>   requirements for EAS but you do not want to use it, change
> -this value to 0.
> +this value to 0. If platform doesn't support EAS at this moment,
> +this would be removed.

Maybe:
"This file is only advertised if your platform meets EAS requirements."

(feel free to deny the rewording suggestions)

> 
>   task_delayacct
>   ===============
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 05a5bc678c08..57df938d5ec0 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -208,9 +208,11 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
> 
>   #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
>   DEFINE_STATIC_KEY_FALSE(sched_energy_present);
> -static unsigned int sysctl_sched_energy_aware = 1;
> +static unsigned int sysctl_sched_energy_aware;
> +static struct ctl_table_header *sysctl_eas_header;
>   static DEFINE_MUTEX(sched_energy_mutex);
>   static bool sched_energy_update;
> +static bool is_sysctl_eas_changing;
> 
>   void rebuild_sched_domains_energy(void)
>   {
> @@ -226,6 +228,7 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>   		void *buffer, size_t *lenp, loff_t *ppos)
>   {
>   	int ret, state;
> +	int prev_val = sysctl_sched_energy_aware;
> 
>   	if (write && !capable(CAP_SYS_ADMIN))
>   		return -EPERM;
> @@ -233,8 +236,13 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>   	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>   	if (!ret && write) {
>   		state = static_branch_unlikely(&sched_energy_present);
> -		if (state != sysctl_sched_energy_aware)
> +		if (state != sysctl_sched_energy_aware && prev_val != sysctl_sched_energy_aware) {
> +			is_sysctl_eas_changing = true;
> +			if (sysctl_sched_energy_aware && !state)
> +				pr_warn("Attempt to build energy domains when EAS is disabled\n");
>   			rebuild_sched_domains_energy();
> +			is_sysctl_eas_changing = false;
> +		}
>   	}
> 
>   	return ret;
> @@ -255,7 +263,14 @@ static struct ctl_table sched_energy_aware_sysctls[] = {
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
> @@ -336,10 +351,29 @@ static void sched_energy_set(bool has_eas)
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
> +		if (sysctl_eas_header && !is_sysctl_eas_changing) {
> +			unregister_sysctl_table(sysctl_eas_header);
> +			sysctl_eas_header = NULL;
> +			sysctl_sched_energy_aware = 0;
> +		}
> +#endif
>   	} else if (has_eas && !static_branch_unlikely(&sched_energy_present)) {
>   		if (sched_debug())
>   			pr_info("%s: starting EAS\n", __func__);
>   		static_branch_enable_cpuslocked(&sched_energy_present);
> +#ifdef CONFIG_PROC_SYSCTL
> +		if (!sysctl_eas_header) {
> +			sysctl_eas_header = register_sysctl("kernel", sched_energy_aware_sysctls);
> +			sysctl_sched_energy_aware = 1;
> +		}
> +#endif

With a kernel which doesn't have a running cpufreq driver, the following scenario fails
for me:
# insmod [cpufreq driver].ko
# cat /proc/sys/kernel/sched_energy_aware
1
# echo 0 > /proc/sys/kernel/sched_energy_aware
# rmmod cpufreq driver].ko
# cat /proc/sys/kernel/sched_energy_aware
0

sched_energy_aware should have been removed at that point. In sched_energy_set(),
sysctl_eas_header sysctl should be unregistered if we go from the state where:
- EAS is disabled, but possible
to the state:
- EAS is disabled, but not possible

I think the following logic should somehow be extracted in a separate function,
named sched_energy_aware_possible() for instance (or other as you appreciate).
The logic should be checked to register/unregister the sysctl.
---
if (sched_smt_active() || !per_cpu(sd_asym_cpucapacity, cpu) ||
     !arch_scale_freq_invariant())
---

Also it seemed there was a miss in rebuilding the sched domains when
a cpufreq driver is removed, but the issue described above is still appearing
with the following patch applied:
https://lore.kernel.org/all/20230918112937.493352-1-pierre.gondois@arm.com/

Regards,
Pierre

>   	}
>   }
> 
> @@ -380,15 +414,14 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
>   	struct cpufreq_policy *policy;
>   	struct cpufreq_governor *gov;
> 
> -	if (!sysctl_sched_energy_aware)
> +	if (!sysctl_sched_energy_aware && is_sysctl_eas_changing)
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
