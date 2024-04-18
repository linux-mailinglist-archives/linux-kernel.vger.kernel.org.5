Return-Path: <linux-kernel+bounces-149409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854918A90C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4ED4B225BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5238F66;
	Thu, 18 Apr 2024 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Y5qhaceK"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2113.outbound.protection.outlook.com [40.107.212.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F128C1366
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404353; cv=fail; b=AqvSJunbq+IjeYaaGLmLF71i0tynRJLOMenMlxCzWLHfETckh3EyizQCbS2FQNvDYwSAnLTER1Q53QIp3RBnDvSwO17P73jTovtocsiCDqa04IHiPMZzcfegTeiMKV26d97wSspUf5dYQrEe/GdfEsYVq7Ln7rAuZSN5APGBkZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404353; c=relaxed/simple;
	bh=BTN5JMA+Buf25g08NsF89BUxiQSyzbJw1YHOMen7iDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NiaBvwBBHH6a0n3RX3qnZjGgrkIjQynp+iPtUnPjU/PzAUUFQH6vTl6qQm3mQ5di5GL+erhIqrvfvom8VgtP/QkDF36fuOwI0aJPQ+UcvZDwMADrkQ5s6FqOYnc4VFIkeoD8R/c5xoIslv+FQN1UiuWfftNFvTMVvzt1vTUC0W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Y5qhaceK; arc=fail smtp.client-ip=40.107.212.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/x0OVWV3Bp/bhq+7FanXObKmG5J8OyCz/sXftqxOuigdYmbIOk38NT0IBUlNpZ2L50/5e2/7ZlrOLbXRSTrsjOg2TVtz1elzYu/YKGT9FotGF8XujYlb0SVJQ9Z87OY+WEpmvbcHamdr9Kkjcx5jejemS3kh5HHtBmN32z0vgs3RgSmBzKm8kYzomvTEWG2JabhnOF89U/Vdn5loJFwmoqLhJXqP177w9ec0wNi7xJm/K6RXYTluxBQaBS7kxlJ4OZibysRCQz07sWTrBkpIMsWOeqlKAkBKPzaaQ4gftAGmYHGEL/VgxNcLvsEmkVGRYO5gYNqC5dlRK7I+ZG8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixN8KNTbwFQd3j24VeNrnQ2UzLLOJya7Yi445vNn6Iw=;
 b=Uo5uVsK+cWO2ISqSPyicfZVahikgApAfsxbTu2oJ+tdPnHDLkM9LQC6SqQNRkcsVe/kso3GpODh/lOS15TZdP/Q+Iwoy0U1r4rmpd3ouXUkhGBc0CbKjeKa3S9yF4mCj/XxDe7IigaWuSEhF14WHlhLmyEJ5hW80hBIClPN80By1hrblSIgBHB9GQV7JQnu6kQlyWCW+yDEh8Q5tp6u4Ii+O7U1IsZacGDbp+v3USGOxccMplXd5oFaBSK/dOXfcp3NQUgmi9HAMPgxqXu2YiQ6YIz1S0Mzjl9VQebIbzocOtADK7LLnakgJlza72oy/6eWEQiibImboEDUJDKCc0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixN8KNTbwFQd3j24VeNrnQ2UzLLOJya7Yi445vNn6Iw=;
 b=Y5qhaceKWcHnCFGN6klfb/ngkruNfeMmmEicDEJsEWXcBq29M2eJ7fMAr1365Ae/AOLdU9Coi3BzdjZkBToBca2l9nxJzFAeQDRe15/TyPQPLqKXjiI+KUwQhMX+t3Fbk3gS2P+8bzUyEl9joUjzMAGM1qRm7xL8EOfs8tjdglI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 SJ2PR01MB8257.prod.exchangelabs.com (2603:10b6:a03:53d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Thu, 18 Apr 2024 01:39:05 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b%5]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 01:39:05 +0000
Date: Wed, 17 Apr 2024 18:39:00 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com, 
	vincent.guittot@linaro.org, sumitg@nvidia.com, yang@os.amperecomputing.com, 
	lihuisong@huawei.com, viresh.kumar@linaro.org
Subject: Re: [PATCH v5 3/5] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <6inw6vhqe3uuxjozeioqujzdtksmsdr4estzkdsbb762rcxa7z@sn56uogdatjr>
References: <20240417093848.1555462-1-beata.michalska@arm.com>
 <20240417093848.1555462-4-beata.michalska@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240417093848.1555462-4-beata.michalska@arm.com>
X-ClientProxiedBy: CH5P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::27) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|SJ2PR01MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f92058-5237-4878-c881-08dc5f48551f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	shOLIxmOozP5KBIfaYNyjFixZL1Abm5FYx9HAz+DFrPpEJxUzGWe+8v2z13yLObAqd+46vauswhMFtZcM35Wxl1toSYP1ov4V2iwOJbp+CBBctw1F3Fqi3nzOWUl0HFJL8oe+LDIn0a1+3GAQLg92XXPa0y09YyzeuOmoMoz1beXlbQgN6ME9uCO92ZM9wZhR0MpAgnhlsa9k9X+PSDhm/67Gms3TJ4vaiaZL+aKWhs9C66jMa1oF6mDgRdDBVr0NcytyzakcRfkRoPIrocndUXOCoLcFPVrM0PyU425aOT1lC7quntqkBP1IEEiGGmq9wNZtTNIsA8mkiPrMPs3BDE3M/fVETt04oU1h8TutwtNmvXUG8PYyCOPlAo/HfFJRnvjLGJEgvKYbeUwA4WHQclIMMouyiypmgCVGaFYUEj0kww8MFWaB1oPsBXxmzlytuaqPpovzlQbPYH0w20e0XqatdaXETWr2rmBzqhwvP4Y1k89mcxyTznV+zoFUt3pXZhmdiRCuceR0uBkLykZgrhqp8mT1vccFEmscupuw2zRDuA8PmMKZSuYvRWOjaqNgsF47FE2+YMBEPrCTEKz0m5Fu8oMcn92O45qKKCueLjUEVasAoBqI84MGQ552S2ktgum3a9V4eZZMU6Em9nsK7JFvS5ZpVBLLJID3sVVxIs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KsrfDr2NFfpaXP9tqybS2yEl9BDsgZU0BOyNbKglU4ZmMQoa54rg+po1u48s?=
 =?us-ascii?Q?0aqVGo6PVe5AAmLpMgE38JUR35IX/WBPyZbIJ+BAJd/BODDd6kGUkKLJ+KxJ?=
 =?us-ascii?Q?JU0yDdHPukPBHjc2kcn7IuuVOHcQ7kqieRuCdVXytwePABrZXGFnN6f+WhSb?=
 =?us-ascii?Q?hOO937PB5dBwzpIc7XU5VHHpEcCcKKrJX/Vkha4iMRdPQNO7I/6Elwo82xvH?=
 =?us-ascii?Q?J80XrfAypLQiE6z1Q7dqciL/t9qLB0c90mYodUIF48RY/hbMFrtEMRaYBMYi?=
 =?us-ascii?Q?EqSaFF70mLxUPaKsT4gKP31XlKxeMMPB/So/D6mkclrNOJUAQuykjlf79CQG?=
 =?us-ascii?Q?51JuBygZ6L+iRYUyzP8KwLpBN/dXLscfALJx5YB7JXZGqpkNVZaIf+DpWLM+?=
 =?us-ascii?Q?NXlEidubVDiujuPdoBple5aqsUvaPWhs/S40LJwGMo9ZHKvKKxPRFbMy/BD0?=
 =?us-ascii?Q?xpTLCtILnZdtHu6yaf3digZ4ytM2k39tbHZINxUK1ikqu9tsKC6ZDoY1n8/L?=
 =?us-ascii?Q?Dt437V1IBKQk8ojxf0iDb1eRdOqJp8lSgJ/syAps+muNjAT2Mka2xPndnwN/?=
 =?us-ascii?Q?LHmyzG3cPw86JUKH/O4rTEeqA0KYMIZItKjKuoo+8gOmLfBs/vun/fVj5IUK?=
 =?us-ascii?Q?A0/M8CQpD6ge9RMwx+UHu2A1pwj7PJUpougsFmAEu4BqKCDryV4IZ/Esthfx?=
 =?us-ascii?Q?Ixo62w08vyTukx0zn34VgmIYyzFihLplw73/K+Sn801nzoWLmIEkUgTwr5hy?=
 =?us-ascii?Q?wq/o3ANAGNuaHL78k/pjdbePfBEQni84zkfPR7szFlxgYWxl0NDV3kwwiyQ4?=
 =?us-ascii?Q?ONOgS0N7dp6fLN3ny8naWRNv2Ywt8P9smqpahW6QaI/xttth71JB8AryqmVE?=
 =?us-ascii?Q?sTOl14u9zWa9jvMRDuOO7oTMX+iQfdWY5jOh/6F7Zv/l6/+rb9ChlRp/ifkg?=
 =?us-ascii?Q?NBW8afR+YWtBkfi6k1h7KtYN4MnwZ6+VBjz7h0t1MZLMnvnkmmRwZn0ohu/Y?=
 =?us-ascii?Q?jGsgBUTnPBOc5pcv0fe4On4xJvxbuLBnC0ZTp7/9NaIOYm+tScsJylyg9R8A?=
 =?us-ascii?Q?a6wLKaHZMVpFkfiBgl4WSCpeugm2kIE71Xxzss3axHD0vln3ec2ya3G1nmPT?=
 =?us-ascii?Q?l3Wl3+YgHDbNgocvBdmedJebqltTLKLi6w5Mg5noCBG58O6YA1gvJmH+Emsy?=
 =?us-ascii?Q?ybwK2jEmPMuDBV9EZ/OpKx2VTePqNfUPq/m5lmGiNahRww7prHxauQG7srpp?=
 =?us-ascii?Q?9BvVLIrARqhlALMaMDsdqyMspSInPmQUC7CID6tk2BzvqOdWXWJb+MFG0alQ?=
 =?us-ascii?Q?nkTV6fAApGbfxNouEg3WSzY9LqF4rr+EiEXc5vgZiP0os+FdostBjUHKkoMc?=
 =?us-ascii?Q?VFxj5FvhQeq0tSMhoKNL8pYiOWu6AUV1Pha5gOwcW75gkYjldynw9BFvfjag?=
 =?us-ascii?Q?fhfm105AooVO+075xlqwZlb7Xc2RJvkA4d3OaKQdqZ+76o9RfTyHL60YC0yx?=
 =?us-ascii?Q?9yHgbtAeQa4H3Lpam2n5WPvta8+wHaYj1tYbMKAlTt3nqP9PaSDb9j48OKv8?=
 =?us-ascii?Q?gB0fUzn1Gg5pmsiKe/eDy4rGAdrSnL0U9zNfCL7aZqc1TEetWvK8kbePzpWT?=
 =?us-ascii?Q?Tn/VnOQJp7lsHFdohee/4jg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f92058-5237-4878-c881-08dc5f48551f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 01:39:05.4711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaqfotisGKFpTQiBObqszLm9Pcik0Gv0E4iLYusDb757xnwc2b1Ge3d5jlqG+SanS6mCLic92xNxzMTTuQh4Iv7wW2qYti5X12ICqVpzZDRk3b+YvNfnRNUmXG78j7ll
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8257

On Wed, Apr 17, 2024 at 10:38:46AM +0100, Beata Michalska wrote:
>With the Frequency Invariance Engine (FIE) being already wired up with
>sched tick and making use of relevant (core counter and constant
>counter) AMU counters, getting the current frequency for a given CPU,
>can be achieved by utilizing the frequency scale factor which reflects
>an average CPU frequency for the last tick period length.
>
>The solution is partially based on APERF/MPERF implementation of
>arch_freq_get_on_cpu.
>
>Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
>Signed-off-by: Beata Michalska <beata.michalska@arm.com>
>---
> arch/arm64/kernel/topology.c | 110 +++++++++++++++++++++++++++++++----
> 1 file changed, 100 insertions(+), 10 deletions(-)
>
>diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>index 3c814a278534..475fdbf3032a 100644
>--- a/arch/arm64/kernel/topology.c
>+++ b/arch/arm64/kernel/topology.c
>@@ -17,6 +17,7 @@
> #include <linux/cpufreq.h>
> #include <linux/init.h>
> #include <linux/percpu.h>
>+#include <linux/sched/isolation.h>
>
> #include <asm/cpu.h>
> #include <asm/cputype.h>
>@@ -88,18 +89,28 @@ int __init parse_acpi_topology(void)
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
>+};
>+
>+static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples);
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
>@@ -108,8 +119,8 @@ static inline bool freq_counters_valid(int cpu)
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
>@@ -152,17 +163,22 @@ void freq_inv_set_max_ratio(int cpu, u64 max_rate)
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
>+	 * counter values have not been restored - unlikely
>+	 */
> 	if (unlikely(core_cnt <= prev_core_cnt ||
> 		     const_cnt <= prev_const_cnt))
> 		return;
>@@ -182,6 +198,8 @@ static void amu_scale_freq_tick(void)
>
> 	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
> 	this_cpu_write(arch_freq_scale, (unsigned long)scale);
>+
>+	amu_sample->last_update = jiffies;
> }
>
> static struct scale_freq_data amu_sfd = {
>@@ -189,6 +207,78 @@ static struct scale_freq_data amu_sfd = {
> 	.set_freq_scale = amu_scale_freq_tick,
> };
>
>+static __always_inline bool amu_fie_cpu_supported(unsigned int cpu)
>+{
>+	return cpumask_available(amu_fie_cpus) &&
>+		cpumask_test_cpu(cpu, amu_fie_cpus);
>+}
>+
>+#define AMU_SAMPLE_EXP_MS	20
>+
>+unsigned int arch_freq_get_on_cpu(int cpu)
>+{
>+	struct amu_cntr_sample *amu_sample;
>+	unsigned int start_cpu = cpu;
>+	unsigned long last_update;
>+	unsigned int freq = 0;
>+	u64 scale;
>+
>+	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
>+		return 0;
>+
>+retry:
>+	amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
>+
>+	last_update = amu_sample->last_update;
>+
>+	/*
>+	 * For those CPUs that are in full dynticks mode,
>+	 * and those that have not seen tick for a while
>+	 * try an alternative source for the counters (and thus freq scale),

While testing this on AmpereOne system I found that the scaling_cur_freq
and cpufreq_cur_freq are inconsistent for nohz_full CPUs that are being
throttled (OS requested freq != HW provided freq).

For the test I ran stress-ng workload on 9 cores. All the other cores
are idle. I then forced the hardware to throttle the active cores - core
won't run at maximum frequency despite a request from the OS. Each core
has an independent cpufreq policy.

For the nohz_full CPUs since arch_freq_get_on_cpu bails out. In
show_scaling_cur_freq() the next check is to see if
cpufreq_driver->set_policy method is implemented. cppc_cpufreq does not
implement this method and we just end up returning the policy->cur
value. As discussed in other threads, it looks like we want the behavior
to be identical to x86 systems. In that case it seems like returning 0
from arch_freq_get_on_cpu is not going to be valid behavior.

Core    scaling_cur_freq cpufreq_cur_freq
[0]:    2700000          2700000
[1]:    2750000          2750000

nohz_full=2-7
[2]:    3200000          2691000
[3]:    3200000          2645000
[4]:    3200000          2731000
[5]:    3200000          2714000
[6]:    3200000          2466000
[7]:    3200000          2708000

isolcpus=8-11 (no workload applied to core 10-11)
[8]:    2700000          2700000
[9]:    2550000          2550000
[10]:   1046875          1046875
[11]:   1096875          1096875

Thanks,
Vanshi

>+	 * if available, for given policy:
>+	 * this boils down to identifying an active cpu within the same freq
>+	 * domain, if any.
>+	 */
>+	if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
>+	    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
>+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>+		int ref_cpu = cpu;
>+
>+		if (!policy)
>+			goto leave;
>+
>+		if (!policy_is_shared(policy)) {
>+			cpufreq_cpu_put(policy);
>+			goto leave;
>+		}
>+
>+		do {
>+			ref_cpu = cpumask_next_wrap(ref_cpu, policy->cpus,
>+						    start_cpu, false);
>+
>+		} while (ref_cpu < nr_cpu_ids && idle_cpu(ref_cpu));
>+
>+		cpufreq_cpu_put(policy);
>+
>+		if (ref_cpu >= nr_cpu_ids)
>+			/* No alternative to pull info from */
>+			goto leave;
>+
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
>+leave:
>+	return freq;
>+}
>+
> static void amu_fie_setup(const struct cpumask *cpus)
> {
> 	int cpu;
>-- 
>2.25.1
>

