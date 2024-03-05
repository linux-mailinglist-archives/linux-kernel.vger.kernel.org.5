Return-Path: <linux-kernel+bounces-93007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E359E872954
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9671E2835AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7851912AAE3;
	Tue,  5 Mar 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IUy2QBkD"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ABC12B170;
	Tue,  5 Mar 2024 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673718; cv=fail; b=cxHkn1UAs37HZD0zXwLLzSNBkOezkt1mGmo1tLa3F9J29qMQsC2Mgmwmhq38SExQJyOBjImpOTcy0gGAFQOBCuZgRbuWtT0juDwAaqrJd8pEY7JUBKXc0OSh/sFGa2Em0WJbYDRMwEYZESnVZPxtbAjP6R/yTP+CSayT/3jM/kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673718; c=relaxed/simple;
	bh=wihzzRQMyqRJ7LIfj3m+Fswenohlo6Msi6dna8XG2pA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CPkUoYHSs/3IzPzWsBezT/JpIjgGY3+xrwHPndJoEf6+VOG6KWHpCNYWK+dww2m/yMOqV/GqechafbEOnQNoQuIVyFAceIAFYXt3yTXtcAdKvcCctt56IKhfKWpKqY/hpa37l95w8aP4rnNxtqfgO7jk2bDiHw1j+tt1meNR/EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IUy2QBkD; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSKtSJnSCzZVimLqsPW8t7+fa04jdSTjVUdpLvfLl3z+vUm6sjObJDvAaf0dEWtc6PR1qWzURIWPfTW9FDr3C7ST0ULm/7+Psnr6j9I6yv7cxamzE8GGXJRomxRbp2QseUYIo5poTLibVWgIZclB6H4L5PpmgdqOLnszkUOkvDvwHnMonQW1/4+Xf1biUBegSS33+lL66eA4uNcOhOt14G3iaLRtH9Kh3xpToh0R6sTBWgqxrSCKn69VH9Vp5GV5KCFu5r7dhkKK60eK1dIq7NVyCUDyNy5nxPJ2zzizqj9lP2xe7SDW9pVYhH3HrcKl2ZdgAux/+KMCx3rr4bUtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSUNuvGsK7tOqKrD+NJgXgD6U4lfdplUnh1dvFCE2Qw=;
 b=KND6isXqYimusqKzEeZy2vmZzswNWNU+DIeqBQIuBhL210BmPnX2vGaaGtS+Nti7QqB+lIpLoARuuHuFddGd3UyEGX+vZfJaHLObVkbwI0r2nj5jHrXkhgTs4nhgOEhODkYtHBGVtAzSgnVC2m7RqbqfbfNqWcyb3A8dSKs+neVsKEENxWyaWz1vhvywLShYyZLeDtK1JBN41BRrgMN/KisExAfy9Dvk63iqdz8foL0butOz7SgslS00kwTKrnwxCZTVG4M/3uyEhpTeD2AYXkgt3fK3TvBG6U6namR+kIMjr+NRSG9vOtKawmBOAY3nHaJALIIlM7DBAzq66jnOnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSUNuvGsK7tOqKrD+NJgXgD6U4lfdplUnh1dvFCE2Qw=;
 b=IUy2QBkDSFvTvI7ckVmILwGawwrvfiHOajs6lR5BCWz/lGcc36WMvnpl2KcnfNCpiy5p4EN4x0tcexZrSYSALLZ+DVxDCcX62+TZaQZptmE/6CKTozCFRaSZ4tw+Li34TJY499j363iVnpLpt3IfaabxeFgK+2528pCmhayjeBVXoB3IDyrAc+6PI2KF9Bn+OjJ4tB4H/WkXPrAIVkw1J5EQMDqBAVUzE/QdTfYh2exrrsLOmykRPjoTFvQUNzeOVrZw3AASXJETdt18hoVZ4IgoZr2SqB2oilb8PTDbcQEwOg9hfpQLKmZ1+h0ENfUXFM1x9tox/aBmWPrWOv5h/Q==
Received: from SJ0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:33b::21)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 21:21:53 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::18) by SJ0PR05CA0016.outlook.office365.com
 (2603:10b6:a03:33b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23 via Frontend
 Transport; Tue, 5 Mar 2024 21:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 21:21:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 13:21:41 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 5 Mar 2024 13:21:40 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 5 Mar
 2024 13:21:39 -0800
From: David Thompson <davthompson@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>, Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH net-next v2] mlxbf_gige: add support to display pause frame counters
Date: Tue, 5 Mar 2024 16:21:37 -0500
Message-ID: <20240305212137.3525-1-davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c2c038-08bb-4db1-a3e6-08dc3d5a470e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZCpJjS+XTQTmqCXWQCJ3hwcRWVc6mDvsTwzoo6JnVoOJMe91hah35IwPNiNiPZDEQoJ26+KizRPS2lz6Mfi9XtTJRlLo7aItbJ4A4iO7cSbYkhdMQDjtUy44seJTZl3YNy5uSqba2SiIrTLapXjTqcXt6XZBT547vbkc84v3wioeSm87wcaBCBOBPAb94JyreXnd/4XoRCqN9A8HzyaJDnM0+6kVvDYiVADrO3vbv6afFu0U2Qz7ZPp2sv1fk+B+LWJ7xSlm0eEtkFhx5dJ2e5/osrwG3DC6fZQUODlfV0AnkKyo0R/nfHXhZHdJyDiSIdotrgHqjJkHsEnfuquFX9ix+1+IKPdww6vIiybq4EZXi7slGXAoujDj28BaJBzGH8160olj8jtUPj2pbSYDYuaJIKvxVNruFpWRP5lUyMXFR5Vk8oR6h9OQw+neat+WhsEHSd3+FmaSN0serIFZtAhljKqSA326QDEQMYdf6By7/AtB/qAx38U1bA+RN77Na9CwnTOtnnZtE/KZlSPtPuyRYvEJdPqa6uDE1FEaYgBWe8NiWMUkS5kA0Jg3LV3YaPhzn49CzjDlz338xuM2CUgfSN1/B0bU5UnoL/n4IMs+n+4Q2RzROiPSpe8LWuhBnwvDHu0Te1N94BEWNhTuat4B8Wpz59mdjorTIJPdno59ekZZ4RkP7fk+T48uvMVw7Do3B3CpwkfrFgj6UveICOTbpQwFJs2pRou9Ma0MMzi9CvuLs7aKI7qfn63esX1w
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 21:21:52.8104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c2c038-08bb-4db1-a3e6-08dc3d5a470e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970

This patch updates the mlxbf_gige driver to support the
"get_pause_stats()" callback, which enables display of
pause frame counters via "ethtool -I -a oob_net0".

The pause frame counters are only enabled if the "counters_en"
bit is asserted in the LLU general config register. The driver
will only report stats, and thus overwrite the default stats
state of ETHTOOL_STAT_NOT_SET, if "counters_en" is asserted.

Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
v2
a) Removed logic to report stats of zero if counters are
   not enabled.  Instead, the default statistics state of
   ETHTOOL_STAT_NOT_SET should be maintained since driver
   is not actually reporting stats.
b) Updated commit message accordingly
---
 .../mellanox/mlxbf_gige/mlxbf_gige_ethtool.c  | 36 +++++++++++++++++++
 .../mellanox/mlxbf_gige/mlxbf_gige_regs.h     | 30 ++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
index 253d7ad9b809..8b63968bbee9 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
@@ -124,6 +124,41 @@ static void mlxbf_gige_get_pauseparam(struct net_device *netdev,
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
+	/* Read LLU counters to provide stats only if counters are enabled */
+	if (mlxbf_gige_llu_counters_enabled(priv)) {
+		data_lo = readl(priv->llu_base + MLXBF_GIGE_TX_PAUSE_CNT_LO);
+		data_hi = readl(priv->llu_base + MLXBF_GIGE_TX_PAUSE_CNT_HI);
+		pause_stats->tx_pause_frames = (data_hi << 32) | data_lo;
+
+		data_lo = readl(priv->llu_base + MLXBF_GIGE_RX_PAUSE_CNT_LO);
+		data_hi = readl(priv->llu_base + MLXBF_GIGE_RX_PAUSE_CNT_HI);
+		pause_stats->rx_pause_frames = (data_hi << 32) | data_lo;
+	}
+}
+
 const struct ethtool_ops mlxbf_gige_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_ringparam		= mlxbf_gige_get_ringparam,
@@ -134,6 +169,7 @@ const struct ethtool_ops mlxbf_gige_ethtool_ops = {
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


