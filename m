Return-Path: <linux-kernel+bounces-153555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 631978ACF8D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860FB1C21822
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385151514F5;
	Mon, 22 Apr 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hp/+pnA8"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56C015217B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796502; cv=fail; b=ql5q47GP4/Nq+b2IlDmRetq8iiQGbT5O/UYh2Nb4if08/AG2PPDV5jfblZ1A0VY5IT7WfxL+K76WsfBgd+snqr3Xwptji9Cjp4m1luOTnzZ1Fydd6jzFndTOLzQH9p8gjXdj4a4p4ilH9GTXnw1bJGYlo9U57fqgKYb2kvpn+38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796502; c=relaxed/simple;
	bh=1rsZCg37VMTRZ7+OhqrYlp8/TsRQ0YMiMp0aDqqEuto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EaRMWyekny9VHIqtdQf9voKS4CxsKfVUP4jqvaZwFuoY3xV3UKHNCxyMGn1qtTAJMKV3yScWflcUbwxU0bav4kXYgiRL0iePTFKErJyGuttZB7CxIsL5X2XhiV3XJ6kVfk74DX1JFLMaDG8N+F3VHArAsN0BLBBVg9YgXPUaPZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hp/+pnA8; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVwdHvKThn5bSkquAAb4wwt8bWJv8G0A3bPsrwUOa7UBIC5pqyO8zkmCfRMicMQd6C9Cl9v3Ptxp1aMdCsEAuQmPLXUgdpb6iWPOUf1/crWYIBEpqh0uJHqSdkPwM6LjeFnKYqN5iSb09LQniyABaU69Up05FYTxItZ94T8CWvuguOpu0j9n8P1ZVbFgGFjfF84SnaYrbXY2pjcwB/ZXph0ls8KMSc2jYULGf6dzoYIwCiSx+P1db9wKM/zdhWxPYX+Bz9JY/Kh0Kf42AHDYxhYbkEf+IHowM3kw+bUvHvJp+R/gWrg3cNGHQcE2rFbNZUU66UvLTypQAJjUdH0WOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dnqMJ0RiwnE5PQF/2nJD/QGruNnFu/vj5qjEr0CPKs=;
 b=cmBI7+ppRHFQ/853vo7BIVmB7TmYfS9VRBjyInECirnqAAu0DGlNT9kXTFFnu3sltg2JYgUf9gGKaS5RUDt8uRuQrGreZtlhxzwRIbCNSBKfvWYKsHE+0iFS0IZl4a6qcyGnzbEvytNvYG+ySDQ2SYQ9sJyWZJTjgUdkPbru4XdjuuQJFDitajh8DHXJ4izwVGygy9vSkUmaGaurLNlJfY9Way2NXHlXwLJm1XkTQP9xPKzt+NQXZcRPeTTs08E1Df5esgCuVaq/ON8SAbj/4isLoOyt8MlXZonPGkVf4Q7cH+D4KC7ee/cQQ0FOHEdh/PEhnKQDMwX1zQxiZsXFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dnqMJ0RiwnE5PQF/2nJD/QGruNnFu/vj5qjEr0CPKs=;
 b=Hp/+pnA8ho+CBjCPhlMrer+Qek1vk2C11Ig7FzemYxjWgXdO+BAHqCHR4armubjaHxiNHBMjmkjcm5zCIZutmrGzICuLhVFB3EFgfzVp9CLpAw5jzqeHg8cXmNmlPP9PHdhfC/rezifIMkXQTvOezpKy5AR3losn6MUWa1at+V0jtfyjTC0UPXh86JXxrju+AyEEpBTtGsrGS/6y0baT1yrBahqEpPIDcV1Oxh8P/+u3bC6Bm1rryvZa1U3ao13PRQvLmgGyXNuDehUWzk4FrS7JxH976KNrQmzSFaeD/XRRnW8yUfLcLaf+0zXg09Pa2tfSFqQYRefRRmyrNHpjmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 14:34:56 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:34:56 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v1] mm/huge_memory: improve
 split_huge_page_to_list_to_order() return value documentation
Date: Mon, 22 Apr 2024 10:21:26 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <2EA1EAC6-D42B-4EA8-A919-FD891B2B8AAF@nvidia.com>
In-Reply-To: <20240418151834.216557-1-david@redhat.com>
References: <20240418151834.216557-1-david@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_31E52CCF-73C7-4E0A-8098-78252728FA34_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0270.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::35) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b89d60-077d-4438-acbf-08dc62d961a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JN38Al3ynPDoKmvFc4NlspPHIocOMFpr6skG+jnFF9p8GX2iLbO6G9tQmnvk?=
 =?us-ascii?Q?CNY/EG+KOEryQExLdhS4s0aZa5YfzffIFrD0dGVvAcbhjZ5512aP+3NAKpcZ?=
 =?us-ascii?Q?nsZLtJ7VOhzg/Bp/lmEdEdvux4juDucQJb+sF/Wc9JSxNM06RZm8dyeqAXgs?=
 =?us-ascii?Q?zEzXZ4IVQFEMkpBYPUeNQXt3UFVN1FXXoSiXvI05DkanQMgDz1BAQxJpW9o6?=
 =?us-ascii?Q?dlH7gOO8jNR9bM+2yZMP4aZC01/SO9k0/20lLWJDotp+pujZ9/Pcz6KZjLGs?=
 =?us-ascii?Q?/eDqFCM1jr1EflYjtJSfd4FtRRgFOXxMwlqUIz2Lamhjr10YINQo7FOONowy?=
 =?us-ascii?Q?4pjpypT1zF26BXkEBNOIwqDvqBLin3VjeshX56p3oKcgWOs/4QLV6BoWgVHV?=
 =?us-ascii?Q?pagKcmPTDTST2np06sTcbri7bgea9cq91iBLUnG6ezM57NtJt2hdHpB9HeeD?=
 =?us-ascii?Q?8k+8UgvCy7Umf22uQh0IWkHlhXlgF4o3wsWz67FUuHlb+K6PH6uVb15vi2Nz?=
 =?us-ascii?Q?NZzSKw5inpptqLhSY/0uD4XeDepsuawzq5jrbqdj/JOnvaXRW76NNavuSJe3?=
 =?us-ascii?Q?+23V1bFxIyNhY0IMKclAnWpLxIn8ZMtOZC3uKFSMdI5W9WeGh5e8wW7EODmP?=
 =?us-ascii?Q?DGyVdHDVmELVXoYngZDahJXXXHmLuv60vs4Ru/ubmBC2WpSaOQF5VTWvmGQK?=
 =?us-ascii?Q?oPtL/BM9wohibsIGRoeEgxlne70weGSRkdwjn2gvjn6uCWJqX/CTR/Zr2+IY?=
 =?us-ascii?Q?r0XmRDCPMiNmPzdFbRxfriqmbLACEZVjrWmrtPqIwHF73I4jfBFaHG+MRzO8?=
 =?us-ascii?Q?iQQ1QUGJxDk9kZN1AYOycS5bBVIqEC3YnV0YeWQgsoMlRI1n+6RPkfBAPexi?=
 =?us-ascii?Q?/Fnz6oFD37s1fri0+tKV+Hzlpir4mYFrh+ElC4EjZkQjbb66Jy6LxDGX4l+1?=
 =?us-ascii?Q?QQKx411dcg/ifs9UbFEGZPBGKP932QjQJije+KUS5AgsPpYx5ITyAGF50zk7?=
 =?us-ascii?Q?bJfIu0jo8xQ9FGSP2MfsJYttWbdwtZC0g+vQieZHLpiH9h0OFEowkxmItRJp?=
 =?us-ascii?Q?hH3HkPQmomsU870RlOywYCXCixArSScBFA6G8l/LBKyarE9+UV1E8B6MpuS/?=
 =?us-ascii?Q?d4wIGhgrUun41fWMZhTk87l1bk+XLtgxVBTbqV2xKXnSdLjcWXKhgiA2+n0G?=
 =?us-ascii?Q?x4KFhFU9B6kSq0VCX9O78AmmnkW0YAoU1HphSoxBhRMxUIjtiljsqKjYqvWj?=
 =?us-ascii?Q?5gbA5oEiMg0DhKIF9EeMMSfaxyV7thMeYqZSdrRhNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F4YM1JIT36aIMhx/ehUtz04M59+I1OL40TXKttb1kFkjIh02COxDOfAA7jCR?=
 =?us-ascii?Q?SJPwMH5PPkkkpsz3oaUKZ8rUwIGQrN74OcPcLmS7doyTxr+G2R75gcefRxkb?=
 =?us-ascii?Q?41IFVpc7TiyBh/hK4b0K/xowWJx2/6xMESgLHPKwpYOIC6Me4OE+0jFC6i+H?=
 =?us-ascii?Q?HOflfTFfusJr21vTTL6/FgsJVwIP4YYF6AbPvVa4hqGza16r5RUEbT/CWBkU?=
 =?us-ascii?Q?5s2GR8gs4u01U6sZ3aIUERBc18sfOqD5OtbAScVFWDxYY922UxG3vWxBdSTy?=
 =?us-ascii?Q?6BX+hqNrAWpmDpmQd4rw4lQrW6TNbx7K7A6HYUqgO5BHmShf3sSICMICh+Tg?=
 =?us-ascii?Q?z9htVPZCjW4NKwNc/ZYlpuG0s21TpjDMe+Py7gKTRKBl9DczD2Smt5e1WNs3?=
 =?us-ascii?Q?RUTBtcsIQM7805+pndyqpVbzSzTlw8B5i7YkdCJ4e76hGJ0qdN7QtUkARWBw?=
 =?us-ascii?Q?1Xfn7DLAKJ3RSEUdEjVT64LuGTcdSiq9K3PBeeWrfBH+jH4I9OHLREDpBqvO?=
 =?us-ascii?Q?sSXtFC+aIsT/Znlwjj/kn5jAb0/QAAF6RUeu7s5YkqZic6l4wqBFMZdc9JDJ?=
 =?us-ascii?Q?gtkdsaTo3wu7R8b2lKPR25GyGqEzKN392eeaUHWK86HSSuWshBBc+ySLeolN?=
 =?us-ascii?Q?ToAsLDLp0YA7aq5egcB9Q5dkFxM7ksb3f8WgB9vMKUpIHcJkTMWq2g2hIkk5?=
 =?us-ascii?Q?vvQTqx4cqf5PAjBQAZ+mLbV7O8zjEP3QZtFO+CWsPdYV/dUFGtIUGUw10/A+?=
 =?us-ascii?Q?e/ZCa+cUREgsNaPP2TDvN52cHb/y7mfGPZ4gsYk17MfKGggXDRyQXsk50zDM?=
 =?us-ascii?Q?VHpLJ9DN+N2gbOImYGNlGJHOUyxyBIZkf3Yp6lWJfgkHoLEjxPPSZhcj0NeL?=
 =?us-ascii?Q?/vEEHl3XQ3rhfPQmahqDLyhM/mZYteN7oXtjthi880OYb6L0pd+/bQOMtY6P?=
 =?us-ascii?Q?wwcagpYbPfkJlAlos/eT5wozs7MKKVJ6iAgI7PXbkeQzeRU70GwmjmLPh0JK?=
 =?us-ascii?Q?Oo3VLvOXqoHVAb6mpPXBbDPC3LMyHgUYF6uo+LLWfFJeUMTPyBKj9SjLBx/3?=
 =?us-ascii?Q?v/gfpeKCi01hXjGqAWEnWhBxt1NsZn9IO3xaI0ice6C1nb8ia1043ACVKjHj?=
 =?us-ascii?Q?T4YSJr0C8VA31/a6YQG167ZPOkXG1f+/eWHKkZXA/4lh5oZ+a9jEn2rGqDsQ?=
 =?us-ascii?Q?nAivEtKSNGw4b0piXvwp6ySumTQgrbqk3LXBngy47oTVGC2RjfjXK/7KY/UB?=
 =?us-ascii?Q?rA1ZjRWuEqHzy6V/6VQovZGCqXU7lNj7ZcIonLDttan4ZONPUEVhRtJf+7bX?=
 =?us-ascii?Q?GRHRUzA4u8f32wI1CsxJhwIMwUhBx+oducrvZGhMRc1eQXvvN3a0DEWJwvyY?=
 =?us-ascii?Q?tDKo4AoL+abxwpJ394V7ZPLSv/WxX9hNBkRZG2oxlgTqhv+yjcEVg+F7NR9p?=
 =?us-ascii?Q?l8c5OjBXFFz8mkBjwUulWP8I4Hpn4H75mx9miNG+SD12GCU8k1660svCUnZt?=
 =?us-ascii?Q?Pn+DZWSraX41gNpbcytjmQpyQ6diZ71gTR6nQx8SXBHZMs5eZoM+6VlGmLTc?=
 =?us-ascii?Q?x88fQC3j3kUhNKMWzGI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b89d60-077d-4438-acbf-08dc62d961a9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:34:56.7359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShevnOkLghvGQGUa5EcDI6HHdonlvX4wPLBeKJKe9WpdaOkDZ1+iDGfZbZMfbgD2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557

--=_MailMate_31E52CCF-73C7-4E0A-8098-78252728FA34_=
Content-Type: text/plain

On 18 Apr 2024, at 11:18, David Hildenbrand wrote:

> The documentation is wrong and relying on it almost resulted in BUGs
> in new callers: we return -EAGAIN on unexpected folio references, not
> -EBUSY.

+Baolin

The code was changed at the commit fd4a7ac32918 ("mm: migrate: try again
if THP split is failed due to page refcnt") without changing the comment.

>
> Let's fix that and also document which other return values we can
> currently see and why they could happen.
>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/huge_memory.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

The changes look good to me. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_31E52CCF-73C7-4E0A-8098-78252728FA34_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYmcmYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUdQoP/1OpPDdMs9p/rlYiQXcX4KbJBHXcsR2Zn0z1
ByQ09C5N3MRfKv0h7dlIOPzXvPFyauF9Pacb6iBRXZcLr/nNdK0CRlXUeWPHsa4r
cVri1BdUjaEg0osLkd3lAWoxajml+Ydhca9r5gTuV1W1mMpEqf9qnZ0WxgDFx4rQ
vhcqXVsFO2j0XcijHd6EmgAC/f2PpXICQ2t6iqvIWrEFGDZBv43zLwG5WNGOSaE/
E2EuOO1dN5oFmSZ8ebTKJ/KeFA3jbKQSHtaTkF+c8v67KajZ18rkGJuyFTX6oVHp
iakBdJxlND2Uwq3MEK2NVg859iFEKDYjB5czrLOaa+RYGojftwJvstfBo1Z5rXuC
TYDR0xHMkLBJIC4P9p/EWpfJ9NM7raTp8q21l24fFni6pFkRICFH0Zqg5G5zO4si
of0xz2WQFPbN6La+KXl00VIow0FQKtI/IRbYKWjUq0BhDi7QD9H/TB5+ajCHVhUx
hnxgtzX1GMZcg3zNyuYFLrDMMqjG2hsollqq0pF1m2e61/bpYL/kYHa6Y61WMMc2
4yWtd20wBLww1lRU2BeGO+bIcfybb6WbeWOOwRQiG9SF656M+L0LstqCHV+gKjHL
K8hwzCoPWjEhAwPoF2ECeUPtB0It5WocSIxCsvb0ay7SbSi/IRZbFujYTDfISSJS
k/N2VlhM
=56sr
-----END PGP SIGNATURE-----

--=_MailMate_31E52CCF-73C7-4E0A-8098-78252728FA34_=--

