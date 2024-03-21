Return-Path: <linux-kernel+bounces-109573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC6A881B09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8DA1F21E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A5C3CF79;
	Thu, 21 Mar 2024 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="VtzXk9bq"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2061.outbound.protection.outlook.com [40.107.255.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371402E85C;
	Thu, 21 Mar 2024 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987194; cv=fail; b=VW/BGyIsgt8EeifDMalojTuo+xVqXp4NjOZ0u9dIvrVwyOduJx2aSJ3EsYs4RrgqnZV8zWL+/NEoSCaqlXRefbseWdb3ieNCImGHqJBhyikxm/V0cEG2fzXGN/98gNIDNCrHBm/LP/AfZfCxAPg27ZtVjIkIl5PJUNUqPmZGmdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987194; c=relaxed/simple;
	bh=BmfZTooCAzIpaNOc3B8xmRqtlUfNqqzTg6e5j9Kgu2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmKT44oeFIN/UoWNtPvLuF36u69VZoqabX/ylsVnvLilr9a4wYicpnCOiUvFkEMr1C0Pp8jIbhnE/RsKffOhNcIAroneW2t+QHKqdI0RuV3mLmOioCRIxDUU9mcxTt50oH8xhseqHSrP4r1u3nob+8dJZ/y1JF5Bex4Y9gjSLcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=VtzXk9bq; arc=fail smtp.client-ip=40.107.255.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpzoLUdxZIIKX9j7rWf9dOXEyq0IhRntBjgAQXOSZgUUKz8gjuR9zcdelEnl8AxKGDIqQ9wrLlfOp+MmkHYVf076So3ATjbB69dWsBu8+f6RRGxBQGyZJ8vr9E0PlC7TRpfJ6+UtKcBsCXOuJJFEovfWmdO8WcDza9c7hJrw2bJNSN0Oij+3N4sAUH8SyE0i99G8lTR9bZUeZwMKrf2YutCEBOyywFB3vmSATSj3pIMQmby2fdMJK6GUfx/qywOYtlkldCDrXYGo4MY2JZBiNYJIOSejK7cReYV0R3fFOFM9WJmlowaEb9yqqZhp3r2SpF8QWE4SCzVAnG7zEU0X7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTP0HPzoNXvVwXTbVz92pkwHvuQp0E8Ck9Pw5Rlz5iE=;
 b=TOEJpHy/spKjybNyg/FnbR6gA8Bg2z8lsSmHiE5W6/GY5caJmQQhYubuQcIcicF4wrulbH32/LwXbWfP6maPn/6JJr2vluRted+DtcfNXPFL5lCWVyLPtdvC+Wjg7TBj1Bg56NCT76fNnjCiFWzHvcUcBISg5se5fRf1KpVQW2IgBoy1s7WH3IZeHCHJzLdZuT0fejSBkz9D7429mXjAJi8qhwhzh883FKWDJaVcfiKI8nBF8gJ6PI/KeLT/4lIlpI45EdRq+YkyhDt6XalR8KXj+X9yQ9qhJYDMT24YmhIjkEBzXBKvPdKBx4BnHEyROLzbB/OowVmJK6IjIGxM2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTP0HPzoNXvVwXTbVz92pkwHvuQp0E8Ck9Pw5Rlz5iE=;
 b=VtzXk9bqTzpFtlNeVIMigJ/ghZdTVuK+ynngk2n6iN++T5lWQyrS9p7V8fKu/5bYCaseQQUprnQe//VF/9AkR/WXRJ0zMQ4wCypTb7wEshfX2QHSoWHoBD57RJs6sLir9Z7QGbPxIp8aMPkETBm8Vc6YFdlVrDaP9/v8tAHsLRWdqfO7OaVDzoUX4pLVwgEZlw3nfNgAJOEX5uiWchg/StRGLqFomj0Ec72yv9vrTyCmUAUjkOGk/8W/kT7rMW2DD7JZ5+aQ+s41PIO6kYJa7JbBIgB40blE0ClqA+rh167LTq2wGKuFk3Z1ycnxsQ/yHcRCGUuuU+pIOa0TKkAnGw==
Received: from PU1PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::17) by KL1PR04MB7681.apcprd04.prod.outlook.com
 (2603:1096:820:11a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 02:13:07 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::97) by PU1PR01CA0005.outlook.office365.com
 (2603:1096:803:15::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Thu, 21 Mar 2024 02:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:13:06
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
Subject: [PATCH v7 09/22] ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
Date: Thu, 21 Mar 2024 10:12:21 +0800
Message-Id: <20240321021236.1823693-10-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|KL1PR04MB7681:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ba435741-5551-4a04-6eab-08dc494c72ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ovum+D4V84vnUEkIJff6UkfoQJ/yWQa2OoGub5yITEG5kr1ucWL+ymvFHwi7knLJUerswzWQ3bI5q/naAXvbE2YZQ9L1eQRNCmp/GI/gHvGxSYs37LXP83q5HNEHu4LZVTwy11ivQa5efGKTbpE1A7lGwuPL4LF7mpLiOk6itKFNT+e1a0F4CFu73HU1Qkl0mbNJd4QNuruvq/vihfPCygYFMFTqgu5szchUsEfXqcTSndXJhiEK5wn1z4iiYmoUFaHn96U2R0XSkEQFxBlYbKvQW3zazMoQxXtjsm7LRYlAoVf5xUUaZdex0sKezjA4lMveC8hePY7/TBtCBWioiNibtqGMnfarymzrglGo6aOvDi6xfWjcSN3WBFGAFwjOG5AoSPOQ/5XV3s7zdGmdIoVD7aeODnkByJNUXeiCCLMni67ihQhVfWye1beOyHDoPIVElb9wPY3WRNpUfVfU+/Ps3e4I0aULOfxwMQS3npythKVM/BRvsl/VOcFe4EcCjoQge1D4n9LUVfXUgCMgGCXfrl5BhFE+zogAZciCc9itXAPPEnT4if6BHvPLr4nQHMQrRqPXvxlC7QgGYxNXghlKvPnmh7yNBUI2gCnkHLq4Ty0U2VkoEUj5tjLYmb4LVltdk/yoC5sIv3Q6mVjBdRw8eS2dDfRPvzHF8nHQ4PlBgcOL0pq07RQkTxYa5J7OQAxbQDBNSjFqlpU/7xhHGFWO9BzD8C2Jw3RrOuMqPZ2mPkW7JnBuC94X0yxMJ9Xo
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:13:06.9791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba435741-5551-4a04-6eab-08dc494c72ca
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7681

Enable interrupt setting for pca9555

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 56 +++++++++++++++++--
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f6527f0dbeb4..d1ee5a6bd7d3 100644
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


