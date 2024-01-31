Return-Path: <linux-kernel+bounces-46043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 988EE8439A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDFA1C26FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88A164CE1;
	Wed, 31 Jan 2024 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="SQStcmzb"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2064.outbound.protection.outlook.com [40.107.255.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C3B8289A;
	Wed, 31 Jan 2024 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690548; cv=fail; b=eqgYGQJy/Yjfv5twG8wVI92Y6HMBrhkVHYTaMMdGTl0gmtrZLw55ZvYx3g54laG7I+I/BObjNdWuzkHmaN+DH+E9dFzOdbN9xRgkSKvBwHU5hzfYyiT9q8cb8e6cL6XQytq7CXWWYgXrtkzgOZf7P5x7/MSaKfpASJfjTM5GbDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690548; c=relaxed/simple;
	bh=2lMj6OPPM0/rhUjxZzelIgBRmQmAE3wzvanFBMW1Agg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmgNHNFD9AaMxpMKCnCErv1q7VPsQMBTQioyLiKheHNCFqP44Mf8lnbd8uMFCHxmMnpTUQLOjxwOcAIIFw2TullqOX/DyRM8ZU0UdpUJ1R0wcxaV6caXUz4yYmfZ6A27xDG7x0x0ESbkoTUyzLiTVH6/eHtdfDc7hfkAll9a2F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=SQStcmzb; arc=fail smtp.client-ip=40.107.255.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1euOJqk8r3xtCF4D2tPpkc4+SGcDLQIEAokyujqiEgvdvvTYgG2ifVJCObAQ2jdsYWMXkTVvfGZvNhurnoas8Z/scgiVcY2fnldmmi0egjU+WUwgG+lBt7HOkK/9BFFYo0MpJYlhlbM41r0ZPzYVi/FVcmVnKWpr+BqCph0Tg30iJYvdvoLbYTOtkqnhkciYhR56X8V+yVxDp7ihUFkcpWI8IPzRV7ifFRaRTBX7Lu10sNE9CqDfvqyIG6UrPAybGO5U8T2FSYDqrbI5jsYfyx9azBR0HKT8BJv2EePKqbRuHAjXZNI4T+RVlnBjJYEiGnGePiNB56oHOAcj2RkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83qzPgFTx360SjxOmqFNjD3Rm3s/Cy16s152N2P3fZA=;
 b=cCX9bMf4AHkX3bjCp/ZHWgvBdfe7O6iF258kzIHj35xskOnpO8nUOrmO9OJZCeifC0SrKIsw5uwgoELOohzw1NlJZ9Y02rk4vVkC5AnAmgu4/x+kEemO0y5pyB3RIUipdplPBI+4n1d8cypxl+WpQgjOzebMP60lh3+v/EG+fKxIS5BynKn3GVFX0ossy6ovhxR8DXkymSZh5PAisIXegoaUBvEWXx3sUdcSiVB/Xlhmjle3Uw5LdtHwKbRB5PirBDqxCkw4taFCzVVyuoKqCc/8lhjreZfnybowRogqoQIncNlI69Shzn8Z8yZhK/b8yc+x8ScuoTbAkn28V1q/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83qzPgFTx360SjxOmqFNjD3Rm3s/Cy16s152N2P3fZA=;
 b=SQStcmzbdjBSW2jaX9VaudvuYxLh7V2UxnVzZuJPhHf7RniKlgeO+KQUORY919CFnZcPQMLrl8mEKOzOWu3AxY9ct9otdDRWzynVYDlsS/Mtuco+jTVouOv1kV381WVkOi+J/LPIyv33l/mM6eSWqv4pCL/hM9fZF/Ce87SQ0OOjAO69ziRSbtbDcIAwOyKYCbOuoogK3EQqr5zCtOJhwciKlsi1HupCEXa1UJTRnlobxXhGTyIV5lXC54N5/3knT7yWh8Vm1htAvEoKb8xOtZ0vzAipVWl9BJRgqDqHTmH6DdbImyA42oMTjK8zRM7YAMo1+XZ0FxZEHXC7QMMOCA==
Received: from SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22) by
 SEYPR04MB7689.apcprd04.prod.outlook.com (2603:1096:101:1e5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.23; Wed, 31 Jan 2024 08:42:24 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::a9) by SG2P153CA0035.outlook.office365.com
 (2603:1096:4:c7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8 via Frontend
 Transport; Wed, 31 Jan 2024 08:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:42:22
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
Subject: [PATCH v5 11/21] ARM: dts: aspeed: yosemite4: Add eeprom for yosemite4 use
Date: Wed, 31 Jan 2024 16:41:22 +0800
Message-Id: <20240131084134.328307-12-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|SEYPR04MB7689:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3db9b725-73e4-4a06-9b8e-08dc22388b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fRCXhZP1K1qO+GcjXw3l2L4wXJHCLSvEhQ5NarOGAnFdTbbP6jz4QRGyeQDHv+MsB/oQeqyIvIn028xPvJCfOKjY3WXJhtoKqCMhkkDFHRm4G2msT1j1RFQAmlMFf1UBHCzEvLZMIEcRMFtDT5SjK82Bt0ZAoC+w+eG3bvXA050izdmgwsDQQADfad3fvV0dbIugOWxrNpmlVZEo8TYFqGjpNYxOG7f8wsr9eVBp/h/qDDZTsTau3We0CclvE9mYdZr+/PahVay9Kwyir41nMMPsGoE5WTfLWXkTHfBf01c0O/d54UVHSf1u10+Tw5JaRJovx/aG3O8Twe34WRL5qRAoSOONyq9us+uV1M2Z/gS6619s8EGSBAXgFzWI3J7uZwC7xAV94f2WRjeZgWHA4oh9AfY8KBJD/fJOsXALYVVjNw4+JJz078KeZW7yn/Ll6pkXuaC3EzXAnPdAp75hZxS4+aKhpD/zJqvsoQzi/sR8fcA2vJkpvGnviQY7XLJ++BtjFYp+Gt5BcV5qoPlTuKmUhaA0Xec1rmpdj/BXcBgQoZNiIrhhRPfUvMXk3IaZOXYaer6HW8xq2H1hDomVnLmW26+r3ndocGtSsjdc40u8xOXkWDgASLKY6P7Wv5v9FvF0Krvq61PlseKbMMEmWeFfg1KlyDZ4dDGl2iCLZDCPqkXZFqNlkWvkVmAgjZLWImqZc0BWz7uCB8A6CXLHog==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(36840700001)(46966006)(81166007)(47076005)(356005)(40480700001)(82740400003)(83380400001)(36860700001)(336012)(6512007)(6506007)(70586007)(5660300002)(4744005)(2906002)(86362001)(36756003)(36736006)(316002)(8936002)(7416002)(8676002)(70206006)(110136005)(4326008)(26005)(956004)(41300700001)(9316004)(1076003)(478600001)(6486002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:42:22.0359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db9b725-73e4-4a06-9b8e-08dc22388b69
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7689

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


