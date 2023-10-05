Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494807B9F55
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbjJEOV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjJEOTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:19:30 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE604EE8;
        Wed,  4 Oct 2023 22:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwUkETit4DiIn0ywnoatas1t2leECTCqul9RbuDwZpcOq50/pu7KMUF9pPrpuJ8HWpnOXemSUiwfNkRhNLbp5utDrvHMXi3czwTICbBE1CYSYNsdD6In9dE96wqmnA1xskf8OApwAw/Sfua5ABGipHQNKCl6U+OvyuUCVdfPCyE26U+OyAN/jzqtDFhx8Hedy63vMEZim9ZqvU1UN1paw3Hv00emr8lIVoC3f7qaXUUyNnOJcsAPV3sJTZOw2efyv+vCcZgI6g93hweAJAIaoy1DBrvGL3pqNqn4uXrbNYTfvEb7VsH1bcEMt98rVksLzexLuI8BMLKrbG522AdmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMmsOE81tcPEf1TtjF3ppaSEoCx22VbO2B6jtxXluH0=;
 b=SHELh+otjLc8OwQ7sPP9+++xxEraFJ1MV6IvqWSBrfz7iQ7pF/r1Kwh1QFntf/GDYLTL9rYxxPOD7dPLSX+CQAqYxoM74qg2a0EpZzuEZGNGRcW5xwgNfwgBPKvDXSWje9s9c7DaVy4NmUOr9XTib7F5/IPlh+fBVQMeYGBhocKR6L6tMHfQKGORuGM90GFmh/PXrZGFmr2wu7x6EEvwrh2FIzr4XfrXKj3Qr9oD2dkV1QSzidO+TQ2czMl6z3fTShfaMC1zlvRLjVD7M4iIKOLFtrRsKZ08EEapFKQnKwDgH6fK8qzurbuD91dkx9J/roEbxhcM+zw5AMCBCoJcdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMmsOE81tcPEf1TtjF3ppaSEoCx22VbO2B6jtxXluH0=;
 b=Ng0H7XoRZJqmjJtQmRP1Y61TyXRIZViakPPnBW/zDrxzIvDtNvwrSAe/FhAF6IUAPYmyJwiXEUJFeCW+j1yFU2bONqHKzPOA+/+doSViqq5P063ub72mQI6AcuCH70600QeGWbl2d8kabH7eTmPqrEEQIacMKoOr9NOhd4vb0gw=
Received: from BLAPR03CA0164.namprd03.prod.outlook.com (2603:10b6:208:32f::20)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 05:25:29 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::e6) by BLAPR03CA0164.outlook.office365.com
 (2603:10b6:208:32f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Thu, 5 Oct 2023 05:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 05:25:29 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 00:25:22 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH v2 3/6] perf/x86/amd/uncore: Use rdmsr if rdpmc is unavailable
Date:   Thu, 5 Oct 2023 10:53:13 +0530
Message-ID: <e9d994e32a3fcb39fa59fcf43ab4260d11aba097.1696425185.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696425185.git.sandipan.das@amd.com>
References: <cover.1696425185.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9f51d5-3c52-48d2-a7af-08dbc5637cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWDc+s6gLUKOA8dNPPGBMtSyogT0JJieYaTg33uFDBTUEZULvsmrSZr9kyHmc840UxEvc9BkKzpX/ExMTEO1WGJYru5A6I/W7/hrDl6CxvzeKeR28nuLzkKS85PAJxa2rIlppbX8dYhBJgJEyv0OWrrfx7NRN2x+l8moNYh7nSvQY52/H4aS5BgmnVOOnvlJPqz8frX2VEhIVOA9HzsrUffVeGgrF7AIZB+TpxiGSNUc04Wa337YMi9kSoaMxrKgB9qtYpeb5nsqoPvBhAZhRNwFDBa8csXtySDVdLH2jWbB2P8PyKdtfRDo+01D3ehI0VqsD+zWkGiA/OmoUU0xQUG4MlTfHG8ovimspgae5/U92moewpbzWju/LLTfuV/o1YHeRJ/EoWf2qhmNMFbzzJ+tlixIutfzubVyhoYraxGjL+8hbjZ6hW+eWpnHYyQnXdGU/CzpW875bswu6WuJQ4taqH3x6aMZPh1UpjLmZTltHORdLgNQUHQt0z8MKJHVvbi7Dm+g9ur1v86blm1bRx1dRst7cdcYOI7qPysJCXB9r5A+CrfMtcL0MtoIDrgAAmKSwbloLjiUvTNJS5o2iI3V9AruwGQ5SLMN/Rwp5MvtFI4xlxSqstUASyb0KAngASvriHdJb8/thZn46K2CRuqYauzuKqmk18D8fvnr2ar7UeDvm8zdgESulXRnwEL6Npj07Q3ky8OYezFs2KMMxwJbBRvk7px3MA5oM2f/HXNKxN5m8dtlp1cG1OjyY5HIGAggs4E8mWrZGAYuqqle2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(7696005)(478600001)(6666004)(16526019)(82740400003)(36860700001)(356005)(86362001)(81166007)(110136005)(2906002)(4326008)(2616005)(47076005)(426003)(336012)(26005)(83380400001)(7416002)(36756003)(70206006)(70586007)(44832011)(8936002)(41300700001)(5660300002)(54906003)(8676002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 05:25:29.1325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9f51d5-3c52-48d2-a7af-08dbc5637cf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all uncore PMUs may support the use of the RDPMC instruction for
reading counters. In such cases, read the count from the corresponding
PERF_CTR register using the RDMSR instruction.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index ff1d09cc07ad..2fe623923034 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -96,7 +96,16 @@ static void amd_uncore_read(struct perf_event *event)
 	 */
 
 	prev = local64_read(&hwc->prev_count);
-	rdpmcl(hwc->event_base_rdpmc, new);
+
+	/*
+	 * Some uncore PMUs do not have RDPMC assignments. In such cases,
+	 * read counts directly from the corresponding PERF_CTR.
+	 */
+	if (hwc->event_base_rdpmc < 0)
+		rdmsrl(hwc->event_base, new);
+	else
+		rdpmcl(hwc->event_base_rdpmc, new);
+
 	local64_set(&hwc->prev_count, new);
 	delta = (new << COUNTER_SHIFT) - (prev << COUNTER_SHIFT);
 	delta >>= COUNTER_SHIFT;
@@ -164,6 +173,9 @@ static int amd_uncore_add(struct perf_event *event, int flags)
 	hwc->event_base_rdpmc = pmu->rdpmc_base + hwc->idx;
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
+	if (pmu->rdpmc_base < 0)
+		hwc->event_base_rdpmc = -1;
+
 	if (flags & PERF_EF_START)
 		event->pmu->start(event, PERF_EF_RELOAD);
 
-- 
2.34.1

