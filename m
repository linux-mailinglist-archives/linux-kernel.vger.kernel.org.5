Return-Path: <linux-kernel+bounces-73792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D4685CB44
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D6428439F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53273154456;
	Tue, 20 Feb 2024 22:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoAqyhHT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73F154434
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469902; cv=fail; b=GONefcICJYbaIjuwA+FiR87vsTSXZMWTbc4cleh7+hsY43QLQUDDEjoZoJ93Rv15e4en8wqzNOsaW2pXo4SWgNKUpKvJIwKABeCIBknQKmFvkRM+KW6VpAlTl73Xyj1vZtjsd3Zw7XDl4WkZRD4x6PKLBxoCYhNAZDZhZyQBQK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469902; c=relaxed/simple;
	bh=xKZy1GD1FXcFkaO9tCZkJGyJ44Y+maoSI4fUTFmBe0c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DTBssPc0+ETw287Px1I3o4HxYcYnRTqpPnsrrGWM+PJNl+TO3iBvJ7TwMCzceNd9VoRMZkEEpN5yFxXe74PC+YSnydgVcgKrsG26lyK1whQFOi+H9Aby5tgpFXzQEJJz4CxhdukXlFl75cdaLP+JIiAEB2SLwtIHUmOJEL7aTVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoAqyhHT; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708469900; x=1740005900;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xKZy1GD1FXcFkaO9tCZkJGyJ44Y+maoSI4fUTFmBe0c=;
  b=YoAqyhHTI5fH85AlgbVPt/4eKG33hkOyEfP/evukxrzygTt0HoTjZ1P9
   uw+ZfS+kjNAPgke+He36GLR50/65wy002N/CWu7FcPWROWAreUSRPAzD2
   7ihBPJbDforfqcbSG235+dYSI5AnHhv5xdHWFuCG8z+gxEhKwCTG5XImN
   CBm/1RDfXV6zh9qmSjyZRZKttO6PWCLWCu7y3usEvh6LWM1MP67S1jzs9
   KQWsgwFvTvHSNTFA/xKgFKL6Qf0sqfSNyk9OR/diXsdwvgLOdjwj9T+sM
   94kGtbvUHeFiAn5kEo4Ye0g/nDwgY1SO0X2+PNJ5w8edsk3fYAn6EO+To
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2478464"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2478464"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 14:58:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4818814"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 14:58:19 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 14:58:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 14:58:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 14:58:18 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 14:58:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5AMSqcVcpuN+i0z42Oiwn2gS6PmpAGcU2Rt5ubnM95KiXk4iNWtVOK8bNtlysGuijVwHwj+/PAOV1Z9TIcHtzXLDSCOr613qGrlzLBb0WyMm+RG0n1MaimLvA97ovYLkMfbzaSPHjf0anfAK40lXHkfEywzygcd3tNRrucWvjhiZXoBI7yYx9C5FfcTYBrgrxmTvy5nPQAGLF0KIyHBlv5JL47okGnDeftuUn2tLDD+1segY+0D3lkHYchH2lLWA0VINbWkxbqwJ3nKf6EPaw8spD7YfLVef2s744I/PTAKQ6MK3+BZXvj+okKWawPzHF0x7B2bs0GOAGHHDRScVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUSM7Z+8ndQUNqpHiMEJI1Zyo3p+uPyGvyTW7BbuysQ=;
 b=jxwq7l/7HYP6phjKR3apD78+/4Rke2jGrNUR+eivqc6zxFab2sZyJcaYcqzTljVI5dh4GcMdZ4K0yb2+92YgNjPbro1lGGF9v0gkI1Ac8bLuZF3Z8dSezlBOJNhIWlArrEQOpvpotIrCJcRWo98REFGb/JCOSOZxFdw1NXIWSzxxvSmT+MHLWLF6XtxhBmVls68f16k5DmIouv8mQuupI5R19C82qozUwjbYeSieF3yQOpp8B9LMn1eYrN/ToHmnhGG56urW8uPHp0QQO078gdP1BHEZrP/krWIoVSWafnAYS84fdaLC/pc/g797Kf/Uv58IYkCtan9LA5HSWTYRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB8131.namprd11.prod.outlook.com (2603:10b6:8:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Tue, 20 Feb
 2024 22:58:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 22:58:07 +0000
Message-ID: <d409c32d-0f9a-4773-bc25-9d39de3c9e9b@intel.com>
Date: Tue, 20 Feb 2024 14:58:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, Fenghua Yu
	<fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local> <87zfvwieli.ffs@tglx>
 <ZdUSwOM9UUNpw84Y@agluck-desk3>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZdUSwOM9UUNpw84Y@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:303:8f::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6f9e4c-1a3f-4583-d019-08dc326766d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNiZTDJNQT75aUkLr2UOjQCb5YwZNhnK7RMMUsJlF4eoFTTXHqHaYbB/l/F3+7oUY2QmGU0AzeQwUFOtEP2O7klQPbAW3SypplQ7UNN3+O23fkQav5qUKedMYlAZtlaWdB2KuOj82APh6EOExBSO9Txr42Vz215OiaoN5j3ruxeAVl8qr/5mo13RGoH9KIT3UCqjwyBKqmUr3o50/9NxW9tbBaGZkjom9G33ync1/K1wAn2sE3sE1uO7lBY9B3ypO8CoEUcMYyczFMUJ3AEXGnyKKIxJquPZuswf1wGCZ3qiEc/3poHyD+HRA37u0lNnS8peX+NCTxuysCT5sDfCawGrmR7gvOHbu8RJw9OxfsoYXpZmGT8uMxDWiJntbUtLyYUOZlPTuZ6ix/qEMQ1OL1g2yx1GQ3+VPOe1HspYmTlNT98zcfnA3VpB7xxIVKbEdScjQr4lT6SkwS8TO+QWxRYvTYR5UaLgyjp1z+JDm5ULheGthNMZrqUo53R6Z83xD9V6tiPJErwKg72gS7/f+OuZzbY2eY8ZisuAhOL7H4uor29lytoqBKJoh6o+mX2r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFhVdm53L1V1bVVaNDA2dU04ZnFqaWk3ZUVhd1lMUTJMMEpHRFVpeDI5bGVj?=
 =?utf-8?B?Z0lUNVBFVG8xekRhNmlkVHA4N25ST2xOa2xDblowYkpUWEFSbmwwOXhHOFdi?=
 =?utf-8?B?Mk9LdFd0Yk5aUjRXUFVSNzY0WnBEYVpTK0YwSFpCcFh1M21haGpLYVIwMkt3?=
 =?utf-8?B?LytKSlE0cW1vQkhlcjVDMFg4OEw0d1loT1d1TExKcGY1ZWMydmxSTzJydGgr?=
 =?utf-8?B?Z0dxM0cxWjZ3UzNjZkJFczlGaEpnZjRJVTd6S1krTU5EL3h1TkxIT2J1c0kw?=
 =?utf-8?B?K2wwRHNXamx1eVFMWlhIeTVoK3kxZ25ya2VCcFl5cktZUTNQVXlMekg0b01k?=
 =?utf-8?B?cFJoMXp3V2IxdlFGOFRpMEY2a2Zob0twRkRpWU02OW5wN3NXelFSTnhTWWpn?=
 =?utf-8?B?aXArV1NPV0IxOFlIcUVlZy8vT09XZ1FmUE56ck50N1Q4QVlqTzJscmNWdXdX?=
 =?utf-8?B?TnAyMmc2eml1VFplZWlHczR4bFFVOUw1eDNBZkoyNGE0VHc2Y3RmMEFFcG1V?=
 =?utf-8?B?TGhaRlc5WUN5Nm8vNUVVblRTN0kxVmdXcS9VbERuQ3kwWHUxaVlickpVQWRU?=
 =?utf-8?B?Nkw0R0x2dTFhSkJ0VzV2U1RnYWQrckc3bXozWkNXQXdZZm9KdFhJemwvcUxG?=
 =?utf-8?B?MlRNSW5IRnVjRlRncHdxSVFNdHI0VE9TemZNcWcxZlhxdzZRK2FJWDZrM3I0?=
 =?utf-8?B?WnZwVkdDWTNUSDZtR0pDRTR3dEdaRXRlN291SGxlbmpvcnFvaEZrVUNVV3hN?=
 =?utf-8?B?WmNlakl4RW1ibmczaVh5RG1TbmFPeVRJQVdyWmN1Y2hpbVJLSVIxTUUwZUxP?=
 =?utf-8?B?NVZzdjc4ZVdLRjJwK3J5Ri9MUG1CSllEUE5WZFFmRzZGVy9SbFYrN0ZLSXBX?=
 =?utf-8?B?akg5bEE0c0xxUUZ0UUIwOGErcDh5dFhpRDc3cWJqYXRYVmJqR3Z0NTV2Yjg3?=
 =?utf-8?B?cDBNeUk1RzhOaU9ORVFEMzRLV1Z3YXQrcnpJbzhyRGM4dUt3eUJiM05ocmN6?=
 =?utf-8?B?NEpmZC9iWGZiWlNieGpGckdQeFZ3ZGI3cGc1OGxOMk9LNHJ5SVg3bXNyRStn?=
 =?utf-8?B?dE1ER1hOajJ1bk5VR2NwQWZ6cHpPakJ5ZHhZMStETnZYais2akhWTkhvcDRE?=
 =?utf-8?B?VW8yaWNKQU1FR2Q5ZnF5TDJ6WmtIK3BNdFNjY29GQld2MEJJUE1YM3daUWpR?=
 =?utf-8?B?VFFjcUsyYjl1TTNVSitETkt2ZlkzUDRCVHZ6VDBFL1NMV21WL2pkeWt0ZmF4?=
 =?utf-8?B?TmpleklnZDBhZU5ZUzBEbUtTMENpNHowQ2dLSlI5VmhCaFNUYTJrKzBxRWFp?=
 =?utf-8?B?MWp6OEI3eWdRMXVMdi9rV28zY0YweEJBRk9NeTJxSXVwbk1IdnFMZDZzRTli?=
 =?utf-8?B?WUVuaHlJMk1LZzE2L01uYzcvbkZJUi9Xb0c5OUdJblBXc2RPQjA2VXZZV1h0?=
 =?utf-8?B?cDVNdVZhWXhSeWpqRlozL2dQTjZFM0dGRHVEUG5pS1VVQ1Z2SVphMDcyU1pR?=
 =?utf-8?B?Uit3UmNlOU9GQTBINjVLUUM0TzEzbnJJeTNBakRRSVNhbWhnT2tJNmJjNHJ0?=
 =?utf-8?B?OGh6UkJWS1JjZU9QMElaakVWTnBVNk5nQUJSZVV1Q1dYUEU2MzI0V2l3bnZB?=
 =?utf-8?B?dzl1Mm1UMytMR3dXaEFoZnJWaEdQejRDamRpU0EwSUdHd25DVjNWNFQxSmtL?=
 =?utf-8?B?YjBsa2xvSHFkZWdXOEFlalhjV1g0bGNDNzBmTzBIaDA1OFNWdFV5bmVzcU16?=
 =?utf-8?B?amF2UG91ZDVPSnh2eFFyUnp2bXR4ckVxQUFZeU9ZVWxwaVdwRjRsYWxCekFH?=
 =?utf-8?B?Y3cwVEQ0Qm9mS3pXMHJYSW9uc2VvaGtVSWVybFRKbUp6ZmRJVGhSeWxheWtH?=
 =?utf-8?B?WE9UM0U4Y1NRNHR3OUJmc2pWYjRWOVdsZi9BRE0zejl4UHJjSU82NmprR2tU?=
 =?utf-8?B?a2xyU0FLVWYxc3E3NGZ2Z1IvSnFJMHlXajA2YWVxQXlsV2FtNHFkY3BhQlhM?=
 =?utf-8?B?SDI4NzRLM0RYcU9lWE9lOTJEa2FHT3NFR0FjQUlSMUFjZGEyS0dNTkhmZ1Ew?=
 =?utf-8?B?MSsxSTdSVWtSa1F2c2pEQ1U3b0dsT2hhVURkR0JiaDduRE5zQ1ZHNkNET2tR?=
 =?utf-8?B?dkswaC90S3h1MC9McUM2QmFmR3AzS1FxYXJsTmxsMGRNZkRxdDcvWEFJbUQ4?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6f9e4c-1a3f-4583-d019-08dc326766d0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:58:06.9168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQbvgztxrBV/6EpZr7Frpe9n5D+30tyjBrWiWzWEdkr6oNCfbae8aChfvUGtwJqLDZu48bdTKJK9gehBwUeoGIzMKjFb0O/Cr1PBVo4SDWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8131
X-OriginatorOrg: intel.com



On 2/20/2024 12:59 PM, Tony Luck wrote:
> On Mon, Feb 19, 2024 at 05:49:29PM +0100, Thomas Gleixner wrote:
>> On Sat, Feb 17 2024 at 11:55, Borislav Petkov wrote:
>>
>>> On Tue, Feb 13, 2024 at 06:44:14PM +0000, James Morse wrote:
>>>> Hello!
>>>>
>>>> It's been back and forth for whether this series should be rebased onto Tony's
>>>> SNC series. This version isn't, its based on tip/x86/cache.
>>>> (I have the rebased-and-tested versions if anyone needs them)
>>>
>>> The set applied ontop of tip:x86/cache gives:
>>>
>>> vmlinux.o: in function `get_domain_from_cpu':
>>> (.text+0x150f33): undefined reference to `lockdep_is_cpus_held'
>>> ld: vmlinux.o: in function `rdt_ctrl_update':
>>> (.text+0x150fbc): undefined reference to `lockdep_is_cpus_held'
>>
>> Wants to be folded into patch 24.
>>
>> Thanks,
>>
>>         tglx
>> ---
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -368,8 +368,8 @@ struct rdt_domain *get_domain_from_cpu(i
>>  	 * about locks this thread holds will lead to false positives. Check
>>  	 * someone is holding the CPUs lock.
>>  	 */
>> -	if (IS_ENABLED(CONFIG_LOCKDEP))
>> -		lockdep_is_cpus_held();
>> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && IS_ENABLED(CONFIG_LOCKDEP))
>> +		WARN_ON_ONCE(!lockdep_is_cpus_held());
>>  
>>  	list_for_each_entry(d, &r->domains, list) {
>>  		/* Find the domain that contains this CPU */
> 
> Testing tip x86/cache that WARN fires while running
> tools/tests/selftests/resctrl/resctrl_test.
> 
> Everthing runs OK if I drop the top commit:
>   fb700810d30b ("x86/resctrl: Separate arch and fs resctrl locks")

The new WARN_ON_ONCE() is why this encountered. The comment notes that
lockdep_is_cpus_held() is used to determine if "someone is holding the
CPUs lock" but it seems that lockdep_is_cpus_held() still only checks
if "current" is holding cpu_hotplug_lock and that is not possible
when running the code via IPI.

The trace that Tony shared notes that this is triggered by get_domain_from_cpu()
called via rdt_ctrl_update(). rdt_ctrl_update() is only run via IPI:

	resctrl_arch_update_domains() {
		...
		lockdep_assert_cpus_held();
		...
		on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);
		...
	}

and

	reset_all_ctrls() {
		...
		lockdep_assert_cpus_held();
		...
		on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);
	}

I sprinkled some debug_show_held_locks(current) to confirm and encountered
the following when reproducing the trace using the resctrl tests:

[  202.914334] resctrl_arch_update_domains:355
[  202.919971] 4 locks held by resctrl_tests/3330:
[  202.925169]  #0: ff11001086e09408 (sb_writers#15){.+.+}-{0:0}, at: ksys_write+0x69/0x100
[  202.934375]  #1: ff110010bb653688 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xf7/0x200
[  202.944348]  #2: ffffffff8346c890 (cpu_hotplug_lock){++++}-{0:0}, at: rdtgroup_kn_lock_live+0x4c/0xa0
[  202.954774]  #3: ffffffff8344ae68 (rdtgroup_mutex){+.+.}-{3:3}, at: rdtgroup_kn_lock_live+0x5a/0xa0
[  202.965030] get_domain_from_cpu:366
[  202.969087] no locks held by swapper/0/0.
[  202.973697] ------------[ cut here ]------------
[  202.978979] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/cpu/resctrl/core.c:375 get_domain_from_cpu+0x6f/0x80
<SNIP>
[  203.200095] Call Trace:
[  203.202947]  <TASK>
[  203.205406]  ? __warn+0x84/0x180
[  203.209123]  ? get_domain_from_cpu+0x6f/0x80
[  203.214011]  ? report_bug+0x1c7/0x1e0
[  203.218214]  ? handle_bug+0x3c/0x80
[  203.222230]  ? exc_invalid_op+0x18/0x80
[  203.227198]  ? asm_exc_invalid_op+0x1a/0x20
[  203.232529]  ? __pfx_rdt_ctrl_update+0x20/0x20
[  203.238146]  ? get_domain_from_cpu+0x6f/0x80
[  203.243548]  rdt_ctrl_update+0x26/0x80
<SNIP>


So even though it is confirmed via lockdep_assert_cpus_held() that
resctrl_arch_update_domains() holds cpu_hotplug_lock, it does not seem possible
to have a similar lockdep check in the function called by it (resctrl_arch_update_domains())
via IPI. It thus does not look like that lockdep checking within
get_domain_from_cpu() can be accurate and I cannot see what it can be replaced with
to make it accurate. Any guidance will be appreciated. Perhaps we should just drop (but
with detailed context comments remaining) the lockdep check in get_domain_from_cpu()? 

Reinette

