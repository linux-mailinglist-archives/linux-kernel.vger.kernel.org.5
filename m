Return-Path: <linux-kernel+bounces-160194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFF28B3A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672B828C067
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B93148825;
	Fri, 26 Apr 2024 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VsYBrvRu"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77801D52C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143207; cv=fail; b=HSPJ0qqA208AYoqhMl3FfkiE0LczkdKahT8KtCIR5/9aCI3ASMR2UGoK6nFjld2lZqMSElwM+sTkNI4nwkmRURMfYVvphOhfOVuIrnrBFJd0PoRXcfcbmKDWcQzCgpOHsU8RXNDpdMhf7QRAbZf+CzMwj1xd8z6OJddQGPjILqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143207; c=relaxed/simple;
	bh=vNLZ0OU0r5qHNN8qWukczaZ0uy7AqQUo/b9mUVl/XaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YVBongbOiAAbX3kU2CSKBdi6MtR6Eos9XrQLeIiHcqTl2Ntwnnibmq94UcXVon6nhijOnKrhBgeDePMczgpyEKLZod1LpXOfDIv8Cg13RROllAzA8PhXr8wULmsazfA5XcnvpBIXCJe2hcEJ3HOcKyAnl61PdIBvglcJCkM49fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VsYBrvRu; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APJrLR67rwUioYlB6Dv1KlneWhSzvePkfAfrXfDrY3G70bfJYAgGa9M5m01lRrfQg8xy6j5ExD//Bt9pvDNNbvYTurM9alH8jJeHrwAo26qPShf0UurDwK+EekiqoBFEK2q682maKUKhXixGj2qO2KOMA5SRALaezar1SrhvnsMbJgQMbhlS7INqn1QguHgkew/dMNrvRGwruHuNzBuIkWO+n3BKFcP2xqMV0XH5pX4heB2wZTaPhcGqf+YSOVC7Yhpk4iArQdLZUCJU4/UK5FpBgT2V/QlHT/h095gCWIFDvW0L5DPS80RLXrxYOxHRJDUeQxydDbLqum1Kj03dNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LC9QRkbaC7dMwwrvCczLpmXjtOnAuxmjt7XZyyJCQzk=;
 b=nWoUR6ImBbSpu4tADx46kpROJlhlOx+P+DSt7mF+zqJ2XMw37Gfdik7UcLqgS8ORlohiiiY2qD4RCXKpWSwcY6o2mIi2j//oxqScvHWkRc0xDQ9gtdKqJE+XmkjMuDwgJ9pK/p0aRKHmK+JuvyEr/O2bjes1tYHvTf0hW5xUaeIi8ID2IN/3FWyE/IXLWkyKgw0CXcKYlp1aabA7cpHWYo7FC2NZozAUd96tBuerqRnIC1OQMGvY/22Pa0mc51yxtlDXO/ADK1bs8u6ZcvcPbFzGpN+HRzWs6cQMqrOhVDPI+OKWCt7/xRUMkuZRZXANOuTwB8Smq//OGcguwHwEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LC9QRkbaC7dMwwrvCczLpmXjtOnAuxmjt7XZyyJCQzk=;
 b=VsYBrvRuIxGwmirrpqdQryRp4bZURfRbaVTtiJGvMIZFgToV2glao9fY+0B4S0z8SUwnqme3ijsUnQcRSeyrDBJmdogkS+YwsxZrrFSJ/O7ScZQnCmHVdCWnd63ZFrINFvO0WSYTBpPfRkjBo2kZTjQKP2PoRKogCcQ8xoDZKeH/ch6d2X2qoAaBk05GFXLw2HKWKodoMkrWkAI9RgBQ4rrNW+UhY1Mk1Jw7+UIuTmwk7RP7nHRw1R/0N5WbvhWthipQu+eeRbGo3Cx9IDwy/Hfol07/IEO6GpvsPCJrKRAteUD04VHlqtC4LxwYEdj+JShljzvdiGHNNHejb2MW4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Fri, 26 Apr 2024 14:53:22 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 14:53:22 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Fri, 26 Apr 2024 10:53:20 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <D0E6B5DC-6206-408C-81D1-C9B0A85E1D0E@nvidia.com>
In-Reply-To: <80148272-208A-4306-A8EC-98C79BBBDCA0@nvidia.com>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <39d0236c-4297-4001-bc7e-f516bc674f7b@arm.com>
 <87df74b7-2352-4ad6-b9f9-baed9291cbed@arm.com>
 <80148272-208A-4306-A8EC-98C79BBBDCA0@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_3E0BCE55-2E9E-4805-9ED0-13D11EC852D8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0066.prod.exchangelabs.com (2603:10b6:208:23f::35)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: d03c56c6-3b6b-416f-1baf-08dc66009e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RU0jIsOaQP2h2iIpWI+pWwActgMx7jrfragA7819d4MmuXr2dY32plJUJm1S?=
 =?us-ascii?Q?9vCtSObL12M0hOMY1waOgzTyGLyEU762RGybt8YnJTG0Z2dbNE1xmqFvYq11?=
 =?us-ascii?Q?JeGgHAb7Ke0fzcNT70BHocTuHSnRr8EI9g5oYvS/W8VgNiF+OGo+LJBkchyq?=
 =?us-ascii?Q?osUVBgtXYjCHimCyDbUxCLuHiKn5i6fumFS9Op9feduZHPCRcbtiPa0cew6x?=
 =?us-ascii?Q?V5tJQ4982dnisC37+nNsT+5RYAqD404yGyben9QFVj6TSGe9RrBLZRqNx0HB?=
 =?us-ascii?Q?0WG3dOFNStTBZsg7DZJuEVFQnrrM4SSOXsnp8k5sh+SlHAhVeXs5Q4bVGhDf?=
 =?us-ascii?Q?nPJW1MpUMwNJWsDtPE1QfAoF9MO0vySEWqy/5RmUM6ojy27q3DcFfumpKOFf?=
 =?us-ascii?Q?7j+PFjYDD54ZM9AepyZAMGdB2QrK3ji18J6Myi+xbIHA50hNfSWsz6q16b94?=
 =?us-ascii?Q?5Qy/tde2M2z+qoHIQMDmG3kooByV+F6Klrzt8+VXcodi4IuS1GZie5V0SQZs?=
 =?us-ascii?Q?z1k9sagUup+gasojUQdUHBlQG/fq81sbCOpD2FGciqA4UKcjU6zgBRN9C7kk?=
 =?us-ascii?Q?MKXMWsGkkKvHVtkN68Mmwk8q+OkUQPHPHXTyDmeWCV6wKxV8EwuqqCSEjB96?=
 =?us-ascii?Q?SneJNcXI5ncMdSUs+hsShN31Ym1j8nIQz1+QIXcv59RerrctKbrRm+JH8BjC?=
 =?us-ascii?Q?tn6ItqPmmlvq0bm/pOm9ySg6iayoTJYJSB7iRwjGD7HQ/5yx27c+rlmtoOgL?=
 =?us-ascii?Q?7n1LhMXJ1OjL3rzAmPaML8sRXvwpQ1vAP8XrqMsPcntS7UeWehtr7oxcvWR2?=
 =?us-ascii?Q?Ykl50EBMflsO+JxtLomq8JaNV59A468wD5U+P0WnPGIkJMedkr69vCw4GqRZ?=
 =?us-ascii?Q?41qk5q84cnfxW1TOwellGu3Hr+j3m/NOuTlN0bgraBtndZwPp0sl69zPosKz?=
 =?us-ascii?Q?O2Hh1+zauFzKKICJr2OtVtfSFrabrgMUZJBjNA0dXGXmKemP8bw/e9PdrTrY?=
 =?us-ascii?Q?gujakvg+GqdoDQuTcuD0hDj9qV3pvmspEPGfD92/yjYl+WECQKrAZIjeSvE+?=
 =?us-ascii?Q?t7CF5dovHemhorhq+5XJs9VD3Z9qRzD081B52XxQtGScR02uJJfrjei+dEJ6?=
 =?us-ascii?Q?52E2K/bbmGaKX5kwoiQsBmf3XbXyOw8fbYI6DYtG7XBnj3OLt7K3bDEkC/x8?=
 =?us-ascii?Q?0jy2Xn9wB3+9gMiMsOjmKvOIT37YEwoS05vBdYJms/ogy1u/fQTnddatcVEo?=
 =?us-ascii?Q?hlpryfoOxGahjMacBxyCPBK//3jVvpk9GfxQ3dEslg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8nXrQGC3EruM2EQhnHHy9yQSGTWqfNHQKS2QBI9QVi7rUGELYzTeGWblXN5l?=
 =?us-ascii?Q?1qsuA/broz986llrJdyv2AYjw6AeAmy/AEK8pnUGYFbW1dLpPW+a2udQ/3dB?=
 =?us-ascii?Q?WK1tfgTHh+MkxN9sG7Yf8JiBh9H+5CzQaBNuxnsOtwDmc88E4mO8gP5MCS+P?=
 =?us-ascii?Q?Po/6AgLmG8n0to/hd4N1PwAa7dzTNBU0CN0m1yK/FfniOx69f2dgYGQoLNE+?=
 =?us-ascii?Q?evEFwkqY3iBWjb/6Ycypg14xPlDcra+h53DQoebk5qWe5Q7JSM2bVZsf5iKz?=
 =?us-ascii?Q?UZsQefbI1Cwjme97FpbWPnbxdps5UJhhEhX1v/OvXtHCJntnVOb2GUbvfyNl?=
 =?us-ascii?Q?UHdhTjMjIZl2KpR77zarj9fRyM4H0x14igdzqE11GSzQ/ODwielFMh3rRPNj?=
 =?us-ascii?Q?22RYJN6ebJ663ZeyGWxy+JSEVTBmmIxVNiyk624j35BXltrpCDdnwLxOF7pP?=
 =?us-ascii?Q?rkGmZ8kWQvpQg601pA8e1TLgukwULNMqDIEke8lTbyHo/ZGv1pcg806qSZGn?=
 =?us-ascii?Q?sP5rhGNLIXTig220dL6CX1Y3IHzMhK62MVYHvys34K4GlB58sfjjRok36/wp?=
 =?us-ascii?Q?B54LP0Un4Hi4fweYxSrMfvpXbZ6jL2a8pf4ge0Y6GxVQcrr6KSpUJqJpJw3b?=
 =?us-ascii?Q?N8+L2rn0BsYmAuMmPNIUmn0BezmH6iUqWHDQ7RaQSrqt86UDxf+3wAso2TdW?=
 =?us-ascii?Q?dDxRRKfZMs/crLjMQpSJeNbruPKQQp10JuRtB5V1OYNMcVFJgA+G+NowvPqY?=
 =?us-ascii?Q?6jZzLQhiGBg6gkBWqitGE4pG2azzJAk1ih6v3CkUQJ1jWudX7R+AeOp/3b0p?=
 =?us-ascii?Q?1NYv/ZW1PQLz8P7jCbicU9EMwUgzxpGS0IRGVwEeJK9o9Flvbs7tIn7s3d1n?=
 =?us-ascii?Q?FyNbuhym+MdgRcVOfvVJaB/rV73Ht/hxmLgJclym5WsfMWW+AS7o/+rdUdqw?=
 =?us-ascii?Q?c1h43TkB7czfDpijTnpoukxdF8Nm5Hy/13xKtxzEGNBYsspLlCCG67aL3axf?=
 =?us-ascii?Q?9DWqpBzClBDGo61FEttbVt185bxtJWgolhG7W7TRBYku8H5oASf6uRxJpPnz?=
 =?us-ascii?Q?Ln5TSBNxiCvG7VE/3B79b/b6lIzC2lKQxkVLUxvnZyUiAmaO0orAAL09kYMB?=
 =?us-ascii?Q?JHGy4SwtBJqfnFAuHHnT/fGo4lsGK+WdEZFYZfp4zfsPB9B7AIxpv0/eGYwd?=
 =?us-ascii?Q?cP3ctW4K4NULQj/MmwbCe6WhAwy2LZz6/VnCTArRdiV80Aj1tAUXQIjegvGq?=
 =?us-ascii?Q?L6wULjGDVECEsTjo/aEc9KkrGPLZd3pc+W7ZK/iFCZqVUDELmnDDvfvpudLY?=
 =?us-ascii?Q?VQocg3EaCsvs9fMCnxfC9THfyqa+KnCTO39SGyeZzFc+IHTvCBRcrQut2Lfr?=
 =?us-ascii?Q?XT7Tfw9DJ9bT88kDvkZKUwPrHfJ/9dUj46bMddh5RyARAxX5UVno0PYeuaia?=
 =?us-ascii?Q?rr97mTVVM9s+38URurJjuXu/vxxvt15GhtfEvE3HguvLPaC4yyEifOf4nnje?=
 =?us-ascii?Q?Cp5i/c6PYXJJUm8bjdijm3DWUSsHZcCBOMAXrZwYWVquN9LmuU2NmVvkT+dy?=
 =?us-ascii?Q?yeCTSl0H+A2vlGJ+DaXYeiJ5cCZjdlPIh4YL6923?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03c56c6-3b6b-416f-1baf-08dc66009e2a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:53:22.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rU0bU93BanpnNR6TFF8s2z0a+2kLgnPCB++ROsfp3fPzW5priONNPytLHhpIuRGJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167

--=_MailMate_3E0BCE55-2E9E-4805-9ED0-13D11EC852D8_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Apr 2024, at 10:49, Zi Yan wrote:

> On 26 Apr 2024, at 3:43, Ryan Roberts wrote:
>
>> On 26/04/2024 05:19, Anshuman Khandual wrote:
>>> On 4/25/24 22:37, Ryan Roberts wrote:
>>>> __split_huge_pmd_locked() can be called for a present THP, devmap or=

>>>> (non-present) migration entry. It calls pmdp_invalidate()
>>>> unconditionally on the pmdp and only determines if it is present or =
not
>>>> based on the returned old pmd. This is a problem for the migration e=
ntry
>>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only =
be
>>>> called for a present pmd.
>>>
>>> pmdp_invalidate() must be called only for present PMD - is this expec=
ted
>>> by core MM ? Does this cause any problem otherwise ?
>>
>> I'm saying that only calling pmdp_invalidate() on a pte_present()=3D=3D=
true pte is
>> the only semantic that makes sense. And, yes, it causes a problem if c=
alled on a
>> pte_present()=3D=3Dfalse pte - that's exactly what I'm describing in t=
his commit log.
>>
>> To labour the point, this is the logical type hierachy of PTEs (and bl=
ock-mapped
>> PMDs) as I see it:
>>
>> ---8<----
>>
>> pte
>>  |- present
>>  |   |- valid
>>  |   |- invalid
>>  |
>>  |- not_present
>>      |- none
>>      |- swap_pte
>>
>> present: All fields must be interpretted the way the HW sees them. e.g=
=2E
>>          pte_pfn(), pte_write(), pte_dirty(), pte_young(), pte_mkwrite=
(),
>>          pte_mkold() can all be legitimately used to query and modify =
the pte.
>>
>>   valid: The HW may access the pte, interpret the fields and create a =
TLB entry,
>>          etc.
>>
>>   invalid: The HW will never access the pte or create a TLB entry for =
it.
>>
>> not_present: The fields are SW-defined. HW never accesses the PTE.
>>
>>   none: Unused; represents a hole
>>
>>   swap_pte: Contains a swap entry and swap pte bits. The contained swa=
p entry
>>             may 1 of a few different types e.g. actual swap entry, mig=
ration
>>             entry, hw poison, etc.
>>
>> ---8<----
>>
>> We test present vs not_present with pte_present()
>>
>> We test none vs swap_pte with pte_none()
>>
>> valid vs invalid is slightly more vague. The core-mm can move a PMD fr=
om valid
>> -> invalid by calling pmd_mkinvalid(). But it can't query the state. A=
nd it
>> can't do this generically for a PTE.
>>
>>
>> Based on that lot, it makes no sense to me that we should permit calli=
ng
>> pmd_mkinvalid() on a non-present pte. Indeed, we don't permit calling
>> pte_mkwrite() etc on a non-present pte. And those functions are not de=
fensive;
>> they don't check that the pte is present before making the change. The=
y just
>> trust that the core-mm will not call them for non-present ptes.
>
> I am OK with disallowing to call pmd_mkinvalid() on a non-present entry=
, but
> would like to know how to enforce it or document it. Because x86, risc-=
v, mips,
> and loongarch can call pmd_mkinvalid() on a non-present entry without c=
ausing
> any issue, any developer who work on these arches but arm64 can use pmd=
_mkinvalid()
> improperly until someone else tests it on arm64. You will need to add V=
M_WARM_ON()
> to all arch versions of pmd_mkinvalid().
>
>>
>> The alternative approach would be to make pmdp_invalidate() defensive =
so that it
>> checks the pmd is present before making any changes. But it doesn't se=
mantically
>> make sense to invalidate a non-present pmd in the first place so why c=
all it
>> under these circumstances? There is also a practical problem in that s=
ome arches
>> implement their own pmdp_invalidate() so you would want to make all th=
ose
>> defensive too, which would grow the size of the change.
>
> Like I said above, if you do not do this, other arches developers can b=
reak arm64
> without knowing it, since their pmd_mkinvalid() do not change a non-pre=
sent
> PMD to a present one.
>
>>>
>>>>
>>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>>>> future call to pmd_present() will return true. And therefore any
>>>
>>> IIRC the following semantics needs to be followed as expected by core=
 MM.
>>>
>>> ---------------------------------------------------------------------=
----
>>> |	PMD states	|	pmd_present	|	pmd_trans_huge	|
>>> ---------------------------------------------------------------------=
----
>>> |	Mapped		|	Yes		|	Yes		|
>>> ---------------------------------------------------------------------=
----
>>> |	Splitting	|	Yes		|	Yes		|
>>> ---------------------------------------------------------------------=
----
>>> |	Migration/Swap	|	No		|	No		|
>>> ---------------------------------------------------------------------=
----
>>
>> Indeed, the problem, as I see it, is if pmd_mkinvalid() is called on a=

>> "Migration/Swap" pmd, then a future call to pmd_present() will return =
Yes, which
>> is clearly wrong. pmd_trans_huge() will also return Yes due to:
>>
>> static inline int pmd_trans_huge(pmd_t pmd)
>> {
>> 	return pmd_val(pmd) && pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE=
_BIT);
>> }
>>
>> At least this happens for arm64. Although Zi suggests other arches loo=
k like
>> they will do this too in the other email.
>>
>> The reason is that arm64's pmd_mkinvalid() unconditionally sets
>> PMD_PRESENT_INVALID (bit 59) and clears PMD_SECT_VALID (bit 0) in the =
pte. So
>> next time pmd_present() is called it will see PMD_PRESENT_INVALID is s=
et and
>> return true.
>>
>>>
>>>
>>>> lockless pgtable walker could see the migration entry pmd in this st=
ate
>>>> and start interpretting the fields as if it were present, leading to=

>>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable wal=
ker.
>>>
>>> Could you please explain how bad things might happen ?
>>
>> See 2 places where pmdp_get_lockless() is called in gup.c, without the=
 PTL.
>> These could both return the swap pte for which pmd_mkinvalid() has bee=
n called.
>> In both cases, this would lead to the pmd_present() check eroneously r=
eturning
>> true, eventually causing incorrect interpretation of the pte fields. e=
=2Eg.:
>>
>> gup_pmd_range()
>>   pmd_t pmd =3D pmdp_get_lockless(pmdp);
>>   gup_huge_pmd(pmd, ...)
>>     page =3D nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT=
);
>>
>> page is guff.
>>
>> Let me know what you think!

Add JohnH to check GUP code.

>>
>> Thanks,
>> Ryan
>>
>>
>>>
>>>> I suspect the same is possible on other architectures.
>>>>
>>>> Fix this by only calling pmdp_invalidate() for a present pmd. And fo=
r
>>>> good measure let's add a warning to the generic implementation of
>>>> pmdp_invalidate(). I've manually reviewed all other
>>>> pmdp_invalidate[_ad]() call sites and believe all others to be
>>>> conformant.
>>>>
>>>> This is a theoretical bug found during code review. I don't have any=

>>>> test case to trigger it in practice.
>>>>
>>>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common p=
ath")
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>
>>>> Applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>
>>>>  mm/huge_memory.c     | 5 +++--
>>>>  mm/pgtable-generic.c | 2 ++
>>>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 89f58c7603b2..80939ad00718 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -2513,12 +2513,12 @@ static void __split_huge_pmd_locked(struct v=
m_area_struct *vma, pmd_t *pmd,
>>>>  	 * for this pmd), then we flush the SMP TLB and finally we write t=
he
>>>>  	 * non-huge version of the pmd entry with pmd_populate.
>>>>  	 */
>>>> -	old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>>>>
>>>> -	pmd_migration =3D is_pmd_migration_entry(old_pmd);
>>>> +	pmd_migration =3D is_pmd_migration_entry(*pmd);
>>>>  	if (unlikely(pmd_migration)) {
>>>>  		swp_entry_t entry;
>>>>
>>>> +		old_pmd =3D *pmd;
>>>>  		entry =3D pmd_to_swp_entry(old_pmd);
>>>>  		page =3D pfn_swap_entry_to_page(entry);
>>>>  		write =3D is_writable_migration_entry(entry);
>>>> @@ -2529,6 +2529,7 @@ static void __split_huge_pmd_locked(struct vm_=
area_struct *vma, pmd_t *pmd,
>>>>  		soft_dirty =3D pmd_swp_soft_dirty(old_pmd);
>>>>  		uffd_wp =3D pmd_swp_uffd_wp(old_pmd);
>>>>  	} else {
>>>> +		old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>>>>  		page =3D pmd_page(old_pmd);
>>>>  		folio =3D page_folio(page);
>>>>  		if (pmd_dirty(old_pmd)) {
>>>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>>>> index 4fcd959dcc4d..74e34ea90656 100644
>>>> --- a/mm/pgtable-generic.c
>>>> +++ b/mm/pgtable-generic.c
>>>> @@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_=
struct *mm, pmd_t *pmdp)
>>>>  pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long add=
ress,
>>>>  		     pmd_t *pmdp)
>>>>  {
>>>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>>>  	pmd_t old =3D pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pm=
dp));
>>>>  	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>>>  	return old;
>>>> @@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma=
, unsigned long address,
>>>>  pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long =
address,
>>>>  			 pmd_t *pmdp)
>>>>  {
>>>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>>>  	return pmdp_invalidate(vma, address, pmdp);
>>>>  }
>>>>  #endif
>>>> --
>>>> 2.25.1
>>>>
>>>>
>
>
> --
> Best Regards,
> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_3E0BCE55-2E9E-4805-9ED0-13D11EC852D8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYrv+APHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUg8MP/jKe67X8FHHriwwpD0qYLd9k1HSEjmJmvHTu
sWnjyMB4mghiOMV86ENi0TwGnnDac4kbWIW3CvUddJ5TUAk5UeKE2yw5J7XsfAmt
KQZ/ImAa8Y894w7Kr5OHnqwmwYSYUsOjmMc0qKVkSyLDQ1fkOygJDUL76VHOUn2A
tl6RrGUWIWQ2y76L3ZgniYK3NYKPvF/O2YDf6ojGf185rRFmNgWDlB8CW36RVqr8
SdkWsHH5Wy/wsh7m+G1ezqZJFBlXPBOeeWeJ0z5sIwf6kHF4tnbHXFqcpq36l4xz
aMefeNpVbTKYtcM96HFUKonpcOnZeeEX4IsTAJWOGLJbdGqmkl8aWuJi3WR9Uzqf
0M6g6xWSwz396G87zIEFVWfA+WUu25C8vWkPZfckNFmRGy+t/b7qjwm1bHZPgwkx
HOnGC/uJOeqMoR71FlhLBJHBQTR8Y6HRo4q1T9mT7BRUlsdLqrhwh26GvuMfXArL
5q3W1CKYtyTVeMDjZVtAvPipnhKMVUuSBpdBUxxmoCNY/dv2cUnKnKP7mw7ogRSE
j34p88ze10KUQK0L2N4UQrFIEOnR2BmlnOpVe9uBYl4EtLEZbBSmuPHtDZE27Btx
+RMCOlhXtP8ayTRGAIsZDuePtwpMcJk1C+j/ROPNy+0hTC1rtH+27gd1oA4vdXGw
U1C/U8Tm
=WJTd
-----END PGP SIGNATURE-----

--=_MailMate_3E0BCE55-2E9E-4805-9ED0-13D11EC852D8_=--

