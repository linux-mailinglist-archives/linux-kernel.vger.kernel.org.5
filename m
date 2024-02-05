Return-Path: <linux-kernel+bounces-52804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A14849CD5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F67328127A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D722208CF;
	Mon,  5 Feb 2024 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K2HVeP0d"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2B22EF0
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142709; cv=fail; b=lyFAmdWKHlbTcftzQJAJ3RSqdd+INN0w1ViDpzZkOfNToutNCV7f+H4rw05PuLMM0VlKnUA7rHYuB5fnhAcoKKRZrwhXnBfDzqEuDv9SBGLBdoLc4HPEouA/KcYHRav403uL4zveZi8JO3b0v1z8o+Ny1fxOX2TV3BCHGZ3X5G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142709; c=relaxed/simple;
	bh=pSFNPgRJfy4WSLEP+7+w0D05fO90c1ULyNTlPfDE1Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=times5alEPFO6/NblJXKLMptrF+86dYsDzbrIJk/VZ3c3KiVkA7nkyk6oe4Dx8/LutT5/jxQk5udR2z3vwAGY/YUJRQtIzTjWpxHSFwAXD51NSCbEkrplVFrPlggVAA26EVVyfLGJfTVjMn2g4gMqIakKZRbH0zptEsFSojhijg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K2HVeP0d; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsxQ5InHJYyFnmUr+SG82a4VDUR58rdfd43Qkxrf+idcQGKqhv5irjjbjcyixsWLqRnH5O2ZNLVPHyknksysCMxuuiQJKFMt78hB18OlgmFc3FfehzlnYMA6NVP2Fn+pUhSqGf2ENygjUNn0cvo0Okc9vj9VKCWc/s51y+ZjuV8D2C1mRkA5fVYctivNdjX5LM+fZt4bAGxBCB8Fxg/5wdYGjwNgCCeMx+HNE1hM1AOAoVtcgHahq6L42MmUakIWMh3vNTxCSjxn4LmR28R9EFQO0X7BQhgW7mHCCkD6FAG/2Q1piju/KVylXQgAezIhr203cLMZpATLAiLl6/eFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSFNPgRJfy4WSLEP+7+w0D05fO90c1ULyNTlPfDE1Ag=;
 b=MnseyxPk8QWlpihuqk5/3ya5rAXWuDYR+uJM0MwhbLdjkWU5TqxiRN0WT9VgF1OdMq0M/uUVXLVm8X7tQ1yoEae78LRq/GQxTnhiiCUredC6S0oKXhGS3kT1tbGSqf2bLOXfpGmhxqiOt4xFJ8CeroVCO8SGTTRE8CgQN9QRQocgmNFIoMz28MsI1Bis6MnJZPV83PocLitQqyBxQOJ1jSkjTizh6vuxkSPVBpjknYLMFwCeVS19sEfvHGqux9dmK3KUjqBj/24zOy9gxOw00bTEK2vXe1HjiH5DM7+hVenD/V+tD8jhsr6AfRKZ/fvIVV3EVIt4GrWQ2cE/J9iqHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSFNPgRJfy4WSLEP+7+w0D05fO90c1ULyNTlPfDE1Ag=;
 b=K2HVeP0dm58ETOgproc+uOGwNpxTWFLUQnYKiVjOY4opehkqosCku6KzwK98m48gt6u16/kmrBez7Qpb7dwsgXF9lmo0nrQVQRYeNBw18cOf1FvVm9gNgr/J0Em+w/HqY5Qwlbxase7sh+VqwnlQi02gPDzw3or89KpzAErKtmPYh2tF1teuYzIO/b1+/FCBN9g6VInLvpmZ1zshx7OISMFZVsHg5E/e50+rzFrPEojmZKXeOWdGGUZHTLm7N43P+IAFBRkQTpIwlhtNTasidBFsG57I+KK+pqaEDpxIkqJHoh+ufIBie5tgGf21vHA5XO+3JiB69FlF7Dj30K4qtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.15; Mon, 5 Feb 2024 14:18:23 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%4]) with mapi id 15.20.7270.012; Mon, 5 Feb 2024
 14:18:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "\"Huang, Ying\"" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v3 0/3] Enable >0 order folio memory compaction
Date: Mon, 05 Feb 2024 09:18:20 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <9E4B4BE2-0A00-4D76-A0A2-8EA67BBEEBDA@nvidia.com>
In-Reply-To: <36d709fb-967c-42fa-a47a-465e29e13ef6@linux.alibaba.com>
References: <20240202161554.565023-1-zi.yan@sent.com>
 <36d709fb-967c-42fa-a47a-465e29e13ef6@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_93F9D700-CF0D-4982-BD69-0710D70938B2_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0049.namprd20.prod.outlook.com
 (2603:10b6:208:235::18) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 0016c28e-8e0d-4d29-52a1-08dc26554f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zcudjFt30Rqcv0PhFlFQnJKynnGxBcXijzaBdmISgWVBaqMEp55/Y5Fsw4YPQwh5Z6cXVr8rPo5MpW0YLoAMIM7JI38/2WqPF4HUG1amkKwX1AAmTb13k8zXkp4MxCSzsd3Vkwci15KwUUnzt0CuV7W1HQvSgourklcnTmS7dl4KiOKLEg5lvQPWLch4ITDctR62rJLSNLzHSMEQ4cqvTZ4ctxaQBEzt3kGD6BXpk1qusrucuYl8RnQ9qfH7xf6VHQc+S/b4hFsp2LOTzrEU1HWPik7xwPADND3erkEHncr+D+EGUdxP2I5XJR7JIaJKwxPuNB9MoNZw3kQTiZ/YcsAjjpzqAwz+cP9UCFHFMh28gYzoT8VKNzP4+I+DN3rYhMXngDARbITNOY+XofjabJQhwa9FrcrQnl1wO4IjT7KIZOVk7ofWYSpsXR+xse9tXITkSVfcd5oRHQg384+gKebZsjnoR+A5SQEBsMdZdLe9itXbXnRnqyjtwbjmwIpZjgIal9o7adQ1dMODhVMIPLkFonOIoo/v30AWf8MXoOiaJq+OsCzuur1f0daLRBwM6z4BRPi7dymJMh/h8f9hxsoD9BAkuFPPkbgRcjt4AB3qRQ/YQ9XmU5rS2CjuxS0V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(2906002)(8936002)(4326008)(66556008)(8676002)(235185007)(5660300002)(33656002)(7416002)(66946007)(66476007)(6916009)(54906003)(316002)(86362001)(36756003)(38100700002)(6486002)(53546011)(6506007)(478600001)(26005)(6512007)(83380400001)(2616005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U5sVzGJLzAx/F4Tvywu6xQIdIZRwrc0X6weYl7XCxnoNz4AI+yGPLACGcqWC?=
 =?us-ascii?Q?jsCwk6UcjN5rTHCScObKzJMe95vCMjc7eZArFfRQrl5q+q/6NdBvjM0SEDE5?=
 =?us-ascii?Q?272ngMU0Sazd7vtJPIQEx3fc3VlCNnnt5NFJuTPrjLR8o6NUzhRbOBiDldgP?=
 =?us-ascii?Q?eDJSMhOCJggZQ+QVO0vVVUO8QHrVYBuHrOnHmalsq4fUVmIntI5dJg+gnve6?=
 =?us-ascii?Q?pZJCLYeHTy93jGJD+Ksvie9eajd22R+YrRE38VTLRT/33wIqNdu+Cp5LguOt?=
 =?us-ascii?Q?jHjazXAidNjOvjFWQUJCqjKO2QFmU9W6vgs33qRqMasPrhQ/Q0h95XHR/Ot8?=
 =?us-ascii?Q?JNiySStI+ar9awwQCzb/5n9kedR4IKrgbKePtr2jNbTSk9VYpeBu4gUGrbPc?=
 =?us-ascii?Q?IGgEGvm5kIcYToyCjBTUgyIamBfp06aRMhcA5HDeXY/Wikrb7hhexvOE0dko?=
 =?us-ascii?Q?q4dIt0vfrS1yAEwcZdITnU4KQvnCT+XouZAjUCOhHMcqQ5rVQmhtad5//YxY?=
 =?us-ascii?Q?feffJWDqKHoLJGQZqE3hRA/OQ9MUQDt1Pb0iX1W3y+kZb1I8nzkpiMxBeYk+?=
 =?us-ascii?Q?yEih8FIo8boFY/KyfyKSzp65aVkpATK/LO9P8mlXrqGJmDvT9xk22NJrxinw?=
 =?us-ascii?Q?frWAe7tWVIliihFLFs7Gzenr3da4H8poNcUyO2M8269G9XDp8svdvgHOo19t?=
 =?us-ascii?Q?2WzquQvVTe82BZjgbkzpmOER+Z6lgp+ipJ+Vm8NsRuPvfY1qWdglbIwhoRbm?=
 =?us-ascii?Q?smX9ETQ2h9/KPQmPHSqZxv5JQkeG4Gf93Wfv/GypD5UOPQsONhwESXak6Wna?=
 =?us-ascii?Q?mUeeXoSvqT+ExWekCp6eif3R3mAmZh7i8iwxPsdHYdZGG9nsXCJfA/h47SoG?=
 =?us-ascii?Q?T2AJC46Jl4oIRkwL8OFJvFpfjtpipYn3JpTTEbf1QLM/FE/G/pBWuMxW7x7I?=
 =?us-ascii?Q?YqP6s+LxA6ppvUMt0jw2KySE9nt4yCPWun0KsFSi8xu4Q5MjSCFCK+Rgzfr9?=
 =?us-ascii?Q?CLHUJm4716ZE9muvi/IxcGWYBRcIKz3IEsbd5iNRDtPfzMgCzb47LZ9+ZtTr?=
 =?us-ascii?Q?iW/kjPG8JGQUhpvB8f5+Vn3bnY18YAR0yLwLbHImkOozEs8zUvX2Vl+Xsp7h?=
 =?us-ascii?Q?2VwRprnyWLenQFAW2penLUe56pDDxmLl8sZAIGDN0ZL8dDCJaJIcW0/H8L/6?=
 =?us-ascii?Q?WwzI/nopApoKzq8bwdjAvdg7dzeTrzfA5j9Xzz5Ou+7k0hJ9TMF15QnFUUxL?=
 =?us-ascii?Q?xTZ7TuIDuV8Vg3G5QaNK4+F50xYYhr0Z5quBtLrvJKl7E8KPqLwvQBl9uziy?=
 =?us-ascii?Q?WNqpZngTNh8oxIyfmGDziYCHVBYllzdGewjBUerM9e1WCxGLfYBh8c/iLpV/?=
 =?us-ascii?Q?pMfxRaOT6kPOijZOGNywk83dz7i5DG+mUt+pp7uz9lmicI0P/RmifrYOBw2/?=
 =?us-ascii?Q?XbmTbcfHlLYRd3NwNeZLn+CfkvxjnAFBvMzVVqqPJkePeCCGO51RM4xH7PJO?=
 =?us-ascii?Q?iVcjODUNpTnXjww65J5a1jejYd6o2SRb5UdKKSZkkjmEnIAp+SnrNUl4A1r3?=
 =?us-ascii?Q?unNnrh4ttivYrIIdVzE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0016c28e-8e0d-4d29-52a1-08dc26554f9c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 14:18:23.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ey4v84UYTtuCMuK/OlEsB4aXL45tKZKbo5gvG09ydmMVEyLdBSHr2gs6vAC1m9f8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070

--=_MailMate_93F9D700-CF0D-4982-BD69-0710D70938B2_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 5 Feb 2024, at 3:16, Baolin Wang wrote:

> On 2/3/2024 12:15 AM, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Hi all,
>>
>> This patchset enables >0 order folio memory compaction, which is one o=
f
>> the prerequisitions for large folio support[1]. It includes the fix[4]=
 for
>> V2 and is on top of mm-everything-2024-01-29-07-19.
>>
>> I am aware of that split free pages is necessary for folio
>> migration in compaction, since if >0 order free pages are never split
>> and no order-0 free page is scanned, compaction will end prematurely d=
ue
>> to migration returns -ENOMEM. Free page split becomes a must instead o=
f
>> an optimization.
>>
>> lkp ncompare results for default LRU (-no-mglru) and CONFIG_LRU_GEN ar=
e
>> shown at the bottom (on a 8-CPU (Intel Xeon E5-2650 v4 @ 2.20GHz) 16G =
VM).
>> In sum, most of vm-scalability applications do not see performance cha=
nge,
>> and the others see ~4% to ~26% performance boost under default LRU and=

>> ~2% to ~6% performance boost under CONFIG_LRU_GEN.
>
> For the whole series, looks good to me. And I did not find any regressi=
on after running thpcompact. So feel free to add:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thank you for the review and testing.

--
Best Regards,
Yan, Zi

--=_MailMate_93F9D700-CF0D-4982-BD69-0710D70938B2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXA7iwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUZrYP+wRGXfeWoSNa8mVuDhnRtrMzBQm2Zvq5dSs+
1TESZ2DebfMqlVbVOYq+KSeTKwthCKdjc/FQdPosLMkVVB8VISK2cj8hOJH8FEgH
wlxM/QVipm9dRaD5ICZjY4eojphpcblCZUUHpu7am5rtBHXW8Iu2njbI+Mcy61vM
6OCLxQd3hEBZXczoQxj1/6oaNraOG1mszJj+4XccE+drQzfICB81JwLQXnyHAH8H
8m4mpJxcNthXat4b6xiJWZqf2xmCxfHNvMmgVQD6A+yCrs3EKiEFnfmKSKhiKIQQ
6dT/qXexLKKxZ5J/hKuFw5JoRqb0hEL69lD+vo0KzNCYFwNm6gjDeewfo0Hr/ZO4
LNNq4A5Dq2MB8t+xBs3zZqUuNcCYom0JxgDKJON0739NRF0RewH6y2hUXhiviAvN
Dtgvr/Xx/cfRL4eBZV1ilvxdXpuJ13jq1SvrOJNhG55IENVFC0HBnllwYj91WJ1R
dQkIp4oQaA3CeElnvFMcxIWHwQQMEG2ltHVTGbrbppsXu0pkBRUEa2Q84v3q0Zb2
5wMPeamBqyKjoipy6z3LG9+C6rPV+lSUwccuiUfXDWOZmrB15RQilhW0+1GW9RzQ
xSeSz/JowOjIxgmrTPezQnwHjBZXvAmbti4QHnbg3irLqgkaD6aY/eleX9+oVJ+6
fiFwmROi
=2SXr
-----END PGP SIGNATURE-----

--=_MailMate_93F9D700-CF0D-4982-BD69-0710D70938B2_=--

