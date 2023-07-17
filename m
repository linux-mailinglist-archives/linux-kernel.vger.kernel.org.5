Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3FB75672F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjGQPJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGQPJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:09:30 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C477C10CA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYAUFGnuTGeZs/8bV1JqcRFdSWM1qBZ6A+BJhkYMLt0YGk8OqIPQy0Qw/Nge32W3FC7KputYdgvoysm3G8EhkEnay2ECGFZroBEOaOC8EA5BZ8Aw7XPPNp7vr4qNNgnVcVIeL/1Gvqc6fawkJJ8UfrQT/Z8saG0ECO3KRezUDnX7GixLHrnhaA1TrDqLdsr6uv5StThPrqEd8+CA2n12hq4kVvNBy4K1zyzVu8NL1Fldr0bEW8wGcdmAb8zG8yT5AMWnEqsRcYdkRg8BvnOxKf+VZf0gKvWU9N69Kf5s+YqSdPcWSaB1zff1I8981H1ukTrTwIWXD3wFSi+wh+KHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zbr3mrgCyg3AvEeoHV/ZiNlImA2QMFbUJVCTgOgEWo=;
 b=KvK2rLTXtjpCPQqNzbW2U14a6OQ8HmbOcULcTysoT1fmP3nh/1AO3MzkPTPKbuV3gul7atscmCofQXfttesjyE93zl0nqNPJ0laChc0/IEIDb/IC4sh4U2cS3MIT/hFyPngg/U9xp9v4nT5A/b/uR7qc+c94XRdfw+ShOqM4peRlac8tU7pWWnUS+wrBIHRy4UTwANdlZfNaY+yDLO4IUKanpRDMgfbqxcoQ4qtq1qNyrg3xacE4aRC1JqWIVSEh/DVfVjp0YWkqxs75YGbFC6Eq+0avGjnl4Z5gi2eampA1fxFfy+u7FXS1Y4npvoyUv94yRgIQggZEdXErzNo8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zbr3mrgCyg3AvEeoHV/ZiNlImA2QMFbUJVCTgOgEWo=;
 b=ndygVqLqz2qew20V7LsXuwt41fzypoHpNLYtmINAsOvIv25y8nJCakiJPOsFJSd3/MldoBwieoMdkkIj2QPdoIEJwqdH8LTzBbdCqtlTMawrJgjejmml+RxzbQPQEj2pRiE3H01JOcR+p+omMkTt/Sh0cB5fMOyW/EeIF2+18H5ePeAbn3l0Bfw9StN1DPht0HPK7B7Zd/1soWX702BIO7VdHP2fRfxONpEVmaBHueLRhxg3ahCTUUTK7CYPo3P1O6Y/2pVoYa2P38Hgu98SF+2xtyzD7oHfVmjq/vGvIHXgID/a9SsPJ/AQwBg8UMJ5TbQKbWuux8gbXlcOVU73Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:09:22 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:09:22 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 2/3] mm: Implement folio_remove_rmap_range()
Date:   Mon, 17 Jul 2023 11:09:19 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <B4A5CF00-73E3-4AAA-9D39-1E7ABCCCFB06@nvidia.com>
In-Reply-To: <20230717143110.260162-3-ryan.roberts@arm.com>
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-3-ryan.roberts@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_756158AB-85C1-4D6F-AF5A-E16D9DC3F941_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::27) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1dcf22-896a-4b7a-e7a8-08db86d7cd3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ckvZHuQeJ3ATwNgBsRoPnqJNAHaSkGK/JpCPZP+C2ohHAB+xlwohc2Up6Cfqsohs8E35J53REhApTdQJGOixqql8QNARl51xAtLtNN4QP54k+1uRmiO4+ExluOipenaNytnt3tA4VqRfuRr3v0cJzxynXUNoKmvZ1Ar9jXAgO8WKClNQZE23Qk1BzMu0uM8cQxs4tIerPRdntBSCYVm3eboRdcA4tN/x0Ua7o3caffohegEMHIXP/kIRH4lDMpTXiQDfS+jCDcfaDJLYsOH+CD3Gj81bUsRn61ugqBbhT4zCJy5KifCQAYmluwc+a32OWBVKjty3EtJ7GwQZxGThIHobag39w1qtDgCQTneRmRBzK80DYZ4rR6pIAB27QFJTxT5/QowEkfCHCtiDoue/RLkIyhmAu9D5HWlbUlmcr4K1DHDxtdqwsnfR9f2h86UqQOjB6JiOnCwos58ZZwuZHtynkcFQUtcZQ/oCi0jz/jdX7e4gPcn2Y+obLBuN9qlZNCW6QfI3wLZQfmuCvxECePHffp46SUgZX9XB+p2OKv31utnohKhcfWetB7t6nXMDssbv0keM/7BuZoUvdJtyC/uSIp+oLo5a4oFlxVv3NFS88CwPb9gEwtWJV/AkHgb9immag41fmA6Y/Fv0TXeqcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(2616005)(53546011)(6506007)(186003)(26005)(66476007)(66946007)(33656002)(6916009)(41300700001)(66556008)(4326008)(316002)(5660300002)(7416002)(2906002)(8676002)(8936002)(6486002)(6512007)(54906003)(36756003)(478600001)(6666004)(235185007)(83380400001)(38100700002)(86362001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GKfMcgCucYB104CbqAJErA/IwL6ExdHshxkRPJ0ETpon45UUa74L4z1D28Ey?=
 =?us-ascii?Q?NvgRg+VLnaJ1ZSXGOrnK20He5VjIp/VVP2ELdpSqhsF8JqaeVgS6BKuXGn4l?=
 =?us-ascii?Q?lM22nCjA2BCVM1y52qQTxCFFQXfT4ApYyBNZqX24xKxtO8mycebakgrRzvqi?=
 =?us-ascii?Q?/X70B+BiqfH3sffBx+riK7ZwoE9guvJ839hvKkdYszON4BMpsyKZTZcezM7U?=
 =?us-ascii?Q?+goyLUdqxTYSWY8DKWEwtfBOownqq9bUTbhKB2IrsqETQALYcytchDFFAN32?=
 =?us-ascii?Q?AsxaRPMS2EFUQnA9XzXvnFuZKlqhE7whocOsJ9C7yZkxzXoeWMTjwlQuTj1a?=
 =?us-ascii?Q?GrUGbfkIM/ib3NMG/ZmqObgNBs2NVhZkch1rOgcv487SOdh224lJ2KiKQ5+1?=
 =?us-ascii?Q?kTfUs4sKCawY7Bpti97OXoyexZBm29n7dmLYubf7L5DPphbch9NroNYqKI1R?=
 =?us-ascii?Q?WGln2vGVoaqU8KoQmUkcO32wH0eQqcMbIuryGAhmuAtBHnATAdYTqEtrTB6n?=
 =?us-ascii?Q?AtUajxH6Xu4A38zWUuyQU9pMfrr8/IHqs3F2zv1cjfT0noJpOAzGhKGHFNQz?=
 =?us-ascii?Q?uGwRRynCqPp95rE6xaU4bzD0ru2J4wizZNYKDww2m4B5JJg8RgIBBnEIb+Ed?=
 =?us-ascii?Q?m2kn7Y29BCD7TCwuCP68tL2HFDaA7ZY+pLb8VOJoJ+qdt/v8zoEc1uzHt/Tz?=
 =?us-ascii?Q?5NHw8fnCzd96Q2SxCZIl9Y3J9XUkxf0v7d1yCwLGnKUJx8egtCH8VXEnui4O?=
 =?us-ascii?Q?PcRT9Z2tGlzKEurlY/mh5o/qRCjXjRTa3BQz7HPHvVLIq0JjOmJ0K9XDTmWM?=
 =?us-ascii?Q?qva9lqgzkWbx5PU4dXCKh7tCeON827VY0xXOVJnzA2xKaVURTvDa96GRiyOF?=
 =?us-ascii?Q?DlTOmpXyiFNNlL+1YxCLlJimD3uSXKCUZ5+zYQlQEolzVHphC+w1mq4ej8Mj?=
 =?us-ascii?Q?TxgEGCJrp9WljIm+WFcNz1EmGFd/BhxAhDFzQuf++UN3TL749JXnOgVgJTv6?=
 =?us-ascii?Q?8OA15PagSDBJ+ZQhZuW9sQgN66zmgVCD3Z5dCbWYHpdZBRj1m+eSbY8eJXi4?=
 =?us-ascii?Q?L2gt7Ern16Idy0k+kXvOXETsChpwGbfGm6F7if+419ubeuw82Qwj4qbeLQrc?=
 =?us-ascii?Q?v0Scmwk5O2+ezGTF9ryHIliLO16lcnVwlgQHPr2mKzMWun5wLmPsaPeRrsbo?=
 =?us-ascii?Q?7+qginj1C34S+VYX0OVeQ4cjKyNdkQmZIMvnHTDDz0MO+/BqOnTy6KflfATA?=
 =?us-ascii?Q?SFmVpXreB+eWlj7e3HTJ1NU8j6x/aR9m2/SBwHnUD0u8trN07RFnfVh3l+vf?=
 =?us-ascii?Q?hewMU+S7Gp1yff0Kiq+8axycrZaYT8H8a6lYKkAWMyUy/mC3HWPjgZ8dTBop?=
 =?us-ascii?Q?RUqr+f0yJU+z3+Tf1G7z3076U8NwgJRV/a53jzzgxDwdyXEta1OUSAvVU9tP?=
 =?us-ascii?Q?aVLp4hTu1kwVKTiEUAkbmA4JEVHFpAIfbjuSMr+hjibOhTN5Wy4MiyC8rNUl?=
 =?us-ascii?Q?1oLTmGmd3YW86uSIjvfZAANeXxEvDTPp0U6kWIrjPH/WENPYWX2fD/yzRw9a?=
 =?us-ascii?Q?73avDmBnb5+Yl2L/QLtI/v6Eka8WjGBqljbRSMzo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1dcf22-896a-4b7a-e7a8-08db86d7cd3a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:09:22.3778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQqV6pNYMx6DsaW8hVbo/lcnLwv1gQV17FNXvbaDnO67GRV3iXgOLjcpkF7GLADG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7871
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_756158AB-85C1-4D6F-AF5A-E16D9DC3F941_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 17 Jul 2023, at 10:31, Ryan Roberts wrote:

> Like page_remove_rmap() but batch-removes the rmap for a range of pages=

> belonging to a folio. This can provide a small speedup due to less
> manipuation of the various counters. But more crucially, if removing th=
e
> rmap for all pages of a folio in a batch, there is no need to
> (spuriously) add it to the deferred split list, which saves significant=

> cost when there is contention for the split queue lock.
>
> All contained pages are accounted using the order-0 folio (or base page=
)
> scheme.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/rmap.h |  2 ++
>  mm/rmap.c            | 65 ++++++++++++++++++++++++++++++++++++++++++++=

>  2 files changed, 67 insertions(+)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index b87d01660412..f578975c12c0 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -200,6 +200,8 @@ void page_add_file_rmap(struct page *, struct vm_ar=
ea_struct *,
>  		bool compound);
>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
> +void folio_remove_rmap_range(struct folio *folio, struct page *page,
> +		int nr, struct vm_area_struct *vma);
>
>  void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
>  		unsigned long address, rmap_t flags);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2baf57d65c23..1da05aca2bb1 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1359,6 +1359,71 @@ void page_add_file_rmap(struct page *page, struc=
t vm_area_struct *vma,
>  	mlock_vma_folio(folio, vma, compound);
>  }
>
> +/*
> + * folio_remove_rmap_range - take down pte mappings from a range of pa=
ges
> + * belonging to a folio. All pages are accounted as small pages.
> + * @folio:	folio that all pages belong to
> + * @page:       first page in range to remove mapping from
> + * @nr:		number of pages in range to remove mapping from

We might need some checks to make sure [page, page+nr] is in the range of=

the folio. Something like:

page >=3D &folio->page && page + nr < (&folio->page + folio_nr_pages(foli=
o))

> + * @vma:        the vm area from which the mapping is removed
> + *
> + * The caller needs to hold the pte lock.
> + */
> +void folio_remove_rmap_range(struct folio *folio, struct page *page,
> +					int nr, struct vm_area_struct *vma)
> +{
> +	atomic_t *mapped =3D &folio->_nr_pages_mapped;
> +	int nr_unmapped =3D 0;
> +	int nr_mapped;
> +	bool last;
> +	enum node_stat_item idx;
> +
> +	if (unlikely(folio_test_hugetlb(folio))) {
> +		VM_WARN_ON_FOLIO(1, folio);
> +		return;
> +	}
> +
> +	if (!folio_test_large(folio)) {
> +		/* Is this the page's last map to be removed? */
> +		last =3D atomic_add_negative(-1, &page->_mapcount);
> +		nr_unmapped =3D last;
> +	} else {
> +		for (; nr !=3D 0; nr--, page++) {
> +			/* Is this the page's last map to be removed? */
> +			last =3D atomic_add_negative(-1, &page->_mapcount);
> +			if (last) {
> +				/* Page still mapped if folio mapped entirely */
> +				nr_mapped =3D atomic_dec_return_relaxed(mapped);
> +				if (nr_mapped < COMPOUND_MAPPED)
> +					nr_unmapped++;
> +			}
> +		}
> +	}
> +
> +	if (nr_unmapped) {
> +		idx =3D folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
> +		__lruvec_stat_mod_folio(folio, idx, -nr_unmapped);
> +
> +		/*
> +		 * Queue anon THP for deferred split if we have just unmapped at
> +		 * least 1 page, while at least 1 page remains mapped.
> +		 */
> +		if (folio_test_large(folio) && folio_test_anon(folio))
> +			if (nr_mapped)
> +				deferred_split_folio(folio);
> +	}
> +
> +	/*
> +	 * It would be tidy to reset folio_test_anon mapping when fully
> +	 * unmapped, but that might overwrite a racing page_add_anon_rmap
> +	 * which increments mapcount after us but sets mapping before us:
> +	 * so leave the reset to free_pages_prepare, and remember that
> +	 * it's only reliable while mapped.
> +	 */
> +
> +	munlock_vma_folio(folio, vma, false);
> +}
> +
>  /**
>   * page_remove_rmap - take down pte mapping from a page
>   * @page:	page to remove mapping from
> -- =

> 2.25.1

Everything else looks good to me. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_756158AB-85C1-4D6F-AF5A-E16D9DC3F941_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmS1WZ8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU0ZoP/0rd1OUGIjmfBNmJKTPV81y//5DMvL0UIvzl
H6uJItYmUuEVe7nWbDqSHwjx8J+/QKPBqAxXjsJTCaGgtFwK/sGW547aU57dlUny
xZC6vRqEO4BYq7JFoL0sLpQL/uz6M1INqWedTONPtJss8qAHX5IlhAxOf959l4Ev
pjbfin3eLqri5wtgGR8mIYvoNBN7UI5Vrk5E5TGE61Cx4xz9S+EysG+nRxQaZKyS
F1jhbP4u42bEOKaJ6lo1HRFNd6k15SESdp7hDydstpLGZomFbDkYTbnp6I55CC0h
nAKkP8yfFH+MdCS5KbnZ2rrWTYruGyQfxW/2/yehs47MzYbCTOKfhSgje6duvfw7
mTuOgJgYANm7CAQNygg6VX3U63hi/Qwi2grf3qIky0HWwsmzTb2uYKdQHB8vlScW
WVWKJWjL6AoyNwB5aXhoIlRn8S/36UfVJpQDRBJDTiZjVA6pZvzlqLRy4ZD/TLcF
AkWURMLtROulqbD/gEA4JGT2gPAO6KMPYAbmRCQIH0vjEutjWhHSYBHX+p9qarl1
z3XufS5yDGWHAl3Uwt6DtV4FEkup5Q99CeQPTfYLNkk7HjRYht/wT9FbT7/Hv780
PaTzLi3ckp8rkYKKSqVR4EL6H+3TmeZi5YnhZBbbZAt0gKRDlIBufc3VGAGv5rxq
HY78Xgjk
=gBdO
-----END PGP SIGNATURE-----

--=_MailMate_756158AB-85C1-4D6F-AF5A-E16D9DC3F941_=--
