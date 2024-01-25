Return-Path: <linux-kernel+bounces-38475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B533083C070
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF8D1F257E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF145917D;
	Thu, 25 Jan 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F5h1IxHV"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF85D90A;
	Thu, 25 Jan 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180738; cv=fail; b=mn11JGJNj0ShNKYJ0rs1lGh+ufwiR154PgOALw6PjuKqJ5kisTjioF+pVVQ06oeZcKo+MsNmehLprV3mS4yOH5cGTTKh4US8BguQ75HdtIIjEh1PmqnblnMYP3Dkq27R+FPKsp/yFJ52qfX2wn0AJhgIwqzZlc7mIgXZR4y/MSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180738; c=relaxed/simple;
	bh=Pm3VOp9lyPcsQTfFUS61v7QXjT8AQbUIGk6tZpwkcPg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=a5Bj13fFD/BkSac/Oqrv71f8tsu+SiYEHrmb32zWZvrBNeO0f/+vpyzYyCYlEKEjNo3gHZ0wD3KpUkldLWcyRcre5jr8+LyeepiVZB0+T0JLVy3RQuTQpyXHBlFIseH5e83Y5BoViOxc227M7bkQKP+AFeLqQaKCI3rz7jyyIPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=F5h1IxHV; arc=fail smtp.client-ip=40.107.249.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeBTFVuNSz3abC+Wa8e6Ezhf0idO0k8iD2WEwDC4WYqFaM20Igssh9nkDIkgFa4n0CB4Md8fpNiBHNfTr7qkpxmthfBU9/59xMUw7mjsp3299wXPlZC3H7pln+SiCWXH9TZJizyjESAkF9xWnW3qb1aK4V6kBE22LlX3AghTx/06yKuopT9OaGj+0zLlOr+DzJHDl349hr34BodiAPO1HPouz6Lx2vp+vQ5esymIz8bIHUZ3YV+jqfBTXbyrRAoecWZkBNynBshwIxLP5MuaTk1rgN2DoevgdmBgdCptGLnsXGzQYX7KVgj0ocZGc6rm5Hfj4cxMyfUiEP2XcEfbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CBTVlcAkdfZaToFcna87lP180DfxyrqcFF3ZfdJw40=;
 b=cG4ALy3eKIvNjVPX6/kWwtDgDzfmm6Zo5I2zLFfnbxKcchnJFI2OzKF6SswkPCufo6HJjNUV0qwgPh4mkttzgDV3F7HLCnlWW4gfz6Y2uEl8NtEQFWoclUGJmTBFJ/ggw4GndauBFTmBB5DKbMcxcm4dQ7dZ4M20AmW8uuVOaKU6k3vK8Xkwh4tzCAouA0+GbWs91jc0uLf9p0CVdVoRBvJxXXdzE/YIfODH7D8LrhRZqvxAnNwdr4o/b9v2oGFADtYpmJ1aNgx6AT8T8Zu9SfMnuK4iU5OMWsJJ+26sjz5wGe1EwODLCD/QQW687Yx1WDgtYprevFvRYQYycAXHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CBTVlcAkdfZaToFcna87lP180DfxyrqcFF3ZfdJw40=;
 b=F5h1IxHV3es9MzjwT0q/9B1AMQp1LqZdXh+IT6V6xmKfO/fbHFZsQb6JBw14bgsfKZXP0DK5Uwn2he4b2e3kYHLqg4fKQLOuzFYHJCc8AWllGrAl8CIpcW3XBjA6Rtd8a0iwbSd8J17ywFgOGEZhhq9sWoFl6yKsi6symhpdspw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 11:05:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 11:05:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/3] clocksource: imx-sysctr: support i.MX95
Date: Thu, 25 Jan 2024 19:09:46 +0800
Message-Id: <20240125-imx-sysctr-v2-0-7332470cd7ae@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHpBsmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxMDQyNT3czcCt3iyuLkkiJd40QLy0QDC1MjY3MzJaCGgqLUtMwKsGHRsbW
 1ANDwrYtcAAAA
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bai Ping <ping.bai@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706180999; l=982;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Pm3VOp9lyPcsQTfFUS61v7QXjT8AQbUIGk6tZpwkcPg=;
 b=SDFpWiU8VvwUEzWiS9tl0HAe2uFkoWnQjdFK5gQWXDNc04vjMy9kg7Kvt5QH46qTVdSJDcluK
 2pNQFu0w66GBwJgYfj72zG2GqWCJBPaEswsli+G9140n2WtfKy8r3ZO
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3d0bfb-1699-47fb-90cd-08dc1d958b8d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WfnoXr7xP3XUpthbQETq9WGfgAH8V7BT9RiX/MVYmfqAXUlmjn2MuCJjicA+epCKZTO8LRSDC8EN3fKNn/NdliDkwNlQxH9z12/ScHAN5F9Ys5LVebDyEn33NSo0MGmm43MHOFDES3j5RJXMCNCQ5Z0MiA46HP8V+3v6I7P0rLqTyDjdtehw9bV03LkM/DGvXu1hfqWlEpRWDB3Am65Zj9cPAdOPYc4q+c/zLu+nbRiG3zwY1lU9FswROq3H/p/1seY8v4zCEu8XciAQo+HrQp0L6GDpdKcbSSMX6BkwssT+c04nuAlpqRJgowkHLeJQQ6673yvEaqjREoDkyhvVH+t5PA3yc+J4EnY1jnk7dtKjLPyZmVsrXzsNaJ9rcTBkMtHb59A2zD66pv2lpYcbM+7xuHu2j7kgMO9nDCfTQr4DmqbrjWTEjw1oUAv90YZbfv/s0Hj/TTFQbEs1+7CCTOOqGGFFW+1+hjMJg0h5aubUD/JxbFF/qa7eVQVsx92GPxB7fHaKZqI7pgq4neN334WnJUlyybEg1jz8Oc2U3z5Iy2TArcwp7iDCHQn7/xKV3N6f354KHcNLKXYnE9O81J3EaKc+GBSWXE10HNLhxVnGtyx+m06Oaa/g/bRmQbCFPx1zdh+7Q9ISpWZndxs1Yw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(2906002)(4744005)(8936002)(110136005)(7416002)(66476007)(8676002)(5660300002)(66946007)(83380400001)(26005)(38350700005)(86362001)(36756003)(66556008)(316002)(921011)(52116002)(6486002)(9686003)(6512007)(6506007)(478600001)(6666004)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1FhUHpYWEtNQ0VYU3RxR1BPa1JaZ3Y0bUZhRkwvZGpwSzBTV3Arc1BqUXN2?=
 =?utf-8?B?M28yYkVaVmorZlRNVWE1d2dnWnY4aXl0NkNia0oxck1qMko2OFAyU2k0V1Bu?=
 =?utf-8?B?WTBnckxzTmoyaXNBL21OWTlidlhXaFFFd09mOFRIN1YrdzMzYUIvWTdZU29R?=
 =?utf-8?B?NEwyaHZabzF1dHBvYnQ1eFptTHRrVnJ5T01xYUZGMVZUZlZLWUwzaDZZdm9J?=
 =?utf-8?B?bVk1T05Rb3RoQ1J4cHptek9sNnJrQkltZ1ZzRTMyeFRWSkkxYy9mRU1DMHIr?=
 =?utf-8?B?Zy9OMzVoSjhOK05UazBhN1dDSTFEZFE0UHFlRDYwbUV1VXA5NXAzTWJIT3pU?=
 =?utf-8?B?TlFUOEJibzhsUENBQlIzRmJ3RVNVZXdUdG9QeldkaXd5RmFRdi85dzVQWUoz?=
 =?utf-8?B?R0NNZGp5Um84bVR6RmRtcnBTTHJpQjhCWG12UE0xeVBtVEFqazVWL2xRQlU3?=
 =?utf-8?B?V0dJV2UrSE8wUGZ2NDRFWHhhR2FPUWEvejVYVUpKWkJpRzRxVmFJWGxoTVJX?=
 =?utf-8?B?WkNyN1JNMjhCTUo0Z1E4QnQrSFIyZ1lUdU5TeGxSb1VyOFVsanEzTTlDVjhK?=
 =?utf-8?B?d1hiUGFLOFZweDYyNlFkYTRBbDNZei8wUWVOWFBuTkVNTXU5MTZpVUtReFJF?=
 =?utf-8?B?c05QWVpFOTdYbi9PQU1kUzlVWmJkeVVIM0VjZFNreWl5SU93R2YyeWNIekZq?=
 =?utf-8?B?TGgyaGJ0UzEzcnFQRjB5OERtdXFjSnNHVHhid0NQUUd1Y3FpSFhUOWgxNVdJ?=
 =?utf-8?B?bkpUZU9DMWJpTTh3b3pySFpCTE8wb0JNSmRaYkpFM0FBMUNIQ3ZHd1hXL1Jo?=
 =?utf-8?B?L2RmN3hlNjloVkR0NTVzVE9GbU9NYmpjOGN3L0lLbzkwMjVqbDVaN2ZHeTBT?=
 =?utf-8?B?T1ZNVW1LTG1vR3pvWXZPSWVPdFBZcUNXUUtZK2o2Nzkrd0ZsekMyRE8vM0lw?=
 =?utf-8?B?a1dMYVNYUEErNnQrM1h2Mm1WaVhlOVZjdmxpVGZYZVI5cVdGWXVsUkd3cUNl?=
 =?utf-8?B?NjNkWVZBNUliTnZvNUNBZnpsY2FyS1d3VE56Y0xhQ1htNUVoa1VJSDk2QUIy?=
 =?utf-8?B?NmpEZ0toTEZQSHJndEcraUQ5SXRlWktQdjdDZGpwR3grUWFIdkoyempzWjFI?=
 =?utf-8?B?cGk3dzhzODl4b0h0UEFDUjlXOWlWUWlIbDNQa1JvdFRQNTNnWWRwdS9BbUIy?=
 =?utf-8?B?TmJEUy83TGhMTVRaS3RmTmRhdXNTSDFqbFF0MVFxNGVXUHNYQTBueTdPaFdE?=
 =?utf-8?B?V3FEbHdoV0NDbmlXSnpMTFcrTHJXMk1sRmxtS1pselpHRUVJREtLdFo3Witi?=
 =?utf-8?B?dkVDdnh2dUFRWDdPOFNQZVB1Z1p3MzltUUF4WjdoUjhyN2l4alg1SEVyaG5O?=
 =?utf-8?B?TUpVeXlUQldEMWE2SnJ2ZmkzMWlqeTBhMEhjWEZDUnorYkxIUWZkTldVTzhl?=
 =?utf-8?B?ZXFxTXFpbjdweHFnL01DMTRaaW9WVTRsWVVqVWw4K0NHUHRmSnlsNHFTU2ky?=
 =?utf-8?B?UWJMZnltaEpocWZqcnNsUHlQTm1MVUZwWk9kK3FwdGo0V3pQa2YzTGFzSWVv?=
 =?utf-8?B?NWsxNEE0SlZFMXVvbkY5QldGZVBhVXd5T2pIcUJ3YWw3S3poMm1jcGNpRXNi?=
 =?utf-8?B?MXRHQWs4ekJReW00dkdrK3pYNllleVJON29BcUhPcWhCS2xKRmNVS0I4U3Iv?=
 =?utf-8?B?UWE1aFFKdU93S0t2QnBLOVdUV0h2cDZmWjFFNXp0ZjdnRzArK0pYRVNhdjFt?=
 =?utf-8?B?ckNnNGlFN0hYTVNpL1oyQ01OT0pGZlgreFhnek1nOFN2alpTN2VTcTB0WXFK?=
 =?utf-8?B?VU9HRDVhbUVUdGRmUGUxZFRzcFFYTTlkMkQzSExuYmZHd3RtcFdFcHNUeHUw?=
 =?utf-8?B?UEw4bXNib0tUOE1tMkJyU1lHemNrK3crREhPcldZU2crUFhnOUJCVWZ2c05U?=
 =?utf-8?B?WGhRMTEzaXhOSHQrRHZveUVKdUhVdjFBZjk0emZHR3RvR2tNWUV0NkR5TVV4?=
 =?utf-8?B?U2wyUVJ6ZE0zemE5a1NteUlYUms0Y1p5RldJN2ROaWF1YTczNHNSNFBBSXE0?=
 =?utf-8?B?NDVpUGMvb3ExOVNLRTNkVnNZaHk0TWJHcEI1emo4Wml0SmUyV0JGc2NDUTI2?=
 =?utf-8?Q?MkNP3qqTSxt3W+Vi7jM32juHa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3d0bfb-1699-47fb-90cd-08dc1d958b8d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 11:05:32.0881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: As/pjjEVKpUijbVfwsI3z7el1vQfF7Ox7ESVKxvJmiBfqU0wkzMyJkvv2a33/715YsGZITlbrmXWF57rYZWxrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013

i.MX95 System Counter module control register space is blocked
by SCMI firmware, so we use Read Register space to get the counter.

V2:
  - imx95 is not compatible with the existing hardware, so add a
    seperate entry for i.MX95 in dt-binding.
  - Per Marco's comments, the global variables was removed except
    to_sysctr. And add a new TIMER_OF_DECLARE entry for i.MX95

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      dt-bindings: timer: nxp,sysctr-timer: support i.MX95
      clocksource/drivers/imx-sysctr: drop use global variables
      clocksource/drivers/imx-sysctr: support i.MX95

 .../bindings/timer/nxp,sysctr-timer.yaml           |   5 +-
 drivers/clocksource/timer-imx-sysctr.c             | 116 +++++++++++++++------
 2 files changed, 90 insertions(+), 31 deletions(-)
---
base-commit: 01af33cc9894b4489fb68fa35c40e9fe85df63dc
change-id: 20240125-imx-sysctr-3a89a0852376

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


