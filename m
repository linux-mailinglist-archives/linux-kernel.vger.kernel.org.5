Return-Path: <linux-kernel+bounces-75134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC3D85E3B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EDD28635A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AB982D9E;
	Wed, 21 Feb 2024 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZ13EsTr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3186680C08
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534122; cv=fail; b=VkHk4dv5zbQf1fTINLuJW9qZrJnmh7IdGri33gw1UxXp6226E5y5CwE4738R8PdWqiAAo5tjZvz/UouT9ZrczxK11Ld4N8MPZJlcxpmCy0QiGQxNlAyWOhQaJp8iifGm/lENd/dtQwPSVUOJHXynAbo/FVbPub2Kp9JIf/Bas8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534122; c=relaxed/simple;
	bh=Eqo9IH3WDwIFsoZ0SbJNEBgOvhh9blgJ+V2mebyv8U0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oQDhuCoI1ku6tVJx0rCdqEjS20K1KzCcmI9ZvowZ2LjqLehRA16a/umPI3Ia/Zc4CsrumqBLH+yhkXmmkKmrxYiX+OsUy08FtHx/ti/2wYENeJUWK0OsoYdhMChoe3eMekNeQeP4xMtajSPnr7PAKEMZ6VnN9VCusgbAVpiNz6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZ13EsTr; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708534120; x=1740070120;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Eqo9IH3WDwIFsoZ0SbJNEBgOvhh9blgJ+V2mebyv8U0=;
  b=NZ13EsTrV98/wrA1BnZmiWeyFHjKdO2e6FMhSyhIeJJePTArwpAGLxun
   wObx/KFiubjaXD7v9B4qIfJg2LLVnmYg6Iu9ZSWDVieG9OmLCESi0Ynhe
   phMasSLTfMgZuolwK8QYQu0Uc182id1IyE3g7NLFHkgADGBXGiQoeNszJ
   Co1slZWEUVYE1+cSoHy8zXAKlixBLLa3sm2jrEumiuAYYnXATm73upMdP
   mIu6J0u+/bLPIqfU0e9oz4N5gyCyo4kHxb13+xkQaP8VQctt1f1Yx/InC
   41LtgN3VpLLZaYZzG+7jOTykJKlJbSOKIfqpXtiej8tC7tTsJXkQProFq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13323324"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="13323324"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 08:48:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="9814447"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 08:48:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 08:48:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 08:48:29 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 08:48:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0Nk5NX2RsZPlAgZSnsp8QyvG0utqecR+fdohsn38oVYfY9q4K2UZm2dh7NIf7+3QwvBEysV78Ap4eVcGLwfAm6juOS8z/LihVvOno7lw0p3wbohcGkHL7Zr+0utGfrikX3Te8aBySpO3raEejBPIyoO1P5KhV2Z3IH/C54yiQIPUr+nJD/Wp3vGLJWyj9l4J0S3dzeqIllf7PBzx8oAow6PrSQkLlKcbGAc+B3zR2MWM43PtRKuBbCXRdpocv8w9BzHIYOGkIIP6x11yVQ12NX8VTCRRQE5aAsuggmCSq4vzu68/KiCEbeIcFtCgK+4WT+EVq0IypdoSGui2MMf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThDkdPskXaQLW/PE0H53WiO/RrWCUN4FUPf3238l6ns=;
 b=IN6e9iWNZUn8WqGWwk9Hon1vW1SMp+V/zn2SM3w8DVhHfKW4RjLCEPKspkDZ5kiIxzhRX8a2ZYYL29Wx9uqzS8z+GnmQiiDHtCUTd1Sg/r72w+XWaBPb5/llxg400+fhVQjq7TTs7rmsQ1YK0T5YGQgC75FEwad9FvXtXX+ock+Vzp/O0i+HSXcEULF2upDtDtAs4H4a1uuIG3honTZLT5OH/g32UQngEsHFGI4cL//B4b37U/lrsJlcCh6+5OcljCylxn6MV8iC1kifnv0bhSiqxH3YUTbl0NtG7+xA3pIyjdnVfyO+ljQQIXSrKvxfATOQlssRc3u0Dg7+F1kDfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6112.namprd11.prod.outlook.com (2603:10b6:208:3cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 16:48:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 16:48:26 +0000
Message-ID: <67600176-d299-434f-94d1-d6e4f1a5b2b0@intel.com>
Date: Wed, 21 Feb 2024 08:48:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Remove lockdep annotation that triggers
 false positive
Content-Language: en-US
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Tony Luck <tony.luck@intel.com>
References: <20240221122306.633273-1-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240221122306.633273-1-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:302:1::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab9f151-2bbc-4803-56e8-08dc32fceca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMQPyZqow0Ab32hwjjWh4Jopu/wV/cG8leQgC7jo4UznbtS5C1FsqIgXY9s7mFtIJEqnCJsYMJmDsLJ2ba47494QJqMetUyASmfkYQLIHQCdTdxRYCaH63Vq8U4Szx7lAihN/EBdLC/jvzpt2WGMN2hTK2VIt3uF3FFh9bBZqoWwLLmki854aIm1A8PVW0vcRP2nR+a9uma6lrv0wvHIzffgAH4FLlE11TXA5iZWJb0O1pZ/Idx4kznKMzpeC9SZNxOyDF+97QZJC1KSwhZI58P+i62c/yEbyz9NZsNkbbr33DHEHpyPKPDkYOVpldD8fj6CrivXQIXocyRLjtbdfby9rYofxa8gprZD+N1gz1EyJzFXrTNobPG86xFNrYRRxTEYf2jUrj/WEr1tToFUpQNL89Ojgmz2WD/UB+3MLM6KhO4jRTcGa7PY0mSmsLA+9wIzd1k2jzK4XXkZqhU8gzNPRdIa/G4BERNQe22VcYSrJD/Qm77Sm5AUVddaFNV+EJE66s+Occ8CYEoYp6D8Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm02bmN4NlJFdmhpOS9pZStwV1ZsNDhGQ1hGenR1aC85d3U0ZjRiL05tV3Ft?=
 =?utf-8?B?a1Blb05HVjRVNzl0UUVCK3RQTDRmTlNhV2lTOVNaNUxiKytoMi9LRU1JeDlq?=
 =?utf-8?B?UVlnbFZiNlkvWTFVd1lLT0JWZXVpUjM2K3AyakhxMkZrMTFiU0JYTEpOVkMw?=
 =?utf-8?B?YWs2WTh0czBTWFBZZHJLSDFrV2tTczEycFcxQUoxZmIzZTcvZ2YzUDJySjFw?=
 =?utf-8?B?dVdWWi9MSklGYUluOFJZU0dVdSt5ZHpnQWpmYncwV0tIWXVvL0dHS0YwK3hM?=
 =?utf-8?B?SXRKZTZIeFZwV3dJZldxUmw0bG5zTy9QT09RWjRpbmlOa0dNZG9sbXo2QWh1?=
 =?utf-8?B?UWlJUElzakl2Uk1hQ01yaWdVTmx0NzFRY2lZbFBRNlYwdkczb0QzV29VTlRq?=
 =?utf-8?B?K1Yrdnd1R0xINnFtOGZhNGRITU5xNjh6QmJSTk1yNHdEZzgxaGtabnMzVE1t?=
 =?utf-8?B?Mi9vbUtCU1AwcUt0R0Y0STlVZG5yTHVKSjJHZkd6MmZERjhmWmVqcTh4VVFX?=
 =?utf-8?B?UTBTYWphUW1QTG9MWjBuazRBNm1NeklCL1drNS8yNG1CYURrT3UzTTRSQ0I1?=
 =?utf-8?B?Qmw4aFhWS0g1UWxGQ0N1NzE3L2dOUWVhVGh0aHVQanMyYk9DT1M5UEZCQmtQ?=
 =?utf-8?B?T3M5cE14WDNDS08rWkVFejBqOFRlUE9HRS8xeFhSUFJSQ1B3K0JxZjFxdXl6?=
 =?utf-8?B?QUw0aTdBbzdJd1hWdXI2THJhNmxoTDRHS3JnczVRbFNQanU2aW9vcnpUb3Zy?=
 =?utf-8?B?QkRiMG1vSm1USXdUeWZScnBMc2p0OXEvRTVqaGMrN0svTEg2WmxQZ2d5eTVK?=
 =?utf-8?B?RTZSbHNKRXpCVHIyNzA1TGQrOGlYcUd4QlZCMU00UXR5Ry9Ra05uWUdscWU3?=
 =?utf-8?B?TTYrUG5aeHc2K0Q4eVFUeEpXNnI1RVhFTTZTaWlXbXhUYjNub3hDd3FWdHph?=
 =?utf-8?B?ME5JUVhRVHJWYTQ3M2wrb3FtRUNYRUthNUFQWmhpQVlRWVZ3MUljb00vTGg0?=
 =?utf-8?B?a3BCUFJKa3k3M1lzMEtmcVVQZGNSNzN5NmlOend4WmhzS3pOalpIWFhrRWtM?=
 =?utf-8?B?ZmRIampZSnlUOW1KcGgvMTM3SENsaS9QaTQxOHhaMXdUT0UyYlcwVTNuczZM?=
 =?utf-8?B?MEtDbEtvVTJZM0JOeE40aUZWY1hUcUV1Y3BxaEVPR1dmRTgydG9ubE5va3ZJ?=
 =?utf-8?B?Y2pHQ245UVkrN0lxeXVuUHNsUURweTgwUkY2OHRmSW50OWw3OVlVZFRPWEdV?=
 =?utf-8?B?Y0srSW5yMXpPVXJkcXdUK2pKSnlnT0xGVjJPVUsxMG9FeVlGT3dtYThzaGZX?=
 =?utf-8?B?MHZSTEdteGxhUXd1czIzTVZHV0VSSGlraVh6c0RFOXgydXZPNDVydE1RR3lW?=
 =?utf-8?B?dnV4RFBiZVpDb0gxUnhkazgwY0ZKNjdlL3B1M2pnd2k1bFNLVmpyQlFpRnU4?=
 =?utf-8?B?YVpZckU3TWJOcDBueUZvbWZRdHJEVTBzN1oyNEQwMFB2eUR6WG1la00vSmRK?=
 =?utf-8?B?SVRTNld1TExXM0cwVW1pQUtXdDdtU053Nk1DbUFnTXAxZFpDbmdEZi94Uml3?=
 =?utf-8?B?LzA4Mk9WZFhkeDNJWTh1emgxdnFySzQxODdQcXZycjlOYS9pRUFQa1RDQm5P?=
 =?utf-8?B?V0c5bXlTM0d6cThKNWE3a21GamtxMFo2WWcvbFN0TWFyWnpCb041dUM4Y0Ex?=
 =?utf-8?B?Q2RaUkc3OUpCbGRUSGJSQjI0K0lRSWFMRWwzbUJodFI2bGJTN29MMytudzF1?=
 =?utf-8?B?elJSNmJlUHNReE5qOWZMWkwvbXhJUHR6MnNZY3lnR2lxWVRDNS9ORDM2ZUtB?=
 =?utf-8?B?bVNsclkwNnpoTHphaitKeTUxRGl4elNERU9oMkVjalM3cS9qUHlzZy9jWS90?=
 =?utf-8?B?TklvM0VaMTBqa0ZhZ2xzUUZxcitzSjZIWXdHS0xQUDZORmV5TTJ0MzV5ZXli?=
 =?utf-8?B?OUtqSG9RWmtrRzkwQzVaQkNpdW5mZ05oeFZnMTEzbEkrMkV1SjhEUTk1a0d3?=
 =?utf-8?B?SENuNk5yWDFSWFlBVTRPZmZyS2twcUN0ZFNaOHZITURlcnV3aFowOUxwZmxu?=
 =?utf-8?B?cVdvWWZtdzlHRmFDNFNjMUJBcTNaTGxsTXplaVN6OUJhS09Pa0RpemNPdHZv?=
 =?utf-8?B?K0tNYzM2MlZQMWoveFRXTERzYUpraUdMcVRxcDhkbzNUdzVJV25Xd3hwRDVP?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab9f151-2bbc-4803-56e8-08dc32fceca7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 16:48:26.4796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZjoKaD2uIJIhvi5+ncKNpjOjYkkbiSz4bUcgytZ5DHq+QFkwgZWy+NJhC0EGB2vzSoQe5Kh6GMtN+fX2o0jEfIeXCyxeq8M6GV844hPcLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6112
X-OriginatorOrg: intel.com

Hi James,

On 2/21/2024 4:23 AM, James Morse wrote:
> get_domain_from_cpu() walks a list of domains to find the one that
> contains the specified CPU. This needs to be protected against races
> with CPU hotplug when the list is modified. It has recently gained a
> lockdep annotation to check this.
> 
> The lockdep annotation causes false positives when called via IPI
> as the lock is held, but by another process. Remove it.
> 
> Reported-by: Tony Luck <tony.luck@intel.com>
> Link: https://lore.kernel.org/all/ZdUSwOM9UUNpw84Y@agluck-desk3/
> Fixes: fb700810d30b ("x86/resctrl: Separate arch and fs resctrl locks")
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 9f1aa555a8ea..83e40341583e 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -362,15 +362,6 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
>  {
>  	struct rdt_domain *d;
>  
> -	/*
> -	 * Walking r->domains, ensure it can't race with cpuhp.
> -	 * Because this is called via IPI by rdt_ctrl_update(), assertions
> -	 * about locks this thread holds will lead to false positives. Check
> -	 * someone is holding the CPUs lock.
> -	 */
> -	if (IS_ENABLED(CONFIG_LOCKDEP))
> -		lockdep_is_cpus_held();
> -
>  	list_for_each_entry(d, &r->domains, list) {
>  		/* Find the domain that contains this CPU */
>  		if (cpumask_test_cpu(cpu, &d->cpu_mask))

I agree with this change. Could you please base it on x86/cache
branch of tip? 

Thank you

Reinette

