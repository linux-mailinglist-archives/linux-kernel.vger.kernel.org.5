Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57CA7D3C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjJWQRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjJWQR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:17:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE25DD7E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXYzDykA5PSoEeT+D9nhOJQvrUKnf0bjtw8qG6QPff+eWNIC9iil5TJe7BSTMjD9A14U7mwJmWUNpPrQoT2QInzXhGJJ1hLKTUc1MGxfyaceWSCU0t/n0Jhb4fLrXVXU+YYGReJbbHyO/I9BoPMEaPTEXGaa/q/xoS2KlXZ6gkcyKEw1FCymyvANr617e6m4jxOZsqUcrnrSrutkCrqaFWwLquhoh8pIK34FKm7Q1NdbJ1WNJp8xp8EoPgCR52EcuSw/w9G3E1ANLuw3AQ6oXQjta9KJm5lykcYw3FeBu2RfziQTadwGlWWt3Ula3xv8E9a7iLxAOKiqR5bi1JS0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4mJGV9acOW2cLGFSJ8HHBb/l6kCukylYAa2hfxh9Kk=;
 b=H0TjZ2P9mzuAk4q5PULUniR0oTPNu9kchTy4b8YimwxjGVn1PZwNxYRErufOHR1ENG6QMR3rHMSOEvuKue+CtJeoWdHMtfBd8KF71e8oOH62V8U6/HyGMmxGBVh2Ppsy9gqyEMTIbjKIcInllw5A0j+XKEhIvfXwvZBnrSnk9nAjuPYQ+JjCin0r6O8KLC+AcAxlhNTjSaRUAOo+43yuwbd4i3T3xq+ifq2JlvCEeMegYhsdqT9hZhzpTUBysFl+4hwiGyzaCVrnaZpIO6u0lgcHAF3d3mhSTO4JKMm/qnh3KxMKdy3C5uBzHDK7NnQs9pY05VLfo3e1S74StwDyRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4mJGV9acOW2cLGFSJ8HHBb/l6kCukylYAa2hfxh9Kk=;
 b=H41A+DHUyVgZfpeNUxBLi9emY5G9wj4xSdcoeA//jxIuKIBXmpEijzxTzl+9S4DKR7ulJ/N6DfUZ5nhs4AhI6dx2D+ulC9iz5NV/yQWI4s1+gIlhEkIKlRMcmOg9KZR7rkUA/197kepu+PYYQoqAUSo4s48OlfnAcqO52VJU5+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16; Mon, 23 Oct
 2023 16:17:21 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 16:17:21 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] i3c: master: svc: fix check wrong status register in irq handler
Date:   Mon, 23 Oct 2023 12:16:56 -0400
Message-Id: <20231023161658.3890811-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023161658.3890811-1-Frank.Li@nxp.com>
References: <20231023161658.3890811-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 3069292a-2621-486f-446b-08dbd3e388f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lR4XnIQi1rymZuHkpoaYphbgxmNRz1SPJUV85YsB9cowoObQLDUoZ0PJiRvVNWg5ThCMsD4PJVSsy82i0RHOroO/5txBJs76e30SzdH5dUnkvwo6ZGur70jIIzRG3VXHcH6HyzwPJjmSzwWM6Z5LOS8KMF2/r1CSXa7kWbJ+IfdZhyu5kZT+lvTmyUaUbm67EEPRBJnXBZcHlBKEsQxbLID837FkGDvlD0RwyKbKnuhgFLMor3cv9ja36jtAJPUHVbsfhGSRgjxjmFWI2N8ggmJ/rZAlEI0icItbqqY7OB6nydYpZZH4Rnh2zbvWpM0sXq6O9m78Y1FrfBOJtRQygAV00RdzgSxH0036NZHvl4N5vw7cYfHrNnLXHzVlcY0CZRy4xnoci/ZaXTJzCNfa2hY77aKTTMCZZ/9D9J3SjodBhW/hdDFrF8TBUqPMV4TCNI2U/15TT0M7nCMrl13IsOWmwnhHynz1wUkNILN6abLp8ER0OBj8hgNGbB/yRIc0DWh11y30pU5MWuQwmnEWJwzTbps1HaqW+JDw8akn3KmgaosUdugD4V8K59UFrElhQxRVODlgIa/SO+axS91j06qzRtSws7LO6c9yberZSgGduHFNsRNQTktK9L5MSbKu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(6506007)(6512007)(6666004)(86362001)(316002)(41300700001)(6916009)(2906002)(6486002)(5660300002)(52116002)(36756003)(8676002)(2616005)(1076003)(26005)(38100700002)(8936002)(4326008)(66946007)(38350700005)(83380400001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EpREH2ApipoCFTjNKq78RmnjXZbB0XRrG4CC+afhXCiIpKgh2cKFCI4Rb0bV?=
 =?us-ascii?Q?FhFLENsAlBd9DsG3oVZbT6zWkFtv5XrcJX9ryFTG9b8bnE8Sapl+U0+Pilwh?=
 =?us-ascii?Q?Grhm99mEjnr6tD9KNAers6S0xGonuKnwhABr2GP0JXGtfFXz3mCLE+pI3+gI?=
 =?us-ascii?Q?S+EUqBRg6/pZhwuqGvfsWQ0WFkqyqXGlOT9DTmxv/JuCtJkIvnIKS8vT6+hd?=
 =?us-ascii?Q?oftLUWb9dw7WyjfO4xNVfeWzBMlM/p8K3a67WDlHa+s7Tyv+KepMe/J3JcO9?=
 =?us-ascii?Q?4c5VIKcLcOTkFYKSlFoB74U35yotDSWyVpU1L+9GWklXpfPWYWQccpoiDylg?=
 =?us-ascii?Q?ev2DktSPP9nx2v3ft49AmusCC5/k9u2jOnyRewm6ZrBIuJlkGJz2yq/BnMDr?=
 =?us-ascii?Q?3Qyv6em5Fj60Uwe4Q9ZmbEDFfasfzPBCz6mqrSzeX862rgG7DyUqtSvajI9R?=
 =?us-ascii?Q?PESdsNza1OXcvQRYnjkOGzKDX/Py8d7kAWKixc4tL9HgxL7Rpr/bXGMGrvH5?=
 =?us-ascii?Q?CFxvkRJ5TPHQhqH9FE5ZohyqDRlMY58rzPAnNwJet2Zy0dPVSBpOukscEuBv?=
 =?us-ascii?Q?gM43OtPTHz4G1Ms2AuR5P9MC2IdbkNPyelGZs9WuNtPtEqDigHgDkjuF/0Yz?=
 =?us-ascii?Q?IPb5Ndf3NImfkto2pKk1r7AVNE3NNKdk0Do2uDK7ovzx8AyRAqAzeJR0FOig?=
 =?us-ascii?Q?9AXLHTRWL+prQRaFCbp5GcYp6M1yMJe+X7DjkATyUDAhq8Unk5nP/tNRtukB?=
 =?us-ascii?Q?ZlXW0q0Jr8m+OV71Wt/QoQR7NguP6GCOtOTk68zO2kMy/olRSaxso1cXAqj+?=
 =?us-ascii?Q?juYyhFNr+nkUb8oOfb7pNuxJLFob4INP7PT7Hd7StAVrEsWUDIxl7267NYgD?=
 =?us-ascii?Q?uJPA54Dfgc3wJHcccrPg0VoLjy9xcz/8SPlIj+8FGUVHf8eeLXXsmtVL6CZn?=
 =?us-ascii?Q?Qj+i1VPESyz1q0dnj0986ZIFO0/sw50PsCs4c9JDbFsnxZ4jXRHll5dY+YCA?=
 =?us-ascii?Q?EsTa8/7uCMFgfT9HA3kCQZYVnJroDEB78CwTZfoGjZTmDHBOlPiXHL0yatVq?=
 =?us-ascii?Q?MxrHi/MrNfqXWin+Ej4kWGiJ7s0aZ1hl7ir+LR+fjWSC/FHy1OV97aPH3YBw?=
 =?us-ascii?Q?Sz8eUXORz61jBVbyUPiNRW7dg+XGA/OeogvT1JCdeByLguT0+MjJvBFJFYLm?=
 =?us-ascii?Q?vysnD4ezIdNbeAbkFd9thQOCltUmAuLCtVH4kQT/vR+2Jx5MmdNKLW4Y/7ji?=
 =?us-ascii?Q?dUxuxutHzZq8fG2X0cJtkb8mMNXpL3ZQn9H2r6RrnnN2rGjUHaWYnxC+W7NR?=
 =?us-ascii?Q?V+uoK79GXqqoPd6G0Wmy52QvHDB/2CxR1CBJ3j8/5WCd4mWEkyTdCqutmJGg?=
 =?us-ascii?Q?qYuTYX4F6Vavkw0BUcnBQvSZyZ643SsbPuruuMoZR1A2UTa8OeKUFlPS4zEV?=
 =?us-ascii?Q?kfS9UaxQab7aLclN9e3l3eSAoA6ev/tAe89SaZ3XIus4c90noYldHnq+R+nr?=
 =?us-ascii?Q?UXnM2IZ5e8VTqCkgojrEVt9XN0htcgmfaNF4eE6BLDrRILXPLBnjXqJgs7gU?=
 =?us-ascii?Q?LhbRQRr5gmMItIK9yOCyWLewUmS0c+o44CSK8vqW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3069292a-2621-486f-446b-08dbd3e388f4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:17:21.4682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6waxxU/5KgXtirH/MXaK4sRjHcHfjEpQVpfP3ntSLWlh4Wc9+ib2dIK38AdsV2/1pnjnCiv7n8d7hy9bnTcMfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

svc_i3c_master_irq_handler() wrongly checks register SVC_I3C_MINTMASKED. It
should be SVC_I3C_MSTATUS.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
    - 'wrong check' -> 'wrongly checks'
    
    Change from v1 to v2
    - Add Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
    
    Change from v1 to v2
    - Add Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

 drivers/i3c/master/svc-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index dd06b7c9333f1..b113460f059c3 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -476,7 +476,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 {
 	struct svc_i3c_master *master = (struct svc_i3c_master *)dev_id;
-	u32 active = readl(master->regs + SVC_I3C_MINTMASKED);
+	u32 active = readl(master->regs + SVC_I3C_MSTATUS);
 
 	if (!SVC_I3C_MSTATUS_SLVSTART(active))
 		return IRQ_NONE;
-- 
2.34.1

