Return-Path: <linux-kernel+bounces-18030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55CC825779
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484FA280D81
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4F3173E;
	Fri,  5 Jan 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SOOEox2n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4632E852;
	Fri,  5 Jan 2024 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzXpHe+zGmV0I+m+bS4yNJ9v54/XsisM1JDvsJ8ljRSaGwLT5NjwXVXEhpLbTsjEQTQdGhey6MaUJvqfEcTxfiJJiaH+bCIX323sV1VRPEj9zJUZi1t/7Q2iDGE1t6+ni/miBtTKTt6lVadFJKptF8Hvhq5Ykl7dcbEAbfrdMrAgKICXiZqcunUeXx1QnRvBl5zcyEvkD71TrKAlxoH8P3XisuGnY7YlLIbRXvNJZqwIMaXDp0GJPuChzVJwwUADLRMmISECwSmnaWBk0fxU98DiM9FZQVZmsf7S7l0r03XP9iWPARzZDy8awxfH256aXsAK3drZlhs1k5x5vb0hWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgTwTwAA74oG+QG5oi+SaerPwfOPNgXn6yDbXrpeEzQ=;
 b=Px1cxS6TqUktIYr3NF4fsmO07wqhql0X4Jv419GUYSLkQV+94leONBHFt61M3CjcyzBcBAEPu9keG6Y41NOP+k1TvXnAFr84RhBcW0gHBnv9t/tT0cwm2Z0ep5Y5QHzdoVwJzGy2WSxvTTO2o7lmTQgDtKbmZugIlNBUtP87q5qE0iroBH6jrbhA3ScQDzjO19HqGuUhgq4hL7MEWJ7G4LNGhc0yfWTUfG/IAs4AtSNl++/IK2Ykcf5fBWWLthiFPcg8b/t5ogxWtob5WRrMw7mdNGgGMKKgt3JQjQFERGG6Ltzip56g2L2YMaFr7LjbBFIPtoCo+Xk6hFtzmtvUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgTwTwAA74oG+QG5oi+SaerPwfOPNgXn6yDbXrpeEzQ=;
 b=SOOEox2n7GBoPGzfEQjMmpWjH04eESfdf1l+Fk6DD0O/7bwcbQMSt5sJRzYh3o7DDqmWDNPxOAZwV8Ro5sv1KhwgrQxwDQyZQu+dpCYzWxsGFq1CT7/Efl9kTin3nJhjWdbZXCMYQ5gyXiqabrH7xIahrnjoHf2Eocb0pO8f9HwkzIia0wM822gIotfiS5cGdnxtpB0v0GlKyZZNQtfUWy2UAeVEFDyDOJL8Rl+GOOSsRJmiLnM4GaKClymd6+j+qlEaS8FdfyHiIV76ydsMnzSgGQYiVXNRts/ZBC9nFl222Qf4A9sU5zdVKJWoXFo/OLqi5/V/uvTcO8vejVlnLQ==
Received: from BYAPR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:e0::27)
 by MN2PR12MB4568.namprd12.prod.outlook.com (2603:10b6:208:260::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 16:00:46 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::ce) by BYAPR05CA0086.outlook.office365.com
 (2603:10b6:a03:e0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.9 via Frontend
 Transport; Fri, 5 Jan 2024 16:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 16:00:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 5 Jan 2024
 08:00:18 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 5 Jan 2024
 08:00:18 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Fri, 5 Jan
 2024 08:00:16 -0800
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <f.fainelli@gmail.com>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <tbogendoerfer@suse.de>,
	<horms@kernel.org>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <davthompson@nvidia.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>
Subject: [PATCH net v4] mlxbf_gige: Enable the GigE port in mlxbf_gige_open
Date: Fri, 5 Jan 2024 11:00:14 -0500
Message-ID: <20240105160014.23353-1-asmaa@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|MN2PR12MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9d8fda-6b93-4b08-ee2f-08dc0e077ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HoB5qxYJrMR9Z4nH9ayCT2GhMDtJM7xnTj1xvVWl5B9u9UUpDE9cSM06yesXv/ikcM0Nvl8TwzrW+E1GwAJSTFqDzswOmph4Ccw8rjiDhRblQ8IlbBIdSHCAypq07/Y0Tj6AV4iEj8wEt8XnCIPmH4nszz+OeR+9sPpDdUFVet0AQcyrzI52+v3EIf3VpCOZwXPZLXX5X+H9v2/HtYz3PdmLe3GWYzVEbzISB5CXrqZUtzwNmnV2Fyj+alzwUCJ0A9AscQtv0Dh0VY3jdvbzsrjwTpnLQzu0jWqGInZUSddfzCDp3q8f1J4IQpJJeI2xWvvc79AQ9rnyHfRH4awO42T+P0qCxFr2pBY+4E1vnLhYPn9OUudoBiGe8nXC30SikvamHy/rNw9q4TUmrbvnxwmwsmfx/EyDWUZXK0aHUGHc+yiIZJOS9aWMaLUid+oVScE5eiRhTvwJ2tli8MpQ0YRKwyOIv14iCUaJUiZwBsNDRx5V7A1eLXVuE1bACoBbll3plP+Ca83noxKMSh3tzadx4OGSYg+x9Vnl8ud8Bqj01mGr8XmpmGjjLrk/oH5RDnDO9VbW9XDLJM62VfbhSg2UsIVWrb4PpgqiTWOk85yFbIK4N+9JOC1oT+8G0oYu8FiEaerLLNa0gdRAV6cnZ6qPNhTpfgKpmcg4yluoZtMY170Jf+nzgSVQz9pO44D3QB1xj0e4FwzQuVgjrv0Bql0e9kWU7KJIcVPGjSxJtD1szSvwCF08FQFWQTRmWPE2
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(82310400011)(186009)(451199024)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(2616005)(426003)(26005)(1076003)(336012)(7696005)(478600001)(82740400003)(36756003)(86362001)(7636003)(356005)(2906002)(41300700001)(7416002)(54906003)(36860700001)(47076005)(83380400001)(70586007)(110136005)(316002)(70206006)(5660300002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 16:00:46.5496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9d8fda-6b93-4b08-ee2f-08dc0e077ab1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4568

At the moment, the GigE port is enabled in the mlxbf_gige_probe
function. If the mlxbf_gige_open is not executed, this could cause
pause frames to increase in the case where there is high backgroud
traffic. This results in clogging the port.
So move enabling the OOB port to mlxbf_gige_open.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v3->v4:
- rebase
- Fork this patch from bundle of unrelated bug fixes.
- update the subject format

 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 3385cf1ef9ae..ce50a25c4772 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -130,9 +130,15 @@ static int mlxbf_gige_open(struct net_device *netdev)
 {
 	struct mlxbf_gige *priv = netdev_priv(netdev);
 	struct phy_device *phydev = netdev->phydev;
+	u64 control;
 	u64 int_en;
 	int err;
 
+	/* Perform general init of GigE block */
+	control = readq(priv->base + MLXBF_GIGE_CONTROL);
+	control |= MLXBF_GIGE_CONTROL_PORT_EN;
+	writeq(control, priv->base + MLXBF_GIGE_CONTROL);
+
 	err = mlxbf_gige_request_irqs(priv);
 	if (err)
 		return err;
@@ -365,7 +371,6 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	void __iomem *plu_base;
 	void __iomem *base;
 	int addr, phy_irq;
-	u64 control;
 	int err;
 
 	base = devm_platform_ioremap_resource(pdev, MLXBF_GIGE_RES_MAC);
@@ -380,11 +385,6 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	if (IS_ERR(plu_base))
 		return PTR_ERR(plu_base);
 
-	/* Perform general init of GigE block */
-	control = readq(base + MLXBF_GIGE_CONTROL);
-	control |= MLXBF_GIGE_CONTROL_PORT_EN;
-	writeq(control, base + MLXBF_GIGE_CONTROL);
-
 	netdev = devm_alloc_etherdev(&pdev->dev, sizeof(*priv));
 	if (!netdev)
 		return -ENOMEM;
-- 
2.30.1


