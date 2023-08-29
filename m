Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1BB78BE45
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjH2GIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjH2GHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:07:47 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75812123
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:07:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd8cWr4GYmxgsC4snfcob7DPg6pol2Y5JM24Kze1/YWXl+9UOP7WP7Mn775ggJ1J+ohu4c57HzoEQK0CDTAPOEbjtmtss2rZIpQbVsRzybmBf29qDimqPXyAnVH7BUXMXuZ+dR40G623wvQoZO+8/pXHdnW+3CQPmWLMahH16EaN/+SXtG8Snw/yM4y3HZWZYsuALzTmpOUCmR1ho4WMljAiMY2weFxKjiadrjA9dXtAHfr0t+pRLHCqajdY4X7mZy+2O/j/Dd2QG/zv8c/vyBlhmlUjrxmROMIhdyz9EuTFbiX7KTAolFZnvJeZ5bVEx4d2TqRsDj79GlrfBjVqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRMnvEZFZa+SXREsx1mEu87gMe0ygE3/OYfP96M/kuI=;
 b=XMLRmd1cEn9081XVxguoqMZnA+/KypUKyO1Tw24+vK/TCCNZEhOyz0pqXvC5EqvtS7UeHl1Pbyi4SJcJjXUD5RQBE26i5/wsKc3xrXuFFfm95d4Tz3fyQ0CuY6rF0yzhqhtisv5wjW8NUqzoaaU/hx7ILLK148+WfaVDxrkFE6rBmxd1rkn+4UmabMoshDYUB+L67s63r1LBKxsKTnt2fEIyPwoMKWzOchaAQ+oXio+n4ESbbevZVJa9cjoo1tIYa+A3JrRX0DhQinwaf19cCeFPSm0hnfQOwNhQ7uFyXVOXrTEtbx29iaGopLMPAPpVoOumcCz46fhv6p8NrjwfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRMnvEZFZa+SXREsx1mEu87gMe0ygE3/OYfP96M/kuI=;
 b=QG/TZBXSPNNfuQN2YtQvQpPAtGZ3DC7aSK1A4ZS4+T6KP62lY8z/0ZhqbinHqxV/9wCnxNSKcPFVwoAWPObvI+sqS4ucvpM0Z6HaTV3vxBae0TVAf+F7uhVQi5Y9dMvsn601GPA2HJRzHiNfQzMle0K8/zpqlmX6malcsNddkCQ=
Received: from SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::34)
 by BN9PR12MB5274.namprd12.prod.outlook.com (2603:10b6:408:11f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Tue, 29 Aug
 2023 06:07:42 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::d) by SA9P223CA0029.outlook.office365.com
 (2603:10b6:806:26::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 06:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 06:07:41 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:07:36 -0500
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
Subject: [RFC PATCH V1 5/6] sched/numa: Allow recently accessed VMAs to be scanned
Date:   Tue, 29 Aug 2023 11:36:13 +0530
Message-ID: <109ca1ea59b9dd6f2daf7b7fbc74e83ae074fbdf.1693287931.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693287931.git.raghavendra.kt@amd.com>
References: <cover.1693287931.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|BN9PR12MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: 967e03bc-4b23-40dc-fa21-08dba8564142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3bo5lY0b4YCgRZ5cCU6gOWX+YW6/n2kkA4nWbeX2qvMf/Q0/ei0dLoSQ2hh6xmi2GNtkUd67U3PSrmdJWwopUyXcCVYfYOp4gc+R7RxdGBlHWtGvn4h+bv01wnn+WE3/Shmv++2MR2zBGbdZ8cUPlH3X9svQjDeSwUJAVMYeSRaki8Zm8PuUJCaMg6OYA8aW4QqxqF5Wiec63WNOmr6ZeiWNXnvsIHyIETKF/DHMKyqDpv0lX+rY0NUSwOWq0Q2kLUVjuiBXHghazRbL2a7Vm524EG3AfJiHe8cEaKFJ6EkGBUBWtwRnD8CUfLfOmPY/U1o+2PisEx4s+W2Tu+UJUHXC1lbXYIfFpvBa9bGneB/F8QcQjSdasoxV+HH4yri7vBeFNMte7TbDMTmgUOJVhSkppCALV3m7I62WoIKRir6b6nZiyEHQBwkvuoVthj+N2WZmCoGtKFKOibPrunV3dUU8+ZmAQ3OVZWRE4eFxwZKGy13/i4bWjaWs6urLUhby6cPCTibJqrTag7t/SH++j8oFV4OFY51DaR0IVKlKTwWEDfop8YHWvVW/wbDvbQYMzL5VgHhUbM4w3JW2g8ICN8W+QrNnUMfuksBzd1BO5BOwmTla9QF3XhwgnjjYfvLuIM1TYfK8iox1+drJgYYAJxwkNU5Td9zgA6K0Dcm7NQD4yby/Q2bntxADjhy9OqVxQo/6t1CP2cao/r9Vy11wR+3uvApBQmIcbwvbjnUOL0HK6WU+QPHY2t7RtTcajH7HK7NRt/d1o2a3RtSumIZJW/D5x3nocM4Rkm3Y5yQn/A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400011)(1800799009)(451199024)(186009)(36840700001)(40470700004)(46966006)(40460700003)(316002)(41300700001)(4326008)(7416002)(426003)(336012)(2906002)(83380400001)(47076005)(2616005)(16526019)(26005)(36756003)(5660300002)(8676002)(40480700001)(36860700001)(8936002)(6666004)(81166007)(356005)(82740400003)(7696005)(54906003)(110136005)(70586007)(70206006)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:07:41.7994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 967e03bc-4b23-40dc-fa21-08dba8564142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5274
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ensures hot VMAs get scanned on priority irresepctive of their
access by current task.

Suggested-by: Bharata B Rao <bharata@amd.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 kernel/sched/fair.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3ae2a1a3ef5c..6529da7f370a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2971,8 +2971,22 @@ static inline bool vma_test_access_pid_history(struct vm_area_struct *vma)
 	return test_bit(pid_bit, &pids);
 }
 
+static inline bool vma_accessed_recent(struct vm_area_struct *vma)
+{
+	unsigned long *pids, pid_idx;
+
+	pid_idx = vma->numab_state->access_pid_idx;
+	pids = vma->numab_state->access_pids + pid_idx;
+
+	return (bitmap_weight(pids, BITS_PER_LONG) >= 1);
+}
+
 static bool vma_is_accessed(struct vm_area_struct *vma)
 {
+	/* Check at least one task had accessed VMA recently. */
+	if (vma_accessed_recent(vma))
+		return true;
+
 	/* Check if the current task had historically accessed VMA. */
 	if (vma_test_access_pid_history(vma))
 		return true;
-- 
2.34.1

