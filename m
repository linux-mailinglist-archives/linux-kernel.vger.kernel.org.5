Return-Path: <linux-kernel+bounces-50697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF05847CFE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9635B28A0B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF0612F38F;
	Fri,  2 Feb 2024 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gi5lMXA+"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120FD12C80B;
	Fri,  2 Feb 2024 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915404; cv=fail; b=mHypP8UhF6GQIC0uO/HFtKoFw+39ueBsul0VZRSo2hWVUoxTQmK19jz+5wi6Nh9zlUVJZpCh35xNzSh0Qj6pCTitSqBtdSqvHJ2icydcfAz8r+zGl6lL8vdR/rjzBeq5zAM0FmuLmtnYkglPj/yCZUwKRCpbY85CVXINsHjHAVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915404; c=relaxed/simple;
	bh=or+397yWvEm61Xp5s78xEs1alVCqW+LonSzHmBaw9VM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uyirA6l2H24EmF5lzAujo6o875xTiGtYpVmqk8L1UeF/zFVKlsBCZRAhcgYREvNxtFthqR3peaw+2dXlqV6FoyDoUu0VedZUJ/TavC+2mfB1lMKLhV6bsAelha7BCSa9icihZ6+XUt+g6aoCGxTG2WV/asXfl0dNZ5rE4ye/V+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gi5lMXA+; arc=fail smtp.client-ip=40.107.105.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp8tV5PD9V80cLoH3AYZBcxcc0OgcxTQUPH9Sqc7wYqRuhfX32/hFgsB1QZnGiGsO/Ji+eRgF06cHZDG+0HjSUNyT/Vfo/NDFkP5os/A50KiL71UWdlLTgdtLPIowCkDkhBnPSMsY+Gm+dYfMtaGpdYRwDX5jk5JCzagPw25OFEU+kFuf+v5PN47wag1Ok4Xph5pTjNa2OsyTGT/fadLUBGDj0uhqDWwyKGie2GLCpFrY6u5KYVyDwejyuNpI4KdidhHXT3fxGDrHwr8yTXKwDGezxtQu2i0FT2/oJULsHYT7SGlM4iionWsqEca7ljJ6YeyGmIvnacsd0t39FCIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUFNo4LWNJOIgV/97UbyKVahyaF8RY8BcXYiK1q7NkA=;
 b=PKqB7jQyrUjsoTIPQUgfa3n5P1vfQ7kLQWVA4v6m9SQQ7sHltG9sw6AGYqCfS91BpnQ4crVppAnbjsK+VyNtVTRndqyCbO8qQdvfEKvoKW3Mb79nS29WJJ192xsTukURqAHNHPyuEgu0okAjFRLkRZ7aeTUqwAts5nceK6QcWaiDgNqg/1nAkV+7FkjaLA0bROGctxr55Ky0wUlQ11cs8QNTiC+pQaStnbbFZXY04cS34aQqFRMg7/zP9D4vJWbosSlTMaTaQ3Qbe5dBjcyjC5cOBW3dTfED2++dlMF1w5StFqzUjEtIkkNJiDrgWL7q/St8aXhJ5SHsR54Z0zc2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUFNo4LWNJOIgV/97UbyKVahyaF8RY8BcXYiK1q7NkA=;
 b=Gi5lMXA+uqmX+JnAEBODRUC5gOokdtQ2qEo6WeiQMDdDXGqlRFt5AokLPGLS4g5cLC6kjaCkncI6rY1STTSJt/rAKgmySC/EfIMw2l1YG6gmJ4kuMmro4Vdh7MHJ+t8bKGNpiFguuxITE9dWGQ1v2yo2uHfr+mFBEVunerFL3Ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9997.eurprd04.prod.outlook.com (2603:10a6:20b:67c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 23:09:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 23:09:59 +0000
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
Subject: [PATCH v6 4/8] i3c: svc: Add svc-i3c-main.c and svc-i3c.h
Date: Fri,  2 Feb 2024 18:09:21 -0500
Message-Id: <20240202230925.1000659-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202230925.1000659-1-Frank.Li@nxp.com>
References: <20240202230925.1000659-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:a03:100::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9997:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb3ef9a-ce89-4084-7424-08dc24441416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ANBobcw42qMiuy94KW/spO4/W2XK4T70vnt3s9YvcinVZK3ToBa7hFnKSQmEEXLMD0Oq3WHpko2MgMT3zSLDvfYp0WvrGGBNY2oL8tIDwdXEHOCRFIY4O3MPJELuc2eF5Gu6K9gJGkEOce+0eay3XSmJPm5togpF2a23OW/EQPpT724bkus+/+vXEtEkd9NagI7aF92aUird9a82XV8wc9b61IWW9l3HhF3/SUQ2PM6sbtEpoaKybxvTLumY9qQaWfBCcsjgzClnLcx5jhGtBxx1xQM+i1SJyC/uKTIr8gPvfb6vb0zwQozkd/SeQY24V06EHrEKJVWh4MTfC2AGHLaFJgxLS281H7D7MvX1wYZkh3iPjGihr6D6R0AHDqb1BBOWX9Ui+3OKlGZCR+20H3K3iNhsiFg6liMQ7CuKVz+LQSadxqx+xetKVERRYd6q1VKMtZ5mUI53Dv4AKVWi32mMa+5VWphN5v4723/gsUAT+QvPFbTkQJa9Kk9Tbwv1C6SoRaoeHlqOutUHE7NsqXInJ2MugHHKIcWaWhZ+t9n41XZZDZOUFbMjiYqSAgrfXeUgVyDB8e/wNJPLMEGfRsIUsXDUP527XmDouAUtOUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2616005)(1076003)(41300700001)(26005)(38350700005)(52116002)(7416002)(6512007)(316002)(36756003)(37006003)(6506007)(83380400001)(6666004)(478600001)(66556008)(38100700002)(66476007)(4326008)(6486002)(2906002)(86362001)(66946007)(8936002)(8676002)(34206002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lEhn+53bm9Mf3USCKAQ4whVSZaqqjkty+8txrf1Y+UMyAD706gUmJRaZzt8j?=
 =?us-ascii?Q?S9ZgeFVGM6aKtk+IBeh1isclhMr7+K7n0pl/ZLxej3XTv0W/NOuRn9wOcD5x?=
 =?us-ascii?Q?bXMNO+H1Gs5j2xidJ5hnZjS6zF5mOJI5PuXkJgw2Lu63YLCAUBEmZoD5vKp1?=
 =?us-ascii?Q?TFbmFTLbYVRcaGyjRfNEJaymWW4ciY0fqaxTxcqhigRUHjtW6gmhar7Z+PoB?=
 =?us-ascii?Q?w4etxyX0bNJF2MH7IOeE1EICRZquC1ROupZaVpzFnVrJbr/GLk/bQX0Xkcij?=
 =?us-ascii?Q?/YKEM2ao1MI2p828oOK+Cf68ENXVaX/DdF9fpmGUoDpL1LDafHyIJPu+s0Cv?=
 =?us-ascii?Q?O/PJXorIawDDp+EmF8NY+VshlqQyuTjvz8Zvdrmj3xLCVXeV4xbuQwsFtRfY?=
 =?us-ascii?Q?otqMmUaKgagoSPTtPdm1+p0SYO2gQDozytGDqZ7KFB7+c1S3ckH4zbnCDRqx?=
 =?us-ascii?Q?K7vHE+qAjls0CCCopu2/lk1ZQX7XuYXYJ2O9FQw8nGMFjpJYR8zH8h3sBOPb?=
 =?us-ascii?Q?CIhpq4nTSN9gPz9G9n3QZVGUAjokiJH8/AGE619j1qibCtjrwofKtLIGyjNs?=
 =?us-ascii?Q?TndrDQCwSE69/U2Zw9cs2hoRnhe91Vv52S8sj2g+Yr1UNklzwSopVzQIrCYM?=
 =?us-ascii?Q?1U0NsCyZXC4Y13oX8ijjMV1EoF1B2YtDNT37RBhA1XRQLsO7PDZpjVxFStX7?=
 =?us-ascii?Q?LsTeAvRKUrO7QhKtQI/6ccVgoUSqXgkiB/xDcEcwE55iWhT9GUM50ue2GCZU?=
 =?us-ascii?Q?VeJ1opF+AVav1YtVLtfTn4vC7KiejxsQPgiMrv91xaIYzyV3xike81ER2E/y?=
 =?us-ascii?Q?7NV2lyCEf4Pf9E80MDbXIK1eUEaNrxj9UbBth7Li/AJEshQmofcIynCO0Djh?=
 =?us-ascii?Q?DMAkRxu0rAat6YOHo2UBH9yUsFP0/hZRh7L+TwmD+i/vT48OQLlTB8qezNdU?=
 =?us-ascii?Q?aZqdz3rhr+1gcJQ8WySW6WfEUmJbfKOM8igwqbzmvv00jskLPhiKAMYO1yY8?=
 =?us-ascii?Q?JYyecBcxQHOtQ8DYYw8naeZ1isr7mMb8nogvyG9d/SG+eFdS+9i9ifcJag5w?=
 =?us-ascii?Q?4iD0zDH5qA1rxO7tqglRx6yCPqWkOztqtQW5F1IEIXxhtxLGKc43YfIquogV?=
 =?us-ascii?Q?BDJzEXdsiEbkfs4ASPLpQHw6QaR4Nwq1y3QU2bQECR8GWNGKbmuSPOu79v5Y?=
 =?us-ascii?Q?jemyprRMkdXPLi+BOrf0lkhT706Uw3uifiQtQ/dVMxoYe5QQGbSOyFsbV2Fk?=
 =?us-ascii?Q?LF9dQM6Muoc3N4kva8J7YbUAAF+DfpJH1weR5gQ/I50e5I0AG7lVPlXpJD7H?=
 =?us-ascii?Q?L+hxIjNw47sT+TVA72Twp8gX9ZMCJo68YPAMbD+CmSUmlkLBKHhK5UBHLek4?=
 =?us-ascii?Q?7CCuN64BDFx1D6Qn+V5sSxEFCakcHaX90CcowqqmxcMWDVOmKOxc+NzfL1OG?=
 =?us-ascii?Q?ZHNCu/xzb56WALDbJEvta9IelSuvbYFs6oUohSKK4lgmKlPQZyS3m36JDyBE?=
 =?us-ascii?Q?bMq8RrJk0DfkSWzuAASIOkDSXIQviWxu5fSkvFAIqdV62VDUBCSx3giHzIPj?=
 =?us-ascii?Q?U5JCsraU8l+OWrJrm14s98BKjX7tJCzVMuDPcpH1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb3ef9a-ce89-4084-7424-08dc24441416
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 23:09:59.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lz2qvVZ20o9b+ijGAR3ISryzulqwv5oqTUqKMys3+M0D8ezxr95DOWTvZoWbWjEOeIzmse9VFrnlpJfLWAFTRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9997

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


