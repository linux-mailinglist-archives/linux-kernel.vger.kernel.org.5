Return-Path: <linux-kernel+bounces-102612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CF087B48E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D2B281DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FE15CDDD;
	Wed, 13 Mar 2024 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlOBfDM1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C05337E;
	Wed, 13 Mar 2024 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370054; cv=fail; b=nIygmBTayFj40ylanenXJAVYdbpB6XxbmJQhzj53QAZCMAFnM3mAWTWrVZJwNA43qFF1yGMd5YsO6ukqa4byliPlxp2kqa+gvD5Har2fL0yaBaom3tHstlvV67B7+EsiERuyo7lRtHVAExJ/mmpQmROBqWdgBCGtQD9dbn1HTVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370054; c=relaxed/simple;
	bh=1ENgm4a9b1uoKVBZpemjoxGKEGOezNzsAgOTzgNufes=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CB4VwMtHZU3OtjUzx9iLubd78Pjpc6qAtYndMCRT25iCnmEiiY4RZPyQRL2lQcPjyy6YFpth/Ifdenu2kLsd/OtT0zh38a06KcxTchbEmUwYivqp8QMFQu0l5mUQ624UeIsIc6n5bgEf2vY2sCdJjUuQ/YkMyQgWEniN4yOcf2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlOBfDM1; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710370052; x=1741906052;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ENgm4a9b1uoKVBZpemjoxGKEGOezNzsAgOTzgNufes=;
  b=XlOBfDM1IF8LLHh5dPvHLDZoN1bM+bmfJTWlnbsVxkD0GCjtXZeq8IS+
   o8Qwt2Mi/D61Si9AcKD6ZoEgHhi/tp1RTlxa6hYNcvuxpdXC3qUPI2xhR
   ApKgfDdEui+oBWTcdTfP25OMB0Bd8CpOmSkYQYc6qE+T9wIvItVROSFNf
   zgnw3pxSUJgmwRnoP3Atjckfp4BNxLxEIjIlp5LKr7mLeAaxtEKwmQ8lQ
   VnDpXvczZ/LBTYxrD511xnHlfdnlrOU3IOl8LeVXx9KqfV5lkxyLwpUtc
   M+Hoa50sWQZlVRQI7I/+XRekyplDd3t4f8T8YxdIQxnCVOKsdWrxicRmG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5293483"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="5293483"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 15:47:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="49527978"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 15:47:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 15:47:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 15:47:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 15:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCYLZH9Q25nOanRmeH9FrOyTtwgEsvSSlEpWpXtBCT/ExGrkMpqoGXTn0dqt1o1R/ynn8vMVb7+14DnPyNvZ4Yz170WEs1brfNDhyOoNIG8U3sjAcNfNFgs7tdVL7V6S9gAMmQoqWt00JKVAQUdic3qnB78hPVN/QHlWyItZ4EBftMWs6ZNiC0Icyion7c5qHZrR/JqpntEavEUtfizmpryP1YeGxHz6MkyO1BRK+M4sOU1ObQpCL1tdZRTlLOnfYCumYvtKIprQogRpiTzSaIbGe0gfbSbysSr2Lrjov7LMJbuIGKIxgVA7KSWbGWLa7dB+vWQKISpEK2KKwHNRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrCTRKV5W60ZFwnEzje8ckU29DOzWZrQyc5HUFQlXy0=;
 b=aYlzbXYeKTor72/+a7z0duKazdDDTqELxulYI+/Nh582SGDPDlSm1jzgpT7+XkZxXKap9SBHLW9KkGlpzprpBO4LTlRDaLlBGEhTrMrtkZt8SoMP7WCEDb53L6J7/YZIrVhDAIRts2yIfVX1XL3F3IgLnH4D3FjkYUyW1RqDfV0xDoiobv1OU73GbM6enm9y9JKzIttdP9opNWdefpzNd1pu8a+Ut7QTMr6w0LtTXA5/51oa/7rWYXE52Q6ru+A1nUmQuYIgcqHXskHj7vjgZ/qVj9VTuDvT93/inSKfLQTWMd2cng7Y0FhkTgQ0m0J4gw4cLAQlAVF6PUQaiFZF1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM3PR11MB8683.namprd11.prod.outlook.com (2603:10b6:8:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 22:47:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.015; Wed, 13 Mar 2024
 22:47:27 +0000
Message-ID: <c8822e06-a3df-4f05-8625-b2bb011887b7@intel.com>
Date: Wed, 13 Mar 2024 15:47:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] x86/resctrl: Add tracepoint for llc_occupancy
 tracking
Content-Language: en-US
To: Haifeng Xu <haifeng.xu@shopee.com>, <james.morse@arm.com>
CC: <fenghua.yu@intel.com>, <babu.moger@amd.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <peternewman@google.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>
References: <20240308074132.409107-1-haifeng.xu@shopee.com>
 <20240308074132.409107-3-haifeng.xu@shopee.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240308074132.409107-3-haifeng.xu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:303:2a::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM3PR11MB8683:EE_
X-MS-Office365-Filtering-Correlation-Id: e42265e3-a84a-4489-c49f-08dc43af8eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NtOrCecLlYI5pW1HnYHqtLl9aPC7z+KZQrTZKeHP/CPh0QiZipFLzWHYrBobQ7258ZvbBjc87q6LIlBCCXdeQat956jE8589GSivsF6seroUAbjbVPJcVrihKPryzk7ZX3uMApvXyZ1xdeQ4GE6RsN/nZd4CTm+gDFTZxCQHCZmaJTTS+Oh0MkATWhDntKmpKPjacsyfZl7bAs7rE8QXIrSEOiwN/g3s0xjGmJoWmyfutz1/QpbP6rEUYMf7v/Av0BvcDF87ULwKHB0J4eUh0w1Zvz1jpWhFHJukRX2257XKoNnk3PCBc9k4EZ2Pa05gDkLIFt8oWFzWEZRTh6AQtTGo355aJBaBTZszQTMDSNs2Z5xc6IdKX8dt9VhRKxKdmx551qFHnVIO8y3SN4uB7L9lQY9KhiFhUcJHNaMV7WetXOoYfol8hNqdkestv3jbkC+ETeYUFOTzKgH7+VLlfg0dZ5VeMeWoKdF1WPlxX92uIhqXng3T2UB5w/KKQWYZ1/L26EGvqV1t8HledrCuavNTh/n/ubgBH47tqmH5+zePsGenWCWxCM71lAmfuB6AkhM1yjHrp4217cTO6elroU4zp4pO8rs5GiMuFowu/S8xyw9qkM3ZK7xwMN7JyXfzNYjgkaurLw/pNf9zRBHG7kq8tWjSlmCVcO5FRlcoHhs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1lIZWFvRFdab2dNUXZCbVFyK3pNZkxDRlBrM25kZk1IRk5pdDBtR29FNDBG?=
 =?utf-8?B?RnMwK0p4MFpVMXNzOEhEeisyWEZuaHd0WUk0UTBFSzhlenBZVE5PQmgyRFlM?=
 =?utf-8?B?ZHBUNEFWWDQrK2VPKzlCUjJBWDMyV3N2RjR5Vk5NWlF4bk5ZTVdadGY3T29p?=
 =?utf-8?B?R1ZJSWU3YUN1QmhpY1N5Tm44ckpPTWh5OEdmYVAyWWRid0E3NG16UnplSjNu?=
 =?utf-8?B?bHN6TmM3TVQramFxK0FoYkRLVktqRytrZG9FVzJEMThiOXA0VmZwNUZyOFZo?=
 =?utf-8?B?MW8xWmdZcjEyUTdja1hpbjQwMzErOXZ3dkdwN001V29TY25rN0syNVpPMWtZ?=
 =?utf-8?B?cU5xSEh3dFhSODNub2I4eTNDY0hUUmF1NC9NUGNLNENZcFBQMWN2WHdZV1pr?=
 =?utf-8?B?WEduL2hNS3hlbHlPWXJYbTJhcXV5V1l3ZnRBUjN3OERadE9UNTlYSXNCdVMw?=
 =?utf-8?B?ZmJtdkU3SVNoVGdEQ3B0eEJOM0ZYTkt0UjdpdCs1VzI0NkFyeXJVMWtWc0Zx?=
 =?utf-8?B?RHZ1SXdYQ0FJeDJ5d1l0bk1vQVlMZngvZW5VTkt2ZDV1SmJaMHp5ZnY1T1g2?=
 =?utf-8?B?eTN4WUNGeUduaklHRFBCem9BdndUWWwreTk4RzNvQXRCTGJHaUM5S1V6OEdt?=
 =?utf-8?B?SFYzWFZIWm93ajhyTXI0MUN1ZjdvUkxxRzdnNjlIeld1ZEkyTU5GdFJTSWli?=
 =?utf-8?B?QmlwTmxqTE0xV3Y3K0JEdWJFVFpSNDF0UTYrcmYrZkZQWWNPMGRDWThaVVJQ?=
 =?utf-8?B?TER1V3dadkptVWplU0QvY0YwNG1ndUhWMXArN21hTnJhWHNnSHA5M2l3Slhw?=
 =?utf-8?B?Ti9TdFZZek9ieFFrbWUxTXc1YVc4VVpzQWFTd0RQNDk0Q2RRZ2JNYnd2YWZI?=
 =?utf-8?B?L3RqOVZkZmZ0eVZpV2REQWdqZ2FLQXVHNlZESkkwUm8vYUpLSHA5Mlp5SHk2?=
 =?utf-8?B?SHZzU1JsMlBodUU1cGwvamhMSFAxaEtKWlhGQ3hRRHIwbnU3aFF1MS9scjhB?=
 =?utf-8?B?c1diM1VTU242aWw1OVdFQXh4QUt4ZGMxamJKbkxjT3RtZlBZRU9BRjIzU0kv?=
 =?utf-8?B?SGNaWDE3WXZwZjRPT2tzdktEazJSNjkyOG5TQTlPVXlBWG5vU0tOTktyMDls?=
 =?utf-8?B?UHRFenpmNkgrR2kvbHlXTE1kVHd6M3psM1EyNHZabU1GaDlnZ0V6ZG9GSUo5?=
 =?utf-8?B?ZmFkbDg5Y0hLMDF1bWpLbWxWYnM2c1V5T3I2ay92dm9sc3d4N2NONk5oZEti?=
 =?utf-8?B?Y3VMNEdMTitnTmNFYlpIYUw5VTZwZG0wR0UzQ3FGY0V6SnRCRlhVQy9GTXMv?=
 =?utf-8?B?YnRHdmhJeTJYc09qQmJBM0lyOFRISXRGekU0cWEvMUZDaGdIKzVrM0loNUlN?=
 =?utf-8?B?VkdaWVg0eERIQzJUSExycmx3NXZlK0hqSnNLVi9MQ2dESW56SUMyQ2xoaVRU?=
 =?utf-8?B?SFJLSzljVDdWODJrYzJuT2NWR3ErYmFSak4vNjVlRUVnUlpPdEJIMkEyN0tN?=
 =?utf-8?B?QUlrTGNnSDd3Tkx5SXhPV0o0VS83NzR6OG5zYXpXaktIQUZEbjRXR2hSNURE?=
 =?utf-8?B?Mzg4UUk0TXl0VjFlOTFaZU9IVnQySmVBeTNETlBBcE45THluTWVlTldtT3BQ?=
 =?utf-8?B?dEF0eHQ0QlJ2dkhYWncrL2xHQ3kzQ1VXdHVCN0RDdGFicUUyY0FQV2lSMENG?=
 =?utf-8?B?aEl0K1VmZjBSS1BSU2VFZnpJbUFjSnFjYjRjUXpaeXFBc29lUUNCSUd6c3lH?=
 =?utf-8?B?RGk5aFBkamc3S0dUaFRILzlaTHdBbjZJVTdaV2NWVC9kdjE3eDJVMVFCbzFC?=
 =?utf-8?B?YWQrclk4UFJxS1VHOFJSbENITkZiY1c1Ukg0ZXBVc0wzdDV2UzZrZUppWHBu?=
 =?utf-8?B?R0kvQzNlRFltQUFET3p0V2hwMm1xOEE2aW1pc1lXbnBxYVU5S01CRGs1eW15?=
 =?utf-8?B?SzQ1eUNmajZNK0wyQ2p6OU5LaXhOS1JTdzVFbUw3VzV2QnYvWGRZRUpwTWlM?=
 =?utf-8?B?VS9uQlc2S0l1dC9PMWFpRlovVURkK3JTUEwzdFdib3RScy8rdHdMZzV0KzUx?=
 =?utf-8?B?QnBtSDRyaEFMN0Z3MXBDZlhFTE4wczlrdzZUYWpIa2srVnZTZTJBaWw0Qm5R?=
 =?utf-8?B?TzRPZytWZWdTWXQ2RHpmNFJWUGEzVERZa3MyUFd3R3p2eVZuQTZORnBDZHpI?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e42265e3-a84a-4489-c49f-08dc43af8eb3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 22:47:27.3553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhbkxFypJG7QjnxNwQL9oj5LUnjuSNBhn61QURPadLFdUTst2yDTdA3M4bWePz7cvQVC3q/GzXdew6rjIoJabSnxdDLP265/5/14990xuBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8683
X-OriginatorOrg: intel.com

Hi Haifeng,

On 3/7/2024 11:41 PM, Haifeng Xu wrote:
> In our production environment, after removing monitor groups, those unused
> RMIDs get stuck in the limbo list forever because their llc_occupancy are
> always larger than the threshold. But the unused RMIDs can be successfully
> freed by turning up the threshold.
> 
> In order to know how much the threshold should be, perf can be used to
> acquire the llc_occupancy of RMIDs in each rdt domain.
> 
> Instead of using perf tool to track llc_occupancy and filter the log
> manually, it is more convenient for users to use tracepoint to do this
> work. So add a new tracepoint that shows the llc_occupancy of busy RMIDs
> when scanning the limbo list.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Suggested-by: James Morse <james.morse@arm.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  Documentation/arch/x86/resctrl.rst    |  8 ++++++++
>  arch/x86/kernel/cpu/resctrl/monitor.c |  9 +++++++++
>  arch/x86/kernel/cpu/resctrl/trace.h   | 16 ++++++++++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index a6279df64a9d..dd3507dc765c 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -478,6 +478,14 @@ if non-contiguous 1s value is supported. On a system with a 20-bit mask
>  each bit represents 5% of the capacity of the cache. You could partition
>  the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
>  
> +Tracepoint - mon_llc_occupancy_limbo
> +------------------------------------

I think that the below paragraph would fit nicely as a new paragraph in the
existing "max_threshold_occupancy - generic concepts" section. To support that
just one change to text below ...

> +This tracepoint gives you the precise occupancy values for a subset of RMID

The mon_llc_occupancy_limbo tracepoint gives the precise occupancy in bytes
for a subset of RMID ...

> +that are not immediately available for allocation. This can't be relied on
> +to produce output every second, it may be necessary to attempt to create an
> +empty monitor group to force an update. Output may only be produced if creation
> +of a control or monitor group fails.
> +
>  Memory bandwidth Allocation and monitoring
>  ==========================================
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index c34a35ec0f03..60b6a29a9e29 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -24,6 +24,7 @@
>  #include <asm/resctrl.h>
>  
>  #include "internal.h"
> +#include "trace.h"
>  
>  /**
>   * struct rmid_entry - dirty tracking for all RMID.
> @@ -354,6 +355,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  			rmid_dirty = true;
>  		} else {
>  			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
> +
> +			/* x86's CLOSID and RMID are independent numbers, so the entry's
> +			 * closid is a invalid CLOSID. But on arm64, the RMID value isn't
> +			 * a unique number for each CLOSID. It's necessary to track both
> +			 * CLOSID and RMID because there may be dependencies between each
> +			 * other on some architectures.
> +			 */

Please watch for proper formatting of multi-line comment and consistent capitalization.
I also think comment can be more accurate, for example:

	/*
	 * x86's CLOSID and RMID are independent numbers, so the entry's
 	 * CLOSID is an empty CLOSID (X86_RESCTRL_EMPTY_CLOSID). On Arm the
	 * RMID (PMG) extends the CLOSID (PARTID) space with bits that aren't used
	 * to select the configuration. It is thus necessary to track both
	 * CLOSID and RMID because there may be dependencies between them
	 * on some architectures.
	 */

> +			trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid, d->id, val);
>  		}
>  
>  		if (force_free || !rmid_dirty) {
> diff --git a/arch/x86/kernel/cpu/resctrl/trace.h b/arch/x86/kernel/cpu/resctrl/trace.h
> index ed5c66b8ab0b..b310b4985b94 100644
> --- a/arch/x86/kernel/cpu/resctrl/trace.h
> +++ b/arch/x86/kernel/cpu/resctrl/trace.h
> @@ -35,6 +35,22 @@ TRACE_EVENT(pseudo_lock_l3,
>  	    TP_printk("hits=%llu miss=%llu",
>  		      __entry->l3_hits, __entry->l3_miss));
>  
> +TRACE_EVENT(mon_llc_occupancy_limbo,
> +	    TP_PROTO(u32 ctrl_hw_id, u32 mon_hw_id, int domain_id, u64 llc_occupancy_bytes),
> +	    TP_ARGS(ctrl_hw_id, mon_hw_id, domain_id, llc_occupancy_bytes),
> +	    TP_STRUCT__entry(__field(u32, ctrl_hw_id)
> +			     __field(u32, mon_hw_id)
> +			     __field(int, domain_id)
> +			     __field(u64, llc_occupancy_bytes)),
> +	    TP_fast_assign(__entry->ctrl_hw_id = ctrl_hw_id;
> +			   __entry->mon_hw_id = mon_hw_id;
> +			   __entry->domain_id = domain_id;
> +			   __entry->llc_occupancy_bytes = llc_occupancy_bytes;),
> +	    TP_printk("ctrl_hw_id=%u mon_hw_id=%u domain_d=%d llc_occupancy_bytes=%llu",

domain_d -> domain_id

> +		      __entry->ctrl_hw_id, __entry->mon_hw_id, __entry->domain_id,
> +		      __entry->llc_occupancy_bytes)
> +	   );
> +
>  #endif /* _TRACE_RESCTRL_H */
>  
>  #undef TRACE_INCLUDE_PATH


Reinette

