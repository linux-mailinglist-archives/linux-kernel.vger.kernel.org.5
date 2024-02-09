Return-Path: <linux-kernel+bounces-59923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ECB84FD5E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51ED21C21886
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147E86ADE;
	Fri,  9 Feb 2024 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsE3qc8w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2A554F86;
	Fri,  9 Feb 2024 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707509777; cv=fail; b=L0wMCErG/+hEI3UFkB0IhM15ty4zjvjh9u7af7h4RXne2nCvOK0msjtm7y/Q5YJOt7uxQowKH/KXSfqIvt5kZfiYvHD1FcrYa6kmckEOvuloXVJETC27+Ql9EG+lsYFvx3zTu2N0ONglyUOPNlohfAoy1clnAwXKWqGLL7hC09M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707509777; c=relaxed/simple;
	bh=25BkjeQGTzBbD3Q29DP7pqWDglgAMa7hl/TZUcCL7W8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SEQZA5BU2+KZ0b8EFl7Xkb/VkGMMq7JaBrTXPdDnibbmUX+7oEXMQrq045dnwY9hj9Uys+mZNjdK/FPQCANCEealkgKSYxI5SXY82b2HwnKUvSKfg7s1sIMTC+OdRvJ/k6oDmtHrKqrUs4X5bs171GVrul1imJ6X/IiZyPZfCSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsE3qc8w; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707509776; x=1739045776;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=25BkjeQGTzBbD3Q29DP7pqWDglgAMa7hl/TZUcCL7W8=;
  b=XsE3qc8wPybox0VBDXTgbWxF4kJ1OCAqqGTgNqOr15IMh1d24JdkNAZZ
   SDwkAbqWVLNncWa+4BPDSjXlaTyFsn6pl2Ce7T/yQyN+kX999U4Ong0Aw
   kx9ucm5y9G1ukvsJfLQj6oX0cIEMKb6wZp1swsjm8jmhQfg1g68FQSyTA
   yS4QqKXZst4TMypFDQteEn91+iki/LPlPIhUb4P2GaE14aqZqsbpY76Q4
   k4T/avIuD6kW6EK0RU97iiZNw/zvTa73Wfv5N18TN2cYyFAtT8Agb8lgy
   A+F/EwIGF4+lNOD0RNM5HnZmfZqFyzb5tLApX8Tq10/c9rC3BoHapNf6e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1373913"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1373913"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:16:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="33108997"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 12:16:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:16:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 12:16:15 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 12:16:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqXt23Bb0WEDcRHMFBpQIMUkP2IgismhSaAPxuF6/pdVRu0ulRSkikn7t1k3I8GLCFJi6jETTvbmidsJtPiLRvHQOhHkvJJXDYDG0dTlFmTX6awe3ihBAuR2Jz4A1P8vJN8u33loyS6mAfPI6Gszc7tlgOgQDnmNKPjMjSV+RI4VFw2MNcU+FuEvURz1V5RxJLgRCHDpP180jChLW1MSCX6h39110luchUitrSkrfu9Qfz43kqFyR2PhkHNyTrCRIAbVCF/Gw7og0NsikLnCEhuj+vDBdcRjRVrOyRzcRkphDmgVYDPwnAqvj2DVsDEDe5KtCKo1HA6mIWh4sZr09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d97wNCoR1ifq5j9xDw5+NjasW1+mZ+diT4y6Qr+6fnk=;
 b=W/Q+brtfsg8hgLjnhyGq9MEO+0uB+OCyAUozPgxHPNPaCBUR6vvPNnOachfmmoBDc0GbKs7+WeEK8uu/DajNlxybV4t9grjkpuiYLo19vnLZChkbAr/g25LYYom2nIL3pyXgXvsfkxXR5Zf1ddMwFCaCntWZMxKKAZSHDNeW7EMpyYQ4dlhoV2SCF7xFBKzuwVMfM/KoHeXwoLaGKviVkvL46XZ8RImxl3mHgiJW16qWT211r+EqfyUxEEs8AWJ2+PX67iLn5yQSCokwhvH5FIHtjvKYDG7se6qPqbZuxOAh0jVuVe7jD5IdGOLcNmIAobthbEOabJDRRyEepTwRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW3PR11MB4731.namprd11.prod.outlook.com (2603:10b6:303:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 20:16:13 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7249.038; Fri, 9 Feb 2024
 20:16:13 +0000
Message-ID: <ad674def-f129-4470-b07d-b1ed809da4eb@intel.com>
Date: Fri, 9 Feb 2024 12:16:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
To: "Naik, Avadhut" <avadnaik@amd.com>, <x86@kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:a03:80::41) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW3PR11MB4731:EE_
X-MS-Office365-Filtering-Correlation-Id: e4620b3a-4546-49a3-f9e2-08dc29abf68c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQuLllPEcjvWHf4X6dwFOiij00TajcLP4bgiMXYi8913opEeIm60Ul6BvJl9yWywMNdRRyDJv2ks4v6E2w9U37bo7vROzONIvxdd2zlj4YhkevEdwGn9nXgcrtcq19qCYj5XXAW4uruammqTtrjQQlUmG49jyTJ95h1grcHRq7G7NF3L7phgw+p9KDttf9Hi1cBOlRkvgJ1fQ4r1bMz0qqAoXYhkDyJXazSTWqM9OwhCK82FUoBhFYEKbSka1AFXdHU97Vg1N0O7Ud8CEMQpwVAh+Je1BIcz3UoL3SOloc6OD0Vg2qbyPTqsm8atbEV7f5MVeAbZCfnBBYPilj3RnUxAsMoSd76FkvHxaT+rwcu34srh69cgDIodz+sm6DuMsNjcn1hPqmYr/L0ZwkUa/xaSTXKSYVcdp6Bihdbw7oyvNxu03DHDy0ameuMQ7cnEZYrag4eZyebOw+QczO8HGt9yLhYExJqslNm3LzpoF/asBtyEbXUsip2tUQyFWDeXSDRMgDdgKNau0vR8qUs/dBSS9fox5KOxL1qsvXk9lcpFzs1kB+F92qQa4hkMV0HK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6512007)(6506007)(478600001)(53546011)(6486002)(2616005)(26005)(5660300002)(4744005)(44832011)(2906002)(66476007)(8676002)(66556008)(316002)(66946007)(8936002)(4326008)(36756003)(82960400001)(38100700002)(31696002)(86362001)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXIzZDlNb05rK3ZCNkdDN3ZML0RMZGtlam1JMXNrT3ZCU1pzbTlsL3hCOEUv?=
 =?utf-8?B?aERaMFl1WEY2akhVTnJhNFJHZms0YUtXVUFsdTRtTkt5TExMTndsNUdNWnJp?=
 =?utf-8?B?TE4vWGhYQ1Z3WmZ3eHoraUdMUGJ2VGRsNVNycHZJSjkrTExNeDkrZHp5aHc0?=
 =?utf-8?B?anU5QjkvQXR6amp5WC9DVnZBdnArcXB2NXh2N0w1amNjS3hCd1AxdzBZMDBt?=
 =?utf-8?B?b3FoeDRFeGhmNmdPd25ITVhiK1ZobHFaWmpDZWxQNGY3Z0wvc0xpMmFkMzZO?=
 =?utf-8?B?VWV0TjZoQnRsbXNiQXFOYWZ0Qk9QbjNJU24yL1BVbXRsVzNiSXU1VmUrYjhn?=
 =?utf-8?B?UlN2L0FiaUVNYkFSb2krZjlwZXR0a0FyTytRUm1zaXE5Y041K3g5bUZCQml4?=
 =?utf-8?B?L2NKZUs1TXpvcS9ZeStqTWJzV01WN1VlUkFUL2hHNUFlcTBzN3Ruam1FSCtq?=
 =?utf-8?B?eEhmN1VmU3lYQUlGbUhKdGR1S1cweDErUURjV3p0N1ZkdXhCNHJ1UCtjbFNp?=
 =?utf-8?B?bEdvYm5IMnJ2TTh4ODJITWcyV1o0K3ZmMzd2NE1tanZYNkxLNVhyN2JRU09L?=
 =?utf-8?B?ZnorWm15enh5VHdnYWJjV2pVaU1lOFZseXFxMk9XRVd3cVJQQTlob0xnK1R6?=
 =?utf-8?B?ZFlkUzVwWDdmU1I2Q0dpSWQ5UmI0ckNhN3lUYStKUld2R291WWprTjV2eGgx?=
 =?utf-8?B?M0ZhV3hEL0ZiV2VHWlVwZ3Bmdy9GTk5teGpCdHhFN0plSWw2bkxxV2VwcUxB?=
 =?utf-8?B?NUdCTFpTTnBnUngzei9PZC9kTVVoZ0JJczRSMm8zK2J3SUVqNmp2NE9xRkZ5?=
 =?utf-8?B?WW1LNXRiN0hzZTM1cWlCdDBEc21tanlUdlJrOVJTMys3bStvaWlZVStoZ3c1?=
 =?utf-8?B?U2hKWW9lSm5JWlpEb0VJRDgxOWhNdTE4b3l5b3FvOVF0V2Vud1NCMWFnWTRi?=
 =?utf-8?B?S2FhSkNNYXl2dWpXQnl2bzQ2a3R1aFg1VTBlcFRuTGF0d2orYnloc0lDSy94?=
 =?utf-8?B?ZFhyUlM5dmd0eDZMQjdmckROMy8xWERaRzRGam54d1RNN0ozSFB0YTdIbERO?=
 =?utf-8?B?c1BJcTRIOFozaFUxNmR5OGZYN3pIVGZjYTcwZm9VZmFUcnlTai9UR29ORXdJ?=
 =?utf-8?B?OFRvdlIxYnlGc2dTNEcxSkJqditTTkJpbjF5M0Z1UjJacnVZNWRncXJSNEFm?=
 =?utf-8?B?S0VCb0RKRitSKy9RZE9EMnJ1dXpkOUVFRndrUVY5OTREK1MxQiszRE1HWG5p?=
 =?utf-8?B?dy9sWEQ4ZXVPdHZOZExzTDdQeWFhOWVVU0k4aE44SjF3dSsxWTdnNThmYlRx?=
 =?utf-8?B?RG1EeXdlU2d1UDlqWm1iWUFrWlQwRGo4aXMwVExwVmxrM0o4UVd3Y0tVZjFR?=
 =?utf-8?B?TGk5WTJ6ZmkwWWpWVGo3ckJmRm9JQ3JBNTBhbFNvdWpqcHhVU1lYL3NScDIx?=
 =?utf-8?B?WVdHWU9nY1Z5UHA2NXJURFJsa0J5OWhLMWxEeExYb2xGZ2J0TmI5M2dEb1N1?=
 =?utf-8?B?aTFQbThHT0Y2c1UvYmRlUDcwYXpRMS9VQ3JxWHgyUkJPOUZkOUk5RWZoRzc4?=
 =?utf-8?B?aXZDVkYwdklHakZISnRPdXdQU3pnRGNJNjVDZ0Zuc2t3SVU3V2hFRHVOZ2h4?=
 =?utf-8?B?SGRzZGxVaFVEQjZmUkFQU1Y0cnlmZzJHSDUrMThOWlVPcHhOSjV3Q2VKZkFv?=
 =?utf-8?B?SWhzRk9zN3dnZGlnV01CSFZ0eWwwTVNHbFIzTlIyTVVBSjZzcEgxd3Z5S1pm?=
 =?utf-8?B?eHNRQ0NBY3pacTQzR21lRmU4Zi93dG96dWFhVUh3YjZ4UEsweG9xRFI1TFNY?=
 =?utf-8?B?SFBoRjJqa2RyQWttM3p6NHlqMkpzd2hwbzlqRzc4UzB5K1R3Slh3eGw0MXBr?=
 =?utf-8?B?TGRsS1kza1R3QVJkaU1rMlEwOVU4WDZtVzV2ZlluRUxrektQRGpMWHBOVTlN?=
 =?utf-8?B?YXdwdzJJeFRFR0UwTVIvV0xCVEZ6bWIzYkxPb09OaVVmY2x4QzBPTGRWcXZW?=
 =?utf-8?B?NHlKT2I3b053ckcrenRnSjZuR2cwdkZpUFo4dGRCUUVubDdTY2U4Q2xNY2U4?=
 =?utf-8?B?RTJlaXFFemNKcnJMN05GTk5HQ3Y0eU1uUDl2REFnYW5teWEwWUZ2UGRvRzBY?=
 =?utf-8?Q?LXnpEjG2VIXNno6jz/wjQSnmN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4620b3a-4546-49a3-f9e2-08dc29abf68c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 20:16:13.3432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyuSR7Sd7A9J2lwAl7ks8cjV2aFQBdiBAAjHXup/x7h5LhVzjEJx5xauVufNMYQI5A8ibDy0JjCGdZ8K8DAZGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4731
X-OriginatorOrg: intel.com

On 2/9/2024 12:02 PM, Naik, Avadhut wrote:

> Is it safe to assume that users will always want to increase the size of the
> pool and not decrease it?
> 
> IMO, the command-line option provides flexibility for users to choose the size of
> MCE Records pool in case, they don't agree with the CPU count logic. Just added it
> to ensure that we are not enforcing this increased memory footprint across the board.
> 
> Would you agree?
> 

Not really. Providing this level of configuration seems excessive and
unnecessary.

To me, it seems that we are over-compensating with the calculations in
the previous patch and then providing a mechanism to correct it here and
putting this burden on the user.

How about being more conservative with the allocations in the previous
patch so that we don't need to introduce this additional mechanism right
now? Later, if there is really a need for some specific usage, the patch
can be re-submitted then with the supporting data.

Sohil



