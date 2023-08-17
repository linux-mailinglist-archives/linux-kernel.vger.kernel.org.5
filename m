Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C140777F353
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349640AbjHQJbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349696AbjHQJbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:31:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF3F2724;
        Thu, 17 Aug 2023 02:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlHn+apm7t6GLvqr6ZAyuxMaFTKBGR4bFvO82ciNhlZeB94/qG27HttcT8ZVz8M4Gr2f78CP/gSCnmPo7uZySBTmk9Bd48HDe/wA0vdo40PLEsKEc8+TJJH9QkwaksIyhrDvPrRgz65PiR4z22ioDfy6xMkk5uR/xCn1Vfl7nmCJA+g4UW0SVXIvS5jJJgXGqwfCEenes/alUbegeIscotxFKFRIq/Dkvf3F9QJH8f60Gr41S9VzWXaf/SdIGh3XZDn46kiTA8zHIuIKSDjytuzWa3IxvCFGXDlqtb0xbGHZBS0niNzEqxWQgq6VuWG6c4d1bIeNEIuwFQQIfWcYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQ8gjrZeCXu+h+VF4+kMAq0ZDLY1cyXuEghXR1lZBj4=;
 b=fR688VN1gKZu7WTZ9f8ruw3taEOzZ/cr04e6AqE4JySXncb5XHh7WV/dXtEQjnoTADLS2a8wMiimoyzR4FLGt8auLnGe0ELz3Cs6HptSx80/DrbDYeKHJXkVX0COfLeOO/Qcsho5kf81xew12Mn7AgqVyApWFORWpxvNP8/EBtyaoR4VHLLtJOQ5w3zaVZHAUObC6c2gAo3P2j3cQzWlmrvU4eifgWfuq4AIqlz1/oX22Q1pR66DYa8QxUQiTDqMzADQM+3jnT/1Dr82jiMGQNu18xDCfhfl74yIozlKetDn7O6QAG6Mb1RhBIGFVFhz4SmqlamRPdSNPwh6sTY3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ8gjrZeCXu+h+VF4+kMAq0ZDLY1cyXuEghXR1lZBj4=;
 b=ZoZPkEEpUsaNQo6NHEvGaNvL3Ab3WzVdLpiDs0Q+OM+p9v5+5lEQUOyrlrMQOVegNu6jnY7toOupvFEX/YSJZ6yOC7xlALt5SwS6aQeYk3cHBE7Dc0OHzzPYHwHngIKMAmWfn5ULIkcC4qAnmkC7VNp41M0yB0RdmLhnKP8orrGtH84ZbXC4ip6xZRNs5EZn0sz6zCjwS4kJizWMVsbNQ7ByDXGlCGOOUO8SgD8ELG4Yj0SvMOrQsxnHBsEkUeaBmrDy2b1zEYdUuMPKo7x4GZneCX4AcWT8kedD7SeRSvM4gKvfgkFVEQn9UlUrZittr0c7V5R6UvXwRIggHijLeg==
Received: from DM6PR13CA0015.namprd13.prod.outlook.com (2603:10b6:5:bc::28) by
 IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 09:30:56 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::e2) by DM6PR13CA0015.outlook.office365.com
 (2603:10b6:5:bc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.6 via Frontend
 Transport; Thu, 17 Aug 2023 09:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 09:30:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 02:30:34 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 02:30:33 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 17 Aug 2023 02:30:29 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>, <bbasu@nvidia.com>
Subject: [Patch 2/2] ACPI: processor: Add support to configure CPUFREQ reduction pctg
Date:   Thu, 17 Aug 2023 15:00:11 +0530
Message-ID: <20230817093011.1378-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817093011.1378-1-sumitg@nvidia.com>
References: <20230817093011.1378-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: f260fb8b-39ac-4fc3-a71e-08db9f04a898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUzTpSZn95hTtJDAqNutir8ZfsccS0GfVkftP+LsHhh6mHQv37SuMoYMDsT3DFEaNmVzRIoDj40E6AlPgss9a3IirkpSY8OjA7NP4vRXcDwouCzuw0+GQecEIFtc6tMwp+Swee/F8b9IRnbVX0+ErYKIZexeWvbcF5HuuootOFrpyShWFO68lc+cSgvvd3BvuSUHh4+5v/nt3rfK1O3rVgZVuqYWMB2nsnEf0niOTpnKP0qfL7kXEudBb7O7LpHGoM0+qicfFv34TTlXD3ZNK9xFzQb/UkNBeHt5Z5lf5sj9U9z7JibszdynaYf3irOj0YfQnb7ddGgmHJFZX/iY0cbxgjsNTgqpSIUrUEGFnLFMllQlJ/COBBR5XES0S6AKXGWk0FnbbeB8iipkcQNhbaPjQHbdS5Sd4Dtot+caun1ZKssJ+XyL1CaT/ddLWCnOmyNoWr5vwAXBPYUmZo1Or/TBvkWxYB/m7T9DPWeFaJRrqsDFa+3wkKhazQGu6b2N4Ini1Jb/uBiogyvPUiTuyGLSgzF4n3svzcmZTShEIfbukLBB7VfrOuZFw1Te6PaiHlE3EEF/YQgtrVu5x8/4DgORYy5eT31bgHTdvHoOKKd/272rFSKHvJ8lNl0CJq+G4gPA89pB2+YLApi1gCEa7a5+t3ZKGtdQlo4PBeZMfZpL2Q2CSxH16O72NA0eQVeJ2VqWl6CVFqpXO2xWEJmtCVht1v0YJE6ZsJJYM2Bf1xYtWIsrfpOvbnKWqDI9DLWaOVwvS3QqNsqqaq8kKtznaA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82740400003)(356005)(7636003)(40480700001)(5660300002)(2616005)(107886003)(110136005)(478600001)(70206006)(70586007)(316002)(6666004)(7696005)(54906003)(26005)(1076003)(41300700001)(4326008)(8936002)(8676002)(40460700003)(336012)(36860700001)(426003)(47076005)(2906002)(83380400001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 09:30:55.8913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f260fb8b-39ac-4fc3-a71e-08db9f04a898
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikar Srimath Tirumala <srikars@nvidia.com>

Add support to configure the CPUFREQ reduction percentage and set the
maximum number of throttling steps accordingly. Current implementation
of processor_thermal performs software throttling in fixed steps of
"20%" which can be too coarse for some platforms. Change that by adding
new config to provide the reduction percentage.

Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/Kconfig             | 15 +++++++++++++++
 drivers/acpi/processor_thermal.c | 19 ++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 00dd309b6682..287cf58defbf 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -254,6 +254,21 @@ config ACPI_DOCK
 config ACPI_CPU_FREQ_PSS
 	bool
 
+config ACPI_CPU_FREQ_THERM_HAS_PARAMS
+	bool "CPU frequency throttling control"
+	depends on ACPI_PROCESSOR
+
+config ACPI_CPU_FREQ_THERM_MIN_THROT_PCTG
+	int "Minimum throttle percentage for processor_thermal cooling device"
+	depends on ACPI_CPU_FREQ_THERM_HAS_PARAMS
+	default 20
+	help
+	  The processor_thermal driver uses this config to calculate the
+	  percentage amount by which cpu frequency must be reduced for each
+	  cooling state. The config is also used to calculate the maximum number
+	  of throttling steps or cooling states supported by the driver. Value
+	  must be an unsigned integer in the range [1, 50].
+
 config ACPI_PROCESSOR_CSTATE
 	def_bool y
 	depends on ACPI_PROCESSOR
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index b7c6287eccca..ee443cc69b73 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -25,8 +25,20 @@
  * _any_ cpufreq driver and not only the acpi-cpufreq driver.
  */
 
-#define CPUFREQ_THERMAL_MIN_STEP 0
-#define CPUFREQ_THERMAL_MAX_STEP 3
+#define CPUFREQ_THERMAL_MIN_STEP	0
+#ifdef CONFIG_ACPI_CPU_FREQ_THERM_HAS_PARAMS
+#define CPUFREQ_THERMAL_PCTG		CONFIG_ACPI_CPU_FREQ_THERM_MIN_THROT_PCTG
+
+/* Derive the MAX_STEP from minimum throttle percentage so that the reduction
+ * percentage does end up becoming negative. Also cap the MAX_STEP so that
+ * the CPU performance doesn't become 0.
+ */
+#define CPUFREQ_THERMAL_MAX_STEP	((100 / CPUFREQ_THERMAL_PCTG) - 1)
+
+#else
+#define CPUFREQ_THERMAL_MAX_STEP	3
+#define CPUFREQ_THERMAL_PCTG		20
+#endif
 
 static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
 
@@ -113,7 +125,8 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 		if (!policy)
 			return -EINVAL;
 
-		max_freq = (policy->cpuinfo.max_freq * (100 - reduction_pctg(i) * 20)) / 100;
+		max_freq = (policy->cpuinfo.max_freq *
+			    (100 - reduction_pctg(i) * CPUFREQ_THERMAL_PCTG)) / 100;
 
 		cpufreq_cpu_put(policy);
 
-- 
2.17.1

