Return-Path: <linux-kernel+bounces-18467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF00825E0F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 04:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B1D1F24108
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 03:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367F963CA;
	Sat,  6 Jan 2024 03:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVNhocBs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792763AA;
	Sat,  6 Jan 2024 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704511434; x=1736047434;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TVvqmWpJ7rucB4rSJn02KaMTJavPvaotV5ZEq2SE+uE=;
  b=RVNhocBsAECHmLBpMsJmfI3pIXqzqEkyOCVgosy8a5TMLxFx2JIm6FhA
   Uq2ffJ19FBJuJKFCf/jFTd4l71uCXacbTpcRoo20/va6r1Nx1Ung6S+cj
   ZeuJ8RnXNDCpKnYmY4ksWpRA3R9EUf/faJ34VvD3YwWs8EAqAVasGLa9f
   zLW8bd0IIsjIr1J0Lhne8twKcxi03DNhZtMQQgZ/nGjjBg4pJ0xgsxaTS
   ifNseehF1lI1h/DnB1CwWdVwA8Bc2TcOF6+dQLaz/Ck7e2aZD1hKwmnnz
   7uTadiyJCHGZW7p0ifiPip4KqpeFa4nAKcgPnQMvpR9G0M41MYnZY06ju
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="4400745"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="4400745"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 19:23:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="846734918"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="846734918"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 19:23:53 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 19:23:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 19:23:52 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 19:23:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDlh+mZNu4+NtTQ2sJRohi+UJJq8x+LLHh+6de41Fo7dc6+GHTb9ZqOVfo59Y18WeURr1rHgGLXv8Sj3+m8k9mw0dF6w9BFe0VKCjUh9yBfVw66CIIZ2xpCl4v+cwDXfvMLNpKiwvDN2s9y/nLGxzc5WBGALHRS1LJ09CxCVkxo/1qnOLP6J6s0q1HFE2qj8cgdsva41SgNIWROVBh1S1RKo6yMbcmF7E/9DZMXBvPgk30O5KvmJ18PwNLHo0qaEH6epBuK8OdHaQfbLmT95CFCaeAfvboy+4oEwY8kk0QHwrHecjlsovY/BHItXFSAGvoGjvQwhz7clYpuXj1IDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hb0DhPpoXwiR4v7ETlR2e+6gWXU8Xg+VDFsW+y28ADo=;
 b=URpkR23/akU8zmry6txRkP/xnTgoNM8OnbJtFmFCq5BpvnBBJSV/rVGlF736dnwZCxJ/7/y3d9xKqZtm0fFYdyjjfH2W8p/SyQ4EzgIQAB48JHwqb1qg22R9HLjc6Cb28g+GIwXYF4WBpsjDdR90LwkDYc17//xH9sFan4rpQYJScEYisoHKR6D8VoIJZprr7xW5I6zYRLF1qbgGD7nK0GRH0+d4i2VJEyPPMmw8TL11yWuI09wPcctEs5NhSJfnLPCl6LmpN66sPoDtpbxaGKcQ7TQOfyClnxJKdRlcjIeYF+ExPXbcaRWvyDhs8cijqYzAbxNiBUFdEsh5q79urg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7565.namprd11.prod.outlook.com (2603:10b6:806:344::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Sat, 6 Jan
 2024 03:23:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.018; Sat, 6 Jan 2024
 03:23:50 +0000
Date: Fri, 5 Jan 2024 19:23:47 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>
Subject: RE: linux-next: build failure after merge of the cxl tree
Message-ID: <6598c7c3db0fb_127da2294a6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240105161709.22d1b027@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240105161709.22d1b027@canb.auug.org.au>
X-ClientProxiedBy: MW4PR04CA0274.namprd04.prod.outlook.com
 (2603:10b6:303:89::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 119f9b3b-2ae7-4eaa-3711-08dc0e66e6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3cCeDv7wcQRXvBL3hxEnWg4lOPmw3pzsDStBkvNE38QWaLtEeiECKfeRZLP2iMVRUM7pTSzYDNTfc1AV1Zp3/i1TBHUypkFPaQzFQmxFdiQxQ5WBw1tfZ0L4VwDV9++cjbpfM/nGjcmmsgXq8BimuT14/pjkZUFomx8wlLsdeqaQOtUWoo+W0rd1RXqUfntHXoU2Uixrub6ZYmv1pErzx5QVDK29LEphD+4uN16fcc3uOg7t3TlNNCM0sZJuncJRe9dCoh/Ad7EYTPFuFCZg7BKpFylVKWvPuU9m4FXIoM3U2tq5478m+pD0BvoZRhuvuKib/tvfREVvE/jomtGRoh80sKAuVS5gnb30s2BaytOjc7DKVQ4k22Ek7R13CMAopP3GFRyf9FDoJYiyZZ4eZRfeMELhNumfDSp1rHXlVk171TCBZPdHX17BOe4zHSscBCpZPp3uxT1WXQUbOlXyIVjgTQAalGEl8/fXgxXo8kK0SUh55uUzIL7MAlcvX0iVqQJqEE1nevOtGiJZd7P1IYCKokHtB10MEPblhCyioAJPhRA8M50GNzUAxQYe5Pk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(9686003)(53546011)(6512007)(6666004)(6506007)(6486002)(478600001)(38100700002)(86362001)(82960400001)(2906002)(5660300002)(41300700001)(83380400001)(110136005)(8936002)(316002)(54906003)(66556008)(66476007)(66946007)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S19SCg3+GVZOpGzCmTGsgLzSSz7KR2Ty1vdStza0Lzm1yGWvz3nykpgAAgnQ?=
 =?us-ascii?Q?TPvYaScDKT/6aOdp07tGOuSdavQLDzYZEpE50tl1+o+dxB0Sb7rk9Y1Wp0ON?=
 =?us-ascii?Q?APMnIh0wvxdkzi0TO7SA2Sab/SvFv6ZX9L8PfvJCzYpSLhqLC5QZJ8K4xTAL?=
 =?us-ascii?Q?gHtuhgP8L6bI5+YU5L446g2UUeJW684LfaFbbqFVQj5MZ1122hbxwIvdoiQW?=
 =?us-ascii?Q?S7AaxHn+tlaWP09YPAdrhFWi110ZvC+15dpjhO+K9i08r4sxidg6HgAU+Cma?=
 =?us-ascii?Q?jaMczuWs0EQgMVeHqpVEcyqH2JcSDzHbcc5jB3MvlY5hTv3gtCrObXGLQnTT?=
 =?us-ascii?Q?DafqAZqhhBiJCqWWj8yKDrBZCvFmLkLNj+FSY29QLnD8pX5UbGoF0AOzAWTq?=
 =?us-ascii?Q?mYuDMDLWvsNooOMKfoIyiIlch7MvjR9w9VpepVQdxxE57CI2smnNoRGtmX90?=
 =?us-ascii?Q?octDnGX60lz4wmXePprmOe9324AfW1vZPq2qsZofeIq+MCa6kS5W1QIM4vMi?=
 =?us-ascii?Q?WkwUQ5G+Rxx61UpZSOknrOUcNwy2iTOeVy/Cylrlhe9jcPAyDplAa0sZ+6hT?=
 =?us-ascii?Q?xaQcJO19Nok7I5XJh8B3MzfjbNQrzaYgUbMSGeotuY6tA/dJiR/jVBi/W0DI?=
 =?us-ascii?Q?vczaJUVMhyTLNeL8PfOjToOCvUY4kboNVe3Pm5tkR4gIW2CxL7FN7yMhFMvU?=
 =?us-ascii?Q?DQOM7yVspH1KR0FmWxI5owNkOa/t3r83YMwv6IyzKTuc4Bj9TzCoLJc5cwo8?=
 =?us-ascii?Q?Q1N21eW/2CRyJn5iM5FdPa08eT77p6DnxgmPgOsHefaWiRTKiLS5699lSKyr?=
 =?us-ascii?Q?alD3L50+J/IN+187a7lT7Wv4Yf5GHL38FKAQeU6Xewpi8ZSmHg6BRSIKQrrh?=
 =?us-ascii?Q?ybwNaWUK07ZNWHDYJWU0jvocTY5yR4ylOxbsdeHG9uSjqTK7cmt1R/VayHt+?=
 =?us-ascii?Q?m0SbTglW0F3nwLbdRKN7JxU3CeO5gwzgiU4AQDFmT465/Z/qen3yPF/czl1c?=
 =?us-ascii?Q?s9m3+oWFcoHZwl0EZuJ9R0l++6H45ot5MAiHXdvJybCDmyRckyLDpbQ0o7sc?=
 =?us-ascii?Q?l1r0FoSZOt1Gicutq0nl0iP4XMxLjWwpSWj/lXPEeuOH4kZ4sG3hjovLeDjh?=
 =?us-ascii?Q?0ME21qYTS5ESOM311tjdmkipPjiX8bMvRfZC82aigba5GksRa5pYs2Ra+mHS?=
 =?us-ascii?Q?Np+a1Zd+vKRpWPfe12/bvqVVZnfHcF9bOq4M6QjRv/8IVG3moKFrereeWD5t?=
 =?us-ascii?Q?e+6T4wMyq90vM4adRJuyEIRoxFlNk+XSL2/9OGw4ag6MjGnVLWa64+zevV+Q?=
 =?us-ascii?Q?6EMwgvd9vNTDzdDwFOVGFd+2Io6ZEPuMjaDfC9ePj5ubpCPRi3xPGFiDCr+H?=
 =?us-ascii?Q?gIFN3ydARi0IAWjDPEAVtBibT2IBR/QOERd+LGL6bsk3xlF1tVwoD/gET8/1?=
 =?us-ascii?Q?5pw5mBJw6uB9e9j0E2LdIvdGrvrrJwkbmLG2QyI28BOSmIIRn0Dl6kx7Ks+Q?=
 =?us-ascii?Q?nu9F9tKaKg+ZygfQ13pV6ekoQnztXJVSGKLJdh2oQMRxEnvBDc7VAK+A4VuS?=
 =?us-ascii?Q?s1vtmH6SljswAxF5kQsHn5Pov2BXh8CxV7AQIEV6QGxsxC7QliYW+fWPr+tW?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 119f9b3b-2ae7-4eaa-3711-08dc0e66e6a5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 03:23:50.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DEmjUlG0rtPjRh8oLz/Hm87KFNGoWjgRQiEgdzBIjMIPQs21MHm+TSt8FlS4gDZffm0FqKuS+kCxvpxvAsHuebFcuk+6TQgo43JGkmcTJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7565
X-OriginatorOrg: intel.com

Stephen Rothwell wrote:
> Hi all,
> 
> After merging the cxl tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> drivers/cxl/core/cdat.c: In function 'match_cxlrd_hb':
> drivers/cxl/core/cdat.c:327:43: error: 'struct cxl_switch_decoder' has no member named 'target_lock'
>   327 |                 seq = read_seqbegin(&cxlsd->target_lock);
>       |                                           ^~
> drivers/cxl/core/cdat.c:332:38: error: 'struct cxl_switch_decoder' has no member named 'target_lock'
>   332 |         } while (read_seqretry(&cxlsd->target_lock, seq));
>       |                                      ^~
> 
> Caused by commit
> 
>   185c1a489f87 ("cxl: Check qos_class validity on memdev probe")
> 
> interacting with commit
> 
>   5459e186a5c9 ("cxl/port: Fix missing target list lock")
> 
> from hte cls-fixes tree.
> 
> I have applied the following merge resolution for today.

Yup, this looks good, I will include a this merge in my next branch
going forward.

> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 5 Jan 2024 15:44:24 +1100
> Subject: [PATCH] fix up for "cxl: Check qos_class validity on memdev probe"
> 
> interacting with "cxl/port: Fix missing target list lock"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/cxl/core/cdat.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index cd84d87f597a..10ac76bed477 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -8,6 +8,7 @@
>  #include "cxlpci.h"
>  #include "cxlmem.h"
>  #include "cxl.h"
> +#include "core.h"
>  
>  struct dsmas_entry {
>  	struct range dpa_range;
> @@ -315,7 +316,6 @@ static int match_cxlrd_hb(struct device *dev, void *data)
>  	struct device *host_bridge = data;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_root_decoder *cxlrd;
> -	unsigned int seq;
>  
>  	if (!is_root_decoder(dev))
>  		return 0;
> @@ -323,13 +323,11 @@ static int match_cxlrd_hb(struct device *dev, void *data)
>  	cxlrd = to_cxl_root_decoder(dev);
>  	cxlsd = &cxlrd->cxlsd;
>  
> -	do {
> -		seq = read_seqbegin(&cxlsd->target_lock);
> -		for (int i = 0; i < cxlsd->nr_targets; i++) {
> -			if (host_bridge == cxlsd->target[i]->dport_dev)
> -				return 1;
> -		}
> -	} while (read_seqretry(&cxlsd->target_lock, seq));
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	for (int i = 0; i < cxlsd->nr_targets; i++) {
> +		if (host_bridge == cxlsd->target[i]->dport_dev)
> +			return 1;
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 
> -- 
> Cheers,
> Stephen Rothwell




