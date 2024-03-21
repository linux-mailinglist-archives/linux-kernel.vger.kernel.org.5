Return-Path: <linux-kernel+bounces-109566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C680881AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805531C20E84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C36A9463;
	Thu, 21 Mar 2024 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Nd1rp0JH"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2049.outbound.protection.outlook.com [40.107.215.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE2479DC;
	Thu, 21 Mar 2024 02:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987174; cv=fail; b=tSy+vocYdyjEpgym2bAKAFfuZtoSb9KribbZfxIpcn+qIRMBUpKniQjq/u3+ryRZ/D3MPm0gTab8ZqqovMngb6ycAqE5GvLAq8mXJxqRz6ecjI5EjFE+ibfC/yteg0K6B9PI+pLPL9xyeyu+VzwvFPz3Lrvk8s61+47HweJGVBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987174; c=relaxed/simple;
	bh=0uqavz9LrMtQsZ0CHtAlV5c+czx2PwnIw4YXLNZBMzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qvac5IkdtQUEqdvgTuVFfBY2G2t6iZh7HBAh5uEQCYJowOjldfoGg57gvEeZgLuEpoERc1LNK0hal2UmtWNM390YNcafKMQy0CIO8oFuv4mQYeD08mNfWxM51yPHFd2lfDEmxs+hnvF0Go1Ry+o0JsMq44Z4jGPyKqcLrohtkXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Nd1rp0JH; arc=fail smtp.client-ip=40.107.215.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsTanZagc6FwZwV5LIjfFQ+RkJ9BGq5RBuZD71rKG3slwcRrQc8bq1UrNdkbLVqM2icPmSgGjqdq9EcqUJTNR0NviCNjsVkdQ5XuKgML5RXuxYyoSUyUlv8PaxdCACgpxFyJAej7aM3H6nf6ZHUjThwCfoll+SxHopXPiT4WrVXvvAJfrkBOF/9q85erfXYNUgh4lUnpr+NkaAaOHRY9673aUTIA3pMMxynvDgp8G5kzSRb6rALF8Y9huasmD8Z3eIbhkdyl+laLQkkn4WGY+uQKCJLADRLV1UhtS5Vjx8YhKed9xcSEfAQ2JONDXAm1Lxw5iclSiUzNQYIAOAAblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kCO11WdUiFDfGWanOnHA5fSAvcgtGuDJsJBtZQkii8=;
 b=Y5HGknlpe0DS+4vPPLU4CQ1HuhEz6fLtyz26mX/l3bv5Wgb+U6v6MR+PfyFQLGvVQsgspdLifD+A3uoh7BrdfBLxukwX346NklvGKauUf1wS45kJAsdjfTVU/Ux4jXxjfw6bKP+HmOsVPkX91auAQtEHWNBvPCKZDbJXApaW6UJ6N6Dpw0aHHESMZ/A+r9tnW2QzZPTeCxzLF/xSNRr71XBvcZmtYh05oLNYELNsxl5Tt7dhtunYeTFZ8ZznRuEInOrTk27Dbyunsd9v0p4yMbHWnJlrw9tiRCVOjwe6MRo7KJ1+PY3yhaNpervb00wJA7aSvrKHyfXlBtam2Ul9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kCO11WdUiFDfGWanOnHA5fSAvcgtGuDJsJBtZQkii8=;
 b=Nd1rp0JHUg+Gk3HCjoV3K0ZVfbngCYu49gQfdRYVG1tBKdKhMwdOozc4EszKZOUf8hdmVodcnfaOJ37o9PX2KKKLbPcUTfMfG/TcuASK0Oow1ewoieDDUBU4ovoOujG40Z717C3yQu/STtzTXAbamnNGca1S1ncT7oot0fJHRbyUyvProbFWL/CO2jf/iCdAuJUgtVbHy1SV5Zv+SxuwHIzP6jry71LZpfduZLW20JUywjkDzkt0tEJxGTv/YF8AsdJvnNp3CrSXGYPfb/zb5qweI6+lvnLaECxPsZFjezbljw9zgdf9c5gmgi1qnk/8R/P8cmnL0aetBgp68WBq7w==
Received: from PU1PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::32) by TYZPR04MB7453.apcprd04.prod.outlook.com
 (2603:1096:405:42::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 02:12:48 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::cd) by PU1PR01CA0020.outlook.office365.com
 (2603:1096:803:15::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Thu, 21 Mar 2024 02:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:12:47
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
Subject: [PATCH v7 02/22] ARM: dts: aspeed: yosemite4: Enable adc15
Date: Thu, 21 Mar 2024 10:12:14 +0800
Message-Id: <20240321021236.1823693-3-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|TYZPR04MB7453:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0f7f9706-3d8a-45b9-1ac4-08dc494c6732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xk+ykW2Ml/EwEtICuGotzSRmn7emVFdUB2jSw8QCIjzdRu24A2fYTS02LVdNdf93e6WrUUpl0p8K5hKv9/fSOgOHYNuCKgJzHFKtzyYEBs7kiFlkGaXF+yehsG67a939YfkXpeh2eL73N2juBK5UKce1tXynLhGaOvggMV//qLUn9wOuis/RhO4SXORke2hxB3cbTIwvjE7hRi6nrQxkihksaq/UG+6Kzo1koAw8FlA4LFm2aDyvJSV7vFnSoe1k3GLceaTNiSsQBldv9cXZMMaaGK/dV6FAQeGcrkWJwvdhDvkq0U9H7Gix7ATqx/VXEH+VfqOSiwPMEaNpw+/bTsf/reAaeVMMw+lqY0HYDyRrV9tS0BYQ4oqw88TuZd7eBLhRFKsRNoXQdFY1Gs1SIIzgWi8/AQSoopgLsoTtYO2PhvlcEBkZ79efNFM1QCOM7Fe+2lkhtO4RZ/u48KO9gMtPb0aNnOXWTYkpBu7fd17/UxrPH2cWAy2WYtHttggoog1PVWl8bDiyMsyPspBcKZkhlMgUQpD8DzdQBS2tOhtL6shrgaJ4ZzwvFeAoR8S+eQHb+B2vFk+4o0Xd+qQ3SYn80wVB4J+IAu+Uo7wC99KsXYuynZ9ShnJbQHUhPBHnkZDpZHzdpEY3+biMn4sbGIFbglhr/RxbJDNcUv6GmOU04bvoo9JciDk2B1J/bw+2E73l/ajSZPH+SKOOe4Ac9JBgeO/2zBvYomV9ZzLgdpHdl/juDPpX4wmq08Tt7yFg
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:12:47.5259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7f9706-3d8a-45b9-1ac4-08dc494c6732
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7453

Enable Yosemite 4 adc15 config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index dac58d3ea63c..6846aab893ad 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -51,7 +51,7 @@ iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-				<&adc1 0>, <&adc1 1>;
+				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
 };
 
@@ -920,10 +920,10 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 &adc1 {
 	ref_voltage = <2500>;
 	status = "okay";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+	    &pinctrl_adc15_default>;
 };
 
-
 &ehci0 {
 	status = "okay";
 };
-- 
2.25.1


