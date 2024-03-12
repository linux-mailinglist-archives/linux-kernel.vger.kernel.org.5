Return-Path: <linux-kernel+bounces-99871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3638878EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6DD282CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A935A4C0;
	Tue, 12 Mar 2024 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="JZQ4Pt4r"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072.outbound.protection.outlook.com [40.107.255.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052FB43AB5;
	Tue, 12 Mar 2024 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224198; cv=fail; b=C2U0GMyF3kusJpBCYoKW/y+BOq9sAEHk0vP+LZo5B6taUvCtwSRU1nFjlDDHIhAQc2HbBNE46HpEQoB3NmqhnzDtWqKcGaJ1DJGTqYmBuHojN5TSA99QAp8gunZ3Wczvk4tm7zWLboEGlN1QpA7TWfyQeoI8/FcKEGHvELNjUP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224198; c=relaxed/simple;
	bh=eRiem+C8qTOoLgPNChOVz6bvyW4SFZl5FHZ8TykRGJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWPXZURZ5GepLrY27QVIAuaJI7sgtF7YXCKCEntqMqxWu1oLEDfyRyFFdu/A0OYZkPsjL8HMjrzZ1NF0NtQvRP/aZKavwoOg7+AvzErHMwQPY+H7kPk/cTbjPkOH8rZ8dsmr8lEECNJDhyt+wyWe9kyFHnmRtR527gWSonVm4YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=JZQ4Pt4r; arc=fail smtp.client-ip=40.107.255.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F71UYjKiyqrs0gBboYqtQGZMJ7N9WrwPin9wsMf458euefMPdCKZ4btLzRgTDx3nGB9sVvlrytQKLIk6VZGUSbb/0ZpX9H6lDuiTxJNeAdY1H8r91KXwK93bPdg8K82alpRAmyN6XryioaBQH1aCHx4p9s18/59gVxBiZMZexfMOURS6+ATOmXeoF5Br9iebr0ENq/TSM+l730rtUblG4fa0mTxF2aDp3XcUnEiJHU2kpFZ9POToCCOyRZGjCl99DvmPD7ZW1NJU+9S5cpcu0Ci9I2S37QqJrq/NS0+sAKBCllrtA6mJTpJ9hHKgdOsTIwR6gwdOAKbQNrqWOYTmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IINSoxJIm5iybOOhBOWJpL9vfzS3qN3CTn+pgk7JS9w=;
 b=GKJFVU69FDVfygk9FpAUYun4ZBBUhXGAujATC2ArHynLg3KCcAJ551rIv8AGPaGCSikOLt2JhJ2JFob/tRJNdCtmD4Q/1V2anWG4nde7MuSMNL0zyu+FhWUJUsCHG0/tHDNdhZtox8V2AAxJPfDlqmIrLMUaY3S5e8pZnalhiidAybJiVJW7usn6bghjZpTXJX1Il0SktEiPWTNQN5TNwvRn2FCJfNoKYzbDqH0b8dWywUOuxxyvGcNgwLz8J0+nJeLYgzGOKZiT0XMLxA+vr+7LLhcWSRYokDNGKYQU8occsh3B2diaTTlvt4zfcF3ojF/EHm+51IVMUyGzAI6ETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IINSoxJIm5iybOOhBOWJpL9vfzS3qN3CTn+pgk7JS9w=;
 b=JZQ4Pt4r6WhkQfgI1Cm2TEQGKGqNzU+6JC8e3mA3Z2rIkBJOc8RkFwwCkqjfVFEvYif6v9Rf1uAqWN1gwcJPltxHJHFiR/ZPOpwSIece79AhtaRTwkl757PHHUU5PrL2D9bmU7CJLs3IS+MFK/DrK4cpmXkCO6xEd2gP8z/i8Fv8ntaaIOxbi0YEzNnxqNpMutNQam5b95Rj132Clu0xN5GHHCOgRPm7cWBhpCtlgnxQy4srZruUfAOdBYjlTu37+ZidAvqa1Bo0eHtJq8OD2V7qtx9DB14SkjAkWvhKsATyCogNAjDhkwcVMvDyYcBPoH5dUkm2rtYiZ9pn1tj8nA==
Received: from PS1PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::35) by SEZPR04MB8405.apcprd04.prod.outlook.com
 (2603:1096:101:243::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Tue, 12 Mar
 2024 06:16:30 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::50) by PS1PR01CA0023.outlook.office365.com
 (2603:1096:300:75::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 06:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 06:16:30
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
Subject: [PATCH v6 08/22] ARM: dts: aspeed: yosemite4: Remove space for adm1272 compatible
Date: Tue, 12 Mar 2024 14:15:40 +0800
Message-Id: <20240312061556.496605-9-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|SEZPR04MB8405:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3a461927-8ed8-4cc7-d4ed-08dc425bf55c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eXwkNAUIiQHGKCU9UF28+uDXS6taLDkJf0gR/tNWeE56yS1NnAGx5fV7dJDgWQBtaJNxYTOyFpdYk3+CklUtxSKixKRhy4pdX9LKl+gTaLUs1Tk1Y9bBtC7K4R570Qwd6Pq6mDD30v8KSNPIhTzcnn6aGYqe0JlhUmalsZOBkySmS9ogw+B8pjczRt6+KtracNbwRx/LLeeE0DdnrMEIZcbmLKckNzT4ssQ1ZG64biZ1FF/RPjNCa60sB82tTATMf8B1SVOasS2FbDOcS/1lVBd3EORByY5AXn10szWjNOlycQUO+v88NilRLIm7NmwBDdptNAiMAdsN8lOsHLNpsqZH09xMHx6SCLsQHP8sX2DRCzVA+FCIEQ2oiIVGa02ALVP+KE3hVmRLjAGFH8xsK+FVb9038qvvkDQThfSOxxwMMT3b4DrJO7XpRA2SO7ctU2bUfLq4zCgop+yo/O9QdYVeXKDQ1Cilv1FpE+8w85LDDALHN2HDy4efiqQIeeaphM080Mu7yOvxAQqQn6pYL1qs+ikpRJmHnWZCpJfRtBdRkmPti1XitjdRnJmv4fOJdK0CbY3o5TUbobEwueroxtOuii+r354/Wgb6GDzau72h3evBeKiiLJdMPkhfY1ay3fdLcPAd9l0AxxYAOgiaaFqdebwTaIIBuAFLBplKu5PPbNPk9FDtoXt7e4eCzFzYzI+cuuM/gDc+pKhT6IR5wo7prI2G/SKx4FFQbQXIuDbLQhNiO1FfROsmJCUxHbsE
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:16:30.3539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a461927-8ed8-4cc7-d4ed-08dc425bf55c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8405

Remove space for adm1272 compatible

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b1775b5a6782..cbf385e72e57 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -821,12 +821,12 @@ imux29: i2c@1 {
 &i2c11 {
 	status = "okay";
 	power-sensor@10 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x10>;
 	};
 
 	power-sensor@12 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
-- 
2.25.1


