Return-Path: <linux-kernel+bounces-46041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F2E8439A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5233DB2833D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64778287E;
	Wed, 31 Jan 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="NizJmQJ6"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2045.outbound.protection.outlook.com [40.107.215.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6AB82880;
	Wed, 31 Jan 2024 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690543; cv=fail; b=l1ZFIe+Ww14AuXoXT5QEV4UrA+U9fytenpPjM1qyUh9q4cczNjA+gCl6P3GJABJ7/TXgsO2mGnLEdSniVdYdENPZlhS9I3m5Ln6C+Z0TL+YZiTx8h+rda4eLVFwGcf5p+Wliijv8F9IraF/Tw+seYfI0l2zSKcVtBEkpvQL0GDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690543; c=relaxed/simple;
	bh=mTzuMIXAZw/MeWd1tids3L6bELDVF8uPHoNj3Njre6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daE6z/SpW4iyIMOlfMi5wWMIYPUQGbMm6rv3Jm4/aLhFDcUvZdr3Qfq7NJJ8OpC/Xgqg3vW7vybNcWiqFxB+0g1TmuzOFvTUV+/AxXNMEcIeQd01UV/yiAujFYnkKYPD1jZNGyUyu1n+qvJJnRE9qMl5dNq5cvya/3t8HNqSoDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=NizJmQJ6; arc=fail smtp.client-ip=40.107.215.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPpVk0EuQlS9ZlfzrF/eWfOPaL577bLwUc8UDgkZJWHXyF19a6TcBhq6HTGLnpkRmj+aFbUIaEndGI11RcXhBw25JJ/aJFLdWqWAZJ2E6qumdPAufNOpPfBaRpxaUO9Vu1nqJaJkSgG9NHDyvKBpEp8NlLcwvAuSGwza7XhiJSEVPEStR+aQWrmcVN+kDf75syoOVdPKXL5aJpYsJwwbMYZcz1hPbWYpwE809gaQHsPpMggiJ/ZIhtgiivAFXwFmLP3fwcLuXH7wCLK2aJpU6eDlAP/UgkOoQnv7FWLeZP/EX+lYvO7a/WLdfLiQEVRsiZU1yago2xe65Q4+P63wrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLNGMUNrdX1hlgNVJ+IEvc2cz3VhRE8IbJel5r3BG4U=;
 b=Ip7CL6+bvPYscrn/qhzekWyJemDMJXMVPLqk3NnLjny6ZWoOxlsSYQEaX+s10idKAk/unjYIGMdL86iIYfbl/ptGjS2tkx+ORZjuWQKgllCUEIAjTjhlUBb4DUYwBmcgLoh2uCOIEY+M3hYR4b4WgCOhsSJxc6OD46MrqHpIkh2cBr48tugutPXueFuf0BhHE7V+KcCgA8uLVvfYULFmNPEG0AQ56/oY2jW6Sv6lXi3p+tlZIWJvdhvZ5FcLLRiFB2JoEIyr2scUlHkx1n00y08Y4iwoLDFqf53t5IBwVzGwWeOSWRIAGP6TU+cig/SvfZ6A9PiqLur09SS6HqRX3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLNGMUNrdX1hlgNVJ+IEvc2cz3VhRE8IbJel5r3BG4U=;
 b=NizJmQJ6NYw0NTvZ3N7hOl4jVtXnJwazIHEagiXF92rmnEphwaEw7LuF2awm84y+MCj+5uGWwn0C/rtZhIfVMV64cqhJihdObbiRqmWZ5Nu+m3AvkXG7cWeuVq3Sj0prFidVYlixhuRLYjSAz/IxT08QBMSLRuxCPN7WrLpfoitpOWYp8YroQkHHQFX18cU/QgZq4DPhWBFgGbqRk1z/EVLjWHtxVX+e/fLCg/g63MsBRhVowy69yTIcovuy0s/ojQwls8EpSVZSsiOkle52s/UZp/LVzR9RJxW3hdiXEQRtycPATWT54YzWKoKpuOiKwr6r3Q9oIf01Nuz89xqbhg==
Received: from SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7) by
 SEZPR04MB7736.apcprd04.prod.outlook.com (2603:1096:101:221::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Wed, 31 Jan 2024 08:42:16 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::93) by SG2P153CA0020.outlook.office365.com
 (2603:1096:4:c7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8 via Frontend
 Transport; Wed, 31 Jan 2024 08:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:42:13
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
Subject: [PATCH v5 09/21] ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
Date: Wed, 31 Jan 2024 16:41:20 +0800
Message-Id: <20240131084134.328307-10-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|SEZPR04MB7736:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8a405778-0242-44f9-e528-08dc22388685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vHglbQbuimcd1fUtp1eK1JFOUnAIICabbmYV9H+sHsAj0qNVCYSfBWuF/2XrUxGxurPI6kK3YQCtD91iA4bMG09hOISNW1I/WOj8DUQHAKBd6uA13/Kl4PsB/KHDL9P4PQTXHlDkzBXFt2uDbEn1ySScnByK1h366oIa0FF9LtR8FU65vY2IJPgnJMF83vxULB43HA98IZvTMJV/7bEOt8ognUnsKUHFEVKR1zL5jsKQX/pNOLxTg/BHiO+fAOZAF+JbBYIqiuOXYlU9LFGqm7f4mHfSxmolmuvg06oj1pHI0B+EWm37ayZ6xAfSuvj19jaqhDgFnYg34YoWmhS48Pn9I2tKVAksOLQVsSoUs1kpyzA6+KP0YrUy54BSpYtB7ptcdsBKKaopO3bY7jyWVccH0FXkYjEdKVFYXC4ZDUZQAvTd7nqQ04l4r+Zrrr769PHdjVViY9R+/uD6hrEQ92vv2O6of6qmqpDHzGeNIQydRZnNabtC2HVuvpPkrFTg1oi7IxQdtU+lQx29nDjjh+2JFIQe/swccJqhNDQg8Opfu6qmNUMfCMAUadE3iQpooefv5WbapWwSeZ4pVPX7SSCY/Xg0S4MUF3pfqOHuoKp3LLTYjctBMCv3hFCALHksvqcYDFSc17FZ9WAv3V8FBZPCEmsQgnOmMt7VyGVuIE2xXlR0BUqmXjcB2Q4Cf9hnU45y+3nD1j8d0nLWrjTqZA==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(46966006)(26005)(336012)(316002)(956004)(1076003)(83380400001)(41300700001)(6506007)(6486002)(2616005)(478600001)(6666004)(9316004)(6512007)(70586007)(70206006)(110136005)(36736006)(36756003)(7416002)(82740400003)(4326008)(40480700001)(8676002)(36860700001)(356005)(81166007)(8936002)(86362001)(5660300002)(2906002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:42:13.8952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a405778-0242-44f9-e528-08dc22388685
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7736

Enable interrupt setting for pca9555

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
  - v4
    - Revise device node name
  - v1
    - enable interrupt setting for pca9555
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 56 +++++++++++++++++--
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index cbf385e72e57..4b23e467690f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -832,30 +832,78 @@ power-sensor@12 {
 
 	gpio@20 {
 		compatible = "nxp,pca9555";
-		reg = <0x20>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"P48V-OCP-GPIO1","P48V-OCP-GPIO2",
+		"P48V-OCP-GPIO3","FAN-BOARD-0-REVISION-0-R",
+		"FAN-BOARD-0-REVISION-1-R","FAN-BOARD-1-REVISION-0-R",
+		"FAN-BOARD-1-REVISION-1-R","RST-MUX-R-N",
+		"RST-LED-CONTROL-FAN-BOARD-0-N","RST-LED-CONTROL-FAN-BOARD-1-N",
+		"RST-IOEXP-FAN-BOARD-0-N","RST-IOEXP-FAN-BOARD-1-N",
+		"PWRGD-LOAD-SWITCH-FAN-BOARD-0-R","PWRGD-LOAD-SWITCH-FAN-BOARD-1-R",
+		"","";
 	};
 
 	gpio@21 {
 		compatible = "nxp,pca9555";
-		reg = <0x21>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x21>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"HSC-OCP-SLOT-ODD-GPIO1","HSC-OCP-SLOT-ODD-GPIO2",
+		"HSC-OCP-SLOT-ODD-GPIO3","HSC-OCP-SLOT-EVEN-GPIO1",
+		"HSC-OCP-SLOT-EVEN-GPIO2","HSC-OCP-SLOT-EVEN-GPIO3",
+		"ADC-TYPE-0-R","ADC-TYPE-1-R",
+		"MEDUSA-BOARD-REV-0","MEDUSA-BOARD-REV-1",
+		"MEDUSA-BOARD-REV-2","MEDUSA-BOARD-TYPE",
+		"DELTA-MODULE-TYPE","P12V-HSC-TYPE",
+		"","";
 	};
 
 	gpio@22 {
 		compatible = "nxp,pca9555";
-		reg = <0x22>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x22>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"CARD-TYPE-SLOT1","CARD-TYPE-SLOT2",
+		"CARD-TYPE-SLOT3","CARD-TYPE-SLOT4",
+		"CARD-TYPE-SLOT5","CARD-TYPE-SLOT6",
+		"CARD-TYPE-SLOT7","CARD-TYPE-SLOT8",
+		"OC-P48V-HSC-0-N","FLT-P48V-HSC-0-N",
+		"OC-P48V-HSC-1-N","FLT-P48V-HSC-1-N",
+		"EN-P48V-AUX-0","EN-P48V-AUX-1",
+		"PWRGD-P12V-AUX-0","PWRGD-P12V-AUX-1";
 	};
 
 	gpio@23 {
 		compatible = "nxp,pca9555";
-		reg = <0x23>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x23>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"HSC1-ALERT1-R-N","HSC2-ALERT1-R-N",
+		"HSC3-ALERT1-R-N","HSC4-ALERT1-R-N",
+		"HSC5-ALERT1-R-N","HSC6-ALERT1-R-N",
+		"HSC7-ALERT1-R-N","HSC8-ALERT1-R-N",
+		"HSC1-ALERT2-R-N","HSC2-ALERT2-R-N",
+		"HSC3-ALERT2-R-N","HSC4-ALERT2-R-N",
+		"HSC5-ALERT2-R-N","HSC6-ALERT2-R-N",
+		"HSC7-ALERT2-R-N","HSC8-ALERT2-R-N";
 	};
 
 	temperature-sensor@48 {
-- 
2.25.1


