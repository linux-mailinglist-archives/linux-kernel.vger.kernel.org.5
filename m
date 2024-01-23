Return-Path: <linux-kernel+bounces-36071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B0A839B19
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6691F2215D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF824A987;
	Tue, 23 Jan 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EkzwOybG"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650248CCC;
	Tue, 23 Jan 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045187; cv=fail; b=uI0kRzUXSNJt/Ut1G4lsQj1wD1a+WxEQ3UnavtMgumGdiJ6jnWwjjEWOvTfkEWKRNorRKfFMaKiEKFCEe/hGoos5BQKXk8sktuxteViRP+0NUij+nTVIceYsfOKqaoxDn5qXq+MPd9by+SzogvX+kroeZSZM+vi9w0RJRuAjbpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045187; c=relaxed/simple;
	bh=CD5kjo9+4Dx/aNyWiQdbwnyptasEeCwpH/xSHn2yLWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dFCR6bJjyb10jv5zSDJjRXoknPa3uh2/Dn2I58j119uhPK3nM+P/81yx0KPanqUM1mxcO/imG5RmvVfaTCoQKKODAt/iJxlLQNaPMZzJnW19gucUIQirIj1nY9t3t6cnAlzr/bac0zzp4Hb9kCg0mCaP5yMDv8Q1eDlQliiR3OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EkzwOybG; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i246Bp9P+i6wjtJYxcTV4qJw0gkdqUWtV5QZSI0fI0x9Mv7DRwvchV68FMGI74e/8O8+Rngyt0lz15eenb6wMw4ChGoygHdgfwT0ELsCOp7EGg+LL8PLh/7xzauztdmS48HzzxR2DQ25CnnyS3QkTbmXa0OiieO8cZM0VqLK+fZXugrTX7+k4pKvigznaj7uLCE9hBtkHkkOdK15JyYk8hWL3duiMuHHjj4LqcO2A0OaXFm59KbeI4QdxV0HUYwe9mZjuGajX0f/Kr0IcVkHhqX3NodFZZS1t6XIkmhP6dOUq9j+P6aobfPyZEVCBU5JdMjgBAHXiuEmf/zjDr51/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9UN7ujkdLSFL/UqlRYdVA1+ucq1lYc5jQjhqBg1C2g=;
 b=KFYgberhGSryqk7ITjLuSwqos3QnaHRXiArAej2o92nkw7T7lTLo6eqy7HHxu9yZCOPnEx+qTAaXAEgjpJ2Gh66YFLR+4BDjALefGycjZF7d90hk7C30nAwwru9cU66n3kIugeDgCbRphL7234hul7pPWsKj1eApnfH0DtsuoqbtMHVD1+nYxGHaJfRNQq1zg14hWZdQ80xc87qdoQEZcZUe7ZY19LUmWMvUGJfjLXZNBxoQvgDGGab7hyyHOhYQhVsbqSGncVWjav36akaXClJ4KIPQX1NJ+4EB4GHXYcwJsn2WSx+XxZH1ruohFJOKwKv4YghxLD4TVNMjgIb6Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9UN7ujkdLSFL/UqlRYdVA1+ucq1lYc5jQjhqBg1C2g=;
 b=EkzwOybGhB32rwYzMcIj9CujA++ABL/xh97KygpnXjUYKwc+kHrWnwflbOcyenTwBHKLzTPAXYWkzeEUbZp54Sibchyx1Bqejl4p4qBJHktXAjqgLjOKbOMntfp7LSwhg5lL9I18uwPDr8+l0405PnHAt6ksft9YSa7CkIJxAYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7616.eurprd04.prod.outlook.com (2603:10a6:102:e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Tue, 23 Jan
 2024 21:26:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 21:26:22 +0000
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
Subject: [PATCH v3 4/8] i3c: svc: Add svc-i3c-main.c and svc-i3c.h
Date: Tue, 23 Jan 2024 16:25:45 -0500
Message-Id: <20240123212549.3858137-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123212549.3858137-1-Frank.Li@nxp.com>
References: <20240123212549.3858137-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 18667996-3c9b-490a-08fd-08dc1c59f292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7OcpZ/9lVj4mLLw/ZhdNnpwRlyHUBl6EapFmfGOtTKS65ewXwgKNEvdw6+sXxbhMeDZIiSNRr9EsUUyvwXR1wkeGtHnxHuwcq4/idcuM01WRGbsybi9C6nzFxyXpvyYxAfOSACgUzzZVnfY1HXvfRo3TvUbO4SB76LG6bh/BeFbrVZ7fTnz6o80SVg6fQvcWq3/F/JBAqKjdrFJCz+FYb4oUbCMqZitefGbTlbRkY3YylYeqXcU7c6XIGb6bnLmWnPTLDSYKDPd4wG9b9ykBBsocs5FS1vQ70XAlUvSRe4i1fp/wmxYEorfaRakzpGBHga+fcVCkzSd+gbBTKWPOd1s6law66Ljtv40m8WOWWd5XPh8EnwlyCdJ7BlQsls3RRffSGPhB2uDLfvRa7NjJCBQ8Vkd5uZCK8ClQRjSXDI09Atj9pdx+3mZMxapOG95+FZH+m3Xz96+HvFa+1txZyjnoDP5MYTJQquFCVsapxgROZSDtt+PnoS0q/DNNeynGAaxEM4WuUBKZfUwCV9bznqeMZNM+Hv/fXQ2AOnaSKgNxXNG6wBqMkqJpT1ir3FdcPM+uHsZM0LW4HFnQPS9WOvkekeBExuTXxdD0Vbb6/b1SrhF4FQSEpE1BLWXmegGa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(1076003)(26005)(2616005)(478600001)(52116002)(6666004)(6506007)(6512007)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(6486002)(4326008)(8676002)(37006003)(34206002)(66946007)(66476007)(66556008)(316002)(8936002)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zgb+PR+8n5qZVBrvgqrFDAV5OLoRhhyhTYX8INnawenKKkY/trF414W2QCpH?=
 =?us-ascii?Q?ePTIUbUaUZdb7WVxH0nn+hlOTqar6cWt0tHkl9Txfw/O6vp+IMV6nJ23Ijtw?=
 =?us-ascii?Q?Wu9HviZhwc/gQ4HHelbsEFJobSW8dCSZPYljib0zSpXI1UCcI56gUAaULz2t?=
 =?us-ascii?Q?uwp1sFkiNH8XvJrkrTBfR+y5W0god/vSzKjW9IUqyUc5IpqP8ZAfoeKvPiIM?=
 =?us-ascii?Q?PpywMwBgwvdl4X0alYsgDeOCqiwWG2Zz0mljEKG8k+B36TAkaGpziP6RkVXc?=
 =?us-ascii?Q?RQCgMwv+cr77+TVHX3lARFlNkV/i3CtWpUKA5Y7HWX24JTg1ZDUsAAJoizFS?=
 =?us-ascii?Q?CUdh7JzhoBMlBTdV/JZWE3l6t1dU/6D2HnkfYw5IsrIKGnooSMY6BwjOXQ/5?=
 =?us-ascii?Q?awF7g2QbRO5zDSRISQalMwzWx/V+ryhpYQ/9NFT3NNAsBdfNOWCuPylTffuZ?=
 =?us-ascii?Q?Mkl4TQH3HO1x/LXb/2tb3slYbwjnxze9cx5EmJ+yykcOuv/KaVA7VEaOkPLw?=
 =?us-ascii?Q?JOjuItYCcLtVN7OQBCACtI7qRnKU0HlbzzKP9B/w64pqo8YECbPJnJCoJASZ?=
 =?us-ascii?Q?2jIVCr0f1LK96yv/czD2zA8dU9IxMtfmo3ZLDjIjU7tA/250WU/xaF56Rbj+?=
 =?us-ascii?Q?VrA4vsQEmmqGuogq5aQ23jZVl2rEIUY/iSPZlf+MWfJQwDpNk8De1vjwgbc8?=
 =?us-ascii?Q?KW9eP29+U+xTP42VP+5UsxoCQxTWcejVHZvEjdKKjn+Z8trOMpvRxg8n9N+H?=
 =?us-ascii?Q?Ow43rYYQXcPMobD3u7XBnUfyEf+M5EQp+G5hjK5EGKr602OIB/8Ltpy1eAqh?=
 =?us-ascii?Q?71+XLrypGTZkJP1wDzJ2rNcqFXl4iog2oVsgy/HifwGFKnznXijerA+05eSK?=
 =?us-ascii?Q?RRcMSrN3ydy2tSk17FInr8egZP6llreAC/YMBNGFP418/TBASfJzQ9OCtMgt?=
 =?us-ascii?Q?5EmZNFLpkQBp8tc3scrJ7q1zg/fpSKRtKXhwPBQqEce1jGI+5Cn0feMNNQSJ?=
 =?us-ascii?Q?IMRqzA/R8VV9xwlVoCDbw4iwwnhM6pavXK/3fP6pvtzjjfcggwo7qP006y6o?=
 =?us-ascii?Q?IkcVoO6qXDOM2sduqpyg2+mnyov1hqwUFlassk1TmTA7H40eVZLiwudk//ed?=
 =?us-ascii?Q?jgU/0Ijyl/V3tu5z/6DI+PscaxOaRWhjuYGrXjBz0yaRAevMo+2vYz2I8e56?=
 =?us-ascii?Q?3JdX03Wm9271QtHkQ9Ngupl8KA0sFbon23QAAifZyAP+wGLLy/h/YtHi5TTQ?=
 =?us-ascii?Q?KUluTRX+CvnimjQV+Sf4+A2mGYEXcHcVviShGKO06AX3Se4ioFxrAlhgHq/M?=
 =?us-ascii?Q?lLp90a5EFqteFtmYxdJJ52N3jsUfvWEPbX4qSf14IbOFloT2QvyCIqv3wA4t?=
 =?us-ascii?Q?J4hVeCO8xgJIUXjKae7/mpDEYWoG7yC0nsVyP+FyKrK8UfyA8OACnnRzHfX6?=
 =?us-ascii?Q?HJQARSoqb7Xaoebgf36HiuNjAwgMqkT5Gi2xI036Bd5mKJOnj6bkaGGFdePg?=
 =?us-ascii?Q?+Z4SNx/uEinbjqxGouxY+Wvu0WXtujpuK8QYrVjoFd1jGQfT/f5oW7TAJ+kW?=
 =?us-ascii?Q?0ANl4D/kHoxZLvQQFE4DCs/Vi0oB4hV0VK7jTuDm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18667996-3c9b-490a-08fd-08dc1c59f292
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 21:26:22.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrCDO8wROH2X6hQ6lTUX0RUiBZchmr7rHOD8R1u914QLgyv0cMFeWbOhE1EpGKLDpiYoPIQg5NO0itVkOyyctg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7616

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


