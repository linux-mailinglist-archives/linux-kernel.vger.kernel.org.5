Return-Path: <linux-kernel+bounces-99875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788D2878EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4831C2166A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2249036135;
	Tue, 12 Mar 2024 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="rHPNkZ8O"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D816D5B5A6;
	Tue, 12 Mar 2024 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224208; cv=fail; b=rHFQz00+YTt5lV4ZmjgPIztH327o6b+Gf2RpuJY72kSvq5i3s/mg/cRiSAvmHzo19hsyzZwiuiEvzOYhzn6zA6xS3l2UqIC3/VTP5KXC7tPvssYj/UaH36ZwBH7kA8bWXz+GwovfF52OPpXDUaco1jEOyW3LDWn1+IJDY4NR1BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224208; c=relaxed/simple;
	bh=yim56lTD2PWbgOZ7Aj7rerm03DGa+MvWKEtai7Exv9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQy1LdMK+f1Q965poK7TqK+bz9fp7uH4ZNhIWr5CG2haZKdcTJOKSO2ZdCz0IL4o0q6q9IXh74/aHDOwQvIApWmPLvBu38BsPzmfXKdK4o29w8/mJsgqu3ghgSLqOhkHkGxca5tU1xYFDrAFOX/V/xm1ZvzkSpNsj2Q9o7fxMlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=rHPNkZ8O; arc=fail smtp.client-ip=40.107.117.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUeNvSfU2leyDig/9TqrXMXEah2EOg+/NLd7EU0Uf74fleZdRZWdURSLoEFgUg17oojjAgVMVdBPbHAf8Zngy480VzHt3rLW1yf7UUEzBvzPb1R/LvHPSNWyuFF2x4Q12lHBSpoSzoqMmGBN6HvCxGNTe+ASNqATwyt55NQcMWZeS4FJJGe24gJ/yzNvDBRbvwQz1Zhdlq6RvYWhH71YIQHK3KsshpzelnFbsfktNXpL5Q7a57u9+J+qBLzeegOOolVBXL8Mbx6Aj0qmSGRBq6LZHN97tz+eXBhhzEGEulc62KPpH4G3NWCqL+SZvYsBigcp/m7jkCdZ+s/tK9vZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phXviPZoJ6ps795hGiyy1iR8IfUBkORR79WtFgTj63I=;
 b=DNXCmBAS2w3gU+zWVlCqNULoF00IDyJQEszISwfQOOKnJIrh3YbZO4+s36MG+FLJndsLr6TYkUcupIDzr/v2gO1RVHSZ6uekVvjRZCa4aEsMCbHcSi0H2M+FZljzGyC7g7th00sYsheu4OjByV5zOe/BZQosV8Pb3EQDYfn507sGaIey6LpDsRJykBhN0ifgZLognUP/thOngw/s4c9onmg3g+wG/A1gyNG7OrB9bUPXxDisq/s2pMIbhNFt2FlGpiCA5xslZXP2tqwPwhAl695nzqlGICV2qG2zQvXQByGpUXrs3w+/33pNKIASA2tjbVYFu5Ey6vtPhrUxs0i1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phXviPZoJ6ps795hGiyy1iR8IfUBkORR79WtFgTj63I=;
 b=rHPNkZ8O7SGhzinkNVrca89qljHFEDWEjGvIsM8sfK8yhuATQODL7TCFACu0I2eoUc+t4sqC01iLT4sYARDKUDc7S49yke6rvkClmvSTPbqv0TY1QfdBhfPu3ftgUkaxT98m0QcqEpCzVplR1P/G0QLtWo1DFrdfyOHI0irIZuZmUsSr5tW6S4zjkuoHSqoV/FWLQnkafpkTT2tqZ71JUotrL1NpEvwcAmUW6MVIAodL+0+6Z7LLBlbTvimId6weihGlxiy8l+4Zdp0bL38avcq5SWtZD7LHE6cbclH763eT7ywNNwdhLPh5gTS+m1qvDcM7/AZigROTxiXIptbQBQ==
Received: from PS1PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::13) by TYSPR04MB8111.apcprd04.prod.outlook.com
 (2603:1096:405:96::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 06:16:43 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::8f) by PS1PR01CA0001.outlook.office365.com
 (2603:1096:300:75::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 06:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 06:16:43
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
Subject: [PATCH v6 12/22] ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4 schematic change
Date: Tue, 12 Mar 2024 14:15:44 +0800
Message-Id: <20240312061556.496605-13-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|TYSPR04MB8111:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 419b19ae-7d95-4bc8-e019-08dc425bfcff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xYbXx1LpXVeeHgdLNulLQ1U92wp9OOw6dZPIipY1KvGcy6Dn+DU4CaBZsuHMhy0LSGWBOUCFOO8jUJf1K9EcykSUUMUkyQdqq9GWU7VowzbXWWUZDTng79HmRnmVCZnDdMObyhfaiP3yopX8OVdRAQkcBQtiQd75rERAsBuhheNRmMvXqYXC1yHk2DbiqKqqOSVQQBYKBlYyBfsKw6UVbOGH96RDuPik9v75S++WJGpxabPO63rXAQ07yqGeKyURReNAG1KVoH0Vo6QiWmJDlHiW0KCKml3w8cb0KF4DVie8SrqoipJVgI+kSZ21oUvE+9ePEVC6zz/x/6lP1Z/6C+3J8OLABbJ3Pmxt6Szsi5+pwJNBkniE8duvoetz3kyTHWdYuVWsS2DfUv7aQ0BCkdaDBpY/uwhqfYE+3RW6QuEVgvldjGlQ4nKhnhr7Y6SWC0CPFz3BjczKEFSDeJCr4H1Ac3LJWAI9Fehf97TZMTTzHR8Zi1Oig2zIk/PJRbM7W+I4Obg21OWBPaT+v5SkpsNEIzjKo/adgHFv8pwte5l0GW2Kz+IGfXgxyNUoEO9dvIfDL+ndDKtC6wkM9IuHdCnPgv6d3DWpJEi6oYxOxhSiG+TLJHvhqFcf5DLArCxvVJTNRo602fRSGXGClcR0EWAtc8GQXkc6xJh8nhz3NFn13efMhpxfnb+SpAualwZUAPKferJfwlXxVAOFKisocN73qgFbsg8ZbpjMq83KtDASJCPDuwfpjFfRtAkeH5Ya
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:16:43.1664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 419b19ae-7d95-4bc8-e019-08dc425bfcff
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8111

Remove temperature sensor for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f00df378a371..bb4cba8f057e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -921,16 +921,6 @@ temperature-sensor@49 {
 		reg = <0x49>;
 	};
 
-	temperature-sensor@4a {
-		compatible = "ti,tmp75";
-		reg = <0x4a>;
-	};
-
-	temperature-sensor@4b {
-		compatible = "ti,tmp75";
-		reg = <0x4b>;
-	};
-
 	eeprom@54 {
 		compatible = "atmel,24c128";
 		reg = <0x54>;
-- 
2.25.1


