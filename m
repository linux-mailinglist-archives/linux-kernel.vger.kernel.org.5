Return-Path: <linux-kernel+bounces-99866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ACE878E89
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995DDB2179B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EF63CF79;
	Tue, 12 Mar 2024 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="p7lZoLey"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2060.outbound.protection.outlook.com [40.107.255.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D430453E2B;
	Tue, 12 Mar 2024 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224181; cv=fail; b=IqojGteIW0JNmXViqNGru0xYFffu60az7X6/Y4JfjoOp7vqkfuj3Y2TITTiRAScMrOTSzIjBaLMpq3nBdjJIPy9QmArSo13Slv1hsv0SDyijBfsEudx2Y7dBIJOnlP+KCxhmP1O1eNKtfxsPswvOH5QvEOBOngzPSjud/rre8RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224181; c=relaxed/simple;
	bh=hwgDrijLyjmApinmqTsVpRR9pQF0DfxsCzQgWtpc/qY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJZjEJqt1iCAmZtnBLiRfVvHfkkRtUoLp1lyi9r0xdHBXOFCzOir7JfkMRXVEp8B1JfQbHV1s41001MNcJ2WsCdKkM7Rn3ASYF5pvHwtqBA/2MGEAuC2/MpMcmaI1g3PBZK0H+gNEVZ2Zc44JQ0wFJBzoQ34Ei5798UKBLyLEQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=p7lZoLey; arc=fail smtp.client-ip=40.107.255.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GX6PcF0BuB+7+P/x8g9OGughP9wHp/f9Hkz0rZxli2d3xgfo2nAkuGiwuP+Xb9Qc8JuP3jE1KlV0tZheqkpXpj0Z/bT9s1En9BPoxlzdmd+6vKvMBCrgrrN0S4F+2f9x7TdVCcK2LetOJqmyvQ5R7V7EfyyX4p721jmOeBvxDjwM2z383cT0vjlKDN/Dvv2o2wdkNS4oPS+kQTYSOmNmQK230JSj9sPT1s4ErbiKswPLwbwDpGRDO4L/g3hhwgbYJLmPj0N6YI+rmbBYCNxfgYEbdZSQd3yS+5/GoybwRyLG0JQjctNqCtbed/cTsVzsLr0encV7AJoN6m0dUmfOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXS/IBxr+oV5K2cp3jW9e7qRwk8DHsYfz2fJN3Mk/J8=;
 b=CLdtUYjV1s05fmvicmAHvL51pOXWJU3j8LTCLUfOi1Gk2nZAvQItIUR9E0Dn3noUvx8snYOeHo8o4+9Z6Pw/Lmpioh3yvAHVNDa9Q4SLLlSCqt3/sKy1bjk9cC4C163Dk7ZIi7gLNKTmqV1ECsogq81FCesoqoJWQ93EpW+CuFF25WFWkJVnBhjzH9mO9hTzOSvgNuuG7iR5/l7a+LW+UHPDcEM6rjiYelziwyDYNud/InbMbhIx/ZrJg4OSFBCl1/KqNMs3mVjHrF9D0EtU7jyFI4RiUo35Z3cSkozg6VedmDNGASGelBpIudVg/hDIX9AlI7+LUmcDiRowPbfOnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXS/IBxr+oV5K2cp3jW9e7qRwk8DHsYfz2fJN3Mk/J8=;
 b=p7lZoLeyMY0EkvHy0UNMMdM11g1decax0Ta2LlHQr+r5hW2dPCaOnzuBhtfoiBdwb+AVibweP3YQtdVFu87XmSzSrsL3Mw/1o+lfQHkqwCfhW878MCPLoIXJC3tP53z3RpfPIZis053THs0XNssYG/VTLt/GVixwi5KxGlpfexL82azLUESNsLJe/71/SxPVsI4AiqtkXB3BSj8F9X0DZvBLHvT7PEHFwjYYfkysbvjfs4kd6I0FW9IwUkjj2YjZgLLDZcU0FzWFZqUkWgZFM/51EVOIaXdvp83WItSHs5DVygUN37BujsWlqSUZUTRnZIGnizFQBk95BglOM3g0hw==
Received: from PS1PR03CA0021.apcprd03.prod.outlook.com (2603:1096:803:3d::33)
 by TYSPR04MB7715.apcprd04.prod.outlook.com (2603:1096:405:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Tue, 12 Mar
 2024 06:16:15 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:803:3d:cafe::1a) by PS1PR03CA0021.outlook.office365.com
 (2603:1096:803:3d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17 via Frontend
 Transport; Tue, 12 Mar 2024 06:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 06:16:13
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
Subject: [PATCH v6 03/22] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
Date: Tue, 12 Mar 2024 14:15:35 +0800
Message-Id: <20240312061556.496605-4-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|TYSPR04MB7715:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e235132f-9689-4e92-d2cf-08dc425beb3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AXaq9GWJdcSBEO3L7S+J/6DRQwt1pSXwqoeLZzFNlfDukcEkvFqZLkjgkokLkG804w5HKxZIv0OzuL/aCY57WVs2wB5S9QjZ3c/73SbsOWi7tyH/Ojw7RvPke/iyMyRpSGNiaWE25hI+ZMt9jdKm+vBjp50HOn+oIp47Tqfwtw0rGFdLLU5SWan15+rT9e1dFtDWXGogD1mwKHZBDM9R1wUXZ8tyTWeQVXziOsnyW3xid/+pcuWf3F///3y2M99DNSHjxabKMFp2M1pfyzqdWpqsvnNjwNvNMfnRHgtNW2gu087BQD7EL69QQ89GbEptNnO/OXfvJEZNH6ZoKslKYaKvToxOb1NKvneqrhTHefrYF9JylGmipHj2WIjfIcwLiRq48D7Tca9Tx8cf3TznY6GNB9gpqrm1mI4Ir4rxz3Mg5qcTcKfhLMWeZc4g4PclvynUFFo1ou3ItwZ9NuK3xZf9vGr09/RisZhkWBXew4Tt7BSkXddKCdxx0w7g5cRFJXrS6dhO/2SXsLwjDgRBSPUMbDT91E3DMeut80LydA6OQBc1/7DCswWfaihyMRpOY1qy51DoxkAKU4gG6zssKOGxRt53mu6XMmEUfeZcp/J7duXeAV+869VyK3+ArV+BTVLtOMLNmGDczM4oY+6WMWyNUIA0287BMp4KLrDrXIATPvJSlLX4yi/c4Lrux3thb9WkRBq9J36vbO2HSR8fLzTRM8ssy9crK/CtnI31O3DVGKfeuLhYweV+3Oj+PKiC
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:16:13.3538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e235132f-9689-4e92-d2cf-08dc425beb3a
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7715

enable spi-gpio setting for spi flash

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 6846aab893ad..ea8fd3ec0982 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -53,6 +53,24 @@ iio-hwmon {
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
 				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
+
+	spi_gpio: spi-gpio {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
 };
 
 &uart1 {
-- 
2.25.1


