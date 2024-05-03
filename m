Return-Path: <linux-kernel+bounces-168233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B70B8BB577
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526CD28139A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A55B47A6C;
	Fri,  3 May 2024 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UV95HAiQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AAF4174C;
	Fri,  3 May 2024 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771003; cv=fail; b=f84UXeRNkch/MQN3Ms7AwkdDv3WuREtlhB2ptNY60ZptrQCMWQFAzpMqf6qxcsi1mnZUmnhKnnMXZ6ZEmH/SyL8k86af9U9NcDddG49juch12oNbJmTOiiBI5HRyn1yclX6V0ELrIre8tc6IWOc79R2rONP6D1P2OYyVU7P5+Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771003; c=relaxed/simple;
	bh=d4KhommHj3ZJmwWe18iZ/YTq0Xv8Fouv9TIBvl69cf4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FsTpScESzaKz2YKy6KzQFcg1JTFHty1Mtc5+NuVEBezu97/a1k1qh91atKA/DW7PbjuU9T4BuaCJ70J+9U52OkLXrcmcKDaYDJ9BN5rpVKI965T+qmRmDV0ajfmpUXCp+0Rfqzgz+ww8d2yMkIxOG18dG6aUDEYGnivjPDFyzf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UV95HAiQ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714771002; x=1746307002;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d4KhommHj3ZJmwWe18iZ/YTq0Xv8Fouv9TIBvl69cf4=;
  b=UV95HAiQ1aQ8Td3ZdD77pBzmELWCE+s5IAMecFgh01BRkot2aUfkBFPC
   HSLpZSwDG9Wy0yen6qHOp+WX793NmutvQ4D7fvGWI2lDv9VoZMBSaa42i
   I9M0TjigasN5KVdq+lpE7eAaJtAjvZxpDcEHpv3uxLa3H5gouXmSIMoyc
   gB1+cPRlsU5AQJSZxSLz2p1PpAr43WgQEDxAC7pCnYvWjzaNPfkatSZPb
   yaRiiO37ozz7Y1G4njyKK0EikGqFkwjGe8duEEKAohIOdgt+FEjl0IiZT
   KEKuoVhz6mda1Yd26osQ6w0+Tq8newPgusuRgp1T8neuyqpYUeNCbHMHl
   A==;
X-CSE-ConnectionGUID: 8im+L/f5QtCc/Pc59KsWtQ==
X-CSE-MsgGUID: t7PT3Zt6SoiPRsCmSL8Klw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="28072358"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28072358"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 14:16:42 -0700
X-CSE-ConnectionGUID: PL1R1lW2Q324KxCzHwH3kQ==
X-CSE-MsgGUID: PqTl42ddQjWucRMIy7Wo2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="32376349"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 14:16:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 14:16:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 14:16:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 14:16:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 14:16:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQg4ldppfrBauRfZPXHhk8VHvHkSNweW1bZEmuAKBo2XvGM46dS4fpQNiHvNhAifK5V8dpODhWAxZZJV+t3RWWHhucVG2kCwQcMxZJfhcyGQ0HG1ARs9vY5O3/uAfYs6TaJ3pyGfnmZPx+DadG2Q7X4VrT+vQ7xqS2Wued+lFUPPc7BJLlwKK+sptA3/o9tGr8UDY51I5chmlOSjxdHdtUWQ1nQDSxpEaEXvIsTPJip1ii9f+g+x1UKjsB+gw3iNXo1IoTiwHkjGCYoSieV218BQ6oTBJI+nblBq6tWeJmFn49zNo5zqhmSKcfExFgUDjC1Mp+xSoYTH8fbNETYqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HXM09XlSalxLQtd0Dg5eiAREDZb++AWqWEStWSVp0U=;
 b=F2SzeP46voFZEt06xwFIwge6b7OqSaPTHIffKT8je360DKAIkFDYrTxHIIYH71kCsuocbiOybXULc5nx29Xpe8AFMPUemzFeHQpldH8DyWx9H/MVNXUdj9HFSSZFWQSfPQyHW/QZdCwg+xw51PhkLMGJTJa4HooDVOE/66KdRcG5pVA4sHKsmY4LedFmVCUYMbZ/A2LQKIwSuyJIhwg4J5TxcDrUUp24LzV7Z10z6AGYs/eYQwzk0zpWdaqmh2MPr33vXOvyKlaGqcal49YkOIa4HSEY5S9hfIyYGEOGAjtgyBI9aQzPDvQ5C2venWnayyZj9O7GvJyMuWmRIbkfAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6220.namprd11.prod.outlook.com (2603:10b6:208:3e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Fri, 3 May
 2024 21:16:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 21:16:36 +0000
Message-ID: <330e3391-b917-4a88-bae3-bdcbb8cfd6f4@intel.com>
Date: Fri, 3 May 2024 14:16:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 17/17] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: <babu.moger@amd.com>, Peter Newman <peternewman@google.com>
CC: <corbet@lwn.net>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>, <james.morse@arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>
 <CALPaoCihU+mat2A-wNtTm=qbpya8ZqhDURsfZfjuHitch0WrLA@mail.gmail.com>
 <9d59d38b-af1a-46d8-81c4-b426d47d4ed6@amd.com>
 <CALPaoCgFEybS5MhsPx4EaJmsfBe8Es_6QwWBXpoctdaNf0NcMQ@mail.gmail.com>
 <80c56417-3d74-7d68-1228-9cd944567b4e@amd.com>
 <c8a23c54-237c-4ebb-9c88-39606b9ae1ab@intel.com>
 <4cfe9c47-4736-b08c-50a3-5d7a11246b5b@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <4cfe9c47-4736-b08c-50a3-5d7a11246b5b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:303:dd::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ada43eb-8dc5-4526-b3a9-08dc6bb650d7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bG1LWDQ4QmhwamFjamJ2SzdJM0tZTUxpck5oWFZOMnJzU3VabG1nRmtTU1g1?=
 =?utf-8?B?NnUrMXlPdFNiNkJFUDI0UmxEWWJ2dGdHck9Hb0FXVlNHSUc4VGJtWjNxSWRx?=
 =?utf-8?B?THVkd1NUZEM5WDdqTW9GU1BSSGJoWDI1Qy9Rc2ZocUp1aEhGRkhhcFN6WDRu?=
 =?utf-8?B?dVdPSXJMQnZ4WDlmcUxVYTdhY2R0ZXR0UEpnSzlDczBKMnRTMVpmNTJXUm8z?=
 =?utf-8?B?ckpHZDJlbVljRHNCNkg5VmpzS3RVanJpYURXUTk3WGpZaHoxaEtwdCtNZ1V2?=
 =?utf-8?B?V3RpaFlsOGxnZ0NiNEhiaHQ4SU9CQWJxMk9kTzhKYnA4eTNHRkJkZ083MExY?=
 =?utf-8?B?L2RPQ1M3anVyQTdZYzQ4bzJOUXZocElXbkR2dmdnbzI0RHVMWWc1Ukh1RzRP?=
 =?utf-8?B?Z05sNm9VRWZwbmxyMVdCeHZ1ZXd2SG1IMWdRbGIrRVJQVmhqVTJGYUdJYWF6?=
 =?utf-8?B?V29SRlpHcnpvQldkOFJ5UUJBbUVvZ3VyTER0Qm5WV0Y2bzBoRFA4a3VrSERz?=
 =?utf-8?B?SXR2endVaUJ2S0VENjY0Y2k0amlVdTUwWC83Z2dXZWpZZ3Q2K2tRdnB1cU1v?=
 =?utf-8?B?R1VYd3MySGtsRE5Gb3p0QmROdFFRVXRKK0Rjams3em0rTFVRVWt3WHFtZlpn?=
 =?utf-8?B?T1ZzTmdqZUM4V2FmVk1hbXFoLzBtVmRqUzhTTzBia01mUXRiSkNmc2xwR2lD?=
 =?utf-8?B?VW0rM3h1bUxBV2xsR29iSlcvU0pPNzNWbWN1V0R5cW1PQWdSNDlyU1BERVBC?=
 =?utf-8?B?ZHdRc2pySUpYS0FnWUtXZjFRVEtZRGhNRFZQMkU4WjI5Vzk1NE01NmYwNlFs?=
 =?utf-8?B?Z3RvK2Uyc1VTRjdyaHFuVUlERlV0czdIamFxZVZyeGJyMENqR3ZkYnhNVGlB?=
 =?utf-8?B?MTlSaVlGZENoNm5oeWtDVHlPZWZmRlU0NWdvaW5YMHN5Uyt6SnVaZ0RqUEFD?=
 =?utf-8?B?L01JVkdCcDNjVHp1VDVHNWZsZDY3VFBET1lkN0NQOUwxQVJ4Lzl1M0c0dmty?=
 =?utf-8?B?TzBYOW94TFJWT1JldlBQa1B1eXFqTkxQMHZUbWRCRzlrMnkveTRaOVVFd2R6?=
 =?utf-8?B?Qm5QaEFTWmJMOU1IbnZFWWZjd3pEK2l2bStUYzE5Sm5mb2FRcVBvNlpmY0FR?=
 =?utf-8?B?WVNJaXVIbytwdkZOdFJPeUFsRU1jeFNCTDFNa3RPVW1rZFc5WlcyZTJuancw?=
 =?utf-8?B?bzkyWENuTlNtT3J4Y1VNN0ZLTk0zdU9kUjJzUHQwSVJwV21leDhtNGFiS1Vy?=
 =?utf-8?B?L1QvOUgwdThvRXlqQ21kR3JrdzdFaDhlb1A0OG5HeU5QTEgveXFxYUNSV3Jp?=
 =?utf-8?B?K3pSVzBJUGJIVHlQeVVVNDRMUDdDRkZvQkV0SjBISVUzN01sT1R1blF5RktL?=
 =?utf-8?B?Q1NXVzNGUnI1UkZBUHgvNENQbEtuY2R0Nm1uRk90dmJoNGVlbG1MVUd5Z3BR?=
 =?utf-8?B?aGl4dGRwY01vTU5Ia0E2MGVaUzArT2F2ZFBRTW9UVkFIa0JldFVmK1gyVlBv?=
 =?utf-8?B?aU1BMTJ3LzAvcHhIRWZYcUsxQi9zeEF1RDBxYjR2YWR6NGxycXFCSzJ4R3ZJ?=
 =?utf-8?B?L2NrZkpuQjZXb2FZZFMweFJ5cHFjWi9mT0F6d2Rpb3VndnpZN2FjSEp6NzRX?=
 =?utf-8?B?MUdSbEZDcDhiNGdLMGYwOUs4eGtzalBKNEwyVklILzlDNHBnaURXb255Z0hn?=
 =?utf-8?B?UUh4MzhCMmpBUmthMmtjVzc0L0JqbHU0eVNnUTU0RGc5WUo4cGtjd1J3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkdYWVFTa09nUVg0RWI2aUJaWlZFUlN1bjdaVEVxaUNWNkZHUTRwNlI3Y25X?=
 =?utf-8?B?aVh2NlpRREhDR0tiUW1EUXVIRWF0OCtseTdqaHkzNkxHdDkxWk9iejViK2ow?=
 =?utf-8?B?UWpBQ2xvZm8xOERMbjltTEwybEpGb04vN3lrbyt1ODFOZXZsWlRCcDRmM1Zo?=
 =?utf-8?B?MEVOZWVwbXArMFYwWmpkcW5ZMW03YTZoajdVamlTWlptblY1MDlTYUtTYkYz?=
 =?utf-8?B?bjYraGF2UlVZRlA2K0svYVZGalVROEhnMExKQ2JPamVIeGJvYkN1YTJGeEp6?=
 =?utf-8?B?d3FxNHFubTRnK2RZU3J6RmRwWWNobkZuQ3c1U1BBbGR4TFFCMytQNWJYaWFi?=
 =?utf-8?B?RHVnbGlheUVycCtxTkJEbkJRNXBEcjlmWUhobjRhZXY1OGFuNlh3ODBlOWRa?=
 =?utf-8?B?L2swNW11TDQ2ZWNhZmVpSXEwcHZmL095cE9YeWxnS1BHZ0RnK3NxV2JWUlF6?=
 =?utf-8?B?QmtHNkZidWVWODlDN0hJNVpIL2gzSmVoRTQyYUxkMEhEUzhQcjFtUlhZYVY5?=
 =?utf-8?B?WG1sY3cwc3ZTN2FmVVpCQVZUQkp5Q1ZPN25tUE9NSWkya3NUZVRsUFNRYmNI?=
 =?utf-8?B?MytJclVhMnFXdXpWY0tweklmODRUbUdFdXdPbmYwaFQyUFJ5UWNFVkVYekM1?=
 =?utf-8?B?SDN1S2NmSVZsdHB1VHMrSDUwV0w5MFhWWjY5UTdVbzFIcThjNXFuWlFHWi8w?=
 =?utf-8?B?VWFPeERuYjYvaVJpN2lwVHhpNTd5SFZGQWVQZ0wxMzN2Y1dwdE5nWVJOZi84?=
 =?utf-8?B?bUtQKzgwQVlUdXB0SDNMNWlPN2FQOE5xcS9pNW9oM3FyTHdFK1ZoSW5wcUlE?=
 =?utf-8?B?eE92QnFsVmFNNlJOTWtBSFZzT0g2VkZ5MUp2VlVmNVNKTXV0R2dwUkdVOWdH?=
 =?utf-8?B?NE5OL2pYVGRpVnlVSVNFSk5PaG8zVDNjTlZpV25RV0wrTzdYNThaY1lBOTdZ?=
 =?utf-8?B?QTIxQ0xWQ0FVcHZmU0xrNVZ5R2FNb1d6Zjc1QkRKejJUSWdnOFBaSk9sV0l5?=
 =?utf-8?B?dE56TUFnWUp5cStJQVBwdmhSSjA4amVZeEZvcEF0TUpHRllEUitJTDFoMEN6?=
 =?utf-8?B?SFRIeE04bU9aQ01aNUlZWEErcXVFVTZ3OWNMSzdXcmNGMllCNWgrNEZjcDkx?=
 =?utf-8?B?d2hqTUtBVmhSVUU2N1UrSkJLbnUxbU42cFQvVmJaL2dpc3k3ZUVNTHp5dVpa?=
 =?utf-8?B?UE1QcHVBR3pSWktQeCtGQ3ptT3pUbHAvbDYvaUU1ajZ3d1hvcFczS3BvMERM?=
 =?utf-8?B?UEZIRjJkZ0hnS3kwM0ltWHV6WjJYNDZyK3lTS2VIdU9xMWZyc0dvMC9FY1R0?=
 =?utf-8?B?RDd6SElYMVlhb3dDek43dXoyRjBkMlNhTFN5SnN3SVhqZC9hV1pZQWUxR2hJ?=
 =?utf-8?B?US9xWlNyck1ORm42NFJ3S1hUL2tNaWZPeWlUVm5hZVc2Wk9ENEJGWi9RTmtN?=
 =?utf-8?B?SHQrT3RZRzEyczlBZEhhUUgwL2oxQk9aMFUrb1kxVzh6dUkxOTFESnhhRWFt?=
 =?utf-8?B?VU5oVitKSlBDVklNRGQ0aWNCdTZ2NFpPRVEwZ1NuWFNWTDZ2djFpMU5qTTBx?=
 =?utf-8?B?NnYwYUJ0NCtSaWd0WnM0TG5Uem1kNUpYZ0hqTE1Hc3pvY3FhazZUVnN2cDNF?=
 =?utf-8?B?alZxcGVsaXJHS1h6SlYwOVVzeDRJVU50UW04cUtuK0xnS1NSenpzdHFJM3Ir?=
 =?utf-8?B?RXRVbTBDamlFVlUzZktoVzVTUTZHWHR2TTlEU3JIMjlqcE4yeUJ5ZWpOYnU3?=
 =?utf-8?B?b0lqZFM3TFplUWR6UDVVd3kxWUpuSXc2NTUxMFBFSWUxS3N3OW1EYzlKRU9U?=
 =?utf-8?B?SWtGT1hCb3p3R3JSclhVeVZkQUQ5OGs0cmtUUEhQNm9WYkFFYzVobVU4M3J4?=
 =?utf-8?B?bjRpblpkV3puS3phcDlKYWVPdDlSbFZnRy9IWUxNOTlMR1l3VnZzMGZaMC9W?=
 =?utf-8?B?YkRIZVJ2Vkk2dCtyNmpPRENZY0I1alArWXN4U21KNm5uMGNwekJMQmRFM1hV?=
 =?utf-8?B?bDMwS3JKRzh0U3ZRRE5mb2JxMGFNNS9WZkF0cEsxSXZUaFNYb1JJekt1aTNT?=
 =?utf-8?B?NjNXRXNON2h5WmZwZHh3bFZkV2YyTFFYZmhET3QwQ2dObXhUcDFtWmJIaFV3?=
 =?utf-8?B?MFA5WGJZT244SWR1QklmS3RuUTdqUy9FRFNERmFISm9BbnJOdThGL1VSUGlo?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ada43eb-8dc5-4526-b3a9-08dc6bb650d7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 21:16:36.5444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QnBfSOwV9K0+kdepmOQtPoa2yoByCTMezci0t33mqpNRU9o+/4faBeWwCvLBpsuqpXxfWaIBn5DHRvW0Z3ZZiFWBl9oZ2Q0KmeDw7NImFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6220
X-OriginatorOrg: intel.com

Hi Babu,

On 5/3/2024 9:14 AM, Moger, Babu wrote:
> On 5/2/2024 6:00 PM, Reinette Chatre wrote:
>> On 4/17/2024 3:52 PM, Moger, Babu wrote:
>>> On 4/17/2024 3:56 PM, Peter Newman wrote:
>>>> On Wed, Apr 17, 2024 at 12:39 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>> On 4/17/24 12:45, Peter Newman wrote:
>>>>>> On Thu, Mar 28, 2024 at 6:10 PM Babu Moger <babu.moger@amd.com> wrote:
>>>>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>>>>> index 2d96565501ab..64ec70637c66 100644
>>>>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>>>>> @@ -328,6 +328,77 @@ with the following files:
>>>>>>>            None of events are assigned on this mon group. This is a child
>>>>>>>            monitor group of the non default control mon group.
>>>>>>>
>>>>>>> +       Assignment state can be updated by writing to this interface.
>>>>>>> +
>>>>>>> +       NOTE: Assignment on one domain applied on all the domains. User can
>>>>>>> +       pass one valid domain and assignment will be updated on all the
>>>>>>> +       available domains.
>>>>>> How would different assignments to different domains work? If the
>>>>>> allocations are global, then the allocated monitor ID is available to
>>>>>> all domains whether they use it or not.
>>>>> That is correct.
>>>>> [A] Hardware counters(max 2 per group) are allocated at the group level.
>>>>> So, those counters are available to all the domains on that group. I will
>>>>> maintain a bitmap at the domain level. The bitmap will be set on the
>>>>> domains where assignment is applied and IPIs are sent. IPIs will not be
>>>>> sent to other domains.
>>>> Unless the monitor allocation is scoped at the domain level, I don't
>>>> see much point in implementing the per-domain parsing today, as the
>>>> only benefit is avoiding IPIs to domains whose counters you don't plan
>>>> to read.
>>>
>>> In that case lets remove the domain specific assignments. We can avoid some code complexity.
>>>
>>
>> As I understand counters are scoped at the domain level and it is
>> an implementation choice to make the allocation global. (Similar to
>> the decision to make CLOSIDs global.)
>>
>> Could you please elaborate how you plan to remove domain specific
>> assignments? I do think it needs to remain as part of the user interface
>> so I wonder if this may look like only "*=<flags>" is supported on
>> these systems and attempting to assign an individual domain may fail
>> with "not supported".
> 
> This series applies the assignment to all the domains.
> 
> For example:
> 
> # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
> User here wants to assign a monitor to total event on domain 0.
> But this series applies monitor to all the domains in the system. IPIs will be sent to all the domains.

I would like to recommend against this. (a) this is not what the API
says will happen, (b) behavior like this may result in users having scripts
with syntax like above expecting changes to all domains and when/if
AMD or another architecture decides to implement per-domain assignment
it will break user space.

> Basically this is equivalent to
> 
> # echo "//*=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
> 
> I was thinking of adding domain specific assignment in next version.
> That involves adding a new field in rdt_domain to keep track of
> assignment. Peter suggested it may not be much of a value add for his
> usage model.

I do not have insight into how all users will end up using this.

Reinette

