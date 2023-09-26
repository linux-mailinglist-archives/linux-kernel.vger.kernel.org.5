Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDED37AEF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjIZP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbjIZP0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:26:23 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2041.outbound.protection.outlook.com [40.107.105.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCF610E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsQY5lvKwNE1l7HaZb+yhT7IJDVp+UIvHzUvTZMZW1KSrCKAO9qsSgsa63F31GoQYmKEBgBfhe8KBl0Wcf7Kd6cAsM4eB1mpGomhEYosZoBF0DexbZDPTBUX9zX+k71iLWDjsQd0dUWofvrbeMwp+F6l0N59INc/7z2HB6LdzeOFwxQ1vRt7LW+t0yHJ00D6tEHSTJDJpgmIKuokOZdK2C5Bl/9/vahE4ram+MXFmZeC0gnjC37fYHchOREq5Z+0XLvLcYptXo9XTJkQsP92Y7Opaz1Mikm3DLU2ECyYOWP7w6gr7Cs7xyhD/gtUfx6bZWwVhWzzYH8JMnI8rb6f4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjS2oc1G2xKWiWE4J4bNLWk15KU6ekD8lNB1EVGxXPM=;
 b=ZS9sPSP7hbjwlVrp1I9ro/BgJlU4QValXsTm9dDK6NuhwqWY8HEU/MD0v6XaqXCwm6PQ/ytWPTmHOCxVvyZ2oSVdcGlO7JCnsS0AUEYH0N6D/x/nvRqSBIL/5aE9AfYBUXMq+A0TGnJRDqb/7FOPa/603aYjaB6+zAwOV9tbOjN63HeAwW79RQZK7Nocp1tCoZ+RQiCBTtgALoFIy6CMH7Mebq4REenkh9ny7zkE6cvYdjU2zGeWH2gfoygjuzXmveUYHksCWpfyvDFthYrSB6oCS1+cE0s/1xazgNFU3dVa2tQcb5MSONVqvNRH2sNNMdKEqOdtTVwOmw3lDkPyQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjS2oc1G2xKWiWE4J4bNLWk15KU6ekD8lNB1EVGxXPM=;
 b=mo2G6uweotZ+1U7kWSuYN0XWDCIz5bP3RbhnGqnS5OR+vajivnbFu90NurVAesj5jzL9LEJAjk9CIKBzoJOapBN1cvHYYMlXiZhNMR1RlJUwljENayTpzUnhPgmSreJkNYajW+WHcXhOL4/Uklz5NJmEr91vfMwaqX1qgq68J5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 15:26:11 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::425a:a4a9:17b3:cfe4]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::425a:a4a9:17b3:cfe4%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 15:26:11 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        treding@nvidia.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v3] iommu: map reserved memory as cacheable if device is coherent
Date:   Tue, 26 Sep 2023 18:26:00 +0300
Message-Id: <20230926152600.8749-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0225.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::32) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|AS8PR04MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 372469d3-a7a4-45b2-a3f1-08dbbea4e9ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bk2SioSbhFoNIdCXj9QHnNHk1mffNr5povuf6jCTo/1YwShFaTEc3VMTzE7ff/V26R2qpFy8/CPnidU3bJXtRFZLixjhnsymp6Vrc0J8rex9tC2s8Yc+SzEsvdcaye1xVkwJbGGgjJkfiAGkXeQaGbKRqDubPDO19PozsxbmTKgrWDB2caOk5J6OFN+pjFX7U5vk7NC6UX+HD3FV3YyVRvwHh7FA4e9wSLg6hEDnbf9kZ++dX4Fzuh67uzrVqBmYp3gMYzPZ2kZ4uGWUIa5ufsvhLSBiTqN5zm77XpRkRC/ZMh3ekSmilLT22Z08T0nQUrwDFm64V9tJRiDtH920zAY8v7CeWGSKzeRKI8O7+Ncdg792o3dBgZ4smEc+m31l8yuc5sVm687GMU9TlPU6DBz0ZtB/mXOIJ4XP1Y+y1fci+EEYYaF54Aivdy59xZkFVZnPofiw2sTQ4X+iAEmlkN8X8+zzs9Uwj0TeO67h7O8cc8lXQ2VDQXGJD1iaceTQdN/mGHJKKk9NwRfXAxRcYmJxYn+cwj+r0x6d4VwJYZYz+EKWetxXnQ8YeBB5+ZGNRs5wUBuGVQGKVuxPJgVixQURqeVxf+auxSW/3YPCgMhDqL/yiAqLwMpvN30Md3S2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9380.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799009)(5660300002)(316002)(83380400001)(44832011)(41300700001)(8676002)(8936002)(36756003)(2616005)(4326008)(66476007)(66946007)(66556008)(1076003)(6486002)(52116002)(6666004)(6512007)(6506007)(86362001)(26005)(38100700002)(2906002)(38350700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6pY9MerhWsPfiAUGRhTAnPfgpZ2oSk5T1wXJlQHOXW+00AMvVke8HIK0c4OF?=
 =?us-ascii?Q?SrfKWn7vKPRVzk+X6OdVOL4WZcEB4gopCXTkLDg9uHM/5DpGk7FthOgYqvMB?=
 =?us-ascii?Q?L6vPYRhHPN/mUersq/UYAYt4XN5KroTqheO+K/touUlCqClKK2Dh3R4ZYxUq?=
 =?us-ascii?Q?mEGRMWWSzvDWkPYsLIy3XO8IMMUBuD5RIE4vIp0lvTNaImyjvp71RU9ysvW3?=
 =?us-ascii?Q?PyCZtBw0jZ1whOTyQJ1RmUpLXw5DNkAcZ2YA7LledzBRY5hP+KgrsM3RIFPa?=
 =?us-ascii?Q?dGlkSz7675deFChYcyhk3ed4n+1lC17ziO8T5Z3KXXU6hSjmjK6yqVICuyD1?=
 =?us-ascii?Q?lqGSqK5ipStMsL65CT2WQ+AxYDyDSDml5J+ubr76zGdvnUGhPA8dHZScPkZ8?=
 =?us-ascii?Q?wln2trtW0BmIwG+Tw9+qDJjHIkcVxSlLT+dAQuK5ihs92oHJk67nxJ20CZLx?=
 =?us-ascii?Q?8JTFHMfAwy7KJ+NP2cggenY8x70YuV9+Ray4pGh+yMTsjFy/A7UFjEtn5UNT?=
 =?us-ascii?Q?yA/f32Hus0Q2vCE8Arx18wDvhAo14BgqiHlksKA70s+fBIpGDtCMMB+IAoL1?=
 =?us-ascii?Q?pgDZ47OmwUF8r0sq+FkWU21IOcwr6+dxkAxz6hT0X3/Z14dKLe0t+o15cljE?=
 =?us-ascii?Q?zHoJOm0QKWF1jGFWbzXazPCopIF6Qb2qdO+i8OaZqVl+Poe/Nc1xwFdeCMrv?=
 =?us-ascii?Q?ut088fdDfNPQhjftjxYJWizrkOjmiaO2vnCHviWTyijFgvCpW962FhNLVBGA?=
 =?us-ascii?Q?ZKbgj65rwQ/3r379pD/acWkMgvupaqPyfVbcdtt/LAgFmmLY8x7ePJTSaZEV?=
 =?us-ascii?Q?XjNkFI4nGpdNQYYiQJsTohK2Xz4cZpyPrHmwwdgYS1rkJObD0LlArdKhCQRZ?=
 =?us-ascii?Q?tHLpiJchZ4vMg8jfXlOYEwEpVVUJX5oZ0vIGU15olKcZfSD0P/3fy+izsfoT?=
 =?us-ascii?Q?uTDFjQlP+cLRkoORKdFGEMR0C7kxIaIMfrKBMcngq+9Pm8HnCiEpZOmM4yqW?=
 =?us-ascii?Q?3HhrfQZRNzlZzi1oIEPMYjwecWvyRpHux4GkLZh4i8vmggccAx8fDGk46jPr?=
 =?us-ascii?Q?gXpRdO8VFv2HqOcpD/TbBcTgx/I83Ohq1dhL9K4/1vP/nn+fy248QX2xgr9z?=
 =?us-ascii?Q?qUP2yrjN7LLwdZ7x0ERseMbgYAANheIDH7VbcYzK62zfDduOHwYn1S4d2xuV?=
 =?us-ascii?Q?i1rcUzb6K1IN8WRt684MSqhFNgROUff0uofy9FREF4PKIQWor7eJanJJgtI0?=
 =?us-ascii?Q?J1LLD8dV7E4eW/HRKr/Qscl4tqKirjhMZzGZPFE2Otl+AlyO3xy1NjAIfew9?=
 =?us-ascii?Q?UFXHoOy48Pcu/XDp5kVRcI3/mTyq5bEMh5ystMIbSk4Nd4YZctELwHGXmSzB?=
 =?us-ascii?Q?UZV1cDA4Oxh8Bm38QDFmcVhA106iDiG+ZcmQw0OtjiP55in+BzLTISKrLP+z?=
 =?us-ascii?Q?9oIjA/pMfPvhCBs/jiv8jk68cUHcJE6OfpGTFUZtMZJCiySxJOzplY8NyZwa?=
 =?us-ascii?Q?f5Wl2/qrACSKcG/XZPabQ6feFQaMTQuzMNwfyhFdQQSVtShtPme02YWGL73V?=
 =?us-ascii?Q?gg4rSE+3Km/xdUxugd9YfKtCB3XXKD+Hp01wVdGn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372469d3-a7a4-45b2-a3f1-08dbbea4e9ba
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 15:26:11.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKOP1zIQzMySyOrWlfOnAc01301Elw8NqJEKEY50oa/XQiNIjktT8gXH/DWO5R2gpmS0N0k9kOlEecHb9DXsTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7493
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Acked-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
 - added Acked-by tag (Thierry)

Changes in v2:
 - added Reviewed-by tag (Jason)

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

