Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFB88098BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjLHBpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjLHBpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:45:46 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0D610E3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:45:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fq3hTw6arBOrRf0R9rov2qX/vNL9aAf6GQ2FOxqk41JBdGBIed9hPypsY4Ezd+Aaf9myEEBIL4WfraFfngUnhB2N2zzxbvYwmXk0WYhmYZveDCYmhfear9FqRpeZJ0N7ttLBsZTXBhP9MCRRQBDMoxd3SvX1drzb7WOD46xIZo6btQVzkzv3OJv+PGO7z1CiBpIsTwvyY/HXWXSOEwSUcoJNbxbcxYPymVgyf1IKy6RTD2fOIDivUvL49Ml/3GzHLIQ7NNVeAib2ugTk+hokxFnpdG9b3L6BxKH/99Sdqj+PQgUpDVXnnc4BOce9RSBLSel4AEIyM0YSwya4pNEBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNNcK1hu3dUEctH5yCCDcgZcmfNojAFFjGDNpSSP3uQ=;
 b=kaKap7DpH1qyYccEGukwBnA9vLp8n0ztZyjaAqm+BmZucnYTa/iOmAdf2D2ldCkdGEIOLBiKc8FVsAZkqai6FfxuC5R9jUelEEgQUrFkkm653VP9ih5vbbx8PlutYL5NUxJ1vlTM9OJ1UdiUaaG6e+M2j4c3T8w/OJq1CGKuHDd2+et67u67eu/iRfjR/bMH5WLGbKnYkml8qSkUUJAmqd55SIm4QlzCiEzRh2nzx7rCOMAF8kDvHzIDsIAkzJVyiyLRNR9LTbLFW/hA2oeWcX9ld3mE4CYBHS83BMD/gFlBF9yZbbRr2pdvSHyTfKVncc+v6ozXeViQawbUchXvvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNNcK1hu3dUEctH5yCCDcgZcmfNojAFFjGDNpSSP3uQ=;
 b=CdopbAEbY0sHDTdGtQOtvkrQ14UE9ehxxoypHYKUGAngnQ4W4lu9fwIzY54UmUkvAjgbdNR/m2uCyJd0l9rg3KDBejoumB5gY92+db6NoJv+/VdQCqoVWWoa1qgwsmryWmd0xJ3N39iTV593FihWePOXjWO5gPWndHsziqQBWEgtufdUf8bVE/Cr6A3nGVz4IzTfySR6ZPn/fXjVKG0Nr0HDfmhyxXTqlP1vnSeKR25rb5rHil462lrM6Atml2CedY5uM4nESzXyE1cvb/NrzmqpYVcjuL52VoZ/S7LBkZ56Evk0/t3h9nzxa7rIKdRGPSIpSREV3kokV961vZ6Gdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 01:45:46 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 01:45:46 +0000
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-16-ryan.roberts@arm.com>
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
        Barry Song <21cnbao@gmail.com>, Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/15] arm64/mm: Implement clear_ptes() to optimize
 exit()
Date:   Fri, 08 Dec 2023 12:45:27 +1100
In-reply-to: <20231204105440.61448-16-ryan.roberts@arm.com>
Message-ID: <878r65a2m2.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:10:111::14) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ac789a-253a-40f9-b9e3-08dbf78f65bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qa2WZwifQbCEgqc2B0B5px7Xca4g/oCWMJZ0eAsY/sLVrvt81/YYlWOi00E1QTBzwwBOwTU5TCHNXMhk63wko8vGt0jNIkobb8AmV/ivpFXUL5tkGiT6y+aN55mnTFA1UmDcPzQH59yClwtipMaXbbWvn5GfG+vLxz1Mfkob6RIa34FxBGYvVMh1K7PYdmFuiSSZ98CagYtNFeVKwJmi9VB+bUGhtsCph3p2VK92A+fmQghTIuNN86JVJtS+r/dSLksYW0Oc5G+gQNGXQGgLGeExFivi/UuoaB1eEMPR28HI5IMp1mItoU/CnOkVBWwR1qjGBjUOLiMaC2KRvq9gwqBpNz0FAkyRE3y1GfxM5c5Z6MBhuNerpaLehBUpc0DItenLZxn9pIZsMbTUg9DINafF/nJQbK39MafOX9vrXWEH9i7oGtRiR7H3SeCUt1XWnEIeDmp91JO3Zehqb6ZfxRZBEoN+Uz7lyVCK2yJetDo0BOLrknpFpHvQ8PIZM2Oa7oAzanqxcYqFEeZGZjGYOWsJOJPMHDX/Zfquhp0PYh7O4o0cE6DJNpojs2IOhbEo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(4326008)(5660300002)(6506007)(6666004)(6512007)(9686003)(7416002)(2906002)(6486002)(478600001)(8676002)(8936002)(6916009)(54906003)(66556008)(66476007)(66946007)(316002)(41300700001)(38100700002)(86362001)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iHhhQhuDBqA4q2XUWFDpHGqyxHod/2jSQIcbC2bsQr471XJ5FuMscIoDNLwi?=
 =?us-ascii?Q?FuKm9qFyD92dmIk8+GpjIK5SAWlsEUzXZnec8tlkQ7MLFnOwXr9ByJ3LVzuk?=
 =?us-ascii?Q?cvvbTXwcTpgJRmJ+nMNFfIHC1ARPDFFdt9UQ5f/vacU3Aui0MB9fduvoZpFv?=
 =?us-ascii?Q?CUoH5RNtpX59J8kLppALqyiI5RbYG2PJXi4HV21GHbhU8BvoxarKX2UVz/Wd?=
 =?us-ascii?Q?InCUEIO4B/XJOWCqazeMatf+zDUrB2mGaH+gOOeppuwYILLsq2Wc9jwlMsWm?=
 =?us-ascii?Q?pbdREwHt+789vq2Wc8Uy93lnwohRog6/65Cof5mL7YQyLNBdcU/5nYCoGBXR?=
 =?us-ascii?Q?F4k9vtSSoF3qUSLHbykBXGuxF4t+5nNstMz4hOFOtm7lIHsFzURlRAGnD6fD?=
 =?us-ascii?Q?GKhQtR4F1J7WKsJcQxfosJSPoJKGQrEW6aeABgC5qoFOwvoRpa5IjKv+imDS?=
 =?us-ascii?Q?Pkv2+ncA7mAiCVLQvXfgsC6yx1x6UqZr6mX23S1YMKkcaK3kfNbbpHa+HoLT?=
 =?us-ascii?Q?6BOaeSvB1APxAtxKITy53SZF5H15H25q2GAKC8mcUrWC04o/U3T4cK3tTXk3?=
 =?us-ascii?Q?xVPkOA27xEIOw09FMo/1g5tqrHhrxyF6frB9KWrHrUxt0As6Kiioz0KJgLCi?=
 =?us-ascii?Q?JrPX5Ve2Z7S6Hjrlo8ijK4WYom7VYLCMDpf4xs5qLDh5PSbHxhOEULvsO/95?=
 =?us-ascii?Q?AngbUBm8rnAFR0sG4ajdce4/FmRs925ZgTx5BhpEpV74YJ3dvEVIK5Pbk/Sx?=
 =?us-ascii?Q?8cFSsP/EdvS6RM+9QTl8Qs/spyxdSxGPDmQQUhW70nOEVRVXnswXimFqFVRH?=
 =?us-ascii?Q?4rvQmLr0LRu4/9peHc/Q55GdDkYlyEYecBuENTpPLpiflsmYE9pnLzS9tVgI?=
 =?us-ascii?Q?7StFX56ErE0E009nPBYa8jYAHyYjLzqFj3v4M5g/3XAR4X+ejK0U0fhb6AH3?=
 =?us-ascii?Q?XRuQvbt/SCfeu1u/GpnUJ9R49I101SnXSNeTZ1fFmIJ7RPXIc/ulsr7Ea5qA?=
 =?us-ascii?Q?nDXBUxWUoR2MxlWseV9eqadxEomvegMwbwfuE3kU6hhiyt8oFALyeR+4nBz/?=
 =?us-ascii?Q?CjWVBj6cRYx+pJt1lv1MaZfHWzoD/d2PAL3gp6LXqN/WwFhBe+NeRuzC/q+z?=
 =?us-ascii?Q?FiY4YIoxNvqjCLzE8Cb6c4izPDoJVL/rbgYom9GqjwXd7vV+Tv64gA5Iz7vo?=
 =?us-ascii?Q?oWUPU6tJNStEFu6bucmOggZDb+3cQBzzPFHEUAzyYJcl3dgW6SkY7bf8xejd?=
 =?us-ascii?Q?AMRRdDpqnxknJw/zmBwMLmKV8oTuec4B6kCag3YHuXV+WoEZtwYD0nmhcyqS?=
 =?us-ascii?Q?J1VLj0fPomUYLdiAQIhjhBEhSheA2I0YFKb0uxqnrT5wjdDs1Efmn2lxS+B+?=
 =?us-ascii?Q?caEpRvrWCS/BM0cCU6k5npMbEnUzPKsGqyCcsBxOmQPgQpChPwecgEtD7e4i?=
 =?us-ascii?Q?Yt0k6c9TGmbUBbdvpFlrFsi/8dzFNT6x+OVC1sHJPXe4W5za/SjuQbL3zGoN?=
 =?us-ascii?Q?yvKOcPHYgx06a6L9EuPmxC1I+Zs66IhLut8tY5GAVVPN7KtSdxIbgrbiuTZs?=
 =?us-ascii?Q?2ayzoRPLqOOIWxmykMG6pF6RCD+Tsy4DY/57cIKw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ac789a-253a-40f9-b9e3-08dbf78f65bf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 01:45:46.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vobk3UojQcGoZoKdd7moEkOPwb4TjUvKrlRFl5CqeV7vusvIuUHgOM0wXKqyvxN7sdb8RyrjKXW/+7tAjv+y0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Roberts <ryan.roberts@arm.com> writes:

> With the core-mm changes in place to batch-clear ptes during
> zap_pte_range(), we can take advantage of this in arm64 to greatly
> reduce the number of tlbis we have to issue, and recover the lost exit
> performance incured when adding support for transparent contiguous ptes.
>
> If we are clearing a whole contpte range, we can elide first unfolding
> that range and save the tlbis. We just clear the whole range.
>
> The following shows the results of running a kernel compilation workload
> and measuring the cost of arm64_sys_exit_group() (which at ~1.5% is a
> very small part of the overall workload).
>
> Benchmarks were run on Ampere Altra in 2 configs; single numa node and 2
> numa nodes (tlbis are more expensive in 2 node config).
>
>  - baseline: v6.7-rc1 + anonfolio-v7
>  - no-opt: contpte series without any attempt to optimize exit()
>  - simple-ptep_get_clear_full: simple optimization to exploit full=1.
>    ptep_get_clear_full() does not fully conform to its intended semantic
>  - robust-ptep_get_clear_full: similar to previous but
>    ptep_get_clear_full() fully conforms to its intended semantic
>  - clear_ptes: optimization implemented by this patch
>
> | config                     | numa=1 | numa=2 |
> |----------------------------|--------|--------|
> | baseline                   |     0% |     0% |
> | no-opt                     |   190% |   768% |
> | simple-ptep_get_clear_full |     8% |    29% |
> | robust-ptep_get_clear_full |    21% |    19% |
> | clear_ptes                 |    13% |     9% |
>
> In all cases, the cost of arm64_sys_exit_group() increases; this is
> anticipated because there is more work to do to tear down the page
> tables. But clear_ptes() gives the smallest increase overall.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 32 ++++++++++++++++++++++++
>  arch/arm64/mm/contpte.c          | 42 ++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 9bd2f57a9e11..ff6b3cc9e819 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1145,6 +1145,8 @@ extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
>  extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
>  extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>  				pte_t *ptep, pte_t pte, unsigned int nr);
> +extern pte_t contpte_clear_ptes(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, unsigned int nr);
>  extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep);
>  extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
> @@ -1270,6 +1272,36 @@ static inline void pte_clear(struct mm_struct *mm,
>  	__pte_clear(mm, addr, ptep);
>  }
>  
> +#define clear_ptes clear_ptes
> +static inline pte_t clear_ptes(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep, int full,
> +				unsigned int nr)
> +{
> +	pte_t pte;
> +
> +	if (!contpte_is_enabled(mm)) {

I think it would be better to call the generic definition of
clear_ptes() here. Obviously that won't exist if clear_ptes is defined
here, but you could alcall it __clear_ptes() and #define clear_ptes
__clear_ptes when the arch specific helper isn't defined.

> +		unsigned int i;
> +		pte_t tail;
> +
> +		pte = __ptep_get_and_clear(mm, addr, ptep);
> +		for (i = 1; i < nr; i++) {
> +			addr += PAGE_SIZE;
> +			ptep++;
> +			tail = __ptep_get_and_clear(mm, addr, ptep);
> +			if (pte_dirty(tail))
> +				pte = pte_mkdirty(pte);
> +			if (pte_young(tail))
> +				pte = pte_mkyoung(pte);
> +		}
> +	} else if (nr == 1) {
> +		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
> +		pte = __ptep_get_and_clear(mm, addr, ptep);
> +	} else
> +		pte = contpte_clear_ptes(mm, addr, ptep, nr);
> +
> +	return pte;
> +}
> +
>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  				unsigned long addr, pte_t *ptep)
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 2a57df16bf58..34b43bde3fcd 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -257,6 +257,48 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>  }
>  EXPORT_SYMBOL(contpte_set_ptes);
>  
> +pte_t contpte_clear_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
> +					unsigned int nr)
> +{
> +	/*
> +	 * If we cover a partial contpte block at the beginning or end of the
> +	 * batch, unfold if currently folded. This makes it safe to clear some
> +	 * of the entries while keeping others. contpte blocks in the middle of
> +	 * the range, which are fully covered don't need to be unfolded because
> +	 * we will clear the full block.
> +	 */
> +
> +	unsigned int i;
> +	pte_t pte;
> +	pte_t tail;
> +
> +	if (ptep != contpte_align_down(ptep) || nr < CONT_PTES)
> +		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
> +
> +	if (ptep + nr != contpte_align_down(ptep + nr))
> +		contpte_try_unfold(mm, addr + PAGE_SIZE * (nr - 1),
> +				   ptep + nr - 1,
> +				   __ptep_get(ptep + nr - 1));
> +
> +	pte = __ptep_get_and_clear(mm, addr, ptep);
> +
> +	for (i = 1; i < nr; i++) {
> +		addr += PAGE_SIZE;
> +		ptep++;
> +
> +		tail = __ptep_get_and_clear(mm, addr, ptep);
> +
> +		if (pte_dirty(tail))
> +			pte = pte_mkdirty(pte);
> +
> +		if (pte_young(tail))
> +			pte = pte_mkyoung(pte);
> +	}
> +
> +	return pte;
> +}
> +EXPORT_SYMBOL(contpte_clear_ptes);
> +
>  int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>  					unsigned long addr, pte_t *ptep)
>  {

