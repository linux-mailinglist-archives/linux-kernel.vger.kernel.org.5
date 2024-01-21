Return-Path: <linux-kernel+bounces-32000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33286835521
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563D41C212A9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D368A364C8;
	Sun, 21 Jan 2024 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DA5NZeHD"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2079.outbound.protection.outlook.com [40.107.247.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC2B33070;
	Sun, 21 Jan 2024 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705832277; cv=fail; b=MmARBfzVg//WqKdyNwKpBFesnZoa34VjM1Fo4Tdrar3BHwtq6z6b3C/7CmIjjrcvb0MsNWYtNy5ul1g6Q7r74yzQ8R9eiMmfHuQruD4gIErRcMLqsOIJVIuHaoQcu35FMhoZKGj50I3wGJJqzgBUbGwejovidKA+9vx9hGZYcvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705832277; c=relaxed/simple;
	bh=mjgn1afGVkPfYsYqHkr4WM3BX7c/LQeh2L2w+ZgeSCU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Md9mPRIjTbiBghXk6Gw+c4CP3EHljQZz/7xg51HtYNWZ78wTF8ehWZBbEFSGAr2o8uJDI6nb9tqM8gkFsRkhWp21cXU4TYrnPOouJjUSLZYWwQaKEu8Ks4fcUWcb+l6CDP0gxgrdy9AhOuDvR6LT9a6I9Jf4k3a8jzUfqj7yuRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DA5NZeHD; arc=fail smtp.client-ip=40.107.247.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgtL9ISKVOus7nXhx9utpiW7ickH4VPC3iba2+z1c6Hgla+Cj+7Py1v66JeLyU+4hJcvnK2eR74AwPdL1Yx6GSfBmb/MErDyoCRVGaFmNOQL7ZHPjqSpR8NeaI0oIWP1xlZWjC8VPGTg3V9KFyug75pvMuFST8ppVwjP5YErWt86mSbNwKJiwmI+ifqlW1QRgHOvkrVdA50TgsM5atpRMox+oOTYwwl6aK/4859+TSFx524VuPccmwLWLteigr5M4tszWuS7dtKp+24BD/NdBhnPYSm8O7T3WpFB+0nCIWHHF2EvRJ7O2452WibJ4B2G7icL87VafJRGoOLqmFTThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8AzmDQKk1IOGVpnymFSzc99Qrn61vuzBfA6Rs7uiP4=;
 b=eWKLBNMe3tADmAIv5ghSNNyV9qetUH5zu6iYY9O63tH2b5UNEYwhCmnIFORhURC4M5pJrkN0I9rmbP6DCFxxnBsXvtRGNUSFrfqgCYgdz9rMlnkKzZXm3osazNcdb7Ivn7WnbfnFsL7Ly0NVcMSW/wJ24Vrr7r5RlD8iPoNbz90cw9zDUNB+IS917oUl8YDTU0sIJhyi4IgtQQTR9Hub++JZGSESB7aPBgnLA9TbhaC4zLYVzjwuicv260uoRztOtItvvZQ8xEnwSnc1cOfEydEjAFjW/JpJQ4CUXwkQp+Yxh/UGhKogqAeEPiee+1wAWRChDzOTXXRjJEjx69m6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8AzmDQKk1IOGVpnymFSzc99Qrn61vuzBfA6Rs7uiP4=;
 b=DA5NZeHDbxyuaoBmS51NpF5SitACoMDaLjBNPIBEvgNzm+TnNvqOrLR+L0blTtq4+blrZiiWUyLOB3SweamlpP7Ai4X1EY2HKyj/FsgYmstWs1/GU6rfikQS/0COsf+B+eer7OM7zXGZpoxtgQSvHcwBcA3b6wsXD728UWQEmrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9203.eurprd04.prod.outlook.com (2603:10a6:102:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 10:17:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.028; Sun, 21 Jan 2024
 10:17:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Date: Sun, 21 Jan 2024 18:21:49 +0800
Message-Id: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD7wrGUC/3XMSwqDMBSF4a3IHTclT7WOuo/SQYxJvVCjJBIs4
 t4bhVIodHgOfP8K0Qa0EZpihWATRhx9HuJUgOm1f1iCXd7AKReMM0Um9GYOTxLNgEQa1VJRSSd
 NCZlMwTpcjtztnnePcR7D66gntr9/QokRSqizQllZMuaqq1+msxkH2DOJf6ikjMofyjPVl7arS
 90qXcsv3bbtDRPw7IbhAAAA
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705832539; l=5245;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=mjgn1afGVkPfYsYqHkr4WM3BX7c/LQeh2L2w+ZgeSCU=;
 b=P1L28PaW6qt8mg/623Tu6UAnvTt9FgDy9CnxN77RPki13X9oB/mDy0KkHZsOJLuTrDscMwk++
 kj6Pq6kqG8QCfU7AXgmyBW/JUOFCVK52wJW+4YebdPcm8KJb6y/PrNx
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d11b9af-14cd-4051-05b0-08dc1a6a3962
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FFkh2IBOPTiCaYuxjTMDvuYoon1ZwwZPz5MxsqLXnfrLMgUtFp7V+U+aCR4TUHqTwBBBnA0S0e8mSsbcBjvyB1iz127ULgdjAabPFgVyolxCvmlsj0jNttSfLFPEDujsj16QGcle8SCaCVfDuQVufQ4ZOchC/kRFXVnxzTpRrW4KUcLakn6IoCTkcKs3yw3bE50SUkVi0I5XZtiqiys58VM9Ax85Goa03wlDiAX3Vhpbz+OaBiMJ6fWnnHHfPx05iDL/l/kWDYHbeWkP2qogxT2DZoW/9ftCb8/6EcaRNodf+Q3VMJj6D0H7v5lbn+sE/eOoX+pB54nYAO/r+ECKWXIqPVFplTZbdaY4+e36Zyg65BaFKzD2RRh7sIEHBCQkiqlwl3N9X0XtKaZXhgu+mSsYv+N8e/yu94aZj/p8CgjYFJ9CPGK2bqapm6/YGoqysfVesXLoGoxwjhbPzv+NdLkQtutynRIYIMK9Ia7EpCAwUcOL4jFmTVrWP98m7jFlAVVBGcz908iO6bJVUCVGJxWsoMAJ8sA5I7sFrUPzJC+vFGntwnh+P7ldblbw41bjHAiWOL881CuHpNHif7wW5RQTXl5Ph3YnAtLp+G25sBV5RWTdcDIpPLecdfQ+dAs/vgQWo25bkTB4FbW6z/zwU+77674LQ3DhVtE/xuTyrww=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(38100700002)(26005)(4326008)(8676002)(8936002)(2906002)(41300700001)(5660300002)(7416002)(4001150100001)(478600001)(52116002)(966005)(6486002)(6512007)(9686003)(66556008)(6506007)(54906003)(66946007)(316002)(66476007)(110136005)(921011)(38350700005)(36756003)(86362001)(84970400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUMrOUdzVnlnbkN5bVlnR0lESmxwQTRzSXhLTmdscit2VHJJUDEzVUk1VWdn?=
 =?utf-8?B?ZVcza3g1TnhRdHp2K21aeUtqTWc5ak5xWGR6bnFucnpacE5GcmgrSkpsTTVN?=
 =?utf-8?B?bWZ4N1FIRFUyMXZQbFZkaGsrYXdTZDMzOThOeEQ5NE1JaGY4THZsVDNYVU9t?=
 =?utf-8?B?Ulo4b3MwcUdkbjgwR2hsZGZ0UUxLOU1SeTZaWGZVaTNuNDZyQ2ZOWUlmbys3?=
 =?utf-8?B?ejRpNCt3WGZJNS9zSUN3d0NxVFZWYTdvVGhYUEl4dFBaa1NvbTc0eW5ZZTVE?=
 =?utf-8?B?dEk5SWhwQUR1MGRjRUxMcXEva2Y1MzZLWVdOcE5yREpBTGRoVlhPbk5xUFpk?=
 =?utf-8?B?WGhmQThJcGloSmtOWjVYTXhVTmtNTTIybW9GNEN0aFBuOE4zRmdqTDVZRThF?=
 =?utf-8?B?RVN5MVd1NGg3QXhIdy85RFZRNzJuZjd6WUlhbFB6UERpeE5Oc3pMSG9WRklW?=
 =?utf-8?B?dVB4TUNQRnRBZXphS2tUMnN1bHJZY09naGNyc0JJMTdSR091WXZYUkszK2w5?=
 =?utf-8?B?MCtsMG84U0FOTlphWmUrd28vUGhIRVBQWHo4UnpaeVhQTnlvY1FobTZTcC9V?=
 =?utf-8?B?VHFxTy9PRE9mcDBnZUZpNElVNGNldmpzNDNXODJva3hJalRBTHgxdlMrSmpk?=
 =?utf-8?B?VFU1Q3oxNU9zcVZwNGlRZlU2dzgxbUNrdnZQcTlzQzRhbXZoOWo2TTJqem9u?=
 =?utf-8?B?MjVUcW45YXBUSUVSWWJ1cS8xc1ZuMHl1bUxTc0V1Q0pmZVIreEZtMUs1NnFh?=
 =?utf-8?B?MGVsc0lNVkxNQi9NQURPdmhyZHBzSTZwNXZjTVU0QUg1cDJyZzZwL3BDTEhJ?=
 =?utf-8?B?SnRUdXE5NGp5L0Z6M2RiL1lLN3dZbThsL2s3TzNKQUFRZzFSemNZUlJmNzIy?=
 =?utf-8?B?ekQxREV6UHVPL0R3NSsvdUVCVlB5TlN1RDJvdFhGSnZSa0V3bU1iT3QxellN?=
 =?utf-8?B?eTI4L0hZV3pzdlkvVDBheUo4Zlh5R3d0dEY4eGJmdmxEclVrSUtHWEJWNGFj?=
 =?utf-8?B?VkRFSGNVRDRGKzBLV3VHbUpoaUNoVVFIcHNHbUU1TXdySk82ZzN6RFNXRndT?=
 =?utf-8?B?MGU5SndNNGFlMUNnRmlOUThFT3ZYMEN6cURoNWlFemczMFRIV1kvVkxSR1RV?=
 =?utf-8?B?ZktEaEQ5SnY0MUFaQ0Y1bVBRdlB1WC8xUGx2eVhERDhFS3Q5a1FXSDJHMUR3?=
 =?utf-8?B?K1RENVlYR2hUWCtvbVlMLzZ4RG1QTi9mWDMwRDNXUnQ1bjBuWDlDYm80ZXZK?=
 =?utf-8?B?YTNiWkRJM0k3V1QvNGFSNlhTZ1dCYWJ3cVFieE5udUpyKzZTVWg4QzVXdmdX?=
 =?utf-8?B?bWMvck9LYlY1K2RaUWZncmJJYUpFKzhSNmRVQWRiVGhhY24vNFdPaVV5YVcr?=
 =?utf-8?B?WGpNcWlJSllUTkNNZ0h6Yng2ekpKd1V0cU9GWVk0SnVWWW9pN1h0dlNtbFlM?=
 =?utf-8?B?MWxLaENmc1ZsbkZqZFVCWnFIWjFBN3E2czBnV29WVWJBbThFTmlPRWRLZ0x4?=
 =?utf-8?B?Q09LUnJOS3ZFcEV6NjBiZDAzdmlmNWF0czhWWmpUeG13QnZQSzh1SHUreEVh?=
 =?utf-8?B?aW5nL2hpUFVHc1F4THdzVFdHQ2ZwMEp4cWdLRHR6VmpQd2Q4YmRMVVFXTzNr?=
 =?utf-8?B?bHVWbXZweVNETStoVlZ0OHF2UTREYmR0Tk5nRXlVaHJER2g1eVRHZ2h1NFhk?=
 =?utf-8?B?YXdMaGRpNTJCbnNZelN3Rk5WTXpCVWlrZHlZVGwwTWhxVlpUMllCcTl4U3Q2?=
 =?utf-8?B?dVAvb2Z1S2JJM1JMdkQvMm8rU3BOWXRWRm0rODlBdnI0dXpva09DZEJqa0M4?=
 =?utf-8?B?MXprVno2VkQxcmdzQ1B1V2VkWHpabmhKMGpiYUpSN0grZ1cvQTNCOXMxczk0?=
 =?utf-8?B?NHhqMUJlakxHanB1UXAyNDlMNUhpNUgxcFNuRnJRN1hWVXNiV0tXZzNXbE03?=
 =?utf-8?B?aXVrYkg1dWxYU25CWWJ1OWVScEhyTTlRcUUveWRKeWd1c1FKWTlza2NUS3By?=
 =?utf-8?B?VDdDV2QwRkdtM0w3UUovSTlaYVhFbUlld2E1cEszWkxsd1NTZENUM1JuWnlz?=
 =?utf-8?B?STh4K3k1QS8xdUVzVXliaWlUZ09vQUZSeFYzS3hTMTJmMGFWRTBrRFptUEpS?=
 =?utf-8?Q?QqE44s038h8XIRbcPYLn43JPD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d11b9af-14cd-4051-05b0-08dc1a6a3962
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 10:17:51.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNXRjse3XlRms8647aDaY1ayYytpYCiaoHKvjVYTbZz0KcT9a07gF2QG8UKUFH9wzhT9BJiOq/DTujDR7PTcHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9203

This patchset is a rework from Oleksii's RFC v5 patchset
https://lore.kernel.org/all/cover.1698353854.git.oleksii_moisieiev@epam.com/

This patchset introduces some changes based on RFC v5:
- introduce helper get_max_msg_size
- support compatible string
- iterate the id_table
- Support multiple configs in one command
- Added i.MX support
- Patch 5 firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
  is almost same as RFCv5 expect multiple configs support.
- Patch 4 the dt-bindings includes compatible string to support i.MX
- Rebased on 2023-12-15 linux-next/master

If any comments from RFC v5 are missed, I am sorry in advance.

This PINCTRL Protocol is following Version 3.2 SCMI Spec Beta release.

On ARM-based systems, a separate Cortex-M based System Control Processor
(SCP) provides control on pins, as well as with power, clocks, reset
controllers. So implement the driver to support such cases.

The i.MX95 Example as below:

Configuration:
The scmi-pinctrl driver can be configured using DT bindings.
For example:
/ {
	sram0: sram@445b1000 {
		compatible = "mmio-sram";
		reg = <0x0 0x445b1000 0x0 0x400>;

		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0x0 0x0 0x445b1000 0x400>;

		scmi_buf0: scmi-sram-section@0 {
			compatible = "arm,scmi-shmem";
			reg = <0x0 0x80>;
		};

		scmi_buf1: scmi-sram-section@80 {
			compatible = "arm,scmi-shmem";
			reg = <0x80 0x80>;
		};
	};

	firmware {
		scmi {
			compatible = "arm,scmi";
			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
			shmem = <&scmi_buf0>, <&scmi_buf1>;
			#address-cells = <1>;
			#size-cells = <0>;

			scmi_iomuxc: protocol@19 {
				compatible = "fsl,imx95-scmi-pinctrl";
				reg = <0x19>;
			};
		};
	};
};

&scmi_iomuxc {
	pinctrl_tpm3: tpm3grp {
		fsl,pins = <
			IMX95_PAD_GPIO_IO12__TPM3_CH2		0x51e
		>;
	};
};

This patchset has been tested on i.MX95-19x19-EVK board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Add R-b for dt-binding patch
- Use 80 chars per line to align with other scmi drivers
- Add pinctrl_scmi_alloc_configs pinctrl_scmi_free_configs to replace
  driver global config_value and config_type array to avoid in parrell
  access issue. When num_configs is larger than 4, use alloc, else use
  stack.
- Drop the separate MAITAINERS entry for firmware scmi pinctrl
- Use enum type, not u8 when referring the scmi or generic pin conf type
- Drop scmi_pinctrl_config_get_all which is not used at all for now.
- Update copyright year to 2024
- Move the enum scmi_pinctrl_conf_type above pinctrl_proto_ops for consistency
- Link to v2: https://lore.kernel.org/r/20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com

Changes in v2:
 Added comments, and added R-b for Patch 1
 Moved the compatile string and i.MX patch to the end, marked NOT APPLY
 Patchset based on lore.kernel.org/all/20231221151129.325749-1-cristian.marussi@arm.com/
 Addressed the binding doc issue, dropped i.MX content.
 For the firmware pinctrl scmi driver, addressed the comments from Cristian
 For the pinctrl scmi driver, addressed comments from Cristian

 For the i.MX95 OEM stuff, I not have good idea, expect using compatbile
 string. Maybe the firmware public an protocol attribute to indicate it is
 VENDOR stuff or NXP use a new protocol id, not 0x19. But I think
 current pinctrl-scmi.c not able to support OEM config, should we extend
 it with some method? Anyway if patch 1-4 is good enough, they could
 be picked up first.

 Since I am only able to test the patch on i.MX95 which not support
 geneirc pinconf, only OEM configs are tested in my side.

---
Oleksii Moisieiev (1):
      firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support

Peng Fan (5):
      firmware: arm_scmi: introduce helper get_max_msg_size
      dt-bindings: firmware: arm,scmi: support pinctrl protocol
      pinctrl: Implementation of the generic scmi-pinctrl driver
      [NOT APPLY]firmware: scmi: support compatible string
      [NOT APPLY] pinctrl: scmi: implement pinctrl_scmi_imx_dt_node_to_map

 .../devicetree/bindings/firmware/arm,scmi.yaml     |  50 ++
 MAINTAINERS                                        |   1 +
 drivers/firmware/arm_scmi/Makefile                 |   1 +
 drivers/firmware/arm_scmi/bus.c                    |  39 +-
 drivers/firmware/arm_scmi/common.h                 |   2 +-
 drivers/firmware/arm_scmi/driver.c                 |  32 +-
 drivers/firmware/arm_scmi/pinctrl.c                | 908 +++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h              |   3 +
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-scmi-imx.c                 | 117 +++
 drivers/pinctrl/pinctrl-scmi.c                     | 609 ++++++++++++++
 drivers/pinctrl/pinctrl-scmi.h                     |  12 +
 include/linux/scmi_protocol.h                      |  77 ++
 14 files changed, 1849 insertions(+), 14 deletions(-)
---
base-commit: 5389a88b06eb19c3fb08200cc1519406e299b7b0
change-id: 20231215-pinctrl-scmi-4c5b0374f4c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


