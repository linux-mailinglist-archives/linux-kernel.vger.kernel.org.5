Return-Path: <linux-kernel+bounces-108306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686A48808F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E14284A39
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4134E748F;
	Wed, 20 Mar 2024 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bnB0RlUz"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF16FC3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710897404; cv=fail; b=TcnLhC+ixqeSYqoj6OohiP8GXdtgww/Jm19wU3tUNXQ+rD0SYsFGu+9SGlEjA8uKud9pfIAL/Z6wBBsO7txhwhzpujv7EEH1kuq5XWEeWdNolI18Kly40No0cBaGRdG/SS1oYl4C+mMBlCDARWhxtnPaNnrGk7nves12SC99HIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710897404; c=relaxed/simple;
	bh=TWFUW8diczs1Nhq3GFucThfXCuuq4gjIALsxQuSoCEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Co+ztUDHqhAZE+Wj7A+uRIiVqyeN7QSPiL31Bfbxndx1mhk52mNs9es+7u9+/kuZB0D78UolE0hHJo3VBBjgaj7rHX1zDflSOhaaiV+zmGh503R3c6RW36vZWYgaOP/Xa1hfuqjOIpFO6LN8rbpeySK+sGNXbgCPfEt8/hqeYbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bnB0RlUz; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEmnIk1IIF6Dry3x64QGH+MwrVeF2FKLm9Wve4sNGS+VMzGDOuYQqbDfrBmgkupYuUvqYweYg8dqLawt/moJ26Oi692HVlNRvHdBnQfVHtx609eXfddQAnqTwIXgDADqK1mpLXIows6CBd1Tgi5XhUsmdqtQDNSouXAKgW424pJXoexGgw9jpGq+dskTgGZCjNSekrPwmG3KqyNFnk657MmJHKojvbj6Jlj4deSH8y3Lm8e9h8fo1x9gJQ8YuxSsR35IaBoPBIb/E8i3YNNFsfdbIf/nrh2snClI+rTKmnRECyXMuywL3An/x8XMUgV6ca2+u2SHN5FMG9yWCZOimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RqQXcr7gm9oMtFVK0mrZROqZg6PA/m1Y8Fyfi3ys9E=;
 b=fcL9VM8mu/YYyeKJx/GUbHWQU1Il9Fy0L0U8iD4wIQ/qcCsjf+ucX10BWEQd2kRGEodm1zAJjiWd6fweVP0wTq/b5s4ECFesbD63KygCmjwuSMqm0aFePoPjQlCKctpagbmrcWl079gT2m/ZVkncnIzLC/eIlrr4ZT/aZ6G6fstEMN/v3iSbrS8ZP7J1zKYMJ4u+xT/dyZtOQgMNRd+sbsjJJj1LKUPezDdlfwSRNii40iiXfHm7aN1CS7JVILcltAUgecUdN7pj2wNYvcH28Nn1eY9gbGDWIcLCD08CSrICDmkmhCcEkNTsj2KI2EmJX0T2isSeE5HwKzlktvbuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RqQXcr7gm9oMtFVK0mrZROqZg6PA/m1Y8Fyfi3ys9E=;
 b=bnB0RlUzXY1hg2VFDO0EQdWKaV5RAa5x9wQiZPOrSFzrOR6UjTi313frtft66BeYG/7ulBoReslpzsKXFr8fh+GMI1exDt69j0oLYkZ81aResKsJAaXdrlE80cPkkbgeGT8gdSH8cB5JmPxBAy8Wk1k8hxqTdZzWBzuJ8tbVuem15QT2g5rdLqVhtiPIwGKiEZcMhc8UpV5wGcrksv/qi4CUN3W/ZKXN+IvQ76ksWMvp3CWf0gJQwIzZ1UqZGqx8LKJ7XhjCyUh//Ielab08uOioMbEaRZUy3SJQAS7KfHqBv0aPoWFdtT3QWSwB+cTSEe41W5WwiRnHz6iU9IAsxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.26; Wed, 20 Mar 2024 01:16:39 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 01:16:39 +0000
From: Zi Yan <ziy@nvidia.com>
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/migrate: split source folio if it is on deferred
 split list
Date: Tue, 19 Mar 2024 21:16:37 -0400
X-Mailer: MailMate (1.14r6018)
Message-ID: <28D1C313-8333-4F87-9B1D-47E77789A853@nvidia.com>
In-Reply-To: <DEB67249-569C-4585-BB67-B4EBEE91152E@nvidia.com>
References: <20240320010813.136765-1-sj@kernel.org>
 <DEB67249-569C-4585-BB67-B4EBEE91152E@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_5F149087-FF09-450A-A387-C3F289CBE53D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:208:fc::23) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: d97ae18e-d324-450b-864a-08dc487b64fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	abnX+8B38aJSCGj3lIg/D1VUE7AcmpHxab8ctx64NI93FT5oWUJvxpwBKT0z5CrEgy4N/0N417PUdKuQuhxlIgUf8zxB0vCk8Dghcuse+yBTs9cGCAObnmK5A/pnSCl91LZiSRBT7N/cTHwirqLAO7nqmmEJADEB81Ym+VJzD0/DnqLFM+nWhb8FBMAd0tdx4JZImY7uTLFREqdvMg97MIHzXoOuaAUSmUPq6zZKe2dPJiVrVHuuTQM6ESEbF7fb9V/6X0vil3fjoRM5Nm235sICCw2FMBnvFqC9I37/v1TWapYXFFN7pw+snt9yethF+AudYOxkX0XWcHxWlek2nmdxEeE8vDVYWYo7tgP0rMgLxJAc7tZfVIx22j3wMgetaZEdfsjNb3kvcGskeQcN36Msfw6HUzcpTr/t/Pu2sIL5zl6TBsVt3lXR9W0HPuKjs+DbjPrXXu7NcOMv2MNb00T7hmb3wHZB7rlAHqlgQors9f/yKriH1DmCVaOpCI3n5r2owfztIQHegR5O235khNMDX7CG6bpaHiwuIxMl+FekCETZVotbQhpWi+N0H5TobOdqP2CcvRKGp31gI4CIjDnQHtswkOq8uck498JCo8Ui4fVz+AQ1JZbg2AvNLGGOTCmmzbrqxDk27trEQZMQ/sAQl3JO3TSA6HGnZ4kfNW8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KwzRHYoxVFVTSCtudutyBf1dV64c6YCFIn5Byzqet01b8H56ysgRzLJPI7Hh?=
 =?us-ascii?Q?Ao/WL62gVs6MtlljG6XYl+/DmgXQwR4gI9+stJijGtfzG7kGhllSqgbPV6H5?=
 =?us-ascii?Q?jIEB4Vi0OX0ezgG1NaAK+sy5DFEhmTbh323LdbIsz+jaFm+NYy0ChoNze17j?=
 =?us-ascii?Q?WEIsd9DH+invEBJUN4DcCO1Gis/HhMFP6/lQEoerY+gmhkQVcZ5E0YRhGqdW?=
 =?us-ascii?Q?ns4sgY4AkTHhkwobf+0D6+9bC93g57HfTcMIkutf9AmLdgWBugUx/sW/JKMQ?=
 =?us-ascii?Q?yxRs2iwyWv/6cFIuHIgocjMWC3+WemOoqm1f9q1d1kheY32XeXZNOy7vg054?=
 =?us-ascii?Q?p1A+MNdipvtvEyo4pgjx9CoV2NbNkc8pyb5SmiXCLmcCEblbAQWl6dqEZJfK?=
 =?us-ascii?Q?sGTKRxWT/5rUzxSo++MIDXDtJAAIs3ND/WixIeNHizzCWN8c94TB+n6IN8sJ?=
 =?us-ascii?Q?oZzEZ5/3iMB3Nr11PWzMnei3gjSuIN3rTdMLRFExCBPAsQ8oQWcfYYxa9Azl?=
 =?us-ascii?Q?rGjQnm28TLOWWEuR5zH/25bWkLSri4c5MyUZpQ8nPm4Y7XSmamlGwToLCuEQ?=
 =?us-ascii?Q?7Az1oAWQ080YngCIMhvZ1hKErr0yIWibmJvNLhwhIH/45OVKl2mwQj6xB59m?=
 =?us-ascii?Q?5c9yTR5VbLehP2vfF5a/XFIruUxLe4QKahyQSdc1G8olQ+jH36nIxTDQV8x/?=
 =?us-ascii?Q?yLcrVQHaJuHvp9Ojr/B5h0t8s34k7GX3K4Czkqqc427kYCWyYXc/4Gs7nSzW?=
 =?us-ascii?Q?4PICr5BuJM6Hij/Mh+ugGfxheMffJy/vTrxa7G2aj52qYu2hqFjmiAhrzhq6?=
 =?us-ascii?Q?vYPDq1QshdiOvy9B6bd+YYgaGl++RSbImhwvMwk9nvANygax1GZflSkG9k5w?=
 =?us-ascii?Q?P288hKI4e4zDqQlQlum+HqB35/k0xo8ShvYFz4Hm7QiaMTxS3rC2IKJgXAt4?=
 =?us-ascii?Q?NG4v5WM6QHSQVNVO1ZwLBT4Wyu/izNKJnqu7exUdHJS4awsP1KHeGAl/9cVT?=
 =?us-ascii?Q?hQMA93sH5M0T7fsXCWaR6h0tm3b7cjIqbQ4QTFeWkJznTwtqqkUpiKpr82c3?=
 =?us-ascii?Q?Drv1OPxn1lbGeWmygbGPS3QnRa8OVNcqlrp31yW4kw2i13VFqeSI5z6C+OVV?=
 =?us-ascii?Q?r3FtysAbMNPAJEals27NZ4HXOScR9Ku8HWduOy+T7RydRmJPmyObyVVMsxt+?=
 =?us-ascii?Q?HKWCDGo8n1ezG+gWz2nap7X01e6rS+mc1MmfxWsH79TvAk0s+09PTPMaVnBZ?=
 =?us-ascii?Q?bA1QSazWo9+g0w8xMWtkezYHy5qjEpIQgJgt/Vi0W+sNga8Dv7mg8rb3+RvV?=
 =?us-ascii?Q?VN/ibJwD9eZQMx/Xo9aGTb1llfF7j1bd0vqN3qE+NRCBuP5YWYA68mRxFO+h?=
 =?us-ascii?Q?jj3gjzMNJpmEl5+UyP2nWLS9mMBmgYr1yLwwp0WTcM93cPts5vpciDC+aJre?=
 =?us-ascii?Q?BHLqOzPD9kuNNfLtbcDSKFHHWxmqvEHzimEHep8SE0kFV7i+R2sewwRxCF1X?=
 =?us-ascii?Q?o6zmU2AkEvo5SCY0xPameAAVEgt5HOPWqoO5nXbqZspUfyevWihj9ugPx+Kd?=
 =?us-ascii?Q?r/wOyf3I3/nQ7WQx3gc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97ae18e-d324-450b-864a-08dc487b64fc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 01:16:39.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GL1NahkqsGOPLo3xqCJ3d9oEI+342btx3Y/r1tlWIKYTDQvy9EfpX+CylwmUFq4S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012

--=_MailMate_5F149087-FF09-450A-A387-C3F289CBE53D_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 Mar 2024, at 21:09, Zi Yan wrote:

> On 19 Mar 2024, at 21:08, SeongJae Park wrote:
>
>> Hello,
>>
>> On Tue, 19 Mar 2024 11:47:53 -0400 Zi Yan <zi.yan@sent.com> wrote:
>>
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> If the source folio is on deferred split list, it is likely some subp=
ages
>>> are not used. Split it before migration to avoid migrating unused sub=
pages.
>>>
>>> Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path"=
)
>>> did not check if a THP is on deferred split list before migration, th=
us,
>>> the destination THP is never put on deferred split list even if the s=
ource
>>> THP might be. The opportunity of reclaiming free pages in a partially=

>>> mapped THP during deferred list scanning is lost, but no other harmfu=
l
>>> consequence is present[1].
>>>
>>> From v2:
>>> 1. Split the source folio instead of migrating it (per Matthew Wilcox=
)[2].
>>>
>>> From v1:
>>> 1. Used dst to get correct deferred split list after migration
>>>    (per Ryan Roberts).
>>>
>>> [1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713=
C817C@nvidia.com/
>>> [2]: https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infrade=
ad.org/
>>>
>>> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")=

>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  mm/huge_memory.c | 22 ------------------
>>>  mm/internal.h    | 23 +++++++++++++++++++
>>>  mm/migrate.c     | 60 +++++++++++++++++++++++++++++++++++++++-------=
--
>>>  3 files changed, 72 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 9859aa4f7553..c6d4d0cdf4b3 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -766,28 +766,6 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_are=
a_struct *vma)
>>>  	return pmd;
>>>  }
>>>
>>> -#ifdef CONFIG_MEMCG
>>> -static inline
>>> -struct deferred_split *get_deferred_split_queue(struct folio *folio)=

>>> -{
>>> -	struct mem_cgroup *memcg =3D folio_memcg(folio);
>>> -	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>>> -
>>> -	if (memcg)
>>> -		return &memcg->deferred_split_queue;
>>> -	else
>>> -		return &pgdat->deferred_split_queue;
>>> -}
>>> -#else
>>> -static inline
>>> -struct deferred_split *get_deferred_split_queue(struct folio *folio)=

>>> -{
>>> -	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>>> -
>>> -	return &pgdat->deferred_split_queue;
>>> -}
>>> -#endif
>>> -
>>>  void folio_prep_large_rmappable(struct folio *folio)
>>>  {
>>>  	if (!folio || !folio_test_large(folio))
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index d1c69119b24f..8fa36e84463a 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -1107,6 +1107,29 @@ struct page *follow_trans_huge_pmd(struct vm_a=
rea_struct *vma,
>>>  				   unsigned long addr, pmd_t *pmd,
>>>  				   unsigned int flags);
>>>
>>> +#ifdef CONFIG_MEMCG
>>> +static inline
>>> +struct deferred_split *get_deferred_split_queue(struct folio *folio)=

>>> +{
>>> +	struct mem_cgroup *memcg =3D folio_memcg(folio);
>>> +	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>>> +
>>> +	if (memcg)
>>> +		return &memcg->deferred_split_queue;
>>> +	else
>>> +		return &pgdat->deferred_split_queue;
>>> +}
>>> +#else
>>> +static inline
>>> +struct deferred_split *get_deferred_split_queue(struct folio *folio)=

>>> +{
>>> +	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>>> +
>>> +	return &pgdat->deferred_split_queue;
>>> +}
>>> +#endif
>>
>> I found this breaks the build when CONFIG_TRANSPARENT_HUGEPAGE is not =
set, with
>> below error:
>>
>>     .../lib/../mm/internal.h: In function 'get_deferred_split_queue':
>>     .../lib/../mm/internal.h:1127:22: error: 'struct pglist_data' has =
no member named 'deferred_split_queue'
>>      1127 |         return &pgdat->deferred_split_queue;
>>           |                      ^~
>>
>> Since the code was in hugepage.c, maybe the above chunk need to be wra=
pped by
>> #ifdef CONFIG_TRANSPARENT_HUGEPAGE?  I confirmed below change is fixin=
g the
>> build on my setup.
>
> Thanks. Will fix it in the next version.

Actually, since get_deferred_split_queue() is used in mm/migrate.c, that
part needs to be guarded by CONFIG_TRANSPARENT_HUGEPAGE as well.

--
Best Regards,
Yan, Zi

--=_MailMate_5F149087-FF09-450A-A387-C3F289CBE53D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmX6OPUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUUz8P/A787ligPSqkoyfUMfslw4VA9IlLL6OfHcbP
hvgOiw/9WBKascd1+2LavTn5Qhxxl4taXPdcWHwdDH9h4WoHi+sNhTulafT8kgE0
iJW8PuPPUYNQMee0z3YRGmokVBKS2dlujwQmkspxPhF2dv1L/v0wcxErw9XAy3Ji
EzDWNymgvKCrn2jlGbSklQp8zOdedXozbq/n3lL58f2q3eKKkPk84QBi5kiQcn2g
Tah76VFpg2O7JtXqaA0lJt1qAPx9ivOit2Zigofuztm9uurg31LACQZCZxWB6NI5
dnlshUhc49/8dw0H3xPipLaxBXUh0x6ck0Qtqh3DGdD6fwpKsXAB74oDk1ot0/X+
0KNml1+XQCfnEJ3vKBPdFS9ffWMnIpj2RGG900/JqhaSsPdPlFa5djwtt6hS2ln/
tXgE8IGnd8sN3tCXayDMyd/Df8BqdZskDMtvldZEfYvXr8yXzzT55W8rZkXBXaQq
9UlHXqImfucwmiv/BHHERxdxb36w8V9iP+SRidnYhGPVLGDmhygUeCxgXcHg91pQ
BQfapIH3kEyzOiXR4/Ls7AWXG868emzfYYsbAIeoICNIj/uNE/1hD0mF+rU+RpVl
S97Ys98gNm7AE0cdtcu2eyd2oiC9z7MT+BlAdmHc9AzZmAJfw8yIoTbAkVKn0Bg6
ht2fejL/
=99xy
-----END PGP SIGNATURE-----

--=_MailMate_5F149087-FF09-450A-A387-C3F289CBE53D_=--

