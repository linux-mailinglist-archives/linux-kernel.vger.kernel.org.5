Return-Path: <linux-kernel+bounces-69401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613AE858874
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181931F21F63
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BE514830D;
	Fri, 16 Feb 2024 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuC5vRhA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EE812FF9B;
	Fri, 16 Feb 2024 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122111; cv=fail; b=OY4bdplGAdcUG8uE1cCRmT3duYxhWFh477UdTx7eElEjB4ytXVPgcEwPb/Uw+mHgP1jj9nyKB/GKdp9HzSnMvQ9b4+cgH/EL7apxiL+cb5HtCaZzCoUCT/r8uXB1KSY02KsOcb3w1bYIehqnGm9JG11lAd2ECrZt6KZiTfgS1fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122111; c=relaxed/simple;
	bh=xSQblTigb1GF72rG1wGac8NpneX/b3bZroF46JSZtmU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fk1I3POM92zkha/fpNCz7tY1PERsRH1YII9Jb9QvDauqXiRlQasE+hBPIyrwz1un1Rz+tqYHEWBHHks0PBZgnLaT7LINxZik62PcSya7SWXoHzp2+847vx6dO0hnqJfB7itzOaEvc8FR6HKFfDAOw38qA3dzl+Oy/D+L6oQGC0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuC5vRhA; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708122110; x=1739658110;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xSQblTigb1GF72rG1wGac8NpneX/b3bZroF46JSZtmU=;
  b=VuC5vRhAkLPsXMMwhM76u0ZEfkNMv5Tf/ssXPysCe7/5Hsw8uw8P75bH
   ij8f0y57WMQ26FDZOCZk/bEkBiBvWraJ77Ok/8N0Qy6nQIKKn9XdA7JsA
   kMHaJH3aJoS2RrnLOmQbnDu1pci4WbrhEnhobb263APVfdOgjzzk9T0ku
   4xQ966kvrXML6dKvMppRFv06j+0IonyvrLofzyD9p3UfVzUN5dtZwG8CH
   iGgClcT7GpXyXA+rJyfhuPVEOONqfS+8r+QNa8pEqWuHNAZwpV+/zsijO
   iFL8zG+vF0homGKG6She6kO2/pcVNui6uYBQnZ+O5buhDbyo1pSfsZBzv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2172076"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2172076"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:21:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4338845"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 14:21:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:21:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 14:21:48 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 14:21:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDEwLwJYq4Nq6pkmxUbYxNoS1TxRBvVkKEPBNL/rNpOVd6mTL/WAvaDW+7uw75pfPUcz7/vC8E1eqXGJ9s2YGrmpzxMX3kIfp2xBdjCc+05Mr6Tw0JXx5tPqqrWueAGG6J2O9lGy5fyndao9PPKHb2VEq++2pcPxiuL9YyehsZGLAC5/iedUYwUDanJIhURMLB8XRkSdRo5zaG3oZI6TD1yESxok0M1RSeRLOrIt3u90CL0SJy0VTq+q4XcD9ihyxF53m4xiWY2P2Opx17Y1uYtmE+rRbIqztMuCPM6gI8RzcsY0N3mbv+PS5B65TwumUCwqkHEIZ6X/AxyHzUAeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mOWM8uFCLdzZe3LJ65X3FDudimilofqH9w4LzJ50Pk=;
 b=cplKFk0hK73N7MMy5a/YoI2G2Oq30eg9R1wEMbmwrmYxtQ0haA1BimeMJ8XriLX86ZW73DjlCaIRR4TQqI6iVd9F7MEVHm/ay5vZjcuUfUpjTCLAffgxbHtLijr1OjrYtEk6pgcjTnWec6t3gfc7/mSGel9wqjjTw6YxMYZ3C2+0Q/yDpLDwOzhcNyeDZfBxf+uBQO3MAVFJnFlXowKQJG7k1wJQw0S8AJTJXRP6s9CpFYKKUf7DK2UY2o0gGJEg1hG4eeNEiFmoXKx2rr7y5+G8BjZxR517lkn4EHCVMCZzojfbQWAims7fkfycuPoTZujkqEm2uHuSBqBUz/yyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5476.namprd11.prod.outlook.com (2603:10b6:610:d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 22:21:46 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:21:46 +0000
Message-ID: <3e81297c-2821-4af4-b13d-dc33ae8f85cc@intel.com>
Date: Fri, 16 Feb 2024 14:21:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ethernet: ti: am65-cpsw: Enable RX HW
 timestamp only for PTP packets
Content-Language: en-US
To: Chintan Vankar <c-vankar@ti.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Roger Quadros <rogerq@kernel.org>, "Siddharth
 Vadapalli" <s-vadapalli@ti.com>, Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240215110953.3225099-1-c-vankar@ti.com>
 <20240215110953.3225099-2-c-vankar@ti.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240215110953.3225099-2-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:303:6a::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5476:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dbabac-8e36-4731-4fc1-08dc2f3da954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMh2oKK2496XN9kWjDX2bl/fSxCl3RWPJmY+AMPtXY9PvA4L99excKRpxuB8roA8PTR3n0YClb6nUgBdAyREFaPVCzIowVFCj8QjbLTS9/0cbl1vLiuTBrd5KMrFjB6wbWllF+/o7xL80n+qJBQh/712qySNqohCIou5vWNUaokTuTCJ5DYQdZPI3mY14YSLivUJHClOuTz2PDZVwRVonnH5BhfrZ78PxHGnMWKhZRzQS7OYGh3H93y8ePgE8LibIomuk3D7vty+YGxsYvWP7xAPEa++6knkQUQ3QBTVFfeMNqFF4pv8wfyo7Q+YjHQ+LtO3ITzWGgIgx8Jwk0nGErNF34Hxb5krlKUI+dK8PkI872C+zg2QeBPJ8/R7b7yWQYTWAA2toAQTaG0m9A+8tSoUgxwC6JWXnsu3YZGFNwkyZ6BWpVEngHG1jW6sw65zH1urOZM5L7kzK2bmXNAY/w3f5z2YMr6kQubJPq2cC1AHdQd1HmSKJ5r7tfTQ79ZwfdSjLxHNi/OsK5OK6HKXF0/jp0TO1XJ6DODzwyj44iUhVFC/FvccHkmjvHoUzZM7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(53546011)(6506007)(6512007)(2616005)(6486002)(478600001)(31686004)(2906002)(66556008)(7416002)(5660300002)(66946007)(66476007)(8936002)(4326008)(8676002)(110136005)(41300700001)(316002)(26005)(83380400001)(558084003)(36756003)(31696002)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SENKZEFtdFJqY3NBNk5ZcGQwV2x5QUZSU0pxU0xFTUF5VWFTWUV6bkZpR3dn?=
 =?utf-8?B?Q3JGWDJrL3lPUmJhSVNHa0tZMWpxMVBrRkN2MG9QYmdpc2FodGUzY2dsQjhY?=
 =?utf-8?B?NllUYUd6REFrMy9LN1JVUmRsVnNZVWNNckhubXNwTFM3QXNQMlBCNzd1czVS?=
 =?utf-8?B?cFZ3eEJGeS9ybjM5TDhWa2tRQnpFalB5b1hGMHIyaSt6NWFydGJJMzlRemdD?=
 =?utf-8?B?eHFpZWx3Vmc0eXQwQ1Nad0QrVVQ5MHZrVEQ0Z1lxMzhqcmtnYVA3Y2tnM3Nw?=
 =?utf-8?B?eUd6Rk5PVmhQaGl4Y2tnYWpxWmI4aktnTDRaLzJRaXkyN3lNN2tab1dTbWV1?=
 =?utf-8?B?MWtyV1dTQkJqNDJXZmRXTTF0Q2xqQ0JrVk5uWXdxbjFxbXN2UTU3WjhseHBZ?=
 =?utf-8?B?U3dqcitZQWNFMzM1WG1JZDVFaTR6SnVHdlkyNWlZaEFIRzBMazVFQjZhMUk0?=
 =?utf-8?B?eDJOSFd4Nm5wanNPTDZtN3dZQ0NPMGllNlc0NEVObE00VVgwNHpRcWxnb2dN?=
 =?utf-8?B?SnZNcllSc1hWa0huYmxQQkFGZW15OUp2b0tXV2RxZTBydGVqM1ZDTjFtR0Vx?=
 =?utf-8?B?NFZuaDJReGRIL2xpMUZWanNyWUttelNQU1JTTHBieDZIOTRRZ0VJSXVHWk5y?=
 =?utf-8?B?SkY5cTFUcU9zV1Z6L1M0b2pwZnEzYktETEhiRkFva21STFdZVlVvMVJHTVZ4?=
 =?utf-8?B?ZGtwYk9FWURhTGN1eTBtc2xtUitpc0w4WUVQMTR4ZUh5NXZ1OUM1dEFWazdj?=
 =?utf-8?B?NEh3a2V6aFVZYUN3QXYyRVM0b3VKUUY4ZGZSTkVlOEZkMFdIWHZtV0NKUUhu?=
 =?utf-8?B?S2NCUFpzMXQ0eE13czRhYThBSGtqWkwvenJUVjUzaWJSVUpDcWEzb0t5NFI2?=
 =?utf-8?B?dlpmZEVHNTFrSEltMGZPRkVzeXcvdXBDYk9XbnppM0Y2WXpVVXZtRi91cFFq?=
 =?utf-8?B?eEcvaXJEV3NwWVdwaThsenF5NEtQVkZPUmZIMTlVVVlaNXNMRkdXYWFlR0tS?=
 =?utf-8?B?UXpSa3RSdFkvZ0dxNDNkZ3poV0FXVWVSbFFUWGo5elR3d1Nnallyelc3eUEz?=
 =?utf-8?B?cGNKZUp5aXlxSStzeU1iQlhhWXRWZDExc05GUnZQMzl5U2swUlRGZUp5ZXFH?=
 =?utf-8?B?VEFwd2xiUkVqRTJsazAwVlJLcGxWRVdSOGoySHFTMXJxdkExNTZEaG93cENI?=
 =?utf-8?B?L2s0czRiVmk1WGpGMTdFdkNTaHlxSkZTQnAycHZRZStlZEQybU5NSWczK3Iw?=
 =?utf-8?B?QmlNR0JpWjVjU3JkeUdLemVsMTMxR2FCQzhXSzlsT3pxeDhOTXBHa0JmSjdV?=
 =?utf-8?B?YUQyc2Zha09vQTRjQjlmbzM3OE0velJ1azdIcXd1UHVwbFpkaDdoZVdURS9E?=
 =?utf-8?B?bnhyQ016RU5WSFpnMkVqc2JzVjZMbEpPWkxVdFBuYTR3U3pDTFk2OSt3OWd1?=
 =?utf-8?B?YjI4ajA5S0FqMXEvV0NKRXUrVHhMUUhSZFBpa1pLREo5NGpiazZhZE1vd0FX?=
 =?utf-8?B?MWFaell1NjJKVnRNazZSdFRUUm1BbjRZTTY3SGYxWWRkRlY0SWhHeVpXZ2JL?=
 =?utf-8?B?dHJreHJqZEp1WUpGTEZRRWxTWmM2Y3REeVZhRXNVdy9NcWduS1VlVXp5Tko5?=
 =?utf-8?B?QjJaZVZ0RzNHL1kzN3o0a3JCaVJzTU9nVmxHRUVTOGtpbERwUHdoMDZhK3Ax?=
 =?utf-8?B?T0FIYTdhaHBDN1Nkb3RWVEErTFZPcWloa3A4djB0WUZFaHBDZXVRN1Bvenkr?=
 =?utf-8?B?ZVlheitxS1l0T1NQMFB4TDVmaWd5YnJTeU0rQmNmcXoxWVZaZzJtOVpWN21E?=
 =?utf-8?B?UFRDdTQ4Z3AvMlNES0dBNkM4Vk5JTTFPektSYzczMGg2TklHdUVzVk1VcEhV?=
 =?utf-8?B?V2xQNUM1QVFjMzVXcWtHTm03RDZPWXIrR3ZPWHgwVFNIM09Ga01sWjBia0dZ?=
 =?utf-8?B?aUR6eEdia2R4RGl6QVFLRHVuT0llMTRLY3kyRjBCK3RUTThmRGlHcVlmeGFu?=
 =?utf-8?B?RkhFY0JvVUZ4Z0JVRE1IbzlhbkROcEVSeDVnUzJWYXo1R09iQ0R3d2w3dERx?=
 =?utf-8?B?eVRBcDMyZTB3MFJhL1lSRUozekZWSHozZ045ZlEzN0ZrcG1BeDR2dUxpMXRs?=
 =?utf-8?B?YVNqMkloTHN0YUEweGxQVGZ1b01pTGRGbnVXdTlNUlc2eFVkblhNQTJRQ3ZZ?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dbabac-8e36-4731-4fc1-08dc2f3da954
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:21:46.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BHk6AEefGIAn7TwqIUaiBQt+QEh7ufCp6ubQTFs7nNuS7fuSU42Vcgy69IfygvUTByqfJHFm+d0r5Gtc3037uokesRCPYLwQw3xdCThFdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5476
X-OriginatorOrg: intel.com



On 2/15/2024 3:09 AM, Chintan Vankar wrote:
> The CPSW peripherals on J7AHP, J7VCL, J7AEP, J7ES, AM64 SoCs have
> an errata i2401 "CPSW: Host Timestamps Cause CPSW Port to Lock up".
> 

What's different about timestamping only PTP packets that prevents this
port lock up?

