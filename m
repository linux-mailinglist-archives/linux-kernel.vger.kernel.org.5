Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721707F3E20
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjKVG23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjKVG21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:28:27 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE51CB9;
        Tue, 21 Nov 2023 22:28:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzgikRu0OqEokyK27voxEPi7biwvFso4KH3EZG0XjO/Ew3ZitFm1GoF17NRB/ncov5EIM9Tk6gvXrAKA6SFyDxLmyYgMST9w3kPGOI/UibTL7YQnLe1a+kD8ahaOYlI1uyxVtQGVoo/dY+QfeFhUZlq1GWYv4xzNgJ9dAYvKBBmb1OT9mu7I4A69pCJdcKXLMATkOa/WCG/XWUEnTxPDHZ4HL9l9nJ2WP4TbgLLBFZNs1MvEo7BP1QcByi3tHeyXY2VUam0V5LVbpnwF3DIt9rfAG/PeSsrhbcqqaSYAS1MS11baRKoU0c5CwOoT0LlzzXbQDjRJpSfmTe0adjNf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B1NV03QZHe55F1PLPGrAijojPgXIK06fuZqeI7DCL4=;
 b=E7l7xel3Uq3vKVMLRFPUiYXx+1vv3H0Nzb21HD77ymc1bEInNPz3sL35WRGOTDGRA3WMh/QKhuPml8i9quVBPB2/zK/8aL/tFC60S+xtj4EXNPyB5SmKzQlP44wIRHDiOI1mqa7EbEtx9h/oXIqvxpUhy3ddmOijP8M43sr80JD9qcupZm+9Wpic/sHtU+In1xaYgr2orsgZHCBp5yWXED6NPev0tUUdFIuJjbxdMhkUN5S8bGG4DlrvSAtQRJ07Sx5oSIBQsYVFFmuOE0AacFayWNNFQSLLfj+xk+9IkfBKAWF9pLc82q8M6/k3FquoRU1qU7z+JoLqDFKaaRAQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B1NV03QZHe55F1PLPGrAijojPgXIK06fuZqeI7DCL4=;
 b=hSIEtPhV00rxQcr3YVS/VLBNOVw/3YcAom+If9DVj+I8FKsAz3IZW1fY+c026yX+qcNdwfZQNX0czaUGKEEWaX2iGgNBOSPhdLlPfJcsrX68wwjfUBTVHH9cEQvGdiAN9TZXswvJboty+xBL1mIQZ/UE03eud+jlJp+W+G0KD7PRWwGkmn9oZBy1eYtM34AX15ly40AiS140gZQWg7bXvKkrqEg6c+p+hcLMQYIouOsa4UFLI6AjJm6gqoBoJhACpYxS81p97GL7oH3qAeiV3SDR4ksaj/3T933VL1Sg9BnWqllW2cwPEGvFb1G6/tAm+0O6iqaEQ74UouvhSxS+3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Wed, 22 Nov
 2023 06:28:21 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::fb09:9679:bd22:6bcb]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::fb09:9679:bd22:6bcb%7]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 06:28:20 +0000
References: <20231117090933.75267-1-baolu.lu@linux.intel.com>
 <87edgll1up.fsf@nvdebian.thelocal>
 <877cmdcewc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Alistair Popple <apopple@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Luo Yuzhang <yuzhang.luo@intel.com>,
        Tony Zhu <tony.zhu@intel.com>, Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect cache invalidation for mm
 notification
Date:   Wed, 22 Nov 2023 17:14:14 +1100
In-reply-to: <877cmdcewc.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87edgimhds.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0039.ausprd01.prod.outlook.com
 (2603:10c6:1:15::27) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ff9630-30ca-410e-c4bf-08dbeb243813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3zV1wKTNGDqgn+eZ/8wfjRYseDQUr+g4xxOtyfLsIn1/XpjPGCrB9j3WXfcEpxQqGXV0aVUrFHTwAMfZlJkMK9cQvDH6uDxgxUtZCkvv1WuDuMZfF9izRxo7TYp1pz3k6vb21AASFeu8Lz3ypm2FwLMvEXE4yTPWcIBRvCV/6UChmvgYRz2tNKFdLmF4Iyrbpq8DIWLBYtPW8Vv4eZW8ENPyB9UwuXFmUvzTwXRUboD5IAwTvfcpMrZAaJQzMd2eEwGq357BtocXR/rOpBEeyDPjYB9O9fQRZWr7WVMHI/Uogau/D+BnMhJfbO0QGzfQyYlA4XSBjmOxHqoxwkrdHpXrt/teD5wEgMWPTfIOLsZRljc7XLemh4f5HCgaZPH0HcKCVp488JYMDiwag+5P8gFDpM4Aaqg5jxkJnr0URAhmROm5/aSTgr3ETgUQFilZqecKkmnvQaaPOJWbEAhTHHVjWnQoI52kaNhZ4YONdewd8wVoG4sSjG5pVDaI8V7lUJlFswxQsmj4rYRHWG7UnKbH/DIp3wlgeWcgLElFz1W2+2QUQKOoKjSa7ZI+mCHhL72AEAKZTjieaCxSyWEXm9mmBxEARKNT4WSVX1Stsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(966005)(6916009)(54906003)(6506007)(9686003)(6512007)(26005)(66476007)(41300700001)(83380400001)(316002)(7416002)(6666004)(66899024)(5660300002)(86362001)(66946007)(66556008)(4326008)(6486002)(38100700002)(478600001)(2906002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jAHJDdZWX/6uwaA6eUNRLqvDS8krZsu0ftCKlWti9jggURgD2oI22h4UBytO?=
 =?us-ascii?Q?rlBW0nFPpOR4RzDAPPFwiTpJdhJZyyrSxgE1I8r/h/EnAZcHBRkhGNLVDqJU?=
 =?us-ascii?Q?idRkd+M8354QxLErza3fzH/3FQu/SIvz4wa7Pnd2JIt85Y5XgUwvALnmtVgb?=
 =?us-ascii?Q?WXwRLUIB3ctXPfJ/zYTjqiDZ0Z/59Gjwiq6KS4t4nPWfAH6ZPxL42/gLdpSf?=
 =?us-ascii?Q?nWcLO/oxofDjkEKaJN0ID5gbH4VFO0pOBD/mgJTcVHjU+Bgri4Bde8g1wUvS?=
 =?us-ascii?Q?slHc25/YLTY1wzmU43XNT707JPoxlamRmslRPWqIwcXfPhloK/FDfd/Bh17V?=
 =?us-ascii?Q?VcRsPe9nMZZvzL1HLInMxr+CZf54SBVBlooIsixk/h391YBcvadhMunu8jtf?=
 =?us-ascii?Q?v03vllM5MCPQkwcWJ4Oit54RlcTIo2VRM8gjBRFUzQuC7UNu4f/HW8SMOLM4?=
 =?us-ascii?Q?69RWYj5ImHBgJLKY6JByXZwUrrhZIAfjW83RujBk+5p8C6KlyPoaRHTKgfaE?=
 =?us-ascii?Q?e5QkioeZduS7CWfUfkpVD2Svg8tZNdDoVSdd1TXdmE/v6aHBst9rscLYkc10?=
 =?us-ascii?Q?NdzAxKPdlbF356udR5GZxf+4T85e8fNDyM+2GhYMpNw2mcA7H1Zo6xFRjCqu?=
 =?us-ascii?Q?Uh+migB1EE+LHSuCBsiAqRToDGV1morwhuFpCwPEgtDI0VkQDu4tNox2cov4?=
 =?us-ascii?Q?V3pJWArRzqOYJamH/ZBGyBj6TcAUSxs1l0AAUL4M6ydjsU8ZBUVYvwCReYBq?=
 =?us-ascii?Q?p4tyvayLVCvnMhAM1kqgEGvqUYKrNvzICB7poMxPmNuHYB+uH2drtH93L+AK?=
 =?us-ascii?Q?64dkJfL+b8nPLLYPgy6atBVW3a+VAa/uSxEjMaAtBnzijJzfdvD/jJ3V7EQB?=
 =?us-ascii?Q?xKsCU3Jm6ROCXORHggp0Dd9P10eM4/kbsKGhiJqQeHR20FglMMY3g/RxmYbv?=
 =?us-ascii?Q?3l//qKk2//uHbWSjQncyIWFbXMgeBjEdWSDllo3TYVBnOT+1zpzP755Pjrd1?=
 =?us-ascii?Q?Kg5Mn0tyc3om13g1xj+oFexjRb93Faq37VgPbA0qCulg8bSbH8qwTWQvfgr3?=
 =?us-ascii?Q?UBeMj0+gLTmQ2BdBDPkmlJvc7HPGHH+GDGBIVAQhtL4WvZR0bVCEaRW2nlZi?=
 =?us-ascii?Q?FxEfQDAwEQGhW3LDE/xTlzdLx1ocgYBb0P7J0/C5tkX8+MFMRhqKmT4FKzGB?=
 =?us-ascii?Q?MiI4X7S4ymrCJ/R1cpchniBwU7J3RRbzAnmyUTVbCUr3TFi7HHNv1IBUT/gc?=
 =?us-ascii?Q?WRVJOkXFAMWGWuKoFxtL6JtNOwUYCB6MdN0Dib03x/WZouFST6MDcrZJtBf+?=
 =?us-ascii?Q?bPTwM4Tm6JHopNWD+nmPJJQQJMyZiWuSUrwKWjyod38pwDT3jLVm1nt7QSSn?=
 =?us-ascii?Q?L6ixqQNeql+7ngx45kPXIhr+NYkOBUHXyFTkiU1H6kLP850wIZMKP80jKndU?=
 =?us-ascii?Q?9UnPm03ZxWWWe0yhXluhRkc3w3qxvKhLyV/pyQe4HbPNHO5JG+5/rS/Cqa5h?=
 =?us-ascii?Q?cE4gP/QYAf5YguRZawuTpdOa1wZ/8XLmJtituGL+pW59CFuLZ9XqFHEsY+B5?=
 =?us-ascii?Q?zgfXGtP4WKzsA9xVmlbXECG+Qse8NuOaTcakXYm5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ff9630-30ca-410e-c4bf-08dbeb243813
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 06:28:20.1447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrJIRtgHi5ddrB0VBaaajmeJiE/2DaqDVniYno9Bof6K3EKRW0FH0DJO3dm9rZlxIirHMddjaG8Ye+5J6YPrrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Huang, Ying" <ying.huang@intel.com> writes:

> Alistair Popple <apopple@nvidia.com> writes:
>
>> Lu Baolu <baolu.lu@linux.intel.com> writes:
>>
>>> Commit 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when
>>> invalidating TLBs") moved the secondary TLB invalidations into the TLB
>>> invalidation functions to ensure that all secondary TLB invalidations
>>> happen at the same time as the CPU invalidation and added a flush-all
>>> type of secondary TLB invalidation for the batched mode, where a range
>>> of [0, -1UL) is used to indicates that the range extends to the end of
>>> the address space.
>>>
>>> However, using an end address of -1UL caused an overflow in the Intel
>>> IOMMU driver, where the end address was rounded up to the next page.
>>> As a result, both the IOTLB and device ATC were not invalidated correctly.
>>
>> Thanks for catching. This fix looks good so:
>>
>> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>>
>> However examining the fixes patch again I note that we are calling
>> mmu_notifier_invalidate_range(mm, 0, -1UL) from
>> arch_tlbbatch_add_pending() in arch/x86/include/asm/tlbflush.h.
>>
>> That seems suboptimal because we would be doing an invalidate all for
>> every page unmap,
>
> Yes.  This can be performance regression for IOMMU TLB flushing.  For
> CPU, it's "flush smaller ranges with more IPI" vs. "flush whole range
> with less IPI", and in general the later wins because the high overhead
> of IPI.  But, IIUC, for IOMMU TLB, it becomes "flush smaller ranges"
> vs. "flush whole range".  That is generally bad.

The "flush smaller ranges" vs. "flush whole range" is equally valid for
some architectures, or at least some implementations of SMMU on ARM
because flushing the whole range is a single IOMMU command vs. multiple
for flushing a range. See for example
https://lore.kernel.org/linux-arm-kernel/20230920052257.8615-1-nicolinc@nvidia.com/
which switches to a full invalidate depending on the range. I've no idea
if that's true more generally though, although a similar situation
existed on POWER9.

> It may be better to
> restore the original behavior.  Can we just pass the size of TLB
> flushing in set_tlb_ubc_flush_pending()->arch_tlbbatch_add_pending(),
> and flush the IOMMU TLB for the range?

Ideally we'd push the notifier call down the stack, closer to where the
actual HW tlb invalidate gets called. I think I was just getting lost
through all the indirection in the lower level x86_64 TLB flushing and
batching code though. Will take another look.

>> and as of db6c1f6f236d ("mm/tlbbatch: introduce
>> arch_flush_tlb_batched_pending()") arch_flush_tlb_batched_pending()
>> calls flush_tlb_mm() anyway. So I think we can probably drop the
>> explicit notifier call from arch_flush_tlb_batched_pending().
>
> arch_flush_tlb_batched_pending() is used when we need to change page
> table (e.g., munmap()) in parallel with TLB flushing batching (e.g.,
> try_to_unmap()).  The actual TLB flushing part for
> set_tlb_ubc_flush_pending()->arch_tlbbatch_add_pending() is
> try_to_unmap_flush()->arch_tlbbatch_flush().

Thanks for the pointer. I must have got arch_tlbbatch_flush() and
arch_flush_tlb_batched_pending() crossed at some point.

 - Alistair

>> Will put togeather a patch for that.
>>
>>  - Alistair
>>
>>> Add a flush all helper function and call it when the invalidation range
>>> is from 0 to -1UL, ensuring that the entire caches are invalidated
>>> correctly.
>>>
>
> [snip]

