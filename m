Return-Path: <linux-kernel+bounces-79247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C67861F88
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B8A1C21129
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0DD14CAD5;
	Fri, 23 Feb 2024 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSuZHAG1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ED214D44A;
	Fri, 23 Feb 2024 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726895; cv=fail; b=ASyb6Go9aDDg/dKhdnN4nAMWO5iqbFdT7AYVWM43YUA/5EXY5730UbqKb40fW0/RPRhuvxgiNLlSdkmWC4FXfphwypvTTTUuUEivoDW8jLZjDHe9/8tb4aWAdajPnU5jctJ84kag5zf9opwNYenfbvjK+TcTBxaIfRutiFD4HLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726895; c=relaxed/simple;
	bh=cBGhTu/BwkDgD6q7Cl6FZSf5GIix0kvPHF4oDBFj2x0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u0OrmG82Ytd3b4GpIJkxH96qBy5pCIAQ+GJqu+EVx7G8UYAs8/q+eYluLJPm3LpaWBPUveRQc811gMiOimC47NmOWe5KbJOrNUBisImv/6maOOzBK1Z0mK3XnUQyvIocZm9H5LBWMwnSdULyZLIsiY+R258plX2TVIiv12m9i9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSuZHAG1; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708726884; x=1740262884;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cBGhTu/BwkDgD6q7Cl6FZSf5GIix0kvPHF4oDBFj2x0=;
  b=nSuZHAG1tlJXN761RO5BGHzu+WU2lWPuhyFRNcrjrsRmLPlLTuyYql24
   sR7HCzvrxn+bSlrn47GX4MeZdMai2BtY7P7OJCYBKI+OWPv9nPs6Vlgt4
   dvJaWeOnHrj6RjUyfYQkXemEfar/3T5anCxeKZ2GlbVLygFKzmxLjZGIp
   BtmaHRhBP2Kg725ZPpdhgc7J76HExd+YycmX3cXgF4GgtbHpbhmNjuWUa
   Chk0Fz/f3e95zw8Ic0BxDyid3oC/k5WC0LMd4V9UU+IKB2gaTgESiqX9X
   AHFL3acSCxIlGex5tnbAY9HKLytDU1P4Qf6XOR49M9592DH5QTrDurMeu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3223710"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3223710"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 14:21:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6406261"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 14:21:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 14:21:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 14:21:19 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 14:21:19 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 14:21:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYRym0+iOH+PmrAbEhWTyjnTa4RA2/l3il4fdQd5hGeq0YSTR86oOfp5RKNnz9cbF32Fk8hkVPoLHqVdyV/O4c3eAjIGKZl24xuCACzLSLGCaDrBN0ry0tUjzdH55VgZ0HoYQjVeIqVSrAkTlWroSPeoW97eOPHHYMGZMUrrrv27iMtbSUR00GUVWnWTPivHeu7vqkn/Qjqpbhbu9B+ySLNf4sgJGd5WfiKdfylGQgWcRowBtimrtOyI+AhXxNsH4xNluG1oA5GTu7eOXLrZ6Ruhn+qpLLsA5JMBZ8xY3xIyh5MaQAzhODLDDNhY4rOYSVQNIL5stx3GaEB+M7lvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+lMoMdwUl2t089i5gFDDmeDH88h2UeBJelvICWdbO8=;
 b=n+YVwK3H9zlYDMvMUpqZVtOZzCWlMEmPdHo7SNuvTvnMxbx3nSygfn/P58Hvn9nAIRYKsejXdHR9RPxFfUoBIpunOrzA6DcXDR04JNAS6tbMpsyT+D4/FnzVHXI6C6k1PI48Uglt3nCtsfzEjb5HJtF60eME5qxr4ZwEE4y/Q75MXTPEqY8aSX6eP8LfPO8+77prJ/i36u+zsuW5qX2J3kExbKMqqL1m4nHom1XaUAl+Yl1AZG1UPUrebO1DOkso6Yq1wy8kIKm2vmEkwZGeVw7Yb8QzSAplhAOLjwzHbbDuobCiw8O6ZlKeZhBmb4Elp+b1eVnOXOQLL9zCrwOc7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 22:21:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 22:21:16 +0000
Message-ID: <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
Date: Fri, 23 Feb 2024 14:21:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
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
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0072.namprd16.prod.outlook.com
 (2603:10b6:907:1::49) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: a2076def-014e-4f92-49c0-08dc34bdc054
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSRoWFhgOhhwyaAuphFi780vLtTZo+3nkkchX2BYDzo1FE+hNC1F6UqVD7un8qcE2iiXnTie4rQIWnoDBvL98598mpdABO/2qYOvqemMXKkcHU0J/CbMzDYoQx9AqB9T9HFyfXEWmwvWoOf7OOS+N5bZ4OlkVs+W9kpo/fNLO9ujFsX3pW//Jm9H/hZUwkAiRPPLxl4T/8IqvOZpmAMs9c4k4BnC2F9bvC+HpV57MTKhv2xQtyK9fUYJhteV6MpvjU4IhLKoBBMZnanCuQQRFx7YgNF3tn0dHPrbH6hWnl03aVpV3BFjmuERulzlXTkgAhOu8e96FfgzaGuEb27OtjYxCs7zzvxFd2tN5u52g5I3i/tPcT663lWJkmKd9Vd3urcIgirgfjpwV/SgRLu7+y3mrGbSv8HDoIUlTIgTzgj4gb+dF02gA2B+RNyB417jL5Ab11WZsXjw0pdfmknNg3nk2fxOq7ZnRDaIc7VUr7RRMDKInV3zp+UZbOuvWrbdOLIroHaG56w2qlaUhvKwaik+beAeIhoYfUXIodblxIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUNmbk1lNlplM3FNa3RjQkJ3U0pHQTB1R3NVTm5lWVorL3JLN2tOUWd2cmti?=
 =?utf-8?B?YTFzZ1F0ZHN0MGZuZ2tTck1kNGhwb2ZPeklQK2JiOGIxUm0rSVJIaWRUUEFG?=
 =?utf-8?B?NFVBQkkreFFqallJOGQrMlArZWlIMWVHNCt5T1FxdDRxS3ZNdjk5WjZGeWpr?=
 =?utf-8?B?WWJRYXVBam1EYmVnemt5MFk0V1NaSGZUR0lJTEZMVXVqQXc1Z05yRy9BRnp6?=
 =?utf-8?B?VjgvQTA3MkZRaW9kT29KMGk4VmJiUVhTQkR5RzZWYmg1ZFRsbnVQOGRoUWRo?=
 =?utf-8?B?VEJBaUMrZWVlaTFneVJlSlFmUUwvZ0dFRlZscW9SNnBuaEkvSDRzMUpDYlFu?=
 =?utf-8?B?NjVDeUo5MWhYSmppdnprRmVyNGpSdklkRlNMNTlXVlVXeUxpaUVSTG5NaXNS?=
 =?utf-8?B?OWt6S01Sd1hRSFVyL0tjZWlqcjE4eEJ3UUxwWTljSnJXMHEvSm9qalVjS0Y5?=
 =?utf-8?B?aUNWQnMvZW1CZFpUYUh5Mk1ud0ZMMnhEMGJ1UEhTOFdSNW5SMHZVZVRQRmZQ?=
 =?utf-8?B?YTJHdWx0RlpLWG9ZMjN5aERBS0R6cC9CdWFGM2VMalNZVEg0NXhwUUFWeW9n?=
 =?utf-8?B?NmJJWWVPd0xITHBkSHQxNVl1QllYMC9xb29pTXFubjVqb2pzakVlRWFzdml6?=
 =?utf-8?B?cFNyYnQya2JBK01rZlRPbzRkZE53K1BwUmEzeFVoOExkTGVJTnMrODR4a1BK?=
 =?utf-8?B?RndFM0tLWFE0UVZneWhuMkZ2b1ZrVGk2Y3ZMMG56Z0RnNkk2Y2E5Zy9XUm1M?=
 =?utf-8?B?TEJpRHlOVTE4cUl2bHk2aWVsNG9rT0lxOTNYSkh6T3JmRWNxWlh2SnZiOW1Q?=
 =?utf-8?B?SCtxcEhIeHp2SDFiTUQxL1BETzF1cm9xby90emtscm9GYTlPZ1NnaUlSTnpw?=
 =?utf-8?B?RmFIVENEbDFscVhSUVd4WUQwc0QvOWRWeDB6SXFGdFN1b2ZmeTJwMEhEaXUx?=
 =?utf-8?B?bEdiWW1LaCtQSHRVYzZTRlpUM3pYNG5la01saEVNTEJOMVgvOENXSmp0b2lY?=
 =?utf-8?B?VTNpZmhWQjFpYVZIZXJBZllXeGtyWHh4d3dtZ1BZU1BkdzhDVlJWRm1KbUd5?=
 =?utf-8?B?S0RBWGhmVWdvZlljajlVVWgzZVh2dUtXVlU1MDljdEhXNXJRMnlvbnJmVlVD?=
 =?utf-8?B?eTFiQ0RKa0wwTVA5c2F5bDkxQnhkUm1ycDhOMGhMSWJYeEVIclBoSitrR1JP?=
 =?utf-8?B?U2VhS2hVWk1WNEU2cXlkWmhNZ2NWNHZwZU5rZHpObXZXYzhQWW1sd1JveWxi?=
 =?utf-8?B?bU4wd2s0VVROU2VGMllyL1NCZDRDQU04RU13Wkt3bm5YVWZ5RzJURDhqdjRG?=
 =?utf-8?B?TERvcjlkMDJCVWJta1d0ZFA4ZThWR1d3dWx4RlYyTjdabnNsRFBNaTFSelNF?=
 =?utf-8?B?ZzRnZGFrYzZhVjJIWGUzdHhIejhNc0Z3ZjRVeTdYdjBocnZWV29zelBVZ1Q0?=
 =?utf-8?B?b2hvc3duNTN3RHpHZFYyT2hyTzFyekU2d0ZCMGRIc21XMFdxem5mUVdhTnpj?=
 =?utf-8?B?U2k3M3g5clhyQjQwK0h2dnFPY2RuZVlaaUFlbTJzejlkZkUzSkxrRkpmdVQx?=
 =?utf-8?B?WVBWWHQ2WmZpWHgxYmc0RHZxRFBZZFJzVmM4V0w0ZDI5VXJRZ1VkR0c4L2pH?=
 =?utf-8?B?KzJEWURsVCtWL3krb3NEY1IxNitMcUluM0llMDFUVVB6b0tHRjBJb1QyVTBk?=
 =?utf-8?B?OFVOc1pTbTdlL0daLzYzUW5oT25BU1o5REVGMktNSDhZSWhpeUxOa1JuSy96?=
 =?utf-8?B?elp4RWYwOXdrdjl0VjRNMjR6N2RjNXArbDNNTHpGM0t4S1RGWmtDT3RrTFly?=
 =?utf-8?B?VkM5U1hST0pWUlNuV0VyaTNyQVZrVjBVWmFIODJuUUxKUTBla2RzeVJySTY0?=
 =?utf-8?B?YXJtVE91MUZSemlub0wxMjk3aVdncUVaTTZWSFNySGw1VXVvYnhJTE8zeXlX?=
 =?utf-8?B?RjM3eUdaQUwrc3JCV3Y0Q2FHL3NTZkhCT1lsczlheFpTMmdBcnBXQ25SSnJs?=
 =?utf-8?B?UFh0RTVJK0xUOVNzRzREYm9DOFNEOGNTL3RmdDJ4eUkzNkdEWHFFUnMvVW9R?=
 =?utf-8?B?MjdBazNtNmYrYjBEbjlXekdkUTJMUkVBQzc4QXUxa3pGSjZ2ejdzYnROT1Nr?=
 =?utf-8?B?cjF0YmpGN0o3MWhFblFUazBzdTh0OGpUUEtIQnRlTlYxMklXVmsxOTdEcWVj?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2076def-014e-4f92-49c0-08dc34bdc054
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:21:16.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZQs05o332A602bAefpSz1l3EeoUJzhaphtswvENLcSLWIEp9wusm0e89062oURGbpKlrcb/XHE2Od3Gf73qLNkmxCAZut+Q/5dppv/nxko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com

Hi Babu,

On 2/23/2024 12:11 PM, Moger, Babu wrote:
> On 2/23/24 11:17, Reinette Chatre wrote:
>>
>>
>> On 2/20/2024 12:48 PM, Moger, Babu wrote:
>>> On 2/20/24 09:21, James Morse wrote:
>>>> On 19/01/2024 18:22, Babu Moger wrote:
>>
>>>>> e. Enable ABMC mode.
>>>>>
>>>>> 	#echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>>>         #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>>>         1
>>>>
>>>> Why does this mode need enabling? Can't it be enabled automatically on hardware that
>>>> supports it, or enabled implicitly when the first assignment attempt arrives?
>>>>
>>>> I guess this is really needed for a reset - could we implement that instead? This way
>>>> there isn't an extra step user-space has to do to make the assignments work.
>>>
>>> Mostly the new features are added as an opt-in method. So, kept it that
>>> way. If we enable this feature automatically, then we have provide an
>>> option to disable it.
>>>
>>
>> At the same time it sounds to me like ABMC can improve current users'
>> experience without requiring them to do anything. This sounds appealing.
>> For example, if I understand correctly, it may be possible to start resctrl
>> with ABMC enabled by default and the number of monitoring groups (currently
>> exposed to user space via "num_rmids") limited to the number of counters
>> supported by ABMC. Existing users would then by default obtain better behavior
>> of counters not resetting.
> 
> Yes, I like the idea. But i will break compatibility with pqos
> tool(intel_cmt_cat utility). pqos tool monitoring will not work without
> supporting ABMC enablement in the tool. ABMC feature requires an extra
> step to assign the counters for monitor to work.

I am considering two scenarios, the "default behavior" is what a user will
experience when booting resctrl on an ABMC system and the "new feature
behavior" where a user can take full advantage of all that ABMC (and soft
RMID, and MPAM) can offer.

So, first, on an ABMC system in the "default behavior" scenario I expect
that resctrl can do required ABMC counter configuration automatically at
the time a monitor group is created. In this "default behavior" scenario
resctrl would expose "num_rmids" to be half of the number of assignable
counters. When a user then creates a monitor group two counters will be
used and configured to count the local and total bytes respectively. If
two counters are not available then ENOSPC returned, just like when system
is out of closid/rmid.  With this "default behavior" user space thus gets
improved behavior without making any changes on its part. I do not have
insight into how many counters ABMC could be expected to expose though ...
so some users may be surprised at how few monitor groups can be created
with new hardware? This may not be an issue since that would accurately
reflect how many _reliable_ monitor groups can be created and if user needs
more monitor groups then that would be a time to explore the "new feature"
that requires changes in how user interacts with resctrl.

Apart from the "default behavior" there are two options to consider ...
(a) the "original" behavior(? I do not know what to call it) - this would be
    where user space wants(?) to have the current non-ABMC behavior on an ABMC
    system, where the previous "num_rmids" monitor groups can be created but
    the counters are reset unpredictably ... should this still be supported
    on ABMC systems though?
(b) the "new feature" behavior where user space gets full benefit of ABMC
    that allows user space to create any number of monitor groups but then
    user space needs to let hardware (via resctrl) know which
    events should be counted.

I expect that only (b) above would require user space change. Considering
that per documentation, "num_rmids" means "This is the upper bound for how
many "CTRL_MON" + "MON" groups can be created" I expect that "num_rmids"
becomes undefined when "new feature" is enabled. When this new feature is enabled
then user space is no longer limited by number of RMIDs on how many monitor
groups can be created and this is the point that the user interface that you
and Peter have ideas about comes into play. Specifically, user space needing
a way to specify:
(a) "let me create more monitor groups that the hardware can support"/"let me
     control which events/monitor groups are counted"
     (like the "mbm_assign" file in your proposal)
(b) "here are the events that need to be counted" 
     (like the "monitor_state" and "mbm_{local,total}_bytes_assigned" proposals)

Reinette




