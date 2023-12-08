Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30028098AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444223AbjLHBjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjLHBi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:38:58 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284921712
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:39:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO1/6tEDfsli91CMVJpbEHkcIiWbum6Nb/6kb7BY3MDVUfS21sOda2k8gcDhqlT1H/Zxaq4y0Qe2KZRT5IKI/WxZ6F4FYNey3lTemi4CT8RO9mPDiE6LDIHCNSBd/oznHLVCdI94quCzCrBfSaOZqNN4b48hm1E6fcrfZ9Rk5ttnW5m0JZPRrJTJcBtSakzi5xqenvZgSkFdY0Kz8193hk5OcrAaKPwdw5CtqXZVPHoHhvpcQrfW+dyqflL5Mn40M7EhtQottSSUkh2qwVEPwBaREvR+JVk1Fs0hTu3ZnFYGSPuo+PpaZRF3ztdGXQYWY6eh4EKBXgLJM37FjOYzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+OXwpZtxyaCJv4MFC20l5pbMc7D5W4w1I3CP6dcUDM=;
 b=QD91uuj2sJ5mEKlkspBvtmkUNQYchSZvNc8okoDBNhguNDGL3IsZVYmknjQlh8urXe/HHcuqM7AIfviIF78cpCd4F8wNunBP2Nxh7FV5iZw2/jLOBCJe08cJdwaE4Cc6TD3YUgrrhJ1TwBQMrPraHbDcPFerx0QkEQRGaujTYgzIguwRehGv9B8+Ug/vtc2H/ywOmXQDTlxnmkiIFx33EDDF/Ekmnz8eLUfqHpO9Q8DtaBeZTqUzT5nP0o/xxvtQlFnt1QYwiT/rwo4cvcmz22dow2/AEDEScClUWlf1wKGQ1j4JTpM4dtdXtu4QA26PQmvA+1feC0RwK/knAuAmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+OXwpZtxyaCJv4MFC20l5pbMc7D5W4w1I3CP6dcUDM=;
 b=DdsapQRSToI/TaZQBk5SAVj7RTO5Tb1fVyjR7+yI3u4RbGfLOk1YOwpAAt01Ep8aAAUmZDyKxXeDSFGcp1PXMF+ADT3njI5q5VbDCobqnC8f0MwbIePZqNTI6Pw73Si9dbttdQgSGR86SixX1wMk8LDCrWJPxi6FfNZOcbtglTEZ5g02wtqap65br0Do/NEz3Rttv2RHylDZ+QD/HXX6qZF9YZEMHX2SYaDLwdOYf4CR0p9t3fmLJ4UjxbtZ8lXG6kxEv8h0F1lj3w6ucULFChv8BkTxomDO1/unRGEi4t4phE9qwCDDQh42CUPgS6DWEMYhc4pbHTRXgYwZ9vDw7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 01:39:01 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 01:39:01 +0000
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-15-ryan.roberts@arm.com>
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
Subject: Re: [PATCH v3 14/15] arm64/mm: Implement ptep_set_wrprotects() to
 optimize fork()
Date:   Fri, 08 Dec 2023 12:37:32 +1100
In-reply-to: <20231204105440.61448-15-ryan.roberts@arm.com>
Message-ID: <87cyvha2xd.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYCP282CA0005.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::17) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DM4PR12MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efbac67-e87d-476d-8f3f-08dbf78e73b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ryW/E2iZI6cesFLY9UogDGJGiiVLStk04Pm0WvToxqkfDJNAJ9SsYYKQM5zPYKHBMbgTKjZWITppbDnF1Ycgmq7XsHlsrnJZ36GbVC+raqKwSTqAQv9JdUNMWCwvMpu0S/qRJlgQ7mTB6Tpv99O0GmxIQYwOvY8R9UzCEQ8hLCJZkXFvFOMlrwG1s0EdTnuT8wf7G98aTSJZbaTaVq80823xd6F9vduHgKXBx8INvUj8boNVjDjh8KQYlpiKUhszbWkwX9QwtezEvhv0vNxXzp98tziJJhildEsbqn5fUBI8IH51TwA1T3AsEYCKQqzOOvh6FayyweBt04mr7rw17m44XXzHGPgKGjXv8SqgA2tRYjBIQ1T+AA6ujOlX8gJxiQSfJsJ0qvFbE3N77N556p90oDWzVwW4H4RTEsfjPdNCjKyLWFhDZg2s9igG+3GmvO06nCTbRJ5aIqj2vj9A2kPGxCwOazaWH8hAxFjc5UPBOl8OseHA9uFhAoh6byBFAd41oHEREnoZOnYAN5mSJXXi3xXMcrGE2G/Vqstr196gHWIlpHy4mnbyBG2OQ/19/iqmkMwojWvaBGFSyd8xXDq3TUWQ8UNRrjhxfdchxqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(7416002)(8936002)(4326008)(8676002)(5660300002)(316002)(66556008)(66476007)(54906003)(66946007)(6916009)(966005)(6486002)(6512007)(9686003)(6506007)(26005)(6666004)(41300700001)(478600001)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KF5C2Zd5VtACsN+OTkDlF9rhdnnco4egA4JMAKgnMCDDSjzVGVOUwuwyCZWB?=
 =?us-ascii?Q?UHTeSnL17Z2Zk7seUM8SlpXWReWXGi01C67q2rwJ1gKX5ousCabEvR17UqZ4?=
 =?us-ascii?Q?8LUtLElo7PogTJIevVNtPNxwpHJCN+oIQY72O3MWyIXs+iWC8nwC6JBM/oAK?=
 =?us-ascii?Q?48qto+LI221rldC03zl8LRPjygqbxRPk0aEeZc0xoX9+oXPUi+uKnUqNl81c?=
 =?us-ascii?Q?7oNF45Dzb87XIyBPdkddbnDz4sC8ABdMVyDBjTjV34fO3e2juk1/KCZZDKs5?=
 =?us-ascii?Q?RWFh1gA5L0qCstIyLCbGof5kHUIzLWZuORvzF37MGfCT/zBU4ZbmO4fulgYE?=
 =?us-ascii?Q?HHFToVL/ywlEo7uzeDK7/ReqbRBS1bMZmPgta4QXQy1bXFV1WxQVgDticnGq?=
 =?us-ascii?Q?24VQ3fDzlGp5fhiYigSmo0qTQQWQI3d1foFaGQBF5dLwjwIS3NSaDbL+++Bi?=
 =?us-ascii?Q?UosSORG6/r17SlBRAmKVby7EJ0OHxxYy6UsRQjGaS9WOrVwzchC34M97Nb5T?=
 =?us-ascii?Q?/o7OkPa7VmKWAK98JcEBJhyn2fxGd16daffk+/Kvpm8v9io+SfD5UjxUlAjx?=
 =?us-ascii?Q?SB4L2JN1OuJBwioivloqVvV8GyhCvFH79QXXOUEAEnj8dsfcUsltvuMpttv9?=
 =?us-ascii?Q?BY3PDT3/xj9pSFT4ZjMcwez594BCt+cVxT6YpR3aIsn0+kkgZs/1K0Be+zez?=
 =?us-ascii?Q?ppIQIE7vWLr98H2oYxsNZstH5fyQYC6ZijDje1VvWWPrLxCPpDXaPx1Q1eAJ?=
 =?us-ascii?Q?3qzyzk11EL+kXTVSnLVGsPaqxMrrJK/GGVfk+fxzNrua3cLbrbY9nuOFCkMU?=
 =?us-ascii?Q?4ZSWaxEgk/m8ldhDvfNbClnx1RuFZ9D3syLrzgcGQNJhtS6GOP/Ig2hRV56G?=
 =?us-ascii?Q?yjprAKQpXnnBh36H3/JIhJj9QRUk6zJGxSJPGKLhvfIxNQLo8zP00JdxBLoR?=
 =?us-ascii?Q?JfcXDvQClKygDmNq4rAOJuaHpgEcWW68HxdsyssyhkmSDJGlZ8yOCuOgJtkh?=
 =?us-ascii?Q?lY+60aM9fFGKzM538s6AN5mD+7rJm3fM2Pu0L1BzJoQ+sbKrA+HaoXyu3fWA?=
 =?us-ascii?Q?owEWGNYGGf+z2G2BmkUB/akT5kpI3my8Q7d8mQ1f07DQO1w4spsZuOkSjFX8?=
 =?us-ascii?Q?xywveUsTJBPI9Hnw/HTwnS6I/n2Twy+H5JXwsb5kOCtJI2pI8FNw/R6+M8+3?=
 =?us-ascii?Q?GI6+xKJSQWcNqaP2/Nd54BAqI25dilNLFU1c/bsxHNVwvAqLhRa8hymgkduX?=
 =?us-ascii?Q?UivsdmpbysqqAJmf6TUOgDN2+KYnCVE02C31hR1WOnRwidUjV6XE6YnIgTK8?=
 =?us-ascii?Q?4v13V1+jftx0wzWbBGcBuKtqFyVbUQTZs2ENX9D+kAbQIbUnQaDx4DivoZj9?=
 =?us-ascii?Q?JAX8psZ2+T5KJdkzqpx6Yr3ki4emRUSASzGC9jZwOaSVyXDQvoYj696NpAsS?=
 =?us-ascii?Q?z5Tmr5LLjVFnM2NqC1e8z9+gZwL+CtfxDUkFo9GfP/fEbhMVU9iyXsvCXfoY?=
 =?us-ascii?Q?5s4biU1dThJGbY9SGEbce3/YNNmwZxVwRpR1Tth18vaCVypn7rQRpZgxn4Xv?=
 =?us-ascii?Q?0p9JrNu+d7Agz1Cpye25u06tcBuEC2LGPnZcv3ib?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efbac67-e87d-476d-8f3f-08dbf78e73b5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 01:39:00.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBpDgQTPQ0vg3o+cOLMW9RZ+2O76qIWQtiFQw4Dy5kQvdwF4PNtvTquTm461dKWK8Ct5d+Bw+ysMv9aiQu5xIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
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

> With the core-mm changes in place to batch-copy ptes during fork, we can
> take advantage of this in arm64 to greatly reduce the number of tlbis we
> have to issue, and recover the lost fork performance incured when adding
> support for transparent contiguous ptes.
>
> If we are write-protecting a whole contig range, we can apply the
> write-protection to the whole range and know that it won't change
> whether the range should have the contiguous bit set or not. For ranges
> smaller than the contig range, we will still have to unfold, apply the
> write-protection, then fold if the change now means the range is
> foldable.
>
> This optimization is possible thanks to the tightening of the Arm ARM in
> respect to the definition and behaviour when 'Misprogramming the
> Contiguous bit'. See section D21194 at
> https://developer.arm.com/documentation/102105/latest/
>
> Performance tested with the following test written for the will-it-scale
> framework:
>
> -------
>
> char *testcase_description = "fork and exit";
>
> void testcase(unsigned long long *iterations, unsigned long nr)
> {
> 	int pid;
> 	char *mem;
>
> 	mem = malloc(SZ_128M);
> 	assert(mem);
> 	memset(mem, 1, SZ_128M);
>
> 	while (1) {
> 		pid = fork();
> 		assert(pid >= 0);
>
> 		if (!pid)
> 			exit(0);
>
> 		waitpid(pid, NULL, 0);
>
> 		(*iterations)++;
> 	}
> }
>
> -------
>
> I see huge performance regression when PTE_CONT support was added, then
> the regression is mostly fixed with the addition of this change. The
> following shows regression relative to before PTE_CONT was enabled
> (bigger negative value is bigger regression):
>
> |   cpus |   before opt |   after opt |
> |-------:|-------------:|------------:|
> |      1 |       -10.4% |       -5.2% |
> |      8 |       -15.4% |       -3.5% |
> |     16 |       -38.7% |       -3.7% |
> |     24 |       -57.0% |       -4.4% |
> |     32 |       -65.8% |       -5.4% |
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 30 ++++++++++++++++++++---
>  arch/arm64/mm/contpte.c          | 42 ++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 15bc9cf1eef4..9bd2f57a9e11 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -984,6 +984,16 @@ static inline void __ptep_set_wrprotect(struct mm_struct *mm,
>  	} while (pte_val(pte) != pte_val(old_pte));
>  }
>  
> +static inline void __ptep_set_wrprotects(struct mm_struct *mm,
> +					unsigned long address, pte_t *ptep,
> +					unsigned int nr)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++)
> +		__ptep_set_wrprotect(mm, address, ptep);
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_PMDP_SET_WRPROTECT
>  static inline void pmdp_set_wrprotect(struct mm_struct *mm,
> @@ -1139,6 +1149,8 @@ extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep);
>  extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep);
> +extern void contpte_set_wrprotects(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, unsigned int nr);
>  extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep,
>  				pte_t entry, int dirty);
> @@ -1290,13 +1302,25 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>  	return contpte_ptep_clear_flush_young(vma, addr, ptep);
>  }
>  
> +#define ptep_set_wrprotects ptep_set_wrprotects
> +static inline void ptep_set_wrprotects(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, unsigned int nr)
> +{
> +	if (!contpte_is_enabled(mm))
> +		__ptep_set_wrprotects(mm, addr, ptep, nr);
> +	else if (nr == 1) {

Why do we need the special case here? Couldn't we just call
contpte_set_wrprotects() with nr == 1?

> +		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
> +		__ptep_set_wrprotects(mm, addr, ptep, 1);
> +		contpte_try_fold(mm, addr, ptep, __ptep_get(ptep));
> +	} else
> +		contpte_set_wrprotects(mm, addr, ptep, nr);
> +}
> +
>  #define __HAVE_ARCH_PTEP_SET_WRPROTECT
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>  				unsigned long addr, pte_t *ptep)
>  {
> -	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
> -	__ptep_set_wrprotect(mm, addr, ptep);
> -	contpte_try_fold(mm, addr, ptep, __ptep_get(ptep));
> +	ptep_set_wrprotects(mm, addr, ptep, 1);
>  }
>  
>  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index e079ec61d7d1..2a57df16bf58 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -303,6 +303,48 @@ int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
>  }
>  EXPORT_SYMBOL(contpte_ptep_clear_flush_young);
>  
> +void contpte_set_wrprotects(struct mm_struct *mm, unsigned long addr,
> +					pte_t *ptep, unsigned int nr)
> +{
> +	unsigned long next;
> +	unsigned long end = addr + (nr << PAGE_SHIFT);
> +
> +	do {
> +		next = pte_cont_addr_end(addr, end);
> +		nr = (next - addr) >> PAGE_SHIFT;
> +
> +		/*
> +		 * If wrprotecting an entire contig range, we can avoid
> +		 * unfolding. Just set wrprotect and wait for the later
> +		 * mmu_gather flush to invalidate the tlb. Until the flush, the
> +		 * page may or may not be wrprotected. After the flush, it is
> +		 * guarranteed wrprotected. If its a partial range though, we
> +		 * must unfold, because we can't have a case where CONT_PTE is
> +		 * set but wrprotect applies to a subset of the PTEs; this would
> +		 * cause it to continue to be unpredictable after the flush.
> +		 */
> +		if (nr != CONT_PTES)
> +			contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
> +
> +		__ptep_set_wrprotects(mm, addr, ptep, nr);
> +
> +		addr = next;
> +		ptep += nr;
> +
> +		/*
> +		 * If applying to a partial contig range, the change could have
> +		 * made the range foldable. Use the last pte in the range we
> +		 * just set for comparison, since contpte_try_fold() only
> +		 * triggers when acting on the last pte in the contig range.
> +		 */
> +		if (nr != CONT_PTES)
> +			contpte_try_fold(mm, addr - PAGE_SIZE, ptep - 1,
> +					 __ptep_get(ptep - 1));
> +
> +	} while (addr != end);
> +}
> +EXPORT_SYMBOL(contpte_set_wrprotects);
> +
>  int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  					unsigned long addr, pte_t *ptep,
>  					pte_t entry, int dirty)

