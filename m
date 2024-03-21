Return-Path: <linux-kernel+bounces-109586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2056881B24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112ECB22DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A159578675;
	Thu, 21 Mar 2024 02:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="rpP5cYlm"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2087.outbound.protection.outlook.com [40.107.117.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C07829B;
	Thu, 21 Mar 2024 02:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987228; cv=fail; b=bAYNlK8xiAbxVJfv99K3XTDj6kchJ1AdepQvqGpFv/bRLVX2IcotVAlmcsSyfqOSU7zPn/BMq6QPACOMuESFgi7pqjf6PEF1Jj2RnqPhorvb5fqKngYImIK0aTMvDvwPAmfzw1O8+NMSzTm4BJen8q1PDYWNJ42LxuP46kcV6u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987228; c=relaxed/simple;
	bh=7bu4fiM3JqRHKHBGWNtfMyWtlWgsJfjtbcknI+NpnbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+epxg4qQmSxnMNIktfVTb1wpjJucN15w8NPvyMCjU9LNjg9Q84bdUTPV2FvXVnLjFVuuo4Y+w8zvUfdvM/SHPk55Mvqs9NWk6UJRFtPCBufMoFU7kEw1xxpJQTWEVf52wBts8E+kTMpCgS/dYzNFygHLxVBa8uzXKRQ1rW1T5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=rpP5cYlm; arc=fail smtp.client-ip=40.107.117.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxgnMfxXGXjDat5IYoPgd5E1NLwxUsUxm1IVGhVqxLF4n0DblfxATUql+QrT7ZDvfRDnw7RJqyOlBzVFktusc2VQUy/2VKuowR/kb9JXAHZzhYae6720dZc6kZYorY7RNcHbbyhzFSxJVTCxagZuTyBqMHin1X4RqDESLPpx28K5L4iCHYUEo+fJHi6YYPzSseFHD0vX5+Poog2QNYQyie0Ceg1TV93SEPoJkxeV6cxjznELMMPcJMlKB8d+dzbw8q/quO+3Y9MtHzaXWdDCmbBbosNQ3NMxP/9xfOGiLSnwSG/Z8gfoFin4mqOVdps7IFZ0WDjswTT7mSl9Ay8+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6wbCZNYz8PSgbwkRuo0n/x8giBmR3OtNMKieVl27+I=;
 b=kzseLaczq/Vb9MMFhZNtfjoXptD9MCtzzrW4XeCFHWK2WD2nbFQXpcb0Q9jdpXYTJY3B/2zdJOGFTYA+rZRP3RjMQ3CPx38+WBD0NH7bGngysgof3DwBrCu/1oL7A5GS2TdIl/VeM5Xby8AX7zYl6JtY+Ytz0lJV4ENB+Ub0EbgHWxbCB/3dmyKvQpEQotFtN+DzhDcfkoWNqXioV1xI+HH27h6pil5gWIWMd79pHw4lPzvdQUs/koHK8OEFAc8ikrtOToDAt72HHtAjoTcRZXD5OkBD2hwfNFFp/AIeVvH5kL4PFWnnIQ3aQx/daTf11nFRYO7/HtfNeSVnSosTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6wbCZNYz8PSgbwkRuo0n/x8giBmR3OtNMKieVl27+I=;
 b=rpP5cYlmFaWOcOkDSryHbdRcKQqe0uWGi4cHuXBwpLPlX+BuOsjkj0IxkCxjG7JbhdXhsFYr1R5OV0oZW4nBBpnXMI7Jk0lMAonsg+/I9TFFArI7vvg56KQQW8T+8WX/pWJTE2HoDilOGx+4zYEjraI6ncNOh2mtXZEEVVV1mSoSEyCluMahn4H7BFY3uR0ODtho/IjMd++PxHkE4Ob4qEYLwQJBVuUrEs8XhvWu12mmDlyu14lCLP5mfsceMzAw1tVWX8bh8h4RK6JwxVzsG1KRT5HoMbflKEP0Aj1VK7qivM2IXaQQkjgWedzbO5DVMvVwnN83GTEEg+nUCosTlw==
Received: from PU1PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::13) by TY0PR04MB5741.apcprd04.prod.outlook.com
 (2603:1096:400:21f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 02:13:44 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::cd) by PU1PR01CA0001.outlook.office365.com
 (2603:1096:803:15::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 21 Mar 2024 02:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:13:44
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
Subject: [PATCH v7 22/22] ARM: dts: aspeed: yosemite4: Revise i2c duty-cycle
Date: Thu, 21 Mar 2024 10:12:34 +0800
Message-Id: <20240321021236.1823693-23-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|TY0PR04MB5741:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7930f744-6f85-4e81-35c2-08dc494c88f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JanbFoDmNXynttnmgn3MZj6HrkG5Lere0pjOhDhH5k4l5QbNXmxC0PvSH6UkEy4HAMCG8qbiOsiLiWXWOMoOFXL9ZQOJj6VeGnZqPtmg3VA99xmqMu2x5m98Eobjp7yNCiYyhv5aA200TBDWdDOe0jmJ/jUNhAfySrGknVMXCGiF5/AujThGOKC974NwTuJINM+vu38+2P5FRw8IwB6j813vmidUny7KqOse1jHjiXCxw+o/3UX2q1hEtc4ZCJadzFFakfIhtONfsb017KdarNVA8gE47kJU0onoA9qVFLcSe8dv8AnSH8nEVPsce/cHPy3L52g6XCt4Q/pFY+GpPX+SfF4fb7SkuSH46RUA9K251ziIqWipgLLg44H3y+0ECNkBOQnqJfECn4HTtrYlUHQNReqwkOKwMhkm+uqDWlYjBD6SV9gWnJ4K0aTOWeTwu8OQvT7SeaeDQItfBvQKLqS+d1YTuTWYX2e+hhfeTtM9izRRjaiLuBlpJKUZQrPVjUtfAS5YVM3Jfm5P+EuxFVXi1dshFQeTsAFGKwUAzcMVMVX+Wzrcch0sH6emRo7eTVOoic/bfw3yLWYgRL34nHHlU7l4AYdoV6VnSHNWkJAMjbEhkTB/jF9CH3Rkb/NlO2FqgruK+Diqmxcv9WDTaY/DOUt19x4WlC4tc3ZPGXhgZ+27vC1RhQUgmwCQMCF+L2Yv1q8xC35yvhcqdGcleA3yleGl3iQhHtMZpIl5Mkr8uoYy5Rqe+SH/H0Oo3IaI
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:13:44.1824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7930f744-6f85-4e81-35c2-08dc494c88f7
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5741

Revise duty cycle SMB11 and SMB16 to high: 40%, low: 60%,
to meet 400kHz-i2c clock low time spec (> 1.3 us) from EE request

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index c7bba7d68ce1..3a4da189f2c3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -761,6 +761,7 @@ eeprom@54 {
 &i2c10 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux@74 {
 		compatible = "nxp,pca9544";
 		i2c-mux-idle-disconnect;
@@ -1306,6 +1307,7 @@ &i2c15 {
 	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 
 	mctp@10 {
 		compatible = "mctp-i2c-controller";
-- 
2.25.1


