Return-Path: <linux-kernel+bounces-97136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F18C8765F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E719FB22572
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B74597E;
	Fri,  8 Mar 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FHQUoAda"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B473FBA2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906687; cv=fail; b=hwT5J5cd9ouenPlHT4/Bn9aZZ/ztQua+UjBEVspAjI5/ryZgkxo040e4nMEkcxta3d6sHFOjUj3lHt1E9qoRFw6VbhTNbNFnT5Mlfrs/5zvEP1R9xA9KDh34PfzrEBV0WcUVGRVjABFlknRV1+clK4HmOirL7jiv7E843aXIWXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906687; c=relaxed/simple;
	bh=4GhkANg8FvtMo2Wo94MfzWTU/UWUZnR6yOqhiQkGsYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RehXYI+6WuMqV2fkndZqupIXYgF0yNfc+1927bN4pg1NqzeRVXsc+5M+LFMU/QTPbVjwInYGMQcOnZmpjTL5RMpfye0ai9/+lY/02QsSS/5S47rIPEyCjoigy/Dh4mv2UhnCdJMT/rL9NGFc4mcnapOL0YuYp+Haj6XDIlbRBfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FHQUoAda; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvEnwYDhZm8Y8dmApZkCOraLEugSGCrxPRaHMWTMwNoTKFvzF/giGg36l/tjh3Ijy0RXg/T2cSe01QHv+s/+nzympDj6pfIP0x0Xwfzg6YTr4lyeTVM7919baa41E9pIX/MhkSa/Pi+3gd3kWooiFtv5FdGDcJQGapzrfXfO/IvfyayAsPQPreWnyE5BBbUqaZr6L/UP2xf408TBNKXmvwPWkC2wrUgbBDseF2PvZAaprwP5ZiPm4tPxFQF91GxAyc/wGOJZ62a5Y/RN/CNIOmLqm5BaNp66iIy9jo2D92myYvW1PIZ48zefqLkQ5BZPRbNypsIYah8pLrzagh77gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5c/LMVknU82XBOGqzQx0l2l/1kvJS7ub6qbOLOJm81A=;
 b=TcykUc5KNqH7FcmobhPI6Ym/5noV1K4vrmw5mt0FPNKhhdrTbBpYaIBhUaXDm1SUB/6iD5ZfPwtTjQy+UTOvu1lf84tXCyrMcw/ryyRE0MwcE0x13zTXn7yelsSgYVO/yidGlRNQaqRR/cGRc9MyBhUQFqknZfxUzb2MVyj8zJjytNagwZJVNP2Z/6ZDhNSGKD21mDvULzi+lMemkL9qGsWLji9yNi8ODX5+WnSgRl+I/YrRBCdrSusZNdmP/wdPjX/ZD4WcpnoqPXew3Q761KlT0IdF2HkWd9XcM2aTuHHRyU0CqDgX6k4KXVeVXsbbibWiVB2E315cFZwfoX8CLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c/LMVknU82XBOGqzQx0l2l/1kvJS7ub6qbOLOJm81A=;
 b=FHQUoAdaf1h3ZxAIz730wJ9pNPl7MVzzct3bcuhxFalC3JtH+vhdGPZH12yBGrsYtD38HC/zYQjKnCi1OM1bWcfZkSBd9Yaos+r9cnAqP6iT4ZAAxpZiJRxWkgvvm/gW7ga+q1pJE9d5lcTJ/eYx7wtLDtQcWOZbVN7Pcwgftkmpn4buWk6iLF8zoXfT4PQ/6VbXEiNvMXiDiBmbmenG7eN6Fg2gJfAz2eh/3YvDcKN/bpNsmhKOCVwOXf4TerwFNVCDFEIOwGd5IJOy1N9rHT3XInyot4ceqoiopReZEQBuzc4MiAn5bfzbArQ9LYS+YXdfz5+elaJijF3O7eXMBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 14:04:43 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 14:04:43 +0000
Date: Fri, 8 Mar 2024 10:04:40 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	eric.auger@redhat.com, vasant.hegde@amd.com, jon.grimm@amd.com,
	santosh.shukla@amd.com, Dhaval.Giani@amd.com, pandoh@google.com,
	loganodell@google.com
Subject: Re: [RFCv2 PATCH 6/7] iommu/amd: Add nested domain allocation support
Message-ID: <20240308140440.GN9179@nvidia.com>
References: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
 <20240112000646.98001-7-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112000646.98001-7-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: DM6PR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:5:337::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: b250b6de-3d42-477c-860c-08dc3f78b3cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ax8SfbipC44PGxTR7G7SPXdq+f3MJeB5QYTDnp0DO9mos3n8J+ja3uX074Bcn+Y/kc8y8be66laEAY5IO382ccvvwi22oXe1KguqE7OD2DTLiMv8Oxau/vtQH/aUUR3IEoRimUGpdDlrDJ7+wYCmVuqc5DvwxA1U1pi+Qzqp2ZBTVn2h9sJFpgJKEQZerH8yXlqOscmGFzv6laAISdBm6rwA1UMVsiSRPZy1UCwYQRwopiNvwWmMs5qt7k1pQrXLHCTZ3zXsWqrryk2TQYmILzZYwGrehRWG/G56jYxmYb8lmdYEaj2Xn0KK6/rAmv8szjPZE9/0P5uTUchFoYAUrbVkUquXGOmKpMQ6XGG3hw/Wt3GpyL9rdbnUkb6Uex4Wln5GrTCfsCQUsNbqDaGJ+xuMqg9g5xBPevHLhIKFZHwlSEY+GwdX0zqTjNaRYTRnXAfGs2DGk4OR+cpSk5QbSvh1b//IVVM+SCOENNBHIH/ch+w2JSgioxH95eUSMq3KccQ6TcPURwa2Dc0mPq8OCPCWG7ktnvt2lOpO3SMnH63aoYPDCW7ZdB4JQ73E7uc0Qqohvdi3L6WzllonZPq6C7LIdFeyU51NYt9w6nhF6GLWhDlEua0JKXrIn2+BqKF26aEqUzBpKyF3MQ4WE962zYD2RGVaMyh3qlDf2+aCywM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v2BsVG52RObY/MVT8Eu5Q7o3CgMOAxhtiVBLTe+PCYOur0XEURusoS8r64F1?=
 =?us-ascii?Q?5pJk/BVArg0ffXBsZRBYSbXSvG1HCwFUbUADBRoz9/Jx6pkOzV0Yhlkr7Q1y?=
 =?us-ascii?Q?EyytpKyEHqVI7l1TT/1kHwxNu7oR2xb6/jXSENZq2q8+hLpvuupaPxG8Wnif?=
 =?us-ascii?Q?ZVEthDLMRpiXcPGIpGflDElux77yJ8j0CEIIW/Uj0S9iJhkMvZcfBDffM2sz?=
 =?us-ascii?Q?0iawygUVEoIZLYdmWYWY9vyh1V+5jgHqSmNXvFpbLzu6FJEMt7lnEjWaBfAY?=
 =?us-ascii?Q?l6+TpZ5pLpX/JAAhe/oa0dWLq/KFsgRV//fBpog75EFIzZNJnuAhqtCD+Lof?=
 =?us-ascii?Q?6+ugARC3YXBxgKvVjH6n4G9MW0CUEsgekCCqFLTwX3w3elgHZkdggB/4Jy+N?=
 =?us-ascii?Q?ya4jYb09Wm2/n39R6jWPZST4yZI8RxJBJnAdroGbDH0DTEiJx7rkFBvvxpjc?=
 =?us-ascii?Q?UcsLrpTNz85He92FZIZUN4b7evwLznLk8BKifwreqiPK1DqoabEArgsilaRg?=
 =?us-ascii?Q?FuJkmghgAUYJL/7ty9P0KQScgqMYu9hWKJBa0TaVAQx8seNenxXKnTe0gjmv?=
 =?us-ascii?Q?tY3MSwk6IyI9YNUrVbB4o4EbckiC9qpcQAvW40dkDGCbSorV/6LMD4WjShL2?=
 =?us-ascii?Q?t61b/NlxoYWLmkSAn56AP8PBCp0fWG8AKUtJ1/GdnAT3JSv0Mnp0H88UbzXg?=
 =?us-ascii?Q?qtzNEwVT0RQubywiB43k9fH6uGV3pJr1MbeHwXSr2bcb7iTTmA3tD97s44gk?=
 =?us-ascii?Q?7AHCJDTIY8asOe/TUbir5cYl4P9JKuDaY0ozJqM+UYihv0VaILeQmY91ZveZ?=
 =?us-ascii?Q?D3MoUtrR34ZcBq0SUg2hU2oTxsy39xDsUszMMQXMFdal8RFipxXIKANFld/7?=
 =?us-ascii?Q?GemYlNJ7wtk1iT3eXWY99NfolW3Mx9xdzXCrRYe4owa/wB9VHEpK1gmLRxoc?=
 =?us-ascii?Q?sAT0c41bwKriD34W+MJ23Mj3L59kiqVAosOrnDQLm6er9Av9b/p/Dt/Dll9y?=
 =?us-ascii?Q?TBL8BqXfFcsHrHJwF6kBcP5fIt/0uXnBJnzX8LHFYgJjXye3Puk5yQdwA4a3?=
 =?us-ascii?Q?RiTnp1E5t8xb0/zD54uk4KtGZ5tMQBa1EbbkA/V+I6rSo9bUSarC25oj9Unh?=
 =?us-ascii?Q?NCcylzKgSkIOQ8fMsPWl8Xogbw1iFAJlRbmHAB1rCH+p2Xz8OnwHSep7tbRf?=
 =?us-ascii?Q?F4pGau8tSJRJQEqO/hihL9ncOZ5jmSWnu/LauiRK7JE+Pj27KNw3BbiHLn41?=
 =?us-ascii?Q?FJ5WsWtJDKsrS+nXOGW8+G4WdgFcwczanq6WYNETzLB5fvAUWTwxjf8kg3wA?=
 =?us-ascii?Q?wv1St1zMza0eVAUAzcVGB+geEgY0/H1x0QbVRSmd8v1EBH+1TstTWnjfD8oR?=
 =?us-ascii?Q?AfK2pT/rCv4xIXvRAwjwhwtMBTFGSrx4QYL7blfvq1TkfddIIS6Mnd2IodaZ?=
 =?us-ascii?Q?J2mis03J9l0nKwS6eArzrMhkFHjCTo30fuCM/Vr/bFllNCuVP+mtRFxmHR+M?=
 =?us-ascii?Q?gzObd6tjs2xjhG9E99X88r/SIU0qXeBrBldqo1Wvee2f+UOcZSqYKGFxJatk?=
 =?us-ascii?Q?vXPQWL9lrC6Uvkg8PMM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b250b6de-3d42-477c-860c-08dc3f78b3cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 14:04:42.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOUZkjP9XEn2JDjg1WKufaZokUJ0lVjV3UWKwURs/ithiAhUuVcKLBtqmGixWZcu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566

On Thu, Jan 11, 2024 at 06:06:45PM -0600, Suravee Suthikulpanit wrote:
> @@ -2367,8 +2372,9 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  	domain->nid = NUMA_NO_NODE;
>  
>  	switch (type) {
> -	/* No need to allocate io pgtable ops in passthrough mode */
> +	/* No need to allocate io pgtable ops in passthrough and nested mode */
>  	case IOMMU_DOMAIN_IDENTITY:
> +	case IOMMU_DOMAIN_NESTED:

These constants should not show up in the driver, it needs to be
reorganized to use the new allocation APIs to avoid this.

> -static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
> +static const struct iommu_domain_ops nested_domain_ops = {
> +	.attach_dev = amd_iommu_attach_device,
> +	.free = amd_iommu_domain_free,
> +};

I would expect nesting to have its own attach function too, because it
should be quite different.

>  static struct iommu_domain *
>  amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
>  			    struct iommu_domain *parent,
>  			    const struct iommu_user_data *user_data)
> -
>  {
> +	struct iommu_domain *dom;
> +	struct iommu_dev_data *dev_data;
>  	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
> +	bool nested_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
> +
> +	if (parent) {
> +		int ret;
> +		struct iommu_hwpt_amd_v2 hwpt;
> +
> +		if (parent->ops != amd_iommu_ops.default_domain_ops)
> +			return ERR_PTR(-EINVAL);
> +
> +		ret = udata_to_iommu_hwpt_amd_v2(user_data, &hwpt);
> +		if (ret)
> +			return ERR_PTR(ret);
>  
> -	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
> +		return amd_iommu_nested_domain_alloc(dev, type, flags,
> +						     &hwpt, parent);
> +	}
> +
> +	/* Check supported flags */
> +	if ((flags & ~amd_iommu_hwpt_supported_flags) ||
> +	    !check_nested_support(flags))
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> -	return do_iommu_domain_alloc(type, dev, flags);
> +	dev_data = dev_iommu_priv_get(dev);
> +
> +	/*
> +	 * When allocated nested parent domain, the device may already
> +	 * have been attached to a domain. For example, a device is already
> +	 * attached to the domain allocated by VFIO, which contains GPA->SPA mapping.
> +	 * In such case, return reference to the same domain.
> +	 */

What? No! This would break all the lifecycle model. Domain allocation must
always allocate. qemu needs to allocate the nested partent domain type
from the very start.

> +static int nested_gcr3_update(struct iommu_hwpt_amd_v2 *hwpt,
> +			      struct protection_domain *pdom,
> +			      struct protection_domain *ppdom,
> +			      struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +
> +	pdev = to_pci_dev(dev);
> +	if (!pdev)
> +		return -EINVAL;
> +
> +	/* Note: Currently only support GCR3TRPMode with nested translation */
> +	if (!check_feature2(FEATURE_GCR3TRPMODE))
> +		return -EOPNOTSUPP;
> +
> +	pdom->parent = ppdom;
> +	pdom->guest_domain_id = hwpt->gdom_id;
> +	pdom->guest_paging_mode = hwpt->flags.guest_paging_mode;
> +
> +	dev_data->gcr3_info.trp_gpa = hwpt->gcr3;
> +	dev_data->gcr3_info.glx = hwpt->flags.glx;
> +	dev_data->gcr3_info.giov = hwpt->flags.giov;

Here again, this is just data copied from the vDTE to the pDTE - the
guest's gcr3 related parameters are just bits being flowed through

And as before "alloc" shouldn't touch anything outside the
iommu_domain being allocated, touching dev_data here is completely
wrong.

Jason

