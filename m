Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43125772376
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjHGMKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjHGMKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:10:20 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2085.outbound.protection.outlook.com [40.107.13.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CBC10F6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qtet9YP1FExt4xExgYwIyVh2SHfbIXfJPB1nof0xrJf/xPpCB4DupeXxdJyS00EfXzSGtLZOPNJvvim9CyA+bvm7XGubVfaPH6F5ah1UQX/5l/X8aUUeeRszf1ncU0jzsdV5+ZbvEjPfvZUrFk3ki7nI7ebfuellbiBfv+nF1rxSJuasaCyLpl6ZkRwMQWdsWDUTcS0bwZI5AlB3rJA53ndhpxhky24HH/f5c375s+Ct1HBAnhhYWQDyoYZSzadKsVkwjSNp+rf5FtkYcYZ8PDlEQ2B8ZxNliEvLe3mkjSb3ZLAGTWgJKka1GWBeE8g2c6byMChkqajXRcNckcvv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJJqcTom4DUPHiuLbywdxILIeSIa+VbUbkHM9Dddgcg=;
 b=F4th6Rci5Tvdl2SYazr71E9xhiyMZV3xioVZifZnCNhzw9oqYfr6hv25HB11H3foBQg5QIQzCDd0z+qUKr2H0FRVEoJpSrf56Iq5qTL1NzyGq8mGc/zBX3pwOs0tz0nzU6TnVTmeQj/y5e8JPoiauFHAGgqsyDuc09X/M1Kz8aXjvRRkJ9taKmUgGD2WLE8WVfXRDGyzMK27Zm3NbH+PvoOn+CnAP37aPWiqD35CYkgoqh8lOCnkoJRv1L5h0/jyNxEsNGAQ/CRLv7WevsmwzWD26c00lJIlFVV1LPGESRxv83gBzHAvGLhgHjGFtFlJzrBDw2ED/fybcdtnDehjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJJqcTom4DUPHiuLbywdxILIeSIa+VbUbkHM9Dddgcg=;
 b=TLKrMr9rZvQNVRHKIVDUPOZGsnKL/dmqNf9/oKIe5qh+sP+690aCWMuFm8xi1/2cs5cZHAWXG1H2N6tXUBkvmaM30BH2iqnNU+whf1qU8hk3CqMku4acRDz4k7HglnGT6Gryn5FuKB1SB4ES1r0wErjffYkBxQ4C1DsR17t0QJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7261.eurprd04.prod.outlook.com (2603:10a6:800:1a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 12:10:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 12:10:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Gong <yibin.gong@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 5/8] firmware: imx: scu-irq: fix RCU complaint after M4 partition reset
Date:   Mon,  7 Aug 2023 20:14:29 +0800
Message-Id: <20230807121432.3970610-6-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4bdb32-d316-475e-3595-08db973f4020
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syunkNQF79nDMbYwR2I4Sks8ZFUWvmXRqGJobkliPM4YdeCZpEefCxFKVcqZh9UZ8sY+6C+Uile2MNblSiqNwa8o2wNBwdtiFox8JB6HUNSREk3lSebQDYMMdDt5R18mVBX6p/+dFSXjABEWLAJBCAD6+YT6ZP8W6rY79l1Pgu+kO8ew+5hiY88v5EYfeQB2gHc5V229Qsm/24KMAhRI85Dqpx5WoXqt4z5MK3dvQb+0AclUX2SIHAIjehMAFD3/eePb/ySgAwNnncxjAdK9uX3dlzV85DyVEb1GQ+VZPPEBON38Q+lHsfx3bKBpKXzzC/cOILetJeZdFUkv9oSNrF1VA+i0tWOVlrkMa5nej5E6WhLZMqB89emUgg5d7TE644IEQwU0WMt7ElSuOlruzGq8ObO6Tj3aAUX1IAClf5S787gcmW4ax2rPO49zIFuzMZOOJllaoPYsEI/FxFtMeV+z9ayGDmAt3k2ES/+HvP0VKM363DB4A6yd+z05EoGEOIHQaQW/jRY1PSGwDNDZlj0n2cwDiBzEr6+CLGLeh6iANyboCRoW7X6yI7kUCfCWf/VThOPsqJkBIueNyNu/GFd3MMT/i2sKU8UNGDIb0aqlTqGjRCQhJEGAyE1lisPD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(1800799003)(186006)(6512007)(26005)(6506007)(1076003)(54906003)(38350700002)(38100700002)(5660300002)(86362001)(4326008)(2906002)(66476007)(66556008)(66946007)(41300700001)(316002)(8936002)(8676002)(6666004)(52116002)(478600001)(45080400002)(2616005)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B22SRe8aCrkOJxc7Gi9K4bqsDAfVlmIXmyIc6h6Hm9mEQr3b6rj6UpoTyAtz?=
 =?us-ascii?Q?iSZQCYZBjiRIb37C5E4x9MrATwO2addy3T4Gm9stfMtSJnW5urf/EjcL2VF5?=
 =?us-ascii?Q?ljgrkka1052uGoG9fGSLiA0vOnpGozK6nwD6JGPZIxbRzD2eHgH1k1/JIBkq?=
 =?us-ascii?Q?xUbzqTNUm6EEqEXrK4zdw3Set7whcmVL//VAQx0QvJikhqhvHC7TJy4yGn2X?=
 =?us-ascii?Q?HLQdfXqyC6pie1pJCwgfG4i5zLK00EEJWHtV1S/nq5IbzxUn5hpHGjCjEW3w?=
 =?us-ascii?Q?kP3Q64HxlK8pnPXLdcFvElnW6Sp93AIZ238RYryqss076IKazM7reY+Zu5O2?=
 =?us-ascii?Q?V/vRqPX1XgUnOoThS4VZRFqHGmKS4KOS5IaqOFkl9UJSJ1Vio3Fg5k0KSWLA?=
 =?us-ascii?Q?wEjUBp921HVFxKhqe6/GyFm9ZUucmOZJnQfmQPPJT6k0olUwqrFBtXyvddjW?=
 =?us-ascii?Q?9vO0tPH28y5OlgotA/XT0AoqixXm+a5QnCZoF4XkmeOYUv8J4f/RxX2BW1Zs?=
 =?us-ascii?Q?3RJ5Tkw4SJtSrk85W05WSwYSXhsao5UQPwHrQcXmkEfqnJ8GOnSqlQkcOZJ3?=
 =?us-ascii?Q?d3csbWkI9OrXQB8qBCmttYTVU1tQU9Pl3beQ7IYOr0yDy1zDRz790NGEDrOQ?=
 =?us-ascii?Q?G6ZVDGFkGMBlUl4WhSAIxYbyFsUrSSearW9ljTxLWFr6fvfZWTbyCdv6KGyz?=
 =?us-ascii?Q?m09X2zHeBMz4hkFRef8vAIIGBk0n2bo2Tha709oyk0qethudt18u7XvsuMrZ?=
 =?us-ascii?Q?f0kQe/pKzCqR+Oq/CpHdEuVV5tvIBTaqccbSAtasBkwXgKwAIHuOWurz6Am0?=
 =?us-ascii?Q?tnRET6BPHVExsFNh6BvOgukZ01/LQzbfSFtzf518A8xfayUPMVXX4Rx2GQzl?=
 =?us-ascii?Q?OCrhlwj3mM+R/voE0sy3gv7FqbXiE1Cg9egg9ic84ItZkqGW/9ihk2f5BRZh?=
 =?us-ascii?Q?shdf1hSqBchhe9phHugK2neFD8LmhqI1F3S9JzN8fp1ivTNnyLMw1q6GTuaG?=
 =?us-ascii?Q?1rc0k1yTlm9PYJfcmgKsX6KlP2qkVfIEDHrKTd8ms1b2RXTceQjjr8mm4DJe?=
 =?us-ascii?Q?ugjc2B9ZRAOW2oCDnh9aBlExgPidA+hX9DiFZABE19RzTEyAkT/rxoGY0igB?=
 =?us-ascii?Q?tNxjbnGgTirnxvQZkKj7xHKE5tK7KQTPdB0zENhNQ2HfehS8ZchrI4VHtqND?=
 =?us-ascii?Q?sAokuEkxAotDDosmajWhlTjMK7+sehHFzDLSJ7qXupwr1B9zQYuZ5/d2SGYS?=
 =?us-ascii?Q?dimabWFGo2CMIfqWgMaC43mBQqzsFaseKATeFHn8THeWpCcvOeIy+eEWzgRO?=
 =?us-ascii?Q?j9sqlZmf/QNkhhDULBCP1Fkkjs7OXP1Pyr1bGwX2bKJn2BImLVcN5ikaAIUD?=
 =?us-ascii?Q?+c4TKqLBtbiroHHzDFyLS/1Fz4LKBjJAZtn51hO++WSL6/o6lT7AJO7DwXlj?=
 =?us-ascii?Q?BxLb6KsPMDGF4Yr12fh2oEXbMbXpIDmXBNoJWsAQInOfAbz+7rCprg4FGfYh?=
 =?us-ascii?Q?wU0DU1JdvXwLg1Zak763D1+pQkj+obORtcxoHGQkwIIjBGyvDJUNenk73/ej?=
 =?us-ascii?Q?cv7dcVYer02KwFoq1hedCqmhACrvalk5uCuokWvi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4bdb32-d316-475e-3595-08db973f4020
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 12:10:11.9235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ni46P3XkEhxjozonI6YXOSXfYmLL2H0r0SA4+G0GAhbpMjLe+xJUWkS40B87cd0qbhWG48C1tDs5bDhk4TmVfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7261
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

Use blocking_notifier_chain instead of atomic_notifier_chain, otherwise
there will be RCU complaint, because unregister/register_virtio_device()
will issue mbox message.

mbox_send_message() is blocking again after received M4 partition reset.

Actually, no need atomic notifier for scu irq notification since this
notifier is called in worker instead of interrupt handler.

[  389.706645] i2c-rpmsg virtio0.rpmsg-i2c-channel.-1.2: i2c rpmsg driver is removed
[  389.767362] Wait for remote ready timeout, use first_notify.
[  389.774084] ------------[ cut here ]------------
[  389.778729] WARNING: CPU: 0 PID: 397 at kernel/rcu/tree_plugin.h:293 rcu_note_context_switch+0x34/0x338
[  389.788131] Modules linked in:
[  389.791195] CPU: 0 PID: 397 Comm: kworker/0:13 Not tainted 5.4.0-rc5-02977-g08f78722f07b #26
[  389.799633] Hardware name: Freescale i.MX8DXL MEK (DT)
[  389.805481] Workqueue: events imx_scu_irq_work_handler

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index d9dcc20945c6..4408f150b3d5 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -42,25 +42,25 @@ struct imx_sc_msg_irq_enable {
 
 static struct imx_sc_ipc *imx_sc_irq_ipc_handle;
 static struct work_struct imx_sc_irq_work;
-static ATOMIC_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
+static BLOCKING_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
 
 int imx_scu_irq_register_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(
+	return blocking_notifier_chain_register(
 		&imx_scu_irq_notifier_chain, nb);
 }
 EXPORT_SYMBOL(imx_scu_irq_register_notifier);
 
 int imx_scu_irq_unregister_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(
+	return blocking_notifier_chain_unregister(
 		&imx_scu_irq_notifier_chain, nb);
 }
 EXPORT_SYMBOL(imx_scu_irq_unregister_notifier);
 
 static int imx_scu_irq_notifier_call_chain(unsigned long status, u8 *group)
 {
-	return atomic_notifier_call_chain(&imx_scu_irq_notifier_chain,
+	return blocking_notifier_call_chain(&imx_scu_irq_notifier_chain,
 		status, (void *)group);
 }
 
-- 
2.37.1

