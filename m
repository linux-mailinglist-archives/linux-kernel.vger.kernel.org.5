Return-Path: <linux-kernel+bounces-125128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A753689206A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA541F24FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522031EA74;
	Fri, 29 Mar 2024 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4HgbX6f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3218EAB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725921; cv=fail; b=QT1gc7YQm0UPV/42WMQTGxvGuNKT6BymMdy82gVhIIsxTjxVE5c+AGmqIw8drhlcJo9mmyrA2PWxKNZ14KVtXiQjS6M3kf+qHmkBRZ2SgxJ13noO+fqpOnjACdedrwKOdficKSbePtzOH7Z9cir+Krpat6j1tF1C2SIb8sIZkFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725921; c=relaxed/simple;
	bh=kTrbBuWes9isNgZQBjGNw2Iynce8U/ksqLX4o8jcYDc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eJscASH5AuOuZj7YfdB/QTl0kbqgwuvBAEmivAbibW5mVrbwdCdsGJrbvlvrEuZTCjkDfHocJP7kY8A/86q+apZCFdM3d82qbLpAlwQWokaJ4qq8M3rk45rHsZWnkgHplCy41yW8iDdYOjyDcmHPSkdXGZ7Skt1eM6T++C2UQxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4HgbX6f; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711725919; x=1743261919;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kTrbBuWes9isNgZQBjGNw2Iynce8U/ksqLX4o8jcYDc=;
  b=I4HgbX6f7e6oXK/cqO77SImDhsLkuZCGYzSrkZ+W/ScHsXYQJZdZcnAM
   iOFyoAQXrHgeV1lG3lUOOKgiQwNaEFYDzPmZO8VgK421DnmxeMLhaKBWV
   9v7yGSFrGtgol0X0MZ/4KkwGxlHfQBjRHIAcJxbU0bQA2rgp//HUnNwwH
   rg5zQ8ut1j97y9sDugowxOZ/t33mkU0Gusq/nCSi57EE9N/B1IbkPHX9U
   Cv5uyvRJOfxBXfJ0VnF+sTQlqr81BXVcemDo+YNy+pKSxNjK3b+iIt9d+
   WEwQon78eNfFgT0+wKQapjvuBVNWQIaYqDH4EuiWENTHcOf1BmD34/MXX
   w==;
X-CSE-ConnectionGUID: iPiIMbOpQG2R/9oD8gy6WA==
X-CSE-MsgGUID: IFVm86gNSZ+rHrjqLn8vFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="10726027"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="10726027"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 08:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="40153471"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Mar 2024 08:25:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 08:25:17 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 08:25:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 08:25:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 08:25:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThlM0xAMywLXSTpAff3WxTVPtLT+ssPzJXYGQo7cxMA3/MlIqpDzL4vVYZujAICUHI88YTVGllm+w5oG8UVQzp4+fwq7qzedO0lF1gMVAl7DDnF5drkKMbFuSOfQb/7S4f/MmCR5ADb1liLJ9a6ZgU6RV877cJ+bgKb5YQHsbk/7GchJCX0HzIyFiubUNhZvGe9+Jvf7mO9L3dlkyQRpB/t/o7S8AanddJkmVwECLyfrjFVKrGL4xpDFrkegsTl/2gIjzccVEsW8AhVsvIEV0AZUS2+cY947iB3y1uMDORhUByun3K3PrW2fN2SAZNnyUdPPfEb/Mpt1pTcn0pxo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8S3xKuKSzIF83ArBgfWccOAO5ntfCmy3FcS6NJgJac=;
 b=RAWXJEobnF2gr/9vYdbOVeaNLB/+FRbtJv24YrdcGQsf2ZtO1x2BEA7m8wPaXGOQvJTG1k9Nb7FLVk8CqVYB+1scyyLhnmfv0IEKfd0EUuaGYK2bbVieU4msxsEk1iAUVNtG2yJa7mLXK8CWXlBqy746/BwqiaZcXGbuJcwiaxutktGuc2BUb+BLRR5lske3cjZFv1kLSM4jcVnR2Mly4pOzQ65XNZT2qB64VQMHozHHeaK3inwX9TF7eCAd+JY+CnpfIA3i2aLCY3F/wc1AY8Y3lG6TDsIbMUin9yp6O9Cxr9M9UpuDo2e+bWtnJZWLv/XsYkpnimgFrTsZhhh7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7801.namprd11.prod.outlook.com (2603:10b6:8:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Fri, 29 Mar
 2024 15:25:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 15:25:09 +0000
Message-ID: <cc629f91-b4b5-4c9d-b47c-c40eddb03a07@intel.com>
Date: Fri, 29 Mar 2024 08:25:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix uninitialized memory read when last CPU
 of domain goes offline
To: Ingo Molnar <mingo@kernel.org>
CC: <fenghua.yu@intel.com>, <bp@alien8.de>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <peternewman@google.com>, <babu.moger@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <james.greenhalgh@arm.com>,
	<linux-kernel@vger.kernel.org>
References: <979cfd9522021aa6001f8995cd36fb56e1c9cd39.1711659804.git.reinette.chatre@intel.com>
 <ZgZnZgfDUWlhQQxW@gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZgZnZgfDUWlhQQxW@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7801:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94Hw9gDdT7HtN9qmy8IM7qMvt+Z1wlFEwoQaRnIEN88OqkDLqC7/VLPd5rgK5cqfiOdvJWwEkIdlCGwvFhiixdE6fl+i+U20zLEHhGDeBz2VSCmW7RlDwdaDDX+Z9oaviZRyHNvI642CUQuIHGuyVd9T7VZR14W52S2YOa0trm+ow7ynqLx8PH2Pn72B9alQAFnyr22FlCMOO4vownvy45hkpuq85fKWAVDgY0VrLU75VO9KjHDjb2EmpTgpzwgN5oXXgOdbJhJwvUtdq3LHbbroF672aD+jY0EgQj3zXLbmt7McU6ryPGjiGg+2dp+OSPnMC1bp+LtX4QTX5XVEhRffL7xU1ZV6SbpmLTsNyCcBUrIHIoraymmEncBdU05pRMXC5FSK6m+nqD00wb+zDu2OqXzk2xeAzHLYiZcolGpkjvrlrQUGCPX/YAT5+h+28LOTcJ5+kyvz+OmN/mI4oTAQ10AT8MZOmBK6K6lJLxEEy+aj/qIthRSv7Ug90IKHOOcqBND0h4Ygd7ZDrE4F5SyJH79GeGSPIG4XhFMSVD69vBw7TZB0VA+cKMwdp4+Dfo6BzupbD82qbRL4Y2EIiebiFEo8Skt7Lj2hlY+ztpVxFOpqMUQIKEdSheb6mOgkNwbVBKHBtMeeNOZ0ZUWskGwYOu6/2UADA87GIf29JiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ako3KzN3TEIyYUkxSHRxdFhZZzlxUk5td2Y5bFJSNEpKQ1N0NUFUNVVjQmt1?=
 =?utf-8?B?WnorU1RTb09sTXRjM2kyOStqbHBuaVE1WGVuVzZ2WTVCemZCcDFWaU5ROU1u?=
 =?utf-8?B?bjNoZldRZzE5MGNTb2prcXBtUklLeE0vclZJSGpLVVpPdHpJSFBSNFRmRUtu?=
 =?utf-8?B?WHI0ZG5KVVFNZDBEbWFaTVhsSVM4T1p1aHk1dGF4RnM2ZnFlbnRvMXJHQUpj?=
 =?utf-8?B?MVdUS0VNelBPUGRsWGJubjIxWDJxNlIzNDNwRDN0QzRSNmlwc2VDR2VVeWFD?=
 =?utf-8?B?RFJCZEErYkVYOHhPY3dGSHVCQ0cwdS9YYVEyOXNGY1dnKzh4ZTMvTXUvMWZy?=
 =?utf-8?B?enBrelpaMEwxUERDaFpSdTZ2L2RxSldCMkhKNWFsbnpSYnFpY0M2VmVKcFFm?=
 =?utf-8?B?ZE1PczhvQUpWMEdzV05CUmwxK0pFYVloMlZvMW9kNW9zeWppUlc0RlQzYjhU?=
 =?utf-8?B?eCtwUzBGa2dENDZjdGdUMnRCSUxwNzQ1RUU2RytRSmYzbThFZll2RDVaOEdn?=
 =?utf-8?B?aE10eEZub2NNUFdYMzYrN3dsT3RWcEVzSk1QRFpTRXR0MWRHYzRqbUdrUXFD?=
 =?utf-8?B?OGxGRGdTQTdiS0RHTjdyOHB0b1MvL01jTFBnR1ZXTktHNk91OTdONWErRGcv?=
 =?utf-8?B?Ri9ERHY1V3RYWmF0bUoxZU00cDdvc3IvTFVLMHpNRzFHb3JXUndVd3llSFJy?=
 =?utf-8?B?Y3VxUUFaeWlKOFVxZ1hSMG04RFh3WjVyZUU3MndCVWIrTzdVK0YrUkp4aEdW?=
 =?utf-8?B?bDdYeVhZN2c2YndNSk9nd0ZseEZlVFVoRDdzWll6S21hdkFsOXRpNXZWTjgx?=
 =?utf-8?B?TTRlTTNLRCtlM2VVRjlOZjNuOXBYc3dqaWc2MXFJNGJLRXp5TWhYU29JM0Zr?=
 =?utf-8?B?RXRuUEJmQXFhelNJTlY2WEkzSHZ0SjNsc0ZXblEvTy9hREJ4RDNxR0F2Ympn?=
 =?utf-8?B?U0Q3L2dmVVBBUW1SUXJWSDFtM2tvcldKYzUvQWVDcHFMOEl6WE9HVVNqTTJm?=
 =?utf-8?B?S2laaDhhSWZld0NrVnhTd05XbGQrZVkxd3ZjR3FQUng2b3BqdytMWk1TMm14?=
 =?utf-8?B?YVdnVWc0Sm15MnlFN2lGV2h0MU4ydFV6MmVLb3p5ZUFmSVhXWVBzQzRQMVRu?=
 =?utf-8?B?bEIyNjUreHpVeEwybkdTWWgxUkJMa1lrR3lWenlqUmxabHc1eVN2WWd3WGpj?=
 =?utf-8?B?TlRuN0FVRmdVbExSVW4xQ1M5YjhGc0NBVy91akRXK1dOclU1TVJMcGluNkdO?=
 =?utf-8?B?NnY2TVEwb2d1T1krdXc0YU92bTZ4RE9LWFZXUjdTdG5DbXp3ZFlQRmJ6bTAr?=
 =?utf-8?B?Mk5Yb2JoaW5tNjJsSHV6WklMTnJ0dm9MQ1ZGOTFHbDhoSCt0ZWxTMjBFcGp3?=
 =?utf-8?B?ME1BcEw1SXJFR2lXanNST0tXTzR6SDI5YkxNcjZnTGJrZHRHK3U3TGxqcndr?=
 =?utf-8?B?WFhMMGJnaS9jbDk1WjREd3F6OFlocDJWNGNCSWpNVHJMaUJqLzJkbzJsZi9J?=
 =?utf-8?B?N3RhSEtlUm1IYmlHMEk5K2pGWmQvUDkzcUZEcGlidDBJVldmWFdUa2laTFAw?=
 =?utf-8?B?SStYUnR4b2JoTTJSY1B0ZVBRVk9oMDU0TGlDVUVkWlFoTHVwRHFXTTBxWkF3?=
 =?utf-8?B?ejJjRWc2U2JkSDNLaHlNRHYweFN5K3ZINXpqMTNta29yemV2TWNhNHJHM0Q0?=
 =?utf-8?B?L1lGQ1VNYVZlTDdUODJZR2ZxSlpmNGg5YmJtdWNRdHhHbENIQ0VRWndFR0I4?=
 =?utf-8?B?NmUxakhyWVBaUCt4OXpTcXVlV3NsOXltNzBCK3ZkbnN5cVlhR1NZNDdOdjlt?=
 =?utf-8?B?aVBUb29ST2Y3cHhaU2xFN1lMZVd1YUhUMGRZbWJaVjFqVVVveEdWL2F5bDFO?=
 =?utf-8?B?K1k4ZU1OUzlxc0c0TXFtN1BzQ0FqelRyanhOZitYaFZIcVFNcEpXK2d4eHA0?=
 =?utf-8?B?R1Znc09zYjhkdzNZVSt5OFpCMkFLSVpCYUVlSHhzTzF1ejZCYWxBVS80YjJH?=
 =?utf-8?B?dmtxZWpzdGhkUldFa1FGV2FETE54QmhZYS9La0tQTE5SUFNoRjBEQXpBTjRK?=
 =?utf-8?B?ViszcjFjaW9NeVBoSXJIaEovOUsrNHZHV3hDcWdIdzU1ako2UzBVb05vUXc2?=
 =?utf-8?B?Yy9yOGRvUGVvVkRPelBOY2tSS1JDYVZ0cFFKN3dHSmFwWUhUM0xPWjA1aE5H?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4309225-70d0-454d-a4d9-08dc50046b0d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 15:25:08.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNEJUrFhiN2+9Ke2t3hq3waIcUiFOaoF7D1zUQYEa28MbXRGPwOG0j8aYIK0EhzKc3hAD6ZXcmdtboKU57f2lJVkDEviuIEeuCjhshf+28k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7801
X-OriginatorOrg: intel.com

Hi Ingo,

On 3/29/2024 12:01 AM, Ingo Molnar wrote:
> 
> * Reinette Chatre <reinette.chatre@intel.com> wrote:
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index c99f26ebe7a6..4f9ef35626a7 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -85,6 +85,10 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>>  	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
>>  		return cpu;
>>  
>> +	/* Only continue if tick_nohz_full_mask has been initialized. */
>> +	if (!tick_nohz_full_enabled())
>> +		return cpu;
>> +
> 
> So we already have this a few lines up:
> 
>         if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
>                 return cpu;
> 
> And we can combine the two checks into a single one, with the patch 
> below, right?

Right. Indeed. Doing so is most appropriate. Thank you very much.

> 
> Untested.

Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

> 
> Thanks,
> 
> 	Ingo
> 
> ==============>
> 
>  Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> 
>  arch/x86/kernel/cpu/resctrl/internal.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c99f26ebe7a6..1a8687f8073a 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -78,7 +78,8 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>  	else
>  		cpu = cpumask_any_but(mask, exclude_cpu);
>  
> -	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
> +	/* Only continue if tick_nohz_full_mask has been initialized. */
> +	if (!tick_nohz_full_enabled())
>  		return cpu;
>  
>  	/* If the CPU picked isn't marked nohz_full nothing more needs doing. */

Thank you very much.

Reinette

