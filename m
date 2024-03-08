Return-Path: <linux-kernel+bounces-97117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B9B8765B7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B8C1C217DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC78B405CC;
	Fri,  8 Mar 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C2MXTg1J"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3B3FBAE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906111; cv=fail; b=ki7EvewtJVnDDQ+Ake33Zxf/ubaC4qfEbSgBe2TZRwKVTCruKSFVD1xp+Q1zSwY11/JEfQhbiN5Q7PKME97PpytmZHNS9E9/dr/H8fL1ghOA+iuzMGnAL0RMl8VGj3TVmOictP7inl7Deo73nz4mh+QkN8eqt2/gId4V6kUTS68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906111; c=relaxed/simple;
	bh=p9a8rg5YxdcdO2+bBvQY0K1xkEPCp5Xtj90Ch2Fjf2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pGWzOSElGI4GIOKBRt1f0sGgEQlVnuLuBj2b4mXy+kMRFePHU7zD5q9tKalzeGTCtk6xAVGNv4JhxkEMDHu4bJRaEo8H2sVjNmoGyNiEpBPNxtD+LrcjMKUj9YSeVqELYNshWFYXcKUtEljjJ40X+ckN4JiclAdFebxG205709Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C2MXTg1J; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijd/fgqP7NOEa1BCjh65y7Edr0L9jwffYuPo7ITRjB5chuyNHKGAYBcUKXG1q8l7qY8uIwLQ6RbO/0HpUuEW1XSpeQFM3rWxW2disOVPDDaBC/P9sQafncWHmmOxUJpsghoO2E0zsz3YeizTibVVSDiWwwMDAP7DRo8W37cPTR68e2UoX1Dbfgje6L4fFbSE7vu9eOhp21FK1ByPmrrcc7mCYa62SphIu/LesCdsJ9W2Oj+xf7+CHc09xTIC2Ep63WdfZzNtlfX6HIfnE2nFzzWnVMN+hI2UvS0rWgW5uA0Bn1IXgzOlo6A7o8CKt/P1S3AYzImKnGqAMnOi1nK+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8BrAlF8op6V45TvVtgc2xpNrCjX4yeLuX7TODO3DXM=;
 b=bbGc6/tpRH0yuHcqcR8jEubMrEcO+lRjLFK6Q1HErkuFcf3J/nrJMvaL756t0qc1HpVIkcT3ZOlARH70QsEUm9B0hm+d8UVZkxnLKEACxR/TYX2rpmbnv3EN3w6BZVMymIbJ+I29JNSVouR7nzj5jNqbf+SGt55MOf3eRkm4lHYGHgCfDHP30nUpRlm7pvABYNiWh93DkkW87BHu6ufI0SzABKSm5Q4MRC2tpyXzXEesanKTSlPJ0Gad0FvNw8iBk9VZkKbPnwU6UjTl/XtOviHyLWrZvOdS0oc57U2YQzXI6UbhQFlLiwqil/RVo25cYTyxZCLxsAFo4T7g0CKTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8BrAlF8op6V45TvVtgc2xpNrCjX4yeLuX7TODO3DXM=;
 b=C2MXTg1JQv770z09UGbCPwIeZ9klL9hk3HcjoemMuuDJ3Gu2c2aw4g+9HDx0ldB9h3b4NhrAZfkyY50eF6AeRYyLi1WT2AIZ/ZgJ4jsjFp8SDu/UOyrs3xbvNwrgvRDeoAyu4/PQ5PdSrP6O4mzzCre2WBKFhxr03cXBcWtyf0f0ocLnuvB0CRplD/KVjTOrbk+t1G6Ybfceyxe6PqI2z6kIrqqEvJyn2mCZz/5Ch2XQqIS95SH1PxUZd9YEhHOLUBcWhOFvYIQXpx3dajRF/cQ4q1lQWRQEhQar6SMEgdF3PnABhLbMAvBijk+s5/YNJW5ifHa2OwAmPzrjHi+pkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 13:55:04 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 13:55:04 +0000
Date: Fri, 8 Mar 2024 09:55:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	eric.auger@redhat.com, vasant.hegde@amd.com, jon.grimm@amd.com,
	santosh.shukla@amd.com, Dhaval.Giani@amd.com, pandoh@google.com,
	loganodell@google.com
Subject: Re: [RFCv2 PATCH 3/7] iommu/amd: Update PASID, GATS, and GLX feature
 related macros
Message-ID: <20240308135502.GK9179@nvidia.com>
References: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
 <20240112000646.98001-4-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112000646.98001-4-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: SN4PR0501CA0120.namprd05.prod.outlook.com
 (2603:10b6:803:42::37) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c2ea7c-9dae-4f28-9e87-08dc3f775b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Po5SQ4Xm6TvDwkmhqA8uuVmAcksR9DrnnKLUgDvvqTiSOHpATRzltWQUBKpHSA+p8vNBYSihYBBofxpcfmhExXcXWZDr1bqePJP6yiMa+AY8xKOuL43Z/j7s1Am8JaXhvWIpPIoWTNFztWCz0DzH7ncE4/rfYm2Xo9vDwJL18HFkuCsSkJDxTiCGU+I5LLS2h4J6JP3eqGYmXLMMpPUnPq11rQtkez1ypgFewsYhVzugtx1t58h3FLAZhD6i8BFV+LjV/dEykn9gZVecG11jPQ4V30UkEO2eW8zpnYa9hKq5W2hwUudJGcLUHC8v1t0pcrYXqEqIeZZc8+F9vXWK4U3CzOpASBffK/eaKKEcSQVhYbDh73ubOtsNM6uP1Z8gyQWA4sWWDbSIXd+h+CS0Iolmc30GYeBNq6Yw+uOllDy/EQa7syDlOC0ynprnkl7T1+YFaTkeK2GjqK7m6os8P81/z5jAVTrF0M7duF176W4AWXB09Mbcx8RxRz/UR7EefkB41NFNkK9h3a0FObqz1PjYR4Np7RJDYHePG3p4KYOY1/uMEI3gH1aPi26lFI+0N0zw7h0y7Ll7dRy41jalFgmhLguvXBls0JEDiA36zS2Yv+Qk8U2egWz9WEvyu1D4WxogEVZCboRd/ZRNafrnx0Kaoah6rAYfqB5qGZXbhGM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+2ueiIlsQ1QODqPkmHtKfwTP2tuqx0qoGshSYGiq6DsD5O4gJVlZ9nlXbM7y?=
 =?us-ascii?Q?h+F91VsYd1Ni5VH8/lp+9QYYof9kYrQGbGCkZQntv1UIN33TL+oFvLgjqFIF?=
 =?us-ascii?Q?nl81eGq3mVessjdVjNGxko99bATaCjL0YIpRFsPzdUM5GH8zcGHLqml2PRzV?=
 =?us-ascii?Q?9fBZUNV/I3r3JvGHUG0uLaSgQKiMyC1n17p6qdONQIknwUZfQIJ6m+WbUb26?=
 =?us-ascii?Q?4Xe0zIR3P0vfg+OhFevsNZlIRDynUGxwtT6HOLwdWyO8eMV2KQXuKwxutN27?=
 =?us-ascii?Q?2T67+Wq8y07SrYLH2Geb7c+42qgmRJVUxFdGzVgkSxP7GHVAkHLFr2AjMh2/?=
 =?us-ascii?Q?Gc5PC42x/pNOUiiudzpnWZWZLK6Oyg4H1R6Sdn4e6eP9SOl2LoqBl1lp5MVa?=
 =?us-ascii?Q?orYOKbcDn+5fPLGCbZ84YVQ1Zo2IltsyNLngYZ8tUceUAIud6jZT7NnnV77u?=
 =?us-ascii?Q?IzFkWp3jJvXTn+CxWvoj7I/2I+ltzDGIKTc3AN86s0JHVFdtfKy3Y8bVjn2A?=
 =?us-ascii?Q?HGluxOjzjdGKgSLiAh2XeztLkAnWWjoUqo4+BEdDt+Nm8eVkyvzBgzGFoKTp?=
 =?us-ascii?Q?5AF1kcYf1dxNtWGvdtT3EQpRz7gs5DBg0g+hr2BHObIn+z2U2YsKhJnfUwEv?=
 =?us-ascii?Q?cd6oT39C/zpCt55fkyxnFXgUnZH2NU1sYrNBhfKcUwOXBaaC14/YF+hzlzfB?=
 =?us-ascii?Q?ZzfDFm5428Psa5hZXM/CZx8Cyo+T+BLMqjqEFzhQ1ehVD6Cp+sR4PeVd5rqu?=
 =?us-ascii?Q?U63PFIY7qa5PAfru1GIAwWtZDacQBtLh9HlejMhG0ikfdiy5BpvE31RY3zz4?=
 =?us-ascii?Q?mDmLtUEkBXMVKp6Q4ASaLcvzdDIkvrK+zQeVW0GG8OrMbA8cqmIRN2ysBhen?=
 =?us-ascii?Q?OkFVBnfhkmDNOHUj24BcPdsgKzdc3WEw2YZWTIdk0DEXislP4ncyXBTn212c?=
 =?us-ascii?Q?oIKqGTpWXJWUgpjasXTlyjXUZHfuR2WYuP+In3dPHvI6hqaynb298Ieo+/6C?=
 =?us-ascii?Q?gw8s1h4mAba932O1GHj4vJYYNwndkPMuGud2E/doKM05DbSQajhMAMoGzdbB?=
 =?us-ascii?Q?geyH3BSDTUFluomYZHPMoyDXjOmU2H/sX1ayiFjiInu5GuXQgjRdvvnJjwXu?=
 =?us-ascii?Q?dqNoVaNR3JPgOT0tQQgzvrcki8xIrRiUvozdV4XaBSEwqzD4mLp00+VQVvQ/?=
 =?us-ascii?Q?pR2j9X09MDmCL5qUnsYeS6f7yrsQ7KovROFQvryZT5qZCvgT5KeXaug7Cho4?=
 =?us-ascii?Q?DxyV2MZvfbxgBbFbGqTCS2R5u1RlGOj7QBLKaXRyEHu5NXCpS2oDAgTGKGzx?=
 =?us-ascii?Q?wQCTz2Zk2SzpnIB2nXERuaZqQ0cpHfVAMBps2h96IrKUM6bdfHzovQ3SBjZm?=
 =?us-ascii?Q?1wgw0j3R8x2nai4fbjDwfHYGMbXavbsDIyIbn2PTIPL2oG6bnH69vlBcYtCh?=
 =?us-ascii?Q?BLuFrI4X3KsYZkkZLClkctr0+F3SxNCFOhdnvZDXXCDqpv26WJ0+d6I6GWER?=
 =?us-ascii?Q?JF7APyZs7JqMHwBV3NZjPDzpLR0PjXqz12SL4gUsS77qwW9iaxyVrimxC1Fk?=
 =?us-ascii?Q?QktOFrAKvOKKXRKLrNw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c2ea7c-9dae-4f28-9e87-08dc3f775b4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:55:04.6369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qe0bDRLz7ceeYBCEsYIU+IC/HB492OXTwI6aApWOpciFEVAPaRQsqZLF+Pb9FIXF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

On Thu, Jan 11, 2024 at 06:06:42PM -0600, Suravee Suthikulpanit wrote:
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index ff56c857f6ad..f8baa8d88832 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -93,8 +93,6 @@
>  #define FEATURE_GA		BIT_ULL(7)
>  #define FEATURE_HE		BIT_ULL(8)
>  #define FEATURE_PC		BIT_ULL(9)
> -#define FEATURE_GATS_SHIFT	(12)
> -#define FEATURE_GATS_MASK	(3ULL)
>  #define FEATURE_GAM_VAPIC	BIT_ULL(21)
>  #define FEATURE_GIOSUP		BIT_ULL(48)
>  #define FEATURE_HASUP		BIT_ULL(49)
> @@ -102,11 +100,14 @@
>  #define FEATURE_HDSUP		BIT_ULL(52)
>  #define FEATURE_SNP		BIT_ULL(63)
>  
> -#define FEATURE_PASID_SHIFT	32
> -#define FEATURE_PASID_MASK	(0x1fULL << FEATURE_PASID_SHIFT)
> +#define FEATURE_GATS_SHIFT	12
> +#define FEATURE_GATS_MASK	(0x03ULL << FEATURE_GATS_SHIFT)
>  
> -#define FEATURE_GLXVAL_SHIFT	14
> -#define FEATURE_GLXVAL_MASK	(0x03ULL << FEATURE_GLXVAL_SHIFT)
> +#define FEATURE_GLX_SHIFT	14
> +#define FEATURE_GLX_MASK	(0x03ULL << FEATURE_GLX_SHIFT)
> +
> +#define FEATURE_PASMAX_SHIFT	32
> +#define FEATURE_PASMAX_MASK	(0x1FULL << FEATURE_PASMAX_SHIFT)

If you are touching these please convert them all over to GENMASK.
ie:

#define FEATURE_PASMAX GENMASK_ULL(36, 32)

pasmax = FIELD_GET(FEATURE_PASMAX, amd_iommu_efr)

Jason

