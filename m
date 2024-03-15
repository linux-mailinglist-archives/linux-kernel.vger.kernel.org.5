Return-Path: <linux-kernel+bounces-104846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E6E87D472
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B422845B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AD8524BA;
	Fri, 15 Mar 2024 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSUO5ZcU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DB48BEC;
	Fri, 15 Mar 2024 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710530675; cv=fail; b=FVOsNgKOawDASwZXs3gsTXjlpfhLWKXuWwttydzNqdvsEZlj9s4eLv3zhoVifzZKtThWvS9+XGJHkGke8zq7jQvzTrzkqFCAoOSTx8VV0Xo1WMxFbCxfqB1LyLGm4lpvzCpw7bjbt4cHgbKXFzhAdXXxhd4GMGrlEmVj8W600TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710530675; c=relaxed/simple;
	bh=ZMqOeBFXTFemSg+QXF/6KGbdD/FqxIGzBeu0jFfoNjk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mR0ewZu/LBxrXMnOXdGwEQ58VCLNTmW7KpcVp6M0GRw/SInlTUmtwphglyakGr3mpqHc97qtZUQIjDV+gGnU+Rr6jKy6DhHsGjX0+2HxZLAPFaEmytLAhDrqZ/qVf5H4R4zGjzjGZYxS6vYoegeh/AE1n8GG4whac5A+1CpQpQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSUO5ZcU; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710530672; x=1742066672;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZMqOeBFXTFemSg+QXF/6KGbdD/FqxIGzBeu0jFfoNjk=;
  b=GSUO5ZcUOXuyZhRLvnJVM67SiuHGk/lyBaMm8Z6xb0v4pIUuP+iM5zpT
   BX5r3RQ0JccxcSY3KF4yTxi/qFXtb7vJ+8JFlEhrg4Z5NLweVITPFB+5Q
   7h9A7hxXgeA/Q5YeaY6ldGedyY4FpG/tGgIucpB2mxLSr24DQrK5aZXJc
   n4LKnaqyMkup/TiNwrQnET25lptEVdZV5pPnQu22+QTW6aKPhVGXsc0sN
   qFWvyawJY5BVHaIGyvlHdz95UcIK5Uj7lJD1gEPq1h4Nr2ppEDmSF7pmL
   8Aa65NZM29YKlgj3AbENxzwGC88LYbF6xSXVXl54qogU7prsRr3ncgTwP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="22879569"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="22879569"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 12:24:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="13403483"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 12:24:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 12:24:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 12:24:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 12:24:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwBegR05DPBAaSEd6A8JOuySmzqBbFzHo9Jv2PTIitPt6yF8Og14to0fnE12nM2RAXVBjiBcqV3KJPTk7vFkVvCm64OanWKZbV8wXygh9/5C8GKD4Vxfig4NMDiwDo25vukeFSmz4qUW8K1MQBDk82AgJLYoxS3SeWfd6dYO8CdzHl/REgyAkkyU3TexLMJeR2C7GM7h+O8wTlLxnr/M5BF8Q1K98tPN+5dKOxfVgtjedSJqigG/etpjjul/ef0mqjHbidj68/2+um6sjf507JkydRbv3wmrme0o9YVAHKtnClH5MMNmSb7H/RV+wPmUzaIuqBZ8z1Y+NozXi2JhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JwHqTG8nUWiAJtctdjgMykVW+uKlg9ZWn1FBeio74g=;
 b=jdZLVdDJdw32grOrj2aFmdia+0P6SCGwUzZaxMT6cSukE+q9SZ0lTCedzl+i+8Caa7fqeF/YKmqr4UnNBpzKv3GpBJKN6YTZkRUOWH20tZ21ORmGhZVxg8bl6BCkucsyWGm3purPamJTQAOM0t1+YxW5CBn/cYIivdutlWpWPKJJxioGDVfEw3HtRiTH2DaUpmfYMezmQ0D/qnsXhoSwZFd+Y8D/DGc5xgo7GiLRt627lTEB3SYgxDmcsEPtXjamjPzkcKwiSeDY9pWx+zcX+DeQNV0QbhQAO98BhdqivdXH1tVhEKu4ERhqwL0QPx3EbyQ2kCbAUXo2KHNZMnWgvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM4PR11MB6384.namprd11.prod.outlook.com (2603:10b6:8:8a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Fri, 15 Mar
 2024 19:24:16 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::85d1:70d8:4c39:4599]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::85d1:70d8:4c39:4599%6]) with mapi id 15.20.7386.016; Fri, 15 Mar 2024
 19:24:16 +0000
Message-ID: <c9285318-affc-4d45-ba9b-40e3a86be68b@intel.com>
Date: Fri, 15 Mar 2024 20:24:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2023-52605: ACPI: extlog: fix NULL pointer dereference check
To: Lee Jones <lee@kernel.org>, Prarit Bhargava <prarit@redhat.com>
CC: Vegard Nossum <vegard.nossum@oracle.com>, <cve@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cve-announce@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <2024030647-CVE-2023-52605-292a@gregkh>
 <e4906091-598e-4d21-9e8d-4cb088855d6f@oracle.com>
 <7591f33e-d64f-49c5-b7c8-deda2b6f0fde@redhat.com>
 <20240314110110.GL1522089@google.com>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20240314110110.GL1522089@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::11) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|DM4PR11MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 636aede4-7737-482e-542e-08dc45258141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bnMSFRY+XN6JCR11S0MS7hhotoWUU8PtATbn39kLYdmZKiZKuweUCmsub6kz+mUPw60PeNZRL8C3JbytiRo0sytbkke8xShDA7fvg3ikcB52pgdj2RqYhDR4Nc/f3vptiFM3l/socW7rx4gwhqjQ0oHiM4Rgl2bLQ4qlutOYukpIyy6wBz0J0A8AMxzL13LN8C+z3iXv1eYZGYlRj40HLwSkM0+W/Jo0ztrHnjHn4XzrvMcyeh4F7eRQwk5KVbWFcwiZTpnyTTiECjypVvhcOSobp86wNhEdnIhKb4ockmvXyO7QoIpjtzSNYCcswYrIpGTj0rliIjLY46FnEtKDRrsiWVCnZD1UR0dz2hRFot+85Yb1h9B+U9K4Gb6e33OA8QJckb8TcTHIetxrW1wODL7Yv/2+lz0hGH+45nLush+wcieww4+nsxDeqAg2RlInYgpwN+BhsriCQEu8Y3NlixGE7uX1k1qLFpduEQhAXRkliwJuz2lN5xiXBVRxURtD8ZFSMzvt9oBoOTBgB9dMzmHkrY35Kyi8mpd/5bA9pMvT/PtVX2cB8btV645tUoI5hqKlCQgmaATLc3bB4sOjAPb1xDDVteBactoZNVwoxZp9ACEd+UeAv0BewJLlhT8mULJAY+RTzNTFAji+WaCbQaG3AIiy8i5sxRd6mkxtjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUVFYnBXQWxnNSt2RTRVQjEreC9MTzJyd1F1QmJTb1JlYjFoN09ybW1wN1RW?=
 =?utf-8?B?eUxCZ3NIeWh6aC9Da3FtZnBHTzFYcVMwTUczSVYxblNJK2NaaVU3eXR3OEI0?=
 =?utf-8?B?eFV4Rmg0azRqZUU3MGFiU1pGSC9wc3hFUlAyL0tlRkJVZFVuL1hTOG1IN2h2?=
 =?utf-8?B?N3RNcW1aY1NWeG50NjlwTlZLVGg3RFlCcnhDZ09OTjBwQnFRTk02cm9POWpt?=
 =?utf-8?B?S2d4ZlFuNzFpUWhsTmxLMjlpeEtseUFSVCtGZk5hOVV1ZmFydC9IdHRudGhn?=
 =?utf-8?B?WWlpK2pLdHVDeXlFT21YQUJ2MzQ5TGJ3WUpxUmFkSEM5ZFZSL29zeEhwUnpt?=
 =?utf-8?B?RzlJa3h0Rjgvc1doekxYUGZqNkxUNFViNU1EekR1RU16OHFVSlRhWFhDWTFx?=
 =?utf-8?B?Mytwdk1vTzBxcHlybWx5NE1uVjFkcUs5bkJSNGljem5hT0w3Y0VKcGh4R0d0?=
 =?utf-8?B?RVpmM2F2Mzk3SzdkOHU3c3VFQ1BrSVRYWjQyMTI4d3BYYVlaZGRHVithYjZT?=
 =?utf-8?B?T1JHVGlaYy9YbXFQY1pWYm15V2RibGNyN3o0UmhYU3MzMnZPVmhkYk52UU5N?=
 =?utf-8?B?NExhVExDVDZUa0RpSlhOL01laEkxM1ZmaURiblhMSlhxSWhzS2JwcUNwaEtx?=
 =?utf-8?B?T2VFRFdSTmNueHhsZk15a3k2QTNmMFhMYmRHb1pZcUlDMVM2Z2M5TU5HZHlB?=
 =?utf-8?B?SjdrTVBtdHdPcXNPQnpHMmFtcWFYaVVhTC9ZY2paSmpVSWNUY3pwcUZ0WFN2?=
 =?utf-8?B?VzNKYy9rNWsyNzlSQ1dGNFRYd3k2dWREdUV6UFBuQThYbTgyTk5GU0ZYMHVh?=
 =?utf-8?B?ekVnbC81ekcvbkVZUk9SbUlXYUZVc3dwc2ROb21FdkRPMTUycitPUUE0L0cv?=
 =?utf-8?B?QkVaalllWGxiNndXYkhzSkhld2xjQWtJN2J6S2pseUhMcVIreVF3WTFOQXVq?=
 =?utf-8?B?UGR2WXZLMExBZkdYNWRaVW1pdm9Da1hjcW50WGhNb25MVVhpbHh1bDVXd1lB?=
 =?utf-8?B?K1czbUV2eDA5MlV3TUhXQzhnSEJlWjhmQWxkNkh1ekFJdnFQbElFc2QyL1cr?=
 =?utf-8?B?UUVTOVpJN2JYTU9DZU9sZlFrSitDeG1YOW8zVnBoSXRvdjNpSi94U2pnY3ZJ?=
 =?utf-8?B?ZmVNcnRCR0hVVzUyN0RYRWxUNVNyOHg4Mk9BNlZHaWVmOHEycU1nejFUaHZm?=
 =?utf-8?B?UU8vZEp0SXNZQit4YTJ1SkVzbllPN2R5U3F1NHNpTHQ3Rm1Ka0hBd2dsN2ZP?=
 =?utf-8?B?N29FZGxYNmRuQkhTQzZoVDRTeXhicHJiNlBtKy9TZUhJU01mYWNyY0Ntbkln?=
 =?utf-8?B?OWs3SStHeFlCY25tVXBkMjRNK3NHc09jK1UzSmZHWEIyc3c1TkM1RExqZlFk?=
 =?utf-8?B?M1dUZ1c4aTJJRk04SlczZlRVbzRvOHFsWG9ESlNKR0NCaVNQVHcvMzB0dzlI?=
 =?utf-8?B?aFY3ZjVubzBlWmt4d1lBZFlmTy8zd0FsSE1zWnhpZTJKcGVmYjl5a1JHcFF1?=
 =?utf-8?B?cTM1N2ZSQ0ZXYW5FY3VIQWJyV1Q2TEU3N3ZvNTJ6VkFGRklBZzFqY1VOS01p?=
 =?utf-8?B?QUNUNTBQNXRTbDBMK1hENVpmOGdUN0w5WkRSbGo0T25xeUxrZnMrVDNSUzB4?=
 =?utf-8?B?UEJYakJESkVtcWRLdU1DV3BMSEZ5ME4vZldhQXJSbjJvUktCaU14bENmRHRG?=
 =?utf-8?B?bEhkNnZuT0VRc3hSRzRETmY1N3phcFhDYnpPb3ZoaFUrRW5IcU03K3cyRjI1?=
 =?utf-8?B?SjlTUGVTcy9ZMFlFaHgvMGFqczJkdkhKUHFNbURXNG9zaWpMM3ZiTm9ZTXh6?=
 =?utf-8?B?NzU4ZXBmU1JrdkNBbmt2RXFDazFFVDk3QjFlYzd5OUgrNGloOXYxdlozUGVG?=
 =?utf-8?B?bDVtN2dsVnBZVkxhZFlZMnYwV3YydjhRbTVJRnBONXo0Q2tnU0xheFUvaC9O?=
 =?utf-8?B?VW9QTlhjQkk1L2pQUmZHOTlVbXNwcmRBbHZaaEprV1VJeUJONjRWNmtQZjQw?=
 =?utf-8?B?eHBHN1BQZXFkMHpId0JTSGxwOGd1NjcrTWZKaTBLclNHYVNZR1dRT1ArSHJx?=
 =?utf-8?B?SjNROW91U1FSM25CQ3JQMnRwVW9VZ0tvSFpYZi9ZaDIzT0Y0QmhuSm8rTWpi?=
 =?utf-8?B?U3BULzkwYjVPRDNGQ3hMSEFtVnBhQmZDOTY3cExZdHo4WmcyMkUyMWxVeWtx?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 636aede4-7737-482e-542e-08dc45258141
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 19:24:16.7463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LbPxiBxynzJTunUqALJoHnNo7dMn/kuK03u6f1O4+kivD8+du0JZlUvHgTXrIC0rsdZQ2/Qqul/1sX036uwrhLrliR31H/qABWP7o2DR54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6384
X-OriginatorOrg: intel.com

On 3/14/2024 12:01 PM, Lee Jones wrote:
> On Mon, 11 Mar 2024, Prarit Bhargava wrote:
>
>> On 3/10/24 04:10, Vegard Nossum wrote:
>>> (Added author/maintainer to Cc)
>>>
>>> On 06/03/2024 07:46, Greg Kroah-Hartman wrote:
>>>> Description
>>>> ===========
>>>>
>>>> In the Linux kernel, the following vulnerability has been resolved:
>>>>
>>>> ACPI: extlog: fix NULL pointer dereference check
>>>>
>>>> The gcc plugin -fanalyzer [1] tries to detect various
>>>> patterns of incorrect behaviour.  The tool reports:
>>>>
>>>> drivers/acpi/acpi_extlog.c: In function ‘extlog_exit’:
>>>> drivers/acpi/acpi_extlog.c:307:12: warning: check of
>>>> ‘extlog_l1_addr’ for NULL after already dereferencing it
>>>> [-Wanalyzer-deref-before-check]
>>>>       |
>>>>       |  306 |         ((struct extlog_l1_head
>>>> *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
>>>>       |      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>>>>       |      |                                                  |
>>>>       |      |                                                  (1)
>>>> pointer ‘extlog_l1_addr’ is dereferenced here
>>>>       |  307 |         if (extlog_l1_addr)
>>>>       |      |            ~
>>>>       |      |            |
>>>>       |      |            (2) pointer ‘extlog_l1_addr’ is checked for
>>>> NULL here but it was already dereferenced at (1)
>>>>       |
>>>>
>>>> Fix the NULL pointer dereference check in extlog_exit().
>>>>
>>>> The Linux kernel CVE team has assigned CVE-2023-52605 to this issue.
>>> This code is in an __exit function:
>>>
>>> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
>>> index e120a96e1eaee..193147769146e 100644
>>> --- a/drivers/acpi/acpi_extlog.c
>>> +++ b/drivers/acpi/acpi_extlog.c
>>> @@ -303,9 +303,10 @@ err:
>>>    static void __exit extlog_exit(void)
>>>    {
>>>        mce_unregister_decode_chain(&extlog_mce_dec);
>>> -    ((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
>>> -    if (extlog_l1_addr)
>>> +    if (extlog_l1_addr) {
>>> +        ((struct extlog_l1_head *)extlog_l1_addr)->flags &=
>>> ~FLAG_OS_OPTIN;
>>>            acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
>>> +    }
>>>        if (elog_addr)
>>>            acpi_os_unmap_iomem(elog_addr, elog_size);
>>>        release_mem_region(elog_base, elog_size);
>>>
>>> This can only run when you unload a module, which is a privileged
>>> operation (restricted to CAP_SYS_MODULE).
>>>
>>> Moreover, extlog_l1_addr is only ever assigned in the corresponding
>>> module init function, and it looks like it will never be NULL if the
>>> module was loaded successfully, at least on a recent mainline kernel.
>>>
>>> Since the module exit won't be called unless module init succeeded, I
>>> don't see a way to trigger this bug. Is this a vulnerability?
>>>
>> This is certainly not a CVE.
>>
>>> It might be better to just delete the NULL check altogether.
>>>
>>> As usual, I could be wrong...
>>>
>> When I made this code change I thought the same thing: Perhaps it's better
>> to remove the NULL check given the status of the code.  I assumed that the
>> check was there as a failsafe on unload.
> If Rafael agrees with you both, I'd be happy to revoke its CVE status.

I do agree with the analysis above, sorry for the delay.

Thanks,

Rafael



