Return-Path: <linux-kernel+bounces-119233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D30A988C5F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208943051DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A26413C680;
	Tue, 26 Mar 2024 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jCYGY4cl"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2118.outbound.protection.outlook.com [40.107.93.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C813C687
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464846; cv=fail; b=jN2dvmWHutDjL6MGE/SfRfFtB6tXQxBFfCSfBinQOwR4ZyAnzLL5amkakm9tMhkTRfo80UM/J+6wxZJctnxU64PQu3Pm05lkmKm2JpZ1CqpUzvFBHOCkA9QSszB7AYs/RP36ttgCMDkM7PXUoFYyRGdYl+9VFwb+3qbBSWbEk14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464846; c=relaxed/simple;
	bh=P/V6pmqufVWfS9uzoVw4aRDkwW7Kwl078IHwSAyxmSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XEfzrZlSvaAUR12oe2r1PQnfjWnQ+rhS6gpVHgzyys9V/nvsU24x17EGURT1VZUWnln6eqEoBUmS3Qrz5QzoMs4uu31tY58Os3tn86rsBDevdJnCvIBqRkEarOfYn0muMtb4kdtw2E6Jp+pvVkke78A7LxJYoAhBL3qDnhRwT74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jCYGY4cl; arc=fail smtp.client-ip=40.107.93.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQuG8B+pvaudQbPr50Led838XuxR0qWdyiHq1QJ0HYYuMDF0D8+Lel3ug55aB1R99eTmFtrgW/xbsUSoxmAtnAsy+TmlNnTnNSnfYuqKno1d3FZ1FNoISLAWesOSy3tTppGpdehOy9u/FG8cE8Y3p5wR0s2i0MZfwp9Rl2Fkcxijff/bs+4FZICBOHI/IDXIehAtCnGiuG+wNvKnwhRF0Z1nx6PLvkJXRB7nJtsNFjAH/sDCE9EYP5KOJTWtCO2brNUPMm7nM7GKl3H+ly+dLcPnKxbn3QsMcv38fZ7/5lo3txqvkE/MsiSiUUTfKesA9cIeT3QKs3Ux9MZXkq10rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnXJx5PDnAQ/gL5KGZE1VZU13+bSrW0ymClAdwVklkY=;
 b=fG7s/iow1aeE7hFIhaHZFm0UipO9kvbqVK/3Te+VXsLzpWYPv8tK7a0YNa958vqNpT2yBOnYixiGXx8dYVc5/BxYzjBy1AWbkYR5n4w0nMjZsePFinzneQRgNzlaFUV110FahBOCEoigJ38SJCTAoopZKf/onsl2nWRyMDHm7or96DEdHMOz/xf8qqSY+jq7ri1J6hkurz7zjy3J+YqnglTRGajDWQvn6pL2i0D0mGKaijlnWXQ3rk46RoPwfkg774mhx1e3epSabFnNRheIX0xedr1HcboiHGeC5Um2CTUE/9ilsGx9nEFYz65jabPdv/BSnkPd9eEKqrju92H6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnXJx5PDnAQ/gL5KGZE1VZU13+bSrW0ymClAdwVklkY=;
 b=jCYGY4clIzHO1FyzomHU6uSI+94s8AXDvE2wAzE88AVyxGHhmeR/pmL72elluz3w7zs3jRgCOpQSLeTn/XxsKjgmvOk1DQat6h2vEy48/CbJ/iw07GDWvwJUZ5qXUBeTadQAe/JNNLXXd6KwMj0ibg1CC3kQDWxH2rxYt/LJMfa5drRB4rZFBC5hrNp9GbwWdKI3EOX70/Es/ldUlgGQ/VHsa9pVG/K9YhZqiBjB8X09CjbrMxxiRMkyikk3eXr9rxNfeYAVTscORLgAtIJQQleLAJjtCWdp7W7gGghr5YaI5QA5JGHnguAguvqB4ahaMRFPYI2VkutDaRu9JiyBLQ==
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 14:53:59 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 14:53:59 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, "Yin, Fengwei" <fengwei.yin@intel.com>,
 SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] mm/migrate: split source folio if it is on deferred
 split list
Date: Tue, 26 Mar 2024 10:53:56 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <6A1CCFDF-CC38-4B29-A514-3D500EA04B16@nvidia.com>
In-Reply-To: <df9a644c-a007-46ac-98e3-61d4014fcfff@linux.alibaba.com>
References: <20240322193304.522496-1-zi.yan@sent.com>
 <1ecde325-097b-49e9-9f1f-d93edbc8e1f1@linux.alibaba.com>
 <8DAC0D9E-9B0D-4035-9211-2190C6F8284A@nvidia.com>
 <df9a644c-a007-46ac-98e3-61d4014fcfff@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A52ACB3A-425E-491A-AD70-D4B583EC8054_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0230.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB8124:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QPwPL26uDZtFEkNeS/l3hau73DQiuvHcM4fH7G9N4paYh7B7ZP41I/I7X0oN+yiD2hVo0UyJqI77zFvH5z4qMHLhpXYbnh648q2MFA+08swoZDy2OswpY5ngbT7uIrajuVArqOZajT0s4OZ8Jv3t8nRMSEB+PoQ8jfN0fncjSrU3or0z5Xa7VSQbiEZbxWnwmhca83r+nFDFGlBq0gdEI9k1IB1VGCT0isug5Yn/rJg9ZKT8ajBLCpSx+Y+Lpeuoc0wr+WCRQamnYSBzSrxNWQrtHxf9uquwvEjTlwAKr5RMK+MV3sgcJMSJBhcgzrCk4iZvH8FeICyDa+ErAATjC5MByHnKzAwxxuQq2yUinJpCeYV92aTCe4mDL5ts9JrMwX9Ez4uVpCYyFKzEuI+d1rVMsCpZZ8kLdIZB/u9Wle53/UFYG3YSN8fxAvc4PeqpUHYlyMZ40LTF87bVmU8qCUQ/FNDS0WVyic5m52xGDaBWCei4Sdumxm/5MBrUARq2dANZHx4q5B0dGKmX1PSJz6O4Dwu6lerVzT8G+bT8e7Ng+DIwDApeDdMR+jBwW6oy9evJXACJniRD1Waa19iREVxg9DV7MSFEI6QUuPI9SF3GQTnm6Ac8sQGrqmzrxIBRx13rCKXM2a8KlFsdSXk1gOhkRecp9G3B+GejPsF6LbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p2JioGjuZesKy/q6g/P09kj26x/Xt0EOUN4OqdGl92MsUhN0BJeGtdUbasc0?=
 =?us-ascii?Q?Jr+Hg43MeodGWh8A+P+d0JEsy6hH8O2BAbf5E03YWNEeXTRz21gG1ZQSWGPT?=
 =?us-ascii?Q?TszGiN+FE+0FiAA2vkhVgbczjs1G7nmDGGTW/m/0Ke4jtAvAfz+H/p15OEDL?=
 =?us-ascii?Q?Mpt7DN1dFUW5eHrazDT886SObP9tZMLv8qe0VDG+H8XaaWYMOFXsJWvkLxxd?=
 =?us-ascii?Q?WdNuZezeDVPtq2m3plzAMCjm/EmcnwZjvU0EEdKOJ+fLrlVdXDTflHZJKxRd?=
 =?us-ascii?Q?YJWxtG2hxLLnt4WH2pmx5JGKQV8zbsqSkdZXTQIDQmvs6H/FhPk+r2XWndWP?=
 =?us-ascii?Q?c2wYxoJnhiWtseyVGy3dPAUCINSQx27+S/QkX8ekL0QhaKUrpYbniQT5HUzt?=
 =?us-ascii?Q?6uULTuPp8sEa9hDzj5mPx3svNUdPmyYcHkajoKSyG1LkpH9zPv5c7KLxRLPM?=
 =?us-ascii?Q?uVLQscOaIRDbIKUc+PHPtIpizS1CRqQDYboIM2GVSGbv9+jtgJ8GzER1gvjN?=
 =?us-ascii?Q?HvPrrHlMCTNkEe0ca7uPL56Gul+GoFAXPevQHCtPpS41ImCrNt+8sXZwGTWf?=
 =?us-ascii?Q?UXniruCX0xDMEiVemI3jvSv7H3PhSEhPmTljWCF6OA+oUrVdfPO0v8kc6Uam?=
 =?us-ascii?Q?5tXPMU1JLouo99HBgHYKpPZwlmFPCLzx64jHeEYTw/DHWSnl4J1PgjktOVft?=
 =?us-ascii?Q?6SavJg3HXsTdgKv3bQ6TUKK9rMOIm3AReEjPkL2yZZfMbym7NPhC8Ig8NIaV?=
 =?us-ascii?Q?gba62nT7Uxd2RkaAMzxpD50IbPBPQDWOEJjzHRXsB+UWvtLhTrPXYihZO11+?=
 =?us-ascii?Q?QIs2DiThCatPt0YRR5laLl94spKKIdS31606yyeo6K2m9VjCGTEdF1U3Noa0?=
 =?us-ascii?Q?eCJOujcdGfjTYN0lMZffjG+F3To9aswFRsLPpwDFtp4hW4NJ+uqphCvMEjWT?=
 =?us-ascii?Q?7D7h36f4oMycH9sFuJLfpcyPQMKDfGTtPnK0RGoxCIofLyKC5BkeJQm9h/Zo?=
 =?us-ascii?Q?A9UR20j1AHQkFPkfpTt3mjZ+JXh4BSzCaeN/2Sio2tURVh8jOiaf2U4TnlhU?=
 =?us-ascii?Q?SKnQePxzWPCeA93OvkOTomTtnyQKtdeXxT2c0RlAlwBB3XH4JEtIU4KxtR5T?=
 =?us-ascii?Q?ADrnueAIgwbk6z0AGbPWG5xAHuOZJ7Vlo/NBgDvWCLhedqpubb+Yp0+86RM3?=
 =?us-ascii?Q?PgNA70LEEde9hdaxPhu1nL3Vgs7ZnxbHes8NouCaKU74qKIfZsZ1MQt6XfLY?=
 =?us-ascii?Q?Aqdsua/1hy/ctmtvARIHn5vmS7Ji74JRDKjwwhDputozz40cETdmzx4eVbW/?=
 =?us-ascii?Q?hU6mo9DNcRMfddA8prFhABGe4kiFDhsSnq21SgsBG1g7PdM+6wyjQYtoWi3d?=
 =?us-ascii?Q?b20RMKZ3R9DOlxHY3DPqJf2pZlE1u1grfYoDKLHnIysA42+w6ghcZ7lLstop?=
 =?us-ascii?Q?80XeRg5MLf+g2IWvnQZLQe6euniqSbYRLEZR6OYEueNUx0XXdomU662J2Gpp?=
 =?us-ascii?Q?cQQKxRx+nCUccQRQPK2pUNMiwVaJlTqtcX1gD7HvqDEwr68pXxehbc7NN2h6?=
 =?us-ascii?Q?+gDjvspRl8yvFf44UJ0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157f8477-24f1-4788-21e2-08dc4da49168
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 14:53:59.0636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eus8FgN6rz/dlwUAxxmgGk2tYun/m6lLziCU//Wnkf4zGcL8wVn8HJthBQkKX/8V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124

--=_MailMate_A52ACB3A-425E-491A-AD70-D4B583EC8054_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Mar 2024, at 10:42, Baolin Wang wrote:

> On 2024/3/26 21:26, Zi Yan wrote:
>> On 26 Mar 2024, at 2:19, Baolin Wang wrote:
>>
>>> On 2024/3/23 03:33, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> If the source folio is on deferred split list, it is likely some sub=
pages
>>>> are not used. Split it before migration to avoid migrating unused su=
bpages.
>>>>
>>>> Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path=
")
>>>> did not check if a THP is on deferred split list before migration, t=
hus,
>>>> the destination THP is never put on deferred split list even if the =
source
>>>> THP might be. The opportunity of reclaiming free pages in a partiall=
y
>>>> mapped THP during deferred list scanning is lost, but no other harmf=
ul
>>>> consequence is present[1].
>>>>
>>>>   From v4:
>>>> 1. Simplify _deferred_list check without locking and do not count as=

>>>>      migration failures. (per Matthew Wilcox)
>>>>
>>>>   From v3:
>>>> 1. Guarded deferred list code behind CONFIG_TRANSPARENT_HUGEPAGE to =
avoid
>>>>      compilation error (per SeongJae Park).
>>>>
>>>>   From v2:
>>>> 1. Split the source folio instead of migrating it (per Matthew Wilco=
x)[2].
>>>>
>>>>   From v1:
>>>> 1. Used dst to get correct deferred split list after migration
>>>>      (per Ryan Roberts).
>>>>
>>>> [1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A9871=
3C817C@nvidia.com/
>>>> [2]: https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infrad=
ead.org/
>>>>
>>>> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path"=
)
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>    mm/migrate.c | 23 +++++++++++++++++++++++
>>>>    1 file changed, 23 insertions(+)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index ab9856f5931b..6bd9319624a3 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1652,6 +1652,29 @@ static int migrate_pages_batch(struct list_he=
ad *from,
>>>>     			cond_resched();
>>>>   +			/*
>>>> +			 * The rare folio on the deferred split list should
>>>> +			 * be split now. It should not count as a failure.
>>>> +			 * Only check it without removing it from the list.
>>>> +			 * Since the folio can be on deferred_split_scan()
>>>> +			 * local list and removing it can cause the local list
>>>> +			 * corruption. Folio split process below can handle it
>>>> +			 * with the help of folio_ref_freeze().
>>>> +			 *
>>>> +			 * nr_pages > 2 is needed to avoid checking order-1
>>>> +			 * page cache folios. They exist, in contrast to
>>>> +			 * non-existent order-1 anonymous folios, and do not
>>>> +			 * use _deferred_list.
>>>> +			 */
>>>> +			if (nr_pages > 2 &&
>>>> +			   !list_empty(&folio->_deferred_list)) {
>>>> +				if (try_split_folio(folio, from) =3D=3D 0) {
>>>
>>> IMO, we should move the split folios into the 'split_folios' list ins=
tead of the 'from' list, otherwise there might be unhandled folios remain=
ing in the from list.
>>
>> Can you elaborate on the actual situation you are thinking about? Than=
ks.
>
> Sure.
>
> Suppose there is only one large folio in the from list that needs to be=
 migrated, and this large folio is in the _deferred_list, which means it =
needs to be split. Your patch will re-add the split base pages back into =
the 'from' list. However, please see the list_for_each_entry_safe macro:
>
> #define list_for_each_entry_safe(pos, n, head, member)			\
> 	for (pos =3D list_first_entry(head, typeof(*pos), member),	\
> 		n =3D list_next_entry(pos, member);			\
> 	     !list_entry_is_head(pos, head, member); 			\
> 	     pos =3D n, n =3D list_next_entry(n, member))
>
> It will terminate the iteration early because the next entry 'n' taken =
out in advance is already the head, leading to the remaining split base p=
ages still in the from list. This can cause the following crash when I di=
d some migration testing:
>
> [  412.576943] ------------[ cut here ]------------
> [  412.576947] kernel BUG at mm/migrate.c:2634!
> [  412.577132] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [  412.577201] CPU: 59 PID: 9581 Comm: numa01 Kdump: loaded Tainted: G =
         E      6.9.0-rc1+ #69
> ........
> [  412.578651] Call Trace:
> [  412.578692]  <TASK>
> [  412.578730]  ? die+0x33/0x90
> [  412.578770]  ? do_trap+0xdf/0x110
> [  412.578815]  ? migrate_misplaced_folio+0x1f2/0x2b0
> [  412.578875]  ? do_error_trap+0x65/0x80
> [  412.578922]  ? migrate_misplaced_folio+0x1f2/0x2b0
> [  412.578977]  ? exc_invalid_op+0x4e/0x70
> [  412.579048]  ? migrate_misplaced_folio+0x1f2/0x2b0
> [  412.579131]  ? asm_exc_invalid_op+0x16/0x20
> [  412.579182]  ? migrate_misplaced_folio+0x1f2/0x2b0
> [  412.579255]  do_numa_page+0x205/0x5b0
> [  412.579305]  __handle_mm_fault+0x2b0/0x6c0
> [  412.579354]  handle_mm_fault+0x105/0x270
> [  412.579404]  do_user_addr_fault+0x214/0x6b0
> [  412.579453]  exc_page_fault+0x64/0x140
> [  412.579509]  asm_exc_page_fault+0x22/0x30
>
> 2583 int migrate_misplaced_folio(struct folio *folio, struct vm_area_st=
ruct *vma,
> 2584                             int node)
> 2585 {
> 		......
>
> 2628         if (nr_succeeded) {
> 2629                 count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeed=
ed);
> 2630                 if (!node_is_toptier(folio_nid(folio)) && node_is_=
toptier(node))
> 2631                         mod_node_page_state(pgdat, PGPROMOTE_SUCCE=
SS,
> 2632                                             nr_succeeded);
> 2633         }
> 2634         BUG_ON(!list_empty(&migratepages));
> 2635         return isolated;
> 2636
> 2637 out:

Got it. Thanks.

>
> After changing as below, the system crash issue is gone.
>
> +++ b/mm/migrate.c
> @@ -1668,7 +1668,7 @@ static int migrate_pages_batch(struct list_head *=
from,
>                          */
>                         if (nr_pages > 2 &&
>                            !list_empty(&folio->_deferred_list)) {
> -                               if (try_split_folio(folio, from) =3D=3D=
 0) {
> +                               if (try_split_folio(folio, split_folios=
) =3D=3D 0) {
>                                         stats->nr_thp_split +=3D is_thp=
;
>                                         stats->nr_split++;
>                                         continue;

Let me resend with this fix.

--
Best Regards,
Yan, Zi

--=_MailMate_A52ACB3A-425E-491A-AD70-D4B583EC8054_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYC4YUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUVyEP/R3cXGdRZ2F/P+DInKj6ZeIsi22HdBt52fBM
D99R0g4DTKt/7zvZFl/gaqX0IUOBu3eoLH5MsLDfjKgxTdfSrPy4dkZg+lsVpKMg
EyZGBGchgOLlWetrauPGypFwHTBizjvMt6q4tXWW71NQGtOhCl32g10ZOCQWARyC
5ZA7kmYoEYCMGFOlL6gL7o7A3qpDyGzg6O3E+BI9Kgq21LEPZjejgk1nNzF5Jef5
5Uh7DMDVMnW0ql6xYz2h2u/bFj7NwMJARostktl9v1/2AC84Z/z6UlfSAfSxvLX+
dIwNRROMcs3a7EKQUMZ8ncJbC6MBPqK10uXnv20QDLq+9OrR0t2FoSI/M2uM/pPj
c25bqwbIzqbzbTs0ChJEK0CL+ycD5gDXwSKTkItNUrNd1571EBK4+tmZ2AJ31Y6w
pWyanFfFj5WPyT++M51rxYqIqHQSo1Zcv09hBqCyppPxzgKcieX/u5JQEDJDVhMU
h89ApHpwix5ebWc/jQxUS85D2FeEAG+2y+FFXs9kINaSFhtHsmzbG7zv6nib3sjE
ROz9TWPWif/0NH4k1PoIVkaRfxtf399jCEBExpxYNX0mTimV7wMnMs4K3xuK1Gy1
3LNbqBpIwtKa1DizMiMIskq4zZkBoMd/VYY6CnCXt9ARNHYtPZOqpbn1J9NhOsDQ
DIqWH0Df
=Vo/E
-----END PGP SIGNATURE-----

--=_MailMate_A52ACB3A-425E-491A-AD70-D4B583EC8054_=--

