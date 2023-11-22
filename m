Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E497F3DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjKVFod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbjKVFo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:44:26 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562EDD60;
        Tue, 21 Nov 2023 21:44:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hT5rNkMUTA+B+86zOaRrhoA2+Y4OO1RFkezotA/Xne/ls9x9+q+U+XPB9E/CbeeMFeKLeJYqcZb7hx/V6QEsy/pM+8gcT885ZS2GhDfyf5Ydbh6P0LemAfOdGnG8ErD0GFpAW+YBrWkQiIllCs4ab+33JSpRKy6qCr4hEi1YP5AbFQ48tyV1OusAHcZ88SNgPOeTgzOLeaqe1u19LO6IMq6JL9Km1paOqL6sjLu4kuKy5iKeDh7ALNDvh2iHA2FioZXj+2cpTbh7lcBkjB9K0PhHMDLTxEXvKIy1RWQLp1oY/vXZLV75KbEeyJnKQlaBqLEQZq0UESrOSBAEXgqy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF/zaS7M0P2WtfcRo1p4D+Sk6sb1dnw7d2FI7XptH8k=;
 b=Cvg1E03YsRouWTStKPq3wfk54u1ZsGUmJZbYkgNzOLy3Ou/wSeLO12N9lUiE15G2ZhjBXoEISfPQUbXop/7ZIPZjiURwbgE64GC86/5mNj5AJ5ytXLvOocSp7r6i8i6D+JCzfG8k3m/G+jhiyGe7yP5K6IYG78updy5zK6dkPfrk80kOYXwfJxNpWbxAM+Bw0ciiiNxPxhi3oaW2Aq6SeLXXlPrJx29Mests1tlEefOCRsxUf1C22SWSC2FnEZyT0kSVkFaE/p5IL5StJlFXNRp+jZLp7WoxttOuVpoFGS1+knScOHb1vM2porKEqHXsYe/uv6yNpyx02mmu//veGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF/zaS7M0P2WtfcRo1p4D+Sk6sb1dnw7d2FI7XptH8k=;
 b=G+HAVjeVKQZAeAEXxxZJQUrEUe35Hl1ZfpAo1DXjvnSOMmQxIDSkDmWtvGTxQRUwPLf3mkXshcq/nKL617o4hT6tj2Mv0yIHn2LVFx9mT0InUZVldG7qfwx51NZoriVhxeXwVcyYyriddlz3ilTZ14WYw+/67qeIScj3ZC/6JJ4=
Received: from BLAPR03CA0084.namprd03.prod.outlook.com (2603:10b6:208:329::29)
 by CH3PR12MB9343.namprd12.prod.outlook.com (2603:10b6:610:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 05:44:18 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::43) by BLAPR03CA0084.outlook.office365.com
 (2603:10b6:208:329::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 05:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 05:44:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 23:44:17 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <mathieu.poirier@linaro.org>,
        <ben.levinsky@amd.com>, <sai.krishna.potthuri@amd.com>,
        <tanmay.shah@amd.com>, <nava.kishore.manne@amd.com>,
        <dhaval.r.shah@amd.com>, <arnd@arndb.de>,
        <shubhrajyoti.datta@amd.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 3/3] fpga: zynqmp: Add encrypted Bitstream loading support
Date:   Wed, 22 Nov 2023 11:14:04 +0530
Message-ID: <20231122054404.3764288-4-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122054404.3764288-1-nava.kishore.manne@amd.com>
References: <20231122054404.3764288-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH3PR12MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 04674ec8-6cb5-45f9-1400-08dbeb1e11ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ms43jcq3yVuko7z5M0ebYICbseFFloHzIOM24F4wI1W4XGcJKvaqHp6qwI8XhxQC7HHHn7I0S2NQP3YAnh0U/NYuJbIcHkYDwqnBAoLwCH2Q0swPmmIymsXIxRF9paDWqFHV7STHVMpVLNQy2vwdbO6v/g9+sW3q7K5cPfpno0AhuA8i0lpjbqA9JbOjdOxUQOHCeLQ+2l/MidL/bjdQRdjUo8Iz4CjJyWqaPjcr+nWJy6H8BnLzjgcQSF29/nTxKKWn8wBPC4IztLerwIRAjJGhGNimcw0VhEtXdZuQS8FFFXZfEJ7Gyt0LWYqQfFq15oWMllPaBW3ePhKaGAADyEukSAjXOnp6zyafvTf/8Xoq+X7Bzaw3Q0tXIFd9TECuNAMoPKrtTnwi67Dl6gYG2bNC11Wq2cFzou0HpXRc0R0bneGnZDT3SukIlEHVmwoZIXusula9vskx8I6UshDXXucicjAlZ5ovOhYOAPwh0Tz7x49VjK1j25zIfu0ZWNpqmjF/NQM5srtZTY/KkrCVAKILVSku258P9XjXhYC97hszZIbXI82ak25BVO4sps1kJMaotj32h2myaH/kcsgetx1txynf5062L3QIrO51tg22ud9QjESb3rkPxwys4d89wrIbGnTI6CfwGhFa+O7B6lo1pPkRSQuUxpNv5XI8MN9pQcgjb1C7qyBoXdx4+N2ecgl61Zqr5T3CtOivv95MItm7qIhD7cOVb4yNYvPJOSedmuJjM3wHnbnxTtt5VD+PFEQo0Xd4FwHJCZ0ssiTAY3K6vWwYpcJEcp2Ve3jZ67AwZngSXBioMUpRnrUZGnVNgMkCyn0L9TXhgWttFlbM3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(316002)(110136005)(36756003)(70206006)(70586007)(336012)(2616005)(426003)(81166007)(478600001)(103116003)(6666004)(1076003)(26005)(16526019)(82740400003)(921008)(356005)(83380400001)(36860700001)(86362001)(47076005)(40480700001)(5660300002)(7416002)(2906002)(8936002)(41300700001)(8676002)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 05:44:18.0599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04674ec8-6cb5-45f9-1400-08dbeb1e11ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9343
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for both Device-key and user-key encrypted bitstream
loading to the Xilinx ZynqMP Soc.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 drivers/fpga/zynqmp-fpga.c           | 53 ++++++++++++++++++++++++++--
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index f3434e2c487b..8b0e4b8b5d99 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -15,16 +15,44 @@
 /* Constant Definitions */
 #define IXR_FPGA_DONE_MASK	BIT(3)
 
+#define ENCRYPTED_KEY_LEN	64
+#define AES_MATCH_STR_LEN	5
+
 /**
  * struct zynqmp_fpga_priv - Private data structure
+ * @aes_key:	Pointer Aes key buffer
  * @dev:	Device data structure
  * @flags:	flags which is used to identify the bitfile type
  */
 struct zynqmp_fpga_priv {
+	const char *aes_key;
 	struct device *dev;
 	u32 flags;
 };
 
+static int zynqmp_fpga_parse_aes_key(struct fpga_manager *mgr,
+				     struct fpga_image_info *info,
+				     const char *buf, size_t size)
+{
+	struct zynqmp_fpga_priv *priv = mgr->priv;
+	const char *str = "Key 0";
+
+	for (int i = 0; i < size; i++) {
+		if (!strncmp(str, &buf[i], AES_MATCH_STR_LEN)) {
+			buf += AES_MATCH_STR_LEN + 1;
+			while (buf[i] == ' ')
+				i++;
+			if (size - i < ENCRYPTED_KEY_LEN)
+				return -EINVAL;
+			priv->aes_key = &buf[i];
+
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
 				      struct fpga_image_info *info,
 				      const char *buf, size_t size)
@@ -43,25 +71,43 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 	struct zynqmp_fpga_priv *priv;
 	dma_addr_t dma_addr;
 	u32 eemi_flags = 0;
+	size_t dma_size;
 	char *kbuf;
 	int ret;
 
 	priv = mgr->priv;
 
-	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
+	if (priv->flags & FPGA_MGR_USRKEY_ENCRYPTED_BITSTREAM)
+		dma_size = size + ENCRYPTED_KEY_LEN;
+	else
+		dma_size = size;
+
+	kbuf = dma_alloc_coherent(priv->dev, dma_size, &dma_addr, GFP_KERNEL);
 	if (!kbuf)
 		return -ENOMEM;
 
 	memcpy(kbuf, buf, size);
 
+	if (priv->flags & FPGA_MGR_USRKEY_ENCRYPTED_BITSTREAM) {
+		eemi_flags |= XILINX_ZYNQMP_PM_FPGA_ENCRYPTION_USERKEY;
+		memcpy(kbuf + size, priv->aes_key, ENCRYPTED_KEY_LEN);
+	}
+
 	wmb(); /* ensure all writes are done before initiate FW call */
 
 	if (priv->flags & FPGA_MGR_PARTIAL_RECONFIG)
 		eemi_flags |= XILINX_ZYNQMP_PM_FPGA_PARTIAL;
 
-	ret = zynqmp_pm_fpga_load(dma_addr, size, eemi_flags);
+	if (priv->flags & FPGA_MGR_ENCRYPTED_BITSTREAM)
+		eemi_flags |= XILINX_ZYNQMP_PM_FPGA_ENCRYPTION_DEVKEY;
+
+	if (priv->flags & FPGA_MGR_USRKEY_ENCRYPTED_BITSTREAM)
+		ret = zynqmp_pm_fpga_load(dma_addr, dma_addr + size,
+					  eemi_flags);
+	else
+		ret = zynqmp_pm_fpga_load(dma_addr, size, eemi_flags);
 
-	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
+	dma_free_coherent(priv->dev, dma_size, kbuf, dma_addr);
 
 	return ret;
 }
@@ -99,6 +145,7 @@ ATTRIBUTE_GROUPS(zynqmp_fpga);
 
 static const struct fpga_manager_ops zynqmp_fpga_ops = {
 	.state = zynqmp_fpga_ops_state,
+	.parse_aes_key = zynqmp_fpga_parse_aes_key,
 	.write_init = zynqmp_fpga_ops_write_init,
 	.write = zynqmp_fpga_ops_write,
 };
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index d1ea3898564c..e88f24870a77 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -83,6 +83,8 @@
  */
 #define XILINX_ZYNQMP_PM_FPGA_FULL	0x0U
 #define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
+#define XILINX_ZYNQMP_PM_FPGA_ENCRYPTION_USERKEY	BIT(3)
+#define XILINX_ZYNQMP_PM_FPGA_ENCRYPTION_DEVKEY		BIT(4)
 
 /* FPGA Status Reg */
 #define XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET	7U
-- 
2.25.1

