Return-Path: <linux-kernel+bounces-99872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F430878EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54C1280D61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DCD5B1E2;
	Tue, 12 Mar 2024 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="sI5GsCBJ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2051.outbound.protection.outlook.com [40.107.117.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6095A11D;
	Tue, 12 Mar 2024 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224198; cv=fail; b=AiEk9Q2h0mQtFl6JCUoPGF9T50yS82QluTh9346tPZtgmLXoRzTHdSP6ds/j8NiJi+ZGWtkNaZhRStHf1yXWZ7Az8zj6VX30WN0z6iv1uC/PsQ5Ig8hP6OsW6+gAW+oa5gQGhs10UzefJET0EtA3GBCfJkfHp0Q1MbUmmZGGqu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224198; c=relaxed/simple;
	bh=mTzuMIXAZw/MeWd1tids3L6bELDVF8uPHoNj3Njre6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mbw6fs96bhM9ruhg/U8ilncVM5jB9LUVxBpwylosX6xI3fOhuQFU/pG/8XTJZiFq7fVBwdBhkf/6Nws26CfNGrR7mIRNKz7rfmKc0x1GH+R+XcRmTZDcp7ew3CEYjXRGJjIrQtSK2uh8V7iyRTbo+q4S2hXmbK+aEMFQrx7CoWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=sI5GsCBJ; arc=fail smtp.client-ip=40.107.117.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNm47q2D3kMyI9Kr+5bdH7bc5i5Guzb9VtzDho9NjpoRZJqZK/3WYUo5x/9fTYd7t1r7WaUmdHP96R6Xfv09119gsOhJcui8arQejojWe/HNiG+nC3VaP61/8yx9ks30NwA/KS0MKfOUC1/0kETuG38c8UH2QK0mkFHcgRAV+yS1VW2Akp6yZ3KJ6Yyn/slMbR+qLjikr6WqMozZIULbRLSB5whvdTheyeBEeTKmafXAOL7NuElve6zVfRk2QPRjf/ZBDsMxVYYvGt5o6JaEScjntGvdwfWYyXSRbitRalEk0N54nOe45eoYlwIveUb/7em8raPFh97W+Vu1Xf/jRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLNGMUNrdX1hlgNVJ+IEvc2cz3VhRE8IbJel5r3BG4U=;
 b=ObAMw6Bnu+c690hDDgbZDSCfCT9rDsLMIYher4R4zO9tE4BUhvo/ezCGLDSmus7A9Jrnw2EGiz5o+hm+SLnmb6M6J+l6XtmgYzT5LTqzdzUwM4aN3WPgK9O5X9+zrC/Szt8E0yAbO+e+/54QBXieGJG0BaDVlKzqnETimJDXHac6QLJtXdNaHoecgtdp9Ph160rHOlbJjwXXprud2VCY9D0HxdIC8/OTBfMxdmZ5Wu0GwFx0Jd9iv+hhuyaCXnO6aI5Sdz+bQ1io5He2aXOnT0T0eX5/6d7gLCO+/XCTuvrHvw4O1qXCXzgNqnZxI2N12i4oj3iEg50wQ7Go+35p0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLNGMUNrdX1hlgNVJ+IEvc2cz3VhRE8IbJel5r3BG4U=;
 b=sI5GsCBJJFTZfch85CFHSlchNSE0+SCY4FygGr38TkcgfJQSvbf+Lp0ihCpfS/gdZrl9NTJWAhs9pvbyleIDnZ+QapdqI4ru2wfaE7/x4vwBW4iuPXda+UF6Jng1LzE/UnM+N6zQvmhKN0M+Y09Uko9+Dufxv8mk5ZZttKpTNaT09faQovBQbC1l63AgYcnmSk08dju3CM5hmPEnuN6f2gQRWVCBy+C6V670/xJShqYXEeMoyLytmJhrXo8fEYfdvEJq6jgKUun5TkYefLmuqNW0NiBw/pIgPzkrvD3ANBtcI8q1qlByRhJuyDj3q9zEBMQg0Jp9Sj1sLET5GDdMHg==
Received: from PS1PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::23) by SG2PR04MB5916.apcprd04.prod.outlook.com
 (2603:1096:4:1db::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 06:16:34 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::36) by PS1PR01CA0011.outlook.office365.com
 (2603:1096:300:75::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 06:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 06:16:33
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
Subject: [PATCH v6 09/22] ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
Date: Tue, 12 Mar 2024 14:15:41 +0800
Message-Id: <20240312061556.496605-10-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|SG2PR04MB5916:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 21800f14-5142-4600-c198-08dc425bf70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2sRZcovAX3wW0Rl6QuZVuGmJGGCcPw5pWS+d3fKeuiUHqSCsx/kjvC8He0z6QsMJcipmneDChsNIu3YFJFVcXiCKmqPwfTj6EcRgJxX+iqF4BTtJlbqaAHeSbfm3+R5zRVWUaVT0XDSE/7Age6TLSidempffA5UQLbtxyHf20A+QRMMGdwiLmQlPMP26seJ5FsZhCaTheCLbY2mb9i7pl+4oV+WVwq1pTcXSLITxoWgc/tOh7O+6CiNxkKrQYrHDR3WFO707ktX/Cs8PkhsBgAj8JgXxGwbP/7pHx0t/twhl6+Ns/TaPpAj1aBUzyQELGHYjf4tsdlwqfnZ7a+F8aDMT/BFc4wOyK5715IdpX5mY4QOyNXIQ3aIfYWMnCjJQngSe0LVdRgEK2Am/pV31QLbMhQ3lYPiYk9ABXVF5R4aW9nNBxvNxG+fGj61V9i49lCKiu9BJNYIckntDq2KBYgCCCcVzn6EFKwOgExXg/qq5LKluhHCjIUmQiKHZs1u+mUnh8lrBVpj9waFPret+mu6VUBWSoyVFcn8IupGXUm0ZHKiE8JfEdfes+TC027zV5T7qYMNOoOSn4Wnh6Jkoy1MbTPFJPgFElQ+2tvNhUafglo2dw58WY5qpsSu+tjqjAA1ZNGvJP0OQCui/hZff2KJOze2+iqJvCzZ6JiHHkD1PAyxNkg62KayypJUVxVtjcNAfUTZFxllABBNjrawMFk6EpoDq5vraAIhA+fcxBckpV3+zqJiTpcb1+6OBSAZT
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:16:33.1976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21800f14-5142-4600-c198-08dc425bf70e
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5916

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


