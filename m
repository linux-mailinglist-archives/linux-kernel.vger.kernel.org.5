Return-Path: <linux-kernel+bounces-136200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2896289D101
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9477C1F256A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3446083CB0;
	Tue,  9 Apr 2024 03:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0/y17UR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1380C02
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633109; cv=fail; b=ignAwKGD060LoXfkuH/wpzsmhK7IKIC8qvl55JKUtgnFkQrapaJug26kStH+ZmQjykmyJ1Sa8CMJsNX+XvL+Et2Sv7S1Ucoly0NCTDWFTevOf4llPUjbkQ8qEYp7nzVWTHNYA2OkxcOa5sHiidu62lX+KqmiwRP8+dgCZ9/akGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633109; c=relaxed/simple;
	bh=HG3OHhjXMwf/eJSl/E3RjLpSKZ44CPqJVkB6dAnwWbw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A6yNJCVjAnr/MwUhJ4wcqFm80iQtNzLJmtwxn3zAMfhCRC8LrOZcZVTb48mZJC2cqa9nVZhzX8rn8aFOes9mC4zhPFx4OIbVbCn3g5bIqt0nuNNFqeAo1C52EIr/oku+NR1s18sXfu0JN8wihBgp5b4Wkveldv1N9kj+97zPscc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0/y17UR; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712633107; x=1744169107;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HG3OHhjXMwf/eJSl/E3RjLpSKZ44CPqJVkB6dAnwWbw=;
  b=h0/y17URN4tJVFtJTMWQ2DCLfqu6WSNMbTr2egL7tQ8EA/e3CngLZCNw
   +WH+bqGuwt60RylTuZNAafI6xlmc+z6J61YxVZU6DkKgXMPsYeiX20rL6
   jJKHOEAsF1rITn0NTJKQDKMMThifLNU2ARkk2wScacpRNKxaxXGv4KoC9
   TetzV8v6Ww0hb7pQzhUJwrVBbWmoBJZ6wMbE3dgmli+FC9eRWTRepUhpP
   guixlLyHYSWUsYjuel2Z5zWyc3am293sF5wnJe7XvznnDFQZw9kIMdYrr
   jc0yREW9Jsk9EpQq1hGDPnGZ/EZIF+MjgXR09eaZj2TU/iwcxEscXS7NB
   g==;
X-CSE-ConnectionGUID: P9bzH4LiTAKY7TtcURwpXQ==
X-CSE-MsgGUID: vwASfP7WSr26ENfWI2Z2Wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7847927"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7847927"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:25:07 -0700
X-CSE-ConnectionGUID: Hq80DG63TT2U+3wUgkAzlQ==
X-CSE-MsgGUID: WmQdiVxwT4qvJRsLsgXRbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24730451"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:25:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:25:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:25:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:25:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RecHi4g3xyicylcbucSIPfNT9yW0n30nf3KISCuuyaLC6tu83dnxLL7Qo9D0eCvASpw+60jZj8LGl3qBCvUnmiFjRJlYqfK0z8bAfpDcYbJur4Gnwn7tjfM7rQowejmCk2FfCBXaj7a38tsakXy9CigA/RN3zENfxQEd1RaMW2mUwuspck3yIOeqWO6kQ11erF9XQAxAkT7dYtEtHTI2aA7+ED1GQ52FGYecJXIe3KRUf8/Cgs0WRj8YFe+DD2E4t6t9lCZo6fFmV7KTRkipvdo05CItpbV0GII5YIL+s0XQZ9n206z3qZaoQrJbq9Is3FvEoCLQbXeYT8DTKo/lyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNDNxx0F+Cee/aYIRZbm1m6yhVLg9Z6asr3T93a8+7M=;
 b=KiRYzIsEtGjQNknQlphnmmE5OQk+Eq8TX05V7thHtg2L+QobSoWGTaPlBKTwvN19xovn5gyyYH2/BMBm/Pu5Yio/+lPhr+wcRuEjydx7s9lauN3N7bB9qbkNrRSsSSIGvkoibMBHSWnOuQlVxvIfnbPbCGKQHLDwZZEg1yKuERgTAaYsOmJCO1ju3vtgF1ny9kGnBZ30DsEg3xqky1TQzK0xv2fa7Tl2zXeEtMd0gDc3jsM/DdkmYVP0+2EIB8jozeIjFjnfMW9txdTrI+qlBvhMV/NyVQfjn7zeW0/2ljJLZn+IWXfs7YaSleLvpYRyWB21+Rf2v/VWDgWfm6SQRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7506.namprd11.prod.outlook.com (2603:10b6:8:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:24:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:24:57 +0000
Message-ID: <6589ae7b-95bb-4490-83ac-95904da7649f@intel.com>
Date: Mon, 8 Apr 2024 20:24:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 22/31] x86/resctrl: Make resctrl_arch_pseudo_lock_fn()
 take a plr
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-23-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-23-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0325.namprd04.prod.outlook.com
 (2603:10b6:303:82::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7506:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zf8khPhY74Oq10KqP9iKa/1bbYWeTR1a+1aHbLXI5FB7Uefp9vBmqsQD6MY0gR65kXlOBN9uAwey8kXdj57BJOv6RvFFrk9BbS7fUtQr+KXTzqMIPfkr5D7Wi9Yp/Qnq8K57yjVfgFya1BiGGOKRVeLiqf7g2mBAuhfDI98KTbR4SyypipVK2tqtJYEeOgQROciNsuX04PMqoBBJQDxBXSAc2iaL2PlagyyCrGfmWjqZJMots0qVsxeGU6dd38DhQXOxRxRTiUFJADHBhNjdjKdrzgYv+fXjrAqENqTbxWKwxVphwBprmeNknDwgLVicQko9fUXPyS03GW/seSYxmX5X55cdMj7+AZYqUJpXfawBsUqUbMqcdu6c40NOIMWNfY5i044kSBrPRncZeb2lsr/lV51IiFxBlXj8X3ZmXg6zLRXSPvIILz1QuYah2NRffx//EDMB6L1V6YW2t53jZeI7Oj+Pcg0S9tdiCxtbH+aAbfbqpgYH5wkYqDXZNFqx9h8nv9KUSMYf2uOXZfoZCkPcQg209LTIC4g2ZR62oV/u9BkRZv1yip7yUwFCngNdI34bZWscqVwzQSf2WXVz3b7se8crI+XQ8vPSbT7QCkV6uLMNg5jbvyOO2a3xfnbszXgfpG+zQAxQb2XK1aPWe26dE5MAMr/bjZ0T0SNztAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnZwWEtqa1YrVlZEQm9lamhQYTJvcG8zbmpRZTdKWUhKZ1lOZTR4dkRJWkN2?=
 =?utf-8?B?MEJxUkc5VW45Q0FWR3RHUTY3TmNsL1hnQ1pZM0xyYkpxNjhFVmo1TDFmc3o3?=
 =?utf-8?B?WHE3MjBsNnhpdm5ua2k3VCtxbXhGWWltOHk1UU5hU0NRSWVEeTBjVEVucXgr?=
 =?utf-8?B?bllyWndKTEdtcXhMUnVtK2Z2MmpOd3ZmRmt1dGZBQmpmRFNjR1l2dWp4aGhw?=
 =?utf-8?B?bVc1UzRCL0pmd21HZWs0OTlLdUUxLzFaSlgrZUxWWHBab0JCL2JnUklIU0h5?=
 =?utf-8?B?OTRhUkNqUkVqZk4yZ0o1OE9xSGRaeXhaQ0Q0UlI2ZkkyMHF6WUgrSFIzTFBv?=
 =?utf-8?B?TTBsWUtWc1hxSXVTMlMzNzdKVUpHVFBkS2ZLODF6TE52Vm1rSWlIc3NsY3Rj?=
 =?utf-8?B?dHJtZ3RwSEZkV2d1dVN1SmxvaUppZnNXaWREMFg2YnNCV0hFeXRTSTJLZ3h0?=
 =?utf-8?B?K2xUY2hGRXhwd1MvRTU0a0xTRk81NnN1RVNLNnNmRUtjRkRUWC9tQXRINnN6?=
 =?utf-8?B?cjdGRUZZUHZtYWcyWHUwMUJLNzQ4TXRhMkhMdWNHdGFmQWprdkQ2VkFiWEtI?=
 =?utf-8?B?RnF2UFQwejZiZjI2NE5aZlFkTnFEcG5rdzFtdjdpMTkyZzBPa2lCN2VqSlNV?=
 =?utf-8?B?c2JUaWw0STlzV0c1aHdTOXhycEFpL1dYd0pjdkhmUFJod0Mrei9QcU11VWdz?=
 =?utf-8?B?Sk9DN29ESEZEZ010MFFITWYxY1dudU9zM29kUVJ6cUZIMnhtQXRJbDVRNDVh?=
 =?utf-8?B?UFVWcjJENEFIaHRHWGVFTXhQQzZDS0FkMHpKeGhoQ29mNXVONFZIRVRpVjFX?=
 =?utf-8?B?SUNxMCthd2JnOUE1M2ZndDl1TFl5SDM1RVlZd1pTdFh2RkpkV1JGL0NtNEdS?=
 =?utf-8?B?dTRLM3NlSmprdHBOUWFtNmdVaVc4SGZxSFVuMHdGOHhENXVrZ0tIaTNVTnV4?=
 =?utf-8?B?ZGE5akZSZUlxU05qSlhKUjdzeFFUYlNvdXNUTnVPUEJ4ajAyaXNlRzhKYmJw?=
 =?utf-8?B?Vm5aUHNIYzBIanpGOWNhQmx5b2ZCZVd3OVNUUktyQzV1enQvdE9kQWNQRHhx?=
 =?utf-8?B?ZERwczNaaUoxR05FVmVlbUd3a0plMi9sdmNJbC9jWWE3TFQ1dHNJNmdpTXJ2?=
 =?utf-8?B?MFFaalFlcU5SMytFYVMyRFk0RXJBbWJsWlFxY1g5M0o2cjZhMTd5c2NRcTEr?=
 =?utf-8?B?Sk4rTzE4cUVtbWMvdWo3eStiMGFhT2pFazB0ZU5BbVJmbk1aR2o3ZlZnbkV2?=
 =?utf-8?B?UzRYQnYzZXp6amxaOHA5aThaQzJyQWV2ZGx1bWphZitDaWhMOG9MVkpXSmoy?=
 =?utf-8?B?YjJnRTJWVENBY3FMUVRBYWlVOFYyZUVPUUtrNTZsdW14SHFSWmhtZUpjaEFN?=
 =?utf-8?B?cmZlRmRlSE8rWW9iY3B6TVg0a0tQbEVsejJqZDRTd0trMnNuU0ExZE1WYUx6?=
 =?utf-8?B?YmFyejlmclc3ZVJBTnhPMldhY3N1bGgyejdDdVlOR1MrMytCTmJvaUQwMHNO?=
 =?utf-8?B?TVNIa29Eb3YxcDR0ZFVNbWRpUVVRRWpnQlJ0TGIyWkNrTnVkWW12OWFLVHlT?=
 =?utf-8?B?bm5OVTBJVXp6UUg1anZUMXpWak1pYXdVd0NlSWJoTXpNZFhubE00am9yUTBD?=
 =?utf-8?B?QlBGWG5FRGVmUmkxVFNsMTM0VFovS1AwaG50cjRYSVVXZzh2My93aXNjaWNm?=
 =?utf-8?B?NHc3WWRDb01ldm9BdUhkNVpNbkk4K09tSjhZQzByVGtXZFFCa0UwSmJCcDRR?=
 =?utf-8?B?YURuVTZxb0pMeHR0dG9aVGxBckYwWERLZFgvaDZINCt5eDFhL29ZSmg3NXNV?=
 =?utf-8?B?QVNMZzJxMWNYNVF1aG82NXdDZVdJRjh5UERXMGxrcXdJV0Vnb2VwaHBRelVT?=
 =?utf-8?B?R0IyTU8rcjR5TVU4SzN2OVFpamNtV1ZkQkVPWTl4Nzd1MVNleTBMUkVVeGFr?=
 =?utf-8?B?aWdXYkhsamFZMHJvWW9pMk53RVdQbHltUXRGNHRra281YmJoajBBak5ydHNZ?=
 =?utf-8?B?MlNvWWVDZ2tvenBOZ2hybTc4TXJWaXRqbEZEejJjbERvNDhIbmZPVlczbFA0?=
 =?utf-8?B?akZOcWNXa1gzSHgxQVlQR3psM012bTI2REdLQklCZWFMcGhXTzRyUCtPVFdG?=
 =?utf-8?B?dm02ZE4xNUxvbVZ2VzhYK0FhQWYxY0gya3ZKd2N3emdHWlROOW1XMmJ4YVpF?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 747e715a-f5b5-49cc-ffaa-08dc5844a19b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:24:57.3148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Gfp445oAzOD4fmZbU0hsOGeL0qn7UKSiLdG0seebtJ3Ldv+57iX89huq9PUKSNi5tJZISLYHaP3gG70ZlQgrnAFsc3aBW7pctBbfUDdmSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7506
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> resctrl_arch_pseudo_lock_fn() has architecture specific behaviour,
> and takes a struct rdtgroup as an argument.
> 
> After the filesystem code moves to /fs/, the definition of struct
> rdtgroup will not be available to the architecture code.
> 
> The only reason resctrl_arch_pseudo_lock_fn() wants the rdtgroup is
> for the CLOSID. Embed that in the pseudo_lock_region as a hw_closid,

Above creates expectation that the new member will be named hw_closid,
but that is not what the code does.

> and move the definition of struct pseudo_lock_region to resctrl.h.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

..

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 6705d7960dfd..3de5bc63ace0 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -25,6 +25,45 @@ int proc_resctrl_show(struct seq_file *m,
>  /* max value for struct rdt_domain's mbps_val */
>  #define MBA_MAX_MBPS   U32_MAX
>  
> +/**
> + * struct pseudo_lock_region - pseudo-lock region information
> + * @s:			Resctrl schema for the resource to which this
> + *			pseudo-locked region belongs
> + * @closid:		The closid that this pseudo-locked region uses
> + * @d:			RDT domain to which this pseudo-locked region
> + *			belongs
> + * @cbm:		bitmask of the pseudo-locked region
> + * @lock_thread_wq:	waitqueue used to wait on the pseudo-locking thread
> + *			completion
> + * @thread_done:	variable used by waitqueue to test if pseudo-locking
> + *			thread completed
> + * @cpu:		core associated with the cache on which the setup code
> + *			will be run
> + * @line_size:		size of the cache lines
> + * @size:		size of pseudo-locked region in bytes
> + * @kmem:		the kernel memory associated with pseudo-locked region
> + * @minor:		minor number of character device associated with this
> + *			region
> + * @debugfs_dir:	pointer to this region's directory in the debugfs
> + *			filesystem
> + * @pm_reqs:		Power management QoS requests related to this region
> + */
> +struct pseudo_lock_region {
> +	struct resctrl_schema	*s;
> +	u32			closid;
> +	struct rdt_domain	*d;
> +	u32			cbm;
> +	wait_queue_head_t	lock_thread_wq;
> +	int			thread_done;
> +	int			cpu;
> +	unsigned int		line_size;
> +	unsigned int		size;
> +	void			*kmem;
> +	unsigned int		minor;
> +	struct dentry		*debugfs_dir;
> +	struct list_head	pm_reqs;
> +};
> +
>  /**
>   * struct resctrl_staged_config - parsed configuration to be applied
>   * @new_ctrl:		new ctrl value to be loaded


Reinette

