Return-Path: <linux-kernel+bounces-39656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE44883D53E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30221C258D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781E2134C4;
	Fri, 26 Jan 2024 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fQ5fkDb6"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803CFD524;
	Fri, 26 Jan 2024 06:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250305; cv=fail; b=KxAJMFRpLdCoagxma2lXqxFMu1uLt5b6i4aXm14qv9V88sDN0plUBeiFj8an9KvAiNNP4o2sslbaqNgZGqDRbIdeYF1QA09PAX06etbNnOt46Dy8TTVIL88PJFdm7vgLW9iFN6K7l2n++wwxaLtIl//0VAzMszLUIXFD8NRqwRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250305; c=relaxed/simple;
	bh=dV1JE2dBFykGtry3QCR0342Elkljg+vxbwFLX4WBv3g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NDaASmgclS1n+MgVID2p5SVW2G7U+kaqDqAzN1fWXOy599JIySUiYIxb8eVFu8BrIWyFR1mTmA4wdM/uzseBLPMFZ1RmOIAQPRNDOr/GOigKrjDDmqanfeIggKBtUvrv0naTtyfX3ndZWmCXae0J9ehVwS25XQuh5xobAezJjq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fQ5fkDb6; arc=fail smtp.client-ip=40.107.105.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnOWk708WgIN2/RBkHUX6pFPWN0Uir2SvTWo2E4271zWnQf9lpaccX1JX1mYK8k0UdJC/MWSTdB5YqbqK7q3fm6UI5HNCD0Q+bSOKXE0Lp6y/gB8PBxMpLiTyQSgW7o4JSUxjja8TYC4DiN8WKTlS7L1bIyrkWX+PCsttOJ+kC05iCm3HaeBQFE5RNAt7TAgB2Ls/Ciwz4Krn1SoW51AyZWO3ALRzcCO4zvKNPRrEdbE0XdSAsoD6LthLzuli1Aw9yT2gpbOdm+ydlNQ69iIK1SpkP/dPqxCW5Jov5cgaKfuUEsVH3wiCoz+oBpfa3KFylY8/kOTNcXfdK3+bFMV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BsEtLvK2LO5kx/XmsIcliJVjFv4jEF43rbFLLOuJOQ=;
 b=Yb3AC8Gq0UGUGZb/hqB3LozFHaEbKkgGSslA7xFDWvWz/piqLsDn0OaeZH1mhKQ6xpccCWb/n8jUqV0n0ba8B7w9HOA2aWLCeoDwyAmm+bYrj6QbiBcGb/1Ja8MtIxwfjGzjIRk9W+4/G7v+vT+6m3fsDcyW5cWf6kL7TOWn05NqHXxzyW10+SxW8aJNeHOFp+/txHUFsU/85pw6GdLFhTOj3sD3nU+bNm/Lmaa2XOOfIznmVsY7PvUvLpVamapVH//CKYcfst7UvI12LH6cOmGc9XuB0j89d83AW6yZWsWrj5wCoxJDJvICcYMN8bnVMZTNTXMEI3QAl4jnW5rBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BsEtLvK2LO5kx/XmsIcliJVjFv4jEF43rbFLLOuJOQ=;
 b=fQ5fkDb6Eoar2Mkr/wn5nybItAoNdFR09tg26lHC23AisaBVot2Y0Yc6mzsCl3B6UhwcOPu8gbgCK0HMcc6pWbxdT/p1+bgbtZ99fRzDKIiFvR+SKQMs6T4MCUKmqH28kutI2ELc319DpPFQICOodiDDjS3WLt//ciPfP7Qom44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6851.eurprd04.prod.outlook.com (2603:10a6:208:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 06:25:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 06:25:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 26 Jan 2024 14:29:14 +0800
Subject: [PATCH v5 1/4] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-imx-mailbox-v5-1-7ff3a3d53529@nxp.com>
References: <20240126-imx-mailbox-v5-0-7ff3a3d53529@nxp.com>
In-Reply-To: <20240126-imx-mailbox-v5-0-7ff3a3d53529@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706250566; l=2712;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=TOwsWAbXauMQsQBj77QPNsiLkiJ9S+3QBpYZUzgpilk=;
 b=ee7xilz1WrxvID9wR7kHpZbB+sFce3HHWaZsVwzk9NToX8UoN7a3hOcUcPIURlg0KiQD7bM3U
 Po4tkFY/DzLCItD4rxWNrktUR2+PiDB/NRLjJt6g823P4Ik4P1MIU2F
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: e5abe841-2b67-46a9-3efa-08dc1e378710
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yEHRSIhMo8tMexeqpZVX5W2vhMcMsnTOMFxB9nlnes8H8hY+EyfKbjjQDAlGP2tfuPtjfK+o9ercvsVuxUb20+PgNZiYYl17PCwHPoGtfLteEhGAsFsJYVg64jqO6HLTDCCHdJAacszf3Bg4LT+NVzB5bGVLDD9DcOh7oq4ZhPDd7VEufvzINkJu95rdgZey5y6k/28fRqyxnu4pEFtsCehy64G2EzYhurZ3hpioO8aji5YrkywTCl12mx5bEvT0VAeP8TcWGIkTAd5W8stf5GdCB30vB7B5hXWlEBAWknpFftya540qgIzKogrpFFV24aNyPhocH0440RHCXgXI9rPbMH6OoaITVBBeJ7xkZpPScLsxtMbNCxAgRIAXjkLre7pIf08UD3XjeQV2H4+YL5hESnjq9rT3bbYXhy3u3MITodpboQXTcZn56AMJYfhy3d6RhbPXx1mSsHa2GR4v5rNzjvJ3TV4wtfIyfqqfcBQ4MkAIogkkBJBJYhks0VwIuBZljhtjFtpz6n0YfyWitLd+Qq0c+omGsGqbEh42p7fCOy2cTIQFtyJA7ImxJdg52gZg50qOLwoXkedtIVR+FJQCBOBnS9ab6y/t3xOxpP+AEjE8svrLZfV6+oMMr8KzaXoOSaA9k0a9jEFfQ0NwV5VEg/mZFsPwjOvGSaLzFGE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(52116002)(921011)(38350700005)(478600001)(6486002)(36756003)(86362001)(26005)(83380400001)(38100700002)(110136005)(8936002)(6666004)(9686003)(4326008)(6512007)(15650500001)(8676002)(316002)(6506007)(2906002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(7416002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXZjaG5CcGF6MjlXdGo5dE1RdWlEdW1UZGM1MkpGQ2d0R2hBUks2S2tVSTRq?=
 =?utf-8?B?elNpR1NhYlFTeFJSRmMvSzBieG9EMDcydVpxNldwOGphb2FZV2t6dHk3ZlFo?=
 =?utf-8?B?OUdkM3dFUWc4V3NWdUNTTHhMSyttbkUyR25UbTBQSURsMzY5WmdwQ0hwd0xX?=
 =?utf-8?B?ZGY3eGlJWkk4THVpb2RGLzdzcFEwM3RROWZWcHN1YU8wZGhjekJjU3lKMCtw?=
 =?utf-8?B?akRJL2ZNVWtVOFhNUUZDaDM4ZXhyZ0JFMDFOSGFxT0h4MTJ4NENhVmRMYWVq?=
 =?utf-8?B?aDFqZGdFc0pianhlQVlQS1lrclpZcWg2WUoyNkhwZEtOS1U4ZTJsb3FqTEVE?=
 =?utf-8?B?UDNoaVRBNDZDSFRLbkxjL0ZtRDZZUVF0TTN6UTF6VWVsblNnVzhlVVhmMUIx?=
 =?utf-8?B?RWRCQlVHM2pyemgrRkNES3pyT3YvMFJMbC80WHNXc1dIUmRuaWVRV3B6cERB?=
 =?utf-8?B?NWVtZWE5SHAzbFpwQ1U2OHdIbWhtMFVNeVR1cjNJMUlCelJJSW1KR2RyWENR?=
 =?utf-8?B?T3l0c095V3o1WkYyRjNtRlpIT3dnUERUSEdhTE1CZGhHNkdvQXNqU0tJWk9l?=
 =?utf-8?B?NVpXT1psVHNyZ1owMnRjZk0xSkcrbHVvaTR4Um1wU2xqMncrMEFHUStkMEM3?=
 =?utf-8?B?U1lJZlBiSHJFdjZ2UmliNnNZS1h4S05ObnVIdndKVXE2bFE3WW0waWJ5V1E2?=
 =?utf-8?B?amQ1MEFuaDNJNHAycnFmQ2xidkJPd2JGQkdCUXpWVDBwcWxTOEpCbURKSHd1?=
 =?utf-8?B?bWF6TUFIanBndDZBbGExV0M0UjM1OExWQVVQTVBuZkdyVEdsTE11MmZMVkVK?=
 =?utf-8?B?NE15WDU1enlob0VUVWRPS0szbmoycmdpSFN5T0VZc2tZNUkwMWpXQ3dXNmpm?=
 =?utf-8?B?b0FNUk81NHZVSExnM2orZUx3WCt2S0lYeVB2dklIb09Ed1dyN1AxSjBOcDZY?=
 =?utf-8?B?dWV3d2tGcFZXMVl1N0U1enNRcy9Lb3AraEVBaEU0T0hudFZ1RG9JM282Y1Zk?=
 =?utf-8?B?OHI2a28xek50blc3dTVSK1RLMC8rdkVnVVoyemt5TW5WaTRZMEhCdmFqZGdU?=
 =?utf-8?B?STNEa1E0Q09PN2pNeFBZRDYyRitYV1dNSWZzZTZEMi9pTTNKZ2xPdEZKZDZT?=
 =?utf-8?B?cTdmUmt2YVRYR05BcHZ1VldLVzdjV2srdnE1OUpQV1JoemFjaW1tK0RFM0xt?=
 =?utf-8?B?MStaVkVuTXdubFFDQnpxZElFQU40T0d5NkRxTXEvR3VjV1cxc2h1WnpNWEsx?=
 =?utf-8?B?MVBTNHhHbUtSTjhBajRwaGhzNDJyQTlwdEVibHlHcGkzcjJxQ2FUdjZ5dy9X?=
 =?utf-8?B?MEtwdTF0VHVtNXdtR29uUjRXd1FEblBNd3o4UGVXbk80bVhmN2FOZjZsVEVZ?=
 =?utf-8?B?eXhGRm5mMW1uVFpKVUtiMU84Z1JvUTV1ejNvUG1uZXJmV0p5RkRrajNVZjZK?=
 =?utf-8?B?emlEOHFqWXROeG1vSmJwazhyVlUzV2d3NnRkcHNqUXhYTTVGZEo4enJJRk83?=
 =?utf-8?B?cTM4RmZwcW1VclZKZGFJZVcxSlZTald6MG1XYXdMV1MxZFZPZlg2VjZ3MlpQ?=
 =?utf-8?B?MXpIU3lpeG45Mm5rcmVuTXpaa3lSV1UyZ0h6RmpXUElkVEtIYTNNNi9vUjcr?=
 =?utf-8?B?Slh6cXlpc0JzK3VNbURJR3dOTUQzSGM3cE54SEJFSGhIUWlrMHJzNFdPTHJV?=
 =?utf-8?B?b3FEWHhUTmJaL3JuSFhvV3Q1OTBlUDZkZFBCSENaUllteVhSbFpaS2M5OERN?=
 =?utf-8?B?N3Z6alFuRmcxeHo4cDU2Q3BjckRMTnRwVVJuRUJEekdkNnJiVVFBRC9xMUhG?=
 =?utf-8?B?ajk1V3hxaXNaZGtjSWlydjBVLzd3Y1FaRzZUbVhIckRTWThrMVQ2UjhSQ0g0?=
 =?utf-8?B?S0F2L0EyS2RFeWFwUFlZZHdjbFRVODBqK2EvK0xtZDZuU2tpeWZDYmxHVUZD?=
 =?utf-8?B?RndaVHNCM0QvQVRaNFdQUXVBaEZsb2I1bFBFNWYyN25DYnVWb08yeWZ2Y0tK?=
 =?utf-8?B?VGFUZEp3Yy9keWdmUHk3QjFIcndRK2l1eGVyVTkxeFFEQ2lwdTdyWVkxOEI2?=
 =?utf-8?B?UFk4aTFnWk1jTWlzWnBST2NzY2g2eGxQRUhlc1dTMk9vOWQ5N2FwajFBRnB2?=
 =?utf-8?Q?SFOCp2jXWrnwMc+DqYnZH3nQ9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5abe841-2b67-46a9-3efa-08dc1e378710
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 06:25:01.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtwVNwZpUQrwjveleuNTyqumloeCy6yoKfNVvMgKi83t3f9owzIQ535Jf53WXNqURJk06Dl8ayIxJ2Y1+MFuWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6851

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 Generic, Secure Enclave and V2X Message Unit compatible string.
And the MUs in AONMIX has internal RAMs for SCMI shared buffer usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 58 +++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 12e7a7d536a3..33140f72da6d 100644
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
+    mu2: mailbox@445b0000 {
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


