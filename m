Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4FB7F4910
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbjKVOfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344295AbjKVOfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:35:39 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8758112
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:35:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkHlixHo3pH1yUZ86TXbQ0e+2sF1eyJGM8sS5rBqaX3r7h/CVhPNU0F4cYhyyD04hyfvzOUf432Ih03E/XauxbzXlEYOJ+Ah00ucAhsV6eK9CWactzvnNiQSzyoBJALUtvChrus6D5xQhT/44baRPkJ2Gn01NoeqEW8CptvGhH+PdMJe9mBzhPUEANClH9steuWRFy0jmfVU989/1cfjCuPctSqkaCt0p9BLPW9ja5YC5Ig4qEHLYbZPJJYXqXbjLhP4RGCsQAro8RFfv9wD1xlhGOK+McniMh+KJ1VeBG3UW8X7NCNCFbT8cWJi7sjQTCflRR6s8yw0L2jy3d1iRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2+oXsv7wZvESkf7/9p5Qstil5A3f46U7c1TCIgkTKc=;
 b=LyaNNIhfzdPaDvtOVeqFe41uc3Wht32r9DOEuAo0zzlB/4mqo11sKoRNrOdZKdvoSqSQiOyyK5JOTioMfH1FY5lI5BYl3UpiPolaG7zr7mlqD6aVPQu+cfqHGo8sXqK0cJ+2QdnnlgiXyeZjz9JwtF3T5ygcoAfO8A8YXNyja0IYEP0QfGuE1FAnR7T+GfJjdgXbMe8cKhat1ftGljt/rJtsqu7OEfZ6AbZMwEWMfMoIN1fTJPVK2a5rgAEfFWQ9Kkjce5IgqRSRb9zSgx4HLT/+w3h+wH+2bxGs60kU9sZXG5+FHr+o0JJ90o1cupM5Xvu+S9dGN7wJFgNo59oAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2+oXsv7wZvESkf7/9p5Qstil5A3f46U7c1TCIgkTKc=;
 b=nSp7LVQijbKcVsZPoilZH+pMKqXYn4xcsy8dOF7gZ3OesmSzBaKDzp6PbrIMilcRmHYIh1hoDhgA05+69YigRBakGhzEGhs/UXJY0E/gK5tnI3j0bML5UoCqFCp/lRVDL9aDzDb888ftpawW9UOL4LWSN/z0gOvuogCq4s6A6jXFd71bbd9b7HrebmVhQbd0VmoYi9P/H7UKQ3Fszz1p+MmCE8hY+pJC3U4DGFaEcIpnJpOOrigrL0nb2D3rif8c2zMkxkvTN0DYWGRHEK2+EnZwgcHwncpu57CT8/bhRqJg0xU9pgfryWtKn4X9mvwfg0mLlePxTYRzJcRif7rM1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.19; Wed, 22 Nov 2023 14:35:30 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::a7c2:45b6:7733:2bf1]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::a7c2:45b6:7733:2bf1%7]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 14:35:30 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "\"Huang, Ying\"" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "\"Yin, Fengwei\"" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v1 3/4] mm/compaction: optimize >0 order folio compaction
 with free page split.
Date:   Wed, 22 Nov 2023 09:35:27 -0500
X-Mailer: MailMate (1.14r5994)
Message-ID: <87F62FC1-62D7-451F-966F-0287B236941F@nvidia.com>
In-Reply-To: <e460ab6f-3ebe-441f-8f55-ce8d50bf078f@arm.com>
References: <20231113170157.280181-1-zi.yan@sent.com>
 <20231113170157.280181-4-zi.yan@sent.com>
 <e460ab6f-3ebe-441f-8f55-ce8d50bf078f@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_204F3E97-FA1B-4CDE-AEF0-31C796705E75_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0401.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::16) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 676f752a-3444-4f24-5e84-08dbeb6846cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9d+HLed8fQPI85aE+ILJ9rElcONJtTX/9EzOoPyHfKUtBsi9LDZUWi3a3yWnykwP2Uyfd28VjmceJ1msiQ4JjF8jVTE7Wb77zfiRMcJd9uR6j+ZbeumxzNBn2GtjrbgY36wefzH5+qhHRraDo3l2QbGSEPHCBLjCD3ivla+mj9p05Sxm/yfWlYXtMhwaQdsldAE0Zokx+Rec+PdyfzPea2rq5wwwk72IGQG4WUDhhlqF1NeGE/N7Yduk3jw7F0jUySU+z4znVRItggazLEkRr7NTNecxYw50St+6ANdumUzqohgI0sTViTRn9B8n9am58RX0TLwBOIwbnLskbFwlWE/289HIYM2Ywq+24mjvenPxv6M6kZYvUPAnpjts3Zx8RCC7mkk5xI+pm+WYn2b4o9ZL4gibH6udfa50l5m2CRejAfUZm6MdQdn4j3h7pi/xyOdx8T1V12m0Svc8rEMF1oIL4x5F/QrEkO86FWiRbPwtyP5Y0I9hDb9ySdSoECtLj5xV8ck3sA9b20TsXlw0Mg5JOy/jnP0xVjT7Kc/QQaIkiQYYFJSBtmlBifw5jikJ/BnDkFmkDPQDGyyNZR6TraSLxV++9IRgRQncxkNOZ1wyBWZkxnrHvZNAj5Kyye06
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66556008)(66476007)(66946007)(54906003)(38100700002)(36756003)(33656002)(86362001)(83380400001)(26005)(6512007)(2616005)(6506007)(53546011)(6666004)(6486002)(2906002)(7416002)(6916009)(316002)(478600001)(5660300002)(235185007)(8676002)(41300700001)(8936002)(4326008)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mXtSIUTkEEJib0+mXZc2HcZNp+wGiegzYtIjpLBHwXrdoJTIIA7DOURlBTMx?=
 =?us-ascii?Q?W8J/h+I2fop2Wjb3U1fxGdOzJK78z5N7/xu5BhSlGOSJcI/bJh08NDkTJLZJ?=
 =?us-ascii?Q?bYorctPuVbg/ptuGYTycf/yZdI0mVahYhSU161Dz08QXaKYCGPPCYXNdjvQk?=
 =?us-ascii?Q?6sdX/+U0v7dZlyR5iBgBuUQou4JXWrL+MN8IPNw9I/5yz8dux60UJpc8+1lM?=
 =?us-ascii?Q?KDJiVnNAiE6CxCjL4g1neFcrzx+jo9q9RSCRBFeMgA4l12MRx7PsDZq9VxsA?=
 =?us-ascii?Q?E9dx5PfJg994LOZDBbNQcfM3u7XwYyTJqarhKcnyy/tNm80AjbZbxhBttv1p?=
 =?us-ascii?Q?vdwVVCAevFRoGPfeU1EG3Ngp4v6ObInhBFnr4YeKwP14uTRjOH7cBdiy9PAU?=
 =?us-ascii?Q?eSFRNwJpL18hRSRjhF4/kQCkX88V8QNU5MDGXu9Ox1bkiOTBDcf31FJucwWy?=
 =?us-ascii?Q?5Q90GhCze/PE6MTcvVKpRknLuQyG+TUTVKbzx32/ueq7APzpEy3SkjuCfC+T?=
 =?us-ascii?Q?9pSrW6zs1n7CwYa1LFycBNflFQkqCC99vxi7hjrfY7GAj3lYrbV7FRpdn0Rj?=
 =?us-ascii?Q?IBWEeNy/txq0BVCLR/iMDnWEMQeewt9z56ugo6GcNaAYs4LK+ExI83VyR4bV?=
 =?us-ascii?Q?KhANCwgvL1AH6sEFbVJsX7e/8J9XoVuEg8/dWSrF/ns2/ACQW0Vshd7PkYjB?=
 =?us-ascii?Q?xskwM4yniTLUWbWBG+tg7krnV/WOxxWblwy+WRQ4mFzAIqq/bP777euz79QO?=
 =?us-ascii?Q?rH9SH55FMdxhGslasPLMMNSVzb0glLs8Z7wHgjmAlG4mu65p/0O5OfU7gcTK?=
 =?us-ascii?Q?9oZ4YCecbJaVdn2PW3QfvG+910XlnLo0EkIMs/RLo7/AdALZ5V0SiUEdioys?=
 =?us-ascii?Q?te4PoGN7oanHPnenZck1rLGdtzNlS671nVtraWn/8deuC8r1h+Fl43glGS/F?=
 =?us-ascii?Q?a1I9Eo2PpN0+KWbL1XAwY5CAT5mBT7s39OUJGI7Ku/KO03nrDpofgszFhPq6?=
 =?us-ascii?Q?KPkkY1sG0ctAXeXPXHdaf1mcdHUuBlvcjXLzwdf5sHMV4HYMb4RKpo8BZQl5?=
 =?us-ascii?Q?QNorZBTF7gOnUk+SsSVqY2JaExCFDnl2bdgiw0MYllfzETm4bpTdMkMxmKdG?=
 =?us-ascii?Q?EHNkBMWVv+DhP05hu/XJjOdKPIw6eLRppTjyquyWsXBOcvWPh77TNyZfCFam?=
 =?us-ascii?Q?A69lrQ4BwxtghkFwEiZUzJ3SzcigEYLDQ1uEd/y7hbA85wJw4D0N5hPI5Vys?=
 =?us-ascii?Q?sQuThb8Tt8NRFgg9tnwyc9I/D1rS+6qr793LWyY101xCYALvdFgyGV7bgraV?=
 =?us-ascii?Q?+1sCx+2rctjwDhPIEX2+BBCj81hXFuM5v4RKALjo0m73r5OjjpAI70N/1ggG?=
 =?us-ascii?Q?Ca2tg9pvF8GereRoONNOzlZXFeKOdTZWZTEJB7NYz1RGotsYn0IxEPLFfixT?=
 =?us-ascii?Q?0rmtrlVHAUkdz7Z9sgbxQivCaFoEWdiQFD7QQ7n7gC9+t8rUFYOO1bejHdoy?=
 =?us-ascii?Q?bkCkfk/2MhhCqwety7edp599IK8DjC0iIL5nui3ETrY48XAjZh9APD00gDOX?=
 =?us-ascii?Q?EaxzNZWn2TZNForUw85673qltVWUS8gmVmlCjCY1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676f752a-3444-4f24-5e84-08dbeb6846cf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 14:35:30.1476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0k50yETPGBBWKWGdJrsERW4/HseKWO5RT8evn/arcx+fU8arxOIecCN5l9cTXh3W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_204F3E97-FA1B-4CDE-AEF0-31C796705E75_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 22 Nov 2023, at 5:26, Ryan Roberts wrote:

> On 13/11/2023 17:01, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> During migration in a memory compaction, free pages are placed in an a=
rray
>> of page lists based on their order. But the desired free page order (i=
=2Ee.,
>> the order of a source page) might not be always present, thus leading =
to
>> migration failures. Split a high order free pages when source migratio=
n
>> page has a lower order to increase migration successful rate.
>>
>> Note: merging free pages when a migration fails and a lower order free=

>> page is returned via compaction_free() is possible, but there is too m=
uch
>> work. Since the free pages are not buddy pages, it is hard to identify=

>> these free pages using existing PFN-based page merging algorithm.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/compaction.c | 40 +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index ec6b5cc7e907..9c083e6b399a 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1806,9 +1806,46 @@ static struct folio *compaction_alloc(struct fo=
lio *src, unsigned long data)
>>  	struct compact_control *cc =3D (struct compact_control *)data;
>>  	struct folio *dst;
>>  	int order =3D folio_order(src);
>> +	bool has_isolated_pages =3D false;
>>
>> +again:
>>  	if (!cc->freepages[order].nr_pages) {
>> -		isolate_freepages(cc);
>> +		int i;
>> +
>> +		for (i =3D order + 1; i <=3D MAX_ORDER; i++) {
>> +			if (cc->freepages[i].nr_pages) {
>> +				struct page *freepage =3D
>> +					list_first_entry(&cc->freepages[i].pages,
>> +							 struct page, lru);
>> +
>> +				int start_order =3D i;
>> +				unsigned long size =3D 1 << start_order;
>> +
>> +				list_del(&freepage->lru);
>> +				cc->freepages[i].nr_pages--;
>> +
>> +				while (start_order > order) {
>> +					start_order--;
>> +					size >>=3D 1;
>> +
>> +					list_add(&freepage[size].lru,
>> +						&cc->freepages[start_order].pages);
>> +					cc->freepages[start_order].nr_pages++;
>> +					set_page_private(&freepage[size], start_order);
>> +				}
>> +				post_alloc_hook(freepage, order, __GFP_MOVABLE);
>> +				if (order)
>> +					prep_compound_page(freepage, order);
>> +				dst =3D page_folio(freepage);
>> +				goto done;
>
> Perhaps just do:
>
> dst =3D (struct folio *)freepage;
> goto done;
>
> then move done: up a couple of statements below, so that post_alloc_hoo=
k() and
> prep_compound_page() are always done below in common path? Although per=
haps the

Sure. Thanks for the suggestion.

> cast is frowned upon, you're already making the assumption that page an=
d folio
> are interchangable the way you call list_first_entry().

To save the _compound_head() in page_folio()? OK.

>
>> +			}
>> +		}
>> +		if (!has_isolated_pages) {
>> +			isolate_freepages(cc);
>> +			has_isolated_pages =3D true;
>> +			goto again;
>> +		}
>> +
>>  		if (!cc->freepages[order].nr_pages)
>>  			return NULL;
>>  	}
>> @@ -1819,6 +1856,7 @@ static struct folio *compaction_alloc(struct fol=
io *src, unsigned long data)
>>  	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
>>  	if (order)
>>  		prep_compound_page(&dst->page, order);
>> +done:
>>  	cc->nr_freepages -=3D 1 << order;
>>  	return page_rmappable_folio(&dst->page);
>>  }


--
Best Regards,
Yan, Zi

--=_MailMate_204F3E97-FA1B-4CDE-AEF0-31C796705E75_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmVeEa8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUviYP/00dcmxngEPMjwbAfma/X/AYfVtwsiVlPL4c
UJTOMidA5dJfa1Bn0I8W2VpWITlITqbPHc4g7/7Amc5aM9P79y+6zF8YZaeu4vWA
bQh7OQDnrGPAWcAOaUnIwI2d5S1daVg66suLdN7efUZOH9oqhL7iMgLZTG7/TwCH
yXD2LQH5gg2sBuHNitlOuXsGsakee12cPHyTV3SkOwHR9w1H5WWdzPrg/TK4MsRo
gWekPgYsKVyKjmBkCyg2F2oWs6Xbk3Bu6xqTQFQ5T1NB4I78B2zJrAVBVzayfUJ1
Uku3e+8LNIPbqbRGWleLZkOyszpqA/EJkob9bNrEyG9syBSB3vCuHAHIgkH834g1
Kou4f4+py2NCmiBoo849Y6mGownNv9TOKyVeOWJKNxtM93WIDm6bRZqLF17ToVON
m/5RYtPwM6OHDTLUXOGZGZeMJj4rjwjfC+OqOuayeZj6Q/sSnYONszgv4zDmnol5
LSha6J+42Nxet80PDmtG22vbddLQUePL8PThYPt2e0Fs9p/OdfAHFZmQBhiaBWX3
114XgvhhMY7HrHoBiSCM1RNpgH/Jndy37EhKGI99TPaBWTyQ9Cig+cQXw/wDFQKf
oqyiiBnJAz3dZ1UXUS2/lteTYnADG2dQj6596nlt+ak1wWhKFF4f5WUghYuwPrjf
XWe6RpoH
=EMRr
-----END PGP SIGNATURE-----

--=_MailMate_204F3E97-FA1B-4CDE-AEF0-31C796705E75_=--
