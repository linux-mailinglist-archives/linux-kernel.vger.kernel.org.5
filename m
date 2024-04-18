Return-Path: <linux-kernel+bounces-150506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D728AA040
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14562B26516
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4C0176FB6;
	Thu, 18 Apr 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nqoTdKCA"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34A176FA7;
	Thu, 18 Apr 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458235; cv=fail; b=feMBVxogNrTsuMpC1KWAEW9cXpwe9tS9ntb8dCvOQxYBi3oSptWuZhkena8Ph6yMfQ3S7fOX4+EKLB1bazWI0Y5Uw8xAt+Kys8/rXRg8UZB91VYvZk2ioF5jteSETn9U3E1M1XHSLHCUKYM04U+ngdj7KDvUL0tholEaUquNJwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458235; c=relaxed/simple;
	bh=/qWkdmCItfnkKhql1UId37fRHLMvXRFCRisuxFSzV2U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RK6JeqVF3tVUm9yG1POTiSKyICxFE+zf/1A6BnfcHlgZQkAy0cWCqa6OFQluOgHlC1p85cG9MvGQ01DOnd38uMXP9gp7TMcf3ud3keEVdDEerGmqUi2Q+c+wfMa6MPxRXEw3mqtGfhdjxyOvRG7woWWSLitLVrNSG95ffVVpegQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nqoTdKCA; arc=fail smtp.client-ip=40.107.104.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLLWiCrOydwZ1ONwgeyGuusYovHNS9iFz9Z/R36/pNXV4/Ohd7hM4PYTBB+g1bwXhusU17j7omiKe2jgo82Y3Nd0bD8kmHnp3goO25wQdaxQhmtsxtsd7aC9yz9jbE92p5tFfOxYj8a9IgDmIeKa4p+7Q/llo3WHTHdCM4Dj5zJta9XSR6W30zqr3UBLB1UZhtgsFC90K8dgyfGu2gGnaa3rjXu0aT1K9Pb6fts1hS4tLp6qGXBzn2uEQtFvtlVfm2Bp9S4QbKxwZsnvDBtitaknp74Q+ySya9QlRDEbEVvJ403RXaqZj3sGKMm1Yuxy0Bhxm96f2nxz6A65dY9qYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bmjb5ouB4TJNCtZ+fxOU9Esx1teP5G5L0i7ZnunQiOQ=;
 b=YaWnMRNE4u7mDaKuCb1ugPoZKR4MuCudcoDzwj6I516fKj6jy7KVy2EHkUNF0vL3yPTGzgdWT6KEXTNxB7Pd2I6G+ezW/7WMTcJ+BLwN8xFbMOFOO+XYMfrVdpVaMedvRkWMVpsEZJRfJkfyPqSkJO1Gm0AzQMH7aUbxjc7i++k9vis0hUHhZ63TIb+q99phhiwdo9IbRcKYZcRhQ6bq6sxWfixxaNqYVdhIP3pczDPNoC+nt2iQCjWSCwsLT1h6V+7RieD7clJvhFEk0OX1F6P+lficvwWcEHTcv9xwDvh/bL7AonqO4xFm47RRnQz0p58RZO01P8WvCvZLROIpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bmjb5ouB4TJNCtZ+fxOU9Esx1teP5G5L0i7ZnunQiOQ=;
 b=nqoTdKCASxL7NocUj8NasEpR4wf8+sdMVTdin2ah3xLwbAFUkXhegE6m9zPBf2M4pcCcojPtNp4H/OLFY6dioHQYR9g7YZWRN6Z9x7QChUV4l2069u2ev6XgPW3hvWCRZyHTi+l0UuuOR1bBJUCwA0ZlAqau+2B4GZT68io68Nw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7079.eurprd04.prod.outlook.com (2603:10a6:20b:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 16:37:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:37:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:36:41 -0400
Subject: [PATCH v2 06/10] arm64: dts: imx8qm-mek: add cm41_i2c and children
 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-dts_8qm_audio-v2-6-e40fe76b60a6@nxp.com>
References: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
In-Reply-To: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713458209; l=1328;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/qWkdmCItfnkKhql1UId37fRHLMvXRFCRisuxFSzV2U=;
 b=JJIzZ7sYd+Yo244L/4gnJhCj5DJqeIsWACVQowvBN+uLZwBG9XYmGYigWk1XTPhCrdwUh+Z40
 cVxtceZbn4ZD9jGOUx/4gSqehnjEooKTCnlBB+dy8YVRkuhLxdDBm1d
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ef8b8a-04fe-4a42-f05d-08dc5fc5ccc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6VV5SWVdh9QJPiuNuUrgVvFoiBOUTUdoC5FY8grVIyvAIv/hB3WJKVO3gKfNpDZHPDyStsPg18L2c5r6AL/dP0R4YnZDf3scApZptrcdQQsTGOtu6Zm0e8nShRd3f1VqaRrQkZi8s+t4t8SzT9sRGPbdLr4nq2tHhauO9YAT5QrIC18bOMCBUZMZFOTcBnrlUJY8bz5l+vmLjDGScJgAlawe63IQhSGTS8hAhtQzuqrEQOcZizHxvNOwT9r22SNFw2CvEx1z3ZxNtp8U0Ag3J/huBi08vywUKXhneyB0+nIFwKVL+Z5PgJ3yHb4OhQHB1WX0cBy8nQj9+aeQkYyjd2c3Xp6kGk9KlM6CcjXBEYhwA/hbvMw6WsqvBVD+wcyF79gUiy+3b41p+oYYfxPnBeaaAtUbvGP8YYtEWrKtk2lYKgng2dtECA7v3YfH9mk1Dr+o0fCZ/vUOMKg3YZMelddTZ2g1OJxJaVH7UQO8mfF15gr22OqFfeRfp1UVLyWXnhMQuAvgljbPDnbRM+yPetNUAAyW9BYl2G7uojPXrXyQ+Nr2hvWGsYqgyFYVm6QeFOBI85VafezsJq3hU6FhcnxJrm9+xPbibxU6fH4TuXtoilYnJAr0qoRY5xaQ6hMiXMJEJK1ENaEY/DR71MkGwY9Wif2EcgahrbfipfQH1f2hhTZYzRkZnpYnZQbk6MYS/6iB2GIpTRsVWAuRT00q58JSPR4QObxHzP7+7EuGvhw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmRRT0s2TXZwRjlhSmVIYzc1RjQzL0lqZ0VybzFIUzJHbldZWVFzRWF3clJ1?=
 =?utf-8?B?TXV4L0k3S3ZnNUo5elpCenJqM2g0Ui84T0pqRGFrNXl5QkpUdU1ZS2lWaXpS?=
 =?utf-8?B?ZzdIYVRTN1VGSGxnYjEreExPTmkzZHZCWWdoYXYydjlPbTdoWHpZKzZoNkVB?=
 =?utf-8?B?U2ZUYzl4ay9naFpUNXhGSmZTVVNXS2RRbFlqY1FPVnpYdnY2cUtYNGY2bXFs?=
 =?utf-8?B?Ly96OGk5UXZ4M0FMOGUvZmZPcDVYNE9qSGM4Q1paSnJWeGoxNEFmUENxU2hm?=
 =?utf-8?B?dDhzay9FRGg2RytzQTRpb3JHYzlhaVF3ZnhpNyswckgxbFJVcUZCNUhKV21X?=
 =?utf-8?B?cVE5aC9rK1FpdTRUN2plSkVzS1RZczNhQzhHeXdMMyt2cXJGL2VvQ1c3QWF3?=
 =?utf-8?B?aFNWYmRDK3VuMVdnVy96RnJJblR2QTRiNHloZXEyK1Y0bWRULys2ZkRyOU9N?=
 =?utf-8?B?N0pIa3ljWUprQUZCeGEvUUprR3h4YkpYVkNKVDRwUlhiY0N3R2FYdjh4ZHIz?=
 =?utf-8?B?blpPRWVwOWkwbHJGSmdYSWw2V0pHcDJzYTdGd2Zvc2lGUXVqK3NJUXFQYk1o?=
 =?utf-8?B?SmtsRHpuU1pqY0Ntd29ZRmJ4QXhEZnd0T1k3eFNjUkJjVi80NStmVVZZQUc3?=
 =?utf-8?B?cjd4Nzc3cmdFazZ1OEltRFZLczdhQXk5aTZrVFlMcWxEN0YxRGxVNXRSTWRj?=
 =?utf-8?B?Rzc4V0tFb3pqUVprWndUeWk1ZGdoUDUrTlp1blBjOU81T1FjQ01SM3R4Y2Fs?=
 =?utf-8?B?RHpSUURhTk1HbEg3emxva0xra2hmakdSM0R4Y3FIS2FIQXVXOE40NmNWemZz?=
 =?utf-8?B?ZC9HdUtuaEEzL0RqZko0SGYvRnZld05wek4zWUwrR0RTNDlYVmdiQkxSN1A5?=
 =?utf-8?B?Sm9uWHRnMHZTam5FdUk3cnEyd2FGWExnejhrMUUzSW5ZZFFVOUVPUkxWWTRo?=
 =?utf-8?B?QlVXNWJ0Tk4xaHdMc29KYnhRUW5hOFdLaTBQN2RzRTZQVUdFWnp2dWVBdHVy?=
 =?utf-8?B?NE8wbmJZR01WK0k4QkVPekdtZHBpckhrTlAwa01JdDdTWWlXR0VzQnNJMU0z?=
 =?utf-8?B?SlBXRklLZlk5MFdlNGRFZkZPQW9DR0VoUzhLVW5zZTdTaFJkS1UyYXpkQkkx?=
 =?utf-8?B?OEROUTU3cmRPeDloQjBsWm5vTDBFalJlWUZ2N2tPTURMVDNLSWp2Q0xVWWMy?=
 =?utf-8?B?VmdXUERXYTFEWlk3OWw4K2JobjFuNGJ2ZlZzcSt0cnI0aSt1OW1HaGRyS01C?=
 =?utf-8?B?WDNqMGtISzJ5YUx6TXBDVzVqcENlVFZ0VnpSQm52cmx5QmFDR0t0b2lKU05y?=
 =?utf-8?B?WVFiRHFWcVVlamRyVDZ0QVk1L1FoalNheXd3UlRYZ3ZNNGN3Smd1bSsrNWMw?=
 =?utf-8?B?b0xscks0bFMvblZGditad2dLZG9ERnVwc2NEQm9yWEt5dFZKaEgveEZXdDV6?=
 =?utf-8?B?WG40UTJzZWRJQTlZN05XN3RzcHA2RkZzalc2ZjVlbEY0SlovaUJXWkpleWRU?=
 =?utf-8?B?cC9vQ2ttL3p4bzRmV3ZQT3RUTzRqd0ZUYVY3cTg1SWZiL3JraWpQanFlNHVi?=
 =?utf-8?B?N0lsZ0JLNGFzdkNCcG1walVQb3RLdDJZNmJiWmE5UnVRa0FBVkMyMG5GZlVO?=
 =?utf-8?B?L0IvVEdLNFlwMXJuWFBUekNwQXJzbkhucFkvSGdoNnFFRHZVek8vK3pFS0M1?=
 =?utf-8?B?dis1Q2kyV3p3Mm55cFVhU3BxM25hK0RLOWE4WVNPRjlxVEZoWmFpODJvU3I4?=
 =?utf-8?B?MVhScGR4cVBWVHFnY3FIRlZ0cFJuTVA4STRvcXQ0b0NpWUVlV0c5Vm43aEhC?=
 =?utf-8?B?ZUhrLzdERDhsc0VtZHpNTUhoVXRDenlLNkd6QnZOSXBPbFh0MkdzVTJNQUkz?=
 =?utf-8?B?TWRSWi9UM29WbUYwS0RCVVI3TmFsdVk4OS9TTnRmelpuOEFTQWlKVDNFT3VQ?=
 =?utf-8?B?Nk1sUVlNd2pCZ3JXc0Z5RkRHd2RrREZmOUF4RDNQRGJiMGVpVERTWm9YaFhI?=
 =?utf-8?B?d0pwUHFneHRyR3lkcTl0c3J3cml3bGNMQkh0TG5Pa0NlSW1kVngveTNkUzc4?=
 =?utf-8?B?RU85bS8rSmgyQ3lJZEY0MUdYVGpBQzIzbE9FUHpkSjU2WGs5SnNRQzY4L1NC?=
 =?utf-8?Q?1XvicQIdXv+PVP70NayMXp2y8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ef8b8a-04fe-4a42-f05d-08dc5fc5ccc2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:37:12.9139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4030GP/MhB/xf+rVmu/NQuPdcWXYyh3xu0NnsrkIUEHpFysYgsZTkPtdxCmLuJQhWyqaPHnexiiTIoWJQbsdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7079

Add cm41_i2c and devices under it for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index e5740f301bde0..765ff15b16410 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -222,6 +222,26 @@ &sai7 {
 	status = "okay";
 };
 
+&cm41_i2c {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cm41_i2c>;
+	status = "okay";
+
+	pca6416: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&cm41_intmux {
+	status = "okay";
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
@@ -353,6 +373,13 @@ IMX8QM_ADC_IN0_DMA_ADC0_IN0				0xc0000060
 		>;
 	};
 
+	pinctrl_cm41_i2c: cm41i2cgrp {
+		fsl,pins = <
+			IMX8QM_M41_I2C0_SDA_M41_I2C0_SDA			0x0600004c
+			IMX8QM_M41_I2C0_SCL_M41_I2C0_SCL			0x0600004c
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QM_ENET0_MDC_CONN_ENET0_MDC				0x06000020

-- 
2.34.1


