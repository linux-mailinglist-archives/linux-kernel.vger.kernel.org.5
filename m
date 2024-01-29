Return-Path: <linux-kernel+bounces-43312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AF2841205
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C551F24830
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8B513ADA;
	Mon, 29 Jan 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aNAJqleb"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379FF33CE7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553145; cv=fail; b=hEALU719YIiSBoVdD9vrC57wSBJ9N2jlUA4st3NVJSlVSn9ov+bXw+D5I76EdO6rSkmALaVdUn6px33T40L4Shz+zdd9X+XqTJ55Wue1kSSWm6Uzt9uKDF+eAU9x5WFuRw7B6dtWxkCfaO0bIE9j8/vO07HkHhvuZT/0YatPZns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553145; c=relaxed/simple;
	bh=868cwphYqMBzINlcevQrkb+tpC/rpOsrBobgluEHGcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZGHn/IO4Hbvm7O7p+0Z+E7tnxpucun2gMAWxlAmJADAuax8DFyCYtlhZ3tGjWdrf3dqnxiqpw/xwh3EAXwRq3FMxBVbsNQTEUUmO6cVk5AqtdTzUhQvD0fIgCYC1r+rLv1uZu89C223jgAUwuIe4edZNA8erdD8A4D60hDpmXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aNAJqleb; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfUO6Msh6xZ1GF/x1GopCJUPXDbbd4XeSubyx8ZBWko+I+pLa1V39R2wRkl42mMso348fiGfenQrtItQtJEQw3JdvHguw66TohwaCabCCGVPiklYF/2vON/OHYKVjiVt8toY8kNh3GVGDn9Mh1WaNzdFm2JMl1kEwcfz4YlIVikjgGaKJARJwTMcYF1+36re1kBRipZepqLO/WTGFA1wCkZ4IT4nK0qdXBieN7/gWYbReDdqn8JMuN0ye8Dpsypa+uJq3yrzoLz77QBIzwFsFHOqgXA9og4aIXEhQG3S6F3bqqGNBEkZUNdGhpIUsOODBuwGLZdWo53fAladGTjPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk8E0v66+vP8VdhaFSNPL5KbWvqtxL3V0iYA22udKgg=;
 b=je3+RjsIBY0ZuyO63/miL03cEzAGPMThT31Zqee9xTfhAo/Kkdc9R3dayyLx+aCp3q9rCsxwQM0gPTpZpnYh5teLOitoFAqVirajQJSO1sNSxAg3AUqsc9NByK0C2PWhSunryjZnVZFKnG5wrIdhBdeAcPj2DFAlYYJCgtPka7Nfbd7jOQP48bmkhudO64npKt0DzFIL3BRAmzgS3ZUUkQfgmpsT+08zSZgrltARJGOFBEW9g4VAOreix6ta0teTw5Lge0K11VAROe2qtmPiTYxgMaY02nJkONHlO4Op8/nw9j9h6zYA5MBftnxQR3P07+qIPGUBxf/YAI98oWURRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk8E0v66+vP8VdhaFSNPL5KbWvqtxL3V0iYA22udKgg=;
 b=aNAJqlebKMgn1SuafoLHgK/14ZXbKFuioi6q4O+/44GzM5QtqWatgM2xsiZ/8XqE7PotJX36OrdCjCi+RjmztmrfyjyrxB3mtvjv7c0YTJ4gIbDraZT3QNDGhwBBppTgDGC8rfuTNjqHphW6NRrWOpO+KjFhzlWnNCsyNpgf0MJHniHSZYvOJiYN9P8pGAMX0QPnlrdQI6JhfToy6ZHIKzE/HJp62gmHLO2GEO4XvE/4HLhPAP91mW4GL7Sr8MKiXboYHTnD3y5vbk3C9AB75GzAIl8ix5oOB/Rl6Zkfe1cqnPjnHb3kn5bNvJmG7GByXQjg+beSYPf6wRqQM+OiQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 18:32:19 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::63ac:1dc1:e486:121f]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::63ac:1dc1:e486:121f%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 18:32:19 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>, "\"Huang, Ying\"" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v2 2/3] mm/compaction: add support for >0 order folio
 memory compaction.
Date: Mon, 29 Jan 2024 13:32:16 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <23BA8CC1-1014-4D09-9C33-938638E13C01@nvidia.com>
In-Reply-To: <20240123034636.1095672-3-zi.yan@sent.com>
References: <20240123034636.1095672-1-zi.yan@sent.com>
 <20240123034636.1095672-3-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_531A4F8A-D19F-4C4D-B350-FBF4281FFA54_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR15CA0002.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df9edb4-21ed-4387-dcfc-08dc20f8a001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LUAd551UDZYa2xtuQR+aXnBusoPGDlqjPzi7Bai37pkr9aie9vPQXE7Sd+MI8AjPyFBe5dNVGed7SuQXsyskAh2uKnMY3C5IYEqViEJwU1W7OyuKCL20dQp5tqudE5+5x4RCs8oknh3rkR3kSu0DN6cXbLskKt/2uExFDJEk5tBNIoaLZyrR6OeeKaFCOsI1j3KUkNqbF2r9uTIhK5YfKi3DrAtV9dJoZG0queiFnS3bx4u0faXDzvW73er+JzOOKaZjUgJcqk7IyADUX1oUx9JUGOcU863KKWZF9Vzis5Qm5pVaOGye9whOEahjeQO64f3Zy72W8vWirCtcQJCyyrmoXlIXQXFZUb6PPJb2FPMWHfCPMn9D/dLIntZWESlTscSAU16Di91Iz7BZgex2gf5FwPNrwiuuScB0WkilxvQe74KUWTLpMi9X6VQMgZCaVtnDVJtCfKPMt8osQ5ynLpQcBibnKeDmJjcEsiKByVP1CTOroLRTRPa/i1CY5OnMxisMqHjHkxX93/vOCQZ3EmUNbexlweKP7kb0uW934Jj36EbK5qQ/SVZmk/xPdInpWrEg9t6Yy47Oz2i/i3pS0+OXT8GrBV7iwMEGR9rSTJCaPhYt2RM1Hk9MA/Xn2H3E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(38100700002)(6506007)(86362001)(316002)(54906003)(53546011)(66946007)(6486002)(66476007)(8676002)(8936002)(2616005)(5660300002)(235185007)(6512007)(7416002)(33656002)(26005)(478600001)(2906002)(4326008)(6666004)(66556008)(36756003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dJcq20gHcBMTl/q7AEGw6OZNQbrJKj/QVh6JSv9ehlHOWNJZX8jfRC8o+/Pn?=
 =?us-ascii?Q?UeyVyqKgGAxUZZFzMHbM9BR3tK3pzhB+9sbQ3lZaY0qIH3O6O6GUH/RMtamw?=
 =?us-ascii?Q?F5XgvrJMOH9yEyt1/tSx8uZlCtR4kBunbwcXY76LdL8M5/fwe483bA7TQwL+?=
 =?us-ascii?Q?WlCSZyCIX6lRU016NzlqAi88khoaTKEDLPQHoIFFMRXF31I16PUWtYly8f3o?=
 =?us-ascii?Q?OIMH9vNW3nbQhUX31tWPOBff1e+RwGeCaEEIc3w7EqaHbMJSHXZqG47dh+Me?=
 =?us-ascii?Q?ms4sBjopjQraW0ajDmRHWH3DQY1t02NjsMiuqZOFG71hknNQXXcQsrGnGPGv?=
 =?us-ascii?Q?4SsLCfXb51ckmvrpnl88hZNcICDAuBPdsTd8grISr3aPxXgjt0m/Mqk4Boh1?=
 =?us-ascii?Q?UBK0e4J95UFTi8SJTTrFXU62cS1Dhm78RDs4EkQnomhOjy3pyOn6OqRX9vql?=
 =?us-ascii?Q?WqMIoRNSdqLAmDJGyQi0s33+B3gN50pFqgpqlfqvVa4u2NGKYP3rbGypylQ0?=
 =?us-ascii?Q?SlqMr4r5qSPUWw71GFiHOV9oos4obzl3srOmbLBcWmmLHfYh1H00KlubdeiT?=
 =?us-ascii?Q?/3EA6FnWZL9sPop2wDNQlSwfar8tKUgmU3B3OKk3Yo7y24G66f4WhiL7VPFq?=
 =?us-ascii?Q?pO1oxrvafDqmMHP/0ffxl2V6MZ/1gXsh0brJAz5UGY5Dx7DsF+PW93To9jEb?=
 =?us-ascii?Q?I9m6D32dpBZEP1VglC+jEKEu9fpBKTis3kYnNs4MpIXbx3qO2uzda7uAvoaj?=
 =?us-ascii?Q?9FGa4i8AE8iKP4DqPkVf5laHzqynquvhjTmzUNFVz53/IG+0lFQf/pAy21kG?=
 =?us-ascii?Q?nl7SbYXFWDe3lY8+gnegt1ER+Svvkw4hwRYvgwpZdTPoPnvc2HPrHIyG6AVL?=
 =?us-ascii?Q?Feay1LEcFYsOFIhvc3eksPuGp9rjs1u5MQ9NODR6mOmwkhaWHTf3PqF+YylX?=
 =?us-ascii?Q?xaTqk0mz4AMmip7qBSBKNJ9HUWQ0OSR/geuzJXE9coj/0BKwtdbE+PzZrpab?=
 =?us-ascii?Q?ZmNXXSAHf17GgvXQL+l1XJBNCyCD1lKBNyTXvExs0m2T51lUfG7NWyvXrnV0?=
 =?us-ascii?Q?iwrEZAQdB6WZObmOKHKoqNxHajDgs9NkllWmmIFdjmHi8Vh2XMEhfvO3sARo?=
 =?us-ascii?Q?AseQEGK5X+EoQrxPokeVtJcoR2DovHG2kDh0d7eR0ZelN7lTJwIevGiJa+NM?=
 =?us-ascii?Q?uQx/Vu2AyTza+BpN/P4ZFBUDSAIUXRjz8IlQ0Kb9sy7pG8Pb3VT1wk8ydnEs?=
 =?us-ascii?Q?u6axhNXY54wJ0GCstLujUDp4SaIQwyxBl3LfYtAKbT7JqIRX7w6ed9GgsT4g?=
 =?us-ascii?Q?PSqyyNLuNdrqI4Qp9iLapLb1MmLXpVoov5tgbFj/Pw3WC+3esNo3Yg2ZXwnP?=
 =?us-ascii?Q?8YXCkE1JINoABOo8MjDSgk4F9PlamG7aRm/b+ZQ9fievMXfWNrmN0MPx9gi7?=
 =?us-ascii?Q?TzpsaMc9+mu7f9aYy9FtzqksTPgVPsS/XUFiwrW9PPolrNM6cRH4FQetlqKJ?=
 =?us-ascii?Q?VR1ghDjdlnYlG71DcJprMRlYrTMWoE8NufWg21RsH6u3b/Op/DInP4HG3jkG?=
 =?us-ascii?Q?MQf5JTUb3PwWolV3gb4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df9edb4-21ed-4387-dcfc-08dc20f8a001
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 18:32:19.0176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sMCKcXqU7MDosND/swG5RTd8er2DQkyhouPa3rzeH1OiEtt1J8Em9cWLwXJHDPS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368

--=_MailMate_531A4F8A-D19F-4C4D-B350-FBF4281FFA54_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 22 Jan 2024, at 22:46, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> Before last commit, memory compaction only migrates order-0 folios and
> skips >0 order folios. Last commit splits all >0 order folios during
> compaction. This commit migrates >0 order folios during compaction by
> keeping isolated free pages at their original size without splitting th=
em
> into order-0 pages and using them directly during migration process.
>
> What is different from the prior implementation:
> 1. All isolated free pages are kept in a NR_PAGE_ORDERS array of page
>    lists, where each page list stores free pages in the same order.
> 2. All free pages are not post_alloc_hook() processed nor buddy pages,
>    although their orders are stored in first page's private like buddy
>    pages.
> 3. During migration, in new page allocation time (i.e., in
>    compaction_alloc()), free pages are then processed by post_alloc_hoo=
k().
>    When migration fails and a new page is returned (i.e., in
>    compaction_free()), free pages are restored by reversing the
>    post_alloc_hook() operations using newly added
>    free_pages_prepare_fpi_none().
>
> Step 3 is done for a latter optimization that splitting and/or merging =
free
> pages during compaction becomes easier.
>
> Note: without splitting free pages, compaction can end prematurely due =
to
> migration will return -ENOMEM even if there is free pages. This happens=

> when no order-0 free page exist and compaction_alloc() return NULL.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/compaction.c | 148 +++++++++++++++++++++++++++++-------------------=

>  mm/internal.h   |   9 ++-
>  mm/page_alloc.c |   6 ++
>  3 files changed, 103 insertions(+), 60 deletions(-)
>
<snip>
> @@ -1462,7 +1489,7 @@ fast_isolate_around(struct compact_control *cc, u=
nsigned long pfn)
>  	if (!page)
>  		return;
>
> -	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, f=
alse);
> +	isolate_freepages_block(cc, &start_pfn, end_pfn, cc->freepages, 1, fa=
lse);
>
>  	/* Skip this pageblock in the future as it's full or nearly full */
>  	if (start_pfn =3D=3D end_pfn && !cc->no_set_skip_hint)
> @@ -1591,7 +1618,7 @@ static void fast_isolate_freepages(struct compact=
_control *cc)
>  				nr_scanned +=3D nr_isolated - 1;
>  				total_isolated +=3D nr_isolated;
>  				cc->nr_freepages +=3D nr_isolated;
> -				list_add_tail(&page->lru, &cc->freepages);
> +				list_add_tail(&page->lru, &cc->freepages[order].pages);

I did not increase nr_pages here, so compaction_alloc() thought no free p=
age
was isolated.

This is the fix:

diff --git a/mm/compaction.c b/mm/compaction.c
index 335a6f6787e4..fa9993c8a389 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1638,6 +1638,7 @@ static void fast_isolate_freepages(struct compact_c=
ontrol *cc)
                                total_isolated +=3D nr_isolated;
                                cc->nr_freepages +=3D nr_isolated;
                                list_add_tail(&page->lru, &cc->freepages[=
order].pages);
+                               cc->freepages[order].nr_pages++;
                                count_compact_events(COMPACTISOLATED, nr_=
isolated);
                        } else {
                                /* If isolation fails, abort the search *=
/


I will send out v3 once I rerun vm-scalability and thpcompact.

--
Best Regards,
Yan, Zi

--=_MailMate_531A4F8A-D19F-4C4D-B350-FBF4281FFA54_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmW37zAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUqOoP/iGdf1zf+AEQ6shsWVGXQDpaHvSjBYBa1+xe
RWNjX+N2na4MoymOYCtExonMi6Wa5vc5DglfVs6WXN38TQRYybbYAUhFg2soVxx0
Z9y62ixIW//8y2cPfb0fg6WJXw8aIMHkmDK9gf8KTf5nTxOkFBxUcPJsTaB17XZf
yY1I1qljmVNdf85Jy4u36DtoXP0+YqedpjBwrqIgIKgf9TWcRPioNCKb6htzmH+h
c5fOWVAtdBCsCoGyjklP/LJ96rZNgN1i+tw2+uWwpNIeB2HHbJxq4ZLkdM3NC7br
KaOf28TaHg5MTnOyMVurS4ehNJNJbkikxIerDa8qDcxGaNXidGyHwN1FcWkdZJEH
cnnA5Cl/cpCypCOETrSqdOQttNtQbARC66SjumLGnrxrK41O7xTFuDTH1btU3Fu/
rVNmwva7j87P1r6i5M7GjG/acCAc9v6e9kR2555j3M8EbsxHt4MCQNboAlknZbSP
MMCPx5G6w7yjKdqBnGLGvz1pW3TVKqgsOpYCGILnB2kzVgAAD67/Qm7OHdwFxuwF
M5UpXGj8SatAOOoxHAkQQdTDWxauZM7xrAru2jj5ThNjMaRfHANrSVN/Q8/UsdEt
lfNBRqXlJRst5f6XfCQivmD7LvienjVl0TU0FIH1rbzHyHZPj3f1C5rJjq3eKwk0
iV30atSu
=V/a8
-----END PGP SIGNATURE-----

--=_MailMate_531A4F8A-D19F-4C4D-B350-FBF4281FFA54_=--

