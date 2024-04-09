Return-Path: <linux-kernel+bounces-137118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614B089DD34
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71603B23BC0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5001882D99;
	Tue,  9 Apr 2024 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZG2mgXR8"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2116.outbound.protection.outlook.com [40.107.243.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339D813048B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674027; cv=fail; b=VV5LyKuuHlktGETJN1RTkV8Q5XsQej6n1mluO+28vZ5t4prZlkHeRtJ5AJ06wBbHdIcC/CqSA0gqs6HkOf9PwCCVLtlMCGLK3R1tAxNQ524sBtWdF7q6k8tLtGqVEDmHuO1/YTWtOdx2ZxncSBdwzT4tNjj6nA0+dz1MBUv5TXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674027; c=relaxed/simple;
	bh=5xPrx+Z/1TckvtuobOrGwDCojkKqDtJh3H1brpdO/5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j+60+6uBB5xFL4ZdEU6ODKoM/jQ377z7AKAZcr/LRnTqvo3XwaAuZ3Fk2BY7n7BWd3/iF48b8h4XMBZ1qm46uv2vxXumsEfidV8SQVhyePnDSqEphZtaygqowBYB4p52jSKbVBlwdEcHHzu/HXGthXvyxK0OWa8Sw0coq0+HrgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZG2mgXR8; arc=fail smtp.client-ip=40.107.243.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsxRza6MaH+YF3gF9TXWYx/AHUf7qiwrT3apxZfzg9OBr3kCSHQi09yhpK0OscoxXQQX8YS3RnzcQ7wws3cRVFgEtEmTTwPHuAwzKJieZS/LGvQnR0J7aFBSAs46Lv/js+G+OZF2y+x1uVfd+iUDSxc6cwzdNxxCjqFFSy75zj3m/d0l4QNUVBzoaygoZf5gnRg2ON/J3px1r/jrdS1Et196Iz60N6a/NoaBz1R7SA9Rah4+/QPcIARpxVWzbAi2fvDwrGCn39gkTz3hxvlBIXKuZcKpDSTi2VbnNKT6rIheHZoZAzodX3r/565F6YbNmUUoxv0a73Pb41KwwvPqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eSvUZZwrwGmDKB1RL0QFQA7vrkcuh7tK9RaX7QtxLY=;
 b=R0q2Y4BunlcHxLqaGeOPaP/cLthFILcWAG/5YUlOTCgHfELjg2Cm7Ghz1iijVoiVIYPCM3xOCAW9c1dEhhuQ4OPxHPd01Xo2RKDut1X71rZPeGGNJLcQrQfQiGtsJekOtkkCLHpDSUOWbzVpW2NsJlYd+rsDDgEI5ZKQLYDeVUXtmr8uSDKJw/wETXeHQPgqwwmiJ42gqgXd/tlpJPuFOVWSmZgYkSrF6Ta81Xl0tBOQ6sFJXP30Y0xq3aT/LrIsAoqUoNV54r6M2VibWIgNcieSZIcLVzJkNJScmYY+VDA7Jj5JkJuvD1W1mluXQauhu1YMXCqr4eyZYfsHOhvR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eSvUZZwrwGmDKB1RL0QFQA7vrkcuh7tK9RaX7QtxLY=;
 b=ZG2mgXR8SSuWEoulo4iO/pabRaigeb8iGFuPLiPO8Rs3aAMFjSnADMEIyw2sAVpnX8rzwWhAo7lXxzJSXoq2sTZlEC2YdJofcnosexOWTyDEAqSEMtJdjFAbLmBsGMajxYMMDIdNW7zLqM8DPweJApAjP3M1HusEOd/GRVg+6jOi07A2IonrZWAC+WeHvmo0gI8iQw4tlY0595qIG4G2qJmOnM8fxtvuO9jbdX0frEUH6LpTD+CYqZdM49pN1ACDNlycs97kSkM8jioeTnUDXtryiRK2Hq1B7l1dPrW4XFHQlAJK5yT8n2f4NDwguLP1WBtYpeCePiHNvB55DslVwQ==
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.48; Tue, 9 Apr
 2024 14:47:01 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 14:47:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm: page_alloc: consolidate free page accounting
Date: Tue, 09 Apr 2024 10:46:58 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <FA55690D-0532-48DE-A929-5FECCB667C86@nvidia.com>
In-Reply-To: <26cb722f-6e1c-4aaf-9edd-ed10a60e0018@linux.alibaba.com>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-11-hannes@cmpxchg.org>
 <7b3b7f2e-7109-4e72-b1cf-259cb56f3629@linux.alibaba.com>
 <ecb88320-9990-49e1-a58a-e8fc85b1da3f@suse.cz>
 <20240408142340.GA1057805@cmpxchg.org>
 <26cb722f-6e1c-4aaf-9edd-ed10a60e0018@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_F5D4F1A1-867E-4A0A-8EA4-C33F07D24F40_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:23a::10) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4341:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u3eOaGWs3c2XYFb7LARw2s31XBAZp/YAgcEFNuHEL0LL/0+QUVjqp1/utDy/x/8pJw/E9ydKn9gP6pevyB7QWYXmaywjf1L0cNvXMdEmVo/Igt8Da2I8JQ6F2SFZLYdBaeAM0xKV6KfB5B3a4cEJJCs3rdp6Ta8UpDZ2vifFND2Pxhs1qi7AYymF8WcIIWzEgESc/bVXLggnFsY70y7v9mnlVDuunbDOxhFEEJFwdFcVTS59K1AqfOboOtzoazvrSR51fFI7jl3/OJeB23lqKHa9iASuHezfeUp8/lxlXDKP+0IgbnN7+gC95uCqG2oN9isCQ4RQPdNQb01/10XYnCMntcM7QYudg5oUJU85CtjaPj8fOQfH0CM1vlVrP5+L4Hk0BO+rOzh6Af3Yn/HLYj8L9o9BBNRH5vJYBxhtk0OaJOhDndimX/3zRP99WKWM4u1MZIPKjD8GPVyBRhq4uG3JE/Hwi4x4gkgy4HcNVWUhXLaG4jZSzjwpfmy06MkKRGd9RS7xnURprsIZL9ZqlzGJuvDE+vEgd4jMooIfICFMimZOgUOvouDf75EckY3V/dTKyd1orXlG0PwKTxIScwI9VxPfvXNd79kiZctGPlWBuYQfo9l/nVsNOr7Ybn3BwFdoKYrlKdQObY6TMXG2TjPKSpJxKfmLw1tqBhU7BSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jOp1GcYFIqKS9ymHwY+mvGXQWkuRKeycgl4Xcu+GtIuguJDh0viic5H3RTeD?=
 =?us-ascii?Q?No/GId8Sz7+8ynmPO67P+YFo+gSXv6FVqRB7jwePKmZ2IFkGc7dezVaDEDZt?=
 =?us-ascii?Q?TQ1MrC+K20Qrk7y4YaG6z9Xkzw/muyPuvWgkFwRj0cQAfYoQZS2sAX/keqR9?=
 =?us-ascii?Q?bGKVAXH0n98++57IFaLbcEHv1ykcR7dAN3KzjIvAbmvansa6ymfcAkzwsi4/?=
 =?us-ascii?Q?xAHgGoOfxspqxeuIcsRhnKswx586PZzIvt/lBQtosibVGE/+fpinnTYnLJwH?=
 =?us-ascii?Q?BoyV+YlC6LtcA+PDAXg4TE2cFneBD88UpMj1dv4GTmYeYxDM2m5wlcW+SOGM?=
 =?us-ascii?Q?tZpb/Lq1TIx5StnDnc+hbpOcIlNQs/4xSx7Ag9vauSWOhNPCyEkWZFXNlFcT?=
 =?us-ascii?Q?0VSdH6BVCv/nl1oUvT4iDstSQIlkFDpiiqfd0PhEeOeU42syIkj9HonCwgmI?=
 =?us-ascii?Q?7dCsZGgqWd9qMq8DzvTVMm/XP75G5g1uRA3oC7cxKS5Dq2EEOocsNj9bxvta?=
 =?us-ascii?Q?kfteRBEqpbVE/3Dcuhn2s9tT4ykwQXB3NSTnQCZhOorx03ywlHjDaou/y3nE?=
 =?us-ascii?Q?ylgsgn2fWuWqBO154p4OQsh4lZD4fkbO/XCLWtc+KYbEQLaLtovxACJJq/2/?=
 =?us-ascii?Q?A6pzb3u8KRVFDTNj/yitx3uNX5bVYKPujZvWMleiaqusuBk59vUmbCdHpFDD?=
 =?us-ascii?Q?/BJdMxce1HxJxQeHWv+nv9qNO1lssy/n7tU3RfTKE5+WWUjQu7hueQ6vpaBp?=
 =?us-ascii?Q?i4ifXakDoDEKOMPNjtESmtPCe78LPdsgCB+6VuHDLKUbl/asOadJVP0bxNRk?=
 =?us-ascii?Q?UkwOFu7dhTn6ng5oj/Wi8R4PiK/D7n0EpsWEKaa9LMfQiejdA4K9OT03sq2b?=
 =?us-ascii?Q?lWB++//HbYfTclL1hlfLj576BYRs09gJ8HWHJSjZ8q5us6MW4eC68Pr1HX4A?=
 =?us-ascii?Q?QV7xUUwMsvwSfj0WpTkKQCECZtUS3JzZEBxnpu76mOGC+m0zEyTHRIpRKZIp?=
 =?us-ascii?Q?JVSgilwYjRy1S01+0iRc0jp0dbGrJZG0x2Iw+9uEM/Wupl8HgQOzuB0kku3V?=
 =?us-ascii?Q?Tn4FvNcW5MCmaLblYdgl9yu7UWFA3o4unTvhmSlKxpoR/b2HmtoJmPoCBypJ?=
 =?us-ascii?Q?0Gj/h6UFnppC1zaO0WGYFTeoiiFsnRFOEqaozUN5aFwt9iPbKTNR7qr00MWu?=
 =?us-ascii?Q?WL/5SieKXHhYU/DnrIpHJdrUzBAN/CNk+wm3KGSSuqYcHJ8rsg7iyLRVTHAi?=
 =?us-ascii?Q?yMBuXTcgSYLFHs8UdPVotb4nNrObC821LQWHCNSuwN7Cuc+/sXLHJ2fMuFNp?=
 =?us-ascii?Q?fV9WMhWvuIBN57fy/ZIViDdkHrVaYU9mR5LlStiIfoakrIMnYekP5eBB7QbD?=
 =?us-ascii?Q?tzKzyM9frTmw0NnUkvu6eZLsEmywZEPdlD5HbdRdTn/7x+iI/o+vwMXsrtwW?=
 =?us-ascii?Q?gEFBiHjGY5eAQZ3XwBXt4Gm5yb13pvxnFcdDFct553aI+4R92S8ephdSsOfB?=
 =?us-ascii?Q?yS6+DLyDaR/d1YrUf13kJLBapkw6OZvG+BKeNdgvIZTb2BbG2MInneSvbwPf?=
 =?us-ascii?Q?l/W4MqKufWqL8JKd7Jo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908965e2-36a6-4403-b247-08dc58a3ea27
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 14:47:01.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxPcr1XjFaYsiBnxQpErplvf9guqE86X52DiprFRFOHSkG0iJy7oepL4lcoGjLsU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341

--=_MailMate_F5D4F1A1-867E-4A0A-8EA4-C33F07D24F40_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 9 Apr 2024, at 5:31, Baolin Wang wrote:

> On 2024/4/8 22:23, Johannes Weiner wrote:
>> On Mon, Apr 08, 2024 at 09:38:20AM +0200, Vlastimil Babka wrote:
>>> On 4/7/24 12:19 PM, Baolin Wang wrote:
>>>> On 2024/3/21 02:02, Johannes Weiner wrote:
>>>>>   +	account_freepages(page, zone, 1 << order, migratetype);
>>>>> +
>>>>>    	while (order < MAX_PAGE_ORDER) {
>>>>> -		if (compaction_capture(capc, page, order, migratetype)) {
>>>>> -			__mod_zone_freepage_state(zone, -(1 << order),
>>>>> -								migratetype);
>>>>> +		int buddy_mt =3D migratetype;
>>>>> +
>>>>> +		if (compaction_capture(capc, page, order, migratetype))
>>>>>    			return;
>>>>> -		}
>>>>
>>>> IIUC, if the released page is captured by compaction, then the
>>>> statistics for free pages should be correspondingly decreased,
>>>> otherwise, there will be a slight regression for my thpcompact bench=
mark.
>>>>
>>>> thpcompact Percentage Faults Huge
>>>>                             k6.9-rc2-base        base + patch10 + 2 =
fixes	=

>>>> Percentage huge-1        78.18 (   0.00%)       71.92 (  -8.01%)
>>>> Percentage huge-3        86.70 (   0.00%)       86.07 (  -0.73%)
>>>> Percentage huge-5        90.26 (   0.00%)       78.02 ( -13.57%)
>>>> Percentage huge-7        92.34 (   0.00%)       78.67 ( -14.81%)
>>>> Percentage huge-12       91.18 (   0.00%)       81.04 ( -11.12%)
>>>> Percentage huge-18       89.00 (   0.00%)       79.57 ( -10.60%)
>>>> Percentage huge-24       90.52 (   0.00%)       80.07 ( -11.54%)
>>>> Percentage huge-30       94.44 (   0.00%)       96.28 (   1.95%)
>>>> Percentage huge-32       93.09 (   0.00%)       99.39 (   6.77%)
>>>>
>>>> I add below fix based on your fix 2, then the thpcompact Percentage
>>>> looks good. How do you think for the fix?
>>>
>>> Yeah another well spotted, thanks. "slight regression" is an understa=
tement,
>>> this affects not just a "statistics" but very important counter
>>> NR_FREE_PAGES which IIUC would eventually become larger than reality,=
 make
>>> the watermark checks false positive and result in depleted reserves e=
tc etc.
>>> Actually wondering why we're not seeing -next failures already (or ma=
ybe I
>>> just haven't noticed).
>>
>> Good catch indeed.
>>
>> Trying to understand why I didn't notice this during testing, and I
>> think it's because I had order-10 pageblocks in my config. There is
>> this in compaction_capture():
>>
>> 	if (order < pageblock_order && migratetype =3D=3D MIGRATE_MOVABLE)
>> 		return false;
>>
>> Most compaction is for order-9 THPs on movable blocks, so I didn't get=

>> much capturing in practice in order for that leak to be noticable.
>
> This makes me wonder why not use 'cc->migratetype' for migratetype comp=
arison, so that low-order (like mTHP) compaction can directly get the rel=
eased pages, which could avoid some compaction scans without mixing the m=
igratetype?
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2facf844ef84..7a64020f8222 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -622,7 +622,7 @@ compaction_capture(struct capture_control *capc, st=
ruct page *page,
>          * and vice-versa but no more than normal fallback logic which =
can
>          * have trouble finding a high-order free page.
>          */
> -       if (order < pageblock_order && migratetype =3D=3D MIGRATE_MOVAB=
LE)
> +       if (order < pageblock_order && capc->cc->migratetype !=3D migra=
tetype)
>                 return false;
>
>         capc->page =3D page;

It is worth trying, since at the original patch time mTHP was not present=
 and
not capturing any MIGRATE_MOVABLE makes sense. But with your change, the =
capture
will lose the opportunity of letting an unmovable request use a reclaimab=
le
pageblock and vice-versa, like the comment says. Please change the commen=
t
as well and we should monitor potential unmovable and reclaimable regress=
ion.


--
Best Regards,
Yan, Zi

--=_MailMate_F5D4F1A1-867E-4A0A-8EA4-C33F07D24F40_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYVVOIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU620P/1ZtpQatoJ0RdMkIcX5JLu3Jy1j3ELtoDfIn
OCMRnyCGDzWd6HjM7giaSBWnqlIe4jyIhf5/9IIv74Vvq6ifEvO9p7NiGOelhmoH
39QtSv8X+/t8EnlPOHDCeWISjlzkc7R6pOKRNjQVoWLpK9JVTZboOoytDfUlfQzB
1AVcK9lIdFHpZchcQRxDrt4JtrvzvBxgP005PJsSa+yN6G3AgVYS4NX/61pNx9rB
m/YF0oedN7luO07VRCLfyrjaziE7eT3LmdXUHkN1MYm/WCeGETXslbEV0dc3kUS2
2LBxoPSP8/FDoh9cZT5BD0uiT5slBX5evuRl6aDVgldy/9K/i0h4xWM9wJ4OAdLn
blzjLVZCaP+0wL1BbLc1ubawr4ccPk/6I4TrUcPB7zzscJLol2JYtD9LksGfNhV0
RwOIWTXyPhqtlmSAJI4SIvm+qMaQ/wKg162shTrNrSpejBACTKvFdKDwtBPpmUla
HfHkjGz6uo1iPO/AYIKEyNhdIWRqqMdlnkWH4dLyUsU4lirljm8Og8HXWUQmxHBS
EpZdlNuijCc/GU3Ca05PGkuNjQwOZc40cccFqJOg9JOa9ShSfWwJ0/sbxKp8rPZc
KgOTk1W9opSN7oJ0Ab859oNGVxHLcnueeLfQDNTEuQ53E+6U3IJEG2VGsyZxlJPw
b4eAVxq1
=iDKD
-----END PGP SIGNATURE-----

--=_MailMate_F5D4F1A1-867E-4A0A-8EA4-C33F07D24F40_=--

