Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B057CE4AB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjJRRcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjJRRcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:32:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F361A3A9F;
        Wed, 18 Oct 2023 10:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxSzVUd82gNaaHvOv5e7qcNWzHx8khA+kzmFeulIzEKMqVyreYeYzIJv6ebEhZfLsc6IJMq2zT+TdYFaJo4qzc6V8kz9uoRtbQN3j9eMWrm8jnqQIBd1aPKfoAphg6LoiReBe34UDBsqHSZ6SI3/C2WG28EuUE/wkFP1u/G8GopUuqiyczizdBfxgpYTsVnQVOiFuPU6dcjZi1sRvDDW8jlI7oVxk8qXqURKa8MPZzQdMnkrYy67eKBSZ698H6Y/gI+DYMWWOUCD3PVt56w+HFbeC4o912t0tCXiK/XdNhCQ/ELXnQ1/Mn64pCcL3mTnqhjvyc1Q538jWUXeA7GhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JeIikDGFCSsEiqCPWnGvXoD10jydbbTgmGgNaa/v54=;
 b=JiorhSlu7gdrC0iyX4x4kLUewZLUDbYgVrsCHTiOfvqh8dDkzvYbN6NpKMKH6yzbH3pJQbXe96+FyDvErLscaUBlojP0TizjA3XD5Oko64R+UfxTeOOBJeOtAX1v7/y7vfdylfh07bX2qHsl1u5Xn/vJnCvDXtUEatssiQxDgTy34iI9jnDdiv3RagHkBn814OxkCHM7Itlu/1+TdC4vY+b4jaSIA5KwTEuEROu0ttKi4XzRTz5KfI6tX8afAQfqhHtwXnNS2/qJt50XU2t4E0MzgPjL6YrL8f6BAjtbWZ+YH0qiie9GhLT6iAKdaC0M/PzUuq8G1E5j+r52weZBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JeIikDGFCSsEiqCPWnGvXoD10jydbbTgmGgNaa/v54=;
 b=qU4CJiRSC5ZsTzQz7XSSZmCfYPYflurx4XVYhuvXT1QBf28bjoj/XiJq7YVoUBlVjgJIiSxGy+mftZMDRIMWFaLA7KguY7dbSqyOy9dc/+dLpKoxSgaJecCGRR21hGU3TN/FazW9tj30e8YxmCIYHaMbaRxT+AaDJCURlrHW67g=
Received: from PR0P264CA0183.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::27)
 by PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 17:20:45 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10a6:100:1c:cafe::c8) by PR0P264CA0183.outlook.office365.com
 (2603:10a6:100:1c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Wed, 18 Oct 2023 17:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:20:43 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:20:37 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v12 18/20] PCI/AER: Unmask RCEC internal errors to enable RCH downstream port error handling
Date:   Wed, 18 Oct 2023 19:17:11 +0200
Message-ID: <20231018171713.1883517-19-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018171713.1883517-1-rrichter@amd.com>
References: <20231018171713.1883517-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fc37f9-e641-4e5a-bce2-08dbcffe8f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JB/W40Bpu/86nzlRdyp0sLy32v7p+lbRhzXqFYXEGk/P5z7tb+jo9T2dMf58hoMG1UMlXj7cB0oeZliyyCzx4dTL7WAFRVXqW2MiPXDQVOwFSiDRdbHC3KWVO4EXOCixnVWBkFE9IwHJGx+s4qV+eUhCm5bODUMGbmlUZ/XzGROcHOeH0yEAMggf8OVc6gAwFdT9S+bef2e1oQXMBOjbpbJAViKfP+S1CyicVQIjkLAANwtcR/jCc2UZ7j6LwMblmmiG6twe2btzUIqE1VyXH1ELOH7UXTI5uwossJZb5S0rSn65lIKonFudcv0VUI5+EAi34ZcBlJ74uR+M0IVlSs7NNA7vlbOXdIe2VIKpa291lU81Wlnt3YSpv9Twk6/RAiInn8PtDrIZtPbsPaHhUD41ohtAIYbS3cHEfIoC9o2VR6tOWy4eb7u1H9DBGJr/r88e/lJfwqwl2Cy+H5pMj2TkA+m6XOhkL33g39OmSYvVV6Z1tH+54hxM6NvsgPPveUWwHI3CLjDu9opERDIr8/b2hUxMiBNpZjTByIbW63OhWbv+7E1oLMaV+oq4Q94JAJbLf4XsAhlQvq4vCXE5mmf7P//EYaaWcYFAOuke7xFOHrptRtN0g/dczOlSOGQNxtGG7P0rag99N1YXEQ6OqTxdDS01x3YvGeFuS1r+mY355ZJahjqvqE8BAq0CRgJHDE3I3PkDPKCjozm9eQm/nuDFEKDFPh2bw+gHfyFs6udW7y6L+D+rjVjItUVPszx1nwU0nMcOBhl9gy6BtPQzCs2rPnYgkrLYnIcwdNp3LiI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(40470700004)(46966006)(36840700001)(316002)(70206006)(2616005)(70586007)(426003)(110136005)(478600001)(54906003)(2906002)(16526019)(4326008)(5660300002)(8676002)(26005)(7416002)(41300700001)(8936002)(921005)(82740400003)(47076005)(36756003)(83380400001)(36860700001)(6666004)(1076003)(81166007)(356005)(336012)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:20:43.1772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fc37f9-e641-4e5a-bce2-08dbcffe8f17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AER corrected and uncorrectable internal errors (CIE/UIE) are masked
in their corresponding mask registers per default once in power-up
state. [1][2] Enable internal errors for RCECs to receive CXL
downstream port errors of Restricted CXL Hosts (RCHs).

[1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
[2] PCIe Base Spec r6.0, 7.8.4.3 Uncorrectable Error Mask Register,
    7.8.4.6 Correctable Error Mask Register

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/pci/pcie/aer.c | 57 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f1e8494f5bb6..41076cb2956e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -936,6 +936,30 @@ static bool find_source_device(struct pci_dev *parent,
 
 #ifdef CONFIG_PCIEAER_CXL
 
+/**
+ * pci_aer_unmask_internal_errors - unmask internal errors
+ * @dev: pointer to the pcie_dev data structure
+ *
+ * Unmasks internal errors in the Uncorrectable and Correctable Error
+ * Mask registers.
+ *
+ * Note: AER must be enabled and supported by the device which must be
+ * checked in advance, e.g. with pcie_aer_is_native().
+ */
+static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+{
+	int aer = dev->aer_cap;
+	u32 mask;
+
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
+	mask &= ~PCI_ERR_UNC_INTN;
+	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
+
+	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
+	mask &= ~PCI_ERR_COR_INTERNAL;
+	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
+}
+
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
 	/*
@@ -1012,7 +1036,39 @@ static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
 }
 
+static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
+{
+	bool *handles_cxl = data;
+
+	if (!*handles_cxl)
+		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
+
+	/* Non-zero terminates iteration */
+	return *handles_cxl;
+}
+
+static bool handles_cxl_errors(struct pci_dev *rcec)
+{
+	bool handles_cxl = false;
+
+	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
+	    pcie_aer_is_native(rcec))
+		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+
+	return handles_cxl;
+}
+
+static void cxl_rch_enable_rcec(struct pci_dev *rcec)
+{
+	if (!handles_cxl_errors(rcec))
+		return;
+
+	pci_aer_unmask_internal_errors(rcec);
+	pci_info(rcec, "CXL: Internal errors unmasked");
+}
+
 #else
+static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
 static inline void cxl_rch_handle_error(struct pci_dev *dev,
 					struct aer_err_info *info) { }
 #endif
@@ -1412,6 +1468,7 @@ static int aer_probe(struct pcie_device *dev)
 		return status;
 	}
 
+	cxl_rch_enable_rcec(port);
 	aer_enable_rootport(rpc);
 	pci_info(port, "enabled with IRQ %d\n", dev->irq);
 	return 0;
-- 
2.30.2

