Return-Path: <linux-kernel+bounces-101046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B00687A17B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1184C282941
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A219710A28;
	Wed, 13 Mar 2024 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="SwKQwNDP"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2108.outbound.protection.outlook.com [40.107.237.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685010A13
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295974; cv=fail; b=qTFYNOeX68CZa0fZ/0gQYaFYIfyoXlrZcSRzNQRKQSiLwQvz+MrOD/9mfDRy7q1MZ3aTOFF2qouclJA5q6QpTbsca36X/fQcKV9gi8hWAFr8dv4OWntRCNLCbDAP2iX1Mkq6Q8SF/TBJLdTta6UQZ2VoKpe7RlviEgNC7U/422Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295974; c=relaxed/simple;
	bh=JMTFNYLTaqkdiWJ6HRvNTENsdOrREx7ouKMJjOemL0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iwpk7wt0MWXwDD+OifVoozFuDTJjSC0eVcILjM2CXtufi1OUnA6PQ94dRocPoUSYj+qUGuIHEIsxEme8AA17kJN+selRj9DOxfMT8PixjgxDJhSR0OhplX5i5A6+aEW/2z7Lm2Mn5RnEvfybw8rvxMfZRFAkCxTv0j3SMY/8SKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=SwKQwNDP; arc=fail smtp.client-ip=40.107.237.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZvWuuabvog/nTsqSC0qVVcCfM+bPVlUi56P9SIH4XKdAepESJC/mh/G/6SaEW/qGPD93eCgGzGi9FbcqtK6rlen07qP0yE7zq/FYukH7nk8WIQ86UasFugqCSel2X8f4DbBsMEo+c83Kw8R7xsFNRS7O3pmP2/bkcDOX1YZ5F0HKXCPuJjUbSqbxBgRIQBf1VP50h+Lr8XCrGU7oRCQp/AuVcdAMgWl9Ist9/myuYw2CeG2hKu2heCru5MDFse5ZpkBODSBAvPPSzZhLI400jI8epozO6QsA7kGes/YiCF4kwdxbd71mJcDp4sY6HSltBcyD+HGanoG7sMCfkKwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0peciEaaVXNBUsfkF/gRbxkPbOTGa1No07Fr4mW9sqc=;
 b=ak4aL/RLQ/sTsQOYz9REJH91VZkcDx7fpSiwc5pWYN+cgrADwz4mK7LODGeZ03PqbMdM8Gl/knR/KaJr+Hl2/yMT3MYpzj6nWmGTNnqj2sh2KUR71nTyQ2llau02FpqVKiMNsPtAghDoz3FAMYnBA2ydz5D9kR3OxiUGwa5SLiQPNGlbqrZX0AuxXxb6cGHRcnGbOQFvgw/wmy2m16j8V76W8OYAOcVc2ytKJpfcszo4Msd958TMj7ms9U1gTGUy0Zbc77Hzh0jCPeeRn2PX6Njtq+UhqSuURMnU6gXlWIqXs9rw3zz/hGq2S0Ze/CTstNj1J0tFeFstOynamqpnDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0peciEaaVXNBUsfkF/gRbxkPbOTGa1No07Fr4mW9sqc=;
 b=SwKQwNDPxgsPem4hvsFfzzBAzPuKksADaqRKHJ5tF0v9WZZuy/H6/XsXEHoEMbUjiy+ULDb2K7Q+C07MDYKO91BDoTERFMIqE36XYtba1IHGwJFe9BGo3/g2BYhIQick9VuupZq3pDMRQTjxT79/etvhG7VklnsmJtAzZ6+KWI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 PH7PR01MB8544.prod.exchangelabs.com (2603:10b6:510:2e9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Wed, 13 Mar 2024 02:12:44 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b%5]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 02:12:44 +0000
Date: Tue, 12 Mar 2024 19:12:37 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com, 
	vincent.guittot@linaro.org, sumitg@nvidia.com, yang@os.amperecomputing.com, 
	lihuisong@huawei.com
Subject: Re: [PATCH v3 2/3] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <q4pc63l43mtp56qim6s5riwu25cgvdqfchg7jbqhhcixkyqs7i@mlqqgd5hxnec>
References: <20240312083431.3239989-1-beata.michalska@arm.com>
 <20240312083431.3239989-3-beata.michalska@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240312083431.3239989-3-beata.michalska@arm.com>
X-ClientProxiedBy: CH0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:610:cc::6) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|PH7PR01MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 1beeb29f-1fb9-4c79-fb76-08dc4303100c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OpMIuKITwkvkcWgu0YuktM8/VdTTpUMd2YWa4TJLE863/qzT2L1GBsLQ1PbRbJWvnOa0dmXPqTHBN80QQJI6AW7cJZZAU/qie+4eptLWX4Y9KHBZTZsNsAcEAg4MYaGYwSMim5JIljugawxGFYWvKliuMvJB0xpgoXVQgRrEOq09sGKIDHrRcg+458xCbZjbeWL4bJJQ8cKYnk6GutgQ7SHJUg1aDm0DQrh/n8AmxuleVP28RfoIp9JDxyRYymFwy1UZW7bdo2Y9QBHREV2OGL9Set6n4o/F3rODIsUf0WLLV9YI/q0vrnhIjf9j/qZgbAat5izvhqc512gQRvJ0PH9dLcDsCXeZiBFafBeERUMqHvz5mdC2jlie9D5La4X4arf33lRGorH8VUtcxI9iE1RpE20XIpgIi0x82ajY4RQ47IfDE7KAkqv5Mus3lkHXhO9KikU9fGNjHnzlpNAbD8RWg080q4B4izsMqWQzQ7rP1VYggCFUDsFRdQSAfA+HFlHUpOmeJGFUqlKnB11yY9mRDJavQpV+dcLl0ciibRAz69fid+f74hc8WPe079sj4xfMEjrY/SgiYdlJN4NTqRu4e2ZQff5Ej4kU/H/dIRUiUGeSr/OPZ3XtQplNllLILSG3RkV2e3EPjmzPbtSaNPW8xM+wFJUsQgzFDHOKttw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/sqJs/rh0gxfmrVVuwWCgq7UR4Pwam2wbTdbPLfAMKjE8rKMijiE3+iD4DIF?=
 =?us-ascii?Q?+m460CMNgIWH3dz0B3Mgib6G2jA9eDw+WjmBml50TixKn2eImkHFnCEQ7dlC?=
 =?us-ascii?Q?UcyVxlSynYY83PQn8LaqZ9cdx3GFE4denIsv2PU21OavLbUMaj28pw0oXUBq?=
 =?us-ascii?Q?Ba96jDTNTQ3fICfx91VXeKw+aCyVcuKuthIV0QwmoRqyP3bvW07t/vrCo1Co?=
 =?us-ascii?Q?lsGLQZtdft7ETIBZCU3NkK6XfqSzR0hH7rc9cToo4z34J27Pfc1+Skcv2BD/?=
 =?us-ascii?Q?GrO0NqcuVvbUIVbIbXEWrw79WzX0bMFt96HY/6TAqRFYfWFJhXCqXkZ86xi5?=
 =?us-ascii?Q?FSTxgfrWVId5ZVKuRPo/rvDZkHwD9lFXXVcOduc+iLkvMXoXW0QkaT5QEdTJ?=
 =?us-ascii?Q?idOnemEXZVohKO4WR8MqhfTCiup1Rxpg7qKyCsQ+rG7WvYecfQxmuBgyvBMD?=
 =?us-ascii?Q?rZzg+YwnQh1dygsuY94iHtepMWmT7MbLWwrDC4WxcpZKTr5BTwH7CZh1xgNR?=
 =?us-ascii?Q?zmZyvCUsxTMd36tBGw/wRW/NVF8bx/91llqpgIxscQ0zJq6x1WqhqPExRQAE?=
 =?us-ascii?Q?cz4bFs8eqytkBNZ8M3odtbuvmsRZOiobNbtlSfu0nnE5FbVnH1nahD0tzO3c?=
 =?us-ascii?Q?/WMu9S4CdoNABa9wB08V68196mgJfr4jrEG3odXLR40QpkDui3EtaxqjzsFZ?=
 =?us-ascii?Q?qTZNHU+N8C7XNEbv3wP3ubkh8a8E5PS9ERKjh5H0JVxgQilmoBKh5RhjW+mc?=
 =?us-ascii?Q?fyoCDIZc7yVXtjliEq9Z8tYZujqFhPpCmdyN20Ka35zaJOCUhkF/4HbZaW2s?=
 =?us-ascii?Q?sFXpZBF6sgcsWqqRIlv+VLEiSjWkDEId4WR8PfvpyiL7ltk47z4jATL0UUwz?=
 =?us-ascii?Q?fYM6vjW4EXMgAMh9jlmDK3nEn5v5CouO2Et5D0NCTMe3uSWtG3462JCT3/Bx?=
 =?us-ascii?Q?qguFiKnXSm43bnRnjmH0bbrgbey04jFgQHO6HnDrUsZW+cXS4Al+HWznzIxA?=
 =?us-ascii?Q?FJhc9BTRMDGUEAWUxo/pnaxeiwPM7GrzHyIIq31Ps9VqCf2fugFILhxU+hl4?=
 =?us-ascii?Q?RZieqGuByT5bZToNJ+aMiZHVnW04k4H6EWMUgeny4bIuGj/nmGAqdKQ8MZ+p?=
 =?us-ascii?Q?ptdvtQdFBRqvOv7NCCcnDzUvgoZ1ce7ITrAN2E1ub3SIOQfwr5GimRcLck5J?=
 =?us-ascii?Q?UHhVewEIdjkQ2IhHCijgSsaOYORG3tLV07Ehuxt8arwbF9jS+qP3nXWBpQik?=
 =?us-ascii?Q?+/U90u5J31SRdVsZNHzoOpPvkXGdKPCXQuiEveVX6xFSUuk1OFQNXeU5dLe+?=
 =?us-ascii?Q?DRqocVYWySIs99o6BdxB38ox5swe9ieU93WfFt9ek+U9askaYGCQG3uDFm7n?=
 =?us-ascii?Q?o+rePji2ye6ELEbRVLMtJg3Lc/cwNQ/r1YuXzIyRPo4oz/mF7SsNHO7B284H?=
 =?us-ascii?Q?RzdP6VeV+DWBnkB0yeeNrOqSDciXeJWcjCAw5OXFHho4nqcH+diAR3tv/PBU?=
 =?us-ascii?Q?pxCqD8ZPD4SL+ZuD4bALRLV2GWNtWwtsNouHC5syYRY5PalTwSGOAGEHVrXX?=
 =?us-ascii?Q?BTx1iF21l4Dcsc62zyoAiUZqx+4aOcL8pBB5KjAjtIDS+ZPLU0pE0lcohdl2?=
 =?us-ascii?Q?sNEJ6e5znoTOalYvLPnfpuQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1beeb29f-1fb9-4c79-fb76-08dc4303100c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 02:12:44.0134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsNLD162PZR+uQIWIu+JbT1vCfNGSrgu6dfWIBqWaClNJU0sNQRVeDIXAf7YPhqrI1DELKrwptSwbk5y/EsMDnwpT9w3nwFSlUX5KvsMz015wEj/Srn+p4RcfJ7DMLsY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8544

On Tue, Mar 12, 2024 at 08:34:30AM +0000, Beata Michalska wrote:
>With the Frequency Invariance Engine (FIE) being already wired up with
>sched tick and making use of relevant (core counter and constant
>counter) AMU counters, getting the current frequency for a given CPU
>on supported platforms can be achieved by utilizing the frequency scale
>factor which reflects an average CPU frequency for the last tick period
>length.
>
>The solution is partially based on APERF/MPERF implementation of
>arch_freq_get_on_cpu.
>
>Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
>Signed-off-by: Beata Michalska <beata.michalska@arm.com>
>---
> arch/arm64/kernel/topology.c | 103 +++++++++++++++++++++++++++++++----
> 1 file changed, 92 insertions(+), 11 deletions(-)
>
>diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>index 1a2c72f3e7f8..42cb19c31719 100644
>--- a/arch/arm64/kernel/topology.c
>+++ b/arch/arm64/kernel/topology.c
>@@ -17,6 +17,8 @@
> #include <linux/cpufreq.h>
> #include <linux/init.h>
> #include <linux/percpu.h>
>+#include <linux/sched/isolation.h>
>+#include <linux/seqlock_types.h>
>
> #include <asm/cpu.h>
> #include <asm/cputype.h>
>@@ -88,18 +90,31 @@ int __init parse_acpi_topology(void)
>  * initialized.
>  */
> static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
>-static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
>-static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
> static cpumask_var_t amu_fie_cpus;
>
>+struct amu_cntr_sample {
>+	u64		arch_const_cycles_prev;
>+	u64		arch_core_cycles_prev;
>+	unsigned long	last_update;
>+	seqcount_t	seq;
>+};
>+
>+static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples) = {
>+	.seq = SEQCNT_ZERO(cpu_amu_samples.seq)
>+};
>+
> void update_freq_counters_refs(void)
> {
>-	this_cpu_write(arch_core_cycles_prev, read_corecnt());
>-	this_cpu_write(arch_const_cycles_prev, read_constcnt());
>+	struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
>+
>+	amu_sample->arch_core_cycles_prev = read_corecnt();
>+	amu_sample->arch_const_cycles_prev = read_constcnt();
> }
>
> static inline bool freq_counters_valid(int cpu)
> {
>+	struct amu_cntr_sample *amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
>+
> 	if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
> 		return false;
>
>@@ -108,8 +123,8 @@ static inline bool freq_counters_valid(int cpu)
> 		return false;
> 	}
>
>-	if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
>-		     !per_cpu(arch_core_cycles_prev, cpu))) {
>+	if (unlikely(!amu_sample->arch_const_cycles_prev ||
>+		     !amu_sample->arch_core_cycles_prev)) {
> 		pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
> 		return false;
> 	}
>@@ -152,20 +167,27 @@ void freq_inv_set_max_ratio(int cpu, u64 max_rate)
>
> static void amu_scale_freq_tick(void)
> {
>+	struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
> 	u64 prev_core_cnt, prev_const_cnt;
> 	u64 core_cnt, const_cnt, scale;
>
>-	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
>-	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
>+	prev_const_cnt = amu_sample->arch_const_cycles_prev;
>+	prev_core_cnt = amu_sample->arch_core_cycles_prev;
>+
>+	write_seqcount_begin(&amu_sample->seq);
>
> 	update_freq_counters_refs();
>
>-	const_cnt = this_cpu_read(arch_const_cycles_prev);
>-	core_cnt = this_cpu_read(arch_core_cycles_prev);
>+	const_cnt = amu_sample->arch_const_cycles_prev;
>+	core_cnt = amu_sample->arch_core_cycles_prev;
>
>+	/*
>+	 * This should not happen unless the AMUs have been reset and the
>+	 * counter values have not been resroted - unlikely

/resroted/restored

>+	 */
> 	if (unlikely(core_cnt <= prev_core_cnt ||
> 		     const_cnt <= prev_const_cnt))
>-		return;
>+		goto leave;
>
> 	/*
> 	 *	    /\core    arch_max_freq_scale
>@@ -182,6 +204,10 @@ static void amu_scale_freq_tick(void)
>
> 	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
> 	this_cpu_write(arch_freq_scale, (unsigned long)scale);
>+
>+	amu_sample->last_update = jiffies;
>+leave:
>+	write_seqcount_end(&amu_sample->seq);
> }
>
> static struct scale_freq_data amu_sfd = {
>@@ -189,6 +215,61 @@ static struct scale_freq_data amu_sfd = {
> 	.set_freq_scale = amu_scale_freq_tick,
> };
>
>+#define AMU_SAMPLE_EXP_MS	20
>+
>+unsigned int arch_freq_get_on_cpu(int cpu)
>+{
>+	struct amu_cntr_sample *amu_sample;
>+	unsigned long last_update;
>+	unsigned int seq;
>+	unsigned int freq;
>+	u64 scale;
>+
>+	if (!cpumask_test_cpu(cpu, amu_fie_cpus) || !arch_scale_freq_ref(cpu))
>+		return 0;
>+
>+retry:
>+	amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
>+
>+	do {
>+		seq = raw_read_seqcount_begin(&amu_sample->seq);
>+		last_update = amu_sample->last_update;
>+	} while (read_seqcount_retry(&amu_sample->seq, seq));
>+
>+	/*
>+	 * For those CPUs that are in full dynticks mode,
>+	 * and those that have not seen tick for a while
>+	 * try an alternative source for the counters (and thus freq scale),
>+	 * if available for given policy
>+	 */
>+	if (time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
>+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>+		int ref_cpu = nr_cpu_ids;
>+
>+		if (cpumask_intersects(housekeeping_cpumask(HK_TYPE_TICK),
>+				       policy->cpus))
>+			ref_cpu = cpumask_nth_and(cpu, policy->cpus,
>+						  housekeeping_cpumask(HK_TYPE_TICK));
>+

Could you help me understand why getting the frequency from another
housekeeping cpu would be a better than returning 0? Wouldn't different
CPUs in the HK_TYPE_TICK domain be running at independent frequencies?
May be adding this explanation to the patch commit message would help
people who look at this in the future?

Thanks,
Vanshi

>+		cpufreq_cpu_put(policy);
>+		if (ref_cpu >= nr_cpu_ids || ref_cpu == cpu)
>+			/* No alternative to pull info from */
>+			return 0;
>+		cpu = ref_cpu;
>+		goto retry;
>+	}
>+	/*
>+	 * Reversed computation to the one used to determine
>+	 * the arch_freq_scale value
>+	 * (see amu_scale_freq_tick for details)
>+	 */
>+	scale = arch_scale_freq_capacity(cpu);
>+	freq = scale * arch_scale_freq_ref(cpu);
>+	freq >>= SCHED_CAPACITY_SHIFT;
>+
>+	return freq;
>+}
>+
> static void amu_fie_setup(const struct cpumask *cpus)
> {
> 	int cpu;
>-- 
>2.25.1
>

