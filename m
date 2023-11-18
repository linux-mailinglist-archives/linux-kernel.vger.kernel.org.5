Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1DE7F029A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjKRTdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjKRTdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41FD192;
        Sat, 18 Nov 2023 11:33:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FC9NjIaFAaaEcLF8zEXJOfgUrRe1TDpU3rjKyfGDlZVKJzC+27GV/0AP1QN39T/c0xz7QTSJhPJRSuX6vMUrBW1F6SNqzU94l/OHx75dz2xf3Q74B5Ld3Tl23HKlj8gh8yxScKcd2bOpx60agNNFH9vfLWIVq6PlarYw3xs63n6ogc08q1fs1/ODY1kk+Wra4JJfEJWRrQDGPNUqytBsLF+VdRrk8PzjzkXFiFiR8cvauv88jNJKZhvKn7jirN6qvXhW4pw+IF4YpB8UT1KkmRvKQTMg99ikemCj/DNU3ydBv4bKnH//hQJPDJjVLgi9y0gt02CXd3SgaUBW4Yf8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0dxyp9FRzUePJH0nDMmW1/4cp+TAt31i7MmM/jvXNU=;
 b=F7CiSvUzgSND63BIulOh/oYXhE3ri17U4z65ulnBgVZ3OnwX2PlJsiLmHgtGjhY3zmw3oV4u4fI6HjpP0q6Ng+/NM6AoOFgjIERB54wbQDxIKqRPjQWb+daJc5oXDhLVH3oH9VRHN6NG8ANsjKanRT6Dgn2dV/BaMI5bCa5YxuVsDn5QHb+UqTbaGjyszW2ztp0wQv8IntmqCrv78VUsxUhOjcOTZ3XcjUfT9HII/VluKZOPOFei4i6D6ebevy3jUISQ9w3DO1bEetxVqE1pVCPXj6Gylg6YCBEVVbkbcmEpc16/LiDvZzRlu6TwL36PJWnjDAaHNr8C6BUfah2GPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0dxyp9FRzUePJH0nDMmW1/4cp+TAt31i7MmM/jvXNU=;
 b=erQveuqUObfkxQjAxnRMqaqTUfXs64qKcjvpYnjS4vhi0CHMdMSiohPTkAjYMav2qjOFJ5iLswfKWBOJvCT+MPvP9OwzoCxn+MLBxCV5fbrI5uBR0SISWZyRKKEbNCfZm+5SHeVopHV+5XvZREE5LZsWndxsfseI9zRwaOpgxfg=
Received: from BLAP220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::13)
 by BN9PR12MB5275.namprd12.prod.outlook.com (2603:10b6:408:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 19:33:07 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::b3) by BLAP220CA0008.outlook.office365.com
 (2603:10b6:208:32c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:07 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:01 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 03/20] x86/mce: Use mce_setup() helpers for apei_smca_report_x86_error()
Date:   Sat, 18 Nov 2023 13:32:31 -0600
Message-ID: <20231118193248.1296798-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118193248.1296798-1-yazen.ghannam@amd.com>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|BN9PR12MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb3f286-3c71-4429-fd8c-08dbe86d30fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmZhPYg5YHBgLEMF7CwBOz4HgPhgryYm51tdHWFl0JkvMNks5ko+VkiwP4WiayMCVHI/1kHvl5a2Z27EHJBLzeTeZ0sckgjMZJ2HLu6PuOWUcJ8Fs8AI9Rp8YyotLClqRJIptpcS7VpWwdAo368sIb9imLp+TZTKWuUM0GAtbmIcka3u1pxGJ+R6PfOhWBjQnBbiwxbnRaGXYlQWUYxkqxEHC7qnKH6CorlTYaw5G9NzyM8I1qlOuTn6zq0sFz4CNRLUReDGL/xrvmGBlwCSlN2TjKgnfMEV/aR0XbrjQj3TegYXAmfHK5rkpsKiEIYVbb6jXJ46fJxRtY7Ou1r/E9/Xg2uwQcL3KabwItAiSm8rLuNZfKA3ul1cdSozA3qRIaq5HEUHlpYvO+7Bv+gXwTyS+av8QYnQe5UMQ4COEEQaFUd/qm14wdIIDqMmsyH54cdvfWgmzFgyHDtAR0a1XHRj5qW2F6JCBhlOi7UwVZt+MPkgZSXYyUVry5keC/91gsKSfbZ3OfUX6UK1mt34gMrJ0AjkQXKMGSbxfhRJHy0hMWCBosKkilb3DU66Mkv0RpWoB3q2ZtL7axbQUw+xR+FiRDTlJAjfJTQFecyosjZqhzBrwl4DIjYcgj8buQckV/f8AfM0q10R/WylSr1atgvgAkjGW/pmoEEZv8CY0RUIK7imiySAPPKzZV+kwvfzxbik/pcFaZuo3FtT26Mx68sfDqkztbijrF1ursXknzuWDtiAEE38be5J8ZEJOCrmiGluoFKERMQCNouZU95cIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(40470700004)(46966006)(36840700001)(2906002)(41300700001)(8936002)(8676002)(4326008)(40460700003)(316002)(5660300002)(44832011)(86362001)(36756003)(2616005)(1076003)(83380400001)(16526019)(336012)(426003)(26005)(82740400003)(6666004)(7696005)(81166007)(356005)(47076005)(36860700001)(40480700001)(478600001)(6916009)(54906003)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:07.3554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb3f286-3c71-4429-fd8c-08dbe86d30fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5275
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current AMD systems may report MCA errors using the ACPI Boot Error
Record Table (BERT). The BERT entries for MCA errors will be an x86
Common Platform Error Record (CPER) with an MSR register context that
matches the MCAX/SMCA register space.

However, the BERT will not necessarily be processed on the CPU that
reported the MCA errors. Therefore, the correct CPU number needs to be
determined and the information saved in struct mce.

The CPU number is determined by searching all possible CPUs for a Local
APIC ID matching the value in the x86 CPER.

Set up the MCA record after searching for a CPU number. If no possible
CPU was found, then return early.

Gather the global MCA information first, save the found CPU number, then
gather the per-CPU information.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/apei.c     | 18 ++++++++----------
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 7f7309ff67d0..33cefe6157eb 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -97,20 +97,18 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
-	mce_setup(&m);
-
-	m.extcpu = -1;
-	m.socketid = -1;
-
 	for_each_possible_cpu(cpu) {
-		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
-			m.extcpu = cpu;
-			m.socketid = cpu_data(m.extcpu).topo.pkg_id;
+		if (cpu_data(cpu).topo.initial_apicid == lapic_id)
 			break;
-		}
 	}
 
-	m.apicid = lapic_id;
+	if (!cpu_possible(cpu))
+		return -EINVAL;
+
+	mce_setup_global(&m);
+	m.cpu = m.extcpu = cpu;
+	mce_setup_per_cpu(&m);
+
 	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
 	m.status = *i_mce;
 	m.addr = *(i_mce + 1);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index e13a26c9c0ac..424c7461dcf9 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -209,6 +209,8 @@ enum mca_msr {
 
 /* Decide whether to add MCE record to MCE event pool or filter it out. */
 extern bool filter_mce(struct mce *m);
+void mce_setup_global(struct mce *m);
+void mce_setup_per_cpu(struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
-- 
2.34.1

