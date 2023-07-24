Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E199475E985
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjGXCJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjGXCJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:09:02 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CC35BA1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsWllyt1bde4MEnI3Acvwe8ZeiMCr+dt00jimjyOUpHEQupB4+HpISWPjc8caKSidauu3GrnVLOjUSO/xmlMC+x6nuerqHvJPPmoSC9uNjcVrFkkJr2a05nejmrEMqvYXOrRhyOXy5ufF4AdvmBRvoR5AkT5kT2Wj2v0BmaYc6RSeakt61dvdwB9fZGK+KABubrM4UWp3hHfCVTr824USbtoNsk9EZvayQfSwYR3MbbXPjw0wBjK3vnOt4ue6tw621MbPgmifqxCI9lGaNGMNvQzinram15hL10axFccWm9AYj6rCto5A+RmvlEwoznxpZOYqq4npIBcGhz4PyrWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG0c7xlEu5lw/+LfbmcuWV7Q2W2d5z53TXqPTJE8ZOM=;
 b=cJSVhdCoRVv3nFof3L1e7QxrA6iCf2EbuMXBd4bfw0liTDUHTiNO3IuwiS5zoshABsxPs5OxPt1Zpvnl5vCK6i95Hz0UEK0XwTcJKZE/4KiKE6IFQ1JM7qHc6kGNmPD7INRHdLtaC4Sm7qXQIRhZxWP98kqlfhMYQb61Hh2UKy8XbsbFNsR37EQKHjsoiMd0c2kQ4YV5/cKQsJCVKIyFSw6YMQwIDk3IjfsoYmXlGxq+cnYJdOfShux5Wprj3rnWmNxGiK7t+y7aA0xsBky4mThthaVtVWANrkKXhXczpYcreUzu+phKdTKP7ni7pFR/qBg68Ly+jBgA7NRERNUiNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG0c7xlEu5lw/+LfbmcuWV7Q2W2d5z53TXqPTJE8ZOM=;
 b=PgEpxcLn5/yMW8FMH5pdf6rIBFE0xEYWIC6tbyTPcbkS46gkcwSSTxSqhUqb8bPk+rfvKv8bdzd76jvvL6JbZ7zK2kC+8zlpmmRMf1Nfa6B9Fo4o5igHyvWAD29j88ebIl6e8JmysfKFH1ikA+PX2odvvhVStdEANMq5lSBLY/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 01:42:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 01:42:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 8/8] firmware: imx: scu-irq: support identifying SCU wakeup source from sysfs
Date:   Mon, 24 Jul 2023 09:47:09 +0800
Message-Id: <20230724014711.2048958-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
References: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f4afed5-ecd4-4717-c206-08db8be74d42
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRM/+3JY1q/R5NU+XdhKiB9wLSDoDG6ICcs0wJMZXpt+tk3i+Ws0xLWyOktzsPCmjMVlg56547lfBBkpwqf+bfi8Tf4YOQs6W3E+4Rfyo3y9cMfxgIxH1niI+BsqvvOWikO4EH5UGI3XPSAbRogEdf18HxsGyZ5BHz5CBpftcS3mJXEXi5BDltU90+2Hhg8HRMnwXruob5vCbq78b8hkXdeKo3PGPy34JiiYvchECc8fniySPZpuOfGTZXuWh3mYKd8Nex50Plk9pqLv2b0yhPEo70gILXE5vx9yTDaksV+8QLIgxIuGokH9veJVoAwOjG+lbZc7GxP7ZCA757Jmz8s1e+RTYnYMaItHtfvtYBZiiRf8s562TZkDGQvPndBYhiWU/A4nOTFcGyMPqruVrLKgPg44IUeDzYJRM7N9edz/O3ZCAZRm0+cGcdtmF2XRjSxOip/ddutR2mz5U9BDHL4N97gKXphxe2Q1bfM4jFOmIQ+TmWou/b3WBbXES7Mx24gfWiF8Uv5M25+ld+yYgHpl51YOgCpm2yYDaTbGh8ly+oy6oFZQdnpmga/VjZtDlU8DQxZiuDCR3+mGFPQWRb+M/YrcFjJ9xFvB6+GTfBkzZWDYWS68odFjMHEqMhXV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(83380400001)(38350700002)(38100700002)(86362001)(54906003)(478600001)(2906002)(1076003)(186003)(26005)(6506007)(6666004)(6512007)(6486002)(52116002)(8936002)(5660300002)(8676002)(316002)(41300700001)(66946007)(66476007)(66556008)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vq2udE2FAy7bo0CCBH1jQVatfTmdwh5nwZC3tGP2RidZTq+9pfwAet8ogdit?=
 =?us-ascii?Q?nPY5UG4OOODjY5MyLKerd84/EJoBgnC6aMicTemC8H4/O3R47vJTCuq47Vzu?=
 =?us-ascii?Q?DXllrJAkHrjIL4D8TwfyEu0nv/rLe2imCDtnqhJ3uiHpPWYvmtxm2/O7Co6C?=
 =?us-ascii?Q?T5QpowBdrPH6bi1/XE1zJHXaJdB4FuU7mgcizBiVVtQbODi0cTEZz+EzeitG?=
 =?us-ascii?Q?0UZ234aATYVMUTcisKWoX4SMgjOGWBdp9illLC8wgz6Rx0f7lliyrA+2HNLf?=
 =?us-ascii?Q?0sikitbJaPBR9oxFLKiRPpXud10ChqWVKrI1nXFjzlnlnExjaQFKnsfVzjDq?=
 =?us-ascii?Q?PkqKI+t+XB8xy6Lh3lbOYi/zHATac4ffBlmX7w1hJa0ZTvlghdKVWw8bsQWJ?=
 =?us-ascii?Q?4K7gPWnvfXxnYrgtM+d+0yF1+furDXD1m98lXmLHcRTFMBDRXCRIg6+IvrEm?=
 =?us-ascii?Q?uQdigtWs7uwXibwzIYkDX963iQFHuw+F7Yq50jfcL/xH6vHi2nqeTuGiJVk4?=
 =?us-ascii?Q?ncte6lzSEtz4tOV7mwU869Zdi9zv7meDm/PDWgg7wBPIHnIQuOcOjlaDDgVr?=
 =?us-ascii?Q?VefEYWk9GkmbK5Gi434y0xrOUkyjPPXV9PUaYiOUfht773sm+oWmFG+T8M2T?=
 =?us-ascii?Q?DldzO3mjz3tGp7TO5qrrE9w21vZGPmH7rWx8S/upPWG6EZC3CSkDjl/GbMcS?=
 =?us-ascii?Q?BSeypdi3+wRTosVCg+s9r2gmFpfTgFG5YwwORtcganGksezWvJax5OnruJHS?=
 =?us-ascii?Q?dxFk0F4Mk2wD0hDL2RyFPLLz7IhOJJxQGEGt+eDlCJfTsIss+Tl9DsOPJ8an?=
 =?us-ascii?Q?Dr2YsWpT4CCpcbFUmyUMoEM3lnB+OyBRZ5XFxXSYNnLEU6DU1euA1T3pzcgs?=
 =?us-ascii?Q?WOOmU/gBpWNgTmGVYMj8GWb82fzcwN1j88UoRvD1J1hR6jLQe9iB5JyjhSJU?=
 =?us-ascii?Q?n9UMZqfC1GEBqfFr1373Mys67N/w8ziCS/lkCNSwF2bMXcm7ZV4dfO7k3Kh+?=
 =?us-ascii?Q?2l/zHP2KCRlh1bQgGFzdOfG7OS05rzczLeCLHPxHJcvXyMjnm3k8+hXTJkAP?=
 =?us-ascii?Q?yy3D9Gx4IE+//jNlA/fGeHx4/i5inevaeCSyMfJbF38ji5Aoh16IbEmzC4zX?=
 =?us-ascii?Q?f3TuWel3beiv5DqzutB9mONZBdVBMbWZKRUPB/pfClvGqQ80mWZIVKExqTS3?=
 =?us-ascii?Q?/17YFmSwhtd7L1/a3al27KtF5epwd0G4mavd/7RFnH2pu6V4BpxaNY0KoPdG?=
 =?us-ascii?Q?pdez06yCM5taP5rtW/U1XzzIcSXMtFRsRyGPyCXj5OVLddnQabqWlUu2mlBJ?=
 =?us-ascii?Q?Y+D0VH7ACco3YfwkD54G04ZcLfavRXh1U/WrAErbhEzTeIi4frfUsBntXVL4?=
 =?us-ascii?Q?uW2APbufrskU0qu4snDM8V5QdVfMP9aJw7BGzjXmJr0/+h9nT3Y4p4IW6DLc?=
 =?us-ascii?Q?E3p0iGvm6UU/ZuLFMzSk0BEMxCc670xDth/7TyA+cHk/Sgb7a2Iwi16DILTz?=
 =?us-ascii?Q?nnrGhmZ+pnBy+uhzRVGnPZMkmE337MDadapywCA4tUnPuaFXBUa9ibNjuS7P?=
 =?us-ascii?Q?+xmJf4y2v3sxLzGcgtT1z4a7v3SWw6FBB9HnxOmX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4afed5-ecd4-4717-c206-08db8be74d42
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 01:42:55.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xmk8QAfD9PfSyknEeyAHF1ttA9lqJgDRVdGMVkWQRjM2Cu6rZbiPwskx7O1PHGkZSvMfwhZtFpo0mMYPQuRGbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>

Record SCU wakeup interrupt in /sys/power/pm_wakeup_irq
The user can further identify the exact wakeup source by using the
following interface:
cat /sys/firmware/scu_wakeup_source/wakeup_src

The above will print the wake groups and the irqs that could have
contributed to waking up the kernel. For example if ON/OFF button was the
wakeup source:
cat /sys/firmware/scu_wakeup_source/wakeup_src
Wakeup source group = 3, irq = 0x1

The user can refer to the SCFW API documentation to identify all the
wake groups and irqs.

Signed-off-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 66 +++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 8d902db1daf2..79efbf259dd7 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -11,6 +11,8 @@
 #include <linux/firmware/imx/sci.h>
 #include <linux/mailbox_client.h>
 #include <linux/suspend.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
 
 #define IMX_SC_IRQ_FUNC_ENABLE	1
 #define IMX_SC_IRQ_FUNC_STATUS	2
@@ -40,6 +42,20 @@ struct imx_sc_msg_irq_enable {
 	u8 enable;
 } __packed;
 
+struct scu_wakeup {
+	u32 mask;
+	u32 wakeup_src;
+	bool valid;
+};
+
+/* Sysfs functions */
+struct kobject *wakeup_obj;
+static ssize_t wakeup_source_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf);
+static struct kobj_attribute wakeup_source_attr =
+		__ATTR(wakeup_src, 0660, wakeup_source_show, NULL);
+
+static struct scu_wakeup scu_irq_wakeup[IMX_SC_IRQ_NUM_GROUP];
+
 static struct imx_sc_ipc *imx_sc_irq_ipc_handle;
 static struct work_struct imx_sc_irq_work;
 static BLOCKING_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
@@ -71,16 +87,24 @@ static void imx_scu_irq_work_handler(struct work_struct *work)
 	u8 i;
 
 	for (i = 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
+		if (scu_irq_wakeup[i].mask) {
+			scu_irq_wakeup[i].valid = false;
+			scu_irq_wakeup[i].wakeup_src = 0;
+		}
 		ret = imx_scu_irq_get_status(i, &irq_status);
 		if (ret) {
-			pr_err("get irq group %d status failed, ret %d\n",
-			       i, ret);
+			pr_err("get irq group %d status failed, ret %d\n", i, ret);
 			return;
 		}
 
 		if (!irq_status)
 			continue;
-
+		if (scu_irq_wakeup[i].mask & irq_status) {
+			scu_irq_wakeup[i].valid = true;
+			scu_irq_wakeup[i].wakeup_src = irq_status & scu_irq_wakeup[i].mask;
+		} else {
+			scu_irq_wakeup[i].wakeup_src = irq_status;
+		}
 		pm_system_wakeup();
 		imx_scu_irq_notifier_call_chain(irq_status, &i);
 	}
@@ -135,6 +159,11 @@ int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
 		pr_err("enable irq failed, group %d, mask %d, ret %d\n",
 			group, mask, ret);
 
+	if (enable)
+		scu_irq_wakeup[group].mask |= mask;
+	else
+		scu_irq_wakeup[group].mask &= ~mask;
+
 	return ret;
 }
 EXPORT_SYMBOL(imx_scu_irq_group_enable);
@@ -144,6 +173,25 @@ static void imx_scu_irq_callback(struct mbox_client *c, void *msg)
 	schedule_work(&imx_sc_irq_work);
 }
 
+static ssize_t wakeup_source_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	int i;
+
+	for (i = 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
+		if (!scu_irq_wakeup[i].wakeup_src)
+			continue;
+
+		if (scu_irq_wakeup[i].valid)
+			sprintf(buf, "Wakeup source group = %d, irq = 0x%x\n",
+				i, scu_irq_wakeup[i].wakeup_src);
+		else
+			sprintf(buf, "Spurious SCU wakeup, group = %d, irq = 0x%x\n",
+				i, scu_irq_wakeup[i].wakeup_src);
+	}
+
+	return strlen(buf);
+}
+
 int imx_scu_enable_general_irq_channel(struct device *dev)
 {
 	struct of_phandle_args spec;
@@ -173,8 +221,7 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 
 	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
 
-	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
-				       "#mbox-cells", 0, &spec))
+	if (!of_parse_phandle_with_args(dev->of_node, "mboxes", "#mbox-cells", 0, &spec))
 		i = of_alias_get_id(spec.np, "mu");
 
 	/* use mu1 as general mu irq channel if failed */
@@ -183,6 +230,15 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 
 	mu_resource_id = IMX_SC_R_MU_0A + i;
 
+	/* Create directory under /sysfs/firmware */
+	wakeup_obj = kobject_create_and_add("scu_wakeup_source", firmware_kobj);
+
+	if (sysfs_create_file(wakeup_obj, &wakeup_source_attr.attr)) {
+		pr_err("Cannot create sysfs file......\n");
+		kobject_put(wakeup_obj);
+		sysfs_remove_file(firmware_kobj, &wakeup_source_attr.attr);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL(imx_scu_enable_general_irq_channel);
-- 
2.37.1

