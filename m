Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61307F5809
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbjKWGMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjKWGMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:12:19 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A31C19D;
        Wed, 22 Nov 2023 22:12:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZNuIy3E63aBpdEm0B3q6/yVF2MlxWiKklT2kzkVCO7k5vKfFmSSAMpzOew4zRrVRDIHxPd8LjWhtANDnSvm0/LVKjfEuoezEpGNr/um4P4u7JnarLGnpSGE7nK1NE+ZmyqLMx3hS9/ykhz5M2WloyQ6yfBKCPWZoN3SlTaw3NjtRG6mcTxzAFLUABRp/2YrOHCvFAYZtpedJQoOoxF7gythJ2FGnt8aRiNJN/aZHgpDw2JnduPLn6xET9XYlvjpNrYJkrRUdV1OeJklkDJml+CY63mPW375efzaWB9H/CZ0KmS/gycdSgcgjpMpxUbO2tOyH1cCcTt9F9XYwI7oOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsewroVGgFflXzhuj5kumgX+BUuSSpBaCj+bLWL0rwQ=;
 b=DPZrYQ6VfJxnRozLCOrhFPRcxI4JHl1BQl+GOihpD8UikgLOhRwTmdkDYXe+V39gYaFhAaf0TiTT2VF+IYp5GroAzuOIQh0NRVbgVMiF6PH9sENNsfY7s8rKNV8+twXon8iE4mCVzfz8wBX+0cLDvYRKOXB/sYZSm6B7+MJUM1KD4ohz5VU+ntr2JPOxD8XZLerOO3q2OU8x4PhhcY+i4Cyen+KEAdCd+vBA/3yETkpdsgZXQiai5oKEBJPX61aQnNCMqwLexGXuNx29tMSKKoyoK/8z2O7XLQRlKppLKzUCo6Gug/Iati+dXBNnz6s25pNJHa/K2N8Gy/V4qoCz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsewroVGgFflXzhuj5kumgX+BUuSSpBaCj+bLWL0rwQ=;
 b=o/L6lebvrcHNnDzucTbwJ8eg2CjhkiKo1T65FIWSDGty10xdvkChDFjCz2b5Nn8Uiy7t/uZkUJv3sF0oOG4xQF9j5xV5xKsFBcPqYO3t6b0UeKDjIkxFvMw9JBQ02FN3LzR1OgfQamkLIdVII7r0WCgPeZkNc4H1dqur2kQbJTeC8kjGVZQSVyz9dakDiGG+haSWf1mxm1PdpFILXA4ep03AgSwULK8N991PlEzz+gVtbSJa6z9Rc42u0zVAMOqjL4Z7h8aOrrLSvZZMWMdRzDcW4YxFbA0B5q2TfXOlwiwNGjvxo25x3o4CdzQ5kVXR0juOII7yuo3G0FAGvi6RaA==
Received: from BY3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:a03:254::16)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 06:12:20 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::2) by BY3PR05CA0011.outlook.office365.com
 (2603:10b6:a03:254::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Thu, 23 Nov 2023 06:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Thu, 23 Nov 2023 06:12:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 22:12:07 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Nov
 2023 22:12:07 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 22 Nov 2023 22:12:04 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <robh@kernel.org>, <treding@nvidia.com>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH] iommu: Don't reserve IOVA when address and size are zero
Date:   Thu, 23 Nov 2023 11:42:01 +0530
Message-ID: <20231123061201.16614-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b28bd9-61a8-4250-ce16-08dbebeb2673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Yww6NmGKgXsHlTMOOYWi9rHDou5qfo1muFvInFrsYpLDyfu017v+39GdiKLRH8IE96et4Lvtrso3+QpEb65w9w2U+uw9X/cfPN9u1eKvWhBrFt2GmrbzqKz4dw3o8/rtkxdSQYcw1AEXDMsbAEB6tAZpctqTHMpLwJ8N7ZsKttn0v0+T7b70WL9Y7he8J+GE8j/9UXqjBvU68+BL8juKfgMWm3omRwZkdNhN082DXcXHQSq3pHShNzdtU5dHkBOHmKnAmSSofKuJnv9X6WdFJipnWsWNXvlmw3OK3DyLoRSlseGMQsboxNNrYK2wdaIg5xCDut8mfTB4RPXQi2T7Deb0udzV0vdgaVlPzAvMDT1wWfFm3rdPQYSdY0hR8PyP5z9ApLi/Tkfe2uPvV9EapGJ6hwm2wrK74Xfdjcl2Wgi9LhudVqeFOqCs7Ted91KlNDnh6/yM8tEFH/JhyC5nybYeAUP36w/PTeQxKvH/KB8w5DN4HGWUjKNEtJdU+/yi4Af9YuzmRvJscybSa4mdftsvOfzhGjnKL3pNDYbRbGh96xJgjC4Gmb9mO4wqy75CR/cJtGfbjTqU3TxcZdA7ytRHE4SGFJZh0yHFKxaJiEjsJ8jP4tldRHaewNs/GtcPNvVhjVyGGGDDs/t+p5gAlZzf3JBLFPpVi4tfHUx/AVPYoLZRKCX5yZ8LWdpX7qmyFz1P5SAnQkWLObYGwa5u3g3c5TR5s1SNZQ+Ca7TUtL5LXlX/gRdOK5zeIrX4PYfqC/eUApFJg0xqjkJxj5Aqg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(40460700003)(26005)(107886003)(336012)(6666004)(7696005)(426003)(2616005)(36860700001)(478600001)(4326008)(8936002)(41300700001)(47076005)(8676002)(2906002)(5660300002)(1076003)(316002)(6636002)(70206006)(110136005)(54906003)(70586007)(86362001)(36756003)(82740400003)(356005)(7636003)(40480700001)(66899024)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 06:12:19.6460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b28bd9-61a8-4250-ce16-08dbebeb2673
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the bootloader/firmware doesn't setup the framebuffers, their
address and size are zero in "iommu-addresses" property. If we intend to
use display driver in kernel without framebuffer then it's causing
the display IOMMU mappings to fail as IOVA is reserved with size and
address as zero.
An ideal solution would be firmware removing the "iommu-addresses"
property and corresponding "memory-region" if display is not present.
But the kernel should be able to handle this by checking for size and
address of IOVA and skipping the IOVA reservation if both are 0.

Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/of_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 157b286e36bf..150ef65d357a 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -255,6 +255,10 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				size_t length;
 
 				maps = of_translate_dma_region(np, maps, &iova, &length);
+				if (iova == 0 && length == 0) {
+					dev_dbg(dev, "Skipping IOVA reservation as address and size are zero\n");
+					continue;
+				}
 				type = iommu_resv_region_get_type(dev, &phys, iova, length);
 
 				region = iommu_alloc_resv_region(iova, length, prot, type,
-- 
2.17.1

