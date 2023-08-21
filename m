Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC0778217D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjHUCfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjHUCfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:35:02 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8C79C;
        Sun, 20 Aug 2023 19:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRpbTQHGO6AWTMnkBd9PCli7/ukXVmo8EtthHR5XplztMjRlfvmC+PpOTYKCxOnwyo5WstVbaEkyf8ksAhvgy2g1qeOXa7FJvEf9STysPd9AF/dU8Tmu5JIsMmUhuJD5M+3pO/gJM+mjl6pOGCnfs+bmjOObopJXYAdB7qaxUsgNZ/TfBshm0gexxQoTpCV3WekS0SciL3/CKL87K1Iw+fhG3YMCiA64jNXmXfUGs3PqEPVxnkYex2rqOAJJCOTinr4+fUgL2e/6LNOR0EYmhpRTCX/Xo8hg1yfcrzICuv84YLQRjt8k2Vc9craDh8q8CdggFVeq2wlPiiZjZEO6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWVY63ydK5V/5molkt3FoV63FnrU+sYlDYUpARXtmrU=;
 b=fWVy9tW2FK2FHqo6hMwfJrJNF4EQfg5Xt4355ewN88cZDz4L/HqhtLbkRg9GJz9QLI+EqqUZPfjBKeKuygw5surGlPXzM0MiqnzYx66YiMk/fNdclEaHOcX/dvUPKZm0hqMYTd2Gwm2z+Pce6QNWVDHX+fLGhiH28Yivp7jJRdboPg+2/bO95+4YE3Jmlijlem72mXqky6hn4bsg5ouSilj3REohLXK5eXoojvv63l+YZmhfy5Tmpeos/4urHfjrqL4CQWRMrSzDqWNHgm7xEBgGgUJxwgMIx6KxLL4bgHCt7v3sgdITpNcW3DI3Oxwjie/F1S+5V9Ny0C62bHgpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWVY63ydK5V/5molkt3FoV63FnrU+sYlDYUpARXtmrU=;
 b=gok/x4l8fm/mTfMBfEI4H4pcvZNOhmshbOMezXMaWvD2rtXdsig/RT+lhkuXaxtfYI46KJxvO0QYFHpC7gC1LjbcEtPXLamnHFbxmu2ZT2YE8kYJ/f0KfRkawo7PXPoLxYZjUMU6iufldsEfbEduy1VGiUpUuoj7qkKBDKk0e1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 02:34:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 02:34:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, frowand.list@gmail.com,
        andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux@armlinux.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
        jeremy.kerr@canonical.com
Cc:     isaacmanjarres@google.com, hdegoede@redhat.com,
        ulf.hansson@linaro.org, rafael@kernel.org,
        grant.likely@secretlab.ca, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/2] of/platform: increase refcount of fwnode
Date:   Mon, 21 Aug 2023 10:39:28 +0800
Message-Id: <20230821023928.3324283-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230821023928.3324283-1-peng.fan@oss.nxp.com>
References: <20230821023928.3324283-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAWPR04MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: 32786c50-48b0-4b36-d0df-08dba1ef3606
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7HkwH69/SbN6eSB00A42kMz88AzlAGiBBW6MUAwSWRz27Bb5c4HU9lgESHdPMT8Zul2MuhyqkHNOsfJXW5JsPAWlJX9tm3fIWzDtUQrWFsPzcxMY2fFHHduR1M+exeg4AG4veV48Yg+npL0nEM4Oo+JOXhdRiOeY8ApehgPz+JNyWeBAZAOhhV03qRI+Y8nd5jzXtrOxReOtfxXwHdUKiXFkfDFLrZW0PSxwSPYYppyVyzugVFCBPW3MMfjx4z0EH3KbN+It4Fe0pgmvXSj56vgR5uARJsJNE8v5BDYa3SiHSUNgIAUFG5hc0MCAL8PriYd8j6emKsGPgTcgE0VliDgYKtvNpvDpGz2j3RLZzwQL0/5XWacNxJUwgim+6kih8ofOcso65pKswZJr8d6oT8hdXx7eEO1VG9Od8VhMHvTiQ/iXI9wk6QntvH6CDL2nKQM9dPPQsajW/7tDOQM7aeot2X5lOZ8hzmTITmUiafIw9FErUYudnjejW5z29w9eijEwrwdKOUITWpp1mN5RlC2TD+D0f3Y3gCPkhsAq6kqAFCN7BpEqWvWG+i7B6Ri4byzHG1PzBXreILfej9NLnhZCC60UKiSHMLEELN+ECwg9uPfIbv4OOA1XrnkRsebZgkbK2RUi7NuL9VOE1+0+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(86362001)(921005)(316002)(478600001)(66476007)(66556008)(66946007)(41300700001)(38350700002)(38100700002)(6486002)(26005)(6666004)(6506007)(52116002)(6512007)(1076003)(8676002)(2906002)(8936002)(7416002)(4326008)(2616005)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/0aIpUp8WJl/NAXPUJ7MFWUiq5YCtzlhbSx0r2SCPa/fo/8uTq1SHUSXGY83?=
 =?us-ascii?Q?7zdN7wQOscToKP/0hobVu5Do/lBzIqqlhSUlqHdV6Fsmh96y1H4RuG5b5mZO?=
 =?us-ascii?Q?AMfxPwOds6uhODzNKAygJY6S59t25OZdFckOnAky6vKDKc8ojoncHmSIa/Vm?=
 =?us-ascii?Q?0MJX+YocDXItlWp7dfJvKAsQTucKZNsnm66t86WLpBl9yAWiaQdRoRl3mmxo?=
 =?us-ascii?Q?dQWfbyOTOkfZsH0AYFw/WlVF4NUEFXA9CMyBkz0imtIfrMmgdbpfnjKnJtd6?=
 =?us-ascii?Q?ZNKGmM9K31cyhcbZmDfeXWPkjAs6GGHZoSztH/YswiaT1e60+atxtMrJZgFb?=
 =?us-ascii?Q?7xryR37bHUZcj6PfugDYi0C/ZAS+RO6dd20KV0DiLNQK3CddZHFMec+6Ikr9?=
 =?us-ascii?Q?0PMJWbdLiN3VuYo4B7u6wIIBkqQaEwGjLgUaOj+S5KARiKYRZNyX+wuppd4+?=
 =?us-ascii?Q?KeFpZsidddw4BMPpblOGzP5NeJWO8O64MiCLyN6ha/AQMeeAwRtcdw3NFayP?=
 =?us-ascii?Q?ZeicEYPuGhwuzXoT0jMk2xwPwOWxEP3aMQvePij2h5rNbiq6daMJqWtMMFQj?=
 =?us-ascii?Q?2W5lz38prKsFLjFFrg4YetteAYPMtIV9ItRlmhgal0wEJ6SdK/DnH6R2ouXQ?=
 =?us-ascii?Q?ykr8BwkQmwsLIoNE4ulJSj+McV+35+fa7kiCBa8Rd1dqAXmCGAPcif9NwxcD?=
 =?us-ascii?Q?fMZ7SjfwGXufGe+eTftPbehZu8nPo2EWgsgfAAdjLUvMSyGtUP1Ec2N+ipP1?=
 =?us-ascii?Q?WVUDnFgnHcC+x8L5W1kAgGC3gvYDEzueAU0pjGYvVC3TZ01Gaud/nZaGiEZ8?=
 =?us-ascii?Q?C85aOBo3LN5A/xbl2klXtDLSAARC/XHqnalTcWdfFHT6aGZqS8tznZAVZIod?=
 =?us-ascii?Q?gpWjyYQTxz/0BzaMYhvXQSwCgXF54+DREsweMlQ6OJtt8upNQ6mFs6Zt0W1P?=
 =?us-ascii?Q?RHMQmQ+gDUqDBuWYuheeSTFcxct11nHfMxWg2l7MuiXrIT/acSF0mmZ5jhiG?=
 =?us-ascii?Q?SGxAVgN/j3cGpWfa+IPGVxUD83s36QtdIO9Dcd5LcShMvzxbPX9viO46qYWk?=
 =?us-ascii?Q?ASyQ6mXeFP3ziuFZcyfR2+bc5a0dA9CmKSABzul7A+h94kjDDEduuAp6qRUs?=
 =?us-ascii?Q?WVwt8nPTzxTwqW4TnBN61FodZzHPZJUPXajUiDvanO6XDTEyUVKvTDAgzR1H?=
 =?us-ascii?Q?41U+P0KKokA57sOGfK7xiR7lvBBjrpJ0u9S0RdR5A1L8gbwnYabGspDzeyCA?=
 =?us-ascii?Q?I1KKNs8DjRXOFj9ueHTi88Y2EfsSa8CG7CTBIjnNvUefEJlw5TwO6d2PEztj?=
 =?us-ascii?Q?QOXJMNXSLpNa11xFJ0Kz6BRaPXqqB25f3OCTmxpptglXmBGQyNIOGeLJ4zqU?=
 =?us-ascii?Q?I3vgVe0yrTKi6GB6SBOoUIZGvqyBB/VX9Tbk18J+A79Fsv2IR5h+d5ug4Afr?=
 =?us-ascii?Q?VHfDrMfo/zjaKW58Bg2arp0tqdOtoDy5BCT9YNcTOsB9aPGWy0oNca/+goMG?=
 =?us-ascii?Q?jICOzrf1F8pA9KuEcdW45l/W2+6XW5t4+nwWM/YkHj+cSuu3+6Jl1U+ciPkA?=
 =?us-ascii?Q?Ra2wCr50B5OwYuWyCs01MCwVUT7abme3mu54uCIU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32786c50-48b0-4b36-d0df-08dba1ef3606
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 02:34:58.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpsarmZ6e9ozhGy+t4jrMxwReIYW0YRMigoFWUtn9EnjcWn+87QvQSJ9ZgyP7WAd83ylaLKGrDtbFNvIM5Csug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

commit 0f8e5651095b
("of/platform: Propagate firmware node by calling device_set_node()")
use of_fwnode_handle to replace of_node_get, which introduces a side
effect that the refcount is not increased. Then the out of tree
jailhouse hypervisor enable/disable test will trigger kernel dump in
of_overlay_remove, with the following sequence
"
   of_changeset_revert(&overlay_changeset);
   of_changeset_destroy(&overlay_changeset);
   of_overlay_remove(&overlay_id);
"

So increase the refcount to avoid issues.

This patch also release the refcount when releasing amba device to avoid
refcount leakage.

Fixes: 0f8e5651095b ("of/platform: Propagate firmware node by calling device_set_node()")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 - Move amba device changes to patch 1/1

V2:
 - Per Andy's comment, use of_fwnode_handle(of_node_get(np))
 - release amba device of_node refcount when releasing amba device, this is
   done from code inspection, no test.

 drivers/of/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 267d8c9a5612..d328bbb679c7 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -175,7 +175,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	}
 
 	/* setup generic device info */
-	device_set_node(&dev->dev, of_fwnode_handle(np));
+	device_set_node(&dev->dev, of_fwnode_handle(of_node_get(np)));
 	dev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)
@@ -273,7 +273,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
 
 	/* setup generic device info */
-	device_set_node(&dev->dev, of_fwnode_handle(node));
+	device_set_node(&dev->dev, of_fwnode_handle(of_node_get(node)));
 	dev->dev.parent = parent ? : &platform_bus;
 	dev->dev.platform_data = platform_data;
 	if (bus_id)
-- 
2.37.1

