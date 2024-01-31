Return-Path: <linux-kernel+bounces-46045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21558439AB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3A328E3E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFF384A20;
	Wed, 31 Jan 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="0gJrfaVz"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2069.outbound.protection.outlook.com [40.107.255.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D1083CCA;
	Wed, 31 Jan 2024 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690557; cv=fail; b=UFmkN36mQVGIbgjo/S6BYDAAdptjIE1DG6VRUixGAwwH+RCN7ik5e3uMag3WTP7+0VOlGmqt7VUZoujSnojgETCN8ja6a4rKLQY+74dnJ3mOj/DCYp3zgDgDqyV8NjZRoC+4+3futRoRaItOSIf/r9nyVgudvgDWLfpxDgf1dcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690557; c=relaxed/simple;
	bh=blhr6PvAdyVePsUOz88+Xl/xNJgf8daI7R2FDHYZg0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3IQXdZ6Ii9jY0QcQ2zNqGIAsrSnR5GFBa+ZHhuqr2AB9+kVsr6eyoyuLhyyLP/cmfovcnAYer1fviy/2oVy005rRSBDtUarLrtLn1U/oIxYd60Jguf7XdGLPtpOwh0h+VMPuOp02hB7LC3w7Yz45pvRlcmo7Us0R+05KrV33Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=0gJrfaVz; arc=fail smtp.client-ip=40.107.255.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFiGYGXLPFoNYbjbWT0f3CeKMLJ/FV1/PDGYPp+bv7uPHs71sfakQdGk5AHc4uQ7Xxe/1VZ3GU+w6JidFwy3GKrbkpl6JFaOYGKLkVx+ZlF/7WUKIaFF+K5ANrm4ReNnygCyS2osPRwOTDmhOlK32EVA7iPTbFZwwtMHcw588Rec6sl/2+R6QZsOGCZAFF9qLrzNgDRaUEzWzwWt2J999KRxYJEDDtrztzMv29gFxW7FSWkVihVngdxNi/8ei95OlY8xXKuawO2O3Kew9nsFbyZPUM4ddkd+otAH1ReAhWSKULR1rGSErdwXxw+bpvmUm4xvCwzJoFllry0bG90GIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beZQnJO8EVDQsB6FD+WDIWhawKeQLQfwrszb1xOyP/U=;
 b=E/Ic775QDm4SewJ5fDHki3Tmbs7zX/ZhlKqu7R95j4mxaqsSB53nBNgPsfzGdNXCCv/5YVTyEHLNCoBGVTdM+g9MYZY4vDiwkOSzUjK4u+2mEasTXs6N1Fn206B1GVwB5DsQG9PB+PTV6P3Y698SDZv04DVJNK/IV2mzzMvZ4bGw/x0evQN0T3I89FTQHL27rKhff904z7iI1WtHDPdjR2VsiFlO23buAjyJAhDn52E6K9vXw5H3I+Lx0BOoZMG++DudNufBM1/pAZOWf/duad5Cl66czpeQgGaGHIHAU0KVOkMGj980xsg7DUFoW+LmWAZilDBOCRdMeJGBGQkiTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beZQnJO8EVDQsB6FD+WDIWhawKeQLQfwrszb1xOyP/U=;
 b=0gJrfaVznUaL2unyaICQj2ivvj9UdxYVZe0EVtrgSrNxnbssFde+nzqg27qlOmaGwpc/mIoChXx6ISVbtx9/DHOG5A2Fr/7mDNBe/oJk7qoQSbg/WbRmn4he44JTtSGAoYhmPQOUdoEWnE03MDTBahxw9XhSZs4MG9j+29x4FSTtpzvz0Eywt7IcTedSkgj30aAt/N7jU4Js/DIhj5LOSy8vvFnIO2RjMKC1C+YXdUaoXJYFbGA18b16G2RCFfEJeF0oYCO6HRQZAgSzlfZcRQvV5NbTZdjavIUiAQZWfvtSvegl2TggkVsKZcyb9/xVPuOiU+D5C+6vZ/i0BfI/BA==
Received: from SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9) by
 SI2PR04MB5646.apcprd04.prod.outlook.com (2603:1096:4:1a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.32; Wed, 31 Jan 2024 08:42:32 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::86) by SG2P153CA0022.outlook.office365.com
 (2603:1096:4:c7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8 via Frontend
 Transport; Wed, 31 Jan 2024 08:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:42:31
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
Subject: [PATCH v5 13/21] ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode for yosemite4 schematic change
Date: Wed, 31 Jan 2024 16:41:24 +0800
Message-Id: <20240131084134.328307-14-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|SI2PR04MB5646:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3226394c-b3c2-43a0-9b47-08dc223890d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XFN6uNMlnNL9I9d6A6d4HXFinwwlV1ynnjKg+f6bYgjPRgzaB8mneSAO1C13Ihk62NvQYVJkdMavotD8bDCw5DmV0t7eNiOhP1QBWzjW2DET/1VGGdtWEX0KFCEnL1rnUJcZK2ZU6JZK0bMqjjjWIqOoLgVTn0xyryQ6Lj5puAgDj9e/llmFP4nWfQtPbxS7f6CkETVwPUrps+xKqViK8wjqEct14Ye0CPKJzfi2/KOE0UZMwxAnNhd/uQdv+75BoHh+IV9DbpYYD4IFCNaZW5BVCfjXH8nZgweLTWgh49xldCv8kCntyN+ajFOATKmBirobc2TBkm66x1SRKk2P2EYC0QM/h7V4fIQXIk1SiX0CMGTuo/xddmXoo5EnVObFHMY0B0xEPlfvhEt5ZQhf0hvhY3QSOsFRdFpMYbSi0sj8A0Ly83gHMa5sEIlMvWNq+p7IahWjmVCzgoDr1ldHUzaqKAp1WlP6ou+eDfYTFxipt8DuQC63KcGbczoNsJqoRwsIOYAR6NI+gBuE9opu8pa/C7blaPurWoAn7XBKcLpESeUTT8qED3szE85kOPk92OAu60LHCJO9CsLd15TvNozPwpShPVu2GZYNb7zY0hBIkaYb8wN0/jVOplSOjjjPxPkTig2VU+sGWeN8fqWtMb/R8ICrdjt6DEpKHOpGFxE6JwuP3KLeJ7j1yxvDbgfiIWmTYZQTLi7lqAUpNb5QVw==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(36840700001)(46966006)(478600001)(41300700001)(6486002)(9316004)(2616005)(6506007)(83380400001)(26005)(1076003)(336012)(70206006)(5660300002)(8676002)(4744005)(2906002)(6666004)(7416002)(8936002)(36736006)(316002)(4326008)(956004)(81166007)(82740400003)(36860700001)(356005)(110136005)(70586007)(86362001)(47076005)(36756003)(6512007)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:42:31.2392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3226394c-b3c2-43a0-9b47-08dc223890d7
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5646

Revise adc128d818 adc mode for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index bb4cba8f057e..4cf4b0ca1024 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1010,19 +1010,19 @@ &i2c14 {
 	adc@1d {
 		compatible = "ti,adc128d818";
 		reg = <0x1d>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
-	adc@35 {
+	adc@36 {
 		compatible = "ti,adc128d818";
-		reg = <0x35>;
-		ti,mode = /bits/ 8 <2>;
+		reg = <0x36>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	adc@37 {
 		compatible = "ti,adc128d818";
 		reg = <0x37>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	power-sensor@40 {
-- 
2.25.1


