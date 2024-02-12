Return-Path: <linux-kernel+bounces-61158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5562850E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3C71C2122B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB1A79FD;
	Mon, 12 Feb 2024 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="d56+4NYm"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206D7489;
	Mon, 12 Feb 2024 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724017; cv=fail; b=ozEfgQtAVnD1SAsUEIE5cP7/Xn9XaFpzARgV3EKX7sxHqUNab9WNKyvG5SAJudTxxz2rP6IkLT7SPlQTG+erqSXUmg0/BvNQD0Js4t6dRchUKOkSCT1ydKHRrVArmMfwrBZzyxGfg/NbiC8RNBHUW1kv/dOL8fd8gR+lfAkZgeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724017; c=relaxed/simple;
	bh=5wXVzS/XJamkrudF8d5GPL73oahsHPeQ4/VL7d/Qkxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gyWXaXQ943CGJ1fN4TsPZRPE7JBA3NG6s9bR7LpLMTDgUoaxUIF4Nm5poLrS7jB9/tHh5qJjjR3/4lrVLCO2GEkgr3AQKVFNKB67EdbJqPpXbbJzkDrPkx3szVakI3lhJ59VDM9oJw9zmF9hjWS3j00AsAEhcIzo1x2Y1xTaVQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=d56+4NYm; arc=fail smtp.client-ip=40.107.8.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbwmF647JlJMxcNBcsMQeDUZLKfj4miVmPtVRDy2JytFMtwgRezNemcTtTPmQ2v5wEAgcc77IPY+YUJYwHa4ohiyjZ/2me46KYY5e749+SZlK4Eop/d9jIZ/o2HRBCUVNhcvDuZv2/eAhYu4sWE7y0H8HpiZiPGMnyGt9xUXdb0XAXPH5fYljfWPoarAkNq0kqOa/7+B9dZw4NpNVV+uTb5W58AB0YKXg+w68R6xJyZVM5dLEEGrLaCmP3zCB3BgkeibDC+1bbNda3ubzWgFmcPtWDEAIJaCedr4S3FPNioDwHH7VUk6zRata7+ClELIR8N2T7Bs3kwDHjL/O27tTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK7JMUGHKOnZd1g7l/7doSMJhnVWxCWXjsiExT6lZhE=;
 b=H/f7umPqGQzYxeW1OVmQ8mB7t5MEZPiP18sRxu/hAalpAfmn8H5TK9HvGIdjepbt2yS5focVUQBSrkz6uRGE0oWVUGs9c0o1BrajyXskGhe1At/5MfDcY3XZs2jJFUn0v1zOTInAuEFOvam4BMLeLVZsPuNXYVks+A3uvFl/J5UHd+diayVlXZ+3Epv00mowkIx/0lIsUHsiE93JNypI2L8hpdHg4d2r7EZdfMgn/HwOcVyBjoBKFXndilzw5o6H6iZ5N+VxhRS7G7YSnNFiopDc2mql45EcmGeY7YqTGFa1uvzYxADHcJ+I9U0xdyFHCuseCocRkhURw9hYBIK8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK7JMUGHKOnZd1g7l/7doSMJhnVWxCWXjsiExT6lZhE=;
 b=d56+4NYmupo/CB91NjnjmsMv2ePzhUIZzXNod/Lkf08zZl+ZGHIE8PTBCZI+0pcYKd6Rz0AfdmeXgbRcAOOhM+iNjd/5vYuGKDsBDYJy/FaTFm/O0WdZsyIj1QbQMqRIlZfp/n1cK2iyLjQI83FU2O0bWTlqB2tTobsQhnknqdc=
Received: from DB3PR06CA0004.eurprd06.prod.outlook.com (2603:10a6:8:1::17) by
 AS8PR06MB7943.eurprd06.prod.outlook.com (2603:10a6:20b:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Mon, 12 Feb
 2024 07:46:52 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::4f) by DB3PR06CA0004.outlook.office365.com
 (2603:10a6:8:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Mon, 12 Feb 2024 07:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 07:46:51 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 12 Feb 2024 08:46:51 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	afd@ti.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com,
	m.felsch@pengutronix.de,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: net: dp83826: support TX data voltage tuning
Date: Mon, 12 Feb 2024 08:46:48 +0100
Message-Id: <20240212074649.806812-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Feb 2024 07:46:51.0603 (UTC) FILETIME=[A41AAA30:01DA5D87]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|AS8PR06MB7943:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c22681b6-b8df-4ab2-37b0-08dc2b9ec6d7
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q0S4RCWxps1b5C3FBeMr8ObdJ7EJZQ0RfT/RAtRsIVIvXWVKn/iu9Hv9ahmPeOMMNfockgBYeKRvoySUOa350v4E7mfrqPQm0yXwlrZLEr0K7vdN1IAsUHLvnRZAXYToui8WU4qLpiXRLfMeoCwc40QY45TvcdeoCMshe+fuG0eonDnyNtEYSYdPycvfC+h7UEzDWw6r8oj5sFK31AltZO9tOfu3XVTJXXdsXBRBxr3JpRySAdxV6K6krrCSYlk26NtPFdSCJS9u+DYzyTwancgLtkMcYzrpv/0suE7cyaX4OCpaNIOhzBjR4YR41nWxdKvGnEzgYxVCMl9zlppQwFwZdTV+SY7DrxYqNplw8Uw9SHvfq50t1KuAXdc0Rpr/SfTqxCgB6PN4cBtJDluuz11vVNXbPcB/qSGh3V7Is2utdSHxx5966s46SA5VDrS1Du7Ruep74wDHjOI+YDc0VcWaBfpOXPRVhnrlFemEN+Mrtd285FuVku4x5VYkwTfpqru8hAq9J51eQGdqFvXMDpFWMAhAzIbBfau4vFDfL+ThOXatfju0+4G9nyzUCDIJHgH7VvYxsSh5c6WU4kmOnyUp+r8L3IairCKsIY/2BvnUJnBhB8s3PyYTmKg7ieiJuj0dCSTlw1QQ1zi/gExAaw==
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(36756003)(41300700001)(478600001)(6666004)(2616005)(2906002)(54906003)(70586007)(70206006)(5660300002)(336012)(44832011)(107886003)(26005)(1076003)(921011)(82740400003)(86362001)(81166007)(356005)(316002)(8936002)(8676002)(4326008)(450100002);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 07:46:51.9338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c22681b6-b8df-4ab2-37b0-08dc2b9ec6d7
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7943

Add properties ti,cfg-dac-minus-one-bp/ti,cfg-dac-plus-one-bp
to support voltage tuning of logical levels -1/+1 of the MLT-3
encoded TX data.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
Changes in v2:
 - squash the 2 DT bindings patches in one single patch
 - drop redundant "binding" from the DT bindings patch title
 - rename DT properties and define them as percentage
 - add default value for each new DT property

Changes in v3:
 - rename properties to "-bp" and change their admissible values
   accordingly

Changes in v4:
 - add reviewed-by tag
---
 .../devicetree/bindings/net/ti,dp83822.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
index db74474207ed..8f4350be689c 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -62,6 +62,24 @@ properties:
        for the PHY.  The internal delay for the PHY is fixed to 3.5ns relative
        to transmit data.
 
+  ti,cfg-dac-minus-one-bp:
+    description: |
+       DP83826 PHY only.
+       Sets the voltage ratio (with respect to the nominal value)
+       of the logical level -1 for the MLT-3 encoded TX data.
+    enum: [5000, 5625, 6250, 6875, 7500, 8125, 8750, 9375, 10000,
+           10625, 11250, 11875, 12500, 13125, 13750, 14375, 15000]
+    default: 10000
+
+  ti,cfg-dac-plus-one-bp:
+    description: |
+       DP83826 PHY only.
+       Sets the voltage ratio (with respect to the nominal value)
+       of the logical level +1 for the MLT-3 encoded TX data.
+    enum: [5000, 5625, 6250, 6875, 7500, 8125, 8750, 9375, 10000,
+           10625, 11250, 11875, 12500, 13125, 13750, 14375, 15000]
+    default: 10000
+
 required:
   - reg
 

base-commit: 1f719a2f3fa67665578c759ac34fd3d3690c1a20
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1


