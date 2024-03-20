Return-Path: <linux-kernel+bounces-109161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 057AE881592
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF398281D18
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45654BF7;
	Wed, 20 Mar 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ADfMT5GJ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B14F1E5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951898; cv=fail; b=T7En3ZmmxTH7WWnezzIQYIB8MA7o5GJpxGeFd+3sOPB9yNJ4LsD5vxY3vR/drugBcOWyddlYcsxhy4sjWBQZYNm/h/v58PU67vnoOM+592zFcTdO58Dy5wgTJsjH0kRaFc9Sonp5mlxJIOY+encGE5XHo/+wOyF62h9rUUOh5zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951898; c=relaxed/simple;
	bh=7RmQZwieo+GL4Vu9Gc24Y2R+f/COXG5qM9WoYb5O2jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sa3I2hJ/mgcxJQYGx7nxAY2OCMflsN5k+/OZVQys3PkPeu97pfcBj0evFQA+O2xto+DT+muv+Yj1Jche1FgYvjulCcyvIYGdLttaabKKSkEDOn034LtLgTOBbXiQBiABCoyFOAPNVByU9vqIipQ8VmFcu8/AXwYDbBA23IP6QZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ADfMT5GJ; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/lVuVuHt9sTwvSA5K00cDdqhaVOtFletBeDyk8XnhxBjQvMAVE4uRn06j5HUS497imsI+AnLwowtY6zecDHDOWFgjvuW1cs5v3gaMqdhm+KHZUnvHFI8fFjLRwdb2us0TDWJKF5dH06HfpeaQpf3qK94HEA/v7xIWr4K1DsEXaR2DLhrr2bC+wRsjVjnSO3pdywvhJnG5fCXI4EIjjkEm+bW+bF+aIefghnhutHDNcoDXlSromBWmoPqS//jUqv3dz2qNaEVOsBIJmgdQv8edwhKt3H9mS6p4JG/K2UOsdt+A8SKko/WSXSBXHZ6OVZAnhMqC/JVGhHETcHV/chpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvskVY2Hke0bUzLx+I9GIqfbD3O/4mepOJrhxn24RmE=;
 b=MWi0YOprpBjueG6PUFnnBMSrfTeSzvni1JjPiAyziK1+nHsaatX/wugRlTFhNHYGPGkt3WW+BAfaImuA35uYvXad4lqMGrM0lCd+ih5hz589Y0tzE9oWbtoYLhY/xOaMLHMimdv89PKWQ5eLvppOmaoDIPj5aViXSGbpMOEG3W2Ex1iOXWzZIFrER2xTqbWwxj4VK3EI7CMBxXAy9NTFB5DkV8LhLw/44bF4Dq7jemroa8P7gI26wKMdSfCMdDqj2EdMtvi8C1S4IfNl1OU0/uZPYCRdCpTaTj4KkqRw8yijiMCmdt3JhEaQrKZ4T0MwFZhHcMkTm4Pa1GXH6yTWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvskVY2Hke0bUzLx+I9GIqfbD3O/4mepOJrhxn24RmE=;
 b=ADfMT5GJWjbSDpRuPAlOD/z9q31ids0zC7UeuDuOSVIhWirBzg/IYPWYgfujBnGd1HuMc4hf1lhB9zxDqyxdio9t3vRBNlsb8Xtdd15U9S8aJNBPRtEeo53Omwf1BmQYyF/uaQqDR/AJ5I228wHsF8lzzHwIpmR/s/nAz5Lupe9H+rY4KjwUwGTo2Gg8+gPs01Ilu2h2vlQzDo1nP00vcJRL2j2vcQGE05NxgbTt1GOhWzq/65VZg1M04Obh1OFkHzPNEeibceXF1cC+pPJCfQoFIHXVb36IwPtn7BatThxgWImSMtQj4IX+rELZt9WWJcORttavmuUbpxd+jzbtZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 16:24:52 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 16:24:52 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, SeongJae Park <sj@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/migrate: split source folio if it is on deferred
 split list
Date: Wed, 20 Mar 2024 12:24:46 -0400
X-Mailer: MailMate (1.14r6018)
Message-ID: <2FA90B72-60FA-4D5E-A66D-D135B64C7C5E@nvidia.com>
In-Reply-To: <ZfsIp8GlLx2LoW2G@casper.infradead.org>
References: <20240320014511.306128-1-zi.yan@sent.com>
 <ZfsIp8GlLx2LoW2G@casper.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_9C819F3A-5E2A-4F05-ABF9-0B5F9C715F21_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:208:237::6) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ffb4b7-7af2-479b-9b53-08dc48fa4518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6HjKa4nl61BbCxDGyqfbRuEk8FvjSjWaQBGmtFQFB8RPTqDX1EWdWuFo/5KfFEBzEo+DXH4UnHE2ipFPNZzD4SmJfG2dARaMIln0M+5BVXrgM1J2X1L0IJG73bktfZZ4Lt38fKffQ1VZ9/2r+8W7QuPJggdXa0z3WPMOf7g4ij4NVdjAo+76iyxblyP8aAUjw1CpH+Mpg8DkirJvTClGR0reSDVYEdiW/QBf6GC80UDZ61JAK+PuV2mLbQCoAWMljtJwK7Y7TXscZIqxMdzIkQ6spcDGhqGyFVTwW8AXnfARXaJsO8WankTVYAjFVoIS7lyM5XtrvZrQWATdtbxfkIrqihiMeUm3LfB6IXiPo4BEOiCW/TXzoR9kpteRdbWQkC4pqM7yMBLkUk3W8pit9HTiy8UjpGtvK3uFloeiRc+ahgotcK0+ceeDz9RAVHyk5h8k/rheEUhl0SUT1YKScBkAqkriUC4iNuCY3tUZGXsFFnvx3y1PyoxpJbVIgVNVrkvXjCSh8n0RrAkkZu5zYyfm6cXqNwGoM2hhTXhM+HNfLiks8KfDMSocw+/jREFquLsccSMH7VGlAJP0PJDgks2FkX9WrwvGnzRlJ5A/3K8tjRfoeJocCt4CVkXevn6Elecl0MgA/O1DwNw4CH2e0KKKASiqfKpe87hnoAdf9BQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FFmH1Rgun0JuYI6IRl6HHGHVfYIiIIEjvYx9VUwco8g6wkmU+JSFVubtA2vN?=
 =?us-ascii?Q?kM3/C2UX9EpVedE2R4hevrk8dF/jbO2q4nsRRKsoednSoyr8y4F4WZ+u3KFO?=
 =?us-ascii?Q?F+7qWfyG5jJeg38KtxtZnbpzN7SPiZgzOAyLrrvJ0LEubXinOGJavMBLo6fG?=
 =?us-ascii?Q?vbXrs6/fCYgyMw3c8rjzfkyFkJuWeJgFJemGlKJAhziqD49638ro1CBBcFqL?=
 =?us-ascii?Q?PdQK7slsc2TmkOdV9X5wElaGsEUjUyAjZMoXiCBwkWAUK0QS1g4P7BW5iDPm?=
 =?us-ascii?Q?W4R8kOY2zg/8ypLneW6Iw4lKoBh8ZZNooeMpbSIMFHEq+RWxdNWup5SOPXyZ?=
 =?us-ascii?Q?x+i4SRJvVRyZ8IbJHLIdYc5Kg9fr/tvlTQZvsbHODXmi2nB+2yNui8GHOQY1?=
 =?us-ascii?Q?u1pwtgjmKsvmJbh2l3dqqac4zaYSN7lQRqu6eLiI6yDSCicoVmrzqWoKQ8NS?=
 =?us-ascii?Q?vjdU2l4HlZ6l/vD6vx13veqtufxpq31FzYbQbcSxdpWEHbrZN6G5+/mbV42K?=
 =?us-ascii?Q?+jZwb72FTtpMfkfFspTmLqF7VPphye7tqqotxKhwtfG3c9yO+mY4d6w2f91B?=
 =?us-ascii?Q?pC6wgbMvC92c9oTVNdQ22wrW3V1ZjisvpZ/YXKQPQoJBRBPsy2xuswmsAcOH?=
 =?us-ascii?Q?seAns/ZHDKl4ym/W/KeKc0lSHO/NqJr7DaxzOLNy/VzNRGdRLgzlLjmN+wqy?=
 =?us-ascii?Q?XmNOtxp5wX691xClCsgxxwtKKZtWSFUG7wFYb7tpdMAngdbuhdRgMH287UUj?=
 =?us-ascii?Q?UrR29j2FTRfiY7lZPNYHa+ZdwDzW2WwjXS+JMkXJfle/+2aJ/K6X6DkyuwQ+?=
 =?us-ascii?Q?AHNOa0fCdBEFp8SDQNpE266WZPJiUMWPaZs3KAnnroDDS0KwiHRFyvDvvhJM?=
 =?us-ascii?Q?PqoNCEFENEmQKC3mOiudqxUrf/8Oi6gWq9uDP/3WLIec/X54UemQn48XCZzN?=
 =?us-ascii?Q?xlggysz5axbCO7tVZN3F6AyiYMMReE84V1D/q4D8tjkItzKv1JRJFA5UVQ23?=
 =?us-ascii?Q?ptNmzgFbz9edwPHI53WIGGwb9KlSszrFEbw40Wu+pTpcSekmH2x/cLXzYMbQ?=
 =?us-ascii?Q?ZhDh9YexUGwJ/nm6jDURrnFzmGWyjPr0htpqOu6Hh/7iFURlhCchBE8IXpoP?=
 =?us-ascii?Q?TeboJ66Yyk7Ielg7y+fiqbbS+AgW8NKu7J8KzT7rkBeut6GeUm+DFQRT/iNb?=
 =?us-ascii?Q?EcMbG443FJTH3wVr9i5rMClmNbI5l0tt8MxYY95GvMCoThYU+nZ9g6gH4rgh?=
 =?us-ascii?Q?ybDUVslL08KPvZ12nVkB1F2NWfwRQkagnSqAtEdcgmfR+o6tgRCAUL8sYG78?=
 =?us-ascii?Q?MPg/sGJ4zr8j2zxKCvwLkZqwYuTfJ5r6+f23z52ziI0UjEgfnTCobKWInXD8?=
 =?us-ascii?Q?VTj75vJwgeNXwQIPiYzH2tltx3yoeEEUxQjodsSWk19m7sihvglEADHeINLw?=
 =?us-ascii?Q?f3RmRWwQU26o4fB5Gxe8arGpdDuzUw2DRsS4m7thhAfuOaXy0CxC2SRgApu5?=
 =?us-ascii?Q?T9jmmhJnYZ6zwxT7JwkP1XX+pwXcB2W0LNcmOcx8GDE2M5slyREaFrUH7shb?=
 =?us-ascii?Q?jRTqSwoXXl4hTJE91NE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ffb4b7-7af2-479b-9b53-08dc48fa4518
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 16:24:51.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WFFFfMNfaZnQSIX+EXmFc8txrwIDFXyRTyeV+ayjzjiFYdXQn0M50IXMPTktofW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881

--=_MailMate_9C819F3A-5E2A-4F05-ABF9-0B5F9C715F21_=
Content-Type: text/plain

On 20 Mar 2024, at 12:02, Matthew Wilcox wrote:

> On Tue, Mar 19, 2024 at 09:45:11PM -0400, Zi Yan wrote:
>> +++ b/mm/migrate.c
>> @@ -1654,25 +1654,65 @@ static int migrate_pages_batch(struct list_head *from,
>>
>>  			/*
>>  			 * Large folio migration might be unsupported or
>> -			 * the allocation might be failed so we should retry
>> -			 * on the same folio with the large folio split
>> +			 * the folio is on deferred split list so we should
>> +			 * retry on the same folio with the large folio split
>>  			 * to normal folios.
>>  			 *
>>  			 * Split folios are put in split_folios, and
>>  			 * we will migrate them after the rest of the
>>  			 * list is processed.
>>  			 */
>> -			if (!thp_migration_supported() && is_thp) {
>> -				nr_failed++;
>> -				stats->nr_thp_failed++;
>> -				if (!try_split_folio(folio, split_folios)) {
>> -					stats->nr_thp_split++;
>> -					stats->nr_split++;
>> +			if (is_thp) {
>> +				bool is_on_deferred_list = false;
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +				/*
>> +				 * Check without taking split_queue_lock to
>> +				 * reduce locking overheads. The worst case is
>> +				 * that if the folio is put on the deferred
>> +				 * split list after the check, it will be
>> +				 * migrated and not put back on the list.
>> +				 * The migrated folio will not be split
>> +				 * via shrinker during memory pressure.
>> +				 */
>> +				if (!data_race(list_empty(&folio->_deferred_list))) {
>> +					struct deferred_split *ds_queue;
>> +					unsigned long flags;
>> +
>> +					ds_queue =
>> +						get_deferred_split_queue(folio);
>> +					spin_lock_irqsave(&ds_queue->split_queue_lock,
>> +							  flags);
>> +					/*
>> +					 * Only check if the folio is on
>> +					 * deferred split list without removing
>> +					 * it. Since the folio can be on
>> +					 * deferred_split_scan() local list and
>> +					 * removing it can cause the local list
>> +					 * corruption. Folio split process
>> +					 * below can handle it with the help of
>> +					 * folio_ref_freeze().
>> +					 */
>> +					is_on_deferred_list =
>> +						!list_empty(&folio->_deferred_list);
>> +					spin_unlock_irqrestore(&ds_queue->split_queue_lock,
>> +							       flags);
>> +				}
>> +#endif
>> +				if (!thp_migration_supported() ||
>> +						is_on_deferred_list) {
>> +					nr_failed++;
>> +					stats->nr_thp_failed++;
>> +					if (!try_split_folio(folio,
>> +							     split_folios)) {
>> +						stats->nr_thp_split++;
>> +						stats->nr_split++;
>> +						continue;
>> +					}
>> +					stats->nr_failed_pages += nr_pages;
>> +					list_move_tail(&folio->lru, ret_folios);
>>  					continue;
>>  				}
>> -				stats->nr_failed_pages += nr_pages;
>> -				list_move_tail(&folio->lru, ret_folios);
>> -				continue;
>>  			}
>
> I don't think we need to try quite this hard.  I don't think we need
> to take the lock to be certain if it's on the deferred list -- is
> there anything preventing the folio being added to the deferred list
> after we drop the lock?

No. OK, I will use the less hard version.

>
> I also don't think we should account this as a thp split since those
> are treated by callers as failures.  So maybe this?

I think we need to match the stats with code behavior, otherwise userspace
caller can get confused by the results, where only a subset of a folio
is migrated and split stats and failure stats are not bumped accordingly.

>
> +++ b/mm/migrate.c
> @@ -1652,6 +1652,17 @@ static int migrate_pages_batch(struct list_head *from,
>
>                         cond_resched();
>
> +                       /*
> +                        * The rare folio on the deferred split list should
> +                        * be split now.  It should not count as a failure.
> +                        */
> +                       if (nr_pages > 2 &&
> +                           !list_empty(&folio->_deferred_list)) {
> +                               if (try_split_folio(folio, from) == 0) {
> +                                       is_large = is_thp = false;
> +                                       nr_pages = 1;
> +                               }
> +                       }
>                         /*
>                          * Large folio migration might be unsupported or
>                          * the allocation might be failed so we should retry


--
Best Regards,
Yan, Zi

--=_MailMate_9C819F3A-5E2A-4F05-ABF9-0B5F9C715F21_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmX7Dc4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUW+YP/jh7W7lho5upV/0bVRYb3nWq1V+K7QC9PrGh
epZEMOPa7qXebfB3xmMFTMtjSB07JAuaj+YRxhi+i7e1nxfknlYA815fHE7Mn57k
L2X/UogkRdHxN+FmFrKT0x9J36euHdLYVf5oQx3e5TpW9U0abTwmq188J99ETTu2
6V0FrGC28SU7ZCIfgqbg6jPWRvwTAYjUWjLWHmqrtVpiMvGcE6zxUANbmb503viN
UQZrI1Y6fcAfthSfZTbvhgjOAQ2vJn9e0Fznx0Dcp8amEsIriTmJjlyw+5ImmzD8
t7za1mg4Em6zM/95LbhkY9NYk5IkurvsuLJQUAjbh4qDHjrqufuElGoZDBQWaulO
VJwMCta04ssZawnXzcHkan8nvzwWC9UOpe003nuwhRX10xmORuiRJ44isPs+WTgI
kKJB1eg0CtKuzq5mSdO7sXvmJx3gis7Arpsun6SCFXmFp5+1mpYhdGiRlCEpyZ1w
snCQ5zdtQP7XxwMXY+3LeHmSXq5pJo5S0iFwSsVw7j6ZGdNO9DnEsqSggi66t+8D
msyjLhjm6IJGrr0W5QhOPIPP9ay2cAJ0mOU1fIdxQ3QMpXKXY3of13WBoGSizcLW
egNwtDg/ohe4wVHBawnYFMSqGc95zyERmR0FUB8vmOZXoVxKPgK18ywr5S2dZ4Te
zXSRBT5m
=KwRb
-----END PGP SIGNATURE-----

--=_MailMate_9C819F3A-5E2A-4F05-ABF9-0B5F9C715F21_=--

