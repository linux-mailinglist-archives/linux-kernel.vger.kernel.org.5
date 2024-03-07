Return-Path: <linux-kernel+bounces-96162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD168757F1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBCF281CDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A6513848A;
	Thu,  7 Mar 2024 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qhv3wS7r"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548D1DA2F;
	Thu,  7 Mar 2024 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842115; cv=fail; b=UMrt2vOGbuT66XS8hHfZOesB2F7WrNJDPJsIzZxH8HFsugIsPnBAMHuKy4Oze5D0r9Rr/I7aRZeEVt7/th2oq1CzjkUmoBwZXBzpzDa/L/sSNbafP7VhiDYkBDOeDful9xgnDWVIc1qUjYpibCArscmOFE/dqIgZXV6rQQcmx3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842115; c=relaxed/simple;
	bh=PrkvlCk5ml2tArIAivgu7axhHg9/DxnfeNSbmRHapvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=saF7ZNGyP7Ko44E8acMNV6qcqi49yCmp/rJ+S5c/0VoryzA91VOA5Re04AfcMN2IU/z7/zgM92CfM/7HDrwIuYRqCUl6sk7ehCchV0IfmrfCewxAlEUh34dhv9kfqpSSWSVhs///ZGEXFaK+RM3Dg0OBixH+XlDGUUXsHiNuSBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qhv3wS7r; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ac8Fs6Hw4LimRkPHp/mMv43mhCPAt3gJVZCmHa/9037yLenYx2mz7xlubcY1xiUIsX++jOMANAcUepuBA6JXelYNMAyhi2jvHYBBxHZvyow5uVnkcV+GofzDnzLau0kr0n4ORDGDrKChs+6Z9e7luJQqDg0rLcQ071uF5UNry3L0Tare/nn6vB6Z+yIuvMus8HF731NVSujlsr85lOFX87w04pzCETsVd+dzKo+VNDbjj90E7VR+DTTmEyZxl6FoMbLnBKrOReLm9EEIlRGkIGSBCAJEnnanwJ8IlHcnYWR2dIeE9MWWc1xw6IDpfNeocjkqhTkNPOLB/x8D+HHVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8wQUDTOYSJlMARjTgmzAk5fpDYwgSG+FjZHuf2weMY=;
 b=SAPW3eCYJFCoctUs5cM/z80E1imm4P4wWb5mqAq0XdJfjELS7Nim6g+EzmUz8kq+tPn0TLfmvfOyK12nZOkz/qKizHciDlkUEBXQOfBZZQ9chjmEXqtL+mvGunAbvWA+RieGBp8b8Mva+rxNpoE8woMO4AN/pZ6MK32wTtW4Mn9E66UmA+CIKs3Ulq9pUkPcH7wSBtc5FwKqw2YrmxY1KMkHM0MDQeDWbi+DuNuzKWkyUBEkPXKwOmWUChPGpVN+4AYr6v1nXF+oJP1RNCmJATIlF4qCofrHQj7Wmb0wsSxgeaGglau3+01VNyFJ4bzNsSLzcnV3D0ZQDhC1K3JrNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8wQUDTOYSJlMARjTgmzAk5fpDYwgSG+FjZHuf2weMY=;
 b=Qhv3wS7r61ETog1AQTy/bBDfpBUWwezej7bTW10Z6aT5nRBb2k6muvnmvWhpOXc/68uBodz1qTnWb+Xv/agMfv6liw8pjdq88v8xy4vxRNtwwPnQsDlngiDb+wYiFf0tLiWQ0m3LAIbnCoiIbNQsNpkxS3u1dsP6M5dnMS5bPuEBokiQqTqon8A2GycWPhWmKkQREIA9rAiNY2O8nSD2oF6rz0yXSOzv0M2dnJXTI5PdlUTYuqfDTC4DNGHCfwSgT5WkZ5Fa7sNJbMME9wzydzM5vMOYwMmhve/MnE4caIV2foDVo7aD8474a+piqKUC5T77zDsIv4d2Jlatrtmn+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 20:08:29 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 20:08:28 +0000
Date: Thu, 7 Mar 2024 16:08:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
	sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 03/13] mm/gup: Check p4d presence before going on
Message-ID: <20240307200826.GE9179@nvidia.com>
References: <20240306104147.193052-1-peterx@redhat.com>
 <20240306104147.193052-4-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306104147.193052-4-peterx@redhat.com>
X-ClientProxiedBy: SA9PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:806:27::19) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b10a5c5-e075-4142-0b21-08dc3ee25ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fJsL/DeLsT3Haybnm2Y2kJUGYEhh/OcxVNROe/21sBWEKdg4Igg6Ck5ySrnTeFrTRDPrTJ8EYQWiRB5VfwCFTmGDYo0wt4xDBfYx6aAuzsnvv0LFqUly0oQ3Tg8z8m/EoN2HGFukOEQbCtrT8GIGm7WaGHOO++N1Tc4nHSKGjTLjYgL0TCfSu5xBHJxO2naZOMmjYwt/58P6W9WqVQ7vkXfNwd1Q/5rhVcJ6cSiIVyro7gri9Zr1NcVfKqRQkH9sip5WXb2/Q0Q6p5rEFeLTiSKw409EsEFc6ZfHdDF1S3TC0aXgeynMsc9Fc4FMT2I8dNHlLtqVmndZsXjtpvrMHNY4XEzjCRycN+bUwkSsgvnfFKJ39m4rZLNrJuY0HfZhwKo/3hzo/qs1NyAZmapPmBnR6uyibtA2yI+xYTxWlUeSr+0JHCd7rCEnjtSEE6tZNnqNB5BHr8SzXOyWvdL2o8q6dHaGQt+9IlAguMPexBTg7Wb09nAagLBtrYnMGGaJxByj0ww2W8WTxLuah6+mSpoFHYutSSlMPkmm/S02hk5HeF4/No6lX86jKhysbvM5X0/hso84vyEMnFME9g2VBbA4AeXZn0l6eIH+R6gfJCibElrLsHGp3Eh4q0bqHtFgaOGd99oWnx27KohVQooElX8bicFAbRL3oneVsoVbeZ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H1K18NrF43ngrcnsp5NUFbt4fQoL4BH9lQUEl7UBDkCt3Gq/umwHhkB7tzQ+?=
 =?us-ascii?Q?eqeWxwyHIrlxTR25dLl+G2oPGrLy/hoXDdfQBnXbwnDc9qdv0YIWsGMLzmQj?=
 =?us-ascii?Q?fhenZcMERZdvAmBBIIobFEFppvaDvAwR5w9I7IeZQVGV5TnDyg9o68LvMBzz?=
 =?us-ascii?Q?mDTCMw0FV4+o4knmDYetADXvDqxOjw99VvFbtXm6yJL5RnMABsCjGkz2XEHx?=
 =?us-ascii?Q?sHZ962kRzTKZj/l7p4B6SDb4vyDRogVlpaqydlHHIUIFoqj7P1xh2A6w//O9?=
 =?us-ascii?Q?pc91VU3jn+NjjO3MlYRCCBXaHA2q377BpOcqdSxARE/7GvCe/tsT+eZkQ4ei?=
 =?us-ascii?Q?eQRZF3dERbgus3/aZxxSR3IN7tCfWq3Tf/GVc8SGPABe4wZ6o11gB4ytTfLW?=
 =?us-ascii?Q?f6uut1SjsV5w0BoPyH6sZz2LUa8TIGIq6kLVMNt2HDsCfTeYozlXwZWvL8Pr?=
 =?us-ascii?Q?iq/03PFg6VDgzs+cLBVPnkXIJqkOyYufkc7MtWhND6/jOggS1Ap6h65BpPtH?=
 =?us-ascii?Q?kqVkAXr0ZLnPkI4Oxq/JSnx/moM5oudl46LCQfo7Ln6ZGRDJlkgte33IQ7zz?=
 =?us-ascii?Q?id1Jr4ERHpBXf2vAmXfgUnuxPdTbkt429z7InFsT4mGEWFNELIriYPaW70dw?=
 =?us-ascii?Q?h+OpHUE2sthyzYr5UekjYVc+MNJdBs9VME7nCdcFRKu9H5SMxfTxDju4oKFl?=
 =?us-ascii?Q?pqnuYGjBXZ9JkJK0ZVXNc+Dr2chGfgGsdKYpdDtPVwnGBaQvBCFbLmwXjH2b?=
 =?us-ascii?Q?lf4dsMU8tGii0jSndrcuBgYfRVSctEUCCROZ4d0GFGrbSy4ex7fNhhR5g+9T?=
 =?us-ascii?Q?w+ukIXn4tElpLiD9LJZ29OX2Dorfncfi80e0+PgXyZt/zDdBfUtIjL3It0aX?=
 =?us-ascii?Q?gj/R7ro8hktxCVZe3FezuVSo5kuDv1C3xHGjWd7tCBklitgGxGSZueJwYHqd?=
 =?us-ascii?Q?iAxIurALRccV7rcPoq2Gve99zyCByMS79xLrGyOq+rEQXmXe1MdMR+pVHQNb?=
 =?us-ascii?Q?LRFjTBFEw2HzGQalAEDrFbRerDm0M3rYSw76TUGXnkP0vzWezb9gEnVHvO89?=
 =?us-ascii?Q?xxlY+jdxFzSGBZpiT3kzbxII87U2GrFFxZvW5eC0piOuyqHofMOhxs7vESqD?=
 =?us-ascii?Q?d5t0qb3uNNOh59WZ94y486o9o2UmSWI5XdkNlMvRSByqgMjBiIJ0kbHifWXI?=
 =?us-ascii?Q?EFj+IJZJUE1cWhLZ1h25f2ow6qxfzijucnKFghSdTNnkS3vDLq9dZRZWEBTp?=
 =?us-ascii?Q?Uy6V8PUzzGjs7rKAf7Rz9XwNjvQyBDQDMLub7nDcOU3+i7UIKOVm9JK9EQVz?=
 =?us-ascii?Q?ti31eQ05fTo0DNE642/d36tLlel4OU2SUdRpB5/AsI9l1jAId5KLiV4fFkL6?=
 =?us-ascii?Q?3LqlCzTprrEFUrK9ug/L03LG+OcDRNZKs2vyjgE7FvnaTMGlDnrfZDO7DBKB?=
 =?us-ascii?Q?9kzs5M+cZRMV2m1G+j8TJYC889ANNpNFywKS85lzuLvaAO5IlRUMO/Mte8oK?=
 =?us-ascii?Q?s+GNuvNQAgsQvdkerzjYqSBA8C44PZWaoZ9IuXxj0aiIVAbVPl9zg0szOq3D?=
 =?us-ascii?Q?cQ1So0tu8OMXtUWM8yg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b10a5c5-e075-4142-0b21-08dc3ee25ab1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 20:08:28.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hh3/T1R3A0/2/VWGto8TaosNkvNNAkVY+qrhcRfHa6Yd8mH+VSFHupTFM/aXeCkI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292

On Wed, Mar 06, 2024 at 06:41:37PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Currently there should have no p4d swap entries so it may not matter much,
> however this may help us to rule out swap entries in pXd_huge() API, which
> will include p4d_huge().  The p4d_present() checks make it 100% clear that
> we won't rely on p4d_huge() for swap entries.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/gup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

>  	p4dp = p4d_offset(pgdp, address);
>  	p4d = READ_ONCE(*p4dp);
> -	if (p4d_none(p4d))
> +	if (p4d_none(p4d) || !p4d_present(p4d))
>  		return no_page_table(vma, flags);

Like the other place I think this makes more sense as

    if (!p4_present(p4d))
  		return no_page_table(vma, flags);

Since none can never be present.

IOW if the following code doesn't decode swap entries then it should
be guarded with a chceck on present not none..

Jason

