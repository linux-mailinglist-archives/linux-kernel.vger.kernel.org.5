Return-Path: <linux-kernel+bounces-132995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D85899D05
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60E21C21391
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E954216D9BE;
	Fri,  5 Apr 2024 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NUVhu3pa"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2134.outbound.protection.outlook.com [40.107.20.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9016D9C5;
	Fri,  5 Apr 2024 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320327; cv=fail; b=DH6XAiaB+cAcqes9tjErhU6KiZZt5u8nENh/kioFxDw+xhHCV7opRdZ35XJBsGi2QmcOrOHO7GAoWzfM8sCPvspiiFCZAx6p/B7pgAX0quhl8kkTWYs1afEwnSDh+Hy50G6NwBQfoXZfsEIZuvGb4cOQyqx8F3ZkUo1k7S6TqXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320327; c=relaxed/simple;
	bh=F14h2hIZxy/WaPTp6QzvyniwhgTu1G7E/XZjU3o7xuE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fMNqS6AfFPInaclQ6hBokZrvLItbBppaWPgtU0MYjUCL2MZBpwXp98fEGQug9GJkkODmqFHCurNBZbkblDK2Qy8CC8GlQSOwtrKE0FHUIyJ3I6pf5ql6t4crvQZ97TMC8aE3aD5TzeHAEns4yXQKFd72u/8Lq8R99d12ouctR3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NUVhu3pa; arc=fail smtp.client-ip=40.107.20.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbOR2Bk3jOsCSs07kfbVXjxapqIve1OUfrIwTqf9LpkAocu+NwCldVvikMkLuzZUK7ng9ie8bW9GjnxUaSzYFNoQVp27/RC6KgkbFTR10gjNcg46OVkCWH6ALHhe2Eu7YiBMWJcWyZLjaApZEzgzsWdXyZo71Kkig5Xa1PMuGcyubbI1Y+s+f6zbo2UwW1vHHo5C0+KWJ5Vh51b4atDEMgAPLQ80r5cwUKMjauIfADnF4VQ8TKu6icKDMEOSO7xM2bLJLdOslPaq1Pd2k1xPm+nE64P9tS9glnhJujbugIjnt7LMW4WwIR17jwfwreYR7JdZ/zhMM2CexUveK/vuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmLEKLDgTbuTKcvdN45vKFWC6Ra3feV6bbsCVFoin+Q=;
 b=Uu70MlunmDkq2ZwIrtzOtHLFpF5E6jJhSzJa3/rv6r8wiXXsSzIsyqcSEZP60/fzqppRuOc0Pw8YjAspdFMa5ksOQYwVFgyx+I7lWijMTfTh+lZZKwSeT9IyuyOXvjMJ5jFEsfY3tdrt/YW1cwxfGx24ucrRMJ5o6bLyE6SUorp4ZditBeI5FAqu9Iu80WzepuZRdH3Gz9B3qFkRV8TNDMupMmpTcq1EFdTWVcnXgFw7Iw0R+R90/+/McGiiqL2q7QvIQLsDcBJwFU4rRrwhmuMAzRJnwu3dxv24+BNKzU7ko0vWpqnQ1WwdD3GO7rF7t1dxd2PR0hCLU9G1XqJJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmLEKLDgTbuTKcvdN45vKFWC6Ra3feV6bbsCVFoin+Q=;
 b=NUVhu3pakuKSiULZ/H7pA7EXuIc/FJYUzu6cNYAqlPOcxo28ELyxPDw4DFqQiFKkllOQ+vMfq5b91B92JNmU2GY4/rljf7dcQE/tVcJHIujiUqZqhKKUS0JAGHLuDiaJRqmtmmwW94VJnsZ4zfX3IRFZYXV5ZVG+Q83SoTKhJhE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7744.eurprd04.prod.outlook.com (2603:10a6:102:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 12:32:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 5 Apr 2024
 12:32:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 05 Apr 2024 20:39:28 +0800
Subject: [PATCH v2 6/6] firmware: imx: add i.MX95 MISC driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-imx95-bbm-misc-v2-v2-6-9fc9186856c2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712320792; l=4839;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=CxsTem4c2UkSyoEAgF9+D0rRRjQcCv/6gmp4AinHGy8=;
 b=t0H+mFmPeAYegC19iPxmWW1dcghnCrQMgG53u8dAzgygUK8ThK/tgn0DK6SYsIVPEdT1JQ5WU
 LDHzUHS2Ay5B/VlUQgXvwP3H+R18Mlzd0pXo8rDxksC895BaVAKj18D
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
	Yq8+E9rnCZW6I0Eb6CsIV7q/C1ENaM8Xjw4q4nYv/7uxLJDC7qbkFMOZh81Lfo4F1L8gmjUMT6eBLSzKymj2/vxQ1v1ZdiqGAvi2AJtkMbgjbHNEMjwdtzzFjd++1QZ2NCK1MHywAc177jCYCnDc0gBLan5Xlt8AT29sBUCzy5jePWyyuGufaR2RneDCP0WZB7LSiWGc7fcow19zCFubrfuUpHQydwqMtfTdjoTlZlwNg5pSMMP+byOcibSYRSLvK9cfngTZdPZeGu691lT/OIeXi1N3RJizyERmtOjneiXRnPsgQ98SJ/dah04+N2K5gNWla89LiTdhYF8ktID2pHAYoCyF+ZvjTgiCdvNIkcS7V9zA5EtoqSjVZDKDwXnaHycKufKlniokCED6jiQMcG0Otk5vmAj4/KGRCazS7HjwGUusMSlGEigK9I0zHbheZ2qpkkDIcSIfCe6iw2hVPiE6nJIQCJcdxCR0DisK25Kwy96x1klYUuPcQ6/DVcgIFRXW5Uoj7BAK+QMbZbkgvy8RDgEodUYJJpRVzRaX3bUpWuBERUEFCewIyGkJ48YRMiW4UQXSmhB5mOhsOWt2sfpkr0RWvzUbLNiTW4l2F388L0lppNE76B/32QdtAdKyF8a1y385j9YJ9bcjsuphRfMWAW8MFAnSAmeYQVPe2k81DKmj5FT/XICiBgASrqCKlwjQW1a1lRETYTE4SayryalEk2a6v1PHSjPyZJ5ItZg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzJOa0RYUGlHQ3dBZ0NSbGJtSXJBRG0zc3ppaHVRT01IMWpBdjcvTXlFYVFz?=
 =?utf-8?B?Q1hkYjBkbGJDM3FMSEEvSWkyMkRUWHVGdHliQVNuTFVQTXBvOGhSZ2V6RUtI?=
 =?utf-8?B?M3Rrd043dWVsbkpMeDBUbmlXNWx1KzdxMDBDOWU5ai9hbEEzc1JwaWdFTGVo?=
 =?utf-8?B?WHd0WDUwTklHSmROWm9hL1NRRUkvSjRZOEVWbVFhU2VjdUJZQm1FRlBya3Yv?=
 =?utf-8?B?aEFTV0dqMmFiMXNja0V3VWlmaXlNYmFpNjcxNjN4SFQrS2hLSDdST05kNTZE?=
 =?utf-8?B?YTZaWmpkY3o5RWxZRWFGYzB0T1pwMzlDQ05CNkhZM3BSZlRwd3hsSE5lK0R2?=
 =?utf-8?B?S1VoanhTZE41ZlRvc05IWjI1Mlk2WGlnTFBzTGFyMGpEcGhqZlRpN283Tnh0?=
 =?utf-8?B?RXpnRUR2R0RKZ0l4bWp3ZEV1ZHBBSWxNa2dLT2FIeVV3TFFPRlpDK2FqMmhI?=
 =?utf-8?B?dy82QUU3dzRMTlJCeWdHRVlsRFI3anY1NWpKRGM1bXRXU2dDY2hwQVZCTWVO?=
 =?utf-8?B?SFpBWEI4bHVZUk9EOHhxbnhWWC9tcFhlejg2cVBOR1ZrWTd5d3ZKdTRyT2Ri?=
 =?utf-8?B?c0JhMmxOamVJVDM2dHh1OENPUWhNNlhSUzV6dStUQmF5bFM3VWVJUWdYb05Z?=
 =?utf-8?B?bys5Si92VjdSdXRPdVlGTmt3RjY4Tys1Sms3VU1rR1ZZbVZzdUVodHczQzR6?=
 =?utf-8?B?dmdQbGVwMDhmbG9kSm5waUV1VDRLejRTZ0haSGVzTkc0T2lkR1lXVk9RQ0tT?=
 =?utf-8?B?Vnh0QVZUaDNlaHN6YS8zRFk5TWI4Y2U2aWVYU0U0MmtJSDA0aXRqNkt4aFdW?=
 =?utf-8?B?Rmczay93ZFlxZlduWnAvQ09EMjF1b3d6b0lKYXhKMTl6cll4QmFncWZTREVI?=
 =?utf-8?B?aS9tUWtsaWd0WnJqR3UxaE1Ydm1xQ2dQdkhrS1ZGWTVCZFZaclRjMmRlQkxZ?=
 =?utf-8?B?NGZGYlVDNmZUVXo2VjdLYjlhK0xFbXFBRmZGRDhWK3gyWS9SMXY4T2F6dk1O?=
 =?utf-8?B?SENYMnpQMzhmYlR6K3NpWEQzb0dhNHUxNC9aY3dLU01TZytEaDk3RHJ6ZjJo?=
 =?utf-8?B?aFlSSFU4UElDZ0dKVnMxZmxqMUkzYzl1SlFkajRvVHloSjhYYlpSNzVPb3Vu?=
 =?utf-8?B?RHJPMW81YmVVV2RQbFllTVJLK0JYRnEyRENncVFnMFBHRHlsMzVxNXBOZVd4?=
 =?utf-8?B?SFRxcHlJaE1NRzlQOXczaHovT2N5WkpkNVpVeVBsYzBKYTZObm1kQ0dRYmt4?=
 =?utf-8?B?eVQ4ck5abkx2Y2NjZGptNkRqcTVuVmhIRkQ4RnR6QmZMcCtKdGVTalFrMWVG?=
 =?utf-8?B?OE1zUDN1NlErb0JZb0F5WDVUVVZ2dkJ0bUpFd1Nzcjk1ZWRwOWI0U1Y2ZWF4?=
 =?utf-8?B?eUYvb3BQdVplMUthTUpKYkltNk9qNnN1L2dRRTJqKzZ3N3dKb2x2M3h3SEhD?=
 =?utf-8?B?T08vMmhzN0JjcVBmYzVlZS9OY1B3SlljcTNFcE5YME9GNUtrY0RhbDJGTTJp?=
 =?utf-8?B?Q2paOGhHUEdQajZvZXhsb29Nb2VOT2l0QzNoMm9XZ2k0VmVlTGwwaVlnSHE0?=
 =?utf-8?B?OVBSWVppK3graEpmV2hKSFBYUU9LM29WUERtMnI2eURtWHFHQWI1aUNoNHVT?=
 =?utf-8?B?QXJ1NTdpVThNUXlIVmQxdStWRWt2azNVYkJHOWRtZTZoNXlvVUVJWG9DcXhq?=
 =?utf-8?B?bE84cWpZZWdOeFJTRWZaY1pNNXJ0K3dkYXlCemlzTzFjSUY2aGo1djRHM2Nz?=
 =?utf-8?B?aEV4ZUd2MnhkU0ZFNHhZNmlCWGxsOEx6Wm1kWFB0dWZ3aXlSM0wvdTRWd0g4?=
 =?utf-8?B?Z2hIMkF4Zld4QzY0V2p4S0Q1MFl0SHdQRU5HelVHWW9qbnZMTHpNWElKMm8x?=
 =?utf-8?B?aXl3bnl0YlR6NnRxYnB5YjN1a2FpWFpvbHJiRVJWeVp1NVp1YTBBRnlyUVhw?=
 =?utf-8?B?T0ZHTmtDTVdDRUgyVjQwWU95Q3l4QWVwc0UyWmIxekJWa21yNXdnMm56ZjlZ?=
 =?utf-8?B?UWJlSkNQVHYrNEsrR0xlSnFaTklRUEcraDV5Z1NsanlsZDdnVzlBMW1TcGpJ?=
 =?utf-8?B?S0ZYbnBISkx2T2NMQTdpWktlMHRhVVN3bnBHaFFpUVpabVE0YStyUUl5TXNk?=
 =?utf-8?Q?c2RBE4KFyV6FAhWYtIpyc+24w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef5d688-57ac-400a-cbc3-08dc556c65e4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 12:32:03.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzxWKbIZAyDqDQR6R3aT6uPb9ry7HzpakoxeNvj4CqWRSYwDcmQLK8UGN8bbmWtF7bJ3ivo3U6SKhueiA2b5JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7744

From: Peng Fan <peng.fan@nxp.com>

The i.MX95 System manager exports SCMI MISC protocol for linux to do
various settings, such as set board gpio expander as wakeup source.

The driver is to add the support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/Makefile   |  1 +
 drivers/firmware/imx/sm-misc.c  | 92 +++++++++++++++++++++++++++++++++++++++++
 include/linux/firmware/imx/sm.h | 33 +++++++++++++++
 3 files changed, 126 insertions(+)

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index fb20e22074e1..cb9c361d9b81 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 obj-${CONFIG_IMX_SCMI_BBM_EXT}	+= sm-bbm.o
+obj-${CONFIG_IMX_SCMI_MISC_EXT}	+= sm-misc.o
diff --git a/drivers/firmware/imx/sm-misc.c b/drivers/firmware/imx/sm-misc.c
new file mode 100644
index 000000000000..a5609de426f6
--- /dev/null
+++ b/drivers/firmware/imx/sm-misc.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP.
+ */
+
+#include <linux/firmware/imx/sm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+static const struct scmi_imx_misc_proto_ops *imx_misc_ctrl_ops;
+static struct scmi_protocol_handle *ph;
+struct notifier_block scmi_imx_misc_ctrl_nb;
+
+int scmi_imx_misc_ctrl_set(u32 id, u32 val)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_misc_ctrl_ops->misc_ctrl_set(ph, id, 1, &val);
+};
+EXPORT_SYMBOL(scmi_imx_misc_ctrl_set);
+
+int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_misc_ctrl_ops->misc_ctrl_get(ph, id, num, val);
+}
+EXPORT_SYMBOL(scmi_imx_misc_ctrl_get);
+
+static int scmi_imx_misc_ctrl_notifier(struct notifier_block *nb,
+				       unsigned long event, void *data)
+{
+	return 0;
+}
+
+static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	struct device_node *np = sdev->dev.of_node;
+	u32 src_id, evt_id, wu_num;
+	int ret, i;
+
+	if (!handle)
+		return -ENODEV;
+
+	imx_misc_ctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_MISC, &ph);
+	if (IS_ERR(imx_misc_ctrl_ops))
+		return PTR_ERR(imx_misc_ctrl_ops);
+
+	scmi_imx_misc_ctrl_nb.notifier_call = &scmi_imx_misc_ctrl_notifier;
+	wu_num = of_property_count_u32_elems(np, "wakeup-sources");
+	if (wu_num % 2) {
+		dev_err(&sdev->dev, "Invalid wakeup-sources\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < wu_num; i += 2) {
+		WARN_ON(of_property_read_u32_index(np, "wakeup-sources", i, &src_id));
+		WARN_ON(of_property_read_u32_index(np, "wakeup-sources", i + 1, &evt_id));
+		ret = handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_IMX_MISC,
+								       evt_id,
+								       &src_id,
+								       &scmi_imx_misc_ctrl_nb);
+		if (ret)
+			dev_err(&sdev->dev, "Failed to register scmi misc event: %d\n", src_id);
+	}
+
+	return 0;
+
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_IMX_MISC, "imx-misc-ctrl" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_imx_misc_ctrl_driver = {
+	.name = "scmi-imx-misc-ctrl",
+	.probe = scmi_imx_misc_ctrl_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_imx_misc_ctrl_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("IMX SM MISC driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
new file mode 100644
index 000000000000..daad4bdf7d1c
--- /dev/null
+++ b/include/linux/firmware/imx/sm.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef _SCMI_IMX_H
+#define _SCMI_IMX_H
+
+#include <linux/bitfield.h>
+#include <linux/types.h>
+
+#define SCMI_IMX_CTRL_PDM_CLK_SEL	0	/* AON PDM clock sel */
+#define SCMI_IMX_CTRL_MQS1_SETTINGS	1	/* AON MQS settings */
+#define SCMI_IMX_CTRL_SAI1_MCLK		2	/* AON SAI1 MCLK */
+#define SCMI_IMX_CTRL_SAI3_MCLK		3	/* WAKE SAI3 MCLK */
+#define SCMI_IMX_CTRL_SAI4_MCLK		4	/* WAKE SAI4 MCLK */
+#define SCMI_IMX_CTRL_SAI5_MCLK		5	/* WAKE SAI5 MCLK */
+
+#if IS_ENABLED(CONFIG_IMX_SCMI_MISC_EXT)
+int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
+int scmi_imx_misc_ctrl_set(u32 id, u32 val);
+#else
+static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val);
+{
+	return -EOPNOTSUPP;
+}
+#endif
+#endif

-- 
2.37.1


