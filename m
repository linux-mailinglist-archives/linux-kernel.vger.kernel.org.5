Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473C07FFEA3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377185AbjK3Wod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbjK3Woa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:44:30 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EE810F0;
        Thu, 30 Nov 2023 14:44:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhbQEnY95RL9A5JaOZpnXj03+FwMtvJ4OtbQegzxpzyBUvqoGKKlWZb8ZYP3S1/i+haSN6sMqXF+qgUvbeOQiCOmfJI15eE4nA7tq811SHDXeFsLaJrl5RZmP+mXNoeM7A0KTYz4jPiJ9h1Q6G9U7i9vTPF2+2YioSSfGoJRtgHcPhMzRfAqTeAA/eKDopojVAX8JMMUvg/ca1VeOj7JO7wnYe2d8bOCkFlNsdWFDQF3LsLryYw9+wQiX+XzRkE3+dcpHu7ilHtuNm/ScWebIXlaWf3m696ozGdIczedfXw34HhEKu/VegLIGApVY4vZVyWEQvqqhdn8cHto/1jZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSwk4mrsbP/IlP95SQCItlUNiOZrW7VhvxjtbF83/ek=;
 b=G3AWjEjvc37L8P97k/quGISbUz4O7nlNMs+mvSnMiU8Fg6LQFSAgiOmdE5jbJu/Jc2DcMie4KhEMQmgmbTsVbHh5wqbCej6+20ubqAzRa6sT5URFPQ+kOSJ6n7G93DsBM/WzjQXaBvlg7P3t6BL9tpHMSSYywdcNnJeI0f59TEFCE4wmwf1fcRrjpKCRH0iLvlCrv+8IeGlJU4TdO0VIR+uklW6EAAfm561PAiYNfH6aPN/SSjkQlYq2c2ym86ACV/HtDcTaNdMGEnGOd/4hCgq3lltdE6VaSWoy/2W2TaWghQJ6W/Si+nOTPWCP1ZS1TQ1Jj8T6cUPE9YyWcHWzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSwk4mrsbP/IlP95SQCItlUNiOZrW7VhvxjtbF83/ek=;
 b=pVBR0gUsTPnCxtE1rooJAk/b68qH+ODV2EQv8g3ZFTlLuJ8mQN3t2yy/wzFox6c8EGEEf8sHbdypr8/z3XrucCgoMj3gbZbfzKRJw6kpEIYV25bjdpiGOL6LYIKtDJuKKiqIhfn0OAyCfOrkGmsO7ruUMeTv4ZPf2RVH9znoqcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8851.eurprd04.prod.outlook.com (2603:10a6:20b:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 22:44:34 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 22:44:34 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v5 2/7] i3c: master: svc: add hot join support
Date:   Thu, 30 Nov 2023 17:44:03 -0500
Message-Id: <20231130224408.3591288-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130224408.3591288-1-Frank.Li@nxp.com>
References: <20231130224408.3591288-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf35edd-8306-4614-65ee-08dbf1f5ecd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BRNZD6ddfb+QnFAkBnBEqhby2xIH20ggDuC8TtWD44obeFlUG5JocUfTTwikAjMCQgZUH1ZrMQoCNGuSEjvBh5NSqdbzzWHYf39SFyjpv2uzOpQ3E4+cmgu4EaKGpEpv1SzxF4zyyxpLRTKrF+yJMDlFaPrB9NrWnVokITpzGzGlIEf6Koahaj9gbffNI87gPy3/LGN6tAmu1bCZnFZhzZGA/RqoBkuy8vjmkXOpRrljoFNpPfxISBYMVTz/7M4+PUSpzGND+CD5htOWzsMY/9g3dqv5uegUuabiAjux6hlCJmGI3DMgSmAR+kRmSsywlJobvA+95RC7ucfl21z5FXVVoUEmowYmFzD4IcbFIajq2Z/z59yrjQW3im7ap6r42XuUDqbjnjex+LVM1do0o4AevHJuUwUmasyYOwcHsWAyHA5vfB5H3x1ivJNsSa9YCJmEvKJkEAuI3VlMGw58rCJMraohrcscV8zeMtgWjeLS/YTXG6tq8bLk0Sn2H5ab/PNs4qL3c7YSy2Aupcd5AzQA4YzyZB7oG0aiKkq7zhYwsJc0QvPqI5tranCoa0VSyLVSkAD27YxM0kEFVl09ZGqfIdyW60zppkrUPk0g0UPQa+YIDxSPtMnWpxCElZN1l3al3PlixSNJOHuKw1RlAZKn2QfeX/qUchGGveF6MyKnCC1sNuanciXBa6eDp9SgvhX0bKQmXMXilh65u0eNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(86362001)(6512007)(5660300002)(36756003)(41300700001)(6506007)(38350700005)(8676002)(52116002)(478600001)(2906002)(6486002)(6666004)(26005)(83380400001)(7416002)(2616005)(1076003)(4326008)(8936002)(66946007)(6916009)(66476007)(66556008)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Q+b64IT+BSCQNmAss79NJWQj0xfwYDNbLY3irzsLebdS/7nTpoPLLEhrmgy?=
 =?us-ascii?Q?fc/tLq3rUtqaIPwj6O4v7WCiUEho7ioETwP6Bu5Xp0s7x2rrLhN20nhy7V01?=
 =?us-ascii?Q?NHVIVCw1/2k+wNIG4+uEswhQFKnNnrJBufgkpjoXw+I4piGXMA5FFgN4gEew?=
 =?us-ascii?Q?Wc7rAnTSA/UVafXLjv3JpZM86p4tt3KyD8B0gh+Vl+kKsSLUwAvZpGzCBtwu?=
 =?us-ascii?Q?27Cza4RSo+54/tqUkyoIKmxILC9dxwZupfncMvq+oAdxocgTnKhvIQPuN48c?=
 =?us-ascii?Q?4fPlejaChswyYn+zIUDi3uylVfGglzOsE8cEO+v7YpTniv/5U+WcsnVI7qMX?=
 =?us-ascii?Q?hy72/31ElmwscZ9i7PbfCGjiTsnTy4A+vVTbGYIbhfsjrzimaWXZ9jylVTjL?=
 =?us-ascii?Q?JgimjNbnVUHttgtPGk0luK+Q52cckyQ86qgUfXZ84AM4/CMeLOQWTe0+eOAv?=
 =?us-ascii?Q?zzpqNou/kZYgD0C87Ck0rlf/0AR4TTgYeVTNOEMxlSjPEH00nQzjyMBl4SDi?=
 =?us-ascii?Q?RaP0tdEfBQbBxc4A4TM8C+NnoS4DlR8cv+SvSbve1fgvbvqhoJbVgRzJElPp?=
 =?us-ascii?Q?bTBaG5m33KEYjj9KsBXCCIG8Idt8ZKk4CLIim7NE0R13SMPiCn1A/DPYbw/Q?=
 =?us-ascii?Q?dJz/1vCAR3sHfUw5NhYwS5uZMA0BzOJMI/Vi0I0ufs6kyG7fls+aQSUx8+Yb?=
 =?us-ascii?Q?6by1mOFkN0dFRzMBRw98xQWEL8HhusgG/4Z91R1M4v+3Y6xktLltLCYJpjE6?=
 =?us-ascii?Q?S50om0m4qt6s2aAUvK6d2C8CiCi9pteRK9AelSxqjGRJGSZj7AGpUBmHhyZe?=
 =?us-ascii?Q?OBQSiMprOVVqEMDs7kr6tRVvPWg07Y/Xf8Bk22Ksv/REWtBRda4q9EtSU81p?=
 =?us-ascii?Q?Mj5Xjm+E36LzxPHRCRWyOOJIPKE3O0UcdFoGNBYbfx+s01RtMVLV0DrxZKdk?=
 =?us-ascii?Q?Eexwj9OnNFgoZOkomUi962hrIh7XSBh4eWNSw+LieOMHAmpn6zAZm3xjquqr?=
 =?us-ascii?Q?TlMmy4hUGpkatZcUHIaEIGv3Cj1zWkERnlEYqqmHx1CzZ+x66vyfO9Lfo8IV?=
 =?us-ascii?Q?kUkd9NWGzJr4L4fHHuEVhUPPcExH9u9uc6TYY9oYrpKQlSXUNsWM9A1nY0dP?=
 =?us-ascii?Q?ozc24afNKKHGY6dyNck8DYM4Bn2532PQgzoQ1Sti+IPFZ1ocX4SsN3bJpval?=
 =?us-ascii?Q?nkiawQB6YIQWjDoopnFJrfWToB8VYtVrx0wAoDzFzmzyaLKJXjDl+uXTv5ok?=
 =?us-ascii?Q?kU40f4/W1Kh3nAVI5No/UnXYc2dDxPCgIIRVDEjo79qwIl80ChZoFMTgCHZ2?=
 =?us-ascii?Q?mJevQr+sROOrDazB3nj6YVAEeYeSuL8vuualbH9nXp3610pTIfX6DQIMXn42?=
 =?us-ascii?Q?4hw50NPmEcijqm3a0jsY7YHckiWPvulfCy04yie3kR73R2QdWnO3B0/GQVea?=
 =?us-ascii?Q?HwtBMZpFdJ901xKiOIQJLMc3VVBxy8NVOqaM4PzvmoJCJZ8vasu4a5xVXICM?=
 =?us-ascii?Q?p1QC0vAKTfVl+Sz1FJdv1hP1R7FlBx8t4bkb+3IeaiGCkzvKo3OjtFps0qCr?=
 =?us-ascii?Q?3dWrw61+7+OIgNl9b6ZzwVYS8PzPzunzBCfjUUOT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf35edd-8306-4614-65ee-08dbf1f5ecd7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 22:44:34.7354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWzyxPGqFp1L7tEoKBsqN3OMhiU+uKqSpu63wLFpPsmmGlMz8NpCA2QFP3AxFW4hDzUMbnqQR3BDXsIydQwLIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hot join support for svc master controller. Disable hot join defaultly.
User can use sys entry to enable hot join.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5
    - default disable hotjoin
    - add help func is_events_enabled()
    
    Change from v3 to v4
    -fix build warning
    
    All warnings (new ones prefixed by >>):
    
       drivers/i3c/master/svc-i3c-master.c:212: warning: Function parameter or member 'lock' not described in 'svc_i3c_master'
    >> drivers/i3c/master/svc-i3c-master.c:212: warning: Function parameter or member 'enabled_events' not described in 'svc_i3c_master'
       2 warnings as Errors

 drivers/i3c/master/svc-i3c-master.c | 61 +++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 6b6bdd163af4f..f2058a36f869b 100644
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
@@ -219,6 +224,11 @@ struct svc_i3c_i2c_dev_data {
 	struct i3c_generic_ibi_pool *ibi_pool;
 };
 
+static inline bool is_events_enabled(struct svc_i3c_master *master, u32 mask)
+{
+	return !!(master->enabled_events & mask);
+}
+
 static bool svc_i3c_master_error(struct svc_i3c_master *master)
 {
 	u32 mstatus, merrwarn;
@@ -428,13 +438,16 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	switch (ibitype) {
 	case SVC_I3C_MSTATUS_IBITYPE_IBI:
 		dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
-		if (!dev)
+		if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI))
 			svc_i3c_master_nack_ibi(master);
 		else
 			svc_i3c_master_handle_ibi(master, dev);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
-		svc_i3c_master_ack_ibi(master, false);
+		if (is_events_enabled(master, SVC_I3C_EVENT_HOTJOIN))
+			svc_i3c_master_ack_ibi(master, false);
+		else
+			svc_i3c_master_nack_ibi(master);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
 		svc_i3c_master_nack_ibi(master);
@@ -471,7 +484,9 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 		svc_i3c_master_emit_stop(master);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
-		queue_work(master->base.wq, &master->hj_work);
+		svc_i3c_master_emit_stop(master);
+		if (is_events_enabled(master, SVC_I3C_EVENT_HOTJOIN))
+			queue_work(master->base.wq, &master->hj_work);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
 	default:
@@ -1471,6 +1486,7 @@ static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 		return ret;
 	}
 
+	master->enabled_events |= SVC_I3C_EVENT_IBI;
 	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
 
 	return i3c_master_enec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
@@ -1482,7 +1498,9 @@ static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
 	int ret;
 
-	svc_i3c_master_disable_interrupts(master);
+	master->enabled_events &= ~SVC_I3C_EVENT_IBI;
+	if (!master->enabled_events)
+		svc_i3c_master_disable_interrupts(master);
 
 	ret = i3c_master_disec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
 
@@ -1492,6 +1510,39 @@ static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
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
@@ -1518,6 +1569,8 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.recycle_ibi_slot = svc_i3c_master_recycle_ibi_slot,
 	.enable_ibi = svc_i3c_master_enable_ibi,
 	.disable_ibi = svc_i3c_master_disable_ibi,
+	.enable_hotjoin = svc_i3c_master_enable_hotjoin,
+	.disable_hotjoin = svc_i3c_master_disable_hotjoin,
 };
 
 static int svc_i3c_master_prepare_clks(struct svc_i3c_master *master)
-- 
2.34.1

