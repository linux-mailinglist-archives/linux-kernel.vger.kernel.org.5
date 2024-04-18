Return-Path: <linux-kernel+bounces-150614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011838AA1CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4C3286BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7EA17AD72;
	Thu, 18 Apr 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tw/7+s1E"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB7B178CF2;
	Thu, 18 Apr 2024 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463786; cv=fail; b=foxOhhCNSeeW8fUJMKukVIXlIDWsV4XB/B2lH4P3aZLlGvJCl2feQf/H7BzJGv+KEEsjVGgc3AvkgwIcIsr+Zmjl+jZu8PGcN+SEIhfMP4gcBpIdnj7N4L4vwjMmRbHBg4CSTBZDEOyuf5H5uzpUFFeikFqPc057L25KX26aqTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463786; c=relaxed/simple;
	bh=N0RdEHUZsI1zzW6nCuPZ4hZFLMrkfmr6Old8d5fO7aM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=B/sVBPvU3Mk4MugDxnzyxeXLGV4neZaXDjLaq649CFHyFYWCrihhfL3ndIe6Dtp0Ldu+7tsnIZnprRf+A/CXujtu7PklZS5UFwuTfZCr1I0nOYa0OLVxTcor3FaqQJwQTEBzMoQrs9Bmjfa1TiCw1sUEqSwtecj0Wyo6rnXQkMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tw/7+s1E; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nu7ioSpgPdXJ1nZD5Th5xEVH1MWe4qJyQ2sfHoRZyyFLFbebCEujYQYJUDJ9KyOVtIDVVKfOP5BL6Fl+tIUExTYxmmqH2xbQuKPeqVcqIxkv0oIQXAljujkixx2wiVDgl2EotZ8fUv0h56ANI55MTL4+tfLQOefSpZcz0QlTJQJWVxAlJUokFMELg1hyNIYI7MwBk4PlkZMv2ptHLkHyWm9Y7hI+8x+XRzkjQ/hGLEsJDSK6QUSICf/0iq6oATaj9HSVabAcLCGDylAO5D3M6hYfkG8DhwkPLVqFqq0YK8rUnmoeKeDbsyjtoCBUpjGu27nz4QqSI5sRVZ+WjK+zVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7rGWxaI5aeMHq6ZQYbO3rxp1eHNz45A7eYB681GZT0=;
 b=nRzyB8nKyY7vBheXUGitzrPODosed0EoF+MV9oaXwcNfrhxCzWnj4WU76UXQJC6toxJgSib1+f2LpJqXPA1OR6HhiicjXp9fJXuXoT+gX+znF9QI4VHxF+nL9hzI0AjpfATEN69OF42oEFKAqV0ql1l0gbh2hIwvBcYDTZlv3JIcjEAhpJf9nKGFoP1kc4M33BCVmhLoEAt59ssHLilrd7SJHMqt10CuzX/Yo/xKpIDu7V499R9wZNeSvHhPG/m65hh9FC80KdIfearf2+l2LgJh5wr5jYk7AfkcWV0Uqv6SiRApHIwuSJnVpwP9FR5fSagUnZjp36Eh+Il7vbxWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7rGWxaI5aeMHq6ZQYbO3rxp1eHNz45A7eYB681GZT0=;
 b=Tw/7+s1EXAu1A4IChgBqbbs41SRRyX6zddUsH+WTMOLtmclBjPoa9KPovGXM0Y2T4zxsIVhtbrlrC++pXiGs0MXjETqc8k5cTF+/NU6j3k60kLiTDo1McGjxdYSUuoq66mZH86BMs8EiO6/l5eUug9kiLCmhXMjrw9WorudJRL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Thu, 18 Apr
 2024 18:09:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 18:09:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 14:09:28 -0400
Subject: [PATCH v2 1/3] arm64: dts: imx8dxl-ss-adma: delete unused node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-dts_dxl_audio-v2-1-e4e2747b3a49@nxp.com>
References: <20240418-b4-dts_dxl_audio-v2-0-e4e2747b3a49@nxp.com>
In-Reply-To: <20240418-b4-dts_dxl_audio-v2-0-e4e2747b3a49@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713463776; l=949;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=N0RdEHUZsI1zzW6nCuPZ4hZFLMrkfmr6Old8d5fO7aM=;
 b=uOJV3sexnH4z5HvEuH8zD8bOXplmPrtIYoX0KDs47kYSxCy6yYEWKOTgAkb72+qnhWWeUuRaq
 qs7UxaPAacZAg1OzVuLIjWrR2Zvx92BTXERfKMd4jizPsQnEPf4aoCy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e27afb-2a05-4a65-6e33-08dc5fd2b885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	92XhDCHtkdSzo8OGkwC47gBid4nqqpoe7hXOSvBDdTXz+t+J592Q1Q4b4WfOT/jQCH/NDJLmqxx1wqW5fF+g92lVBPhoXvwxrW7NyX0keKJ7Yofy/WpHSAPfkbfO+Hma45ayMGMUp+PEJhwopiCzK7W5OTcGd9TsfUVKIr8x+V3NS3bXSq8L7786yYf8tS2vfoNFyKExbjN7ilETGzMldObXU0ygFzdoumsdtSYvBG0BpzNrLX7UT0ashGjGJf0CqO5ysW2X3flW2ojmWQrwAJizEQm+emeRw/bTa6/1KA0ktSmN0i6zGtt4vGP4pvhVM8gR0LiimYC8NWHixI7tJ6n7mt1/BaGBc348DXDFSL2SA1p8SZvzwPEBmHd2ffEqVzsRxxEgbWPLRB4vOmZJOcrNc3Mm13oD/mT32sCaSzkh+/FmtIsdcW9uV9U91Kai1xcH2bDz9AwDCf3c42T7KOVOsggm6vV5WmqCANS9E1jZ/jkqg5oKwcyf+uRmUxw1vl1JSj7SctkAjpCfql3CcOWJzFyoosK/x3He9qjifSemsrker/VEk/3N1dHtb/3uUS/ytkB+IJGkuWuRKHCXuFoSGU/hUx62f5Q7o4Il/sD2QRY0xFHX+G8nJ73J09JR/oLJ0fKODt9EoHYcc67Jax+zC9/dPRsfZ9MwyffWwxz9Ak/TgmLeXSiF5lJ8zsQtKokxeuRD8Bw6TMMCHtyZC8wo23k7bIf+Uqk0C6UYA4s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmJHVkxCaEJpZkkvL0RZSldHSEZHNE02QlZGWk13azl2Y1F4S1J1Uzl4QnMx?=
 =?utf-8?B?VU1ZOHljeU1xKzYxT0RxVDZlMXRUSGt5em1uNSt3U21XN2RGeVdlaVVMbTdF?=
 =?utf-8?B?OTVrcE8xaFhtbmE0cEE2d0pramdYdGIxYTZMd0JNaEV4dCtxVXNZcGUxTUR1?=
 =?utf-8?B?VGpHWXgxYjNjSnFzbDZCSHgyeHdxeTJRb3lpc1BvempmbHFHNU80WFdJY3Vq?=
 =?utf-8?B?RC9MdWlKNUVCQ0tBV2M1eDJ3Wm5DOTZXRnk2RmxkbWhvdGN4S3NjLzUxckFy?=
 =?utf-8?B?TDlaS25hSTN6Tjl1Q1hYdTNhVllxRmFGM1dGODBxcytlaThxUmp6aUM3MXgz?=
 =?utf-8?B?Y2hiNWFQUE9CV1V0MGxrbmxCaDM4eGxiaE1Vb0xZVGJEZUVoamR5MDNKKy85?=
 =?utf-8?B?L0pmYjI2TndVbllEeUZKVTUyenNOS3dmRjFhMWt4YlpkZ3BRTlVBbmpWaWVx?=
 =?utf-8?B?NlV5NWY2VXpTV1kyRGlDM3FWZWxKYlQ1L2xWODlxeC9HUEpaNFJxY2RWTzBI?=
 =?utf-8?B?MlFCcHM5VHowVHdwK3JsbFVJYVpxMjdhSXZCK0dSc1lmcEE1ZndPS0NnaWdu?=
 =?utf-8?B?dWJJbW5Qc0tXWXIzcnNWSlVFbXVLb05rYkFSQXVSUHduYk9KRWl2dzFOWXRU?=
 =?utf-8?B?aE51R00zWC9HWmZ1ZWgxRGlWSDJtM003V1hZWHFkNVZCUjI0bUtiZUkwd2ox?=
 =?utf-8?B?aFlhMEFuTDZ3S09VU1B0UWYyTEpScXhLYkhZMXA0YXRaMWtaNkcydlZFcE1X?=
 =?utf-8?B?SW8zTnRweExtejZYQUZBKzcrWXRyUEVrd2tZRElnb1RhOVhxdUswM3RLSVVI?=
 =?utf-8?B?K2JzS2hDNVJpNy9Kb3FES2Nkb3U2bk1pRlArMkVNb2xJaENCYysvcndrZWVZ?=
 =?utf-8?B?NGUyU1liRGdLV0FzSGFJaG5xZzBic0tDQ09QcEFNYXkyMzJjRUhKU1F6WFlK?=
 =?utf-8?B?RjRXVjZaNisrRE9DV1lFS2V0MnMzc3lqZUlWdHRFd2Y1LzJaaTRDZjJMMzc1?=
 =?utf-8?B?cDIydWNpMUlxbytiOHIrSzc4MnZCSEl1QWp6UG9JM1g1R0VxL2hmakN2RG9k?=
 =?utf-8?B?T3lacndNVUY2dTZNRkVIUFhlYnQ0MHNSRU0wMUxJQ2c0QkpFWThuNVYzTFFO?=
 =?utf-8?B?N1dOaFMybzVLcG9Ed2pROHlhZndxSStvdHd3cGo1TU1OUng1dHZPR1Z5TUJL?=
 =?utf-8?B?ZEUvdTI0MHVaM3hma3BnSm5XcHRrZ205Ym5PbTBJVWdxSFVGNTQ2K3hCaTVK?=
 =?utf-8?B?NHhLdFBEeDlScVRyQjJJdTVDUEt3TlpBamR1dHBQRUZjZVNGc05qNDcrdFQv?=
 =?utf-8?B?S1JVVWNqRzA2eFZpK3VXUzNxSDlZUzhYRXBlTnVWMmxBTTk1R1p5ZFVBZVda?=
 =?utf-8?B?aGhGNnNaK0N2TmFWNmVQdFZUZnQxWDBKZDdkSWhQbGk0NGNTYUpKaGlrYld6?=
 =?utf-8?B?MWMwUmxYWWV4enNmN2hPbWhYd3BWeDJvLzJyNXMrSHYrUWxYaXZqNU94dE1I?=
 =?utf-8?B?aDNWQXVYdkExZElaYXVHVWVkcFJlVE9VMlBlRzlReUtyaDhLSEZEd3JmU2xo?=
 =?utf-8?B?TFhoMTNFTXc3U3hqWkxKc09PK1Ywa1M0akFEK0JNRThLNWQ5cjVJUWpMUis3?=
 =?utf-8?B?cS9MVVpzQk9jNHc5eHVyWnNrNWwxSEltVDIzN2dETXFFQWdxWjlXSHk2Z2Zs?=
 =?utf-8?B?dUhYRTkvN3VQa0dsR0kvUEhFSmZ4dE5lM2RETmlaa1hJRjRXb2VRbE8zSXFt?=
 =?utf-8?B?aVVRZms0bUNNTzUxeWNlYXNQZkhVY0dTMHlDalJtdS9BdG5OU3VaZ3VRSGtX?=
 =?utf-8?B?cWpZYVRjMkc0L0s4dlRJcHpGeEVSdHpuVzNQeEVuNzJVYTRuRFZwRFZIZ3lq?=
 =?utf-8?B?aGNFSXhwaHVGcUcrdkpWZ0EvVTBsbmVaRTVZMmhuZDd0cnFBLzMyR3Zjb3Mx?=
 =?utf-8?B?NXM1WURDdGtzWGNaU3IralRTZkovU2NncWJVN1AzeUQ3aHh6VWo4cW1wZTc0?=
 =?utf-8?B?U2VlVXZYV0pyYmdHNkZJdlNRNkVLeE14V201WkpudjkvTlRuWHkwUGlaejJW?=
 =?utf-8?B?eVpqQk1rZ2NBU2svSzFRM29EV09ZMDlFYXA5SEEzL0NDZ05qQnJ2MnM0SUJT?=
 =?utf-8?Q?n+A3KveOMUymypP1jw1AmNn10?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e27afb-2a05-4a65-6e33-08dc5fd2b885
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 18:09:42.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4vnbijfcjhv31+Hc5rGXFJrj8UcQTbL2XuS9RSAwBPL6Wd8OBJSQIWc6/qbvXINL1z9etFT0C5zWiViOtvRsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270

Delete unused node in adma subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 5d012c95222f5..f5dcdd9405928 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -3,6 +3,20 @@
  * Copyright 2019~2020, 2022 NXP
  */
 
+/delete-node/ &asrc1;
+/delete-node/ &asrc1_lpcg;
+/delete-node/ &adc1;
+/delete-node/ &adc1_lpcg;
+/delete-node/ &amix;
+/delete-node/ &amix_lpcg;
+/delete-node/ &edma1;
+/delete-node/ &esai0;
+/delete-node/ &esai0_lpcg;
+/delete-node/ &sai4;
+/delete-node/ &sai4_lpcg;
+/delete-node/ &sai5;
+/delete-node/ &sai5_lpcg;
+
 &audio_ipg_clk {
 	clock-frequency = <160000000>;
 };

-- 
2.34.1


