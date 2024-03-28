Return-Path: <linux-kernel+bounces-123255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B85890538
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F5B1C2F90B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849502BAF0;
	Thu, 28 Mar 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y62Z7IPj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FE0339A0;
	Thu, 28 Mar 2024 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643604; cv=fail; b=ZunFvLloNOLsszE/MwwU+9TSyWtWGI9aqnxOSXTei3pwyKXPoi9OTjuPJDU8WUkrr/VWtqtgj+wXHhoevSUpARprPqvEx/ZUMk7OMNgdusp0b51xwQuwmbuxoZqLJ0DJaKg5/JQYe9pn3dNYfGKkIsEwE/g2kXN7zVuxxYtPkBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643604; c=relaxed/simple;
	bh=YhElyUclDVcOFI/81ac4zN86zP0dITvVhui8mDDXW1g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BDpZFQf3NHzpnMU3RfI+HupTYLS/KmDNn0spVB1mAlPIdiqapdUWXSp5ma3NuXdW+sYjv1DoS06cTXr6kUgv9lrUIZInNMd1+9un75vhafLbeQ63zcSQ0C41VRFD9SqpwdFnnxIRSaLOrLI+sHSLcvBehoQSJyeViq0NgFv9S00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y62Z7IPj; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711643603; x=1743179603;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YhElyUclDVcOFI/81ac4zN86zP0dITvVhui8mDDXW1g=;
  b=Y62Z7IPj9MxdzZbKDtrPbnYNfqXSCj6xVZmXtjPEHZF3KDkBGDfzo8CJ
   0jzYIUx6Q6d/5uliDG2qmCLjih9jDaLGRT3VM1gMHQDejBug6dVJ3Y5fp
   88TwvGgVKo02FzVqMf+/szmYrhZqGJGMvMNuQsgU/+clzQJPaDWuMfRGL
   NXCugVWS9W3oqfmD4oqw3fq6TVOjBYhwmUlkr4Kcd1G2fHV+ZVH/oSVVX
   QDDszIvTI2KzfOBL6LIuK4WufhhL64rLMTldTF+OpIv0lc6WFh2okK6or
   SW86Oob0JAfxafQh8DarZ1RKZrp8/8BGEHBKq0RYp7Br7lt6Y7yqcMwIk
   Q==;
X-CSE-ConnectionGUID: E9fyamaDS3Omw7lL4ZTejw==
X-CSE-MsgGUID: sRSGBOLTRh+4f1mpHn6kfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6743843"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6743843"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:33:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="47668948"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 09:33:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 09:33:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 09:33:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 09:33:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 09:33:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odImHPl156E80lGnA+5Zxk4miqCnwtLEefOKntFtUKPN2HurD8Kt6gCrS8pddLTty/toqmRCK5t7YrK0/A72YmFqkSgHx9WeP40w2lvkvp4lDhGT6ypScUeGxvWzuLa6fsVEpwmf5ui1AKAJUdJyS5wkSI1ymXQpJzFTFyMXYUdqUm2P+y6iRYxoRYFW7cpA+Yj0Cx2dQLoigrcMOm8mSmRUBt0VPLhljMJmdWv3s0br9tOj/68Tco2ZXEmjG4ZrwXjdzrFKPYM8ylIEt2ahbuzJW2dsaAFS1nrvwl8fEfouFkdHu5j+fvHyf1zozq20z+HPQoSjsH4XVVt9eJi9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGqlykmu4xIWE5ghK0BfaOTSFoHvTj9BJL8P1hVEpG8=;
 b=NheX3XUfl9tacWgSKq84KkO5uH5DUL9ooshvpnHWeTHlzkHPitBrQ6uvDBzH/6CdIWo627lDFX3WGFB091UPWme/BVxPMTi3LRVnHn6fXN89amUu/tEIHBd85otB+ZrKYgCHYl3xl4V0DwBVYUCkc2x+jCKJymP/mFCq7yjSmlfpwVOWnIUC6NirANJ18W8lqTL0W2JnBhCd0zzYGmfmhBy4wfQuf0D1G8lt1JF6OTTP9VM5EwpFaciEycafSo3QZdPX/KrdVwEZT+3Pc7OOV7OcD0W/Ms2zmAn47gPPhTv9YJQMPUAhACW0bzDnmLtSNwmF5wgibl3aNOAbVATGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB8349.namprd11.prod.outlook.com (2603:10b6:806:383::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 16:33:15 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 16:33:15 +0000
Message-ID: <6d228b37-fec7-4a0c-b888-6311c5e17c24@intel.com>
Date: Thu, 28 Mar 2024 17:32:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: davinci: Fix potential buffer overflow
To: Aleksandr Mishin <amishin@t-argos.ru>
CC: Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, "Andrew F. Davis" <afd@ti.com>,
	<linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<"<lvc-project"@linuxtesting.org>
References: <20240328091021.18027-1-amishin@t-argos.ru>
 <b2c6bc3e-11c5-4a20-8a30-666821ab2613@intel.com>
 <3fac7a3d-cd8a-4367-8ad7-206b850d2e41@t-argos.ru>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <3fac7a3d-cd8a-4367-8ad7-206b850d2e41@t-argos.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e372100-a075-4bae-a138-08dc4f44c458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqVNMt7NAi3aG95GvD99TQL058EU5lf1ISk1LMT082A6A+Gr+9RWsJkQP33ax7t9XymWu34xG0tJ7JOAZF0CY0qlhsByjqEc/cTZJQUzT5PCEjus7za+7ErcGMU6i12Qo4aIXVIPfPq3/lADlLYq+0sVq8gSk+GECM+m6rX6u62T0OHcAUEg179flFhGnfd4Qke2B9msRyI3oSIwryXmXWY+TKDmw916aROZPPb5SQRzgESzVB7shHj5B5tsN2P0Gvkm0+ZGZ3cZIeOu4iWV5hkOGgbDMfLAypA8v+oOd7FMo2NqOgX53oH05T5dNk8MVJtsLknK43kQxNjFpJuVd0dPy8vj03CeqS4rOd2aEr+v63Y1EanNXG3ytxSHLsKAI7ZQwD2VYSRoX1+1BTluoulnCTnu75Ztfm7seQ6m8f/62Dy0Bwgc3Mo4bMsIhdqpgzesAk1mD/RoIes4OJQ1lO1jem/FjYM18T8l9WllBESpuJu0IJLFf7fKmsorNfy7qD17toLe6UOMVTMSQy6YgUcpG9J0Ho9fvVhfF59axGxlowhNDdmF4Q3OjUioPRsiaTRxqLmlNUN91GVaMBCYBt16f0S7xoh+mxj4pdAAcTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVqbTQzOVJOc1hNYS94aUFoanpVd1ZwbEcwOXlDNE13bmlTQVNzVkY5cEd3?=
 =?utf-8?B?U21ja05QcHd3eGNHcHNEYWFkZlJWMU9sbitEeGdCS1ovQ2xnT0lPY250b0hC?=
 =?utf-8?B?RFNrTGRIcFJkM2VGRmFDU3NOdzNhYTFQOWNRNnl5cFA2UWtYNDV0R3Y0QkxX?=
 =?utf-8?B?OVgycjNydmNMREFPbGZUQkdqdVh5NmwzaDhhbG5ZakhkNlMrQjRZMG5MUGNV?=
 =?utf-8?B?RnNSR1YxOWQ2bjArRUFicVVaMXFaYVhsc2VFZEhWWS95ZHd6REVVSDQ1NlVz?=
 =?utf-8?B?NG5vRDQxN2tIT1BWbHMxaW56Zzh0d3pKaTNaWVFvdjBYbFdUWDFDUTl6c1pm?=
 =?utf-8?B?dGIvdThtVWc1ZWgzUWFraWQ3SHZRVlQrV2VJRFdnVnRmSDcraU1iUUNhTWZZ?=
 =?utf-8?B?dHI4R0FVWWRqUjdtUTVNODR2UVlaRStFZEtYUFJyNUVFdk51ejRCRWYwOWVk?=
 =?utf-8?B?b0ZLWTd6VXB4VXl2cE1tQXNISWZjRHR3K2hldlM5VmdGbG9DV0xwN0xkSnZ6?=
 =?utf-8?B?NDR4SExRd3lOUGNWb0lUdWpqbFJFKzJ2VGJabFVYY20xZ2lNQno2TjQ5bkpL?=
 =?utf-8?B?TnBDemZleWJqazZrVURzNUdhWWpnTFJuN3dlY3dEQ0J3NmY1WGI1QW5ta3lh?=
 =?utf-8?B?dDNRb0NZV3c4K3d1azF5SFNjcjZRR21LRUtDRzQ0OWRHelFpMXkzRXBhOUNa?=
 =?utf-8?B?b1Q4a0hydUJNbkFsbi9Kc3o0WjErWFh3S0J5Z3AyZER3Ni94OFVRRUhJYWx5?=
 =?utf-8?B?Z2ZoTUY0a0ZocGY5NXJhNm1hRFFVdzRibFViQWhpcWEzQ0E4TGsyTno2T0dL?=
 =?utf-8?B?VFZDNG9hT3V3OHpvL0JyVXhsRjEwTFZvTXB2MGJnUlc5eXFTYjR6dzNFeWJC?=
 =?utf-8?B?b1hJMHFGQ0o2RzVpd2F5UVFpOGd5ZVI1alAxNmdZMjFYUng4Q1orR3ZSL2ZI?=
 =?utf-8?B?bHI2RTR0S3lHU3ZSTU95RGp5MWYvVWVFa1hHTlV1SDhKd3dlTHhSOXh5OURs?=
 =?utf-8?B?L01zajEzWG00cTlwRjB2U2pSUzRTd1QxcTNBOUdPdENmVEVKVFdIYnNRaUJH?=
 =?utf-8?B?dS90ZC9ZbFJ2bVB3STJUd2ZLSngwSXg3MnF1OUg2SnZlbEhuZmVqV3NHYTJZ?=
 =?utf-8?B?T0tBY3pwTWI4bXFnb2Jjd1h6L3lZRytWdE95YjN6eDZFcy81KzBuNGJ2djFT?=
 =?utf-8?B?WGhJdlhNaGlhRlF0eUE0dFhPZ3NURnNRTXVOWVYvZmdSVXh6UG1wRnFZV2d4?=
 =?utf-8?B?d1lzamZkY0JDaWVFY250NTY3RnBjMnBWTldtcjdKR2dRR1RGSUJmcWFLKzJS?=
 =?utf-8?B?bnRNcXY1NG1ZVVRSZ2ZaTnhiZzA3ME5yRVRURFVDSCtld2tYZmpVSTlzNWt0?=
 =?utf-8?B?YUJURlhlQ2l5SFBrTGlDWnJpcVM0Q3M0aHNPdnZQcnEvT3hSMW9xcmxUVWJN?=
 =?utf-8?B?MlpqRGluTUozYnk0b1hWWnc0US8xUm1xOWN5N0xrMDZXZDlCVEZYRjBFS0gr?=
 =?utf-8?B?eEgrK2YyQ0NvMjNTT1R3RVkzWktOeE4rYnhwVEJRajNPR3RINWptTDZaMVJJ?=
 =?utf-8?B?OGdZQXViNXVHU3lycENEZS8ybDhFQVpxdHNsbXA1U1Q0MkhOTDdCVXFRNVZB?=
 =?utf-8?B?cGFhekhXSldaQm5XOFJyOE9nb2x4bGJRdERlSTdkdUNSUzNRUUhQRnRIQVdL?=
 =?utf-8?B?OXN3aUtCOVZ1V3JIVjlRSlFyaUFtZDkzUFBQVVA2UmJTQU9ISUVSRXhPYXdt?=
 =?utf-8?B?dGl0ZFdST0hJWVA4M25CU2swT09tYzBqQ2ttY1R2MGh3dDcySXVwcngva3gr?=
 =?utf-8?B?cnJVekl1VHk1azBkNzRQcXl0V0EvVE05c08zaWUwQ3o1Tk1yclNHc3EwK25O?=
 =?utf-8?B?SGMyaWxhdU4yaFFkbDNKZ2FBdGV6Wnk0RUt0QktIdDJyWkZ6ZlhmallrdC9B?=
 =?utf-8?B?K0k4Z0pTY0hOVmdoNWZ6ZU4zcHpIVDYzTDZJYjA3WWcveHNTR1dBZC9HVTdv?=
 =?utf-8?B?VEpsVG02bE5rY3lrZzR0M3g4a0NBbnBVcEw5UTBOeTFsU0J4VzY5RzRjNm1C?=
 =?utf-8?B?L0RzTjZla3pxcE5zNFZETVA2dExpNVRDd0UyaHdjTE5odXNQSUNyM1VaekJ3?=
 =?utf-8?B?VnBXSlN3THNMbWFrWHZ6QkZzWjFMc3RGTTZibWpHcEFDamprUnNmNHJzYmNw?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e372100-a075-4bae-a138-08dc4f44c458
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 16:33:15.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70SLbZbqw4g3atIzWnWZ2ZvbgS2xdkamvXpIX+Xfi28di3fZ3wYmMRnUETl3vKuQSNZExPBTiR8u2R1EBCguXpEggogfyX72gDEUOZd5CLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8349
X-OriginatorOrg: intel.com

From: Aleksandr Mishin <amishin@t-argos.ru>
Date: Thu, 28 Mar 2024 19:23:56 +0300

> 
> 
> 28.03.2024 18:27, Alexander Lobakin пишет:
>> From: Aleksandr Mishin <amishin@t-argos.ru>
>> Date: Thu, 28 Mar 2024 12:10:21 +0300
>>
>>> In davinci_gpio_probe() accessing an element of array 'chips->regs'
>>> of size 5 and
>>> array 'offset_array' of size 5 can lead to a buffer overflow, since
>>> the index
>>> 'bank' can have an out of range value 63.
>>> Fix this bug by limiting top index value.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Fixes: c809e37a3b5a ("gpio: davinci: Allocate the correct amount of
>>> memory for controller")
>>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>>> ---
>>>   drivers/gpio/gpio-davinci.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
>>> index bb499e362912..b65df1f2b83f 100644
>>> --- a/drivers/gpio/gpio-davinci.c
>>> +++ b/drivers/gpio/gpio-davinci.c
>>> @@ -257,6 +257,9 @@ static int davinci_gpio_probe(struct
>>> platform_device *pdev)
>>>       spin_lock_init(&chips->lock);
>>>         nbank = DIV_ROUND_UP(ngpio, 32);
>>> +    if (nbank > MAX_REGS_BANKS || nbank > 5) {
>>> +        nbank = MAX_REGS_BANKS < 5 ? MAX_REGS_BANKS : 5;
>>> +    }
>>
>> Static analysis warnings make no sense until you provide a reliable way
>> to trigger the problem on real systems.
>>
>>>       for (bank = 0; bank < nbank; bank++)
>>>           chips->regs[bank] = gpio_base + offset_array[bank];
>>>   
>>
>> Thanks,
>> Olek
>>
> 
> I can only see the code at this time. And I see the following:
> 1. In some configurations CONFIG_ARCH_NR_GPIO value is 2048. So nbank
> value can be 64.
> 2. Previously, a patch was proposed that removes restrictions on the
> number of GPIOs
> (https://lore.kernel.org/all/cb540a9d73cad36d288664f8b275c6308a4a3168.1662116601.git.christophe.leroy@csgroup.eu/).
> 

But no real hardware / device tree which declares such huge number of
GPIOs, right?

CONFIG_ARCH_NR_GPIO is architecture-specific. Davinci is a platform, not
an architecture. If no Davinci board can have a number that would
overflow, the fix doesn't make sense.

Thanks,
Olek

