Return-Path: <linux-kernel+bounces-105006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEE387D78B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B1C2823F8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2E639;
	Sat, 16 Mar 2024 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpF9oCL6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA0F360
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710548429; cv=fail; b=oP/jlJj9CztXmsnhUtCp5jZixFSnZ71baDZfMBUUQW8/hoprBM8cXt3y9ATEr2O0eMvvw3iqrXZUFqevVjIrUoANekVDDZBtZ88+tvDFe37bJ1L5QmTjFm9t3bhR4TDpKKjYZV775CCO8RTu6IltoaPCN8QA/FKW7CQND83nKsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710548429; c=relaxed/simple;
	bh=+Elrtc2939dgHUtTuQXZHU3G7HHegKvajwHp7w+bna4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GQExf1S0tGFJa2xqr5brzdYKEpuU6LKBFEeS8jsjV0AlyvMKoNDcW2hEe1qFg37fCBCa/6xoyWIITdWp8Bl+hI+bdRgJ9PNkLBFsyHlbUPIkRRSYQ2tX2TlKTvHNoMyw4/3pDx9mdC6IVn5OLlIHEmV9S2SFL+H/glqBroNCHYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpF9oCL6; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710548426; x=1742084426;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Elrtc2939dgHUtTuQXZHU3G7HHegKvajwHp7w+bna4=;
  b=DpF9oCL6M7WG4dA1PYv2xUenu3xKEEcKGOA72hKht2c9e183cX/6iBRh
   QSf0NejDYGXH/gny/E6z5ZHrhTS80uytQsBnEUylCAFVd9GylcmfrVZ2V
   cVQdnLuTXuSgrYUpcbbDh6wtQjHNVEmPUJy46aU3NqZt7x0N0c+ENZPNo
   l4ZvA+j8zO7qOZr7nKEXyPaqbZ2sQPiFc8DUQ9FPp5CkPEM6MqGXkAVtm
   sWOwQENy5Rt071zZi7Uy+ONx7CbkGm1Ubr2JjDFpZvPd5IYm3yX/q+H+2
   w+h1tfQSIkRi2alMr7y+dSwsmgWLpUN/qMCwW/scRjYJWkVtyE6b3QO9G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="15986533"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="15986533"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 17:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="12918186"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 17:20:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 17:20:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 17:20:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 17:20:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTsJDY+OE3fE9vsJHCt6rp3QWAH6F5e/dHnVpcfAQGryb0pua/WcwFlmfM7EkHBuLXBR8j6kzKUK6RRnD2mS6pFPsN2wo3hm9g+FgbYSlorerE5uMu1yfCkNLE3NZG0IUb4ma8UgH2bEkztykpIHQA4B+dLSq58e1OKtWavaXSlLBrJjHLzwqwxEYCYhkiYC26lIICG7iTbo3mXQEsNqV5nlshxWjMAA0Ldt0Fmt94A7N0uC4TnYX+20XboC3gun+P9+UJrE1T6nKy2/Bzh0/HlkE9kXA9X63PfbeJr2mVZ6jkii4uc7gCljPKXpDiNbQp8u+vBR69EbkOdqhWeCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNQTIhwcRIPvfrxPgQOw9M1H5OxG/45cYrkawZYVD0U=;
 b=LqI7i9PbfRXPu0/vJEWAXEu1GEpfQrTQNyC/1YkPdsSojeSIYCeJJpjTYvJdUQRUld2GaKX3XjLFc2AKmXF2ezapigrYUIvbyIxDXJvbXpgIiG9yMctxuIzUeeBtXErRq5yDHtFxTAk0BCdbb3BVE8ojXeHCqW5lxWSono+3PF4HcWoXYzDvAZH5IBI47W7VcNG3jvBmmxGaB/FAY2lzHeuko25Cis39O3NkLpN+WEPixJV1zm7ZkmGbz3zzqUQEp5fw/FFezyTqLV+kZA6ky1lgVjbpU5T0XLhwcBuudws08eSMB7GKzg/gVGJdtSQhkLEbLgKpAopX5LGmriJZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.20; Sat, 16 Mar 2024 00:20:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.015; Sat, 16 Mar 2024
 00:20:16 +0000
Message-ID: <27076e14-66b5-4fb7-8a9a-4d5d59bbe837@intel.com>
Date: Fri, 15 Mar 2024 17:20:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: 32bit resctrl? (was Re: [PATCH v2] fs/resctrl: fix domid loss
 precision issue)
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, Rex Nie <rex.nie@jaguarmicro.com>,
	<james.morse@arm.com>, "x86@kernel.org" <x86@kernel.org>, "Luck, Tony"
	<tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, Peter Newman
	<peternewman@google.com>, Borislav Petkov <bp@alien8.de>
CC: <fenghua.yu@intel.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20240312075349.977-1-rex.nie@jaguarmicro.com>
 <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com> <87jzm3jckw.ffs@tglx>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <87jzm3jckw.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:303:8e::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e14671-285c-48b7-e0d4-08dc454edad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhuPLyyLSVWrQhvvFoYAuLf2TJvXXFbh/T8bqfYKI8Ka+MhaFptZofGAu9Ppi8k+GTcJxJP1qQJHpBZzoJQF/HT+z+8IlYtNdeIBf7nXawHp/jF+u3JSIVGWoreA5feU1LUK3MZUFp4qMvbRq1UrOxjubQTEu4q1/Y7GzjwiPhs/rrk5C3Hseigldh+Mr0aZBZcDclu35r26d9VSbP8jj7ZvtkEKf/FLBI4/7Hdt3S2gvVMq6Z6WDfb99Stg6GXxR7hK/qAawEt56XmPaWkeKDsNYjVKACo7d7wW38BVJHLcgTZyb6B3JPHWoh9sqPNkopKOKd9pPsd2Ab9jcQ7f9dNbHpzxQFmCmyegatd//JFqsaVZJNXXTz07bHLOjJiIBKsrSnDu0ogXzU3ip/IN/VOt9lR8FGqLtShRpQgenwcBWY2BnajRG9V7h0Kd//Ty7lJFeTenXpVtTQCNr40yelleZStCpNbysGoZQNnKy56srm7Vbvlst1f3q4RHaGY/K6qFBHDxziDDyGpoaM6Z3PsnWiLAEiJJx5JvCcIHBGlbGQCTt8uAgz/rpGUCcK9qqs1inuIvEwcXrbCoKaF8wyGc5BxkElIZjNNg5ZdwF/xprrvDjvitTX+wKB5zIV5iVnSy5TdcEFDvA6xTeRVqOZ5yLvDRswfe5L7EjXEjPo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEJnQUpFS0haMGRSWHZJRmp6MlB6NXRsOFdDWnZxUG1WS0NYSnNsZVIrQWFU?=
 =?utf-8?B?VXJHWHdXc1h5N0EyWFN0YkU3aWNLUTAzL1VTY2diS2g3Z0I0dUdVRFNtSDYv?=
 =?utf-8?B?aTNtWFVydjhxWWc3ZmloSUJwMGZFNzdwUGF2eHJGd2wzRmlQb1RjS0UwUW1O?=
 =?utf-8?B?T1ZKTXNoY1RKTmhvcmUwU2ZWdFZHeGx4cVR5VnN5NTlqUEg1UFJlNFlMRVU4?=
 =?utf-8?B?VE1adVF2WlErWkpWajJhUlJyODlicVoyeGZMVmZBSmEvRkJCbm5scVV4T2xM?=
 =?utf-8?B?eURza1hocksweERGbnNUV0tFN2xPbVA2QU1kN3BTK096ZzdKTFdpaHJpSVpG?=
 =?utf-8?B?SDFTRmdRemZBK3A4d1Y1b1ZEMTdKUy9qVnh5SEdRZlk3c3BzUUl4TGxaNUp6?=
 =?utf-8?B?YmxMc08yQWI1N0ZIQ2JjRHF0TlE3NStOajlZUEtWY3EvY255cjFtZmRZY3h4?=
 =?utf-8?B?eVovSHVaeVYvbDNQUkUwZUxISXFpSFRCMWwvU3E0b1ZmaXlOMUFGeDM5Y3Q2?=
 =?utf-8?B?ZDI2bkRVY3J4aXNJVXFCQUp6SDROUjRaVDBIZWZPOHRNMGhtbFBDdGE1RWZs?=
 =?utf-8?B?blVZbVVJMnpISFY5cUdPOTUrcjZKK3dWaENZQjFDcXQ1MHpXTXZJSm1WSzNk?=
 =?utf-8?B?Z2pxbzdsZEFuNGEwU0hjTVFWUzBkQnZnNGxaY3NSUXNmeUdKdXZpUDFxNjVw?=
 =?utf-8?B?VC90dXNqV0djUmhKc1VKdGRZUjVqZit1NlVBQnVHVTh4d0VRa2cvYlA0SGs2?=
 =?utf-8?B?dWluMk5mVjA5R3o4bEdWTFRiRU1JN0hxWkg0YmxIdTVpNEowcXlpbGRZR1ht?=
 =?utf-8?B?VUdxNnVyTlhhdlE4SEpSYVlwLy9scGo5Z2puSmtPRXJCc0hIYXZsK1VmZG1k?=
 =?utf-8?B?T1haM3hPdW53RzhubjZDTFdYNEtwVGZWR1JIOUx6V3l3QjVMTmJjSUtEa1k5?=
 =?utf-8?B?S1ArTEp1VFZwcjZuQ1VYRmpWTGxoTWpZSWx3UnNjNUlGdENweFUwanJPUDU4?=
 =?utf-8?B?TkdOZVhZNGdaanhnSmJmUFpLVmZyeVROQWdxemE4bTM5MUJUNEZhTUUrWDkx?=
 =?utf-8?B?L2JnMWNhUWtDa1FRamRLZzZBVCtra3RVSWdqREgxVFBoYUoyREdFU1B0K2dz?=
 =?utf-8?B?UXN4ZVZtQjJhaEl3Wjk2dm04MmVOeXJZY1VpVStXSUJrNTZrZ284emhnbW9j?=
 =?utf-8?B?WnA3T0lwSURodHp2L0g3STd5Sk5GTWJSRHROdm9KSnJzSGF0aDlibzUyaGxF?=
 =?utf-8?B?cURFVTM4T3p4QTk0NlVaRHpWeXdVVVhzVEs4ZEttL3pVSHFpS2dBWmYyb1NR?=
 =?utf-8?B?RzRrOWdzQkpQRW84NVFlamdHbjlCYVZxT0I2UE5EWG8vNkJtV0QwRHBmY3FH?=
 =?utf-8?B?a09uTDJXMGhSWjNxbjhLNEdvYXMyL2NqdmRRYjFBUEJvOExPaXJCd0RQeml5?=
 =?utf-8?B?QnJTdXV1RGJNV1M0a2RVWXUzZmQrNlhrUnpLSlNtbUYzMDY5dTFqbWYwT0Yy?=
 =?utf-8?B?QzRTS21JSnV1SVYxOEljb0NwelkyMVJ2TjJZTFRhSncrcVVzQ2Y2SVhTZzNB?=
 =?utf-8?B?MUhGUFVHY3lvY1MyRStBZElEVm5RaWhZSVNvUWRNdTAvZ2I5VmFXV0dTWklO?=
 =?utf-8?B?dURNcE5nNiswN2JkTFVLSHFnYTdtSjNCU1M0a2lzZjdBTE00WlFYTFZPTDZx?=
 =?utf-8?B?Smt5MnNRZFJVemgwRml1aTFjWTJ4OWd1U0NIU3RRdW44MHZTT1pHa0p5bFlv?=
 =?utf-8?B?S2p4a0pZUmU3elNDWGVpaHpqOUFJaCtVOTN5YXpJaU5aYTViTThWWENqd00w?=
 =?utf-8?B?K0ZrNEpDSS9Yckx1U0xsc3hzOUZFcEkwTEVkZ1JDN3F5V05rOWxZVjlETVN0?=
 =?utf-8?B?SEQyOVRjRUptaTczQjRFVVhqM1ZtdSswVS9qSnlucjBPYmhCaVJPUi9mTU9n?=
 =?utf-8?B?OWhDd3RBVmRUckdGZkM0N3lWRlRjcGdjNGpTaUNMcGh5azQ4ZUs5Y09vd2Yx?=
 =?utf-8?B?OTAxOXpFa21hRFdIU0g3OTZ0Ym5tU2JPdVdVTHBNNnkvaVVuRVpIbXdrK3FM?=
 =?utf-8?B?WUppQVJpcnVWeGFYbkNRYXp4cjZDRVNWVVVyellRUkFOdmlQT2ptMlB0MUJi?=
 =?utf-8?B?NkM5VWlPUXBXeUpkTFdGandBOC9ISUlUUFo3WkhOaEliRzk3SzFqeEo1NUZH?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e14671-285c-48b7-e0d4-08dc454edad4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 00:20:16.2188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7raasj0/UaUjOPd97M5E9XeMIN1P0gqHHuzg4ueClFEKf7ofYp0iD3wLzaLunzuo+8Aef9GiRASpPPrKlwylZQUHiPKDx2SiovDtErJKNec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5970
X-OriginatorOrg: intel.com

Hi Thomas,

On 3/15/2024 4:32 PM, Thomas Gleixner wrote:
> On Thu, Mar 14 2024 at 08:25, Reinette Chatre wrote:
>>> On some platforms(e.g.,x86), the max cache_id is the amount of L3 caches,
>>> so it is not in the range of 0x3fff. But some platforms use higher
>>> cache_id, e.g., arm uses cache_id as locator for cache MSC. This will
>>> cause below issue if cache_id > 0x3fff likes:
>>> /sys/fs/resctrl/mon_groups/p1/mon_data/mon_L3_1048564 # cat llc_occupancy
>>> cat: read error: No such file or directory
>>>
>>> This is the call trace when cat llc_occupancy:
>>> rdtgroup_mondata_show()
>>> 	domid = md.u.domid
>>> 	d = resctrl_arch_find_domain(r, domid)
>>>
>>> d is null here because of lossing precision
>>>
>>> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
>>> ---
>>>  fs/resctrl/internal.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>>> index 7a6f46b4edd0..096317610949 100644
>>> --- a/fs/resctrl/internal.h
>>> +++ b/fs/resctrl/internal.h
>>> @@ -94,7 +94,7 @@ union mon_data_bits {
>>>  	struct {
>>>  		unsigned int rid		: 10;
>>>  		enum resctrl_event_id evtid	: 8;
>>> -		unsigned int domid		: 14;
>>> +		u32				domid;
>>>  	} u;
>>>  };
>>>  
>>
>> resctrl currently supports 32bit builds. Fixing this issue* in this way
>> would first require that resctrl (the architecture independent fs part)
>> depend on X86_64. Is this a change that everybody will be comfortable
>> with?
> 
> Why? Making mon_data_bits::u larger in the way it has been done does not
> have any dependency on 32 or 64 builds unless I'm missing something.

I should have expanded the diff. The expanded view of current code below
gives more insight into how a pointer is used to store data:

union mon_data_bits {
	void *priv;
	struct {
		unsigned int rid		: 10;
		enum resctrl_event_id evtid	: 8;
		unsigned int domid		: 14;
	} u;
}

> 
>> (Of course, there are other solutions available to address the issue mentioned
>> in this patch that do not require depending on X86_64, but I would like
>> to take this moment to understand the sentiment surrounding continuing support
>> for 32bit resctrl.)
> 
> Caring about 32biit resctrl on x86 is a pointless exercise.
> 

Thank you Thomas. This code is what will soon be moved into the architecture
agnostic "resctrl filesystem". Are there expectations from more generic
interfaces like this regarding 32-bit/64-bit? "resctrl filesystem" is on a
path to support more architectures (x86, Arm, and RISC-V) and I am not familiar
with the architectures and platforms to know what the impact of such a change
would be nor what existing usages there may be for 32-bit builds.

Reinette



