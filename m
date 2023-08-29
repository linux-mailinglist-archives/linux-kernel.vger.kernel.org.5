Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4521778BE43
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjH2GHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjH2GHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:07:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2EE123
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwHuH8lyZfIOX6uy7ysdaOXTGDbzRyqIB83ajCb7KXIXNrneL0OLaxKhQujkp/51EDkqgddCScSbSWBfK7IFprIiVaZBwP8PdmfhvoMJhevlCfFKOYaRi3AolzZNXsMnjvxL+pCwDDL5C1wnpm9qJinxYOmzC1X7JoYwYExSSXKWFxvYEGofkBJOe7YIHTDdkV17wA/Eym5pmdMYNtLRdq+pApHLT4TmdDQWL0NaKliTfD8G07EnRCrvRrf5FHMeWOMEyaDAs4+ttLFxD4C57V3/+3A7Z6Ui+Y1lBP2KiCNTKQKHh50B/nQu2FTOgYnv+24mDYHOBKcbjFM2EIM/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEz2+qnb2lnDS8E0XPihouWAu39teWcxGama3d/HlJE=;
 b=kPXzkXkjO002wBOXnTc7YcXZCBjDfuRKJhig9cOREZyAufaKO5EtSd0HaoJx6xUjxYCXOsGjcGfUcGXCv5GB2yphJF4AhW8cOulCh6e8+mBqNbXScqeHl40bcb+nKb0hQjiY6w3kpIdHnwn2RcftXOJON56uvew5fXOMAPxzPoXPfHsHBzqpjskWBujcX7HWC4ggoHSzxpjCEfX30jzEgNb2mM0BTiJkRkIRSITCQoPa3825U8feRAucQloW2Vwbx22wSNcDDzBlaeDLtitjMbyj9MccU9b9BCNW4VRL9rhWzqivtsDolrqaDH5GQsbpIoIAOUIxH8hzFzjeQCheeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEz2+qnb2lnDS8E0XPihouWAu39teWcxGama3d/HlJE=;
 b=tkW9dUVTnH0my/7jP+6xVW4V+kb+Hm4cgN0uCZ/8VsuUzrQevXbAJjbvI/GvpzHL2TJjIE1relN0rj3xCxpVkhzxvvme/kTqzWh/S9oNh/OIMLPUGOzFFMa1u0H7vo0fMe3dpjzPDi8XSJLu6X5yz5pzVxNqsQCEyVZIAM+Oh7A=
Received: from SA9PR13CA0068.namprd13.prod.outlook.com (2603:10b6:806:23::13)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 06:07:32 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::dc) by SA9PR13CA0068.outlook.office365.com
 (2603:10b6:806:23::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 06:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 06:07:31 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:07:25 -0500
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
Subject: [RFC PATCH V1 3/6] sched/numa: Remove unconditional scan logic using mm numa_scan_seq
Date:   Tue, 29 Aug 2023 11:36:11 +0530
Message-ID: <e8269f757a9167579ef61f7f4802d30352ce4a9a.1693287931.git.raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: c9faf779-1997-45ca-7613-08dba8563b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5biHmpdEDFVYJgo4N2fAack4i0ZOMS63ZDUR1Oz7VOZCfNH+6Ovd6rHzwxtuWEJRttFftScKA5O1e5wTjSmxqifBpST70AAii05B+Cp5KgSDLMu9xWuEYzTTwpn8vaSoUDQIGBKa7axdMTmo1Q4OoocJFVBSzKnCxhZ2ukRpOi4FlB5sOobvKoGhO/mzPCGBSMyTUy9ttX1PG1rFywNBTnP4JW5o53Yew7VGiQX/9wR8Rrx95ArDLPiegy2hpBDOpt9qsjKTL0hawrvleGe715yFiKbDu7T4ZXt9sEsIzuCa11RCjI+YWd80kzfIxBu4mYUKxS2FOM1LcKvFJx1Sf38YsQS7J8izYsGEEaVlgMS5ddAZjnkvNsY4yoBnBq+Jtctbhsv/di/WysEE4OHwDXv760rmVAL2MUe5NIr4usHPK9NplOF6wo8p3tn2JyLGdgxCTo6lDQl6Q0J4J3ePrhY2agwOjCZdF0M/YuV5c+1WVsQC+JpTiFVI9n54EVXWXTM6MjxIMKuV+C2a6FGtxpCRP7hdJZU8e7MOnq6l9HefgnaU96ZjzLRNloIBx+eRjTt6MyVK4VT9/0+iyuGm1xDaiaCUmPNzQoeb/xu8uKTfI9M6/KkTIU6KDDCv/ajvnFW744WO3c1sh6UIycj66k1armCNf48jDdEKgXMqtgsj87+2BfGxSKMzo1CBUGm1fg83ZUhb0nTrWoCWlwlbKX8bo+rebX/sB6FiikcgrGLN5lRkteo9c850Zvlj12Z4GNA/aTtmyY0Vb9RovpMsTPuP+EqXlO7uKlDBFbmzHE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(82310400011)(186009)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(6666004)(7696005)(478600001)(83380400001)(426003)(336012)(16526019)(26005)(2906002)(7416002)(54906003)(2616005)(316002)(70206006)(110136005)(41300700001)(70586007)(8936002)(5660300002)(8676002)(4326008)(40460700003)(36756003)(40480700001)(47076005)(36860700001)(81166007)(356005)(82740400003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:07:31.3455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9faf779-1997-45ca-7613-08dba8563b05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is now redundant after unconditional scans introduced for tasks'
disjoint VMAs.

Also this approach was not considering a rare case where a VMA gets
created after mm numa_scan_seq is greater than two.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 kernel/sched/fair.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 23375c10f36e..e26e847a8e26 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2961,14 +2961,6 @@ static bool task_disjoint_vma_select(struct vm_area_struct *vma)
 static bool vma_is_accessed(struct vm_area_struct *vma)
 {
 	unsigned long pids;
-	/*
-	 * Allow unconditional access first two times, so that all the (pages)
-	 * of VMAs get prot_none fault introduced irrespective of accesses.
-	 * This is also done to avoid any side effect of task scanning
-	 * amplifying the unfairness of disjoint set of VMAs' access.
-	 */
-	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
-		return true;
 
 	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
 	return test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids);
-- 
2.34.1

