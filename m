Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAC878F649
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 02:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345909AbjIAAI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 20:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjIAAI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 20:08:57 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA6E67
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 17:08:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDG6m4s6ziSLx4+dejFt/34YBxFLSc2yycTmyZPHhkXWMU/IWMaJDXODp7VAfuYMv3bLZ0LYT+xhr6MmRQd2Dpa7RrbOfEEVDwgoytKCZDFu6v+iofCoHd6fXqn5QgZiLvA/8A5QnLCbKRFVticuUr9aLjR6LlKl8/2TAKnmkYJFgQvqTx8ymHUJ+3/VK7mwZVFNBaHuNHT4MIjHHZL6z1Vn0mk3dAmq1uy81eqdu2KwTeI9KBwKZzV/O7qoB87Tj9lu11XVKXd8Pa+2R0UamcaQsV0WmlKMqT3hCd7D0l+tCCKfurr0d4Kufr0l2Ui33MOzKLAPIs4M+lwuMEY3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0daO7m5tFn8JyCqnhfPZbVZfHvO1YbRI/1gZQ5AOIQ=;
 b=JWQmcHoyefsAaTsSzUfaCWizsXDNJruCRuLSdNCPRbHteYNWXSK9B/NZE1V5Zm5sk29WOThklN3rAIPavSvN+BmZVkgxIbxCIEyYyJ+GeQtOCuwFTBCMjUrVoxp2KerZe9sJbKxGUfGJ7j+xrap53tJ9hl61GXy7eLsgAZWdSZ6+esNT0Zi3bNizmYEdqMfnleG1eGyKxIxYTXLPZ6QEg4OvnCMoNNKSMKfh+mQ3Pmi+w4K1OuBMYn2GU82fKTMOXfRLQoKQwqBMbanJyJvfYUvOrohKoTaYt8SNyc3AABzBOlXqcpirZ6eN1iD4TLcLWIXivoCMk9FcS8bXENL2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0daO7m5tFn8JyCqnhfPZbVZfHvO1YbRI/1gZQ5AOIQ=;
 b=YaUH9coNN5TawQqRCbZdNcczUWpXMtgkA/yTQg9+y89s0d06nZ9xs2PoZOGPDJyfSRAQMwJ/xO4fPydEoZFsn0KXqYOfhMMFD5Cd+12dDqtWrKFJp0zCnXNjgN9uAYNv5ujxtpXFNSmWY3UzVo0jUBNm6hnYAHwlKVT6kkqQAbYSJAlXh6XeRoqNI/lRZ0qPoZA+B3JMR/xLeQiQRvR5wRKD2iaSUDxuIEVSXd425j8wahhci5CYy1brqoTv6TdIF4GAIcmK3HNNYxfXYnbxT7kwFOdqAp8sk8Lw81DP94HphIGTQ46MYBdgdVuXdVJPCJsiXI2I4ThiF4wkabrlDQ==
Received: from DM6PR02CA0154.namprd02.prod.outlook.com (2603:10b6:5:332::21)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 00:08:52 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::47) by DM6PR02CA0154.outlook.office365.com
 (2603:10b6:5:332::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Fri, 1 Sep 2023 00:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Fri, 1 Sep 2023 00:08:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 17:08:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 31 Aug 2023 17:08:44 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 31 Aug 2023 17:08:43 -0700
Date:   Thu, 31 Aug 2023 17:08:42 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC:     <jgg@nvidia.com>, <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in
 struct io_pgtable_cfg
Message-ID: <ZPErio3R5redmDNU@Asurada-Nvidia>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
 <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
 <ZO5uGKzGsaliQ1fF@Asurada-Nvidia>
 <20230830214958.GA30121@willie-the-truck>
 <ZPDQPs9UL2sksblM@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPDQPs9UL2sksblM@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|BN9PR12MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 497178b9-4528-4277-f032-08dbaa7f9fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7pBw3tgWqEs8bEnMzdFNjMm4xC7s8oc/pfD4qT7sOUpQqcT35qt1JnLfXCA/z3BhJOzWAGJUAbtuaAHQX/UEwnqVW3eSZldlRrSvlDn9g+BCHDnYQx+2CUl5VlpUGbCJgxSFgKdsDgsw2b1yMeXRQABsWe3YtVf32yzqWrCwTqvH8wHSumbVitW/nXgP+gNlgemmFCPqki2siBiY3uxUgzj3ZhGUMrwTZfA8BDPusLH9MNmm6/YJH2hTN88EDZjVhKQtFyDWKFCQPaUQXFzQptqOZEpHUzwqXNGHkTA7Onbk/g/XSjkrd/CQB2ZYxtRBYZq3V5im5bLL5Sxj2BkMKy9yHYx00kPo9FIalr9UQJ/8Onr/Fkecp/DIRlGza3le2rATigueTPXO671PHiOF95hlO/1SidHdBbvE1REKBB8ViQrL1Y56MlWqyNrZ3qrrzGG8cbz7o4kF1drMiUaGn9L5N9PWhcuOgUB/c3vsa4dfdd53EUR2/X5g3Ks+xRsZngeTZz1ayXxAj9YBgjWVaBRB+yS9A0qvsaOfDpBAUYkfqZlCiVNCT/TaCMOpMBE4m3ig8R31cyZJJSTce4VVpa8tj/n7kkKlJwQYn+EIGSVwQRdDI4NlcsJ8Y/rp3Ax3tnggnpiTfW1Y4c4PzvitVQhKE6enap58je63yLHcHm0+42gnKN75iAzjqpf3Rkm5CHTvBhI8VPwjxH9XyLQ38vPLZpdAp5dYKgwQ/kj/LvntPXhUExD7PqP7lbMUcBTl
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(356005)(7636003)(82740400003)(9686003)(40460700003)(55016003)(86362001)(40480700001)(47076005)(36860700001)(2906002)(426003)(336012)(26005)(83380400001)(478600001)(70586007)(110136005)(4326008)(70206006)(8936002)(8676002)(54906003)(5660300002)(33716001)(41300700001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 00:08:51.7878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 497178b9-4528-4277-f032-08dbaa7f9fa1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will/Robin,

On Thu, Aug 31, 2023 at 10:39:15AM -0700, Nicolin Chen wrote:
 
> Though I have not dig enough, I assume that this worst case could
> happen to SVA too, since the IOTLB invalidation is from MMU code.
> But the same worst case might not happen to non-SVA pathway, i.e.
> TLBI ops for IO Page Table doesn't really benefit from this?
> 
> With that being questioned, I got Robin's remarks that it wouldn't
> be easy to decide the arbitrary number, so we could just take the
> worst case from SVA pathway as the common threshold.
> 
> Then, SVA uses the CPU page table, so perhaps we should highlight
> that SMMU sets the threshold directly reusing the MAX_TLBI_OPS of
> CPU page table rather than calculating from IO page table, though
> both of them are in the same format?

Our test team encountered a soft lockup in this path today:
--------------------------------------------------------------------
watchdog: BUG: soft lockup - CPU#244 stuck for 26s!
pstate: 83400009 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : arm_smmu_cmdq_issue_cmdlist+0x178/0xa50
lr : arm_smmu_cmdq_issue_cmdlist+0x150/0xa50
sp : ffff8000d83ef290
x29: ffff8000d83ef290 x28: 000000003b9aca00 x27: 0000000000000000
x26: ffff8000d83ef3c0 x25: da86c0812194a0e8 x24: 0000000000000000
x23: 0000000000000040 x22: ffff8000d83ef340 x21: ffff0000c63980c0
x20: 0000000000000001 x19: ffff0000c6398080 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: ffff3000b4a3bbb0
x14: ffff3000b4a30888 x13: ffff3000b4a3cf60 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc08120e4d6bc
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000048cfa
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 000000000000000a
x2 : 0000000080000000 x1 : 0000000000000000 x0 : 0000000000000001
Call trace:
 arm_smmu_cmdq_issue_cmdlist+0x178/0xa50
 __arm_smmu_tlb_inv_range+0x118/0x254
 arm_smmu_tlb_inv_range_asid+0x6c/0x130
 arm_smmu_mm_invalidate_range+0xa0/0xa4
 __mmu_notifier_invalidate_range_end+0x88/0x120
 unmap_vmas+0x194/0x1e0
 unmap_region+0xb4/0x144
 do_mas_align_munmap+0x290/0x490
 do_mas_munmap+0xbc/0x124
 __vm_munmap+0xa8/0x19c
 __arm64_sys_munmap+0x28/0x50
 invoke_syscall+0x78/0x11c
 el0_svc_common.constprop.0+0x58/0x1c0
 do_el0_svc+0x34/0x60
 el0_svc+0x2c/0xd4
 el0t_64_sync_handler+0x114/0x140
 el0t_64_sync+0x1a4/0x1a8
--------------------------------------------------------------------


I think it is the same problem that we fixed in tlbflush.h using
MAX_TLBI_OPS. So, I plan to send a cleaner bug fix (cc stable):
--------------------------------------------------------------------
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a5a63b1c947e..e3ea7d2a6308 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -186,6 +186,9 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
        }
 }

+/* Copid from arch/arm64/include/asm/tlbflush.h to avoid similar soft lockups */
+#define MAX_TLBI_OPS   (1 << (PAGE_SHIFT - 3))
+
 static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
                                         struct mm_struct *mm,
                                         unsigned long start, unsigned long end)
@@ -201,9 +204,14 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
         */
        size = end - start;

-       if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
-               arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
-                                           PAGE_SIZE, false, smmu_domain);
+       if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM)) {
+               if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV) &&
+                   size >= MAX_TLBI_OPS * PAGE_SIZE)
+                       arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
+               else
+                       arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
+                                                   PAGE_SIZE, false, smmu_domain);
+       }
        arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
 }
--------------------------------------------------------------------

What do you think about it?

Thanks
Nic
