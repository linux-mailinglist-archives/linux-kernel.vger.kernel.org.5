Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A59B772F04
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjHGTir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjHGTiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:38:21 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0361BFF;
        Mon,  7 Aug 2023 12:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hrf3OFLR9gemHjZX7Vsuo2EQwGm2hHmDELFrPEnDHuo6XdEQVYvLdtWRgH5y6gbwAv3rGZDYeiFsomxa15p4GOU6L21ndzMrJFDvISCdmIwFZ58CJQrst5D7mEAzmmGCkFKkIhO0GYea6BvkXOwq1YMwWuGyKdKU9VOGQHsp6bk0cV+W4IxPGfd/G55L1rjQXvjupokNnZ6qKDev2cLUlXK/n/lD8OTjjcFMr9YjtaAamo/n904H2FOUzt3ahx7FirfGfieitctDMqbKS+OKqI6gcmdor4uSp1KzXZf4nsbzG5kf+J2AGR+zRL6KyiCfx7I+ANTZ6mU8TVcrFobqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+bU1uxiNPiImEetcfeiOA0elVzTOu+QmBn2RC/WRtA=;
 b=ChuO0BlOXwS86sjZ6BizRbTPshsL6eybqBE85RSzkAADWXMft/k+owSK1TLK9tF22aVKXaifeh7gRh57doNGXskuATdB32delVd9VK5wwMIBCjCgFUIfIE2BZaiGqN1VOWA4rAqQqBKOcowFjuNkfziVAboigSoIx2UJZz5Cp5RtVELmuvWenAlBBMyQH2zzBrUDUZtZu7KdGXwb4P4sHj9FUguqUjSeDuKDoKPlV6GDkuAqUnWZ4wHqLBPxzXoNQXmW7hGM64FMlA5lKfoYxioFqs63RE6iX5qzw31ShRQ/JwrUZpWOiLozbZugOfwWc4d+gxk+/uX5hU3Tr5jV0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+bU1uxiNPiImEetcfeiOA0elVzTOu+QmBn2RC/WRtA=;
 b=OS8aaw9o3cVgUMVuy6v8rZF1iPh1YPV2+52qOmWFYJ+VQ69EwVaO0HHegrvGKNbjyUZnadbG/QV1lFnIbadV2Fk0POjNp6zDiPfDEhKoqZhAKJMmqdkTNZnjp80VK/skRlonw+7Cd3oQuzl0h5+W9tZF+r3sQTp2JDGskCBPKaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 19:37:41 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 19:37:41 +0000
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
Subject: [PATCH v4 net-next 08/11] net: netdevsim: mimic tc-taprio offload
Date:   Mon,  7 Aug 2023 22:33:21 +0300
Message-Id: <20230807193324.4128292-9-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4ed35dd2-3039-48e5-3b71-08db977dc3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zyd+9WWe7mSP2S+Cv+RPwzCTvgKe+T85y36TSqcTW02BgQHheCUw+b5vaVGZfn0JzIJYVemDzk6w9oT52/bDSXQX4uDUaee1bkc8ry+hV4NaelvppV882FT9g6KaTRuIcxpKsaKvBxSlPzZIN1flvhukbqFf+jSM/+76CD1TSptBNMQVA7Nxrw3NrG/Dl55/QhygIyhqnb0437jTgytYkazjSjM5x4ye/SPqACFLtf+SqOWYwONy9wVX0kvRo4i4MtAWjO5nZZFmkF3oLo5nZUqjrDHZtCEYK+WrCO8Dl3oLSnly/sJcQo6zb1EruBuymr+AKZzYtCRY7SdwFckni8e1L0bHaROKh3PkcWKV5SPEFpfcz4TCv/nOW714k92r12KhZIatQjM8HUOzXm4divlPNatUpK2z2eijiY5932xkfYoI0eoML29xPHfnfmg9R8/7S1MQx4novDovbbpB81MUNhVgBJTcLZ2jRC7Jbe3MzPpjLqNPYUlFnbQbYFTyEKTDm8pZ1FWwnEOpqRZ7qU3RrVcRcQUR/6wLlDTG0YMjAwI0dHOF/RZejxlIR1h6578QeGuTxTJ0Xlb5lfObD/iaE8UJ9CpOqBqz9EOaCYYLUTjTY2PddPjs20hm+oLF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(186006)(1800799003)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(7416002)(8676002)(8936002)(2616005)(6916009)(86362001)(316002)(6506007)(54906003)(38350700002)(38100700002)(6486002)(66476007)(66556008)(478600001)(52116002)(66946007)(6666004)(6512007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wkX7dXyLxA+Owy2yEFGh/GJ2M3TLD97BiwetmJkNYaK6++BAw/CmhPu3sTMx?=
 =?us-ascii?Q?CX1pTzMFg8YH/CFrcY7bGb2RjtqnaAuOAlODwZTbCnOZjdKGfj4ANbQq1UuI?=
 =?us-ascii?Q?WZTX8WODrogz7RWiKVrEQmZ/fzyZOvr9r3Yc7Znvp45813xzDLqVPDrxVGKQ?=
 =?us-ascii?Q?iygA0czvNCwZ8r346evRXjiHNapYFcTwarVN6ubY3zms3MfB2CFExY+a8GSx?=
 =?us-ascii?Q?Qv9+uQMNl3ALEL5A+/kbjmuinsDWRw23oSnALRnZcA0MYIHhmUfuRabH4OsQ?=
 =?us-ascii?Q?Si/b78oR/3xdgqLrA2A+PSNFKH2KK1UsAu5MXC46VfYf/icCxWhu9ouyayU0?=
 =?us-ascii?Q?f/RL+stLNY1lk6cVK45noxZ00xYJACM0UsO2jngNYmRqP5f5Kdtr6rmu6V64?=
 =?us-ascii?Q?lJovuiF76BQ8HPznDBazF2Z9uF2/iv+mrjHWJy/BFyEbebtOJX2RsYwcN5xb?=
 =?us-ascii?Q?alWd0d7FsKuWto9mh3dnsVJjPJlkm+kzjEeUVaF455u54syrhohUPyyx11F+?=
 =?us-ascii?Q?c8pMKhlLUFmBdiohesfXCpsmBPvYTG/akxbrI9SDxuiBOqXHx161wPaPiBQK?=
 =?us-ascii?Q?74VGPWXHgXfitWQc/1262FSCov6nWBZBP1ZNjUwoOjgmayCRGyocakuYaUli?=
 =?us-ascii?Q?G/NFf0zRwqS4gXnYl4wk+4leY5iHJca9Yf0Wzu+Dy0W0dr3KASdA3414SiLM?=
 =?us-ascii?Q?XsJLB6X4ENRhEPoIQmF6vB6WVnZroRk5Z4PbamchM11iE0zRDCMq4IVBvlHr?=
 =?us-ascii?Q?jETXpeZcChpQrexY65/UpeHPdBdKsfcAm55/fhulUS4+KdO+qjiBzg/SM2LH?=
 =?us-ascii?Q?o/mJwZxE5ZerLi4apIAdXWC3FiZd/7qLL+pOl9xag1gOdKBrblaFARLBi7ES?=
 =?us-ascii?Q?RrHAlbfzLuY75jlCoGZ2VEFHLTLi/FGCyoHyc+LKAHsT0rnoSTn3KKU/dy5I?=
 =?us-ascii?Q?rSl4EERY9aNy7Y38PrY29gVplMLP/Bxx/g19NwhqfNtsLGxVVGhpq0gmx0tq?=
 =?us-ascii?Q?SHArjRcts4yBmihU0dUkyhTWZzAPGaGP1pAJVinQvdAVcPn+h5jcxZL4kP7x?=
 =?us-ascii?Q?z1Yb8jtVt5fkbsoIPGXQc8aocNmYvYjnixmmVxy8fOpSHU88nwpu7NvA4O2U?=
 =?us-ascii?Q?++NlO+uKk2RaxrxV8rWhPKNboyWf9SQg5xka/WzUHLrP+gWFAulXDpf+iV5S?=
 =?us-ascii?Q?OwCoLdDO+VnBuSFy7wToaCvxB6t7CozA8E1lPBfEuUALWdV3JSYXlqExoSRm?=
 =?us-ascii?Q?uMyLJLZmnpYepNJJQlHTOA08hNTIh6RiTy9X1x6sWe7xMShC8wAldKka0OYk?=
 =?us-ascii?Q?XymkSic//bkIjrfAKFLSKssLH/81GDyBpezruEEK8NbTUFWDeBFEEvPtp0lr?=
 =?us-ascii?Q?v1xqahYgcmYfeDqum584epVYF9MvLsM4SZex0xQ1aWM0/CALRFOigHsTLE3W?=
 =?us-ascii?Q?VikM+OuYjPFimrliCayCYeLAmlSBLgzX1QaffkMO/V59c/CGTAJ8/0bRdOWS?=
 =?us-ascii?Q?ORVVGejGDak1Xua2HNAj71alHqCNi1Pa5u1L/ZlJ2h9xksRlHDWzEahYHvHr?=
 =?us-ascii?Q?v6GF7SWg9vPTrZ1C+djkGzi9As6cuorzKaAKCOu2kjqLlmxG+JI0PJnlRrsz?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed35dd2-3039-48e5-3b71-08db977dc3d5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 19:37:41.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ThjjrAkJIvCun5qa8AswfBkVkYQ8P0agMfuPf0aSQrKHrxS9d5KCBFjUG9iaq12qof+a9/UpXlzrCXsa2cX/g==
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

To be able to use netdevsim for tc-testing with an offloaded tc-taprio
schedule, it needs to report a PTP clock (which it now does), and to
accept ndo_setup_tc(TC_SETUP_QDISC_TAPRIO) calls.

Since netdevsim has no packet I/O, this doesn't do anything intelligent,
it only allows taprio offload code paths to go through some level of
automated testing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v4: none
v1->v2: patch is new

 drivers/net/netdevsim/netdev.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 2a4a0c4065cf..2eac92f49631 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -209,6 +209,31 @@ static int nsim_set_vf_link_state(struct net_device *dev, int vf, int state)
 	return 0;
 }
 
+static void nsim_taprio_stats(struct tc_taprio_qopt_stats *stats)
+{
+	stats->window_drops = 0;
+	stats->tx_overruns = 0;
+}
+
+static int nsim_setup_tc_taprio(struct net_device *dev,
+				struct tc_taprio_qopt_offload *offload)
+{
+	int err = 0;
+
+	switch (offload->cmd) {
+	case TAPRIO_CMD_REPLACE:
+	case TAPRIO_CMD_DESTROY:
+		break;
+	case TAPRIO_CMD_STATS:
+		nsim_taprio_stats(&offload->stats);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
 static LIST_HEAD(nsim_block_cb_list);
 
 static int
@@ -217,6 +242,8 @@ nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
 	struct netdevsim *ns = netdev_priv(dev);
 
 	switch (type) {
+	case TC_SETUP_QDISC_TAPRIO:
+		return nsim_setup_tc_taprio(dev, type_data);
 	case TC_SETUP_BLOCK:
 		return flow_block_cb_setup_simple(type_data,
 						  &nsim_block_cb_list,
-- 
2.34.1

