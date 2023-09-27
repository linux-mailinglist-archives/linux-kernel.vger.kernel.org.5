Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20037B06B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjI0OZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjI0OZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:25:41 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2091.outbound.protection.outlook.com [40.92.99.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2580D19E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZrwJ+NH1z3OwszniPybXUFD1f7zlpg53NeAwxq5WeA6nVcXRi9yn9Rp5HDHvTKpbK4hrj0oP+vWOnDGj8yDh/3pJLyXm5OmeV1nbcTqYKulLGOimBOlMYZeusIqa+zE8/A9zZosDnXqH7ZKadwC6NwqX9j9r9VCyJyZ1hCwFu5/bIRpd4UJ89BzANCIsX9dWVsenoTpferVwNIlQqZUkEuZBb5euJbX4+AS8xMmkWv6QXlKnNdTqv81S5Qapb15yHUni4qzDg5pRcWuomKDgeRGJzCpQbweg3TUO5m+f8I57vYbDV7F0bdP7+9eG9DlAEDAsTaoCOkQmEAj011/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLubrLAF8F8iFpdG1xw+fKj7eghrW9TtzkA2ictIvrg=;
 b=k9DnqpmO5P0R7z9WQaso7PRLMdR+O4RmgRV+Nxyt88Etbxz/TvNYAG9PP5HBai2m4eDWwA4+Vek3BVY+JtflY8DFqn5TQeGSkQy4uCrMDAlDu71cFybNyyGxH50ADIPQlW7m7BhmYC741E0FmcsTFOai4A9a/ZXJXM5/m/b6de1Bbov1ksiA+OuObFaHg8YycTyezoyJws4TqcnreRmyq6mu65yWg4nUkaaOqT6ZntrCG+HRO9Vh1Gkfhy6vG0i3qv/tUuCZ0M+avBnwxEM/cmmB9Nz4eExs849/YAHvndjzNLgJW8d8+LZbfu8cy/zBCGYXrK31EyPCZYnuBzvSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLubrLAF8F8iFpdG1xw+fKj7eghrW9TtzkA2ictIvrg=;
 b=L2RoHXfsus5CGgxIbQHSVd7jB6PHdPj6DWmNA+MCjnaPGgvKaIQAxQvyR83l9nRXitl6sgcjjcI4nGIHyXqrFfS2A8nObgshu5wuc2/z+8Ufy53p/44eGKlNcy4pXzyZI31cughGsLaUsL4uvVnq50zbYrALjuz2lSZ2at36Hf7k2u5qzn1BIwhrKp77RWqMqIrOMDZ1KcoSPfWw1GSZ1+15F7LRnHVegYF3tf0DLNloeFW9F/ZfAjjnQPMEDlOXnrqJtn4jNgiiz+3jAA+ob01bYC136Sr8fKjQPwnDSadszTmlMVv9BaPtZ5bcteM8xeEiMhnTAUQvuVXk90x2fQ==
Received: from TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39d::8)
 by TY3P286MB2771.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:257::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19; Wed, 27 Sep
 2023 14:25:35 +0000
Received: from TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ee22:5eba:da74:7c25]) by TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ee22:5eba:da74:7c25%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 14:25:35 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     robin.murphy@arm.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] iommu: Sanity check on param list for iommu_get_resv_regions
Date:   Wed, 27 Sep 2023 22:25:01 +0800
Message-ID: <TYTP286MB35645FDEF45FDFC91D35CE1ECAC2A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [f9PMvWYya170/TBFzH72aac6/QRDkiGe]
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39d::8)
X-Microsoft-Original-Message-ID: <20230927142501.33287-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYTP286MB3564:EE_|TY3P286MB2771:EE_
X-MS-Office365-Filtering-Correlation-Id: a0293fee-7527-4a02-d881-08dbbf659d21
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRutR2T7uaR1RJNSp5v2Uyf0BTb2vRD5zWv8giUdnBJto6Iy95C0pdByy5pilxsJTguWclfjWp/EAeVGqwZWMdxBKjpyFtF4Z4eAcrXnvEEzYg7Dc/JzeYcMKKJyhgwFYFMssDC8onWw9ZIV+xZ8Ge1nDj0fjww0sGMO8jmr0cTvlrDszikAy+5YDw2RrHAPqKQ5cFrgsXPlvzRnFmUdSMnYJb+MU0rdfionnkZ0BrNKgoFc18teqRvoKFTKXy5G5963rpUgDZOVy6zzYeEs4NjMwMtctNRVgrW3vgXGMo2Ivm7Uv5FiiiXN9dBBV9vC8Iu1Jq0Wfnn43Pt+Xx1YRBqwPMWxSymJ3J4RKkcnc3AQShebPjwP5eZccQ+bN/yg2yGXhVyOZTXZQI20CI7m3pv7urrhJ98UqWI1fzgbMLXsiPfxPWoN+j+/ioLjPyVqnjXq0jzO7pMnDM4BXtuIPWJzOIE9BKBwxqmPjoO6zzXzd5oxDSm9HQpHrlp+6CEW3gK2FwtwexEwyPVBaAyTjhZ5bdWdh27wbaJcBbxytLo2S3fTh3ZmT5I9ayGGX2+Th4wG370ZlzYWMl/SpWuGJbuSLKSibhPECjoI1HR008xuYTA2LPdDUgDRVlDg+JX9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bikK3bzAU4uyAcI0J4DotFwbUdio2GWKen5TwPYrtU/nmrGTTUqtmoLAVdMT?=
 =?us-ascii?Q?qc2BqgSfzelkcZvEI1NNbt4FOPvaxGPTxQBnXNQKhnFLaXa81+VQynVqRRO9?=
 =?us-ascii?Q?vjqb+LpZTW/JjKQFH982C1AjlB57ajZ7MEqmc1gFZaMwF8L/kX/541ZfM2VY?=
 =?us-ascii?Q?67czWSksKlak/TnVRHjNU9XFvrWfzGCdeVN1TC1/NdjhCPyvI8LOgYwNjRBD?=
 =?us-ascii?Q?ogwqSBajeHFhernItTsQLM58O5hseQf4haaOZQ9c6qewuy2oIISzQCWRwQU2?=
 =?us-ascii?Q?h4TFkJBSDhseQQ++RLHrUZIml59ar5lwYK5/UKlz0CKGJlPZAr1YGVJdv245?=
 =?us-ascii?Q?yG0QZw0vX6hUFTWcpf85kdalxxVlWDIBXz5B5zfg//uUEpPPcZZy8L/1xxCa?=
 =?us-ascii?Q?Iz52SEd8jr6fc3MYxNQtSS7QUp+vdDaUaxC1wW1Vh0p2IMDkYPkohhZFW82a?=
 =?us-ascii?Q?REB9heM7M0HkkC1wquUA8B8rOQErysIb2rbQoNivk5RcUjTeEuyTmzJ+uj4g?=
 =?us-ascii?Q?vgqtj+DjyXSnzj50+gjkBBI6llTyhHdTGf15bAE5Jlop8Y8dTE3mJIHR/grI?=
 =?us-ascii?Q?JXsvG5c5BPml8yo4D5TylHMB5avFjNjMDqpkzN2Ywhz8Spn6xpPAXYmYvvDe?=
 =?us-ascii?Q?4kyaUIvCf902a3nYg1N5wNgMEqwN3sYZDuTNfyA9cr+yHUO9/rh4N8IIhJaF?=
 =?us-ascii?Q?/zNj8Z6tqxX/4gcul4uuLiJ68qWQZ5dEWOHy1JjNb0PzGaA0Gvgm6qsJkbf4?=
 =?us-ascii?Q?Bb2dSGQW4QGS1IKSDEAeSQSgxnUwOW8m7+gy4pCdNQmyhhDlit96T0BNWVvD?=
 =?us-ascii?Q?O2HbxGWdw9oo4zYyO6ELMHd1y3Gh/d2Tm8H3SSVxjv9JjCDeCQNDB38b4KDq?=
 =?us-ascii?Q?1FzZ4x3CyELb1uDmgvw6wDuHLNNIh55YOuUI/8muJlEs//h4y77DJ6PNUF8O?=
 =?us-ascii?Q?wlfeJGBBP/MHBhzun0SIkQXq3njNgFvBBLAUbmhHKitjYpq64mMpM0mHx4g9?=
 =?us-ascii?Q?zTbxN3Ymynmbxr8oqpOxtScLVjicS61q9Nvj9upl7e4MWe96aO6LixjuMxki?=
 =?us-ascii?Q?E0Hb/PMsvHTCHovXPOyfkg/Cx54JPAzt2b/CCyHECDFYU3MtCrNhGUmZuTQ1?=
 =?us-ascii?Q?us+O+7A2zK9GCKlRydZ3iJm6zFPRGP9B3B/ZfEzMdOBygIRSHbwQQ9xtql4h?=
 =?us-ascii?Q?KLMvLBLC8yocumDTChkJe/Ztg+8siippkMkuiA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0293fee-7527-4a02-d881-08dbbf659d21
X-MS-Exchange-CrossTenant-AuthSource: TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:25:35.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2771
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In iommu_get_resv_regions(), param list is an argument supplied by caller,
into which callee is supposed to insert resv regions.

In other words, this 'list' argument is expected to be an empty list,
so make an explicit annotation on it.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 drivers/iommu/iommu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1ecac2b5c54f..a01c4a7a9d19 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -813,7 +813,7 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 
 	mutex_lock(&group->mutex);
 	for_each_group_device(group, device) {
-		struct list_head dev_resv_regions;
+		LIST_HEAD(dev_resv_regions);
 
 		/*
 		 * Non-API groups still expose reserved_regions in sysfs,
@@ -822,7 +822,6 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 		if (!device->dev->iommu)
 			break;
 
-		INIT_LIST_HEAD(&dev_resv_regions);
 		iommu_get_resv_regions(device->dev, &dev_resv_regions);
 		ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
 		iommu_put_resv_regions(device->dev, &dev_resv_regions);
@@ -1061,12 +1060,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 					       struct device *dev)
 {
 	struct iommu_resv_region *entry;
-	struct list_head mappings;
 	unsigned long pg_size;
+	LIST_HEAD(mappings);
 	int ret = 0;
 
 	pg_size = domain->pgsize_bitmap ? 1UL << __ffs(domain->pgsize_bitmap) : 0;
-	INIT_LIST_HEAD(&mappings);
 
 	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))
 		return -EINVAL;
@@ -2813,6 +2811,9 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
+	if (WARN_ON(!list_empty(list)))
+		return;
+
 	if (ops->get_resv_regions)
 		ops->get_resv_regions(dev, list);
 }
-- 
2.25.1

