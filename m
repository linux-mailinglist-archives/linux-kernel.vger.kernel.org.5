Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D702770800
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjHDSeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjHDSeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:34:18 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E8B5FE6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHT6tpHiNw29Zhk++R1Qe91hsvzwKnqH5/niOCn4vngjxxpi8B3uzCQupMFYsHXHeGUnNvpk9c6RBNs1hWyOM5jOi4W8qrVtu5I3yu0VAoRCojO7MN50dScH0G5LaMpTs9d9v/p03RyWeM3baUfBmwuEhXt+S2cUsC7gYDRE495LS2XcmagAg/ebEGRggbEtoC/2pIQmGamiwO9cqWo+8WF5Gylaa0ktuEK6OjDr20La/XzS9oiif2taIKz4XsKR/6Ut2WuyBrcFHYtofPbfgQK8Uo6vwV822OeaAb721VcoPXzT85LnOJm13lMT7tCVMdoSveOTFZr+bG0/ESPV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lN2gVAAitNLid+tUDFM6CbEMVBrOiU9JODJztQJBP8=;
 b=hZpwujuK82rvIImVb0p2wlTq80gRSYAizjO5Z5t6W3KP56qpePr+8IAvGdvBvR5t5foYvd0f4QrXaRcSI7Me5gUXE6/9TZGwKrpqewztwazFT5ldlHFKaSfEZsh9QPgO0RftN/DOSdzj7yiWkrCzSc1tt5Ms3FbPlkJ1sDaZn/1ZVvMfoYWS24l5bE5uoWoxjW/uLH6m4yqHpQnFrZi9sjK+tTYuFTCUjy+F7nyQp4ox9f24aqYC24RKOuRPtHBIrXg982qHAwj4sfOi4/pgaqIzdvwdjq7l0ThYfOaUyqXF2TKepUYnnu+cb0KgWd9yoADJlrq0U/Rf+XU46POUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lN2gVAAitNLid+tUDFM6CbEMVBrOiU9JODJztQJBP8=;
 b=XUe/TCKuZ2pAe52LCudQetEAMQmaNFfXGc2b8OYDxDWlltglb1gzK557asCi4qlBTxQpjacKAuVv+n1kx0Uzeikg/2YImd1zxA7o0/WKApiuQrOalynik48tV4ZV8Pu1yVm3JPno3XkersNMHMV4f3hQPAQj4Em9TSUATqXR8npVeNLspfXfQ3kqSzfJXeVe1U6cwtTKOjiIAxkvIM3kgoubh4BKxXKR8bdtsGhsDG+2MzXzwTI3Yhz3Q3/WjOFd/kMFhVl0qGSRGRGfl0lUR4x2i+VB7qdJeJVmdaO8pEo6nyTk8wKK2GyBPSRBPGgNCLn5Z+Xcoc77me0LD31lYQ==
Received: from DS7PR03CA0252.namprd03.prod.outlook.com (2603:10b6:5:3b3::17)
 by DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 18:30:14 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::21) by DS7PR03CA0252.outlook.office365.com
 (2603:10b6:5:3b3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 18:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Fri, 4 Aug 2023 18:30:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 4 Aug 2023
 11:30:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 4 Aug 2023 11:30:05 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 4 Aug 2023 11:30:04 -0700
Date:   Fri, 4 Aug 2023 11:30:03 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Will Deacon <will@kernel.org>
CC:     zhurui <zhurui3@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tomas Krcka <krckatom@amazon.de>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu-v3: Fix error case of range command
Message-ID: <ZM1DqxXcBT2SOs8/@Asurada-Nvidia>
References: <1690784482-30028-1-git-send-email-wangwudi@hisilicon.com>
 <20230801085504.GA26130@willie-the-truck>
 <27c895b8-1fb0-be88-8bc3-878d754684c8@huawei.com>
 <d5fc1f72-7428-4fef-d868-d06b85add635@huawei.com>
 <20230804165225.GF30679@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230804165225.GF30679@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DM4PR12MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: ab992c6f-8519-4c45-d2c1-08db9518d874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WksydmJe8cgXkzjpDIeFTcp91tfhviCY/P2wofT9rRvR7jUXE2Rw2EN+Fe/5thNzAP3pYm3numK45QHtnk2hcE2+B54L+oyFUmdE+J8p2kkNpTlh0xesPFNXLOH5dNEm9j/UzLP0doAFNnKBzf50ylKWp0zEOUGYaIHfI26XGaowO5oh5H1mdAAMJq/njTMMCa/jTPd0KxxctdvTgQEleJ8ajMmT/7aa551CQFJ2IaD+0hORw6PsbKO0PeZBOtO/OxFStZ1fjFTSEbL70e9k/r8QLlODr4OwYc6R83U/ZVh65H3tBy7xpwTGEXXW/CDqASmCYYQaEC1ntv8v0w0aBClAfQh+mLjIe9Ek48mQmbMWcNVOWVWOi1pY5f1mmAARUYTUmOMbHMDgojrlzLm5PR7hfvF06wTfPekd8VC0Te6H7NoK0EUgWq+reIu7fn19vBLFYfx2ou9e/CDI0PbB4uQDhtJ+NvEqRPkWEIVH0Ih5I3ZOlnJm3lXl19y2yqGwWrV+dMT39RazflVdrrgtA5UiBoqscDPWMY/qq7Nl9Qg8/FT+tFRhpkBr/QcORmPKzNzwwBAweiZ+xOTtp6wqyaaMQuVC8f7BpPl7l3QyfJsKKLQAQAKxUMxfXx31OcH5Uc9hjJ8XARvraewI/gPxsprUUxJIzJyjY5tIJqaQDmjcWlay6AcoSMiGHU0sHruFhN1F2wZ7SdzZZis59GOVNEC8CtooQ/qpABPrrw8el/t06rWO1NSkagxyz8qnI+iO
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(186006)(1800799003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(54906003)(41300700001)(478600001)(7416002)(5660300002)(8936002)(8676002)(336012)(4326008)(6916009)(9686003)(316002)(26005)(70586007)(70206006)(40460700003)(426003)(2906002)(83380400001)(55016003)(47076005)(36860700001)(40480700001)(356005)(82740400003)(7636003)(33716001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 18:30:14.5408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab992c6f-8519-4c45-d2c1-08db9518d874
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:52:25PM +0100, Will Deacon wrote:
> On Fri, Aug 04, 2023 at 05:31:20PM +0800, zhurui wrote:
> > When tg != 0 but ttl, scale, num all 0 in a range tlbi command, it
> > is reserved and will cause the CERROR_ILL error. This case means
> > that the size to be invalidated is only one page size, and the
> > range invalidation is meaningless here. So we set tg to 0 in this
> > case to do an non-range invalidation instead.

> > @@ -1930,6 +1927,12 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
> >                         num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
> >                         cmd->tlbi.num = num - 1;
> >
> > +                       /* Prevent error caused by one page tlbi with leaf 0 */
> > +                       if (scale == 0 && num == 1 && cmd->tlbi.leaf == 0)
> > +                               cmd->tlbi.tg = 0;
> 
> This should only be true for the last iteration, right (i.e. when num_pages
> == 1)? In which case, I'd prefer to leave the old code as-is and just add:
> 
>         /* Single-page leaf invalidation requires a TG field of 0 */
>         if (num_pages == 1 && !cmd->tlbi.leaf)
>                 cmd->tlbi.tg = 0;

Is "!cmd->tlbi.leaf" to be "leaf" or "non-leaf"?

IIUIC, this "num_pages == 1" implies "NUM == 0, SCALE == 0" while
the "!cmd->tlbi.leaf" implies "TTL = 0b00", which in combination
would result in a CERROR_ILL mentioned by the spec?

I feel this could be more clear by just checking the three fields
following the spec...

Thanks
Nicolin
