Return-Path: <linux-kernel+bounces-87073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D43C86CF13
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E6E289466
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08570AD4;
	Thu, 29 Feb 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MOQ5jQpn"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2131.outbound.protection.outlook.com [40.107.95.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA616063A;
	Thu, 29 Feb 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223934; cv=fail; b=pRJadsBXdt9/d4tV+ToVnYRoBOrbEGYd3mqOQRty68DaiWf5WiJhnkcCUeW1/Z2CT5noiGjy9C/0057gvDkhyuXhF5eUFLiCB1qC7W/nEtE7XJKZY66AGkYR+ZVyY8/8Zc12HLbSJ6zQbSuwXh+gpRvTS3iZ9p6Yu94exIGo24M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223934; c=relaxed/simple;
	bh=c8IB9JQtAQLRn4tDN+0mjtpB+twHCIeOvinT3yVba6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D59LMvIrAbDEK7D+6WT+kceZz1ht5jm/lpqxcHNEk0KMvE1NjHgmOw7sAjHp4WuLAq+ATbj3+Wo3M/uUFHUzlgZw1+SsXuP0rIPR6785arUFImvsq3FeSMwjHwyc6/PwEGMzzg9wms2/iXgQDzOj+4UyzxpJ/r+jnjFbrbiUHZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=MOQ5jQpn; arc=fail smtp.client-ip=40.107.95.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie86MZ/UPWFz2qGZruLcfjUw0cugGo8AGbhD9rNkbLByibPqXIyWi0lj7R0MxhFDyx1NUXYCGTv8pUssTK89b9173wiN/kvl6Baz2HlLIFm/rDPlABlZ3KRpXaYv6rOj8aZ/7cwR124zF1R2JCuwZp04SAWx5psEu3n2fAjR7aJtcEH5CU2/vEOns6TjQop55oPjjta9YPn0+IxZql/y++VLWiKQ5C3EoAMJcJxYteOoT6BIL6ne4rm3Mp5iPoCkjDPlSDefolQSkNdjvHhqWr/1ih+G96YB1QQ4mE8JjfE8stzGsJQxP1uIIeJDeRKQNodXoTLzONrN/4/Ehnl+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSz2qDlKix/6vaArGmJ2NJgkGJOSduawb/qLuGOk+yw=;
 b=kMm998ZHtpK4KHFU5dwb57oCC2qkr2+yDaGwrzr6IIJQd6pApQZ3dhV35uqasAoBGM9ZcjE/0UN/dOJ0v+eoHiDGMycZRWnI4iYd5+vlFZLnMQxIph19Rn1BnYQEvMsuVwtGVO3lkALajaiTwXs3wivKr/xxslWTp0LgEAf1aGxK2mHy47ekJkRBdXc0YMvbPG2T+0KGsUqtpKYDJ7xuhS78xXfYjBQanmqlXgzoiOQzazsSoWXHd5kd8SScZBFrW1z3F+rwes4FxbCbIXWQGqPM4XjBe22n2grNKS8j7jzXFy4pZMJSNRw+KdC0s2zV4aQ9OvgyCub+jD1sjTN+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSz2qDlKix/6vaArGmJ2NJgkGJOSduawb/qLuGOk+yw=;
 b=MOQ5jQpnq44SpSdGORDELnLE8hw2AnegI1480zPB1Bw+SFYkLx1V4ILVuQKTH7FJgtE7kTjQ5PIZZ6YUH0OsRWJ9rDzFGp1laUUr+eyJBtmyGCEV33/6QjuO7GgM4bze4hnEQXQVk/fjw6qMXbWBVR3x/xYnJjOj5fgm5jmpGnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6509.prod.exchangelabs.com (2603:10b6:a03:294::17) by
 CO1PR01MB7225.prod.exchangelabs.com (2603:10b6:303:160::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.33; Thu, 29 Feb 2024 16:25:27 +0000
Received: from SJ0PR01MB6509.prod.exchangelabs.com ([fe80::3bf9:56fb:dd12:56])
 by SJ0PR01MB6509.prod.exchangelabs.com ([fe80::3bf9:56fb:dd12:56%6]) with
 mapi id 15.20.7316.037; Thu, 29 Feb 2024 16:25:27 +0000
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Huisong Li <lihuisong@huawei.com>,
	Beata Michalska <beata.michalska@arm.com>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	sumitg@nvidia.com,
	zengheng4@huawei.com,
	yang@os.amperecomputing.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	liuyonglong@huawei.com,
	zhanjie9@hisilicon.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH v1 1/3] arm64: topology: Add arch_freq_get_on_cpu() support
Date: Thu, 29 Feb 2024 08:25:13 -0800
Message-ID: <20240229162520.970986-2-vanshikonda@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240229162520.970986-1-vanshikonda@os.amperecomputing.com>
References: <20240229162520.970986-1-vanshikonda@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0393.namprd03.prod.outlook.com
 (2603:10b6:610:11b::21) To SJ0PR01MB6509.prod.exchangelabs.com
 (2603:10b6:a03:294::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6509:EE_|CO1PR01MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 4568ed09-1d69-4a92-5f82-08dc394309ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qDgXxHpSro7q3jd+pPMtPTaWgidW2fviQBN0dgL4ExvOI+kJ9ix40DZLsoDe+WVF1u0OpeKewB55l5PeTqIXZ1gHtRZ6hXHNn8URmDxvE9P0p7olEB3iYYJ70XgxKIwSm9xrAHWB6rTF8JedUgMSOUkfNUKkVXY2ZFB6U4d9QXncuo97Eg9jievotf23cBwT4grMKbOAA1tQ+U7Z8pc+/TaAXNPGlz8eKqDicBHEjU7qfFM5YQMw1Fl3wQd3JvdeChLKTjV4VsLvnzb2Pq7byk1585rOZVMISOsoQnq/n5c4bO7/kztaLxO5FkJPFPQKt80HgfYgOb6YkowTzLUhgKEIYFzPtBkN+VaEGXSEGFgXG/z2GrXk9p4PONUrKjXyFujsMZCglCNj2x/FdSsdNKH3CgKYgLugUIcNnQAqFpX13gzuxvjZcFgGBKk6UVUcmND6lFLsZEv+5TUIsFocz4lmeg8g/kCSGio0zS6H77TRDHJvSNEXSisJOhLFva1IkODzeAf0/xcotRG1bKtpk478bJ+ih6SZ68VEBqIHFlZi+qlx7go5urksZ5a0Co9Re1mnk7qRDIzJ6slvUzdfXTpq6MweW/dVvUN3E1Lv+rEavfa8YH1Of0WmARygrV8hIfwTEmr3Omv0zZWD7EPwFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6509.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qZhycgWvOYoEDfDJCEWDI+f3nI5RSvDFD/bPv2gLLoYfN7kDzTN3B7O3bpFF?=
 =?us-ascii?Q?mlRxFRth8XGV1M+eFNzPWKIYfXWTDOi25L8V9IiTcnC32cFJfbOrR3r/0bsS?=
 =?us-ascii?Q?eSqSV37kl7Tchem5usWdDLG0cHEApGELACFigeGD+XnxCJsFMs/zqrt9NNXQ?=
 =?us-ascii?Q?YFyrJCX8fdyttTVd5LPnaNKWdPtpTBIvduQ02Z91Nd6HM/GPcxRrXCg7OBJc?=
 =?us-ascii?Q?+KWWQKYSTe8lAP4jHPcf0ZE/KBY+1paFybiCv6hK0f70HufH/pqlDs4S/N11?=
 =?us-ascii?Q?uxZ+oSiDjRhSx8zUDdpdHVof2blOeSa4oTNMyGmBPqutvn33wOeVCFmoOAAt?=
 =?us-ascii?Q?iWgvZ0EneaKf9hwQHF4P8HhNd+Bh3YtkyLGnzDIv2gNPfDXOYDLQzprJAhxT?=
 =?us-ascii?Q?KdK/qRgy+S7GWSHuh7EoRAhJmnM9n18yMlrRAifjvEUiu2IODjsWIi+7kR2v?=
 =?us-ascii?Q?TN3pQXjhXWlYstdkyC+49bBkzpWY62nRDbvlnnirW+m2QhmUTyEXdagb2qZr?=
 =?us-ascii?Q?Z5wy3phOjUPKQV63XSUIe52K9mCIoB5jjKDimCP3CFbPwpzML3H2iHwsXpjo?=
 =?us-ascii?Q?Z4kBp2m/c74V49/uSaMMkSTThwV4ZRUvzNNOr3j0Ipc4oU6TbhdInd1EPhHb?=
 =?us-ascii?Q?ZmTk6XBfWeSJgB3JcDIM0X5EMTldIrgnFa204fvQhLx2EBzE2a2BZu7CuxOv?=
 =?us-ascii?Q?55f1D8QMWefS/urzw3g5mZUKe+lCQRJXMumDQoviewj0fLMEgSkNHS5WX2Of?=
 =?us-ascii?Q?pgeQt/1YSxYqOnnGkpXl5njRjK6iH4HBVpCi7udtKxJBNPYjHym6eCY4MKvH?=
 =?us-ascii?Q?1JFaSCyZo6cIcrsmF8YKS9c+WSyKpWX/as4lbdaArZsvEHeZupOHW+bws51r?=
 =?us-ascii?Q?6WD05cFMeAE9Y4g65ua8gEzmRnVgGwxBVwBmHaezoZ0iGHWcYDVUeJYxDwaD?=
 =?us-ascii?Q?eq2uZ4SfiFz2qkWiYS8vCoLVi+eKTq4Y2TzcCZkWy3s6+z6RbrYXJobHvsy6?=
 =?us-ascii?Q?qyLjoLAacpz36BFmuFWWk5JtGaM9CgTljqjTBTrVcGzYd6Nq9YaXwnNcJi9k?=
 =?us-ascii?Q?iHLsV4ZI2H5E1fQX/HQ532r9n5t6oyMuHsT4wrXdhZiL+47zdq1BRVSrHAml?=
 =?us-ascii?Q?sxPrCu3eWQ8wi1ofyyr+28N4k6GIA0Z0hjz8hTA12rewJFVmbedlTZIpWYKO?=
 =?us-ascii?Q?1mBDBzRrBjV7sQ/KQDdM58bK15xdKc2nopAR5fuogohnBoJeC4sQuq3G7CTu?=
 =?us-ascii?Q?FHHqvqgIJcZeTiPzcTuHkxh3w8uUjsc6mzo29abTQ61tqp+cUOl0SSGy7+UE?=
 =?us-ascii?Q?eWUr++AEr1eIqbpS5YoXi/HNwX3QWtaGIKZteYB/pFRVHrWYmDs3YVMMAdZ+?=
 =?us-ascii?Q?reR1qCRX49ywRWLMSld/+t6RBkt7QXNLgyHWXEhgD9SVBAtrXxJhDbGDrGc3?=
 =?us-ascii?Q?vGmUkyqIsm7GXt2Zrcng9mEHO3KEdOVGvgiF0xA6/8vbzmxc/3/Jgru1eers?=
 =?us-ascii?Q?kl2kzVh7U2iF+fIKXhPMeqFutAgfW1cJNwR1Xs22bVPJdXbVGuhE68mOg4Le?=
 =?us-ascii?Q?FgTGdCcbzMcjOFES0PYSem8swniwS9O0ejrXJkPN2lR/nl2DAyB7izAJcjKa?=
 =?us-ascii?Q?aWGvfZOW8UE64DMJYt9NZDkLczr9TVxBB5IDjh32fWxJ?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4568ed09-1d69-4a92-5f82-08dc394309ee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6509.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 16:25:27.3101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsuUjr8LakPzpB3G+M4Sxx0Zl4vQAhGJ9QI1jXKg8lFDJF0UBEUqM6bY05NdJwunDhSRhhMZKcPWg90Yur6m4Ay0tIVH/Ffr4/z9ltIrb4RLS9rt7kz4J8wtO4vbsB3H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7225

AMU counters are used by the Frequency Invariance Engine (FIE) to
estimate the CPU utilization during each tick. The delta of the AMU
counters between two ticks can also be used to estimate the average CPU
frequency of each core over the tick duration. Measure the AMU counters
during tick, compute the delta and store it. When the frequency of the
core is queried, use the stored delta to determine the frequency.

arch_freq_get_on_cpu() is used on x86 systems to estimate the frequency
of each CPU. It can be wired up on arm64 for the same functionality.

Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
---
 arch/arm64/kernel/topology.c | 114 +++++++++++++++++++++++++++++------
 1 file changed, 96 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 1a2c72f3e7f8..db8d14525cf4 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -17,6 +17,8 @@
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
+#include <linux/sched/isolation.h>
+#include <linux/seqlock_types.h>
 
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -82,20 +84,54 @@ int __init parse_acpi_topology(void)
 #undef pr_fmt
 #define pr_fmt(fmt) "AMU: " fmt
 
+struct amu_counters {
+	seqcount_t	seq;
+	unsigned long	last_update;
+	u64		core_cnt;
+	u64		const_cnt;
+	u64		delta_core_cnt;
+	u64		delta_const_cnt;
+};
+
 /*
  * Ensure that amu_scale_freq_tick() will return SCHED_CAPACITY_SCALE until
  * the CPU capacity and its associated frequency have been correctly
  * initialized.
  */
-static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
-static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
-static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
+static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =
+	1UL << (2 * SCHED_CAPACITY_SHIFT);
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_counters, cpu_samples) = {
+	.seq = SEQCNT_ZERO(cpu_samples.seq)
+};
 static cpumask_var_t amu_fie_cpus;
 
 void update_freq_counters_refs(void)
 {
-	this_cpu_write(arch_core_cycles_prev, read_corecnt());
-	this_cpu_write(arch_const_cycles_prev, read_constcnt());
+	struct amu_counters *cpu_sample = this_cpu_ptr(&cpu_samples);
+	u64 core_cnt, const_cnt, delta_core_cnt, delta_const_cnt;
+
+	const_cnt = read_constcnt();
+	core_cnt = read_corecnt();
+
+	if (unlikely(core_cnt < cpu_sample->core_cnt) ||
+	    unlikely(const_cnt < cpu_sample->const_cnt)) {
+		WARN(1, "AMU counter values should be monotonic.\n");
+		cpu_sample->delta_const_cnt = 0;
+		cpu_sample->delta_core_cnt = 0;
+		return;
+	}
+
+	delta_core_cnt = core_cnt - cpu_sample->core_cnt;
+	delta_const_cnt = const_cnt - cpu_sample->const_cnt;
+
+	cpu_sample->core_cnt = core_cnt;
+	cpu_sample->const_cnt = const_cnt;
+
+	raw_write_seqcount_begin(&cpu_sample->seq);
+	cpu_sample->last_update = jiffies;
+	cpu_sample->delta_const_cnt = delta_const_cnt;
+	cpu_sample->delta_core_cnt = delta_core_cnt;
+	raw_write_seqcount_end(&cpu_sample->seq);
 }
 
 static inline bool freq_counters_valid(int cpu)
@@ -108,8 +144,7 @@ static inline bool freq_counters_valid(int cpu)
 		return false;
 	}
 
-	if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
-		     !per_cpu(arch_core_cycles_prev, cpu))) {
+	if (unlikely(per_cpu_ptr(&cpu_samples, cpu) == NULL)) {
 		pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
 		return false;
 	}
@@ -152,19 +187,15 @@ void freq_inv_set_max_ratio(int cpu, u64 max_rate)
 
 static void amu_scale_freq_tick(void)
 {
-	u64 prev_core_cnt, prev_const_cnt;
-	u64 core_cnt, const_cnt, scale;
-
-	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
-	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
+	struct amu_counters *cpu_sample = this_cpu_ptr(&cpu_samples);
+	u64 delta_core_cnt, delta_const_cnt, scale;
 
 	update_freq_counters_refs();
 
-	const_cnt = this_cpu_read(arch_const_cycles_prev);
-	core_cnt = this_cpu_read(arch_core_cycles_prev);
+	delta_const_cnt = cpu_sample->delta_const_cnt;
+	delta_core_cnt = cpu_sample->delta_core_cnt;
 
-	if (unlikely(core_cnt <= prev_core_cnt ||
-		     const_cnt <= prev_const_cnt))
+	if ((delta_const_cnt == 0) || (delta_core_cnt == 0))
 		return;
 
 	/*
@@ -175,15 +206,62 @@ static void amu_scale_freq_tick(void)
 	 * See validate_cpu_freq_invariance_counters() for details on
 	 * arch_max_freq_scale and the use of SCHED_CAPACITY_SHIFT.
 	 */
-	scale = core_cnt - prev_core_cnt;
+	scale = delta_core_cnt;
 	scale *= this_cpu_read(arch_max_freq_scale);
 	scale = div64_u64(scale >> SCHED_CAPACITY_SHIFT,
-			  const_cnt - prev_const_cnt);
+			  delta_const_cnt);
 
 	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
 	this_cpu_write(arch_freq_scale, (unsigned long)scale);
 }
 
+/*
+ * Discard samples older than the define maximum sample age of 20ms. There
+ * is no point in sending IPIs in such a case. If the scheduler tick was
+ * not running then the CPU is either idle or isolated.
+ */
+#define MAX_SAMPLE_AGE	((unsigned long)HZ / 50)
+
+unsigned int arch_freq_get_on_cpu(int cpu)
+{
+	struct amu_counters *cpu_sample = per_cpu_ptr(&cpu_samples, cpu);
+	u64 delta_const_cnt, delta_core_cnt;
+	unsigned int seq, freq;
+	unsigned long last;
+
+	if (!freq_counters_valid(cpu))
+		goto fallback;
+
+	do {
+		seq = raw_read_seqcount_begin(&cpu_sample->seq);
+		last = cpu_sample->last_update;
+		delta_core_cnt = cpu_sample->delta_core_cnt;
+		delta_const_cnt = cpu_sample->delta_const_cnt;
+	} while (read_seqcount_retry(&cpu_sample->seq, seq));
+
+	/*
+	 * Bail on invalid count and when the last update was too long ago,
+	 * which covers idle and NOHZ full CPUs.
+	 */
+	if (!delta_const_cnt || ((jiffies - last) > MAX_SAMPLE_AGE)) {
+		if (!(housekeeping_cpu(cpu, HK_TYPE_TICK) && idle_cpu(cpu)))
+			goto fallback;
+	}
+
+	/*
+	 * CPU frequency = reference perf (in Hz) * (/\ delivered) / (/\ reference)
+	 * AMU reference performance counter increment rate is equal to the rate
+	 * of increment of the System counter, CNTPCT_EL0 and can be used to
+	 * compute the CPU frequency.
+	 */
+	return div64_u64((delta_core_cnt * (arch_timer_get_rate() / HZ)),
+			 delta_const_cnt);
+
+fallback:
+	freq = cpufreq_quick_get(cpu);
+	return freq ? freq : cpufreq_get_hw_max_freq(cpu);
+}
+
 static struct scale_freq_data amu_sfd = {
 	.source = SCALE_FREQ_SOURCE_ARCH,
 	.set_freq_scale = amu_scale_freq_tick,
-- 
2.43.1


