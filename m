Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD45769104
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjGaJBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjGaJBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:01:16 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DBE1BF1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fi/ypUZqeq0hN+lPeeTy+z5Adhz2DPJN9nkuzJ9PMvgzHwg/HlvrJpHAuVdc7O3iR9ugpNkkjiU0bQMhOeKULdA+M9cqmlABo3YDdTLmbteDTHpPMdVWq0c+p9jO6VH2qn9m3tF1DwvrR5aiBGt3DjBuBhuxqmgctm4Y5wtlf/QEYifqZrQlpsZVpPBkI8hEylb4TRV4J3038qYeud2vBTbu+7GtUeGEYWfJb4Okd/mH2UCGRrgB1xKxh1QB605R4/aLFAtwdDpA4sgjBjKNscjJDEm6PSJYmGS0Ukh8+AUEoSBPQDnV9phEAiy+JbTE181Iw7EYCEPWLRB2HgLiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umI6ZrQ15cKelsFX67lK86cAvVI5zNZJ2V7Gcc2eaAA=;
 b=bV84MZoUac0O6HhAk2ccSih4hCzc0FHJkgXPIs+5RiN1zEcy1Tdpx2CPd6pr8MxrRxY3ZSAei1D/F4kEOl/FuycZpH/o+nk/4WP+VzfVf8qI3NW0wGDzfAetcaFIcdsWj5pdspE0z/UjW+qoF/79Fo+jNKkxgmvN/NhOSLSF+hbcAL6ISkpL4CV5YClhzznq1MoKPd2xlDXoCt6KiQLGxCxa0r32y3gEkzqlfTH+7F5s6tIFkOIIAID4ot3mAOC9mWQI6XTfS+poZZxf6ceapDr+aIncTYrwrocCBnbV3XzJuddC6Bn2+7pYZxZ1gAhMRsO6G7HffNibD/dGJncu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umI6ZrQ15cKelsFX67lK86cAvVI5zNZJ2V7Gcc2eaAA=;
 b=H0WwN2FLrnW7BTQCIYWHY0rVgP2WIJq7BbPjRVLLCfX8+CUhh7SOmIqhYUsif5MjptxGnRiCt8vQEm4cquBJSkNa3skJJe4++R8S4thexW+RceYnzwwhSirkL4JAdkrMyYkuYLEPCCJcY6TJu6neiqe11q5VUmFhLN519HlK0rQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8229.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 09:00:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:00:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Gong <yibin.gong@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 6/9] firmware: imx: scu-irq: fix RCU complains after M4 partition reset
Date:   Mon, 31 Jul 2023 17:04:46 +0800
Message-Id: <20230731090449.2845997-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: e960e039-c3ae-4c2c-7af8-08db91a4942d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3E8w6iaxmEt/85ux4N81q9ozCw0bUhRPTs5uHzjLq/iqY1ZDFYxxjd8gua07gjO38mHAYJ/tWYRYzu/7/YmsrP8SIas6/AVYaXUWQzF98af39K45oZFSBiEPjsyExbq4WNt2pz2Jo8hEsKQhKkW5ef/wF1ueyAWRf5fHAc01NMo0wO3hGkk5tOYQX3nuUnaJm8vUlEmdFRG8XJTpLPzhIFE7P/mU/8ZTIHd9HwBQHe14mAv8NvC43+AnWWTOsAdxZ2m4/+2Po30hxxW+4tWXjxO/E98UBaP9nWHqmYPFW40TXboq6Pvm+f7pmKKBMOIVJ2VFtaA+QFaTOFHGsvo2b9PDUA5WBi8jZ+E1gZxTQRCQegeQVOAeCDpLz3gPbAFDIjY4x74gRS5JBOpH+o0MdUp/4jW3SXNOtP008rR6zUgpkRis0pDjEIregUglNaimQljme2LPoS5Kg5O/wszMAsLALUGocNVeXBol3P/67b/Dl4ZYktzVTHjDxKxouebnlWIKlsjNIZHKBqYpRqg8p9qVzLm7S8VetvXzxLzk/+ShEI76rIZtbh4/lv5CKiHo6Uc5aCkj0WjNr7DVQhq3R40oJbToImbYu2AuAN2R/w2qsDlvs0IuHk1dP0PTJR5e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(6512007)(6486002)(52116002)(2616005)(6506007)(1076003)(26005)(83380400001)(186003)(66946007)(66556008)(54906003)(38350700002)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(8676002)(8936002)(38100700002)(2906002)(6666004)(478600001)(45080400002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZVsSa8cSn5sCJApdqYHtcwgz/dAG7FDAz2tJAsotcFJPb2cji82Wqh4BjWc7?=
 =?us-ascii?Q?8kXs5eY49nmZDY9ZJr/ZFKWiuRTTVhtuVJ+9oN1vXxTpB98YqH5zSiTkiw3G?=
 =?us-ascii?Q?2VtR3Bal++yRkL778qVySu0VKECXxwhOXDF9FV8dXFWlhdwUxedJKj0b0Dcj?=
 =?us-ascii?Q?ygFiTR9RA77m9E1hGX2tKLG808powPszUoXeyGsTJ79Ccbg0tvOtc6F7EWJa?=
 =?us-ascii?Q?PLOr2Wrsgp0aSvuO7d9nw4MIi8XnZPVET/uDFfaN7A+NapY2qXhkI0Okcqvx?=
 =?us-ascii?Q?5EEqvwNijvtS4ffPqoESHze6uSarfA2M4NVWbi6moL2lycZOUcFjEvGqRJUn?=
 =?us-ascii?Q?jgvV18aA0anUyKV2Sy9VyUunh+S2B4B5Vfrhs49irTrA5euzulvae33dgiMf?=
 =?us-ascii?Q?qbqcFNMmoaT476k4enI4GlpcCvETM7xB7ln+Eu0VPOcW93N1QvLvqY9FDtiS?=
 =?us-ascii?Q?L48KaHiaT+mchh6GHSeZUtdT+lMquwiwJtxXBAjTQA85VpxBQiZNtbsBVCBI?=
 =?us-ascii?Q?zsIZEmQyS0u8A8gb6DUqvSHoaa3mRSP1RS44Ej7GchTzLY3RKDxs398ik4MP?=
 =?us-ascii?Q?Hxs/4HXSnZjwEP15q4mKrHAKd2a1hu6gBfSUaJCAffE33HsglgZ1htO0vLaO?=
 =?us-ascii?Q?zvh+pzSkISAJdnKbXMvR3SN+lefKjkcPyUThi8qxvc0HpBCrDJnXSl+rkx1y?=
 =?us-ascii?Q?87VWJMV53kdCLucGGte0+JAR9iOFV1OMQOpEWFTntaB6k8y+Ruxhw5da1XX8?=
 =?us-ascii?Q?HQNTuCP4HlvGFO3jLxPqsme2EccIzpVCDqRBUtBjcM6JM72sbL5Gx9o3nL1q?=
 =?us-ascii?Q?ir9g1h4myfDlwPh45tIGso2CJGlvvJjeyFRBt8U0q7QYqFUYqAtR95GRYt0e?=
 =?us-ascii?Q?1OVSKrza/XwM751Fp+guybqV/QscTXY78PN5MvnkcihdSqyF0prCUb3i3qmm?=
 =?us-ascii?Q?1WwekitVZMnRJbA2cWWnJAtTXPtkYHuDjL7fg91qqcHBhWNSrKCyeKBRjlij?=
 =?us-ascii?Q?y8Afqz4xXIR3NvYnrELSo5dcXqOlHa0+0kldFm5KmawBaf8tJtT6zy/VrKEs?=
 =?us-ascii?Q?A7eC2mmw2cLQ/c86NkmpoHOn5eKbwc7G9Vud87EW6D2jtk2vxAy+OtsvHhRd?=
 =?us-ascii?Q?eIRSeAYeNQs5vHPeUIGKmpMoZrVO/Q0DWYpujtVgVqnjkAuVyMyrRMpFI/4N?=
 =?us-ascii?Q?oRv6140mx0v/TIO/rjfVYznH5bpKs+tXgwuuhCTRR5DKM/yNExsmiw+wG4+g?=
 =?us-ascii?Q?R8aO9+sDOH8XUCjdhrLsD7fIVl9zFhGKS1M557wgGj0mrb0EpojN6W7+7pEs?=
 =?us-ascii?Q?XThBSR8I2vHe2oG4njZfj0EDA+m8V4KJqfv0klMnahMiD/S9INu4GIXWkg68?=
 =?us-ascii?Q?vyRoXK1AyivoHHR/EU4DuRSAgktdfXVPN+nMTFo5gl/OOgfGpIjIFV5puVdn?=
 =?us-ascii?Q?go4zkNZdE4Sh9sqdACiUVBjzr6enTuJfqDp0MdorxWy4VXqCZDTAGXxtjqoQ?=
 =?us-ascii?Q?FuUpURGfHNUX4Ch3F1lL+hkMKNTEqyxToa8VpASd8mFb8sU8auRGC6ktDgeo?=
 =?us-ascii?Q?HfOzyAdwwpT5QNVWI1kUKY4YCyW+eFnc6Gj6g+Yr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e960e039-c3ae-4c2c-7af8-08db91a4942d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:00:25.3152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqSXfKApVvwvADQ1JB877odIvz8fJcYpYbcSvQg6CtMusEYa3KuDdX+52/0/HglxoImJmYoAWFRZ47qVrYJ+YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8229
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

Use blocking_notifier_chain instead of atomic_notifier_chain, otherwise
below RCU complains would come out since unregister/register_virtio_device
() will issue mbox message (mbox_send_message() is blocking) again after
received M4 partition reset. Actually, no need atomic for notifier which
is so tough for user since this notifier is called in worker instead of
interrupt handler directly.

[  389.706645] i2c-rpmsg virtio0.rpmsg-i2c-channel.-1.2: i2c rpmsg driver is removed
[  389.767362] Wait for remote ready timeout, use first_notify.
[  389.774084] ------------[ cut here ]------------
[  389.778729] WARNING: CPU: 0 PID: 397 at kernel/rcu/tree_plugin.h:293 rcu_note_context_switch+0x34/0x338
[  389.788131] Modules linked in:
[  389.791195] CPU: 0 PID: 397 Comm: kworker/0:13 Not tainted 5.4.0-rc5-02977-g08f78722f07b #26
[  389.799633] Hardware name: Freescale i.MX8DXL Phantom MEK (DT)
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

