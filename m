Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A91278B2B4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjH1OKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjH1OKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:10:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0597CEE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:10:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMW6RNETDD9PVUsiyEXesL+ZFdfDhxpOXXd3eMspom69c45hOAfix0bU7WYqfKeoZPecD1ZHOH8APP0DJLN0pNBRJHQ/W9hPrQMkTVjmF/9WkAowXBP2riRAMSlmIiaUK7n5tFHK5CobgH0z778U+YqA6w9MttnRVlG3oArVA5eTzt3aNy5EaukTtIuNOsNvd07afxgQNvq9ofoMxvX3it9atlKDaCo+aakO64v6rWiMVrOf8HklM9pgX22LhyvbCoZWfLiC2udLBYavm72l2l9UMK0QP2Z1sUj2torVvlYh6+LvuBWiATrJpdjRpXq0pJFmkvKHA/Hv+tI3RVYwWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOl/pEE9u7WUvWfQdbrudJb41tdGJ5CKasohXZQHSQI=;
 b=PjnXLh6UnJqiIKWGN+nXAo6tU0oCazUwzfsjQEfOaSgKzxhne8dID+2cLCbTFVlYqUzzBHLTZQ/2nGG4Cr+Piu0yCOMtetconoQS/Py8JJsfOURyD/hDmxRr9wf5X957jASNcMPMhCjSBhgGlphdfm3HrUcjwGBwoac24BLO7XMOusGHwbmDxeM9Zkg8ZwGkaHGHlkJmuecLSgdPMDl8eQgq33tBXjAWpbkctYoNsry/apS9wzsr/GyEcTfEBl0Imi925fIwtBnhp/w+Q4HuFsJMCF53S31JiSbEjdMk/BvU1yjIvTDcmKVQuuM26ZxfI08gpNmMl3QCZkiee/9Apg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOl/pEE9u7WUvWfQdbrudJb41tdGJ5CKasohXZQHSQI=;
 b=XPhqP4oF6uABWIg7eHoIwGq9DCImt/qNvaBlZptZ+LYuHZ8aiTVkOAy8GQl5Et+UzPrWxaPP7UkcByQsf5RuLD5aaGqAqjTrxDs4RiVg8ViSjA07DFd6H0SYx8ZtBq8+I0BNQl0X2mV4hv4kdT0bLVvem6Gzk4oA/GK82EBxxC3fl/WwNhoOgF8RodtfLJPltNdGrZIN+XOb8XysZjaOKx52ranl3ySo9eoyqMJeyuvJE3xBViVhbtEgiuyZST3B+7aFpGE+uK3gMry3rpEszAvyGjeNa/G2teH3Dzy0kIErIFfb0zqyA1NLN7j06Mm/9c6V6Pd6E3/EiYk4kDjMCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 14:10:27 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::926c:4184:7e6:de25]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::926c:4184:7e6:de25%7]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 14:10:27 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, david@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, hughd@google.com
Subject: Re: [PATCH v2 4/8] mm: migrate: use a folio in
 migrate_misplaced_page()
Date:   Mon, 28 Aug 2023 10:10:25 -0400
X-Mailer: MailMate (1.14r5971)
Message-ID: <855536BE-766C-49B2-B358-6C0548760929@nvidia.com>
In-Reply-To: <20230821115624.158759-5-wangkefeng.wang@huawei.com>
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
 <20230821115624.158759-5-wangkefeng.wang@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_964CBF66-072E-4C00-810C-1AF32DCFE211_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:208:32d::12) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b47aa0-ff09-47b7-1072-08dba7d0875c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1stMQtL1FY1N9gKpJFYxQF0/fZCV8sKzLdphEc82EMSydqKNXa216D4xANzQDpRLh0ufpdXNdOsbOTzjDAuWRtAew+ZdWxatygVFyfJ2njN69MS+zAWc3UsvGOXB5LDZ28rbYXnBygBYV2FHtLtb6Nn5gPcXjZXijc6leooojoJtIwCr+AE3QMGvfYqRlpV7Rc8hER1y4p3vs5D3Vp7TxD/lZxK3ijz47z2BJJoEJTWHALqw1hRKoszeuUa5OAOu8sQX9NANx6BoO3f6CObgSk4Co+iij1ubVqwWqMVjytb4qSv5FoU3lMZVu7V91JQKXtM5E//XyvUMOnTJc/0V/VH3s1J1fgenHogts9F1j8bD6Xzc80ud/bBkzVrtyr7kjpZJEUCkmDnP9LXGlHTtTJxysMK11//c/4L41T8GbvXA9W4vpjo8vWH1+qZ0Ifi/CTlDPb6BKZihBAY4Bo910UYo6pSxaq3gb2X1QJB3Xd6UqmWMaNRDKwi1M9rPNdsPx/+aubM3KqM9QzWpPMO1NqWf3STu/Pi9qaLJtHeGm2clEYDh2zLi5Oocm7nmLw1XkHvCTQm0QlwoOKMApSlih87skZd85ip9pxp9IGENR2NDO/9ECNqrsUKIQGarjVcYDmqAGS50d90sGY+uLXXhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(186009)(1800799009)(451199024)(6512007)(6506007)(6486002)(53546011)(478600001)(83380400001)(2616005)(26005)(2906002)(235185007)(6916009)(54906003)(316002)(66476007)(66556008)(66946007)(41300700001)(5660300002)(8936002)(8676002)(4326008)(33656002)(36756003)(38100700002)(86362001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?56jI5s7yo/yCfHoaj8/i5cdmpPu0/J1d+i/KI5t1U+ZEFwxED+3tWrT6Vxtn?=
 =?us-ascii?Q?kBjEUZ3Ak13qxaza/jsZy8UMpmxE9ENF3M7hFyHadTEPK04B504fl+E50XXM?=
 =?us-ascii?Q?+tWY+Pvsy2UHdyQjz0/nkG+QnhcuLjOzUbFX4CntYn+V1P4E7BK0duV+KxeL?=
 =?us-ascii?Q?5xcK/KhsuD6e16OmK1H5g9xok7quT/GB4ZPE4JjuxvPq7dyJMkwCQ4lhcmdQ?=
 =?us-ascii?Q?l3YxApL8xP0yOvqAEg8hZnkYKIx/Wky5qnVOT8EbP2thxIYEjm5X9K945l2M?=
 =?us-ascii?Q?XNBSB8U2I/H/+KPVhiX9yvZtArEXDNrmAibQySI01EHxrL25K/n+vhVHzSDw?=
 =?us-ascii?Q?h4e+HRQn2upSV9/Lh+G/gH0VAHgqmtOC25klbKxvboMvxGOGitlV4YepfkW9?=
 =?us-ascii?Q?/OHaZpr/aC2OyvDJllCJaEcTdZy5BXeebGWJSdsvLei6meqbHJvg2R/ii0Rn?=
 =?us-ascii?Q?FJhAGk2hK1Vol6t1/3SHnyX2fR7S2KBXYdyHU2LlYj1QpGuAj8mp3A+r1ZO+?=
 =?us-ascii?Q?qSCUwGesp0kz9PGtA2xucD+74ixZG6vJWPgeIlqlEtNx9CbrbRO4NNGgsWl8?=
 =?us-ascii?Q?XrkjZeh8htZHFvCr94h65yFvCd0xHDYXry7zyB4KmSZL02wMBYs4URU7FAmN?=
 =?us-ascii?Q?tpVySp5xTs7inF9F8cdzqc9Pbrl8DFPIC1o96zEDx2Suars+JL8JJQZMB1Xj?=
 =?us-ascii?Q?8MzzT+O4wNd1YmppmYyKsAdK1sH5HPSpbY1+6uH+3NGWWAg7ClaL/rdJklup?=
 =?us-ascii?Q?qUI9LPLPbSz22KiZn9EmOnKGKBsyW0QA0HMnjpdtnAVsy9qvuXxhaXskN3fn?=
 =?us-ascii?Q?/s2Gq/aeT9+gK9+I2fwlhrMl0VqQis75YxgXxoTIdv5PAWYLnnNXS+v2eQW8?=
 =?us-ascii?Q?E4kgphlBPbnsuCAZrETtHrRa7Ramrl36eDwmmgqTYLLkMZAMtKwMqBtrApCk?=
 =?us-ascii?Q?g0tVXMR6gc2gGvVWrRSTrkX883WvgoyN91YGCWNgZnXNe7RjXO3U8+MFgck/?=
 =?us-ascii?Q?BsK6cS/FBh5mYfanFsDuDWeKBSnTOju1CB5HZqewvjLeQGt3QGJZly7JmnNQ?=
 =?us-ascii?Q?0f6WX7j+/iyRZiwKL7zwXDDX14QuDZp8K/FCAyq4YA/XOy1K4F2F3qBnI9wd?=
 =?us-ascii?Q?BQ61Y3LCx2Xp4VciH6xy1ujuMaqdqDMjSR27K67T52Yt2/cGI1L3omjxZz2+?=
 =?us-ascii?Q?y+5sCykb5DZMCChHcFMyIHyYyXhfyd4T0o+GmJJeHNimJeU6anyY61C6482f?=
 =?us-ascii?Q?9gT1jvSpADeql3ssafxG/uFlGxjAABZsT8wBh8iRLXdyKxZQM/mRyiyKjXfe?=
 =?us-ascii?Q?7AJjiOOv5ls3H/gis7oDhCGaKOlAs/2SirUU0qJVtoYdMqLHwWqgIxYZkswj?=
 =?us-ascii?Q?yaIgxRXfLSwwyGH1E76NgHZXjHDDRza4/+rhgiGfEb7s5urFRfYRjKpVUxgQ?=
 =?us-ascii?Q?NJ+nN2ddmnjWDrJnXvCtCjYDFs57AULaJoeNuFDcxkkT/5Ldzl1BQKVQXwIe?=
 =?us-ascii?Q?oFV+Ms0zDnNszrD69YoN4lo1K2nxNoPBWGB/8flwW4a8k8ZPx09yO+L2iANk?=
 =?us-ascii?Q?Wkcqrhl/mM0VnmfVO8AO7adOmBH+mE33GeHlp/yb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b47aa0-ff09-47b7-1072-08dba7d0875c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:10:27.0804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEeI1Tipp9Svevf8iyZ3HC8KToAqC9O5qBYmHdpuTXl7CaPixgoZ0hTKRFyMvY8K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_964CBF66-072E-4C00-810C-1AF32DCFE211_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Aug 2023, at 7:56, Kefeng Wang wrote:

> Use a folio in migrate_misplaced_page() to save compound_head() calls.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/migrate.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

LGTM. And a comment below. Reveiwed-by: Zi Yan <ziy@nvidia.com>

>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 281eafdf8e63..fc728f9a383f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2521,17 +2521,18 @@ int migrate_misplaced_page(struct page *page, s=
truct vm_area_struct *vma,
>  			   int node)
>  {
>  	pg_data_t *pgdat =3D NODE_DATA(node);
> +	struct folio *folio =3D page_folio(page);
>  	int isolated;
>  	int nr_remaining;
>  	unsigned int nr_succeeded;
>  	LIST_HEAD(migratepages);
> -	int nr_pages =3D thp_nr_pages(page);
> +	int nr_pages =3D folio_nr_pages(folio);
>
>  	/*
>  	 * Don't migrate file pages that are mapped in multiple processes
>  	 * with execute permissions as they are probably shared libraries.
>  	 */
> -	if (page_mapcount(page) !=3D 1 && page_is_file_lru(page) &&
> +	if (page_mapcount(page) !=3D 1 && folio_is_file_lru(folio) &&

page_mapcount() is not converted, since folio_mapcount() is not equivalen=
t
to page_mapcount(). It can be converted and this function can be converte=
d
to migrate_misplaced_folio() once we have something like folio_num_sharer=
s().

>  	    (vma->vm_flags & VM_EXEC))
>  		goto out;
>
> @@ -2539,29 +2540,29 @@ int migrate_misplaced_page(struct page *page, s=
truct vm_area_struct *vma,
>  	 * Also do not migrate dirty pages as not all filesystems can move
>  	 * dirty pages in MIGRATE_ASYNC mode which is a waste of cycles.
>  	 */
> -	if (page_is_file_lru(page) && PageDirty(page))
> +	if (folio_is_file_lru(folio) && folio_test_dirty(folio))
>  		goto out;
>
> -	isolated =3D numamigrate_isolate_folio(pgdat, page_folio(page));
> +	isolated =3D numamigrate_isolate_folio(pgdat, folio);
>  	if (!isolated)
>  		goto out;
>
> -	list_add(&page->lru, &migratepages);
> +	list_add(&folio->lru, &migratepages);
>  	nr_remaining =3D migrate_pages(&migratepages, alloc_misplaced_dst_fol=
io,
>  				     NULL, node, MIGRATE_ASYNC,
>  				     MR_NUMA_MISPLACED, &nr_succeeded);
>  	if (nr_remaining) {
>  		if (!list_empty(&migratepages)) {
> -			list_del(&page->lru);
> -			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
> -					page_is_file_lru(page), -nr_pages);
> -			putback_lru_page(page);
> +			list_del(&folio->lru);
> +			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
> +					folio_is_file_lru(folio), -nr_pages);
> +			folio_putback_lru(folio);
>  		}
>  		isolated =3D 0;
>  	}
>  	if (nr_succeeded) {
>  		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
> -		if (!node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
> +		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
>  			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
>  					    nr_succeeded);
>  	}
> @@ -2569,7 +2570,7 @@ int migrate_misplaced_page(struct page *page, str=
uct vm_area_struct *vma,
>  	return isolated;
>
>  out:
> -	put_page(page);
> +	folio_put(folio);
>  	return 0;
>  }
>  #endif /* CONFIG_NUMA_BALANCING */
> -- =

> 2.41.0


--
Best Regards,
Yan, Zi

--=_MailMate_964CBF66-072E-4C00-810C-1AF32DCFE211_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTsqtEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUvCwP/1mf3r3n9NKMOg1ztR1HucGVrHmmVr1r3Awp
XJ2hT52KP94xa8RqrcCRrugs11j/opPT39pCtg32GYhQnXLbH66gi+pro/wHWjD0
fMKy/F5fNJFofro+jE/KfOowhvEVKd725qJEzWUNr5PfCw1v3Jaa0/k821hYuPm/
Yo1wrUq2I3LAxbOLyRwOLgeARE1p/1sp3AIWHsUB0F7mMFx4aMMBr+tSxpBBlgX+
pCH+PrmHBC4q1cAp9b8M6x0thEvi0s9JZYRYDCB5SSq7Zmf8eLHzcS4XqSJFK8qy
vvSnu5w5jCsyhlCmrGymZ9jD6yNC8Mm/l/3jfOD6KiFIUQOuSfeMjQdyA7g/0WaD
MXW4E2+VBj5cJRfwFywdxQUrlHHKhQDyAisZd0Kve7nPrfQTiyZVWmJkG8o/28Ha
kjpZh+mckcD3Vlbmwv+v9KXFl8SlC4IpIA7g7s/8GHUoFXyZ3cHZkfs51v/B/0ik
AM/DIdq9Ag2vehyoXn0aVZWhRA46yyHmMZLw++KlKQZhSZsYP+n8QvZiE5KMDUN1
zNtqKOeKCqb7gk4IEotcUHNEExnNuVroM1NZizvU7EoEcoJBy4Hb04T2BGHj7EpQ
16/DphXvw8GdV/9ysTyp6NLsjTrKKsq4B4foIxa6/8KT3mvNZyyZdoH/HiCZS5Uo
0mOMCGdG
=f1+h
-----END PGP SIGNATURE-----

--=_MailMate_964CBF66-072E-4C00-810C-1AF32DCFE211_=--
