Return-Path: <linux-kernel+bounces-125175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57D78921AD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EE4288327
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9732D781;
	Fri, 29 Mar 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8rqrXgu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7F2C861;
	Fri, 29 Mar 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730239; cv=fail; b=uubpJlRlTDRl8u8m2JkmrtU9kwBBcYL0mL+hH11DrC0WnD+kcXx3e9Bbk83rlx+w4RP0Pld2yJaKJzjDR8NHC2Gbf/SjSmmoTNKUVB3FKhkcFh4hWfXvMSnUsC3HS9lR7NOF+KHkQLvGua2bIh6aUamLaNXJHad3qJnDYzpTKhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730239; c=relaxed/simple;
	bh=7MfFRh6Sq9kFy1WiwyE+DeKFlERNevGTN5nAtTFxaA4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oh8LbuxCitqT6oRIv9qNKH8S9e6a4X0q+IgQb4hC1YmZu1YDIhWAE9nt8yt9eM4ZpaIU7zdT6Di5axPdO5Gh2iP3mxfWViFblKO5frjDmL8l26A9QDYHHhS9Puwya2WExb6Lz0fRwjRSEk96K7SsuhEmvIcz3uDaFqVW+6GMuHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8rqrXgu; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711730238; x=1743266238;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7MfFRh6Sq9kFy1WiwyE+DeKFlERNevGTN5nAtTFxaA4=;
  b=c8rqrXguBu6jo5OVfiK8+LISgZj5D6r2yfCdmRRJfJlJYcCgr4DBzrzg
   +UpGAlB2S2vQjQSK+geago02e1uAGC5LRUDBNkyTXT2VG+xxyz1nQaDzb
   4PLJ2KvMHZ+Cf6uEIfMkYV1CqJ0zqOH/dV0wGu75uyr/p8GnHFUwbA+Mq
   gieLj6C0uITGn/Y5eS8mGJU8oBp3pHp2VAq9wQzr2L0Z27fIX5id2vqUK
   ZvOX0AtIwnxbVremEz2jJUV3hlh564Wt1wjWQYQp3yzd16XiUNZAKQt0V
   mdKchmC0naRcYbO6q/j0uCtyhcxaEZJezKxcQC/vJV3M+fB5XT5pFfCP2
   Q==;
X-CSE-ConnectionGUID: g4dkGtrnTF6jvcViF7YM1g==
X-CSE-MsgGUID: UTB17yvPQEe0W5a3dIMVjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="18070775"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="18070775"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 09:37:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17097107"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Mar 2024 09:37:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 09:37:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 09:37:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 09:37:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 09:37:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQvEtzwZezwbU1UYUlhBDB39FXgi/5b1qO2v5fHOdFh4En0of302JjeSKI3hIr0NuzJKm/hT92KzOEs0iE2lwJz5F6Rq3CBSj9fnzrRRaSBd99ow3i79pfDwlqmfv2gmmBROSM9/umQP2XeKl0E91n4PckRKn+X1RrD3EUkmGJe1xQIFnmbmzxxvBzxzMicKkGuzD27sYPbv04EeFitTa4MfidK/qULvIvkc7XaghzKeVCj68Aqyb0Z46wuvE4S7XqUAMYAHlw1kITnfdpXtdfa27S+8zcI6laWfTzs1xGPIYjBzPfNlhN6J/GBEblvRkXOhaY8M6vxTtUz7jveqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTEgMxeQbaFhxlvBmSbdvtttnVBaUGYQkqod0cViD4M=;
 b=Ppchthofuf9sQ6IgSxpp0KkS1qp8/XT5Rw8y0ROP5FKwslTImScl8dXEt0MUTPZrtDIvuMdojPNX8IVOX6I+Tn+mIlOOAjmvNkiYR/nsi39r1HeYZzpTYJenWqbMxMWfeY/EIznbPNo+Vb0SA+TVe6W1+ERXMOm2KphroYL/AB6mG+xhcSWcGhkMNa7oT5aOFbsMx/dtuwFhSepem3qhLNppaCyR70J4TF2XIQz7ts954AMIuAz/bnlJkjQCvrmk6suJH0LqykESud3JAIFm+O9keKEOs2skzSjEb725wQ65tpO8QugF2VF+42b8HWxXb0mh9N+x/+eDtvlwopfxIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB7991.namprd11.prod.outlook.com (2603:10b6:510:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41; Fri, 29 Mar
 2024 16:37:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 16:37:14 +0000
Message-ID: <cf59f587-9ca2-4f0d-b412-69b559acbabb@intel.com>
Date: Fri, 29 Mar 2024 09:37:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/x86: Document resctrl bandwidth control
 units are MiB
To: Tony Luck <tony.luck@intel.com>
CC: <linux-doc@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, James Morse <james.morse@arm.com>, "Babu
 Moger" <babu.moger@amd.com>, Drew Fustini <dfustini@baylibre.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
References: <20240322182016.196544-1-tony.luck@intel.com>
 <56a93ec2-dc01-49be-b917-5134f5794062@intel.com>
 <Zgbe2FFwyHMmmsyM@agluck-desk3>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zgbe2FFwyHMmmsyM@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:303:6a::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB7991:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QM1hDjFFCHQvl1lh2Dp+8jPBuJUiYZ5JGjtGISZW9F+e0mI+Xl52jBbVC4iQXv8Aq6Plm3eES788HqbrLbWbYfwZcTWT7RLuITa89eYqLNV4wQYL1E/55QXX7IUIF+2dYlFtvPPPerWni6sd1UvS4Ft8wBPYHbVWLpegasiDpF6jOLnFOuzo+N7rdMzSdSitMVd3XjaQERnsIexkfHEvXRUajTZYcA1l+2EogizFksLLf/rfHKHQp+zyUhvAk+Mi9YF5QVmM0rlK3bDaEJHHhWAVVyhFF/v33SbdWTkDI5vmaAjy78DbYQewmFIKL4sM/6l8q7PXcKMSvRG+l3GHG5xNRKSOnS12LknFEI1xMzPEac+/h7N95Ep39FsnH7ApLACwUViKyYsBCYV/z5WXMDQkToWTdrQKmasLovaooS40P7G6hKKEJYLsJ3CVbcjsG8b/WSeQcGlE4AgFOTyzQqQ6v51pWLdqq6ggdB3I5We1emesSUWaqyClFBf9KchcN95+7idkA/cBou9kEnJAJQHZoe5sR5BlJBnqmNdI9hVJi9QV5Ckcw0+jaYI70lwM27Ly7grzxl3iQNtkQXmjoSsU+bQSN/ZA87E6bNnushnHb1Nm9i43qkIdt16d+qR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzZYUDdSMVJXNUpWSXU1b0JrOXhRckNXcVllRGM1UnhGVFpQOUhwQlpBckRW?=
 =?utf-8?B?R0VZRnNKR3lnaTBsNVJwYlRvS25EUXBLK3VmRVQ4SWZyTjh2Uno4cVY3YkZl?=
 =?utf-8?B?MlNVVXZITHE4OFU4U2xET21qZ0wyRFU2U29aMzVIME9oNHhHVzIvd2o1blhx?=
 =?utf-8?B?SThNb01CTnZnVHVPU0JYN0Z0cDVKMzJnbS9pWGVwOFdldUh1a2lOSzJXOUkv?=
 =?utf-8?B?R1hXRjdqR3lWbnNqNWdCWnlBZlVGN3AyR1FDVWJTOWxhODgrdHdRSURIOGll?=
 =?utf-8?B?ZVBOTmwvTlFPUDlwbnR6VjZ3bnlZUG10NWM2SmRENXl2MEtyODJheEt0YnF2?=
 =?utf-8?B?TnFTZzlWZGxaZlFpWmlRZTdDMFFpbnk3OHJxN1NsZVZ4VE8ycDQyaHJXdW1P?=
 =?utf-8?B?NkdGMGxZRkhGNC9qWGtoazVVRmxLYjVsb3JHKzVmYjlsb3VrcU9WckFJdjNq?=
 =?utf-8?B?cDZGczBUOVZucFZjTlpQUklReWdlaFFqaXNPNk1vNTVwQi9hRW9yd1l6bDly?=
 =?utf-8?B?N1VFNXRWcWZ6RlNMM0VTcFdVUHJ6c2NUUXRhcGhXNnNIaCt1R3RxUkt2dzlH?=
 =?utf-8?B?M1VUZDRoQ2JYZ0VMREJhK3d1U09LZEpmS3FUVHdrV2hJNUwxTThIRWdXcEpN?=
 =?utf-8?B?b1h3Y2ptR0t5S3dqdlArUGFmRCtzRUdEaE1VRlJLZGlCUlZvSWYxTlNMaFVt?=
 =?utf-8?B?KzdOOHV1L2RRa0RFVVFPR3UweVYxdk5VRnlML0VNd2R6ZzFCcEJpdm5BNklY?=
 =?utf-8?B?eGN1ZjltT1VRUzkydlp4bFhISDV5ZFdDeExSWnZGWHRWbzZTT05Bb2UvZjZJ?=
 =?utf-8?B?L0IwVjlRNG8zZWFkVGFKWWFkeElEci9paC9vT2RndHlnSTYrcTRVMURVa0pk?=
 =?utf-8?B?TWJyQ2ZWZ1M5Y1FuN2N2KzY1enRvRlZPV3ZoUlNDT1FRVWFJRmt3ZFdSYTBF?=
 =?utf-8?B?NWUvcmd5bWdjbXpybG1PcHliZGZwLzFjcE0xaEkrall3eHBoc1lpVEU0akV2?=
 =?utf-8?B?eFp0S0pqcWRDR3laNlBSME03cEFhdG9WUXNmcVNhSFEzSEVkTm1UVUF4cTkz?=
 =?utf-8?B?L25zeVNwUUZrRU1QcDVkL1JxV2gySEphTngydkxIZ3NGMVJzOW5jdnVSUkUw?=
 =?utf-8?B?NUVtMGdZWDgzZnB1enJzTmNlRnRFYjFEeWNRNGtwVm90cVhySHZrMis3SVl1?=
 =?utf-8?B?MkFOOXlCMFRhRVdTRWZtTlFFV3JtYWpOcVgxZWkyaG8zM2tpM0FkT0syT0NI?=
 =?utf-8?B?WXU5citQeFhOdmh5NzdzdU9MUFo5ZE5IanhDdXRyeFNRTVRYTVNpS3RzUi9D?=
 =?utf-8?B?SFVoaC9GMktWVGFQRzlReUg1WjcyRVhaa3VaL3psZXlHK1dXVHpIQ2YraDd2?=
 =?utf-8?B?K0YwcjB0ZHRJMUpPSUxhcnE3T3dxTXlidUZRMlZSUEV3Zzc1RWFKMDlmelV0?=
 =?utf-8?B?cWRCVWxramF5ck4zWkJwU25jdmxSTG1sMUpHUjFRYmpZZHJDcjRmemI0OXcz?=
 =?utf-8?B?THQ4OThzUVFkUmdEU2hzQ1lFT0VVcUNBS1lyMGVxU3o4UmNhZ1Avb3Rac0VD?=
 =?utf-8?B?S2FzbFNGTDJmY2NBYnBZaGJWTlNmcStmR3U1dzJ3NlE0MTQ1djlwbHZnai9q?=
 =?utf-8?B?S0N3aVVDNk84TG44UG1Panp4OFdOS3ZVSkw2QUNHNUMxV0ZnNHpocnd4aU9Z?=
 =?utf-8?B?aTNmRVlkM1FGcUZ6SzNUWnV4NTNGS3pDeUFXMVZQS093N1YvcmZGK0I3Rk45?=
 =?utf-8?B?SldoZ3dWcVk2dXZZczF0bVEyMEJoSkJFY3VLYkhnbDJZQkc0UTNNM29pa2x6?=
 =?utf-8?B?eEIxaVFYNEF3akE1dEkvd3B6cXczZ092eFY4NmpQY1Q4YXYxK3dUZU1GcEVm?=
 =?utf-8?B?YUdjME8raHFVSU5sQ3EwczR6aVUyU3NEQlRNTlJmeWl4TWhMTzNFdkdSdjRF?=
 =?utf-8?B?Nk9LQnh5TS96Y1F3YVoyUjB5Q2tUOGx3NU9MWUR4eXJCVVdxek1USitTMUhQ?=
 =?utf-8?B?Z01vSmZqendiRDNVclpPSmQrOXpuRUFsWHZhVHR2NE5YVDRqYUpDME1qT25L?=
 =?utf-8?B?bWxwQmF1MldHRnNTZ3F2N21CSUZFL2NUb3graHNpSXNhcUtwSjBGNDBJeDdR?=
 =?utf-8?B?bzVxa2JnNUx1SjRBV3haaTlNdkxxbktZVW5FZ3NUZmhiWklOa1N3YTNKUU1N?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0214e82-ec9a-4dd5-b2d8-08dc500e7d68
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 16:37:14.4824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYnZnSHBZjQXoipLZsQyfjCBQ37OJ5c2TlpJZqeIH45qswqF7o7ac5HUaGWVZNznqxD0bV91GhCvkNcwlsycT58JuFpqP8aOgOiUT/dfP+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7991
X-OriginatorOrg: intel.com

Hi Tony,

On 3/29/2024 8:31 AM, Tony Luck wrote:
> On Thu, Mar 28, 2024 at 06:01:33PM -0700, Reinette Chatre wrote:
>> Hi Tony,
>>
>> On 3/22/2024 11:20 AM, Tony Luck wrote:
>>> The memory bandwidth software controller uses 2^20 units rather than
>>> 10^6. See mbm_bw_count() which computes bandwidth using the "SZ_1M"
>>> Linux define for 0x00100000.
>>>
>>> Update the documentation to use MiB when describing this feature.
>>> It's too late to fix the mount option "mba_MBps" as that is now an
>>> established user interface.
>>
>> I see that this is merged already but I do not think this is correct.
> 
> I was surprised that Ingo merged it without giving folks a chance to
> comment.
> 
>> Shouldn't the implementation be fixed instead? Looking at the implementation
>> the intent appears to be clear that the goal is to have bandwidth be
>> MBps .... that is when looking from documentation to the define
>> (MBA_MAX_MBPS) to the comments of the function you reference above
>> mbm_bw_count(). For example, "...and delta bandwidth in MBps ..."
>> and "...maintain values in MBps..."
> 
> Difficult to be sure of intent. But in general when people talk about
> "megabytes" in the context of memory they mean 2^20. Storage capacity
> on computers was originally in 2^20 units until the marketing teams
> at disk drive manufacturers realized they could print numbers 4.8% bigger
> on their products by using SI unit 10^6 Mega prefix (rising to 7.3% with
> Giga and 10% with Tera).

This is not so obvious to me. I hear what you are saying about storage
capacity but the topic here is memory bandwidth and here I find the custom
to be that MB/s means 10^6 bytes per second. That is looking from how DDR
bandwidth is documented to how benchmarks like
https://github.com/intel/memory-bandwidth-benchmarks report the data, to
what wikipedia says in https://en.wikipedia.org/wiki/Memory_bandwidth.

I also took a sample of what the perf side of things may look like
and, for example, when looking at;
tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
I understand that the custom for bandwidth is MB/s. For example:

    {
        "BriefDescription": "DDR memory read bandwidth (MB/sec)",
        "MetricExpr": "UNC_M_CAS_COUNT.RD * 64 / 1e6 / duration_time",
        "MetricName": "memory_bandwidth_read",
        "ScaleUnit": "1MB/s"
    },

> 
> It is clear that the code uses 2^20 as it converts from bytes using
> a right shift by 20.

Right. This appears to be a bug.

> 
> Fixing the code would change the legacy API. Folks with a schemata
> file that sets a limit of 5000 MB/s would find their applications
> throttled by an addtional 4.8% on upgrading to a kernel with this
> "fix".

Wouldn't this be the right thing to do though? If the user sets a limit
of 5000MB/s then I believe the expectation is that it should not exceed
that bandwidth.

>> To me this change creates significant confusion since it now contradicts
>> with the source code and comments I reference above. Not to mention the
>> discrepancy with user documentation.
>>
>> If you believe that this should be MiB then should the
>> source and comments not also be changed to reflect that? Or alternatively,
>> why not just fix mbm_bw_count() to support the documentation and what
>> it appears to be intended to do. If users have been using the interface
>> expecting MBps then this seems more like a needed bugfix than 
>> a needed documentation change.
> 
> I agree that the comments need to be fixed. I will spin up a patch.

It is not just the comments but the constants and variables also. All point
to MBps.

Also note that there remain several examples in the resctrl doc (see
section "Memory bandwidth Allocation and monitoring") that continue to
use GB/s. Are you really proposing that all should be changed to GiB/s?

In addition to all above this change would fragment resctrl even more
with AMD's memory bandwidth control clearly being in GB/s.

I continue to find this change to be the source of confusion and diverges
resctrl from the custom.

Reinette

