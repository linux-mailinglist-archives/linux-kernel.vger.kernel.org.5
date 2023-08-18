Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4760780391
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357131AbjHRBz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357135AbjHRBy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:54:57 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2055.outbound.protection.outlook.com [40.107.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E708C2D58;
        Thu, 17 Aug 2023 18:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh9fhT0KSWZx/+E48QYL6wdpiJfj6E6LZEYD6K91tUcKdsblMQ+Eikii976lTuvZdbwEUeYJalQnIettRTRKhVgCAm0GsUG/2lfr8hi6nWQC5QNVcfimb7BP+XlA82J01z8IWReCKLzX/qsOzMRJKaZMY8+H7IV70UmCVTIhLiBY453D7OHcz2LQMHzpOngcyvXter42sYdCmdwMaIh4uKAorwxz+u9B2KdUa9MXXrDCyJVaA60DqgZETGqolExMDWL8EdnF52FKjATJZiw0OYxESsNM/lRobUBTc1A8xieUFXf1PHjT3MF+RtB1J0LkDh1WpYrJTGEN3UpMggSTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JajERYEhFC6apBRpI7oHFnIGgo9zPZ1gtssA4rXeXPc=;
 b=GmuWJkOqe1x/BLEKhKHiPRyvb70z0UV+dLucl+ocsyDmZvU58BvcWyN89hUY28lSxVd26bYjajLgJw/kKQo6SakaiwutEZ6LinGTeKNBSbu909/ZO4fy18JeA+wFiDcGL0ABdmoMHBLmqNVIACpqgzidDd0z44AHK7mZjq6Wi52+OxTjRxCUKMai9qf4GqeuwA9R6ZENQrQqIGGEMdu4tb3kHDxN18C3reWIaGvdFAcZNqnnrcpNjj/Bf2FF2mU0zTLL+CxUyyEey9pacVj1U+lMuGig/2/gB7+05BPdURM6YFOI3yrdZlKen3UPLFZ2u0BmIXuaFn35Nwejfeq6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JajERYEhFC6apBRpI7oHFnIGgo9zPZ1gtssA4rXeXPc=;
 b=lqDPeQrf3fX/SdnGswjx1YCEbrQZSuKipzvHtUWHsNcPh210R+eNiYYwLE315CelbxzArwyRagBj54i5xxSI/IC3H+9H/lqPDg+f+8Ko1kbD/aD29rxqpsgjJhTQdnZ+j+qMR2KuZ1tlCnEbP3NUsdUcB/sR7hVVdvkHy75zYlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 01:54:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.029; Fri, 18 Aug 2023
 01:54:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, frowand.list@gmail.com,
        andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     isaacmanjarres@google.com, rmk+kernel@armlinux.org.uk,
        hdegoede@redhat.com, ulf.hansson@linaro.org, rafael@kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] of/platform: increase refcount of fwnode
Date:   Fri, 18 Aug 2023 09:59:32 +0800
Message-Id: <20230818015932.2650041-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 5354d20a-7028-4516-66ea-08db9f8e1d19
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KljuhzFd1UnCMCmBi034gvYuhxTnSXb8EQ5B6xC+dhBcVcziz24eQzMWETm4YoCf/kHYIr9G48LfIHQaJdi3K1VZwnTTSrZ/jYtWiHNgTC4V7AFGLzUvC681786AwVryYeShKExZdNx3eSHMaGzw6hGrP7bxUdKXWlQY7LTW7Z0pcJWRZBQh6Mj45RgX/53AhSh2Jd4Kw3xK4Ab2RRjUBtU+u7+0MfTdW+O6EG/RI/UUJxLwIWq06lEc8VrdPsoazvsKGurI1rRT0B1GAp1WDxJNWIfmzqc5iKH7sC+R5wosXWBLcBtkD4Zcc5lkRy7rR0hLFv4Aa5inBWdY8QaQHHR3b/C21TDfLbjRr6/pCwcrDq6gsWFU0jM0az170qV3mK7JDv+zEUSex47aRs4FXVwA0Ouns1/n+1t70miD/Z5Q/+7mRG4RRDL1bkx9sZSVHnp/+6axvyfoO4Bc2emx4xOVLStJgDuBSayUAywzcWoEhAoCtU+baekX55hfYGSE6oTc7KZXQNxbu4mH/VxvJGG0oVwGMv7Obrv+Qd/Aqn28ULEPd/UxeJ7HqZM3BhXWEL39T8L4lJxo5WOD6PWFILq2Ci7ebZfEzmetId4M6wqHHsXkBulUoDe63bzlFSwp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(7416002)(478600001)(6506007)(6666004)(6486002)(2616005)(1076003)(6512007)(52116002)(5660300002)(41300700001)(316002)(66476007)(66946007)(66556008)(4326008)(8936002)(8676002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cLXSOiwJj7h/dV6J2TWKciWi4ZNcIusvss4V+u7yhU2edDK5FG5qpJfL/cTA?=
 =?us-ascii?Q?5BaDCLs1si+uXmpxpzNBOX4AcideSpuyyKa9ZoHghxpRZEcqALND9Nhatv2K?=
 =?us-ascii?Q?VXFs9+pmWv4Izk6c2U5VutMlfUvHkcAmnjZKzDeqVP/a4GhUjRtDxWj5VlRD?=
 =?us-ascii?Q?9RK1lJuQNdR+ZNSJJAG7HNlRE+q5Hut4ezGJ9R6qxQXLv9puHlnoQyjnCaTC?=
 =?us-ascii?Q?E1K86gTRYk+OtgKHVk+ZuHXR7KEM00q56CPSFd5jrvL1B+XrDi1ga23EqvWU?=
 =?us-ascii?Q?snLJnzBeC2ZC+VkeRB1hp1SKDK7FIs1S/OiwJFom+zwuqlj9LYjuruNF40Wg?=
 =?us-ascii?Q?nub9d1gFCyyOzNr6MqsrkpIuMIjoYqQyxG+TSNFKYZGUD4Sx2VuJ0HNXGf/1?=
 =?us-ascii?Q?baqNQ7kIUGnLQPgW5pg83emaJHLovWQQ/UyhreN8ojkQNBka4I62w81oC4hi?=
 =?us-ascii?Q?0IMA+qLHSWp1kiUCPXacCeD81p5cKxELb7AnaKX/pUHOHybPXphpPW3i9tay?=
 =?us-ascii?Q?Z5Ej/X/25DNsnjUYk6rz8I19T9y4tzUKrYFO3IfvJYHoFiYHY6957oafFHfY?=
 =?us-ascii?Q?V/iDEixMq/+wCAOEo9hkl2cCjgmvFBSrkk9WxQe+6E1nxvyBRkQIkaOeD2KJ?=
 =?us-ascii?Q?UwhhdPyYey+qF+JnpUHap1NK2xvJJ6ONZ4tmGeDAk4AcjoRDIiO9QqcU9way?=
 =?us-ascii?Q?LyuotlNPUUMgqMdyyACczSfCAgzQOA09yQ2tSI8XjGQY+rfzLqW+SO79hEY1?=
 =?us-ascii?Q?sCT+GEEDwS7aJBesYFvEZg7dtRoY80Paq5pkLAzZca3HU3TKA2FSoFOg1mfx?=
 =?us-ascii?Q?PPvCC9rQyKJ5OsqYB73GcMkVvjWkxoS/V4yqNucvsdN3BEknPsdp8w75y0re?=
 =?us-ascii?Q?O3Pqw5DEgjvCN0JGnwUGnWHEJDhsIb+PB1FOZQg6/HabJ9KY6STFR7CEuY1a?=
 =?us-ascii?Q?IScVwugfE/YI3iCoId732A0vtqNPUCTxJX1yf7fzp5VLllnHqWMiAWcsD3LG?=
 =?us-ascii?Q?71Nrr+fnNf498CgNVWOYH9YnfaJy4HukoC8cX+9stlCuah90J7Bx4sC76CpO?=
 =?us-ascii?Q?0jeCVZzdoOdIG+YTnvMHiyWlrBvArWzRoAWcTdsb2j8JFAGRY3F1I53gGoMC?=
 =?us-ascii?Q?6J+fyFcZvqEZjc8phGvF4jdidY4oaJb65BqIKvC3jDgDRzcZxcWADlOgcJTa?=
 =?us-ascii?Q?25vEwzsyEKHmR22Z9JjTOvABHFlmH9mQAQbFxhlqNWAjVw+jHKimrfAqghDu?=
 =?us-ascii?Q?hS8qQz5nk0NHm/yyCGYe04jz5zLJ9P9zSqd2K2fKSNecr6YnsVw4Z8+bekOx?=
 =?us-ascii?Q?dAQQUXCMpqJP2tzso1sPaxrTfuWsm1q0PbMNMsU+vfyWajNwjbHoWUfEWhdz?=
 =?us-ascii?Q?XRyksUwszHOWtkKS+QZX6kT7Io2UNdv7nnqS+xv6RV/azxxzG8Pz7FpOIRKN?=
 =?us-ascii?Q?uiBoYdFC0lua2G8rYF3tXV/o7jG7G5Dk/5aenibI1yoFeK0gXZp+gy8no2d0?=
 =?us-ascii?Q?MPXHHFVd+zmvQW4SazGIO2F8209tusDpVQopJyjOITCtiRZc/K/Eg4oH99Zm?=
 =?us-ascii?Q?NFYDNdtTzYIrs4h4H97yfvaeVnaWxXHv5gzsEEZW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5354d20a-7028-4516-66ea-08db9f8e1d19
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:54:52.8821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oaXxy5ikHYqfxCHNrkIVohiYeTtH4klJR+Pe53+ls2Zll2BAyhUHpsyXFLNcL9rBPCBmoe8cwvzCEIUs1me+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8774
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
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 - Per Andy's comment, use of_fwnode_handle(of_node_get(np))
 - release amba device of_node refcount when releasing amba device, this is
 done from code inspection, no test.


 drivers/amba/bus.c    | 1 +
 drivers/of/platform.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index ce88af9eb562..09e72967b8ab 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -528,6 +528,7 @@ static void amba_device_release(struct device *dev)
 {
 	struct amba_device *d = to_amba_device(dev);
 
+	of_node_put(d->dev.of_node);
 	if (d->res.parent)
 		release_resource(&d->res);
 	mutex_destroy(&d->periphid_lock);
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

