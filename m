Return-Path: <linux-kernel+bounces-37812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A0783B5D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5AE284D39
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90F364D;
	Thu, 25 Jan 2024 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFuVWx7P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC87F;
	Thu, 25 Jan 2024 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141153; cv=fail; b=uO7IJP8K1D/gOxPiz2snGsLfYqeGrYP9q3mcMgpW/j0FJYFOHbIe1OhINAk+rjHkk46i6UaGAyz0CItXctkAKiNnTk+EPyzFXg3OgHWXqRp2O7F0vcTGK0fATySXiPaLfY6c4vY9UrF+8SJle2RwDN2V5GP1YQU9tbbNOhvM9z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141153; c=relaxed/simple;
	bh=pEIlIcnAs5/aONGRUanhL1Fw738xGCKOsR/W3OZvIE0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yrl/tVk6xkjxCnREYxvwYl7VbZBcrlSIKSlXU11B6Pv3h/FkgFbAxFN85iQOePhsbDG1aGCo5w7GvNVYeIlcngWZLOOfFbqH/sFieZm47zFtBue3SZDT2WqfkhCl1zoRjwkZSEDU48HXtI7LvClKFoaP4ZMaEYG3Kpw5/PRN16c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFuVWx7P; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706141152; x=1737677152;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pEIlIcnAs5/aONGRUanhL1Fw738xGCKOsR/W3OZvIE0=;
  b=hFuVWx7P0BMEDnemC4/MUdC2LSEibmzDxQjNQYEyepT7ubL2HJFp+bQD
   LHKR6uwIuTEUvzh77D2tYzwqTmKjrOeVk7OsQ21BsIZqo+bCgugwTnrUr
   y9JBvS3Eu/ndOLnYDL4uL8aVdGTc6TUDM1s3RgXSJ2IDbjYhArb4rK7DA
   CDtva2ONCbog+JeKhELtBbYhzFDFwPl6NXSB3sS7Y9Hupbm2ot9jLn1EZ
   gr3L117rpbiM2IUX1TJbnPMSPa6slXM9tGKRfGDVxtXDRF0hq+yJjk+KW
   5WrPrCs/KczfTvKljHYJpY2P5wcuh6JoEDt/yA0jfD/1uPheZx0TX15Wa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="23473545"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="23473545"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 16:05:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="20879515"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 16:05:50 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 16:05:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 16:05:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 16:05:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 16:05:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbI5mdTNNzlz22RM7nTiVb8KxXJwFz0YBwbVkRbWMV01mh/BLdqNRvIWYYExtyqTWSpTwzXbiBqK0j6WVTMBaJdzo3tL0R4E3zH6GPnUVbaRYMDwW7XpkTLixNp4SgG0V2Sp6lA5cAbCVCQ1RlDF0v0zW5yzNWxZWqWkqJwCL7bbzj8Bmz91aqcUZd2EaEJVApM7MHvdV3+yLdURAcjfUaTO30HnPBurJVuce9MhwlZHqcI0pYe6xn+QWVkMd+arZFEOb0BM38GmbwSaPt9w3/F703TMRErzDGNSKwMA0jjHguus4pxc700teZDDvd+lLv1r2ZUykIWUd2rMoDgLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmfTDSZPfwgwK7VfdG0CSjQKsk/IPGEdfmODFGqkSJA=;
 b=XK+4sDcdm2k/tBMYAq0d0UfO2SaZEImWvIru6tkgA8EIdQDALffUhTGGkHotXynzGUpRUCnjBwzB2SB+p7nyuXMjcpJ3Crdq57bBb/WUQuOJqRMYVc5+nSpW0EcPbOzAcnx4dliPNARfhUz0QJ15kYJO5gNHKTo9ZmALApMB0TXOda7WwHBMCq+f9ofO2xrob+2OfvtI+e9OznIp5N1RyyXPXNwy0EJUr8R5CxLxMkXu6M1GdQDES1E2wiLgfT15d/cVPYIXjM5Wcdhf1cE5v6NG0iNtPylKwlxzfRCJNVv6dMfL+NZDuUWAu2FDLMlacDbWnJyvO2Ph+VunKSXzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB6376.namprd11.prod.outlook.com (2603:10b6:8:c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 00:05:42 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::b9a8:8221:e4a1:4cda]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::b9a8:8221:e4a1:4cda%4]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 00:05:42 +0000
Date: Thu, 25 Jan 2024 00:04:56 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	<intel-gfx@lists.freedesktop.org>, <kernel-janitors@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/i915/guc: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <ZbGlqD6zyyp4DsmH@DUT025-TGLU.fm.intel.com>
References: <7108c1871c6cb08d403c4fa6534bc7e6de4cb23d.1705245316.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7108c1871c6cb08d403c4fa6534bc7e6de4cb23d.1705245316.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: SJ0PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::28) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: abfc9c64-f38b-4b20-3e05-08dc1d395ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MuFEAWVdtIuRzaADNEWGBvlHQJrZcQ2aWRqwnG6eLTodANXaOpF+g1nWvdjjMRckGco3yqNSzn8lHGeOud4gwLAg0PoAcHK1t9Wunwc+01YjfqVXpOLKH8CZbNwTNf0JmsclcSP8ydiyzwTboxnaqPN3c7KB9HfiDBpRCNAHGgqu7PS+Ft5isMc7C9tsT5qPYtuPNReTMVO6gJhMK4reBq8Yz38CDsZTWq/ZoNMNpl1J5DRwY8B7392Ym4NPIVD9zuakai7HDvbk1/WfhFCt9kdv6PnquTYHfG54ldCBGzc1XWbm4PpZ9U+kdkLS8j7IF2HQZFhoPaMn9ouqkeoI3EOp80JEiHGOtueXi6okhD7/3ch1OQ/cRFx2tdjlUrVJLtm5y99bTec7ZXdIzMBK4wXgP0dNBh9B0+PIQA0lpfYsI25pL/0kkYdBNgi+2oXjPeytOUwOz3BYuSXiQhAKLHwZSevQ1uxe0v4Nwz/JKte6s3fSj7W2z/8YOYWLPAtDsQRDKPtSwD6G4DzcL7o951b+i3NhuEoJ6bj5DOBBVZz9o0H1RVT4etqbYpiMfcAI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(8936002)(66946007)(5660300002)(86362001)(2906002)(44832011)(7416002)(54906003)(316002)(8676002)(6916009)(66556008)(4326008)(66476007)(478600001)(6486002)(6512007)(82960400001)(38100700002)(26005)(83380400001)(41300700001)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xXxPdjGh/TcigKPw/fB8w+2xqnvm3EmbwUFSybdltINdD/pGaVjeZcgKBl1q?=
 =?us-ascii?Q?A1iqHAehBtbhTo3hOj488bvkBUQyib9hhlPURNe2f+sNkup+Yiluz0e76roz?=
 =?us-ascii?Q?R+UJyAWHHuJ8TLRcxJGLU2TekAS57RKUf4c3jLZXnNc1ewkB1lBe22Rmg+N7?=
 =?us-ascii?Q?psaVXZmz0bKLKpltfABBTMrb+LGe0i1b4LwxTbM3ZT2VRtUnqLHvvLFBT0zU?=
 =?us-ascii?Q?TfZm2KCiEeJjjwzM++XhzZoV28pKCnWIpKSgwH4RRJqlNv7ZlNm23WOzRwGt?=
 =?us-ascii?Q?426XbGTFzDloq0DPYnAUp0vCIsT73LaXWA1j93yAfFJCmbBt1ejcJGFG0pRH?=
 =?us-ascii?Q?rsox4agQZOH+FUKZy7IW90li/nvxYEnUSM4URxnMUvplaRrgwYneQBKJlAKt?=
 =?us-ascii?Q?qdD6kyus6JxVmFPQ29lyec+NLccDXeeuLvruoTbC+VeB1sK7yP4STMdYHLg+?=
 =?us-ascii?Q?pttu/5kmpnJ9mpPEDvOc5A6WMnaBFGkNeF0xyMogAX8E+ygQ6GiuqsDUGLVx?=
 =?us-ascii?Q?DYHJRL19FTPZDFDZNlafainvYTWTMIYyDwtBDYR1L5iVKL12p669pO5FXHuC?=
 =?us-ascii?Q?faVcCliskxeEm/Gh+bRTxhwDWvyRXxUMNzZDHjA6ftVSNjHyRxqioz20OMwa?=
 =?us-ascii?Q?HQrQ2Uc1ADUL4zJhVgH/GKKatQ7dLRkhWNB6YdOBVN0ErT2jufNzOokHhN75?=
 =?us-ascii?Q?f+9eabsDwzNrnskKCHjGIZSeCRkExfYxwdCUPYfztxZ0rpJ1zdwGTkLOGrK6?=
 =?us-ascii?Q?zQAS5z6XAdoaTwxa/pP+f4Tjyg3Qt1K8ISmx0flm/zRO2ryFZVZ9HXzmDuWA?=
 =?us-ascii?Q?iFHHQI4EzxbyseNfR1t8V7ap2RKzqDJgVFlEDePc/+LUup8ZOA6EYV0+zRWY?=
 =?us-ascii?Q?jAYOMlr56JNolm9dQnju9/hfx1VePGuvzE/VgCz2+yuJcC6edDpr5zsvGCBW?=
 =?us-ascii?Q?OObgThAvZEtScAAFgiYmjo55qI/EVadpFEJYPbY1IBxFWqkHI+tqZvu6XKww?=
 =?us-ascii?Q?ObDIu2XlI33efh3mto9ROwH2j22I47aBJqikiV0UKnZOF5X8/L3tHMDsLXQh?=
 =?us-ascii?Q?InsVttOIY8PTiJ2zowyaOZOhg2VRMoy5H4kMzhTQ7Z/W8/Ap5Nns5PiI+OBs?=
 =?us-ascii?Q?iNkT5KybRgMKHyEuzITZyLKRF+9iIutIrNwwLJMbcIsYsnunPkvXRI2lNJPc?=
 =?us-ascii?Q?g1AJMCFf+AESZO+uoT1A61Zqcu9JY7SjL3++N+6JUNwiVFwTG+XYsvpa1Ff9?=
 =?us-ascii?Q?VOTRqKUPKDv3RgNR1ebkx/Oi8fvHClbVik5/WPmKk0jbBPy6c2BO3c3X6mcm?=
 =?us-ascii?Q?/pXvCjljd4Kq4rukqfBee4pSgCli35qu5a1jkLtqYuGqyvQmiZfFt3dOON+E?=
 =?us-ascii?Q?a2js/wkOkgOmCuV3nTp8oTuIVq+TJspbX/VKfo5HymDh/hiWsYBzDnMXVhbS?=
 =?us-ascii?Q?imDy+sfTgA+E8wvQZbi8gsleGKNFvB+LA5OlFXPNLCGRKCGelGVxPJjBd8MB?=
 =?us-ascii?Q?AxBpFAbMDA89rJ1P6L8Kkv349cvhVXo5KwrC34ABdJBOwZPaASiRZUGpHXQl?=
 =?us-ascii?Q?wAzctrmayPh/u4k1EoDiZLGkqFDoNVMHX9GCz/3deH5Yy/Yck+mLID7gQzQX?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abfc9c64-f38b-4b20-3e05-08dc1d395ea9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 00:05:42.0127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYxfe6licZEuBjP+0v3GvXpW60KmDiNtSpSf4dT3J/EFNKb5Gf2IUEhOtS9aV9ybUoM3vHM5spip6v9RhrUV5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6376
X-OriginatorOrg: intel.com

On Sun, Jan 14, 2024 at 04:15:34PM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range() is inclusive. So a -1 has been added when needed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> ---
>  drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
> index a259f1118c5a..73ce21ddf682 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
> @@ -2156,11 +2156,10 @@ static int new_guc_id(struct intel_guc *guc, struct intel_context *ce)
>  					      order_base_2(ce->parallel.number_children
>  							   + 1));
>  	else
> -		ret = ida_simple_get(&guc->submission_state.guc_ids,
> -				     NUMBER_MULTI_LRC_GUC_ID(guc),
> -				     guc->submission_state.num_guc_ids,
> -				     GFP_KERNEL | __GFP_RETRY_MAYFAIL |
> -				     __GFP_NOWARN);
> +		ret = ida_alloc_range(&guc->submission_state.guc_ids,
> +				      NUMBER_MULTI_LRC_GUC_ID(guc),
> +				      guc->submission_state.num_guc_ids - 1,
> +				      GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
>  	if (unlikely(ret < 0))
>  		return ret;
>  
> @@ -2183,8 +2182,8 @@ static void __release_guc_id(struct intel_guc *guc, struct intel_context *ce)
>  							   + 1));
>  		} else {
>  			--guc->submission_state.guc_ids_in_use;
> -			ida_simple_remove(&guc->submission_state.guc_ids,
> -					  ce->guc_id.id);
> +			ida_free(&guc->submission_state.guc_ids,
> +				 ce->guc_id.id);
>  		}
>  		clr_ctx_id_mapping(guc, ce->guc_id.id);
>  		set_context_guc_id_invalid(ce);
> -- 
> 2.43.0
> 

