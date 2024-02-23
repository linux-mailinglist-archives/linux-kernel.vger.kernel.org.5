Return-Path: <linux-kernel+bounces-78482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919F38613F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F083B21DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AADD4A3D;
	Fri, 23 Feb 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="fuu7atEB"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91E37C;
	Fri, 23 Feb 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698696; cv=fail; b=ZMudodTfyfDODXEncUsfu+pKhoPEaH5gPVmKAVHxpF8qkPEWw+KHWhhuH354fO1EERTnIyMknpWv0T+hhiJ8LJoTP91Xx5KY3tNng2wGACgVGy9BdUWK5tcBANA5yxpgO9x3BvHqks4ewsKxhVeE5+CFuFB62tRYhQc8cYiH+3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698696; c=relaxed/simple;
	bh=9FJ6NYTh1Bua7HoPJBkfwNzAlVYI2lgIgADbnSk8MOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RVWBQ7hA5VWezYmh899oJO1NsVOLB1hlkuA7uw4pgT6wl2UpIR1nm0PRwPNBR19c2GMAY1iyhG/cGBAfFvyFoyQKH2GQhn9WhXFr2XS76sJwEJ+N0eCQZCbFt6cXl2mr0AAEN+547B5rE/w4hg+/LTcW4TZoSIJPoewDQqoWa/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=fuu7atEB; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mV6LB2lMBsjCsZojKg1Xt1IIlqgDGzDdSUMLH44aEW6K7sfOg88VlHw9MrQ/c1YmPpcitiMnNORY+qKRF3Hi8Suu+DPhU22vB4neMishhu/1T/TY5XkY9tRBUStpyTcO6iPOD+0CDnl0UWBkxJoYKrK+aOQ1M/orbN0b9xjsk6RB73/ONeuCEHqzqFnvZ2IsMr8ZtzonpTEgI83tvYZeYa0h4/pw0n2E2h4iM+FP7UreIP3vNPvmxQ8QhGOC5Hjqbc55dsBSd7OjKxzXpY6Vmo5KtH5R/e+8Y5H1r7JeBXjtdwj4eOJKb7PqeJ4NrK1dCPWhwxSY0SKfkXhIwBUdVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEgCS/z3z5V/g27F6BT86CN1MAPrbQIkZF7T+xmtVgU=;
 b=XthuG+kzyK+RDwoycrHYui0DrHiHRirdxdLlg7XL+OCtXbymh556S5AyHLj+QQfeDvUOMIVs3/tyWvcKytdXav3MrTEbLfuQqDc3E2/vpbNi2Pi/9WulapgqlaXRuDx84J+R9GxLTuKVr7uQ4P588OQ4Z27sHTUAAWybejsv6MQixU98nFI2JHtiugZZRBpE6SVs4R2AikcPjTUdxkNhwI/QCWk+nkIq7FScMhGVJdnkUxovlIgy3FDoljhbCki+iY+XM4MDZbeLc6KXRNbjuZL8m/grFcUccxQbmTTCqR4WIivAoWTMVHVsiSI23awZAHjQriYbHhtnbMaMVUqfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEgCS/z3z5V/g27F6BT86CN1MAPrbQIkZF7T+xmtVgU=;
 b=fuu7atEBmvBw/WIUKFLm2MOtioRWkcxVxGbenO2PV8EHezNm46eqVNUnbiLhnDhykKg24P/q18acH5G4exqO+qgWBn8JcKaao8bbtT3R9mJCEeBGpKNrSMdOyzpMAqVFv3iINCxGbQAOXqk3+N3lyEDB0tepnZhh2Ya8gtVflRQ=
Received: from AS9PR05CA0027.eurprd05.prod.outlook.com (2603:10a6:20b:488::18)
 by DB9PR06MB7452.eurprd06.prod.outlook.com (2603:10a6:10:253::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 14:31:31 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:20b:488:cafe::25) by AS9PR05CA0027.outlook.office365.com
 (2603:10a6:20b:488::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Fri, 23 Feb 2024 14:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 14:31:30 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Fri, 23 Feb 2024 15:31:30 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com,
	m.felsch@pengutronix.de,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH] net: phy: dp83826: disable WOL at init
Date: Fri, 23 Feb 2024 15:31:27 +0100
Message-Id: <20240223143127.1942129-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Feb 2024 14:31:30.0792 (UTC) FILETIME=[FE2C2680:01DA6664]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DB:EE_|DB9PR06MB7452:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 42880a17-7c7e-4e58-601c-08dc347c20cf
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CxFvivukhg81fnfhwowlyKckh4xz2zYJ27ErZ9Nfku7BG0abHyP/g9lHGgw6TWjg+jO4qh+4AVplWg8O64Rwdh7/Dbvm0zxERkrunZtOQ1HZliyf6XzWt4PNdhvU/fVx/pInPvYRsxNjxcaEeq+ncw2GDluJTxHPZYdB1DeBVMAq/qzIq4DZQc+2lonCdmIV0v3LNxilVZHIW4jPJMOINzeJjduakonNJBOeZZAZNd6QyJICRp8TkqJwMy3gBn9h0VhQjI7K3yvJvr93PYGFLS6zTapLLrfGsy2ujAy5lR9ghvWr1kSLU0gFBrpbi0oUVH+zJDhIOyoK1VSLZWSXCxjw293md0EEGkkzQlBlfLMhUexSf/62HxiQ76mxBTfqWceRNARRrtm/LIbE2Bo0txl1ajJall1iYdCSNbXfEcq07Dsxw5g9LeqTOH0sFbgmJJbqFxpLj8D+X/vIqf+GmhNFr6k/DTBLIqdPC3hyVNLi3OYSJzFnh8jWS6EmY11/ZH7ng4HeJ1+Fsi9gbncJBUTAUh+3QrXc3gql92on8U3kf1udpFI8IGuDx/dKVx3OzAsUkeoRef99nNw9E9VGdA+yvNAfKceWztvaMPWipkTULT0YZqKOmUMWXy+2DBbFP8y+zIeHwVHDLEaABl/5XKZiCpJmjnwmGo7ARSTL4dQ=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 14:31:30.9880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42880a17-7c7e-4e58-601c-08dc347c20cf
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7452

Commit d1d77120bc28 ("net: phy: dp83826: support TX data voltage tuning")
introduced a regression in that WOL is not disabled by default for DP83826.
WOL should normally be enabled through ethtool.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 drivers/net/phy/dp83822.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 30f2616ab1c2..ba320dc3df98 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -528,7 +528,7 @@ static int dp83826_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	return 0;
+	return dp8382x_disable_wol(phydev);
 }
 
 static int dp8382x_config_init(struct phy_device *phydev)

base-commit: 33e1d31873f87d119e5120b88cd350efa68ef276
-- 
2.34.1


