Return-Path: <linux-kernel+bounces-46023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E584396F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F191C22C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D3E69D3A;
	Wed, 31 Jan 2024 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="nWdykIzd"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2062.outbound.protection.outlook.com [40.107.255.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821869951;
	Wed, 31 Jan 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690516; cv=fail; b=F1sMDxkRJhIAjk7ViKcieDVQsJ78VtwIE9S8gLfoUN6EfRw0h1j2ndGusqEhVe3uXkb8LMu6KBqzstaGOplbH1EUItjQlWbHS9nwIRLPElBPmO3Et6oyl94XOI2W5A9jWMHVLICG+JMJLVDv9MIkTN2Zz4/xgIXHkUi+dOOHVnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690516; c=relaxed/simple;
	bh=0uqavz9LrMtQsZ0CHtAlV5c+czx2PwnIw4YXLNZBMzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIQjRe1oU0q++gQAk/+Bw9JzkOkqAOdzD9pKxl1g+CtIT0hOIAD5qe0p90GntVRA8/8BqHZJz7vMt/Xq/yaaGpPvUGXCkwR9DxQmIo5wcx/yloqJvrBr3ifvSEwz7EekRs8PQ7tnFe54qb13Gkaqqz0hQOYi95MRhxTHX8odrn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=nWdykIzd; arc=fail smtp.client-ip=40.107.255.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpAgdLrGMvCvG9kviUClNyYumzl9DfNjBg+SArXH9K8oygwRsPZU4Kb/ZnqgC312SVrbuv0Tqer+7qp3WqhLJ4aU9R08tQh+Zygww/eyrrdyw+zbVKVvWRvoIGki8BYrlqSrLx5g/iZw2mixw08DqAeM2vAVk/mbTPMhTMvsCPtgNN76zXDvh4viFt/ok0asKEctt7FHjdDQIP1iBybs6P2BEewOleWQLQMAAxrgPN5cFeneBO+fbPj01Ws8afY0PKyaPVBZRMg1TAIUvRNJMswP9dTlb1raUnys+tVzlLbd4YBXMDOWPrvE9BjR5cKF0NYtAKnaT5QMdWyaprVwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kCO11WdUiFDfGWanOnHA5fSAvcgtGuDJsJBtZQkii8=;
 b=iYmlN3N6iXjeqB/bxr50RWPgavq4s69OA1Yr0pDl7qzGaRt7qlHl1ZPUkvG2Y9Jqg6hTLRUE9XIXlKxSZjv1OO6+O/Ai5aN4Od4MZY/Ldkt7NZqfhJ0QtKSX8XDjtUffttdGn4O4OS5l1/i9VcFUFKK56agSVugrl2ewpoaXcHEHRJ2dH9KE5cAlw1x5tEz65KyJqkm2zOAFkoT2GPD35kZuyD+qsBFI+cXWHsYIekrVnjKuS5DVerCdtx/t3xyE9TwQOvkz95Mmpj1vHz92Ah3wCdVyIed6ZZjEANrF0v8+Ys7+TsQYPPqPUnYKivQLdeWLBvrMtzhgfoIxVOImOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kCO11WdUiFDfGWanOnHA5fSAvcgtGuDJsJBtZQkii8=;
 b=nWdykIzdRignff7a08thqIOFGvPb+VWNapP5SVn7SuBIMuinzJMBFyFPEr149S0CZ8KE4P3fQB642LbBDlnExIXFxv88nx2b9dpCeF0kVzIrjyF0LKuMVlvyhGz7hcf7nUBqeXD0ld1b1sm3kIRj3gHxP3MLFrXdZkco8AAt0wefaQTFEbsdJusKQqlz1Kwl/02uTvZyjVSrCXIloobvdhPip8LKlYQWt7osoXZ+tDFEwmMjhYL3/eFmqOIy6bO+p5rSPdMG3h4pNKnzkzb/DlmH/B6ScoDEDOtYT1bVC+SGKW8U8Y/ns2NYPNfccejMzmup3XmLRJdvepMVqIrXpg==
Received: from SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11) by
 SEZPR04MB7248.apcprd04.prod.outlook.com (2603:1096:101:17f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Wed, 31 Jan 2024 08:41:47 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::47) by SG2P153CA0024.outlook.office365.com
 (2603:1096:4:c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8 via Frontend
 Transport; Wed, 31 Jan 2024 08:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:41:46
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
Subject: [PATCH v5 02/21] ARM: dts: aspeed: yosemite4: Enable adc15
Date: Wed, 31 Jan 2024 16:41:13 +0800
Message-Id: <20240131084134.328307-3-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|SEZPR04MB7248:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a877906d-7b84-4f4d-c25f-08dc223875f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aS1jebEGCiI0x6LeNWBVLr9a8RDR9ofgv2VWJJtSnwIGi5aNOrXmT9frfWBoRETHZMZseGdQ7TKXGC/5qwY6fPQywm9EayHU/GYNOu/VWJvhRp5R48NIV6cq8c+qteastZWCSpApnTLhEAydcTkmLqr2ituM+FVdYLJMhDNnBQXdjSVfkre0gI94MQ44dIPKMiZb2XOQ3unA3dkdCGu1Re69nJqxlhh994Tc2cfPSzOtRacThu+Wqh7GXSmDkJ/fl5HR0e8TudrtSJC46t6WNwlVakePbIMnsmxvaR+a0sgmBHksytlmdRV2oxsnTSiw0fHAD481LQd5GRM1+jasMHjP4jbTvlLPbwXZRm3qJy/MKM4zkswL0rHShN1SMQyVOADB6TiGTbjMxZ7tT/gZAVq9vhXcqipy6e6Fcjwyc8G0by2kiNjCXCRp/6EvIS4UNtpJRbmEjR71+/lrdgtgFNv5ATELfHuzXvqMuLg2AceGoUVqgNvxMtRY+JGKofS2EkAn/Y2zblfHYX9L0yqs75fdntUlF4UaNIeypCZd69ATUASTbKRcq+5RncVOxCMSC4uv3M9lFDwzKK4+nsmEC+MiCTkfb0QDjGeckT3WXbzfEaRrhzWcwMlmJ1qTr5fDjFUSbHlcaGl5ZxzETq0Z9QGruwfG1HkLFm5YkCDshlOxQcRDg1E9KAU4Bod9+SeFk5Jj+Z1yVZlsNA5hhWcfEA==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(36840700001)(46966006)(40480700001)(47076005)(81166007)(36860700001)(6506007)(356005)(83380400001)(82740400003)(9316004)(336012)(2616005)(956004)(36736006)(36756003)(6512007)(86362001)(2906002)(5660300002)(316002)(4326008)(8936002)(6666004)(110136005)(8676002)(41300700001)(7416002)(70206006)(70586007)(478600001)(6486002)(26005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:41:46.1449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a877906d-7b84-4f4d-c25f-08dc223875f6
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7248

Enable Yosemite 4 adc15 config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index dac58d3ea63c..6846aab893ad 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -51,7 +51,7 @@ iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-				<&adc1 0>, <&adc1 1>;
+				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
 };
 
@@ -920,10 +920,10 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 &adc1 {
 	ref_voltage = <2500>;
 	status = "okay";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+	    &pinctrl_adc15_default>;
 };
 
-
 &ehci0 {
 	status = "okay";
 };
-- 
2.25.1


