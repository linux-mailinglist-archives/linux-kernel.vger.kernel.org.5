Return-Path: <linux-kernel+bounces-61853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A30851771
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D3428315B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BEE3BB27;
	Mon, 12 Feb 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zb6UvmYc"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B99F9F6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750039; cv=fail; b=P+SWEbypbZWfXvjkFwwy8o2/NYyd0kW8f/v0OfO15ozzvw6ySd4NeOAiCoOn2KeT5xyX6LxRs91yuB8MJmg8u/4nKF6MNaqW39xJ9ynJmXzSDMVe3d0eoAId7Iqdvi1J++Zap/Gi/LiIbhbjzlMcg1uVyVXCf7ZktQLuBR+WeBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750039; c=relaxed/simple;
	bh=bCmxVlshXpiYgyelAwkdBL2Qob1SHdVqaBxfKOVF9F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lvt1gwGOzINjhklRd0yD8rIk/uLLdch5mtK5FKGXzojjdT3/2Jo92TY17fX/07SwWzKiliaGLLo/OWerdyvSuIMDXTN3wbqeL2G42ySTahVdYAITIESC60SKdP8EQ6fdYF2fCU8kCBFYwxsGuFBVa4OzeeCF5JFkxGGZCygWnEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zb6UvmYc; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B395O5/ahsUMfvz9hJQgI/6hlLgMDk357hA/mB017YGY20dwVPpLu7J0OlRltLlPaUqnXoc6h+2JbytMXsgLyvdAE5AlKJkLJ4K7K+5OY1zrtkjpsgkgwAGum8jBpyxM0/eRM2dT9kyHdsE6LFE4mTRnAG8FpCkMuhOL4rwSLJmgaXN9s/EK0Py9I61YT4qw17szGzrZdy4zqpGCHWPlPPXOtpPQEIUjb7RdUXFex1Et0WnJ1o/8C9yBGs3AF22RBkzTzdHfhwtfRCg6LwwWo1/y6I4DewZj+v9L4g6HrnlMSb8HhT65pasUVYq5ucuRNzGp17CuSaKEZtK4EkJ7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BojszTW/dlnounflia3xR+ZHbgYeAPjdtACJGZ0fIlg=;
 b=GL5IFHjBWCuuUdDrWTQHuRw+23P7QwzOoJ2b802sg7JygtWfOUb9vxHztMcJE00NNblnwfPnCJv+qQP0iIyCyl1IQMOERKSKbPkJwY8V9R+7hSTfQ/FqzHW95SeMYx+ETu+m8PrgR0KZKfecDMiYhI6o9WFPNZHSP37KH+x302cmxfMDIYx+Pf+ac9WJnmmtMUjtmFfW+LQHSwUxev/B9ilBogdHXfVga8lBNToahF7pWRWFGh1WVnuDQiGHSBh1j4Gfn8EiSV65zlC2+IiUGoqglzEPO4hWnA88tX0nuknlDWhzarkrX9i2kXn9vGRGULDoo1fi2d1e2XNBZWtLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BojszTW/dlnounflia3xR+ZHbgYeAPjdtACJGZ0fIlg=;
 b=Zb6UvmYcmbzRA/5HDantrAsLWxJVXsxHMLwQp5JrGqd6jIjkb9hgPLKtKl/9+ESlWIenQm2gqIaQoHPuJx12R1EBT381bZAhJwj/uE/tv7w72QE4bC6E6sFU3k/8oSFkRlXnJYW04StvSW045snvzqJclZJOmzRyeefXTwOVyMz/+l4SE0SCpC3BaFMGEuuSECxay6WwYzKzYczPTlIZu2xPXClnicPzxxTeOSSIWoD5dUEuYyV6wER2F71mzgh69euVEo608wQAuF0bXFma1PVvgtBv7oFBOnyXAe5A83rO0yF1HuwuemqW3Kt+IGqL6haMZR38UBzlLtw6d98iiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.14; Mon, 12 Feb
 2024 15:00:34 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7292.013; Mon, 12 Feb 2024
 15:00:34 +0000
From: Zi Yan <ziy@nvidia.com>
To: Vlastimil Babka <vbabka@suse.cz>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: compaction: limit the suitable target page order
 to be less than cc->order
Date: Mon, 12 Feb 2024 10:00:31 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <5277627F-6791-46A1-AFC2-54FBF0DABF1A@nvidia.com>
In-Reply-To: <20c8fa7c-62ae-4e48-aaec-8b512519cee9@suse.cz>
References: <afcd9377351c259df7a25a388a4a0d5862b986f4.1705928395.git.baolin.wang@linux.alibaba.com>
 <20c8fa7c-62ae-4e48-aaec-8b512519cee9@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_EC359E8B-9628-4E0A-93E7-7B79D4DB9C6E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:208:134::26) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b24bb6a-5bb5-4268-4bb0-08dc2bdb5d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R6dgQEFIvd075WYjhoQwbLpv9wKjTizKPvNRJ6kw37d3MS80FPUhUV1axk3EbBvrpWJW9z/qU2aYBRIDIvevv7tfe1Ez9EwrnkgPdlk8f4nWK4XZ8W8E2AAl7059FR9nPjm1yS3P00Xp+/x8tluJAb2GNNB51ujhFPnsFAV/t2XcDGu21Zehtj2hdkJVsiG1VPX+CdM5bBMpRF0WToj850AcLfHiCUiyKwFELfIy58J44Lzvn6wKsr7Tsa1xdln8Pn+XRjkYj8xaHz4c3BvAqRO0te2sLuXZ/HfUpGOyvNgCvQ9tcPpGD2Cqr8c58Lm3qLRQ2etSN6aPgjKRptx0KNBuRsRQM01RV2a1uDbY/d/jguh8fckEtZDWt0KW8f0aFagfDQC6mxhQa3anW2dBZY+m4nK6DGOojfrwFlQiwmKI6meLH6RVo0Y/dncE6kgvp7LK+CjrohU3kjReDHsG7GO/ns39worvbtU8ker7c7cG76SPFKLXMiN6BqiuQwWFn78X7nrvbWp26xTC3TCbGwWMyd+M2lXC0U6yzHwYRLaFI6ZpYz0qHODO/5a17DmL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(33656002)(316002)(4326008)(26005)(2616005)(53546011)(478600001)(36756003)(41300700001)(66476007)(66946007)(83380400001)(66556008)(5660300002)(235185007)(6506007)(8676002)(8936002)(6486002)(110136005)(6512007)(6666004)(38100700002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lmp7/4f3Eu1ZLp2ghQrqdnuSIlT2X7DOg18UFcLpM3kQ5zj2xSp7Ys9BIVtl?=
 =?us-ascii?Q?yiHTSd1JpyxaKmaT2jIeEOMlq1yqA048GiCjhBOqggyYhN0jLN0wmcKeYXRJ?=
 =?us-ascii?Q?qjxpsDNB8lUxDqysdwKIsGP2v7Abi3Z/mLnpna9N3uq0l42Zsk8WQfQhcUp0?=
 =?us-ascii?Q?lnq2itnrrYlRbvB5vQ2R8tQ7bk/npva2GqBABGbWoI7fdKTTw5kYz1AvOs5c?=
 =?us-ascii?Q?yVPVO6cUvb3jLunQF4zniTrGGTUX6m2Rieyn6aXMUVdABcb5IslBNj5UPCyF?=
 =?us-ascii?Q?DfoJz2mcAoIoFDgJA5mUaZoeuWEHRNanvkaz0/wCKxqKyZN1WCd/WHyg/37I?=
 =?us-ascii?Q?lKF7kwtuUODkFFfSjgeYGZmEt5j3Lg1uaF+kL2wrI6n/3GiB/tUfhukh0UHu?=
 =?us-ascii?Q?3UgP+1ZcjU4Z/wUFJ14Xnq/Jq/IYeUTJXJpiYFog9VRbx0wt8+QF/5YMCV9V?=
 =?us-ascii?Q?5U+4qutiYhyG+dHz09atwGbUomgEWUBEl1crXPndHcvkMwLQkb0q/ZTdQBSc?=
 =?us-ascii?Q?AsXc7KatkGQxTyvyHAm+JPKjZ8Gdi6OPO4qiGiqJVRIcPufuAUeBY+/ROX5a?=
 =?us-ascii?Q?PRqKuvdv6nK8LIClV90aXD3wq9FfzjCVLvAGlFzhjoPz/wMAfltWfVNjn9Pg?=
 =?us-ascii?Q?EOzbWeRifdzN1CWr6Av/6mb4LinGiP6QcWWPKRNM83GUoqjJDmy4pEu+Yadg?=
 =?us-ascii?Q?O1gqy6+LimvCIG9pjMCHAFlujzmSw+aw3ywiy4fjajbZ8ORbsqGi905DtF+p?=
 =?us-ascii?Q?yzrUos5tNdBtkeHznRkWGW7F/xvoiwjItbmJfIlguosJDCQFAOuyYH2v3DHm?=
 =?us-ascii?Q?2T4NYGfJcwHl+KvfTKpQHrO0C7bXF/TQ0gLKMA/Yx18H9GPjDszFHbrXPsMz?=
 =?us-ascii?Q?bu4pIxFmKoPI3WIgs2RalPkroJAM8vY0QPWXHK+y5hR8UEjSC85a+vw8bcUi?=
 =?us-ascii?Q?6fONri4iiooSIllebHbcvpdDBn5Yr5JZ1XgiwxW5+PkWwC333BBiCzhKK+02?=
 =?us-ascii?Q?hSkDCyKBJ6You0aL/lqR4sX65+Kw4Bt6aGY1tNXVLyQ1MlqGVErZBk5+fELW?=
 =?us-ascii?Q?8C+G5Z/Agl30yB1SwmjVUDsNcsvHOYkj0rs8NrZUFujdvESDTSux1yzBkYMh?=
 =?us-ascii?Q?gIopLegZ7jin6GAPmCkaeZx0/rWR1XP2APazqcnok1P5ckuWYbb0hM5obVCz?=
 =?us-ascii?Q?6OfeI7oTAWRm8Px/w2Mr/9e2ywQQfSgQnT97x716M9fjXQ06eTIQuBsDWOUF?=
 =?us-ascii?Q?JCy9o13U8bboXUGS9ULNFiEZJLHFVvdBgJMbtI1rOjMvF5j+XTEFscKcQTFu?=
 =?us-ascii?Q?mkdo/9uzTizCHKA+9DSPYilKYtldpRt4mHE55DE1jg8RYdSm2SD2Aqxh/jtZ?=
 =?us-ascii?Q?2ILtF7CNzpZ3PoLKMF2GQtifo1i7NXoPx7CIlHKUs/LDrTcNejmVHjYrLaJ1?=
 =?us-ascii?Q?DnxTx9+oQ4z7haTC1ijaT0ybQQ2CE8BY/WRuD1PHdhlDbOmoRljcW0cGAOPp?=
 =?us-ascii?Q?YQfJpBrTdbkz000LN9lQXAdzu/mBF+Q7Z5RMjV/N7pRRdHO2GJ39IWt3QYN+?=
 =?us-ascii?Q?cyPnh7J1mkg1BB0VKgwrm0EQkPY2stp5+GO5wggh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b24bb6a-5bb5-4268-4bb0-08dc2bdb5d2b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:00:34.3333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zo6NysN9FqEGPjF7PWb2Fm284wc6peT1+TMpGOW08088Y7Mp+E9TckHMasBNPSvJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418

--=_MailMate_EC359E8B-9628-4E0A-93E7-7B79D4DB9C6E_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 12 Feb 2024, at 4:13, Vlastimil Babka wrote:

> On 1/22/24 14:01, Baolin Wang wrote:
>> It can not improve the fragmentation if we isolate the target free pag=
es
>> exceeding cc->order, especially when the cc->order is less than pagebl=
ock_order.
>> For example, suppose the pageblock_order is MAX_ORDER (size is 4M) and=
 cc->order
>> is 2M THP size, we should not isolate other 2M free pages to be the mi=
gration
>> target, which can not improve the fragmentation.
>>
>> Moreover this is also applicable for large folio compaction.
>
> So why not Cc: Zi Yan? (done)
>

Thanks.

Hi Baolin,

How often do you see this happening?

>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>
> I doubt this will make much difference, because if such a larger order =
free
> page exists, we shouldn't have a reason to be compacting for a lower or=
der
> in the first place?

Unless kswapd gets us such a free block in the background right after
get_page_from_freelist() and before compaction finishes in the allocation=

slow path.

If this happens often and cc->order is not -1, it might be better to stop=

compaction and get_page_from_freelist() to save cycles on unnecessary pfn=

scanning. For completeness, when cc->order =3D=3D -1, the logic does not =
change.


>
>> ---
>>  mm/compaction.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 27ada42924d5..066b72b3471a 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1346,12 +1346,14 @@ static bool suitable_migration_target(struct c=
ompact_control *cc,
>>  {
>>  	/* If the page is a large free page, then disallow migration */
>>  	if (PageBuddy(page)) {
>> +		int order =3D cc->order > 0 ? cc->order : pageblock_order;
>> +
>>  		/*
>>  		 * We are checking page_order without zone->lock taken. But
>>  		 * the only small danger is that we skip a potentially suitable
>>  		 * pageblock, so it's not worth to check order for valid range.
>>  		 */
>> -		if (buddy_order_unsafe(page) >=3D pageblock_order)
>> +		if (buddy_order_unsafe(page) >=3D order)
>>  			return false;
>>  	}
>>


--
Best Regards,
Yan, Zi

--=_MailMate_EC359E8B-9628-4E0A-93E7-7B79D4DB9C6E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXKMpAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUgSYQAJA+p8PbfyilA4bzNyOm4SFYsVwTUN1nvWJL
CsitHbqCwgkeuHaaaPLBk+GKglYNFbwP1D1qILXtWs8fj+1q4hQb1+0WZTvLp/VE
Z9gY6K68PtUk4J5UZrNVAk54ak9kYS5qVyEAbWLLbZEP8r2r6C3PDXtWusEOTvQo
IwE4faMLrt8CChKlceiBMKaSISQQlaNahM41iy/bu3cat2XCwuZT23KjXQgcYJe8
qfwHMme4X5JOEZD249QYv57YZMp0OW4zQ88sxwHip4cMV6hXeA6yfbIBpMLO/au4
38S6ANiMBPFBGCCrnTCPUlaYareFaBB7R6z+oPg0Ufp75Oc7vtrsXCLpDyCplNlZ
/JhjUpRfULSaGQsVW9Bmq6WypdP38J9pZx8sd/lao1Hj10HnkGIjKaZYli3a6xAQ
7lePrycOW2fP7FvBisND6aWpVBKnBFmYJb17kK1MRQhM4r+OhcKtG77rEOb/ed2E
pXplXfi2np6iVQ1sJLCkgLkL7xseuXsIm914zh4fJTV6Xeh5rVQf1fYauWjnmmiB
uRIki4a3tlSFpVl5Q5W04xb63aRUrlB1mhlekPBiM7RmGXZy2R4Q1M4lcam9aenU
FpRNeAFf6TZbbl//haxXrmjdEZmuVEmN5naeLQc+p77wZtEVfyFrH1k7dwalJSws
IBHDpuQR
=IYH7
-----END PGP SIGNATURE-----

--=_MailMate_EC359E8B-9628-4E0A-93E7-7B79D4DB9C6E_=--

