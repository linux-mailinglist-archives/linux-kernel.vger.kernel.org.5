Return-Path: <linux-kernel+bounces-24990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F1C82C5B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1BA1C21229
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BFD15AD9;
	Fri, 12 Jan 2024 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZpW1Fn8"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863614F72;
	Fri, 12 Jan 2024 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705086185; x=1736622185;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JG02LSAWGgXJbaiCiat4WdO+NGn0CHtuxYaS3LMLOs8=;
  b=EZpW1Fn8YI0YaH+r33WPgQrLOKY1DjwYCwQCSBBRp0AfAwEQ0bBYXTcl
   p/luxOQTXdP8mLwY27zOoI23FnZ6x2cTrkxIQlUCLzdYLZc6597LGRUyl
   d/wha7gbkKFTg+nAFhkwkVeP16cHHbziEX0i7GNv/f1nlY5nVbHEOTkUU
   f+SAlCwe4qRREt5Q33PdojYRPIObweGXwNX31bMv11eduyU31IXJKZq/c
   WIco+LYSO5p85JlNkM/I4DY5bP50BxM7AxEkRgl+SXRcHCzQIzGKPHgmO
   YdwveelSrSDiQRR7k5PfcMXDAKcvBZ0PqzTKnI7p7tRz9/wHFQEoMnabm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="398936865"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="398936865"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 11:03:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="25086670"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 11:03:03 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 11:03:03 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 11:03:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 11:03:03 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 11:03:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOhYyZoFqYttrV5COqTAn8f3d1ScmLttIqaCKsyYRcZp53b6EyGwm6DOY2Y3eAik9oau7ecrJNFXoFURIEkd1GpwCHxwDB4bIzQjG5eKQUVtXNVR1CE+FaubMLU9bgY+xc/RyWiybPIkmFYYMOk9gmxvydCfkVM2yWvNRkpNxHjKNmaSkHB47zdwTrbUDCzuBJUTw6FqEoLuXPDHRlhRRgh/rbXFyfCujAKoxyQHGiSbe7/LJEd1TFbfRASMQ7npsPZXR73Hrg+o0MEWCe76Wes8zSXF53ay0+692cvKpPDpGITOx7BNY7I+h6p4/fkXtG6p8u7UBFwtPrN1Y3BGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eB4dswXgTlvC8SvcWICl+Fjo0Eqt5hOCY+4ntEywYYI=;
 b=KO7rhHssMO4STRkz/v66ra0EcGCH0sVCEBVLImZ1PZBMR9NlVL3HU0WycDoxI2Bn4ZJF6OP/nV0jxZ1PG0cS+FVWZrV0cum/G+ZkFjFPi0z4D7C3Q0RtreRQrak9UyCE3Borxwp8ZoHCXEl8SOcIRwse7yqMiKD4GiuQHqugjinxo5d0k85FP2TVQJsfNmPg96Kz12+p773MQP514bdkr1uvCp6vPdXSYdctklgSFa/AFX5edjXZH0PzC+Av7FVaeInZGx8dQ3lRp7l5IEaUCphZhcL3zZbJlo6QbmRvrjN3PKvX6LysW+6SUr8fmS5SznPMtawiKz4fWzuouWv+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7181.namprd11.prod.outlook.com (2603:10b6:8:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Fri, 12 Jan
 2024 19:03:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 19:03:00 +0000
Message-ID: <4c5bb5ac-1e84-4021-845d-cafea5a1fbde@intel.com>
Date: Fri, 12 Jan 2024 11:02:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] x86/resctrl: Read supported bandwidth sources
 using CPUID command
Content-Language: en-US
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ba1305bf2a29ce2667d01cf997718126a7ea607b.1705009003.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:303:6a::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc45abe-1196-442f-e2ba-08dc13a11845
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qB5kzEQtHePhcKuH/dq+8GT4it6rM/RakCCTTGY7KMNf7BbGm3M0220Fx+OlvLBtDpPb8VikrT5/JZzZkBJhvMO6JL21NkmMSynv0a7GbqQ92X9d8/Hk5u4B23I0oAsc+i79yL1VDmJF73ThsqRW1RmDJ19BjOaT9tMKQWT+6Ai16eX/BQqATQ//b18PrCO/5qzUwUQS2yC9ZlSvby6hjwEerswZvWOUg3XK/yEw7QJmnQWE1WbJzZS0Ab2CXWrjPLiRMTVwt/D6p9eBLXt4QR2j8+EB9aUm1C2Imw6dPedpOeIo94kZT1aNm6T08iiYmcPujhWn+A5cv730R4wRP5MI5lSejsmcv6ReZoExOSrOpa/mJWpFqAMtCrPHDtK25Q1fny2Jk5nm+tbpBMFBf5dNDj4Emi8SOrpqK1QCBwM47GFykQthQmEXYGNsrVRHN7Ih0I0NyIdpjYRO5JegGq/zwMBA/0BBNqu8xvBiS8io/MtlSYgQ6apNkW/NRw4OS+zQ/kbwyjpRRj5C59+22GNcOUI5kNgU6YK4NkGEt9aClYBR55ehOpRp8oEVwTJHFbAIRBHRJZ43MaYVLZ731daacYX8wLX6yj/TT+F+hqrdDPylPcyW0lSmBwba/RF+C122nJv406M1az1NZqhuxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(36756003)(83380400001)(6512007)(316002)(26005)(2616005)(53546011)(6486002)(38100700002)(8676002)(4326008)(8936002)(66556008)(7416002)(5660300002)(966005)(6666004)(6506007)(478600001)(66476007)(2906002)(44832011)(66946007)(41300700001)(82960400001)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0JuTFpNYjd3a1VGaGtNMllqeElJRWtzVkNaaHZqWG53WUJEUlRPRklQNGI2?=
 =?utf-8?B?dk9RdjBjTWVFY1NtZkVjcG1LbXZLTzBDM1JieUJyYUJZeUI2Si9GRThPYkp5?=
 =?utf-8?B?NWJSY2dQUjRCWWhoY0RZWnd2dGEzQld2bW42bmJGZ0RpRExEaU1jK0dWRGNH?=
 =?utf-8?B?bWE0OTgwYVpIMXFoRnRKVklWai9LOXg0UXVGcFI1OEZjbmxnazFmMDUwdHNi?=
 =?utf-8?B?ZTZ0NU5RWGo3YkdGOStXUXF2Wk1MYmZ6Y3dyQW1aeGt2S05EY0ExL2tpTmxW?=
 =?utf-8?B?N2tzYUdDNjhob21uQ2dNSnk4RnY0TERZeTdNbDFET2Y4WFlBMWxBSlVONXJu?=
 =?utf-8?B?bkIrOWRlZHpnbTNneVVkQXdlalFyY0NQVDBTeFJiV1ByL0V4dVRQWUprTmx2?=
 =?utf-8?B?WU1nd0x1c2VEcTZxNmozL2xpYmJEdGMxMngvbWlmR3VDODU5eTVXOEZENm5s?=
 =?utf-8?B?YU5QZjE1Zmh0eVVCL1NSTmZsOUp1U1QzZi8vak80RCtyWmpRMyswQ0lKdzNY?=
 =?utf-8?B?Z2lrYVNwQ1h0ZDZYdnFtTHJ0NTh3MjVOS3BZdzBCWXNzOTZTSDVRUEd6b1BR?=
 =?utf-8?B?S1dVb0M1ZmpiRDg2YW1QNTRtUUFDenp1K0N0VVAyZWxscGZDTkdlSnJtQUhN?=
 =?utf-8?B?ZzZDaHcwMXFwcEpqQXJhZUMycXdobWVqRXhHQnBLci9qbFJNK0xLSVFvc2pm?=
 =?utf-8?B?MUFFYStxUEJSM0tWTXVQSnZ3czQ2NWEwYWRtNlJUL1NETGJ6MkJUYmFFK2lu?=
 =?utf-8?B?S0FsVVI3MjdWWGhPSmdMZXZjbDdJc0N2OTBwM3hDTGJWU3ExKzNCL0MxWU8x?=
 =?utf-8?B?WWtDditkcnVYZFVIUlB3c3EzZEFxWlBrb2g2VE9FMVdMTGVvTFY5WUg5VEow?=
 =?utf-8?B?My9PeWJLWTJQNG52U2x2L0l6WmNmU3lyZk5LTURJK0R3a21xL1pQY0dZNi9N?=
 =?utf-8?B?RHdyTk8wNGxsVnE5OWphMFlpVEZ4c2ZCQ0l3R3BiQjRqTDljbENCbDdGNy8r?=
 =?utf-8?B?QkJDT3Y2MGhocjdVUkt5Sk1PbWNNWHRFWVJtUEsyYlBPOWcxUFhYdWhpM2xr?=
 =?utf-8?B?MENoa281alFUc2lSZzNINm9IcS9wa1FXanBMdFlaeElLZ0kwS3dDR01pUmdv?=
 =?utf-8?B?bFRCWUVRQnU1WTFKTTQ3YUkzKyt4bjFyS08vM2JTbkd1Uy9YN05QVFRITDRH?=
 =?utf-8?B?NWU5ZldpejY4ZEhsZjRzZkx3NTc2bjd1L3U3RWJZeUs0cDVKTXpKOGxja0ly?=
 =?utf-8?B?ZFA0MjUrL1FjU2RvUi9ESkVqSVE2eFFDVW8za2VnV2pnekZPQWFLQWM2Qm82?=
 =?utf-8?B?ZHRsVkdDWGRub1RaczBNdmJ3U2pQRFQ4NTZvODNwNHVxbVRFV080NTlCSVRI?=
 =?utf-8?B?SmdEN0J1OWZKNXBnNU1vWXMvR3I3cjlmQklSMWNZaHBJQUJWbitWTWQyVlFV?=
 =?utf-8?B?NGtyODc4QWxteVhRQTFKR1g4dTA1b2VwNWxJMmdTck9oeUJiNVQyb20yUEdm?=
 =?utf-8?B?eU55Rjk1YXUzdDdCMG5vS1VDd1pYT2ZwSXR4RVJBVUtTVWZzaFRsOFpsNlNJ?=
 =?utf-8?B?UjRTNjFhT0xidTNtK2UwOHhiWEk4bjJnRmtnQ0RZbkJDMTlmUFJwSkMzNE5N?=
 =?utf-8?B?V0MvRXNULzEwYitFbC9sL1daZDRnSXdpOE81MG9nT0owWHNHcVU4WnJKSEZt?=
 =?utf-8?B?aVoxTXRDT20rTnkzM2Fra3JzUU1mcGpUcnZnZEY0QnYwSk1xQWdDb1VUTW5m?=
 =?utf-8?B?RURuMlA1NFZvdzFrUm8yL2NpVFdWVkJmN3pla2Rac1RiSmFnbytyeUxDL1Mx?=
 =?utf-8?B?UVJKSktSUzF2cHBQVm40L2hpWXZkSGdWTW5lNWZlNllDb0hGY3AycHh5UlNC?=
 =?utf-8?B?SHF0TWw1U2t3cE9jNzZITFRaQUxQaXh2RkszTHRSaC9IMEcyS1BvdlFIQ1Rz?=
 =?utf-8?B?K29yeGdZMmRFdkdwcFpXTWVQOW8rbDNKTWFhUTdqaVYzZU13RjJWLzlMcWV0?=
 =?utf-8?B?M1EzVFQ3NlgrVW5VVTFwNFgyRitPUkRIVGxGeE1MK2E5ZERMVHFQOVQzdTAy?=
 =?utf-8?B?NWxzWkt5WVJBSjl6UXFVNGc1aTU4OTd4d3VkT1JXeXNHT3NBVjNmS2JqL1VL?=
 =?utf-8?B?M1JqLzNlS2tPZ3ptcEZGWmRSYUhwcGRYZEY2bmFQM1J5N042azZEbGlkbE55?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc45abe-1196-442f-e2ba-08dc13a11845
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 19:02:59.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEB5LsTknklMke20lnFozvPicV8wf04cMgGGDhncQoOVZ+AMnHd1aYCPqSMajjTtiancKIYEu77uUKgFJDbN/gdeElqIqDuE4j8rdFEckzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7181
X-OriginatorOrg: intel.com

Hi Babu,

On 1/11/2024 1:36 PM, Babu Moger wrote:

> @@ -1686,6 +1681,13 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
>  		return -EINVAL;
>  	}
>  
> +	/* mon_config cannot be more than the supported set of events */

copy&paste error? There is no mon_config in this function. 

(copy&paste difficulties reminds me of [1])

> +	if ((val & hw_res->mbm_cfg_mask) != val) {
> +		rdt_last_cmd_printf("Invalid event configuration: The maximum valid "
> +				    "bitmask is 0x%02x\n", hw_res->mbm_cfg_mask);

checkpatch.pl should have warned about this split of text across two lines.
Logging functions and single strings are allowed to exceed the max line length.
If you just merge the two lines then checkpatch.pl may still warn for resctrl strings
but that is because it does not recognize rdt_last_cmd_printf() as a logging function.

You can also just shorten the string so this patch passes the checkpatch.pl check.
For example,
"Invalid event configuration: maximum valid mask is 0x%02x\n"
or
"Invalid event configuration: maximum is 0x%02x\n"
or ?

Reinette

[1] https://lore.kernel.org/lkml/cc273d98-d73c-49bd-8799-b119966e226c@amd.com/

