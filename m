Return-Path: <linux-kernel+bounces-39270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7369983CDE7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE24B26549
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E05C1386C9;
	Thu, 25 Jan 2024 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPw3TRzk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D4813665E;
	Thu, 25 Jan 2024 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216309; cv=fail; b=exrvgFY/2cMsTejRenOcui/UPvSMMo2koA3Eo5CFVGH/VCUdjihTxFA90q5tJq0dqoAX9D9Vfi7FX+LXB+xXRF+RA3emkDp2wg2BP4C5PezBY3CMjS4YB+Apf9LXGyNpBcAfdHeJjKNvAKZTIAzQ+gFTRjERbumV/MOJUI/TJLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216309; c=relaxed/simple;
	bh=sxrNP3760MhAGfqgb01YLqtPqCmDSbpedE22MaZOLcw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KtPDo3/sQ/in4dehAWJvWNkIlx0paQE4CHm8U4AcGzGvJe/wr9NBD7AxCqKIDyaZPV9DA+ZOhN68lJbkV3GvrFiSWGNGv158MhgN9LfWifwmumKe9mhWSjqjwVSSvOFHHO/p9OVymJhneUchdq1cqLB7EVs19UQr9viFTX7Cyy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPw3TRzk; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706216305; x=1737752305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sxrNP3760MhAGfqgb01YLqtPqCmDSbpedE22MaZOLcw=;
  b=JPw3TRzkeDYtz+zHdB6FEqTqpXZUp4QcBJkWTXWyBAcbS/o3V/1utQ+A
   yma53WwQ0nXmxMq1zU3ahZ+G1dHXEPCwow11O0YgqHQMjwFNfExjeFQUZ
   ZdxLmh/g2WdknYMSKfELKhZjIudgvgbAACKIyVbTnDOUmF3urWzegjQVa
   ZwZ78jRTJxKbtVaNxd2syn6ohuz6Na4moeU0hkQIm6Uf/7mPl1Fm/C2n/
   AjHpa0fVM8mu3XY8th8GeJL78FV8Z0J4p/zOVrEgWAnYT6SvDadXlHYrO
   DqnDvtdsTHhFr3uNmcFUxghmRfUKiAMSULwePnfECaxDqR7mGuvPBXEBC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="1218898"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1218898"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 12:58:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2553519"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 12:58:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 12:58:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 12:58:21 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 12:58:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7IclIRHscjVaAZAvPwKhucgA6q5d7jshM2CpMvyCl412FWStEqAED4rSMn3aMKyeDj5i4xrH5AxcOvTeaabYITc+4o9FJx6XjpeusnABfT3f1aytL/5XrfE4P3YBi3JH7wZVEgIhFFDpMVlB/TyZJ6N5o4LY2zRAC4f1ZLjs3R9xEWJi+nh6gH1OPfP0+5fvBa3Q/i6bCxUcG6THfG2qrvQFgOkWItEHG3S4S1EaDZJkodEVcv3CBmvaxLsu4mfqVd3drf09aBYj0YUfaQ7WYgJEVIzlTaYi3nSCEQ7Lmbo3NJWrh1aSArq55A83jCv6ZXf7RUMR2LnOVJHdZvnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tM7pstojN/Uc+Q+gKSHEIbKhKlcj/mbQVGdaFMzzt4=;
 b=X/Jc+UNbok4b7ManJtupS27JLEpV9MREYTIUdLXDe4a6pFKGpu7iGyCowuP06fkin1x5ojdhwFR1M1HVkNHS5J5czDxHVRatr0wbYTmj4t6AMBc7TuTEtqiRLU/w8uKZSLDpWyvmk4DSyCpZ3f1UoESfHBD30fBCaZmqHHXRYiNZs9+V/mmjAnPCPPDBoKhdw/WgwA1Q7B2pdzyuXg0tImrsQScA9FRYIO8hZahp1ctJy0NPtaO0k3lffN7d0KmrWtWHd8I22hLwXiM5tmGlYpAiUycJaGnKGbvjU8hcR3dVx4eu8gZ4fl6OXMLCgihm2sZNeJaeVxvQT8QP66d0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SN7PR11MB6798.namprd11.prod.outlook.com (2603:10b6:806:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.39; Thu, 25 Jan
 2024 20:58:18 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 20:58:18 +0000
Message-ID: <a5ddf76b-26bb-49ed-b202-0bde606a3bea@intel.com>
Date: Thu, 25 Jan 2024 12:58:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tracing: Include PPIN in mce_record tracepoint
Content-Language: en-US
To: Avadhut Naik <avadhut.naik@amd.com>, <linux-trace-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
 <20240125184857.851355-2-avadhut.naik@amd.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240125184857.851355-2-avadhut.naik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SN7PR11MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ce78f4-e72c-4a2b-e02d-08dc1de85b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9KJy6rrmn87+gDspYb8mHZxNk5ZaWzIAV8c4+Zag30cYzkrR8/ViEVACWlknKoN2Z6Tt3mi7G80yCVj9Q1PcQmS20tzDLJ4jZg3Az22m/Y7S0PvugNsqua5Kn0Agn+7LgANAIkM+f4h7jothbb4vhoSXYfv0ToB9rS+3kNpp2fpiwsmgWuFoJ98G8I2ojuWUEixm3QzuaF7mZz2qYH57PqVvvx61GjIQGHOLXYpk3N63TfR5Ho8XbCeAVVjT+zQs3vm/lNd7q0XByJKZ500K9La0JUhPzB+s/mzKzuUagzlZMYmlEb3UmipQrQul9elpSM1f/LP4N3Fq+trDSGcdI8mvBUpOH+QApp7z4exCgbQ07e9tfKCznb4CHY4f5FO/hMftwuhvcWxxa6S9QXIs5aOc30nXEGtgk3HY5Qo6H9b2m7ArjeVJtjxOs8piKo9WdYkKZT21cinLq9CGblIdH6oPAfZWpgqAQ5ZV0tLzHgxMf4iWarFvdswenqAEuU/ylktfJV9zlJXsD/dpvYEsf55mWQZP3WiENWOPwJ8hwVqF2Og9sSTv5JUL7T08XcyfFCSW37dJU6whCdtfdwSehu1TSpU2cgfPCyOWo+QlAgOatA23dSmgnHl8bNWWM/J2YU0L5JTl2DOgAm/nC7k6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(82960400001)(53546011)(86362001)(6486002)(478600001)(83380400001)(36756003)(31696002)(26005)(2616005)(2906002)(5660300002)(316002)(8676002)(6512007)(8936002)(41300700001)(4326008)(6506007)(66946007)(38100700002)(66556008)(66476007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUErdGNLZzNrdzBXVmVTZnVpQVloVDFSK0hOWHNUVTZIUEVIR2hmWWxUcHRn?=
 =?utf-8?B?bzZZajJjYkJlR3hpcDVVd1RXdFJHUWRYWE1QbEZHMmpERU1SR3pOVm5ZbUNY?=
 =?utf-8?B?bm5GVmwra3UvS3ptUGZpZkQwS0ZKTmJUeXFkNWhOQlMxZ1BHNFhsREdDMG9J?=
 =?utf-8?B?VXNaNTJtZ1JwT2ZDQU9tZTN1V3IyWGFQd1JzWXZIUnNCWnc0VmRnM1NrN2Nr?=
 =?utf-8?B?TnA3Z2w3ZTlYQ01Gd2plR0VvUktuTVo4elQxelVyeGpqMU51V3lNQlJ6ellp?=
 =?utf-8?B?SXZIb21ZYityOHNPSlRvenRuQVlpWldOeXlDTTRBVStLbjNYZ1dKRWNPVWw3?=
 =?utf-8?B?VWFNbnNNT0Zubmw3RlFJYWNRbmF5MTlORG9SRndyWkRqblBLaG1KUFNkYUtB?=
 =?utf-8?B?bVpmY0RkOHJNYmppOGFvRS9rbDgralJsd3JBdExjUDJMdksxVE9lc2U0TlV0?=
 =?utf-8?B?VFBMSEM2dGtFUTBmVU43T3p3SXdQOWMyZkZwQnBIRCtiNGExdjhha1Iwd1Ew?=
 =?utf-8?B?QjdQa0ExTis3djMzYjJ3Q1BNbU4wcGZ1Q1hoV09vc2hXaUMzV2ZQNllJbGJq?=
 =?utf-8?B?R1ROZ1doSzBzcVJQRGlBOWZxU2RyVjMxakpVUURQdkFtdEhDU1h6SlZtZXZG?=
 =?utf-8?B?YzBOR24ySzJTaC9Oam83Ujh5RXpHRjNHWThhZHVpV3lKQ1J3b0ZoWGtWR1lu?=
 =?utf-8?B?NWdQakdUYkJ2NE9DUXdTTTVPcG9yYkUzbGNaaE02bmczTWt2andBRG9TRlVR?=
 =?utf-8?B?VlF6K2FCUzBJbXBxeUI5NDNkLzBlTUpOM1N3N3E5VGw1eVZZWHZscVdHQ3B1?=
 =?utf-8?B?c1BxcXQzUitGWkhtZmhMenplUXdZbXd4TlBLNE5SaG5PZWFrTjNIK0RkdVF5?=
 =?utf-8?B?aGhYY084dTJaNmt6MnMvUlIreGpuNUhQM3Jad01RRDREcVEzRnRXeHBVajZU?=
 =?utf-8?B?T0xhSmFLN0pyazBKYURocWU1cmJ5WUVTZHV0UXFKVHRta0s4MWlZRG0rZWls?=
 =?utf-8?B?eHgvMTVUNzRyUktFZDVjQzBXdGhZeGllcFF3NzJ0RGNFdEhWLzQwSkptdTlz?=
 =?utf-8?B?bnNjajdaYkI3WTFCdHRqYlJsS1oxODVpZFVmMUJUTkJVdEJ6dCt0cmhkMXhz?=
 =?utf-8?B?OEluNXYwcFJ4dVNYOGcrWUJFVXovVXVzdTJjK0kxbDA2ZUZZemFiVWY5VEoz?=
 =?utf-8?B?UGIxdXQrakFDckN6MWZ6WFVKcEhNb1BhVlRFczljTWExMmtFRnBSTXBhVi9N?=
 =?utf-8?B?bWsvYjVPSHpSZzhkd1pQRlRqSDExaHhSVDNyN1hVYmlUM3lUU0h6K1c1QnBv?=
 =?utf-8?B?YmhsSnVkbUZLdDYxU0RFOHNVL0w0a1hURkg3LzF5NktDQWx5dS9mR0tBTk81?=
 =?utf-8?B?dURzdWJmWnZvL2lCNUgxdEVsRlp0L0twamN1ajBkTTNSTzVHUUNpZks4REVp?=
 =?utf-8?B?WVYzR0UrbnlsTDl0QkFHSy9Sd1ZjQlpCSzdWZnVtaCtJdHdYSkpwVHJ4NVRs?=
 =?utf-8?B?QUlQZkozYjd2OWxDWWhhTVRzc1VwdWNMeDBjdkVPMWxVeVdyN1ZnQ2ZMYStT?=
 =?utf-8?B?c3Z1ekZZSXVkUnQySTNhMHlnTk4vZktCUllQR1RXbEFrNUllVWFMSGR0QmxG?=
 =?utf-8?B?SFJ5cXJlYUxMem1qZ1NwL203a1VwcmpPbnJuTWc2OHB1MnRGZW1zNm9qR211?=
 =?utf-8?B?T0h4YkppOWNuTXFLVUpBbjFJWi92OWFiNURQUVVPSzBFU0k5SzhNVEZ1QXc2?=
 =?utf-8?B?T1JKUm45NmJ2WWd3K2NyNGVMNy96WHMrN21ySDl3UEJZKy8yby9YQXJkaHcr?=
 =?utf-8?B?Ni9hdGdUb1BhbHhtenVOdDQ1ZGZUZG1wb01FUndhMWxjZzFYK3hlQWRVb1Ns?=
 =?utf-8?B?a2s5MVQrc3ZpcWt4VDk3SVJjSyszRldudnBFMVIzRkszdzJKcmloWHgraHRn?=
 =?utf-8?B?OFlzcGJtQzFDaE9GK0sxS3A0MlhBaXdzZnJreWN0TFlLRFV6dmp5TmtmcWVt?=
 =?utf-8?B?Vk45V2hkZDQyM0hnYU5SdUpXK29ibVBtcDRQQXI1YzNKVW4yeHYxdHArVHlW?=
 =?utf-8?B?RDBxM1FiMTN4V1JYQS8rSnB1aVp5cWNLamZBMFBXaTRuWWZRQ20ySitaL3hz?=
 =?utf-8?Q?Ncm6ekKq2mhZ4FsPnzZsSlmB1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ce78f4-e72c-4a2b-e02d-08dc1de85b5c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 20:58:18.4094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2jqln/JaZP0k5KSi/xaM5xSu6BgLkpMOOfsP71qSXSJ4loTeL9PCqoPaor8fSv9WVM16/CL0JG9Vg69IhRIIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6798
X-OriginatorOrg: intel.com

On 1/25/2024 10:48 AM, Avadhut Naik wrote:
> Machine Check Error information from struct mce is exported to userspace
> through the mce_record tracepoint.
> 
> Currently, however, the PPIN (Protected Processor Inventory Number) field
> of struct mce is not exported through the tracepoint.
> 
> Export PPIN through the tracepoint as it may provide useful information
> for debug and analysis.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---

The patch looks fine to me expect for a nit below.

With that fixed, please feel free to add:
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

>  include/trace/events/mce.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
> index 1391ada0da3b..657b93ec8176 100644
> --- a/include/trace/events/mce.h
> +++ b/include/trace/events/mce.h
> @@ -25,6 +25,7 @@ TRACE_EVENT(mce_record,
>  		__field(	u64,		ipid		)
>  		__field(	u64,		ip		)
>  		__field(	u64,		tsc		)
> +		__field(	u64,		ppin	)

The tabs are not aligned with the rest of the structure.

>  		__field(	u64,		walltime	)
>  		__field(	u32,		cpu		)
>  		__field(	u32,		cpuid		)
> @@ -45,6 +46,7 @@ TRACE_EVENT(mce_record,
>  		__entry->ipid		= m->ipid;
>  		__entry->ip		= m->ip;
>  		__entry->tsc		= m->tsc;
> +		__entry->ppin		= m->ppin;
>  		__entry->walltime	= m->time;
>  		__entry->cpu		= m->extcpu;
>  		__entry->cpuid		= m->cpuid;
> @@ -55,7 +57,7 @@ TRACE_EVENT(mce_record,
>  		__entry->cpuvendor	= m->cpuvendor;
>  	),
>  
> -	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
> +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
>  		__entry->cpu,
>  		__entry->mcgcap, __entry->mcgstatus,
>  		__entry->bank, __entry->status,
> @@ -63,6 +65,7 @@ TRACE_EVENT(mce_record,
>  		__entry->addr, __entry->misc, __entry->synd,
>  		__entry->cs, __entry->ip,
>  		__entry->tsc,
> +		__entry->ppin,
>  		__entry->cpuvendor, __entry->cpuid,
>  		__entry->walltime,
>  		__entry->socketid,


