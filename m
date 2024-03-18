Return-Path: <linux-kernel+bounces-106537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE44387F013
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BEC2838A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E9056463;
	Mon, 18 Mar 2024 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nM/m9bo4"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2082.outbound.protection.outlook.com [40.107.241.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46555E67;
	Mon, 18 Mar 2024 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788450; cv=fail; b=pqQoma9gaM8kilS3tDhjgtHhi1zLpiwCkyJVquR5yBTgtMB5+DoYQQrTBBJHZO4KPzhR+jRt1XEg3D/LRaVat95zEPj4yR4qL9GFvQj3nF9bOkEaiB92s0w8TUkFnXc2U77gHQmLdTO4Z/+tLwDK+BUG5jLLY3yBxF6DWbmjrqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788450; c=relaxed/simple;
	bh=XYdtpAnSNxogxk7ryRvzs1Js+leFWFpq6OxZDn3E1Gc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=FTkkmvVLNJYTOB9ENUxhgG7g4GaWyjdvEpdF8Ukrqf9LMW8szd0DK4lD6D8PGcGz7m6UZ7t6W8BZ+zmsVfKl40WBI7hBqfbjpvGB4mSlrg46JyYpDprfONB0QSN2zm7QED20IcLmskuAa6mZDaAtNEQnw69OQfX8mqyAfj0SO1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nM/m9bo4; arc=fail smtp.client-ip=40.107.241.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYTMiiM6CAWin0NKbcBVPP5GqAyMw5nmusCUQGBSGetXwS39gT8KEUElRA1JoQhWi/0xheJM3gDrgs2zLa/ZAZ8CtNKbnwPUtCFabqoEp3nEeM5bk7MIR2u6VYrkqAo5sW+eKzAXBfiUxB3yTDqO79zOLz3rDM0GZQtBX8AMLGQ/RgPe+mgkoLPLseKE3B/6xxXq9rwHkz2KRjHXFUGfX+aSb7W1uyCIGRiH23ryKlOHDykkgsERGAZU0Tow+h8D6FZzdeZuibC171NTgNtU5PSm81t69ZrkamocsZ7+nw55bTVeHJe8z/XqUwRbcXGvLtFe2izuWTBLQEktiZIFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ht2/VEvIrk+CRg1thc/MWTNbbLcaMaSvWp0NsFnEn4=;
 b=ngxGMBUt5lZw+/JvGjNF4QZi6bF6m7TerWw/XhYnpi5px6NA1PT4dhhOqiv4wwI5hzJqYmYhWKTmH92NOBcwMTgvtbyKPIrGWsKV49xAaljCB5IxhmWV8vOBsdneHA71JfXyIYZqgNJs+GO1Hqas0yG9Tssl+qimXsFRFkOQZKOZvCXCf2pE5Wci7vVfIJ3vrekMPW1PT7TfpI+V1iVEnhaW7Bh/ubU/qrrNDdK8+stcHsL2u/JUr0G94DAlIfqM64hw25FQceievMG5Bu4j5m0VN++5DkCqxMrOCtwS+v0/bZq+i2r2aR7ta+CHg6+cBrkXJXeREAutVaW7Qt5qGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ht2/VEvIrk+CRg1thc/MWTNbbLcaMaSvWp0NsFnEn4=;
 b=nM/m9bo4gASFr4XkduC69s7Kw7biCzy9zrL84IxA8ZVqwGNtZq0jrNKGqJPR2IJZ+p7n1kowfHf3HgwqHXvzH+kiQCyIsoNGe09j1ufpT3dboKXg4bvO3ZbSI8/Giod/a2YX4siwVDoBi4i4nR+NDascJipxFkRmU2ldSSsdyU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7119.eurprd04.prod.outlook.com (2603:10a6:800:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 19:00:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 19:00:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 0/4] arm64: dts: imx8qxp add asrc and sai
Date: Mon, 18 Mar 2024 15:00:06 -0400
Message-Id: <20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADaP+GUC/23Oza7CIBAF4FcxrMVM+a8r3+Pm5oYCVRa2FUzTm
 6bv7tSNkLg8zHyHWUkOKYZMzoeVpDDHHMcBgz4eiLvZ4Rpo9JgJAyaAMU1tTu7PPJaJMmmt0oY
 bAT3B/SmFPi7vrp9fzLeYn2P6f1fPbH/91jIzClSypnNOh65xcBmW6eTGO9k7Zl46UzqOzgsvW
 y57z62tnfg4DrJ0Ap1TTdcaEEq2Te1k6ao75f5fxxXXOFLG106VrrpToQtgeuVxEqD9uG3bXmy
 iPbOAAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710788440; l=4174;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=XYdtpAnSNxogxk7ryRvzs1Js+leFWFpq6OxZDn3E1Gc=;
 b=unQgkwXYhGvIWMLm8TjVsqzS7YnVwkmnUTDUbnjbXa5OhUZAhSKjEmUKg/XW7ezrgLUsjYQEl
 YbaikQqGEWDArPTLkpyLZUfXCK5lnAj0dgdF2JStqbBj0x/a8zxEw0P
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::31) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5f5f25-0c6b-4c97-5d9d-08dc477db707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DiFW+m/lMPUpZ8pTsauTKgSHSQvGVdgvzWRyohgY/GrZECpwHXWI8iBEkAt/UyaKS/VPKXltx7lU/zlsSFYnlqjySQCkIWbia738s4ZnfrOMAU4aotoZtASCkfScokusnaiGUMRedga+PKpgRDbBaROkIMD61shYJNMStyJtNZH+t2zntE6HD3ggeUnYYIdWT7zpBA9hRXw/w+uOSHtezkvmnSaqpmYmjE4u4rgx85c64DD4XBujJIz9chfI2jexuSu/2vohXMHYA3WWUvFwJnPY4bpop735DUzBtrcY5PrxA7ziC4zCoI8IwjPhZyYXIXlQa5eoyXerJ4qAA0M+r0zvRzquQq4Q0sfcpHbRF9pVu8ima1k0arP0WABHe0dFxRh2NJm43jucafN5QJJlv8Ha3NXTnm2Nqrkim1uhGLp0zFEVLeWLpokP29reBXLpQyXK7JBLCtFHOlmjuzjaCjM+hOZ5EhTZcFyS5nKQOgGD4omx8jkdiiefbteKOw82QkoajU2Rc8WdfF7+7TDo9919C4vruSe25YOASh0lZFHqKdKwWRaFyK1JpHa2DrEvCbKnqwnH7Dl3HLGD8TfymVwC4sL8V1nT4ER/ZB2EvqbDkOo5awuXk9W6AhjUlmfl6vyrst/HRI5nnbpnGwM+8xznlslevIhUKVyZ6kyYITb+CCEF1eeTfBl/1I/MtDts
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG93S01rMFdKTXRLNHpoUGk1Q2FtdzVGbHBBQ2NiZUFaYTlMczlwbWMrNmpw?=
 =?utf-8?B?emY5aW16c2xpZzdpWGpvbFJMc3BNYk93TUhlZjBTY0JtRy9NaEJCUy94WFU0?=
 =?utf-8?B?dUxsZjFRcFZiUVBuZnNtbStodTZYSkNwalFDVnE1R2JUemRxcWFOYXJQeWRL?=
 =?utf-8?B?NktNaGVaZmpLM3p0T3VHb3NLNmFQVVJ6bjVtWndXSXlvME8xanZpS1ZmK1Fl?=
 =?utf-8?B?K0NnODI5Tm9aQXQzOG01WTJRSWJ0RWNhWEtheVd0ZVhDbkJpcjBVSzZMeEds?=
 =?utf-8?B?MWUrNDZZRzJMRnoweFlIZXZ4alpVUTYxV0FncWhhUWF5U1NQeTE3a3IvbEJ0?=
 =?utf-8?B?NHNYQUdmY3pva3FkUDJ0L1NGejFwTW9ORGxsdE12dnVobThvYmZhVjlSd0NR?=
 =?utf-8?B?VHJaVUU0a3U5cFd1RG9NWDRJeG1WaklYZzZkQVR5Y2NPWVNveXpLZnR2bGtS?=
 =?utf-8?B?VldoYXo0VVhhdTVDM1dEeTZaTHlGeVI0c1JyZmUvSFhLeTBQdHJtR0NtWDBv?=
 =?utf-8?B?Q05VSE05RGJ2TlVOOUZ5dXpGZXB4RlZsUSsrZVF0eE9XWGNjWEVLVlhWZnZa?=
 =?utf-8?B?VDNtazkvWXFlQUxqangrUEFtRm1yNFNGQzJEOU1XM1lPVUFjVy9rRmp2YW9q?=
 =?utf-8?B?a0JaT1R3TVcrZjVJN2ZXN1dyV3kzM2tTSDJ4Y0JzMEh2aW1VS3VCWUVScDYw?=
 =?utf-8?B?SDN5MVBCdWJ0TGtURlVjS0I5TDhWZ3lSdnViZjN5aGpaM2hYRG1PQkpPTE90?=
 =?utf-8?B?MzJramxKWHV4RU5kd2UvWk44YitNcHdrclA0Y0ZLbnUwTTFIL3hIQ1pTMFgw?=
 =?utf-8?B?eXBKVHk5VmpPemlUYTMyTTZlYUhienl1WFVNbCtHenNhMEVvUU1xV3VhaFZ3?=
 =?utf-8?B?ZHFDTHFraG9GZ094aStpUHE4L1RDNVA3ZU14dDQ2ZDhadTYwMmVtMjhiN0d1?=
 =?utf-8?B?OVd6ZGlnNW1nd2ZlNG43K291Z044Z0gyeTVSM0NXdUZRSElRb2xYamhEYUwy?=
 =?utf-8?B?bXFLSElzOTkrRzRYOE9uU2RzbkJSSXFrdzlwUlE2WUlPc0ZSQzdwM2w4WlJI?=
 =?utf-8?B?WGRSOUE2WTk5WnIzK3VzaG1FdjhPdll0TGpxZ0RWMnNYNHlhNkVOc1cwWk81?=
 =?utf-8?B?andadGRCbTlpUmEvdUEwOHRqL1huRjV4MURrRVBDMHZubE5aZ0paK0RnTThI?=
 =?utf-8?B?SURWbUV3cEVuTUJiMjBFM3Qxd0w3L1FZR0VlRmw2N2NVYmpwWHQwNmt2Ykww?=
 =?utf-8?B?dTNSeCs3T1BkRmVQQ09zSG5hYTU0eEhKa0w1THN3Y1JhRiszL1lsM1NTR2Ex?=
 =?utf-8?B?ajZkWXhhcXZYMzZwVzUyZEJDT3dZdU41Z2F2SklCZWtiR2FtL1hUYjc0TlNR?=
 =?utf-8?B?THo4Nml1UEl4SXRKSURTbUVoSk4xSm9JY1l4SGhJQXF6NVVjbDJxSXdwSFQ5?=
 =?utf-8?B?bXB3dHV2WDBBWUs4ZndSbVZJQmNKRGl4c1B5bXZsb0xnVUJwZTVHVFl2dEE2?=
 =?utf-8?B?cksxRElTYlhidGpkVnhDeG5NUTdEa2RtWFlINjk4T2wzSGpoZmE0UGNEQ1VU?=
 =?utf-8?B?RE9CUEtWVFliVlJ0REJ6SVBUNnZGeEw0b3pUYnUwUjFtSzh1VkIvMWRxcWhY?=
 =?utf-8?B?U0VEMWM2MzhzZkpmcDA2SGk1Mk9aS0p5VG51OUdPNG02V3F4SmkrbE44SGFs?=
 =?utf-8?B?OWRnQ1R2NlRTTnJveWpnZlZmZXZma0xPR2xDdVNnQ2lHbHlvR01JRW12RmJJ?=
 =?utf-8?B?QXk4WHlYSlBWWkhNNmF1U3pFNHFBaXhjMGwxbUg2N2hmMHZpblQ1WWFzRnNz?=
 =?utf-8?B?WjYxSTNUTWd4andoYTZzSjdCSWRrR25VQ3BJVmtFaEdyeStydUZadHNZb0N5?=
 =?utf-8?B?V1E0RXc2cVNZRmNiL1VnMkljZ0ptVEhNdDdvOWFVdkx3a2ZhamN3Y0hGSjhW?=
 =?utf-8?B?bm1Wd3ZMWG1ERHZVNFFRZUo0aXlDWjBhOUdscm9ubHR2REJiajZ4aHNJVDNG?=
 =?utf-8?B?aUo4SUxQVDFRRnk5NlpmWDJaUTc0bUpjNWRBZ0ZIOVp5N0JnM3h4RWo1c0lI?=
 =?utf-8?B?czVZRlkzaGNHNkFjS3BsT1FjRHRSYUhUR0gwUHZnakdCVXZGbElsRXhCWEsx?=
 =?utf-8?Q?9KeU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5f5f25-0c6b-4c97-5d9d-08dc477db707
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 19:00:45.1840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CuRyPncJimNzrSoBAFBgllBAkjWxabbnhxFnHrRt6OV5dR1d44G684A2sMcK/gKOKOgbWAwtqgdFv4Gi6JLcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7119

Update binding doc to avoid warning.
Change from v1 to v2
- Fixed dts DTB_CHECK warning

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v7:
- Using rob method for dma-names
- Drop conor acked tag form dma-names and interrupt patches
- Fixed warning for interrupts
- Pass dt_bindng check

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,sai.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/sound/fsl,sai.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/sound/fsl,sai.example.dtb

 make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,spdif.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/sound/fsl,spdif.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/sound/fsl,spdif.example.dtb

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx-asrc.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/sound/fsl,imx-asrc.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/sound/fsl,imx-asrc.example.dtb

- Pass DTB_CHECK, below warning exist because binding doc still be txt.

from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: /bus@59000000/amix@59840000: failed to match any schema with compatible: ['fsl,imx8qm-audmix']

- Link to v6: https://lore.kernel.org/r/20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com

Changes in v6:
- Add interrupt description in binding doc according to rob suggestion
- Link to v5: https://lore.kernel.org/r/20240307-asrc_8qxp-v5-0-db363740368d@nxp.com

Changes in v5:
- using rob's suggest logic after fix maxItems.
- sort dts nodes.
- remove spdif1. Add later when do 8qm upstream
- Link to v4: https://lore.kernel.org/r/20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com

Changes in v4:
Combine comments' from v2 and v3. I hope I address everythings.

- Krzysztof's comments
  - add reson about why change

- rob's comments
  using rob's suggest logic to restrict interrupt number
  but for dma-names, still need use oneOf to cover 3 case
  - [rx, tx]
  - [rx]
  - [tx]

  oneOf
    - items:
        - tx
        - rx
    - enums: [rx, tx]

- Conor's comments
  - add power-domains required for imx8qxp and imx8qm
  - remove dmas descript, not allow use index to get dma-channel. Current
no user using this method.

- Link to v3: https://lore.kernel.org/r/20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com

Changes in v3:
- Fixed dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/fsl,spdif.example.dtb: spdif@2004000: interrupts: [[0, 52, 4]] is too short
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#

- Link to v2: https://lore.kernel.org/r/20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com

---
Frank Li (4):
      ASoC: dt-bindings: fsl,imx-asrc/spdif: Add power-domains property
      ASoC: dt-bindings: fsl,imx-asrc: update max interrupt numbers
      ASoC: dt-bindings: fsl-sai: allow only one dma-names
      arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif0 and sai[4,5]

 .../devicetree/bindings/sound/fsl,imx-asrc.yaml    |  14 ++
 .../devicetree/bindings/sound/fsl,sai.yaml         |   6 +-
 .../devicetree/bindings/sound/fsl,spdif.yaml       |  35 ++-
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   | 267 +++++++++++++++++++++
 4 files changed, 317 insertions(+), 5 deletions(-)
---
base-commit: 8552c902efe7ef670b6961fb8885b67961aeb629
change-id: 20240227-asrc_8qxp-25aa6783840f

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


