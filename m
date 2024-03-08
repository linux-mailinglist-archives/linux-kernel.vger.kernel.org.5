Return-Path: <linux-kernel+bounces-97121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 195338765C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDA11C217A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2C338389;
	Fri,  8 Mar 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QUGvedMg"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ACF38387
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906262; cv=fail; b=DYUmqzLpTPeGxng7xxK6zoF8mcjh1IaMuG1I6v1fjVoYPZ/jbYg/BrAv/CMFRkpSkAoYPOuJOar01GnGu5mh0Tm/M7RYkizH7Ieu6V5z5IExWRmVP7ah18PE5ibPduI44F+3LZOv7m0H9mmmGwqvBCWZGqETFOqO5gr4VPc5rJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906262; c=relaxed/simple;
	bh=QivsHE32x4PIKzDE65l68/r1Rf86/Wt1wgbkI0D7wn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BFt5FtsA+WYR/d8FnZsyGoK8FW+QcL3WfqpLPU2nfv90OFFW6+4AhwHjS5ptIpYeqXCe81XnP5rN1+Rpv6pOABOBJLW2tTadMnL9V/nS6o4dCLywFXI2OoPKIzzv8Mg85VM9OEDV/EELk50jXI8Kqu1IwmrQDAbz28fCtfVsfyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QUGvedMg; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiDKX8rzaZMFp41522ZH2VkxkjZL6K43daixxujC05R4QvDDRPDZ+5Z/NPFzHfjdO41G9cN56UL6tLsMYudYHKcD8IpqBZkP75dlWt6uQ0oioqGzWnSK1X7oSiWWjSafxN8pUfJEVsG2wtkIffUDHjjKE6doAXI2wSh0foXp9N16xSuJcr0ATTjOFJd4fKUCBIcVLdWvg6pIs1P+oL3VEEP2sEl+ooNHRHeU30W5/mg49Kxr0DCujrsq8eApSiW4Uwb/q1XETrrJ9v17H35/ZMndhW7LFgVhCzA2DTG/TJEdrKC8bBwuY2OrXIeOSo5i03ZGJbICsnHF3lOJkLMMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ7pyd33lsOQ2eibcNXmY5gu4raeqvDIDclPJwWH6p4=;
 b=SmoFoH+vSPFeaLYll904B1jhjVljqbzi52635+H8JnEQIw9f7sn1Rcf/HHJdmvizXw1BW1IU8Q5ckoV5inNM6qX+b5qW4teWRBM00logtdJfiR5PFfsCgN7KFHWdPFfUTAbHbqIHBFNbKCG9WNKS1rN6fkHVNg5oYHOrwpM9688LcE5cEULK1ug9Y6kBmflJNaiWXCtgwE5rtCU+rAzMUcixCSmI1bL3hdPKKK/2tcN1BQOaxY2InMeca6zHu8bALTeZvJl69AfHUTnqX6DIHv+WGaf2Gxep9QtBhC4aAr7T4WQ4wkSHBc9CtYqrLKMStBSRtPS/H7vY2v8LYJhwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ7pyd33lsOQ2eibcNXmY5gu4raeqvDIDclPJwWH6p4=;
 b=QUGvedMg8cuRAPTpBvfSig+lSoot5F2SR15+9uYKHN0TM2UujQjrpjSCLHpttsd8VkVbF+NxttcKDx5gYKS+MsI5Bmv/ND8wz6movL56k2z15y7yoXu8iGN3pUBIF/Vj9x8tVv5ozAsNDfA7+PlD0OXA2fDYwdcQh8J2+l+04/920nSbDi7dA7hXldMsXFn64SD0C8tNtKMALP9IHesEukn1W82u47zV30I6SKzf74QzIeoEPC5DCP4drGF0gBqX7RbZoK2DvBF1mFrdhQIS7F8pahYc1zK6isK8tNANDINgvJ9mKGlpfy18o/QZDMleItK0fH2c7F+oPazzwAYQLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 13:57:37 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 13:57:37 +0000
Date: Fri, 8 Mar 2024 09:57:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	eric.auger@redhat.com, vasant.hegde@amd.com, jon.grimm@amd.com,
	santosh.shukla@amd.com, Dhaval.Giani@amd.com, pandoh@google.com,
	loganodell@google.com
Subject: Re: [RFCv2 PATCH 4/7] iommu/amd: Add support for hw_info for iommu
 capability query
Message-ID: <20240308135735.GL9179@nvidia.com>
References: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
 <20240112000646.98001-5-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112000646.98001-5-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: SA1PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::6) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 96813ea3-b415-443d-c3d0-08dc3f77b622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+3Ua9zbZW2+MJ/VPEgrHif5qxwIOhRj/0x8nn8EUmuHTnrsYWrEPoz3pvqzHGMtbxOL/dsLriIy6wsZhYBedXrFuUtIfkJJvoRf+YNRRuYqDGuz+pCDXyF7nEjgyLg03cxd65gPzd1g72nNH9O2GM5g9oUBojWUCryo0GfdHSvNf4v1Qyit1I65JiY365o811XKBiA7SX/uVQMBU10qLVpwCdv/qhaWCIRlEiU31pQQHzNf+vylqXI42wM9CS9vDDxFLTXbO7PB9DJ2YpmsQuAm8gNf60RP7vJB46xHh0Cu1MKrep9YJGWTpFFF4GUM/bQudtbNCH3KBXyIrYIt37RTlA0pGoMvGpq0iriRZR7+RaTMpk5TMgotyMOzgE0YRMA0dRJcmCFQRMTqvHWDhL502uD9Rzc9fKYcbISeCmcfqMFa2hsg6MU4Y4mZ9AsfnWemH0WTiBwfJbrfrrLSW6w3CN8/lfTxrSRCxo1G5GDJluftqRW6bExhK6ZsAJBwpPVtAwpEpDxV23iuP6kyHU5mjmmJOKgtySme5L7XAdDtB6OgrcXd3C7jUYKLQDcc0eK2JbrvPb62hbDY3HmXnRSxLjgqCqPgfbUhmcQQ1w2aRfObMrqGFmE+AJmMSBvxKZlMaY2aNAJa19lLdG0ZKQ88dNfJWwDqm0p8ftE6jOEg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UGOhpL3N0ZNsLDI3CdyiuTYR+Aydhz4DrZZ5Wmbiu98PoERYvt21cEp5Bxrc?=
 =?us-ascii?Q?BtdBgKl5tZLLMi+A8OUcpOgpjZSHahoT1Txs9YiDlJ2Nr6j6MYjAZJEZVEOX?=
 =?us-ascii?Q?NDDFRhaAb5mFX4TzeTwlthrcaSQSgZgCCWg7BQ4ISiphDEewSMSqA2w/hOwW?=
 =?us-ascii?Q?ul8xXNKdwn8iC0nwsaIj94tANUP4jSR3s245Y/9ZKpfP/r9ONMXO8fsjsras?=
 =?us-ascii?Q?LdIadcafVDhShkHOJOeOmyn0jmo65ZK+o3dsuSrLcSCtWVA/bzISZ519kCMf?=
 =?us-ascii?Q?hOuvaytEHkCNW9JPzz2khpxoLUDLK1t8c9i2elsoMnhrYWYvCuzWWi002nAI?=
 =?us-ascii?Q?f2EDvXNrW/Nh9mBlguBOSc8I+qiH9u2qZEzW6W50JGojHhwtGYgWgyDgATQt?=
 =?us-ascii?Q?kFxPEqLbF4D32CObliEp9rt04mXiK3H1pxd62kuqW1PvRQhpplXGN5/y4kUo?=
 =?us-ascii?Q?9fLueglCOWF3/7BVigrVHr+TlybI6eWiL5NOMhwlYEUvBzH4ZneQ8ADkRqda?=
 =?us-ascii?Q?v8Ef/fhNLJxpJqhIWxgaYrZKAfHXmSJ9zG5NheztPKIYfIOsHKKpEBZttZfg?=
 =?us-ascii?Q?c08NIugtszasO1IN0Jx2zV3zE0JpzKz/wq9AcguWTvFJx7QFw+ThxdTE7A0d?=
 =?us-ascii?Q?b6XVrLjrb6BeNIpgBaQlGMWsVOP3W3h0M9h5UXVlbZS26K7gbxHofKMGKYIj?=
 =?us-ascii?Q?guKpiZ4sv2/jhv7G/fprSb8koOBNt8rBQOdNaeyptOiWqAiRDETlQ/qjTKDS?=
 =?us-ascii?Q?HC6zOZafrk5/2WQuyNI6bRbJR7m7q7DGKsjcLo5xLsfWk+AjfNmR9IOKUCMg?=
 =?us-ascii?Q?HV8s7WJvCG9AMzIdV2KnwpGczMw3JIsCwnfbE0JNRAIJCAGxS+sT12m2MOUM?=
 =?us-ascii?Q?zmUiRdMEQu+yIwLl0gkiDMwzAEvl8qfZIOMgaWVIlykIhmXRz7mt/j6N/MUs?=
 =?us-ascii?Q?9Nnd/hEOzs3NEbmdVh0601s4t2ICboLHWYLaadkrcwfMLuYS9r6F3xQ3KP7b?=
 =?us-ascii?Q?31eYXnQ61aPbAc+p9zOtGQwjLItS4Js8AoYcjrOa9FtjemUltUQdIE+AuwFf?=
 =?us-ascii?Q?MfnA64d8+CH+se/L0pOP1+69TNrEmB6cRdCOQkKuSS5bYst9lfDir6IHV6la?=
 =?us-ascii?Q?EwgmrX+2Htgy9bctzaM2HDEqUI1/3CzoQtWcU8PVeuLPLZk1EvNA9ARhJRjq?=
 =?us-ascii?Q?N7RE6j+vk4I6XFoTz/QvRedr4KkUNUW9nl44gIbWg7KkAtjYr6Jkfitl6o2N?=
 =?us-ascii?Q?hz/YcJHaM1psqOnpWwOPiK1gkUmHH7zmImC2PNB1ERYXoYG42ILpotu+H6gZ?=
 =?us-ascii?Q?Zjb7K0eEfn41vnNNOuvYul80Nl8lsXH5PwXPTzpoRULkSi628LGItCnRtvWE?=
 =?us-ascii?Q?e/jsq9Noae1uyAxNq86w/udRmdVVqSiAV4a3qLW/V55VSJgRQ24v2DDL/fYq?=
 =?us-ascii?Q?1WmKCmep3hfAwCsOqLefiHMH3JlY+9zcHpVfNOay9+zwfQOOSd4xUEHkpLd4?=
 =?us-ascii?Q?mFHsuCe6kk/l8TogZqT7WdfB9YnG1huyf0Pv7BQ4ubDRBiSvIMcFA8lwhirI?=
 =?us-ascii?Q?/rX+Yx9fZ1ItNP9gUEg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96813ea3-b415-443d-c3d0-08dc3f77b622
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:57:37.0086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4RFTjMM7Mo5WuL61jAJubZHb7C+LIe/ciyGJd7/baTWuevKfSWSs8K3yfqQLQIB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

On Thu, Jan 11, 2024 at 06:06:43PM -0600, Suravee Suthikulpanit wrote:

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 71099e5fbaee..134f4af921dc 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2849,8 +2849,44 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
>  	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
>  };
>  
> +void amd_iommu_build_efr(u64 *efr, u64 *efr2)
> +{
> +	/* Build the EFR against the current hardware capabilities */
> +	if (efr) {
> +		*efr = 0ULL;
> +		*efr |= (amd_iommu_efr & FEATURE_GT);
> +		*efr |= (amd_iommu_efr & FEATURE_GIOSUP);
> +		*efr |= (amd_iommu_efr & FEATURE_PPR);
> +		*efr |= (amd_iommu_efr & FEATURE_GATS_MASK);
> +		*efr |= (amd_iommu_efr & FEATURE_GLX_MASK);
> +		*efr |= (amd_iommu_efr & FEATURE_PASMAX_MASK);
> +		pr_debug("%s: efr=%#llx\n", __func__, *efr);
> +	}

Why scrub it like this in the kernel?

The userspace has to scrub it anyhow to be compatible with future
kernels.

Is there a reason not to just forward the two efr registers directly?

Jason

