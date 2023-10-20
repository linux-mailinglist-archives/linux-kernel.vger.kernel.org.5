Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96DF7D134D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377804AbjJTP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377676AbjJTP5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:57:35 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06216D8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAH67m4M0x6s4X09CXkyvTdCc0lXp2Eah0ecH/PIpOH6qyT+V4SQievBtiEfTGtyKU+ajenLsTACWpLSNeSl3Do2h7fZvFTHNj/s20m/FKRGCGWMhW6lA/QQi7T1kmtv5HuqQHTGdwmdNoABxIFjMv9x24yroEXWLt0Wn9SRQc/pZ8u2d2ireQ4QZlbEz6J6ziVj+dYbJ4CvOHUzv8rLSnCTRg027RjOO1LrgHB241TFmZaFA2fMCI5k2iPTiuJrdklWZ4l5kLWdat/Hlc/Qba8oas4LQDMXtSJwL9byKtHFAgAKg/VgTOEXZiyN8zE5lcTiyNUkjv0Y69t5sAwh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnjffVlKH4Hr1H/LKb6+KG9T9P8saUndmkezQxjVB5A=;
 b=QwQzk3VoCw5580ZfywNh/GEvwE8R7VWmyYbAn3LeB00c4v1l2HKJLicblhOM1G9D4Cm1zZlHwQMy9d0RXR9Osvv+WFMvWj7LcJlQluA2vA45X5LxQGPfcWUYlsG6o+s4L8jg6UA1l6PN8rnCXXt0IOY3R1+jI1pdRg4IyXbS9UfErZgnV6jqvAsFEZYCYsqh7uH50bII+utXnCzYKiZhVHCHl0a6vAQlSzGHJTQicnIMf38j82ADDiTdjpD6Fuyu24E6QfJMDMypYC7uDgdF0kZciBneyIdIhZZhMAEK64h9vCaoeqwXE+45si+hp41+MybvsMopkQrBd5vXMJ2PjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnjffVlKH4Hr1H/LKb6+KG9T9P8saUndmkezQxjVB5A=;
 b=ijVQI1ggaxZynkHQNm7oNPlHA1VqANAu89H/5oqCVMuzk8FWamvsUnr357YPvQ2Wt82O9UylZyZAybfqDVwal3Icu+hOxzSESx3JPAmH7/ptJvnzKp1HRYSsLJ0WGGAXbYDs4NUrcQw6TO9rjE5P/hkRSWCeR4cKvvjHtVD0QX0=
Received: from MW3PR05CA0005.namprd05.prod.outlook.com (2603:10b6:303:2b::10)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 15:57:29 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::73) by MW3PR05CA0005.outlook.office365.com
 (2603:10b6:303:2b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8 via Frontend
 Transport; Fri, 20 Oct 2023 15:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.22 via Frontend Transport; Fri, 20 Oct 2023 15:57:28 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 10:57:21 -0500
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
Subject: [PATCH V1 0/1] sched/numa: Fix mm numa_scan_seq based unconditional scan 
Date:   Fri, 20 Oct 2023 21:27:45 +0530
Message-ID: <cover.1697816692.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: dba973d3-4f22-4ac4-3ac5-08dbd18542d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUbu2moHcOmkkIFri/oMHX0p/67wZy7s1s4otIxB/TbK6IkO4RnEKwK8ywA89+Rp4lg1g+IkvKikF+CrW2w9ySiUipzl63SmbVganXknwtmxVPPNPlDwEc5a3DEQwST6IRZ5ujtXi2reqhF9mD6zb9Dm5DS2HnuK1YtHYUBIl3MnpeZT2ZFLrYgFvPXosN7mac/iFADhgDsGpV0thGlcGiQEw1Badu0B3gcqgJEsA1jhlXOQAi6naR8mW/pN56uekzVG+fve6vwG9onoieeIwedquldHhAKRSrrw9fE7GdN0VEDDroqqrF3SEt/ov3TKP5B1uorDvIGVrTRLXGGSiPEZzq1XA31pfzRYnLu6n9VqpRpqBVXD6tXZFdb73+RE5jFJWly417S1gqFA/Nz0Mvlu87KdSauMNgX4gqUet/f/4JW1dWRbrQAQFHdg5KdixB8BCcNdL1RRRu5hN/OVIjx58rR/4p3lP5X5H0S1jnry0QVD5GV5VpE7Ic5HWGe31lt5c6WeWxDnXFXl/0pwb79ib72lSB1IsRxBrsZ1Gdvif9Gqgcs2Pk1w16E3egNWlbT2quEoqWGUxfvHHsHvgTfXq3LAS7Q7Lb5J2d71M/TzagkfO0/sIbln9j1aKPvFwyncVlUc3Q2sroT9aIDqrQWWK/3ga/3H6+P3i64n310HiQzBJFWIKbktlVa2D9mrqjKUGbiZl7TaaBbkCpVFkWbVBhzb8VLCXqpHsg4gzPVM8n4Wp6sT5gHQu2sRehcnvPUH60e4JeS4R4L0AuF4JQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(2616005)(7696005)(40460700003)(81166007)(356005)(36860700001)(36756003)(82740400003)(4743002)(426003)(336012)(26005)(7416002)(41300700001)(2906002)(6666004)(40480700001)(478600001)(966005)(47076005)(83380400001)(16526019)(8676002)(8936002)(4326008)(5660300002)(110136005)(70586007)(316002)(54906003)(70206006)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 15:57:28.3645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba973d3-4f22-4ac4-3ac5-08dbd18542d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA balancing code that updates PTEs by allowing unconditional scan
based on the value of processes' mm numa_scan_seq is not perfect.

More description is in patch1.

Have used the below patch to identify the corner case.

Detailed Result: (Only part of the result is updated
in patch1 to save space in commit log)

Detailed Result:

SUT: AMD EPYC Milan with 2 NUMA nodes 256 cpus.

Base kernel: upstream 6.6-rc6 (dd72f9c7e512) with Mels patch-series
from tip/sched/core [1] applied.

Summary: Some benchmarks imrove. There is increase in system
time due to additional scanning. But elapsed time shows gain.

However there is also some overhead seen for benchmarks like NUMA01.

kernbench
==========		base                  patched
Amean     user-128    13799.58 (   0.00%)    13789.86 *   0.07%*
Amean     syst-128     3280.80 (   0.00%)     3249.67 *   0.95%*
Amean     elsp-128      165.09 (   0.00%)      164.78 *   0.19%*

Duration User       41404.28    41375.08
Duration System      9862.22     9768.48
Duration Elapsed      519.87      518.72

Ops NUMA PTE updates                 1041416.00      831536.00
Ops NUMA hint faults                  263296.00      220966.00
Ops NUMA pages migrated               258021.00      212769.00
Ops AutoNUMA cost                       1328.67        1114.69

autonumabench

NUMA01_THREADLOCAL
==================
Amean     syst-NUMA01_THREADLOCAL       10.65 (   0.00%)       26.47 *-148.59%*
Amean     elsp-NUMA01_THREADLOCAL       81.79 (   0.00%)       67.74 *  17.18%*

Duration User       54832.73    47379.67
Duration System        75.00      185.75
Duration Elapsed      576.72      476.09

Ops NUMA PTE updates                  394429.00    11121044.00
Ops NUMA hint faults                    1001.00     8906404.00
Ops NUMA pages migrated                  288.00     2998694.00
Ops AutoNUMA cost                          7.77       44666.84

NUMA01
=====
Amean     syst-NUMA01       31.97 (   0.00%)       52.95 * -65.62%*
Amean     elsp-NUMA01      143.16 (   0.00%)      150.81 *  -5.34%*

Duration User       84839.49    91342.19
Duration System       224.26      371.12
Duration Elapsed     1005.64     1059.01

Ops NUMA PTE updates                33929508.00    50116313.00
Ops NUMA hint faults                34993820.00    52895783.00
Ops NUMA pages migrated              5456115.00     7441228.00
Ops AutoNUMA cost                     175310.27      264971.11

NUMA02
=========
Amean     syst-NUMA02        0.86 (   0.00%)        0.86 *  -0.50%*
Amean     elsp-NUMA02        3.99 (   0.00%)        3.82 *   4.40%*

Duration User        1186.06     1092.07
Duration System         6.44        6.47
Duration Elapsed       31.28       30.30

Ops NUMA PTE updates                     776.00         731.00
Ops NUMA hint faults                     527.00         490.00
Ops NUMA pages migrated                  183.00         153.00
Ops AutoNUMA cost                          2.64           2.46

Link: https://lore.kernel.org/linux-mm/ZSXF3AFZgIld1meX@gmail.com/T/

Raghavendra K T (1):
  sched/numa: Fix mm numa_scan_seq based unconditional scan

 include/linux/mm_types.h | 3 +++
 kernel/sched/fair.c      | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

---8<---
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 010ba1b7cb0e..a4870b01c8a1 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -10,6 +10,30 @@
 #include <linux/tracepoint.h>
 #include <linux/binfmts.h>
 
+TRACE_EVENT(sched_vma_start_seq,
+
+	TP_PROTO(struct task_struct *t, struct vm_area_struct *vma, int start_seq),
+
+	TP_ARGS(t, vma, start_seq),
+
+	TP_STRUCT__entry(
+		__array(	char,	comm,	TASK_COMM_LEN	)
+		__field(	pid_t,	pid			)
+		__field(	void *,	vma			)
+		__field(	int, start_seq		)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		__entry->pid	= t->pid;
+		__entry->vma	= vma;
+		__entry->start_seq	= start_seq;
+	),
+
+	TP_printk("comm=%s pid=%d vma = %px start_seq=%d", __entry->comm, __entry->pid, __entry->vma,
+			 __entry->start_seq)
+);
+
 /*
  * Tracepoint for calling kthread_stop, performed to end a kthread:
  */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c8af3a7ccba7..e0c16ea8470b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3335,6 +3335,7 @@ static void task_numa_work(struct callback_head *work)
 				continue;
 
 			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
+			trace_sched_vma_start_seq(p, vma, mm->numa_scan_seq);
 
 			vma->numab_state->next_scan = now +
 				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);


-- 
2.34.1

