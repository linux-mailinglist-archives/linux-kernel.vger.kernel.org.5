Return-Path: <linux-kernel+bounces-109570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B45C881AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3088C282A68
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C695E1EF12;
	Thu, 21 Mar 2024 02:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="xO0CaSFQ"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2082.outbound.protection.outlook.com [40.107.215.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38418AE8;
	Thu, 21 Mar 2024 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987184; cv=fail; b=IkSe9jXRC16RRZ571JPN3sfrw+NJavNGFl1JYF/dVA5EeAPAGU4fGpWpGVtxTug0CfPwruAAPn2hIgXZP2KA8oHSF4mz5gcLbjGgOzSgDMkpG8FFkQEOrG4GFqsx3VktLbzPo22KaR8Y1/3R7/pKdlAQolbMzdC7ecWb6JYvvNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987184; c=relaxed/simple;
	bh=gW5Gb44NUsFmP68ZRCRypcAn5rwOVQLI0hNvdIAwIIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVHTNhzO5qOFeurvb4LVQBF1j9fLKyZSQi4tpLH3Z1K2gEEsANC+8mvO76M6crXSzTzvyyZ7JnA5fcTF5dk55xSMHpAWc9Ms6VJFZa//ioe8fu4uRlrfXYirADWfYcenoqnP/APx5+XiAvk+XE8rcNanxBzmVrEdWKpYaP2N3LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=xO0CaSFQ; arc=fail smtp.client-ip=40.107.215.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcSR3tD19vF5N/a01JDdHBTzCHiFCwabZCrjtSAOFkfAfqz0XKCSy+KgEJbol4H2NH88WH/9/8ujTtfn3dccg0PiRZSssSJZO4Gl5/nZvrC3bhKXllPdk/2wgVeneDlhzfsIzXwSd1BhL++lKe4WueqJZb0QIbgMDGSIRBZrg2I4xKYJ0qa3x+XmvIMbQ9kS5eDyxHSTMdmQjVknCuGb0hdbxd/4DCFKBx1rbka3LLVYWcCPLWuCEgY9oYM1rHME2kaMGds/sbcYfj6DtxqOens5UTuaCM4HHcWdI3JY60Ajtzd7esAdYVy6n5/04AeTfRZ7Etb7dvMdkHNakTsfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyfzsiMTiBll4ouoSSuk92xJoh4krtds9VMlLuTcNyM=;
 b=Q+O/Yq7bzq9h/jpNvQRSYB1stlOHfy/f7gtigfL9gcj7rrcY/l79BVrTsQkiuHJzExoj1Ve8dQKSJGX5FhCvvPUU55BV068JDIfXFacsOT2RyiI8hOHzA2fnrM+CZfdgsrEdKx4OqjX3pkXX7GOuzcm1zA49wXVOeGCdaKvGVFQ6QQBEv0RgAc5ONkFPx8U3n/MgeVOIsqKsuBWETPaGlZFa2ZmzyxKQXMq8mu9mHoc1U9h7BwYx25tfP7Xy9D8wsCCHoQ0dvWr5UmllS8cqFQO3vNdrnPyTKJo6+hpCyc4N4JhmNMK0CAYmuRdwODN5IEm6/6qckNmDKSl3hNYfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyfzsiMTiBll4ouoSSuk92xJoh4krtds9VMlLuTcNyM=;
 b=xO0CaSFQpX/7eQH1bkBnZ2H0RzmkkFRXSq8UXQ3hDmCbLiRtep8gk6yDYyOyxcdib/MycuUoYCyDIqxh33ngnqBhDMJM1RHPLKhK0tV655A09BrYDyQtwBn/lY2TQUh3O1fEG+tHsAvBX+M/N77cUVpKu5k3PnYNCiknJZKMF6sDScYcPivEIC326mbUcsgh03/gcUr8DQiZRmkeRJNxCYjYqxpgovJZepPUIj3DALUQXuKaAz3UDYZqjdJrcUPXAmWuBBz/XPY2qJ4qF/h1LNtLhq/JWAK8SLd5KgPcHsHyPTPpFIluUw/Z0v+lVqaIGBTKeC0sBuPDUQ19lCqJ6A==
Received: from PU1PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::34) by TYUPR04MB6763.apcprd04.prod.outlook.com
 (2603:1096:400:350::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Thu, 21 Mar
 2024 02:12:59 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::c4) by PU1PR01CA0022.outlook.office365.com
 (2603:1096:803:15::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Thu, 21 Mar 2024 02:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:12:58
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
Subject: [PATCH v7 06/22] ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic change
Date: Thu, 21 Mar 2024 10:12:18 +0800
Message-Id: <20240321021236.1823693-7-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|TYUPR04MB6763:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0c371453-4191-467a-6c16-08dc494c6dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lr8wdk3Vo1CQwzkdWeTLIt3aLj22+PXn+APtnQNlYB9IIQIZaen+vYjhvV4Hxmw7AB7P7FOpKG2TE6ZbOO16pDwgDKWgvnmu24kD16nI/pKf0x0yIkcL6eYFRSSCJzd3oQD998vRqHZbVuJNeLg+LjJVCpNoL83oWBPzkPlbpU8fd62lwppJWhIgm2+xOQoxtg8v4N7U6nc4wNbMAjVVMgXhwOxQOKZsUkIFk0BVUiU90sA+Y5pQhDczs1hhgpMUrq8oqtNKioG6oxHGwrE6RsOHX2Ae/shE9xEbFX3P2u4bOrN0pg9bk7QAlCB/Qj7VOWM4adXGOQvM5VxMmr8kOJXEe4zOh4iUofWItAnTjmjMlBF5nvCsBveNEAZ/rvwrafcvVBoeYX8eb/EEXQXIR2XwSsYfgN7UmGnbidezKmi3QukriPlAz8/li6iw8I0rR1BmBah1MDJ2ya0AunO544f1Bgm+dmSTvJBTmFDXwrXzbKByfD+isPK/51HDe8cLhGkRL59JLveyUnI7eW42g2d2/u0M943skYWDLsDqtGo50AoZOLmlo+wJkKnceRdwelJ/L4lOC89nb29mZAnn1CrK8Kon5ipuYNVEz/MZagE4SltePnPIfHOgIlnmB+fH7fxuOJgjlZ6WwzjuZB1WbBC/yLPmn7krZMIgGLNZj074eVo8vGWyPF6KrfWY2NWagWHQOqqXkq0JPM+2I6YnKcMbFNjXamb2g5/7KyxlCca1RX2cZW6x3bYRJPjN+8qm
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:12:58.6822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c371453-4191-467a-6c16-08dc494c6dd8
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6763

Revise power sensor adm1281 for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 23006dca5f26..af9f7067c57c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -176,8 +176,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -193,8 +194,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -210,8 +212,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -227,8 +230,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -244,8 +248,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -261,8 +266,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -278,8 +284,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -295,8 +302,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
-- 
2.25.1


