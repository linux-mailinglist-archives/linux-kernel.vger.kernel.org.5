Return-Path: <linux-kernel+bounces-46026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB53843977
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8861F2513C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295AD69E01;
	Wed, 31 Jan 2024 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="p6qKu4vW"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2081.outbound.protection.outlook.com [40.107.117.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D569D32;
	Wed, 31 Jan 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690519; cv=fail; b=q8z1+q+9pLebxnKxwuYdpcMnGlQuSuUWHHptNuCUv/eS/Ql1VzItspuvXRXvEju3vNmrF5tfCScshRqE/Azjq591MvboQPoDQZwuetVJYHfrjqrb+xbWKqinC8h0CcgJBFr1QFxnzFJWJTlT6hSRDALWqCT5tqwJpc+uCSc+uhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690519; c=relaxed/simple;
	bh=hwgDrijLyjmApinmqTsVpRR9pQF0DfxsCzQgWtpc/qY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjbMj+diL9NtZB3zStTGzFWGnGCi/ol0haLXadJfGpt5JLRTjhGePzkll70KAHup/1PcwA2MZ3GB0ZzE30eQGQQ7BwIdr89XqP78lhYuF17Fc/YsJ/Dxczb3nmVMiEBQefBW0jcBCjTaTNOBe2GQj5oMq0NWjro9cnWPOtA3cVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=p6qKu4vW; arc=fail smtp.client-ip=40.107.117.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1MKELH089KgtTISardo9nOiJEZlLCUF8SquYgeJnplFmJ4tOdT8T0luQ1yZUdZVhYDWOqH+wKFbd9PrkJEjClPyMhR4BB9ptpv3db1wHW+F/1q/1BpP05ZqtP973u+DzrY2Fo0QI8U9hZvR7LYLKXtsgsluzo+g/2JzYM+rnPvMemcfm7Vq6F4QFKTT4f1rxTmpOjP8i1woyT/hjWxPU3wF38hUqcNVz/RU0/MOBN+SQ/OnlI+/2HkQcCW3J7BH8EZYkomSnx8vF9vC5WssdetYE8vjMfXsql6G+EbO3/pD9/525JGosewFqvghvsesd6Fbo3KPnzZC1B6m8DPZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXS/IBxr+oV5K2cp3jW9e7qRwk8DHsYfz2fJN3Mk/J8=;
 b=WMoIv5Y9j8XhWMT/eTZJ4uOJkZYNwrGw9fXMUrBwT8ifx2G9pbWgrjCg4n7z/V2txy3mt/SAxR0J6cjiC+AnG3QhNXo/3oTK2971mFRHlNQnCMJ6UtKXcmKoH9kt/Pj6OTaP5eQKv9DoNbktbojq4T8eK1linCZ7x/QaJW2DugbOP2CiaIu+sfi+hVHQp1UCtp657vMUN3ivTUgvdAYML4OnvGnc6FXikx/sFDU7dgqzIPnxQCZ9rXzMiXCUBbDhx/pE7UaREuiWc/CNJPdOFCzfn6htNrAXVZagNfm4Ff0j0oymaG8oHkG9S9K/BXSj/iHZfVNOfTBajRItUQNOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXS/IBxr+oV5K2cp3jW9e7qRwk8DHsYfz2fJN3Mk/J8=;
 b=p6qKu4vWmdbtNPYQV8YfG6cbAG6aQ1lknDJUHNUTlBEeO+5CHTlGnobsUcpjFyHBw6ezU72MrGMuXamMVtDlzq472xN/DI7tVO6qHcsXr2pRix+s1OwWKnyh6JNfjZ1YZtHcQUj7hxCc/swOFq90dNozUTi4YmcnfTFEcgztZ+G05kkjl/jzl315kszq1iAhlk8yg9RtuvWmPm6/q/A3gitS2AOmdyiZz2Nrx7ObJ9n4R/v85R0kc60LGB/VeHNG52k778Kxlnp3Vc2ETaHuReD8gpDoM1rkGio7hKb5DY32H55UwaSnXYnWPYNASPxhy7cKb0kIq+MGMFooZBv2Hg==
Received: from SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22) by
 SEYPR04MB6725.apcprd04.prod.outlook.com (2603:1096:101:de::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.23; Wed, 31 Jan 2024 08:41:51 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::34) by SG2P153CA0035.outlook.office365.com
 (2603:1096:4:c7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8 via Frontend
 Transport; Wed, 31 Jan 2024 08:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:41:50
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
Subject: [PATCH v5 03/21] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
Date: Wed, 31 Jan 2024 16:41:14 +0800
Message-Id: <20240131084134.328307-4-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|SEYPR04MB6725:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 66f84783-702b-43e1-325a-08dc2238784d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/sIBq1GCIE50flOv/QOeQnlP5lxgcjK2GOoScOF3bayASQ4nCyU/nmvdS7nc2eDIgWUP+uiLZ7Nn9YF7B4km2aJ+7tL9p5R4EigJN23KsnbGj3mnpfefB32VtjTQxcBqLWUvElnBoEpBHyJx2T0NPDBlnace/t+P0e/sgQrGYk3ixQpNuR72Ku81fHzx+XPfEvWWmOfnQDfWCEYRIcLAuICx+YZu81e0OIbw3P5sTWojKAYm4ctFGsaAYZBFHZyJozl+GLfz1GnSvITpRTdYHIXwSp1OciD3QvmEGOlwwe8L4fcKOgciHHbcuQhM7klqcMDeggBshy5JuNfc7fZcOj1VqOR8r+1+EaIgbevzPUrKS12U3Dp5IIFsum3RR+7/+IUEM5PVqhavHijDC/CzQRUZp8sMWPJHTU2qX1Rf8bqkXa3Bo3D6YuajBYXHjsCaxmePD+VpHwasGuI7zBC4SCH9CcBK/t3plGCzUtsHVZP2naIyA5Z3HtzjXimC9ig1UfFCzHYyEWQ6WJr2V6B1ffHthBU51DLbaW4d6kxefPUpt7iswhSHI5U/jYUpspxQtwWH7J02TqVjlAjCRYIsm3dOX2ZyHX6imHnozlBtUIv7rDrHurFgHp3M1QLpifhV2FmA0JK1QeExCyysp1a9y9F76eo3oqVzx5+CMBDId7Mp+ayJ3P7Mz6QbzeILtMN+PFxsyHbSEpKZd/rE0ZlX+w==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(36840700001)(46966006)(47076005)(6512007)(36736006)(41300700001)(356005)(81166007)(110136005)(70586007)(70206006)(316002)(86362001)(82740400003)(36860700001)(8676002)(8936002)(4326008)(5660300002)(478600001)(1076003)(6666004)(40480700001)(26005)(2616005)(956004)(336012)(6486002)(6506007)(7416002)(2906002)(9316004)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:41:50.0043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f84783-702b-43e1-325a-08dc2238784d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6725

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


