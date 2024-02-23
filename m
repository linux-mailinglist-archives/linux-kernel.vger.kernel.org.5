Return-Path: <linux-kernel+bounces-77861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD2860B26
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D3EB23D86
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C81D134B7;
	Fri, 23 Feb 2024 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DXXe1wLX"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14407BA2B;
	Fri, 23 Feb 2024 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708672075; cv=fail; b=ff0QVhkmtDj/s0rdSsyXoTPW1/9zgIUhMenerbXqyY4Rr83youq5PuJmrfNY0Lvtt6JqKH1M4PBuQ3+uANsqZAGSSb0054jGx2fUzY9cnA45Cv1AFlZP7WTCKMq4bU0cSheFi0cR6tKuidmXZ1zxXKNFBPStWb4U3NZXxiuKR34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708672075; c=relaxed/simple;
	bh=8Bv0oK8F6aroOKnuNLzRXudE9KfmulfcYJtoc+wxGSU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TL9Se3lfy0qGVJ/aPePHi8Q3fuE/bQi0pE5dTPu0n+i6I9PHVlWVi+hYN+PUe8uFBn0rsURPxRXtklVIzbihFhMbdR+ZKyyIp6JF0nFvk8axxnKboVpF0HGsgyPTqf14wyJR8g5uA1nAZ7XL3EN8kW+30hjh9HRpUW/KUSQ+0yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DXXe1wLX; arc=fail smtp.client-ip=40.107.247.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaYUZPklmxM426S03e5rp+fdy5+U9nlCd3hmx5E8K1iaQyGvhRTUcGKNYTGDZh6Q+/e8wC8NsS3n/xdsGoKboGBoXXKQSC403RNvZGq4oKi8VxmCK/ghCxTX+KOWQpymX5TYFE6NWh4nsTYZu0BFE76yUpsX0reKDog8JxpxM0WWNW+i8KYU1gNI7ZuSByv5RaKLhGaLgje37vuqJ2wC1nNI/kJr13//ZMzRHO8ZT8/ja1173vax5Jow0x77t849S7xiaP4xJ+zXyUGdnC87OIDX5cTRVfA7OeEcDOgMXfxttIkNw/fWwNkH7Tqk1LQ38QcKQrohjtHbwey/jp9bLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IULnDMdSt6WJwg+Taf/HHBWqcec6eoVyfZLSyNxiOU=;
 b=W0l5ojqYZYfr+0ne9s22Ovl4X6u9b8G+JeLsgkuHyYA+NXIMcjC9AbgxuCTl0LiilUmLrR6Q23n/pBZaxosJmJhMKfPkYHntvEjLHwLRhwRXDWVlaUxk8X5m8j4IV1gG+CROFdUi0cxv11tfKN2acDlk7NNos/jQ+xgJ20uRXvZ7i+YbByU7kwNxn1XT4Ng+AgQccA6dqwlADGYLNT471Gh9T6TYkSAReRl8fnxBzGfJksUySIsy2QrgcH/+f3CUCERJu7hqw1Z0HmppmyaTvzNPZW+pn8aFcuAPugj5GMoTSzAC1TDKsONLKs31/wcl8JxW5W9kxnfWT3XPDa82Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IULnDMdSt6WJwg+Taf/HHBWqcec6eoVyfZLSyNxiOU=;
 b=DXXe1wLXTQWEAevCge0OFVCaBXxemN7ElIgSm14HRWTVERWMTiCabLZG8fy2xf5McRPjDwQOJsHGve63YfBbU/nIR6eH1JstVcCoBUoOk18OmFAV3R7tKm3nLPbXr+bL9cXOtUDwlO8BTbM8MQAH+f80/zmS6vHCJEER0wbofrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB8051.eurprd04.prod.outlook.com (2603:10a6:20b:241::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Fri, 23 Feb
 2024 07:07:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 07:07:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	linus.walleij@linaro.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	aisheng.dong@nxp.com,
	nitin.garg_3@nxp.com,
	ranjani.vaidyanathan@nxp.com,
	ye.li@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] pinctrl: scmi: support i.MX OEM pin configuration type
Date: Fri, 23 Feb 2024 15:15:57 +0800
Message-Id: <20240223071557.2681316-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d3bb90-ad0e-4a7e-800c-08dc343e250a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UiXob72qTnPXIxNQiZbiMMxVSu9diUm3BDxeg20LOpQGs2aCDvNS7wnIoZoNADbL1HfkEcg8tLAdctK4f/N7DJO+um0rZQR9SPJv4dkREJTfFpFJydqAxMXDJpfkASxYb08wXwj4hynF7e+Qyq90J1a7O406VLR5aDm4dL1kHwlumNFunSHEJrS2ljO+TcGpUUjJj74zB01o44wq0G/cGX0PyGkcLfJfrkBxNBAmiUCM2xRIBOi0NInhPKB7OX56wmdCIQXie0NG1QxEfanQk7gP4h7N/FeMlIly/9YCm+erPkjSEbbSzoJC/RduMze4zq+mEUFi38CYIqmCaJA9TBdr9aLWFGn9ou/fVy89ICgpRwddQv65KlTG3DDOetOHlg493nLyVl/j7ptsjRKpbTjHDa1Bb10mfMKjZdlyvJ+PhfnxvvDv0nSU5PyLOAsPdHt2zCfPdmjczVSWBQtUw6K0ATzlhS9X+bO1JhJGD6vemXP5lfYuJTL8dXnfaxPc1Q6jW4aOl+0jNR3i4ZZOqiCbhl7J16zGCmTIJp47eXTlX0KIl7p87uE+6GyUUVzLYXeBSBQu98oLw+Hvf7TejM69MAsgat9Q3KY6VU+8Yi4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+OM36pD3QbzyHYZ3IznLtTdoGKE/bmdSBqyMgwnhnWyjx3huragDPd8vRoo8?=
 =?us-ascii?Q?fGKvfJxlKIudKtdRUtES6Lbvl6V78En4L1DVhhLBdn8qn9XmKoxRMt1llurJ?=
 =?us-ascii?Q?LtoMlulsuAF5jaMndFjMEc7zxMJGvuUkFSQMTf0xewbrySgNeVAcakbEVqOr?=
 =?us-ascii?Q?RxXsuDOckDnNgaVuhmCUkiNNroj39frVwGFFTizoqFeD0BGBz5sCS8ffxwzg?=
 =?us-ascii?Q?FhQENgnTkqcsqAYf4sSViuR7Vm7VfovVHYO3x6tkySuKYKHfY+jEuL0tchcJ?=
 =?us-ascii?Q?XeZbMQAWZJnKkk3f+v44AEqHISJxTmS4hhMTYT60ihQ87m5NJurYcTFX28mJ?=
 =?us-ascii?Q?1rlvl6kcmRffQ1Qy7RbGBAa0Q4x+X4UKpTqHyMotHX8AR5lwOi8QFCm46zKc?=
 =?us-ascii?Q?to9a/uqQtqWUOQlY5KHUgMaebXPfLy5IMiXiFQW7/j4osECFQ14sGSDhAP/I?=
 =?us-ascii?Q?YFrYCbrmqw3dz9Q0I6IDn5vRz3ZrQfhurykzu7GtMfGmPNrarQgPoYdZmlmU?=
 =?us-ascii?Q?Rb4CV/tokipVc7PHzGm6y39yUgju6u5bGLJkXXQEFK0Op5DJRwvU0hBR0V6g?=
 =?us-ascii?Q?ljDKYkTB7+KwH3OSggeN6Lh4jCkuulThp9ad3BD2spLq1TqaCi5XLeHFE7uW?=
 =?us-ascii?Q?E1+4bdr6gEg2PTwCxGnomak5dvsRCj+RP7h1xXs4lic+knXQO9omNw1utiaQ?=
 =?us-ascii?Q?kfxi27oxnmFX01gh48JvT+yBQTe1xDu61klIZcQAAJvUmCEPeARV8sIj+SYR?=
 =?us-ascii?Q?q3ewgCBCM+/H28XELk88YEvH2m1/to+QwSIfygnUzZlAUu80HNJwTKyXVlJ4?=
 =?us-ascii?Q?G0L3SyiYRRfvXBcUD8r9IdbIfr0uDfZyxsmZtGh2f/8boTF5ycMhFcbs8Xfy?=
 =?us-ascii?Q?gI/hfWoAn1pxUQ+5cj/RKC9aT+cOC6EQoEIutorkAlJR2hXnBhXWXMhuDg0V?=
 =?us-ascii?Q?+hrRUGvmbJH35ePyy7AlnVt4zeYDiYDXFXDNRZ1NoS8fw+AX9zE3qT/uqeRo?=
 =?us-ascii?Q?y1vSUycXtLJ3CAOqJiQOwr50N7WSHddTICteVjicizACKmJl/po7UQjQM3OL?=
 =?us-ascii?Q?fVrMyiYUBhDfNLBxo7HPKEXPM32T+3ffzYXTtja5Spbwu0aswbIuHLEWgLD8?=
 =?us-ascii?Q?iOYrf6McbfZ5p+rahINo+a/ntfJh5pzeu8vb4PWahkzKJZ+wV5erpn087QnB?=
 =?us-ascii?Q?E1AqnrjwMlCb1uJ/Mgwrqh/0hSyrsVfODbQxRGJ8onY9geQVlyPIhMBkAxn2?=
 =?us-ascii?Q?BIwmvxt6lwyS/3qkUnehcRB5rTKdAV4SYEMu67ERa25zbYbPuA7pYmpZ78oK?=
 =?us-ascii?Q?uh6illPd8EKx3XpZZ9rxr+1xNZANB5PNdK3o+T4dQWdgIWkl8EjeL7P6ryeA?=
 =?us-ascii?Q?Rq+IHVtmFCXwkiYacsdn3JU69pE4R9v+9S5agQs0ZW/29SJKnVd6h+yVNb2P?=
 =?us-ascii?Q?xwQm++n18sqZVxa4khe4uQolg49eeK+OMIf40Rg4Rj1g6hxwu0KdKAtPxpET?=
 =?us-ascii?Q?cOmVGB9OYxIWHlit1f9LaTgHwtnb9u/gxsuFXpiMfYVKksJ92BFiQ3WmC1n2?=
 =?us-ascii?Q?1gTdHQlGFVQjgfg7MfRvwDG80DfPUV9Zw51Z7jGy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d3bb90-ad0e-4a7e-800c-08dc343e250a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 07:07:49.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqEXUMXVUeEeM+ioSX0fP+Gd8i1KEpO6ampx3TrLeBkVgnqc0XZSOusoA0TMEI4QZJFykdwI8YUwq1GAYufqqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8051

From: Peng Fan <peng.fan@nxp.com>

i.MX95 System Manager FW supports SCMI PINCTRL protocol, but uses
OEM Pin Configuration type, so extend the driver to support custom
params.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Based on https://lore.kernel.org/all/20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com/
 This is an reimplementation for supporting i.MX95 OEM settings.
 With this patch, the dts will be like:

+#define IMX95_PAD_SD1_CLK__USDHC1_CLK(val)	\
+	sd1clk {				\
+		pins = "sd1clk";		\
+		imx,func-id = <0>;		\
+		imx,pin-conf = <val>;		\
+	}
  ....
+
+	pinctrl_usdhc1: usdhc1grp {
+		IMX95_PAD_SD1_CLK__USDHC1_CLK(0x158e);
+		IMX95_PAD_SD1_CMD__USDHC1_CMD(0x138e);
 ....
+	};

 drivers/pinctrl/pinctrl-scmi.c | 10 ++++++++++
 drivers/pinctrl/pinctrl-scmi.h | 15 +++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-scmi.h

diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index f2fef3fb85ae..e58f1aaf9963 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -19,6 +19,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
+#include "pinctrl-scmi.h"
 #include "pinctrl-utils.h"
 #include "core.h"
 #include "pinconf.h"
@@ -472,6 +473,13 @@ static const struct pinconf_ops pinctrl_scmi_pinconf_ops = {
 	.pin_config_config_dbg_show = pinconf_generic_dump_config,
 };
 
+static const struct pinconf_generic_params pinctrl_scmi_oem_dt_params[] = {
+	{"imx,func-id", IMX_SCMI_PIN_MUX, -1},
+	{"imx,daisy-id", IMX_SCMI_PIN_DAISY_ID, -1},
+	{"imx,daisy-conf", IMX_SCMI_PIN_DAISY_CFG, -1},
+	{"imx,pin-conf", IMX_SCMI_PIN_CONF, -1},
+};
+
 static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
 				 unsigned int *nr_pins,
 				 const struct pinctrl_pin_desc **pins)
@@ -548,6 +556,8 @@ static int scmi_pinctrl_probe(struct scmi_device *sdev)
 	pmx->pctl_desc.pctlops = &pinctrl_scmi_pinctrl_ops;
 	pmx->pctl_desc.pmxops = &pinctrl_scmi_pinmux_ops;
 	pmx->pctl_desc.confops = &pinctrl_scmi_pinconf_ops;
+	pmx->pctl_desc.custom_params = pinctrl_scmi_oem_dt_params;
+	pmx->pctl_desc.num_custom_params = ARRAY_SIZE(pinctrl_scmi_oem_dt_params);
 
 	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc.npins,
 				    &pmx->pctl_desc.pins);
diff --git a/drivers/pinctrl/pinctrl-scmi.h b/drivers/pinctrl/pinctrl-scmi.h
new file mode 100644
index 000000000000..fcc61bc19c98
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __DRIVERS_PINCTRL_SCMI_H
+#define __DRIVERS_PINCTRL_SCMI_H
+
+/* OEM VENDOR Pin Configuration Type */
+#define IMX_SCMI_PIN_MUX	192
+#define IMX_SCMI_PIN_CONF	193
+#define IMX_SCMI_PIN_DAISY_ID	194
+#define IMX_SCMI_PIN_DAISY_CFG	195
+
+#endif /* __DRIVERS_PINCTRL_SCMI_H */
-- 
2.37.1


