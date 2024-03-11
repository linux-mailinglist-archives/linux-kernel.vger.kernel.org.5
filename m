Return-Path: <linux-kernel+bounces-98962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 112538781A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012F31C21913
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEB94087E;
	Mon, 11 Mar 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEVWUki4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C633405CB;
	Mon, 11 Mar 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167405; cv=fail; b=PwLL3FdRhQsqdc9dGZ2SqjKsc7AGA7RYoYElgqfKuw8y1NjlQImFIh7YdNLv5xtgqSeuftkFa+1HGXmZrB1fGxOIBE06XN8wY+8RyghlJDHlw7GKcd/P3IHR96UESJPLMB2ipGMG4JMgiGgL8jVkd9rmkiFI2+KdnezAp7uujVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167405; c=relaxed/simple;
	bh=RMa4rB9O9VpR4TK1JZMPga5eOoTIJ8U9HcqMEn3jgYQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oOQg/G0l+jDY6me8YzR+1b1QSaVgFShjUtyZRPQvcZ9kMZYwFoVeRMHy7UibbJa7xnUkSnnz2oMxevQ6IdA+9lDRSPjs7EhvvjfFAeRT+cQzAUzyMEaPINbDK6bo3v3uEb5mItXD4C+kmXyaO6Qc0lt3TjPv1BaRIh+5KYKjR2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEVWUki4; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710167404; x=1741703404;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=RMa4rB9O9VpR4TK1JZMPga5eOoTIJ8U9HcqMEn3jgYQ=;
  b=fEVWUki43BHDcsE+X/wVul/i5qrTPqJFej6vmKu1K1dCmx/sSyv/sv6a
   oQcUGOzBCnnvOB8dAT4e22RlCY4Yd4tWUUM0osPseWlCOhAom90rKygG1
   UPcIgMthPjt4xCamy6hIwouNuD+CcLSSAEdfWD+6aCenfApLCXnHwxYqj
   GLP3uAbM0RhgaSt8a+WZgL8PNHVTw2gm9/BrZW0EojjaN43vHLfwl4Okd
   NwIBCubSD/GKMGZbWB9DHoI6MCdL9mFFk47+m1aowg1Ldb37bVSOm0TUC
   OiJUZmsmLVjEyrXrMEeAspjiPVAZazHF+gVqS1Su3HK90h+zryTRFPZan
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4996373"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4996373"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:30:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11073279"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 07:30:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 07:30:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 07:30:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 07:30:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 07:30:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3zzbRupW7QfehERg+T22aaBvXoNiPzf9VYRvKVXYjnjJOWF7z0MBIPneem1QbNWnTqFzil+Rc3yvpRAHDEBHd2Q55rGRScjcHl3m3QE5iQkMDGaKROqSKmir46OFaAIoWX92YnUS6LxKmDeT4f0h99Ii07bsy41YnG/TyPeHXuoAM4goNAePmrZot3+suiU9VZQvMX641vhw03JQEvf+CjLJi/N49Z96xGdZ8x2/dMBEGGgrwLRd2nS1jvuyUGX1njjtkKNMUoJcrFhKr1NgWRTGni5PzWEyTBgfMUwx6HWf5uwW0pDYzUKd06MUeP0r74UPIaWJI5Rd7ruFc+IIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py47f9xgeYhSA0atAqskDp/okOY9rSm/z0WN3k0xZNo=;
 b=RRwhdclpmZ0AhgnkD5PMmcfcJlOU6gj3f1clV+G+LVSSC28l8qPyxyUBOkZbfK8pjyI7UAz749dpYhswnpzB2VhEQyHB++qVMi8HqoIt0yibm2iwE/+Kr3OgsPHyKdzJ1Ji8rrwaKY35caQLRHYE/HNP5oawIUo1PjqTsuuPmu9sp3fU6+O99rr2HhyKJWYW5nshoDlrPZcpSk8OF1QTAlaNkirYNbdPZFSHZgXptVmAYkNbl0LG1KFSxwUX9IdhZyYvlo0jw6mUwWTLVJlOINnxQV4HR7dyTuX6aXq+i5vra2aO1tq97MkD3w8ifOoiJa1i5+WSaLis9B48CclBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM6PR11MB4548.namprd11.prod.outlook.com (2603:10b6:5:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Mon, 11 Mar
 2024 14:29:59 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7386.015; Mon, 11 Mar 2024
 14:29:59 +0000
Message-ID: <10dcb1bd-1a61-46e8-81c3-bc87542b72c4@intel.com>
Date: Mon, 11 Mar 2024 15:29:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: marvell: prestera: force good base mac
Content-Language: en-US
To: Elad Nachman <enachman@marvell.com>, <taras.chornyi@plvision.eu>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew@lunn.ch>, <kory.maincent@bootlin.com>,
	<thomas.petazzoni@bootlin.com>, <miquel.raynal@bootlin.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240311135112.2642491-1-enachman@marvell.com>
 <20240311135112.2642491-4-enachman@marvell.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240311135112.2642491-4-enachman@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM6PR11MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4b0e6f-e98c-496b-ad16-08dc41d7baf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIJwzHcGb4xfHFPw3CMGDpg3sE/XAuOYrzvt9hPUuoCAsSpgNUbBTzGOiw6hQGyKpcgb+4oPzX88L5oK2leIwOTz7KakyugPKyYVerMR0dbuFnc9axFKKHjIsPnmGyHQesQPpUFRaTpsM6ERilkf/dtRg82Sx8tzGUgTjtZQtHKdKAZUDyWTT2CgXPPcVof4tmJytEw/Rt71mB6ljFWweaTMBVR2a7+hWKFHswkqPVr0YYsB0QfI3oVv8WFKGG7BQUvJuFmKdfR8UUdkVsQZbQRktHmef10YSWeZo5uk5CLfDeUmkcN63DVfelorMbqW1FrJixpJmw9fXshYqH1GfCKYn4ifL3pBcFQFPmcj3gvGaX6cgNyua4OBk5LK6emJDezdF+2xwuP+wxS5bUyboPbj2IqmvvPQayu5c85NoRWOZRTWZFPpPuWoCHIJzOzTl1VP2LXdvoscPNpCm2UooPbYLeM6lcLkbuMJ9OF7I2ZVnQFwu7gcNZMpHvFh5RtX5KZnI6blirTL+K1w3XCrbEhm7dfZ0JWIkvkMw6uV+XtHkNF2RYMkVKjD+UEJezVpOc+qTBVfnVyszUWboNEQ+qWsTZQNJgZ1SGHnybqkVh3d3rxdxl/z40R6uDPKJO9X2Wa1hutPJsAnD5wahfV5ZWRCgUN/MPKtiWt0uNKtLaZjVjPpEg8OrkKvI7cEqTZZp8weHrIBUNn8K8NJ5JtGaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2oxVkdTV2Q1UGpMSkxnYVFIQmM4QkZpbUU4bjBWSXNDb1FVeFhHK2hJR2Zp?=
 =?utf-8?B?Wm4rMWNjZlh1SWlRRnY5VGlZRzNqcEVVVVRKVkxQYnp2bWhzTTYzRW4zNG5Q?=
 =?utf-8?B?QmVveTczT3pPbXRROTVkUU1aOUJnYnByNnk0TlVrS0hIQmVWazdkUGh0aE0x?=
 =?utf-8?B?M0QrVjNIam5yTzlRZE1VaTNESzVJZStlYUJIYkIrb3RLZmlROGloeWJCVnJm?=
 =?utf-8?B?b3RnRlFjUzhRcEhTb0Roa1F2SXJ0RzVOemQ3TlBYNzZrdllJcC9HeWxGL2pM?=
 =?utf-8?B?ODN6UnNsOHJFUm5XREh1Q2tSeVNnd2tMTzI3cXVNdWZjZkc0N0lQenJKRlRk?=
 =?utf-8?B?aW9BamJGMHRERUUvUEFlakFyOWR1bDhHZ1pXMXdqQnF1cXkzdjhuL1c3MXVC?=
 =?utf-8?B?UjV2N3lIZzJTb0Y2blkxaDRnaktJdmhIVFV4ZDg2bmY2MGE2bHUzV0ZHWnZ5?=
 =?utf-8?B?S05FK2piZUpPeExZd3krS1lNVGNBM1ZpYVdpanFHblAwK2JWOU1kSWMxYmpz?=
 =?utf-8?B?Y3BjdFA2N2pkaFFOOWt1bm5MdWVSak51d2pqTm90RGQzM3JUcy9iMXg4NlNi?=
 =?utf-8?B?Z3ZIYWdhcm5obStYOXFyaXlmRnEwSGFZaktrUHkyVnZERVJ5NVBPQzdLZjlL?=
 =?utf-8?B?TFhaVEdxU0ljT2VBSEFuWVdjMnhodHlISEYzcURSRkw0d3pEWVRLQnUwTVdJ?=
 =?utf-8?B?VVgxd3hQbXY3dThCQWptM3NpdlRRK25zckZyblVQUUpiTkJQajJpUVdzbWpJ?=
 =?utf-8?B?OWhrZVFDdHgrUkNGWjJpcHkwMHVjdTZndk5rQWlnRk82dGhwVkNQNkJrQXRE?=
 =?utf-8?B?eGxIVGhjbU8zcHpPUDNSYUpWRHZEQVNkVE95N29EbDhia1QvRHNkZjV3T0xy?=
 =?utf-8?B?UkRudVhSNzY4aWgzSXorZVczZmhFcTZDaUFOWkg5dmJWVjdMeUlZOTNyU1lC?=
 =?utf-8?B?SU1VdjV1V2grUXhOUUpLS3R3ZUZ6cTBXWWNmN2s4enptZ3pDbEZmaHFicS9a?=
 =?utf-8?B?Uy9vYTEybGN0RHlVeTVuSVFrUUJzZnRwQmpRZW80QXF4SmdKNWlMRWExQmkz?=
 =?utf-8?B?UzBuR0xZb0xFNlhyUklLSWJlZHIvVHA2OWI5MWsvd1hmejdOSmQwLzMxZDhv?=
 =?utf-8?B?c2d2bHNreFdPTnpidzlreFZ3K29QRC92VzdMcFlaYkRTa3ZlaE4wTXArZldk?=
 =?utf-8?B?bDVYZm1QVFQrT3A2clQ3ZzQzWEhNSFUybGZ6elIxMENjaEpDdmJRMGtSTUFw?=
 =?utf-8?B?RGNlaVB0K0Z0NmZKOWc5MERiT2pyTmFYMUdocURuMzRuMEtveWR5NFNuSTBL?=
 =?utf-8?B?YkJxcTlUcFdiVTVQaVJqSlVzR2l1TWdoazRXNHFObng3WGs4dk5BeURkOEtr?=
 =?utf-8?B?QmxZbnFyYnpIa2p4T1RVSjQzZzRqd2RydGVnYzR2b2RoMTVybVJ1L2FCVzJW?=
 =?utf-8?B?MnBReCtoVHVYRmVvVW9tckxzYzY2MHVBLzZKUExQM2JkREFCOVQzUHZNRURF?=
 =?utf-8?B?N25CdGFscHk5MVQ4QlIwZXcvRXpFV2Vhb1BXamF3OVFrRmRZdEg1WUxpV2dn?=
 =?utf-8?B?c1FHS3JXTkN4UTQrV0tzT0ttVUo3QzcxTDcvdXBHaVp2M1IwSWJCNGRTWTBP?=
 =?utf-8?B?dTJYeHNWaDMyYXBJenkxNUlyOWlrSGtTeFczTWpJa1lHQVpTcmlkVkp2V0dP?=
 =?utf-8?B?SERkeGp1eW8vcTVTN1dUdXAyWFdBUUtIQ0d6Zm5DZ2FvWHBwdDFQL3NCdDhx?=
 =?utf-8?B?MGI4c0Mxa1Z6YUowemsrNHRjVkt2RDQ0Q0o3UjlNMjFQM09xY0MwaXNGNnpo?=
 =?utf-8?B?b2dkVEVtWVNLSjhDOWt6OGhHS2FHWHl2cW55RVBNc3llTVdhL21zc0YvN2dO?=
 =?utf-8?B?aS82ZzBqUUtiNDIzekpLdnhIa0ZmNkxHMUN0dkxKemlPM3VRekF6dE1VVlpH?=
 =?utf-8?B?NWdnVlZ0VEljM1p2eFFTYzdQVDMxZGxaczZHQnFDSXZLbURXbUJSRzhaeTdp?=
 =?utf-8?B?M2prSWU3SDViZVg2ck11RnBHYlE3T3p2OGVTeUZCSXNnNFJzbHNvZTVjajZi?=
 =?utf-8?B?RkVockdqc2VUb0NqRFZzNkNvc3c2akc0cEplb0pCZWN3YVgwUXlQc08rcWNp?=
 =?utf-8?B?eVpDbTRxZlZLdStGUjAyWUI5N0xONEYvc1hOY0FPeFZRUmVCUWxndjRRTktt?=
 =?utf-8?Q?p3ujlPqHBj3KaZKpBwmKRz4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4b0e6f-e98c-496b-ad16-08dc41d7baf9
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 14:29:59.2169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suvDM5FjFzoR2kI69/5Kdd/U760SeZQpCfjReZS6pv36jcLiAIQ3CmPLWfBclAxvno8y6WZYtjYXxpdudWj+/GmJlNnPcG5FTrUIAob1pVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4548
X-OriginatorOrg: intel.com

On 3/11/24 14:51, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Since each switchport MAC address uses the switch base mac address
> and adds the physical port number to it,
> Force the last byte of the switch base mac address to be at
> least 128, so when adding to it, we will not wrap around the

to be at *most* 128

> previous (more significant) mac address byte, resulting in a
> warning message.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>   drivers/net/ethernet/marvell/prestera/prestera_main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
> index bcaa8ea27b49..e17b1a24fe18 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
> @@ -859,7 +859,9 @@ static int prestera_switch_set_base_mac_addr(struct prestera_switch *sw)
>   	if (sw->np)
>   		ret = of_get_mac_address(sw->np, sw->base_mac);
>   	if (!is_valid_ether_addr(sw->base_mac) || ret) {
> -		eth_random_addr(sw->base_mac);
> +		do {
> +			eth_random_addr(sw->base_mac);
> +		} while (sw->base_mac[5] > 0x80);

Instead of this loop, that uses 6 bytes of random data at each step,
I would just fix the last byte.

Either by calling get_random_u8() in a loop, or perhaps better, just
toggle of MSB unconditionally:
sw->base_mac[5] &= ~0x80; // or '&= 127'

what would change your condition in commit message to "to be at most
127", but I think that should be fine, granted simpler code.

>   		dev_info(prestera_dev(sw), "using random base mac address\n");
>   	}
>   


