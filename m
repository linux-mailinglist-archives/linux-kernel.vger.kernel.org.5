Return-Path: <linux-kernel+bounces-158050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170878B1AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFD31C20899
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AAA41ABE;
	Thu, 25 Apr 2024 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Y5e2dBGQ"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011004.outbound.protection.outlook.com [52.101.128.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE13D0C2;
	Thu, 25 Apr 2024 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025247; cv=fail; b=BvcUB+Efwr4joEzusAlge3KWCNjGkxFBOIVPvey1b1QDdUH7G5h8VeMR5rlN5K0M2mpNfCVWcYjcyI7AiZflO2w9VWOxn40Q3wKhhK1gXr9k7/F0zN2JlYY9y8dWixaoSBs2mLUpHSfhecrmNQT20yVUd0gfW+4wyxjndzXghPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025247; c=relaxed/simple;
	bh=Ets9jNCtF0ud3ki/R93AiQLAOXz6YIl6ltUCaKWl3iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDJ+d+4VzMUPsk8HG5NI/JZ8y4APcUDcYrZV29/CkWm+bUurkJTlMumKJd6M3HkIvqm4LNhU80vpY4XQ+J3+gxSJTSPLXSB1auU3GUB4rhclYXzzp8K0aTyZzM5RkyBA3GphXugN1J6WJb125HiriB4UHj4Kr9Wh2bzolmPz+zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Y5e2dBGQ; arc=fail smtp.client-ip=52.101.128.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5nL6D8RjhfmU4y6br8Z8sYaFDiG7daUyK+aDrkmr2ZqJIx0KdQKrhn77dn3t9Llb5HMHIVRNxuSFGmkg/qimRPxhp1OdjGeWrNXwhOCNSv1tFQrniEgnQtVHEc40rk7Hd+GElF0fZlcBRvqilof4r/SOaNjU0f2mMz97sYZQRXeBuzNNUDhEdK7GhwYj6h7XikLrYysEFpir/mCgvWne7pV9+nEtUrhpK5k6+ggS0lNiSbg8ZEGgAxQaRiWpvqRCIXhKmvQFLeP21j9c8i/ZEjCUMpWDx/kZtuHaw3Z3tXtaMmZznWb+Qu+XdVN6A18u9GGJQq+GJZSgguNNqh7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Eg87oFJzWC7xCt0aHVYxZaLsHmigJmRYeA5ee+//qo=;
 b=ZqVRNfOSIHkpeNZHxDbFYoVX5CvtB/K7ExCSqFZehE5dyyDAGYMI2l6805+ByUzbuvwXrHngc3JitVBVPjkExDg2a4sVdwP0JjLr4ZTcVQoSv0X0/PrWMsi44bk+yDUFTSRoM5/g3nVpY5jSxLIHjbvFBQcI9AIjOj7Y/2n55Z20r21CG1EdGm/gTiNT3ot/WTaDWIirwBPpeGR/FLdvvCwKobcDCiamweqw7qLX/BHTYCW31XtakKyyRv9uxjZYpUQKGyBmi6mfO/4PlAGcl8hLJdH/yWPzj5Svrxp+WsewBfyz4f4rjnv0fQYsxCc55+oVx7TlyPc4Mb8ecxll8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Eg87oFJzWC7xCt0aHVYxZaLsHmigJmRYeA5ee+//qo=;
 b=Y5e2dBGQXOpKCYPzF//VjhLpORTmnQB3XNK2RVV5iMv7abennK61VxkX4aFO9JCMrqzL9iyKFbm1Mu8o6CI/0WGN8SXiSg+VQdQvK6fi5FQS/uJGq8xwBgwuXx0+nmdXSGahbZHfOosyNUDCMc/pIZ+4MBXRVS31UvKKxNS+9lnGER/Xok93zAujBT3vbbi+2FaqIaL6q534pX0CkoPBdb/xFDYf5kd5gyA6LxbNHke+PHZ9tlZJnSaxlZIOxAIINTJifwnAXWhy+qsL6zZMX3WRXKMhWpFYrPHY6X9dI1sN0WgJXdK3EOV5fMY9BEOBjXIjc7ZEfVYNqXV8fEJy8w==
Received: from SG2PR04CA0215.apcprd04.prod.outlook.com (2603:1096:4:187::14)
 by SEZPR04MB8173.apcprd04.prod.outlook.com (2603:1096:101:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 06:07:19 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:187:cafe::31) by SG2PR04CA0215.outlook.office365.com
 (2603:1096:4:187::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 06:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024
 06:07:18 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] Revise mux and hardware in yosemite4 dts
Date: Thu, 25 Apr 2024 14:06:24 +0800
Message-Id: <20240425060626.2558515-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425060626.2558515-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240425060626.2558515-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SEZPR04MB8173:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c701d320-1df3-4fa1-4d78-08dc64edf6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kSmoJ168Ik8EMU2SSc2s2fkPk8Q+h+7os1cv08l4lNtdhqLoznEnaN8DoVCY?=
 =?us-ascii?Q?cJWttraWxNLmLOuIvC4D0TclKdyKGbwFwplAPqa0b1n3MxA5BB1v5OQU//6s?=
 =?us-ascii?Q?Rz9bEgpUryJv4hkdW2rQeCUM+SIcZs6C/2/0VyJ5cXyVMUlh6iIdS7GAX0aG?=
 =?us-ascii?Q?17Y5hyQQ0vFoupU2yURpMCi+7t6fEBNtFcEunNDk+EE/uOJWiYwXHDP7QAIp?=
 =?us-ascii?Q?rH2JubE+SHjMtO08CJpz29CigU/B7exExhIsnLfUl4TygzX30jKX3STcpK96?=
 =?us-ascii?Q?MumJWyiWlL91N80AocvUuyaC/RmAVNG3JX9NwXM8YjweLydiO9wRB5YSSucy?=
 =?us-ascii?Q?0SgUUjJjvT0ITeWDbx8rrZ/M/OUZpXQWcV/fgCrM8fQ+05qjf9uqULNaiPKT?=
 =?us-ascii?Q?Pac3Fwt7MeCtS4odGnla1nQ0+NUKE3by10ipVxvzwKKNZTIo9yEs6zsKZaS0?=
 =?us-ascii?Q?iD3pEFNGbFXVu9+SOMEzG04kM3mF4OkOJBHED2Ga+LsPDhfFxsp3LTSSEmuZ?=
 =?us-ascii?Q?rymf/RpWNfiwzRg/QRHYP2quCt/wQopBHOGanEUa7ZXVbf+o5EK/MCG1l0Zv?=
 =?us-ascii?Q?xnEnd5NsHGQJorBJVvmouwYHx2HIA0UNtZBh6rMSdcofA9ZIjBPQ64XmZtRB?=
 =?us-ascii?Q?VR8qfxe3gR8sCwtbBaNvf+17NKdZxCZS9HkHm4v0Xpx1MU8rnDCAJchElMvC?=
 =?us-ascii?Q?0Qn5pf7tGFK6ovppDbeWLTaF3+kOjJ4NWOZaYuDqD9ml7zooUbyvacEJKfpG?=
 =?us-ascii?Q?TlPLJA5dxe5TNWJA7iN6h3MldJaQnyj3igCxIdALvFeFAVdvw/jom0eRSgjl?=
 =?us-ascii?Q?7hmksZUoTe/Rm7fi72BxzeIUoZTm+kkMcf77w1YK4xBxw2ifoajcbX+IMe8w?=
 =?us-ascii?Q?MsMvUpWmOFz6mFyLbT3DoT4UZYOGUUFbeR69GWxNLdq/MFPRgMNmTK4kU4KV?=
 =?us-ascii?Q?bSPoX2vjcRZrwKjm8uUwhJkcGO0JximWBeczZGr7neByjPl7NmVfWLgdvBDh?=
 =?us-ascii?Q?IyyO0wOsnlzNCSfV1X2kkV5g6mAmIoQ8PhmetK5Fk0EsIQDQokLr/41V1kfJ?=
 =?us-ascii?Q?zLeeWVhDgssJ9HNBsRI4nwWCqHBtkPRygVBIQgfHAAR+FZfzzP022+XJk0Vq?=
 =?us-ascii?Q?jxqf119w5Gmw6DXqap6wh4J+btNKzN2t09mdEnGWQnA8M0KgjRfFUmjBrjc3?=
 =?us-ascii?Q?HnvXlOm/s88+2ABOlHC6U1pVNVJD0lPLdLnE2KVo2TwmxpynZEz3f/WC+/Pr?=
 =?us-ascii?Q?szh/fEwazUrgz5cCiOiZsB/RZ8/oSj5OYh6Cvpef0ik1Xu0ruuCLnKiTV4oB?=
 =?us-ascii?Q?ihimYnxg3kmKu5NYoRRfc0f6FxyuxFjNIpX2/HAygalgCUF41I4s1EDvn+lX?=
 =?us-ascii?Q?C40Y7H4q7EsKaS9/OCJPtRYTc7se?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:07:18.5656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c701d320-1df3-4fa1-4d78-08dc64edf6f4
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8173

ARM: dts: aspeed: yosemite4:
Change hardware configuration, consequently modifying the mux in the dts.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 78 ++++++++++++++-----
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..e45293762316 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -433,16 +433,14 @@ eeprom@51 {
 		reg = <0x51>;
 	};
 
-	i2c-mux@71 {
-		compatible = "nxp,pca9846";
+	i2c-mux@74 {
+		compatible = "nxp,pca9546";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
-		reg = <0x71>;
+		reg = <0x74>;
 
-		i2c@0 {
+		inux30: i2c@0{
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -450,26 +448,46 @@ i2c@0 {
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
-				compatible = "max31790";
-				reg = <0x20>;
+				compatible = "maxim,max31790";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				reg = <0x20>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm@23{
-				compatible = "max31790";
-				reg = <0x23>;
+			pwm@2f{
+				compatible = "maxim,max31790";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				reg = <0x2f>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc@33 {
@@ -492,34 +510,54 @@ gpio@61 {
 			};
 		};
 
-		i2c@1 {
+		imux31: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
+			reg = <1>;
 
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
-				compatible = "max31790";
-				reg = <0x20>;
+				compatible = "maxim,max31790";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				reg = <0x20>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm@23{
-				compatible = "max31790";
-				reg = <0x23>;
+			pwm@2f{
+				compatible = "maxim,max31790";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				reg = <0x2f>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc@33 {
-- 
2.25.1


