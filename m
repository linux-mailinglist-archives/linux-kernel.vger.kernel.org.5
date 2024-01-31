Return-Path: <linux-kernel+bounces-46039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2976484399F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3D81C2781F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA63680C11;
	Wed, 31 Jan 2024 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Jxd76hHC"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2055.outbound.protection.outlook.com [40.107.255.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56497F47C;
	Wed, 31 Jan 2024 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690533; cv=fail; b=sF797BVrhbmuR4DuP21Cp3wxD6TbE8+a4yNCf3QMzwHvToSbJvUvBovQYqE/0b69bHNC20p9djLQbaOXPdrnwOa32og7nhfyvIlywcYAku2woJYAuwIaPEKyInw/Zs1H6j6BeHqp13Aic12eE4yNq0qlTwNmkB/NW+CeUD2Q20A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690533; c=relaxed/simple;
	bh=VIZAyhd8g8pKkt7GWPguA9c6ldn9dYZPjwwkEC7LSr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNl6LwkpJLnpPATCZ9XUd//06Rd2nJzr+cmznHnqutZ392egcfhN7SrTx9DqkYYjWvh5alqBz/CSEY3E95hjpVkaxkubOywf5QQLR6svZJJuFAS/gJR/IqyiL8wHL7vir+YsEcTm1GRcjuu6XqtlEGLsBaDke28IEWnwijaAsmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Jxd76hHC; arc=fail smtp.client-ip=40.107.255.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VP7vsvVSUdYTM93CwF4T329aQJQAH6dkxsd4bRvgz2JAvtPN9odYJfZXH+I/Kqx64rhy8kLvqEEVZiA9Jd5gfjW0/LoRSyHAJUlO1toZWIy5kKRlH8T7lCGR4kRDyaqlrSG9J9fGkLGUTj0WzFWYCr69KRCii/ABs5VhYWv6U3kk5TkVC+gSEUwS+vremXZCi60xioEqhsdKKRmriKP+LbZQekUQgRx6cvb2wCM9ji4LSdzSLCsOTRMc9aQqn20JQjQaJxf+BEjFeOCb9jkLmMRYO01scvLggxFa1JE7yri3Ahse0dPUTChy8HIjAATXwMBMZBaEo76A2B1uXLiWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzEHseuWZgbqaKQJTdqvuHDahqAOJEonMBupyxnn32I=;
 b=A8RBct0cTOjijH9ns6lkVPAvQA3IScVidZN+hQNldhY7pfS7SgdreUfIXR7DiG8E2hjx6L8z+DCsH/cY66/X0mFH56QFD2ARghH8jXmjpnHLHrIFwnE+LFXo3tLMpogKMyWS9jEHqdiBnEujVK3Eys+YB5fVItY2N+kR8MbDbw24nDGS6CQNSvois09373Vu26WF+v519oJoKz7v1NcudMaWDxfdm5mzu1nVpRe+vZrTlFj75nR3BCPeXOkF3HZdLj/vl4AszlCMBsL9X2qkGeZbWw84iDHf1CQZWkPdxvubTn9rqDpPSCEsZfIAAWnhL9PybCY/tbZzGqHCNlIvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzEHseuWZgbqaKQJTdqvuHDahqAOJEonMBupyxnn32I=;
 b=Jxd76hHCBRwyOBHG/aSi6CAq9yiDltuY/1KQLP4YJzqUGXZO++0YIpNvc7i5mQcLPo82WRQInGBdf+azHdqK/2qeBKvjBExAV4VYSUPCgCk/nktgN/YqYUiggCS2dDgiSwYqX+GJ9y42UHUXuowgYe5ld3+sgRUlCM2Rsb+ZL4vJLTV8ZE4wOeETj9cxZyHEM4hshyIxW0UZwSndwKdcQkcKUc9R6UP9RvwVoxRBD9ucFBaOILjsC6hENyWa0NJKz9f7xxr8Q/HHKNbmVcZMKxcwjWa22N10AL05BX2EUkjDz6pkUBQC4weIUlmOoasphSKWcYOGSDS/kbQrrCcZ7A==
Received: from SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21) by
 KL1PR04MB8103.apcprd04.prod.outlook.com (2603:1096:820:142::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Wed, 31 Jan 2024 08:42:07 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::83) by SG2P153CA0034.outlook.office365.com
 (2603:1096:4:c7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8 via Frontend
 Transport; Wed, 31 Jan 2024 08:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:42:06
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
Subject: [PATCH v5 07/21] ARM: dts: aspeed: yosemite4: Add gpio pca9506
Date: Wed, 31 Jan 2024 16:41:18 +0800
Message-Id: <20240131084134.328307-8-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|KL1PR04MB8103:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 70bcf9f2-1725-4bce-a25b-08dc223881d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uBYiSFKSW54ZZ0zoHmmpYMvpbB2/7hlEdZMTZ3rGYuqhASw/1h89BFTgWbj7x+bkDClmcc24F1G8trR8/jAyu2RpmC9kI4kayoa9c1yt9iDbc9WaC3KGFcjzI57fXR99OwVTy8eclb/6VT81Hz6tVJdfQlRWhoejNlWSwg4kokKHGpwy1Ao1hQgyQZsVItn/qUiuH3vmbQS+xNRhgRxYYuuWMkN+p/l6koTwY3VLjTqhUJWV9TONCdFNfrigx1hUbkUcBAPhMpwMQjuEh6y0jFCtfwJWGdox70riIS3I6uycrgA88Jsg7SB6Yq4aNE69M90vYJBl7P929CIZzHACqDSKkwPOzLVF65OY6HRizK+5zAhSn+j3x3fhk4YzG1oDfNa21xq0433l+n0McptM9EeRChOWX3j1m+wpInGx7i0CE/BPv8fErT5z7FCbU/hDGRSrmzIUOgL40+UTJZto9qeL8pdQJAm1w+zWJWZEPRDExqHhQeo9nP0vCFzJDyUW4FRATjn2TdmFeVbnPab9dao4ugPH59awQp6dzckx4gBMyg5BVvP37wfRphAK0x4NpVlQLU4fSTm9VIT5kQlWQkivoIDoYvxwPRHzmzWlYdaJE+TRtjDGibeCV8EopckshYT1+5lkgr6Dm8MX3QMsEr65VShXfzLPWCy8n5WKYqp4E6qteGjNoYDUCHF1pp/uHLpIEpgE5tFJ+9cdVDjwOA==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(46966006)(36840700001)(40480700001)(9316004)(86362001)(7416002)(47076005)(36756003)(356005)(81166007)(41300700001)(1076003)(956004)(26005)(336012)(2616005)(6512007)(36860700001)(70586007)(82740400003)(2906002)(110136005)(6506007)(478600001)(36736006)(70206006)(316002)(6486002)(5660300002)(4326008)(8936002)(6666004)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:42:06.0513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bcf9f2-1725-4bce-a25b-08dc223881d6
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB8103

Add gpio pca9506 I/O expander for yv4 use

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 251 ++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index af9f7067c57c..b1775b5a6782 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -175,6 +175,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -193,6 +221,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -211,6 +267,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -229,6 +313,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -247,6 +359,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -265,6 +405,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -283,6 +451,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -301,6 +497,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -683,6 +907,33 @@ rtc@6f {
 &i2c13 {
 	status = "okay";
 	bus-frequency = <400000>;
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &i2c14 {
-- 
2.25.1


