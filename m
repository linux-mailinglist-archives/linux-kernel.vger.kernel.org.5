Return-Path: <linux-kernel+bounces-59314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F684F541
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF02B24D51
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDED374D3;
	Fri,  9 Feb 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="Vcq9L+WQ"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E571D542;
	Fri,  9 Feb 2024 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482195; cv=fail; b=bhvoZCwaDBsc7p3jbHxaWeZk+JXFwLSitISQoD6E++ZyBFbwcncpj0GseY5F5HLgdT1xSM2h4F/PodLAJo3hC/0jZZG+WcUn9gvTZ08mTgnzEUE5KniHJQA6VtkAALQuUfT/bkkQIuVaFOysIKcuf/erD2gr+82LAwQ4ru/VG94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482195; c=relaxed/simple;
	bh=9+QG2Hq8/ZyBJOD8xpORMBtig0LwbRsK+3CdnRmb51o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lTd1buMBHJfyV1SgQ0jfrW5+Q9umRni0VgIM+qqa9FmeHZkYkJU/x9x0W7U3znoSYib+1ZkxPlLlmTw45Kiy/bFo0+qbzsJlAxDtoSX2N3BZEUP5XSFb/SDXQkpeh9auSZ4+WXRjxE+NHjPfRkzBxsUbBNfG5/4yNpl2R2Ba+e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=Vcq9L+WQ; arc=fail smtp.client-ip=40.107.104.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsYQbJp0VcbcHA9FVvLtQ5bRc/3j4WCHhZXEpXm5urO+8zyru4ZjNQlwiRuOyretsRFkfl1guSBICMnpuMqfqdpyPUaTsqh0VdTRq3X60p5NtpLqEDhNwy/ENkRl76RgMMMrm4fNWOONTuw0uwgKoBbnLzQysYR59nWgse/P9CZEXcqlTfodi0wfa0QqNB19gEcUGQsla3J6LiHEe7pZy8MjZP14u/TswfAIHA7hVaASCjK4eivAtrCgnAQtZO0Ghx5we10adUXMZ9HvZ/Ejn4AoI80wRrw5uO9TK5CYdp8Y3OfDj26Gdzpef2gRHgKuk+zD6J+2jp4Dgqn8reAgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ao5MTLYa4nTppStjNVt9Giw7gLFiIh3FtdDTtV8BtHE=;
 b=BgQiQnLfyDLPKtJ5HseeJBzR+kKrH2j08CfbZ93njIstrn3TDauAwUyk6XMNQYgEmUfwIQctoXuwFBg4kJq2T6OsOKnOq4nq4PMifx2iKlILVQbduZRtcVapjiAiCqIluANHw7nVxkXGRsH0LPv9VdMnAtgi9nip4oOakF37J3cC0m9qTH5wuSB9RzBKVrvkdXI/t1ARAgt7h4/Vt5CgV/NScZxPVIgx65s8GgtEe7kczRxOcp+nrKfBaGOL0MS+eHB1a18ZkkzWRQs5AOFb8ayL+iCbVP7rvtoogAy0+BkO1mMwaFp+mWzaei/eV6Suw4zptleUsgFO9aClPN68Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao5MTLYa4nTppStjNVt9Giw7gLFiIh3FtdDTtV8BtHE=;
 b=Vcq9L+WQwjqAltzbgWwSZqVI17IWoBRWJ99E1yRWNzwuRx7KlX/7KP3PIkEGUKANeNbqHagX6trf67GIUH/866BEBRIHBWb6I2PL0UbVtQW7r981hcxW6K4IiL0O92MC9sKK4cA3HjrOce4kvUba/MJt+9tz1Ycc9C54udxpS0E=
Received: from DUZPR01CA0093.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::21) by DB9PR06MB7194.eurprd06.prod.outlook.com
 (2603:10a6:10:21b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.41; Fri, 9 Feb
 2024 12:36:30 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::b3) by DUZPR01CA0093.outlook.office365.com
 (2603:10a6:10:4bb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.25 via Frontend
 Transport; Fri, 9 Feb 2024 12:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 12:36:30 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Fri, 9 Feb 2024 13:36:29 +0100
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
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH v3 1/2] dt-bindings: net: dp83826: support TX data voltage tuning
Date: Fri,  9 Feb 2024 13:36:27 +0100
Message-Id: <20240209123628.2113971-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Feb 2024 12:36:29.0791 (UTC) FILETIME=[9B1276F0:01DA5B54]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|DB9PR06MB7194:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a4270de3-22f4-4037-5934-08dc296bbdcc
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qEpDD91bQK8ohZ/00ZHU/LroGJJfmZ+RwGTLQGqLeODcBvAdOuazl0o/ogfb0R+SECbLfohzKQak96f3o2BPIrI95AYa4LHAagpPg0XueD+e0J2CTGvAGsJ7KDHUdQrhuQdsGtJrlXQNosfwpFAWbZ6R7DOBOQTEJF87dLdZrHul4tDdBjMHCJ1Qk0cKem6WGkcO/r75noaQPOODTwJQuqyo8MjqZvMwaj3Ayx6d4RTmafDQXVlSprT11D/PZbgFrj3RjadO7WTRexfv+0mOPNzIChMwWqoBSwmz44eAJQ7tXlYPKM3lgfRmtuRcfb9AsMR7v0kTJLsnGKy3j4W6IdWL4UryDGeunlgdIAIeXgamWBOttyPBOG3BWBs5fvQcgR5g8SbbsXRQMjqmJUJnehz4BfuLed5U/gdbmeirlKC3hB4hVP5re4gHId0Xx4wJuzYRndNObmEQq3Fq6bBn2UxscmODku6HOEL//KhlF2Zuhx63hKM37s4WhbNuX8pkoqdo5Jzk6RDDWNniBAjr5AEZ70sxtzE48yedC2WB6as6e1NLsP60mpgCEgBbKWiOf7doj2sJ6rlmB0ODt0tmb5g4+G+KHmHejDldPz+F81cycdAFlFZrllepDjF1nCQqTISKKS+dm9XvP3BHXUuSEw==
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(46966006)(36840700001)(40470700004)(81166007)(86362001)(356005)(2616005)(82740400003)(316002)(478600001)(107886003)(26005)(336012)(70206006)(70586007)(1076003)(36756003)(921011)(8676002)(2906002)(41300700001)(44832011)(8936002)(5660300002)(4326008)(450100002);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 12:36:30.0730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4270de3-22f4-4037-5934-08dc296bbdcc
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7194

Add properties ti,cfg-dac-minus-one-bp/ti,cfg-dac-plus-one-bp
to support voltage tuning of logical levels -1/+1 of the MLT-3
encoded TX data.

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


