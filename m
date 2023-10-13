Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6367C82D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjJMKPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjJMKPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:15:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82F3C2;
        Fri, 13 Oct 2023 03:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpZlH2hzfExyBEZYMPClob4L0sibfmXjmC43Q2VVhmz4kJKc9OFM20TPWVz13xuFFh0pEqgN41dyrEc68XTNdAASWtJUO5ThksnRIguS/cqcHOC6aRu8a/p1joOsjWkDPsz/pAOoiZ0gzZbfO9At855Eoedo1FToFQ21udFkNxYtQHIA0moDoZx5RU+yZhKRuTZTsryO7r4bc4caoQ8K+jW6AdxuEXTzhZ35fffDHg26w505CI2SIZJCVsu6WXI8DPVHSjsGR3Ep9j93GS9uKE81kun6uyGLphukzHAHhVxMm4dvE0cyXqWuxcdqHFSBr4MygYaSoB7SBtNo9CdCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs3xTZXNQ9ThDGQ9UX4jqxxKmQCRuE/oJnMwNPqvfeo=;
 b=NNBDKXiy2AaTCcOOyAibwvBiwxWbWq+gmGNholI/eauxp9tYkCobAHtVbXpPn7Ox8uH72ahiDiCq4681iPcXRwa2YP3Qq5qdbGKaLSKby3Z5TRvqwJasSsnlbUqkeIVHhjV0xJ+NOqIchinlOiu6dfiOaPdx0Kfblmwy5UiTqGPmJYPYlHeBw5Ea/C6ko4P1VKnil9+cLxR30kPz5vTt361aP2ME1QvQSMQZpPj8AdX0cpflelh5HoMcsfGnt7WTDdL7yQHirzO4+PD9WUimnQZhYzPUAdAH7hatVbU0PbHsFAYSynPH6UBxn2k72YU3aa5GkOd4mK8SeGmLxlZz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cs3xTZXNQ9ThDGQ9UX4jqxxKmQCRuE/oJnMwNPqvfeo=;
 b=amFS8TWiuPR+UKU3R6TD1tTjmqa/prrqwuPlGzsok+9eUm0PnS0q5X1+sd5AK9+iXuRnpNnJNKo89fNrQNhVNHTSOyUEaBUSlLA8ntODA/eiPQ3rMaeHqhoCC+luQqgXbauinJRUoLh+wrQKKWkaq2q8xbzUhLNNnGHjCEMui3o=
Received: from BL1PR13CA0115.namprd13.prod.outlook.com (2603:10b6:208:2b9::30)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 10:15:27 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::b0) by BL1PR13CA0115.outlook.office365.com
 (2603:10b6:208:2b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 10:15:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 10:15:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 05:15:26 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 05:15:24 -0500
From:   Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] nvmem: zynqmp_nvmem: Add support to access efuse
Date:   Fri, 13 Oct 2023 15:44:50 +0530
Message-ID: <20231013101450.573-6-praveen.teja.kundanala@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
References: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 95af8458-a558-4393-e6ae-08dbcbd55283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ye6Jh0PEaYddlE8RLprNQbkBw67gUtr7S0m3oqGAyVa9RCV3lJCiQK3o9qesByNe5h7K9PL3u5uWcq95DRWWQ0tfVN9LMPRGIB0IuF4mlXNTQ0xO+fDUQnMS31NrSHdeuq1NBMh2dmP4y3UbmV0cx8EHufnjHphxppl508++Ww5VhJh8FO2WVTxlN3J71VzXIAGp2zFg2uxfKThj/Ih9S9BwLuEtfIKI9+xRTXGVWH8bHo/T+NR6SejMCXGReifWx/Y7S9vKX5owAgaktQqmxVgaWRHjNybd06GlNlCwiJV2H9bKX+TXYgubGpjgi0rH3YLpJNafeFD3Pg5TrZ1QBdRXIWxewszWgCqai2lmuhRyJs0HN7oSowbQKB+whfBWgbr1Q1zRcAsgWW8yujWLSa4tSBnMjXaP4Fq9LYJvQXTG3243lFhHF78L2rVIWwCmrfH9NgaDlvaMvQiyJs2CUfjCzRJzr6niuLCniztREG05VbILpMSft6zPTh3zI+EwvOdodaJaVA2//FPEi4IAX3KTP0mryYHResHoiFBV2mX1NSbysH/oPO5fjgNLbBZqS6WWCZGtPuMnf4hG/T/HQusx6L83g5ef4lz+Zhvq/YWyMLGpruSvncCerv+UMXtWlCqPx0outMdebZvB9s9vKl9fzf515folcC53OqhxWBayZcVuP/uqjOLwgjBgUAust3Pp3U+WyIb3oP/wJAdIygcHWrmP74/YtwsT0M4hu4jY8K/ZekgkqDANbj5bmDINwm7Sliu4WicN0HaGFj7zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(46966006)(40470700004)(36840700001)(478600001)(316002)(82740400003)(6666004)(70586007)(110136005)(70206006)(4326008)(41300700001)(8676002)(8936002)(103116003)(426003)(356005)(81166007)(1076003)(26005)(40480700001)(2616005)(336012)(36860700001)(2906002)(5660300002)(83380400001)(40460700003)(36756003)(47076005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 10:15:27.5436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95af8458-a558-4393-e6ae-08dbcbd55283
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to read/write efuse memory map of ZynqMP
Below are the offsets of ZynqMP efuse memory map
	0 - SOC version(read only)
	0xC - 0xFC -ZynqMP specific purpose efuses
	0x100 - 0x17F - Physical Unclonable Function(PUF)
                efuses repurposed as user efuses

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
---
 drivers/nvmem/zynqmp_nvmem.c | 216 ++++++++++++++++++++++++++++++-----
 1 file changed, 185 insertions(+), 31 deletions(-)

diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index f49bb9a26d05..e6123a32268a 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2019 Xilinx, Inc.
+ * Copyright (C), 2022 - 2023 Advanced Micro Devices, Inc.
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
@@ -10,36 +12,190 @@
 #include <linux/firmware/xlnx-zynqmp.h>
 
 #define SILICON_REVISION_MASK 0xF
+#define P_USER_0_64_UPPER_MASK	GENMASK(31, 16)
+#define P_USER_127_LOWER_4_BIT_MASK GENMASK(3, 0)
+#define WORD_INBYTES		4
+#define SOC_VER_SIZE		0x4
+#define EFUSE_MEMORY_SIZE	0x177
+#define UNUSED_SPACE		0x8
+#define ZYNQMP_NVMEM_SIZE	(SOC_VER_SIZE + UNUSED_SPACE + \
+				 EFUSE_MEMORY_SIZE)
+#define SOC_VERSION_OFFSET	0x0
+#define EFUSE_START_OFFSET	0xC
+#define EFUSE_END_OFFSET	0xFC
+#define EFUSE_PUF_START_OFFSET	0x100
+#define EFUSE_PUF_MID_OFFSET	0x140
+#define EFUSE_PUF_END_OFFSET	0x17F
+#define EFUSE_NOT_ENABLED	29
 
-struct zynqmp_nvmem_data {
-	struct device *dev;
-	struct nvmem_device *nvmem;
+/*
+ * efuse access type
+ */
+enum efuse_access {
+	EFUSE_READ = 0,
+	EFUSE_WRITE
+};
+
+/**
+ * struct xilinx_efuse - the basic structure
+ * @src:	address of the buffer to store the data to be write/read
+ * @size:	read/write word count
+ * @offset:	read/write offset
+ * @flag:	0 - represents efuse read and 1- represents efuse write
+ * @pufuserfuse:0 - represents non-puf efuses, offset is used for read/write
+ *		1 - represents puf user fuse row number.
+ *
+ * this structure stores all the required details to
+ * read/write efuse memory.
+ */
+struct xilinx_efuse {
+	u64 src;
+	u32 size;
+	u32 offset;
+	enum efuse_access flag;
+	u32 pufuserfuse;
 };
 
-static int zynqmp_nvmem_read(void *context, unsigned int offset,
-			     void *val, size_t bytes)
+static int zynqmp_efuse_access(void *context, unsigned int offset,
+			       void *val, size_t bytes, enum efuse_access flag,
+			       unsigned int pufflag)
 {
+	struct device *dev = context;
+	struct xilinx_efuse *efuse;
+	dma_addr_t dma_addr;
+	dma_addr_t dma_buf;
+	size_t words = bytes / WORD_INBYTES;
 	int ret;
-	int idcode, version;
-	struct zynqmp_nvmem_data *priv = context;
-
-	ret = zynqmp_pm_get_chipid(&idcode, &version);
-	if (ret < 0)
-		return ret;
+	int value;
+	char *data;
+
+	if (bytes % WORD_INBYTES != 0) {
+		dev_err(dev, "Bytes requested should be word aligned\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pufflag == 0 && offset % WORD_INBYTES) {
+		dev_err(dev, "Offset requested should be word aligned\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pufflag == 1 && flag == EFUSE_WRITE) {
+		memcpy(&value, val, bytes);
+		if ((offset == EFUSE_PUF_START_OFFSET ||
+		     offset == EFUSE_PUF_MID_OFFSET) &&
+		    value & P_USER_0_64_UPPER_MASK) {
+			dev_err(dev, "Only lower 4 bytes are allowed to be programmed in P_USER_0 & P_USER_64\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (offset == EFUSE_PUF_END_OFFSET &&
+		    (value & P_USER_127_LOWER_4_BIT_MASK)) {
+			dev_err(dev, "Only MSB 28 bits are allowed to be programmed for P_USER_127\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	efuse = dma_alloc_coherent(dev, sizeof(struct xilinx_efuse),
+				   &dma_addr, GFP_KERNEL);
+	if (!efuse)
+		return -ENOMEM;
 
-	dev_dbg(priv->dev, "Read chipid val %x %x\n", idcode, version);
-	*(int *)val = version & SILICON_REVISION_MASK;
+	data = dma_alloc_coherent(dev, sizeof(bytes),
+				  &dma_buf, GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto efuse_data_fail;
+	}
+
+	if (flag == EFUSE_WRITE) {
+		memcpy(data, val, bytes);
+		efuse->flag = EFUSE_WRITE;
+	} else {
+		efuse->flag = EFUSE_READ;
+	}
+
+	efuse->src = dma_buf;
+	efuse->size = words;
+	efuse->offset = offset;
+	efuse->pufuserfuse = pufflag;
+
+	zynqmp_pm_efuse_access(dma_addr, (u32 *)&ret);
+	if (ret != 0) {
+		if (ret == EFUSE_NOT_ENABLED) {
+			dev_err(dev, "efuse access is not enabled\n");
+			ret = -EOPNOTSUPP;
+		} else {
+			dev_err(dev, "Error in efuse read %x\n", ret);
+			ret = -EPERM;
+		}
+		goto efuse_access_err;
+	}
+
+	if (flag == EFUSE_READ)
+		memcpy(val, data, bytes);
+efuse_access_err:
+	dma_free_coherent(dev, sizeof(bytes),
+			  data, dma_buf);
+efuse_data_fail:
+	dma_free_coherent(dev, sizeof(struct xilinx_efuse),
+			  efuse, dma_addr);
+
+	return ret;
+}
 
-	return 0;
+static int zynqmp_nvmem_read(void *context, unsigned int offset, void *val, size_t bytes)
+{
+	struct device *dev = context;
+	int ret;
+	int pufflag = 0;
+	int idcode;
+	int version;
+
+	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
+		pufflag = 1;
+
+	switch (offset) {
+	/* Soc version offset is zero */
+	case SOC_VERSION_OFFSET:
+		if (bytes != SOC_VER_SIZE)
+			return -EOPNOTSUPP;
+
+		ret = zynqmp_pm_get_chipid((u32 *)&idcode, (u32 *)&version);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
+		*(int *)val = version & SILICON_REVISION_MASK;
+		break;
+	/* Efuse offset starts from 0xc */
+	case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
+	case EFUSE_PUF_START_OFFSET ... EFUSE_PUF_END_OFFSET:
+		ret = zynqmp_efuse_access(context, offset, val,
+					  bytes, EFUSE_READ, pufflag);
+		break;
+	default:
+		*(u32 *)val = 0xDEADBEEF;
+		ret = 0;
+		break;
+	}
+
+	return ret;
 }
 
-static struct nvmem_config econfig = {
-	.name = "zynqmp-nvmem",
-	.owner = THIS_MODULE,
-	.word_size = 1,
-	.size = 1,
-	.read_only = true,
-};
+static int zynqmp_nvmem_write(void *context,
+			      unsigned int offset, void *val, size_t bytes)
+{
+	int pufflag = 0;
+
+	if (offset < EFUSE_START_OFFSET || offset > EFUSE_PUF_END_OFFSET)
+		return -EOPNOTSUPP;
+
+	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
+		pufflag = 1;
+
+	return zynqmp_efuse_access(context, offset,
+				   val, bytes, EFUSE_WRITE, pufflag);
+}
 
 static const struct of_device_id zynqmp_nvmem_match[] = {
 	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
@@ -50,20 +206,18 @@ MODULE_DEVICE_TABLE(of, zynqmp_nvmem_match);
 static int zynqmp_nvmem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct zynqmp_nvmem_data *priv;
-
-	priv = devm_kzalloc(dev, sizeof(struct zynqmp_nvmem_data), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	struct nvmem_config econfig = {};
 
-	priv->dev = dev;
+	econfig.name = "zynqmp-nvmem";
+	econfig.owner = THIS_MODULE;
+	econfig.word_size = 1;
+	econfig.size = ZYNQMP_NVMEM_SIZE;
 	econfig.dev = dev;
+	econfig.priv = dev;
 	econfig.reg_read = zynqmp_nvmem_read;
-	econfig.priv = priv;
-
-	priv->nvmem = devm_nvmem_register(dev, &econfig);
+	econfig.reg_write = zynqmp_nvmem_write;
 
-	return PTR_ERR_OR_ZERO(priv->nvmem);
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &econfig));
 }
 
 static struct platform_driver zynqmp_nvmem_driver = {
-- 
2.36.1

