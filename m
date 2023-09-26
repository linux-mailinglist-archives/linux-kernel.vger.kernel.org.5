Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F76D7AF68D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjIZXH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjIZXF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:05:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97A4C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 15:07:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE0891FB;
        Tue, 26 Sep 2023 14:29:55 -0700 (PDT)
Received: from [192.168.178.45] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 242463F59C;
        Tue, 26 Sep 2023 14:29:14 -0700 (PDT)
Message-ID: <caab4d10-3ed6-faa7-5435-3086f3878537@arm.com>
Date:   Tue, 26 Sep 2023 23:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] sched/topology: change behaviour of sysctl
 sched_energy_aware based on the platform
Content-Language: en-US
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org,
        pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, pauld@redhat.com
References: <20230926100046.405188-1-sshegde@linux.vnet.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230926100046.405188-1-sshegde@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2023 12:00, Shrikanth Hegde wrote:
> sysctl sched_energy_aware is available for the admin to disable/enable
> energy aware scheduling(EAS). EAS is enabled only if few conditions are
> met by the platform. They are, asymmetric CPU capacity, no SMT,
> valid cpufreq policy, frequency invariant load tracking etc. A platform may

s/valid cpufreq policy/Schedutil CPUfreq governor

+ EM complexity < EM_MAX_COMPLEXITY

> boot without EAS capability, but could gain such capability at runtime
> For example, changing/registering the cpufreq policy.

s/cpufreq policy/CPUfreq governor to Schedutil

> At present, though platform doesn't support EAS, this sysctl returns 1
> and it ends up calling rebuild of sched domain on write to 1 and

sched domains are not rebuild in this case, i.e.
partition_sched_domains_locked() does not call detach_destroy_domains()
or build_sched_domains(). Only build_perf_domains() is called which
bails out if !sysctl_sched_energy_aware or one of the EAS conditions is
not true.

> NOP when writing to 0. That is confusing and un-necessary.
> 
> Desired behavior would be to, have this sysctl to enable/disable the EAS
> on supported platform. On Non supported platform write to the sysctl
> would return not supported error and read of the sysctl would return
> empty. So
> sched_energy_aware returns empty - EAS is not possible at this moment
> sched_energy_aware returns 0 - EAS is supported but disabled by admin.
> sched_energy_aware returns 1 - EAS is supported and enabled.
> User can find out the reason why EAS is not possible by checking
> info messages.

This will include EAS capable platforms which have at least one EAS
condition false during startup, e.g. using a Performance CPUfreq governor:

root@juno:~# cat /proc/sys/kernel/sched_energy_aware

root@juno:~# echo 1 > /proc/sys/kernel/sched_energy_aware
echo: write error: Operation not supported

log messages:
...
[  160.902138] rd 0-5: Checking EAS, schedutil is mandatory
...
[  324.467341] rd 0-5: Checking EAS, schedutil is mandatory
...

root@juno:~# echo schedutil >
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor
root@juno:~# echo schedutil >
/sys/devices/system/cpu/cpufreq/policy1/scaling_governor

log messages:
...
[  414.195073] root_domain 0-5: pd1:{ cpus=1-2 nr_pstate=5 } pd0:{
cpus=0,3-5 nr_pstate=5 }
[  414.210877] sched_energy_set: starting EAS
...

root@juno:~# cat /proc/sys/kernel/sched_energy_aware
1

root@juno:~# echo 0 > /proc/sys/kernel/sched_energy_aware

log messages:
...
[  414.195073] root_domain 0-5: pd1:{ cpus=1-2 nr_pstate=5 } pd0:{
cpus=0,3-5 nr_pstate=5 }
[  414.210877] sched_energy_set: starting EAS
...
[  544.482690] rd 0-5: Disabling EAS
[  544.493729] sched_energy_set: stopping EAS

> sched_is_eas_possible return if the platform can do EAS at this moment.

sched_is_eas_possible() returns

> It takes most of the cases into account except one where EM complexity is
> too high as the code was bit tricky to separate that.

I remember that there was a patch from Pierre to get rid of the EM
complexity check:

https://lkml.kernel.org/r/20221121094336.3250917-1-pierre.gondois@arm.com

If this makes this patch easier, maybe both patches can go in as a
patch-set together?

Although I don't see that not checking EM complexity in
sched_energy_aware_handler() -> sched_is_eas_possible() is an issue.

> 
> v3->v4:
> valentin suggested it would be better to consider simpler approach that
> was mentioned in v2. It is a standard approach to keep the knob visible
> but change how read and write are handled. Did that and Refactored the
> code to use a common function in build_perf_domains and in sysctl handler.
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
> [v3] Link: https://lore.kernel.org/lkml/20230913114807.665094-1-sshegde@linux.vnet.ibm.com/
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>

[...]

> @@ -231,6 +289,14 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>  		return -EPERM;
> 
>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +	if (!sched_is_eas_possible(cpu_active_mask)) {

This is using `cpu_active_mask` so EAS can only be disabled system-wide.

So I experimented with an exclusive cpuset setup creating a symmetric
(cs1) and an asymmetric (cs2) island on my Juno with its cpumask = [l B
B l l l] (l - little CPU, B - Big CPU).

root@juno:~# cd /sys/fs/cgroup/cpuset
root@juno:/sys/fs/cgroup/cpuset# mkdir cs1
root@juno:/sys/fs/cgroup/cpuset# echo 1 > cs1/cpuset.cpu_exclusive
root@juno:/sys/fs/cgroup/cpuset# echo 0 > cs1/cpuset.mems
root@juno:/sys/fs/cgroup/cpuset# echo 4,5 > cs1/cpuset.cpus
root@juno:/sys/fs/cgroup/cpuset# mkdir cs2
root@juno:/sys/fs/cgroup/cpuset# echo 1 > cs2/cpuset.cpu_exclusive
root@juno:/sys/fs/cgroup/cpuset# echo 0 > cs2/cpuset.mems
root@juno:/sys/fs/cgroup/cpuset# echo 0-3 > cs2/cpuset.cpus
root@juno:/sys/fs/cgroup/cpuset# echo 0 > cpuset.sched_load_balance

[ 3021.761278] root_domain 0-3: pd1:{ cpus=1-2 nr_pstate=5 } pd0:{
cpus=0,3-5 nr_pstate=5 }

root@juno:~# echo 0 > /proc/sys/kernel/sched_energy_aware

log messages:
...
[ 3143.538583] rd 4-5: Disabling EAS
[ 3143.549569] rd 0-3: Disabling EAS
[ 3143.560681] sched_energy_set: stopping EAS
...

root@juno:~# echo 1 > /proc/sys/kernel/sched_energy_aware

log messages:
...
[ 3223.277521] root_domain 0-3: pd1:{ cpus=1-2 nr_pstate=5 } pd0:{
cpus=0,3-5 nr_pstate=5 }
[ 3223.293409] sched_energy_set: starting EAS

Seems still to work correctly.

[...]

> @@ -458,6 +487,8 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
>  	return !!pd;
> 
>  free:
> +	if (sched_debug())
> +		pr_warn("rd %*pbl: Disabling EAS", cpumask_pr_args(cpu_map));

Shouldn't this be used in condition `if (!sysctl_sched_energy_aware)`?
Otherwise we have 2 warnings when the other conditions which leads to
`goto free` aren't met.

[...]
