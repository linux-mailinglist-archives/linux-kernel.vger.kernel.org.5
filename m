Return-Path: <linux-kernel+bounces-109572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB73881B06
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA741C21027
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0D92A1D8;
	Thu, 21 Mar 2024 02:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="U9t6CNMF"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011005.outbound.protection.outlook.com [52.101.133.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85ED29CE0;
	Thu, 21 Mar 2024 02:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987191; cv=fail; b=Hwpps+soy/uMwkVBZNb/oXqzQcnTp3MEmqgpfRB0PERbCrwLW11vmqHQCu+rdZCTQjf4txNMayDoljrasPMcGoDSrMPYt23GbfZz2DGOSP2NMvQR8GNXm3Q3EFyvNS4zL0mExyNq1jLUiH4d/toQfSn/f90lCfCzDwtugmtmIZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987191; c=relaxed/simple;
	bh=E8enz+Ue9oFAMScnGONDQHk1dwH5ZdG9YL9KJq4tA74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbc/3Z0F/RttLmPlMbOyTZPGdzgocvTgvzXCnGscOm08MhfGdVolHkMw23hSmMXOvK5/TgXDSM87zZHtbLda959Cf7F2FWRgsijHGau0bCYB6gEK1FELw/vWN0uCja9QJKaboyhqzTnQ2ABsKRSkjMpW/KPBhEF0c/NyRHfjmm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=U9t6CNMF; arc=fail smtp.client-ip=52.101.133.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEVu71/98K3NEq4EpRNa3mqmrSFVZuWwLuqmrP+hyAjOREcmrLvw48GW91PrXEVbY4rT8c3dbxIUCzioE9n1pF8s8SDMckA070AVwTRDULNrCQV/zzi9Xtta/2ZGVce6lPsp+gCvUzeC05uEDlBoOn0zXtPkIyjPbhUPXqZceYLYxUr92XHmgBpSAdDchqoXL8HeyKnxuwcrEe+8hJgXsOV6AXUJVoCRMlUwAFVLu71pJX1hZjszVvOzL1BIaIxrvZbpe1rpyZcSfcLHtHdPCTPmQAknLrTDqCuaRYAE6COJPJ3LhJfqDxlHXqQ7Bpbk83PolQh0C9nEWiLdA8kyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBt3CofCqwuPAgo+xufnrGcsk+PA9Eyy8aVBCoVNz8I=;
 b=F6NO8L1XRjv5CmNT1ArFiUVy+66397C6KB2cIImhV1aocR9Wxxy1Rq8mwxQBOoIlP91F+/G0nfXOcNuV84lnYVtb51QsiYrOHe406/to0ZRQhYpWoJCysVNIq/oGRSklHVrbBODEI0nr2XXX55Je0JQdMmArxO693tMrkA9/PP6tjfnztUCBnxIojoEgm5MAjEO9sJjB80q5fRzBAxnlTK71ZT0KjqWh+qYKAiLlnE4wTmOZtr6D1k7E0A+nqnOAyCQavzUQ2k5QyKeJ291N31jZmthkKIvsnrnryvSSh+39zRZuBe2/Vb6O58pC+BahAYp/aIPMUDu4MuPNmRNzWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBt3CofCqwuPAgo+xufnrGcsk+PA9Eyy8aVBCoVNz8I=;
 b=U9t6CNMFnorfwd4VcRyxUp90HkwocyDytR9Y12UrPVO8Lmy7qOX4lL6MX2rAoi7nr0nKF+ALXaafM4ZCBojZQgsxC1x1Z6Y8JCoH7V+VQzBpJ+v0KwXUIpgsY9H9hhLHrjLlWP7JvAbcW/ODJbN5vt94oMsOZ6uzbbkTfHdsSn7mnLj/k/LDppylULi/BRG1njAM/J71WDc4nqXoM2mEAhhWoVrjl/9VVmC2tuEZtaBBikzTsyU3sZnby3+wRubMFKpjBdIegA6eze4yh0UnECFzuPVPCE5Rpeza/QB7XSJ2zso299tlRU/vGjhoO8Ksp+afJOAGJ1iwZFugdNfkeA==
Received: from PU1PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::24) by SG2PR04MB5614.apcprd04.prod.outlook.com
 (2603:1096:4:1c1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.35; Thu, 21 Mar
 2024 02:13:04 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::e0) by PU1PR01CA0012.outlook.office365.com
 (2603:1096:803:15::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 21 Mar 2024 02:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:13:04
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
Subject: [PATCH v7 08/22] ARM: dts: aspeed: yosemite4: Remove space for adm1272 compatible
Date: Thu, 21 Mar 2024 10:12:20 +0800
Message-Id: <20240321021236.1823693-9-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|SG2PR04MB5614:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6e9c43c3-8cbb-424c-1f87-08dc494c7116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/IqMczxJwfZspH8j54Bw5M8+7P/V02w/VV+NC2ZANYpEv8YsvJEnORcvftLfMJrGq219MM6b/t+P4dICJXF6OuKf7K/v+cg6fk0X9eqYKrrIFdC76nuTaFMGECWLXcFeXTl4PebZzWbYKb4njfSOQsz/35L86WxMuKFuQ42avIVVW3LL2jJ9ihYEAjW0tt0KOR1vypzsCdqpQ5EImTLtDsaunstWagAvyL6NRSQz7En+RbsfasJXEIwt2XmJNk+o8lKxNHiBGOgFsx3j89bwJ9/vIokMgVqMGbOAP86yahZEV4vTEtoP3TvXZuOaNTsbT26ypJPrnCAoCTvUvlmu7KaoUHvAYkMsIWIzqpWjsT6Eg4AY5e1Tveo74WbkYyVnkmxxKmjnZHDx3e8+E9ZNM8tfOgsfy4LHbctsImkGV4dd92q/FgTmM2a2VZ/6miKlP6NTMEtlZGP9m4zalY7ZBZgIpvJnhV0lBG7uk4vyLAyn2YYBRvgDYv46sEdmXYYt+fWc9i9JxnCw492EiipXumf+EeOiNVAo83jBqk2ZubMgf3IDMINvdRqNRwDa+FUIRyosjxPIV6EfvzIRgPYuT2LudF6/85sTab30Ks3xEdCMElSKJhI4hHz0nAeiYAhuAkU7p+7nrpqllf3LU9fayhfk8nrKqgGIwuy39CfTU1mt9IIX5IR+R1d0xwEs0qkPMkK467ldp8ID8nE3qVfXWhgvAuvtvBeItGX+5p6VDbs2zIZEp/qGhqWiX/gT7vS1
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(7416005)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:13:04.1197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9c43c3-8cbb-424c-1f87-08dc494c7116
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5614

Remove space for adm1272 compatible

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ed8f529a381e..f6527f0dbeb4 100644
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


