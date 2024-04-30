Return-Path: <linux-kernel+bounces-164094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021F08B78EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC32B280C32
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2549E174EC2;
	Tue, 30 Apr 2024 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KHe12cSA"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D80172BB5;
	Tue, 30 Apr 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485968; cv=fail; b=YujMV0Q+YohrshCqDZNxGd2uaibzyG/KcJgX+NEhICvTkrN7pRKSq1zN9XxLj7hkf7tz3FVfGPOgAAQsJdhF5Y2xvv9XLtiSmm3jqlu+EXYp5qf4v3GncJozjx0i6Wjoez/0iZtPr58vZMPdujw1AyGKAUZfooKYd7q52ozeLHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485968; c=relaxed/simple;
	bh=Fc6VKYeOYLXOTWVl0ZlnwvuvG2hOXy+RPNzfxV/Kdmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GjvgLj4dS+SqCNTbxVqZ2NpaDslBd2z1YKm823KyQvTVkzc+E0IJka3b7a1ssh17LVVuW4Tk5R/4T/XOdezBTJxCSH4AZl4ONgnRYaqrc0MgmlpH+no6xeFsPZipPGvibtWReKRH737kRvHWkZEmJEH261RquLSnbNtTMeyOkNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KHe12cSA; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWOUAG0oo9xPbQvVjhPio1MDlIbqi9yOU+ExwEG0yQkh8D+jm48Ub2vba+X+mtlD4BznyxEoVR5yCFW5U60BRBqDXsxFoTdBq7RKIxwLx76uQEN/w9Sp6td08cjAFahSM/wz9De689xe9TanQtde+Sy77JtJIfUTDasRt+UDKtdnNrP9+XlNV+jfmnvml2D0AtcNm1ovS1OPpT985qlGcE2uRMFVwGnErTfe2e51+zkft3TbEGXwqcr9TgE2Iud9SLoIz/gD1IUg9ybrE+4MZ4Id+0VYz5C+yHnp0y0NuC4pNIAsTZr2/30Ekv3U7S5/HyMreUUP5GOmuDAKa/U6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xv7+alfGmC0L3lFcIc83KYYoR2JcfcX7O1Gra8tjvrs=;
 b=D0EaePuFItIpL1mgg0QTCD3rccTPZYpFJ/aLUv26K3q2tQC/kin+GuLhZSqN4xLg6L1sKMjHFh6TAEwq1ecQLAZzm1nUgD1XYEoL59//2YnV9V5uuaiCclke4IDomukBv+gyRdQaJZuEApaZ7ZHi5eIAS8WS8jWI4bnYoPM51CpEFzyRCiaSNREwLOpUeGeYvctIdrUAmShM0mp9eyb90ALOjxWI+/40gVgbQaEvXYUpqtL/kbRT4jqNTK1KFnGSTBlQEq159yg3Kw/zvbWGKJRmws+krrh9TxHZDfECLq3x2IsdcV5CrYvFA9tm9y/LZNX8n2l0s/+ODHd/cAuCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv7+alfGmC0L3lFcIc83KYYoR2JcfcX7O1Gra8tjvrs=;
 b=KHe12cSAtVE1u+70JJj9/rEJKi9ZIN61j/npVhI59JEDi6TsHMdWwwmrnEm7FjsVls0pDDWdt4V6yWX1rjchshfVbbUPBMNQ0y0CXHol9XyeDffi7QY56DjYRyvUJTM374IetVzvm5A7lVFX9deZKEoZXigIfcOq5vELPtoKbyBW9idBfm4YIv7msmZ4hoEtufHKelKmCPOb1Q1nZO34k/tDC0bLfXda5EHzmkl3QpnRxxsPii5yoz3bb9jzHRZffO8BmQcK1fEmfsZx7tAUHr95/aeAqaAKaA4v0JjVDAg/eAVJLMt/rLGnX2gihilJiS8YRdo2/hOGhYi/xmnrYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 14:06:02 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 14:06:02 +0000
Date: Tue, 30 Apr 2024 11:06:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 4/6] iommu/arm-smmu-v3: Make __arm_smmu_cmdq_skip_err
 reusable
Message-ID: <20240430140600.GP941030@nvidia.com>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <25150aec77edf5590bca81f4a418ef1ee7b21952.1714451595.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25150aec77edf5590bca81f4a418ef1ee7b21952.1714451595.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SN4PR0501CA0008.namprd05.prod.outlook.com
 (2603:10b6:803:40::21) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 1068d6fb-cc19-4b13-ea4e-08dc691eaaff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2IgN1BIs/dI+b/lWVKfq0m9HfPE9LmbHvLCXQRClmOAdKpmSfmz6JkYXNwW/?=
 =?us-ascii?Q?4r2048sNJ7Px/76/ZrbyOSNhbvND2X8ZygsVpaeBmb/dZZ1F+CT8rQCcrP+F?=
 =?us-ascii?Q?2mp1vtZWA2ToKScLnjvauODiMTIazDzlYnf6hzxysFzWaxV6T4v8U397vHbH?=
 =?us-ascii?Q?isRnNjUJyMTq91dMgPk1lWjIksn4+v6PeaNYlZsN1XaaisofQdrPJFH9mJD/?=
 =?us-ascii?Q?cYHG283mdIXocqSp3ioqDPhlPdCBzfrmd8HQMKsYvU3P0pkpQclwTqogoHtG?=
 =?us-ascii?Q?BW/kPjsiyN13e71viT75UAXiSqghI8sk6NXzO8PpEu3z+lS8Gan4giQQwpIJ?=
 =?us-ascii?Q?TpG44CcfGveusKHXyFUVZvK/RQulCSyRf8F/g2bFu4sd2mUxiyDPqEnJiDWB?=
 =?us-ascii?Q?0YICgwP2iliRZlaW7rQOREE6t66VM+XvSh1zUGcBE3OUCCd65cozqCotvcN1?=
 =?us-ascii?Q?mevz56WUAV/ClXhLz4tx0Uv3E7Lwh+VHjiTLo8KPh1b2uowKjFNTb7vTvG+x?=
 =?us-ascii?Q?XwV4LE775ERbrd/PmyoOXCWi/doxqjkljOHs2W2273REhNJpLnTK3XYGRmyw?=
 =?us-ascii?Q?ZOv/0H5wQwxkiKIMxmZRw65h6bFDV0k5rqpuBOxXCVupRs8qOr6iPQRfHo/J?=
 =?us-ascii?Q?biWEwdaAyxYHxoUPykMEdJwT4xt/BPhN2lDEd7zT2tDL7q3yw/I2rCh4tCHi?=
 =?us-ascii?Q?oF6s94Ykx0DFVl1jYTJTBpvTzLwj3j+DgJo/PaWo6S/11MOk4dM05lCZEmju?=
 =?us-ascii?Q?7FVm6OGZWgBDbPH0cVS+e8CfrFC8xAJEUZPlA4eKtp+3hHpG1m8xn9MY740s?=
 =?us-ascii?Q?p9MbG2QLXkKit/XLdV18W0sTut3EONO/LU5AVL/C1LIcwH7/gy0rhzTodddd?=
 =?us-ascii?Q?mZyUZU6tmtLAZwNLSaBWTiz0gHXsIz4gLASjI/ZHDueJA0HNnztQopGhC8qb?=
 =?us-ascii?Q?Sd7lzrOw/4wwYj1FmFrF6Wz+68xrIsuPG4q7Ps4cWS8syOCVyVXy3cZfqXJW?=
 =?us-ascii?Q?p7rIyNKo2pJm9F1D+2YVtkrrgu2ipWGgQyzp3fIjwyhVwUUaawMRankK3DxR?=
 =?us-ascii?Q?1Mxs+uDDrRL2SMd75kuSQb/fJ7zaGm5kM4XT4rs4eYve1y1ugEw27wEYN0UE?=
 =?us-ascii?Q?s1voblsXurs7BvQlQDWv1h7BYPQtqPWnAcOeWvduMiadFV0La0pUMLd4PSBf?=
 =?us-ascii?Q?r/IieYUzxSlm6MJy7pvkHM7Zs33C4lKjDMdxEnfxNjea4+GrkSQCgsY5aCQB?=
 =?us-ascii?Q?y4caOh9X3msXETAu11+SebVcuhPrDpqiEoTAghgAmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ot/r774E8O6OQtcO74+Z1BIAAX3gTcYw7rOjKIkqhaV5sHzwzaoPIowhAc2E?=
 =?us-ascii?Q?sbkpxiz9eFdmLY9IYYENOQFiClxKkmXZBnZ0oJ4cr2hse1lQp+fjtdyCmyo0?=
 =?us-ascii?Q?me7brtZKw2Xz1y0d7IlcKeA0OICEFVXgucx5z2myhn9p5YeYL6ruUUQACn4O?=
 =?us-ascii?Q?3xTojfI+penGC6ib6FbDACg0ntuup5JcXjLRJHLH9lMXnf43oIfY7tgNyc2t?=
 =?us-ascii?Q?W/FPODtCAv4ufIwWaNE0beWJc7mQUoFiG7jb2Mfzsme8vLgS+L8ZCaczAP7+?=
 =?us-ascii?Q?YZqHzaVjWwjBBQcBWbkcr8D87u+x1vMSTPvdyQagKz//BJO8JQtUD92WfINB?=
 =?us-ascii?Q?3vVSgop0thlX46feKcsSm0si9JpRbCaqB6S7ckL+2tRfsLuLcQnMwBo/MXNW?=
 =?us-ascii?Q?JWpY/0XA+x+nEKxvSXUOKBprKMuSe5p7KHxiHK+UGBUbbnwL4QzWSHlXV86o?=
 =?us-ascii?Q?Cuc3a0hx5qD6FpG9eq1bmTfYr65o3anpcvZXNZv7zrRdHyfJ7vcLIqFzn/vV?=
 =?us-ascii?Q?SbOc/W8p5qZyRJROQUSFfqWyjQ/88Oa6O9U9B4ywI/VkPt3habcvMjJujMg+?=
 =?us-ascii?Q?qEHyWnqPC9rOQpknNxif1QqLK3CblIBQFFh5OtNdyXDVhFbm9QlNTgwQI5xQ?=
 =?us-ascii?Q?13AIYLyDwineoT5wM+XVhz36yH0OOzbs6j3VNMjRAavtU5I1hGqFacUu8z/s?=
 =?us-ascii?Q?DOtlTnX0ydj7dyWwLIz5efkm2ffiU42/9NOUwzFjzkYHkHUBbjIt0lJo94wR?=
 =?us-ascii?Q?d9a1Zhpu6Xpf9arxpvmyylWmj9uFO+lblDP9hnR7MCKWzlszpCJ4dvjIC3Ls?=
 =?us-ascii?Q?orTfw1RrRfxcOvkb7BZRrNd09C8SL4xUA2/Hkpaxr+Dk2ObBSEnYbtOdfL0L?=
 =?us-ascii?Q?mwi/wRC1Dk7xOytu+A4daC8OW5Td+k9/MFoF5BclLGHgllfR+O3n340/l9lI?=
 =?us-ascii?Q?vGhE2zrxluzOySHrsE31JQM/dXvZOJGbQ2vQt/Y+pCi9b29pnr3Ffn3I4qnz?=
 =?us-ascii?Q?nl8awNPX8v731eisLYYKdVAqtnLpaZmaeVzjrglPSaJDa59Bg2L7mP40dXpO?=
 =?us-ascii?Q?79pll/4cHZJylHruCgdln/QNvFBIOFxglHxeYt+TC/b8qJM8kyQGOazySdAk?=
 =?us-ascii?Q?iyP+pRcmPIcJxbkehAO2Tl5VF4dJPTAa425g8mS8vJSDhzPdXrrfMELPylgl?=
 =?us-ascii?Q?RHM6iMg4ahFdQaHxt04TMRLdeWe/IHxsXmtJ6HlHaSkR6IkBfX3PL4MuUUVW?=
 =?us-ascii?Q?4DLAqWYage0J5abaHvxSF7RmytnSjttAuuN7KDfABNHR8qMZlreQvkNzzrfd?=
 =?us-ascii?Q?nsHOfK4VPA6YgWDhgGwUuwHrDVq83bguMJm20wlWCpxWaZUuBXI6B5rVFOjr?=
 =?us-ascii?Q?v8ZuIiIH8YwVhLn1Wk9VsU0xIz0q5rqQxL/izI9hRhHFz0OrywcqBb8KcYwh?=
 =?us-ascii?Q?o/aAYIazqx4RwBu1b5pr16IRzdaQvBNufYzL710BnXtu3WtvxFpAfZz/ta5j?=
 =?us-ascii?Q?LP/E2ktQZF9rw2Pgl/vgELecIBEtImyJOkjTdrk7sMQ+LO/vqsXcwkcOlCEK?=
 =?us-ascii?Q?kjIsq98Y+eJgJ7QutLIfjfeAau55/lb4r2UIaYK3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1068d6fb-cc19-4b13-ea4e-08dc691eaaff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 14:06:01.9990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nr6L7Z/2aqCyGn39CpIdgTIeAKfTjoMKLGRG7NFC4YPjNejxk7cmP16ldxG+oiSH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165

On Mon, Apr 29, 2024 at 09:43:47PM -0700, Nicolin Chen wrote:
> Allow __arm_smmu_cmdq_skip_err function to be reused by NVIDIA Tegra241
> CMDQV unit since it will use the same data structure for q. And include
> the CMDQ_QUIRK_SYNC_CS_NONE_ONLY quirk when inserting a CMD_SYNC.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 538850059bdd..5111859347d5 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -379,8 +379,8 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
>  	arm_smmu_cmdq_build_cmd(cmd, &ent);
>  }
>  
> -static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
> -				     struct arm_smmu_queue *q)
> +void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
> +			      struct arm_smmu_queue *q)
>  {
>  	static const char * const cerror_str[] = {
>  		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
> @@ -428,6 +428,9 @@ static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
>  	for (i = 0; i < ARRAY_SIZE(cmd); ++i)
>  		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
>  
> +	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY)
> +		cmd_sync.sync.cs_none = true;

This hunk should be in "iommu/arm-smmu-v3: Add CS_NONE quirk" ?

Jason

