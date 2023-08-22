Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13C9784D23
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjHVXEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjHVXEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:04:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F5CD1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:04:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqnKBq0JKLHdp4AtqnPO82AM6wzAsbnEM1qLJ0462ks0vIAbK9PL8L0R4vhClQd99xbgInyw2SVNLa0yf28YL3pDTfykX3h1aHMpRBb/HKPtkTAQ29k/xgfWcTylhMvKB6ogj0Gi437jTfKXoO0BeKZcbhlQJ4rZtyXRtPBn+LJMvlzAaTJW7yPFic8oCsWc70Lv3cObtxMuUbKBcH9ZX1aIUuhEwMCvjHARJe8j4fReefwf1vBAMX/O7Ing1ppDItXwQQp0hGGKXWnBN52N43OZjq9QRs8xLfJU4xT4ZyYXgzSBA8fv2W7Onws2xxfZnNZGOcXQsYUCK5XVMBshUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdOF5aOZAKLiRq8C4otomAil2kNfEvJ4nm1FMHCTFvI=;
 b=QSkLryAXWfGzW0rZbV+0NF7PcOJli3dfzlplZ7r4bxM5JSjXqWpzIIRXXkqyqKMiH/sgFyQiUgb+85/QDOgh0ETRikgSLeJ4U2mOxlWz2I7ppmJ3s375mWfdtOrJpgKsMFHU7ewlfIFMuLdH4C+AWtOKwmixTbBCA8mlKSTdlq36XC5cbrmK4lVXV90XeMMraBptxv9xFl0cjwyOSAIZoGwr+vRcAoOwYwql2rqxGMeOZwcPRuGBmB16ihQg5TKTQ+1ts5225r98Ela7vTIYGcQReDAzNX+NtjzOECpkbWzdehoBJDi+E4ZoqqeamsE/I7VYnOv1DeQkWtVziun+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdOF5aOZAKLiRq8C4otomAil2kNfEvJ4nm1FMHCTFvI=;
 b=PTNJea1gd0GeywKvUic1dgMRu5OSynY2LyqKPZta0WM1G1TP2yhgzg3sDXEsgNbOWSCB7/Bdc5cTMJcP3V85KJuauVrApyPZN9Z9NBNf6UbFMLdXAhgaNZWZORqalLBee8jj8e3WoX4PYGGYvSAw1lJPPTjPfPsHa4jEWxgdpTns7+gzmOJbDY5PZKZ1J11sj5ahuzi1Xjhb+2wmmZnzcI2blB8kI8JlzcPfMbTzglu8V/EnVJybGWSsLFSc2DNesqXj3h8qU/PUqmp93E5lM496w8/2hIcp8D9yX2wza5mz0FasMtO+TowQt3ST9p/zmn99desC+vwpwtX9hq+9Kw==
Received: from BY5PR17CA0067.namprd17.prod.outlook.com (2603:10b6:a03:167::44)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Tue, 22 Aug
 2023 23:04:17 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::8) by BY5PR17CA0067.outlook.office365.com
 (2603:10b6:a03:167::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 23:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Tue, 22 Aug 2023 23:04:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 22 Aug 2023
 16:04:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 22 Aug 2023 16:04:12 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 22 Aug 2023 16:04:11 -0700
Date:   Tue, 22 Aug 2023 16:04:10 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <jgg@nvidia.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 3/3] iommu/arm-smmu-v3: Add a max_tlbi_ops for
 __arm_smmu_tlb_inv_range()
Message-ID: <ZOU+6hsKy4R099B3@Asurada-Nvidia>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <3ba332e141102d31b756326cdc4078cac1f5ab1c.1692693557.git.nicolinc@nvidia.com>
 <3f630d3d-c59a-f454-14db-2bf9b8e76877@arm.com>
 <ZOTjGIJU8Kfl1Q4f@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZOTjGIJU8Kfl1Q4f@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 8260a554-43f4-4ce8-612e-08dba3641c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4DDC+gl7nbYkeSa9TPMOlhzsp5stcYldbr+UwNm/K27CyubnO+KOuS9EKNcookIK8vv468xtlGvDXyrdaXAhvN/cNKTnaZZfY2fmPv3Eo+RLOkk/C3cvGUlN2Azeb9JE1l8H+Gca6dFLmuIfXFKuAG7P77oW3rOGnbKrr+k3MBv6X90BAygV/nMe77n0+7xaXPjtG/ypIlC7tSp5bSdnWLsdnO9RUpfEE+qnIbyK07jJVXLLPT6KXJ32UibSSQ1J6EsaJp1L2k8ZTfw7VHcCyxOijerEhMGykDoJ+B3E7a1ZMoJBfLFjAh+FAwaYL75EPGvrhckgENh6wzUcTpiYTzCPbqSeZa0vNo/wmu0aQNikfWnQlUMW5CqSVNcREVh/Zt7RCPUKzndKySdyJV0mgoSFdPrRVruc7qxIO8a5OjEFR2NGfIEi75S0vPDPAnJr+tIzpVCS5hdNl1jLMfSSsevXvwpcAgZi/ZU0qoKiD9Ogeh3ThtBjYpRwv1foASk9CvdYo5El0DG6FVl44WZNUvDItv/v9KPSFCCaAXY9QAx3z0uFQ4eK5tozTjLzuN9MdiAdiUQiAJdcrhOqJT8xNSjSuShTQZHJbb3GohJKv88yYeTNifj+iHv9Dvta+ywSxegspnBmh0Xuu/OTLmFchgS4VI2Ri/RsQW5L9NmyNk28gIL/zk7BIbkk32102e1vcKlPOA1LisHFQhmMX1tSpSBRhQEhKUaZLte9YzfJAhcw8u+I3xGvjJ/NnowMkOBbmsz/WOEmzi1dsOK1/l2xA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(336012)(426003)(7636003)(82740400003)(356005)(86362001)(40480700001)(55016003)(47076005)(33716001)(36860700001)(4326008)(8676002)(8936002)(70586007)(70206006)(54906003)(316002)(6916009)(9686003)(41300700001)(5660300002)(26005)(478600001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 23:04:16.9730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8260a554-43f4-4ce8-612e-08dba3641c58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Tue, Aug 22, 2023 at 09:32:26AM -0700, Nicolin Chen wrote:
> On Tue, Aug 22, 2023 at 10:30:35AM +0100, Robin Murphy wrote:
> 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index d6c647e1eb01..3f0db30932bd 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -1897,7 +1897,14 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
> > >       if (!size)
> > >               return;
> > > 
> > > -     if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> > > +     if (!(smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
> > > +             /*
> > > +              * When the size reaches a threshold, replace per-granule TLBI
> > > +              * commands with one single per-asid or per-vmid TLBI command.
> > > +              */
> > > +             if (size >= granule * smmu_domain->max_tlbi_ops)
> > > +                     return arm_smmu_tlb_inv_domain(smmu_domain);
> > 
> > This looks like it's at the wrong level - we should have figured this
> > out before we got as far as low-level command-building. I'd have thought
> > it would be a case of short-circuiting directly from
> > arm_smmu_tlb_inv_range_domain() to arm_smmu_tlb_inv_context().
> 
> OK, I could do that. We would have copies of this same routine
> though. Also, the shortcut applies to !ARM_SMMU_FEAT_RANGE_INV
> cases only, so this function feels convenient to me.

I was trying to say that we would need the same piece in both
arm_smmu_tlb_inv_range_domain() and arm_smmu_tlb_inv_range_asid(),
though the latter one only needs to call arm_smmu_tlb_inv_asid().

Also, arm_smmu_tlb_inv_context() does a full range ATC invalidation
instead of a given range like what arm_smmu_tlb_inv_range_domain()
currently does. So, it might be a bit overkill.

Combining all your comments, we'd have something like this:

-------------------------------------------------------------------
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7614739ea2c1..2967a6634c7c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1937,12 +1937,22 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 					  size_t granule, bool leaf,
 					  struct arm_smmu_domain *smmu_domain)
 {
+	struct io_pgtable_cfg *cfg =
+		&io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops)->cfg;
 	struct arm_smmu_cmdq_ent cmd = {
 		.tlbi = {
 			.leaf	= leaf,
 		},
 	};
 
+	/*
+	 * If the given size is too large that would end up with too many TLBI
+	 * commands in CMDQ, short circuit directly to a full invalidation
+	 */
+	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV) &&
+	    size >= granule * (1UL << cfg->bits_per_level))
+		return arm_smmu_tlb_inv_context(smmu_domain);
+
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
 				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
@@ -1964,6 +1974,8 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
 				 struct arm_smmu_domain *smmu_domain)
 {
+	struct io_pgtable_cfg *cfg =
+		&io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops)->cfg;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
 			  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
@@ -1973,6 +1985,14 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 		},
 	};
 
+	/*
+	 * If the given size is too large that would end up with too many TLBI
+	 * commands in CMDQ, short circuit directly to a full invalidation
+	 */
+	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV) &&
+	    size >= granule * (1UL << cfg->bits_per_level))
+		return arm_smmu_tlb_inv_asid(smmu_domain->smmu, asid);
+
 	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
 }
 
-------------------------------------------------------------------

You're sure that you prefer this, right?

Thanks
Nicolin
