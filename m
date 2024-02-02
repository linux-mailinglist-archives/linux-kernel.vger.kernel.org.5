Return-Path: <linux-kernel+bounces-49268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D11B84680B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8251C23A37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6106217590;
	Fri,  2 Feb 2024 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kOel0100"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2067.outbound.protection.outlook.com [40.107.241.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D861848;
	Fri,  2 Feb 2024 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706855427; cv=fail; b=sXLb7iD1fJwSMpBEVXsE/D/p9LJESVdQw9uQx93de9W47p3y3CYxkcQ+dYXK0DFs9qW3tuqBFFdXO5sZQTfUit0nWC1aVVnzM3Fu82FrDwSgcm4V4H/ex7FNWm9pN8bGiCIumwgR3VNU4nvFEnmT9FTMlCEKCSkt07Hd2dSC60o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706855427; c=relaxed/simple;
	bh=vvCGtDgsY+4qeEGet1ikEW36XLuJIv5/uBal+Uw4s7k=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=J51HY5n9jSWrTaUzAIZ5fjrC4Y/bwKGuXWRUaLhw9Zo4Q01zyZuTOcrbojkghflh+gd84Q5Ny++aWKuKgPKH5TNFt5Vv34Rlq9adXP4pkmdBaMafcAOKLDxDbLb0R8AYQpjTuvUiZR/MofRwkR0Y3O9nuKgfA83VcR2w+iXXdZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kOel0100; arc=fail smtp.client-ip=40.107.241.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B58gsfxeQmiFEwWFiA8GbydvpW1iy3VT4BF3XkCvHXk79sVJJR155EbHION5ZJFNDIC2jLedpUYrdwClyTggC+cWXBAlHfFlYcy/b7Da40vQCh/0g0wzXp35ronlRDMmWXuG4WgWkOmlz1MYaYY/YaJ2p2l05xkSilpKL7XUB9XVZmTI70Fc6kduUaAI1M+7t85zPKmCtFZTcigEzaVLyHfAfi+UZnTwFse8kaLCYHj7UaJFMPifcpJvAsHya8Gm4XdRzSDYjxIV1TtFjy0OgQt3390LvIDW1WeL02Ey8SjtJb/Tdztyx2FDrOXhAeGLgEXp4sVbV2ctl2WVoGVixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzGZM5OvAhKwCSsGd/Xd5tdNYnQSQvXjFg2pUIwpFsU=;
 b=C2HMINTdgXvy1T8l8Fxzu1jm0FpEM3B6+0iQzptxSRZrUCdfApr00ZrwThfkBvGykBJVjP2/Y98ME5qGnL87ShRFoJu7DRI8jgLmkv1KByZWuAxSvLiIMTRjk4jWy3wgijCezK6WkffleMU4L0f05ABm+0qO0kX7mjoVR12CYH0Y9OeBEq4siecljSMNnWLETIM39SjbEh5LaRFvq9ueHaiGbK4yjfQvj2LI8Gg1n85o3yV/vO6EBSU+KRcfhwMcav/sCi4HIULR0FJaU1lzwEBW0WfbSGcEWPVn3uWwAXla3zQ1RD/WRXz8LWrfljLogRXWbR352dVaK4muMIMlLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzGZM5OvAhKwCSsGd/Xd5tdNYnQSQvXjFg2pUIwpFsU=;
 b=kOel0100+bz2SZMisfsLvOOIuTBrcAboaH/A6YepvGrEKw5VUDtsPp6JDneS49WT2BSZU8UxdSFEfTgaliH6XlHkcgX+UW9UEr7HolfIcdsYzPc4TtvGVCwvBqo49mDt8/Y7k5bx0icP6cHMYfqpP0D4Z5ZdJ/sRixvgAKpX4eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 06:30:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 06:30:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/5] firmware: support i.MX95 SCMI BBM/MISC Extenstion
Date: Fri, 02 Feb 2024 14:34:38 +0800
Message-Id: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP6MvGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIKGbmVthaaqblJSrm5tZnKybYpJoZJ5saGppYWSsBNRUUJSallkBNjA
 6trYWAJtTUk1gAAAA
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706855688; l=1515;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=vvCGtDgsY+4qeEGet1ikEW36XLuJIv5/uBal+Uw4s7k=;
 b=0/oL1MUnOeS9D1he+w1YJqyfK/gY/ua9qJAd/h8GYrdDvfqHQbnGQIR5pj7tyXVYzd5X/1pHZ
 XdAbuXb8we6AUhmkCaSpxhzHbH6NxGW+tQ3g1vzAHk1+S29TfasSxVu
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 4631ac50-327d-40da-3809-08dc23b86dd8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qi9GYjI+8yA2YHv8RINDmXSzAWofYjUsiRR/5bA3RUPLIlMsSYK/TW+4Lg44iuxT/p+/4CTU/fCwBerdZlW4e0FDWXEoh/v56GGIaqiZosPpVKJ5HaU9fiKsyrTmKSTVHMkHlqDYnL3Hb9uTpyvHhi9le8v6TpAN5wT/Oqvw8ukbnU0sNK98QA66Od/ixhXPWdAjC7T2qqHsxAgtddA/naL6vo7c1hPsoYuhsFVpES9ElUvBFPTwQaV6nKo+KpdYv1nnHGMUY6EV1t3mTtI77eW52tOfrbekJ24tHVjEIbiqW78aPlAfpJtVybUtAhz/XwSXdDiAq3MvrwF15cg527AneDDKSLkJbtZ5AYKzPrBOzFFBBEn4d6FYawVkSf2Hc1eF1DNPz0h3/t7GaPEz6RB9udvaGxMAFS2pbgaUOZXFa9O6V6HoySkDPnIllfLVEeMcUV4Z8rtEK8L4pF+/vNThb3gVXKBFjbBGhttCU/spJNgKjmAfdTbxWxaJajcVjmyT7EhkpcIiwCVD8CcWzYVkLmL6f597PPycswcMnnIEa8Eu95XPSyVh4JN0UmW7qyyOSJ6Ys7OCuQrqgnES2vAwmR5W3Ym6oMB+WBaR1rp6dV4bpZb+MUt+1Mjnn9jKU6gfChJSS4eHv1IPQoQqPA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(9686003)(6512007)(6666004)(6506007)(52116002)(8936002)(921011)(4326008)(7416002)(2906002)(5660300002)(316002)(8676002)(66476007)(86362001)(66556008)(66946007)(38350700005)(26005)(36756003)(110136005)(41300700001)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFVYWlZGaXRORHp6eXFaTHc1dmtoOVc3SkpmUlNRQmZWRUw0ZWY5cnNuNDJv?=
 =?utf-8?B?Z2NUdWpCZDNDZzhZdTZzVjBTNDRsOGFYcEFYYmc1SzVYS1dKSVFEZmNBRURL?=
 =?utf-8?B?NTJwbVBZQ09xeUpONEl1L2ZjTW9wRUh1QkhqNXM4QkxnMkMzZjJzOURtRnEr?=
 =?utf-8?B?QTF6NFdQcms4dmJCdzdHWEtWcHNyY0t6ZHBldkU3ZWtZT3Y3d24vTS9nN2Nz?=
 =?utf-8?B?OENSQnhpeHpDK0preWJROXdCOW5nN2MrT3loUTlKdFlwZkRzRStJKzFWNGsx?=
 =?utf-8?B?TFFlamRYVXdYTU9iTXZVUDhUSXIvYVpUNHVKdnlJVks3NWN0RjAraFBUVmdT?=
 =?utf-8?B?V3J3Tjh1TGc0OTdJR01SZUFrZ0h6aTNJYzJIamxCNmZTekUzdjU2NUs1Tmc1?=
 =?utf-8?B?cEwxdnZzWjA5ajJWNmNEVzFCMDErZCs4T3MvcEx2dm02ejhPNit0ZWZGQ0p1?=
 =?utf-8?B?dEdwUmlxdTJML0dmSnVsOFpwZHJ4VDhzRUxUSnJEVHdlYWdOTGRDeXgvSU9X?=
 =?utf-8?B?V3B6NENWMU4wSThjWjZHd3d2T3FKMmMweUV0TzdBOHV4bVhjUjFrSFBhL01E?=
 =?utf-8?B?TytSRDlYSW8yb1VXTVhUb2J1SDh0cFN2dGJMbWh3OWd2Nkw4dHZOekRDMUhS?=
 =?utf-8?B?SlVMNkNybjQxWmZQR3c3dVQrMHkwbUZRVXlRYnJaMVhhZyt6RWg4dzBaY0Fk?=
 =?utf-8?B?R2t4b0l3WkFGRW82UE1vM1FxMVNpelhmSUlJOHluY0RYUDNOQjhoZ00yY0Zq?=
 =?utf-8?B?amQyUURvQU82THdzSjBjbmVSWlEraXFpZ3J5OHBUazJGcXZKdWhkK2pubUFF?=
 =?utf-8?B?VnV1MkE3ZFlKcnluWWh6N1U1Qld0Ym1xellXRXFBT2ZEVmFQVFE4UmdEWVRt?=
 =?utf-8?B?WitkdUhSM1VsdHQ0M2tjMWM3MStvdFhCcVRBcG9STis1a3RPSkZ5Sk5mQmVQ?=
 =?utf-8?B?UDBWRExkZGh2WllqOW9peWoxQzRPQWlGS1pEUWJGYkFpWk5iWXQxV3NXakVO?=
 =?utf-8?B?L1hxcDJkSkRHSzFjVk50YldWdGgrSmR1ZDhlb2RuNEhsdFJRSXN1ZWNUR3J0?=
 =?utf-8?B?MUN5a0ljRndRSFhva0t1Tkp0aXJkaVpjRVpYa2UyUTY5OXorR2VKaUVxYWIz?=
 =?utf-8?B?MUp5d0JBR01DWm9wTllyZWZ4UzBsNVJwZVV0QWRLVmh2bThncHd3NVdwWEpw?=
 =?utf-8?B?NW1Lc3R6bm5VUFpQdU5LTEpaelo2bm9WWnUyU0YwSTdsNWJpeHVvMTFCTzlm?=
 =?utf-8?B?QTZXZmNqNlFWUlQ5UG9UblVMTHRlaVZsdTYxM0Vaa1FqVHM2YWFYeDA4anVZ?=
 =?utf-8?B?aE5HQ2F3YlhkV1Fib1pIUFpma0hlOWRCUEJtL3l3QTlDT09UaGFVZERpUEJy?=
 =?utf-8?B?akFITkQySkgxQVpCRlZ3akYxdFlNdjFKbmg3QXMzYWl2NTVjT3Q5WTZ2ZGZ1?=
 =?utf-8?B?VEtlZDUxcm1vdE1pM0ZYZFlDcVBZd3IxNHI5aDJyckUxOVBjSnFoK0lyOG1o?=
 =?utf-8?B?SXR0QUp5Zy9hQjJYNW9RRTJuaEZQcGlvZGRFR3B3L0Z0Z3hOamxUZFJOTTN2?=
 =?utf-8?B?R0kwN2pvQnl5WWU2eHI0OFVpb1F2Rzh6aldKbFR6WTRFVzVLZG1qVzFkZlBT?=
 =?utf-8?B?RVlQVm1CSi9oUnpZeklNSmJ0Szd5elBDQUo2ODhpblQ4MnRqQVo4OWljSzJH?=
 =?utf-8?B?U00ycW5nQ1hwTHM0QkdMYnNUd3piRkc1NmFzM3Y3OEVGNDZ4bUNFSFBESU5l?=
 =?utf-8?B?SUZUT0M3cWtPK3BKZlUxZkVkYU9ucSs4Z3BEN3ZsZWl0ZUgwMzBLRHBzRkRE?=
 =?utf-8?B?amQ4QjNlaytPenBScTVrQkdYVEZBM1lOeWs5cUtHOXdiVkQwaDgwS2p2NUdE?=
 =?utf-8?B?RFUwdVB5WVZjai96cW5CK2ZDd3hFVjZuOGNLaW1FdEFDRDBGOWk4TzgyRW0y?=
 =?utf-8?B?Y2hqV1NVNjVVeEwvRmRUVGRXcWFZNlhRd3R2Q0c2R3VvRDlsVGFYTnU5cVR5?=
 =?utf-8?B?MmFNR1NmM25EN3d1Qll0aVRsV0RoNWZqNGtseGZYa0QwWVpzcXp6L2Z2ZVFQ?=
 =?utf-8?B?MjU5ajFxZE5IMHhOVEdQM0FuZVZBRHlwczlUU0dSc3Nsb3BzMk1Dc2FwOU1n?=
 =?utf-8?Q?C5BBu1rDwVC+bMWqNX2djY11w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4631ac50-327d-40da-3809-08dc23b86dd8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 06:30:20.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtM3eMPuxf6ZF8ZWlesv6mre7kdGhpFkE28KdR88twu30ybnnICBhsTgiRX5SwdvmHslv/MIboBksH4UT3R2aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8604

i.MX95 System Manager Firmware support vendor extension protocol:
- BBM Protocol for RTC and BUTTON feature.
- MISC Protocol for misc settings, such as BLK CTRL GPR settings, GPIO
expander settings.

This patchset is to support the two protocols and users that use the
protocols.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (5):
      dt-bindings: firmware: add i.MX SCMI Extension protocol
      firmware: arm_scmi: add initial support for i.MX BBM protocol
      firmware: arm_scmi: add initial support for i.MX MISC protocol
      firmware: imx: support BBM module
      firmware: imx: add i.MX95 MISC driver

 .../devicetree/bindings/firmware/nxp,scmi.yaml     |  64 ++++
 drivers/firmware/arm_scmi/Kconfig                  |  20 ++
 drivers/firmware/arm_scmi/Makefile                 |   2 +
 drivers/firmware/arm_scmi/imx-sm-bbm.c             | 381 +++++++++++++++++++++
 drivers/firmware/arm_scmi/imx-sm-misc.c            | 289 ++++++++++++++++
 drivers/firmware/imx/Makefile                      |   2 +
 drivers/firmware/imx/sm-bbm.c                      | 317 +++++++++++++++++
 drivers/firmware/imx/sm-misc.c                     |  92 +++++
 include/linux/firmware/imx/sm.h                    |  33 ++
 include/linux/scmi_nxp_protocol.h                  |  67 ++++
 10 files changed, 1267 insertions(+)
---
base-commit: 51b70ff55ed88edd19b080a524063446bcc34b62
change-id: 20240202-imx95-bbm-misc-d4a27c159823

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


