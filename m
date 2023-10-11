Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D28C7C5B70
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjJKSit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjJKSis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:38:48 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D58493
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEI8H5JpceVMr4MdBgRqVHNJna7w5m2zwlN4XIhSqD/7TsjvexBm3Fm3IbarQeJoAAN/VTlkQUci5h4TIu3co8vTpafcBiNLD4yU0tQ44P8okKbxtWcHsqncaszHyf1JODCq6oBwhOZa3++lW6ySggaHVqbZsHgstrdrVtXamAnPsOOLqIgex9niniWPcGWS6S3fRGcP92iGX1nV81bOHTgUkTWv5pnUeHStfCd/IA+7JkVyod9e1xcWBCLuE1maFVaqGx+g/zLjroV4H1agFAvrWjDzAvH7tiBpCcmQ0NxViiN9wpaQaI9f0RSY3v8OGhj511n4+XW0cWsWdBSvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdCTNRhiwwSAMltSeYHjXcNem99smaZEevAWE9D2dgg=;
 b=Z8tcWHsBUPYoVLwfonkk+0CYaiCxopFexxZZqEvp4CEw8uzfjx8betZRSOdpaTECJuSkkC2EIhT7LafFLC3jqHe7fOXs+gCOjN3wIxHWN6ZYRhzWoLX6Wvg6eRrnVRjew6xJDfqd5STv0vJH+SE08QNGJ/RjahBpmi9LkLeFOJrBjd1SfFlRj+VMIfAdtF6TGdDqSwHTt+Yjp3XwomMn2JqGcH5BbUDN39xH7DrtzdNeukns02+thMVpzBOG2VqOYZgul4FDHs7MlXKBIvF3luScOd3fd3F1kplYEAvQYI0+5q/SVZ9Hd/Ma2K+wZiWF7Tvek4Q+ZfFvMjyGOfRlXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdCTNRhiwwSAMltSeYHjXcNem99smaZEevAWE9D2dgg=;
 b=NQ03N+M3r5mEZpY4T3Z2++oRGHgMwhbtrZpZ9aRu8RFQOQKSpKnll8CGypEQdUAbUeNPL0b4O7vVt5DaTkHM5hkOpp9J3dBPM8OQFfPCuvmUWJ4eKT3zXOE5qcsd5arTYRxg0rdCj7kvBskTx7sRZ25lQoCrO0Uhpsvwcn0dp+PR7bG8yoZzYhXMflZeJ2G+nTmoDGlF7+O2Silj/MxpPnoOWiagdo3DwNNqVq883ADHsdt+ofAP5b0Bm3LjnoC5CNLDcN17PCmToRhw+9+cp1Q7ah1gYE9P1vwDViKPuu8Jrji9byICC5e7UGtCam6NnqoNvkV75xloZKKVwiZ+OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 18:38:42 +0000
Received: from MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::5bf0:45ee:4656:5975]) by MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::5bf0:45ee:4656:5975%5]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 18:38:41 +0000
Date:   Wed, 11 Oct 2023 15:38:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        will@kernel.org, aniketa@nvidia.com, cjia@nvidia.com,
        kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com,
        acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Message-ID: <20231011183839.GC3952@nvidia.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-2-ankita@nvidia.com>
 <ZR7hKYU1Wj+VTqpO@arm.com>
 <20231005165458.GM682044@nvidia.com>
 <ZSVe0nb02S4kz5D2@arm.com>
 <20231010150502.GM3952@nvidia.com>
 <ZSWHkvhutlnvVLUZ@arm.com>
 <20231010182328.GS3952@nvidia.com>
 <ZSbfUNLwDkaYL4ts@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSbfUNLwDkaYL4ts@arm.com>
X-ClientProxiedBy: MN2PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:208:23b::30) To MN0PR12MB5859.namprd12.prod.outlook.com
 (2603:10b6:208:37a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5859:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 74120893-dda6-4f08-80f9-08dbca894a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Io5ziGcv2HBUkp+JCekZbdBX/x/HEfZXItQaFDtClTtTEVERpQDCe2jDdLX6brlX5ziqTCs0Hs031dnbwaVow4IzQPPUbfoOWh2amH15AfaeRgF9mTpFQ7BZmMpEny1mDdgzlZzPP9BpQLk7uHcJQuUmRn+qmtvcHN9YmuxeyvqnZ6759G6bS+o0pPWLZinSHl/H7Nj9d8xqgtIwzMiuh5fQm4CFCMQzQv1Wmse6VMDmCjJymuds7lG9IaPMABy7Z3UzRLh1LyHL9Iacf1OO0S6wkRR+ye6qYm1Vstg1YrSs2ULjaHxxqBMslEW+6lnUY+nuNadKEpJz7IxZpjVtKvUjB/0zRRpzdxawFItwIDncJi+TC4LmD+Px2rflz501Uhqb0gE9vvWmjf2vqLHqlRFr0S9J3DU/pkmRMg3oOfm/+ov8f/vwG0ifjvwVa9QhA8FvtE7zCO0HHZGOamhzvw6aGY29J25kiPnb0tzk0fnigqZUXj9yxFeOSxm4qZpuqt8rSr18z5xQFAh8xG5UGYddAFi8sxh5tCWpJajupp9WuRTn5DK8aEpdmIWELcYM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5859.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66556008)(1076003)(6512007)(478600001)(33656002)(86362001)(38100700002)(36756003)(83380400001)(2906002)(8676002)(6486002)(2616005)(26005)(6506007)(4326008)(6916009)(8936002)(41300700001)(5660300002)(66476007)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cbPrIU2J7R6fQZl5DzTdWCf7oz66GWhCLdb1XHLkGeHSNMVttZxj09K/x8QN?=
 =?us-ascii?Q?DYdMI+kVLD7j5DrpeTzKxo+EJ7pdoZQYg4S7s3ret2EACaulhhazUGxqdURO?=
 =?us-ascii?Q?uPEYmqZT67sE+iIpA8xS+Z4yfkJWRzu4B83hbDfcX2G54IiYIp/HlyNk2jgG?=
 =?us-ascii?Q?A46HACjurjL+TRIYUm/SJ0gmcCt8q/+ce5T0GmzsAXCIbxY91WVExTH7FIx1?=
 =?us-ascii?Q?2NDp/G5+oR0fU01lpZXxOTCS1DaxuzlkYDPVpLyCFYAe+b8qtxcCG87Sudaa?=
 =?us-ascii?Q?wZIICklPeE29aXaJpLX3aDsPVkHgFmRzhsupAiuYJBZCGBUCArfqgJGlY/nn?=
 =?us-ascii?Q?RyOHPRXQq3LHv2H4NPYGG8ChWJia38iXnUonEZu3SpXJyXzcL65we5ncAQPn?=
 =?us-ascii?Q?oPp7exu3J0C6+yM6agm/3IKdi5B3uVCi+xbZyTszx4dZiuV9KcrIJeDD88fe?=
 =?us-ascii?Q?1vAPY9n4r5dhcDOAHRM5SyrZ3ibCzoQvADfvAivybY9ux5eIjxEHvi2k+kF2?=
 =?us-ascii?Q?w6ARF6171wkEkq6LVZ6zVcNxknm2/dgXds+yZUrfUV78mZegorwZ/buSTX5m?=
 =?us-ascii?Q?uu243NPsPYvJz6xinSQp2ftbouK1hi4EnUyPlTaO90xFLlBu2n4ozTj9YYtX?=
 =?us-ascii?Q?9U2lPvT8psTcBaLZXgaelghyxgCXw9y4yBdbQDZza9rJfzikKiTdJjeC3bCP?=
 =?us-ascii?Q?Al8uSaK1M3vjanUkw2Xi2raBW/Ph8OFHNgHegi9VhH9ZLP9uTW74Go6P+brG?=
 =?us-ascii?Q?i61LdU0BSmcAF2GvLPu2DQIrZLtdoOKyvYMbDOOW+5LdT7B9SBNUF5fMirgD?=
 =?us-ascii?Q?cjqO8yEghtscJjwVoJeoQJbjAlwwsVC+fUyODRsuGjvWHAlmh1m+XWD6byJs?=
 =?us-ascii?Q?Zr9AUFXHvhoWrDGxGw80HdW/Vx0qNp28mh8e0SxJY/z6VfHjH8peh9dMgxNR?=
 =?us-ascii?Q?qtDHijJ1Vw7rL9gSo0RPbk5SOBF3kNUUYwmt79c7HXoKE2C+FNk+9KN/A3nq?=
 =?us-ascii?Q?cg1UQf+ymeSuXvfTKeuETB5a8ohO+Apf8pRugzy0cYV6Fz1UYKt98lSFO+NI?=
 =?us-ascii?Q?dQFudMbYgE2xMiqAc3ZFNmqvR2ljvoa/+Dim5xpb9cHEMiF5I/tfkgQqD7yR?=
 =?us-ascii?Q?ZOr9i8H421Mq2WDK/N8qj/QfvOc992mAHeEPkb9zUvB9JlMQxEaBtSAQNPxs?=
 =?us-ascii?Q?my8qsZ6YZQvINvUxCqbxuBy44v2wA5whqSUlAniF98lc5R+So6syD46Yr4SM?=
 =?us-ascii?Q?wNfuI/e6cHHaTXLJ2OH7kpUefIDs17Xj/PoCvTh1b58Zz0eHPSOWfKTz0omt?=
 =?us-ascii?Q?XAvbqWXpaj3IzM+VwurJ21+VeDm8FYx0ZnyJ4o+s9ajWnXYu9644fTgcEWOc?=
 =?us-ascii?Q?cvjWtIkcXPvB92JIOWKx7oECsKCtiLlWNyUhsHq7rXCSmaa/wtDgLazJbsrA?=
 =?us-ascii?Q?M41qae5FaBHJknXbEKXIyxCPbtUkd8/vyF/KpriZ/7nIy438FmJjwj6CWGWY?=
 =?us-ascii?Q?6WM7Hgnw7+2333ghzxjFsNsk6QyCSnQjnqVu/vtSBbOoGRsmySFAOjEM1BB+?=
 =?us-ascii?Q?gn0cnG8DU5+yD8EzjMsQD1r0g3tn591LFSUFooV6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74120893-dda6-4f08-80f9-08dbca894a46
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5859.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:38:41.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruduFyJoK+l0rrAvitqYp5sTWq/Jhzw5AkHs9revYIybankxHws6Kj57tBAVNq0l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 06:45:52PM +0100, Catalin Marinas wrote:

> > From the mm perspective we can't have two kinds of cachable struct
> > pages running around that are functionally different.
> 
> From a Linux+MTE perspective, what goes into ZONE_MOVABLE should work
> fine, all pages interchangeable (if it doesn't, the hardware is
> broken).

Yes, and we imagine adding GPU and CXL memory to ZONE_MOVABLE (on a
NUMA node)

> These are added via the add_memory_resource() hotplug path. If a
> platform is known not to support this, it better not advertise MTE as a
> feature (the CPUs usually have some tie-off signal when the rest of the
> SoC cannot handle MTE). We could claim it's a hardware erratum if it
> does.

Seems logical
 
> But for ZONE_DEVICE ranges, these are not guaranteed to support all the
> characteristics of the main RAM. I think that's what memremap_pages()
> gives us. I'm not too familiar with this part of the kernel but IIUC
> that falls under the HMM category, so not interchangeable with the
> normal RAM (hotplugged or not).

DAX pages use ZONE_DEVICE and they are cachable, and not "HMM".

They are not fully interchangable, but they get into the page cache,
they can back .data segements, they could be subject atomics/etc. So
they should be fully functional like DDR.

> I don't see the mm code doing this but I haven't looked deep enough.
> At least not in the way of doing an mmap(MAP_ANONYMOUS) and the kernel
> allocating ZONE_DEVICE pages and passing them to the user.

Not ZONE_DEVICE. One popular coherent GPU approach is to use
ZONE_MOVABLE pages.

> > > > > I've seen something similar in the past with
> > > > > LSE atomics (or was it exclusives?) not being propagated. These don't
> > > > > make the memory safe for a guest to use as general purpose RAM.
> > > > 
> > > > At least from a mm perspective, I think it is important that cachable
> > > > struct pages are all the same and all interchangable. If the arch
> > > > cannot provide this it should not allow the pgmap/memremap to succeed
> > > > at all. Otherwise drivers using these new APIs are never going to work
> > > > fully right..
> > > 
> > > Yes, for struct page backed memory, the current assumption is that all
> > > are the same, support all CPU features. It's the PFN-based memory where
> > > we don't have such guarantees.
> > 
> > I see it got a bit confused, I am talking about memremap_pages() (ie
> > include/linux/memremap.h), not memremap (include/linux/io.h) for
> > getting non-struct page memory. It is confusing :|
> > 
> > memremap_pages() is one of the entry points of the struct page hotplug
> > machinery. Things like CXL drivers assume they can hot plug in new
> > memory through these APIs and get new cachable struct pages that are
> > functionally identical to boot time cachable struct pages.
> 
> We have two mechanisms, one in memremap.c and another in
> memory_hotplug.c.

Yes

>  So far my assumption is that only the memory added by
> the latter ends up in ZONE_MOVABLE and can be used by the kernel as any
> of the ZONE_NORMAL RAM, transparently to the user. 

Probably for now, yes. But CXL/GPU memory goes there too.

> For ZONE_DEVICE allocations, one would have to explicitly mmap() it
> via a device fd.

Not quite for DAX, it gets in through the page cache, but it is still
mmap on a FD and not anonymous memory.

> If a VMM wants to mmap() such GPU memory and give it to the guest as
> general purpose RAM, it should make sure it has all the characteristics
> as advertised by the CPU or disable certain features (if it can).

This is the VFIO flow we are talking about here, I think. PFNMAP
memory that goes into a VM that is cachable.

> Currently we don't have a way to tell what such memory supports (neither
> ACPI tables nor any hardware probing). The same assumption w.r.t. MTE is
> that it doesn't.

Indeed, but my GPU driver hot plugged it as ZONE_MOVABLE and my VFIO
driver turned in into PFNMAP.. So these things seem incompatible.

> > > We have an additional flag, VM_MTE_ALLOWED, only set for mappings backed
> > > by struct page. We could probe that in KVM and either fall back to
> > > non-cacheable or allow cacheable if MTE is disable at the vCPU level.
> > 
> > I'm not sure what this does, it is only set by shmem_map? That is
> > much stricter than "mappings backed by struct page"
> 
> This flag is similar to the VM_MAYWRITE etc. On an mmap(), the vma gets
> the VM_MTE_ALLOWED flag if the mapping is MAP_ANONYMOUS (see
> arch_calc_vm_flag_bits()) or the (driver) mmap function knows that the
> memory supports MTE and sets the flag explicitly. Currently that's only
> done in shmem_mmap() as we know where this memory is coming from. When
> the user wants an mmap(PROT_MTE), the arch code checks whether
> VM_MTE_ALLOWED is set on the vma before allowing tag accesses.
> 
> Memory mapped from ZONE_DEVICE won't have such flag set, so
> mmap(PROT_MTE) will fail. But for KVM guests, there's no such mmap()
> call into the hypervisor. A guest can simply enable MTE at stage 1
> without the hypervisor being able to tell.

Yes, so this is all safe for DAX usages, not safe for GPU CXL NUMA
memory hotplug. :|

> > Still, I'm not sure how to proceed here - we veered into this MTE
> > stuff I don't know we have experiance with yet.
> 
> We veered mostly because on arm64 such GPU memory is not guaranteed to
> have all the characteristics of the generic RAM. I think only MTE is the
> dangerous one and it needs extra care but I wouldn't be surprised if we
> notice atomics failing.

So, at least for the system this change is being tested on, the
"pre-CXL" GPU memory is 100% interchangable with DDR memory. It is
surfaced to the OS as ZONE_MOVABLE and it should work in VMs like this
too.

> It looks like memremap_pages() also takes a memory type and I suspect
> it's only safe to map MEMORY_DEVICE_COHERENT into a guest (as generic
> RAM). Is there any sanity check on the host kernel side to allow VMM
> cacheable mappings only for such memory and not the other
> MEMORY_DEVICE_* types?

I guess it is this current KVM code we are discussing, it probably
happens by the pfn_is_map_memory() check?
 
> Going back to KVM, we can relax to cacheable mapping at Stage 2 if the
> vma is cacheable and either VM_MTE_ALLOWED is set or KVM_CAP_ARM_MTE is
> disabled.

This seems logical to me, thanks

> From the earlier discussions, we can probably ignore VM_IO
> since we won't have a cacheable mapping with this flag. Not sure about
> VM_PFNMAP.

PFNMAP is the interesting one for VFIO, at least. Can we use the same
reasoning that it will be !VM_MTE_ALLOWED and we can close the MTE
discussion.

Currently no VFIO driver is doing cachable that has memory that is
different from DDR memory. So this is sort of theoretical discussion
about future cachable HW that does use VFIO that does have a
non-uniformity.

Maybe that HW should set VM_IO on its VFIO PFN map and obviously not
use ZONE_MOVABLE?

Where does that leave us for this patch? We check the VM_MTE_ALLOWED
and check for ZONE_MOVABLE struct pages as one of the conditions for
NORMAL?

Jason
