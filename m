Return-Path: <linux-kernel+bounces-99874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F705878EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC61282F67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A065D725;
	Tue, 12 Mar 2024 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="sfzXDfQE"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2073.outbound.protection.outlook.com [40.107.117.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B21A5CDC9;
	Tue, 12 Mar 2024 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224205; cv=fail; b=W0SkO713Iw3vlBHINx1/oQiI0u3s09U5g8etAg0gZ8RX/epgSQUqpthS40ojQ3rB0aLIYKHLXV5dlRrsoPg+QtSYvsLL6rkkjSiL6PohfB1bE3pcfLDwIpHfUu24yNVubngYxGtXdKHWfCvN6L5MNsHdxbAAne8DwruZ74wot2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224205; c=relaxed/simple;
	bh=2lMj6OPPM0/rhUjxZzelIgBRmQmAE3wzvanFBMW1Agg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+In+v3LQYuTTrcuLEoTPjs/kFx3g2uFNvAJTjvydCTWH84qD0X4x32OsnmmyE9VsiZSYv7dxlr3aeVccsrebk+mfPWa8eoI/QcXlrSsBYQkX6WKZuy2WN98Bd3C1Rca1cjL0xiB13WPznW0Mz/VqmxIwnfLn2OCclkyGrKDYx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=sfzXDfQE; arc=fail smtp.client-ip=40.107.117.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLYo+TZT1QGb9wpJIL01tQnxEOzwE8Qn20kqhK+ux4mZPuD8Wo5t8USHx+ZnMn3fFwhf7LxK+w5n96MJMoZE47qTizQ63bQKDSJ6o4l9VlWfPoDM0EJDGaULS4rIhnbemix4hf6hbf8eg0Ikrkqg+5mEGTb8f0EH27CXNr9fx6/wO158DEIDEPxwNfSGzgTxAkFDZEfrkDYQkRvqV0S16syU8vpEuzkkaT5MqFZX72KVkuiTNX8NsFK8W+7LsVrUjq+1/4do2C63b8ph6NuLUDGMZxdozICuY/KjTEFgsqSv+Vnen9eU/GlIAmaQXAKOmrOGlWoKiXjlXoOJWpe/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83qzPgFTx360SjxOmqFNjD3Rm3s/Cy16s152N2P3fZA=;
 b=P2J14/PV/GYNTfph9ANgHJBgEzkTzA7MRfi5QRjJQ49/Wh95yosRkswgr2wrNL0jSq0vWow32toYEhIKEI2KFnZtzVkG3l5E2y46G0fCKpI3ERJwKBjSkWtiq+nZChunEJFRMchCLa5VCP//zYhk8zbe0cvHiijggZ+xzMY1pI2fuSRU1eTW3ht5SJeEgQ/NgV7HPkFARLgs+qaNnSZlMeg8rZvA9QyCyZCNO5denSNy4sm6fgckFqMTxTFjhf54lalquNoBX1einSwD49Sgdhw9a1MrYV9Q45Tx44hIcqHJOD/VlgeCyrl6IsXnm3YSFH8lXHcAuvUdEi1MdZlXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83qzPgFTx360SjxOmqFNjD3Rm3s/Cy16s152N2P3fZA=;
 b=sfzXDfQE4o+/JEVdqgiah0WMM1NIsgiSnAOcMfnWyEvZQpPE7MUqdLrLciBoGrRmnH0UX0xspsj8bglANWIZ/9E3lqN9qGIODhSkib+35Uet1JombVjcZbXmOejsLYPl6kL9zKpMSckdHdRKGgV4TKcj+WpdBm+4Yj/45zyP5YMFTEigkfPcXNfNPcliWe7kn3rLQhylzfbDnlphnRL/sexq5edeMU/3YkfPnQxnCGUtGKjuSw8lmM8ajJjDiMx+jovojPCbZqKkdjmZBx77yaqYk8ZTUejPyJ4I3yIpyVFNt0lrJiATa5fpTirRT8jS3JIfhNsMtTefY+czNBP7AQ==
Received: from PS1PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::26) by SG2PR04MB5687.apcprd04.prod.outlook.com
 (2603:1096:4:1c7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 06:16:40 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::b6) by PS1PR01CA0014.outlook.office365.com
 (2603:1096:300:75::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 06:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 06:16:39
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
Subject: [PATCH v6 11/22] ARM: dts: aspeed: yosemite4: Add eeprom for yosemite4 use
Date: Tue, 12 Mar 2024 14:15:43 +0800
Message-Id: <20240312061556.496605-12-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|SG2PR04MB5687:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 58d503f5-1c45-4aaf-0a98-08dc425bfb04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	snBOFQ2rfDeUKR4xNBwtRB9qAHnvzdE1zMMDOPxYivhxAUehzaXaR4EGwAIHWL4QN1/ebSKRuHjxiDyXAi5EgKIkFapUamoOdAXWznqvcgm4FRiiM4KYWNEeBASUp1IvHAVEGuLENHSjULAVNebRfYzsKWA31YM3GmWXgjow0ea04/LVo4X0wbeN3H9VRsR5YNEdKprJo2oww99x583JHTywZd0xHOly8QhrweY4yNowWH4SMDI+MjEvf5AKiBasdAcCGhiQ6qBb6EtT2X1BPkTXCTze+NjQ0H6T9RggUI1vKMe9MMyPnzJIjI6S0y3SNbwjmx12KcYHHZU49fT4TEpQq6LOo6jGWhtL0dPr48oJiuFSOkEnbz5b9iXqLx8C1fTxXCAR3z8Vq87aW2cjgplJXzDXqfYPVvtEZCHxepONfFnVAZ3GE5xtUCSbKWRsYx5DrUu7twBNBCAY0Yug+kIa1R4t8ZsZz9PR4iP/6ZmEQdmPwhhpq5t2ZrlFELa72ePOFtEIeD1fHjqfLiHGdgSzJmsmvU10yvCHEYYSv01V5sKGZgMcCOcf/ktWxEh6qAvd/Tn4CB9+dv26mRYmgrL8MP4ZsjbgldTYpfz/ZUgEt+pvIKi/WZIP/72dcN5xtj8823cd0qkP1oenKc3p6vEMjEfAE+BieX2Uia4aMOvac7UxljscrcXjebc8mkq6c+iWmpYWFWpvloVdfwc1mRK2+NFq1xkiK5rJRSq+DtrotQyLRwB4M2kyIBTHfmED
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(7416005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:16:39.8383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d503f5-1c45-4aaf-0a98-08dc425bfb04
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5687

Add eeprom for yosemite4 use

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index e8d7eb7ff568..f00df378a371 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -932,7 +932,7 @@ temperature-sensor@4b {
 	};
 
 	eeprom@54 {
-		compatible = "atmel,24c256";
+		compatible = "atmel,24c128";
 		reg = <0x54>;
 	};
 
@@ -971,6 +971,11 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
+
 	rtc@6f {
 		compatible = "nuvoton,nct3018y";
 		reg = <0x6f>;
-- 
2.25.1


