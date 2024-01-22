Return-Path: <linux-kernel+bounces-32375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2712835AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DEF8B25ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4BB6122;
	Mon, 22 Jan 2024 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fL1U9uSY"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5A5673;
	Mon, 22 Jan 2024 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904109; cv=fail; b=A25FoXdEgzXA3R9K+X0naBNPV750m/K4xv4Xg47WgwJlas1G6s88xdd/gAJCQlcQTLYYhfa94kDe5i9h64/EWZfCgxA0R+YabipR2pSzqpJGv3PiuSQRE7UgLLFmjPc1ucJCDG8h3wU6mqZKRLLlPmgz9z5DGv4LqUakRlZZKa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904109; c=relaxed/simple;
	bh=BCXzV4X25NJK/Trt8Wz/CxOlEmAEtMNWyWB/JUuOegQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=mLFuesWZlkk0mhTUEGKATHGodsalvQ9YJTpeC6d1kCqMmWyr8FNZnfzTvgnv73liBAdQo4PN6+PI6lBSe3i9GThs0D50OVQP6OiTziNSJN6CUuivrDto5GP4S9VqVjBaW1P2FF5WH9iQ3771LMMoPdjaAFQWysxJYNvxzaTUrPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fL1U9uSY; arc=fail smtp.client-ip=40.107.7.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxzVCoRDRLH+PAPKPCs3jXwdcVZlWs6VCxeux3LoWECGagabvvvJPOSJ9WR9NcE1SGFemqE+1X5nc2FAEVjkd2BefLoOHmYmsbpcO82EEeqK4c+1uSEdCBcZKZcN0Vncp/RbOYMSm70aBHYNLBTDZjGSZs0Fs0D66FB601hMK7mIm0mKMOnO+7YJ4qTPokSZQZb0dyTYIdqZAR//ZcCiRPZ3zdlZ99jh9IfgtiAmQXkBvsbemksZ75OoJuLz8HadZowjDfOV6J0QpjdeFDGePCwKYesOGVAR05Cm47oxKqlRjRZD2l9zPURw20wBOBxtUS/wncto6GzvDE5IZzQvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QJDF/1VxNxo061DUHo6xh0TFK+HtRPsHgUknYFh8k4=;
 b=d8BQkWJZuuOuX7DgyDR8sewiD+JoEXW7fW2czG8UGJ65POvSy92wrkvotM1i7ahFBVnNcO2x6DRsS+axWGkRNhKLw3ZHw6pEMeb3as57lis5KyA/fudRKJTcklTIjE985LRMSTHvKb+M1YmmP1YliRVDWKIW/nhR0LNO1q9lzNOHNohseD8leHIU1h6a2+DpVPKkUpSc8+kVb23mbqO0BAenYI/WtgqwtHnDFf+Zn7WarII1JcmggLexNf0QB8vEgbWOJ/b0ofnCo0ZE7PeGUYneghbpRNi/hEfIgxORWB9xaBVkPNhpvKiXTgj7xiQEyHL+n5+pu4zLbo9ps3FvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QJDF/1VxNxo061DUHo6xh0TFK+HtRPsHgUknYFh8k4=;
 b=fL1U9uSYD5Ns/ISaqvOjJkMk6XJ23OI7IOVuYBsMqd34YmBVRzYe3InNdXOwmomHejOiFyC3v4EPOR2byR84+1GLZQsI59puXZxUMS+WVqex3mzioWBXIdicdIdsQEVcTINos8YDNfRVWn1UbDyHsIbUw7jFVl8P6Irzmb3Uuy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7940.eurprd04.prod.outlook.com (2603:10a6:20b:240::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 06:15:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 06:15:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/3] mailbox: imx: support i.MX95 ELE/V2X MU
Date: Mon, 22 Jan 2024 14:19:22 +0800
Message-Id: <20240122-imx-mailbox-v2-0-7b3c80333b92@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOsIrmUC/23MQQrCMBCF4auUWRuZmaQirrxH6aK2qR0wTUkkR
 Erubuza5f/gfTtEG8RGuDU7BJskil9r8KmBcRnWp1Uy1QZGNkjMSlxWbpDXw2fFRiPTRIwaoT6
 2YGfJh9b1tReJbx8+B57ot/53EilUVzKk50vbMuF9zdt59A76UsoXbzZOQaQAAAA=
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705904372; l=1104;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=BCXzV4X25NJK/Trt8Wz/CxOlEmAEtMNWyWB/JUuOegQ=;
 b=DmxsB+Mz4bqS/ZEeMQCeXC+R7e2s0XnPtiTxCJHVXk6nMBubSSrHvBwv1+1KWgoCoQN+aX5an
 FdzsnAY238QAFZ94jNdb9bC6gbdwstxbNdrJNefxAzdklqVuFpTQ9fp
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c0029b-2357-4b5e-3f52-08dc1b11783e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	asbhQTpMImSnFE2nBGrllrmP8CpdgOMghecJ8QR9wLKc7w+dd9YaaXqMQZQI2u3ymJ8yqJ0vbaxjsD5Uylc8Secl5HOIR0EKVKLOuFLG3+Qk/9DOBDXdC830zeP2PZ9XU/BcYM9USe8xSKt8hKbmSitlF2nAVqoxwR/0qvWeBozmnUlUb4swcjOBMUYKRbH/fg5NqMqvRAOtFZyAWr2kZXCkfH9N0RSmUXtXi9SFdH+ubn/2EVg0TPOJwvJq/wn+1n6PowNcNGOw4ByQn0lz3DWpKBeokx7603h6gzvKvnYJinJ2iwzuG1dCLGDf68V6hkcr/ZjmnsNia0o64Fd3BaqrjPRe0JPfJqy1pc7oUz9yvx73mQB482k4sabrDAcmRz6J9ydb1fb+7pgqg5ZGWV5ftJ8UK67Nur0QoaydmiYs9NmZi279+1wXuH/sR1r6aRU1vI1SOCtJSHx5cFGTU9QTvFR12AI9bpeID5Kal7E0g5WhDavx51LKYdVVeHbwzv7FaKy+kuIba2/S9iETQBdgLfqIdzk1GoRkqJM/bRUvngwMQqYeJl0t3RO3Vwxqpq1F/iwzMXnp+Gr4xMt2g8/mYkccf2mPrjnPrdbNz0HxVVGbwfKoRnmspH8vtVIv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(26005)(921011)(36756003)(478600001)(6506007)(9686003)(52116002)(6666004)(83380400001)(6512007)(38100700002)(38350700005)(6486002)(966005)(5660300002)(316002)(66476007)(110136005)(66556008)(66946007)(86362001)(8676002)(15650500001)(2906002)(4326008)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUMxNE51TWRQTUlCNVJydzZWUWxSaWVvUnY0bmVWc1NEaUNNdzU3TnNZVjA2?=
 =?utf-8?B?elpyeWpLa3pjQlhMcHFuRGN2Z05Oc1d0V21WNVlNb0QrdWQrbUFRc1NzMzBs?=
 =?utf-8?B?MXVXWFNWQ0hSb1E3U2ZSSXdid0huUjhxWVVwSTdndnRxQXhCL01HUkVsTUts?=
 =?utf-8?B?aTljYmlYaWJWL3BqdiswR0ZnWlR0N2pKV1N6M3grMFEwYkR1L0dMZVAyeE43?=
 =?utf-8?B?YXhtZml6MTEvT2NQMVJrSTk0YjNqL1lFckxiZ0wvUGk2VXJOaVRWU0h5L2J1?=
 =?utf-8?B?aWNvT2o5SU9JTUhJblFmZ0ZyTXIrTE9mVDZvNVU3R3pObGhPbGhpRTZrNEFj?=
 =?utf-8?B?a1hmQU8xMUkyMjFVSVh2dVRpYUFLTDJvdjFweGN1UWo3ejF3Wm5uN2d6Z2ZB?=
 =?utf-8?B?eE5SZHk4SzV2d2R1V3JjQWRNajlUa2ZSV0pwaXF6enVmK0ZCWWJSRTdSaDFH?=
 =?utf-8?B?MHNKbHNnYzhFVXdiL3lmMis1Rzh5QWFvOXcwTjdBNXdMekhuYjJGUXlyNGNh?=
 =?utf-8?B?cU93c2d3dEZlS202d2xNRjlwK3VTYXhwckpZZ0Z1OGxOT0hRNVNMNVFFVFFo?=
 =?utf-8?B?anVOZDFTMnpReitadjZYU2dONDByZ0lZYyt0NWk1WSsyUEFHeGh3VEtaUFha?=
 =?utf-8?B?bzI4LzI2aTdWRFFRRlRWQ0dJTCtxSWpkMkJkTGdwdUNhRzRFUHRkZmdrY29J?=
 =?utf-8?B?OGIyYzNMNWNIRGFTTm42SE45a2d0aVhwUi9oeDhpL1R5NVFvRjUxeGE5UjVH?=
 =?utf-8?B?RkZxcmY4MmM4YmtUWXFra0g0QnNSTW9GWGtjTVY1ZDZLeldjYWlacy9Fem1p?=
 =?utf-8?B?RnA5amd4NGhUWmpxTGx2RUQ0YUlyUFduOHBZV3gxYXJzRmNBZENlUGlydEVG?=
 =?utf-8?B?RkJlRHJhRXV1SVpjanRmNG1meXl6SFZacjZBVG9hcC9ua2I4dkFMcEZqWUZO?=
 =?utf-8?B?ZFl4UzMxV1BERDhMMHZXRXNGSWQ3SmlyUGViWmlqcE0yY08zVkdES3FzTVpR?=
 =?utf-8?B?djNMdXB6UjEzSEkyRkkxWWUvWFdqZnRFQUpjMU1TcEh0L0tLazhhbzNLUWps?=
 =?utf-8?B?TjF4bWtQclh6enBGci9MWHFLTWFCcVlHUk9KZXpCT1Q4b3ZjaTRHNHVlRGFv?=
 =?utf-8?B?VERyRE11d0VDZFpxMy9RUC9zbWtNZXJkZVA3MVE5eVR4d2lIaE5QRnFXZ09N?=
 =?utf-8?B?QjFUVE9nWFBIcE5IU21rNEM2TUJpS1h4eVdPQmpKWG96V2NqQjNhUVJEZnkr?=
 =?utf-8?B?bmhmK3haU2hSSExsSDgzUVBPbldFdFlKKzBGY2VJSy9FRGkxc3o4eGxRVC9s?=
 =?utf-8?B?UjlpakQ1ZTdjTzlvVjYxRUR0ZHhqeUdlcHgvdmkySzJ4ZGMvMm9IaWRsVW9o?=
 =?utf-8?B?VlJ6TDh3dTBTVHo3S0dkV3l1MW9vRWZ5SndwYndDQ1FDWjQxbVNKQ3o5TklQ?=
 =?utf-8?B?eDU4aEYwY3ViblU1dy9HUjEyMFkrcmIzVndPQ0RPaDdpL2RNdlFubVZ2Wm11?=
 =?utf-8?B?OHFDMW84eGxOMHg1VTJqWTBEMkt2aGpLRlZqWUp3d1M4Wkw5bVl1R3Q2NmZL?=
 =?utf-8?B?eGZXRlBnUVBFK3dZT0x5UHNabGQvR2IwWE1yVmFHejVPQWNKK21ldWJ1S1k2?=
 =?utf-8?B?MEpmZ2Q0ZmhobTliMFVZTHF2eEFza2Ezd3ZQZWU2b1hYcHRvaVNGbzg0dHlX?=
 =?utf-8?B?dlJyc21YWlY3RUlKOTZ6bFc4NDlyYnZGMXVvdFcyalR5ZGtUbzY4dnE2QWoz?=
 =?utf-8?B?Tk1pU3lPNDJHbzRDWGRQU3d3aE5MZ1Fja2szZ1NzcXIwWndoNUcwT1poKy9q?=
 =?utf-8?B?WkRscTA4NlFVRkNmdzdrYldHdGdrWHNIWGY2UEtoRThGN3VvSlNiNGlCeHhS?=
 =?utf-8?B?ZVRkRVVQK3JnQ24wOXpZYVRrUEJYdjhFMG1IQXpMNEVlK1BEM1JLbFhQdDBJ?=
 =?utf-8?B?TU1iYURsZk9TRFZKSG9keUR4SnJMcmIzaDdDZ09zTW9CeUxBaElmTXRUblRm?=
 =?utf-8?B?cWtQY2diUnpQQnNPa2ZJLzhTclRmSkNBZzV5dkg4VytiUGJ2VUpiM2NFS0N2?=
 =?utf-8?B?WHE0ZUhWNUE3RVBuRE9SNDA5NVJXMVZLeWtkNm9SdEU2SVdSWEFFQVdJMHJH?=
 =?utf-8?Q?Fixv6d8P3JQ1ji0v9rgnSOeG/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c0029b-2357-4b5e-3f52-08dc1b11783e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 06:15:03.2543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MeBSArQ2cHUzTdomeJFHrX2vOsZeo7cn9bTNNcuRNAq7Rtxv37A747uW3WXIOAj72ngsHzbWoTti+cP1aAJ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7940

- Add dt-bindings
- i.MX95 ELE/V2X use same register layout as i.MX8ULP S4 MU, but
  the TR/RR num is different. To make code reusable and not add too much
  macros, add runtime detect number of TR and RR by reading PAR_OFF
  registers.
- Add i.MX95 ELE/V2X MU entry in driver

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Support sram property and add example
- Populate the sram node in driver
- Link to v1: https://lore.kernel.org/r/20240122-imx-mailbox-v1-0-81413f655210@nxp.com

---
Peng Fan (3):
      dt-bindings: mailbox: fsl,mu: add i.MX95 Generic/ELE/V2X MU compatible
      mailbox: imx: get RR/TR registers num from Parameter register
      mailbox: imx: support i.MX95 ELE/V2X MU

 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 50 ++++++++++++++++++++-
 drivers/mailbox/imx-mailbox.c                      | 51 +++++++++++++++++-----
 2 files changed, 88 insertions(+), 13 deletions(-)
---
base-commit: ad5c60d66016e544c51ed98635a74073f761f45d
change-id: 20240122-imx-mailbox-243021d12030

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


