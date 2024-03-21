Return-Path: <linux-kernel+bounces-109568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E832881AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70FE4B217E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FB5C154;
	Thu, 21 Mar 2024 02:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Vv8rQnCO"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2080.outbound.protection.outlook.com [40.107.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C647DB64C;
	Thu, 21 Mar 2024 02:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987178; cv=fail; b=Y56Cdbz1Xr4cfaogAXBRGZ+RHjfV1m+vUmoNAKiFIRTQdqsqAE7NaL9Bo9WsChX9PBIkShHdoGMtZ0gDeUQ6n2pu2RmwTukk1r9e05QT50aoZ9nA/pIdekVgn2S0QXkuIHIERU7fDXzcEWgSZlGwAxyLTsWR0SvBqmP/54uSQic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987178; c=relaxed/simple;
	bh=hqXsYu7NJ7eb+I4JR+cYXqAEiSyMGWeSrIHRdp99mFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NiXX+pZ11Vi4xpJyX41hVIvv5Z2mpI3matGaY4QLlQ954SmSlbTBqoMCDr0hb+nJzQqvAd0Qcx/RXMmiAEWV0VQGILe3anp9cGx9hSH0nXCCupEP9jEmFIX5csnAZK0U7BA9D2hO6KJ1uH8LL4H/BHxE/Mqhbu37V3v5JYmlGzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Vv8rQnCO; arc=fail smtp.client-ip=40.107.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VryABaB4vDB6Zsl1EqhrGXZcz4UuUi4ATFewvqLdtk2V9J8Ts6d48vx4j2Pn8rtAMTNYM40o+5l7iGhuhNfv5VeL8+Cl5Wf6lCHfqA88qkqh/7l7kAEUe5qsDz7sKENkGjKk2fjsiqzqPlSQPx+EBbxFAzNTXCwyP/q0cYcK9H/WTdVt48Xx54gfoBZkcAAm6OHE9ewo6h9Xyziz4aHfiDYvP+1qOxHPDsaPjtnmoUwq+J/S4FfYuqVlKOZD8P1/+pIWzZpjmLfKHcpZytROaFQZDWhDJ9kjtVER96QA5i9c7z69ZeTJxMs7u+Hh5+ILcoDJBRGrQ161DBkaUZrWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5ns+z/bWZune1KJ9Uhx7h1a0Q+DT0TnpkyUTwFsiqA=;
 b=URy1cOHJ9RFPJS95vPYj7XnsLYNr4P3Xqn2r1iTZ9lGRl6F6XRE/jgEykQyqEegtkgjGpuau5/nbrQ5d0EuqT6zP+w6vBjBLRneKBTecoHGSqQN3T8T7kCOYdon9H/KtqtNWRUtTtV5K6dyR8qCi8uXnsV8LSpfBmsmuqO4wWGe4N23cQVq7vN8cE1vNfm/EcLomueBRb5320kRF65RhGmblHHkWuONBctBYO+lRBQ8WP4SQ/VttwZB97S+dccl9EhevPvRI1PY8uFKbmW5zRbvBqYNhFt4SUPbTkJjiu+m9rKNOvog6i51LlX3apGPzFDrBY8WR7O+F1XIpJ9QLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5ns+z/bWZune1KJ9Uhx7h1a0Q+DT0TnpkyUTwFsiqA=;
 b=Vv8rQnCO98aTS3Aub4wl0pmuACCIXX2lEVhshlyNrEaN8JP8VKWEBucUy+s91fVLZsi1LUMuudO0P/wDl/Wzps9GDI3Sh4tIlKgWCSrmeSiPEdG+c4Jd8CjAuT0WxgBSS9i5Bxe3xUor+PIHN6dviYUc46DPhcYnmQaRkvNKX7jEFT+v+8EeC8owXjUR08dx3BLv59vVEBThar3KxulY5DCdKV3la869qiTJPXGDaenxxGM0BuoRStNQBNYoTdCQTNmdiiJ4TrbCjZPVdVYrFZwvRuSNumQc6wOaHh4P0MsMyvtevTBNTbHmd83C0ELfeyHqmFqJeig5/V2OLr1STA==
Received: from PU1PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::13) by TY0PR04MB5741.apcprd04.prod.outlook.com
 (2603:1096:400:21f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 02:12:53 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::1f) by PU1PR01CA0001.outlook.office365.com
 (2603:1096:803:15::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 21 Mar 2024 02:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:12:53
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
Subject: [PATCH v7 04/22] ARM: dts: aspeed: yosemite4: Enable watchdog2
Date: Thu, 21 Mar 2024 10:12:16 +0800
Message-Id: <20240321021236.1823693-5-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-Office365-Filtering-Correlation-Id: f810ffe2-61fd-4669-7ead-08dc494c6a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DIhCaaKddddgCmlyI6MhVINBfIaP/AJb/yYAccS6sETV768bHGsnGkogMcRDcIazAu/YZ1MOjXyKJtVytL9XkDl6pHpZP6exgKazgsnCeutdmyA9FryyJNeH+N+t0cyzGJ4L2Zsr4yh4WpzKcg/hKdaWiE3U1N1U5+of7FY5j+//aMflvsFI6a5RhhCyw+cdCK8C2xqO7RD/sL9uVfzYS1j1aT5rct+YC4TV0mdYePMZv/92K3K7Q5qxtYwR6KBKXAQONAIvjebycHmxURQ996PQBA8j5J26slVhphy6CKtgrPwEBxPHV0Tst4tNkxAMfSlppzcoCEqWk0tLAfqTBJAX3GkfUZZLjWGthNtb5PRDDzkJWDoVF4zkfdI+RhmoK2otffBy95Hg2M+Y6dfPoEFf6sJ5l2zuk4EHUCuL3kG44XuVsbBkQjRwKEKdQlZOU0hfWu7wZ8xcLL/qTui8fzE3KAkS1ctuZzq5UbwzDaZLEKZpB5N6QqSLk+SavVuG5+UpyksH3dB89IhrMXhd9vx1NexaTOgGWI8dp9JOHqgauJzNPUPTO9nRDagCmBUYNgCuHMIteEV5MAYOns0JjSzET+jIVG1n7JOsmI9v6to/DLlw7Dgtp+6+vRp4CIiPe/qola3DrxRiCMety4FoLor82C4r9C6fFLkk7LkKelxY5Xzzx0GyWjvlGeZnwzvScXDrKB7tfEUgh5gSQWfspzzGMVFjqwUwRUBbsurDqw2WfaBY0iXPAoaSP9pUY7dd
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:12:53.0728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f810ffe2-61fd-4669-7ead-08dc494c6a80
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5741

enable watchdog2 setting

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ea8fd3ec0982..f8bfdefbefc6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -120,6 +120,13 @@ &wdt1 {
 	aspeed,ext-pulse-duration = <256>;
 };
 
+&wdt2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst2_default>;
+	aspeed,reset-type = "system";
+};
+
 &mac2 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1


