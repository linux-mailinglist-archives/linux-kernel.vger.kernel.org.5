Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972BC752E79
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjGNBOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjGNBOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:14:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA12C2D5D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 18:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wq1L2EPNRbWHjMNw7xuoPs3KR1Syen48ITpmdGrMU5KhCFtwK3yS92vm3EQhUkAtk/LCgTCpPw4yai0pib4SOqfLJvgjzTF+SznLN53dOGy6tXd6PZlxNslqjHz7dY8TjLMRWcT4ty3duld1s98o/DmTlsA3VfX3hyheG74otDnbn+3p1MEXUK2NO3oa5P/AqV8ljT+eG2FjMWjtgWT0FDyJStOTPxl8xHKWDv5KB5X3+isEGTthlKDfUhhmQyYD+QrsNyHFk7MSnGtVgpc1FN3uwcliiKDKfPkF0oLJ7/KbU7ZqeGclE63Tjc+wkYvnvIuM9xi/HdFUvRKNiWfPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3srNnLNk0dXD8RZ9+KBUjJqTFaUUeDM55+yUk604/+s=;
 b=SVJIs7EUeSt1NGgRKxV4oxcPe8yxvFAvzLxPx2NEF4uw5Q4EECgfxo8G+yLHCRKcbe7IrnPIqN76A8o8OSR6FUswvQGPiInGkTsolOXr3OHLuRwgiKdjZR+8GrD+W2NZv83yQqyc1SXEma7l/EmLrnOgGmCa0R0pqu93+AcZBwTymyDo+6+nxOat9JQlSLIJzNroMmO4lWaAEk61riFrU6qG7QpqwbyH0WHeHktvyi4t2PicZF5W/W8CHx74ExYUMHEM7OC7IldiqHqK0Wt/XXcqRn8k/DpZ8GtcipNebfwJyt/hwkoOGopzpO1uZowFaGVXuWwpHNJEKd+zF6KElg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3srNnLNk0dXD8RZ9+KBUjJqTFaUUeDM55+yUk604/+s=;
 b=D32vdqjlRTlQY1YWKEFz9cHKclQH3JwQLGpkDDeep+gBdPEIOgZp7yAgjKvV6APqCpVN+wECKekFULpEKXVDeZr0Gqy6njZZ0YzRbYhKh4zM7gfBEVoLL2Lj/vcDaPD0UFcgugDrTVxiqJy0RLMGHHhDgVRCuvA4V9yIcSt0nqqm9p6dVw7S5QznNog+Znc0NcAIonVzbFq48b83Nvgvt44NAbgrv1Ynhsj4IBcglewrnTVJMkUIZG2/NvM1EH8R42I8OosIxA+f4CjZEninHZxfukYP4C9Sc1ntCM2R93ajb9TeSqXpIu2XcDrCy358MKE4/fF3WTTpavFCIapR9w==
Received: from DS7PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:3b8::34)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 01:14:31 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::62) by DS7PR03CA0029.outlook.office365.com
 (2603:10b6:5:3b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Fri, 14 Jul 2023 01:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27 via Frontend Transport; Fri, 14 Jul 2023 01:14:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 18:14:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 13 Jul 2023 18:14:28 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 13 Jul 2023 18:14:28 -0700
Date:   Thu, 13 Jul 2023 18:14:27 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to
 smmu_master
Message-ID: <ZLChc4A58PkU2Fe5@Asurada-Nvidia>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia>
 <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com>
 <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com>
 <ZLBWh370pPjx2B+z@Asurada-Nvidia>
 <ZLCNUNRsWy/YuHhQ@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZLCNUNRsWy/YuHhQ@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c28f3a1-98fa-4e9a-0462-08db8407ad87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2/3VnkTt+KuVkV70lCxCjOKLcCqG1NjHghjOcX37I45P0i7EcRiRlr8r+nTy/s8CH1JxG9fQ5YqUcVTvBdE37TIk9JIMlj32Zu8vu7PNGzb98S/xqMW8DOF6nGb8Gi1WpZ4+CQ8O54CpPL97DEoIzH7uiQG3hsnqJVRZ+QJfEID/nl8Zkl5HRDhEIySpLODWIEUb7ZmUejJkwWq249xRm9qpJidWBDabSTF7bSXefoOHFvPjYvMZIzlW/SHYnSoW6NZtswNOeTSUz7Uj0rjEtvIUfr6H1jzms4v8+yI4RX+pfIV4LuJnNEeiTVb223Ro32LYAa2F4tSjgYgPbSfP3viKyYKkUFalmnunA+93XPmVCscut6k43JEqa40bMC+1Okd4jNovgvwPaAFho3XzScPT7Z21Xf0EVs05typzVytQ0gyHl4FX+I8rNDr5+9VfBm1+W1ZZ/9iTkV+vBD3nmI87hyelwXf4WQCgm/8wSUWUm1ohzvtYalNS63OFSQFUHzF2y8ADtJwFBuNzmAsNpeCz7b5O1CKpPohDDXmWu4HTk+KH7aVrY3Nw9LeIhZXQT8XRys8ceQ2zKRWpB8bAzduCvILe7hgNgK1o/4X0bEoN3KH4JSvkHCO5Blrl/poDLKjXko9oXu24Eh9csZYniusraxj/O3/aByB5Gm4xnuI3DsJuJKyBQHKnJWVxFnqDThvOynWWrUew5w7/gCorfaoOfd2j4pyW64py3gdkksy98lPx4PO4x9J5ipvuodR
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(36860700001)(83380400001)(47076005)(186003)(336012)(426003)(33716001)(82310400005)(7636003)(86362001)(356005)(82740400003)(26005)(9686003)(40480700001)(55016003)(70586007)(70206006)(6636002)(4326008)(54906003)(110136005)(41300700001)(5660300002)(316002)(8676002)(8936002)(2906002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 01:14:31.2595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c28f3a1-98fa-4e9a-0462-08db8407ad87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 08:48:32PM -0300, Jason Gunthorpe wrote:
 
> > For struct arm_smmu_domain, it still has a union of a CD (for an
> > S1 domain) or an s2_cfg (for an S2 domain). Or we could select
> > a better naming for s2_cfg too, since s1_cfg is gone.
> 
> By spec it should be called CD and STE value, but frankly I like CDTE
> and STE a little better (context descriptor table entry) as it evokes
> a sense of similarity. I don't care for the words 's1_cfg' and
> 's2_cfg' to represent the CD and STE, that is pretty confusing now
> that we have more uses for the CD and STE's than simple s1/s2 IO page
> tables.

We have STE and PTE, so CDTE sounds legit to me, though probably
it'd be safer by just following the spec? We can always add kdoc
and comments to make things clear.

@Michael,
Would it be possible for you to update a v5, following Jason's
suggestion overall? And I think we can have a smaller refactor
series first without set_dev_pasid, to have a common codeline
sooner for us to add new features, such as set_dev_pasid, the
use case of IDENTITY default substream, and the nesting series.
I will help testing with some pasid/non-pasid use cases too.

> > Yet two cases that would waste the preallocated CD table:
> > 1) If a master with ssid_bits=0 gets attached to an IDENITY S1
> >    domain, it sets CONFIG=BYPASS in the STE, which wastes the
> >    single-entry CD table, unlike currently the driver bypassing
> >    the allocation of a CD table at all.
> > 2) When enabling nested translation, we should replace all the
> >    S1 fields in the STE with guest/user values. So, the kernel-
> >    level CD table (either single-entry or multi-entry) in the
> >    master struct will not be used. Although this seems to be
> >    unchanged since currently the driver wastes this too in the
> >    default domain?
> 
> As we discussed in another thread dynamic resizing of the CD table
> makes some sense. Eg keep it at one entry until PASID mode is enabled
> then resize it to the max PASID bits.

I see.

> But I view that as an improvement beyond here. It seems fine for now
> to pre allocate the full CD table and waste the memory. PASID capable
> devices are rare.

Yea, that'd be easier for us to move forward other features :)

> > With that, I still feel it clear and flexible. And I can simply
> > add my use case of attaching an IDENITY domain to the default
> > substream when having a multi-entry CD table.
> 
> Yes, with the above note about dynamically resizing the CD table, I
> think we generally have the idea that programming the CD, eg by
> installing an entry, can cause the CD tables's STE to (atomically)
> change.
> 
> Eg to toggle the S1DSS bit if the PASID 0 is IDENTITY, or to resize
> the table if we exceed the PASID space.

Yea, we have enable_pasid() so probably can resize over there.

> Longer term we'd also need a way to setup IDENTITY domains for !0
> substreams as well too (eg for SIOV). It is too bad the CDTE doesn't
> have a bit for bypass. I suppose it will need dummy 1:1 IO page tables
> or something.

Oh. I haven't thought about that far. Noted it down.

Thanks
Nicolin
