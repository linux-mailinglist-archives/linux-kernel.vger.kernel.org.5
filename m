Return-Path: <linux-kernel+bounces-18362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D6A825C10
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99007285466
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165C03609A;
	Fri,  5 Jan 2024 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OvqP/E5r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443E358B7;
	Fri,  5 Jan 2024 21:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704489273; x=1736025273;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1EC0XZTOP26J7E0ZamFc+QLA5KYGJM/gHPwrUWwgWkc=;
  b=OvqP/E5rlfOtQHSKC7SFcr9UqvFcrC5Kjj3W29OYZeI9Qqc7+rdfqAGV
   ZcNy56hf67cG42A+Jnri5VRypHKXGDUiswqu41cnhYI6LMTRjUuUaNejU
   gtFRkU8UwobYBJf9C2ZqmQ+g1NXNYKWlUMedB5WGdLMRyjECLoADa7M4m
   NXYQojnz85p8xrq7gUbZ9pXgfbCRh4kAv0cIkSzWZfzaVZGyRDV5wBpLV
   DWXnr127lEAHkCisr6xB7Iw93HDK/LwpreU6CYqSuBYPGe1jXw/NjnGHl
   6oe/9qeVBTvtFBh12Rz9R+3RCvkdyVtVSSH/F8k8zdWJKqR+iKT4MPCwW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="16202651"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="16202651"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 13:14:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="773938186"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="773938186"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 13:14:17 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 13:14:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 13:14:16 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 13:14:16 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 13:14:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZltWYdtz8r6klziZN+rf2KEvchPdy6mhC2bcM5Ls8F6nnfno2YQ4PgYvrgKDJiwcpXEgOmZR0DDr1di8592OcbMrU+l3kUNwhvhD5HBjGulNy9Z29rJx8gaGWLmSApv+vr360Ki1CD9BxfRhATe/1EBJAYChswDzEGm4TGnPD68k4RWvcawUUOWVOzQ8hQYdgX5hvML7NijOuGVnjA2Ex0eSjJuTz/grRUF3830t2ly3Onf3quhv1xPOAQVAKOPkVJ2h/l6JvORRuI1ANa0ydiaOQZZkmElf4nbCos9N5OZYgAgta7zjaxiRloZORnq4PgZ0nwj1AjPYNyTuOXjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB1LPkqrad/RliJNcm53NCWnYN85nioaV7Qw+I+YHAs=;
 b=CQYMvSQLHLln/gGzZ/fFISAnRD/x8rAQl5bxxOZ9aNASr80P7GSY9U5BXyz8L8gsYMs9ZQa10qdEc8KD3uCiYCwehaFtRAFvb7XJTBM3j0uGZAox8N/eUO3Y6heJbtcyU7f+lBk7VswRAfcN9mHJceDaPkFf0i76RkfS9ru4TQJ2OFPI/2RDIi8KG2nMFgELcxjMSgpTMIRDRc0b8ifQZMtJygIXfFnopYVgb4y1apqizjJGrTotF7N2UT8a0CU9Q1ZC5a04gRiqMpeDu4uTbL+jxiVkAq6J+YnwPY/SnXip6yu2ut05vnnDb+qqhMBl2j8SPK8mMDuRehjF7w5rUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4600.namprd11.prod.outlook.com (2603:10b6:208:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 21:14:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 21:14:08 +0000
Message-ID: <5a3624d1-0801-4418-a179-38ea83c40c94@intel.com>
Date: Fri, 5 Jan 2024 13:14:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] x86/resctrl: Remove hard-coded memory bandwidth
 limit
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
 <20240104212130.209490-1-babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240104212130.209490-1-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4600:EE_
X-MS-Office365-Filtering-Correlation-Id: dd11cd5b-eb08-4b44-b3c7-08dc0e33416c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epkEWOU3krKIa1vXoczF5Eb+JFf6EJUy+Os5Oiqiz+8ofhRbwf8xl+TGBjQm8NVl/70QXLCk1D8X3Ob2zqo1VIBpEjt1a81iGUPBxV0yOD6mWrz2nHUQeZlNC5p6lHYsBgH8H1iibudMriUUSsxKXZ+GR+XcwTgINnlQ4yKLiPsMntbSyWQ3XtZNDQu0o+xv+SFugFwmyMJObpsD8n6k1FJhELC0jSMb7OK9TWMscJITKuXs4sfPdFKx1SP8Ti1JjfTYHqebUcUPVcv7RxYIwnwmZWyInVDNgclxnjAOMtK4pgmXss9SmbiU/n1U4HQy0r8Lr6FGYFAMLWK+u0cYEEfQRfIYN6NlaTpWv675OtM1sHvNpfGyBpGgTzVz8o4XfxzL+LIFxkGXByJFpMeRrqQnCXcUxdStYrXCoJh/c0IJW1rSbsknLdot+9PM4KsvXqj56qEC3s8gdg5tz6onPwCmthNf01Mbnr7YM/ERzbWwASTCrkMNrTFsI9iaKAs5M40pui+Ye8cBaBbxVkbbiXVD0scArEq6eU08Shi8wPYYiT9/9+juEiAnMkEhDy+fOft2yjQKrjLnMzCntLTo/UT2QH2ILKlh65U5neiRCfIiFtO38BqVN6R0e+Rv60jynTdVP/DMx7a4DBiY0yTGxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(2906002)(26005)(53546011)(6506007)(6512007)(6666004)(86362001)(83380400001)(4326008)(316002)(8936002)(8676002)(5660300002)(7416002)(36756003)(44832011)(6486002)(478600001)(966005)(66556008)(66946007)(66476007)(38100700002)(82960400001)(31696002)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2dCMTZIUkkzS0wwTDVYRXNSaFczTGM3dXFYaERzTDhUVWlNelBXY0xsR1Nq?=
 =?utf-8?B?K0REZDB5RDZoSStEQVVwTlk4ZWlIc1ZmeGY5eDJxVTFrcTdaczB4S3U4bVpr?=
 =?utf-8?B?a1BIWVNreTE5SU4wTmRMZUtIY0NPSlNxYVFmV3RidmhQZEtGQ0dQcEovYWs4?=
 =?utf-8?B?OUd5Tk4zcnlVdEZaNVNTTG15U3dTY25LbGsxREp6WXJXOUVLYmFEZFhnVU9H?=
 =?utf-8?B?YnRibm9jalhIbXBlVUtTU0x0K24vT3FYOUxCLzEybVBsdXVSMFcvNXlqTnY3?=
 =?utf-8?B?TXNJRnJPRUlIUjdsaG0yNXJBVFJUS1hRQ0ZtbUQwUVk0bGh3ZEp3b1ZOT1V6?=
 =?utf-8?B?WWxOcElkc1pVSTJHU1k0LzIzZlpkMXFCZTJxcW40TFN5NWlMK1kwMUtuRFAy?=
 =?utf-8?B?dGtpd1pIRWJEVUtEK3RrWGZqbklRaElaOXBsUFJhUmNaREpvb0xUY0VWSTlI?=
 =?utf-8?B?YnJkVDNYOWFnVjVzYTZKRCtiUFJ1T3diY1lZaS9XMG1wcWtoQkcwcXVGdzl6?=
 =?utf-8?B?Wi95Ulo0ekhlMUJxNlBxWVRwQ1JQTlRnKyttL3VpdXlSUzE5bXQ0K1BkNzdP?=
 =?utf-8?B?cGM1NGhMNkNseFB6SmozdmxOMFl6dWtmTjRUU1ZCNE9uc1J0eFVIcFU1L2Rt?=
 =?utf-8?B?d1AzcHdKNTlPejZ5dGtJYlVTTzV4VmFpMHc5MGluL0JtejBUQit3cFBMSmpV?=
 =?utf-8?B?Q0hiNGcvcEtYNHdhN2xEZG1pZzN4dGdKdEhkQk5zUVVmdW81Mi9BZXhlN1pa?=
 =?utf-8?B?bjNxUGlwRDJWTTVZSGVEZnN5VlhkZjNTa2dQZUN3V3pZUjlHMEpOTVcxTUh4?=
 =?utf-8?B?OEpzNE5yVG9sUSs4Ymk1UlcvS3lNaUt3cjQ3S3IrZnk5WTZ2bmpWTjIvbEJp?=
 =?utf-8?B?a0JrKzZXZHBsdmxjNmJVWmdxNUdhcFNLTWNxVjFLMDRRTlBwWnRtNDZReExW?=
 =?utf-8?B?aG9weGN0Y2NQVzBadTdlS2RVN2gxZHczVklpZnlJZEJTanNFME9Ta29kcm1V?=
 =?utf-8?B?dDYxS2JRYXFRRkVQd2twWmZrWjJKR1RRNGQ2Ym53TzZlZVMzQm0wM2Zpc1lC?=
 =?utf-8?B?ODNJcVc1TFJic0s5K2IwdjBXb1JWbEkrdy81UkxiQ003dUhvdEVKRCsyOHA4?=
 =?utf-8?B?bUtncUM1Uit3MnFTM08xdVlGUnN3aVE0bkMxUy91Ym8wU3RNWkpGQUpkWkp4?=
 =?utf-8?B?Z1ZrajFINEJtMS9rMVZTWkJVRXFOVnBDZ09GNnpZdFBuYVByaWtEbGJDRjVx?=
 =?utf-8?B?VFhidnBuQmVSVHpscUlvajVrSlZpUVZWVUJLV3dkUG5MQ2ZFZUJuUVB5RG9z?=
 =?utf-8?B?dkliOVVVaHcvNTdXampycVRsbXBsSC8vSjFMSXJBbEpNaEpISTBjT2lFVTFm?=
 =?utf-8?B?bzFlNmxwcGh5eWZLTTJ1KzZDOHRkUld5YnNNeWR2L0pVbmo1WTVLdVpES1lk?=
 =?utf-8?B?NWRUWUZ6RzFEMmQvYjZab2hyRXArMXBJRVpYcWhQK09HOWJUdHF6MFNqL2hV?=
 =?utf-8?B?Ujh2QWlpc2wrdlBndnhLY3FqbjltT0IvWW9QQmFwd1N0ank5dm9uYnpDVXVr?=
 =?utf-8?B?VWpYRzR1Mm5Nb0MxTWMrOHAwSFNCeit2alJKdXYrSmJYaXgxZ0VkYks3U25z?=
 =?utf-8?B?ZUttTkV2Y2FpbHd3T3hhbDBtNzg2T2RsZWNSTnVQZll2bEprQ09KdUt3eGRB?=
 =?utf-8?B?MjQyb251MjBvbC9NWGJYeHJBeDdML1h2dmVXdE5tc004dFhhbys4WkFpTHRP?=
 =?utf-8?B?UEpuV0FrL3VVVCtVc3JaZkNlcCt5QzhwekoyRzFiSnl2NHFQUVNyeUVoNG5w?=
 =?utf-8?B?NHZNc0FCWCtLNURpYVFCNTVxYjNRL2x4QmdRQmFCNDlkY20wSTg5dW53Z1FM?=
 =?utf-8?B?MzI5WkxLSjFUTnBUUkwzL2NPV1lQT3ZTSG94MzVOUGlqSEl4SkY3MStGVFkv?=
 =?utf-8?B?QTdpR1BJVGlIVkUyMEh4S1N3Rk1jMzByZGFqVHU3SU9yLzRKTkJuazQyZDla?=
 =?utf-8?B?b0xZMlM3NEt0SWFxRGc4c2FoY1hITXFiNjR6VWFKSjFBWmQxOGE4YWFXSm9J?=
 =?utf-8?B?aVpFRmRzMzUzNkFtbEcwNDZWUHMwbnhuOXVtb3pzY0hnZjNlcW5EM0dCbC9M?=
 =?utf-8?B?QTNKL2lWcUgrR1lER2h2b2FmZnFpdGx0bUpiV3M1bXFPZ2JOczVZZVk0bzZG?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd11cd5b-eb08-4b44-b3c7-08dc0e33416c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 21:14:08.5492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPm8QIO3k32o3IGOJplXS4SMr2TLisXgb/egrLU/vxV/iil+vnNfA8H/Og8vvkWelXxfS7+zwVi0ZGGwU9CxRv4qeNmBDTckBMuakS1J5w0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4600
X-OriginatorOrg: intel.com

Hi Babu,

On 1/4/2024 1:21 PM, Babu Moger wrote:
> The QOS Memory Bandwidth Enforcement Limit is reported by
> CPUID_Fn80000020_EAX_x01 and CPUID_Fn80000020_EAX_x02.
> Bits Description
> 31:0 BW_LEN: Size of the QOS Memory Bandwidth Enforcement Limit.
> 
> Newer processors can support higher bandwidth limit than the current
> hard-coded value. Remove the hard-coded value and detect using CPUID
> command. Also update the register variables eax and edx to match the
> AMD CPUID definition.
> 
> The CPUID details are documentation in the PPR listed below [1].

"are documentation" -> "are documented"?

> [1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
> 11h B1 - 55901 Rev 0.25.
> 
> Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Looking at "Ordering of commit tags" in Documentation/process/maintainer-tip.rst
I believe "Link:" should be the last entry.

Reinette

