Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823037B7E05
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbjJDLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbjJDLRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:17:35 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDA6BD;
        Wed,  4 Oct 2023 04:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8UCVZOFvUKoYXB9Uk5myr9iJOf0vvb9mSOjvszNXhS8g0DpxJyxh38qy67IPLaErsmPKpuVMWogZVRLOAQmSirScnbDjYP5bFZRAGYspez752v6r2+/1E/5g3fYwc/UPHv3K33/eJ18B9Q3PMxhUpzDXtvme3EnIxGcenoUEqqOSdP5N2PjcD2riS6LSirF5QGxulLFAvaikTnALrOXe8MI4V77bzq0rCODukEgCJMSdDz/79pAcI0D55WjMWFzkqC/+Egl8NMPkptQNBWt3PO0vPkV5QaEthNGTbJLtMhP9Gri06J6hOQMoErqlMPgdh38WBsY7Bva4Q7+QqJe4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGoIo37IfSbBawdoyVc/JL0/ZWGDg1A5XpIqUx1V/PY=;
 b=SQIdVg7WMVkRmzMqdn6hq3XUK88MvASMYWxoFJ4A6IUvuzXF4fQc+y47L7R2DvyTfbui/Nrli7Ue+bCuMablREl5a1LWd0xA3q4b3QcQd/63r4kTqumvb1lbV9MygQLiG4ejbIzw88x21Z8UvhKgIXcwmeZ5XwtyV+/idJ5W5juYMC+z7ledyU27VE7b7TEhRU2n7xUFZpd/UbpGReog5SXCobXvzJQ3OHSz4bf6fjoAMcsNLaoFZmQijonvPngS6m5LlmKOcKZdV2p9dLjLespfDXuVkY6L/1we+Z/SqSoghTZOc5po8FUJQhWxb17vTZ4kOMcBveEbg9VjEq9y2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGoIo37IfSbBawdoyVc/JL0/ZWGDg1A5XpIqUx1V/PY=;
 b=gQfIlXhI5XBFAZgWZ62JVwta/cXPvZs7DdkRcqNqg4+/P3pKrVxcp/3RffQf+nX6H1a6Byj4DwNhT7PDmO9XCbMAPwd6vumnUsQCQ2xjGWjsEweYyt/t7qu3WYdzKs1DrLENZTYmpXtTqAXt5qm/WPhOMktQaoP6nCIFVF5AB2M=
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
 11:17:23 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] phy: lynx-28g: lock PHY while performing CDR lock workaround
Date:   Wed,  4 Oct 2023 14:17:07 +0300
Message-Id: <20231004111708.3598832-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1dccd4eb-9bb2-4b9f-c045-08dbc4cb7bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXC4MJrVnvaSlIppsm7Y/XVu7o5IDxzjDQtSqPq65+/kxHG5fVX9CELROo9p0oMqiukiLuV9InBTzkFRDKl5geyG+8UNw7sTtLC3hDBgSKLefiV+PFzO6I9GvQBU1UnWSXdi56OyJ7FHCc/xCJFA/hlI59YoEGKzvbN0AnZmX2M5m4pKARAb9nkcGN4WzpvXtqEP8YPhyFcU725A2KDEG5rIxI14S+0tGbchT8/Uqm52PiL1v5LaanndK1vYa2ZRJtl1hOjQnjJjbNYP64xeJpLI2T1w4PVPRbCE91QIV6GIwPHls7LFJSg4kGH740vLfjIx+dPBpnBp9ymmOQw7zuvr8hPBjamFqcZFGWPfvv/pSDPePHy0YTggYfW31A1tyG/otVmU/hdkRmDE0zGnFq35qQEsRQSfGcIayKPHkri3q/eeCtTgbHbZo70lnorbZ4WGI9cp19+N+gMkax9l28b1BVuwNISvl8j1QATFbB1T/aiy6TaVA54mhbMCD87cOKxxQgSapJwdN9QHga8DjxukbeeWRh5WFZtnXn27rBJNrcWBwCbLqZn/qTKzUfyLRtiCTD5TkaYSS6rRHaBlN180w4Zkwdaj+prfKofTIFuy2TGogw9qrYvHmtvFHzFU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(316002)(66556008)(66476007)(54906003)(66946007)(2616005)(1076003)(26005)(83380400001)(6512007)(52116002)(6666004)(38350700002)(38100700002)(86362001)(36756003)(478600001)(6486002)(6506007)(2906002)(41300700001)(8676002)(8936002)(44832011)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hHb1q8UcVtq/gk1mxoILJT5FqqSqdk02ziMUIYnq2h5D7t2vnvMtxbIYt9St?=
 =?us-ascii?Q?Iz367iNqteE8wXgJa1d/ZKbYsyuEqFjn9OtRyb3Wt5PNjTOtAahPK3PGy5li?=
 =?us-ascii?Q?p+C4Y9e2FHqi4/dnLslKIO6bZr9YoKYdI1XW2QJ04MQkvZBXEL9G+V8CNwJ2?=
 =?us-ascii?Q?t+2azDDy31TIXY2G8FfM8EOLfyAUla0lKA/Kh3JFvk16xghvJWx4aeOHxNz1?=
 =?us-ascii?Q?ktcYrrPEVVA4okdKDcVaDpxex1OlnJ2o3oFBSzteL51e2R6Cv2rVnvuiwLWr?=
 =?us-ascii?Q?xNu8rx13H5ydMJyKbVh6uIRUZK9qCgQRVTD6aJXBuAJ2XR74JS9nspRXMGQl?=
 =?us-ascii?Q?cumSnia1xtd5wvD7tviiETqn7KubSgr6SmrWRFw0ivv4sBX/tsF5Lhw+Fj2q?=
 =?us-ascii?Q?0487cehYMOYCUytCVK/6oppB/5gCExIlWHaSYtYvH9gOB6z102yAByPK4EkT?=
 =?us-ascii?Q?0An6V7UqC0z8lFtsCCXxjDcXqwFHZ879Db01mMEHj/XiF+cNd4VKsOF+vCbg?=
 =?us-ascii?Q?/G7d/iihansvPVAotcQyo9FvYnIyqwhCYpzrU06jlpOUuUe5F6ErBIAVkTBJ?=
 =?us-ascii?Q?+xjbWjD+JFzmz1jtqLYJ118KcApr9m070lYJ7dNdCUXQsA+nR+tIbYLgk/JH?=
 =?us-ascii?Q?Av9W65/JwKJr1CYG2K8CIjHbM3PNkGpW6LI7uyExbn0/2NRYv+n9TLZ8hPtO?=
 =?us-ascii?Q?3xeoSJCk1zoGjMnYmTLBuntEKgNk3Y9oc2+BtTpKHkxkg3t8UxjvxQej+FNQ?=
 =?us-ascii?Q?FuQymzViSzFyZdeMLAWYpVJY4PmeVv/A3darebdTY9e5rEkyl0gxMbImtXuf?=
 =?us-ascii?Q?UZitE+PlEBu/57+hMs8a3bTVzQJb2PORfI2wtBwcdlyyw0QWuxPnMgqPiNog?=
 =?us-ascii?Q?QzE2WA+GjO9SGjzJJNdJZddt37INg2HivUYNJZB86YyYXuIOgR4x3xEOakar?=
 =?us-ascii?Q?qk7JGbeJm537i3pXD1lSTOFii/WwbjBaAnss9p9zvI+1kHp35SMhLt2J4FTN?=
 =?us-ascii?Q?MnZViBjtTtkw6w9ewzZU+qUK4I5zsheV7HrAG0SNwj5HBvXTyEPIiVdYCclL?=
 =?us-ascii?Q?yKSDQNpn2eY+7BI/sXt3qIEt8fg7tn70NP5glYc2w8gRrLbHJ7fmP67SUj4A?=
 =?us-ascii?Q?Ks+BDTHcsShzqsVqDBbKy+trLBBDXDrLSg9hcDCTCVvnP6qnZiXYSudCbRiF?=
 =?us-ascii?Q?VcGKaYDPMocWEkMWIY6TrLqYXQzEytjjh3KCaH1kP+chtOui+0PghMYpsM+x?=
 =?us-ascii?Q?fWmXq0wa3ygS4DC/zs874lQwrEKQXRzHKb2W7UAiDm6YnsRVMd2+aWHdxumo?=
 =?us-ascii?Q?O4Kkmw/XXFvJ4owcYsFAgO3uPpFdrvtzmP2sSwZhDuQUCBiBNVX71fbbNzlx?=
 =?us-ascii?Q?SoqeofJGpr8dOqZF3kINKdHaZJeiw+A7cCG50u14bgxLqeCskfspGELUBjO2?=
 =?us-ascii?Q?TR4+4rv1OxCPLHVfDqIWbwD9Dz4lwcSQpg5y+kx+5i12gSZkHfhOihP2NIeV?=
 =?us-ascii?Q?GzwFtbnxp9lxtRCAmzyjsDpTVxh3ZptbUn/FPBjsIU4PCLIRReh+uenR06cQ?=
 =?us-ascii?Q?BaA9fxWtM6Es6FvpaWsxPt9u8I0K9LYg5BqfggO7ae3hx1JQCpZuicPb5/P8?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dccd4eb-9bb2-4b9f-c045-08dbc4cb7bae
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 11:17:23.7218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+/5o+Dbrs4h5xCdQp3u6iQUJBtCoyAbDUOutHjtVYmMQ/ClMI2SzVz24P9/s9gGTVNhF5iXgo6tv6uY41NEuQ==
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

lynx_28g_cdr_lock_check() runs once per second in a workqueue to reset
the lane receiver if the CDR has not locked onto bit transitions in the
RX stream. But the PHY consumer may do stuff with the PHY simultaneously,
and that isn't okay. Block concurrent generic PHY calls by holding the
PHY mutex from this workqueue.

Fixes: 8f73b37cf3fb ("phy: add support for the Layerscape SerDes 28G")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index c6323669f119..d5385d36735d 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -508,11 +508,12 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
 		lane = &priv->lane[i];
 
-		if (!lane->init)
-			continue;
+		mutex_lock(&lane->phy->mutex);
 
-		if (!lane->powered_up)
+		if (!lane->init || !lane->powered_up) {
+			mutex_unlock(&lane->phy->mutex);
 			continue;
+		}
 
 		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
 		if (!(rrstctl & LYNX_28G_LNaRRSTCTL_CDR_LOCK)) {
@@ -521,6 +522,8 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 				rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
 			} while (!(rrstctl & LYNX_28G_LNaRRSTCTL_RST_DONE));
 		}
+
+		mutex_unlock(&lane->phy->mutex);
 	}
 	queue_delayed_work(system_power_efficient_wq, &priv->cdr_check,
 			   msecs_to_jiffies(1000));
-- 
2.34.1

