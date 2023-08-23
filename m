Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D58E785C03
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbjHWPZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjHWPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:25:25 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C5C10DC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1692804306;
        bh=jjbq8D+IoMHe6MOE+m1xxX4qnhZwXBmoLQpQwAvqkr8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xZ/ElP0z6meHzpJbXwFc/qoRZrMQCNgpGyMqNib86jrzGduchNUziRylJJzp2dT7K
         fScQBlDwiAeICDfMozAZrJHeMoWTjAenkNr8BQ+J/R9RTU64umT1/3l/xBN9TxA2qh
         hDlJggJCGdN8l4V6o+KP/9j5UpSuh5T8vfvHffGp4eWMWQiqicGzjz1FuYKm2Q+p9N
         6sGjdOhpTaOdv7EJMO88536AQjN3++b3GEyd+TRywjdl11GQ9G4eirrHACCcmfUgGj
         ZxrzmaaXR8JmAS+mnFGC4bQRNWMmOnGY95uS7Vj3OQsWWilOYyYGnsjzb6nwWoBb/B
         FdIG7yw3zBZWA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RW94y078pz1M5D;
        Wed, 23 Aug 2023 11:25:05 -0400 (EDT)
Message-ID: <04be42cb-0e8b-25f7-a34b-41b2873f39d4@efficios.com>
Date:   Wed, 23 Aug 2023 11:26:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v3 2/3] sched: Introduce cpus_share_l2c
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
References: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
 <20230822113133.643238-3-mathieu.desnoyers@efficios.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230822113133.643238-3-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/23 07:31, Mathieu Desnoyers wrote:
> Introduce cpus_share_l2c to allow querying whether two logical CPUs
> share a common L2 cache.
> 
> Considering a system like the AMD EPYC 9654 96-Core Processor, the L1
> cache has a latency of 4-5 cycles, the L2 cache has a latency of at
> least 14ns, whereas the L3 cache has a latency of 50ns [1]. Compared to
> this, I measured the RAM accesses to a latency around 120ns on my
> system [2]. So L3 really is only 2.4x faster than RAM accesses.
> Therefore, with this relatively slow access speed compared to L2, the
> scheduler will benefit from only considering CPUs sharing an L2 cache
> for the purpose of using remote runqueue locking rather than queued
> wakeups.

So I did some more benchmarking to figure out whether the reason for 
this speedup is the latency delta between L2 and L3, or is due to the 
number of hw threads contending on the rq locks.

I tried to force grouping of those "skip ttwu queue" groups by a subset 
of the LLC id, basically by taking the LLC id and adding the cpu number 
modulo N, where N is chosen based on my machine topology.

The end result is that I have similar numbers for groups of 1, 2, 4 HW 
threads (which use rq locks and skip queued ttwu within the group). 
Starting with group of size 8, the performance starts to degrade.

So I wonder: do machines with more than 4 HW threads per L2 cache exist? 
If it's the case, there we should think about grouping not only by L2 
cache, but also sub-divide this group so the number of hw threads per 
group is at most 4.

Here are my results with the hackbench test-case:

Group cpus by 16 hw threads:

Time: 49s

- group cpus by 8 hw threads: (llc_id + cpu modulo 2)

Time: 39s

- group cpus by 4 hw threads: (llc_id + cpu modulo 4)

Time: 34s

- group cpus by 2 hw threads: (llc_id + cpu modulo 8)
(expect same as L2 grouping on this machine)

Time: 34s

- group cpus by 1 hw threads: (cpu)

Time: 33s

Thanks,

Mathieu



> 
> Link: https://en.wikichip.org/wiki/amd/microarchitectures/zen_4 [1]
> Link: https://github.com/ChipsandCheese/MemoryLatencyTest [2]
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
> Cc: Aaron Lu <aaron.lu@intel.com>
> Cc: Julien Desfossez <jdesfossez@digitalocean.com>
> Cc: x86@kernel.org
> ---
> Changes since v1:
> - Fix l2c id for configurations where L2 have a single logical CPU:
>    use TOPOLOGY_CLUSTER_SYSFS to find out whether topology cluster is
>    implemented or if LLC should be used as fallback.
> 
> Changes since v2:
> - Reverse order of cpu_get_l2c_info() l2c_id and l2c_size output
>    arguments to match the caller.
> ---
>   include/linux/sched/topology.h |  6 ++++++
>   kernel/sched/core.c            |  8 ++++++++
>   kernel/sched/sched.h           |  2 ++
>   kernel/sched/topology.c        | 32 +++++++++++++++++++++++++++++---
>   4 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 7f9331f71260..c5fdee188bea 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -178,6 +178,7 @@ extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>   cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
>   void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
>   
> +bool cpus_share_l2c(int this_cpu, int that_cpu);
>   bool cpus_share_llc(int this_cpu, int that_cpu);
>   
>   typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
> @@ -227,6 +228,11 @@ partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>   {
>   }
>   
> +static inline bool cpus_share_l2c(int this_cpu, int that_cpu)
> +{
> +	return true;
> +}
> +
>   static inline bool cpus_share_llc(int this_cpu, int that_cpu)
>   {
>   	return true;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d096ce815099..11e60a69ae31 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3904,6 +3904,14 @@ void wake_up_if_idle(int cpu)
>   	rcu_read_unlock();
>   }
>   
> +bool cpus_share_l2c(int this_cpu, int that_cpu)
> +{
> +	if (this_cpu == that_cpu)
> +		return true;
> +
> +	return per_cpu(sd_l2c_id, this_cpu) == per_cpu(sd_l2c_id, that_cpu);
> +}
> +
>   bool cpus_share_llc(int this_cpu, int that_cpu)
>   {
>   	if (this_cpu == that_cpu)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 81ac605b9cd5..d93543db214c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1828,6 +1828,8 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
>   	return sd;
>   }
>   
> +DECLARE_PER_CPU(int, sd_l2c_size);
> +DECLARE_PER_CPU(int, sd_l2c_id);
>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>   DECLARE_PER_CPU(int, sd_llc_size);
>   DECLARE_PER_CPU(int, sd_llc_id);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 1ae2a0a1115a..fadb66edcf5e 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -661,8 +661,11 @@ static void destroy_sched_domains(struct sched_domain *sd)
>    *
>    * Also keep a unique ID per domain (we use the first CPU number in
>    * the cpumask of the domain), this allows us to quickly tell if
> - * two CPUs are in the same cache domain, see cpus_share_llc().
> + * two CPUs are in the same cache domain, see cpus_share_l2c() and
> + * cpus_share_llc().
>    */
> +DEFINE_PER_CPU(int, sd_l2c_size);
> +DEFINE_PER_CPU(int, sd_l2c_id);
>   DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>   DEFINE_PER_CPU(int, sd_llc_size);
>   DEFINE_PER_CPU(int, sd_llc_id);
> @@ -672,12 +675,27 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>   DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>   DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
>   
> +#ifdef TOPOLOGY_CLUSTER_SYSFS
> +static int cpu_get_l2c_info(int cpu, int *l2c_size, int *l2c_id)
> +{
> +	const struct cpumask *cluster_mask = topology_cluster_cpumask(cpu);
> +
> +	*l2c_size = cpumask_weight(cluster_mask);
> +	*l2c_id = cpumask_first(cluster_mask);
> +	return 0;
> +}
> +#else
> +static int cpu_get_l2c_info(int cpu, int *l2c_size, int *l2c_id)
> +{
> +	return -1;
> +}
> +#endif
> +
>   static void update_top_cache_domain(int cpu)
>   {
>   	struct sched_domain_shared *sds = NULL;
>   	struct sched_domain *sd;
> -	int id = cpu;
> -	int size = 1;
> +	int id = cpu, size = 1, l2c_id, l2c_size;
>   
>   	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
>   	if (sd) {
> @@ -686,6 +704,14 @@ static void update_top_cache_domain(int cpu)
>   		sds = sd->shared;
>   	}
>   
> +	if (cpu_get_l2c_info(cpu, &l2c_size, &l2c_id)) {
> +		/* Fallback on using LLC. */
> +		l2c_size = size;
> +		l2c_id = id;
> +	}
> +	per_cpu(sd_l2c_size, cpu) = l2c_size;
> +	per_cpu(sd_l2c_id, cpu) = l2c_id;
> +
>   	rcu_assign_pointer(per_cpu(sd_llc, cpu), sd);
>   	per_cpu(sd_llc_size, cpu) = size;
>   	per_cpu(sd_llc_id, cpu) = id;

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

