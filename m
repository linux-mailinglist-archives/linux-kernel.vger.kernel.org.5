Return-Path: <linux-kernel+bounces-3462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB7816CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C97284795
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743C0374DF;
	Mon, 18 Dec 2023 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B39i7dvX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A4C374E8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702899526; x=1734435526;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sjAWKi7fK2qfry6Lixv8JgWbkIAjSXmP9QZ5ovdY71s=;
  b=B39i7dvX0tEaQ2FWQsW0naYDEOHSb/k3N0XVvHwgJgNHWVJMMq3lWTbt
   xqv2w5L3VXmvVVFv99dkeCe1ILltzoym9bsVkLmFoFYjnNBO7lPubXjJo
   o17A1/cdQ4KROjSYsTgIuPdnidVAtVLk2b6inpQdsc+UMVJKGd0N4XkHh
   ZNC9bsK/feOSPntopYIh/Qx6VbO8TskN2VUyS3G4Qm+ZcW1CtoG6PtXgL
   XywTwwAKeX6f/ZiKZow8u3ntdzQvMwWGXDa8RbdUAwfmpJYIyeJw6Gsfg
   8HPFGSs0hGNyDuSDYzvEY6AACTFhB0ajNA20D8r1FRomrxlCSJf6noWMV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2320686"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="2320686"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:38:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="804498142"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="804498142"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 03:38:45 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 03:38:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 03:38:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 03:38:43 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 03:38:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTLJo1wySKcOafcFgoidsIdo4i6NOozGJJxEIJLf2TFTOsUO+emsWwlnlGVhm9kIs11KBF5kjSqxTkz7S7mWk6DHic0FJKc5lKQ+2mruAz1QHRjpt4WORQzbITQMUOwOQ6J3A6icITwi2adxjBBQpB31M8ht1ZnCw7MinIZCDSbU/LfBv0/DAsUyLvJkIvL+7Ar2zNfjhyBjhe4KbyJbymjiyNUuTFek1HOQn45wfuML87ppGgm2EguYBE3QkMneC9N3llAaSJCl/vtdp3CoVOgkF2C6N1Gmq/IWCoRTbzfurN2W1QVlQCRUfM2ZJm0eefwy3nGsssptMdUu69WK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fbsNaB2peVvloJ9ZWxrBxD6sTbiCXxZeEV19bOwRmw=;
 b=P5Rd+WVNOQuQSnvEp9/BjPrlpMkzTH399E5iPFy8/V9taNfmmaemxV/w3HL3Khp8xdAsuN3OHJdHsYS9iP9PoEl1ocnjnbQlZnsiXyV32bfKIgBdbpSBzd1L5jB8GcKjRygFe9KDSbIc2p5Y1i55Uszj8IzXprZkowM30e/jQqtJNI9PuhpsowwfvQ2r7R2xd/KN+TGMF0gtKiKUsqbAYqOjcwkBsfeuIOqOB+wPkmokVNSyeNFG9NTBUmUczZIQdHmaEu7cVmrOKvu4SUE+TT3xb/icpuLag4xwVgV+B7T2VqnOj2XvL+kMpwgfpDP9RTR5rmvbe1YQD0iuhOgxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BY1PR11MB8079.namprd11.prod.outlook.com (2603:10b6:a03:52e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 11:38:41 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 11:38:41 +0000
Message-ID: <e480472d-73b1-4273-8943-d1391a861936@intel.com>
Date: Mon, 18 Dec 2023 17:08:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/usercopy: fix kernel-doc function param name
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
References: <20231216195004.29040-1-rdunlap@infradead.org>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20231216195004.29040-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::29) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|BY1PR11MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e12dac8-a387-4326-3503-08dbffbde1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6COOXhzo0PcvTkdmOGWZMbGR+3C6pBjVsNLH51cv5xTCO3oTQFl90yjIh+gcEwcYSQ0LZjqgHR6ZiDbbXvEp8Px/R+IuQnraDCBlAn0z6XX7UsL+VjlsAGCN7xf090nL8dTps0q3uK/y4+2wKNSVcjEmNkn2VgTfboQNeyCdtjHVcOINgjMNvDeYmsCC03f51M3GNuWbm11yrJemc+6GTx2mLjPk42l/uGmIDKMTu99WoUBEjwyBjrnx2JD56tt/wKYsDl0MgpAvC87TNoYZ0yYtEVkqQycqUNut33xd+hrPHlju85dLYZ2mxwU/uho17ZjuienpiTNPEchTjMuwV+mlNRWYZZRcUcP9ZLLiUp4Kxpp3i3q0sYGbnZX3R4ijqTah8RI5FugCylXzEmfIJ7k1M0qEBOm6rnV0+Hd93MgLua/V9EjfzjhenFEdHNDo6QnPD/tG0G14gG14/unoQXGbLEEUegqr8wueZt3w31CX36R46SbGNFdjdAOcZYxG3kGlg9b700jWgV3K7GBFzwz4W1GqLV65lROroC1cHtgWsf2etgy9wSIEfE0jzqIKB/1DUl0p9W5YzpSy876Y+mLnGV6ny767Wj6vMnam5qv3fGHzIOiYbDKLiewEpJMOjtH4hxt7hDhUoa1VTG1VfjDTwX0Qa6meEupj2fLIW1SS/qyBBE3WsO1sUP3Z/M5U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(82960400001)(5660300002)(2906002)(38100700002)(36756003)(41300700001)(86362001)(31696002)(316002)(4744005)(6506007)(53546011)(4326008)(8676002)(8936002)(6512007)(6666004)(66556008)(66946007)(54906003)(66476007)(83380400001)(31686004)(26005)(478600001)(44832011)(6486002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVdTdE9UTnpSU1g5L2p5ekFJWklMbFFUdkxuRnFmUUM2N29RanVabzRKeUM5?=
 =?utf-8?B?YXN2WGk0WExkVEdSeWdXbmxvbWE2bUYvYXZXU1BXZzNmTzF1dkdjVXB5Nk94?=
 =?utf-8?B?YzF0U1I1S2Z1TjdVaE0vR2YrZERPNUVxTVZ4bVdxWi80UFFYdGZvekxiMDF5?=
 =?utf-8?B?UDkwVlBVcUhGdmNqSDgzMFV6dEtjQU55UitFN2RlblBXbUh1MTJBWWFtUjcz?=
 =?utf-8?B?MzNSV3lCUVdMb1JpVXRCZk5DQzlBVDZJOHlrakd5cjhSQ3FMRjVaUDFHMXd2?=
 =?utf-8?B?am5ST3J0N0NHbDEvbFU1WHZwSFRmU3B3bzF0VHlwNUpJTmVKQTJJS1hQNnI1?=
 =?utf-8?B?WnF0cDhNck9aVENKdDdzKzJrWnEvelVITmI2cWhHRHV3RFlYWGZpUTRyczRO?=
 =?utf-8?B?SW1LeFdkU1hjRUd5ZFU4V1FxTTFiaGtwUndDSENuSTZGTzJCblJDRG1lRzRv?=
 =?utf-8?B?b09Tcm5XbWQvK0hGZnlPNEZZOStDMUh0WDdRVWpab3lYaDN6Vm5QdkdZNVd2?=
 =?utf-8?B?V2JTRUxpdmtCdi81WENXUkUyS0tNT0tteWRWL2J2bGdFbU1GVXlZb2E5M2sv?=
 =?utf-8?B?aFpLOUpld25jYngwUmNBMGgwRE5mREdsTGtJZ2V4UWlGcldzUDlDZHR2S0JR?=
 =?utf-8?B?eGlKeVdOSU0vQVpUSnFka2FqSDhjNGorRTZMeThZOEIxRnU5QW5TN1hIRWVZ?=
 =?utf-8?B?b3NCaUVHeHhlQmkxWVcyTXZpbm1iNDJBSlk0NHdxZHZPNjY2YXkwS3VxYkdh?=
 =?utf-8?B?bHVOZGtqOGRVWWkzZkc4TDBCR3dEdjN3VDVxYmJVQUhydUIwZ3JZNmpSQ3R2?=
 =?utf-8?B?SHNNRWhFOTZjclNpa3pteVNaUGFPbmlLcnZaTFUrajROWjhRMkZraWZXZjN6?=
 =?utf-8?B?emlBbnNmMktQQVdWMFVtYVZKY2U0d01aNnczc2RWZ2g0VUhLUU9NRk1qd2Rq?=
 =?utf-8?B?T1Y4ZFNWS2FGZXI0aElSd2EwMGVjRjRDeTRHZzRwdDFBUEFwRVdvVU1NS3VF?=
 =?utf-8?B?VWdqcTlWa2NwdG0vMTBQL3NwMzRYN0hhdEZZdVA2S1F4L1ZlSlJ2QnhtSmY3?=
 =?utf-8?B?dElnN0pVODh2VTgxRExQcXV6V2IyTTl5aEplUnRVZXNvS2NOOE9FWkFBZWQr?=
 =?utf-8?B?TDVVcE9SeUd4TDZzWWNRd1ZEcDVxaGZXaUtvbW5TR0ZoSjl2Zmt5Rjc5UGZk?=
 =?utf-8?B?aE5DdTJXaFZnL3AxMXNqZU8xZmd4bGtlZlFkSG8zWklnTnFjakNpVWJwZzZs?=
 =?utf-8?B?QmRQUjVKeXQ5LzU0b3Z4Y1dHRVk3emJ3UFpiUFdIckU4OVdST3JXVFo2SjBB?=
 =?utf-8?B?T2lJYjZucVBnOGNmQU5QRWR1RkFVRTd5ZVRXUVMwWU5VNllGREhVSklYaGsy?=
 =?utf-8?B?WHoxYzNwenhod3RDWHZhQm9ZYnFTaXFIRjFDS2NVS2xpb1E3NlR5S0J3dkFh?=
 =?utf-8?B?RG05ZHRRS2g5amJxTUIvMWl1dGhTZGl2RUZ6clp6NjYxaGdScjFwQU9TdWx3?=
 =?utf-8?B?aVpBT1RJZXpsQ09QV240WGFIR1BhUnYydWhXR2tmb0hwS1ZGTWNuUzA0eVNs?=
 =?utf-8?B?eU1JMVhZemF1c2FyVkU0RmZyZFd2WGxOZlhxOEw3OGxUMnpoRVlWeXdNazRV?=
 =?utf-8?B?MDF0L2ZldmdyZHJNNlFyTFNaZzhTdWNhQ3lBU3ZWK1VFTnhPSFRxblN3d3E2?=
 =?utf-8?B?SmRSTjM3U0pGTmZJYjgyamU3emMvVUNlUG9VNFp1aWJzZjFxOGk1RUxhSnZ5?=
 =?utf-8?B?eUcyV08vaGIwZnZ6YVJGSERKSFhNM0ZVdm9UMENzZU1nTlNUbHZGYStNT3cy?=
 =?utf-8?B?ZE5kVTJBdnZ6Vm1XUW9tNWVSL21sSVU3V2UwSFY0Tmt4YlhqdE55NmhrbDNB?=
 =?utf-8?B?R05kR0hUK0FLMENsMEJSZ01zZ1Vxd1lQMzJXbkVkNnp2MVhQT0EwYWZGQmsz?=
 =?utf-8?B?SUlIcDBadFFXY1VuR09oMGJ4blZiTXVsWGloTEluVGx2MGFDd2JWVzFzV3kw?=
 =?utf-8?B?V0djRkd5TUZBeUZVUGoydEh1NmlENWZZenJTUGF6bXFiUy9xbjVOOXljK0JS?=
 =?utf-8?B?cjJDZk8zcWoxdjFJb0VaMjFMZHQ1YU9JQmFxdzZZTkVRNDZxSzdRSExRLzRV?=
 =?utf-8?Q?W6NKW0y4CR514VmCyzp/xmr2C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e12dac8-a387-4326-3503-08dbffbde1c3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 11:38:41.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myvzryW7jA2hozCI8Vs7gx7aBCzhps9+2OaHC6oO+BaMq1pBR44Cjpf9MbLIdUBWnxDbbxNnqrgfCW9DK3lkhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8079
X-OriginatorOrg: intel.com

On 12/17/2023 1:20 AM, Randy Dunlap wrote:
> Correct the function parameter name in clean_cache_range() to prevent
> kernel-doc warnings:
> 
> usercopy_64.c:29: warning: Function parameter or member 'addr' not described in 'clean_cache_range'
> usercopy_64.c:29: warning: Excess function parameter 'vaddr' description in 'clean_cache_range'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/lib/usercopy_64.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

