Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908387FE2CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjK2WMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjK2WMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:12:45 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC1CD1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:12:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT9WW8COAZbtUwwb07C9LYivJFV+bKJzyz1PRRC9JE5h2fKXZL5KZ941Z4pW2T/Exi9x5AYCBE70ZtSOVCFqmHBp2mf2t+AcMOWqNsXBUvJ5mVLjK2NkosG69x7IAIHfzmYsoJ293pWHh2xo8GADOlIxeiiatHrXYnWQyPJLspVREskGSStOXdajU9FXeCjZuZku8E0u63fyS6qWwWIipNuKmjCCMw2qs+/X4DdSwCVIhWz6abNT4335JcW8qnCh2BOTwSTc16735I/d0TcCcuufgiWlpdANItk/NLK49yBQwzwBBw5diN9mFM6OX9uSJPM+MNAeKXEschZS+bA5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ejs+fzDBAH2ZY/qjkH7dS4XB9G6YOzq3AX8ZgGT5dkU=;
 b=LiWAo6+YjmnJfZLqcmHyTf4+RtRv/3+RlxQ/rq/xNQ5VRqkdUPVd3turgxLnqmkVFPFcmYF1q6whoiKNGsKPOyz+ce735QQuUBb5uR6p9zi7Mwuz/TwdD5sVgHv2cQNtU+KH8I5FvVF9wxjzpFVIbxFDN3ktbC+2yHNQtehAWKTgy/zWhdhlZr+FsHbgDfX6fHWJPWjNvrHQUCQ7xHHtnmjub4KEKwZwzJKI8eVxamu9Tj34/NT1WuYZrVeIpUwlWoBn8jY7yTc6AAsRFTrFyAAbWEqPWQa60Gns/oM3oNxTYfNoxyuEikYV/XSdWfs6cLrJqR3kL3nxIDFPb+L4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ejs+fzDBAH2ZY/qjkH7dS4XB9G6YOzq3AX8ZgGT5dkU=;
 b=SgkiI0iWA1pte1bkBn4uJFk4uzqq8uEoWbi/4Y5GjqMFVkD38NE5uIW/s2nrHL9LE6lWirc5BMA3SWVczA7tVWel/eRm+M8czKV2GJn24e/F0GSi9mAtm39jURIxBZ4NcVfky/P2QNoz8aZeC897t2hiK6CXgpOdXCoWku/1adQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9578.eurprd04.prod.outlook.com (2603:10a6:10:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Wed, 29 Nov
 2023 22:12:49 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 22:12:49 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     alexandre.belloni@bootlin.com
Cc:     Frank.li@nxp.com, conor.culhane@silvaco.com, imx@lists.linux.dev,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v4 2/6] i3c: master: svc: add hot join support
Date:   Wed, 29 Nov 2023 17:12:21 -0500
Message-Id: <20231129221225.387952-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129221225.387952-1-Frank.Li@nxp.com>
References: <20231129221225.387952-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:40::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3dec51-7000-4016-907f-08dbf12852e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NWUpI+ThdopmHyGa2HNuyyXLOxnXBFLVos/u0o0sM3fqmekFFBQgYnGJUkER1n15VHx4tKl2y22JdOfcgg75FT5LJvEpE03R5VzP7YEnnMox5IfSRIHkUnRC9wDHVn6igWqdzRYXWpMaYf0WX5u72+CuMoOlVX4GsDqgLo0+rtuMqkSXc/ATpSzxH4eQpZblrDt0CqaZBothkL0CFlYI94K0VR9FUeMDLa9o0xhHaypLXT1PSy26HzYFyfBNkPMz+xciRU0KHjKPrCQgWy/dGXFlGtP4cULj9odAMl2CSIFQjVN1Iys+T85Z8/dqbNLLGGgSGAHcL/dP+aSrzJ1H2UzGtO1EORjW8oxbuJIyktsA2rSRFgYapv9Wa6eQhCad6q0nHjXmXVB94mO+h7cY9+Dwadg6FCcSoxnHlmVtS+PM6RR5FK53yJkbhxvdySWvSJYY512x66PvWVo28XRgvILprxCHpaRRVfjJ12bpmADso+wVqorSc/cYc952DjrQ6Yn2vIOOtNzmvWqY/uAahRUYa4igKhKbmw6J4SBexC2fiofhR6Z4D6QWMu+56a1o69zvLfE3IkWZxH85qwz41ATKOaJrDbymPNHAqthPPyry9ywoKK5TX+UYBBYTcxdo3V4p0fyk/1s5zmwp5v3e1tD2UGBOIp/ak9/4yFHW3DY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(202311291699003)(38350700005)(36756003)(2906002)(41300700001)(5660300002)(86362001)(6666004)(6512007)(52116002)(83380400001)(2616005)(1076003)(38100700002)(6506007)(26005)(316002)(66476007)(478600001)(6486002)(8936002)(66946007)(8676002)(66556008)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wqWsEHyiJP44QbnKJBehDrqARFaHHggpi/PdiXUUjz850JFIUHFc89+yfHUv?=
 =?us-ascii?Q?fre1rwvRxfr6Azhdn2c3rWBnG/ndHZO3XWtTGaRKLm+oj5efl0sv49ZqspUK?=
 =?us-ascii?Q?xVOZFJexSvi0rvDtPqJefKJdVwZ7urWm6ZZlNRBp4+SvmWFgT9tiD3mOSYkH?=
 =?us-ascii?Q?ko8x/UmIHrOluOViDZJMbYqV4a6h3lz2M+ayHixStZvlZcMSSgwOrvcfErWZ?=
 =?us-ascii?Q?IOELR+bf2Mgcu/cxr4ljC2v41dzri2a4EoQToT1QG21N9cRjBkq1RVQUR0BZ?=
 =?us-ascii?Q?JVD/+OrOfVKLfctGdd1yH6Vfsg6wqByesaqi95LR/cq+zYul/QI3DS4ey/Hc?=
 =?us-ascii?Q?gd/IbojQsEullJQV1mH/LMlDpYZj86YO5aBXToMXiAuQmjWa/0v7b/ExOmJ1?=
 =?us-ascii?Q?Tn5juAa3FKhLkE3EvhHn7M5mZPpw3Cs/Zz4HE04oEp/7lex8e7bNOHuykAwq?=
 =?us-ascii?Q?PsxK/TiBBi0l6JU71gL8UQz50mr3ZwkbmEik2S1QPMu0IYQuZcwiAJfo3NgA?=
 =?us-ascii?Q?Gtv/ECJX5FvJso4bknPJUpfCYeoupBGZqeYnfB9C4IrIyypbWcwDXVt+PaPg?=
 =?us-ascii?Q?a4l5HN1juc2ncaNZ3M8rp5joa3RZbJ+jFZ2crXUvv5hlqPQ8rGenrca4jm5E?=
 =?us-ascii?Q?nN+IG4atTY6u8/0mAtFSwPB7NVhWuq5Q2FGVqT1XqTn1kxY8jCANOuZN7OQP?=
 =?us-ascii?Q?bW8DbMaofW3Vcw1a+IX7DqprD++NMix4xDaJw9xAC2AL9AD8FHXNvL07IUz/?=
 =?us-ascii?Q?k3BNDWMXeaJzoDDnedn8riTLsss0IISomRqUceVxyHj2H7FPeuxb2LpMz6o7?=
 =?us-ascii?Q?7vZsbTRzJiJApJ3myxeLaD5lH+e3qX3QBzeIa/GHTV6IkxFARQvlHcbi1P98?=
 =?us-ascii?Q?DttgfYUvZovXDXoxRB2hdE8ha2P56b3e7HPs2StJGCftqX8Nrqhed63fB2hI?=
 =?us-ascii?Q?YmQsMbNhigaN4VeB63qjNPr5FkZJr4X3tMZSJCq+tnP9PCtnzYbtqToftT0o?=
 =?us-ascii?Q?Yjut722/5dG5FgYOzxIyuhnmwu26cH0qd+E0GZZE9F8p/lmhFB8hr56BQOi/?=
 =?us-ascii?Q?/lyio10L24C0f76g4kEwCF9gp96XGutVc48+vv+K3tcfnqVkQ5Gdy249b/m5?=
 =?us-ascii?Q?PvPFvRlV92d3/oDi1rveqRdoVPxxngKalNe5zjxmRl15zX3tSR6lSLSURz9Z?=
 =?us-ascii?Q?BY6MSOjci3fT0K7e0H5T621GYBfMeK6bdY1sLVp1R7NlQdCjzU3G7mFmCIg9?=
 =?us-ascii?Q?Dbb6K1EiWLORBt8ku1SjtAqHXi0m4EqnjvgmDeOHleN/kcVMSj4QqTkMKo5t?=
 =?us-ascii?Q?fIRM4FnnBEB/q7v8Oei1zfb4TdnCgjFU0R5Z931SzAfnITtvwrkb/ZtPzqcg?=
 =?us-ascii?Q?USJmgO81GeHQQ4VjuCVHGn2FF9ZV12U34y2JQ68sDSNd4IHmx5z4H7a7IuAw?=
 =?us-ascii?Q?AZVmv9i3w7bSoTvq/TZJ8MfaPuM0SBAwMkTjKplP5Z97sBtzYvuouodeuuMe?=
 =?us-ascii?Q?euVwSvO4/0RwD/cUJe16nGD+FWbcEFhMEJq80l4Gj9mf6EnYhW01nzUXGMIH?=
 =?us-ascii?Q?SrxpjsKwjwBximLAlSLuRphQh/8Tp/bp0CrJhRQH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3dec51-7000-4016-907f-08dbf12852e3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 22:12:49.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5O6DsE43ddHBoZIj0/4hSXlcg8S+1HtXKNWa8Ny6IN+vCUBnwo3UPaFFJi/yEoNY8a2wWRbNeVd8xgSk0UpAVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hot join support for svc master controller. Enable hot join defaultly.
User can use sys entry to disable hot join.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 58 +++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 6b6bdd163af4f..880c6ae76c013 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -128,6 +128,9 @@
 /* This parameter depends on the implementation and may be tuned */
 #define SVC_I3C_FIFO_SIZE 16
 
+#define SVC_I3C_EVENT_IBI	BIT(0)
+#define SVC_I3C_EVENT_HOTJOIN	BIT(1)
+
 struct svc_i3c_cmd {
 	u8 addr;
 	bool rnw;
@@ -176,6 +179,7 @@ struct svc_i3c_regs_save {
  * @ibi.tbq_slot: To be queued IBI slot
  * @ibi.lock: IBI lock
  * @lock: Transfer lock, protect between IBI work thread and callbacks from master
+ * @enabled_events: Bit masks for enable events (IBI, HotJoin).
  */
 struct svc_i3c_master {
 	struct i3c_master_controller base;
@@ -205,6 +209,7 @@ struct svc_i3c_master {
 		spinlock_t lock;
 	} ibi;
 	struct mutex lock;
+	int enabled_events;
 };
 
 /**
@@ -428,13 +433,16 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	switch (ibitype) {
 	case SVC_I3C_MSTATUS_IBITYPE_IBI:
 		dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
-		if (!dev)
+		if (!dev || !(master->enabled_events & SVC_I3C_EVENT_IBI))
 			svc_i3c_master_nack_ibi(master);
 		else
 			svc_i3c_master_handle_ibi(master, dev);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
-		svc_i3c_master_ack_ibi(master, false);
+		if (master->enabled_events & SVC_I3C_EVENT_HOTJOIN)
+			svc_i3c_master_ack_ibi(master, false);
+		else
+			svc_i3c_master_nack_ibi(master);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
 		svc_i3c_master_nack_ibi(master);
@@ -471,7 +479,9 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 		svc_i3c_master_emit_stop(master);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
-		queue_work(master->base.wq, &master->hj_work);
+		svc_i3c_master_emit_stop(master);
+		if (master->enabled_events & SVC_I3C_EVENT_HOTJOIN)
+			queue_work(master->base.wq, &master->hj_work);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
 	default:
@@ -1471,6 +1481,7 @@ static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 		return ret;
 	}
 
+	master->enabled_events |= SVC_I3C_EVENT_IBI;
 	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
 
 	return i3c_master_enec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
@@ -1482,7 +1493,9 @@ static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
 	int ret;
 
-	svc_i3c_master_disable_interrupts(master);
+	master->enabled_events &= ~SVC_I3C_EVENT_IBI;
+	if (!master->enabled_events)
+		svc_i3c_master_disable_interrupts(master);
 
 	ret = i3c_master_disec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
 
@@ -1492,6 +1505,39 @@ static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
 	return ret;
 }
 
+static int svc_i3c_master_enable_hotjoin(struct i3c_master_controller *m)
+{
+	struct svc_i3c_master *master = to_svc_i3c_master(m);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return ret;
+	}
+
+	master->enabled_events |= SVC_I3C_EVENT_HOTJOIN;
+
+	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
+
+	return 0;
+}
+
+static int svc_i3c_master_disable_hotjoin(struct i3c_master_controller *m)
+{
+	struct svc_i3c_master *master = to_svc_i3c_master(m);
+
+	master->enabled_events &= ~SVC_I3C_EVENT_HOTJOIN;
+
+	if (!master->enabled_events)
+		svc_i3c_master_disable_interrupts(master);
+
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+
+	return 0;
+}
+
 static void svc_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
 					    struct i3c_ibi_slot *slot)
 {
@@ -1518,6 +1564,8 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.recycle_ibi_slot = svc_i3c_master_recycle_ibi_slot,
 	.enable_ibi = svc_i3c_master_enable_ibi,
 	.disable_ibi = svc_i3c_master_disable_ibi,
+	.enable_hotjoin = svc_i3c_master_enable_hotjoin,
+	.disable_hotjoin = svc_i3c_master_disable_hotjoin,
 };
 
 static int svc_i3c_master_prepare_clks(struct svc_i3c_master *master)
@@ -1630,6 +1678,8 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
+	i3c_master_enable_hotjoin(&master->base);
+
 	return 0;
 
 rpm_disable:
-- 
2.34.1

