Return-Path: <linux-kernel+bounces-109569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3470881AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A991F2815D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1CBFC1E;
	Thu, 21 Mar 2024 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="I+wMsoKi"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2053.outbound.protection.outlook.com [40.107.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B88C2E9;
	Thu, 21 Mar 2024 02:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987181; cv=fail; b=Q7Zro9E8LeLh/9Z1vYIcrhrKtvUf3BXd2z7k5ZBxRMhw8/O/dpjzooTEkpdh7nPTAG/2c5frx+i7gMkbfT3eEfFDlQ1JMsvNSyfuePnvlDn+AvK7EKosOzeCPYts4i0/fQMTmC8N3tCkawPrbRT0McCu6Nzwuxrm8ZIW+ywC4gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987181; c=relaxed/simple;
	bh=Os6OESlbEh2WOR1Xu0jRO4O8qHSClljUQ41VmT9VMno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sA+IBY43dL9iLagT6h7u0QcMF/yp3wy50MmwgIsOWr1xBIafnKM/pAiDjv7kqmGmRvRYOKP8itwN7g3AIjBHU9vbTvM2JIVYm+Sicg8008yEam0sNTd4Fp50e/6aw515vwdE4xqvrqsF+qEBbXzyoJxytmgSFUeh6FxRWJsQSi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=I+wMsoKi; arc=fail smtp.client-ip=40.107.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KR74mHQpcf2fGLzzKW8cgRYBLGKtCfGAjRUfyYZ6G/+SHPcKLo8/N8GvGIrr2auNt9okwGPlT2tkxFZhuYII3n0GMenZWFLPFfSG9pob/cADRxZpYLcZ0Jbs65eUAwVvLXppPP/NL0kxleR7ea8GBYzVy947t1fxFyTzbEV/7G738wTFzj3Wi0hLzu7xe3T19ujt1qSAsKqoLI3f7sFTm7JwcWiVCEMbFdyQ7vLnjEvhhWOssHyLUrTx0qj1qz/51lQS0LSlUUj7ajbEP4mmsIufHApyAGJQurKwg/42juQPQpvWvRJnVgsHQ3/KqwUTZJWCfrz/3svDRWWS76b2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+rCbKa980zvtFSL+aiZSLIdHmQc5ZtQwhUuhOWMtss=;
 b=ghCNvsRsuXH6ZN9qCu2qrCv/F0YXFTwQ4VGRN/RunPcIXq42bYrtonhluCynMm61Q/woIFUHH1Pod5odG5eRnOoC1G7ZSmCyqpcZO/9ivCyXPFDFHcdGfCGaTk/TLYbrv+T2ovnmW3KlNcgajc8NptmHXmAswfCbr90Ci7euLMs+rIa62j6R9u+hnKSxK7dguBxqcpr3x4fBfhfzTcKHnOognRWunzVkEBN7R9g3Mj4RiVL8achhh75mfJfypV8xi8sz+Nit8ma1m9Gtml/BhnFz9yuo4RN2Ytksh5iUunQLSQ6NdtuoHcAl8zYpaGX5JS98jKoqSwSdRIR8K+Os7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+rCbKa980zvtFSL+aiZSLIdHmQc5ZtQwhUuhOWMtss=;
 b=I+wMsoKiYsxqEbwgHVRiuhKN0x+Rx7nKWYBx1RFxkWn4gVIdo1yzGVKIxs4Njd/PSNQOpjoCQplrQ+d+MGpzM4UbVSVbdebqpO8qHdRuiKBfarj0a0Yxr0NM4OLc3j+CkRmloRa8AtnNmsvRvywSVSK5SycLOh0bmlqDbc27h4lIrCv9DYdgWdTXX/OhUUjenhLlhLa1f/sG2ItjZD179q56G0s6OtkRTBWYso5So5gABd7q1RPPCRDysetdTa6nnbCu9C1YChCT7ie2j4p1vAV5IqaqEH+DmGgp9Lpq1n6pJJbqsjJ8ZjUBKdjvVxS2WhVeaSqoih93XmWw0MkMFw==
Received: from PU1PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::20) by JH0PR04MB7943.apcprd04.prod.outlook.com
 (2603:1096:990:99::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Thu, 21 Mar
 2024 02:12:56 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::b7) by PU1PR01CA0008.outlook.office365.com
 (2603:1096:803:15::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Thu, 21 Mar 2024 02:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:12:55
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
Subject: [PATCH v7 05/22] ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
Date: Thu, 21 Mar 2024 10:12:17 +0800
Message-Id: <20240321021236.1823693-6-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|JH0PR04MB7943:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7cdd5808-378b-4311-93de-08dc494c6c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WISBBR7BvLxxJtpz9wWl0TZ0cpK7wckKbu8ktU/jd9ySRIQ+nIA88tV2AIeOGFpSinovneuDuLaGD/nL+r+y/SH2ENPFePMiOFwJrFYzE+sLoHNLr2gN4XEwadu9M7RXGS7kUrsHbaygMKDDIDU2775Q1waWFgECezPE5aDd9s7PvbtYqrkWZRsPr0QwQ/GbvLWqnTspM4yNolQusnZwTKgp/iHGGcQ9NcY11fDv6EeMif4VYvz1dMFV601P0pvodWeRSEoWtL9XN8nAFfcXThSTjGS7/Nj4AWNLP4NJXAjwTMCrbUJMkLruqGNl2y8q0OUyY48F95BL0csRqmnsBltXgCF1h+had0f02x1Pu6f/n/hkLjZwLbPdT3g4LZszbXUbZp54VvywUkbj0fjagoWtUXO9lkR/hELpvAn6s+1Y1dhA1S5t8B8piKia5abLtGzbOomzWsepo8DtVRCeFyrRBRYdg2hT+jPrDSoHIpDfQJaWyRBs5pI0AyNXug6fCSmpVUFSiLoXPFgDaPwHKRSsoWjHmlrM0a9qQQ2umL7oX/69yFi63qLTjafnk7ALs+/oiJREulDDmwDorwwJPqWz8gRNUm5ifFqhzH/b7lK+iesTQY4dN+zFtxYh/5tUIQ7jJyG+/lpiAiN/BHFANvUiZJzBLy6HTO2/EzHdqDx7YmMrgxMUJSzROaD1l/oP5u1UOwLrKQsYcd3kgT4/24FmRGmd+ZnKZVJmd5xJutP0DytA/XSg0pXBjRYS46gN
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:12:55.7603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdd5808-378b-4311-93de-08dc494c6c1a
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7943

Revise quad mode to dual mode to avoid WP pin influnece the SPI

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f8bfdefbefc6..23006dca5f26 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -149,15 +149,17 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-64.dtsi"
+#include "openbmc-flash-layout-128.dtsi"
 	};
 	flash@1 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc2";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
 	};
 };
-- 
2.25.1


