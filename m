Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BCB79DA0E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbjILUb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjILUby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:31:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A733B10D8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfquFaOBELHgeP5oxo9bm8nE2BKZBfM7uYk96MIHbT6OAz7EI6Z7oRpjx7b4FnYTW96TqRhmzFq66Bfo+zva0jVm6rHTTApSPpkOvJwmwmDDXp1Uu6FQsi/lTN+eK0LUlexK4pDHOX+Z4UncynAz3TrzUaXri3WQJZ+IhixNH4hAAaIGgERtd6RaFyvnYqtxfCzREEdiyEctbp0fRfHnzvfTzKMIZaA0uu59xGlAvLQp4za7lwSx3eAOMYH1CB/+TUZ/cicrdMw2btAHndzZsQwLFy0qdWj8IhyoH91QKQwdniPMRJnjoYD9Tqy40gyszE8g5amUK7BfWFnGPwHzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuzhGkrHw1zqjY9ITnVh4/69Q/4Tqk0NcZpZB0aBdDI=;
 b=e5brSQgqhqWTsP65esDx0CI3D8/0lA52Gu0ufV/pJMAggEtPr95D76/PfTf/5v1GQ/FECEMEqimgG2l1lYpG+SenmU/twIRCOJyybBEW538Biu6p8aAwUr/xuI5Xz2vi4WyKJYgocotNko/JfjoMjGbB4k7bsn7+rOlYihgtgCSO/V3zdCk7QFRoTyqYKMBmMd708ZLWhenR7Zh1M+fyFIDCOQWEBOzQaESVAyPMEq0YcRSce1DcnELuTTtgXfbVOJLt60tEG+Ufqvud1AQcHE3mju8LVDimeCxy8SfXyl0ZTE3C0ieNW+lU85nhw2ng/MFZjxo6UKRlu+asktJaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuzhGkrHw1zqjY9ITnVh4/69Q/4Tqk0NcZpZB0aBdDI=;
 b=gjZ+gObFk0vsyAkNSsMTKaYiTj7yYW84F9wEeXPV2nkjJctk6q/npLLpf8iza9V+hgc5EwZx8gO0dbUb/cfXwXzzVKDY4PvmzsG7GE+kuR+8ORWZ9x2ITrntmEQ9qatcto0qtxaXVicyKvj5KQnmgP8vhh0kZPiuGzZE3ED8H1502jcpqK67//tOkafVqeyFG6yTw4n0F7wc6dDJ5o3Krpsva0Zz9cIqLoiiROIWsAQXSILBKCQ+JZ/vbATzsu1OHIuSG4nBNEcxs6pk1R7nakg8+7ptkl8MV0oM+9d3k79c6vJyr/vuNZuw14lNRADBtWVUIjpPQlwW0D6iicJPWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 20:31:46 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6745.020; Tue, 12 Sep 2023
 20:31:46 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "\"Yin, Fengwei\"" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 3/4] mm/compaction: optimize >0 order folio compaction
 by sorting source pages.
Date:   Tue, 12 Sep 2023 16:31:43 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <84D25C3B-6A9C-4F3F-9A7E-434D2A41B38C@nvidia.com>
In-Reply-To: <20230912175610.GC34089@cmpxchg.org>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <20230912162815.440749-4-zi.yan@sent.com>
 <20230912175610.GC34089@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_5D983539-6F74-4E64-A5D7-518F988D460A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:208:239::6) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BY5PR12MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8466e5-1022-4427-8a2d-08dbb3cf486b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b72fmFoy5I9wc/9Lm9slRPprWvSWqeqJXdB7as6lcsAG+UzcDDsKfSIvjSNHCWJP6XDZcrcgCNEzffjklRVCt4rA4BlKtk7k4znppPfaB+1gHBHVf6oBWSBJNgwm/KSvrF55gL3QFtxBihhsu4hwGSDgbOwd4gplM3gO4zj7xRJsxd4o2LZPCVbq/2zGc+nTY97WuEdc4XTEKO7KH/u7DfzUy5YJEGZNRJMtmoFh+Dikb7ubVw4/zRwkuMd8TQQ6YpfWqJj7AHvu4zjGY10/QNs7oGHTn72ALEZELfEkKrMmM0jml1OO9j3txX/z26ou1mo9Ez/dG/4RcrS51Gfty4wc5MlwxABSx8UCGcefPplmUi3/MIG4n7CMkUvE+SqgaJIaP2st2xDtqKWUZtObPWnEaCJPMfsOzXFzvS7fsO3lBsGX5/GgHc4kwq3QpxZm4cqd6JRjBApACAz8G7FO4MlxaWaLAo9eVxuzXwwLUyKAtvy8MI7FH2dTuf0HmhzNS4z+yUtLkUnpaQ+qpZ/KcoCd3BNsuOO10JOu5NxdL33kmzMQQHHhMpvZWpip7IEqLmCxYdJXjB1nuFfNDc2lFnfrBzyswxgx5HbUdyA55r64FQSTvn2nKtTcrksGoXLA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199024)(186009)(1800799009)(6512007)(53546011)(6486002)(6506007)(6666004)(2616005)(107886003)(41300700001)(26005)(66556008)(66476007)(6916009)(316002)(5660300002)(8676002)(8936002)(4326008)(38100700002)(478600001)(54906003)(66946007)(83380400001)(33656002)(36756003)(2906002)(7416002)(235185007)(86362001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tdBo07e7+LeioYEj0gXvIkqNYyABemU4oiDwaHUasXAc8+2IFqIhz04AosEB?=
 =?us-ascii?Q?SNlKUrHckc02elpgDc8GZGudtfxRcWgffcK1HehSRXcZMgM15Jym0NjQVMc0?=
 =?us-ascii?Q?HUuUb7CZC0lsY+VKqezriA8uyDYNXrDr5jOyVrpfjAnsL+eXX1O/WGeyHx2o?=
 =?us-ascii?Q?yqk4zsq2HvoSykgFpRYCAP/WHwz6weKnfOQFpUIToxqqLfJHCKJmtvkI0CXE?=
 =?us-ascii?Q?noUXduHLduzHspm0zSNSm5QaQo78ALE8wRuqVTTIRN2gpsM3EtukrpTAhEOV?=
 =?us-ascii?Q?eQwW8L1uktQjSfTiKPgkLDoh2/6hhs0hFkAAIwqkCLMG7+jPjAFhE8gAbeF8?=
 =?us-ascii?Q?3vaSGcoiQD5mh1BAc1+CReXfqKlWWO0ojO4VhcBJgK4dZ5ao9oFVb8OB+URp?=
 =?us-ascii?Q?iVeYWe1gBLndUXz/XdsOqbTuE1R+nWw0Z4AlvPYtbIQbbYoyJ5VO0aa6Sk1B?=
 =?us-ascii?Q?/GAQMOQRHDQaP0qHil7c+czYPmin/SKxPBKjkr71UYIOIBqB8XaT+MOUxAX/?=
 =?us-ascii?Q?6A/xOdQtSa9J16ZboUfK2aFqBfNSTvrK5tvinQh9Z7TCxJ+OYdjC44vrb7oX?=
 =?us-ascii?Q?XUvo9PLLSNre6wfxhHJNurJCosKwaCePVtJThx1WrtFQHVfJtDuptIMtb36j?=
 =?us-ascii?Q?608JR/2/rJF+Gyuq1C0Ze0jP/SquRO6lKmf6Yet8Z2XrHVNpZHUKrUuFVOU5?=
 =?us-ascii?Q?zsSOeRyo3MWoARwp1TvJTWOQwqDCT98/pMdHpWaKFMnC1jCPHiDEBVJsV5Pk?=
 =?us-ascii?Q?N5LbsBv5nRP13LpYN75jb3iyeVhD1plWzVzBuhe4ad/x/z/vu9EfEuz5vVhj?=
 =?us-ascii?Q?S8Juz93a365of8bg2UR2IjiJxOy+xYBVApbyMbjK3FKE/qaIWuTaRbfLSAVS?=
 =?us-ascii?Q?D4Pc3P1isCN+6NRmqbngw7QQcZUzZ3PGgRxn4xBfXuCXtwfq5H/RcNjofodQ?=
 =?us-ascii?Q?efH0NEko2mpNwqnTP4zCm+wveLhPLe6uA0lT9Ms7WwNloXxSJc7SzoLlcL3t?=
 =?us-ascii?Q?rhRUa9Oplmp1aMlQfvf4uM3q02UUQ7y4fWChmVV/wh+VRNVZqo2i8yWnnle6?=
 =?us-ascii?Q?LNbUpsHGx7M6XaELFGBlVtwU+3dSxnulm9rCIo4xZT77rs3QIou2D1dE/OCy?=
 =?us-ascii?Q?yoI3LZXhvzPMWwvbKNys/PhsYnE2711HoJitCy6er4ZXPJHqFAVwFeUxEaWz?=
 =?us-ascii?Q?QAu3UWqKQCQPOe41HdvsJ8oJVlsAwGGP+ktF+Trsz0aZBqdQm2vC/DesvG+N?=
 =?us-ascii?Q?W4885l+n6OMZYCJoX0bf71pAhXkHAzGyE3BFa/pib9ziOMkrid+6JjBSEXkl?=
 =?us-ascii?Q?MZ4OGuV8nlFwTIfFBxRc4aF6yI9OAI8qzpY4g5qJRs+8a64F+ImCeLnNd08b?=
 =?us-ascii?Q?1bgUdSOeu0AbTbExk48YaFAZU9uIvc9+CTQLIpAE5Ulj3YBfgdEY/6vSNqPV?=
 =?us-ascii?Q?COeQje+mwMbM1d5r41+djxgBNrBwpbfGDYlPm4YMFvFwwqaYgsPf65fyL1se?=
 =?us-ascii?Q?ail6FGjb593S3ARs3aczRhw1hT2tdbDlcXnf2VIrkujv8oQ0JhfJaV6jXtcv?=
 =?us-ascii?Q?fp6tLDA5vBSaDN93Jwh/NbBxf1khvntJPAxnfiM7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8466e5-1022-4427-8a2d-08dbb3cf486b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 20:31:45.9343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdwRLlj/aygxcQ3CYOt3F6yxnNmw/xIASlmMaXlv8hCnXKQxO5t4uabilQQYeQnZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_5D983539-6F74-4E64-A5D7-518F988D460A_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 12 Sep 2023, at 13:56, Johannes Weiner wrote:

> On Tue, Sep 12, 2023 at 12:28:14PM -0400, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> It should maximize high order free page use and minimize free page spl=
its.
>> It might be useful before free page merging is implemented.
>
> The premise sounds reasonable to me: start with the largest chunks in
> the hope of producing the desired block size before having to piece
> things together from the order-0s dribbles.
>
>> @@ -145,6 +145,38 @@ static void sort_free_pages(struct list_head *src=
, struct free_list *dst)
>>  	}
>>  }
>>
>> +static void sort_folios_by_order(struct list_head *pages)
>> +{
>> +	struct free_list page_list[MAX_ORDER + 1];
>> +	int order;
>> +	struct folio *folio, *next;
>> +
>> +	for (order =3D 0; order <=3D MAX_ORDER; order++) {
>> +		INIT_LIST_HEAD(&page_list[order].pages);
>> +		page_list[order].nr_free =3D 0;
>> +	}
>> +
>> +	list_for_each_entry_safe(folio, next, pages, lru) {
>> +		order =3D folio_order(folio);
>> +
>> +		if (order > MAX_ORDER)
>> +			continue;
>> +
>> +		list_move(&folio->lru, &page_list[order].pages);
>> +		page_list[order].nr_free++;
>> +	}
>> +
>> +	for (order =3D MAX_ORDER; order >=3D 0; order--) {
>> +		if (page_list[order].nr_free) {
>> +
>> +			list_for_each_entry_safe(folio, next,
>> +						 &page_list[order].pages, lru) {
>> +				list_move_tail(&folio->lru, pages);
>> +			}
>> +		}
>> +	}
>> +}
>> +
>>  #ifdef CONFIG_COMPACTION
>>  bool PageMovable(struct page *page)
>>  {
>> @@ -2636,6 +2668,8 @@ compact_zone(struct compact_control *cc, struct =
capture_control *capc)
>>  				pageblock_start_pfn(cc->migrate_pfn - 1));
>>  		}
>>
>> +		sort_folios_by_order(&cc->migratepages);
>
> Would it make sense to have isolate_migratepages_block() produce a
> sorted list already? By collecting into a struct free_list in there
> and finishing with that `for (order =3D MAX...) list_add_tail()' loop.
>
> That would save quite a bit of shuffling around. Compaction can be
> hot, and is expected to get hotter with growing larger order pressure.

Yes, that sounds reasonable. Will do that in the next version.

>
> The contig allocator doesn't care about ordering, but it should be
> possible to gate the sorting reasonably on !cc->alloc_contig.

Right. For !cc->alloc_contig, pages are put in struct free_list and
later sorted and moved to cc->migratepages. For cc->alloc_contig,
pages are directly put on cc->migratepages.

>
> An optimization down the line could be to skip the sorted list
> assembly for the compaction case entirely, have compact_zone() work
> directly on struct free_list, starting with the highest order and
> checking compact_finished() in between orders.

Sounds reasonable. It actually makes me think more and realize sorting
source pages might not be optimal all the time. Because in general
migrating higher order folios first would generate larger free spaces,
which might meet the compaction goal faster. But in some cases, the targe=
t
order, e.g., order 4, free pages can be generated by migrating one order-=
3
page and other 8 order-0 pages around. This means we might waste effort b=
y
migrating all high order page first. I guess there will be a lot of possi=
ble
optimizations for different situations. :)


--
Best Regards,
Yan, Zi

--=_MailMate_5D983539-6F74-4E64-A5D7-518F988D460A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUAyq8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUFPwQAJi0sk4YvQC2cuGWizbbx8hDjxdOTrzw7ac4
S/4qQU9+1mSHWcz5hmpCErlbDobQEL9nfFArCi5QdpqtTDhSCLRR79hrxMPfG+fj
xpgt7fO4g4OpTp/xH8It4NBxUb6j9oGqroUThlYdW9INaLWH+STEDQXLFefwFxSe
RD7spWfaztJR3uhZrAd7BFB/PnMUkLUoWeyp5Y8jfHaFxijIVD6EcJpC0+aXOfk7
Rbv5vcRRiuzCN0Fpm8sLCS2X/YGMZtO4iTJbE6gW6SWraCcFubE3YEaH/B4gcV6e
71ko5bUg+yJpkI0Uoo69SaI25E3EYOAjx7vsKvovL8yRNCHiTFZloZ7mRTA36YqU
A/p0dSKzFtJfUMW5YM4HvZdZHdmKUwxXvbhfHrkF6KrSlmMec8xXLJ+7honv37gv
jZoW7i3LQRB4DwAwog71dmhsHMI0wt5r1o4gkcZyNWgqL30b6uQh+UYYJXFXz7Qq
7CN5ivlQhG1GApFkUnsSrWBckqiKMVTn/LS66twwEJIR7ZvdhlF3lHRafpHEYNNq
M9qACIxR+Aa2txT6u+k+r0tjp+5JihyeRLiXgAVAMPPdaRS55HJKrzn7z19APVL3
sdEAEkSwFvr5IVxKPsaxBZpVkp7hsZRnKsmNvLhD/lYlwNpgTXXnavkOI778v01E
R6PyYsC8
=YprW
-----END PGP SIGNATURE-----

--=_MailMate_5D983539-6F74-4E64-A5D7-518F988D460A_=--
