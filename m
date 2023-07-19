Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD57758E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjGSG66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjGSG6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:58:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBDC1735;
        Tue, 18 Jul 2023 23:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNd6udUw+vPC0cn36IleM8galdcx0NCQEReh1WK1WsYWGhjbu3FaqqHR83IlERKFnsGKC9ohu2lFEoHrJkgcxXrZvNiCP/P5Ht4tiPPEtBArZaLIsN974NBQFl1T8/SwzTMxGhujP5RmvrpMBauy48mQesoBgDkG5aoH1rVn417Qthi+W62r6L4VSMcLQeEhh8YFp+35I8taUF8dri8USOzf1NBaNbQLeyKmjnYUoI5a1uX5nXW4WmnYqkCQgaVDsD/KiR/4BQBOApDT+T2ifQt2B/QWbOpKx3rsJ3PvSkR/WpNSM1aPFkSROhOVKZLjZ73zXWxK0krGnpMISNys+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shJYfo5HPR96g5uSryEucrv1t0iGShZOy9dV1NlVuB0=;
 b=l6o+HpFjmvtMlf6SUq0Tx30U6Qnhf2clQc4LBoZmFhru7gPnpA5ycB//b1mvXCkVZuuqbKBmyVQbuS8PIzICWTLcnzHhKFZNeC2YGR5HfMJ/pnMkG73fS8/LIY00+QdBMoZMET9/SKdlfbz+Cr5zqy46+Z7BcU/kBRwUbYXangxcIBCO7HfeKKFNrpWqqjVBOPJ0qEKftfLiXteWX4kKoJOPXnTmNFXyixFzG/uDSXo34OFvHwJDpJYUMyJcE4Sc9xP4FNDETKg+56cPJTy6L95sQ5NO7AES5zctCsJlaYG2ab/yawIscoWaho2jeJCjIWDFRcB+DLkYcBq8o/7iJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shJYfo5HPR96g5uSryEucrv1t0iGShZOy9dV1NlVuB0=;
 b=IFGqHPRCiDzzxmp7FTUaUQkQdS1Mlz/t3YwjbTcun9ap8ZJIX/n0WSRkg9NOUGuV4wVmWBojmieJATtg1MJFka/e3sw0s54Yd15Yvoblr7XU6tMcxtsnwx/In4JQR9HKxi4BckWIVyqo/f6Kk8Bm2VlrMFAI6FD0cAXmPzl9D1Q=
Received: from BN9PR03CA0504.namprd03.prod.outlook.com (2603:10b6:408:130::29)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 06:58:44 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::8d) by BN9PR03CA0504.outlook.office365.com
 (2603:10b6:408:130::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 06:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 06:58:44 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 01:58:37 -0500
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
Subject: [PATCH 6/6] perf vendor events amd: Add Zen 4 memory controller events
Date:   Wed, 19 Jul 2023 12:25:41 +0530
Message-ID: <a70b1ef6ab427b768f21401af280d235dd095412.1689748843.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689748843.git.sandipan.das@amd.com>
References: <cover.1689748843.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 708ed943-8416-43dd-6f15-08db882597d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIZEJI+8RyWZD6B+6pSbESa/imx8zS74+qNlMT3XJTm2We5E2hx8u4hu/u+3fZ7P+LZ3rU3n2x0Y0ngRuBMGccBhF5DuNoE7/N8Y3rE6G8OzFM3+rwDTS99hHCvNmai3V0j+sJ5grTPBEutjUdJl5nL8zRgSJ3kBCtS6k3veK/93Sd7Ppkld9TjcDJXm44xFUUaaAQ1bKhQGUzAENyFdiaxVpFuD8zFPqrF5TwDPzQBUmyJmUnEOwUS/FeWQswD6tH4x2k/Xmcmnph/pERSE9evB5n36lhpLiHfCSstvQf6KFEmyeZYtLT2srHuDB/3K+MX+BAk3HWwBZGQ9bnPC/QwMrs85OV8S3i39OL+BMBNW0fva0ji7/ILaWL+fpEvpYf/7Fx5Mi1OS7UsVwci+MELuFgIpFpMJEo3xrZGCLlMPVgHQ+6DZy7GSzG9tk6kY+A5OlAcDTWwa/0oRr4VYr6RZrkOQ8GhebxPEtEvjsz4ICJKNH8AKEuO6+TCIO4IToldRi5Oqtm5QgSxaSPDbcpU3mYHvORsjitaYdjDOtexXHe6Hy171ggcdXFMQYlvFXdrPoA17IiUQnldwfoB+q0/PQFBj579sETQnsSln/orGaIWayfO+iGbvVNPhPXfMCxhNtL/8X27rGjEtYQcAV4XtKRMtENSpKNwWaUxFHezrogpou9TPw0DgJ+kdAmEFhKUeZk2+pzZ5sqXP1JPhtx4lX8c+tnHlez8BTnk03hzEY1uyjqpgwFHfDWH3gazPsmsMIYQgoW0rUPVTSDgEsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(54906003)(110136005)(40480700001)(86362001)(44832011)(7416002)(186003)(336012)(70586007)(70206006)(4326008)(478600001)(41300700001)(316002)(6666004)(8676002)(40460700003)(8936002)(5660300002)(26005)(2906002)(36860700001)(36756003)(426003)(82740400003)(16526019)(81166007)(356005)(83380400001)(2616005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 06:58:44.5062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 708ed943-8416-43dd-6f15-08db882597d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the jevents parser aware of the Unified Memory Controller (UMC) PMU
and add events taken from Section 8.2.1 "UMC Performance Monitor Events"
of the Processor Programming Reference (PPR) for AMD Family 19h Model 11h
processors. The events capture UMC command activity such as CAS, ACTIVATE,
PRECHARGE etc. while the metrics derive data bus utilization and memory
bandwidth out of these events.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../arch/x86/amdzen4/memory-controller.json   | 101 ++++++++++++++++++
 .../arch/x86/amdzen4/recommended.json         |  84 +++++++++++++++
 tools/perf/pmu-events/jevents.py              |   2 +
 3 files changed, 187 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
new file mode 100644
index 000000000000..55263e5e4f69
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
@@ -0,0 +1,101 @@
+[
+  {
+    "EventName": "umc_mem_clk",
+    "PublicDescription": "Number of memory clock cycles.",
+    "EventCode": "0x00",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_act_cmd.all",
+    "PublicDescription": "Number of ACTIVATE commands sent.",
+    "EventCode": "0x05",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_act_cmd.rd",
+    "PublicDescription": "Number of ACTIVATE commands sent for reads.",
+    "EventCode": "0x05",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_act_cmd.wr",
+    "PublicDescription": "Number of ACTIVATE commands sent for writes.",
+    "EventCode": "0x05",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_pchg_cmd.all",
+    "PublicDescription": "Number of PRECHARGE commands sent.",
+    "EventCode": "0x06",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_pchg_cmd.rd",
+    "PublicDescription": "Number of PRECHARGE commands sent for reads.",
+    "EventCode": "0x06",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_pchg_cmd.wr",
+    "PublicDescription": "Number of PRECHARGE commands sent for writes.",
+    "EventCode": "0x06",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_cas_cmd.all",
+    "PublicDescription": "Number of CAS commands sent.",
+    "EventCode": "0x0a",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_cas_cmd.rd",
+    "PublicDescription": "Number of CAS commands sent for reads.",
+    "EventCode": "0x0a",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_cas_cmd.wr",
+    "PublicDescription": "Number of CAS commands sent for writes.",
+    "EventCode": "0x0a",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_data_slot_clks.all",
+    "PublicDescription": "Number of clocks used by the data bus.",
+    "EventCode": "0x14",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_data_slot_clks.rd",
+    "PublicDescription": "Number of clocks used by the data bus for reads.",
+    "EventCode": "0x14",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_data_slot_clks.wr",
+    "PublicDescription": "Number of clocks used by the data bus for writes.",
+    "EventCode": "0x14",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
index 5e6a793acf7b..96e06401c6cb 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
@@ -330,5 +330,89 @@
     "MetricGroup": "data_fabric",
     "PerPkg": "1",
     "ScaleUnit": "6.103515625e-5MiB"
+  },
+  {
+    "MetricName": "umc_data_bus_utilization",
+    "BriefDescription": "Memory controller data bus utilization.",
+    "MetricExpr": "d_ratio(umc_data_slot_clks.all / 2, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_cas_cmd_rate",
+    "BriefDescription": "Memory controller CAS command rate.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1"
+  },
+  {
+    "MetricName": "umc_cas_cmd_read_ratio",
+    "BriefDescription": "Ratio of memory controller CAS commands for reads.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_cas_cmd_write_ratio",
+    "BriefDescription": "Ratio of memory controller CAS commands for writes.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.wr, umc_cas_cmd.all)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_mem_read_bandwidth",
+    "BriefDescription": "Estimated memory read bandwidth.",
+    "MetricExpr": "(umc_cas_cmd.rd * 64) / 1e6 / duration_time",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "umc_mem_write_bandwidth",
+    "BriefDescription": "Estimated memory write bandwidth.",
+    "MetricExpr": "(umc_cas_cmd.wr * 64) / 1e6 / duration_time",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "umc_mem_bandwidth",
+    "BriefDescription": "Estimated combined memory bandwidth.",
+    "MetricExpr": "(umc_cas_cmd.all * 64) / 1e6 / duration_time",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "umc_cas_cmd_read_ratio",
+    "BriefDescription": "Ratio of memory controller CAS commands for reads.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_cas_cmd_rate",
+    "BriefDescription": "Memory controller CAS command rate.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1"
+  },
+  {
+    "MetricName": "umc_activate_cmd_rate",
+    "BriefDescription": "Memory controller ACTIVATE command rate.",
+    "MetricExpr": "d_ratio(umc_act_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1"
+  },
+  {
+    "MetricName": "umc_precharge_cmd_rate",
+    "BriefDescription": "Memory controller PRECHARGE command rate.",
+    "MetricExpr": "d_ratio(umc_pchg_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1"
   }
 ]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 12e80bb7939b..c2a5728253db 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -272,6 +272,7 @@ class JsonEvent:
           'imx8_ddr': 'imx8_ddr',
           'L3PMC': 'amd_l3',
           'DFPMC': 'amd_df',
+          'UMCPMC': 'amd_umc',
           'cpu_core': 'cpu_core',
           'cpu_atom': 'cpu_atom',
       }
@@ -330,6 +331,7 @@ class JsonEvent:
         ('Invert', 'inv='),
         ('SampleAfterValue', 'period='),
         ('UMask', 'umask='),
+        ('RdWrMask', 'rdwrmask='),
     ]
     for key, value in event_fields:
       if key in jd and jd[key] != '0':
-- 
2.34.1

