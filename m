Return-Path: <linux-kernel+bounces-109351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFAD8817ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E1D1F21F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BB385951;
	Wed, 20 Mar 2024 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ahd7pGwv"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77C685644;
	Wed, 20 Mar 2024 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963112; cv=fail; b=sN3emWszZp3LURtO+pX69JaUvU/5X+8WVq+uJHp+OTiA7ty88LNG3k/u89HhJQA5/8I9rzzadE884fUfO87IZgEEomA26gmg3pmA2cr/EM998vCvNoe7yJxYw6aNc6LcMP9sOMrN6LV+dl3GOgIdNfArGGrCDp+HlFWU4ckHMOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963112; c=relaxed/simple;
	bh=xWXjlSjhAg9puhse486/gje6nu32JX1/whTUx2GPzLM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N6yFVHvfgIxkeJieZ4hWWfdIOvugQ9tvvbtK0Sxrv06CyoWcexWzK1G817eRo1AGkcFBdGKiIH18ogUr/2VtdXiYShqV477mRMtYOHLHigEdiZUglLWeHLCcjIfPOS9PSGClApqNVzjv5r+yx4cjKisyUsE4OAjalKvL2P1X5ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ahd7pGwv; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElEBcDGRD4vsRZh6pAV8vGgYaphUron60fQQCZ8eozPXSI4D6Wz26cgt32vEcFbUzqd4+vIilm+yHQoB4mQ1DpM5G0Z63jz8xLpi8/q/IAwSd2g1F6SWyKOLjdYsCeMHLWTzdCF+WXND7KpaTO6lWPr764ADmBZ2U66x33KeBOL78u+KGro/l0np9TV2YUabD31dim74mor+dbkqbsnB8mR6+JGW1aCGwTlWxiyGOF9Mib5ZulzEdYnymVaHJykH2jVbTPhSsZUtSePuiDrfkF32TY1l9H+WbI0zrvPCI83Btqy4exgoLyIvaIwjAtO8cmNcRgukZctHaddswhc8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGEetMG4nh7DH2ZZmC/qyyrjf7JXEYuLurapMu+YEB4=;
 b=AmlPmXtfAhlH/+p1FEJfZENgU8GJlhim7glO++Avt0UZX1yLvukg6RX3eKA/mMzFSQBhkiFESn5AAEiVNoBEdj+/jdBx18mn2FO7SRL7T/voUfreh5EQM3C8iRKBMRhOi0MGufsPd9KWY8kwPTdPK/M1JH0nEX1fMvF2i24xmt+CHloY91nju6UrBeeU6qAE8QmEgaLMkvjqKPG7aD0T8imheVnnrVAdMSM76pdyFtzBBfXqQ2QpzNQk/okyMwwl24dJ8gX0Y+hQ6CX9OPSgR3AqfPAfH7iYCGZgxTSakmIZyjqjzTF4DeBr0L5AeZnKpkUR6P6wxFG3BlsuOY6O0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGEetMG4nh7DH2ZZmC/qyyrjf7JXEYuLurapMu+YEB4=;
 b=ahd7pGwvHjhwxyD45MgBO5DIU9Qn7y3xJB/SvnjyWI/L0F9en6W9EVZGabLHjbqceCwSNU2zl/8+mOx4aYGEjhte6sdRaNG2yvcWL5sX/SBO8QKY3PD2n6dqf6W6T2AbdSFrc53Ikr4M7K+hdsdn4cdpUHefPTGyz/UXw1F6VWcGzqy6d986DF33gkHsXi/NHwL9ErffWar4YjGVKNFfWExVn89hPKpHjDX8mCJXAC2NFYrgUFTLlpeLpPQ/SvOWi1eEEZL80C90RdZjzkaVezO8eZyYhPsfEFOxikxUxluvgm+xLwcdIhQlNn7KbEYsx5LJqRDNrxGhjUY09sEmLA==
Received: from BN9PR03CA0635.namprd03.prod.outlook.com (2603:10b6:408:13b::10)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 19:31:47 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:13b:cafe::bc) by BN9PR03CA0635.outlook.office365.com
 (2603:10b6:408:13b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Wed, 20 Mar 2024 19:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 19:31:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Mar
 2024 12:31:23 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 20 Mar
 2024 12:31:23 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Wed, 20
 Mar 2024 12:31:21 -0700
From: David Thompson <davthompson@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <u.kleine-koenig@pengutronix.de>, <leon@kernel.org>
CC: <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH net v1] mlxbf_gige: stop PHY during open() error paths
Date: Wed, 20 Mar 2024 15:31:17 -0400
Message-ID: <20240320193117.3232-1-davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|CH3PR12MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 365b900f-2784-46f7-74e9-08dc491461ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rj+d6/LtqiKZzVqIv0V04/qpaadfY/Fheg7h0o3yWqk6eW+UZAzhuSJqO+GwGnY90FK6Wa1CQXkkLn1skqAcFHdOY9zA+iGq5fwMsmY4hJv7b4p2lA2DbRpLH1nPMSai5Fqauje2L7pL1ygLFlv4xpD6fDnn/4hQ6FOFbJzyAoN77MnXnpKu5jlH0E9IusADO41qFkIuqpMbRMiFY/jQEOlPTv4CXdRim5ZhKYKSVYBj9Rcf2X4+Hrs6A4g8Og5sGPkbeeTRA1Iz4iwmEaxaQJyH0Pr3AFSzNei9HCDO9yLUk4Rmc54rPz8PgS9pEXCsdaYtZOhg5XSJHYXtJt2PBgxOIQCvKSZaQ29ohAQ1OA5tlzE7g/3lnZ0BCcSW+Ag67BH8UeD+TBX5Vl7y8qa/M1L7oyyb+ZuYz90jkq1TbOrPWt5zsToxBAeP7h3t6NxkwIsM5RxMMcDcSFr2Xdzk5WtlfHVwX3MKAEhk/mRYh22lnVh8ZPal4+V/K9niL2Iry1QJC5TT7/oasXIQQOGHqGNrWw89LncOPZOBSRjunaRVZGTLIsO0oT9WDVHJzeX/MfweCSdatNYeIJhjS9n5CGKVRRYcOCUGjnNr1tW4X+RoNV8bFPWMYSUwLCCsAb1rIMueUjLckA+HE8KGpXf4PXlrGtZeiR3/rC1ofmcNVJLK4B6hOpQN/tmTo5dfhx4chfPS9cwfBIIIpcCWUCfHANEw/vtfG2S157plFRulenu3hje65W8hZEtWu0mdyAZf
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 19:31:46.5675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 365b900f-2784-46f7-74e9-08dc491461ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210

The mlxbf_gige_open() routine starts the PHY as part of normal
initialization.  The mlxbf_gige_open() routine must stop the
PHY during its error paths.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 3d09fa54598f..cef0e2d3f1a7 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -157,7 +157,7 @@ static int mlxbf_gige_open(struct net_device *netdev)
 
 	err = mlxbf_gige_tx_init(priv);
 	if (err)
-		goto free_irqs;
+		goto phy_deinit;
 	err = mlxbf_gige_rx_init(priv);
 	if (err)
 		goto tx_deinit;
@@ -185,6 +185,9 @@ static int mlxbf_gige_open(struct net_device *netdev)
 tx_deinit:
 	mlxbf_gige_tx_deinit(priv);
 
+phy_deinit:
+	phy_stop(phydev);
+
 free_irqs:
 	mlxbf_gige_free_irqs(priv);
 	return err;
-- 
2.30.1


