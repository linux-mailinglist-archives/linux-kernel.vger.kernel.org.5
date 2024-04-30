Return-Path: <linux-kernel+bounces-164303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5218B7C12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0C91F21850
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D286174EC8;
	Tue, 30 Apr 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R06xfWjQ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8573E17333A;
	Tue, 30 Apr 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492146; cv=fail; b=Fku3AbWPlfkFxVm+8ZS8+aB48f3iTlK/1F3GspC2HJadbkpjiP8MYMwIe4LSGNfxCDXZVmSEHpfEHzrUIJdEfNnTf+MiCA79U7BumlsmYIVNPIpp8GQTWJW/nZjaomaiZinXTufOs3LkcG3Ycju/RLNtObIaOKp9S+Ojo4A6hqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492146; c=relaxed/simple;
	bh=/R0kp4L5kY2FPWbpYxu0RS7H48R4l8mLfJY7lvH40w4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq4QU3Xia+6pmVWDGndaDf66gzqe8L5AScJhScQJGSnZR3Bj2Jfo31tb0LZX7np2GEAlQmJGb0wUphseFkQxWWVW6LuI3PBWCQRskq8zSjJ7GdGmY272jutKr5+stE95sat8aFBbjLNmSstxkESzoNl0Pw/9ghPwzANrwCULWRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R06xfWjQ; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YG4lvQSGzQB0jSxfC3NalDnkbYROHYI7EROJzeiik1AO3AJHrwEMBzAoobs93C+d2047sWnMr8MK1pE5MIFqnwiTCgwGQWugUeQ2cFhvf4Hz2XbSbAkxsEMUA16/CU6rQ8fuczzGt493IakTp0cmwHBi2h7ea4nmttc2SuxrykTmn9Ion/e4CFdweHyq8mCOwnoH6gz2IYkJCgVbvIvBs2DEZZwD0KEHkZgFtava/K8hvzpZeFDZ+UyLeTuynhBUGKKf7jI1h2lzl649j4DGtBH/MzrsPR79548IPjhY/MKDE0Ap1b7578BfFJ3Ysb2WLGrEm9vjm8MfiwdxxcpCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qZJ3Mrwc+J32LU/rdosoEocgWE64O/Tq+9iq8Z4vf4=;
 b=CN1cejdQp3GtsATMIi1Ct+jaYkxsjBy+a2Mf6u2akPkz6VGlS2JF0qkcHipgMmGHQnuCslN5AGRO/XXhzXuGRaEw05DeY747RNgHlg7gqzqLnI6/5wLrmmYxPqPAmb4Gg1HusonXCuLv9+ZAFv3e5TiR7JCtzmghY2gvBol+ty8dV1hSvLdWwI/ri/HL/hFH+PiaTs9p+t8P1LhGO5VpQMmOMWi78jKM/LUFIVzHTJrBV2qiICac+TDMHj27YQpB9HAnmViaPLKumggASj7yJMVsZgz+LSczj38a9geffiLFBGXHvYqoJmvCDgzfvfOpe97455MnTFBS7Iv/70cpBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qZJ3Mrwc+J32LU/rdosoEocgWE64O/Tq+9iq8Z4vf4=;
 b=R06xfWjQOxGGgPZljtq142Jny/HKgfX6mgydBvW8Hn5RXb9TF1sUOn2TKMOUm4yeWcVFkXza8RhLdBo+O+20nuaU9gDXoSVoiOKG3j92/DLJt3I8XLQzICcsKzQXZsQZlFkKKp1Q6dKZ9TWOeCO+D6HijAQKq5ZBT9Li4ZNy4jF2mhEgGql5v8BZgK0ZfasP+O3foU4QLWovfo6zgVttyRHeUMgQfCpnK1ZEvlSCLhIQO5IQVd03U1GcFO2L66LThV3eV8UYawdbXT0FOuNWLICLx9GQNuyZ08wbEk72HCVui7HN0MpmHDrKs11LhBI3f3EFVUtcjZROmlgwcHzioA==
Received: from BN0PR08CA0023.namprd08.prod.outlook.com (2603:10b6:408:142::17)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 15:49:01 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::26) by BN0PR08CA0023.outlook.office365.com
 (2603:10b6:408:142::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.27 via Frontend
 Transport; Tue, 30 Apr 2024 15:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 15:49:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Apr
 2024 08:48:46 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 30 Apr 2024 08:48:46 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Apr 2024 08:48:45 -0700
Date: Tue, 30 Apr 2024 08:48:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v6 4/6] iommu/arm-smmu-v3: Make __arm_smmu_cmdq_skip_err
 reusable
Message-ID: <ZjES3FTHWOl4Ycdq@Asurada-Nvidia>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <25150aec77edf5590bca81f4a418ef1ee7b21952.1714451595.git.nicolinc@nvidia.com>
 <20240430140600.GP941030@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430140600.GP941030@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d2ee3f-5587-4f9c-f74f-08dc692d0dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4TR8MlcGn+Q/USl73llWMwl2VHNAdlhdQnm0kDXETPckmzyRS1tDAhFjBQNB?=
 =?us-ascii?Q?sBg/WeqxvH3RGu5lvFPjx0COseNJitc62lnb4TpnrvB603+hjlaCxfnscski?=
 =?us-ascii?Q?qbTn/o72AeOCfkXVQ5xAj4uj9K1gDfAperwJbNwHcfewhIicdePnOjJ+lSAV?=
 =?us-ascii?Q?XppavcjH6x3gV8amtxoRhYzZyfdShL/30eq+BioVhNFJdJYxUnm7K8IDZ3fR?=
 =?us-ascii?Q?45Dwt1z+rwqsATr+JPHK1Uh9OvTVMk26glt9ttx7E235lej2OYgeAcAUffUc?=
 =?us-ascii?Q?N68KAJwGsxQV6+ntoERt3wfYahgr/vMUU/CBsKZrnX7dlX3Yux5QQSqUd6Wp?=
 =?us-ascii?Q?l0bwDKNKmuyLgJipYvTRf3lxJCZCEaOILLykedtqtmhNksRs1vZbnQEWpXUC?=
 =?us-ascii?Q?XFb+6T8FdCriKh/7KR9dNQPTJfcoh4jakLb/H8gLItbECsfxaHTpeXLoA9ba?=
 =?us-ascii?Q?Yx/4GBQv+cjy9wUhMjKojsIDvCdBNJqqmVKz6TbzslldgXTzcdQPucWkH6O4?=
 =?us-ascii?Q?OZcESBFqgSAVPZa9KofQ7xmVXrR7OOtU1D+wQMG6Tgqi8fnc1RKXm3JZ9OBV?=
 =?us-ascii?Q?K4Zpbrhixov2G0Xl1l9Q5cTjK1LAlqLUOOIAQ6aawyDUIP+F4YSzoXvc6L5c?=
 =?us-ascii?Q?z+Zw/dEsASfLjeFAA3G4Nk5vEmIcIPVmXMOb4AoZrfKjvzYHiR7KV1F1zSwU?=
 =?us-ascii?Q?oiDQW82jtiOgYE/kgFvwFLhiejFaM1e5mEFRgKYRBUtUqNzob5BPFHdKmjld?=
 =?us-ascii?Q?a72gaSmFFQt69hRTGSUG/kkRTynNGcpyosMkoGbCUqqot+FOAeczYfJe23dl?=
 =?us-ascii?Q?RoWQkCPYa3D/Vsnx59fYjzuNzAAy8YP+2lah/fFNcyeKpYqMzIrC3j+NAeuh?=
 =?us-ascii?Q?1quvUIyuENtm5W0Eoeg3lIfaqxjYZBJ0taq4DGx3Q73aNxFQF2ZhXu8wyS8e?=
 =?us-ascii?Q?BZzMI9ECDFuicC5acK8cBwfMRTckx906ZfQuBjH4YPmjWh3RGQfqzHmqdtGS?=
 =?us-ascii?Q?L9XKkPA+fSPWannVOyjCUy53frgjaElqLm0apCzwgcJpjlXw2cgcjuIc0JNj?=
 =?us-ascii?Q?LqGNVnVFg8jGjsGbikSSqefhY9WRTwaBBsk5lJiFtBOH2NbT64woeT/BNZnY?=
 =?us-ascii?Q?mPa1mS5H3aZy2nfdiOyoyCrQ2FSe2ngajZIKH4CR8rwObe6p/x0pTZbzQ6gf?=
 =?us-ascii?Q?jNORhwVlobEedZS5FiYGWH48A3c/F9An05rhch0YfscRTT8pKx+KKf3YJnXl?=
 =?us-ascii?Q?6JqkQwTQ2FcxyPf8A+29YM6IhP31+iOBleg335aoog5Y5TvtyFhf0QUS5zBW?=
 =?us-ascii?Q?Tn3BZZkWNbar2uVapppVB3vcTozXsdPrmtXOsGB+Z3D7eCUA7VJPyjbjDqq8?=
 =?us-ascii?Q?QYS9F7bKRiIXAT7peQhrQEpiedg5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:49:00.4176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d2ee3f-5587-4f9c-f74f-08dc692d0dd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467

On Tue, Apr 30, 2024 at 11:06:00AM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 29, 2024 at 09:43:47PM -0700, Nicolin Chen wrote:
> > Allow __arm_smmu_cmdq_skip_err function to be reused by NVIDIA Tegra241
> > CMDQV unit since it will use the same data structure for q. And include
> > the CMDQ_QUIRK_SYNC_CS_NONE_ONLY quirk when inserting a CMD_SYNC.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++--
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 538850059bdd..5111859347d5 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -379,8 +379,8 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
> >  	arm_smmu_cmdq_build_cmd(cmd, &ent);
> >  }
> >  
> > -static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
> > -				     struct arm_smmu_queue *q)
> > +void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
> > +			      struct arm_smmu_queue *q)
> >  {
> >  	static const char * const cerror_str[] = {
> >  		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
> > @@ -428,6 +428,9 @@ static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
> >  	for (i = 0; i < ARRAY_SIZE(cmd); ++i)
> >  		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
> >  
> > +	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY)
> > +		cmd_sync.sync.cs_none = true;
> 
> This hunk should be in "iommu/arm-smmu-v3: Add CS_NONE quirk" ?

Oh, yea. Will move it.

Thanks!
Nicolin

