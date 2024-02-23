Return-Path: <linux-kernel+bounces-78816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5B486193A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E4B286559
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DE412D764;
	Fri, 23 Feb 2024 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mvXxqn9H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76203823AA;
	Fri, 23 Feb 2024 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708686; cv=fail; b=ehSYiiMyxotGMrz7U2Ns20YIefFPgEL3GaUsM9OsBw8XoKfgNiQf9ptIJUIs89DvfqdXY3wZ18zZv7+XNmV5bz++2VIw9uLB64lkd2RLoNLW8Yg0OJ/tU2MECnYhDIwN/4W4qOIOYhLTiWzI43WyQNwNnIf+hCPg7Y+P19zhN1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708686; c=relaxed/simple;
	bh=sjaSu0XutEkHD8lLOJnfJkR5MxpJOPjKqXiis4fvQX8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hRtu4fY6T/GmvrhaX/7l0KjkmA7m2p0VhTk1UPvmFiCcAGC0ZOTbo+0m2k83EzJUtRrqFm/MVzQVLwGI4FEgIyd1lC92rv6GcAgBga6OM8MCmMNi3bf4EZJuhpyXjrW7mkJPumUS3xiw2y/NhCSDSTjahNeQrVPLQYKXrD2EOr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mvXxqn9H; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708708684; x=1740244684;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sjaSu0XutEkHD8lLOJnfJkR5MxpJOPjKqXiis4fvQX8=;
  b=mvXxqn9HZI71kLMHZdaO4XuzP9kSCUkLvSYve+xcsq2L/9AO643rlOjb
   57PooeCo2Xe0yjv63L2NELu7Gke9QBxsjApQJxvevFgOdssrKa9TH9+5U
   APh9T79GDmtLbKO1sPctqgIORkVRRJ2dj8q2wezdIMUaro4KSFKD7njxD
   FCgBeq9Pf9Hy4minF4ZBU6AzqSBMXAzgpps+J1VsnT7GU1EMQtXiqO8wn
   r68qF4IuBOERLWPjQuph5bTkifl8xkcyXuM6wM8YJN7OXPhqr7uFELKeX
   mOw/ma6qbmjt4EUV6sXNmCfQ/CxEmD5sEGxAYCH8eCC2+xJA1e2h9tkDV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="14445070"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="14445070"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 09:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="10533635"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 09:18:02 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 09:18:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 09:18:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 09:18:00 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 09:18:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG0lYYJlM+7LGRjCdAKEJp/syiKDjBZ3nmJFjcofOTush0nlezh96n0GXY8WGASpEkYOcbGv0gM/IxwErHvUuYE8V1YzBQ9vERAY1jCCAbGByqSJWkr1cqWeT+gjBjgY+hdszK/bWTey/Ql8IcROhfPsQXIkzlxfsFPjqvPCrxMyFKiOZtPiPH/Ebo0gBLSsVL+lZDqjlys9dV6d5vDFO10qRYrnCiaZQC+Kvu4NbBr0Eq/o7SFpFG74AXz0l1rjEWODcvb760964Y/z1vLWw87Oa5P2KD1F7VELiL/ABNUbZnszQ6cdP5F3BY0Cw8zfEbamfG6E616IHe01+ZVPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivRenUHvhI/4LMOWi/FPd6Oq+dctz6nbHdo6EqhnXFg=;
 b=LVSyTGMKN9SAFuL/qh7UnD8g9l2BakyLiXr9mnS21yNxR4wcSAsdSnHFkc0Fhp23crcp4JkPV6J8Y+QfmR1kaMh/Weugrq3dWY4spUwCGnwh7PrFutPhDp+cjrCM2ASYMM6CWZAJpql7evUHEpUxNIRX5jUJfKoK4JpsX+JPNaCh97w0l4ZUP0czRnMS43VwrLRJ+Ku+UyZ4JiIhExOoVlX8cnWzrYo1SsB32A6gq+dHbmDARcp/6WPch4leFUjhiF8XcoR+4+yYf6hlXRGpNwEEfVredqtZKRl0BugnpIEFcdKL1gJjoArBVm/PrgnCbXmSKtXkWlWX9JNW5JElkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6251.namprd11.prod.outlook.com (2603:10b6:a03:458::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 17:17:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 17:17:57 +0000
Message-ID: <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
Date: Fri, 23 Feb 2024 09:17:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: <babu.moger@amd.com>, James Morse <james.morse@arm.com>, <corbet@lwn.net>,
	<fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:303:8d::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ1PR11MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b853a67-d3e7-453f-bd13-08dc349360d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7sCz5ogTr56tSj42Lsa6nF/wNXaOja6IJ8OKjZHQQEqpSWAKG6fwPeMgePq+gTCBkk2Un2+OrGnigmyM5aR2mTW9GpH68vBqLmu1vo5q7HKs+Q9sVVsxh1Z73phu+i2aTDZ5YTCK4EIizO8ikfVwFECOzEiRpvcDRgPIhEPpJYPUBRcgkwgV9Hdr8MxVBGvagtsLJazHah+H0LDYZPpXHFgFa3UOylLiPVJgthuWbfsVS/8HUbO7rI/+iUc1I9mlvul/e7HEAG5JHec+4RMfIX1hkdSM5md5Vb0j2tIyO+L+7UFJk+zjV8f/p3ATGan8NuE4fYlOIyhPtstMomBjp70PK99YjWocOT+ov9CjtHeBY6YYUSfAuA0bZUwZKZWhJjsh0ePe0sOSnkJhaP6vp6Yy3584S4AEH9LZlsVZ9wewU61Y962OuuiSJQ5w6tbqqzFx1teBzcMQgP8bzpaF6edxD/wszZwm/H6tdLxCz2Ezv/QyKBCHAwd0EkrhXf4/yakQB7Pf3cYhxsRQqt3gJQz/uv2B5hdfKmdZnDN6/RA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3NldjBuQlNRdUVGNlJ5SnBTUG1qMVpNcGpFQ2lZR2w1K092d1dCNEk5aUll?=
 =?utf-8?B?RFl6SFB0d0FkeVVncTBZZ1VXczJ2QmZsMENhbDcyOUhKVUxnQktmaUg5UExP?=
 =?utf-8?B?ek10SlF0dTk4dWpZZnZtTmpxbmRzYUFsRVRQbzU2OTFOaE42eHhtVGxoTDNa?=
 =?utf-8?B?Sk1YQWFZSkRZbFpnTDhOK1NCOThoK0FNcWtyZGloOWxxU05vUkhvU3RqbkY1?=
 =?utf-8?B?TXFMN1hBTzJqK0FHL3A3OU1zVjV0cEFhWk41ZUNqQ2pRTHg0MDJsQUJyWEc4?=
 =?utf-8?B?MnE3ejJyT3lLWUVqTGwyZmFsK2ZXRGhMa2xkY21BdTVaanNVc2YyejV0VzRP?=
 =?utf-8?B?K245M1BDOFVFSzY0bENkK2lQU09lOWYweFlMWWhDV09oaEZaUmtVZTFFcGJw?=
 =?utf-8?B?YmNHUXBvR3BCSVlVV3V4MDNRTmo3eEU3eGhLN21PcnhodFFIMHpIZWhxQzNt?=
 =?utf-8?B?dll0ck8xZ0lMSWRtc3BTV2k3ZWJGeEdrTVhFelZTWlVMUTNtL3AxL2NmS29M?=
 =?utf-8?B?VGh3OWZmRUJSNklhSWhqR2tueHMvOHZaQitRWmFTcDFTNS95eXdwbXhOSEUx?=
 =?utf-8?B?Uzd0Rlo1Q2JDNHFSMWFWTzZLdUFUWDNqajJTK2Z4Vm5NS1NDc1ZwOGNLOXp4?=
 =?utf-8?B?NXZKTFFheHljMTFjUytzUzNpdlcrekVFeDRoY2hFRENMQ3hZdjB0M0J6NldF?=
 =?utf-8?B?S1l2dXRiTGI0a0N3RVpuL0gxcXZXaDVod1R1U29sV2tpSVJ4RU84OVJVMnR0?=
 =?utf-8?B?ZXphMXRjUXg1clYxR2lXckxMVFZWSFdiWCtNa3lxK21kSWYxWTVhV1VRdGZX?=
 =?utf-8?B?RFhwRW9TVHpBSnErRHdTcVhFL2xxOGxqVUV4aXQ3ZzU5UEdpK3pNd2tmR2dq?=
 =?utf-8?B?ZmVJR1gycDZGZVhpdnBWSXBYOURieVZ6RXhYMmdMMHEwanU2RWc2SGhEVWpF?=
 =?utf-8?B?c1pHd0Fid0NjY25vYm9EWk5Odk1DMGx6Q0J6K2J5MkZHWTRITnZqaTMvK0tP?=
 =?utf-8?B?TkYzVTBFM2l5UmRON1FaZ2ZmK1Y4VVNkdnl5V2Vzc0NkVXZhVlJjQThQMC8x?=
 =?utf-8?B?dHNRZGc3dGpINjRxM3c5Q3VQMjBId2RXSFN3WGhGbTBzd2JLbVg5dzg2bHBF?=
 =?utf-8?B?TzZaLzdNakdLb2REK2hxa08xeXlORkx2N3E2WWd3VkI5aHhteGRwVEpxRmxn?=
 =?utf-8?B?bUFCNVl2SklwdGlUbTRoZCt5bDBZcURqMHFPdTFmclVxMms5ZXdIOS9weTBn?=
 =?utf-8?B?V1JidkpTWUVMOTlacisweEd2a2tLWlhkZDcyb0FTTmIzZWJYZE1sZDhVbUl1?=
 =?utf-8?B?MWdIMHFVUmpnSGRzRWJrSGxKTjk3bFBMMmsrQ2pRcFMzbFpETzR1ci96cXFh?=
 =?utf-8?B?WFRJVllJWlJNYTNkZGY4UVVOcWp1YXY5YmEvYlYyNEJPKzREUjFQRjJpRjRY?=
 =?utf-8?B?RjhpbW1Kb0dzZUs2Yk4wUVFpZnZlbmxZUWZnckhCU09XbVEyMzR2VVZ4aEti?=
 =?utf-8?B?bGxsMGxkYmlYWlR5QTU5ODRpY3VYYzFucjBBZUllTFp0UldQUVM0RDhFaHVS?=
 =?utf-8?B?MkN4RUZDRmY3NzgxQWtyZXhWVVlwWlA1bnVuY29pRHV2TTNRZDBOdTg5V0t2?=
 =?utf-8?B?SSs2Mk1rN1RCaVFycERSTUNjOUFvRTlMeTVuNms5TkE5QUYwZ1NSSGIvbG1Z?=
 =?utf-8?B?cG9ML3AzUDZnUEdXREZLTjZpUjZObjN6bWNBcmt1K2I4YzBmU0Z0R2pyd0l0?=
 =?utf-8?B?Mkd2eDVPY25MTzZXSzhodS9IYjI2QTFydG1ldmlLcE9uQW1XZDY3a0tSdVdt?=
 =?utf-8?B?SGxONFpWOUFwcmZvR0Z0N0puNzZOUzNkZlRFVWNVcUpvSTRHdnVrQUtXNkFo?=
 =?utf-8?B?TVR0czNiZGJ1b05UU2JINStZLzdsalB5VzRJNDlKSEZxWm9Qb2JUZ0dJOHB6?=
 =?utf-8?B?andRdXdEYlVIZHV3algrUHkzQzFmVVB3Y0ZkbUs2V28vUUxKaCs1Y3lQa1Zw?=
 =?utf-8?B?THZhTzNuUVJjclNlUGduMkovSmNiTWM4Z3VWcEJqYVlhQzAyZXh1RW5MaVdD?=
 =?utf-8?B?NnZ0TTlJaGJOS0ZqMFhuajNMcGM4V01xcnI5UExGMXJoZ01XY05saVYwVE9q?=
 =?utf-8?B?VkY3cGx5RUFOMnFyaE1QREVxbzJZcWdPSzdJOUIrYndNaThsNlA2MjhTdHI5?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b853a67-d3e7-453f-bd13-08dc349360d8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 17:17:57.1407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZJ6x53RWCCkKUZDRHS+GmkIc62g5tRO6QU3KADQ9BeGfVy3oBG6h0CVQCBKsW6XIkOxF/i3QpkIVRkoK1i9KZ1wV1v5fQtjaWZdXtKK9pQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6251
X-OriginatorOrg: intel.com



On 2/20/2024 12:48 PM, Moger, Babu wrote:
> On 2/20/24 09:21, James Morse wrote:
>> On 19/01/2024 18:22, Babu Moger wrote:

>>> e. Enable ABMC mode.
>>>
>>> 	#echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>         #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>         1
>>
>> Why does this mode need enabling? Can't it be enabled automatically on hardware that
>> supports it, or enabled implicitly when the first assignment attempt arrives?
>>
>> I guess this is really needed for a reset - could we implement that instead? This way
>> there isn't an extra step user-space has to do to make the assignments work.
> 
> Mostly the new features are added as an opt-in method. So, kept it that
> way. If we enable this feature automatically, then we have provide an
> option to disable it.
> 

At the same time it sounds to me like ABMC can improve current users'
experience without requiring them to do anything. This sounds appealing.
For example, if I understand correctly, it may be possible to start resctrl
with ABMC enabled by default and the number of monitoring groups (currently
exposed to user space via "num_rmids") limited to the number of counters
supported by ABMC. Existing users would then by default obtain better behavior
of counters not resetting.

The "new feature" could then be viewed as adding support for more monitoring
groups than what hardware can support concurrently.

Reinette

