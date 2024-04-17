Return-Path: <linux-kernel+bounces-147876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CF88A7ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFAE2835A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9189779E0;
	Wed, 17 Apr 2024 03:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rz86kyV8"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2081.outbound.protection.outlook.com [40.107.249.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3297470;
	Wed, 17 Apr 2024 03:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323236; cv=fail; b=do2Wvs3bZZHXPTZ3qLAZDRpjEoX4fr3MBMX7V8M4eiAFrjiP0KAchVcqW4QyGdHC7DFkWvngSyJncUhIBn598DfwEUg4FIBho+ELICKe4w1niGY+Tqf9ShavbNnyjINuZJOvl+v5ba42iFrxSX4vm5EgElHCXrJTBKslChSv/X0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323236; c=relaxed/simple;
	bh=oWmIZERJzu+7jV8XHxIy1v2CzqA2LRG+t0busAJrch0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SIKfbhOuXKyHTIzhiZUo2oxujc9BNsMTLXwWoJq7LUC2OnJxGcELqQ//3HrqNYO+BFw04hymhW6TdhNSPlYiaLpIW50Te0Gne5eajMZ1L5V6RgYQSikmyXoG+t0Xvk3h8LO6/WvLJe5CTenGRLSXXdIy7i8+IgOC8MmsqfzbgFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rz86kyV8; arc=fail smtp.client-ip=40.107.249.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lD046HbeznGd9W4xdjiOZXt17OV5EXCJEijue9dM8l+QSO4XqeIGA25ZH/61+moe25kULfYlPfyV5pcCsqFXLVG+lJ3+mhx8IOGEehquvfyDINBO/xcFw2sfddisVhFlNg+mwK1BBVAM/aNi/OcceRmknVceXh2b8kkX8zcOb0EQNLAdcavS4KWgF0BruJILFSFeXxyCWWlTbh5C7cpL5HNTcZ6vighuAM4mIpwgGoFRlmx0Uqi4UTtKS5F01EZ5ul6IiVeNZKqwCbRIbpbZMTkbFe6Ra6FZF7nKUiSmMgm5/ceFM5LiGHCEPR0CJYOboKP77GqS0HM3M6LbI9pncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9ghx55F2OHxFSJQhOzvypfCz61hkQNVngQuoC5On2A=;
 b=Iwlue0zTmlwFZXQH/uoZIykOLvjWkJXPj38HeEiSYp0slq3scHW9CgtnnT/evScdeHPNZYVQPj7AKOp/gizQ2TzTV+ww+FQdM3M09UHtzbi9MWowRhUG8QgWES/R7V0LUY4tI0DUTO5k7XoGexb0IsCepH/6L/C0CFXk3JyGMQU87ZcM8FulE+TNiS5DHKCrk/ks8lehOIlXfnT5bBMuIh8jhx5cO+hpDkY2HKi3dqPnr9rvcb+Zd1zBdKHt+f5RLc8fSANURnps8teQNKIp5xYkeRgRkn085d7CCrjMiOd8uGeAvN6Fb6E/Lv+MoGsPf/Sn6ckTKilyAFM0cUFaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9ghx55F2OHxFSJQhOzvypfCz61hkQNVngQuoC5On2A=;
 b=Rz86kyV8Ulpg1n/vaNNhbVx9Ig1ZOs78GFDi6q1OBGISDkP3bxAos3HCPuEaTmyEVedOVsXNLfKN2RK5vW9JnnSbqFqH2qEiY3cZbni5EhrMTXpX8I2Z8kYuBOytTFuQrZgt375fweKQssvyzIGdUWWGlRAr8pDmdsukrxK2Lk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DU0PR04MB9321.eurprd04.prod.outlook.com (2603:10a6:10:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 03:07:11 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 03:07:11 +0000
From: Joy Zou <joy.zou@nxp.com>
To: m.felsch@pengutronix.de,
	frank.li@nxp.com,
	ping.bai@nxp.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] Add rtc PCF2131 support
Date: Wed, 17 Apr 2024 11:14:54 +0800
Message-Id: <20240417031455.3177778-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0221.apcprd06.prod.outlook.com
 (2603:1096:4:68::29) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DU0PR04MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b941e9f-9bb8-4612-4def-08dc5e8b7979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hmM4l1yBUAE0zkBuIl05C5V2BthQLzEvPWwyePikZV+k1t084mNLMqGwQca9sWdvGUGZI6NHZh0bzXSE7H3ckvA1y9H6e8ZKGbv3WQ4Sg49Om9jAPskN8VUOyyjsU+IhwigI5WyBkstFJG6WJqGSKh90N7sh0wqWC1UK5NrpRQX767FUKcdjIK47H74hBg9695AEB5Bml9fszYxjWE5PvbLf1t7/oo8mXYOz65WaWly8JHpNC7Df/Z46tJFDMHJ6d+ZtIwYEUPM+0BooXUZMBcs4IGQFOTIkk852UZWPAFL+rLRXoqtIlelH7BICpdZmgWhME88k+9m1NjE+e72Tw8IL6hpJL4ifxgsxzfvsQUUtJnZLVTVBOmZphxTSxN7sOuCVsJAK3G6GROlIo5yo+jACQSD5Nw7vb7Iws9DecVFfdFsKOQvMZytPnLEoTPo+w3kMzJSEeKpWZEsfgMEJclJ9FTvXK+3bGbklMOVB5qjED4UoC7ng5KQ/bPVLwDmLsb2tLOX9G/w0r0NjCNoj0E6hGcsK3ETk685w1xZ2LWiS362fqvaYYOFuJlMj3rgZbsjLqoNNNs+56wTwvWdhooPXgrJAtpTO9kbNILssAGZYYVzlV27GqyBsh50drBTo0LA2NfWEyz2Q+XbypqO3TWUVuHBeUIAhn1KOHngtYgub7dZZ/Kj83jqumRG5qQK/ASCAwS+0kTXssA2QmID+u/J3OZX6FEV7oc3KRBxaynM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6/E3Wvuz8a/5KyWkSFarRHcwRjjKR7R6jpOxDgbjLum/z/o9t8AO3W0xF567?=
 =?us-ascii?Q?monCvf+3dLjqIrSIyBIohnHUKLcUjYTv8f+98SOdw/3iBG3MDGOnVc1UiQ8s?=
 =?us-ascii?Q?sl6aUD5npkLpnc5Chfi57HKGIm7KeKiapwizEgFXxa36YJNytPerZlJQZ7Xc?=
 =?us-ascii?Q?z2WaGtMtDXU1wRUILjLvbKr8wMKRLIgWAa5aGafr4GHOJbQrJqWbeyEdlWmy?=
 =?us-ascii?Q?hmtCsq+YYySN6RUIceH2yDQ/OarfYGjk/9dxB7SAillVVaW5gRTvTVqQF0dl?=
 =?us-ascii?Q?8AKmTetnZ05udAiidGxq4EBe1TIt6LPtm7oVXRdZF8/bE/rrqFYie60dNZcK?=
 =?us-ascii?Q?oIt6fmGI0qUSoeQ30AZc/PhOztVJmGNZkz9ec4R3p4dCQiQFbr8qCx/AHOA1?=
 =?us-ascii?Q?nlHzIBYal0liIJcAf4qv0phCFRc1unX0Hr/xS9fnNAiwYy5Z8mZgFMYlo5oN?=
 =?us-ascii?Q?2COf8IU5SQBZDywDnMVLfaQmwfLOVRb0jFw0V03SQHZU6KEKHcHbYo11y9g7?=
 =?us-ascii?Q?nfF+gdcRyy0BpbBdSw+ur8GXGFRRCTHoS1eOwnNZs2LrnrSXnehEstJeVmgY?=
 =?us-ascii?Q?tMY8eBzhh++8O62C3+xBvmhbBoIL3GjnvZ1jozh2vNU62Gu+HD1TH0rcnhnZ?=
 =?us-ascii?Q?HwJlebpp0rsrVEh5czRcrJW5RnCZy404FDhEvwh2oMH9b/kSMGYOUg+QJmK5?=
 =?us-ascii?Q?Mq1YZnEIBa63sCzjIl3NXqB4+75rs7Mftnp1wfjsWddayilJ+7LvfgJNIjN5?=
 =?us-ascii?Q?ndqE50s+fTmPJ3inoFKKO7uH6Tx3JQMl7NCcQRMbP4TsHNa39NaV//oIbB2A?=
 =?us-ascii?Q?mwEgZjN29yj31ki2EcmNxpXmnuXC59i/QcvP/hFAfLwXO57gPUfvz14a3fAp?=
 =?us-ascii?Q?xkItB0OfY1ZfRCswyaop+Wf2Xt4VzLIc2j5LnOI8mBUv9fjIDW6qHws2fF0X?=
 =?us-ascii?Q?ITF20o+/qyZs0dSAMP1uFMGHzAGMwYZ7CtNvnO0jRdY3EU5vKWYr4a/62eNu?=
 =?us-ascii?Q?4kic02SRXVrtoI/leV2PBO5nqHo4TF8uMSLjxwyIGVGKbayqH2bZt2CQ53FQ?=
 =?us-ascii?Q?c/nYVJbrQIls019E5bIZUM3cMKnfNB30eWjwg1k/IHQhxyd50NLGZ+f0iy1x?=
 =?us-ascii?Q?WMLjeIioU6TzvNF2GdVYKTPEBFWGmnrUoz40CU1OAlQ9tODJQjn3KOhZWFDw?=
 =?us-ascii?Q?ibDyDqKD5LGKcFx/DuTPK9h4z1MQ+Z1U76ykIbVobF3/JsfzKPk6kEh9k49s?=
 =?us-ascii?Q?Ig9VvilzG5a2CEuYguzTPUb+pk2sZmhunBNc8U9It8gUWupiJ34lUPXq5ha8?=
 =?us-ascii?Q?rZLx3M0+oaSXORxg/hbnVMa0y9J+fzYDl7gsq/ODYQ0UPllJub6MjXrskw9q?=
 =?us-ascii?Q?GbWgSb1Ncc6p0D/8FIHETiLnPcYSdMXBkfBJOxhRzL3NKW4gvleYQsC6ihNj?=
 =?us-ascii?Q?IYnMq7z1kWncbT7s1p2DmYoPNOwpIbOPKIYggNsfbIQE975t+trVtjt7dTB9?=
 =?us-ascii?Q?+QP4/eShJQ3uYzN3BjoERuwi7cE17tCOsPh2pHHJOB3KTLpJ8keOw3E/IyZK?=
 =?us-ascii?Q?I+MGvuPDrOw/NF88H013dvOK/4i+bblaKQD7pmFI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b941e9f-9bb8-4612-4def-08dc5e8b7979
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 03:07:11.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtYvrX6zq7z+6Cl7yUVySIWHJMqIoGYYYB4U9t7NeNRTTpBgcuPw/GkaVSjPEWcA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9321

The patchset supports RTC PCF2131 on board dts.
For the details, please check the patch commit log.

Joy Zou (1):
  arm64: dts: imx93-11x11-evk: add rtc PCF2131 support

 .../boot/dts/freescale/imx93-11x11-evk.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
2.37.1


