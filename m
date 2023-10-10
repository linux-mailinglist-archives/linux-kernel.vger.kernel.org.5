Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E1F7BFFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjJJPFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjJJPFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:05:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA27397
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haCmri6TbCBW5vhn7Gs1av8rCbd2iHotQvLL9Cu9gu5rqIGmRN77Bn7NaqC9mIkoruXHozvsEDBsll6FWjdYVeuhvMMumVFrxTbsQMs6roRhrEB38n49h7DMcwVcZ3mG3G5W//CuFJt+/xowJ0UCMUG0RV6O+4jzUSdloB0XDl2K01qFNRqUNZW8Pt4EIJ3NsBcqlIhb36lS3UN2BMJBRwcNQLaWkORjiNstpgNmuhJq75qF0+R45hfHLId6CSZSSiSNqyncb+Auh8S+XeBE6TYhA9Mk897tv+Yfa9ef78ZwEvzysHXx2i5jVYxqYdCGNdgjGZK3Cuv7+NwbvL5d/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdoA2s+zlCMdVPDkNoKQUGzFUMH9X37i0XVRnBBtf1I=;
 b=LFxoIQPDiR/LBq99bm8kUogyvUequcH149EN5adcddllXktruKohrrp9/raoa72uTtT1zF1Z718KWJh1Scq6YVm37+CGNzEn7U2X4J/eXtaSuHhT/7LH2hGKMfKMl/19Dl69f/HwGGILByJDZCF4U3mdb+MYpo6XLYbIeYR0Tpqu8z8rc3DLZoeK3JPRc2pnQS+I6ti60F3DdbiUihndWjZ/RyUXTcVxOR4Xz8yHmc75E62cFzhptsithKHjiqJDLH2nSRAfCHZygY8CdOjxkbzsCFuY/GtSPdNdUQQj/1nGdpIZBd361F2n46q+SJjExGAYCk6G1hvIGizV4dbqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdoA2s+zlCMdVPDkNoKQUGzFUMH9X37i0XVRnBBtf1I=;
 b=Rl/3uTRWHBsLH/VyrTg1/EQRaVzEJ/Ibc9SRInNfMcDre38+KeY+HgQWae0EV3WfyGETRYn/ElvWs1MR9qV3Yj3vh4LfnXXtgmSWg2Xx0QvDkl/gIUYS3vzsxVGS+XScUc8qr2G7VJ3RDo08O4F9ldJ0PmD18yTgkx3Y1Uxspk7IMEQ0wXsLlCtDSCcSmP0YHoYA9VcEFpscf5wuo4qom32qESMjvzgbm6aFcWtiOHRf6PANh+8yJbo1GCxysArAMWHbR8sWBq2VRQQPOYNaniHwTvCXALTV8JowmoF2TH9K393fo9k6JHbE+VG94b2ueR+qqnoHxB6maJi+uADdwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 15:05:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:05:03 +0000
Date:   Tue, 10 Oct 2023 12:05:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        will@kernel.org, aniketa@nvidia.com, cjia@nvidia.com,
        kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com,
        acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Message-ID: <20231010150502.GM3952@nvidia.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-2-ankita@nvidia.com>
 <ZR7hKYU1Wj+VTqpO@arm.com>
 <20231005165458.GM682044@nvidia.com>
 <ZSVe0nb02S4kz5D2@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSVe0nb02S4kz5D2@arm.com>
X-ClientProxiedBy: BL1PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be5086b-f018-4fae-aa8b-08dbc9a247fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khikcPI9nJ+HNkhn1Jjh89CQmyXWY/phu6MpKswyEvOndU5oI+OVomLoueUEyIs+17vsKG4wFvcBebBFmiTIAcnS5tTGLaXVdlEvdyfEU2Fp/84M2FRuH28rrISnw4O7AMOb9To+SgcTGGGTuajMm8l5pYDpBdkNCQb8bpPpPJKK+09TEEt6FiJpVJTY0lQxRFwdisd4LqIVZJD1IQuIOKudLvjiLp9dloKOCbGBPU24NnM9zbp7eIjMoGt1n42p181hyJq4voUzIxKWaCaTyqUq7nsJr8la1d5TpkuIT5JNiiJUHSmudHdTMLXJJUSbNf2LH9EXpT+MXry/MUWjEn4rKaKhkVjF6VvrE3V4M/cI/vv40N9oBUeSWjw3RBxTul9pYKKz4MBduYPfbblajvj6k/aJXB6sJbWHumEXtQsccYm1c5Duxq7VcETccjpF6mrVOIbVozb5U6n+/j68KgzlvY58ODB6moMH4Eh54THRWgFOZUtSlsbb7SiYz/6BowcK3ASHNvdx+VEswHW54TgexrNUhJG0/xIgPXMYOIZ71DsAtUxvBTHdV4exnaE5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6512007)(66899024)(83380400001)(66946007)(2616005)(1076003)(26005)(6916009)(66556008)(66476007)(316002)(5660300002)(8676002)(4326008)(41300700001)(8936002)(2906002)(6506007)(6486002)(478600001)(33656002)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bRpkjZBWzAcw8rcNoBxHAkBW7/4PGQIxMKVblmq55C6DSU7+enlOo3uUHiHY?=
 =?us-ascii?Q?BUwj1RRFKLtIEdzA8ZSXf5Jm/7sths/kA/jkN6KBuOJGe2Zi56ac5NUGM9Xp?=
 =?us-ascii?Q?KpETGEW/TMhLI2jzXm2LNsiwLMCnY4+CiyEWLZCdOZHGtjWYMzkTxyalFVHX?=
 =?us-ascii?Q?wyl0pgtQQs0tyy6Iz61/MjzTAL6XrB487dbHM50yAuTvQiIlRpmj8G4R1iVc?=
 =?us-ascii?Q?mp3lgAZVdgzaWKXujWbsGzsgF5O4OGf4hs/ZOELCpjQtzBxnQmHtuZuGwThH?=
 =?us-ascii?Q?EW2VmHxpnBdHgwvctNJ4FDrSRjXyFSS7eEGgSXsTauA/rBCcrjMxuimeroCu?=
 =?us-ascii?Q?E9i5IcdRC2xTyLgwlcu+1FUwCytFVF089Y2EPm5rK12pVX3lqJ/bHQW/DsP6?=
 =?us-ascii?Q?IzAv3ymen1tInN3/IQz4ZWH7lvY4xQDXYRecx+sj8ZYfli/1UXVQ+adWdTZq?=
 =?us-ascii?Q?nDDnDEPtxDu9ASq7PG9guX14bttEH+3JsVz76y+f9vFp8JVJEEpwRjtHvint?=
 =?us-ascii?Q?rtWv+mA8da13fhSnM8x35HZDLMY40aCBVvNNPDcqFCWHnp1iM7z7iQ6/FtPF?=
 =?us-ascii?Q?nrixez/vXOv4vBWeI9+oYaudSrSkaYbGUue8w/1ZA5+sVZsTZxk93PLdLpOT?=
 =?us-ascii?Q?+p8OL9ewouH86tc42bqDITH3ktlYSm8FDW9xYLrWiJxXsJzopQL0n1mPiSA0?=
 =?us-ascii?Q?u2wGXxtW18a36frWczBElQkA99izCSnmLXlT+PWAg8YxZa2TokhaxIvQeiYW?=
 =?us-ascii?Q?bY2Q88t8Ome0b4uZvO/2dBslgwBbCIjRDhuuJVjZKk10QWm8jP1WQQFS76IY?=
 =?us-ascii?Q?2gWlz8ctDy3mPjVIGpoKTGg5Ysll97Y1mWaz4Jki5pvL9GeDePyp443mNfYo?=
 =?us-ascii?Q?2CrztJxUdOj8HKbIa6rajFReqy5wx/Sy1unezUXzzMQVDTvfHfffhskhceuf?=
 =?us-ascii?Q?gs39k1uuOZnukb8YD4aR2LCv+eG7UEgh4iDs0dKp7QeLD3dKXTRteWWKv2Cw?=
 =?us-ascii?Q?MvPVI2sgjLsvD75SVJACMdni3UDePpUMrvMvvbsIFzms9dNXQpugWcR8YT66?=
 =?us-ascii?Q?DbllzmKv0wWKW2c/dAOcfeE8atRGkY2fZwP+n3Ks9yr+KkLT4YVrIq4cjEeS?=
 =?us-ascii?Q?5a21OkEaNtejjURciQ4DrFxPJ1j/NpXD6xwYENR8tQJllZwljT34VjLQmcVJ?=
 =?us-ascii?Q?oV8uB+zK+jcqlQPMUTkNVb4kYS6uHMTDvLcUzjgRNwQqnGw6TLupz6X0E4+/?=
 =?us-ascii?Q?l3wOTfpjAniMd7fHwJEXJB4x4AA0ci1/2+zMyEfQdGmYZoK59vHSTVvqsP78?=
 =?us-ascii?Q?hRno3suZCTgvTE60l/J6XcHzKe2jM2x0+36cSKGbbxxYvWxFIyROz3zJpg25?=
 =?us-ascii?Q?GT/6hTl5naGjuA85jU6rmGxLUj/4eZXYa/i1h/lQ2Gb9X2Tw1xYyFwhJtKtj?=
 =?us-ascii?Q?xCEZRS1e6gYpA3mImum4QSpKhM2huDuSb228S9WkLWHRepfnBJRqqH8Vwj9V?=
 =?us-ascii?Q?2mONo/bBeNlVrBEufUerBc4UvY1JaeVCcWLh5JALCXsBcFtO5hegQa82epM7?=
 =?us-ascii?Q?Dfg4F587EZdT6xgbb8k60VOj2nP7gEBvy9r9iTTZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be5086b-f018-4fae-aa8b-08dbc9a247fa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 15:05:03.4006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: som5HS7qfdcB23JOHr2p9YDsATC5cDkBVGIiw8erzbD9RPWAqAtjdsDJb7kX7XXD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7563
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 03:25:22PM +0100, Catalin Marinas wrote:
> On Thu, Oct 05, 2023 at 01:54:58PM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 05, 2023 at 05:15:37PM +0100, Catalin Marinas wrote:
> > > On Thu, Sep 07, 2023 at 11:14:58AM -0700, ankita@nvidia.com wrote:
> > > > From: Ankit Agrawal <ankita@nvidia.com>
> > > > Currently KVM determines if a VMA is pointing at IO memory by checking
> > > > pfn_is_map_memory(). However, the MM already gives us a way to tell what
> > > > kind of memory it is by inspecting the VMA.
> > > 
> > > Well, it doesn't. It tells us what attributes the user mapped that
> > > memory with, not whether it's I/O memory or standard RAM.
> > 
> > There is VM_IO which is intended to be used for address space with
> > side effects.
> > 
> > And there is VM_PFNMAP which is intended to be used for address space
> > without struct page (IO or not)
> > 
> > And finally we have the pgprot bit which define the cachability.
> > 
> > Do you have a definition of IO memory that those three things don't
> > cover?
> > 
> > I would propose that, for KVM's purpose, IO memory is marked with
> > VM_IO or a non-cachable pgprot
> > 
> > And "standard RAM" is defined by a cachable pgprot. Linux never makes
> > something that is VM_IO cachable.
> 
> I think we can safely set a stage 2 Normal NC for a vma with pgprot
> other than MT_NORMAL or MT_NORMAL_TAGGED. But the other way around is
> not that simple. Just because the VMM was allowed to map it as cacheable
> does not mean that it supports all the CPU features. One example is MTE
> where we can only guarantee that the RAM given to the OS at boot
> supports tagged accesses. 

Is there a use case to supply the VMM with cachable memory that is not
full featured? At least the vfio cases I am aware of do not actually
want to do this and would probably like the arch to prevent these
corner cases upfront.

> I've seen something similar in the past with
> LSE atomics (or was it exclusives?) not being propagated. These don't
> make the memory safe for a guest to use as general purpose RAM.

At least from a mm perspective, I think it is important that cachable
struct pages are all the same and all interchangable. If the arch
cannot provide this it should not allow the pgmap/memremap to succeed
at all. Otherwise drivers using these new APIs are never going to work
fully right..

That leaves open the question of what to do with a cachable VM_PFNMAP,
but if the arch can deal with the memremap issue then it seems like it
can use the same logic when inspecting the VMA contents?

> I was thinking more about keeping things simpler and avoid any lack of
> coherence between the VMM and the VM, in case the latter maps it as
> Normal NC. But if the VMM doesn't touch it, the initial cache
> maintenance by the KVM would do.

I see, in general we usually don't have use cases for the VMM touching
the vfio memory as it is hard to make that secure. I would like it if
that memory could be a FD instead of a VMA. Maybe someday..

> See above on the characteristics of the memory. If some of them are not
> supported, it's probably fine (atomics not working) but others like MTE
> accesses could either cause external aborts or access random addresses
> from elsewhere. Currently we rely on pfn_is_map_memory() for this but we
> need a way to tell that other ranges outside the initial RAM supports
> all features. 

Indeed, I did not realize this about arm. See above on my note that at
the mm level we should not have different types of cachable struct
pages. So I think the right thing to do is fix that and still rely on
the struct page test here in kvm.

> IOW, is any of this memory (mapped as cacheable in the
> VMM) special purpose with only a subset of the CPU features supported?

At least the use cases I am interested in has the memory be
functionally indistinguishable from boot time DDR.

Cachable memory that does not function the same as DDR is something
else, maybe that is your "cachable IO memory" concept. I don't have a
use case for it. If we do decide to create it then it likely should be
tagged as MEMORY_DEVICE_PCI_P2PDMA in the mm side and not get into any
code paths that assume DDR.

Jason
