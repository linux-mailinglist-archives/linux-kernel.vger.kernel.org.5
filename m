Return-Path: <linux-kernel+bounces-158746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6A98B2469
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4E9BB27DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF7414A4F0;
	Thu, 25 Apr 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hAL8d9EH"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3372812BE8C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056833; cv=fail; b=nbBtPcRFQ/Y+SD8hU4KokZse0i2ffmBrq+cxHRy+pULD28lq6nmHUIJkk6pq3tfe5oPgaGny/XdiJ7sgpuooBSJoINMPzV9iUmWK4K/yRIDGJv1YSa03oT+UEqbQ3I5BOo63Y3+LaK71W5VrDo1QoMsLcJ6w8rkk9vT6Z6CanOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056833; c=relaxed/simple;
	bh=LZ0WOgSBuyKf95Ntv1eli2G00uvpit1l2Rn/st5lO34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tAiPkza/vuF4t0QmfWQ7AwmmI6qICOgL9ORgge1akGTIyzl3bfEAghFywZh4woJSTgqSMQhjAiETJdhFEWPowW9KNZHKxdKSXEhAsw+3QtPFe1u4nkinud0KVN+4LHnNaKyodOZJj6tPlcxyFFScxgAtV98n9xOAZ3mGFZe4qzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hAL8d9EH; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTdMbhT5GG8VfCqnp7h4jUsrrQUQNz1mUkDt5hlfr5U0UEEu7rjiVPHUk4yzScDrLd2xaxVAgOFfNui3rEaQKqXE91vVDrO/7R+35Fe//bulFcFsGl2CqwwIaBA0/R55LDC9T0eFQtNzneps25dx7LdAU8SpgI4yOULj1zRIvp9icAL6Ni/nxxNbeM0JtWqAHxPEWLu+/FrJHqjpBnd6pi882xA3NgKihQA7T1YCDw9/qROxd68EOOy6DTXH0iZNr8wjCnX3e3YMJX+6GIULxDRzLpWe2WhNE2mcUzI7+tf979azpbwZU/LtLX7PIHlYYkvI7tUC7Q9DoX/JB8uKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iu5e2SMl7Jrb/eNvmZy1eNsAEM9+YTHoKm+q2z6HkHc=;
 b=GZW7dnJisqJJ0UYZQWtCrC4TmEVmjDmm/xctoFu0FcXOxai+1qh8CIN4IFfQ5jegmu1MSyFIBA+wZ98QGhDuxOraZXlKt0lJ0vz82tlR6YvPxyyPxMBnvEZeWmK72HL5YqDaARjXx8hIDock/fc/rUaaYsP+ASu3+m/da1hQyBaMC51az42+oHGpg5oWOfDgNJP74RE8eNATrrL1hsy2HG6fn1rTtG5QYZhq8Abq9RFS976LQYztGywOicT1OLCfPa14IxSHP2cyLItSLXpcTR+rHNKgzarzU4IylbRgCvnxbavofBP5V8yp2RBveStq2r/+1oOLzXuPK9MwazTQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu5e2SMl7Jrb/eNvmZy1eNsAEM9+YTHoKm+q2z6HkHc=;
 b=hAL8d9EHkG0zXhN8G2+xYYJQCD4QoUfM8fdVVvkOP5hGUsT94rin26rO6gIXu9bDk33mw/wG/W6Ow9HnA+xLENUDWhxGp6+sxDiSJjffRKTsHwz/Cts4HA9nGtfsh4IXTLZzZmTEVrHTxvH/qhlEhtvT6IWdaxi/I4l1NDHBswvp6TrfcbrNViGkaJ97Hyv7R/BXoQtIwFKDWOS2qimmi0AouF+/QAZcKpkryGGrB0ivsiE6yerAoBrrE43KEqTjuh/eHKxueCoenh6meLB61n4l9nVGj1Awg/PGmjPHeAHAU49cuAcL1lXrcC0ssk5NDyqLxWlXyvTQu0Fe4Mv6dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB6764.namprd12.prod.outlook.com (2603:10b6:510:1ae::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Thu, 25 Apr 2024 14:53:46 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 14:53:46 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Thu, 25 Apr 2024 10:53:43 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <8BBD1B75-135D-42AA-8937-53B259803AA7@nvidia.com>
In-Reply-To: <a5426fa6-442a-453f-a234-63d89675ea79@redhat.com>
References: <20240424224614.477221-1-zi.yan@sent.com>
 <a5426fa6-442a-453f-a234-63d89675ea79@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_88369472-D40F-4247-8648-2A92C1E93C0C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::26) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: d08ab1a4-4c3f-435c-54a5-08dc65378204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CsxIpHqZgMsEFlcaQutWN/34o7hLaVwE5Shjllo7iJZDM8uK+Bg56kOiLb2E?=
 =?us-ascii?Q?2RCIfEnyFjdq0XalM/QduPZQtvDE6PRiPYCLnmIagsJ0uEpM/5yLy2cmcJzv?=
 =?us-ascii?Q?kfrtAfMPeyZ9rO88q7G+oXukpgcZMMqetfKGJJi9qR9EmArqIWNcFKpPplr4?=
 =?us-ascii?Q?XtAnWvd9X3aeiqbAw1AI35HK7jQqM5im6e8YjDVpLYR8zphR9gkQfJTuSRIJ?=
 =?us-ascii?Q?vcCfgWkGxqQs07iiFMZaEkXoGCRdfbeHM8XwZ4dbyh2pBi64H/difrLeETuf?=
 =?us-ascii?Q?ecUzY9vNx/8yHAcFLNr2eAVMqg5nGSeQf7UvOoBbL4G2lui4k7/zzsMJQqlG?=
 =?us-ascii?Q?c5Lt055xnAENXdQlzuiXrD9gHT+im/xSj8SEYR0jpKcM/sgYp/9W1Ok8tu3C?=
 =?us-ascii?Q?KxRgRXBklPG8gFnOXZVLrtA6i6c/IRtFrTMlouEHLRuZRxOu7BOvy8saaHEo?=
 =?us-ascii?Q?YeWSh5d6i704iLQr9csr/Tqg48nXhJjuYv/ug5oxr32asF0IKgDyfJQUjvvk?=
 =?us-ascii?Q?UpZnzQ5FcXe84gUfiw/CQoJ0RoHg8iEUj7t3qsnzWlLt5/XGOjK/tcpotrMk?=
 =?us-ascii?Q?1hW1qYM+DGq9b7S64K5JtG3z+dHpp2ZBNPHK7kctd85em+vPi9N2aJjV1XH/?=
 =?us-ascii?Q?Uw3oN8bP+WYTcVgTzymgA7glY39it/C3KeR4RmZvlxn6xBVug4MEJzlCNkzz?=
 =?us-ascii?Q?+RSR/3aJDortOao/s2Fq83AAaNDHgvd0IBi5FKFZgk5Agigcu4iRPaAuUuk0?=
 =?us-ascii?Q?8i/ylU0D0HBHQXTZr8vsxtkVWW4AJccYhgvwKPb2LNWKG34nOldeY8ErozGn?=
 =?us-ascii?Q?N0heet58HgYGmJWgvpHghxbaTxH70Qhl/Aj3h6u1/LIZ20FlN62jG9p1Fuiv?=
 =?us-ascii?Q?VfeRfY6a+4eYtpYsZDwUiQQugXmaRjPW3CQ/Hgysc/NoXUJTCXxavk+HqJEd?=
 =?us-ascii?Q?veN/gnI8VOT6PcLoo78OrNBcqucotP8cn3403e/pkhjMeVrM4+k3eW5xiuY6?=
 =?us-ascii?Q?0Q2rpM0a/nr9qX+1DgilsCNA20lJshmrHtj4JRijp0gL9AvjMouMXdVSWH4Q?=
 =?us-ascii?Q?LUOeqTAq2C9ApvLMwMKt+HsJetM1LzJMMglD0J3mDkHwmXLSt6cXxm1H54e5?=
 =?us-ascii?Q?zs3+gQWAuGY2qzJKYRe5g5OrTL6vlhxe7um0ls88lDhEwnorji1kGPAb/q8R?=
 =?us-ascii?Q?ozRlKz3jBIAAIfFllLHfZealHgl6F3XTZRZqCrvoYfF4UYMMEsvkwwuO3CIl?=
 =?us-ascii?Q?6OxBFWkIs6leA6QA5+ASe2LXmdpvKjLyZpLL3oHjng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rJ6NzQF5VDH4xVqMJc2sqcPt5MCvpF3pUVZQcm1wKszukrGHWMQtVfUKpALa?=
 =?us-ascii?Q?37Q3RsDpJiYesh2DN9YX6nzptQtpW07Ji6sx/Ur2HC/vQu+V+r4/q0tiouho?=
 =?us-ascii?Q?sOZ5bQqPYtEku++Ra7qwFtLG+zSBY1ZBGGQnBBFSRZBgPaCEoniwyUkYTuMm?=
 =?us-ascii?Q?ZYPr9Oi1CcUOM4rc/fJcCaCYv/r7xqv9PiS/kvhBmoZyepTR8rH2Tcjd7H2w?=
 =?us-ascii?Q?XTBsSieJVgZ/2uSsx2ZXKwh4kvF8aKLjG/3QDaxofj4ra+1bq6rJtisFJoPZ?=
 =?us-ascii?Q?lRu7INASNVXWFxZzfxeL6Fa/C1eLU30rpwI5CZkwZdSi06eISvuKLA8bBY54?=
 =?us-ascii?Q?1Z+zVyJVtPHQ0K+prig98B58GqFsR5zOIGNjfnVZpyZ8PH+8TjSMnoReRQSY?=
 =?us-ascii?Q?DaxzqrXD2lD4f4k44FOIVMAGPhjJYp73JkcuqouWAccIoutP/MaIH7MpmOl/?=
 =?us-ascii?Q?hB0c/qH/adsOQ09+RC6ILNG1LYRR9BmlGS0NhoqNA1wAPp0BWCwDkhu1NqTo?=
 =?us-ascii?Q?TaiUpFNuwJvB0V56VfApE+NbO4R2FXZqbTF2r8drinzggl+iGsBN6C1UefBM?=
 =?us-ascii?Q?7P97dUOWhLYUmU+8JvAlFq1I20u8CWTW/NltCPvM4Z8MzUMxixVLPUM7N4G7?=
 =?us-ascii?Q?5X7hE9ecgjy6P7Z4jwOTAjM16PLfE6+EOhuBh0p2zt1l63/0ZJzwi1zcGM6t?=
 =?us-ascii?Q?iDNh2gaRmOjEMDiP83qelgj72Fo/HrGx/a+S8C97L5YhCJXOePTCVRnAgntJ?=
 =?us-ascii?Q?kD52iSeMt42pYMjpIAVOCKTS4alcpakj68Sy2kI4mE3VOZYUuE/6O7l5Ebsi?=
 =?us-ascii?Q?xCqzpTVeRgxOjtA5FaOHvK4YD9hsCLNijztP+Agp8ip/EANC+AjDYkXORO4I?=
 =?us-ascii?Q?BCN+PTRuRcdtA8N43L25K94oIa/MdZqo30Y3HPuhw68Mb975fapLojaWBkmr?=
 =?us-ascii?Q?qmDIYxBGssAbGX7vdXtkMCrJwpgUBa7PihqqNOLISmwTEP2ROJU+Hta8K1i1?=
 =?us-ascii?Q?+3jzPwTWQ+eQqK/N2EroYUnDaXHN6ymRIz46Cg5x6/wS66z7sCe7WsMedJRY?=
 =?us-ascii?Q?baPYyAQSfRjP3pwhswA8JSQm8y+yKf81gjGQOI9SRQDuTj4eo0pkfAJjBo+I?=
 =?us-ascii?Q?J7sibaj1y9QPDHQmLtsAZsqlh9AW7g6e+7v1fdNEgwekd0VFRYb6+uYbq79C?=
 =?us-ascii?Q?ndiWbTzKTndXCxoumte3rQyGofTcJdFVpycWxxFm8JtMyVnnTYrimuwWoTQM?=
 =?us-ascii?Q?2WglOE7aRUwSQSU+r7L1Sl657fviO7VEvuJzYexdYGZgra8+tChtLm3ntgA/?=
 =?us-ascii?Q?chUZTx4me0IraISqg2UpjuUw8WEyG7MI/fXF7bEFGujCVKiF84rE06sXpjx8?=
 =?us-ascii?Q?N9tG2d5SQVJV9G0Kve84lrm8DozUV8WNMIaSwXp0N+Q4t3nBcQ6PuWPrm/q/?=
 =?us-ascii?Q?fQ1nM2SViEURXcCXZMzhq0KQd6sFy075AbFl3ykQ1zQKUcQg7PyrpHm+28Vr?=
 =?us-ascii?Q?LsJ0w32geM5GEp5G4XTouk9w1uJd5iZD9o8hRKcCB2EbqhQ4sryYHmrgi0io?=
 =?us-ascii?Q?ScrF/Jie08yP4SFPF/fC1/UpP4ie7o080S6HueEm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08ab1a4-4c3f-435c-54a5-08dc65378204
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 14:53:46.0292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHYXr4VJWtSvBmjZ+lotfXiyQRCb+ViZEVDogZ2zTKFHo39l1Th0OW7bfKkoxTgI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6764

--=_MailMate_88369472-D40F-4247-8648-2A92C1E93C0C_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 25 Apr 2024, at 3:19, David Hildenbrand wrote:

> On 25.04.24 00:46, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> In __folio_remove_rmap(), a large folio is added to deferred split lis=
t
>> if any page in a folio loses its final mapping. It is possible that
>> the folio is unmapped fully, but it is unnecessary to add the folio
>> to deferred split list at all. Fix it by checking folio->_nr_pages_map=
ped
>> before adding a folio to deferred split list. If the folio is already
>> on the deferred split list, it will be skipped. This issue applies to
>> both PTE-mapped THP and mTHP.
>>
>> Commit 98046944a159 ("mm: huge_memory: add the missing
>> folio_test_pmd_mappable() for THP split statistics") tried to exclude
>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does no=
t
>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still=

>
> Once again: your patch won't fix it either.
>
>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().=

>> However, this miscount was present even earlier due to implementation,=

>> since PTEs are unmapped individually and first PTE unmapping adds the =
THP
>> into the deferred split list.
>
> It will still be present. Just less frequently.

OK. Let me reread the email exchanges between you and Yang and clarify
the details in the commit log.

>
>>
>> With commit b06dc281aa99 ("mm/rmap: introduce
>> folio_remove_rmap_[pte|ptes|pmd]()"), kernel is able to unmap PTE-mapp=
ed
>> folios in one shot without causing the miscount, hence this patch.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> ---
>>   mm/rmap.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index a7913a454028..2809348add7b 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1553,9 +1553,10 @@ static __always_inline void __folio_remove_rmap=
(struct folio *folio,
>>   		 * page of the folio is unmapped and at least one page
>>   		 * is still mapped.
>>   		 */
>> -		if (folio_test_large(folio) && folio_test_anon(folio))
>> -			if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmapped)
>> -				deferred_split_folio(folio);
>> +		if (folio_test_large(folio) && folio_test_anon(folio) &&
>> +		    ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mapped)) ||
>> +		     (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped)))
>> +			deferred_split_folio(folio);
>
> Please refrain from posting a new patch before the discussion on the ol=
d one is done.
>
> See my comments on v2 why optimizing out the function call is a reasona=
ble thing to do *where we cannot batch* and the misaccounting will still =
happen. But it can be done independently.

Got it. Will keep the deferred list checking here and send a new one with=
 commit
log changes too.

Thank you for the reviews.


--
Best Regards,
Yan, Zi

--=_MailMate_88369472-D40F-4247-8648-2A92C1E93C0C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYqbncPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUAvkP/2Ek9m3XjgjHJHSn5uJ5CccVGind9sG+/uQ9
HZn98ap4OfjNTBguPRwl5YloFnsSzfQXVkG7+5iGn3j0uSppAcPUD6TkHq1KJ9M9
HrUTXPmeq4gQv72lL622HQ+lmHHsHhviyfEWnBBJCQahXMKsRaD7T97IlKKL0RCp
tmdqEyFfBTiB9uMlj8dYXCz8FTEnapRqOfaOcU3OHmQFMxc5WJBLDc7Ug7eQ6Mbe
I4TXv1AkQcXkrZgSu2m4t1lHughp+GwestQGVZe+75lGajmDMq2ZE4/o9ArzM9bw
eDPGIZ4moevgWYjRHahwzeh8BI6uaf98M9O4dGP1TzQBQTQaIkTb3A7u3qqhEBS/
3Zt8FFOS7VA8EDeRXHbwPk0LS80LUe5LkbV5Ryy3kvHwz1GxFHVVocV8HdHgRrmx
/Nvu34+Mp/dQGNEuWNCBLXbpllvRpo9Vd/+xY6jJkdh4xLH/ZH99UXpbVE/i8HxC
akQEUDaes+tDytG036ZaaxvwUOpMBHfpivPN5NSm5I0krtq3yasnKv7gf+/s1MEM
Bi32BSTGqHXUVtyVyxC7Oug9jPevHCvURcy5PR5t9HJptMDV5gVdDLlrp2X4KgRb
KZpt4e7U0slaPQAZdtEuAkI2hcqC+iZpc451MqtQxk/FUPumGEPsksv0ILajtOkE
xt+tRalx
=jmjC
-----END PGP SIGNATURE-----

--=_MailMate_88369472-D40F-4247-8648-2A92C1E93C0C_=--

