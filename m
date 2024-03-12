Return-Path: <linux-kernel+bounces-99878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB76D878EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E481F225CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8BC5DF3B;
	Tue, 12 Mar 2024 06:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="sfllnoIe"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011004.outbound.protection.outlook.com [52.101.133.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C985EE6E;
	Tue, 12 Mar 2024 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224221; cv=fail; b=NtvycMQ8DNN6FuaZL8j1IegayM4Xesz9E/WrT7QuFWjPf0Cv8m2S3yVNCXeraQvq+eXmulcLjuP+6V28xAb2WYKe9Nf6YfXg9miyry9Tq+AcxDFloPPP8zM54stj4VTFpaQd9S8eOitp7phZjwbghwS03fvLSJkKV3ETxAGV7yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224221; c=relaxed/simple;
	bh=pHREFFhwlOVJ+c1HJlEaq0Noh5MYW8giykiy57ShYiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XP2K3fA8BWeJXijkF48yr7dtg16GTYKFzcIqhmTkUXzfi0YnfajJrPKhC56FIpX7ywcCHpStIUcJBncU2vsdFoSaxoh1dYoKY71PnxRYNhqBOFQNEc7O35Y+U8AfVB6Az4oVWzlEnBALAfbsUAY34yoFUddwbQQ1/K7eLHmA/m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=sfllnoIe; arc=fail smtp.client-ip=52.101.133.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYzxYx9in4MEMyVK3N4Y1XVBMneojXEbD0GqeyCS+HA0cVQpg23A6aXpXktqDvplG8kchKRxxvzt854CqntTokbhlFt8EzKYsulNkFNf8vMoSpB6Xc63lON6jw1DLZoMtBEp3Bv9gdGl/dKH/pZLOxsVOcc9ZkQuMSE7Du+gbe3VYXdJ9NmaJGwWbhNMlCOKb3ieim/tg8els1Zp7XWT2wU4Q6zHXyq73UwmHDq0sWmIeH4i3gck0aP7Rg+QRDKGkT2NWajUdOXACBSlvoFkX9wD6Uk/3YNIs71vzRFXFHed+sVGrXIEqekmFWzOF8EgBbbwQADPFhkGTtUspasn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUNtvQ1Eth8qm1pnxm9kajQVaK4SrxDkTRzAWRlpwnI=;
 b=BuUSMo0F4VujlBBPECnwJZLM143AtkXZlQyWr/kw0/tskcOVMBYhBxOOZiWhQhrQRt54QADpiR+uvvYDfgsLAGbYg+WejVvUr4iN/ewZp6WBwSjLWZxbbW1ZMamSNzoL16tvcJq1LjJtZWI44J37kjm43vvEUXm9lWfo1b/Lo1MSOTMKLOs3eENWuPO4s/PjDC+XCc/u2qvOqZt6FCQZ/t3GthXuyMVA6Dho+uytQ0so+6PbweUpuBPUwl4wLJBZ/bT5h5831tJQPq4IGknN2RKbWU9L8jGwWn/93t77HMpm+UUQwsPS4X8+YAAuj6VTfyjZw1vqMY4SxGTEvzVQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUNtvQ1Eth8qm1pnxm9kajQVaK4SrxDkTRzAWRlpwnI=;
 b=sfllnoIeXHMYRCKwIZf0hts2h/tzPN2Al81n89Pp4FakF9nMHkXhqX3maL5uomo4oZ5HEfmL5F2x8pz5+IdweW98V74bHVSCumtgtrXP4DQsbmbGVQ7B8NTd99xunKHsH/7LO2ARds1oWXQXeggHjRu2Xxq2ZSUfI02kO1ZI4Oj9GseuGRWORedo08MOZPYpxXSADNK8DLhJetcUOdFppbDioZezv0yMDwDUeWxHp/IJykh4AJjV1EjMyS9H3V3vAE9tL3vlzM+8b+NMTyJrvxwj8u55/iw9kCu7L5o7ulfkHnkeQNE1wLMSBufsEcJO+3z8zSOkJF9sKt6i5JSPzg==
Received: from PS1PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::14) by SEZPR04MB5874.apcprd04.prod.outlook.com
 (2603:1096:101:7d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 06:16:52 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::8e) by PS1PR01CA0002.outlook.office365.com
 (2603:1096:300:75::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 06:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 06:16:51
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
Subject: [PATCH v6 15/22] ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4 NIC connection
Date: Tue, 12 Mar 2024 14:15:47 +0800
Message-Id: <20240312061556.496605-16-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|SEZPR04MB5874:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1411db4c-5dc2-4940-e137-08dc425c0210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4spmlKYp255FLw6YZf/ULNoGaHOCzUFTrkuor9OGxnVfLHeVs2dpcyq60KrOTEVoo5mXKCpBopGuf8hWUemQ/cuP+DkoKqgSjlSkR9BcCd84jWMvpiXD49d2vQZGW21Sk1/mYXdbHPInq7MH3I6inbVugLalxgxAEMT8m2BK/kWBiREhOSvD8+RVR2v++YTSewLU1iQlbKhZIJ0y10XxidT4pcmaG5XBRT7FHYNuqkAMW1t2tNgAf2N/xhxI0kFEjMfEfJPygGW9XCXFw1n9Z7Vj8qBGHQitubNO6ASFA/k4dVS1LSNd0frnUCBqjG1+9946o5y5nYvUFeo0fIib3X5PseVtFjZUS/aZ9oHeAHcIstcSI+vasSb7TOvBWPQPZhRv/jI3QuP3JZX6JocZ2wVyfOTR+Vo7L/XtULCIT4cRxT4STD9GzTHhjss/0utGBQZoDq4Rm2rbFOfDRX9SMIqunThSJf8WRfJW8hczDt84rQvZBRth4FWHekH2cM0xYgEo5rMZS1iTq/0diUWFiOkNSDCo5qkK1+vaoSBghGWlPlDag+4N8EIDt+qUVWkzfTQtgrYnlTGBVzjxQBqifdv/ImEYDXmaPEvOILg9yuAzRY6yzFlqRCaS2+VDF8W7Ea6kq6B1T9t3HD58Bvhh9zDTolISy6HYSt6ziTHMO0MASrF+RH5F7TH5MnIWW/3vSRBe6qAJlHID7qIhAboO9jATevhTJlJxPCgBQoFEw7pp24PUqcUKBL2bl73lIlHV
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:16:51.6665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1411db4c-5dc2-4940-e137-08dc425c0210
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5874

Remove idle state setting for yosemite4 NIC connection

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f0e93c74003a..6d5710e5753c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1227,7 +1227,6 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		i2c-mux-idle-disconnect;
 		reg = <0x72>;
 
 		imux24: i2c@0 {
-- 
2.25.1


