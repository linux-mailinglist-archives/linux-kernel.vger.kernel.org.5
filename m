Return-Path: <linux-kernel+bounces-143352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9628A3788
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A67D1F23278
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1042514F112;
	Fri, 12 Apr 2024 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jvD9MM1h"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AE414AD32
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955987; cv=fail; b=lkuoQFZ3TlTSOBX1F1BYOy3YB8EFIdQWv/7bcaJXbxLn9kDEnMdMFuOJtwswTwlDR6foQBfPxjcapDe6tIqcNb1tsWspizVxHg3ormtoSKJAzdIV1+UDBlWdK+4JBhSuNDOOBqZBoL1C9iG7pjudZmj4/W7km0l0qErTNCr41Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955987; c=relaxed/simple;
	bh=AzDrU/+6qeLQlFT8++cOGGS9KB6LsPpi6QNREUQLfdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hDbLwesxjy922K4yYSDmAl2NfpdgDGXignoA6qEox7xWQP9hM+2ph5vC7w0oZiOFmnvECY7cmgt0a0Dw+3gHgoYHxtyXt5toeA4a7FG9mwTGlxElAWfVOEyOtut+hKIQ4ouym1l5HeBMf/LNeBenosGrGdmLEcMw+LoNNY3jJ2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jvD9MM1h; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZie0e6kP0aTu7CtDakctroacnvQ71fBG1lecM2lmBEklrxYB6F0WXF9AAoOvVjUViV7EFh5ipO3pUcwT3RHHT3jy7Z7kBkSZ699lweqbT2TrqSN0FZlvlTgV3QxuQWS0uo2kjdpt+pBSYGKu628J6zWsMGbD89vn4OsLp/QlAfTLlstr4Vsx+Df372ovDAWlxF2nuYU0f1dolSVs6IfOeo37bzLixR2RLCiaFSGI+dKGDLPR6B5FKHuXnaXXCLoysFeJAD6o1Qv7MC/xDFvyCqmHorBuEXeCA7pVW26UaYMosAagA3sIbpMqYb8WzACK+3SFLS8Zz8mYv3detWZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjmmgAR7p8j+mtTEWncENVLOpRsh0AItjgcxmnJqXx4=;
 b=AsSc/14NuywzaQk9oobyKPXB0HrNim6V7/6g5Ys90xVxt2hf+3BBYpx6KHyZzABCjp+o98dXsiNfyybg/jOIIogZWEJh6RB/Z7vXILT9/+794BVjfG+NO9I3KMmUlIuFSnleSiu3hnI7k2psyd1n/yc8DOh6ibS3Gn3CYGZbKHz/LFp5eQDAVYutRNCRRTBKsNX7N2meXYKPDoJBpfqNkxhn+vcaAsbaiSzo0LlSHDyHlFM+XfqGp/gT4OwBRaT+JztDCtLEBfv+X78NNQSaeHX6Erd5FM/ozsKXXo05LgO4hWm6Gq+xDkDvS26qJrqKGokx6OYlhzGJ77ED1UMCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjmmgAR7p8j+mtTEWncENVLOpRsh0AItjgcxmnJqXx4=;
 b=jvD9MM1hlZuzOFuCpsQtNQGJS+JTTTVNfOaqtoygVuJ+rbgCn5aZ1nDjVREfETKHmeN/UZQ1X9PnZgyib4QZFPDv5SgKVQAzLTj7Af1yzDnjUrDpCRXWpN1mY+IJRS8xpklDYtBy0QvGwX8fALOVQtNmH6ouWhR8fT1cqlJL34GBkThJmZxwGy2AlsrK7xtlONKCZCXXfRYOZALImMBroDjnhOWXhq1CtOeOYYCfu0Ps+MB3aGamT3A7Mz00j7h5HZ5z8p7afE9q+iB3D743WFtaAvK1oUy8Kddz8ZSpWkUOGSVIHD17W1H4WhxYZ5JDtI4/Sdg3NCvfxdPqIsRnpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BL3PR12MB9050.namprd12.prod.outlook.com (2603:10b6:208:3b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 21:06:22 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 21:06:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Yang Shi <shy828301@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Fri, 12 Apr 2024 17:06:19 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <BBA893A5-1463-482E-8475-384BAD1AC6FD@nvidia.com>
In-Reply-To: <bc8effda-6ff4-458d-a3ee-0d6f25cd41e0@redhat.com>
References: <20240411153232.169560-1-zi.yan@sent.com>
 <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <2C698A64-268C-4E43-9EDE-6238B656A391@nvidia.com>
 <bc8effda-6ff4-458d-a3ee-0d6f25cd41e0@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1FF823B2-2831-4AD4-BF46-4033E1FB2427_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR0102CA0012.prod.exchangelabs.com
 (2603:10b6:207:18::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BL3PR12MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6170dc-e452-42c3-2216-08dc5b3467bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XcRfIxZI1AgKsOH43hBRD/u/15+jfQKMmLoprwlhSHnyCYGYLJIHjmNqsE63QqaIcAZtgWWggIexWan1HjRxarZYnQAbeSPVgAMWLaHwgsn6qhT+NIziPZjHaSZYFZvWAFY+saJuFLPTYTwf3FueTnchECpnGRtshpdJNzPcuNJ3LwTJ+4SPisS350R0FZNnK5g7S6ild8YD22u5pSo9O6QZwDOzTwG8PD3x539abVSsFss8Yhgi0zskx2ORw1CCQo5pAYup57k7uqiqkfSxPs8ZcdkYNnaUvgmah/63vzDPUMycp3D6HQtbgaUSsJMh5V96+j+VllXJaLM1ukcDF7wVtXZlheBAd691J/gZGu7lwBpsoLSYh4rGXnSdAIA6UL1rdpeui0Kl3iG5c3f5pbs8BF1h8D1qwtOJZlmOPwLzvAPQ35pos472Z8hck/UO229wU61Qqe02AV5sfIKLatzYeCGmW2xZaOioI7CzojkCLVjxDdtCrjh8morOZrJZ6Ft6UkspyEJTB5fvjrj5DKiQgR7x4mjs0l/7idB70RQdEfR56H0ezSpRKwy5zuG5jXsTbjlhVIPSCsjr7VZCK2gnd1R0KEtOUUafQLImq3Oqx6Jy4y7ckZDX26alE3U0WPaBCi8HFCAMJIRV7O+7LW1Hdx68aQUGvsqJWTJO8Jo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7wefB5hl9r2+o8pbjXrKpnR2Ok0kSrTH8e6s+Unu2351fppcLPQSpx8mbVZW?=
 =?us-ascii?Q?iovtxvDeQElSnVoCR2Mf43/8U5wdyApfA1o3rnOyHQqxZpDL7pp2O5sKqCqr?=
 =?us-ascii?Q?7uEXMsuDZqmB16mHaTl0By9MzkK7n9XLZZU7/grOQtVUpphWbhXFZ6gx20Eu?=
 =?us-ascii?Q?xPxfP/rEVv2hgxfZ0sXcfVrQssjwLlYa5mNT+OmzIFXUaKskUuNSpMwWbENF?=
 =?us-ascii?Q?9DFuvB5AwzTj3dPFi4wSAOocawticedeU14nYmY/qKwChOk1Po6zdGOssR1y?=
 =?us-ascii?Q?Z2gN5s2Qg8Nxn9HDH5l9omP+GT/xOHvbG4sJrvBfhk7PODmwRJasNb5iUf7O?=
 =?us-ascii?Q?vJ6vjsORRh3G5r/V6TTHOMPIiVxyR85OnXLc+t+lqUWCtgwsr5tgEoQYDDfJ?=
 =?us-ascii?Q?KDL48E3isYlHwITeQPPii9vIWN0lffDwW2NK26HMwXaHWbvYuqa9lKZHhI9O?=
 =?us-ascii?Q?Vtcu34zyJShVPixhaCekPvK2QysvxbozXtcFKQLEEDWEP6EGhCR+xmJMbilx?=
 =?us-ascii?Q?Y/JVRKn6q8+XOWMP5xi7dd7UbjK0yKE7GY3nososSXq44Apo6M6CBMkipyYS?=
 =?us-ascii?Q?XPECi2VhN9y5OWZvmTh1WIdzV3pmQNRcc2XkWBz7WGzAlQ0RkvK7Dz6Tp1oj?=
 =?us-ascii?Q?8nt8nBJgfqnWr8Pd2hLoGeAE8xW4a9bu8oyk2ze1u/GyWMteNSA2U4vGgEG7?=
 =?us-ascii?Q?ifv9C9i/osdeG334qJgrYPkh+2CSsEj9HyntwmLXtNun1sUjedS7WgFq9eQX?=
 =?us-ascii?Q?qTjfHZfkbtt5gl0bqUBGLghw9WuO359Ckl/tC4D4LVB3OEgc+4V+J2Rxbqzg?=
 =?us-ascii?Q?51oNID9sFf1wrN39OJV5uQQwC4AzoFMG/IyK6QalSmRAC73o6FWaNNLKorKE?=
 =?us-ascii?Q?kudoInFjKitAEkV/dVCU/pgEOWrlT7bJ2TimNGirl3i+Xsc9+qdpNDCfi2ND?=
 =?us-ascii?Q?6XAbBT4UUvzQ6PKkUzKTPlwkVLKIQOCpemHLJ76nuvD8GmT7ShLPDtr1A5vV?=
 =?us-ascii?Q?Q24VRgF1UnkDBk7ZG/x/Ew+lSe2Wxu3GVOFHVanwShRpj+52VLRquZtTUsrI?=
 =?us-ascii?Q?4DslqmmjdKeo0NmsKW0baF8IKDPu2CII8FnwlbxOk5KzOtBtS86DGGPn4+Um?=
 =?us-ascii?Q?NLRY/mxL3UYUea0IUwrMGCyCzc3NUei8u37fqnlu3Lu0HGDcC1ugOJK+T1IO?=
 =?us-ascii?Q?/QLmHANUoKyK6pOy9DpPxqAell+beS7ho/kfGeI1NDpvIpJLYUsMCt7z/4HA?=
 =?us-ascii?Q?M1OA+BYutXlBIX869DCD34+j2YOPll6eq58EDXyXc/5jByYfW7LHx829WwZn?=
 =?us-ascii?Q?ykSNPqYNhXoUHAUYBAMoQYKL7FjBS2OlZ1TKN7/GlXa/q273QKvTmiR4VudX?=
 =?us-ascii?Q?Fa8mcEaGSxlBqaAsJ00chbmqLpmpwv4rfZovTUgTD2s7YvVQVT2rh1WixXdy?=
 =?us-ascii?Q?uBbTdZkIsr06YeQJfBvaISTkf7N5zFpMpcV41vJc7iNFAUGwlOkgzR+hSSEv?=
 =?us-ascii?Q?ht16yoNYKyMBFo6qNFEyo9/6Nhc25NKih0Cnmj8S3tmwPxns0kHV6UhK+eUI?=
 =?us-ascii?Q?XaWWaxzfcppGIzyylkM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6170dc-e452-42c3-2216-08dc5b3467bb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 21:06:21.7480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4e2qBKfnb1lPBEqZqKURDlx5ZnW4ZhZvV7uPrMalrnu7GMpSClQOP/q/5WoMP/y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9050

--=_MailMate_1FF823B2-2831-4AD4-BF46-4033E1FB2427_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 12 Apr 2024, at 15:32, David Hildenbrand wrote:

> On 12.04.24 16:35, Zi Yan wrote:
>> On 11 Apr 2024, at 11:46, David Hildenbrand wrote:
>>
>>> On 11.04.24 17:32, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> In __folio_remove_rmap(), a large folio is added to deferred split l=
ist
>>>> if any page in a folio loses its final mapping. It is possible that
>>>> the folio is unmapped fully, but it is unnecessary to add the folio
>>>> to deferred split list at all. Fix it by checking folio mapcount bef=
ore
>>>> adding a folio to deferred split list.
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>    mm/rmap.c | 9 ++++++---
>>>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 2608c40dffad..d599a772e282 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_rma=
p(struct folio *folio,
>>>>    		enum rmap_level level)
>>>>    {
>>>>    	atomic_t *mapped =3D &folio->_nr_pages_mapped;
>>>> -	int last, nr =3D 0, nr_pmdmapped =3D 0;
>>>> +	int last, nr =3D 0, nr_pmdmapped =3D 0, mapcount =3D 0;
>>>>    	enum node_stat_item idx;
>>>>     	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
>>>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_rma=
p(struct folio *folio,
>>>>    			break;
>>>>    		}
>>>>   -		atomic_sub(nr_pages, &folio->_large_mapcount);
>>>> +		mapcount =3D atomic_sub_return(nr_pages,
>>>> +					     &folio->_large_mapcount) + 1;
>>>
>>> That becomes a new memory barrier on some archs. Rather just re-read =
it below. Re-reading should be fine here.
>>
>> Would atomic_sub_return_relaxed() work? Originally I was using atomic_=
read(mapped)
>> below, but to save an atomic op, I chose to read mapcount here.
>
> Some points:
>
> (1) I suggest reading about atomic get/set vs. atomic RMW vs. atomic
> RMW that return a value -- and how they interact with memory barriers.
> Further, how relaxed variants are only optimized on some architectures.=

>
> atomic_read() is usually READ_ONCE(), which is just an "ordinary" memor=
y
> access that should not be refetched. Usually cheaper than most other st=
uff
> that involves atomics.

I should have checked the actual implementation instead of being fooled
by the name. Will read about it. Thanks.

>
> (2) We can either use folio_large_mapcount() =3D=3D 0 or !atomic_read(m=
apped)
> to figure out if the folio is now completely unmapped.
>
> (3) There is one fundamental issue: if we are not batch-unmapping the w=
hole
> thing, we will still add the folios to the deferred split queue. Migrat=
ion
> would still do that, or if there are multiple VMAs covering a folio.
>
> (4) We should really avoid making common operations slower only to make=

> some unreliable stats less unreliable.
>
>
> We should likely do something like the following, which might even be a=
 bit
> faster in some cases because we avoid a function call in case we unmap
> individual PTEs by checking _deferred_list ahead of time
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2608c40dffad..356598b3dc3c 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap(=
struct folio *folio,
>                  * page of the folio is unmapped and at least one page
>                  * is still mapped.
>                  */
> -               if (folio_test_large(folio) && folio_test_anon(folio))
> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdm=
apped)
> -                               deferred_split_folio(folio);
> +               if (folio_test_large(folio) && folio_test_anon(folio) &=
&
> +                   (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmapped) =
&&
> +                   atomic_read(mapped) &&
> +                   data_race(list_empty(&folio->_deferred_list)))

data_race() might not be needed, as Ryan pointed out[1]

> +                       deferred_split_folio(folio);
>         }
>
> I also thought about handling the scenario where we unmap the whole
> think in smaller chunks. We could detect "!atomic_read(mapped)" and
> detect that it is on the deferred split list, and simply remove it
> from that list incrementing an THP_UNDO_DEFERRED_SPLIT_PAGE event.
>
> But it would be racy with concurrent remapping of the folio (might happ=
en with
> anon folios in corner cases I guess).
>
> What we can do is the following, though:
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index dc30139590e6..f05cba1807f2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3133,6 +3133,8 @@ void folio_undo_large_rmappable(struct folio *fol=
io)
>         ds_queue =3D get_deferred_split_queue(folio);
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>         if (!list_empty(&folio->_deferred_list)) {
> +               if (folio_test_pmd_mappable(folio))
> +                       count_vm_event(THP_UNDO_DEFERRED_SPLIT_PAGE);
>                 ds_queue->split_queue_len--;
>                 list_del_init(&folio->_deferred_list);
>         }
>
> Adding the right event of course.
>
>
> Then it's easy to filter out these "temporarily added to the list, but =
never split
> before the folio was freed" cases.

So instead of making THP_DEFERRED_SPLIT_PAGE precise, use
THP_DEFERRED_SPLIT_PAGE - THP_UNDO_DEFERRED_SPLIT_PAGE instead? That shou=
ld work.

I wonder what THP_DEFERRED_SPLIT_PAGE counts. If it counts THP deferred
splits, why not just move the counter to deferred_split_scan(), where the=
 actual
split happens. Or the counter has a different meaning?



[1] https://lore.kernel.org/linux-mm/e3e14098-eade-483e-a459-e43200b87941=
@arm.com/

--
Best Regards,
Yan, Zi

--=_MailMate_1FF823B2-2831-4AD4-BF46-4033E1FB2427_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYZoksPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU/2oQAIOxo4FFyH9dbqR+oCb4nZrcpMjPDP17ttIK
ZEg70a9kxLMYIP1pCKyucYHC0KLlq9/xNF99uDZV4aHCD1pSFllAqX4qJ18wzZ9S
boH8NNAbkSzQxR+vS3/4mYn5BsO/LYTOQVyDUR4R1nXXzusgoGOueKffOQn+1hCm
12m6/luVzCKZDT1HP/YGuds0Q+VwAUJwXXnNwpCsM+7b3XRpnMtFM4LL8L35Y14t
2rwRkAc0ONwWuVJAbOSqnCeobZZC8SSwc6FDB15hakcgxFWUG4Mz6JQnAds5a80e
XnURSlCWiKUkG8bKLfqLV1LtNBFWUpghfZDxdW2hP82Ov3Yu/iI+Cda1V6KoNPu7
G0YQlOyFIaGdzRFPeDtKxQcjtB5wos9WneY3NRhJVwHAY9pPIMYlaB1zT+nE0zMq
6osjnvZo7K6J5bYRoL3g9eZvXa4PcVO9+AqL9QXeXEb9yPL4VcAPbHjhJYELxGB/
L5xXwQ+jX2ctr91uYaF/DsLpIA913VU1Lgw02ZKsrT06Sg2O9fzpv0LM6EDT59LX
SIRuGpR5zPlTch1iNXBuZSwzAGRp2IS0zBpsnOe+S7lmUnMTk4xMNo2kRpKAg93d
OArAZrYQoxLIguzScKfeS6nj2d0bl5rfylAKZM2uhbkwtiSCxLvjc5oDrKnncq5t
yok/70H5
=bYcb
-----END PGP SIGNATURE-----

--=_MailMate_1FF823B2-2831-4AD4-BF46-4033E1FB2427_=--

