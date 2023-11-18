Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED207F0275
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjKRTdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjKRTdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:13 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E362192;
        Sat, 18 Nov 2023 11:33:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6mLTP1ft8yO6JtQxEqMQ5PHwHY6brB8VxVmEqyNhuhD8xldQgseOBB+BJ6acYgFgVXyp89aPT7qRjzYiP7o1Ol+vOwgOYL/qsc37PmmkZBvjCMJ1YkBGctNK1jAt6YHwkuI4q+5T3QV1Yj19I517W3h8Ac4NyVW5N9qwxPoTJjqgGW8MSv3dHhsZ70QiN/+iO2Crpt5dp51yZiAoinL8BfFX9aJ3bkuJe30lwBz7u2QWNbH3jWG9mQcxMpbt2D0Z9P4U+2y6nZMYD9fqsxpW9gSMRWxuNmOrbc/zStxzzWsQcsRxkVEXGC7aFMIk5eisN0gTBgRHyHQxCVKr8yvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg0iIyoSMW/Eb8G+iaTwSW1S46jeE1iIteyRrub4Thg=;
 b=AsncsHS46KiH1z0EA1xI5y8FRHtsSKG8B2LZwtI2mBCWpTCHOcwBMnZj3KV1B9la5SO7AB0ZdSPDltaV+7lRFUlDSks690z+bakEUtOQfPVkbMFEM8GtJACIL8KejDBaZs/lab9IhgnS3XH8J4DNsPmZj420LlPF1NwQTqIexMB2Qga5QZ4A8O56a5Nx03lcL4XUjp8UatzZCJUgnF2D5DyDqFlvHaumQGZohcaLsccEZGZX1o/qJWM6zXYhMKrkjvWpTzgz0yOOb0mC4jXaAeNSzMqwTib41oyYgwHc13+tP4GjEvMywd5bGlYBcSTpitam5NNp50XnpjCrw7YYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg0iIyoSMW/Eb8G+iaTwSW1S46jeE1iIteyRrub4Thg=;
 b=wKScch4W24vkJcfuUoUJAKSWCYS8VCsjhzztHIIssRPGNVMewGWLwFqxzqEFk9tzh4CJP8YISb3+J5jTdzeoLRjrMUghzDX06NdcJr/d+eyHJwMza96zCmMswroog/IBfL5xomlK+eDxj+KtwTJr17/JHP5gEKX9oXI+EhTWbKY=
Received: from BLAP220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::15)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 19:33:07 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::91) by BLAP220CA0010.outlook.office365.com
 (2603:10b6:208:32c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:06 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:00 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 01/20] x86/mce/inject: Clear test status value
Date:   Sat, 18 Nov 2023 13:32:29 -0600
Message-ID: <20231118193248.1296798-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118193248.1296798-1-yazen.ghannam@amd.com>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: cbfb31ff-b962-4960-8b37-08dbe86d30a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8pEkp5tF/TMTtxQqMGdQfLIsa/xjb415jSQPlD7JTpzTguvzpWapzk5PPn4iVHx4p2BM5ix9OrlmgJDP9b1KtXr39+wrz+9VmiieS3JEi6Pj1YM7p53pHG7EWfh3QIC+0RyZuhtfa7WEGf00HmuezTtje95vZg3EOVioHUP2AQxWARm92B8rFtng65IpfYDtYXfovSEFhjwAUTlmN1okICw09IUl+kh1AF4rPI/MPN98LTU5gmyYmvHYpL6mVIf9oMqyhnR7TcSo8/yV4qL1ezRJkKRrITW8vAtPaKDPmwngUtFL10PXj2pgESwjt5GA7w0GD+vGCI2gPYhG38W4uHX1B8hcuMKxAZXw36VEBPlgJwjxGDh15PlFuBaYOMIzEVtR7oaBdKBpIb/jHRq40EHR/8MuUf4LYE39pEVlirDwnc7X8eA/lWHQA+Q9RxEX5yxgUlztLbH//LTj/f60JyHU4Cvw2HN5RIFRh+fN2uNC53Oq+wpO3TeaRIh2Wj+fRIrKl5yOwoURsacgaTlJhX67DAQIazP9tVjBTL0zjcmdVl46wcKLkTu2FAqPp0mwMeul6KnW2AJFRPAs2ik1WwYng5KrSrRPCOz6F1lqkhXiQ4IPcHgJ3vopDkAiASpZbMr7nhcCnZLBcAZrOn8pGCLrFZfHQZLMAFOMcxk7tRi4s4a7Q5gZij4blO6eQmcmb/t88/4iML3tEXD39N4t6yKasPwB0nZEro6vvrjelaolESvdOmXtEGiqEvoMNGI6kzeI2DDV/LdmK3DFKaRByVlQ9OYIYmlHpRFODiw3aQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(70206006)(54906003)(70586007)(316002)(6916009)(7696005)(478600001)(40480700001)(36860700001)(82740400003)(6666004)(40460700003)(26005)(2906002)(16526019)(2616005)(8676002)(8936002)(4326008)(5660300002)(1076003)(47076005)(36756003)(83380400001)(426003)(336012)(356005)(81166007)(41300700001)(44832011)(86362001)(3714002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:06.8085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfb31ff-b962-4960-8b37-08dbe86d30a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD systems generally allow MCA "simulation" where MCA registers can be
written with valid data and the full MCA handling flow can be tested by
software.

However, the Platform on Scalable MCA systems, may prevent software
from writing data to the MCA registers. There is no architectural way to
determine this configuration. Therefore, the MCE Inject module will
check for this behavior by writing and reading back a test status value.
This is done during module init, and the check can run on any CPU with
any valid MCA bank.

If MCA_STATUS writes are ignored by the Platform, then there are no side
effects on the hardware state.

If the writes are not ignored, then the test status value will remain in
the hardware MCA_STATUS register. It is likely that the value will not
be overwritten by hardware or software, since the tested CPU and bank
are arbitrary. Therefore, the user may see a spurious, synthetic MCA
error reported whenever MCA is polled for this CPU.

Clear the test value immediately after writing it. It is very unlikely
that a valid MCA error is logged by hardware during the test. Errors
that cause an #MC won't be affected.

Fixes: 891e465a1bd8 ("x86/mce: Check whether writes to MCA_STATUS are getting ignored")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/inject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 4d8d4bcf915d..72f0695c3dc1 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -746,6 +746,7 @@ static void check_hw_inj_possible(void)
 
 		wrmsrl_safe(mca_msr_reg(bank, MCA_STATUS), status);
 		rdmsrl_safe(mca_msr_reg(bank, MCA_STATUS), &status);
+		wrmsrl_safe(mca_msr_reg(bank, MCA_STATUS), 0);
 
 		if (!status) {
 			hw_injection_possible = false;
-- 
2.34.1

