Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4733F7D19F3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjJUAhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjJUAhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:37:43 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8B4D5E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1DwBGfG/DiZyTsX1rny16gR1uevbUESyHVSa45VNMA4QwdPN1j4fqPG3yHNVoj92+32SAS+20VLcIu3z+IaQneIKRJlkAlwkwqCWGeh/Kb+32S+FtUEkoL5wpUXqORKEES/tMxfL3Rv76ByXKW59bOtgZowmh7Sk1pW2QxxlStfvaFQQ3wj4MZZSps0oS2unvWPBpqeYMQecex+FZkiBbiSKloEL27uWjSE14ChggmOGRdkTfp9o2Tq+1seakHp0f+5FJZHRtcl9zfi5sN1weZ2oLu3UxfzfMigdLwNoZ8kW9x8qYvuh+1tcF+CluWmJxDK9Nc4udp3zjt1GlrkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJmaG/87YMY7FeaM0m3Ga3kSFFqzx4R2gWWnTIG/aMw=;
 b=GEC5NV+fWLqbZqz/hDizPQlM9BvBC2h+L508k9h3vRK7+N5a10ldCE3ovvmr/7l4lwdxCNOp/DkE+3R5Ct0DLbMy+aLqO3Shnru8qPFSmTfe2oma7BkRbjOSu7Anme927S1dhRcW99NSw5sruWjfs/oPASjg6UEOTx/GnXcxlnnzuvEEvfPUtCPNuxcSDxBABAVQXqzCNLcyyKLeZaJAPsd1640UGDTuSJOC7ncWb9OBA6w+7nIznP0uXwoDJBBQysT6lXh/6+4eNR4ssXBDY8VC2z+IU6DRjhmTg9p1Rt3cyCZeqUQJ6yrZQdUUXcPcbM3rwINhLVIIuiiWcSTbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJmaG/87YMY7FeaM0m3Ga3kSFFqzx4R2gWWnTIG/aMw=;
 b=tQQcUcgg3lPJarZtJ9xEVmV6wqxRZdc0As1/Z9Vu+kY5YzFAqNfyh/KfHMhkik0hPOgukffFNtuRSZX4or9l+bl6eY7dqMYPMv8qUW8kMk6e6TTf5aEd3rA+Fp6XIFW2TuBrUqW18PHE8SEv2wj0bTCiXpuask1Hhi5rND6THVoJS9BfUlN5gUi1WEYfAgJzPtu/9YLWmLr7GEtkQY7feBNpnJa5d6X1kEzKIK3X+wZvwyOgkm2zRNmuPh1CQbhw6CEtfHKRn8LQcB8oto6Br5OvfUbwSRVmC6Gh8GZQhHjWDP+qkP1KpQOBTMOURSFN6bg+3G6PA2wfpOgCN9Y8/w==
Received: from CYZPR05CA0016.namprd05.prod.outlook.com (2603:10b6:930:89::28)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sat, 21 Oct
 2023 00:37:33 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::c) by CYZPR05CA0016.outlook.office365.com
 (2603:10b6:930:89::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8 via Frontend
 Transport; Sat, 21 Oct 2023 00:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Sat, 21 Oct 2023 00:37:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 20 Oct
 2023 17:37:25 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 20 Oct
 2023 17:37:24 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Fri, 20 Oct 2023 17:37:24 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <yi.l.liu@intel.com>
Subject: [PATCH 2/2] iommufd/device: Drop enforce_cache_coherency in iommufd_hw_pagetable_attach
Date:   Fri, 20 Oct 2023 17:37:11 -0700
Message-ID: <d51a21eecd19966a98cb56b99a4ed1d7f89b6151.1697848510.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697848510.git.nicolinc@nvidia.com>
References: <cover.1697848510.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: a86818e0-018f-4ddd-4e15-08dbd1cdea8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zW2ce2DoX+DjMhIYVgGm2i09jYhPGrl+J9kMX3RiYkx06PJCPon6Z2v0Ow5v6NHFoy/D8voBNvBG6OxxKoMJiKU2HrtGDTnoCW9WLPZ2qDEXPfiB1G8TE7Lg/ILMj8lrIxGTNgld7d3i+MsNiXNJwSv1hcF7xpwUvk+vKOehIc1SS1ntZViR07B9pusoD92rzyXrIiliiQSRQ6qNB0zUvUSRt4Hd0Qy2Pt+fRaH6hMNqtLYY/b21gf+fjNU1DuslSDRjUaVJXGAMoagi0kIIhq3QshkJwb1Bs+eBh4gQ4AOcY8BaguKz8f2qV961ZHj8B9DWAUehNrUiZ8RlcvCRpowvMrU/EXIXszIxf6tlWmt/zkX3lFwUIrjF2mL+TCdRYMucpuD8yHT5KsrUvhmnrjAqAS+4DEVffIzbUcSbVfEczrXBjZoLuFGq4eqEZ9fslurlWz121IlzyGbjsvL1ioF97+gU5cByovn0fmaOW4pm/oPxnGTJmOA0qffVdMnECLVJkxMKofyqNxLJw+MYrRLR0niAYPnXFR6AA/Wtnh8M61Fka4nmuCkaetEGXXJp8UTPEI/TwdQiaU/ahSB51gWr2j9vXvkr+tkIGG745xX5rHJ/+OeiRZ1v7mSPbe4XNSgETHXwkUmAW2bt7HOm2AinY5mU5B4U60QbjYK/uxAMrrcChsvDcTabTZdmn0Gx/Qc0EGfpW4ivgH7xRbNm7QEK9qITc8IwuxOs8Ez5tptzA7ujzKLGx33wFqBQ1i1nxZWmsbmK8aEIq/HDMRIt984pXmer8g2tZ5CylH84CdA=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(86362001)(40460700003)(2906002)(5660300002)(8676002)(110136005)(70206006)(316002)(54906003)(478600001)(6666004)(70586007)(8936002)(966005)(36756003)(4326008)(41300700001)(47076005)(36860700001)(7696005)(2616005)(26005)(83380400001)(356005)(7636003)(336012)(82740400003)(426003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 00:37:33.5724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a86818e0-018f-4ddd-4e15-08dbd1cdea8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the conversion in the following link:
https://lore.kernel.org/linux-iommu/20231020135501.GG3952@nvidia.com/

The enforce_cache_coherency should be set/enforced in the hwpt allocation
routine. The iommu driver in its attach_dev() op should decide whether to
reject or not a device that doesn't match with the configuration of cache
coherency. Drop the enforce_cache_coherency piece in attach(), so it will
be called only in the allocation routine. Then, drop it in the header and
mark it as a static function.

Cc: stable@vger.kernel.org
Fixes: 17bad52708b4 ("iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()")
Suggested-by: Tian, Kevin <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 7 -------
 drivers/iommu/iommufd/hw_pagetable.c    | 2 +-
 drivers/iommu/iommufd/iommufd_private.h | 1 -
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index c93f3478f808..557c10fd4a7f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -337,13 +337,6 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
-	/* Try to upgrade the domain we have */
-	if (idev->enforce_cache_coherency) {
-		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
-		if (rc)
-			goto err_unlock;
-	}
-
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
 						 &idev->igroup->sw_msi_start);
 	if (rc)
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 8b3d2875d642..b8bad5b16b5f 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -42,7 +42,7 @@ void iommufd_hw_pagetable_abort(struct iommufd_object *obj)
 	iommufd_hw_pagetable_destroy(obj);
 }
 
-int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
+static int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
 {
 	if (hwpt->enforce_cache_coherency)
 		return 0;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 3064997a0181..60221e728e80 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -244,7 +244,6 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, u32 flags,
 			   bool immediate_attach);
-int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
 struct iommufd_hw_pagetable *
-- 
2.42.0

