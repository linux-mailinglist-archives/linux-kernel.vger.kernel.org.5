Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41057F0287
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjKRTd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjKRTdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:16 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FAD1AD;
        Sat, 18 Nov 2023 11:33:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RohPjXMQPs/bPPdf/e7C3F92EBelNz1HkoA/mg1Ysuk/fAXyvxc6VMWepFV8U7835Jb8fBw76scUqMdtcyxME8adDrAl7jAHGJ4U7CZFGAYQvP0797qdPrMbh/2ENao0MRb4HjUwH68N9nJ7Z0uYPJG40P6qTkhGN7A08LELfkVEnSX4I6ihtFlZufHL3Gli4pcqsNVzzsUd5PNuIXz1hCtEbXP3RtJmX2O9II69te3F1iRnt65oI07rBz6RIr46UhBZjbecmmLKkxlPKabLm0rUK1OZZJQtrd5+wxPGjuVatuGZffnSvjdO8xvvQ+13WFDdtQoB6otNRLbeRWLPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38638wKhhJmWkaGK2DALwfE5ugit3QFutWNfgrgDj+M=;
 b=S0P+SIfQRtBMSBpGT2hBCw0S0+kwPVQfwjGnC6CmDZDxYKbMmATFOWVUM80XwbfUlwkCgOaetzavObWAGu3DGY+Uc+fMhI678PJ49Bz51J5TT2UdvtwNrjhzYSxrCw6+Is1dqOncu7VOG6UJ18r2gneleEvzdZLTwqv/WVggZNvHvW1ve7F2Dgo4OyYKjzCeCkp2U0sq5+Se6zcoAEE6vShrPUNyBfysO1QADbFYwHd82IIM7JXN6dN0Rf0Xpu7JfNUpn+4jF6nNfBvZC3bPGMibNSUZS4SjNVpUlLq3U1H2aTqhIZsDgcAIwyFeAHuHd9ReMhGlsuGC6IvII2M44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38638wKhhJmWkaGK2DALwfE5ugit3QFutWNfgrgDj+M=;
 b=H0Rpat76dz3GAN21vh/w6GV9qDJQCPclFVr147gUvwBve1ftxWchJAtTC8augzo8NrbkdRdYZXPlPWDxPwg1PyTUZGo7fm9ZSPVUc3AkZ12bN6HmoK1W0vTaBtNAUW+TLyHD03Ar2V+hHz9QD2QcTlowQQniXCqkARizq/af8NU=
Received: from MN2PR10CA0008.namprd10.prod.outlook.com (2603:10b6:208:120::21)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Sat, 18 Nov
 2023 19:33:08 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::45) by MN2PR10CA0008.outlook.office365.com
 (2603:10b6:208:120::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:08 +0000
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
Subject: [PATCH 06/20] x86/mce/amd: Use helper for GPU UMC bank type checks
Date:   Sat, 18 Nov 2023 13:32:34 -0600
Message-ID: <20231118193248.1296798-7-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b71e3d8-aa50-430f-9653-08dbe86d3194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzIqh3x+LfGwY33WujhQoN1VD8f8XP/JAUElH1elSVCUvVYhJPnliqlTYynkb6fu7iZJS4OJweBzVohQCxeaCaAd5gndYpKcbL9j5E9rFG99PFQ5qYeEfuOjjfSD6Tfv42e1EzguUGLaoVGrHD7Sef0PJARSO81s0dh3ijAjXEYkimFmBeW74usLSQBe6r5jrv39hLuJbCHKh6nrFgIbzQdbbfNHwMHPgqvw3ccRkSUXKqL4T7VwkzCJIjwHhh0UUmIEJI5+YuXiY+O4VXiL1/t9ivc384ETCdM1IPUThYRg02tu/78XC/YQJpE/vOm1XQ4dQLVm6xz8uCoPcwKr2Jx1Kmv6uKrqmHFX6C9AEjClSAw+Jt88+WKbWkJwNUlA+eOePzIf0A6/2ItNyE9QAzKT79rK2CaPAiPxR/b0/Zpvo/KgPz5bzNSCKCZ5lkfi9Wcs0x4Y36rlWUO0FMIYkqqQqGAP3pyZ0kWaLVeCS/ip3NxFNNQWUOiykaS9EbWDepN6MLJesEE7NPumwu8dt1USDg2mIKDdpsZ0nGKxOk+1WFz428MkITiFPEqAPXlnBcZZ/ucdmVCUT/WBOA/0CABgxd1LRJiFK5GoYxlQpgOQU++Gwg9dbP1tqyn2++33U1p6wyTlfbVPcmuP74asVNSfCSZdVXWMbXwhmVwoXA1W7XCcCkaoP0atVdxLBwQeLYwTffjv5ETaQu9jwPQwFzxbKlEWVn8wJFdpNqrB1MwKUqhtO+w5frpCkbdJ6K2ZUdMIlLl3MAitrMY2Cj2vXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(36756003)(15650500001)(40460700003)(5660300002)(2906002)(54906003)(41300700001)(336012)(82740400003)(478600001)(6916009)(70206006)(36860700001)(316002)(356005)(26005)(70586007)(16526019)(1076003)(86362001)(7696005)(47076005)(6666004)(2616005)(81166007)(83380400001)(44832011)(426003)(4326008)(8676002)(8936002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:08.3645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b71e3d8-aa50-430f-9653-08dbe86d3194
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of an Scalable MCA bank should be determined solely using the
values in its MCA_IPID register.

Define and use a helper function to determine if a bank represents a GPU
Unified Memory Controller (UMC), and where the exact bank type is not
needed.

Use bitops and rename old mask until removed.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h              |  4 +++-
 arch/x86/kernel/cpu/mce/amd.c           | 12 +++++++++++-
 drivers/edac/amd64_edac.c               |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  9 ++++-----
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index c43b41677a3e..012caf68dcbb 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -59,8 +59,9 @@
  *  - TCC bit is present in MCx_STATUS.
  */
 #define MCI_CONFIG_MCAX		0x1
-#define MCI_IPID_MCATYPE	0xFFFF0000
+#define MCI_IPID_MCATYPE_OLD	0xFFFF0000
 #define MCI_IPID_HWID_OLD	0xFFF
+#define MCI_IPID_MCATYPE	GENMASK_ULL(63, 48)
 #define MCI_IPID_HWID		GENMASK_ULL(43, 32)
 
 /*
@@ -341,6 +342,7 @@ extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
+bool smca_gpu_umc_bank_type(u64 ipid);
 #else
 
 static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c8fb6c24170f..6fc35967b11b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -150,6 +150,16 @@ static bool smca_umc_bank_type(u64 ipid)
 	return FIELD_GET(MCI_IPID_HWID, ipid) == 0x96;
 }
 
+/* GPU UMCs have MCATYPE=0x1.*/
+bool smca_gpu_umc_bank_type(u64 ipid)
+{
+	if (!smca_umc_bank_type(ipid))
+		return false;
+
+	return FIELD_GET(MCI_IPID_MCATYPE, ipid) == 0x1;
+}
+EXPORT_SYMBOL_GPL(smca_gpu_umc_bank_type);
+
 static const struct smca_hwid smca_hwid_mcatypes[] = {
 	/* { bank_type, hwid_mcatype } */
 
@@ -312,7 +322,7 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 	}
 
 	hwid_mcatype = HWID_MCATYPE(high & MCI_IPID_HWID_OLD,
-				    (high & MCI_IPID_MCATYPE) >> 16);
+				    (high & MCI_IPID_MCATYPE_OLD) >> 16);
 
 	for (i = 0; i < ARRAY_SIZE(smca_hwid_mcatypes); i++) {
 		s_hwid = &smca_hwid_mcatypes[i];
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9b6642d00871..b593795e1e6b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1032,7 +1032,7 @@ static int fixup_node_id(int node_id, struct mce *m)
 	/* MCA_IPID[InstanceIdHi] give the AMD Node ID for the bank. */
 	u8 nid = (m->ipid >> 44) & 0xF;
 
-	if (smca_get_bank_type(m->extcpu, m->bank) != SMCA_UMC_V2)
+	if (!smca_gpu_umc_bank_type(m->ipid))
 		return node_id;
 
 	/* Nodes below the GPU base node are CPU nodes and don't need a fixup. */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 84e5987b14e0..7235668b3cc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3279,12 +3279,11 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	uint32_t umc_inst = 0, ch_inst = 0;
 
 	/*
-	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
-	 * and error occurred in DramECC (Extended error code = 0) then only
-	 * process the error, else bail out.
+	 * If the error was generated in a GPU UMC and error occurred in
+	 * DramECC (Extended error code = 0) then only process the error,
+	 * else bail out.
 	 */
-	if (!m || !((smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC_V2) &&
-		    (XEC(m->status, 0x3f) == 0x0)))
+	if (!m || !(smca_gpu_umc_bank_type(m->ipid) && (XEC(m->status, 0x3f) == 0x0)))
 		return NOTIFY_DONE;
 
 	/*
-- 
2.34.1

