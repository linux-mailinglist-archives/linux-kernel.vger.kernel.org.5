Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C137D134E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377817AbjJTP5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377810AbjJTP5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:57:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21874D8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaKBbAvickS8pOLjSPG4rVdHEMLGpIy7PEeGbH+ZKCAwC3hWbl0nMnGcSRbCJ3K73jgYNwicdf0gxdnCBqGnSE3FTFDTPVnpDw38MLUYTgFm70GnLLAS6jcaOLPhQE/PIp5DCW75ou8xeQmOXvDQoHnIYs8BPEcJ2uznTqNpCM5d43NU4zleW2edHpFI1AzZvErWbAC1JVP57cuoPqEA3B1JqzRSmngIqskxaerrQciZiNS5AhrCm1IQ7zOv5LNssa3IU7B+9zWxU4PyrcgA7QmFO/DGiu5SVxvSiWY9H8621DZYInNLcXZ+R8TzyEoZBL83Gpy07kv4uqV3mccfpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9If9vMnaA9cDPuOB/2/kiuutVmw99xeF7WonYExJ0Q=;
 b=FqHlbaTpySB79v+ctJiXXquz31wdkXMM3xHr3uJIIMSNA/h9ibtsBkiy7GE5O4wgXjsRlz93P5dm00pncX9++Dgbi1d5nNBQ57SNUeyfQeteJol+PkIDWCTWxQFaifCXq+gDPCh22dyShEETIuse2SOXtmvVmNS0Vsy3DrPgQmGKhYDCdT9/BBcXJhU/GP9nZlkWCOSY18OgXsZd7qAMu0b891fadsRpsNMkbNqzaGYuYZiV8es70FRTiUJ8cWBW5MpMFy4OrGxYSIP3rUto+hfygSNdVFUpLdH+VKNSdqfbZ/pVoEBwLGaygCKMKaNaTHAJmU+YNXBV37I0v66d2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9If9vMnaA9cDPuOB/2/kiuutVmw99xeF7WonYExJ0Q=;
 b=e8vHbdeBntM+poNSYSmwW9mAIVg/anfgr/3WWixxVr7FIUH4yapiRcljOli2xThneImSpFzXi/1JKn2IG8yqeCgizkCGQhTYdQWe5hbT5VnhcaJK1DhmndM6LxqDFGfTsavKJr3cVXE2AWecbFiPRc4XmQdQC1gxHXH12QdBPds=
Received: from MW4PR03CA0270.namprd03.prod.outlook.com (2603:10b6:303:b4::35)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Fri, 20 Oct
 2023 15:57:32 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::f6) by MW4PR03CA0270.outlook.office365.com
 (2603:10b6:303:b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Fri, 20 Oct 2023 15:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Fri, 20 Oct 2023 15:57:31 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 10:57:26 -0500
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        "kernel test robot" <oliver.sang@intel.com>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH V1 1/1] sched/numa: Fix mm numa_scan_seq based unconditional scan
Date:   Fri, 20 Oct 2023 21:27:46 +0530
Message-ID: <2ea7cbce80ac7c62e90cbfb9653a7972f902439f.1697816692.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1697816692.git.raghavendra.kt@amd.com>
References: <cover.1697816692.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c92b48e-7892-48db-f32a-08dbd18544f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTJ1Uys7VfpZk3mm4pLmEBz4oPGB8qN6WlrrfWtz9OAWgYjJ2GntrMy4CyDCBHSJvDqOTUEPNkeebJkfHssUQLVLtpDHmdxJlQnKwtUDkgfUxP14IfMVXXrfk1m98HuCjM8PEb2WNrgMUtH3grbTphnrKV7haQifjNkd1TJCY5JGj3BMJjkdmB7OskIYxQb1YCeoRIOV12ak97Tc2bAbWcouSTGRYWWvHCFxgX2eHOVM1Ibj8JGFv8yeHKK98DEmQhMt+ifSiCO3wkX1Y+BMNik+CpFH5ewBQLT0cK85Y1gU09p8w0pPfsfGaZDsUzLDOPj06E1CO6gn1sTTaYRBP8Gp8s+x4E8uRv1tgLChEeZz67reSdO9yBBjDdjA90QhIBKilXBEPwiFXrP5T6CUJ+Ns2T/StWDf5AHnTk2pG/8pieQSvCYXiSVGpVjI1Zchrz9ULhnPwuW6GHPa8h9GVX4s3uqDVuc7uZZd/FrJ8okMaWokK4mXqGYvQFdhlkMtjb3hlKnXKB+5DFWqTFU2NnBPpwI7hx6xb6WCGataLIP0eDJRHx3ctSjSJVHdI73KiOQnWdlLW8O4DDaB7PR2GK25wgvAomgT4MElC/1NTR9lhqylXJBnDIwNyG8o2zjA+UNu/sIKgusnA4QBvEuuUhzCG3WPWe/wevd52q8V4TU/V1hUi7QiOCpXADza67I/Bp30eNyEhNK5Q11yH9xxJy9YDr/mzxr1zWkd7T+vuoEBSuERRgs4gfQwZxg7nKa2AvUpLDtbq1qn4sMqdbLLY69ToqLz3AmwHnBOFPkg+m0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(6666004)(7696005)(426003)(336012)(2616005)(26005)(36756003)(81166007)(356005)(70206006)(478600001)(110136005)(70586007)(54906003)(966005)(47076005)(82740400003)(83380400001)(16526019)(36860700001)(316002)(4326008)(8936002)(8676002)(40460700003)(5660300002)(41300700001)(40480700001)(7416002)(2906002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 15:57:31.9385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c92b48e-7892-48db-f32a-08dbd18544f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic")

NUMA Balancing allows updating PTEs to trap NUMA hinting faults if the
task had previously accessed VMA. However unconditional scan of VMAs are
allowed during initial phase of VMA creation until process's
mm numa_scan_seq reaches 2 even though current task had not accessed VMA.

Rationale:
 - Without initial scan subsequent PTE update may never happen.
 - Give fair opportunity to all the VMAs to be scanned and subsequently
understand the access pattern of all the VMAs.

But it has a corner case where, if a VMA is created after some time,
process's mm numa_scan_seq could be already greater than 2.

For e.g., values of mm numa_scan_seq when VMAs are created by running
mmtest autonuma benchmark briefly looks like:
start_seq=0 : 459
start_seq=2 : 138
start_seq=3 : 144
start_seq=4 : 8
start_seq=8 : 1
start_seq=9 : 1
This results in no unconditional PTE updates for those VMAs created after
some time.

Fix:
- Note down the initial value of mm numa_scan_seq in per VMA start_seq.
- Allow unconditional scan till start_seq + 2.

Result:
SUT: AMD EPYC Milan with 2 NUMA nodes 256 cpus.
base kernel: upstream 6.6-rc6 with Mels patches [1] applied.

kernbench
==========		base                  patched %gain
Amean    elsp-128      165.09 ( 0.00%)      164.78 *   0.19%*

Duration User       41404.28    41375.08
Duration System      9862.22     9768.48
Duration Elapsed      519.87      518.72

Ops NUMA PTE updates           1041416.00      831536.00
Ops NUMA hint faults            263296.00      220966.00
Ops NUMA pages migrated         258021.00      212769.00
Ops AutoNUMA cost                 1328.67        1114.69

autonumabench

NUMA01_THREADLOCAL
==================
Amean  elsp-NUMA01_THREADLOCAL   81.79 (0.00%)  67.74 *  17.18%*

Duration User       54832.73    47379.67
Duration System        75.00      185.75
Duration Elapsed      576.72      476.09

Ops NUMA PTE updates                  394429.00    11121044.00
Ops NUMA hint faults                    1001.00     8906404.00
Ops NUMA pages migrated                  288.00     2998694.00
Ops AutoNUMA cost                          7.77       44666.84

Link: https://lore.kernel.org/linux-mm/ZSXF3AFZgIld1meX@gmail.com/T/

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm_types.h | 3 +++
 kernel/sched/fair.c      | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 589f31ef2e84..679f076e3a91 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -576,6 +576,9 @@ struct vma_numab_state {
 	 */
 	unsigned long pids_active[2];
 
+	/* MM scan sequence ID when scan first started after VMA creation */
+	int start_scan_seq;
+
 	/*
 	 * MM scan sequence ID when the VMA was last completely scanned.
 	 * A VMA is not eligible for scanning if prev_scan_seq == numa_scan_seq
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5e03ced2b566..c8af3a7ccba7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3191,7 +3191,7 @@ static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 	 * This is also done to avoid any side effect of task scanning
 	 * amplifying the unfairness of disjoint set of VMAs' access.
 	 */
-	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
+	if ((READ_ONCE(current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2)
 		return true;
 
 	pids = vma->numab_state->pids_active[0] | vma->numab_state->pids_active[1];
@@ -3334,6 +3334,8 @@ static void task_numa_work(struct callback_head *work)
 			if (!vma->numab_state)
 				continue;
 
+			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
+
 			vma->numab_state->next_scan = now +
 				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
 
-- 
2.34.1

