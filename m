Return-Path: <linux-kernel+bounces-108392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E488809ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C521C22D13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4553927473;
	Wed, 20 Mar 2024 02:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FPon9u0A"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E210A29
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902878; cv=fail; b=CLmtViZ09jbvHNHEhmOKwDThJoHXTG1Khson5kzzB5hJbo41C97j0QjB4vnQNFy1qaZrTDKBbf+FBdp8BpN91BTuaZi0pXFVN+6z1UVflZ921VqVCNlrjZ9wrTxb6oxZkyyw6uT21hyab5rcU2io3iVS3VMDIk6fBh5dFM5HK/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902878; c=relaxed/simple;
	bh=C9GGIoGjmeUJPaAjZEeOiAo2vr3u+5NsLCaIbzy946o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kXO1n5XZ5TeOUKPhdOB41YQGHRE6dT+zwm//LFGtbexW2WqRdtVpmNXo7da//LBj5p2rgFlmAEtMdzemzailZZtAzA3iAOoC8I9kHVJ6cxAqJPIN+fd1kWkFESNeDgX9vDRfj3o4r0W8bcggtsvcekWvpVUiwg8UfTvF24LWkQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FPon9u0A; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5ArIdLY6fM/EqjmzkLDzReGpqhDNVCVdbeeWT9QTDnW/0dwcxVTT6sqgElGc/rT/ILcAvmEhzgArZNphq7WJw4+Vip3n/IfVKbJmqn/xxYhj7ZztjPYjtX5SD+KVnrAiiGAfvK9WaJjzJbOR1pgx0cXaRnkxAzCi1a2qmoXJs9MmlyK14u1sdXZZHXtgmagW2EExF1EZESa5c7pn78lC/tKyvjsFv1IzGYj+q3gI63A68Km3yS5G+OnnyxukDEJMnsCmN61Lqw0I7FNcZPkKxZnFDrtAQcv3VlTaEUXagJPdrCZ12tCjqFH5VnAc4GI6EpoLms6NIF14V2IR+x2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9GGIoGjmeUJPaAjZEeOiAo2vr3u+5NsLCaIbzy946o=;
 b=A1zGIRwvZ02ugfdZanzMHhvxqTfBiRsyJpaewW+9ji4WexmC/z8ROaHHlve43blTTZTQv+KiL/0BIckFlGWuOpIwd0WCL4RWLsmUgAABGnKSml8/baWgDtTjZns2WdjiiJ9uKIv07OY3sQLnJfRs0clNt3o4qa2X3yqhb5yLmRV3K8ut7wFg3xm474hx+2e7nHj1s8LcpKeZShYYDQM9Zw8ywYotkruOSL6sqIisXsVmUMf4qZPpgQy+cx4WIyq3eDYjobCPY7QNMiNWCBlHDaVYhY9A5Use8NwauNum53zfaHqdAs3lzwelbj1FIAyqeXUubCOW1G3udX3o4mOYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9GGIoGjmeUJPaAjZEeOiAo2vr3u+5NsLCaIbzy946o=;
 b=FPon9u0AVMyskLJYi4WmP+7s2VpH07Iw4H+RM6db4OYhQV0shGL1AV++d2Bo4tjnZyrEkFrAULCJbRP8LSVkkaOlhTh1mpJ9Uux3lmkjpvf90d5d8PW31JTNSqeGvKH9Avu/OjyPpG6t2iV6PRvRSJC8OHNtXGQhWYDAx4L5G+Lrr4FpfhRCvVCqZ1yd1qmtkd345lnxJU756aD8Z6H9YIAzDJpPY7yOvWQF7RQvqm9odAqDj2Ss3t5m9QDSmi/PA00ibjnDEcSPeRI1tpG4vRTVBdBKKzGrrYCvQmbnvVCPgg3Vz87AnSAk3QWbNjziauizdbaiSgWj4tNdxYpWlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.26; Wed, 20 Mar 2024 02:47:53 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 02:47:53 +0000
From: Zi Yan <ziy@nvidia.com>
To: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
 dskarlat@cs.cmu.edu
Subject: Re: [RFC PATCH 0/7] mm: providing ample physical memory contiguity by
 confining unmovable allocations
Date: Tue, 19 Mar 2024 22:47:50 -0400
X-Mailer: MailMate (1.14r6018)
Message-ID: <9D567EE7-45F3-4252-974F-6AF90CE6D635@nvidia.com>
In-Reply-To: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
References: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
Content-Type: multipart/signed;
 boundary="=_MailMate_B015B720-F1DA-4BFC-AA29-49B1BE04AEFD_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0055.namprd02.prod.outlook.com
 (2603:10b6:207:3d::32) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 675a922f-ab20-4797-187c-08dc48882387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xGM5xW7Us4VpLKP0w18nxWADpckltDyUt1Gh6E2qByxxcLUYngS6F5p3HSttA5HHVrikDizX2S065IcJyme/r7M2T2Aq9mtBVYQS6lqEMiV6cQaMBrR5sYZYuHeOuaQGwvpOjxVzUsvRQdQ1maXhyvPtn2WGrg+h9As1POY8ambx6sFehUUKBbVvAGXtGdWJjz38JLI8q0N6qIeXkF0lpK1ECD7Wo7gE1CtxC5wGx+1iN5bvpnIjbTvOVpRPOVrBsjZg9n6F5/PaxpJR/7qFO4PQMFL8C2uXvq0/yO0V7f2VQmya0r9fCP0ylEgkrmTff8yvDUsZxed6PEw9wOZqhTC0FsBTdwYctZteTk8cikloWtOKs/0BUQKhR3woXSBUi7avIv9G5s/S9kSHx/6Bycfs5czd6N+FPYEI9uwRv4bt+yqNyV9QCKRdiXLZehKzslinKrjQH1NiMcPCV3vAYKmW9QFM9kMgPEMiPVh4uClY0pK6HX3T6bNZXVO+ZWjPg4KHsRwLW+lULXE8BSBb6EvAzcNNDL9u+kbR+EbaZ4opro6zLB8Ydca44dshwSa9/TypxLm43uVNwzMOlKJJftCoNA+Ia/9Tg1Q9wwH8SYBCM7aIg4ySWPc2MUvL8FRdWrqbKFLqAgBBvHIVJYMSpvXQMdUBUYP40O2v4UgzA0s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3lFOGJBTEdNN2pPYXh0c1NKUldHRGp0NzZua2pUelk0ajRRbGJQQXg2MGl4?=
 =?utf-8?B?dGNuZDFKWDNXNSs5Ni9zVVgzcVNKSUx0a1FxWEhSdGNaRllvNHVSaUJ0N0Mw?=
 =?utf-8?B?QjFtcDdIbEJWQVAvemhRR1NuRHhZNTErWTZaTEoyQnBkWFU2bVpUL2F2eFpt?=
 =?utf-8?B?bUFSTXRRM0JxZ00yYnU1emZpYWxXWk9GWFhwQm1iOUJYSWF0N0MxSmpoOXFu?=
 =?utf-8?B?NGowNjZpTjNMemhTOFEyVHpvdlBTZXBXWGNiQ05sc1VXRlZjU3hURHBMeFNZ?=
 =?utf-8?B?b2JubFByd0ttMkZUV3ZXQ0MxbWtzQitCb212YzBXclFKMFBKQXNvdjllME9u?=
 =?utf-8?B?R21SSnJSOXkxQlk2aUZFSnVVZjNMSWFZTFE4RlJFR0h2K1Z0ZzFwLzFQMlBW?=
 =?utf-8?B?VHhYbk1ETFFWcGFhT2szQ21ERmNpTUl6SWxJL3AzRHczdWxJa2tRamd0bzV4?=
 =?utf-8?B?aEZtTFZJdDA1T3Vrc1FIbTRzUi82RmtaZ0xrcmZXeXh0V0NGbGpiVSttRWIr?=
 =?utf-8?B?ZzFOZmVycUdZUjRwbXVPLy80WTY4MEduaG03M0IzcDZ3ZU4yY1JmeVlNUFVv?=
 =?utf-8?B?RE9RUFgxZTdvN2NkdmFHbURNRTNVOG1tM1hNUXByNkNGdzAwbUd2eS90SUg3?=
 =?utf-8?B?KytZWVYwc0RJcUlDVDk2bGlUVWlqVFZMMFNab09GYng0R1BlOUhMaUVoTDcw?=
 =?utf-8?B?ZUpHbjhLUTlDY05VNXRsQlkvdUttUUI4Mi9KMG93TWVodnlFMy9ucjdZWVpk?=
 =?utf-8?B?cGdBZVlaaDlzc1dXd0Eyem9JUGRRYUtoYWhubEN1dWFENWJJaU5iSTBweE5s?=
 =?utf-8?B?VERwdHhpamxFdVJSaWYvMzVhakREaDRrUURqR2g5VzE5WVJJeVRqeS81ZXpU?=
 =?utf-8?B?ZFZ3Qzc1bkJURWllWkNqRFZjYUdJN0hPZ1ovbWVYVExkQ2tGNW44bEErbUVZ?=
 =?utf-8?B?QzFyNVJPT3Y0amJ3VXdtMFp5UFBjdEE5bkYzaE9JTURnYnJaRGRUbFNSdVVW?=
 =?utf-8?B?djVOOENQemFLR1JEdDFBQURWTGpibDFPczBxazc2eXNuSkdDaTNLQXd1Y1kr?=
 =?utf-8?B?NVU3UUdyYklFMCtZeC83WUNSTVMyTDM2alRad3RDdVgySitiY25nMDZRdU4x?=
 =?utf-8?B?ek1ESHhOWEtZa2VEVE9xbE1aNHQzZGVIb2doRWdyS2t6QksxcldGaDF5dU4x?=
 =?utf-8?B?TWFkdTZSbWpqUU1aZCtyWFhRRFVUVCs5L2h4M1VNOEEzeWVJWnlXTGVVRnZn?=
 =?utf-8?B?SHd4U1M1ck01NFMyaGhuQ01rL2M1STBESHF0aWVjZUVQY3pSb1R5d0VKcXpE?=
 =?utf-8?B?UjN3RXFONkJKUTU5YVZLa2lKRFI1VEtQeFVNNXZDbVR2Q2VKQkV4ZUp5UkR3?=
 =?utf-8?B?MldXUXR6Wi8rN21WSFRRUXJjaGlKYlJKMklHU0hsa3ozS0czNGdhdUIzRml1?=
 =?utf-8?B?RWsvd09tS1lKSWRhRlBNMXd6d3cvOWVKNVh0VHNWR1BuOHVUY1lXK0k4NU5q?=
 =?utf-8?B?eVQxbFd0a09HTEs4czN0QVVKU0pSZ3NMVkFyNXJDalVkYjROVWxXR2pwSDZJ?=
 =?utf-8?B?TEo2RHlBMVY3R0dvSHVsR05LZGJzWlEwUUluTXpMNGcvUEJJVjBIV0laV0Yw?=
 =?utf-8?B?K1V1OUY4d2E1VHpwUkR6REpGYzREejRhbDJPdVJmZ2FjbE1PbXltYWNyL0pI?=
 =?utf-8?B?NkdRd0J6KzBaRE1vaUdLRWxUb1NLVTB5TVB2VC9qaUNBMHU1NkwzZUkvQkc4?=
 =?utf-8?B?RkVKb1R1K0ZlWFNmTVRFWTE3Z1l1N01FeHBBQ2txWTZQajRFdnNDRU03OEtn?=
 =?utf-8?B?WVZRcUdSaFpmTVVEMThFVGZ2WVIzK2NzdUV4MGhvWW1FOVR5OWVqdE5ObmQw?=
 =?utf-8?B?UjNiTDN0dEhjTml4NFhacEl2alpsZUMwQk5EQ1ptQjlXRjIzOVZLNDdBamQ2?=
 =?utf-8?B?cnE2VU5ZeXQxcDR4MnJ4dUJzMlk0VWxYVkZyRFhxTVBndU5ocnBiSlZhdFk4?=
 =?utf-8?B?T29GbUZHemdHSHZqZ3NEM0x5UWpEakxDMnBQOWI1eHhYNkVVWVh2RjY1NElj?=
 =?utf-8?B?VnJvTmxtN1REanlOMnZTS2Jxd1pNRk9LR2JiR25iek94eDY3QzVtNjZmbUNI?=
 =?utf-8?Q?YAx8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675a922f-ab20-4797-187c-08dc48882387
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 02:47:52.9913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfAW0RQ1aFJufJigQuWi81+jTLcO98pSpuRd1KYInwuFPke6xyK8mRsO+U/2l2lP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724

--=_MailMate_B015B720-F1DA-4BFC-AA29-49B1BE04AEFD_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 19 Mar 2024, at 22:42, kaiyang2@cs.cmu.edu wrote:

> From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
>
> Memory capacity has increased dramatically over the last decades.
> Meanwhile, TLB capacity has stagnated, causing a significant virtual
> address translation overhead. As a collaboration between Carnegie Mello=
n
> University and Meta, we investigated the issue at Meta=E2=80=99s datace=
nters and
> found that about 20% of CPU cycles are spent doing page walks [1], and
> similar results are also reported by Google [2].
>
> To tackle the overhead, we need widespread uses of huge pages. And huge=

> pages, when they can actually be created, work wonders: they provide up=

> to 18% higher performance for Meta=E2=80=99s production workloads in ou=
r
> experiments [1].
>
> However, we observed that huge pages through THP are unreliable because=

> sufficient physical contiguity may not exist and compaction to recover
> from memory fragmentation frequently fails. To ensure workloads get a
> reasonable number of huge pages, Meta could not rely on THP and had to
> use reserved huge pages. Proposals to add 1GB THP support [5] are even
> more dependent on ample availability of physical contiguity.
>
> A major reason for the lack of physical contiguity is the mixing of
> unmovable and movable allocations, causing compaction to fail. Quoting
> from [3], =E2=80=9Cin a broad sample of Meta servers, we find that unmo=
vable
> allocations make up less than 7% of total memory on average, yet occupy=

> 34% of the 2M blocks in the system. We also found that this effect isn'=
t
> correlated with high uptimes, and that servers can get heavily
> fragmented within the first hour of running a workload.=E2=80=9D
>
> Our proposed solution is to confine the unmovable allocations to a
> separate region in physical memory. We experimented with using a CMA
> region for the movable allocations, but in this version we use
> ZONE_MOVABLE for movable and all other zones for unmovable allocations.=

> Movable allocations can temporarily reside in the unmovable zones, but
> will be proactively moved out by compaction.
>
> To resize ZONE_MOVABLE, we still rely on memory hotplug interfaces. We
> export the number of pages scanned on behalf of movable or unmovable
> allocations during reclaim to approximate the memory pressure in two
> parts of physical memory, and a userspace tool can monitor the metrics
> and make resizing decisions. Previously we augmented the PSI interface
> to break down memory pressure into movable and unmovable allocation
> types, but that approach enlarges the scheduler cacheline footprint.
> From our preliminary observations, just looking at the per-allocation
> type scanned counters and with a little tuning, it is sufficient to tel=
l
> if there is not enough memory for unmovable allocations and make
> resizing decisions.
>
> This patch extends the idea of migratetype isolation at pageblock
> granularity posted earlier [3] by Johannes Weiner to an
> as-large-as-needed region to better support huge pages of bigger sizes
> and hardware TLB coalescing. We=E2=80=99re looking for feedback on the =
overall
> direction, particularly in relation to the recent THP allocator
> optimization proposal [4].
>
> The patches are based on 6.4 and are also available on github at
> https://github.com/magickaiyang/kernel-contiguous/tree/per_alloc_type_r=
eclaim_counters_oct052023

Your reference links (1 to 4) are missing.

--
Best Regards,
Yan, Zi

--=_MailMate_B015B720-F1DA-4BFC-AA29-49B1BE04AEFD_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmX6TlcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUcgwP/R+9bOpWICo+zauS8zV2dNQralqdAPHfPnUO
oxXNfXvbEN1Dh4Q5gNdV/3PwNhmotV9BBDgrkqx/4B98GKRboaUrv3YsQjeBQHjg
UwPXqg6ODUnSn3t6l4j4GZtK9HPjBd1wUoO1wu0bpJKfU84N8nlfHlnNMWNHS/xW
G2AfQTUl9TYg/B9j+8pWTo1EtpRlk8P+F9oVFbbWTnT4PJqhbwFD9GG2QjYSOM7Y
t85FC01N3l5y2n4oeAl8RLP0CWt4bWWQ2ZjBx3vcRs30/ybKUqb7+TDzAwVDl1Lh
9vJFx98nAMWgQ81xYfdIU9UhbnAPjsdpRYkgFlludxkt9/YlPtcib9VKDZMHQGU9
L97lTzTag059F9NKLhX5GaSTk3q0I7Ep/VE3g2KI7zk3FLl2T1OM4mt9wQ3v22Zl
Cb302OrPPcyIonLUy5deCWeNX1tmo9drp0PB43XfKKpdP5z/3E8Fc1qQC0JFCxSf
LlNd6m8nUSjLxLDWuISVmjuzyw5SkUOdJtLAStDBqR25bWJEAP3Dx1rxS3zR3J6p
1TOou+D3vNQh6htnQc/YkIcrFt5EQ0xZOveQCv/KPzIpAic6aI8OOzvjEit+7Kj9
ku+cugymgjrKkNpF1mOUwRPijFCzpkh7S9D98ypig1b7lGOYTtRinbdQzcUsZ3Et
Jf31uH4q
=XQPZ
-----END PGP SIGNATURE-----

--=_MailMate_B015B720-F1DA-4BFC-AA29-49B1BE04AEFD_=--

