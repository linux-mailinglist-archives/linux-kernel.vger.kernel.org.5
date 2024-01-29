Return-Path: <linux-kernel+bounces-43436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE0B8413DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E56C1C23D60
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538ED158D6D;
	Mon, 29 Jan 2024 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FlT29xD/"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F5157050;
	Mon, 29 Jan 2024 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558041; cv=fail; b=sJ7WXX6aVkso4c0rzcHFg/u1N3jlgnVHYrlNO19v3ldplQY/fEl6KbHkzas0MUUMviSyt/dlkekm4eJurjwOlxDIiectnBqb0CvEvkhwVrtoy3oPwK+kwjH0JbrjmQy8PyvpVEHynIBiyQ0jzoOfL3R+KpmnnNtAmVopdpu/eNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558041; c=relaxed/simple;
	bh=or+397yWvEm61Xp5s78xEs1alVCqW+LonSzHmBaw9VM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CtJ6Q7MwsoGJrs+cnBwhpp8NTHBIdHTF520LGSRgw9OwybowShM6rgd8hR1ppniomNFVQpIp2K6Q8koRU6IKJhmX9NJbW/4vRB4nv70ugfcFF/u0uY02wFODFGu+HUutZyv05QloKeSSO8/RFenXrze9D0tcoOM9POH9d7bmtU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FlT29xD/; arc=fail smtp.client-ip=40.107.104.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKcUQm1/YiKVZqr5hQIuSzKhIXMTAjoKSzlodSh9m9auwq67JdzO3UoPJ4IZHSiyngdPHhJfAWtkolJbnNHClTaD1jEMokZrqT3W36O8h9G8+MSEJ8IO/eBX9PYvH3sfWhUTUocvPkrS0k0qMSlSDWwTiOLX4WYnNBCKc4MjmaVfC4dxdSHYQ8kIF4i+Add1YaEo1SeXFdbaqGChAuqIhwjkYgHooWXTFtrRpYJhapjXEdTenH59N+Xrz5T4VAscY848w7G0JSKuWq+r1NQjQAGSkKFbPDrdJ1GFfnH5jXDll3eyQyVQyfa02YufbIsLPCt88Fe+ndu1UG0/aFSGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUFNo4LWNJOIgV/97UbyKVahyaF8RY8BcXYiK1q7NkA=;
 b=Z5yYr0xW2qJx/4pDY2RfD+sGYAaVaC44RSc23wFk/IQSM+h+mXD/1KrqcL2RFUDs0KLe6M7ZRvku6uCU7j+2QRCaRMyiUvOC5KDGy+Nefs4/SN1ZKpfVM5iMUMO5g7BdH+1Fbl/cF0wBuQh7jjkUF+dYoCHEGSh9kscs4TSz2ffXsH7VtuGbp4AWwwqRvSO8XINoxvf/ao22o1lBppgEDkR3xxUDi20j+hL/w9K0wWcR0X7l5qRbA0NrNDAHDINLWQkyGSr4YBGP7vit4AuaseXWBHPKvwoGOSqV+LVRjG9q16JLyGI/ulsgG1ghfLLuKJxycBYp9+Wz9imbowMrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUFNo4LWNJOIgV/97UbyKVahyaF8RY8BcXYiK1q7NkA=;
 b=FlT29xD/Nyya+mHJ27/4pw2HZ1Lk1sJQjuphrtnoDEfePEsfVr9K7EvYcCYcJRagCvaNQgKS50XQFdQ6gTpOSDXGWQRW5tLo3WO08T5IIuSdwZblbT3XZjxrvhdvsI9XOCRqcMwl+OSx5csICBBJYK24FADEQlQPbgoUCH+OIUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8128.eurprd04.prod.outlook.com (2603:10a6:102:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 19:53:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 19:53:56 +0000
From: Frank Li <Frank.Li@nxp.com>
To: ilpo.jarvinen@linux.intel.com
Cc: Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v5 4/8] i3c: svc: Add svc-i3c-main.c and svc-i3c.h
Date: Mon, 29 Jan 2024 14:53:17 -0500
Message-Id: <20240129195321.229867-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129195321.229867-1-Frank.Li@nxp.com>
References: <20240129195321.229867-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a100bb0-cc18-444a-7402-08dc21040726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K40OkAdM82Aj9YJVCPKJfaJORA+ms735LnC15XbfbF5uLz8gVv2Hvnj7v8foEf4AUqT+4qcV+yFdTBtyf4V5+odr4VVyoZHDXW56VHex5gmeR5atkMHkACskE2mmGNVQRt/yutudY145XolKTCZGKrquEiv30dyQxLzoRRT9UMNaAScCEWkIDCwSKUx76jg+i/VN4BoRAwGUVckrt5Cu22xk/1jHIR95d5qGy8SJR3jAgr+9yl7g0y2lUIvGQOws0yUkec108qRTbzsA7vvs0ZXi9aRPJQOnCAGLViFqlXksc3rGUT7Jf8qXcG7klGaC35Ne/KdQzSnhxIt1++szHhkD0FyWObJiUE2CR2W7EKjYpNjmcQRcqcCFtMK7ZCEdGaBDWHG1r0y0dXh7Av+BdzyxgeQsGy1SqIAeFCpEXg31880RvcRMjFuXyLiKFncyd3f+3hrumbHIXOL+krl02EH7/t1J/P64y+yaW+4OOWBpY3rtxobSQeu0Ng6znbzryB7AQ6wbDy8xjuHrk5DPeMVg5a5SK7lQVZrvuIjMHYw5I+MhI/jE0ospBWVbNqd6WTMEPkpSBwEpWqwihYmzRFReIcyZXKS3c6oyd52PAWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(52116002)(83380400001)(6512007)(6666004)(6506007)(38100700002)(66946007)(4326008)(5660300002)(8936002)(8676002)(7416002)(41300700001)(2616005)(316002)(478600001)(6916009)(2906002)(66476007)(6486002)(66556008)(86362001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D6j/Zd/y2E4EUHXYEQHIwmX6XkQfMmeSlc2kLOdu0orOu8kfCNGi375E3wy4?=
 =?us-ascii?Q?A2BJX7dHsctifCEAYR0DSNF6MpAqyWxE8PzSn+IgcAubqtimFsxkJapMHNYl?=
 =?us-ascii?Q?MYPKX1ZFs6fP/tm5mdE8iBG3CH10F65YR52DavNKuX+Wo9xbU7/cId7gpNu5?=
 =?us-ascii?Q?sUPW1YJi2MXccHzrdUUxO1E/jCNMR8yRtoxIh63a8WyJEOnzlpa3BFECdBIy?=
 =?us-ascii?Q?jpUzJ20Oq/d+RqboV3HPFp5HJ1tRCCYigc5ITDJndND+ZRPbJJs9wLXhsm8w?=
 =?us-ascii?Q?hlEAQavEIkgVo2jFCuV/raW3FEoJ9dGbyRK3usb+8LDd0cWKCwH2tcWOytlr?=
 =?us-ascii?Q?p/FjtUqHLyIuMuRew/U9uOlD9vMZSsR+D3m0q8Yy0mLpXCx9fXpnSx8+e64p?=
 =?us-ascii?Q?wgjFbDOrMjQCViWnKBl/QsOhzBgacYjaaxZmKTAiVIVkQVi0qq3hlsgC6qkp?=
 =?us-ascii?Q?k8ZbX7Eqyg8BKsRHOBgZAoiMTiNnYpJjdIkJvdhrQhC5f4pMSqw8Diangeo7?=
 =?us-ascii?Q?LMIY/1xtU5aLsmtDPNGbLZPkBLxf8+buOnorP16mqN2NkyBM+8d0jZsgrrEV?=
 =?us-ascii?Q?OGK0a+QvC/JZudhXX3BKceJYQMt9GqtU572PWkdLGL31t1naxIhygWtljc+W?=
 =?us-ascii?Q?3T1PS1SGPtlOEOSGuhgJN8DMUxhvmr+g2CdebUOwrUdjdX0kpNz/quYqsXgB?=
 =?us-ascii?Q?XacPvcg0pwiKPMaB0AkOgMuwnbjLx2um0Q7tG7a9Ey7l34RxMFctDTilZKbG?=
 =?us-ascii?Q?j4gg040D8XtCCT8Lu2JmEWS4fwk7frdSm/6eRFTG+hisbodax+EBLoRuRP+Z?=
 =?us-ascii?Q?bI+e7cwx1iDRAGEEc+2a6psFWhBzSVz/EXK8b1b4dagAYQbQ8Npp9ZC7NnEl?=
 =?us-ascii?Q?GScUbdnz8zIYplqT703DJV3/7okYi4SIg9VvRFCtzGjz8ApwzGIO2leQhRZC?=
 =?us-ascii?Q?7FJMvvq4+rMc7UGFb29Nq3FA/7yqSCM+uiaglQCC4uLkMp4DhgC1UV9V0OlB?=
 =?us-ascii?Q?SmV5u8fb9hLIwZiCQDCDOYrt4vPWML/PL90KyGbdSS5VEDlHZpRoXX7lA3dy?=
 =?us-ascii?Q?LuN5cOyPZ4uoHoNs1qjnpQLPvhteuspcrtFHFWYgxb6xY5UUeXcdT8HQbV/w?=
 =?us-ascii?Q?5PyJqvjC+01ksLqO7Pv9VgZmCm61mzLdYswMfZLGSMgF7wVSkcJo5WX86hRF?=
 =?us-ascii?Q?tRU3BSsnzrysi47u3Z8Kz6WzB1EWkLXFDHa3QItu84T2cNkYHGimw3WVRMJY?=
 =?us-ascii?Q?uHPnt1s+2LfK+R9N8Stms4yYEcoADnwlKNiyz+15AJu6rBATknHXhkp+x9nA?=
 =?us-ascii?Q?VerVvLD1F+c6rxwTT0MIV1OY270tMaGB3AG4Jdr0bX+mB7FQ7e2o1xsWcAca?=
 =?us-ascii?Q?wloXvZB03gsDRfO2EYxIQLO0DZ7YnjOqQ6cmjCiOdzaR3p50dfi7EspZBovI?=
 =?us-ascii?Q?DnVg9PcXwhHZrXje74kT2pFsPm/7AEkb0x9PZGAIvDWJlO+UC7H6zPNvTnCi?=
 =?us-ascii?Q?YF1LEp9mH0FX9dlR591tzkFz0SDQINuXAMvcUJxduWdSU+/4V04dTPJGWYGj?=
 =?us-ascii?Q?+gt69wErUcmng7C3fwj9S+DoptBhYE+lS+qDrPP1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a100bb0-cc18-444a-7402-08dc21040726
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 19:53:56.5271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WchcXB5bB3m1GmhtmsyvtvI39IUKH821r1xLcJT2U7hhMly5comIokZlFqwmXSEDKPBFclNy+612cKx2M3H4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8128

SVC i3c is a dual role controller. Move probe() into svc-i3c-main.c. This
prepares to support target probe depending on dts "mode" settings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5
    - add new line at end of file
    
    New file from v4

 drivers/i3c/master/Makefile         |  3 +-
 drivers/i3c/master/svc-i3c-main.c   | 53 +++++++++++++++++++++++++++++
 drivers/i3c/master/svc-i3c-master.c | 34 ++++--------------
 drivers/i3c/master/svc-i3c.h        | 12 +++++++
 4 files changed, 73 insertions(+), 29 deletions(-)
 create mode 100644 drivers/i3c/master/svc-i3c-main.c
 create mode 100644 drivers/i3c/master/svc-i3c.h

diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
index 3e97960160bc8..484cb81f45821 100644
--- a/drivers/i3c/master/Makefile
+++ b/drivers/i3c/master/Makefile
@@ -2,5 +2,6 @@
 obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
 obj-$(CONFIG_DW_I3C_MASTER)		+= dw-i3c-master.o
 obj-$(CONFIG_AST2600_I3C_MASTER)	+= ast2600-i3c-master.o
-obj-$(CONFIG_SVC_I3C_MASTER)		+= svc-i3c-master.o
+svc-i3c-objs				+= svc-i3c-main.o svc-i3c-master.o
+obj-$(CONFIG_SVC_I3C_MASTER)		+= svc-i3c.o
 obj-$(CONFIG_MIPI_I3C_HCI)		+= mipi-i3c-hci/
diff --git a/drivers/i3c/master/svc-i3c-main.c b/drivers/i3c/master/svc-i3c-main.c
new file mode 100644
index 0000000000000..6be6a576cdf7a
--- /dev/null
+++ b/drivers/i3c/master/svc-i3c-main.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#include "svc-i3c.h"
+
+static int svc_i3c_probe(struct platform_device *pdev)
+{
+	return svc_i3c_master_probe(pdev);
+}
+
+static void svc_i3c_remove(struct platform_device *pdev)
+{
+	svc_i3c_master_remove(pdev);
+}
+
+static int __maybe_unused svc_i3c_runtime_suspend(struct device *dev)
+{
+	return svc_i3c_master_runtime_suspend(dev);
+}
+
+static int __maybe_unused svc_i3c_runtime_resume(struct device *dev)
+{
+	return svc_i3c_master_runtime_resume(dev);
+}
+
+static const struct dev_pm_ops svc_i3c_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(svc_i3c_runtime_suspend,
+			   svc_i3c_runtime_resume, NULL)
+};
+
+static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
+	{ .compatible = "silvaco,i3c-master-v1"},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
+
+static struct platform_driver svc_i3c_master = {
+	.probe = svc_i3c_probe,
+	.remove_new = svc_i3c_remove,
+	.driver = {
+		.name = "silvaco-i3c-master",
+		.of_match_table = svc_i3c_master_of_match_tbl,
+		.pm = &svc_i3c_pm_ops,
+	},
+};
+module_platform_driver(svc_i3c_master);
+
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 5ee4db68988e2..4dfe85ab17fd2 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -21,6 +21,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+#include "svc-i3c.h"
+
 /* Master Mode Registers */
 #define SVC_I3C_MCONFIG      0x000
 #define   SVC_I3C_MCONFIG_MASTER_EN BIT(0)
@@ -1613,7 +1615,7 @@ static void svc_i3c_master_unprepare_clks(struct svc_i3c_master *master)
 	clk_disable_unprepare(master->sclk);
 }
 
-static int svc_i3c_master_probe(struct platform_device *pdev)
+int svc_i3c_master_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct svc_i3c_master *master;
@@ -1706,7 +1708,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void svc_i3c_master_remove(struct platform_device *pdev)
+void svc_i3c_master_remove(struct platform_device *pdev)
 {
 	struct svc_i3c_master *master = platform_get_drvdata(pdev);
 
@@ -1733,7 +1735,7 @@ static void svc_i3c_restore_regs(struct svc_i3c_master *master)
 	}
 }
 
-static int __maybe_unused svc_i3c_runtime_suspend(struct device *dev)
+int svc_i3c_master_runtime_suspend(struct device *dev)
 {
 	struct svc_i3c_master *master = dev_get_drvdata(dev);
 
@@ -1744,7 +1746,7 @@ static int __maybe_unused svc_i3c_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused svc_i3c_runtime_resume(struct device *dev)
+int svc_i3c_master_runtime_resume(struct device *dev)
 {
 	struct svc_i3c_master *master = dev_get_drvdata(dev);
 
@@ -1756,30 +1758,6 @@ static int __maybe_unused svc_i3c_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops svc_i3c_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				      pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(svc_i3c_runtime_suspend,
-			   svc_i3c_runtime_resume, NULL)
-};
-
-static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
-	{ .compatible = "silvaco,i3c-master-v1"},
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
-
-static struct platform_driver svc_i3c_master = {
-	.probe = svc_i3c_master_probe,
-	.remove_new = svc_i3c_master_remove,
-	.driver = {
-		.name = "silvaco-i3c-master",
-		.of_match_table = svc_i3c_master_of_match_tbl,
-		.pm = &svc_i3c_pm_ops,
-	},
-};
-module_platform_driver(svc_i3c_master);
-
 MODULE_AUTHOR("Conor Culhane <conor.culhane@silvaco.com>");
 MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
 MODULE_DESCRIPTION("Silvaco dual-role I3C master driver");
diff --git a/drivers/i3c/master/svc-i3c.h b/drivers/i3c/master/svc-i3c.h
new file mode 100644
index 0000000000000..26a3fbcdb6524
--- /dev/null
+++ b/drivers/i3c/master/svc-i3c.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef SVC_I3C_H
+#define SVC_I3C_H
+
+int svc_i3c_master_probe(struct platform_device *pdev);
+void svc_i3c_master_remove(struct platform_device *pdev);
+int svc_i3c_master_runtime_suspend(struct device *dev);
+int svc_i3c_master_runtime_resume(struct device *dev);
+
+#endif
+
-- 
2.34.1


