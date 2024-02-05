Return-Path: <linux-kernel+bounces-54032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E85084A973
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA7A289328
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DE6482FC;
	Mon,  5 Feb 2024 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4Mnijv0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F747F71;
	Mon,  5 Feb 2024 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172723; cv=fail; b=dFep4TsAFatnHj+2MejydHt5sdCdO6d3wDUJR1PGi9yNazarHX9xV6ScDpmi1GmVcVgYUv436pASCZGrdS5XaaeyArkSW6gkVW8PA7M1tpYDc29eGBg89rug5xizC7R5JgLpJGsq6VbeTLHYC3vh5AN+WfkFsbY2fEUjVba1LfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172723; c=relaxed/simple;
	bh=Du/yP74SaSMGXlAHUjRx1MeBGBMFku52L4NHcCeF2/s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aArfuCuqStC6somYm2CRnHHlHfQ1RrOVVrdIHEATe/thPePSRsi7X9g4owEq7T0QBEkdeAERyFncVtCA37HWyJsvpTLHK9OIIK6HVycMCT6OqtkcG1joLDHznBYrjmDlXNyAVm65mNnBTttiCtHsBx3P0b5CsJCiNJx1whHoep4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4Mnijv0; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707172721; x=1738708721;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Du/yP74SaSMGXlAHUjRx1MeBGBMFku52L4NHcCeF2/s=;
  b=L4Mnijv0jtdwODWVD5kUek3lmdLUmHNPM8Y4r73lUblu6DNR2f8k6PwE
   9geuCOtsDjl0cYLLlbwfRNQQunZ3w4T36b/HDxnQn0htF5D0okU9aqHH/
   1bPFpjnGU4AedjSE3YOl9uLV7twv5anNMkAjy++Su/jigetYcIk4/Y6d4
   sSwjV3w4oIXoAX63jVsJx3Ee1O3jhGqhq0H+WYWxGnSPdj9xsySk1GIef
   XypNAlZpjXpfdUJ7r6JjgrcaLGq3VSmRzpkt402XClqN53eLP3d64L3ry
   COzVesLEmsmT/MyXXtqM+hPXKDJewNtVHLIjj75ydkWCg7OIPqjw6PhKQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11267375"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11267375"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 14:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="835403"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 14:38:38 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:38:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:38:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 14:38:37 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 14:38:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAKlX71WYuaxNLJ/731y0Lb4oYq8laqhSHXlk6D/S+txxD+182YYozAgINRqpOz4+YeMB+yWWVdge2etHON/TRrJ/5zPdFSsbAMc0yJ3YQzRkoTZHADYwdvrbDi8Ejoq0FdhUg4htu+GYFZkNweVgEFmCYDNuN/Nbsffp09h7LdaadNvojfUQ8gqYEduoyc6LKBRzXKq00ZUP4zgpqJJRAbo6zRVQAqzI6GRyloP2acgNfmq6PnEu3eDCnaO3Cio3J2DdThKKQZkjn/g3gulNCfRpgZn+60EoC6Ny4TYgNJfrnfVB38L2t2pkD2RR9L4MlZWzqR/lG0xMijzTYgx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNWDzS2Qm0xmhR6wuEjzjvV/SZUQPlSuf8iZlgJ9uks=;
 b=AMxoaI3f0lavh6y8vdiOLM9yRudIZ3NTs7CvSIBYrkhmJ5YfyvIlu8OFW8MCGA8zBZBRfaeX3nGquMC5ceQsbY0md9EDj65CrRk+GBlS0JZf5TPn8BgN3c6NS5QZPhgARjdT9InKifZ1NPSjdvS1vIuCOUx6FegvMvC/bp1aNvWlhWnp8O/m+JRsA0ZEl7G+SmceSbiWyy0UlpoE227iFaH+iiQImk1KuvILH4t1+MqWxFn9I1cfiQGvOsDRirXuakuhFIeAIomAuFMtIoKhPlJy3oVdWknmHBVlRuaF2h2uGVYLW3nbXxbf+K7WupldcrBCNePBrk2PLsgDy/nwhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 22:38:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 22:38:34 +0000
Message-ID: <4bb63a78-0d0d-47bc-ad65-558af8bc5519@intel.com>
Date: Mon, 5 Feb 2024 14:38:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, "james.morse@arm.com" <james.morse@arm.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <7c26af23-fa1e-4e01-8088-8fbd9be3d6f3@intel.com>
 <431d6ac4-53cb-2f73-3cda-22616df2f96a@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <431d6ac4-53cb-2f73-3cda-22616df2f96a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0352.namprd04.prod.outlook.com
 (2603:10b6:303:8a::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 41611d90-0d05-4000-9235-08dc269b2fb4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mp7Hxk2VaVcdUYUELjhH0jLm8IKz3bm7z2+wSawCMnx/2IC+GUpzZfGxjtt+Ogt3OCrnRE/RqEv+fHEhrxSMsFaaGbBPKAXgJzJWoReZKc3enScu1vVS3QJoUVLdZ067qDnSU+lB338E0245Xj+39MNbTNGZexvdsQUPlZ4UEtIsDF9Xg687hKx4KkSCt48rXaqF3f3nAQmkRx6KWGqjyiYZBoWF9VYI6xJu0lYMFVmsAHeEyV0O3FiXrco/fvb9cqrJiodFKFwdzdkwlxgp5ZkAfuh8PPolVaI01N9BFqEZ0inxcv/nuIXxruMg86DBvrM87TQNe3nhIrXBD9q1blj5H6kbesY8x1Kwegj9uTPKJCGPJyLAAe/uYFmc16aRcdagbcK/TpdtJTY25KhHOLoIToQrrlkkWP8zobSm0dH+MEnmKf8FUN8n0R8JxcFTQWAKn1O/sp3my2sM+dVRisVFQxD6xVZ8lvbakpagchNOXusFFSKGSOZ6RjCVc+QuOuk45owFbVeUmkooufe3Mpm/EYQEB1Jicc/JeDIQoeKqO5zvaVwDZbOsgnTF/NeCn0YYuWK3xcDPSiOKkPqqAKXOF8oUcjG+fpEc1T2ZNF5O9wb/XTdnmVdqskN2XFkckbOp5Sq+L4yHdpaH0ACPdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(2616005)(26005)(86362001)(31696002)(7416002)(7406005)(966005)(6486002)(30864003)(5660300002)(2906002)(478600001)(66476007)(66556008)(66946007)(44832011)(4326008)(8676002)(6512007)(8936002)(36756003)(6506007)(6666004)(53546011)(82960400001)(38100700002)(31686004)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alU3UFVMbi9lMnc2b050L3daK2ZEZzd6anVackg0dFFwYXNRY0NwTUQ2L2ZN?=
 =?utf-8?B?T3ZKL2FvUmZUb29OOUtVcTZmcVVLaFBzcFZqTFR4b2VEUHMvcVNGdXlScUV2?=
 =?utf-8?B?K0JkYlF3QkpCZm92bjdvSW5LTkEyVXhYTWZFMy9EQmJ1R0FJdHY1R3RGQTAw?=
 =?utf-8?B?bXp2OTBmS3RmQXJJZEtOdkpmelB2RHdvdzZoRVMxOWM3ZEtESnROMmVQckxN?=
 =?utf-8?B?VTJwWC9JQm9oSU80MTdZdU1kcC82ZHFiTDQwYlI3a1ZZdHdrSnN4WVB4R3Rz?=
 =?utf-8?B?MTA4ZzRoMFB3NVJlaE8zcVo0LzM2VWNNVnp1czYzRENWSWpuRnErYWFpODBw?=
 =?utf-8?B?TTZqZVcyL3JndkMvYzJreG0xdTk5WU8zOE41bSs1Si9xcHhJU3B0T3N0aHlW?=
 =?utf-8?B?QUdvMnRaVHByWU5kOFlYYm9qTkxuWnhBTzVxWDBOVHU1REVPWmlQTW1xaVN2?=
 =?utf-8?B?Mm1rcWJZU0duYzlCTnNTZk1WOERrbU5leUd6QWVrNWRNdy9pTVpMdmpVYWhz?=
 =?utf-8?B?S3FhMnQxcmVGSlFGTWlQblp1OE5NL0tzZGppSUZEYTh3VmxwbWdpT1ZPY0Fi?=
 =?utf-8?B?V2x3Q3U4cnZSSkNzR3ZQL256OEExL3U2V2dhWDBxeW44RUdOMjRwcEVPeUhl?=
 =?utf-8?B?RkdFRGlDeGd2ZmdxaHdNbXBaalFGTGZvUUFnbkNHR1ZpK0JjVGhhTmcyemlo?=
 =?utf-8?B?N1VJaTZNSWtzK3RMZk5RU3RCR1phVnlqYm4vc1EweVV3OC9UM0xmRURESzRL?=
 =?utf-8?B?THZYNlR1bDNwNXRaWU9ZZXd0TjJsMGVJcit6L3hqMFJEZXpGUEM3TDF2Ri9n?=
 =?utf-8?B?YlQva1cya0pmNFo5UlhDM256ZjlmT09LWFZpSjdsbnZsUFdxMFZKaTllb25G?=
 =?utf-8?B?ZHBhZkRILzI3V0ZGdzN6c0pWTFhaaWtBczhORDA2V2loSjliR2FSSFNoaXNh?=
 =?utf-8?B?V1ZscC9OOElmRHkwM3ZQMjg0dmdTVUxSRncrWXlLUjlRc2w5VmoyNlAvTjBH?=
 =?utf-8?B?ZnBhNHZ4SW5PdTE2WXZWaitmeWZGL2ZGLzg3SWZlWUx3cmdkNE1VU2IyMDl5?=
 =?utf-8?B?TWZhWEo0ZlEzTDVJQXBPSXZLTEFRQXRNcFE3a1Q2ck5jMTY0Z2ZuQU9saTU4?=
 =?utf-8?B?M244bWhSUzUvV01oQy83dVprL3FSQTFMU05ycWtxMkFieklHQ3RaUHFRVDRm?=
 =?utf-8?B?NXFreDFkbXFTWUZBVFJ6WCt0b3FpNGlmT0ZlZUFMRzJxeThJN2JNam9yU0Fv?=
 =?utf-8?B?SkkrZ3pkaldDMklwWVIrbSs0VEFzSitmR3NRaXFMNXZ6RW1tbXcwZ2xjOFFz?=
 =?utf-8?B?TnJPUWR2YTRYa3NIN0lKRFVRL09LbkZ5RGp4a0MvcEtVTTdxcnR0UjUzRlZq?=
 =?utf-8?B?emdHcDR1SzJRWnRlMVlMVU12QTJqWjAxQXVKTngxaFdMWnQya1NpYlYxQjQx?=
 =?utf-8?B?bGY5MEovdEd1V0p4eVFUMzhsSDBXVkRBeWx5eU43VVAxV3dwbUFwWnRkWEMv?=
 =?utf-8?B?ekQ4ODREcUd1Y09VT05UbVpSK0M2ZHZRaitYMXdlRG4zemFhM0dnSWZnSndL?=
 =?utf-8?B?UU5oVU5kbTRQcjFwa2JYRW9GVjBiNDlqMUpxMTRHUEUxL2VYVEsvbjAzNnJz?=
 =?utf-8?B?WU96YjNZaDd1RGRWekIwM0lEbHgxL1Z6MU43QWtDZWVQMjVUdnI5cE5uZW1h?=
 =?utf-8?B?KzJTLzJFTm9uU3pGUWdaZFJCL3FUOVdVN2JOQmdUNVg5Wnd5Q0s1WGlod1Zp?=
 =?utf-8?B?TTBWZ0ZWS2xoYzBJaTdyb1ZVL01zT0ZVemxkaVlIRUpBcmtzTitSd2RLZUd6?=
 =?utf-8?B?ZENNQmhNUThYOHJhNS9YdVFHTlBBUlFIbktBOEx1MXYxUjBhdnUxUEo4UnRu?=
 =?utf-8?B?MGVVMXM4a1lqb3lwN2Z4dlRJalNQRFpMQS9zdklQdzdhUHNOUTAwbWdiL2JN?=
 =?utf-8?B?Y0gzc2d6TFJGbHQ3OCswMkl3K3JOdnJRNTZNQ0NMU002N2piUHI2SlMvdkVO?=
 =?utf-8?B?cG9tSjRlb3BZSEJ5Wk1OR0I5clhja0RXR25xR1QvYzBWUXozMkcyN2ZZZWZB?=
 =?utf-8?B?MEQ5T2JTR1JTNFlWRElJK3g2cXcrc2lQRTJId25Rd0FTRnF2dXI0OEhaNFRB?=
 =?utf-8?B?TXYwWjJjam1TR0ZyT1lmTDFWUTFIdytUZ0g2ZmxQS0tnMjNkNDdGcFZkNlBY?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41611d90-0d05-4000-9235-08dc269b2fb4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 22:38:34.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlrLybRkMyzpUUTX7UCVLoWwZAKtBFTvNKc5ZxGNsVYwoTblZOcpZOeFqBdLQA7ucJeXPCa3Yf8IJ9QrNN+Kt+JKtfHmMtSOfZlJMyAAc28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8189
X-OriginatorOrg: intel.com

Hi Babu,

On 2/2/2024 1:57 PM, Moger, Babu wrote:
> On 2/1/2024 10:09 PM, Reinette Chatre wrote:
>> On 1/19/2024 10:22 AM, Babu Moger wrote:
>>> These series adds the support for Assignable Bandwidth Monitoring Counters
>> Not a good start ([1]).
> 
> Yea. My bad.
> 
>>
>>> (ABMC). It is also called QoS RMID Pinning feature
>>>
>>> The feature details are documented in the  APM listed below [1].
>>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>> Monitoring (ABMC). The documentation is available at
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>>
>>> The patches are based on top of commit
>>> 1ac6b49423e83af2abed9be7fbdf2e491686c66b (tip/master)
>>>
>>> # Introduction
>>>
>>> AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
>>> feature only guarantees that RMIDs currently assigned to a processor will
>>> be tracked by hardware. The counters of any other RMIDs which are no longer
>>> being tracked will be reset to zero. The MBM event counters return
>>> "Unavailable" for the RMIDs that are not active.
>>>      Users can create 256 or more monitor groups. But there can be only limited
>>> number of groups that can be give guaranteed monitoring numbers.  With ever
>> "can be given"?
> 
> "can give guaranteed monitoring numbers."
> 
> I feel this looks better.

Sounds good. Thank you.

> 
>>
>>> changing configurations there is no way to definitely know which of these
>>> groups will be active for certain point of time. Users do not have the
>>> option to monitor a group or set of groups for certain period of time
>>> without worrying about RMID being reset in between.
>>>      The ABMC feature provides an option to the user to assign an RMID to the
>>> hardware counter and monitor the bandwidth for a longer duration.
>>> The assigned RMID will be active until the user unassigns it manually.
>>> There is no need to worry about counters being reset during this period.
>>> Additionally, the user can specify a bitmask identifying the specific
>>> bandwidth types from the given source to track with the counter.
>>>
>>> Without ABMC enabled, monitoring will work in current mode without
>>> assignment option.
>>>
>>> # Linux Implementation
>>>
>>> Linux resctrl subsystem provides the interface to count maximum of two
>>> memory bandwidth events per group, from a combination of available total
>>> and local events. Keeping the current interface, users can assign a maximum
>>> of 2 ABMC counters per group. User will also have the option to assign only
>>> one counter to the group. If the system runs out of assignable ABMC
>>> counters, kernel will display an error. Users need to unassign an already
>>> assigned counter to make space for new assignments.
>>>
>>>
>>> # Examples
>>>
>>> a. Check if ABMC support is available
>>>     #mount -t resctrl resctrl /sys/fs/resctrl/
>>>
>>>     #cat /sys/fs/resctrl/info/L3_MON/mon_features
>>>     llc_occupancy
>>>     mbm_total_bytes
>>>     mbm_total_bytes_config
>>>     mbm_local_bytes
>>>     mbm_local_bytes_config
>>>     mbm_assign_capable ←  Linux kernel detected ABMC feature
>>>
>>> b. Check if ABMC is enabled. By default, ABMC feature is disabled.
>>>     Monitoring works in legacy monitor mode when ABMC is not enabled.
>>>
>>>     #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>     0
>>>
>> With the introduction of "mbm_assign_enable" the entry in mon_features seems
>> to provide duplicate information.
> 
> ok. We can remove the text in mon_features and keep mbm_assign_enable. We need this to enable and disable the feature.

This could be improved beyond a binary "enable"/"disable" interface to user space.
For example, the hardware can discover which "mbm counter assign" related feature
(I'm counting the "soft RMID" here as one of the "mbm counter assign" related
features) is supported on the platform and it can be presented to the user like:

# cat /sys/fs/resctrl/info/L3_MON/mbm_assign
[feature_1] feature_2 feature_3

The output indicates which features are supported by the platform and the brackets indicate
which feature is enabled. 


>>> c. There will be new file "monitor_state" for each monitor group when ABMC
>>>     feature is supported. However, monitor_state is not available if ABMC is
>>>     disabled.
>>>     
>>>     #cat /sys/fs/resctrl/monitor_state
>>>     Unsupported
>> This sounds potentially confusing since users will still be able to monitor
>> the groups ...
> How about "Assignment-Unsupported"?

(please see later)

>>
>>>     
>>> d. Read the event mbm_total_bytes and mbm_local_bytes. Without ABMC
>>>     enabled, monitoring will work in current mode without assignment option.
>>>     
>>>     # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>>     779247936
>>>     # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>     765207488
>>>     
>>> e. Enable ABMC mode.
>>>
>>>     #echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>          #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>          1
>>>
>>> f. Read the monitor states. By default, both total and local MBM
>>>     events are in "unassign" state.
>>>     
>>>     #cat /sys/fs/resctrl/monitor_state
>>>     total=unassign;local=unassign
>> This interface does not seem to take into account that hardware
>> can support assignment per domain. I understand that this is
>> not something you want to implement at this time but the user interface
>> has to accommodate such an enhancement. This was already mentioned, and
>> you did acknowledge the point [3] to this new version that does not
>> reflect this is unexpected.
> 
> Yea. Domain level assignment is not supported at this point. Do you want me to explicitly mention here?
> 
> Please elaborate what you meant here.

You have made it clear on several occasions that you do not intend to support
domain level assignment. That may be ok but the interface you create should
not prevent future support of domain level assignment.

If my point is not clear, could you please share how this interface is able to
support domain level assignment in the future?

I am starting to think that we need a file similar to the schemata file
for group and domain level monitor configurations. 

>> My previous suggestions do seem to still stand and and I also am not able to
>> see how Peter's requests [2] were considered. This same interface needs to
>> accommodate usages apart from ABMC. For example, how to use this interface
>> to address the same counter issue on AMD hardware without ABMC, and MPAM
>> (pending James's feedback).
> 
> Yea. Agree. Peter's comments are not addressed. I am not all clear
> about details of Peters and James requirement.

Peter listed his requirements in [1]. That email thread is a worthwhile read
for the use cases.

I believe that James is aware of this work and do hope to hear from him. 

> 
> With respect to ABMC here are my requirements.
> 
> a.  Assignment needs to be done at group level.
> 
> b. User should be able to assign each event individually. Multiple events assignment(in one command) should be supported.
> 
> c. I have no plans to implement domain level assignment. It is done at system level.
> 
> d. We need only couple of states.  Assigned and unassigned.
> 
> e. monitor_state is name of file for user interface. We can change that based on comments.
> 
> Peter, James,
> 
> Please comment on what you want achieve in "assignment" based on the features you are working on.
> 
> Do you want to add new states?
> 
>>
>> I understand that until we hear from Arm we do not know all the requirements
>> that this interface needs to support, but I do expect this interface to
>> at least consider requirements and usage scenarios that are already known.
> 
> Sure. Will try that in the next version. Lets continue the discussion.
> 
> 
>>> g. Read the event mbm_total_bytes and mbm_local_bytes. In ABMC mode,
>>>     the MBA events are not available until the user assigns the events
>>>     explicitly.
>>>     
>>>     #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>>     Unsupported
>>>     
>>>     #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>     Unsupported
>>>
>> This needs some more thought to accommodate Peter's scenario where the counter
>> can be expected to return the final count after the counter is disabled.
> 
> I am not sure how to achieve this with ABMC. This may be applicable
> to soft rmid only. In case of "soft rmid", previous readings are
> saved in the soft rmid state.

Right. Please consider this work in two parts, first, there is a generic
interface that aims to support ABMC, "soft RMID", and MPAM. Second, there
is using this interface to support ABMC.

>>> h. The event llc_occupancy is not affected by ABMC mode. Users can still
>>>     read the llc_occupancy.
>>>
>>>     #cat /sys/fs/resctrl/mon_data/mon_L3_00/llc_occupancy
>>>     557056
>>>
>>> i. Now assign the total event and read the monitor_state.
>>>     
>>>     #echo total=assign > /sys/fs/resctrl/monitor_state
>>>     #cat /sys/fs/resctrl/monitor_state
>>>     total=assign;local=unassign
>>>     
>> I do not see the "global assign/unassign" scenario addressed.
> 
> I am not all clear on meaning of "global assign/unassign".  Does it
> mean looping thru all the groups and assign the RMIDs?

Please see [1].

 
> It may not work in many cases. In case of ABMC, we have only limited
> number of hw counters. It will fail after hardware runs out of
> counters. It is better done selectively based on which group user is
> interested in.

Right. This is one more item where the generic interface needs to
accommodate different hardware implementations. Perhaps this could
be one of the "features" exposed by (global) mbm_assign that the
user can "enable"/"disable" on demand?

> But it can be done later if we find a use case for that.

There already exists a use case as presented by Peter in support
of AMD hardware without ABMC, no? 

>> This version seems to ignore (without discussion) a lot of earlier
>> feedback.
> 
> Please feel free comment. There are various threads of discussion. I may have missed.
> 


Reinette

[1] https://lore.kernel.org/lkml/CALPaoCiRD6j_Rp7ffew+PtGTF4rWDORwbuRQqH2i-cY5SvWQBg@mail.gmail.com/

