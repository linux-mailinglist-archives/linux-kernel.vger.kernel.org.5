Return-Path: <linux-kernel+bounces-82429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA7D86846C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4D01F22174
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F841350CF;
	Mon, 26 Feb 2024 23:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F774gzuG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF6D135417;
	Mon, 26 Feb 2024 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988518; cv=fail; b=hcCxvl7rgNzOkrrt8FbQhXehuEUCUYaQz0kuy9m8EGPc7ZH8d4pOe67SyRq8+vElyChGFzpCm3pOxpeEPdmESfJ5T4Fx/L6Ut1C1nkMQnZfNvVVdKbB9VtQhhJz7JSAWY6YQuiT+SXXLyGuZTyMrDTyG1ei0gr8W/ydS2TaJCaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988518; c=relaxed/simple;
	bh=awI6By+LWAKhQcUR2ybtQ79BaDCZpGNKepRcapIKrIE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HVVk2/m2t6PKTZjybdKDhNbPIpFmdolH3FaGVMpcRQpysgzNPlcTiVsxw5nGVhoZuToXYtKEa+EZttkyEF0K+4JFO5RXxlL1euiXvmR8lr2WXr9fdAt7nbZGSG4UZVssFtBGBQ4tmvgjY2biUTJTBWK+lvOAJzXOe4fbWB7r4Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F774gzuG; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708988516; x=1740524516;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=awI6By+LWAKhQcUR2ybtQ79BaDCZpGNKepRcapIKrIE=;
  b=F774gzuGinfeMluYrzTa4Z1huLg9qwh6yG9jnA47SEOGaXY17PZfSFe/
   xS8+BUaHa+XxUU53JBKRd3tVCqAhqMpKUs3ZvoGCnxip85wP2/P7NdyWr
   8OrOgTgwmVhydO/Zb4vY9HlB1JUn9wwvmkG4FJSxApoM2LGA5DeMoADlX
   C5iPnhrlwb8Z3iKskz8X7gK3qByEfQGqrEieKrUJgx5vAnSnJiYv1pZF0
   irIfouQu8dPNy1DwFS9UrNLha3Y/bkbj9BU1MGE4u3/HHyBtMbY2EWPdh
   8PxMfG1iRiIOUsSSsUQCo5ADuJ+JQrwWfhaLkLO9zImbLDKa+/mkLiKCY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6256754"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6256754"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 15:01:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="11606409"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 15:01:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 15:01:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 15:01:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 15:01:53 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 15:01:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPSjePyv6LTQE0CD9p2DZEAVrHx4EuzTZ3B4YhxQEAgK15IUJ/czo+huC0BLEkj2e96dCFmDcsGL8Tiw3FtgZOq+OdGFCga9+8g4xN2ai8tPDuG7tj+2BbxjCK7CuXOlQZtNihgHHy+lmxFgAjZfFC5WqqAZH2IX+15Rhn+p5IvRv1iIvUOYcaK7YpyiRUprfmfdqwdAR2sLpNZesbs2a5H5l1pplcJmS5G3VzxoA3L4Ex+JIvFlkvJR5BPwaLrITD9HfX4sk1tGvhtMx33ToKTWHTPEiWoJeCzbUamBAnBftTU3dXWzu0tjNwtDdXTEKMK9YfCpj/IZPSr/t//61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFkP5wfsKHCNXPbFLfE+jhr58QEgh454/XYEY2R0HIM=;
 b=e9Gz2UCeqbBCkL9pzflsLtEMpJBsztKeHMrPQJG1HEUUbRXr9aGsluSbENbsQBF4XXQoO3R8YqXjck64sAXV44VRZuTWqc1GkTUjz01iF9VsXqAMnIbAtt0s3dP5YbUTPbxv5mzrTjzRvcDS+qApH/j8RR0tp9f6kkbtmaMenRxU+GoQW/mM7dN/Ksjnysxv6Gv/P2ft3zTevwowJ3Uh8orXTSUv6z9xRL2CVWqBUPOiOY+bcYmvnXraCRKOY6kJMb6n7DIyoHaveN4qFNjaWtaktRNb2kuwN2NJ0ZX5bga3k3oAOjNQ8JmhNfS1SDG2x65qhMnvqZSce8gv4Y/NnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8399.namprd11.prod.outlook.com (2603:10b6:208:48d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Mon, 26 Feb
 2024 23:01:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Mon, 26 Feb 2024
 23:01:51 +0000
Date: Mon, 26 Feb 2024 15:01:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Dan Williams
	<dan.j.williams@intel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the cxl-fixes tree with Linus' tree
Message-ID: <65dd185d2eba8_2bca029498@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240226090417.65ba3c4b@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240226090417.65ba3c4b@canb.auug.org.au>
X-ClientProxiedBy: MW4PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:303:6a::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8399:EE_
X-MS-Office365-Filtering-Correlation-Id: 1477df71-845a-4744-62e1-08dc371eeaee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZkeed7/r8TlGNReUw+6hR5UGof/1b7DIqj9U3UzKIWkCJzw+CgGPux5Sjh+7Cufqzi4bFeEVPqCumgc7b0MF8G6fc5R7uiSp81/ZdXi84OP/7N3p4pZO88UpBNzzKNJPoiaiJd25NRoSM75cG7JzYgnTQ86DidauYogAkQzbR42BWXT4J+qKcvJo9BWIgbk4U6yBJbIbRWwTSNv5rAPsY/Zuu/LRZ9oT8w2YDr9woKI3/0Wi0CmPxhxzesNMCcjW1Ex2U/vH/h13VMD5QrLrwRuPLFl9DKETuYsg8Xuo70gsbj6P0ICmtBQVwjEtZRKear7RpIGni97ApYOcfNhKH2c5Xr2E/iLkOeUfzpbXOt7wDcPdNjZ+A0EQcGI4anb8THWzFJ0PA7Eg7iYIZIsDEY9P0WK7SRnBdvTxi6C7eB9OEKcdMNVePDHAlv7KfLxWH8jLUywlf457G4gvvTBqfa/ZAXap9lXs+DcXnTk0A/rAo7SFkjIJ2K2KnghAyF/DSrloGvb/3sPvmpec4ZCWIUBYSwLjhe99R1/f0E9Y3UUZ9KJDFrv0odv/PVtoxTU6wM85R1R+++mIXyAnOFyc69/lr3805BK21gru93OfDv88vjAnZrk1QCSYTOrtGkkYIiPKxRK4ydMAWwcD08g8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C8z81SbMWGUXy0nVmlQwIrzpN1MCSS7fei5MmGyAMn/aXO3Z8PFW/7w16hEr?=
 =?us-ascii?Q?sxKBOd7N4FefW9LDF94f+QzPPULLce39FAW36fKN35WkRml7Wrfq/ISs3hLE?=
 =?us-ascii?Q?qPmPRulbaNlfsDURaVuEF/aoNCziuInI9/1Rc8lTwi7A77qRz1ZVgZRvR1qG?=
 =?us-ascii?Q?3rtAGEx/aSsPo2E+b5+LgI008DwxMPgRtZoq0gpT0VfxS+TYAlLGj7knMPvF?=
 =?us-ascii?Q?7IrLNYuzArNGb9YesagHqFiJAF9meBx7KZVOoPazSFmD0X2QR376W1qiKWYz?=
 =?us-ascii?Q?9jhIk2K3EZRMsnXCnzMqfPowSXyR//4tmXbWvnxJCWpOvJ9H6T+HfeMPojEP?=
 =?us-ascii?Q?2zgviuIxWyvRz3HIgrx6tV3mhLHIwKModtk87uTz4VFOT9WXxJrAoPJ+jcF0?=
 =?us-ascii?Q?03F7KBpEI2w4aSzu4pj4gcfm+cddMfvsQmimSlg62Nuvkr17QYhB6rokb/IG?=
 =?us-ascii?Q?ftnF5kh8audaPFdZGUoCiq6XDgv8P6ZJ7gEjna8lgXxBhul4gAGPLrGFnasL?=
 =?us-ascii?Q?yo9Aq2hdAbSrRkbPESBRkYyqZD/qVqwdFWF3dHDgQDGAb3IKwkIk7jTEsdG+?=
 =?us-ascii?Q?GhAl9KKdqvsqNfibgvfd2Vq1s0voGPeH3IsVdVDfmxDJrPcDGCeSvGmVTP2k?=
 =?us-ascii?Q?hSJNb0deNw0+D6f4+LJMKqemFelF2zQT3ElOetdVzgWO0MUpMJqPlOGTzdPF?=
 =?us-ascii?Q?lx/6JKejOC/cjdrZnVy2CqI3944JtfHL/zCBBsxPwyfj4vBZ9ltRCCy7Sh0y?=
 =?us-ascii?Q?kjwTM58aBhmxg1RTETbBBFGu+JC1FeSOeuIXaU2c+ZWdDp++8frKWZHxSybv?=
 =?us-ascii?Q?68A2n2PBTjZl74D5cEHChmmZe9KM46dJRGIET2LuMIrsy3VAfl4EBiYKeSaF?=
 =?us-ascii?Q?JGngouLBNxXE0RpYptijhKOQ5Fj+k/Ta/rBpZACUkRxesisl85KJXmNhgUhf?=
 =?us-ascii?Q?L6A6fKlhEMLZES3HuUBuzrfx1khlzoQZPsSFb0ne3xa3A1a2tzXVFS2+IGNX?=
 =?us-ascii?Q?AvIEvdWiLOn022ieEy8h6bb79x0yPC8F24UFj2fsUhMj0ztE4s1FnvDSDny5?=
 =?us-ascii?Q?jj18o63IoUsaGxkfgT3/76G6H+Kys2F2icQnINDE9pk0kEfZmcnGAQRYFIUI?=
 =?us-ascii?Q?KcYq8fYCHLyHyyGmPH+aGRhjRzo3QjfOz0l0xWr+ZupQhN1BAHdq21q2VsMx?=
 =?us-ascii?Q?3HKqUYVYgi9OeW54fX3BpfLzSizYGJyKaHVKIqlZBjxNxsjpsnYG/Yd34Ug+?=
 =?us-ascii?Q?leN74Cq0ghi10iBz54hfh4tfsEVa1Y+8PALR0n0IYtIJgKhH4fhImIm6Tf8Y?=
 =?us-ascii?Q?7b4GgidIQeZ1FyFChpgxjdjt3RGRVkOxs8vtaEf9nwVG9N/cy8W9L6V90hRD?=
 =?us-ascii?Q?6396npY2JR6oVTpeBQ/Mgy/0K4/lmh62dGeS5QJBGjOvYU7oNuvmmx4j1GWO?=
 =?us-ascii?Q?mQWtHjPiR72YTtrnMC0NuyoVmJkeqilHpcqCivazOQW3nkIiVimWRNPk0O6v?=
 =?us-ascii?Q?3SFKDeQ1UIWq6Ex+RNTbsXMQIQb9ZGT57wYX69amDMyq/4IaBqVderpYUUZy?=
 =?us-ascii?Q?MTj30KqLo78D58qUhQUDrZc+sATS56ByNBminEV/LgdCWje521Ptr3372nZi?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1477df71-845a-4744-62e1-08dc371eeaee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 23:01:51.1030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0W3oSlVmM0jLS+An1qFgUkwQxaqSanGXkmEjlwSP3kbFi+y0aElMILRmD9D+GlfanXjtmNkaa/pfShEPJX3Z6XDvWBVXvmfPpJFkZLEfLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8399
X-OriginatorOrg: intel.com

Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the cxl-fixes tree got a conflict in:
> 
>   drivers/cxl/acpi.c
> 
> between commit:
> 
>   5c6224bfabbf ("cxl/acpi: Fix load failures due to single window creation failure")
> 
> from Linus' tree and commit:
> 
>   5141fa1ec23f ("cxl/acpi: Fix load failures due to single window creation failure")
> 
> from the cxl-fixes tree.
> 
> I fixed it up (I just used the version from Linus' tree) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

Thanks, Steven. Will drop that out of the fixes branch. I ended up with
a late refresh of what was included in the tagged pull vs what was
soaking in linux-next.

