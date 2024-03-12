Return-Path: <linux-kernel+bounces-100332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 241C88795CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24BF1F2318F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CF67B3DC;
	Tue, 12 Mar 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QP5+7Lhe"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5A7B3C5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252810; cv=fail; b=iux/vQHu8+KwMV5FXgmclvP6kassVeeX5mBIvov4nHUfwGM6JdAlH2zoiL1/nAUujNPLTR0nX3btUWTIZz22F7ejrTsgFji+zQXdgSLq+1UxeOM4NOWesLtqDxXUZTPAN2WEJiItPbvnACsIhJjugh+7xhIlcbHOOrC4KEVUXEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252810; c=relaxed/simple;
	bh=ioK5GIeHibAe/HqKu5BOs9MJDZDh01ZMmMfTbU9TVso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rpK1avGC0q0SYycxAHdbx9xQfgl5dBvrILCw3pN0v710NlchgrzJ1siIXjRKangUQpkhL2U4ZsQ7NtlIZ6HpB7bPz6BZi7ZV0Zi9jyKTplojfosYl6YuyV7vpLj/u7H7P2Dztr8ieERGptGY45Iim0EckN5Pry0HzkuxUvjb7t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QP5+7Lhe; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7rLsYEsR8QqHkBtO2hpBUVV9Oa3y0wXGdTwnd3y3JGf5DxZ6bhI2PI/q6c20f04Ts1f+CmK2D/m1A6pnDBZ3IfIzezm3/aTU8vc/zSXBjKuLfbnIMRvX9QJuVkcXX9sgN1d9Xw+H+sMamwCoauuBm4VN65+cZn9DQ679HGSDB1M8yk3Jr0EPSXO7OCY5qRZs+d3ZHsqSMnaTc52FLf7803+sThTUm24qwA8nuypXaQv8PCYiRa3CNR20w92dxuK+KfhuKgPhSNT7kutIe9f2JLlgYJc9dc4edOU5KyZqdJtXbFnZh38oYoXv8r0+ypqeDLv3EyM5j4oN6dJuHLOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3qD1jATwEEUJrUW8OEyIuirMNgzyG8QdsAEceG7S4Q=;
 b=KtQdaaZWfC2DLTl3w9W5f11UEx51hOlreuoukjzoZHHyhAWzbDrhrSYZie41YDuSPtwXKzHaw/62gxo+1z20nqAZxmrUllGUqbMMY3VhE9/+mkRrxCsxN+W86YDJqp8ocvjwP8pSdBYoavJAcaCVYdION3pXIeHpSqzGVs2OXlo0mpEePCfu566v/D58oOY6YIOxYiLiMEVzvaqhYJwuzicvO+5iwU7as5nljwgZHrtBNlUjUt6H1zB16KQV5+ENxYwbRbsWABVcoawlJFOQ3DAt0qo/Plvh5+ERukEzly5s7jv6U3L6eDkANiTt5V16bycTKMoarLbCM/3OBwADRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3qD1jATwEEUJrUW8OEyIuirMNgzyG8QdsAEceG7S4Q=;
 b=QP5+7LheE8qUMpF6fV2EtSZKDJ5/g8rUoGUIoyFI3/xmsji1rHYCgvd19RvUNEMHIVng1iLv5+hXnJQXXE/6agIRXbVOugZ4/ovw/kUs3CZPbbYl/ZTKSLZ+b9b30hUmFKdXFuRZv9lap9GzO4rzgabXHNoBhuaOyZOnMh0v4OoWgmn02nYN9qIZkLMK7DVQ2t0txNt8lG5mz+o0+mjJSgJAW93vYoe1xLgD/fwn3CTo1PN2CigJenO0DzMx8z0r9N3pbKUcYAPagli9rHPdvnqoK/AIcwp7jLoFhbykW+i9GgMpEg94hckrKOv4PSXf6WzWwl1rZUGjeB71TV3BQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 14:13:23 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 14:13:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: put dest folio on deferred split list if
 source was there.
Date: Tue, 12 Mar 2024 10:13:16 -0400
X-Mailer: MailMate (1.14r6018)
Message-ID: <74AF044A-A14A-4C66-A019-70F8F138A9AB@nvidia.com>
In-Reply-To: <Ze_P6xagdTbcu1Kz@casper.infradead.org>
References: <20240311195848.135067-1-zi.yan@sent.com>
 <Ze_P6xagdTbcu1Kz@casper.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_ACE1246F-14C0-436D-8621-9A3AC4016D27_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0021.prod.exchangelabs.com (2603:10b6:208:10c::34)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: be1aa8d1-8554-472b-4f06-08dc429e93e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	atOY47oGfYPVWfDC68YiJMqWoG1/+jxKQSApSP+WP/5xFa9neGG7znDav+5V8bYVIBh8+ET5haFCFxiMg4OWrU620RoJMyNrjm9fAEJ53hsjrUL3jtHmIzDnUib3X3NbbgF2RSbFRvstXRZ4XkCF9TcQgqdcY+0obJHea/eyNlW3iQ/xsGY0aIAv4xFZsQ8MNlYKVn9NEsPhliksGRvvz9tmHXAWgoV8VweVpgFGh72StPRHQ7NhZPfCOaBX90n5yKya2gVqEs4/174Okjn2z7qxyqLY3hZP5pZ7V/AsBA5AzPDKeXlU1dvwvr5ehwDcg5mM7TCU5ElXLSNv0Bjp+euQSiyJiHCcANkEEloq6ag6DE+nAkmzp05MWOX3+72cDsVMrVVUJOtokXnRglS8AQ0wF0H7kIxm1magOPLjsUNCDryEjOxuO9UJLB9RZ9DHKP//86DB40FArchPKoEcW7CInMmPjGRy0xdhqCsman4flUziY2IeuWFkaaVWZZOa+toC5MB+p54+iIJtDazttFr6R2gt7kMJKv3bOTbWz2aOlLja9/Yz3pWcPOFXZvpUWPsSg7JUWBQASD3GLm/b8hvlnKHcyeM1EcCK8+nnF45L+hZhV8vl343ftiPEiTiA6fGHn1l69jeMqFbXJxWTbCm5WbpLeoiO9NviyieCfcU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YG+VOV5YiRnYoOIvR2yLyMklFoO4fqrdzol3vPpS6+cUZjGlqKxYIEB1yGQn?=
 =?us-ascii?Q?gIaKoOA6TTiK631+jlmUulND/XfUaOfyuvwckfKCqyVkeB9ol58Lms3yQyXM?=
 =?us-ascii?Q?DL1vPWXIuTF9jLXtQTWsTMi8RCQAQI9TPWJALNwq34rLsEutJULnjr8xWsZI?=
 =?us-ascii?Q?+WNB5wAuBgIhUNZ49D1Vz8dKB/ybmY1Cg3XkbNclml+mWglCXjI2AcmNzDcC?=
 =?us-ascii?Q?iVvUVuafJRcR2qM57ny8RLOxh5sbmkYvmAqC17PhLNXh86wOnXLYXoqFOJN0?=
 =?us-ascii?Q?2vfdXjAZZKMdKgOj5f2LBreQBCjSRSSJcve7eGTq2AW2GYgIEIRoqQH1g/PU?=
 =?us-ascii?Q?Jn9JTt59mfT3V7VlNKxyIiNf2eQid3IrqcV6tgHZ6+eqYRlPiE/0rGxEvITK?=
 =?us-ascii?Q?ryq9WG6nVkIq1BNJ99BJaYlXDtjSsZUJUBwyd6NbHtExkWjWMfy/bkjDjMvY?=
 =?us-ascii?Q?73bkiETcBeReROIKk7nqOI37itHnQ6z1lF/tBt9/vgNd9C++V03F1qUvRMz/?=
 =?us-ascii?Q?6Hn1TNx4Y8FBYPHcNJaHzvZdpTBob0emS3pTKz81zRZDOn26ZkUJ40CdYFjH?=
 =?us-ascii?Q?4JWGMgJNlYZMSR0MSTkPTaNHyj+gVAJxOQr9V10X4ri1M/xp2k1n980PHt38?=
 =?us-ascii?Q?jVF3x6EDd6DvBcaUIAbqbARKmjkNWMsLeyrBruDs0YBWTXgRIh6Ju9wrPw+z?=
 =?us-ascii?Q?RbrD7/DgU07F0eTxWomkYiyrIg4zLoVcWruSr1kajZCTC6m/qj01d5D1yXCm?=
 =?us-ascii?Q?smIk4aLyre87O1brEQQx1avv7F0ulffZ47jgqZqIWupvH40v3TpnWYyfQ+rP?=
 =?us-ascii?Q?qXnE41/yHWGFtFdl+hGdbYnFwME9LHzh1kZjO5eb7SK1g2/NMQ3+ISBWJZLv?=
 =?us-ascii?Q?aeN60w6wXDrtsPP8jW2zVbSk9ovw5qKyQkjwXwcnJH7dcj10qQRZM4qVYqas?=
 =?us-ascii?Q?KGpHZG2HHhqg39PQ99JORe3tcCdVOLhVXuElJigRyZSFQcT9Jc4KF63qraLQ?=
 =?us-ascii?Q?DmcawdqCk6Yi83yctEuFg6/6tBOm4BjmGhJuZxGfL/icZ01D068ttsTsj9jb?=
 =?us-ascii?Q?/cd+lC1tVxi12HOwPEdUAZ/vQpIfICyki9IgcYU6cNRpi0ncuByPbw1p5NsB?=
 =?us-ascii?Q?YQfvXrkP4H0r7eRJZ1C5+Afxl+LASwJEvbMS6kzXmURZJgFBZpB3X1/B7K6+?=
 =?us-ascii?Q?7Tb7tj14muISoQg9QinIMpTvWWUsSsb6qSHjj/tv8J3xC/hUERIx4UwD8ojq?=
 =?us-ascii?Q?d/L8jAaErSVjYSATUUF6c+tszBYGY+E9Id/HhNv/X7DCS1Wog5xy23AZkplc?=
 =?us-ascii?Q?XvYaX3TXnhH43Pa4DUKSHho1JI64yX1sd317d+PzqI2l5fnwLX1wjrwCOe42?=
 =?us-ascii?Q?Onhm58J/6GVduZNG0xW8nPHd9ZIF8bFcIq7cntRMW6kQffCDomqTHgSEVqBi?=
 =?us-ascii?Q?NNXeo8CUyij5IrJqnjP/IZB9wVIj2jGhhsal3fzyThkvQiWjpvegyi6blD3y?=
 =?us-ascii?Q?X5t6RFLeMetPnQoSn3kdgIfi+Xb7SZJTzhRl3baIF+ZCevGtiMbEL48vV206?=
 =?us-ascii?Q?/3l0IWR0rEKjef4kLtzM59oW0r/pLlSG1MXulZQV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1aa8d1-8554-472b-4f06-08dc429e93e1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 14:13:23.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDnnRPSkHHqeV5A34VDO8AiKJzKgoKEz4VZHW6wHc7CjVyYC/sjpuG4MiZ8f9yEe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822

--=_MailMate_ACE1246F-14C0-436D-8621-9A3AC4016D27_=
Content-Type: text/plain

On 11 Mar 2024, at 23:45, Matthew Wilcox wrote:

> On Mon, Mar 11, 2024 at 03:58:48PM -0400, Zi Yan wrote:
>> @@ -1168,6 +1172,17 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>  		folio_lock(src);
>>  	}
>>  	locked = true;
>> +	if (folio_test_large_rmappable(src) &&
>> +		!list_empty(&src->_deferred_list)) {
>> +		struct deferred_split *ds_queue = get_deferred_split_queue(src);
>> +
>> +		spin_lock(&ds_queue->split_queue_lock);
>> +		ds_queue->split_queue_len--;
>> +		list_del_init(&src->_deferred_list);
>> +		spin_unlock(&ds_queue->split_queue_lock);
>> +		old_page_state |= PAGE_WAS_ON_DEFERRED_LIST;
>> +	}
>
> I have a few problems with this ...
>
> Trivial: your whitespace is utterly broken.  You can't use a single tab
> for both indicating control flow change and for line-too-long.

Got it. Will not do this any more.

>
> Slightly more important: You're checking list_empty outside the lock
> (which is fine in order to avoid unnecessarily acquiring the lock),
> but you need to re-check it inside the lock in case of a race.  And you
> didn't mark it as data_race(), so KMSAN will whinge.

Got it and will check data_race() related changes. Will fix.

>
> Much more important: You're doing this with a positive refcount, which
> breaks the (undocumented) logic in deferred_split_scan() that a folio
> with a positive refcount will not be removed from the list.

What is the issue here? I thought as long as the split_queue_lock is held,
it should be OK to manipulate the list.

>
> Maximally important: Wer shouldn't be doing any of this!  This folio is
> on the deferred split list.  We shouldn't be migrating it as a single
> entity; we should be splitting it now that we're in a context where we
> can do the right thing and split it.  Documentation/mm/transhuge.rst
> is clear that we don't split it straight away due to locking context.
> Splitting it on migration is clearly the right thing to do.
>
> If splitting fails, we should just fail the migration; splitting fails
> due to excess references, and if the source folio has excess references,
> then migration would fail too.

You are suggesting:
1. checking if the folio is on deferred split list or not
2. if yes, split the folio
3. if split fails, fail the migration as well.

It sounds reasonable to me. The split folios should be migrated since
the before-split folio wants to be migrated. This split is not because
no new page cannot be allocated, thus the split folios should go
into ret_folios list instead of split_folios list.

Thank you for the comments.




--
Best Regards,
Yan, Zi

--=_MailMate_ACE1246F-14C0-436D-8621-9A3AC4016D27_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXwYv0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUKroP/2tzxVy73eTVTV6UNYmhwuKuKIVaBTd8O9GR
IGHlh/V9FoehZ6EUZYs/W6CXCFASkW1TfDmjHawH49nXjU50cW9n28FvkFIE76KJ
auP9SHEe7hhwgb405uMM85961LLeYLpsBE2mlFM39OT5FAnqqnsgOJwGBo2i2WOq
QMRz4t1sihKSJ0h92m6t7BIG9AgfQeJXLCOAUkd7i342DILhTgSwbDNhZQZWPVUd
sOiHPgCk5AKfYc+LLRDrATazuNU+Xzg4aCTZOzr85AYBrOgjy6f9o6D+c4y1kGbl
3JscNynKME6lRgTEaEloqJvOxoGai3hLUTe8k9tuax9PF5LAha5ufhyZWjYcqf8J
pndT2iP6rqRmmaYqTp2vq/xHCoF8VtxwTFRjl5bOordbZZPqb6fhZipNDNb2HnT3
iWVbL4MgbRnFTS2gg0uBX3QTbwb3zTF+o6DKvo0Cjh+9AYwOyparNIXewYLvGWxK
m8YKqFgya3hh6Dxi9K0Rt/Hs3UKbHtM4PVKdM3ur50YYCUBY6P88dSkMUbCWzv0F
vHklxexkbFHS2hOPzi+bf+Xn2ft5MXZ8eytR5+SJP/7s6uWYa7SjVz2oDQikE5FF
L5OdIJd6SazESyDRDSMKxpYKn9UZVrGSvaRGdkAASiAW+NIATMH4Khyatc6bpiWP
GSR9LS9T
=VQMN
-----END PGP SIGNATURE-----

--=_MailMate_ACE1246F-14C0-436D-8621-9A3AC4016D27_=--

