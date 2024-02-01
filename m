Return-Path: <linux-kernel+bounces-48398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D63845B70
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A3F28F6D8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AE562171;
	Thu,  1 Feb 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z0di7A4i"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C7779E5;
	Thu,  1 Feb 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801158; cv=fail; b=GaD+WQGOctDQaMGWJOT77YqN7jJBUdoUvGm0uvN/ojXhp9EEhbddjTpI62y0MSPhqXfz7YAIlPa4r+3Siuub/bT6S4V/Icv13nuFDZpsvmSo4WXXgJhnBDu/0yk6DFw1aqp/Bmr4Mg/G/kRNjPS4RVvdJOjuQQ47A2Dj7X3OXhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801158; c=relaxed/simple;
	bh=KFVywDxvcabGiZLQ2PTyeoIjWiJQ/vPZTqOeGUhPh50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UL7NzMJqDYp4t9PzPP7KfJVvzlU8yzvSTc53LJOiyg2znAqUVc+fWSU5WPNYlm22TN/i4k1B8/QxIXDEKy5GBdSLsBmlFe9PgqkYOKkeG5KK+SvrSRoDnj52GNGNqE9pqOshGE88+2FOgR51E1YwBHu5cJL0BeBzD5LWPypOuWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z0di7A4i; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEiYYCHrzeXWZQiWpF8vX7rPrIH+CsIi1n08J5lY+D7LVwcGn92CDD3qq9LXYQ0eacg3Oe7yZ1RGlaWB8xVSRcAjzvHdr4o8B24FY+0HunOOyrfNjmhk+K6zAlPwTtVPcFnNkXIzaVGX/cSosBoyjBL1xx4oeAn+OJerlZ17hV0G/MSOI+uoP8TuuYwx3kko7JV8Mj4pAdgZcZYAMPqViUZ8U6WUm/Kd/bfRT9uufWT/hYAShmThnGxAtvx96fox2Esv/lgOLrV8lar5cCeZYuX3UR67M7nMe74i2b8egr6fRlhHBwzf1LUT00K0u3F3eg9UrbdCGeUeZC/8mbyrMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgUMaRp6+NciZly0HdAcBIxz99Hk9j26dTXvVT6J0IA=;
 b=kbI86wApB4jja2zzcNDthzsp0ZFLk5dFBWBgd0ozHRfe8xIoaLrs3tIBPjUifQ7gl5/u6mF4tOjiLc/qMmW7A9xNJyFly8v1rNp340EumuRBNZUYSHE3jX6rjKhYUhApMiwdMERDFp/d+2AQOMbdaTjuB9lyctT2yGr1IqOFuMy1XBXclT0Su/Xsk58v4mM6h9wryTfhoFuWytJ550vWOmrlmvm0viAEDziG+981pTp/Q4ki08frEH2sOPDpdYSCU+nGqeyUaISWxyTKrapl3u1iOsGE5ExmsLgxM7b7SChkwhz8eVn91rLrf0Eu1L65Jc70dM9aAofTUXwunb5m4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgUMaRp6+NciZly0HdAcBIxz99Hk9j26dTXvVT6J0IA=;
 b=Z0di7A4iKEOW/asiLfGIUsyW4/kwFxUY/KAOOAIO9scuH1KxhvT+yw08UCpiGMUbCsSyVlBvy5MgKaoERna/MQqU4bS84lAo2HRg0mntUvlf88cVoEl36wZa/5mzB2WivX8Ilns886icg7VyjPDDI9czzXTOWWik2ZFo3xBruTmR4kkEi1bMQMOJQDIzlKVAii4TKhWA0WwfrN7rFMTUqyLF3owi7hvAENB9mn2zeJsBMXag3x9VIhgWSBQCrHQeU8CVtGTw3Afc3lQxqcbTYRokydcSeun/9Ihv6QHY0jlQMb9+fr8xNG/xKa1OYHio4VwUg05ut6avMsxuyOhLSQ==
Received: from BN0PR02CA0052.namprd02.prod.outlook.com (2603:10b6:408:e5::27)
 by CH2PR12MB4972.namprd12.prod.outlook.com (2603:10b6:610:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 15:25:53 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:e5:cafe::f7) by BN0PR02CA0052.outlook.office365.com
 (2603:10b6:408:e5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Thu, 1 Feb 2024 15:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 15:25:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 1 Feb 2024
 07:25:33 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 1 Feb 2024 07:25:27 -0800
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
Subject: [RFC PATCH net-next v2 2/9] mlxsw: Implement ethtool operation to write to a transceiver module EEPROM
Date: Thu, 1 Feb 2024 17:24:54 +0200
Message-ID: <20240201152501.3955887-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201152501.3955887-1-danieller@nvidia.com>
References: <20240201152501.3955887-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|CH2PR12MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 987e8192-7d22-4bab-6442-08dc233a13f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rGv9SEsDaKjY/+F1IJfGFgfqb4qfMQE4gpCoZ62CyKlPvIaEVdWq1q99vjzNllL7CEqRR1M2/nMD+XLJnM/WN003znNXkrmSlmY8v+7CCnaV1Kp9/JOz6N+e3lDqbkbwXR5SVVwe8ZVGE70iF4FKuWFJFyLriJQV7n04P4R89sdZ+eERaKAi/C/w+nL9uSPV2jNOxpyVcrd7bEcO1XMAeLBvh3BoB0oA+nmv340mBb9SnbRBzZpdjR2kAwrJEoxB1e5+9SUeK1iXQY27KRqUKeSdLv0Vpi3hxtPvVs94GroGtp0OCQi3u38QFKHV9ldPpt8PHi+uoptAKZl7E1HBXP386HHqnyejbsKSf4qhw6TvdTeWvEQvnqlR85ddWwUB/nv/qimKp/K7DSLV1CuzXXgJFP53/dvIyLSHRMWeNnfxLwToDUmW1Vr2HEEhO3kRrF6RPoMVJaKJRFjoaaHf161TGkIL/EpWTnjVeast5HonhYmmbTlANIwPp48mnUICS438zpLJ9ocjI37ChpER1KwCRqlMyGfTCStVhNbjYpODV4dWavhkhg0gRvIfIzUSjCfldXj2axhSeu/ww6gm6CGQ+3Oh6JujNPPknYVBFewY0QZcYqD93KGJZs/z/Q9oEGZcBMES/gYdk8de1qFDbiBzziGlN9IPaKR50CLOY0OdZbG7Qab4brMtB6OP1kBRqb8SBZlOfXw6zh5MG/xQ6EFdJmGajG+CuYdv3GEc0Xw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(336012)(16526019)(26005)(2616005)(5660300002)(426003)(107886003)(7416002)(4326008)(1076003)(478600001)(8676002)(8936002)(2906002)(83380400001)(47076005)(70206006)(316002)(6916009)(54906003)(6666004)(70586007)(36860700001)(356005)(7636003)(36756003)(41300700001)(86362001)(40460700003)(40480700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:25:52.7686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 987e8192-7d22-4bab-6442-08dc233a13f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4972

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
index 0f29e9c19411..d4fd7f7d660f 100644
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


