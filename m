Return-Path: <linux-kernel+bounces-158051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEBF8B1AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DDA1C21040
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6092B3CF5E;
	Thu, 25 Apr 2024 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ay6JBWHJ"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2083.outbound.protection.outlook.com [40.107.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED0942070;
	Thu, 25 Apr 2024 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025250; cv=fail; b=QSZli3sylTOLGm+ANtjCe+s5xiQHhrXJAJ1XrWV5xjDr6JHvi66BGYS8duBfkJEsF7SK/kZcI7mCLwYzap0nDmwaneRdgR1hiKdV1ABhkXBlFO7zgsApMYyF2a+55qHqlmxjcUhRR+zIKsnRCV0n79li5k48pwz0gFimhNTR7Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025250; c=relaxed/simple;
	bh=9cc+XI2VCZnU4mWObH71nYa4BCUSIRKS3wTzvn3mzMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I92cPG2AF+6PN+wNMaHEk2/eQABWhru1RAqFhE6fFfPA7durQWf4tzgPBfYdi6KGalzwmSLR1w7NU4bIvaVMn66vld5g7LGUesRht35WJ3qbEOCirtXja9p0+by5+ylop2vYDVj29g2cI/CvdBs3DbWvPSbvqdm30Sffwqq+a7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ay6JBWHJ; arc=fail smtp.client-ip=40.107.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8WbSc+tHTxqxiiKymnBx/fGcEzbouJ32G+gy6LT/xploYRi63ngsmoOrFHDuoGZ1RBmEBTlxizylPpDfo2pFTbjv9V9SarzfJT+O4kLDoQbYcL2xNVBHV03X7pqXUH24UsnZcMi1+jOZR2BdNXcGnjmJIbhuFBQN3ug3ecTsnsQU1nfkeJQZNBF8fzEUbK7pOj57q3Vf4p0emA+WPGddE0ipCsHZXZbod+tfYG8J537Omw8yYNb9IYHeXsVQ8OCALbR3H3jit/zVRJj+QWNREWX2stt5LOsHlf4eZ+MCO30wAIHAAWW+FuuCn9R7EzbPTbnKs/R2b6L9yQMnjTgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhKd5eugbyroswwz7UaRSsSWJlu4McTkV2n49tT+a+k=;
 b=ikeVoz0xQs9y0yepvR36O3dGjc1dLug/DcXgFtyqicMw9eR1mMZ18HQiFxD4KZB1+GUinHu22bgVLzvM26RXn1GJlnn0jEsLMnQdIsiHsxpraIXBkGk6J3R4cIPn5ctHo6h8ihjQ9sOZrDhIvn4MirrjG0FWMKD6Png9BbuFclPKreB59/cDcttjMpsn5G3TBw+hChtD6zBk3yQplrS4JdNsG/5nyONmHcPLw5QGeiqbCHGopMBE0+pd1zeBOyk7NWqHiyf1UasDbYUUp7qjWOmkKPvNoqDK6Upra6KxdW7859Lll12F1K60V3KCAWuwfUY2zd6IQSqXuy2siw43Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhKd5eugbyroswwz7UaRSsSWJlu4McTkV2n49tT+a+k=;
 b=ay6JBWHJ9bSXJvf3ejxAcQ9DlyjmBvtNosHY/qc9qeFrg3WY/boXCIfeE0MlwQkgunGfr3ugdp3IpBIKNcBioFYWFV8tEVj2z+21md5PEQcAv3fDA9zAvzb3KqDcKcp+PRQgmm3uVQVn0K0ea6Mo8dY390hwSHdM2REgO0mqbh6cuZ7mr4OBR6tP3hZ9Ax2FkTn7LYfvQs28c/wKv/9CPtzKWD4pyzv+G+rkc2NycFi+49hUCuKJ9LZFKnVhGCgSt3VIuKIb5dHOULUJubET4PjfwiYEAYvfueC5b4sIGjtFVR5pRVP0NuGpQKSJN+Cfy12Mo3FpqP3uF+NKCsi4fg==
Received: from SG2PR04CA0209.apcprd04.prod.outlook.com (2603:1096:4:187::12)
 by TYZPR04MB7132.apcprd04.prod.outlook.com (2603:1096:400:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 06:07:24 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:187:cafe::8c) by SG2PR04CA0209.outlook.office365.com
 (2603:1096:4:187::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 06:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024
 06:07:24 +0000
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
Subject: [PATCH v1 2/2] Add nct7363 in yosemite4 dts
Date: Thu, 25 Apr 2024 14:06:25 +0800
Message-Id: <20240425060626.2558515-3-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|TYZPR04MB7132:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5d7d6c7e-4b38-42f6-c74a-08dc64edfa36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400014|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r2wibwp52lCUxka1Oxullj4jDc0nZ+fLRbaPBlwbtlZTVjr4FPB5ra8H7JUM?=
 =?us-ascii?Q?a7tNquuhGmBSCyYGRKr1LkIWIqEF3UaDCOYTUTOCnUpq0sUdVTzQryxQbrs7?=
 =?us-ascii?Q?RPav3tDReM7QVD04O0v2NfyEDHhBeyELkXZC+p7Jx9szwLAfYBUSmo9qCezP?=
 =?us-ascii?Q?bIpPf7q1lhbg1Q+2Mp0CBExLQ7k4wgyPwmmcTDob/bEAMK8qWPi7gSAtA71S?=
 =?us-ascii?Q?CZycsl0zcy3MQ2VDN0RIVKD6q7/Lj4/LQOs89MCrQHz9QIZZEGpYOAs6p+AR?=
 =?us-ascii?Q?12N9uHo1gc9KyRd1WUEHAS9SBnW/qN+RAIKP6XkHA8jATcKN5Z6dV2MFzqUp?=
 =?us-ascii?Q?3u650xFuqflG0uoApA/pvj7jk2iKIf7lFwMpl7mPtyrcn6c4aZ2gviH2VBOE?=
 =?us-ascii?Q?24yP9itnAvzV/5dj5H3UOM46zWSTUVJhsW3T5Qw3cj/Y+Juk2nL/BPn2sBvs?=
 =?us-ascii?Q?TC0fjuffIso6EmtZviR55K2CJeDrNxYXrEQaE0uvLCbg91j6A0xcU8+ShLqw?=
 =?us-ascii?Q?hCkXr/XhYUPg/CAXHH6UykvSBJPO2B3UNYubttheQvN93ot6Zr6H4GMgqHfu?=
 =?us-ascii?Q?b5kAFHLAe1+ujfkSoA5uuwcod8BsLihvPnnND4KX696zEynZaZbLtyxhDG2n?=
 =?us-ascii?Q?Zy75DQZCgEziXZpQ7eywEDmvrKHKDifVIUYnCD2oR6cDlXiDiiaFweTbMo/X?=
 =?us-ascii?Q?xyxoDU5SepndKGO2yJ/oBzFGQYJS77bb+pzVOf7SKkxSNoti9EdisD+Ac7dI?=
 =?us-ascii?Q?D1YC8bBKfxgRMJSVS5YioLHUaQ3lghtz6RcN4+PWb61mGvAdT7kxfnF5oTNK?=
 =?us-ascii?Q?dKEJ70zzJkpvq/7jnDV2EJanQp0s9H/K7NXg6jJUSO82rlXawfsU1jcMtX5n?=
 =?us-ascii?Q?lhWCrbFG/w+LNy0HP8eNI1IUiRWAAXwxEM6G43uqq1EFpw8kjWTt6vyB8E2c?=
 =?us-ascii?Q?8mxdOJC50KZA2tClXZPjaJVltIwqcRdHAcNcqUF5EPnLmubwKFRYm2ZgEqLK?=
 =?us-ascii?Q?ePjZMmjhounWze10NUSo2Uv4o9GYI3o0/01FDW0RNCeEKS9dgBq2Y/kNQQ+S?=
 =?us-ascii?Q?Sqh+/ffkfGIwgewuBWk+IhXuc2ccAyNwwghvWyhozKQ9WdX1cg2qdjIyILdZ?=
 =?us-ascii?Q?mkeqDWQAneCUuililCZ/zM2/eA3SCKfDQHWSlOui4fxyADpTa5rQm6eAGoCU?=
 =?us-ascii?Q?omXvLKnnfGcsIreU37FFR/F8oCtI3hc+VCiyz5bFN948zbPg3LlWHhVTDUyU?=
 =?us-ascii?Q?5bHBUXAOI1m9QWh4HZLTyh6Tx7OgJJmFkRBcpcNLD+7nHuBxA6WIE/1cmt8j?=
 =?us-ascii?Q?ihwY9UeK44lPR2laIV6wNLrEbWtUpCfIuaVhzN5vUldhogiJUKECJEImiQlJ?=
 =?us-ascii?Q?J0+NTLw=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:07:24.0344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7d6c7e-4b38-42f6-c74a-08dc64edfa36
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7132

ARM: dts: aspeed: yosemite4:
Add nct7363(0x21 and 0x23) in yosemite4.dts

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index e45293762316..06b709b0a706 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -467,6 +467,42 @@ channel@5 {
                                 };
 			};
 
+			hwmon0: hwmon@21 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x21>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
@@ -474,6 +510,42 @@ gpio@22{
                                 #gpio-cells = <2>;
 			};
 
+			hwmon1: hwmon@23 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x23>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			pwm@2f{
 				compatible = "maxim,max31790";
 				#address-cells = <1>;
@@ -537,6 +609,42 @@ channel@5 {
                                 };
 			};
 
+			hwmon2: hwmon@21 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x21>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon2 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon2 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon2 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon2 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon2 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon2 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
@@ -544,6 +652,42 @@ gpio@22{
                                 #gpio-cells = <2>;
 			};
 
+			hwmon3: hwmon@23 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x23>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon3 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon3 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon3 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon3 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon3 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon3 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			pwm@2f{
 				compatible = "maxim,max31790";
 				#address-cells = <1>;
-- 
2.25.1


