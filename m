Return-Path: <linux-kernel+bounces-107943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F297F8803DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B0EB21C72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1132C194;
	Tue, 19 Mar 2024 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyguHsNU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774AA2BAE7;
	Tue, 19 Mar 2024 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870604; cv=fail; b=ZFJI0+f+Bv8HzAaRhcPIjc7P/DT/Cmt+gM2ukT0n8kc595oC1JPP/rlaDCvYKWql7DVoFCAHro82S4jIdmBJrfL6LEYIABi5M5DZmv6+RXAgnEJV1PLzifBnueY7d6Ar7PtdK2aZfdKRntEWc3MsmtLJoPoAldWkGSZSE9ZTWkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870604; c=relaxed/simple;
	bh=C0ZWY8hLIGtthJBHz0nfbwuVM1uuVi6QhJNc6EkNAvk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FLo6kRwpGwFsSGEnlETkFMddvok8bZndyO1/+m7LgwtU1OH0AYyPEhT46BdFFK/SXOCM0fbZ4HChnZ2HkYc0YB3K2uwM2Wa3GwEq7g+gA+Pac9yKz4WGCzfC28IFj3PnHCC50AMYnH2u/sVgSYm/OSeBCfFYasRedxd6kb3gv7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyguHsNU; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710870602; x=1742406602;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C0ZWY8hLIGtthJBHz0nfbwuVM1uuVi6QhJNc6EkNAvk=;
  b=hyguHsNU//WJ0l1cwyoRsNWIAzAWFH1NOEgqgG8Cm5F7aJSvbjDMPumV
   mNYDkV5Zo6hF+DYZn8KjNHwloeKdN/7YOZ4pYNVQBaDqDqxBoz/IC/yc0
   C8AVgTMKdemzTgpqPsiJlGPV/yuFWhwef+st1FLj61Xb6//YIae+Ze9VN
   C7pt8bFAsdklOWmRAGE7lL0sjhB77gsVwbqf6nl8T52Ea9p7Eq8QQPYq5
   TEra4/VnxvJWtsqeOcQU3HjB7+Xbh854v9AbashlndM7FKa8WkWg3ubJ+
   L0f9450OjjpjWoZLeRasXRZquW0m4a1xnQru8oYeOSSA4ZUZEiX9qwr9w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5598970"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5598970"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 10:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="44977990"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 10:50:01 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 10:50:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 10:50:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 10:50:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeKkFQnT2C7wweza8HEJuY6gLb4ZlhTOG5Ee5HcCku6pDgXlRhD6Slw6bWMA/oL+iINanbkyUXTz5QtW/WPflGF0FqsIJKV/+bn6ZtBvlAO4v6/+i4K/m4K5en+1AJ5opvoZEUur6MQox1J2ByRRAr1GHhi+SZx7Ezu0prmlnuiRZUx8mUPWOSA3TAzzW7pgCzxBvoCkZ1UcsHOtFTtc01WZpZdoUnZDEpoADbDqQIqVA62zA54gYJCQLLJK8j01zZSp08K5wHRnhNMDa3q2EXoaADwZ0NOM6VCUsdygBXlQNY7qapwKlKZ/EVGAjGCv5jBE2+q6egEe48pdOcIDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1m+decvGXBpzatD085/HTgadW57Ahl3Z9qvhyFCavY=;
 b=JePFZRjIJ8MZVK5B8tHcxrnxwEnjW1nqVYjoQAVhyGOVzyESrOnjM8yHI1dejW4D9fCpI3XMj4oSwmhToBzmBAa/gyOb7AuH4TUX8tSEt/WTsVaPH/bYGG/EFgPBKNY4CZ56YMNMYTHMURqaVXurEI7pMyenVZz65ojI4zrIHgmCeSwVfW4YPo4XKMGzunu2WE0qEYRptB1LS2fq2HkITC+mDv8klN1YwthaBzNpsbxd6n5T8MTijyhE//cl/UYK1NFNam7zK1Y+cJRLCIKYdF89yGIpU4vFBQ3bwN7Iyncn2JBtQ7cJGwiJkSb52mpG1ZwOq7fvEJ0G2y1gu5Mlqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6113.namprd11.prod.outlook.com (2603:10b6:930:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Tue, 19 Mar
 2024 17:49:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.009; Tue, 19 Mar 2024
 17:49:57 +0000
Message-ID: <2833663a-ffcf-4c47-99ba-741772ae32d8@intel.com>
Date: Tue, 19 Mar 2024 10:49:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 1/9] x86/resctrl: Prepare for new domain scope
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <patches@lists.linux.dev>
References: <20240312214247.91772-1-tony.luck@intel.com>
 <20240312214247.91772-2-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240312214247.91772-2-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e215b78-90a1-42fe-2e91-08dc483cfe0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUeVf1ud7ZvotM/AeqFj5Lds2dEtYu9N1qbIQL503VDSO9TDlI0bDU8l9szs/RkBQ7DXrQNfbNfh4dcjCayo2jFMEJdDWSGp9ZfcpT0zi2yFg105PUcjm+J23JtdTBW9OBTGD9wRSpVbfO50shxDCVHH6kBNXqnG3JBA3kI8tLuJnqymMS9odgUoGIo2+WEZsDyTc01E2u31UjLC1gwA9ZHF2DS7UpZat7nMxptdSJCw8WEAnPkTKGS8iz1/i3Ld+/3HRJl6jtbLNrj+9WdS4zZBSrjhvxqlLRsczNK/R8lOT1oAczVTVC/o20HvQl+evCk0sW/VtagU3FnITw/hAerZ5KPZObRn8EE9jp5wzrltPnZu0qkesAIzE82ZFVYol3uzpB59LVgPZOH0DhvrjhdAvVRXg65xJvWCzhL0AYIqvw7+YwIPOaRvBmn/fszUfb8+4dNGxvUKSj/LRNBulLi6O/P5pZVGqst4UT8kcduXfztDNfh0USvw+cvFoNMSzOaySUoOSOzULYx9EbP16fHT6UXqQjFX9uQ95pGQb2x2LeD+vjt20D6M7juIy6cQAu2D953gWCt5cF+8DqhplX6qtHwJoGCjhYcQ5Wsr5zTTj/qnZcayjvYXph2he4CNb6RYlssSN4Vs98bHSf65QPIEXvYUhJikYypKk+vfQx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RENDa0NKQy9zOFhDMS9KTDVzWVZjWVZvdnd3UXZ2Wk00VUlEc0lNZVBGemtC?=
 =?utf-8?B?QVNVZWk1T2w1UXYzaEltZE1uRDd3TmJTQnhRdUJSaVhTSk8rMlJEWm5MZ1JF?=
 =?utf-8?B?TndEc2VrdGJxZkg1dHVnVU9zU2dEV2RJM0VtN3hBQmU2QlNIcEdJS0hsbG14?=
 =?utf-8?B?ZWw0SVlIdkVuY0RFS1NoY2Q4UXo3YlJQSjB3TEgrRzUrWFJnWlJrS2paQUts?=
 =?utf-8?B?NDVMaGwxWGE2N3k4KytUdnNkY0txRmhod0w5NVlMS3lUVU5HemI2NXVXTXBq?=
 =?utf-8?B?UXpiTExVNmI5ckpHWmhXL1hNZDN1Q0lPRCtUZUdXcElWYXBPWi9FMk9KYkZF?=
 =?utf-8?B?TFB4SXF4aEc1Y1VDbWY3VE1taTB6WWthbHBNcmJmTCt4Rk1VYklBSjk1NHlT?=
 =?utf-8?B?RW80Y3Bid2JLTVVrTjNqdXFvekJiZTRqTzlMMzhWSlYxVVd3YXIyT1lhbnJP?=
 =?utf-8?B?d2dWSUtJWHdnQnZTWFBTaC9pTHZWaGdWOVMzZmV1V2FnZkg1NndLOUFIbzlo?=
 =?utf-8?B?MjBxeWEzTzVFc0xseXZnUDVreTVNYVByU0dSdldXQnpFYStTY0srMnBpSnZz?=
 =?utf-8?B?dHVKb1lHbFg5SlRFa0h1cExyRU5xQUZGdmxyK2t3bERFYVhhUGdjUmRrYTdu?=
 =?utf-8?B?c3VNTzhnbHJybmcwQk1VWEFtUkV2NGdvTlh4TDFEZzB4NjZqTUFtUUhSa2pt?=
 =?utf-8?B?Rk9kWkNDVVlFSHQ2R2p0NXJjN0ZMYW05MHBOTURrbUg2ZDdvQStvb2dFNWFv?=
 =?utf-8?B?TThwcjRmMHc3cm5rRTdNc2ZDbHdCOWZXWno0UUx5SFkyMDZrT1BhRHJFRzVV?=
 =?utf-8?B?eGJZQWI0WmlqUGdSYzZwNUJwYW9zUzNSLzVzYk1FVjQwQjZ1MjNidkpJd0lL?=
 =?utf-8?B?SjROb1REOWdmTnlVak13MXQzV2crTEN4b1dPQjNsVjVFSHFSUDlaMGFSQzMx?=
 =?utf-8?B?eko3L0dUUHc1dkFmbklWVkEybXZ6UWtOc1pnUU1uQ0FWVkNxRWs4dTFrN2ln?=
 =?utf-8?B?VjVWN0pHWlgwQTk0dWJ1RGhCYWtpYVRVOXZ1OHNEbnVlU29DTzVMSG44MFBi?=
 =?utf-8?B?M3JXWW8ydXEraWNDUFlQcGR3R0NxZkpRdE9QcXFFemlPendmNmJSNCs5NzNO?=
 =?utf-8?B?dWd0SlA1UURFcG5vSVRra3lnbDlqMHZBcTZna3hMeUxaM3F5WnlzYmhVdDFw?=
 =?utf-8?B?Y3RVb3dKMG9QbzEzWVVQNFJCZ2QvdVpTWXUzakljNmhpZS9VYlFWYkNqMVR4?=
 =?utf-8?B?TFlJUU5FMTB0TG4rWWFVVnhNZ2xLYWVsRGI4aHk2b3FDT3ZPU0VKRmNTNHdu?=
 =?utf-8?B?Q2szdGp6K0Noa1V3UUxqM3E5MUl5L2p1VjdqMUU4UnE5TTBjVG9wNEZFZ21o?=
 =?utf-8?B?NnE3QUZJYVRwYjA4WjhKdU9ad3BmN3o5MzhVcS9oMTQxNjJ4c2ZjQUQ2c0Mr?=
 =?utf-8?B?WmNHL2R5QXRlYlJOOWF0aExZVldIbHhIdU1QejlNTkNpcGVKaTFJVkgvZnZ6?=
 =?utf-8?B?cUFzVE5xU1o1eGdoaXBuQnNFYTk5c1dHLzNjRmE2c0JqbDEyeitCN2huVS9z?=
 =?utf-8?B?WUFFL1AxQWJ5Q1FleEZDVHB4RGc5ZWpoWlJPZEV6RUd1d1hWQjFsYzlmdHJX?=
 =?utf-8?B?RU01RTJSSjI4dFhoZXN6emFuTHE4SkE2U2p4b2JjZW5qclc0SzBWcjVUUUVD?=
 =?utf-8?B?LzBkcTRzM0traW00dlRpZ29Rczk1MDBsR1loVi9SbDVma3ZNK0tBK041OWtJ?=
 =?utf-8?B?WC82dUdtbnFjemFlb0VTaHNUL200QklOUzlkeUNRbWFJRzBqM0hxODZ2Ky9m?=
 =?utf-8?B?eHJEdGJOL2oxTHdTS05jU0s0Y3RvTVBlYVpPTjE5R0hCcFl1VWFTZUkrWG84?=
 =?utf-8?B?NG9ENERlYnJWQUpiVkZxb3FKYk83Njl2Tk5Zalo3UnFhNitEYnE5aS9kM05p?=
 =?utf-8?B?a1YrV2dIL1h6TExyVjE4QW5DbVZDMWJ6TlJreEd4KzFxNjJjZTQ0ekJ5aVBl?=
 =?utf-8?B?emtLeUk2QytQSFUydTJSN1Y2SWM4UmY5ZmlNeUt5aEIyVFFaSlpSVHZLWUZr?=
 =?utf-8?B?NUFNclpyMFlKM2pqbHE0TEdJdjRtdmhGMFR3cFdZZ2JrWFFvaU02SXBrVHh3?=
 =?utf-8?B?UWpjVTdjZkhrSUdnTXRQOExsQmpRT3VjVzhCczlTSDMwRFk2VmhRNnRLdkFu?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e215b78-90a1-42fe-2e91-08dc483cfe0e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 17:49:57.8984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Q5UwtdHNhOB9RvGPPJLgVyKHJbZ4PmIKJ1rpw798lguivPTa2oRr4iPlacD/3pSq5GRFyla1CdAzQxpeykJIvSNBNzP/fzbJuJQmqQXQfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6113
X-OriginatorOrg: intel.com

Hi Tony,

On 3/12/2024 2:42 PM, Tony Luck wrote:

..

> @@ -392,9 +392,6 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
>  	struct rdt_domain *d;
>  	struct list_head *l;
>  
> -	if (id < 0)
> -		return ERR_PTR(-ENODEV);
> -

With this snippet rdt_find_domain() no longer returns ERR_PTR() ...

>  	list_for_each(l, &r->domains) {
>  		d = list_entry(l, struct rdt_domain, list);
>  		/* When id is found, return its domain. */


..


> @@ -507,6 +517,12 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  
>  	lockdep_assert_held(&domain_list_lock);
>  
> +	if (id < 0) {
> +		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
> +			     cpu, r->scope, r->name);
> +		return;
> +	}
> +
>  	d = rdt_find_domain(r, id, &add_pos);
>  	if (IS_ERR(d)) {

.. but there is a lingering IS_ERR() check here. I wanted to confirm that I missed
this in v13 but this looked differently in that version and seems to have
sneaked in since then.

Reinette

