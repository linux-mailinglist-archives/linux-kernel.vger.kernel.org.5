Return-Path: <linux-kernel+bounces-109576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256F3881B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77206B2110A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5C5482F6;
	Thu, 21 Mar 2024 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="A0yIjS2T"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2071.outbound.protection.outlook.com [40.107.255.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B00A4779C;
	Thu, 21 Mar 2024 02:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987200; cv=fail; b=Si1NLtBSh9KaT0UDkmDl88oQGShggL1ykMoNFarp7lc3YOauyH1ID015uleJyFtCPFPPcn6r0eEc6y1Ng0EgJ4NFFswdevqNxx0bVrGV3jNGCWs61+DwRm5LLjJ9Gil+hrO38i3wo9KLgo4vU3rGZNLOvlTGldfscuwFLdrrEd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987200; c=relaxed/simple;
	bh=UKyrKBTL73MgtjJpgXnxDjZmyC6Z7qx2vyXbG1XhYAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8nGGzxCJ1/WvBYe4xxdwECnrKrqtrTiIJc+Yavzv4louBw8hSbgFLCff4SSEUxiYxN1Bgf9ClaCvGRfcgg4/PHdWqA+67psDxZbiySWqOkdJu0/apOaMtx6tVaAG+TF0MQEXvSY/MoBhILHwvPoFYdFtFd6viOrl2Y+aCdf3NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=A0yIjS2T; arc=fail smtp.client-ip=40.107.255.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETRHGQKw6PLhuD+cCI+1OXzei3U3lEEafIAohfc+DTuOFCx8PEH6HmShA8oJr133Pt7oFswcizvJFUwW7S8Dj4wUNxt/DoCDlNglEP+yzhNmNz5iQ0eLd8h36DDRZqJ2TBf9f4QGVG/JIO8ax1azMm5DNvRJlsk0a5EnJ+iUOB5JofqdZui490c64E3pHGoWEkmN13ED60JBI8eV6d08KGbSVZPhtjo31m41K1LrMMOAQDhAi2CgUpN3f6jKXurfoNgWLj3LM9iCEx4Pik70/HGMLGUt48hjYHMZ8itD7ZRP9A4B01rRR2Oa0oBoN4JTl6bina+b2bkSWdorTK+bdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzCsl64ZHVlfgQUamfuum3pvHbcM8f/GHRvXk9OMp/Y=;
 b=FaNRQAnri3YFZt6yzFg9DnhANMeDfWFFgkF0CBAbS+2rA8VRUN+JZYA44OlW7nvJuU7JMPrR1w8W0auLdNAO/YnGnC0DKeb0T3TYi1oYeJM1IKAKc1Mzo2vPmLvZYmFnd7H2BNFVcUgpYcEXR8TU6FNkB8Z1tjEvy7poSHNQj1abt+waQyTUTzgWZPIM17dhD3qM1ety4J7O1UxYP2qQlHhhPUzPNDEgNojBBM9uKGoyshdnXQzwS7GZf9gzjrWHlllMryxiw7Sahups04XSLquHU9aVHSwdl3lKsrt3ilPmiMVPD8nLyZiXMgcLaU7tAJXK+iAixEuQQYE3L4RZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzCsl64ZHVlfgQUamfuum3pvHbcM8f/GHRvXk9OMp/Y=;
 b=A0yIjS2Tm+h6vUI/7/ODqwrrWiV9BodwYl22GWCktiZbKc/DTcTE157OHxLNvJz03QeMBLr5asVz1R0ZuNQnQ9jmmndx83MCBmJrZWDx9nKxinF1k7hFVkNRuAJclBUr2/YtGyyaTO0OFT0f9MGfsMyEOHjMm5hiAjf5ei+6EbzAo72JtkOngcfQpwrNfPLLen7NW9Nqcde2/pAVYmYEy2tvuqNOOF6qjzFVpgGuL1Prg6YxOhrBD8MLbPSO1+0QTX3jnMCED/aLZpnGATyXGWVPtA7y42x6oaZxsfkY8tM1AL2zfaMLzK+NCQPFLhWQf4OsqOimVShZx44SMMB1Qg==
Received: from PU1PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::20) by SEZPR04MB6372.apcprd04.prod.outlook.com
 (2603:1096:101:ca::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 02:13:16 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::30) by PU1PR01CA0008.outlook.office365.com
 (2603:1096:803:15::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Thu, 21 Mar 2024 02:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:13:15
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
Subject: [PATCH v7 12/22] ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4 schematic change
Date: Thu, 21 Mar 2024 10:12:24 +0800
Message-Id: <20240321021236.1823693-13-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|SEZPR04MB6372:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e06fdb8e-8552-44ea-4748-08dc494c77f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LczXgAcnVPflRgEe7ECOrlldKuUyKakMI/WVGzN4xPPZ9m4f/UkD3GdkRX9IjAY3tuH0/qllkBkUfFBxL1bYFTihSZoL250v8Z59FyroGFt3dxnYd1qdxlj6WbdQz1cf4hs/dp7a+aBrA3RipN9MrioccJaBBwMprx+r4zc1paHDGuN7XntSl4EVnheyOZMRZD2f1Yh07h1xXRN/uX6qjap64mnMo5vbypObmxAvdfY8VptdRdd7uY0yK4Pli/RUpNTEdZI07XFq4+FaMXgwRVmG+Dxf+s6nWuPDg5oG3evpI3HbfYLBTtI/CH1SqQcDfwW9nuzLCiYg9ynIUFtUyUg4GUq+ZSztZkjNdQFKdJa6FZtTw9ArDtFkQ/8u9M0cF+mPNdqZIFo8TPonbXWKVEwox/vkmX45d/9LLru9/05zUZ4/awkeY5/2lR7ArvcvZrjawYCiSNXsqMi1g2v/jwkn3XQP0xTueERqTkA+4pXu0LmRxTp9RUWsZXc79MxiYPo1QHtPMlTKgOQLhE+NVosul5vQWsbp4lExG2qTJ7HSF7ryIAlcnpmAiE4SGhf/L2Weg4O420a5Nm027eEUbD9QPYjjudw21LWbDUq+6cUNwkN01wq8b0uY/Pn3oDg6V/8i8XyFaVnAljjPFd9r/DJMsFhBRudekqFWRkDFFIn44+djwC5IP/t7qyGmmiZ0Rky1OD/G/d3L1tRFmbEBJ9Bev5bUv7CnSZsEtH21sYxYf3GDhV2fBHz9i4heY+FZ
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:13:15.6354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e06fdb8e-8552-44ea-4748-08dc494c77f3
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6372

Remove temperature sensor for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b52241b0559c..95901f651f7a 100644
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


