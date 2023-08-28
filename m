Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48CC78A4F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 06:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjH1E3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 00:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjH1E2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 00:28:41 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5567B11B;
        Sun, 27 Aug 2023 21:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZQvX/O6ewO7Ys/uO/BI1DlzEYMQbUXoiY6AnBhqp+dT7wZuTDP8FaSTIOWQypEEw8tm3dUGHUgl71t/CgjlOa0Jd4NI/Ypfig5WHxtyD76kEfhPvRCUCAvEvUX0JnnsSenZHEloc2tlNcNkbLU8zrVfKPMIfs2EMEM97QAeukZPKxCBz8AgZvW3g6bKsfr3HTuc5zu+qyMoT5FxpAluql0spdaFyrZUdO/kptYCphW9SW0yUARaID8IZraJB6apPCfjAuYJUlEml7O3do/amtycJKanDkGmp+bfsycmoR56x5foaX0bXOuZonUvj5MPEGnZZQ34NGltvzSDKRN9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3sKBtE2Tjksx8Bw9f+AV6tiWIalNLIXFrzg0qmOxM4=;
 b=KFytJSLYCmDwMmCm4vu0yzmDE5CRWtZgRlQY3CURYPxhW2Naz0zyeNlTawU4vZeV5c6WX24vVsvPAxw0fX27jY4OJA8xQEPkKtQc80758bnz8IukABT9PQabyht83FvFJC7HWwh2D28MXbd0WkxLjzK9SCswhPMNxE8ojGL+HkJRDC/kVDcfamKB5sHXWUB2sYwAgMVXhuCI9YOGFNsmwWWwq4tsRxmlg6cZp+HO6guNe/n9AXkzPmFkKU6d9Wl2ZutSrF34vpZh0h+ZngPoT4PAu41G7sUujdOVPMv+Se43vk3QDtohZMu5JI+f9ENR1BcvZ8V8sIoL5q5dx8psCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3sKBtE2Tjksx8Bw9f+AV6tiWIalNLIXFrzg0qmOxM4=;
 b=SiA24unyeEBWsLSIBHUoCuKI4dKnaWgwAkUcSK+XJTAapm00w8hApAJVUId4dusWco0V4iY2asJONqAirdnLEKsJB+4FhuqfpBSq6mlrarg+rUsioXT/6i025GUEV8LeC9d072kRe1SxdKfwIuqKMcsKhbSSISkX64oHNwi0fSU=
Received: from CY8PR12CA0037.namprd12.prod.outlook.com (2603:10b6:930:49::19)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 04:28:35 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::9b) by CY8PR12CA0037.outlook.office365.com
 (2603:10b6:930:49::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 04:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 04:28:35 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 27 Aug
 2023 23:28:34 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>
CC:     <bhelgaas@google.com>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <iain@orangesquash.org.uk>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v15 2/2] platform/x86/amd: pmc: Don't let PCIe root ports go into D3
Date:   Sun, 27 Aug 2023 23:28:19 -0500
Message-ID: <20230828042819.47013-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828042819.47013-1-mario.limonciello@amd.com>
References: <20230828042819.47013-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|BN9PR12MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: d9428ba2-6768-499a-6390-08dba77f3e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8/5lRGWWgO7z1zNLC2InOegVdSZVNBrnemtcS4ZPn4f7lfs/K/KHVUzS8FQxf8H5euDGaSHAucp5Y5SyNCNdf22jH6qa2JYxNowv2UMc8fgQlOcszfkNJyA48iS/xoiiFc2ijPfYYF5ESKlZfpBYAfC9iNtFtj+Jgy6CiF72tDIbCrZA/Q65JnWcC1aEtJMfMJYija7mLRIlJn9NBfyUn+UBpyOjcYkvxuUmjckqAVIFUCtauLQ44FpEUnXF5o6XRSlrW2hT7EBRhxG8iPcHsvWwrfXBVXPIrDhhW2PBi8Y7A8ci0aMZzF83aLv+fvOfATfQvpLwPN2NzMOXewJzrkjpJNMC1fyDu4QhXbgaHYWXfsnAscrKJkbGntWDBw9CaoiXJBUzWhGIsjyVLZPCdhm2ZmJe2/ijUEFkO7HcX1yVZGy1sOxLcoAlTSpryv7dIPtHpQTd3DDNKSMgOmzfzq3CXc/Jxxle/oyVr4icG8shILlPYzUME05W+3l2nSB2baWGyjOD7HXuTrGYmhOjOoxoZCI9FaSKRcgtRpzLOGOYsb1tnKFGcJQ98DcsF5E3MUB9GHWRVDFaDnenZckro85ZYdqDM/oZ/E9nzKz3HqHbjCApjlL4/dY1RePd9gfEyNxmA+wGEp4TJCKqZuNt+WLWsf3dNOQbksG8Bju2tXk4zOJAmo3r3euHGZtTpLkyujnoDWIF9ZxgWhRvPiQHjZlcnp+C82pHTYx4sxaGj+Uz0iatG1wS8nyGzFLpVmDbV7/xaQniYrixMmdJ0A7Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(6666004)(2616005)(1076003)(7696005)(40480700001)(110136005)(40460700003)(2906002)(86362001)(5660300002)(44832011)(6636002)(70206006)(4326008)(8936002)(8676002)(54906003)(36756003)(70586007)(41300700001)(316002)(82740400003)(81166007)(356005)(478600001)(966005)(83380400001)(47076005)(36860700001)(16526019)(26005)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 04:28:35.3381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9428ba2-6768-499a-6390-08dba77f3e82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
changed pci_bridge_d3_possible() so that any vendor's PCIe ports
from modern machines (>=2015) are allowed to be put into D3.

Iain reports that USB devices can't be used to wake a Lenovo Z13
from suspend. This is because the PCIe root port has been put
into D3 and AMD's platform can't handle USB devices waking from
a hardware sleep state in this case.

This problem only occurs on Linux, and only when the AMD PMC driver
is utilized to put the device into a hardware sleep state. Comparing
the behavior on Windows and Linux, Windows doesn't put the root ports
into D3.

A variety of approaches were discussed to change PCI core to handle this
case generically but no consensus was reached. To limit the scope of
effect only to the affected machines introduce a workaround into the
amd-pmc driver to only apply to the PCI root ports in affected machines
when going into hardware sleep.

Link: https://lore.kernel.org/linux-pci/20230818193932.27187-1-mario.limonciello@amd.com/
Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc/pmc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index eb2a4263814c..f7bfe704ce39 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -741,6 +741,21 @@ static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
 	return 0;
 }
 
+static int amd_pmc_rp_wa(struct amd_pmc_dev *pdev)
+{
+	struct pci_dev *pci_dev = NULL;
+
+	while ((pci_dev = pci_get_device(PCI_VENDOR_ID_AMD, PCI_ANY_ID, pci_dev))) {
+		if (!pci_is_pcie(pci_dev) ||
+		    !(pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT))
+			continue;
+		pci_dev->bridge_d3 = 0;
+		dev_info_once(pdev->dev, "Disabling D3 for PCIe root ports\n");
+	}
+
+	return 0;
+}
+
 static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 {
 	struct rtc_device *rtc_device;
@@ -893,6 +908,10 @@ static int amd_pmc_suspend_handler(struct device *dev)
 	case AMD_CPU_ID_CZN:
 		rc = amd_pmc_czn_wa_irq1(pdev);
 		break;
+	case AMD_CPU_ID_YC:
+	case AMD_CPU_ID_PS:
+		rc = amd_pmc_rp_wa(pdev);
+		break;
 	default:
 		break;
 	}
-- 
2.34.1

