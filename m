Return-Path: <linux-kernel+bounces-135365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D72BF89BF8C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20316B228C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171E77C08B;
	Mon,  8 Apr 2024 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f/jOOR6w"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2067B3E5;
	Mon,  8 Apr 2024 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580879; cv=fail; b=E5ofHLHRFlN1sWtDej6K+B4na+0quJLtnuq8quE/Z+JzL7HU0q1c7rA4xzNsbC4GKpeOQKSlSY5XMBtnlhyJjOr/kOYDuc9WPeHcalP+IzASm5ECMEke3gFfonRc50VnFes80Qxql7MhDvLws5r3ByC0LdeAuO8jOEmbgjUbknQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580879; c=relaxed/simple;
	bh=g4KttqU3zxKQlek7DsPqtT/EY+zUBUUs1q8UzggIz4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bM65Ic2ArXDu/Cd7UK2czTdrqA5STA4T3II/DcMY2DOgQrLpqwrWA2baT+b2CVriar0ilDmcoRGKMA3aY0UsyGbFujFC5yePLPTaAk2oHYahngyZBRvV0xS0wh3V6Nbe5/BP6wJJJuUZ7DKnAiiYmlV53i+27Ry11mHSKCec6MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f/jOOR6w; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpjSl2mdQSgJdFqBoyZ7v4g5HuKGJm6hI14HpXTeZJbnD63vYksvMIiLl98IAZi20jWlbdnLPlBdPpN5XQADcOC+zFbqa5EwzWWE7E6lSRbVX0bjWvD1N7zcGuqR77YO11cT1jD0QSIu6r8UgJYwQjXiRslysBQbYJqcYwoW8EhRKru4RbMtkbthXe+z6N/1Lr2+qPCtBttcYKy32l0UW2aK2xsIDdWj2CAHm6LJjqu4YFIMM/PkWIX0WoLl8c0C2+a+hj1kX/BCRNKgpSy6Q/ZZVHsL6ib5Lh9Jx6ZrbYPBGAfm0GDd36enDMyrR6i03GybjkV7hRsVZ8SaIxBoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfRaFeSwThfmWuhjh+xiVcQeHoZzaZigjEK39FRs3qE=;
 b=Mj4DHOeac8TLApfjISLytIDJVt0kyqrnpBM4rTlUcvU3S7Ay/04LgUKlfZy5cuiWpCp7IHaK7yU08C3iETduTKsrTG3K3vJEgs/u9JpPvA+p0oJ7KJ/lS78U/1BJDbf4x6QgtBOojKTwyTiFAArT/TIjIUn3jdChbPIxvBWHN+8KYUAwMk+VSnVxDlgenrA8OWnOM4M8Zai+z0YijoVLJ5vdRnbxRFaQtKedZNEZwsVs7h3SKCV7zZdL621d7u7AHfCxQeHScLMohwQJu3wpytEfXYirt/N+hBjIswCb21s1iFrpy4Z+ZGmtzqq5NDo9h+LlatN+L/xDvY8IysFp3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfRaFeSwThfmWuhjh+xiVcQeHoZzaZigjEK39FRs3qE=;
 b=f/jOOR6wLry2CJ86N6kn4faBpGYaymHEEi+NSnLqVkM5CHs/0vM2NqZ38KdxHNf2Hz+Pg8xFtz322AGpVhhRmtfUuVBD8GqxdtSDbxi+oF46+adL4cQkhxaUtoRUwx6Bcw7DkpjG/uRYQfloUF8pxx1aDZ6DWmc3smq9qz+rALxQU3Z552S45JFJwUIqAicX7/lRqlbrlSHIXgfUE0vF24TbUdtM8fD1ZxMviSmoEZ89XSozFi6YM6/nlXOX+Orl/EQPDJEq7YB8saYeL345AHrDARqTXYYDcIX7MTg9xkhn8EluJ5JGmcg2nt0cZUPV4gEUMrEyiBft1CqnNEQmNg==
Received: from BN9PR03CA0674.namprd03.prod.outlook.com (2603:10b6:408:10e::19)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 12:54:33 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::e0) by BN9PR03CA0674.outlook.office365.com
 (2603:10b6:408:10e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Mon, 8 Apr 2024 12:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 12:54:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Apr 2024
 05:54:14 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 8 Apr 2024 05:54:08 -0700
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
	<idosch@nvidia.com>
Subject: [PATCH net-next 02/10] mlxsw: Implement ethtool operation to write to a transceiver module EEPROM
Date: Mon, 8 Apr 2024 15:53:32 +0300
Message-ID: <20240408125340.2084269-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408125340.2084269-1-danieller@nvidia.com>
References: <20240408125340.2084269-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4584db-5fc2-4930-72b5-08dc57cb09ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EMCiLJotLtwhoIt9xASYl27i3gCbTBwSU4lxaisxQmvPDrOrXT2GSfkycUCNtUXgPpJ0OrfmCZ4vmSzcA7NqldMZ1MP5vFOX3/I4uMImTHvFfGZ2EiW3L2u4o0r3O5dhv0AidNVYL/XLAKGbGSaXMgq3HhQuJpEWB8EjZ3XnOTupomvIqIED9G4vI/hZdAnf31FoDgmnxKM8sST45Av1/N2ws/3wVwtoG4wWqxTRpoZbaAe0msFzTELPK5iEFrJk+emEdbtjzB5/8CUUJ/dmYdK7kb3N3ZG3drCezuQohMGygQv65dxvhS8pz33vNbZLu06weflLRJuzbUucHbg3ClSv8USORJA7CoYGcNm6M400OAa5gjod6OvS5sTxkYJtw1nxpLiXWpX7HbaBHoXXrWky+UZvbcOC7hS/ltZMEI68BtokBxKtNrQaRcV/KCSsVXRMGjO+3zZs1ILZy9f7kA565Qq3x0GtwFOI/AnD6NdqdlmKtDaNLLAG9O9aakAmNW26/ZrrHN4wnIHjNcfdzxkgDiVndR9ClHTuzYoNPGxZSVkzKqVKHygLD8TW+FMtfkeOmLaJBXwsERH/ZOK5c8ha0iLdP0JyNEGFxV9y+GbL8CcWigR1ZaUXZg8yetzxnJ1STMb71VqI+KqW7LNQIf7beAYII8W1plcmwWRO8h9zU3yIbwzRj3WLUNCmYqsRn7FSiheRPlfV/QvWM3rlKGf3syOaoXbZLK1BjpttMsXUd/gdG2Of92XcIWsV2RNJ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:54:33.0928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4584db-5fc2-4930-72b5-08dc57cb09ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601

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
index 53b150b7ae4e..79e4c745ac3b 100644
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


