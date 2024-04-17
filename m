Return-Path: <linux-kernel+bounces-148473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC618A8316
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4001F249A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126A213D24C;
	Wed, 17 Apr 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RdXC6o1D"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D113CF87;
	Wed, 17 Apr 2024 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356692; cv=fail; b=m7Lgsd0oHS6WuBmznNjyRtECML/Itx3PGZqpvVZUD+sYpYYO4zwezXNymTGyDAzmwVtyThnbUTHS01iDtdRzL1lLePnGpgPb3zT1EGo+UQzpnQayETmx957LxNy8I+6rNGy9XtIwe9eArEdj1Z8zHnhs+3D0o2FtLI36DNeKbRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356692; c=relaxed/simple;
	bh=gowoofUGOd/RdEgpy1PBjmfcNehglOcOZnFjwAc8QX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q0TZ0DLRJ8X7tNdsgxY3rmrRvBBObJNpIsGLJBo4BpXLj7qYcTtXEmDO/KWGvGed1w9sHwWcVCMmkUk7CG+W9RT5eSM+MzgcUne/6+uG0dyY+WOJj9ZGhmBTxf8l+dCh8pIMxKds/iydhEVGoEWZooCWZvQJrBV8x5RqBPlAf/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RdXC6o1D; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLxkvL/k8rNmCwAIvJcUi5jVb3Wj1jxVPH3nh1SMhuKg8noVMQUGAsKVrfLnAzUq9iOC6Fe2V1QZ08yxtZ17jw4nA0k/lPDjvyvWzCuoMKodARvVOY8XDN/B6gKGxgFxROtChQTf0owlEwxIYIR7yLPfMIlnL66fB2ZkWmDQMlXpwgn+zVg1g+Ww5AOu0jrrnbLDlSmvByRrCmn0hwbiZmbyeaurnl4D4fhWOwPur2ChY/qNX1qeMSvpHCZM+VvW7c/es6DvogV4mY9mfsrSa/LBGcBbHk741h553idzOt03KfrH5R86LZ/JLWMGk87tGi9htm3sCZpeSluMFnklCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epML94k/deH4YjtzUV1zs8gm7UpOHZW+3Wo+zVBr3xQ=;
 b=nokz23g9xXkQ9i3h05o+IxJ3/kYRRsrJ9bBM8t+gVwIPhN+lG099F6Q7ic3bJX3pHGQlLDxDazh3a32Cs4k9isPE8d4yua7/ArPEk5x4nNdlJolQYBLvFXd/IqkGonlZ+suPvPIi5tLMuo+Y9qKXbDD4BrRkNT/v/cs7fifluJUswUoCZYSYp9W/mcD1lzUPB7lNYrlCN7vizn/KTVxAMN+ZMT4KPfUDjZUe09Qc8IUAYt6GNTfZaje+7ycVrzFv8hs9tQyUZH55SUepA4JoYwJH1a7a6ujnGvExNRIOgZ2uG97GGQq2yabJRdDAZ/crbaLJCdrsQFWtZuYM0pXeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epML94k/deH4YjtzUV1zs8gm7UpOHZW+3Wo+zVBr3xQ=;
 b=RdXC6o1D5RWkXQzzmwN3wIB+3mbf6UWSsTdjKpgE6BsnPoT6sqsNTOviHdriiSVXg6HbBAVHbtQiSpBAnI/gdN9ANNfPKX9yg64ltISnlSvouUGjMzJZG4MONm1AUmRwcLjPvWz6kUO/0v/VmMJDpZqGxuGL756XT1qmpjWtTqRB4vWYiBS9rj+ySniR8EOhWtvFOr3ExQlNzpm3CICCkZ6StRkSxfJg8NBYUO7PT6BhOr9n/gLs4E1HXJH1Q431Ady8B4pAex/9drYQPX7Ga8FB36cgzRpA5pby3qHTMgnv+HHWZQlZtfUzRRs/Q07wK4fum8SgvrpcFrkRiUFcvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 17 Apr
 2024 12:24:47 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 12:24:47 +0000
Date: Wed, 17 Apr 2024 09:24:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH v5 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Message-ID: <20240417122445.GO3637727@nvidia.com>
References: <cover.1712977210.git.nicolinc@nvidia.com>
 <20240415171426.GF3637727@nvidia.com>
 <f92efdb774cc4cd48a59495e7cb69c27@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f92efdb774cc4cd48a59495e7cb69c27@huawei.com>
X-ClientProxiedBy: SA0PR11CA0193.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c3b894-a32e-4646-fb19-08dc5ed95ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EgqQ32nHHA9wxFwX6h2tFqZctNMSwmbhe2vBe30oBq0bED7NECyBcorM/JYCILnEUTvT/pDRDlVlZow++7nIp+7xo6XbS4SeaidyHuNANdU3glqnlQgJDImnLXSRkICRLA+hZhiGamrBABTrmH/ERMtWMXc7r8qZi+Y8GgZHdLG/y7i4yUkYAIFM6Zj0kzOAnB3/KxqGtb9y6oJnXnhYfpagEkytbuvYohyGLiG0Tr40UBC5wuptRJh70uYGlN1887+Li07zqYYJZSm8aWGDaIPzVFm+jEqqtu/6O3Srfki9Yen2+a87/YJJimQLyRTy9vcLeb7g6M5lM7JuEbOW/SdMQ3nF2J/FiUnYUnbYUE8iUZMCk+DZjVjrbrb7OS5EKxnf9mY6dFhC27qTO1QyL6U/drzv9nyyI3QNEduu0Qk3CTXAnR52QJOzxDnCMz0Ip64xx5kv/3tADJTsHi162e/7uQxvLAVfBLHSZm5KPf4MfTvQ8Lm0VPb4C3Mmg16FKB7Wzpv8aqId7okR+JFwTZmCMlxuazyfFbwQR7xsoKg78BUNDNZY1u0dlVtLl9eBs7BeAQGpcVWv33SENDuDoj+nBw5zrkygV6osgZ/KfcPqv7FE+iZFzW61IYr9aQP4GoDcKEuWGrY6R+0JdUuyLsN/LxpA5Ix6ftGPf8TDSNk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aDguiBuE8TDxNbpUGiQ5UGi2asOe6JEypJwciiYTFgWywpyRHm5DE5+WXdrw?=
 =?us-ascii?Q?Pfr5JqmtzYb1Ehseh1lIpRFkEeKGyOl8zoP51YNbxH2vdtkUnMA+y4HRw+Dr?=
 =?us-ascii?Q?UxOzAcna+N7ai7oKV0W07Rvmra8z6b0V/H6+6tEViO0lsxv//I/5nnnRvyCN?=
 =?us-ascii?Q?5l+fikvpN+oaDhchC8Ar9VD6Bh4SKTb956ihVfEbeUvkZsmx5QgYTJSFeKbh?=
 =?us-ascii?Q?NV+y6EclTDkMzpLp6XT97SPAzeBG7XBsCBnDqOmdrV6XptKj7AnzUZXyZ603?=
 =?us-ascii?Q?IOfjmEP4372PwpQqGw0HKNzTyruAsS6/tQm5XyxwW1I76zVt6PG8/NqqLpug?=
 =?us-ascii?Q?uo1ISNFacHDIviTNJAjF43ibSXGy31bcXyvt2PBBy5SllnZelOLOfHAMfjqR?=
 =?us-ascii?Q?PtBhvX75MKam8RQFNO6snTAgRmRJU3xsS1yALJTnVTZdJJSZ70IirE5aUsfO?=
 =?us-ascii?Q?oSYOvsUhR5T81FBCASOMcjiN2gKO1KOad0yt8EOD850Urp0bC8/DQh9STx6x?=
 =?us-ascii?Q?jP+iNcDmV4GvcLEB086H5cqPyzgQJEZaUpKx5Q60R8IRgLhrOCgHS8zATbYq?=
 =?us-ascii?Q?KuntqRiB9F+uRNBkCDNaGEDKvFtyy1qQ9sAJ7bKXlE8yUmM/lJv9U4Y0P0lV?=
 =?us-ascii?Q?fFLRTNGm6uc+v/phMi7FOgEtPqSahUkFRTual9bWAbeSkWHFLg41ahrrl82j?=
 =?us-ascii?Q?gMe+SqFTV/GooQLzm5WQV9jfCCfYsMTds5rQ+wwlJeO2OnT5p+SkNsDqDAGB?=
 =?us-ascii?Q?0Nqrjjfm3CmJeBR5FQC4TK+ipEJPdMGehe2bZPpv7B2IzYeTaOQeNiEWQQuG?=
 =?us-ascii?Q?rMYzgI2tIB4g3hPfwhvrpem5ys4D9flpuCD8xY/tgsZIStqU/FSEUsS+j5VL?=
 =?us-ascii?Q?Gf2WFjzIrvqAUBSGC7/G4cQ/3PocpfXIm4iYz3xHaCo+LnCFdcXZTpgh0C33?=
 =?us-ascii?Q?yJZgQgRw28yV2Eljbmq72y3qdX4cH0Lp2VhwzfihvOSQkrHIKHRQE6sm9773?=
 =?us-ascii?Q?/8AtO+hPAqMkJhwn8zdKYOkspxqR9QNp4AghXyJQAq3bMwlT2sjhY+1SxBpp?=
 =?us-ascii?Q?saaJ3jiWf5R0omOuYpNFvw7t2rk+Okpeqk0J17T9bZqC4xRK3ljooGal4y7Z?=
 =?us-ascii?Q?RqcoAyMA3+XICCI6XPipSdi4GVUECLeva5O/nBOJb4Owg0eRCi2mQ40J6PMO?=
 =?us-ascii?Q?dhhFMi/ouyJuE0OEnSZA8IgdJCTHjB0+Qq0FzEaBjmCcx7bFIxfITcNc0knD?=
 =?us-ascii?Q?/LHwyCmBbrAWwSpIfDaNSBIEQRpcLwnrAr7GkOuDZ2qzL+KsaqwhzFR62INh?=
 =?us-ascii?Q?hOmGlOMNv4X8W6hIJMJm3mZzIhslTLanEfvpl+enREdtd6LmrJapZ5682cXM?=
 =?us-ascii?Q?aVM+6EaaKQnaX9rlXiyS6ZI3NlDwQpY8PR2XPuqSvUfts6W5rISGBQ83Aq7h?=
 =?us-ascii?Q?yM9SDBi+ZAUtywz8zm7Km5MW/gUorHYup4HY2BzvSvYD0e+uHhOmNuSqjN8A?=
 =?us-ascii?Q?51KGM38vS9/G2p4klO0J2Do8HGDQpZr+iAkHfgCIgBOQlJBltljy7mxc1YKF?=
 =?us-ascii?Q?4fTUuW+ROCb9Ja6iwWpDpWSrZrnSn2v/sL6r11dq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c3b894-a32e-4646-fb19-08dc5ed95ee2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 12:24:47.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uoK/dvc/O6PE2Ao13q+nxTR/d45Knuer2IANvx7ibsyg4Evb+tSXrET+2bWUP1V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641

On Wed, Apr 17, 2024 at 08:01:10AM +0000, Shameerali Kolothum Thodi wrote:
> We do have plans to revive the SMMUv3 ECMDQ series posted a while back[0]
> and looking at this series, I am just wondering whether it makes sense to have
> a similar one with ECMDQ as well?  I see that the NVIDIA VCMDQ has a special bit 
> to restrict the commands that can be issued from user space. If we end up assigning
> a ECMDQ to user space, is there any potential risk in doing so?

I think there is some risk/trouble, ECMDQ needs some enhancement
before it can be really safe to use from less privileged software, and
it wasn't designed to have an isolated doorbell page either.

> Not clear to me what are the major concerns here and maybe we can come up with 
> something to address that in kernel.

I haven't looked deeply but my impression has been the ECMDQ is not
workable to support virtualization. At a minimum it has no way to
constrain the command flow to a VMID and to do VSID -> PSID
translation.

I suggest you talk directly to ARM on this if you are interested in
this.

Jason

