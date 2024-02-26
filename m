Return-Path: <linux-kernel+bounces-82333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65248682F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A34A1F26D91
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27B1131E35;
	Mon, 26 Feb 2024 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKHVHd2s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CC131732;
	Mon, 26 Feb 2024 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982516; cv=fail; b=tUS8XrTokPvzQxnDBNJHD2w0xtK/JvjpV7JFDvq/1WV7UyLyNTaaslx0Q7JGOObOnVb0lSgB6ofOyzQzZlng5mc+5hfJBZspIVvDkmtLH1WJKxsyYPlgzCtZouoyKSv7t5CFNRxsZSMdr48HxwqjEPJVaaQ2PePZdun+qNl9Moc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982516; c=relaxed/simple;
	bh=vz9jKJxdeEFau6Dgo5xfM3hZJp8cnLdt1wnXYHkdRWA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U7WYTT5oa2KRd6Re5OO38PDS+Flk3u7dRDbuLaOtFAxZPlArJALfpyk1uALNXOHmDyh6Kk1OW3sN2fnDTatANP6GztYQsOTgJCKcxIIf7gidcEMq3ePnpgRQ6cwOGqp91scPU/HP9tpjcuFh5lsCUxOUinR5fknyeCdoI4gkQpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKHVHd2s; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708982515; x=1740518515;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vz9jKJxdeEFau6Dgo5xfM3hZJp8cnLdt1wnXYHkdRWA=;
  b=LKHVHd2szWLXPR6B/qVQ9Im+hvXMS92rcohlFgE8V8m2nyjtf+AQvArb
   qD4qGGEvG3vni0gbi4SP+CIJPfkwVbC+8dp/i34u8gVQ66GSxNbZx71f7
   sbSqH5HtnD/2usbmusXEdzj3l+FlErC9TzJFx6IRCG6qCuLvhezvyMNz8
   IR/lFa0yvFBAwww6jHfDF3OXM93vQfon67vaa4lw/uiei9zbKQ0WvHq4o
   7b39AD/Cl47nppSRMgH4miZRAfs5IpCzAkFUb4o8Y9WWLO4KWtG4Sxlj/
   C696sBQbjZD5QB06b4M3XYeZQQqEAVDcfpXKmRLFKRoktToCwBdDpbSRh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7115205"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="7115205"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 13:21:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6743217"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 13:21:01 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 13:21:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 13:21:00 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 13:21:00 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 13:21:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARJrBcVCmBNlOtgwweyHE7xjxBy/NoWVz31XInvNEdEZY8euZu7D/FD5uzSoOV4llXgD1bwoiKIed46TzvDW/YOvi5PTptYElDayGnfKTUwjOaVOo4EIA/Zp7Tg4kFHHItJn2urbmctIIPmzeY8T4IKDaFsPsfqvy+lGIvwwJQXkJvjvkKP8cYoHz75ff1y6kW+Cv5GgqNr4coHbiYL0LhhvXqLHoH/RbZ+Ugbw4YE4xbRTZlPzY4iX5y845uHGyNUPGkDnH/XTN/+CT5L16OyUZnAQkuJ9+yp5AMGV9nXYeixBFl3H+jdeTjZf9ZL1Ii62lBMXvmD6tziyravnTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TF7t5tH5NFPoitBTpndmzsRuQm9rSz2zZHXbUiHqpBc=;
 b=QjyRHBJ2qYTQkSDmuQzV45A1Qic8NWAlCferv4UEWEwaEwNamHz+l8ishOqK8zH2yznUz75GBTZGCUJIxTx6I5dcp8bh5MK3vCPMghsn6ihutY+fZRLauptF6DJTm9/HArcQ2nW5yuxDRTmwES6HcBxN0RZ5xTaUVMDadTkOX7qylQF+DWNo8mwWqT9fdumvNn/K8rRrReAC3JwsraUos7TK+MnGzARqKDFhwDviLPBOuSjL95bAw4waA7SeRlGWGZJungg7QqfqV1EFr/xwiRGi8S5LhF+Q2iBOIe8C0CCKHMmNSq/WI53bypiZz8Y5vgFWMLyKtscAr8VlPho6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Mon, 26 Feb
 2024 21:20:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7339.024; Mon, 26 Feb 2024
 21:20:54 +0000
Message-ID: <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
Date: Mon, 26 Feb 2024 13:20:50 -0800
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
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ccb41a-dd81-44e7-c49e-08dc3710d0c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ax2hZqravj5wv315EEsZlG/udwbXlE7Arvj4+FPV3Ir/ROQfCopIsUH/7RbaZtdjamr171YwmTqK9I+s6lVxHGmdRALChLnJ9m0kLgyInjOOEZOKq9qeAqgcRQNIa03Vy9LWyOtzcxSNychOejX7XZ9dGkyiHJ9aH6+8wfRuMgkSDHxxGvfP5L4XVgAE3JgKGxms760PX2dvGaPcLEx3aNVVCHbdIryQtRtTT9Qhm1HHp2+rMVRhng9RjbZ3W2uPeJG2FY1TEKAsLqVy0aVrANGeTnuREhtg/kenWuHcd8q50STia7sWxGMzYLEXO9/K6H2QOn3MajcVropsuK8SSwFVM7qJksoMzF0f0xX2C+np/qiAksJSptBGtImG35Ev29OxAiB3qZC0lCzMZe+9I7ZWNxtm56DmLS8OmzEcvm/4Ar/g23orB5ymfrNByPIpCAfCKiwEswNSi3qzl3UsY/xi8mbBbVLT4a0pBTfHUAre0SyrUMUyO63EbKWURFv8eA6NUJGDQmEMQovLka+CjVs8QjZzTz+NM6avh6F7N30XqxplMxgO0ZyljXXQ/bM/CApuynR4qR340ZezQsbmgPuHOHOttktNAKUHe+vze2s4AqAOJ1mG2420DqpKjJYs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUVodkZYUXJHZ3hiWFBKM1FUKy9ZZ3FvNXRUdnE4dURmYlAxSnhkazl6SHRu?=
 =?utf-8?B?TlhTWHdvNngwVzBXSjJJN0dzUFhwQlFubVp1YTJGV0crNDVlT2c2ZkZ3NkxJ?=
 =?utf-8?B?ZVVkbG5KRnVxeXoxenJPR1pXbDBYSm11WUVDWmJ6RzNiUTBzMkxGUG1YWXRH?=
 =?utf-8?B?RlpRdElYQU5qMi9rdGZBeGtIZjV0YjRDcjRJK2FJdExXOC9IQ0toQ0NvTWE5?=
 =?utf-8?B?SnlHbkJhdFU4dldjMXRiWUtHMVRKRjArSmprTE1RSi9nOGJBS1JmV3dVR3Bv?=
 =?utf-8?B?aHhQR2RiSVB2OHAwNDBDK3NLZUo3aVNDSXA0NVpnUTRTOWhVaDBSUWRwN2NH?=
 =?utf-8?B?eEVZSTVYckE0VU1YTUp2ampBM21GRXRGeG5TVlhOTkdOemJFNW9DMUprbzZv?=
 =?utf-8?B?S3lpYW9uemF5UlkwQzFpT1JNU2ZVUEUzbnJ5R1cvWnFGVHdjbVhTVTlISzdN?=
 =?utf-8?B?YjZodmZ2dE5SWS9MNUR2YVFBMm05SktZK3o5eFdGV0kwaFhGUnJUdXBnQ3Ew?=
 =?utf-8?B?SWpJS281cFlHSkZvM3YrT2NjZ3U3UStUdWV1dW9rT1R0NnhrWWhxZjZYM0ky?=
 =?utf-8?B?T1g1VVBzNHo5bHo2bTVIQkVURUx6M2FuUGpUUFE0cjVTTE01WEhEUkZBYTcx?=
 =?utf-8?B?VGtGb3JFSGk4ZE9jSU5pZCtZS2lZWTkzTUMzbXg2NnhKQTh2RFdTazZDek52?=
 =?utf-8?B?empXeStxRlRocUdkWlZuSUNwTGVYc2NlcWZvNEJlNmpSN0pod1lVU0c1ZUt6?=
 =?utf-8?B?UHNqMllHUkNmOTNBaHRjdFlMT2Z6UGJjVkpEMnRNUGFjMDJMRGE3WC9CNmFE?=
 =?utf-8?B?VkdSV2xuSlQ4dWFTejNxaVAxK1ZsTGJ3bGFHeldIMjhnWlRXZkF4U0l1Ky93?=
 =?utf-8?B?Sk93MWRFNzBMUGZ4clh5NDJIS2ZQTy9LeHNTRS9oRkdEa05ET1Bjd0JUZmtj?=
 =?utf-8?B?VWJudWRCYWlXeFRXQzhPRmVLVE5YZjFwQUl1bGlUNGh1c2w1WXFkem9USWVU?=
 =?utf-8?B?ZWd5VzVJcjJzN1JBYjZkbE9xUzdEYmFRVjNSRm5yWGhxUXN3S1l4bU1SYkVn?=
 =?utf-8?B?ZnFnQi9lTkV3ajN6cEZEd1BISFZuSDNoUU9VaVRzVVUyZmlnYVhiWFJBUmFN?=
 =?utf-8?B?aHAyNnhwa0pKaFBHQXozREFRdG1ZUXVrOERnNGYzOWtDWjh6SEljdlorazhY?=
 =?utf-8?B?eVV1dVJaeGlQTnZFVWdFZFhjeC9YdlA5VXpDRTNhYkY3K1RtaG54bk1sSkpK?=
 =?utf-8?B?Y1ZVaG4xY1Vzc0NTZlpmYldmZlJPd3huM1huMEN5ZGVQS1pDYW8rcWovTTlK?=
 =?utf-8?B?ank4NEQrV0hNcStSVytWK2Iyd25FTTNJays2OUo1SkdTK1hrY0xrRGFidEJz?=
 =?utf-8?B?UWpaOUNtRmd1QWt3VVRCM2xmYjQxeFNyeDBxTEw0ZWsrM0M5NXo4KzdGVUhh?=
 =?utf-8?B?QThiV1V5U2xVWTMyZFVzZUV0YWR5emFrNXlxMU5UeDlBRkxXWTVXb1A2aFNJ?=
 =?utf-8?B?Rlk4Nkh5a2w4VjFBVEdoYjRMRnZsSWEzTFdxLzdsalVGeFJzam9uWUFLcmt0?=
 =?utf-8?B?ZmtFSUhYdDRUOXkySFNFcWZhNGJxQUJYajJIR3pBWExFTSt6MXV4QUFZOWY5?=
 =?utf-8?B?L0JGRWZ4YVY2Qno3Wm03RGV0ZEpoejJ2UG16UHRvTk9vN3FJT1ZSa0Q4c0xY?=
 =?utf-8?B?Qi9PS3ZYYmtseGRpbGNNQmc4WWJwU1JPbzRLbTlKK2RrcFF1QWU5OWtGV3gy?=
 =?utf-8?B?cDNwSnZjTEJTQXZnY21NdDN4MlkvbkNFSE9Ma2xPeDNDRzFmazBOOGNTbFZ3?=
 =?utf-8?B?VmJUSHRJQU5YU2xWTXRwV1FXSTRhK3VheFVhd253Q25sK3czb0lXcUFJbVJM?=
 =?utf-8?B?b08vSXRGaDBMTW9mdVc5eFdXa1MzMGcrVEh5c09zaDdOd1FSbVZzbUpoRUtn?=
 =?utf-8?B?QUpESk9QSHZ1NFpkeHFqU0NDajY2WHNNckh4TnhUN1RWbHZMcStrbUxLT3F3?=
 =?utf-8?B?QU82UG91K0dMNUZjOGN3T2Z6cC9lUTFZa2p4ZEdXWEZKZzRBdER4dS8vSnYz?=
 =?utf-8?B?NS82RHFoM1hEQWZ2SFkyRzBnZXVrQ1gvUTMyNlBPR3pJdTN6dThPdDlFWVlN?=
 =?utf-8?B?Ui9EZVA4cVMzeTBRNzhWSHJJcFhtVnNMWUJla05ONmhleUpPeFQvQmZtNFow?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ccb41a-dd81-44e7-c49e-08dc3710d0c7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 21:20:54.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqHHIlJEPzv6ngKk7/+q+EjE8jujY8W/q4ZEbsPCoxBkCSNxWFErYRcnKNNBfLJUo7L+TE5acWmRV7+UpcoDxMNpQTVxQuSP9zvDxlqAnVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5645
X-OriginatorOrg: intel.com

Hi Babu,

On 2/26/2024 9:59 AM, Moger, Babu wrote:
> On 2/23/24 16:21, Reinette Chatre wrote:
>> On 2/23/2024 12:11 PM, Moger, Babu wrote:
>>> On 2/23/24 11:17, Reinette Chatre wrote:
>>>>
>>>>
>>>> On 2/20/2024 12:48 PM, Moger, Babu wrote:
>>>>> On 2/20/24 09:21, James Morse wrote:
>>>>>> On 19/01/2024 18:22, Babu Moger wrote:
>>>>
>>>>>>> e. Enable ABMC mode.
>>>>>>>
>>>>>>> 	#echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>>>>>         #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>>>>>         1
>>>>>>
>>>>>> Why does this mode need enabling? Can't it be enabled automatically on hardware that
>>>>>> supports it, or enabled implicitly when the first assignment attempt arrives?
>>>>>>
>>>>>> I guess this is really needed for a reset - could we implement that instead? This way
>>>>>> there isn't an extra step user-space has to do to make the assignments work.
>>>>>
>>>>> Mostly the new features are added as an opt-in method. So, kept it that
>>>>> way. If we enable this feature automatically, then we have provide an
>>>>> option to disable it.
>>>>>
>>>>
>>>> At the same time it sounds to me like ABMC can improve current users'
>>>> experience without requiring them to do anything. This sounds appealing.
>>>> For example, if I understand correctly, it may be possible to start resctrl
>>>> with ABMC enabled by default and the number of monitoring groups (currently
>>>> exposed to user space via "num_rmids") limited to the number of counters
>>>> supported by ABMC. Existing users would then by default obtain better behavior
>>>> of counters not resetting.
>>>
>>> Yes, I like the idea. But i will break compatibility with pqos
>>> tool(intel_cmt_cat utility). pqos tool monitoring will not work without
>>> supporting ABMC enablement in the tool. ABMC feature requires an extra
>>> step to assign the counters for monitor to work.
>>
>> I am considering two scenarios, the "default behavior" is what a user will
>> experience when booting resctrl on an ABMC system and the "new feature
>> behavior" where a user can take full advantage of all that ABMC (and soft
>> RMID, and MPAM) can offer.
>>
>> So, first, on an ABMC system in the "default behavior" scenario I expect
>> that resctrl can do required ABMC counter configuration automatically at
>> the time a monitor group is created. In this "default behavior" scenario
>> resctrl would expose "num_rmids" to be half of the number of assignable
>> counters. When a user then creates a monitor group two counters will be
>> used and configured to count the local and total bytes respectively. If
>> two counters are not available then ENOSPC returned, just like when system
>> is out of closid/rmid.  With this "default behavior" user space thus gets
>> improved behavior without making any changes on its part. I do not have
> 
> We can automatically assign the h/w counter when monitor group is created
> until we run out of h/w counters. That is good idea. By default user will
> not notice any difference in ABMC mode.
> 
>> insight into how many counters ABMC could be expected to expose though ...
>> so some users may be surprised at how few monitor groups can be created
>> with new hardware? This may not be an issue since that would accurately
>> reflect how many _reliable_ monitor groups can be created and if user needs
>> more monitor groups then that would be a time to explore the "new feature"
>> that requires changes in how user interacts with resctrl.
> 
> Currently, 32 h/w counters are available to configure. With two counters
> for each group, we can create 16 groups(15 new groups plus the default
> group). That should be fine as pqos tool creates only 16 groups when it is
> started.

user space can never assume that a certain number of groups can
be created. 

>> Apart from the "default behavior" there are two options to consider ...
>> (a) the "original" behavior(? I do not know what to call it) - this would be
>>     where user space wants(?) to have the current non-ABMC behavior on an ABMC
>>     system, where the previous "num_rmids" monitor groups can be created but
>>     the counters are reset unpredictably ... should this still be supported
>>     on ABMC systems though?
> 
> I would say yes. For some reason user(hardware or software issues) is not
> able to use ABMC mode, they have an option to go back to legacy mode.

I see. Should this perhaps be protected behind the resctrl "debug" mount option?

>> (b) the "new feature" behavior where user space gets full benefit of ABMC
>>     that allows user space to create any number of monitor groups but then
>>     user space needs to let hardware (via resctrl) know which
>>     events should be counted.
> 
> Is this "new feature" is enabled by default when ABMC is available?

Not in this design, no. In these scenarios ABMC will be available and enabled
in both the "default" and "new feature" behavior. The difference is no user
space changes are needed in "default" scenario and resctrl limits the number
of monitor groups to support all monitor groups to be backed by hardware
counters. 
When "new feature" is enabled when ABMC is available and enabled then
user space is able to create more monitor groups than available hardware
counters and new user interface is required to manage associating counters
with monitor events.

> 
> Or we need to provide an interface to enable this feature?

Yes, an interface will be needed to enable this feature.

> 
> 
>>
>> I expect that only (b) above would require user space change. Considering
>> that per documentation, "num_rmids" means "This is the upper bound for how
>> many "CTRL_MON" + "MON" groups can be created" I expect that "num_rmids"
>> becomes undefined when "new feature" is enabled. When this new feature is enabled
>> then user space is no longer limited by number of RMIDs on how many monitor
> 
> With ABMC, we will have a new field "mbm_assignable_counters". We don't
> have to change the definition of "num_rmids".

The problem here is that "num_rmids" is (as per Documentation/arch/x86/resctrl.rst)
documented to be an upper bound for how many monitor groups can be created.
As I understand, when ABMC is enabled and its full capability exposed to user
space then there is no limit to how many monitor groups can be created, no?

For example, if I understand correctly, theoretically, when ABMC is enabled then
"num_rmids" can be U32_MAX (after a quick look it is not clear to me why r->num_rmid
is not unsigned, tbd if number of directories may also be limited by kernfs).
User space could theoretically create more monitor groups than the number of
rmids that a resource claims to support using current upstream enumeration.
Instead, it is the "mbm_assignable_counters" that is of interest, that is what
user space uses to determine how many of the (potentially very large number of)
monitor groups/monitor events can be counted at any particular time.

>> groups can be created and this is the point that the user interface that you
>> and Peter have ideas about comes into play. Specifically, user space needing
>> a way to specify:
>> (a) "let me create more monitor groups that the hardware can support"/"let me
>>      control which events/monitor groups are counted"
>>      (like the "mbm_assign" file in your proposal)
>> (b) "here are the events that need to be counted" 
>>      (like the "monitor_state" and "mbm_{local,total}_bytes_assigned" proposals)
> 
> With global assignment option out of way for now(may be introduced later),
> we can provide two interfaces.
> 
> 1. /sys/fs/resctrl/info/L3_MON/mbm_assign
> This will be enabled by default when ABMC is available. Users can disable
> this option to go back to legacy mode.

Potentially (all naming placeholders that will only be visible on systems that
actually supports particular mode):
legacy [default] new_feature soft_rmid

> 
> 2. /sys/fs/resctrl/monitor_state.
> This can used to individually assign or unassign the counters in each group.
> 
> When assigned:
> #cat /sys/fs/resctrl/monitor_state
> 0=total-assign,local-assign;1=total-assign,local-assign
> 
> When unassigned:
> #cat /sys/fs/resctrl/monitor_state
> 0=total-unassign,local-unassign;1=total-unassign,local-unassign
> 
> 
> Thoughts?

How do you expect this interface to be used? I understand the mechanics
of this interface but on a higher level, do you expect user space to
once in a while assign a new counter to a single event or monitor group
(for which a fine grained interface works) or do you expect user space to
shift multiple counters across several monitor events at intervals?

Across resctrl's lifetime we have seen examples of user space wanting
to accomplish more with a single resctrl interaction. For example moving
multiple tasks to a group that you added support for and moving a monitor
group feature from Peter.

I thus think that it would be valuable to consider more efficient
interfaces from the beginning. I do not think that this is the type
of work that is an optimization to be delayed until an unspecified later
time, but instead multiple usage of interface can be considered from the
start with a most optimal interface created from the beginning. Specifically,
why does resctrl need to be "extended" to support a global assignment as proposed
by Peter at a later time, why can it not be done as the original and (ideally)
only mechanism?

Reinette

