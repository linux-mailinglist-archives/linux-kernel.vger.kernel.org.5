Return-Path: <linux-kernel+bounces-49768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305BC846F29
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542A21C24625
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC56414078B;
	Fri,  2 Feb 2024 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tsCIC1/4"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EFA13F01D;
	Fri,  2 Feb 2024 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873962; cv=fail; b=joruorabF62LhAN26Nc1j6nhHjnjN0DA7FZM3Uda2f2M7T3cDfZT4FiB9TvW3Gh+wZ6Lwt38JcNXJpiUb5nC83JwJBFniURBQkwmfrHDpXpWY1YjaTu2sONjR45xgGp5ocWG8F0YArmcvoudUJEcKecy5hA1AxOno+3KZi18CQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873962; c=relaxed/simple;
	bh=Uz0ApcAA6JiQkZUd0ilM0lA24O9DEmvRDAhS3oZ+fN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRYAl/TKiEDYz506Ip9CL7XHufk+TU0yo+1hstcKT7dZBZWkv3NAQTJ+cmBTCf9XeVNwZ7h0EZtc8Lc7xaRfpxOchPrVzUZYQM/gO6q4xa9OmiLeWeC+MSAo/CSsYGAtxLcBUuBIg9Sxa9vTofiYvP9+BrKc9IoVWqGuawpJUkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tsCIC1/4; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF2Rqa+kqxgtIuWlgm27El8DLOLnkHspx40h4Zwaa/zSYaCw5f0ym//U+EOUrDVWEVO+uG5YgaDNc79yZy9GS7q32qUkTbtaZjOjSwie8TiEacDruZmK0KiiGfnPCzOubGVAoRjQ/Y78D+4jhddiq68QWJAQctCOB7E8Ykj8beytTOknzSsaqecCw2GF533pnLOFFVR/U9O5cVi58I8at7HguYv21tcpoVRnD8RX9U8nwBFDXG7yBuHuotRqEPLpdMTymSZ66/hFXbtXN7v0wOFBvBtXAbTqmwlE3EfOu5mha4Ic3ckIkAWIhkiqZHghhbG9i/8UO/1xJqzZ1T3jnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zThMBt7dUMB9H92U+RpcfLi0BqyoRA95TFerElYN2JU=;
 b=N+3PaX6GZZbvWAuuSG+Oh6NALL0IsouH1Y6g7I3DqFdE8Dln7tXPj4Z0ybr4kAgh7K9uti+QbU8i2Lekuhc+gUJFpVw/3NAia8ksFjxwTMLQESm4TETpoQURJlAx0tu/enKkO7UbzwMFTAu2jcng29pUPBqdSKgFEw39U2Yi3eCt/WQJvoQ2isU3KTIxDiO+uxAzx3K00Airzmc/lPbSXeetcEc8B2rISaXtI8qHgrXtV+Xm3hyos6QVhmmVDop7ovZb4kQ1MioDEcR+PauqtxYtKkh8JG5hMGkinafljJO70/WVAfFlM6hZLu7250ZwHz1UfYfikGftPffmtAlYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zThMBt7dUMB9H92U+RpcfLi0BqyoRA95TFerElYN2JU=;
 b=tsCIC1/4UqY1LFJiy313su0b4EzYEbI+77tDDvDJwFanV3FGC3hZI69JCeGJ3oemOgxOg6PjAxhxItCfd5tn+Kzm5nrGP1dXeLPXr6EtgUoSgWyIJuEvflne35LSzyKX5S9lj6FitDAbWPVVxLkh7yK3QIAPVnMKlz+GYQ6rjYI=
Received: from SN1PR12CA0054.namprd12.prod.outlook.com (2603:10b6:802:20::25)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.9; Fri, 2 Feb
 2024 11:39:16 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::df) by SN1PR12CA0054.outlook.office365.com
 (2603:10b6:802:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Fri, 2 Feb 2024 11:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 11:39:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 2 Feb
 2024 05:39:15 -0600
Received: from xhdbharathm40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 2 Feb 2024 05:39:14 -0600
From: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To: <srinivas.kandagatla@linaro.org>, <michal.simek@amd.com>,
	<kalyani.akula@amd.com>, <praveen.teja.kundanala@amd.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 2/4] nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup
Date: Fri, 2 Feb 2024 17:08:41 +0530
Message-ID: <20240202113843.17999-3-praveen.teja.kundanala@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240202113843.17999-1-praveen.teja.kundanala@amd.com>
References: <20240202113843.17999-1-praveen.teja.kundanala@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: efea9808-db15-4370-962d-08dc23e3964b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z+OI8M3kYy0zM08NgA6T2AhA/9YDtzB1JIH2ItB2JwfwSZIeqy91FBpS/6hvtQKS5pJZt7ij5/0IslMFMnC0D80Rx/1KROmAWARyz75tgFu2swFykGzpHUW/XyRALxVkv7SLofkCLxzEZntDsHGSZcmEoEfaBaeH0ewni8QIeVrhcW4nBXrf6nMN8sOVyvMdJ6yXDypq3p2srQr0WlGArtcFHnzLDCnrhKXlAWF5cxuBlYbMArTtieanDCwVyClbpXzerYSGA6Erbn9EBim5AMAlXQi3AbdEASJqm7nnRp2I5U2CF6mndhP7B5ddN8yKvuQsgqs8Ww3Qfup+dkIbaeFiHnWYK/VxpqcYHTGK08M3lTR/4SqH3kPhr/92kz2Lo6UShfFGgfE7weCZ0VaGI66+dub3ra5MHbr5Qer5wgfQKfjhSwSDzdBkdRtildHcs7WkyaI+/Rf4hgh5jUdpC31jFWjdYFelAeXZau5qw6tWN3wFJgFqSRNMbmW26TE4CF0lFT1YKLQWFQCmDisiyo8qnIUh5PuREnyDlq7+aoJsIgo6TZJ2hNTpsJHHHPY7Fj+14Jj9ztjigQ4YH8vBd2umXK2cgdIjRFDbb9hx8MiHMvTEiHhvV9CJwOrWfkusiSvN1dY/8YubhZABpVUPJ5J3SvxAx2duXWB2eLG4OFkSNC8Ypj3I1LsZEsSD61AkzzaV+Jz6vetZnpJvk+Thkwsdd1+WoGk/+RIRwKc11gFleup8fIHrMrzNI9Ci8clU3OEJXfy96mOnuPOyEYslVA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(36840700001)(46966006)(40470700004)(1076003)(8676002)(8936002)(4326008)(5660300002)(86362001)(103116003)(2906002)(70206006)(70586007)(110136005)(36756003)(81166007)(316002)(356005)(36860700001)(478600001)(47076005)(82740400003)(83380400001)(6666004)(426003)(41300700001)(26005)(336012)(2616005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:39:16.5227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efea9808-db15-4370-962d-08dc23e3964b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772

- Remove static nvmem_config declaration
- Remove zynqmp_nvmem_data

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
---
 drivers/nvmem/zynqmp_nvmem.c | 37 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index 7f15aa89a9d0..391d8e88b270 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2019 Xilinx, Inc.
+ * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
  */
 
 #include <linux/module.h>
@@ -11,36 +12,25 @@
 
 #define SILICON_REVISION_MASK 0xF
 
-struct zynqmp_nvmem_data {
-	struct device *dev;
-	struct nvmem_device *nvmem;
-};
 
 static int zynqmp_nvmem_read(void *context, unsigned int offset,
 			     void *val, size_t bytes)
 {
+	struct device *dev = context;
 	int ret;
-	int idcode, version;
-	struct zynqmp_nvmem_data *priv = context;
+	int idcode;
+	int version;
 
 	ret = zynqmp_pm_get_chipid(&idcode, &version);
 	if (ret < 0)
 		return ret;
 
-	dev_dbg(priv->dev, "Read chipid val %x %x\n", idcode, version);
+	dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
 	*(int *)val = version & SILICON_REVISION_MASK;
 
 	return 0;
 }
 
-static struct nvmem_config econfig = {
-	.name = "zynqmp-nvmem",
-	.owner = THIS_MODULE,
-	.word_size = 1,
-	.size = 1,
-	.read_only = true,
-};
-
 static const struct of_device_id zynqmp_nvmem_match[] = {
 	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
 	{ /* sentinel */ },
@@ -50,21 +40,18 @@ MODULE_DEVICE_TABLE(of, zynqmp_nvmem_match);
 static int zynqmp_nvmem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct zynqmp_nvmem_data *priv;
+	struct nvmem_config econfig = {};
 
-	priv = devm_kzalloc(dev, sizeof(struct zynqmp_nvmem_data), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->dev = dev;
+	econfig.name = "zynqmp-nvmem";
+	econfig.owner = THIS_MODULE;
+	econfig.word_size = 1;
+	econfig.size = 1;
 	econfig.dev = dev;
 	econfig.add_legacy_fixed_of_cells = true;
+	econfig.read_only = true;
 	econfig.reg_read = zynqmp_nvmem_read;
-	econfig.priv = priv;
-
-	priv->nvmem = devm_nvmem_register(dev, &econfig);
 
-	return PTR_ERR_OR_ZERO(priv->nvmem);
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &econfig));
 }
 
 static struct platform_driver zynqmp_nvmem_driver = {
-- 
2.37.6


