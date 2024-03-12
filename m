Return-Path: <linux-kernel+bounces-99844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE53878E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B43282CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E191CD33;
	Tue, 12 Mar 2024 05:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ojGRT4bG"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011004.outbound.protection.outlook.com [52.101.128.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE6BA28;
	Tue, 12 Mar 2024 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710221616; cv=fail; b=s3g02rA2zccoc3S8FU1BlQgKjrsjGvbjxoo3wU5Q1SI2AJOIuWa4ZfG7PCfofoNQ7NbfyI/PfLx6GlArbBAao/eUvaKRL9LU0G1TAk0iGBHlBSS/we6Z7iemCogqJmjyftf95ptN7LhNq0q3fpUke1xDTL3dbUujod07h7nzBqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710221616; c=relaxed/simple;
	bh=ZqJab6hE9LCSGGawyA+ijy//hOEBIIR6ftxQpxavwq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OWOMn8+Y+IUj/WUSsO+GV37aFDPB1gw50lME5QHlkMPP58dwdzshM2rprp9GNX9YwqnLplfXwIQw5JEfnGH/rCbWz8LKmv2v8VyVMdzm5R+IJUSHvyDObfJ0xMxQU6IHK3xOJZLvktodsK8PazRYAJoF8LatxxRs9IQjMk7uWmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ojGRT4bG; arc=fail smtp.client-ip=52.101.128.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HO5qLJlxrDF8pz/ytVyd6J9P6MdG1v4ghbS/rjuUaPBKGhoUylq2KJBPSkC+XDYVsU/F8IHLZJAiz5p3iaX7fuibC7ss0HdGTsT5YXbX/L1h3vuzqD476USXHQELIhADjVtDQ0suMegJUbnHDfU2aIjxoQy18y2FaRk3nbZhMpVUfJJKh+12/Osqy+jlnITzWj24yTK4dPs6lAXuX4fgz/Offzhcf80gd36SWU3I9XMo7lI01JnZ1VWdpIKizpPgAEoCVpfLvUp9/KJcPyEK3IDnxW6U0dRtgNitZW/vMHumhfDRgSlH7zxtXkXNm+sufZZRFptPR5gyPJ45JdIhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guL8wObsV8082jc4UkIG1LKFBCUc+PZIML/Wht27R+8=;
 b=fpgLOXjH/QHxASR7g7CCyd9vwW20n+6DM58mWv+kGgqisE+6riUzanv2jwC52WLmNzKs1ujcQ5l5kIkYcxhcQ/5ku7hVuOQNVFaG3ne8iiWiA+tPB1DI1lqlwnBlUqNWm2nRy7DdZDvY6d364PFOClnPSjdAQ3Yrhx5j23z2s4HS/XHoH7WgdtrndTCtN0dX6LscIqmQIEGnqVOJGcniZyfmpFYSJfZJ+83Q/J9i35jqUFA/aY40IJjRk35ccXjo3qvBROez2eDZwcmM0+n3WdOYgih4Kv8q66OQARDGZkBWDqEMAEjmHqxoD6mMHRM2gdYOPQ7rJ/X18ojCZ1zDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guL8wObsV8082jc4UkIG1LKFBCUc+PZIML/Wht27R+8=;
 b=ojGRT4bGQsko9z9lUvEpNjKDZmPyY+RlmZi5kkpNFvCzT4Fi8CyBPCLlPS4LJWTqa12awfdO8ubPPCAJ0KBNQUTyD80W5rgb9bG/kKzOkQa32UP+DeYyyeBm/VPmbgYML7uCjOS2taubfoY3WVYY4tRXxrq31pagJLt/Zd21Qr1dXBSCtPoRk+CWXRLABe6F20STa7gIhi17Yi/Tk3deeynmdATObKBBVmUEy0Qcx3DoeFQr/hTxFAZBr9697shEhWdj4YI8F1L3Ig9qF2hG9173I5btmCqePHrL8RPp14lBLGANA5XqjwVYDA44CeQlS03aDLPGSzTZRJ3+yOkt0Q==
Received: from SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) by SEZPR04MB6753.apcprd04.prod.outlook.com
 (2603:1096:101:ec::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Tue, 12 Mar
 2024 05:33:26 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:8f:cafe::ab) by SG2PR01CA0134.outlook.office365.com
 (2603:1096:4:8f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 05:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024
 05:33:24 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable ipmb device for OCP debug card
Date: Tue, 12 Mar 2024 13:33:19 +0800
Message-Id: <20240312053320.380997-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SEZPR04MB6753:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9854b0af-090a-4e18-750f-08dc4255f07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N88tr0N0oo1qenqFdF8SB6X3L48w06WXAlT7FsBFqJhNXTX2m04AOwdjd03Wh0JIT8aK0jbW12y7y6Ygrq6kw2bo4Pk3UxHqjZwmtsrKIuW1v8/lM7GgAgzk7XpjO5gmRRkKAtwxJ5QDKZlTaNw6roEwWsPc2gPowVWFhioCLhbid4A8dKQMqtvJrl7hhIoRgOL99T95jgOBJt2VMQ0KJkfPUm9z4MqUiRoslAtlyvHuCl/ODSuTWIerM7hD7N+1wrsJfYFXj3Eie9ioc/nxUtlHa9IvhPpz5vrqTGhAGqMN50dwYxEgy7D8ok22J3J2FdWgU0+e0rCrQQgRGyKVKiPdw/1x+aq4v4ZlaQwCsqT+DydjkysnW2LN9iXOGToSfo67lKRqsXXXFQmNnO+fAPjZ5dy1HYe7k0KRJujPLsRkbcv8jb/SM8+2sG4obz0W0m1ZEHB0U+Oby2G1ommGmb8Ip5wRDJIDQoJi4Qf9VcbfMzqNFdcVexDwMytrJCH2WvnA7v7FxSApn6kMKDGeFmSS0qV/XcxPxF/0G3smZlGAPFZN/kL2XsGg+GpncLzSK8Hat25xHcoCoBT+wuIhdBJWB9elumo+uY55TI6pOFgxeLP/zAHD0DJuHy3hMvgHYoG+yEERT6kemEW/2zq/QG2yvj3ZqRzBjkQxzlLj4TvodL1xMjVnYUYhzHMgjbhaUd4/8mD69xianeuDZG742LWQTn8qR6tGgwOvstyq7gMEqje4wXZLUzXj5Y/Ariao
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 05:33:24.7793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9854b0af-090a-4e18-750f-08dc4255f07b
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6753

Add OCP debug card devicetree config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..b944ed2cf2f8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -370,6 +370,13 @@ rtc@6f {
 &i2c13 {
 	status = "okay";
 	bus-frequency = <400000>;
+	multi-master;
+
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
 };
 
 &i2c14 {
-- 
2.25.1


