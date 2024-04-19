Return-Path: <linux-kernel+bounces-150964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2AC8AA735
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4921F21DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395E622301;
	Fri, 19 Apr 2024 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VMZtFkCx"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8232BAEE;
	Fri, 19 Apr 2024 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497401; cv=fail; b=UAuq/9MOvLEF/0kLlucMqUC314iVb1JWHDHlVOoY3x/SsAI2VAwIoIii6YlUqHjmuKJczn04FqlA2tPvGFrORWhqAqxmJX2Jg32uVVHtwbPEm4dWR18ulCaNKtqpjAEsideuqAwvF7BrlZOmAfUpvgUDa0PW8Ec2MDvWz9s6Av8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497401; c=relaxed/simple;
	bh=zrNJwRWKudONbk7rDjH/jDpbC8QXJK75zL6EcM9EWPY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=d/Cm4yXl4SoBgVvnNyWFzAhld36rsL22AEWaP21l+/9ftWGRWZrLt1Jyu9mrHcg5Brtxd/JnwUgmkkgZP+SvrEl1r1nP97saKnX5KWFCMvcSHcZ3xVqeEp7MSA/3rC+4k0lulpY7MviI0Z+szpO4kX5j7s824JPBmJIgTfBgFrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VMZtFkCx; arc=fail smtp.client-ip=40.107.8.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQGLsFneWdlWWveHE44YXGORwUwGLu3fGEUWgkswl/pvpdZ9QTl8f+WC+T1w8mmxVMcG1w2pt6I81dDDK2CLWCoi1ZcE75fnpvcGZln9wfkPeC79p8ayulo5VZjAJ8qzE5sP3dy3TQtcqwiSFAH5e6dKk1lFLMnn36lhFbq6pr15vn/fXJJvFVM2sSux4Jd46XHMJUclKMBiU4ygvnvlNKpiAkuhmYFRPvJ3SSJX6OeQo8Z+bnObXW6rJEVcTHa1znNJeu6oOxGU1Wc6CKUfzA2cAuSuEjEC30vZeZnOVTKmRnHB45Ci1fZR0oZG8kuA3jC7LZ/5MT+UlgRN7tZgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT32LSHMcIuQzL0CIpSXsBuJt+5bRTSEl6OAOqsLuRk=;
 b=oA8IlOqVVvR7/BSqOBdB0vK7FAaupuFmAuxu3P+OjE9NafJEUUVcscEJU54YSVGvReoIhGlyp62hpmGs7SFZoJE8NpiFm25HKs67FJD8jvTqVLOiiLIuT1e+uFHKvC0sqBJvjZ5AXbbTSZFVbD2wY5HA8lJ+BkfQVs25ifOQYTalg4T9hcAzeSmfkbluSBNYdm5HujfyUp6n+4wMy56h2Hj1h7Qibs4oaK6kQ3WFGIUKh5Tr1Q8fWEDySX+1mIZ4ZxB1CyvHB8W+b9Y28VjWVUQTgYOy+LuPvOdR8YQ+8XMcNp7dRJjjJTMxPFN67G7Xho/5XgZmecLCn0bH+OpOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT32LSHMcIuQzL0CIpSXsBuJt+5bRTSEl6OAOqsLuRk=;
 b=VMZtFkCxStS3ryfSdS77K3h2GCD3FAa+P5sBO3oe5Ti6YR+EUoi6L9xrFoGLOpZTtx02DsqJ8yjMHdmase7WA2zO91jxgb0ldDGOeBL2i1Df6vnPzw0XRxEnGu7RVgJqRiXsBBJa32L9Ke8pAaqnqnDpw4vXmeSlr27ro+SFhxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7358.eurprd04.prod.outlook.com (2603:10a6:800:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 03:29:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 03:29:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 19 Apr 2024 11:37:06 +0800
Subject: [PATCH v2 11/12] arm64: dts: imx93-11x11-evk: add reset gpios for
 ethernet PHYs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-imx93-dts-4-13-v2-11-9076e1d7d399@nxp.com>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
In-Reply-To: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Wei Fang <wei.fang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713497841; l=1135;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=zt/COlkMbz43z8ZmWUtFhg4O3YRr9hO66cApIQ48y4I=;
 b=farRS/ccGCSQdrLCknRNrjRqh/nwA828mot/UMZNriNy9oskYOljuZNJthrAy5cwo5aUCJUpE
 6ydS1TxgaeWC2cdp6lOyi8O0ga4AT8pRGSISST+EviJP+8OA0Bj0oIK
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: f70ec9f2-b34c-4004-978c-08dc6020fad8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4rEp7BAFlKoAFnw1EuYQApMhyDW745ksliyBCCDg0CLql3rRKSnGoM22LbByvRwLuFowNqfbqfb8C0KjyXzZ0XryPYLU0JnbbH9JqSKcYqKJFDRHvTTXzNzhG6Mw0bWjhOMoAcI+mJNunsaa1u/3ce7rUqOD1a5gEI4p9DnhaJpvm6bJBUB9xZ5DmkU7+969hXGnL9PULgzqbgvSLZwsFOjIxPsOfOfrsY4jTmrtybIGiIRgkJ+qBUGeJ269AT06tWnjRurzTnIdEIB1eYlw48Pb3x4sl6r0ckPYnCUbOVxPrGB9b8dtAT0cnpYiocaHScVqojXWg0vBbBstWp6NRTZkxilOaUmBbszqKKoecK5nzJ6fBQMvpr8xrvSrU4pxK38jpO9SRTtGlx480aRK289htJjb38VXH9XREoMtO7x89s626POluUT6RNRAO+mhDaSVbjyM9Yf9B7DbnCnsj74fSwhJ30Oa+z3MpyleSJRquxOsX7rXIzvp/bRf6iE0xGoQkSNbx8qXvCxcJemJTe3/a8U4rVCCMCdot4hMgT3YKWTZWHroDpFjtFKNQ45t8alwD0L8n/lLjSFWOAfnwcoWZqtIxlTt6FGsGcMgiB52jcOGQsWwDX8APomFUXwCDleFz3Odcq/6F4ChVSWPnnJE/tF/s+Oa6dG8x/KAFHOj+p7YJ6EpsarnP1wdvlTVwuhjgHKOgsfE0TL6qKGTwWNJZei0hmt+Inud78FxLgs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2Z0cTBaZVhUTkJxWEpacnRpMHlTQ1VIeDBMSUFjOXJSaTNaQy9GOWNTYnQ0?=
 =?utf-8?B?bEI1RURsY3orT1FRS2cvNEVjZkpkdWhiRURPRnZyVklvTm9yUVFwaXNuMFQv?=
 =?utf-8?B?ZjhIdzUzVjlXUVJxLzdkN2lPMVRKblFiM1RRL0h1cU9DdEZ4NjRRU0pjU1Z6?=
 =?utf-8?B?SEo2QnllMStnR21DcENHejV3WTJQUFJ6dmUvL09tTlJuZitkWGsyLzE2V2ZU?=
 =?utf-8?B?SW51YUMrcE8wbVFFclZYZGtvQ09XMERNNHhqS1Y2RmVoYTIwNVJ1Nk1ZMWF0?=
 =?utf-8?B?ZWpkcWJhbXJwckVObkk5OVMzOUN5eEFpaVA3L0gwNzlRb1I5U3ltRWo5eEtq?=
 =?utf-8?B?ZGVENSs1THlRb3d3NWhUYzZzSWs3bTM5Z3FHMFlkQkxpVE9SWlZtd0VURURJ?=
 =?utf-8?B?c1hxQmZLYVp1UnlrcUV6cWdqYlc3VzZPNUdjZ0pVeE51U3ZWTFd6N2pnUGtH?=
 =?utf-8?B?elJOT1ZFSVN4L0tEVG1oQU1XeU4zK0ZkK0F5ZDhOMDlTK0xWeW54MVFEN2Y2?=
 =?utf-8?B?WXNkejBHc2VqK3ByZWpPeHZGTmg2Y3VveUF1Ryt4UTJsWk9EVTF6QUdSdGtT?=
 =?utf-8?B?eDYvUXViSHFPVjdQOEFrWjFuT29DN1NYU3RjY3RYN0l5ZWVJZzdpNU42ZzU4?=
 =?utf-8?B?MENicHBVV2gvdFp5YURNYTlheXl0RVRmNWpxbVVJcFVOMlJHcXRuVUh4bnlF?=
 =?utf-8?B?S3FDbnYzbDA1V3lzVWtaQ2c3S3k1VG53cjdrNjNUazlHc3RyV2RIZE9BVy9i?=
 =?utf-8?B?Y21tc1FXY20rZnl4bTlHV1BHZ2xzK3dKOEh4K2FZT0VsWXZQZlp0OHZMV2Zi?=
 =?utf-8?B?RERVb25WdGxNWGdlTU80akZpZlJ6VnFDaEtPVFUxYVlyQzVLNnNBMmVKSHZJ?=
 =?utf-8?B?ZnRhRWJGOUdyTzkreDhuWUJzYUoydU1IMFdycjhPK3VMZ3NUT3VvTVJUUkg2?=
 =?utf-8?B?Yk84ZGJLeUg3NDU1cmIzbmt6ZFhFR3BvanRFNnA5Z2xJYUNGbnVKeUhneEpk?=
 =?utf-8?B?a3VDSWg4RkVsYi9MUUhCakR2eHNDTzNIa0lzMkpsTVFVdWxmWVdjUklaamUr?=
 =?utf-8?B?OFFpNjFxcWh0Y0ZvTFUyRlpSYWdyM1JJRVA1Y1kweVhxSFVzekJyY1Iwbi9s?=
 =?utf-8?B?WEpUaFRjZk5QMmhVVmFseGV0Z1lGUkJtb1dTaFJ4L3BmK3J3SEN0bnFxOEhB?=
 =?utf-8?B?M05OWFpMd1REbVFjK0JYT0JVQ2w4WndkY2RlNWFRK3d4c3JuT2FsSU5BQlJy?=
 =?utf-8?B?bGtjZFJJZmcvUUhtQ1R4ODBkZGlpL0ZnOTkvS2FKVTFFMEo0VTJlSWtsRmh0?=
 =?utf-8?B?ZWNQcGxVK2w5R0t2cTM0K3pwRzkyNnExRG9nQW9VQis1VmhSUEZzZlZQdUxX?=
 =?utf-8?B?N1JZaDVmWWNZWlN2Q25Ham9Qa3lLV2dlRWtpbFp3K1R0V3BWZkoxR1pBMkdm?=
 =?utf-8?B?OEtQY0RFbk9wZlJ6c25EVXFqdWtlQSs3dzNWYW5ZNkFCUmJoQVVXaFZHTldE?=
 =?utf-8?B?QVZGeUhYTUg0UVVmUmcrakFnZHpBM1dNY1YvckZ6QjhiUkE3bXVnK0hNYmdF?=
 =?utf-8?B?a2lsejQzSWNUREJkMmdib2pnSzh1cHJRL3p1RVVGZlh5N1ZoanhNcWpZSm5I?=
 =?utf-8?B?dGttY2szdS9WRzVXdEFNSTdPZkhEVmRibVpHMHAyc24yN2w1MG1UYXlXQXhq?=
 =?utf-8?B?TEJ3by9qY3dUbVhLcnNBN2d6d2JhL2F5ZUhCZTFJaGd5cW8xUDZCc3FmR21M?=
 =?utf-8?B?OFFwMnVQMTlIVmt0bi9lRHVQTHJWYTlSdDZkR1pUQ1pYcnFDREtoNzgyUnEz?=
 =?utf-8?B?SFE4cFo1cUdWZjNhRDVhQkdNV0IrTXJZMkkzMVlMYXF2WU9LOGIvdHoyWERj?=
 =?utf-8?B?K0p1YzhhaXh6Q3JHWUNqVUlKaUg2emlWeVRYNGNJL0RpcGpNbWh2ZW5wM3h3?=
 =?utf-8?B?bGVyMk9paGdwZnY0UVVyalBoSnpIWkJiOFF0U3dBUmp1d3pla000bWlxblJV?=
 =?utf-8?B?SmZnc01HQ2hrT01pRTBmWG5qckNHUlpOeG9jdi92RHJJRHNYaHFGTmJNdjZu?=
 =?utf-8?B?a1M2dFJHRkNSR25yZWIybnZ3VytBR3ZIcmZianB4VmRvZU5LV3NuSW1nYnFP?=
 =?utf-8?Q?b0CFg+Bwg7HY3ClpNskX09v8J?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70ec9f2-b34c-4004-978c-08dc6020fad8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:29:54.4369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6In4AhVE77z9TizfTgc+sEpjVhc2t2AXeEqkoLwWJdsZoMafY/7vFQ6PePzRFtG1GkPAAlQ3aoHDgDxszEMTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7358

From: Wei Fang <wei.fang@nxp.com>

Both the PHYs of the EQOS interface and the FEC interface are supported
to be reset by I2C GPIO Expender. So add the support to reset PHYs.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index b29d470d2492..44ae985945ad 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -121,6 +121,9 @@ mdio {
 		ethphy1: ethernet-phy@1 {
 			reg = <1>;
 			eee-broken-1000t;
+			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
 		};
 	};
 };
@@ -142,6 +145,9 @@ mdio {
 		ethphy2: ethernet-phy@2 {
 			reg = <2>;
 			eee-broken-1000t;
+			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
 		};
 	};
 };

-- 
2.37.1


