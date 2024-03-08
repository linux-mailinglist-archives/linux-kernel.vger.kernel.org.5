Return-Path: <linux-kernel+bounces-97124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401918765CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6A02822F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542463FB8D;
	Fri,  8 Mar 2024 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jl2Cc8pv"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDD73D3B9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906346; cv=fail; b=Yr8xJg+o8VIWVSKAFCXUjwxPk7aIvrwPufvWHHkGLE4Ka1sTdvzjFZaxkDs21ff6UOFC4/1FQy2gO0Vovn3Mf2nUqUuJvSx5nFJDIXkxmQJt5IXerqvZQ+0FTYWb3mzZZ3MfssmLCkLiZiTKpfx3wiOv+DxajZMceurm7wulKNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906346; c=relaxed/simple;
	bh=eZtooRgVWVgZ2MK/tkKqQs1NyOqeuRr/1rYMw/sUbRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vay0PL4nLdAHqvYdSo9a1rDe3f74lVazw1iNGXLDKeOJh2S8s4o1u/GdGOLa/D1/wpacC9OsUWrln+Lb5+jbIarO1vF2nrVhARautjBHlSEypia9YGnXzifVycnH46uiNgSoIkEzSsFqXL0TVFaC2/rTK/TKuVS01EKiX6GSXsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jl2Cc8pv; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFk/v+QQh3Oh2WTvMqmAGx8Jldl1qpBcXqZtMuxhUs9uo6xmxPWOHUrk02FxXf9opWws3wTQ5TjkG3wNDua/OSviK7aA6uAmrCF/k0e5RKVNRocbUHZ+nEZzlVr3DvlYf28FNu6SZD40kn1MYFYxWGSfsTx+CBkhSe9nv0jJQowVVNKpCmDvMNcQMomm+zCn7Hf3wQc1387BevwK6LFMNPWf+DAr+xt8fqrNqdlj6Cl6n9G4YtS2BVtwBm0+OW81NW2btPd8PZ71LoG13pNUT3ZhUDalOGw7GeBQzkSCkW26dgTVdRtEbgTC78OMI8kCglAdp6EbZVvtHCvMYf4Atg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZEm1DR5gqtVSKh4uOKLZI6+qo8J8I9u4ky9Q07SAjU=;
 b=DrWPftkVbRLX4RSJFvQQLVcYXxAdBGKJ+gZnBKohv3SJykMMhEZlPFCdzBm+XtrX+k4UrvMFMGeU+DQmL6akOy8XiZsA0/vvzERH4KXweoxhmaciqpZQ8/0Fb5Fma1zQnYulAhQT1OrEZBH4FNpUSl3BjeY4j67vi7lVMVZRlzfW6PPUtKtMQPb6jfClQ5o764SKgwhV5T0rA4mAmyf4YFNQBev9A4xMB1E4hIn+ReBD68zNUpe1HI1oeawYXrn3O2yohA1kFhGeeJRphBIaurVoROYTYzsN1DtrRXmpmMP2gMLOvjci4B0EJY9zEwcOxXj27WS5dFPVu8w+AFoDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZEm1DR5gqtVSKh4uOKLZI6+qo8J8I9u4ky9Q07SAjU=;
 b=jl2Cc8pvbSMhkFrSKPD9ARNqtZCUXncDmMzdFBFSKsf2fKpeOiPcO4ZkEkM3c4malZzFArH5Okvg3BuDFCzUgwQvXvC5OqwQRvofMu23zCtifcSYBZMIXcWWba12bzP3uv4FYV+GanRH0Jmt4eRY42+R7EsQVDCsQI8YGye4ELMUylazCbkrF75jH1ei1x98q+KewWOQzxPLuTdddR18oZiLjTUTdR1FJ7KM5cyrOCxXFfFshakA4wPLb7527q8PIP8062DMSFr+KrQyMO4C8903MypyUvpnzwhTwkPOCMZcrZXdcpLNHROigypWG0vlebc1Txz0w95jZpy3HXqgqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 13:59:01 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 13:59:01 +0000
Date: Fri, 8 Mar 2024 09:58:59 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	eric.auger@redhat.com, vasant.hegde@amd.com, jon.grimm@amd.com,
	santosh.shukla@amd.com, Dhaval.Giani@amd.com, pandoh@google.com,
	loganodell@google.com
Subject: Re: [RFCv2 PATCH 5/7] iommufd: Introduce data struct for AMD nested
 domain allocation
Message-ID: <20240308135859.GM9179@nvidia.com>
References: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
 <20240112000646.98001-6-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112000646.98001-6-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: DM6PR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:5:54::17) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 4260134a-71ea-485f-607c-08dc3f77e87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UlfglqRN8TsYnm9KEwdiQmefn3BlEbc35xNRku97Tp2UzpUhI/bnS1q1rFeWY9Kb4gS5vMw9p0A7jFpao4WowwQiZincCfXbFlhID2d0y9BjiORGh9IqrfiR9cDqNiMjCdikLNcpheZBxCey6ATgZhw5EDovMOyZ2UY+wU3+od96DtwRKdueXHIFze06bhG8zGyNrQZRhG6tkr/2p1Q+t3/8/hPAKGaH1Zdi+0AiW1Wl7pdsgGE2gbpI5DO7kx4fCXhzMnZeoWbhms4FiEYLfK/6vJ6WmIITeR9ZiV9HlOdNiAE9LbS5XVDGx0VwDJf39A1j8PZhlWaw6yJziFIEZ+3jTDPB7La7qt+pHbhSRxHA5LQasf/Rhg51oKbv45mpvSDbYkVDoUQ+HfTSkVMzWHO94cha4RdRmocpD2wsMQi0+OIyOQf637kIRFcVDcL9YQYHISrZ6f+qQyXHNfbZc1F5XD3hHYYbd8p09bGPhksLudmSxZ/CHZMpeUO0my2Q3onmrZ6hh6IoFmvK/U82NiDQU9u3qYvqUoqf94zL4VQXbB0bX3Vncj7uni5bP05eHXfwhHyizUlJ4K2HoEzgchB6eZp8wY7UDoeQ7/hri0vL/qRgnSQFmCDGpXXWz0aW3REXJzhyKnPk+y2FYhszKBpmetG47MVistKr/0oc9kw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L7NKDGUlDAJLRIK9+zK1pmf7qIqUJRavYhw+QPCco35s1oR5r4WImQzdv8jC?=
 =?us-ascii?Q?LF4BFcne9xmcZcbNktyZvFCasao5O9DiymcQz//H0RoJVPtPvVDzS/4OVz1J?=
 =?us-ascii?Q?73Oq4XlQqmme44alkeiI7lwldmYspoAzr6XK6GXAq7akUnxKvB+vXTxGKK2P?=
 =?us-ascii?Q?8/WR19HcmzwLYppGF6+21td5a4GItAI6uw9ZAGhytPGC9SuPM+5M/QPdADt/?=
 =?us-ascii?Q?xaFyHUO8gZ9qKtA3LSG/ixbkCv3ozF96o75znHjeG6LYYgeZVj5hRXChE1eY?=
 =?us-ascii?Q?BOfDjjOnWXgDP8F53bt6wJuNsENJBOAsNtMmKtnALs4luhS4R0IDcGyElUh4?=
 =?us-ascii?Q?2+wOjrN58S7GpBhW5EIxbSsBoTyfs3NKF8ze8Lx3GCpoPN0iLRI6DnpyoocX?=
 =?us-ascii?Q?kDx9LjNPkYY8dWxGSQ+STzn/Jy+sRyGZ0fo3oSXnZ24uZkgieKAREW/NaEP2?=
 =?us-ascii?Q?3e4xmagc8TVd4KmA7fQiWHzKYNtPd4nF9nHF/uSYrx4NF2ZN2V5ubi2lTZt6?=
 =?us-ascii?Q?6qD4rZdPaCWRdgVkW7d0yJD5Y7J4D6jU7eJV/vPS/8gYeP0lnNHwRvAAYxQh?=
 =?us-ascii?Q?nfrHzXsVeJ19ykOGxUISA49s2W1c8jLfh0nH70tfYIrxPvgi8dqVPvwPXCSd?=
 =?us-ascii?Q?U+aDKTLLC+bgmQoF4acVGLqd2EiDWQHnWKmSvtUGOXmBCJ8bHDP0q28d6+8B?=
 =?us-ascii?Q?c7nzobrGC9KFDzocA7Xsfue/jv844vzvVMCw8ptwcQVoNIFo2U4W7BGdnbGM?=
 =?us-ascii?Q?JtbhEbCXMdUvrH56zSBeiitl7oK89liQhMvfu3311JeYyXLqZ46CjTS7gL7v?=
 =?us-ascii?Q?gZR+YeEaSdc4PFaf4rrLHJz0LzI7x1vRwqMugmAJlKDEEwBMsX6e1DGQpg6U?=
 =?us-ascii?Q?wQbpLgziWFeACwY+QgIt2NyuLDoosv5FMIe50QKIyfJO1NWKum5RDyemKxRQ?=
 =?us-ascii?Q?4QoTZUVLWWyrFpX/tnd2SEaoIvBREqBnRC334OPohpBC3McJuBtTTPqxeGps?=
 =?us-ascii?Q?e2TAR/rRjUMTq//Yg/+IWKL4MaIR6XW8WxV9dJPDX7sFerCfkwci7DtE/aFZ?=
 =?us-ascii?Q?QayLDr+iXTMHW6NH3/VFQEptvlWxL6FXOswC5JU0KECcLqeSOYdnKdubdgz6?=
 =?us-ascii?Q?HoyUenc2H8NlgbxtzWcsX57TRMJxFC5erS6YcY7Wfz5EGlEEoG1HcOlS3b20?=
 =?us-ascii?Q?CRCBWGJG4N8nT4YNuIZM4oF6T57WhitcLKvoDY03aWhaR32zSUE+E3vJXGW9?=
 =?us-ascii?Q?ZgiE483owepcft5eXzxjWP9HSZkRogbRQUcao1EX8aQbtKIL1eRfequ9xhjV?=
 =?us-ascii?Q?fJrt1Qpsacz1I9J+kfiZnau9WBknjZUXzpRrDGD/HsGRg/CdUDwQILRsuTDU?=
 =?us-ascii?Q?btPUOcsjSWq+kfYwgf6STNMBiAYFhhiBxYIEx6rPxD/VWEd4d6EeRCu8jbx7?=
 =?us-ascii?Q?P8/v/4LSr8uKLdKPRPhykJ+vNS6cllYrcw1ur3CAtjczVHz6TeS/rFXhjKU/?=
 =?us-ascii?Q?Ah4AYQ351jtu/4eJyyF839RyZaoZ0s61n5DB1D09GUSKo7hupuqK8y2yLSBV?=
 =?us-ascii?Q?pJi4hKjOQ+lYaZLrmUw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4260134a-71ea-485f-607c-08dc3f77e87d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:59:01.5055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvdSyKlxqwyw+pO2G2gpSbeB7iyBL0RpqUk+QefzdL32xM3wVZX8pAhPqGBE6r0Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566

On Thu, Jan 11, 2024 at 06:06:44PM -0600, Suravee Suthikulpanit wrote:
> Introduce IOMMU_HWPT_DATA_AMD_V2 data type for AMD IOMMU v2 page table,
> which is used for stage-1 in nested translation. The data structure
> contains information necessary for setting up the AMD HW-vIOMMU support.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  include/uapi/linux/iommufd.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 9901b9f4abe2..b28ec5947571 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -389,14 +389,39 @@ struct iommu_hwpt_vtd_s1 {
>  	__u32 __reserved;
>  };
>  
> +/**
> + * struct iommu_hwpt_amd_v2 - AMD IOMMU specific user-managed
> + *                            v2 I/O page table data
> + * @gcr3: GCR3 guest physical ddress
> + * @flags.glx: GCR3 table levels
> + * @flags.giov: GIOV mode
> + * @flags.guest_paging_mode: Guest v2 page table paging mode
> + * @flags.reserved : Must be 0
> + * @gdom_id: Guest domain ID
> + * @__reserved: Must be 0
> + */
> +struct iommu_hwpt_amd_v2 {
> +	__aligned_u64 gcr3;
> +	struct {
> +		__aligned_u64 glx  : 1,
> +			      giov : 1,
> +			      guest_paging_mode : 2,
> +			      reserved : 60;
> +	} flags;

IIRC you should not put bitfileds in UAPI headers..

I suggest this should just be something like:

__aligned_u64 dte[3];

And you actually just copy bits directly from the vDTE to the pDTE.

Jason

