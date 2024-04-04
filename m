Return-Path: <linux-kernel+bounces-132261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB002899228
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14F61C22F58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE2A13C673;
	Thu,  4 Apr 2024 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKtDUNS7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1756130A7F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712273730; cv=fail; b=gDnh2fUC9mcshM0vTYnR1vhbD6EQbuOsCIN8pr7oJ0NKAnrwxKPiqy+7ROMyPKZ0Brr+MHG+40z41BGuJllgC4IZxWnfkGVY76OgpY3/b7QDs5D+rx4M13vUosf3KSI2NecGowVELeifHVADPq83irDiP5B9n+bKcPyNB33JhY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712273730; c=relaxed/simple;
	bh=dHJO1dUbY5EGOIn4YkAdw4wfRpn4BFJwvMnAbJOR7o8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hs1XJiiSJYEG2MXcZjJIdoKjD1ztA2+jRuc5lp8V0l89Vii6HgGEPl6akLErOVHkpVAscOIbhTEMRngfsXulFwykjFvxsv2zQ5+jEklKcIvAxfDoYAHKPmWm3PqCXznlpND31ldtPZfZy1O1mPLFCIUb3CMvPu4KJLhLXhhVlBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKtDUNS7; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712273729; x=1743809729;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dHJO1dUbY5EGOIn4YkAdw4wfRpn4BFJwvMnAbJOR7o8=;
  b=XKtDUNS7qWQ9RhbChO03NWUJqwpyoEIcsE3q4pc8Ttr7y57A/0y6g7Gm
   WOPC9cBe3DHfCEhTjnw49Tj4I96UfjSxjF9B7h5DouHfP7s5txrDMyc3Q
   2McbehHkyxjJ/zdMGkhcIlOOMvobiwA4XRf/Ck5mCrTmk/2REbEOMCBt3
   FZYwvjz+CkUKd6Xwkd93dke8XY76AfuznBTCrlmVgfwFMMNTZtg0OXqxi
   cjf8zIr5vQIRk6zhhgTRSUPoR5h6j80oGGzl5bEifQKHEVwS3SLvcgA70
   2t2YFxn4afEoI8wtU3Em9EDBZJ+rnvzwGsosRJ2rIGt3KR1Ae0+uQ3SUz
   Q==;
X-CSE-ConnectionGUID: mH2L2uQ/QBmu7NDSX7mCSw==
X-CSE-MsgGUID: Z9UegYwaTuqzOXKrbSkzOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7433365"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7433365"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 16:35:28 -0700
X-CSE-ConnectionGUID: bJVOO4h8TDSAtrdhOPdxyA==
X-CSE-MsgGUID: WYrqbK1qSGGvaD0mnBgAhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="19413955"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 16:35:28 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 16:35:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 16:35:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 16:35:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKYMNWPK3jYcm9ToV1bmC9u8fKNEs2dCG7YxQvM1QvYJEBOGmR3F1HFUSU2ijPJldJaQHnvlqnq4AyG0iSlMIlN4XEmOOnlErndodU+f4bOwCZd/H4xMjb/SMZcLehI1tjoRc1bZvbwOn5gWOtkZ/hG+qqqfpdD0rJndDLLP7LhU1/iXW7oCZvtEVNwTsrRWI9lfl5NWlyn2OP1fRgaBpYAwvYQPIx+Gg7+3Iwlx81BL97zFmZ/eg9cDxTPgrHangF4yCSIb9qmTUZ1D1hO79DJlk4q7I/W+zojH5tiNwmaaFGpc68sviFp4UKtQzndyOJoDUDroO3y+SCQQAixG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeKU7m6TlFpfL94zxvHiL/OTKGwPnHc/UiKbk1C+dMA=;
 b=mvo1lz7l8a4tl7r9x4dFnd/yU74H++8QpbZneFnJ/eOtkepHHgeYvzNJpifuIRWbA4y3mXmPgPM6VYZSmitvNbZtYqSk1nOtI50aJPqMbAepFcEMr+H9BqWmkvKF1kzIlhMa3YyYWFzkP+iA0FPG23jkabcO78bBAwGKWizV9dpUdcH1X2QpvJwgpPRG+r0S48NsTr6Ev9Uv7QQ0qJfKiWEnVRvBiCOxVxWe+xDO/jAsmLtLgLafdkoOJIl0aLcYR9CI5SPJabtIOh/NS54mvVF6216YaYDw9pA1R/2KW9OriD/CgsEtdqtjFOT86Fq2ZHJF/S7Zr0wLXJhM5pIsyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.21; Thu, 4 Apr
 2024 23:35:19 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1%7]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 23:35:19 +0000
Message-ID: <16f786f1-e214-43f8-ae0b-7ab537bb511e@intel.com>
Date: Thu, 4 Apr 2024 16:35:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] x86/cpu: Add and use new CPUID region helper
To: Dave Hansen <dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC: <jgross@suse.com>, <tglx@linutronix.de>, <x86@kernel.org>, <bp@alien8.de>
References: <20240322175629.01E8B39D@davehans-spike.ostc.intel.com>
 <20240322175630.72CE974F@davehans-spike.ostc.intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20240322175630.72CE974F@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|SA1PR11MB7109:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1EjvkUHtTYcVQLHt/pEr7/n97VI3RaFdwRCg3GqA9t9vrWZSLXVqGEiB7PJObCAFY/G+GL9sZupnwAAs3odEOjhCum+nwCWgGUCuL4aD3uoB96fpw5XtRkpmxwA1N5oqpVhIISohNdVWtmvtYMJzcnnL00kvvRc9TgEPHj7qM3GysV05x7JIxX8CoNMeZLSU+8SoEKlANey4/eYZRpHar/g7++oYX6vhNnaZfujqDNK3HLaeERVTAjJLTG5FVYbQyoPfH3CjRgZCqpLvv/Aqhz2KOQQPEeqz9uvb9YGHRc83NhRUqUQ1++Ba18vpaaFX1jICryo5z/zUCzjiEZ3eCIELXomuG1OGmBcYfgqGL+Cra/C8f4+XNgPqD4MrSpESpahBi0oPFwgqRjHafI+eDm57gE9z9P9KdATEn8oSeLcusMEOrM/KNcL0RokOs2xNc7e2x7poBqE/YRCq6TZ7TFnWShb5K2MWscZmNBZ/O1I5xEZwe07sbb3AtHMTn84Xf6x09fIPvgXJu72agvd4Kvwz+iInE+9HvIUw4DJjBl5X0NNJx2Db2Ma00ZT/jlrpgFHx2/e9XWyDp7Gc7Hw5bDtW+HmPIWwSrpIz8rbe4cpIFNCvcyJZR9qKt54h/m7KkWi0Q/xA8kdIPahD3WRl6MLI8NAN5O/OsQl8N76pw3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?My82bklQZnNScy9yMXhCTEk0SmhwRFdaMzdPME9LeVBaYnJOUzdqcW1CZ3Nu?=
 =?utf-8?B?bFVUZEhzanFvQTdOZ3NZTjN5emd4UmZDZklabC9RdGpvN04zY1kxNkg0UHlt?=
 =?utf-8?B?MzI0MmRILzROc0xxRzBQSUhGekxmR25FYWdySGlSU3RnSnBOSFEvb21oZFRR?=
 =?utf-8?B?Vmc1bUNaYnpJdGpnUGREbkJUVk9PUU42K2RaMUFRWldFKzhWNTBMcnY3OTBE?=
 =?utf-8?B?MFpYSzREeEdUdkk0cFFCSWorZE9VSEl5QWZ3YUNPUjJneWlabk1BSm44THhj?=
 =?utf-8?B?NldOYnlvNVBsLzVWVzI2L2FsamdkVWJWamR1bm1yNXZCU2NxZXhzeXdUQlNm?=
 =?utf-8?B?bUJsb0pFekNtYmdzRUVCUTNrMkQvak5EbUk4ODVuL0gzcnpqZ1VLSFVpcHpR?=
 =?utf-8?B?OVB3d25CTjBaaUUvY1NYV2lEV2pxM2Z6VnlPTlJ2UXd5YXpxSS9QOWpsZXhn?=
 =?utf-8?B?R0NmK3FkK0NVTkdhY2RzRExqaTFFTHNNZ0xYL2p5Z0lTNnJ3YkhtYU5oTGw0?=
 =?utf-8?B?NVlxRTRTUURobDY4M2VhdFhaZHErM2dMZHV1NllkVm5FTk5qaDlWRTVyTlo0?=
 =?utf-8?B?bDQ1dXFzV3REd1UxV1Q4a0pKd2ZodERwTHVLalFsM3hpV0ptNkQ0cHlYdThI?=
 =?utf-8?B?Ty82Qitjd1I3WHdwS3NXaG5weHhPblM0eThnbDVxMDlhZGt2KzRQWnBhQURN?=
 =?utf-8?B?NkRvdGRxS1U1WWxxQzBWYkxScWpjMkQyMDVLVzJIYnQrdFVIRDZWWTl2MGpK?=
 =?utf-8?B?VFFSMWYvTXk2cjJyMXRPSS81TDdjMWJyYVVQTnE0VWEyTzg4cjc1QWZQNzRR?=
 =?utf-8?B?dmxia0NkK3BVQW5aS0c4NEExQU1pa0prRkxjMWVENmtoTFNwODNoVmErQnNr?=
 =?utf-8?B?NWpZME01SjE2aDlJSGVaMFRBbENHK21VcjQvQU5OK3A1YTV6dUJaMVNnV0lM?=
 =?utf-8?B?VS9pNm5JRHN5SDREYzZUNEZmcXFCQmV5ZDRySEdHbTMwRVUxWkI5NDNjR1JS?=
 =?utf-8?B?M0Q5RFpLV2VueWFESTJFQW4zakEyczhTTEZ1RE04aDVneW51V1VaNG94L0ZF?=
 =?utf-8?B?WlJjVFNhVitjRlA1YmJpVnRoYzFzMCt4QURKajIyei9QMCtSbjJLV0ZWVUNY?=
 =?utf-8?B?RE1jdEdMZDBFdmFlWWdyWmRrdDJPY2JrdU5KVnMxeGt2NjhOZnhqYUFaRFB1?=
 =?utf-8?B?bHlkZUNEaXdjN2JWNXpTSmhNRGVJS1U3U1ZhcGtWVTBqY0ZRT05UODdoeCtE?=
 =?utf-8?B?NUFLVHRETU1XTHZIeFRHUnlZbGUxZjFXZ0xrN3JWcy9qQjd6N2V6TUtWZUVw?=
 =?utf-8?B?UnlUV0UyVEUzUldVVmdSWTVvblFTV1VwT3l3N09wVW1mdjlKa3kyNUQ2c1pT?=
 =?utf-8?B?WmNyNUtQZk5SczZwYi9ubTVpYitSQlJTV1lzOTRzTzBPdUk4NHFHZVN2TWJm?=
 =?utf-8?B?Y0h6Vzh4RHlEZkJXQ0loWjIvVFR3czk3V3hFYUpJaUtHVUFLQlI2Nmw4WGh0?=
 =?utf-8?B?eVZOV1JkM3hZS1N5SmpIaFR4S0FVNE9TY0lMZmpXa0Jtc29XdmtzTTFDUFUr?=
 =?utf-8?B?ZWtJM09qWnpOemtxSUlpRml4T0xMc3lVSFM4Qm1UQURPVjg2cWlFNHdmWHNR?=
 =?utf-8?B?TEZxMUZEMDFCdmRWbkJtSlZpY3g3TkZNOE9lZGs2UjZidW1yV1RWUXAyd2VC?=
 =?utf-8?B?MzdubzI1R1ZHam5YMitCSDdOV0VIdzJDNStaU21SK2NuUjBEZ3RmbitkQ1F5?=
 =?utf-8?B?Ukdxd2FQLzYySEN1dWZpeGkvTkJqL1VjVlJ6QXNYVzFEMTF3bU0yaGlyOW5k?=
 =?utf-8?B?UTQ1dW9wdGVwV1BIR2VINlFFSTduc3JwY0xxWUt1aG9iNGdob2pydkQyRHMw?=
 =?utf-8?B?VGtQcXdTcXhiTVNwa0FlR2dYYWdjSmRQbHR6MDk5WjhZbnpPcDA0MTBwNmhy?=
 =?utf-8?B?c1djSmVhTVVFa2t6YWhYVUx4Q0VqWWFFaVdDUFNwZWpETHZvM2RkRXJYQlNy?=
 =?utf-8?B?YnErQUJldVkvK0xkUWhOUjhhL1E4NnZaRVBPcFc3SEZsSWl5elpDQjBpRW81?=
 =?utf-8?B?QzgzUUorYWRPMk1CVkIxOWxudUNWOTY4YmJvZTAwU0tRV0xDQktOL0N0UmFH?=
 =?utf-8?B?YzBjTHUwRytqU3pGMWxlTnE4b1RhbGp1QTI5d08xWWNlcmJpY25MWHg5V3Ar?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b0ecb6-57b3-43fa-5305-08dc54ffe392
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 23:35:19.2618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sT0Ct913uj0epnGaP3oyRzQoeVdm0bQeL4qUa6d0z/34e5LItpJXA6rFAoEh2ETR9gpx+J+z1QS6mpRXu7PlGr8mXysSYyZyBAKKOx2Hq4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7109
X-OriginatorOrg: intel.com

On 3/22/2024 10:56 AM, Dave Hansen wrote:
> 
> diff -puN arch/x86/kernel/cpu/transmeta.c~cpuid-regions arch/x86/kernel/cpu/transmeta.c
> --- a/arch/x86/kernel/cpu/transmeta.c~cpuid-regions	2024-03-18 15:12:20.680308889 -0700
> +++ b/arch/x86/kernel/cpu/transmeta.c	2024-03-18 15:12:20.684309023 -0700
> @@ -9,14 +9,9 @@
>   
>   static void early_init_transmeta(struct cpuinfo_x86 *c)
>   {
> -	u32 xlvl;
> -
>   	/* Transmeta-defined flags: level 0x80860001 */
> -	xlvl = cpuid_eax(0x80860000);
> -	if ((xlvl & 0xffff0000) == 0x80860000) {
> -		if (xlvl >= 0x80860001)
> -			c->x86_capability[CPUID_8086_0001_EDX] = cpuid_edx(0x80860001);
> -	}
> +	get_cpuid_region_leaf(0x80860001, CPUID_EDX,
> +			  &c->x86_capability[CPUID_8086_0001_EDX]);

Just nitpicking one minor thing:

CHECK: Alignment should match open parenthesis
#136: FILE: arch/x86/kernel/cpu/transmeta.c:14:
+	get_cpuid_region_leaf(0x80860001, CPUID_EDX,
+			  &c->x86_capability[CPUID_8086_0001_EDX]);

Thanks,
Chang

