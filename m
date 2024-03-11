Return-Path: <linux-kernel+bounces-98472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C39877A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745701F22001
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349E7AD55;
	Mon, 11 Mar 2024 05:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ddLmLAtz"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F508F41;
	Mon, 11 Mar 2024 05:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710134683; cv=fail; b=VglwWmQGkKSP8tNmdOEYsMhjZyMgNSLs2IjBF4B8Jtjd33dXm5+nQGXdADYWTvroZlkdc4IsSRu2wLvSGhdBYmyOmY5+RT0GXqBbi3fnEScck7ADCrPlp0qZMCstjdL2BTtZxFZLip2mgVKH3Y5iQJB/jBW6k8BbWAwGHQ8w7Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710134683; c=relaxed/simple;
	bh=c7mMz7j5eqNzDsYdI9i/1xeTvHwUJtd4U+vRziKY3w0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWAmef6g5Ce7//RjdYesrgcYXkJKippHwRmmInJp+vpBeNClFgk6ZqJZnfS7tYjAL4uNwy3bmbG3/+ughcAiVw04pYHR224PeFdRQG1cGq7c5agaLbDGw8pB5R7b80+mHmAXqxlSTETbBeBv2B1jd0INAa6UtjweOg8hGix/lJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ddLmLAtz; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYYlYRaf15JOGykUJ0AJERETICHHs+N/8J0aXi3j8g+6i4RE0D8EOAco0YznngvtPxfzeMM3UkN9ICSceRPtN8tloXVx9zRHRmc3sIgHd6WpNOqXlXvnxmV6bBEKV09eGljOnFVOZGNgxSNiLG1GQpVqVrIVi5JAxKgucLw+jBnbeDUyVNXSynI73VUgwvHCl2YagA3J6SNautWZR95KSEyyx/1uCPoEO6Ac9qOPV1pgYf1dWcqPEULO+woVVOxXWLhnrYqep365vmU/p6qoBduhOqJ+HF4fPhwI+rVJrKbyebU9jPWmraznik0fcg0S4TWYj7E+eNxz7I7M8xPtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfzDKeQA5XkrHqDNhSLBVrz+nQgoHbE9WhOKU8RuJlk=;
 b=OAIhmbeypHLMT1FajkLACt/negQcddn02R3GkTORZTj4ZARkLATKz/7OMlW1L3BU+ihR6a3MJavhpVjNvOp/f3rj634gi7TpT5pa1//NZe2kYRgXoanApewAQ5et+1DdL8UpogviZ4QUICmxgMklH3m+EYkwRIlRAofggYbVvFp1pRi/xbqPl4jwqvbR2q3MM1FDAtlvmsvkwgZgPgg482cOHh089JdRNEWp8IfSVr6KAE7KpBqAf7OA1XRcwcdNap/FrsI6L+kH1cc2iqGxJDc0VRw78LQyPGQaNXJ7h06XDwAeB7UDfeqkW12h1LvItX4MW9vWaSFRCMIT5d11yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfzDKeQA5XkrHqDNhSLBVrz+nQgoHbE9WhOKU8RuJlk=;
 b=ddLmLAtzvy7JFcDtatGKi05Y1FVtwCHuhnrrbnY4DncOY9/v6jj7WUqSQVI2tSt/wKu2nPFYFVED6IoEmm1wNb/lN3gjGFy6onKr0eZekQC7q9KBG+fCaRU7+JZeXSK5irQ1M8C/eGq/bo1bfnZQJvRmTvTIJY1H6F9kdjzVFPo=
Received: from MN2PR10CA0001.namprd10.prod.outlook.com (2603:10b6:208:120::14)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Mon, 11 Mar
 2024 05:24:39 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::98) by MN2PR10CA0001.outlook.office365.com
 (2603:10b6:208:120::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 05:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 11 Mar 2024 05:24:39 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 00:24:35 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <eranian@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 4/4] perf vendor events amd: Add Zen 5 mapping
Date: Mon, 11 Mar 2024 10:53:18 +0530
Message-ID: <802886deac171056ee89f2b1aa17888ce035778d.1710133771.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710133771.git.sandipan.das@amd.com>
References: <cover.1710133771.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: ac76c8b1-e877-45e8-fe22-08dc418b8cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	moqdZ9PMQSRDRv1G5yKBs3W4Lbko10rN66UE9vSQl6814O+/EhhdkxXP+Y3mH106SYW7uU+TMMoVjR/dIC+o8l0IxpQaVM4oeoSB5GIVhsoQv1AlV6L296hal2/XeB1gNHJGnKIt+qsaUVtN+kAsFhs+UW+K+EHmVyKxkg0uivvOpHC42tJhf6KgiXs7u7pIG9RdGFAP4JAhEAi72GiPrsFfNQ5SVic0cFT4nM7yNKKCReAA8/j0B9HrIHhsE4y0WQGMGV8pthIhhEMorVmiNAU5ppuheGMoYwymzK/Di4qFwXJPIUC3xaDw4Mgz2J8zKTCuWqRnooPdw5Fnee9vzLOijIdtZaWROXuAD/SPI2VdkCmR8wh4uO6dHLGo729WnJrgpaRIYSc+mzDM+U6HDLJFCvVEYsE5b5hFcWtqdclBBZoHTjCWlybYWTZOpSWG0YpmLgTgymH4Ars4Ul+DnvNfa3nSuxpe6irfmzqRKtJS6pgEERfTKx7lYRvNrF3RBu7XUK1rnHRRlYoktHhIZT5uHILycrsIxWYRQs5wZNpxV6+2/mTju9Ovav5ui3GRbqmYLY3C6dRRiANzDbsQu5aOb71UsKMRxtwwBl3EHbVY48lznbI3D0L1sCvZIyz0bPVA3UgjKVl2CPLyai/8ooMZeAKHhBUSHFvlp/6HVvkZOehXK7P53B0weFPxWdozUQjIVYrywt18XdaljE2tzAMdQb3f3J9My8NsO0V5D+uCsyYEwbk47IqZAkadxpuH
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 05:24:39.6164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac76c8b1-e877-45e8-fe22-08dc418b8cb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482

Add a regular expression in the map file so that appropriate JSON event
files are used for AMD Zen 5 processors belonging to Family 1Ah.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 5297d25f4e03..3dbda6317921 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -40,3 +40,4 @@ AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
 AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
 AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen4,core
+AuthenticAMD-26-[[:xdigit:]]+,v1,amdzen5,core
-- 
2.34.1


