Return-Path: <linux-kernel+bounces-25044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515DE82C69A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717771C223D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7214168D1;
	Fri, 12 Jan 2024 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L17J3Y6b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF0171A0;
	Fri, 12 Jan 2024 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705094658; x=1736630658;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jBBoEGNN2e8TaMjTH6EV7hC2eZ2s+HwyB84ds+PbyKc=;
  b=L17J3Y6bcD5lqgwqsYb25hO/jfLWDtVieZjq9JtBwb/gBZxQO4b4Wpxz
   jar0c1WM+mgu06y/heRTRcKNmosmJEixMT2pe0fjZ0XCCHJvpJnw2uHAP
   ts+P1ygF5pwHeEgPCC/RuJ8qbKZRtW1CdfiDG/r+NhDnv9AxMVtcnKcoZ
   puqQRyrt+X+sOOAkVjg6GrYffAhpN6mXhDotBk/1igYLm8RvKoPPsAZZI
   9woCC+Te5kMlrRQu8oH8jm5VDMTOR1gFhtws03zMJffWnqaAI/btumwmH
   QI9y8j82ntCvhf3nrdOKETExUaxqV5NIANKvi7tJwNGiFC/dPldwBfkFO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="6016954"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="6016954"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 13:24:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="906424900"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="906424900"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 13:24:16 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 13:24:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 13:24:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 13:24:15 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 13:24:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXvycyQt2OAJwtLOxa/O+FUkFrXMceMuNcsJFucsXCyVrJqeBcN2ynQ3dQSimw9HqTx14c6SEgiqIxHKJZCPIGf2pyAsQqPdOPRamBh3N1WV0V97w6YhNoPcrf4P3KLlw3oD9ZsiRIlrjcaPrIbPzw3ibfHU4kp47NXG3n42Mfj8kN+9x2uWSGn+0Vap23nRtZ9D+faW5Kuym+VCvri4PKK3vL9i1xUrmFavNhHc6fi0JqJZ+wN20G8fH5wBGnre6fzvEcVHS8NifoVI1+NEKNxuGOhJ2lDAwpHp9x++k3Bwh09RjlqC/iv4ErBXraB8q8/mXvliaN/whGTn4xopvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckCBOJlOlkSOXsPKySYwun78AF2RdlHDHvO/S0QLPlw=;
 b=QTx/dfiLHrO80BBtFZs++lTT4W+PDlIQcgm6f0mrAWvQvEJ/3Dc7wR7HV0/0qtyIi55+jAAppao2BJU4ReBXIrxaS1/UN9/CIVgC51ffueI3BnwikQ/GYSjCZ8Gbe5JlY4SDBUWkqoUMajF56W0ZtyKND6MsjB1JkQziEUqSDsq1sdOGTxFvMbsiyQ+uyWXzXQaljvvc7MirwrV48/TSMuZ3NTNpdLNW9fNNVLP9ChF3c46iw6tWZqNyIhUtiERM+FMbHN9GboOAkc+Z7M0ojhvaruU6yEsq8jfiF/37w+r1DHm2/yBjlYfBU7b1fhRiIDrqW0jITdeQuoJbjwPuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 21:24:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 21:24:10 +0000
Message-ID: <920e6d40-78d8-4e98-8f85-6d015681887f@intel.com>
Date: Fri, 12 Jan 2024 13:24:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] x86/resctrl: Read supported bandwidth sources
 using CPUID command
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
 <ba1305bf2a29ce2667d01cf997718126a7ea607b.1705009003.git.babu.moger@amd.com>
 <4c5bb5ac-1e84-4021-845d-cafea5a1fbde@intel.com>
 <3bd2a660-82fd-51fe-f7cd-492908d90ca7@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3bd2a660-82fd-51fe-f7cd-492908d90ca7@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:303:6b::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf7920d-1c93-4364-8ff3-08dc13b4d162
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnoHgTDdUhqwQCqAtLvUArg3uuGZqBb59IrQ66m/oXOCbGg8EWV7z0HOIgcS/ZxPoNCOk4vqAfnoPkqDoKv0RPyq7mapBte+4thSdrrMH0es+z6XhVmaRrYcdEKMGRjsokl0ZMzU7PFNO4Be8CE9Pc4drD4a2jV1TUzAhu260IDOW7zsS592woWZj6d2mdnBQCKIFxdk+/6LLyRjJn+xrx4W+J99hOCIA7tks2q/IKYE2KR0mqW+vbCR3Gl6Gy7OT5r7Ksd/6GtP2so4w1HmHd1NlzHuuqzMXZtSz/KrMQBTmJpo+a7m9SxO2dYkf2Yeh26ST/zAQ3HO0GYXAhHcyDQpVlWO99QaYQfU4IqxBht50BlpBek2jYKWHAV431vZWOxfwUhMQSaaz6pxjSgiUx1ya5qyFQHP1vuDAe1mFE/T95IRvvXCYyV9lorpKoXYOZlrZD/G/uUbCKzZAuMstTST5fI78HqOux8IcjUCDl0Gq+B6/PZ7SRUJZ24eDvyt2zjLpxPh+BDByMa3kKU/P1+0Byt5C9/FWeGvc8b8PV+Ws/MmfLl/ZiSNkksBQk6zU+JBLcweCikgznb9lSKzdghNKhITIaxcIDC/PFaBvWBgUf6pBhTH8MRIZGq9RkyeX1gb7r5YLfpxNg3IB7EpzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(53546011)(2616005)(26005)(6506007)(6666004)(478600001)(6486002)(6512007)(38100700002)(5660300002)(82960400001)(31696002)(86362001)(36756003)(2906002)(41300700001)(7416002)(44832011)(316002)(83380400001)(66476007)(66946007)(8676002)(8936002)(66556008)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1VrQ1pJN09IZGRSTlVycTc0Zy8yZmRmQ0o1N0NNa0tUaXduOWhTNHNRUVRk?=
 =?utf-8?B?SkhkZ2RRbTVBNTZ0THBvNDEvTWJsZHlGMFQvUFBzbklPUGNLckFreHZPSTY4?=
 =?utf-8?B?QjhLTCtzODVLN0FCb0ZURjMwSU03Vkk4MmFCNG1ZMk5JWFBDcmE5M2NjdVBP?=
 =?utf-8?B?STg2UXlqc2I4QTVsMXFCUklBWE04a21jamZzWW9YYkhsYVU4SUlYN2M2bldI?=
 =?utf-8?B?VDBXRzBBamlodm9wQWRIZ0g3Vi9DTTQ0SU9CMHdqSFdLT0hUK3F6NkJWMCt0?=
 =?utf-8?B?MHkwTmgzMGJCaXFNdis4dDNEUmVwYndXendnNlFiclFUUmlsNFM0bm5VaHMz?=
 =?utf-8?B?NkpvYmhmRjNhNWIwTnF4eDlkUFJHWGpHTUlNOUw5WHlHQmtkeUlXbU9vSGFO?=
 =?utf-8?B?SWUwWTd6SjRiYmF6MStqaFZuZjd6MGF6djhjT0ovcTgvT0ZuS2R6bFNsNGFO?=
 =?utf-8?B?WXhCRWhITlRaazVJdDk2a2toS2ZHdnJnUzd0ZnphVmJvSnhHTWN1QzNNalpj?=
 =?utf-8?B?by9QRWFwM09wazJuaFVpNkczYXVwcGY0TUFGM0VOV3ZacklKNE1yVEptb1Ju?=
 =?utf-8?B?M2p5cnp4a2hxOUpGNU1QOVV0VVo5OVVid29qNUc0b2dGWDlDVVlZTTNRcVVT?=
 =?utf-8?B?d2t6enNKUHBhNXZqZGo2N01RTC93WWM1NDJmeUZldjlTZFc2NFg2TWpqK1di?=
 =?utf-8?B?TEwrUkNTajJoVW1wbm9sV0VwS0Z5WHlGM1Y5dmp6aGczZWFQRW1va2kvVE9r?=
 =?utf-8?B?OE85cERNbHNJZ05LVy9mb2UrN2w4d3V1VkZLazFYZ3BuQVZncS9wZ3ZnbEJu?=
 =?utf-8?B?ekFySHRxdHU5NU5IZkNTalZuS2dOKzhQRSttTENVN1M5NnN4bjZoUk1BcUdq?=
 =?utf-8?B?TFE5NnRXMDB6TnIrSURKSVBDS0FXZUZPZXFhc3R4M2dPNnBtMm5XZDNGL01E?=
 =?utf-8?B?MENGdlRWYWthZ3dCeW5iZkQ0VG14N244Z29GSTl5ekVEU1dxQ3VCZlVHdjdX?=
 =?utf-8?B?NWU0aStiNHhFdzhlTUMvT2lVc3Z3eEFYdmErLzhIRGJaV2ZPWllTYmxXeURh?=
 =?utf-8?B?blZhdU80TGJEMlBNbzN4WFJ1NE5nM1JPVzZES0VtcjlxVXcwQ0JxWG52L0ZV?=
 =?utf-8?B?YzU4UlVtZDJCN1BGRFZpUS9semNsQU1icFNuQ3lYRUhJTVhIbWtvbDNZRzJi?=
 =?utf-8?B?NFRJSEV4L1Rmd3lxZTVuOEk0SUc0eUo2emJvZGJLd1J3WkdHYzNsYjFoRWJz?=
 =?utf-8?B?R2M5TFlYeHhMeUllSHAyaENXNXR0WlRFbm9qRTh4NlNBR2N4c1FtSDZyb1N3?=
 =?utf-8?B?UFNYam1DTW1MVlpNU2lVS0g0MXRtbmZsVVJkU0IzeFRPRnZkQmM4UVoybkVs?=
 =?utf-8?B?MWx6MmtoVjFPdFR2dGtHT3RrRGE2eGJ6bjlFWnRUVnZhYlVSd2tQcmlYa1FC?=
 =?utf-8?B?ZnVrdjhFQmRiVUx2MkhWYVU5TVFBY1RsZTd6a29VbjhIY214dXRBU3RTYjNP?=
 =?utf-8?B?bmtvQXR0cW42NHdmMytlV1VoQ2xQV3l2K3Q4Ry8rRDVucVBXdS9pTjd3ZUdr?=
 =?utf-8?B?QVJuV1hDTDB3RERFTXVpTHFoNG1lM1NybVA1ek90dlJjNVU0b0ppTEcxeFFp?=
 =?utf-8?B?MllRZk84bmtsZUg4ekYxb2psU2hITnZzYWZQVnYzR0J3bm02UEJBcEpWeDAy?=
 =?utf-8?B?MVVHajJHZHhTUktoYW9hY1FPdzRISlpJVnNlSlp0eVZwaVlORFBOOThDaU1H?=
 =?utf-8?B?LzMyekVGaXJFQUN0TC9wcG1kSk82ZEtNUy9lTzF4SkpvTHJDbHJuQ0NxTnFx?=
 =?utf-8?B?YTRKS1RHdzAxZzlHZkdZSnZIRHlyN0w4MVVGSTdrd2ZGZG5CLzA0WlQrb1c3?=
 =?utf-8?B?VTI2QktGVXlQaGFTVUZ3TkFxYld4MEU5MG9BazJiMU9oV1VxYVdCNUlRUmVo?=
 =?utf-8?B?ZCtvZWRpTmwzWlhheCtEbkd3eXl3UktHN0pWOHdzaGRHWFlEY1d0ZnR6QTRa?=
 =?utf-8?B?dlFCS0FsbmdYY0dKQ3VzdUE3eEZZMUJya01MSlhnOTBVaktzMUxxL1I2Vy9W?=
 =?utf-8?B?ZHEzRnJuWFVaZmsrMHdjZEhhM1JZMmxiK1JnTU5WUHJYaEVINUtWQzdDSSsx?=
 =?utf-8?B?TkJObzRZcmpmUDk0ZHdhT1UxUWZKZy9aZ0RhVElzUGJqYS8yS1BUdTFpQjZX?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf7920d-1c93-4364-8ff3-08dc13b4d162
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 21:24:10.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Iv/nQvTuCrKk3PhB03STnvLfnO9/Vu7/ILocjUDT98DmNJ5ONLQL8Uevcd3TGvKEBGlAnF/rNK2SrY9fsJH59zZ+yV1dhqSoyv+adjJH9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563
X-OriginatorOrg: intel.com

Hi Babu,

On 1/12/2024 12:38 PM, Moger, Babu wrote:
> Hi  Reinette,
> 
> On 1/12/2024 1:02 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 1/11/2024 1:36 PM, Babu Moger wrote:
>>
>>> @@ -1686,6 +1681,13 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
>>>           return -EINVAL;
>>>       }
>>>   +    /* mon_config cannot be more than the supported set of events */
>> copy&paste error? There is no mon_config in this function.
> Yea. it should be mbm_cfg_mask.  Will fix it.

I do not think it is correct to replace mon_config with mbm_cfg_mask. Is this comment
not referring to the user provided value (that is checked against mbm_cfg_mask)? So
perhaps something like:

	 /* Check value from user against supported events. */
	or
	 /* Value from user cannot be more than the supported set of events. */

Please feel free to improve.

>>
>> (copy&paste difficulties reminds me of [1])
>>
>>> +    if ((val & hw_res->mbm_cfg_mask) != val) {
>>> +        rdt_last_cmd_printf("Invalid event configuration: The maximum valid "
>>> +                    "bitmask is 0x%02x\n", hw_res->mbm_cfg_mask);
>> checkpatch.pl should have warned about this split of text across two lines.
>> Logging functions and single strings are allowed to exceed the max line length.
>> If you just merge the two lines then checkpatch.pl may still warn for resctrl strings
>> but that is because it does not recognize rdt_last_cmd_printf() as a logging function.
>>
>> You can also just shorten the string so this patch passes the checkpatch.pl check.
>> For example,
>> "Invalid event configuration: maximum valid mask is 0x%02x\n"
>> or
>> "Invalid event configuration: maximum is 0x%02x\n"
>> or ?
> 
> Yes. Checkpatch reported error when I split the text.
> 
> How about this?. Checkpatch is happy.
> 
> rdt_last_cmd_printf("Invalid event configuration: max valid mask is 0x%02x\n",
> +                                   hw_res->mbm_cfg_mask);
> 

Looks good.

Reinette

