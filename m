Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D410175DC86
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjGVM2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjGVM2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:28:35 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601E710C1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWOnqVQiPBUEB6JC730pP5TdMWXGRp3fisQPMnwEBkwcLKgLfBModUU7z3HetOTFZxDfo0qaWAMEMvKz+++82HFpYe9c6a2svqzD4Sp29jA+48An2PKJTAXaG1zkjyANgusu70qNZN5RPDItSFTNSR4ogdpGFNM6gav73LgwxVZ/9y3HxF5QFJiD9LeWExe8A1iDkCW5DR8dyLsbMAZeivxpEw30tBgmGNhvylXX4Y/eJMMFrRALxzHmE3K4MU4nlOPAKslHEGTRuhI3Vw1SkTMG+GmcRYpENJBy0E1AZOG2iAKZFnhy3Eqc0iI4/I6tT7Xzl23q689dZhHd9cpoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG0c7xlEu5lw/+LfbmcuWV7Q2W2d5z53TXqPTJE8ZOM=;
 b=PoLuaOs2efA9SU3hCc4rrZLDlsiEXwaEHUcn9OBUtxoMbkRAB98ZvA/a9zvOOd8r2u1cizO/B7uftM0lyvBcaRMXup6sf4IpgfVvrflHdADHYp2XjnGqB2eikjNk/rfEo2DlZx8wkT0OkJGSC/77H3mCNQJwxi/X61ExJKR9IKbsl9UkNs0/1nH50gBmYhAUhBKn6SWCtKdnH/w/gnfjcIM4KinTTBdrzcmXpRATMqM3IqPgBWWuGgP5KFAC5/F1jeUAvgSg/0KbFJKkgYxkD5VjLdgjPMoGFlEwc/jxvE7TxFvwpI2+4vVmLAdVJsrCskLc/ksanPGEY0UPLzChtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG0c7xlEu5lw/+LfbmcuWV7Q2W2d5z53TXqPTJE8ZOM=;
 b=fkldCRcdiyx+vM4j1z8Ie3/Sa8w0l2BTZbp+urzp6cZzsun5ArB7R791yhiAwI2Wwd3zCBiv9onVUP1rDjZ/Cl/vr08o2VEggDtc7qBCby4v8yIcQvg/9ITxNOlhbbav9EqKbXuaa3+T++x7esYs+ZXzwhuKa5S+6esSE7eBJuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 12:27:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.029; Sat, 22 Jul 2023
 12:27:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 8/8] firmware: imx: scu-irq: support identifying SCU wakeup source from sysfs
Date:   Sat, 22 Jul 2023 20:31:19 +0800
Message-Id: <20230722123119.1966998-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
References: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 529d1314-8e84-45d5-214f-08db8aaef4d2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLo0rQeDaynaPMj8SmIVPFrVwjgcqTA7Lp3N+T4xBj1bdxfOR9sd7/8qM5cIFuv5E/6vrpKNTPyqDztGMYI4qb6HYJg9VbbDw+1OP7OLzX7kiCJp3TfBEurvwNM1238cwQYOL2aGsG9yqCxZdWjWwWdkNV6AjaA987iwZr33hy9kde6RpZSysz1EUEf24sgoP1qRWdUy0QGOwWhA0XeW0FQSRThQj8t2sBv93zmHnxpokFX177BYQSPNazMhV9Aa0niz6jXJiwY0LoX143ASY/yr00aIX6NHyphv6jnT2dEDP0XyVzqoBec6gZcLMJTFFvFiXLgQCZ+OMKNkLWdcqOCnbxcQurUJtUDL9PJvdIGwdwtqvmDqGISb2r1C9AJwZlfzRbMuyK6z/fKYgz9xr0MENlTsPBNG7WG6jQOESJI5tqh2t++hRgtd8wMVJPXzjtOtfjGcTW4E8iqXzQ8hjYukNJ+PifXtE0GTNjsKFE4C289ACPLi92zqZ1KuCv9D9yGNu65UcmzY/c+Khg5XqAND+WKRunlTu91C4gSuqJGzE9y6ODJw99M5TZ3PdzSfCYO6jqhluSUo3cItHlbOTiCsOBNJokuV1DwNOF6cteTqg5wOqmuaHL7gmG8XruZx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(38100700002)(38350700002)(2616005)(83380400001)(8936002)(8676002)(5660300002)(478600001)(54906003)(66556008)(66476007)(4326008)(316002)(66946007)(41300700001)(26005)(186003)(1076003)(6506007)(52116002)(6486002)(6512007)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q6LRQlgByyONk1fqP3duMDdH1V6INv/NwG3XRGy7F7VgCDqsIAxCCocfWDSx?=
 =?us-ascii?Q?RTfjQme8LI7AnTWjSuZxTaPd6QGCunUY4dTPfCmK9tE9ieaLjAIChgtSmGCN?=
 =?us-ascii?Q?WzkJwwwaLE8UYLSO2n776pjg7Unlmfeq2o12/LJgMEhp7BEYvOKkOMpoNlMl?=
 =?us-ascii?Q?cqWmeJjHjxY13pN67yA/IxOe9FleIK55onJrbTFWF2/mH9tg3KUV4lZFaGti?=
 =?us-ascii?Q?jbDsJmZw6q4FhJC29hL4lG/QdwDBaUJh75yZaDvKXQ4T1fA5BMUbSrjU9z7L?=
 =?us-ascii?Q?mqq2HGZmXLcZiVmadrumKVac22a8VSKGmNw1KFhopl2b4fhK5TSf6QoYlW5x?=
 =?us-ascii?Q?ctxR8vdCxkxLPhOaD9lWwKxB8Xg+SB4DDUrFlQtwdC9kk2JrzNa6fXJp3LjW?=
 =?us-ascii?Q?AkA5XlQTXChee5hvb6jtDyJlXEZUsxc4a9uqdgCj1APl5SS6Oy/8vBRDRu6h?=
 =?us-ascii?Q?3JsOywKXpvRBAfcs+oC2KxjnvBlPS0wdrZxXdNLlTYCdD2/PdKFMO2z07rni?=
 =?us-ascii?Q?2SHf9WDaZHLw8FtLxnsWcvH+PhoZUUC4UmRV7TQmhTNzYuRVEJN1IEQZf0aw?=
 =?us-ascii?Q?cPbHmPFppZ2MoOA2TW0BZByCNfzfir78bJA6f73RYSayWacy6lRl1Djwy9Tt?=
 =?us-ascii?Q?BN8/Kd8qPRMiz8SkmdFJKvYY2/NG1MfGWvvIajXoc63QPeipNDjpCvVn/KOb?=
 =?us-ascii?Q?qXkLC+CcnUUAyfowxc8qTwhpyNsN8+IW38v8YCOQRzCLjMJc46t+cDz0Fa1G?=
 =?us-ascii?Q?mg+mE1rX5Eo2oI5FAQGNkgm1y6PIT+s0jJbu8IIs+mcdjTS19v0EK7XCnB0k?=
 =?us-ascii?Q?sb04IVGjXTmpfo7EvkcmNxmj1OdtRcaXcbE7HYH9t4hqSnZMUUfrTXpsDyIi?=
 =?us-ascii?Q?j2o9OqxkiOd1IcRiwMMU4rMeP6TBUyq3nj4XY8cDSJQrEZ4JcrmeLIB/hCPI?=
 =?us-ascii?Q?jE8XOKAFo/FqZBzHO0Tz/ztRMC8VxwHvTQtaCtQq+OpL7S6Ra6svDFqM6JsR?=
 =?us-ascii?Q?RC1lULI2W2e9JK73qGrzvMcwggiMY005yFf13qitUiZbSK8SJm8GG51DbMtM?=
 =?us-ascii?Q?ZQgqgcbwlfISUbCG/eKZXSUEc04/kgYWxuyIIwvetrN7uOC/y5I4khnJiQuO?=
 =?us-ascii?Q?Ewk1UIVDRTT8LT8qi5Vqlw0+UrTUeIiDb5xk9PxPeSYe/0WEjsJ1FlNNYH3X?=
 =?us-ascii?Q?+4BJ3Y7PLLdcqe4Z5khXOMQh6MEvdnO2D8SZRYKcz9QWm9DzntEK17W7JE0T?=
 =?us-ascii?Q?oc/z9kk7o58D/DyB/szYKYY1WuNGB4p/HJfIZc9Z3Xf5Gh38qAfkKPVRn4ac?=
 =?us-ascii?Q?j25oobKnqkUkeLLd/GnOu0qtlgjU1dUccejwQarL7jMkomQMDAbI19s0+0vL?=
 =?us-ascii?Q?mXSy2FXwlNcHLQemF5Mp2124jjB8jJou3qkyJV/IT09lHrgv+WgiccAB4E9A?=
 =?us-ascii?Q?T8IzHtL1F5TUja1QHMay1oqlPdOL11J3gLRUxdKGzYWu0OyBNOXVtR8CDImH?=
 =?us-ascii?Q?/YqxgFdpMOGTo3NsjGQ9Zzr2VpIDOodexJO2vUa3/UQV7ePTLBZOEh6/HCwY?=
 =?us-ascii?Q?ed1eE4PNGZf+jNb21kxx7SgjkTs+ow+yj8bu099I?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529d1314-8e84-45d5-214f-08db8aaef4d2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 12:27:04.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1QXYfO79MaD+CMZrNCwkgALvtHORJa9EdtDi/eb5SMaNd2gnFMOVitfC840xqaJH5rl0B7kw9XKBZvisF6u8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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

