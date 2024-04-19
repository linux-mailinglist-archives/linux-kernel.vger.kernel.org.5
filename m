Return-Path: <linux-kernel+bounces-151811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14D08AB437
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9331C20F49
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D501137930;
	Fri, 19 Apr 2024 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RG3PVZFX"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B1113A263;
	Fri, 19 Apr 2024 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546790; cv=fail; b=Z3/dl2jaQU8GgDIxSnckdkY4iLHhyDxXR+RoHvkyr+nf41VpTvRkcd9+YN3BuLOiGep6cCG6b4CKdTsYC81cHMgO5o1oFess0qn8uti6SF6pjWlKugcDJlUqxovfO+Ynojp7LOMPYgdhUYF1QlmZDMEdA7w+K+wucQr0L6LtOr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546790; c=relaxed/simple;
	bh=mqTPclps3AmS3KTDiyEBm6gOyazCCaeWxJytr6fWX2k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNUh/d7e+KrmCvQpgJBdsn10zVpQomv/hPHI9bzb/o7S+XI971TTbhi0mQFTEXGomqa+suX520RvPgj2SPJwMH4JucvEoKWPLoJTXk/UkxCr5qdn5lWWcXbW5mTP9mRrETIJreKPWuvYtuF/sXzXTdhvebLwVPMvfmOJuYLhC/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RG3PVZFX; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVs/BNhuvNy1mWM8c1vo9xRxezsTK4h3A8Pdn1du0UEny6325hfZbSgju/WHrxhr+WLQWtHe/kTCHJTxfcCrLXZfn+wYzqGdOpN66O/3TVoY+qolAiIY9ZSMbQMz4p1yUMjo0+xXrEcgtR2CI9C7rfb3Sp2BoweknS+XN2k8ZQcw7n21PlueIqVKdtR0eY4INdemhU35LKRIcGDxD3SBz7fF+E/fb1cP1GwVhqLdU+g2hDe0QmvCnkt6iXYG4L1C2IesCtisFfyCuxLHRp/Xsj8h7r740WpqfK7DIwjDvWhC2gSSr9poNrR/sdC+hsMtEptsI8ZGuT/wKfHlEXVq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvhiYh0CNb7+OKegWC/nYxq0nsiBeCz90VDH4RJPPYM=;
 b=Gx89USvCmXXvEZkWMEAx9msvZ4d1ZH7Ub5eaoJDD07Z6j/5Rhxby1oJetQFhbxO3/ToeaowDjCLw00J3T7wcCTvIxcOIsDC48FQYk6+XD5XFcixIqSdV1FuWE64J/21LGreBuGkLU7rVL9Hpz5A6CztRO+PuOYgU4soaH0e6SvKBO3UycQcqAccRMZiTRqRIIeu8NYi5hm+Ccf8XNf0anfrP2Wy9viYaaOPuFpqjsymU7smFza4gUCFB2YICJUYTbXpp/uVyDYP5vtDC39WpAmpBQ9y6PtsiNMcH/jC7CiYFpfD1bIWIOiqvvtQPa/JKubPocJij6Nv4deiWt+Jjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvhiYh0CNb7+OKegWC/nYxq0nsiBeCz90VDH4RJPPYM=;
 b=RG3PVZFXHL0ePs0yrgpfsAV0LGVOvMLnfl5pKWN6B5cLR4vwXl1Vpj7duudr2Z0J1gSUslqZa6NAkpYdAU6AXSoqbI1tMobqpfuSB0wNVxLaLErUl7bwBWpiYwjFbLhDMYp6FZV98ePF/6Tawha1j3FmQ24x/ubylop1/GgAIRly+FlVT1bxU868qmhSQJxTk/9DwXaA+sArS7l9RrXnBeWZEYH+FBOq1d5UhmAcDFT6tSpMO5En0+/RwGpB6rLrIXjqzlSfzxBzRhX3VjJOSZMKi55WtC3NFmJ7JzSH0TKdGzMIpKQ2haRgNas2HH+7DhOpxheUJkI8ZkphClcBBg==
Received: from SJ0PR03CA0091.namprd03.prod.outlook.com (2603:10b6:a03:333::6)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 17:13:05 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::24) by SJ0PR03CA0091.outlook.office365.com
 (2603:10b6:a03:333::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.30 via Frontend
 Transport; Fri, 19 Apr 2024 17:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 17:13:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 19 Apr
 2024 10:12:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 19 Apr
 2024 10:12:46 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 19 Apr 2024 10:12:45 -0700
Date: Fri, 19 Apr 2024 10:12:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v5 1/6] iommu/arm-smmu-v3: Add CS_NONE quirk
Message-ID: <ZiKmDCAnAc0sRT7K@Asurada-Nvidia>
References: <cover.1712977210.git.nicolinc@nvidia.com>
 <10a39a51cae4de9ef47580f0c4439fb6c5373588.1712977210.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10a39a51cae4de9ef47580f0c4439fb6c5373588.1712977210.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc9b12d-f107-4729-1f0a-08dc6093f9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fjTOlyDo0V8VYplXMBxZkaTnJrS2FBBg1me0SOC5vUqZlrbGav8FfPAo/M/u?=
 =?us-ascii?Q?42T/xoUMZ4u3kxUuuyYViPJjecgznnvtEvpug4DeOQlnMkaaBL/exja3S42X?=
 =?us-ascii?Q?5k22H6oCO2SEa9Tpm+WLlLC2gGQqmNPtQStdx56aAiadyOtGrg0eek0nqRvi?=
 =?us-ascii?Q?VcAwO7t7ugSGyh+KTeNG9fpJ43ri0UUfFSQ9WghYs99TvSqOobcrdOPltYmX?=
 =?us-ascii?Q?3yNNYa/euhB5CCjKr0ajnsy14S5DxeMx4yqyhTzv19FQ/SuVqQ4UEEXSoo3d?=
 =?us-ascii?Q?tWjj22Hd91iV9Pmn8ZlU+xkf0oRqDuwGuDSHSrEC+7dzYsrNxsDAbLGm2pQN?=
 =?us-ascii?Q?baugt8xNwAQP/fB3PYxWNdOUK8Jrt2smWiC3Hvi6ePqa/0kJ4wa19srhqIUM?=
 =?us-ascii?Q?0MAjzN2WqfJL8O6LDBiv3lSyCGiB+B852AAZ2IqUsRDaMif3N0iDMZ6vN+7R?=
 =?us-ascii?Q?/rUkQ5cZvztY5mKV5bfj4rZ0OxW/7tTK1Lc3s5aK/HY6rLRUZvS932yabrkO?=
 =?us-ascii?Q?aQolQvPmfDbDUI0+WUxFWcGxuLpUw7JO+GmvYZIeQf/CRImAzFiPYzYK/uhI?=
 =?us-ascii?Q?DTQ+rJu6j4nco3vAvJTvA8mvAWs3WcvIVjk36JFgq1BvxrUS9FfDTt8nNosz?=
 =?us-ascii?Q?ZGPA56lrlMqwX/pFGU+RzgsyxkR7qs/GL7BxFuG4MWiHEYF7XSc12TjUoWwl?=
 =?us-ascii?Q?KNZU3LoW8b0EbygqtP6Akd1HjsW7oiIaGLhFM7x0p7UbWqkibNMsJ6Q75n/4?=
 =?us-ascii?Q?8rd/bGibYqefz35spJoRNnej2sHCVDZyc4CsGGZMYTInD5xu7yCWmHw8Au9F?=
 =?us-ascii?Q?uGL+2n9ezL6M1UK+6eWniMfE4b5RcLY4nRYXyD1g99Cd8lZJ0Qqs8Yniuc7B?=
 =?us-ascii?Q?IrCTGkgBeck/46KAZGdtqJ9fLZyOG2s6PWwDtWk0R2FOIao+L+uUaP20b1Pr?=
 =?us-ascii?Q?8W2/cbKNTvw+QK9yGleZE5eMwzZFkfxA8bYG/0EDu9Cy/FyqsrJ/RpfaT13o?=
 =?us-ascii?Q?VHYR2SkCxJtwfmtKiA6VYPi6t6bO0421xL2WRAZGwt8dQCIjcIGfvh5UIJw5?=
 =?us-ascii?Q?gdsJJoP5XMq62NgPBpDtUhRM7HJv1UMv6aI+p/68QfGNW/9Q5+tDRqhr19D6?=
 =?us-ascii?Q?rJwJO2u/QoFx4n8AyaYkax9gd0LE3MGklwp1FM02NDsTkzlNbrkDYphZQBWI?=
 =?us-ascii?Q?U89ylhPls+TF7chYqyZs3PmDJVCVB9qvMp9s90TDW5oWvYlgvAGGtPTy1kT5?=
 =?us-ascii?Q?ghbw/S9ZfNddPAN+J0Rh2ZIKlr822Fkn9+Ts0GA8RbP4bGJts+DJeI6mAeEi?=
 =?us-ascii?Q?SsvXRa72kNs5tpWdbPSW4HcQPgiogBEehjE5t3g8clgyla80eyGO8lwMXESC?=
 =?us-ascii?Q?2rJlBHlSYJxx2OEKnokxnpVJ087/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 17:13:04.4610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc9b12d-f107-4729-1f0a-08dc6093f9bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

On Fri, Apr 12, 2024 at 08:43:49PM -0700, Nicolin Chen wrote:
> The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
> CS field of CMD_SYNC. Add a quirk flag to accommodate that.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  4 ++++
>  2 files changed, 12 insertions(+), 2 deletions(-)

> @@ -707,7 +712,8 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
>  static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
>                                          struct arm_smmu_ll_queue *llq)
>  {
> -       if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
> +       if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
> +           !(cmdq->q.quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY))
>                 return __arm_smmu_cmdq_poll_until_msi(smmu, llq);

Realized that I should have moved the PATCH-4 to the top for the
cmdq pointer here. Otherwise it breaks git-bisect... Will fix in
the next version.

Nicolin

