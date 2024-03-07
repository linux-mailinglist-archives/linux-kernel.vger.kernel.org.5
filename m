Return-Path: <linux-kernel+bounces-96212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3208758B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A651F26344
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769DC139585;
	Thu,  7 Mar 2024 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0Bg5tTQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5021386AF;
	Thu,  7 Mar 2024 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844081; cv=fail; b=ud5skzgFLBrFjsNusYXtEqh7MpWIGAk7Bp5ai3jyWo0wcF+RWBxsz2IRgzv7Z6rPMAhwJ3PnFxSrGHo7vwWSXnmbAqs3ZRlaAAoXSaQ7iNoF6qVFIGJsnc3dXUNq1ScWqcOamfFTbPeKyNWgCbo5YY8Debz4uUxCHRjtosMH9bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844081; c=relaxed/simple;
	bh=4tQSKYLg25p3JEi0dTlkRC+PJj4RUyNkx6FMhnvVLlk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gSrCtfPV0SYupRX/LkkMp/9UriVw9JdUBQkfaEWvDBFX3BmcltfuAJIR0NTnsSrKKyAzfAHCZNHvW1eu8o4mCEjAeNtSgUtL1xCw+RBB7TH6kGf7Gghsr4bAw9mpsyedL8b1qWXO0jbBwGAT3NlVbeKBvLj2J2qRfGkImKp0VwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0Bg5tTQ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709844079; x=1741380079;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4tQSKYLg25p3JEi0dTlkRC+PJj4RUyNkx6FMhnvVLlk=;
  b=S0Bg5tTQyYYpSkivYmvr7eSf6/RHVE55r5AjCDLUsnAFj9E0Jq2pCpYh
   hB61/qwOfxvamvSCDfg4nYNCgRMvwvNLWZ31u7CYDYCc8CFEBKNxB+Vgd
   ZQv/UlQ/coixlp1pc5uW1ajAcV6HdKvrSiBHMBiupUorl3+BucVtfOfZZ
   vYgEu7xdyz0TD+oj7doVvNGB5RpejyjNP8WK2lYUqFZY+hVPq6nvynMeU
   BE3S2g/ZTIU/DWoe114HRvXc+IvWqHsy4vR5DBANGN5b2nGnDDZhki0UH
   yVUiDqyXgd4Y+LR2J8cijzwrWCvwID5unf2n2TqqDjdNqUi+YS3I98GaW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="5134709"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="5134709"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 12:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="10302573"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 12:41:18 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 12:41:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 12:41:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 12:41:16 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 12:41:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sgj6gxLrn5XVusiLRYDG3AOqgrd7gNlr/XRfQSbsQdRJrXvegkFLlj/XOrPH2dYFeK2IN8EM1SMnqsEfNpK1nsszjQKzM5JYqk05dWeQbz2QsSFVUhciR3rNPbCfs3UfbV6XtEdzl89yHfIkpxtTdB86c7rEdg9kt4+CrlsdPPAvCcChBkTCJAIKlidRLtxl9AcJ2LpxUlWinuYltySkatrwdP35fKc5WP8NoMPjkoQ/3xmjztv5QRI6jutXZfMksx50nDKSjVAzQoULjZp8CBW5bv5hE95/A0r2Jxw2q0gagzCELFKKvC7I1m42jTXJzWqhusujdiom9tp34xvV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2A2qW+vzJTya8lliuHYdyq62hoO8hKYkupfBL4j25E=;
 b=V/O/TFnM/6orEgwE91P/HrA76G2NoWLokAneegj1iNWkQvhtcnFM07sXl3Cz7Lm4u/QzKBxmJz+VfdSO1V5TTWxb1o7Fnnb/EGu9CPSFAo9XSskGKumPKJSPK0fo/KHPzBEL0xpvmJBO2/wqzI/vsgQWYNhXI5PkDT7u9y0l1ZHTjo1ZErYSO1D1rzpF/eUC/tInJSTeIoCUAZgprUgrMbpRF/BDzVkOcKiH+Zw1h8gJsFSHla3q8Vnzw/JoXaqPNsT/GgFYi79XowP2c9Q941debRWoUefg7kzCsS/a4czzgx4jmaR5R9laaqwPd4qQ/ChYEud7cMIV0YGuXhmR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7377.namprd11.prod.outlook.com (2603:10b6:208:433::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9; Thu, 7 Mar
 2024 20:41:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.006; Thu, 7 Mar 2024
 20:41:12 +0000
Message-ID: <1d3e8b68-28fa-419b-b129-0c39df34f718@intel.com>
Date: Thu, 7 Mar 2024 12:41:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Peter Newman <peternewman@google.com>, <babu.moger@amd.com>
CC: James Morse <james.morse@arm.com>, <corbet@lwn.net>,
	<fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <paulmck@kernel.org>, <rdunlap@infradead.org>,
	<tj@kernel.org>, <peterz@infradead.org>, <yanjiewtw@gmail.com>,
	<kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>, <seanjc@google.com>,
	<jmattson@google.com>, <leitao@debian.org>, <jpoimboe@kernel.org>,
	<rick.p.edgecombe@intel.com>, <kirill.shutemov@linux.intel.com>,
	<jithu.joseph@intel.com>, <kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
 <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
 <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
 <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com>
 <11487a31-908e-d474-50c6-65617d417deb@amd.com>
 <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com>
 <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com>
 <1f366890-d9ff-4ac4-9af9-1ea3128a87fc@intel.com>
 <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com>
 <CALPaoCi=PCWr6U5zYtFPmyaFHU_iqZtZL-LaHC2mYxbETXk3ig@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCi=PCWr6U5zYtFPmyaFHU_iqZtZL-LaHC2mYxbETXk3ig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0287.namprd04.prod.outlook.com
 (2603:10b6:303:89::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa3ec98-33b5-4eeb-32f5-08dc3ee6ed1e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONv1yZ/EjHak1b0b1MwtSwkNHMT5KM/hFF266o46Me1UthKQYKG30OLAvWF2ltRkNAOjf4nLYxctje4pWG4p1aAPunukSgdRJHXaOk5GhbjdOnRD2JY+2Ex0AEZmbsXn0Dii8LoRnMAVwhlyWzsWa5+l30+KKjRkA68c7lqpH5RkiB3vR5JQH0quDk/C3o1Flmo5RW4NC9Qc74b+Sm9n8ZbpX1RWe0da5vyReLwKBJ16m0wIeUbhF2U578rPYG7hV+cYF6tAmnJL4UQsBVEeFAt05pG+WCAm/HpPLjpf5Hv3TrSUteuXjKrLo8mcZg2BQlY8XwcsN0CGRa+/XmW7Fsj13iEPpQscskQRTHu/WhZZNK0jGTkcWB/tn2mjecteZGNGbELIiEvvgvtKELM4cAcA2yulrC/ejymyyEWWYEonEP6I0wdAeL/ofILQlEkNqoO3a4AEA5efwoqB9+xW9pPem9rOREWKt20/Mtgv+tTq/rZDRbKiLLTfyQ0MBkVIcMhJ8o1hpZhH11mo5AWbeGgqk05rg86iouB3xvqpcbJIfwZqNVSqqWiZpaBcq7QYj0rJzIZBYosCVkWH0sHFsIsVVhRD7+Sb1OIFJbrdn5GuaFUUqTOU3P64OXTEite9VisQFzmchblI62e0eP2A9+fha13mE+y99tCCVMEYw5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0hsaUo1VFhFb1NYUTNtMlZEeUgwYkdMbnVoTWRPTHlrTVdPQlhIUDVrc2RC?=
 =?utf-8?B?bit0bkRxLzd4MkZXZzRCUEhLTm9kb0xoVDdiNUdzZkN5L1Boc0dyWGdyQ3BH?=
 =?utf-8?B?Z2xZVlV6ZlFNNGhSM1JSUm94M2RxMk1LUEh2MGszT05iVEZQZnU1dEVYcm52?=
 =?utf-8?B?cUZwU1h1dDhuZXVkbTRDZEd0aXFwbHZ3Ymd1NTk4WFNSYzBwcFZuOXg2RDRl?=
 =?utf-8?B?UmcrVVRFSEJwYWdxZWF3OVBveTRPdk16U3hmRUcyQk1tc2dIaWxXR3V6clFE?=
 =?utf-8?B?ZTAwUWp2TjRIcER6VDYzR0JkWDBhak5SbkNoK0dPNVRneTdPRVRJZDVDOVpM?=
 =?utf-8?B?RXhBN0YzWFREYzl1U1NlckkrWm5ucFhXTlpQNTkxbGM3VkJxVmVYcTBRTTFn?=
 =?utf-8?B?eGd5eDZCajNoNWlnQ3pWK2pYMGJ4Q1RrVzVXbnRQbzNZWVEyUzJSbHVNTmxY?=
 =?utf-8?B?TzF5UnF1QlFkSTUyLzdwRnY0Mk0rck9JZm9zdEVWcmtCQ1RKNTZxQWZobUtQ?=
 =?utf-8?B?V2FmYzhPeS9Hcjd6Sm00ZVVZQ0JvdUp4TDdPajVMWUtldG5xb1Iyc2gxWUtK?=
 =?utf-8?B?NkZjbmtiNFZRTmtURFo0Tm9menVENlpMdEZ2UTlobDFLa3FjaUJYSEZQQy9t?=
 =?utf-8?B?dWNJa3dzRzJ6ZEJmdUkwWDFwcWMxYVpwUkF3bi9wdUFxVzA3cysvZ05IYlAv?=
 =?utf-8?B?YVpRMktqRmpTei9HaXpadWV5REZLUGxEU1IwckVQZ0lOZVY4WUZEQWpxaFZx?=
 =?utf-8?B?TDN1S2JicStvVlJIWTlaTTNlMEpFMWVBWHBzTTlmMmpoeC9iWEppQy9Zc3cx?=
 =?utf-8?B?ajV6UGp2TVJLNHJ3Z09vQXdTUnVWRmVFL0hQbzFTOWhFZStZQzFZMksydHBE?=
 =?utf-8?B?c1JMc1FibTVTcm81Qzc1NWFlRFhaaGNlREp3VjNvTER0RHNNcFgwRHRGeHFr?=
 =?utf-8?B?RXVSWTJDVmlCcHNXaXNaNU1xa2pBd3A4QVM1NDRvMVJSMXVBTTNMd0N4empk?=
 =?utf-8?B?elE4RlhYNE5IUVNSeG0wOEdLcVVSTFdzUE9YY25BSEhIajMvNTVKckkzN3Ez?=
 =?utf-8?B?UXE2cWJsZVZvUjhFUW9heHpsUEdNTC9LdmQrM29UZDNJb29KWnJEUjBXN1Na?=
 =?utf-8?B?bUVZTmpBLy9rNnE5QWpkTmlaTkZxMGdCOHd4eE4wT01lVzhOU0ZWK0FNaGM3?=
 =?utf-8?B?RzN2d3B2K0VuZ0kxaytzSVBYcmN2L2lpM3AzWHFnYVJnYmxYNGE2QTY3TDYz?=
 =?utf-8?B?Z3BlZHo4ZVY4UWNsS1p3TFRwNXZ6SFBkUklMb0JTN05XeEJvcUJJcHU2RmEy?=
 =?utf-8?B?ZThacnhQNEZEMThwREdSeElwR0haaURvYkM2ejltOE8zRmFsV3NVNkFPT2RR?=
 =?utf-8?B?ME9hVWJvY0dLenlGQUVBUkx2a3ZkOXZ0V2xWdHJTMDFyd2l5NHk3MWRwZVBS?=
 =?utf-8?B?ZlRzMFJ3VjczL1pjaFJpM0JBOG1HZTNrWERqaGVseWVjY1FkeVJlcUxndnFJ?=
 =?utf-8?B?STFLTXh1K2IyNU9LdHg0U2FSaTFsRi9ndjRlK3Z4ZkdTQlJEOTBROEFjcG5y?=
 =?utf-8?B?ckptZ0tCNWZibWVleFAxS3hiNXVSMm9iNkhWbTlJMWlCUHJxSjc3NGR0Qk1X?=
 =?utf-8?B?UDY5KzkzeU92ZEs5bUttMG5RTFh0aUJaYlYyREhIeTR6UkxwQW40eURoMkNY?=
 =?utf-8?B?b1dYS1lFNTFBRlZoUk9maENHblNYN2VzWXEzYngzZW8zZGF5UFFsSWRNTXhj?=
 =?utf-8?B?dkNJQ0RIUmNoWFlxTU5aMmdaYjNZQVVPMEF4NFUvNTlxSXY1K0I2S3Q2enNZ?=
 =?utf-8?B?TFlBTWtxbndZam9OUnlWK2ZZYVFOUWVEYzdMYW5GTWdjcG4wTnNvN2hpQklp?=
 =?utf-8?B?VlYyZTg4cWhNNWU2QlVycGxUQjQ0R0tyS28rOWdUL2VmeGxvK0k3M0JEMkJP?=
 =?utf-8?B?TWU2ejlKT2lqdy9OWExFQ0QydWxQSisyZWVmNXIyZm1LZzNzTUxaWTkrSTBS?=
 =?utf-8?B?bmQzbkMyWk9GNVFmTE9pUzA1Z3VZSGJPSjJsMktpRXVBV0FIcUpDT29CN0JY?=
 =?utf-8?B?a1NlZmk0ZldJZHMxbi9lRkJqR2RpTy9SY2dLT3hCbTZVc3dVZjV3amFrT3lu?=
 =?utf-8?B?VG9xVzVJQ0RDbjlzdjl2bjN3TTQxdXdpYVdkZDJWb2d0VWJFM200TlpRRHZt?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa3ec98-33b5-4eeb-32f5-08dc3ee6ed1e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 20:41:12.2932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDB3Dl1uEvDaXSgL0pT3pAdqQsWn7YDu8LcoIXTTQD3H9PmKV9bGoIlygwllRfNQIX1x8fvWB5tmSI3S8JXpaB8oa76a83IOZ+sdQV4VNX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7377
X-OriginatorOrg: intel.com

Hi Peter,

On 3/7/2024 10:57 AM, Peter Newman wrote:
> Hi Babu,
> 
> On Mon, Mar 4, 2024 at 2:24 PM Moger, Babu <bmoger@amd.com> wrote:
>> Based on our discussion, I am listing few examples here. Let me know if
>> I missed something.
>>
>>    mount  -t resctrl resctrl /sys/fs/resctrl/
>>
>> 1. Assign both local and total counters to default group on domain 0 and 1.
>>     $echo "//00=lt;01=lt" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>     //00=lt;01=lt
>>
>> 2. Assign a total event to mon group inside the default group for both
>> domain 0 and 1.
>>
>>     $mkdir /sys/fs/resctrl/mon_groups/mon_a
>>     $echo "/mon_a/00+t;01+t" >
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>     //00=lt;01=lt
>>     /mon_a/00=t;01=t
>>
>> 3. Assign a local event to non-default control mon group both domain 0
>> and 1.
>>     $mkdir /sys/fs/resctrl/ctrl_a
>>     $echo "/ctrl_a/00=l;01=l"  >
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>     //00=lt;01=lt
>>     /mon_a/00=t;01=t
>>     /ctrl_a/00=l;01=l
>>
>> 4. Assign a both counters to mon group inside another control
>> group(non-default).
>>     $mkdir /sys/fs/resctrl/ctrl_a/mon_ab/
>>     $echo "ctrl_a/mon_ab/00=lt;01=lt" >
>> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_contro
>>
>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>     //00=lt;01=lt
>>     /mon_a/00=t;01=t
>>     /ctrl_a/00=l;01=l
>>     ctrl_a/mon_ab/00=lt;01=lt
>>
>> 5. Unassign a counter to mon group inside another control
>> group(non-default).
>>     $echo "ctrl_a/mon_ab/00-l;01-l" >
>> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>>
>>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>    //00=lt;01=lt
>>    /mon_a/00=t;01=t
>>    /ctrl_a/00=l;01=l
>>    ctrl_a/mon_ab/00=t;01=t
>>
>> 6. Unassign all the counters on a specific group.
>>     $echo "ctrl_a/mon_ab/00=_" >
>> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>>
>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>     //00=lt;01=lt
>>     /mon_a/00=t;01=t
>>     /ctrl_a/00=l;01=l
>>     ctrl_a/mon_ab/00=_;01=_
> 
> The use case I'm interested in is iterating 32 counters over 256
> groups[1]. If it's not possible to reassign 32 counters in a single
> write system call, with just one IPI per domain per batch reassignment
> operation, then I don't see any advantage over the original proposal
> with the assignment control file in every group directory. We already
> had fine-grained control placing assign/unassign nodes throughout the
> directory hierarchy, with the scope implicit in the directory
> location.

The intent of this interface is to support modification of several
groups with a single write. These examples only show impact to a single
group at a time, but multiple groups can be modified by separating
configurations with a "\n". I believe Babu was planning to add some
of these examples in his next iteration since it is not obvious yet.

> 
> The interface I proposed in [1] aims to reduce the per-domain IPIs by
> a factor of the number of counters, rather than sending off 2 rounds
> of IPIs to each domain for each monitoring group.

I understood the proposed interface appeared to focus on one use case
while the goal is to find an interface to support all requirements. 
With this proposed interface it it possible to make large scale changes
with a single sysfs write.

Reinette

