Return-Path: <linux-kernel+bounces-85576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C3286B7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02E2B219C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B39D74416;
	Wed, 28 Feb 2024 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QoyuC5G+"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAC071ED5;
	Wed, 28 Feb 2024 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147675; cv=fail; b=UEoeFyIyFaUF/hJxpy6yJp/hgRkS7GjJXcJeSTImHN3KOZzAlDJO7ncLWpJBejT5AU/0bwJE8ZaLVTi9IyBm0klhbybzAx16nUCM1S9lH6yeHwVeaUAmUWRjFxjyM+OPpgpJLx0czr10505VO3PLOoBLI+BhxcsP17B01BqJz50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147675; c=relaxed/simple;
	bh=7iNOKyVgPV+NASK32AAV4GSz44MILMDSyJ7liOKDspc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=M6cUx0PDoS8wAe8zSqfcBPYJXUgsbDfj9Xhu/clMO24C8xhs7SfBqVPE3R9DV6yi3xPQmKNtuvtNy1mm1WBltOoMTVn5F+eOVCAUBT/VtsOhguTx1c1Yly26jYndv77/WBW82dzP0TUTuIbqcrehps79ioB79AK+YLealeLwtTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QoyuC5G+; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUtl+j1d+PMqV2FoDdIX7LTgpo48R5MpXJTnPiMpqUwfE5ydDeSveWnSDV1l1KPpkpfNrUwDPp8TQQBBFceYntlFEont2p6KIWdlufpdDpvOUNQGPX+zcpEMmmjImw/Vstl3l3f5W3R9iMasPvt1rB+0cqc/CL5CpzMwRWHgUHFbD3FEotLah6DEIGE3Dne3oK3LvqKVqtXol9am8nXAaVXE4AMEqjK6NTX463F1WhL9qny055OMHgQDMMB8JeH1QNZZOw3RHM7JU/NUtb7dFbMxMrMtxyFXEqUuMEn2AnZwQOCY8/lSc9UmwEJAKdPQU5qAW0upqvB14DJRjkbDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgX7pm/WN4qh/OVOYBqwQuf7h4vJHUClXfX1K8VHH4A=;
 b=fiDxdflQEbQa+DT9z/WVv9wcZtxcziAFU0T2vhZa/2xswmZYPo130N1O7cgnHuPxnqGjyyaXY/f6OtmXMkpivh3WWBCOcUZMu+nGeLSrJkXEoQNl94cEG4HaCwdTMtUe13lm/D3hQGL+eIMwj0NIN8ZzQQVPHGiWsvFhORUI+oR1uLTM12yVJeuS6MMTtJUquHHTDpCtHzLvXNsD0sc21fcjKX1kjFGYtIPnlCmVyjwiIcWo34wbDNqBKlTyOTBoWErCe0hCGrIMn6p8ZMAtWEwKTgrWFTvNADkkOUtDq5BSvKnZEbDqIg+gHoX1VM7xsDBPI/mXCTzH8dGr0rH2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgX7pm/WN4qh/OVOYBqwQuf7h4vJHUClXfX1K8VHH4A=;
 b=QoyuC5G+9zRgDfizrntChH6bYk9+6vN4xR7BX5iZL5VlOvlRuy76l/CZ3eCGvMtrr+H1b2E+jtn0Tmu6Lkj3NvXxjJT+k3rjPjv7up4iUcpyUmZ8rzpLcy7MKMu2CmuQN+xSbXoAc+1cKi8BMDNvreNxgRb+KKOaADU46iWhANc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9835.eurprd04.prod.outlook.com (2603:10a6:800:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 19:14:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:14:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/4] arm64: dts: imx8qxp add asrc and sai
Date: Wed, 28 Feb 2024 14:14:12 -0500
Message-Id: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASG32UC/23MQQ7CIBCF4as0sxZDp60QV97DNIaOU8tCqGAIp
 uHuYtcu/5eXb4PIwXKEc7NB4GSj9a5Gd2iAFuMeLOy9NqDEXiIqYWKgm37lVeBgzEnpTvdyhvp
 fA88279Z1rL3Y+Pbhs9MJf+s/JaGQYsB2IlI8tSQvLq9H8k8YSylfdiyHmKAAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709147666; l=1288;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7iNOKyVgPV+NASK32AAV4GSz44MILMDSyJ7liOKDspc=;
 b=w7o0dQexyDWQFJ92TeSxkkl45lnSkdw1GxAfYFryXW4R+5rFVt91OuA+JLSgiz8IURQjlXyKU
 6R9PTIrBml3CNeOxual0PbOg1hYrCpZXPTv+Q2UODySNYKCRKenWwWL
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4a00dc-822f-40ba-85b1-08dc38917d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RX+sXaMYnhBl2U/w9n9LETiGc669ERUruq+6FLgVj7Acke7ThB4flGa1hcrRaaCLJdy+s8RHRSwSXldu5BlntBauEMRT+cc8ZcxG8rlMyMw8M6kK9ZKW0LGOwNySmJ+iPxw4VrFlpTKGV6/xPi1XAj6Pd1gspgQAWHzuZsBh7IfybwO2wj/MSEPdubPJW9ggu/eb3LSuWtF881j5cbUgb5YLDWjn2RyneWxyvaBs9A4GgtL+IIypyXNCNsUUt6DB68UlKVDUsH2iX0JVMIuGsefjbZWEbPgk6bhp3HPJHqUeNtwBzVfN08i8Ala3Pd77UgUP/9zgN+U5xD/IYDWtJhdcrfuoX0jh6VbfY1gbr0E0OimAiowPe6e2KfA2We18T9ABqR2zh6j4W0i9neYlQ26R9VwFS2jHjoOV/hYzKR2CEGKYo2DyvzQ/z2qS+6hYpMgL9ZFHvYOb/jjDSq/GyKsAK7l8tT61YBW/VzqU7UP5hQXrYTfaDMGRnsSATvEo9IGL0b3zDod8tGbE9XMyIIcnNoZgZzQohzLQgdf69JC3vFcgO/GmjeeOvcI5EtAzzCPJyKOMW7MnDzQ9lx01ujkrgFJ6f0ZccmLlz4Ka+3k4uJsYLj/8qzGuXbR6K1NtFCe7mnG96jrFDTwDY1eGpd8DyyEwTeuNsOZ+xPpSnqXD80xc/VNx/GOsBFfD3+A8+9J+frxxIJV3S7dZFuHQCyQZLUpq6g/ppItV0RqpBfE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkpIM3VNNVByTkZibzV2SkRHTGt4R2R1NEZwWGdUSW1yVkFYbzF0QUlYL3p2?=
 =?utf-8?B?YjRJQVpxVXB2T1k1RURoN3Z2dEZROXFPdmNEeTlsOTROdXVQem1VcHp6R282?=
 =?utf-8?B?a1VsdlBMYlZCRzBpWW91eDlpdlRlMGt1eGtKWjNTcFh1cjdTY1IxMlNueCtH?=
 =?utf-8?B?WUFITjRKSHIyRkR1Y1RSWWNwb0wyQ2dxdmwrMlZSV25SdmVmVXE1VmJXYVdw?=
 =?utf-8?B?ZTk1ZlZqVCtjS0krMGxZbTZwTmRpQUhMSUxVT0taNU91Vzh4RHVyMXB0eWph?=
 =?utf-8?B?V1ZJSHVVdTFqbzhvUjJXa2lDQ0k3bGxNSGQzbHAwbmxvM3c1NjRiUFphM1NI?=
 =?utf-8?B?OTE2bGhQclJLVTVoNVIzQkVIZkRtMUVOZ29oU1RIVDRNOHprQUV0ai8xSkdU?=
 =?utf-8?B?L2dLSUkzazRnQUZRbVpSQWdFeE4yUlNmb0N4M1RaM3R0V1RRWnlqb3FLajRx?=
 =?utf-8?B?TW1rOWZYd25RMW9VM1BaMTRXeFJQVVNjaDV1cFlVVjAwMFRldGNNbVVTcG1P?=
 =?utf-8?B?aVJLRzcwNnRwU29OSEFDRjRJL0lmWSsrYk4xR1V4eWVDS2pFekw0TUREa01y?=
 =?utf-8?B?VlVWN3FYZ3U1N09IZTJoYnlBaVh2M215eHJuUTIzbVc1SW80VzBrYWxhV0NJ?=
 =?utf-8?B?TUVuVElWOGFQOG5zNUZsS3B2YlpDb0tqVGRJT1hLNnlxaXhnelUwcDZHUDVp?=
 =?utf-8?B?ZUh6ckFPN3ZFdW1LcFZyWUVYUSs2c05FMERTUmFaaUs2ZnVRTU9PT2NibTFU?=
 =?utf-8?B?c21IUWJhVnZqYndMNmtMK0k2T05MMEhXdlNSWDBMT1V4TUZZZk1IZDB0Y2xo?=
 =?utf-8?B?S3RMN0lQYm9TU3VVMXRLLzhzMG1WcE1qanEwZ2lRNUFLdUxvTWlZbitqUUtH?=
 =?utf-8?B?RE5qTTlCRGRkUEp3TmNWRDlPVCtZa2pWZFVoc3k0cjZMTzJHeUZNWW15UVNU?=
 =?utf-8?B?Y3ZCdndZcHl4ZGpIM2ZTYkRQN0J5bExVTjNwMCtXTVphK0F2RWpXeVhGNjBz?=
 =?utf-8?B?d2hMaUhHSUxYa1JxdlBLT0p0TkRyZjBXVFpFWlNId2pSZEdQUUpFRVBOdHdn?=
 =?utf-8?B?YlU0aVI0K1REbjJza1ZqWlRiaWZyMkpFWU85cUxZM0p5RWFJTnZUWEhlQkk4?=
 =?utf-8?B?Y2lSdVBUZDNHR3oraU5RajZRTXVnODdyRkp3QkxVVlVhN3NkMzE3VXJQSWh6?=
 =?utf-8?B?anBTY0wzYllFRlZRNmRiV3VPL2RLYXQwaFZKeHNON1prdkcxRWdIWTRBejNr?=
 =?utf-8?B?MmxNR3lPVkFMQ3Q0U2I4ZkdyWUg0SHJHdUxmM2VkVWFkTy9TUVQ0SFNHZDM2?=
 =?utf-8?B?cVRiWGZpWGJoOVp3SnhkaHBGVm0rQjRDaTZOUnc0aVFFYStONkhoNjlMZ09i?=
 =?utf-8?B?TFAxbVkrOGt0NWJoejBHOGxaMVJZRHVGaDFydUVYTUxpUXJqWG5IcnFhYk5x?=
 =?utf-8?B?V3cvaDdKeTFYNE9zMkcxck4xTGF4Tjh1cHV2K0hHWHFvbDUwVUsvRUNpYmUy?=
 =?utf-8?B?N0sxaGl0VUdoVSt2OUhPTExIYnJCTDlmeFVDTExQNjVndDlKdDZSM29PaXda?=
 =?utf-8?B?UXVuTUJRS3VlaE5rZFE5Rk5Gc0VUSUNSRGdGYnFQVmJNaTJVbmlvRjJYd0NH?=
 =?utf-8?B?Yk9qNE9uMEtmTWhXaWZPaUVOZ2lweFdkcUM1QlpFcWdkQXlwOWk4cWFyVlk0?=
 =?utf-8?B?UFlkWmRGK1VBbVVya3BFcy85bWtpVnNrOXA3UHY4T2pBRzV5RXROMmYwWWd5?=
 =?utf-8?B?OGlCSEdjNFJjUXI5ZEx2Vkpab0xaSXEveVFveXNPdTVkR084OEFKd3lNbFhG?=
 =?utf-8?B?USs3L0VRcDV6eTE4bndCeDRGd0ErWGFoYjUrc0NQVkZKSUlBam5Heks0WHd0?=
 =?utf-8?B?QUM3ME5tYTRuYXozdUZNVE5oL1JHODFFNVNhZ3k5UHhtOHBjVTBIc1prWjJZ?=
 =?utf-8?B?dW5ISVRMTU9PRmtPQVBZdnVNQi81OFRqRm5HZW1EQ0F6dWhOOU1qaWhRWmFl?=
 =?utf-8?B?Q05vU094dlRXMkltTS9OVE1YM1BiOHViclJ5VGh1cVNobVJJdEZBUGRDRmx5?=
 =?utf-8?B?WmRDZ1J0TUVLK3ZFNEJpQXRlbDdzd2VOYVRsWDdVSG1zRmM1M3BFNEs5bHI3?=
 =?utf-8?Q?flxQWtzLBXbQRYGGSdpUyiVY8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4a00dc-822f-40ba-85b1-08dc38917d4d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:14:30.4202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju3mboIiN+5jWp9yr5kquJoIKFfqwgU+a/CONB/koQQsgMrqMRJ8DCgcsZ5nl30EAoXs2VoZf+wFwFD10MNcfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9835

Update binding doc to avoid warning.
Change from v1 to v2
- Fixed dts DTB_CHECK warning

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- Fixed dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/fsl,spdif.example.dtb: spdif@2004000: interrupts: [[0, 52, 4]] is too short
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#

- Link to v2: https://lore.kernel.org/r/20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com

---
Frank Li (4):
      ASoC: dt-bindings: fsl,imx-asrc/spdif: Add power-domains requirement
      ASoC: dt-bindings: fsl,imx-asrc: update max interrupt numbers
      ASoC: dt-bindings: fsl-sai: allow only one dma-names
      arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif[0,1] and sai[4,5]

 .../devicetree/bindings/sound/fsl,imx-asrc.yaml    |   3 +
 .../devicetree/bindings/sound/fsl,sai.yaml         |  12 +-
 .../devicetree/bindings/sound/fsl,spdif.yaml       |  23 +-
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   | 304 +++++++++++++++++++++
 4 files changed, 337 insertions(+), 5 deletions(-)
---
base-commit: ca301cf599a4eeafed8e3dd87bf8d2fe810e075e
change-id: 20240227-asrc_8qxp-25aa6783840f

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


