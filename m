Return-Path: <linux-kernel+bounces-161083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A998B46D2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A821F23589
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6863253AC;
	Sat, 27 Apr 2024 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V736b/cN"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7313F4A01
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714230904; cv=fail; b=G3uEbgAGEsPgtKMh0KvKF8SQt5yYWuL3iwSortWO7HHvInw7ydZkv6Q3gvobggtE0AgXVZZmyIBBNxJcrqz92qwP1QNdN1okdjameVJsAV+myZ86z2G3K/3Y0VTqrWaTfyN6sexmXGtudEUU6hdw404JuM/H0KD/3Jx4PaiMcHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714230904; c=relaxed/simple;
	bh=/t0YzZxFGWiCF5uCDWn5SSeZq1d0GBiuL4paIpZZPSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHZDL3pqo09+WTuNCq+IEvDCyCutgeLISHirhgyJKTMAODcEqVVIieKc01VqsJQTz5rrBK/jkNP5Zg3Qwi5uaei/T51oeX03Bygt1O1BmYOXYtTZ+zGVM//O8fBDya79b73QkfmP9HZmYZodVnWQzIHwEGnMpVqZM4m1uI5YrVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V736b/cN; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTpxAvBw2q3Zt3zKIQ8DfqjB/xqnrHStXS2CY4VE1zIIXg5LdBAlpqIN8C64szmipTKJB+zhAJ52IC5Dcs0PbVs1ACf7wv04CTtPM6T8ZhxEkid4Brglj8ZIyWS97/aLGgwq3zinPbaTHC6sXdYtvZW7fOsAF6T0f0bbWt95XKOmfXulXsZhyeKVvDVZMAWRxtGzNsWJSSNDg39lYbqCE5Ui+5IVvupl0tcWuvPuesdeGD/gVHPx2MF7Z1Dr7Z3Vz8B4RQe1NO7gZY5LCcqVRDnX88/7ksvkoVb0cJtHTAZ6jmOdkhG/d+Zht1GSR2U7wReufFswobSwD6fO0AvK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1rZFyanv2wibyu8sfsZlcVmoEpiCzByRCiIozJovig=;
 b=kNJQ3HXfHQIAU2Kz04HFJ8G22VMQ5SxREfV3QDljCJpnGHS1VXRC5OXCC5s1L9O5JX6hfKQmajzoPIqp4gYKM7g6d8ZNgPMavb6qjADgsRLBUyBFC3Lmec3+4LE3XELaZRnpeiNwkeGE6lUrf5mHcLrRd4vjjDuLa99jJD8HpFex27lq6XuLozvb/5tEvVqZs3T3LJsY9BQi0liQn4/mFvEhl6r0vbwByAV6wI2gWSaxKBImIuT57CuNIh0IWVGc0hkgZ+Ar1ynEpWMf5XYyX8E9RswBqC/D1tJ5bUkb+zIeVyYFbK24DgJCckZvOgnrpNmX5Kxzqu2DaS4Icl3tRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1rZFyanv2wibyu8sfsZlcVmoEpiCzByRCiIozJovig=;
 b=V736b/cNSAjNjYSyyKMi2rG+0izArMup192g9ArSrZQLhBf47yJCKRiwHpptpB7GtcFVUO5XtQSMxIgeq4dc83xPdYfvteN9Z+YMlXOA0lleqlzTFCTy1inlbqdlo7gajWCCXMdqgNH7kGxrkuSnrVyipL/+JYqbQ2fWkEPS6yF5TqvOTIxZ/jr2hjnVJpSUZnnkoP3JSFoviM7pVk7+BXZKuIac4WmXC8xoyYL+Xq57xE9/SqBL2Ik1y3SxPUIzx/vcLCyFwpvmlg2eI+ffxZxuXoNE/nnCTzJkMleQNk916lVZlwvAPPF2Gh2H4uD8eIb9kEuPvD8xJuf1EJQwIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Sat, 27 Apr 2024 15:14:59 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.031; Sat, 27 Apr 2024
 15:14:59 +0000
From: Zi Yan <ziy@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Sat, 27 Apr 2024 11:14:57 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <2C9D897B-0E96-42F0-B3C4-9926E6DF5F4B@nvidia.com>
In-Reply-To: <17956e0f-1101-42d7-9cba-87e196312484@nvidia.com>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <17956e0f-1101-42d7-9cba-87e196312484@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_51ED5975-CE96-41E7-A2EA-A5ED50FAF4E6_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:207:3d::39) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6b88e5-376c-451a-6f6f-08dc66cccde5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g3StCUfvBg5P15xteC3gEQk3cD0DgHUjxpU79Fuc1O/HGfTHIAgwyIIriNgW?=
 =?us-ascii?Q?KQZIicmWmMcWCT1wRQ2ug7frCK7X+3RpSSDuZtGM9BaFkJvU8Pj/Z0iq4ri/?=
 =?us-ascii?Q?JuteldtJMBHv8DUzifDIICcFpcmwbiQtd4eB9XT7wf9stnwPLLC83aBMS4DX?=
 =?us-ascii?Q?Am7QiipHvLOOHeS96O/0YCXxc44nK08AP6ep+c6p8H+jSG1otbSaP6anflbi?=
 =?us-ascii?Q?+3MFmMlQX747sF4mVEeGcd2cXN2y5TpdrMU42Km/KhHS37t4uGJO1U8bmkWA?=
 =?us-ascii?Q?PV3TCtfZZHrJ/Mmvfz8Udg6VWX1xHPCkWgu8CdBxD/szYiMBC5GzSfu3YbqF?=
 =?us-ascii?Q?wiPsEfOhXg86eFVzsaoedVH9wcVbsEPsT9KYuoT2FPevJXPCx5AYPjnYr9jb?=
 =?us-ascii?Q?kc2nuYBMp3Db+niwHcoZ89GCcXVvdmWXLaKjnhsRExg32U19UIYTxu2a8Oj/?=
 =?us-ascii?Q?OlnN/cXJz+ObmSV4CKhCt/fOkHCqXmbBQrM2qIvpF6KgFgJ8/I1TtZ1PHbRd?=
 =?us-ascii?Q?9qtrJnxCmGUE82Fev7ZuKPGGbenS49FXBk8vKQ8nbWCecMC07fcbjbt0sGkA?=
 =?us-ascii?Q?fIG0v32D6KmvgRniNSoK8kyYvxOjt+MDR/aUkE+45xB6ZmakVYTnSKQNsTDX?=
 =?us-ascii?Q?qKFIB+0nepM7VWpyHxUvdDcIPFm0iIXIpEQrQoGGWKuqHXmX4iJh/ydIGCN6?=
 =?us-ascii?Q?iOB/EChyCoE6JC3YpzEzPnB7Fo05qYjqcWN090yrjD3ua4j+OutCwJqlSMZb?=
 =?us-ascii?Q?BEz59Q4YcdXNFf4xgiS5vIYJoKTfm81oW8h/TpYihvv5bR8PWeUgfsk/deyR?=
 =?us-ascii?Q?BQ6omW8jXJkIsG5X4N5HLDOkdFT06o2L90ia9Bq8BiD3ilBSf6SgzBodAEBL?=
 =?us-ascii?Q?2CP3ZQ1bFtAymnlZIwqkO/fkP8DjOdtOUk3vBrFG8CyNdk80uJi/CQYojo5C?=
 =?us-ascii?Q?7KHyLLACXLAMOXkEdMUD3Bs7+eQJPNWHIYvGUQyT4OTwJBcsnj8x3NbnSGpk?=
 =?us-ascii?Q?et52g9FwXOhSInQ6Mj0rHf3LJsP8sazRVzckzxs81fJ0DXIcbN+Vt4vtdP7B?=
 =?us-ascii?Q?nVCt6NmsUdIdLwUayQagmF960ewBiNhnx2W9NV/O353l/ZE1ECT0fe2Vm3yS?=
 =?us-ascii?Q?HM3ttOfCpY6lwnixtY6PPKwVlahGRGyIGDZlWt21THcUkc6DVjm/OOPtVZTM?=
 =?us-ascii?Q?KX5zlapTMBereoNPbyNFNv0x3uHVrJQaeMeOh9ePp9bepY1cEI5MszKEMRal?=
 =?us-ascii?Q?v6bt/St3/sMMkvDE7c7mQ/voPOK45wVy5DUrfhMNLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rGXdJKWJdguD3KhXXlHKAxsspz0Y2XurS/hq8wZHQTdjibsUcxu0PJ3pd6oa?=
 =?us-ascii?Q?qIrhe63x1xwDUv+dOZuua+1muxQ2dTKISL7FVX1VqRcth5CL1mGMjcUjP8GC?=
 =?us-ascii?Q?4nM8VK0aolF1vrXwupst3XZrcci/DPz8n362JmO3aopidtUlhlylVGnYTz2P?=
 =?us-ascii?Q?TLhO9o4JHO+9p7eHroHcM4xzCrza9M2xVyo53OpStG+brHhTZVvOx8dattJB?=
 =?us-ascii?Q?24wQn9Bw2bf29gT9akSdtfPYB0UE5IWgGEmvz6k75LbaaMBeizCcm9gS4qV8?=
 =?us-ascii?Q?QuV1fBRMbHBgLgO5LhQoWY/bJ0KfkpV7DaEmibeduasAXID9rgrNdn8H0x/C?=
 =?us-ascii?Q?Ih+mtp9CuOgNmGpuOof3/VLOZkZ50M+8uLlK/CWBQa0BCXDw9LNvZJ5/Ch7y?=
 =?us-ascii?Q?+u75aUUM0bC1y4WrRiSeBYOF8wxhV4PUzi2D6ibGBjtxVWSlUgp1gn4ZPIji?=
 =?us-ascii?Q?TKz31FdjbgdThZdceofP7RubjVFEugv0+pTICnkO+ZnNMqX2wwKUSUMyHO0O?=
 =?us-ascii?Q?fx3uiFSyHqOzpRRrhksJ5DCKVFqoLzYmJlWEE61S6c+Bh1OYNMKxv9QZhwFS?=
 =?us-ascii?Q?NgojGu/Opoa8n9SWfPV2f9bKXbDkFV7n1J4SSfb6d2qkN9IakZYwrNX4mc2K?=
 =?us-ascii?Q?vIG4mqHWQYWS00zlbeja8RUU0IIMhCyjJ8w/CX1uBIPgxj3JoVNCkv1gLLfx?=
 =?us-ascii?Q?5ctSwOcX+fUtw2JgPraXj9fYLrvx2OeRCtQZ5DTFxLMIaTQLFZUjFHJLhbXN?=
 =?us-ascii?Q?PHv38WI12oHOQ94Rsjjeu1zrZAgXI/+WdaX1tzfbqDHCpWzTKoAcekOw52lt?=
 =?us-ascii?Q?I0ErdbY1tug+XwwNsYKy40s2Eb/Z+zYKUMbrf3UBkw+zAzow0q5jO13aD1hr?=
 =?us-ascii?Q?Tv+5V4aPWWnf3vMgVyfSV3JvoWpEQbBR1YIkxruRV22pMKw1otVKRxq0DKEg?=
 =?us-ascii?Q?SKJt1p/M1MG/Re67jZDoCoNuHF7omTOYE/Ez9r9vIVXxLgeta315e5nOSwAZ?=
 =?us-ascii?Q?mPgeHX0b1Y9bttwYm+9YzlJyqCCpEzUSzaQA/AhPAt7bsrJe+/2TYJc3iEbG?=
 =?us-ascii?Q?I2tqLfRPuCzyPxR6LkdW9j100Kl0P6WNU0Y6IPGAC6sdh5xJg8CFD44xJjrM?=
 =?us-ascii?Q?1Pv5SMc+b0qB5zF53f0/iub5qyLXvwi3kL1qpLfY5sbttRivDnUPYdVIL//L?=
 =?us-ascii?Q?D2ZMDQ5mC3iK7o5u35KPY+MdMeAn8HfArrHuXVP8bLfxbJ4dcJ38upFaO8/B?=
 =?us-ascii?Q?4TCkcg4Yjz66nMpuA9f/onhtyGzkrTe8TsTcktxBQ8HFdVFOoGFUtY8thHWW?=
 =?us-ascii?Q?kmP2JCwhB3tsKacZIooPc6fw+5tdFqZsdALKn6R0t1CAvvWlyldrSFsf1S9U?=
 =?us-ascii?Q?QV9y11IWqJmvyxy/xQd7CPd7NGh5vT9Wpq1vWGxr7RIvwW9KSb6xbcNkma00?=
 =?us-ascii?Q?8/gvwKm1NEAMWNNkgVIpXyDFyKAk5CCJZKqzv8cG9YNuKB112J9QG/LFANvu?=
 =?us-ascii?Q?crXQpTbdmch4/HosH9v2cL2ra8f3n5LLmYQigkBxbuDpG0/FRicxJA5Mh4Wm?=
 =?us-ascii?Q?2/1cs/3TLmf1kPbUjVM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6b88e5-376c-451a-6f6f-08dc66cccde5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 15:14:59.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQb3DZ4wmQ3GJ1Oq4+nWtKZmGdF9D6+piZTdX0nkTeq9a1WsYxkAOE1VfwwtNpMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086

--=_MailMate_51ED5975-CE96-41E7-A2EA-A5ED50FAF4E6_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 27 Apr 2024, at 0:41, John Hubbard wrote:

> On 4/25/24 10:07 AM, Ryan Roberts wrote:
>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>> (non-present) migration entry. It calls pmdp_invalidate()
>> unconditionally on the pmdp and only determines if it is present or no=
t
>> based on the returned old pmd. This is a problem for the migration ent=
ry
>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only be=

>> called for a present pmd.
>>
>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>> future call to pmd_present() will return true. And therefore any
>> lockless pgtable walker could see the migration entry pmd in this stat=
e
>> and start interpretting the fields as if it were present, leading to
>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walke=
r.
>> I suspect the same is possible on other architectures.
>>
>> Fix this by only calling pmdp_invalidate() for a present pmd. And for
>
> Yes, this seems like a good design decision (after reading through the
> discussion that you all had in the other threads).

This will only be good for arm64 and does not prevent other arch develope=
rs
to write code breaking arm64, since only arm64's pmd_mkinvalid() can turn=

a swap entry to a pmd_present() entry.

>
>> good measure let's add a warning to the generic implementation of
>> pmdp_invalidate(). I've manually reviewed all other
>> pmdp_invalidate[_ad]() call sites and believe all others to be
>> conformant.
>>
>> This is a theoretical bug found during code review. I don't have any
>> test case to trigger it in practice.
>>
>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common pat=
h")
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> Applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
>>
>> Thanks,
>> Ryan
>>
>>
>>   mm/huge_memory.c     | 5 +++--
>>   mm/pgtable-generic.c | 2 ++
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 89f58c7603b2..80939ad00718 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2513,12 +2513,12 @@ static void __split_huge_pmd_locked(struct vm_=
area_struct *vma, pmd_t *pmd,
>>   	 * for this pmd), then we flush the SMP TLB and finally we write th=
e
>>   	 * non-huge version of the pmd entry with pmd_populate.
>>   	 */
>> -	old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>>
>> -	pmd_migration =3D is_pmd_migration_entry(old_pmd);
>> +	pmd_migration =3D is_pmd_migration_entry(*pmd);
>>   	if (unlikely(pmd_migration)) {
>>   		swp_entry_t entry;
>>
>> +		old_pmd =3D *pmd;
>>   		entry =3D pmd_to_swp_entry(old_pmd);
>>   		page =3D pfn_swap_entry_to_page(entry);
>>   		write =3D is_writable_migration_entry(entry);
>> @@ -2529,6 +2529,7 @@ static void __split_huge_pmd_locked(struct vm_ar=
ea_struct *vma, pmd_t *pmd,
>>   		soft_dirty =3D pmd_swp_soft_dirty(old_pmd);
>>   		uffd_wp =3D pmd_swp_uffd_wp(old_pmd);
>>   	} else {
>> +		old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>
> This looks good, except that now I am deeply confused about the pre-exi=
sting
> logic. I thought that migration entries were a subset of swap entries,
> but this code seems to be treating is_pmd_migration_entry() as a
> synonym for "is a swap entry". Can you shed any light on this for me?

It is likely because kernel only split present pmd and migration pmd, but=
 I
could be wrong since the code is changed a lot since splitting migration
pmd was added. We either need to check all call sites or check pmd_presen=
t()
instead of is_pmd_migration_entry() and handle all possible situations.

>
>
>>   		page =3D pmd_page(old_pmd);
>>   		folio =3D page_folio(page);
>>   		if (pmd_dirty(old_pmd)) {
>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>> index 4fcd959dcc4d..74e34ea90656 100644
>> --- a/mm/pgtable-generic.c
>> +++ b/mm/pgtable-generic.c
>> @@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_st=
ruct *mm, pmd_t *pmdp)
>>   pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long addr=
ess,
>>   		     pmd_t *pmdp)
>>   {
>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>   	pmd_t old =3D pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmd=
p));
>>   	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>   	return old;
>> @@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, =
unsigned long address,
>>   pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long a=
ddress,
>>   			 pmd_t *pmdp)
>>   {
>> +	VM_WARN_ON(!pmd_present(*pmdp));
>
> Should these be VM_WARN_ON_ONCE(), instead?
>
> Also, this seems like a good place to put a little comment in, to mark =
the
> new design constraint. Something like "Only present entries are allowed=

> to be invalidated", perhaps.
>
>
>>   	return pmdp_invalidate(vma, address, pmdp);
>>   }
>>   #endif
>> --
>> 2.25.1
>>
>>
>
> thanks,
> -- =

> John Hubbard
> NVIDIA


--
Best Regards,
Yan, Zi

--=_MailMate_51ED5975-CE96-41E7-A2EA-A5ED50FAF4E6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYtFnEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU8mwP/1mBuJOnRSSI8R1Un/btpoPk+1WQfog4wgyA
TasryYN9XWppQDDIx25eRXEMi+UH9IXadItdcnCrSCUJCgQSiNSaKTBUBwbOGNez
jNfKBgBZAtJ5Tm0CLtaRSDxa2Z0EjWwkrt9aHnIXe8rSd2ocdGFxK9s6WiZRiVpr
gfvgw3Q4d1RS7YarLbj2F2anpIs3/GrXwOvB4GZeM+qQbcY+/+2mcoHOuTUi9DAv
bkflj7dzmVWJUj7Sml1ORpbonJPb09GDCS8Y3uvc/39eAS/SUcbGRYZ0DmFlI+YK
XHncZ6OQuu80xEd1/rxM0KWu0Bs4wW3NxJZPNiqNndCbkpj0GFTKwuLLl8caiqwQ
75JEZqwbRTZyogRCZ3JW+jhAyiK7ZfgfyJG2VGdpymc/MfQXnPwv0n2ZQH+umEOf
v92T/PKsU+vHKcI+xt/RoFuSfgJL6GV5Gcy79UOwk2eUgllPfbzqQ/jr+UGLA/3B
DpkwEwTuEnTVkHGCXL/UiVuz7NuF6I88jdr7yfwVAnAcOEjaUEL0M4SFY/E6sUMY
Ha2h73++NHswJrSqU95xCiJlZmlCOuRqA/WVsIBRrSSIViUt+USghajsLvxAsp7x
LAjMGO9eU3SGY+hNrtw0ZTTnJjlCa5hQZrKvdueiFe3yVGLPWcubw8yk4rACaIjp
i4jrZVVY
=dct8
-----END PGP SIGNATURE-----

--=_MailMate_51ED5975-CE96-41E7-A2EA-A5ED50FAF4E6_=--

