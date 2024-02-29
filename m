Return-Path: <linux-kernel+bounces-86020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA8786BE9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D5C1F221DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A8E3612E;
	Thu, 29 Feb 2024 01:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STmHmcZA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F0364A0;
	Thu, 29 Feb 2024 01:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171794; cv=fail; b=F3fcoKLKwnYug9OFpKo9rYsz0pAJ5JBBCRZJNFXre/7iClJR/6FuK7do6jtv0/K6Pd3UZGvf6Oe1uSWcGg0D2W00or04KQIK9t9yaBMm6ohOcr7d8v7cWHu5kjEqJLFN9w1RARUAN2/duWgIdKxZDDPaXbc2dPCFyuhUU5Y80kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171794; c=relaxed/simple;
	bh=2fsRnhTiXb9ft59f9tori+7G7pldXFNqKT5h5Q0lXts=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kx5wTT81hf6As4vaOwfaP511XqjBcUJplfERJmMrXcJQJCL2QaPEkaBT3FoUTS3Cw8Y2qoXDVrg4m421zDcNw7tuouHIac4sRsWkZdQ+5ju4QMgkCF7vCvt3Mv6jktTLbbq/KkdtRB+xweH+VwWIKBq+V4cVM8ily7Ws9XAWrC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STmHmcZA; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709171793; x=1740707793;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2fsRnhTiXb9ft59f9tori+7G7pldXFNqKT5h5Q0lXts=;
  b=STmHmcZAjQY1IT+KP9s1m9z4gKluuM6ALBLJD/C9NdBzjz4MvQtlQSk4
   vAiBjeGvVAjViuJJDO0Zlav3tVWYxU1wg6Fz8L5XC59JeZen+Jtp/jXHX
   eB5HIx4DQB8qNcZbdQScOqa3QKWzXQn1PAoMh/siVQGNln/4Kohq4a3Y6
   0HqPh8FoiyEHGVJrVlUFGeY7b/4H35GAhWxqgxfCdaXBLAT/9kiv0oZRI
   hDW3vQcpARsULBCIsHLPU2kdceSapEc988kTZiAKVjnWp07gYEW3n0sAB
   VMuwXxDUwFVH+MKmvS8Ogc09T2YtYHKzxvyKR2u6mnHJ4fuCGeXi1ql9O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14763849"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="14763849"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 17:56:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="7569512"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 17:56:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 17:56:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 17:56:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 17:56:29 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 17:56:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMAPJXl5n+93XypMDj8Y+fcWVBoQ1dk8a1Q/uThlKSMpYtjO5XIogkNlNDa5oemf6faJfbT6dC74Ko6jVbKo9swi1CmuzBWpEkoCYqgm7M8RML1zV/8GGJbg4XQYSvOO5Vs3Tu8266UHoVjVeKfEaAUxMZ7VDum2+grwA6lKppKEwc6utmE/jKzLAH8ZO5JFTCfVKzLIXPs8I/VUnB8vAb4/6WRsxtFnDU1N+M6IntO0RCoJYOMdYeOvwgIvyJUeSafuO8LbvW66yEp0vAlARIzY7P8K5OMfKoLa0j45z67PDoh9HCpFT1FUTig6HyzBO4JiuWzQnPvT7LyMQQ0eaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sodaIqJIGWdgCSo3DZC4JGwPLlj3YEVByD2HECOicvM=;
 b=ZGqfrMf9XwKRgsgRU+TS5isXr1Uc7C5cuu5jXYob6RkjdHvjGxUG3w4MF5Rjl1SvpvDjJR/hwkqvxNPjY/xE8lh9qu1ZDzhqQE5NwW7TDTN+vZ4RNX5BWYIEKOpDUbLlsi8EYm/THto9O/JKg62irQLZHTN+qaIU++k7JkWZhQLPfFQ5eUDq1kugvMiaV0GKdwZKYnWnLIK+/10PQH9e7S2+R8ttQ7rzngXfEYzRZsUMfcU8fZUKIyJ+zI/lN2yUAuB+R9EkY6qzBa/+Voe2MzuBUDSZv088nKvmZEj+kAwrhSiukeDy6DP+WM+rsSjCYjTnjgLufGSQ2rVKyIlmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA2PR11MB4809.namprd11.prod.outlook.com (2603:10b6:806:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Thu, 29 Feb
 2024 01:56:27 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::940a:5c0a:1b08:67bb]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::940a:5c0a:1b08:67bb%3]) with mapi id 15.20.7339.023; Thu, 29 Feb 2024
 01:56:27 +0000
Message-ID: <015bf75e-bbe7-44ea-a176-9f1257f56b81@intel.com>
Date: Wed, 28 Feb 2024 17:56:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mce: Dynamically size space for machine check records
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC: "Naik, Avadhut" <avadnaik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, Avadhut Naik
	<avadhut.naik@amd.com>
References: <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <Zd--PJp-NbXGrb39@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0038.namprd17.prod.outlook.com
 (2603:10b6:a03:167::15) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA2PR11MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a03fcc7-9983-433e-e2fb-08dc38c9a453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/h0zPqGkYt6R105gVsMiZn9btv+YKZRe9xZBNOlR0yZdVzfL0HgxYsUqABU1L4nqa6uHNqd0mwAmeW7AMlICJ9O2ogzz1I6Tr/V0xSSLt/+2hGl7wOyDkLssYr0gW/DVCupWMPwDVYosvDzMyqmHSrjm1x+JCluvpSjzQCm3G7N7M79WOyG2XQ5XA/a6bGDYUrVBt28Ub/QdHmm4eKtQIhiyCYV+m/VGMjv9ALC2Ah6NELZPAMZdRacQpFyQDNekPiuKj7hSmT5e6UCJIrsTqXowcRo0eso7Gd2e5kJAeYI6vGNAH/YSB3a7V7BqEme4KA12q2vSNnXbTO7UbBQp6KFeJeCNeTZA70h/6MjMHaN+h3089lgUliZKeAILIVffIihq124vL4OKgP+GA02FY9Qae+BC2PYtr5uYHMGoHfpfiv8k8/XWYSWw/Gdn0ReFGv9i/lgC9IZQ22FJfznIFqEkWvBZDgSCUL1g2yPwM/mVhTIVwNTKHjTCKqXJKsYHoscnkI2MGkq7bQyO5tb0OxFAKs+3hIm1wqonxp8rd+Tb0sDz+1inyXEj4aaRjzRyf6bgZNXOwDVc+BLtTDYMe22XRvm6nH7jSmdxt0QVMmINXEwltjHW9Cg9/wqN6Eg+cLC0vTI/godeQpWTmV93A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXJBTGJKeE9yQjVOVUh1QXRjV04vV2I4eUhwYzBHa282aWhsd2ZEVGtFZEtk?=
 =?utf-8?B?c1pzdjhuVGl1V1QyUXlzdldpSUd5b0dBUkl5TEIwRHBOODNwS2JTZnkyVG1X?=
 =?utf-8?B?djFwRnlrY1hVcVI1YXFqbUdZam1uYWpPbXQxRWZyUWlQYk54WFZHVWtJM1ZP?=
 =?utf-8?B?dTBJT3pSakx6RlRad1dobG9pdkdhKzY4VlArYXREak9TazNGNWx5QXpwZURR?=
 =?utf-8?B?VDNyVk82SW9hcjhzNitsdlNKQ2NuVlEvMHVHNzlCN2V3RjB5MTIrQ0lZOHds?=
 =?utf-8?B?LzMyTm9xMEFJU3lHdXdCOGJUVFVSdWp0SXo3NERlV2FjMGFxRHZ2d1YzUjQ0?=
 =?utf-8?B?b0xSRHFVdXBXOFN4c21QMFJlZEZ5azRBcXJIUGRRZ3V2TmJJZzZpSEt2Qkdx?=
 =?utf-8?B?S1ZSM2s3ZDNtdG5CN3JhNm9aTW5peVJyR2VFcmNUS3I2ZG9sTk1MNzNDKzZZ?=
 =?utf-8?B?UDhYU21qYUFFMjJrWkh6ZHlCdVFJOFVsMGJLZi9iZDY1eXVMbmE5T3Bod1Fa?=
 =?utf-8?B?RGFndTJNY2FiQ0hCWENNNzZUZnVLMHA0eGIyU1dmZXZJbGFheDJZSFVxcW1v?=
 =?utf-8?B?Yko2VnJvbE12ZWd4UlRMN3dadi9zK2VnZ1BVUEdMclcvYy90N2NoSHZvcHJi?=
 =?utf-8?B?a1dSMlRQSVJqSXJEZFdwdFRLblpUMkRxaU1zcjhxVGU1S3FEc0ZqOFkwZ2RI?=
 =?utf-8?B?S2ZZbkp2d3p2RUUrdmlHNDNVNVAzTHc0U0FyeEo1cStNeTdYazVhdDcyRTVQ?=
 =?utf-8?B?cVNIejNTeTBhUVJ2WnowNmpyWU9EelFJVWY3bC9aMGVqeEhic0hqOS9nbG8w?=
 =?utf-8?B?aGt6T3FjUENsS0IxQWhsQzQrR00yL2trTXF0emNFTy9rUUt1YmlmNllHM24v?=
 =?utf-8?B?SzEyWHR6MVVmb3E1S1p4aHVTenRlcGUzcERJVmhZL2hXN3hjeDdWOG5ZOSs0?=
 =?utf-8?B?Q2xmSFBqQzllU2tINnZ6eUJYWXhldW8rOG05QlZLdnM3Mm4xWHViaFZNNE5P?=
 =?utf-8?B?U3RTTmRUamxWZzlkK2c1aW1EaVlneWxRTUFGZlpPM1JKTURPcUhFdnBjMVlq?=
 =?utf-8?B?SGU3Z3IvZWVBdkdSK085NjBmMzdhaWprVy9aU2ZhdFJPTUVqM2l4dWZCK0Vt?=
 =?utf-8?B?UUZKT2dzZ2w5VUd3UEdwWjlTbS9Kbk1NRFpGWUV0K1pQVkZBTHA0eloxVU1M?=
 =?utf-8?B?MFpYMitqWUlxdjBrbWppTW1DTTFtSElpZHUrOW1VS0d6YTcvQTlIRnpvaFQz?=
 =?utf-8?B?YzY1OGdEL2FKbG1Ta2IyMXZKTlR6dEdVaFNGaTFTQVZqWEM4RXM0dkFHellt?=
 =?utf-8?B?dlBQMW80N3l1Rzc4MmN6cDQ3VUM4SHhJWFZYczVQMU1Vb0FyZFZ3WUtFNVBo?=
 =?utf-8?B?NEROMnpTMHhzMlRnVTBaSWdhVTlDYWRXdU9sMG92bTJlT2RKM3R1Q3dvdFdr?=
 =?utf-8?B?Kyt1b2hGQnZIMi9KTXVydElmVHNDZy9zMXlnRlMzMW5hTFdWK2p3b1hRSTRN?=
 =?utf-8?B?b1lOZjhpNmp5ekdnLzQzeWNZb1o3d2FhOGFJUTFGdGRyR3BDTnVyREkyNnVQ?=
 =?utf-8?B?eXdKeEdZQ2VBYzJ1TTlFNEtEaWs0ZHlkTWJIZnRVbkpmdHJFK3MxQmJvOUtX?=
 =?utf-8?B?ZDBYN1cvQTFXL3ZDTkY4OFp4MGJaYUVVSkNTMnV0emFPNW9TODIzUWRXL2VS?=
 =?utf-8?B?bTk3MkZzZVJJcWNsSGdCNFBQdTZtMTVJcmhIaE5ZOXlvY3BhODg1M3VXZGpF?=
 =?utf-8?B?UFJ4VjF1VWp5Z29rN251MGF4OHRDZUVVM1F3Mjc1WjJubHRRU2J5VWo3amt3?=
 =?utf-8?B?Ukl3MTdxRWhZcEhHN1ZhbnNQWHR1UytxbEZ3bjN4VFhmREZHWUhXaHc5NmtQ?=
 =?utf-8?B?anp6M0luOWZMVExaM2EvV1IwNEVTMHJveFVHOVU0dk56Y0FRV3dEcUJUdkVG?=
 =?utf-8?B?eDd6VUlBMzgvSmlROW5UbFpGamxua0VBT0gvR2JCa1cxaElsbFY2SGNwZFBE?=
 =?utf-8?B?VWViTVQrY3RMRWpvYjczUkQyUU41cHFSUC95cWtLMDZhdmRSRTRETHhQczl4?=
 =?utf-8?B?UVdlWElDS293OGZLN1RmU3NCc2ZUSURkeEZwd0RWNS9yaG93VzYxeU4zbzBU?=
 =?utf-8?Q?HbjxwKdBBpXzAwiK3brz5yBAc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a03fcc7-9983-433e-e2fb-08dc38c9a453
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:56:27.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmmesgZdtgY7HY6pG6yqbBeN+Upt2ocZ2IiyQ18nQH4HFYZ8QR94RanjVbxrS62MrwBRTehNXXSl4geoTfwY/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4809
X-OriginatorOrg: intel.com

A few other nits.

On 2/28/2024 3:14 PM, Tony Luck wrote:
> diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
> index fbe8b61c3413..a1f0a8f29cf5 100644
> --- a/arch/x86/kernel/cpu/mce/genpool.c
> +++ b/arch/x86/kernel/cpu/mce/genpool.c
> @@ -16,14 +16,13 @@
>   * used to save error information organized in a lock-less list.
>   *
>   * This memory pool is only to be used to save MCE records in MCE context.
> - * MCE events are rare, so a fixed size memory pool should be enough. Use
> - * 2 pages to save MCE events for now (~80 MCE records at most).
> + * MCE events are rare, so a fixed size memory pool should be enough.
> + * Allocate on a sliding scale based on number of CPUs.
>   */
> -#define MCE_POOLSZ	(2 * PAGE_SIZE)
> +#define MCE_MIN_ENTRIES	80
>  
>  static struct gen_pool *mce_evt_pool;
>  static LLIST_HEAD(mce_event_llist);
> -static char gen_pool_buf[MCE_POOLSZ];
>  
>  /*
>   * Compare the record "t" with each of the records on list "l" to see if
> @@ -118,14 +117,25 @@ int mce_gen_pool_add(struct mce *mce)
>  
>  static int mce_gen_pool_create(void)
>  {
> +	int mce_numrecords, mce_poolsz;

Should order be also declared in this line? That way we can have all the
uninitialized 'int's together.

>  	struct gen_pool *tmpp;
>  	int ret = -ENOMEM;
> +	void *mce_pool;
> +	int order;
>  
> -	tmpp = gen_pool_create(ilog2(sizeof(struct mce_evt_llist)), -1);
> +	order = ilog2(sizeof(struct mce_evt_llist)) + 1;

I didn't exactly understand why a +1 is needed here. Do you have a
pointer to somewhere to help understand this?

Also, I think, a comment on top might be useful since this isn't obvious.

> +	tmpp = gen_pool_create(order, -1);
>  	if (!tmpp)
>  		goto out;
>  
> -	ret = gen_pool_add(tmpp, (unsigned long)gen_pool_buf, MCE_POOLSZ, -1);
> +	mce_numrecords = max(80, num_possible_cpus() * 4);

How about using MCE_MIN_ENTRIES here?

> +	mce_poolsz = mce_numrecords * (1 << order);
> +	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
> +	if (!mce_pool) {
> +		gen_pool_destroy(tmpp);
> +		goto out;
> +	}
> +	ret = gen_pool_add(tmpp, (unsigned long)mce_pool, mce_poolsz, -1);
>  	if (ret) {
>  		gen_pool_destroy(tmpp);
>  		goto out;


