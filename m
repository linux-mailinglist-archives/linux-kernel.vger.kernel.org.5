Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5CC7A047B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbjINMxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbjINMxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:53:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68991FD5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqyGrRDnYg65hFOsLwEJooKtwH43Kmg+qrDu6yRi2tdo5c9TWs8gRW3fdWoRsAktrgqpCBy22NYgKMjwu1sv4QoHr9UunSNoa164tXSfgtWBm/PaOa4vvualJ8PdWKR3zTd+eR8VlQYgSmInkaVBBD0wdWHKOyJXY9atmvQqGBi4SLSQx9BTowt3Tvm0fWizCcePdHLezdXWUjZhncZtvqbSBTD6LZdhfqvD23uSD+LB2BCO133+KlKe3EtN79riG0qlQGAqD24gM8LZln9udZTJhzhs/NRodp6LLBnmPEATUUrRB4i3F7t8ttZDqTMeV4H7+AFYsi1AGK6/gs7UQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC34ha27AmK0m22M8o22cgYRmo6ZGR7N6XZ4HFI/Whk=;
 b=OYNnQXSgd4T+ypD0OpNnkiiy9vT0cLQa3NSgZ8GfumY2BAA0lWd2Sk4BTLNbEP6Gt0TOvRvPSorQ4fuHfPHFyjXxw44gEpJKpJwdv2aj6lWnGnZ8vqZPsB/MxFh28sytwqhrJCKfCzd8XnAHo+ARQ0xEVszJmfFUA68QehhVvp+QrS+qhRcEG+iK0cWRCPtcIZ2UxAWn54NE1mxmh/AyuQZmWGaRXpUvitOUNYWxpVpFRHjwh4ROFzX3JvZvRqr+qAapwvdXS3eBYyuqHpBQa5DyZ2y+277UIhNlDOw3x/1ebQZuNReyfVt+ez1VHl/1fBWkiToxTXtoxklnG+APRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC34ha27AmK0m22M8o22cgYRmo6ZGR7N6XZ4HFI/Whk=;
 b=XsN2+wif0UOOg852whm8VnE0D6Ie5D5vhwDnROfbqqULdzytMtw+Pl//xBgNQ59xRNLdDtXpirPKiMuqfFyOY2mS/DBiARozxhpx+JyX+3NPRHT6jRPWRXpakqb5XBA2BVleZQzxm2xUuvBdilk3axbj7OzPWCVZE9Eb/ehWebo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by PA4PR04MB7808.eurprd04.prod.outlook.com (2603:10a6:102:c8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 12:53:15 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 12:53:14 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        treding@nvidia.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2] iommu: map reserved memory as cacheable if device is coherent
Date:   Thu, 14 Sep 2023 15:52:58 +0300
Message-Id: <20230914125258.19640-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0107.eurprd03.prod.outlook.com
 (2603:10a6:208:69::48) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|PA4PR04MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 978f98e1-f969-4274-40b6-08dbb5218f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjWXXzjqLY5LWwJmnekGYqgDr2Sy54ucoHkDiIEpSzKBUZcBpkfJFfdFAHnDDhzOAAh+xhiXicQGrCg2cly7GizqxKCrH4oMZ82uaMme6O2SiWkco6U/0uSZge8XTOaIDPypMaXvDLedVSxePAATxC4IvXhln+MxYszJZpTOMn+mu4s0TnhJLQZ3sA/ycfRvjfWYMVb7Wye0HOQilqC0shsQdiuZHCXfilb9d2qniTR/DzSkjZkSWWJzcIv3N/SJj09P7QwBipUEzrDeapzwWMbMn9UqgrKGHkarTtAqOcxQDSTRs6ze1e9O2FxUkN8Lh/RuNZobuDqNoQXIS/+0+VuIrLXxtRa0aGWmpgsXDVrDQdmMbLzbVv2HpSeQoLPzp2BwI2Amh5oFtQxEKTy1+rEwx/vKQnBF7vM6Tt96k/PyFdHmMVYFMarIG0JvviWMKeJaiSh+KVRkZ3wJ+tMV+wc/6r3JsWcqg3WmEcVIcbRffyC+RAN7X0nvpAEaEXH7fJYdBFzssqtX/SbPTdK5Lz6RsERzckflGfpYXDBUYoEvDYeI12AePD6k0f7Adke4TXsh4sqPcT3hhJtEUeinPymXNvza0oefakyD8BOEh7wSy5t3YP4xiJegpEi4i6Zk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9380.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199024)(1800799009)(186009)(8676002)(2616005)(8936002)(4326008)(6486002)(52116002)(6666004)(6506007)(478600001)(66946007)(41300700001)(2906002)(86362001)(38100700002)(38350700002)(36756003)(316002)(44832011)(6512007)(5660300002)(66556008)(66476007)(1076003)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xLnh2Dy1ZDuXcpc50BAdJ1oL0cVe3qvzAS5J0n3X446rj27bPF+ZMj/+9P1X?=
 =?us-ascii?Q?uJ6LWEw1pXFrttXpZksggVYnUR0meT0z6Wo6YKV5T0krGp8TpUTJzexvzFWs?=
 =?us-ascii?Q?gGkAcTl6wt1nZ0JWgKIaccN+CIi5GkP046jV2asACDm7xfwEt1udhsfQa/cf?=
 =?us-ascii?Q?DgJPPkhCp4cBZxVMEgc2UIIC0mwL67BWuN3W90mxmxqNbQ4lnvyUWLbWu6XS?=
 =?us-ascii?Q?m1wd2JlD2da7xam56lWQTB/WmouPeNYA6M8YPvn7RlwlGRf1dx5rxSkrHXb+?=
 =?us-ascii?Q?/yk/cigHqm+LXJi63KUdke1n6YFV+2JLFEAAfOQlJR5eZ4RJoej0eJyHHCOw?=
 =?us-ascii?Q?UTZNLTruvwZGCyMtZadlE6S6cAtUXAk+F92CYgnd2eVM+qQueykCutCtH3LG?=
 =?us-ascii?Q?HN6LDMGVzZ0OWV+benhI0IQr6mNRjg4dKUoWnWaiHuaoun+MMZG8RWVPwuRG?=
 =?us-ascii?Q?dMFdG0iUts+xK9GCT5VwXLf/+ZkENcIJzZx6yYhI1PV4vtmjFC4hvylM6vct?=
 =?us-ascii?Q?rYQUshbJsncd9OLReriwi5dFpPp+aAlxjfZaVWdSuxZ5Sj8GSrc9CPqePCyU?=
 =?us-ascii?Q?LAN2d7H+A9z+IA1MY/NMvsVoSlbpOKlKVojrAphj3Tu3ZmdagI6+AoVM6Eby?=
 =?us-ascii?Q?m0adrnr48fuXgSlRuAnUTGomcDnYY7tp4ephRUGDFZFwpbYWFUa5GKC/EVmr?=
 =?us-ascii?Q?GWu5PSobgNVbgWjA6YTKZ1N0JxJK9EjUqxzPt2iv+uRZoFFE6UowS/L72puZ?=
 =?us-ascii?Q?wqnhzV+7bc3dVJH+dHlAe05ONJ944pIcfRabT0n9LZ6ZpPYYdtA25ZiCz3uN?=
 =?us-ascii?Q?KDMbmd65S3TdoNFKSma82tAoqkRq1s3shrm84HKgxKftClfQfJU60ETy/BIy?=
 =?us-ascii?Q?3FlXpfoWTV8THfzYX1Zcl/nq+g/cdOrxHCRZqmzPyDrtFUYjv3+AXJhy2ghd?=
 =?us-ascii?Q?6w7v0/yYIS71CecmlR0GqgmiNbJp7VCrKqmFQr1stHO0eSr4d7+gq/dWKqiK?=
 =?us-ascii?Q?s0QUeD7+mbNdFgKY16P9wVoSGhVEy0NFWFUP3Yee/B9GpHNJyrKF2m2mcl7z?=
 =?us-ascii?Q?p2BSIVZqiPSSYcx4/TkCR1YNUZps8ZJD4hsYpddScHbHtJgctOcJ8qrnRbdn?=
 =?us-ascii?Q?yAvJBCbKpe2DUswXatUbdYFT8nJh4Zk7FLjWYGy+OLX+KA5QhUdXrVUZUCxa?=
 =?us-ascii?Q?l9YwEh8mqhkl01W/A79O4E5RbI3MS62XQ+ThP8+nMAHQh+UBlxp+ThW+6a6b?=
 =?us-ascii?Q?O7cLBSq8jJuZbQzRNHpBMNhs+nXSHXIxkMJt4wTr4mi3dce5xlq1eX4bmRHK?=
 =?us-ascii?Q?e1NZcSg+FDJKQpkEHR10kVUQ8wk05TSW7SjgI6Ivyv2DjGfWhDiKMPta79RZ?=
 =?us-ascii?Q?NMu1SuDaAN94GgSF4mQLhiXkWG4BuzCedF2ROtL8IrqWPr9EjWT38++0CQQI?=
 =?us-ascii?Q?7cOaelDw/eomIxtqEkm5/PzjRMzCkXvgYvdepIF9qZ5oRWKTAIwCS+mz++D2?=
 =?us-ascii?Q?ZxUnhfLCDQ3vlqfCYpl8ghAhN227leqL+FXeeKsBy2oZn/3SJylNy4RwCMHi?=
 =?us-ascii?Q?zJVQnQtpPmTox+OBPt1r+QUxiY/7EIc6o+aHdW5d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978f98e1-f969-4274-40b6-08dbb5218f41
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 12:53:14.7606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6T1joLTnlzr716OCJGmhjfSeEBouRTkF7pr8Y4u0UVRdHOeMOw2DrBtqrA98bUd8EAAZCvpPP7e0aJpBOb5mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7808
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if the device is marked as DMA coherent in the DT and if so,
map its reserved memory as cacheable in the IOMMU.
This fixes the recently added IOMMU reserved memory support which
uses IOMMU_RESV_DIRECT without properly building the PROT for the
mapping.

Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
Changes in v2:
 - added Reviewed-by tag

 drivers/iommu/of_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 157b286e36bf..5b3631ba5a45 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -254,6 +254,9 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				phys_addr_t iova;
 				size_t length;
 
+				if (of_dma_is_coherent(dev->of_node))
+					prot |= IOMMU_CACHE;
+
 				maps = of_translate_dma_region(np, maps, &iova, &length);
 				type = iommu_resv_region_get_type(dev, &phys, iova, length);
 
-- 
2.17.1

