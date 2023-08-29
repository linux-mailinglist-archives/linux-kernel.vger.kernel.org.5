Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387F378CF67
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbjH2WQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjH2WQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:16:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823BD198
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUdOpspd91w2v8LyN8hYN3UWG87OffPX546QXKOWXOaIG93evlOEp0MR/E14ZuO8YDxgD8QQ0/fnSaUoeZgq06orbUNtKHNPTIeG+gx7w4XzLBgRXKm+pjeIC2tZZcrC4BiwS9ISDiOVBBe0Mc2voKJsWXOHCWsJKaNOaikE2kIHW3xzZ+/iiNRhZ9ga+Q/qvdVR/rbz2opVqqu2kMhjiffsZ6YWoGuVza8SKMkUkdnJiifPX9Hu4bmtSTKWFvAluk7FQxMX3V2uRHZt2TEHv2a03+lMyXgomU1n4sNngRhm58Om+onueArDwRbVbGwcl3xfO2SCSHKgF1tiayhsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=attlM3jLNW5mCPh3vHHDT/LcsooG5pWmbrU3bbQqnp0=;
 b=G1I8BoG9C61RgLlJaOSZzEP0WNzNA+2dHBy9KWySArPxplk8vU8rIazjW7TkBT+hcGt4jEJQNTp723Z1o05bWq+JQoFEmZTRDt5XGbanxlXfNWCGmq3bBCtp36EA3RBOotNqzz8p/kmVBvGS0BS6Ul3HYLF0XPavfUXU8EaPji1GjZJI2XeB65ka7R0H06J/zS3VnSJWJT17gV50oeSxffr3iIBnUzBBHggXQtVlsj4U6Jdyn8zU5pseADQYdGC48MXE8A+0LpAUh5wdYr12Knk49KL8OyuBeYCP7pK84q81NFfla0AbwxELMX9gzSctHedZtB7xiS7FfDJ95vaa1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=attlM3jLNW5mCPh3vHHDT/LcsooG5pWmbrU3bbQqnp0=;
 b=fdXcsZNuCZGpCdp0Lupp9JT7sFXeSCH9d+ZjhhBYEwrTDzpvuk6dE7r8zyNcUQcBEcn/ra4t/ffowKPk2ZxdlTPNG0oIO/IBJ0McX2XGhoQ7hfZtZMZNbK33yf0sbbD+XSsdiM0abBRjzNsPqmocBxbApKl47haIDri3sU4YLQ3fIF81MmhP/AfmudOpCodonb2xIGyNFyGzzlAMCZWpe9aQ5NLdyoPiXzHZnR6Ba/Z33ptYby3z6dg27YDqDdt37hSQOfwRN4JJ4L62KGsi56VdZwUfdxNC2dxDwW56m+9dl3hj0bkPdS2+NEhVrlnl/wVUL7R82GxQBMbzQPoWzg==
Received: from DM5PR08CA0029.namprd08.prod.outlook.com (2603:10b6:4:60::18) by
 DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Tue, 29 Aug 2023 22:16:09 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::a7) by DM5PR08CA0029.outlook.office365.com
 (2603:10b6:4:60::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Tue, 29 Aug 2023 22:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 22:16:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 29 Aug 2023
 15:15:55 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 29 Aug
 2023 15:15:54 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 29 Aug 2023 15:15:54 -0700
Date:   Tue, 29 Aug 2023 15:15:52 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in
 struct io_pgtable_cfg
Message-ID: <ZO5uGKzGsaliQ1fF@Asurada-Nvidia>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
 <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a105e1-cd93-4e9b-9862-08dba8dd8c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36Q/nr5+R6QcITBDMjOeHr7NRN1/QYJWcfeVjVsbwi3h8NU7HxkK7/Yw83vtmoTF6doJK1h0LudwUkZocs5odxpsq6x+3XPwfDTA/sbuV/kv85uyMTfyXBX8h1KLSJ14Y114z0ZqF0iBCoGfug413ThGyXdJBBuksCFtg62nrAf8gl1WtlFyEnA8Xa664oDeZnwz59iYtLm/H2PO7FoBv7X++nP22zcoPSy7II2iyCD04aAja16b82IfAnt4RR5vZ8dO/LhQHhjbvSd76DHwH6BXTqZTVC/vktNrhCc1Bf49lOYgx6uVGriDfDPXYVUHBtC9oKLCi8QW8dG+IpkSL3YZRxjcfILV295bnFnvSN/wzwIM1VwJKfRz45y+ysWoyVSclAyziEmwII+yeIRTtsmBPwU8tAHHR/yhX3X1EPNtV3hpby2WzOt37ICDHShRXRF6rZuIpjsm93R/VROG4cCqf3Ct2cC+WP6P3gPIhSZqEqw7Sblp2NWmUlfCUAePg2xaCX2eGv68G+x5oBsTUR7REgCWkyQ2LoOTHcSSE5gQReZvKL0EipGMA2QBCvJI99WJblBpRa4y8BMq06EAsDz0UrkUi8HYvMRV0ovQGtf+uUGJjCzassurjLxrLKcP4wDaBJutpg2FvgatY6NwAQWBtUHVsZS4RYznpYT7zQW38KozrNVPDd2uP0gJiI6HBm+aNAr3kR5MpJmWIMHwqcAAIxr9eO/mzO93AQ8jG7jmVDmMXbQrIHnaWhIo2JS2
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(8936002)(8676002)(4326008)(54906003)(110136005)(316002)(70206006)(70586007)(5660300002)(2906002)(66899024)(336012)(40460700003)(41300700001)(36860700001)(26005)(9686003)(426003)(55016003)(40480700001)(82740400003)(7636003)(33716001)(478600001)(83380400001)(356005)(86362001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 22:16:09.4057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a105e1-cd93-4e9b-9862-08dba8dd8c21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:25:10PM +0100, Robin Murphy wrote:

> > > Bleh, apologies, I always confuse myself trying to remember the fiddly
> > > design of io-pgtable data. However, I think this then ends up proving
> > > the opposite point - the number of pages per table only happens to be a
> > > fixed constant for certain formats like LPAE, but does not necessarily
> > > generalise. For instance for a single v7s config it would be 1024 or 256
> > > or 16 depending on what has actually been unmapped.
> > > 
> > > The mechanism as proposed implicitly assumes LPAE format, so I still
> > > think we're better off making that assumption explicit. And at that
> > > point arm-smmu-v3 can then freely admit it already knows the number is
> > > simply 1/8th of the domain page size.
> > 
> > Hmm, I am not getting that "1/8th" part, would you mind elaborating?
> 
> If we know the format is LPAE, then we already know that nearly all
> pagetable levels are one full page, and the PTEs are 64 bits long. No
> magic data conduit required.

Oh, I see!

> > Also, what we need is actually an arbitrary number for max_tlbi_ops.
> > And I think it could be irrelevant to the page size, i.e. either a
> > 4K pgsize or a 64K pgsize could use the same max_tlbi_ops number,
> > because what eventually impacts the latency is the number of loops
> > of building/issuing commands.
> 
> Although there is perhaps a counter-argument for selective invalidation,
> that if you're using 64K pages to improve TLB hit rates vs. 4K, then you
> have more to lose from overinvalidation, so maybe a single threshold
> isn't so appropriate for both.
> 
> Yes, ultimately it all comes down to picking an arbitrary number, but
> the challenge is that we want to pick a *good* one, and ideally have
> some reasoning behind it. As Will suggested, copying what the mm layer
> does gives us an easy line of reasoning, even if it's just in the form
> of passing the buck. And that's actually quite attractive, since
> otherwise we'd then have to get into the question of what really is the
> latency of building and issuing commands, since that clearly depends on
> how fast the CPU is, and how fast the SMMU is, and how busy the SMMU is,
> and how large the command queue is, and how many other CPUs are also
> contending for the command queue... and very quickly it becomes hard to
> believe that any simple constant can be good for all possible systems.

Yea, I had trouble with deciding the number at the first place, so
the previous solution ended up with an SYSFS node. I do agree that
copying from the mm layer solution gives a strong justification of
picking a arbitrary number. My concern here is about whether it'll
be overly too often or not at triggering a full-as invalidation.

Meanwhile, by re-looking at Will's commit log:
    arm64: tlbi: Set MAX_TLBI_OPS to PTRS_PER_PTE

    In order to reduce the possibility of soft lock-ups, we bound the
    maximum number of TLBI operations performed by a single call to
    flush_tlb_range() to an arbitrary constant of 1024.

    Whilst this does the job of avoiding lock-ups, we can actually be a bit
    smarter by defining this as PTRS_PER_PTE. Due to the structure of our
    page tables, using PTRS_PER_PTE means that an outer loop calling
    flush_tlb_range() for entire table entries will end up performing just a
    single TLBI operation for each entry. As an example, mremap()ing a 1GB
    range mapped using 4k pages now requires only 512 TLBI operations when
    moving the page tables as opposed to 262144 operations (512*512) when
    using the current threshold of 1024.

I found that I am actually not quite getting the calculation at the
end for the comparison between 512 and 262144.

For a 4K pgsize setup, MAX_TLBI_OPS is set to 512, calculated from
4096 / 8. Then, any VA range >= 2MB will trigger a flush_tlb_all().
By setting the threshold to 1024, the 2MB size bumps up to 4MB, i.e.
the condition becomes range >= 4MB.

So, it seems to me that requesting a 1GB invalidation will trigger
a flush_tlb_all() in either case of having a 2MB or a 4MB threshold?

I can get that the 262144 is the number of pages in a 1GB size, so
the number of per-page invalidations will be 262144 operations if
there was no threshold to replace with a full-as invalidation. Yet,
that wasn't the case since we had a 4MB threshold with an arbitrary
1024 for MAX_TLBI_OPS?

> > So, combining your narrative above that nents_per_pgtable isn't so
> > general as we have in the tlbflush for MMU,
> 
> FWIW I meant it doesn't generalise well enough to be a common io-pgtable
> interface; I have no issue with it forming the basis of an
> SMMUv3-specific heuristic when it *is* a relevant concept to all the
> pagetable formats SMMUv3 can possibly support.

OK.

Thanks
Nicolin
