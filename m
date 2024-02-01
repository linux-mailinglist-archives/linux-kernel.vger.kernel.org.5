Return-Path: <linux-kernel+bounces-48937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8882884635F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B5228AA60
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038043D566;
	Thu,  1 Feb 2024 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSyWTZxU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579F83FE51
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826278; cv=fail; b=FmV99pwMMmiw36Qi99AUeEuDNHzsptLtVmqfIsdL9pTJ+udcWmgffRwmAWYKIDGguaTBB54eb1sRimtQCBiX0mTCk/zsyCtfsYWC5TyuAAiEvgQEZfATC7OANf1ZM1DsdiNqzTWiHWudgTn++Gxo8HJn9yDlsVQB4qi/t5sAtig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826278; c=relaxed/simple;
	bh=PthAk0H2mLcVFoGmhV/aSvd3Qla8wwt68XCunPr9+Ec=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tt5fsufP/Lw+e2DJazxEslSO8hF7D2PRrvc87pwDMvZ1BIpvpgrQ+hq2xxrUa4peE5UMG0wqpU7EudvKHhedWfGQRmYZ4jw+A1oWhfqcr4+NIWB7A3kt4mzJkAgz9qA1/cQLzHvzrIfKmebM9KgU37uir/xeptwDgPVplwvs8w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSyWTZxU; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706826276; x=1738362276;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PthAk0H2mLcVFoGmhV/aSvd3Qla8wwt68XCunPr9+Ec=;
  b=OSyWTZxUV16OzxPZEXJ8t2kiq+pkgxcmho+lk+vuO3QG+tlApKDq8OE/
   yygiFSP7rjyJJwnqKQSL0tMFEOzuQ8ymQgNvYlrRcqB29Dh1gDBxihg5V
   vZ5uXje6EFUvLqoTFgNLdkiHOR4i0l+q9RLfgwgV+AakNx3EDRyD0GBVG
   +lnbm6YsWWGHUSLqyxgoxwK4R5zkNBjiOI2khHdYVXUOCzo510fvVftP8
   7PvU9+xXBiLxRVRjPJ0vzt8tkhb5ZBu5oaqKCcrFaDfTLxj3Ln7kuegks
   de2CcsMiKYaOi9mp/9Ks+GBVHgrh4auUSCEG2uNQKMNcmHaDKu7dPcBXs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11393315"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="11393315"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 14:24:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="234043"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 14:24:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 14:24:34 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 14:24:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 14:24:34 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 14:24:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCI5B9JWx1H1BWR+Fg0QTCx3rZrInr33zHHGA6u59Dt0OYrl1i7dA9ldk6I/wzG9HXU4UEvL/tx77sShlnJ7q/Qz4Yxj0NqRN5suisFuo7O8n16gvEiqPvE7/Sf5xZIAeKnQXyLVXpNx6s0rNYZxdfpvJTj4CRMh2pZs4opf4nm2fIrwRzy7bPF30ucgtmIO61L+4PtkMTwBW7zmSiLC4c/Oj2C5YfJt35QCWkRjtBL2BNpCOJjjtkKdaQND+2od1UU4fAhHeSWTGu/dRLVdw18xuIdIv+I00XQqhyfJPlmd3glb0/eOCPPal9MYv85lJJRca77ufXHZaeIWkqiB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrdFKLsdXOhbdMLdC7ST3gEY6tq72PAmtuuMr9JVJXI=;
 b=meSj/gIf4XLHppCIhlJmrWSZTt02f6XeaDdnN7BYvkLgNn+BCZ7BwhSvZnvn7wIQyiUwF2gIY5mkecJc1APECfoetbGPB8vNZU5m2+aL439uxubCqDiaoz0lnyQrOemYju105Kvvta/77WOb/MOFtaxSRgVMgtBtaY5HacQfYoLBsa5qlyqKLJPgEMSjqv6vdFr95ddH/MF0cNuec05LBK8YccD1D+Vbxxwmm598JGwCH389VGlJzyBp3363bIHg8YVlqCTxNbJZNAWV4YoANuSPOIf6+2Z6/4uXXjDOkj8c4tM+BlniOfgPoJBJKoLiO7YkrNsTSfV0R4dznPfMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Thu, 1 Feb
 2024 22:24:30 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7228.035; Thu, 1 Feb 2024
 22:24:29 +0000
Message-ID: <49d3bba9-0235-466c-b84a-7eef4d8f6ac2@intel.com>
Date: Thu, 1 Feb 2024 14:24:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 04/22] x86/apic: Get rid of get_physical_broadcast()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Arjan van de Ven <arjan@linux.intel.com>, "Huang
 Rui" <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>, Dimitri Sivanich
	<dimitri.sivanich@hpe.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Feng Tang <feng.tang@intel.com>, "Andy
 Shevchenko" <andy@infradead.org>, Michael Kelley <mhklinux@outlook.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, Wei Liu <wei.liu@kernel.org>
References: <20240117124704.044462658@linutronix.de>
 <20240117124902.600583242@linutronix.de>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240117124902.600583242@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0035.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::48) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 135a678d-f1e6-40bb-73a9-08dc23748ec6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1n78l4/UIASAK/04eAGxcQH7oBcVL2gJJp9qnqAIJvMNQ68lsHqUxs0m1JLbT5LWMe4BRJCwNnLazw16Y9hKCdETGMmdeh1jGPKt81zIJrCyuuAovT8tkPam9H4ZJPhDpgw/Oh0N/Pzja/VT/TKLaEQeS++Ql3R2zgwpnnJX76GX/gONEO83HXd0TdL5GTGpMK7NAdAYyacYScp54Z1FKQNNvQqcUWJxqbEYJKJPKaqKlLF7ttMjLrDKPt5/WuQSgeTXhBnzrF+GxUT9cB42QJfb986Vm7yuvn9hkPhZkYUzSEe4eqe9TammSxrmYMtZDVTZ+t7xg5qpPUQ/mVVNv7sKojWnlrz9G7BBWya34T524jTIlQtLoBGIknsMtNMhGQ20w4VCqOLWYRh2ZvezMsET8vWNfLFkRl221MTmzINY/sWEpbbsCQPe2+Y85aGcYBUy9R1UrH6OSB/zKeOL8bvWVqXswrLKZWKPqbxy4urkXgdub6rlxicgsfU+KbF2zL5Ywy8ZrSEBp/17BfhHzFklyEQaQyVlywhJbyV3BhQYtZK4z7CJS7w2lhsnefBpXoUlYybHBzFfiARxBdKP27GOQUOoX8IVRmHR6jhHNq4t0OLmHr1J6WoMq6+2IEQAQ5zv2LfLKulpON13LPMOS0SKu3lrGJwv8oDHNKMyGXoTEVOa4c66VmclV7nstzjJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(478600001)(6506007)(6486002)(26005)(2616005)(38100700002)(41300700001)(86362001)(31696002)(82960400001)(36756003)(53546011)(6512007)(44832011)(7416002)(5660300002)(4326008)(8936002)(8676002)(4744005)(2906002)(31686004)(66556008)(66946007)(316002)(110136005)(66476007)(54906003)(26583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGk1WVp4dUx0VGxsVXRpLzdzdjE4ZEpNV0VHcFJKeVY1VDB3ZUI2RTFzWnBL?=
 =?utf-8?B?OFZyd0JrVHFDZ3dlSmU5bGlmLzJyNU13N1oySDU2cEFtUWc3SDJwREhNSUw1?=
 =?utf-8?B?ZjBTK09xNDVuWGhiMUxIVUQ0K3g4cnpaRjNjZ1JUaWlGT1oxOFRNWEVMMFh3?=
 =?utf-8?B?a21KRDhCNklsRnFHb0JPQUxFUWhZNWJQMWNMYWEzV2ZjbmZjNjM1cDF0Z1Qv?=
 =?utf-8?B?MFZZUk56eTY4TUVxNUVyUkgzZWNVOU1sOWVnbFg4TUFrUlNUYWcwNVN1Z0Zn?=
 =?utf-8?B?ZXFrK0ZZbVhFeXBlN1IyUXQ0dEpaUFlvK0FPMHl2ZDhmcHpoalFXeTlJakdI?=
 =?utf-8?B?SmppNVQ2QW42NXlvMG5UTzYyY2NYa2dUdWtPRnZDQ3c2dklpVm9yK2FhREsv?=
 =?utf-8?B?dEIwS0UySkVkbldwQ0lvalphS01IODNoRnRYVGVoakx6ZGNPR240Zm5WU0hq?=
 =?utf-8?B?aTd0VjEyT01sZ3BZajl4VWw3dm45d2ZMa254c08ybndHNUp1TTNxMFhaL242?=
 =?utf-8?B?UE5WRUdXU1ZuNU1jemkvY1lycEM3Z2VpU2ZpNHc3b2xPd2JoaHJxcDd0VDN0?=
 =?utf-8?B?OUdVVG5YNFRDM2ErTWR0RGdGQ29ldDZ1TzBIWUpwN3hzY0EwUFlXYW1lamZs?=
 =?utf-8?B?Tk0vaUZTaDAxaDRNUkpjMkxnMHhTYUw4NTRtcSs4RkF2Nmw5YXk3N2V5anJq?=
 =?utf-8?B?UEE3V0NGLzhvM0NOcVpzQ1hzU2VQeitlVUVwKzlGdXFHanlRTThlZTNYejM1?=
 =?utf-8?B?bDRIcHNHZjhUWjlZRzV2U0VaRExwalJlTDVmVmc4WlhCRUdnYWlHZXNMN2dT?=
 =?utf-8?B?UTQ1OUhZTlBUeFpOSklXLzJZRG5UelNBc1QwMExoWjB2VThMWVp6SzdCQVR1?=
 =?utf-8?B?T3c0SzJ5SHlxSXFlUyt6WEpzNk43RTNnc1poZmd1LzVxQzF4Wkw4OW5Oby9K?=
 =?utf-8?B?SU8xOW9tRXlaZlAvZFp6UXl4ZlZKdW8wRW5pOFZhVFh1RTk2WU8wOEdPTHZy?=
 =?utf-8?B?V0c5MjNVZ0MxK3hTeFNiSHQxWHJaMDdWaDk3a1NZSDFwK0lEUk5mYmhORFF1?=
 =?utf-8?B?NlBVazJaeFQ3Mkg0QStqRzVoNFQ3dktMSTR4VSsyR1FaZHZaVzFvZW1jNE1v?=
 =?utf-8?B?bFFPb1B0WlJtTUhPb1lrbWZYdHgwUlRiRDdmWHBBNitLOXZFdWZMUDF5VVQv?=
 =?utf-8?B?OFVkTTJ2dUp6TG5uM2NHUy9kckZqTkRFVzRqMFdGanJMZUNLWWZuZkxEd1Zh?=
 =?utf-8?B?MmdoM3dKQTJnTFQ2VDBxNnUwRkhkS3VWb1dUL1FwUjgzTTZQeGZxclJ0dUpW?=
 =?utf-8?B?Y3BYKzNBSkJvaitTZ3EwWC91MkZZMVBTWEw3UEw0YkdEYVNnandURVNrMmJj?=
 =?utf-8?B?SkppenlvVmZzRXZuNklxcVZEamc2ZUhvRE8rMnBSTU1LbU5reXY3Q2lpVDlm?=
 =?utf-8?B?YzM0bWJScjF2NnE5aXM3OGtRSEJGQ0s2MHRuRW1uMVNyQ3lHOG5WN2FodVZO?=
 =?utf-8?B?bk1hMkxzb083ckF6ZGpKK3RxbVFPZ0F3S1JRamdZaEtaQzdEVFhvZEFWeTlw?=
 =?utf-8?B?MTg5NHV6NlY1WVUxL3UrcVhqUy9NOThxcGtBUXRHUDBIY0pGU2lkdFdWUEZw?=
 =?utf-8?B?djVBd2JDOCsyQnlEbkZmQy9DOGd3N3pFTjdiWWxKemRwRFVoc0llNnpPdGNh?=
 =?utf-8?B?b3B6VE9wem9VUU9GL2pyb09HLzFhODdGTGtBTnplU0xpM3NoVzZYMmNVbS9O?=
 =?utf-8?B?OHcraUdKWjBidHFFbjI5TWlTMzlsTUdEb0tOcWppZ3FqYjJ3NWRYWG9mSXh5?=
 =?utf-8?B?UVRpL2RCeTI5cndjSlloaDIyUnQ3MldHZ2s1WHprcnB6ZHU4bC9oNTQ5eEFn?=
 =?utf-8?B?ZTlRM256bUpnU0krYXZNM2dCS0Nja0EyUWRaRkUvclZZSVRFcFNxckprQ3Z2?=
 =?utf-8?B?czBCRTB0aklxYW5YSnRDbjJZVW1kSkhaTlZGODJIVUNnamJnSnhDTWNFUGpm?=
 =?utf-8?B?YjJHbEJRQUZVT0ZwNUMvM1Qvd1dZZEdyS1RTK0ZHUlRQZXJHeXo0TlJVVFlJ?=
 =?utf-8?B?ZTA4WkZFQTVJWUVNSTloaExNSTlkQldPMEczYnFTWm9zNDZ5YXhWS1RVL251?=
 =?utf-8?Q?pWu1DikGrZddjuX4l1sWtxca/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 135a678d-f1e6-40bb-73a9-08dc23748ec6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 22:24:29.9361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5UcPy2gXI9QEeqXAX0uZLkByi0oJreF+o4j749XgEefwChqzCXKYOgnVhBbsW1eDOHPBEISSh9vKvTYnd7PTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8020
X-OriginatorOrg: intel.com

On 1/23/2024 5:10 AM, Thomas Gleixner wrote:

> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c

> @@ -1499,15 +1498,14 @@ static void __init setup_ioapic_ids_from
>  		 */
>  		if (apic->check_apicid_used(&phys_id_present_map,
>  					    mpc_ioapic_id(ioapic_idx))) {
> -			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
> +			pr_err(FW_BUG "IO-APIC#%d ID %d is already used!...\n",
>  				ioapic_idx, mpc_ioapic_id(ioapic_idx));

The second line could be aligned to match the open parenthesis.

