Return-Path: <linux-kernel+bounces-15874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBBF82349E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E02B211B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0F1C6B9;
	Wed,  3 Jan 2024 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FtQ6hzuj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE151C6A3;
	Wed,  3 Jan 2024 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704307108; x=1735843108;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+h2b8u30aWz79nx1rm0IDOKk7ai9Vg8q3tAf0ENkkQw=;
  b=FtQ6hzujE4zJmWKIXPBZ5PX1CsAjpttUJSiWeXcFS2ZeRYrjyJkhayqf
   2BpCsuQY/sd3yqnU+qXuoQ21RzGlagoRVWrURmdpEpI9Wc4PkK/rn20ob
   jge4OFGbxZhNLKfXtoVBIePNwmH99uCf6QqkFMrKsvN0KMpVMpL2B7hP0
   YrCZYCd1VQNhWgzQadB/M2RoTh0bnfMxCx7gk9sgkbiJcDM4B5MqAsT56
   z785jAV6Ip7kHkOJdZMHYzV4OokwDaNWohCn4a+fsnxbHYVUI7dUAIRrH
   dLfVspPZ415fZmln487ZVnrIO2WxDZkZLu5rBzE1B0pHR67+LSt2JV3Yv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="463449321"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="463449321"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 10:38:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="756284023"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="756284023"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 10:38:26 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 10:38:25 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 10:38:25 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 10:38:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN8Lwnt+aO7IEV1wkFEUHcg35koBG8K65N57j0sotDHileFHGd1+zyMi5h0moHvpbaMgCNp9guaVYiqIswu57JtKdDww5eVN+gKV9zkNvkDfJOSg7/SpN7LWzjjO8djwuwX4fBz1nKIJ9KMep5GPXx+1BtFJFK/UUaA1rCbHm/sSPBk42Xn5/OgPtgEDYGGMnwkGjDPTDoyi7fhiudI9D1MejKHlboPldM+WgbV+sZsfjVEgn/i3DgRRHNZsgRBtv3n3+Nz0M77LVF5JUH7JO2to0jRhViNkpI2aeF4GaDptgnJz5LtZ1D1TvIT2LD94Rt1M6QIpkaiXVkht48mdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwRCRFPniKJ2PFROXYDUWQ+w2gAul8tTAItz4giwW0c=;
 b=L5GXD4th4jE0m0qcD6s/zwAptSltTEUWbW2Pvw/w5ymJX9njKA38CBfhuQ2fFaEG7Y/ITmlGPrHjh+7KjYzqTB0zi2752nPhNozjxT2gpn5xRU320jsRe/o8aX23CKHd9WiJsxfhPJeDjmgDiuD/qzTAMk/32FXovrJDpv8kkRTdk1IBr2NaiTTfVl4v+AXNsVLEWyawfLgn+GPVntyL0CeLWF8JnYu/n9zCz2UU6NU1t/G1xbvUfaBx2qPUgGJUWRWvlgXCPvmprEtEqgzMADOuhhIDVnZuVgu7qKWtYRo5WUVOW3+3yAcrHwaozywanMpq3k/at6vqYuyv+sCt9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7718.namprd11.prod.outlook.com (2603:10b6:510:2b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 18:38:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 18:38:17 +0000
Message-ID: <ac9916a9-d83e-46e4-8dee-ecc15775e94c@intel.com>
Date: Wed, 3 Jan 2024 10:38:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/resctrl: Remove hard-coded memory bandwidth
 event configuration
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
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <978719d8-8492-47f8-afdf-09e7c997b0b3@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bee1ad-9391-48cd-a763-08dc0c8b26c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7G57KGU/aCYq+lQ3Dg629OAV6MYeN88QYNqMN9OwqJxTqlYcf97gYsrVvnYdpvQhFILx/ws+fuESc5Zvb5JBq183aEbPyseShlOXr84MM7ZlX4e5PLMHz5GVtvZs/XkrfMYBUm4zI33Yss1RZwCpjf/5tzWd/YrVGpBDOE95A6afVIM+9QdBdB1u+A2NxPXeP0GLRgqYnTyPXScXwcbThLtcU+o1utPHSYMKs9SLE7GvuATKEFfUlmQzteH3+2l3OzCO8rMI1OZ67ozHPR5Upr/MnD22UX80o6vVCDeDVYQy+JuSv3jjyQH4aCCyc+M0kdKCn0crMEQ/EdDdqjmLv7mpP7i4oFTY7Ceuqxo6FtvEvKi6WtyRV+CUQWdv2HUgkyHTONxlc02mMWJ2dJQD4CLcPW5JNfNNMv4ZiZMYFnWgtHN06f0spaGz1E56qluArS4pWyZPpoe1zZ2ImzmLZ6TLKLP2jmSob9NdrXG8TnFgrdQb1MX2Smop49QwB3iuZMei+JfOzlw4w5f5zcUDPfrrpgw5WWdKsy9SPoHUSb1p0ptCybkBpM1+4eixC2koRD+kq3JtIIAR9GPdIuc8VWpI2WFihpOv9mzdQ8RqRG0F+u4t9juaBiZy2Ks5gQvVdqEhJ9UH7BcVUGWLUZ0uRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(36756003)(66946007)(6506007)(6486002)(53546011)(66556008)(6512007)(86362001)(31696002)(66476007)(38100700002)(41300700001)(2616005)(83380400001)(26005)(2906002)(4326008)(5660300002)(7416002)(478600001)(44832011)(6666004)(8936002)(82960400001)(8676002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3c2NGZWSDQyYXVrWWFrNU1xWFZLd2kxT3FqUGF0YzZpeWhNTnc1dmk2elN2?=
 =?utf-8?B?NkVwYW5uRFdCdDRTMmVHbVU4bE5RRmNYY01OV0hDOFhscU9jREpMWDVKbWFW?=
 =?utf-8?B?NTBoRGJTbkwwaXRXQ1lCK2IwS0t5S21VWG92UkU1TDNScm1VcUxraTJlbnpn?=
 =?utf-8?B?WC95NzBjU0pGNjI5azhJVi9NM21Od2svSTRwcElIcjhFcmp2T1FveTlhaXZ0?=
 =?utf-8?B?Yk9MbDFFOTRiSDRZaHN3c1RyT09Pd1E2SWd4MFJnWmEyc05XdnFITXJTTG5a?=
 =?utf-8?B?dmI3SjMvb24yZ2dqUFhlMldtZlhTSlBHM2tBRmU1M21xVWRqc1lXZnZqK0VY?=
 =?utf-8?B?N1kvUnY5cEJwT2tKdXpYYjJqNVFUanNNcEwycHk0dFNYRVB5T0tUckU0bzNj?=
 =?utf-8?B?cU10R3h5akErV054VHdqeUtTejMwRUc2VnZNU2ZXaTYrejJSTEhjZkNVMzlM?=
 =?utf-8?B?UTlmVGVOeVJKazB3WmZYNHR0UHpmaHpjRzVuZTdFOEJxZ2UzSmRadXlya3dq?=
 =?utf-8?B?Ukw4WlZnYS9mQUNYcDVUWXF4d2FxM1BYTUR1VGhLZHNHZzVlVjE1V0VrTFNx?=
 =?utf-8?B?eGxvYVc5YVgzN2FWdWZSUzBHQVpibFcxT3pOZ2NSZURiZnZYTHNIMXFOaFdE?=
 =?utf-8?B?ai8rY2ZvOUN2dHlwa0JvQmw0cldONTBXb2FvRVpaQkJLN3JYMWJDVjUyd005?=
 =?utf-8?B?VzhyVnovUDNWRzFLa1RvaXVsUkgveDVBblYxTWUwNTcwbGFGV3JQbThyV1Er?=
 =?utf-8?B?NURsdHJvRlZuNTlSNTQxMk9waXpxbk9xRUUzZ3VTSTZjaTFpQjhtVFJnR3ps?=
 =?utf-8?B?bklHMThqZ0NYd28zV2U5K2R1SXhIM05HNENLMUhUNEFKcnB4TXZxYlh6RkpM?=
 =?utf-8?B?TUFabTlLS09ZSEl2aUp6RW80V1VxcjFPNm80ekpOWDhsOWpnWXkydWdVTWgy?=
 =?utf-8?B?Z1V4VFc1cDlpZWpQRXJ2ditOQTkvdTg1dGQzVXp6bVM2cDl5OUdJZ3NJVnBi?=
 =?utf-8?B?Qis0bGxmMGZ2bkNCMlkyaFlvVlFNSG1xZDRQcCsyQ3piSFltK0RDRDRRcVcr?=
 =?utf-8?B?c2VoQXcvVTRpR2NlOGdKcEM3UzRtdUVUa3p2RTJYVityVForRGJvOVlLNUlH?=
 =?utf-8?B?WVJLMTZJQlRQZHhjclZGT3JNdTI3djVGSURnWXB2Sm0vSXZvRUFKdi9vYUNJ?=
 =?utf-8?B?cmtJRW1IRGpHWlBja1JaRWFtbUNMQ2N4VnEzL3pLaExzVkVSZUszZmptZ1Yx?=
 =?utf-8?B?eUJzeTBReFA1ZFZiSlkzMEtMMHh0Z2NUTXp0YkZkVDl0NlFtNXBQUnJ2WUdj?=
 =?utf-8?B?eVlxbnhwZW1SMEdlRVhhUGRaMGZHNi9VYk9aZzRBVzdYZ0JvVEVSYUZJbUhZ?=
 =?utf-8?B?cWlFejJZaVVvVVVtTlUrVjYxMDNsNGFBeCtOTnZWaDdxcHJFRjM2eENOVVdD?=
 =?utf-8?B?V3ErSWViWWtTcXFPZzIwSTVNK2kwWU5EUVZQdGFNSktuSlVoQm9vQnZsaU5x?=
 =?utf-8?B?dk9KZG1odlFDT3ZQNGFmWHE3N2JGcEFPWkM2ZEpnUzRXQkJUY3dDTlhSUnVl?=
 =?utf-8?B?WFVONms0aTAwS202a1JudktMRnAxV0dkTnlkbjdCRWlwYUtqTUt0b2dLOTFq?=
 =?utf-8?B?LzhTOXJ5RDB3WjZTQWw5ei9VSXdmalUxdTBhczdJd2NPTk16VEJzM3g4c0lT?=
 =?utf-8?B?MVZxa2l4ajVSbFJoUmwwUDFJdnFteVJhcXZXeXJiQkJyU2NjekV2T05qZkUr?=
 =?utf-8?B?MERaalo4M3hNdzNreTRLaE5XVUhKbnU3QVVHcWx2Y0E2aDdkeHp1Y2VvemRM?=
 =?utf-8?B?d1N0VExjdnVzUGZrZG1NNnBlRzBDbnNkR0twU1VxU29Na0VDbmw0dVJpYTBK?=
 =?utf-8?B?M1ZFbHU1MXlTWEIweFc4ODNEZTdiTWpMYnhuTkM4K2cxd1hVbm1VaWVyd3U2?=
 =?utf-8?B?MGNESlRua0t2QTRBL1pyY3g1YmNVVEo4SnN6aU9Ca0ZKS3JYQllGZW1waFcr?=
 =?utf-8?B?dFpWalpFTW9FTVVnZWUyUDlhbDZtVXlZYnlHVUsyOWxGZGFkc3dqTmoyWHVl?=
 =?utf-8?B?Wm80UmQzTGRidTNXT0ZkM1EwZFIzMFUvRkduaG5CK1FhdkorVUgrTFhJaHNp?=
 =?utf-8?B?TFE2UHhQZ01tZFo3VEhoL1ZSKy9EUGxTWmtkQlZSZEFFdXJmNTJjQjd1WVBq?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bee1ad-9391-48cd-a763-08dc0c8b26c2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 18:38:17.2406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RM3D0i2BsU3XNMCXnBG02bkwaAnQ8a8yQlkBdkDnz5zh9h9+WaqQosbjyU9Lx7Sh5RL6b0U+oBm3V4vNPfQN9CqY7M8KGrwGu6zAomuAAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7718
X-OriginatorOrg: intel.com

Hi Babu,

On 1/2/2024 12:00 PM, Moger, Babu wrote:
> On 12/14/23 19:24, Reinette Chatre wrote:
>> On 12/12/2023 10:02 AM, Babu Moger wrote:

>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index f136ac046851..30bf919edfda 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -813,6 +813,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>>  		return ret;
>>>  
>>>  	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
>>> +		u32 eax, ebx, ecx, edx;
>>> +
>>> +		/* Detect list of bandwidth sources that can be tracked */
>>> +		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
>>> +		hw_res->event_mask = ecx;
>>> +
>>
>> This has the same issue as I mentioned in V1. Note that this treats
>> reserved bits as valid values. I think this is a risky thing to do. For example
>> when this code is run on future hardware the currently reserved bits may have
>> values with different meaning than what this code uses it for.
> 
> Sure. Will use the mask MAX_EVT_CONFIG_BITS.
>               hw_res->mbm_cfg_mask = ecx &  MAX_EVT_CONFIG_BITS;
> 
>>
>>>  		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
>>>  			mbm_total_event.configurable = true;
>>>  			mbm_config_rftype_init("mbm_total_bytes_config");
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 69a1de92384a..8a1e9fdab974 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -1537,17 +1537,14 @@ static void mon_event_config_read(void *info)
>>>  {
>>>  	struct mon_config_info *mon_info = info;
>>>  	unsigned int index;
>>> -	u64 msrval;
>>> +	u32 h;
>>>  
>>>  	index = mon_event_config_index_get(mon_info->evtid);
>>>  	if (index == INVALID_CONFIG_INDEX) {
>>>  		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
>>>  		return;
>>>  	}
>>> -	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
>>> -
>>> -	/* Report only the valid event configuration bits */
>>> -	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
>>> +	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);
>>
>> I do not think this code needed to be changed. We do not want to treat
>> reserved bits as valid values. 
> 
> The logic is still the same. We don't have access to rdt_hw_resource in
> this function. So, I just moved the masking to mbm_config_show while printing.

Why do you need access to rdt_hw_resource? This comment is not about the bandwidth
events supported by the device but instead the bits used to represent these events.
This is the same issue as in rdt_get_mon_l3_config. The above change returns
reserved bits as valid while the original code ensured that only bits used for
field are returned (through the usage of MAX_EVT_CONFIG_BITS).

Reinette 

