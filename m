Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50BC7F57BC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 06:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344655AbjKWFQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 00:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjKWFQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 00:16:31 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771CD1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 21:16:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRmhXmE4L21EcfVPmYVipUvFH4264oZdatEkBWmB0Fku06LNYL6/KsnQVYiHIQ11pKF224BgYivPCXTOD22oU9f/LAW44kcamZC1cmi+qUTftO99DtflZfO1C6ptt8ESahmtbm0cYoTJqaCaf2ep+f/8qmyoPf1L4kUi8eGSTASkSCbkOWRW4viIfjy5rswatpRhONk+WBTuWj/8HnNbtm0eIUTU5U3hOzK0EGI9aJ/5wlfz8VvPz8nvcbjt5XBx9KQn9OUiQCjdVy8zd5xpDwFgnplpy6+fPaArD47s1YfZkfbd9846tkT80s2sYJaNN18NdC+ZxsgTXudsKWHEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWEc7WxPOSC/jdspV2ZxxI1QRBaETZvioRaPPCiVe9U=;
 b=DfQLmZGcHc6LxBXY3dHhBHSPS8IIFsSoGKxKKmAaEXpjcyV9SJQyBnf29I3yGiJFS7EnePE8pjr9kaqPfDGTsqw9SfYfwB3DiAqyxKd+O3N5E738MxpFobUlMT1YvbfLs+QkEmpi+C7SPiDY4ZlZkyNNALuLz2+L78NDBFoyx4JDWoL4iZMqgU/qqYAmdfEkAzbEA8nTtZanfLINDGQHLdD8UIuENVqMYUC7WIwjOoc0f/Rr1xXvR4EaOlEBEmKGHWcNU9DTiUdJHshS5uKAauGFt1qU0ZL/OsdSD87WY9Z4joKx9GQAwOk0TAqqefm/TX3eBZs8RU3qNSMdqRzUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWEc7WxPOSC/jdspV2ZxxI1QRBaETZvioRaPPCiVe9U=;
 b=jMqK0EZUiqKCxr47CI92WZqKb6aLwghvNARvhhLG6WqUQZSU6JB08P5vR2xszYhmTkki1PZyF9U4y5PX5k8bqHjN/fqzF85pZPJyuf/5GuCgs8bqNep6oauQ3lIMMgJrBq+Vl5gWjcEm5NwSczCp0cLvPkZABJZ0u5QLQXXJQW28P0tiIKfcI78NrIMbZt0jrSLcTLr8lD8MbAnigJBNsJ4hi0SkiVkv6ZWABYb2wNkKgJerccEG9tpp6vOtxjyqRxSJpdOmlpw0vzRecSkue85sjB0euXobcVeFfivsG/I9taseDvyOZSMvGBTmUBM1i4c8FX2Ye5VJRKdIHGxyHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 05:16:34 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 05:16:33 +0000
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-15-ryan.roberts@arm.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] arm64/mm: Add ptep_get_and_clear_full() to
 optimize process teardown
Date:   Thu, 23 Nov 2023 16:13:17 +1100
In-reply-to: <20231115163018.1303287-15-ryan.roberts@arm.com>
Message-ID: <87fs0xxd5g.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0039.ausprd01.prod.outlook.com
 (2603:10c6:10:4::27) To DM6PR12MB3179.namprd12.prod.outlook.com
 (2603:10b6:5:183::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 814c7b67-5f46-48e7-c119-08dbebe35b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avbJwK7ibgk36epRoaVr+Hzd4ERiHr4rxcYz28IvnMMuOAwm5Q/bdhVgsFxzOWadg1Bkw+nwKzoca0toMz2YHhtD3Fabh+pHHfRWWob4nAL3LHu+TwtTpd/wUt1ILER5YSObTzjFFoYA8lOzh8QDYehGn9AC5hn8IBvnbFa4p2849xn/NjvjAXYPahkWIhVDOcEQDBib4dXQ0x8D4i4aom2GjWyVDzCVn/AoyjjmriBjrr45WY+XTfV7L1LnbrA2sgEBGxgWG+jwnvURFiJLp/GdJu3TD0hTy8GiH1f+h/ANAfzrwhsAv9ElZqaZlFkRE/qJQuTj94+Jsgxe1IgI1exaScVrfUSFfG3J6nLZ+QwHo8h3FYardlb3RIUNBKBFR8cWMt1nSxW1tDmlfOQENraG2DukY2qjKZMPqpzk+V5aU3PKCdyzyyb6ld7kZQtpOM8/M+nqRWTKqGUxbo2HbEyhmCrNHhN+kgwisEVc/OqwYFfbPNJHtgW/UYrFduQnGcVNbYbX5yZGAkfpTJsm3djRcGY89/vrH4bPSBMPOVHHK2+r3S35he4slbbmuF5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66899024)(26005)(38100700002)(86362001)(83380400001)(316002)(6916009)(8936002)(4326008)(8676002)(5660300002)(66946007)(66556008)(66476007)(7416002)(41300700001)(2906002)(54906003)(6506007)(6666004)(9686003)(6512007)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LqqX3xjhDTOqdf1jZk/OcJucWsgnxn1MQNfHQYCX2RbQGgt9EEKgkPPkrEsF?=
 =?us-ascii?Q?45Zab0loIqMRSqMip9vrmbGd/TKxEqYIAAjBfPk9fWXywfXaJFxoWK3jxgLa?=
 =?us-ascii?Q?N87KIYRDxYkFM3twXMF3Mx+tIkB/NdkWWfNrNzr14qB4qphpxTEy9g+5QYw2?=
 =?us-ascii?Q?7Mm47SfWIWm9SefvVN+L2CZeqQFkf6JDJACxOgjo/0saEVipM5hMTv83J/OP?=
 =?us-ascii?Q?V/52TpC2vwPd/hZvOW6pTvM4VTV4YCMBF8AJmXcq8cWHY6da5shjufK/vxmm?=
 =?us-ascii?Q?UIZawbAdLF8O74A1z7O76u6W0mtOLenZtq1P25b4ZUmVfRCCe16RNzT5Yr2N?=
 =?us-ascii?Q?KywpO0hTgCbZel/y4HTkTXWNwV1+aK8N94H14TKP+ZBz1SKDzggc2+y+jHXN?=
 =?us-ascii?Q?IdOnYl2KIrIpV5rbaoTTyJIIpuCpGSrWTIJwXwPnE6AKui117V8EA8W7hojR?=
 =?us-ascii?Q?ouJOyou8pE2NDU3DE48qjFRtMbrWIjRZUDFFMt/8ImJZbPNh+zL06TOtI1l5?=
 =?us-ascii?Q?ht0t1tddssw2oZZY0HllMrRCg4FR4eKl13FvBqgGlLkeQFpDSY+GwjRCtUIU?=
 =?us-ascii?Q?oH0D5hROpEtSwzVK1r/Bc31Vki7Hf7p4iJ5XOj+cB+DS7ydmjiW5Jg/DUdi/?=
 =?us-ascii?Q?ksJeeAtHQi+Hx3k2ZImEUvbJght35cMSS41e9maLMxgGcKs5qjNmJ2IvXbF8?=
 =?us-ascii?Q?loBPkFuFws4mIY6kLPdVRsn+wqtIJstHFAqpUwNh31qEUrZvbFvDA/vA7deP?=
 =?us-ascii?Q?1gVTPiFy70QWU7La+ItJfmcX6vYYQd4r1EfTC+YP5PF3mZ92uS6nso1K7H5L?=
 =?us-ascii?Q?MVkHzz3bUZ42Yt3Vn5i92Xep9CXZyCuCvqewfC/OFLs/Hw/LR3EmSAxLDvYn?=
 =?us-ascii?Q?ySuJuCwa7jtPIncmSdQPI0d4X2w5uhMSVtHSmt41TSnOd+XubTCblr9UmC7M?=
 =?us-ascii?Q?l8UP36u71NAYDnWJMehQBTS+KkK6jNkgAWgYVhoO8Wd3iwJC5eB5D5KZuLaF?=
 =?us-ascii?Q?3elCiY1xibm+omvKbDT6p/Xh3XEJ3ODAf+EKL+vbYVpwsZXLJxI0d4RvbH4O?=
 =?us-ascii?Q?qi8e0xlc50JsFqjZwKI1kpQHvLZAQeLJ3LEF/PddPTPxQvJPiZkvgXgtCvDj?=
 =?us-ascii?Q?53sYoUJefJ5r75opQBffVfpONOvNQQB8z2V9738Q0HN/7a1lx1HcaAdRFmrb?=
 =?us-ascii?Q?nwHFG5XLmvtUuNynZWof03QuAtBNJjTVsxuF1uPhYjOuhrIZAsDEP+jN8LiO?=
 =?us-ascii?Q?0c9VwsDsOuWtDS7o6vRbiHgLOyrXcrL63wrTXGtj0DnlMXP2Umh5vprJv2O4?=
 =?us-ascii?Q?2RwDx48xMX4ph+JHmNPNrxrCGDyHP1hyG8DWXoH99wusfo0gDAEtcURKg3vu?=
 =?us-ascii?Q?ejKjv1WbBSEQhRQLgDDNzbZFiTpcD6dvduk+wTVE7pJd5/Z4SAF8Quj15FT7?=
 =?us-ascii?Q?TT7HRPjvkq4qs6GWkYqRlZOXuWFtjxADMiS3pcvvfC5neluu3n5HL8CC0DGR?=
 =?us-ascii?Q?VTewKF4dU+lA68Vv5qiQ1F7m0zeON2cIx1HrDX+HsYxmsA1+/YLB7Ur9VYXG?=
 =?us-ascii?Q?4lgJbZDUuG7GATyTzfazrjTTIdMfxagFKhEiTqg3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814c7b67-5f46-48e7-c119-08dbebe35b0a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 05:16:33.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tT6pSJUGjaw2+w2h9rq3zRboD1UsGnZDgtY8DW0wc13gRQRdbG8E2vbDYrKtmWdv8WcEXjYmJmR92HFEiVwA8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Roberts <ryan.roberts@arm.com> writes:

> ptep_get_and_clear_full() adds a 'full' parameter which is not present
> for the fallback ptep_get_and_clear() function. 'full' is set to 1 when
> a full address space teardown is in progress. We use this information to
> optimize arm64_sys_exit_group() by avoiding unfolding (and therefore
> tlbi) contiguous ranges. Instead we just clear the PTE but allow all the
> contiguous neighbours to keep their contig bit set, because we know we
> are about to clear the rest too.
>
> Before this optimization, the cost of arm64_sys_exit_group() exploded to
> 32x what it was before PTE_CONT support was wired up, when compiling the
> kernel. With this optimization in place, we are back down to the
> original cost.
>
> This approach is not perfect though, as for the duration between
> returning from the first call to ptep_get_and_clear_full() and making
> the final call, the contpte block in an intermediate state, where some
> ptes are cleared and others are still set with the PTE_CONT bit. If any
> other APIs are called for the ptes in the contpte block during that
> time, we have to be very careful. The core code currently interleaves
> calls to ptep_get_and_clear_full() with ptep_get() and so ptep_get()
> must be careful to ignore the cleared entries when accumulating the
> access and dirty bits - the same goes for ptep_get_lockless(). The only
> other calls we might resonably expect are to set markers in the
> previously cleared ptes. (We shouldn't see valid entries being set until
> after the tlbi, at which point we are no longer in the intermediate
> state). Since markers are not valid, this is safe; set_ptes() will see
> the old, invalid entry and will not attempt to unfold. And the new pte
> is also invalid so it won't attempt to fold. We shouldn't see this for
> the 'full' case anyway.
>
> The last remaining issue is returning the access/dirty bits. That info
> could be present in any of the ptes in the contpte block. ptep_get()
> will gather those bits from across the contpte block. We don't bother
> doing that here, because we know that the information is used by the
> core-mm to mark the underlying folio as accessed/dirty. And since the
> same folio must be underpinning the whole block (that was a requirement
> for folding in the first place), that information will make it to the
> folio eventually once all the ptes have been cleared. This approach
> means we don't have to play games with accumulating and storing the
> bits. It does mean that any interleaved calls to ptep_get() may lack
> correct access/dirty information if we have already cleared the pte that
> happened to store it. The core code does not rely on this though.

Does not *currently* rely on this. I can't help but think it is
potentially something that could change in the future though which would
lead to some subtle bugs.

Would there be any may of avoiding this? Half baked thought but could
you for example copy the access/dirty information to the last (or
perhaps first, most likely invalid) PTE?

 - Alistair

> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 18 +++++++++--
>  arch/arm64/mm/contpte.c          | 54 ++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 9bd2f57a9e11..ea58a9f4e700 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1145,6 +1145,8 @@ extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
>  extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
>  extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>  				pte_t *ptep, pte_t pte, unsigned int nr);
> +extern pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep);
>  extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep);
>  extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
> @@ -1270,12 +1272,24 @@ static inline void pte_clear(struct mm_struct *mm,
>  	__pte_clear(mm, addr, ptep);
>  }
>  
> +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
> +static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep, int full)
> +{
> +	pte_t orig_pte = __ptep_get(ptep);
> +
> +	if (!pte_valid_cont(orig_pte) || !full) {
> +		contpte_try_unfold(mm, addr, ptep, orig_pte);
> +		return __ptep_get_and_clear(mm, addr, ptep);
> +	} else
> +		return contpte_ptep_get_and_clear_full(mm, addr, ptep);
> +}
> +
>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  				unsigned long addr, pte_t *ptep)
>  {
> -	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
> -	return __ptep_get_and_clear(mm, addr, ptep);
> +	return ptep_get_and_clear_full(mm, addr, ptep, 0);
>  }
>  
>  #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 426be9cd4dea..5d1aaed82d32 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -144,6 +144,14 @@ pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
>  	for (i = 0; i < CONT_PTES; i++, ptep++) {
>  		pte = __ptep_get(ptep);
>  
> +		/*
> +		 * Deal with the partial contpte_ptep_get_and_clear_full() case,
> +		 * where some of the ptes in the range may be cleared but others
> +		 * are still to do. See contpte_ptep_get_and_clear_full().
> +		 */
> +		if (pte_val(pte) == 0)
> +			continue;
> +
>  		if (pte_dirty(pte))
>  			orig_pte = pte_mkdirty(orig_pte);
>  
> @@ -256,6 +264,52 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>  }
>  EXPORT_SYMBOL(contpte_set_ptes);
>  
> +pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
> +					unsigned long addr, pte_t *ptep)
> +{
> +	/*
> +	 * When doing a full address space teardown, we can avoid unfolding the
> +	 * contiguous range, and therefore avoid the associated tlbi. Instead,
> +	 * just get and clear the pte. The caller is promising to call us for
> +	 * every pte, so every pte in the range will be cleared by the time the
> +	 * tlbi is issued.
> +	 *
> +	 * This approach is not perfect though, as for the duration between
> +	 * returning from the first call to ptep_get_and_clear_full() and making
> +	 * the final call, the contpte block in an intermediate state, where
> +	 * some ptes are cleared and others are still set with the PTE_CONT bit.
> +	 * If any other APIs are called for the ptes in the contpte block during
> +	 * that time, we have to be very careful. The core code currently
> +	 * interleaves calls to ptep_get_and_clear_full() with ptep_get() and so
> +	 * ptep_get() must be careful to ignore the cleared entries when
> +	 * accumulating the access and dirty bits - the same goes for
> +	 * ptep_get_lockless(). The only other calls we might resonably expect
> +	 * are to set markers in the previously cleared ptes. (We shouldn't see
> +	 * valid entries being set until after the tlbi, at which point we are
> +	 * no longer in the intermediate state). Since markers are not valid,
> +	 * this is safe; set_ptes() will see the old, invalid entry and will not
> +	 * attempt to unfold. And the new pte is also invalid so it won't
> +	 * attempt to fold. We shouldn't see this for the 'full' case anyway.
> +	 *
> +	 * The last remaining issue is returning the access/dirty bits. That
> +	 * info could be present in any of the ptes in the contpte block.
> +	 * ptep_get() will gather those bits from across the contpte block. We
> +	 * don't bother doing that here, because we know that the information is
> +	 * used by the core-mm to mark the underlying folio as accessed/dirty.
> +	 * And since the same folio must be underpinning the whole block (that
> +	 * was a requirement for folding in the first place), that information
> +	 * will make it to the folio eventually once all the ptes have been
> +	 * cleared. This approach means we don't have to play games with
> +	 * accumulating and storing the bits. It does mean that any interleaved
> +	 * calls to ptep_get() may lack correct access/dirty information if we
> +	 * have already cleared the pte that happened to store it. The core code
> +	 * does not rely on this though.
> +	 */
> +
> +	return __ptep_get_and_clear(mm, addr, ptep);
> +}
> +EXPORT_SYMBOL(contpte_ptep_get_and_clear_full);
> +
>  int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>  					unsigned long addr, pte_t *ptep)
>  {

