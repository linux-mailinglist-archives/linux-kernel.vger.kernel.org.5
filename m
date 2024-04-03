Return-Path: <linux-kernel+bounces-129692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EABD8896E89
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D30D1F2736D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F1D143892;
	Wed,  3 Apr 2024 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VdyeYP4J"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2090.outbound.protection.outlook.com [40.107.237.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E8134CCA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145542; cv=fail; b=Fzacg4PYTWqH6QAttClpQI9x7KZyEiY7H4JYga/Ic62pGV3tXxdfZiC+z5P6tOIUbZqN5pvXU/TvgnJoK8IKRraClxUUaGg2C2OyY0W0wp/bz9tlGnGveTA1JGV2plQNHgO3BqWCl3kBtNgV5NQzWvt1zCsffW9RkZryIAoOVw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145542; c=relaxed/simple;
	bh=84yBnkGnFK6CNblbWiigGvmddlOvm4y2QZ7jZwSlrqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QVwiQV/cEKDdNwiRc9Cdq8+dF79ejBiLIpWLmYkuVQTG32ac7MvH9iKLyuQM14iqr0RLPsE2m349eHq473ybA3RaYJyvCcDwsqNM5lsucsOEyZjF5m+mHNqV109wOK16IEhbm7yclddw4DW7dOrxnrtigIIKPciImDgSoSdUigU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VdyeYP4J; arc=fail smtp.client-ip=40.107.237.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6lyfq+Lqaw3NTmOW3nD9VdYIFpT3933GO37PnM55Py45PPd2DbmeApxxxQM7N5ZBkxKlyaEhssrqh8f94Sd+wpfCH/xCdMU42Lim8OjLdGv/xukIhOaANggHVHffSHM0Zwl6/cBSWPG7jZQzFWSh5jZL8s3A9iQbKlC1s5WM3kVmC43w+kSYsYNI6HKZ895nohxFJkWrEnuCTYl+bRLIGnuezie38B3iyvzr+jFpJCyA/2eCgosRmGTGgBFMuBcj5YCxlmIt96WpuXMFjvWvK1p2B3h0alH8o3GU5YBXVv1ySEN8CbHlFuqO/jeHJIqbOy+Rkay0Vt27cdxMolrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnEEbKZy2pvn32/kc8iBkjVg9oUfhnu0JSOlYGczkkE=;
 b=P8eFhZwbSi7h8umUoHemqpUoR9O7x9BHUI+e89Pb2BuDDWASy0uHYKsBpvig3gzpF9R67d5wh1s4Hx5QrbQSGUcG8MectklX0EoG4yP0vTJDCFuI2EM2W9w5U5KNMBy5GuumZompgA7Hg4/7M1qD7HWpGgC2IEwRGtIKxaKI60Wwslm/Z3YC9m0b12UCXVK39eUGr/npUTPNHGz0rd0XUc+Y2bc6vtmP7uBqY0AGCCQ3NCCFTfSmQo7S33nd3z/AxEcCOUqnveLQDpO32dxIF4E1qOWRnahrTU74j+T9VDEICNqhqto9XDPrsq1tiBmWRbVfhppDMo16UVEWQUD3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnEEbKZy2pvn32/kc8iBkjVg9oUfhnu0JSOlYGczkkE=;
 b=VdyeYP4JON9t3uWwGiWgmcY1l1wiQjX1SGG1z+ycvcl5m87jcbZfqibQx254/dGVm6UujawwSMqL6lT9jatbk+efcHEO2ezVuId/G+yjVrgUbDLlbDmNg8wd26M/DAgWfeoJJWe+sc6zT0Ecjk78iFxkm6xsRIms6r19cidWEVhKrirXdyk81+VTs81FDzhMc4KREmWPCS4uWmyu6JtyJtE5uMkrUEyWe615PWV8MzlBtT8c5liH93cFyGJf/JmyQ2sPYx44aq0PWYr1OAH7XjHHjMZNiBBXuc46s5r0mR0z7VXpC+3Xs5s7IoC4+b1BZunUue0PEuB8Sd/b3CoZ6A==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 11:58:53 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 11:58:53 +0000
Date: Wed, 3 Apr 2024 08:58:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] iommu: Introduce domain attachment handle
Message-ID: <20240403115851.GA1723999@nvidia.com>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403011519.78512-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: SA0PR11CA0201.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::26) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB7688:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VPkm1Dj61pStRpKkHmdkkT8VRyyXl1Nf5ND8peBHfsyZm7JiBYiG90LN7U8efANVDcnsRmcfAKD8LBgASCuVBrYKP5oE+EAQxp00SM42cTQZcBB0MIMbY9v1E008eKtL7LUeEHTeXAhMO776DglyELk5Io2pKO1TaV1kXnFHgN3dY5leVX9fljOEafMvSLsCekYO1fPo4VyipKyzhS+uCJhTvZ529GbVRVbLhMaSAQkiVxGQjNV8sGUjgedgb3rsLYQWXsCboTX6lgJPvP+FmlpCF1rNuQkv2BguNJTvePeW2ToegVvo1joj7829OhPZNKjY0oKV+OZujptTEThviRWCBOHaJqUBLCyP5hz/2EZN2vsvyMa+Ha8qDvNyWATd5S/8FAS/b8uz5vEn2DERozxN8yjzdNr8jLQxykgmUvmhYMzgyCKeDTDPaphzwfRBawai/+NP/pMYY0gtht1TE/3WLCYBmtMt8i71BHDrWEquUotfVpc7taESO/bmIx0EVLDakoEpyqZ2uK53nHvHOoH7BYtCYekNdF6XIgAbbgPSVhychZqIYr4m0QhMcoklXwpOIEqMtXd0rOYiUCocFn7rZEw1BYhRQi6orxWohpGIUcUs85uFGlBREb9mY1kNhncbLRCjPjQwTOuIHEDlwaNVtgfFRZG9ccDfpwgNiEc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XliPTdb3JxKu4bdSeMjI5+8cnrWcaAvEAs3FVmf7qpOiLkE6xAeF+nk09pki?=
 =?us-ascii?Q?qmGumr2sK5Uc++MpERC3UeKYzGVdsZGzNP0LzfVF1Y90yU1HfCIZZzWBZcZp?=
 =?us-ascii?Q?Wpvr4Ck+qlGIa24ZScIl2p2ZLJkjuP5e4H6epg0tdWgQdwtz/RICj+Ln2lqg?=
 =?us-ascii?Q?z/3IJv1yR32HQJL3O3dJVR8LlkeApfuYH4LEdtt1xeY5S/xZuXZrlZoU/1sl?=
 =?us-ascii?Q?pSWXJ6ZUdz7HqclgWI9WqZefEhctDi3v8ssUZLCyGErpQfSxIRAFF0kKwyuy?=
 =?us-ascii?Q?Yvxu9zXo7Io1QxFhizCMbeuYpqrPTHatTrXIdJpdJObIYYlufIePmr7bAm4W?=
 =?us-ascii?Q?4iZkr0+8u4uMWBuK/54sAmRif6hBb6q1E32eogkYqO1vgj27s4c0c+TybvLv?=
 =?us-ascii?Q?9iapnBcuhU3itHBmX8X/FxJ0Dpa85vgqxkK1WTKowwe0CA12k6X7C0DqxwI4?=
 =?us-ascii?Q?CX8y0IMEhdwYlF+ncDDm+x0usi3CRPrHckSrB/8jWRa3NaGo+orsXMKtfIRR?=
 =?us-ascii?Q?hliXjMJHAtyfWhIe2C6gWvKYpE7BbuYZBQFORhttUJv5y6lf6AZQqCcKh2AQ?=
 =?us-ascii?Q?YG6tZjiAsim3IO06dhZCO/QvsGZdTpixKQUp0T5OI7fF4lsFlJZ4NQ90t5qT?=
 =?us-ascii?Q?kuW9zJKZWvpH2Qna/oKq0VoNoHnQQ4qAruCJ3uYgPaC6Fhx3dM9cPhe+/ST+?=
 =?us-ascii?Q?8L79beah71p8X+ohb9k9kBqd87v7X5hMSZ8phSQTyoO8g8CgiE8PRKXwqTSj?=
 =?us-ascii?Q?ZpXuDDptr+k61HI88OpB/oM38X9HtdpNFbqF2+nslSOu3TZ4/RsVqEwl8b95?=
 =?us-ascii?Q?DJxPE50Er7rkkKstfQv9/DrOZLgWV5panI0PrX0m/q2Cb0yfbOVKtxzcmiYj?=
 =?us-ascii?Q?rx77KZ/DzExFBh6nqhKU8g+TofcKbIQDr9kYNTxkCC1NvdiQrkSl2pvZFkb6?=
 =?us-ascii?Q?zg+hpM3qEJjILucJNZlK4aHAxN4SoYUKgMd9jRqeA7jI82LQeV1zZ7QUgird?=
 =?us-ascii?Q?IUvuI42sdJq4lJoUN4GpKOmEwLmOWRreziZJS2EgGhceaXnAbppUv/ybPYtG?=
 =?us-ascii?Q?/PSt4uvDlxdapewG50bxyzcBxr6WR1fJ49lIJC8bbS7yVo4lBvdmITjVNK/g?=
 =?us-ascii?Q?ib5UH36t92CgcWdvjDFY+5wPuRNCj4oaGql6YHju7KqDt+Ny5scyaITTZ0E5?=
 =?us-ascii?Q?HawtrA+IQXycT62k1Ta7g3X5NCcSE5LZDmYsJH3bA07eC3nRgG7FYWcKI6+R?=
 =?us-ascii?Q?S42OssTwERxirZtAPXQr29ewiOqyoXLUwGYkFYJ11sTIu8GnBv1gCexvJRYU?=
 =?us-ascii?Q?7bs/XnvzR65JnAR3vp8mkiMdq+9oi+bkyQ5k/RA0B5BrNwkwq32l3f326dM9?=
 =?us-ascii?Q?SAEPb5vru45nYqXe4ZAS8H57AQRIsOdBxSQQsqqio2jv0RbElLDRNjHdutPa?=
 =?us-ascii?Q?4D99MqzKWPOHKzWyllYiABimtQY1BzcsAUkyfPcoGUnZo8kVHzl3hU9bcOnI?=
 =?us-ascii?Q?Jjuk+p38ZUwjQjd1onYufOPtXvXoB0Z//TFijupj/jpnmFAoJsFY9em8xX9Q?=
 =?us-ascii?Q?oT77itEYyg4DeA/n0THjmOibnWD8KgxysInYA0aQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5f3223-cc13-4bd7-9efe-08dc53d56ee3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 11:58:53.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I55o2z+Sr5WAaDLTY87Qr4urNdfUHcZE+/NdVdiSni6SLBdoB3ZMo8AcCpMidm2h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688

On Wed, Apr 03, 2024 at 09:15:11AM +0800, Lu Baolu wrote:
> Currently, when attaching a domain to a device or its PASID, domain is
> stored within the iommu group. It could be retrieved for use during the
> window between attachment and detachment.
> 
> With new features introduced, there's a need to store more information
> than just a domain pointer. This information essentially represents the
> association between a domain and a device. For example, the SVA code
> already has a custom struct iommu_sva which represents a bond between
> sva domain and a PASID of a device. Looking forward, the IOMMUFD needs
> a place to store the iommufd_device pointer in the core, so that the
> device object ID could be quickly retrieved in the critical fault handling
> path.
> 
> Introduce domain attachment handle that explicitly represents the
> attachment relationship between a domain and a device or its PASID.
> A caller-specific data field can be used by the caller to store additional
> information beyond a domain pointer, depending on its specific use case.
> 
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu-priv.h |   9 +++
>  drivers/iommu/iommu.c      | 158 +++++++++++++++++++++++++++++++++----
>  2 files changed, 153 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index 5f731d994803..08c0667cef54 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -28,4 +28,13 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
>  				 const struct bus_type *bus,
>  				 struct notifier_block *nb);
>  
> +struct iommu_attach_handle {
> +	struct iommu_domain		*domain;
> +	refcount_t			users;

I don't understand how the refcounting can be generally useful. There
is no way to free this:

> +	void				*priv;

When the refcount goes to zero.

Jason

