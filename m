Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25492801649
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441841AbjLAW0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441839AbjLAWZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:25:56 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A1194
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:26:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN3x/HKwo2lPWYenbfCDJSjN7UDo6I5jJMiru/Q0EzcJ85LF+Dkqscn9O9TZo87kYlWcBGLIQKzVaCcyS9erGuecTLv0/em9ejBzy8attV1T5gWsLDDhi3oA9vn7cS/vwP3hex12D+36Nvc0vXQQlyfvxX6pzXVOZWr0KnK5V3ERwj8k4IqNJPezAt0K23avb1xVrd57J1LxXV4QAXtL1ManmwWe46p3ouhXF7zAOlAxUHsi9ajZ2xmPX3nt7TmuCECS4pHM91taxijfamuI5i4X6kQX90coPimx+eeQDmTsvSn0TEp5ZIfPRyqBezTamNJDVOXvpN1pVq17UtVaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSwk4mrsbP/IlP95SQCItlUNiOZrW7VhvxjtbF83/ek=;
 b=ADAasgL0mg4ie0XKXu8rQnta5AkoqDf99Ck7hrFMd6WzyAu3B601ZCqBiQY9ja4IF4rA/gqLlvc5xP6WiqBR+fpYQUxdpRy8NQRAUlbjXPdUsoVkBjctASC/6tyJWQehBU/ELy1lVyLBI+vYqQ9+jvkH0gxDHN5v61FxvOGNO8DJoNIrY+e6kIBji3P3wmGZqmoCGohCpD6P6s2v8VhLZDrEdm1QYmnuJTAJYAvOKR53j6WTRCUJPg0lzvwsuDlZubhtiAPlNfJ3PqxMv4I/hh0SvsCEVCEJs4QWV1o/xzI3v09NKe0DBLO2rP8SLEfIL/UXB3Mc2ScQg0GfgJLcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSwk4mrsbP/IlP95SQCItlUNiOZrW7VhvxjtbF83/ek=;
 b=TFp8OPjzeAQr8O+YSLdHNcgiMTB3Y01OgSnjKHDZTo9OSTxh69gRXIwtNW123yfA9ELZS/O1XQHhPCc/rthCMurw26W7LlYMX5iOe5AGDzNJdL3762Y/UexZCrjuGnBUYILbsZncq6hFGD+iyn9sNUrB6T+xRN/0788qSgWAWjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS4PR04MB9573.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Fri, 1 Dec
 2023 22:26:00 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.016; Fri, 1 Dec 2023
 22:26:00 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com
Subject: [v5 resend 2/6] i3c: master: svc: add hot join support
Date:   Fri,  1 Dec 2023 17:25:28 -0500
Message-Id: <20231201222532.2431484-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201222532.2431484-1-Frank.Li@nxp.com>
References: <20231201222532.2431484-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS4PR04MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 51db0ffc-456d-40c5-c01b-08dbf2bc7f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJja0YpnTLFwlhiM38BF5+aQon7UW3rQpahwsNjjRaL11IujSVC3nh4Fwy3GmMq3aD7PCTFGMPPvW3+4k+NYpR2U/MXRDKce2haMW9pCr9oo+QLRrieLHabm/qe790jslUAANa29TbvBh78VKuoFkEtdvEyjJNbbRzZ3Jb6SB/c3obNIWJxaqZVFY+vl/Wm2KXRamxNWOnOeg6c18fJxAJTxftzP1My+2kOJBlcg5pw4inyDo4X5RI23RU5xgXn8MBP31I3mRpiZe3rhtBe6xzLthxxbr6fCbG3jvohhtgI1DKK8JJwQUQ0TOnXjXs8NvJtUSPntjhziNszqxVIy96n1iHkAl5qRqu4LfuVrcNbF+xXtiQIUUnKPiEg5whSyFfoLU+F/DTdX0stZE2C/mqJu/jm0EnhCd/xd9zJFd0ZRDzuoDv2Gd9nY/f5G5Uk2UgKrcev/J1zkdDAJnYjQ+svjvB05kJfNFJGDbE6nVssm+y1Tq8lm3+tdDXU7sAl7FfoDFS9gsiMf0nISvNLwFN1RxludjbY0JvakUgUCV1OXpfs1dRIYR+0UlcDX1SBdmpW7YA+PDVWqsy7WJpxlqwfCWhBdVMiYj+kb9w6OOi1aFcf+gz6hZRq9HiQ0GHqwLsNjm1+KHamLKpYeGs6aP3Uwvn+Z9Qqfu7M3iOjuvzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(86362001)(6506007)(26005)(1076003)(6666004)(52116002)(2616005)(6512007)(41300700001)(5660300002)(8936002)(8676002)(6486002)(478600001)(2906002)(4326008)(316002)(66556008)(6916009)(66476007)(36756003)(38100700002)(66946007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ZVCdNGAIGXhJtZaB/9hrw+S8rpIsom7ui/guZyewXMg3zBcQdsXu0fuF1we?=
 =?us-ascii?Q?TmmM2O1eYGFszIaD8llkyxHYrdNnk7SJtMxoBVnkQlTNB5sy3A9kBB6820uS?=
 =?us-ascii?Q?RUZZ+NYQ6hqtAoBo+h/CYp9rqp0IUUfOjp367F0Ig4e0JfkYgoWJNcHGaSdL?=
 =?us-ascii?Q?Frk6EE+JVO/zGfYHXdw1IJevJHzvLynrIulHQs5qJEeIUPLvahYW8Q/Krjxi?=
 =?us-ascii?Q?HYfxOS3PIVkBDJuaNFgmSduuxssY/DezINwQT2//GvTSrXTVqz9OhwLMXKHS?=
 =?us-ascii?Q?ULDBsoi6u7fffww8MR8r3UgrsCM15g0MkZE8YIF8p3Av0pDTU88L8/guPvKV?=
 =?us-ascii?Q?7Fu/aioA1LZRC5I2Be2u/a/Ky+VrNLQ8rC8W/Rps1tLQLpUxO9Nq1A4wYtaV?=
 =?us-ascii?Q?3rfYTM/k7IfPUaR/mhwHV4q3EGqkx3KEGTCTNn11KeVdOSCTL8n5tVc86gW7?=
 =?us-ascii?Q?o2MitMBVuNYErAmrRbL0q717gPpZI3LuEuwcI81JtNZSluTZuRnVgtrLDfQy?=
 =?us-ascii?Q?xygiMpWlLqS0euatv1sXSaHLeC53epRNevJ2lBvCtCX1gH/xCUlXFJGwvdUU?=
 =?us-ascii?Q?BpwrqRF+Vu6kTXzKawP/6lrYieRULpkdxaR1QhFLtvvAaoHb28wD68GBvdgx?=
 =?us-ascii?Q?DHOYHhs5OHNdN3c4XOzdyG6U0nNMpBTXvZxCu0NaAKVNyEk8e0pcT0qjG0mq?=
 =?us-ascii?Q?s4rvASWuPhcwhv6OnrWZusTr/BxLT70jRSVGjDIR9GKqt3NviVynwBfGyhNO?=
 =?us-ascii?Q?DIy70JaHtrP+lM4q1fDzYSELTpKpeDITu11PPwzfwGFBt+pIdYSGpKfkGbV/?=
 =?us-ascii?Q?SEcscFRZLuwISjYtFSh11pTjq2EiA31wpdjrZDccAEsSbHRTmtAucPTeSGD3?=
 =?us-ascii?Q?v59WUjMhn5R8y8sgKHNRGWb5pSjlw7YcibXITo4+ESaIg8zu50HBa8voDIWT?=
 =?us-ascii?Q?Tng3gKnUvl93omvu/F1F8oWiLIRsOJSCYiPahT8vGBbnXVjtFRNqD6Kx+wWa?=
 =?us-ascii?Q?dqMWxd0rmdV1RcKRsMzbJeU/OLqx2h0OPB/Ws1mLkD6emMC11HISckoLm9My?=
 =?us-ascii?Q?tDXkCFleTHzKyqGYWU2cjcM6iJ4QXadd8zrv6xSrPeQczl4v3nbp5imLqQBb?=
 =?us-ascii?Q?IdRi53DnR0S8XoX37v8QHnvtx05G5byTJ5rnVf/QjHQqqVKnY+w7b/VsbJj/?=
 =?us-ascii?Q?1wiJKChLPRAehS5qYd8ZGP9h9P1NyWsE24rOj03yBwJrQlWQ6GG6iUfg1PHF?=
 =?us-ascii?Q?B0yZg6FFvOlUKrBx6JgSRRLizlOyMPpD3a++jSbNfDPAJVZ4fRxvB16a18Cp?=
 =?us-ascii?Q?6AvUmGLV/fLmLRUz8Ssg2ewKBANu6yEMlCGk8nitnT+Rw+AUSDTTbKbE8vv6?=
 =?us-ascii?Q?NWYJm17ZWAJ2xrIS9ARI5249jnmAZtK0O3jUZuXF53QsJGVCqxNoMmaEHntt?=
 =?us-ascii?Q?4A7C8ZdBW4lAY310LnWI8Z+1zwRGwdCv7t6N4YKMBEXqeVDOV6xXW6IWTw21?=
 =?us-ascii?Q?tC81vcVYctCs6vB1uXy0GV+SPa9DTg/L18/zrlNmukM+eOItfOhLh20KQGDl?=
 =?us-ascii?Q?698wL5nq2p0+ujFNtLviPkM3SGkFCMQII4LrFMxE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51db0ffc-456d-40c5-c01b-08dbf2bc7f00
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 22:26:00.3007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtUjwv/rEeiI7RTYtXKH34/CcUOJ4ZudH22bKDl9Sha+CnMuENIn3R6zhTCKDN+27vis84ydwUnd74KgeczfCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9573
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

