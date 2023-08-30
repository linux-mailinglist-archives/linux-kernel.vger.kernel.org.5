Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F0E78E148
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbjH3VQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbjH3VQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:16:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD81E48;
        Wed, 30 Aug 2023 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693430129; x=1724966129;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ljB4VrdDUzAsZQ/wdHvEk+4wRv0rXBog5345PxIFVoQ=;
  b=mQMHHIpl3UhCgFNbo9SJKOG5irF8y+sZ5nD+8kCXmnX/bVcgxJjOgsED
   xDb3MjGAWGZTOgaz6pIEDNlsAel61dnW0vp/iXEZUy2nmgenWTLfE+5vu
   0Dm2EPYiUsbIU/sIcvkctLK1hBeFzVLO8CJzDjXrgTW3jlF/Z+jWq8wE9
   nnYK+atgdy9ejStDm6M5ycGPs4tb6XuvNy4YZ845Tj6uSGIwXOfDmx0Oy
   KHJMYoEm2//irLw0jy7M3f5PHZDsJ/KoBjtmUZHJmB3jqlpuPmTISBWyh
   n1cBjoBuXV35P4ndwkCvYQVZMmjL4+wxcxq7ha3rx0zf6cvmazpSvsRqa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="375702043"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="375702043"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 14:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="689052959"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="689052959"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2023 14:13:16 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 14:13:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 14:13:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 14:13:14 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 14:13:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsXqYF+F8+Z0XhN0kcyWEzNt4KMtrR32fKE1DyxM61sYOAnnFaBS67Buu0Tf8lq5A758BDnYQO8RCRz9/OGZ6V14HxM0wzC/8A4ShlIRuY3SD9l8EqBmQrItTd6Ty2tx73kUXtsTkzVCVJFdWyM1hu9t8Rgj0TF/GlNYtYP9SHS8JGuXEqJseIioBjyi6wh4PlmDJJ5ffiYY764XQbXc1UWc7yPEs2gdsUULSKXWeg3T/Dd1JjpZ64Qhbp7T4ylAtqouIHght0DrXCYLrxVYbsuniMiGppOEf26InKM6k4mw968P99Jknd6l/xadygYDEWsFpl5FYqtlGBCcXeL5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiVHc5cNSgnl9ZFSJ0zuO8XcUAFY3PiQh4wHm36+w4c=;
 b=XeqV3hiP+9thEH87rGnP2Dj9Q9m28t5eXvz3XHS8DE9M3FwacZNgK/w1FWpXs//DFSzODoaLJglXk6IQUMN6ZEh8Hosn+OJYHLMU1YAq2jMb9ZvaRWhE0cOsgpfoqXyFFgD+pclcwSPGQJG0Vo85DSXGKTXFxRz+Yhy4K5U2LLwJ4AoruzgN1QzuVArCKCst2PzbZ9QUoAHCgjUxnoLmeKVLw2bwcFCQzT41C4oQVzMRS+Ina0t6AS1/Vt837rkL2T3Pk/jDgY3J3+LtVuHoxmR+kRRyHOkabY7YSyThQ0PgOLKQQB92BJDXi8qH5bgdHVf7l5maA19jBWks6aiPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 21:13:11 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 21:13:11 +0000
Message-ID: <9706e50d-18fa-3360-ff79-d7e02587ac54@intel.com>
Date:   Wed, 30 Aug 2023 14:13:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH RFC v2 04/18] cxl/region: Add Dynamic Capacity decoder and
 region modes
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-4-f740c47e7916@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-4-f740c47e7916@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::17) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA0PR11MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 175154f4-fe95-41f4-c992-08dba99dea61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ew5xK2PzqYlhvKmSvmr3mgqQx/XAyKDN6To3+21+E3aNo26rcbvjLGQsRYGuA3NyvcTPdpiKI8m9Rz/Rxt83tl565XPJK89llHBaVfSQQgqipfyRWcE71G14YeDy2o0hHjug/jrlYkoELPpbXOHXiG4YTt5COjGEyvjrOLQS2aUduzILF6AHsDACcm+qLua13smY7R+ax5Z6u9WS7o/GY0lnUckSLH+qXi3MkPmmVtrVrBvyYb+7bSMpHi7PFQFboLhKBEVCvAaobP+S4lFG/y6rZ9a/rMr2tFG7v8tdMQdmnQA81ODha5Lr7v4/dOp7036+iGi3OYM0LbFcgKvyjHUN5pOn7gA+fvlGPp9uvYxZjXJPp1BoVqF/NUmsXNc7vBJxCUBSKzIb/LtdUpxsud4x3/yY1hA0rPISM0GBdvq/OF05bQU3/uGijTPMwka1osRgDEXID9fAxeS9NSn5ladNdNExwn+YnOTtEz5Eld3xfUkK8sOChkG2j1YkEYA6ASW6mFM9dzreW+LxrpUek6kykBFRwhR/yX948IP59hR90owJpWOXQwqpI9qi70hya4B2KMwQUPTWs7H/DgreJ57NiCUrgbTgeZkirm0IlVn2CHSTZAe7QIpK6uCdUryAAXistK3VvMLKQLsQoovdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(376002)(366004)(186009)(451199024)(1800799009)(36756003)(31686004)(4326008)(53546011)(44832011)(41300700001)(31696002)(86362001)(5660300002)(8936002)(8676002)(26005)(6506007)(6666004)(6486002)(2616005)(6512007)(110136005)(478600001)(38100700002)(6636002)(66946007)(66556008)(66476007)(54906003)(82960400001)(316002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFRGV2tQQU1kSER5K2NEREFaQm1ETmRHS1RCY2tUYTZ2YVE4eFJEY1ExS2gr?=
 =?utf-8?B?clRoWHZUd2I4cktZczQxVDVzZEVmYTZ1SEp0L2NOS2dpS1phNkFqOVRQYlg2?=
 =?utf-8?B?K2pMYnMrVXFJc3M3MUJPUzM3VmdSQmxMaC9rVUczMk9LK3JUeThhaUk1VEtv?=
 =?utf-8?B?NWhuRUdvVTYwdmRYWlYvUGlVcHF4ZU9qWmVIVzdVWnZVSEhKNmFRejBraHdU?=
 =?utf-8?B?Y0c0WXJpMFJPSHRneFlTR1Y3V2ZsMVVxc3BQR0JrejE0d3Q5Qm9mK3dVQTho?=
 =?utf-8?B?aWRubmUwNkIxcHloRjRMNE56aEMxUnN4bHNLT3RESkNyTjVLRllFbnRrNVJC?=
 =?utf-8?B?L2x4ekNHVld3OE1hSmhRQkFiQzhwbXN2N1czTTVqM21YLzJORmRCU0kwVG9i?=
 =?utf-8?B?UlNuSU1BS3RLYSs2V0VmVGc3bHBUYlVqcHFhZGpSQTRaYms1ZVZKWE52d0xa?=
 =?utf-8?B?NTV1SjdBV1ozUG5pcG1kMEZvZEZEOUxSUDlGYkQwS2lOek9iZkl5bTNENzh3?=
 =?utf-8?B?dHBmZjQ5d1RGcDV6SXNJSlhpK0NFMnlzZ1R2bFBEeWdFOTlyVHFjN1NDMGQy?=
 =?utf-8?B?cHd1NHNIREYyVUJuRERJUm1XS25IUEhZZVE2RlVEaUlyTlVUMGVxbmg0N3l3?=
 =?utf-8?B?eXV3UlJGU3k4RlE1S0hjQ2NEZmxVWEpZNyt2QThaSG82bTVmZ3ptODN0aXQ3?=
 =?utf-8?B?NjBZaDRVS2hldUpRTTlSbVRPSFRtQWlyVkZremhtU0hJQ0JTT0VEc3I4VWFX?=
 =?utf-8?B?bThUQXVwMjA0djdqV1M5VHArc3k4OUxmWTNaWmVxR3NEVE5ReEJTZWZOUklR?=
 =?utf-8?B?QXR1c2MzR1puRFExWmM4WU9GUUhZM1VQbjV4Rjc2TzJEVVh2U0t5R0kyb2Zx?=
 =?utf-8?B?dkRiNjdvR0xibWpDRTFRZGVkTzhoZmRzWDBvVTFTVmNZZ2NIdHN5SGtkbCtR?=
 =?utf-8?B?UkxQbWJmMGhPR0VvMlJhdXU5RlNQWFhNdzJ6eEhqRndEYmpPUVpPOTZmQlhV?=
 =?utf-8?B?ODFNZUdUZ1hNMzN2eHoveW1nUGNYRU8zZWhvUFZBVDhEVkt6VWNhVHhKTVV3?=
 =?utf-8?B?Y3AvK2p5TEh1dWpjVDNYb2NoRlNydTY3MEIzTHU5bFZPZWlXY0MwZFhaRFhn?=
 =?utf-8?B?MWs1L014cmtMdFg4REdsbFJSbml1VVpvSERBMGpWZDFRMmgrSjhNQXhmaUZu?=
 =?utf-8?B?MjF3c2J3UXpCKzZuVjUrd3M0dEttUHJjektsQ3JLTDdPY2VHanhJVHFZMDJB?=
 =?utf-8?B?UnIrNGk1QjMvZUNkcVVzRzBUZm9lc3loamFJVzIxUzV6b3h4MVJ1MW9kSjFa?=
 =?utf-8?B?aXU3cHczbEZnTk5haEJXYVVuZ3BNTVYxYUwremlhWUxGK3NXZktPb3VMalBz?=
 =?utf-8?B?UFNGZTJWcmYvd2dzeUowUEtKNkRFTlp3T0FDc2cxckRmZzh4YmJUZ0VDM2VD?=
 =?utf-8?B?alF5MXZlY3BxRE9Xa0N0NTlDekxhYkdGTjRJWDI0cElMTUJIbUZ5VEVMNFFx?=
 =?utf-8?B?VEhoUDUwZTZTK2xsb2ZBR2czMEE5d20yNWJjaFVnSnhwTlFabUgwZXBId1A5?=
 =?utf-8?B?Vjk2cUs0MVVQdU5HSENLaWkyZFdNODAwSzZLaHpwTW5reFYwRjRlb0krdEVn?=
 =?utf-8?B?R1h0NnR1bEh2bTIwNDBRZnUvV2FvSEN0KysybWdLZ3dpMVhEQjRpYVh3N3ht?=
 =?utf-8?B?Vi9kK1R1U01icXdob21XdkpiUVFMaHc4ODVDclVYU0lucHJvdmNNZVJCNTgw?=
 =?utf-8?B?dEVXZ1lXSm5oQkdPL3VEM0x5QXh3ejZwZXc4R2UxZGY4WjJRRzhiek51dFlM?=
 =?utf-8?B?cXNxMWZLc0FLKzFnSHlTU0R6QmMrUDhRT1UzOE5WVndBRkxVc3VIM0VCUk5W?=
 =?utf-8?B?YlAyeHZYSFIyVFFHdFltVUlRb2JrU1pFMXgrNnYzOFdQZHduVXhEdmJSaEtQ?=
 =?utf-8?B?cTJNbWtRSEcyM0JUVGk0MUhnUElVS2VpOUNJRzBnNEtkRWJUbFQ2YzRVeGJ1?=
 =?utf-8?B?UVNVTFFsQUxKWVJkZUExa1V3eTgzM25tbzRtMDZ0UVgvam5TbCtoc0JaZmEw?=
 =?utf-8?B?T0JWcHhMUnpwaVVYMEJXR3lqVjk0L28xUllMbUZXQVNZdWFNL25HVjlmVjVo?=
 =?utf-8?B?MlVNVC96V0VZc0JmSGJoQzZsKzViMktGZk9CejNPU0NqOGxEMWR3YkZMUHoy?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 175154f4-fe95-41f4-c992-08dba99dea61
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 21:13:11.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWi/al5na5PvvCa9NlmNHXACr1Hx9ErCLLaGpvw1kf7GF2KcP11DJlyyF81SCvlaX8bGOOIYMaSF7W3rnru+Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7307
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 22:20, Ira Weiny wrote:
> Both regions and decoders will need a new mode to reflect the new type
> of partition they are targeting on a device.  Regions reflect a dynamic
> capacity type which may point to different Dynamic Capacity (DC)
> Regions.  Decoder mode reflects a specific DC Region.
> 
> Define the new modes to use in subsequent patches and the helper
> functions associated with them.
> 
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> Changes for v2:
> [iweiny: split out from: Add dynamic capacity cxl region support.]
> ---
>   drivers/cxl/core/region.c |  4 ++++
>   drivers/cxl/cxl.h         | 23 +++++++++++++++++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 75041903b72c..69af1354bc5b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1772,6 +1772,8 @@ static bool cxl_modes_compatible(enum cxl_region_mode rmode,
>   		return true;
>   	if (rmode == CXL_REGION_PMEM && dmode == CXL_DECODER_PMEM)
>   		return true;
> +	if (rmode == CXL_REGION_DC && cxl_decoder_mode_is_dc(dmode))
> +		return true;
>   
>   	return false;
>   }
> @@ -2912,6 +2914,8 @@ cxl_decoder_to_region_mode(enum cxl_decoder_mode mode)
>   		return CXL_REGION_PMEM;
>   	case CXL_DECODER_DEAD:
>   		return CXL_REGION_DEAD;
> +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
> +		return CXL_REGION_DC;
>   	case CXL_DECODER_MIXED:
>   	default:
>   		return CXL_REGION_MIXED;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ed282dcd5cf5..d41f3f14fbe3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -356,6 +356,14 @@ enum cxl_decoder_mode {
>   	CXL_DECODER_NONE,
>   	CXL_DECODER_RAM,
>   	CXL_DECODER_PMEM,
> +	CXL_DECODER_DC0,
> +	CXL_DECODER_DC1,
> +	CXL_DECODER_DC2,
> +	CXL_DECODER_DC3,
> +	CXL_DECODER_DC4,
> +	CXL_DECODER_DC5,
> +	CXL_DECODER_DC6,
> +	CXL_DECODER_DC7,
>   	CXL_DECODER_MIXED,
>   	CXL_DECODER_DEAD,
>   };
> @@ -366,6 +374,14 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>   		[CXL_DECODER_NONE] = "none",
>   		[CXL_DECODER_RAM] = "ram",
>   		[CXL_DECODER_PMEM] = "pmem",
> +		[CXL_DECODER_DC0] = "dc0",
> +		[CXL_DECODER_DC1] = "dc1",
> +		[CXL_DECODER_DC2] = "dc2",
> +		[CXL_DECODER_DC3] = "dc3",
> +		[CXL_DECODER_DC4] = "dc4",
> +		[CXL_DECODER_DC5] = "dc5",
> +		[CXL_DECODER_DC6] = "dc6",
> +		[CXL_DECODER_DC7] = "dc7",
>   		[CXL_DECODER_MIXED] = "mixed",
>   	};
>   
> @@ -374,10 +390,16 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>   	return "mixed";
>   }
>   
> +static inline bool cxl_decoder_mode_is_dc(enum cxl_decoder_mode mode)
> +{
> +	return (mode >= CXL_DECODER_DC0 && mode <= CXL_DECODER_DC7);
> +}
> +
>   enum cxl_region_mode {
>   	CXL_REGION_NONE,
>   	CXL_REGION_RAM,
>   	CXL_REGION_PMEM,
> +	CXL_REGION_DC,
>   	CXL_REGION_MIXED,
>   	CXL_REGION_DEAD,
>   };
> @@ -388,6 +410,7 @@ static inline const char *cxl_region_mode_name(enum cxl_region_mode mode)
>   		[CXL_REGION_NONE] = "none",
>   		[CXL_REGION_RAM] = "ram",
>   		[CXL_REGION_PMEM] = "pmem",
> +		[CXL_REGION_DC] = "dc",
>   		[CXL_REGION_MIXED] = "mixed",
>   	};
>   
> 
