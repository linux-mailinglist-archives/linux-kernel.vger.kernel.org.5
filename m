Return-Path: <linux-kernel+bounces-95900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A77D8754BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF086B2302D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5904412FF60;
	Thu,  7 Mar 2024 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fW9QfLPt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337112FF90;
	Thu,  7 Mar 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830811; cv=fail; b=PvgXWdpqGK8kuq7ncbsqkACmYaMvLAOH3yE/flHGoU3dJLXEoWUhhFF+SEDCmHV2pFfYUcALjNSlhp1TbB5sapciLJHMqJzpJKRboGqrEpBVo76PzzEkJRc/HWT1SxEdnTDmzlP0uekrVDrAb0VX2ocjfjRb276997fay6kHOXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830811; c=relaxed/simple;
	bh=Gn5lkvffQsDOgUR5AXMjsPIlmyKvi4ZpvahK7KBZEkE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SwTCHG/rxzPrK1WO7uDMULep2f5kgqsQDWN3OEWUpQIkiATAxJrjbk9OqdBUtdbpnq93ZCOnFY3zqRwQZeuHs0xZqvh/hLQ2gvbP9XVv8gTKdW1miEmdLtqZ4ODE9Xd/OHQe5w4+vUwq2Ve8wIqrYHlDHr4gNRyb/VWOW72ywVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fW9QfLPt; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709830809; x=1741366809;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gn5lkvffQsDOgUR5AXMjsPIlmyKvi4ZpvahK7KBZEkE=;
  b=fW9QfLPtLDslxurjfNhK6ytTSOP4DgtgPw4j0A68k+jVMwvUfyaFa5+4
   URM0KX7kjK7IrxKn3utmrUDJhQ3bkTpmBm4+xrI7lcgCwFtjXSJLpLxyQ
   7Wwf7glld6U0I0wm5QNIJ94wGt2X/frnLMwK7fWA6gxZc6bCDr/nzwbfs
   6OKs1gV0CtZ/FqwhFPrftIaXS/nBDh8ac2hk5vKVc+fBEU5woGUJKEmmo
   EZpNK72n8RCcHg62m2/6hx4c6pBJw+ysS6qQJv41CGp5n2URjLkds1MGU
   ZxY9bKNypFLvux8lnc42yZXGjowQbd1LZysUa9GMBZJBUbMysguy1OSZN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="8271350"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8271350"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:00:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="10064879"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 09:00:04 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 09:00:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 09:00:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 09:00:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4dUNMXCr4mdLZBtzAhkjLceif8L56UPXQoOjGqKtgyd0Lttv76GheVRC47qqqwLYqAkR+dKLM4Ahfs+/8GH21sp/hL9uHQxzRO5LFesuiErsRUcdXwFile10a3mUzhStSlTDkUXabOA77XjVHYpoQH+NgPWzG58LO8U8bZ3dCCPR+jHV25yv7d8YpFr9eIOQAnVyqHrg3I8TsAce3BQd2wFChhak+0Etr0GFqNJUpTAaeFcnGaPoly6Zb/ruYgf4BqWohKkOUEwKLeqSyDdSodTonzWp6zWRCntvJSfuy5Eg7PEcEWc5ItU++MgmJcMV5pnzMOb+SvNGMoqZIh3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJsS28n+fyYZlEBTbaHut41PEgDM7BuPCXq/RkMOdd0=;
 b=dc+B2jCHm36dmOQ+a+Nfyd2jfJUFvbFhQCuLWm0x0KHd19zZdTXowgLBJPp9GebS4Hny0371bBx77qxVWv/Kysr5Y1bDWM+BbWo/apaM3x+OHxMHOXN8jk85wDpTy9aCrN573Qjku+V6C4J4O1J/j+mB+2+JNlvB1s9vIM5hAlnHSO9c2lBfW1C62Oxhxv65EaFMazmeAq7aGueYU/tofMwgwHtQil3sVgE7zLUOuE9mmosPJHmx9mV0Zuh3gC3QjeH/e2PtB1CfajttpZ7vVHWk/tCO2vuua88OxcU4pd8/QcF565LXhpRRkAneWH6VIDtb/3sKKcdQ3lu57IDT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CH0PR11MB5251.namprd11.prod.outlook.com (2603:10b6:610:e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9; Thu, 7 Mar
 2024 17:00:01 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::940a:5c0a:1b08:67bb]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::940a:5c0a:1b08:67bb%3]) with mapi id 15.20.7386.006; Thu, 7 Mar 2024
 17:00:01 +0000
Message-ID: <3c2afc2b-85d7-4c2b-8a32-1a6b0f225328@intel.com>
Date: Thu, 7 Mar 2024 08:59:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/mce: Dynamically size space for machine check
 records
To: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: "Naik, Avadhut" <avadnaik@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
	<x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240307000256.34352-1-tony.luck@intel.com>
 <20240307121634.GAZemwIgbKKJGaUVFg@fat_crate.local>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240307121634.GAZemwIgbKKJGaUVFg@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:180::27) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CH0PR11MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: b890d750-166c-4288-07c4-08dc3ec80760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j85zwazqcVOySAdF8eqbX2bRfpaVoPOCxI66Dx7mcbI7nkyN1ve3H7GnjO/Vxn434W1OpGPeJmbrZlp+hxPsfIAAmGJBsbisxnkisRIiNOizDX2Fc6VOUjtrx1Lj1jYL3nPvV76DS2pDc1QLaN/q0F+hSM1GGA7dnMKL8+Vap7eskYy8tuyeZ6uPvodYSSUo6nQQEbZ7CXKGHaKkh/rxa5TVLjldFMb53Ho8RVKqxKIVSeT0eKaeBsbBxqJGTwgY1hOjqKXv/7tL9epVjkEK5kL66Ul4+j81ieCX/fe52AHXcKWfrY0thISfUEbX0U1fdV8LX+WiqH80+eiyRrq7V+W4a3tViSBg+QL0UdSAgBVHlBvJsTT44QHsZtd6peeN13uhIP9Ivu30J3X3gWbTInklzh1BWqkIP+lwFLoQlCZgOsZpSrSfhfVCw6Y0qXHvi87OlgFo09HR0EyFT/zD9ydNT7HCgIxuCKF0guR+snBgoC1xkpUmPZcVwdjjTHQvZ9cSLHLtZ16tj0xPkNO0dUgP2ZiBiG6WSLAHVS46Fd1Rx0mf1YRnz5MSM3OD0a8NAQCiGahYsQysBmQIzMD06lp/zVhE7JnNsJX8n+OPJESUGJujIMAYav2AHsQfXTlLtA+kE25hLMB2rkP23e6WhsGmLfflUN/UXrqSPPAgX+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1M1bnZmRkQwK0JsNkErZXZXclV5Szl0bDdLWVNBaktCaUlSY05nVkcyUlRG?=
 =?utf-8?B?WWFZdXJHV2Q4QkxQU1hkZ01TTXI1YUxoM1YybnVaMnNlUm5KUFRlWnZsRnkx?=
 =?utf-8?B?dFFWVkYrZ211aXVyK0RmNjRHZ0VkeXJKNE5pcmsrWGpRUlpqTmIwZkhOTEJi?=
 =?utf-8?B?SkFSVnM3WFE5enl6dm1GMTJVR3VuMmFIUmpMVklIMlJsZ3N5UzZYeTY0YVJL?=
 =?utf-8?B?VHpFZTVzeFVPT0RHb2JlcjJlZ296RXMyT3ZCUjFpVE1abmZvSkJBR3B4Nmd0?=
 =?utf-8?B?RTdDMTZrM3dxT2p2ZzNPbTlhdEtNalgvQmUzcS9sVEFyRWFVbnh3WFRKU0tU?=
 =?utf-8?B?MnoxU3RodHZrWllJRHpXQi9kRnl2dVZPTXhYSC8weFMxcU0zVGM5K1hOMGFn?=
 =?utf-8?B?YVFqallVeVBkN1l0REdCSmR4QzkrSWlSSk0vWlE2ZlB5b29Ra0RXekxPYkkv?=
 =?utf-8?B?ZHFxeHFzaFpLYWJGL2swVURwb3ljQUNwODR0ZnRkTFpVRTkvZGNSQnFwUVA4?=
 =?utf-8?B?TXZLVEFiNGlNR1BCc2h2ejRXWS9FZ2FLNDh5VFZRYld2dUlOalZZN1B4ZWZC?=
 =?utf-8?B?R3Q5M3lPcjMzbmo2Y0piRmVLTXZ2OURnNnFWRGxUVHdHa2pnV1g1WE1FMWxC?=
 =?utf-8?B?eEJyUk5rdk5BYnEzZzU0UXAyMHB1WkpnR21wQ0VGSzFKcDNqbkJpQWdJLzM1?=
 =?utf-8?B?ZUljVWw2NnhBMmxXZEdkMzllcWpDRG1FM0VmeE9UN24wTXRURFVzRVNiT3Na?=
 =?utf-8?B?VmlhazUrZTRHZU1OdWMzaDJJM2NORFhiZDVWVzFrb0xDelM5VzQ0ZjJqVlVS?=
 =?utf-8?B?eTRMQWdZMGp4dUtEWCtaMnBhT0w0VGpSSVR5N0JKcFZZbzJkOUJJSXJESm5j?=
 =?utf-8?B?bXl1NytHTXVZWEVGckpZOUlwdjNYZmU4VEVnN3BKcmVuTlBCa2lMc3dIRUdT?=
 =?utf-8?B?SWkxNzRQWUxiRkhqQjl2eWNVZ3paKzFJcGg5U0hSdnNQNW12cTZaZVZsanE2?=
 =?utf-8?B?MStBUlVqbDRCZzNsN3YxY2R0UXQ5TFloSEFQazRkZTVPK0pxZWd0NjB1S2ZK?=
 =?utf-8?B?UlFXaWd1S2lpRGFxRkR3M01TWll5KzU4anVjYmFxaEVwUUk3aUhZdkliY3BH?=
 =?utf-8?B?WkZMOEo3cnNtQlRua0VlZ2NOWnhIUDhoT0piWWcrRERVTGJ0NSt0aVRyeXIw?=
 =?utf-8?B?TFF6akZHRjRtWUsrWWs2aDJtZm9mK1hldndXZ01VaFhqbThURXJOOTYvSGIx?=
 =?utf-8?B?MldLa2VUQ0JxMmlubTBwOGZsTlVnWExZdFlEeE14cmFFdlA3R2J1RzRNYWV3?=
 =?utf-8?B?Zkg3WEs3S2hiaDlGeGRTeXR0VW1Zbm5veElYRUViNUIzUmp2bFpRdC8zNzNw?=
 =?utf-8?B?NDlmQ3hNSTlpY04raXVRa1E4MUxtcEYwR0lVYmFsVU9NMksvTkpIQzJkS3VX?=
 =?utf-8?B?S1lHMUQrTTYyaEFtQ2JMY1lJN2RkMmRpYTJVeE9qTUQwazVQVnpzQXQ0Wmda?=
 =?utf-8?B?MEZQT0RWbnRiQmNWb0dpaisraWRUb1p5SThiNjhZK0NPaVlacTdVVmhYY1hh?=
 =?utf-8?B?bXFNdmY4QkxSam5Yei9LWVlXNTZrc3RRQURwenFXR2VCT2dtV1l2OTBTM0h4?=
 =?utf-8?B?aTZzMCt2bDFQd3hXTkUxZUNVeVFSUFF3d3R3Ylh4NEdIaWZjeXlSLy9pSzNC?=
 =?utf-8?B?TDN4L3lGemx5N1M4cWZwcHNNWFpXbUt3N2hwaVB2aEwrV2ExcXBYRVJpRlpa?=
 =?utf-8?B?Njc5RkVkSlhmVDEzNFhjSFdOVjZWeVlZay8wMDFCdjJrRldKTUV1aFVEejFW?=
 =?utf-8?B?TTUwNGtkQmJISXJPNk05QUZ3NlM2SnByOFZWaGFWN0svc3VuUkJrTmZGR3VV?=
 =?utf-8?B?azBYaFF4eUdmQTBJaWUvaXJoVHdaRndhL2RQTk9xN2NyZWxJSkV0MlM5US9p?=
 =?utf-8?B?NURGUzIyZTlSZnl5STV6Z2loK2thZnFkWFZZWnRKUDhTUC9CVndURm8rbEpC?=
 =?utf-8?B?VkZ1MktEdWJRQUZiaUxtME52ZE5iWjdKcUdpdENEYTNyYlhLMWVGb05tc1NJ?=
 =?utf-8?B?SG9tV3ljVjkrdTJoTUpRa2Z1VE5vaFpjS0NlS3BSY21XWkh1amVUMzdRU3V5?=
 =?utf-8?Q?VLs6/2PGbxPXvtmPHIX2OEWfR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b890d750-166c-4288-07c4-08dc3ec80760
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 17:00:01.8821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7iiwOvNGnd4CjZFy5cfcYYHJh4w6KkdX0WDCk5Yc7S6f6o4SxWm42ICAU7BO6nBYH5JsgdcXosBsYhIiZBPHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5251
X-OriginatorOrg: intel.com

Hi Tony,

Overall, the patch looks good to me. Independent of the minor
suggestions below, please feel free to add.

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>


On 3/7/2024 4:16 AM, Borislav Petkov wrote:
> On Wed, Mar 06, 2024 at 04:02:56PM -0800, Tony Luck wrote:
>> -	ret = gen_pool_add(tmpp, (unsigned long)gen_pool_buf, MCE_POOLSZ, -1);
>> +	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
>> +	mce_poolsz = mce_numrecords * (1 << order);
>> +	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
>> +	if (!mce_pool) {
>> +		gen_pool_destroy(tmpp);
>> +		goto out;
>> +	}
>> +	ret = gen_pool_add(tmpp, (unsigned long)mce_pool, mce_poolsz, -1);
>>  	if (ret) {
>>  		gen_pool_destroy(tmpp);
>> +		kfree(mce_pool);
>>  		goto out;
> 
> Might as well get rid of the out label too since you're not doing the
> error handling pattern of jumping to err* labels and then unwinding. See
> diff below.
> 

> diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
> index 42ce3dc97ca8..cadf28662a70 100644
> --- a/arch/x86/kernel/cpu/mce/genpool.c
> +++ b/arch/x86/kernel/cpu/mce/genpool.c
> @@ -126,25 +126,24 @@ static int mce_gen_pool_create(void)
>  	order = order_base_2(sizeof(struct mce_evt_llist));
>  	tmpp = gen_pool_create(order, -1);
>  	if (!tmpp)
> -		goto out;
> +		return ret;
>  
>  	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
>  	mce_poolsz = mce_numrecords * (1 << order);
>  	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
>  	if (!mce_pool) {
>  		gen_pool_destroy(tmpp);
> -		goto out;
> +		return ret;
>  	}
>  	ret = gen_pool_add(tmpp, (unsigned long)mce_pool, mce_poolsz, -1);
>  	if (ret) {
>  		gen_pool_destroy(tmpp);
>  		kfree(mce_pool);
> -		goto out;
> +		return ret;
>  	}
>  
>  	mce_evt_pool = tmpp;
>  
> -out:
>  	return ret;
>  }
>  
> 

I was about the suggest the same thing and maybe slightly more. By
initializing ret when really needed, I find the code a bit easier to
follow. No strong preference here.

diff --git a/arch/x86/kernel/cpu/mce/genpool.c
b/arch/x86/kernel/cpu/mce/genpool.c
index cadf28662a70..83a01d20bbd9 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -118,22 +118,21 @@ int mce_gen_pool_add(struct mce *mce)

 static int mce_gen_pool_create(void)
 {
-	int mce_numrecords, mce_poolsz, order;
+	int mce_numrecords, mce_poolsz, order, ret;
 	struct gen_pool *tmpp;
-	int ret = -ENOMEM;
 	void *mce_pool;

 	order = order_base_2(sizeof(struct mce_evt_llist));
 	tmpp = gen_pool_create(order, -1);
 	if (!tmpp)
-		return ret;
+		return -ENOMEM;

 	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
 	mce_poolsz = mce_numrecords * (1 << order);
 	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
 	if (!mce_pool) {
 		gen_pool_destroy(tmpp);
-		return ret;
+		return -ENOMEM;
 	}
 	ret = gen_pool_add(tmpp, (unsigned long)mce_pool, mce_poolsz, -1);
 	if (ret) {



