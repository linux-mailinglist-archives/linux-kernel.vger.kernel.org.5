Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31726772EF2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjHGTiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjHGTiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:38:02 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA93C1726;
        Mon,  7 Aug 2023 12:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc0WtwpI6/xuub7DATIUWnq+fCE1U9qULCwZTUrA+10gL37PduChPP+qWgAnv5ZoW91LCgjVvW2qcDYP2SWDFhiBLwRdc5WCOEq+hKN9gG3KmM2IioKPdjya7A2YU5ff5eA/zKdhObHjNO/wuUlLjY0KjEV0PUKjfusmamLxvV45zbwO2Z7NJjAXulxOBizDzWthqfsFifp3/MmKhrohxhgJus5MWEIkClDMy6eH8PqK3SmwBtavSRCV0QE9qaUefCU02ZKGyxQkef4McJfwC/kZf8aoDCiu7BTAazkSfaUZKceQsTnjA4t4Qs4GtDgvGtUu3y8axDCged+oFyj2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8ji/QFNFkYozc1uGEnu/Wm4/4KzmkqxPvEJ7tFXBd4=;
 b=BWGKPMSHVUr/14K9YPKS+ec9EZxnTymFjzCJ1QivVeFjgunSN2+q20dXTrOZXcT7z2Tpks/WOP8KLOQ1JhfKb2YmpXke17oJmtYEgmCHhBYWVtsMjN+05+ZSh6uWVx8R60fqBQW1j8vlo+3nyuGxIv3xYFd95U1Po7hnUDqEg7r8kIf5CwZ3c6PfNQsbSEQ6Z0RfacjQzHsIgPNawa02KcXB5eiNUD2Yo1GXWSHtcAvAeI9YSpmSGEqQctph2ctr0RBKkLWzBxFTgHIjaiBPLH8ApPKbXt1Q2qdig61E4Nh0+0Tgju9hNFEUxvOWdRhyZ48NycRTC1W2hl1We1WrMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8ji/QFNFkYozc1uGEnu/Wm4/4KzmkqxPvEJ7tFXBd4=;
 b=ebcTyI6TNjTAA98sMU8MIa8SYRM4WRwAO7lBFNPIzShEBGSNA5EnsGV9ngvzBUM8XlUaeTfNSC3O6OV6cRFo0VM8NUI3mZ39MQljvYxWbgPxYwFip4FN08PHL5iNwfFqH10BwQ4k3frpoxQy4XBLhgh+Xu6lS7Jb9z4HCxBv/9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 19:37:33 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 19:37:33 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
Subject: [PATCH v4 net-next 01/11] net/sched: taprio: don't access q->qdiscs[] in unoffloaded mode during attach()
Date:   Mon,  7 Aug 2023 22:33:14 +0300
Message-Id: <20230807193324.4128292-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807193324.4128292-1-vladimir.oltean@nxp.com>
References: <20230807193324.4128292-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0136.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::41) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: d8dd46bb-250b-40c0-1ff0-08db977dbf1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqWQJ0VxLTfuLjaQZayxo2Wthp6fj35ROpy5h3tG0pEFb0XkJpmyN0/dFP8uearywIgtv2JQ8J6mb0JWA2uNrVAlt3fMsbq558ZXhRm0IMM2OG5dbKunp1pnuo16DZVaJeHtcq1PyfwM3plWT50Npew/iPpENGrU8GUeyWlaEEfu+P0ns6GFMGjpfN7k9wBMrX4oA+heKZ2O+OxAmpcs8BKqeYsu1DdJ2yI/34gQkYMkUIc96eR5vDcDXlFBggMkpxoV6bhPAmerCzG1WjeOu5yFubIxaqkYLGEhHuaID8kxkz19zGOA/+0nFMt/IPULAq0ckwQVV7OE/ZNR5SNsrEK/wj5j1ggbYzC5/sZyGC83f6tFNhys4Xv97NgmTpLdoVwruVTFRvsXQByo8XiKs/rSlQ5zTCqSDuynjMHBb30CIcfJ+l06Icc9jHaFCD8DVI6QxF49DVS1NoA0RzTt4bHbEXGQAnfevYKM5mO+901mtwjPFU4fzjG3ClpKccrBNWS+47ZImJlajXp7AKoRQcTR5D39sLYb5QZYQR5n594fGikf8Kfbq5H8Un0l2Vanc3DE9TLNaBFQEC2XhAbvEHVplI9Q2bxeWJIFXk8lYI/2x1xi3TiXPPMyMG/eNHjN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(186006)(1800799003)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(7416002)(8676002)(8936002)(2616005)(6916009)(86362001)(316002)(6506007)(54906003)(38350700002)(38100700002)(6486002)(66476007)(66556008)(478600001)(52116002)(66946007)(6666004)(6512007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DrFA0OOR62MxE7N71OdGFnw/q4OZgd1RW2MGAGCfq4Re7EvvGVL6GBSD8hyC?=
 =?us-ascii?Q?VjJ3OnCFixb1BRpuY0+Fu2WHC7NIol66K2ypwsLway57WbvsClww2jedmV/f?=
 =?us-ascii?Q?zO/9537VljXhTMObKJxMj15QAOTOTeqkYuBSEWEpc7bbvZB60ktG5+N3frxt?=
 =?us-ascii?Q?zMwjXJ6nk13C0lwzNgjRpaz4jIIfyIfvQ6zN/9pwKCUj4C+8Qj3/oTCsxkW3?=
 =?us-ascii?Q?riWZjL33k0SCbc4EfGVK7zfKN5MOZjRNL9yHJFP+qQCP5wCBCuc6M9ukV/2t?=
 =?us-ascii?Q?l95YnWxXRDOESAL8Tnp2XYX5LmXL0qjwmMtQKQ0T72zX8MVnAAIwmicVHjU8?=
 =?us-ascii?Q?W5KikfQEWhN5RlN0okfAkveLJ66h07y7EMXCfcKF3orsmUewVjFoBVteFM7v?=
 =?us-ascii?Q?j9tP7ZahhP6iUpQf3txUz4CpNB8FsNoLgIlOVS2Rdh/SbrOSv4jU69AYky7j?=
 =?us-ascii?Q?lE8Vsu/71GU2It4ElEfOlx7nrKlLcN+ZBIjXGkIVSqVcjRU34txaEr8njKxR?=
 =?us-ascii?Q?FCCMFkcdTid0Y4+s4rNuaTSfWiRHiy3/kFZ5G32BgwVYrnBF72KLSyUfA4gP?=
 =?us-ascii?Q?BZm28BiBsemCjrE7+ZmKyg78mUPg1NmTjawIkRaxsvDgtnSO1y1RdAz/gT2I?=
 =?us-ascii?Q?34dQlCa7BNIH/qtUmom3XOfnwGysvjUfZmQ0W443dE6PgeIVbhd0ZXvjRm+W?=
 =?us-ascii?Q?5vFlHq8agj+6omZHNqPcL0kBTq9Hik9qLtIe2jaF3Vl1/ZAsChQOZa+7fX/p?=
 =?us-ascii?Q?jntKJ6IqCKtipUbyzA3c5bnTkCaeJOeQ0j6vuzxWxGI5/IGVx4gBP6PeCM37?=
 =?us-ascii?Q?yD9Yy/Cbmx/LUAW2M+L7WZYLRHYHngaivt0UqD6y2P9RdcXYt9rLfsKZBmOm?=
 =?us-ascii?Q?xwYbzAxQqZkvcKfOBO6PchS5NvdFgeUr6VhurFWq9OlHThkAw0TsRjhu2I4a?=
 =?us-ascii?Q?ecakHHISumXhSydEAT5PMw2exDJ182gWIOHGLkhH0veYNmc5jvV9AQeuiue5?=
 =?us-ascii?Q?3lQDlzf3Tjikk6V0JdITKK0ewamh5GbBylQgJQdsIIvZq8jeKqtiTKMno0X1?=
 =?us-ascii?Q?WIdmXTsXDDFTPSlg/usLV1TQlwbu5EYXULOVboMaamEjdKsZT27ASZiL26Re?=
 =?us-ascii?Q?PncnsfO8piaQN9nnK35XUUTvEqBSaN2F3Z8rKs6XD+8YA7adEfGb5V+KDBPS?=
 =?us-ascii?Q?8mioiGr7vGLZ+V/NdjYEBZALy6wz9ikXZvOQECHxP2diVRJH1z2ZKk3M6CWU?=
 =?us-ascii?Q?oxu6lmCTU9aiMOrZYNboWORpGxZo6QQbQRElo94W5pvqxjdya0qYJuYJKL9w?=
 =?us-ascii?Q?QaZ3u2d7+iG9Q/Dh38AzJxTdUrYf1MdPpjqsW+3oH+gEna+3K9jkB4EuhyEY?=
 =?us-ascii?Q?NS3BUgLAxQNBjSRQbrNDYbbN9F/UurlUaX50hifC2FgZZpjpyUWOROsCItZe?=
 =?us-ascii?Q?5N+l8I/GTZ0HzYsGuMGE2v5s7alWiTA+r8SOaGZIdWu/MSOzXtYn1bi28kFf?=
 =?us-ascii?Q?YkqCfK/TJFxFSFeSeaEtqfa00GGZIEBtWm5vCManOV0r9RhdbH+mpNXe07Zj?=
 =?us-ascii?Q?HLjf3Gj8E6fvjzt7Df0TMr5CdsoIYRTuVzYzhIMlDRo6q2BV8eKMBjBOgvnV?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dd46bb-250b-40c0-1ff0-08db977dbf1a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 19:37:33.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeZeFE8NCAuJggBnu5YNU5KujvjopoW8R/ovFBZikJUCZP4oSwJGCjSoMX/iJ2e4eoJYOUykBJW0aLvoqn822A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9451
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a simple code transformation with no intended behavior change,
just to make it absolutely clear that q->qdiscs[] is only attached to
the child taprio classes in full offload mode.

Right now we use the q->qdiscs[] variable in taprio_attach() for
software mode too, but that is quite confusing and avoidable. We use
it only to reach the netdev TX queue, but we could as well just use
netdev_get_tx_queue() for that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v4: none

 net/sched/sch_taprio.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 8c9cfff7fd05..1cbc7fcd56c0 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2145,14 +2145,20 @@ static void taprio_attach(struct Qdisc *sch)
 
 	/* Attach underlying qdisc */
 	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
-		struct Qdisc *qdisc = q->qdiscs[ntx];
+		struct netdev_queue *dev_queue = netdev_get_tx_queue(dev, ntx);
 		struct Qdisc *old;
 
 		if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
+			struct Qdisc *qdisc = q->qdiscs[ntx];
+
 			qdisc->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
-			old = dev_graft_qdisc(qdisc->dev_queue, qdisc);
+			old = dev_graft_qdisc(dev_queue, qdisc);
 		} else {
-			old = dev_graft_qdisc(qdisc->dev_queue, sch);
+			/* In software mode, attach the root taprio qdisc
+			 * to all netdev TX queues, so that dev_qdisc_enqueue()
+			 * goes through taprio_enqueue().
+			 */
+			old = dev_graft_qdisc(dev_queue, sch);
 			qdisc_refcount_inc(sch);
 		}
 		if (old)
-- 
2.34.1

