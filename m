Return-Path: <linux-kernel+bounces-145842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 845198A5BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFEE0B263FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD5116088F;
	Mon, 15 Apr 2024 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A1AYH6Fj"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9901607AF;
	Mon, 15 Apr 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210452; cv=fail; b=EzXMADAlIrjmhWX5u4hUECCHue6BOk6blH005o7OtBF/Cj7qrcoUj1P8ccBa10YxsQb40tpW/nMRdu5KcRC3WtZEMAI/5XGRfrwsp1/EisOB8PZH4fWT7kdDEd9lPGHkghmAAbZROIs/RepVwedk4+1FCCttCCu22bOenrcEoGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210452; c=relaxed/simple;
	bh=t4lCiFcNj3UHNmOa4h/pQJmxZu+XlkdXWM1ZPKq/yHw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b4+uty+/HIirtOIxvkcGGDzOAPve1xbu3Jj3FBOfvDPH+1GsHDypnfZbgzn0SE7NkxAC6EOr6y3htIAqsyjqFsaDpqG5Q3WsdUlVJ4f854NyGjMQkbOdlNz6br8/xqKTkjyWXHsGKIaehHJ8VzfEapKKw0B4eNM0BTxeG4crAzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=A1AYH6Fj; arc=fail smtp.client-ip=40.107.105.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr6zUwASHbJIOEpy6oya9uQsq2YxrUWQ7/JfVmLcH6of2S0gJ+mGK1b87zTGS6Jf60CS0yz74pUfsRkD+wah4y1hdseGOxjDyfqTc7p1efdkhpZFAVyvmC4sYrCksRU6Gv8hn4kQSuBUpS4RE78In/5tBDbKOdh+6UDFL2wzg8FXH5oxr5ipV6p16ZYeRp9Ow9FkyBxnYe5ZsKo32r9EjjygfCZn10CmeJ2DuCiltkPQ+O+ldn3Vz8i3OF90ivRzg0SajgZQkk6OTI4WyDjS9pCGQ89Eg7lbG2kt0QwTUDOe34icWdvTJs6SsspIhYvwfde6dSLq2dc56R/lrPLxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AT5ezCL7+cC3MS/XPtKS89P1uMjqR82y2tq0aQSNBo=;
 b=jKcLQB8BSR3CCB4KreA6IMb8JEMjDoa4dKp646IszadiapfxFsSln+7ReSKBWmTLuZOOnwU6uYYHzr80DVfxtTZjJKVXMqXwUYAthSgzjmshoRvCkSi3NM4Ai3dVdE095PDLkw4wfgfiRiX8Mv4kh//noYbVUV6VhSgGh8ix83loNB3Ceyn2OYC6WZ20pclanoqLx00NKD+KF74NQebt/X318zX134o1mxfbgr2WKJkifdQEzbVGiETJ8pNa8fchNZD4VciWaLPH67v+1qeF4E7V3G/ZIcYuuLMqVjdPlveRAJycdc0NX06CqQMB+nL4YvgaQ43t9g/5W2H6mpySIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AT5ezCL7+cC3MS/XPtKS89P1uMjqR82y2tq0aQSNBo=;
 b=A1AYH6FjN21c+jp4la+H0e89PNAUdEc1drp9rvm4sV1pJYq9eMsB5VXHd8BXR54pH6+SgR2hPIg3+LC1YcSnHSu0p5hLbycYnsaElZ/lmFzIDFpTgtyO0UeVH9LWtLDLjgHEBx4n98ZRaIDwBUkm4dFMTJhXggvyVxm6nN760kI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7328.eurprd04.prod.outlook.com (2603:10a6:800:1a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:47:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:47:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:46:44 -0400
Subject: [PATCH 08/10] arm64: dts: imx8qm-mek: add lsio mu5 and mu6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dts_8qm_audio-v1-8-2976c35a0c52@nxp.com>
References: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
In-Reply-To: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713210421; l=641;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=t4lCiFcNj3UHNmOa4h/pQJmxZu+XlkdXWM1ZPKq/yHw=;
 b=kapNT1+iTqreXdpMNM0bK/Kp2D+t2iQAqBZq6aCp0kHM18h9JSrFueLGx0ze7aRD0oDIF0OIt
 nVgomxwq6dADamw3MMPRoiGtl2QdLTW8I0qGq/CsboiM9+ECFikL099
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:74::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ba0611-56ea-4d47-13ea-08dc5d84e149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qHksFiGIJah930WFUq4gZzS2JcXE9HWOrwZlw+/MJAoiEMbGFBwGtIYZoZzLxLGcNEZ+GvPpS5FRLNYe6EksSyqknPSiwwAqxoLlAtqb7LvCqUIl3tZTj5TVdBfy4Cp2DdpxBji2YJbPA9f9AgwltA3/KItpvorovYhTYEJ9gnWahNDCsCuvHvRC6N4XH2v8gh8xdUtGVKVsvECm7byCS8d0HYoeyXnCZVsiuLcFACU5htegPLTzDTKCgS7T+/gRehuHtNRgOdIpr1Uwkbd5rFUAt1vW0zLtGDI1A8oOFUyP8Adt0Db0YaNgclWtPqJ6J9ObDQMhOwN8QdYZWzJIXIIClFuEPSEWGvgp5Tx2oG7ZAJ6Fpoqr5vsRk6ZCl+QPMxm4wEUZOurelpW8S5nLUHC3EPyIAmBwocAf7kT+xRVkWxVYxIn7iu8OBIa6XSnyXpF6vY0IkgWLF11UOTlHy0r8U1w5GqCTQBcpoTl2zcP/JHK1so1ddi2NWO88RwFcR/MOmuciyqcpfYaPRMkdMf5ivurbYXffWbOL/xEa5+6LWjVbvdSFoEs8x8t4sxwA4zE7rePUi4hkvFFtsrppGUwjiYKSDlvLzt9hn2VPmpPtaFVMuLpuIR89SgOTeTRrJxI1rDQ5ojARhyJZSJfvXkIdDKfaSo6sZukul9uh7c0u9aBF5zjTl83LUJkOI+ebCZHmLXmu6URDQWru7mt1glwTulpBIGwC2xru+cYyWvU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WC9QRzd4cThpK01qVDJSdGRrbldDSE11eG1KcDdTbGRmV2h3SS9oV2N6a2Y5?=
 =?utf-8?B?UmlkYVkyaXUvTWwydXFRc29iY2l0T1dydXdvVWExcExnNFZ4YVQxSmFLVjVu?=
 =?utf-8?B?QWp1OHozRDJ6MVp2Mk5NQkFLb2pFbzRQdHZrN05zSjRZbjZtLzR0QnJsZFpr?=
 =?utf-8?B?R0txNCtUUldjK0FxVHBqQlVsdThZYU5HTC9xRTlmM0NUSFVpUk9zUFZCRTFq?=
 =?utf-8?B?MW55V1J5aUNzdCtVSmROajRwN1pDZkRvWVBUUmdONTBIcC9VNSthNnpubkpR?=
 =?utf-8?B?ZmJ2MTJvN0xWNG1XTWpMbmtOZXEzcFAzUWdzeVVBOFNnekJlV21PdWgzUGtu?=
 =?utf-8?B?YnNsOGtqcTZGQlIydXd1SzRyY1hPYTZDQ3RyS2p3bHQyZlVpY0tVQkw0SjI2?=
 =?utf-8?B?ZzJ6dGFKTkNVc2x6U0NPeHlER0I1YzRPWk1ZVW9XakM1cVY3N0FMbGFWRzJ3?=
 =?utf-8?B?Zk4remxRZjgzbjhuQWFsWnpOWGZGdGR3LzB0QnVhSXQrbnJubldrZHhnK1pI?=
 =?utf-8?B?ays1UVR2N3Vick9nbkRkL1JuLy9TUHQ4MzhWZzVPQ2pNMmlla0x3SXdONEN1?=
 =?utf-8?B?Ri9JTVRFQWdxOUtueUh4N2xCUitORm9iK0c1SVlrMmFhSTRGb3lRUWk4cEJK?=
 =?utf-8?B?NGxNdkh5R2cvckJzWE5DZVpGcnVGSTdINkNYNDY2L3EyalZQaWxlbWx1M3FO?=
 =?utf-8?B?MWthNXpIR0Y2TG95Y3FxQWU5ME4wT05kUmYxQ3FSVXdNM3JmQ3N3OTFiZW5w?=
 =?utf-8?B?VTVabjRKRUNrV2VxNnhOaWxlUitCQTJCeE0vYU9NVlB4Yk1BUVdnWVNYdlNN?=
 =?utf-8?B?SVNEMFlBUXZxMjdSVnZNUHJnNG5nM2srd2FnbkxmaUMrWmVtcEpORmp3ZURi?=
 =?utf-8?B?UnJJcjlTNFdobDRFcU9yUDVibWhNeUxGRDNwSW5FdHNncUhUNU1zQnNjWEhu?=
 =?utf-8?B?dURadXBqRjZGQVZIbVN5OER1YmhXVEV6OXlsNXNTYTFDRnNKRG9abkJBOFV0?=
 =?utf-8?B?TVQzblhoUzFpRkxrbk56dUI4dU1zSlZ2Rnc0WWpWZEt6ZWg4TjNXTkU5VHNz?=
 =?utf-8?B?Y2FxV0VDazNFdnYzNG5wSi9sK2FueGhhOVlKVG5oaUY5RS84VlRzMUJOeWs4?=
 =?utf-8?B?QmhLdEMrRUFTVElWMkc0UWo2MWFKek1hR3hLcUNhSW0wQU9FSmZaOGo0VkNo?=
 =?utf-8?B?cTYzQUlweFVDdU9HNlZta2tLT2doWFN3RHJxVVNJMjkreG5yU1pPZXJuRFJL?=
 =?utf-8?B?OGNkeXdPZlU4K1RNY09STTdJZFRCTXhxaGRianlhd0wyRjBBY0M3aWdPOVFz?=
 =?utf-8?B?VGRuam16d2x6L1pTT1dMd0hDY2ZzZmZVZFRhZGxiK2dvUUtRaDJDS2d0NW9p?=
 =?utf-8?B?ODVMWFhqWHV6eDJMS1M4NGMyNXJLcVFGOSs1aTBSdFhNVVh2cVprNmdXWk95?=
 =?utf-8?B?STlEQTR0NFBxaFhxTkNMQUg3UGRPTytzL3YzaU12bllncHdDSGlMS0RLYmV0?=
 =?utf-8?B?eGpHN0JaQ3hvODgrNlUzTmVMZVVZUG1GTjhCT3NTU1FQMnp5Q2tPM3ZBQmxk?=
 =?utf-8?B?RThLZWdLT0NtR0ZFWUgzMkFtalFCeFNTY3ZodHV1ZWFjeDVXbUN1V0w3ZDBV?=
 =?utf-8?B?VmVZKzZVNWNacW03TXViSER1WENmZ011K0JNY2x2cmszWTBweEFBdGY2QjhW?=
 =?utf-8?B?eHRkQlNnRmFMYXMrZU1pRllDTk1OTHZrKy94Q2xkQjlvSzA4SE1kM0I5UEcw?=
 =?utf-8?B?emFudzdXdlJoaHloZTl2M1BvQnZmZ3pIYVJRdDBVWkRCKzhTTmRVRG1mNlhY?=
 =?utf-8?B?cWNVTnJnOUV5SlBEY01kbmhsUHV0TWY1UWJqaUtONm54VTJ5R2dSamVvTDE2?=
 =?utf-8?B?MDY5QjhqRy9XZWxWaXM2cXk0UHYrQ2ZuRy85TnU3czA0VGt2R2N5VkpiZDZK?=
 =?utf-8?B?VVhKZ3o5UzQ1TWJVajk5dTJXbFZSVUhvOHhDS1VNcisvL3FGbGswbjJlR1lI?=
 =?utf-8?B?elR3OTJ5UWVWU2Q4UlVvYnl2djZKbzJ1QnNXcGREOHJkd29Ybk5tOUZLb1U4?=
 =?utf-8?B?TVkvNDc1SHdMc1QwbnBCY2FRVGlydFZNdlpYbWRwenZqdnJ1cFRhRWZpQ1ZP?=
 =?utf-8?Q?JGz+btq9pHs6WdO9HmUnf28xw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ba0611-56ea-4d47-13ea-08dc5d84e149
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:47:27.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIvc97uEbge9Ry4Q8OuC4zmoGMpAzYwGpp+/JHSJDAMyPDpc3EbUseZ4csWfd5PyuoLCoCGI/1kz25AL80k+7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7328

Add lsio mu5 and mu6.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 94a4195d92320..da17161055179 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -260,6 +260,14 @@ &sai7 {
 	status = "okay";
 };
 
+&lsio_mu5 {
+	status = "okay";
+};
+
+&lsio_mu6 {
+	status = "okay";
+};
+
 &cm41_i2c {
 	#address-cells = <1>;
 	#size-cells = <0>;

-- 
2.34.1


