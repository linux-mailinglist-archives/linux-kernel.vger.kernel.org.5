Return-Path: <linux-kernel+bounces-164224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252758B7AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3171B26754
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594D617554E;
	Tue, 30 Apr 2024 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ROMFn2mM"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808FC17B517;
	Tue, 30 Apr 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489233; cv=fail; b=G3h090prmqeLtga3bzxe0jGvZVK57DO49zTREGCPAqdCEc2kfUiL6prpwvWOM5W9NTe+7wYCuWm1bgo7rkBg1LTkmsSRU59wkCr1kAV88Bdy27djjnanONQPvVBCZWM3yRtMGgj/lFZhWrWuOaPQRhdg0qQqZkRs5j+FUKx+1Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489233; c=relaxed/simple;
	bh=2knyiIl86xvXxMqi1g4A3IrGkv0rCHOr878Hfxou2G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LZjU+/NU9DmNeCz62v0Zr+zAj3Fe5p8aGD6f86bXaOWJdwxS9L+aP0nIxrV0nBc4otWqaedhM3Y1eL3TV+FRop/xVjq8Wb/90SMzTay9Sg6Pyvk32QFrP1NsagG+hBdIiS1tgj28A1CHHZvjFpzE7lEVN09zZzOU9wywSegu9Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ROMFn2mM; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrSUuhw5kOh23SJPakVJ4O7uXNV5dfGkZ0HwH+ye2kT7jUtsCKy53W1hglRv8phXogsqjQuEDQCJWhpzCvGDbBdRXBD38uFPWdyKA0cxOdCkaLAnvXxSQrxSKL7RvoBEUvNf9gj2PeDItoY2YCI590tCMOAu+33hof3kZl3l7Ess3zSbxoIzMIn5jQibUcUZwFNLf2I2ZxVaPke4Lml+Pz96hCPx3+k8zcBuBhhzFmw8DNbVxcUpeZiNF1zR+gEePyF5U1ZWrT2TjCKA+TPQ7SJUmt3lfWoNFlQrWfJeSQaSftfrkWsp7gEcwQ7P9MSGc/UUXi6kCGjxCpOlY0aShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZg3gXxP8xLgwsdxusP7Gc+DbqlPbqff/ARAP1pDcUQ=;
 b=U6wo0iWi6ig5qmMDp+V5k339brEVNwsLBCqiVx4mjGLAoMAzvRABgjpEM4sA1a3gvmimmz+UzX4nhe2SLZMLqYY5PprDYM955UFjYL7nkzgm8dOl5mUhAxpCNs8UoJiHnW4rkZn6mArbL/wcfiGmxmYqmAWIA2I/mUgm37Fy0U96Np80dvR6sT9XQGs5K3cbPr5v/tnsi3/YV97QODzV0+SLaFMYMEXSWRHdju/8tGxN2cUAHJAvbcd+E9Rr8tW9YjTTUla3TNIoattXmTn79Rh0npt3rZTBQuy9gBaavdMQEbT7XvOF80ceA+7stFvfD9iFf06wxetWr3e7DWSFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZg3gXxP8xLgwsdxusP7Gc+DbqlPbqff/ARAP1pDcUQ=;
 b=ROMFn2mMzm2YvWH5D4voVKt7hbmNSKXJPY9LM5QCjRUew3XtRNSL5tOmvTuMSl7VuHyFN9ZnPOl0Ad403wPI3txDP2Pu6Fjwfpn1tkghhHpBK1Qx0NYzoWP9p3n369s4S0ZnKVdAnbCNT6OpxfN1wkr6qJUHzGkKldszcz3PP0BFWd4Zs+rx/ZbZ6NyaWWAkjVo/8ENkugrkE3VlJUIg+3HyYH6zRymC9+KrdJOm4cPV5P+wdvXi/yxozGXfvVyPgpMP+xWH1hz8AmnJVvokMnMCdmhvO6nhvLnZqvABS+vNi/azDrLzT1ITNKAmyzKyyxLPkin861OgvjV9fUNO9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Tue, 30 Apr 2024 15:00:25 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 15:00:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/mm: pmd_mkinvalid() must handle swap pmds
Date: Tue, 30 Apr 2024 11:00:22 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <32048DBA-EBDA-41DD-A688-8389903DA0EA@nvidia.com>
In-Reply-To: <20240430133138.732088-1-ryan.roberts@arm.com>
References: <20240430133138.732088-1-ryan.roberts@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D4EB5EDB-B3B5-4372-A6AA-1E40E32999F4_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:208:134::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 408500dc-3fa2-45d5-95c6-08dc69264418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?22D4q9hxfIT2WCfWvyoAshA3N327TKBJB+4oL8nw7L96/SM8xBjpQZUUcv4Y?=
 =?us-ascii?Q?kM9Vd7+tpJ2239cEjDYKHlgIqVIKkLaW+Yz1AAAsUUjTUeiQzU/gfJinxqsB?=
 =?us-ascii?Q?0WSk2bVlLpIGht7wNuFus1ODOCAhsE5u4iLcqwBWlNht1qv3xoGbA0snG486?=
 =?us-ascii?Q?NbzoPklFG/J9iNP6PjFk51HcuzAt4FAeDyEx9ArS//KTXG7zT/kqQwz4AA6y?=
 =?us-ascii?Q?OU7tOMm/KPi+sCA5WX2h7cD+IO6O10G3ftnsF/cXa+inGK0BzJCogUNI5WbT?=
 =?us-ascii?Q?XLhAzNBZ5NsGS+gE2a3Ntt5EZfyR8WF7xgBtqBJ9jo5J1N3UojemScgqZy+z?=
 =?us-ascii?Q?T4GpZy5nO9ds5DohkHchRqe2ClPxz9VuRSd+1HmmMy4Pfc/TCP2Gg7onuhk+?=
 =?us-ascii?Q?41Z4pgIKuz0Lw1TLmMIW3Jb6bnxqALzEmltX5UZoREhdgJtixJqQWb1f+zkf?=
 =?us-ascii?Q?tXmX/1h5t3RQCtFK9jUaKpiDhf+0gYjtpghjC7xSRRcelgp0gWhfaRUf9wQQ?=
 =?us-ascii?Q?FmR+vquedp7MfH8kiU0dTtEVT9+HZRmRxqgshBEXFJva6GZ0wq9FoW2U0IqJ?=
 =?us-ascii?Q?PUVrf3TOLAHfyzvwXP9lSHauyMSmcvImbejlRdWx1UeueG/YMt/nRzdZMN1G?=
 =?us-ascii?Q?SZqFezvpgimJ1GNPucDtfYcMBuIN2iX3LQp2bk4QCYEUMUzWQCHDUYmq0i3a?=
 =?us-ascii?Q?ctL6S+YDqGn1BDY+J7kvL8wtgToAzJgKYXtcmWl/e2fq+VZ7nU1q074aN8O6?=
 =?us-ascii?Q?0f7F5T0TDZEgbqA/EKI9ep2k/7BvOyEr+uG7DWSXxVf6di/1HG/6OVJlnf3N?=
 =?us-ascii?Q?SNeJSDLMRvn+GOsBR/ionVX6UMHpTsay0cc1HSHbOVfxMZJpxjvzKN9RwOZw?=
 =?us-ascii?Q?zEO5HWM6nwfU3oR6mgsEXIRrkbmFNM/odPCmfOQQF+CnjVjbcQXhBhLd3jT0?=
 =?us-ascii?Q?JGiEfWrBInKeSVcyPBSMdDkCJICQNcY3tgCLVIaOy+TfO1eW72+rPBMUhRKP?=
 =?us-ascii?Q?vQPB2UJ6e2+CV5oTpCqfP8rA4crdRqKq7Z/MLVgBn/e52Ld/PB4ebo+xYfee?=
 =?us-ascii?Q?TlqRTm4hbLP9Qvumv9kcKFPXDy14HjDQo43nqeBqkRJSHFdmpLFu89CUHKJQ?=
 =?us-ascii?Q?SF6WoO+bJr/MSW0dgaOS8Idr2XOxKgmtPGuIsm4EK/eGKWBvjeGuzF0A18G3?=
 =?us-ascii?Q?7NLNWCLc2DG/8AFpLfMAjknWZ7tLKFJmiY6KIGHH5dMsOHQKCmXpieGYcA6I?=
 =?us-ascii?Q?SS3HO1yQwfTT7vD4JLnTa1x78DbFq0yCW9KHfnGUqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/nQYeX2cnObX7uLpd32boQoeX1Q08QEcE8YGCNb9wsgzhjO8FuhW2TKg4Zz+?=
 =?us-ascii?Q?53y9ts2xoCWWxAyWWuRhSPIVlOK/5CpVpr+boNoqTqQ8C8MlhW09HczA4Ivn?=
 =?us-ascii?Q?Zep9L9MDowXzV2jGLtp91QVe3Fs3AmCWZMhnZUys+j6yoNpINCTZXMR43Trd?=
 =?us-ascii?Q?QLyvO9L0kHefMWkQQ9ronURe4TN8hlOpW0SMAd/Fvft8iyJgm4uqMfNb/Q2g?=
 =?us-ascii?Q?z0tBgAkl9FfKg4R4hUxXvwatmy1hoV9krhtguavQnGomIBr63FZ3HxvG3KZs?=
 =?us-ascii?Q?AXF1lqFpMD4mpS1VMfpBt9h5j/nmCWX71VdbQmY1CXuf9wxfHePE+/RMOM6D?=
 =?us-ascii?Q?fnz/lqpjHQxLJKLIfHnx/dvnRidHu1QaUs1pM9z47i1e5mC0bGOj0wCGPk7W?=
 =?us-ascii?Q?u8NPTyvjLlCR6BRLFi9CUhM64fQw04muEmOE2QWa4fFdM92IWPQxjmOQ2Jg9?=
 =?us-ascii?Q?1m53OSa+72P6TizMz2rpc2g7mAda409mBwQu9vQAfR7Ok1RJye5P9azlJSd9?=
 =?us-ascii?Q?ZeBtyOKEEtbooJvUTVoJNLatCRoE/mgbXSbtPaWNyyIG2KeO5VKPSdsUKgpc?=
 =?us-ascii?Q?0VXO9rnjhZCHnLiLr3/X7WdNpDVT9eAbRdO53zTmVdbpZJHfRSWW0dI7zyMs?=
 =?us-ascii?Q?vfpRClSOs4969GEflLNUsD8nloquZShDo5GUjKVEJ0rNEQnn+k4hHXgZPvyC?=
 =?us-ascii?Q?FOsjZn8KmScyZYrUvHpHz3vDYbbJZAL+Z1tFKO0nt+inXyt/dwMZ6ZEEAvux?=
 =?us-ascii?Q?amf93kYBFB0V31d0tXhGh4bYf0kpzx32MwTnEZs5XuT1DlBQvMPA3fENuoq1?=
 =?us-ascii?Q?3c7VuBMqwA+1JASPeSjcd7lYcWdoJoPr1MKGgl5ocCOX4QtncgR5oYbWxWIF?=
 =?us-ascii?Q?vTBSFmRaPg7/vuajHOEJFWCMfnBy2yVS1MN6YPULhAaSQixj5Jm+yFXk9g1h?=
 =?us-ascii?Q?jIRpJCdBMooFy6hAufhDPO6J/rVBTTaGUTEusuQskXvUt/kCEZu1xK0bdrtj?=
 =?us-ascii?Q?fstTb4efRC5acHgb/fgVtVAoxAwIBeSGuDxH9sm/Y84uX7dfbuyynFOSs/8D?=
 =?us-ascii?Q?QtKbDBQQ1Y6/VfCLgUxig2GomD7OB1awZAeJ5UzMu8T5UCRTNK6KSqVIor4Z?=
 =?us-ascii?Q?AlkNv2b16Y9O0sk4iVO9mCgOuaAXduYst8/f+ml2s4oSjplAcYPEXt/pEOmD?=
 =?us-ascii?Q?CF2MvDMmZ6aXaOgC6uxm5uRttI5VKQubTvfm75PVVVsHv/ELiR9F8H8RKWh1?=
 =?us-ascii?Q?e4+wzWM4QCbjA45pX5EFk+KpeCVEOrH5B1DLi4hNJlaWdlHG/kob6mPks4gQ?=
 =?us-ascii?Q?0HR9LgHL9GU4YFq4Gn1/zxIApNrQWvE4d3fwjLD423wzG6/uEDQJnGWDvyl+?=
 =?us-ascii?Q?Uypd4R9sBDhTMiGTOvsr0hqDRUZ9uH39zJtpg/sS3jb5wj95B2sAdD13vP03?=
 =?us-ascii?Q?9KFTsym4/wfECnUi37CUrjbMdXPPVGnl+VB24UW4ih5Nm5qBp71wDcYGtY4S?=
 =?us-ascii?Q?ROcsaRBgatJjoxolJkUeqsH+sdDRMxBRMrlBiciiozWhgilYLmcR88t1Gl6j?=
 =?us-ascii?Q?UA4NZ8YMtsGbME0IS85fE/KjHMyRjyVVQk7gEYnv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408500dc-3fa2-45d5-95c6-08dc69264418
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:00:25.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cjTvzjDWqnVNSgjrrrGs+Wot4NYiWn8dFzDs5Th47PgQDV6hHujAv9Q7XtHlO1e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191

--=_MailMate_D4EB5EDB-B3B5-4372-A6AA-1E40E32999F4_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 30 Apr 2024, at 9:31, Ryan Roberts wrote:

> __split_huge_pmd_locked() can be called for a present THP, devmap or
> (non-present) migration entry. It calls pmdp_invalidate()
> unconditionally on the pmdp and only determines if it is present or not=

> based on the returned old pmd.
>
> But arm64's pmd_mkinvalid(), called by pmdp_invalidate(),
> unconditionally sets the PMD_PRESENT_INVALID flag, which causes future
> pmd_present() calls to return true - even for a swap pmd. Therefore any=

> lockless pgtable walker could see the migration entry pmd in this state=

> and start interpretting the fields (e.g. pmd_pfn()) as if it were
> present, leading to BadThings (TM). GUP-fast appears to be one such
> lockless pgtable walker.
>
> While the obvious fix is for core-mm to avoid such calls for non-presen=
t
> pmds (pmdp_invalidate() will also issue TLBI which is not necessary for=

> this case either), all other arches that implement pmd_mkinvalid() do i=
t
> in such a way that it is robust to being called with a non-present pmd.=

> So it is simpler and safer to make arm64 robust too. This approach mean=
s
> we can even add tests to debug_vm_pgtable.c to validate the required
> behaviour.
>
> This is a theoretical bug found during code review. I don't have any
> test case to trigger it in practice.
>
> Cc: stable@vger.kernel.org
> Fixes: 53fa117bb33c ("arm64/mm: Enable THP migration")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>
> Hi all,
>
> v1 of this fix [1] took the approach of fixing core-mm to never call
> pmdp_invalidate() on a non-present pmd. But Zi Yan highlighted that onl=
y arm64
> suffers this problem; all other arches are robust. So his suggestion wa=
s to
> instead make arm64 robust in the same way and add tests to validate it.=
 Despite
> my stated reservations in the context of the v1 discussion, having thou=
ght on it
> for a bit, I now agree with Zi Yan. Hence this post.
>
> Andrew has v1 in mm-unstable at the moment, so probably the best thing =
to do is
> remove it from there and have this go in through the arm64 tree? Assumi=
ng there
> is agreement that this approach is right one.
>
> This applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
>
> [1] https://lore.kernel.org/linux-mm/20240425170704.3379492-1-ryan.robe=
rts@arm.com/
>
> Thanks,
> Ryan
>
>
>  arch/arm64/include/asm/pgtable.h | 12 +++++--
>  mm/debug_vm_pgtable.c            | 61 ++++++++++++++++++++++++++++++++=

>  2 files changed, 71 insertions(+), 2 deletions(-)
>
LGTM. Thanks. Feel free to add Reviewed-by: Zi Yan <ziy@nvidia.com>.

--
Best Regards,
Yan, Zi

--=_MailMate_D4EB5EDB-B3B5-4372-A6AA-1E40E32999F4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYxB4YPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUX6wP/RiN1STcOZKXdHM57ttW0ZL/Y05QJai6BiO+
mGZ4HZ33Lc2tzulZLkZz1dNScktvDj3MRBBj7d6wivCsZT/uiq9cXiVOZF2QlsJ4
k/5tIJxoH1e98JjNAakTmlsC6xZPv0tYI0fsQdCyNeh41PTaMkadNAyLrb4tSuFR
rjgRwEWSWV3adAngzKNn479NWYpqyTXVLcU9LBIp/uQj2vQ5lC/5Vb7yd9eNMOk/
ls5GUwN5xFlrjVg22cY7QDUzQcorNLmBNQInUitj5visvHzJPcw2p8Lwsbgl6g7z
WqDI/yn+yF+MsyE/DgE7kn9XGWiOMnjUd2qR7lMLbH1Glb9joCaM9YepgaennMdx
eF65hTGtYoTptWvLLUAMhLmteR6fsAAbEOONc/oTbFPtiocGHWiueSoVlx/iwNyr
U4lWdxO9U3c+hT1VwLPJEXS1ZR7t++IqL0BrbxvcOUk7gtbMUzUC9efzQIuzJJhx
0hg8uKzPEFwDctGLdv+EGYj6Q0sKyD0kHTILDixUpntH5mNp6OWMDw9dnP3yZfly
4QEAYy/0IrFgAaaDqaT1pUu+kG6PqwgmKN53Dva3p8H79PnWULxpOuLGlGmtDTNh
vm3YRNRynP/tB9SXxTtzSobYN4l3I6B0Mqmh4ZzrVmaba4XQTJtsaz6M2qhpmjQy
7XtSeH/Y
=fW62
-----END PGP SIGNATURE-----

--=_MailMate_D4EB5EDB-B3B5-4372-A6AA-1E40E32999F4_=--

