Return-Path: <linux-kernel+bounces-81894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FE6867BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37051C2A918
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BBA12C7F8;
	Mon, 26 Feb 2024 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="KCw/pjAf"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2067.outbound.protection.outlook.com [40.107.249.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9EA12C54B;
	Mon, 26 Feb 2024 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964628; cv=fail; b=MHy/DFujG0INefgy1E5bAmMoRk+rRqYH/LgQBeKuJG6e/K/9ICh8SuBxnXeDgerFtnipkRmha4Q9CnIkFvC2ycLvKo6mdC7NtThSfmJ/v2IowCUmRhcYfT1fy9Q36E504evFjhAs5RQMlyvIMnOu8J3s03fvtGeHS99JG1x1+t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964628; c=relaxed/simple;
	bh=EUsaDE3yL68RnitcmKg7uVqIAvVYWX8bcmUQ9aIDw3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ttuvFi/5iLopl1GlyOsUfmJ7JX4UM2KGqFkN3aJG8tE42LSgZvJU7gCGELi1vl3uUS5EFxgVU/CtXovw3jQYgfuOs+qMA87CjshU42mcziffwM7fhklLFFDbnTA/MTty8ouJq+RaZBkVZK4P4jFjjR16k7Xty6pvvc0pGqdTNAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=KCw/pjAf; arc=fail smtp.client-ip=40.107.249.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIoSWfeQIUvAQY+ofI7TpLT12wk4l8nG1WWc/MMhA5i6RCDvZ6A7ugjzxYJJV4oe8xdCvv6RtyZsVN62rqn0qPKhd/5DNEAvnEq40nJHu7qU39r8EvEUqRONuA0efdJx/QvV6PbpfYhTVxtgvdFMl9R5KeJAAwtZs8Yne11T61qNDTeVHeDwVtIg5GrMVppYSeLGdWRcquCOg8h1drabLLGyJo/pBnrJESHx8ieeLQdfQjCa+v11oiVNwzb2szm+uQYYuS+OEO3uD0DGIK+g/8g5NIetqrAkolKJDNngXvLa0X8SU13nukpY7JL+gK+A/P79juX9OOwXfu/BXn3ZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2PUlhb7aluY9PS1b2gzvNJikv/DQK9mmeHonP8mdI4=;
 b=HnEGmqt1vbLMRw6Sl1X2DbhI0m8jKwPOiaJnrMc2N/vyoHY99MDPjNGPDwgyX2UjOE4OcqrL1AITjVGZJuubReak6rI5Mmu/sB0kEDWATMkURkDBO3jtub/3odvC9fmL9WzuAbBvN10khVx45FBlALWRN93VPwxH3RFaA5FMlxK3QScanRSntMv0N1yfZYvOf8Aw1SCSCXpUdLYcJ40JdDZVa3ZfwhB3TeOVZJGrZOFOMCcaxtiPvIY1f7iKBqAwTskttFvbwYvCM4i0XTntRpIMwyWCwK1KFD0AGh0kBsTPhEyx4SGfSi0fVhYhWOJs5D0Syx4vixF0LpK+sOWXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2PUlhb7aluY9PS1b2gzvNJikv/DQK9mmeHonP8mdI4=;
 b=KCw/pjAfAiizGqPARePMFeH+xBC0eNPrxE7DryGCdVu3z5oevKvXki3EKKYuNTYpldt3mzFrP1wk2n7u4h4Pe0k15iKCzfyGtr6aQm3qbZGD3H/nBD4g/fWOOt2+lYpVRngRcJ77UI9hY7pVjhSLzAPQJvsgdpF4GGE9zDtqUUU=
Received: from DBBPR09CA0016.eurprd09.prod.outlook.com (2603:10a6:10:c0::28)
 by DBAPR06MB6806.eurprd06.prod.outlook.com (2603:10a6:10:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Mon, 26 Feb
 2024 16:23:42 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:c0:cafe::e1) by DBBPR09CA0016.outlook.office365.com
 (2603:10a6:10:c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 16:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.45) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 16:23:41 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 26 Feb 2024 17:23:41 +0100
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
Subject: [PATCH net-next v2] net: phy: dp83826: disable WOL at init
Date: Mon, 26 Feb 2024 17:23:39 +0100
Message-Id: <20240226162339.696461-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 26 Feb 2024 16:23:41.0603 (UTC) FILETIME=[2949A730:01DA68D0]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|DBAPR06MB6806:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ce34d50a-2112-48a2-7a7d-08dc36e74c10
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	//713sEnSpTDhuySVRPpDuAs2YNTzRQCA1HyzzpHu8q/mmwGjh5Syu+p88L3TS3whQ04/g+f4ce1rpr/k8Dy/7KjGl1e78/u+gzNKQtmoH/T2W+AFbtE6O9u5V0TXdLnKmVAERn+PxAnbKxJdT3EXoWUetM6d8GMj7iUQ8A5IsgIK8n+Vtxs+hWVis8toyRWJ7/ohVWlZwwy36EE8VTGgaXRbenfotGaXsnGL3M4auu9NR9hCYAGNZQtGLnqlPYmsPsFuajCeKYWX7sFVSMrI8jC9mgXDRXOCbXiyfxtz7Rr+6qu/Tm5yihHFkRzT5vDCLfY78awlyJw4Ej2RIcH0e9V//2LCAiTET5dHD/M+oNMb9fT5eQNhRhOplTzU4k4IQYTKcChcmH+FeC7JH+pIx2dV/xD/KNFJ9izpfzb/2Ja7TqTdKukmEvP+Wq9+RNU0jXBktfOTuZLPr3mKQw9eEccM8lvhNKq4aXW2Y5ZxZDDi50SkjorsPDXrVK/6jCVoVk9uWJOAANSEIBSywLcZkULOMCJ0euMdU+1Q7u+O489MGfwFIxxFkLhDvkTLI/cdIaufKGWiOaCM7M8xZTUMIMmxnB+5UeNjGNDTPba3nxrKxj4eFG790KebBeOGgOO0Lrq5ofzz8KD1yA76U42QkBQ3oUvwjBNJtdZ7MbYIUh30luCF1kPZrK6t4umabrfKcWpLFyXbiDXfeA/Bab1ntqqTtUfQWuc6onCJ1Dct4T3AhZlasQpPjI/ffEKO3WO
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:23:41.9855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce34d50a-2112-48a2-7a7d-08dc36e74c10
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6806

Commit d1d77120bc28 ("net: phy: dp83826: support TX data voltage tuning")
introduced a regression in that WOL is not disabled by default for DP83826.
WOL should normally be enabled through ethtool.

Fixes: d1d77120bc28 ("net: phy: dp83826: support TX data voltage tuning")
Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
Changes in v2:
 - add Fixes tag to commit message
 - update subject prefix to [PATCH net-next]
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
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1


