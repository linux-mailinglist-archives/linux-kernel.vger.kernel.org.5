Return-Path: <linux-kernel+bounces-2083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D40E781579F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7101F25D97
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D9810A3D;
	Sat, 16 Dec 2023 05:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ek7l/DUw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1329510A00
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702702958; x=1734238958;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZeekOitKk+vBiN1LSex1a7mQtQXgeMy8eUjmsCPmYBQ=;
  b=ek7l/DUwaiU9QVfm9TGl0JSQeyNwpo39+ntD3VNVtNkaFqCYlmrS+yrM
   oHF7HPuT3O9/xoQUAj6IVmRcU8iS+urniE/rX3GhOaTFbJAwJ58P4wiCC
   +2+Qe+whdaqseIEKTmwxbFOtDlblJmDWBNLnkLSS5Oymqy6OWKYTMJ0uj
   5fW1nXKDV2zvqZyaYiLf0zYxnKngCIjFqcnA3y9RGLu6v9kLF931ibWwS
   S/vUiB5ANcwBSSvKsyuMuE09K5rNGG1z9bs6QKZ+rpVSTG9MkIFUOz67y
   18iOY6MOAmoLOTht3VcR07LheZHUzSeAvP/9nUzGTJNT/U864hIp7+IZF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2183200"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="2183200"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 21:02:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="23076481"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 21:02:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 21:02:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 21:02:25 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 21:02:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqZvIzQB1utu571ESV37rX+ykumuC0miQ7IpVaxpjTqB8Rlt4pNBdM1G2dwSW/Voi90DJJZbs9raNJTDc5fzz3YOM0+Whiv9LIVc6KGCV+VoyRW5qtoh+gKqUE2fN0biFePzA/BSkoaXSLhTccc3U/DgKadvs9tF4TvjuG87+WrMBP3lqFxflsExXCeRkflK4keEBplaCJ/Rq/wZTo4z1utK7YEm+eZbBfrGcNw8oWYdMoQ0r5jSyJkVyMZM47YaPGlQTsnnMgeB92arL9yJxZaYvpzF1NefDdbtNiKIJtcDJHcZKYjQj1GDIr2jDqAUCdh1otwvQNwy8B2UKJgg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1VHs/u/etX4lD7i+EY+mc+iOWKQfJ5UpD7hXHv6UqI=;
 b=VH6Snp8Tvyxm2bIJT7ZnnQyzNo3HQ5qycYo716bfRVs9pEmLumE8Wr46uQh543PTLE8r04JXugdR+KuoqBi0S8sSY8nHp1iE7cYaP1r1ziu5DznWImU5ybDEs0wl9bXo3GUyHMf0U61DJOGLTlgfDs6iEbOEMG2QJ4T0hBwrayds0ckU7xZMXIMr4ZWWadwUtgMuAyt6sMiW68ih/Kl5Ko5Xtz1xTA9OicyUpeAQaICdqb78K/aTAe7Mg9bbySsQ0NZoibEG6HcpydmEosBIyDvA5UCcjQ7pjkzeNR9WOYG2BxF+J1NlDtiIyHhBzD4aiN4UpcNMJQ/gJYr4l/dJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5775.namprd11.prod.outlook.com (2603:10b6:303:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Sat, 16 Dec
 2023 05:02:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Sat, 16 Dec 2023
 05:02:02 +0000
Message-ID: <1516e4ad-b0c6-4c03-922a-5b14522c8d0a@intel.com>
Date: Fri, 15 Dec 2023 21:02:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 21/24] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
Content-Language: en-US
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-22-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231215174343.13872-22-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:303:b5::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ad0b24-ff93-4151-fb9e-08dbfdf42434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaAwtz9DZkeOiYbS3R4FEAq8SfcRThquiXqjH2qQWIhmdmCMUnhj3/0MwFg4P6sXw8z6Bqmz39DnjVCPj5DqSc0vR3vlclGwgBjctViu1Xe7BKTLqbpURxZZ1yJXI5JTzcBDerolUTYoJ6adPLbtxNxIhKTbT60rKnoxaWUD4BKyEEgaT2kfDeKaQv5qrP8pP8cCunwQc13l8yna+9A6TbkrlVMviIPQysiGsKUagPbI87BKGkUrn9MmK8iYLNurojGjysSJ2JDlFK2F29ngSkQxbdZw/nsmonfnsn/tz732G9i4icf9ApolN4mVW+q8Hj4wLupDzfi/DIgYgM2xHJnqBuWnWC6Ht8sGF4/kJ21oxy0jRLsPCyWq4enYg9WeOLvr1wz82e3+CvGATZOegDZzo/Actj8a9NTyurBSzGoEyqMF3htdmlwpEnObpql8L8D3z69tQNVD3KmFsKs504b0yKLpMTAUu2mGCRRLUxnJk38cdQYJKszoiRYCnygDwa4OCeD5l3BvVO/eBYLkQrmMtBV97qLgeC1Bmi/RwcV016yMH6oB0IJM5N9bgYBa0fFu+/IzFsbM3Sw7rTs+6OZDlrpzo+Tux0clT0d2z0KSN5eggweaHoy4l7mYC0OLNWOM88vO46SCg3GYMRA3Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(26005)(6506007)(2616005)(82960400001)(86362001)(36756003)(31696002)(38100700002)(5660300002)(4326008)(44832011)(7416002)(6512007)(53546011)(54906003)(316002)(66946007)(8676002)(8936002)(6486002)(66556008)(66476007)(41300700001)(4744005)(2906002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THcwak5BMWJzdmVFVml1QVBzVGhKZ09KVGJ5UUNhdFBKZWYwNkRJSEd0LzFi?=
 =?utf-8?B?WmJRWHdqelZmVjBZMzFvSUZyZjBkbFd5VmNZL0ZzTmNCd1hZRG54dFBEaGhp?=
 =?utf-8?B?c0tRcFRrZ1VKK09GSUkwTkVBUnp4Qys5T2xsdTJLOU9iN1lNOHE4YUhCdG4y?=
 =?utf-8?B?UTNURE03VXpCd2ZTQkhoL3dGdC9xTXloVU5INnVuOXZJQmZqcllLM3FUa0RD?=
 =?utf-8?B?SkJEMytscklYb3NqQVBjRHVBcGZJVkh3UFpmUGp3enhNZEVtWjdMUjB2ekZ6?=
 =?utf-8?B?ZVZ6SkpxNlRWb0JqZ0FpUGxKQjFRUXlrS1YwZG1wd0lYTzllYWQvYlRWa2kx?=
 =?utf-8?B?TlFsT3JsRkx4RXc1UnJ4dXhKaUxjVUg4NGp2SlRsV1B0YU82Zm9zSmZBbzc0?=
 =?utf-8?B?bFJJaUZUSHJmRGNoV1EyaVhYRUZ1MFp1b1pRd3FDeXNLbkx0TEphYVByNFVP?=
 =?utf-8?B?ZkFra1Q2VW90Z0ZlT1ZTdmRYYVBTZk9xUU1QNmxFMEJpWjVVR3RFYjcwN0Jk?=
 =?utf-8?B?dERBSFJyKzMyaXU5Q0pHNVdlNEt3RmNmV21UR0JxQk1OamxNVElWdVlEY1Bw?=
 =?utf-8?B?R09POXhONEVWRkx5QjlpYnBHY1JzSGx3dFFjWGZLZGRqVlQ3Q2NjVG82UUcy?=
 =?utf-8?B?elU5eXVLSnFNTS80dWd6aVZvYVhINjI3WUZVUC9pcUk4WmVENERNelFVc0pL?=
 =?utf-8?B?d1RjOGNkZ0xrWVZlYVFpWVVFU2hvZ0VqTG1zZ3VCWmtxWGtxNk50SEFMb1BP?=
 =?utf-8?B?bXFuTHdGUjE5SDJSSHUxaEhYbTJPUDZiMFhxSWFUYkVvd2ozaUw3VXdEVU94?=
 =?utf-8?B?SXBuRGgyRTA1dTdFdDRwZ29MV2xKTVNYNzcrd2pJSkhHQk5mQVdMOEZIQWY1?=
 =?utf-8?B?YitHWXE2cjgyTzdqejdQUkF3KzlnM1F3aWJZQ0lvZ3pVUnZ5NU41MU1iMURD?=
 =?utf-8?B?aGlocWo5bnU1OENIWXNIVStnVXl4RGtxQWcvWTVkbVpxQzdKOTI5bzdOcis5?=
 =?utf-8?B?MHQwenNtY3doUEFSOXZwQkhPblBVUEtOek1zYjdocmpBUU02RnlpLzJIK1lq?=
 =?utf-8?B?REFPcThrNHR3MkUyeDRQM1lvVk5WMjdmYVZsTnRiOFVLMzRuOC9MUmY3YWJo?=
 =?utf-8?B?RTdxUE9ESmg3M2czM1duVFk3bGZNOSsxSWpqODhSL2JaQ2JHQ2N4T3RvclM5?=
 =?utf-8?B?VXIxdzBEVkRVRUtEUS9QMkZTM3NseVZyRlRXSXpYaXd0VHNvYWloWGxlYlZh?=
 =?utf-8?B?RCtBRUR3dDdnOVJGNXRXMWxYV1cvcXdrVzU0cXAvbWxHaUhMVGo5d1RLMnBk?=
 =?utf-8?B?d2dEMmVCRXBHdUpoNHgrSm5Ba21YWVMrc1NGOGJKbXZVWU5BZ1hlR3VLeDNr?=
 =?utf-8?B?SXFiOEtTMTMvU1hFRGN3T2xpRWx1M1krR1BaUE9Zek42OUpmVDNDQVdnZzM3?=
 =?utf-8?B?cEdYZHA4ZDU2SW9CL2RXTjNHVmJoeDRmWTQyOXpqaFdpa2hJSCswLzZZVElP?=
 =?utf-8?B?SFdhVGhhWmdnbFY1bTRWTnhCVzRWc1hieEltcmEyS1F4SEo0a1lVdEx4dERS?=
 =?utf-8?B?ajdmRzh3MXpTZTVqckZXM1hJb2w4THRRb0lGMWlvaEVUbzZkQ1owVk9jOHlj?=
 =?utf-8?B?YnJEZEhtcU83U2xsdmx3R1dIQjhBOThOUDNwcHBjM3dmdS8rOXdHWWwzTjZ6?=
 =?utf-8?B?QjRCUmhiRFp1QXIrcHRCNEJZNldZOWkxZmdjTDlBWXNlQzk4MmVEVitlMWtr?=
 =?utf-8?B?SHZIc2hXdGFQRUdKN2RqR25ueC9ROTg2c0hPdWxTNG9oaGc4S3pCcjhiTVdZ?=
 =?utf-8?B?dHVTcTdCc3EyeFk0SmxGZVc2blkyQURrZnBRdUk1YXBxLzlLVzFoVHZ0elll?=
 =?utf-8?B?VXJqNldEUXJzUUtibWRnOG03eGhNbi9mQzRwV1pIQlF0WldzRGZoaWxIR1hV?=
 =?utf-8?B?N2RNZnpIZmxrY2M3SllvYmwxVVRjd0xXWTlWVStqdkQ1TzhaQ0hNeGRtSHVZ?=
 =?utf-8?B?ajBZcFd0eVJxRzk4WG5hSVRpSm5aTjdzNGc3dmxCRVVoZ2h6Vnp5TzRNdTFv?=
 =?utf-8?B?cjNVN1gxUTFxeTh0bXZhSWlZSmtnNnM2dGI1MGRTaWVSNGxLZFlzQlN0S1pt?=
 =?utf-8?B?M0NCWWJuL3JYZnV2WC9YS0poejhzSFBGU0xjSzJlZUNQMEZYbHNvNi9JYWNR?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ad0b24-ff93-4151-fb9e-08dbfdf42434
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 05:02:02.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: es8u75eFDsQgy9+fnhGogOfbhK3BVZiHoChcoft4Eflt4ox1jA7FWvr9MmNgbmXahX6z53bd+9TvxluoQkcKer+IbCRgOfUC8UW13Fo5dQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5775
X-OriginatorOrg: intel.com

Hi James,

On 12/15/2023 9:43 AM, James Morse wrote:
> When a CPU is taken offline resctrl may need to move the overflow or
> limbo handlers to run on a different CPU.
> 
> Once the offline callbacks have been split, cqm_setup_limbo_handler()
> will be called while the CPU that is going offline is still present
> in the cpu_mask.
> 
> Pass the CPU to exclude to cqm_setup_limbo_handler() and
> mbm_setup_overflow_handler(). These functions can use a variant of
> cpumask_any_but() when selecting the CPU. -1 is used to indicate no CPUs
> need excluding.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

