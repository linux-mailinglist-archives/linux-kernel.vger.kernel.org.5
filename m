Return-Path: <linux-kernel+bounces-58395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA4C84E5EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8011C266D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B5F84FB4;
	Thu,  8 Feb 2024 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ORXgumF6"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2057.outbound.protection.outlook.com [40.107.103.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C75B83CBA;
	Thu,  8 Feb 2024 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411717; cv=fail; b=lq/qxUNtyk3MGjyOH5OQgpUvvvdeonbDNy8XpNBNiNXBUAU/GA8IBd0VUfSc5FbSS5Q/vMEljdIaseb6WNeAvXenXaxp3OgxHsnYn2iJ8ab6z4XGs1ugVfmnSyyMct51VxlZBqAKW4o+mrbcPYNkxx+Qbkm0ARv5b7EAGkH16e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411717; c=relaxed/simple;
	bh=0j3fzm05aohiIuZdZuSFtfkw1tdXAOH16fzdMqTQGZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCbjCSSOlyfudwKxmY8luNS7W+AFS52oynGUsVisHdvtQJB326W8ti644WevkTYscf6MAWYpqoUtXHgc8kdCQkten0oOffIg/1++HbZvK6eSD13SHjyA4D0OfaNnfUpZtT8uwPggqNEwhIglsIfNrLaF43pE0phd//ZzeLKDBdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ORXgumF6; arc=fail smtp.client-ip=40.107.103.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkLOQ3LhKX9GTlANxd6YojrLhXyMsYiiTfFmwTu9JQE4Q+oQ/DSuIc6HcEjD7RidrqiiyLuYymmjCIgv8q+AA87dJI8teRv4vf/iHTYAsKvHcmxdT7NPGebVeqi5inkt+bEXvs9DwwapRJW5p4Sn4HRRLFT1WUFscHzHJHqbNEpJ/WCHQgpNThjOBfExHpN0kp3VyIO2pGnTpLpMckSoS2f4xBdITdg3ZNXvwh6CbpQ/DopFb9gsURprLMfIDSzq3nJh2vA+ISoOA3ivsPmhuN0frEoDIbk3HdZwnt4c3dDkF3sgxGza7Sk4aX3NVFs2UKpWImBn/+JK4d5UArQjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weZJEbDsJ4Sl/mO/kzAmO46dRq4XMRwLtJczW+bxKko=;
 b=Tv5OJrIghW6UbG+wdUKOC/REUanFrK6JfrK87QaP1ZTH0XdTFI1ILwlX2t6iazEgF8+Ohc0b0yV58IcDuELWYwufZb17F4b6sBWqGWz3T3M51wUExiWGVBtDGOz8pvgKMRc6e1Odck6/oI14BdUWspEDf0StZAXbLL/yBU4+COm8Nv21tVo9ZDz7lGhr9lkY5x5yQ/x0z8tlNzWBRoX1i8lbDjHBhmBkCoV6pEMGsx2yBmaVjjOzzOBp9ReNwC9mmcfmL8Gc0d8Ll6toOOm/BCYD/dCgRlfwAuAOqQn6Muj8Or+QcqeLU8aDq4gNxOErMAZImaQ/YwbHTaD+aLLdPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weZJEbDsJ4Sl/mO/kzAmO46dRq4XMRwLtJczW+bxKko=;
 b=ORXgumF6gxvP9lbYp9xAL9DyZ0to+X/rd1r9v/xApYSuqMioJVBgJWsWXIQPl5vAIJGiOHf6vBPNUt5VXBOcKpU6E1Q1wgZ668gCkxCtqf4yMfS07PxiP81bSLmerAhNZ5AFlnmJq4/EMRBjNVwFTR32DqqOL/3WvyVnQQSUReM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 17:01:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 17:01:52 +0000
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
Subject: [PATCH v8 4/8] i3c: svc: Add svc-i3c-main.c and svc-i3c.h
Date: Thu,  8 Feb 2024 12:01:13 -0500
Message-Id: <20240208170117.798357-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208170117.798357-1-Frank.Li@nxp.com>
References: <20240208170117.798357-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de0a646-10fe-469c-176d-08dc28c7a5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d47qnVLFT+ezrse3EdrfG9LPl0m7PomFCF2eJDm/JGvlkKq553Cs6znSv68rCDZRdfcOabJHBlhYQGI59aefnodrXLs83io3NX8wi0HdKGrGYdC5k4v0OFXvK39o73g9+18/wkvX/SiXnXfOhS5XIbyMsDD7Avxx3cBjeG7maVG8+eVfO6RAxa3oeI7EWg+QXN5ZF2t8rin6Gc/4I97qAdWcXEW46N4BglXXBJWE0kuS2FBeaa3+EwGm+ODvQcVkqmfXuI4jLWtwBHgh/gRJxWz/nDUFk0aU+PWbuTw4TVfD93XTX2NZOXvNCEnm6ykmAt/tyrqtiJg+VTzJ27SpM8B3Y6+uBOxU/n8uiXu0R4GTPF+uoCEjIXG7BcaUih11A6NVT4AkzpbT//+rXK5w+8dWTkNZ9pROsD90XvlB2T0yMm7ZBP4X91i3fSc/lSafx653eQ6kpr+6VEIDfCuhpuGAnPB9fRGjhhm57GSu6QaQpBRtrUxsKuC6+TbzHbEYy4eOm5NSq0QxUux+0KTCMuKgXFWkc+xjpr8xS62DpL2TEpsn7WcKLSo73BdSX7v8Tvddb0kBeHH7N+PZ8z5JlgJAobqWO19VE7erbH/aJnU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38100700002)(6666004)(52116002)(6506007)(83380400001)(37006003)(86362001)(7416002)(41300700001)(1076003)(2616005)(26005)(34206002)(6512007)(36756003)(8676002)(8936002)(4326008)(6486002)(478600001)(2906002)(5660300002)(66476007)(66946007)(316002)(66556008)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fvt3sECGJbnpDWdmlWV8OCsoa8CfAD2996ZT7VgKA7dcV27DNRl5b2JnJhGi?=
 =?us-ascii?Q?vxHX4u046ISo4pxHxNFc+3CRn7Y7XMJidLmwQg7HkPS75xFzwjVEN7024McP?=
 =?us-ascii?Q?6AJ2B5Quz83EMnOQH4Y1VrTpZZchlN7CynPKBAxOntXH9IEle+tOkRWmIt1g?=
 =?us-ascii?Q?DHQhhT0v98/mjkC/fCaMykEkTY5W95HEcfXhtEbvpUIOh4DRk9SVFtsaxa96?=
 =?us-ascii?Q?ObMNvMALfCVM62P2LrJLMROkDk57oZaZZCuD8Pl7qokeXQUHee1BhbA5dMGy?=
 =?us-ascii?Q?/M73gq7iceX+rkhokZfrv7WR5itYaJfHkcz1BqdMdU2HVbBttlj5YmKO2KVU?=
 =?us-ascii?Q?HajdWtr5d52kJDDEl8V/J5XpqS6R2fiP4u/O0J3Nsa67Fb9UHiRhgj7UQ88c?=
 =?us-ascii?Q?fGO9+TetdkfeQlZjgN3j+7H0TLPA32yAWJ2EQWwjHVH6E5bSPp51y8wmkdJM?=
 =?us-ascii?Q?29g8ztOVlCT7QSYbUC/dN5UcqXLWFos53GTsI/wtu8hpI0SAQiK34PAYqic+?=
 =?us-ascii?Q?9BFT1zZDdI89Cv4g7srn7/faSHJ5nkAhT+LX6xX+uCzTlChv9YVX0bwoRy44?=
 =?us-ascii?Q?6N2Kj2n1H7vER8Wv+7v+Txxy2b9dpGGMzo78Fh6lpU5zss9d+gv9M5a7Wc5g?=
 =?us-ascii?Q?cy5qDTjRnRvISIpRmA4rqo4hhL7Y8tHpQfxF/s8jMnJKgSpCIJzMaS4gj0fy?=
 =?us-ascii?Q?K9dKgoXYGsCuP3w7ZW4gP9gEj0K8kmy4pbJYzwUuE1K1iOcnIWlObqfHWpMz?=
 =?us-ascii?Q?kLN8mjEI0sNlzv4I8wM0+giICxCXhR3sgqpQoj+ON3DPgfvWxQHbVHGTQU57?=
 =?us-ascii?Q?T4br7VE+2MQkbS4vKwTK42I6pW1Qi7XZSC3NYZxfeUolp1ePwO1CjpbdsjDO?=
 =?us-ascii?Q?tmDwQIYEFflEA2n2yv8p4Uvlqe8sidCtO9T5W922hwQ/jRcv7mivl6udyZ9Y?=
 =?us-ascii?Q?2riCb6kcnXaqwTGZFIFelUbGg/OyyqAy5uRFjMkOR3gnPxJpXlUqbF9OjmnO?=
 =?us-ascii?Q?GBbpxQC9Xm6ykMb9LcJ3SsclaHslCNvku1DS+Oo5pBdzDHh+maIBtazCxts+?=
 =?us-ascii?Q?3Gqarx+blRqBYqShxSyQB34ZB4zplqhaE1A+8l0GCxYb/H/MeD4BPw7C1Bg+?=
 =?us-ascii?Q?EJUk9SNq5EXnTgqdMXC6GwE/HxsQvrXFCya0YoKohz0GCuh1qxMUYNDpBtjf?=
 =?us-ascii?Q?Vwdt5RTSfQ8ZZhtGCOeqtE4Ycpuy+9aZevjMUeYlfNCkfba3DvxkqK9UBlGg?=
 =?us-ascii?Q?Xn4A/7BA41mVVXOsAU4dfk49S1/uCXXpNQTwYaby0Y0oegW9p68+QvQLyCaY?=
 =?us-ascii?Q?WwtQs/AcD6NXagh4UNbm87v2swMtENCahGKLnq5t8b+jMF8jD2u/SRcLDQwJ?=
 =?us-ascii?Q?ye7gtgEpRvnhxeR+gOZoNdeZp3NZio4jeturBCv7GYtyAOgBJWkK8AhoQoso?=
 =?us-ascii?Q?WSSB8hSDZuZllqnGyun2hwo1n7czvN4t2Vmm3nAWEljK0f/3UYfpwN0FpliN?=
 =?us-ascii?Q?L4BwUSl7GTasgmwU4FXrZw+b0Sd25u7OZSY88H+ozC+iDQbcpt+lNwxiGDTO?=
 =?us-ascii?Q?daxYL2Dd7wvHqao43ywrkvtbD5AXgp4OevSljSGV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de0a646-10fe-469c-176d-08dc28c7a5e6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 17:01:52.8191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Nlrp1tg2JIMHeWIlneKjixz/DW6H/tYJ0iQVcSW8Uo4qLMKfVvDQfCYZD/Y3izBetmK0elUeO4bYAMD0/21aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

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


