Return-Path: <linux-kernel+bounces-18363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C4825C13
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93541C232E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80043225D3;
	Fri,  5 Jan 2024 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIN3TZp/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350A21A15;
	Fri,  5 Jan 2024 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704489508; x=1736025508;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=baaVYsdKTXo8IfOqFwCyW/vYs63jXVZSwMjykdN/OOk=;
  b=DIN3TZp/x79oRCO2Vc7miO81ahVa1LOagQ2GDn/O5chyuc3o5ItFNUnM
   xqS+4Y/QgXdiW0xai8Cs0wSrexj2p9TRoQBYko6fYKVfuvsV63HC6MyxV
   LbEtUXQsDqz5cCzmxbfyuQFbESRILp2ga+x80GqzWRAapxdCoKkMVLXon
   huvTU6rIU6Exx+aOIsTI75o012BBlCt0/YIUZkpYCn5oC8k8nHW5MFyNV
   QA+R96Jj2n2G8xSiuUX8c+xbJ0s5WE/60PNJ+CtE6IHIWixjlxtuzknhv
   dK1Yo0e48kbId8LjFk2fSeKrgEas/4fDDYddj4JQMO/19x0JWRbCyafrA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="4349421"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="4349421"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 13:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="809656925"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="809656925"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 13:18:25 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 13:18:24 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 13:18:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 13:18:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fA31jPhYkmTlPcNU5ti144m+By0wol1UfoF2x76JDEvP8r+ZHYVT1f1HX1I2u5NAZfm/m7bfil8fIR+hLdxlBiihLjzd4S0nCQcMWHnMhUd5MX9Kg6ZWENoNBKifD8ZGPGuisKfBqhZ9GE7jIbctGWVDToWFh2AAkeJcmrsObtShgG3LRsa6yv1s0pXdIwZFrtWc0Dy7SSmaaDf0sPA4oK0WMC5mjpWAQ67TO3wJvF19czFISSkCisF2daGJcVGgPLdShCyLru4a3WCPmt5vk3W7zvgjZWcsrQp8UgC6MKi8ik3+CdfwcjCdFd9I3ELWR8fMT/SxpGOJKLDGaFLbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReJwi8UxyW2VqOx2sCYldZxmYukEzuW+1P1IDBS/XbU=;
 b=ni0pGmNQq1M2yBsK5i90CCBxe/enC3W59wFKZOSrFzcxHmUOxoWwDYe5tw7CsqBTfTE+e7cO48gQZjcTb1Ug64dVl6uP5rv1DixubwO2zXXFU3ajUBWCnoN+icqipssee7oQliWOAsJMS7lVqXuZChVJdo9sdnttm61TWaVdDGQvd+yHEQfqVCM51DZJiQpJZH/9z3Fh+D3jhzOnJXemt/cWq4g9w+0ifhvE3UpGG5NVctTCiDoBGJSTlOBuGseGdIGckSHZC+Hr8d9doBJ+aW7mpHVU+qhwYyfwDGeaMQhoOTkfNG6QELOnfnlbQaTAhXVPKsmv7pDUSPALYROFrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5513.namprd11.prod.outlook.com (2603:10b6:408:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 21:18:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 21:18:21 +0000
Message-ID: <e25ef699-7b6c-4731-b62a-39a90dd888e7@intel.com>
Date: Fri, 5 Jan 2024 13:18:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] x86/resctrl: Remove hard-coded memory bandwidth
 event configuration
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
 <20240104212130.209490-2-babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240104212130.209490-2-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:303:b6::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: a943da1e-9bc7-49ab-6d28-08dc0e33d856
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAxd/6YAaHmMb+nndLoMNCJ1VwzB+yugY5ZoFCiFcXhrGcrvhDhPAxEhiRNAWU+XDSA6mAA7H7h/lqY1/z8ka73XMCiQgRh4aZ8AZqUs3Zs4aB/QWqMXKCSqMiyiCKTjchARvFt1qzGhMIBClpQoST6ljjOu0uZ8lrEYWxNV8Bgs18c8AUWTfRqCDgVt9lL4DBZ6H7nDH8Dnc3CQfbmM0ReejkYDqv90N415Tt+94fSI98AbkgqpCfwJKR0og8yQOaSbCPXm2c62s8AesJ/qGzbvsR61TDzsbQ6Fb/yL8vS652kajPfOyJ5lFFHtOk8PhD86iMQS1JMHaajewzOfA+yOK0OBWFnd0BGm3SDIYwx/l9ATxLfBn2+Cy61KIlicjHKMTNc/h0iWcDN76+JB2YvJhQna4DYC2AcuEuQPP9rBqF1qM/xEFRUR4s9T61fE3CQNGE39n+/EXwMgm6UKsrZ9rV4LjOLnlvfdHAXxHrXrBDzB01GKa/eZhoY4/ugc+mMj/z8u+mj+qQ+cMCZyE4HWXrGkrFxmT7NxGl7+yVsNjNQNdlSqo3fgOj68zhBODyiCfY7x8FXdon8zJvGoHZEG7PQSdTf1UpaZlB9XRSffePspk09tyMtXDnNQPT9yW62XN/WjJhWzpi3OmCCIvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66946007)(66556008)(66476007)(38100700002)(31686004)(31696002)(82960400001)(6512007)(6506007)(6666004)(53546011)(86362001)(2616005)(26005)(44832011)(5660300002)(36756003)(2906002)(7416002)(478600001)(966005)(6486002)(316002)(8936002)(8676002)(83380400001)(4326008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkVZU0krOTZQNGI5TnIwaU1QK0NwejNHV3Avamc3R3M1dDBJZHNOeWIxWWhS?=
 =?utf-8?B?cEl4d21mYVU4RDVJZjZhSVZLUjJFbkVjM1pWY0NaSGVPV1A5d0RnTG1SMXM2?=
 =?utf-8?B?R09yUUZHWGtkcU1Ha1Z2VkxQR3lmQy9mUFdKZjIvbGp3eEpWU1hOTVhjYnpi?=
 =?utf-8?B?akQyMW42RnpZNWhnaXhiaGFKVUIyOWZwdXJqUUVqT2h5cXVwMlNjZnE4cXla?=
 =?utf-8?B?bWxDVUhXT01xcnQzR01mMjkxamQ4TTVZTGgvVVR2WEE0YndoR0puUUpHK0kw?=
 =?utf-8?B?QTU4NWRobEMxL3lYd0dnK0RxQzZybXpnMEY4bFl4NmpMc09DNzNGSzduY2Nq?=
 =?utf-8?B?Yys2cVp1dHIxM1d3TjZ5cXFLSTlRVGdKaFkwdUdsZ0pobGh3OW5MS3JaN0l1?=
 =?utf-8?B?YTN0WU1yeUlyRm9LaE9YSWpRdDRRUG5FWWdYeCtSQitlaTJqTXh1TmVNTnVJ?=
 =?utf-8?B?OW1tcmdFTWdvL3F4bUpkd2tQY1NZVSsvQXYzQWFJUW5FSjNqdG1yZFpBbENV?=
 =?utf-8?B?bXNMdzd3Ny9zZWpDKzJRT0h2dVdzSTN0d0c3SFR5UVRvcGNsRklXdjJIMVNH?=
 =?utf-8?B?aFg5SFJvcEc3NnlCNnp1TVdQWjQ2UnE5WlB5dDJDUzZBOGVzQ2pDaVcwZ2tC?=
 =?utf-8?B?MkgrL2N0WDdSOHZpWkdsVUlLTElzbFZkNWpqbExoQklHUytWUkN4RUE1N0Vj?=
 =?utf-8?B?RUZyM2ZrZW5oSk10ejVKQjR1OWVnUFRmT3NpejQxQjJHTjlXa2xaRWNBOHhm?=
 =?utf-8?B?aWFCV2lCa0Y0KzFKOEdaOGxsRVVTRkZGMldzQXFENGZsbFVhTEl4b3c2VmRi?=
 =?utf-8?B?Mmh2RGFNK29UL0hhVGcrS0gwQ25pS09oeFhaR1NVdEhFYk9vaUl4U0Q4d0lv?=
 =?utf-8?B?cHk4cVh4MzhCc2Fod3BXL2lXc0hjeFl4UlZ0b0JPWXN4ckNneDFlMTBoaVdL?=
 =?utf-8?B?K0FRSmVxelROc2lub3c1L3QwNHVoM1R4Q21PYlpiZytHTy9xbHNhR0t6WnlY?=
 =?utf-8?B?emFpMVRwRnhsUmJTRk5WUUtIQnhqcHM0emdLem8wemJ5SEdKNXA1bFJ5TVg2?=
 =?utf-8?B?N2NHcU9XYVUzTEwyeUtOMjcyRGVKK1VuWXhCcVU0STVzb1RUczRPZjNMVnJU?=
 =?utf-8?B?bGRaWmF5OVh0NHFwdU1rOHpDb2Z0dGxPZUlJd01CMG12TVBzdjdmVDk3UDNk?=
 =?utf-8?B?UUMxK2taVHVuOFdTejhvYllSMGFOVXc2RXZEUkNTbG1STUROSG54L1RWY0Ey?=
 =?utf-8?B?QVU2Rkx6WDB1VS9kNHJTY3hMdFN1OTNEQXFtRWJtdzBVY0ZQVlo3T1hpTDdP?=
 =?utf-8?B?ZnBJMjB2VGVIS1B5RGRDekJ6aUN3SkVRYjhGbmNpR2dvWUh1dVFEeEphMW95?=
 =?utf-8?B?eXR0cGZPM0JlSXZuMEpvUW1UdWh5SmdTbHhQdEg2ZmovT2RWZ0JmSHJIVEZo?=
 =?utf-8?B?L1FWT1grTGNZS1o1bHlybnZNT200L0tydjBQVnpSVnBTbjZGS1FkSEtzY3RK?=
 =?utf-8?B?QVRscmo2aWlvVzErR0tUSDA4Tkw0ODBOUnZ4WUd5dldBMVpDd0dmVXlpSFlO?=
 =?utf-8?B?U0RmaE14UlZyUmx5NFF2OHVEVU1mei9WTXVNb0prd2R5TWk2bWNBaXhCU1hj?=
 =?utf-8?B?aFdYSnpOcU1YcktCbHhhRHNiSmRrVVp4dlRvWlVGaDhPYmxpUjY1L3Uybzlt?=
 =?utf-8?B?QndETktPOGRndjI2cTZ6OERTS2xJUVE1RFVaeEZoNENoVkZFT1hucGkySnBN?=
 =?utf-8?B?Ym1LVmRwS3kvMjlJRElYUWRuc1poTU15SHVBdFhRdHFSR0xjZW9Qc1FWSlNG?=
 =?utf-8?B?RjlxZ01pRVkxb29Ia3hvdVVVam5URGN5dzUvUTU3R0dGbzVueUxOOGlzVlJz?=
 =?utf-8?B?b0pEaklhOXVGQWNFSXRTUTVjeXBwNVc5YzhEMzhvUnB2VlRlR3Evd2VrYnJt?=
 =?utf-8?B?dlQvQXo1MlluTzRRRjhxVGhZbHNzK1EzZ0pMRFBiQlRkZGFibzhYRFV0VEpG?=
 =?utf-8?B?SllINVFyWlRHcjA4UTFOalRESURYQTBsOTBkbFpBYU4vdlYxcTRYOTA4aW9H?=
 =?utf-8?B?cXRlNVlhbHRoUlRoUUMxQ2ZFNHNReVVRTU5NS25aSklxK1NTTUdsNjJPZGFy?=
 =?utf-8?B?Tzc3ZTl5S0VhZ2UxYVBRUFdSSkluYjlteGI5eldDcTFoa2NEbk9PdXZJZVRD?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a943da1e-9bc7-49ab-6d28-08dc0e33d856
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 21:18:21.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvKp/tTASiL8OPY31C/FFuzc8lTwNAULGv3epcgHExGuUsW1jTSlzheYXAkWbTcS21K+KiSCx8FmhYToKeBP28UXxcX7x0+nyB926ki+NbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5513
X-OriginatorOrg: intel.com

Hi Babu,

On 1/4/2024 1:21 PM, Babu Moger wrote:
> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
> supported, the bandwidth events can be configured. The maximum supported
> bandwidth bitmask can be determined by following CPUID command.
> 
> CPUID_Fn80000020_ECX_x03 [Platform QoS Monitoring Bandwidth Event
> Configuration] Read-only. Reset: 0000_007Fh.
> Bits    Description
> 31:7    Reserved
>  6:0    Identifies the bandwidth sources that can be tracked.
> 
> The bandwidth sources can change with the processor generations.
> Remove the hard-coded value and detect using CPUID command. Also,

I do not think "Remove the hard-coded value" is accurate anymore.

> print the valid bitmask when the user tries to configure invalid value.
> 
> The CPUID details are documentation in the PPR listed below [1].

"are documentation" -> "are documented"

> [1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
> 11h B1 - 55901 Rev 0.25.
> 
> Fixes: dc2a3e857981 ("x86/resctrl: Add interface to read mbm_total_bytes_config")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Same comment about "Link:" as for patch 1/2.

> ---
> v3: Changed the event_mask name to mbm_cfg_mask. Added comments about the field.
>     Reverted the masking of event configuration to original code.
>     Few minor comment changes.
> 
> v2: Earlier sent as a part of ABMC feature.
>     https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
>     But this is not related to ABMC. Sending it separate now.
>     Removed the global resctrl_max_evt_bitmask. Added event_mask as part of
>     the resource.
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 3 +++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 6 ++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 ++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index d2979748fae4..e3dc35a00a19 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -394,6 +394,8 @@ struct rdt_parse_data {
>   * @msr_update:		Function pointer to update QOS MSRs
>   * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
>   * @mbm_width:		Monitor width, to detect and correct for overflow.
> + * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
> + *			Monitoring Event Configuration (BMEC) is supported.
>   * @cdp_enabled:	CDP state of this resource
>   *
>   * Members of this structure are either private to the architecture
> @@ -408,6 +410,7 @@ struct rdt_hw_resource {
>  				 struct rdt_resource *r);
>  	unsigned int		mon_scale;
>  	unsigned int		mbm_width;
> +	unsigned int		mbm_cfg_mask;
>  	bool			cdp_enabled;
>  };
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f136ac046851..acca577e2b06 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -813,6 +813,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  		return ret;
>  
>  	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
> +		u32 eax, ebx, ecx, edx;
> +
> +		/* Detect list of bandwidth sources that can be tracked */
> +		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
> +		hw_res->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
> +
>  		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
>  			mbm_total_event.configurable = true;
>  			mbm_config_rftype_init("mbm_total_bytes_config");
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 69a1de92384a..5b5a8f0ffb2f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1617,12 +1617,14 @@ static void mon_event_config_write(void *info)
>  static int mbm_config_write_domain(struct rdt_resource *r,
>  				   struct rdt_domain *d, u32 evtid, u32 val)

Not specific to this patch, but since the valid mask is per resource I do not think
it is necessary to check user provided value for every domain. The user provided value
can be checked earlier and only once in mon_config_write() before iterating over all
domains to write the value.

>  {
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	struct mon_config_info mon_info = {0};
>  	int ret = 0;
>  
>  	/* mon_config cannot be more than the supported set of events */
> -	if (val > MAX_EVT_CONFIG_BITS) {
> -		rdt_last_cmd_puts("Invalid event configuration\n");
> +	if ((val & hw_res->mbm_cfg_mask) != val) {
> +		rdt_last_cmd_printf("Invalid input: The maximum valid bitmask is 0x%02x\n",
> +				    hw_res->mbm_cfg_mask);

I think keeping "Invalid event configuration" is useful to create a detailed message of:
"Invalid event configuration: maximum valid bitmask is 0x%02x"

Reinette

