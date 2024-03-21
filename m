Return-Path: <linux-kernel+bounces-109575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1343881B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDB22821C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0C99468;
	Thu, 21 Mar 2024 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="t5uxSgXL"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2080.outbound.protection.outlook.com [40.107.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE614643A;
	Thu, 21 Mar 2024 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987199; cv=fail; b=SeDbNp5flhyuplCBcXRhyA/zginlzWHd8ajiqgzTMXFqvXn6d4dbRZ38F4q1K6us+nEvpjARXslQAJtgluUUPP7gSk/OCHCyxHpCJOcJjElB6aGP41sCDdxx1KGDflFI6Lw3T7S//ZaX/bVdHMJj2joYqGMQkqn3VQpCJUBCc34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987199; c=relaxed/simple;
	bh=hjydpZhOWnI47PVvuHM0DLC4e901zcvnrYYDJ7Yy/QU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvLPeONXhed3iXt1Zt+eSlpzzbnBfF7QCl3HL/Pno5dCnrb/FKLq+6Ihn03zI5+rIUQMgm6qhKUl+YJDL4QLPJd15g3uNDMFNIJ+ioA1VXjgMPnQ0smc0mMeIIj5UHO/Z7/uOavM47hcpJONZBGjJ05AeKx/HxIEieyEFUQGsQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=t5uxSgXL; arc=fail smtp.client-ip=40.107.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR6F8EoUXP10LbLB9ETHwBbzB4co+Rf8/3yaI7P0QzNtS9x2dIc69wVXg+d/00gnzXq3yW0tqDJwcwncG8qCF6Ma66cL9JXTUbPBGwrwjwXsPNSLn1pkMMC+CcIAuvcpnKZDXIAwQfFJekNxmY7TXu2FEoz/h0yMFPsdwGMp9b9ZDH9Kww0wY+cGjodiXBnEgnd1lSbr7bSZ7VYACP/L6YYakZMecFGH40GNgTnR9dQ8Sm7Lgx7nfvB/v0iZHZoDuYfMdUDKGxZQFuWUgf6aOfJmkbQqsFSgV+SL3bDO4L3xHkE0Zj6drgNEGvOm0SCALpE7/MTuKiBv0tKmkwDd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPNtZKi2fUNRPIzzMuqLSUdtQ1FNVxrHfoCqREbxi3U=;
 b=IYMSViOi1PulnsO9vdmdfK08E0mR0xVzP9GeAkFHDMXSNK6XL5FZ+qCN5xBZ8uV9x6/9NiJNKxJVyopW3zSQttCOE18ArM+exAh1Kv7t7yxe8fLJsgouTBGjOlG3ByuyFR4tyxMq5h7U+DL1ptjzawc4X5uITxnw4Llpygaa1bn9YJ4wULeUfDuSUexrrnGzZUf5FLyRNf14MsKPa121WOhl7h3UNRUpQX49MgTAqe+lkr4B3EubH/05rUQVhCOSe/AcEO0mujM11WAdwA6qPS3Don19VC9xYWBm5Pj6BVvR3Bz3yDB0y9Z9XItAGyWY3LMKCE1tzHEIJ3dJp/YqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPNtZKi2fUNRPIzzMuqLSUdtQ1FNVxrHfoCqREbxi3U=;
 b=t5uxSgXLKQGosa4RWB+JSY+9IeMR5Mi7sgFT48jYeUorfhsGe+Ac4VUq24X565IAz5dddlc2oNtOdCoSaMwG34epXktOLrjvllxjvOgOznyMj0yfV3QuUqV2XG8B6SWcYEkqZWOxw1BZtGA/WcdLdT+qZvi10GEpzHh96K47gEfmZmrlJgf2AbwyhHhylFElkDpQ5++46n3+6ZpeZprlRJFG1dy/ciorrDfC0EG+oPbKWsq+2qb3oAdB3sQoCRtML+KcuWzxShaL+fGBeoxyEikG0IcFDJ+S6v7YwdhxYfDsxUWjWC4hme2gktAG8zmkbUZq4Zl641Snc80kasn2fg==
Received: from PU1PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::32) by TYSPR04MB7552.apcprd04.prod.outlook.com
 (2603:1096:405:38::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 02:13:13 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::95) by PU1PR01CA0020.outlook.office365.com
 (2603:1096:803:15::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Thu, 21 Mar 2024 02:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:13:12
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
Subject: [PATCH v7 11/22] ARM: dts: aspeed: yosemite4: Add eeprom for yosemite4 use
Date: Thu, 21 Mar 2024 10:12:23 +0800
Message-Id: <20240321021236.1823693-12-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|TYSPR04MB7552:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b0b40bda-fa82-41dc-95dd-08dc494c763c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	62tlVqUhebK+9ukPKhQZ1CAWvITKBkqdWA2Bq52JJvTxXCPrhniRfS694J0zkwoRXvbqEGMJkShEkSEZMUtuENSGw6ivD1mI5JHP8vsYD8PjZ527nv2qpeAD7FxiYBFyZxaVLzhDr7t9geCnRDRiaXADN+rNWID1tj5s1/+klSFiiBzCU91VV4Ssmg4o5qsm6fdK93vqZEQLCFZXvMlxMrh8cHTMyiYNlLFo3njBBjSNyW4jKs15y7UZnWPD6t74lHiARfsc54O7MB6YVfAhujxITJJEe4AsCLu0apl9T6vZsZN5hjbIKRvPHSrJ5m6MfJdFYCnnhN+cMJXAVslrQuzOE2kGLcnoS/o1u3QTgDP9ocPJbqLziHvERorzyENM6LDqERZPVrSti/ICeI/d/Osc11aYK3U32lRJeneGfUUK2KlriownNeOU0zcWLfGrW3eCBBD45M5wsAVswf2aVgFg5iYhN/5JDKYPQBIlr8AUAYDsK+zAZJO2rsuRsOgJDMnvD6JpdP10qp321wwGKSrvl2woky7vRQ72NEfsfms3vRMBGZeP46IVcL98uGxC//WKwGz5NwUjeh1/lbdHDoCQ0JljFi4iPa1H26afCvYM46/F1SEaWlDXFEWbOTFExGswcwih/oPvOYO2R4LANu8aNRHRJSpS7CAnbdEbDGRwlbVVMRKMVs2MT5BOpDZJ6LVdmvrOb5Y5VIe7fGhKMUb8UNrOYISqqC2On9abm3bUcVppL0Txqb3gDnB8cpPD
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:13:12.7604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b40bda-fa82-41dc-95dd-08dc494c763c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7552

Add eeprom for yosemite4 use

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 175bb5849e1a..b52241b0559c 100644
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


