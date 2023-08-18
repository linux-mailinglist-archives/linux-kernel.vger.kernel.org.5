Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43772780B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376685AbjHRLpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376641AbjHRLpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:45:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8A630E6;
        Fri, 18 Aug 2023 04:45:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5TZxKfiP4d9BIcp2J0uKlfcU2SO81AL1qKv3OTdkbaS3itbhDW2fS9nZ7mksrqe50RFCVG9UmhDsdJTiwnknUFq3ppre0WNKjbcNlB053Q/UkKztXEsMcquM3+x6r5fuEGPnRrIpn2ArY23D4K+LUdEuZ4ma8Tcf6+Xu93Qi30dV89RUkbIb8FyaJ3M2X4/zLqZhh6OBpJ48bKlT48wWp9R6N0LvZIGPMNK0ysLvPyW2Mytjlmcet9FeqjjUhDx8jfTGJo7DcgeVN2pGEhgrXuZVcpFtR8uXtVwkZ97gQ+tkhAgco+e0Ettf5S/iqGNP+0uUR6azVvQhuFAOeTykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehMPB++HnOCniXs/A8t9+3ulL5SCXn9pcfNgvJxIOdk=;
 b=lnd8fGth+NmLqbykDKKQPWoI+1jcr+/TSrDn6UlAOUfQwEH/IgaUmRSpcpFvrXTbLd4xBuNq2101EaFLb3VB3PFvd3zK5NaNv3OTuYPEyICNLXwBrdeXnl8r3m1HiI3ejhcZwsj+/jf+lWhlqCgp7FebBBYLIrshl9pS/5DuAbJ6GzEDlkRp33ZCsIU8YC7wsCTYN+7nnmPwCQz0SD422OuZGEgalQkygcPvSxATOZS555FOJs6D+CL0FmlK7R5Yf4ZqBkxyYZ9+yDxxfPOec6kM7idO09nIJYsWlsTYAjyLXeveiLVm/KjK+LnFVYtWZ+01XpOP/+QxCV+fvqtT4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehMPB++HnOCniXs/A8t9+3ulL5SCXn9pcfNgvJxIOdk=;
 b=G3UW/nHUtRi7PN5BdvtUocBpJBeQSSGGlqe0Cc6T+Xqrc2E9jm4CjTsqx9xbXYWkC6elPV3TlioaY4MxFZdK6tIdJ95kXlRwiPKhL6EUuvBPmKGKy/6y6skXJNOA1syErqGbjC0eBnGVkmGloVuaowXFdvni57c+wjZVN9IrxTE=
Received: from SJ0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:a03:333::23)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:45:26 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::7f) by SJ0PR03CA0108.outlook.office365.com
 (2603:10b6:a03:333::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 11:45:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 11:45:25 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 06:45:24 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Meng Li <li.meng@amd.com>, "Wyes Karny" <wyes.karny@amd.com>
Subject: [PATCH v1 1/2] amd-pstate-ut: Remove module parameter access from amd-pstate-ut
Date:   Fri, 18 Aug 2023 11:44:51 +0000
Message-ID: <20230818114452.66780-2-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818114452.66780-1-swapnil.sapkal@amd.com>
References: <20230818114452.66780-1-swapnil.sapkal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b805dad-38bc-443b-3e90-08db9fe09d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TrPTbyR9Hh8YLbJQtVuXM3OBNj/i1RDd9a9PJsJ3DoHJPVBhkO0ZxTfxy/EJ2jXVL2eQtC19YaYg2cAg5Akq5KMa50XEJJ1u8nX41WsW7OnxMfefyNHBUdomghQP/f7hOvfNuNYIWZcwu7Ay3ta/bTx1E8xpaduEGL6A/nRFacxtKJk6dGuF716H9BkmXcth1SVggJ+xcrRgkDPuZayPOVf9ERp6to88d2zw28LqEYJDcfSmKYNEaYxkF3Oosdjp0ANt1OoaGGC6pc+332KIj32r14wz4gX6VuJj41RLDDih6bjCmUfq7mXIFTmiiDgquoZ2+GaRNcc+K8ey+23zEDh/mAn+3HWG93zTtaW60PjDcF7NZFpueff7Ey+0qst2KWe2rRrz47X4xunEDnvbBSr+xExusvG2qzrcicTMWIKqXVr22vDYDEP3r2mlb09pc8yCpRV2u+8Pfz1SKN/ckbokJVhyLeH+5xx0jbhfqPo+4SunoBHrOMyQAZ9PWue5QgdMcSZJdcDzVwNhZkRk+Or5762tI4yyKAJNjVfzqikooj5rCdRcR4xP+Ivxu968JQ1Xg8z84KAUiYK4TmdFAMDPbaOahuvXpd210K9rMEv5Sjg3ARPFaeGOrVb7oalBT2Tjo48BYMy7Jfyf5e93Pj1zQDqfIlAfvG/8UByzE7KhNjwge6e3+FnQBvW4zydaIst8Jsd6VCXSyV90f/ElDj25sihb6G/ztKnnutFdIAQkV4dkflaCvo6S4UBUSViFYw39XnQkE+9YrBHSECps21zJLkLrWRXe0SkrukLv5SI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(86362001)(16526019)(336012)(426003)(1076003)(26005)(40480700001)(83380400001)(36756003)(36860700001)(47076005)(81166007)(82740400003)(356005)(2616005)(2906002)(54906003)(316002)(41300700001)(70206006)(70586007)(110136005)(44832011)(5660300002)(8676002)(4326008)(8936002)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:45:25.8178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b805dad-38bc-443b-3e90-08db9fe09d14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In amd-pstate-ut, shared memory-based systems call
get_shared_mem() as part of amd_pstate_ut_check_enabled()
function. This function was written when CONFIG_X86_AMD_PSTATE
was tristate config and amd_pstate can be built as a module.
Currently CONFIG_X86_AMD_PSTATE is a boolean config and module
parameter shared_mem is removed. But amd-pstate-ut code still
accesses this module parameter. Remove those accesses.

Fixes: 456ca88d8a52 ("cpufreq: amd-pstate: change amd-pstate driver to be built-in type")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Meng Li <li.meng@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Suggested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 7f3fe2048981..cf07ee77d3cc 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -64,27 +64,9 @@ static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
 static bool get_shared_mem(void)
 {
 	bool result = false;
-	char path[] = "/sys/module/amd_pstate/parameters/shared_mem";
-	char buf[5] = {0};
-	struct file *filp = NULL;
-	loff_t pos = 0;
-	ssize_t ret;
-
-	if (!boot_cpu_has(X86_FEATURE_CPPC)) {
-		filp = filp_open(path, O_RDONLY, 0);
-		if (IS_ERR(filp))
-			pr_err("%s unable to open %s file!\n", __func__, path);
-		else {
-			ret = kernel_read(filp, &buf, sizeof(buf), &pos);
-			if (ret < 0)
-				pr_err("%s read %s file fail ret=%ld!\n",
-					__func__, path, (long)ret);
-			filp_close(filp, NULL);
-		}
 
-		if ('Y' == *buf)
-			result = true;
-	}
+	if (!boot_cpu_has(X86_FEATURE_CPPC))
+		result = true;
 
 	return result;
 }
-- 
2.34.1

