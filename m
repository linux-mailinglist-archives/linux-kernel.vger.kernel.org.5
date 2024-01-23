Return-Path: <linux-kernel+bounces-36173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A8E839D03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341021F2517B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266215A794;
	Tue, 23 Jan 2024 23:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OGfAuDTF"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8EE55E57;
	Tue, 23 Jan 2024 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051481; cv=fail; b=qUruv1Vanbhrhd+a2H1vzi/ZtXMK8C4lywT2YaKCr6ekWo2hlgzjLxIWcIHjgkqg97EQB/2UXhRDwSBPl/ofpKydN9UGDL1gEzH5YastpUGyRxESDyevsQ5yfc3z2V+d89VSybPZnWA8Q4ryrTR2bonNy837rQAD7z2v1y/FCiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051481; c=relaxed/simple;
	bh=CD5kjo9+4Dx/aNyWiQdbwnyptasEeCwpH/xSHn2yLWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DvUU5V+pLgShWW/ugYwSgJ18Kl3iCqTUprsSDVrkTcAYPBl9UwNNgxNrTRHGDsFxrCl4m92Bbw3YI2gYSHWhdK4x2xqaYiz3uUWEXbG1xGz1hfgnFaOfD2Zf7i3UEVleWZb9ZK8e1RgEtkq+qc9pan0eVZfNrPhggz2TmfZ2sac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OGfAuDTF; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXxEN3SROqdxBDzPNpUegTjI6CdXdBheZuI9i+FYhbdizQbn/cUA2ph3Jcs/NIn5t/u2NOFDwrlK/FVUhhOQYSR6P65jdoGFPVNozhSy6uk/JX6uDDnky/q7SrVJ8s5F0eQHAbTIwqhEmYaJZHaIOLGdvC8nXAhDVw7jZrZU2NgAlITMJMYWpxIfzJk0jpntwa7shBZnV1yrWUYfhe3rtGkPN886CdFAgaodUv1wztaPerMR0ZYiluoaK/zqmQ/1XoeoevkIUFdIWjNS3x78eDCmI66zyydew6+HiLUMNaEJQQsULR+qXl36aX4V9Xjhqhmj/sw1rGd1MGK2oKvaHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9UN7ujkdLSFL/UqlRYdVA1+ucq1lYc5jQjhqBg1C2g=;
 b=h6Rc6wAR+kzaZgAkiU3oYh2Z9ngKPDEf6dYTX4vyeWmy7ug+r3rD+TyIZaMZUbQwqNg5kR1pKMa8oNYNWCmeeInP1jdY3ApDORCGczIOK84N+NittxIEMLcJtNtClZZolHiC+MdtwGFbdYevgawq32ZTlBpBuwtsZfBQ5FMobbKwsWxR7EhpUumjt+/VpcoUY1ZLQt5OrhF6+yKNkEwB674cwXpeGmGgzmVC6Tt83RXY+MbYg7CD4EM3FzHH0UxdY0eXpsN+3T3nis+YzbPuwuHlMXzN49RJJtxoOvaQKAE1w4y0I5zpazlLJgScv5T3kLw2XLveJnWf7Sqj9Dk7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9UN7ujkdLSFL/UqlRYdVA1+ucq1lYc5jQjhqBg1C2g=;
 b=OGfAuDTFF4zb4SivLSRPiEch5EmlHnd1pIePPB0sJPjQ1zhHpZzX1qDltRKA2wlzCqFayOHsPsirtRbh7/Ocifv4vSWMMx1Tkzz1FczLo6k5ZEzjdYPtlCXdiqqpTJtfLlFen9EJzJ1C8rdtss22N7dA3o+FfDWYySjztbPFTnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9475.eurprd04.prod.outlook.com (2603:10a6:10:367::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 23:11:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 23:11:16 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
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
Subject: [PATCH v4 4/8] i3c: svc: Add svc-i3c-main.c and svc-i3c.h
Date: Tue, 23 Jan 2024 18:10:39 -0500
Message-Id: <20240123231043.3891847-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123231043.3891847-1-Frank.Li@nxp.com>
References: <20240123231043.3891847-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 6171de60-6edd-4235-6059-08dc1c6899b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KEC8KBoV8pb9qz0paEdMr7k5/l7qUDhBM3eLXV8asSrq8m6dlxwlVDKhc/CsjvZaQVXu9jRP1c/X1la+sBGJfyohbM2RDNlG5mcGF5q2tSGItWvYIb6RAnPol3N2/RFjOJ252aH8PspHGpWV6tUi7EOtaCysJAikxoq4+E3Bili9DX6GooMawZh6OELCYeBl3yYOqeq+zMP0rNCJDTe2xN0XjPbueQBNADmZl2D4LbR7rtd+NdbA+EVxypaqYUwNh/7xA5FZw2VOVngNuC5mU95sm1x8uSh14pXg+NkmLeXTAg7VxhgO86pphJ5BKtOeM5qJyuDuNVsjlkSlnJElIq++snZIhvfMPSJ9QE+V2v+L/GJjXlKgs7yigo/bYulXUYKHLmGwktuQZK0dSeOkxo2xHPZlVWsifx7a1Mslf+AMwO7mv8a/H21uUynh5EzkLy6+vUQSfvBgOyl7+jPtEDbT1NJAxpjjyed2E/aYXlbLrztCjVf/EK5MXq2LYkpCkYytLA9nCDyW+TlRAfMCzOZUYS8csdxHewwNkV9ef2W4eP+i2MFUOXXyQx3VaJU6Fw55aB32ByMCgp7zATeCh1nZOxHISh346+vClGk5qCp87R2L3MjwR4tp0U0Td1Hw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(1076003)(83380400001)(66946007)(2616005)(26005)(6506007)(6512007)(38100700002)(478600001)(2906002)(8676002)(34206002)(8936002)(4326008)(7416002)(37006003)(52116002)(5660300002)(66476007)(6486002)(66556008)(316002)(6666004)(36756003)(38350700005)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RK0gNy4NOu0Dk4N7nZbiCxcF6qBe0oiKFexgxziQIhGa7R8Z/CiLQWKZb0Dc?=
 =?us-ascii?Q?vHIQMo6Q7rxJKo/QbugnjJsHPsuPthwvY1BrP1d8xwyve4sBeWHRCQMzsCH9?=
 =?us-ascii?Q?2P0ykjzdBTXqkDtcHsWAtuIN6Nv9FGCruNFXtB5lTjN2IgnAFuWSQRg1Gxaw?=
 =?us-ascii?Q?MtchGEtNPsVusegjPd6LsGFbz7HlvbaxUeNMmHmqJUBzTQNIKhf4/yWhIySR?=
 =?us-ascii?Q?8NTkVjof1wWzPXe5QGj06ajqTdEsegJRNtpQ6k5yKOPVHZB1NakSUWJU8bBW?=
 =?us-ascii?Q?0vSF9clfPS5D89ZrSi5hNgfNoDGwts0Jxt3+/F25XciQA9nEvUiWZD2DwtR5?=
 =?us-ascii?Q?LbHV/yY3IMrvIzSTMuijujoREFeJqFLlOO0QtBMp5qw0qs1ALhGd1VuUkhcJ?=
 =?us-ascii?Q?5N2N3JfbPxzbb1oNUA9hRGU2mRGM/p13UIFaDmHhxRFf3+N4b5ZSchkd5YI4?=
 =?us-ascii?Q?IQo9DgJd0Km8ugmmyMIQvvSlR+CZp0zLZowxPEyo/FlYjOg2A+XfYszehgh4?=
 =?us-ascii?Q?nKWpWtfq757Chpj79gjZRrip+P9bZj4Y+2iv1Fk9rTRqWrHk76WYM1nx8qP7?=
 =?us-ascii?Q?E2wZgZH5C6Mv9VTdgGiLG6H4Swt1mywr9rIGHCeh10KzLSuyKSSrnwRtgD6r?=
 =?us-ascii?Q?vtzyqkmA62s9uwrLmqfPBW933IAA3eKggzje7Por1HIzwSPFZDqhtkTlrMmL?=
 =?us-ascii?Q?AeWLpaSbNXXmQBmfPLj1i4oyzF/wuSi2TwKqhYgzbeb/E8TRApZYlJzbG18w?=
 =?us-ascii?Q?/Yt5NNFk/wNRVAe2GnXK323UTQe1ixwK7bF7+6lCwAXJSToyVOnD7JwRpx+U?=
 =?us-ascii?Q?R6FInwCQSls0IRAYu77FEnf9mPlRNs80awNcaq+cTCXlMsBTT/xsxu/RCeED?=
 =?us-ascii?Q?HNCURtmjWtKb4k82bkS12eNDHmBNiA02KaS47kjg+t0EhZ4eZN7cM0JhiEia?=
 =?us-ascii?Q?9fUZB1D3MifBNs4bGrOMyTH5c+Gfe6+gYtmC+zdAyucO4LcNCSaxPFQof/aF?=
 =?us-ascii?Q?TPxb6E/MPAHnFsAuArNTWqHWoljrdb3/G/zj1VlGAKM4n+qLSPt3JXFIY/iA?=
 =?us-ascii?Q?bwUA3Y+wuFgKnvDHpanEXXDiMJWZ0HNfzcn8nIxptS+gyGYElw7VZQTjn6sz?=
 =?us-ascii?Q?3nRaN9CijyxltFzMeBtJu6taR3oMGdhTmKc14UcDm52JMfu2cg6dzsZ6SwDp?=
 =?us-ascii?Q?xdRzQI9MciifNMGFbdTNo3Mn5YC63jtPTAW6GohgYFEpkp1quk+TgAfrZfrF?=
 =?us-ascii?Q?kB40p19wVpTa4LfnFKPRNgwX3xxMdnGktgatlp7JIbb8Vi+6afBT8642ro6U?=
 =?us-ascii?Q?afv5aLuvd6J8F1b5liI+T4sFpv0y+K6JbOfebn8I9msaqNO23sXSjKaqxPJf?=
 =?us-ascii?Q?DC9ScrpYUjQltXBH0Uk7NssR49b/oD9dAiD8d/Ryk1oDgQWX07HEvJLuR/Uz?=
 =?us-ascii?Q?SGsbc2n39Cwcw5w39FkICDbJIrelDujUI8R3d7JYASW03mpGGdXb6xZVTpkA?=
 =?us-ascii?Q?PHcW9oGAoO+r6pvOZPH9Xxb6L2LPechdf0xTWuptN3bYvmoG9C5k6AjiCxyu?=
 =?us-ascii?Q?ACrvNh5ZJffiG2ndhrBsixXouoDWN7hkvkjRV2Ln?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6171de60-6edd-4235-6059-08dc1c6899b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 23:11:16.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9y9kIW4xJxFgmWfKRBYwDesJmfLR9Lu65SZmdHr1IU5yVKwsfqEwUzoCAA3fsU7UDrxeafjFsEDp4lwlTWZZXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9475

SVC i3c is a dual role controller. Move probe() into svc-i3c-main.c. This
prepares to support target probe depending on dts "mode" settings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/Makefile         |  3 +-
 drivers/i3c/master/svc-i3c-main.c   | 52 +++++++++++++++++++++++++++++
 drivers/i3c/master/svc-i3c-master.c | 34 ++++---------------
 drivers/i3c/master/svc-i3c.h        | 11 ++++++
 4 files changed, 71 insertions(+), 29 deletions(-)
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
index 0000000000000..053b2bd9d8317
--- /dev/null
+++ b/drivers/i3c/master/svc-i3c-main.c
@@ -0,0 +1,52 @@
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
\ No newline at end of file
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
index 0000000000000..0bd1f0112a071
--- /dev/null
+++ b/drivers/i3c/master/svc-i3c.h
@@ -0,0 +1,11 @@
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
\ No newline at end of file
-- 
2.34.1


