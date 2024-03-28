Return-Path: <linux-kernel+bounces-123151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A0D890307
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D56A295EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1246112F586;
	Thu, 28 Mar 2024 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnUc8L62"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1A7D3E8;
	Thu, 28 Mar 2024 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639673; cv=fail; b=MoToWXq+2Y6rCnP1oAFizyDIiqCJnwlF2GPv+cxH0iQMcgGJ3dOcz9nlsuQq+owHa3OmytjCqyKb+FGbIYGevft3temvmfdoMLLfBGPrz2aeumGiNU7u5ZYKoU+KIJoiZpxLysW85IblTcX22KG9RXXTkxU9cTWLHC2uoh4pIMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639673; c=relaxed/simple;
	bh=9Co/cKBUPibmlVhTS6hUuPieQz49n7UsvqTqez+Q2e8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IQOM5axuO4tcr2dGVh+lz/GThJgTAgJ2ykszehHKI5Q/rusPPH7mmlp25UM2yDjSo7EhU3NjxFRbdGIBUW/M7iztBCkvLpav95FAug8oypMkYX3YjT6U3oh+swe16Wa6L1hbAajCoGin+BqC18nJyZFlrskoKkEGrVIErreFdIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnUc8L62; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711639672; x=1743175672;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9Co/cKBUPibmlVhTS6hUuPieQz49n7UsvqTqez+Q2e8=;
  b=dnUc8L62CYgU/zTKomVhCiXwzjFHeP08cpg2eCccx4vxIdRSmDdQbUri
   rKe1X6RdCJmdvSEVv58d5HuRRa/WU6WqLuBVCpDxnBSon+bFrhOyvcotu
   aC9Wtjxw1hSitdI8U4NTV5ZX+xLLuYJhtb19Mx+pP8TYgFpl9GfXSuVQf
   d9ZcNb+BizZf4CCdl767LCjHDu/73MwrSW0CezYU8sL8oHDAqiUVQ9ZjC
   6fHRmMXsr64AAFP8KWG4gPdpYIkJJKxt/n+jR/0Nw/DpIFDL3BziJufxe
   d1JN1YYDDJCKhIGuUG8ODYTE31SkKiCPeSWJLjv+RzLwXbqlod2UhZAht
   g==;
X-CSE-ConnectionGUID: CjUDqyO7QZGb23jibhh7gg==
X-CSE-MsgGUID: 4wTrHaErSyuahK2Vo5hb5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="29283241"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="29283241"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 08:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16741365"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 08:27:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 08:27:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 08:27:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 08:27:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1QvrUN0Q/dclOaGBYEXFpjWKapDg9MJ2FxiYdv+5aAxMcxRM8w6EsE0ptn/fg+dy+Vm/5zPDe5YZqXrHCrxUX7beXuaPsylSSpW4vfqKdk++uAtx/pC7RDvvtIadZHUvUah/Vduh7OI1h2hsColAZYIgoQQxWP2uQUt97K88ISOVWdbV+S53KDDvesSSZKvuLCjZ7tUk+ph/EhRQsjWylNW9QHanlkJ+TAbvB7Bx+1zv7dQkugVemU4j10lASKGhA44kQ16FNps6VMAWxB3xu8+3Sd8ezQicKPF3N0kaOjjE1xSuTOh2hW16m2PBZ80D6UyjikU5RLUv6IW/tKvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2rW2LM0W4Fot9nbPp+sza5eXygJjePY7kSUb7o/B7M=;
 b=K6hoZvCwn2G4e5hz+w4or+G/TPkWmxI9L324FUH4vQQaVLWxlLNI+8qroJTgVOuRfG5Q3dLlqBctUqzh8oJpMmUROsR+niUWvXFe8djzlXanhjRyuyC6cNNjSo6Zp3qumTVUxb/dBdSF2lYOTYU95bBjo12SwaGEZ0QR2wDwXHaRIdkzgPVTr37JBO56ffxoAQ4e3MeSKDo6lnG8kQREjLNk5nqM3XQPydO4bBOzonkC8VplWO6uYB0JGCR1gpxCDvhCVsLfDJmtPug931oElOtdapblxEhSvA2i/swmtSbUn/oopslPhDbAxS6Ei/z8gURnctGXgVU9w5R3xFbPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 15:27:47 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 15:27:47 +0000
Message-ID: <b2c6bc3e-11c5-4a20-8a30-666821ab2613@intel.com>
Date: Thu, 28 Mar 2024 16:27:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: davinci: Fix potential buffer overflow
To: Aleksandr Mishin <amishin@t-argos.ru>
CC: Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, "Andrew F. Davis" <afd@ti.com>,
	<linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20240328091021.18027-1-amishin@t-argos.ru>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240328091021.18027-1-amishin@t-argos.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ2PR11MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: d08fa24f-fb98-4596-ff80-08dc4f3b9f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZDrWtgNkNlP5KUkftwcJCsv7mgf/TWdpkn2W639H6xUkqXKfh+EJVWHRMbyR++bEhrH4G+d9t1hUJD5mTHCKGPjC+DOyopGMo/0uZGRxwe14C/Da0gTQ/BPf4b4fjfIQNuTPAG14Rx6ljw0GSr0BXlQkZluNe7VM73vLs+3U/2KzSSxymZ/vaJaEmtap1vM7o9ESiC2d/tWD3z3T5qa6srnR5aq+ShPaU8IbTS+DV9IN3MUDLLaUCCUZwBiPCMhQTYGDE8Xf4sITAX0jFoKP68rUbWWfqAesRM4a+D+ZkCUBSIFpFlCG293MSZJqgn0DoRsKeHiIfsGXxOEsek+EuBM8kSLC1BeoZX5ssdet5H4ir6YzxH59cRLshZARXL9kDW/H4NZNesfOhillWRoRWlszQCKozW/JRBvc8zmG1xR0xs9eYEI18td91QIG3l18kSj0bNuoo0pxGWBY6M/TZQvW5rcGYBuE90rcvCs/KikS2vvd8hrN9IuLNOTBr5yWYxJNXYwz6UScjkmQF7xh1hJe5h5ekSQGWFK2iLBvF0qNBafsM7pdaSRnzSzVX8yPXDY9Ub8TqeE3b0e+3v4t2D9thgnNn5PP+DuYJn8pIaeJgsMjDnehOaoLQpWKMFtsgR8TwnCfbvbGyYdogSU+ktfq8aqrwgGU9F84gcfZZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTlEWWFuRUtXbEVOZzU5M2dXVEV1dHh6ZDZlU3Z3aVlpa01BdHpRVTZkWEZ5?=
 =?utf-8?B?OXVINVh4V0dEZ1hHR25TbUFKTXREY3Zldng0N2dUeS9wMXpmVlZVeVpaZzJv?=
 =?utf-8?B?d24ydzdQNVNwQTVZMW5YbHE3cCtwa0Q0R2wydjdZdVNoWTFPbTlsQTJqQzAw?=
 =?utf-8?B?Z3p6R2UvTUg3SVc3RTdRSjZuNFBkeENyMDBCV3NIWmQ0TFNxNVg2em1oWnNO?=
 =?utf-8?B?WG9QbUJpblBPelZ5ZWZHVlBEL1hIU1BUNkJoOGowQ3Z2Q1NocFoyY1M0RWYw?=
 =?utf-8?B?OGZReTdENWxOdGJiY2VmQWF3NlJFbzBvZjNkY0lrb3BLUFJ4KzhhZi9WM2JT?=
 =?utf-8?B?RHdyZVU0aTdjYjlGTkFSMlNRSGExS2dDa1lYakZ5NG12TzNvb2NBaGJ4L3BQ?=
 =?utf-8?B?RGg0OFVTTERjQnRRdjVXTS9DNHBhOVZ5WHREUXdrdmE4b05oNVFveFhCNGN5?=
 =?utf-8?B?ZVFwaWdjSnlNYlA5QUJaZGVsRWF1cUxtc2V5WFVXVmN6ZlZxdTJIb3dSWXBE?=
 =?utf-8?B?OE10aEUzWWQweVl3TWxZYi9lbmFZdDhIVTREYUM4RzNLMGNJRnh1WW5JcmV3?=
 =?utf-8?B?aDR1VXQvUytFSE91RUgrWjhra1N0amwrU2FjMkpza2hTTmVkZldac2tYeGZl?=
 =?utf-8?B?VmZtWUZJa2lKQitYSzh3NkdKR2VMQ1V3V1A1QWpsd1hneHhRbXQzYWY4SklP?=
 =?utf-8?B?Zkh4elVpRVpkdCtrSXZzZHJuVG9saEZzSDFMQkJBQk1xMzFBSFlURUtEMC9Z?=
 =?utf-8?B?aFN4NFFBTlNXZXNWTGV4bGFzNEFPNVRNQXV0RHlSTk41aS9KMUFZZ29CdDZB?=
 =?utf-8?B?SmljbFVTdEpZTGtEVlpDdjI2WGJzRTRVTnpZQ1E3YklVcEdNeUxjWWZpbnly?=
 =?utf-8?B?dEFVK2hOaXludXJsMXJ4dTU5U0RnUjdlUTJmMUtIOC9uNzluMStEclhSTmRN?=
 =?utf-8?B?YkZLbEo1M3VrSisrZGwxUklSaDBvZnZnRlpsRVFBM3EzZkpOakFMMGI0a3Bv?=
 =?utf-8?B?N1NtQ3ByNEZGR1dJbURZa0w0ZHU0bWpwV1ExQXNWVnl3Y3UxNitObzI3STNZ?=
 =?utf-8?B?RG5BTEllL0FDY29YdmptTndNcjAzbmdNSlpDQTVkZlRxUTBiL0JvLzdGMStT?=
 =?utf-8?B?Qm8xQXU3ajV5TzJqc3JReG4rd0Q2T3lQMkFvQmNwN0psbVhyY1N4a0cvV3dZ?=
 =?utf-8?B?bjM4MGZQZXZPWGE3c3hYZmgwNHJpRVlKOW9uK0ZjaTJOTjI3TmE1VEpiZnpq?=
 =?utf-8?B?RVc3bFZvUWlUdis4bjVMVVN3N2hpOW5SZGFreThRQXpiL3J6Z3VVclJQdVVu?=
 =?utf-8?B?UW5zd0N1NllPb25Oa0xXSnlpL0o1a1pjRE1WeVVBazloNDB4cEhnMDBEV2Fr?=
 =?utf-8?B?WXlHQSs1NW1zT0Q0WmhWaU9DWk84a2RxQ2pONkJndXpRWGdXUEFFdDRrTjMx?=
 =?utf-8?B?TXllbkpCeXJYVE5PR1JlNXFqUTRKZXBCeDhxU05tV2xvdjlEdUJUbFByeXBq?=
 =?utf-8?B?R1FZd2xnZXlQVmlYb2tzaldPYUFJZk9pQWh3YjdWZVpUM3FEdUJ4Qnh1TUhB?=
 =?utf-8?B?NjBYVXV0eUpKWDFRbHRmNkUwRkFzMDhFRVNINnFhYkxQbEViWm5aNkhYdFhv?=
 =?utf-8?B?ZDROcDhOaCtFWnBJMG9DeitZbEhJUWhiblhYNTU3ekYvb1kwSnk4WFdwdmRh?=
 =?utf-8?B?b1JZZW1GaElYRjQ0YTVZbFRBR3pUb2VlRzFBZzA0MlZxS1VXRjNPY1Y0dkQ5?=
 =?utf-8?B?anFYeDc4c2xRbnhBVUVHTlpkY1lLemJSNUtQVGtuL2JwQmZuYTlRakhuVWx2?=
 =?utf-8?B?eUtwcDMzdXEwcmNCdDIzdzNSamxSQStZOXJkZnh0d05wbzBLa2MyenJSbkhK?=
 =?utf-8?B?OEtEVWdmbTVudk44VnN5TDFySlhHbWUvMThvM3NzanNEU0I2bVNid3lHQ1VQ?=
 =?utf-8?B?NlYyUGJZYkVKT242cWQ0eENlNUlOSmVEOFdJS1QrL21LVkU5ZWZaRkNzeEYv?=
 =?utf-8?B?RmhhK0duWHVSMkpzMElzUUplU3puR2FZNHpIY1N6bEZhMWRLVHM1cDZtcFFn?=
 =?utf-8?B?VDhyZm4yMzNvZis5WXB2cDh5ZDh6TkJlZ3d6dGhFMVZFNkJSMDc5d3oxN0NS?=
 =?utf-8?B?QjBoUldoUE9KOGJ0dGtoSm9ZWGlrei9PYy8xT01HSUZGazdMbjViZUk0OVVM?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d08fa24f-fb98-4596-ff80-08dc4f3b9f2f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 15:27:47.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnYyqUGxZUmYx6bRtuu5L+MlebeJa/y+IXD2WqjiX0g+hYOnGU+mgWVCBnEiSyiVIzzkZtxHcuYDX4N4ND/ZNwyU7fXeFZnfjpPYrqL8kzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
X-OriginatorOrg: intel.com

From: Aleksandr Mishin <amishin@t-argos.ru>
Date: Thu, 28 Mar 2024 12:10:21 +0300

> In davinci_gpio_probe() accessing an element of array 'chips->regs' of size 5 and
> array 'offset_array' of size 5 can lead to a buffer overflow, since the index
> 'bank' can have an out of range value 63.
> Fix this bug by limiting top index value.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: c809e37a3b5a ("gpio: davinci: Allocate the correct amount of memory for controller")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/gpio/gpio-davinci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index bb499e362912..b65df1f2b83f 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -257,6 +257,9 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>  	spin_lock_init(&chips->lock);
>  
>  	nbank = DIV_ROUND_UP(ngpio, 32);
> +    if (nbank > MAX_REGS_BANKS || nbank > 5) {
> +        nbank = MAX_REGS_BANKS < 5 ? MAX_REGS_BANKS : 5;
> +	}

Static analysis warnings make no sense until you provide a reliable way
to trigger the problem on real systems.

>  	for (bank = 0; bank < nbank; bank++)
>  		chips->regs[bank] = gpio_base + offset_array[bank];
>  

Thanks,
Olek

