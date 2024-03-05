Return-Path: <linux-kernel+bounces-92589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EFB87228B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BC91F22E07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ACB1272C3;
	Tue,  5 Mar 2024 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OJsfegRt"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D774126F23;
	Tue,  5 Mar 2024 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651951; cv=fail; b=nUqbHqgIH0h2apiDlA5XuFZqa2/wmpj2MTNmOTbraITjbsWjxS8iCXXni5PphYxnyo7EhVc09mBpClPkerq6eihEJaJe9bFOOAkvwkSCr4lkAYKB0FKbGe430gWetUL45LJuO9JHaPmRIxbyFCT2Frprts2+dOmj/NcCPZgp8EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651951; c=relaxed/simple;
	bh=9E6oXbfFkyP4TPHRZXDTKSEWvPbMp9XgjJDIhTteY9c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FuXTnPjY1H8GhhJl6mLQzvHVlBr+/EjSDZSUeEdEMnauL5bDvI9Mjncvh75D8Qiv/eRm09X+RFnIqXw+z/Ge2KABbxWdjK+E/ZCbMayAxn/ff6SKML8HL3KWAbPROiG1eMYb5TsVuzHXCyECzsasfemP6AaySGP3PeLNpc15Y0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OJsfegRt; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyUSQKEgV2hkBpyx5XbI2HY+XPEYOc5wUQsAegoByzUusvSJ/b1CR5RiFQpIm/fe65rLFhzG6eq9MaFux/clRCMNkf9UlT6yHXVBPkFO0Soa6WgC6on5RidwCRw6N0/J5z08bU5N7uPUVl55cQ3rg0xIDbwhpTKmJ3aTqjDb0AdqzRPv2p+ulsVpnCUK2DLCaxsihXLFWIgGux1v+MHWr8gPvoADm1gIcVLUlMnwuK4vISA1L5mI+1RuBnqsMDPGKgB1zkCDp/eRMiqEHUOQxlG7bkreNoWfWco7tn5RCKcyQmB7aohiBad6xRkCH1Q9d+3IqCzIUeEl09pVtuQMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFtG53mIFxhSLujdL2ykMpe2S2v0KzJRzGipKXFVY+s=;
 b=Lksi5Lhm3jCQHdKmkKiI3d1qky4yY5OGL2581ZRoKon3pb8RbnQjXpCoD1rw8BtustL6hVZJBxIwCB1j5vLgjVbh6FtRlXNFcFtouAEP5UGQEiD9/C/1t1optwq1W4TSQt6ttSeKFck/oi3LvButeh1u0FefM2tgxzxY09YyHMEZUhdEKqxaXhJUnCepItn8OcyPsAZcZLkno1mzlXSi8DAtYXco1Z+NKN5PJPU484QNhO67zQ0S7TeSzRok96b40LsrCzYolnJlG6G/1hREMJ6rJDjeFUwZHbs0H+Gtt+Ph35oFd52BtPFrQd1L4+c0oEcIUHOudjv1eOSkz+BqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFtG53mIFxhSLujdL2ykMpe2S2v0KzJRzGipKXFVY+s=;
 b=OJsfegRtWx6vYYojuWn7xQsQQ0AYH28zhkbkuxsMc62qqJaasAKrpo2gg/cwXWnodrLNS/+1YA6f09Ak6HOAISPsjVmV91GKgxXt6A3VF0S3+x74GHUEVOXj0PL8rawbQ0oUFBnL6/qBoAIjWRmTCSkpATAW7cM8MPt6eWQYesLgPyUBa0OEZZglSKjqN3f0U9Gdi5irViqcSiXpEMeTD4cKFiS7XyVDhMZM46cfFi1OEFc4TmrdY+2s12Y2RVyj+CmJlpYZVLU/tj7AGXlQjWuZHUIVnk/770xaZM+mQcO+zGhcHkZBvJ2IG1l5QvOCfihB8v71ZwqBgInEskJwPg==
Received: from BL1P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::30)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Tue, 5 Mar
 2024 15:19:06 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::e9) by BL1P222CA0025.outlook.office365.com
 (2603:10b6:208:2c7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 15:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 15:19:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 07:18:54 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 5 Mar 2024 07:18:54 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 5 Mar
 2024 07:18:53 -0800
From: David Thompson <davthompson@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>, Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH net-next v1] mlxbf_gige: add support to display pause frame counters
Date: Tue, 5 Mar 2024 10:18:51 -0500
Message-ID: <20240305151851.533-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: c253d8fc-2c44-45ad-ceda-08dc3d2798e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zjJSSlR57LOZVgObjD60/bYdGrsSdNE7X+pYj16W+x8Fj3NdVayNqU0hF1ZwC29DVMwWaIP3rwov31v4/mrV21up3NtHt/I7x6Ucn0vXL1TBsjk7YzYvTF3OYfbHKgzXTsDX0qJGc7m/2SdQcVHST87wtFYWkTRQDRs9ADaM/A/euP5HYrxblwxqBkbFjyrrNMJaEqnU9VwhiICGugjapdOPa0YiGdmH65itGvJBx0XASbAOx4Q65pU0MpXBRL+LK6npinEYulbPB2HJmHCedlXlZWnbTn3YtJso2lFI6xQx22jCOUPTNAC9AoHsijO2aqteElp5/c9WWK/EnXLaMXRABVoAoCtTXv6OojTkhwQfOvPSfsOFuHEzBV0HigkPdLo3OkbbYavGtKYvQ/WipBuM/osC8KNOySFaqJ/zJbQoPRPsEOhjOXokJ/OqYFeUB0sdrfIFHrK1NBQU30URzl4VZyaju5FtZOsYoUjdSJi3IG7J1mWuUb9gSle88yybGAzAA9qwFqJmg4OW9cK+7Z1kuT2j+1UWvyqdPyI4ZlWbbtVrDUla3C7fyRwoSSX7BFn7/BGpf+co4NmdI3w3B5v7eCtwSbuku+xyRe+SY/yYnceRkhds+be+EzbG4Vk4KphNlCMhkJuq86zXrvo9oEPiHqJ21BLzHTDVS2lqcxS4PpBwR7s8x9TgABK8XUp8pAe2HlooCmuGPMZFVTUZXRW+G32E2bAZlrAMOJqSTJvrtQ51CPXxtEGkQntdkvQR
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:19:05.5912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c253d8fc-2c44-45ad-ceda-08dc3d2798e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384

This patch updates the mlxbf_gige driver to support the
"get_pause_stats()" callback, which enables display of
pause frame counters via "ethtool -I -a oob_net0".

The pause frame counters are only enabled if the "counters_en"
bit is asserted in the LLU general config register. If this bit
is not asserted, reads to these counters return bogus values.
A run-time check is made to return counter values of 0 if
the counters are not actually enabled.

Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
 .../mellanox/mlxbf_gige/mlxbf_gige_ethtool.c  | 39 +++++++++++++++++++
 .../mellanox/mlxbf_gige/mlxbf_gige_regs.h     | 30 ++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
index 253d7ad9b809..107acab06b7e 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
@@ -124,6 +124,44 @@ static void mlxbf_gige_get_pauseparam(struct net_device *netdev,
 	pause->tx_pause = 1;
 }
 
+static bool mlxbf_gige_llu_counters_enabled(struct mlxbf_gige *priv)
+{
+	u32 data;
+
+	if (priv->hw_version == MLXBF_GIGE_VERSION_BF2) {
+		data = readl(priv->llu_base + MLXBF_GIGE_BF2_LLU_GENERAL_CONFIG);
+		if (data & MLXBF_GIGE_BF2_LLU_COUNTERS_EN)
+			return true;
+	} else {
+		data = readl(priv->llu_base + MLXBF_GIGE_BF3_LLU_GENERAL_CONFIG);
+		if (data & MLXBF_GIGE_BF3_LLU_COUNTERS_EN)
+			return true;
+	}
+
+	return false;
+}
+
+static void mlxbf_gige_get_pause_stats(struct net_device *netdev,
+				       struct ethtool_pause_stats *pause_stats)
+{
+	struct mlxbf_gige *priv = netdev_priv(netdev);
+	u64 data_lo, data_hi;
+
+	/* Read LLU counters only if they are enabled */
+	if (mlxbf_gige_llu_counters_enabled(priv)) {
+		data_lo = readl(priv->llu_base + MLXBF_GIGE_TX_PAUSE_CNT_LO);
+		data_hi = readl(priv->llu_base + MLXBF_GIGE_TX_PAUSE_CNT_HI);
+		pause_stats->tx_pause_frames = (data_hi << 32) | data_lo;
+
+		data_lo = readl(priv->llu_base + MLXBF_GIGE_RX_PAUSE_CNT_LO);
+		data_hi = readl(priv->llu_base + MLXBF_GIGE_RX_PAUSE_CNT_HI);
+		pause_stats->rx_pause_frames = (data_hi << 32) | data_lo;
+	} else {
+		pause_stats->tx_pause_frames = 0;
+		pause_stats->rx_pause_frames = 0;
+	}
+}
+
 const struct ethtool_ops mlxbf_gige_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_ringparam		= mlxbf_gige_get_ringparam,
@@ -134,6 +172,7 @@ const struct ethtool_ops mlxbf_gige_ethtool_ops = {
 	.get_ethtool_stats      = mlxbf_gige_get_ethtool_stats,
 	.nway_reset		= phy_ethtool_nway_reset,
 	.get_pauseparam		= mlxbf_gige_get_pauseparam,
+	.get_pause_stats	= mlxbf_gige_get_pause_stats,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 };
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h
index cd0973229c9b..98a8681c21b9 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h
@@ -99,4 +99,34 @@
 #define MLXBF_GIGE_100M_IPG_SIZE                      119
 #define MLXBF_GIGE_10M_IPG_SIZE                       1199
 
+/* Offsets into OOB LLU block for pause frame counters */
+#define MLXBF_GIGE_BF2_TX_PAUSE_CNT_HI                0x33d8
+#define MLXBF_GIGE_BF2_TX_PAUSE_CNT_LO                0x33dc
+#define MLXBF_GIGE_BF2_RX_PAUSE_CNT_HI                0x3210
+#define MLXBF_GIGE_BF2_RX_PAUSE_CNT_LO                0x3214
+
+#define MLXBF_GIGE_BF3_TX_PAUSE_CNT_HI                0x3a88
+#define MLXBF_GIGE_BF3_TX_PAUSE_CNT_LO                0x3a8c
+#define MLXBF_GIGE_BF3_RX_PAUSE_CNT_HI                0x38c0
+#define MLXBF_GIGE_BF3_RX_PAUSE_CNT_LO                0x38c4
+
+#define MLXBF_GIGE_TX_PAUSE_CNT_HI ((priv->hw_version == MLXBF_GIGE_VERSION_BF2) ? \
+				    MLXBF_GIGE_BF2_TX_PAUSE_CNT_HI :    \
+				    MLXBF_GIGE_BF3_TX_PAUSE_CNT_HI)
+#define MLXBF_GIGE_TX_PAUSE_CNT_LO ((priv->hw_version == MLXBF_GIGE_VERSION_BF2) ? \
+				    MLXBF_GIGE_BF2_TX_PAUSE_CNT_LO : \
+				    MLXBF_GIGE_BF3_TX_PAUSE_CNT_LO)
+#define MLXBF_GIGE_RX_PAUSE_CNT_HI ((priv->hw_version == MLXBF_GIGE_VERSION_BF2) ? \
+				    MLXBF_GIGE_BF2_RX_PAUSE_CNT_HI : \
+				    MLXBF_GIGE_BF3_RX_PAUSE_CNT_HI)
+#define MLXBF_GIGE_RX_PAUSE_CNT_LO ((priv->hw_version == MLXBF_GIGE_VERSION_BF2) ? \
+				    MLXBF_GIGE_BF2_RX_PAUSE_CNT_LO : \
+				    MLXBF_GIGE_BF3_RX_PAUSE_CNT_LO)
+
+#define MLXBF_GIGE_BF2_LLU_GENERAL_CONFIG             0x2110
+#define MLXBF_GIGE_BF3_LLU_GENERAL_CONFIG             0x2030
+
+#define MLXBF_GIGE_BF2_LLU_COUNTERS_EN                BIT(0)
+#define MLXBF_GIGE_BF3_LLU_COUNTERS_EN                BIT(4)
+
 #endif /* !defined(__MLXBF_GIGE_REGS_H__) */
-- 
2.30.1


