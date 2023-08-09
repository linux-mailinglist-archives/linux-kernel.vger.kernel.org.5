Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5770E77644D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbjHIPpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbjHIPph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:45:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487522113;
        Wed,  9 Aug 2023 08:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxBEQr1TOex9TV8Cm46EsSFrBVzj87ob5dXJoN5M6N0qZ6s+860vnkQIv9LTvGPalY5TTvI5RkBYHDR6BM0C8q3BzGlIKKoTQfN9iBL6G/KVeLj8nqagrLi5Ea4fQYMthdOBnhB+RzbgPHuSkwRjw/jcThhFumtZ1lR+GDULlSy99xEL1ghwVRX8XklhT3O424g/LcqcgrpX12ZBab3zwTzDANSGwTrsxTWpuausOtqs2JCdM2IgEsNbIswMvHh7FI0ZZQQyrqQzndm2Zl8PTamXQhT/eSvLB98djTX9mfapRdAzcF0/U0vyrf9MJMMoykOhUcKGp1zqj7t/wE9B0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHvH6I3bsJlJQUVfgxla5/UONs267ZOSSdtjz8kn96g=;
 b=fFXRDQEWyqS9+P11EPdwE0XkR9um6+Y1cgHhUCXPycfAeFn6i82ZpcB1YPy5MnecFNP/mNF4j+7OaNaDNV2ADn7zMPOC/sy4rQewqfvdUJvXP2BWAWfG4nNsAyXYU9T8GBfFFjRmM4nbba3JaYCtnJJ/NccwwygvpVyKGyXvWtRHx+QfM881Iuo/6GGoCSuCNgbcPe497m5U0GtshZb7XU5aXggcRZSBGYSvT4RKQCXdNlsxaysr8TNrgDcX9cWoWb9FQ8+IHm+/HUjc4Kxou/6RLLkKZelKA6etfs4jYwho+sO34MuInJvOA1m7yrJkTrU7JgjtDcRrWvb7/ez5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHvH6I3bsJlJQUVfgxla5/UONs267ZOSSdtjz8kn96g=;
 b=k+tCO7GEI4Vml8MWraz5awAXrdPERq4HkieG0Nv5JBS/TmR0eg/7HoYS2L/7aBMk/ZRilEVZrBz8CR2pzBhQd5rJJYE2CwTIo1A0ik5pPb2xbB66jDdYY4Of730rA3h+JD+DB1f3S2bZbjLMTpDhnIBw7SEYdIsH/cT+cryN67OOHvjpmHrfVF3IjcJW0mdFvyZ+7hcgHRVl7sDXp3jdzv4oMzkwJVCnPwTLWe7hGqxXDdzWVRBRdK8QrCT4S3Pej9IAdlJilr6e1qEk6bm9erzbXFbGkcpDr/h5QnUUzgce1w/8mC4k2Vh0g1fAG+VVjem7aHgYhPcmLTEOgCUA6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Wed, 9 Aug 2023 15:45:34 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 15:45:34 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Date:   Wed, 09 Aug 2023 11:45:31 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <6BE8E079-974A-4D4D-8577-92DE72759710@nvidia.com>
In-Reply-To: <20230809083256.699513-1-david@redhat.com>
References: <20230809083256.699513-1-david@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_BEE70BB7-7018-472C-9985-F5285C122516_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::10) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e91367-67f4-407e-de42-08db98efab09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKBL+CgQ9Dcwkrp69bDiDks0fseVDf+NIg/js1M2c62ZEA5AQ73sD5GkAM+hxtXwyrhTSfmosyqOsYsKV1QLpMi+95x1+FUdis5W9mf00TsLTnJc82zWHWG010Ouq4mRv99EmaQo4TdVh+umMNVVNvBB+PrOiOIrVk/q8y84wBGaYc2pVjmwTkrUq0rgjgx5o2vn80jV/8QwmhmMChy5zK69BfTAibnJvh/TtIvBWY7XFSdY324zpGiZ3g6MA9Itdc5alPLQwd80D6eTnCIt77l+E2wTTc90GEbI8z5857MvGnemcbXlZt+Ckd5gZphc2+AZx7JZOfKYD2L1AVHQoSr2H1XjAtc+c/hF+i77UFIwUL/D12ph0g3pdBmhT6TfklHz1WzDOexlEZELuvxSRtQ9k2XhBOT8Q/0mSVMZz5ctOUy+xDu5ir2fvI14JZzCViOmXRcDCnZMM7Evuo+AoC255tRAOpKzf3N10mjeSJCrLpiLWDnvCGFlxP22gtRD6qU6E4O/yIXTXMP48WzdSYZlbdWGtMZtutvqFKuoS+vpVskBP8KLYcIUS14Jj5E1Dw57/9aYD52wIxzVNQJdW/B8+itnpw1hAtThYr9BuAeOSUVXtzsDHpFrLVC3uIdJo0eXiOtpj2Y/ObkF3hCu5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(1800799006)(451199021)(186006)(2906002)(26005)(6512007)(8936002)(53546011)(38100700002)(5660300002)(6506007)(8676002)(66556008)(66946007)(7416002)(83380400001)(41300700001)(33656002)(235185007)(66476007)(316002)(36756003)(86362001)(4326008)(6666004)(2616005)(54906003)(478600001)(6486002)(6916009)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vbMtRIuRFagASrGj5ztn6/BbggtFpb6t9epuMyFGq8r6VbbN96rdufiViOll?=
 =?us-ascii?Q?9lMdhTMmHqOf16w7n4Im+oJRLpRxVDgnt6nlCAphmoPi9awtaoWE9FJTusgv?=
 =?us-ascii?Q?AP4Ii54g94ZhHV44HKj+eoTzRab5U+AidfeK0+1GKeIMpF1Y5RyAqOzLx22Q?=
 =?us-ascii?Q?OXVaSfP8kA5CSMZr+DR4xdkFuPk8aZGiSDVYpcyIYcYdAzWyjQTZHhrlIEtL?=
 =?us-ascii?Q?gHxHC2S1Jz/M3zKhGtMrqLTvLn216UGNkK5P9IF+HIUd7D0u5fhdn/H3HCYq?=
 =?us-ascii?Q?zSIZ194IjuyeLQ9B5YI6SFV5/60KNs4EyIOVigd2k2O/1yzUhLLeunR9e5+P?=
 =?us-ascii?Q?Q7HDzKtq/6agdYBIk+XsCMiIN8RjpQxBT5qnWnXuapJd+gsXnvIm+eNckcqj?=
 =?us-ascii?Q?efBS2osvUj8JHjCl1swlzZAOYT5cadNiKkNcvtd/QkOw4L6HEBRoPL0zmcQA?=
 =?us-ascii?Q?mItvWOjZWKgzg69dAwsqGzY+JBU8a9td6uAqY9DxHThRjn5jnkppmO0xdLgo?=
 =?us-ascii?Q?TcOhzci9IvbkGJKrpgeYj1QAqBcwJSl0wd3dir8H/qMqnkSR9b21DMlYSlK5?=
 =?us-ascii?Q?QHIuUYslz2YEvYxx21L+cIZBnOfhRmRzTwZWeGRG3kmJZTK5zGa42WiavyWc?=
 =?us-ascii?Q?pJQpGbxhcLPL5zf1taz6f0hkQjX+t2CGgIfOdLxiSdydUu5RJkBZhMzbJsFP?=
 =?us-ascii?Q?0N+CXNP09UJSWZ0bCwN1LEeN4zJjBlLY0l2zeBymOuaaOUN/lZcCdvRazs1U?=
 =?us-ascii?Q?taw2yZeDtQWeORb5kJODwMbgPzogB8NmNqdrzDqjnbvAVWTVVC4lgK0FZUv8?=
 =?us-ascii?Q?4YNHWzzEECerPjvekW7z5sxMFWGWDPyberEJyTyCX4k7tVXBvvoWYrbUlbWa?=
 =?us-ascii?Q?PzZjpHhtReC3dHjM+tQEq54heLDELHTE15ZAdhpRCARY00+7btqO/8aqk/15?=
 =?us-ascii?Q?xXUb68fmAKdB7uQQqDB73eVnLKzp5tzyOygdZfKRTV4EkCoMjrjDothKvmsJ?=
 =?us-ascii?Q?qSHYKkuIMuOGXLZv5Iixt9wpgguXwBBPj0dOb2//5w4RgU8e7VInvKP2fZQo?=
 =?us-ascii?Q?7bLB9LABcgOhR4DrK0EM0/jhPMVRYQbu0wS+xsNYEDZMYAkbXWHA0irWGZk2?=
 =?us-ascii?Q?vUQlnHA1tuoHaB3sL2yFGItC4esn7ejHiUq9M257F9VGvXePWuv8el2r9ImO?=
 =?us-ascii?Q?H8r70IU2md0E/1QHfLf01zVpP/4rBYTP3cVWNtfPjU3n64U+TcQXy+QmzmVM?=
 =?us-ascii?Q?AIDWvcjnbSuiyp0nalXn++WiyoCiE2jQSS31EVYxsA35Tbn/knkCwjL4x5T7?=
 =?us-ascii?Q?ECMckJb2fk4i08siKcj58FDNgVHzjWH8hae2xLm7l6cdiHpMuLtYg54uyl2U?=
 =?us-ascii?Q?Rkda9FLHUUtupUHMjpwHhrxHgtnXoix47NCkp/MzuN7vASu8EUs8SuK/JOgE?=
 =?us-ascii?Q?8josTzxwZIvisTqFDrq/T+5QKc1daUlLnkiaiCvnsN+N+/FpbIsSkfQPRSqr?=
 =?us-ascii?Q?Nc7LaMBmVUH/CI9GdPQRv3MdGihfWHEc/KaOZTxRKnuSeUIi9lCjP+ASJcnM?=
 =?us-ascii?Q?2YFBkGpAhIxc0UJkHtk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e91367-67f4-407e-de42-08db98efab09
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:45:33.9326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIqwzKSoNCLQkzIB4+pWADmmHD8OgJh9VYEpsRAt8qZYPccNdg1MQZ199sS+WeOs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_BEE70BB7-7018-472C-9985-F5285C122516_=
Content-Type: text/plain

On 9 Aug 2023, at 4:32, David Hildenbrand wrote:

> Let's track the total mapcount for all large folios in the first subpage.
>
> The total mapcount is what we actually want to know in folio_mapcount()
> and it is also sufficient for implementing folio_mapped(). This also
> gets rid of any "raceiness" concerns as expressed in
> folio_total_mapcount().
>
> With sub-PMD THP becoming more important and things looking promising
> that we will soon get support for such anon THP, we want to avoid looping
> over all pages of a folio just to calculate the total mapcount. Further,
> we may soon want to use the total mapcount in other context more
> frequently, so prepare for reading it efficiently and atomically.
>
> Make room for the total mapcount in page[1] of the folio by moving
> _nr_pages_mapped to page[2] of the folio: it is not applicable to hugetlb
> -- and with the total mapcount in place probably also not desirable even
> if PMD-mappable hugetlb pages could get PTE-mapped at some point -- so we
> can overlay the hugetlb fields.
>
> Note that we currently don't expect any order-1 compound pages / THP in
> rmap code, and that such support is not planned. If ever desired, we could
> move the compound mapcount to another page, because it only applies to
> PMD-mappable folios that are definitely larger. Let's avoid consuming
> more space elsewhere for now -- we might need more space for a different
> purpose in some subpages soon.
>
> Maintain the total mapcount also for hugetlb pages. Use the total mapcount
> to implement folio_mapcount(), total_mapcount(), folio_mapped() and
> page_mapped().
>
> We can now get rid of folio_total_mapcount() and
> folio_large_is_mapped(), by just inlining reading of the total mapcount.
>
> _nr_pages_mapped is now only used in rmap code, so not accidentially
> externally where it might be used on arbitrary order-1 pages. The remaining
> usage is:
>
> (1) Detect how to adjust stats: NR_ANON_MAPPED and NR_FILE_MAPPED
>  -> If we would account the total folio as mapped when mapping a
>     page (based on the total mapcount), we could remove that usage.
>
> (2) Detect when to add a folio to the deferred split queue
>  -> If we would apply a different heuristic, or scan using the rmap on
>     the memory reclaim path for partially mapped anon folios to
>     split them, we could remove that usage as well.
>
> So maybe, we can simplify things in the future and remove
> _nr_pages_mapped. For now, leave these things as they are, they need more
> thought. Hugh really did a nice job implementing that precise tracking
> after all.
>
> Note: Not adding order-1 sanity checks to the file_rmap functions for
>       now. For anon pages, they are certainly not required right now.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/mm/transhuge.rst | 12 +++++-----
>  include/linux/mm.h             | 31 ++++++------------------
>  include/linux/mm_types.h       |  6 +++--
>  include/linux/rmap.h           |  7 ++++--
>  mm/debug.c                     |  4 ++--
>  mm/huge_memory.c               |  2 ++
>  mm/hugetlb.c                   |  4 ++--
>  mm/internal.h                  | 17 ++++---------
>  mm/page_alloc.c                |  4 ++--
>  mm/rmap.c                      | 44 ++++++++++++++--------------------
>  10 files changed, 52 insertions(+), 79 deletions(-)
>
LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_BEE70BB7-7018-472C-9985-F5285C122516_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTTtJsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUkvsQAKaDcC33LSGlycVnoWQPQSytt2U8ogKzyEuq
JwKbl5WIwGdKxenJELgWvDDMtjuu8KI58/3Mjk3nHwobb5U1lDLmY5+Adid6/mEK
SVEnmQVwsVgDbhMW0jd7rCEhPoFfJfIuP7mjW1YO1BvswpPxmvXwqTfNjPMVfEOi
AJjSV0LPn2lI6pQzMYUz3xkkTsSEyl2Mjhgiy4bU9g45LH7OaDv+SJH7hLYAkcsV
rR+YzYB9Hah1wDhnzY3vLZiyZghAp0EWQYkNeOfYLuLvxHWiuT3+7Wswc1MobXv0
tqT/OAUG01iwVoEV9dq4zrlTurYb+XS8mCppRn2/pxx96cGQ0gz32ByhHLlIzmGa
wyEeG3SCE09G3s5DqRTFEcbE5vBwrzgKXz31Bh8+DHzz2QBSU2RVE00wyCzATnEp
8LhZKz5JrkaGgOMcMv6PceOFtot+HraXhJdFmQmXNqIkmgHaycoO/11CSwENvceT
zINfGGmFQOOrF61qM/M6BypDNo7s3kzs/MBh9K6PLk4gep4jxfi24LA/gN/oLDNg
pL3IKQt2u0E/15CUL50hEqXj6U+MRAamBvxXrYg4R3PiFeivTTDGiXp2rps80LHR
HMDK0f1v4ECGhlyDvTlYQx95hj5brxLYqp3WWnMw2lB0uh6At/xePS+ITkK5Bnbb
CY+P0VNY
=XamJ
-----END PGP SIGNATURE-----

--=_MailMate_BEE70BB7-7018-472C-9985-F5285C122516_=--
