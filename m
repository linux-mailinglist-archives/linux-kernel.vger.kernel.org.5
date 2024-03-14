Return-Path: <linux-kernel+bounces-103487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B539287C01E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425051F232A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C738471B54;
	Thu, 14 Mar 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AY10v1WQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650F858104
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429926; cv=fail; b=kXMWN8y3zqIhSyl7Q6ucldmukh+EPKjFtFUqgQxZrG39ROLXJCWmAPjNBhe5K4g4ed5331G1kGEQaOVlCoAl9pEErTwIFP08f82W1eGKAGvH7ebkXm61ghGvQDZERpKAJ7g+uzXCeXVbuieXkgF0HuVVJd8jqC+CeX8jaGxIg4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429926; c=relaxed/simple;
	bh=zdlRNJqD5wTid+NjJ36QHemzcOHKwRDDz8Yoef9b4NA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BqjmuX5wlRsc/0LKx4qgcZDi4W5G1C/LulQ/sHsB9/cvZuXOwZKFBZ178o8kN3v12eitWE3onwaMWIu/WlPo/wl9lfgbO/b1iF6jiZEIrkitUpa11xJpFLiHzv+lf6HI8Xkywnj1YPq/7YptYr8hJCc6VN1/CFfDXVlRfbm6LMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AY10v1WQ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710429925; x=1741965925;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zdlRNJqD5wTid+NjJ36QHemzcOHKwRDDz8Yoef9b4NA=;
  b=AY10v1WQetBxlCQeoq7dfimySXa4mkF2GLIymWxNb/gb7ROQZBAncFAE
   xRAip/kOR9ubRWGUTNgXz5mMWm/WOYq57ba6aKKpccMAgh3qTJvhjxW4b
   uRi+igUwg32JJxTyq55EKLSUktGQ9G5vjcOhJQB3KJR9K+T8nma8NVLX+
   Btj+Th89pKkSs82oLCxbOQeVogF1NtMrtWkcpJAOaxOATNpVs/64ObknG
   p6DeufR7we/w03Ev9a9DHIEXIhxVzRHDGSwbH66QwXtziDEP6opyBvanx
   Re+9Zx00Vew1YMj3tVAqqwmC3SaFC/BIRwffcH7hkHlp7pKkBUaHZKLaG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5380337"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5380337"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 08:25:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="17054724"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 08:25:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 08:25:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 08:25:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 08:25:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 08:25:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgSaIWeg5NhEorB/gZI4i/7NNh9Wh5++/0YEenYkcYuOybiu3Je5fTctnKPAUq2hImtYcduqPdg52/qUmywOmE44HORQkKXuA5WeXjgx+ggfpS1MuDGWsatuH/rlLOjRrmzNHLHqMh5RjzWcTvTv48EDMlV0piVVxRHmFGrU2Wj42xsowrBBnVGGknbm1/Z8xXmWIMQWhi7sm6c69Vem6+tXawbq7Ipor5xQsWVx31VVj5j57PJjuFU3lDnOAVsT7AUWccKAEpb76iGHrMqPHSbkEzLq9hMxr1w8X9FqjEZGt/I89Tm9tHZ28kRWZ+4WC5zwuvFOiDgS76/9xfMZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYgrKfrEOoZ3k1PX3BUYXMxQ4pVpKKAn2jJNGN0BSsk=;
 b=FF9K4UXvGImWlU8zW0k3f6a7l1zYaXweOoN5uDmql2pIf9auUzTBg9z4HxvcszF/kSc4x3vCuvN/oQ8dvhRXgHVLMK8WKnhersoCrP4Nxkdu56np568d5fpCCPY903cWBmZTQI9+6jKE9alF+2Wvt2RDxkEzWUtUfgVi7/Pmd32LUvln50nOxg4oCK7lSkjMlUdIXUIbFqYNCMausvtWc9BxUZjg6O82q2NpFcWidHMVKHq6ox9kC8M6OQWMd9r+5LqsicMZ3chTLPtuhFnS+zGZQcDn/GQyVKEB15sijT797c1g2H9DvPUeA2JEQl7RvvuHwfm4psb6awnbMucdEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB8176.namprd11.prod.outlook.com (2603:10b6:208:452::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 15:25:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.015; Thu, 14 Mar 2024
 15:25:08 +0000
Message-ID: <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com>
Date: Thu, 14 Mar 2024 08:25:06 -0700
User-Agent: Mozilla Thunderbird
Subject: 32bit resctrl? (was Re: [PATCH v2] fs/resctrl: fix domid loss
 precision issue)
Content-Language: en-US
To: Rex Nie <rex.nie@jaguarmicro.com>, <james.morse@arm.com>, "x86@kernel.org"
	<x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Babu Moger
	<babu.moger@amd.com>, Peter Newman <peternewman@google.com>, Borislav Petkov
	<bp@alien8.de>
CC: <fenghua.yu@intel.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20240312075349.977-1-rex.nie@jaguarmicro.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240312075349.977-1-rex.nie@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:303:b7::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: b67e2f77-58c0-43c0-d1e0-08dc443aeec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocgDyGhNM/dtbtx0vPAfE9vI8VXcWFdJppxpq+D4x9IJFrELjn8xBfwokZifDEoiWHsARfX+49X7xSt5h5OfqICqmonG1v5RkOV1wN+/L3TzCtNBZ3GaMkxq3RjY4oxtqSj4cR+UOybexQkLogFZZMuUfwBGy1SwRBK2UPRoarv0SscAbV2hjQdFAHsIdutuxq2IGDAqWD11ilkuJsZ6vzh3NKA63HR1ygmXJ0gZ12MLIgI9k/hM4GdHRB6mex4ht6IErJdJt4yoxZGyEX5BCmPIg5RS7jmAZbbUi4uTYxwpkXyAScWnkG60KjQ2dMBa3jQH4Cw+Bj8TcZYjidsBccC2eP56xPLZ3aPlpx00imSVrZ6gnw9DKMiDbJQ+mTgeNnjk73dA8Yk09s4Z7X+jht/3f/oqNdX2yPttyaJ1gmIoFv60YGTdgYoht+QeOoWpfgoIO+OwHcTo0nh5jo7vL2ct431YBgTBlRuicyOsWnPw52TfbEHoTHqd9xS2yiimbWQXBWv3LisNSIT/xAAEyiNmiQ5pNjI+qFO6Ds4tNbJYG2ZPNIzwIXSeviZ9km3sT96SzMAJtwJda0OOExSdIitao8OQ20b2DIsH1v5i8q6VvqP3tzm+oMGk+5Jl/hPwCwpL3ie+0687ReAf5m2zL1NQXp465k9452PRVMGwVH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1A1OVQrQ3JuaHpNN2FGdjZqR0pvSXk0T0g2cEhaSWNJcVVnaGtxcXgxMXZJ?=
 =?utf-8?B?OUF1WWRTQk9QS3RUbVJuREpPMHRIbW5GZnBHSnF2WHpVYkkyVlFFbi9UU2xD?=
 =?utf-8?B?M2VDdE1wWEJ4ZkY5VW11MEFmanora0tucitvNnFnZGRJZ01MTWtBMXZlVW1l?=
 =?utf-8?B?WlhQUTlhYmdQNUVXUks2RjUyeGh2OXl3VmUvMExubW1xSmd0cDZhd2FtdllR?=
 =?utf-8?B?dGxaUG0wa0pJMldQZnAzdUxZdE9saTlXREs5ZmpIbzFpb0JEbUVJZ3A0LzRw?=
 =?utf-8?B?UXRvanBUYmJVYUhHMDdtc1hMbHdCRXpKUStSY0Q3MGJ6dU9JZ3NIZWF5cXFZ?=
 =?utf-8?B?VVVKdWFwMEgzZ1hXdjQycXVwdEcxaWlNOVpEeEgvUmZHYksyOVpKRiszTzBN?=
 =?utf-8?B?b0FTVGYzcjVMTU5lN2Z4Q245cDFxSU1XUEJyaG1JWXV2WC9PbzB5dkZCTkQz?=
 =?utf-8?B?TjZQWDJqVmZCWUZGZHgvTWtnTUZHS3lybHZ2eG4zV0pyR1FCa000blhvamxj?=
 =?utf-8?B?MmFTL1l6WkpEOGFYVER6c202L2h4VHo4ZXQ3V3FseDQwUFVNNkdkTG91c2Np?=
 =?utf-8?B?WG9JdU5GMFNqREtnQmZISlZQUGFFU2w1M1FCTm1YNjNXaktKTXNya2dqSXNU?=
 =?utf-8?B?YUI3NzJ0WFdra3JIN3NlM2pmekxZcm5ha21KdFhoYmFVTE5ET2VaMWtlaG1v?=
 =?utf-8?B?aDFySkRZVnlvZ3hOMWl3WnBrS1J0SWFLOE1icHBaV0pXTWxULzA3MUFjV2d3?=
 =?utf-8?B?Y2FVK0t1SUZJYjloRHVsMWl1WUFzaGwzRkRkaTRTdnlMUTZmcWNNUEpOWjNR?=
 =?utf-8?B?NjYxUDFWRzhkRHkyK2xwSkdWY054RUc5VG5UcE5UZWpBZWl6azdLOTFEaUNH?=
 =?utf-8?B?d3diS1l6RzZPODVHRzYyMkhKbDI2Qlo2WG5LK1RWbE9aYlA3VjVMNTNuejFQ?=
 =?utf-8?B?ODBXV1VkeHBRVDNvM016M3RSc0RLTGZSSFFvSlJGTEJuTkhEOWp1cUpBM3c0?=
 =?utf-8?B?N0sxR3ExTi83MWk5ZDMrS2tjS2ZUVGxHelJTcTdBMzNwYmt2Nk1Dc1h1VzVB?=
 =?utf-8?B?VW1TR3FYbi81U3dMYVEwaE4raXZXVDhZais0T2pYbFJSUXZjYSsrcmdyL1NZ?=
 =?utf-8?B?Zzh0bmYxeEhzSXpybDBMWGhoTkIxV0kvTUsyQmdGTG1RcU5KZ2l5M3dkV0ow?=
 =?utf-8?B?Qm9wRTlwclNFa244K29PcGtsTWpIUFRMRE5TM2JWVEVBeVlNZkZyeEpBTkpL?=
 =?utf-8?B?T0xUYkR3UFFiZXBmamFkUU91SmhCUnVhOXZabWJLMVJDUk5SSlVBWXVrb25h?=
 =?utf-8?B?U3dKa2gwcnZoY3FjZjAwM0piZS9ldjFMZUF2dTdkYTFIVU05a1pSLzNVcW00?=
 =?utf-8?B?Zms2MW90TU9jdEZQdm51YkgrUFo0OFZFNTJsUjkzV0NBMnVUdFFXYnJYRk9z?=
 =?utf-8?B?L3Z5NEp3aStBUVhjeWNVcGNSLzY3bGpoMFExbDJGcmhvbExMNWZYZDU0c3d1?=
 =?utf-8?B?TUhONW9JZXVHamJkVGRKNTdFNTN1MzI2V1lSN0F6NUZCdDJQMFYzNGNuRGRa?=
 =?utf-8?B?ZkhmZDQ0SkVabTFubGVxUCtlSWRkTE15eG1IV0x2UzRDVVJVUS94T1VvUW5F?=
 =?utf-8?B?Y05RZVZjTVB2QVFMSHJPc0NmWTROU2M0R0FNamRtdFRGekZWMTNETmM2M3ZW?=
 =?utf-8?B?a29RTzZCZ2FUbGoxS3JRWXpOUmdEU3VjYUpodDdEMkJUYks1aUk0MFhsakNQ?=
 =?utf-8?B?aUhVcXcyOG9DWXZpTm95SXB0M3lnejVwcXc4QVJCZzhrZytPeHpHR3FoQTQv?=
 =?utf-8?B?U2tlci94K1VxL1QvVnRtYmZ4K0kyT3lpb0JkOG1VL3N6QkdIQWJSeDk5RWxJ?=
 =?utf-8?B?cTF3YWo5bGRjY2d3bS9leDZHRE56K01Yd1h5SmtBL2wzZHdwS1V5RndhdWZi?=
 =?utf-8?B?U2JiTkhLOHlxc2Jic25Qb0Q3SEQ1dkRXNjV2Vm1PZXBzblR1b0h3em1LRXFW?=
 =?utf-8?B?UUlUc3pndENSZWwzZWJBU2YvR29nTkJUYjdkUGdDcExpbXdzSlhQQmJNbFVZ?=
 =?utf-8?B?WW92WDRIeSttQTdKa1FJRmZ6cnh1eUprTW4vTWF3VlBxamtWK1YwR2JJL21R?=
 =?utf-8?B?OW5LL1FNTFlKTUJEOGlGRWl3M0FBeGNCTmZtS2ZBMCs2Yy9WMmp2ZkdDYTYz?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b67e2f77-58c0-43c0-d1e0-08dc443aeec7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 15:25:08.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/LIzUhy1xHJt4LM05WzSRQqH/c/V9wgGjnStXGdwY4/R3erIqu2ADdnmcwj0vu7xjSWbtqLZnQZMe8PBNgSdprveyDhKwMXb0zCzkCvx9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8176
X-OriginatorOrg: intel.com

+x86 maintainers, Tony, Babu, Peter

Hi Everybody,

On 3/12/2024 12:53 AM, Rex Nie wrote:
> Below statement from mkdir_mondata_subdir function will loss precision,
> because it assigns int to 14 bits bitfield.
> 	priv.u.domid = d->id;
> 
> On some platforms(e.g.,x86), the max cache_id is the amount of L3 caches,
> so it is not in the range of 0x3fff. But some platforms use higher
> cache_id, e.g., arm uses cache_id as locator for cache MSC. This will
> cause below issue if cache_id > 0x3fff likes:
> /sys/fs/resctrl/mon_groups/p1/mon_data/mon_L3_1048564 # cat llc_occupancy
> cat: read error: No such file or directory
> 
> This is the call trace when cat llc_occupancy:
> rdtgroup_mondata_show()
> 	domid = md.u.domid
> 	d = resctrl_arch_find_domain(r, domid)
> 
> d is null here because of lossing precision
> 
> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
> ---
>  fs/resctrl/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index 7a6f46b4edd0..096317610949 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -94,7 +94,7 @@ union mon_data_bits {
>  	struct {
>  		unsigned int rid		: 10;
>  		enum resctrl_event_id evtid	: 8;
> -		unsigned int domid		: 14;
> +		u32				domid;
>  	} u;
>  };
>  

resctrl currently supports 32bit builds. Fixing this issue* in this way
would first require that resctrl (the architecture independent fs part)
depend on X86_64. Is this a change that everybody will be comfortable with?

(Of course, there are other solutions available to address the issue mentioned
in this patch that do not require depending on X86_64, but I would like
to take this moment to understand the sentiment surrounding continuing support
for 32bit resctrl.)

Thank you.

Reinette

* Please note that this is not an urgent fix but instead a preparatory change
  for future Arm support.

