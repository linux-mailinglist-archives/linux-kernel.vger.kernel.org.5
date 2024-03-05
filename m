Return-Path: <linux-kernel+bounces-92769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0368725BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C3AB28D16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5911D175AE;
	Tue,  5 Mar 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sjs/VvAO"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B92175AD;
	Tue,  5 Mar 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660006; cv=fail; b=ZaWij7ynSS9KJuwHyASNnvPqn9P98CUmLrsf+7T3yYS7Yh7L08fzWwKLb7ksKPQkrPn08qxuoztkaWZ5PN9QRq+nRpxVnGsJ+9L1nzCxo5co44mQWcxGqL85i/JdX2dkbE94tGtWEFPxcocBrB5PP440xX7be9HjcHSsATIH5jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660006; c=relaxed/simple;
	bh=VwHc3kjcb2pWtSk++KPQVvXCwWX8pTOMc7rwxNKUg5U=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=O+g6nxTLMj+g+hthtwx+N6iiqLfn/1dGToWPyKUrCzCHGZqVagwjk2SCupsYJJUkgKKwXNoq1NABd+kO9lInrTE9PGsFYuKbw3DkRKWCdmzuZmw1QfQ3UrFDs6oOENi2z9iQ+jjm8CRFbvDryWB38+K4JpRnTg0bH3ucBK3eKSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sjs/VvAO; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbQ7EsvDxVv5uOZ63Qhb0yrxAPtCL8iofC/IPJMDO3EO7VxW7YA1Wrb8dQxWy2eItEgywYOlo1pbizy8NBubqlKjS//jgCVeav5g0jxYltAsKhWnjIUAxMUXBBvJRT81JNaXwMWPOnXFgJzT1KgV8Tr/bjQHrjICGNrVn4Gjn41GOBxg6LQFBKBSw7g0fJnR8jRT3T8t9i9Qf0vvRCr9InJw8c/nqTnbYQQ/X6usROumCc5G/9Vl50b4dgPDhXhIfP885XDSxoAnHX6RdymvPyEizZx43OTusPRKAkWDbT35Me3m8TVoH36OtwQpdW3Ra+Whe/xt88MwU68XM9nXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsojrvO4pMzNiiQfQ89H0V6O1virTNQPr22c0toyn2k=;
 b=dS5LdI5qhQKILSuYq6Ycrq8f4LpSwfSbLKL6BvqQg7pLyVltVrF4Tw/6jHu4dD2RM4Wi+wq1PRI0UH/kislnLVDp2pSKY2doxYp5UeKQVD5WaTcKex7jf8gSV2LfULpxT2lfS6PKAvgjOhEXc1wVnYsQW4U1T0AoyARqHBxAhJLOxXVHJCH5iWH3CnJ57CrGxMyHnxRfbItvabJYqLCM4mXNm3MZ+2j/fLV0qT3JzmvO8BwJEATMrpxZN9nY2ONoGv6ko9mtdgeI1QM0Z0CJjHbvfiRzTjTzfa92cXDtz54LOuAAGJiPf92rbFAw/9w2LhU7ZaBhnRd1uiR0CFPQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsojrvO4pMzNiiQfQ89H0V6O1virTNQPr22c0toyn2k=;
 b=sjs/VvAOx6ZwjParKWdpuwIojGYPCeD6Pejwz2xVZWz5/GCkN+TYKYOW4PxKkqIPoTJK1bFIJ1uXPh25UOnrtdNH5tsifl6/iuXDPmcNcM38A8pjmC8sED76LILgJvXBXugKb4z8HNfMqYSHCjg3V23nhWjIFnASRhS77IchC0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7856.eurprd04.prod.outlook.com (2603:10a6:102:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 17:33:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 17:33:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/4] arm64: dts: imx8qxp add asrc and sai
Date: Tue, 05 Mar 2024 12:33:01 -0500
Message-Id: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1X52UC/22Myw6CMBQFf4XctTXltrWVlf9hjCl9SBcCtqbBE
 P7dwkYWLufkzMyQXAwuQVPNEF0OKQx9AX6owHS6fzgSbGFAipwiSqJTNHf1mkaCQuuTVExx6qH
 8x+h8mLbW9Va4C+k9xM+Wzriu/yoZCSUC69YY6dra0Es/jUczPGFtZLb31N5jxbPcijMT3jKtf
 96yLF+MyHIR2AAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709659997; l=1942;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=VwHc3kjcb2pWtSk++KPQVvXCwWX8pTOMc7rwxNKUg5U=;
 b=yJ1Fis795/ZtEnWPy2Kkhbz92+dRUoUMyNm6kgyUfzCDGq/wKlXxtagR2hpJBpSmz3wM947m3
 f0qy0FKqNl/DUW6D4zJXCfGm1g5qFh0Qty/ixn/eih9VwSdm2Axz8wn
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0159.namprd05.prod.outlook.com
 (2603:10b6:a03:339::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 319b5d1d-80f3-400f-0c6b-08dc3d3a5a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DR5M/gBlg5rYttutStQRxZrlrgZmYnmp/T/jzI0qsfoeYb1OqnDEEqRQIOWxkUqe/3n6TOg4wZuVBPmmCVoYCc97xI10QcfhGhwpA98HoIvNibDUU06tmD0D+iCgW/ndYR5d8cQ8vBsJ9lqS5QMNXpJWXoYo6M0JFVFiUFfURQe74fmtrVMpBviJ+bIaADYj6j1xGROPnc0yXowj4mgciNRBkQCNKDKjc5SrcXyt7i6cIaiHQPj8W32N9tohbN3re6ORu/Pt0we4Y4t5dZ44318rZh7vKloKFA69sAODkdNZVQ7GOE5QewtlwVbgXjNJYqte56FeGTQUXfPx6hiAbFYpN9zYfzjaWDd6ehp6hZ6i+HD28M7j3nAXoSuv5hxvCGCDnNoPQ4FzgCUfsQ/WiFksLFomX10Ovy/9BAFjRe196npLUOmoj9aaH1gSfTlSZaxcmblAWCMalZuQzD/Y7vP0rl22QfkyIJhquVWLBC59qT4jbMkDbZSiz5NEcQg1ai4twO5TmQDofscjwrCf6kr1mfV5f4BbopHseEpUcEuTZgC2GyPkcbp8W8GLyZZUyZIntzZmBRdZya71rFW87k50Ll2oD6nl+rfuEoB/UKjX2fAyeED8JtZXZjrnK0VyPeFuI1RNxnzsvCva9YfpNBp5pucitOuWCU3XcwHqq1gNyh2j/8/kS5OeHlQ71VJE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWZkbExTZFp0S3FjQjE3dGVKbE5kVVlvOG0xallHV3RSRnFRajJLMElsM3Y4?=
 =?utf-8?B?WTN5dytJeVZQWW51a2ZYSUZFTUdGaGtMU29XeGVtZ1lmdGRJa1hSYTI1ejhx?=
 =?utf-8?B?MVlydXgvMUFvNG9ldlBod0N3d3JLSmVRcUtDa2QxZ2VPdDZMMmR2WWZIM09N?=
 =?utf-8?B?UjVqNnpPVncvSXhKb3dQTE1tWDdVeGlaNmxIYjN1VFNrMnpKVXZiQVc3WnJE?=
 =?utf-8?B?M1BZR1pmbWtoRWhYMkxhdUtIblVKeWhJZlV3bFpSa3Bvd1BQcWJ5R2hMRmx2?=
 =?utf-8?B?TytYSU9uNUU0ZU51TDkyQU81R3psZ2R1YkNJelVGaUQzTzZwcnk0ZXAreDgv?=
 =?utf-8?B?aTlrZXdWaHN5S0JnSkwyWi9naG9iamVObDFOSG5qMTE2dTdaSHdqMWdGNjE5?=
 =?utf-8?B?VXh0dlBoTFRubWd6MDBQeGo5MElWSzI0Q2RVb25SbG9zUE93eVZic1RuQ3Bl?=
 =?utf-8?B?a2xPT3VlKzRBdWZ1VFBacUZDdlJlblRub0NXY01pNVZrTldsaStzRUY2VUE2?=
 =?utf-8?B?SThZYzVtc1c4THQ3Wkxha1hNeTRLTzBHUXcrbTNsbElPQWlISE1yN1BRc0dW?=
 =?utf-8?B?OXVnbWFDaUVPRCtKa1FaNEFCcU1jTXNGOGFiRGUvTW56d3pTVzRPSFYxWEdQ?=
 =?utf-8?B?aGRNbUI0bkpyNktMSWxneVJuL0k1RzZBT1NtUmxKaWJsd3lvTWVFVGhpUzFx?=
 =?utf-8?B?ZUd3KzBvd05xcUZVM3VxZ2ZicFlBMnpLUG84WFdLUDJWWnRNVU5mYUY3OFBT?=
 =?utf-8?B?RmxEdjF5dy9sbkdTM0RCWW55S2g4UzJrdXZucFB6dElKTmtwamE1elZYZWJu?=
 =?utf-8?B?TzRGZ3F3UDN3aG85dGdnamVuQUdoRHAwaTIwL3lQS0lYcXNtcHdlQzk2aDIv?=
 =?utf-8?B?b3QwKzZNckE1TGEyY1h5VFF0dXBRQk9VcTJoQmE4NlJYTFMvaXBTL3daNk9v?=
 =?utf-8?B?SzZMc0F1YVUyekVsRitBcU50RFRkZHpGWFRKZXUzVEc1QTh2MWhMZVVBWEdv?=
 =?utf-8?B?NkRlS2E1T2NRRUFMQ29ZUGVsRmNzRXBSTGtTR3RCSFY2UzRTcGk1U1VDRWYx?=
 =?utf-8?B?bW5uT3dNL2xKZnhoKzlMdDZVYlNsdFhkL1VYYlk2L290Vll5Y3VHakdHT204?=
 =?utf-8?B?UHZad3psd0p3VmJNVVZ6UXBGWE1kRGdWQ3hkRHR6azVyNlM0NGdDL1NsLzg0?=
 =?utf-8?B?NjZmWjlIcUxHaktuQTVFOHFuNm8rNGJSeEJyL0szRTVHSHdWM0ZBVUdWWC96?=
 =?utf-8?B?d3RKRGw4TkhreFJZVnNncnB3RExQbndHQ0FvbEZaWlAzaXEvWVNOWU9RVHE2?=
 =?utf-8?B?NWNRZHdWS0w2Nk1kTGN4QzJKOGpWQm0vMldyTFpWVE1WenA4MWFNb243Yngr?=
 =?utf-8?B?L0RlTEVrNVFPcVJ6Wkg4WWRlOUdyRXNhSXFQNlgxSDZTZ1h2UkFNak5lblo0?=
 =?utf-8?B?ai9WeTV0bzloaGNMSGZCTDBCRlhqNlVLRlNsbmpLWUR4N1VPaFBXSDFRZHB5?=
 =?utf-8?B?NFp6ZlhCMjV0a0ZrZ3dkNGtDY2dmNloza3JaUk5jK3BxWEcwTzdDT2JZYWF5?=
 =?utf-8?B?MUxpeGVlajVBMzlTWmg4cjI3akI0eGdTV1Vydk5WTThZRlMwNllGM3ZGNFJ1?=
 =?utf-8?B?TW4xWUpMUW5GWTRDd3NIeW5XS1I3cmFiMmtTS0dGVXFLUDNDY0YyakpWN1V3?=
 =?utf-8?B?U3N1bDhvUmhVVHNDT01LTVpuZ2Z2MjZrTTdhU0ErUGV0d2Z2eDRJOWZnMHZJ?=
 =?utf-8?B?dGRiZ0pIT0ZYVGdxWStWVVF5eTdOSGN5d1ZjRmhKYnVqUUFFMG03Z3IrRThY?=
 =?utf-8?B?QjNzak4rZlpBcHZQRzN0dmxqZ2NPQ3ovaHJ6Y0FPM2Z2ajMrNFhVSFZvblFG?=
 =?utf-8?B?NWR1eHNoSGRFNXVuUysvNGFJcXRiMFVyOE9vQmdUU0RHbmlVZVh1L1FjSDlG?=
 =?utf-8?B?N3RIVUxUU0RYVitUYlE5SDl4M0NjaVAyaThvSDNleDlFTXdSeEdnRXhPbld6?=
 =?utf-8?B?SlRKdzM3bGZpZ3lueTB6THhZd29qSzhBdmMxeXRlRTdpc2VBYk00Q3JYbzhh?=
 =?utf-8?B?MmlQZWVPOXlxNkY0V2F1K25KVUZrckhPd1h0MTk5UWdOTDV6RzJJcktraG8z?=
 =?utf-8?Q?SPYoLHDfW4ZKwceqRx21xBKzZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319b5d1d-80f3-400f-0c6b-08dc3d3a5a45
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 17:33:21.2556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6B+ihu+rCJf8RbLRPooxuCV16UzJB8nxZzkuX3XbXam6f+zr8btddp44KDkOPgXvgsmRf1CKz4sdMAIRJq4Q1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7856

Update binding doc to avoid warning.
Change from v1 to v2
- Fixed dts DTB_CHECK warning

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
      arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif[0,1] and sai[4,5]

 .../devicetree/bindings/sound/fsl,imx-asrc.yaml    |  14 +
 .../devicetree/bindings/sound/fsl,sai.yaml         |  13 +-
 .../devicetree/bindings/sound/fsl,spdif.yaml       |  33 ++-
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   | 304 +++++++++++++++++++++
 4 files changed, 356 insertions(+), 8 deletions(-)
---
base-commit: ca301cf599a4eeafed8e3dd87bf8d2fe810e075e
change-id: 20240227-asrc_8qxp-25aa6783840f

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


