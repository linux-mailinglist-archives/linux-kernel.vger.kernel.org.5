Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E20769101
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjGaJBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjGaJAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25639E41
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgbVb/k+4srGDlepwgQqaacRJviSa7Qvw7zA+bPNAGFbDPBymKWaDkv+6/qNmzBnfHQDytybt5OZu+avY+ryiQZs8HhcJoGe53n9rxp5QHrQmTSXKcUf97cUvRiTW9IGMhquI8Wk9nnFz77ASWJaOnTiduOG6HW0NCiHvh7SJumc8S4zLcZCNWgsTtCa63MRnnveHMeS3nt66LAqr5b2ZXQsIbdvJ0OkdXyFEMF3VjFcfdU+/T7YWk26VpeR+nZbcdd27rGglab1do+bltZtfla8bEdbCcykZdr81xJQ5E60o5ZQlGq3E29yMeAGHmlUyZdCNyGe/y0WrJfwdjJ5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oI4tLjdGvrvpQt5r0xaIf/zZnKlkwUrXvNkzmXrngp8=;
 b=kGUCqVgVEjukKk1MwpemnGtpWEJT+ldVRO14fCqK7hm8LlrsdPpLhiifAa6vunWTqOF+gr4/1tCHOB+VZ/WoJYY1P9Q3alAW8K+rnLQZ/sxGDmQ6ROb/4GdfEIg29TEC+snrJ6rnuAZ5FCWBHQFAvCjPPvrApFbqUJD8LNTfa3MjBIfcWmgADCVmMDskY23yfyOqSP2JDRhw4Oo7wFPXPtN6c2zV8CdOkvvi4VE8gyiCbapfIWhqBv93muLuGPrbFr94WDk7A+9l3nHnPmtRFeiHI/Q20Hd8GotsLboPim0/u//xZkeuU1aDYSxKhITKte+EyMt4z9NVJCavDRTY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oI4tLjdGvrvpQt5r0xaIf/zZnKlkwUrXvNkzmXrngp8=;
 b=PxHSbupy/v1RP6LRw54c8FzIoX3l+jHEs9vwjl9FrpyiyBag/o0xmits8ZayVN08I2N8Kbfdnm17AVMSoMRuo6FwqukZzIYR+WnI6y4lBroFKIL1w3j7VG969Pe/zHxX8cYv5UBCN9Ty6mOhlT+I3Zo8vpDL0FLn4z3E1WPrGog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8229.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 09:00:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:00:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 4/9] firmware: imx: scu: use soc name for soc_id
Date:   Mon, 31 Jul 2023 17:04:44 +0800
Message-Id: <20230731090449.2845997-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: df9e018c-7410-47d2-1d43-08db91a48fcd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P3PxSxpsfvCpwV+mSWVhP+vmykq/7O6Yw8zpkKkbnvZ+wdX251AM/W2O9tnDI+VCeaddM6ZeAxZ4Pkv78fKmtou15GUCpebHiO8EEiQSUqHp/oFJmgnsF7SNFxnCwfvu1adkG3aB6wsnYJzPxISeH2UC/dZLoDyan72iK1C6/r4W5NXqDweTKWjpcE+hpB5xdG0niSaIFxry+v3F9UAOjIKIoOjTeQuHB7VXIVuMkE14983XrFQvrP1cfyIJ2TtwRBaDfu06JTquKt3iD7C3h+HYS14Xg3zKpCeLvLMhQXSXBunSYD44PQ+ucZtv0bJDgtCws3AWkNIzrck3VruopXQaD5RJMIRKFuBn7xeXbRPqhPzuK23kh/jh+hMCqSM3Ta6u9BLFgIDNRzhhhL822ZIyaxCxt/gwIzVd+3zJI6ElnjWQ3yF5HGIask52usRAmgIlqlEwNaVw2ysFotTMV23Y3iMuZnG8W8BW+MIrJalnD9yZ6K/sFcDmKn9GW8QlzobHO1thE7WVwqmv84odGtclH4ScIRcKUUt4tvw+O6oSTbtGZRff9PAlg6/5xSMh+PBWy2UzXvd+HbBRHLKxgPoAddOAykm4KC7lTLHr7hZjQY3CTp9uaG8qk9x6p5uF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(6512007)(6486002)(52116002)(2616005)(6506007)(1076003)(26005)(83380400001)(186003)(66946007)(66556008)(38350700002)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(8676002)(8936002)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ksrDrjXXGFqw8upRTyQ7TjGsGR2EepdNxSQGFd/g2EJN8wfkDVxzklaX+NQ?=
 =?us-ascii?Q?TjvztG00HD8MWsgBetK3Z7LCmvvFnhoaXhvGNhAXvPVG2iYK70B1yC8/vFBT?=
 =?us-ascii?Q?paMRssuTuDrfXVWyIRjU/YjazYvDhL4Ftv9z+ssdPpSWYnSlrs/kTt7a1aCD?=
 =?us-ascii?Q?JARWx0n0B9EXyZxVST40Y7VXAo9AN7UkvxTgIianN6pi8ftRwBP6wilsxB+c?=
 =?us-ascii?Q?Lw+Q+5tdgNnKciy+MknkhANcPBwkJKPxzQWzlGsTRBl+5XbZOvoAPULx+t6j?=
 =?us-ascii?Q?szWYiw9iPuNNxfKnDW7rAQHFmV+U+IgeQ4vcVmi8fvwg39A/DR6GEcpT9gTb?=
 =?us-ascii?Q?pqYKAjG8mlAKzIWq5EG03cUTWiXyH85/oWVUFrQaj6wRcncfGO4FF8QWD/lM?=
 =?us-ascii?Q?UzvZi6TP7uew/KciShm1g8vUqTkBtrnW7s5qgl6awS7BON3HUpKAA7gV17HN?=
 =?us-ascii?Q?9zOLGTwvwwC28ATEQymDvsLa+QrDCBZrPwyTOqckzgX8SYLNSpjNKwE5i+hH?=
 =?us-ascii?Q?1Tjn5KAUbFtAsN5geRjLKwMYf5RHCMRiglIAwhCDz7pRGZkiyYa64HFpu/MO?=
 =?us-ascii?Q?AuBJmAtO9xMozuX9DumTIhh++IGHpgQD1TMAwBqFwL0Oa5GUKnO0CjCE0KOS?=
 =?us-ascii?Q?exJ2sZuyzAJD+ptNizVSTvO3hWqOxtNHeUH3sye5Cg6FM6Cweb9JqFgF4Wzy?=
 =?us-ascii?Q?hhKziy0Ru0RhwYClmPA5pYNduEEaRurd4CJjP0/8SAgAEwI4Q85dn3GcNmAd?=
 =?us-ascii?Q?BV1wyR2ilN/3PDS9KxUpafHSOK1aZyrT5mFQ9k2Ydor/KH68FW6hLE3XXi3K?=
 =?us-ascii?Q?KWtGrxmD4axGG0ap1s2DcOcmCSz3td53QnCwlX4e4+Ayq3ZyeAjzQfdtu12m?=
 =?us-ascii?Q?6YBwnk3mPyL3ELJGDXE4X7mK9jsKNlR6vQ+vLlJgdOpYsYeoyNEcENIPBDq2?=
 =?us-ascii?Q?rQnmi5y1hOhcU5D3ApvMbAkfI/meYByB5pTWL9XSw2qLZOu+eL4/eCUxlc2V?=
 =?us-ascii?Q?IQ7Qdfds9BXGVsEuRZP5AHWWq3KbPSB4GAQJiGCsTdDj7V2q01Y5c+/UYJRB?=
 =?us-ascii?Q?+PIzSjKeUWdoAeKQoMmZLV4ZFQ7P9pi63n6qyzpJpa3GcRmFiajFUAZ2j49b?=
 =?us-ascii?Q?68ilEtn2uLe93SGKhrbJ2nZis0uqjY8w8aoUD8/5Jq6rlnnyWpGiJ3oFwrYZ?=
 =?us-ascii?Q?Pn0DJuwTYFN2gCC52cL5b9wBsGaJVUQywjA/XbH/10r7TKX3nb+0m/Ot3l1q?=
 =?us-ascii?Q?CEtOizlmwnHGC61Jz/Du34gHwhqRgfr1KyyAOx2cRk1YUW6BKSAI3q2nUaaw?=
 =?us-ascii?Q?CKwkRIu7BYV5Gl48f8/DRoiWEkZOS8AJEAyiIo3x421BPo+okj+D/qnYWlfG?=
 =?us-ascii?Q?RDX3vBm9xabvWpO7Zz0tlVwIu2wrtknEn/b3HfXJ0XI6Pl/Ld5YzupL5+3D5?=
 =?us-ascii?Q?+Rx2NJofPUXYradDbA+x0eoTgY32QRSPMMfRpzVEYVAL1405WZCpmGqTL8p3?=
 =?us-ascii?Q?MTj4O+62CGRygP4R8LYg/cgseV8ZBzMEyi+OK6KQYoaH6L/sWJiZoxSawNGr?=
 =?us-ascii?Q?SfwwL8v7nUKSoYnexMBkmIrM1lTidekEAxBGiaca?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9e018c-7410-47d2-1d43-08db91a48fcd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:00:17.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYM9H2jNjRZFDQ/ekZklokRxeCy+6ERx/ecp7CeA6RBipI/9LIJf6aVy2XYbTgfU6k/63FK3XeExlOQF96EbIw==
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

From: Peng Fan <peng.fan@nxp.com>

Same as soc-imx8m and soc-imx driver, use soc name for soc_id

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-soc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-soc.c b/drivers/firmware/imx/imx-scu-soc.c
index ef9103987e76..cb8377670a7d 100644
--- a/drivers/firmware/imx/imx-scu-soc.c
+++ b/drivers/firmware/imx/imx-scu-soc.c
@@ -107,10 +107,12 @@ int imx_scu_soc_init(struct device *dev)
 		return -EINVAL;
 
 	/* format soc_id value passed from SCU firmware */
-	val = id & 0x1f;
-	soc_dev_attr->soc_id = devm_kasprintf(dev, GFP_KERNEL, "0x%x", val);
-	if (!soc_dev_attr->soc_id)
-		return -ENOMEM;
+	if (of_machine_is_compatible("fsl,imx8qm"))
+		soc_dev_attr->soc_id = "i.MX8QM";
+	else if (of_machine_is_compatible("fsl,imx8qxp"))
+		soc_dev_attr->soc_id = "i.MX8QXP";
+	else if (of_machine_is_compatible("fsl,imx8dxl"))
+		soc_dev_attr->soc_id = "i.MX8DXL";
 
 	/* format revision value passed from SCU firmware */
 	val = (id >> 5) & 0xf;
-- 
2.37.1

