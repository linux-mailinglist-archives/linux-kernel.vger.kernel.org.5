Return-Path: <linux-kernel+bounces-46046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED858439AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD03C1F24B71
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F1C66B22;
	Wed, 31 Jan 2024 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="RWGV4FSj"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2049.outbound.protection.outlook.com [40.107.215.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934084A33;
	Wed, 31 Jan 2024 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690563; cv=fail; b=GDUpY7mUKGTW2JGCj15jeekclHjY8LgF3g8KheT0Wpffe+sGL3MqnkORG3Ip60HemIFUb27iy5A7qtffFTS+qPkR/Ual6sPe29uqzHKWEjMuMqTPgIvFQABQz9UVyE9D1LmBPflom5pqnwNFUFpsABBM1HkqOmFUYkC+I4+bEMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690563; c=relaxed/simple;
	bh=zMuUty8gtT0THeEVMCnl/AJrWG+fTxynkHX0KGa15O0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUzQiorSEvH9j8tWG1pl8uH1yLW1zu59Iv9C8WXkrEynIrP/x54ThqdM9PPhDVGURTZT98PVxXMS0rpA6HZdP5Tw8ZNN2CYVph2htZ4d+a6nJLMFL6G7VjIT1TFV0X+GSyT2Sh7ALDzJwzc8AAODFmVfWp3/D/z2/ALlh8lNWqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=RWGV4FSj; arc=fail smtp.client-ip=40.107.215.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZofAvuCg7b+BTypM3Mt44/wHRmzBhVFPiHSPk/dv+k7oCc5zR2XtIWCkhD1i9RZvPgMY/dN1ic8+Y7CLUNrr6IoVvZlTeliaApjgBB0PGnI+/CdIS/lWRkIeDQz1Na7Ntol8C2FeCHPHCjJccHuZP3n8M96zrAKA0o7P0VnXJaJeWRZMLGeKpv0lgv0spju23QALHinthEddPgMWO3cMKOYkbukp1TIdwx9JXvb3vh4NmY848GlUv0UCs+IQ+zn1k/aoLeT2kWi3GOsXBOLl7lxzoeMRNbMz8t1pnGWDi2XFyO5R54FNh7QVjRgzLttjvQaufsubtk2q3Rt1OaD+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G/0w18p91abLzXYuBsYuPzEWdrZURAnJ260VnL/nkc=;
 b=mH3YcRTWTmw/vNo75MUhJFp+gQCf2fTqtrJf1TLajLsa4ryg754YGwk8yRqn15YeaCDjpNCiDRbbs9be56ifVjhmlgbMLdayiUVu+ek9r7o5d5hYzU2IKuCy64Cz2bvmCf46fEGZNrI3c1SqoqbB/hRyurlr+ruD9n/y5ntA2xfcLxTv1Xibtv+Qv5j+915KBMLbhIVlLMKTqwW6wSGAsiaJtCgIS1hMAZQ1UAWdPcfS99x+hwXNP4Gv66WJo9Az7mS5YRagq7IBrEnhex9wIMjCarmxyHWzNKvPXfco1GokU5aVbozdmnlhSieHwP2fJ8E9t7ax3XudBoEYCnOIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G/0w18p91abLzXYuBsYuPzEWdrZURAnJ260VnL/nkc=;
 b=RWGV4FSjsApb7ZvWmlxL6Wy6AYT6AJQ7k78wWRaBb7E1qDvsnxbCcJfgFLT3HCCX+P3wagSbtSBexq0VZaqDLJw878o9pwF8cqWONzM7VBdek70ah9g+RSPOjFw5PGpCinKdDQKc/y+07d8EIVZj7R8ZsxNDSmduwz6xK7cQUyXNVTX6Ffm4ECENsQCHQOi3vxM0uH0bLfOe5cEpM9TJ9lf/bUecpIBlrXHjlhVQORxqm3/2rcXQ9FaTjXD5ozqdIxd8PIhRY26+wVdKtaQyPVbk4/8nkEMprrVTtYNufPjT4z7t4noo5Re72y6flhTPELk6KxLFYYt6i8YdMT70Aw==
Received: from SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23) by
 TYZPR04MB7886.apcprd04.prod.outlook.com (2603:1096:405:b4::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.31; Wed, 31 Jan 2024 08:42:36 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::d0) by SG2P153CA0036.outlook.office365.com
 (2603:1096:4:c7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.9 via Frontend
 Transport; Wed, 31 Jan 2024 08:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:42:35
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
Subject: [PATCH v5 14/21] ARM: dts: aspeed: yosemite4: Revise ina233 config for yosemite4 schematic change
Date: Wed, 31 Jan 2024 16:41:25 +0800
Message-Id: <20240131084134.328307-15-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|TYZPR04MB7886:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 67c9fd02-144c-4cb3-f5c7-08dc22389358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1fLf9o0RYHVjcw10Nwa63AUJfoYrHeThuG22qzm4QB7k0XxDHehmjb3w0NPsycIR47wyiYTCCLJL6Nv0kXdDgB/siECw2RQO/PQMza+cdfX6UiyDjbcnFoiIX2JDwG1I39ElCwDUzreefYGVWGSX79mMWOJrVG7/qYhKsYM/gguEkTEyLBzka1B7rQcHffFxoch21FFzk2feH8eJsJPgme5W+Ly2vpt9UmqvbkoF/cRTCasSjWYIPQPOEHLcG8pf4BBSQYYgolRBH3+LEX2Nq/bx7xNg1iFoIQETkmzS9FYMjqS0CT2K/Xv4XVIftGGl4TC2nltomgGdbySoyCiBG7iIQATPBwX9uPSenIfTm29FpdgjFSJ4gQzHSQmaFaT2n693YSjztu3M9OIc8VDXCopvYWrIzual8UATwVEhKYkSGyOQ5LlGI0browgQkEV6KnKEfNctj96xf3ucX21mXNEGzjjx0ljO8KcqEbnbTb3Lb0RdXWy719bzf03bV1eDtXnDarxypBN1ZequS3OkZkVhS5T7l0KM7rFROrZ8GoCB/Sp27ny8NR2zYT1ZzPFTCk2YqObRxpXRnJ6vvUK3NFerjGMkH7+F6VuW7M/fAfYxFZAfgpS5GzaNos3ZXjSI5XZuhimFJne05vNcDAwTVlCePrEmvdRpLyLDWrWkid2HDQmKFzqVzp9gwTheeD4totDLEcq3tTxDF7YVmGU3Sw==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39850400004)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(36840700001)(46966006)(7416002)(5660300002)(9316004)(2906002)(41300700001)(36756003)(6666004)(6486002)(70206006)(36736006)(83380400001)(70586007)(316002)(47076005)(110136005)(86362001)(478600001)(26005)(6512007)(336012)(1076003)(356005)(2616005)(40480700001)(4326008)(8676002)(6506007)(8936002)(956004)(36860700001)(81166007)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:42:35.3955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c9fd02-144c-4cb3-f5c7-08dc22389358
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7886

Revise ina233 config for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 4cf4b0ca1024..f0e93c74003a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1026,28 +1026,38 @@ adc@37 {
 	};
 
 	power-sensor@40 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x40>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@41 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x41>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@42 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x42>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@43 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x43>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@44 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x44>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	temperature-sensor@4e {
-- 
2.25.1


