Return-Path: <linux-kernel+bounces-109579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75932881B15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FB828314E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC6869953;
	Thu, 21 Mar 2024 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ZC3JiiZw"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2051.outbound.protection.outlook.com [40.107.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45959B41;
	Thu, 21 Mar 2024 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987209; cv=fail; b=M4at3SrIHWR8sH3PfhXT3HH6AycL+NL0jBEqSi/+s4Xmb1WMrqolygRvZh4q7Jn8QGzw3nqFXSNnRh++wZn24FK+/hLgmTEAwnwSbE8nGAy5ThWQVchEsLeHqNsIUrdfiC+gfMyb6vTE4g2rZE9eBRUV89g2oAepZNDf7c+20dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987209; c=relaxed/simple;
	bh=0zgFWbCU2DOSa649mvqtTkdFVWR6/yXQUXwQ1i1D2tE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUQoF2TCyEdcBWnbVca07/qcksu8o/O7pP7mgYJxofF/7qBfBeOEiNeJJE8/gsm2QzlNlNzR5zc5rmIEiwmpTfaMzyQMA3U802zOmxrOWBe4QhFoZ/sJxBXQk5ULhs16sOmwufsDWNCe8K5BMJ3/vIFs0ot0u7gc7qLueMW/oTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ZC3JiiZw; arc=fail smtp.client-ip=40.107.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw5EHGl4OeTbzoEHOytWGWaKwsV1cBlnYYRED/xoJEpoyoBjDuVwFMr+69XTYDiYxa2oxj8f7DJZSddyJAsw8YhQllfbaHmtphoESA2Cb4RzCp3pCDrMBQFO+iClPsv2AuopMQwYR0Z0Y3Xu6v9yj3bnJhSl8RvoA7AwnlyFeSa3AGWWE2hiHC8Fg12NzTfIdfGALzHNw467rFPzMVi8BI/8SMjul3ZBfoqvP1EoMN0TWRemvkluyS+RtQg2ippROb18gHOe9oNWcChmD4E7IWEKIVFEJUudHqG55qFsjMzsZ6lQwiQA1akkoOAS/AK6BnSxLxV/S671b6qgEVb86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcUhSE2maLHVA7W0+EbGqlTEQ0qUxE3CEa/HFLuYWyw=;
 b=M0hlEYxRgjI+rFVKjiGxx0tQfELSEqz7eimPvIGj6L9tjFNq84VbQT0kTX6ozdx1F4DPRFz1C7wsgkcDGF9H0fIFXoJj0s6r5ENmV2YnIPJo69O9UlCzwkJq1DiKP0VPvrM3hA6vN7LUN6H43/MvO2EYBSkN3FghyIiRsq5n4y12vhuWI8Xpr0oDdxm9roUvbgMN2YdiHkwZWTSXv1Czmk0FWPZv/V3GVaLbQxmTHFmyWUL6fR4eAuD7MJYN71+GYECys2XS4zGGQ2rIwh4mSJTFNbHTr69v2E1leypYjAKf0hG9oD8gOMcEHEYc4CXkmXFQC/aw5agAEB/S7Nx67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcUhSE2maLHVA7W0+EbGqlTEQ0qUxE3CEa/HFLuYWyw=;
 b=ZC3JiiZw2YKORP9oDiTTSlNyIpzg70YuyhpelQkeapCePxtLEEoon0S5koFvYI2U7fjkEW9XP6CC6lMZuYuobzd056vSPwWgQHMFDhHsc80s/Enh4poDY5n2rByE97zE0jsc8XZMSApMTsco49zvCTEi0hI+si311m6IJDNMLSjc7bYH9ls0p2vAqJWGhCmN+Q44TXexqVSFFDGfk7pdp8cAEBIJlvKV9tMKXpIpolr4ubnvaQscqj+9V14BAu9sgvsCTxhsMdmO9fwdK0k3vx+QW+LdogFBfi/D1fWXhRB8aFmvbZHrx/wPYWK7LK18VeOTyGO6UUOUHmRX+rgXMw==
Received: from PU1PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::16) by SI6PR04MB7919.apcprd04.prod.outlook.com
 (2603:1096:4:252::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 02:13:24 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::2f) by PU1PR01CA0004.outlook.office365.com
 (2603:1096:803:15::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 21 Mar 2024 02:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:13:23
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
Subject: [PATCH v7 15/22] ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4 NIC connection
Date: Thu, 21 Mar 2024 10:12:27 +0800
Message-Id: <20240321021236.1823693-16-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|SI6PR04MB7919:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 63e560f5-95cf-4c2a-3587-08dc494c7cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	smSBIlQHFRL5rU7IPwWxEwF7wLrBUVpy4KeKeO4HCGQ8mcq4xnxoPGCrJr+hO8Q/jj2TyWPCglRZiE1jZLGsF/JlZ69pm+s9P2pDBh2z4ovTdRAMAKiBR1V3LyX/al4nDnKWioBCxPlzvwhHowGynNFIcQK8xcl9PM1zm/+IoQhEU30YQ1Oof+voIe6LBYgN3ZsnkZkt0VLdT7XAqNe2u+HGY+9oIMA+F+XciEpSCMV9Pa4mt5xa82zb4KHP8ZUD1HZR7RMp3y+9r+EdxESAO/i+4h1L0GV/rymZ79wp6Jcs8gttz0jiQC/vmM4SkoxbCdZEV8l9//Donmhvnv7ENy/mUVXeECdxVKEDnU2Ii+e8UbBH/BdTPVJeutDLXL6/z1RTF46gYbPsV4xfjO33z7yf9kEZNuJJvyzGZwnD+jRC+ChUI0SRip1odulCdWoboXlFS7R0TLDn+ixCOuxgkE/KgqSaN/4N4mjiLzHZdOpy08Ma58CtLx0ghBOWvZPKLYlB8jb4Bbt5GMshB5AAAQmU7AvtdrrkYT0kzVsFPOIEvdZqWUWRmhzJrCaaL5Z/RA7XadKpZCPa/XWtQXXdfUdOCqng5KiGKcYuv12lsvmizhh7CSwGeX71SikCqDYqCTwT2xQQ6yN+5cWc17L52AeMR565q7zbtBvsDAZUtxj9OLkEBLqJBTs0pYXIWOxlBfkIH68EkqafsB2J93d8VM6FKDNP43P39WHfQG/fzAPtWS/xt2SGaJXZg+h2ojxw
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:13:23.9948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e560f5-95cf-4c2a-3587-08dc494c7cf1
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB7919

Remove idle state setting for yosemite4 NIC connection

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 011c8d0bba73..79e3c956bc00 100644
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


