Return-Path: <linux-kernel+bounces-46044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6D68439A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586FE1F219B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EB583CC6;
	Wed, 31 Jan 2024 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="rurJ6i9U"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2084.outbound.protection.outlook.com [40.107.117.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD5383CBE;
	Wed, 31 Jan 2024 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690554; cv=fail; b=lj36xkmGLO/4wqe3khaXF+WJTwiOUUQNSPSh+I7AnhPdU0Q/8qDbaUBThpZKh2YX+cXF6+1GmZSuY3cgh+HqoSyMl+Uw4NYHK9cGXYfGIarY/kqtvibjrNMQfAY5Ox4Oi3+zU31FrENsIFz/ekW/HffL6a6dE+XrTh9DnerR4pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690554; c=relaxed/simple;
	bh=yim56lTD2PWbgOZ7Aj7rerm03DGa+MvWKEtai7Exv9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qfix6RsDHJllnLh+S/HqD47vyeMG3/tJ8u42h0cuPJsUnbhobAhGvtbEaHa51X/vabrU8tgrC4pv+6O3oZlNXuIGKb7gS7kA2ytIzvlnWIq8H5xlDVJBF0A2SiCZLL0F5juMcIkJuJxfUS9VzNNel+5RpDYRHzCVgA8+D8+1G6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=rurJ6i9U; arc=fail smtp.client-ip=40.107.117.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnF7D36+KJZN0ce+d6b3TiBA6hLz2mH8v7cuyFu6O51oYE6JNarJArJba8t/MdmWBP3A/I+jo6U53A4u+ukLjRVvhcIM4wUVHX/fCZqmxkYPIVdHjVO/R5Ils5i1/n1plOyOXwdKj3UTnyqcU/Yd3XdBvIDo5yEqsNyBWVfVlRhVOhbesSeiE4rgBwA/IveFaIkNCE64l+RuYNxGN/OYE6DgpRolqAQr/yT/F1PpiIN2JiM7WskBQGxygcSWSJZdM+BfZzKOzvUrTReEm5qoD7ExSiwtGBr+UUNQlWn4MkaH2N/f6KSO2pdZaiWBVcZ7jzBal2MOx0bYWveVVm0uxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phXviPZoJ6ps795hGiyy1iR8IfUBkORR79WtFgTj63I=;
 b=VU0ySr2A4jh5tDPQWDhtnSY/H6danq3n/jaVzrc9zO/1RwI25kqTUZ+AqmIsKZPzhfR9/Z3pTzIWzkBzBsUBHsdAASf6yRoP2Egs1YFJGeOJe313MQpfnDBtG1YxN7J3kJ9u7+wbMwUsGZ2RhF2fn2KdNpi2jUxvSwsJhSRnWnJDbJkVlaau3zzc2nOH4vxySTa6xaoex6gVzcQCbn2tGrYVRLrQBIs3cskxt1+SGRI+fMw5ZS76yuYL9XXV3AyMBt5Xl2k1PMJO9f/9vLwBcduhR/kXExeUAWgpdgbjBfL+y8pzDBIZ70XSJSCMjLUrWzKGw7pd/jHmHjMLZsdZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phXviPZoJ6ps795hGiyy1iR8IfUBkORR79WtFgTj63I=;
 b=rurJ6i9UDyAO9TsuZMZ+MB46wN2fknv1FP5Dm5LYxV2JUmWG77fWHq8XiLKbFs8TQO//bNtxqBesUwTPIXihd9lg1eRBoaCBypQx+988ywBl29JHp1UpLfaO5dWJG9uMNEQlKvzsRlBZ08yXY8nkkGigm2vafxlJ+nRbVATNQiBwTct9xCuA509617ntqIFehZBXPzWTMIwkXuMNf3J4ydZV5e2tT0b9RaLjXz7Y8gBdZuR4Xhcdsmexs0YfuwJeSJIn0oG4fLka5OEkP1kGQjej7CHMo95LUBZV9FA9qICFJqLJDt6OP8LtOn4uMVT/Nxs2YfZxZhwFvUtfkIifUQ==
Received: from SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22) by
 TYSPR04MB8220.apcprd04.prod.outlook.com (2603:1096:405:8e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.23; Wed, 31 Jan 2024 08:42:28 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::af) by SG2P153CA0035.outlook.office365.com
 (2603:1096:4:c7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8 via Frontend
 Transport; Wed, 31 Jan 2024 08:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:42:26
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
Subject: [PATCH v5 12/21] ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4 schematic change
Date: Wed, 31 Jan 2024 16:41:23 +0800
Message-Id: <20240131084134.328307-13-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|TYSPR04MB8220:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ca6ea922-87d5-42c6-1aa0-08dc22388e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kHllbjmNkI+kIryIREgyqdOIaI1AxVEhwd1VcYpohY+LEvf2eCit7t8QdkHQ4u/LrlzPMQ85Mq9KUcGuP8N3MvGoKYcy2UGj7w1SqGJ0zdEFNqLYtqa1lWbp4Tx5bekjOrO3tq9tmI0kOGJs/bgwvCVrlQlFW6he/3+kGxLPWPthSXrDZfc/rcbidu+efy+3nRyjUlHa00Vl+5E7wpOw9cka+8FQG7ROrn4zhfLzKiw9gYjEadsXJKkGkkohy3Fxw+FWbI4+nyhKliOqH3jBZuq+6ilhjxlp06uW9rpEwoTHcnNPZAyA2Am6Zas/otJnREwyM/1ZWMK9wXSJZlBdasEsq+DlnOAv6GCp0fn425objC/8zZSv3uF6rxkfFTfPr2kCceLjceR6AI16x3EIIkDfvN+70oYTEyUfPvzGKjsJTZpZjPNboegxeay5+vFe44Z0zY8Ra466qXr4A8mL2MvYO/8irfakVaU1gyt0ln0ax5n+JkuiEkv2JXb0ixD4zmoFJDrhSDkbBGZrYZv0VqvAT/mtjIqA5AJ8YsLswlM355N1/7T6WIXbbEax1ZjVrJGV++edGwkgkkTAGaNhsyroGY7lf4GVi52/VB+oDNDyURQZwzA1jN/MGUl23IL10+fKeq2oPo1LCm7xFBDW2WKuZwddSOwoolyPhm1cCkjO/l4gtzCNJG/IwU+f6Y41+SgSA3TGnVb6aGt6p7J8VA==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(36840700001)(46966006)(1076003)(2616005)(956004)(6486002)(336012)(9316004)(26005)(6666004)(6512007)(478600001)(6506007)(41300700001)(7416002)(82740400003)(5660300002)(36736006)(36756003)(4326008)(81166007)(356005)(47076005)(40480700001)(8676002)(8936002)(36860700001)(2906002)(86362001)(83380400001)(70206006)(70586007)(110136005)(316002)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:42:26.6766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6ea922-87d5-42c6-1aa0-08dc22388e30
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8220

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


