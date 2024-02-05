Return-Path: <linux-kernel+bounces-54092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10DF84AA9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF6B291995
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9BB4F60C;
	Mon,  5 Feb 2024 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e/g1qCao"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D24BAA7;
	Mon,  5 Feb 2024 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176044; cv=fail; b=hOWGNP1QIXLIN60utdhWkxeuOYg11KDaXV9zDecbwRUs1iyoA+AignuY6WX5vzu6dpDRyZddNDYIqqfBKfKy9iJl/gCB3CcstB3v3e0DbDKG7tJQ8WTtY8QHRQmqf1BiPtExRMo97OvGBM/1eQXQilL9/NEXtLDUYy6zjY9In3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176044; c=relaxed/simple;
	bh=0j3fzm05aohiIuZdZuSFtfkw1tdXAOH16fzdMqTQGZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ox7ERJLOeObe3An+zerDUN2TBVsfGkCzxqpPSjm+Ziv3gPqZhoppuJuPnzQY45gHlyRG4ZaMlCBiHHKgzza8r7kI84t29c5kwTHKyBVOexSHKg0AfdLyphORWXBtWGVVEy7QlYFEskcMEWRDnVUluv3GkrUP7vKi+43zHK393C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=e/g1qCao; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7fbQaqNr7tPngiML27uwkprDTJLeZo/Pxl3OKLx+/7frZikQxyK9B/51sLI/1itPotKS3jFP4IS/kvgPP9oPsLNd7fGMuL0MTVTcLBBx4q9nNuM+Y5kLbiN2PCzIMPmttlDembJ7D0qgo3cLJbwaqMIC/vyOfKWa9CWauDQkyG294kL3UtgYj7nliXpchsyIMvMc2e3mZFM5ottg8d37y1jG2oSZ0zWejbapLptyuSfzXNe7zj0RyVDUa8pxH3ToRFyEoj/tC/MQBizpMCvf2GQhqwZkqRrLn8ZLgZ0AWzseSEWB4A/TaO1LIM95+US3aA/MUThqfDS9fy47cBN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weZJEbDsJ4Sl/mO/kzAmO46dRq4XMRwLtJczW+bxKko=;
 b=ijUBrKdNGkLEAs7HpOT0y1mkSRZKlgrgU3aQ+yT6sD59c3JsKwoomNdN9m71HfLF0leyIwk54wiHtggG15ULcsinzFF/lhgFw3FFeR5+ah3TXjuABeR/HQPzmC/sNm9y6Qr4779+lMPJcWxy1bxOThSB0u/1w+EIpbHqxaM2flW2f3V3k1lYhtaKtEQuEpB+OFVGRuolUr0k6qrOaRrTMSJbDuisKWnCWj+c56UsGDNSQL/LgumELo71zB3YlOhSrKO9s2m/cIhvL7B4Kx0KcC7biRzyLN5avLZTs3LRTisD5nNbQ/5/W3GKDzvvQW3zdOUt4x0cEyRqxMPM5MJ5aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weZJEbDsJ4Sl/mO/kzAmO46dRq4XMRwLtJczW+bxKko=;
 b=e/g1qCaocQ86Rx+K4tK5wOXA9E1wFwI52z0pZfN+0LAKJa+ZQ09N4RrUPvxxSJSspxNmWNLw0Y/+RWEw61TggXxnhLz6j6YMd7BSb8TCXp+au5xi7rGJ2b60dxfOeK9Ff7QFbyF91CWfyIk4Y4wQYWlZAxm3zK2dbwXk+v9R1F0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9205.eurprd04.prod.outlook.com (2603:10a6:20b:44c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 23:33:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 23:33:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
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
Subject: [PATCH v7 4/8] i3c: svc: Add svc-i3c-main.c and svc-i3c.h
Date: Mon,  5 Feb 2024 18:33:22 -0500
Message-Id: <20240205233326.552576-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205233326.552576-1-Frank.Li@nxp.com>
References: <20240205233326.552576-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ac32a8-e0c7-4e9f-99aa-08dc26a2eda8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PQhK54Bk0KnzadNNCt0DyjluEWNyTCjSc7qhykwyhWUSHZc7cpGIOTWm+wgo5Fmb3u6G9bDGNTHWccMWtyX3ZZP0vKhsBUuZpZxz4I92SgVwcM/ePBbGizNathCkx2nO33XokEAReoAWuQnSdQyvrJIria1HudFVQLRBa2KKCvsbdA49lqxt2TtFkFy9F3gW9ftGS5Wzyeld3Jb97ZkMJMisHGGoHBlG+uPN0aSM4XDKJrmX0PNRzYKhK0067AjvGyohJlPpNT+4tPIzTCdHPlN7e+FHKCDOcFuq3HrACdEhsVrUu6YLKcUlhq0+RQY6nNuypmDWYh+ve935uU0Cc8TPu9rDmPQMMkdXpAqh5PeHvCxVmU1LuikSy0DQjG005fb//OISIr3PqtA88D4c9FO+Mn5sthethA3UDisP4bUVajJaM1cf29lDlW/EGkitoUO+d7rfH4CzYZDG3IpN8Epqp556oZrFEmOx7Zru0S7SqcA0yXBth2yi7rCa7xDbMC/GG2fLwDIIfyqNS9+wywImsphJROlc7iXVX/40LTHch3/57I/Bx5JUXzw7YzyflGSYqHzCa7EjZ3H6+YTK6rKtVAe0wTbGYml+x3dAKvQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(1076003)(2616005)(26005)(86362001)(41300700001)(7416002)(6486002)(5660300002)(2906002)(38350700005)(316002)(37006003)(66476007)(66556008)(66946007)(478600001)(8676002)(34206002)(4326008)(8936002)(36756003)(6512007)(6506007)(52116002)(6666004)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3HRJaV6QLl7DZXSPmUVTr5r4VNoBQdS+bU+0YKHoe9naVLc/uLWEN+fYqW5N?=
 =?us-ascii?Q?tmcAuw1VjYTkLNLZlizPzxXphaFg5t49kjIf4l4YZs7iR2sgnTtugampfeJl?=
 =?us-ascii?Q?xAX0KCjkpu27u28gleCas0Sm7F7N9HMZHski/W/etmnlM5L2fQXd69ldQFAU?=
 =?us-ascii?Q?jZB0ckFPxXz3MXm+O6kpzxDhMGyW4oiQVku72nu+1tYWdtl13pFquB756p7N?=
 =?us-ascii?Q?9KWKwG5oJsVw1TeRqquSKq6th2L2Gj6yZp5rRiF4zjPhCXfpH6lPr8EflOwO?=
 =?us-ascii?Q?KurE96OJNnW3dPRLbEb313UaS4wY6aLD7iK0HPFt2hh9Z0Jxe7siirFa0xSQ?=
 =?us-ascii?Q?VOQhyb+EzS94pitY9Hjbu60zlo9PjYL/B964pHdqkj7fyR7L6FYXwh9N+Lun?=
 =?us-ascii?Q?OlHV/CBwP9OgiO8DOuLKt0WlBm79XG4/wY/9nGZh2swucYsNYNeSN24WsZkK?=
 =?us-ascii?Q?grZ2eADC/F5RTu9KPcGKO26aahiX+unrFu7A/DsNsF8TcQS/FZQIoLXxuWzy?=
 =?us-ascii?Q?GFKClFdzLCHOqNfiDz/n+W9EQAm9dqRxFqZLHeE8P/kEos0CZoPK4Xl6MfBq?=
 =?us-ascii?Q?3kccMunOquYXJQVEEbCAduVTHP9AabOkaHpx+HIhaBv2tXMkbCr1kOPAEZbw?=
 =?us-ascii?Q?JKC0evtUdtGoi6lQd/JlP9r0NgqUJHPgZa0OmQUPsJXB8aV0e//nM/cWiAA7?=
 =?us-ascii?Q?onAorTJaXphsng1uVF3bUOS8+yrT8iD/bHGBFK3tedOuNZAdBg7VwxqPwo3W?=
 =?us-ascii?Q?H5Qk0fhQ+fTC2PvujigCYXE9ALH9xe/V5uvLZW6REXJ5svXlaFwzC42otJj9?=
 =?us-ascii?Q?rEQ08Ec2ibdDlByc0YwblWmgVfKVGQwFOtX1p3DZ2236Nnn5Uk8Fq81pgaTc?=
 =?us-ascii?Q?/8FK9bHJa82+M2Wh+VUwft825A3jGOUgwRS1n0sLam4GIGPThZmyGJYFrD/B?=
 =?us-ascii?Q?rOjylXlKRXWTvADp/MbIGJAOwYMBE10qlMqHeGZ9mTD1+TRNoaXnykwXcXuB?=
 =?us-ascii?Q?sw5dQS8zVJi8Oz4LrvIN07GS7YnCitNHtMQrBYM2Ca2Z9Jde/a+EJD/Tx0TY?=
 =?us-ascii?Q?RmO5k5gc++TyDvqiaYRznCCLe7sW4y65D1hIqTmVyMxnZu0rdL12TGC9ZopU?=
 =?us-ascii?Q?rwmreR5QNC3ai9oRlAro4Kv2S/K57P0guLotPkkF8zhYtD54emxOeNU03utB?=
 =?us-ascii?Q?bC7wrX6GUlfMuent8NaY/o0YLA9RFw27lzl8YUpVM9qhAH+y1rilySjXq82n?=
 =?us-ascii?Q?qa7VsNIRVZI/5vwoeG5+2YM84fED55u0OXg68CdR3qrAVNM1+my/HCqZB2sV?=
 =?us-ascii?Q?jFhr9qjp3C0nkvebfd9wAwhvl5veyaoY2yuoGFIPRTQN1frS+SlCJg9pHgBp?=
 =?us-ascii?Q?wB4RG2SdsGem93uzdINhyHOsbca2Cz8JuVkePDdlq56JFtRXpaSFIagXQmtR?=
 =?us-ascii?Q?Ysg/LxAmDc62xOo/qgt6Tk3DtqmfEZRWcKI+LvIDhZHNfgQgenqT1TDPWPvF?=
 =?us-ascii?Q?gz5GDItdvq5QWJhPTVBdQCcwgb400ER7THr3Uf4I0AXASayw80IfbbrvPXGm?=
 =?us-ascii?Q?xU+YNqJKMOcvt0x01s0LoCahMbzt6jhvG1os93U6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ac32a8-e0c7-4e9f-99aa-08dc26a2eda8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 23:33:59.7108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5+p2TeXtrx+w9mNE6CIZ9co1vLTfz4gthXrHmdjp1UhbtZIuqoTuvL5m0mlE017HiX6BJ4DyVmQScXqOJU/0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9205

SVC i3c is a dual role controller. Move probe() into svc-i3c-main.c. This
prepares to support target probe depending on dts "mode" settings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
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


