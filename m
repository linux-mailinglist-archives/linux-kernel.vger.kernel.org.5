Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F827BA696
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjJEQiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjJEQiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:38:17 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4774ED0;
        Wed,  4 Oct 2023 22:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd+Yv4SlZ50zb2XcfXy8PXxZB8TASrD0jht7NErEQUdNfsfKW3EutsnKOwefBr6EsDnrhwz6c145RIYsepGSO1HVWUs5RZU+3LZnUz27nMebit9p8GhHwoQPJsnTCy3p6bW905exun589Pr8fjBjGt6pws+1utuctbx5gZyTiYynNb/8HSpbOCdBA6gPoD9Qw7qyEwJZuEFRfZv3Z6MO7u9A+rWBuG3iEBfi9JPw0+auRwTPyIZ0IWqGI0L58yAhL0bVH01zbpTdTw67jdhMcXScpVz2Z8bvyri5j07pfKdS+hk5S1XBNGxOkrZjcAf4ff+k+wjPJETtZHmEEcslyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFBqgzy0HqlX7GK4g7PO4lzLMoVw4VlPkOSgtpUIoHs=;
 b=XlE151Ab0Ijcf9GQbRNiEor7Ou/kuVXFBpl7JDGFu/xcUklmKoIGemuczwSLEuUSKLfl3Lt5bI+ihCMApXMCIygYUgF00r6r4t/fHHAnW5BokgskTDvkXDOAsLjCZtXtTqztNjoZ5TozZyJMxGsNewUFV60p3emjgwEK3+w+TMoKE3p7l2LODx12VYDZc9hPniAwwsiRQza8GPYW0Q5DJtMgkNo2/MMpuhdtHQCMol5S3zxcXu2UQkw4t5hzM3a7cufeCNLQQuX/YScBPG+iKXmJZayjxXQXCAdwr1dUsxx/KEISUDH7gTpmu9Tqb4JOcBAVBh2L7+MrsRZroi1iUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFBqgzy0HqlX7GK4g7PO4lzLMoVw4VlPkOSgtpUIoHs=;
 b=Jk11FVaHWUxuug3IP9Lz4qAjyqsb4QR4QMyx+lptF2WxPYOUBKdRl5MU+2KecFee1Cu7X/WXwi3ejKk+5FMCaCCIEzJvhyI+9hDdOUsIr4YHMlZjoPbdvKz9g/Etlj2vP0W84QqmQ0N48dF31CKVbCwV/zDXkHCsCqKeCXTUWCs=
Received: from MN2PR04CA0008.namprd04.prod.outlook.com (2603:10b6:208:d4::21)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 5 Oct
 2023 05:23:36 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::2a) by MN2PR04CA0008.outlook.office365.com
 (2603:10b6:208:d4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Thu, 5 Oct 2023 05:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 05:23:35 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 00:23:29 -0500
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
Subject: [PATCH v2 0/6] perf/x86/amd: Add memory controller events
Date:   Thu, 5 Oct 2023 10:53:10 +0530
Message-ID: <cover.1696425185.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: c19db04e-217c-45cd-78c4-08dbc5633972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDSXRqO/aaUkVo9v0Ki/saAzbBd2hCHwP8e5I9SUL1iCOslGkrXp9qtU+Wad2M6v9teN6Bv6nGQNKhSAncZyHAaXSNdfIavshbapGG2YGaZ7GiBk+OpfaaV++zCZtkxNFfpDlsANAUu1qQlCNk35kBHyUB/PfTHRdpuZsueI6FrVnOiSkbWz8tVugO0WDHrF7TRrMqB2YoSuHyfwxErVUyG1rcnJSmWlEDNNrI/wmHrCBpiQfyxws7jKHhGwlMTgmY5UM87j+KAA0inPg+ja7QAsPJo+ZV8bIFEcFSepBfm3m7OuZFxciyD2JG976tpRqIuzn+1LkrdGFL0sKa0aroiSJZPzehXn5h9eteQcxzfE60rhmLZd2YVP8SH/FwoigmA1f9f53qAuZTPPtmj/B/u3tFmP+5PCuqZQjSAlo4tqB4UePNSMkAcmcATGi45cIKtPbGAJ5I0gQqACCcLVCfyWAKQHaFH6hl78hBnOXOhlX0ZVeya+Fab3WcdBFns13dBi7Tc4zBwn9/OnDsXCcfTaTJ+AwWerjtuO+VBgNKsVJJ2YZ3hBJd5IIdvycswlO5G8BpbAuv1S7Qd3jIcpOhwr8o9AK9ZGgWH5/1Nn3fUTxSs9VNF42fCL5ZaCxUOILnk22omx/cV2L6iWOXe/9XAvkR+MW6LluSxRmWy9DEUxjeWBrY9D0HN4YNUgUiIGa4QwFxCu11DTfMKqyJcPCvkwak8TaVuf1KnGGEQwH/WAz8MmmZr5SGVZCIuXZmom
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(2616005)(70206006)(70586007)(54906003)(40460700003)(316002)(41300700001)(16526019)(26005)(426003)(336012)(36756003)(6666004)(7696005)(478600001)(966005)(82740400003)(81166007)(356005)(47076005)(86362001)(83380400001)(36860700001)(110136005)(40480700001)(44832011)(7416002)(2906002)(4326008)(8936002)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 05:23:35.8825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c19db04e-217c-45cd-78c4-08dbc5633972
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unified Memory Controller (UMC) events were introduced with Zen 4 as a
part of the Performance Monitoring Version 2 (PerfMonV2) enhancements.
Currently, Zen 4 supports up to 12 channels of DDR5 memory and each of
them are controlled by a dedicated UMC. Each UMC, in turn, has its own
set of performance monitoring counters. These counters can provide info
on UMC command activity which in turn can be used to derive utilization
and bandwidth. Using perf tool, users can profile activity either on a
combined basis (includes all active UMCs) or for individual UMCs.

E.g. measurement across all UMCs

  $ sudo perf stat -e amd_umc/umc_cas_cmd.all/ -a -- sleep 1

   Performance counter stats for 'system wide':

	     544,810      amd_umc/umc_cas_cmd.all/

	 1.002012663 seconds time elapsed

E.g. measurement specific to certain UMCs

  $ sudo perf stat -e amd_umc_0/umc_cas_cmd.all/ -e amd_umc_4/umc_cas_cmd.all/ -a -- sleep 1

   Performance counter stats for 'system wide':

	      27,096      amd_umc_0/umc_cas_cmd.all/
	      35,136      amd_umc_4/umc_cas_cmd.all/

	 1.001602807 seconds time elapsed

The available UMCs can be found from sysfs and the socket to which they
belong can be derived from the cpumask.

E.g.

  $ find /sys/bus/event_source/devices/ -maxdepth 1 -name "amd_umc_*" | sort

  /sys/bus/event_source/devices/amd_umc_0
  /sys/bus/event_source/devices/amd_umc_1
  /sys/bus/event_source/devices/amd_umc_2
  /sys/bus/event_source/devices/amd_umc_3
  /sys/bus/event_source/devices/amd_umc_4
  /sys/bus/event_source/devices/amd_umc_5
  /sys/bus/event_source/devices/amd_umc_6
  /sys/bus/event_source/devices/amd_umc_7

  $ cat /sys/devices/amd_umc_0/cpumask
  0

  $ cat /sys/devices/amd_umc_4/cpumask
  96

All of the output above comes from a dual socket Genoa system having
96 cores and 4 populated memory channels per socket.

Previous versions can be found at:
v1: https://lore.kernel.org/all/cover.1689748843.git.sandipan.das@amd.com/

Changes in v2:
 - Move collection of PMU CPUID info to startup of UNCORE_STARTING.
 - Remove mechanism to read CPUID information using SMP callbacks.
 - Defer PMU registration to startup of UNCORE_ONLINE since this can
   only be done after collection of CPUID information.
 - Remove mechanism to collect and free up unused uncore contexts as
   this is no longer required.
 - Rename some structures (amd_uncore is now called amd_uncore_pmu and
   amd_uncore is instead a collection of amd_uncore_pmu instances).
 - Add new uncore management handlers (scan, init, move, free) which are
   called at different stages of CPU hotplug.
 - Add Acked-by from Ian Rogers for the JSON events.

Sandipan Das (6):
  perf/x86/amd/uncore: Refactor uncore management
  perf/x86/amd/uncore: Move discovery and registration
  perf/x86/amd/uncore: Use rdmsr if rdpmc is unavailable
  perf/x86/amd/uncore: Add group exclusivity
  perf/x86/amd/uncore: Add memory controller support
  perf vendor events amd: Add Zen 4 memory controller events

 arch/x86/events/amd/uncore.c                  | 1036 +++++++++++------
 arch/x86/include/asm/msr-index.h              |    4 +
 arch/x86/include/asm/perf_event.h             |    9 +
 .../arch/x86/amdzen4/memory-controller.json   |  101 ++
 .../arch/x86/amdzen4/recommended.json         |   84 ++
 tools/perf/pmu-events/jevents.py              |    2 +
 6 files changed, 879 insertions(+), 357 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json

-- 
2.34.1

