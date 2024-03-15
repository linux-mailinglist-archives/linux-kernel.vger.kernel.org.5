Return-Path: <linux-kernel+bounces-104063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B3F87C86F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2816B2201A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A02FBEF;
	Fri, 15 Mar 2024 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nG3iaqJ1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F16FBE8;
	Fri, 15 Mar 2024 05:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710479354; cv=fail; b=BsfEDO4eUGasmeQlBH0rgEhXo9jLmZqXP1oZh7xmL9r2v2pCrHCnDDf9xzohz52AJpQbLOpi/DPwHaSPc3naFGE4UiHQlE4Z3Gfcrh+coGa1cMyx4pl/MFx3GlgPfPfxjbVj9BVydmbaQUoOQsUgH/743CnSPa7byTlma1/OihE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710479354; c=relaxed/simple;
	bh=vdtNl7lMY7vRwqSGDTd+AMpWn02N8n8ura7lI5LMGvw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hC9OyyBQeY+s9HSbuuKiI7SLfrzYB/1FaJ848JKJuoKgmU+5zrtdA7SSW6PoUBmsg/6eH8q+v4mcE7itnJy8rNlzcju7HlH4euAL8RXWIqra4CiQhmoVUqjlNwKehX+uEDSjvCVJ9uEpcVufRHSEgb4nNUo1aykKVIquq8FIBzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nG3iaqJ1; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710479353; x=1742015353;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vdtNl7lMY7vRwqSGDTd+AMpWn02N8n8ura7lI5LMGvw=;
  b=nG3iaqJ15JA68GskpEfTVcm2atq8qP0n81HX3cqbIP9Er0jf99k1v6qj
   SLA0xkGIXAeYz6O9l1FeFQdva/XTL5GyBeK8WP/qtYcvD6ZKv9LdNYm+x
   akfWphIZT7AvX2jjFi//Dag2i1Iyafsit0Th1U4kglWi6cHQuXA70nJwy
   MUjmugAmjR8n+jtP9yXz3Vp34Yx+D0lynGLZolfXNeHos4gUtZkJ1hlcZ
   JI7V3AUap/HQOGesJhculaxLqg8Pn7f+oh5P1ZiA4OuAGG+t6TIt+gSgX
   OmWgE5W1jNJ7uVt940B/HW8hUJIAgVi43yA77oCxL0G/NEZNLwl8v9z9w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="27806468"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="27806468"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 22:09:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="17211453"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 22:09:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 22:09:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 22:09:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 22:09:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqWJw1KnP49JZ2fcx3rsz7ZaN5PG4g8c0dsCSBOO8LEptcIElEpchu7Pav0u9tM6yA14m4Awg5vIyyxgHrULkMDx4uLEi8MQF59o8qjLPmmGcwZ8VeVnxHHOTDRXFIJkH/efDj7I97+e56hAxJ31MQaKDq8BZ431oZm4jC8mDnGBNubihiB3K28yroY1CFVgWfkza3VlujPUGcnYR5Oy3xx7fHMtNtni1j0RPOsFWJb5I0dCiPaFL7vhNOjpAI1abGyO3b57ZQRuBjPngxiJb2qAB1i8Vkzz5is/vymbHkcs0k6bTgsltzZg18hJbM7QHwPJEWJbGDGsFvcCH4CoDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVt+KIG3uQim4lkAJiU4xo7xgjQdvgeWKC+Uf9dyBfQ=;
 b=NkU1mvQQMNu+pEeldmMd1vNey4tq0xR1QllslLQxDX8oHfslgBKrb7EyQfFZrIPmC44kwJqISdJIwkXqYYwFKDdv5YyUyCBnscdB1BYxHlXz3U5tnwiGGddayjsG2h2/ROvx3VWwC77EHupC4PNAAhwei3KzRpXo3gmAZCEBblbo7PnAKV32YuVNv3bOa9bYDdfwljdRpFX5trePBPPOA1eUJpkb2sSKltsnhIjvqJuSubK+/2xMHqgyCAyMFyutn7D3k1qOpJlcMzFw3fhFy6fSLSU/hwVcQUHKSsLOg+m0T7I9GofZinjqlowpGAc7nA+LRZP4VUjy18ZMfbAiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Fri, 15 Mar
 2024 05:09:06 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165%6]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 05:09:05 +0000
Message-ID: <60689e0c-4e53-49c9-82a6-7c431008c177@intel.com>
Date: Fri, 15 Mar 2024 13:08:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] PCI/AER: Extend RCH RAS error handling to support
 VH topology case
To: Dan Williams <dan.j.williams@intel.com>, <rrichter@amd.com>,
	<terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-5-ming4.li@intel.com>
 <65f3b2b29cfe9_aa22294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <f2dd9f36-5e69-4c6e-9640-7140a694086c@intel.com>
 <65f3c8fb458d0_aa2229435@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <65f3c8fb458d0_aa2229435@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|DS0PR11MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b1a15a-9cf3-48a5-9ed4-08dc44ae098a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LsZMhqfOWgUxUTXq3SUDfE3iIjKh9MQRxpV+j4UALXxxuRbuVOT+GTUiNYS9Rv+x8JSVCbVWlDRK8LRsEPa1Ka4MFL9tM+px1LRVWrDzI1atqV68mHkYb26tZ1OCZd8P6cQR/VC6JWQGWwm8u35erWtlh/w82PRQ+xDn6w0LxbC2RfTOSLSFAf63W2330NjU4jkKR2wu/jJuPYTknZbkbcGzOnPZLfcf8KuKa+sI0fa37SlDuSZVYT5awlQIRhKQ8eLSEVKyJQJY9OjXLgj/2XBtjvUk/9GGCuz02aLimaPPy3zjLk23dkqv/B2Bq1QeBnMTflobnsRIDkFrjGIFU3xyYKuM8wewUKMEBZiOLJRG68Ms74bPcESK0qEeihdChlYKOq84ZIzN19vaYqbdv9dElLKuLLThfw0G419iCWh3/mQS2jgZkpTv5Sa6TsuNX6pzxLvkuygAXj+0tPO5K3ueTeCDHvjw2D5tqmT0UKlpuKZzzIYpuwpo/sBjrp3Zc5LFrQM1cV0MXjQqGcCaQR17lKKBd92NdQGw6dF9CUbZYeweHSwaoAxWw8ogsM8Baloud6k83gxPJ4kP+uCF89bKpCgK+AgUxIxSq+s1Z+NC4OPr3EeXQTSGHw3HxVdZ7VysVtukKufEJm0B8585/qZSeT9huyjGn7C1y5syoIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWZLUGsxVzY3R1pFelhKREl6SWQ4Rnp4K0poZ21PY3ZubVdWM2VGMXlwc0JO?=
 =?utf-8?B?UktyYWFLTXhudVlLVy9nUWRHMXhPaW5rOXBZR3FzMFM1S25YTTFVTnNpbXFU?=
 =?utf-8?B?Vkt5YSsvR3Qzb3c5Q0JoWktOSUVRdFpPZ3E3dkRXbzFxNll4L09OOGJhZmVX?=
 =?utf-8?B?UEwxZE1vNVAwYUYrZGYza1lKMXphL1pPczdvbmUzNXVVNHhPN3I0aGhMYTRm?=
 =?utf-8?B?dWh3c2ZwQjV2bFFxemhtYjNmYlRXOGtXUU1WNFhxa1ZyUWFMRTF3cFY1dEtS?=
 =?utf-8?B?TkZtckRKOVhRV0JRRnpMTERaYm5WTEE2RUY5UElBZ0Q1NWhIK2hpMjRtTzFE?=
 =?utf-8?B?bnlYV2R4YmRkOUJ6VHZHdldLY2JIaEhDMGMweXErWjBtOEROL0xmcVNDUHJG?=
 =?utf-8?B?dURrOWY5WjFZR3NDQktwa3lwSXJOaW5SNElNZnZtOXRvYk4vTFJhQjBlTzg1?=
 =?utf-8?B?SUQ1MDdxVUx0QXdqMUZ2UFlVVXJEM1VZY1l6ZzN2bWpFSXZJZXJlZGhEM2U5?=
 =?utf-8?B?SzdBa05mSnhQeWI4MUpjSU1XNG16U28xLzRZY1BadExOZmRYdHZSMzhldmww?=
 =?utf-8?B?UHo4REtyR2FEYm9Gc1o4ZVBqbkFZQkVPWmhsUElGTFcxZjRiTDRTZXV3VEw3?=
 =?utf-8?B?UENZR1ZSbHdzV0RsV0FCYTM4UVNLZmlBNG9EQlozRUVuQXN5WWRWT0ZVaVlG?=
 =?utf-8?B?L0R2ZFhsbzNTQVpyWUc3K1ltQnBrdTVuaUlvVUFjR01qS3g1NTE5V2MxRXVE?=
 =?utf-8?B?c3BGSFpYbzNNaklsVyt6V0lBSzdORFQvZmxJMjI4cmpJOFErNjY4YTZkc3Rz?=
 =?utf-8?B?YTlDWGo4UXcyaWFlUDVra1A4V1pldHNpcXBXNGxaQitjQmdYQlEvTDlHMy8y?=
 =?utf-8?B?Ukk4NWozTTN2TG5EaW5kNHJIczQvZkxHWXUzQzVnTEIwaG1NK1VvcHc5eFpr?=
 =?utf-8?B?ZnlJOHlybStqMkM3cXkyQlVVdkZVVzdnQ1ZjSDdsZWM0Z1l5RnhhdjFsSmd3?=
 =?utf-8?B?VGtmSTRYMEs2TzV6M05GcGl0ZEx1ZGtPTU12S2puSU0zNkNQc3FZUEwrWFdZ?=
 =?utf-8?B?cUV5bU41VjBzR1BPS0hzanVObWREZWNnMGVEU2psTjdhOHBZYmlPWXB5M3lx?=
 =?utf-8?B?cVBJd1MrT3MxTzFpRnpaRzErUTRGeHBpSitlYjFyRFRreEFFd25Cc0Z5OWZM?=
 =?utf-8?B?Z1U5anB6TXN6NTRyMkNYVWZXbUlSVzNxU1dCalhDSXdyeGZCUjk1Q25zUXYz?=
 =?utf-8?B?SHFKQTNHaVdQV2IxTWIzZXdnZXdGS05paFNYZzNmUVRkWFE1VTA2NW5ZQnV6?=
 =?utf-8?B?T1pvMWlnQ2ZOSjZydjU2cWdENDRtMDJmVHBidFg5WFBRRm5DdmZKNTN5dDcz?=
 =?utf-8?B?TVA0TzRldTVTVmhnd1RWL0svZGg3SUNEN2ZiYkhPTVI1SVRhOTRlV1BReGRz?=
 =?utf-8?B?TU83eUl3TTRBVnMrNk1hU1FieTNrOHdiQ0p6ZWIwd0gyR1VhdUpVWGdXeHBS?=
 =?utf-8?B?aTBqRExTbGxRakpOU3dBblhPTnFYa2owVlFTN0FhazZ3WDg4SWo3WjdvalpO?=
 =?utf-8?B?VzYrQnl4djNuS0oxVFNxVUlkbmFRbTRIa1RtZjNjSHozYXl1R0ZIV2JsblQ1?=
 =?utf-8?B?SVlwdHZZUlF3Mm9NQTVSelRWZE5OemxnbFQzNW1naDhKQWdzRWtuMHcvY3V2?=
 =?utf-8?B?MWRYNmdwVkhyQmpjQjZrTVhRWDhWcWFVVTJFbS9hOEdUMlhiOWRYWmFCaHMv?=
 =?utf-8?B?c1NFRGFQelhGaFVORkhXcTdqMEJTSUU3c3Qyejg1Wk5QZzhZTTFZaDhxc0xL?=
 =?utf-8?B?NkwxQnJpN1N2R0p1SVptbkg2WGtMdTZVZ0NPMHpobG91WXMvZjllNXp2Q05I?=
 =?utf-8?B?R01MQktSVjFxb084Q0VMRTUrRHlVUUpYSTdxSTRSUDdYUmpBVFJvWHJlK0pI?=
 =?utf-8?B?Y0hvSkVpNkR0K2ZjVFRMVEN5S2ZtNkgzd0xNeGk5ZWxzdE9tdjNRbDNCVjFu?=
 =?utf-8?B?aVVRREJVdGVpUmNjVXdzYS9SVXZvdEZUNU56Qit0Q0Z6bFZGVzdEVURETjZU?=
 =?utf-8?B?YWMwc3IyOEN3bVhFMFN5S3dyK3FPem9YSjh5TE5ONk54YitvWU5UTEZRVVNC?=
 =?utf-8?Q?tOHF47XpcvNeZit63itMq5wvx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b1a15a-9cf3-48a5-9ed4-08dc44ae098a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 05:09:05.8096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5DYe6/T5JE/RbuEvt6KFBkH6PCYyRFGOo8p1t457fsFQph3U9iEuC1tp8eMf2fqzrc9totWiUL1kUPrWUB8ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6373
X-OriginatorOrg: intel.com

On 3/15/2024 12:05 PM, Dan Williams wrote:
> Li, Ming wrote:
>> On 3/15/2024 10:30 AM, Dan Williams wrote:
>>> Li Ming wrote:
>>>> When RCEC captures CXL.cachemem protocol errors detected by CXL root
>>>> port, the recommendation from CXL r3.1 9.18.1.5 is :
>>>>
>>>> 	"Probe all CXL Downstream Ports and determine whether they have logged an
>>>> 	error in the CXL.io or CXL.cachemem status registers."
>>>>
>>>> The flow is similar with RCH RAS error handling, so reuse it to support
>>>> above case.
>>>>
>>>> Signed-off-by: Li Ming <ming4.li@intel.com>
>>>> ---
>>>>  drivers/pci/pcie/aer.c | 20 ++++++++++++--------
>>>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index 364c74e47273..79bfa5fb78f4 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -996,11 +996,15 @@ static bool is_internal_error(struct aer_err_info *info)
>>>>  	return info->status & PCI_ERR_UNC_INTN;
>>>>  }
>>>>  
>>>> -static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>> +static int cxl_handle_error_iter(struct pci_dev *dev, void *data)
>>>>  {
>>>>  	struct aer_err_info *info = (struct aer_err_info *)data;
>>>>  	const struct pci_error_handlers *err_handler;
>>>>  
>>>> +	/* Skip the RCiEP devices not associating with RCEC */
>>>> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) &&
>>>> +	    !dev->rcec)
>>>> +		return 0;
>>>>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>>>>  		return 0;
>>>
>>> is_cxl_mem_dev(dev) will always be false in the VH case, so how does
>>> this change help the VH case?
>>
>> Hi Dan,
>>
>> I think it won't be false if the CXL memory device is an endpoint.
>> pcie_walk_rcec_all() will walk all pci_dev in RCEC assocaited bus ranges. So these two checkings can help us to filter:
>> 1. CXL memory device is an RCiEP associated with RCEC in the RCH case
>> 2. CXL memory device is not an RCiEP, so it should be an endpoint in the VH case.
> 
> It will be an endpoint, but I though cxl_handle_error_iter() is only
> called for RCIEPs and RPs that are share a bus range with the RCEC. The
> endpoint in the VH case is downstream of the RP.
> 
> I had been assuming that pci_walk_bus() limits itself to buses within
> the Root Complex however it descends the entire bus hierarchy so this
> implementation will walk the entire topology on all root ports
> associated with the RCEC looking for any CXL device. That feels wrong.
> 
> I would expect that this limits it self to only finding root ports and
> then only proceeding if that root port has a directly attached CXL
> device.
> 
Got it, will change it in v2, thank you.

> Note, when you send a v2 of this RFC be sure to copy linux-pci for these
> core changes to PCI error handling.
Sure, I made a mistake here.


