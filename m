Return-Path: <linux-kernel+bounces-141751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E31B78A22EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E80B21C06
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6564B139D;
	Fri, 12 Apr 2024 00:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lLtHuZoM"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D181E;
	Fri, 12 Apr 2024 00:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712881286; cv=fail; b=eds4a/jntAT0aV/R8vKNKvWThMv+y5+PXrwGE/bhhEImgam9aMCnInXOiAuHdTwkVFEc1uG1V+xNp+BJrWZLDQmAcfINkWXYjpwppfVTdcJv5Dz7Aa0lkM3XHK8bE9VsYCQI+FZGzH2TbdjFdF/NAuiWTesY1yZSAxnSuTm0vZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712881286; c=relaxed/simple;
	bh=ugPvJFgjnLJ0NJ4wxAzAYriJw4zQ+J6ovcBuFXmrJK0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=CsKJglFmWRDIpzBmBsU1QpGNUi36NQGU8YqvhEGIV83RZ56W0MfZz7I9qaqHfnZ1eEAYXhMOwj7eF+77L2M6WMLhZxfcPXFovb7xiNIWn4e6dwtdxpnwctQOqhNdxAZ0dzNqN3LO1cGblDowCCCR03Vokhqem+I9+9dGqz0C2nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lLtHuZoM; arc=fail smtp.client-ip=40.107.104.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBJf8ygNDYKiUq09ixp+MSiR/XYRmJmhCnfbzcAccsF3TFDIXcx5Ip9trj71ZHRIFamniq0sb8QlJ5xcQB3MzYccfqzqlr8eO2C9LpfqBdMebcUjdaUBtRTetdZYZb2kVjFpucqmOMdwarFEMTgTsuFE2AdjRi+N02xy3wwKbyPaAGlihoriE1MVfKjJQzoR+UMEfP267Z3dWKnylWQNb6PscL2xUw+1oeb/yfVAsVIC+Xie2xJbkAJu9VBQB2KOvZJ6alXJVxWScYXtb4Evv4oVTAscAXhbiT7CmL9mpAF0E5EdojdNh4TsNHVQwQ47zkQIXxhuNuuBldf8Rcgsqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=it+OUvIgHyhZidLVoM3yG3gEMv/oyg06GoXnSuq+X08=;
 b=jijnKU87OZYKpdkjLLn/M9Wb3w13304EbY0mDMeeiu2ul7ybkhXobLam8TgmE9HwKWFjnNSQTwdR6MMDFBwQwmkTBmWr3H43J1AGuacpztrZoEloSQowBNv64hQDSRP9M6wEAw0ed//ucrLXLO+Vz3/8eGftKvYSBbf4vmyxNVZPOr7gqz5ozDd60m5LptOxWXRHG/nQjRbKuYi+qYsk7uGcNfUSPhz5aE2rfUruFEaEm2qCZuGhWjb1UkgcWEu01O8RtJ0IBY0PENNFJNt8RzzzOAwYulGrueAzQvIyi+X1gsY9XnPH3QXo1aRz2I7IaM3+5JU9zdhgticIyJ7JiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it+OUvIgHyhZidLVoM3yG3gEMv/oyg06GoXnSuq+X08=;
 b=lLtHuZoMSrIs0K9Xc67YOl+oyskBxYjaExqvLBlNJUhaddLxqhrsng6zSGAkO2FUlfqpTNRmyXtyBJ/xyv+kRJGPu+OHX+plzY/PlV4A63o3W8nwB9KoCRLMZIllT8twK9EYXoz5LwCXc5WLv6Kb24is+QI7DMfk903x2Lo+wh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7970.eurprd04.prod.outlook.com (2603:10a6:20b:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 00:21:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 12 Apr 2024
 00:21:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] pinctrl: scmi: support i.MX95 OEM extensions
Date: Fri, 12 Apr 2024 08:29:24 +0800
Message-Id: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGSAGGYC/x3MQQqAIBBA0avIrBtQmUV1lWhhNtVAWWhIIN09a
 fkW/xdIHIUT9KpA5CxJzlBhGgV+c2FllLkarLakyVi8JPg77pj8IXjygdkgdeSddZOhVkMtr8i
 LPP91GN/3AyIuIAplAAAA
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@arm.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712881775; l=1113;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ugPvJFgjnLJ0NJ4wxAzAYriJw4zQ+J6ovcBuFXmrJK0=;
 b=3+HE8AbL61B1AlyhYweRJo9Z23PKvzL6iH2zusoi1uoMXT62RZi1frAkUvQ1E/ZOseai+dCMD
 X7B+cE8RQTvBgZYfik0Pbs/1atGOxlUQFfjUcmM41PnxwKBu++pZw8e
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e2c0d5-d1d7-42b2-1db8-08dc5a867b41
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YDo60lquzj9CBscG4PmqX1hooj8aA1dlQ8PheZLVdOM8PFj0pNU6ZwAR/jJPJYuMn7HKabg3YR15lFN+99tglJj+5UDy+MRCukX4z1mdSzAi9qr9KG+8j/JYFgQAYxE4ui+ZxC64VbsKpj9kWFLASeSpsrZCWo+fQGVCvdLFklCfPqBc6nbQT4k9nLgkFDiu8DcIp34hVrvxI+GEeuDiWjqFS8b0vShJmghYIo3VpJuX3+Jqb3CxYXPskAfYX/bkJFq+N8MLmFUfKX85+qgr9DMl8UgGaChfZQSldz4IFaIE0fzee2nYaFH9me7alvnICB51oYCdMWA7R8lMv5G7GyGl6PkMwZouISWC35zNtn4GE2+C5zXI4Yp0mFVbYxBivgcljZYUwZe6/Y2tq8DTtxMToeS5mPQBjyZXluXTGwbuWPiZLXPIWWc/0qdjQ8LqcHyoFPioi+4aeVJXvx02Jko+MwXeeCgy+7V6oBgin6YQsAnWUrHpbwd8yOMvHFtMmOYyESrN+ZM82dv7QCgBeCShC1aTnHfRi166Bs1KMTx05XsYWhbOJfgkQPdGfIs9VIUErtcNs4HLukpKpv3Vhmqb0Nwv8aL1UCX5sL7gW7SAPzNmA9IDKrJ0l+B+uYn42HZZiFPorG6EooS9b7btEnAZcaiLyD+tP8qkuVJ2NwxuPxmUazYd8vo6AEJRFveumZJrJ+h8tY9WefSo1pqDa30yXo5My+cKZNwAKM7MZAI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnNXRlU3UzFiWjJTbncrNGxDNkJmRnEzdlNRbjlwaWVHQ2k4V3pGcUdXa1A5?=
 =?utf-8?B?eHpWOFRCVm81b3pJaWRNenAyQ2JsOHMvT25IUk1CMDRFTms4VGd1YUR6Tkxv?=
 =?utf-8?B?a3A3RjZMb25rOThaWGRpNllnRlc2Y0RadEhKeXdMN21CUVRTQXFJN0xEcURH?=
 =?utf-8?B?RTNBQnB6cDZJL2R2cmQwaW9ESnEvczlteGs0VU52THpuSDE0VWh4elNodmlh?=
 =?utf-8?B?cGp4S25KWVBydDlRZ2h6ejhsa3FjaDFHZDM4b0NsVGtlQW45cGxzbnB0OHl1?=
 =?utf-8?B?TU0wVFFVZlYweTBPRzJrVHpHSGRvaEtKU2o4UkZJeGtWeWlYOUdVUHJJcDhN?=
 =?utf-8?B?cERrclV4OWR2cEMwRDZ1c0NEZHdnSmt3MDdPeGhCaEtGSkE0c3VHTWFaWHM1?=
 =?utf-8?B?Z0tTNFBydHZLc3dGTVZ4a0Q4dHJwRGMweVRlRkduTGw3YytkcTNUa20xUS9j?=
 =?utf-8?B?RlZOTkJ2cnNJV2dBQVlYQi9VL0hXeklSa2V0MlVqYWk3Z1pSeG5MZ2ZFZ254?=
 =?utf-8?B?RkdiblZRNmJSNzVaY3o5ckJESXVRa0x4YkZyaTdBdUMyRWlNbUQycVRUUUxz?=
 =?utf-8?B?V1dvZjJ6c1JpU1doRUZWc2VJRVB3eWVUOXJRbEIycTBueTdiTzFuTjl3UnRI?=
 =?utf-8?B?ZWduNzgxcDhtN1NONEZpbmRBM2k0WjJWRk4vV2JTckFtMFNsaUN4VzRzVndB?=
 =?utf-8?B?dHBpdHowdkRVbVdKVnJkMWNMa2JCR2pSL2piRWw0RXhHczlFeUg4aSsrQTFY?=
 =?utf-8?B?czFLUEh1MGhjSEpVRFZGam5aWkM1TE94QkpSNnhNTVlkaDFwRmNSOC9vMmFy?=
 =?utf-8?B?M3ZZY3RvcEdqTWtrYUZ5K0luSzdrbEpEeXV3WGp3Nk5tdGNpTnVSUXpCWkJv?=
 =?utf-8?B?S2Fjd0EvQ0JKKy81UFVYMUNaMFRTblNMUEQrdk9PU2pFcnF6YmdFeWlPWDli?=
 =?utf-8?B?dW52Z1pwTGNlU2dVVXB3Y0dha2FNb2NuSmxMVWVLU0FxbWt2UVlwSzhHcDNN?=
 =?utf-8?B?b2RNQ2Q1Ylhuc0crK1g0dmtGczd6YzZwTGgzNzRjb01sMncyaG9ZN2xrcFFr?=
 =?utf-8?B?NW5WVFdBTzZoQStUNUN4djNXM3h3c2pueGU4YzVVb2Fvd2ZYbkRVWndRRExD?=
 =?utf-8?B?dmZydXluck96S0hDTlN5bUwvRzdpYXpodzluMDV5VmNDRFFDS2RVOXJ0bXpH?=
 =?utf-8?B?S0NLT29SQ1hrWlZ4SWlVMzRoak5obFhVWHRoUyt5OUNPbGQxaENZWE5QaThK?=
 =?utf-8?B?ZW9nYVBPNXRBSlNvNHRUdnl2QkYxdjlkUHlnN3RxeW9CVTA4dFFEV25qQXhZ?=
 =?utf-8?B?a2RPS1ZrQzEzRHQ4REFEQ0lWclBIOUdDOGoxdkVYTStSRFhSWG9xSy9UV0Y0?=
 =?utf-8?B?cWM2Mzl3VnR1QnZHNmhrbzFWMTE4QjhJK0phY0ZPVnRhRzVtQ3c4YmlpQjF4?=
 =?utf-8?B?U3dNd3JuVHA2akhkYlN4c0RBNVVzcE5ZL2NtSDdXdUE5UFN6VlVZM3JPNUYx?=
 =?utf-8?B?bGlseUtqc0l3b041R0tqZDdjekNVMUtVMFF3VEpvdXJ1alZHZ25POS9FTHVn?=
 =?utf-8?B?QVUydS9jS3VaY2ZIeWxyNnJ6OWkzRjZHOC81V2txQlVBQmg5emxUQTJKUXJE?=
 =?utf-8?B?bnR3NkJSckQreXBwdTNHalBpWU5Id2V2MGFTSzNuVFFRWGRWSDRub0ZRWjBw?=
 =?utf-8?B?WlFiVGV0aVUxZDJnU3JpVVBNaEdacDZ3TlFQMTVwZ1ZKaFRyMWFkNjVjempt?=
 =?utf-8?B?UEJvVFVYVXNuVTBjWXdVWXJyWTZDVFNpYlRIUk5GNTQxZ09wa2dYUFB5QmJ0?=
 =?utf-8?B?QW5GeWdsd0drTXo1SUxsR3ZWSUc4ZTIyTDFaRFgxRytDTVFIOUJXTE5wUHF1?=
 =?utf-8?B?MmllNHovbzkzcHpWZTJLUXI5cURmbDU3L3JERk9jSFBBbVBTWWMrRTd5RUNX?=
 =?utf-8?B?cGw1alNVRk9jWGIxOU9oVVJjbjVOOUR1Z0V0Z0kvYWhOa1V0Vk5EZUk3aGJz?=
 =?utf-8?B?WFdOLy9kdVhncHVDM3JBWWxrOGQ0dUxXeHpxdmNrWUtJQitvallXVVVXZ1FW?=
 =?utf-8?B?L1dqMzlkRlFjR2R1eHFxV080NU83VzVRT1BIQ0pmZmU0UnNlWW92bGhaYTlt?=
 =?utf-8?Q?GYqHblv1RvUSD51lTtqPRpZT8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e2c0d5-d1d7-42b2-1db8-08dc5a867b41
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 00:21:22.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+Yfz1Wp0a6mUYFn7o89egMfJMnvDgn2+UTanWH/58sE6HF07pRCrrBgAalYeRE0U7RMvhm4JJkGxggGdNxk+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7970

ARM SCMI v3.2 Table 24 Pin Configuration Type and Enumerations:
'192 -255 OEM specific units'.

i.MX95 System Manager FW supports SCMI PINCTRL protocol, but uses
OEM Pin Configuration type, so extend the driver to support custom
params.

This patchset depends on [1].

[1] https://lore.kernel.org/all/20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      dt-bindings: pinctrl: support i.MX95 SCMI pinctrl
      dt-bindings: firmware: arm,scmi: support i.MX95 SCMI Pinctrl
      pinctrl: scmi: support i.MX OEM pin configuration type

 .../devicetree/bindings/firmware/arm,scmi.yaml     |  8 ++--
 .../bindings/pinctrl/nxp,imx95-pinctrl.yaml        | 44 ++++++++++++++++++++++
 drivers/pinctrl/pinctrl-scmi.c                     | 23 +++++++++++
 drivers/pinctrl/pinctrl-scmi.h                     | 15 ++++++++
 4 files changed, 87 insertions(+), 3 deletions(-)
---
base-commit: 6bd4dec347319b2e0b713a88956470e352f493fa
change-id: 20240412-pinctrl-scmi-oem-v1-494ca2ab1480

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


