Return-Path: <linux-kernel+bounces-109577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6018B881B11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92FB282942
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24CD58105;
	Thu, 21 Mar 2024 02:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="MelVlak+"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2043.outbound.protection.outlook.com [40.107.117.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71186B66B;
	Thu, 21 Mar 2024 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987203; cv=fail; b=tdxmjSmtNkIj0JWewCPfTTUxwLcLoHs3oEXj/Cq4Vh3BHy6cznWSjtevWSG3KrkgQp6Ia7qDAstAcFa8PiCouA8oEiIAIR17Du6/um7iuNfjg+0D2ED+Om5CENSeNVlhynDQii5SgLIoFIwewWP2z1wC6vz24cpOHe+cTVhucec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987203; c=relaxed/simple;
	bh=bYqNphwqGrWPnM/OxQt7oz9nvStYDJSeou9vgS35EGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WB117DamYsb9F2+1OQR2FRSZ/H7Vqf9PK+lTuf1lQpwuiKmLedt32tcovFiK1KxFPaUFDLAe8DuhBq1BQo1NuvvfGpbL9ehi2EWJO04y+HohjJvuUwNRuQwIIUpRpOymWGxk2YIuNulFlk0FBH4j5IMDvLnpqV1bar0Dku9c6ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=MelVlak+; arc=fail smtp.client-ip=40.107.117.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epS0NTEqwS+ruJjEpF6Kdp/kW+9oAbkK7SnoKhahipbwgbftW6BLQG9PiHH5TjXpVzRkeGkwHDli4Ps0aLzEJ1NTOeMExR4/2mFx9gngYeerMDYM117WzjzEhJvUDqrSJ5T2i9WNHU3HeKYAggwdySe5v/A8nJF0z4BZ/BDhxMHh6iZD1jL1BBKC3KHnXTmM1whhxxvdniY/763Y086zmthg3ePtwtArU595o0IZfyGOLFO7cly8SbS9NQGqCtlvB0S31VYkJI/UAFK1v2lBg9x6j+bQBVivNAjUfkmn1Y8OdzajqcIeQZwCvJvWmpJTd4Y1n2gSWIRi47zS3WYvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuNsvJZRjakzG0xvO5Ql3cleligdFuGLtEYFAXXxLhg=;
 b=j4KVRmGKMLwAvoYkCbzW9f1/R30+0K7jLoTdLL/J2FRg3WlSGiU4IVofol6S1PllCByJwwE2A/gGL1VP2aWfItlOyOeapnqU6j8GyxAmtMGDYCnz9oY3RKn49EVyTeL9F8F3dpWYUaMwdsjNq9PaQsjeICGpfKZv7ndesBw5NThQ6eO3Vb2naX/xDjdC4ePdreISJvwUJuRXv34xJz130X2Q4/NlRkbUvCryvsC9TDkd8cpGCLFmZiN2CzZAZI3udmHXdZLIokHNbEWhW+qxJIL3QBmiXFCQk7gXSHoFFSLCXlSeWKCUzJ9WeNqr2c650NpwEKwgC8xehsXh8UvE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuNsvJZRjakzG0xvO5Ql3cleligdFuGLtEYFAXXxLhg=;
 b=MelVlak+r8X8dM1Zyg0LT8jVPgLkDoU+dsZwj1m1A1RYQvgmXl/iPuF/9KewAPEKLrftWKGvpU8mNEHrI2A+jPPf+dzgy02tZ+Li8ldVXfz3xd7Fa4MyjjsDSnQZ2CSpHX/4h2XZEFMUx4Nxow8GgYt1svI3OgFUDszOliXJ7ewKonZ7nUU1fbRYtZVFQvlZSrEXlJEnDu3XcSOJNtmamo/NSSOiJUqhVEncGkTP95bqPGDM7rVZk0hk7WYeldUdgceFrcRqHhRJOohkE4DhvA90nK9kOxwPVfUbrbMPswHMBCPrhqIzMcieRi1J1Ebcd/l8TGgRJO5StThJMz/6tA==
Received: from PU1PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::30) by TYSPR04MB7047.apcprd04.prod.outlook.com
 (2603:1096:400:480::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 02:13:18 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::7f) by PU1PR01CA0018.outlook.office365.com
 (2603:1096:803:15::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Thu, 21 Mar 2024 02:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:13:18
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
Subject: [PATCH v7 13/22] ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode for yosemite4 schematic change
Date: Thu, 21 Mar 2024 10:12:25 +0800
Message-Id: <20240321021236.1823693-14-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|TYSPR04MB7047:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1270e3e5-2e11-4d2b-0e18-08dc494c797f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eSbl+kXwKvgIbZQlc8kkncYERxA/vBL3eL027AL7qnM5HNznKAuT5DkNm20ppY0l89GPySe+dgVLJ+sJG+2I5Jiyh/WlPLSYtfw5jLx+r8A0C8w2TbYkJX3K3u9+WNnWMKnsCNF7TzTwCuY3C/A6copdHsGDpaWlnjhiyKiv9KZl9KOjjJfXjQ8E8cXa0+ewSj4KT/Ow2iDK3lZBQQbmIB4bzlWjfy69BDFfOQpKeKwLZ0osOSKSi8q1XMvJdUVJ0+O7w6nSqwwguPDap+K3If4Ez9IXCSZIj/x5enG90ZZUTW0w8KAAGarL/K/68aMZgmlzAqFuGuqIEB9Bxsf0o5ufnIrIUUF6DF5hkU0dZHmKiGf9yy7xbfUth2jk1FJOhWqJ3ZF1LuyfcO5h5yXDHEHL5PRRACFNZWd6sXPZdHnOf6Y+7TsWLmJQHbINO/F3BbstqZRfzES2ou+7tG+bTFiizJD/FbW4kchlKtmxlUzWH2yS0dZeyd2V27qTepcRynM8BzCUnj3/wdQN0DJpoIibHj8M+iDskNv7yZG9hcZCY2MGxYSSlsVdHgzl9muYOmFZP4CTnw5DyDw3rATSwDVWzCoHJ4SZCp7mYEMK5tazgn2/tr817npJhhTAmYg31ZlckZdDqU4T6qlY7dadgm/jTvZzIknYEq9/zVido5qxGi8tIbwNpWhJOLG6yMOhhNaZ8U8GRY/WGbYEOm2/d7X8wS8T/PTYXExRU77vcq8UleTcSy922ZJEALxj3eXH
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:13:18.2292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1270e3e5-2e11-4d2b-0e18-08dc494c797f
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7047

Revise adc128d818 adc mode for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 95901f651f7a..130283ccefc4 100644
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


