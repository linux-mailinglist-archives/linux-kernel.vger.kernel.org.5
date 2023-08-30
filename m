Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828CC78E33C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344481AbjH3X14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344463AbjH3X1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:27:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEB8122;
        Wed, 30 Aug 2023 16:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693438070; x=1724974070;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q02e8eVAuh7lsIOwy0OnwHXUVnd9RbDKonvZh/YB3ms=;
  b=kO6MAgqkRXt5lztraEHUK1SlERFZbbsXeuD3UU8yvqOsCJmOt4ZhE1xt
   CG+wqGzEh5jMQ8M8m3r+rf4fZUArFr694T+FpGhINm71wTPuK4ZiknC+j
   Nw+qt7ss3kMH4R+eMyyjMK/bJnTxhi7G0M6kkry/UGvc33xP4CC2We3LH
   ufgTloMwTdVh7SepCBvomvHjRkmA4L3VfTkRBuQUHFgipF1NW55DRNz6A
   yUmnLQ+3emSJBkM0eKucU7lCZ9uqkIU8XC2TwOsaOEyr9vhFk+VB3Ch0k
   B3x1rIMCqHEX1kbrvFAUGaTkTymoSjZQF0QIp5Gsb7bkDMtdWX3ZITeGS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="356088420"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="356088420"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 16:27:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="689086727"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="689086727"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2023 16:27:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 16:27:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 16:27:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 16:27:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 16:27:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnrVckPGnAgf1Fcdu8R8F/XNnJCveV7bUsEDvBrLhJYslMyJT+kkRqnbd8FledLC8Os/pat7Mc8oT8vEF+X+oPYt2Dh81EVvsd8rPx91/kc5lL0kmyJGHxlIkMw66l+DCM23pMsrSMP5N6NZLbjxUc/Hl3VCJhQMqc/ccWNTJjkjbgrQkwixNtPdk5fDBPPqH2h6QInmbhTcVOS49O1wU045XAyFRm0+HW06XvCoqSNWIthn2mhk5voukleRQb4cq8HSNwTUNxd57EZTx91IuiiGf2ArVGxD+U3Ush0DZTx9qH8sjpaaUJjc6AxwtXaPUV6rdMATYQasJh6UkK1lvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKIMGXalhtjV/XbPor5+r8RFVh14BApUcUrGZ/yV1Vg=;
 b=GdxzVWCA8aRgQXGjGgNiInciJhnN+NhB2Y7Mf9nXqVcGw2F0bXICR3a4QHh4E3aiUCVktiMxs7BnkI3fxXWoVy3wV0qW4AiOHlouNcUBlvw9sSXpe0wKOtXrNM+QsvP0ZNKR0XQZZN+6x/zJiJ550LSBIkjQYjAfapuPoW2/Z2K7QvONPm+cCdHWEqROMdDklwVXoWlLvjXkNa3xxI0GIhqAcjwqoj1dz/JsNK8i0Xeo7DgXbS9obFZwMd5S95Zst+SKPn08RtpsOLmYXXXZGCWt5j0W8KmM5Ma6lQKVDN3SkNFkD6iLLwN9lXW0UqtwNrWy2BsSCnWAMBapeIrsog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH3PR11MB7762.namprd11.prod.outlook.com (2603:10b6:610:151::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 23:27:23 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 23:27:23 +0000
Message-ID: <bb4716e5-5ebf-e818-3c37-7ff2f0cdde23@intel.com>
Date:   Wed, 30 Aug 2023 16:27:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH RFC v2 08/18] cxl/region: Add Dynamic Capacity CXL region
 support
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
 <20230604-dcd-type2-upstream-v2-8-f740c47e7916@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-8-f740c47e7916@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:334::16) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH3PR11MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: ab89dfcc-8f68-463d-db9a-08dba9b0a9ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfLnzL3webho/6RPxdpICX3JCOiZh3N3FjdnzG7FmA4/71KkieWXw/zWqs8wggymrYKxxX6QDUybnv4U7ABJ0Ai6DmmS5JKxnQJpbZDESF91IpaOT0cXT/34z99Ma8BCkllZ7Bszd0HsskDmMOneFceaXVpEdFqGB0UwW0DlLFyVBjRiMg5DZRMA35n3t5aaYatPgr4zcvi7p2RE5X55EROyreXJStTpjOSdKPC7cPbmxll9y/6s1QBOXuuWEnTvnubOYBRyBrNvGwRHj7FbjCk7hdi/jbJ99O6jI2VYA0IM5qXq+Zwy4KAv56JjDbABw15utKAUlGG30uAD+vmokuChJx1RLcD1wM1TWbndp8NnEjEXLvXZQ6Jci1jAlF18ECgm6qQenTE/a5N+CrE+jRejfm98x6xOF1uAEpZBsIbtif02uCSwgXn4f/UgRHNgtcz8k0i1OtheMngOomEFBeJsItf3QoG/LUu7nBmDVCZW8fuWb5kioiacm38fyO1elYVcoWntVwtsOzrghOIPjpyD83dGsWdciNXgPwlBRAjUj+iYvEWj9HLWkV4ti19CGsKXPrUnxexHNKX01No11Yas0k5l94hEpS1GY74uruH+0wYzTMz4f2J7ZeIjCp4pajjEOyCO8NPX0iJ6qKmR1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(186009)(451199024)(1800799009)(6512007)(2616005)(6486002)(82960400001)(86362001)(38100700002)(53546011)(6666004)(110136005)(31696002)(478600001)(83380400001)(6506007)(26005)(36756003)(54906003)(4326008)(66556008)(5660300002)(8676002)(66946007)(41300700001)(8936002)(44832011)(316002)(66476007)(30864003)(2906002)(31686004)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME9Ob1FFUUxQbGFnSDZuMnYyRTU5TEZxUzVoL284WDdqd3I4K0JkUFdDbEl4?=
 =?utf-8?B?Z0J6U2JvOXBFM3lhRk1ycjZZNTI4Y1QvaHp1OW4zeFhYQkxueFFMMUxodGdo?=
 =?utf-8?B?NzBaRyt2dk1CL1RrNjFLbEtodWtSQWFyeE1mekdpTFM0VGt3My83UlVzN1pz?=
 =?utf-8?B?bk45SzY0cE9nL0N6RUJRQXRDMnFSL0NaT09YRjFlWElTeXhiYW1lZjhSUjcr?=
 =?utf-8?B?UVhzS1Vua2NVbFJPSFVicDEreEJYMTdWbU5kQ3V3TDBaeXh1RWZlcjl5czZl?=
 =?utf-8?B?ck9qRUxrZzBxeTBnendvY2hmSmhDWkxQNEppdzVSNTU4U2Y5S295OTlTMHB2?=
 =?utf-8?B?Ky9OQkxCUEhtemZnZE1tVTNIb1RwOHVUOERuRmNwSXczN1V4Z1drWHhaNDRZ?=
 =?utf-8?B?bHJqSVlvS2NreVJGV3phdEI5b1lNZ1h3d2dTWndaN2sxaUdIYUNSU0MrYlB3?=
 =?utf-8?B?QlJXRDMwRTRHR3Eyak5OMGdkaDJBc1VoYkZTSEZTaVYvb29UYTVNOVZyeEoy?=
 =?utf-8?B?Q01XSWFOVjdjM3NaUlIzcXBwSFN6NFpCTHRrMHpkbWI0N21ZMEozUVNzQ3J0?=
 =?utf-8?B?bm0wZTg2Ujhud0xhcm56ZG95ZjRuVFV5eXR1WXVESjdsZFdEZDE3M2YvazRi?=
 =?utf-8?B?N2dhV3FTWEFHbUNUNURDdFlIQVpLbUdydldpRGtvUnlwQVlnK05mVzEvajEy?=
 =?utf-8?B?VllwRlZZZTk2QkhJY2JWTi9kcHdNeDhKcFVPUFNMbzVGWXN1SUJVaU5hbTd5?=
 =?utf-8?B?SjQ1bEVYc3g1OGpZek9NZzZzQ0lEK3RVaVFmTk83SUdDbG9lSzN1TnF4THlo?=
 =?utf-8?B?MzFJWW9KdUFaUktqTVdiV09xRUtLUkdXcDhSM2IvbTd2U0tNczBPb0MrMkdT?=
 =?utf-8?B?a0w3V3BjVDNjZVBGUUcyQzhMeVFYL1Y1RzhBbWRDNWZOTVo4a2NXK0VyM2RI?=
 =?utf-8?B?bHNXaVliV1A4RjRJK2NYeTNRY1ZwQ3B2Z3VscWp4YmJWbzA2dkhhT2NVOWEv?=
 =?utf-8?B?M0FpMGF6WE16TGtxWmVlRkNieEpvcEkxR2dPZjdTNVJ2RnRXQXI3cEtCdWpW?=
 =?utf-8?B?c3d4UDBtY0NnaDcrWjhRK3N3Wkx4VU43UWZvdDlWMjVobWd3anZoRUtyM2ZT?=
 =?utf-8?B?dUk1andtM1NoYVA0RVJ1VHdpNEN1MUJWZEhqckc3RUlXb1dTUkVVZ1MzSjFD?=
 =?utf-8?B?K3UyZm5TQXN1S0I4MkxJK1FFMSsyNUVBUTRqMkZRUkpOa3dxZDZEZ0krMTJi?=
 =?utf-8?B?cThsNFNXZ2tzTVpwa1oraEZQK0diNTZqZm9rSDF3OWVHa1M0YlVuTHdtcmY4?=
 =?utf-8?B?Y2hyMEJXQkdhOGFYVURqZ1YwSG9vOGV2OHQvdFY2TTBCdnNWcG14dnV2WEJU?=
 =?utf-8?B?eFpUSW1kdTMvaUxtaXNUcUpwalVwUDhoY3lnVkhjbHFLWFJCckZrdm44eGZO?=
 =?utf-8?B?NTk0TFowSnpVTXdFM0lGZW9LSHVWSFNTS0IzYjA0V2duNDhzUitXRXhZS0k5?=
 =?utf-8?B?YnZNT1dZSzBHSXlkRzhTUjVMWThHMVVGMjFKL09FVHdwcHFtdnBhOFRUSU40?=
 =?utf-8?B?Y2hqUGZqR05YVGFmTjZML1k1ZUJGK0NSRnlIQmd0RXF2eGFGMFJ1ZVpVSDV1?=
 =?utf-8?B?a1FXTm9IeEhjZ1ZlREVzcEE5WXZjUkFURW4vb1BxMlk5K3R5VXNEQ1Rna2Ux?=
 =?utf-8?B?YUQrUjh3VUx4blVWaWVubXhuRlhncVhoSytCcjAxVTZTN2dQNWt2eXArOTZj?=
 =?utf-8?B?MDV1dmxWRDdEdkhKeXByQ2N4ajNYZUoveUxyNm9Oc2Rna1FmbklYNGxxZ2Vi?=
 =?utf-8?B?V2xFeHFDUGwxU3UyUjdBUng2Z1hHcXFpUTZmR1g0Y2FyakphZ0xmRXl0MFpz?=
 =?utf-8?B?QkFGU0FHY0pFZjlQdWR1L0pDdGFEcnNlaVFvMFRQMEZQM0FlQWtKOVFBVCtT?=
 =?utf-8?B?QUNJNmFwU2xmZHVhQ2Q2YVdKY0lWWFhhTWQ2bXROUE1GL1pOVWZaSmZYYXV3?=
 =?utf-8?B?QTVualJCSmcrQ1FUZ2pJRW5tNTdZU245UmFMNENTeE1JYnNHYzgyNkFMU1VN?=
 =?utf-8?B?TVc5Z2xBV25aN1hIY3NtZmRsMlh2L3J1ZnBuSnIwdG4wWjl4Wm5meXJ2NUJR?=
 =?utf-8?B?YmtCUTZYenhJd2dPQko4c1ZLaGExR3A3UUd6U21wYkp5MnZUa1h5WEY3cGZ6?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab89dfcc-8f68-463d-db9a-08dba9b0a9ba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 23:27:23.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSGY9TtNOM+gbLF1bmNpTjznGVIR0ZDYGLhoxJdw16N2Q8A7gZPyEdM+Mxh9h/We9QTujnCn8CgoIzDUx0oyUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7762
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 22:20, Ira Weiny wrote:
> CXL devices optionally support dynamic capacity.  CXL Regions must be
> configured correctly to access this capacity.  Similar to ram and pmem
> partitions, DC Regions represent different partitions of the DPA space.
> 
> Interleaving is deferred due to the complexity of managing extents on
> multiple devices at the same time.  However, there is nothing which
> directly prevents interleave support at this time.  The check allows
> for early rejection.
> 
> To maintain backwards compatibility with older software, CXL regions
> need a default DAX device to hold the reference for the region until it
> is deleted.
> 
> Add create_dc_region sysfs entry to create DC regions.  Share the logic
> of devm_cxl_add_dax_region() and region_is_system_ram().  Special case
> DC capable CXL regions to create a 0 sized seed DAX device until others
> can be created on dynamic space later.
> 
> Flag dax_regions to indicate 0 capacity available until dax_region
> extents are supported by the region.
> 
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

You probably should update kernel version to v6.7. Otherwise
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> changes for v2:
> [iweiny: flag empty dax regions]
> [iweiny: Split out anything not directly related to creating a DC CXL
> 	 region]
> [iweiny: Separate out dev dax stuff]
> [iweiny/navneet: create 0 sized DAX device by default]
> [iweiny: use new DC region mode]
> ---
>   Documentation/ABI/testing/sysfs-bus-cxl | 20 +++++-----
>   drivers/cxl/core/core.h                 |  1 +
>   drivers/cxl/core/port.c                 |  1 +
>   drivers/cxl/core/region.c               | 71 ++++++++++++++++++++++++++++-----
>   drivers/dax/bus.c                       |  8 ++++
>   drivers/dax/bus.h                       |  1 +
>   drivers/dax/cxl.c                       | 15 ++++++-
>   7 files changed, 96 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index aa65dc5b4e13..a0562938ecac 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -351,20 +351,20 @@ Description:
>   		interleave_granularity).
>   
>   
> -What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
> +What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram,dc}_region
>   Date:		May, 2022, January, 2023
> -KernelVersion:	v6.0 (pmem), v6.3 (ram)
> +KernelVersion:	v6.0 (pmem), v6.3 (ram), v6.6 (dc)
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RW) Write a string in the form 'regionZ' to start the process
> -		of defining a new persistent, or volatile memory region
> -		(interleave-set) within the decode range bounded by root decoder
> -		'decoderX.Y'. The value written must match the current value
> -		returned from reading this attribute. An atomic compare exchange
> -		operation is done on write to assign the requested id to a
> -		region and allocate the region-id for the next creation attempt.
> -		EBUSY is returned if the region name written does not match the
> -		current cached value.
> +		of defining a new persistent, volatile, or Dynamic Capacity
> +		(DC) memory region (interleave-set) within the decode range
> +		bounded by root decoder 'decoderX.Y'. The value written must
> +		match the current value returned from reading this attribute.
> +		An atomic compare exchange operation is done on write to assign
> +		the requested id to a region and allocate the region-id for the
> +		next creation attempt.  EBUSY is returned if the region name
> +		written does not match the current cached value.
>   
>   
>   What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 45e7e044cf4a..cf3cf01cb95d 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -13,6 +13,7 @@ extern struct attribute_group cxl_base_attribute_group;
>   #ifdef CONFIG_CXL_REGION
>   extern struct device_attribute dev_attr_create_pmem_region;
>   extern struct device_attribute dev_attr_create_ram_region;
> +extern struct device_attribute dev_attr_create_dc_region;
>   extern struct device_attribute dev_attr_delete_region;
>   extern struct device_attribute dev_attr_region;
>   extern const struct device_type cxl_pmem_region_type;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index a5db710a63bc..608901bb7d91 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -314,6 +314,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>   	&dev_attr_target_list.attr,
>   	SET_CXL_REGION_ATTR(create_pmem_region)
>   	SET_CXL_REGION_ATTR(create_ram_region)
> +	SET_CXL_REGION_ATTR(create_dc_region)
>   	SET_CXL_REGION_ATTR(delete_region)
>   	NULL,
>   };
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 69af1354bc5b..fc8dee469244 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2271,6 +2271,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>   	switch (mode) {
>   	case CXL_REGION_RAM:
>   	case CXL_REGION_PMEM:
> +	case CXL_REGION_DC:
>   		break;
>   	default:
>   		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %s\n",
> @@ -2383,6 +2384,33 @@ static ssize_t create_ram_region_store(struct device *dev,
>   }
>   DEVICE_ATTR_RW(create_ram_region);
>   
> +static ssize_t create_dc_region_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	return __create_region_show(to_cxl_root_decoder(dev), buf);
> +}
> +
> +static ssize_t create_dc_region_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> +	struct cxl_region *cxlr;
> +	int rc, id;
> +
> +	rc = sscanf(buf, "region%d\n", &id);
> +	if (rc != 1)
> +		return -EINVAL;
> +
> +	cxlr = __create_region(cxlrd, id, CXL_REGION_DC,
> +			       CXL_DECODER_HOSTONLYMEM);
> +	if (IS_ERR(cxlr))
> +		return PTR_ERR(cxlr);
> +
> +	return len;
> +}
> +DEVICE_ATTR_RW(create_dc_region);
> +
>   static ssize_t region_show(struct device *dev, struct device_attribute *attr,
>   			   char *buf)
>   {
> @@ -2834,7 +2862,7 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
>   	device_unregister(&cxlr_dax->dev);
>   }
>   
> -static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> +static int __devm_cxl_add_dax_region(struct cxl_region *cxlr)
>   {
>   	struct cxl_dax_region *cxlr_dax;
>   	struct device *dev;
> @@ -2863,6 +2891,21 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>   	return rc;
>   }
>   
> +static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> +{
> +	return __devm_cxl_add_dax_region(cxlr);
> +}
> +
> +static int devm_cxl_add_dc_dax_region(struct cxl_region *cxlr)
> +{
> +	if (cxlr->params.interleave_ways != 1) {
> +		dev_err(&cxlr->dev, "Interleaving DC not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	return __devm_cxl_add_dax_region(cxlr);
> +}
> +
>   static int match_decoder_by_range(struct device *dev, void *data)
>   {
>   	struct range *r1, *r2 = data;
> @@ -3203,6 +3246,19 @@ static int is_system_ram(struct resource *res, void *arg)
>   	return 1;
>   }
>   
> +/*
> + * The region can not be manged by CXL if any portion of
> + * it is already online as 'System RAM'
> + */
> +static bool region_is_system_ram(struct cxl_region *cxlr,
> +				 struct cxl_region_params *p)
> +{
> +	return (walk_iomem_res_desc(IORES_DESC_NONE,
> +				    IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +				    p->res->start, p->res->end, cxlr,
> +				    is_system_ram) > 0);
> +}
> +
>   static int cxl_region_probe(struct device *dev)
>   {
>   	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -3242,14 +3298,7 @@ static int cxl_region_probe(struct device *dev)
>   	case CXL_REGION_PMEM:
>   		return devm_cxl_add_pmem_region(cxlr);
>   	case CXL_REGION_RAM:
> -		/*
> -		 * The region can not be manged by CXL if any portion of
> -		 * it is already online as 'System RAM'
> -		 */
> -		if (walk_iomem_res_desc(IORES_DESC_NONE,
> -					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> -					p->res->start, p->res->end, cxlr,
> -					is_system_ram) > 0)
> +		if (region_is_system_ram(cxlr, p))
>   			return 0;
>   
>   		/*
> @@ -3261,6 +3310,10 @@ static int cxl_region_probe(struct device *dev)
>   
>   		/* HDM-H routes to device-dax */
>   		return devm_cxl_add_dax_region(cxlr);
> +	case CXL_REGION_DC:
> +		if (region_is_system_ram(cxlr, p))
> +			return 0;
> +		return devm_cxl_add_dc_dax_region(cxlr);
>   	default:
>   		dev_dbg(&cxlr->dev, "unsupported region mode: %s\n",
>   			cxl_region_mode_name(cxlr->mode));
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 0ee96e6fc426..b76e49813a39 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -169,6 +169,11 @@ static bool is_static(struct dax_region *dax_region)
>   	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) != 0;
>   }
>   
> +static bool is_dynamic(struct dax_region *dax_region)
> +{
> +	return (dax_region->res.flags & IORESOURCE_DAX_DYNAMIC_CAP) != 0;
> +}
> +
>   bool static_dev_dax(struct dev_dax *dev_dax)
>   {
>   	return is_static(dev_dax->region);
> @@ -285,6 +290,9 @@ static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
>   
>   	device_lock_assert(dax_region->dev);
>   
> +	if (is_dynamic(dax_region))
> +		return 0;
> +
>   	for_each_dax_region_resource(dax_region, res)
>   		size -= resource_size(res);
>   	return size;
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index 1ccd23360124..74d8fe4a5532 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -13,6 +13,7 @@ struct dax_region;
>   /* dax bus specific ioresource flags */
>   #define IORESOURCE_DAX_STATIC BIT(0)
>   #define IORESOURCE_DAX_KMEM BIT(1)
> +#define IORESOURCE_DAX_DYNAMIC_CAP BIT(2)
>   
>   struct dax_region *alloc_dax_region(struct device *parent, int region_id,
>   		struct range *range, int target_node, unsigned int align,
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 8bc9d04034d6..147c8c69782b 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -13,19 +13,30 @@ static int cxl_dax_region_probe(struct device *dev)
>   	struct cxl_region *cxlr = cxlr_dax->cxlr;
>   	struct dax_region *dax_region;
>   	struct dev_dax_data data;
> +	resource_size_t dev_size;
> +	unsigned long flags;
>   
>   	if (nid == NUMA_NO_NODE)
>   		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>   
> +	dev_size = range_len(&cxlr_dax->hpa_range);
> +
> +	flags = IORESOURCE_DAX_KMEM;
> +	if (cxlr->mode == CXL_REGION_DC) {
> +		/* Add empty seed dax device */
> +		dev_size = 0;
> +		flags |= IORESOURCE_DAX_DYNAMIC_CAP;
> +	}
> +
>   	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
> -				      PMD_SIZE, IORESOURCE_DAX_KMEM);
> +				      PMD_SIZE, flags);
>   	if (!dax_region)
>   		return -ENOMEM;
>   
>   	data = (struct dev_dax_data) {
>   		.dax_region = dax_region,
>   		.id = -1,
> -		.size = range_len(&cxlr_dax->hpa_range),
> +		.size = dev_size,
>   	};
>   
>   	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
> 
