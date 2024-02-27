Return-Path: <linux-kernel+bounces-84175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 343A086A361
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E66B28DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAA15674B;
	Tue, 27 Feb 2024 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqcdVio0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A856741
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075560; cv=fail; b=M5vdbopXBnQMfQE1gd9lll23XO6PCmvj5yOASZ4/iPlLQlbT4GcEEYLZDFALPmJDAPetJXbuHRwC0Uk0dA8KoN6BTP0tiH2uHrUmeC40wdn0uM93ivyIjvnmZcX+xTSiM+4CsoU9Cb21E4at2B97kYGmYUlek75lY0R/Y48cVeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075560; c=relaxed/simple;
	bh=rP//qjn9ug6zopISy9W9Kfh+3V5B8ZRaAGoHY0on7Bc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ljJJGLa0QT/nZdxbBD/CtYqZEOuLHZkqjp0ZE98qUTYPwlW0baFxCi4/SsUZooagcDUhR5DPoqr+vSjHKEy+cRAzSjvP/wnLojlbyuxw8WXHG6NvotYLM9zD+J0JNdZsthE6qBBNirTx4UletDKrf9FPzAGr/8W3kJWyWvEWMX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqcdVio0; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709075559; x=1740611559;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rP//qjn9ug6zopISy9W9Kfh+3V5B8ZRaAGoHY0on7Bc=;
  b=BqcdVio0j/xGr+/wGAXHSmSOHlXt5J6e7lJaMopNXzPZOgEDzPQTVLr/
   fuTv/r1L1vAJ7+GPc64iBuG+Z8lVD+bwTR6uKWkKt2PrM7LZSr9ZsXuKC
   /D/ryvM/iK6NDi8wNLCoa80K+EFZ560v1erlxjR+KgJ6GD30nS9qdI2m6
   Z2aa7LDyhOMis68vB4YA2RumTmL/iA8uHXagc9/qnE0wT0G4t2W5YcQ8p
   TxQBGQzSbae8ApIuNls+UYYRncgElt4UkunvaPW+I1K4UQ/UFXB7VvKj6
   aXTWF+Fr5rov2u71BgFds2VLfXOVmGsRpYcNC6LoI5YjoVP18RLPSZc0N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25915508"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="25915508"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 15:12:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7432573"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 15:12:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 15:12:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 15:12:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 15:12:35 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 15:12:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw2oLCpjRoOJ13Y9Z5iLEoiudyFBYAluXmYc070aIFnJrekJk8O9WGaYXn1/LHcYtoLATrb1QUwgPfaL3xcCQt1UeBO6w1kgmXfGcKvBfjlmm6rQ1L83+WhO5zB2AB+h4iIV2vJRnWaNrhkuEwINzBgxvlpNHPs6/euR7gA3EFt2I9RvEDLjNDd/zoxS1W+YvsTizH4P4vXqFNWk2/GSFBaFoaHtiBlc0IMRE+lEoaitGNFCbAeD7IulZxd1RzkBkjOJwUj7a78EIglmqsOSCuS9CdbXX8QpfYP4gXSBm5i9K4PXWipKdWvmMT2iXmF6N26uSI0g8OQcLrw/U+JPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruOauABZHXk1DCX+0OrG6EYZVoDnnPA6XBFbbLroOd0=;
 b=QWtgjXgqq8i/F+z3HvXBMRjLeGdNzK9JrmephMXcyUGkWjlxaDzn1mMcJvrSAkUNLh8j1w7pTpACuGl990mG/2mAXyCog8TFi2RlO+LFDRSFV3swtzWMQsswBgAmvKDjnxRERyEGEKtDp4BK/i8EeIomhcgpxfQSqR6V5/NO6g5OO4CJPJhik15WoplFWXdmQJAvF04017Dw7Bs1Hh/viQSRri2qfEX/+8Ya9KtK5hkqHv0qatEJy1BjBkbswvqV4RUD5f+UM8Tg8i5zkAfzqiFWydDpU35pMDWbxMeta5z62zT8hpzponPsoz7hqCtKGbWmISpg7KFzVwhO32acOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Tue, 27 Feb
 2024 23:12:33 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 23:12:33 +0000
Message-ID: <dd3f7acb-4a35-4a87-a664-1d02181fe090@intel.com>
Date: Wed, 28 Feb 2024 12:12:20 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 08/17] x86/tdx: Account shared memory
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Elena
 Reshetova" <elena.reshetova@intel.com>, Jun Nakajima
	<jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>,
	"Sean Christopherson" <seanjc@google.com>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <20240227212452.3228893-9-kirill.shutemov@linux.intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240227212452.3228893-9-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:303:b8::12) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CH3PR11MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: db1bf1e7-28e2-42e9-ef7a-08dc37e99444
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/hl+dbioxE0p3S3xSAtL9MqSeXlcd7YmrRrnphGIbaqICEqJJSHuuBki9bujLYK8RTunleFajc1nUPO0J5RoNJM7wf77TZUHIlMVMK484BI2EdvU7Wl11XEDEM6VE8huTqqmloYCSY8bEL6INUIdo/1psdY5J/K5EhjfMBRN54Feb6VBORPbONhed2zARWGZkNI5FqmlDSqjOeWslE19biYn5bjFTmWJsGNxhoF7QVkwOP0WfAfzjP7wE5PXJEtuenQZ2BOsgDmXBpVDrBWIIhK3tJSeUIAAQp/mX8SdsdVRxm4UNoNWMHV3/qUKqDeyXEiiD5NQy5ARlSg7ii19AX6q+pgXJxp9SYg1gdd9ELXD/UPCGdULF7++e5grKTW3YEuQcpDR3+ZGVJQl3fQu+/ny2JyP9M7SHwI3R7IL2w48lvsU1/VxMGOTvD3fxVTSgyOmaJA6xOHan4DvRjJL/lacNQ6w+09Vsf3R4wHazNaZoHa87w5affWv1plX64E6BeKx8dU+jRTS2bAgedDPP9pXTKRiyqlETgEN5nqyY5ut7sKyj6uegjSNiy0a+GvMJodUV/XIEca2HbwQB04ZaZ4Iym0G4Vfi1sBpxglTJ3unqfbxXW+qXiJHMJNNJN4NWBe420FtTDrsOim49TTvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlcyREYvV0kvbzduSFRsUEdFcmVIbmJUUzZ0SEcrN2lRR1JZTXVUME1FNVQv?=
 =?utf-8?B?OXIwQVh2TEFMWXQ5UXdVb1dveWVaYXdhbUZDMmtZQjVwTW1FaFJiSHVPZlM5?=
 =?utf-8?B?c1RtQU4wTnN2d3V0cXdOYkxZT2lEZWtHVm1PTmJJZGpxU0VmSjJnMFZGMXA5?=
 =?utf-8?B?ODZrYmRWQUJlYkRzMGtmS3hMM3JLU2dyZ0srYnV6ZHdiM2x3dVRraFVYd21C?=
 =?utf-8?B?MlVMcU1CR2dycklpMm8yVHdablI4Q3NHcU1VRWRqN3BtM05ndXk0MU9sS2NO?=
 =?utf-8?B?YW1vby93RjFyRit6M1M4ZGtxQ2V6L29YM1R3aHdXQnZpT1JBaGNCYTF6a0Ru?=
 =?utf-8?B?VWljcVNHZkJielhHTFRIdXpMd3pWZWRSMklwQ3FzSURYOGE3SEpuYjkxZTZk?=
 =?utf-8?B?NGNGQTAxc1BEQmtzQ1lleDAyY3NXRFBpSXNvWlAyUjhWZmJXMjBVeVNJRnF0?=
 =?utf-8?B?elN3RE9OYXZsYjBpc2Z4Y0dJZ21ubUpiWFNSYnQzbXFic2lPTWZabjNudW1M?=
 =?utf-8?B?SllKTnJ3SE81L0VqQnU5Y1RBSktnS1NrTHF4YmI4SnM5bzZNdS9UNXlIZC9y?=
 =?utf-8?B?OTdrTHBxcXhnU1JsZjAwZnVGcENsSTlMY3NDMlhTUEE3b2tYOVBWOVRiT1c2?=
 =?utf-8?B?UGVCeXBReUlZems0aGlHRmMrdUc0U0I3SGtWek9Hdld5MXZoTlR0dUVPdG5L?=
 =?utf-8?B?MllQM1JlWW9UbW5yU2x1eVcxRkx5K1YzTWRQSWxWVENQTFNOM3pIYjlUMXlV?=
 =?utf-8?B?TGsxMlRDSXNoYUQwbHBBUEJlV2c0ZkticldpZExrRjhrMEFsdUpvcFFkbTUr?=
 =?utf-8?B?TkRyMnFxL2ljb0xqOHV2YkpJUmFVbzd4QjF4S1JCdm1laElmR0hLSEwzU2Jk?=
 =?utf-8?B?bzcrVTR6VTcyd0tQRlh3Z2FQbGJmNzE0SjlZbkd4NXhleVJIelRGRVRVb1lk?=
 =?utf-8?B?QXkyMGJKT0dNU3dOTjcrU3NMY2RYYnREVU54M3lWWkd5dW1lQnMvUGhwRDgv?=
 =?utf-8?B?NVl5ekhDaXNxaTFlcnBVa1U1emh5bkNSYVdqRzJYSkVSeURpUDJQMmFteC83?=
 =?utf-8?B?YVljYmh5NWtPRTJLL2RoN3hoMittRXRPMWxaNExyTzVwR3ZEWCs5SkQ5Nk8r?=
 =?utf-8?B?Y0twbE4xUVB5VTIxTXRJcVFiUERvb1lOSGFBeXd2UWUvZHlORkpzQWR0Qi9s?=
 =?utf-8?B?anZOanA5NnpDR3NXTXhudVFzOGdmMkpDRmR0d3J3aUdxb1RSWGNubFlJVUh3?=
 =?utf-8?B?U1lEaWZCWHV1cFZZZlJzWkYvM2dRRUhMcDNhUEZpbmxMMERZVkZteWpYcFV2?=
 =?utf-8?B?T1VHZXdFZ2xyV1V0eGtiR3Z1Y2VMMm5wZDlrQmV2UGNRNUVCL2kyVHJIMXpn?=
 =?utf-8?B?eWh5a2ltWVR6VFBPUFRlNXRxYUdTdU1JdWI4cWRlWkQ2UFZIZmZEWWlVSFN0?=
 =?utf-8?B?aVZhVHhJNkF6SXhQRUVyU3dOOFJrTElkYklmZTJnZTIxMUhGR09OQk9KYmlv?=
 =?utf-8?B?cmowWFJVcXdTL0ZkQ1JNMk12YjJvMmZCbzBqaEprWDltOEU1a2U4NjAraFQr?=
 =?utf-8?B?NnBzSi9TWnR3K01GYW9pMUpnSmRqSllTRHZmNG5tcElNRDh6RzhmeGJZZk1L?=
 =?utf-8?B?THZCTzhQdmRMYWFJRTl5YnM4TldybmZaN0VlajlwZW9CSVh4Y1VHcWlUSXRO?=
 =?utf-8?B?aU5zWnJ0R2V6bUlrZlpYbjVud25kV3l0cERwNEp2czlVa1NEZWczTDVzbWZv?=
 =?utf-8?B?VW9aTEtJYmZ3dmVTb0hLTm1XVjR4NkdJc0haSGNlYmFFTzdRVE0zdTdZS3hq?=
 =?utf-8?B?R1hMMi9hUHYzcThmTTRYcHJ0blZhTVRyS1VEd1lvT25RQ2Y5MzQ4N2NDWXlp?=
 =?utf-8?B?NEdOSFNCR0xWbXhpcEI0WUNxbmk3VWFBcEZHd2FNWVVKNU12ZUpwZ25OaURS?=
 =?utf-8?B?bHlEWFZObXRMUEFvaWFHMTVYOTduMW1yTEhsTUJ6dzgvU1hHVDZlK3dENmVN?=
 =?utf-8?B?NW85cG1RNHA3a3czMVdHN29hc2p3eTdoaVpLSS9ZQXBBaFVqKyt4bXdzSS9S?=
 =?utf-8?B?cFJlZzQ3Mk1uUHBqeDI5KzVOOWVFOW1NZ0srdGV6Q0lJckd6YTF2YUFjdTB1?=
 =?utf-8?Q?vxtXU7CzKH6C7kYYIjzQUOoBZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db1bf1e7-28e2-42e9-ef7a-08dc37e99444
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 23:12:33.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFsznnK06hRLr0kiQGU2DufFOL2R28CcmeCQD3HA2bL3QFHiiqy+2t4k8NIqrJZUIlP4JNJsnIdx46TMJMVGCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8414
X-OriginatorOrg: intel.com



On 28/02/2024 10:24 am, Kirill A. Shutemov wrote:
> The kernel will convert all shared memory back to private during kexec.
> The direct mapping page tables will provide information on which memory
> is shared.
> 
> It is extremely important to convert all shared memory. If a page is
> missed, it will cause the second kernel to crash when it accesses it.
> 
> Keep track of the number of shared pages. This will allow for
> cross-checking against the shared information in the direct mapping and
> reporting if the shared bit is lost.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Kai Huang <kai.huang@intel.com>


