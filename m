Return-Path: <linux-kernel+bounces-128321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6A289594E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D13282DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AE614B081;
	Tue,  2 Apr 2024 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="Hs8PKm3e"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036214AD38;
	Tue,  2 Apr 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074129; cv=fail; b=A5WvUAci8zYbtV4k4+VtBWTux7ODKjEmybTwg/Ja1LQy4BQda3rDOHpZpla9WS/Fvkqbjfjn7D8OQ+QBLBEtTRzcK+2rwANEc9KAx+OqXAQ5Qx8Jkn2I8CsKTP/dnRmkS1jQuLLFxMJ/4ra9b6QQGS8yHE86jHfXm//QRAhG7E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074129; c=relaxed/simple;
	bh=8N/haP7/St1ra/XnNx1SPtRCDNyQy09x/TgZajujdN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bpco7pROa7AhGlCzPxwrMBPPcZVRQWMDotLD95+vNweOQxkqypSbgpZ2iK8g56t3h6FZOARXjnzq/X7GKIyO1b3qHFRczJrUOs8Yej6p69hDmcRpEc54tTtxm62KPLpnp2SjpyzqbhFouUptMu5/4T18yIbjEXI89zZf9B7MVVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=Hs8PKm3e; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7Ln5j40zS+4yQcDl8gEi5TVbKu0gEZr8vkGFizK+KDOK8qw7xWnYQcyq6+mhJSV6EefVwgtslgt3j9wBHCPkINaPm3vR7yw3icYqtpqO06RJztzeUtJ1BfJh0MXIaJBw9PbcVmWPx1Dp/PklRUgxkukAJzQgJJV0Zs2yxrGtaFbFnKjJAJFR0mkRsBfbBHK3HelXcerDmlkpuYhEGEgQEHeFrJPlD6nrsGHsteHssDpfh7EjxCK+fwwZLCuYEvYKfKIOURtIEhyua4Ychb5DOdJDTfXYfZSwdEcKqp5+WmZ652LQCZxnfKDnxbOlfnBeSB92YFIAMI7wbc5UkcH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LisQD85ZxGEEXiBfRJbLVGI2siGO7lDslU5F6WvU7gI=;
 b=cNnxvdc/niGYpEYQYR4W53lNkE/D3PPw7ayWlKaTx4W0QU74bAaaYXe0jTEoSDmsih8bidkVLSOuoMurXbTPkY0PdptLd9bXd+QK4cT3yebKZuHoC80xaKyq9z92/V64T4jEQ6CdTOycyLrQuT6yUAYpi82Y7ZLRtMvQHp3PCtkZ0qw2GsUUKLge7DfFRG+w5qG5YrqBD+dd8G2JdeZY4t8H2idQyfhpiPZWWMNomsHsgbPwvYtE9FzONJ24PRcDeqhZBPlS916YzcR5EQpb6/KJfBZR2Rcs+nxXVylwaBOJmV9s8OSFmSvQeDAeXngBrKd1RhmOfwFZJZOa+YffwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LisQD85ZxGEEXiBfRJbLVGI2siGO7lDslU5F6WvU7gI=;
 b=Hs8PKm3emXr7YJgRNXApQNb1xtAXz5vRw8dyFsT/wJvbTYSBW8/hGoc9ILuaW23jiY8ATNFj0CvY+/Qg8UYMjv4W1QOxkMbtPNvlYrRH51FYpPWkoQvn7y7VHRYnekHzSWWznlWqa89ciifYX5P2AuyqZQqXZ9RnplT3foYbc8I=
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by PH8PR22MB4097.namprd22.prod.outlook.com (2603:10b6:510:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 16:08:40 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 16:08:40 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH 2/2] arm64: dts: ti: k3-am642-phyboard-electra-rdk: Increase CAN max bitrate
Date: Tue,  2 Apr 2024 09:08:25 -0700
Message-Id: <20240402160825.1516036-3-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240402160825.1516036-1-nmorrisson@phytec.com>
References: <20240402160825.1516036-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:610:b1::16) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|PH8PR22MB4097:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vat/PJL0CRXqCGGRKiL+WI3sVucJeikZlP4dmfEt6n6yPMryGckRdX0OG6hsgmW8I8pUhv+PFJU/3ZURBK/Mq0OQ6hiqkfVfSzPb9pD/XDdgLCnpq7mxMUuusUiJi5p8QKyz6SkECVKWs9h69PL0mqBiTW/u50ZSAh9eK3zt1RlIWSJscOWoRzY70PikGW/+3NvolZa6VZc8v827uUDwMvx+xNP1LUCQ/KIhH7nhujwUA1DrgYvXsz3/m+rsQgBSLDOa2oud9+qkE4phT7dw76mgajwXdbm5ojcoTcgJlu6dBB9I9LxpGgjs0KouBqP+sIpb6ZGgyia/kASAiMtwbEX87BVSOQOjedlwqzB/gn2JBGtCMGBcGrZ3/uCep1aTtUY15q2BBdL2mZWD0QaeZea3epHE1D44Rl6i7tgBPOmlVaFNHDm4J0Ludos5dbpWfwgRRjj4AG3/x1o56y87lJUI/VDdVPHhtlLb/r/8deXJJGcRBOE7X25KAZuLMqr9sbo1grQVJIvKLWnmc+Ng+IhpZzUupJfC2kKSS+mTSSZ9z7aIQ5u1kyjP/bK1MGiDBu0iIQpkj0AICODwdnDQkcioYvhH9MRyfrdmCLOgJSR9xUEOjy2sNxdb9O3kLyUfpLAh0rGnCowuZs1KEU5allkdkACp4dQc6T7Uzy3iz5MkTP6Kv5vRCBloygolM8LjvTkd7RFKjXX8pLiZ46+lmNI1mLZbcNjBKSsB728GiTE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9UJ/MyFCDOp6WymHlVWnYGQgGP3wehp7/VXLuZaGhXajGXlVgMaPC+ECEjTU?=
 =?us-ascii?Q?HHvNl1/LPGmywtS/dRCP/HVVyi10wS5g1MV6w5J6acBUTLkDZbAcrFX9VGkl?=
 =?us-ascii?Q?2Yg9qE8FhB/ONU2ms7QuzFZaVMtUi2ubmTDPHg0V4WtsaMQSA3IhNT2t3JvZ?=
 =?us-ascii?Q?StxNpGlub2j51bR0NsDeg573F3AconcQJ0hjL//UL5adL7WsyX53DpNpdGZz?=
 =?us-ascii?Q?6a8xssh1pp2Rsaz+fCVbRnWr/zXGJMSkukouXE6I1sm0mCBJ3n0rkOnCr6bu?=
 =?us-ascii?Q?ETN98vvj9wRGbFesau7mLrXP3PfKmLBxpuZ0omP8i1C9yZ/asoE4O0FeCGWT?=
 =?us-ascii?Q?nH9aMHFogLV2J0RyyMjshn2VmZ4Qcq8I3y//Ai7lKcRl/qILMQWWwKTeEJ9X?=
 =?us-ascii?Q?NJDcKoafgO6KjrgC/3n1YyAcPcDYa1JmUQfDOKpQeb0sAQCafC33HukVqbWv?=
 =?us-ascii?Q?eBY35SWSQPYg2n2/Pe+wPf5U1hj3R/A8DjQPUP+6KXgk3Nx9u1nAJqyIL2kP?=
 =?us-ascii?Q?fmoYRHP/FHRfM4IZy6rNjmKb0H2Dnn6sgqpJ8UZ5RhcK4N7tXd4Z9P+uT2dH?=
 =?us-ascii?Q?FQPJHhBiOJ2aMtmvDlE+aDEWGaF0o99o+2KQs+Qjd6Ku6ET754Mu03RvZlJ2?=
 =?us-ascii?Q?cjun93EU6mAkQkjIjZsmf8oBdPIhZrvZlWkAc8JDHGIbTaaoLabRTgjfQXaU?=
 =?us-ascii?Q?qRNNT9WQKZr/or6a6SBRd/FWUIHUO653E4+uA4u+Po0FgKoFghf4a8MIqDS8?=
 =?us-ascii?Q?mSuplQb95Rvjba+OnH65ms1Xhl/2WFoHa5HtBP6xxkCO9NC4WVN+6wIhPeN1?=
 =?us-ascii?Q?mQ5wFD3be3s6ncBGbCLr7Dso5cYtfqOWo6Mg6qDjXYvCMivCSgSgbljJu2Ld?=
 =?us-ascii?Q?qB0NiTtkcSRZBd3APhtVo6FrTLft57tCdVtv8QW7pr0XC75eKTFJOdxvR4xY?=
 =?us-ascii?Q?/yjc2PqqKbu2lotEWKk1YDLKhdbTd5+qIj4OlglO7x/zBxbxr1O3uogaJcH2?=
 =?us-ascii?Q?UuYsstFyMDIwsFsZ7PkA3cE8YpjC+wHAmCLhhJy/s58gbJoxD1P01kqztxTW?=
 =?us-ascii?Q?847dvW13JQz9Yn/VYGD28iewwJJQyOXNUVAA85E4YJ3HFYL6adkkD2MH6AKo?=
 =?us-ascii?Q?pv68E/EacORIkm/K5Zc7PBRfk5VYpbSGLA6mRcy6ywNLwtBqNA5uiqIXK7fW?=
 =?us-ascii?Q?8A5JVYpr/IhtPl1Ee5RuUw/vJJwNLu7Rl5jTBsXO4/AecakyauS+XRP0R+GP?=
 =?us-ascii?Q?GCimuwB9LBxcOQtqum6liamMJe+1ttcH2TnLXKnBhWx47djTZVoOoI+8FHsG?=
 =?us-ascii?Q?KO2rMPRCeMQ/CqtZoLWx7PoSWiEN+CFIiKJj4hDH72zHeO+QC7eIMVR5Cz3e?=
 =?us-ascii?Q?5O6Nkz0ZRzeXZVz7ypjVMX6x7p0ASMpFDSvLJ7kH6RKG0/XtvefL6foPHhsX?=
 =?us-ascii?Q?O9HMBctV4cbN3ZNrpZqNQqf+jXsI+g7G+LWYt87oyvhdRGU6HBXByxzJKb/1?=
 =?us-ascii?Q?NUR7kIO3fNYDLfg0zPf2+pdVkbRUN6MZWBihHjc+OroRIwAWYRYA+8B2B23R?=
 =?us-ascii?Q?aE+e0tKrE2/0jR67NFPdIGFvWnYDk9swKXB4dG9K?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f68b4dd-9d38-422e-6ed6-08dc532f2921
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 16:08:39.9805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oie1GjpQ5/b4/Pg9hGf1RqbPRTJdu86btWYLRWu14S8YAr5+MB01FT//uZQ0jVY2X23Fb8ei4nSJg4cIUQVedA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR22MB4097

The phyBOARD-Electra has two TCAN1044VDD CAN transceivers which
support CAN FD at 8 Mbps.

Increase the maximum bitrate to 8 Mbps.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 8237b8c815b8..522699ec65e8 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -42,7 +42,7 @@ can_tc1: can-phy0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&can_tc1_pins_default>;
 		#phy-cells = <0>;
-		max-bitrate = <5000000>;
+		max-bitrate = <8000000>;
 		standby-gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
 	};
 
@@ -51,7 +51,7 @@ can_tc2: can-phy1 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&can_tc2_pins_default>;
 		#phy-cells = <0>;
-		max-bitrate = <5000000>;
+		max-bitrate = <8000000>;
 		standby-gpios = <&main_gpio0 35 GPIO_ACTIVE_HIGH>;
 	};
 
-- 
2.25.1


