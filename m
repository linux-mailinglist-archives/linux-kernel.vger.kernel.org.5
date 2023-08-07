Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8BC77237B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjHGMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjHGMLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:11:35 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F15E44
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hORX/RUo49EnvTAChmtfSSXmXOuiPlufbEHXFnmwDRlrrNfDTgBc6hnvNXd6InftdMCp16URUOPpHXSeH7rCMZHt9/fRyL7P0WixU5E1QxLxwUW2Tho1XvYc6P8ggW581erukzNFZfgYvqXZA5qZZFKkJ3S+QwypqCicev+SaCv0rSuAYmyU4q1ldMbWK1iuS0LAkyL2PbV7ffMyG/P/WC2/0yX9tVknHNVeDaa0PinmRCechXns8b5nTXekiRF+tGtjcswTC4edbrdkBl7qB+2mxBj0O+0be2MYxjtLK2x0Oqx7IzCDOxQ99iReL3hRIeTOVngCbb/gE/JrzxaDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlvFmAQ4F/k7Q28fo3p52YilLCFjjGPlBKTtdW0oAqo=;
 b=BtlZEHQL4+gPnviYl70nTRkWZ4V0fUGRUStGxtV1Aw30JjasSJNxLbpBrlRm4qc+7+sbOKq8dINA1qQP97CTWJzCdCnsPlN/jtuQ+QRWA5nJatYDHqjVGwocr6aaBCE0QBu9G1die9v49sLkvxXOB6wqyVRJKCmzgHzfwXgnzqCmTpMrBT5DiRJozcDHCPSnG0CAhmD6Ud3BU0LpduxyTR4f3M5WGIa/3Z1FpwLsJNra8QsaDGqXVUhMfwjlaU9aS8ofncXqhgp2LlZLjYchnN0SaQgi6iwu8noWeN841BGlI+P3vfLek8SO2Zos0/uo2G16/Of5pWRRkisZgNtMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlvFmAQ4F/k7Q28fo3p52YilLCFjjGPlBKTtdW0oAqo=;
 b=WPiylpq5Y+vsKe/rCUmbAKQw+25waH+jLw4W1fQMTNmC2gnb76FRxsHs2yKNaJG9XluhmWLLwwaWXIexrCXPGTEHsplIps9cVe/bcbUXcUtbqJWQ56W3oFRvpW/msNsg+0uZ9QO0UIAD05sWgG9e+doLLTVEeNhmq6ROo992jHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 12:10:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 12:10:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 8/8] firmware: imx: scu-irq: support identifying SCU wakeup source from sysfs
Date:   Mon,  7 Aug 2023 20:14:32 +0800
Message-Id: <20230807121432.3970610-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
References: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d95fc63-68e4-4f38-8cc1-08db973f4658
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c99mlhp2an9x998gUsGAxNaneQmNK1WO5GKE2xmAoOQ20NB2FdI3H3JxOAPEHBC5lqMsT9dUYepOd0YQ/+U1Qtzk4HbiF+8PMpEcWlYKcMsxn0Z86P8t3ImM/qG0NNpVj4XNZJu5Jxhm8FZMwwvvMYQQJ7t168bfn+LeLSbkAxMVHEcIgnHnrfP0rADPHJMKfA+fUgLlT56H+zioGwGoFmdRMGF1mU9A4S54uxdhcwsRvPSpmFg6TMfCkej9kjAGOeCVsVdt4pIU8qgp0wbYUGqwY9WzD6aNOSdYrHQz/iZpUveaP/VsCxgjWgowEQoJMHiph72SPiql+OrVrMlcYb5TRK1zxRVNxvy8WZ7neD7+twiHPwAcuTlquhiWNk2WX+f+r2qc4JfNg19jzYTRhKjt0DiTjk55QEWvxN0Ic7TfUwBHdo7z9tu2dLc+EGx9QSIwj1jSInZfqTVnlEVY3gWFs7oI8FzpRHitRF+uJp8f6Yf0KksMdEXwjX8OwPL6QWBG10RXiwplNUqrvWVmLlhYen1lqBGxYrmzsysPfn61ppjycSoL1XPVhiqWkkBfskCk4E8vnx0Fv54qHagwDfOxiClVnbCsG4KMrrU5mJpgvq1sQbS5Xjz0SX2xkRUX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(1800799003)(186006)(2906002)(83380400001)(5660300002)(2616005)(54906003)(6666004)(52116002)(38100700002)(38350700002)(6486002)(66476007)(66556008)(66946007)(6512007)(4326008)(316002)(41300700001)(86362001)(8936002)(26005)(8676002)(1076003)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ylMK8rMBquiqFbZp55/9rF+otIDdQm3bwzY/CmswN/CCq5m2XtrjDMd3Jzbh?=
 =?us-ascii?Q?CcvcWMzMcfXY653SKGpqlEJxfzxjqmfTs/uh2k0yyTy9KSgGUSDoMc8BQyTe?=
 =?us-ascii?Q?v2PDpOeBV2D5/RKn/LDBnvgq6PXuwVFgB9/JPeNpuwzLC/4taxgQIMI8zWCD?=
 =?us-ascii?Q?x3syI22LlnbtJ1EfQ7MONPVjrrYtNVM81sNGZ1apacp7NzVWpl9vl3NezGf6?=
 =?us-ascii?Q?6M3viKD+IQgC+YHMOBIm9qxso/r3A46CLkTEcEqTk8mNUa1jf0vNbhPFwQdv?=
 =?us-ascii?Q?97UuDWfjJZnqS+CAQegdEtntUh6rusVVu0RztxMr2ty4mJielaJ2MF1fhd02?=
 =?us-ascii?Q?rGwGeVDemdCqh067GFpy0SucD2sMpRRfD+w/2rgLrm1Jmq6L1ZgQtX2mkvC2?=
 =?us-ascii?Q?PkLp5vSoCg7tLv3SXafBuA3bYrR5s+UyVXK91G1l7noobYahK2FtE235KhUm?=
 =?us-ascii?Q?uswKtcm9KE2QC5A/J9MW2ZzJ3tf5qQTlJqqZkwkcHGnSXiUYxw/WZ61Pr6TO?=
 =?us-ascii?Q?blgVNTCfSkToeVs/ueP9mTL8a3pinbXkETzjJlv7OUzJdN5hqPjMhpBUwlXL?=
 =?us-ascii?Q?65zFNMP64486eWaF3esKpAIordmMZMFzDjeb4eB8cLX4zfg3whkGUabcI/69?=
 =?us-ascii?Q?qreGE3gI7PEXx1c1FRI12wHblgQDokPUI/LeTINVsl4VcYNygabli8VNDYVj?=
 =?us-ascii?Q?WBpHaO4A3Cf6E3gFunvEnG/BVktIUrXl700o+3gpxbE0SDLbM7vh+miO7L10?=
 =?us-ascii?Q?YbYs6IoXJuZPHvrI3HtNLJxlTEYB7OjaLSLHtiPUF2JZLGeqMCguOhXmRfOV?=
 =?us-ascii?Q?I/fKsch3Ui5JqLsZCX3DCktttLFLieW0IpfIyIoP9yZb3vLCPbzkXm9Ixi6m?=
 =?us-ascii?Q?JSIR34+VvOZ0Wo5dnDcuuCIB1R2B3d0WKHn2SDPYRcySfjwzmUuV4qmK1p/g?=
 =?us-ascii?Q?n1XKPFawJj6o7+VENaMWP/1ESbBhf4VeRaGpPyIpPO0RgBvLNnydYRrJ9cwW?=
 =?us-ascii?Q?54xBlhQ8f42beGyJZwBdz7c8MJwsee4PYzRNP9dakVHqLAueS/fJWyOZEGAq?=
 =?us-ascii?Q?AnitCXPz8lBXr2442x6VOu98W2V5Ns3xOr1MY3Hsh/eQtngOcuXQ4P1V9y77?=
 =?us-ascii?Q?QjfgN0RXqR3EwBlyHwdsEOA6zMy2WAZveZjVLLudBP7oZe5lGN8MVXgtnaWk?=
 =?us-ascii?Q?LzReF3i2zutHPBhVG9x7x+B7IxLWkJDkqp7e4qYNPkHY14pfe6yRG3X2XwfA?=
 =?us-ascii?Q?l3UQU4U6Kmc01raWs76Hfle/q/uObrlWbfy66xzxdsfcnx68HuDECBwAbpip?=
 =?us-ascii?Q?2QP0DosKCSJUtFUcdY0/MgQpAlht6IBF3eNMGG/XOzHqyucP+10unNXy4T2u?=
 =?us-ascii?Q?U59BSSmciJTJ9aRY0/9JOyyeS1qXUDk33TRGylYpN/rNS1xf9UhRKkSuqQYz?=
 =?us-ascii?Q?Lfk5kPB9K0w9NzD2E+ZQWZxDmyu7nTxaESjrOgIhVCEscnJh6BH3sQ0JOrKD?=
 =?us-ascii?Q?kvoHi7ItRcHnF2yGqW24147mYDc8q9gwpdDzFsBo63GaaAGlnNlA7poKAm6H?=
 =?us-ascii?Q?EY1ueX5HHlL/+ypoVX+6xlo0ltcVxaqKMItyQdC1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d95fc63-68e4-4f38-8cc1-08db973f4658
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 12:10:22.3878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rd/Gm7BWBkPkiRIArCAcxypKBdKPr8ldOnvRu4LkOBis1JgyQmi7mQlTzSdRuLxbZuTZR3w+SmVHaT6jvS2NNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/firmware/imx/imx-scu-irq.c | 70 ++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 8d902db1daf2..7cc0dec04587 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -9,8 +9,10 @@
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/firmware/imx/ipc.h>
 #include <linux/firmware/imx/sci.h>
+#include <linux/kobject.h>
 #include <linux/mailbox_client.h>
 #include <linux/suspend.h>
+#include <linux/sysfs.h>
 
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
+static struct kobject *wakeup_obj;
+static ssize_t wakeup_source_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf);
+static struct kobj_attribute wakeup_source_attr =
+		__ATTR(wakeup_src, 0660, wakeup_source_show, NULL);
+
+static struct scu_wakeup scu_irq_wakeup[IMX_SC_IRQ_NUM_GROUP];
+
 static struct imx_sc_ipc *imx_sc_irq_ipc_handle;
 static struct work_struct imx_sc_irq_work;
 static BLOCKING_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
@@ -71,6 +87,11 @@ static void imx_scu_irq_work_handler(struct work_struct *work)
 	u8 i;
 
 	for (i = 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
+		if (scu_irq_wakeup[i].mask) {
+			scu_irq_wakeup[i].valid = false;
+			scu_irq_wakeup[i].wakeup_src = 0;
+		}
+
 		ret = imx_scu_irq_get_status(i, &irq_status);
 		if (ret) {
 			pr_err("get irq group %d status failed, ret %d\n",
@@ -80,6 +101,12 @@ static void imx_scu_irq_work_handler(struct work_struct *work)
 
 		if (!irq_status)
 			continue;
+		if (scu_irq_wakeup[i].mask & irq_status) {
+			scu_irq_wakeup[i].valid = true;
+			scu_irq_wakeup[i].wakeup_src = irq_status & scu_irq_wakeup[i].mask;
+		} else {
+			scu_irq_wakeup[i].wakeup_src = irq_status;
+		}
 
 		pm_system_wakeup();
 		imx_scu_irq_notifier_call_chain(irq_status, &i);
@@ -135,6 +162,11 @@ int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
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
@@ -144,6 +176,25 @@ static void imx_scu_irq_callback(struct mbox_client *c, void *msg)
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
@@ -183,6 +234,25 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 
 	mu_resource_id = IMX_SC_R_MU_0A + i;
 
+	/* Create directory under /sysfs/firmware */
+	wakeup_obj = kobject_create_and_add("scu_wakeup_source", firmware_kobj);
+	if (!wakeup_obj) {
+		ret = -ENOMEM;
+		goto free_ch;
+	}
+
+	ret = sysfs_create_file(wakeup_obj, &wakeup_source_attr.attr);
+	if (ret) {
+		dev_err(dev, "Cannot create wakeup source src file......\n");
+		kobject_put(wakeup_obj);
+		goto free_ch;
+	}
+
+	return 0;
+
+free_ch:
+	mbox_free_channel(ch);
+
 	return ret;
 }
 EXPORT_SYMBOL(imx_scu_enable_general_irq_channel);
-- 
2.37.1

