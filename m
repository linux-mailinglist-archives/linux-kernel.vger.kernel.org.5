Return-Path: <linux-kernel+bounces-99877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77873878EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FBC1F224A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD035674E;
	Tue, 12 Mar 2024 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="d/YYMUe4"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2084.outbound.protection.outlook.com [40.107.215.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219E55E066;
	Tue, 12 Mar 2024 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224214; cv=fail; b=VOFklFBns1mnRQAXvaSa+14ATyAt2gSB5c/VnqVVVK5diyGqsDTFwLoNzsfdSeU0UDiYywqRJM9wsX3vaU8trbrS/D6CvzQkWHKMNHKSMNPH8g80KbcW2MYq3HRjx9ShfhKgLnliYihEmv+bKMhDH1nw3pYDfOoy8e9BpP7tvrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224214; c=relaxed/simple;
	bh=blhr6PvAdyVePsUOz88+Xl/xNJgf8daI7R2FDHYZg0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fX6vIE0u/sidmAOpRnuHJE8TTBYjT9KhKKaB682MDrVKV2Qp6g2Q69Gov8Hah59QwBpj5h28ew3O7RgTkiDH/ky2gHIFlE6tZGndgELRwCKzeOmHKLkdEaN3FP7453GgKNO4Ynns37hnKFL6ZcdrPmrmbRoG4Gd/M2ht6qY2vao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=d/YYMUe4; arc=fail smtp.client-ip=40.107.215.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZ3kCz6kfXn0gIVBOSdnhYIFonjXF4cbn+dnRfN68CZKYF8bzp7hc/2Vlh71zX9Mt4zu2F5/NK7Jbp2agullmW3+2C7Zanaaxj9TzG4fTev2ycFh8rYDmg3XpUELNNpMWct42ErnWOo8CAVvxNeE5yfTHC06AWvV+QuKMVFGGPSSfI7SnxgFXcTJ7bZQ/5KSuqRBib8lTua00ydN5p2qTS+u/qbTkR6Kz9C/PGADyoo7LUExXLmtOH9g1cYZAAn8hALvO7mAW5JUusWNQ5d1F1hQDFGvJ4j27j/rb2nHNovedxcymhUkq+Mq1Hi8JIOzgqzi3w4I4+yQPH9OfmDZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beZQnJO8EVDQsB6FD+WDIWhawKeQLQfwrszb1xOyP/U=;
 b=ONzJdkHhZLv72X/mpy52neu9/lSCTxxqCOa612OwQ1QKjGxt6DsftoUN4pqcGc4eyzDlnFjI1hGtj5IBfNkG6ik4JOCofuykfG+4W0PyKhVSJYZLjZwh/vbpDr0FosmKnBDuoX6gOt4aJefszmYDQAwNgq9TWTifZtxcljISlI6mb4/pyh1eCRmGKwiSC/JOIeawZmJMdm1p8GFTkIioeHZboDoIqFR/BL7fAL1eJQEPqNEOochK993jmKlVaqjQ/z9XpHURkwL2p0ZifarE65N9I/GEfhV8hASabuR1q555PqCdBDVsBCHgbuEYPI27lEciNpB3T2Wd7iWWuYNecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beZQnJO8EVDQsB6FD+WDIWhawKeQLQfwrszb1xOyP/U=;
 b=d/YYMUe4b4BAPKxc1I5Cd26KhL39scHg4f6a8TE5dv+VBUERjPxO023rFm8UJpP8cAISFxuVciv9Ec+90ovrm8pSW30hUEz2wla3trDcnsyciw/yYgB9eDiLGyd0eTkZE6ib7CV1/KuXSPl3uqHK/+iCSuC2P9F8ZK865LTvdTVoyQLe9Bfc/YWtGuB9h4P0RDlKhF/1IsimK98EwHGOTDPBHmmc6Le6ttgTf5xMfELkITaHXuw2sDn+cwTCwPRAbfe7fnngTR2LJI5nBa8zGLAZKKMTDFm/gKgDKKXzhJE2w+vsjTywuMcTF9SrNmkWziSAkdxuk2DyUIkpoZcI8Q==
Received: from PS1PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::21) by SEZPR04MB7339.apcprd04.prod.outlook.com
 (2603:1096:101:19d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 06:16:46 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::40) by PS1PR01CA0009.outlook.office365.com
 (2603:1096:300:75::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 06:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 06:16:45
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
Subject: [PATCH v6 13/22] ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode for yosemite4 schematic change
Date: Tue, 12 Mar 2024 14:15:45 +0800
Message-Id: <20240312061556.496605-14-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|SEZPR04MB7339:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2aaa9c6c-64a6-4f45-07e2-08dc425bfead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S6bCtIHHEGCaWHnhKAhZIo7w0XpeHgrp9XviIEu0U1Et0yvVrv8gSvzCqAEvnv9I40+/Mk7qrlbKZ37TTazSQ56fSLea5m5Wk+KwHNSdauifEkjSatxON10KCFmc71kI1cwvgvy2s0GdQDbCZ97ihDstDX9hHeY2AC94whvcO292dbB2IFWcsTlxY3HHj4/IRWIMH+mSXMsROt2v41lLhtJGCscNW4G6X2Cv4XQ1O043lHyshfBbvXSmOCGlcr2rHFnOWZrtj83Q7d7Jun4epBS7S31I7UlS9ao5f6dAtvs1zV8We23Dknzuvt+YC6Z3YpDVM4SENW9Uh4hEvaRjZzEAo3YtNBEK8cHc26XdjhBgQ9l6Ajmo5c+ElRfLmRvIS+pgBvOcR21vI9bBZ3tbwacyRDPoR+D9MGYI3sqDFt0HqU/prCwPlpmSvMuOyZmJtzADoCYAjyBXjwQf7p0P2YAhm4NZ0LD/EkCq6GFLatBL5QrU3qio2q+3IERj8mAZu+8nHC8BgzHz3KLVQlSzWlQ5UUPXk+Nw/qLg8uvmgAHdgawUNviTlZM+uQ+Lu+LWdqbn19HH7E2aPDAwSneD0teXn31nfXwbq7f5bjEut/wYlZDpqFo0LMx4K97SeCSnUl7bRUXjQhl69M9x9He3dZN33iddEpgxnks/bOumpgwj7+mo7aq1qNCvrPwAZyzKja0/XBq0HTQOVoNw9iKxHNrvBQ7FywmCSLk7R3fAMbYkEv2c8iF8Mh2Qw0DN5UvW
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:16:45.9790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aaa9c6c-64a6-4f45-07e2-08dc425bfead
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7339

Revise adc128d818 adc mode for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index bb4cba8f057e..4cf4b0ca1024 100644
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


