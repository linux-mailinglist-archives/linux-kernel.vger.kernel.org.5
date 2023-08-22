Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B1D7847A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbjHVQcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237802AbjHVQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:32:44 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0198137
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EawK3Xi1dnekMQm8V+N9zPiDGxNVr/JZCxB+RC51nLWuRmpmwQrL9JEus6HhEaUMMS5D1DQ2rBrwH49jWdwWB/+8fEPNBLPjG53VmGjBfHg+gTfFLSgdtwiSdzr4ykd+uehe/eOOzklpWsUmUcqxKJkf4Qc16czVye1pYoCmQ68ATmNr/fEOwN4lQOU8oo2uvMAGwfeCiVPh6cNzEA+VXL0TYc6dBogYg//QXeQq8LCDqYgW6r+HE9RyTHmO+3G2hTHEEDFzy4o/WhibKnRvzslP2S6GCnyI+E6+E354NxPr8Jc0avjIJkR1oBB6cWn9HbrXdHytHvrFUl+K821LrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTlFBVDqyW/vAK8Z7INIl1TfTdZrRpgPdMpl7KFThlU=;
 b=ehqggjDLNttsLngvmTs6QEzvqRlqCEQUjyxR+f/X6ZUXo7o19BvSZtpgqAxOr1YXaWxdp2vEq2aDX5ZI6Z/3tZdostq4POb8A4tZOfsv5L6WbkJsKsXH1lu6f5La4Q79YQgCKPgetHUKzYsVlr5ZE0gZhZlAeICkb3HxctLoe1djRa251ngu/D/o/k8XUhSbPN/jXTJAOJeAyw9Cqxg6YB7+kql9/aFWVZeMHmKNWIwM7ZEFEueMUSJEPOEBIuMZxCRprGHtcOoC3tjHkC8tYLKPwMmK3OIJQBVJfy8yhkIFV1ixRLarN8vmGsYeUG1P8fhzk7KiiP0IHZfTroDSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTlFBVDqyW/vAK8Z7INIl1TfTdZrRpgPdMpl7KFThlU=;
 b=tDSJXfLC1ErLMP+g9cI+X7qhxhrbhYRQlx6sWAUAEWAJMawnggFsVDsAWniYa551oXtaysDA3gRuwkgukfxrt/ZH0j4oGG4rir9jxq1JN7m78HzQd77o0KgEfP+Bx4lN7D04AKvXJldXy7wvDIGYFuX/9yCAiPwL+o/3tQJwednQDdd/NKnykT86O5X17zeCpUxRkjWvU29is5E8Rt58yXBG5WdLN3JOoNv862ZmgD5yXxJmUwtpu1S0h2lAMzKn6vvVUaCMNw7UXDvuF+CohZqNYdyzXplzjnJ5FwZdNennHN4B5Mhk3PXQfFf7KSiZoC7KobX53m5tJQiLkx0w8Q==
Received: from CY5PR22CA0037.namprd22.prod.outlook.com (2603:10b6:930:1d::7)
 by DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 16:32:41 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::a2) by CY5PR22CA0037.outlook.office365.com
 (2603:10b6:930:1d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 16:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Tue, 22 Aug 2023 16:32:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 22 Aug 2023
 09:32:27 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 22 Aug
 2023 09:32:26 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 22 Aug 2023 09:32:25 -0700
Date:   Tue, 22 Aug 2023 09:32:24 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <jgg@nvidia.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 3/3] iommu/arm-smmu-v3: Add a max_tlbi_ops for
 __arm_smmu_tlb_inv_range()
Message-ID: <ZOTjGIJU8Kfl1Q4f@Asurada-Nvidia>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <3ba332e141102d31b756326cdc4078cac1f5ab1c.1692693557.git.nicolinc@nvidia.com>
 <3f630d3d-c59a-f454-14db-2bf9b8e76877@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f630d3d-c59a-f454-14db-2bf9b8e76877@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR12MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: d54a6c3d-e48c-4d70-a7df-08dba32d677a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHqcGallw0OE6wwbhR+q1WBNhLX6AjMhja/biGGS8N2DRu5ur1up4aAMfXl50x+EiapDC/yENyC5nv/U6wCOSdPJtvMV7v0iqas9jehculJfpGiugQuF6upkzLx2BfTBxGNUCYEaSd1Zom/EdoQO76K1ckQLa/7Qk6fDUcU8GLHzdlq9D+oDnEfqMNk1yLvnkPK88yuNgZ3ddcwUKqUhwo5R+eAnxKQDyc84GoaPQAn/b21In/3kZFwIVwSyGzU2N+3IuIhoknkP1TBWq4CutCulu8QSCtgaBmXnjBN1SpeWAjS3i6UB0wHiSwSoaz8XSOnKfxczUi+swyT/uWJiavr1PbrqMcPqRyWiX4bsObUyh2MwG2rNdOA1Y4mL5l/0moPs8EgOEtJFCRPRFJhlBzv4DHZUKtOulWkLDKrRnP9VcWQpI8Yj3bGc6e1+l+JZFWQSQQHzHawLe9LySEZJ8uXnpzRlkjDsufg/03djGu1LCPkL6FpbLbi88IQRH64o482Ti+FutQ1gNmOocsWbqfVgBjQ45D8fVcSwFDL/LNyxOq/LPvsotWLKTE1GQMx0ls9/z13TpqVRcppMhe/G10gQ2rEpMiJICryavn5z3g3ir7o92v+PpPvsXLPnor1JgH6lYJnRWlvjpIWgmIgkQ7RKRr0P8WFIsaiM20ZX9m/nj+8D2AmUUurVvZi2P5QvuQ0Zuvdvxj6e6qxUXHuQd0nUsqMkRZX5O580Vs0lb2ZBktbR4IM/CNBKtH3+3smk
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(36860700001)(40480700001)(336012)(5660300002)(426003)(26005)(86362001)(47076005)(8676002)(8936002)(4326008)(70206006)(316002)(70586007)(54906003)(6916009)(9686003)(478600001)(82740400003)(356005)(55016003)(40460700003)(41300700001)(33716001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 16:32:40.6910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d54a6c3d-e48c-4d70-a7df-08dba32d677a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 10:30:35AM +0100, Robin Murphy wrote:

> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index d6c647e1eb01..3f0db30932bd 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -1897,7 +1897,14 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
> >       if (!size)
> >               return;
> > 
> > -     if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> > +     if (!(smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
> > +             /*
> > +              * When the size reaches a threshold, replace per-granule TLBI
> > +              * commands with one single per-asid or per-vmid TLBI command.
> > +              */
> > +             if (size >= granule * smmu_domain->max_tlbi_ops)
> > +                     return arm_smmu_tlb_inv_domain(smmu_domain);
> 
> This looks like it's at the wrong level - we should have figured this
> out before we got as far as low-level command-building. I'd have thought
> it would be a case of short-circuiting directly from
> arm_smmu_tlb_inv_range_domain() to arm_smmu_tlb_inv_context().

OK, I could do that. We would have copies of this same routine
though. Also, the shortcut applies to !ARM_SMMU_FEAT_RANGE_INV
cases only, so this function feels convenient to me.

> > +     } else {
> >               /* Get the leaf page size */
> >               tg = __ffs(smmu_domain->domain.pgsize_bitmap);
> > 
> > @@ -2258,6 +2265,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
> >       }
> > 
> >       smmu_domain->pgtbl_ops = pgtbl_ops;
> > +     smmu_domain->max_tlbi_ops = pgtbl_cfg.nents_per_pgtable;
> 
> And now we're carrying *three* copies of the same information around
> everywhere? Honestly, just pull cfg->bits_per_level out of the
> io_pgtable_ops at the point where you need it, like the pagetable code
> itself manages to do perfectly happily. Wrap it in an io-pgtable helper
> if you think that's cleaner.

OK. I overlooked io_pgtable_ops_to_pgtable. Will do that.

Thanks
Nic
