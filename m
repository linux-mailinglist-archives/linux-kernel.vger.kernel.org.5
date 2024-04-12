Return-Path: <linux-kernel+bounces-142516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1103A8A2CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907961F23A27
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B8D5676C;
	Fri, 12 Apr 2024 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ay8/6nXK"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D05677C;
	Fri, 12 Apr 2024 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918389; cv=fail; b=JOauOlm12w2POTQ2HGM4cibPkqdEoMGpf2S3MMhdVGIt+CX2o22n9g0TEE+ewLVoUkVXGTxUBL0QZVHYMHelHFjquyHvnYCLc7JX0g7xRWZJieRHTFCKXV9XYShFjP6A+VFnQAmvl8PpikJjSeZ+RxVZPCYcJpHW88w3oL40JyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918389; c=relaxed/simple;
	bh=7eShSB1HQebkY20sqLbYKFiD+32vvCrnjG0Yj35mBes=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oysm1zuoNK37/IgGNa8wKFLy1v6QcXoiXRVJyXzocLMOMb2HRnTzWIFLPDITB0yBxf0B3zuSB+66atNupTlWklDK+/OW1Qzp4FU/FSWPFQUdXWVVC+Bq7pwwr73Gh3i7QUYQ7TQy+2b8Y4aGgjhLZ2ULXgVYJ8jtjW/HZ0zDI0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ay8/6nXK; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwroFxFj2+oBA9OPqUUWYPEeI47/FkICWg8ROzsAE2sewcQ1U8T58H9YY9KM7hNTo3TT+xKmrm3o1ZIH3/4lVwYlygO4CMP84iJ2lnrzcun5NQ67ptVwPEdh/CvN8Cj5crhXngfQGyHGpCOPnU9oTTh5kK+Ao1jI0FmvI18pxsjMeX4s4sqj1UM4N0Kdd6rjotPiuzD+RVbzwZTYw3ehayeIlsICJBhy3MotGXemBGFZrV1roTdTFmLkl41To6w+OugxuD1TBS3TKQeAW03g+BfgoKTU9EQUWP6CzVDtr5HHR8140N4dRLmvaUAzsVrPz7HcOKX6jdd/hnWU8JZvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4bWUdJk5TwFdQWhDrGyBda9rTGBzN47VQeiZ7m4qmY=;
 b=LlQyO91DqR4X7hDU8IS1PonDeFgkIzetGcctB7SB0UZEUtfwgqFgY1X4OaovF57tqBin/mBKO10xfyi1ZtpbZP1h5BRb1hu+LlA/prRe2O8KDROiNarHrLLpXT8fdY+nWacC0BQP+nULgGtLpmo+dYReWAssBDo/0VG4qCYL5Yy7/4bxjYikWdbp7zxBPxgjOde16wLB5By56haCXjvZzLCXc8QsocT/wmfzpMEqrzVzoiCmSKnT9VM99YCUgYDViizIurUTEJ5EIYWLcMjquDv2Bks/ayGlacyGMfg78oRqVJpCR2A8hEhGDFwAnDEW/hvfC9K4lrvR+cro8hX/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4bWUdJk5TwFdQWhDrGyBda9rTGBzN47VQeiZ7m4qmY=;
 b=Ay8/6nXKh1te4HqiIvSdxPMVl6ODJzzKQaL8OxmStlZQRiBb1y2GXFa9/dhgIF52WSIUfYUG73paH4W8OpXhZah9QJ34NUDB08xOXW2CphX861lYrfvoJf5GTR5phjJfW/3oDdSWyh6rqJLpRYS3A3ujgjlXpUKzKx9jZ76FZsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PA4PR04MB7839.eurprd04.prod.outlook.com (2603:10a6:102:c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 10:39:39 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 10:39:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 18:47:11 +0800
Subject: [PATCH v3 5/6] firmware: imx: support BBM module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-imx95-bbm-misc-v2-v3-5-4380a4070980@nxp.com>
References: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
In-Reply-To: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712918849; l=9360;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Qe4YMjymxAKRop7ehNWBHg5FvDm2cdcwGYpisnkYZ7c=;
 b=MmI3BFTfpRBV4xJtmD1YrQQuGQ8NajI77EbVfe8+Q5rz64l9sfl1gbg4LcSv+vOKXOpS8xWmD
 ODVs60GbX7dDaSTIBIIeIxvKJq4dcWRJsg0e5sYbzPrzZjP14ElyGjW
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|PA4PR04MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e2ae47-6d30-4a16-51e8-08dc5adcdad7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gyANO/EsKz1+25k4goLlA32r/otUhP20A8WNHL4Rp++FMhXGyo7Ct2s3loWzWU/XT5p9KL1KZJwIgPD7u/XJmLzx8/VYMR4kcrNPM1RbFoeGg1CeA3L1NDKkv0iUDy930E9RCi9qauvBZBhrdDoRKb5gVas3IorrW/59YEyzVTKUVkWq2CNns1XBg2gEv5e+rFCeUW4QEaO4swhdzXSldoUJtdwqUR/1EFVoiRqrka4c6gT0eAuIhYen4DldmMIACXt2heJtnG7B/E54vRWgAh07gtTtbUVvfxjRtd4U2TmRGWNFVl3GZ0CqHM4aZvN1TYbPOILhVcEKvGW10+xA+eANuKLk1BQ6dyTJEKkH2+p3eC9TOpdL7668CB9TUzRU3/7YzypCXP78oNP2WxZRo8kPlyIzdtrdgDBJjZkRBs4WETkuwzdwGUyTnZHUyskE9RDI6/3nqlZv3amy7NVohdpkQvD3JPi3L493+2ZwZrrzdLgc4BfODr8tvBsPljr8+1FOT89VZV+76ZGbJsjMSFxZyswT9IFHSJYZ1s06gzotqq67dhsusxLhtHK820hOUkq3Pzlu4jjQYu5KiWMXthkvOPsXrp9fWOaM/UaAJLoQUOJwJQFN+iUsmqdLuoXnsadXuB1LtyrYBs6Y38d+srJbsEzctHE1auFLFVrNNRm8tkCO4APoh7Zzca9qCb/5qhWNn97dsZEmYhCOacc2gQ+SkZK1aMcVS1GRhTmzQwE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTUvbUpUZUQ5NWNGdXRPU0VGQUowS2RUai90VmxiQ21KQ21ZYVZVbEUrcC9r?=
 =?utf-8?B?RllwTmRXa2E1WXNtZFF4NUtEa0tJUFpyQmJGS1ZGb0NJRG9hZkRSVE5KM25w?=
 =?utf-8?B?Rld1SmpkSWszTWhlV2ZQZ1h0aVdOVk1KempoUk1pRWM4MUpYeXFDc3RwMmJH?=
 =?utf-8?B?dTEzMk9MdW1aaEdnYWNub3d1MWR4anhUNWV1OHl0YVdpM0RjalFyc1paYytO?=
 =?utf-8?B?bFFKQ1dFNm1EdEtFRU1oUVRlZlZpUUo5eHlSRUJORmJsSW4vdGtUNndiVEI5?=
 =?utf-8?B?Z2VydlJPSFlTYzBwckZIM2pPemFpWm5YclRxY2lSWjdzUjRXTVdxZW1LREhG?=
 =?utf-8?B?NE8yZkRxNGRoakRJZzkrQWNubmtENDdIK1YwUmJ5OEpBU01haWlqZlpVdUhP?=
 =?utf-8?B?WlR3UngrMFppWUd2dUlrRDZaRWVMU2xHZ0NxdDc3MDM2Tm9RRGR6VkRoQzVK?=
 =?utf-8?B?RXZqRjdVeGlYU1lpQTA2RlRoaWplUk5sK2pjVzBiWWZ6bFYrUTA3WEovRU8w?=
 =?utf-8?B?TmhLb1dCMlJpOUV3Y05UOVl2YytZQlNicmhqN0l0dGhnaWpGSk1HU1VyY1Ix?=
 =?utf-8?B?ZTZwVm93ai8yOTRJT3NSa2pFNHlndGozRmpNVGZtVjdCYTh1eDJnS09ObUhp?=
 =?utf-8?B?QjBDRTBxOENyMGNzZHRUV0h3ZCtZVHpTYjRncmRhR2J6NFpYZ1h0L0o0M3dT?=
 =?utf-8?B?RlpVYXJiVzNCcHdyNEdWTTlpc3Mwd3F0QUZ0VkprbG1saE9iVEtRV3pabC84?=
 =?utf-8?B?RGYzWXhEem1JQitIbG1wL0Y1RWRNSDduVnJ3T25JZXdlZk83d016dTFzYnRo?=
 =?utf-8?B?MlBJMElydVhPVlhDU1p2aTlObi9sZFNjY2QrTHJCK3oraWFYc3V2QnFtb09N?=
 =?utf-8?B?c3J6di8vdDlOU0hNT1NsWUQ3V0VJSnU3OXlTOWw1Yi9QeUxqWWwzMW5JUjRM?=
 =?utf-8?B?YVBuZDNUUGpmR2F5TFhJbUZ0KzJLUXUza3R0NjZNWitFSExyOThTejZVUm9H?=
 =?utf-8?B?Zk5MV1EvV2JIQ0h5Zy92dDZvdjhKWm44TmQvNm8vWFpMVGFMOG5JdHlBbFFL?=
 =?utf-8?B?OGVUQ3AySlRobm40K2pQQ014cHBGMWl2SXQzeEU0YUVnMnZOQUNVMER3eXFG?=
 =?utf-8?B?U0J6bWM4eGhKNkJQQWZtajhNb2ZNM2tUTTVkQkJkWGNUVGU5cFVobWJkTW5v?=
 =?utf-8?B?RXdWWFE1Si9pakoyUnVZWTNRczQ3Slp6MEhDYnZlRVI2OXBib0p5NWh0VUJN?=
 =?utf-8?B?Q3RJYXlPSEE5SmgrSUpacW1JVFpJSEZMVzZIMlNwbFRmbFMwSDI4SGk4eFVh?=
 =?utf-8?B?ajFWZHc0RFZ6eC9OSW1sVHF3bVI1MzkyUUZsWXZrRGhpN04wbHI2SHFVaVhY?=
 =?utf-8?B?clIyS2k2OHBOQUdYRHVCUDZBcG1zREV4eUZ2cm12Y0w4b2M0bG50WnVoUDds?=
 =?utf-8?B?SDBPR09VR3BXSS9Sc3hVaEl1Tk01TFduZkxvSGs1VDluZGZMQXhkYm8wZ085?=
 =?utf-8?B?ZW52Q2JKUXlkVlVmcWJ1MjlLMzFlekduQThoemJuRlVxSU5PdmVReU5ZRFRs?=
 =?utf-8?B?eDkwNU5BUVVjbUpUeWZ6T3k0NmVwWUQ3YWlyblFQTmdqZkJWcXNVWnFaUWs1?=
 =?utf-8?B?M3hra3BnOXFWb3hjSHBScGdWelBmL09RWFhmUmE0RnVad0JUZ2VPMGRVNE4y?=
 =?utf-8?B?ZThteGp1am9nWXNmVXlCSWRwYlNLcU5RdU9LV0UxR2lvM1VwRS9hSzVIZkoy?=
 =?utf-8?B?S3M1RFdDa2xjTnVkUDJrUHFBRW1mOGtDSnRxY2NtcmdvWHZLWTBpdkF1U1VQ?=
 =?utf-8?B?MEM3Yk5WdnE5OVBUbDRTSDEvd2hLK1JWcVVBQnZRN01SRno3Y3lyVEUyQjlx?=
 =?utf-8?B?bFhKZ1N1YTRMbVVuUjVoNSt6a28rdmJBWlQ1NThPUm8ycmV0WFZrMXpYU0Q2?=
 =?utf-8?B?RVV2eWRHQS9RZ3ZWMEdVa3dOTmhieUQyalRib0RZSGFPbjRCazUvU09EZ3hK?=
 =?utf-8?B?b21OZktya1JuUERjU1FBZWxhREhRWGhIZEUvWEJCQXBHN0NNUGcwWi93RTBi?=
 =?utf-8?B?TFpFTEswcUdrNUpHVUxKSlA4OGNUMlFSM0pVcUx6ZFk5c2dDZHdNWkJMbzB0?=
 =?utf-8?Q?Pm7lzlwk5ou0bcNkb2nZLzftb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e2ae47-6d30-4a16-51e8-08dc5adcdad7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:39:39.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vk53YmvSaiag58yHOR/r8/RnDM7tWOC7M1FwmEw/uQvmrP3eP1gnY4N0ypp7H1mRpGqBQOMnASkAkomyoXIa4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7839

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


