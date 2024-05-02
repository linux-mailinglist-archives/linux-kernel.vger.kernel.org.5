Return-Path: <linux-kernel+bounces-166759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB5C8B9F24
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D92B23EFA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BB216D31F;
	Thu,  2 May 2024 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gV96aNpy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5242315D5A6
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669264; cv=fail; b=rtttH2sdqMuCEjAbDnoxbTjjtkEfxrOjniXQkX6Mj21KAqk42rPkPOqWSBYZ+eH7eDsk3KOhq6VKred0TV2qFBFV7R13I6yQ7KikSztZdvSvaN1fq1RPf+40FpGAjoQRLC8aB040iEI0QQJh7WmJggk21q8EFmLeYW05K/9LRBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669264; c=relaxed/simple;
	bh=XWyON9kGz53NFSkf7mRcuVfPD/Tr+vJVEFGpdJ/2zns=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QLYhqbi8K5T6kKosp6ko303KomV2WWhw0ZiQpo8hGwqULH/Dp8cTUnwrRh+kICyAW2bjwhhPRfwao1O0DkxwyVVbZB30VQUETMCEaIbg8D1qTMg/9Fp3HXXIhW3+WCf0RFYX1fNz0UZ5rq/IQ3qEjRWcRmsWrKf2ZFLxoHuegO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gV96aNpy; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714669263; x=1746205263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XWyON9kGz53NFSkf7mRcuVfPD/Tr+vJVEFGpdJ/2zns=;
  b=gV96aNpyK8tVs4T6+wCAeIJH4Y4kyqoVeun+EAGmE5iuTKx3r4IjHULo
   frP+teV15m+JF9FCp+iy1z35+RvM+wyqH1DP6PcE7cU2j+BJOmNcMbApd
   mBlL8w2/KcmU7y9BMVmSm2Pw6eZdelzFTN6gkin6sR4iWe9XwwpakXjHH
   E8SvSoHqYd6/C/JcMNVKOvj8TT6kvmqiCQ5e1NSERmgsF1LqM89CFxbKV
   creNV5Nx1XwqH69/yGgLmk+x2tPa3g0ebETeKPJJbTJN0Y87nfOOBKvUc
   R981et3JUz+yevyx+tvHA1Y2JTY5SU5zNsHOIL11hnA3C6IImmoSp74e2
   g==;
X-CSE-ConnectionGUID: H87vbeO8SHeZOg3CqU/UEQ==
X-CSE-MsgGUID: pGGgj5d2RyaM8Sx+uSvx9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10384125"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10384125"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 10:01:02 -0700
X-CSE-ConnectionGUID: ccSfyYIsSWidvK0vCAB+Xg==
X-CSE-MsgGUID: wDa0vrQFR62enbob50qoqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27580670"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 May 2024 10:01:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 10:01:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 10:01:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 10:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISe/2qxffA6n6zkUxN23oDlyD/M3PvgFAl0kwqPXYwf9eIWHDO3faoM/RmxYkguhj/q/rW7xIXEhd92TjDrTb31eie7jE7p3xIRVjZm9LASE7BQgqItBYuPXTsBiDcflIS6/dtRRXcZ9NQYCw1OqKz/M6EOcCilSv52fbnXzhASvygFiA+czVpwfisrVOwakGTrFYQsoJU8KVbmN4q/TjMWUszKiplHzVZVPRGKwOH0ek/NoqVMYa41qN9Fq440RkPbmLaHxya5vCi1pOg5V6yAHb/RTKyVlLg0BWWPItawA8Mydho+DubU0kdNemySFLmlx8iTzQrwJI/o9y5O5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6eMa0NX4gEsDU4cwBkUDH3B0FG4JSl6GBinzlago4M=;
 b=eqvO3FKAvUkY4H7jMzTsoRxgA+nwMsnz/8zRRQ9r8/iOX2nFcrZ3ysqKwJ8FSwszZlPnk1gnpgKydKuTQ6ZtDDuvxLR94N6UcOUDLjaK2OZMFz2qpfwaxUqU4MZzUsExQEjZepQiPIUHQi3zfvzsddMIH/tyjy7VwNabNjwBb1JjG31fUjwB12CX0tzYwkF7aRRKvyjFbJ7UCiJI4NMo2GgFkO5dldwd+wOOZrBjDgPkUVLs/+O6DN+Vg+IgCO5WxqC6SC9FoBqvhDzcdwusMLR8d4713z/ezGXqtO0CgF59cZXUcs+bmVxXhtTmPJTlbxfsXzG2nK0SH6rdT3mXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB8149.namprd11.prod.outlook.com (2603:10b6:208:447::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 17:00:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 17:00:55 +0000
Message-ID: <306195e9-83e4-43b9-a441-9bc1681317f6@intel.com>
Date: Thu, 2 May 2024 10:00:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Add support for Sub-NUMA cluster (SNC) systems
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	"Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>, Peter Newman
	<peternewman@google.com>, James Morse <james.morse@arm.com>, Babu Moger
	<babu.moger@amd.com>, Drew Fustini <dfustini@baylibre.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<patches@lists.linux.dev>
References: <20240327200352.236835-1-tony.luck@intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240327200352.236835-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0339.namprd04.prod.outlook.com
 (2603:10b6:303:8a::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: f946c64f-170a-4dbd-a68f-08dc6ac96e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekpraWkwOEN4TzJKY3BicXlpdm5KYUM2SnFEcnd6UGxtTGVleXYrU2lSRnFZ?=
 =?utf-8?B?a0g4VnV5ZUt0MUgxdjhWeTl3cm01bWVFTlpWTVFIOE5DSy82RnkzNUxEZ0NH?=
 =?utf-8?B?cEsxeWVBakIvSlRJUzJqcjMzbDd3RGRRMVVKaFBxTkpTRkt0STNJcC9QajVY?=
 =?utf-8?B?R29iTkRRdXA2L3llc1dBd1BmSkl0bk5RR1B0dW1vVUEvb2hqdXdxWThuTzMw?=
 =?utf-8?B?cGxBVitYMS9OQzhLQ09sSmRHdjkrUkIxdmoyNFpoNHEwR1BRQi9HOUxlc0Ex?=
 =?utf-8?B?Mi82VDNrNzZZc0h0SnJHR3JlS2NZVVlacDlMdGpqa081a2FnTmdLQVpFQkFR?=
 =?utf-8?B?N096SUcxbzBGY1M2ZDRhc25kci84M2tMc0hQbngySE1SL05kYnJyY0Rod2pT?=
 =?utf-8?B?MkpvVWoyeE5DL2dKaGdlc1JkZTBMcmFQMlRJaG5veDBIYjNrQ1ZGdmJ0V2Yv?=
 =?utf-8?B?MHRKSGFIZGw0T09aWG9FQk8wRHB3QVY5L0UzbWp6VXlIeHdIUjVJelFTdTY5?=
 =?utf-8?B?TG42bVYzOEpSRFIzRVYyY0hoM2lNTTFUYXhSWm5KZGVXcmRQcW1uMjRId01Z?=
 =?utf-8?B?YXh4cUNLTjhNaHh0NFhkd3hXNEQ2N0VkcUlCSG10eTNYekhQcHpCNmZOd0hv?=
 =?utf-8?B?SzdRN1hKdHFjL242bkUxQzRtTEVSUStyMkFKejRXZ1BPeWdoR1RCdzZwZ1Av?=
 =?utf-8?B?S25ucmZISEJhWXUwZnFNMnVIcGJnR1NOMHFick5JNXlFckQ4VUo4Z0U3TmEw?=
 =?utf-8?B?dFlwbSs4bkk3S05WTjcyZDMrTlk4S0xoTWJJTXMzR1VsN2RmRGlOM3IzZWJH?=
 =?utf-8?B?bUFzUk1kbVJramhEOVNFVWJPWFpBUzZuZXNwaUJBT0IwUDdCR1NQU1k2L1BF?=
 =?utf-8?B?T0RscmtOYitTYnROMFpYditOS3VBQ1JBREhqenlLWDkvN1k3Vmk5ZUlXN25P?=
 =?utf-8?B?QW5hcnJ5QzRVTVljVWZjbWNZcHgyUnlnRHd5STdaaGpqYWlCdFNteVJxYUkv?=
 =?utf-8?B?d2xmKzVzMW1tbnpNRHJEUHNWR3pwWmh4OXJTUXR4VXZ0dTRSS3BvVlFKa3la?=
 =?utf-8?B?U05QMmU0S1F6ajRMcHlyWkM4eEhqMXZmTFdmRGlQMGtocUYxQzBGNXBwNUR3?=
 =?utf-8?B?RUtra3FYZjBhWE1wR0tXSFRkU1dRY3lYTnZ5TFBjUXUydlVRU2d1YmNUeW12?=
 =?utf-8?B?VThiaHVtVFBmbTkyZE1GRnByTGwvb2k0em9DNjQ4RUh5ZVNCTHdRcnFFVSt4?=
 =?utf-8?B?TlFrNWVleXh5V21PUnBER2VkYUFrcnRFVDZHQVdxYkU5b3duUGN5c2Z6UzVP?=
 =?utf-8?B?MFUvWmJkajRJOTJjQ0VPazJqRFZaZXphblNiYzBUbDZzRE5WYzErNllQWTV5?=
 =?utf-8?B?cXRCV0QzYkNrQjNtU0tlOThyN21LdlFsTXNuZlpoeVhveWpXUEx1VE52ZkEz?=
 =?utf-8?B?bllyb1cwNXZSV3VhZ2RnMGczdFc3b3dXZGVOam9YQVo4MmR3WGZEVUxXMFhV?=
 =?utf-8?B?aWdIVFFPUHBtOCtuZ3VGbURyaDZDN0VvM1ZTcC9kbm5wZ0p0UGZHRHlpK3BJ?=
 =?utf-8?B?T1Q2WGRPcXFVUzhRNDdxVnJBc2RPMndDTmpQWkEySkp0eGwxdGJTTFZhdzFq?=
 =?utf-8?Q?Secad2ZCci4DAyPUOV3S+uOflf14sgZUy+FsPzGcHqyE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVNzdzdTVTZFQ0NNbVdjQVUzOEFtQWFOL1BvWkQ3OHorbS9CM2VBVmpxNUc3?=
 =?utf-8?B?SVgzVlhQWXlkVThjQlMxbzhwTGhNbVZnb1hJMVY5bEhScUVBOG4rdzBOWmxs?=
 =?utf-8?B?UmpVcEFwdmJhTUM1Z3RUeVNic2tYeFBEYkR5NlIvaC83M2VDRlhUNkdPZ0FF?=
 =?utf-8?B?VlhiWnlvVnNodGREUGhPUnd5YThPUktlcWYxMGI2RzhRQlI1TlE3VjFWcGFN?=
 =?utf-8?B?TEs1T0lXa2E4S1BzODN4dyt6TkF3STVUL05ISTRLSjVCWWtjVW01b2c2SVlt?=
 =?utf-8?B?OTBoMEgwOVVCaUVsZ3N6SEtWenZ5YlpQVnpHSUpjbzBBQXRXSnB5NlV2L3hI?=
 =?utf-8?B?WFFhTHdrSjZ6eUhPaGtjcGh2Q3B4aWdNRHlUUGVYWXhGMitLaWd1YzBCMFRF?=
 =?utf-8?B?blNKejl3UEh5MXNpek9oY2NOUGlPc3RnUFNSK0FBaDcyOGlpdHg5UHlzTUNu?=
 =?utf-8?B?c1NzVEtlMStYMy9EdEozK2ZXUUdlendrZ3FzUmRkVmc4VkxsQktRUjlpRmMx?=
 =?utf-8?B?bkhrSXc1SWxMeTBQU2dLN0ZudzNmOURLdHpRQTlDcldKTmFYRmtWT2lKTHZE?=
 =?utf-8?B?aEhTYXI1UExjQ2ZJNlpQRkx3NFdaM3pFVTZ2VGs4YjhZdElMaUNkQThSVjFs?=
 =?utf-8?B?S3lrQWZIRTk1dktQeWthWC8yZFBQeVJpU2FwUWNmQVViQ0F2QXdVU0VSSzRN?=
 =?utf-8?B?cElMc3pYOTRLWnMxK2Q5cUg5SExCTk1GY3V1QnFUd0N1NDdiRFVIeVlOTDVI?=
 =?utf-8?B?YW5IcytYLzBaVzVYaEpEL0RJMzJkVHp4a1M3aS9SZ0hvdlFsWCs3OXNjOGRI?=
 =?utf-8?B?U3U4VjJXN3BjOGpUS0xsUnNwWlI3ckxvR24yVW5NUEFpSVYwbzM1ek0rWDVV?=
 =?utf-8?B?alZ6Mmw3NjV0cVZ0SEpweGVNWGI3enI4MkdLc2xTT3VORVhVdGJJbmQ3cGVX?=
 =?utf-8?B?bUhXN2NXV284TVdFZ1h3YTlNWVJzT2ZEaU9vRVRUbU1Dck95MHpObVAranU5?=
 =?utf-8?B?K3V3TGp5T1JJcnBBblE4Q2psZmx4QkdTY2FmYzZyWDd5VUtHdFpuTVF5aEYz?=
 =?utf-8?B?alU0aTlPRzZqRGNqTnIyaXV3VzhsUmdSMzZZWXBWQmkzY1BHZm9WVjdkakpI?=
 =?utf-8?B?emNIYm55ZUdxdXhHL2tVQzNCMllYbFRPOVNCcFZmbHpRU2IrK1VKS3M0eTNP?=
 =?utf-8?B?eHNVSXQyaU1yd0RrSUhwUGtlbUczaWdLUWNaWnArbG0rRGE1NXRQRnlMNXdL?=
 =?utf-8?B?alNJUTY3bHFyYUx2RW1OT3NnN0JIVGxVa0JQL1Y1amlpd0dFZDJVZTZYTHZO?=
 =?utf-8?B?OGw1Snk0eFIrUElnOWRnZHczeVdSQXVNTm04WWxqRjZ5eG5mZjBWVy9NcVU0?=
 =?utf-8?B?aUZ1dGFBQWlTNXpaaEMxcXh6WXhkR05XY3BVV2VUeWVJaVV4Z1lIQnFNeE40?=
 =?utf-8?B?cGFpWlZnWGFrZzlmREJLWmhFL2VlbWh4enAvckhGRmtieEtFaG1xMEhGZHNI?=
 =?utf-8?B?NEplTkNrZ1FWekx1WjcrY1V4dFYxZUI4amo3UWtuQUN3MHJBZGZCaUwvbkhN?=
 =?utf-8?B?Y0RPaU9EbXNYY0dDZ3NjZEFCQTlaTkNRMjhWZjc0bG81Z3ZoRTJPOXFmZ3Rt?=
 =?utf-8?B?d29raHlyN000OERISDJLNHpBN01mc3RnQnVkT041ZlFKVmJpUnFLZWEyY0h6?=
 =?utf-8?B?U0JESDhtRkFjeVBzbjltV0dwYnA1b0Y0S0tHbTZhcXVhRDIrVVZid3pQaUlh?=
 =?utf-8?B?NHJXdFJ4S25ZZllEWWlQeEZQSEFMajNCUVovUTJHdjh0SHRScjhhdjlVRHBj?=
 =?utf-8?B?SVIya1pRYXEwM1ZQaStIUER2eGxVeU5FdjRVWENiUFpOQWdpUXRESlZCUGF2?=
 =?utf-8?B?Z0hzM2pXaU5kanhtanZPSXIrVG9CWUNiSmkyNXV2a0xTWlBpZWFLd0N6Q2E1?=
 =?utf-8?B?QllZWXExUUhPTjN3cUg3Tm95UU9JUnVVR2ZHSDBrNjc2NmFFVzFsVXFLTFBI?=
 =?utf-8?B?bGE3bWU2bEZIVVN2SnQvZUFiR0FZbW5KS1oyakxFTTdOdjNjcVoySDM0VWZR?=
 =?utf-8?B?WGV0WEJEQVdDSFNxelAwLzQ4akRFMWFIMzJTa2FtN1lhUXRUOHhPRHdUaVBW?=
 =?utf-8?B?L3RZSUcybGR3TkVsVmZDb3NGR0E0WVhNNUtIdUU2bnBzMkFSNHNCTmovWkpK?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f946c64f-170a-4dbd-a68f-08dc6ac96e6c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 17:00:55.5412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXzqpDbOxk16zR4gU0t3ksKFqvpaYegJmV4u8AwYGIuH+uukArICrC+HbPcQRylduv2uiTLozsvPd9r0D9hYUlnJ+8vrHN1+XvKqFwaCJB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8149
X-OriginatorOrg: intel.com

Hi Tony,

On 3/27/2024 1:03 PM, Tony Luck wrote:
> This series on top of v6.9-rc1 plus these two patches:
> 
> Link: https://lore.kernel.org/all/20240308213846.77075-1-tony.luck@intel.com/
> 
> The Sub-NUMA cluster feature on some Intel processors partitions the CPUs
> that share an L3 cache into two or more sets. This plays havoc with the
> Resource Director Technology (RDT) monitoring features.  Prior to this
> patch Intel has advised that SNC and RDT are incompatible.
> 
> Some of these CPU support an MSR that can partition the RMID counters in
> the same way. This allows monitoring features to be used. With the caveat
> that users must be aware that Linux may migrate tasks more frequently
> between SNC nodes than between "regular" NUMA nodes, so reading counters
> from all SNC nodes may be needed to get a complete picture of activity
> for tasks.
> 
> Cache and memory bandwidth allocation features continue to operate at
> the scope of the L3 cache.
> 
> This is a new approach triggered by the discussions that started with
> "How can users tell that SNC is enabled?" but then drifted into
> whether users of the legacy interface would really get what they
> expected when reading from monitor files in the mon_L3_* directories.
> 
> During that discussion I'd mentioned providing monitor values for both
> the L3 level, and also for each SNC node. That would provide full ABI
> compatibility while also giving the finer grained reporting from each
> SNC node.
> 
> Implementation sets up a new rdt_resource to track monitor resources
> with domains for each SNC node. This resource is only used when SNC
> mode is detected.
> 
> On SNC systems there is a parent-child relationship between the
> old L3 resource and the new SUBL3 resource. Reading from legacy
> files like mon_data/mon_L3_00/llc_occupancy reads and sums the RMID
> counters from all "child" domains in the SUBL3 resource. E.g. on
> an SNC3 system:
> 
> $ grep . mon_L3_01/llc_occupancy mon_L3_01/*/llc_occupancy
> mon_L3_01/llc_occupancy:413097984
> mon_L3_01/mon_SUBL3_03/llc_occupancy:141484032
> mon_L3_01/mon_SUBL3_04/llc_occupancy:135659520
> mon_L3_01/mon_SUBL3_05/llc_occupancy:135954432
> 
> So the L3 occupancy shows the total L3 occupancy which is
> the sum of the cache occupancy on each of the SNC nodes
> that share that L3 cache instance.
> 

This is back to the "duplicate a resource" solution that does the
unnecessary duplication of an entire resource and splits data structure
use between two resources for each resource to manage one portion.
My objections to this foundation on which this solution is
built remains.

This solution continues to build on this foundation in a way that
I find inappropriate. This solution wedges a new architectural concept
("parent" and "child" resources) into resctrl but does not integrate it.
All resources continue to be managed the same (not hierarchical) while
this artificial relationship is only selectively used when convenient
for SNC.

This solution also brings back a concept that was removed and yet
claims that it is "new" (bab6ee736873 ("x86/resctrl: Merge mon_capable
and mon_enabled"). Having gone through effort to clean this up deserves
a thorough justification why it is necessary to bring it back. I do
not see a justification though since it is used as a workaround
for resctrl to be able to deal with the unnecessary duplication of the
monitoring resource. Same thing for the rdt_l3_mon_resource global
pointer introduced here that is another workaround to deal with the
unnecessary duplication. These "tricks" to get this solution to work
makes this all very difficult to understand and maintain.

Using a "parent" resource to decide if one domain is a "child" of
another domain looks arbitrary to me. Just because the CPU mask of one
domain of one resource is a subset of the CPU mask of another domain of
another resource does not make the domain a child domain of the other.

It looks to me as though the "info" directory will now display two
monitoring resources to user space? I find that to be confusing and
the data exposed in that way is not clear to me ... for example,
both will now allow to set the global max_threshold_occupancy? How
should the number RMIDs be interpreted?

As I understand this rewrite aims to support the new file
hierarchy and to be able to have higher level files contain the sum of
the files below. I do not think a rewrite is necessary to
support this. I do continue to believe that the previous SNC enabling
is appropriate and as I understand support for this new display to user
space can be added to it. For example, could this not be accomplished
by adding one new member to struct rdt_resource that specifies the scope at
which to display the monitor data to user space? mkdir_mondata_subdir() can
use this field to decide how to create the files ... if the "display"
scope is the same as the monitoring scope then files are created as
it is now, if the "display" scope is different (required to be a superset)
then the files are created within a directory that matches the "display"
scope. I do not see why it would be required to have to work from a
stored CPU mask to determine relationships. I believe the id of the
"display" scope to create a sub-directory in can be determined dynamically
at this time. Similarly, the metadata of the files are used to indicate
when a sum is required.

Reinette


