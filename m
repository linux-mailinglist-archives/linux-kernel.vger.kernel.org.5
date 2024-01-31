Return-Path: <linux-kernel+bounces-46042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 458FC8439A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A5DB283E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981698288B;
	Wed, 31 Jan 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="jD1KWjh3"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2045.outbound.protection.outlook.com [40.107.255.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1047082875;
	Wed, 31 Jan 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690544; cv=fail; b=eqksDr1177qni+I6dppRcpjG/60MwUDqWpGkpCdBVPPIe9e3Negh506QGx3Kyfjo/Jg5Z34/npXWv79+9qhGC+XU3hdue0EtZ25yjDCP0AvIYaZ7V15jpmewmHo+XhGk/lM6AoMHoPuvxkBpdYm/obNM9YsnmXnHX5S7KDSlqv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690544; c=relaxed/simple;
	bh=AEp8CYHJMbeBTPwsJ1U65YhzMyQOty5RxBynGL33Uf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqSxZ29mR098S2fvcCQ+fLk3XSRfAvgSXuS1UYktWirW9CFxWi/xCP3mj6al41JyA6iz2+Kohh/L/+jftlG1Omb0rcpWVGHhLW3E+/6i1nA3q3kjwgFL++BZTZfcFM8gRuILbhf/RMwfOhyeIUE6Ex1zdjSgSsdLaD7FwqZrBxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=jD1KWjh3; arc=fail smtp.client-ip=40.107.255.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaACDLtsIvFsgZrnrzgS0uW92uMGq+dPmMR78t3eCEvatZ/cCZEMfmUpCF8jCF9thU63PR3wDwQAmZ419HOrBPrEt9Wfz1JnkyjqrCBnFTOH0+59Id1hSKAsQCFJPpe3kscqvKN16Z/JfOPLo4vmdYcBc+rRVrZp4A+ZQaDVoRi/OrUKZzccNXVqrx9NZTZ0CYC9NYEmQhB9PENzXaaN3feMzWsbwRBPMkwH7gTpK+IeUPj9Ckgrn5jfZASMBKuMuCZ9n4TumyPnHn5aqyc+cWXigNqpXpFsFktuY1Ku/oCeaEjuJGhQqJ9CCBChbyHUgKYH97w/+EszV34StRVGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DosD6Mfg6HM5skGoPJsT5gKYffO1qIysmMfEeqUA3og=;
 b=nKKNDYhqdMwQcMI1tVgjqb2MAhqtOymQJUb0umSLJP0wdWpMAUC+jS9oxLaTEacffy0VjgTacVqdQleXFauKifSGJiF9nuiiWlUBLyyIOVLH92F+E/uK8DaGkJFajf1FfTghKyzs+HbllgTncdh+nuvMHhJoA+hJjIcTJsib9bwaJVn+cfdmobN1AKnyntlL3atg3YipVgA//uUqbUMJnltPSkdhTU7l/1iglvE9QFaeXzslLO3yPGuqlCy5FDcXVZHwnlcmrazuKs7btPfVzRIxb9HgrWNGr7CfvceQUx+ygOLn80G7ElKUUTE0hNSpkUv74m25uzU1ls2/OhTypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DosD6Mfg6HM5skGoPJsT5gKYffO1qIysmMfEeqUA3og=;
 b=jD1KWjh3iCjrFQ5qq8s3nNAwlR0JqlHN4YVGUt/wSRi/RFKcYTVCr5J1EHtfpAw/EuX7tokSKAg6k20f9zhH0v5QEXTUWtFQlRUxTPEul6SNIbKv9rRyJ0lL4Z34UpBbYDX41bfgPs1wxy4tOBIGf67G/F54isEflNLjte/YZdFNXyVTBIS+l1w+qwPckAbl4eIz/kRDV0A8i5XQRGSjHIxabSo4nMQjY1/Th/PSqEZnWpdv8ID+fG+t/PG5ybm/RdXxPGPt1x6i1vbd6EAb+XScvmeiD1uv5Q323GisVbqc1sIGZXSIAIal/WHlsmSvFWp9sirL3urC0s6Top4y/g==
Received: from SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6) by
 TYZPR04MB7857.apcprd04.prod.outlook.com (2603:1096:405:ac::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.23; Wed, 31 Jan 2024 08:42:20 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::f4) by SG2P153CA0019.outlook.office365.com
 (2603:1096:4:c7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8 via Frontend
 Transport; Wed, 31 Jan 2024 08:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:42:18
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
Subject: [PATCH v5 10/21] ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
Date: Wed, 31 Jan 2024 16:41:21 +0800
Message-Id: <20240131084134.328307-11-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|TYZPR04MB7857:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1ff75680-2891-446e-511c-08dc22388939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PV+zfdUEVr46EdaLt6/x/kKP4Pdwe4/amMPAKj22ndmEGTfFIv7jNvYsfkoQqZ1WemBv9megPY+uprcOBJqHrmcsgdHBoiUMBXTkpemW8xcn3GhCHxB8xXxPPkAiJYDW/FvRij8UV1761W4Wy+S5Dau9BIHOTz0Tf1OopfvFSyJXnFJg34O5IS1VkFMG2g810ruubNwACP1/kRbRYTwH+TYgu5pIa9N2c+NifbiVzneN7TDxRsf56J66NRqmip8lNPWXwaLtZdvHn05A2ih+jewKcs7DIHGK7CnZqV5o4MtpQI9vK+QEvMbqbhQcTYdIFGdjteQJojxBJ57yVbrtzs4Vmmf+gQVSRgHeRPyhxIsJatWF/CudXVaa4MJXVCdYTaq6taUzOL40XSDHp6MuThF2tXcDw4AXM2H0JyXMPg6apJbeU+Bo/9sJsCgvl4F1W2Gn+SJGV45oxrIn5uVxdQtuCHHySXVwHqp6Wup4GgMmNbNrMsucefkBsInrr0truIKtPa5mwmPHzg37TNxMa1VkqSLyrLg/OshIo1uz7VaZ5cw2QI1zhhkyO9ndFCB5LmvT6da0skE0JFqX4btVrze2TQqjJouT8Jt+poUJSBr+VS5HHqsNE3rcksMGTlBYMGkz6vnyyi+J8G1YRHTYcKhI7ArB8yqiOlqKkm2p9V/9/zL1Yyr5gCoyURnwvJslvMnY7P9bsC46QhOV+CgDDQ==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(376002)(39850400004)(136003)(346002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(36840700001)(46966006)(70586007)(110136005)(40480700001)(2906002)(7416002)(5660300002)(9316004)(82740400003)(316002)(36736006)(47076005)(8936002)(70206006)(4326008)(8676002)(81166007)(356005)(478600001)(86362001)(36756003)(6486002)(6666004)(336012)(36860700001)(6512007)(26005)(41300700001)(2616005)(6506007)(956004)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:42:18.4578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff75680-2891-446e-511c-08dc22388939
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7857

Add power sensor for power module reading

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 4b23e467690f..e8d7eb7ff568 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -906,6 +906,11 @@ gpio@23 {
 		"HSC7-ALERT2-R-N","HSC8-ALERT2-R-N";
 	};
 
+	power-sensor@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
@@ -930,6 +935,26 @@ eeprom@54 {
 		compatible = "atmel,24c256";
 		reg = <0x54>;
 	};
+
+	power-sensor@62 {
+		compatible = "pmbus";
+		reg = <0x62>;
+	};
+
+	power-sensor@64 {
+		compatible = "pmbus";
+		reg = <0x64>;
+	};
+
+	power-sensor@65 {
+		compatible = "pmbus";
+		reg = <0x65>;
+	};
+
+	power-sensor@68 {
+		compatible = "pmbus";
+		reg = <0x68>;
+	};
 };
 
 &i2c12 {
-- 
2.25.1


