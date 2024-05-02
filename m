Return-Path: <linux-kernel+bounces-166254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDC88B981D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E935E281EF2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A4F5644E;
	Thu,  2 May 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uGL4Pcli"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923C56457;
	Thu,  2 May 2024 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643546; cv=fail; b=r14pCwJk7nn46gkm8DSpl3HIBHIZ27geYhZ1SYiF7cCZ8rz7UiyqyafcvuPKWtEkWLh/W/deeL9QKiSXavRExAGkkf/1RjES5A8Yd5+BFvJMXlE44HQx+Wt1h9IZ4uZ6qx8sVbGizeY/3uaahvL3+d0rE/5AXsHK2idZub49z7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643546; c=relaxed/simple;
	bh=2N2jgjeRvlkvRwKuJxy2t1VcU7YMAAwQWYgfp9ZPaog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbBeS4ZE4xqgbZZ1M0OHOtAov3M4+4NhMrt6fQK/4eC2DWdunNgyIbovRWsWqhtnh0T7QkjTof6IXI8ccJU5+Tpmk+OV2q2qE8T3HZ7D303M5dLPptfPOn50uP9C/dZz/BM6hcfJmnlbEI+2PBC+8YUXP4sC8QKA6tMTJAtQuLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uGL4Pcli; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TK4kAkwy9C3gLBLe2dRAshSsfV9JKeBTgDxpysBjyJFgD2AWDiGfIpO7wjDNQK3o56bYuYe9ssW3dNZMon9K93nBtC3Ur3B9ERhajhAz2iPhNbaAbGUYteDdxeDOdOA6VnUGXwBqX2uJZDWj1lqsOCfvEBvNGYqxSyh0rTW+KkxtSDRwNAJuP9EnCpZq13R45NUJa7HpvaPpBTiWuB1nW0uvh1LRyjGpzEl3OCHjA5Q64FL+XHNchVSl3uTu9liIpXA1wWv1ENgiBflmjZVlwjnCndvaSg8tfgVNj73gewOVm2tsEUD+v1sCQcpxG7ByXOVpb6ZagsGtlZ/dHk+N1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEq0T74Gtb7GxQDw45fVad1A7xFMktKnnuy/2pzmdSI=;
 b=TzM02VQW9PDTVxQ5BOo4fcb/KajwWbaP2TGYGm8d/kt8CeXCzoa/8dAPbxM3EvW4z2FkGxbGY5wG9Zm/h6QrmoJzlkrQ9uNj8gm8jj6SA9WaGjNQ9MnzJtox8bYPKnMbBu8zXkeZtVNqbVzKCGUNFi+FAmMEqyccVjpNtZDrBKU+7Wci7+Ufgb//IFWm23kcx6znEU8P+2ON2B2vT41DQTaVWPPS4Q61sepVHR+oQspo4eAahoZSUpVsHlCAobO7cLCs6ki3lfYtC0ku9lsdWHweQfRl7DLTjoJlLPimrxS/wDwqVJ4RxIS1y6rbM+aVHD48DM44fXqRl5Bz2maGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEq0T74Gtb7GxQDw45fVad1A7xFMktKnnuy/2pzmdSI=;
 b=uGL4PclioGkr1Qs2F+ezZMTrJoha7M+jK32B0YLBD4a77OKdK+NvGHFdaqgCJvWnNZuV05i8RB8LyndRjiRtxBLrgYsW4Asld7IAGfzJRisu82fJoeOahVC7GNUuSBXBSJQlUWQxkakm6P+PJjua/IboeFf4P74drJLrMz/eV4s=
Received: from DM6PR07CA0101.namprd07.prod.outlook.com (2603:10b6:5:337::34)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 09:52:19 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::6a) by DM6PR07CA0101.outlook.office365.com
 (2603:10b6:5:337::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Thu, 2 May 2024 09:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 09:52:19 +0000
Received: from BLR-L-DUGWEKAR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 04:52:14 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <linux-perf-users@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sandipan.das@amd.com>, <alexander.shishkin@linux.intel.com>,
	<irogers@google.com>, <gustavoars@kernel.org>, <kprateek.nayak@amd.com>,
	<ravi.bangoria@amd.com>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 1/2] perf/x86/rapl: Rename maxdie to nr_rapl_pmu and dieid to rapl_pmu_idx
Date: Thu, 2 May 2024 15:21:14 +0530
Message-ID: <20240502095115.177713-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502095115.177713-1-Dhananjay.Ugwekar@amd.com>
References: <20240502095115.177713-1-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 49420e95-41ae-478a-4743-08dc6a8d8e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WRDUcdFDBX7ZjpUBHhXobVnQcGsySiXWLmgWYSnv/aPIobzWl34ligdP2VR7?=
 =?us-ascii?Q?40TFm57P0+dcgiqfP2sfWlHNX5/bS0gmfnUunwm186iy8ApOOZSWahmI82ZA?=
 =?us-ascii?Q?mQo9kebhq6q5Ih8oy4vChuLd/Dq87yIbjPi+3RB+6d3o6755BUw8HidRcH+G?=
 =?us-ascii?Q?OQgSrkaN/dIQtlMfLlC2ORoXxNCnaiszPu45Vvb4BECyNkk5R69mGCssUL18?=
 =?us-ascii?Q?edvjTICA32GF4MCW5kUi4ytLVBFjejajjc2TGpQ+C2AldT3nrQxfhla2F/A9?=
 =?us-ascii?Q?wSF2QSveNKC6AWdQ9loIysAwcTvmxSdUu1jDLec+KOeT/DjGDWiBypHVEj5u?=
 =?us-ascii?Q?3TpigAEpJzKTGYOo1OqmeOFvPUegopHNEs2TKZ1KNgSztoAxreI8uOoYXCq7?=
 =?us-ascii?Q?6yLXl7nZm+5lwXcCsiNA1I/stcIcoQyQ6y/1we2hzNNdMDhr5+CYE8GSieBf?=
 =?us-ascii?Q?Onpza4jeuXo/N+9oonsKJv482V4LdihsTP6HZ5VSIFVZVta5YKgoQBfS9M4F?=
 =?us-ascii?Q?PCdK8f4XJrzHjXtukQ8rOaGNmAEUpFZ3C3enjJp+loC92ZnHU9c19A5u0Aek?=
 =?us-ascii?Q?Qp7PbWVMq9huWxxFbtrS2Hsu/VkLgutZNNwD+91NNNUPwt+XEgAxmjH/5XBr?=
 =?us-ascii?Q?g3u2JJW/cYfZtjYUP7dcil8rFNZCqzVaX23TeMaScjk86rjylnBSKNQ0jCeL?=
 =?us-ascii?Q?ABWZQWZEYVFDuwV0ZWLZm6tiXoJcX8OJfWrH8P5SmlFQkH2bpq1QIJbnquew?=
 =?us-ascii?Q?foXgUQTRHAPoDVFq8gmI1ZvvAqwv4JBNPqw+lhhGDKh0rWG1fKwMfs5Ls7ve?=
 =?us-ascii?Q?t9IYclmjkgIK6RPD3lyZd5PqzQoRQqkffxxU1E9XBG+2pm4SKnmxMXk6+Xhj?=
 =?us-ascii?Q?RZ75yg76Q5+qD9eq81oz4HbmROAv+FGVEuf5zsvZAP6RxOSmmN9KfZzVGI88?=
 =?us-ascii?Q?pQXdhJcglS+D1Z+Vx+wJTwnDbg/mYccIitd2KNwZcXq5ROJ09sOOHSYYR0NV?=
 =?us-ascii?Q?dsT01acjxWZmgld389QUZcVAKCmm9+zStlnVdAs0x5o9b9NWIRtdFwgMFJh7?=
 =?us-ascii?Q?tCFVFztC0yMjE6kZOa3Y5PKldqRXzMLDZI55R53zwGZBxWnqX/oQoKjHSY3A?=
 =?us-ascii?Q?zULb/QeZxr8f8gB0f9vsuDI3yXYSobe5stliPeZasIyJBHko/XlYlQOWf6CC?=
 =?us-ascii?Q?H70w4utAGkhqbVELlwjX9kjHQGhST4kJ7zz3ytk1SQ9YnF2uaZ5U7sCaL8TC?=
 =?us-ascii?Q?Y/ju3+TonA+B31UGcM4TNyCrZLCQcC0QumWi9t31tARdIJ3Io/KTzbJNT2pj?=
 =?us-ascii?Q?3jOEnZ2FTeGY6HL/L0B6bfW/enc1LQOyOG3Kw6cSW8PIMmHCcv0AmbT4ZDTp?=
 =?us-ascii?Q?fY/zHEn919Yit6XxDXUI9ai15QZn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 09:52:19.4526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49420e95-41ae-478a-4743-08dc6a8d8e9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275

AMD CPUs have the scope of RAPL energy-pkg event as package, whereas
Intel Cascade Lake CPUs have the scope as die.

To account for the difference in the energy-pkg event scope between AMD
and Intel CPUs, give more generic and semantically correct names to the
maxdie and dieid variables.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/events/rapl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index ca5f687fa420..46e673585560 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -114,8 +114,8 @@ struct rapl_pmu {
 
 struct rapl_pmus {
 	struct pmu		pmu;
-	unsigned int		maxdie;
-	struct rapl_pmu		*pmus[] __counted_by(maxdie);
+	unsigned int		nr_rapl_pmu;
+	struct rapl_pmu		*pmus[] __counted_by(nr_rapl_pmu);
 };
 
 enum rapl_unit_quirk {
@@ -141,13 +141,13 @@ static struct perf_msr *rapl_msrs;
 
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
-	unsigned int dieid = topology_logical_die_id(cpu);
+	unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
 	 */
-	return dieid < rapl_pmus->maxdie ? rapl_pmus->pmus[dieid] : NULL;
+	return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->pmus[rapl_pmu_idx] : NULL;
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
@@ -658,7 +658,7 @@ static void cleanup_rapl_pmus(void)
 {
 	int i;
 
-	for (i = 0; i < rapl_pmus->maxdie; i++)
+	for (i = 0; i < rapl_pmus->nr_rapl_pmu; i++)
 		kfree(rapl_pmus->pmus[i]);
 	kfree(rapl_pmus);
 }
@@ -674,13 +674,13 @@ static const struct attribute_group *rapl_attr_update[] = {
 
 static int __init init_rapl_pmus(void)
 {
-	int maxdie = topology_max_packages() * topology_max_dies_per_package();
+	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
 
-	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, maxdie), GFP_KERNEL);
+	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 
-	rapl_pmus->maxdie		= maxdie;
+	rapl_pmus->nr_rapl_pmu		= nr_rapl_pmu;
 	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
 	rapl_pmus->pmu.attr_update	= rapl_attr_update;
 	rapl_pmus->pmu.task_ctx_nr	= perf_invalid_context;
-- 
2.34.1


