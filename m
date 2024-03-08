Return-Path: <linux-kernel+bounces-97241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F3D876770
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69151F21AC4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5423EA8D;
	Fri,  8 Mar 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C7u2dCBK"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2041.outbound.protection.outlook.com [40.107.13.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8F2D78A;
	Fri,  8 Mar 2024 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911887; cv=fail; b=JUJAcqUKWr2PfIVXY4i6WUvI6EoayYNrRAvHjuPr3qJemcf9TSuaiOPDVQWXd+gjGJo5k9wFGXrQv2aXrI9noOsRTC8n3DlnWzOLoMwEo5n5npeIewqTMvqdGk5DFJ0b/P3f7BxzJENRayZQ7PIKRO4NGwLRHwqchBOXicakzao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911887; c=relaxed/simple;
	bh=ty5f4I1ceJv/bmgzC4ekvcaYJmsOaQVPeFLA9ZTjxrI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GEyNbSHig7mmxPdT4iq/F1h1rTrOCpFsmb1qwQF/cTVvfLY4tYw/u9QKE3Lby+VtLs+vDfxIrgE5mbWJUV/Z58Yx3BR6Tl9KCwVlRcys35x/+FiD1yNc+IDgM/Dus1WDrcqzLmz2G5gzbc1PeDFgiGpttoj4y7EWVtgJWW9zTtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=C7u2dCBK; arc=fail smtp.client-ip=40.107.13.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O33ZbBOL67O4eDOgeL6vE1Qg7S160LRLW/xqjg2L02ZuMw1lMxRnC5GPtYWos84XjG7rw4y0FeFtjE13au4X+IZJbtuHCcutUBPhpekrCu/sWxCuPWkSf2zCB+3/PFpEXWvxd9e9/mWzT5Fb/tX/69UZ0FBDHdsp9gqJujj4ZBbJ+Yr+o8Ff3CPcjO6pcvemx1P6zvez8VCyJcPAjNGbFlbu/q9gdUJRHMf6jixO82uRoKxFfEagi5cvcD1igiYG2Sm2CNjky9onK7mLQFdPvt9suGyFZQgIxofjmyzUZ7CDu7vvQEVtLUT7Y8lXsLf5F7foRidTdU+WB4ztJ0cLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry9d1O8ri36OnOsr//vKZPxLW9rq4AUGvF6G/VAl8Ic=;
 b=CVk3XHt3czf3HQdWIjFZ7cUvWlOztdQ2BOf8fvzIU3UQtIMpoTte34S1LQLGgprcxmkcv7IMOhLkqhLDyQW/2uFksBsOgVbhD7pDx5R8zFM7JDUZobGHw1q9eSgT0uPgG0xZ7+7M0w6whbvVV7GLZCkRvte6iApkVnTf5D6aWB30w9vsIoExhaiDP+czo6E5zZege42azbo7htWJADGkBdtovrDk8MjI9U/skrcPqr7SIyFHHxjV/ogdZen5JrjJXBilBwKevb8R+Wx1MVKRG4Sd+0hOGKwsdV12fp2rAIF9zOFTHDhoTtc/NCcyYGMlpJSEPhlSGRw/p8ej9WuGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry9d1O8ri36OnOsr//vKZPxLW9rq4AUGvF6G/VAl8Ic=;
 b=C7u2dCBKCsZPf8cq5g5Fli+X6rEuOyfb/q4TH7/honr7YnJPa/X78aD6w9s0UN2ozT5A46C9KoWtnHMomJYXMtUng8wUKymrzuImhs4m+88U4z+Z77LT0LH8UYb+ObRmg5iUWs9ACx9sN8kuLdCZbUmnASBsELGohYige5tBYlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8116.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 15:31:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 15:31:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 08 Mar 2024 10:30:52 -0500
Subject: [PATCH v6 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-asrc_8qxp-v6-3-e08f6d030e09@nxp.com>
References: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
In-Reply-To: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709911866; l=1255;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ty5f4I1ceJv/bmgzC4ekvcaYJmsOaQVPeFLA9ZTjxrI=;
 b=6W8mAOAo4PSbsV23QKNmA6mss9ebhqq+84S+DUZxqDR3U2XCnfUXtxxKrdIlpES2W6laYjki8
 p3tefBVHozQCmcVLvjRgv+LX0uI0Ks0p6nd/am+l82zT3IK5XT3R5Qb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0151.namprd05.prod.outlook.com
 (2603:10b6:a03:339::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 089e35c7-0a8c-4f3e-904a-08dc3f84cfc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vIVm2r72eVYNP3lX6pvvYSrkJiTMyLtH0/tSljXN5WvDRR6nOe0Wf4mi5fFvZauFQbJ2nLng3KiUFW8A7kIP6/8m/pY6yHh/08zbee48yLmmGVVQ8Zj8/GCxTUuIbpZiaCMcruz4a3bhASOeJCMpvWw2PuoG4apgYBxatdadl+UlmJJWlxVroLjvethwD4xLauMKT1kuRaJ0xx5XXBs89YqxmH7Ooj4b/WcoZBXDrNVw6dUTUKDbCPZc2FnQhLfD93eRH09ewzkOjRD5SnU4xzL5hjSVSXCtG2Y3Qszd1AnEEWuh+UJp1VDtXQejIlstUyiqJKlcMkUP40az1yc94TR9CZHyaKMkPl6yJijpn+/Fc47rtPyxTZBTc8rA94DM6WtOPLeYHTolX0OXLNaSDx1JQ7aOQP/Hb6YX15grUi62/eiqPYMyTDb5aHsYpAEd3VgvknlYiFhNH8qV8F/e+hfXNCayNzNKj5jOMjREnq+ED5KZFJBzxDVUo/jUVccZLkR9ssOUyVZ4RpFuOuBUMuxPibXR66x3ZlzDlVxLVcF05ncgmPvA1Fj3UFXzKixaVlI3RAIse+2VYl2Sx0D7BXeJ9KS8Mk3lN4817grItTKVgk1HHzWmnYd5+/EWlf2yCbEvoy2pxUv3wsDWyYKadFLZIaUvzxk63WtFFu3EYbbxoGWS5ss36WQN/Eyhml+eHiamrZ6AMtruWyVXY4EAWuK3Gfqs85mXxS3q1DGfvMk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0tTbC85MFVMYzc2SWE4RlcrQmI4RlZQWmUrWlN4cktLQ3NMZTlSOTFVYllV?=
 =?utf-8?B?cktSUkxhUzZzRHoySkx0eGpWZllDK0xqQi82NVE0RUM3QnpPVUNNcklkVTI0?=
 =?utf-8?B?aENPVERRZlpGN0pwb2dKZmNFK2l4SldiOG9mdE1CMU5HSXVFWlZnVXp3TFEx?=
 =?utf-8?B?NUw5YXZZNzh0UlBNYTJDUTlFcUFoZHhsZEhIa1ZYK0lmcTBVdUNQSjVLaVNx?=
 =?utf-8?B?T1FmWEJTN05ZdmpFRVZROENNcldDRFQwdUJRTGs0dUp6U0lYaG1jS1RMUFd4?=
 =?utf-8?B?Z2VVWlRpR3B6KzRjbU5ydUt0R0JkejdkSEQ4MWNUczJ4WVkxU3hLRnYveEZT?=
 =?utf-8?B?WGI5QXI1aDFjbENzRExPZW04eTZlMDQ3Z011K0ltUU11ZGN4MDdHTDdkbU1j?=
 =?utf-8?B?S2x4R0EyMElrcWlCdkNRVTc0Y2RSWmw0SW8vSkdRczhWUUNTbnVza0ErR0Zt?=
 =?utf-8?B?Z25VY2ovTGtZWlRRNTlZc24xVEd0TVdmRnBWSUl6Z0JCNldzaThBbHplNEVq?=
 =?utf-8?B?VHUxYXNoRjlBajJSci9HQmQ1c2JYRlo3cDc3Z1dOd0hzUXh5VE13Wm41dDlq?=
 =?utf-8?B?MjhFYS9rdGs0M29VcUdHbTNUZFh0bTJ6R283aGRvaktWbUJyb1FoamxlZFQ1?=
 =?utf-8?B?Z0Z2TlJkMG55aFBnZGJoeHlTNjI2QmM2STdva2xFZlJ5K2E2R0xaanNMeHhr?=
 =?utf-8?B?YjB5YWxxSUhQMU16OVFuNzgyZEJLU2NJQWZxUzlvWlpQdWdiSS9GS3c2ejlp?=
 =?utf-8?B?R1lJZzUvK3ZqNVV6U2hWSU9FTDBLc0JIdHB0SCtNTEt4SWFjVGFYQTh2TVpz?=
 =?utf-8?B?WkQxVklQRitUUzhWamtNYUhTcXdaaDhDMUoxS3hJYTZXQllYbTh3RXg1Nm9H?=
 =?utf-8?B?dTZSTnVjMVFqemJVRk03RWdUa0xNOEdZM3pqa2RSczhUZ05GaXdiNmFDczYw?=
 =?utf-8?B?VWtRL3ExbnE5bXUrZ054c0FMWlM3SU4xS3pwSnR1blRTNEs5YU5UM0RkU2JG?=
 =?utf-8?B?THQxUzlGM1V1VjRTeXIvZGFheUxUbnNzdkFEUitCeVJQdGNYL1RLRTFyOWln?=
 =?utf-8?B?UlVLcXh0YW1nUURpL3lzRTlrSERnYk5RbTNlUTNOcW8rYU5URzB0RzZadTdT?=
 =?utf-8?B?dTMzcVpvMGlkNDhYL0N0TmF2dFlhMXVpRDdTTXJZYmpkM1VqMTFEMEFMKzM2?=
 =?utf-8?B?bW5oNFNIR21MS1p0b00vbTAxSHRDYWNCOEZWc0pYdVZlbVpUWHNtRGxZb1VJ?=
 =?utf-8?B?dDhrT1JBNllzdnJ1dlFpeTVRSWFYT3hXaUY3QzNuMlZ6eHhqTTRHSStnZktP?=
 =?utf-8?B?ZVRFVnlSYktrU290VEs5THBROUV5V3kxOFVZRlA3RFNRMXdPWmp2M016aUNH?=
 =?utf-8?B?L3I5OThKeUlSWUtkN3VndzhSZzlCam15b0dCRkU0Yk5rb2dmN25BT1VvUjZs?=
 =?utf-8?B?QmU3TUVWZ2ZTVytFSXJpYUpVWU1iamttT3ovTlVrZ3JDckhZZkJyY3Y5azg5?=
 =?utf-8?B?dlV2UWJsVUZqa1RYMXg5QTU4VDhNUVIvY2U2NFV3cUxRNUxjMGVLMGl0U0Iy?=
 =?utf-8?B?TlN0M1NpNC9OUVVPVHZybkdrc0Z2ZU8vTnc3NnlDaHlZM0FjUjFOWVZ5eURG?=
 =?utf-8?B?L2s1eE5tRlc2RHV3akcvVmhNNEhTYi83UURQUFY4aGVBcCtQWVh1K2NjTEEz?=
 =?utf-8?B?QWp5V01QcGJBNW9iN3N3QlBheXlXVU40amRNamUzYThhUU1OWU9jVGU3UFpK?=
 =?utf-8?B?c1V4VVlHUUE4bGlzUkl3OGpqakVFRXd5ZER1eDBjQmJaZ3huKzhCR0dxL0Iv?=
 =?utf-8?B?RzNTVVA2UDhUaFNxM3VFNHdtSkc0RGJUTFhnVlAzeHpkZTJkSHZLQzl3eFN5?=
 =?utf-8?B?UHVaVCt5dG5OMmt4azJHRXVpRzVVU3dLd29QWmpBQ2FTSG5hbWx3NGgzZGsv?=
 =?utf-8?B?a016dXdPN3hpUWJSNzRJRlk2b1JBUVNsK254dk0rK0lRb0VkajVnUkJ6VTZy?=
 =?utf-8?B?OVlrTXkvaUdEdWw3WHkyemlTOVNrM0s3UUNPQjk5SytDMmxrUlJwRWJtekd5?=
 =?utf-8?B?WEY2bUVYdFFmK09uR1lYOWo3ZlJQVlR3N3dvRXE3TksraUMrcmpOeUhmSVdo?=
 =?utf-8?Q?925ICknPU8FbNVgUu8iHMhlGD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089e35c7-0a8c-4f3e-904a-08dc3f84cfc5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:31:23.5506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+lql3OkqdioZaLl6CfAiamlXlzXVRvk5rIRrQ42RsK/gJFnWp/cvyvvDGrRRa3oM8BdP0xofiFlDic+q3LOyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8116

Some sai only connect one direction dma (rx/tx) in SOC. For example:
imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
for dma-names.

Remove description under dmas because no user use index to get dma channel.
All user use 'dma-names' to get correct dma channel. dma-names already in
'required' list.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,sai.yaml | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
index 2456d958adeef..93e7737a49a7b 100644
--- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
@@ -81,15 +81,13 @@ properties:
 
   dmas:
     minItems: 1
-    items:
-      - description: DMA controller phandle and request line for RX
-      - description: DMA controller phandle and request line for TX
+    maxItems: 2
 
   dma-names:
     minItems: 1
+    maxItems: 2
     items:
-      - const: rx
-      - const: tx
+      enum: [ rx, tx ]
 
   interrupts:
     items:

-- 
2.34.1


