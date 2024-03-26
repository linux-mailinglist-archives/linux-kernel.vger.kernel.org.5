Return-Path: <linux-kernel+bounces-119056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A8888C35A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B9F1C272BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80317442B;
	Tue, 26 Mar 2024 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QAElV2da"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2976042
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459617; cv=fail; b=DksgxgnL5HswBT6Ga+9tkUKPRlx1lxGCIMCP/Bzwxov1NUB3K/C76+SAxCMziXTegumrUsvO4KacS8eYPbyUaHAG/gCzKjkJRApTF+rlJ2wFnYC0uXGr1kPKhcEZuJ51/UXAl9TGuTPpcrY1WcOopuKpK5Y+xoqSaUxBC/YLUR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459617; c=relaxed/simple;
	bh=trPPXEwbUyRR16IqkeB+puTtyhhoyemWckUnQyKaZm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NDKZrfve3wD4FhhaOsj+MpW0U2CwVGZ7ON0Kg76z/RMPlYECLkLq/POPVKkqTTIz9fxJeedhi3DYBAL8eipbxR76TBiLfXR9QB8zQh4GWaINdn3l+1938MrEhpRydX63EN0gxbn7xTCAbb1Yr2Tsu5t50XOqPyqCyCEQNrgnQJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QAElV2da; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9005o6Xx6tYne4/P7r6E06j5tL3cBp4PSefcBuZr2fbLeovVRy3Bpp31U13YO73QIiNidpud695MGAsBvvhPWafcfX0q+Mwcg1qkGXWmdELesdzGDTrQJC6B2ge1C2PdtEUHlp/SpIk9WIgRNA4FXJDI2Phr0fr81yw4+uyNeua9bLAJ9uSHje3D2e48fm2Aw2xVHAC9a6frJtlP1kyuCYBHDnFbAdia9VIWNtT3YH0GQOD52vmusCp3kz+9BjHU2OI+7si4sfkJKs1kg3xZSWxmqRyvEsgKtgux2Q3O3LzwiDo20za58aacl9wRhr/x3Sgwwe9lOouZybMSkLR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXZXNIg5JNGROEpQz1OnzzyaB1rDjbVVwTen0PEBDPs=;
 b=GD/AReYmmkvoGUyfnmytdosatxntRIgRwHg/Ov27h5PcD9J/rmF8/gS2Qmndl6fe35Jn4HK3d7sgKGvR4drvr260EdHMrzVcrLjcedcJ5CWsnJDV/b7LvLhFg0NFGB8DzTIgs0VcwV87TqFrSF+49g/NLF1lACZAowJ+3NG/qo1TmBCbGP3aACcrhFwqei5YcywEmzwckYHyLPND6JGUblp00ylpN3j42EAoIhSRf5yciXQ+bEnhbDeZ8t2wQ7JFmOOP0UMEeTknUFbwY7Vwsf4bZa/udIYZA4q94WTr46iqKstC0+FgJ94Yjl/5Ipei5n1pAnjwR2RvmacIU7B0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXZXNIg5JNGROEpQz1OnzzyaB1rDjbVVwTen0PEBDPs=;
 b=QAElV2daTQZl/6dgwb85vqenRlsgPpfxQpy7NtkBHobvSrIJdCIU+ezqkSLOBfww1Rgy9nAEmtBUww04fINeOgtKf5zEalj7lQnbCJfA/wr4hj8xIsfg+psnatGozcilv7D6xMex0oXHNamHrJBGYrGy/QXQf33dyqfoL7UiHitwfjqEfMqLWlWLwBSvsr1ogzIws8/c48uStHxfMWaAhiTfdLpoOZAGatNiQsJ9bPQHtMbKfr+8mJ+ITDhs5yNSNH9QRtbNArhG7ZUNQIHE8+FbbAaeIDB5rngAPN2Xo21kHNmDpH2CReYLzHygCTy9w0nNIPL8MpmDVvsZnVLFDg==
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Tue, 26 Mar 2024 13:26:52 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 13:26:51 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Yang Shi <shy828301@gmail.com>,
 Huang Ying <ying.huang@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, "Yin, Fengwei" <fengwei.yin@intel.com>,
 SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] mm/migrate: split source folio if it is on deferred
 split list
Date: Tue, 26 Mar 2024 09:26:48 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <8DAC0D9E-9B0D-4035-9211-2190C6F8284A@nvidia.com>
In-Reply-To: <1ecde325-097b-49e9-9f1f-d93edbc8e1f1@linux.alibaba.com>
References: <20240322193304.522496-1-zi.yan@sent.com>
 <1ecde325-097b-49e9-9f1f-d93edbc8e1f1@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_54F2C5A4-AEB9-4FD5-BAAD-4A2952FC9984_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:208:36e::29) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA3PR12MB8762:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dPNKNkhFjMsWlG/W0Lvw+vSHrIX8LaOcighFHMXqSF/3ELhY7UqVPcCe9c2l9HeKGtyzo/v5wJJHqPZbeh5z/naRAzj/8NuU8fEHE4QlHBAnXZW7rZtU5P6GI+pvTMD7zFePmdzySuJKqBsVXG7Hgln6MVyqkU/eVkPU7xNb/tDN1i11VwySnF0W3BxSLqIlAd3JMLaMKL5X8HgfuOWCkR1QkgY800y8IESJ1uBiAw2hjHMe2EHteMBHtCaLaTn8b3zgZim4LCXfiQKTY/M8A40bUO7ncqtzD1s3Zl4zdwwDW4/RXkXGxBVBSXwys1Snq2bk5leJ/lHjEJ+PqKd5H4EBEdz1uHAD++wCET2dn9tO9FF4qpCutwr90B86g2/gqJ64Kl5Nu0bDW1xgFEfsU6hzaJ/8k9neLF2YErcbAgjeUVWGl3+1vPQAObLzyCwzXyk5KkwWIbhbthNZ3agHoLUrNKPx5fVlbFEz+0jspxCdjr4W8sTbEJO7c92SHilA4elr303Va56I01GJnbSRjcFfSQUKBHCeDU9r29w7aR7/h8z1TW7ZISrv/avJdoY551/PDLU3Dzgm9OPrOW0I5809RxXeK0VhiEoIOLvOeGlWXrOZzrZDRJzktUg1OtyWOXmV61gHpnIJGIWBa8MMtRauyHRKl5R0yracDCHylmI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9geflqw4AmDmz2eYehGI+13Ew7+7fBr7GTlRao1xyK5PEg14i2f5kGwHcfbo?=
 =?us-ascii?Q?jbrmBqwazvxS5ELW6uBD/eszYFC5rj0mOEafRRm1xSEdytlL8eCAvMqh5jQG?=
 =?us-ascii?Q?M1JAMo65aK2g27YyesuNhlIT+7P8o0HJfhQVLHj+hEd2euCJ9u2BrDgTZ9K7?=
 =?us-ascii?Q?86MszaMd84eCFo8w8kM8XotaYdo+A4aGrFyC16lsO0romrqzKqsHGLiFswPO?=
 =?us-ascii?Q?p7bA9DUEpFYSGT9uVcFrHqwf6r9ltN73uedHvUXt+8VD5fcXW9DBryS0ITJk?=
 =?us-ascii?Q?0GvhjeyD6ucj3HsALCZFc9d+p9r2qB1wZJdPxdnnkmdmASQraxySqXcTQi97?=
 =?us-ascii?Q?3j8plkSQnxAILSsPZeuwL/SuIowNrjxp3ss9wFs3gZf5+1/Yd2LelpMagDlf?=
 =?us-ascii?Q?8Ul5PhGEp08HzAxxC8EJ7LR/WMExJejyV8BulzB2RVeQK+n2JjCBQ2MtsXkr?=
 =?us-ascii?Q?OiaNXBwW0fZmbJMP+WVYZlhZ79YqrCkswkiSU9LHLhPUCX09HGARf9Nd0iyW?=
 =?us-ascii?Q?Vl0bhhzcHt+PWaNJNIEnCBv7MJa1mf0/oa1ejcqbX01YVaxnx6eyb9bXTG2h?=
 =?us-ascii?Q?PMiHOhfBXOd0KGJ9d/p2GJV5w8Bcb+qm1RhRnJyS4Gqxwj2yazcSodDQbvWi?=
 =?us-ascii?Q?EtuYJ/nAcMVfpuQ2aqQjdotgJuV7soJAnf2Q0dohgXSayZCl+7qkvEdTJW5F?=
 =?us-ascii?Q?eUqqtf03cz8ztg8e9mmKmy3LruO7r2ubE1UK0uDwRVkpLW5XdCXI1Whh/Pxc?=
 =?us-ascii?Q?oUjf7rGSXONrvY+mpUvGUOG5zaWXDXTDgB5LMIM3rzzQl9Yn6sz7sunAj5R8?=
 =?us-ascii?Q?z/n3cKistQ9XA2aymMnufP7RJ3+a/EosX/56vn/0+9tjcX7fvQ8cbjs3OAUF?=
 =?us-ascii?Q?6NihKSty256Ii2LnhHdA14VghUyL4TOuN/2YBZ+7ZoFONEuYeNSTrcYVXiWB?=
 =?us-ascii?Q?8rGy7/q4BB0dXQag8VTMHTJBZMul6pGXBRV7Sl6ySUB5twwPmMMO4dUipMcX?=
 =?us-ascii?Q?79MgqY7y03KvMnCvD5BYkc+sHk+X/LT3Sdybax75Rns8IvJxp2Ki1YB2s4Fu?=
 =?us-ascii?Q?aNduyuGHdrtKWmFEPkLs6/cbtOHaynKKma/ng06tvZwf5OyOz1+4pRfdqowq?=
 =?us-ascii?Q?MkMHy6CZfiA2Bo2KvlfJpzQJwNWOccym2Amofjsmx8dqy2oC1N2xQhWt79dP?=
 =?us-ascii?Q?EI+ZJGPf/RpoIwkTnClfMOIju2oWeyWVjYt4BBRK5ffZgC62jZUNuAfd9Fp7?=
 =?us-ascii?Q?lfZZcqH0S3Lp1C3U0tXZgGsczxNqVPxSguwf0xy+c9tRTaA9Zx5OyAy45Xpb?=
 =?us-ascii?Q?ygv6VHyBmgkgRxpXstzw0eigONfGHE6vjhGu818vXNJT9uE8H8T+Ag4jyBTw?=
 =?us-ascii?Q?Hm5LpDQDa5bqOnGQc9X9zW8Z3jP7fiykY3iKTNEyw1Ii9GTVuQ8XBv2FIcus?=
 =?us-ascii?Q?QDAwdnPrczdVgoTOoJP4zdCzSxf+vuOe2OQxQ09AUcNIBj7JGoUSb73QDsuz?=
 =?us-ascii?Q?yHU7Ql65e73aEWqY7wNaoPOH1ElEbvqhEPE6cDBf+imnlMfI1V00LgXyjouJ?=
 =?us-ascii?Q?XLlC4E+ydzmZ+eg8+Hc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7fd096-6940-46b7-f760-08dc4d9865b8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 13:26:51.8129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wb/BjDV/7Eg1+iT6lB30ftHWoZ1c0s1IfsjMtQdNGwETrcYMblZkn2d71VVSSZ8s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762

--=_MailMate_54F2C5A4-AEB9-4FD5-BAAD-4A2952FC9984_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Mar 2024, at 2:19, Baolin Wang wrote:

> On 2024/3/23 03:33, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> If the source folio is on deferred split list, it is likely some subpa=
ges
>> are not used. Split it before migration to avoid migrating unused subp=
ages.
>>
>> Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")=

>> did not check if a THP is on deferred split list before migration, thu=
s,
>> the destination THP is never put on deferred split list even if the so=
urce
>> THP might be. The opportunity of reclaiming free pages in a partially
>> mapped THP during deferred list scanning is lost, but no other harmful=

>> consequence is present[1].
>>
>>  From v4:
>> 1. Simplify _deferred_list check without locking and do not count as
>>     migration failures. (per Matthew Wilcox)
>>
>>  From v3:
>> 1. Guarded deferred list code behind CONFIG_TRANSPARENT_HUGEPAGE to av=
oid
>>     compilation error (per SeongJae Park).
>>
>>  From v2:
>> 1. Split the source folio instead of migrating it (per Matthew Wilcox)=
[2].
>>
>>  From v1:
>> 1. Used dst to get correct deferred split list after migration
>>     (per Ryan Roberts).
>>
>> [1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C=
817C@nvidia.com/
>> [2]: https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infradea=
d.org/
>>
>> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/migrate.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index ab9856f5931b..6bd9319624a3 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1652,6 +1652,29 @@ static int migrate_pages_batch(struct list_head=
 *from,
>>    			cond_resched();
>>  +			/*
>> +			 * The rare folio on the deferred split list should
>> +			 * be split now. It should not count as a failure.
>> +			 * Only check it without removing it from the list.
>> +			 * Since the folio can be on deferred_split_scan()
>> +			 * local list and removing it can cause the local list
>> +			 * corruption. Folio split process below can handle it
>> +			 * with the help of folio_ref_freeze().
>> +			 *
>> +			 * nr_pages > 2 is needed to avoid checking order-1
>> +			 * page cache folios. They exist, in contrast to
>> +			 * non-existent order-1 anonymous folios, and do not
>> +			 * use _deferred_list.
>> +			 */
>> +			if (nr_pages > 2 &&
>> +			   !list_empty(&folio->_deferred_list)) {
>> +				if (try_split_folio(folio, from) =3D=3D 0) {
>
> IMO, we should move the split folios into the 'split_folios' list inste=
ad of the 'from' list, otherwise there might be unhandled folios remainin=
g in the from list.

Can you elaborate on the actual situation you are thinking about? Thanks.=


>
>> +					stats->nr_thp_split +=3D is_thp;
>> +					stats->nr_split++;
>> +					continue;
>> +				}
>> +			}
>> +
>>   			/*
>>   			 * Large folio migration might be unsupported or
>>   			 * the allocation might be failed so we should retry
>>
>> base-commit: 08a487ab26d541a3bd0adaee144f684b724d233b


--
Best Regards,
Yan, Zi

--=_MailMate_54F2C5A4-AEB9-4FD5-BAAD-4A2952FC9984_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYCzRkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUHlcP/2y6kqO+4YzLRyuh4OiaaXDDn+IVnH0z77hk
3+lhnhx93uXxj+t2MoNuKH3NGbvMlmHQcF3WGhrqU5bNYOqD0FT9JphldsbddC3J
uyeRSiMCGQhprwVh2zks4L/w8NYMC6vY6wGcvrFk7i6nB7KfTsUwE/L4CjIh1qiB
O8uTwVaebb4wJJCUshEfjVW0gShq6B/3az7q9YUCagFYuhkJVAntnyQ1pcM85mur
WWbHyERoOgl+KpU96ObECKW3GXrMbuAHzekGmNP6luH+31dE3ZI/7u/gAZgpLAID
fKfCuhtT/JdO1+5Rll/KHhlY23Rog10AzIlRSryxhC64tfxDPZB28sN1hrSBxBX8
WjTdbQyBIfGF4BxhEhvDVMnSCvHKIWVUrLcoR/ukg/AxjF3TYmMQ6+PWF5OVcwrh
C/xArXl6q2FmPDOWfjLs1Qda9rfzfsycMOJuFUbqW21hxX+i8L+XlrvsAm53ZMlf
jTiVvwD4OtR7TJLiAYDH/0huEZrN7cytT5XX5RqKMocbsH0Q7Iff9ppCsGfrTxHl
3wIROOBR+qjMAzjOpG3SB7B87tGPiVkl6HyoduHH9zCUVLxyZ9AqWWERJpSwQx5k
5eKHn0AWLcJaooiu2FxhyGFSEI3068KXIXkgwi2JbiWL2x/9sWQG2OCJAZf1uNQ9
QN0CPFNS
=d4y5
-----END PGP SIGNATURE-----

--=_MailMate_54F2C5A4-AEB9-4FD5-BAAD-4A2952FC9984_=--

