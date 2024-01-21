Return-Path: <linux-kernel+bounces-32056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9F08355CC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E367282328
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9CF38389;
	Sun, 21 Jan 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Dp9QC2hp"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2080.outbound.protection.outlook.com [40.92.107.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F190381D1;
	Sun, 21 Jan 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705841034; cv=fail; b=AYl+JUGqfP5ZoIqIjM5/I8AWqQ2vT9x5I3JwAJ39+rhRVMudkiwj1aeex/4Sgf4lPbBHiFsrQ6Ju+8gwk+yRrQJhCGTM6Fn6EqDe6zEABOXt/0blAZ0wcI4CM2lGEfWOWjJ+0m5w7udZmH5IyOWGnvHREOt2NtdmtpDfb5jBmFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705841034; c=relaxed/simple;
	bh=kASF0lFs+lu5Mv7AkCZPyWMUAdMlfb9iv6paQNSxHrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t/P8cil3prVcM//k6xwTH62AInazwK38CoDh5LoOhhz/pRYhV4UIn3KUn5xnhpsEsquE47rQjqtJd2vLQPlfkZh1oQiZjJDk1pYBqUdfpMvtQsfmec6FA3UgPvAdpJo9y0Yu1gHeTyigDf/ViSNKh7nn0tM0NDupYWrOL7yzM7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Dp9QC2hp; arc=fail smtp.client-ip=40.92.107.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2/oBJ3Me3CwmzfXNQ+VQBfYXBWHggBcbF+79VgoqRHmFU1jE30bX/xJ0DZEVwUew6eW14u1mzVznkLunhP2Is6iBCCKsG9GXkhHdWgKgYXRcSCGOAiN8fAgYshO9kM7hemWKwNJTN5olvQcLj61icN7S2QIZu0nWNSQrM6wZxVZR/d+EJ5xHgNNh0eWN7HmGG0T7lQ84c3+yktyeMhfrOa/HzaonU7HXzfdVtXIgh8lnkv12O6/e7cU5nJ4Ztamameaap2SyUyxBKfq6KdetCb7urxIlzPm3P23S6wA8xO3CgyDv8Qi+x/arAR4mf4dGR9qjw+B1mVQxF1d31FZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CPMIzkdmf50QazUC/wEjqlzQtV064B5Hgfgo7BjzRE=;
 b=obIZjz+m3nPY2iAM9M1S08rlqXalt8AH8A1uu5vYNLF3U6pKB2ydLpE21XqaK41Cxr79zV6iOnQBzn2zci0CHmoe9o42mubQ7v56VlwpnYxioUzoPQtHI9cNNvrqFb6fx49IikKdQAJY2Guz+uqWpCC8iK6EbId79zVry/v8YUWxpBL+znxnJjE6Gg7F+ZufZyiiI4dn6MBxGrlvDtYNbniWtFKdwWxbXrTMsusZ804ThqEeHP2KzlURWJu+xBxJFW4CrEbf7jUIPbpxVkZ9egY+xOJdzIo/8M7AOfP2R0qYvYUPyGGaEbdIMgfq2SQVJbX4m2xkk6A54r3y65SPnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CPMIzkdmf50QazUC/wEjqlzQtV064B5Hgfgo7BjzRE=;
 b=Dp9QC2hpQNy+7YcGbLx9UHSAlgL1TxZF0yff6u5gO3A8mMnf+QpfYh2qlV8hDpNdz4M5lD+0KBiEQRvNYufqkEo62yMQcx5Fyp+EprwvzDSFJ561Box5tDDze8IECS6DX9Vh4+iH+Su4uSha/YA4mJKZkNK7PVWdKo6YzSa5+UvrPxktfkzArAwqGOZqQ4WwaMno3qViAUMRvux++0zm5vUS+IM1ZSoccMZTi32DaF+kpQnHpHII0tY4iDZlamrDky+7uxvnYNK2YuDnZUv171ZHBVCmeO5aLuOAUv9bCy0FQJsTGctl57WO/fFLW4ZOGALjT6DkaHl3XXhMf4eBIw==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by OSQPR01MB6119.apcprd01.prod.exchangelabs.com
 (2603:1096:604:27b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 12:43:49 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0%7]) with mapi id 15.20.7181.019; Sun, 21 Jan 2024
 12:43:49 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: mcoquelin.stm32@gmail.com
Cc: alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH 8/8] arm64: dts: qcom: ipq5018-rdp432-c2: enable ethernet support
Date: Sun, 21 Jan 2024 20:42:37 +0800
Message-ID:
 <TYZPR01MB5556D3E73D7F7242F810F915C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [2qElDWZdksYkyOHEY7OFc81AJPO6++sP9sL6QwoTbGpWTEt6sYOgLg==]
X-ClientProxiedBy: PH8PR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::26) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20240121124237.3328702-8-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|OSQPR01MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de4b3fd-4367-43b9-74b8-08dc1a7e9d42
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	89AleL4TQzsaGy5w+smUi1gHMQ1XHYqcKyQQOF6xsdRI4npKm9i0WOVw2Rrunl0uGmPaKQPxIfUP28rua2ZPQRkd6hcp79p716QP/VtOO62gnivd8wwpEAPQ7jzuTC9Jz9Yjg14FzetKRpWpfo4nU8sptIzgkc53INmprTeQcOw+mBTZjjf0yF5l83RTGzVD+A8tLLcSA1K/vvD0IwYLcpJsL4aGsArBj/dUPMQNfNq4pp8DqQ+6keU3f9Nlt95Qfl0MmbdOKMX4UBBgpUE7j8OP5/UK0UtjN6X2vkIsXQp1BGcBLxhirDCX4IyNAfq9+jqVyrDis41yj0NkOH9W6mP/vm8KDdRIqC1yXJHy55ZbGzur0PvBb42hOZm/nKM63or7OTPUpdQELLhOtyL7oAIA4nyHg974EpTaJ1XlFYy4j9ngvqYF0oeKf/UAPAjd2SzrtLojAeyBp1VMobdlBs4KQ6dzA3j1fLbuzo/DxGgH3rsc12IjITWaOZwbu9mUrlRpMK/8CJrXNWg9WGNmKRIj7xTbEuCRLMSKIXA53Zy7TB5rLJLgB8POYRLMDuNYAxsHWC7qB560DN0zCZjme4XEDvwkjMRrkJyPacSKFPzHGuIqKvCQdrQHnx7hZ4r0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qBErEdBP8zmN2Hp9yXcLqMGfLEolfkJlkEUDDzL7UNxzYWLD8mNxwbVnULav?=
 =?us-ascii?Q?2xW6oc7Fj7xPnpJu7Q4yFjONwpVjGHkpo/EKf39AV17G1H+MU6494lKG8JM5?=
 =?us-ascii?Q?sTVCeQ+o/q3vim3WT4wAk6YE/QWGDh9fCRzvfo3dDxVcKx31X4ZPaH8Uc2nS?=
 =?us-ascii?Q?W7ydiT17Dedn7FzhAVfFSrYs+HnmE8JfIXlRi8E8PYsKLoSDbJBXlsLVDNKR?=
 =?us-ascii?Q?QwQo5QfXNiqxZw7xhBtES9DbFO9d14HM+QuVwgL2g2UEtjdMz+5wOE1njOnI?=
 =?us-ascii?Q?8XssP8aRopJgbGOq+bsiZe2K7CdxpU4m7do6TravzrLT8g9f5YnyKkCRJUH+?=
 =?us-ascii?Q?FlCcQSQWS/mV4W4R+5ng+0ReJDW0x1X/ooVuXOe7oEwbvGPmtNh8dG8vn6fl?=
 =?us-ascii?Q?Cd7CHpy8CChGigH0DLpsIyp6C1lZTk9239kRT/nGAhmfTamtDilYtbLM5MyN?=
 =?us-ascii?Q?E4/C9WTW18y3lDjLlZkwSmuTaGVoKAbC6x0H9d2zKPawmrveTA/tK6h/sV/i?=
 =?us-ascii?Q?Q1Pc64jhEQUPr0GRTAybKweYXsy1iJTWjo1RPnu3HfXuEzU1xn6aJ4e6HH0H?=
 =?us-ascii?Q?WepI3lRoKsKWdcmmSayn07tamIe563VPjMMS1yYh8UUP55WGFn1dI7eizKBg?=
 =?us-ascii?Q?RlxtkxoL/GevzCOpiRKk6DQmiVZIrkfN1jT+cx0LvNFJIhmkI8kK4kr24mZd?=
 =?us-ascii?Q?nY+XjlvZ2BenGHAELMqtwT2W+oMexFQ/g3ZmhU/ah1zvFH2/e7WeLbOOgGjm?=
 =?us-ascii?Q?uo19PkyrseQ1Q2H3m8N0ROHQ/bCL1Q9zfD9fkkr7ezsus0VV2sGIVRQduwiH?=
 =?us-ascii?Q?fRfxYOIoQHyik14xrptLnNEpwIXaGv35Gd04piQxVw5goac5Yv8FSyegV7/4?=
 =?us-ascii?Q?cqbwAaAlB8uW6z1LNN6LWLUL1OKfg9eYxgyoYrgYIySM2tj2Bcz4vZESr0Gf?=
 =?us-ascii?Q?ofJ9km1fG3be401d2uplU09mYLmpMecsaMGlxOPE2U3vIPgPrrqx9Mg3nrXy?=
 =?us-ascii?Q?DeF2uKywW7et/zkOTHVwDGptNqOkLczedCWkpqM6DAonCjUTnUq5NhHRIg3y?=
 =?us-ascii?Q?OZ5r/1FL/ADeUkC4DYIstIdS4Ft7B37DpZs9swJ/jzgXjCfvSEmYwDswbFVH?=
 =?us-ascii?Q?4g22rqDtV0mOwp4xhvdQRky1iKWNI6a0ta9zXRdjSbFC3hgNJ98H5N+8Ug01?=
 =?us-ascii?Q?7y9I5BpPlqyEpA18Zr2tZH/tkqwJjJRDHs9sKX6q0/C4faIr5xfOHKhfab1w?=
 =?us-ascii?Q?SdWMYAYs18msDN9XtJLN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de4b3fd-4367-43b9-74b8-08dc1a7e9d42
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 12:43:49.0312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR01MB6119

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
index e636a1cb9b77..074b78d7939c 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
@@ -15,6 +15,9 @@ / {
 
 	aliases {
 		serial0 = &blsp1_uart1;
+
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 	};
 
 	chosen {
@@ -43,6 +46,22 @@ &sleep_clk {
 };
 
 &tlmm {
+	mdio1_pins: mdio1_pins {
+		mdc {
+			pins = "gpio36";
+			function = "mdc";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		mdio {
+			pins = "gpio37";
+			function = "mdio";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+	};
+
 	sdc_default_state: sdc-default-state {
 		clk-pins {
 			pins = "gpio9";
@@ -70,3 +89,36 @@ data-pins {
 &xo_board_clk {
 	clock-frequency = <24000000>;
 };
+
+&mdio0 {
+	status = "ok";
+};
+
+&mdio1 {
+	pinctrl-0 = <&mdio1_pins>;
+	pinctrl-names = "default";
+	status = "ok";
+
+	reset-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
+
+	qca8081: ethernet-phy@28 {
+		reg = <28>;
+	};
+};
+
+&uniphy0 {
+	mode = <QCOM_ETH_UNIPHY_MODE_SGMII>;
+	clkout-frequency = <QCOM_ETH_UNIPHY_CLKOUT_FREQ_50M>;
+	clkout-drive-strength = <QCOM_ETH_UNIPHY_CLKOUT_DS_1_5V>;
+	status = "ok";
+};
+
+&gmac0 {
+	status = "ok";
+};
+
+&gmac1 {
+	phy-handle = <&qca8081>;
+	phy-mode = "sgmii";
+	status = "ok";
+};
-- 
2.40.1


