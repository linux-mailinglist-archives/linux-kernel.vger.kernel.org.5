Return-Path: <linux-kernel+bounces-46051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B78439C1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D268D28D561
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A709767E86;
	Wed, 31 Jan 2024 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="epqwqo5O"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2087.outbound.protection.outlook.com [40.107.255.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77A67E65;
	Wed, 31 Jan 2024 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690580; cv=fail; b=tKn9LWCkXMwPBfC+LqNL+s4GJecQOMXkV4JPx+QFWng03ST3DZsHprjbam6NKVDlh72vJEfyBFuw1Vuxe0PN9o/UCcmia+eCf3W0U+iwgifUjQfaRQeArAjA7MiN9g1uFw3I4Z+WAHKohdEV4Eop8iV/UpzL6Q/MmKjWJyfi4z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690580; c=relaxed/simple;
	bh=Vj+iw6CGOWdU4jAxB/ccE7PsoMNyWo2p5kipTLnc23I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBJZ3DGbTsKouvFu+6PtdoK8VgGi5MHKScn/q4KWo4nSZi6xQGWw6+4CM41fH/m4GgCxqZa1hhv0bevJq9F92us6BbYptw8nZE828InYjcdzABwyffWwLCoWrswEPw2wSkEeI5oKhelTIgfUrNHexE+7mrWmhjjPRNj5npYSGnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=epqwqo5O; arc=fail smtp.client-ip=40.107.255.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqegRKKcN7Vq1wEgtsMBiioyC8PG8QZvle8ghQouR+0SyG9Y36K12XSf2fuY5Y3h483PkB1DCQxy4tFHjif18wO4I2uSlvLEjkq1z+J8kDjlHTvvcPjmHOeMFv4/vl5KNXRBrD5IDPzN5fs2oA1wfyJTpG6MsKf5PBqogihqIZLzDaofVldgfLzJFLFxROl7oogGjZsRsmc48dzUFpqf/q31ltWDcoRQhNn1EX8Dh8yZJGhDs5IedKSIPLsUus3zSzznRf1Ov2PJ5KSNTfqJ6gic+k3ZJLdnb9a1qUu7/vuTDCpQaV5XHNnWdi0eI9Rl6HncuH6hqErQ+GqNGQbi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIl5U0jZGhlgCCnivIqepmf0FLF2MPJnH3YgbaINBDY=;
 b=ioivtbZuD0ow2TBPp7Zbp7itu+cMl4KK3dzqQLqcx/ETTmNcLiSepxODJ29KGkQtEqNZXKm2XCqIGpBYJKwAmKakfRxICStQdISNIVzQNOA0awCZQ+HkhwaZxbR3696Sj4Mio3h0rhyZa0jUEFFCn/3y+kvFFtMHT29l1BiClr10qovwxDKl+FnbdHS9rhl7XYNP/O6vRIjOCwytJKIiWGg+hfWJZDiuMcouDHbhJKIz78yYiEX0xp99z5wHKVK7BfiJO+8l/9wuRd3hOkbAIroyTKxjO80I5TYk2gl2qqFKUrtLjFOYr4AnvpDwiA6DAoOD1zJ4oliVzxXc/H/+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIl5U0jZGhlgCCnivIqepmf0FLF2MPJnH3YgbaINBDY=;
 b=epqwqo5OMh7+U8WQ9ew5Z7oY3v2WC7VqZqx806vh69zxd81E9diohaQHYxxnquP6c+kL2YkocU9YIm6KwrRsDvaOAjhUW+OzqxWeTxJ94JF/1OiyarvA43yv0Sb4B23b2SqGpP/42pEM5T56W1yjoxaUnyh/eE4vPXASHzj0S1s4h5yQGk9CIvlClruJDwCK6oECwGlfigk7Hidn3zOF+h4YJTSv0sse82Z20uov2HHAm/Q9m3ZDoXj4liE2Sg3So6E7Y0zBKjWUgkqs/viF/rECVesAsiDWCcMngYKASnzPWumZiNHrJW4CKablmbB0Kv0Oky40fzckWZO5hfoOuQ==
Received: from SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9) by
 KL1PR04MB6925.apcprd04.prod.outlook.com (2603:1096:820:ca::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.23; Wed, 31 Jan 2024 08:42:56 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::b5) by SG2P153CA0022.outlook.office365.com
 (2603:1096:4:c7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8 via Frontend
 Transport; Wed, 31 Jan 2024 08:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:42:54
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
Subject: [PATCH v5 19/21] ARM: dts: aspeed: yosemite4: support mux to cpld
Date: Wed, 31 Jan 2024 16:41:30 +0800
Message-Id: <20240131084134.328307-20-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|KL1PR04MB6925:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b3b22b0e-28e6-449c-b292-08dc22389ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zMozAHFnLG7eIf3snQXq4tcdfgxrJOUcf+BlHagsN0O9CS3VVIk2648ZY8ByMq9j9zYX2DxSmr+kM07xc6VMtVm5Ybi8rEk2My+1RRhhoqYqa4F0w9V0YJ57kZ+kk44T730tqxTc5rdenRnyvPfzt1eIycmKhg38WxIm0X6993QkX5SSlj/xxusmACpfyzntgpJMPREwpyjm8zuayFGlw1ibywwbdbKuCtLzith1+Iaj3ovH0XTQkPqpVjaXbe5gO7r9CFyeBHVDEkeAkyil2WDeV5oGYvtU3ZavDxk8mkdaHT7zpyYiBmrGpUaLjwE0X3r7/axdQCkFrsJjm48NUG/98VcEH49Abi7AEQhBp2Ll1hEoNNRG6awxdun3I0C4Tp/07sR4Uo383cKfzBflcCQ3nvZqZQJ/PWz9Ox3oHfnM3AGsjtc2vTSyKzZdoa7QlhnHePuElncJguTDw+Vky0IWjXo+W29MeaPAkPoiMAmt6U8Gsg4p7sf1MiznVFkNF7qe1BFl9VNYM63v3rh87ZN8TfIiux21xbmHnAfu8IQuAIMKi/mfMevsYocNZCmu1uQAoJAxSEEpzKnIo3hb44Q/eCnqJy3Y18nF7jsd4EuG3y13fe1bhrr4ujahrwRAMf7VBwfDpSUgXrE3tr4OpeGRkUIEbu6O52zSFslZfAQyLJT/q4GiYlUcREXapFkhiaEL2QfovvMJaSd1KEAcaQ==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(46966006)(36840700001)(41300700001)(6512007)(2906002)(7416002)(5660300002)(47076005)(40480700001)(356005)(82740400003)(9316004)(36860700001)(336012)(316002)(36736006)(1076003)(6666004)(83380400001)(36756003)(86362001)(110136005)(8676002)(6486002)(70206006)(8936002)(478600001)(4326008)(70586007)(6506007)(81166007)(26005)(2616005)(956004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:42:54.7395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b22b0e-28e6-449c-b292-08dc22389ed4
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6925

Mux pca9544 to cpld was added on EVT HW schematic design,
so add dts setting for devices behind mux pca9544 to cpld

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 64 ++++++++++++++-----
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b9b6fe729cd6..d97520860f4a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -36,6 +36,10 @@ aliases {
 		i2c31 = &imux31;
 		i2c32 = &imux32;
 		i2c33 = &imux33;
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
 	};
 
 	chosen {
@@ -951,24 +955,54 @@ &i2c12 {
 	status = "okay";
 	bus-frequency = <400000>;
 
-	temperature-sensor@48 {
-		compatible = "ti,tmp75";
-		reg = <0x48>;
-	};
+	i2c-mux@70 {
+		compatible = "nxp,pca9544";
+		i2c-mux-idle-disconnect;
+		reg = <0x70>;
 
-	eeprom@50 {
-		compatible = "atmel,24c128";
-		reg = <0x50>;
-	};
+		imux34: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
 
-	eeprom@54 {
-		compatible = "atmel,24c64";
-		reg = <0x54>;
-	};
+			temperature-sensor@48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
 
-	rtc@6f {
-		compatible = "nuvoton,nct3018y";
-		reg = <0x6f>;
+			eeprom@54 {
+				compatible = "atmel,24c64";
+				reg = <0x54>;
+			};
+
+			rtc@6f {
+				compatible = "nuvoton,nct3018y";
+				reg = <0x6f>;
+			};
+		};
+
+		imux35: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux36: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux37: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
 	};
 };
 
-- 
2.25.1


