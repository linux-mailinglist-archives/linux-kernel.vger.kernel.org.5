Return-Path: <linux-kernel+bounces-74768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F238485D95E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB712846DD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B967BAF8;
	Wed, 21 Feb 2024 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J6fGHlcp"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEC079DD7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521450; cv=fail; b=GW+Vp/lq3V48svYzB1uMXEHCe8dqYxs8MKvLBtZ3ESBZFD1iyB2WghNE/PEhvvheV8z9WKVoQRVzF3soo4ja4XYXKqqCmxUMSdcMld2ZZDvCtm4hObTLwR3QngBFD7Vdj4j6YDwnMoahH+AQOcd5tscyFiLGjXxX5MMuh10u/ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521450; c=relaxed/simple;
	bh=r5VSkYFlDzjoa6YIldrHun6uI6LKqOxPp+aL1Cr0Vb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qnftOYYCMFqkYTEWI87gD1mMAIEeIo7ehRAdgyD9uJyYzMaNkIa0Yu94YX3wN2y/kAqcC6ji3H9Vjfu0cHv7BImD+7sG7tndFJH5OWnu0ZBlUNhJgP3S+BIaB9g9sYFf1B6bFchFB+k9L+6IiOHMP+qLpzUabScZfnVWG77/aL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J6fGHlcp; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5Ui115EEoSNnSo/s+Rq5W0y51XOaSBBfmbMSPdBAXhgypy8iF+PE1Y7+o6wxObQx0PKNkCEV8+E1YiC0py32tf2g6L6fUYpxKZKVmWLxh5IHX6Hr4Ryc+9+VkbJVYTysdS+tOmKY6t7swpA8OZuWvCklhFUv3VYc3TSLB8o3/Eh3E1itc6SRthR8MROlTvnw37cR8qO5O0EwNPKq6SS9T2ZrIjUygzbipUTtl/B3ZNr+ibnqPGO8dnsqncrvT8Vtg3gsdwH1t/BfblqsrwsSPfhx9/i1YKTBO9BFqTHquuOyu5D+3m3JSYGNsVcINQ1ufx1jzm9mC7C8EK352tpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/m6F1ZUy4EHmkfIP6C/s2L6dTZCViFoGS2D5kmYPRow=;
 b=dbJzc109RUxAD26xpLAa4BUT7aMb01gCwgWEzc78oH+2y4iQFtS4+4cHkxw+lRhv9h/tElK6jbO51TjNYDWMr0CxEVCV65ocChohFRSvjYbBXoeb/WI29FtZY9zMu96KV7/CrIt4hD20cw+4fWFEKSV9kyU6AHz9iupuXD2s/8HYoAvjeM+8C1+Ike0P2Z45D5QdZaUdFY1A46VyDWqzKxDayi7XulK7hOUB2gVGRhbsOnVhnwJ/NK2rO1q7dIun21mjk77NUnSFkuvZp/KUA3fiGFq/1OBujdXiYXm+QHO3FzKi5jEoJ+XKP9nLrS2MYmW6H9ra9U9ZpW5UR7h0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m6F1ZUy4EHmkfIP6C/s2L6dTZCViFoGS2D5kmYPRow=;
 b=J6fGHlcpHHU4l3bfvmI9IN8b9isM0NpN+8lweRLlyXxIyuVMuoPutKu/l9yrac883UtK2zY6I/DTB+MQT/1ric7g25353KQ/iz8gxuct1US3LVcluFw2FlWQcjeTxe1bGoK1aLeOdNaVqyDOhHg90f+M3C+xG1hOcDGdvss4AkE7/ute6yoUrBj8FOnRxlyBEnQr8eWq5gSEbRyduKbSh9zaUjfCmvAmPDJJwC/f5TamhmUqen2JXBNnqw+PEe+FDwO2KlR4L2ZjXROUOMg9+rb32K10G89mNs8XL6fRYJr47XjGbmZOArxaGCUvuIKMmIkJRGSxjarmCmhaFnM0aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 13:17:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.023; Wed, 21 Feb 2024
 13:17:25 +0000
Date: Wed, 21 Feb 2024 09:17:25 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	jean-philippe <jean-philippe@linaro.org>, baolu.lu@linux.intel.com,
	"Zhang, Tina" <tina.zhang@intel.com>, kevin.tian@intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu: Fix iommu_sva_bind_device to the same domain
Message-ID: <20240221131725.GR13330@nvidia.com>
References: <20240221110658.529-1-zhangfei.gao@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221110658.529-1-zhangfei.gao@linaro.org>
X-ClientProxiedBy: MN2PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:208:23c::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8fbaa5-484e-4f36-57fd-08dc32df724b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WZOfXG27FoTb5HDqpF6u4YITiFi37F+abKjQGSchPa7eRiMjeK04k+osno5to9pkjXw80VEXPJMBrW/yHbFkPR+MumCmHlX8zaaaa4xZsLDQE/PkDfRW7iiRByzbO5fL7GG/skvYtQ9W9iQHYyA5wfakKp28U684x97WD3SVCZz1U/ZypsT9m5/zHpPYnr6yExJ7quFTX4SjV4+XXDHUu0/BT7Yd+UR7yjZsdpLi54qdivscutyw2NAsj5Mt4zIWUwPrpjaJH547uGWWFSe9KNXTYt+rVwy/Ccx17Tn5t1Hyqr9ifveevQRAIjFRlJRpQwwwTNXaojMcKb7h4WxEcf0Jd1HcxCDtgXGiN98vq8ntGCx9/YuDdyIOdkeDveboiKXanAAswqrnvCUjNnJAxcXPFnI82oVXY9QB4kR5x42Fk/vyLSHCHvt4JBw2KtJo/EQWVJq8JqF+YyHIPrAtSfKZhI6Nyppr+8BeJOJTyZVqQoFGC4NbmyUbn2hNCz+g7wzrvB30a2edM6vy6/EVZcVoYaCwUidKj+n7QUXJVDk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?asFWpdYNUMqMT4CZwuvzfm3gTlvpsxM63sY6pRqs00VlASRUhIC6H9oZeW7x?=
 =?us-ascii?Q?mUeVXBSaQ3zgwOdB7NNl9aGMHv1v1YXhP8Z8LwYmaKGA/fC4XXdnfNc6cQPp?=
 =?us-ascii?Q?yDa3F/9E1Z8NyrhqQQxNw05PgI/TR03WI9v1uLazfBdrySlgH/TL7A9yXcVe?=
 =?us-ascii?Q?hrKfBEa/byU3yCUJq6YiN/VpoArojcTiXfcoptAMJmqq6fdqTF+HB1boNe46?=
 =?us-ascii?Q?hXyVlFRmTos0bQK2PSOzwoQQ2Pw3ORf3SrxmxfYyOtLH985G3Efxwtud6D/i?=
 =?us-ascii?Q?P4b6zY7l99c2pw9do84ixNGXGmuJcMZwdeOquXMvFSZdpG4TR/twfv9wKHGQ?=
 =?us-ascii?Q?14w38Tky/qs/Sz7y1MWAJFoxnUvLQvXV2rtT00DjlmOoiTVlMQPe84RAY7nF?=
 =?us-ascii?Q?CxmDgWK53G5XhKBxArqrQKOon9eUIXv7oL+azWXPLGq0u/LvmUHYUnI2HN6T?=
 =?us-ascii?Q?OBH+vx65O0beBP1O321F5Rf/WIHT9lHSdPFieOUxAdSDiDlrR3BmmdqoTiui?=
 =?us-ascii?Q?K2vzVJAd8zkPEXogVXTUwjiuCAgCmAJzHCYSdENX3rYWa2dEffaqg//Rdd44?=
 =?us-ascii?Q?5UyS1c67M6zRVwWP5nWc8Qt7Mk+mJJOkiC/yRi8sQ1Rdq5WN4hGiSNfQI4yQ?=
 =?us-ascii?Q?fNV90/IUrJO6VCkTyAvSYpdHycoTI25HpiTO1KBYj7lRuf3DwVcG7Z4Abrbg?=
 =?us-ascii?Q?pJxU1wFTRWBF+m2PU3T52nY4L25voY/FFI9dmsw6kjnrGtSnWiLAutnNtulc?=
 =?us-ascii?Q?7GGN9Msp/Rm1g7H+W8U2zeWyJl+NeLDzW7QqFn2vPVr5+asmyA091m+olbJN?=
 =?us-ascii?Q?mM7MuDbDcYORDvHNBd9XxzNdw+Za9B9hLNsRvGYAul8PO0OwML3Ipcd2obZB?=
 =?us-ascii?Q?OSvAPodkP+t9P/hrlws9tPCkWnvscyvuLnoagsAIinq1/PDA0CeInZYByc9c?=
 =?us-ascii?Q?i2fpzYjBlnECmWy+rDoMhMsmrKadadnjLv/7CBlJbqfqe0N0Uzb0A+xNPUyz?=
 =?us-ascii?Q?7P6Ehp5j2Q5wYZryFYnS8ADiGjuEIcrsO0bLgovMNQLITAbZNYmQkMI5WOpe?=
 =?us-ascii?Q?R/MPFXSYAVYkC8Rrx0RT03B5tw0NgTxxJlDWz3VPPvi6CL/DR3VYJJQ/n360?=
 =?us-ascii?Q?6NMaM0O4L+HreOQesaL7Ftjbt0tDK+n8cOtMkc5IJ9aZy5Z1powF1FTnXKtQ?=
 =?us-ascii?Q?3gdCZs8BaIq3zTxDPkpGwtKeT5A98+33KJWwYaG/FUgUidWn0hHhw3RANPwB?=
 =?us-ascii?Q?hL9EnsrBAkfhLBenNYsEHqSQRVchrITXX/R6Gu/yVAm9t6Fg6YdU+7Sfvjo0?=
 =?us-ascii?Q?tOzXcm7eWk2XsAU5xnktuvsUJpSCxXc43THhPuA3DeVQ+blUgePP7DC5LC5p?=
 =?us-ascii?Q?eFs0dl3XWe8lif0h/Dh4K6ursLPfJnJSp80ywllnvdlJXClpItzkM9H95edN?=
 =?us-ascii?Q?2/+IAvofEt4OeCkvrE1WI6B61AKhO/yNhUCtcxAgUWpMFWP3MivEAAUy87U7?=
 =?us-ascii?Q?ny7XtBKCfRxScYrUk5eAUrIo9pbE+zAr20T7EIeceUOtpZfWaFPVv51F2zwW?=
 =?us-ascii?Q?v/wa1EZvtpGm71DNVUlXWmVjIqHFvuzoUx+BxZrP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8fbaa5-484e-4f36-57fd-08dc32df724b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 13:17:25.7169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAd3bFFpVHz5qRvehK2S8ZF0fOO1oyHSYjbm2MQqv5qwgEofX08w341d2DUuQiq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205

On Wed, Feb 21, 2024 at 11:06:58AM +0000, Zhangfei Gao wrote:
> The accelerator device can provide multi-queue and bind to
> the same domain in multi-thread for better performance,
> and domain refcount takes care of it.
> 
> 'commit 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> removes the possibility, so fix it
> 
> Fixs: '092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
> v2: Instead of checking ret == -EBUSY, 
>     change iommu_attach_device_pasid return value from -EBUSY to 0
>     when pasid entry is found, and refcount++ when return
> 
>  drivers/iommu/iommu-sva.c | 2 +-
>  drivers/iommu/iommu.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index c3fc9201d0be..20b232c7675d 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -141,8 +141,8 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>  	struct device *dev = handle->dev;
>  
>  	mutex_lock(&iommu_sva_lock);
> -	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>  	if (--domain->users == 0) {
> +		iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>  		list_del(&domain->next);
>  		iommu_domain_free(domain);
>  	}

The users refcount is not to provide for sharing of the same PASID it
is to provide for sharing the domain across devices. This change would
break that because we loose the 'dev' that needs to be detached in a
multi-device case if we don't immediately call detach_device_pasid
here.

You'd need to build something much more complicated here to allow
PASID sharing.

I wonder if this case is common enough to warrant the core code to get
involved. I suppose maybe, does idxd have the same problem? It can
only open it's cdev once because of this - that doesn't seem like what
the code intends for a non-wq_dedicated?

More like this:

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index c3fc9201d0be97..aec11e5cde6b0e 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -41,6 +41,7 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
 	}
 	iommu_mm->pasid = pasid;
 	INIT_LIST_HEAD(&iommu_mm->sva_domains);
+	INIT_LIST_HEAD(&iommu_mm->sva_handles);
 	/*
 	 * Make sure the write to mm->iommu_mm is not reordered in front of
 	 * initialization to iommu_mm fields. If it does, readers may see a
@@ -82,6 +83,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_unlock;
 	}
 
+	list_for_each_entry(handle, &mm->iommu_mm->sva_handles, handle_item) {
+		if (handle->dev == dev && handle->domain->mm == mm) {
+			refcount_inc(&handle->users);
+			return handle;
+		}
+	}
+
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle) {
 		ret = -ENOMEM;
@@ -109,6 +117,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_free_domain;
 	domain->users = 1;
 	list_add(&domain->next, &mm->iommu_mm->sva_domains);
+	list_add(&handle->handle_item, &mm->iommu_mm->sva_handles);
 
 out:
 	mutex_unlock(&iommu_sva_lock);
@@ -141,6 +150,12 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	struct device *dev = handle->dev;
 
 	mutex_lock(&iommu_sva_lock);
+	if (!refcount_dec_and_test(&handle->users)) {
+		mutex_unlock(&iommu_sva_lock);
+		return;
+	}
+	list_del(&handle->handle_item);
+
 	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (--domain->users == 0) {
 		list_del(&domain->next);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1ea2a820e1eb03..5e27cb3a3be99b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -892,11 +892,14 @@ struct iommu_fwspec {
 struct iommu_sva {
 	struct device			*dev;
 	struct iommu_domain		*domain;
+	struct list_head		handle_item;
+	refcount_t			users;
 };
 
 struct iommu_mm_data {
 	u32			pasid;
 	struct list_head	sva_domains;
+	struct list_head	sva_handles;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,

