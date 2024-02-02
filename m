Return-Path: <linux-kernel+bounces-49273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DBC846815
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E1B287205
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D54A17C77;
	Fri,  2 Feb 2024 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XdIdISDK"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2062.outbound.protection.outlook.com [40.107.241.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B017573;
	Fri,  2 Feb 2024 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706855450; cv=fail; b=ZR/G18VoMQzvbFG6LyMGdtfcS6fVFY3RLMAA/2FvqhdCy3Bh0cPRhfrJIhjAe3P5FU6Uk0xianswaU/lnDJZvs9WvvUzXT4OOIh6e6tLsWhXF30sXPtKeOxK32VaAIaM3+Vd+7tpi+Lobj1HS0yOxtjJX3myaM9v+B58xjkp6R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706855450; c=relaxed/simple;
	bh=/DlPMNfxtOKPQ/452D7/XtslYxyfvnTGmvJVTSj8oeE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=h7CSQZDhzRDiDdHhNv/0LjfawWy25rEU4xRGU0rSVCJWIBtrFRa2qzM9lqMAMTHgVjiguKk0/++QISu1o8NF2zEuLcyXCjiQHP2WIXxENXDw1zP/AJiOL6WMRLOhXtUbbjmcyvfQbzUxtkw2FqmkRGrav7iZSEQYh107CgEzDLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XdIdISDK; arc=fail smtp.client-ip=40.107.241.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhjtLWwiSogMkL9GiHQyFbHghBGBC6oFMLGeR2vWPYhYVT7Kbqes1YnPP2YoXo0DQSkdYZ0lFs7+M8YTThz4fkpLWGFp3sco1Cib3DLWe0PnX6DajWaZMPlIV93K/A3DREgScF+GLUiuy1HTtwcrpSx0tI5juugQLDAiwLgnGoZyyGNahrPVf76b2Frfr4EATKPAetXM34+9+WVdQyMJsQS7Ok49UHcilvIiUd/Uv5GvA3U8TRuwqovyaTtofyKKZJfqFiWLttPK/FYzMlvmznMawsyxCKVDT/5ZhzzXQxtoB/OZAmp30FDJ9Tq5G/kqgo/1zWKEtnbM6s4Dv7X5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/+8+PBCrKXHGNNHEE/QQiIcvFqinI1PO5Zudu9T9Xg=;
 b=MMlzPbV9x1deQrMSBWiUBDOA/8gyUAjOT0onzWpAfum4hLISC0Gli/MCxzhzTkMRwGmSwSDlPABibhLrbDHQ8PDzuDDEJ6Rqw3FKmeE6AcSyUzzd44TUnkmhl0C/QhD7sLqTSa3DztXMvb/mmTU1Vgx5kfIChZQcuySbt7t1Uz/cxDLL1PNHgoB54qXFJJLn9KEAwUZ+KxKi2wDeOekzSKX6hCpJps0Y/LhXu/NxCe1vsJpFyC8CpRdgKPBPUunopYJTD3zVZZKyIPCmZlgVO0QHgmRsvnhaA7NYLxOyqYMhDm4kbdeteF2SUH1NLzfemiMDgDO9ulP1SlmHykJKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/+8+PBCrKXHGNNHEE/QQiIcvFqinI1PO5Zudu9T9Xg=;
 b=XdIdISDKB64YAeb2fpDWnaABB/QkaMVf8K109tmeoFcfAz+UIxr8s7MqqAEwkzXKptTICeQIl5K8VIxvJ2E+wPKetJLarvFcCcETf2o6uLgMUDKIu8XfQ7puVBe/LKcOJOzLlmqVZtYP/2W5l6gvU7IhdYHCWLhJMZqDKqVSMYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 06:30:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 06:30:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 02 Feb 2024 14:34:43 +0800
Subject: [PATCH 5/5] firmware: imx: add i.MX95 MISC driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-imx95-bbm-misc-v1-5-3cb743020933@nxp.com>
References: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
In-Reply-To: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706855688; l=4839;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=l1+u1wEujwpxZp3cg566GNVi0f6jUiKSXBYb9aNl0nE=;
 b=7kFiu0G+0ErsohkFa7SxRb4C2Xj7w1sgzEswV4UpIHy1ERHGa8HUp8YemYmW76B2mC5FsnGtT
 2jGGZfASWb5C40TIEQz1T8gpNvOTQz4A0RghbBIqWcHBh2KPlEaT//K
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
X-MS-Office365-Filtering-Correlation-Id: 330b7724-358c-4e29-32e9-08dc23b87cf8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AF+K50A9/GmAlwMXN9rOfmBjoiMPZ0ubmaXpMS/cQ8S5KlaOhpbs8MN9RjU7UOSt5cs4CAKPNzjY2s0t4y+gxkf6LUba6+2e2aRgiQv55EhrWWVdHMGmlLrp+nEm+z9C2fS9WHWDdi+NIfNBveIQ2rgTYl/r2c97z/llasIAk1lp+ROugKnScLYQz4S+NcG1DGNegW+4G7AMPA4V7AXMdcWnCxS6AEy4117kfp7DSYUgx/08JrCwGNPAj6Hia4qwYWnCO9dsv/fV/qnSG+YlQ8hks6Z6woBcRUCmZaZSMZqduGIPYQ/67GZk0B8PCbyMAJ9ZD+ULNzI/1Q7HFYCds9qH7ARSYEnH0LJE8mGznWuK4CURLyj8HFIElvK0yrro866wg5fyrXTXXO51LYfgEdbUphWdXxIehd32I5IC7t9h+AJgCs0d+L724SuW2LMRSEAUst88orjG0pXMBvYump0qxjXTHsoi/Hv4BwmUq8zb5hRrw1wvTQG2/XkE0D4/igJea2rucll7R+S1xWrLsKKu5Xm8hBy9kF4UFAxXF56llxSkFHZLpERwezbyIM2WAmSxiZfrJQ3u+kUHcg87Gpx4JpHxI6lptq3ouUfHoecNgQoFp+he5SOfcUrn8sJapulBSU8eu0u93skheXw+rA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(9686003)(6512007)(6506007)(52116002)(8936002)(921011)(4326008)(7416002)(2906002)(5660300002)(316002)(8676002)(66476007)(86362001)(66556008)(66946007)(38350700005)(26005)(36756003)(110136005)(41300700001)(6486002)(478600001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEhKNmE1Z05MNS9qSzR5NW12RW1TS3pPd0RtVUxYMTN4QnhvYkI1NmlJUFdo?=
 =?utf-8?B?WFU3ZFJrRUJTZEt0MGdyd01GWWw5dFVTcUxkdi9pOXZhZlh2RnFsb3FYMjhr?=
 =?utf-8?B?ZzI3cXdHRmR5Q0JoUVgxK0dHdWFQaXZuRkJmZ0pjK2VUQklna0srelo1WlVh?=
 =?utf-8?B?UWVGZ1ZWWXg3amJ4NWxmeWVkYWhkckJFWmlSRmhGZnM1dnZZdGZBYWordnBu?=
 =?utf-8?B?cWE3RnNGUGk0cDlOdnlURkVML2ZRUHIyeWR1TXdyenI2YzEvTC8rd0JKNytm?=
 =?utf-8?B?bW1IMHNyM253WkxHbHltSGVFZDlxMmszcDY2cCtzUlRseUhleDV3TUZLdDdh?=
 =?utf-8?B?R1ZmemZLNmlrOFRrUncwci8zRVd0VFR5bzhpNFFIS3J6M1NsRzM4OGRlbERH?=
 =?utf-8?B?SkZLYzd5ZGg3NHQ2WjV0c1RoZFl0Q01VU3dvNjBpYzB6NUtkQ3NaODlTbkxX?=
 =?utf-8?B?elk4MjZLTVcvY3FZQ2Jlb0Q3TWJ2Q3R5RFM2OWVzbGhvWkQzTmRoU3hTZFp4?=
 =?utf-8?B?UFRoMlpjNEprOVlxdUVKREJFdWRwUHhZcnU3VitPNjM4Z1p4ci8xTzlrN0Z1?=
 =?utf-8?B?VEZwVkNBRFluQUVBK0VPT3ZYK2VQWEk0RHRlRGpsVXJCcDArb3BtRm5NK1VG?=
 =?utf-8?B?V3kvaElEak4yTFVUUmhIbEdGZzRMMkxqeWVqZlFnRmc1LzBHUi9pWlU5RDNu?=
 =?utf-8?B?TVU5TGJVYzBVRDNySHB3NmVYN0w2b3RxcEV0V3JPTGFQL1RXWmVUSDlJMTBX?=
 =?utf-8?B?WlcrUjNYci85RVM4bFhYVTZQelQ5WmZPREJyMUdPa09jaGlQMjZmUkt0OFlO?=
 =?utf-8?B?bERya2NFZmJmY2gvazMzSEh1bGJNWURxaG55VU9nbUtPcjI4K2RmV0VpOHlT?=
 =?utf-8?B?ZzJzTGNCWVAzN3piek56MDVmemtyQTJoelRzSm9tdjBpY1pYdElTQzBlM1Vp?=
 =?utf-8?B?VWljNThkNG9HWTlLbkduYjlLVUFTejBtMUhhOFlGZmN6c1NJYzFpOEdQNWQ1?=
 =?utf-8?B?aE5wMndpeHpKVkZOdU81ZS9nR3NWSFl3SnZPQkh3UEx4dmxiaDlDcTBUZDA1?=
 =?utf-8?B?S0wwTnE5djIzN3V3YkR1UlcyUjJxUXlOV0g4c21rQjQ5RlJTTXN1eUpDMGJu?=
 =?utf-8?B?N0NPbEhWZm5jL1VQb05abzE2TDI2NEc0SnZXeE1aMk90aUlqSFdUeFQzRFhT?=
 =?utf-8?B?UnVIOVk0eUUzQm4yM2hQekxpdmlIMHdEOTBZQUJRdzVGS2lESFJXdzNLaWdV?=
 =?utf-8?B?L3M0dkU0K3Zhc0NDUTM4U2lWeE02WG1DOGdOY0ZxYTJiSzM4aHNaSU9uaTh2?=
 =?utf-8?B?K21SRTk1Y29Yd2RCVXVsWkpWVlFpYXI4ZURaUnpPL2szZWNQQ3JMVDQ0eGsv?=
 =?utf-8?B?TE5BSllhczM2d2ptdkE1YXVqTCtCZmwybCtsNGlNZFFrL1Vpa0xaSTBiaG5t?=
 =?utf-8?B?MDE3cTJqdkU2Tm9rZ1N4R1E5T0RxTWNOc2pCamRsRnZoODFrRjhmRGFjYllV?=
 =?utf-8?B?K1VKVVZjRy93dVBBeU8xNFgyM1ArZ1d5bmhhMFQzOTg3TWRiczc0STFIOHFB?=
 =?utf-8?B?bXdzMkQ1eS9DQTVqUitjL3BQOEl5YXhkK0tPamhZcjMya1hrTFpLNGdyQysr?=
 =?utf-8?B?MXpDbWl2TEJsTlFKVFpNZ2ZTRzYxL3pkb0xxT0w3WnlkaklhVFE0VThMdGxR?=
 =?utf-8?B?L01XS3hrdGl4TUUvVVhsS2puUzVkR09TdVZYbnY0UC9EblVxUTVNYlBOZGNR?=
 =?utf-8?B?V01DL2tWYnhwUnZiZDNrS1lFSlA0TU9acW9LbUdBWTM3TDd6N1M0SElWbHFh?=
 =?utf-8?B?b1U2ZXVtOCtkZElQUnZ0VVpadXdZeWFoWDJNUzRXaUFnUGNPTk1CWnFHNHNx?=
 =?utf-8?B?M3NqeFk0U01uMHlmNWhoOEp0bzJUTkFobVRmTVRrTVNiTDZjTU0vdERLWjBW?=
 =?utf-8?B?RXlkQzlHWERFYzY5akcrOVp1MGpkNEhpYUo3YWk4enZ0MWE5YmRqS2wwVGJl?=
 =?utf-8?B?aFR4WkNHVVFxK1FJR2hqaEhZbE85R2FZNEZtcnhob1NLM3J4cjduMG1yaG1v?=
 =?utf-8?B?M0V0cmQ1R1E4Z3daMmEwUXBHNFBjWnpOandnVk4wdUN0b2kzZWx0Z2FsYXV4?=
 =?utf-8?Q?YGZ9fOa1cKph/lO+RZa+y5E1N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330b7724-358c-4e29-32e9-08dc23b87cf8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 06:30:45.8310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIOm2y5Acm/Adwrpzm24d+6bnHZK2lKRvI+SmXSpzA88LE26mqu91cXwhT7UGgnN5fiYSQWxJKBfDriyxtEoUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8604

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
index 000000000000..4410e69d256b
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
+#include <linux/scmi_nxp_protocol.h>
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


