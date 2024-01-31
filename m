Return-Path: <linux-kernel+bounces-47365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D6E844CE4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696F31C257EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A0113DBB0;
	Wed, 31 Jan 2024 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="a+VYs2vA"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A749C13DB88;
	Wed, 31 Jan 2024 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743297; cv=fail; b=lB0G4Yb6yZkbL/QmEFMRCY+8Gc5Wg0h8MgSqkjyPojrr+meuOzmyQHLMVCLcl00EtscTjbzPQFDYGOcqgBltuNul/Mn7DgIbpQvMYdHXTWhE8NH6Sl++egpLOADGlqsao54oY4ploX6CL9JED4/mbu5F6eZhtTJGuJfxoK54kFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743297; c=relaxed/simple;
	bh=MM4hGelQPWJBCNSBHauYYOUJtAGkks0oEt/r7CVecMg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SOhkDqxkfSu+L6MjAIuvf02h1zzmeyNGokBqRaLzM8wsMoDukh9gLaSJF3XLjYs0D8lnkVRQy6khSdJ5kK4d75mRtepr1Em/QSDzCwgZH/WK/ZQJy7Fzt+v3mAb+Hzsn9pXjvqSTNtp8reSI4fOvpYyczpYvwpnHUFVGvFI8GYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=a+VYs2vA; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7I/S7iIr+SfLhoJ+iz5p32jJbMbJ9+MbWKtrZlnpC09SEEsUTPHqbDzYAcRJrhxIv8VxzqixSk5OKwCIUotpP4WHTE38jhp3xmU38wj9RsZ86sEScTIsJQYwLcIU71lfNpt7Mn5ej2nz2rVt3cTYFv89BEnVHRJynT8YZJ3n2UApKUP8Jj6nhQVRsnuYVvepVvVQeUNOJuyoNUTPquOWxOp7fLp3d2y9y1hvX0Jo+Uqqmz4R/PNJqWjYgLMTI5oVB41VZA4E40RMw4CO0HHdMWKRDMjaVVEfWvtD7P8jNWuBFsMXEgwuw9EcVpsKx8UcXEwmlejy+FjKTpTke71JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KvOi/dUrQ1BiOs5m/DkXp9FaTqjukDIJmIW7LA79+g=;
 b=Cr9fXZHI20tRRbycD3OKkfxQXGFUh+ArpxTEIehxlJ9ZJQrakO40acLcpV7ASGiGo37JnJAZXYvsEEe685Z9pgzUvg0SQMWvpBCHM+TN22S9IzzKik9c6i88ZExm++1WDjGpNLK6dG0DiWdxIuiM2aRkmDH9VTCkZU/44mWcB3C7FzzjhBwRW5KYH6mqxPOJW1/4/EoBl2qRZVBdn5P7jRD6gUKo6VTBdCInLSLOF4VPaGCWPHADjjwuZoXTx9PS95h1zKz9U3qiSMnaDJ5vIwanlVDUyhUXtNH7TyMUy5CQdIUmVCI8JuF4l0R4YRtHHJ+48/AHfrRbWZiSE6NeiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KvOi/dUrQ1BiOs5m/DkXp9FaTqjukDIJmIW7LA79+g=;
 b=a+VYs2vAWcpzsxofriEgt0nDp7o2l2rQMhDF2/XCMfu0BE6X4bDZGOxnJacmnrNlkn4NSaYCe845QpWrT7EonOGor0FCLyKlnD7z2zUvWHFH17AyTtaAqYe7/UmblVbXZ7BgqIvQw7zxFIrirzpSIIexJ+fju86d5GyKRO2+Czo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7396.eurprd04.prod.outlook.com (2603:10a6:20b:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 23:21:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 23:21:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 01 Feb 2024 07:25:37 +0800
Subject: [PATCH v6 1/4] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-imx-mailbox-v6-1-76f4f35b403e@nxp.com>
References: <20240201-imx-mailbox-v6-0-76f4f35b403e@nxp.com>
In-Reply-To: <20240201-imx-mailbox-v6-0-76f4f35b403e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706743555; l=2741;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=C56rjccJP8TyE3Eb4IvcogQQf1ZEIotnAVpBDSA+e98=;
 b=KLcThEvzo6Xy4sMKRqGkO7miDveme4FdkV8yn3+zdMIpf+UBI92n3tuPIsbCHhuge1aL9+tyF
 sxf9QNjK0bTAeq+mUwLanv+FnEZJbXtzwVGauq5RfyPnWi7XiSdNn4F
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: 7691dbde-9938-4240-aab7-08dc22b35ca2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	joId/7+XBwTv0xAgR1Lwry10FgQjB7VvLbKJDZCunJiDlJX8ipm7u3JONar2n0Jfp0HwVSPnsi54bRbSagNMAE9Hq+ENMT3/tFMCgxlv2jGLKySl7rdeYaKQov31CUf9mC/Pe2Y5jbSdYAUUqC160a9eDtwlKs5afo9zQe7JNUZtNmJ3flKSW4EQPnCe0Ut/C7bYxO2q/c7hBIZEFLLwSV7VjsNL9thkr27mDsPsKBAvRKOtUAyF61Uo7KhFUZK82rtHHPbTjYP59VdhcPwPUMD9rmN+SmxydRsgxvzinQRCRhp/u9+CZusbrp4GGn9ItpqHzt+yZ4hTezpcqvc/kBcNgQvO+6W/tGKZ/Nl3CIW0ve+Ntf3mq60r07CZpeUdIl58gdIQ/ZNN1kO+pW2HSQS8gLzTxAtOf5ctxjbZZCnLqWT/mMEkXBsDbfIZNyglJ+r0Rn4lRSvtCjYqqzIggNpp9R09FWN7+m7OURiXWgRG2ot+G/eLApk3aNADZaO9Zi9VpDgQjuKYZX45/s1h1yd8BcvRYBUQGBjYsr9PmpxNQXOPCcdf6lScosxI9ddQjEZP39FsRNufQQRkcB/CiBvsEJng1TIS1qXFz3cqJWKwQwj9ONwkmrS8oCvE8asJSw4EOOifIBMHxDwvjaboA3HtLv8PX+uj/vnnqSnlEDg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(921011)(26005)(41300700001)(54906003)(316002)(38350700005)(66556008)(478600001)(36756003)(6512007)(9686003)(6506007)(83380400001)(52116002)(6486002)(66476007)(38100700002)(66946007)(5660300002)(2906002)(8936002)(15650500001)(86362001)(8676002)(110136005)(4326008)(7416002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG5yMm5udTBYb08zY3g3KzV5S0gzcWhKL2lWblZHR3RjM1VMT0MySEpBaGxJ?=
 =?utf-8?B?ZDJ2cGlCL0RuMkxoZmJxWmV0aG1uLzd6UUszbmc5UW0wWEttOTA5czF4N09n?=
 =?utf-8?B?eHdYM3RWNWh0dWEwUGNvN2s0Q2dzZjE2dFJjVTdsakpRRXQyQThpMnNnYkdm?=
 =?utf-8?B?UUtKaDZha1VjNlVZNFFWb1ZkTEpZNU95aHFTdXJnSHhTUHFTTk02UHBqbzkx?=
 =?utf-8?B?YWxZZUdXeHJoYUgydlU2ckg1ZnNoYTJWZGxneUFUZTN3alZnR21DYzJoT3RI?=
 =?utf-8?B?TkZBbEhyRVI2N3dzV25hdGxrUk5jbUFORVkrZVRZRTNzTVVlSStRZWxOQWts?=
 =?utf-8?B?UHMwYnVJUUxoY3hHcXE5SkFLNVRhSCtqbzRUTU1FdmNUVnpOOWdjT3pBV3lZ?=
 =?utf-8?B?elM2ajZscEl0Y2trcjV6bnpXTk1WMEhSd0krUXprWFJVQ3hHUjd6YXZNREkr?=
 =?utf-8?B?SUl5Y2JOaTVrRnRLT0F2VEg4ell0clhzZ3VralgyMTlQSld0bjU0d0Vsb3hh?=
 =?utf-8?B?bzFkd2tGZEZNRTNjbmxZdy9JSnlCeFFraHpSQWV0SG5DMC94NTk4ZXZCNzQ1?=
 =?utf-8?B?bHloQzVpYytjYTFaeTYrdUpsS3I3dW0rNHBQSWhsSjV3T1llb1VWZzVoN2ZL?=
 =?utf-8?B?S2p0NTRiZ2k4alUyQkN4UjgwMjJjTlVQblBNcERocVBhV0JTTmFUL1pZWld1?=
 =?utf-8?B?MFYrNWxmYWIyQjBONU5mOHFJWEJNeHpHMDZrSmQ4OHRUMGVmM0VyZFQwK2Zr?=
 =?utf-8?B?UndGUWhQUDNXZWNoOU9rN0lQKzIxTFNBQ2ZCdFU4L0tmdUQzQ2o3Z09wOUJl?=
 =?utf-8?B?NXBwdzFGTDN5RXdidFFEMzh5dWIyYk1HaVRUMFR1MlY0Uzdsa3E4Y3N4djRa?=
 =?utf-8?B?Q0NEZ09yOWNneWJKbTc0TjZTWVJYRjlmOTlZV3RHL3c5bW1RK2cvTVBGQnY4?=
 =?utf-8?B?Z1JJUkdSaWRhZVppOFZ0bDFEc0hScUhrcGJjc2NPdU1OelVHZGptVUVETXBq?=
 =?utf-8?B?WHpESk04MHJhOCt2aWEya25ZMDRSUnBHODRGbFRKQjVlYlRwYWl2aUJQVXpT?=
 =?utf-8?B?THNYY2s4OGZIMkZoZmt6NG1NRFlxblJkZVduUFlVTEM5cGtaSUNHM0l0S2VR?=
 =?utf-8?B?Tnd4L3gwa1haUlczeGErbmdJczJiQ1UrK3FwaVZ3eUdRTTBFVkE5blR1OFpI?=
 =?utf-8?B?K25CZUJSd0tqamw1WTdQWnVCUHplUEpYL2UwZzR3VVdqbUhDNXVJV2FZdS9G?=
 =?utf-8?B?Zk9vZFdLWUdpc0tNM1pWQ3VqczNnYmxvV0Y0M0t5WnowQXdqd01vUjhqVkRl?=
 =?utf-8?B?Yk83Yk5odkhsbHJtZlM1OTJVTS9DQmFVc0pIaG9OMGdhbnZNbXkyeWd4WFZV?=
 =?utf-8?B?dWVseEpPVW9SMFRBcUhmWElkVDRuNWNFRnNtajhNUEwyQUNpdDAvQjlYNEQx?=
 =?utf-8?B?Y3Q0ckRGTVpHc2U1akhzWmpGZExjZkxxaUlLcVBDamNDS0U5cm5QZ1hCT3VJ?=
 =?utf-8?B?Qy95OUFiaTVMK0dBTlZONXdTbW1SOFJjMHQ3Z050V3RDeTVxR2I5N0RuZlVC?=
 =?utf-8?B?eEQ0cnAxTE1NMlJWam5rL1ZFUVh6OVpmUko0WXNNYzNJOTRiU2R0aWhTaGg1?=
 =?utf-8?B?aW9DZUpQR2NyNnBxNGpJZkZvOGhOd1ErZ1pSbTNTdzkvVnNVWUhOM0k4SzJl?=
 =?utf-8?B?eWNFblRSdWJxQUhRVXZoSzh1WVIvWU5VUzJPaW1uZThENmdEUHVwaHVNTm9R?=
 =?utf-8?B?ZHIvWmxZcmVNNERxYzdwZnIwOWhLclE2Ym5nOUFjYWFaeXhFd241UmJhVDRt?=
 =?utf-8?B?QVpLSDdLQkwvVDBkbFp2UDYxRGRUbU03NDVKbW5uMUJYUGlmU2VETkhLWFph?=
 =?utf-8?B?ZDhXckxwUGxnOGRxQTNzQWltVmdEN0FaVFlkSVpicFFidTd2M1RlaUljY2Vv?=
 =?utf-8?B?ai9xZzROWlg4SXBMRkVKMmNXekdtOUxTRTdPZkZxUlZTNFVLMGdPU2Y5V2tx?=
 =?utf-8?B?Y05HeUFKQVFSUWxLaHo1VWN2R20xQUc5Q3E2MHlBZ2piUlBpUHpEcTdKQmVH?=
 =?utf-8?B?U1hzdld0VFJIZ0tKQVBJelRsdFcwb1JiRkdCeW13OFl2alRpR0lDeFJTUUJW?=
 =?utf-8?Q?eunMeLwRwM8Xt1vMRIa/pUcm7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7691dbde-9938-4240-aab7-08dc22b35ca2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:21:33.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 913uIOHxg4pQbhW2gEHbDzGTR81ygnPLVQub/KhuhkY5jpISMW415UQOfcunhMKLfjuRavQHoIQUXBvu2N2Hig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7396

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


