Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FE679BFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354923AbjIKVzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244295AbjIKT76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:59:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2996F1B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWVIEggbiTrmniiIztFl/BUsFwiqCFrbeT1jTWN1mxxIMhI+VYxldlmmjPGBnSIu4P0yUFGcqK5pCo8v8fwIV/+8mdAciAK9CJTc7n/ngsSF+e5S0MuBkAPGbNVS0bUvlYgnMRFLNgGq3csy/+pedGXVb2J2qvzjGyYhxQV8hIPSZX/QR7la51HHB+bViHYK9verbKC8pEkH1rfNksgHxL97km9SMVIr8VIYQCPavJ404N63ebY3A28bx965Vp9YGJvmodaMq/NigPmfS1AmLNM1Q9tZzdyjLkm26dbglO7fPr8wWyWh9EjjAIJfFflaql0Rnc2asyKu/7y7G0ID6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KFlMm6z/5M+jGVdKJlC5n+CO2o3a0XlaR4DMKcGVKw=;
 b=iVBazroC1Ms8oP/l4DTAW3REtXeQKmnwnAYxk0hgCtIK1TJNzusJMu56IBvK2bjut8kXNSwY4YmxbAyRYiWjWjNLbrx2XBIEbSD/QtAZxL07X+4PQYFbArUwNCmUvoValyhaBDQBP9yKqxYy2zXGjb1pks6q8F34SmnKjC+vFDnpRpN8VVD1Oa8O8n3wM7qf7M/Ozjxf1nngqnEyudWzCGHlu873+oe5effxwsk3UQitM/Ce2m36oxcY1SX7YSp763PDGHOopfl1crttESkZIkINHgQj4+JS6SgkMAvIU4ZcEM3SCt9D1VTR7mEPQZHMFZQBdYHx03ZHIJMIgbkKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KFlMm6z/5M+jGVdKJlC5n+CO2o3a0XlaR4DMKcGVKw=;
 b=prfgtVV5otNy+ogVbDPwM8TGdJcWzUKCtD9G1O/Aaf8xyFAt0jL6QKyHXvZ4PpMtGU9+UB9rhxInYDQ9po6LxC3BERJKkNqO6a5Zri9jErs+/eV8Os9/bsQqgxuvTgzxFkmggHL9i30eaDdLLXmzi4/A4DbQ7Y4eKZy8zCnlApKxMO4F5AWzmpwQOCIz5OT5nagzSInTIVtKYppGNQ5h/cxb5UAMAlhFv7mZgLpJOIqpIRE/wlAmqPIRoNE7Kz99mm34thyn1TSP8GdF3g1SBoBySwl+Radv344QYBEuWcIelXaBnBrM/+x+PiVL6fV/aaQ3kT4LZBsn0ncsg4BkdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 19:59:46 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6745.020; Mon, 11 Sep 2023
 19:59:46 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: page_alloc: remove pcppage migratetype caching
Date:   Mon, 11 Sep 2023 15:59:43 -0400
X-Mailer: MailMate (1.14r5978)
Message-ID: <931839F8-3D9B-4203-9FD1-BDAF998B3C97@nvidia.com>
In-Reply-To: <20230911195023.247694-2-hannes@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-2-hannes@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_EBA60356-A746-4A6A-AD8E-D5275D2CB35B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:208:15e::18) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d56515-987f-4921-0133-08dbb301a5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dh+xl/GAvQY5zKShv2UjBuigRfJ/pBOBAaNDO0x8GQDdYYVnHGs75stDeKI+IRurCQWBGkAhbqVJGPijJNDxISNXmIwA1gDf+i4QfvW8wUggUAGncSX1BvRUzJlh/63vs30gILwiUw3a1Oh3S2Rxc+swVsXorNfeLIq0sWYC5nuZf+LA9HM2df+pzwbAnzNzk2v2fboFOWc2LJQEO18bRH/VqV2x/H7RmW04u0QEPooHGa+EEeEjkIJ/BVEQY+lo8zlaRvxZSoYwEmTkWF5XB7STA+NyH5MAKL79ZPXTDLwBwUDnc51IqtwketTFPy7we05q4hiM7jBp740EQ4SxrEPQoK3w4NpVrLq/FA5NmtDAO7KuNhasQG5to4ElUfl2c/zsV1g1CZpq8OfzwkxQqvm6U0Lht0k8+FwU4Ok+nsb8N6bqQKfw3pt9mQbwS+2Ipkj7Jnp0l7IMAGJHfsyvsduJSBpYloScA5oe4HRWubUM31gX/88nN35Ju7O2v7S+hDd30+P/EWhFkBOVV9Hbz1jHYKg9cvUG3wB8XNrbyx+dEdG+W24dGFFb2QwU4ODYy+YZtxFgiIfJrF4gI2WQfHT6XUSNn6zpvNMtvsRPij9Sj1zVvx5Ae4BUIv9z3vTD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(1800799009)(451199024)(186009)(53546011)(6506007)(6486002)(6666004)(66556008)(36756003)(86362001)(38100700002)(33656002)(5660300002)(26005)(2906002)(83380400001)(6512007)(66476007)(66946007)(2616005)(8936002)(54906003)(478600001)(8676002)(6916009)(4326008)(41300700001)(235185007)(316002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7zsAO1IItgdM+ENEu+ipOwYMtMr1hgByB58etZsXjVNaQm/DehFnot3D4pSz?=
 =?us-ascii?Q?G6CLR/SqTtBCCbhiNmOHV4sz9W4SfOGbgN5a4sihu7GyZbKwwxKkGfr4ruX5?=
 =?us-ascii?Q?ZQlB1NkfmWZmIj7FOhrggJiXfY5HYKCXobSMd/1YE36SCnq/CtnvDrLSnQPl?=
 =?us-ascii?Q?kIX2Z7iUJFPY+y2800vDydhFjbsdWwu3wu9Px64702ApJFnCkJmC0KWhbqt5?=
 =?us-ascii?Q?2AT7iCWh+SRGUW+1OovCftisMEy3QWAFTxHFPfOT4hn0vbZihy9PaI73+r21?=
 =?us-ascii?Q?BjLxeKEb4GVxrvRqxpBrk3pRDkjejH5edngHZbdweHL4gQEn78Q1flOGCe3L?=
 =?us-ascii?Q?vgCrWOn+B3csXTz9Nw2UjkkEwEoIokG3tfSbo+knJaM01WgPajEDZFaOGxrJ?=
 =?us-ascii?Q?A4MCicP3Xc1worrctWfs5Q7RfHoJjq1s0PErN6QZ6RRp2Hai1P9C/UenQ9+L?=
 =?us-ascii?Q?s8tWgdtVDjO/mIczirwrWpApCntmntn7jhGTWSLHpj0xV83AKaduAWM653Pi?=
 =?us-ascii?Q?NdEGfYp42vYS+Zcu+9N6zkjSkNq1WouY29boFtIWu/gKRAosYUhkVoKtKnaE?=
 =?us-ascii?Q?NWKSVh3CvSr675Lf8vbBPtctHOUOKNYZRZj+rHkPLRPJOePobvP637FV9tOh?=
 =?us-ascii?Q?N+CpFgRkkZv7sae3e9Tty5IOZVw4OuhyDwfzfB0pcSv5N3AUVEuCFK/BF2tA?=
 =?us-ascii?Q?ccDqoQ4TedJpYz8SlapZIkGWHzG3lT9F2qewKpW9KNVqbq/p9K7Li3m8PFwE?=
 =?us-ascii?Q?nugmn+lM0upKLP6ZXNOR0jcm3o27s8k6pavNh1aDlkmMf6SpUNih4NM2PAVg?=
 =?us-ascii?Q?hkmNhS4qChoxpSn0pn+U9kQknMA0MHbiRL3bmGgHmVHFLrzPr8fCpAoFYrzl?=
 =?us-ascii?Q?kxZyXt6odmTb5A4/T4asztFvU5wQ1UFXRTa750WhDhvArdDEOkW02vx0w1vh?=
 =?us-ascii?Q?RRV3O9wPDOAKtuBno3U/VMUodZm59asTZfq4zGJ1uf1fInXmLarBNSKI3FP1?=
 =?us-ascii?Q?s6ukK8v9lfNCy8NjrMaBR4l5JMS78gdeCxvY6+ceZKATC20QXK9FnSY5i7S0?=
 =?us-ascii?Q?5edyDb5STzft8HvbH2FCzeFziCaxttey4TGbT8WyASnxThEOZZx74r8zDsfN?=
 =?us-ascii?Q?uydQC0u76yxSygrsIY7+w0zUle2UpYQOErYfc7PpIpGJJWuMAUwL/6VtKRXk?=
 =?us-ascii?Q?b2GghgPKzUKPsohK9XFy51P4wZ+02+eDaCm6a91LvBFQd7DTnwqF2iqEWQM4?=
 =?us-ascii?Q?WulNvV8w1KeEV0M/NKASd2ycs7NpvZ/NE+m5hclsOYZ9B3X4e4bpwNxdx31V?=
 =?us-ascii?Q?Somo6blIQfjauBZkWe6lJZAmYFLA7/qQJAiwjsCYvB3Da/ypnHsIen7jbTcM?=
 =?us-ascii?Q?SFb3Wi1WK5pkVAulBjj0yAPU1ghcqAPktV32XwyfelmGQ55cxN3sJHbN9+6L?=
 =?us-ascii?Q?GvVF/TCn3PkEkPP9rxgMnqga/MRtlaLYO09ZdsYnhVtOLNwEsJTToamDfIgD?=
 =?us-ascii?Q?fGmuqHAISzttq9ySThrg3TpIWaFYn+S5wIeqyDSVqalSbTY7Yw2fYjgxIa/y?=
 =?us-ascii?Q?B2yHqhI6ATurEDepW7k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d56515-987f-4921-0133-08dbb301a5c1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 19:59:46.1888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCGeotuWHpuAVzEq7gkzkL3OM/jdTxbOPQZyHDQMm+PvGIKAPf8t+a/cxooVPX6v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_EBA60356-A746-4A6A-AD8E-D5275D2CB35B_=
Content-Type: text/plain

On 11 Sep 2023, at 15:41, Johannes Weiner wrote:

> The idea behind the cache is to save get_pageblock_migratetype()
> lookups during bulk freeing. A microbenchmark suggests this isn't
> helping, though. The pcp migratetype can get stale, which means that
> bulk freeing has an extra branch to check if the pageblock was
> isolated while on the pcp.
>
> While the variance overlaps, the cache write and the branch seem to
> make this a net negative. The following test allocates and frees
> batches of 10,000 pages (~3x the pcp high marks to trigger flushing):
>
> Before:
>           8,668.48 msec task-clock                       #   99.735 CPUs utilized               ( +-  2.90% )
>                 19      context-switches                 #    4.341 /sec                        ( +-  3.24% )
>                  0      cpu-migrations                   #    0.000 /sec
>             17,440      page-faults                      #    3.984 K/sec                       ( +-  2.90% )
>     41,758,692,473      cycles                           #    9.541 GHz                         ( +-  2.90% )
>    126,201,294,231      instructions                     #    5.98  insn per cycle              ( +-  2.90% )
>     25,348,098,335      branches                         #    5.791 G/sec                       ( +-  2.90% )
>         33,436,921      branch-misses                    #    0.26% of all branches             ( +-  2.90% )
>
>          0.0869148 +- 0.0000302 seconds time elapsed  ( +-  0.03% )
>
> After:
>           8,444.81 msec task-clock                       #   99.726 CPUs utilized               ( +-  2.90% )
>                 22      context-switches                 #    5.160 /sec                        ( +-  3.23% )
>                  0      cpu-migrations                   #    0.000 /sec
>             17,443      page-faults                      #    4.091 K/sec                       ( +-  2.90% )
>     40,616,738,355      cycles                           #    9.527 GHz                         ( +-  2.90% )
>    126,383,351,792      instructions                     #    6.16  insn per cycle              ( +-  2.90% )
>     25,224,985,153      branches                         #    5.917 G/sec                       ( +-  2.90% )
>         32,236,793      branch-misses                    #    0.25% of all branches             ( +-  2.90% )
>
>          0.0846799 +- 0.0000412 seconds time elapsed  ( +-  0.05% )
>
> A side effect is that this also ensures that pages whose pageblock
> gets stolen while on the pcplist end up on the right freelist and we
> don't perform potentially type-incompatible buddy merges (or skip
> merges when we shouldn't), whis is likely beneficial to long-term

s/whis/this

> fragmentation management, although the effects would be harder to
> measure. Settle for simpler and faster code as justification here.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 61 ++++++++++++-------------------------------------
>  1 file changed, 14 insertions(+), 47 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_EBA60356-A746-4A6A-AD8E-D5275D2CB35B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmT/ca8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUEZ0P/1hlFSHAuNOtTDHY+/RpFIWQ0LbqaDsMYwMu
6ny1/05EWYzA5fspOO32/IDYHjkRCCGbUnAgCbp8ek9C9bcwzTb+c1gnksiFefl6
EOMC7yW0QjjT7ZRslNYiWeLLrwFHbq1gEhpEQ9i6lMUtA8BPzCoWzONytjmaH8Nx
8a71Ra4PB8+Gh8d1C38ZB3+/XWumEd5bRLE4MsdQ404sZ/V5oQjjRH6s61xU8r5c
V/gpYTleWg2zw5rWAuQKn6Foh4NhlaQSev0msCXUJEKlUWJE9b35J6vYqyHR+9/h
T7TMTylNBbyb3Y3o7vK6DBvwvrlWyjAesV232uQKQWAIXX17YGusmPu/Pn8K3MLI
ZdAuTvP/n8lkbkjP+tTVPWtM8x1UmLSTBpPVyTwEIsZ5RD3tyuh++OEDHCM1HLcY
GrKaR6ybuOGbfmA4rWIvltQWwODbWRYR/DtNS3CawQHKU18ENkJdec3EGv7QrlF3
umYM2r5h/0S8gWKpLvyqZUqmOPMERNJECEoeVk51x0M2ctx1k0wxFG7Jh2/03LKT
cZoGXi5RMBMqW5ljHJIMILDVZ0jAhiYuWbJvU3XpSLxebNmB5kAg+LI23Ih8eT4P
lua2UsMHuzhdRYpqP3KLW1T5oRY1al6hDaEASgyX5UKuYfLPyY8GGacpOT0aFPnQ
zsRJN+kr
=x54p
-----END PGP SIGNATURE-----

--=_MailMate_EBA60356-A746-4A6A-AD8E-D5275D2CB35B_=--
