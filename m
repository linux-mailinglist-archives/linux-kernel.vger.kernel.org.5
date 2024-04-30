Return-Path: <linux-kernel+bounces-164401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D08B7D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32F21C20FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C39184136;
	Tue, 30 Apr 2024 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OERjnFA4"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5DA184133;
	Tue, 30 Apr 2024 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494954; cv=fail; b=RgSL1KDD/3d/Vcjzo0HxkeLw92sgnHkAQhoHLg25GPw5Lj9i03TPy4Zejq8jMiPUpGpgEESycSLpoEuRNqQMYriKDJ/y2CO4QZ09XObVXGvgwjyKtZdDzBz6WtzKcwJERhArwrUNJ4aQQ60E1K+9E+/8mqdyFfyjJpHujWImBEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494954; c=relaxed/simple;
	bh=+nddv1SbChNDGQKEXwbBjS/2SRNPxO+ETw07qphAc3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CACO3Asvs9DyuDYKw7UhfngUFQ+fCKiKOymlYdpbbOvmfLJvoXzIhn1KGDBs3etU2GLIF0UOBaCCdZoQSkSJLAgpcnzMG1WIWt5g/rpMwkOqWS7wKNyKjCOp/CczRS/udjaKsU/KtqQpKg6xgLrPnTVTIkf3KGqcz4yoV5vGDIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OERjnFA4; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HohTbs7FVvDzvW/+BzSKIDI8nx80Zi2GG6th6ifxG9FZvrNhxt3rSiPkBIL4qWvCDOQpAkF9JG2H3a1GRPoSrY/3zkR/YiEZoAFSCUsK9fowyysoXPEx1tuYVOL1tWTCsROZ7h2Lq+dDhXMB0ULNVLP2+PZPCJCwuJNGbW7CeRlG+KQG3n7agx/X7HHmlo8YMWhKTfdUGKGyJ1y0SrKLQqgYIpFdvPerDhr1GVdHzfPb9Gbz5QpSTsPKQDUDXIBheaKS1gwGBzuoywh8e2G8EWZ5g2Boyfr2RTgIdnrg+1/LQ46XmHTOiJ6uuLEZfSXnjm9xxk+TG7GMIQsajpVaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bg4I3Fr20dtLv3BAl4ttkOQkvDnPE59fyxPVZy2aUZw=;
 b=CNQkgmf0VhOGXENBBkt35yL40pvua+2Q47REcynxsas9P4qluHt/J087WIpepZPFWqlJZpNLBht6pzthLN0kBb9LG+/ct+iTo+Jzttgm9ndJJARwc0hQcXe/qS49exVVeRgyFUWXGlFUi2656DlRKdJs9p2fL0rns/HzcfFziMHAowdTmcodO82DeheMWZWHMMaqm+SeIo3wIsGg/U8Tt1CnEjZuF31gBv5BeBLdbcZxMOsq+C3B+1trOdLoJOp1/h8HQT7jrqi4GatWjAfypMLi5e6DNY5Ns7Kcb6qQudW4VqI0/7c/LL0eNLOX82j5sEJV2QnLORY1ZyJK6LFcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg4I3Fr20dtLv3BAl4ttkOQkvDnPE59fyxPVZy2aUZw=;
 b=OERjnFA4jqTzVqhYDzhsyKz9vV3aIget91jUOJcUJlklDXzLvPEtU4vIcOPiFuQ75g9CcURG7I2Sj3TnduTFR6el5JZQjv+/9zLYQDlT+IqORbaOQj58fB4Uno2fzkcdvx67VXBCDqgNLGCrVh6PFOIc791U/nyGYBMqj877yYfCWZH//+Gp81I1qQQXyJ/JvDLVHUrUoZmyXaDWqo6/cG6H3D8EZaQE4B9I8pEJsPACC68Y7KtaaIrGRoBgeUxtP0nTGRzqMehDBsmj4MI8GoF2LjKvAR9EQ0AVCyntJ7Nv9KhimoRHsM75r76ouQX8/ra4s1wi0BlaeQtsmspaAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 16:35:46 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 16:35:46 +0000
Date: Tue, 30 Apr 2024 13:35:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 5/6] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <20240430163545.GS941030@nvidia.com>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <63414546b1eafdf8032ac1b95ea514da6d206d63.1714451595.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63414546b1eafdf8032ac1b95ea514da6d206d63.1714451595.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR20CA0049.namprd20.prod.outlook.com
 (2603:10b6:208:235::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW4PR12MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b623616-19c6-4d93-0552-08dc69339617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IpKFsWUjkRAmooQPTLFRmhFSnrMIc44Lp6X7HLunVlokCugaKY7yQY64jOh8?=
 =?us-ascii?Q?RyFQst1PzgVhmkqBOvn3446JmFZaCy8UUxeUCmsFMUBtjx9egdkVPDZJs9JU?=
 =?us-ascii?Q?GBAHYyPGfiT8xhTRztAREVapOIeYR/2hkQCk/iUhzJPhPlzAUdbzaKh3DKbx?=
 =?us-ascii?Q?dvwmWkF9EmiWAROZyViyIKfNkz72hBRV7pFelckUr5dxFB1PM71B4jY7t7kz?=
 =?us-ascii?Q?UgpXWV9L1L6odWPyExzhFaro62hLk330iQEdGcsIz9CZ76JAwTT6A9jX5nDB?=
 =?us-ascii?Q?Q7a29OhV1UiCoBbolIZv9kmq7VEtIA1y3QTnARi5+78snAEparZU6gPnWiE2?=
 =?us-ascii?Q?o8aYd6atTwLfBiyLPBtm6irRb0CWtm34E6p12WljnnGm12rS860kwqilJCmb?=
 =?us-ascii?Q?8Ztq1nhHE8ir7J1upCfF6GQTc5Lif9zZVBeS7PtaRZGenQgXCtZr/lwaqPRE?=
 =?us-ascii?Q?YDF6RbN7D8XB0RDlTEG42zN1tjHrcQH++rfUCDzBmvFoxlsc9mG9ul3zOqhO?=
 =?us-ascii?Q?kc13ysOL69fszUt4Td8tSp/pt0Y41de7eH2n7DN6GCiKmnVebdP8dp7YkKlR?=
 =?us-ascii?Q?opJB/W+qYNsErBLdCTKxEp2s8GhBIjbPwrgOPJbUSimFlmOwYr1LQgLhMyNp?=
 =?us-ascii?Q?aO0bafZO80cmOWQQIQYI2J83YB6W/t4gXXtC5BNlDGhhmYt9LjL4rXu1xQzp?=
 =?us-ascii?Q?hWRoNSKacLSahkyGCS8otyAJWkPB3P06odbfhgVIpaJqQc5HHFsl+I/cowwY?=
 =?us-ascii?Q?sYBpQW/2cBzS7jJ47sV9AldBaEX4/BIV2e8SqTzm03alrQVEAz0MlBH45FJn?=
 =?us-ascii?Q?/p41pFijFdL6Du6hIIhMU4iRacaQwF9FMCNx2vr4Mznjdo5/5ywgbadSScAb?=
 =?us-ascii?Q?PkR9UgcgABTPyd3swY3lsdwedV+FMIqS/qF+3Po1c75P4mseFBcQqFhtYMsE?=
 =?us-ascii?Q?qMj1Yt4qL+tMM24xdBO3/jbeRtVqFPN/KBEGEZsAr57vCBgpHdwebXYlU8Nv?=
 =?us-ascii?Q?vB5ultb3EHI0XYZaiztOJSmkUNv9vOhejTuUTfdh7Mm6LnGL8CaIC8bOS0pg?=
 =?us-ascii?Q?Id35pYzZ2+XVgTWkXAWjsANZiVxb3De/mEdxZ/PRSIEjfC8CAndc71hd7oye?=
 =?us-ascii?Q?BbAHVI6dQLL5nKmQt42X9R9UaK65J3isFUydnjspT/e/njXodQtTJeQOENHg?=
 =?us-ascii?Q?sKtxU8tiL2McGNh5ZnoploqhY9u6e0tsInwPUm+il7hKq/Ukh4Y+LT0cUD6Q?=
 =?us-ascii?Q?aWsl0wWfXWQMKRCNXmYO3V0otH9gewiWtjKa5/LRfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z1SitkVbIQ65Sc13NwLPMdOJoIfI0gUdlOVDSEdiVKSOGukStV8OsL79/DQM?=
 =?us-ascii?Q?Yl2plVNyI2TG2sxkjub/30EmN55vwZPwTPKT013IAv0wcrm8gkzf2z7UWgm3?=
 =?us-ascii?Q?DwKSlhrS//LriNp54RGfp5xHfyThp/jwiC2kLnblg12zDR2oHZVNE8kLQzu9?=
 =?us-ascii?Q?GW68LbRV1W0Ve555LWKZFnEIFV7CeTC73xdqsO0ylUTvuNEDi5VpH7CnOLQJ?=
 =?us-ascii?Q?igEmkg7bit8Bl+SIIDK0z/qkf1HkfciF38JwWDjyD7I59jvh1DAIsfCfdgzc?=
 =?us-ascii?Q?OHYDwScvOClN1u3clGFWDN9xlaPTd+AoP5h8G1TIV7oFD7jKJkzoh0PsKi6m?=
 =?us-ascii?Q?9ZRG4/z7bP7JpT9+V5g64u9Wy1XX+hKqTZ/FTCV/Tw+Y4qslS3o7iApI9t00?=
 =?us-ascii?Q?GpBRmxBPRi/J0Se1g4k/DnM/DAmnTOKU7ImYJ8aWnddZnOI2j83TsqcKI5IK?=
 =?us-ascii?Q?k0rEc6x1ui9j7zl9Iow9dMGlQlj/csEhJIti36KJDGpSmFid6TmfC886AC1V?=
 =?us-ascii?Q?2JSI91OT8oHhzvr0b0e6mmasJ3keUrfAlMjXAOgcMlnkjWohn+pP7y1KBVNI?=
 =?us-ascii?Q?EJdcEP/BY4Y9akC6YRZWJ1be1VECvRq7fsy4W+e873iMVUhxLV/rHEKSU2sq?=
 =?us-ascii?Q?lVlg2+fodTa9oPk2MjxSR/Pp9ULZZrFgwDNYw89xP4+8aBuLAvJEprM2UZ9m?=
 =?us-ascii?Q?Std3dQLIvDzikXu5tHWFwIjiolAXltn16GYuwGvDx3yCXbR4WK4X6Pc9FQKb?=
 =?us-ascii?Q?qds795sjABQmh3Qczt8Mx02LVz7GO+Nu8F1znRLQ5xuLLWe4wjjSAp/yydGw?=
 =?us-ascii?Q?cIad3NslBTIlcAgklIHax+GzlRPZkoARyBFA6KAyHs1WNiFAwbPJ+CsxhFvM?=
 =?us-ascii?Q?Z0ymuFlEcuIJc9/p2QvK5Pnk263VIbwDmhEt2yVDkOq/dxhyM4dVdMaYSgeZ?=
 =?us-ascii?Q?tF/+Tvq94TXbJP+9WJrrI4qWyZFlE3Yxag+BwoPNXR9SvzZFZFk5A4nKBBgs?=
 =?us-ascii?Q?VywX97MP/JO4/dLTjvTMyzDCa27+xcmsd7RHxb5Sstq2SIfEPz+krWjumEGr?=
 =?us-ascii?Q?gLRuxs/sT/SnjcAmCutS94W1c0NW/3PSL5q6qu8onIriRRnVAtaJk4HSpHR8?=
 =?us-ascii?Q?87cjftN6vYP1LnFxPrWZx7BC3bbVm0kVSyMLzy52tkvTDH0KxvF1Xs5bRvhg?=
 =?us-ascii?Q?mQWCXf1BflTMQkY3x/uHXe/TAva3/GrxX4bp9Um/+ZofADfVso0qvSDcrheV?=
 =?us-ascii?Q?To9Lo8Y2JesPQHrewcUrI6LbAaTMF4TPhEd7KrW/E6FHIp8vVCb07qx1Hfd+?=
 =?us-ascii?Q?D7wfH/WneXPL5beQyNUP7jSdzg3b59jo7/aFdZiCqOQgVgu+rcjDb3xKTPAF?=
 =?us-ascii?Q?jqxM6zVr7GclDMSqKXFdozIrKd0gRrkMXIlXVpe+adqMg3nju/NlDRQS3pFA?=
 =?us-ascii?Q?HIlVjNoiuIW42I6UMxgzUbw5yM557ETWSecMeydAo44V/4UPT2nXtQ+S40zG?=
 =?us-ascii?Q?OjOr3y+lhIqQEXAGZmeXZWAqXMrQvAgwAJR1xJ3JEZk7cqMYbAdixSmqN3fl?=
 =?us-ascii?Q?3I/3lMDX6jLdjgrFN+ym3ct0a2S/wzaurXEgDRKk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b623616-19c6-4d93-0552-08dc69339617
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 16:35:46.4094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRnXNVj9rtIUVSOQ0SKwFhSfbbXc1Vbc0KOvM+wjTHFGlw2px7nJG7XiakFYQ6hx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264

On Mon, Apr 29, 2024 at 09:43:48PM -0700, Nicolin Chen wrote:

> static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
> {
> +	if (smmu->tegra241_cmdqv)
> +		return tegra241_cmdqv_get_cmdq(smmu);

Since it is compile time optional it would make some sense to optimize
this (in all the places) too:

if (arm_smmu_has_smmu_tegra241_cmdqv(smmu))
   [..]

static inline bool arm_smmu_has_smmu_tegra241_cmdqv(struct arm_smmu_device *smmu)
{
	return IS_ENABLED(CONFIG_TEGRA241_CMDQV) && smmu->tegra241_cmdqv;
}

> @@ -3105,12 +3108,10 @@ static struct iommu_ops arm_smmu_ops = {
>  };
>  
>  /* Probing and initialisation functions */
> -static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
> -				   struct arm_smmu_queue *q,
> -				   void __iomem *page,
> -				   unsigned long prod_off,
> -				   unsigned long cons_off,
> -				   size_t dwords, const char *name)
> +int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
> +			    struct arm_smmu_queue *q, void __iomem *page,
> +			    unsigned long prod_off, unsigned long cons_off,
> +			    size_t dwords, const char *name)
>  {
>  	size_t qsz;

This hunk and the .h file part should be moved to the prior patch that
is de-exporting things.

> +/* MMIO helpers */
> +#define cmdqv_readl(reg) \
> +	readl(cmdqv->base + TEGRA241_CMDQV_##reg)
> +#define cmdqv_readl_relaxed(reg) \
> +	readl_relaxed(cmdqv->base + TEGRA241_CMDQV_##reg)
> +#define cmdqv_writel(val, reg) \
> +	writel((val), cmdqv->base + TEGRA241_CMDQV_##reg)
> +#define cmdqv_writel_relaxed(val, reg) \
> +	writel_relaxed((val), cmdqv->base + TEGRA241_CMDQV_##reg)

Please don't hide access to a stack variable in a macro, and I'm not
keen on the ##reg scheme either - it makes it much harder to search
for things.

Really this all seems like alot of overkill to make a little bit of
shorthand. It is not so wordy just to type it out:

  readl(vintf->base + TEGRA241_VINTF_CONFIG) 

> +/* Logging helpers */
> +#define cmdqv_warn(fmt, ...) \
> +	dev_warn(cmdqv->dev, "CMDQV: " fmt, ##__VA_ARGS__)
> +#define cmdqv_err(fmt, ...) \
> +	dev_err(cmdqv->dev, "CMDQV: " fmt, ##__VA_ARGS__)
> +#define cmdqv_info(fmt, ...) \
> +	dev_info(cmdqv->dev, "CMDQV: " fmt, ##__VA_ARGS__)
> +#define cmdqv_dbg(fmt, ...) \
> +	dev_dbg(cmdqv->dev, "CMDQV: " fmt, ##__VA_ARGS__)

Really not sure these are necessary, same remark about the stack
variable.

Also cmdqv->dev is the wrong thing to print, this is part of the smmu driver,
it should print cmdqv->smmu->dev for consistency

> +#define vintf_warn(fmt, ...) \
> +	dev_warn(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
> +#define vintf_err(fmt, ...) \
> +	dev_err(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
> +#define vintf_info(fmt, ...) \
> +	dev_info(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
> +#define vintf_dbg(fmt, ...) \
> +	dev_dbg(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
> +
> +#define vcmdq_warn(fmt, ...)                                                   \
> +	({                                                                     \
> +		struct tegra241_vintf *vintf = vcmdq->vintf;                   \
> +		if (vintf)                                                     \
> +			vintf_warn("VCMDQ%u/LVCMDQ%u: " fmt,                   \
> +				   vcmdq->idx, vcmdq->lidx,                    \
> +				   ##__VA_ARGS__);                             \
> +		else                                                           \
> +			dev_warn(vcmdq->cmdqv->dev, "VCMDQ%u: " fmt,           \
> +				 vcmdq->idx, ##__VA_ARGS__);                   \
> +	})
> +#define vcmdq_err(fmt, ...)                                                    \
> +	({                                                                     \
> +		struct tegra241_vintf *vintf = vcmdq->vintf;                   \
> +		if (vintf)                                                     \
> +			vintf_err("VCMDQ%u/LVCMDQ%u: " fmt,                    \
> +				  vcmdq->idx, vcmdq->lidx,                     \
> +				  ##__VA_ARGS__);                              \
> +		else                                                           \
> +			dev_err(vcmdq->cmdqv->dev, "VCMDQ%u: " fmt,            \
> +				vcmdq->idx, ##__VA_ARGS__);                    \
> +	})
> +#define vcmdq_info(fmt, ...)                                                   \
> +	({                                                                     \
> +		struct tegra241_vintf *vintf = vcmdq->vintf;                   \
> +		if (vintf)                                                     \
> +			vintf_info("VCMDQ%u/LVCMDQ%u: " fmt,                   \
> +				   vcmdq->idx, vcmdq->lidx,                    \
> +				   ##__VA_ARGS__);                             \
> +		else                                                           \
> +			dev_info(vcmdq->cmdqv->dev, "VCMDQ%u: " fmt,           \
> +				 vcmdq->idx, ##__VA_ARGS__);                   \
> +	})
> +#define vcmdq_dbg(fmt, ...)                                                    \
> +	({                                                                     \
> +		struct tegra241_vintf *vintf = vcmdq->vintf;                   \
> +		if (vintf)                                                     \
> +			vintf_dbg("VCMDQ%u/LVCMDQ%u: " fmt,                    \
> +				  vcmdq->idx, vcmdq->lidx,                     \
> +				  ##__VA_ARGS__);                              \
> +		else                                                           \
> +			dev_dbg(vcmdq->cmdqv->dev, "VCMDQ%u: " fmt,            \
> +				vcmdq->idx, ##__VA_ARGS__);                    \
> +	})

Some of these are barely used, is it worth all these macros??

> +
> +/* Configuring and polling helpers */
> +#define tegra241_cmdqv_write_config(_owner, _OWNER, _regval)                   \
> +	({                                                                     \
> +		bool _en = (_regval) & _OWNER##_EN;                            \
> +		u32 _status;                                                   \
> +		int _ret;                                                      \
> +		writel((_regval), _owner->base + TEGRA241_##_OWNER##_CONFIG);  \
> +		_ret = readl_poll_timeout(                                     \
> +			_owner->base + TEGRA241_##_OWNER##_STATUS, _status,    \
> +			_en ? (_regval) & _OWNER##_ENABLED :                   \
> +			      !((_regval) & _OWNER##_ENABLED),                 \
> +			1, ARM_SMMU_POLL_TIMEOUT_US);                          \
> +		if (_ret)                                                      \
> +			_owner##_err("failed to %sable, STATUS = 0x%08X\n",    \
> +				     _en ? "en" : "dis", _status);             \
> +		atomic_set(&_owner->status, _status);                          \
> +		_ret;                                                          \
> +	})

I feel like this could be an actual inline function without the macro
wrapper with a little fiddling.

> +
> +#define cmdqv_write_config(_regval) \
> +	tegra241_cmdqv_write_config(cmdqv, CMDQV, _regval)
> +#define vintf_write_config(_regval) \
> +	tegra241_cmdqv_write_config(vintf, VINTF, _regval)
> +#define vcmdq_write_config(_regval) \
> +	tegra241_cmdqv_write_config(vcmdq, VCMDQ, _regval)

More hidden access to stack values

> +/**
> + * struct tegra241_cmdqv - CMDQ-V for SMMUv3
> + * @smmu: SMMUv3 pointer
> + * @dev: Device pointer

This should probably be clarified as the device pointer to the ACPI
companion device

> +static void tegra241_cmdqv_handle_vintf0_error(struct tegra241_cmdqv *cmdqv)
> +{
> +	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
> +	int i;
> +
> +	/* Cache status to bypass VCMDQs until error is recovered */
> +	atomic_set(&vintf->status, vintf_readl(STATUS));
> +
> +	for (i = 0; i < 4; i++) {
> +		u32 lvcmdq_err_map = vintf_readl_relaxed(CMDQ_ERR_MAP(i));
> +
> +		while (lvcmdq_err_map) {
> +			int lidx = ffs(lvcmdq_err_map) - 1;
> +			struct tegra241_vcmdq *vcmdq = vintf->vcmdqs[lidx];
> +			u32 gerrorn, gerror;
> +
> +			lvcmdq_err_map &= ~BIT(lidx);
> +
> +			__arm_smmu_cmdq_skip_err(cmdqv->smmu, &vcmdq->cmdq.q);
> +
> +			gerrorn = vcmdq_page0_readl_relaxed(GERRORN);
> +			gerror = vcmdq_page0_readl_relaxed(GERROR);
> +
> +			vcmdq_page0_writel(gerror, GERRORN);
> +		}
> +	}
> +
> +	/* Now error status should be clean, cache it again */
> +	atomic_set(&vintf->status, vintf_readl(STATUS));
> +}
> +
> +static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
> +{
> +	struct tegra241_cmdqv *cmdqv = (struct tegra241_cmdqv *)devid;
> +	u32 vintf_errs[2];
> +	u32 vcmdq_errs[4];
> +
> +	vintf_errs[0] = cmdqv_readl_relaxed(VINTF_ERR_MAP);
> +	vintf_errs[1] = cmdqv_readl_relaxed(VINTF_ERR_MAP + 0x4);
> +
> +	vcmdq_errs[0] = cmdqv_readl_relaxed(VCMDQ_ERR_MAP(0));
> +	vcmdq_errs[1] = cmdqv_readl_relaxed(VCMDQ_ERR_MAP(1));
> +	vcmdq_errs[2] = cmdqv_readl_relaxed(VCMDQ_ERR_MAP(2));
> +	vcmdq_errs[3] = cmdqv_readl_relaxed(VCMDQ_ERR_MAP(3));
> +
> +	cmdqv_warn("unexpected cmdqv error reported\n");
> +	cmdqv_warn(" vintf_map: 0x%08X%08X\n", vintf_errs[1], vintf_errs[0]);
> +	cmdqv_warn(" vcmdq_map: 0x%08X%08X%08X%08X\n",
> +		   vcmdq_errs[3], vcmdq_errs[2], vcmdq_errs[1], vcmdq_errs[0]);

Put warnings in one print only, spreading them like this just
increases the risk of tearing.. It doesn't need to be all pretty.

> +struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> +{
> +	struct tegra241_cmdqv *cmdqv = smmu->tegra241_cmdqv;
> +	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
> +	struct tegra241_vcmdq *vcmdq;
> +	u16 lidx;
> +
> +	if (bypass_vcmdq)

READ_ONCE 

> +		return &smmu->cmdq;
> +
> +	/* Use SMMU CMDQ if vintfs[0] is uninitialized */
> +	if (!FIELD_GET(VINTF_ENABLED, atomic_read(&vintf->status)))
> +		return &smmu->cmdq;
> +
> +	/* Use SMMU CMDQ if vintfs[0] has error status */
> +	if (FIELD_GET(VINTF_STATUS, atomic_read(&vintf->status)))
> +		return &smmu->cmdq;

Why atomic_read? The unlocked interaction with
tegra241_cmdqv_handle_vintf0_error() doesn't seem especially sane IMHO

> +static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
> +{
> +	u32 gerrorn, gerror;
> +
> +	if (vcmdq_write_config(0)) {
> +		vcmdq_err("GERRORN=0x%X\n", vcmdq_page0_readl_relaxed(GERRORN));
> +		vcmdq_err("GERROR=0x%X\n", vcmdq_page0_readl_relaxed(GERROR));
> +		vcmdq_err("CONS=0x%X\n", vcmdq_page0_readl_relaxed(CONS));

Less prints, include a unique message about why this is being
printed..

> +	}
> +	vcmdq_page0_writel_relaxed(0, PROD);
> +	vcmdq_page0_writel_relaxed(0, CONS);
> +	vcmdq_page1_writeq_relaxed(0, BASE);
> +	vcmdq_page1_writeq_relaxed(0, CONS_INDX_BASE);
> +
> +	gerrorn = vcmdq_page0_readl_relaxed(GERRORN);
> +	gerror = vcmdq_page0_readl_relaxed(GERROR);
> +	if (gerror != gerrorn) {
> +		vcmdq_info("Uncleared error detected, resetting\n");
> +		vcmdq_page0_writel(gerror, GERRORN);
> +	}
> +
> +	vcmdq_dbg("deinited\n");
> +}
> +
> +static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
> +{
> +	int ret;
> +
> +	/* Configure and enable the vcmdq */
> +	tegra241_vcmdq_hw_deinit(vcmdq);
> +
> +	vcmdq_page1_writeq_relaxed(vcmdq->cmdq.q.q_base, BASE);
> +
> +	ret = vcmdq_write_config(VCMDQ_EN);
> +	if (ret) {
> +		vcmdq_err("GERRORN=0x%X\n", vcmdq_page0_readl_relaxed(GERRORN));
> +		vcmdq_err("GERROR=0x%X\n", vcmdq_page0_readl_relaxed(GERROR));
> +		vcmdq_err("CONS=0x%X\n", vcmdq_page0_readl_relaxed(CONS));
> +		return ret;

Same print?

> +static void tegra241_vcmdq_free_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
> +{
> +	struct tegra241_cmdqv *cmdqv = vcmdq->cmdqv;
> +	struct arm_smmu_queue *q = &vcmdq->cmdq.q;
> +	size_t nents = 1 << q->llq.max_n_shift;
> +
> +	dmam_free_coherent(cmdqv->smmu->dev, (nents * CMDQ_ENT_DWORDS) << 3,
> +			   q->base, q->base_dma);

If we are calling dmam_free, do we really need devm at all?

> +static struct tegra241_vcmdq *
> +tegra241_vintf_lvcmdq_alloc(struct tegra241_vintf *vintf, u16 lidx)
> +{
> +	struct tegra241_cmdqv *cmdqv = vintf->cmdqv;
> +	struct tegra241_vcmdq *vcmdq;
> +	int ret;
> +
> +	vcmdq = devm_kzalloc(cmdqv->dev, sizeof(*vcmdq), GFP_KERNEL);
> +	if (!vcmdq)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = tegra241_vintf_lvcmdq_init(vintf, lidx, vcmdq);
> +	if (ret)
> +		goto free_vcmdq;
> +
> +	/* Setup struct arm_smmu_cmdq data members */
> +	ret = tegra241_vcmdq_alloc_smmu_cmdq(vcmdq);
> +	if (ret)
> +		goto deinit_lvcmdq;
> +
> +	ret = tegra241_vcmdq_hw_init(vcmdq);
> +	if (ret)
> +		goto free_queue;
> +
> +	vcmdq_dbg("allocated\n");
> +	return vcmdq;
> +free_queue:
> +	tegra241_vcmdq_free_smmu_cmdq(vcmdq);
> +deinit_lvcmdq:
> +	tegra241_vintf_lvcmdq_deinit(vcmdq);
> +free_vcmdq:
> +	devm_kfree(cmdqv->dev, vcmdq);
> +	return ERR_PTR(ret);
> +}
> +
> +static void tegra241_vintf_lvcmdq_free(struct tegra241_vcmdq *vcmdq)
> +{
> +	tegra241_vcmdq_hw_deinit(vcmdq);
> +	tegra241_vcmdq_free_smmu_cmdq(vcmdq);
> +	tegra241_vintf_lvcmdq_deinit(vcmdq);
> +	devm_kfree(vcmdq->cmdqv->dev, vcmdq);

Ditto for devm_kfree.

> +struct tegra241_cmdqv *
> +tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id)

id is a u32. 

It might be clearer to just pass in the struct
acpi_iort_node *?

> +{
> +	struct tegra241_cmdqv *cmdqv;
> +
> +	cmdqv = tegra241_cmdqv_find_resource(smmu, id);
> +	if (!cmdqv)
> +		return NULL;
> +
> +	if (tegra241_cmdqv_probe(cmdqv)) {
> +		if (cmdqv->irq > 0)
> +			devm_free_irq(smmu->dev, cmdqv->irq, cmdqv);
> +		devm_iounmap(smmu->dev, cmdqv->base);
> +		devm_kfree(smmu->dev, cmdqv);
> +		return NULL;

Oh. Please don't use devm at all in this code then, it is not attached
to a probed driver with the proper scope, devm isn't going to work in
sensible way.

Jason

