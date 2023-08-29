Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9416978D022
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 01:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbjH2XPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjH2XPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:15:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE44FFD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 16:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJ4w531SD+9BSE17JlzHpOOVNbOcuGhd4XL1dn9BA7oj+qUaJTMa78eZ+phjdLan/qjiFHuvS8cy3ts/Kf7/P1aSjTj1ZWdVqqrHh2EUhHKv/T6UGHeZ3o847uUX1ta9xh6GrKc81kBltdZK8OdLSsmSscsjWjvVejandKRbHyMEx+aUiROoHbFmrehnW6q+eDnwN4qelTQs8aD5wiZdpd92rH9yQ7KSIgvs3hvVZT65eyhCy1rjgizqK4xAIQaeonfPKZxaagNFwwJYagXF0lof99dRkVRBOjJAeMN5w9asxOUsmFsExLiJZYd5s/3vOeOPxLwevcsO3WxtTtXmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emey6KvzuQa3i/UogGJRMtonYBo+Rh0SFk0wHI7Iq+U=;
 b=EA+t1+nModC5dDoXIcZ1QNw4YAT+pVK838UhSW06AkSVMD/b357S+Kv2ibIaGhT32z1At9vQ6rYneix9s4N/Cng6CpSEBK6s7SR1VqRYm/sI++bEs+51IjeUdQbaf5E5hwmMh5VSMPgpbOC6cKA68WgQjs+wYxaIRtwBPPkrmtV/FmP6F0osKZU7J4GyMEPB5vYUY3IBveVrNkNgMs/fznDWpWFma1XNYKf4Uzb1TK1e7seHtZl+F5jzX9lJqOe5wWqtANJBwsgMRsQes9/roAI7iYiSysDYr1efiR111WJ1Ddvalf5RyASljbLZg5UYxTXbDzqb1x1WeM7AJsFZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emey6KvzuQa3i/UogGJRMtonYBo+Rh0SFk0wHI7Iq+U=;
 b=bwNJei1oJZop0vNHAvld1D5mRpqGgEXQzmcUKqEIxuzn2jucT3VEKKLuf7iE1NsLqx39SVN/nA8OEz/oFqlc+MZJCHnCN1lwwDmp2IBbpd79di9ZPUgoZyw6oZhoI2bqilwqiw6vcjvC62H8VATw2azhO5ndvX8tTQcE6EbE9HBnq6tuFf7otWWKLbC0aRr+QuFXNYRo6ziIV1Qsfl8uapCZlFM2fNnUXyWHe7iDK7xu2CqbHRTFFYTrVVAs0rrJb6anfDwPxU7XUUGPzPmSvKjaUB4YD6MLcyEkLiGO7sEiT3JmPNOxkjP1sgLgqgczvdeXB3OwkxZ1jE5MtRb1nw==
Received: from DM6PR21CA0020.namprd21.prod.outlook.com (2603:10b6:5:174::30)
 by CH3PR12MB8910.namprd12.prod.outlook.com (2603:10b6:610:179::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 23:15:01 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::45) by DM6PR21CA0020.outlook.office365.com
 (2603:10b6:5:174::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.8 via Frontend
 Transport; Tue, 29 Aug 2023 23:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 23:15:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 29 Aug 2023
 16:14:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 29 Aug
 2023 16:14:50 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 29 Aug 2023 16:14:49 -0700
Date:   Tue, 29 Aug 2023 16:14:47 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <jgg@nvidia.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 3/3] iommu/arm-smmu-v3: Add a max_tlbi_ops for
 __arm_smmu_tlb_inv_range()
Message-ID: <ZO5755PjMx8mofa3@Asurada-Nvidia>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <3ba332e141102d31b756326cdc4078cac1f5ab1c.1692693557.git.nicolinc@nvidia.com>
 <3f630d3d-c59a-f454-14db-2bf9b8e76877@arm.com>
 <ZOTjGIJU8Kfl1Q4f@Asurada-Nvidia>
 <ZOU+6hsKy4R099B3@Asurada-Nvidia>
 <dc99bc7b-b6bc-1b82-3d8e-8e385596070b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dc99bc7b-b6bc-1b82-3d8e-8e385596070b@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CH3PR12MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea613e9-998b-4545-92dc-08dba8e5c541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOrke6bDZt7v06acsWjxfr3jxz9YmRxnNpGOnvnO6RLopoOdmHvq3a91vHb5O9ER4783lWfaVeKpgEAlntCnRuhC/0wBcTOyCkWjH8P2Cv91AzWegsqQn96gLkndcuUVp8xK6IthDCdwXxvQf69W6o0rqoFunR94zh5Qt60UYOk+nw1xcb5B/4TUkHYb3019tTPecUTjMlXzTs+XO0i42OUl9LbD5wGG9pBcfQfDNElwC9TpFMaJx2mR+DPfEvKCWhc5BsXwrtqBouEmpvmB9AnSaLfxQNT8OIvXq4gHLTIk3yqVJZN6ZZgDUeWvb0p5jbUr3AAtj895EgNU+Vz+F+WEU0QKQ/+8cNlpso29HzdW6iDtBpDrrRe/1HW4JM7PdMR5OssNAyaxKiPWxALpj4M/uJcWmU7MUa9kDGRFEp94pyGSkLh0Men8Su9XDH0Gyw5z2sOsuWC3IjZC+u0C+LppjR2bAIWHfUv5VimKDvtOd6sFjdJApFZjO4UCgjC5wLU4ayZ17EASw9bl7uy37pIv2pG93WSR0j1pI3QY/JQn5VAgv5i2VgSiV8UDdLzMmPBs/fYcu0pUd/4hwlVV/qwhzFkyZfC25yl3vvFrA350LqvwrdZg042wiNLlwNn6EGLWbXwkzgWckIlwYjYCgJk/kY3iTkb6bkJhA+B2qNxO/sOMLzUBP2QkdPfh2HTrN+lMNw7ii21XhvA/AFVm5sg9q8F2xYwrG1N/O/p4EZRNnRt/Z1dGi2FEEKHMHvpB
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(356005)(82740400003)(7636003)(8936002)(70206006)(70586007)(478600001)(54906003)(316002)(41300700001)(426003)(9686003)(40460700003)(5660300002)(8676002)(26005)(33716001)(2906002)(6916009)(86362001)(47076005)(40480700001)(55016003)(36860700001)(336012)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 23:15:01.2505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea613e9-998b-4545-92dc-08dba8e5c541
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8910
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 11:40:29PM +0100, Robin Murphy wrote:

> > > > > -     if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> > > > > +     if (!(smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
> > > > > +             /*
> > > > > +              * When the size reaches a threshold, replace per-granule TLBI
> > > > > +              * commands with one single per-asid or per-vmid TLBI command.
> > > > > +              */
> > > > > +             if (size >= granule * smmu_domain->max_tlbi_ops)
> > > > > +                     return arm_smmu_tlb_inv_domain(smmu_domain);
> > > > 
> > > > This looks like it's at the wrong level - we should have figured this
> > > > out before we got as far as low-level command-building. I'd have thought
> > > > it would be a case of short-circuiting directly from
> > > > arm_smmu_tlb_inv_range_domain() to arm_smmu_tlb_inv_context().
> > > 
> > > OK, I could do that. We would have copies of this same routine
> > > though. Also, the shortcut applies to !ARM_SMMU_FEAT_RANGE_INV
> > > cases only, so this function feels convenient to me.
> > 
> > I was trying to say that we would need the same piece in both
> > arm_smmu_tlb_inv_range_domain() and arm_smmu_tlb_inv_range_asid(),
> > though the latter one only needs to call arm_smmu_tlb_inv_asid().
> 
> Its not like arm_smmu_tlb_inv_range_asid() doesn't already massively
> overlap with arm_smmu_tlb_inv_range_domain() anyway, so a little further
> duplication hardly seems like it would hurt. Checking
> ARM_SMMU_FEAT_RANGE_INV should be cheap (otherwise we'd really want to
> split __arm_smmu_tlb_inv_range() into separate RIL vs. non-RIL versions
> to avoid having it in the loop), and it makes the intent clear. What I
> just really don't like is a flow where we construct a specific command,
> then call the low-level function to issue it, only that function then
> actually jumps back out into another high-level function which
> constructs a *different* command. This code is already a maze of twisty
> little passages...

OK. That sounds convincing to me. We can do at the higher level.

> > Also, arm_smmu_tlb_inv_context() does a full range ATC invalidation
> > instead of a given range like what arm_smmu_tlb_inv_range_domain()
> > currently does. So, it might be a bit overkill.
> > 
> > Combining all your comments, we'd have something like this:
> 
> TBH I'd be inclined to refactor a bit harder, maybe break out some
> VMID-based helpers for orthogonality, and aim for a flow like:
> 
>        if (over threshold)
>                tlb_inv_domain()
>        else if (stage 1)
>                tlb_inv_range_asid()
>        else
>                tlb_inv_range_vmid()
>        atc_inv_range()
> 
> or possibly if you prefer:
> 
>        if (stage 1) {
>                if (over threshold)
>                        tlb_inv_asid()
>                else
>                        tlb_inv_range_asid()
>        } else {
>                if (over threshold)
>                        tlb_inv_vmid()
>                else
>                        tlb_inv_range_vmid()
>        }
>        atc_inv_range()
> 
> where the latter maybe trades more verbosity for less duplication
> overall - I'd probably have to try both to see which looks nicer in the
> end. And obviously if there's any chance of inventing a clear and
> consistent naming scheme in the process, that would be lovely.

Oh, I just replied you in another email, asking for a refactor,
though that didn't include the over-threshold part yet.

Anyway, I think I got your point now and will bear in mind that
we want something clean overall with less duplication among the
"inv" functions.

Let me try some rewriting. And we can see how it looks after.

Thanks
Nicolin
