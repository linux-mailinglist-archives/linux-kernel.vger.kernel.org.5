Return-Path: <linux-kernel+bounces-32376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E14835AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 419B8B26165
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8DBD304;
	Mon, 22 Jan 2024 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L0QuuIlz"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74D63D8;
	Mon, 22 Jan 2024 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904113; cv=fail; b=q8qdRLJb/w6FRNwwIcJ3lvJDtMCKw3azoKDwSL/D/c/KJC2ASzmTkXgZG9wxWLbu30HIiB+qwfhwQXq6JSpGzBYPiDfcj5NdBLchhaGnCsc1xjZCFhf0twvdAygp/FnjHvhNmx1kYoryRNWQb/VQjG+yrlkg+FNVUk7VpBfMEjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904113; c=relaxed/simple;
	bh=NpXlwuMhAeLVKAfY+de0oicSjFZNNYXpfaLulAUMNgY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qCjNObBy5kYgB/AozerOllZdkOznIg6xnEeNHXnJtXIzzkfrdFjJvdIMmM4LRxmsoTQ2QWTt4Y81/gheDtH8LZf7JMpdCOB5lQ0NOxql5Y3C9f07RPz7ni3LsyKE95adm34pPZbVIJLLLz+l3jYM/UB6KGdgEnmyJ3nsAgYpR+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=L0QuuIlz; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCvwU1NCIRkpCw2lBqoPDdbvE4Ha1OvS0w/2Xhb5U3wN/cCPQTKHZKomu6Qj3BgRdnnDzHRtM0Iatj1QD30rUSwd5Jl6UrMHKqgkthCsqsn9q34kmsKDvNjCn7l3pFGGuZzoQDzQrZpqnxnjXVKGcy3Bi9eatZoA1VappM5yW5LURhI08obIUlcOUg2vv+OML0J9DDgyug+jCKbDi2ON8pbrxTogTtp1pj6ThjuV+/cYkqRF2+l6hXgWV2egJOsnnXTAr9IuufOnANJe33cekKcaz2Wmc8YlYpZYnIRKjVbgJeuZM9hWjuqqSPNaVD42A8EO/IBZLWgy15euhK7s8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g82O2aBVyCptVCQ3vky2tKNcvp0YYqSnK6Tx8buxk/E=;
 b=PxdfTfBlaZ6UkxZ/s1UTncktBOgP5Ns2kver42UoD5J+3W0tsMxHf/eIFF7S3/msuAavK/3gDvFT8+QrXtLbiNt3D/A7M7AFfvAB1X1LOkL91daeWTHpMP9QKHtOySy8NznblIfjUzl9cOzZ3z9B19077y+vwQpSTYM6Q4cCd7Xp8fkJEV9BJxZRZwk/v2FsRZSR3YihE/pFGi0i2gFgw6mSI2wrt29YjtidJgOtvaowGDLY42bj5GmBdjuAI6fLwnT24bU0umVZrsFWu3PEoS41HuRJLa6o8DGgdD4OC5SkhgsMXAjCvB8CvVyTVmw6D8eWH3gSYoEardylsLKpng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g82O2aBVyCptVCQ3vky2tKNcvp0YYqSnK6Tx8buxk/E=;
 b=L0QuuIlz27B/WBX01y3qwx8F0BvhtgVGf2NlNOfumfercbif7i37/tJtUAcP97O2phyxTFpq0DyMGyHizabV5TtRg+Y6ssMjBd5n/nmhsNnzu5VunZvfE/OFg3QD/LjVQMvPFEry0xTuJeKLCujyTs0M/9HyLyKhntJ7qknkXIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7991.eurprd04.prod.outlook.com (2603:10a6:20b:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 06:15:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 06:15:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 22 Jan 2024 14:19:23 +0800
Subject: [PATCH v2 1/3] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-imx-mailbox-v2-1-7b3c80333b92@nxp.com>
References: <20240122-imx-mailbox-v2-0-7b3c80333b92@nxp.com>
In-Reply-To: <20240122-imx-mailbox-v2-0-7b3c80333b92@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705904372; l=2485;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=yxhUwukR1ZdbYAmIIg5lDJYxI/rUpRQGRKB2Vuls1Jg=;
 b=w/DCQz7zjfmgkOVv/KVl1bxZX/wiGxSELbw0hBBIVa8ZKLhLpQKQm7gMrFa5RPFG5ECqX0zxq
 xhNOAmIFBEECkRuc+0u2PO1RCKUZyzBN2MHc9cdHd7UDBmXjYHhEONK
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 06730c13-9553-4687-1dc1-08dc1b117b64
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QHz+ouFpFmXS/BqTGRw+NhYv/Ezz7p2xXAOdz95pzLNQpw1+QcFadjHjpIsntsQTpKsTtIuzxEr+KxSYtTE/9SmdBf4uN3FHQvQxWpOOOkCzCxJTXLKYNfe32cuMdQKm+dowViupv824q+do0P73q1saDqSsW+11h4RWqvtrdU0uJ/mR4GDNjNRQlftjpFWiubrUTrT8v56ToHRDeRZ7XrkIBMyu+EH6y9qy/go1VBQqlEP2i1XSGAZ1Wr7DiOe1Ow7kpYqASYxqzkDxb3340jqLsFZA2a8/5GzHkA++HIy6EGTaKgYX480S/ot9ACLnKbcGWT+PRBzYuGdYfAjKGba5K0N6AJYuJVnbxX0CzLYXPjEr8yZsj+xe3oIiIIUWIQZMKCicZfAJuXzVgiUSt6uf2XJ5JiD4swRzru5+sLx3NtexsKxZGb9C8JCkzawTALX0UQAGGq1GDedNXL8eTDQDj0omNhowyJittvhPxRDASwsOBQ8/T2sr+qVFsmoprtzt6wRlBewmbA8HCFzqSMCTMpins2bPq+ZEzakeFF8sfySvbrpCAeNLTG5l/NPiratyP4k7qe5IenafrUc4/4Hw/J20yeWz7fYOCfxtxGngfwGqeJADl04XsX9aG8GaLkjy8qk35+jAgh5LBhZVUgK9NsmX+16sXhoVPt+bMYo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6666004)(6512007)(6506007)(15650500001)(5660300002)(66556008)(66476007)(66946007)(52116002)(38100700002)(8676002)(8936002)(9686003)(4326008)(2906002)(7416002)(6486002)(316002)(110136005)(478600001)(26005)(83380400001)(921011)(86362001)(41300700001)(36756003)(38350700005)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnZScjBQR1NoUVRodGZNME50MmI5OFJXNFdSbFFYZDk4RHdFK1ozcnFtQU5F?=
 =?utf-8?B?QVFYWC9FTjBJYW56MVhOYTdTbENoTFpJZ1ZVNHNzbVRqNVh1ZFUrK0tmNkVW?=
 =?utf-8?B?OGZrcFk4THFaN3B6eGFHN25OZWtnK284NHI4RmdGS0hRbXpNMWJNWEdTYU12?=
 =?utf-8?B?SVhsci94cUVnM0FFVFB3ay9mWWw1VHJNeGpCN3R3a3ZNTlhTamJvRktONWFY?=
 =?utf-8?B?cnFlTlo1WW1XSjRQeDk0S1BId0pVR0syc0d3WVVaN1Z4QStpNzdDTTNwcVor?=
 =?utf-8?B?ZjBUR2dnQXBJMUlvZzdHMUxaY3YzSU9kRU4xa1Z2amxZOE5ZYXF1bE9NY0pi?=
 =?utf-8?B?c2hSYzc5V0FMTk5teEJlZG9xZkM5STFXVGhNSTdCSDhOY3VkRngxeFdOOFdK?=
 =?utf-8?B?elhPMjVRTUlwZXU0Y3c4bjVGa3kwT2M1cGczUmJwUDYxMnZGZStKWEF2U1Vm?=
 =?utf-8?B?ZzRiZEhxT2RSOGxtdjYrbjJTdDVLNm9xR3pJV3BmNTE4ZFlxVHlmTktWZ0ZK?=
 =?utf-8?B?K0FmbnllYzNMV1pQbjBacFN4S1k5bjFJUWJKK2dPZnE5cWdBZFJIM1I0cm15?=
 =?utf-8?B?R01zajhEbVlRVTkyMll1VUNVaUJwcGRMV2pub3ZVaDhjZ0pzVVBQc0QwZjdY?=
 =?utf-8?B?QVZwd2M2UDBwV3VVTGE2TGJSS3cybWd1b0NweG9oNmVoS2lFWE1WS3RGVWRG?=
 =?utf-8?B?bDFybThwWnVYNk9PbjdlYWN5cjlKQ0V4RHJkZzNZaFZuS3RudnNRMTRBdFQy?=
 =?utf-8?B?dHNYQ0M3NXc0b0tIbHViOUg3cmFkQk9BbG1RYnBHTXpIS0JvVWVreDBOdkFl?=
 =?utf-8?B?aDZVWmdSbmFkTmxjNTNMRDRNMy8zNjlMSExOZW9BOW94c3NTdGY1U2IvT0NL?=
 =?utf-8?B?NytucGJkbEFtRldKQTBiRkhyem80MlJsSnJwT1EyRm9yMjVzRG5LdTJiaWtH?=
 =?utf-8?B?blhsMnd5MlpuUm5mdWZlK2thdWE2Mnc4dnF3d1lRQnNCam00WVBpNkVVS25O?=
 =?utf-8?B?amVTSXlrVERFYUJIV2RPSG0va2pkY1JobXB5Z3JxVXlNdkpKRlBNeXdCc2c5?=
 =?utf-8?B?ZG1BMmg5a29oUk9mTW8rdXVEcVg0bVVTUmVKNzRrSDV0d2dtVkI1T2YycmE2?=
 =?utf-8?B?WE13ME11MFpvUWFzS3lzZ3BqTXVyMnk5cEtjcTZCVko2ZVdmRVdMZk1sQWl0?=
 =?utf-8?B?Vjd1MVVpWHBDWkpBZENsTCtlNEFiNGRPNWtxeHJEaGc5TmdzSnNOR0FHcHpo?=
 =?utf-8?B?dUVxTXVmeFVrWmVpai9PTXc2VmUyK3A0NjNvOWVISnRtRXRDaVdSMUdDTGFp?=
 =?utf-8?B?aVMva2tDS2dmblZJN3dPTitqelJzTEw2S0l2NS9KYnJqY0xYVlZMa2ZWNTVm?=
 =?utf-8?B?bGpWODJ2SnUyMUpzQkRWR0dtVUZBbzFtYnNqSlhHODVXU2g3eittZ0t5SlA2?=
 =?utf-8?B?NDlnSWJrT3V0eldZTC9wUFVCTW1YNDNTb3dvRDZ0MlA4U3JtNXRxUTF1UnVy?=
 =?utf-8?B?czlMOGdvUTRKZ0dBQUJCN2VEVDZySHdVdW51dzFVOUNaUHZuWDVHNU9KVXFq?=
 =?utf-8?B?YlNWWndNbml3Z2FnREpxbmtxWml0MjZtekdKcjZrdDVObjMyaXdnaFU5Y0N5?=
 =?utf-8?B?dUNpRzR4ZXRUQk9zdEtwQlA0TkJxWTRSVDA2c0x4NkFIWjZTNzRQaEhXWm53?=
 =?utf-8?B?Z0I3N2NvSmk2ODc1WEJDdDQ4cDR1cGN4eDRjd3FHSGZmaHFmeUdsWjg1ejho?=
 =?utf-8?B?NEl6MU00TkxYdkJlM21XbTU4UTNZT3VHSW90ZE1KQlR1cEpTbSttQWZiUWFl?=
 =?utf-8?B?NUtmT2xuTDFFbjVTd045REpsYmMzeE43bWo1Zk14bTAydFp5V1lwUEZVdUtv?=
 =?utf-8?B?am9qNkQ4MFBWQWg0U1JXRnUydU5PUFVTNEJFamRZVmhzVG5mYTV6ZDhHVGVq?=
 =?utf-8?B?RlZwTW8vcmc1REMvMExuZ1hUM3VndXU1SHJiZHc4TVZLTjdYUi9OZ2pVNmlj?=
 =?utf-8?B?MlNnU1kxT1JxcGJnTjdHNXQxZHg1cXN2WmQxUEdaTFowZm8wd0F2N1JMYURB?=
 =?utf-8?B?MjMxYnVUdVBGSlVlaHJVc3d1b1p1TjMvTFgzNjRBc0pmaHNZVktyNnhJRVlo?=
 =?utf-8?Q?RxiwlJy/MLxSTvstWTuYfi5w8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06730c13-9553-4687-1dc1-08dc1b117b64
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 06:15:08.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnsPwQcHm8x28kM6XtPTp8ptdpWR0eQeSemm6p9sfSwkyKoQ3SUYrK/Foa8xgBe4XQEDeoYgCSYcGrygI68Bag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7991

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 Generic, Secure Enclave and V2X Message Unit compatible string.
And some MUs has internal RAMs for SCMI shared buffer usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 50 +++++++++++++++++++++-
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 12e7a7d536a3..d10c6fed291b 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -29,10 +29,14 @@ properties:
       - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
-      - const: fsl,imx93-mu-s4
       - const: fsl,imx8ulp-mu-s4
+      - const: fsl,imx93-mu-s4
+      - const: fsl,imx95-mu-ele
+      - const: fsl,imx95-mu-v2x
       - items:
-          - const: fsl,imx93-mu
+          - enum:
+              - fsl,imx93-mu
+              - fsl,imx95-mu
           - const: fsl,imx8ulp-mu
       - items:
           - enum:
@@ -95,6 +99,17 @@ properties:
   power-domains:
     maxItems: 1
 
+  ranges: true
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+patternProperties:
+  "^sram@[a-z0-9]+":
+    $ref: /schemas/sram/sram.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -134,3 +149,34 @@ examples:
         interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
         #mbox-cells = <2>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mu2: mailbox@445b0000 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        compatible = "fsl,imx95-mu", "fsl,imx8ulp-mu";
+        reg = <0x445b0000 0x10000>;
+        interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+        ranges;
+        #mbox-cells = <2>;
+
+        sram@445b1000 {
+            compatible = "mmio-sram";
+            reg = <0x445b1000 0x400>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges = <0x0 0x445b1000 0x400>;
+
+            scmi_buf0: scmi-sram-section@0 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x0 0x80>;
+            };
+
+            scmi_buf1: scmi-sram-section@80 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x80 0x80>;
+            };
+        };
+    };

-- 
2.37.1


