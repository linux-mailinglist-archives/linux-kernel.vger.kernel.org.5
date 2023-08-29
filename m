Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A0F78CCEF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbjH2T3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjH2T2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:28:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3D7109;
        Tue, 29 Aug 2023 12:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lc2wCExCvFHtrA8tVogIxN9tom0DbXHhatjJlU2VaPw3Uh1NGXRiub+czOSHSS7zlebMGpAx+qCVA2IdhV5MCJNcLR1POgSyEn+kwRfH+KYGmitvNO2+W4uk8DMCHy1vqG56ZazOHcm0nsrG6OYArbDMzjK/3iyDBIcvCVqpVfbLhMQje3HqgplNYgNEb01IucocOAnguCwrLES15RaZ/BT3sciBfvdhSjRRYY2i5iW/WmEL/R073uDf7hLRaoGvKPGqM9VeA3pj4cgsKr4DKgOPf9mM6zoETOzh/4GsjjgA+g1rD2bIPKQ23lLc9zhyp6bTe5VX9FThWpQT4vBRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9fyVuIreUbf6OgEFV4sz7YMe46WwDMMWeynvizgo0k=;
 b=Uq8466k+V8ovWvnvXzwUSoCmk0n5a6XV6XsP9MNyCdXj2oFx2WvO2TU7Jznni0QF3Dwa6dYAOGSb7tdtIuhW1BRA3ytv9VLDQBm6CtcfGxPl8B+PmDZ7XGHtcS4zHiZwodvWYJzyh1JNCdS8XJSDJJZRt16OlOAn4SJ/glFUEEdtvg7QBo3JUIDp9foHb/OkHjx+Vv6BEBiw4Nso6YOvTg6MStD2y6gKWkOsQkQJA7yj4jgQZ5Gely+R4xV/CrIvhLsBGhd7xgJIb3kkKNIYfXPwYXBljMinY52NF4qfGJuSfW1REq+Dd1TQyzizs4+eBhQPETo76ttYp/lcZkT7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9fyVuIreUbf6OgEFV4sz7YMe46WwDMMWeynvizgo0k=;
 b=wfCB1bGsgy4KHAVGfmDDfBUuR8vct/rgJDQmh72arZEKCFMsZ3sT94daxVRDWwWVMjiyirBrBkEh4o8eOG4aE72hUnPmu+MEqHIWMeO87tnlL1KYbooNFJos5rTI3NVaxAhl8soMiI1k+kuj5WOoX6bDbskPgMTrmoqiAqMYXiU=
Received: from CY5PR19CA0043.namprd19.prod.outlook.com (2603:10b6:930:1a::33)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 19:28:33 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::71) by CY5PR19CA0043.outlook.office365.com
 (2603:10b6:930:1a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 19:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 19:28:32 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 14:28:31 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <hdegoede@redhat.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
        <Shyam-sundar.S-k@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Iain Lane <iain@orangesquash.org.uk>
Subject: [PATCH v16 3/3] platform/x86/amd: pmc: Don't let PCIe root ports go into D3
Date:   Tue, 29 Aug 2023 12:12:12 -0500
Message-ID: <20230829171212.156688-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829171212.156688-1-mario.limonciello@amd.com>
References: <20230829171212.156688-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e8c513-e6ad-4752-5252-08dba8c621e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lEqpVsOF/7WLnB9Tr9lYIOP0HHVsbjey3+Ei8q8Wsax3PqcooarVD52CT/x+nyYjUufFnKQE/Gn0Ynvzv+21yVHDhTFvEB51LX763gAxzd8JGQRtzjn7HUhqNix2MHSvvfAyOHC2bShrwllj8L8dKCJxxyRRonaQNfX1NK72u1Dme93ZEivmNyOMkZxlUgY4u4mMi+Y6pdbyyUtzFldiwhABq22nA6I28wcSq4wW1g1vA48C6GRdazSUcweL1IqGvUBfkhPBIAQW5GchQHzqv5Ap9GZQKlo2s7CyBC7rDUOKlhhPNEygOflinBndvgd1UGIS8RiDjNO0eO0jZQHusMZNSsb/j1JHUs6/WcyNBUeAgp6edOD/w8oqes59wgEnYkWeM5g96fUxtcvzrKmZ0cwEZPtWuHVoxrqfdev9AgyJ9Xaz//WG/+jqBOxL7wLu10QBSkWG/aOOJsw1RfQ7raDNEvf7yLq14NU5Q9Olj/6Q6XnhMBlRn/AZUZrVl9HcY0/D/e/B1xw/rMlMGYa80gjLTKyR3W1ERXuZun3lveky15E8CpYMB2VpEJ3YDU/jodElWwWhdcnrKpiWfq0TksbeeIPPf6eI67IdLljJbcZK83Hn7FDC1G5wqtcKqfZPGoJDqiOME7mZNj1c23JfXwu/WkPyPFRwNoGFJGdjsECrxxg0bvH/jRYkCGv4bTVSHxne8RHKteu+4lTeAI5RKo/Khl8WqXHUEbxRgeC3Ics1V4MGaMrbmOwqSrf6klsN
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(82740400003)(6666004)(7696005)(86362001)(36756003)(40460700003)(356005)(81166007)(36860700001)(40480700001)(47076005)(2616005)(2906002)(1076003)(478600001)(26005)(110136005)(16526019)(426003)(336012)(83380400001)(966005)(70586007)(8936002)(5660300002)(54906003)(4326008)(41300700001)(8676002)(44832011)(70206006)(6636002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 19:28:32.7565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e8c513-e6ad-4752-5252-08dba8c621e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
v15->v16:
 * Only match PCIe root ports with ACPI companions
 * Use constraints when workaround activated
---
 drivers/platform/x86/amd/pmc/pmc.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index eb2a4263814c..6a037447ec5a 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -741,6 +741,41 @@ static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
 	return 0;
 }
 
+/* only allow PCIe root ports with a LPS0 constraint configured to go to D3 */
+static int amd_pmc_rp_wa(struct amd_pmc_dev *pdev)
+{
+	struct pci_dev *pci_dev = NULL;
+
+	while ((pci_dev = pci_get_device(PCI_VENDOR_ID_AMD, PCI_ANY_ID, pci_dev))) {
+		struct acpi_device *adev;
+		int constraint;
+
+		if (!pci_is_pcie(pci_dev) ||
+		    !(pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT))
+			continue;
+
+		if (pci_dev->current_state == PCI_D3hot ||
+		    pci_dev->current_state == PCI_D3cold)
+			continue;
+
+		adev = ACPI_COMPANION(&pci_dev->dev);
+		if (!adev)
+			continue;
+
+		constraint = acpi_get_lps0_constraint(adev);
+		if (constraint != ACPI_STATE_UNKNOWN &&
+		    constraint >= ACPI_STATE_S3)
+			continue;
+
+		if (pci_dev->bridge_d3 == 0)
+			continue;
+		pci_dev->bridge_d3 = 0;
+		dev_info(&pci_dev->dev, "Disabling D3 on PCIe root port due lack of constraint\n");
+	}
+
+	return 0;
+}
+
 static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 {
 	struct rtc_device *rtc_device;
@@ -893,6 +928,10 @@ static int amd_pmc_suspend_handler(struct device *dev)
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

