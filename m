Return-Path: <linux-kernel+bounces-109578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 224D9881B13
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DBDFB21AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B48D4C79;
	Thu, 21 Mar 2024 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="jX5FSUO3"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2078.outbound.protection.outlook.com [40.107.215.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4D5812D;
	Thu, 21 Mar 2024 02:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987206; cv=fail; b=rkLjJpsIaxsBp9E6nmz6o04Y9LXz+K5/q1WFuhqBa+ydWMIel6sPzY0YZiN/po2YeYqIs9/250uURIIEHP0Yy0ykztL9SO6jr9vsC7c8qj2bOxFeO6Uwb3NTvVqNPPrAJ4nidUWfBXvW8fozCMPwGfvJCn+k30Hekv8GRe8Gh8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987206; c=relaxed/simple;
	bh=y61bLkZDpEuvdqO3XCeYIvtasT0BxLRdPr4cEP3UbTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWttbUMiVSBf36cS2oMUrgX3WYzq1sYDxP4ilnNFCpiTSkGAENmsXCFish2w58+36mNSirPOTU/wVdHHeDoFxpO/oStNIYoGG6VnXnkMy5Om6h0k6Opt9qlMdznIwCVjIGvl/uPXE6bfq8SBSHkCwreN7zhnYl5FZqP35v7SvhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=jX5FSUO3; arc=fail smtp.client-ip=40.107.215.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS7UBQu2/LWXBIyVtauKkgrrv6XDaAn+1gOP3IbQsniX/inP3eO93YOHwSuZsuFKonKP1EpKYo2SWrJNUFXlbKyUuNXT/xQA/GwoEWBaxqXAsWv4Y+N3GWCmy/rHAjVDABdUa/+fNpJSGaPnD/uCGBriENxexAhXPrt5CrqIU6Jjb/nvsb2xZo21G0hYp/N+5nzbUwrDRvr13hGe0Z428LntdW9TBiyQq+HNtRAiFSkHDIhfpp/li4I9v4iQvLn8Yj1z9u1E1SFnrXm4S3LdXdVSVZtm21y5M4aBNNIW8njOtYL9tVrDLb7XaBUpl24dkQCN0IyqXxp3P9rCyAg/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6eURwzLT7RdaeNBJqI62XJk0FsCqAYnzTzJ8lTXipo=;
 b=BiF1u2p5VpYgkOVKY690LeuoWPfP77c4bHd/i6Ep0X8V6t59tPbgDQSAse3M0QcMXfDclBZT/RkNWTNCVjBk0zXwSS7aFogFE2WgROMwxUVbTg1SZ8ZVnmV3mVs4la6jCTgSppR60xhk/q/4n1rl8ZIyH0HObII1Nn20rkCFaAEzqIF9f3daJttopFxavSmwn9Jtczcjm3pr5Ht26XYudbK/FwZz2he93CUG3FrxFqDh5N2Z1ckChxcspJXSoZL/OPZIoj7ZJr0KQUfxec22Btm8iUcH3lnqU5tptvhjj2GHY9bvw2BZnu++dMGeMBPMHDwemI02zkX8hNCWzhljAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6eURwzLT7RdaeNBJqI62XJk0FsCqAYnzTzJ8lTXipo=;
 b=jX5FSUO38LdZ+AOYICmOaVM6xmiHKl8g1e0bwlgMdCupTS0nDWggzoa8KIjPN3v5MQpRZJs4BpsUll1WuvzfszUFsRqucbZ7gIBONsHh5Cvbe/vqqqEvndy/abrGAj1zj6VQs8aitmNUZME2PgdyxzWI3wPfPhUnnpnyKymL2ZFUChjvb9mUCku4ggM+cYl+0T6tWxKtf4/ldBYgcqRziwd/G5i7gqKKAVVPWRjvv9asq+7gmPlifG14BupN+paKZXsdtS4MuPsLGb4AA2Bx9ThDD1De0rKouttd22oeDDvhZXoK6JaADmfR127+9HEvpIl3fm3FT9jLcyx2A6pYYQ==
Received: from PU1PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::31) by JH0PR04MB8066.apcprd04.prod.outlook.com
 (2603:1096:990:9e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Thu, 21 Mar
 2024 02:13:21 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::16) by PU1PR01CA0019.outlook.office365.com
 (2603:1096:803:15::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 21 Mar 2024 02:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:13:21
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 14/22] ARM: dts: aspeed: yosemite4: Revise ina233 config for yosemite4 schematic change
Date: Thu, 21 Mar 2024 10:12:26 +0800
Message-Id: <20240321021236.1823693-15-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240321021236.1823693-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240321021236.1823693-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|JH0PR04MB8066:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7026e2dc-5e24-46f5-21c8-08dc494c7b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v1g3R6ezUa/uChlT8XP848VKIJIm9V0IF+ZxPK+NY0ZcL6IcR1oOWFuAkR5iI88yISBHJSin7tDkMWtLg7qBNV7EkAna2lnyGiQVEiePBcs609qiGseyBfQiFTBG8f/eDU0Hz1GR+F4sK6O/ra3MmmCvEyxMz4KgMyvA5t7wyAk/13d7NJWmlcI/pupsv9VERS99Xpb49/tvpbnION5akLGWEoGAFgQtdqo2dZHJiH51/NfuwyJh14rxUco9Ykr8mlxU6PsO8tHN3QK1+OUsZ0qqFAJg0vCYSxu91prfu7aVfEFVxL6c4yPqUgU5S8K6Fh3zNK5yPHWSeMGuVPEN6HEmFCaIPAx4xVvKUW5tbulIPZ7Hc6EX/M9elbJ3ulof9n2rjglvsFbjoAm8dxQ8cfpMG7FeR57cKPbhRRCn0ZI5/qUTvDBOjH9Q3NSFBqRLouXqzL32WFE42XNVI1dENAWPVnBrILvk3427MUJjDftE1gindFWKjb+ukoTlBi9TpOf35M2EXRWMNOYB1xBaK9nTe5ty6nu7Fpj9XF9f7xFMrvXRtXFvak24ZN5itcMI9WFkqXR9i4KlgvF0lRYLXa7GK+xn/tlJSDYnmYLAqFKcSs+GAUb+baKwr2pGlQhmVP1l1BbcDcPftq+gz+q0XyeNDxaLaHcFooNcFzpEGepzzAMRE9JpSktNWdP05v5U4c4+DUOADhIRFtpEZJNEEltHsbyK9XjLqlWfimClraQQqNtVgnG7f6GKVWajOCGp
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:13:21.1198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7026e2dc-5e24-46f5-21c8-08dc494c7b38
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8066

Revise ina233 config for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 130283ccefc4..011c8d0bba73 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1026,28 +1026,38 @@ adc@37 {
 	};
 
 	power-sensor@40 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x40>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@41 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x41>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@42 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x42>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@43 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x43>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@44 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x44>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	temperature-sensor@4e {
-- 
2.25.1


