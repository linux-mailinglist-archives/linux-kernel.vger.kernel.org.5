Return-Path: <linux-kernel+bounces-16028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF492823736
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898F12861BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33941DA23;
	Wed,  3 Jan 2024 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODX2MtXJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0A1D6BA;
	Wed,  3 Jan 2024 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704318046; x=1735854046;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kipWzJ7mnqb13HcmxII9FgAWuoif2bIvGCAO/oyS2oo=;
  b=ODX2MtXJBPBqcXGZltSIznXmhPHBN0H3XamIxChGniSNtu6kIYuRwipN
   TMOdc5wusJtnbuCLGFaLZI2SV/HbzXXu4Qj8PJ38kq0ZcjcZxxhTxnOLJ
   MEDxazbCTB/FZInAKHd879QVeAP4Ajo6TyPohfHusX0cDXplPi4YA4EaK
   fo8b1Gkgg1poTzIkAJSFLf3VnYnHh8flATKiLuKcCk8GlDO3NXPCT7L2Z
   7zHmNyKQjs8ANcUcMxZxUc0B3cTRv6JjC6mnEcRtEoy8U8evGpXXkrEDT
   BHWZoofmjF8dSptw2ubX/vdQP/jjRAqKPIjbV7crNXoh+v8qHByJExSXX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="15713000"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="15713000"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 13:40:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="846000669"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="846000669"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 13:40:44 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 13:40:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 13:40:44 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 13:40:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1j1n5zKcyEgikubeyV1cIcZXpDGJZnvJAIlhyfLf03uqAVVQq+r/CuBMiaoyYYqM+hIealHFVEFGzNjOHDBdHgbrG6c7xCcFiX/R7A9QuQFSdhhG87zUkZjv8pKps/z6e8sWe3ZWMfReX2HEfDCAGGVcyxT3JQUhsnpr+dO3Ak2wzEVXPPzjGIOXpUgbswwv+v372BwTrXZ/O//x3hhbRiICFULGhXPZ91n1EoVjX5TF6vSYb/02n/+SjsFF4nhQn6zsv46r3olyA2MAO0r5vpwF+wtBI/oHBYT/DnEAooAOX+dpqcJ29wL0GB8oApRWnJa4of9vHLScwOyJMfLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JIBwqgjwK1ADG0jI3xmYVcbiEINPn4bIrc8AXuOuyY=;
 b=eMgo2VW68IjPy+2ZQtvoEJUl4RqajpBGYGVRbxVRCDpKWvrBT33IlIY56QLVyhX+rgCUcWAfCVkS1nDJXLiKkPtlt8LUIgiTQcP8T5MbTTO+UGlLYHRHo8OvtPcGA7lbRHEI7v3UfqTUBcb94/vOCmXTlXlIZAnowh9k+aLULlmtABtVYtdzuy7RqVrJnAQrPcCxkgiVr6WfTUTkAO/0fVE3RWUqHdH3oYzPfPTDi2uzMFwJnacCtZVkA1nRrI+LJRcvqBi7q45kJVATNZeuO8hTiyq1ivSQjPWYWpodth2KODqIJ+tCTRTJ22fpJ5cetLHdyZ3eKPNi5c2y+r9EkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7717.namprd11.prod.outlook.com (2603:10b6:510:2b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Wed, 3 Jan
 2024 21:40:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 21:40:41 +0000
Message-ID: <54c18d29-3925-4bb6-bf39-ec5cb6dfeedf@intel.com>
Date: Wed, 3 Jan 2024 13:40:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/resctrl: Remove hard-coded memory bandwidth
 event configuration
Content-Language: en-US
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<seanjc@google.com>, <kim.phillips@amd.com>, <jmattson@google.com>,
	<ilpo.jarvinen@linux.intel.com>, <jithu.joseph@intel.com>,
	<kan.liang@linux.intel.com>, <nikunj@amd.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>, <dhagiani@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <170240414535.760665.1609957728181418569.stgit@bmoger-ubuntu>
 <d9f3d23d-aba7-4229-bddb-5d6801b22f27@intel.com>
 <978719d8-8492-47f8-afdf-09e7c997b0b3@amd.com>
 <ac9916a9-d83e-46e4-8dee-ecc15775e94c@intel.com>
 <0ac93544-106a-45a9-a3fe-acb107da798b@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <0ac93544-106a-45a9-a3fe-acb107da798b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:303:83::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: efd949b5-56ad-472c-2a90-08dc0ca4a1cd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uu8Dtg3wpqBXfhOny7S50ptsUqrjsiiTBOgX4KC1XvJAeCa5pRHfTQP1G4YuJ8Ljn1zc+btvKdthlnORPk66Dga47dec2LyBQzoZp6ThZ6yr/hxE/cTh6qfpg8QEtBAZM9nX6PO7zi0gv/KsNiwSLEK/5lXrZ0PMCq8kciSh31eQFYP+r09ugUu2PFuRd8iva/aetgvDqCJIViiOe1XzJp0P174bKS/wVIVQGBJdsSrcYvYfxUz0RQvsTlfDJVTdP9HOJg2v2hWP6PjymF59p6CGqoBdHxpyoHzFuCrYWMUZdpe1Ky/ME5HMpBuVGmFAlGE72tEZuKsTXLR0NzzgIgbH+bB+7/hTMWnuA1RTK2AX6dVokxCi028v9GQGSFhXbCAg7vvvIm/C8eqVjim9d8IQXHovOPJJD3XFO4YWqntSXq6C4eHX9eQHYKztr+/wN6jkARZPuyh5mKo/6Az55fZXhkUIMXZqdXVqbXadPISpNRAQqnJqC+g4wNKMQcYBsigxO/4L36A8uncfLwwA3p9gktswpvnhFT3HyYr9fg9vTDR71WXpZs1K2AB55RAJsUce5mnZg0eIMe7xDqdwdb+2ql+o3qX+B1bOfynnjEZ5gn6mHPq9/uMwd6Q+BAl4/ykEyG5xN6fxZEOoojkYww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(478600001)(2616005)(5660300002)(6666004)(6506007)(6512007)(7416002)(53546011)(4326008)(316002)(8676002)(8936002)(6486002)(66476007)(66556008)(66946007)(44832011)(82960400001)(38100700002)(31686004)(41300700001)(86362001)(36756003)(83380400001)(31696002)(2906002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU1iUklvdm5sUHFUbThyWE54SjBLWCttbFUrYlppN2NMT1JMaThiSHJVYldw?=
 =?utf-8?B?YWxSOWN0UW9TenpDUzVYYjU2RDlWZlgxMDNhb2d3M1RhOVMxS2gzTCtrVWU0?=
 =?utf-8?B?MUkrNUR5K0MxMXhGcEJMRzhPb09Da1Y5dzVjZEx5dW91ZEdtSjhCMTB2Ulll?=
 =?utf-8?B?SHVqZVJHWVROcm5ycWw4VDJrY3p4cUZ0QW1LNEt3V0t5RU5JNFcvSTIzNHBB?=
 =?utf-8?B?dUtLWHc2SXJrUkI2d1BIbWVNdHJzOUpvSGZoMW9MV1A1bmo0WkNsbjNNVWpW?=
 =?utf-8?B?LzlibFBIRWhHZEZNcVFZaldNeVEyWFN0NFptUGEzcWFaZFFPNjFCRWQyYUlW?=
 =?utf-8?B?djBnQjVDVnVVUThxYjFPdGRIRUZhSFhEemdhRHdBRGVKc0JLaUNFa1pVY1pX?=
 =?utf-8?B?Tk1VMkF0bE44Sm0zTnZ6THo0b1FNTDkyVkpvUGNLVzlSY05XYzlqUVMzTzE3?=
 =?utf-8?B?RmlnSms4amQyOGpkaldsUWNBd2NXb2Q2Z1BLSlVOcVVyRlhwRDFIcXc3RlhL?=
 =?utf-8?B?MEk4Z2tsdVZuY1JCSVhRN1pEUlV4QjVWMzFQSE1zLzNDeE9SWFB1MmFnRzFZ?=
 =?utf-8?B?YWxIZkoyL1dWaGhZUmlBNkcxUjZVQ1NpRXozV29hc0crRWttUTFwb1M1U042?=
 =?utf-8?B?Q25GQTBKRVJ3TW5rSkdmYU0xWkgzMjllaWZvZnJDWTM3dTBkU3JkdEw5Mitu?=
 =?utf-8?B?SmlNK1JIMHU5L0hLVmtmSVF2M2Y5dkZocWFNYWpaM0p2dC9HSWdDUGRvMVo2?=
 =?utf-8?B?TnJKSituSXdZOWVYTmpzSmhmQis2OFFoRmY0MjdzYmNNb25TWkEvQmJGQWhU?=
 =?utf-8?B?VU1pVzVIYVF5OGowYXNMWjVweWJ1bzN2Qk8zNG9wRFVkdm9UeVdKNXBnMjFZ?=
 =?utf-8?B?cDUzQUU4MVFXM1JnMmx6Vm1HY0V4RHF1UTQrTE9VQ0g3ckFVVkxudEJ6OXgx?=
 =?utf-8?B?NjdoaHowbXdrTlJ6elAydldFazh3UVBUenZ2dWppWTVPdHVHQlpieU5ya1hx?=
 =?utf-8?B?a2tBZGdaQmkycU5FY09YZ1BUQ2pwcndDYm5WZENqckgvMjYyblZ2aFRnTjN4?=
 =?utf-8?B?QWhKcXdMNzYxRjRRbEJKQXVJaHhRRkg2S1QybjBkR2dRdnZFWE9sQjlKZmFI?=
 =?utf-8?B?d003eWJqY3RrK2t4dUhUODVqL0NkR0wwU3crY0FJMzRxeS82TGUzQ1NYOUV3?=
 =?utf-8?B?aFNvMVdtbzhVU3NIcUdEVDFoQXJRRlE3Q0VKZ3ZSdlU0TzZzWlpodEJFcE5B?=
 =?utf-8?B?UjZtay83b2tzb3JGdTd0WWFvRm9rVnh6QVZaRWY4VmxoTUM4NWZIbnV5Z2Fu?=
 =?utf-8?B?VXRRRU02Rkg1SE1aUzBPVWxvcjA1VFZ3cHErbWlibmlXZHlwVmZ4N1ovQS82?=
 =?utf-8?B?dXhNb1Z4S1JQb1ZhTEtucmVVQ3dGcFhSdmtLc01JWFFvVk42WUhMbHZIK2lh?=
 =?utf-8?B?b0lmUE93UWoxRWpCUUhheU5qZThaTHBVMEpGa2dLbmMzMFRhZFFKcGRoUFRk?=
 =?utf-8?B?dllzd2xCVGpPTjhHUlo4RzF6alBtcmNoVWU5NkpoRE8xb0s4Y3FQYStGSlll?=
 =?utf-8?B?T1NSTU5tRUlkUDFwM0lLUWRzWXQ3T1hITmM3ZXFUVzRIYU9XRGRuaHJXeFdL?=
 =?utf-8?B?UUV6OGZWd1FzdTBGeGtRVDMvVnY5N0xpb2RhNXgvSlJCOCt5VEFKWk5ZOXRV?=
 =?utf-8?B?NW43TjJUZzdLdVZSZk8xQTgzR3I1WllmWGxvQ0pTeWViWlJiYTEwNStadnJ6?=
 =?utf-8?B?THN2VFR2T3FMSDJRb0wzZDJXaDhVYWRxeElnMEhuQlRIOFIwQndjWWdxS1Rs?=
 =?utf-8?B?ejJuaWNHaC9aWWcwa0ZnVHJ5cStaemRzWTNGeTVUNzBzbzFKdlJMY1ZwN1VR?=
 =?utf-8?B?MXo2WWFXTGFicFhrRVRrdytyM3NBV3Z1QUZ5L00yZ1VmVmMvK2N4eUxXUFhL?=
 =?utf-8?B?cW5pZVlCT3M4TGo2OUI3a2t4bm5XYVpROHdxbG5HWUU4Rm9xbHk4dzhpdkwr?=
 =?utf-8?B?V21XSGt0R2I3RWhUSjNjbEpSRDNOWWRieUlsWWpwK0djNXVvU1V4Y1djMlFl?=
 =?utf-8?B?Q3gwQjdwQWEwWXdhVHVuMHNweStsYkZpTzU1YkE1MDFjTXZ0ZEowWmZmUndH?=
 =?utf-8?B?bENLeEJTNVltUWovbEtyTFZwM2xkOFg2T0pGQjRrRngrNnpzbmhlWDdWeTJE?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efd949b5-56ad-472c-2a90-08dc0ca4a1cd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 21:40:41.0143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /95DRSSID7BsyysNpRGYKtzUxzbzPGvygisGnseEMDYSqVLIJxH1WhlTxHr1OGWJlsCX2XBBtO4Q6u+8rqpgS8765eOykaLq2DzLIntXhXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7717
X-OriginatorOrg: intel.com

Hi Babu,

On 1/3/2024 1:03 PM, Moger, Babu wrote:
> On 1/3/24 12:38, Reinette Chatre wrote:
>> On 1/2/2024 12:00 PM, Moger, Babu wrote:
>>> On 12/14/23 19:24, Reinette Chatre wrote:
>>>> On 12/12/2023 10:02 AM, Babu Moger wrote:
>>
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>> index f136ac046851..30bf919edfda 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>> @@ -813,6 +813,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>>>>  		return ret;
>>>>>  
>>>>>  	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
>>>>> +		u32 eax, ebx, ecx, edx;
>>>>> +
>>>>> +		/* Detect list of bandwidth sources that can be tracked */
>>>>> +		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
>>>>> +		hw_res->event_mask = ecx;
>>>>> +
>>>>
>>>> This has the same issue as I mentioned in V1. Note that this treats
>>>> reserved bits as valid values. I think this is a risky thing to do. For example
>>>> when this code is run on future hardware the currently reserved bits may have
>>>> values with different meaning than what this code uses it for.
>>>
>>> Sure. Will use the mask MAX_EVT_CONFIG_BITS.
>>>               hw_res->mbm_cfg_mask = ecx &  MAX_EVT_CONFIG_BITS;
>>>
>>>>
>>>>>  		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
>>>>>  			mbm_total_event.configurable = true;
>>>>>  			mbm_config_rftype_init("mbm_total_bytes_config");
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> index 69a1de92384a..8a1e9fdab974 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> @@ -1537,17 +1537,14 @@ static void mon_event_config_read(void *info)
>>>>>  {
>>>>>  	struct mon_config_info *mon_info = info;
>>>>>  	unsigned int index;
>>>>> -	u64 msrval;
>>>>> +	u32 h;
>>>>>  
>>>>>  	index = mon_event_config_index_get(mon_info->evtid);
>>>>>  	if (index == INVALID_CONFIG_INDEX) {
>>>>>  		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
>>>>>  		return;
>>>>>  	}
>>>>> -	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
>>>>> -
>>>>> -	/* Report only the valid event configuration bits */
>>>>> -	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
>>>>> +	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);
>>>>
>>>> I do not think this code needed to be changed. We do not want to treat
>>>> reserved bits as valid values. 
>>>
>>> The logic is still the same. We don't have access to rdt_hw_resource in
>>> this function. So, I just moved the masking to mbm_config_show while printing.
>>
>> Why do you need access to rdt_hw_resource? This comment is not about the bandwidth
>> events supported by the device but instead the bits used to represent these events.
>> This is the same issue as in rdt_get_mon_l3_config. The above change returns
>> reserved bits as valid while the original code ensured that only bits used for
>> field are returned (through the usage of MAX_EVT_CONFIG_BITS).
> 
> We are already saving the valid bits in hw_res->mbm_cfg_mask during the init.
> 
> hw_res->mbm_cfg_mask = ecx &  MAX_EVT_CONFIG_BITS;
> 
> I thought we can use it here directly to mask any unsupported bits. So, I
> re-arranged the code here.

I am not sure where you mean when you say "use it here" since mbm_cfg_mask is not
used in mon_event_config_read(). My comment is related to mon_event_config_read()
that can reasonably be expected to, and thus should, return the current "mon event
config" value and nothing more. 

Reinette


