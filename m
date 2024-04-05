Return-Path: <linux-kernel+bounces-132994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A81899D03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A69C1C21CEE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED2816D9BC;
	Fri,  5 Apr 2024 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eGAlBXxa"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2134.outbound.protection.outlook.com [40.107.20.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78D16D9B2;
	Fri,  5 Apr 2024 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320325; cv=fail; b=LulOnQ0Drur6p0GM+XajoIu1aT5U/Ov9lMBfUHe2UQ5RkEWNCyg67mgci6O5VTj3urpxsQiAwSFcH8GIfbiEVt0Vr/hZFDyrKCHSufYp7yO8HczeZRt4hAMlEaSIIzwslRcvYKGyot5LcPb2zxBUjUCkv/aJseqicQcFTaItFys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320325; c=relaxed/simple;
	bh=7eShSB1HQebkY20sqLbYKFiD+32vvCrnjG0Yj35mBes=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jTl54L5I/NA6jjrDndbmcMxR5Bvgrs7rTPe66fca0FspxUIRsxiUX+h+9g1iEja5sY5D2y83G5sAIivnCzXtHJ2w6PhJkkGFmZ239fUDBb99AHOBPR/zz2VDpdwdj5BW1ZL12tFvIAyf8Jj12pU6O2H5TeIfIWPBz40gz+Cqq6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eGAlBXxa; arc=fail smtp.client-ip=40.107.20.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0Rsh2sFCNn+kGYoD/xQOdfVfvRi+hzYGQhonil0K/tfXMIL6cWpWyxv793NbMd1ZRxMP+wKah901cIyJgIF95wGZ7II2RuMWSe3uCqA9YWIaEt8tmg73bnN/CbxUFkrTIvC+u8gezrH7uynzZ2HtIcOtfZCo0gcUdFKwu+9pmSdUgT2n0ABGIVszVXVmrHRzAPzRHHNOQWsB39b0sHWCJdp5I6TgDZLy5EHanjE8jw5eH9XZ3I/1s2wFd8JJSmsAhVQYd1tx7okA1ZDPZ+08ZmDS3OCciLfNS9ryR2uG6hTxq3hJIbHwSINYR8AhUHpevSTXpNnGq7FdqyVysshqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4bWUdJk5TwFdQWhDrGyBda9rTGBzN47VQeiZ7m4qmY=;
 b=Oe5KzaaqCTWyJW7ALbziGbVX9UbPWulSTEfR7eNEwdFseMvoPMsmVZu/UuO9sz1RSFrP/dsEMcP7bvkgjNQHVrMODJCpqRD8YHokg/vWewIe3EE0DWUCe/9NBjmQlto9v53lpLdRPrLUSl+YSnHQKS5bpQ/axLh5OsYP/6iaoxshfVsOApATA7/K4C++nXQF/Nk1sSXhe8XB56tbvG0tS/91ob+SDo2ZTeBtXuZj0tujfnWL4gKlZXM8WyMB+pUbg1Y9Gn3hJkUGYUUpNxdCH8KZJt4k8q7LH4u+qEKqg6uVB4ilWOfMezUKdXVRqmIk5ohVJT2VO8yy/l7A81SFgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4bWUdJk5TwFdQWhDrGyBda9rTGBzN47VQeiZ7m4qmY=;
 b=eGAlBXxakJTTEAseIInWgaE1Cti1zVKWg8OeaDzxCk5bxGupaPZpY1oHECFQgSm4e2FgiFnK7EUAGDh1FUJkoVMNBPnxEFfPpKyZmZERw3YAHNdPSkGAKIBevBrFIEvR8d+OfRSLFMCtx8hpaR8OvulUHnILa4D6LvZmplON97k=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7744.eurprd04.prod.outlook.com (2603:10a6:102:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 12:31:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 5 Apr 2024
 12:31:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 05 Apr 2024 20:39:27 +0800
Subject: [PATCH v2 5/6] firmware: imx: support BBM module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-imx95-bbm-misc-v2-v2-5-9fc9186856c2@nxp.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
In-Reply-To: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712320792; l=9360;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Qe4YMjymxAKRop7ehNWBHg5FvDm2cdcwGYpisnkYZ7c=;
 b=vSs53BV829LpJWQKScfmmL9pJgwsMqB1/M3m8ulRx6xnuB5VcnoEk+DInb/iW612o1OfN7pg3
 M46V5VlNxyFBXjSGNXE9eW6Ai9u56TtraQ/JwlTVBs9rcG42Q3zliqZ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7744:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fh2cytYS+ppVx9mEe9IGbA95p7V9lQ2mzOzOc7//C8vJPK02XrTne3z3eEWeKUi7SEHElTmIPt2L1/oheKv+OK637xjvjxGZ1JJw94ScSCjyzYiXKjj90gfUtV5ooe42bBcda8JT6B6jM2etFYq0pGydy31y0fI+aenDZ0Tq8bgvlpVurLJQSRMWuqRpsyMDkFdZJpsFKjgSUURwcm8TEB44ANgNZ6p/lvxqktNbKk++DmdFhcO0pJVdCyQCEm72vdz3ihIxjfnvD8JkhQ/YGksPF8+U1CtVftV7MdQvoOfNtvBeIrRU/xmuqjBa9piF/uo3+PQWt2zBJ0xsOTYa//flx8olQqd9iNzx+Rx3ALgFlQGpP/9UPtABCQ9lrMg/F3XSCVXvVvh7PDv4WkYz62K+x/bTsSdW8nEbu6IPNpdzaRrzSlPRhpnAiYISkzgjEhGDR4YFzeMK4mBijo942/oyUN6NvNKEJ10c+jEW7ciRNhAiEt7+9807uSwYaH6Kl4rCzaeAuflDtrV2tXSwTUMF9iaVHG67cbFpI4bY1kA8KOdjuJWoNxqSHp15hP4Me1DXvF8mOxNUTZ4n6SxLIg0ETYcUyXcVbqrJWAeaHiKoHFS+SyfDe933sqvQU6W1XAWhF+C/F1wdSjbeDImNrNu/GRWHHC+ckYICghRxUJmWkvfFaVBLxsYpD883HZOzFz2TnY1lgPzmDMjDSXukFMMyBnI2+4qcn7qweBY/lNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGw3elQxUEVpeE9vSlFKWVBVbVFkZWtTZEpabW1yekJ3R05DaHhmQjIvMHR5?=
 =?utf-8?B?UlVISHBweGRJQTF1enh0UnJ1c0lkZHg2OHBRZmdCWVY3K3k3QmFxcGZwbEVR?=
 =?utf-8?B?YXR1YmJsT0F6SFpSbUFhbS9ybm1LNmE5T1N1cE1kSlpjTjVzQ1JWam52dGFV?=
 =?utf-8?B?aDZqaVhYTVh3eWYrR1QxeW5pSHlaMGJTcElUdlVxbmFxaE9JaTVRc0RNdzlp?=
 =?utf-8?B?WVowOFRSdUdqa0J3cTNhdFZCdUtudHU1ejZHKzd0MjJndWwrdUh4SWhuZkN4?=
 =?utf-8?B?SVM3RkJwZGZjMXk0Tkp2emVGbW9kZ1FVU0Flb21nV3pWTThBVXczYTljYUlt?=
 =?utf-8?B?WXhtcVVHUzlmdzdXN1M1RXp1NzVSTjQ4MFo0cXA4YXRjQXZJLzhEZ2pTTlpj?=
 =?utf-8?B?bnNWT0FrMHllY3RvekJmaWdxRHB6NmJza0Q2QWg5aW9URHUwcDZWRkJYMWpv?=
 =?utf-8?B?bHVGZDlqSHpTc2VPaTlmdCt3OTZxc1h3UHh6aUdZVmpNUlI1M0EwNkNoWkQx?=
 =?utf-8?B?VFcwQjRrUGowUm1nUFJsSnZTQlh3TnQzdEVDNGNqdU1OUjEwaFFyUGVtamV5?=
 =?utf-8?B?VkljUmVwNXFaT0NTRnVpVGQ0VmloYTJlSGVaeTBiWGlIZjFxWXYyY0QyWEcv?=
 =?utf-8?B?SmtpR2JhMTBHbmx2MFBrckxhbWc2RjBOSlVGSjQ0Z0xwa2NzVFVDVDJkdjVp?=
 =?utf-8?B?MWw3OW1kNENlYkd6V1hnN2xPSWFlaEsrSUxOTExYZE54SHR5ZXczbUVkT0hJ?=
 =?utf-8?B?VmtzMk84S1AyQ1lsSW5iMy9rc2F1RlJKYkI0MnNBb2toWGxqUFRVQmlJZ2Zk?=
 =?utf-8?B?L2c2K0RMdjJ1c1FvUlk2cHMwSVdYOHA2OVhWS0J0UUNIeVAvcEtxN042Q3V5?=
 =?utf-8?B?RTk3ZHJPSUk2UDVKcDBtTkFycWdEYzhCL0ZWa2RxV1RCK2kzeGJVaDJrQUtX?=
 =?utf-8?B?ZDNLWnNnQ3pWbDdoQWRpdm4xdlNUSkpqejJqeDVtVU9QMy9nK0diN3VlNFlx?=
 =?utf-8?B?dkNmR2l0QTd5STU2ZGFMUCtncENnSzNmazN6dzgxU0ZPQS9HM29RRlNtUC9K?=
 =?utf-8?B?SUVFU2ZGV2VYbjUxS3V3UE1TQTM3MjlnQTBvc0xzdXE5WWYyeDd6UHZycHJG?=
 =?utf-8?B?RDVQWlBjS0k0MEpvZmliL05uOVZDMFF0TE5rM3AxYjNpbWdCL3ZaTlNHWEtt?=
 =?utf-8?B?eFFEcVNoWWRzRDFTNVpRRTRmbzFUbmRhTStLSGNNdW93eHJ2K3VIR1NpT21w?=
 =?utf-8?B?SlpFREFFMk5vUEFPL2xnbEdJY21uVkt2Nzd0S0k3MmJndE5raWJaUEF3UHp3?=
 =?utf-8?B?eVF2V1phM04zZ0pTd2hkOUREUWEwWElTSUtjdWNnOUx5dCtOaEJHUXdIZXNB?=
 =?utf-8?B?QlZ5ZlNrRWZlcmFvTkVyMTJ2ZGt4NnVEWkhMeXFZb21kVE42dGlRM0oxQjVJ?=
 =?utf-8?B?RXZYckFtUXBPcEF5VTRNdk4waFhLbGNROEtJQWJ0azlEUFgyZHZ2V3FQZmxh?=
 =?utf-8?B?M09VV1MvbzJqd1JySmpjbjVmMUV1RW95OUpZZXJJbjNMd1NpTDkyZWNiNEZa?=
 =?utf-8?B?M2dXNlJMRmFTbDdtMDJXMVpsWCtnWFhlYnhBZXlVOUxFei9KdzBUUWpuSUdJ?=
 =?utf-8?B?NTJvZ3k5K0NheENwSkZjV0IzWHlJZm1RN29UNm44UjBBQXFIU3ZBWFRpM3d2?=
 =?utf-8?B?MjQ0TjNONE9PVTN1SFFWdHp0QlkydWcraWh3RnV6aDFwV1RBcVlzUFJHYmpT?=
 =?utf-8?B?ck4xWnZTYW51c0dIZG91TGllRCtQWFlhSUl2b0lqdkhxK29KSmZOMHIvSDZo?=
 =?utf-8?B?Q0NyTklKeDhySUxhY2xqVVdYNXN2cWJReHRuRkcvUkx3OWRzdXAyUVdKVmhL?=
 =?utf-8?B?K3RUZm81cXVXcFJCeENNaU9LeVNkNDduZmE2UE1oL3FlK1BJZkJuTmZYTG03?=
 =?utf-8?B?Wk9WY3k3SjJFOFhDN0FPck1DK1RmL1k3MEVaR3dMU1A2eUNIbndjZTN5bGIy?=
 =?utf-8?B?YmtUOFQrMFkyc01lRXliNTh3Zk1QdE5jRGEwUkJnR2duL2pRYW1oNkZjMzRQ?=
 =?utf-8?B?VnVQS2ZtR0J5TEpYcFNxVUlKalF0aWdpMWp3UmpVa3hvQVp6ME5lcDNzYzlz?=
 =?utf-8?Q?b1YLOZROfiyjy4XSUcp+5zSKz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34935b08-19d5-4a83-120e-08dc556c6355
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 12:31:59.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DR7qSJaMR9xCEU6EcZzAVokSCuKNncV6p1VPDGL+BPVIwsPqi5J25oomgGdAW12V0meFFC8YGXBlwneLvS1w9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7744

From: Peng Fan <peng.fan@nxp.com>

The BBM module provides RTC and BUTTON feature. To i.MX95, this module
is managed by System Manager. Linux could use i.MX SCMI BBM Extension
protocol to use RTC and BUTTON feature.

This driver is to use SCMI interface to get/set RTC, enable pwrkey.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/Makefile |   1 +
 drivers/firmware/imx/sm-bbm.c | 317 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 318 insertions(+)

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8f9f04a513a8..fb20e22074e1 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+obj-${CONFIG_IMX_SCMI_BBM_EXT}	+= sm-bbm.o
diff --git a/drivers/firmware/imx/sm-bbm.c b/drivers/firmware/imx/sm-bbm.c
new file mode 100644
index 000000000000..fcb2ae8490c8
--- /dev/null
+++ b/drivers/firmware/imx/sm-bbm.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP.
+ */
+
+#include <linux/input.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+#include <linux/suspend.h>
+
+#define DEBOUNCE_TIME		30
+#define REPEAT_INTERVAL		60
+
+struct scmi_imx_bbm {
+	struct rtc_device *rtc_dev;
+	struct scmi_protocol_handle *ph;
+	const struct scmi_imx_bbm_proto_ops *ops;
+	struct notifier_block nb;
+	int keycode;
+	int keystate;  /* 1:pressed */
+	bool suspended;
+	struct delayed_work check_work;
+	struct input_dev *input;
+};
+
+static int scmi_imx_bbm_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	struct scmi_protocol_handle *ph = bbnsm->ph;
+	u64 val;
+	int ret;
+
+	ret = bbnsm->ops->rtc_time_get(ph, 0, &val);
+	if (ret)
+		dev_err(dev, "%s: %d\n", __func__, ret);
+
+	rtc_time64_to_tm(val, tm);
+
+	return 0;
+}
+
+static int scmi_imx_bbm_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	struct scmi_protocol_handle *ph = bbnsm->ph;
+	u64 val;
+	int ret;
+
+	val = rtc_tm_to_time64(tm);
+
+	ret = bbnsm->ops->rtc_time_set(ph, 0, val);
+	if (ret)
+		dev_err(dev, "%s: %d\n", __func__, ret);
+
+	return 0;
+}
+
+static int scmi_imx_bbm_alarm_irq_enable(struct device *dev, unsigned int enable)
+{
+	return 0;
+}
+
+static int scmi_imx_bbm_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	struct scmi_protocol_handle *ph = bbnsm->ph;
+	struct rtc_time *alrm_tm = &alrm->time;
+	u64 val;
+	int ret;
+
+	val = rtc_tm_to_time64(alrm_tm);
+
+	ret = bbnsm->ops->rtc_alarm_set(ph, 0, val);
+	if (ret)
+		dev_err(dev, "%s: %d\n", __func__, ret);
+
+	return 0;
+}
+
+static const struct rtc_class_ops smci_imx_bbm_rtc_ops = {
+	.read_time = scmi_imx_bbm_read_time,
+	.set_time = scmi_imx_bbm_set_time,
+	.set_alarm = scmi_imx_bbm_set_alarm,
+	.alarm_irq_enable = scmi_imx_bbm_alarm_irq_enable,
+};
+
+static void scmi_imx_bbm_pwrkey_check_for_events(struct work_struct *work)
+{
+	struct scmi_imx_bbm *bbnsm = container_of(work, struct scmi_imx_bbm, check_work.work);
+	struct scmi_protocol_handle *ph = bbnsm->ph;
+	struct input_dev *input = bbnsm->input;
+	u32 state = 0;
+	int ret;
+
+	ret = bbnsm->ops->button_get(ph, &state);
+	if (ret) {
+		pr_err("%s: %d\n", __func__, ret);
+		return;
+	}
+
+	pr_debug("%s: state: %d, keystate %d\n", __func__, state, bbnsm->keystate);
+
+	/* only report new event if status changed */
+	if (state ^ bbnsm->keystate) {
+		bbnsm->keystate = state;
+		input_event(input, EV_KEY, bbnsm->keycode, state);
+		input_sync(input);
+		pm_relax(bbnsm->input->dev.parent);
+		pr_debug("EV_KEY: %x\n", bbnsm->keycode);
+	}
+
+	/* repeat check if pressed long */
+	if (state)
+		schedule_delayed_work(&bbnsm->check_work, msecs_to_jiffies(REPEAT_INTERVAL));
+}
+
+static int scmi_imx_bbm_pwrkey_event(struct scmi_imx_bbm *bbnsm)
+{
+	struct input_dev *input = bbnsm->input;
+
+	schedule_delayed_work(&bbnsm->check_work, msecs_to_jiffies(DEBOUNCE_TIME));
+
+	/*
+	 * Directly report key event after resume to make no key press
+	 * event is missed.
+	 */
+	if (bbnsm->suspended) {
+		bbnsm->keystate = 1;
+		input_event(input, EV_KEY, bbnsm->keycode, 1);
+		input_sync(input);
+	}
+
+	return 0;
+}
+
+static void scmi_imx_bbm_pwrkey_act(void *pdata)
+{
+	struct scmi_imx_bbm *bbnsm = pdata;
+
+	cancel_delayed_work_sync(&bbnsm->check_work);
+}
+
+static int scmi_imx_bbm_notifier(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct scmi_imx_bbm *bbnsm = container_of(nb, struct scmi_imx_bbm, nb);
+	struct scmi_imx_bbm_notif_report *r = data;
+
+	if (r->is_rtc)
+		rtc_update_irq(bbnsm->rtc_dev, 1, RTC_AF | RTC_IRQF);
+	if (r->is_button) {
+		pr_debug("BBM Button Power key pressed\n");
+		scmi_imx_bbm_pwrkey_event(bbnsm);
+	}
+
+	return 0;
+}
+
+static int scmi_imx_bbm_pwrkey_init(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	struct device *dev = &sdev->dev;
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	struct input_dev *input;
+	int ret;
+
+	if (device_property_read_u32(dev, "linux,code", &bbnsm->keycode)) {
+		bbnsm->keycode = KEY_POWER;
+		dev_warn(dev, "key code is not specified, using default KEY_POWER\n");
+	}
+
+	INIT_DELAYED_WORK(&bbnsm->check_work, scmi_imx_bbm_pwrkey_check_for_events);
+
+	input = devm_input_allocate_device(dev);
+	if (!input) {
+		dev_err(dev, "failed to allocate the input device for SCMI IMX BBM\n");
+		return -ENOMEM;
+	}
+
+	input->name = dev_name(dev);
+	input->phys = "bbnsm-pwrkey/input0";
+	input->id.bustype = BUS_HOST;
+
+	input_set_capability(input, EV_KEY, bbnsm->keycode);
+
+	ret = devm_add_action_or_reset(dev, scmi_imx_bbm_pwrkey_act, bbnsm);
+	if (ret) {
+		dev_err(dev, "failed to register remove action\n");
+		return ret;
+	}
+
+	bbnsm->input = input;
+
+	ret = handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_IMX_BBM,
+							       SCMI_EVENT_IMX_BBM_BUTTON,
+							       NULL, &bbnsm->nb);
+
+	if (ret)
+		dev_err(dev, "Failed to register BBM Button Events %d:", ret);
+
+	ret = input_register_device(input);
+	if (ret) {
+		dev_err(dev, "failed to register input device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int scmi_imx_bbm_rtc_init(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	struct device *dev = &sdev->dev;
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	int ret;
+
+	bbnsm->rtc_dev = devm_rtc_allocate_device(dev);
+	if (IS_ERR(bbnsm->rtc_dev))
+		return PTR_ERR(bbnsm->rtc_dev);
+
+	bbnsm->rtc_dev->ops = &smci_imx_bbm_rtc_ops;
+	bbnsm->rtc_dev->range_min = 0;
+	bbnsm->rtc_dev->range_max = U32_MAX;
+
+	ret = devm_rtc_register_device(bbnsm->rtc_dev);
+	if (ret)
+		return ret;
+
+	bbnsm->nb.notifier_call = &scmi_imx_bbm_notifier;
+	return handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_IMX_BBM,
+								SCMI_EVENT_IMX_BBM_RTC,
+								NULL, &bbnsm->nb);
+}
+
+static int scmi_imx_bbm_probe(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	struct device *dev = &sdev->dev;
+	struct scmi_protocol_handle *ph;
+	struct scmi_imx_bbm *bbnsm;
+	int ret;
+
+	if (!handle)
+		return -ENODEV;
+
+	bbnsm = devm_kzalloc(dev, sizeof(struct scmi_imx_bbm), GFP_KERNEL);
+	if (!bbnsm)
+		return -ENOMEM;
+
+	bbnsm->ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_BBM, &ph);
+	if (IS_ERR(bbnsm->ops))
+		return PTR_ERR(bbnsm->ops);
+
+	bbnsm->ph = ph;
+
+	device_init_wakeup(dev, true);
+
+	dev_set_drvdata(dev, bbnsm);
+
+	ret = scmi_imx_bbm_rtc_init(sdev);
+	if (ret) {
+		dev_err(dev, "rtc init failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = scmi_imx_bbm_pwrkey_init(sdev);
+	if (ret) {
+		dev_err(dev, "pwr init failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused scmi_imx_bbm_suspend(struct device *dev)
+{
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+
+	bbnsm->suspended = true;
+
+	return 0;
+}
+
+static int __maybe_unused scmi_imx_bbm_resume(struct device *dev)
+{
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+
+	bbnsm->suspended = false;
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(scmi_imx_bbm_pm_ops, scmi_imx_bbm_suspend, scmi_imx_bbm_resume);
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_IMX_BBM, "imx-bbm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_imx_bbm_driver = {
+	.driver = {
+		.pm = &scmi_imx_bbm_pm_ops,
+	},
+	.name = "scmi-imx-bbm",
+	.probe = scmi_imx_bbm_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_imx_bbm_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("IMX SM BBM driver");
+MODULE_LICENSE("GPL");

-- 
2.37.1


