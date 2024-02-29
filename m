Return-Path: <linux-kernel+bounces-87074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113AB86CF16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7408286139
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA39570AFA;
	Thu, 29 Feb 2024 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="f7EJXINd"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2131.outbound.protection.outlook.com [40.107.95.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329A6CC1B;
	Thu, 29 Feb 2024 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223936; cv=fail; b=GYfmFnLPtYJfHkjraBngtmTCXcRq8lpdeY9Z4XsuFm3VvItvi7gQ+887tLETgRB4XEhMFIIDOo4kjcwyOIU9Mfnx2I6L6zjoca7ZvyW8qDFboshM319N9frEd8gODyp2Fwds71lcUcB4Kfxn8dOrBnNe7mgwUJ1vnyx4E4LhTDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223936; c=relaxed/simple;
	bh=QCkTf3OnGasVu/7kR6MWYXsw22rGxvMFCvLCOdlbyGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E5pWQfnRZo5WodSQkX3xnc6SvQKKA3YwODwaIeYH7vpHMdpFwucum9SiUoT2+TNQWcMIYkwiINDHsHVcWrZo72BRLfECkSRvZi6+LR6HhKEoE6q4xLV4PnEChz5Pz0kEBZc8j2ezAE86eD/BdZ2AXUt3L2ImGfQJpzTe2ELsfDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=f7EJXINd; arc=fail smtp.client-ip=40.107.95.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qc7nJnPmi69LJVwbo0BpsT/7nFH3PRTE9YNVHIJ7v9cAfQiiYuVT1TL6spjA9dcR++GHMt+EnjK2BskX3jgUuR48yMtWK4okM+lj+RTkLXSkG3MQMozWWJGbTZoJTNEki+LUvAtk8tQOiKHgRBayht1yAbnJ8QFhD5D4Kwfh/XB9az1N2Dn+kCwhIczVibUShVUqqZbtD9lPqPrMGc0yzHaSKdkn2gZgW5T0tE0jEN7f90GcK8yixDWth4Fkqgbt2a1EM7TgQKZaWrsn0Yp1cPXhwAAE6i1Ti94grHVVvIpsZpmkJPLOJoZ3uAdWBnQDlULLsqT33yQR89DjHPEqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPf8ktNOUncWzsFgeSsltCK0HgC4tkxBS9eGBpVMFiU=;
 b=doSxpmUbImMpDYTeOtfcPnFyej67/3k+wJrJnw0BB6Q3coo/1+gVSx+/VvI7gKAfB2U9woAP3zuRcYy6kL1c3g2KMnhmyw2csfj1Y7pnApsAxva0TJgoecG9zLnzOqxOCTsBLNDhQUIpsWxmN6D+E0SRc86BqGT2v42cLt/sqLwor/NzH3Fd821sO/nV9WQGgX8uJNoN2zJLrlSsZQzWQj/CfDc2JvOc/tm0miF0GsBCvj+lqCKMyFckxr6sKb7AUQnyQwQc1Mp/gp6/U+B4wvQrotJE2t9G7gv8bmBNA+i9XlJ9Leeqc/pAikgqAaLCn4Nm+FqnS4k/h+Bpf4U+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPf8ktNOUncWzsFgeSsltCK0HgC4tkxBS9eGBpVMFiU=;
 b=f7EJXINdRr4Fdo0riDk9INCbjqjuAKesblJ+Q+gOEcoXt5/lD/R66Oj4dlqC70TGbirrQAlSOznbeQCSUtYRpdldkgD2cnge28Hvr1SbajAYpDBbAB/S+2MSOPdIcpm83BYCPyu1i19IDRxoVHwIuOO4JAWa0XNsaCWdmM+E55A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6509.prod.exchangelabs.com (2603:10b6:a03:294::17) by
 CO1PR01MB7225.prod.exchangelabs.com (2603:10b6:303:160::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.33; Thu, 29 Feb 2024 16:25:30 +0000
Received: from SJ0PR01MB6509.prod.exchangelabs.com ([fe80::3bf9:56fb:dd12:56])
 by SJ0PR01MB6509.prod.exchangelabs.com ([fe80::3bf9:56fb:dd12:56%6]) with
 mapi id 15.20.7316.037; Thu, 29 Feb 2024 16:25:30 +0000
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
Subject: [PATCH v1 2/3] arm64: idle: Cache AMU counters before entering idle
Date: Thu, 29 Feb 2024 08:25:14 -0800
Message-ID: <20240229162520.970986-3-vanshikonda@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240229162520.970986-1-vanshikonda@os.amperecomputing.com>
References: <20240229162520.970986-1-vanshikonda@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:610:52::14) To SJ0PR01MB6509.prod.exchangelabs.com
 (2603:10b6:a03:294::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6509:EE_|CO1PR01MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 0438bab8-55c4-4a1e-4fa0-08dc39430bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HNAtoXAAlsqmiF57P1BveLuRXGHBKDk2sI09fkflhn3NHSH55/OPxJeRuHozw+wEJFANi6kUmGAS2v1vM8IkvHrLBsgY7JsSQRIEX1n0LwPX2S3x1OEuhebut/KnPi1mILYNQ/B9bSn5v4QFu3VEj4QzNsDvNMQdc21TCXrnyyjqssNGTAEC3fGIL4cnF20cW7IZmUaIo5kaU7UxDXn5P7AaZBBpu6FMC4a6MCWi6jVSYxg6DWiZi+qjYgw17sHfmUc2t/cy7KbpZjNIK1uwPX180z9kBn/K8gCIYJrPzBrQqv1fCKkB/hcLwt+7JgyX/HJ12sKxyKyZcnQ+1GJ1VTRW/2eNB7DDy9P0KW+YXQwDK48F5UtnOcpyUhGLZRjRgb3bW0o4RL8boIEwL3sdQ5QSsWs4xVO/hX6irimnhozyW2TXNxrdzQfMr1uo8H84LivKi7EqkXLL4nNgRtWa8eYA8JTVFS5tCDT0wuHGG2z0VMl+dL4VBc7K0vLreCacXjulp7lwm5LEimpPE5VXV9aAgAHfa559/J2h/o1v0yyWa82ueHxDp+sRSYahSkz9maiT1t0L58DWasclKiQZSn2p/ZPgdJXg1a7Ieh2h8f9E6CwZoNqVReyiw9L9W7KPAP4yat4NDn923MmMkrhVBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6509.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mZXXGNDYfKwAyu6DqR1zsRDlosfzWAelgwxSnFnGnOJhwsiTR0fGKzrhOLan?=
 =?us-ascii?Q?U1EoEtXIbSKxrzLWTAKHeKLiIOM9HIYfvl6SdCZcDUCnmB5TLXLIiqObTRZI?=
 =?us-ascii?Q?zRMQXR039nJ8QXEIdMSx5fehf0g6xBencm+3WDzRqn/hV9rQdL74PkOoeu/V?=
 =?us-ascii?Q?4I8grGZdJCU0eHrK+/nCnjiGEUgo3sBQeehRHoWqK62/0h5n8s1sWRlwPI8q?=
 =?us-ascii?Q?26FpClPdzL7GFrDTr9GH+vi4D9LETg3Xxr3aIzgGl36TsQqznQsIEeLSwVIT?=
 =?us-ascii?Q?bIfcHLpsTLp6mcwntE1lS/h3lLmNna/QUlsmQbqQnAkxuLV6n3iYHj9eWUKR?=
 =?us-ascii?Q?8DaBMgtAb+WywuxvTnxSwKnVZ8qZDql2NUFKzRs+0PEVRVu1q4UAmMvMeL+S?=
 =?us-ascii?Q?Lj/m31AiffvT3rm1eDCDpq/MAz0roXmW7459uSxoVX06Q6VnM4yOPe0wFGZE?=
 =?us-ascii?Q?StioelABP9l3jbH1RBKZGl4KSxr8C5KG4dfD34mm3nsEaSvWdMAiQplWA9q2?=
 =?us-ascii?Q?gKITt+eNvuDtukAuAvWe0icdpXnFfmypfBvifmKCr9IP2zLqLtJGwK/I3p+P?=
 =?us-ascii?Q?lIyGlTiR/38gzKL5OrxcizC9L0eP8yPsFDXvQm7zmR0LpWiWRy6bS9607u4Q?=
 =?us-ascii?Q?JYDPOvmOxf4mb5kRFQYkks3kXzynMLvxdVRCm88ULTctRSOJBT4JSAKXPiGP?=
 =?us-ascii?Q?iejYV4AOF6T5srCYIEs3+oRk1bpAFVHRpcJtazMVx1HY8O1n+BPSKMNH652X?=
 =?us-ascii?Q?GtlLldvfewHnvjlnKxiAcfyFrPbWA2ZZMVYgKY8CRBk5KWnvt0rNSEfbF/Mf?=
 =?us-ascii?Q?gktnlgOsJ3RMuGxjatnwfPeow0EuURriSWIT5j+RWcapSo3TsuxexI+lI8RY?=
 =?us-ascii?Q?DRwUSZDSWr+0ZIr4MC6gJmQr0em7hj49Ww1iXayaqakZEueBQ+0sL3rZCZgi?=
 =?us-ascii?Q?GpkFpsi9QECaWagfvXnu2UCr/vWc2IyDFqKy84dh1+Iz4OHwnlmG+jinfYMQ?=
 =?us-ascii?Q?dtm/Zr4dZBEH2lCA/LX2nuC0Y0wueqlS4B9PYuM3dYWelSq1EvTSjwr8xJL/?=
 =?us-ascii?Q?EtHoqwYXLh7qrDOVT3x1QkKXjLCM4Bat9TAy9eAwOH0GN1fFbnwgJDE0w2VB?=
 =?us-ascii?Q?hDO0VDoH20vt+RH0g2QPwSOBR+pKw0d4qtNzCLjr8+W1OM86kqG0Jbv4T1cD?=
 =?us-ascii?Q?LXl6/Rabq36+MuxkAlNlp59luBKDkp3ZlXMeENGWMAS6CJLvGSVDuoDXFWrY?=
 =?us-ascii?Q?N+zAoZ+rmffA49gc9QXx0ggRNTVivf5E+0PdjZlV+unMTRitOKn5lnfVuVTF?=
 =?us-ascii?Q?naYavtp/E6O7S48hfm1VGNyFR0Kzgrdq1o3Zk/T7tTTpWa5Lz+v1qERYEDtL?=
 =?us-ascii?Q?QvFnUNzagoP87N5n3/DKbR6Ai8kqYovv6dT0SbAoUIqMAUkyq0ybv6Rf8gvY?=
 =?us-ascii?Q?+xzjPhY7IRTmFCG0L5nMFY6kZozEddueh1FU29daTtQMHiozmhA30SerMCeY?=
 =?us-ascii?Q?vdJ3VVKsN4oNdKt964BgpnCr4mAtCcKSW1vdlGCcmHXcPg08sArhkqCMW9ni?=
 =?us-ascii?Q?/nS93+1tcF1UsYcWaT4fI64bhih4NmgTd9zUTVycvAW4oCD/PFcEwllRIx6B?=
 =?us-ascii?Q?XG4KI9rnh7nVxI9A005mpQpdOLOW5Gr2yvxPxdITioLj?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0438bab8-55c4-4a1e-4fa0-08dc39430bbc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6509.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 16:25:30.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH4t4MSGMXgTi+QWHeDz7xSWfUgEdaINwGF5tNJYWirCEvg0jo5fDB91IzhVVBD42+AjL/FDedJ3EmvTTtfLoU2M1o8vCi5fTu5BDntqdtX7k5G/waRyMoruItw3eV0p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7225

AMU counters do not increment while a CPU is in idle. Saving the value
of the core and constant counters prior to invoking WFI allows FIE to
compute the frequency of a CPU that is idle.

Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
---
 arch/arm64/kernel/idle.c     | 10 ++++++++++
 arch/arm64/kernel/topology.c | 14 ++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/idle.c b/arch/arm64/kernel/idle.c
index 05cfb347ec26..5ed2e57188a8 100644
--- a/arch/arm64/kernel/idle.c
+++ b/arch/arm64/kernel/idle.c
@@ -26,6 +26,16 @@ void __cpuidle cpu_do_idle(void)
 
 	arm_cpuidle_save_irq_context(&context);
 
+#ifdef CONFIG_ARM64_AMU_EXTN
+	/* Update the AMU counters before entering WFI. The cached AMU counter
+	 * value is used to determine CPU frequency while the CPU is idle
+	 * without needing to wake up the CPU.
+	 */
+
+	if (cpu_has_amu_feat(smp_processor_id()))
+		update_freq_counters_refs();
+#endif
+
 	dsb(sy);
 	wfi();
 
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index db8d14525cf4..8905eb0c681f 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -240,13 +240,15 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	} while (read_seqcount_retry(&cpu_sample->seq, seq));
 
 	/*
-	 * Bail on invalid count and when the last update was too long ago,
-	 * which covers idle and NOHZ full CPUs.
+	 * Bail on invalid count and when the last update was too long ago.
+	 * This covers idle, NOHZ full and isolated CPUs.
+	 *
+	 * Idle CPUs don't need to be measured because AMU counters stop
+	 * incrementing during WFI/WFE.
 	 */
-	if (!delta_const_cnt || ((jiffies - last) > MAX_SAMPLE_AGE)) {
-		if (!(housekeeping_cpu(cpu, HK_TYPE_TICK) && idle_cpu(cpu)))
-			goto fallback;
-	}
+	if (!delta_const_cnt ||
+	    ((jiffies - last) > MAX_SAMPLE_AGE && !idle_cpu(cpu)))
+		goto fallback;
 
 	/*
 	 * CPU frequency = reference perf (in Hz) * (/\ delivered) / (/\ reference)
-- 
2.43.1


