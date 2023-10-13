Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1458B7C7ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 02:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjJMAHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 20:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJMAHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 20:07:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A406AC9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 17:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2zcbkHrUUyyUUz2g/NVHgUthVIZxqviHXRAGCfQSmkPSJGnJnmBtSm+BUT/+IDdPcajR+IWYRzHgo+DKH1y8XTc9dOezpos6nYb8Xe7Da8YrlHPjf+5iiRpjhDq464lZcsLtcjldhw80g2TSCw+OqpEen+D5Kdehu3fRoBZdky5TjRt8r6eo36rf6lSejzk1ki9peXHNtnn0gNOPMWz3IlLAXM5LifN2JiMzYUds/pXmtihnV7pbNzdWC5hwBJzhaB+xVv6MQ804qkqNFlb+O2gey9dViV/qNjxWKcQU4Re8y6D8Uzqx9G5N3WkNYlpzIXvxz6BgoCoT67A4xOdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YHsh8bciOaJIN8E+kTmwx9BtVIbD9TP8WoS/dDyusI=;
 b=TmvnyTGs+0+td04OnRaHfMYucUGYVL8Utwiz3M+o7P/e7elC9TP+KqH06UeJP9Cr5bVKmd5cH310i+2Vu7LhrWepXTUj6iEAq/NfqQ0tT7roq4W1hlz7Krswrs+Mw+OddziLKlkpOdfUg7Y6TcZUfD/Iat8xfHmP8PgmRXfQFsj3+ruFvkIQfE2CRQgvgruCltuv3jdoc4u7pGX8MjUiblApjpxpQNafH+WlNT86w609QbeDZUGA9JSaKvhOusyaN1bu30/sapiFypRZwIDgJ7wHZeLy1YjIAo8tNjZPYEgf9t368XUaX09RFSNBoort+6Uzgp/J+2vO5/3Ss3VvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YHsh8bciOaJIN8E+kTmwx9BtVIbD9TP8WoS/dDyusI=;
 b=tQXqnGxFqH+efUBg9whWYMEkrUfcn/gIWlCk0ACrRy5jOaMd5DwPdcAFAxME0XnZl019b1Un8wA7tZaaChVg/oO7sc+xdEoEHsT+CGpNfrWZmt5wkKS7f3obT1zDW/HhMSesbPmECQPOpOl3S1weYBFf12J1fDI8qCAvKOshjXfBkA1FMApE9ZoySdY5vZF+7s65AKnuOuAN3f4PVbZELqCWBjGg9srPmXKAfE0hArXSVnaaLIFLFiw6JyOx+KKMdBJtkwRC66c9OT/5/84pSzLj0CzhfZKrttq2r72i5E9fvtQLQ/liDAKj1L4dr+JdXDAQ27zcQggGzQpcILfi0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 00:07:03 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::2b6:2a08:dca6:2241]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::2b6:2a08:dca6:2241%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 00:07:02 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Date:   Thu, 12 Oct 2023 20:06:59 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <D6A142AB-08F6-4335-8D08-1743DFAAD10C@nvidia.com>
In-Reply-To: <20231010211200.GA129823@cmpxchg.org>
References: <20230920134811.GB124289@cmpxchg.org>
 <20230920160400.GC124289@cmpxchg.org>
 <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
 <D4F59724-61EB-4DA5-94DF-59E79F0F1FB3@nvidia.com>
 <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
 <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
 <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
 <20230926173939.GA348484@cmpxchg.org>
 <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
 <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
 <20231010211200.GA129823@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_553417F5-1D0E-49D4-A79F-8B7D1CFC35E7_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:208:e8::42) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbbe05d-1fb1-4736-d325-08dbcb8053a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASUND292UWMC/IRATq4UmF3hxOrG313RfsKJMAkxEMdvCDVyieDfUNxRsNqSnkoVIhxlze4fjS3IIUIWoM0dNBK1C6HN6w/3zDOTXw1HNX0AL9+wR5Z3wKZNc4o7TliQua+sIWRROnbzE7w2K6aSKENBb1jjDdLHEiSSsi3KjHXawaaKJL32o2AhQjL5/OKZs31hz82ZCPfazuXDbQHY0/HO+ZG7SXZQxDo1KrffWA+t12opoG6pvCFLhscYFk3SnyWllVFFpyXJCEeH3XhuhspV8Cvz0KVCuE51ElBDbvkNLK2sYUp3+H+jVbKjs8aTgZ1q3TztE6RqxWun0jWRYKBE4BjKXVmqrzC/a1/geOv1ut3q/SLXDyJIO+hlEgAbSvnmamWj1OC2CwHpDPf/ZgWzuzPhVmwZlPV7N+wG2mMkiuMXZM9ajpYlqPsPtA+GsyPnfsyXZAr2aO5h4rWZ8hqtLOEHJUPcNxeFXopNw2kM+tyvNDSHmN6wYpanO664pPTxjEFZ3yVlZqefVIm9EkBofccFY8548XI3l56f1F04itZKFOO1KJpvviRumKPusmhH7355aaUDCUG489G5Dz1AdYBakn7hQYNvPU3uIjyQOA5Eihg3ofaMKuOUChT3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(8936002)(8676002)(4326008)(54906003)(5660300002)(6916009)(66556008)(66946007)(66476007)(316002)(41300700001)(38100700002)(235185007)(7416002)(36756003)(33656002)(6512007)(26005)(2616005)(86362001)(6666004)(53546011)(6486002)(478600001)(2906002)(83380400001)(6506007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wU+HXHIz324PrDONBWjFKWlZn9uZQrS5x6N+hwcvznmR9JKwFeOOi/KE3ZRq?=
 =?us-ascii?Q?+Qq/A8THeVNlBiHzr7i21jKfWkfKepf9pHbDrofgiCYEJk+CgFb5Er5g+E5H?=
 =?us-ascii?Q?LAW0ajqt5ef+YwNtnhhHzH4hoSP4K3Yim62FALd95ojxUwlC8KzBmNpH7k9Q?=
 =?us-ascii?Q?QgJAamc6FILR8AFHhAuKL5bNiV6Jsm1nFaJtGcyO92PrR5BvU6QlE11qhsgY?=
 =?us-ascii?Q?wNkSzEyCDkqYmHVN5r2OBfXSf/Qn02eQ0qyOBgDRZhoN06bS4ac0qaAeE6HP?=
 =?us-ascii?Q?SAThYco4aD+Rs9HrYjQ5z6z+ZI1Cxb4sogAVD/VtoZ2jxCs+//BJrhGBeE7g?=
 =?us-ascii?Q?+qC+3ncBD1e1K93vObybisqY9xyfjM9dF40OCceULdgzdcHbVs+qUOva/qt4?=
 =?us-ascii?Q?q5eOwS8qOPJ2d+bXk5xLVXiT+lLtk+G46zvSewZmaN1q+feZlLuTUWw7xyqH?=
 =?us-ascii?Q?fjXAC4NNXU+f9hrjiXO2Cz7HKbd6CZf51j4jXx0pXkiH7k3u590DzGZ6MXkY?=
 =?us-ascii?Q?8QSA5a4qZ1e5jvRr+4BTgeQ7ah/7hnnGixiTVO+yY205gCIe+mAVyPkEAr7M?=
 =?us-ascii?Q?JSXhwKl+4Kk26PuEeMZjaHjz2cXok/amUXpoZv9/70kcSmF3vjiaocCykiJK?=
 =?us-ascii?Q?DQ04ky4Utf0ZDbaXkZ2r33zLGJo8IKAW0+8LhOVUAmjK31QyVxLwsGonHVZ8?=
 =?us-ascii?Q?APC+S5zVKCJ2YR38mWLPzm4CRnm3NCzibX5MykhDcFX23Z6gD/890nYghwCq?=
 =?us-ascii?Q?4nUE2O7OolIhqERRuwmzsxCNxA6xBrGhdMo80zS3RrBz42s6kCaN04wnW92C?=
 =?us-ascii?Q?aBQoqneXUdbna5wWkNa317e3wlb218o+Dfks/WEGBodXjL0NmLc8WK2ovpHb?=
 =?us-ascii?Q?PZA95nLOki+uwby0Liu7ocppx8K5EwEjQ/vJ36bVnsQOvsegIVmznLZpCD/s?=
 =?us-ascii?Q?DVxlUSzCoIcyON+kR+82Wm5b+x5fd9JCPGYQEeSYi+k7c0TAeV4q1dnBaqnz?=
 =?us-ascii?Q?SCZaSyZMC3S30ZIKCulJv/2h++Oz8KgC0AqWSuVtcvN6LHDPrtg8lcrgTzlX?=
 =?us-ascii?Q?n2ExYbIBhJAnJWjdp9nx/sXSUSQp222KqrCo0KqNVtLGJ+wTxT8JDdsgGtJs?=
 =?us-ascii?Q?T4a4ZJGXs5Ut7jR7IVjwoeOCDJblxQ6TkNPsfZW/WyM6+dRUqa9G5ffNV5tD?=
 =?us-ascii?Q?ioLTSjnpJgDjYq7uogp7olg9sQ41FIBcBlG+Fpk+h7MmJf+v5IqQAB34YWx/?=
 =?us-ascii?Q?Gj4Ols4EXm6O0nhB06Eyfh1fx6yCtmNbXJTBZj3bxgtSYI7hxFG2ofLxJS4R?=
 =?us-ascii?Q?FB83VMVcnTNQ6MisT/6FSJjtyviQ04Xlz2tfHs94XZMYBWdHB96zy/RhtQHZ?=
 =?us-ascii?Q?XLf0ejfkUZUp9YmpXPO2AgVjDae9chIoORU7to6Es7f3FoiDWWRjPzXVsdPG?=
 =?us-ascii?Q?4WTm0dk4+ynP4VCceq44oXaII9Olxrz1Ijb/cPRPDxDip5xPbDSdAXPVh/0E?=
 =?us-ascii?Q?BCQGWdm7R0wtzKVCgJPMUZ8cXgey5rlSlCLfXBJYCUZxKeyHcMHqPX645rLQ?=
 =?us-ascii?Q?K+OO2SnGc5AUUHDjFbE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbbe05d-1fb1-4736-d325-08dbcb8053a6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 00:07:02.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2sx6t4H6atNnHnWiDYbXPes6Fo3X9JHw4Ro922KEv5iGVa08GiKpRtn0ThRsUUT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_553417F5-1D0E-49D4-A79F-8B7D1CFC35E7_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 10 Oct 2023, at 17:12, Johannes Weiner wrote:

> Hello!
>
> On Mon, Oct 02, 2023 at 10:26:44PM -0400, Zi Yan wrote:
>> On 27 Sep 2023, at 22:51, Zi Yan wrote:
>> I attached my revised patch 2 and 3 (with all the suggestions above).
>
> Thanks! It took me a bit to read through them. It's a tricky codebase!
>
> Some comments below.
>
>> From 1c8f99cff5f469ee89adc33e9c9499254cad13f2 Mon Sep 17 00:00:00 2001=

>> From: Zi Yan <ziy@nvidia.com>
>> Date: Mon, 25 Sep 2023 16:27:14 -0400
>> Subject: [PATCH v2 1/2] mm: set migratetype after free pages are moved=
 between
>>  free lists.
>>
>> This avoids changing migratetype after move_freepages() or
>> move_freepages_block(), which is error prone. It also prepares for upc=
oming
>> changes to fix move_freepages() not moving free pages partially in the=

>> range.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> This is great and indeed makes the callsites much simpler. Thanks,
> I'll fold this into the series.
>
>> @@ -1597,9 +1615,29 @@ static int move_freepages(struct zone *zone, un=
signed long start_pfn,
>>  			  unsigned long end_pfn, int old_mt, int new_mt)
>>  {
>>  	struct page *page;
>> -	unsigned long pfn;
>> +	unsigned long pfn, pfn2;
>>  	unsigned int order;
>>  	int pages_moved =3D 0;
>> +	unsigned long mt_changed_pfn =3D start_pfn - pageblock_nr_pages;
>> +	unsigned long new_start_pfn =3D get_freepage_start_pfn(start_pfn);
>> +
>> +	/* split at start_pfn if it is in the middle of a free page */
>> +	if (new_start_pfn !=3D start_pfn && PageBuddy(pfn_to_page(new_start_=
pfn))) {
>> +		struct page *new_page =3D pfn_to_page(new_start_pfn);
>> +		int new_page_order =3D buddy_order(new_page);
>
> get_freepage_start_pfn() returns start_pfn if it didn't find a large
> buddy, so the buddy check shouldn't be necessary, right?
>
>> +		if (new_start_pfn + (1 << new_page_order) > start_pfn) {
>
> This *should* be implied according to the comments on
> get_freepage_start_pfn(), but it currently isn't. Doing so would help
> here, and seemingly also in alloc_contig_range().
>
> How about this version of get_freepage_start_pfn()?
>
> /*
>  * Scan the range before this pfn for a buddy that straddles it
>  */
> static unsigned long find_straddling_buddy(unsigned long start_pfn)
> {
> 	int order =3D 0;
> 	struct page *page;
> 	unsigned long pfn =3D start_pfn;
>
> 	while (!PageBuddy(page =3D pfn_to_page(pfn))) {
> 		/* Nothing found */
> 		if (++order > MAX_ORDER)
> 			return start_pfn;
> 		pfn &=3D ~0UL << order;
> 	}
>
> 	/*
> 	 * Found a preceding buddy, but does it straddle?
> 	 */
> 	if (pfn + (1 << buddy_order(page)) > start_pfn)
> 		return pfn;
>
> 	/* Nothing found */
> 	return start_pfn;
> }
>
>> @@ -1614,10 +1652,43 @@ static int move_freepages(struct zone *zone, u=
nsigned long start_pfn,
>>
>>  		order =3D buddy_order(page);
>>  		move_to_free_list(page, zone, order, old_mt, new_mt);
>> +		/*
>> +		 * set page migratetype 1) only after we move all free pages in
>> +		 * one pageblock and 2) for all pageblocks within the page.
>> +		 *
>> +		 * for 1), since move_to_free_list() checks page migratetype with
>> +		 * old_mt and changing one page migratetype affects all pages
>> +		 * within the same pageblock, if we are moving more than
>> +		 * one free pages in the same pageblock, setting migratetype
>> +		 * right after first move_to_free_list() triggers the warning
>> +		 * in the following move_to_free_list().
>> +		 *
>> +		 * for 2), when a free page order is greater than pageblock_order,
>> +		 * all pageblocks within the free page need to be changed after
>> +		 * move_to_free_list().
>
> I think this can be somewhat simplified.
>
> There are two assumptions we can make. Buddies always consist of 2^n
> pages. And buddies and pageblocks are naturally aligned. This means
> that if this pageblock has the start of a buddy that straddles into
> the next pageblock(s), it must be the first page in the block. That in
> turn means we can move the handling before the loop.
>
> If we split first, it also makes the loop a little simpler because we
> know that any buddies that start inside this block cannot extend
> beyond it (due to the alignment). The loop how it was originally
> written can remain untouched.
>
>> +		 */
>> +		if (pfn + (1 << order) > pageblock_end_pfn(pfn)) {
>> +			for (pfn2 =3D pfn;
>> +			     pfn2 < min_t(unsigned long,
>> +					  pfn + (1 << order),
>> +					  end_pfn + 1);
>> +			     pfn2 +=3D pageblock_nr_pages) {
>> +				set_pageblock_migratetype(pfn_to_page(pfn2),
>> +							  new_mt);
>> +				mt_changed_pfn =3D pfn2;
>
> Hm, this seems to assume that start_pfn to end_pfn can be more than
> one block. Why is that? This function is only used on single blocks.

You are right. I made unnecessary assumptions when I wrote the code.

>
>> +			}
>> +			/* split the free page if it goes beyond the specified range */
>> +			if (pfn + (1 << order) > (end_pfn + 1))
>> +				split_free_page(page, order, end_pfn + 1 - pfn);
>> +		}
>>  		pfn +=3D 1 << order;
>>  		pages_moved +=3D 1 << order;
>>  	}
>> -	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
>> +	/* set migratetype for the remaining pageblocks */
>> +	for (pfn2 =3D mt_changed_pfn + pageblock_nr_pages;
>> +	     pfn2 <=3D end_pfn;
>> +	     pfn2 +=3D pageblock_nr_pages)
>> +		set_pageblock_migratetype(pfn_to_page(pfn2), new_mt);
>
> If I rework the code on the above, I'm arriving at the following:
>
> static int move_freepages(struct zone *zone, unsigned long start_pfn,
> 			  unsigned long end_pfn, int old_mt, int new_mt)
> {
> 	struct page *start_page =3D pfn_to_page(start_pfn);
> 	int pages_moved =3D 0;
> 	unsigned long pfn;
>
> 	VM_WARN_ON(start_pfn & (pageblock_nr_pages - 1));
> 	VM_WARN_ON(start_pfn + pageblock_nr_pages - 1 !=3D end_pfn);
>
> 	/*
> 	 * A free page may be comprised of 2^n blocks, which means our
> 	 * block of interest could be head or tail in such a page.
> 	 *
> 	 * If we're a tail, update the type of our block, then split
> 	 * the page into pageblocks. The splitting will do the leg
> 	 * work of sorting the blocks into the right freelists.
> 	 *
> 	 * If we're a head, split the page into pageblocks first. This
> 	 * ensures the migratetypes still match up during the freelist
> 	 * removal. Then do the regular scan for buddies in the block
> 	 * of interest, which will handle the rest.
> 	 *
> 	 * In theory, we could try to preserve 2^1 and larger blocks
> 	 * that lie outside our range. In practice, MAX_ORDER is
> 	 * usually one or two pageblocks anyway, so don't bother.
> 	 *
> 	 * Note that this only applies to page isolation, which calls
> 	 * this on random blocks in the pfn range! When we move stuff
> 	 * from inside the page allocator, the pages are coming off
> 	 * the freelist (can't be tail) and multi-block pages are
> 	 * handled directly in the stealing code (can't be a head).
> 	 */
>
> 	/* We're a tail */
> 	pfn =3D find_straddling_buddy(start_pfn);
> 	if (pfn !=3D start_pfn) {
> 		struct page *free_page =3D pfn_to_page(pfn);
>
> 		set_pageblock_migratetype(start_page, new_mt);
> 		split_free_page(free_page, buddy_order(free_page),
> 				pageblock_nr_pages);
> 		return pageblock_nr_pages;
> 	}
>
> 	/* We're a head */
> 	if (PageBuddy(start_page) && buddy_order(start_page) > pageblock_order=
)
> 		split_free_page(start_page, buddy_order(start_page),
> 				pageblock_nr_pages);

This actually can be:

/* We're a head */
if (PageBuddy(start_page) && buddy_order(start_page) > pageblock_order) {=

        set_pageblock_migratetype(start_page, new_mt);
        split_free_page(start_page, buddy_order(start_page),
                        pageblock_nr_pages);
        return pageblock_nr_pages;
}


>
> 	/* Move buddies within the block */
> 	while (pfn <=3D end_pfn) {
> 		struct page *page =3D pfn_to_page(pfn);
> 		int order, nr_pages;
>
> 		if (!PageBuddy(page)) {
> 			pfn++;
> 			continue;
> 		}
>
> 		/* Make sure we are not inadvertently changing nodes */
> 		VM_BUG_ON_PAGE(page_to_nid(page) !=3D zone_to_nid(zone), page);
> 		VM_BUG_ON_PAGE(page_zone(page) !=3D zone, page);
>
> 		order =3D buddy_order(page);
> 		nr_pages =3D 1 << order;
>
> 		move_to_free_list(page, zone, order, old_mt, new_mt);
>
> 		pfn +=3D nr_pages;
> 		pages_moved +=3D nr_pages;
> 	}
>
> 	set_pageblock_migratetype(start_page, new_mt);
>
> 	return pages_moved;
> }
>
> Does this look reasonable to you?

Looks good to me. Thanks.

>
> Note that the page isolation specific stuff comes first. If this code
> holds up, we should be able to move it to page-isolation.c and keep it
> out of the regular allocator path.

You mean move the tail and head part to set_migratetype_isolate()?
And change move_freepages_block() to separate prep_move_freepages_block()=
,
the tail and head code, and move_freepages()? It should work and looks
like a similar code pattern as steal_suitable_fallback().


--
Best Regards,
Yan, Zi

--=_MailMate_553417F5-1D0E-49D4-A79F-8B7D1CFC35E7_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUoiiMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUj+wQAJjEDGIkl4CZdCioSVe4RxmycnY9CLK5r+2S
Whpz6eUaldMOFqJj9vzfUImIAxg606wsyOBbr6CJGQOG0J/T+vEDMq2RGt1QMzry
pJQLXx1LBmBwNLMkcLqcOvynrc9fjOENsBixgZYRO+T2LStrDyVyirWmcC7MVDz+
G2zi1x/5WiJT8kKq3vV+rtmZpJHMT0AeLhX+cI5rxK5Hmi1+uhdNl/QCgNjD/BjP
UDcwUhEkChRsCLm1JY2lGJtXmZm2Yg4IS4ecSaPDm/FFYmz9zWNTLLWG6kedbwpY
UY/dqyMXTiTE6mGK2e66px79zI1C3Yqe9Vyr7bTB6bx7cZzt8JcFPnlSKWGY+c4m
vDm6AOI7mRIIOlXaAovEbEXV3nlsBSqnRA54RpyLwCOFD381/76a7DzeKYzNFRrm
hMQCzFT3KLNQIc88/HQkNpwsjq+04bHSLxhQ+f/DZkUQyW9BTiMZoM01z5pPZZed
njapbd/kSbqfXsEV0ithoiOwfN8uGurGFplIbj2QCXwRurCS5w99LgwcTuAXSTVQ
PbvsJDbyjsT5WWPiBoMF8tF7JWplrw8cKkKywiiMTzGj8hbQ0fmDLcSM+a6LdlIZ
7JtFO7bVB8lk78erJJ9QX5zJJj33G5D5QgoegQFQOJwe3aJIF4cMa3qyfYxRPBWL
cCdZk9wB
=pv6x
-----END PGP SIGNATURE-----

--=_MailMate_553417F5-1D0E-49D4-A79F-8B7D1CFC35E7_=--
