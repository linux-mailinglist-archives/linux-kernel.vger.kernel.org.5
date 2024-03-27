Return-Path: <linux-kernel+bounces-120426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5108288D72B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048CC29CE42
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE16728DA5;
	Wed, 27 Mar 2024 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfwdH+fo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4C16427
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711524209; cv=fail; b=u9yRpl4EQcfWe++zdoLSHKuE6aXRj1cTINYnjVQmTVP31SAUvFIp6DxapPjmhy011cVULXRalStJF/MGqwOYvQtIb95GD6SiCriiHa/zU3+s2dr/gULOD5UoCVGxaeLER7B1gI20DwmQwRjwjooYKP1S61/vEYl/jeCEVx2FrEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711524209; c=relaxed/simple;
	bh=pk1nTs/zfKmDq1d6QmoxTa/Xa2s7LhivS1k3hPAhqMs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fICoflSEchXcH45qwbFytMnhK1t93ED5ljROfi2AGvwVwZJC8U9hToN2vsZr3GZJeqqG4Vh4ClG+B/UkM6Je44vnoi2cFp0XIJClq2SkileNpaxgih1KJ2VsD5H6xhE6W5sBTzSzf2hkKWwAwzrgyUi1uYZnsJ0xiSugsZ927j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfwdH+fo; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711524207; x=1743060207;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pk1nTs/zfKmDq1d6QmoxTa/Xa2s7LhivS1k3hPAhqMs=;
  b=lfwdH+foG6/NkcmuuVKJPLSmzxVWUqkjg3enVnyU5sijfVBBz/xaP2bO
   3sCSox/+pyyzJDFq412X63hxnklMZuYA1xS0g40NIcvYJiFln9wj8Ht3s
   JHMMLXdqD2udaht8trq0oXcfH/GjtA1f28g/ePspHKjMSAWyq5ln+CjNo
   Xsy4qRSWUOXSLg8R/II2VUQHnnD1w8fsf7fgfXOBCA7TCOuaofn1VZsbK
   IMiLyRlSQSsnNAbP8ggMHc2ByZhi3t8oe1fJVtTB5C9/xjsrDhnswqPTB
   Lo0ljtSAgBs8op7Ts2Wt2bp1gPemSeONO9fzGnDKsUuKJK8yxTLyyrPvL
   A==;
X-CSE-ConnectionGUID: 8LTg+6n8SySs9Rr2kuid8A==
X-CSE-MsgGUID: mqvpY0VeQGiS27qYuCe4tA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6738888"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6738888"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 00:23:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16304377"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 00:23:26 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 00:23:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 00:23:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 00:23:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhUyg/cTpi7ZZ1WnjKPCqePw98KPD/1ZxoAhp1QUccfyXPCKT2ZcnVgizilYqqv+iV5eTTKGWDKOyQFcn0E1gHjQNB3AB0qnJNdw8PCKCfSrSZy0TBmi+8BXsd/q493MJHNkBRg/oeyjgH40eQpUDMzwaBJbDI9otGtlqKcTr2XasU9BzViCQAKMTV6S/I2wRHcjZzGtpDiUKSdppHpP1IDy7dk+58jMGczqGGu5Q5ChGE+c7ZWABz77yiX2fLm1tFYgh/3ulpOTcEmJjghS+KniRdVXKrxUWSdvF8NyH9P2TGGx4c+oefUeKvJ8tceNroX/jDUVD76lKShmtscdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBdXvE3wRSBplABmuOmzS/nTE1Rw3lhDWj4CkMW6YDQ=;
 b=LRupf0kPZI6lb3laaus9bTnGlNf/VTUNIoN8ZEKQGi/rA9sKYRZxh8g2zFHS6E4+F+VdHh/soXuQLVg6pzoLZ2cBFg4QlQoDaeP2Godhiiwv7ddvBOL5SKeCCdcpzfMvIk9wEZQMB73nlTKb4rWmbJ3VZ7UOKQf35jM8j0XxopAFNQvq6DkIEgQ4bvN4t7tZoCqEVYZhWrjGHOvs9I2/cm7lgWOAJ2cLCMuiMKnK3wM/faQSBx1MD7f8gamWo4E4xrUoaFXQ3C3CvFY6XXiKezTxopFLzVR8GPMG3da0gT/TQptDa/AHlft+rKG6SDcUr9qIUhWC2Wvq2Y+Yh1TMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB7100.namprd11.prod.outlook.com (2603:10b6:510:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 07:23:18 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 07:23:18 +0000
Message-ID: <b4f73aa3-1d47-47c9-993f-43a7a7f27d7e@intel.com>
Date: Wed, 27 Mar 2024 08:23:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Re [patch RFC] mm/slab: introduce KZALLOC_FREE() cleanup-ed
 allocation macro
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, <jiri@resnulli.us>
CC: <42.hyeyoo@gmail.com>, <akpm@linux-foundation.org>, <cl@linux.com>,
	<danielj@nvidia.com>, <iamjoonsoo.kim@lge.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <mingo@kernel.org>,
	<penberg@kernel.org>, <peterz@infradead.org>, <rientjes@google.com>,
	<roman.gushchin@linux.dev>, <vbabka@suse.cz>, <torvalds@linux-foundation.org>
References: <20240315132249.2515468-1-jiri@resnulli.us>
 <20240321162648.23693-1-przemyslaw.kitszel@intel.com>
 <6601c9e161df3_2690d294e5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <6601c9e161df3_2690d294e5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f62f67a-39cd-45c6-615e-08dc4e2ec61f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPlPVbXes5BDcBQjAOcMroBLxwGH1T9JoqWEZtMc4cnVSTgxQx3IcCF0JrGD9Qa99qHZ5bT/2GOYQ8NCTuwy9YS9GS2WphANZ3bzJhaSUGBhzFnkLHTK079Sn/LmwT5C8li8T/ufCzfrwp4L/9r+iz1VI7ec5CskN1+ddy3m+eFF7P8O0joHzKPfl+2ub1nDd3JQimM+p9U/Yyh5stAM3DJOKTde1iqVYrrD2RYzANU1ZvmrkS/P2QboUJeG8uQHPN66dW3dxM580gBXOUxF6DGh4PZy5gqiKmhQ/I1tUz3WnVZZlh0fOck5OWCruCEVWrz9c9YpkiI/BDRTcKwrn4rh5plG2jfx+xmKK4LlalKg4IFoze2O2y1cgZbkqCsmn/suKcuj+3p8KaT3CSCk1VgmpHrtNxF9l7VPNjGeXTcOhOQmPbAeAWiIR4I2RSoo0sDAf1uvw6k3lbA+cnFKw+4fk7NSBoyypGGV+dD3CO+Sobnu76CLOHVX7G1D8P3aA3cVwnq28bl/G+T9/EH/41fpHh6pLHEch4c/lyayApflbl1undZbJ4LSyTykxVe8+ZaTz8mMJQTGIfUrO/WUEJuse/UMIt/suPt19t5iWvBpv17+k/wKib056JanpKG6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1I5eUFzR1RZekVEOTZLeDNUMGhTeXQ5YmJERk9xNmtXNmlXR09reERXOWI2?=
 =?utf-8?B?NlJ6MllvVmN2emVCSGw4YnViWFYvYmozQWpkLzVQejZHUVRibEs4d3g1aTNa?=
 =?utf-8?B?dTFyMGtJdkFBdkpIOTBWeFZXcHR4YTB5dW9uUFlDeER6bi9pRXJ2enpJS0Nz?=
 =?utf-8?B?STkvQXpiOXdLM0lnRkNvQVFwQzRjb05LRTVtQjFKOGFseFdOUzhQdXNxUW1G?=
 =?utf-8?B?S1ZvTndmSG01UTBUK0hvYlg1d3BzL0FFcHp6Zk5TZTJ4Y0tORjd3cWtYakNw?=
 =?utf-8?B?QXdEanZJeS9EeWxSbFlxOVdQakRSOWluN0hSRHF3YnVWMFl2MmdoNjFLSndD?=
 =?utf-8?B?ekdiSmtGaFRiS2NJeWNPTHg1V2tiWDM4dzZsS2RRbWUwajBvOTBpOUk3c1dw?=
 =?utf-8?B?SldNWmxLcy9VQjlrdTU5RVI4bXE3NXlYc2wwY3loMFV1dnRLckNxVVQybVJn?=
 =?utf-8?B?ZCtWUXk2SGxKbFBxUlYrNTNSbmI3b3lwdWtyOWgwTEY3VlNzQ24wclc2eVRZ?=
 =?utf-8?B?djVZaEZRQ1daL1JzV1FHWGpLZFRESFBDczgzS1A3QWlCdU9wVTBTWHY4ckVl?=
 =?utf-8?B?eGlPVUtrY3pPdE5ZV2lBRERJa1hSZUhraEZVSjA1a2ZsZmRjbU5EWFpYSitH?=
 =?utf-8?B?OFkyQ0Y1U3NmbVVNakJSaXhQR2IvYi8yYTB1Uk1KOTNmS2tHRWl0M2ZDT09R?=
 =?utf-8?B?bStwTGRjV3d5YWdYb28zUjRhQUQra0NZSzBWRnkyQjhtdEtuMkF3N20xN0ZT?=
 =?utf-8?B?dVg2Q0RqMUkyMmdhNjhkYVg3YXRyMkVpY1NVcCt3c2x6Tm5nd0J2WEJLWW95?=
 =?utf-8?B?bitsb0dKaUZmUEw4WWNSa3hBb0FQSkJ1d0JpbzljMXAyNURhM2FDdWtiQzVs?=
 =?utf-8?B?M2dDK1daQitNcHJIdzRFY0ZzSEFHTmQrMStIVzRyTlBvRFRKZnZoUFE1V2hD?=
 =?utf-8?B?WmNFUDdKOG9OTnNwazdIOSs1a3RONmpGbWdnbTFLQUVaL3JhY0IzQUJDMElm?=
 =?utf-8?B?Z3RDK1FsYjF0enpDOGdmYVd3UzI5c1ZkQWFUUmZjR3NoS2xUNUloeTJZbWow?=
 =?utf-8?B?b1lWMFc0Vld6b1RjRGF3WXNsYm43bjJ1aEtjOEcyV2JqSE9MVWVDeHVBQWMv?=
 =?utf-8?B?RkFLalhpS0k2OC9BaUNqekprWThZbWtGNnNqcTRBYmhmZWlrSGFqQ0FFWSsz?=
 =?utf-8?B?ekcveWE4VjhpVVNrTm1MWUprOXEzSUEwSWF0c29pNlEwcDZZS2VXdWV6RnRS?=
 =?utf-8?B?WEVDaSs0Q1lISFpRSnJ3bGp6V1R3VXduaUdZY3dSdi92MitTWC9CckZKM1ov?=
 =?utf-8?B?VC9XS3g1cjhqK3BNTHlPKzkybldlQ2xtY3JscWhhbTRLQVMyWk5OdGEyQzRV?=
 =?utf-8?B?dDdySGl6eCtTN3JKNjZ4MUNja1h6VXJBa3V1SktVUU11dFB3WWZGZjJCaVdw?=
 =?utf-8?B?eElFeEJTMnRDR1RISHQ4YjRoREpPSWtraFNiYk5XKzFkK2hvMzRCcVV1NjFK?=
 =?utf-8?B?MWVlVFA3QmIwS0d0aE9pTmNCZFFBRzdiQ05pWVJZRHVJWWdFSWZxbjBwbUFS?=
 =?utf-8?B?T0luSzNNTmQrajNweUNVZ3dnVG1WSi9ud0ZiakpvSEMzNHJSUDBVeGNDamI0?=
 =?utf-8?B?dHFyeFo1ZTJDYVJwQTdjUjlQcjhJREIxTzN0cDhxbjJ4YVJKcXFJdGQxMFZh?=
 =?utf-8?B?LzNGek1tTFVtWHNHRUNTRFNCcWhHL2dWTGt2NlNhdVhZc1hmV3hWdDdUUkFE?=
 =?utf-8?B?WlJoYnBjVmVUZzFvdk9HaFcxRWt2cDJRQVlZbXRhMk53eG9uT1NmU0oyUjZv?=
 =?utf-8?B?RGR5T2FOaFNzL0QxOTU3aGxiYmpzbHFJazlCZlhkTVJNVmlsb3hIY0NFTTdE?=
 =?utf-8?B?OHNHTXBva3dMZmRxTlBjRGdhbldpZllxVzlXVFl2YndtVForNlg5S3RnMFRU?=
 =?utf-8?B?c1JjN0FHTURSd0FUVi9FN3dVR09aQ20xZUlVN045SGw4VUpXaUM1YzRTQTNy?=
 =?utf-8?B?a2JDcnQ2YTZjRll6SmNFZzNocFVNKy91bEwzZmFsN2ozejE5YjdjaVgzWit1?=
 =?utf-8?B?RE11K1I1V21xamkxZXlNUkR6RVNuQ21YR0tzSTVhdjlDc3VyL3B6NVYwbjdK?=
 =?utf-8?B?dFhFTlRvak9aN2xoR2UzZm1NSW5PVGFJcm9MbGhsanFoeGxYN1JWVkw5ZUdz?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f62f67a-39cd-45c6-615e-08dc4e2ec61f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 07:23:18.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WCA4MrhoGzIWZwESJhKe7b0RpEoX6VHWEDR/zU/8ja87uRCbSuWZ0vAlacp0WrMe9iL/BXdS2Zzt9JNlydUIsnEIoAmzlw1/qHM61ubrNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7100
X-OriginatorOrg: intel.com

On 3/25/24 20:00, Dan Williams wrote:
> Przemek Kitszel wrote:
>>> From: Jiri Pirko <jiri@nvidia.com>
>>>
>>> With introduction of __free() macro using cleanup infrastructure, it
>>> will very likely become quite common to see following pattern:
>>> 	type *var __free(kfree) = kzalloc(sizeof(*var), GFP_KERNEL);
>>>
>>> To follow the CLASS() flow from cleanup.h, introduce a simple macro
>>> KZALLOC_FREE() to wrap this over and allow the same flow.
>>>
>>> Show an example usage in gpio-sim driver.
>>>
>>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>> ---
>>>   drivers/gpio/gpio-sim.c | 3 +--
>>>   include/linux/slab.h    | 3 +++
>>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
>>> index c4106e37e6db..997237b3d80c 100644
>>> --- a/drivers/gpio/gpio-sim.c
>>> +++ b/drivers/gpio/gpio-sim.c
>>> @@ -1496,8 +1496,7 @@ gpio_sim_config_make_device_group(struct config_group *group, const char *name)
>>>   {
>>>   	int id;
>>>   
>>> -	struct gpio_sim_device *dev __free(kfree) = kzalloc(sizeof(*dev),
>>> -							    GFP_KERNEL);
>>> +	KZALLOC_FREE(struct gpio_sim_device *, dev, GFP_KERNEL);
>>>   	if (!dev)
>>>   		return ERR_PTR(-ENOMEM);
>>>   
>>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>>> index b5f5ee8308d0..baee6acd58d3 100644
>>> --- a/include/linux/slab.h
>>> +++ b/include/linux/slab.h
>>> @@ -711,6 +711,9 @@ static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
>>>   	return kmalloc(size, flags | __GFP_ZERO);
>>>   }
>>>   
>>> +#define KZALLOC_FREE(_type, var, _gfp_t)				\
>>> +	_type var __free(kfree) = kzalloc(sizeof(*var), _gfp_t)
>>> +
>>
>> Nice, but I would rather see this wrapper in the cleanup.h file, that have all
>> of the rest of related stuff.
>>
>> On top of that, I want to propose also a wrapper that is simpler in that it
>> does not allocate but just assigns null, with that in mind `_FREE` part of your
>> proposed name does not sound right.
> 
> No, do not hide assignments within macros

As most general advice I agree, but here we have a specific case:
declare variable via macro; and that, (given the macro name would be
clearer), is expected to have assignment (or default (un)init).
I would even go one step further and remove also the asterisk from the
call site (and *hide* it in the macro definition).

See _DEFINE_FLEX() as example:
(there we change on-stack instead $this_thread on-heap-autofree)
https://elixir.bootlin.com/linux/v6.9-rc1/source/include/linux/overflow.h#L401 


> 
> http://lore.kernel.org/r/CAHk-=whYxkfLVtBW_B-PgNqhKOAThTbfoH5CxtOTkwOB6VOt6w@mail.gmail.com

Your thread is a more complex thing to what we have here.
And BTW, your original proposed solution is nice, and even if it hides
flow inside, it's almost obvious (the `return -EINTR` statement
is verbatim at call site). Allowing `else return -EINTR;` solution
proposed by @Linus is nicer, makes a good idiom, but is less obvious:
Imagine two developers that don't know the API (well), one writes:
`scoped_cond_guard(args);` and forgets to handle the error case,
the other by just looking at the code have no idea to append
`else handle_err();`.

> 
> I.e. the amount of incremenal cleverness that include/linux/cleanup.h
> will tolerate is low. Any helper should look like typical C

