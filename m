Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3212B7751B1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjHIDxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjHIDxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:53:11 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE441981;
        Tue,  8 Aug 2023 20:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMFArlEosY9fVWou4FM69BeOFryH6bnXs/N/1AERYeuu77LF75fG9TVZRPwhB4Pj5EeEicAESXhjDIiBerdgskleOtYAzR0SuGz4xWtDA/o3QIkW+Z7enYVn+0o+OT8z5137dhgaRvObMlYJlewA0iOWyaCNpI/YD4dvi3z/tnrpYjkYil16z5erj71HQqrMldnBQVjEe853lTfGgMMts26kDXUD28pBFfNn/jG3nOMFo9gmiXQYTfI0ee0jZCLeBGeGtEOwY2Vu8CZS7slaAAZXaa8MF8pLzeh3nTtS2O9MLwiVpG9Jv1v8M4u6oK2nONhNBEsv6lBtbHbuRDofRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=285YvYMWoZXnBLNG/an8oCUyFja0ao4SeBYM/7FKyrA=;
 b=kWe9Srtb41JsPa3ca9mZDPTDzulB2cPr3nJLxPWZI/Tw6WWmQwpAvJH4NntfHQ0lwhchAaB9U7zAzCagp01JgZFALrJpo06CLY/mg4oV8s5fhYi9Vz/Mwx1EMTamt9R4sXKEDigi104vlDXNCG1jqCs3GAzAxLz/5GObdO4JgCWpxw/zWMFLdYdbWfKFpBnJ/VgXJFmjt4px3iEpdhuR7E+AFWyXpXkhNXFj+bUOsoWU55BUJHJRG7Lu5Ew/oY3EzXdAlzgRlqBDj9+aTYpNizEeTDwI2FZRLFblv+tlJGx8Gfwkz815QhZIWfbG1FTTZ2Vc1I4qj6QsEKnW384fFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=285YvYMWoZXnBLNG/an8oCUyFja0ao4SeBYM/7FKyrA=;
 b=W0gT95Mg3vMUi4maB2JghlZyjJuX6rm79BYdU/ZS3SPZ0Qu22epXvqO87F7vAeVovdSKqhqKtJDJmTM6Puwgi5+wZqsVlGcPX0owkUPFilz6t6/1Tr55E3U7TyQIsqegv20TYjobPFSOwSWmm4svk9C5K/MEDL4yILy+459w2Vs=
Received: from SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19)
 by SA1PR12MB5660.namprd12.prod.outlook.com (2603:10b6:806:238::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 03:53:05 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::fc) by SN1PR12CA0048.outlook.office365.com
 (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 03:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 03:53:04 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 22:53:02 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <bp@alien8.de>, <x86@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        <yazen.ghannam@amd.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v2 1/3] x86/amd_nb: Add PCI IDs for AMD Family 1Ah-based models
Date:   Tue, 8 Aug 2023 22:52:42 -0500
Message-ID: <20230809035244.2722455-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809035244.2722455-1-avadhut.naik@amd.com>
References: <20230809035244.2722455-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SA1PR12MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fcdab14-b4a0-42dc-29e2-08db988c22c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQlWgRvHiJ1bD9heta5LyOv1lLCq2lgU3z9CkOe9PAkCeb77Llx+w/BfRIiswhuBFlt/CWFtw70kx7XEjiMduegQ5EyFCUjOdVkDorocJZ5Fr2dySPOjoNovEyo3tGZIqOCm5Kqz/SD1N0tUPc/E3v+pJtmgx7YqQ++zWsRU67E33zLjT8SbKfQV7i83XOJqkbBAgtc8wy2n6GNUxG6aQzNxtzD2kDJSQCFF/OhHVov8YCOx/X483isyXgU7KdUyKYSvYLs0z1Ek5Wwl01+AabrvxWoAWH0sB9gr6yUvwQvHadGzhOUL5k+RurFetWrwzsWoFKnKYPHxgsr/N7gBwC050MTsMtSVOpvKavc0jT45FCboqq2jp60dmzvPWxsAsJPl5ZieQYsJq5wQpUIccyp4MafLdANaJIwkRGEBOFCK5d//AXEbFrOXxJrmhiTh16djd2V+d9xbHznACW2UehPBTx4O3n9yJIffX58C+A8DiQxDbUxpmgy8IYIknGNCaiYk7+G5r/bmprU7hb9Z1y3OCXVUNxn7hx03h6PDzMi7XVJaxVUprpwSn2Ut6DGhRqfGcjA8RaYRjrKbBD8GwgT0IWnNjBNF8zEfbOoMywE8QsOvRLfW+XG+Ks06o9vN/wO2StSscG8C8THHWIlo7OK4ZJDCnUkhaahlPb7hjE0pOnCkQDJf57jTuj1rP86Pb9qwhKhSBvNl60VSIavVj/67Jk7825g3Ls1aaDtQRy3tc+KCaPfxbf6k+WH7ywvMbWurg9Hs2JuI4eoNs5SbXMa7pEgI+u0KhVujnNnkH4s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(82310400008)(186006)(1800799006)(46966006)(40470700004)(36840700001)(426003)(36860700001)(47076005)(2616005)(40460700003)(40480700001)(44832011)(110136005)(2906002)(5660300002)(316002)(8936002)(54906003)(8676002)(336012)(70586007)(70206006)(16526019)(4326008)(478600001)(82740400003)(41300700001)(81166007)(86362001)(6666004)(7696005)(1076003)(26005)(356005)(36756003)(170073001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 03:53:04.8491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcdab14-b4a0-42dc-29e2-08db988c22c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5660
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avadhut Naik <Avadhut.Naik@amd.com>

Add new PCI Device IDs, required to support AMD's new Family 1Ah-based
models 00h-1Fh, 20h and 40h-4Fh.

Since, models 40h-4Fh and model 20h share some design aspects, the PCI
IDs defined in this patch for model 20h are shared by models 40h-4Fh.

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
---
 arch/x86/kernel/amd_nb.c | 8 ++++++++
 include/linux/pci_ids.h  | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 035a3db5330b..356de955e78d 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -24,6 +24,8 @@
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT		0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M60H_ROOT		0x14d8
 #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
+#define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
+#define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
 
 #define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
@@ -39,6 +41,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4	0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
+#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
 #define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
 
 /* Protect the PCI config register pairs used for SMN. */
@@ -56,6 +59,8 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
 	{}
 };
@@ -85,6 +90,8 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
 	{}
 };
@@ -106,6 +113,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2dc75df1437f..8f9a459e1671 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -576,6 +576,8 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
+#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
+#define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
-- 
2.34.1

