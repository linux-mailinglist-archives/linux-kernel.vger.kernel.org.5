Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD58278BE46
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjH2GIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjH2GHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:07:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976B318D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wa/DYEqd1uxiRSqiZ2ivJQqhnTGn0NkJTZWGJPQBwRRSRdaK75z4oyQYzaeNm1Cficcq4tLzd2exr4Vk1P+SSx+RoKi5f4YHxxNvek3yna45cYgoWR7E4tpMor1MGmnl4/oJxF95rNEBtpO2E+1kTiFmm4maiFODft8vWm2aQ7buU0A3XTqxQcStynbK4/EZCwxMDx4mSv5/sOfSRAjous7pCRCfcljJFIHGAPKZALeFYEaq3w/FRKb6jF+x2s2rp/HgZO/oI6b6RlGx4DwM8bWAKraOxE8ddABOlBwy1p+s9Y7nvh04UaQMxz1bgPII8TevgULLvkIvvRxbM0BR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqQHuMTEJJDtNpFNildcoC/NTNoRUydsBitUUo8dU0g=;
 b=SeHE7ENs1XLlD/+F+QcD1XzVeFkBquQkPdBvZukQ0JBlVY95zDTr4130XL0Uv3ZLWyOA7j/ec8qC2DpDIGSslF6DblgxrVQhWL1oDTBreQzk2lOYeW3iliyoTlD+kZPAllgXKDwwNxhk2Zu7WaEQ4xtUVB4PoL5KByU9L5oo+dlxrgt6wV8kPSiB6oiBWM4rFXZBikaa2U5HrqflOu7T5dXPnwL5nkj9Iazap3nBjQ/jQpH8SXpngA6ob/Qv2w2pfob3pE4R37XOE+P/8UpL563QLuJFfaPDTM95nyh6Dxo8cNYypICRVDt3G5UNGkNnoJER+s6JLTnZeiyQ05uNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqQHuMTEJJDtNpFNildcoC/NTNoRUydsBitUUo8dU0g=;
 b=aj+nFWWc57XKyiqQFLYqwYX7uWp1+c7znXmbKagmfT3isjl5ZK3pKegVb3+MDYdfDDLUEG+HT157dRU0lZpa2CEodEfc7hqU3vvTeypRiKxXhnHmnxAc5hGJmZb/JbVX5QMCu2yndPwoM1pwsAvraGzK96MmkXXwc6woJtN38BQ=
Received: from SA9P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::16)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 06:07:48 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::bc) by SA9P223CA0011.outlook.office365.com
 (2603:10b6:806:26::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Tue, 29 Aug 2023 06:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 06:07:47 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:07:41 -0500
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
Subject: [RFC PATCH V1 6/6] sched/numa: Allow scanning of shared VMAs
Date:   Tue, 29 Aug 2023 11:36:14 +0530
Message-ID: <0ff0d56b88a64e2017b427f37b15ab41aa5d4019.1693287931.git.raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: a9766cea-cf3e-48c4-cf1d-08dba85644e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfPr6kq8rqe2EGdrAEEE+fJA1uNbGBTr7Wczi3D6wnECj6wJKahi7SyPVoPOzAED+Un+I53agTVyyWBeO3RYB54/pSMhBjk3gFuSlVRNhrQqNfirzyDI/ble2nodM8H6ioy8v0lFKxfrMkiJzibmWhnqhjHhvnGMq+tTKy0/rE2y2ZyM8mCW0epv8dC8Nhe/lVPB8vwMrBvPtyvUAmfyXAKfV5kYWu+2hqUfsHtYAyEKOSEHVr5A8VebV/yPGIXL4Mr6iFZDC1xmBrQc/ei6PKYzMm3uAY2MKjHY4t9d6KgTcSEEpGYL/6jojJ6zZHP4shRXWtqCwIvONlPao1Cylvz5SJFyt1h4CerBWKsgmHBuJBBd3RTl8nBsj634fiCDAL1ePBIg1korPACOWsA/nkChMjFa0PR5dDfqMc9bV2k7y2ZXp8WFaaYmTk17eXui16dOy5Ue47zTf8i3rGy96U3CP7L8JJ+nk/UJjAkHSIbxORn+oAeM9Iu7Z/74uIqNFTP4/mRSVCZi1TtFBaMOBPNexvgxjaPBlvn8ykX0IQ/FDC6lV90gkRnw9pjfxNDSLXVoLej05QEiah/sdfcA8dXBfOT9XxulxxJIfX8xEqpidiYw/INdGOnDDVSrLOj5XXzSfTqK56y+47AzINtlVG50pRVPE57ikkrsgKPuV9gmIS7xsA+eLIOzr7DPh0fXc5yYRR+h15Q5JmpgIbs9sEAvO84JoUyLgGvvIPWS7NcA2R5Lvjv8cfXgtv2pR8BnBg4IxFahssDwJ0H3Q5kJASdQBUWvsl03b1UaEJNoC7A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(82740400003)(6666004)(7696005)(36756003)(40460700003)(356005)(81166007)(40480700001)(36860700001)(47076005)(2616005)(2906002)(336012)(426003)(26005)(16526019)(83380400001)(478600001)(110136005)(41300700001)(70586007)(54906003)(70206006)(8936002)(8676002)(4326008)(5660300002)(7416002)(316002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:07:47.8931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9766cea-cf3e-48c4-cf1d-08dba85644e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VMAs being accessed by more than two tasks are critical. Scan them
unconditionally. Note that current patch considers full history of
VMA access.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 kernel/sched/fair.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6529da7f370a..70c8e62c1a89 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2981,6 +2981,19 @@ static inline bool vma_accessed_recent(struct vm_area_struct *vma)
 	return (bitmap_weight(pids, BITS_PER_LONG) >= 1);
 }
 
+#define SHARED_VMA_THRESH	3
+
+static inline bool vma_shared_access(struct vm_area_struct *vma)
+{
+	int i;
+	unsigned long pids = 0;
+
+	for (i = 0; i < NR_ACCESS_PID_HIST; i++)
+		pids  |= vma->numab_state->access_pids[i];
+
+	return (bitmap_weight(&pids, BITS_PER_LONG) >= SHARED_VMA_THRESH);
+}
+
 static bool vma_is_accessed(struct vm_area_struct *vma)
 {
 	/* Check at least one task had accessed VMA recently. */
@@ -2991,7 +3004,8 @@ static bool vma_is_accessed(struct vm_area_struct *vma)
 	if (vma_test_access_pid_history(vma))
 		return true;
 
-	return false;
+	/* Check if VMA is shared by many tasks. */
+	return vma_shared_access(vma);
 }
 
 #define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
-- 
2.34.1

