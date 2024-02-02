Return-Path: <linux-kernel+bounces-49769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C73A846F2C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65C91C2085A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3030514198F;
	Fri,  2 Feb 2024 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="peoti+4H"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68714078F;
	Fri,  2 Feb 2024 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873965; cv=fail; b=mVO09UQv1DPC9uZGU/r6c85XvdqDVtS2RAzQZhV80jj7lgr/rRoOWblP8CDnefNO0jQhvSrdgOQRm4Nb6V3PPm+ZrHPIja2beJF+rsci/KrVfcgTwTKUf7TlY+P0ct4WzYWgLgcu3q/vkR0/fmaJPWFOhHUxqkdp90nkpWalqXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873965; c=relaxed/simple;
	bh=WVTpUF6lr7OOUcZb25Jy9nufIQNXCZSCJWS88wlpWpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kesLpLzcDdPLdds9Tqs1OlUoBBHcdQ2jmt0R4o4YSlnZQMl5F/FQ5lJ50y+oA87Kpb7isjsPU70ccVG6fh8htLnTYIWb74ao4ajs/xfgVSvCKHBRcbkNiCXe0nOJFQqYLjKGEa3eBe+o1Npf+hWKsTnQAu0iwsPRqIytwUWQT+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=peoti+4H; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loXGbOAojIdWL3bi9dQpQVQ2drC1+Z2LN+Buf8zRaoh/SHa6K1ubs7fveD6jLF94GppXcFJvUxB23kp8B76uJEQeyUwYjcG5QV5M/NJAQc40Tbolz9OTRqPYkQTa5KoNHFj/5VLqSN56VdLGjgNtrYBM2Ys9aLx8OMVf8UU3lA90YemSAK+9+ncbtPndvAqTEWgYbaPSUI0+lhWc01w/XDuT2RW9zoBUtboVVYzbvurL3lBqNqtkjoPTrRw9FVh9twnSYDXxDDCkRx3G5obU4FEFn0qeUxHg2WAgX+gj60G1B/Lg9+GhRXdMdS0lNdBqCvldPVNH3Yp/XS0+GYR9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2+6k1dAPykebW78rDXHC8q5YjqCp4KU6kCHtB1JTWY=;
 b=amqsxcI1ZrThU9ZUw3dIAU81tr2tnM86wFeWVgi1FUOgiwTjddZWQM6T0KqiYR9kCxDrOIv40CGyNvRuHdikUsF4Gt3nkZvXvwfD3aP9Y0Fibkox4c0MmDjRhYmODy6q5gP9xn5xn/Fqn6b9p7Wzm/nOz0WrbAAQDlyFyLmKTnDEsGkp9ZzhOGFVzvmT7Hg79wGDbfqGGadzfItfWgL9Npxf4U4bHEHyIqguJvvznEmT+M5Iq02STBUVvtgXJRH2acafcZF54NOAZxAQZ/aufWrtBMB3Pfqn7PT3j6Ch63oishBijFSLabcpc1hxrVC1KUtVBu+CL4DeuWed7Vzzuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2+6k1dAPykebW78rDXHC8q5YjqCp4KU6kCHtB1JTWY=;
 b=peoti+4HC55YhICcP5z5fhJze8tPB7TWi0bDIigz2+lE2Fw/sjgb8tA621OfpDmRw+u3ewEtn8G+BMs8rUXo8fnt53VxEDcp/xUyXkc8ULppO2kupDPrn/D+WbHEPwltulIRCoDVc/1KKQy92h3PSl76T2a75Yc1BzBFVBQfNl4=
Received: from PH8PR07CA0001.namprd07.prod.outlook.com (2603:10b6:510:2cd::26)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Fri, 2 Feb
 2024 11:39:19 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::98) by PH8PR07CA0001.outlook.office365.com
 (2603:10b6:510:2cd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30 via Frontend
 Transport; Fri, 2 Feb 2024 11:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 11:39:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 2 Feb
 2024 05:39:18 -0600
Received: from xhdbharathm40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 2 Feb 2024 05:39:16 -0600
From: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To: <srinivas.kandagatla@linaro.org>, <michal.simek@amd.com>,
	<kalyani.akula@amd.com>, <praveen.teja.kundanala@amd.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 3/4] nvmem: zynqmp_nvmem: Add support to access efuse
Date: Fri, 2 Feb 2024 17:08:42 +0530
Message-ID: <20240202113843.17999-4-praveen.teja.kundanala@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 5503b8d8-6aea-4f1c-a4c6-08dc23e397ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UcxyHNT+syXmRqf5ZbgvqJ9sHxe9/qLzy+PVEHLNjeUhfL2z3v1RlGXcgxDqwxsIGn6mDQRcejASsqHA+kSXreCN0eXPnt0HwXbDo7XQH6cDmEoc1fMAcL+yThAGuxyXh8rdDOyaOnszmn18crpJFsOLGjhgM9qUvxS7tywkpY/ze6/kV+ZT8OFkVbDy2u0ULq/Xoa3CMKxqhClFjc7H7oozAr3H99UMSn33tnO70MAotasesxXW1GuJZrtvGL77H+uebi42WnhNNCRcYTCK/8YBr18s6haojI61K5WDNGlZWcCdAtI7ZEZJs5AM/+93pkhYiybWZR7de4MYjENiyA4w7VdsvwqzPOUcbFzgDeqBAAmObLj2HyRRAEl1xwm4xIMhhYpOwSp5Sk5YWxXGQKHyjFJNuF6DMuMD8H0RLIGz0G31otSreWEqpqmyZWM8YCJ6RoXgZhiYS6hvY5mAQv4w5naVNwSnbIpwVQbgedA9SooqE05Rj4Oxn5kLq6JTjTa36rD4maKyAiKqPD279KxkGVfaoWBzphE7PJly+i6/kNfhDysBedXk0sW8RVhu9n/+lt7s6XhokXkHZls44/95sHOdU69EPWPJx7U90UccHVsl5fwgJLgen6iFE73u1gDzcf9yuvTjlkRnj4L6K5nCzmTYuak9Bd2Q+w1wxNJD4zYP4HuZSzQRRFvmhuPNQ3ZDyKx1199eEHu9sl2cPIvVaKNdmi7QDSsO34Wlde5h1UPzjjPHW5DO12ezV0ZXLRLiV2P1/lGcep7sbCA0Gw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(46966006)(40470700004)(36840700001)(36860700001)(5660300002)(4326008)(2616005)(8676002)(8936002)(103116003)(40480700001)(40460700003)(82740400003)(81166007)(83380400001)(110136005)(86362001)(336012)(41300700001)(47076005)(70206006)(26005)(2906002)(1076003)(36756003)(478600001)(6666004)(70586007)(316002)(356005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:39:18.9282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5503b8d8-6aea-4f1c-a4c6-08dc23e397ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561

Add support to read/write efuse memory map of ZynqMP.
Below are the offsets of ZynqMP efuse memory map
	0 - SOC version(read only)
	0xC - 0xFC -ZynqMP specific purpose efuses
	0x100 - 0x17F - Physical Unclonable Function(PUF)
                efuses repurposed as user efuses

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
---
 drivers/nvmem/zynqmp_nvmem.c | 186 +++++++++++++++++++++++++++++++++--
 1 file changed, 176 insertions(+), 10 deletions(-)

diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index 391d8e88b270..8682adaacd69 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
@@ -11,24 +12,189 @@
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
+};
+
+static int zynqmp_efuse_access(void *context, unsigned int offset,
+			       void *val, size_t bytes, enum efuse_access flag,
+			       unsigned int pufflag)
+{
+	struct device *dev = context;
+	struct xilinx_efuse *efuse;
+	dma_addr_t dma_addr;
+	dma_addr_t dma_buf;
+	size_t words = bytes / WORD_INBYTES;
+	int ret;
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
 
-static int zynqmp_nvmem_read(void *context, unsigned int offset,
-			     void *val, size_t bytes)
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
+
+static int zynqmp_nvmem_read(void *context, unsigned int offset, void *val, size_t bytes)
 {
 	struct device *dev = context;
 	int ret;
+	int pufflag = 0;
 	int idcode;
 	int version;
 
-	ret = zynqmp_pm_get_chipid(&idcode, &version);
-	if (ret < 0)
-		return ret;
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
+}
+
+static int zynqmp_nvmem_write(void *context,
+			      unsigned int offset, void *val, size_t bytes)
+{
+	int pufflag = 0;
+
+	if (offset < EFUSE_START_OFFSET || offset > EFUSE_PUF_END_OFFSET)
+		return -EOPNOTSUPP;
 
-	dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
-	*(int *)val = version & SILICON_REVISION_MASK;
+	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
+		pufflag = 1;
 
-	return 0;
+	return zynqmp_efuse_access(context, offset,
+				   val, bytes, EFUSE_WRITE, pufflag);
 }
 
 static const struct of_device_id zynqmp_nvmem_match[] = {
@@ -45,11 +211,11 @@ static int zynqmp_nvmem_probe(struct platform_device *pdev)
 	econfig.name = "zynqmp-nvmem";
 	econfig.owner = THIS_MODULE;
 	econfig.word_size = 1;
-	econfig.size = 1;
+	econfig.size = ZYNQMP_NVMEM_SIZE;
 	econfig.dev = dev;
 	econfig.add_legacy_fixed_of_cells = true;
-	econfig.read_only = true;
 	econfig.reg_read = zynqmp_nvmem_read;
+	econfig.reg_write = zynqmp_nvmem_write;
 
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &econfig));
 }
-- 
2.37.6


