Return-Path: <linux-kernel+bounces-117758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E03C88AF2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF5A1F663AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9495C96;
	Mon, 25 Mar 2024 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrLgRcEq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6B4A21
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393258; cv=fail; b=jneQvjHuhG5P82XjX23EhthZQtDEcuMl43HLDx1MJ5wUZdTkPObrk1JTbeusPAz5IUuX2U3gM8+CbLiKMGxvuBfeoEh+GddxHWKfl5J38ZBs1LNqn27SS8zt7WW2e4HQiJPid+56DHmAn8vuAQeKZGwTxWgNQ0MggmO62ouZCaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393258; c=relaxed/simple;
	bh=mgB6BCBU9aayva8OqvM6VVzb2DJoQiQaagYBVf+GcDE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TE8S9QmfPhuJva9ek2L64+Mrv8RjVVnARRH4ULPO7BQPudSJE1otUzXpEFlm3pPLKZUHHr6A3PWXtEiE4irqli3uJ30lHzIYFWn9WXUZogEY5sPW0Vnbh0A+HVsaHR3wE0FL4GOO8r+UAHjiXX4gPym+OYMko5X9phTdi/uOUZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrLgRcEq; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711393256; x=1742929256;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mgB6BCBU9aayva8OqvM6VVzb2DJoQiQaagYBVf+GcDE=;
  b=TrLgRcEqHXtC32h0OLgft7mSUhP2bjcXkPoabzzsHLjUT3Cs/SA2pxgu
   sFsxVNfxLEK01bsAp9WQ3oGkxvuaZxKCH+SEpy5n9lDVSKaXapkOfvT4g
   xjL4wFnmex+KP+xDj+wrCxr015jJDSm4PQpNVG8fpk37GOvowelJRjGTn
   yz1YJTvOzwfULlJUlLW8sbrN9kaFWRXtNlLPFGhRBK5vxMHznRXV752eO
   X8pD+DIly/sV4i9xeItvKe0fO5DdzBgomNbzbzjKJzUokQ4mz3jXOeBRe
   Ry6ZKcsrhf01R8ACrJAJFSmeyLyEwxx/wVw5X+Zic/fzeUBjA9IguDsdp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6527061"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6527061"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 12:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15607412"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 12:00:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 12:00:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 12:00:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 12:00:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpSSMm7PS3kO5TYxrvjQc5s35iF0nmjrkgC3fOf4mM11DFtT15YPSto3rELQgaidcDQMs12V0DK6YabzoAEU43JQ8SYbmKePtW+oQPAi558GzwRltCkWdOwQMJUoYYS9oBPDufoJ3ibxZn13VtHHv3cmV0VtgNEx4x4rR94gQXGs3tkCO84OJwZ2MRj1ac34NVk9wZ/RbAkyWccx10uv+nGOJ59C5GwXQeHYBEktkkA0AEsn9wNsjfannTY+DPoNWyItf0tQvfnUV4ZCHe8Kt+9tTkO4oPu95ZVd8LvLDMA1Cv9yK46P4DiXk1k6+5ul5d7qpOAzkue1IYs3qxmV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPvXlSTN5p6jBkjXmyT6TWNbMFmRWluz4SX1qAS4cac=;
 b=WXe/BdVequTzdTgaQyixggGMxZBdP418dYxITHTfUAZ6lOipjuhb7xTxxk0tcdHm0rA7oQw1engEhhge6P6uOzsuEhXnv+UDErC+1fRcaJnkYw44YLiqNUWD0NaYdpdFXagm0UyIi/GFb8J7LjuvCmDY0sp/hfhdojXUpMY8Pl49KxoHZlWgHIG1SV+5yPaI3JHEskrFXPufM4LtGqNWbGpwteBd25aV6jiRkXv37zYAqS1lqCqPhQzSgidoo/lOLWpdKi+NkXd7WG7xEIR3QF7mKRvLTg6kvvrsnku/KgUiGtJcWFQELuX46I6YFnH2cZXTgHZLiekP6mfyOd9g0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 19:00:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 19:00:52 +0000
Date: Mon, 25 Mar 2024 12:00:49 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, <jiri@resnulli.us>
CC: <42.hyeyoo@gmail.com>, <akpm@linux-foundation.org>, <cl@linux.com>,
	<danielj@nvidia.com>, <iamjoonsoo.kim@lge.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <mingo@kernel.org>,
	<penberg@kernel.org>, <peterz@infradead.org>, <rientjes@google.com>,
	<roman.gushchin@linux.dev>, <vbabka@suse.cz>
Subject: Re: Re [patch RFC] mm/slab: introduce KZALLOC_FREE() cleanup-ed
 allocation macro
Message-ID: <6601c9e161df3_2690d294e5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240315132249.2515468-1-jiri@resnulli.us>
 <20240321162648.23693-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240321162648.23693-1-przemyslaw.kitszel@intel.com>
X-ClientProxiedBy: MW4PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:303:6b::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4855:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIFQYswMv7DsxqfF9kgnc63uaPm2nmq7KCR1SCnEn/9Qnha0SXIrW/yQN3WabP2XDt4/5AU0GeDAsVDdmq9zKJ1R9zD1PGRQ+pXH4UrrDKLjQBu6dW5CcfSbhKW1J+EQFD93OV2+jmn/U7407+irGPigndbPHeAf8lqOT6WzNTJ7qUypjxPfHnDcSYCx+n2lq2bPntml2I58BsKumUJmP7ueqpVfM2O6jJgId6J0ttMQZlTRn+85HKAprHniRJS0ajJSvNp+wIn0vET2+dDSO/HkehJST5bNea5Zuam5H5xwMr9R9VwbZ1bL+00kTGY14wfanS4PFRhHMc4T/edaTMBwQgWal6ICFlFxBo1dKpaBXxU7ay/19MksxOEILNINiP7H3tYjt0srmc+z+zBH1yp4/IrNAVVfkzMFpLpn5hWVFNUykiwt6Q8pMSPZa4kR9ZyxxErmYVotZzkCLbzNd+GQQkwhRHYBWO6vpd/LsklUM/4op8e1QspQkxavpDuRIvjfoaKJc3TEGVG2ykm5U2h1SClocAYCQamMIrt5MmOSMWwYp+Hbm/TltBZMbzvvWhJp78BTfoPsOCjMH5FgLuClDvqvCJ3R2h/Rtn+uMAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k32hxxinQV9zeRTir7+hGmmbdQB4VOyC4ZByMl8q9fEz9RUEQwOT+/NrA6s0?=
 =?us-ascii?Q?ZUaOzQ1HEQIodRegXeo9P6/AMKk/iZMnvCJRic65mTnHceCewMVNAkLaWSt+?=
 =?us-ascii?Q?oO0pB8vqvvcS6YU9SRso10+AIJCHX7HqBpHwXme2ge0x1xGDEMw2XrPLflyn?=
 =?us-ascii?Q?cDVkWQIb2rj+4IJ3dbm4zFFbDS8dpPQJuJ5Xs10/GwGVXJNW8MKyFNDeSNxi?=
 =?us-ascii?Q?QCptwPtV9MDg3do4oFaEQNK3tmTOyyNRsO0nTufusAhSd31E44rhrXajl7pY?=
 =?us-ascii?Q?MgB9wzz3GF4MKfwrNbYpL7VbUQPt8vPYDJnKHu9FQibIFpCBDZpFokwVgKV6?=
 =?us-ascii?Q?vS5X2SER0nYMzw767OFy/GZhDjvtNfGW3X+Uvx27hj5DLpFsnwzHEzyD4u8n?=
 =?us-ascii?Q?GTtQN07cTdiCfMZnchbmEUe/Yu0iPN0FGpD0s+zftW81xJE4yv3qFW+2TFMj?=
 =?us-ascii?Q?mHOIpHoRqAfDiDIVeYWM1pZayMr4iq/dEUaXbP0fwONlhlnKxKdYNlGTOoC8?=
 =?us-ascii?Q?FTFdkLeOurBcMrR7/sgQXyZJPkYHR1MrTzwqhWSUXNAMenG7d4d27vgBLWRO?=
 =?us-ascii?Q?Qe8H9WGMpoAbRhXdr+TIp6mDnjt0OVozjmZ59xpysnN+Rq4JVIugHSncP0a8?=
 =?us-ascii?Q?kyhC/8cT3CBsDOR5oGgalnyzHfhYlmRyG7o0ExgcLWWhgeoxpmp/N/fuzK8g?=
 =?us-ascii?Q?B4laat3xWPZ+a3q6aTAnyTFe2gWd4bDLft6DsqgvZ6/L2pd4m9ezhHRjKuR0?=
 =?us-ascii?Q?RBxRpY3G9ztc5vY774ltPkgucX01sOgbV9EbNC9VMbkLo7650qse14IjIVxJ?=
 =?us-ascii?Q?p3s264Bl09BiPJIju0iZZWs22DGI1sXDKNZMBHgbPljHrgAfIXngCrFsXbRU?=
 =?us-ascii?Q?q+P/UaUoXAsczJe5QlkD+46OGEIJITJQTGMODnU1M4EyrepwB/+o/WqZeOKz?=
 =?us-ascii?Q?3D994P9myVwuIjZArI8Qox1hvNjB0oA77bDby4SrwhmTfg88/UQ7XXd956DN?=
 =?us-ascii?Q?ViXUFwzf54gZXxP+sy5NrTgMsKEE/U5c+Vv/0fnrHizcC0gfFiSncKUcUhb7?=
 =?us-ascii?Q?ZDV5du5fSxKgY7tP0iZhCFUtc2bDkULY4nMnqvdBGpa9brsxXEcXx8Um4RO4?=
 =?us-ascii?Q?52T4iLct6R9ODT8lQvhYnl0Q0q1f9X1l/75Ws4te66i7z0iKpJ6309xebHHF?=
 =?us-ascii?Q?/8s9UbtysDpavz22P4Jb/yJYspAxOw6OsOdBGThPKVylUAHPSMjBi0Juu1Hq?=
 =?us-ascii?Q?Pb7MQtyAbh5lgd/HcCxQnRJsWMDLDzA/OsshQRgTqNLz7ZVZDTD4Jai/8vaD?=
 =?us-ascii?Q?PhWYJo7xy24c2BhoKcz2pz3yZKjPT6GJpv7NLOy5nxCwG3F2SlDv+1VmQYPe?=
 =?us-ascii?Q?pCly3mtmxo3PnXEGFQeRV64BeZZ5Oe7fq7fKwKhaIFiBHowqmMaRHD25yS61?=
 =?us-ascii?Q?oIkNlcmvM+JSbHdDLBrfkHz+ZqfRxPqLJuUasGMzb5FKVcNyhLSzq5xzSSS6?=
 =?us-ascii?Q?Igczb9GikyKbjbRlWvSY5yVsbt9kfP/7lWefDmrMvAYmKlMh+M8Aq27YOgqJ?=
 =?us-ascii?Q?jNLMqc/KW4iQWR/w8oQ/f+UsqIT3deRkdf2Kh6FFTjFf6mSS4GTu00a6Buqt?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5620f0be-a4ba-4e62-d08a-08dc4cfde451
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 19:00:52.2263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBhSXWuYEp75K2vNchKgyu9y9nKndrtD5xqHfYyig+LU+IIvkXkq7F8/5fqAACLARkkyCLKcum8V8kEOLgmkJMtMkSdwW9vRfLb5Q1VX5m8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
X-OriginatorOrg: intel.com

Przemek Kitszel wrote:
> > From: Jiri Pirko <jiri@nvidia.com>
> > 
> > With introduction of __free() macro using cleanup infrastructure, it
> > will very likely become quite common to see following pattern:
> > 	type *var __free(kfree) = kzalloc(sizeof(*var), GFP_KERNEL);
> > 
> > To follow the CLASS() flow from cleanup.h, introduce a simple macro
> > KZALLOC_FREE() to wrap this over and allow the same flow.
> > 
> > Show an example usage in gpio-sim driver.
> > 
> > Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> > ---
> >  drivers/gpio/gpio-sim.c | 3 +--
> >  include/linux/slab.h    | 3 +++
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> > index c4106e37e6db..997237b3d80c 100644
> > --- a/drivers/gpio/gpio-sim.c
> > +++ b/drivers/gpio/gpio-sim.c
> > @@ -1496,8 +1496,7 @@ gpio_sim_config_make_device_group(struct config_group *group, const char *name)
> >  {
> >  	int id;
> >  
> > -	struct gpio_sim_device *dev __free(kfree) = kzalloc(sizeof(*dev),
> > -							    GFP_KERNEL);
> > +	KZALLOC_FREE(struct gpio_sim_device *, dev, GFP_KERNEL);
> >  	if (!dev)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index b5f5ee8308d0..baee6acd58d3 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -711,6 +711,9 @@ static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
> >  	return kmalloc(size, flags | __GFP_ZERO);
> >  }
> >  
> > +#define KZALLOC_FREE(_type, var, _gfp_t)				\
> > +	_type var __free(kfree) = kzalloc(sizeof(*var), _gfp_t)
> > +
> 
> Nice, but I would rather see this wrapper in the cleanup.h file, that have all
> of the rest of related stuff.
> 
> On top of that, I want to propose also a wrapper that is simpler in that it
> does not allocate but just assigns null, with that in mind `_FREE` part of your
> proposed name does not sound right.

No, do not hide assignments within macros

http://lore.kernel.org/r/CAHk-=whYxkfLVtBW_B-PgNqhKOAThTbfoH5CxtOTkwOB6VOt6w@mail.gmail.com

I.e. the amount of incremenal cleverness that include/linux/cleanup.h
will tolerate is low. Any helper should look like typical C.

