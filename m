Return-Path: <linux-kernel+bounces-106219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2267787EAE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A0BB22273
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF694CE00;
	Mon, 18 Mar 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZA5Ce6iZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92072383A6;
	Mon, 18 Mar 2024 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771991; cv=fail; b=QHVvD9vbIIa4LlMIsX5vOiwHRZkGCw4wwOc8Op3ydjn+uYi/DZMMxw28K4DWvptcOEU8eerBvHsAxsqsLJMCafnMInQOVwyWXAKt1d7BCc+L5iImZ883fuUO8CiuNr3ee660hoDrw6VT2ndySoh1pVOVHtXo4S2b0L9K0ZZIE2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771991; c=relaxed/simple;
	bh=lru6+tFLZNUIofl8eWHq7iusBHoCC6OJdYbRJDAh4OI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t4g0uaJm4XMaJ4a/WWXgfwjmtdFrDIPx7aBSaCn/UAJTK86wxu88cHYaTmK+jCzE/Q7eLuB1uT+i/HjjH9dpeGhv8r/JSq/o+iyPUO0mUJXvQvSVPoxy4ySNnKYmlR37LFFN5Lsm6IADKC98sfOSP6jK92bu7RuFZnkd0xCf5q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZA5Ce6iZ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710771990; x=1742307990;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lru6+tFLZNUIofl8eWHq7iusBHoCC6OJdYbRJDAh4OI=;
  b=ZA5Ce6iZE1bvxEvTcVrdtvPCb1XPj12d0hD/NqSZ21TgpVSJ65tznRmc
   umUykPBw7uDIQvdfFYCOlT5RCS9JccUiPDGfg3MhEuR5wFpnd2RemRGcL
   gP9GbH2JPe1sdt4ncnnAJPUjpkVxryzxp4f2NBSoVEMX0tGGC2tQi7wkD
   t3Tj0olASMQN86R02xzYJZ5OaHg3VYzPqtX2DGGDQGRJbqWN+zsJF+HYH
   FVBdGFu7s1u7LTNDUNcBPl7R1XZWu0EMSBzhi8e0slVDPAMnzXZoLoDLy
   rt4t9gY3rWxb6X7WGsre4zTaRsPMhYMSN97Pl/kdWOD8oFXYVTgbHScm1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="16732446"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="16732446"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 07:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="36611437"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 07:25:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 07:25:38 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 07:25:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 07:25:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 07:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JthwXJ2uOjBcnBzsPawKEyz4PNfJ7Q7RNDIublLu3ytX1doErbla/zHhsliZeIhaPMQPnJhgAhoD7rMB1fG/o/Sjhe85tZcYZD11oeGloI86r/vFJVkdbAj1v3HxavbIDKkyp2D6MaZ3latQ0agiHBJWy8yGOAIUxpRgzzhgXUf2f2PufiRs2DAI3JhVumZNXPl2uQjxuuQpnX9kX7QQ1fqDzFzy5CrH5ew/JehCmmQJH0LonWiUULqCm3EL1TBEL6UZ8NF6hh3LaCOHrUX1AjKaD3+AwE3tMmAHcM30MptrDTSTUa69lwL9Oljk++IlH0jF5b0ZB09Uv65wOpGNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjotge7GBqzfASntf/Gmrm4VfhKeebFLZdrHLF/Z4Kc=;
 b=eonj0iutNBKjs5kkJ6LD8tVrmD+A45BrqHgrXYNbWnChFPAHSgVjQf1qgTx2Yxik1Upt0FwKDGNvAP9jAopIJVTiW2qZN3Tlm5pfeNed76hwdKNYWTakjPoLOuvmCdp3OfDP7QLYQFds1DAjgbta4uTqr00xTTMQZOIB1JcAFDKLWLdSjcgkefs8vlFqcqQbDzAt4/laP04hzE9I+i7kxmcZTGn2TDTdYPCOFCoco39wILDVMDG36KF2aEg74GzyM99/+Y84TDQrAHj/5Q2Zgkp1xUeD3SyCKayfjLeEmTLA3yzoDLJnmBhh4R8YDeuQWkgcaO2t1HQZG2SIxzcqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by CH3PR11MB8381.namprd11.prod.outlook.com (2603:10b6:610:17b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.9; Mon, 18 Mar
 2024 14:25:36 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630%4]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 14:25:35 +0000
Date: Mon, 18 Mar 2024 15:25:29 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jijie Shao <shaojijie@huawei.com>
CC: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <rkannoth@marvell.com>, <shenjian15@huawei.com>,
	<wangjie125@huawei.com>, <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 net 2/3] net: hns3: fix kernel crash when devlink
 reload during pf initialization
Message-ID: <ZfhO2YMbQPfI7I+y@localhost.localdomain>
References: <20240318132948.3624333-1-shaojijie@huawei.com>
 <20240318132948.3624333-3-shaojijie@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240318132948.3624333-3-shaojijie@huawei.com>
X-ClientProxiedBy: WA1P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::20) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|CH3PR11MB8381:EE_
X-MS-Office365-Filtering-Correlation-Id: 6740ee38-4f30-47cc-ba45-08dc475746e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gd6ATaAiREM6UZJV1j4Y8rv3yP+YIRD6i8vQZTZ6iA1KDbNn4wk7opxXARmuxEet7kcoLCcUht4QQXEBSy65N1uGaJp6aAaj8/cEsqa8QFyxkctiPTcUkdRmA/j905Rf5fQ02W5K3Ri3JekaXDP8XQWz/ojj9AeFXEdRPzKQb24IXc7QH8TsGLD5kmadsplzUnT/GzlJAe7cPW6JqhKvG8sW9gZUtZuf4/syZAlCaQEBP8R2KN7zyVAXuhPKLwbgNfjHpEpCoYLndvArZwpsb9SdnbnJ3VzUDj4L3HkAzzVIYT725QrOG4FBi+TKkOEpAUttOoa1NeI4j5kxFZbaa1d8oMxGB7WL+Ei7JfH/+AQw60ixRAg6AjQmmjtqZHFKgGFazQ/pkob2OX/AG8nwAT9sq4rTHyUelnVhG9EPscYty2PXAh6WDcKG4uTfnTv7zTUKVnIla/9DpOut0a2RP/rQ7xWR+in2Y83eVjwzYT/+vzXFSw3n0uIzoTPUwek7zeLZIXjKrLmCw9Y2ZtDwnsCsHrsY960ZpwxyTNQOLqy7zyYZ0pWM/0Wp6Ej78H/UxpAzFL2naqQhHg2uW2aPqMtMx1KbBRJNgN8bNXsiiwtNOfBjN4cdpqQs9+UzHAxJypIuC0yOmnhnYdid9pU2GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?39iCTlcSi1laIOl0Ee23szM96Je1FcMkyGscgeOK7e5lnemu4a8bKVV0vcd5?=
 =?us-ascii?Q?Wp4UReSFBYMN0BLCqOvJewBEyEXWWW0smZ7ZXaSjKjjKX4dRObHnrGfTp6IQ?=
 =?us-ascii?Q?eeuuBMh8JU6qKKmOoaH5A7z4PJl1lZ23YNlNoDeFxMot3zh3ipT0Gbpm3fJ+?=
 =?us-ascii?Q?8iQXmsBnNGXuL+1HZlkJqT+TAfSvpp+520VXhEHkJ55AFcGHQ8NLMC/I9rWO?=
 =?us-ascii?Q?lcHaHSqIKP9CU2DKtXhXS/qtWG10CnDFT8Xo/VaKpaFm3AncyKSAQpHmUH+h?=
 =?us-ascii?Q?8hnFdRU4Y5Idh+jI9mBmlxrKFnrDvVDfPYw2TflyOB6KXvP/codykdsMBZyD?=
 =?us-ascii?Q?IfE8ka5SaBQxSiGhz91L7rPfitiinx3Ji3H/WAI6zAFPDbGrqrpmgWZNCJYe?=
 =?us-ascii?Q?s2/3fzjsMO7fqBq4S4QnmMfLcZcHuvEgB1iY4DUu+Wt0xXhEsgbxoJ07BMSM?=
 =?us-ascii?Q?ZKXJq6P/CuopVcAFwNnjOvRcXSaUisT+uXPt8YpEsbB/jTOR7K4QQirQhF5v?=
 =?us-ascii?Q?f8fWGnvEAgroC401cPMXWZ5sFavD4Tzwd1x7rpPby+EitYKZ+YFhPYsSJagW?=
 =?us-ascii?Q?YsKNzRqu3XdI9LOw2abceXD7e5qs2S0aMFo4Zq3kNIjJ3RdBzpO+Ih2RIz+P?=
 =?us-ascii?Q?PWUEAGk0ew3cv64GAky/bqpyDxn3ig0HHqeMywsyAuzEU7c45FTZlejBeAPI?=
 =?us-ascii?Q?ZB8ZuVdErbaXQiEdF4/+jQa2bSEAJl6P6HGT7FxH/O7Zs53fco1AkkiOeRXp?=
 =?us-ascii?Q?ayemcEgQKGAUGbNhEqlNd47rkWqIQjhyz95KjlgY9B4ZUuFRsJXeCEhyYOWj?=
 =?us-ascii?Q?rNpUlwWTnIvIEDh9SZYkOyxYy73bec75jONCxog0YEht7Q95sJS94vKv+G9/?=
 =?us-ascii?Q?YWlApXaBdSxYt57x9vzt/0wXHFqF/XXDNwgy4DXdnz4C5/mDTCEk6ZsN9vsf?=
 =?us-ascii?Q?jqwfHVx5SxFUX9uCPmeENix0xJ9jbBzOlgxPpCciP0HtmTKjrR/xFU4Xc6OF?=
 =?us-ascii?Q?kJ2b1Ea9NaFAvdBWw9Uo3fTxjBiDgSDOgkR40pFxO72h1+WeZqzGzx4FoorA?=
 =?us-ascii?Q?94cJBA+bqhtvuagKitX+FlxbfkAO4OdpvirSX5lKt6F0iYRgOz6gYG9GJQwZ?=
 =?us-ascii?Q?7OMvx54CEXdA/dvBt6wKAflu/F9bgScTNLaL5X0+EVzG+q55Lb8Bhkk8Gz0w?=
 =?us-ascii?Q?avHRV/BULhXuCl1jWG3XaWZFhCaiYavOw+YIdAV68mhuRB7m6YFNOKI3wSck?=
 =?us-ascii?Q?RwcMSxK384TLU5jQaTqNB588s9JjHnQ0/12mFvzoKF9CtgcsxqJbTVP9jlfs?=
 =?us-ascii?Q?07qPiWwuA+WVfr/0934MRKNd4WK23KYJ2rKCoTDD5RJdPpec80HRG0HAsI1y?=
 =?us-ascii?Q?SeXo+y5gTHWAacxTbwVZGg8OOdAfLdK4GbqB6bzk48gnwr8jZVb60YVHC2Sd?=
 =?us-ascii?Q?vHQ2cJ01Yd6m0CrVnnQRyLmOZ0pSSR3j6plLD1unfl4R9jGX3o+S9apWkxZ3?=
 =?us-ascii?Q?v3PSdeYVQlwVrLUmc91lDifD9bPKn78L7Gj8CeRpE6NA9ugbF8bE8YYc+WVc?=
 =?us-ascii?Q?mtsDyrKLfoIXnQcUcTDLeBrJnirE2PDofWl2EAGjeNt//eNvhJ+nYzLrsW0o?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6740ee38-4f30-47cc-ba45-08dc475746e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 14:25:35.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mP3E8splitnlAM6pJEixJa2AvEOJBmo1bXyhNqT0BW7zOIkwVmWEknW8kt617O7HS41ZDYxAhtmu6Q7eyAWhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8381
X-OriginatorOrg: intel.com

On Mon, Mar 18, 2024 at 09:29:47PM +0800, Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> The devlink reload process will access the hardware resources,
> but the register operation is done before the hardware is initialized.
> so, if process the devlink reload during initialization, may lead to kernel

This sentence still seems not so clear. How about:
"So, processing the devlink reload during initialization may lead to kernel
crash."

Thanks,
Michal


