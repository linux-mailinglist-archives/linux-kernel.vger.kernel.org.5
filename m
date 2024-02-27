Return-Path: <linux-kernel+bounces-84233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5653886A3EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F89285478
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8410A5647B;
	Tue, 27 Feb 2024 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ila0dlE4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E255E4E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709077640; cv=fail; b=uk3OhJPQstF0fTAvF422MuV5g8ugtyKCCWJZFyxcp0TKZBfyZmzI6CUCDjn6E0HL8tzAzOadvo+6qnoaCkgxOQexZOblwAQM6KpWeEQUR+7WNiBvMnj/VHSgAqOGxWGTOM0ImYMdk1i8ZgXL+BQA1QvumNWKBbaXUyl/IciQXxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709077640; c=relaxed/simple;
	bh=6YXhZ0AnKkIpngHpLSkFRT7UCaLH3YoworqnyaHQW04=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MOZpvQBC7C0/I59iTgGlUa3ROWfemMHykxx5cYX2WR53r87bhd9Jrb7Gp3HgSlrdmq/Um/HHgUJohflv6raOZ6ecGgTjBoRhigo6qv2hi3+vi2KfukY27NKAKF7v+1WfCUDqkIHC9kXBkZE1fwb26WO6M/reQcW7r7kfMKAckhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ila0dlE4; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709077639; x=1740613639;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6YXhZ0AnKkIpngHpLSkFRT7UCaLH3YoworqnyaHQW04=;
  b=Ila0dlE42yVbZ9obPoI+6xNVeKdUsuvnqSDRIJcp/NJeElw8ymXCe+eW
   zYpMoXy9wuWYwAMugwOL9QkqoSpil537j88uL65jLZ4qPQRaTb+iz3foX
   SYgah2EVExcwizsouvBCj4uv/vTkFcg12UV0O7kOEYsyJQ/dmyYIzjvHf
   QxTi8oTUbsHc7S4OjBzG8d8xT/BxnZCQbyrlxlciWOp+tJMKJV1GRg33j
   36xiNDnN2MjhYw4qWGKD8S4F+chEkHr33HgShBmhK8rnFkLiXFVQuCFH/
   7Ic+smBfD/FoR+Oo/fvGU+aLw71Jkp4IU8MTSKE61UEDMt6EwQj3YkJxQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25918627"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="25918627"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 15:47:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7437510"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 15:47:17 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 15:47:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 15:47:17 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 15:47:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLtnTl2zRCdBL6Q/pNYcQhMacYtPVv4S9NFpYq45lV4xMAsXmXTyBbGDflUHBQl97OClQ+WJsWMKi5a+qHsXmAYvXBnffoCrRbazCFRbuR/UUsDQhFePJlPojiPCRHdOySbXajVN++sNk5GQ77teUgb/mBbFS9njsz/cRYO3sVaEU8kLC5tqpZ2NlC5Y4IDRB34HIrXlVOGPp0lL81PSb+8IW0VWu+sfUObJidH6tQhSP0zOFfsjA6VzlkwFJnV0ehD+VPjNy7ByxIEzdwO0SQiwAxqLDK8T2u8J0gGps+kJ9FqJKq2aRxhO2VABRpjvoC9//p/soqDP6Ky0hSkf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgk59DtFeBNgq0wCPKq4uiukvbQEXUe9mMakmxuFlJI=;
 b=UHfsN6pV7Spq5aBjqtsGC4zN7o3tMHtwZ6JgMKomJ2/cVfQUtE2krr0p9IObgAiFsNyAB9OMxz8HSxtMFT0weIepzZ0TGpSb4pbTSb9A8/SwE2rgcrjp67aetcINGsu6xtAy6TSE8xATW8pnT10uavHjWr0Rp82mxwUCLYRnblUlkvf0s7OnfTajDaRPCBT2HG0RUWmeYK3appdB1zft8XPVH2594oSPgdng15CLdmm7Sjn5HJ0SNji8ALxUpd1Gl9g63MILojEEXoSbcdI3SMGAXS8vfmGM1WP+JStUEanT9PoS8UfQH2CvsUMRi/C0xMr79y9BYSNIcAQBilb5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5307.namprd11.prod.outlook.com (2603:10b6:408:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Tue, 27 Feb
 2024 23:47:15 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 23:47:15 +0000
Message-ID: <10808725-d98b-430b-8c47-4feef8685734@intel.com>
Date: Wed, 28 Feb 2024 12:47:06 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 09/34] x86/cpu: Introduce address configuration
 structure
Content-Language: en-US
To: Dave Hansen <dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC: <kirill.shutemov@linux.intel.com>, <pbonzini@redhat.com>,
	<tglx@linutronix.de>, <x86@kernel.org>, <bp@alien8.de>
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
 <20240222183938.662DD27C@davehans-spike.ostc.intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240222183938.662DD27C@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::6) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|BN9PR11MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4f3091-b997-4b6b-2c99-08dc37ee6d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WV6HOgtgfHUZCtJ0sCpYSfhOxHGsgT068plQdnpg7Tqsi59k4eYyWPi05aOooUhY1I3KGvtaD/1/1Xg9PoGwakohSFGEk0NYRJ0IbhtvaJ+wgyrfSO7ZgsGLB5NvTucOP5nH7EP/7lyYWYnwvi+/H0H/A237Q1UqhTcFc50uHaJKVJW2M2R9zT/vXluldsFHE5i+TnWxgGiunYajEl8ocInrdw0Rhv5yCqQdsY15hFCRMZyYHgjf5lFA5aQ3Z8kC0CpdSuNklqKpQOdmrmZndhixHudpR9N5SG3XYLidfE1SqTz8FM123yY6seck8HQlv0n4yrQwMYKTyxbDHYzCx+prYBt2OnHi8hvuRtwqT1jFk+9g8PvsiLxy3xkxp9v9tHcTmbwGjRrY90i+Mc5bMnuIOzFunRE9YfNaFuTIdbl+KOCFh05KXj68Mv9UmT7XndEeULU1uwp8G/mzUT/jVEksfT6NQvky7g5Nr88rFiz6s/aHO3zUeS+0S9Tbk73RfnnXlW0P8spwagIyGHF/ylsVT1KmHS6JmyF2QoWHyhxPwKRmbC5K5I3iCPl7Nvf1g6ylJTVel0vP6KVGvXnugiL+KaUMnR7m6kJuspe7tLlHB08xJuQsMD91e05J4tpRQNiZT+OD66Jf2+qLodEivg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUVUT29mNTFGYThmd2pMTGFGOFp6ZFoySkNCVktiWTY0RWJhZitYWDhpSkNK?=
 =?utf-8?B?VGQxOFlsNmtWTjJkRTJNdVpFemh3dWlHdHNjODRVWURyTm4yVkRNc3BBdjVz?=
 =?utf-8?B?Zkx5Mkc5cVlHVzJ4NWxrcXVXVmw4VUtSYXBsZ3VORE9TZEpXMHJQZjRacEpt?=
 =?utf-8?B?Z2RxRzhCVDBIOFRvMDdvK3BCUzBCVHdHcXU1bWxXZ0FBc1FsNFAxNTZ5OFlO?=
 =?utf-8?B?R3pxTFlTZUM1OW9TbzZ0cjNMN0dhNWdSRnBXMEZMUFozc1ZteHRXckxmL1kv?=
 =?utf-8?B?a1pWVUR1aWFwZDFMZkpTNTlwMFJWcWNlNm8yN0ZVZDRWWHVGQUsvMEo1azlU?=
 =?utf-8?B?RHd0SU56UDdWaW8rZHAvRGtTK2ZGemt2bmlnbXQrKy9xZUlnOXQ0YURZdVM4?=
 =?utf-8?B?UHdoK2ptVlhzTDlIYVRwd2dPc0Q3WTU5ZFpDUzdDbXRLSXhTUTYxd0t3NWRw?=
 =?utf-8?B?ZHNHYjdIVkRMN0d0dFNMb1Fick9lRHZZWEw1MGJIcVZoZmJ3TG9xbTRJTXE5?=
 =?utf-8?B?SGxqWGF2Lzc4NEVDK1Nramw2YytIQm5OQTFLOUFzT2lDZmRZcVludElZTmw2?=
 =?utf-8?B?c3Mrbk95bFRGRFI1UWUwcng4K05aNHZRdFJuMHhIOWdtM2JrMWNWT3VuNDBw?=
 =?utf-8?B?VnZScTJwc1BRNmNscTdUTExpMTQzQ3loVE1FV256WUhFZHh6KzNjQzRvQ0Z0?=
 =?utf-8?B?T3F2SWlKTnB4VW5pcnVYOEp1VGtBYTZ2MzhXWHRyRnh6alFCWjFKMm9zK2JB?=
 =?utf-8?B?ZVBoTTBMNld3RmhnR043eTY3L0ZtNFdxUTFaM1FuT1FPVlNpUEZJTXFxUjJB?=
 =?utf-8?B?VW9FUkRDZG9ZbkFML3FSbnFHZjcwT3ZMWmFONTRzTDVwWkhPUWJqdWgyTHIw?=
 =?utf-8?B?eDVIK3V2NzdhL1A4UEVXQzgrMFhjRnVLNWpNM04wOUVtMG85dXp4UXBjcnFQ?=
 =?utf-8?B?c1Bob2UzbFZnb1NjZE9PL2VwdS9INW9MV2ZoVDlzbXBmYklWbjFSNkJDMDlV?=
 =?utf-8?B?Y2M1b3IrRlZiMmt5VndxWVZqVkNGY3JzZ3FXNVQ0Zi9LVU5yYjhpRnpDK3lo?=
 =?utf-8?B?NGhMMk5KMHVsZGtKWmtyd1lCaVA3R2kxeGdXRElydW02Y1htbzdtMDFzVnkz?=
 =?utf-8?B?MnVaaXhHNFR5UmdRU1lqR1JkcXk2NHNuaUFvVkVtUmNhR2VGbDAxb0JjT2kw?=
 =?utf-8?B?WXVtSHVSTEp0Z3ZnSThiMVhuQnZRaGlWeXRBV3dzVzBrM2lFM3lQaW1FeGtN?=
 =?utf-8?B?UHhMajlPUEJxMnNObEhEam03NTJnU3l0TDg1eWZBT2dZWHAwZitsOGs2cGZp?=
 =?utf-8?B?WnFqYm52ZXlack5hRURYMmE1ZDRVck50RHAySUZGYW1Vc0dxSkRMTGNILzNa?=
 =?utf-8?B?OXA3bVMwNUViNXBYTExweW5TU3RTNXNlUFpQcE1YNVlaNzlnMnllc2FMNFB6?=
 =?utf-8?B?V0QvL1lzek5SWWZEZENYL2JaRUpnMGJYQW9QVUYvZ2ZkOTdBZ2pVUGhRblhj?=
 =?utf-8?B?M3Q3N2Y3MThHcnI5bzloc3h4Q04yR1dhbi9PcE5YMVJlMFQ4alMzKzZUZHNI?=
 =?utf-8?B?eW9BcFBvam5rZFYraERUdmtDVDNRQTkvZk52cnZGd2xtdk5ldlg5MEsxZVVT?=
 =?utf-8?B?Wjd2TlBSOXF1N253SUJsWDYxVkJSZHdBV3hvSk1TbkJLM084MDI5OHhYSUs5?=
 =?utf-8?B?eEtpTTQ4eDh6bGJ4Vmc5Um1uR29YbitldGJ5VTNoYXY5ZmJlYzJkZ0FrNWV1?=
 =?utf-8?B?WjNrSjlRQjdvL1BCc0xaTHhzeFBNemczSUhGSEhRbWNSRk9rbi81Mzlqb3JE?=
 =?utf-8?B?SEhVa3VxZlBMNDhsell0Y3ZRTkdtRnYvVk5BcDJWQ0pEWkN2ZmZHeUxPeUFH?=
 =?utf-8?B?MHQzNUxmeUhZcHowSTlpb2tpcS9BVjAvRUdiUlZ1VFF4QjVjV0EwOC9CUmlz?=
 =?utf-8?B?Z0tvbjE2dHZrSXhCM0hySVdqd3lpbDV3d0hEb1lVUFpvRG9rbW5STWFDRE9O?=
 =?utf-8?B?Y282ZjNVU21ZVmhSQVU3aUFDYlJNN1IvRFAxd0xhNjdoemlSdE52Z1JJV1Yw?=
 =?utf-8?B?T0hzNHY3K2NNK3lHOEl3MlBVaUFETkxpK2syckRvMzJjZjlHUDluUERtMGti?=
 =?utf-8?Q?C2a3eEHllSq1ZgWdxq25gemq/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4f3091-b997-4b6b-2c99-08dc37ee6d0a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 23:47:15.2212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9APNFOcUoYyLbci3Qof7DxhShCZyst2dDN5Pm8XvimIk7MokP0YhxbG24kTBWnpLFt050B7NLkFxZQWRBGuggw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5307
X-OriginatorOrg: intel.com



On 23/02/2024 7:39 am, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Right now, 'boot_cpu_data' is established in a very ad hoc way.  Random
> bits of the initialization code write random things to it, either
> blowing away state or tweaking it as they see fit.  It's madness.
> 
> Add some more structure to the process.
> 
> Introduce an "address configuration" structure just for the boot CPU.
> This will be used to establish system-wide address space configuration.
> It is written while bringing up the boot CPU and then read *ONCE* to
> establish the configuration.
> 


 From the above description, ...

> +struct x86_addr_config bsp_addr_config;
> +

.. this can be __ro_after_init?

Maybe I am missing something, but if it cannot be annotated with 
__ro_after_init here, IMHO it would be helpful to call out in the changelog.


