Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE5B758E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjGSG4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGSG4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:56:02 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F4F1BFD;
        Tue, 18 Jul 2023 23:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn0vFPrpZhmMynyREosgmELfiSwcUxLiLl6k2VJ667/Vo+Y+y0JjdHvFMBEK+CRqnIMCI0c0MTw+KZEEakKd+CsGyeSaIXeJx20dpBlGoOEUnhSMFPUzmZ4K8nbESMDtTXf+JTNW0BvQNSMVcD6DoJ6F8iv2zW5q+N6LQwgwl5oReQBq9b1jhbnbKYpH/e1Ocw0ZO6dv/yTkVW2K1tx3aF0rygsAjHIRkog6W94o70uMINbS0Fv7/1CvbfeFZnz8olzxfGBXCKpvco9NR97YDtE9MHoJMaSegNmmE1/SUpw11eAQxTdRDt8hSkMMNg9OLn3dZ1kXEUSkZRXbMq7ASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wxnt7ur/zUc4R4Xyr3xenabaVLIDj3BFzxjdyaCZys=;
 b=Makp+KX84PieTa7ukhfwl10GUi52gueVJGJT6mNdpf+ZnsHkoiOmpW1ZpM5IOtOUt4seDL6dC9xQMU9GiYh86pYE6sCPcwQd4lerZfHLsYevb1Q/EOtxoD/QR2XvpAgucTBnZQggiZKbYVog+9RAFcMuV7D81ZUZEtQFz8egmQPPbrU/uiFPAPlDavgFUvkYLIsd9ZTpIYKrpiympCeqbc5DddUW6Gpf8WRzLODVmy62ZI/l6hn9phEmmiffQQxtoW2amRDyMYifhN28svQXKRcCLo8PefVei71tVA/C4Ewysr52XacSaIhMq5GZXbJ89Pv7Y0DLdVkFIeObLtbkew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wxnt7ur/zUc4R4Xyr3xenabaVLIDj3BFzxjdyaCZys=;
 b=qvujhVbARAYWaXEjReWCpRJ/kL+MVsPbSVGuSEg7fJVuGsXrpG2AIkSvSJzJGm8LwbDagvZVRub6SEnuXWB88DBCeAmDuD3QkhJggbJeEN8ourOi8fKVVLVW8fkImBSr2ZMu647iIz0FmRntmwUTMwPGmDDMBAWlZCcfxyWEqrg=
Received: from BN0PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:143::11)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 06:55:55 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::22) by BN0PR10CA0020.outlook.office365.com
 (2603:10b6:408:143::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 06:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 06:55:55 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 01:55:49 -0500
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
Subject: [PATCH 0/6] perf/x86/amd: Add memory controller events
Date:   Wed, 19 Jul 2023 12:25:35 +0530
Message-ID: <cover.1689748843.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: c3378ad7-bdeb-4a25-68f6-08db8825330e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gljAIvNIVvrONQEX9Bh2X/OsV0AAcEyd9zlWrszH2iQY1q2ZFotCV3VIxThvu+QgnewUyTgu6ZRcq/x6spbEgg7+Sl3AItR61ueGGm3OE5qlKBurQjqSDCu1SP9LG+XlKu2QwqZZ2WNNyn0bsY7SXCsqTiS/5x9OW4lwU68I/Xm9W5ERw1lWTahZ5Q1QVcdR8F3Vosn3oTzLiVrVkIrRcAjfynxccA/Oxo+QxhbrtiCXXCmb44eFg/iL6zJwBEOXHvSHwKcfLEXorQdLWJ7PDejWILGZJJKKUoTJYU8n6qMlQxpTlsNZw3vJdlVV9bssvin6uRWmpnKTYEMAl6/mdvQ5Un0PouzOl1bFIv68cMP/XvQ+kt3lOhmfsjgxU7fx9Ta3m1c9SEo71z6UvDfv/zTahYNFsgJWgncVxT4IdBxN+JvYqYPlNtea7XM4CevspLtx9vGKbl2wlY6RUXfJ1qdxeV6MsIPC+g8DrLHOM2zwPJTwdVlOpVC6nrkKRBGqOc8np0ANj1uyZQhYn8xQUYdcghkuoBjvehr96UxZJ0v0UxistdFzaK92FF/gqfwoT4zoH8dqvqIv939mSoo7PPdLp+t8Sd+yX60TUt2xxz1pMp5vHRrxQQbv9a13yhuDhMVocaOgkpqhqbX5f1BXc/1mobIVTGO1YBkndsiPWX7k0hz+88mD/s9Lm8xQa5eVdgUiOEGtmefIEk/oiVgeiTW21jvr4gnCsIiN8QG5mTfcX/WdOAVslek5AKRPt45RZ4mYMArM6c/FgKgzucJeqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(7416002)(86362001)(36756003)(2906002)(44832011)(40460700003)(40480700001)(2616005)(16526019)(186003)(36860700001)(83380400001)(336012)(426003)(47076005)(26005)(82740400003)(81166007)(110136005)(356005)(70206006)(6666004)(54906003)(70586007)(478600001)(316002)(5660300002)(4326008)(41300700001)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 06:55:55.4338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3378ad7-bdeb-4a25-68f6-08db8825330e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unified Memory Controller (UMC) events were introduced with Zen 4 as a
part of the Performance Monitoring Version 2 (PerfMonV2) enhancements.
Currently, Zen 4 supports upto 12 channels of DDR5 memory and each of
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

  $ sudo perf stat -e amd_umc_0/umc_cas_cmd.all/ -e amd_umc_6/umc_cas_cmd.all/ -a -- sleep 1

   Performance counter stats for 'system wide':

              21,096      amd_umc_0/umc_cas_cmd.all/
              35,428      amd_umc_6/umc_cas_cmd.all/

         1.001802611 seconds time elapsed

The available UMCs can be found from sysfs and the socket to which they
belong can be derived from the cpumask.

E.g.

  $ find /sys/devices/ -maxdepth 1 -name "amd_umc_*"

  /sys/devices/amd_umc_9
  /sys/devices/amd_umc_7
  /sys/devices/amd_umc_5
  /sys/devices/amd_umc_3
  /sys/devices/amd_umc_1
  /sys/devices/amd_umc_10
  /sys/devices/amd_umc_8
  /sys/devices/amd_umc_6
  /sys/devices/amd_umc_4
  /sys/devices/amd_umc_2
  /sys/devices/amd_umc_11
  /sys/devices/amd_umc_0

  $ cat /sys/devices/amd_umc_0/cpumask
  0

  $ cat /sys/devices/amd_umc_6/cpumask
  96

All of the output above comes from a dual socket Genoa system having
96 cores and 6 populated memory channels per socket.

Sandipan Das (6):
  perf/x86/amd/uncore: Refactor uncore management
  perf/x86/amd/uncore: Use rdmsr if rdpmc is unavailable
  x86/cpuid: Add smp helper
  perf/x86/amd/uncore: Add group exclusivity
  perf/x86/amd/uncore: Add memory controller support
  perf vendor events amd: Add Zen 4 memory controller events

 arch/x86/events/amd/uncore.c                  | 893 +++++++++++-------
 arch/x86/include/asm/cpuid.h                  |  14 +
 arch/x86/include/asm/msr-index.h              |   4 +
 arch/x86/include/asm/perf_event.h             |   9 +
 arch/x86/lib/Makefile                         |   2 +-
 arch/x86/lib/cpuid-smp.c                      |  36 +
 .../arch/x86/amdzen4/memory-controller.json   | 101 ++
 .../arch/x86/amdzen4/recommended.json         |  84 ++
 tools/perf/pmu-events/jevents.py              |   2 +
 9 files changed, 807 insertions(+), 338 deletions(-)
 create mode 100644 arch/x86/lib/cpuid-smp.c
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json

-- 
2.34.1

