Return-Path: <linux-kernel+bounces-99867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ACB878E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECE01F21B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82E058AA9;
	Tue, 12 Mar 2024 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Lv6TuUdG"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2061.outbound.protection.outlook.com [40.107.117.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9985658AAC;
	Tue, 12 Mar 2024 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224187; cv=fail; b=V+0tB602cldFOXtn9gbZ4N5jaZIVtbdazDmbOWP9yBEGWoJ0QaS5C/gf+zle+iIk8zGDurMXd9OZlqRPRWcRnXBbXPNUX4MzTrPpKf310q9dOOfZ1CUx3InQql++Xksz63p3VMD8faXkVBXmgY93SmmDhER4F2xP2CCSB8gOo2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224187; c=relaxed/simple;
	bh=hqXsYu7NJ7eb+I4JR+cYXqAEiSyMGWeSrIHRdp99mFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0Bj/R/zxKeALZiChKchdswffnK29IaTSxwbIfjn02YI+nDJhjNahbzHZojfcSx04FIFuDAGIVkcGf1CyE2TtvbnoOu/6/pYm89vYbePn1MPiqV4cshhN7pc1DI6rpGv4kYanZjwqYRgU6epMP8/dOzVCnLoSFtHOueAEgreBtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Lv6TuUdG; arc=fail smtp.client-ip=40.107.117.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReLVyFaTgCEXg6YkZs2AtIPkzElTErdpO/gm++xJux4QNI9CiIA/s6cORogJi4yjQdm93gbFoY211AwMBm4b0RWkHhL2j4wJVp8xXLbn4N6fR6jUbp62mwbcHC9gvok88qfZte2Xf/G5wwHQMTsYf5uKCTj5ozps690pH/JVvgaJVfFqyFsiLu0pmviaFrhDXOeFNqc9+h4uAYUlmUMyasyRZoxgkq9Gz8EECjKuXY+JZhogBsMCbRMhZrjA1gzQ49HEnh6L2iuvUjGayqAmT/GVzLaglcbm6eijThQGMwtv71UY5lNHGl5LLwjoBcWT4dNXrFlrmTrLI6SpL05tmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5ns+z/bWZune1KJ9Uhx7h1a0Q+DT0TnpkyUTwFsiqA=;
 b=UWsp1cN9Ki1+Imk2oKkQxiFScEcxWgqjEkKDv3QFYE9OzNZH3PuhiwoQRaP/0jvmN5YQWObO71pCvkakBagNsE34MzvA5iIjw6ges1ammJ8T751UXkHaU7YAbA29g6Q5C2Rq1uSNrFbmEMuSpf1/LfOxjLtylQZ8KIxhc6fXzOk0pZAintV5VuWnF+MsUtJ06TGr5lrIzdjzsNscXtvvvMHDuYrdX2GEdyznkb5Ba0bTibRfn4M+7n5j34Sxw+Gd3mwX01ni6GfCRt98WSa8+l+5/p+Eb5iLL0E5wb7/6PcgyA/FQOUOpMpjqGYxVjQ5kH/tLli3G+8b0Af/4cwa/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5ns+z/bWZune1KJ9Uhx7h1a0Q+DT0TnpkyUTwFsiqA=;
 b=Lv6TuUdGILRROf/xJc4lueuxAOMdpFHFhh0E7YH5CnoxNsigln7W97TtKlQLoI1HMrGAgENEQPTWgf88KlBgR5ahBmxsAbjbqRKfO7XUTgrixdZJuLXiJJz+6mIJ/JxI2hdMl0V9aFMX53g8UINIlOAgJ38P3fsszfXWWfLUjtx1sI0jF5FXTkILOwLa2kJS5QHH6SS4Q+MKa8BWgQUinPq/wCN065A0Pg61VHHTX+5X7sNSQzItNzGsHnK2O6xvVXMXDeF5v2lo2Aav+9zC1hQqYtv4StPqj3sOYNgGE6hNOYU9I0V+rz0VizdKOqYDLsHV0VxK1BHCYLfm+dCeAw==
Received: from PS1PR03CA0007.apcprd03.prod.outlook.com (2603:1096:803:3d::19)
 by SEYPR04MB6288.apcprd04.prod.outlook.com (2603:1096:101:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 06:16:18 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:803:3d:cafe::17) by PS1PR03CA0007.outlook.office365.com
 (2603:1096:803:3d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17 via Frontend
 Transport; Tue, 12 Mar 2024 06:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 06:16:17
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
Subject: [PATCH v6 04/22] ARM: dts: aspeed: yosemite4: Enable watchdog2
Date: Tue, 12 Mar 2024 14:15:36 +0800
Message-Id: <20240312061556.496605-5-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|SEYPR04MB6288:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2fd73229-2b3f-4388-efb4-08dc425beddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z2j3nvUA3HYQzuumQDz5FVMkPAQejMTWblKNVF80A7aDH4dQt46zCOV2t9iP1illM/hkx/aqFOzp+34qnla26c8jsJKbAb1SWRz7azdj8wNZz/B9QNh2vreiU54rl8CX8SXeKOvRG/BXSo86vMjHsNxh7P+H/0RluWCbXAnpwCfYbKQNEpy66PbtlcH6qV9XT7Jmn/kYo7X/OUVqDzQ1X9t/Q7FfO2rCm+askDLIFyious39so6nfIz/nKn61513fIeqc0Ty2l1bDb/0UIiEudYwU5XBneNUR+Mm67pTcKKmUQYFzFp3IrVL22lC2me81wralQasDh2kjOOim5FkKFY+AoUjXmPVxGMdd4yXDCpAEzLaAyBZJR772r3aX9s99u+vtLhnMwGRlKfIN8hBatfXmPgEo0tah4XPdEHFlzaamdxx/FqjSb4aJU+gIWIrYnXjrvDAl0kiK8QcUv7es/cc2v3syWo7iDM0923hFeAMONVdDiZJzE5iqvLn9poxn4+A3/vxMr8DoMD52aBDyLRgfIIm5t7Il33vqVWK12B4Wyx+P12/SCJddX3132zwUCjTSQWeWZ0S9z7dzKDy2nBSKYRqns5j+fqTy1PGG+nFiwwOJnkS9mAFXAub3wuyypCtFxFwd0MLoWKc8WgugMzdKcKZNZX8uxCTLCnp+yDddBkxLbpznB95Kgy4KtfpogPjPvYE39yRnf9gdFxpoTy8++FW1znCcXH8jOER6RYD2PXxaIcvEYpj/P6JARum
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:16:17.7913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd73229-2b3f-4388-efb4-08dc425beddf
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6288

enable watchdog2 setting

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ea8fd3ec0982..f8bfdefbefc6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -120,6 +120,13 @@ &wdt1 {
 	aspeed,ext-pulse-duration = <256>;
 };
 
+&wdt2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst2_default>;
+	aspeed,reset-type = "system";
+};
+
 &mac2 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1


