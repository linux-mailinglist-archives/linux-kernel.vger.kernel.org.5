Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7560E7C9F46
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjJPGIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJPGID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:08:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2835295;
        Sun, 15 Oct 2023 23:08:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PA6PGZbnF3M2X3lGDR8/JLE4oSXzkd0JTJxD1FL8yvxcQ2yWfzZbKuzLLSNs7CNkVldApHf5hqpn9Md9AxwwcBTPpuKkQxdvJBaWa/datD8ka6ZpDA6hA/9kvUwWMvhNjVSWfwIqLXqAOp5VrWwCmnm5FbBDusWosNksHfpmMwZM/s1VvsAgXw/8sEgzGDPdw1k82G1ELHw8KS7sHiJ90uQRKNLD8hXBzzMl03KXTR/hxFShe4eXLtG46TELIxTyV2eNqnb2BfWo+sixzgPrKrH5OhwpqxWaWtbvfPUib2uRmpax5UsuTiUWNdNgy1mEuEby9hTGYylQkygMEWYl8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taPnpg/eUyd3vxkyWZWGg6rGocLvm2iX33S6AmZyBvE=;
 b=nTvJ2Hacs/pJFBv9FikWVEhODh3K2vv14HNtzUdgD+T2aQPItl0QtUcSrWoTbuPs0V8PF2ymS/B/7YanMq/2CqWdxrNmrocoxKrCeezzQfZMheXR4sPKZ8JBJWZMTYTNHRc5LpgO0IvThPup+uMebEqDVEvp5no13wJ5kZSw8BPMz4yPyuAjaBEcy8cHD96Ey77rSpQXg2JWJTThxD6Dm75aLV+r5IiNIJpiqfs23A7FYd/TNLutEHK7WZZuvC0ihBDr9ulGlpUSnniZwelGgvl+swTS2eiqvo1txLrYrAUYe6vEqaLrfkH1DPKpqPcxZsbsfreIOkgpAAWdgxXnkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taPnpg/eUyd3vxkyWZWGg6rGocLvm2iX33S6AmZyBvE=;
 b=WqbEz5YdCOpn55FeOAKbMC8pU2ewf0UCMgzULONnFtrrKslqFd2lVEiV0C1iSxbIZgqZ1DCU/Zii0vBUnQdeWl9TgrTsW3Yxf58BqHpDVQ3EIc+PPisFIhzpnhwvQlUuR3hLoCOHdwln3Wm2QgatV/Eehyzg5H7kkexE4H+K6s4=
Received: from BY5PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:1d0::36)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 16 Oct
 2023 06:07:58 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::ea) by BY5PR04CA0026.outlook.office365.com
 (2603:10b6:a03:1d0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 06:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 06:07:58 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 01:07:51 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/uncore: Fix return code for init
Date:   Mon, 16 Oct 2023 11:37:43 +0530
Message-ID: <20231016060743.332051-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e0bb4e-857f-4718-189b-08dbce0e3f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDqkyEW7vyZMI1lTnQeaHAGz4oCnEe87/TTYCp9XNeh3Acb0//pYPOZtVRlH/xQS0zLWrA364HtKksOVKeIqOHbxZAn52G6RUcPZ/GE2VEEMIJfTWqgmspPOTW+Yo2InQZjevamVMEsurTclZmdV7mZq9KdP4xS7MqL4m8m8JPhLN1vO8f7JiMMVOPu1jCGDacpApSJHxyxmgNu83N9mtYvvNOvCl+Me3kmbXaN+ZOb2OVO/kVoj+DPQgsdm/Ga2oqVMtbH0MNM+fTJ5hz+rTwDFL0hKnoTakbSyAsp4DsWM+Xyizl2UJSy8C1wiALYXic7lk2EPoOmHxghM/d2EmSiTlyQNwBNy4CnSp26u4EFED73chosIWnUnby5U8DBEXihJ/1EMk+92FQa5FLBov1qxkUqiOWYapHdKeDPyGfcM8mWKsOtO7jPz15Ityip8qaP2OuQT5sl4/AHeRdNetOgp+i2ib27s651VBpmj0hyClRJdIym+P0SY1wz1QRzaGCDFoJp9spRfcXADreycrLgEziiXSL0aTFWA8pGfRvtae5MzGwUUXrdvn+FTpSbOwD5knKf4eL2sirNMk5xxRF3oZmpXlmeM6hrefMVjRrQe2uJ1Q7YXSwv9bcXIrxrOLxPPi9lgNKcB0mjTr0z4FuHAmw99xLcmpkcrxBxl+SNIOYngzyp4XjNm1NasNr0we+p7/sK2g28Cej5fYdBUKgE6xuU79qKehPiJekaYwlZy7DQRtUaG27Xd8GiRbDBcrtgZT8AL0bk08VwzkmZq6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(2616005)(7416002)(6666004)(41300700001)(2906002)(4326008)(44832011)(26005)(426003)(336012)(1076003)(16526019)(478600001)(5660300002)(83380400001)(316002)(40460700003)(47076005)(40480700001)(36860700001)(36756003)(54906003)(70206006)(8676002)(356005)(110136005)(81166007)(82740400003)(86362001)(8936002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 06:07:58.4116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e0bb4e-857f-4718-189b-08dbce0e3f0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return the appropriate error code when the registration of hotplug
callbacks fail in init.

Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 91f01d6c8f7d..7d768dd01522 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -1039,20 +1039,25 @@ static int __init amd_uncore_init(void)
 	/*
 	 * Install callbacks. Core will call them for each online cpu.
 	 */
-	if (cpuhp_setup_state(CPUHP_PERF_X86_AMD_UNCORE_PREP,
-			      "perf/x86/amd/uncore:prepare",
-			      NULL, amd_uncore_cpu_dead))
+	ret = cpuhp_setup_state(CPUHP_PERF_X86_AMD_UNCORE_PREP,
+				"perf/x86/amd/uncore:prepare",
+				NULL, amd_uncore_cpu_dead);
+	if (ret)
 		goto fail;
 
-	if (cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
-			      "perf/x86/amd/uncore:starting",
-			      amd_uncore_cpu_starting, NULL))
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
+				"perf/x86/amd/uncore:starting",
+				amd_uncore_cpu_starting, NULL);
+	if (ret)
 		goto fail_prep;
-	if (cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
-			      "perf/x86/amd/uncore:online",
-			      amd_uncore_cpu_online,
-			      amd_uncore_cpu_down_prepare))
+
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
+				"perf/x86/amd/uncore:online",
+				amd_uncore_cpu_online,
+				amd_uncore_cpu_down_prepare);
+	if (ret)
 		goto fail_start;
+
 	return 0;
 
 fail_start:
-- 
2.34.1

