Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07437D04BD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346656AbjJSW15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346636AbjJSW1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:27:54 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810B9112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKbOHy+o3VwCdz6G4CPqj3/ZEtGhNBkThMsBR+FKR0du7EAlHuy5O4GpUVujI3wXVYxDmrasfWD415z2SJvDFJAqN9yjdz8l3OSQExOVT7jcHxdI5QLEZQfSjsusszAnFVsYqSDYxqkswcVlxqglLj9cQw/+EXXirZnfyHVlNV6vzauSbMs3yAaYyQok0NntIyVmrCqawASPa7lTCOkqD17vzVwzuhfHrA7X05Uve58j8F/lLci33zos8C5/iZIc/IbVFwZyYHkXY9PUavYrot5moCl/3yjF+XdOc+iAqfbwVw5iFYTtBPDF+CP1/o/iuevPWJoVtnTvnYVdhnhj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghMi/AjqmeuflsZPjowu1AoqUyQlM4/JO+IAd05K8m8=;
 b=LKa+Q+cIBBI4VOo8n+jXBuDCCEvgPX1ZxIym0ZI5GnpDKGn1FnhOoD9K2GFX4gvmjdOref1UVOM73i9owLZM84Qi5N/oxyWYre+Uu5qD0CoZXZwfbBtIy/Gmq280/kX9+UsboVOdAM1XFAg7hqnJac9IyH1OI2qGZuckG2ycEvwLC+uJ8PI2yittoxIxxNIDok6dAkq5Z7UPLupjRjVap0IhAYwX2J4SlPs/6PyOd4eD8NVPcvg4eRwPPrPScF13fzrRxSx6O/UNhLLAFVa4pffAdcod5AcfVClkN0iz4+VmXSYMo6iXr1Yg7VDxmZVHSXn5YQSrJ9vLib7Sx/TOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghMi/AjqmeuflsZPjowu1AoqUyQlM4/JO+IAd05K8m8=;
 b=Tdiaah2yXz74YD/N5Cqwi/OB+DLbE472SGwRW8G4DBK5bCdefMFZNIzyq6ClRpeRbrsbYkoy9w9wWSVxbYsSCRUc4Ouzxk0enJTQ6BnzXEl1PxJB0dCmI+tdFCP1AxhoQoYp62LiJ4A6CewYl/GNMQkq98/gLOac+GaYtI/atKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Thu, 19 Oct
 2023 22:27:51 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 22:27:51 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] i3c: master: svc: fix check wrong status register in irq handler
Date:   Thu, 19 Oct 2023 18:27:23 -0400
Message-Id: <20231019222725.3598022-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019222725.3598022-1-Frank.Li@nxp.com>
References: <20231019222725.3598022-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:510:323::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d65c76-b00d-4f54-353f-08dbd0f2a135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTZ6lEItdrFHmEZu+5m6mBF8BlYcmFPwlP3p9xc+cyzpL3T6Dnr7OcS2BGB30+fB+LExQ02+iSHqcSSCD9BgVjZqH/yZ3qfP0tHLtG/wkj1SqkkAzV97ih5gTlTPQsNVJ0KO2dZNeX4f3yl+5jBx3jErA8IOzjJdgYTdtVkrJtTVC87DL11gnriEiFECQqPW7MxpCf/ZsiCefFvdYFbpBP40lpV6X9g96+vGgfOl9NeJCCIIIPkP/FW4MAJUfRlfCSOqnXvof6PFMCSIMnKatYJRcl/luSZEZnhPAyVmkZ4LpMRSaWTlCCsS078135h80CMohdKzrUVTa234fr/R6rX2N3yT0mGFOTKY4xDKPTn5pXDU8RGqnuAO8OlJ44xQktw1rGWywIgLzL80EyhqgJs2opOI1rCvS6n7RAqqYCgF4n/DD3JrUH5CPnvOc/3zspqv8wjOEesZED6wyFK9mbnryrHoqamrO96RP6mmBczE34Wrfg9AIJeR83rLCzGvSKA5WP8AuFtSleYGyCPKH9tn8D4HkKM5r5mWcf7xgRl7n17yHynNd6evseq86e2pi8iCbAXTCLouzL6YkQ846tRBDmicQsBNFKqVJRkRzdWP/xYGijMqyF4lbsQwCFSxemSdm//+I5/8mrVElfc/EhB3Ms+x1MYnCkUtqXxHWR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6506007)(83380400001)(6512007)(38100700002)(478600001)(36756003)(66476007)(66556008)(66946007)(316002)(6916009)(86362001)(6486002)(52116002)(2616005)(1076003)(26005)(6666004)(5660300002)(2906002)(41300700001)(8676002)(8936002)(4326008)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g3RXzKyWyGbdomcsJaPgK+NIvibljavZG3h0HhdHuMb8YN4Hk9tSpuLmPin3?=
 =?us-ascii?Q?e1Vycs+dW/ZHC2AmX+/yTHTJw5m/hmt+SejgDn4Xb5CKqi9XZrlhw3jyYTJk?=
 =?us-ascii?Q?mfUJdnq7fsPP1kVK10AbC1/+iwWr/Gl8npp8I+skjWwFA33UBf4THLaGkb8p?=
 =?us-ascii?Q?dADWZqWtdwJm7pQYVgqaQD867FdW8KaMWHa54r+n3VmLZYG2Q1/gMRQw9O93?=
 =?us-ascii?Q?hGi4LBL0n4hUPOhZip4LX1n+ywEBxvjaON3805aZVUBsR5zYmCnT6JlYxxXB?=
 =?us-ascii?Q?egSICZl6NzKjow+du83dAy04FS0HNq217KJ3+7sVe1VI9koO9zFo4ZZGtp1X?=
 =?us-ascii?Q?kdTMCzPftgG/LQ+2j1ILq7F4gCr8G2rtLUiiWden4Y48gi4KRHItAJ+7kqBD?=
 =?us-ascii?Q?wk14oiNsh8rNJ5rXGKuYLC/F8bD1wpovzs0YnlcErm47/UeOgeWjcH2C8cNc?=
 =?us-ascii?Q?8u88n9h4YZW8sY38Sm/kWAwkRzkvIzMkkZS8CpVgAjPSYHx+IwLc2Ok+two3?=
 =?us-ascii?Q?+/CcgsEdQyoY4B+tJQVJhdw2TxXjnPWwvWQZZ7AcCVfSjxGnbuMDNCgn0dXo?=
 =?us-ascii?Q?bwhq15fB2XreTwwj+1mURTwGqtuI2nw6nLKZiMkyoJMz9jCH677BNv5c3T3M?=
 =?us-ascii?Q?NIXpIz6xhY6SovRtSGD9QQk5mApHrnkvyeJgoTZoIWNwTHudZeQwu+X4CcEY?=
 =?us-ascii?Q?ah4kOlWSOPqEXmf6OLU2bk3ofrnumCm+UEjb2pp2Vsw52BCpQV4OmbYQI6wn?=
 =?us-ascii?Q?IIlZTKduTUTczhcqoBIWVNYBuPbnvFYGDXZIKL+l0oeS1zEtVd/TlrISzLog?=
 =?us-ascii?Q?0o0seXlGvkb+tSgqJmM/wBspXyShBDRjUOt6VuLlLMJOa4VcTfVmd0BE4YBj?=
 =?us-ascii?Q?mdehs9A8pHWbHblHzxpPtjLPXjyDmqTcNfu3pRfGAxvbcv/6/7S3viOgD3qL?=
 =?us-ascii?Q?m/7vrDYPQlax4zuacfSFM+2XxYUUrogaWso8gAUXFtNxBP9tsCd7wdjMRqZR?=
 =?us-ascii?Q?OrJ4K9m/gNJFLDYyI/2/4HHsHm6hLCd/26jC1IHYgtruzEJxm3ZjLEhA5P/e?=
 =?us-ascii?Q?pNdMtXeIjICQooyVU3y2y/oaJfLfvPdIo8tZ4DsUjJ6qFq5+RP2huaVr7xTX?=
 =?us-ascii?Q?3V01rZ7OqY8qNsCNp0wVFS3N0DUFaa7th3o1wAxxWNzjV+re0HSz6k3UcI7d?=
 =?us-ascii?Q?3LcKAVKRLeLCJKC6qmOvkKwEHGiXB+b8Nl4cTp41S7riB0kLBIlFuCH6ECeA?=
 =?us-ascii?Q?cc0P8Wuz5NGiCyxC2hh0Gzz/mhbHRjBRQWIAKSEVSZLFRdKC9ogSE7u9ZjNS?=
 =?us-ascii?Q?9axdLkEdBBtLDUrTDwUkkCM8Iac5mw6RaOsU1Py7ztaMhO53MQQ6m5+19h8J?=
 =?us-ascii?Q?9BDH8h7kLFjI6tLFjpj/mrXYXJ23DtcH3G+Gb5hOuu01f4e0ZjAbbzgWTqNb?=
 =?us-ascii?Q?vSdgIdu9AbiZ+8GyruCu4+dwZEGaafyAeiy1zunB8J/9aJTBjuzaxogN4pmd?=
 =?us-ascii?Q?2sAhWQmgvi7MPUzqv7FUsmtsU3w915e8uGVdM/WFe55BG2ePHFl7BhSp0c5d?=
 =?us-ascii?Q?Ctdyz75lZ8JgKq6cFRTWZbzFnSIMOJu6uBUnzDBi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d65c76-b00d-4f54-353f-08dbd0f2a135
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 22:27:51.1204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AA2YbLLQv4FwuwezwivnpX1Hl7M34lta86SY/+4Au/KRK4VYkBikaVI0PZdqg6lhjUAtsol6+PaXOiyB9zKDxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

