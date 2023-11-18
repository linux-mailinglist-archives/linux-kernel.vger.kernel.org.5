Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209A77F0299
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjKRTdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjKRTdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:16 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA645D4D;
        Sat, 18 Nov 2023 11:33:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9g6YNCAvXDSVjI5yIyVhIjqL3e4qFLecDyJI6FFdI8hdNeqBAtFIKqgwxMCoa+quaWCe8BuICKoHGqT2ZD2YCgMRSOFfriUirEz12dhbAUfelL1+E64NuYc2OJbuPJQ+EpHpTfzGM5z30PEA2oMdeVe///cQuzGTSQbWxDaLRdYXvHQhKbQr+0Q9H/SMlxOaVlpboPKEkjY3SXyGl5pDlX9sbpkrcI0hO7EV1OD5kufzqb/15nvVrlK4Wuc/on84z4CpICPD1RZsuF4vf5tVpzJGi1Zy6XlzL725KGL2+0QFIXrpwEaSDrkn6FFNIqvEeZ2AR1v1l88cXlyHIv0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYB+IucDCol4XrB3njZyw4LDuS8caYEqMgMjfEntg58=;
 b=BNv6G49fEQFESKr+l7vr+P5pXj+M5slbdt771Gv7mTZE6Q2xpbHyq2Sk8caz1897hS6AG1cESttT8XChSFhpbiXgqfmzLm8jiQAITDcUoaVsjpgiw0DsJm5quwoGWDWVT317Vdn0ePdAfZpLmwofGjc8i+aVNFcuUEkMtNRz5puzWhpxdn+2denLibXkzIuJ4stv3QOuq+6lTyzbjjLWVG4khdsE5am7KeCvzLyieffRe2GzA5omQNfLBP9mfCkjRBgc1vb83SSwRVrA05ft8703uAxrvnbemPh2Sb8VPhuLTniORymtiEovZHN91SW2NVgHXSanRs+FCXZjYooHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYB+IucDCol4XrB3njZyw4LDuS8caYEqMgMjfEntg58=;
 b=AfgV97f5es+BXiNK4q/bnyQbsGXL592Jq2+t4G8Ov0MtrCp+0flv6VrW3d/nViqti08QpZnbLpMOyfbE2XEgaSIDSldjOTMuT2T/1dIbjhW9r9Ofc9SIuyrxA5QerK2911FaqzxbzYHCVQ2JSDIbrs/4d33E45gGL11fIwVBh9A=
Received: from MN2PR10CA0009.namprd10.prod.outlook.com (2603:10b6:208:120::22)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 19:33:09 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::97) by MN2PR10CA0009.outlook.office365.com
 (2603:10b6:208:120::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:09 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:03 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 07/20] x86/mce/amd: Use fixed bank number for quirks
Date:   Sat, 18 Nov 2023 13:32:35 -0600
Message-ID: <20231118193248.1296798-8-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: a7669b20-3fb8-4a78-7df0-08dbe86d31fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qk7bB5BhJxqBjhBu5qOyW8VVpK00CKlMsj0+qgQqQhQCF2f3/9LaqLw/aIOLS3X2lIq2bREDWAu4OAJ8kG4gausLMwBkaiVXZNpwuJFkqVKmSGEeCnlfPOdORTG5fXMLBkWACRMVM5C2/nfcJ0H7S9sEi0ZriSfSyellTAuTlvGvGVfe3cQMgrR0gnVWD2yoLXIXjp3AXWt3lcTQgipfhEDlyCSg4NCRZ1GNtdWQI+CX69ao+jx80gWyaQdY9QrqPKBCk/vK5GOnVjeNRK2AAQKyOqOK8IyVub3CKo+PKerVD5b6HCi6MH5XIBfyb1zTpLo00SanRlvgJwLSujwso+cOf0NzrqCgN9z32peclMo2tbL9ja26a0Xb/zPwtxfJ/fxcxqwY9M5VInSzZL1C+vRVG6MsjnkgowVqV4JFiobQK9RMXYTsH4qS6ErQ1ufbpnoHxLadBEkFALdZc1L9qidKq1xQpxdR6r2fRxUS6rugQ9K/Duux8K1jz5aj3dqBoCYFYrxNwU+BfwuajDLHHITuyE1tCzzMO8TuIgS8YJOxdm5MLz10/qiqj7Pf8MPETwJXolzXpDCM7lDq8OweixXjCQ8v6k01wQXkjDSOi9ddM6AkSmA6lUcaOqy3y7nBR/4zBzgXHbu8AFvfKnEgP7kCyi+NVmqP0C+ekB8gjVuoetozhPrIU5pvWYP5cE4M8w97Zx7iAD8Cif72pCgugmyCZRR27pCNMdU0lELNHz2lBT7W8FD2aIKG/W7ftRbIGfTau3l/BYQtyxoz7oi/dQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(2906002)(36860700001)(47076005)(83380400001)(15650500001)(82740400003)(356005)(81166007)(40460700003)(41300700001)(316002)(70586007)(54906003)(6916009)(70206006)(6666004)(40480700001)(7696005)(86362001)(36756003)(478600001)(26005)(44832011)(16526019)(5660300002)(336012)(426003)(1076003)(2616005)(4326008)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:09.0520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7669b20-3fb8-4a78-7df0-08dbe86d31fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quirks break micro-architectural definitions. Therefore, quirk
conditions don't need to follow micro-architectural requirements.

Currently, there is a quirk to filter some errors from the
Instruction Fetch (IF) unit on specific models. The IF unit is
represented by MCA bank 1 for these models. Related to this quirk is
code to disable MCA Thresholding for the IF bank.

Check the bank number for the quirks instead of determining the bank
type.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6fc35967b11b..6e100024498a 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -616,13 +616,12 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 
 bool amd_filter_mce(struct mce *m)
 {
-	enum smca_bank_types bank_type = smca_get_bank_type(m->extcpu, m->bank);
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	/* See Family 17h Models 10h-2Fh Erratum #1114. */
 	if (c->x86 == 0x17 &&
 	    c->x86_model >= 0x10 && c->x86_model <= 0x2F &&
-	    bank_type == SMCA_IF && XEC(m->status, 0x3f) == 10)
+	    m->bank == 1 && XEC(m->status, 0x3f) == 10)
 		return true;
 
 	/* NB GART TLB error reporting is disabled by default. */
@@ -654,7 +653,7 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 	} else if (c->x86 == 0x17 &&
 		   (c->x86_model >= 0x10 && c->x86_model <= 0x2F)) {
 
-		if (smca_get_bank_type(smp_processor_id(), bank) != SMCA_IF)
+		if (bank != 1)
 			return;
 
 		msrs[0] = MSR_AMD64_SMCA_MCx_MISC(bank);
-- 
2.34.1

