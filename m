Return-Path: <linux-kernel+bounces-142847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284CF8A30C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACBA1C20EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD27F13E403;
	Fri, 12 Apr 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OqdQgAyo"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD71205E22
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932550; cv=fail; b=sRuIjFkYWuz6wGHYXN/JprYQNgJ7JDXZlCCY6ghwap2kC3F1CrWixpBedlo3VbBfR8SmGOYhLJXGQUlZYVFvJEF5pxDoWaNhyKyQlhEqbGQ6y7KEMcuBtB074XP4j0L5IW5hgsjLQ7Aolc6a35iSvZ18jLUP3fB9Q9q5mSmAmno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932550; c=relaxed/simple;
	bh=BWUXdpmAR7VM3iY149HGdFbhOjptyzKToCTXqW0hrlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IYjK1KPgig7YbdQgi7rkjMbxEtF+PH98ED1H+Fzy6Q3QET7CjWOvZv9e2UJIgMwakgVUt0f3XiFkTHmoLQRluQk5X+uBPyzZ3KZNrPS7Y/mzrnkyaJU8xJhQtoK+ORa7epPkcb6Yd6qv7hk7Y2IBkMN/x5qZ5iHPvTcTRj/nZO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OqdQgAyo; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l65SgIZ1EVuha5U7m6lTLabblYeFRiKoBNG594h5EItpq4fwn7tyDcj7R7tgB5/EdNnXir1zPRGUIl+ueKPaPiZgoMc2mABYqCz28hUfwo3UmYyp8y/3VGMNHRWAF0Z/KhVqgNH1pgSD1E3k1I6ZQw3ahGsJBzuptpif6jdPEeaulwfJ04/9Dr7YnFbUBQgn5bHyZ8e2VmtSKZd1pzPzvwUzw/Dno9PkIPTelgeoSKexKScaKgMaR79vOTtia7rVvs1TbTTyItkoAB/BVX6Zxr/NJYW8EoJUCwGteE5uYQ0+Bp/wmWRc30p0+95xglzlGiwe3aU0gAoBJa4yK5zWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+glEmo/4Gst+5eGa2JU9E5KN/+TgZtAjq0ujB8gBaQ=;
 b=czi6aVs0J2k+pesxJXKnEVAiX62fe/vuIWUaeQaM03ULSiHnHVu7MvKXEg40Xn+QdT1BJvmlo6O0Xu8LGoKAa1cA/TXyHVqE/wOtSt5vEn2YoSo0Hj3WScOGMjj15uwjTaGlqtD4Z1nYkzKZDE1vMVE+Qo88NcS3qx2bfQbdZ/MD40TDV3cbUfrDfSRmkA7WjQLbEFKo3+X3EOcs3zucWorSsxxJuisocPQrKxwvRlr82OxpWAUiefF0yd/O+AA2oH4UXnk7HNDNYmeI2A5c8pO2522WVsX4AU/h4S+y2YY3GZIf5QBPA3TYkGU8w6gdPQNf2TJewkhYRhpgw0s35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+glEmo/4Gst+5eGa2JU9E5KN/+TgZtAjq0ujB8gBaQ=;
 b=OqdQgAyoxDsvWju41jguFFi4cvednkCpxrBPYIvByV1vXzrgK2IsaCf8RObdTntIvu8s+ca05KaokK7V1+n8xLpcX6d54AO3CK4r9OnHYG7wRlMdaCuVa1lYju5SBrONIm3dYUV2e8OtybhVbwh19wEBCRZz29B7EXeFOB+a5SXicKZPOuLLkr60Q6fmkeyBzUQJKG75S+ChFtPuKPbx+m8SQGTcVgJbR2pNtYw9AS6z1keowCONEUxiFa3yvSjpEgfAnGw9sokMu4WqUs5QM1mrjYLn2vkhdZgCjTPAasODJIDafFW6DCNy+pOV4tfU3m9DEF8VKBFznzwrGufeWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 12 Apr 2024 14:35:45 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 14:35:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Yang Shi <shy828301@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Fri, 12 Apr 2024 10:35:42 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <2C698A64-268C-4E43-9EDE-6238B656A391@nvidia.com>
In-Reply-To: <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
References: <20240411153232.169560-1-zi.yan@sent.com>
 <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_125EA509-6E8A-494B-BF22-530A29437C63_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:208:256::20) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e32594e-1f91-4e8b-166a-08dc5afdd622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YvFaJ32yn+yGbXjTej5rgEs8GVBViAxbj5+/FlTJqmFyDqAuUoy4CI/elxvPquCSyyiixdWRnXRXN+O+y0vGlg5adxdwmHxK0f/K1hqiomdjV8zKJGdFuSUASvfisPAUC2osN4elei8zHc7WceUYD29ekcDOMRwJNNpGHR1a5CSftRMu0/GluyF+ORnyTzAIGFVrJzpwmpS4GAu5KFQt6B5BZFtBpDILLrG1BgTh14EZGwE0sIpLp/36OHZraeq3eMbdbXP41tp5tSYlWUIwBvdqP99/zbeOBf9Z+qQB4Pbr/VLIEK0DN7QEBNRUwfgzoLyWPcI0xj6KGcQM8I60tj9adXo/WpvL7RGJJihq4RbwqQfmR1Lg34MheZ5Brsrro0jjeAa2QCBzPPl4XC4mF7Ww+y7pSW4o5eAPaXyFF+qB/rucDyvK2z0f/IwSYGyKkw9VlEQcrruzvhITPvvLqJ6KGbUsSF68jys6KLuRL1pkFhaJUteor/Y2xaEVgjgqrEfcNRcil17sDo88B+To+XBk/7J9UM412ZGwxt1meZXsTIzUCE9ZLYcfHXgZEmwHN67n3GWtvKkTnWN7wAGEvES9iXTzUW1OO+H9RUbxzU82QCs/zd81ROpGaUetyvBpDdg+Bw+gy2XdrQaYHfX0cPJsBhsTmue++TrpdmajDP8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2s0UAFq1IJu1oLalWzrvmZJIArS9O2l/BUT+UwtkbkMYLfiIdJAgBzjD+Odo?=
 =?us-ascii?Q?i0xwGgpVDeG7Ny26QAd1nnTjcnW4wFm5Gu5IvtgK9rCRepRRpiIG39SklKS7?=
 =?us-ascii?Q?3vddowW81lK01oAB4YBlrWC2Om6PREs8lWoOcgF2292LxrZ5ZwN7IYkIPTg/?=
 =?us-ascii?Q?y7QlxpSAxv6KD+OiF6ZpcamK15x30isR5LpLb8XS1NAJYtefKXHtAJTvuG4a?=
 =?us-ascii?Q?tez8j+JlVb5oIguUIKeXjdmaZYgTADhPgXo1WzDNRPORCb71kOqdmRjtIk3z?=
 =?us-ascii?Q?RMKB6cB1o5JZCvfRZ326QobDYz2gjBudbZRgRN+OWihh+73mrFmeJRuSL+pq?=
 =?us-ascii?Q?LcOasII8mIWkQKn6q/SP8xXJow60sKpxmyNIS/+DzSKKylfsDUVoi8bhTZz9?=
 =?us-ascii?Q?pI40iGIEgumgstd1ZczUZJLsu5oKz2N1YXnxSgnu8pmPLB4zZDFgqZ2x63GG?=
 =?us-ascii?Q?zi+TPg/FvuOJ6+af7DhGJiyAqv/mtyjr//KGUGOEaKcUroQ7rHMM1LzLPIXk?=
 =?us-ascii?Q?yd+ISmhdt9IW+752ChsSgTFKHVvfGxrgt16o2pw3niwSm8v4o6UF7hxBAh8r?=
 =?us-ascii?Q?bHN2gN61UXEBQhrcTgEGX+TKwXDYdyCvyAaQkRBESwSFQq8aRusjCFkeRlWD?=
 =?us-ascii?Q?knSmCnuT8WKBBIJyOX1oSIRJATjddWH9xqiwANH+gPMtI1B0cQtiPRLHxcsv?=
 =?us-ascii?Q?Wwp5Uz7TTrZX1j1oow8o4gAi7PksLS8yGDoHvCqkMiEXpnZtUBnb+IY/7qK6?=
 =?us-ascii?Q?QXctRMP8djTmxMhF+anV9S1nTTSuX81ZW/k87FJo46kbTxno9uORfWsUgTZd?=
 =?us-ascii?Q?aYNa9WSLzoWqbno7iLL3rV6gUr0vwU0Ov5Gs54rHvwDzqpf98KTwcKYDCkYB?=
 =?us-ascii?Q?Mc5ksZrshHe4a6gNTkgdV3CZ/79wtS9+ZcDYkLdoliXQgIoqFpqWp8JdIMdn?=
 =?us-ascii?Q?eaXr1U8ZzihghUVE7ElhyK8nWBBtWX8Lj0dh+cyQVl0/+dht7G/asIeJODUc?=
 =?us-ascii?Q?LqNmYaYcSlJ9WN+ynXr3j7lWD44vqEHw2AIrO//JezXWa6Mm9aFRkj60UwRx?=
 =?us-ascii?Q?tRlRfR3ClYKoadwrRLofOugtiuNvuVVJhD56sm8lLoNyLm2TsKXkcVH6AK1p?=
 =?us-ascii?Q?Gi5QIUUrpVvvduzzhq3werQvhXTIMLAtAH8ORUQZB5H1RmU28VWSzGIVJrcL?=
 =?us-ascii?Q?3L9CsbQzBbLhC9Ya7gslHd3WMLSjH0lCyK3xu5GhK6PV9HPP890Om33TEkGb?=
 =?us-ascii?Q?eAK5jaz12/Me1RQpPjOI4x4l/k2KrHNuCqk0IPAZfBfPEJ7bCaCYqx3VAjbi?=
 =?us-ascii?Q?YzITkEsT00/98ZcZbmjUNJp0U9AmdtdUkoytaEQLHuM32AJO3BVB/v65dtxF?=
 =?us-ascii?Q?u1PtX7yMmEvSa7yv0iObdPl2vAJzpmmJcwGjfNlZMTz8u6mLgpfqTGFpLpei?=
 =?us-ascii?Q?Ida5kjUVymTq+NZs6CgxlS74akXeCfVvQvIxcm/r6hdZE471NpPocL+PUcak?=
 =?us-ascii?Q?749wf6ATdkNI0o7cGnGdv1hiIKw16sZJcdaJZJX68sWRR+TEfgvxp2AfdkT9?=
 =?us-ascii?Q?fFL1sM6aFJzrpm6Yfnw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e32594e-1f91-4e8b-166a-08dc5afdd622
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 14:35:44.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4gpTcLPAAzA9wdQcKwHV0JwQFDgpFprSKNX2LnjWHwrsgSezSX/zwiJmRvi0RaU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242

--=_MailMate_125EA509-6E8A-494B-BF22-530A29437C63_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 11 Apr 2024, at 11:46, David Hildenbrand wrote:

> On 11.04.24 17:32, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> In __folio_remove_rmap(), a large folio is added to deferred split lis=
t
>> if any page in a folio loses its final mapping. It is possible that
>> the folio is unmapped fully, but it is unnecessary to add the folio
>> to deferred split list at all. Fix it by checking folio mapcount befor=
e
>> adding a folio to deferred split list.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/rmap.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 2608c40dffad..d599a772e282 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_rmap(=
struct folio *folio,
>>   		enum rmap_level level)
>>   {
>>   	atomic_t *mapped =3D &folio->_nr_pages_mapped;
>> -	int last, nr =3D 0, nr_pmdmapped =3D 0;
>> +	int last, nr =3D 0, nr_pmdmapped =3D 0, mapcount =3D 0;
>>   	enum node_stat_item idx;
>>    	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_rmap(=
struct folio *folio,
>>   			break;
>>   		}
>>  -		atomic_sub(nr_pages, &folio->_large_mapcount);
>> +		mapcount =3D atomic_sub_return(nr_pages,
>> +					     &folio->_large_mapcount) + 1;
>
> That becomes a new memory barrier on some archs. Rather just re-read it=
 below. Re-reading should be fine here.

Would atomic_sub_return_relaxed() work? Originally I was using atomic_rea=
d(mapped)
below, but to save an atomic op, I chose to read mapcount here.

--
Best Regards,
Yan, Zi

--=_MailMate_125EA509-6E8A-494B-BF22-530A29437C63_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYZRr4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUzLsP/ig/ncHlFC0b40eNH++n/7FRvGkvwqockaEK
XzJTG/rmDY7VbJv7OSX/6XG0cLAOekTjzKfz2ULN0Pa0UwcHBD09orzt2iqOhcTz
/DEvysyedt0geBsMKXayaHnrr5s+Oug5otwV4cJ8wHw+6dj5P8n71wGD7wDWYUW4
OrqkoQFXL2owI44h2bmxf582+6WD6IzEUTb8NPINUJ9jQIEQsyyOyUpjwlfhzeKf
XT5/4PqLq5Vtbw2AIIiUpDVKlhArIG0+2TAUA4MSAyZQKCzYUqJDrU6jAIBYVBGC
mvfBbKc/QCrOIRP9fZVYdhV7qaSqi6iGb6TgxSMFu6B9+e8S2eYTjs9WcMXku5MI
o7aNMMqUMC1Y++wUcw9H+YYBVyl8+5rVqFnemSnQNyfdGSjQM94gbttDUgK8q/o7
7sf81VRC0iCDDRfziSr3wyIxBcbrvrk1/OrrBNe1/WGNi5BA2YCtfYJxJ5rBK1lv
N88Tt+kFRWiDWCPPgY9oz2Ze5chLSCxIu2eiii7eU9SWkj8esDIy3tjRV4aanYZI
4oNqGcuIXZM0UgqYTSxrYAvu3PzNO61LSwXefg/OwSeUeDd0YKKfOPK3ZXDE7Qog
CF2z5eMgd9YRRzXjhq+4PpOfPMv5E2TquBkiDnAICgnrQg6G4dPr4NBiqFKojVcE
tXT6K1+n
=g/El
-----END PGP SIGNATURE-----

--=_MailMate_125EA509-6E8A-494B-BF22-530A29437C63_=--

