Return-Path: <linux-kernel+bounces-156959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCD98B0AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C251C211CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF62B15D5CA;
	Wed, 24 Apr 2024 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gd4AKjmW"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54715CD4A;
	Wed, 24 Apr 2024 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965483; cv=fail; b=TxG5i7di29B20omRUrPcChTPDi4V+wkv2vkhXPIXdnUCj6l/MYbbXE+hW6MSgoWMZ7kALHpSPNbgngCWYhTopa3FJFgp2ER/0M4HR490KiblRe+yQQMKYVJ29nj58zmHaD7qdma/jkNKdS56KAzHo4FoneQtEWRXzXBuu76L9io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965483; c=relaxed/simple;
	bh=s/Op0Yqbf6RICpzZjCKT8cDf9XJlb745p96bEYRmv1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dt2Jfst+fJRSncXAIgmfyl/rT8sArdGhmfpvHqL4yRRWxKToZAGsZhogOffgw0RsMcTzz6famNh9M+LCV8fB3KkAEy4/zvcK9fsgbjDFGvnpy1zX2lpYfPOdVTYYkS78lQcg2gqA+KT6PjRUzIQO2GroyxT1A5qaXCRI2lFYOoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gd4AKjmW; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMcgSLJpwTFSxXBnx0URBpHYwa1M09l4U2HVOsFYex0BHaqjyN3YgWIhUiosRiC3dLhXiNKdLv+c7bYU1xQp1V6NxLEajUTKopbjkfKJA8W1e06/COfBh7IDzB7sjmoBYS+rJGYbijfHJKCzRlvc6ABn210l5wGylweiShrgAEmT6cWa9rxIxjs/u0SQM91H8TDAf3fx0hhjt9C/PNoQbpJEyVMDQDHSXoBYSS2thr2v4qvTbngt2dr6mpJxuwSNMfQBDmtnrj4pQecJj8cAC+IC5p0t7P/RijEZ+cu2JUMTo10pDZu9L36dXEuswY7PUqwPBHBqxkxivQmyalfLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLEiPhD5ALkvr7wsO4cJSZBPyLqh01f+Muq5qXORYMA=;
 b=eSNVF8vxcci+EaILmUWDsK9nstBWPPmqYfFZjrF8GE8shkReYcRmKlBzWvHVrjkpQhE8MjNtLT68B0D0+5zjzScjOewNkqBjXVQ01YDqzmQD4tBkhZss3SQ+eEnhuW6T4VtuIKfYIWP+86cMhQbmgxE3jupAp0J6+Zv4l3fdXSDlNTybDp0MQskh7Ak5eNYYxID82h9Ho0EuuJQkQN/xgWQvuzZgkJYa8CBen6AawbUA5q6igzuFVxdq7wNVI9Q4PeL6gCyOmTR/kF86GQtsdzbVMsiBvcbRcZk9GrKuXvLMGxNkeSprhTlgc6jiq5AdCokSFBTH9MrIfLHLC28v2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLEiPhD5ALkvr7wsO4cJSZBPyLqh01f+Muq5qXORYMA=;
 b=Gd4AKjmWAsI3yRfALWqXBKIA6z0tgsbYE2w5pa7LkBbJjs2/7tfOgyZmFjA67tCvQCGCZiebWL4k6D+DY/LAuKYG6v0GOVxlNCqVKxUrPsm8ikGZzCp00wWe4yomjtUn7PKbbEFN5DBWfSvXok7pqxySdR+cv+crPuV9c6YC02/LMQXe6MkKnxAFxksvjmPBHJ+CYGLjfGyU1nXAT2zaidiO7Dyru/igkTuF6qnzydX0NFhgLFDoKlEF2bHMkyluz6VWp4y/XGfTSwwHWCYkKJGr1VD+lxDEv6w4BDV/9UzX+F3a9PnefLMfnYohNt5THVJRAdHofLgm9zO3aicBbA==
Received: from CH5P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::8)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 13:31:13 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::a0) by CH5P223CA0013.outlook.office365.com
 (2603:10b6:610:1f3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 13:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 13:31:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Apr
 2024 06:30:53 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Apr 2024 06:30:48 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
	<sdf@google.com>, <kory.maincent@bootlin.com>,
	<maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
	<przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
	<richardcochran@gmail.com>, <shayagr@amazon.com>, <paul.greenwalt@intel.com>,
	<jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mlxsw@nvidia.com>, <petrm@nvidia.com>,
	<idosch@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v5 02/10] mlxsw: Implement ethtool operation to write to a transceiver module EEPROM
Date: Wed, 24 Apr 2024 16:30:15 +0300
Message-ID: <20240424133023.4150624-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424133023.4150624-1-danieller@nvidia.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: ed73ecea-6557-4b9b-c0b4-08dc6462cf9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wLrMpkRdxN5smXgYwzZCJ94d7up5hUa4ro8FN833sE0z6JLktfZB7dhzYJnK?=
 =?us-ascii?Q?NFBPhZeQw6uThDCldPy4lJrmlNWKc17oTILL8STMm99k31lQSxd6xjEHP3TF?=
 =?us-ascii?Q?iKux61Lc+wbd91mSw25PjXzCJeqFan9/7qZKVj7nG5rDPCeMX9/HvFE1YU9x?=
 =?us-ascii?Q?jm8p5QRiOIOtamG5baGyWUKQAKV6JCW80KhvzF77rSM/f2fJ48gfr9V/jr/N?=
 =?us-ascii?Q?wnbIWKv+VWLeue270c14ynxXS+WhGc/mvELRUProVGrpPq8tZz77Mo6Z82XC?=
 =?us-ascii?Q?bje402CNZiQGwkzCjSXAf4GPbuCASaw+yrh7/n6CgpzQn6hWSM6BaghXsNf7?=
 =?us-ascii?Q?kfhxWL2MOzIBy1FYb+RgZp3k6wAoPBc4lrIdcU7qoxA5CJFcqBKl1L0RcETS?=
 =?us-ascii?Q?W+WaX7bzsBkK5NYAlBWJMrkfCXu1WJADc/k/8cgKmfxw6KbCiKravjFRHwkQ?=
 =?us-ascii?Q?H2zqx/zbQOgATYQBNTbgmddc8fLcDXqkJWeiAJ6RvMRcsi/w73pf5nfpq1i1?=
 =?us-ascii?Q?0jHHkE9drYVpu6yKW7nnNW/HpCrKC5g3afYmkONEkBK7y5k/NZiln7FP8+K0?=
 =?us-ascii?Q?DQK7BMfHr6bACDk6uNjAJo6wPA1FUjoDg1Xssb/JoJN3KHd33+napTAhjlUy?=
 =?us-ascii?Q?huAFwlEBU97wOvpWQFJ5VrF6R0+I4ApU1p8c5HUYoBwGxstaK/Uk65wJgvEV?=
 =?us-ascii?Q?vxacYCNANEBHo4QtmXhoyRt7weD4GcUmX0zKls6am8W/naXPeU+uFvyqWP5W?=
 =?us-ascii?Q?pp4LelBKiTQ34LY0npzPJ96GJe+bPYwk0IaXE8Sq6lfC4XyNbbp6Ur7sqv09?=
 =?us-ascii?Q?eNKbAfgaaIY/lAK8ZWKOeFpreUXoKe+V6WnMfUyt+IqcgPLG119SdVTLk3Xm?=
 =?us-ascii?Q?V3ag5n9T7VV/I/xS2Bo+deeZnMkF+xdX8H4Z9mtpsDCans3N8urerkHe8rjy?=
 =?us-ascii?Q?wO0suKghW2epSij0g7SAcsWeT7EM0d9adqvfgdTN3lE3txNbygAydRM9mxa6?=
 =?us-ascii?Q?XR+92PySwCIlAjgYRsL5jhlRLH8gM1U6Yg3IzGL0EjLQilQ+pkeWBFQWrRBB?=
 =?us-ascii?Q?LuJe/WgMvXHmcclTn61XOkRJVRJ5z75nebLmGMELMKRLL8+MZ66WKceXikNn?=
 =?us-ascii?Q?Yp75yXrxiY4iIMbY1PiRL/JyFXzKlMXKYtpOmUPNT7lZAQ5LEmJXNc/Rxuxq?=
 =?us-ascii?Q?RMdPxq3iBNIA7hlBZKo6xG76PK5vEnJyGtHgg6uSZY1GvbpRQegiV/o2gDQ+?=
 =?us-ascii?Q?nwH3lU/lQuJt09aD2ThQ2j73HqDiOMeaCPtmj4zz4ALwapsfknY7rCmEOJT4?=
 =?us-ascii?Q?MoMmgE52QzIbucTkLajn9tPEoUhNCnHx1Ixh46OP9p6z4EvCqXSzv1J+iCWG?=
 =?us-ascii?Q?nWCCWwY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 13:31:13.0934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed73ecea-6557-4b9b-c0b4-08dc6462cf9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970

From: Ido Schimmel <idosch@nvidia.com>

Implement the ethtool_ops::set_module_eeprom_by_page operation to allow
ethtool to write to a transceiver module EEPROM, in a similar fashion to
the ethtool_ops::get_module_eeprom_by_page operation.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/core_env.c    | 57 +++++++++++++++++++
 .../net/ethernet/mellanox/mlxsw/core_env.h    |  6 ++
 drivers/net/ethernet/mellanox/mlxsw/minimal.c | 15 +++++
 .../mellanox/mlxsw/spectrum_ethtool.c         | 15 +++++
 4 files changed, 93 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.c b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
index 6c06b0592760..294e758f1067 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
@@ -513,6 +513,63 @@ mlxsw_env_get_module_eeprom_by_page(struct mlxsw_core *mlxsw_core,
 }
 EXPORT_SYMBOL(mlxsw_env_get_module_eeprom_by_page);
 
+int
+mlxsw_env_set_module_eeprom_by_page(struct mlxsw_core *mlxsw_core,
+				    u8 slot_index, u8 module,
+				    const struct ethtool_module_eeprom *page,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlxsw_env *mlxsw_env = mlxsw_core_env(mlxsw_core);
+	u32 bytes_written = 0;
+	u16 device_addr;
+	int err;
+
+	if (!mlxsw_env_linecard_is_active(mlxsw_env, slot_index)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot write to EEPROM of a module on an inactive line card");
+		return -EIO;
+	}
+
+	err = mlxsw_env_validate_module_type(mlxsw_core, slot_index, module);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "EEPROM is not equipped on port module type");
+		return err;
+	}
+
+	device_addr = page->offset;
+
+	while (bytes_written < page->length) {
+		char mcia_pl[MLXSW_REG_MCIA_LEN];
+		char eeprom_tmp[128] = {};
+		u8 size;
+
+		size = min_t(u8, page->length - bytes_written,
+			     mlxsw_env->max_eeprom_len);
+
+		mlxsw_reg_mcia_pack(mcia_pl, slot_index, module, page->page,
+				    device_addr + bytes_written, size,
+				    page->i2c_address);
+		mlxsw_reg_mcia_bank_number_set(mcia_pl, page->bank);
+		memcpy(eeprom_tmp, page->data + bytes_written, size);
+		mlxsw_reg_mcia_eeprom_memcpy_to(mcia_pl, eeprom_tmp);
+
+		err = mlxsw_reg_write(mlxsw_core, MLXSW_REG(mcia), mcia_pl);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack, "Failed to access module's EEPROM");
+			return err;
+		}
+
+		err = mlxsw_env_mcia_status_process(mcia_pl, extack);
+		if (err)
+			return err;
+
+		bytes_written += size;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mlxsw_env_set_module_eeprom_by_page);
+
 static int mlxsw_env_module_reset(struct mlxsw_core *mlxsw_core, u8 slot_index,
 				  u8 module)
 {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.h b/drivers/net/ethernet/mellanox/mlxsw/core_env.h
index a197e3ae069c..e4ff17869400 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_env.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.h
@@ -28,6 +28,12 @@ mlxsw_env_get_module_eeprom_by_page(struct mlxsw_core *mlxsw_core,
 				    const struct ethtool_module_eeprom *page,
 				    struct netlink_ext_ack *extack);
 
+int
+mlxsw_env_set_module_eeprom_by_page(struct mlxsw_core *mlxsw_core,
+				    u8 slot_index, u8 module,
+				    const struct ethtool_module_eeprom *page,
+				    struct netlink_ext_ack *extack);
+
 int mlxsw_env_reset_module(struct net_device *netdev,
 			   struct mlxsw_core *mlxsw_core, u8 slot_index,
 			   u8 module, u32 *flags);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/minimal.c b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
index f0ceb196a6ce..448263423e36 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/minimal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
@@ -140,6 +140,20 @@ mlxsw_m_get_module_eeprom_by_page(struct net_device *netdev,
 						   page, extack);
 }
 
+static int
+mlxsw_m_set_module_eeprom_by_page(struct net_device *netdev,
+				  const struct ethtool_module_eeprom *page,
+				  struct netlink_ext_ack *extack)
+{
+	struct mlxsw_m_port *mlxsw_m_port = netdev_priv(netdev);
+	struct mlxsw_core *core = mlxsw_m_port->mlxsw_m->core;
+
+	return mlxsw_env_set_module_eeprom_by_page(core,
+						   mlxsw_m_port->slot_index,
+						   mlxsw_m_port->module,
+						   page, extack);
+}
+
 static int mlxsw_m_reset(struct net_device *netdev, u32 *flags)
 {
 	struct mlxsw_m_port *mlxsw_m_port = netdev_priv(netdev);
@@ -181,6 +195,7 @@ static const struct ethtool_ops mlxsw_m_port_ethtool_ops = {
 	.get_module_info	= mlxsw_m_get_module_info,
 	.get_module_eeprom	= mlxsw_m_get_module_eeprom,
 	.get_module_eeprom_by_page = mlxsw_m_get_module_eeprom_by_page,
+	.set_module_eeprom_by_page = mlxsw_m_set_module_eeprom_by_page,
 	.reset			= mlxsw_m_reset,
 	.get_module_power_mode	= mlxsw_m_get_module_power_mode,
 	.set_module_power_mode	= mlxsw_m_set_module_power_mode,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
index a755b0a901d3..c79da1411d33 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
@@ -1067,6 +1067,20 @@ mlxsw_sp_get_module_eeprom_by_page(struct net_device *dev,
 						   module, page, extack);
 }
 
+static int
+mlxsw_sp_set_module_eeprom_by_page(struct net_device *dev,
+				   const struct ethtool_module_eeprom *page,
+				   struct netlink_ext_ack *extack)
+{
+	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
+	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
+	u8 slot_index = mlxsw_sp_port->mapping.slot_index;
+	u8 module = mlxsw_sp_port->mapping.module;
+
+	return mlxsw_env_set_module_eeprom_by_page(mlxsw_sp->core, slot_index,
+						   module, page, extack);
+}
+
 static int
 mlxsw_sp_get_ts_info(struct net_device *netdev, struct ethtool_ts_info *info)
 {
@@ -1256,6 +1270,7 @@ const struct ethtool_ops mlxsw_sp_port_ethtool_ops = {
 	.get_module_info		= mlxsw_sp_get_module_info,
 	.get_module_eeprom		= mlxsw_sp_get_module_eeprom,
 	.get_module_eeprom_by_page	= mlxsw_sp_get_module_eeprom_by_page,
+	.set_module_eeprom_by_page	= mlxsw_sp_set_module_eeprom_by_page,
 	.get_ts_info			= mlxsw_sp_get_ts_info,
 	.get_eth_phy_stats		= mlxsw_sp_get_eth_phy_stats,
 	.get_eth_mac_stats		= mlxsw_sp_get_eth_mac_stats,
-- 
2.43.0


