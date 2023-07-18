Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A339F757EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjGROER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjGRODm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:03:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239521FE1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB3fJDw7HLN6vkEVH7SrVjzyxsJlxhCgJXvYDCyp33YRaPgIyXnBBETL8EBzSVN13AKE0qdvqCmJAyFYuFzfeluB1l1fEIJ8jZUILgeNa3Pd/q8btW5/k6pA8ksyxHQJYAM0tY4AjdbJrzXOAbDW9GWzKBMK0ucn26kd+BhcA63GRsHot6r/xHO6qYV/mJqaU9NeCAlOYZHHizAVhLuXAMD+KPDPlCQ9AWl7xtQ3atxyzwHvOGXPIsU4ORrlvl0v4qROwUD29cV8BtKkZykQjAM+7wKUR8dHH5yIlpURKEvA8250Qyxnv0t7Lr/2SLRsacwFvvTE9xNo7TUu/cOaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQjeh5OUBeMFIoWyXIIWR980xnRKadm09v53+YYdLuA=;
 b=GWDtzQK7MQdGJWis+CUZRDUJfJEjD71KNgSQWSo3KsSELPB5SCNoHyz89qqzRSabpDmmCevWV0l7oxtcPD1eUSiC7jqdx7ufm4FQ49Pe6Fv6RIqxGkZfC3mOibuxU37lVLfWGJC1NIBbGg6dxf3uvRirJHaHdIjRdypa15/CZIfYAjL0dIxdVVU01AjfEl04m7OWzfSD+Mg4rmRTNeqVoMvgj2kW7+/GcJnyh1TPAKFg9sX7DuzuVjDKCusKWdP4b/UyWcL6zCheuASz5FDJQ9UqhyW0EEO6e+LHDaBAXNcjg9Sb8lY/sYA48lRgaUJQFGzaXQK5O0mjInholpvSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQjeh5OUBeMFIoWyXIIWR980xnRKadm09v53+YYdLuA=;
 b=KHv1dIhbiTSHhPhCsP9HlqpkHb+uZ5Wyn5KLSD139TtBHoTOFVchtC9ex2+gAg11yjIjpCI/RZT3rf3pVqHMr1Zg5CVrfcmXhna3n+hWTNGp0dvkwcDdWEE+oNGSGC8QgHNsbOLZYfGaDbOH1OqraPvdd39+4VNWaqT8/d9CGg/cpjFq09jDnmQHV3is3jouOTmUbI4bieEt+QL+p/uVn/hSoPDSdU05N/stxubZ2ygWH3BvJcNW1h5BlSd+lXIsG02cP80oBHixJR4t19b+3LbwKsZJt2F08iqdLMq83Uj/bWcPMRFrL+FoPxtH/GSu7sVudWr+7Ua6VEbVIOKyXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 14:01:58 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 14:01:57 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 3/3] mm: Batch-zap large anonymous folio PTE mappings
Date:   Tue, 18 Jul 2023 10:01:53 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <6B199D1B-24FC-4CBC-BC9F-D7D7CF5BABF2@nvidia.com>
In-Reply-To: <f0a50c66-ff21-caf6-1c73-04149d88be8f@arm.com>
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-4-ryan.roberts@arm.com>
 <5A282984-F3AD-41E3-8EF2-BA0A77DD1A3A@nvidia.com>
 <980c4e1f-116b-0113-65ee-4e77fdd3e7b4@arm.com>
 <C8DCA632-EA87-4CC1-A740-F26E49F67649@nvidia.com>
 <f0a50c66-ff21-caf6-1c73-04149d88be8f@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D9174904-3932-4529-8032-084FE2AFFB4F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0028.prod.exchangelabs.com (2603:10b6:208:10c::41)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c54740c-a9ee-4678-88b9-08db87978ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJ4k+ExS2xi+9cOGKwEddM6VYhUqnEp67/BjJKal4sQ2p7K8UyLVOrI514bxUd7s7ho12KK6be2omDS8Kr6t5Glj0ljl0eyITb6L6CHtfG8oMTiM9Hoo4nQYefIChgX1doyY6yRvuwVxAiony9p3ap2RtflLZifmAqd9E/SIllO+J7yKLwoOrzif8ToWwsRHtJqYomAP7zQyeb2npsfGttteW5WMivB/1B7YsfDGw9ElLlhjWZJcKqQUIFmtFLLj2MRER74n7XYqwDHIGUsCrRJVh3ZamnaKFRA8CB3i0zqYnn6BVJ8+Iw7kLm5asJq1aeR83PB3IDVGO6EVnXfiCGym0L/cuv5YWThTxSH7GRjYliU5BYT0DcrD7B0zpQ2RFVS8eqmnSzotPiqYJmE1hqJzOq7kDIz/dHJgSR9UrswoVxDWmRUuzZt6JFSdUqsj9jsgXA+g0vdl6FJiR8BTCDEwrU5fH/Zf5AezGbUCk1ByTKzruDQU/IzAK3C/KJ6tyN6h/VYLHVhbAGFBv8+0uzn8gqREdhmLJbOPDbmaXbgOjPYPbmFT1okTPweaEmfqY2VYdSTB2J/+4HkeLPy5gaJr8VLxoz6lqnNmJyT5dwF04QyAnPlBCq9sB3HnjeWOMy9RqUEX3tN3sOggeevBFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(38100700002)(53546011)(26005)(2616005)(6506007)(186003)(66946007)(66476007)(6916009)(6666004)(4326008)(66556008)(83380400001)(235185007)(8676002)(8936002)(41300700001)(7416002)(316002)(6486002)(5660300002)(6512007)(2906002)(478600001)(54906003)(33656002)(36756003)(86362001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z8bVIBJaLaFuVJ5cNeByzrUChjQ47mMTboLGO+rFycW3DPuo9zEcUkDa8iWB?=
 =?us-ascii?Q?HNC0rrX1ZCtrE8mleAI9ufxHraRsCMAf08XJ6aNLW5ABgPLBp0O0Kwmpo+Lh?=
 =?us-ascii?Q?muObtnYJ5vEtEVSuQrEt+8FYnepKLo4Lo8mGZq0Tzps1RsD0+U2WxCaxawYo?=
 =?us-ascii?Q?j/4rWyZXSGHKwhR8V3n6qA7yA7EEky4oYtLl5jvdbewOyjF3Sca1qbOAfQ1j?=
 =?us-ascii?Q?Z/Y5/CK9rMeHz29VB3VarQn0qr588M1jLfhAMmeo4PpvmAo3sSnEBO4NjpoH?=
 =?us-ascii?Q?qyuuwX6CQrUg1So0bdTT9QyknJlU1DK4ItOuIasSEbrxBzQHWzjvLnh4LVsv?=
 =?us-ascii?Q?TfdVuhw66WZ3K5yiwTzphv4RcS8hvMAoFsHVVNapTnCZxmvK+8ePqbkqOIuD?=
 =?us-ascii?Q?44bC5z2c4baXjpMu35IHu6SUkFTNkyiSnd9WbNOuXGwTLJLvpF0G7mDDNx5A?=
 =?us-ascii?Q?arERP8VwvvrHo3FORLFJTdW8T/O+btO6rv5Dsrandwk6hgxkDQWmbFEvwwKm?=
 =?us-ascii?Q?ApGO1OZqZBgCTO5Zt5V7gSaSQ+v9ujeG4FgNs5ZVPjB9tdDizLGLuscJYgMd?=
 =?us-ascii?Q?KbOMLqtqPKlaHc2z3tKhjmIo11vR/XKgi9p9pNGhkaPQpTWJgNOS/6dY34bv?=
 =?us-ascii?Q?TlRwPOKX6VsA+Xx0uHeSJL7FYY7WgZrhAhhd7r6xMj7YcAz22HTFeGGjkU5E?=
 =?us-ascii?Q?Qy/ilAGr/j3gEe4asHuY9tAeLdjYmA9diYI9RYO54MvAWQJprOhBPNkY5TZx?=
 =?us-ascii?Q?M7/Zwrh3N3b626LGYHMqKzCGxs7ViMH5sNom8FmnWjw3RJLBqoPcWhA74D0p?=
 =?us-ascii?Q?IzU2KiynIQ8o6izO/qxP+3hEseOdAzQqJW3p4EXADpxkelkSAQx/uOHajKVI?=
 =?us-ascii?Q?B+rLp17I9JDOfs9wS0zPugf8e8ksi523ahYw8UXvNCFnRTKEfGSfHP+Zn12j?=
 =?us-ascii?Q?+p7B0TTt5q4SdHiCIqLq36v5PgAa7Ke+b3vovsHqaO0ydtW1xdAhi0887erU?=
 =?us-ascii?Q?fellxAcvXk8lnGXV+caD9eM4HBOoOWL0weBuXiDyWv/Zf5ZRk/h9WLhwpnlf?=
 =?us-ascii?Q?qcq62OE6tGSaoizIMb04G1h1k4EmQDb9kSpaUIYH3S9ECiGpknBkjp26OfUd?=
 =?us-ascii?Q?2J6xtTSpaFpWceOr2rviROIZDeA+vBdE1RHGHc7uYSOsx+m/4l4Xm6Q2KRkl?=
 =?us-ascii?Q?rdxs+Ne9d9RgwvdVX020tIpHIdBE2ec9+MecrjAIxsP1+Hr517yxaHg8yYXa?=
 =?us-ascii?Q?6hTm7lKa1t2nYlOlCEmZqgLUp1PZ9reA80dpME0J9jCIVnXHiv0urY8xur3V?=
 =?us-ascii?Q?tGYI5qqGLrFjm5juaQVvsZMq4LnMc0vpAKcY+ay5Hdd4xwNL6WB6XlKHjktn?=
 =?us-ascii?Q?0t5H70vH4/2j6eJ745+sh5wlxQvYx4wLTzhCXHI56g8ulqrxr+d4hdm3Rmo/?=
 =?us-ascii?Q?kpzDhFwAzneh7zLKZW2AVeFWF1ee8HkgpOyI+Ov8h39rdu0i6XI0afc3amsj?=
 =?us-ascii?Q?mC+3ciHgJQX1fESxuUaAfz6zPcearCLvV4O8K9ooH2S83+e2DMlMJ+0qDhWg?=
 =?us-ascii?Q?M1Pu6UZpSJAX9O5pmMo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c54740c-a9ee-4678-88b9-08db87978ca0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 14:01:57.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41YSVGHv7GIaR/u1HpkYkKWIsm6+F1phuIcrLYwmBxLEmj0XRWUGE+G0N0LR6++c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_D9174904-3932-4529-8032-084FE2AFFB4F_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 18 Jul 2023, at 6:19, Ryan Roberts wrote:

> On 17/07/2023 17:15, Zi Yan wrote:
>> On 17 Jul 2023, at 11:55, Ryan Roberts wrote:
>>
>>> On 17/07/2023 16:25, Zi Yan wrote:
>>>> On 17 Jul 2023, at 10:31, Ryan Roberts wrote:
>>>>
>>>>> This allows batching the rmap removal with folio_remove_rmap_range(=
),
>>>>> which means we avoid spuriously adding a partially unmapped folio t=
o the
>>>>> deferrred split queue in the common case, which reduces split queue=
 lock
>>>>> contention.
>>>>>
>>>>> Previously each page was removed from the rmap individually with
>>>>> page_remove_rmap(). If the first page belonged to a large folio, th=
is
>>>>> would cause page_remove_rmap() to conclude that the folio was now
>>>>> partially mapped and add the folio to the deferred split queue. But=

>>>>> subsequent calls would cause the folio to become fully unmapped, me=
aning
>>>>> there is no value to adding it to the split queue.
>>>>>
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> ---
>>>>>  mm/memory.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
>>>>>  1 file changed, 119 insertions(+)
>>>>>
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index 01f39e8144ef..6facb8c8807a 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -1391,6 +1391,95 @@ zap_install_uffd_wp_if_needed(struct vm_area=
_struct *vma,
>>>>>  	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
>>>>>  }
>>>>>
>>>>> +static inline unsigned long page_addr(struct page *page,
>>>>> +				struct page *anchor, unsigned long anchor_addr)
>>>>> +{
>>>>> +	unsigned long offset;
>>>>> +	unsigned long addr;
>>>>> +
>>>>> +	offset =3D (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIF=
T;
>>>>> +	addr =3D anchor_addr + offset;
>>>>> +
>>>>> +	if (anchor > page) {
>>>>> +		if (addr > anchor_addr)
>>>>> +			return 0;
>>>>> +	} else {
>>>>> +		if (addr < anchor_addr)
>>>>> +			return ULONG_MAX;
>>>>> +	}
>>>>> +
>>>>> +	return addr;
>>>>> +}
>>>>> +
>>>>> +static int calc_anon_folio_map_pgcount(struct folio *folio,
>>>>> +				       struct page *page, pte_t *pte,
>>>>> +				       unsigned long addr, unsigned long end)
>>>>> +{
>>>>> +	pte_t ptent;
>>>>> +	int floops;
>>>>> +	int i;
>>>>> +	unsigned long pfn;
>>>>> +
>>>>> +	end =3D min(page_addr(&folio->page + folio_nr_pages(folio), page,=
 addr),
>>>>> +		  end);
>>>>> +	floops =3D (end - addr) >> PAGE_SHIFT;
>>>>> +	pfn =3D page_to_pfn(page);
>>>>> +	pfn++;
>>>>> +	pte++;
>>>>> +
>>>>> +	for (i =3D 1; i < floops; i++) {
>>>>> +		ptent =3D ptep_get(pte);
>>>>> +
>>>>> +		if (!pte_present(ptent) ||
>>>>> +		    pte_pfn(ptent) !=3D pfn) {
>>>>> +			return i;
>>>>> +		}
>>>>> +
>>>>> +		pfn++;
>>>>> +		pte++;
>>>>> +	}
>>>>> +
>>>>> +	return floops;
>>>>> +}
>>>>> +
>>>>> +static unsigned long zap_anon_pte_range(struct mmu_gather *tlb,
>>>>> +					struct vm_area_struct *vma,
>>>>> +					struct page *page, pte_t *pte,
>>>>> +					unsigned long addr, unsigned long end,
>>>>> +					bool *full_out)
>>>>> +{
>>>>> +	struct folio *folio =3D page_folio(page);
>>>>> +	struct mm_struct *mm =3D tlb->mm;
>>>>> +	pte_t ptent;
>>>>> +	int pgcount;
>>>>> +	int i;
>>>>> +	bool full;
>>>>> +
>>>>> +	pgcount =3D calc_anon_folio_map_pgcount(folio, page, pte, addr, e=
nd);
>>>>> +
>>>>> +	for (i =3D 0; i < pgcount;) {
>>>>> +		ptent =3D ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
>>>>> +		tlb_remove_tlb_entry(tlb, pte, addr);
>>>>> +		full =3D __tlb_remove_page(tlb, page, 0);
>>>>> +
>>>>> +		if (unlikely(page_mapcount(page) < 1))
>>>>> +			print_bad_pte(vma, addr, ptent, page);
>>>>> +
>>>>> +		i++;
>>>>> +		page++;
>>>>> +		pte++;
>>>>> +		addr +=3D PAGE_SIZE;
>>>>> +
>>>>> +		if (unlikely(full))
>>>>> +			break;
>>>>> +	}
>>>>> +
>>>>> +	folio_remove_rmap_range(folio, page - i, i, vma);
>>>>> +
>>>>> +	*full_out =3D full;
>>>>> +	return i;
>>>>> +}
>>>>> +
>>>>>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>>>>  				struct vm_area_struct *vma, pmd_t *pmd,
>>>>>  				unsigned long addr, unsigned long end,
>>>>> @@ -1428,6 +1517,36 @@ static unsigned long zap_pte_range(struct mm=
u_gather *tlb,
>>>>>  			page =3D vm_normal_page(vma, addr, ptent);
>>>>>  			if (unlikely(!should_zap_page(details, page)))
>>>>>  				continue;
>>>>> +
>>>>> +			/*
>>>>> +			 * Batch zap large anonymous folio mappings. This allows
>>>>> +			 * batching the rmap removal, which means we avoid
>>>>> +			 * spuriously adding a partially unmapped folio to the
>>>>> +			 * deferrred split queue in the common case, which
>>>>> +			 * reduces split queue lock contention. Require the VMA
>>>>> +			 * to be anonymous to ensure that none of the PTEs in
>>>>> +			 * the range require zap_install_uffd_wp_if_needed().
>>>>> +			 */
>>>>> +			if (page && PageAnon(page) && vma_is_anonymous(vma)) {
>>>>> +				bool full;
>>>>> +				int pgcount;
>>>>> +
>>>>> +				pgcount =3D zap_anon_pte_range(tlb, vma,
>>>>> +						page, pte, addr, end, &full);
>>>>
>>>> Are you trying to zap as many ptes as possible if all these ptes are=

>>>> within a folio?
>>>
>>> Yes.
>>>
>>>> If so, why not calculate end before calling zap_anon_pte_range()?
>>>> That would make zap_anon_pte_range() simpler.
>>>
>>> I'm not sure I follow. That's currently done in calc_anon_folio_map_p=
gcount(). I
>>> could move it to here, but I'm not sure that makes things simpler, ju=
st puts
>>> more code in here and less in there?
>>
>> Otherwise your zap_anon_pte_range() is really zap_anon_pte_in_folio_ra=
nge() or
>> some other more descriptive name. When I first look at the name, I tho=
ught
>> PTEs will be zapped until the end. But that is not the case when I loo=
k at the
>> code. And future users can easily be confused too and use it in a wron=
g way.
>
> OK I see your point. OK let me pull the page count calculation into her=
e and
> pass it to zap_anon_pte_range(). Then I think we can keep the name as i=
s?

Yes. Thanks.

>
>
>>
>> BTW, page_addr() needs a better name and is easily confused with exist=
ing
>> page_address().
>
> Yeah... I'll try to think of something for v2.
>
>>
>>>
>>>> Also check if page is part of
>>>> a large folio first to make sure you can batch.
>>>
>>> Yeah that's fair. I'd be inclined to put that in zap_anon_pte_range()=
 to short
>>> circuit calc_anon_folio_map_pgcount(). But ultimately zap_anon_pte_ra=
nge() would
>>> still zap the single pte.
>>>
>>>
>>>>
>>>>> +
>>>>> +				rss[mm_counter(page)] -=3D pgcount;
>>>>> +				pgcount--;
>>>>> +				pte +=3D pgcount;
>>>>> +				addr +=3D pgcount << PAGE_SHIFT;
>>>>> +
>>>>> +				if (unlikely(full)) {
>>>>> +					force_flush =3D 1;
>>>>> +					addr +=3D PAGE_SIZE;
>>>>> +					break;
>>>>> +				}
>>>>> +				continue;
>>>>> +			}
>>>>> +
>>>>>  			ptent =3D ptep_get_and_clear_full(mm, addr, pte,
>>>>>  							tlb->fullmm);
>>>>>  			tlb_remove_tlb_entry(tlb, pte, addr);
>>>>> -- =

>>>>> 2.25.1
>>>>
>>>>
>>>> --
>>>> Best Regards,
>>>> Yan, Zi
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_D9174904-3932-4529-8032-084FE2AFFB4F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmS2m1EPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU2gQP/iWUNEqodsWgcKZxvT12K5O1Bx6Gy7EHHdCx
t3XYTtKQwXVbXgENDpewWU5TEKdal6SxD77uvRMnRoFBrKyuyWi3fgrQW3NtoTDB
hmaO06hig1DbjM/N3afLPeC/I6uZ0lESAW2KJxcZaDvwsWqEuW/DEGFXlk4SzVar
ADpPDs9iGxzUKtR6dpX8eQXRZzZ+wAYm/nGvN3k4p9lt1ms2KIXwjoqoF8TrV5v2
Smtt0CCvuzqm4+7xf8gWGGiirK/5u0OSVAne+9BMwwrQKMAUZzjc10MQFR2I4uC2
VLoVmW27lCVCgBMQQkBjYiSxVQucRcMkL830ggB3kzkM2s8B2tSBDzxiX9miVpJp
k95z45vCMFPuAWMXeYeheqHMeOG//XGNKKrUeEEza85CLFmbJj4nxdaZNn31pX8j
pmGVEJWI5cd/MJB38A4mLb59wKbwT7jrpHot5uKjKGqiC8qpFwCjj0Lbq+weV9Tp
19JFU3EnEgcEV7rAvLTrOs2loETOE201dvUSDqwFR3n1N+km94iDGCFPKfIJINlx
CD5s1VjfXhXVmGtr1DKczu3JoWsnR/m6zWMDA52RAbvukw3qDwLpFkLgmozrKQNU
3egXqwgDyRbaGEGoBuJ4domsWW6n+fYqOqPlImM9WTJ5lSh1OdcN9rp/qweC9X1f
KWHQcaGE
=+8OU
-----END PGP SIGNATURE-----

--=_MailMate_D9174904-3932-4529-8032-084FE2AFFB4F_=--
