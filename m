Return-Path: <linux-kernel+bounces-165329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D948B8B56
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7772842CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4762F12F36E;
	Wed,  1 May 2024 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SpdsOhEd"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520BFC14F;
	Wed,  1 May 2024 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570713; cv=fail; b=geHANs49ba0+KSGgLu760wMZOZGZy8YK7i5/BGL9yxdNS5QvXqstoZqiE0pNyv03cq6HQXqgp2Os2HPYc0JSndCzQ9jrAVUzmLfi5bPiAzh6su/Ff8FJAWdTK758nZrWYFxPmekCohiAhFizGr0tpnT473Uz3nwzTRcsIAZTiBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570713; c=relaxed/simple;
	bh=ySg3aPovDRER6yEKKg4UIeszw0FHdilJ7G9y38p0644=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=USNsC4P3IzRY+yTkZy1//1x0CCYGzyqA/HZTgV9hU8TbBPURFENSPhIkYXjGM4Qd48MRnK44qpX/DLW+TX6IZKl/Ut8NlxfNOJeeVyV/22iK0QepYYhDwPXmx886AZ0TAoSHtzcW0zBmQiaGoxN+7ZLtJOgA6doomRvvk9SHQMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SpdsOhEd; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj0bNTTgnoAniUuiS63wGez4DX/QAuacQqqUTNjMD7RCrGznYba1tFFeCh0kVDa4XOdhuzn8gSuWFksFlyhcf68fAMMSrjPmeZhKPIJ+VwIcTUNpZhfwTQ3jsq7Zsnm8YGGvf3IhxkqNNEK9f8o3eMT741nzSPZw2keQx6sFjODzmOPlqIFn7OTNJijFuati6WePhB39c2HkffLoYQryZjDD7f5Kly7xmvLzikvInlIshrhkQDGBALnFEFR/QIWPBoGQmmt0pMofinfd2I+QasCjA7LndhuKyoNlDkoBwtsUkpFeMfLKt8oMIuRMjq4DaUx88IeNAXmxDEdIO/AzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02V8hBXyDQaoEPPSZ/LRqQhcdk/paODGrgwMNQK+t7Y=;
 b=Lkqppxdl36yg9LAkXtO+XEZEZlgkTcraR7M5ORN3tYHozKROv9ntWUXp3hcMU2wRiBya5DzZKAQsCkVLsjcl5ZGG2DlGttgvoY2MnB0g6PnrlwxkqZ5VCKarVrcv7M0VuNjVeLpuHclG+x6uxTjwwK7EKAGZ7S97qgSB8TzLOxzZRUHrfFJsheJpIbzSJ7F4O1KNk3MnRl3PXaiWrC3660iFq3kHGBuxk+Kowi70AAJ0vH4uPT59NukP+iv7gZ5HnsPWUv/Vz2BQESQ9RCUGdlzjjhKPm2II8hVH3M6d1goBsZQe/HeDbxgil4s+4lrbP2+E3W2E7Np8FjbODamvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02V8hBXyDQaoEPPSZ/LRqQhcdk/paODGrgwMNQK+t7Y=;
 b=SpdsOhEdloMngIjEx+e0WyfpywudRnkwy/AB2g0MDv4urBKbjYfK+BTg/jsb1aKAMoSe75FjNFAPskhSvzKKLs2153g7tdHLbeet7RH8TrC7EgWl30ANDslt8gWBpJJYUwrwe/Um63ErbVicOgMMA4Y8a0xcRXqKMLO+qN6QJ2Sg07LeI4J7w+HsMqtlCB5vGCz+3zxtUf2nqycxkrDNxNNhRsLLT6Z4rAoaC+tUrJD8q6goGOjG5XfS6qQ+j9fh1QmBaIv8KKO6qIq8HcbFl3cDUOEReLtgLSMAZ7T+jlT9/U36qTC5nzrPwpPREXSfrUBNKr0t4DxECK9Nn72qwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.24; Wed, 1 May 2024 13:38:27 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%3]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 13:38:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>,
 Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH v5] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Wed, 01 May 2024 09:38:24 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <5FAD7FB6-4AC0-4427-B56E-4942A95DB68C@nvidia.com>
In-Reply-To: <ZjJCdodEf4CBa1N7@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240426190253.541419-1-zi.yan@sent.com>
 <ZjJCdodEf4CBa1N7@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_CB3F5065-F15F-4DEC-9826-03230A08073D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:208:256::6) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: bea759ba-ada0-4523-1970-08dc69e3fb16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pfcc3OSxOSA3MCiCU/3AnFKmk3N5zRR6MQ/YGy8baJLAvIKyzm0eOrmD7hI/?=
 =?us-ascii?Q?vwBytHpa8BMR9Ve9QLIis575y+Fh+G3Rmt2t7hV0+IG5C1iCAsuYXw8fyCsn?=
 =?us-ascii?Q?cH2W/k6ojMDWY5NC6ZK1QJ6gr07DAxDkMnB29Zx/z6d5UV8m1iEDtq4YhTk3?=
 =?us-ascii?Q?z1SNCitXTEGNz3ZwVtKI2M7IHLJdEAzDA0c/ptlrnMTD39MFOECutp+okYrk?=
 =?us-ascii?Q?6tHXxJqW3kL9o/3ZagizO0Yef16DJTQwNU1HyNf4eTCBONajfmVfim/FzWyb?=
 =?us-ascii?Q?tH7r+hVhpLBiXitfp78Ysgzb7aKdaBGLBLvWPwHxeOgyFX2Hkd41CXX+MB4y?=
 =?us-ascii?Q?eKBHGgzZEcQ5GhLL7dKfqcrzZ7D/XzYkadN7OZ2fueHTGDAr38oIaBO6WLw4?=
 =?us-ascii?Q?j5XdKSsz08ngXd2C5bI2Zw/0vQH30VV1IWufubh0xsTHIQwtEGiYVGL9fAMI?=
 =?us-ascii?Q?W8s3XZYBEIiumSfxCbVlc3mVG7Qk2O7hBC3P5pXVCDv9QLFsYsiQo5XGL5xW?=
 =?us-ascii?Q?U6EdTONX2VLf2iKKmbN0K1miTXIk2M2y7h+uCw5B8ixwonBqo4GSHPmnn1nk?=
 =?us-ascii?Q?MJ+jh8TtMDvAw3BkhKYpZOQviSdpAKjUzoFsmTkAHkRLSKL8wSZg0yEJhCFS?=
 =?us-ascii?Q?jyDFah8I8Z8rWC4ATfoFavYpf8hesjKwUHkz5u6Vt94jCdHYlgG+PZXStwzo?=
 =?us-ascii?Q?uupltRq58Hre7MacIBd6ihnNcRoBWmEEEuANlpv2TCMwxM+DCg3oKGVwe4u9?=
 =?us-ascii?Q?vDocJCG45Z5JF8/rof4eD05Bpm8D7WdGzigf1AIuwlkzSgo0uzPR0LUJIxi8?=
 =?us-ascii?Q?OjPyafSCexnQklT7GCazZyV8voYaNwyoBu3vGLlWuXvqtNyRNH1d97KRskyi?=
 =?us-ascii?Q?K018NMw2QiEM3VPxpqR0fu5a53HlpK1g7+rS3c4PBvY9BfqIkYKKcpj74SpV?=
 =?us-ascii?Q?DhmTJYzDCYkxJcIseZfn18tzd+XrhoG5pPFYqNGV9NINDecxc05gt4NpLmCA?=
 =?us-ascii?Q?XIFSfAY/jl6SJB57jFGqf22zcNIQXD7wnrFBEhztCQ0gZWnHAoRzWbqJlaC8?=
 =?us-ascii?Q?TbqI7Zc7i+xnFfxbNyTQMkzSvAcW+zMF/uCgjI0XyFcu+OGQDX7nG26SiFJY?=
 =?us-ascii?Q?yYgXUuhJsKy7gOoQaqjLJfwmHX9e6cEOI3HWj56iFTHj+OvCRujEcPQwIUTt?=
 =?us-ascii?Q?BJLN9BrgKnBjNNEPFlGxUB+LIfUxt9vc6v9JcO/jjFJa2zHkaGODOCpQJMt6?=
 =?us-ascii?Q?5uOJ5aJDfdkGnZtuB0nUmKmaJaOJVcPgbc9eqrXffw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DaRgOSBhF/xMghyd3jrj0IB2zhctoMyIojSjhnjympQgmYA+DpDy81I/FHwn?=
 =?us-ascii?Q?IuYl1EIVaT/9HrZhBzhb+bI4gPG8NO7KsTD7gYphYXF2mirKbHmTUB/N/iTW?=
 =?us-ascii?Q?/cU4ug2xoduxtgaXqmEHz4NASxCFOfnFhagqfwo58uCX7Cr81H+0Ylb2vDgT?=
 =?us-ascii?Q?62nWir95sgLLU6pl2gKGG5eUzISvc5i7FJIHSfA9CYud9TDx68pVaKih5YBO?=
 =?us-ascii?Q?ml6raIiwGaavjz3AkqR/JBrTTM9dEyNXJiLmp6aisUV0xEsNJtKMDIVNfCfW?=
 =?us-ascii?Q?8O6xbf6defcPE4ATSiwhHRa1ztSRtekm0PdUSLMC+oMG+73IW1uM5JXY/+Ng?=
 =?us-ascii?Q?AHrHh45El9D/DXgrTr7yhxFrgjCg7r5eNwEIv+pbDwdBFfGcnG637EreTyeu?=
 =?us-ascii?Q?UeJV0J8BO26vR0rHzFmeBYATDeLlpDmzjFK7JokNR9QmCcuqzLhIWaSshEDq?=
 =?us-ascii?Q?JXEphZ687S61pOy+nzOZBuDhbWFgJmC/NIfRy/2CJYzDr5Cgjcblch9fcGSC?=
 =?us-ascii?Q?9D9W4NUfW+Nd3c9vWBQt/ZqrH9SZCCUoJmoE8c8eK7T4iMvP3nolmh1i449n?=
 =?us-ascii?Q?uwfehbpNss2UYSwLVIUwHq+30qo58PBJdfAk/TFVSobG27FeSguFdsFRL6iX?=
 =?us-ascii?Q?OQ+2gowQAIOCYBnWUHFztUKctO3HtMdphjfa6QzohIKF/5rPYY3vUVyFueQb?=
 =?us-ascii?Q?J+1GAhD0gGPCVRK12hHaMeBuwRwYK7btTKNU1xk9h2z0UxUuuh08Ly6esh8t?=
 =?us-ascii?Q?Edwdz+iR7VZ/fs55x2vtrsqKB2wGU74GwE6PX7vfQo9SiUN2RkY09vdzCfkL?=
 =?us-ascii?Q?lj38FqIg61zyDt37HkzBQq6Xh8qd6mQyjAWGsndcbiDbuUbGlB2/CZ6SC30L?=
 =?us-ascii?Q?1vUzHIqr/kFGe2H06YiDxRABmHNdIPkNs6TEvG/MDfT4eN0BcpOsSu1ANSfD?=
 =?us-ascii?Q?8Ybx1uto8EXH8UpqMGz9DK0KzNuGINp9+lw40g19FBt39UzY47/pMeCbuUIJ?=
 =?us-ascii?Q?b7pNfKNFIuicJpmwnVbUex8JJiS0iIecnsd7qghU2wJBP6xfRrwysi9TOWTO?=
 =?us-ascii?Q?Hbi9Qp5XP6Kw4Tf80fovW8WMmPPcjP7IaDREaE+DG3NdmXHt2UWXSJttR5G4?=
 =?us-ascii?Q?yh9Si10YjTjZUzidEwBuJWgCYyo8cOfH953CvbOLQ7Gy6vwd4gtPZKcrdxYy?=
 =?us-ascii?Q?YQWCcp1KAy7SD6AE6zmFkRNOzl5Hjnb/qCK2EkkVb6BiGo6PZYTR5RvytWo9?=
 =?us-ascii?Q?xP4E/WACFHVRb7tPOhmbcM6B61IiiKC6KuPdGoLY+k2XyDYjReWJmgGdYYb5?=
 =?us-ascii?Q?ria24mpXwMmhTdPOWnUechMyd1ehBWdi9e9zSz5r6BzODmg7ebi1qOAzNr64?=
 =?us-ascii?Q?krqp7llodwHcyRQBaPP13WkyxR0fujPrqoE2+Bs5WzEM+jm54dJABSFwVU6H?=
 =?us-ascii?Q?Dc0lM55A96RGTbbl567U5vyf6wkoUch4SWvOlhxfPCyb5Q+8+HahI9dpn1Co?=
 =?us-ascii?Q?I0apmwt5PDslSH3HedGS7FteU+Me90EpU8hR/r1UNvshgxZtcpTpz9f3ULBb?=
 =?us-ascii?Q?qXD53L+eisl19wjlia3FtEgpb48CZ4pQRXLf3Fmz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea759ba-ada0-4523-1970-08dc69e3fb16
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 13:38:27.2421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gM3UOxfHeeEINJp39qsp+4fU7PNlGaK+2wacMoVlYbSpRQ0Cl2ygQ0WY8eKohyaj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952

--=_MailMate_CB3F5065-F15F-4DEC-9826-03230A08073D_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 1 May 2024, at 9:24, Alexander Gordeev wrote:

> On Fri, Apr 26, 2024 at 03:02:53PM -0400, Zi Yan wrote:
>
> Hi Zi,
>
> It increasingly looks like this commit is crashing on s390 since
> 2024-04-30 in linux-next. If I do not miss something - since it
> was included in mm-everything.
>
>> @@ -1553,9 +1558,10 @@ static __always_inline void __folio_remove_rmap=
(struct folio *folio,
>>  		 * page of the folio is unmapped and at least one page
>>  		 * is still mapped.
>>  		 */
>> -		if (folio_test_large(folio) && folio_test_anon(folio))
>> -			if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmapped)
>> -				deferred_split_folio(folio);
>> +		if (folio_test_anon(folio) &&
>> +		    list_empty(&folio->_deferred_list) &&
>
> An attempt to reference folio->_deferred_list causes the crash below.

So if you remove this line, the crash no longer happens? It looks strange=
 to
me that referencing a anonymous folio's _deferred_list would cause a cras=
h.
Hmm, unless the folio is order-0.

Can you try the patch below and see if it fixes the crash? It moves parti=
ally_mapped
ahead to exclude order-0 folios.

diff --git a/mm/rmap.c b/mm/rmap.c
index 087a79f1f611..2d27c92bb6d5 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1557,9 +1557,8 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
                 * page of the folio is unmapped and at least one page
                 * is still mapped.
                 */
-               if (folio_test_anon(folio) &&
-                   list_empty(&folio->_deferred_list) &&
-                   partially_mapped)
+               if (folio_test_anon(folio) && partially_mapped &&
+                   list_empty(&folio->_deferred_list))
                        deferred_split_folio(folio);
        }


>
>> +		    partially_mapped)
>> +			deferred_split_folio(folio);
>>  	}
>>
>>  	/*
>
> [  507.227423] Unable to handle kernel pointer dereference in virtual k=
ernel address space
> [  507.227432] Failing address: 000001d689000000 TEID: 000001d689000803=

> [  507.227435] Fault in home space mode while using kernel ASCE.
> [  507.227439] AS:0000000180788007 R3:00000001fe2cc007 S:00000000000000=
20
> [  507.227492] Oops: 0010 ilc:3 [#1] SMP
> [  507.227497] Modules linked in: vmur(E) kvm(E) algif_hash(E) af_alg(E=
) binfmt_misc(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(=
E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) n=
ft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_=
defrag_ipv4(E) ip_set(E) nf_tables(E) nfnetlink(E) dm_service_time(E) s39=
0_trng(E) vfio_ccw(E) mdev(E) vfio_iommu_type1(E) vfio(E) sch_fq_codel(E)=
 loop(E) configfs(E) lcs(E) ctcm(E) fsm(E) zfcp(E) scsi_transport_fc(E) g=
hash_s390(E) prng(E) chacha_s390(E) libchacha(E) aes_s390(E) des_s390(E) =
libdes(E) sha3_512_s390(E) sha3_256_s390(E) sha512_s390(E) sha256_s390(E)=
 sha1_s390(E) sha_common(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E=
) pkey(E) zcrypt(E) rng_core(E) dm_multipath(E) autofs4(E)
> [  507.227546] Unloaded tainted modules: dcssblk(E):2 [last unloaded: d=
cssblk(E)]
> [  507.230569] CPU: 0 PID: 36783 Comm: pahole Tainted: G            E  =
    6.9.0-20240430.rc6.git237.d04466706db5.300.fc39.s390x+next #1
> [  507.230574] Hardware name: IBM 3931 A01 703 (z/VM 7.3.0)
> [  507.230576] Krnl PSW : 0704f00180000000 0000025e1092a430 (folio_remo=
ve_rmap_ptes+0xe0/0x140)
> [  507.230588]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3=
 PM:0 RI:0 EA:3
> [  507.230592] Krnl GPRS: ffffffffffffe377 0000000000000000 0000025e122=
075b8 0000000000000000
> [  507.230595]            ffffffffffffffff 0000025d8f613288 88000000000=
00000 00000157a38b8700
> [  507.230598]            000000023fffe13f 0000000000000000 000001579cc=
d75c0 000001d688ffff80
> [  507.230602]            000003ffb9cacf98 000001d688ffff80 0000025e109=
2a428 000001de11fab878
> [  507.230610] Krnl Code: 0000025e1092a422: c0e500039f47        brasl  =
 %r14,0000025e1099e2b0
> [  507.230610]            0000025e1092a428: 9101b01f            tm     =
 31(%r11),1
> [  507.230610]           #0000025e1092a42c: a784ffb9            brc    =
 8,0000025e1092a39e
> [  507.230610]           >0000025e1092a430: e340b0900004        lg     =
 %r4,144(%r11)
> [  507.230610]            0000025e1092a436: 4150b090            la     =
 %r5,144(%r11)
> [  507.230610]            0000025e1092a43a: ec45ffb26064        cgrj   =
 %r4,%r5,6,0000025e1092a39e
> [  507.230610]            0000025e1092a440: a7910001            tmll   =
 %r9,1
> [  507.230610]            0000025e1092a444: a784ffad            brc    =
 8,0000025e1092a39e
> [  507.230672] Call Trace:
> [  507.230678]  [<0000025e1092a430>] folio_remove_rmap_ptes+0xe0/0x140
> [  507.230682] ([<0000025e1092a428>] folio_remove_rmap_ptes+0xd8/0x140)=

> [  507.230685]  [<0000025e1090d76a>] zap_present_ptes.isra.0+0x222/0x91=
8
> [  507.230689]  [<0000025e1090e008>] zap_pte_range+0x1a8/0x4e8
> [  507.230692]  [<0000025e1090e58c>] zap_p4d_range+0x244/0x480
> [  507.230695]  [<0000025e1090eb22>] unmap_page_range+0xea/0x2c0
> [  507.230698]  [<0000025e1090ed92>] unmap_single_vma.isra.0+0x9a/0xf0
> [  507.230701]  [<0000025e1090ee9e>] unmap_vmas+0xb6/0x1a0
> [  507.230705]  [<0000025e1091e0d4>] exit_mmap+0xc4/0x3d0
> [  507.230709]  [<0000025e10675c64>] __mmput+0x54/0x150
> [  507.230714]  [<0000025e1067f3ba>] exit_mm+0xca/0x138
> [  507.230717]  [<0000025e1067f690>] do_exit+0x268/0x520
> [  507.230721]  [<0000025e1067fb38>] do_group_exit+0x40/0xb8
> [  507.230725]  [<0000025e1067fc0e>] __s390x_sys_exit_group+0x2e/0x30
> [  507.230729]  [<0000025e1136ba4e>] __do_syscall+0x216/0x2d0
> [  507.230736]  [<0000025e1137c848>] system_call+0x70/0x98
> [  507.230780] Last Breaking-Event-Address:
> [  507.230783]  [<0000025e1099e32a>] __lruvec_stat_mod_folio+0x7a/0xb0
> [  507.230789] Kernel panic - not syncing: Fatal exception: panic_on_oo=
ps
> 00: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 0000025E=
 10630B56
>
> Thanks!

--
Best Regards,
Yan, Zi

--=_MailMate_CB3F5065-F15F-4DEC-9826-03230A08073D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYyRdAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUBngP/iWCgTs/tdPUwBMYY7XVQ1wvjzIe/+/L8/Ej
2HKjlna2SXc9HQAfOhoEQl0k9PZg7L+UyC/Txf9H1hz9/JnYriQuxydoQv8NsIZD
eHBTzWxMu243djHDyUNzVTfYlSMQc8o7f83X3HxhzxgB0+teCUQR9avfzprllsCj
uh9GX1lB6dd7BeZBFFB9oqcZJRBur5Sqw1JdvFHUkmhiBHG3Oxtd9n3FrGy/x1ns
1gwuLWjtGSTfPDHvtyVFMKWlDCX9/WbtwVImcVbWx1t4VwF0xH/NhywerDxndYst
mdaNGWArl0jm2gVHDci/yPK6ZtPxebEJl6zjOUTklMfj1Mdzy+hH69iWx6e5o+wH
EJWhGoIP57OpBOVqWnhac/PC9WWf3EM9OTsUw6wk7bZ01VIJqwzTXZajcVfbfh0r
Uuzm8Wh5BAA/4JsXmsA6A+QnBY+BpnI3jplaIVzj6PGEQS/fvlSLCzQVi+6H7FpD
CS+VwU2OryPNm9RQGFoHH/ROo1Sk8HM3SZVdYqTCPTO1ROsHaOQg2Zt00QenB0mz
UYPB9e/kbygGFsesgT6Jn/Vce8aQuo5pceqkz4kiNiHmC43wGjFrUkIWiv7ReaqF
Alp5HIazz2ipgqrIh6KP0RZ+niXdlmM+WUUYF2GZuFGrZ5xskKWU0aWHWGOVxdcA
90H0oVXZ
=FVlp
-----END PGP SIGNATURE-----

--=_MailMate_CB3F5065-F15F-4DEC-9826-03230A08073D_=--

