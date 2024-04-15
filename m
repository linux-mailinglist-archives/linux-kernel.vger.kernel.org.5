Return-Path: <linux-kernel+bounces-145676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D978A5963
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97BEA1C20F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A1E129A6B;
	Mon, 15 Apr 2024 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/fauk66"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335A1E877
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713203116; cv=fail; b=qKNChXt5omCplKnEmjdR81BYApNMNYAZhJ7TeRl2Tl2tMnrVQhtBb34+vdpZgDERprmQ5KbiegQ0d8UtvH4cy8onpDfSJiSv4lFv3buBD8ynLq/DUoZsyHb1EYwtgl5wxJoW/Itlj9s7qTW8/Tf5HsbXR8y4U5sNt91KFdl4ass=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713203116; c=relaxed/simple;
	bh=wSXGZQXClicu5fWp8dunIsngRK2xJM7JxAzPRqHTP8o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uZJKuxcHMUjZqHmF13K/e+rEzb4pue9DyniqZldEEHs+mGZq78ItIYRDU1JQLG3nxXNJehr5FuJxVuTyNC0/5mahDKtnCgW2W+rUMfraOKKpCfPvpVELFq7TfeY+1gawvZELSHtwTpbDeqhyQ962Ti1gJoNT9rFMSqVzdhfQHS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/fauk66; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713203114; x=1744739114;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wSXGZQXClicu5fWp8dunIsngRK2xJM7JxAzPRqHTP8o=;
  b=j/fauk66/GebsgWNARtBTnl0cv4OhcGIUd3hxYDux3fLItpQDWSHz+ve
   U/8T8LA0QS9+pK/cEdd7u6nva1HVADAyYLmE7b+UhxMMXQY8ySil++RMP
   pE+gOuhlr/chDlagiWvMJalo/p4hqxyLYTAda7USKVaxobM18qiPw53zL
   TML3NTJ79pse5m1s+qdLpgR5hltFZtUKyhQ/01w4Edyy4JWV0714HxtSh
   k4ML2RSakGrxpmThT1kmz9yfnqfQXMiiopvPH8NDC/VefmqYnVba59XXI
   GLCl8NUPOUcOqrOGsGn97aNJR+7f04OC706qnc2zkXbrc4eub9jF7Pgmc
   A==;
X-CSE-ConnectionGUID: saU8D2x1QcSdCnO0CXyKXg==
X-CSE-MsgGUID: qjJFSouRSri5vhBryEhzZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="20029527"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="20029527"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 10:45:14 -0700
X-CSE-ConnectionGUID: njr2BpaLTlaTUusPq9JuGQ==
X-CSE-MsgGUID: LUrksYVYTnaX37RiaHEHtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="26654182"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 10:45:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 10:45:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 10:45:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 10:45:12 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 10:45:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qgli26L3E/j2K0KLyu33hsz2PiLiSTypl3EaRQh9DNx1ib+OwJyALPvG+/vtTQcRj+0qKNzWrnNaG7Xi0qi3bMG25CfmVzxKlB6paAGD3SpjnHHPerA1ExML/6yn05fGWUasZv0V23vPAZ9mtK5rgHYAj36HbSBYtHgBF9UhxUO+XXc8G4UlB+fWN8xnNinR2t3vOmIyiCDM86KFR9rZYvWtIb7bH+/Uf4FHYb3aTepxezCT+Lc86cwj9kAfO7nI79fm+mgOx2lKdAGnEqDcHxu1dzfYpbC642EXMlWJnp8P2wYfMj60mT3rSq+dU3WMIy8ZSQJ1F3mHPndpIaxrJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDQeThcUKWp5Am628xwW4Htc3GhoQa6eHyyqB1QFGu8=;
 b=XLbHB5J/rLDuNPqZbVOt6hz8Vw2YZBVOcuSa+WNkmZOint4OuO0DLm8Qu+pXA/fKpREOpPHQjQ+UqjXYhZXIzo7NXeF7XWwAY97dkPhvn1mIMqBN73AWZyHIYBDutxMNbIC8j+xkLwmtvO9g9z2DODHh+Lt//M0N9fCSk4xg6EEWTK6EHGVaUiqsg8XBYdREn9Ze92lbKRYXkedMxK4DbJmoYrVkaSU433oZypgw2s8hEBJMcA/i1Xeuo1x8LtPSGgSWa+AVJIA0Nm6r/zto2VyuksJtoR8v6NvXEAh8dPbF7zDpV0Yn0ciP0sj2M7UTHjUFAeIgREjba71zTvvyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6320.namprd11.prod.outlook.com (2603:10b6:930:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27; Mon, 15 Apr
 2024 17:45:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 17:45:09 +0000
Message-ID: <6469d1c9-f535-45e8-91b7-992175cf4697@intel.com>
Date: Mon, 15 Apr 2024 10:45:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/31] x86/resctrl: Add helper for setting CPU default
 properties
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
 <20240321165106.31602-5-james.morse@arm.com>
 <c8d1f4ec-eb38-4846-a6ae-722e39ab75f9@intel.com>
 <Zhldk3XV/g/ZZfO5@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zhldk3XV/g/ZZfO5@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0161.namprd04.prod.outlook.com
 (2603:10b6:303:85::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: b187c68e-b6e3-49d9-77c9-08dc5d73cb74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqgB4SlTTnUrQJPb7xduedfOMGsdJJFGPGJcVf1CjANFjdp1o9A7wzzKCcs331EixTrqfwAPkz2XTZhZ5O/56rK8lmrbxbgmI9jNa+7twdHEr503EytP1sXRb7q4N2oNE6oorgUth7QhpHgpeqoIxFTW1SQ9l8Nehf0ClN3y4QW8Lp1P6k/3reOhaHsi4rPjHSxMSTD7Hbcr2I8XiVMfdBubeV4bXuMiHvqbdAqYF/0b4xBvFM/91tAe5i/N7Vn7QF2mvngPSjM6pXDCc9LfAg5sxXmPVOBIpjiXGXfKFgl6pFAuQPl5280pV5z7OdG2v95dO/h5suNobRoekq+Eat2HVXqvQ2CV5iIPZkm1orxoyL/bcvvug7XTJDEp2LtL9VW9TwyXR5DLqQUKnojVOMIuxXNnxIK+SbyE/vkikmGvUVZqlnxGvTwKUoXlx8mbT4lIcMMUz4PSXHexGDWxqsfi0ymULNxsCn8TDAUM862WljPqhv7bQTz7+ikFLX0GysGpYWfqwuFrQYRIJSQE9Xpg/pfsZUeRU/rNQBfKowny7mueCMhxYCKIB8D4LsOWCmQfy/zpe2746DjPy1xTO57xKaWHYH6Jyz3Amr/dDNZb/w+qG6ylvL1LG41XSF7ezlV3iBSTK+gtrmG+9Nvi/KhffGhN/aiBNCB+0/5BQs0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clducEQ3eVhaSnJkOU5WR1JxTjR3ald1dTc5MWV2U0RhckZCUzF3ajB4clBZ?=
 =?utf-8?B?QVlkM0NFM25tMVdIVnpjem1iVGU3SlVHNVg2aWZHbkRNOE9XZHlCbjU0cXlh?=
 =?utf-8?B?OFU5T2RSNHhuOStOVzJzZngzRW9RQUtoUWNodVhaTnUxbzJCQzNHSU5FOVM1?=
 =?utf-8?B?QW1CZWhwQmdaTGttZGZqVFBCUmo4TG9NeERwNDArbExLSWhqTEVvTGlZTlUv?=
 =?utf-8?B?TTJFTDRxVVh4WHdtYXo4V3F3SVZxNWhHbnpjYU1MUHBqYS85bitXL2dScDNq?=
 =?utf-8?B?SFZWWWloN1pGdkEveVEwUDdGTUh5UHl4SjZYSlB1NUVoRGMwMyt2UWExVGlE?=
 =?utf-8?B?Mk5NK3JNS0xVVDFCNUZBRFNuQkcyb1BjSWhWK0ZjejUzU2IrbEJxQ2s3YlFN?=
 =?utf-8?B?dkdKcFlkaWlpRlJOY3p2K1UxbEdta0l1NU5yWEkvWWJWQjdOKzBUcnEyK2NB?=
 =?utf-8?B?dmZ2ZjhTeVRVMktWbjUwNklkMzVGMnVLeDVuOVJBcXEyd1FLU1pueG5vQnFr?=
 =?utf-8?B?U3JxRHc1TkptelhHekpuRzFCQmxpTzZrY0RWdkVqc29YV1pkR1ZrMXJRdEVB?=
 =?utf-8?B?N3VHTE5IVkhHQ3ZmencwbzByZmNFb3VJRlp0cmZxS1NKTzA3V0ZPR1pEbC9o?=
 =?utf-8?B?aHhFeWhSVnd4SkxTYmZzeDgwbTlkWVRpZ3MxWjQ1bE5HU0xtRXJMVnk1NW5U?=
 =?utf-8?B?YkVLTXpnVEx2Rm96QThYL2NwNm5XNnNhZjhUYWMwanJ6Uzg1VkRDejIrSEtF?=
 =?utf-8?B?cldMN1F0d3dGcHgva2FmdFBmMVpUMnBCNVEvcjZvVGVCd0grSFdaQmcvaEZ4?=
 =?utf-8?B?KzU0aWZpV1c2S1ZSMnEyY0pEZmFnajlnZTh6SzZONW1lc2xyYlYzazgxd0p4?=
 =?utf-8?B?UG1HeHMyZzVqbDl3aFVkMGp4MjlURjlvQk8zL0dpR0tWRzJNU0U5Q0pQM1dZ?=
 =?utf-8?B?clExUjJlVDJ2d2tJU2F5WlhGakQwdk9ZeTJFSTlacytaWVRvY0hMeVlxa1p5?=
 =?utf-8?B?Slp2a0ZlTzZMR0ZlTmx6Z0xQeGUzMExLUDVWSW5md1Ura1c5TzVmaDlmcE04?=
 =?utf-8?B?MFZZWDhnTXhaaDJYUjlkM3RSbGdTS1Y0Y0VDTTRTVnhkWVNTbFQrUUVlTUhj?=
 =?utf-8?B?eTlWdkJVZC8zV3hlOFRraTlBMG5LWi9INEpVU1pMSlJUK3JzeTQ5ZGV6Z2F2?=
 =?utf-8?B?L1R1WUtEZ3k3bVpJYjFTRnhwNWJVSEhXQWtMQk9PS3BNQU5KdVNxa3hzUkpi?=
 =?utf-8?B?RnJFbU43Y0tXai9odU9zUzNDcDdwRHRGWCt6eEczakZXNXJuV3BKVGYrMTdj?=
 =?utf-8?B?VERDTnVyY3VuUmtzSHk0TWphUWZDbzJhV3RWYkRFMStmUnM0SkFUOXRYZXFM?=
 =?utf-8?B?SG5ORkZ4ek1OSm1nc1VSQzNOeS91ZTQzdVJrRWNKMkw0RnIyNXo2Wkc3Nk53?=
 =?utf-8?B?MEtOdFllanNvYnptU0pHVHMvVWordjhwZTBzVEV2NFV2TnNmVHFNNGhtaW5E?=
 =?utf-8?B?T015Y2FIWjlDeVhab2JxSExkdXVBQkZaK3c4QXhIbmY4RkwwUW9uR1MwdmRK?=
 =?utf-8?B?aGN3U2Eyd3ZnM0o4TG9OM1NSSmxTTXR0clNFQ0Y5Z1dTNi82dFd4VU9JQS9O?=
 =?utf-8?B?YmZHdEdsOEpkUWI5S3Q1MWNQTGtWUlNydjYxRzRDWWM0Q0NsTTl3T0dKejR6?=
 =?utf-8?B?ZzdFbEhKWlR6L3pvR095eW9lZmZtZjRYOFV2N25OYm9yQlhQL3V4SlNKNno2?=
 =?utf-8?B?M29BSDVFSXQ2SWpWRW1ueEpWYjBJbWZQanFEaU9TQmpCcXh3N0VKNmkxZnAv?=
 =?utf-8?B?ZzBtYk1OclJpZHFZMjArSmNDaTdqZEVxYmRkODN6djVoMWpVWlU1UmNXb2Rl?=
 =?utf-8?B?aWtuSitSM29Ba3VkLzB2NExkd3JseWtDRmlLcWV4ZjIxbk1nekphaVFNUEZE?=
 =?utf-8?B?R0F6ZFpvZXd0WXhaaEszKzliY2M3UUVkZnVBcUViL3IwMm5PYWZkcERPMjFw?=
 =?utf-8?B?M280QjhBeEdaUmtyTjlTZTJTOVBxbXRscVo0Z1U2Wnk0VFl2SWJRV3dwZktr?=
 =?utf-8?B?VC85djU5Uk9zQXNXS2ZjTW9ndEVVdUp1bmtycVdETW01alBCRXV0ZEZqVFFy?=
 =?utf-8?B?YkovR2ZzQ2I3L1JhZ05wdXFjcUpYdVh5TlBZczNySExjdW5MWXJEYTNVVC9j?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b187c68e-b6e3-49d9-77c9-08dc5d73cb74
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 17:45:09.6950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBQyEJhKA6EOnIcysrM1ya1WQwWcrrcG1XhEeTcD2wa5Mg/95hGOXIHpXN7hxBpIO7GNPCml9jAOVx7vdE9QyJFnrvF/EdY17xV6gvdobcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6320
X-OriginatorOrg: intel.com

Hi Dave,

On 4/12/2024 9:13 AM, Dave Martin wrote:
> On Mon, Apr 08, 2024 at 08:15:03PM -0700, Reinette Chatre wrote:
>> Hi James,
>>
>> On 3/21/2024 9:50 AM, James Morse wrote:
>>
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -3623,14 +3623,18 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
>>>  static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>>>  {
>>>  	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
>>> +	u32 closid, rmid;
>>>  	int cpu;
>>>  
>>>  	/* Give any tasks back to the parent group */
>>>  	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
>>>  
>>>  	/* Update per cpu rmid of the moved CPUs first */
>>> +	closid = rdtgrp->closid;
>>> +	rmid = prdtgrp->mon.rmid;
>>>  	for_each_cpu(cpu, &rdtgrp->cpu_mask)
>>> -		per_cpu(pqr_state.default_rmid, cpu) = prdtgrp->mon.rmid;
>>> +		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
>>> +
>>
>> While I understand that the CLOSIDs are the same, I do think it looks unexpected
>> for the CLOSID to be set to the CLOSID of the group being removed. Could this
>> be set to CLOSID of parent group instead?
>>
>> Reinette
> 
> That seems reasonable.  How about something like this?
> 
> -	closid = rdtgrp->closid;
> +	closid = prdtgrp->closid; /* no change, but the arch code needs it */

Looks good. If the comment stays, please do replace the tail comment with a
freestanding comment (for reference you can search for "No tail comments"
in Documentation/process/maintainer-tip.rst). 

Thank you

Reinette



