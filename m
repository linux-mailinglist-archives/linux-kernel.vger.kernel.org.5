Return-Path: <linux-kernel+bounces-83254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374818690DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE22282E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2A413AA41;
	Tue, 27 Feb 2024 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NoR/4tdL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926C135A61
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038056; cv=fail; b=gSif2LUbi0i09hYFQkV41Po8yzHLTiY6CqzSy31StKruoB9ePDdiQnEYXdalnNshubbV3xRni6KrrXWLs2qLcCViatFgkRA9jW7fxMr1GbPLb3gk+dCLhfVHaZW1+AFBJVBJKFEGbZx/ZIIXaYdVXUS1DOAYFaN6sq7+KMiCgxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038056; c=relaxed/simple;
	bh=GueKNpx682ZAJsJZJfNRwnoCV392Epu1FpAyVZQkGH4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZNetMzcYR0Vd1M52wQC/03LN2FfyjAs6RpHyKtCGP8Or6/VHeRI2sJfXTzl5jVz4Fb8ncPeFcpfU8TxPn6OCV7GbWdHTt7wupWz6gYtfoBo0gBSET/blBgexhucWyCUzeTSVs2mkzbROCJQF37cPYRmDIrJA356r0uIHoP8YVuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NoR/4tdL; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709038054; x=1740574054;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=GueKNpx682ZAJsJZJfNRwnoCV392Epu1FpAyVZQkGH4=;
  b=NoR/4tdL2pwhm+vH/rcJ+EBVSlLClbklv7m9kUBWfK2fK9O8mdZ4jfuI
   tFldL++kHYhwVex7GsMvYVq3msnVNqB08pbyLWnYQhhEq1aFPbohNf794
   NJJTf1SrezIPMDfdlMZNlLBncYg1cNlVvIMvpZPNx/BofMWDyVhiFQ97H
   Yba28gcChpfrkToViQDtsLiDgCSAfsvDDlBVsC8KMPI2+VjVfxFPekEg5
   Mx4mKNGrgS6b5RN8GFDrMng03GaHKfkb73iewFNG98w2dZSWSwtLo8QuN
   eLCCnzNzY4HWMmynudXOfMNuRBnGkRrjGvhunawKM9MQoRssg4RKgpFX4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3503002"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3503002"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 04:47:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="37846414"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 04:47:34 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 04:47:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 04:47:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 04:47:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXRN5SZxoVXleanYtxaUJuWs85UrD2eb2N1n8AWtCkuRJhTMUgIzaFd8QvUQkTlK6hmEWiGFzOVT8ovVm/jCIpqzVFBWFFvzTndkdp6iGMr7CXuNh5BMzxbIYC0DbEBnLqqBnjsCs8YOedPCIun1tmeSo2+L3ZwyjBtATMLk20f4dLN7tm/XlPWIM1fpaHPK6EQZsf+Ityjzeb8N4z6qY3IeKLK07VcebM8Xu1SJlgsD8yh74PipXVay9X82nnW12kL0sROK1G7iQahHKS4p3PjakqYAQBQateRHXl6lZdOk4/i9b2kNPe9ZU7glbZTuI78Pq4Y6rz3Qdraqth3kwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz6bavHIx0UjfueS0LIEoK4BRJS83gMyLxQFZtbLfms=;
 b=fkNKVwsLBwTipb/9PDEWMAlzvYjzLuHwTBNkOmmdE5kP7xDq7mb8Jus/TeCX2OIDzaEIiS2ztG4BHVMoAqZhbVE/JBQFE51PTchnugTe8Wvfqpd+ZcDNRQtJEn+IzC1V9jDI5bz4vm3FP6ke9DtWW7Ufk5G5nSX3d3sOZS6oez2wub6qq2WAH56hqEb9qCSLZOOzc2+sRR/PaB7Cgw+oPjSLgKspvUqRldR+I4R5zyIaB6DKPx0jdnmoj361zzV5NT7qi3CbfPunC6hHA6ZE7ilw1vjb8XqDes8yGWtEfgqVc8EftbhkJFaddPqcybd4iRSRCb2AyWdodIoP350Scw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12)
 by SJ0PR11MB5895.namprd11.prod.outlook.com (2603:10b6:a03:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.26; Tue, 27 Feb
 2024 12:47:25 +0000
Received: from CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::5db2:5364:970d:d295]) by CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::5db2:5364:970d:d295%4]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 12:47:25 +0000
Message-ID: <5c030391-d8df-45aa-b4e2-73c45fbd1d97@intel.com>
Date: Tue, 27 Feb 2024 20:47:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix definition of _PAGE_NOCACHE_THEAD
To: Alexandre Ghiti <alex@ghiti.fr>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <guoren@kernel.org>,
	<jszhang@kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240227124412.2565716-1-fei2.wu@intel.com>
 <20db97b7-6225-42a4-9f2a-b926aa26b7aa@ghiti.fr>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <20db97b7-6225-42a4-9f2a-b926aa26b7aa@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To CH3PR11MB7895.namprd11.prod.outlook.com
 (2603:10b6:610:12f::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7895:EE_|SJ0PR11MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: eecd42f6-6b56-47aa-f79b-08dc37923fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6T/ln15Ft7Cu7GWH9C826j+W2IaGx5T8oYInaCk7A1nAcG4hDXSZdc3C1FRK07WDK/YXhzkk86R+ClK7sE2n4LZAWyZ/8TLpr/9qs9LEf9g1My2fkRWZ/RuGqxV2gn63ZKQWl0ec6LtA/vPreQ1x1rKj/X56VtvS3jl8PzTeERxODZ5qfjBntmbhiXj/b4zI8oMTsEmj12QC+wNeGv+XuMk4LCzgBR3XDtyO5ZDImuuKi8L0K7vQrOkcNTnJ9SsE6NmESr9Ggz+qiFhOHbmap/sZ8Bc+RT4KQWv+j19sE/1z6cEQ/72SkYnEnNGL2SHit2mw9Z2F5eKmJmy8wNH7VavOSWVp7M62N70D8+FZ8jhpB/crk668TMwteIcZT767/Sfyuffx6SDG7KDllrQYoN/CAnUb5Z89pqjV61agLc+YWSkYa/8DDXoQ3c/leLsg3tYAFMxMCT6LcBnQjQixz0lonagciz4bOtdl9UmpXbqOcvq8mqdkXtRfQZEYqznbFvxW7BFnnWI64Nld1q3fZ+Umu7lInZWZ5qHYyq1MtnRd/uKw8k52DV1qwwSqCPl038EP75jN2/CzyxKCOnCXwbtpqLswHV3dkKYzp3oXPkJdi1l6tRF6zplHzp8SQBG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzJPd1BVV0p3WVR6RDhWSE5Pc1I2cE5qQ09HcTJpTDZYTkR1Q1A2YUxUSm9v?=
 =?utf-8?B?Z1JuU0JDQ1ZxRE5NQkNxUEVNTTVqc0FpTnVaNGFPay96N004d2taa21NOGZz?=
 =?utf-8?B?LzJveVJVZ3FmR0xHMm9OMXh1dXNVZGN4d0RNdWUyTUUwRkp3ZUkzK0xhUG1n?=
 =?utf-8?B?TEYrSTcvWEJRSnQ4cC8wUUREOG1iSS9LQVEvc2ZDZXRiZzBjZXFaaUsyS0ZB?=
 =?utf-8?B?RW05NTd6eERueXRtMVZJZWJaY1NZTTB6QUJXZjZlNytSQTZoUXVrTnRiamtH?=
 =?utf-8?B?T2p3Tm1IYkwzeGtYc3FRU3d2VW1yT3FIQlhjS0FOa25kZzROK0RiYzNWV09I?=
 =?utf-8?B?cm9mcUhlRnBxUURxeTUxTHRiVmF1WGJIWlVGZVlETkFPaytvNlV6aWxNWnZ3?=
 =?utf-8?B?T0EyZjQrRDdTb3RDT0xyYkFEVkRJbDU1N0hPOXRsN3k4Qy92eEVYU2sxckdZ?=
 =?utf-8?B?MWVlRk9Id3dDZExSQ3FtT3NMT1ZyWUNSdjlLWGhsSXBsNHo0SHQzaC8rN0V3?=
 =?utf-8?B?Mm5IV3NEQUhDWkczNlhuMUM0MTdHd0U2N3FLMjJCS0dicTRRbjZUVEphMTNl?=
 =?utf-8?B?ZW16ejRGK21HNFhRaDhNMTc2YmhZOWtRanhCaXZHVUxwaWNLZXVkRktrOHBx?=
 =?utf-8?B?WmlqTTkvd204eGpZa3lXUDZKMktXZzdZUHE4QnlWcjRNSnhTWlBKSTdINDlt?=
 =?utf-8?B?TmtaMmNqR25IR0U2c1E1MG1vQ212cm5paGpkVmpWU2hwNTViWFZFN2VNL3Fu?=
 =?utf-8?B?S0YwTm1IdGlVblhWNkQzdmlsbnYzMGQ1RVI1SXJGZ0tNVzFuaG50UFpxb0xp?=
 =?utf-8?B?M0gwZzc4bVVZdXBLa1E3OWxwYXNLTStWR3ExNFR5ODF4N1dEKzBjdWNFaW9J?=
 =?utf-8?B?cmVaU0h6TU9IRzA1YlNSWkw2Z0twZEVrNlBKOUZxeTZOTEoxKzFEMTlBNmJL?=
 =?utf-8?B?bFpIT0xSQmN4YnQrOHlPWFRCMnZUcXNKQ0Q4eVNuRm9GVEJzakg5am9qSkx3?=
 =?utf-8?B?b3JXb1dLaDBRMHVHODZNTzZIenhYaDZhQThNbXhncHVGU0xESERKWGpoYmU4?=
 =?utf-8?B?Ylh3S1piMmpjUEVnMGIxLzcraUVLRlZKSDA1YXM5OFQxRnpMSVFHU0N3emxT?=
 =?utf-8?B?RlQ2Z01zK3NkdHg0NlBydGQrK3lGOUNUb0VTNnB2UWRraUN6UkFkckdlN3JG?=
 =?utf-8?B?Nzg3YlVtMFVFYmtlTFZOMG5hRmhqQm9yN3NnbTFoMnluNlJ6RUpHRTVOYUJj?=
 =?utf-8?B?U3I0ZnlGWTg1NzcwYy9qRDQ2cko1bGxicUtPRWorUU1SKzdJMEF4YmxrdjY0?=
 =?utf-8?B?SERieXF2eHI4cE96ZVZHTDJ1M3p1aGp2a0lzMy9TVFV6RHZwRnQ2dGxQTllK?=
 =?utf-8?B?Z291SGh2OUpTN1lnOFNaV1hKL1IrUGpXYzVXOW9nWU1zcG5HWVBqZ2dtVTVZ?=
 =?utf-8?B?akJGekxqWVhNNVdVeEM2NmdjSy9kK0lmYnF3ZC9YSWdMaG5CTTJrV3RqMVBk?=
 =?utf-8?B?L3RrS1ZhOXRxM0E3bGNmKzdWS3BuUTBuSnJMVjFTZjQyd2tOWjZwTERTejdo?=
 =?utf-8?B?VmJRL3NRN0xMcjNDeFZTbnplK1RTaXlFWWJ0TVg0K3V0aXJ4YnBrNjJmcFFu?=
 =?utf-8?B?SGFlY2x3dzdEWXVFY2FPczY2bnlRNy83a2JQR2RXYUpLNmVwVGZDREs3aEpy?=
 =?utf-8?B?N1lzS3JWb2wvWERCWlIvK2dzRmYwZ2thWVd5aEttYXRGeWlRUVVzalVRdmQx?=
 =?utf-8?B?V2ZJNHc0UFZqQm9pQTFVRWhUVXVIT0ptdGNieVlLcllxSmlRcFZMZnV1M05V?=
 =?utf-8?B?WG9oU0lHWW0yRTBoYlhoTXFPekRTK3ZkMTZobFJXZnY3U2JpRDQ5RWxCY2V4?=
 =?utf-8?B?QkZOUkFvckpTZkNpdmdEams2dmNzMGNqaUZjRlQwL2JkekhGZElibW5vQUI4?=
 =?utf-8?B?UWsrWDhVdDUwRVVTNmE5WFRhV25Cd09Iemg1TGVrVTgxa2lYYms3bkhic2xT?=
 =?utf-8?B?YktQTUJlcmxocWZnUm1QaTU1ckRPTUZZTzVqbFFIbU8xeVE1UXlLZUZhcTJt?=
 =?utf-8?B?anBDUjUzeTVlT1FmTjMzWVQ4cHZ3amNFdlRMdFpqQ25iNHRDV0hFS0hHQUYr?=
 =?utf-8?Q?3vctrieP7qM5HkAzJQ8UBmv0J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eecd42f6-6b56-47aa-f79b-08dc37923fe0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 12:47:25.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHrFm6Fxf/Ey5ovn6Rttu8dMsmfCvnfIb4qthXsiTxvjMZQKXrNJ76Aj4b+64QsJPHXX3rBVXh5o5Qlu7Sax8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5895
X-OriginatorOrg: intel.com

On 2/27/2024 8:44 PM, Alexandre Ghiti wrote:
> Hi Fei,
> 
> On 27/02/2024 13:44, Fei Wu wrote:
>> _PAGE_NOCACHE_THEAD is not used but the definition is wrong.
>>
>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>> ---
>>   arch/riscv/include/asm/pgtable-64.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/pgtable-64.h
>> b/arch/riscv/include/asm/pgtable-64.h
>> index b42017d76924..b99bd66107a6 100644
>> --- a/arch/riscv/include/asm/pgtable-64.h
>> +++ b/arch/riscv/include/asm/pgtable-64.h
>> @@ -136,7 +136,7 @@ enum napot_cont_order {
>>    * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable,
>> Shareable, Non-trustable
>>    */
>>   #define _PAGE_PMA_THEAD        ((1UL << 62) | (1UL << 61) | (1UL <<
>> 60))
>> -#define _PAGE_NOCACHE_THEAD    ((1UL < 61) | (1UL << 60))
>> +#define _PAGE_NOCACHE_THEAD    ((1UL << 61) | (1UL << 60))
>>   #define _PAGE_IO_THEAD        ((1UL << 63) | (1UL << 60))
>>   #define _PAGE_MTMASK_THEAD    (_PAGE_PMA_THEAD | _PAGE_IO_THEAD |
>> (1UL << 59))
>>   
> 
> 
> This fix is already in -fixes:
> https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?id=c21f014818600ae017f97ee087e7c136b1916aa7
> 
Thank you Alex, got it.

Fei.

> Thanks,
> 
> Alex
> 


