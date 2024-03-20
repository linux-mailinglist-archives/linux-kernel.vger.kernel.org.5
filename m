Return-Path: <linux-kernel+bounces-109184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AC08815DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B227B1C20CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BFE664AA;
	Wed, 20 Mar 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ROBbQv6z"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009BAA47;
	Wed, 20 Mar 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953029; cv=fail; b=CQ2fMPjx3Zs63bBjcl3VEoQqKC3Rki5DKJA+7Y4wXMtILkD6MzWgSmXUujH3NWoAUeqCssyf2FuJLTCWXX6p2OMfomWBeCSiUjdbloViNdizqwIr/yGRExKQHPyQUl2XQdAWC7aiCmiexUC92+T0AqECDCUhzGUefGcW4mMTt9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953029; c=relaxed/simple;
	bh=Tgir4pd911L2V5q9ori7gpQgUMfU9PeYqJ895PuWnZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UnWjhu44LWY1MdH5HVyef4/DMaY0ZyiIFKClH+Iv+DX0V2U20xLxAaEoUcZy4myt1LfFcURAQrSPgO3Uv10sQlMQ1fAcxnsmxIVZiMYziyMBnlLrfqQqcY0ewRd6YPz93Ly347wi5SpTlgc8XNPNrlg+GDl+SOwNCLGBtepdbwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ROBbQv6z; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EreNgqGfblnWIFRvcX8cQ6ZVOvFqrgF63HyK9Hi7V+v90reuiY5VWQ403NYJFr7l8uuaWR2hlsyBXWk3JOQHVZ6wIHgAgyoNYe33M24jaya3YDpw4Q62fdn5Nkqc1kp3oKqVvpbK02BQc2cYZShXTFaf8J0I4am8obc2gmDRxOGJDC5Jhqsvf4b/ryrw/HD10qzdPPMLVk+qdGzvXAQys8w0blXos+BiixxS2cvw9TL2Zu6y/pgIrjohOuNjogk0FTA+SHCwLxxcP7waNq8e2f/hFLhAvtDFYchyhr0huQDzR7zQbjD7NGkSZV4YzVJpN7GeXjH+OQlU+vninwfUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmamfHl4apt1+DbmwrqkWOPbAKuqaWERTJsfWD7QyUw=;
 b=hdfK7QwL5AS8GKHn/jy5zlA/5oqzbbTDz4aY6Mb8aL/SlAPKXL0fF/M9kfCr8503siENsAyMFBrgNhi5extIpbRFqPbUaau/FnkdNVidaMP/RDS4tdFCtkg1BV7wT86udTzIUJFeV92qMFdTt5Ch/eiG65zwnEadajqA8Gpfx/qiEyxtCeXDCitV2YgHtW+0c96f16yzxnuqH8SrAwd72YGp9ro1StdRCXtTR2gF/46crjjYIHeG5qpTCa12p/6Nq+xT9KHUN77UxSOEzZd+c7r7DzCwOsjfj5dc5h7YGlkvtoLfW9zxOClmNKQoxV8QdAbltPN6bkb7gpidTZE3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmamfHl4apt1+DbmwrqkWOPbAKuqaWERTJsfWD7QyUw=;
 b=ROBbQv6ztODUqE9aGN0PxKiFJjkp2oVNMdCglk34D/xlioPD5UYNTOUXpf07DA2g1dJhq0WkFoyitR7+IQ3sCNGszig+s3wxG1T4HM2KI3eIaOnx81tuEJ4SiY1qyaButrfUNVzbPVj3M2kYO9lZizmvCMwLPlBp5m/sbA/BVcIracbzbTbW5xk9X/2ulJwhojKHMMsM6Uj9qB4F7nnFz4rpMNu6AXU2MvXIMHKK40SB97JOko7QqG8TErq6wSWzV8G+z/FbIcBT5tawjTTUVaHBXlPmlRSb/QBWLEXbFmR2LP84CN/jTC1Zb1YNsqUDftn5mvFnMtgmO4zCSi+ZLA==
Received: from CH0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:610:b1::20)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Wed, 20 Mar
 2024 16:43:43 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::5f) by CH0PR13CA0015.outlook.office365.com
 (2603:10b6:610:b1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11 via Frontend
 Transport; Wed, 20 Mar 2024 16:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 16:43:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Mar
 2024 09:43:25 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 20 Mar
 2024 09:43:21 -0700
Message-ID: <370c98a5-30f7-917e-8fe8-10d2c48e4222@nvidia.com>
Date: Wed, 20 Mar 2024 22:13:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/3] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
To: Beata Michalska <beata.michalska@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <ionela.voinescu@arm.com>
CC: <sudeep.holla@arm.com>, <will@kernel.org>, <catalin.marinas@arm.com>,
	<vincent.guittot@linaro.org>, <yang@os.amperecomputing.com>,
	<lihuisong@huawei.com>, <vanshikonda@os.amperecomputing.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-tegra
	<linux-tegra@vger.kernel.org>
References: <20240312083431.3239989-1-beata.michalska@arm.com>
 <20240312083431.3239989-3-beata.michalska@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20240312083431.3239989-3-beata.michalska@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c38791d-d87f-43a5-b64e-08dc48fce75c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7ugF7JNNsfWbcbf8WTF1l2P3xobjacp/xqTYctu9nefsAk+RLd/YUmtuFDyTyCLd5+P1YPSSXbikoKN12YqqgwMIRs7HXUj1EbkafeDbE0TIJ30ogUREUS0vEAk1kGJ9AfrNx8qq+AVNcZ0sOpkyAHAmPOhev7D7xFMiQPZAsbJbv0p4hTif/FzDi2ajqtb8RERIciw4O0HewL2zQeXlQDrceRmLGL8xOYdFUDVhsPDyenR1pLfXbAtcklXT+9fvs6KTcRQdvSYn80nLADyfGiZiykciqvebZGXVXFCong5xm86LrK/F1XPIJa9GE0jkxjwuQUaT9lhwg+5tqUekJ1NWGTbonqqQN0igWMzfTzQbp0mM2Je4DdOItJXk+hKYMrAFVlbwjL4w+539U/g3jTnnl8oPfHrKlftvP8xxKihSnvxRqXJUUNmM7irMJBWO4dgGgdjtN1ZTG5h9kgy/BNA6yhJwZVLpBlmJQi5NOZdG4zxpqN6KG5cFWZzQGC1gqZyEVsFZbBrxjMyWTNYojAhZ9PVmZVNeMA51oACCsaulHjd8fwhVcBm7veJXZOLpU7z00zpyHDzU9NntGuHQn8GDgG8LYqSOSsGlUUR34NAfnO+8YcAwelEV9Xl2fylBk3J70V1GU1GuBI9vLqdIPP21/Tiw0d21T/c7UPmmJ2q3R5jyR5oPSBAtSpBgR9CcjIIzlFtdvC+HmDgfaarIHC7RjG+TX3LPzhTI8BoxQtyR+YYf2jToQiZJpZqLJZaJ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 16:43:42.8776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c38791d-d87f-43a5-b64e-08dc48fce75c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995



On 12/03/24 14:04, Beata Michalska wrote:
> External email: Use caution opening links or attachments
> 
> 
> With the Frequency Invariance Engine (FIE) being already wired up with
> sched tick and making use of relevant (core counter and constant
> counter) AMU counters, getting the current frequency for a given CPU
> on supported platforms can be achieved by utilizing the frequency scale
> factor which reflects an average CPU frequency for the last tick period
> length.
> 
> The solution is partially based on APERF/MPERF implementation of
> arch_freq_get_on_cpu.
> 
> Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>   arch/arm64/kernel/topology.c | 103 +++++++++++++++++++++++++++++++----
>   1 file changed, 92 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 1a2c72f3e7f8..42cb19c31719 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -17,6 +17,8 @@
>   #include <linux/cpufreq.h>
>   #include <linux/init.h>
>   #include <linux/percpu.h>
> +#include <linux/sched/isolation.h>
> +#include <linux/seqlock_types.h>
> 
>   #include <asm/cpu.h>
>   #include <asm/cputype.h>
> @@ -88,18 +90,31 @@ int __init parse_acpi_topology(void)
>    * initialized.
>    */
>   static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
> -static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
> -static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
>   static cpumask_var_t amu_fie_cpus;
> 
> +struct amu_cntr_sample {
> +       u64             arch_const_cycles_prev;
> +       u64             arch_core_cycles_prev;
> +       unsigned long   last_update;
> +       seqcount_t      seq;
> +};
> +
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples) = {
> +       .seq = SEQCNT_ZERO(cpu_amu_samples.seq)
> +};
> +
>   void update_freq_counters_refs(void)
>   {
> -       this_cpu_write(arch_core_cycles_prev, read_corecnt());
> -       this_cpu_write(arch_const_cycles_prev, read_constcnt());
> +       struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
> +
> +       amu_sample->arch_core_cycles_prev = read_corecnt();
> +       amu_sample->arch_const_cycles_prev = read_constcnt();
>   }
> 
>   static inline bool freq_counters_valid(int cpu)
>   {
> +       struct amu_cntr_sample *amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> +
>          if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
>                  return false;
> 
> @@ -108,8 +123,8 @@ static inline bool freq_counters_valid(int cpu)
>                  return false;
>          }
> 
> -       if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
> -                    !per_cpu(arch_core_cycles_prev, cpu))) {
> +       if (unlikely(!amu_sample->arch_const_cycles_prev ||
> +                    !amu_sample->arch_core_cycles_prev)) {
>                  pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
>                  return false;
>          }
> @@ -152,20 +167,27 @@ void freq_inv_set_max_ratio(int cpu, u64 max_rate)
> 
>   static void amu_scale_freq_tick(void)
>   {
> +       struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
>          u64 prev_core_cnt, prev_const_cnt;
>          u64 core_cnt, const_cnt, scale;
> 
> -       prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
> -       prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
> +       prev_const_cnt = amu_sample->arch_const_cycles_prev;
> +       prev_core_cnt = amu_sample->arch_core_cycles_prev;
> +
> +       write_seqcount_begin(&amu_sample->seq);
> 
>          update_freq_counters_refs();
> 
> -       const_cnt = this_cpu_read(arch_const_cycles_prev);
> -       core_cnt = this_cpu_read(arch_core_cycles_prev);
> +       const_cnt = amu_sample->arch_const_cycles_prev;
> +       core_cnt = amu_sample->arch_core_cycles_prev;
> 
> +       /*
> +        * This should not happen unless the AMUs have been reset and the
> +        * counter values have not been resroted - unlikely
> +        */
>          if (unlikely(core_cnt <= prev_core_cnt ||
>                       const_cnt <= prev_const_cnt))
> -               return;
> +               goto leave;
> 
>          /*
>           *          /\core    arch_max_freq_scale
> @@ -182,6 +204,10 @@ static void amu_scale_freq_tick(void)
> 
>          scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
>          this_cpu_write(arch_freq_scale, (unsigned long)scale);
> +
> +       amu_sample->last_update = jiffies;
> +leave:
> +       write_seqcount_end(&amu_sample->seq);
>   }
> 
>   static struct scale_freq_data amu_sfd = {
> @@ -189,6 +215,61 @@ static struct scale_freq_data amu_sfd = {
>          .set_freq_scale = amu_scale_freq_tick,
>   };
> 
> +#define AMU_SAMPLE_EXP_MS      20
> +
> +unsigned int arch_freq_get_on_cpu(int cpu)
> +{
> +       struct amu_cntr_sample *amu_sample;
> +       unsigned long last_update;
> +       unsigned int seq;
> +       unsigned int freq;
> +       u64 scale;
> +
> +       if (!cpumask_test_cpu(cpu, amu_fie_cpus) || !arch_scale_freq_ref(cpu))
> +               return 0;
> +
> +retry:
> +       amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> +
> +       do {
> +               seq = raw_read_seqcount_begin(&amu_sample->seq);
> +               last_update = amu_sample->last_update;
> +       } while (read_seqcount_retry(&amu_sample->seq, seq));
> +
> +       /*
> +        * For those CPUs that are in full dynticks mode,
> +        * and those that have not seen tick for a while
> +        * try an alternative source for the counters (and thus freq scale),
> +        * if available for given policy
> +        */
> +       if (time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
> +               struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +               int ref_cpu = nr_cpu_ids;
> +
> +               if (cpumask_intersects(housekeeping_cpumask(HK_TYPE_TICK),
> +                                      policy->cpus))
> +                       ref_cpu = cpumask_nth_and(cpu, policy->cpus,
> +                                                 housekeeping_cpumask(HK_TYPE_TICK));
> +

This is looking for any other HK CPU within same policy for counters.
AFAIU, cpumask_nth_and() will return small_cpumask_bits/nr_cpu_ids
if the number of bits in both masks is different. Could you check
again if the current change is fine or needs something like below.
BTW, we have one CPU per policy.

   cpumask_and(&mask, policy->cpus, housekeeping_cpumask(HK_TYPE_TICK));
   retry:
	....
	cpumask_andnot(&mask, &mask, cpumask_of(cpu));
	ref_cpu = cpumask_any(&mask);

Thank you,
Sumit Gupta

> +               cpufreq_cpu_put(policy);
> +               if (ref_cpu >= nr_cpu_ids || ref_cpu == cpu)
> +                       /* No alternative to pull info from */
> +                       return 0;
> +               cpu = ref_cpu;
> +               goto retry;
> +       }
> +       /*
> +        * Reversed computation to the one used to determine
> +        * the arch_freq_scale value
> +        * (see amu_scale_freq_tick for details)
> +        */
> +       scale = arch_scale_freq_capacity(cpu);
> +       freq = scale * arch_scale_freq_ref(cpu);
> +       freq >>= SCHED_CAPACITY_SHIFT;
> +
> +       return freq;
> +}
> +
>   static void amu_fie_setup(const struct cpumask *cpus)
>   {
>          int cpu;
> --
> 2.25.1
> 

