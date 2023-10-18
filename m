Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEF77CE49D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjJRRb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjJRRal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:30:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CB63A90;
        Wed, 18 Oct 2023 10:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOmtdO7rkIWwz2zDM23BgzHh63bLOEeSNaj7J13wtw1m+PHz2PS0OtjSGTuzZXjhSVZuNRMJ4+0Ei8IvKlOE+MWsLzuzEPpWPFTXCndtrsTLa49dk09LRI7BF6e+ozzNYATwG1JSxlItJgnyEGi6XpDViDgLHiNQZcrYmvmeHA4uF4gqZsC3HTxUlwQ2olTFJV7ELn6s8lNUi+ChoPfDmnH2vOOddaXP8akp8T+Qra8sW8S0w7ejx/0MLqnwedOcOlbvLw3+79DR7ug7R1whTf/k8c5An7sQPidnwKy1bk6cSfZh/vuupbLLsA2/56gL6D9/36c6AKOq+7ztaYuhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqtoTpc8P9ULmgmi98sqiz9tg0uQaFxc14rukWdyR4k=;
 b=Xs276YJZIYIJlYJGSUemRcwi7on7zju4i76RSaHBQJ3WG3mAGYeFvK2ysItAml8mml+CdsDPT3XkBu7654vXPqRgiJhLaXoSYV37Z7U/5f2XkVjEFZIqrWmvSjWujRFCEnaoO6N7DkeAgYEtGLpE12dZFtlA5X8MCbS23FsUwh+W6Hwn0R+s9Gbyy35n3J20HMnJSJy2Ihqq+0cTTQtdoLIhKBn+/DwtX/tj0ZNBiVCq05KtrIgFc3TPX+t/S8V3m017ObfX9LG7phYL2quvOx+7lWAV7qLg/urjToYgaj7SzSx+RkktnlLAtxVvMn2wheGCiInvJSlubvWyfp53kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqtoTpc8P9ULmgmi98sqiz9tg0uQaFxc14rukWdyR4k=;
 b=5nAQzc4dLV6/nsCg8jj+lhHjBNbnTo5Hp5YilaIfX6Ay3tcCvoj/+rFlcr7gLN+as6jomK8BLqHXzDAVC3IvmTRt0IgpT7N/mBbu0Q/LO4kZ1P0IKafWwqNFK89nTPNfLJ4UKv9CDCeJ5q6KcgMJPw5PjF1F7r5GLspTZwie/rY=
Received: from PR0P264CA0171.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::15)
 by CH0PR12MB5329.namprd12.prod.outlook.com (2603:10b6:610:d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:20:36 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10a6:100:1c:cafe::6c) by PR0P264CA0171.outlook.office365.com
 (2603:10a6:100:1c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:20:34 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:20:30 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 16/20] cxl/pci: Disable root port interrupts in RCH mode
Date:   Wed, 18 Oct 2023 19:17:09 +0200
Message-ID: <20231018171713.1883517-17-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CH0PR12MB5329:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4a0655-2b13-41a8-a81d-08dbcffe89f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /XQlUHSDrvj8EYX/ZLlKoiIqMhcbg7ZLFxjAOH1DBzqh4lc0HWAntfgJeHqrtH8e85fNxIXRBI7SrccNv0odb2JfUHtZTevvQXbvOxRMk1vxOywU/5pcNgAZplHHiodbJo9pIIAIlfAIXklGfctpCdVxaIcj2kSSve19VvgNubDxQnGKl23C3oAJjBlb4cl7V+a3xT3Vx6OoGzIUTrdaJaR7uuLiWNGEfhbWQi3UPDsFxZgXamKngUUEJL8jo2j4+NyuiIfRla/lGQvbw/oS+38eLZO9qY9VFz6Cf43sQtaRAmLoeMYXkQhNpLse+TAbX+cL8Cm6ft4Jdo++rYy6FDtqW7wgPE2PjjgoIzc/P0q48eUsTQHArUpwW6E0YGcBFog+lvr5ZWq485y6AP+AcHnoVeV8/E6GAjPdV0bDeylNZnKqG9GBwfmXPNbQ7ixXd1mWIuHzU6HYq8PfZfIWaVwoB04Z3xAEnn1K5G9Q1UTlA82fNc5C6d3TBg1IYNox1J436t3BoIR1jOjrUTe18AIKyvwovwnQGOeGi+DsjR/hBMayXvwrEIrpTXuIEzGKj2N8so+8qicajEZnylfAcG3ow4MzA7AB6x63KflE/OZWRZccGaz5CTX1DGvFmusYPK2X/jnsgpiuyYTe753dlMZgnNuamtNiWnu34ol/UWVE/w9XPtEyMQQzchYyaUuDIiRXTKX0/22OqG9xTWbL8mdIy/ALk2PRXglYRA+U1+QxBto18NWhDonGt/OQYx8nrMlJ4NX8+1h9GP3o2fRoNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(81166007)(36860700001)(16526019)(7416002)(2906002)(356005)(5660300002)(8936002)(36756003)(8676002)(4326008)(83380400001)(82740400003)(426003)(26005)(1076003)(2616005)(336012)(47076005)(40480700001)(316002)(478600001)(6666004)(54906003)(110136005)(41300700001)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:20:34.5678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4a0655-2b13-41a8-a81d-08dbcffe89f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5329
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Terry Bowman <terry.bowman@amd.com>

The RCH root port contains root command AER registers that should not be
enabled.[1] Disable these to prevent root port interrupts.

[1] CXL 3.0 - 12.2.1.1 RCH Downstream Port-detected Errors

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3c85fd1ae5a9..3da195caa4ad 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -763,6 +763,35 @@ static void cxl_dport_map_regs(struct cxl_dport *dport)
 		cxl_dport_map_rch_aer(dport);
 }
 
+static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
+{
+	void __iomem *aer_base = dport->regs.dport_aer;
+	struct pci_host_bridge *bridge;
+	u32 aer_cmd_mask, aer_cmd;
+
+	if (!aer_base)
+		return;
+
+	bridge = to_pci_host_bridge(dport->dport_dev);
+
+	/*
+	 * Disable RCH root port command interrupts.
+	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
+	 *
+	 * This sequence may not be necessary. CXL spec states disabling
+	 * the root cmd register's interrupts is required. But, PCI spec
+	 * shows these are disabled by default on reset.
+	 */
+	if (bridge->native_cxl_error) {
+		aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
+				PCI_ERR_ROOT_CMD_NONFATAL_EN |
+				PCI_ERR_ROOT_CMD_FATAL_EN);
+		aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
+		aer_cmd &= ~aer_cmd_mask;
+		writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
+	}
+}
+
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
@@ -774,6 +803,9 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 
 	dport->reg_map.host = host;
 	cxl_dport_map_regs(dport);
+
+	if (dport->rch)
+		cxl_disable_rch_root_ints(dport);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
 
-- 
2.30.2

