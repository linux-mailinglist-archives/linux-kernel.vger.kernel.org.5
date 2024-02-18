Return-Path: <linux-kernel+bounces-70233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED89859515
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15D51C20F77
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A1DE57E;
	Sun, 18 Feb 2024 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aMpa6YzN"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863076AA7;
	Sun, 18 Feb 2024 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708238891; cv=fail; b=lCzUI+24G1gVu39nEKoJzm1OFYtbfjWcgae8t324BqfkKiZ9L2DJWsvQ+Ka74coyumfQrV8APiJXwiXZ9ot8CEw5UF4YfKBDw3+iAjDiwXANgRY8sISy2oPsVpNd8yQCSN6ADo5TKxAom0JNf0UBlsvEGeynaMSX6dACeefrPbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708238891; c=relaxed/simple;
	bh=MM4hGelQPWJBCNSBHauYYOUJtAGkks0oEt/r7CVecMg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=L1bH6myi4n9TGfuh6W+R++N56/pn6miSNZ4NxZcinkTKmM4+M84Hljsjb3fCLcx4H92xmaqA6+5iuM2AwQKF5iWTj0duTlf6IclG41EGc9RbTSv5+A/2BlUOEqWv4egSvSt8tYOd3tMjpidubc1g8SHhwXdTumvFPPym96CxowE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aMpa6YzN; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEUwaj8h9Lb+jjvq9sxEKct36LYVbJtJXh3fmPJTT+MuqIzgqz4XXLbFeMZvQ1l75JgoJgGzbGBy4mkVsaPH3L2YDMzh06l7GPOU4PpuLS3qoFHlqkc1FEP66mRHq40uav+FMwQMkM7lWATJZ2hcpCBCNC2mMh8uwSua3fdz3e+3lrIPtFlgnJc+ZsIZqS4Jeq4M3o3jPsUhjq2/pWtZ4nCjvxWfBPLxtSfPkYmnI/p23YN0nG0AVdjMerUaXEYBMSR+HC7+nxoD6vQ4uywItfw5R1LSl3UEwCIoGEADDB2bEg1Fq5yVnKCXQQXHgwJtxcG48xA4Dsy34DMNPIEZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KvOi/dUrQ1BiOs5m/DkXp9FaTqjukDIJmIW7LA79+g=;
 b=m8iWhwuLk5C6bgGk94Rroc/C/mPtn0AHXRulI2hLp9H7heuj/rHW4zrl18GoijA1vKuK/wnjhWHgGBKggbb2EIyr5988YN8CeAw3IQqYrbGxL1azKQ6nCsvq7caEuafiBEp/POR9npn9GzAeBRkZ8iqBxUwCajD1Ner9dBSTlQv61wB8IIxTD4NnaY8t4kiQcyu8+kjATwjP8aEYtfWKpkqrl6jUVypbJxp0mN+F1+rglMjVhvdyT0secFUu96iRNOXmXoGaOuDTlDoCA9gDo/HghZyudrlTnxSz+K+4XUmokKVyeQAe5ZQB5EZSYEgf3HwXInbcY4Ek0Q0mklUMVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KvOi/dUrQ1BiOs5m/DkXp9FaTqjukDIJmIW7LA79+g=;
 b=aMpa6YzNQErdh34/lw8Lx98uFjljok8BfRL9bQnuOGiayNn0D64jNxSnqcTC1+UjAp9Vm3QSxYr6n+FKiGqQpwU4AXHBsh9p81dA56hwg7WH06VgajXF1Q/TLOXaulcB62m6Hdx3Q+xhsuKt5syWd3rFooln3AqaKfVdOmY8OZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8011.eurprd04.prod.outlook.com (2603:10a6:10:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sun, 18 Feb
 2024 06:48:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 06:48:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 18 Feb 2024 14:56:13 +0800
Subject: [PATCH v7 1/6] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-imx-mailbox-v7-1-8fb665eeae40@nxp.com>
References: <20240218-imx-mailbox-v7-0-8fb665eeae40@nxp.com>
In-Reply-To: <20240218-imx-mailbox-v7-0-8fb665eeae40@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708239387; l=2741;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=C56rjccJP8TyE3Eb4IvcogQQf1ZEIotnAVpBDSA+e98=;
 b=bheDqjzxf0ndaVaxi/C64f++TKkz+p/fSnMVuBmNPVjhYAW0OklA4JAfTWoZflGP3tNRK35Xf
 kTyysiq7flIBo0IEpdR3Un6C1odjn/Wwvg0CDUN6nJ/ePPTUwJLguPt
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: d86af653-8048-4192-1db5-08dc304d9089
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C4hVLpgOuA9ywPh5c9pPy19hgb6raG+3bieJvkIBIar+6yGwkqwzM1I0Yk2ZBaHoN6EuDyt8PIOda39loS5UGFRWTPeAuzTT6DgoEmvwlws+LCdW7+u/OKaWQwLx78URQ1qc5rQmWrXaFEUfU+2oCAM+QQ2hbJkHyvYEIchbcH2mLvK8ney9H4RnmhWLy37fnecPsheouzOxidwJNslYLyv0Af0/5t/GN7BZC/vUIzwR6iwHBUydkp4JQ0Fea3No27tVuxRHT5yuG+BUWMuXOaMPvCr+ZnCsgkwyzTKbDrmlofbzY9dawjL5BmxbFfmaHMaRdDJthYcEXlERWorRg03+kxxLsCiSFsaZZ/jh7vFXm5ZPYJNfhL9BdiR7MkKfDB5xgOkvazJXFvS+Zgp/c0GBPBqN/Fm0TQgEWsiWlqVETIRY5JXFP5XCjBiv4NjzMooAeV6CEFYWQYIeWydsrAc4ivtGOHcprfXdM1MTeC/pSh+oIbAQrFAdKleOU97mbf02I6CdLFH1LFZasnUK2FcRjqz1W73utQJsEpl8+Ap2auuyOzUoF4p2fMAooGZqFLdUV81arGE4lslZzK3gFxbS2LEsmhF0ke38x0jwBWCTW6R9ZzR2SBmBbjOC4YmQaTdo81rgZ1hWBKhLiXFH9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(66946007)(15650500001)(4326008)(2906002)(8936002)(7416002)(8676002)(66476007)(66556008)(86362001)(36756003)(921011)(38350700005)(478600001)(83380400001)(110136005)(9686003)(54906003)(6666004)(6512007)(41300700001)(316002)(6506007)(26005)(52116002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHA2cm5NTDI1RERwSXpGQk5CUmZ3YmdsWHQ0TW1nODRJdnU5S2ZEWnNFQUFl?=
 =?utf-8?B?Q0VNNXFKcTdtWjM3NWw0djNaOWFRaG84YTlRRTVBL3BkZ1hxdTZmYytuY2gr?=
 =?utf-8?B?Z2FVV2ZOdGlxY1ZjN2R4SFl3NWlNTUgwc3BFOUlQMG1ZNFNSM2o4Q3gxeEds?=
 =?utf-8?B?djJ5bmJCUW01bDRxNXZDdWVweG9lOXpqd0hLS0ZDdU03dWV6cGtYaXVzUW5Q?=
 =?utf-8?B?cjNTcDUrYTdIUURFamVqaUhpb2hNZ3hpeC82bVV4MzJ6cEh4Ukwyb29BSStw?=
 =?utf-8?B?SG9XVFh4eGFjbUduTzFzNVFOZjkxUDN6VmhOaHdpWUlvaVpFR05yUDJxa0JV?=
 =?utf-8?B?S0luWVBKbnRQVTh5UzdqcVBDMWkwTGxaUUNRTnJ4UURDQnN5bGltR0VlTDBG?=
 =?utf-8?B?ZS9VNDQ4dlNlbzhiZDJxaHVmK0dibW5STElwQ3VsSGtCYlJGWnR0V0FuMkxj?=
 =?utf-8?B?aUVBWEpTZ0FBOGJHOW1pZXcrT2hRMHFjTjg4TTc3b1RWV0FrWlc4WU83RkxW?=
 =?utf-8?B?TWFDVk9SZGhYQXBxVHJKSWxXU3JCSE1OTE8xdEtSb3NMeFUvYWh4UG0xOXVk?=
 =?utf-8?B?L04wcWY2WmM0Y1RkOVlPald5elQzRGV5T3N5dGxoZ3hReWVaUkJLVEE2SDVx?=
 =?utf-8?B?bVgxcUhKZGxrOTdsRnN3SERhYkt5K2s4TDdoclhPY2p6UTV2K243UjlBOVVK?=
 =?utf-8?B?clV5YUU5QWRlck01ZWpObWdhNVVoS0MxUmxvVW9IYUFQbHBERlBaM3ptMHFa?=
 =?utf-8?B?OEJTZ0MxSHpvQXJ6WVAxWDlDcUtMQWNWVHkrSWJqL1VtcTBuajZGNjhpUnNR?=
 =?utf-8?B?Q0RSckxjTElhYkM5Q3RwZ2pEN0JpNUwyNEM4Tll2eGRXMWZhMFdNMys4SjhV?=
 =?utf-8?B?TFFiQkFQYjVzQ1FRUjJna1ArKytEV0MwZ2orK2VYSGpkbmFSbU84YXJWKzB6?=
 =?utf-8?B?T1kzQTFpSTdIczJFRVJ2MEY5YkEvbW9XVXoxOW9EbVFpTFpPaUNXajQ2VTRX?=
 =?utf-8?B?cFN0WTliNk9EekozZVM4RElDaVVld01Hc2poNWwyaFpkWElOUG4yTURoUzQ2?=
 =?utf-8?B?Uk5QZzJZUkp3QkhaNGdLNDJGVWNGMlR2RWkvT1BvWkhqT01xTURIZ2ExcUtL?=
 =?utf-8?B?bmI5eEtJNzVZc1h3TUlVSTNETzI3bUhzdFZ2QVhFYTc1WngwTGJqbmxvMFRr?=
 =?utf-8?B?dHdLaDVmcjZkN3duSFBabkthQVlwVm1oc1MvVTlYamRYb2wxeDhIYUJ5aGRv?=
 =?utf-8?B?dGJneHkzQXR6Q1c2aDlTbll6bFpPUTAwWUhrRnJwZ05JK0N1TlhXTFJaeTM1?=
 =?utf-8?B?WTZxTkJUVnNwejZtanNJc2NmV1ZCVnJlajhZSU1TaWtqYk8zdGhBUUVFUFc1?=
 =?utf-8?B?cWJPRGNZeHovc1lNZU1UQlRqNWpXMFQ1STYrS1kyMlJGOHc1ZlkxRUxKVjF2?=
 =?utf-8?B?MG9IUjM3aTRyS1B1elFwVjBtL1k2SzRMWkdaNnRNcjZjeldKS1J0OEpLRG83?=
 =?utf-8?B?NUFXblFMSEZMeFhHSGFIc2ZMZEo3N0l4eTRQNmZqeTBwaTlYR3hrWERScFgy?=
 =?utf-8?B?cUY2YmlJVzR3N0ZEeklwQ2JFZmhnUnplUkg0bmlDem5oWnQ0TW5UUTRwMWRL?=
 =?utf-8?B?TXM4THZEbmdjRXZOekN4RnNtMFkwSWVLKzduWTF6YWxZL1RmUndVck1Hd1Rn?=
 =?utf-8?B?Q0c1YmFsVkZvZnJaaGhEcEJqSzQ5SjNCakIrb1RjV2MyL2UzWUwyUUtvdTVq?=
 =?utf-8?B?dkZNUnZ0eFdjVXlVTTFnOTRIN2NDUjlVNmdiMmE3MmNrcy9Od0lIUHJxaVJy?=
 =?utf-8?B?QUN4RUdZQTBvSTRDQVdSZEVTRUFkWGczZmZYb3ZpZjRJL3NPUlUzbVMyRlN2?=
 =?utf-8?B?VVRwWWlRbHgrSXVRckJlZmcrdTNKQjJQTVh5WkJ5ckVYSDczWUxHNys2QXZa?=
 =?utf-8?B?TWR3Wm5xS0JFb3YwSiswenV0UEpCSEI0OGp1VDQ5dXJndWdyZFZaSkxLTSta?=
 =?utf-8?B?NFpLWXpoaWRubjNJT1F1TjhLM0FJbTkzaGk3d2txZWl6Z2RlRTRqYXBwVmNI?=
 =?utf-8?B?ZFp4ampqbGsrY0J3Z21EL3dvVmNpMFVUMWRjUFJ3MGZyM0VXVG8wOXFkM256?=
 =?utf-8?Q?t2+gRK5jmn856aRrGENT6o8Lk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86af653-8048-4192-1db5-08dc304d9089
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:48:07.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+oRnjCtHGq7I9ax+ii96yjMCFlK1vFBxxJnNcbVVazRvuUw4hwRnS5YhFX/4IzX2CtjJSlnopvVpvivPTKxaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8011

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 Generic, Secure Enclave and V2X Message Unit compatible string.
And the MUs in AONMIX has internal RAMs for SCMI shared buffer usage.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 58 +++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 12e7a7d536a3..00631afcd51d 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -29,8 +29,11 @@ properties:
       - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
-      - const: fsl,imx93-mu-s4
       - const: fsl,imx8ulp-mu-s4
+      - const: fsl,imx93-mu-s4
+      - const: fsl,imx95-mu
+      - const: fsl,imx95-mu-ele
+      - const: fsl,imx95-mu-v2x
       - items:
           - const: fsl,imx93-mu
           - const: fsl,imx8ulp-mu
@@ -95,6 +98,19 @@ properties:
   power-domains:
     maxItems: 1
 
+  ranges: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "^sram@[a-f0-9]+":
+    $ref: /schemas/sram/sram.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -122,6 +138,15 @@ allOf:
         required:
           - interrupt-names
 
+  - if:
+      not:
+        properties:
+          compatible:
+            const: fsl,imx95-mu
+    then:
+      patternProperties:
+        "^sram@[a-f0-9]+": false
+
 additionalProperties: false
 
 examples:
@@ -134,3 +159,34 @@ examples:
         interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
         #mbox-cells = <2>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mailbox@445b0000 {
+        compatible = "fsl,imx95-mu";
+        reg = <0x445b0000 0x10000>;
+        ranges;
+        interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        #mbox-cells = <2>;
+
+        sram@445b1000 {
+            compatible = "mmio-sram";
+            reg = <0x445b1000 0x400>;
+            ranges = <0x0 0x445b1000 0x400>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            scmi-sram-section@0 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x0 0x80>;
+            };
+
+            scmi-sram-section@80 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x80 0x80>;
+            };
+        };
+    };

-- 
2.37.1


