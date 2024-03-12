Return-Path: <linux-kernel+bounces-99876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC28878EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74800281062
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F0E5E07F;
	Tue, 12 Mar 2024 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="TF71l8iN"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2087.outbound.protection.outlook.com [40.107.215.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC27F5DF3B;
	Tue, 12 Mar 2024 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224214; cv=fail; b=e4Sbnz/Jv69F7TY4WgUrpS4ob8WIXwg43F71XQwe65m/QtNrwiQZ+dIh98ay7ny2vibF3aLnlYIC0f8NY29FS9AYk5h38ndTpH4xNKbt00LmEXvyyUI1qt67EZC00Dtg0yRKuCsGLfQlmHV2Y2z1yOBhqslrF38vBwffMi+RkBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224214; c=relaxed/simple;
	bh=zMuUty8gtT0THeEVMCnl/AJrWG+fTxynkHX0KGa15O0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrEJCd5d+8BZu//EOiZUy+lig94jJL54LFl5RiJCh92ikCyrKKM/7AxQmzw9GLash+41jFvLgwf3PaUPM67KH69ZWv8Q9fwDeFgA2BnaUfJRmRsWRCmGKPjpWvINh4jnFz+i4wpMintpjhaYIMUqF4v+7nD+zzVyjXUypaTXG3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=TF71l8iN; arc=fail smtp.client-ip=40.107.215.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVjxfzDqUd1gAbbEieGcTmo9F1JzJRas6w/uLyclsTC8g93RoeR1llg0JmgWVKAeFcnzyCMhfFq1OVqTdLFkfR9ZK2WUz3mb22KvAmIK//0uwaz8OWoJ2sTizPjV/ICVJOQyKAkISUL1I7flGCD9yq/12aIi/Cid25AeVnemPef7KMDFVjFPpUuXrsLHz37F1r0Wjwi72yOy89Bj5ahIRYhmOKUd+97mWbkGwtQF9TvM2pfSgjKtW3pGJ+9c/5L2HYfD68Kj2IzkCg3VT5ncUOwm6aliczRB9HcKiuDsTc+8UNMmR9hQeyCWnPmy1z4yx35H8OeF1r6ymVOs0dsSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G/0w18p91abLzXYuBsYuPzEWdrZURAnJ260VnL/nkc=;
 b=ljn0UiYR4eRzlS0GS2+GEm1jgHwRzteOVf5rA7kJRQh4umNSFdnq3hLniDBHcRJcM5fDlcNro/GZey5whfrj44jZHCfemKe/uQYjvcCyI/vtRXA+egnBuUZUbe8fyUKEXtisfP+Hml9tJmlDJtC5f0UACq94epRZWFZfsatF4f+PPoD26ypVigbGa4aQ36tR4iA1Eq0+NH2ARLU0JM2BVc/d9dyuhaXbaFySDPSCwgR6fTBH5X6k1PNyG4K7WMh8EVFSx7MRveR4Mk5EXY0vtbOUC1cZ6JdETa5iLvye19hlhABWmWv4uHHA314NJl++1BKrPwQi3ffMWzOYMBaJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G/0w18p91abLzXYuBsYuPzEWdrZURAnJ260VnL/nkc=;
 b=TF71l8iN+ob4bwDTIpZabtbMrLgMWR6LBOn+dxOVmx2JSF+v1FG8YAqVmSSdRaH7miaXeJTEPwhgH1ZPvvGouZK5M2a9mnf1FcVxV0FcbKviQzKzrhKNcyKjD0rWJaaxxGCXatZg74LGquHq28kuOP1QdBtt1g22gUdi10Id82e+1UQnZX3ojTSZOvvsEhIKH7DTNugkrOyZwWgfLGBn1i6iILOvjSYQDq5taLPGV05etLGjB/gZCkcUA5o1FtpyIO9V1YvCuCMoqSOCImdJDGe2j9RJmV7n5yDabgN67Kfn96Maxidv25EH85LaxlvR+015SxcX9spwfiO4FV/SIg==
Received: from PS1PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::27) by KL1PR04MB8104.apcprd04.prod.outlook.com
 (2603:1096:820:140::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Tue, 12 Mar
 2024 06:16:49 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::5c) by PS1PR01CA0015.outlook.office365.com
 (2603:1096:300:75::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 06:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 06:16:48
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
Subject: [PATCH v6 14/22] ARM: dts: aspeed: yosemite4: Revise ina233 config for yosemite4 schematic change
Date: Tue, 12 Mar 2024 14:15:46 +0800
Message-Id: <20240312061556.496605-15-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|KL1PR04MB8104:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fb5c01b4-cecd-4e5e-cd55-08dc425c0057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OI7JIyGJe9wiOVUtZ9ILQeCgwRS1rwA+ga9sErNfSw3kCg/qLQxvvoc/LHe4fawCvYOZCbMynuk3yYrAkknk2X04mrxjq+smaMDzRHpUGQMRo4/MTiPxJHTG9uNF5WNI5rUFM+e1c9YD/Uy8uVJe71G0gCcdqWO2WdCKpoTDx01URRY1b1M18sHEOXth5Ob9krOTxjwu9RAKwKNr+CTxsRw4/O3PdZuTriwTeLiZI5KgxnV5zqvJxvX4ooisj0gJ5j29S0UE13CI2nyTyJdkU5uhRhVLbWGcBrfFSBZ1V/AWxrefmt/Alx4uqNKYcJGN61dghKYFEuzXIXFcAKpP43v6OwYFx9FqVV87fmDZtHD+hATtSbJ67llrw0oRLm7tUMIv+TGR9Q1kxbwlierd0V+YO2nhb53hw895cLgSUJcV7Bx6Jd+kOcGv+0AxsICq7UbXcw9R345cCSdwTEZBo4umsS0qO5PMVjDE1h55cIfaoYD33gLJcu8ngYUbMV/gNPNBSu+lvUuhcT1Xc9ZZnhKv0w0dWpUU+DAUAmDvp02KddFFx/HFODWw1Cs9Pr0kV5CSbr6Nq3c0HLi/PT/BLszeW2JUwocuH4F18OMh0JglGXYw9xpHWziJmeRzptnBiJozEFovy93HuXaEctA4i1V6wYcJ30ovGYKI9lPg2I0Gz2aI9bsLL6UJlb8Fgi00XZXIE1/Vvhs7w37NeY7o8fEZNRrfPXSU2ki6SMNhUQ7N2dYMjwD0Tcw6lSD5mD5g
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:16:48.7758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5c01b4-cecd-4e5e-cd55-08dc425c0057
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB8104

Revise ina233 config for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 4cf4b0ca1024..f0e93c74003a 100644
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


