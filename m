Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10667CE1A4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjJRPtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjJRPsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:48:47 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D51811D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:48:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf0z5Ht8MDN+QtGCuqSwLunbyZp2YBagN3WMcjiKeu5DiyqPDVf8UXl/Hj3yesZ0ZU+zSul8HjLnX/rNttC3EHs/BLn6Thdc9izuY61FPzUYn2twtcvCbCT6xGrOB3C9cT5q9qQ+eiNQL9g73jRU3vx2/pSCiMJqabrZoCZCvPW8dEtlOM5sgovzG/ZxWnJNCH2nPl3XEIcZdNtBbGJa6U8axQU7ezz/17txE9NOpT0wZpOAtQQgQQdXP48VO8Et+reLr2bI122t6MTre65yX3rX8ir/OfJqKCGZ1SJ2xQ7vkjdD+CUhCI5NkUxm+vY3Oqp4eYdIFoQ5B55lBiBiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghMi/AjqmeuflsZPjowu1AoqUyQlM4/JO+IAd05K8m8=;
 b=Bp0hElbf1iM4KVy/QmwCs0lEAduzKxsFda9GJU+HEruhOMcDRDyXTWg2g5Orh9t0+S4x6hYm+Z3swTIlEBH3oMBOmjc1PjbZgT2hysWrfvvRp6/STMqf/HaTrAqT025RmorE84AbXhGUP8zU9wRkDWYFc2woMnCcvMR31ZB5mMdtUrYSEq3wZbKNH1j06I3zAGS2PPcMqVWHkX89wwBkvvu9uIiHejIL2cyG30jL4hZqpZ/KoBxxi4YIOCc/uvYGg9sBuYV3wFKu90pmr/doQ9IPOcgke98kgSWY40Dc+qKsu6yVGdGalx6fFpfuKVABiAcbZ4tE24cUk1NEo4+YjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghMi/AjqmeuflsZPjowu1AoqUyQlM4/JO+IAd05K8m8=;
 b=ZLKZ8NZ+v31L84V+xd1aWL7jQjpYao+Htoo377qKt6uQukQP3HioimYblMPRC2t8uo8L/DZpag6O/mbaI6qQFRYObi26oFtQYWmLuvwaBHFZ/CwVY7mk+E+LWn8Y1wCGAjwvZl0IAGgw+AF6u7Im5w8O+XtiVylEV5+3pqIdUxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 15:48:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 15:48:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] i3c: master: svc: fix check wrong status register in irq handler
Date:   Wed, 18 Oct 2023 11:48:08 -0400
Message-Id: <20231018154809.3304558-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018154809.3304558-1-Frank.Li@nxp.com>
References: <20231018154809.3304558-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:a03:331::32) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fc1490-50dc-4c58-632b-08dbcff1b33a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2hQV3ymHm6djGEuZvc9UoObUFDKb+exdGptBRfUUPEkq3I62gnzr/e3h6CHTZSnZ+J+KGpMhGkYkd6hQhW7JXehSbiCov8QxN16RLEM0VWOE5zsKDk6AVf7h8phbHhxi24sw0gpwcbWY9KyM/EUvxHDVM/ODnS+Nq2NyrUTX8CXPsNEWuvH5wiIgnThIBy/rxH6sm2wjkScSxFBmHSzGs/zB1GHAjxmcQMEieSLGZWsnGAanDOj6TdwKzUcihOZet89x5qPCBGeNgIw/Wz6xjUYyEHdvq3A5po6CWOMLi6yu4hFjveDGyDP75T9/IngfMyKbreiasXgCtIFGcP1V1Gthr0S66wkzi9yZw7pByJEag6mI5IYmEzTLbmMebJ9rI2rEEVHhfQdAE2Ajkol3UNC0eBFMa2879c0iKWmMpVzPq/m7tglMkjGTUlQWV5Yaf+FJNzX8For34juOfwb7CS20q4Pqi1e7Dd5mXMLEHL0L/MoW2ICnmmixrVpLPEtb0nH5ZIwYVT5QDUqUIBYAUsqrI/dFJEOFw1mOn3+eeNk6IX3vEy/2Stp+PcVSPHkBNhpyzmtsS8WEb7bfiwFpZ1P3qU8T0M6Ctrz2gvimeFmkoJSa1wRyl3SFhgv+8n8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38350700005)(52116002)(6666004)(6486002)(6506007)(6512007)(478600001)(66556008)(6916009)(66476007)(316002)(66946007)(36756003)(2616005)(1076003)(83380400001)(26005)(41300700001)(38100700002)(5660300002)(8936002)(4326008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j0QtZFf3aYWpYZxkYWbaudE/uMmdXYs2x37Apel2A4JEpj07lKW+XT2lY2sr?=
 =?us-ascii?Q?elMCq/9/82g9jPwoohKVftQsiDNf0la+RnbrRQPm11BOQkA86N50w7chav2q?=
 =?us-ascii?Q?5zDGmCD7BrdfwBYUWbpNxjJVsdqaSWO7SckAF9mWR614ECGqlRDvTUKt5JCp?=
 =?us-ascii?Q?KCD4iuz7Skoe6FcsQD5SxWmVWfFLOf4hpToVzukj7dJaF91w9kWpfXz712b2?=
 =?us-ascii?Q?FpwaG9SOx6KmU9JPdUE/jKjhKq0oipXN8fYC2b7zvQYwp7dS0ITEaRkEcYKC?=
 =?us-ascii?Q?dPkEdG4OBJgmnP1N7IghPhvdhjE8EBUerNE32MwYfvQwo25qXSO4dU4ga9a2?=
 =?us-ascii?Q?A6nmoUVXCyfzZQ9LWjAFqSgbR8I2Uph5R7K/T62kN6Qmju58wHFfxebXO9th?=
 =?us-ascii?Q?YtqGXuXZmKs493Jmx5KJCM2q1sr8NFViHMQapd4ukqznPfI3hfUTWf6o6lwD?=
 =?us-ascii?Q?3XMV78V5bkqEjPNvaCiqVu6frbrNo7ogH3uFmkhhxJ+C+dTkrnEX8VBuIRrP?=
 =?us-ascii?Q?Sp8vSEHXFgOAGk4BN+y5O/UDg3SeY3aL6BZ6kOCCE8QA/DW1iCfkRkZ1NrFZ?=
 =?us-ascii?Q?LYd0AE+fxGYQy6XmT+wgGyTSsrtUj0DF36gOPduycOOH/GAyLjx4vFzZRWPC?=
 =?us-ascii?Q?8vm7kUrpYZYY9+duEz9kR9JMxmHw//+RoPoLPH2NQAjjTb3whrQQEhFu/R+3?=
 =?us-ascii?Q?WW2gyZ0M3xCfCdOshcE9QTYLECJe24AopN1W4NMuAEFnbz2Z20TdtP07SjSe?=
 =?us-ascii?Q?VjoowME8DVdA7GFl/MkibW9xKmcT9NBJYeBN/KdGaq6ceairEqPQ7PRk+ERv?=
 =?us-ascii?Q?HVDPRtr31xCfVvwbEwFDQVTuwAB4NATB0heoVQQedfsTXVJry9xI2H0RSmz2?=
 =?us-ascii?Q?0j7+C/B+5kbB/YCPEaDwe4Wn2PahRtPDlL/0AIpPWvC4Zf2Ss4TXM/Prqomd?=
 =?us-ascii?Q?F3JaxssG92ngDPgELD4yJS+149EnR/XVJxUn8AUYNflbinxlTHasgPSRf4FS?=
 =?us-ascii?Q?UpsCc+vkWx1N8hBIxXZKJEZvk4NKIDie36nV++OfHxv9fROiudjawzht7bBM?=
 =?us-ascii?Q?k/Cj6ej9aEkJlQwUokwxRSaL5oe5xFlTsqNVQvn5/VMTHerQU4PKBgX+zG3+?=
 =?us-ascii?Q?BM2z0/wOmxGGcZWMFrrWISJljToTcBdFGhKWWQZ44zP5p7kOj8vCIPDb9fcc?=
 =?us-ascii?Q?TcJ26y9qgJWLqnaZrljueNjcESpjuKSwRVAIKHZoI8TVSQq6hSlqP6tubY30?=
 =?us-ascii?Q?tpqFVijCP6+/HTbH++kpbXoOWzdOR0DXUVQXuLutWPRprEUgQbOFONA6ByXV?=
 =?us-ascii?Q?F+FAjI+hj0q13mu2Vd8EqgpA7gUhzgrFJHv0MU7Fg1R2g1gjl9YblJGhuPzv?=
 =?us-ascii?Q?LdeHBBrR1C9z+RpznUZhKUd6VFeUsLwJT6V6GU7f3kYBk/JFvwsfABPykH0v?=
 =?us-ascii?Q?EEes5Q4NzMAx4hqaZSqCgalBmN7buGTYExTUvj0L9OJfNCIMzlLX34Y9yKR8?=
 =?us-ascii?Q?Pfxz2tNGwxsDWTKjlttE9ZSV3cnuDbqRoREO4nyqgmuhH8I2f3OYBlT6KE/A?=
 =?us-ascii?Q?2FKfocRNZidFVYtuDrqGM6BUtVC8lmw9j3yTy19F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fc1490-50dc-4c58-632b-08dbcff1b33a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:48:41.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AksJpKiTfA0O9w1rwQOYzRn2fe7HQJBID/6YLvjFZeo4Q870KY0jxE5zCRK2vQvPHalrjkGtLqggYx4P7HzGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

svc_i3c_master_irq_handler() wrong check register SVC_I3C_MINTMASKED. It
should be SVC_I3C_MSTATUS.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
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

