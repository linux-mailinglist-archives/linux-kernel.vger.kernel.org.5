Return-Path: <linux-kernel+bounces-66960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4910856469
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D515B2B9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211F130AE4;
	Thu, 15 Feb 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcjaVjnD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9CF12FB3A;
	Thu, 15 Feb 2024 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002771; cv=fail; b=C4sFl/duETZ3GBtWohlry3c5LwSeU8TNkZAhCP3PHNXhE1yohKupTNdeUCLmybpQ+iSaVOcbb0mYLIMqqhdHPYwSZmB54m26ahSArQlQKRTipjjf4JTgJAGE/bVSQi9tz93rUYbqhtTRDa42m4Xk8fy3ZSMGW57cVtjnp52BwRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002771; c=relaxed/simple;
	bh=4sXY7ZVaDXR+6hGwp/cXCx2Xk+qrai4LQXhXKVPRmGk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F1y60FJdtIA/n6R74yjF3/KfyphcD3dMuJpDEaI7U+BWipMVfcGvvkBq/wU3DkqUHnHahf6y5nzQJD5ZKA9fwXUjrUnMbiuEHKWIDquf748BYWy0SIFrfNJS18bfHUGIcmhekhT3YJFvPBoqes1K9rBVSwsM4MbG3CXLNwjSIQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcjaVjnD; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708002770; x=1739538770;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4sXY7ZVaDXR+6hGwp/cXCx2Xk+qrai4LQXhXKVPRmGk=;
  b=FcjaVjnDDu1XuVStmJXB+FyW22r7Ev5q3o/+7JP2hEwQcgdaq5vDiLgz
   2Pp1I7EnJ5gVxIXDtnF0uOlU9j04dnFIGvgPCL2Bs1A9iu5AiYC7V3nP4
   HSZRaypUbtcXv2vReAeTcFYDhJEGIyIyLB98tSpOXaHfaZUvMmnfteXYB
   loLMCu8D1rWkrdvEk/fiZtzAd0iY3tgDkaxDTT6IRU8SsnGNZ0LYB5jMz
   8vQbUVhwtAEaYRPG9hjaswYDPoTCFnVStE6CrtpvuVoboCz2kgquPHqvi
   oMK00bTWFAhwtPQLkYdqf6DupToxM+aitiIARFkfQYwO11GXO+PcZfkyM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13478096"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="13478096"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:12:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8135627"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 05:12:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 05:12:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 05:12:48 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 05:12:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXzKlyfsXadNR1PPdmRajubeco6rzgXLnerKy75YzsnUBPKgG5huHVUejVUsdYuWoiEVrVxhkWs20KWEAkDHBKqB4OwQB02zq8uEWRaln/J76ah2SkX6EyfWW7XMWa/3jeL+4TdaYTvQZKqrwYu5rNoqcZngKFh/bLv8Db4KEXQ07VgrC7DBvKEhdOM6iYWJ8FtDPvQ6AS7t1Xs0LUDAR6FI6cayoYCIeDGD62yq7cttQPD2wx4zpuyCCcCvSXG7V0Eh4rGHf1MOiwJaNeYlwUkt/I5ROc4SX1RBYC9zStbEHc0p8/O101hjNwDzX1Kii1Jq1126DbE8+6fHrd1NlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCIM6eS21eYaE87kaPgJcWEnT3Z9E5zo7dM9A75FYao=;
 b=nnaFIydj2PQz9xTCj9tebQYDvFFecij2j9LLGRNuX9OS+KVEU381zNcrOaxRrb2515hVIpn/hypehxd688yKBizl9J4/ySZccqgDMrwZo1pLIpspOS0RFL1uzsgX1wp+ZsgTuTWCqIpw0UQhoYWIsf3FDy4L2NB1W3eu0dq6F3qHhkI5Ata8u9iy/h1VHD+TMp8cxc/sv9/Kyz2PPk3I+fi26pj5EQtriDk7Q5blvXWhN9/QT5lfB6a0iFD9IB+xdnmBMifexz0M44WwNxkK7JItxTa4Al5WaYeGcVAEdgLiRcuFTTd61LS6ypFjAGIAf+UJSyA08RusdGmNqya8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB6727.namprd11.prod.outlook.com (2603:10b6:806:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 13:12:46 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6%6]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 13:12:45 +0000
Message-ID: <8aa809c0-585f-4750-98d4-e19165c6ff73@intel.com>
Date: Thu, 15 Feb 2024 14:12:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] page_pool: disable direct recycling based on
 pool->cpuid on destroy
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240215113905.96817-1-aleksander.lobakin@intel.com>
 <87v86qc4qd.fsf@toke.dk>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <87v86qc4qd.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4a7720-2b7a-4e93-f088-08dc2e27ccdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6BoV+9HxPkWpxok7BFLadqygHl4wPCpvTJ9nr1SPiGDAjcocmPRDDsNGHmY2+p4JKSoHKi+Jy4R9B+NMl0aYDs9sfCOHCONcCnGQdQTA9c4lv5hy5YCDl7UHIDOWTiZpbhubDtHV6yqSU+g5NAlBjp9jo8UoumFehZFJPebToOg5bUR4RrdEWKxlfzD9RRjnBBbSzxM0UT7jUMJ7Pxo+4ftd5Wgp2D4/vDwNOmYEZxwdzTtddNnZX+dmYgcnRe31BNpTirfTEKa4i7yJOhEOBAjk6qbzaCDVcr6YNhgCeglOxHlx3FoWlq1gt//HSgDS5Nh6xGINgjtyo1ZcNZooPQvcUE9Px+BS9N25RZILlUBPpkGnu6Z+16iPKN1UzvDPr6QeYUeeGCDha4Yg+xZo2ie9TacA6qyMDGBqBxddSgyBDGAHaqDiYkC6lugG48+k2vE5GfwAM8ksVhJKtvL+hXpO42EoR2Lg6AAqyHGV31k1G6ONJtSnRksIsD/bRBrNur5lfFGUhbwWAaHi7So7OXrbCLepa+HQH9HQLOLts8RWpGOssSzbvmlBk/Zqr5o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(8936002)(8676002)(2906002)(4326008)(5660300002)(86362001)(2616005)(38100700002)(36756003)(26005)(31696002)(82960400001)(66556008)(6506007)(316002)(66946007)(66476007)(110136005)(54906003)(6512007)(6486002)(478600001)(31686004)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjRvd09ocDcvRlVuWitiK21abExwYkJFWWErc2VqWjlOTE1iQkMrWnV2cWYw?=
 =?utf-8?B?S0FpQmZQQnc4Y3AxSVRETlhyUDZnMzYrYVBUY0xiTFNFUGxkQmV5SWJnU20w?=
 =?utf-8?B?akN4eWROczc2eHIzWVl0d3h1a0ZlSEFBZFcyWExRaGo1VndPem1YYUthR0J4?=
 =?utf-8?B?SGMvZUx0aWZnWDBsdnMxZCtVTk1Oc3hJNTZCNkh2Q1c3NGZwaDYzdkQzbnZB?=
 =?utf-8?B?RHEvMHZ4YXNHenhEL2NGc2duZEcwVXUrcDZoYjlLY0c0Wm5wNGpXQ2xxZ1RO?=
 =?utf-8?B?VmJBV3NuY2VhUVVmSW1ETjVYdzBlZHpFR1RVazNLM1hhNVpSbXVvNTVwYXJs?=
 =?utf-8?B?dFdSL1FBWWVxbS83YVJpVmlMZVcwRUsrT2kzL1lOTk12SUlBdUsvQlUzOFpn?=
 =?utf-8?B?cVRUL0hXN0crU0tHTjBPMUtRNE5GRHpER3k5OURnMzFLSzV1U0RkSjRJTnNN?=
 =?utf-8?B?NndCRkphNGlNV2dVb3BNdTZldWhGTDNjaERxWEdBL0ZsdklRSjloM1Y1QXls?=
 =?utf-8?B?MzR0T2xnMFoycjJ2VjFoWUVWd2FBQml1dnNHSU9jL3dEdmNwWmtyQWFNaGdj?=
 =?utf-8?B?b2FSZ3gvSGw1NFVFbWFCSmZqeStxL0RlZ0R2dlJoWEgyWkZkTmVnRzUxSnBm?=
 =?utf-8?B?bDNJd2pJRjdzVmd0dTA5ZUdhUEE3UU9RSE44SisrS3ZEVUpmakxzSHBWMXlD?=
 =?utf-8?B?SzBUbzdVSktmcGhaSTI4RDVYWVRWeTM4cG05Ylgzb01WQlNVTzVMbVI0dmU3?=
 =?utf-8?B?czFpbXpBN0lpcTlvU3pIamZ4N3JxRTl6ODlVbjIwNnFFdGZndEdIUFdjZlpH?=
 =?utf-8?B?N2pSamFEUkxtdEYrdElDV3VIZmkrMjMyMUlvWU1zQ2dQbUMzcWM3bFUxN3BP?=
 =?utf-8?B?aEo4Kzgwd3hvUjBYV3lKU0V1ditIZG1nSDF5b0VCSi94VzM0bTZRazVSVHJz?=
 =?utf-8?B?VjFWNTdRT0lKRk5jVk8zUG9HSC9jMEtjNUZkR2xWWjJMTTZTNTcwSUJzSVFa?=
 =?utf-8?B?UlEwL2VEQnF3aWlzQ3FSYTVlZzdkZys4bkNndEl3cGN2UmQ3STQxa2ZjcFVB?=
 =?utf-8?B?MWxqRXJrOGRlYURlREVGM3FpNG82MUM1Nll5a1Jzd3ltQTY3T3FIQ0NldTFB?=
 =?utf-8?B?YmgrNEx4Y29XdTUwVGtxaDV1czRuMWZBTjlmbUpIY3FrczJ3aHY2cmZLZjUr?=
 =?utf-8?B?Y2pCQ0dHNTd6bnZiR0NHc2k5U05ScGZjTkpLSUNRNU1HWjNOakJqZFVGMXhv?=
 =?utf-8?B?TFFjeVBvbXdsU2pCU1ovWGFZNG00b1B2bHhTVytFQlllcVRkU3hkMXp2Qmdh?=
 =?utf-8?B?a0lvNlNpSmZ4OSt0dXFOa3JJejZRVkJpOUNHaksxd1dmM1FTc1FGWG9EeXRJ?=
 =?utf-8?B?S1p4QWhkK0NGYzJOMDduaTFPN3oxQUZCSk1wWEoySEhNRDMrbEFMa2Z2SkR6?=
 =?utf-8?B?Qlg3M3RjbUJGY0JZa0NJNmNvWWdLbUppWnpKUWR4Vzh4YWZFb3BjbmIrb0J1?=
 =?utf-8?B?RlAyeU0rNEFuNWFGNVhyMWpWWTBmb3JjWG5QR0gzM3pIYjlnVDhZem9DQ0lv?=
 =?utf-8?B?ZCtpK0d4S0J6L0xjY21TaExSaGE2eWY1SlV4dXowa1dFaThMWE94bkxsTHh3?=
 =?utf-8?B?TThKNGFUVVVIc0xKQkNXc1JBZFR5c09kbzFBQURJODJFTEs5UW1HZ3RnTWlt?=
 =?utf-8?B?aTQxS1BWTEZpS0t1U1ZVNTh1QzQ5eW91c2lsV3A2MkFUcG9VMUEwZkQzajVl?=
 =?utf-8?B?MkdCbFI4WExYYjhibkgxQVdSYm5BQ1F1c2pGanJmQ1pJWmxncXlpRFZIblEz?=
 =?utf-8?B?djRuMERkZ3o0K3gzTFJHNVRVcVlrUjcrSGdKMFBiUWRRU2tjNVcwNFh2Ykxs?=
 =?utf-8?B?SE9pbGRiLzhBcWRINWxjYytJRFNJNmQyK2VGcThBdklpc3QwOHJNckhBbXMr?=
 =?utf-8?B?c3ZmSHBuZjA2Y0cveGM5VUZGQTJMK0hQaFhZYVFKanRsUVEvK0xsZ3pKSG9I?=
 =?utf-8?B?U1E5cE5FMUZWamlNTGVpb1dlODBmUXgyaDB3T1ZuSkljckg0MGIxbTRuR1Fx?=
 =?utf-8?B?RERsWE1LZS9zV1ltV2RrZ0x2QU5SMzFBanRILzNCTVo0S3hML2E5aHljUnhs?=
 =?utf-8?B?QjN4OUFjQUI2ZktlbVBvNnBRamRNMVFwcGxFb0xPQkdaQWZOc1N0SFlHUldx?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4a7720-2b7a-4e93-f088-08dc2e27ccdd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 13:12:45.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBnXiZvclLxJyuLVMkqA3hIM5pZIXsTqwLX1VIMAnFGYxQQSm6ajd4UoxKSHWWxm0Ld2D30Z+mtLMi4gPj485oWZFWHhROR5zaH4dELBrb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6727
X-OriginatorOrg: intel.com

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Thu, 15 Feb 2024 13:05:30 +0100

> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> 
>> Now that direct recycling is performed basing on pool->cpuid when set,
>> memory leaks are possible:
>>
>> 1. A pool is destroyed.
>> 2. Alloc cache is emptied (it's done only once).
>> 3. pool->cpuid is still set.
>> 4. napi_pp_put_page() does direct recycling basing on pool->cpuid.
>> 5. Now alloc cache is not empty, but it won't ever be freed.
> 
> Did you actually manage to trigger this? pool->cpuid is only set for the
> system page pool instance which is never destroyed; so this seems a very
> theoretical concern?

To both Lorenzo and Toke:

Yes, system page pools are never destroyed, but we might latter use
cpuid in non-persistent PPs. Then there will be memory leaks.
I was able to trigger this by creating bpf/test_run page_pools with the
cpuid set to test direct recycling of live frames.

> 
> I guess we could still do this in case we find other uses for setting
> the cpuid; I don't think the addition of the READ_ONCE() will have any
> measurable overhead on the common arches?

READ_ONCE() is cheap, but I thought it's worth mentioning in the
commitmsg anyway :)

> 
> -Toke
> 

Thanks,
Olek

