Return-Path: <linux-kernel+bounces-73685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FE485C5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB916B23C52
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51AC14F9CE;
	Tue, 20 Feb 2024 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJSCXxYW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F491FDB;
	Tue, 20 Feb 2024 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461331; cv=fail; b=BrKRu0SZs8yoVtCd4uxVh4IhAC+sezwkLstavOFEdvfdP8M2NMxUMmao3XUa4NWK0IeetUB1HVxo0i6J7lq8hffevSiSyu5cP9NeT5E27DZpqMsrE1pEX3BOPYutWq3yhBHdBI55J8tl+ivJMRiT7YwM1dmZbm21YioNhSentvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461331; c=relaxed/simple;
	bh=A6RaZSTEvSWOSAsfdYmwh9OGKYMbAdpQrt36UFB3Nws=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f7YYG7Cn7im6tdXPVFX+ryaUjAqVhkfceGznjOz0alDO8l8u0r2/4Hx0ra0sTA6ksyoRuij5ujJjOrYC1ZnGFCxmIUA5OSnRjMNfFtABka5aeliw8/wLB1LxVHyu3PdIbbiLk/p51X0/FF9MSd6iZjOHFCspvsd99bCUTao7ygI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJSCXxYW; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708461330; x=1739997330;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A6RaZSTEvSWOSAsfdYmwh9OGKYMbAdpQrt36UFB3Nws=;
  b=EJSCXxYWEtUcIXcKoAbWQ+aMV/KEtzohuWMSzrNa5295dSURd337n5lz
   VnJMg6g15pfe2EwJHfh1FbhLmbg5kcmaVm1rXVdSLhTRk4Ru0xhIFVQx3
   GX07z63db4CdUaa8742hWuEKjSISyWkRckcadZNHLdPFCHTC8TJtDSoCN
   LPTSJWrFV0/29YJ9cd96mdNnZK5WtuDqGjNlMbx0V59DdhK5ts6pawtDc
   C9O83aUy+9Zi3nH6GH4rPOpKxpE0PJERtLn5XW6sZ+GpfLFOVoSPvfZfb
   norwvIx+DebeC9uGDPQ7EZRaIhfEtqxzuQ9hd+Ka32aDmIc2gh3B89XwQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6365204"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="6365204"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 12:35:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="35934900"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 12:35:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 12:35:26 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 12:35:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 12:35:25 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 12:35:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfHk7pqzTNW/Vs3GPNrpo9CxecioUJOVGYBN2Dc08MAqeZdMg/J3tzW72GWnXhsjUE/S3rc4XYGnVdxaTGxiRAqrl+E743e7a2Af/vHMTQAOL0D1yNGtGri8b+36yJy3ONIKq90vpcfdLv8p3eth0nYnrlrX6iuJWUo9y9CafgilWrAwdfzG96/gnwjaTKy5Oiit9shlFWqW6R7E+SpB54AjK3RoXTlSFsrlt91ghHMRwLAioVHRkwQwZLKLtbeSjvZZ9B95W0RXoDY8r5NSrAoz4ms0DdE0jAgeFiwrp/S+mM6Dz3r66Z3FzGk+7moFEpTjOypuD1xC+mTkASwKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NELs1ugHAP5F5H2QgPOXEYA4ChEw0HkfBe47Q8MG7ow=;
 b=mpHh7+nvZjAN322FnsPJ8F7zhKITEl6Bc6Mg8ZXdvBKXP1IoTOxvDW5/kiJmvMh5h5wy6yo4g3npsvOiNaSBPTT+VGLtY79bIeNl1gzn+y1cwzq4XaqJxBOsGAphTBE9CBS1/5wiq15Pqm6n13lQWragI2wuuCDLlQu43tIaOA6/JnMDe/UgJ7LclnTGwKxkVcDrKTzU3PeqwaiChg1+qjwCu7FdU490UJtLsqldHb1yoWeTju9N1b5sYbY9Yzn1zHOLRL6IYtrLYAGrT3CTVFXrnFFGc1FiEoZma6M7J8ALdIP8foJNQ26tJ1ggKz3vSV4aaLH5S3GISdfOWwebyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS7PR11MB7739.namprd11.prod.outlook.com (2603:10b6:8:e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 20:35:07 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 20:35:07 +0000
Date: Tue, 20 Feb 2024 14:34:53 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: Oded Gabbay <ogabbay@kernel.org>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
	<thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, <kernel-janitors@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH] drm/xe/guc: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <pshjojhgguhevgor6p724fs4pnw4a5nyclwfqnk4pfbommxyrh@jfha3y5whlei>
References: <d6a9ec9dc426fca372eaa1423a83632bd743c5d9.1705244938.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <d6a9ec9dc426fca372eaa1423a83632bd743c5d9.1705244938.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: SJ0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::11) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS7PR11MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: dda0033e-f229-4416-98c3-08dc32536d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5TxUaDuwXHEBgORiBR9t6H3mUBLn9rt3af7viB2UzV+9r61zSWOo6Mz/gwGHe5w6+ZACrNdLw1m1ScEayH4orrf37k4G3i8lka9qGAQtdCsTbo7bsZow3UUOXb7ot/yRxLf7g6vp3WLD1bna7Te4mteoY9e+QRF7/XUUklCDjGCgGqi2V+uBRF2kyYTtnJcq4um+mj3zihTapxjbrJH0/ZhG3gfXDzYCOOxPJcSUEJt7udAK69Ubiaf7heS9jkaguT5hnjye+JlA8+axO9/kjTUW/4li2t5miqGI1UPRlj2Nt4Ar95ca667fGQAn17/K71VdpuNcvwfD3Q09rue2LMFzB67/758nZ+AceUVOEwbDLwe0u8BkOlvY/jB9kKzOWn2VhufqQni9jOhrrJgpFjx4SA0dFB17d9WaJEI0FBnLS8PUeAbNJYo4PZLw+UL06pSMuESe9378DBYog/gjo+HFI3Au0GKcbFfqHjpQ1B275ugMytI2DsMdTTSG+GxQrwpqBCkIXqANpwItmTWAce48+epvz2fPBNpM0f2lJFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qi76smMJU+Rr2pwY00XU1CLZb4wrZC3r7MMfuayGL8EU9YIKNHyTe0WLHQFS?=
 =?us-ascii?Q?KgbWKQluIRcuqgVTv4G0bFbG1PXPKEgQN9tr/jT8aPn3+UHGu/tD3ckRZ/bk?=
 =?us-ascii?Q?MFqGaM4H+LcfVwVh2nAUK51TEetzSy/YBij2BoVL95JoDrb4bI4yMAMrJrNp?=
 =?us-ascii?Q?LCHbTePcu4136KNYLloEQaH5ZYmP4U4V9VFktLFU12ph67zla5GG+0LZi2Xw?=
 =?us-ascii?Q?rAv/WiqrYU/9Vb4roo/TayXJhAI/R5xAOVunrrVi+Xwqk6TJ878kasBZ/Vx0?=
 =?us-ascii?Q?XCcrydtLsDTlIgDK3gItqXGfH7E3SwgRBfMF7EC22sUdFVAovx4d8KlapNLf?=
 =?us-ascii?Q?SQAiTADN5JvWMk/nAGk2y1fEv7IyfcYtOcwVuLWKxPGDhDvmzrMmrnAI/SXG?=
 =?us-ascii?Q?RDq2/elmOavcG+CVHG1bAXJBgYNAdgnuoiGaswOouBOzxhyZU0J+7QPI88cU?=
 =?us-ascii?Q?0a2YPfb8PHo5EPLZrES3SnkhKwPi4v26X/Z8kwadxSi1CHuN1hMdaFA+hqdq?=
 =?us-ascii?Q?vLM0zzV0li6BGgx+NkRT+rmc3AxwQDZQIhec9rbyLmhiXHTsUvWiyXpSK3VU?=
 =?us-ascii?Q?xhorBN8liwb9neQtqot+XsaHrSnNfNxNR5lU/9WN2N1bVPuDDE7GeuPnHkvs?=
 =?us-ascii?Q?ZmQFghBdaER0Q4XaFyn7kmcmfG6gklc92GL5pHtsmGqX/qvBbGNua4BhagRv?=
 =?us-ascii?Q?8ry1+uRzTuzXbESMi2JqZRA5kECUZTyIwMKgei5xdtEFup8SfqDZeySUyTYA?=
 =?us-ascii?Q?ZDj0oOeNeBHa9y2gu/TVkcMQTx2XKBbPFpUzGIgmLgO9xq7FMS3RrQf168VG?=
 =?us-ascii?Q?o991R978ScKJrSWsUnBJLmRjfrn7Bw6jHIbBX71mNQYcixwBfpQMa1Ksoa/Y?=
 =?us-ascii?Q?UT3FRuGNzaC2Iy0xTCSJckDO0sY8svM5ir+3IeuBCNA9W6ZQa++3rUruOChS?=
 =?us-ascii?Q?7mGK+T0HWxLnf/mtqOos+/qoi31o2WAAhfDjuOdahQ0O4f324vJRmYdYPqlh?=
 =?us-ascii?Q?RgN+dY5orYFiq9cmH4VHS3k8LNn3LDGspJMnL2iQ7GtXjcH4Eovw8mixMJZF?=
 =?us-ascii?Q?viQv3zEJGn64ZmKuyjLsg7LfZCYtkYKaMEBKbAER+/DoSoM/DBQH33ligJ0T?=
 =?us-ascii?Q?cGBqk7oEpvj5GSpYXf8id/RsUYr7qMvSWNK2htybkzlDtIPToY4/rrB0iQMK?=
 =?us-ascii?Q?3/2G7C0W91PAH1SpjH/lax1iD3eA8dRw7Ikk7cY/81e6It8jIUYGeMFLEgid?=
 =?us-ascii?Q?uErpvcamW7gBlsxZPBaqzt/rnvGNd4IaJzsV7acF/pyh94d99yQXqsGaWvCT?=
 =?us-ascii?Q?JTHUi67GWWIt1IRABLyqrA5C34Go7dsj23Zl6OdV3hcPWpRBXlrzRu1gfVnL?=
 =?us-ascii?Q?5x6H4qFgPUxj547y58EtnzX+CQB0hKZd9P1OKNsBxlzeJ++BdjhAp8f2Fb+m?=
 =?us-ascii?Q?Hb1zPNaL2Wtctkp4S4LwdFy3lgSRvak8SzATrYgs4quNOsAhk+LJQrf6PiHW?=
 =?us-ascii?Q?0UGk3ArjS1hIybyS1l+xj40UF0wbD1U7dzYi26rs9OJxJQ+fKE9U0jW6ihNp?=
 =?us-ascii?Q?xuXHtfk93yQeg5XfiDjTSkJIFLaTxG4sFA4WEwl5h0orgrpVEUj6OmcioJmV?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dda0033e-f229-4416-98c3-08dc32536d3a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 20:35:07.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEYNk8L8L5cg+b0M4NCSIlan1LaYG5U5GMlDtZ+pabo1NcxvJgLG+1KC9l3yk82+KmE73Y3AimPzFQTFjVWRhN6S9B6ehNLpYTOSfr58C2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7739
X-OriginatorOrg: intel.com

On Sun, Jan 14, 2024 at 04:09:16PM +0100, Christophe JAILLET wrote:
>ida_alloc() and ida_free() should be preferred to the deprecated
>ida_simple_get() and ida_simple_remove().
>
>Note that the upper limit of ida_simple_get() is exclusive, but the one of
>ida_alloc_max() is inclusive. So a -1 has been added when needed.
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Lucas De Marchi

>---
> drivers/gpu/drm/xe/xe_guc_submit.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
>index 21ac68e3246f..11ffacd1dd58 100644
>--- a/drivers/gpu/drm/xe/xe_guc_submit.c
>+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
>@@ -311,7 +311,7 @@ static void __release_guc_id(struct xe_guc *guc, struct xe_exec_queue *q, u32 xa
> 				      q->guc->id - GUC_ID_START_MLRC,
> 				      order_base_2(q->width));
> 	else
>-		ida_simple_remove(&guc->submission_state.guc_ids, q->guc->id);
>+		ida_free(&guc->submission_state.guc_ids, q->guc->id);
> }
>
> static int alloc_guc_id(struct xe_guc *guc, struct xe_exec_queue *q)
>@@ -335,8 +335,8 @@ static int alloc_guc_id(struct xe_guc *guc, struct xe_exec_queue *q)
> 		ret = bitmap_find_free_region(bitmap, GUC_ID_NUMBER_MLRC,
> 					      order_base_2(q->width));
> 	} else {
>-		ret = ida_simple_get(&guc->submission_state.guc_ids, 0,
>-				     GUC_ID_NUMBER_SLRC, GFP_NOWAIT);
>+		ret = ida_alloc_max(&guc->submission_state.guc_ids,
>+				    GUC_ID_NUMBER_SLRC - 1, GFP_NOWAIT);
> 	}
> 	if (ret < 0)
> 		return ret;
>-- 
>2.43.0
>

