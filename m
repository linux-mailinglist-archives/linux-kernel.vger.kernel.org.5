Return-Path: <linux-kernel+bounces-126937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4CD8944AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273D91F227BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385C54F5ED;
	Mon,  1 Apr 2024 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0m/qw7J"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877434E1C4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995157; cv=fail; b=M6NYn7z7lf32IeXC6zb9cYVJ1uFDvQ9P0pt6aH2yQx8ddsUtp8iEH/BdBhR153E5rXDjCIfF7axqP672ATtN65GnB+LGBjXEVW3YGYzfEH85KggLY4JROm9kM2yUrRXqdMfXA5kswR0XG0DCAdWuP+gXFHC6NOX2olasN7HLnuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995157; c=relaxed/simple;
	bh=ftRxCzcVAJ4SGMdlARblu0nlQJ1X7W4W0A/xDRDg2K0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HY6KQ+5dr5n+Wxbkmk3GgAgtCTrGEN+3Ea73Co9RqERfCBwRgnVQVl+MvhUWs6ZexN758Za7cdio1PJKfqcU7VEBa1orgWyrcDoiIFYIuORVS1lR/g0MZzOimVujhU8sLEuOS/gtpxBxI9A3wmLcIom5XudBaiukDLDNsykzKcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0m/qw7J; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711995156; x=1743531156;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ftRxCzcVAJ4SGMdlARblu0nlQJ1X7W4W0A/xDRDg2K0=;
  b=K0m/qw7J2QPc9osY4WYg/UbzNKmSlFY9VX7c5p76fyoMDi797o8pLfsw
   5BnBSO3TIuhN6yXlZ80SN4duB+NgXC7PBMP2Vefc/yp194i7ZaMdgIyhD
   FKvRnKbNk1cZ7ZvPcum0oqAZnphu+pjHKItC9XlkP+aYbq0V1GTx6jib9
   /nQFCwwZte2HZHmzmOX+BXQX2uYkDAaGmL5lMUbYzbqNaFRjqit2aAHvu
   3j+GgH4E+XLqNAz9zv3aWTBjFznUC2Eux1gBwQEFSiEeYkdZMr0S35KeC
   Cus9Dbm7iZ0HcZRUz1Cgch6zwbq90bYL/0OTsL7BBdIzMjHrdKTt1RRqh
   A==;
X-CSE-ConnectionGUID: tpQL3Do4ShO+vGstwtZpfQ==
X-CSE-MsgGUID: 2/uIhs0/ThWp6Dmz/BNNgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="17857585"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17857585"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 11:12:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="18192555"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 11:12:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 11:12:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 11:12:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 11:12:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 11:12:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uw5agk+Ag8hCa1nJQDLTK9cbQuG8DDjGVUBw3z1mqXdhafeEeDzkmDxK91tmquHQcwb89Rl4qgCiVxnvv/pc5X/Pwwmh9LCzbxCu8k1VtfRHWpiWtaC4trG4kr/ebJVyC+0MwtVoyJ1SjlpHY1QbqNwLCD/Cv8lUrLLBlhqymnyc2gjjuwx35akEghOW76K1l2WUpraie67W1yJTo1NCBO6JUeyw4AUG42/ETpUyXnK+K+cju0Ph7d9fH+ojk0zVk13hGlgTf7P2Vlt2te2spQ4MWvaPCKGOCoE+Mtvj4ZCCiLd9QhktL2Cbwuf9HdECBH5I2uWyoHkyMlLPqzSn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5treKNrk6NwIQWNDpqipbMz3vOJssodSXL2rpNNTNaA=;
 b=K2Dqp0QinBrjKANzhkzJF22XoBCTh6FM4NdWKEjYSWEH8p+IFUcm+5Y3GgIeV3Wqr+kAssMzsrlwicHxlNuCh6E84dpOXoRcvA7R7frvsC+/obMFGBwL6c6lNv7OeRGfST6txLE2a35lf/RlpvCj2D9BPIofl/9p0T9FBD3HcdL9cYdJaERSpJ7Q9m1nk/KOry182ejj+pDe6xnLLqDGvwYPLjFxF6d90/byZJ2hd2Fwe0YaMRRsexrvW4Z8wi888zKyuLvpD/YSF//alFdKgfi8RM7PzeCszoFx7h73QaI9NqfUDqDmB+2C8H2wHVkCTtAuGToRdf4x7+gdFD0/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8558.namprd11.prod.outlook.com (2603:10b6:408:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 1 Apr
 2024 18:12:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 18:12:26 +0000
Message-ID: <ea8ef700-daf2-4408-888f-f5c93db82331@intel.com>
Date: Mon, 1 Apr 2024 11:12:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix uninitialized memory read when last CPU
 of domain goes offline
To: <babu.moger@amd.com>, <fenghua.yu@intel.com>, <bp@alien8.de>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <peternewman@google.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <hpa@zytor.com>, <james.greenhalgh@arm.com>,
	<linux-kernel@vger.kernel.org>
References: <979cfd9522021aa6001f8995cd36fb56e1c9cd39.1711659804.git.reinette.chatre@intel.com>
 <133312c4-6ddb-4752-a7fa-3e7e526e9335@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <133312c4-6ddb-4752-a7fa-3e7e526e9335@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:303:b7::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8558:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wR0LNbjhTkNxnxJoSDxZilAcoBBXKo5cYayPOMJ7tvkovwDfQQ3BHprG93wVL5iztFGgp+X+EJUB0FGChq4Cp2fqvC3Pb7Ya3Y403bO6UsL52GCQ3pFQP9F+nvfF92Y6RuehQuLwvnKyprrrYhPVm1QS3hOKg6YYA4t2fgTrZGrPwkdfDP8DCUU4QxpbTL8beCP9ZVkmGGc5ChJ8vQDT0hJ+EEoVl41rF/1S2JsQJj1NDDOeo8pe1+8vfxg9oyZiqtGBeFWdi0UY6vteFF9WIb9u2seQVDv7xV2aHLtb4WPougRQ/nJdXtPMMkyEK7zzcMdKRp9KZ4fw7kvqDkEwluphAULPWilZe1cHHm8se+/9q7MTdjucJeHko4p3Ryueax/9mt0ZeT1U9Z7npW6IV915j+dD32BYpsu7wV/QK4ScMudbYhaS3USZ+66Daf+KHZrJR9vo7d/wrPlczptUX7btlzjZt/ucx2cwh936LYuzA+I4DST2TpkdOcNA7i7BWrmNbyGMhWPsoowx+98ilpELTpk/8u7+fppCHYn2OolXWwT1e22pYMkNxWnHh3BtiaPLNesOf3yEPVvwd+s3wWwpysamwqHuASvKPPuWF22sgdk8Us4uvQikXrEWVyNrNKmKIR+uzP8po7cdcXEWzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2w4NzF6cXp0cnFZc3kwVnNYRzhSbTZjZzIwVGJpRjJNZG9za0tkYisyMTFE?=
 =?utf-8?B?bWpDcGdxYktyU2srNDdqek1FeVp0OHZTajVVNWZWY0FoN2dJbzFKclJReGZa?=
 =?utf-8?B?b2ZKTTRPbFJQOFZSMjk2TmVVbDc2K2duTU1oYzNFUFp4aDlMcmhCbERXdnFS?=
 =?utf-8?B?ZXlDTUkvYk56ZGpJaVltc0NUN2ZRbkJvQmorZnFGNGVma1N4N3B2TlV6TlVm?=
 =?utf-8?B?dXIvbzJMR0gzSWQxN3ZKQlY5UzVMTFhuTndPVDNBbDF6Y2RGeHd1L0xwY0o3?=
 =?utf-8?B?Mk9OUWxvaExaK0NFbmtsNithQU5JbnBtNHJhVCtxVmFiOUFQZUNza3poZldJ?=
 =?utf-8?B?bE1JRWEvMTB5Z3Z5NEdPaG81alFPTnpSY2JhTzRaY0tCdTJSMVhGTUdCZHho?=
 =?utf-8?B?OXJDUWZqUkRVd1g5c2djcWhUd29zZnJtSk92bEF1WloxczZ0UkNZMklJSVd5?=
 =?utf-8?B?WmlYenRrT0FJWkxRaTRoRUQ0KzdITTQ5VTBlMFY1bHhMUE9vZ1pVUCtqVTdR?=
 =?utf-8?B?cldVTFMrZHZiZmVLTFZFSnc0d3Yzb1p1N3dFYzJhWm83b0F6Mm1EVFlJZFlV?=
 =?utf-8?B?SWU2aUZNZkFPQ0RmUFdsbStFZVlqbFBtck9lVzJhQ2xMNnNyQVI5bVVwODR1?=
 =?utf-8?B?OXZINmdNMmh4TzNQdHNWcGYyYW5sdXBxVzJJVjRiV080SktzNnpDaTQybVV1?=
 =?utf-8?B?OXJUME1SZXBhK0pWZUJCU3dsc055eG11cGhVRk5yekxZckJxOFRQNmpHVEg3?=
 =?utf-8?B?VEM3ZUFBRUhxdE4xeWxOckV6THhqQ1dJUW5lVk9McTljRENWSnFPU2R2ZUkr?=
 =?utf-8?B?Ti8rZy9LaGVOSG1wR015Z1BiQ2tSemoxTmxobmZhSlBPMStZcDAva1ZtbFV4?=
 =?utf-8?B?WmxVcTY3WFVtQisvTWIyWUFkTzFBa1hoR1A4bW1md0lNMlhWQzdRRVBpcGdW?=
 =?utf-8?B?MlZRMW9CdWhrL3o5aEhGeVpyUUpXQVBJYksydmcrajRPZUFlK2xyajJhbHpM?=
 =?utf-8?B?QUVCNmNhOENJUkVsaHN1Wm5NZmpmcHRudXVYRHBORzFxblJPWUU1SDZxVWJy?=
 =?utf-8?B?UXB2eHFVak00L1pIWnpLTkx3NkcwNE5kSGNzeXNlb09YalF5K0RQM3JEU0JX?=
 =?utf-8?B?NWRkVU5QUjhidVRHSmxvODFvT0NHTm5udW5hVEc4WEw1eWtSTDFHVFlDc0RQ?=
 =?utf-8?B?RXVNMVYyUzVNWXJJUkxUTFZCVmQ5QWRsdWdxK1BCWERlWEhhNUZ0N3FXcmx1?=
 =?utf-8?B?MWNmTmJiMU9zME56NmxQN2dRdU5mQ2RjaCtaZGM3S1ZrM2xuMnF2bGt1Q3Ax?=
 =?utf-8?B?ejVXN05qQmhhR2JBWWFHalNNRHB2cWY0VzFCdWlBQm44OEh5SnNoeFpSS3Z4?=
 =?utf-8?B?U3VmMVZyK3VrcWdsUklNUUdZMXlUclV5czExb2dXOE5sN3hwS2hzSFRPb2Zm?=
 =?utf-8?B?R2pSbVk4ZnRwYXZjQVlTS0xtZG13UU9laFlhK2VQWVlsSXVRMGZvMkpHMHhO?=
 =?utf-8?B?YTkzaHZRTjhLbndDbldkd3M1SVNKYmo0cmtCN1NicTVDcHU3MmwxSndJZWZv?=
 =?utf-8?B?d25iWU9WVzNqRC9BNDdFWDNMdnBTOFBLUTZOQUEwNHVWcXU1d3B3MGhNbVJu?=
 =?utf-8?B?a1N1SE9YbFpoWFovUjJqaHhpZkY4dEZEVnYvWGJoLzNUa2RUdGV1RTlXQ1pQ?=
 =?utf-8?B?ZWR3MUhTdUtzUG1SSkJTb1hPOUZyS3VnRXdXTmdDQ1RCYVM4Sis2V0NpcEs4?=
 =?utf-8?B?Y0pHUjV3SEJQWnlNcFBzeWJlcWhpWU94T3FodWNsL3hBLzNGZGpTUmI5ajE3?=
 =?utf-8?B?RG1DRG1xWVNnWWxMV2o1SXdlZStRZXpDazBvUGhFcUpCODFER3dzS1ZNd0JV?=
 =?utf-8?B?OHdDOXpLRmFTblBRdFJaanBJVi83ekNiYWRpemlZNjZ2dGFpaWFVQWNkRkpp?=
 =?utf-8?B?V0JvaVY1b0thSnVpYWZrVmZ4b3Y3cmRTcHByTjFDbGNBdFJjK3pxQ2hWc212?=
 =?utf-8?B?K3NhUk5kYk5XYVFrekxTWHU1R255YTFOaUJGU1dobHBqRHhYQTFudnIzdW12?=
 =?utf-8?B?T2ZTcUprL01sVENBNHM4YVZTOVM5NEFiVHZPbEhJUjBKNmtNNnFqdXJZWGFE?=
 =?utf-8?B?Q0lJR3FzZVEzYld2QmQxVkt5UXpCbHVweVludytOQkpBVlY4eEdkU2d4UVZH?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78be492e-7536-4a9d-b57e-08dc52774919
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 18:12:26.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sp8TMJrlujtoG0d4fvTZqwNl7s/ihGLTeEl2nEaPrHVtrqBYFkAn6RrOg32iRc8apWXoFPmAkwrDXvy4kQvTvho/sIkei44AAnlXzMLvNe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8558
X-OriginatorOrg: intel.com

Hi Babu,

On 4/1/2024 10:57 AM, Moger, Babu wrote:
> On 3/28/24 16:12, Reinette Chatre wrote:

>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -85,6 +85,10 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>>  	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
>>  		return cpu;
>>  
>> +	/* Only continue if tick_nohz_full_mask has been initialized. */
>> +	if (!tick_nohz_full_enabled())
>> +		return cpu;
>> +
> 
> I am curious why this below check didn't fail?
> 
> if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
>   		return cpu;
> 
> The tick_nohz_full_cpu() already checks tick_nohz_full_enabled().
> 
> It should returned 'false' and  returned cpu already.
> 
> Did i miss something?
> 

The scenario occurs when the last CPU of a domain goes offline and the cpu itself
is the cpu to be excluded. In this scenario cpu >= nr_cpu_ids in the check you
quote.

You may, as did I, wonder why continue the check on a smaller set of CPUs
if the first check already failed? James addressed that in:
https://lore.kernel.org/lkml/bd8a64fa-86d3-4417-a570-36469330508f@arm.com/

Reinette




