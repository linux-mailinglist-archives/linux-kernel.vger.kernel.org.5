Return-Path: <linux-kernel+bounces-141376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1AD8A1D70
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3B51C240B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4E1524D6;
	Thu, 11 Apr 2024 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nB6EaXvm"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0223524BE;
	Thu, 11 Apr 2024 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855294; cv=fail; b=piSmd/hS7jdlOuCw+ThbQ+iG0sDdD52ZpWInLDcbIlW5NbV9mtPLVqVDTxGu7BdZ2WpjO03Vuz4kEoTQVQxXdRt15YG0EMtx/khit4AfpUR5UK1ZOcZkeTbRGuPPWq6tv3lfitgkv57Wualmm7A0LCBADz3riBzp6Yo/PeeRT0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855294; c=relaxed/simple;
	bh=OLS58S2IRnMDiwQwoZPn1sgiuqiS5FF05/iASQYUyDs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=or+iHDFsANBUWEahyaJYlu4KD/0CChjePAN+W0ZE+dV8I9hNmLO2G551Y3AGectX1XNAk66RWunqy3q3Wzv37VhFkeSmE5fYaDCZdh2si7VY/pk1kkvAPCruGoht6vfVq+zOV9mLSgB85XrWzlKrfhrZudb4A/VjkRW0YKFS5JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nB6EaXvm; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvVsL0VxNdaojkyzE5WeMav6GomZAkkF2Tu49xSyNL2gW8cbcfn7/gqt7cp6qiCY43kcBX29WD/MLZsat7QRYeHgdBPbJWU+5T+37wlueAdAVfNA2CPIdbNbZjF7HRU8FRZsnJrS6O7HA0mFL0JGcwI4EGpQZFIyjgBwMvCCmKAd+7DSr1Nnd/Bl4UMW5xgEClzIGfh6ENK8o5RMSfeYb6Hv8UIPTZqUr2Yh2BAm/uhUYP4Jp6I2cxS/PoqBRn6QXR6bIOcm3O0qJaJP2g4vrc8hh/VLyZDB64wP1DmUlyjHGzQYl4S+UA3yiFjvITXQswHlHkFyhWiClhVoGD8BEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gEBQUzwMSWzsg1U9WvZGllyefjAt2wQO0omZfZt3SU=;
 b=KIP5VN7QBS6Rh6xsKS0dhea/NgFrORBq7V6V2j5pgAFeFTndJL4wVw2fjD9Zvy65oL1kmYf7+I7TYr28/DjTE/Ipo/4aBaFtSfqWytqv1AzNncfkU/+YOVeIreXNRQ7qvDrYgln/+9zx1gZ/rslPvN7toWGt/JQ7/6mfmU5Fopgs36L9N0VbP03OKjlEYBNcsbiRSiA4MiQA8RboTPJIfvkXkPcXezJdwFNQ5G+NDjvJQ4BABHYi08F4Y/ptpPOjry+yz2SJWBV62Px6YjnpXOX8nidYsksv8yFr8D+/hfZxMAcZ4z1WhbYyKa7xx7DKdOLYspVpP61J0F7i/I/H5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gEBQUzwMSWzsg1U9WvZGllyefjAt2wQO0omZfZt3SU=;
 b=nB6EaXvmIgc4Aiav1UzVAZGLPJ/oE49PBzWsJz+4rS99Ezt4H/EF7zrCvUfCS3lg7JL6b6kaA89r1h57ywJ1tLyH1dfpfyAZj+FjTo1/UZo2TkD3E3y/bAcKNMwEvT+8twfdo3R7hmEmbkHKeu/F764GkgjY9LwfmMKdB86NzmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8394.eurprd04.prod.outlook.com (2603:10a6:10:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 17:08:08 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::1d91:1c96:1413:3ab0]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::1d91:1c96:1413:3ab0%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 17:08:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/4] arm: dts: nxp: imx6: fix esai related dtb_check
 warning
Date: Thu, 11 Apr 2024 13:07:44 -0400
Message-Id: <20240411-esai_arm_dts_warning-v1-0-5e1a7c7be9b9@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOAYGGYC/x3MTQ5AMBBA4avIrDVRf8VVRJqGwSyUzAiSxt01l
 t/ivQCCTCjQJQEYLxLafYROExhX5xdUNEVDnuVlVmqtUBxZx5udTrG3Y09+UU1tqkK3ZjZtDTE
 9GGd6/m0/vO8Ht76jJGYAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712855283; l=2149;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OLS58S2IRnMDiwQwoZPn1sgiuqiS5FF05/iASQYUyDs=;
 b=eSsORuf6K/PYcsv0GIh4g9ayoNC11cRozI2NEShhN0W+TLDDaSh5OXNIUOEZtG3oXZAIrNPIQ
 bBsjPvJAL4UA3UDzptaqSaOffOCFmHObLfo0oHRIC004lkIhUQGQXod
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: 8334d7ee-210e-4db0-2b21-08dc5a49f517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0OCgSibJQx/kDZIxf4crK7t+AKQOUYqjaU4FLp/m7DGisKiUN6wvIVGAiw9ptp2qtm8vwmgUq7GfzR2YqUjWDGhc1GP+00/iBX1e72SYEaAcKaAi2vjiDvfi9oSAfWOEDUxdEhwVDazZ6RJTl/hynlQ6Ri+VXKGXj4kses6EfwQ+ihjlabbgoKN1+VsiywgUXXvBuMZEcsA4QU53C1snvPcRCk2A6xNhf+32E7Ii4Wz5UfjwZgWFFDywTPWZhWFSB8Qu0sHGqRaVwXteXAOIziu31X057a7N5fnCGxeAHU6ayGy2C0nK86xFpGfW6jIZ6Qm+xBLeZso4g4a1hRQciAjDX7h17/9w2vu5uJ5uvpsKEoRBay+khM+FR+RzhPUkKehAXJCCcDxquIrYWXmN3iVxWioAkujrYqmeHKrsKfgTvR880pJo9MAfLv07m9+DBu8sKBTKxcL0ElYiwwnvDyqzQRPXVvQ5cp7vykydyLoCLCl73AN7QTVt642OUz/5p+BnZwjcGHYovX8wjY75wQ0ntLiY9IDO9THVgVcpDuhXHif6otBQ6pN8sCrvdcXj0QvxMh0b4AMGaa8xMrMLbI0gdzs9142BmjJ4YGngTM1XXmoqtemsVHpaqquu3Gb78g2T00gig1ubWxdnXc23fSYKLJbiO5oUMQ0rNACiqqGnNcMzhqjDfjWFzGUDN+kcjNUg4/AHr8piyxHw00KEfH9+/vQrmJnosUpORooIajw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUlXRFdJSEJJeThIN0U2dEh1YSthdXQvaWJNVmRrUm9jUndjdTFGVEd5eVgr?=
 =?utf-8?B?NTVLc2lXemVHRVVWaVdQNkV3TDhxenAxRWdTMlFHY09PVHV1dzVkSmZuZDZE?=
 =?utf-8?B?MkMyOTlvdXRzZGhTb0wvc0pYaG5RY3FBK1g1a1dia0NaWjVuTko4bXp3SmFj?=
 =?utf-8?B?U2s5Z3AwZnE1VFRKbE9KaVhjM2tQRzhHMGllUEhhZFFLZFltN2VUVSsrWFJ6?=
 =?utf-8?B?SFlhalBaZ2tGaFVIcTRYaUxFRGx4dlJraWJTQ1NKV2k3a2FDM1Y4d3VDWnNF?=
 =?utf-8?B?akxEenRaUkVKUzM3RTZnOTIwVi9NaGNab0Z4UnNQeTNYVkgzd3Z0TzFRcnp1?=
 =?utf-8?B?VlBub1B1YWt6UG51ZjdTUEpOMTNodmMrc0x3bHFabDZvdklBRXRIT25xOWZE?=
 =?utf-8?B?ZCt2bkxDcHlmTDJ6YTFXMmIvM0FHdVVpRFVoQ3c3eS9CSlI3cVhhRW1leWsy?=
 =?utf-8?B?TE5mWlVSaUFudXRIYjNyRlZSSFB1OE9rZ1VyNEVkU3JXNERyMjlWOUtIaVkz?=
 =?utf-8?B?QmxMVDlGbk9lOFRveVhUSis0OHVubVBzSnZsTkpyR3cveW5YQ1F4K3J0TzI3?=
 =?utf-8?B?QUlaYTg2K3gzOW5aZ0hxQUxYZkQvSG0yZVByZmx5b3JveXAySWdWaVhaRjcw?=
 =?utf-8?B?V3BjMFZ4VkFMU2VKbHRmQXlaa1pPVm1wMUFDbVg1L3FFeEx0YUtVdHRFY0xF?=
 =?utf-8?B?MklpVjkrREFXYWt2dzJmT1FwT0h4WGZna1cwREs5WTRaWkVKc0lwRTdyZzIy?=
 =?utf-8?B?OWdCVlZySm5rcThnS0hXeEw3aTBOL015MG9RQjk4RGR1TGhHek9GWXBjYjJF?=
 =?utf-8?B?cWsxQzN5dUhwVkFsMmhOekF5WCs0WExjcEhGMXowMjVaSUdUN0ViZER3RHZO?=
 =?utf-8?B?L080Unc3SXRDbFBDclg4MXJTSVdRaFB6bVRQY1JUdUNYcFVRS0djdTRqWmZY?=
 =?utf-8?B?Y2JDdGYrdjhtV29WcFVTL2ZjdmlNeTYxUkkrZmY0OW5PMk5TVjMxSTNvUkpL?=
 =?utf-8?B?SlFhZjdEWk9KYzV3azhYQjNJRDdDOXVTRVhCa2NTTjczbldaRk4rTEJoekhr?=
 =?utf-8?B?UXpaQVBEL2pEQlkxNG5zVTdCY0VGWUx6cDIzSjlkZjU4bm1pQ2F6STJ4U3BZ?=
 =?utf-8?B?dXJ4ZFhQU2ZtYlVWcjNJT1FtclpyN01QTnJHWEIzVEI0UTRjRUNndUNISTZv?=
 =?utf-8?B?RTZqTVpIQ1ZuVkovKzRvS0Y2K2JuclNYRzFvRXdxeThNVUovSEV0amkyVThX?=
 =?utf-8?B?Y2Q1Y1FWVWRLMnFaUy9pTExlcXhwTmFKM1NRSE9JS1ArRnpHRU1RN2ovMTNm?=
 =?utf-8?B?cnArU3V0bGZ5NjBLRWxFS2hwRXlQNGIwNkFFL0VvWWpIcFd1emlNWmxkTEZm?=
 =?utf-8?B?Q0Z2UlNvazFMVS9yMlU0QURXMjVNK21hejhHTzczbjl6MDJPckFkbzQzd2RW?=
 =?utf-8?B?VUFuOEk3SCtoV3J1QVM1T1VVUmV5Qk9qdzRzUlhJeUV0N3NVZ2NRK1dFaFpz?=
 =?utf-8?B?UWpWemRlZ2VxT21xZHh2cWhJWjNjbTlXSktsbjdyUGdtdnBLdm1hMW5nM21P?=
 =?utf-8?B?dUlHNEJvbnp4Y0RPRVNiZU9sUDNPamdRNXA1K3IvL1pTeUI1cFcwb2UxdlpU?=
 =?utf-8?B?aTg5RmREVFl4RkovbjFybHkxR2drSFlsck5EWWo2L3ZzSDBZeFUrTE5qcHVs?=
 =?utf-8?B?Tml1U3VFbGw0NWRVa2hnWGlGK09GUW85WTJlU1l4MmtQWDVHYXM2U0N4NWty?=
 =?utf-8?B?Ri9CNE9DS3J2UkhnajZwU2RIN0VaalVWUlllRExDUDBneDhHMTJSemxTcTN5?=
 =?utf-8?B?Sk9sVXVSRk9uZ0E5UTYxSmZIRnI5c1pBNE1mSTNXZkRub0ozNzkzSDByZEcw?=
 =?utf-8?B?WGtRQUpjeENRZE9FZE9va2xHK0t4Ym9Fc1BnQjJ1TDZUS21IUmxqOVJkaE0w?=
 =?utf-8?B?QmhWSkZ5Z0cyTlZhZEZRL0hWRExpdzVWaXBNNXdVUXhRVFdoNldqamxzU2oz?=
 =?utf-8?B?NDhCR2ZaTGZVb3R0ZUVQWDRYZ1c2c09uUFcwdXFRRW9ibjVwWnc2VGVWRjlH?=
 =?utf-8?B?dW1kK2pGTk1zVWtkNjEySTdEb1JoSVVGdlJQRDMyWVBiVFlHSHpkYzlZa1Rh?=
 =?utf-8?Q?ApFw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8334d7ee-210e-4db0-2b21-08dc5a49f517
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:08:08.0419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkJCTub2YN8mK1FXAuE69K4pP270vhCwwbYw9znoE42nXt8YKHN/OL9FTu4lx26Oa6KuMcFyDWBRUQ60c97bvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8394

two patches update binding doc. two patches fix dts file.

dt_binding_check each patch.

git rebase -i aa8a0e0038936 --exec "make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml"
Executing: make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/sound/fsl,esai.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/sound/fsl,esai.example.dtb
Executing: make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
  DTEX    Documentation/devicetree/bindings/sound/fsl,esai.example.dts
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/sound/fsl,esai.example.dtb
Executing: make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
Executing: make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
Successfully rebased and updated refs/heads/b4/esai_arm_dts_warning.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (4):
      ASoC: dt-bindings: fsl-esai: Remove 'fsl,*' from required list
      ASoC: dt-bindings: fsl-esai: Add ref: dai-common.yaml
      arm: dts: nxp: imx6sx: fix esai related warning when do dtb_check
      arm: dts: nxp: imx6qdl: fix esai clock warning when do dtb_check

 Documentation/devicetree/bindings/sound/fsl,esai.yaml | 7 ++++---
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi                | 3 +--
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi                 | 5 ++---
 3 files changed, 7 insertions(+), 8 deletions(-)
---
base-commit: a053fd3ca5d1b927a8655f239c84b0d790218fda
change-id: 20240411-esai_arm_dts_warning-86753197f796

Best regards,
---
Frank Li <Frank.Li@nxp.com>


