Return-Path: <linux-kernel+bounces-141419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 747738A1E06
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2669528E8D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1962D12FF80;
	Thu, 11 Apr 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDnQQklz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833EC17C66
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857277; cv=fail; b=Yb1a54hKbsOTBcKK82kSqxGXmVNmSlEVxdeQ27Mxv4/O/fIuTLIKve++yfBClNhlxqSKCuQP8wD8fE0wZWyLit1Z7AVg2WLeXO2a2TSLWcjhxu4S4DyNp4utcaSIAalegU8bhMXrgVzVyZ11HZTfJlmEypobMF1BDF3ykTm7axg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857277; c=relaxed/simple;
	bh=LXgCvAVAeSDvCE68407lSbl1gGgFWeN/gHQpztesHxo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DAmd/WFnG/CvsZoJvh1Y2Jpzfd3p3mXo4SIPDYPvQv5PVEFxkNojPmGvWhzQjHLlIHdPUypswOCJVczvVKC22OOMk9vd3QFdKrlUGqrVRWKeG+oe7W5CNS4A2etZAO0YOQJOXNW9ZMPge9XfC0nK35mgYZ4Qfd984R1xaexZ/M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDnQQklz; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712857275; x=1744393275;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LXgCvAVAeSDvCE68407lSbl1gGgFWeN/gHQpztesHxo=;
  b=mDnQQklzmp366EOe4WkqUGYrEsIpUkHOPPurBGK6LaTcKlKngJC0f7JO
   3iE7JuC7eByQCrDQO/+UylUiVcNxgHhjCEB2BTgZhOfiqx6BC3+oi/D5m
   ZOAUBnJXrIow/IWiZHts+K24qqHrcVstLCCrEHBzECannvmhv6P1BbQoi
   Pcj2fO9+EIpEsXSTptQG10lXIgath4PYtcddhZIw0QwjwnAmY0Mq0/FmL
   bXyuRoO+FB13ZxUq8utRjdVPfMxqqAeBzEuPExZYF8mZmIfmcvHdHtyUF
   ZrxaraCSwwIx1MqKWu3AOKrS+0LpeVkF1zPk8o65X72mq+rV6Yb3JLVHz
   g==;
X-CSE-ConnectionGUID: Ezwyq933REKElpPuuckNcg==
X-CSE-MsgGUID: A8hcBtm7TgC/+ZB9GRgtzw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8204717"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8204717"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:41:14 -0700
X-CSE-ConnectionGUID: w65EA/MOSaOxArOBOT05sA==
X-CSE-MsgGUID: /+Z/dbfcRIKHbkGPWBlLCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="21455820"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 10:41:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:41:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 10:41:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:41:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaI/IXv/Oi3zOE28slg/42L0jt2/1crOo2oa5cki4YeJaabTkDzRBwnnHCpc2og/w0pr3DrwkA7Y2So3ilyWTFxeLkfv2ekxO/v2Q36KdyiQCcSzCv47jtkGcccqz/eQXMW25h25yLl6n7XcoFYk+LLmLlVk28OxmV7eG1pWubmSKq6334l3WQBgHQ00GcjEQXhKtJHFMW85TK9QVPwRJb59e89VZGpQVXVFbrY393+WCUeDQ2tZKm8ry+OqwO8txBxfV4WZCCXjzfMrbLJfJj5QHxbogi0fN3rc7dpHISbnCmJ49wLXqOKj9sYcb2Z8/9WQ4+4GVvX9i3sdFtgHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYBzpMbgzzXKh2spm9zAUotbQ5R9/Gajdh+ooFnfCKc=;
 b=og8z7dq3tt4lIY52SFud9kWHMc61AtxiX6EcA3H+Ee2TCjW4+n7zQNqGdBTPmYA4g5VfrNImniDybBGKL4553x9TMQrgtoLRRsLySjm2mDsIfarusvQDC3NDNMu0Swknd5lZ0MV8gA0S0BX4t24SWa9Mgj2exxItQ+aPsqu8J5BbzOIAB7WoWV4OXEOuPKKoDMS7L+5YfUnNvdoh5QMqffm3/VqCDx7Lj+Z29bBc+0sNioy7dnCSXIcE0ZKixVHjtpcYmIp2HTstr78WR3TB5jhNG+F+W0BmDGnTtCxPy6o0zfebBXJ6FheJ+oM4gmRWYl9x0HqkXoQjuG3DVTjiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7823.namprd11.prod.outlook.com (2603:10b6:208:3f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 17:41:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 17:41:10 +0000
Message-ID: <e3304a27-0c2c-4981-ae4c-01540c180628@intel.com>
Date: Thu, 11 Apr 2024 10:41:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 24/31] x86/resctrl: Move get_config_index() to a header
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-25-james.morse@arm.com>
 <bfc39b79-b3bf-4187-ba63-56db1ed6d565@intel.com>
 <Zhfy3goUX8kWM5Hn@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zhfy3goUX8kWM5Hn@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:303:83::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c60a39-c8ed-4f40-4f71-08dc5a4e92fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxhZSzUE5lR1AJ8Xjz9ruS1/l/NnepE45vnJI0kTYj74QNXuRT7gLAYCUATnCUj1r/e7zb97c9Ln2JkZP2sexkN9ierXJ70aol+gOj55e4fKi/oW1ZrzTY24/jcz9oKf3R30WcWjcmsTgLRibJ+joupnf9J4g0GZD7gkPFzM5QJNykqoW5s2uJwPJV0Zh4cqB1Fc9SgWiSJ+gle+ulH/IEmSKgO2ZynAtjT+iSdrbOLQljDOqsE/HReotkm0u1WczpNYJWjXYKAm7usCq0w2s9xRMxDJ7b9+5JNKdiPKtbw8KRy8LAxn93LUU1FxzN8hhmyN2ydVw9VbFJI6H/OWt+1edpOoicSj59WqPmeWki5K/oZwdl8oHJA8s3C2PQSgkrfewGpquWdtfkamWOLvlELpdJB5VKJ29dOfVmwSWz7luZhDmJuKm52S+NnPigQUBQ6ZcjsCBEUjpKM/J57G0mnD2OsdjN2PVmPChfs7rgQwVFdJUtvmDHW3MtUbv15uSPM4EJ7s18UUhn31LsI8RbxYL6pg9zIckAV0N12IpENJTHVSrWjuIP2xVkqpqABXA0ggPSymzO8miR0pz06vbbBtmwDsbC1YO5p9UaKU0PlPnYbezAl586nnqCOHsuqmm6mEAyPmKNAQSt+mkjM+pZm9Ouy1nOg3hfQ7vaKEezg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTZjWlltem1IbW9hMEFad3hOWmdYYVo3c2hPMlZEQ3hZN2szcVhHdkMxVkRX?=
 =?utf-8?B?Nk90RGt6NWFXOWVOc2NGOG1VdVhEdGNIb2l4UGgwblhCRkFiZHJRb0wrN0dP?=
 =?utf-8?B?Z3dhQmVLYnhQQzhrWERIa0FCb0pQa0lRV0FrTStUOERJSDBLTHZkaW9ZRFZs?=
 =?utf-8?B?YzYrNU1DMzc5ZnlpUG9EWEtTd2dSemFNc3hWajhJVUlTcFZiaisvV2ZtT0Ju?=
 =?utf-8?B?aE9oU0VKTEdIVzhUVTJiUGd2b0d4d1JHcTVhK0ZvODBoQk52YURIZ0FKcnlW?=
 =?utf-8?B?OGdZTG1kcEIwVmFJdVRkYk50dWEvTjBzb09kV3hWL3JQMjYzNzNpUWJUa25V?=
 =?utf-8?B?NTNHLzErWFE2aWVRcmRnYTBoeVRqNzBvM1U5Q1pEU2ZjdHpIQzZpZVVNbVB1?=
 =?utf-8?B?M3lkR1lrSkJxWm1mbkd3ZUFOc0NLRDE2SUN3UzlJa0VZTGFWTGc5ZXV1UFp1?=
 =?utf-8?B?K1JaTTBDeUFSdW9XZytZWUJDQlhVNjF1NzQwZnNVc0JNUTFGcTF6bER3Y05L?=
 =?utf-8?B?UGUzbEZKSEZmVmptYXg3eXB3SFVmVURFQ1NPNll5MU9JSmQzV2N4NnpFVXZa?=
 =?utf-8?B?VjJCL1kzUENWSWlueGFMYUlOczQyNkwzUVU3d2dMbVhyOGFaRWE3K1lNSTJt?=
 =?utf-8?B?SDdQSjFGV0tVT3JyVGFoK2hCNjB2eXczWU96L0lVL0pUb05ZV1c0c2xlMGp6?=
 =?utf-8?B?SU9lcWtPcmFGWWVMWDgzOCtWUXFMTE95ZTZYMEhKTHVML28wR04zL0ZOZFRm?=
 =?utf-8?B?YmlrVm52dUVPV2ZUYzdkUVJSTUo3NW55c0RDQkZGMWFHUHdiNTVmUDE3TEth?=
 =?utf-8?B?eHJoSFRKQ0ZTZXFpazhiN1lNTDNnQVphUzVaWnlTdDdrbVgzY3c0VXVUVmJz?=
 =?utf-8?B?R1VGZnRFNnc3dmpKU3pkRStWaXRCdi8rS0RhaVU4NGJPRlgwOVBTbStPVmVm?=
 =?utf-8?B?Y3FpSzdxWjBXdnluTFl3MTRlTStpRGVadVNMNnc2Qm9QU2RTMFRsc2xYRE9H?=
 =?utf-8?B?cFdtTXRuTEZmZVJlakQ5TkZMTWU1bjhySk9aSUVZeXpacjhCbk5ZSExYWUUx?=
 =?utf-8?B?U25wMGRzOTlrQ1E2MUNDWnk4UURUdzVNV25GMzJiZitZRlVRamdsYnNsb1Zj?=
 =?utf-8?B?ajNEZ20wYWE0VmNUT0NJRUlncmMreDE5bUpsdFVJd1ZFaC9rQXRkbnpMZGF0?=
 =?utf-8?B?WjFrNnZHUkdjK24xaXBWSEJyZVhPeGpRMzJYdUQwVlhyTkUreTkwQzkrNVE3?=
 =?utf-8?B?Zzl4Y2tmRFFkV2lEaGpkSGMzeXdLeFlmY1VWUHB0Q2pmQmt4RkhHTXEwWTZn?=
 =?utf-8?B?cGFLTkNRZVAyMytKeXd3MFVaS1l5U1NLU1lOMFE3Q2l1czl1T3NEM3NYN01D?=
 =?utf-8?B?a0xFTkY4eUdzTmRpMlk3QlcrblpzSU5pZkt2VnBSdzh0ZUVDMkRTTkFZcnBj?=
 =?utf-8?B?TGMzeTZiZmJldVpIZFFEM3dXN2FuQ0FzYmlFTXF6UGllQ3grMFlLRDB3bkZU?=
 =?utf-8?B?ck9yNHJRc0ZLTmJ2bThvRVNyY0FFVWF6K1BkTkdCbUw5UnhtVE92ZE5wbkRF?=
 =?utf-8?B?QWRiTDMvQnVWVE5TWXc2Y1JEQ1VSRVBWUkh2czRHejdzZ2ROb1lDQmJhSU9I?=
 =?utf-8?B?amV1djVlc0tIay9UaWpsbDgycWI4Z2s0QWlzK25WYTZZVnhXUTFRWEpKT0lX?=
 =?utf-8?B?NEtsVXc2RklOazAyTlA4YzJaWHZzek9nb1pkNmdjMTFlaDNrVzd2by9rMHp2?=
 =?utf-8?B?cWdKNlVDTTdiMmxNTXVCOWduUG9vSGxJbmJGVWwzZmZpbGQwdnhMRjlPVTBV?=
 =?utf-8?B?bEtGUlJZOEVnRFdpeHhCcDVLaDBmTmc1Nmg4V1hBeEVPNjFnOTRzdVNYOFcr?=
 =?utf-8?B?R3k4VE4xUk9IU2UwZGE5eUprblQ5ZHRSUXVucmVqdHZBd3kvSEhiZTJha0Vj?=
 =?utf-8?B?TE5QRE5BWEdib1lkQ3Q4WGhuenJwQVVvemFjemJoMnZ6NmJ6UVk1enZTaUhC?=
 =?utf-8?B?eWNwMGt4S0U0UW9ocEJOZnpnMjFyenlKbkpHalgvKzBtaUFmbUZxYVhNVXFu?=
 =?utf-8?B?RUd4MnFyTlhOZnVnQjVESGlmZWtRdE1mTjdTVUJpM0dJTURwLzB2Zm1wOUM4?=
 =?utf-8?B?UDVaQjREb2RCbWQ3dktNVlp5c05XN0JzNnB0Ukl0ZmVTWXNhMTg1dGxvZHYz?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c60a39-c8ed-4f40-4f71-08dc5a4e92fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:41:10.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+0+CpdgMrEoxXe2IZGruWXwpGrluNOc8ERFJ2fXM2beV2a9ddu/Y6J5C9m9kEaDIvR7ZTzT/1yN8lEs7jwdKUdkNAb/2rXFIMWlXuaKt8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7823
X-OriginatorOrg: intel.com

Hi Dave,

On 4/11/2024 7:25 AM, Dave Martin wrote:
> On Mon, Apr 08, 2024 at 08:25:26PM -0700, Reinette Chatre wrote:
>> Hi James,
>>
>> On 3/21/2024 9:50 AM, James Morse wrote:
>>> get_config_index() is used by the architecture specific code to map a
>>> CLOSID+type pair to an index in the configuration arrays.
>>>
>>> MPAM needs to do this too to preserve the ABI to user-space, there is
>>> no reason to do it differently.
>>>
>>> Move the helper to a header file.
>>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> ---
>>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 +++----------------
>>>  include/linux/resctrl.h                   | 15 +++++++++++++++
>>>  2 files changed, 18 insertions(+), 16 deletions(-)
> 
> [...]
> 
>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>> index 3de5bc63ace0..73c111963433 100644
>>> --- a/include/linux/resctrl.h
>>> +++ b/include/linux/resctrl.h
>>> @@ -258,6 +258,21 @@ bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
>>>  void resctrl_arch_mon_event_config_write(void *info);
>>>  void resctrl_arch_mon_event_config_read(void *info);
>>>  
>>> +/* For use by arch code to remap resctrl's smaller CDP CLOSID range */
>>> +static inline u32 resctrl_get_config_index(u32 closid,
>>> +					   enum resctrl_conf_type type)
>>> +{
>>> +	switch (type) {
>>> +	default:
>>> +	case CDP_NONE:
>>> +		return closid;
>>> +	case CDP_CODE:
>>> +			return (closid * 2) + 1;
>>> +	case CDP_DATA:
>>> +			return (closid * 2);
>>> +	}
>>> +}
>>
>> (please check the tabs)
> 
> Noted.  I also see that redundant parentheses seem spuriously added
> compared with the original version of this moved code.  I can make a
> note to drop them if you prefer.
> 
>> This change is unexpected to me. Could you please elaborate how
>> MPAM's variant of CDP works?
>>
>> Thank you very much.
>>
>> Reinette
> 
> Note: I haven't discussed this specifically with James, so the following
> is my best guess at the rationale...  With that in mind:
> 
> For MPAM, CDP isn't a special mode; instead, the PARTIDs for
> instructions and data are always configured independently in the CPU.
> If resctrl is not configured for CDP, we simply program the same PARTID
> value both for instructions and data on task switch.
> 
> For a given resctrl control group we could pick two random unrelated
> PARTIDs, but there seems to be no advantage in doing that since resctrl
> enables cdp globally or not, and we would require more effort to
> translate resctrl closids to PARTIDs if we didn't pair the IDs up
> systematically.
> 
> (See [1], [2] in James' snapshot, which illustrate how he proposes
> to do it.)
> 
> 
> So, we may as well stick with the same scheme already established for
> x86: nothing forces us to do that, but it looks simpler than the
> alternatives.  I think that's the idea, anyway.
> 
> Then, if the same scheme is used by multiple arches (and 100% of the
> arches currently known to resctrl), it probably makes sense to share the
> definition of the mapping at least as a default for arches that don't
> have their own different ways of doing it.
> 
> Does this make sense?

It does, thank you very much.

> 
> I can recommend adding some of this rationale to the commit message
> if it helps (and assuming I'm right!)

Sounds good, thank you.

Reinette

