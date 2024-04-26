Return-Path: <linux-kernel+bounces-160191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 557BD8B3A65
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7940A1C2104A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9051F148831;
	Fri, 26 Apr 2024 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fo0NgLtG"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6A1FC4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143009; cv=fail; b=XCSPW0gkwL+Nk4odS/wQmI88VedUgMiezSAy+qK4j0wTkNqzZ5N5jTLu/p5fWHeq86iE4TxDmrwNzEkM5XpEegcny5sjARsP80r14HFAmq7uBHFVvnAhzVoxl47497mOOLV4zEjIq52lu5APX4ce2zDdXKvPxFj70IjKe6cGuX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143009; c=relaxed/simple;
	bh=G/iQFG2HldWu2PDtOZQ5teOlq20FgM1n4OOX4lBoc1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jMjv2Jlu2e2ekYlH4kOcQG5ug0/wXG0rFt60zrak/EfBS6yaPRTCQBlV2ZwkPK3dH9ND1udrLy64aUMkJUew8xDGlvhP4TcYUrdk2flGxWWY45T2zG03g8X1qxnJSP020cEU/oKFRcJiIjRNj3l6XJlYYuN66/PMFCdbomok2wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fo0NgLtG; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHy31AXQSLpTG2vX0Z2huPDAEQR+XS+80H+9Mox9JxmXla6voT0MHI/SIkGQJa4GzqTdwG1GDTFLoTzcltjqKKEDW0GaCjKVObYan3L61M4b+4dXMSLihI0G2y26JHDzpPtdz7qaLRWGfUe/Q+PxxQQIfzIPcVXbdibY4ZGq+KiEWrxkwC/fCmp1TLu4dIjnn9hcKyKcL7ahuvehAQONqywhIpP2QotUZ11xWJBLIBbM+w5jgA6USAYqZC1Vp24AyTh/73uY9Q7ebqo0EyF6H0+PH7Vf4EH5sxIEnkqBsB9rVo5N/GzVN4KrQm6Xf4ZpTpmqHsGkIMtv+d74yi7Tzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEIpYC3SWB6dhLrZN4m7cqebR6l02AWPpbCjSx8ZWY8=;
 b=EliA+C/qzDQmDcdgySilMcZy0S+CYVNua8qrhSk+0I5yWeBJZXNHwnEGN7QY+WHWqw+nRAwrjBTyWcsdFf7qYAekBiAT+Ez1gmw2OVlrZ+ik35ZwqfGVJX1kWq8OvrnYPoxz9Uw87EeE9dQeLjA2urkMxefuOzleFjaLW4sCO9xEqXAYWDFI0KdsDcIazdtaxj/NcIa2TFPmK1UQCrtnHzGYKF3Bqw7EUUGf5Fznpt2BBo0vXWhRQj+ozbmkDosphZEwJITMTeet3gsL5lZQhfVhFCcam+aD3PAo5MgK67BCaqNvrGZRQ31MCxfpRqH24o7ApmerVeDQbgliyGWLUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEIpYC3SWB6dhLrZN4m7cqebR6l02AWPpbCjSx8ZWY8=;
 b=Fo0NgLtG8mkTADewW3GcAOl+ERuXzB94ZDYZRQF0jj+I43a21LYsWFfgyPd+fSeW8NKYyMJyqnSx7dmRU0jTNlPa20iTPNawYTF6argvSA14N6OF2iEEMwSyrKd6pFe5YRvnld5xG+ckHeAq7V7kgU9zr/ookNhNlEsbbWmxixI5D9X1mcq5FE2W58KVqdeHe7YkGnfi/4qUC/vTBbF8rJ60b88stq+FGZKWb2NplbCaVzdJwNwZftFnWPKKEoN+vb/LQpodl4cON7gH6k2CkPpNrVXtG1fP4F4kEyHSwOXnwVsCwwOmt3874sKFjv6rC9G8f+vDJSvRP+/nCUjhTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Fri, 26 Apr 2024 14:49:59 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 14:49:53 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Fri, 26 Apr 2024 10:49:51 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <80148272-208A-4306-A8EC-98C79BBBDCA0@nvidia.com>
In-Reply-To: <87df74b7-2352-4ad6-b9f9-baed9291cbed@arm.com>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <39d0236c-4297-4001-bc7e-f516bc674f7b@arm.com>
 <87df74b7-2352-4ad6-b9f9-baed9291cbed@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_90DF40EA-B793-4243-82C4-917DF13A8A03_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:208:fc::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 080673b2-a89d-4272-4daf-08dc660021d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JR7btkxbT9KlwTn55qnvHs+fCsbIX7tftQwsipUzCVRxpGqVvqsnF+AgX/xu?=
 =?us-ascii?Q?+3OGgAjzpuK5KKR/w7mOH7we9OIWoYrtvj//gBk1NPBdKEbxWIVEciYDRPyh?=
 =?us-ascii?Q?otW3c4aEnHInkvaQCf3Fcy7IjKyVrQT6BApj+ZTdlaE+kQAEyICK8ys53lbM?=
 =?us-ascii?Q?FqwDc/gMMiONR0GmDbeFs/ietKQ+lC3iS3IHRsi5vIyx/tEicJuCqasY+pSO?=
 =?us-ascii?Q?Hx6DS3J44cmSS+s0JACNw3OcWFsjDmEesAJTLzHUuca6C++ACBlRT0tazlIo?=
 =?us-ascii?Q?4aVTaYXYyFw9B5QDczCgAbLza4LgTTDCq5dSc7EIYeuAS8LEZQCQp3zA4cpx?=
 =?us-ascii?Q?NDaZXvUn2fqs6M3+tnumfp2W+AGlwHPmbxEhZXIuo7Iv1fMjoYVW/Gt6lnPV?=
 =?us-ascii?Q?2312ZI6zOMCg+TXzRy2Ge24v1evkxW+dmIz9BZETJgud2Xg4kfV41wr6Kr+U?=
 =?us-ascii?Q?ZqHokcmSIoSbtvl+He7Z7vVJLb8ZRWFsNumiw5zbzhRXGEuKitSUr9lN6k/x?=
 =?us-ascii?Q?i8FJQmzclm5vdq+8wxPcfBWtObwS/RbX7JCRXFuJhwQquAhmtSowkCyASGpU?=
 =?us-ascii?Q?Gc6UEWnptRZXJiDGryjEg+RgBrij7+iUH2rhsAfAP6qsfPDLgP/q9zLNlL/l?=
 =?us-ascii?Q?tgKg4NDcyVg7oGbLn7BGBDl4+v/BAh/rDdFdrRPO544amrj3/99KtckDJGvo?=
 =?us-ascii?Q?dRM6VCEn5k3fPX29Oxxu9XS+IMe2XMki80nWLPlYm3plp/y/euMcGbFm5gEu?=
 =?us-ascii?Q?kCHJpFdC78gm2FAsd7tRf6xcRawksja7c28Z18LiSc3t6upZhu4iMjyQNrJn?=
 =?us-ascii?Q?afXYWZ5g/XSTDjFHoFRynq3ggJBaT9I3tXP625hsTcQgZ7quZJ9izaWY33SY?=
 =?us-ascii?Q?s816qqCBxYObxdsAxJUE8XuDxcyOF1AEVivzn2Y4fHLBsDwsCcrX7juRjQe3?=
 =?us-ascii?Q?hiCfFcm5+COTtFvhtLu02fvECyEFBe+UoUSep4SuF70ef1jHpe7OOV83IEec?=
 =?us-ascii?Q?1H3VSCL+aPRpPF9fQ+mSap1sTOLV53DsGltM+EvW6w1O44S53djCHU+Yj7O9?=
 =?us-ascii?Q?1oeKCXvbtElVrF1HgX9DkjMRNKx1rCcQ2L7n3cgvR8tH0Ez54eLqpbd/+my2?=
 =?us-ascii?Q?SeEuhr78w2W52SK4eyEUS6puRf9L/xFBaLLw76gOGco2FaaIfSalv2E6bAKb?=
 =?us-ascii?Q?TWvVi9vRBsu94b9Yj4gu5W0SROqkTUB/Agzu28imcynMXrjerOTjrVFTkLl4?=
 =?us-ascii?Q?bymVwZNxbP5bq2MHr8IrA57NIg7qsQEv0MIAF1oNoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wqkRUmRjqC3JZxuc+obGKOK3JI5uVn7I+wIggvgRh+RrbBFvCrbidKk74R0T?=
 =?us-ascii?Q?2UVuuTNN3xYiH5qzTsA/15q8eEa2pWNuz2gQ2Ss6/kgmKKSJJ4U8wnQ8Gb12?=
 =?us-ascii?Q?VxJJLRP6ELz+Fh9AzqNMhNtulF13hv0xEzwAe5ZB6eTINyXox9v7U6L4JxuH?=
 =?us-ascii?Q?ATJ1UtCYm7mJHLTNi0mCl4G3HNDnt6rpRw0m/NGTqxHFiPrl/kyC64YI/ovh?=
 =?us-ascii?Q?vdmVOr2JKLBJTzoH+8MFOOgmIrAz8EdGqxant0ChGUhhvaBFBa5pb5HNJCgU?=
 =?us-ascii?Q?NKfIs/1mLWbs0yf+9PaZpeqgqlOzZQnVaoZQOBploEB7zT2vu16Tnfuw8Unw?=
 =?us-ascii?Q?VLhCTenHZVICbNmJFqJBEMdSbv3vkeHC4qiaoO06i/SfZxHW8BpHyEnRCUfo?=
 =?us-ascii?Q?69jnwJqi4YlonByYBEn/uHGefKfmPCM0CMm+2iHRMPoIVjISj3l8uDIm+bBV?=
 =?us-ascii?Q?1acebVopwj1Zm4m5a9iTwngtqzkUuvPAWvTvPUC48a4ThixhNP7uScVBccHo?=
 =?us-ascii?Q?E0LB1UrVi/BsEeuU63pc4BOMFTUJpL1WlfaMKCPd3twjTj3qq1/xdNeCjXx4?=
 =?us-ascii?Q?HeyTPq4Lq6AIyL20FztjRR0Uemrd3+SkUNkkFFcghPwdrqJGnD4MVtJR5WKE?=
 =?us-ascii?Q?V8xLcqsNnolFPsaMDkPKxxC0B7p0jImySsuWBVzcQZYv2Zlgsbkm7Udre+D+?=
 =?us-ascii?Q?+qKET0dJncYcfMVxhYCk3Xvdvxts6aOHLhxmLMfsXvZhkpJ3+sE7VHulHF/m?=
 =?us-ascii?Q?U7qWu3HR86tTtg+mDwMVku+axDNs56Dxnk7R72IVJ5K5ZJhzvZTwk4HENwW4?=
 =?us-ascii?Q?69iv3x3tRls9zer3+r6GLm3aLOk5b+DZMyTtsvjFLktImuTQVarT/FH+e+HB?=
 =?us-ascii?Q?53hMgDLTPnoNGwDQ0/qPDhUNATIzpiIhko58nEFd3k9P/c2zeag96X/qOYJZ?=
 =?us-ascii?Q?sQuRk16jqQQzPuGgK1PxB0CId+EkwwSsvXMopa8nwQQj0h4O2olP/mQ89JJb?=
 =?us-ascii?Q?DBJwK7KziAGB5MTzv0Vpa+tZvRa++lkyMwkG7qR4cLaoQnLIi/aFXGU4rGK/?=
 =?us-ascii?Q?M9JwlZBVN6n6mhixouwDDb9TinqxuB+6Izo82Vt0IcIal635r2NDq9o8XyW6?=
 =?us-ascii?Q?uv3mkAC+atlD3GVcVf/EvAunuWD9g/FP2p8kBbaacWNYER/P8PCSsFa5fBcP?=
 =?us-ascii?Q?MlKc13HvpIHiypfiGIrthaddU/F6y2VPxpgwL5DPQhfAgnPtaorzaokXvazG?=
 =?us-ascii?Q?kEB35QwcEz9mRxyegmG2U6BeUwJPMT/0pVYPb/Ug3NcRwvo7FZ5cvlncRNuE?=
 =?us-ascii?Q?gdMIJDFLDfkyTmWznZjCS28TkeBxRLvZbAs1zOyMuz5lHOG7XWce9M32SetM?=
 =?us-ascii?Q?nWdgglCPhftOv8bdwvDRn9imAR47kmW6LCzXo8twY/fefBslMwnPQjYAeVfs?=
 =?us-ascii?Q?M0hZ9Kn8yK2J8yztYGhESaTp7iBROwPMv8Q0UMXxpvo0Hk8IBDe76qJ8V20d?=
 =?us-ascii?Q?3tWSzUWsYijbDi7sxmqhm0GhvtnTxbsEsVHu8aLOseIcllTpCOvmkw/7sJHB?=
 =?us-ascii?Q?FQlXYJF+dLhDL8GLZ8Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080673b2-a89d-4272-4daf-08dc660021d9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:49:53.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnHOW/sUcDRdbd2QiVN4oC3djXxRBOAGScX5iTpMekWheGJRtICW59sddPm0u/gy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581

--=_MailMate_90DF40EA-B793-4243-82C4-917DF13A8A03_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Apr 2024, at 3:43, Ryan Roberts wrote:

> On 26/04/2024 05:19, Anshuman Khandual wrote:
>> On 4/25/24 22:37, Ryan Roberts wrote:
>>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>>> (non-present) migration entry. It calls pmdp_invalidate()
>>> unconditionally on the pmdp and only determines if it is present or n=
ot
>>> based on the returned old pmd. This is a problem for the migration en=
try
>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only b=
e
>>> called for a present pmd.
>>
>> pmdp_invalidate() must be called only for present PMD - is this expect=
ed
>> by core MM ? Does this cause any problem otherwise ?
>
> I'm saying that only calling pmdp_invalidate() on a pte_present()=3D=3D=
true pte is
> the only semantic that makes sense. And, yes, it causes a problem if ca=
lled on a
> pte_present()=3D=3Dfalse pte - that's exactly what I'm describing in th=
is commit log.
>
> To labour the point, this is the logical type hierachy of PTEs (and blo=
ck-mapped
> PMDs) as I see it:
>
> ---8<----
>
> pte
>  |- present
>  |   |- valid
>  |   |- invalid
>  |
>  |- not_present
>      |- none
>      |- swap_pte
>
> present: All fields must be interpretted the way the HW sees them. e.g.=

>          pte_pfn(), pte_write(), pte_dirty(), pte_young(), pte_mkwrite(=
),
>          pte_mkold() can all be legitimately used to query and modify t=
he pte.
>
>   valid: The HW may access the pte, interpret the fields and create a T=
LB entry,
>          etc.
>
>   invalid: The HW will never access the pte or create a TLB entry for i=
t.
>
> not_present: The fields are SW-defined. HW never accesses the PTE.
>
>   none: Unused; represents a hole
>
>   swap_pte: Contains a swap entry and swap pte bits. The contained swap=
 entry
>             may 1 of a few different types e.g. actual swap entry, migr=
ation
>             entry, hw poison, etc.
>
> ---8<----
>
> We test present vs not_present with pte_present()
>
> We test none vs swap_pte with pte_none()
>
> valid vs invalid is slightly more vague. The core-mm can move a PMD fro=
m valid
> -> invalid by calling pmd_mkinvalid(). But it can't query the state. An=
d it
> can't do this generically for a PTE.
>
>
> Based on that lot, it makes no sense to me that we should permit callin=
g
> pmd_mkinvalid() on a non-present pte. Indeed, we don't permit calling
> pte_mkwrite() etc on a non-present pte. And those functions are not def=
ensive;
> they don't check that the pte is present before making the change. They=
 just
> trust that the core-mm will not call them for non-present ptes.

I am OK with disallowing to call pmd_mkinvalid() on a non-present entry, =
but
would like to know how to enforce it or document it. Because x86, risc-v,=
 mips,
and loongarch can call pmd_mkinvalid() on a non-present entry without cau=
sing
any issue, any developer who work on these arches but arm64 can use pmd_m=
kinvalid()
improperly until someone else tests it on arm64. You will need to add VM_=
WARM_ON()
to all arch versions of pmd_mkinvalid().

>
> The alternative approach would be to make pmdp_invalidate() defensive s=
o that it
> checks the pmd is present before making any changes. But it doesn't sem=
antically
> make sense to invalidate a non-present pmd in the first place so why ca=
ll it
> under these circumstances? There is also a practical problem in that so=
me arches
> implement their own pmdp_invalidate() so you would want to make all tho=
se
> defensive too, which would grow the size of the change.

Like I said above, if you do not do this, other arches developers can bre=
ak arm64
without knowing it, since their pmd_mkinvalid() do not change a non-prese=
nt
PMD to a present one.

>>
>>>
>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>>> future call to pmd_present() will return true. And therefore any
>>
>> IIRC the following semantics needs to be followed as expected by core =
MM.
>>
>> ----------------------------------------------------------------------=
---
>> |	PMD states	|	pmd_present	|	pmd_trans_huge	|
>> ----------------------------------------------------------------------=
---
>> |	Mapped		|	Yes		|	Yes		|
>> ----------------------------------------------------------------------=
---
>> |	Splitting	|	Yes		|	Yes		|
>> ----------------------------------------------------------------------=
---
>> |	Migration/Swap	|	No		|	No		|
>> ----------------------------------------------------------------------=
---
>
> Indeed, the problem, as I see it, is if pmd_mkinvalid() is called on a
> "Migration/Swap" pmd, then a future call to pmd_present() will return Y=
es, which
> is clearly wrong. pmd_trans_huge() will also return Yes due to:
>
> static inline int pmd_trans_huge(pmd_t pmd)
> {
> 	return pmd_val(pmd) && pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_=
BIT);
> }
>
> At least this happens for arm64. Although Zi suggests other arches look=
 like
> they will do this too in the other email.
>
> The reason is that arm64's pmd_mkinvalid() unconditionally sets
> PMD_PRESENT_INVALID (bit 59) and clears PMD_SECT_VALID (bit 0) in the p=
te. So
> next time pmd_present() is called it will see PMD_PRESENT_INVALID is se=
t and
> return true.
>
>>
>>
>>> lockless pgtable walker could see the migration entry pmd in this sta=
te
>>> and start interpretting the fields as if it were present, leading to
>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walk=
er.
>>
>> Could you please explain how bad things might happen ?
>
> See 2 places where pmdp_get_lockless() is called in gup.c, without the =
PTL.
> These could both return the swap pte for which pmd_mkinvalid() has been=
 called.
> In both cases, this would lead to the pmd_present() check eroneously re=
turning
> true, eventually causing incorrect interpretation of the pte fields. e.=
g.:
>
> gup_pmd_range()
>   pmd_t pmd =3D pmdp_get_lockless(pmdp);
>   gup_huge_pmd(pmd, ...)
>     page =3D nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT)=
;
>
> page is guff.
>
> Let me know what you think!
>
> Thanks,
> Ryan
>
>
>>
>>> I suspect the same is possible on other architectures.
>>>
>>> Fix this by only calling pmdp_invalidate() for a present pmd. And for=

>>> good measure let's add a warning to the generic implementation of
>>> pmdp_invalidate(). I've manually reviewed all other
>>> pmdp_invalidate[_ad]() call sites and believe all others to be
>>> conformant.
>>>
>>> This is a theoretical bug found during code review. I don't have any
>>> test case to trigger it in practice.
>>>
>>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common pa=
th")
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>
>>> Applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
>>>
>>> Thanks,
>>> Ryan
>>>
>>>
>>>  mm/huge_memory.c     | 5 +++--
>>>  mm/pgtable-generic.c | 2 ++
>>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 89f58c7603b2..80939ad00718 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -2513,12 +2513,12 @@ static void __split_huge_pmd_locked(struct vm=
_area_struct *vma, pmd_t *pmd,
>>>  	 * for this pmd), then we flush the SMP TLB and finally we write th=
e
>>>  	 * non-huge version of the pmd entry with pmd_populate.
>>>  	 */
>>> -	old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>>>
>>> -	pmd_migration =3D is_pmd_migration_entry(old_pmd);
>>> +	pmd_migration =3D is_pmd_migration_entry(*pmd);
>>>  	if (unlikely(pmd_migration)) {
>>>  		swp_entry_t entry;
>>>
>>> +		old_pmd =3D *pmd;
>>>  		entry =3D pmd_to_swp_entry(old_pmd);
>>>  		page =3D pfn_swap_entry_to_page(entry);
>>>  		write =3D is_writable_migration_entry(entry);
>>> @@ -2529,6 +2529,7 @@ static void __split_huge_pmd_locked(struct vm_a=
rea_struct *vma, pmd_t *pmd,
>>>  		soft_dirty =3D pmd_swp_soft_dirty(old_pmd);
>>>  		uffd_wp =3D pmd_swp_uffd_wp(old_pmd);
>>>  	} else {
>>> +		old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>>>  		page =3D pmd_page(old_pmd);
>>>  		folio =3D page_folio(page);
>>>  		if (pmd_dirty(old_pmd)) {
>>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>>> index 4fcd959dcc4d..74e34ea90656 100644
>>> --- a/mm/pgtable-generic.c
>>> +++ b/mm/pgtable-generic.c
>>> @@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_s=
truct *mm, pmd_t *pmdp)
>>>  pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long addr=
ess,
>>>  		     pmd_t *pmdp)
>>>  {
>>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>>  	pmd_t old =3D pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmd=
p));
>>>  	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>>  	return old;
>>> @@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma,=
 unsigned long address,
>>>  pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long a=
ddress,
>>>  			 pmd_t *pmdp)
>>>  {
>>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>>  	return pmdp_invalidate(vma, address, pmdp);
>>>  }
>>>  #endif
>>> --
>>> 2.25.1
>>>
>>>


--
Best Regards,
Yan, Zi

--=_MailMate_90DF40EA-B793-4243-82C4-917DF13A8A03_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYrvw8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUPtUP/0SdY1xsPuDUuyZZM1P5kv+6Nun2+zvC6rzn
cdc8PkYikvN8OS12X2O6qUq6hsSetHwju0QPNnxq8J1/8Cp0j8pnGbaAdGBWIuP6
df3IyQHa0RwzL6hQ/67JIlEFDftU1pFoCTBjJh5BdVe0j0YGpwZPloPuD+Yoyhhk
eFfPg5ERgHrFIfMrpABic6dCnXgV6OOrQGH/Y7I6gJQFY+Ev16nnwuSbTd/1fu8h
P1EV1VhX2kL/ENgsndtcFcJngWGwjce4ozQrbn3NgVp1ryFReAFHhgXr0ENT0Neo
W8rapFOJFWt2sxEOfMOAekXgy0aVnccq6lHPzEbTHRgxurlSNv1ejJbWMsrNDvFx
OtGqdFi8XIs6mvWBghKcrVNR5jdeuck7hZcXN3eIs81FrewxOe9zjS6lHj6Dm9T1
t+FqFmLxbmkR5Ss374VMp9rT7HLToO8FdgVKsuMSlqBqHFsA/po4y1fQ5sE/xbKi
nev9Q55zlzesEH4HBBAkiHW/Fkrq6/LyBiumbECOwB3AmtQHxG3c8Vd0VZOw65Fo
GD/lm1HyoHnenOJhDf+szuMhw1k0ERX/UtVxEmPqsLPA3qooAYWAbtLQSGv/coel
B1FW8b+8/xYG3PImWOu2+xNjpjdyDRwdApKeHD/BITP7wwe9s4Io2PROdPdykpj2
yatyyidU
=Yn9a
-----END PGP SIGNATURE-----

--=_MailMate_90DF40EA-B793-4243-82C4-917DF13A8A03_=--

