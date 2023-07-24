Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C020F75EB98
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGXGfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjGXGfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:35:04 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5791713
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJrER5X3FdSh/7IeMfR7avQ9ONRS78EcY3x0GUF5TDUO20LYu2XkMqFdQy31DFsa9NU7DDJZgEYBzT3u8KOCVkS8Sz0OUsiD+vNS6GhhVsdOo8BVllHgEFO/6hz5vJzUWvBMHJAnF5z9cY1NtoI4Ch/DwcnSn9nmr5Iwl0U9ODAHWs6bfIKqSpc01XAMaCRcLFL1H+3iLsfyqCZ13rfNeB+5Ml4tG73Bhw66h79mHdveq57b2CY8OTqTdH50WCa0Tw4d+CzjOegqwgBakRNomUfbO2strYLfcnAu+bAs5G7ucUYjVCYhDPpzXhXVcLJ3WZl9cI+llxwLY/vfDAYZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG0c7xlEu5lw/+LfbmcuWV7Q2W2d5z53TXqPTJE8ZOM=;
 b=crbzLmcs9DXiCEujHKQersjWMKquwGd6XtxM2NB4AnADdDUFH05jkQUpc18NdTf9fxIuEMPYVUOPVlGHRgIQf253wDOec8u9H520uEbukXnPCP4vXQobKm70c6n1gNamCOwU2G9kpQ3vuLxZOTjDZnMIwuxw4QMwvLJVqrT+7LcbFQWb2Kk/pQ/6CHNEYTymkipJ3lP7yaWzYNSYP63SK7pkDxBUwUHPXZT5jaXy9X+vYshKZvZqpKif/Tz+9tn+d9lxcksd+ChnNN/WMfYtTSwNgN2DOc9G0jq8u+bOkWxyZhaJO+jxCad5pVo87Ra37RqYLB5zy9ZaVJ+HSo81kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG0c7xlEu5lw/+LfbmcuWV7Q2W2d5z53TXqPTJE8ZOM=;
 b=OxQP5+GnXo68SFtsR3E9bYQIeTmIhYr1NmbVU+tByCKgsgd7r0kV6ar5KxoDfRvMccnG15nGEcUVCW5VEDn9mx3AKnDH3grmSK2xzTFGKidfITLQoIf/q+iMAB5tY+jQQ+/rLgTInXN7t4BQ+zbAOxG41Y5GYNHetmCLH+aJv/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9092.eurprd04.prod.outlook.com (2603:10a6:102:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:34:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:34:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 8/8] firmware: imx: scu-irq: support identifying SCU wakeup source from sysfs
Date:   Mon, 24 Jul 2023 14:38:52 +0800
Message-Id: <20230724063852.2666930-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724063852.2666930-1-peng.fan@oss.nxp.com>
References: <20230724063852.2666930-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e76bad-859f-42ea-afef-08db8c100b1e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2y5ioOM+NsbXoRPd4p2FjuXezm7kc8QI1cjgom0tjDe/KCB6Wkph5F2zoQtUX6dafLhVVAYs/tewgTNosCjlKo5FqVzxIw06kHA6yzBs5Qp+yYEM1/QsZadla7r5At0+Cn9zQ34Zm7EAKRIuzbH/1Nv3Q5If9g54MVpQnqehvo9too9QW9RuHl6UvQ1r4JTmt6U29wMOe3D8lzbDIDhPrG+F6O87BuZm8VO4cPAashVO7CKy9X3tWHb+jDAOI5JJ+Gop7VxL0gMMh0LF3karhEvyAiWyPq4pgp2qs/Q5cZhnUQTTa8/n62F2E+Am6yOQ1pffX5OkRyhX27c/xsmKfHslyqyRSeCYys3PjBEfhro5b1sa3KV5tEI7GLsqQxzkcIr4Y9nKiathumv7owfG5UTn3kpdcfxbxJ+qhJgS4nQCP3qZ8hNvtbvRSyy6+Hb/E8m61E0yQuysQHDUg9/t/qTra6/l9cAmJDjnqXU6Na73b4PyvamUQkIdwLEFqaZlN/aJ6dJMClZYz5JZWfppIJZA2C2OGAw0lvDz2ce7F4WnLK5X8MAgvLfTi9uytcOp3ZczM5+OTmXl461PzOh9Uz+Uog18feTWGPkcav55gFzkYj7Tn5p1YEk5VIok4Mn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(38100700002)(478600001)(38350700002)(8676002)(6512007)(83380400001)(186003)(6506007)(26005)(2616005)(1076003)(5660300002)(86362001)(8936002)(6666004)(6486002)(52116002)(66946007)(66476007)(66556008)(316002)(54906003)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9CYaHl/OTfLIxBerkXwfJXrukdpIAP5CuMlZmyZW1rI+Y9BpZquYx3utxKoG?=
 =?us-ascii?Q?vbFGacVySZboKt2f9IVwMqqYw18t3RG/pwKKXPPU1QXlLMiqfOqfImryx/ZM?=
 =?us-ascii?Q?cHOclDVpZ1FTwD4ndFIPiN7Ipf3nDEoY2iF6C8SAjB98FZ7TbWqKSnyvHyeJ?=
 =?us-ascii?Q?RR1fVHBgd+B8SBQ4nuFp9i4phyAdi0wlUam29FqFSzE2es8jB4REqzv2lfyT?=
 =?us-ascii?Q?sE/Btg5Nby7bVx4MnAJ9dmadObsd3TkOBPbQr7HMdgEcKT3x0ULvRbhZa1pf?=
 =?us-ascii?Q?4RQ+h2VPClMvQm7aXUqeonKj9OhqyVozWLCYeuoaPRWgJWGMtJ00tuZD/NYM?=
 =?us-ascii?Q?/dwCwZqsXhHrlS7VKQw+xM8eOcVE7sHDtUIrNqo5VNK1HRdq5GYU266Rr7on?=
 =?us-ascii?Q?nJO5dgrbtjnaBZDjuC8RUsemVKlZmKTKZlQIXbm+/cBwHa76Cg8kBibiOkVE?=
 =?us-ascii?Q?yPd6heaOZoqJvOkfVQNtRhrNKlT2WLfRry9m24/+11niKCtU4O6AO46pwzuR?=
 =?us-ascii?Q?nqlfwHLrGxayqmWQufNTXXWDOOhg6pYqxds2Rt9KLTRFUxsdeu8/6RnjhqAE?=
 =?us-ascii?Q?/N8x7k7bGMsahyC+138yUkOMgnJ8LkN7Rk1w6iweDL0kBNSXMgw0jFA0LpSd?=
 =?us-ascii?Q?QVw5BH3Bux9z9UVd0y6+8ixdEo4eId/8GU6fcJV+QkAlyPgGp703TKoqpQrj?=
 =?us-ascii?Q?BzBCr46l8bggvI5Uto40XMGOr90fisoY1mVrv118C+PyXZKfFLr5r+fW8RNO?=
 =?us-ascii?Q?rS74VDmon2TQHW+6jj6w9BrI3RJPU01ssymg5ck1wgCNJr9mqpoEjlRlm1Ic?=
 =?us-ascii?Q?prEtpT4yzTNqY22CmZaKRYlPjJacYEotUvv+btDHqR+dbOmbUiwN1WV2/zhP?=
 =?us-ascii?Q?mIXD6/q/NYK4iPMAaGQ0lb+RcJorRTBM0bl8RvYr3VKrvBbqvvwyDhF73oqe?=
 =?us-ascii?Q?Dwcbj/ueLPj2Zfz9ea1Y9nrzZ0iKRFZ0Omod6iDQ5gcUm5vDNG9sL6EGx/cX?=
 =?us-ascii?Q?DzDySrw9rCZZVWjaFHaLNmPW0zDEwXNHHXLBW0h54uV9sCxKonMBvPtMqgGa?=
 =?us-ascii?Q?cyA5eFG5NYW5yPup6q9yWoDu2PUwQ8HG2O3dCtKtOr79q6v37pGUX5TvGnDu?=
 =?us-ascii?Q?P1fM7Cyi8PChKEfKOUmPGM3s7ivZYUbUkTr/PZWUR5TFmlHHvA9bMIsK7i0F?=
 =?us-ascii?Q?h4vOzwyQ7tN9rDtv8+xxuxaxVq8lV37/biWaXBPhckEHMn2GAtO9bOKVhisf?=
 =?us-ascii?Q?kVmjyvm9fRoRtLw0Kir2gEJ5Ee0u/YheE3tGAowHujtDg4IIXg2QBMnhXiRw?=
 =?us-ascii?Q?pvhqGFE1H8x2ZfQElDW/82/j5ayRrsKakdA/CW4TMEpeGJaGpU1KsUTCBD8B?=
 =?us-ascii?Q?HRYGSsJX26ueu4htvTlMTcwIeDzDX551S8hL5wTH02DvKrMvSoPg9s2qhrQB?=
 =?us-ascii?Q?uG68Eob5kcoQafbtIBhbbAp/BD2aq/Vg5+6x5/+HnYnb5sl+1X1Llktw/SMZ?=
 =?us-ascii?Q?mn3k1/moROBS0wEQKnRgAkrCF5cfkySvc3DIdNvtSa8+erxWM+OViOLyqPxz?=
 =?us-ascii?Q?viYn7lJtRJKgW4SgouZ0X4E/jSrmkMDDwqtm+qTT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e76bad-859f-42ea-afef-08db8c100b1e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 06:34:33.9393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0M294gjy1nCduxfuI5SQWtSnt59z60nreCTitxNafPeqq3vRP322N4Wf46LaoZvMNbSce9FwNPJgRYWwMEmVGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

