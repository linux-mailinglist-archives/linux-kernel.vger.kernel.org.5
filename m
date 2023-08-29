Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9431C78CFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 01:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbjH2XEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjH2XED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:04:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD036139
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 16:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOeM9ZC80MipnftHhMj5sJucYdS7rE0bGUPQS6UmCI63i/AXklcIjUVbVKoI+4awwOqLYZZegPNJx9SNSfdecW1rDsQvg+JGxIPBKMdx793EggqlvhScCkL156Bh5px6cq1NOVhqOmgcMx0EJ2ayDm9nnrvCx5u52aXqF53wnqhQ/RMTZvWUeqRdMxCRWNv+wznPgZSX+z5npcd6T4SsOOKi+9Fir1y9hUbRAXeOBJ2Dto3QtWjV5Xyy/AOQJZrrBnqDqwwnbou3xgTUMHYVOAkMWppR2r7mZQFQZB4dlELmjNH5gBPxiSBaM0EwSPCHOwkYjtCWfdU6llcdn8R2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr43ZS1dym+rYgHfwmSxyBQZ0BGWV5W6ETkq0KHaEFY=;
 b=J3BxmfiNpXr+s8oj35pqQOYgt2u+2rZ6T1kENmbW+7Hp7itmApxWltgUHCyjxKG2EH6XWCVp/cNnIQQvNjq6WnGFmQtreNfbxyd/g2jkS4OJR6I5dFcJ6ae16VdUPHr3wBKikgGf2mMCf0vkdniItF0EhTysVIxMn+kFznxONTk8xQOtx8u0FRNOjqxpqzvPCke7x57Qvc5Z+zZQ5f3oJX2v0AGkf+NdQoO1x/ZUcgNPSiKpcxdr5gqHl9KqmDDwcFxUboU2Ib3VMcALW3RWhOJOgLG/q3r/hCZziozG+q0jccO+H5tUcT+xneNj4KfTaiPfS7mh5AFCyu+RqdQbog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rr43ZS1dym+rYgHfwmSxyBQZ0BGWV5W6ETkq0KHaEFY=;
 b=gCtzlSqcYdZFSG159uIUkverq0W37iLWnaO0y2NUcTUvhCscxEdf8IqixrEOIHrVGAlUyWDtDZtfqS4kScVXthYeQ6iaY2qsjXq9QLkXGajF4r8sSoqK/FXk2a83+40zbBdg+zvIBaiMHPB6QOlEjof+muMO8cT/aUTum6txdrIQy8h5cdHdKI4eFd2CncHpBV7goxo0VOW0qc2C8c3RF7vYG60FYEdZJJUKCnOTx0T3WV8BQbFNRCDu5wAfJW5hZPC40LAkWZ60cZjyJm/7bgqUa5gAfJqvVsR0h7j7MSEg5WZbSciu24ORFfk8nyp7WTzfX63HlSfLBbxVyZj3uA==
Received: from BYAPR06CA0038.namprd06.prod.outlook.com (2603:10b6:a03:14b::15)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Tue, 29 Aug
 2023 23:03:55 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:14b:cafe::fa) by BYAPR06CA0038.outlook.office365.com
 (2603:10b6:a03:14b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Tue, 29 Aug 2023 23:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 23:03:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 29 Aug 2023
 16:03:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 29 Aug
 2023 16:03:45 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 29 Aug 2023 16:03:44 -0700
Date:   Tue, 29 Aug 2023 16:03:43 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <jgg@nvidia.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 2/3] iommu/arm-smmu-v3: Add an arm_smmu_tlb_inv_domain
 helper
Message-ID: <ZO55Tw4aTlMyaYO+@Asurada-Nvidia>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <854e2b3f2d4f1b76f916fcfc288b34526d4d4162.1692693557.git.nicolinc@nvidia.com>
 <7e97b5a5-6be0-87a8-aaf7-89980b0a35d1@arm.com>
 <ZOTqXmzs/wqgI1s6@Asurada-Nvidia>
 <d1bf37be-6ce5-a446-2f5b-db94fa6a0776@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d1bf37be-6ce5-a446-2f5b-db94fa6a0776@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf588a1-7a3b-4900-0629-08dba8e437bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npTZ3STHo3p5xrwaVf9Y7rhYvxTPxWIrs3d/xztWimCZCoi4NzzYFlcGzThszUBoYPjVtMKl7QjLOXN/xjNTL2xiGf6YYWGZJcspwsF9B07B7I0YXW9J+5lGYZYUuQpId+OWxlFxyhP78sAoDYAMsuqRqZsTkgDnDAfR6JTZorLs41fLXCpgZWOtHjInT9EhZGGgC32avcRvvGUDlZZIiY2fCR5xwDg7rm981ELsbR72c4z+hARPHP/I7MjgVOdqxQFMP7kWZ4Nd4n2KGdVGwzPxBiTIMpdNGN9RC0Hq3cxTG4ksoFA4rKPkY9Mc3Mcqkf/WK6Q5PAv6DC6IzdQy5D1l/QF5S+tQvEUIcaIPPv7fxhHE/6foTeiG10o9uEhG5P5ZKbkfV3oW7WcNOKKoYE82jdhZvbpvjGNCQqHxKSnEKN65aNt9piWwD6pww8PkFn1K+2Sx2Fk015/fIAJym0h4MvoB4yvONYETQUkInOgC3wV/vyb/m8AYr86WeJpb0q3utX1/mdPMxEAPSOYWeyzVSZihrmUElIUcKuKIoDHDglMfkFOfdvQUuODrdhQw5wNBbnEiUWsMFy8IK9i2sZc93jvDPBRIH/TSYQ9qHGYsvwxytNvNwp6rIrToZL4UbteDvGkSb1cxiTgtJa96C2y1yOJxRu8N2Nf6DL5MIRUY/p4rp412+Js3MYUq5Bm3dvMsD+C1pYJlw3vzx5iqHMewjH4m5Y6lN1BdkNJDR6UF+Ju6uiEqeL1mjLRfTfXE
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(36840700001)(46966006)(40460700003)(9686003)(316002)(41300700001)(6916009)(66899024)(4326008)(426003)(336012)(83380400001)(2906002)(47076005)(86362001)(33716001)(55016003)(26005)(5660300002)(8676002)(40480700001)(36860700001)(8936002)(7636003)(82740400003)(356005)(54906003)(70206006)(53546011)(70586007)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 23:03:54.3133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf588a1-7a3b-4900-0629-08dba8e437bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:54:00PM +0100, Robin Murphy wrote:
> On 2023-08-22 18:03, Nicolin Chen wrote:
> > On Tue, Aug 22, 2023 at 10:40:18AM +0100, Robin Murphy wrote:
> > 
> > > On 2023-08-22 09:45, Nicolin Chen wrote:
> > > > Move the part of per-asid or per-vmid invalidation command issuing into a
> > > > new helper function, which will be used in the following change.
> > > 
> > > Why? This achieves nothing except make the code harder to follow and
> > > disconnect the rather important comment even further from the code it is
> > 
> > We need the same if-else routine to issue a per-asid or per-vmid
> > TLBI command. If making a copy of this same routine feels better
> > to you, yea, I can change that.
> > 
> > > significant to. It's not like we need a specific prototype to take a
> > > function pointer from, it's just another internal call - see
> > > arm_smmu_flush_iotlb_all() for instance. We know the cookie is an
> > > arm_smmu_domain pointer because we put it there, and converting it back
> > > from a void pointer is exactly the same *at* the function call boundary
> > > as immediately afterwards.
> > 
> > Hmm, I am not quite following this. What do you suggest here?
> 
> Oh, this is becoming quite the lesson in not reviewing patches in a hurry :(
> 
> Apparently I managed to misread the diff and the horribly subtle
> difference between "arm_smmu_tlb_inv_domain" and
> "arm_smmu_atc_inv_domain", and think that arm_smmu_tlb_inv_context() was
> already just dealing with the TLBI command and you were moving the
> entire body into the new helper. Sorry about that.
> 
> Still, the part about the comment remains true, and I think it goes to
> show what a thoroughly horrible naming scheme it is to have "tlb_inv"
> denote a function responsible for TLBI commands and "atc_inv" denote a
> function responsible for ATC commands and "tlb_inv" denote a function
> responsible for both TLBI and ATC commands...

Well, "atc_inv" is quite clear I think. But the"tlb_inv" might
not be, as you pointed out.

So, we have:
 tlb_inv_range_asid: tlbi only (NH_VA/EL2_VA) // used by SVA too
 tlb_inv_range_domain:
 	if (S1)
		tlb_inv_range_asid();	// NH_VA/EL2_VA
	else
		tlbi only (S2_IPA);
	atc();
 tlb_inv_asid: tlbi (NH_ASID)	// only used by tlb_inv_context()
 tlb_inv_context:
 	if (S1)
		tlb_inv_asid();	// NH_ASID
	else
		tlbi only (S2_VMALL);
	atc();

Then, what this patch wants another non-atc:
 tlb_inv_asid: tlbi (NH_ASID)	// only used by tlb_inv_domain()
 tlb_inv_domain: 		// new
 	if (S1)
		tlb_inv_asid();	// NH_ASID
	else
		tlbi only (S2_VMALL);
 tlb_inv_context:
 	tlb_inv_domain();
	atc();

The problem of this is that it conflicts with the naming used in
other tlb_inv_range_domain() that does an atc().

Perhaps, we could rename to the following patterns?
 tlb_inv_range_asid:	// used by SVA too
 tlb_inv_range_domain:
 	if (S1)
		return tlb_inv_range_asid();
	else
		tlbi only (S2_IPA)
 tlb_inv_range_domain_with_atc:
 	tlb_inv_range_domain();
	atc();

 # remove tlb_inv_asid() since it doesn't help much
 tlb_inv_domain:
 	if (S1)
		tlbi only (NH_ASID)
	else
		tlbi only (S2_VMALL)
 tlb_inv_domain_with_atc:
 	tlb_inv_domain();
	atc();

 tlb_inv_context:
 	struct arm_smmu_domain *smmu_domain =
		(struct arm_smmu_domain *cookie);
	tlb_inv_domain_with_atc(smmu_domain);

Thanks
Nicolin
