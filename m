Return-Path: <linux-kernel+bounces-97296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCB6876865
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0C7286218
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B25E5B5C3;
	Fri,  8 Mar 2024 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LL18mWgJ"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09085A792;
	Fri,  8 Mar 2024 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915181; cv=fail; b=L2qh0Xq377pB9XOcMwHpEirN1wVXhPzsh+Bv0peAidy3/rYJQkqpaZpiKR9ytLmQ0TSsp/kJmlhdm1iXsphcv2wnexWCbebAka48ZwE7WM1YYn6tT+kuzlZkYp3xvvi1z9ilvxqbTnaVQg4vLcC9+evcoTycAiYfQiZqVBl5Q/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915181; c=relaxed/simple;
	bh=9o+8BJFYB+lkE5T3D66G2dBqmc0RWmEpJSNjjla+8GE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PoUyI/JSpDL1djNSGBk0Af1VC5l4vY8dPACEsL1LOKz8QH7bmaEt8SiTe/Sh4z3S89cY5cans7czioaflgONA25xe3Cqv5ZjEjxrkBjbUTFFNbUBnwj1ROfVFOCXryS/gBSNjDg251pXxJsjs0sSUQ/aT9QGyVqA2QfTB469CUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LL18mWgJ; arc=fail smtp.client-ip=40.107.8.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy6qpkYEYwCNWQ7SCoCyAf9TtZs177MyLaxpiBh57syjGP26ScAeGNr8U9CBKOaNoOUpF3VjrJRWX1Gpo9pOSKb0LdmummN1AZko0oN90pAh5UWZqfx2utAh4ouD61gPnxH6epvY4gy2uxvA1yaicEbvXDZ5gmeiXPYex51HMKut4jbZat2u+sTRdCmuvXo1krJucLkAkNshDR8koX6+r9ulcvw0sdbBNQ3avVv2w0oxo4f7HsFGYl5xKNEm5WRRGyCNNG8mNJntr/P8Lt+hEwlV6XNM3S2WMCzPW/Za4snfSQbj5k07OHQJ+JWOx508Fs6CRlqwW51jCe4KJQaszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7elnKms9bN2UvdqPduv8ieP3RqEecL0JMfDSwMzlNWE=;
 b=Gg728gcgk5dB4zIey29nQ0c9vgE3G5TVjzua0FfwQP8yhun+1YDPQvBvykNObqjZa7/zjlPdIhp88M3S3ThGIaQwmIIPLuWX1DHenW45gK59ZAcWIh0XW9FIGTMWiLZ1yeIesRsl8oZbx7Uf57vYlyx3lje6TIRk6qxNk2eqroj9BOJw8kgm2iaELFHpyhAAtfpT1Cg7XOLn7nyDCOAa2waq9XhHFbrmMfw/WE3ebN1atpw5X8kg3CYY4KqLCXS4kn/0I9rDeQv1iZUMK7RazcNmFctObVz0/b2LpLSmAGPFtLRVIruFqVpnge5vgCXep9+S+mctOl5xLWwJXA8YQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7elnKms9bN2UvdqPduv8ieP3RqEecL0JMfDSwMzlNWE=;
 b=LL18mWgJX+8QTmnakkuU14v6SzibEiuancZTpODbP0MEOhZ3Et30m/Vrzpouv8q8pckZ+Up0Xtft3RCaG+lIWB2rndgFKRomucCA7jszP/xouWNneea02SbUrofnLzo0li/a10b40QZOQtv8PnY4UUnZqnOmh3U+ZurjtSsvv1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 16:26:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 16:26:16 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	alexandre.belloni@bootlin.com
Cc: conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
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
Subject: [PATCH v9 4/8] i3c: svc: Add svc-i3c-main.c and svc-i3c.h
Date: Fri,  8 Mar 2024 11:25:14 -0500
Message-Id: <20240308162518.1615468-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308162518.1615468-1-Frank.Li@nxp.com>
References: <20240308162518.1615468-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: de99c49c-1bf0-494e-7a53-08dc3f8c7a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GS5Lq1eDjuW+rdEpgDk5jdaBfX2vc2Gy0vssLePZj/LxOLcZt3o/cuylTXhqaYtm4wAVlt1w3X1y5F4z5SCkJduFNQu+KSnwm/y0bbV7QC1g36pYK2fxObHFU/X473tpXDOXgZnEAXJUnoAFOrakPvobPixAmLFYilMqnhXhTIXjTVT/rxvzBC0FSNx+mrvt5DOFhNrTgGM202sOgM02T9+wGJ77rNEMgLph6bJuAY6yowEdAOunmHo8ARx8YiCR6uPB6/n44n4ljJpJcgua2s1wDsF6miEJwPEFtAm308iXOYqHVvqRpYOdb2vX5E/Y/B77fcSsdCa5fmIMuFsvR8zXXQ32UJSfQqLQng3YsjHwiLtiT0AU+m0J0/bzaBG9YuwufF3aZeXrlXn8mABFBh1AglQAeqCCQ4f2Dgs455yUQE9wQXZ7AsyDavyFnlL/IAl9bDkCiHJ/AzYn0uTt9j9DKUt652CSARgbNy32uQLzQlUhO8EzrPzcje/b4QMXfGUe70Cj4+MtPmbkdzNrQSC8qPbOu4kWIaLqo+Rr8MA6IInfM3W3zTSv1gnh8rl2jTSOEjN2Hyc7nt87ihfCUbeBOwJe2C7XtviCimzockkYtvd327NGPyZyJ86Hy/C7ySoLl9a/fRv743Bkwpo/0oijpPsgFXAhLcEoQXnAJvSAOPDjVrnuPZm19rxJUr1p0sB73Hf9Z+dY1FwNQO6EkQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YkBPKFqPGf8cN5Tb53PPT7NIPBEJA9wIVSYu6ED191hfjv8bh3YBvA/0AeLT?=
 =?us-ascii?Q?VgCIlyT80DUzxG/HWOba6SkAHgl/LBdFgXtCJiqKJVIp2nZG3vuySHuI9nCA?=
 =?us-ascii?Q?FHQ7+se2pFt7+OJMKYiaEJ4B8bCax3O96fHmfrkqeJjOzn6hF3jZ0ANmN0Mk?=
 =?us-ascii?Q?WMrtLNPPk7np8zKf5xbzth7ZcWleuClJ6hxoSOYMIChoHpUVJy//zhQtIgoZ?=
 =?us-ascii?Q?sgmkO6wq1vt2tAKsoXonTrLNeYr6QFsAtdUXfy7tP4b9R8BOvtXgMYPvReSL?=
 =?us-ascii?Q?b2qcmlKLXw3kobrB7wuby7K8QRnUqqxEIB+nM139DdSb4mFu5BKMELXfBzcd?=
 =?us-ascii?Q?h9daPnRQ4FsTh+D1VwGauk8PgsXEASmf8WajCR8zI3fzgQBbN+Z7A2skhdi/?=
 =?us-ascii?Q?wXxrDPhAXjFUSLGrkEhjaio0ULbnJjLyGy8kzQpvYiB+eGoE37fJ43J08sXk?=
 =?us-ascii?Q?ExpbTlsD/7RgBvHxuLSYvjBi4mnPN7eNx7J13cY3BMIEOh0SAplNIL+RTbrP?=
 =?us-ascii?Q?TLdSweQGeHBhNi6H+aNlatmGsmaN2YiohUYff2YoGu6APnIYZPp+zGneZqUL?=
 =?us-ascii?Q?KZ+Xsdxoa3XuvDbl6JJEIH7QrToStRP9lz/H5NSQszjS4pJnawaTqJ6Iy6a4?=
 =?us-ascii?Q?VXzkNOsaMgM5KTm3qLHE5ihchPy/joeUdkv3tVC4sMx3H8nW3Ft8QRXLF1j/?=
 =?us-ascii?Q?0g5eM/J+GiXfBJqmcSNfyhTW+WPtgj2aNSVIaNy8qI7yIfvxo6xupHvVQo+m?=
 =?us-ascii?Q?Z6MEV5yiWgH46iuVfigb1PQeBOaoLv+tISn/d7fcvq4YnWFOevBj5yuZUzeY?=
 =?us-ascii?Q?wzrqnYPJH7wWbVOjE8kgVDIIGiOoRmqp2Yz6GENdtY54eqA/iCWw0jW1etoU?=
 =?us-ascii?Q?suUXTqKwbOdzFkmqrB72iyfedgaR+f1Q9iqJ0sJl5WJ5hjOhlFldb46nzJJb?=
 =?us-ascii?Q?L80fIdt1X8XoyEcdMabd8VkunsypQWKL9GiVugymb+02R9/epJ7o9JTtyoVJ?=
 =?us-ascii?Q?kxlRPte6Mts0ouZhOBYAh40xTVY+H7I5vCo/JoZFgqeFeNKZVGTOLxeLmey+?=
 =?us-ascii?Q?uNlamcGIMKR2VtU1aR+i4MJBJ7A7acnqN0D5C9EKN7KhKQIwmAArJlM7LLbN?=
 =?us-ascii?Q?qYdjbspgqobwVsXaFABFQNl/5hiF4lGeO2AVMx50lyMvlYo51nYpzQpWXZtd?=
 =?us-ascii?Q?YvQHhXvkjWKopVpF6hSPa7p96nnOyROyAnb5JHIwVmnpRlmZk7+I4hWI0898?=
 =?us-ascii?Q?2xt/I4unMaN1w5RH6RJsDcKvEwaTOpNH737zXLQ4jt7gMuYZhkjUbEVUN3vD?=
 =?us-ascii?Q?cfxdYIgxcyss9fGuNy6BS4iPESbzIqaEitqJmg1n5nvRSaDCzsnF1Y/6VBNz?=
 =?us-ascii?Q?wQnCSYHWyjSZs3ofvM9e1d5Eo1sCW06dQhjA11p0X1JAtFnq2aHosO4ge0wu?=
 =?us-ascii?Q?UVcYoU9PKUxMXWKGQb5MmER90DNFRg/YyCAUEcgWP37DkDClRTo8zXH0guYl?=
 =?us-ascii?Q?RZBGVXzXXnGMsg8/Pxlo+4lVLlpxxrVXOo0QWdp6obtIiLQ+4Lhxd5wMBEBk?=
 =?us-ascii?Q?dicqPJTwDTRJ7Ujwbk0bYGS2ncAFmqde56jog6Qa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de99c49c-1bf0-494e-7a53-08dc3f8c7a40
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:26:16.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgBT2RizSr9Pld39RJ+ftuapLqFvrPTIQoYpG3adajYdIDcJDq866xPCFgwAMNe4JQ9TViHryYkPQD9vdv9vYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864

SVC i3c is a dual role controller. Move probe() into svc-i3c-main.c. This
prepares to support target probe depending on dts "mode" settings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v9
    -none
    Change from v6 to v7
    - using /* SPDX-License-Identifier */ for svc-i3c.h
    Change from v5 to v6
    - none
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
index 0000000000000..b9e1dce4b2109
--- /dev/null
+++ b/drivers/i3c/master/svc-i3c.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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


