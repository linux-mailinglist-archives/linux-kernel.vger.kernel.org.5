Return-Path: <linux-kernel+bounces-118450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661EC88BB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8D92E2987
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBB913049C;
	Tue, 26 Mar 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="dEXlYBJ1"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8634012AAE6;
	Tue, 26 Mar 2024 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711437447; cv=fail; b=i7YUai8/g1M89tiUT7GyL0jKB/W+ar7m8Id21yXSENWSkBxUTdijp4sCPc5p5503/nyZStmoRYQy5Squke/+TxRD3goXhg0Kz/d/MC6xJrtQoK65Ot2swffRFYK/FcNYPgBHqTiCfwbJ9iCGlInJVnspH+XfPjhgt3LNCj+gmFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711437447; c=relaxed/simple;
	bh=8WpteGatTRXCROe7pMH70ODPFZLc3MJu77cscNWAg7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UBScaHMo8yZY7tpW+aG8L4tlyolKUtOTnnGLW2wkLpULduulQU8Ike06gO8P+x9UB0H1+O/feZH4YIDmBiUwIgPrKMfepoHZUIdXokQf9ju9I10i5taCTQW/j+qBGr6OaswRbpXpScy6jRSGnDWCaMO2Uhe7M4T+0wzM2E8T9Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=dEXlYBJ1; arc=fail smtp.client-ip=40.107.255.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYqQIeu7ae/U8eO5EJXw14pKsPjBXwlgNddOrXaCzJlpbzB7lrj+GZDnuSIKWBH+YKbSUE8TMBPAuBbMQciUpkgDdNwEj5ar/K5Jfkm/l+JlbMBnFC5OGAmd/XXgCnewGrgYZbpOzn+OdRjjTnMgm/MeUaXP5z+aZFT+yTdl6UIbfU2uboV11jNqo4exHggtQZZ6FsYPNXFj0q+hM6Ku/axdrOJYA2AJoQj8b6D34HCkqjFnebWKAAfDuIOFl3ZW4I6XXxt5+VLuIPZ7W8Y2FI5KaiUXad3g1T3YLagQO6S1EKznUJlUbYeGO0Ub/FOjlKn7F/vv6rBpeAvnnLBPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAHQfx/4wOeZpm05XcBAClVTtOvvBTSz38r0WxzNCZU=;
 b=lztg4+hRZXf7faTwPK2w5UzxltxvQq6BGoEneWwQPKp1O7fYNQYoSnpxdVkOVQOgwgYWZSTaE3YbCF1b2HZshRn6k6SsRaURmmu3w3poBU3QdO9ZJIrBPu4fxrj3ehjyDD6ZKFJuyrN3bGJG4ENC9IgvUHfdqU5fiE0ls+fPxLdm3mPF2O3p/9ctG6ERpV5VRaEYHzIeT7myKgOxZbtMtK3hbWFdH2f+FDwiKRTgMrowJH6xQJwxPBG8b3Va/JrJlSY+vddm2tStbhjuzo/KScsQsS3trKynEjz1ASWgJnhIJsWvnwE46jb/rJWWxlD38zvLLto1NH7o+btmhrZcEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAHQfx/4wOeZpm05XcBAClVTtOvvBTSz38r0WxzNCZU=;
 b=dEXlYBJ1G5CQJ5GuFMtct6b3S7sswHIHGEX8vzoCI1FVaOnDqTMFL/L56irdml/xOCG26/1gf7K5Pke7jAnnW1WCYTDx1r1q9sDL19ndf6j2h16XsCMpKU3NwSR9A0beScF7g+NVeANVhtGfpn7HIgk4Bb3LJ4Agmug3w83e5JCnCGuaZUi0MzJBzh9lUZW35u+y5d4NE050DJrBdOlFOYRJ24AZ/X9BrWVNVovMKYrhNFw5oBmFsjKFjJq2YCNztLFLDfZfh9uON1S6sRMMb567/CohWuKg7vYXsge911LNiHSOXdI82CDMftw0hVFZ7hks3tr/muMopTs2v8Sb+g==
Received: from SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22) by
 SEZPR04MB5754.apcprd04.prod.outlook.com (2603:1096:101:75::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Tue, 26 Mar 2024 07:17:18 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:c7:cafe::f0) by SG2P153CA0035.outlook.office365.com
 (2603:1096:4:c7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 07:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server id 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024
 07:17:16 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: set bus13 frequency to 100k
Date: Tue, 26 Mar 2024 15:17:13 +0800
Message-Id: <20240326071713.2786206-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|SEZPR04MB5754:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a195ffdc-e2e9-4b8f-5c9d-08dc4d64c4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m7gh1kTIBnxtdLeEoGoHbD09X1PuVXTCpB+7J8mC2qFYCaKxj2L7mDriIfU4SLTQnLp28u645PP++TqYrJjHNfmwJvf0MdHvgDonUv0BCpQDoclCKaWfbsSSj8sCxvMbReEgac1Z1jTxTNXs5O1xCCq9c8tFaddgdObya6mnX0j6Y3SQzkkQyD/nFetERgYa8ycNlshXq8MPg2jQc1tJAebxiBqJQ6GpZqouZwaIJxfdm/6IZGtT/D3jSzps20l5P/nnmmKQgXYleXInpl9iSMUe6TwXFVFjmnS17IHMgcI6a/pnZLXGer5cctIXBXjAW0YYg6VaHFK0nHUlODfrsWyqABwUh9bSNKb6Wljr7z3NdaqzKkxC4pdqN7l8QLN6HqH8qVoghNDzxphleiNu/iPeZ1PSr4TJy3qGtR5gpqz6+9bxnkCKpxjcu6qls08MmU8woc3vcoyE7dYiBdwNxLM5ngeeLkjJM+oQky8VcfM/FamxwtueUJlkmZLTRi++ZV737lEeBjVYyBOBYyRuFZglVEfPV+bDrFBNQfFYitXETfu6fKXZtOayUayVs7ynogItiUKo2mIplFm+29yOQi+qU3Tj/fhkDArrd+a95KG5VLQlVdEsobNaVfg+UWYPG/ADJNpCS+tc3azKWeZnRuZjl53JdwzOigiNICBFlYOUuNUiIM/YiXq0fSV05Q13ztvM4XkZq7WzMmRE31QjqUrLaPYc228uS34Z5GB7yc9WDORUcFThj6/x+lyNlV4X
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(7416005)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 07:17:16.6663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a195ffdc-e2e9-4b8f-5c9d-08dc4d64c4ce
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5754

Since the ocp debug card only supports 100k, the bus is also set to 100k.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..98e58e3fea77 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -369,7 +369,7 @@ rtc@6f {
 
 &i2c13 {
 	status = "okay";
-	bus-frequency = <400000>;
+	bus-frequency = <100000>;
 };
 
 &i2c14 {
-- 
2.25.1


