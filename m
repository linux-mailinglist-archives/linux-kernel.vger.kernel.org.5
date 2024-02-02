Return-Path: <linux-kernel+bounces-49767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0B5846F25
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B188A1C24750
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D0813F00B;
	Fri,  2 Feb 2024 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5e0xLKI1"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C32913DB89;
	Fri,  2 Feb 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873958; cv=fail; b=ZM8RDoHPhaR5F1GDiMXl1CHfNFe849EFajnsbE1aYpWSBS3e/UibVJ+aE83KZdIf8GgFiO6+bCnMwS92UfhpkiQWoWzNnlCy2MDvSj85oUs71xP+pWKJ4mI81RM+z4nGarfNqb7gUe4lmTWm17AgEDCIKBCM3GfV1npHk85Guxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873958; c=relaxed/simple;
	bh=oTrAwxaDhw58YZJ3+UoujQkVyfPZVJdvcn9ODfXTzqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ik9PxW8vsl+GHp64SlmbpLKwGN5LKy8nmyO+GSV3H29ErajbnLpKb5buNZoKS1B4Im/ZvlclQWdIfW4IY/CDT8v9Yrum2PChZsNuHViTC0ryN6Ml8XTxiQ4fRnWPSzG87iuaHzRFtEGntwWNEIBBDed+SS2tLaTwxRLOCxL+K54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5e0xLKI1; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFqSkt9s13MOQA224u/aOnB1msljWjtv9Gy9NcHG8vJb2KFwfovkD6OPG3clE6+O1uwjXtBwi7QbD1xGUgQkzTMml8PdNDy0uo5Poda/q4arKLgyfGfHGIqMgk9z0nbAqlHn5CNeXix/5UcYX4LjOxeo5Ezgm0Keec4FYn5r9wugUzKOOGJzYMk4c5FC63VCCHAcVM3ESXmc72+L4MvF+bRGakSOqq5rvM5pduI0mLkc6yHfkah8iBCDOtQOKCN3+kDv2Jca6ZbGQJqnQQwtrosHf7YwMewQt5UR+aRLTQJ0KlMOnTCj+pOArKCfrkvYKTTfevxhCjuMz0h5kb+63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3g1/2cNqEtc8zRKF3VCwz+IRclreZquaPZCwmmVGtk=;
 b=lznSxvkTKZYLKFjrc6CqeUha4s2oicGdmmj1lUG91fDYCdzx1dYSfH6/8MvVVyvWbR/lyqDc0cub81i7RU+A40OD2nqWxtqeFhSmCqoacp0Qz8D7PgXfein9bkBnDcvMz6ZdWRZyzNe0vooPifpeKmIVSrFD4Xmg768Cmt9vpHaHad7zUJH+KDtOfAhX39c4lqRX+KaF0B4mSfbvKTvDOmVowTxTMFhsriLhqm3FPdHYPaDDgEtw64uD4qPwJ73+QPeWFOruvsYXHssRjO86tDaDw/1L6CuA2DsCMmDEOfKlpI3T7rgK1gjpvneP6I0lgHmG6/NEN9CKY4/vBBYpDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3g1/2cNqEtc8zRKF3VCwz+IRclreZquaPZCwmmVGtk=;
 b=5e0xLKI10++fr9qj0hk4/yXSlEHoGCdHoO2jRFNIJ+JqIxA06TwdbfrWSsHWaKiqqAmtCe28JAh45sc0EqBCKzydNQGTPcJhgVedG9PmtLRcL7Y2cc9n3wfvcAXRDTvLc6OGxNym19TwVqs+YQbkl9Nz0Rh/ZajBUHzreiDQSUs=
Received: from DS7PR07CA0012.namprd07.prod.outlook.com (2603:10b6:5:3af::20)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Fri, 2 Feb
 2024 11:39:14 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::48) by DS7PR07CA0012.outlook.office365.com
 (2603:10b6:5:3af::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29 via Frontend
 Transport; Fri, 2 Feb 2024 11:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 11:39:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 2 Feb
 2024 05:39:13 -0600
Received: from xhdbharathm40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 2 Feb 2024 05:39:11 -0600
From: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To: <srinivas.kandagatla@linaro.org>, <michal.simek@amd.com>,
	<kalyani.akula@amd.com>, <praveen.teja.kundanala@amd.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 1/4] firmware: xilinx: Add ZynqMP efuse access API
Date: Fri, 2 Feb 2024 17:08:40 +0530
Message-ID: <20240202113843.17999-2-praveen.teja.kundanala@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 733aef1d-85a2-4f99-9cc6-08dc23e394dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vWMHXcBp7YZ9lZpD+sRMWZQMMNeQgVWsgiBlYj5FGplRAtxoqONeTJtXKh+k4F+ORBlNj+V51zWSy9iSNYATdvUr+o5N3spzKIpNuQKwBW5aFEPepI+fFXrj2O33FnyQQolivosobWwtdVYPgwHGyLB+EKWselj9Nm83XyF13agHFiK2wy36Fs1CUPzbjrgNlntlUeJTScPh59t7czp4OKsYby0IUQhN16jkcrovIJ+TiT4+p0hb9Gi8yEwPeMxPAHFEftTuOh6nq48tNWoTsiCvMYxGwjIBhLCUJeSjJ49HQkTv4FOLqU/qh84AlYO4gEUFzMYJMtyWVgDV5QG4U63AeUvOz7wKhXz0Ya7e2OqYipChcFpoDCwWdqIu3LghPlf95Vw/z/XBzr/TGr8K9yyoQP7XhCtiCh86qFULUCd5o786/Y9970XqeyxUPeGwPRcxk7IkGBDLsJ3j1bdcDSieMIqxl5a+ryIhHts1qIZysdJwkm/cKgI4vWznDJSr5Ls6c1UtupyH1gx0fRDkmUFVu5bOiCCsuQkFWPxNKORWmPSSWqgGvKbkdCX3aLGldKOxT+nUNHgRQtgesLZ/SO9wLT+TZmfAv8FQZeEJZsiawoQ0NKx2/VDG0F9Mkfmv5mdzLh9WOI95f13MbEs2GIOxRZEtKBUZYDUdK3qckTNc9tLWev7AfEWzMtcl+6U5+3ZSBaqzFyvOvc39+HjFj9wHvcuKBB3i719L1yaO7TLYaq8mSSSVN7yxNaz5wYvNIIcX2mH1p/9TfeclsI4BEA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(336012)(426003)(1076003)(40460700003)(26005)(2616005)(316002)(41300700001)(36756003)(36860700001)(47076005)(6666004)(478600001)(82740400003)(356005)(81166007)(83380400001)(86362001)(8936002)(103116003)(70206006)(70586007)(5660300002)(8676002)(110136005)(2906002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:39:14.1333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733aef1d-85a2-4f99-9cc6-08dc23e394dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398

Add zynqmp_pm_efuse_access API in the ZynqMP
firmware for read/write access of efuse memory.

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 25 +++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  8 ++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 79789f0563f6..9bc45357e1a8 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -3,6 +3,7 @@
  * Xilinx Zynq MPSoC Firmware layer
  *
  *  Copyright (C) 2014-2022 Xilinx, Inc.
+ *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
  *
  *  Michal Simek <michal.simek@amd.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -1384,6 +1385,30 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_aes_engine);
 
+/**
+ * zynqmp_pm_efuse_access - Provides access to efuse memory.
+ * @address:	Address of the efuse params structure
+ * @out:		Returned output value
+ *
+ * Return:	Returns status, either success or error code.
+ */
+int zynqmp_pm_efuse_access(const u64 address, u32 *out)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!out)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_EFUSE_ACCESS, ret_payload, 2,
+				  upper_32_bits(address),
+				  lower_32_bits(address));
+	*out = ret_payload[1];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_efuse_access);
+
 /**
  * zynqmp_pm_sha_hash - Access the SHA engine to calculate the hash
  * @address:	Address of the data/ Address of output buffer where
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 9a7e52739251..1a069a56c961 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -3,6 +3,7 @@
  * Xilinx Zynq MPSoC Firmware layer
  *
  *  Copyright (C) 2014-2021 Xilinx
+ *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
  *
  *  Michal Simek <michal.simek@amd.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -171,6 +172,7 @@ enum pm_api_id {
 	PM_CLOCK_GETPARENT = 44,
 	PM_FPGA_READ = 46,
 	PM_SECURE_AES = 47,
+	PM_EFUSE_ACCESS = 53,
 	PM_FEATURE_CHECK = 63,
 };
 
@@ -562,6 +564,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 			      const u32 qos,
 			      const enum zynqmp_pm_request_ack ack);
 int zynqmp_pm_aes_engine(const u64 address, u32 *out);
+int zynqmp_pm_efuse_access(const u64 address, u32 *out);
 int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_get_status(u32 *value);
@@ -749,6 +752,11 @@ static inline int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_efuse_access(const u64 address, u32 *out)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_sha_hash(const u64 address, const u32 size,
 				     const u32 flags)
 {
-- 
2.37.6


