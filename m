Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AB97B7E04
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242219AbjJDLRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242209AbjJDLRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:17:32 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F83AA1;
        Wed,  4 Oct 2023 04:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/BohecXWzD877Bc1yhXEzizt6UMX7BIYl331jZHWfXkLTpb2cvpqga77jRtG98pqP3sSX6BNTt6plJYYr3rinKCXfqHF5Q3VlyXqrLMWNy9FxEa6GBKZMfb8p6yOzTRV0zWqj0wir3UvFrwmsMXwgmHZl/C7FbkiWJVQ4XUWb5Xh4RtqKtpauvHFaUZH7Nqlkarze9eKOhWyNLaSO3gdudOJq9lIckq/k8swWbxEWYqyHVqOYTJ8DAy2R4gj5dOwYTP2RXWr7N6NJPSip7Fi53JqD2HX8CuGFSfsfs95BoDpNV4HCgthVWLuAldoUBDPeu77L//KzcTfBx588zQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUhszzw6Eg8/yiEvcOL9JdV3piTNEWQts4rWeH5019c=;
 b=dnD0idSYElkKUzPIv8OBZZQF1hASYR9+s4ijm2mg7rGxPxjbUT0Z1cct996eVRWgrrTKnp/iLNwaS3VAn7HHWD9pvUjHKX5uzwHozosvrt6roXO1/FPny+Qs9tPjpthUTdfQtVqCrkOmTE69rjQwxq4LUnEHmg9bInHnkBSfZIQOu8ytcYC2J1jdv0l7bXDgJAMxVeXItn+JVLEcOGPHkyQoJWKbH5/YhDsq+Th3L5NPTdJc9hVOH24/cJpi/VpIq8XRB+Hy5P6L26h8TcPgUqJcFAoeE9ap/OcVDzc/j9l0iKx10ejcTa/Wk5Vy9NQz0Ybuq/61XiNs9AWsGYiz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUhszzw6Eg8/yiEvcOL9JdV3piTNEWQts4rWeH5019c=;
 b=nUP9aLESNyCFYv5bKxl06OuOfqScGfGvcl6FwrMflXf4b+qaqFgaMiSdQ4BvfgqqJXxDjIpt8i0b+L9Fg3HWjJB/pTIIf/e4COTdK+wZ/2vKRsr1hVeLCvGEz300NPCMsGZC3aSiZ22TvbBCMgMrNJI0zjF1vkI+ldfDK9bAyZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAWPR04MB9911.eurprd04.prod.outlook.com (2603:10a6:102:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.36; Wed, 4 Oct
 2023 11:17:23 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6838.024; Wed, 4 Oct 2023
 11:17:22 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] phy: lynx-28g: cancel the CDR check work item on the remove path
Date:   Wed,  4 Oct 2023 14:17:06 +0300
Message-Id: <20231004111708.3598832-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004111708.3598832-1-vladimir.oltean@nxp.com>
References: <20231004111708.3598832-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0119.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAWPR04MB9911:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cbe6c47-8158-4e8e-b311-08dbc4cb7b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RFts6I4np5M/FYzNxzRVgKNPyeqms3AZpb+JUL6az0yjK/gPxZNX9zHnsusvWEDmgYLwoh+5D9b8i6rinqZFf8pNeics1FSp5CkAUqYf2Dtng29ictLRVlcqbG4sZTQSx5n/FgntcyZzRvUHvBrhjDM4/aHp4dUKV8a3cUpxFw6TFtLtI9zQh7NtLdduxX8K9jBlo7FbevEtoUHvZmJdSyn5PYRST/pPr0kHXNH8So21S26qLXZyFsEj3sHBk8cdyCjxuW8/XwPY0BxMHcQ82iSAn9D6a9gf66qysZKusFOz6RGTIR7gIwXNtEHY0DvHpLfFC2wwkOV0E6PbEuGZzV0N1fYFXwcKdn6UorjEb8rWYk4gdizCL3X+2SXYI91AFoUFS4iVUIhEBffbQ3pd6qDCgXZI7L0Vxg0viWR5opzFLv1NvV0hVm5YBMUraECXmSdQgU386xDMM11ZMiasr13IieKLb8mUELhvau1APZ+r5OKbe8bzgS/hTEpvIxvKTtbI5QMgJC8xREY3p7xX2d3XTKXJLfIQR+/PhJop4qeCOoV7B1aBpZpmsEW1cKNM4qJ9yUcQH6xXFIQ1BZL5KjpCxbZppsSbhC0IPNKz8JA3WBr6U1kmNXtRgOIaRFWC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(316002)(66556008)(66476007)(54906003)(66946007)(2616005)(1076003)(26005)(6512007)(52116002)(6666004)(38350700002)(38100700002)(86362001)(36756003)(478600001)(6486002)(6506007)(2906002)(41300700001)(8676002)(8936002)(44832011)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iRWMAiaLYadNca8S5A/VqBGrsHLHCBy8h/JeF9sF/iL2sJBwcWpzSHzs03OR?=
 =?us-ascii?Q?4Rw9qix2JIkWdxGuA6kl764KyBPlr9ljS6Ojg0X7W8n0ZVVEZXmk9MNGqCrV?=
 =?us-ascii?Q?UnXy4KRO55lbkqbrSRUTWtsHdeiQuzgh5c5by32PfaJ8GmasKon69u4wSZaJ?=
 =?us-ascii?Q?cASjgYU1uEiurMwiK+uLSTsSVU5/W4kWG/l+DZuoKCZin8oKmG421PNLRLi3?=
 =?us-ascii?Q?qhDwjZy+Wt03MYn4PYPvWont17ZcFoOT7+kA/0ydMA/Z3A4pF/InIsISst0x?=
 =?us-ascii?Q?0H+32TnsQYnplJvDUJJgmXdjh62ZE+EjXzthYUz9BH8a59CmrWNKA6Rs5r/P?=
 =?us-ascii?Q?TNvpe69ZCwKX9cv3bTrB8lNG40jFNq3+dbJTmIct5UAx+w7LsA91gkq6yOJh?=
 =?us-ascii?Q?D74PocVYRahV96S7uCQjTOg/d5fOh9tv0xmGc1D45FnO6OgSEb/wRxao6Rue?=
 =?us-ascii?Q?Qx6sMeKFXmxJMqW+HjFH3X2IqZLpodOZXeoHwugZi8G2G7IS8GBi1VnRcsmX?=
 =?us-ascii?Q?v5vj/LchbvhLMUJ7WVmc1x0oq1/1tSWGADYNINi+5Ktf9TnLFEt5l5SNmkX1?=
 =?us-ascii?Q?pHEiWksem6PZeTdJmG7ZD4uy/CiM5awGl4jyw8qlS4u5vCPrPL+061yppl0d?=
 =?us-ascii?Q?ydxTulxTjK9yfD6ZPheOaO+JRvwQ1pkuq8dFmyrMG2VYwlcv17GHqoPVGmJF?=
 =?us-ascii?Q?VXP+Coim8NY+Rgc/sLLoa/meVo94Dd8hwPB2/amThcjtUJwd0rD7Ip3NujiB?=
 =?us-ascii?Q?gcTEpD3UpJKNPL1WpFyFMAddxWJQrhbfsEwMPe7fNfR8bAKxvvFFT5+rx/KS?=
 =?us-ascii?Q?2jY93ueDCbxEJ2G6kuwrJLJkcK+yfhYqQ+5NohH06SI/0coqeKtx1ovdT43Z?=
 =?us-ascii?Q?lReR4wZFvXqm5/NOxZegJkv6eVhIc3cxfjsIYGRg+HX4Q/9JBRPKnGjPlv0n?=
 =?us-ascii?Q?6fRe/0YThlPIu1LbcupaPJZBPwET7ZxtBIuUoV9OZ+sAl+VFrXRgyXru/D5Q?=
 =?us-ascii?Q?4Rj55TP3vTqvO5vRfd6CR/Apzp33SLCFomgYpLlXEtbaNNd4NjuaHmKFlF83?=
 =?us-ascii?Q?M+0RaomIhWV9Bq3RNbesucgFfGqiYTQl1RnTIZFWWxYmqFsrXOnWw3IuOwtv?=
 =?us-ascii?Q?oOpc32WJ2CuhX5OMF1MKxDt0mPjK23nVXOlf3Vdr+nM0aW0AvbWa5E5p0nTA?=
 =?us-ascii?Q?JjZ24Zx0hB82giThhLBcPx4Feepu3W7jRyaUWJgQNUf8KQ+ABGZrTvWYu4XX?=
 =?us-ascii?Q?hpNZXexsg1dQgad2EM8WblCARHtK6awQE33dKeRrVD7Zcg5BW+5c6Oj0el1Z?=
 =?us-ascii?Q?tA4+0z+QDLWXdAmfKeTZ6mhtFSIohOp0KrexpKH/r7+N8POL6LP3pL7hlD3V?=
 =?us-ascii?Q?tYekV+GImTQvOd+aa1XdAStOlgfUrj2RDwomsh8mjooe6/lEcdfdNU2oHTBQ?=
 =?us-ascii?Q?HPTbqWZXMxbsFJyJHc+5pglv7ozY/5B7VQAI84X7WRA7qF+0SyAVM4exDrm3?=
 =?us-ascii?Q?Z62I8pQun8CF1kZWFKXlEVBn9SQad3/EPkn+ZPQ576nAvsKQeFKPOLmEnvMo?=
 =?us-ascii?Q?4zkr2jcxS2Eookc5aScO/ZXiKJ3XushEeDj2LpGfF71hatj9yjGO17QfXMgH?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbe6c47-8158-4e8e-b311-08dbc4cb7b3e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 11:17:22.9544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qPGDykns/ZwvDUzJ/t6RQLDe3pM4sBfSQ8vuHMuyoZfrvJmDaHyCqe/tYvEkhzO0SoVUVPJC0ZaXIGlYEDDPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9911
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

The blamed commit added the CDR check work item but didn't cancel it on
the remove path. Fix this by adding a remove function which takes care
of it.

Fixes: 8f73b37cf3fb ("phy: add support for the Layerscape SerDes 28G")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 4f036c77284e..c6323669f119 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -604,6 +604,14 @@ static int lynx_28g_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(provider);
 }
 
+static void lynx_28g_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct lynx_28g_priv *priv = dev_get_drvdata(dev);
+
+	cancel_delayed_work_sync(&priv->cdr_check);
+}
+
 static const struct of_device_id lynx_28g_of_match_table[] = {
 	{ .compatible = "fsl,lynx-28g" },
 	{ },
@@ -612,6 +620,7 @@ MODULE_DEVICE_TABLE(of, lynx_28g_of_match_table);
 
 static struct platform_driver lynx_28g_driver = {
 	.probe	= lynx_28g_probe,
+	.remove_new = lynx_28g_remove,
 	.driver	= {
 		.name = "lynx-28g",
 		.of_match_table = lynx_28g_of_match_table,
-- 
2.34.1

