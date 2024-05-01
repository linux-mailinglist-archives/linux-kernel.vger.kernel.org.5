Return-Path: <linux-kernel+bounces-165212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5848B8993
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E0BDB21800
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6B484A30;
	Wed,  1 May 2024 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IMJzEuoE"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB082893;
	Wed,  1 May 2024 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565284; cv=fail; b=UjrUP9H0uyL+rwxvUYvUXemQdmu8bPdlMk59fXMvu9ZLsQNKvZlj0vbdS2fryBQeqT9pROAnLOlJkmV5Lln8Z/mZIXodxUpe3qWWQLvefxSaxqW7C2f7qTM3qV0DIhvm6WOjOtePwljEWGYIyOQug2RineRq0OQB2LCEMN9kXeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565284; c=relaxed/simple;
	bh=IF1il69EEPW8J6d5dT8Z5TLkAkFHKnnfu2IDB/fsCHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=caD2zN0FI/8fb6b+sh0oMfpugcr8sbV9JGg0vgavdnuLx4Delc4hrM8SoD6KChcII61YPJ7kSIhxGLCZW82pqwPWclrrKneGe9hg3TDjArXMby5vkX6y2i5pV0Lg21Lx9D0WFPHzNNrCTc1PeiQJdLlt25CLrS2dVzrDC9Tp/V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IMJzEuoE; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1Itq+NfATbWtTwDYwiE5PyrqrknV+tC2s+H+9Lti6rOHb92W4cvSrgXsjeX0gV7LOc135f9NU4tG0vgMVfV+7Y32sNuhbCBo/TvGI82xHdmv45eXix8rdsIRmI+D59a77Sdlt54ZMg2W0f3+jEqW5MguQqyzi3GLUBsu2B4Z6RGJ5ysnUM7yz2sCrQfVGQ+kwf3WupD9mZraWKQJXdM+5aKOIEXaX/GQgp4ZSpbgjXulg5fw1rbIB3+36BSwBCKm3tSel5fgh5mkEKARgTvvnxguDwulEivJjeje2LiKJLrWCWc329inckQzZDI/1rrjtiC/elC4XeFS2gSFS7PeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Lu2LDE2mmSEEUMaoiXPNWB7uXVsLUCXnzJqHNZQIrQ=;
 b=A9ewvzhb/aPmVCYOkm03mmsv/k3n3IBUYNRj7EzEixwP14DS2g1siQgO4ipVddMhQNVla1DTzxnvBtZx+ji8RV+AXvvhz/KpeLvdmUjQ9M2QW9NLxfqJPAUHF1N7YIZVt0LVkmpL7JId0s9uzbPiwkj67juqCJH68yE8XysyXInHrxUICI4M2/bspur0C8q91iy1cIltkadYdzxM/ljvLZsMbDi8PJk4hjk5rBCrXruV9BR/+XOp0toAIwbfK0RAB3Aibh7JwpdQMSdPeHgG0/YtrUdi88Q4ToxG4xQcgfEI0DbiuqXzdldk4zlRki70DrKUuwqQER27Ure8VmsleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Lu2LDE2mmSEEUMaoiXPNWB7uXVsLUCXnzJqHNZQIrQ=;
 b=IMJzEuoEHhE3bJigGOw5TsFLA91njaTaI3pAYR50Dv2mATypZR6t0PPJwcOSGxPK+Zx2/5MYsjK8DNOGf5S5RJqR8OKKlpI6AlRvvMOnzvCU8NfDDPUKzcGWSpe7kkj0BNAvQChjk0hdIh6J/RNFfD+nHAwuO7EMxBIE2tnuRZE73mJd7gfmX1M8ysGH/xURJyPg7S/4vIOmWtBDGbdIGM3Ym5R6GLIw8Nm2SznjHnuvwl87EIrhPHfhwMFSnYI4/vZaNnJCZo7RHtsRqacJ0H6e+fQzq0WM7of92t0dFDwOHz1V6cbcS5WorGUSl/X96YzcBvPvETkpF2Mfjq2w2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Wed, 1 May
 2024 12:07:58 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%3]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 12:07:58 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 David Hildenbrand <david@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/mm: pmd_mkinvalid() must handle swap pmds
Date: Wed, 01 May 2024 08:07:55 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <4DDEF271-9DDE-4D24-9F0C-13046CE78C6C@nvidia.com>
In-Reply-To: <0dd7827a-6334-439a-8fd0-43c98e6af22b@arm.com>
References: <20240430133138.732088-1-ryan.roberts@arm.com>
 <9fb15315-6317-4bf4-a736-a8a44288b0c2@arm.com>
 <0dd7827a-6334-439a-8fd0-43c98e6af22b@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_055327EB-2B60-4D03-A24D-E7D51C0333A6_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0275.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::10) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 3969ba74-d67e-49d2-f24f-08dc69d75738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iLgoAfp8ddmBFqJujZGeMIuKP4qq5NrmN17o8IAyHDS1RTqA7FNPdMbVmfJT?=
 =?us-ascii?Q?5mrrYURknb0SOWq5v6XWs1wkN2MbXP3h0RYWLy/wBGjPjM4y/6HC4yCoSsfa?=
 =?us-ascii?Q?6/gnOJHydKzhDhthtJWacdTw8ckM/KwADOB6NdhZuXZaxYGC6YHT7UqyGN40?=
 =?us-ascii?Q?lI+aW/KdSyrjArSAqEx9rB74/+SiNHMOZZWjrqF8vtb1kODYbkfqnPgpB+fR?=
 =?us-ascii?Q?EgA+FRbJsKcqum511Ojkg5bEuhSBhsjnXF5tUaC7Ye42Wfwz0JRYUC9+/Ltv?=
 =?us-ascii?Q?onvO5h/YLn5HpTvxTSpV3WBJibvqjJ0xPn1ustxgXo6b6NvpE/hfh2Q1wZH1?=
 =?us-ascii?Q?M9PibXt9B8PsT/kC/H9tY2/bPXugL/c8aJEFHcTQF3yPbL9SRVyFP5xwq38t?=
 =?us-ascii?Q?rcFVIWsk72Pj3tO7duQzmfxy6TkJ6pTwrvM5uW5j2k7J45CkxoPrVbt5OHQs?=
 =?us-ascii?Q?DnOqJ3mmeJK4/1H9H6zhEgsEu5AIYHzTzGFJsbcy2DaNIZs8k0OwTpCqO2cH?=
 =?us-ascii?Q?4ojG8V7pXheQD0FsqwvLEHUXkTVTDu39iIB1wEUFc94TT8KEx+IqXyff70d6?=
 =?us-ascii?Q?UHlK5lMeUT5TJ8OLRsz+lLRYcZ3Lg2Fo7WJ8gngmDzWBaNWZ3TTU+R3935Do?=
 =?us-ascii?Q?14fPdK+7oXqGoZYROut5FWsrwCneA7UvoO2AvrjJ+TKIBG/M1ejCLhlVjYdZ?=
 =?us-ascii?Q?ZKjsVcKb6cJCsaI2VwEDHnForCFG62jtYgFkugj8asdEZrxuhfIAdmpWMFM/?=
 =?us-ascii?Q?+eXEPku1MbKITzsh82MLad4PSLRjXS1aGmIok6ZFyydOthYQ10+/O38EpDDI?=
 =?us-ascii?Q?79xocFyeZKA7z8COTcl2QrfgAUYtPkH3XUjyPFoiHqqq8shiBrJSv4W3FRRi?=
 =?us-ascii?Q?5n1ZVZDvgp7Inrndvp7GBpxrhu6t/Y+j8W7ej3KdVVi0OBk8uFjVAbissO0Q?=
 =?us-ascii?Q?QQ1Rdc/qEAjlT3C69lImJu5i0iaWOWBzXdPWnMGCS0R+A9xSNHZ9JbMIwsi6?=
 =?us-ascii?Q?bBjLdJw8ZkZ6F0EuidZdKU+kCRalzK+g0+Uom57enlRcP2uXV5EcLEvDNkSk?=
 =?us-ascii?Q?jNws0YXRd6V7V2pqoq/9JRdtkgBepzEF799BMbBrl8ZlM+nxJEMm6d5rp3N+?=
 =?us-ascii?Q?YHAWK/bRShmSmgegfJ+eAjU+guhzRbWGEJfJ+BATCBZdZ4ElCMFGfy36p/Hs?=
 =?us-ascii?Q?/FBHeSHz5PmijYWiT16Ch/l69ia0t0fa5Vl/pLbs6lhOLZjaoMiu5YUIytA/?=
 =?us-ascii?Q?rapTXs9Kliaqz6lqIjOxZknsrncbFU29gjdqPHQqUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nd/3NpkSPWNv+0T3pXboeianVuWgENUFROtTJXfSZUVGC2Ju/FjJmQMXpaO+?=
 =?us-ascii?Q?oTTecbAoCrA4RvXxj20dvvpAYUZ2reCVhXrsqUvx1ZGfz7BTQzEpsA219QsR?=
 =?us-ascii?Q?tuGh20CKZ3JZo0YUivrgyjp0XUOUlIF6aPrvoy4ZO1m+Lwva17okEtujOW9r?=
 =?us-ascii?Q?adx8LKD9G22EYl/V10onaDcTyoKO3LWW8Yysgxh9TEuLg260uc0AngJeMEL1?=
 =?us-ascii?Q?OhNiYf9MPKQLOBQCA8v3xadRoH9O52lLYNXpyUBaab+okp5iLdvMCamFbx9w?=
 =?us-ascii?Q?31Rx1ixh/buVAApPDpWNHH4fvXZHnbqszbpgP7N2wLjYuIa8r4+d5gR62gUh?=
 =?us-ascii?Q?4DjiNCN+xKe4hcPl2CPbYozxExa51IRm62ankzFLgeKzjB/ANkULxO5Spnvq?=
 =?us-ascii?Q?xLroPECDnUuVCfe19tF6RJ3XBVm11nZHrzZgLvVT2IcA2BD1UwZQfpGatPdb?=
 =?us-ascii?Q?kIBOA1kXp/u9rMlcAnI/yEzCHmVMjnJuUA1MNDEi+QZDBeb0PIWt0gwRMAMN?=
 =?us-ascii?Q?zeiiRQ18Ffzf7r/5BnZYnskrHx75Egc+Rm/cYXjRN2Z7Pp4pbIauxy4wp3tL?=
 =?us-ascii?Q?fqbqbXGvwBQjHs6jgxXW2+D0DaljnoH27fIt93PN/U9kyeZcSDx7cnZpNkvA?=
 =?us-ascii?Q?IpdObPs+06IRaVQDeJLIiRN2g7uQA87NXIdEkO3TCN8hHcKQWLlRH90xx8Zv?=
 =?us-ascii?Q?Bp+RCpPJF60tUxMKtpvB3bh71p77r4k12g+qH8bcypofucxqBkPupxnJj7FG?=
 =?us-ascii?Q?Pv6RvMlE5Pvn4lvJXrmFQ1OGIBD+65cxvbwAs0d906XGBufzutP7sHXLF1/9?=
 =?us-ascii?Q?ZR55n3hMTaZ4NHv91/HIlBju2INxDTJw6qJR5e4ZoBqzOg9SIy1hX4c2k0hm?=
 =?us-ascii?Q?lYaDN+W9ZOs5XBMgrzZ8DxOhnQmXvQ6nz0uTiTe5K9NIR6Lsdw+bV08dVO5o?=
 =?us-ascii?Q?vJmK0hzDTMnH3PbXwhcbGNEF0k32VYDAxfrTHDlSS/750HxndN6Roanjn7wI?=
 =?us-ascii?Q?ZnWEAqSgN+z6rQ1mO/eS2xHCWl5h84zODvJKphJoE6CojJh8sDXbHUecFhJI?=
 =?us-ascii?Q?xbCEKJO5pZuRvYT3DI7TZpClFTFsDu+eivIJ3AZPJSHpUfJzXjRqHnKGaAlI?=
 =?us-ascii?Q?n7dp/a0QaAND9IwlrH+w1DI6QYXww2NZK6i5Sh18yiO0WoXJS6xNHE2b5Jb3?=
 =?us-ascii?Q?EF2onBJQeTYYyEDsKBEbT6n/PITrK13KOF2WCQznkFcivo5YqeRXlmY80FQ9?=
 =?us-ascii?Q?aCIi2HBTxXlpoHLsfFQIutLxhZ0cQHhb4lM3frl0RNTsOzK6dTD19Fk6WEh3?=
 =?us-ascii?Q?y++33V6R951rWLWeZk7t6b4wdDr/6QP1RIkdZvJ6zrag5ZElykQaPgQEICNa?=
 =?us-ascii?Q?m0wG+uekY/Oe4CmGywBX28T8ppLXd7/glXBJzwvtuGMjPeiN8FAaMrva0/NQ?=
 =?us-ascii?Q?8wP9bkKgR5DjlIMQtdSTAisZOxZ8+oUZ1eMN473y5YGP3Q3KrypUvJIMfMUs?=
 =?us-ascii?Q?vWEsD1fIl0Mkly6tninfWuaRRJDVURxu5KOzaDaWOoJv/8NzN8DW1U60l+CS?=
 =?us-ascii?Q?8xeykDW3QGwdz0aGbscxqDz7xeX1ovgJRANubvDL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3969ba74-d67e-49d2-f24f-08dc69d75738
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:07:58.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bN0YtbPs+MxFfBjdldiVUl27PNiqmktpEsj3sMHqQRdGivhMWUEKsGHtvHWFQeZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239

--=_MailMate_055327EB-2B60-4D03-A24D-E7D51C0333A6_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 1 May 2024, at 7:38, Ryan Roberts wrote:

> Pulling in David, who may be able to advise...
>
>
> On 01/05/2024 12:35, Ryan Roberts wrote:
>> Zi Yan, I'm hoping you might have some input on the below...
>>
>>
>> On 30/04/2024 14:31, Ryan Roberts wrote:
>>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>>> (non-present) migration entry. It calls pmdp_invalidate()
>>> unconditionally on the pmdp and only determines if it is present or n=
ot
>>> based on the returned old pmd.
>>>
>>> But arm64's pmd_mkinvalid(), called by pmdp_invalidate(),
>>> unconditionally sets the PMD_PRESENT_INVALID flag, which causes futur=
e
>>> pmd_present() calls to return true - even for a swap pmd. Therefore a=
ny
>>> lockless pgtable walker could see the migration entry pmd in this sta=
te
>>> and start interpretting the fields (e.g. pmd_pfn()) as if it were
>>> present, leading to BadThings (TM). GUP-fast appears to be one such
>>> lockless pgtable walker.
>>>
>>> While the obvious fix is for core-mm to avoid such calls for non-pres=
ent
>>> pmds (pmdp_invalidate() will also issue TLBI which is not necessary f=
or
>>> this case either), all other arches that implement pmd_mkinvalid() do=
 it
>>> in such a way that it is robust to being called with a non-present pm=
d.
>>
>> OK the plot thickens; The tests I wrote to check that pmd_mkinvalid() =
is safe for swap entries fails on x86_64. See below...
>>
>>> So it is simpler and safer to make arm64 robust too. This approach me=
ans
>>> we can even add tests to debug_vm_pgtable.c to validate the required
>>> behaviour.
>>>
>>> This is a theoretical bug found during code review. I don't have any
>>> test case to trigger it in practice.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 53fa117bb33c ("arm64/mm: Enable THP migration")
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>
>>> Hi all,
>>>
>>> v1 of this fix [1] took the approach of fixing core-mm to never call
>>> pmdp_invalidate() on a non-present pmd. But Zi Yan highlighted that o=
nly arm64
>>> suffers this problem; all other arches are robust. So his suggestion =
was to
>>> instead make arm64 robust in the same way and add tests to validate i=
t. Despite
>>> my stated reservations in the context of the v1 discussion, having th=
ought on it
>>> for a bit, I now agree with Zi Yan. Hence this post.
>>>
>>> Andrew has v1 in mm-unstable at the moment, so probably the best thin=
g to do is
>>> remove it from there and have this go in through the arm64 tree? Assu=
ming there
>>> is agreement that this approach is right one.
>>>
>>> This applies on top of v6.9-rc5. Passes all the mm selftests on arm64=
=2E
>>>
>>> [1] https://lore.kernel.org/linux-mm/20240425170704.3379492-1-ryan.ro=
berts@arm.com/
>>>
>>> Thanks,
>>> Ryan
>>>
>>>
>>>  arch/arm64/include/asm/pgtable.h | 12 +++++--
>>>  mm/debug_vm_pgtable.c            | 61 ++++++++++++++++++++++++++++++=
++
>>>  2 files changed, 71 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/as=
m/pgtable.h
>>> index afdd56d26ad7..7d580271a46d 100644
>>> --- a/arch/arm64/include/asm/pgtable.h
>>> +++ b/arch/arm64/include/asm/pgtable.h
>>> @@ -511,8 +511,16 @@ static inline int pmd_trans_huge(pmd_t pmd)
>>>
>>>  static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>>>  {
>>> -	pmd =3D set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
>>> -	pmd =3D clear_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
>>> +	/*
>>> +	 * If not valid then either we are already present-invalid or we ar=
e
>>> +	 * not-present (i.e. none or swap entry). We must not convert
>>> +	 * not-present to present-invalid. Unbelievably, the core-mm may ca=
ll
>>> +	 * pmd_mkinvalid() for a swap entry and all other arches can handle=
 it.
>>> +	 */
>>> +	if (pmd_valid(pmd)) {
>>> +		pmd =3D set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
>>> +		pmd =3D clear_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
>>> +	}
>>>
>>>  	return pmd;
>>>  }
>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>> index 65c19025da3d..7e9c387d06b0 100644
>>> --- a/mm/debug_vm_pgtable.c
>>> +++ b/mm/debug_vm_pgtable.c
>>> @@ -956,6 +956,65 @@ static void __init hugetlb_basic_tests(struct pg=
table_debug_args *args) { }
>>>  #endif /* CONFIG_HUGETLB_PAGE */
>>>
>>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +#if !defined(__HAVE_ARCH_PMDP_INVALIDATE) && defined(CONFIG_ARCH_ENA=
BLE_THP_MIGRATION)
>>> +static void __init swp_pmd_mkinvalid_tests(struct pgtable_debug_args=
 *args)
>>> +{
>>
>> Printing various values at different locations in this function for de=
bug:
>>
>>> +	unsigned long max_swap_offset;
>>> +	swp_entry_t swp_set, swp_clear, swp_convert;
>>> +	pmd_t pmd_set, pmd_clear;
>>> +
>>> +	/*
>>> +	 * See generic_max_swapfile_size(): probe the maximum offset, then
>>> +	 * create swap entry will all possible bits set and a swap entry wi=
ll
>>> +	 * all bits clear.
>>> +	 */
>>> +	max_swap_offset =3D swp_offset(pmd_to_swp_entry(swp_entry_to_pmd(sw=
p_entry(0, ~0UL))));
>>> +	swp_set =3D swp_entry((1 << MAX_SWAPFILES_SHIFT) - 1, max_swap_offs=
et);
>>> +	swp_clear =3D swp_entry(0, 0);
>>> +
>>> +	/* Convert to pmd. */
>>> +	pmd_set =3D swp_entry_to_pmd(swp_set);
>>> +	pmd_clear =3D swp_entry_to_pmd(swp_clear);
>>
>> [    0.702163] debug_vm_pgtable: [swp_pmd_mkinvalid_tests  ]: valid: p=
md_set=3Df800000000000000, pmd_clear=3D7fffffffffffe00
>>
>>> +
>>> +	/*
>>> +	 * Sanity check that the pmds are not-present, not-huge and swap en=
try
>>> +	 * is recoverable without corruption.
>>> +	 */
>>> +	WARN_ON(pmd_present(pmd_set));
>>> +	WARN_ON(pmd_trans_huge(pmd_set));
>>> +	swp_convert =3D pmd_to_swp_entry(pmd_set);
>>> +	WARN_ON(swp_type(swp_set) !=3D swp_type(swp_convert));
>>> +	WARN_ON(swp_offset(swp_set) !=3D swp_offset(swp_convert));
>>> +	WARN_ON(pmd_present(pmd_clear));
>>> +	WARN_ON(pmd_trans_huge(pmd_clear));
>>> +	swp_convert =3D pmd_to_swp_entry(pmd_clear);
>>> +	WARN_ON(swp_type(swp_clear) !=3D swp_type(swp_convert));
>>> +	WARN_ON(swp_offset(swp_clear) !=3D swp_offset(swp_convert));
>>> +
>>> +	/* Now invalidate the pmd. */
>>> +	pmd_set =3D pmd_mkinvalid(pmd_set);
>>> +	pmd_clear =3D pmd_mkinvalid(pmd_clear);
>>
>> [    0.704452] debug_vm_pgtable: [swp_pmd_mkinvalid_tests  ]: invalid:=
 pmd_set=3Df800000000000000, pmd_clear=3D7ffffffffe00e00
>>
>>> +
>>> +	/*
>>> +	 * Since its a swap pmd, invalidation should effectively be a noop =
and
>>> +	 * the checks we already did should give the same answer. Check the=

>>> +	 * invalidation didn't corrupt any fields.
>>> +	 */
>>> +	WARN_ON(pmd_present(pmd_set));
>>> +	WARN_ON(pmd_trans_huge(pmd_set));
>>> +	swp_convert =3D pmd_to_swp_entry(pmd_set);
>>
>> [    0.706461] debug_vm_pgtable: [swp_pmd_mkinvalid_tests  ]: set: swp=
=3D7c03ffffffffffff (1f, 3ffffffffffff), convert=3D7c03ffffffffffff (1f, =
3ffffffffffff)
>>
>>> +	WARN_ON(swp_type(swp_set) !=3D swp_type(swp_convert));
>>> +	WARN_ON(swp_offset(swp_set) !=3D swp_offset(swp_convert));
>>> +	WARN_ON(pmd_present(pmd_clear));
>>> +	WARN_ON(pmd_trans_huge(pmd_clear));
>>> +	swp_convert =3D pmd_to_swp_entry(pmd_clear);
>>
>> [    0.708841] debug_vm_pgtable: [swp_pmd_mkinvalid_tests  ]: clear: s=
wp=3D0 (0, 0), convert=3Dff8 (0, ff8)
>>
>>> +	WARN_ON(swp_type(swp_clear) !=3D swp_type(swp_convert));
>>> +	WARN_ON(swp_offset(swp_clear) !=3D swp_offset(swp_convert));
>>
>> This line fails on x86_64.
>>
>> The logs show that the offset is indeed being corrupted by pmd_mkinval=
id(); 0 -> 0xff8.
>>
>> I think this is due to x86's pmd_mkinvalid() assuming the pmd is prese=
nt; pmd_flags() and pmd_pfn() do all sorts of weird and wonderful things.=

>>
>> So does this take us full circle? Are we now back to modifying the cor=
e-mm to never call pmd_mkinvalid() on a non-present entry? If so, then I =
guess we should remove the arm64 fix from for-next/fixes.

If x86_64's pmd_mkinvalid() also corrupts swap entries, yes, your origina=
l fix
is better. I will dig into the x86 code more to figure out what goes wron=
g.
Last time, I only checked PAGE_* bits in these pmd|pte_* operations.
Sorry for the misinformation.

>>
>>> +}
>>> +#else
>>> +static void __init swp_pmd_mkinvalid_tests(struct pgtable_debug_args=
 *args) { }
>>> +#endif /* !__HAVE_ARCH_PMDP_INVALIDATE && CONFIG_ARCH_ENABLE_THP_MIG=
RATION */
>>> +
>>>  static void __init pmd_thp_tests(struct pgtable_debug_args *args)
>>>  {
>>>  	pmd_t pmd;
>>> @@ -982,6 +1041,8 @@ static void __init pmd_thp_tests(struct pgtable_=
debug_args *args)
>>>  	WARN_ON(!pmd_trans_huge(pmd_mkinvalid(pmd_mkhuge(pmd))));
>>>  	WARN_ON(!pmd_present(pmd_mkinvalid(pmd_mkhuge(pmd))));
>>>  #endif /* __HAVE_ARCH_PMDP_INVALIDATE */
>>> +
>>> +	swp_pmd_mkinvalid_tests(args);
>>>  }
>>>
>>>  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>>> --
>>> 2.25.1
>>>
>>


--
Best Regards,
Yan, Zi

--=_MailMate_055327EB-2B60-4D03-A24D-E7D51C0333A6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYyMJsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUo9EQAJFjje6AoLMG26FcAmj1GRYwl2hSidWy00ww
rihffr+GfO42QRKUW3BUf/rU76POuOwr3bpFetMLK7hyCQq8xTLc91buU6pjq5wR
Y7uzFmPD5G0AZUK+kYq/q+FYmX/tKFaIQjY5gtN/Aw6JNL1MUWiC8XGjHSlswZ2n
s7dpmHfFdmvtCpmkyzsMxnG/ZAXTPGVR+rAPwGLtgXkmeUN0jR91FZ/9tyJ19ZPC
GVojy+Qj9Ain1f0UITDnJDuRB7wyRZLHHeX57InyNTmi831PjEOxYqXWHcrO1yRm
i5BVtSfQc2NiStX1Ji1KVQYxmH2YPztNXOG9fbBhF5LWE7adrX7aD3BeuYAHlgaU
F6f27INZD5sY3WcL2QbvlUiYuFYuChV/2kmSTUuVY3hzwteZIxz8MQGfx8U8v6Ha
/4QgTN9RyEa+bXFxvQTwf/DBia/FDtpQ8k22CpvsbrM5jI8W+d+4TGtbeCOu26At
sP+72j22MQGEtozracWMSneYEdGsboXsdcEDYTChKOgvpDutf3jiUGAudV2tXD9s
hLS0ZXLtahef/pBA6l3lrocoZQPNlGdB9oyiLXKuZAhxFpnN1bujwDgBm53nd1Uw
4NeVFQqpMRbQ7tN8Y76VReg0atjAzWZiM1JmahHiyMLlijX12kVgrbo2HEkvhCoK
Wj+/xX4d
=rN4U
-----END PGP SIGNATURE-----

--=_MailMate_055327EB-2B60-4D03-A24D-E7D51C0333A6_=--

