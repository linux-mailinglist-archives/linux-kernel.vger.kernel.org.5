Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181427D8727
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345275AbjJZRED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345296AbjJZRDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:03:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B8B1AB;
        Thu, 26 Oct 2023 10:03:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo6KZLCdPlwH3L4A2mdqZtOOQzBKiB4jk9FreNQN6kAyJMxZUsFiBWZf00ICSF90plVcYTh0VTCDFZkmmOWncvKrUb7uPHElQ+51L28uvGecnTVDS5tnMmChOkBmnqf8LOvENCduwFzUt/Ut0ywuw4PYzImZtOheD8J4iTBYy4wZBkfUbyJqlaH6KRRP4GT62ElVleDMJI/eArP8PJ49tLgyNDBOOoF066A92WZpyAETEkThb99Qi8j5md2u6NvkWEwFnj8nf09PeK92aR3Dgtc2nE4Rqyfi5tZsGzdc9G0K8stcMF1k4WUFqKxU/GH3WDD6DsgkTbrkB2wX/d3QuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzhqXwyYitBxL8SmVdl/oNn/fFZjtfRBxh6ntxao4z8=;
 b=RkCZYo7+0JCodhshCuNMkFGeYiWSKMcBpwubyN7A/E8AXKSAZXn8/MZelWRO9D8fk80KutY6SCUsoiL1eAKnIrP2g1G0MzHj745krR/w1pyb7qfnPnx6JuFyKxqkMyzg69Xo7YwjYktNpCpHaKFKsHXYIzsRSH8/BKZs5xAQN8S7QAcsbs05jRe2E+DB2prx+CHyJ1og1CgHTOVFkADOjsis1xzxZ03l76ox8vagQp0YjSyMNKPvaM2hSQ293H2pdUBJP8D4DvcJ3B5DhbCTTxdXdMxYL+KpaeogUf8XaoKbGEJZVFFZD6EnIgkcyHjIi3Wv06pqmONneKY0s9Rt3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzhqXwyYitBxL8SmVdl/oNn/fFZjtfRBxh6ntxao4z8=;
 b=yV6n4T1iq8PVBISm8Fq9Qr0Ry9PiH41DbRooJNCkYhsQV9CslzBIEb47qlFXA+8IE1Oc7xtBFV6wwUyg94QPtahYpRr09fh3K1lUatg1bna4Ss9TJDTGgrzyqms8tfUgXf90WcHkC1OIpO1PAGRoE/dfc0+1EeuKw7o4N21qXq4=
Received: from BL6PEPF0001641B.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:10) by MW4PR12MB5625.namprd12.prod.outlook.com
 (2603:10b6:303:168::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 17:03:48 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2a01:111:f403:c922::) by BL6PEPF0001641B.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Thu, 26 Oct 2023 17:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 17:03:47 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 12:03:46 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Len Brown" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sandipan Das <sandipan.das@amd.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/2] perf/x86/amd: Stop calling amd_pmu_cpu_reset() from amd_pmu_cpu_dead()
Date:   Thu, 26 Oct 2023 12:03:30 -0500
Message-ID: <20231026170330.4657-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026170330.4657-1-mario.limonciello@amd.com>
References: <20231026170330.4657-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 4172abd5-8ff3-47e7-1a90-08dbd6458536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i5bhIpCw3ENQkTjOZyIV98gCiplJTOEmaUE8zpKc9LOpj010xTJCi59y0UM0mYUs154ugupZLYAjpm0WeYSYJeU2WY5AhQBpcctFV519KbtTUjdHNhzzj8sGKmuZDr9KRXCa5mhPnucn9riuv/uFa1b8hzccH6p8FnJHSMjqCnw4wlF7kZh9iF9buD39M5kua5qRaSSm8Gb1upSbxNXUaMph4MASjvo48ddHiCg9dxluaPGWOHzOLRUqwsZ92F8UblHoc4+sfL3gY+6EexLDiETK5YLJ41YZ1MBZgAxd0BLMUPlUb9rxAXN+l5NYPn23b4jUdq7Ry99/PmdqnoCyuyzQ1UzI3KpgdrsT5mypAi8O2MdKA1CIVquWyi88ksOfhHANXLKVX++fTByYHEAmnF4oBcSPr8fxfh1cwr4nqlbUoN+5DZRSQcJB3Rr/17QWmtP2Uxx0Vp1DCkd6oKsvbGbsXmRBZ1WyWDjz02brv1b1k0zha6Qx0WftieXlAP+zblX+R5xXrVvoN5R1oG8ftYi1+MrTJsoDb4NGyHHT5GrMYOHAS2PObAk3Ibpshd9u7U1JCRD5aORqDg46mD7Gtgh9Pae/xH72bxuxq7rcMeDzYfUN/MUsZknoipXVjXK+1zG5rWLWchfzoY/bK+sVcIvkocQTGNZ76cdzRyxHV1RSLhaQA39ywuKMi46D1xwfZeT/u5BMyMH4++X5oRcF2VP2SwccKC9YTbEit4IrCYqYtjLPNv2gmglpg2D6p84MBZaYLbbyDaQ9kjiclCItZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(110136005)(44832011)(70206006)(8936002)(70586007)(8676002)(4326008)(41300700001)(478600001)(36860700001)(81166007)(2906002)(7416002)(316002)(47076005)(86362001)(40460700003)(54906003)(5660300002)(36756003)(356005)(40480700001)(6666004)(7696005)(426003)(2616005)(82740400003)(26005)(336012)(16526019)(83380400001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 17:03:47.8278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4172abd5-8ff3-47e7-1a90-08dbd6458536
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During suspend testing on a workstation CPU a preemption BUG was reported.

```
BUG: using smp_processor_id() in preemptible [00000000] code: rtcwake/2960
caller is amd_pmu_lbr_reset+0x19/0xc0
CPU: 104 PID: 2960 Comm: rtcwake Not tainted 6.6.0-rc6-00002-g3e2c7f3ac51f
Call Trace:
 <TASK>
 dump_stack_lvl+0x44/0x60
 check_preemption_disabled+0xce/0xf0
 ? __pfx_x86_pmu_dead_cpu+0x10/0x10
 amd_pmu_lbr_reset+0x19/0xc0
 ? __pfx_x86_pmu_dead_cpu+0x10/0x10
 amd_pmu_cpu_reset.constprop.0+0x51/0x60
 amd_pmu_cpu_dead+0x3e/0x90
 x86_pmu_dead_cpu+0x13/0x20
 cpuhp_invoke_callback+0x169/0x4b0
 ? __pfx_virtnet_cpu_dead+0x10/0x10
 __cpuhp_invoke_callback_range+0x76/0xe0
 _cpu_down+0x112/0x270
 freeze_secondary_cpus+0x8e/0x280
 suspend_devices_and_enter+0x342/0x900
 pm_suspend+0x2fd/0x690
 state_store+0x71/0xd0
 kernfs_fop_write_iter+0x128/0x1c0
 vfs_write+0x2db/0x400
 ksys_write+0x5f/0xe0
 do_syscall_64+0x59/0x90
 ? srso_alias_return_thunk+0x5/0x7f
 ? count_memcg_events.constprop.0+0x1a/0x30
 ? srso_alias_return_thunk+0x5/0x7f
 ? handle_mm_fault+0x1e9/0x340
 ? srso_alias_return_thunk+0x5/0x7f
 ? preempt_count_add+0x4d/0xa0
 ? srso_alias_return_thunk+0x5/0x7f
 ? up_read+0x38/0x70
 ? srso_alias_return_thunk+0x5/0x7f
 ? do_user_addr_fault+0x343/0x6b0
 ? srso_alias_return_thunk+0x5/0x7f
 ? exc_page_fault+0x74/0x170
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8
RIP: 0033:0x7f32f8d14a77
Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa
64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff
77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007ffdc648de18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f32f8d14a77
RDX: 0000000000000004 RSI: 000055b2fc2a5670 RDI: 0000000000000004
RBP: 000055b2fc2a5670 R08: 0000000000000000 R09: 000055b2fc2a5670
R10: 00007f32f8e1a2f0 R11: 0000000000000246 R12: 0000000000000004
R13: 000055b2fc2a2480 R14: 00007f32f8e16600 R15: 00007f32f8e15a00
 </TASK>
```

This bug shows that there is a mistake with the flow used for offlining
a CPU.  Calling amd_pmu_cpu_reset() from the dead callback is problematic
because this doesn't run on the actual CPU being offlined.  The intent of
the function is to reset MSRs local to that CPU.

Move the call into the dying callback which is actually run on the local
CPU.

Cc: stable@vger.kernel.org # 6.1+
Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
Suggested-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Add more of trace
 * Explain root cause better
 * Adjust solution to fix real root cause
---
 arch/x86/events/amd/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index e24976593a29..4ec6d3ece07d 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -598,13 +598,17 @@ static void amd_pmu_cpu_starting(int cpu)
 	cpuc->amd_nb->refcnt++;
 }
 
+static void amd_pmu_cpu_dying(int cpu)
+{
+	amd_pmu_cpu_reset(cpu);
+}
+
 static void amd_pmu_cpu_dead(int cpu)
 {
 	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);
 
 	kfree(cpuhw->lbr_sel);
 	cpuhw->lbr_sel = NULL;
-	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -1270,6 +1274,7 @@ static __initconst const struct x86_pmu amd_pmu = {
 
 	.cpu_prepare		= amd_pmu_cpu_prepare,
 	.cpu_starting		= amd_pmu_cpu_starting,
+	.cpu_dying		= amd_pmu_cpu_dying,
 	.cpu_dead		= amd_pmu_cpu_dead,
 
 	.amd_nb_constraints	= 1,
-- 
2.34.1

