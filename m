Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7627D6387
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjJYHiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjJYHh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:37:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52673A91;
        Wed, 25 Oct 2023 00:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAtQDA9+mf3bKHBddLM5gS0PfebaA2bMr4Ba1UQ6ifh3KSQR+ldiRGY9M8IRDwsmQvyzutf8xs5YQuCBAEUNdyWgnDhJZctG9i6h6Xre65dpIdxrmJIKsczJWjde0CpjUeAhKOqeHp+kXjVV2HryhxG4RkoiIGf8zHhKvQnYKEnsw0nBXF61CvJxGIUVrOhCPxiKB6HKZLzHScQhCI5zcRlN7LGlPTRnNx+F2J6F9lsSLDOf5FOZ85C+031Pj3HkRaiU+L5WfnOQBaLPwiAsD9PtpfhP46i/dR2/hPhcuRfijFEHWoSM3e+oIDF8MZO7av2LrlDKTxEKvjx6+Utsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58+8MI1ep5pIvy1pEqzcwy6/uPtpk6PWlvlZeA+v2x4=;
 b=C6KNA+mzWULBJ7Jg70L+JhzZaADkShY/PXcyXpVg4Qyo4yk/pB94TC1dgMCr1+PcX+W53jfUtfDLN2Mfonk7xc3mh92P6DfWXV635iCZudSQNnPeMqdtmgqXGSsHfW8gWoG0SBsTkQkDbTIP1NKaRNu6gYX+fFSte8d4zoP8A4s1e5BXnHuQDU+BYdA/SihLSJtgLXYwwL/GxlBMRTbpodYJXe2Y2Yn4nfngVN6VK4+SEc1k50pLdSgGgtuH/MpSBpQ/XBvhdX46CzFHNbnrMKpYRqERAH9FsZXXG6P7ov6k+DeCfvvfGO9PYxEB8l5UEISutRrWZXOmzT+UuVQZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58+8MI1ep5pIvy1pEqzcwy6/uPtpk6PWlvlZeA+v2x4=;
 b=sYtOfsPXc96HgkLjIFISlxkRw64WG2RA+0lIiFozvhkiNUOL7xIs8kTSFoYlvMG4LDWp+wvvZygVcojBM9MmlWClEZoBS+sro5jOd6ZHftQ6DmQSKJXFT4W8XmvHx07JpJk8m0aCIQ9ZgiYE2w3maCYGZ69QHbgSX+KDvkar8a0=
Received: from BYAPR21CA0022.namprd21.prod.outlook.com (2603:10b6:a03:114::32)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 07:35:21 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::b6) by BYAPR21CA0022.outlook.office365.com
 (2603:10b6:a03:114::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14 via Frontend
 Transport; Wed, 25 Oct 2023 07:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 07:35:20 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 02:35:17 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 4/7] RAS: Add static lookup table to get CS physical ID
Date:   Wed, 25 Oct 2023 07:33:36 +0000
Message-ID: <20231025073339.630093-5-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025073339.630093-1-muralimk@amd.com>
References: <20231025073339.630093-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 15db8450-d0c7-47f5-11de-08dbd52cf170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iB+CBnyYufBMuHgqws1ahWzvTGj72o4FzKF17qgAsL8jr1V4AkkpV8zFykKrVKyKM70s85hBJSK4wHlAl+Nvn1kItFQSZQbT9Vlc2Regd6d7UvgG6LlZPxtIogKeDqADcFiLZL6/HJnYY6Pc4cvH/Gil5cjLEEjEXVwoQWGsbrqqO5AYjSJBMljRm2pCB1ctDa3kzcd3Gbfi4Esbzmao8I5y/4fqo9rxbWQP85jYxnc/j/3kwtKvoA3hmSdTn/c7zzv0JPB6SLnkP5CSgzb5kXGjlpRtH0200LVjOdPy0bPeamsmhDUqGhWnuSjcPfTsyGP7NQ4JGGS9QLx7ZgtQmnXYFvU0T5NeZOda85UH0msJq0uT6LhmX9GfyGH6I0Mf/o5RjzNNkRtR7k2PQqmYLMajUBmRLY+362BkmA9KT7ZBC/GwUslIMX4pKj4409iPMOerry3XXWN2JqJWDgfM5v5eI3i3WWbNKEsprLULYIRDron1GAURMU0ugyqVbVKdAdvWlwswi5WCGmECGPqoim5Eop6a9xDu1dAk6fiDn25jM3hvBujmKtXg8gn1awpFcX7r9JugMGCNZZDZ6tl6lMcNhIQh1GCrSemu5x49tw0GnAMc+9O426fPF6lE5MywU4CTyJMcvQHKPb7vbvFrwpd2cdjIk0aBpIYE+qTPx9D53LXFgI48vAHmgn1ceRC3XszLd+7pB08MxTLIAdkKwo1Y5ObEy9/LRihIifnvIabuI9frseASUt1WgLq7C/oFREZKFTYjXCXr4MvE9GBJew==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(36756003)(2906002)(316002)(36860700001)(41300700001)(110136005)(70586007)(70206006)(54906003)(5660300002)(8676002)(8936002)(4326008)(478600001)(356005)(82740400003)(6666004)(40480700001)(40460700003)(47076005)(16526019)(7696005)(2616005)(26005)(336012)(426003)(81166007)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:35:20.7425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15db8450-d0c7-47f5-11de-08dbd52cf170
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

AMD MI300A models have a single Data Fabric (DF) instance per socket.
So, all 4 AIDs are not software-visible (using PCI Device 18h, etc.).

The MCA_IPID_UMC[InstanceId] field holds the SMN base address for the
UMC instance and SMN address mapping repeated same for each of all 4
AIDs in as socket.

Add a static lookup table by reading the UMC SMN address from the
MCA_IPID_UMC[InstanceId] field and use the value to look up the
CS physical ID from the table.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/ras/amd/atl/umc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index fa8c3072a54f..52247a7949fb 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -153,6 +153,35 @@ static int umc_ondie_addr_to_normaddr(u64 mca_addr, u16 nid)
 	return mca_addr;
 }
 
+/*
+ * MCA_IPID_UMC[InstanceId] holds the SMN Base Address for a UMC instance.
+ * MI-300 has a fixed, model-specific mapping between a UMC instance and its
+ * related Data Fabric CS instance.
+ * Use the UMC SMN Base Address value to find the appropriate CS instance ID.
+ */
+static const u32 csmap[32] = {
+	0x393f00, 0x293f00, 0x193f00, 0x093f00, 0x392f00, 0x292f00,
+	0x192f00, 0x092f00, 0x391f00, 0x291f00, 0x191f00, 0x091f00,
+	0x390f00, 0x290f00, 0x190f00, 0x090f00, 0x793f00, 0x693f00,
+	0x593f00, 0x493f00, 0x792f00, 0x692f00, 0x592f00, 0x492f00,
+	0x791f00, 0x691f00, 0x591f00, 0x491f00, 0x790f00, 0x690f00,
+	0x590f00, 0x490f00 };
+
+/* MCA_IPID[InstanceId] give the Instance Number UMC SmnAddr */
+#define UMC_PHY_INSTANCE_NUM GENMASK(31, 0)
+
+static u8 fixup_cs_inst_id(struct mce *m)
+{
+	u32 smn_addr = FIELD_GET(UMC_PHY_INSTANCE_NUM, m->ipid);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(csmap); i++) {
+		if (smn_addr == csmap[i])
+			break;
+	}
+	return i;
+}
+
 static u8 get_socket_id(struct mce *m)
 {
 	return m->socketid;
@@ -187,6 +216,10 @@ static u64 get_norm_addr(struct mce *m)
 #define UMC_CHANNEL_NUM	GENMASK(31, 20)
 static u8 get_cs_inst_id(struct mce *m)
 {
+	/* MI300: static mapping table for MCA_IPID[InstanceId] to CS physical ID. */
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		return fixup_cs_inst_id(m);
+
 	return FIELD_GET(UMC_CHANNEL_NUM, m->ipid);
 }
 
-- 
2.25.1

