Return-Path: <linux-kernel+bounces-79177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B49861E81
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF81B22BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE99149388;
	Fri, 23 Feb 2024 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RaNB1A3V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFC7143C63;
	Fri, 23 Feb 2024 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722438; cv=fail; b=kP84N6WLl1x5HBol7vIH1aT2HEU4IKQksCVgtZIOiz2QB1l8YaOYf/LTj9s3FdDYar+8G5on+BmB3nOTxsIj5eNRlDF1UeDr0psZu01V0QmkRKNIoSTDu8KAW3MYcrU8tQjMxUx5fmtAF96uUIrpAwOKKjwsxF/2g7Bj4DHo5mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722438; c=relaxed/simple;
	bh=iyd+0+3P81ku69CmX3P0m9d3oZVXnpYiS8RiQQvAKlE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jcWooINHDRUb5Rxu2u6Y/Z7n++T0DSzYAzPCE3kC3C3TqKwbQtWv34X7q6OsEoiqG/TcwbeB0eP5kNHRcqnrDJlMwigszSD/1ZBEuA2H53LV4AMcLSVTaRk+8Uvory447aUTsflm4/zRDVV6YqgCT8NURHz8bhLuhjRqZuGqdqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RaNB1A3V; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708722437; x=1740258437;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iyd+0+3P81ku69CmX3P0m9d3oZVXnpYiS8RiQQvAKlE=;
  b=RaNB1A3VOjByLhLIcgIjgkAhFe7sWWKSFfCpLP+9bs5IGBWxIt72nPVt
   9HKylXuwbx2Pbtdr74IeiYy3auw8BH6JoDG23NEP4jmGN0tlQybXh+YJ/
   B8klrJbELpvxL5JTv4pGr+y1h/jsnXtyQgnsDUdmz3BK7kBE0hEG80LoY
   a8jdmtU4B6wVm69G3cgYdFnLRRBtEughyFWuF69XLjIJxCiU8GZfqRYVj
   qHSCJnASpmz8jd97URWOY4k3Hs4PzzKAnwVkDMJJfucXqus88qxTVFNQX
   UF+k4KMDUTxh1+BazyHKHR+dXI573OklUZYQKyFLXEFAePDBJxtAMH5Nr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6847701"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6847701"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 13:07:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6388601"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 13:07:15 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 13:07:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 13:07:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 13:07:14 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 13:07:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXIdxmQHJd1UCQ7IMCP02le/5iX86zzAJi9jqCekY3k5iXOoo82Q4t9/t5evHxpF/a12ptuuaeAWVhK46WQVXBScWuqc9a83MprkO/K2MCLGj7/8COIX6gtxyxKwQEk/NZiWlD8Ex48UplKjczB/Qubh4JCf7jpqoVHESXg03q2C0pU8wiq8LFi5TCdkewEagV5jN3EFNbs8BEtlFpeS2H4pFn2f/1AHM15+bIn0sal23j5JNs/jDTg/l1V2+t/X75gEFkvVYFYcwAKzCkA04H9aDmVThMFqSWj71jU+kDADb+cUph0JhgUxp/K6/OEPpvrH3gm2xeXAlx6mDeYcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0drb4UWWxRRoh7Ks0W3M2SKlr6nmwCU+XW2t9bwn/fY=;
 b=R8vz9LUa9bqEVLO3dvZZ7SsnA/nJfv4XnN7Mu4x0xyY+nT7rRyHMAIooTdF7XqWa26/xOD8ZEySkTeMs2Hj3K9CYiDTvRAFzYOjEfXlchcgY+hondZ6aq+oQkj6Nkfy5QzgCtXT55R4PJo17al/WakXfZwVzSx9WjHCsWyN51y4E8JTsiQcf/SR/uciNFDEIzokjXYMNxlaQvEFmIpG3DibQZrr4r5UbodNJywPy5vChHcXLUlUy5rA8dpKMImow9pjamqGmCrmRSpf6ABZvYCtH9ROwXECGOGc4O2g6oWXm0NZ6ON77RfUWyn/VnW7DmqdB7j46ko7DwUWNTiv5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB5100.namprd11.prod.outlook.com (2603:10b6:806:119::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 21:07:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7339.007; Fri, 23 Feb 2024
 21:07:12 +0000
Message-ID: <abbff26c-c626-42ce-82a9-4dc983372de3@intel.com>
Date: Fri, 23 Feb 2024 13:07:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
Content-Language: en-US
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>, Saeed Mahameed
	<saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Richard Cochran <richardcochran@gmail.com>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Hangbin Liu <liuhangbin@gmail.com>, "Paul
 Greenwalt" <paul.greenwalt@intel.com>, Justin Stitt <justinstitt@google.com>,
	Randy Dunlap <rdunlap@infradead.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240223192658.45893-2-rrameshbabu@nvidia.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240223192658.45893-2-rrameshbabu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0376.namprd04.prod.outlook.com
 (2603:10b6:303:81::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: b568b7f7-aba8-4af1-119f-08dc34b36768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9v/jJBUUbXTPkZ9L4rAuudoXwt6D14UIeP4OuqM3j10dCRN+J7eJOuqJQVH0wXMbBL/Pk25h6nIMEj5U/5emalfT02KJ0N0OQPEzjqtIPk0FAHhGe6BJzWdrLijE62qr8Tp0h355KbImv5RV8mwdi8y4wldqjLFxzEHDCLX+TC7TPEioJQ6kYpnXqwP4P3/m9XXSZp35pLn/9gJVEYMK8bYKRSGTRPtuWkKB/SmVc9J6WUcLAmNot9CARsuCB3wXN9Dziw3VgWYK2Ct2OVenDHGAZj0woCCpcTY4nBuKEpNI3OUtHdPmYsuin2cKYRW3WU78r2v1R/Zlfp295JNBzYBxmYmftJrWXMHdrdtq6DLARi2f3otWwfX1NmvIRGtmVUKjwX90ll3rGoXp6J7Ur6yabI8Y81carEhfouj9ZNc/hZETNTWw8OdiEJ/Qg/zmL/K1BO8J56ROYVCGdNxXZckn2hKI3w7agHNNX40KxojfEjLxCH2h73yd8bxqbEv7bTwDii+VMrtkdM2wu5hVBUmPyPWzVlSC38vWMcobKdVZfFldVvEO18SFG4QvvMruWBCu5hMyX7eapTcrWPEYX+69CZIGuQi+TPbl2LSLPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEd6ZU5iWjhBTFoydnFvR2FMSEt6V3B4eWwydzFGVGl3T2RZMDAyL3RTQ3Vx?=
 =?utf-8?B?SWZ5TElpMGhiNFlETFdDMnA4blhJMWR6RE9VMldZaFVNL2hIN0lMQVkxa0pD?=
 =?utf-8?B?b0FYdkdEUmphNWlmY3dtNjRiK2MrOXpWaFpWR091Q2JBV2pFNUIrS2crZ1Fu?=
 =?utf-8?B?ZlI0NmluUGc0UDlsU0NwNUM2dHAyNHozODRJY3BWYlZ4NFZpWElVUUFXdElw?=
 =?utf-8?B?OTd1M3JQdXR0SFVTa0wxU2VmWGRLUnZWZFhSMGZmY1hXY3VlVndCV0hNZW1W?=
 =?utf-8?B?c2o5eG1EWTVMdHFnbi9weGVTamNYaWd6bU5nUndydDJkQUF4TFZZZ0M5UnF6?=
 =?utf-8?B?bXhGNWdxNDVYZW1kYWwzQU1NSGdZanl5RGtUUytQNVRIZEVQajd2KzRPazNX?=
 =?utf-8?B?SVI4K1oxbTM2NVF4Mkt3Y0NCcFdNM2NvKzJmQ3h1YVpMVE10U3pIVWJ0cURD?=
 =?utf-8?B?bS9seDNFRzcvemJCelFqY3BpT29hQm92Unc1RnV6dkpKeWhsdFpGdjNaUFhQ?=
 =?utf-8?B?WFVUYkNFa3NDU212YlBiT2NkVFFDWGc1SVlHVG5kdlFTM3BoQXE2a0ZiSm94?=
 =?utf-8?B?NzdDNVJ1TEhQem1YdDEvUUJYYUpMOGcyS3ZqUU1Qam9CdXU1bnRTc1FHd0s2?=
 =?utf-8?B?U25YVG42bElFK3l6RXh1VEYzcno0OER6QWhyNHB2Sms4N1h6dkZKUU1mRUdN?=
 =?utf-8?B?WkpQVHlaOEVwMWlHYUdOSVZ0VEw0ak5VNWxKQ1FRZUhDMUhNVVVuNTFnd1pU?=
 =?utf-8?B?bWxuTzFaa1NYT0tvTStyYTZ1NkUrdWZuR0ZnWWFyV0RrdlJvdm41SU1mRGFi?=
 =?utf-8?B?RThXMzI0eGFJV2k5eWxBendTTm9aZTd6S1BGRjJKakZzbWJFVVphZVNDYnN4?=
 =?utf-8?B?QWMyWU9JL1pOZmtVU3lYTmpPeitjamEzQWQ0a3YvRENMSnN2UFRUSnQzRjVD?=
 =?utf-8?B?cVZ5UWg2QzZUL2NleWJhRWxhRlduNW4rREthV1RHUHV4S0tPMEVNV3crTXcv?=
 =?utf-8?B?MnJjNDZhUlBwdUlZL2VIZUdpWTA3QkVXTXFKL0h5em5sVUNXNFN0OENVSk5M?=
 =?utf-8?B?V3F4c1VLa24vNi9BNGg5UFZsZWN0dEJUQlZodmxldGNENFllTlRoV3YvZmow?=
 =?utf-8?B?em1LUy9pNWRoSUtVMVhhb0xKNm9oWlhDbFlDTURWc3ZWMThvZ0VxSVBSU3Nl?=
 =?utf-8?B?QjV0QVlMbHhmd1pzd3p0WldpN0M3RzllQTVPcHZ0WklGaGVmbjBvRTRMOENX?=
 =?utf-8?B?SDM0cXFjK3NsdXhIZGlNNmJqa2lWQmNzVlZNclpEZjJpdVlKM0QxNVJibTNr?=
 =?utf-8?B?NWhNWWR6Wjd4bXg5OW5najRETGNyaCtySEk4Tk9BaUxSZDJ5dTVGbzhPUjNa?=
 =?utf-8?B?QkRVa25mVFpRSjhZcVYvYThocHpRcFlhbUlwckg1Z0RXWjJTcGo0dDB2R3ls?=
 =?utf-8?B?diszU1I0bXp6R0ovZHFOY0NPa095RE9mekdaV0ZLSDUzTkt3MWo4L29Oemh2?=
 =?utf-8?B?Z2cyK3VNMGxjUk5rOFFvem9XZUhzQ2FhQXFLdi9oOUY3RGFJRjZuYjB6VC80?=
 =?utf-8?B?MHIxZzFFRzBqSVljQXQxTk80bFlzdFBTWTNXVUoyL1JyMWpkTFRzSkI3UzBm?=
 =?utf-8?B?QUhHUHd0cGdoVTgvNXBOWW9MUnBHQnZ3bHh2djY4RFpmcFBmeXJjNTEyYVRp?=
 =?utf-8?B?enErcHEweFZjaEN6TlZWZmJGR2EzWVpWUG1DTm1ISTZrcEhFUXB4YkQrRVUw?=
 =?utf-8?B?blJOamhPaGNrK2Mxd2xiODFhbHRlcEVWcWtwVFhOOHpIMjNHZWNSWllFRGI4?=
 =?utf-8?B?WWZmcHJ4SENZK3ZjTG45M3VGSWkzZjVueDQ2VGZCVUpFSDJ5cnJmeGpNSUVa?=
 =?utf-8?B?OEtncjNaYlR3NWw2SVJ4aUl1UnVOL0IzMTlLVHMxQlkrbjUxMk05Smo5SkNs?=
 =?utf-8?B?eHdTeGRYSVBZc0xPNHlRcnI4b0puYjlkdFNUMkpvbVZFd005TWtpUUZnWmdT?=
 =?utf-8?B?QVB4azQ1c3hUS0VZSHpaMWFBMDZWZzh2YXZraHdRZFNQWjZXU0UrN2lYOUJQ?=
 =?utf-8?B?d1Z2emZUMzVVcnNjTkErNlMzOGlPNk51MnA4ZGJOU2lvdVZGcXdYbm9WeTRP?=
 =?utf-8?B?czE5VExITFNFQTM3RExkR2JZQlEwNGppRGEwYVdVNFpYR3FoN041MjhLTDZv?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b568b7f7-aba8-4af1-119f-08dc34b36768
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 21:07:11.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJXY7D1YD65poUInibChpbyXcLMn9T80W0dF+THhsC/fEPNjMMjM/eUCPNH3nThqBz7uorkFJyXxlquZbZltVg5OtBhaVGE8esn8/yrYHJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5100
X-OriginatorOrg: intel.com



On 2/23/2024 11:24 AM, Rahul Rameshbabu wrote:
> +/**
> + * struct ethtool_ts_stats - HW timestamping statistics
> + * @layer: input field denoting whether stats should be queried from the DMA or
> + *        PHY timestamping layer. Defaults to the active layer for packet
> + *        timestamping.
> + * @tx_stats: struct group for TX HW timestamping
> + *	@pkts: Number of packets successfully timestamped by the queried
> + *	      layer.
> + *	@lost: Number of packet timestamps that failed to get applied on a
> + *	      packet by the queried layer.
> + *	@late: Number of packet timestamps that were delivered by the
> + *	      hardware but were lost due to arriving too late.
> + *	@err: Number of timestamping errors that occurred on the queried
> + *	     layer.
> + */
> +struct ethtool_ts_stats {
> +	enum ethtool_ts_stats_layer layer;
> +	struct_group(tx_stats,
> +		u64 pkts;
> +		u64 lost;
> +		u64 late;
> +		u64 err;
> +	);
> +};

The Intel ice drivers has the following Tx timestamp statistics:

tx_hwtstamp_skipped - indicates when we get a Tx timestamp request but
are unable to fulfill it.
tx_hwtstamp_timeouts - indicates we had a Tx timestamp skb waiting for a
timestamp from hardware but it didn't get received within some internal
time limit.
tx_hwtstamp_flushed - indicates that we flushed an outstanding timestamp
before it completed, such as if the link resets or similar.
tx_hwtstamp_discarded - indicates that we obtained a timestamp from
hardware but were unable to complete it due to invalid cached data used
for timestamp extension.

I think these could be translated roughly to one of the lost, late, or
err stats. I am a bit confused as to how drivers could distinguish
between lost and late, but I guess that depends on the specific hardware
design.

In theory we could keep some of these more detailed stats but I don't
think we strictly need to be as detailed as the ice driver is.

The only major addition I think is the skipped stat, which I would
prefer to have. Perhaps that could be tracked in the netdev layer by
checking whether the skb flags to see whether or not the driver actually
set the appropriate flag?

I think i can otherwise translate the flushed status to the lost
category, the timeout to the late category, and everything else to the
error category. I can easily add a counter to track completed timestamps
as well.

TL;DR; I would like to see a "skipped" category since I think that
should be distinguished from general errors.

Thanks!

