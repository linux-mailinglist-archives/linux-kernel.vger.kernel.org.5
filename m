Return-Path: <linux-kernel+bounces-86926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7683886CCF4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A401F24232
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0671419B5;
	Thu, 29 Feb 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pMWYKGC6"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D286275
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220540; cv=fail; b=OXevKnKweaAzLNO5pjmMY5sCxTjlbdtJhdGKeBWM1byiX5LMPaf3+7joR4mTMv8Stn4wnFs8lolUju8DwQfUebFXsHmEEwj7REpMLVKgyUOVI0OklZDcJdb/El6NLB+cYeOUMrvU0/q6wRqVmuWnUUCqziAR4yXK7gknwpgugn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220540; c=relaxed/simple;
	bh=eahQHPXDqf//JLRcVijbi3Lj5d+GqCm5yV3cvARyWgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P4LfYm+ZTlnSJLRFHy/S2qu0a8SuxKGvplAHVtS6InMpqSWgYVH8AGVCButZgEUe6O09vmPhIzDip6VFHREUDE0Lkn4h2LlRPrtgYNa9AzP9GPwT3I/VXBWFHZdDRRPf/3zLJJvOVFHRBRSSEkSr2E5WYd4QhaBvDrJDANeKpxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pMWYKGC6; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXcGN7tgJG7b9X++edSi4wUALVAePU7bZ6z9gf6h6aXWGXUhdbhtabCte27/eXiY/m9qiUih0k1JwiiO1dPd3Zot5n8gBoip63XJK6UQVdjnPeXBnyfu4cL2Xon17Ay+I2aCQ4yfJvFqo3/T5Z5ikqLmBTFSEsRs/7ow7QJQ7M9Sy2V7T/cmUDFj0LphkZ8veZ77aIXsxX5wZmJKQOV4vPbxCxZ2jUqYTl1oZ201NeqGZoLH/RD1V8XBVLlzOhf9Mr2PByytbdEpW/JPoUfZq9+FBjTOozrnUfEM7y85YTihcUsRhafzLL5c49sGlc9hQip2kllEXSE2gpgPbOSK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eahQHPXDqf//JLRcVijbi3Lj5d+GqCm5yV3cvARyWgY=;
 b=HHgNRO7sa5tHnR8U8szacA3Kc2LsmaCdTRTLmlKPsb22cs3b3h3wGyF1RCm51Hk61E9WE8bxCEvNr+KjPTP3xMQ3YKEAYy6pwgRGnz4LkrnEBb5AREVxVykWhbhevIr3dfVPj8jtCF+GSvNJmJQ+LqFDkaQErh9rp44Y7fK7nwUzGtTTYL/GTT9hhNyhSEmw7UUucOykrnuKDisY6ooVZDPtYVn5XnOVdRsh94/+kyBouZd8FPZgfGRJxqNMACntZ2gF507torchLetsplVM4NV6qYod+oyv0lKPrtURF1g0f+c8MPsDKvgz6iGYtpmn0K7K0lDo+BPuBtKvExqKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eahQHPXDqf//JLRcVijbi3Lj5d+GqCm5yV3cvARyWgY=;
 b=pMWYKGC6x6AoBhaL3gFpZuM+5gjhMGNFOzUKSCYC/qVR0egrZmbaG18NIHZ/YLk8dJOzslqSu4hpZpCf8gHncnWFLku31mdXwsy0ftzKSEMS/R17OmbDtbdjrSIJBzOMHfv6zxCPnUE2gLXKAWl1G4KOBxKU85bILXEgeacpmUc/YTbVTpXJYOPfGdC65MvyQuAyI901466F24I/MtdwrfUxg53D85Oz2MMByaUE00Myw5V9MFGyTaXy1jN07LEh6VPeMuJQ4mkQptsmPF2WQS1zPy7hPGtutIlDsxMAl1uoL89uDNpY2u6w7Adey1OFGWmXwJ3R/Os5vjbi7wobIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Thu, 29 Feb
 2024 15:28:54 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 15:28:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <v-songbaohua@oppo.com>, Vishal Moola <vishal.moola@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v1] mm: convert folio_estimated_sharers() to
 folio_likely_mapped_shared()
Date: Thu, 29 Feb 2024 10:28:50 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <B10F7140-A4B2-403A-9333-4A7FAF198949@nvidia.com>
In-Reply-To: <20240227201548.857831-1-david@redhat.com>
References: <20240227201548.857831-1-david@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_01707C6A-30A7-49CE-9DC9-493ACB66318B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::23) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: 1310d8a4-b4ad-4592-4b16-08dc393b23c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NKf/cWlM07Rqp1dhArhzz5TeehxzNyhqLXYeVEgD8ZWnbh7rKXOYr6EmokDEJ4GeFdK3yUfcOFo8q+0mQlMgp0fARCuvErITnNY13cd+d9gFsRgNmyFt+0m3voQ7yhJDoT4N3JCPgRzmWpv3pV1zOmM+//ak4NwNv5ya7pizLFubxGqoLOjAW1UAI+ZskqWsFr+tYcE7E3yhSyYBQR3wiAclgc4kIPdZ0SeGqCS0/3N7M6XOkyL5YRpFL+X0KO3jrnjjcnwcHiUR2LlpP3zOk5NZuoBVy+c4ZIvdDElL4ihcMeWPGYNNao36zmMyokHmQ2LvpXIIxaGsGt8cTlhqucvFBkugiLhV4ilvWipjCg6avpTaLFns4AD5cfrsFInQ5dmXV9zsx/atxkQdOgOFJQ97l2OuUBu4A7GBETJjJNieyETMKEW2ekkF2y7mwLz9TJnksXJA9PDHRb/nxlB+RxkSv860hMcnMpoEMguvDpo13DEc0qKdlvf3pL3bfZsECngK+nj7+CeHhHr2cDWZMm8K6GotUyLpiK18g5gjZ7XVerxYli+XLa+WpwXtjOPWvzwgACEmRZYarrVprRpeCW/xynGtjpw3Fu1JE2nXAtOma/j0luDmH8KI1221akGnnhN5eff2P93WE/mLLEe3HQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qlLgK5gx7QUb/CGVWDAQGVwGakw4wHLYPP5mhTISAZI2qYwcmh8dvDBQ0ECU?=
 =?us-ascii?Q?n2ksrizuqrrvqn0sDPIdsRbq65HFKJDNEIpWgPj0r79EXPEiSIc0gmjJoLrq?=
 =?us-ascii?Q?v9DIq+qubKL/uvmCVW2Fw0BiMaz+rOwK4VNibYgzAu7ZwtAhYVvwqLGbaNEj?=
 =?us-ascii?Q?387fYTq7Cj3L9S1k9gSixmEN1elEOF2lHvt94FYBzH9ZG3w9HdbbaoPXetHt?=
 =?us-ascii?Q?8wq1Qw59erUfZgHE7x0yeje3lPfMVw4GUMgvvycdLwURavmJxKUSNpoO3YQg?=
 =?us-ascii?Q?SlX3fNF4EEzHT1YaHzDyk+/b2PJXunZq/YcWSTyFYeNd70pvHEoVFid4HKew?=
 =?us-ascii?Q?XXdcRhM1KBrgpoYEKYFuxxSfCriluVuXEdJBM+RehOEYu+D9YiwQjytDz0Ix?=
 =?us-ascii?Q?8BSYisbF1BtxHsJ0oq5LXVbCE+MVYIOZRJlp0BiPqnDWMV8GpTCXm1aYjmBC?=
 =?us-ascii?Q?WnPf5xXgCZNgt6w8ql5ODMX9BjzOr0DBEy2DkA0lOrDUsLGB0rvcyqf/Pyo0?=
 =?us-ascii?Q?K6xhgB6QDe3snoehXIyY3I6WKbjyRGhZfgEgwDYZhaShOPZnkohulXheftMv?=
 =?us-ascii?Q?4QnXWJMEbkE3R3JOrZuNP1fqpViqUcLz0e62Cz5PZ/gLHwfmN/2dlblplq86?=
 =?us-ascii?Q?i7J+DBtbCYWEHN0qvZftUK9v7axmAiLRjO98q77HM1sLfs825LCnvi5CqB9h?=
 =?us-ascii?Q?XqI761Ahq2FPYExvJ27/usDxItMsLfMOvrml6RAFIh55/HyqvYLaK7i8JjWF?=
 =?us-ascii?Q?4Meb+LGz0Daq0IFqY8WyW6RoNW23rvmfN9ESfY7CzhrN+9z+/BY1NUDGDUUW?=
 =?us-ascii?Q?Ztog1/W3dk+9pq+mbmaqkXXXcnGXCjDvZ4lxEIylONpiQl+70a4OPPhbEKxp?=
 =?us-ascii?Q?h6tLmdTQMnWRcjTDrpaBKoJTkqErvP9rucl6ef7T9zxeiLw4b2khhyyUFg8T?=
 =?us-ascii?Q?uhX6BN+/YqHxhrG+1d7780UOfHqGlhefgg9pkk1yyGmi+3iz05FoosyWDY9D?=
 =?us-ascii?Q?JkWvIChf4apoaKYCCSfMt2iDVHyWLd0ZfI6eHzXGMBCo71fZ/6enOfMCdfqw?=
 =?us-ascii?Q?jGEwcpAwwvAVjjm8vpVBgaijcMud4wZpZEzsmnk3tFV1e5mMwOO/k3H9DJN6?=
 =?us-ascii?Q?unECvrZKFwribzv6pjTb3mOLoewiC/yLcaafA49GJxK94aeHUuCwkQIefGRS?=
 =?us-ascii?Q?DDMUi/ctzi91DJiMA0b8Jxl18e5k7jnsiIl1R090XEnc9Hr8B1Is/brETMBb?=
 =?us-ascii?Q?UwLiKeluLYxcHEpXUjiTevyIhBX14Hid/XRimuaxLVy0VfzigjPRuD2cGbAp?=
 =?us-ascii?Q?dtkk4FY64tCxLvPD4nzCUONFG3fnaPeMqi/7etNvbdjhMIBxNZYSRWQnfHMV?=
 =?us-ascii?Q?sWEIh0zBncP+wgXa/N42+F4tGXigFxBXGVq3pSthHZdShFdtRSxEFSZI/ADI?=
 =?us-ascii?Q?lLE98vUl8yEIxtMSQ2+lIRZlMiZ/5yaJW4RbhhIY2P2AtyHusdFBqwgwrxTJ?=
 =?us-ascii?Q?s8aqfpYGUlnNQx3bA9WvBCdUMNt3MgRMOtJOEaJkyZS086KrQBNpozXDu7u5?=
 =?us-ascii?Q?WW2nTJ+WdYNqUsUmSKo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1310d8a4-b4ad-4592-4b16-08dc393b23c2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 15:28:54.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycLrllGdlsh0NrdJtEt1YQXmEqbjHbTCK1CNLOOjsWDSQfxuTvKa4S0uq/1O4Udn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930

--=_MailMate_01707C6A-30A7-49CE-9DC9-493ACB66318B_=
Content-Type: text/plain

On 27 Feb 2024, at 15:15, David Hildenbrand wrote:

> Callers of folio_estimated_sharers() only care about "mapped shared vs.
> mapped exclusively", not the exact estimate of sharers. Let's consolidate
> and unify the condition users are checking. While at it clarify the
> semantics and extend the discussion on the fuzziness.
>
> Use the "likely mapped shared" terminology to better express what the
> (adjusted) function actually checks.
>
> Whether a partially-mappable folio is more likely to not be partially
> mapped than partially mapped is debatable. In the future, we might be able
> to improve our estimate for partially-mappable folios, though.
>
> Note that we will now consistently detect "mapped shared" only if the
> first subpage is actually mapped multiple times. When the first subpage
> is not mapped, we will consistently detect it as "mapped exclusively".
> This change should currently only affect the usage in
> madvise_free_pte_range() and queue_folios_pte_range() for large folios: if
> the first page was already unmapped, we would have skipped the folio.
>
> Cc: Barry Song <v-songbaohua@oppo.com>
> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
LGTM. Thanks for the documentation. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_01707C6A-30A7-49CE-9DC9-493ACB66318B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXgorMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUBwcP/Rt+az4MmAVLI8VgjNUHug5Fxl1LwkFz5aA9
5V0G2fnC2A/v8ndncu+C3RowNn1G6deDMEth9skQ1BvY5pIWMxLK6nwuwS10HQCN
aBgXhKU0uXhxnKqMHLl/8SnbccvsxCu139nPEgo8mh8UOuLJG9mxh2wW59CsEL/A
GrpseM47kUwLIVU6G7uvMywy7tJvggje71dF+Fn877pvPQY24kGVxZVIonezuOSm
oWyuiARJ8RuRA2qN+X0/jHtJ5wqOsAHpGEZKCApeKW1HrlPLfT3KsPimSzx1BQ3l
nG6VMM+qZVIfN39H1S7mil1xBnE+G5i7ZhIuA8io0IpqCzxzhakxZrexGs/Q3ho8
afzfgF2ctuVI6jqWJJfFI12P7mtl2fr7+ArKRzm4TOptV6dP0RfoPZUNnz55l1kZ
JSf1in3v1aiJRynpYs/Llr/FA1mUUUhN68e1sNqkTzsCxJBRfo2IVbvB+vHqcs8t
oGPrn30uOUxCHFE5B3LRqlA4PvaRX60maHwyVRjjGJTsNmJ3J1+g7tvfN2konnT2
rZpb55usPIbcs+J66xUwZo+aZhbbI9ZinFdBS57XOHQNB4t3QcMyU7IcvTpuvZIc
Bw3JIl3wyNe0209ovdQ4SFR9aRq69Fef4Wqc2/MtaUn7WhqAyV4YTBRCVUcteYYH
BxAk5e5I
=kz5u
-----END PGP SIGNATURE-----

--=_MailMate_01707C6A-30A7-49CE-9DC9-493ACB66318B_=--

