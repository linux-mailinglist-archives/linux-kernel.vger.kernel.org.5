Return-Path: <linux-kernel+bounces-135481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15C789C640
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A6D28665B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E4080618;
	Mon,  8 Apr 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XRJGBqfa"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2095.outbound.protection.outlook.com [40.107.220.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3188063B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585157; cv=fail; b=q2swlAVN/hjGV3i6Vry5MCddGurTv2nl2AfbrA0H2VZdPmFvgIy0Hp1Hi2NWWJkdCG688dVvmSxKD4NfTWHCylK5k1YnwyMnacJ7aAAi4mE1uA+cVDccCuQWF3Ivd3MR4Vr8XQ6lgoZNPuaZsvXG8htT8Sh1zzT4S34iGzA2NOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585157; c=relaxed/simple;
	bh=vB0jZscvV8VEj9/e0tgK/akp773qIs6nuJoANSHRz/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JRs6IC1POCvGzxXPPi/9uxUdxVj5A2Xifq81wrWIw04a6VpNurJo7obtGBmypUihpPgaIYYtgDARIi9BIbeJC9q4GcnuWkGYzwbwdkr8RKA1Bv7t6cl2kiUk2ZZcsiGW1hTCe0VG5Y/QaQ56Mrgw5DMksWjwnZc+Tr4Env5WKU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XRJGBqfa; arc=fail smtp.client-ip=40.107.220.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zpd8NxVt0mNtT4nYrReGRgFytpgJr/wahUstHQNQW8zxARUi2PH7VdLH/IV0ebr6PpkZoSYItLy3r3XifzEZT9eMHQNiSsiNYUZarih2ALhZG6wvgr88R1jMV6D61bsy6vwSsrcJHeNK0VT5ebCIz8MvHGSyKV8elGdGxL8wK5gX4/5BogUS80THEcG1nddcezConhWnYqfkheEv4gO3cF5ZgqYjeQRhCylkGEuEBnUgb5TGcYPZrqkofzSMVjseKEFDUXmuZcWi6gMizAy+qLVm8afF0fRzPpM9izCDZtGTNTVK6NB3CE1nJkMptJGd1s8uL+8VkMFIcarJFM+cmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIZv46+iiO0BOLsyF5DPp6HnHSuS2U1T9oahVwb56uw=;
 b=nIiw/DNnSByTosU2euJc8c5OwypjQ52db21qim4cLOoYufX0ynhOfYRKleASXxZQqMQFXYfmfbnasAPEWibsFaBcuaEozLiPAfYZLiiM1s8dYidn8m2uVAWqQtGuftZ9pV/yYLBrUYJn9bkSQRfG6Lx9ZV4y0z8MEGTtUyoHypQaMdY8JzyvsIwSMQQJE+RDENLbQDu/tscFQtx1ve23EfcLlZa+/IaWLfjfThPHNEoBVrL1TXp8upCAsyzAFCMCJdPlIps9eLCc/bF4ZEV74kTdQq84lUqMeXNhMw9rrQBH1mjNW/YRea+lZgzLe60SFXq4WRnOodd4ndtNQSzAVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIZv46+iiO0BOLsyF5DPp6HnHSuS2U1T9oahVwb56uw=;
 b=XRJGBqfaxCTp0JQ5gEomjIoLUXUwv0byntC5mn5uQWEgcVa8BuKgUm1Q7BqHyU+lQXLuo9IoIUYBj+sxckUb9YWA8Ts2zO8UD/NU2GLeWsF3z97kJr3E8/y7ynApx0gbBU1Zq7tejPlLxogThyV8s5dMv0Tnx4FnWOuGjJaHiMVK7aQpXp4oZJ27OAC51nkGJPBSuSJAiSNN85ZrImmxAhZ16vuFZ69hDy2qigqQ7E53Dl0y9bxEuYJDGQwenccKZw2/VbYVIzMzm2TOFIifd3lF1eUR0fjjLefBPk1ITWBWdoAvlCChdTpyz1/H/7fXkxRFK/KufIE7VU2b9lR/Xg==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 8 Apr
 2024 14:05:50 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 14:05:49 +0000
Date: Mon, 8 Apr 2024 11:05:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] iommu: Introduce domain attachment handle
Message-ID: <20240408140548.GO5383@nvidia.com>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-2-baolu.lu@linux.intel.com>
 <20240403115851.GA1723999@nvidia.com>
 <3b740988-7fe6-4328-8ce2-d66d9a2ab497@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b740988-7fe6-4328-8ce2-d66d9a2ab497@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:208:32d::27) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH8PR12MB7182:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ciqdHZMdbrmWnDYSuDo4GHesya1jYF3hxtp6fCus0D6kv8lCjq7XmDxW1AWXWdnIlv3Mis2JxkNzPn4Yqi7wEfagrGLOcX8JPBBsO/q9VyHPPBJ9ONQ5+AQpBaBgRZ2nhrGRT1+OdVRoEXlUJJTCkDf40xF3k0a4gKKY6x8alL9AgeTa/Sce4iGscN8Ofl03JXGIDMPcnGJXspbbAW52is8/PbfQZGk4k8cNddG4+35KXQqGoVi3KlYYjpDTF+3kOnsu6FGng2mERIlBtHjvS0nQezENbF1ZSo6iq+8D9Vlp0aV4TsaQXChTpq6ZA6bUvT0N2MHAo58PxZ0B7J1AeCgfjM4lOPx+i6PlzlivnAH3cPYKzmzQwQo2CnRxPOj8bUaQ1WnbcQtLtQG/5xX1cp6I2UiY24SkoYlCw7RixVJob3Vy5qrS8ZVOa7gGWtlyEhcTAIGEWk0j+kMrjBd81JmAfxJTuugqBTchgSun7XCSmemmBGbjpli90+AL2J5Ek6dnNy7HvbOovgeo42s6JNMMTr7PWnVdK/c9mmW5zzaFScYUm7YISfeAk+AUlQPTmvNZX0RjJSWUIFB26uxOGPV/bZ6ssukBeR3be/k9AabrG1lZCg+Y5LZkvHThJKGBk+aTtAe/sGfybm5e6HqqnKCD/2/4gU0d/at1ltmUyMA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ml/DAetkcEBfrQ/MV5G2GkMAZeVqCj+PZXT+neoQyThTM+XcS89uA/EPJ9QO?=
 =?us-ascii?Q?LuADlJpRic7EXalNRZdsmbJrrVoXJiGCuumcL1pMiyDsLnh8OCUSU3UCVi5O?=
 =?us-ascii?Q?c6hZTi5pFTAHvxgxhxEj5OQ9yGBqBG487ezWRPCNQ8wehpDUetwQwcFrnGP2?=
 =?us-ascii?Q?+CXezgoEPeuYB7V4WU42/svMr0ruuE2ufPh5eO2Ju5NiZAZOPqKzYToet3Yu?=
 =?us-ascii?Q?yIcLUbiVnD9ncuWzLy+Ixd+Jh3soBbJ+ikU9mAxSuiSKyQmM+wh8Nsx75qQC?=
 =?us-ascii?Q?uMZv4c9Nh+anPqxJ8z+p2cyJRO62uOdIo+IZHA7KcR46Y1CJOAb05qizpbB6?=
 =?us-ascii?Q?NKLFAGNR4uEGsN4YDBhpAHL63TtNtyDU/+HkEnJYUZ1jdui4qBlBZmq5aK+0?=
 =?us-ascii?Q?thacEoxxWJiTe1nPxkLHzJ4/3dHm4W8n+0hRKuEpmwhe35cliS5pfVrqhpVP?=
 =?us-ascii?Q?OSazelNnMfUDB3ot/eBQ0zgWaCE+Xqx3IwKdxSA0ZLsWcnOZ+FaQfwGMv4Cw?=
 =?us-ascii?Q?SlL7B95n3OjbPegNUyH3HpOPrx0q7Bda4Fq7yWrF8UwtFpeBSZuliBobrWEP?=
 =?us-ascii?Q?2BrqPdnbPCo6hU/e/phhCyLkgtu4S27uzGha/CVxL+zZXKG1bd93PMLfsHYh?=
 =?us-ascii?Q?sx1//9/zrfs+5pOKx4GGmZxlCNf1ytINGNjSjvquuK8zkoipNOXKGrurgkd6?=
 =?us-ascii?Q?u/Iithcz3rBfUu2Ltho+2WsW5vMUPHdqq09mHLcs9goD56HY6tzcNuZUEkmK?=
 =?us-ascii?Q?eOYwjITHGDi47K+YV2wSiTaNf9OUaRrnD1fKQqKkRzX2SSvMrFFIFEnZJlP7?=
 =?us-ascii?Q?o+g0qEN6QSt3BnP7eWIeP+9Tb8XzfMOCNxPPdlMygwIUh2d5WNxHTZ1krCS8?=
 =?us-ascii?Q?R03jzx27+5mukySv8dRYcz7V3krBwmOTSbl/4RALR8TIrPRGl1nZhZwtmUJC?=
 =?us-ascii?Q?E65wDoZH4/FskJ6JjiHUIfFV5HXrwestU2LA64z92+MKfsWAcjJSP2TseyXD?=
 =?us-ascii?Q?DUuVUYf3U0eXGXbXaDoq+zj+5V2qSonL9VSeMegofsflMoOlJ/cdqLcVwGRj?=
 =?us-ascii?Q?BibhzlXpT7kdUwhKTTRqruDz6SIQ5E0+Fzg03b/XSAn5x9XU8BFCE7m+Koa3?=
 =?us-ascii?Q?zTHgXhuyD5W7RhSytOFW/06lSjD0YZt8h0gwldmk7frfhDlJ9r9EGz/Ret1c?=
 =?us-ascii?Q?OmsuE3BvVVeVXwFB7POgeAUwaXR3T5L66liAxcO2E4qm+pDjc3kXN7pbSpUB?=
 =?us-ascii?Q?mgDOZBNLlx9jkTKS/Xd3dbCKVtgQ4NnlHMbN8ukLT/yO/p96DYbjRonlbgIM?=
 =?us-ascii?Q?hT8lXXZFHpf3EXaEagswFcvVVh5zFPcGCkfJfENdKWOCr4mQk3CY6G6Tt0o0?=
 =?us-ascii?Q?xfrUaEw38CU7Cs6aOUWNa0XhPo8LqXnMlTssYWQpHrbKa69tjxzN0U8CFDHp?=
 =?us-ascii?Q?L8nBNCFLu1c9IzM5Ak2zaGEE+LclHFugc5Md8iDP+3DrT+R/Z9KLbDHBeCW9?=
 =?us-ascii?Q?/bVukoaWMBiH9zm74E9zubZynNmlAOK9RAq0WS8f6UiZkPJbYH0DHKQXvrUT?=
 =?us-ascii?Q?VAr6SV7NkQzFBggeodU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098920d8-f9c9-4282-7a33-08dc57d4fe81
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 14:05:49.6061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIMnn0Kg87HcbmQimeO/WnX8oTvEcYF1j/Ow9aRs4gvgSOYBxdvlzEshQW7izr2N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182

On Sat, Apr 06, 2024 at 12:34:14PM +0800, Baolu Lu wrote:
> On 4/3/24 7:58 PM, Jason Gunthorpe wrote:
> > On Wed, Apr 03, 2024 at 09:15:11AM +0800, Lu Baolu wrote:
> > > Currently, when attaching a domain to a device or its PASID, domain is
> > > stored within the iommu group. It could be retrieved for use during the
> > > window between attachment and detachment.
> > > 
> > > With new features introduced, there's a need to store more information
> > > than just a domain pointer. This information essentially represents the
> > > association between a domain and a device. For example, the SVA code
> > > already has a custom struct iommu_sva which represents a bond between
> > > sva domain and a PASID of a device. Looking forward, the IOMMUFD needs
> > > a place to store the iommufd_device pointer in the core, so that the
> > > device object ID could be quickly retrieved in the critical fault handling
> > > path.
> > > 
> > > Introduce domain attachment handle that explicitly represents the
> > > attachment relationship between a domain and a device or its PASID.
> > > A caller-specific data field can be used by the caller to store additional
> > > information beyond a domain pointer, depending on its specific use case.
> > > 
> > > Co-developed-by: Jason Gunthorpe<jgg@nvidia.com>
> > > Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > ---
> > >   drivers/iommu/iommu-priv.h |   9 +++
> > >   drivers/iommu/iommu.c      | 158 +++++++++++++++++++++++++++++++++----
> > >   2 files changed, 153 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> > > index 5f731d994803..08c0667cef54 100644
> > > --- a/drivers/iommu/iommu-priv.h
> > > +++ b/drivers/iommu/iommu-priv.h
> > > @@ -28,4 +28,13 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
> > >   				 const struct bus_type *bus,
> > >   				 struct notifier_block *nb);
> > > +struct iommu_attach_handle {
> > > +	struct iommu_domain		*domain;
> > > +	refcount_t			users;
> > I don't understand how the refcounting can be generally useful. There
> > is no way to free this:
> > 
> > > +	void				*priv;
> > When the refcount goes to zero.
> 
> This field is set by the caller, so the caller ensures that the pointer
> can only be freed after iommu domain detachment. For iopf, the caller
> should automatically respond to all outstanding iopf's in the domain
> detach path.
> 
> In the sva case, which uses the workqueue to handle iopf,
> flush_workqueue() is called in the domain detach path to ensure that all
> outstanding iopf's are completed before detach completion.

Which is back to what is the point of the refcount at all?

> +static void iommufd_auto_response_handle(struct iommufd_fault *fault,
> +                                        struct iommu_attach_handle *handle)
> +{
> +       struct iommufd_device *idev = handle->priv;

The caller already has the iommufd_device, don't need the handler.

> +       struct iopf_group *group;
> +       unsigned long index;
> +
> +       mutex_lock(&fault->mutex);
> +       xa_for_each(&idev->faults, index, group) {
> +               xa_erase(&idev->faults, index);
> +               iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
> +       }
> +       mutex_unlock(&fault->mutex);

This makes sense, yes..

>  void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
>                                      struct iommufd_device *idev)
>  {
> +       struct iommufd_fault *fault = hwpt->fault;
> +       struct iommu_attach_handle *handle;
> +
>         if (WARN_ON(!hwpt->fault_capable))
>                 return;
> 
> +       handle = iommu_attach_handle_get(idev->igroup->group,
> IOMMU_NO_PASID);
>         iommu_detach_group(hwpt->domain, idev->igroup->group);
>         iommufd_fault_iopf_disable(idev);

But is this right? Couldn't there be PASID's doing PRI?

Jason

