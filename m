Return-Path: <linux-kernel+bounces-137703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B0489E62E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28200B22B96
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8AF1591F3;
	Tue,  9 Apr 2024 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YGPBkQp5"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2094.outbound.protection.outlook.com [40.107.243.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7102770C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705871; cv=fail; b=EhNNmR0oj/z7AlVYATLARWu6Ok3A2mOP6+jEs+lpi+OHY+wN73pKweaqwGILozaclI8Pd3ai0zlrrbGnxpqRC2M7idDTNTTHI2gGlK377H8YiH1OeVusKVtMGdozSpEHCzkNCqzF54bTzqdPUE4z29suuQyvJLuAYIap4vu55kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705871; c=relaxed/simple;
	bh=VTjtGelYoCQLE5heqSkcOSv7ZHzcgVeOzaWMXLe46vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ojkuxItoZKDV0X4s2NmbeQhgb32ASwghy/qFg9O3osKo9/F364xBjEQlZPczgWbAihf/vvh/KZuNygFRdu7dIy8G54LcGKiiis4ItVvu9rZO+tdWVxhzzzDv70IJEQNy8y06RnGsbPClzV5fXw01kq3N/ZjnW73SlNsGtZslwDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YGPBkQp5; arc=fail smtp.client-ip=40.107.243.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcJGmg2kLPGVlGLFXvDqBppLzotdP6gGd9pcjS/YNJGxTRBWV6+VUaVXb6AhI9/QhdctN+3t0YUAooqMYAwDjjfOCb3AXDGycVPqrAYR30LH8jiBXICVEWUhkNdwkAZmCfB0O7OCTyHdsiIzEtjE3LaRlzaKZmu8gEATcq4pF/wDHO6r4bnfKLbESS88wNEpkPNVjzrnX5B3VJcQBBgo9P0nSwHHIH+zDeVQ2RRPWyWSuRb5Te6K3nWeor0QLfkO4C28F1xmU/1mDULOjehZe5HKtdOoARPGjVmJ75EIDqXADrSxnDLVViA/37UWcB6fp3RcFp/M2o3dUGvR4es5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IpGrnGO+L3WySjGonK20fSbPGCkpndthFhKCrYpGN8=;
 b=U4qXDkkj34ofcdGZkN0txUYaLd7a2o7W17w+6tPqZaHe9ctoOYp0sC4KvRXeWe2efUCqxSNcLM2ZD+mG58mWckujq7xxKqEfwmWMOukha+R6Wf+mWPUDcLOJGDdtfhHA5sdiQl/5kmeVY762yVqF2YgMbMU/ryV56x7+N2wWRN94sKYiKBOFRF5JD4Iw5HNZ7HXM0hY3SxfEOAp3qwCxyPghaaiHEZPHtvrFgFzv+Y/ihmmP5Lep0spQ0CDlj0lRqbaNd2Qw9g9KU3L1ypiQiXrnMmj1VodEUc1NJxy/5UXm3jA+EaQlVEJpWZ2rz2I5l220Xuh6cXtseEoeIXxJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IpGrnGO+L3WySjGonK20fSbPGCkpndthFhKCrYpGN8=;
 b=YGPBkQp5eHE9xV8JN9Oz0W5p44JyuGDYPKQ3zzxqAnK+8Bg4lb9DufDIAGehvljpOyxgOPY+BPTTySkEwEiIud8tsoUZzux1zuS284QaDRdK/9JUr2hZrMlwVsJ1GDsK6I0wINoAODoMjslG4CzWrwelwzx+D2kLWmqTxdHCi1APdpcJZmU0khM+IouF9+Z7ABCf2cMBtDaLfnJGyR2vsjaWU647EUUI7U2eMYjWBfcuEYb+0s6yPnwqoiwDkPjKu7CxTHyzL2Xp9/EQ1R3RFF/ZLqHQcDewgrCQHIa/IOjUzWcwZsJKCI1n618m6ZtkniIB+gGqLHP424zRePB0ew==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 23:37:46 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 23:37:46 +0000
Date: Tue, 9 Apr 2024 20:37:44 -0300
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
Message-ID: <20240409233744.GI5383@nvidia.com>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-2-baolu.lu@linux.intel.com>
 <20240403115851.GA1723999@nvidia.com>
 <3b740988-7fe6-4328-8ce2-d66d9a2ab497@linux.intel.com>
 <20240408140548.GO5383@nvidia.com>
 <4c07d54f-6c6c-47be-9e5a-3cff8162dd3b@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c07d54f-6c6c-47be-9e5a-3cff8162dd3b@linux.intel.com>
X-ClientProxiedBy: BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY5PR12MB6371:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t1ediwIX4ANJL3vcWopl0smM/O/rUl4aLn7NNcZzAO9kuti0HHMLH0KauexmOfIRGNoC1sAhxHOgfFw6fd3eoaA6bySr9y+RQsZ0LFoCUAsZMaPvS3VekTSHv2MHgbnA6IRHmpdck5ntV+8aLKKXswwVT0BeOAavPsLAteCqi12ect2e71f/k1kwcvKcClQt3UX/H6+V2iRtG8HFUc/Cz04Acoz+YEKvoMO6XBHkdiQ3EB/d/ykMdgZvFpGX+f7wQBwuJ+PrkJFFa7a9hqVIuXyYIFA7h0NnSuV/Y7t1EIFDHXHpWJSn6c2iHy63sTNVv+BcyU70ClXyqa6EbRH6lPEfdasE7rhiBM5PpivwseWa7M5ZbAdRaFwicrK/bNLdcXa++X9XdoZoT+Un0jC1i76lBDw3zj+RnqkPrw2IoV66JSsoUmFMeIz+Kn7cWAnti0wSPJHIvL/Q3rYykFOQRNBiIZwekirdilyTZc4HQki08Rwig4B/moNZasPE6zy6x4Gb50NuJiMUvEcmwmZ6J0EJKlcbyo765HX5r+33C73s1fUMrKxNXAEU9gn7xXVbfNlGlfkIh3nsOXKtk4AU40YkSIWAgWjbGUs5fEsudSADOWwBdHEzUb4ecS8ekwATlnW+K0/NGiDrTeTsF559Uxd0WA6v/6l9b8/h0bqEbL4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gdnTPGs6yjPbaMgLxztnVbO4b6odNVWLlZ8T6REwOzs0CMroZ3DqyGIg+miz?=
 =?us-ascii?Q?kbxLyFDhsBNNM81qRE1b1eml8AT5f/M1G/p8uOhsygGrNEtPqecHAdemc959?=
 =?us-ascii?Q?Kf4rS+nHRQPVcX3QWA0XpXciUFsPZqj53RiGg3sOkHTIJgfkc6HsElCPS0Gb?=
 =?us-ascii?Q?QBlnhezdUcVRC4BpIopuiEPi5FZLurNhzGBzgtWOf5XIpX6PeRmX6/guDFtN?=
 =?us-ascii?Q?prFTFiFLuxg9Bm1Lz12NhfqO4awGJWwGq8u967x6Ch1IQsUv3HKJR+VlSvHW?=
 =?us-ascii?Q?4PlsoAxycDXuHmQ0XiL9jWPF8MExj9MUdKUzLJiKZKha6BF9b8NfRHmRyJtf?=
 =?us-ascii?Q?k/D6YrecfsnjNDv//42i6Eag151fYwYGcqck0MMFrnCTB1Ot2EnRzapaEXVk?=
 =?us-ascii?Q?MSqR072wtVqmslfuZRe9Vqlo/ZXg+aLjsTTOG6MRnjTs+ZzK0oKe5je/3kCL?=
 =?us-ascii?Q?f7z3K9FyoX7Y2t7nzHzYyee5KLnLOhUnSnLsPXuwsBwUUktNUatY/hDjOeDO?=
 =?us-ascii?Q?5akAoW3KqsjT+bszv59+dOKATPY1COjGZICdBnaI3yF5NYbOD4Wxn0cDIoeQ?=
 =?us-ascii?Q?MRKfNY+jNC4HDX7RI2XJoPyp0jtVpqIc2HbNhr5OXXhumCJidw30DYmTFOvD?=
 =?us-ascii?Q?5X0zFAeDZxkQW99RArA/xGHqm2iZIDnZ62RII6j0ZnAPCxHrAdrDBrYmthZu?=
 =?us-ascii?Q?Rzjf5a4wUQQMKzJRHLXECgiJFk+xT1y29uJbI+5VRm+IsIApEO5vRfwyONO2?=
 =?us-ascii?Q?dJHS3wXX4kNkvd6v8bcOW8UpFZvVZwQcJ6ZWNpjFjNhJoKGQt1TGBgj0eSsj?=
 =?us-ascii?Q?9K4JKZJbiHdiO3JB3lwHgLQ3zBnuTXOppnweDrLxGJVGC2ESD3XxV33Ebw41?=
 =?us-ascii?Q?+nknB/CmyMd5F4sy2POnRYBZFMAXmAezyVB95VQQMmRekjX2PY6QT/BjugOp?=
 =?us-ascii?Q?F61WVLnFhQK/AwrVS8CKoeIxIeT7OQIQ6kNG3sphrgc2Bs2RR8c7t8EFnhxZ?=
 =?us-ascii?Q?nU8POh2NQVZ1vjEyGDqFV41ADpWWkJZfLYSfbgx9TmyEj662m+rAn3UHIff+?=
 =?us-ascii?Q?JEipNhTdGRpYRZkVOqPGtl2XZairir6qBo6EYI7P2KIdrSes8iB5EZHUIc72?=
 =?us-ascii?Q?FPAFzLgR8zpsZ2SPkwGlFkdF98cDAQtTL6Q+LbcdEjCd2IO9LoGq/o3X790L?=
 =?us-ascii?Q?5+FAr5hFQu95tdBQwIh6P+H1gm7ceXCmMqxJb7L7icNeCcKUh3x72hSdI4Ji?=
 =?us-ascii?Q?DMKGenhQFQ3NAYideg7TaDjiPbeiqcyxs7RMIR06h0H09qVq38O2dr0hXkIU?=
 =?us-ascii?Q?DrddzrMQAPBMUjL55EU68alYp/MxFSc4DCNJIrqRZ/2GGcksnS66VFzGJ8C+?=
 =?us-ascii?Q?Ik/EziIp3YM3n8ccRMxa8lpahUXKlciZzcZG/6yM/MUA51ZFyDxuBOIX106G?=
 =?us-ascii?Q?YXPjWwM1MwHvEDu/SsZKRInpD5eckXsGK3XzcONLEm68zLKEmE1MmxN6EznS?=
 =?us-ascii?Q?kDtKcd5sVallVIHkoH66q2dt2Xp/WToqt4mrRRaO871fNMRYQZQEZNjYtYbD?=
 =?us-ascii?Q?J7RhxqpT3viLbCsqR9ncjE0HXXSRFVz6xOnXoiLJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fa5fec-d664-4ba0-97ce-08dc58ee0f0f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:37:45.9422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPVFPDowCpiH8rgD2z5RHkup52Llo4/hNKJWLyIa/Bc4pcAyrCj6+O9c+Rgg2eoC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371

On Tue, Apr 09, 2024 at 09:53:26AM +0800, Baolu Lu wrote:
> On 4/8/24 10:05 PM, Jason Gunthorpe wrote:
> > > void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
> > >                                       struct iommufd_device *idev)
> > >   {
> > > +       struct iommufd_fault *fault = hwpt->fault;
> > > +       struct iommu_attach_handle *handle;
> > > +
> > >          if (WARN_ON(!hwpt->fault_capable))
> > >                  return;
> > > 
> > > +       handle = iommu_attach_handle_get(idev->igroup->group,
> > > IOMMU_NO_PASID);
> > >          iommu_detach_group(hwpt->domain, idev->igroup->group);
> > >          iommufd_fault_iopf_disable(idev);
> > But is this right? Couldn't there be PASID's doing PRI?
> 
> As far as I can see, there are two types of user PASID.
> 
> 1. When a device is assigned to userspace, the PASID table is managed by
>    the userspace.
> 
>    Userspace doesn't need PASID attach/detach/replace uAPIs in this
>    scenario. All I/O page faults are directed to userspace through the
>    hw pagetable attached to the RID.
> 
>    If hw pagetable is detached from the RID, or a non-iopf-capable
>    hw pagetable is attached the RID, the PRI for user PASID is already
>    broken.

I would say in this case the special nesting HWPT should have an
indication if PRI should be supported or not when it is created and
that should drive the PRI enablement..

>    The current code base doesn't yet support PASID attach/detach/replace
>    uAPIs. Therefore, above code is safe and reasonable. However, we will
>    need to revisit this code when those APIs become available.

Okay, I see.

Can we do the PASID iommufd stuff soon? What is the plan here?

Jason

