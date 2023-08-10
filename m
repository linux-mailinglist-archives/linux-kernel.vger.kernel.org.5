Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B883C776D87
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjHJBck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHJBcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:32:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B0110DC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 18:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691631158; x=1723167158;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=0qaG6RrMRfLg+6GVeATMnfy4SFh1h0ur9RjLLm7h06Y=;
  b=iXoKli1hGZOL5SLFzLYuEn926ldXTKLHpMKTDYT0ACArlXhIwLUzYUeq
   rJrzF+wHgzNMGj5SKPBiQnPkoIyN/gsba/QbyeRIB0l7vtfrdh15I9cwV
   mtLP82dRjJOJBs4wzngAVQw98goHXzgg+pNTM8PK6Lo7HOVfOU9O+j1fy
   waamU7gRlgrK3LQVZROHAKrSvU4BXpM33pretyICu3DFwuum6iLkOL3Rv
   fe6Ar4dxQKKwJnKFHzXu7E2Y0on9YJ2+mn7XkGvR+vHNvRenwrXwv/pCr
   6Lxo+fjlI1xrrlejyZyfaeEw3xroVHPsTikoCQZuTknOi6NsSs7gJovgF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="361404455"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="361404455"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 18:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="855757713"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="855757713"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2023 18:32:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 18:32:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 18:32:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 18:32:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 18:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8/clYeedLcCBAiopLyhctwnztiOd1vxI8tjhtzAbPbo/GGeBbzZQ+8pUofyUPAnXn9JO3e4LrxYySm5YodSosBcDoXDzgm8KqTaXVbrEADa9Ygk7yDL767MIMcV3ccjc5JRGCZUUIzHQ7e4fvRUVTt72u2zdXRrowUM4LzLseLcpvJle0PT98MmpTDrRioBv0NFYtQLlTwD9si5rMHbuasnGb8tE7A8dPYVPpFkdPTsy7t2UCPjr0cfYwuupkxw/jMab/4nZ7B7FE7OE5CkeQLnneTvzGVKVfgzH8uwkeOdKRZmZDpUJ37aVb/1EmFjnwI3CrZlRwNkOuzsZ0wzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03Nb9y4SYr8ATK5rjVw+qcAeNbZt5ErcfjhSi8ghLys=;
 b=S2fxEnN6QJ5fFeYoqie2xhz619NuLzLVYk6Jyr+kq1p8BKbIGA5cBWVOR4Ca5AtnGrc2QEljNxOQYLauw7EK+reuByFPnTxTGFIqOFI7WKre1WiD0l2bFzUJFFbNd5qOubqb7bWCUKq3gNJNbg1R/7fjEmnQxZ8T4B5Wum/kvYKVJSgHGb32N9/shzvXIGWoDeIvqqTiRcHV6aGgOLOSmrsTTbl3vYueo2b31mSmreOPmPOptxO5OB09/hZRnllBX5Y0aVZNwGmI4Io9hyxlL/cVkFq1F40NxjR8ceIcszvZwmbkU6qlhyC7SYm4yjC+Y2PKTPA8LpKzGek+rxZkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 01:32:35 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 01:32:35 +0000
Message-ID: <864d3a45-1e75-4110-91dc-264d9e77796c@intel.com>
Date:   Thu, 10 Aug 2023 09:30:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <yuzhao@google.com>, <willy@infradead.org>, <hughd@google.com>,
        <yosryahmed@google.com>, <david@redhat.com>, <shy828301@gmail.com>
References: <20230809061105.3369958-1-fengwei.yin@intel.com>
 <20230809061105.3369958-2-fengwei.yin@intel.com>
 <241cb5d6-0941-4dbb-9d16-9226d34ebaf8@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <241cb5d6-0941-4dbb-9d16-9226d34ebaf8@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0161.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::17) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH3PR11MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: bc072beb-71af-4ffb-0678-08db9941ac95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SW2tout3iBhbg9zlHCUTpEUX/AEuo/xMPV3VxOfg7V+L8+Dp1+2PYzYkdea/2bgMNPhwQ7f8pMDikNO4m50zjTVWqv/Ix5YmHsiSvekrnDuw57uLjMf0YO0nN6Ncy/ABl5Zg5iPW0qOBwxmYD9swFqrsAdK5qeBBBC7uiH7VkX5rgPrsGQ8Shq7bAvNBkwjGUoeKy5ng2+/G1tRoqYvKhhG1kFh9xy5RjNLzLYslfwg0y2Hr59zO+P3P5kYWbSurya7vFoWyYXC70hAmdIC1kzEiE2rxMyaIe9iHvVE1Kxgw2lAG9+jK6A6udO2D5kFUEjfFo29z6BkIGtHNLulinKo2+D5ZGe+ta7NIao8mYW+62RfjfQVP6Gf7zQmZLUR9jxPTMnx8EtT431kU4UzbU0lpllAucb2PHvY8t+U6yYYDSaJTEUkV9S0TIjsE1+UPeOOOjiFm/xhwSdFyCgk7xz9NCGD29FKdzJo2p9e05TO5qduwn1G16GMu0T31bFD7PmSLn0R+faye+81k96JupBZMXE1gg0319ArAOdcNh9KtWboIR5rMNX3LbVDXcjag4GBF2XtovzlsLFEku/k1KBpiBoGjKUDqgmjTwT7H9FXMhhzG6x2EH66FNCVgFE0NffFuzzAg5w/L5/ZL+2cJDEpCpv0gxHveT0FLVUmn63g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(136003)(366004)(396003)(1800799006)(186006)(451199021)(8676002)(8936002)(316002)(31686004)(6512007)(6486002)(6666004)(36756003)(7416002)(41300700001)(66476007)(66556008)(5660300002)(66946007)(478600001)(2906002)(38100700002)(921005)(82960400001)(83380400001)(26005)(2616005)(31696002)(86362001)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU9nazBGa3VxdFlBK2tVSUJSbEx5ZWMrMzRPUVpqQkc2dTZoSjFPMHZjVDMw?=
 =?utf-8?B?c1BwMEM2QTY5N2NCYzBveHY4K00rc01LRXByZVRKTElyc0xnQ1JKN2JVcjRO?=
 =?utf-8?B?UVFzejlaNVF3ZjgwQlJCbHFheHRZdGhNQ3dmazJ0dnlsSXJkVTNmcE5QVnZu?=
 =?utf-8?B?NFltdkVKWVArZVhiRWFTY3BTOEdROXl6WEIra0ptYkdCamk4SnE5bVNBQktK?=
 =?utf-8?B?R2ozMGZJNGZMMzBOcURXeWdEdjliWXFMVXBteWM1SmhCR3h6QUpKbkxoV3ND?=
 =?utf-8?B?VlpYeW85cmdzeGVXdGFpYUhrVnBTR3Rqd0tnNlNVYVQzUkcrazF6Q25Qajh1?=
 =?utf-8?B?VHNvdjl4YTE0c3g2RWFTckpuVmhXSDVnVkgxQWVJZmd3L2dmS2ZSOHMvWFN2?=
 =?utf-8?B?bjcyNE91M0t0bHFFQU9CdmFmYXBlRHlJRVFRZUFxVzhMdWRDQnc1MUhVTGdF?=
 =?utf-8?B?dlFsbTJScjBSb0RWd2dWY2hkQ0ozdGpKK3QyUEZoTmRsalNtWDhJVFZBajkv?=
 =?utf-8?B?R2d2R0loQzB4N0lOdkY1dUExZmtLMGVvV3RxYzlGUTY2c0ovdzIrN21WY241?=
 =?utf-8?B?YlRESTdOR0c5RXhoOVYyNWY0c2xpcXlxaG56K1prV1RmUUZqZ1VWb2V4WTNL?=
 =?utf-8?B?bGJSRDFpcC9jcm50NW9sS1VoY1dvQkxtSjJjWkptOFcvZGhUcnR4dVhnNHI4?=
 =?utf-8?B?VmppZG95R1BpaW1CYUpjQ0I0czNmTUJld3NpajFiWUNDMTlPaUd3dlBGYVVj?=
 =?utf-8?B?QjRueTg5bjdUbUk0RkkwQmZWZ1ZhZmdESnVCM2doamJmRnI4VnlYZmMzaU5K?=
 =?utf-8?B?bzhSNWpJSlJiMmsvMklrRU9uTHNKSmNXVGVYd2tZMHNRUkk1NXdqV2RUcUpH?=
 =?utf-8?B?TW50NUlpdWtXOWZXYkdoT2wyZEdjZHJnS2Y2TDh2VkE0NEZXcm5EdEtOc0hv?=
 =?utf-8?B?QXJJdUwyRkVZcnhXcSs0WWtjSmpmRXlIVndCbWNlU0NrNm1GNFRtQjdXeCtp?=
 =?utf-8?B?eEhVajRhTVBuYld3cXRyWDZuSGVMKzFwcERtOTdSK1FVcVMzQWYyY2Z5MHps?=
 =?utf-8?B?elZ3WXlCekdTOVNGaHFLcFdUMm8vWStsbXpKbUg3WGFibUdtMFJzYnN5dFJi?=
 =?utf-8?B?LytNTXhReXY3TU1sWk1XSzJWZUhoUGs1a0dLNUhlR3o0QWQwcXI2aTFXOUZH?=
 =?utf-8?B?eHFHOVp1Z0k3dnVvVXR4eW5TYmNlSDA4RmdRYis5VXI5VkVMU2NwbzRvZjY2?=
 =?utf-8?B?YUloQjlwQXZEb2o2ckhMK2xiWVVGZlZWOVRmdEJYZmU3WTlRVzZWUU9wa1NT?=
 =?utf-8?B?WFU5UDBubkErZ3U3M0MrSThBcE5XYzhtaWxaSWorUFprZ1NTZHl2SkxQcnNJ?=
 =?utf-8?B?MjQ5TmZnQ0dCWkRZNFFKU3pwOXJ2eVhHTllqeXhheEZ1b1JPQ3dIVnlRUllS?=
 =?utf-8?B?NmxGSE9zVzROWUhKZFRsS2xlam1lWUpMTjRqQXI1eThtakVHRmVRUk1wdFMr?=
 =?utf-8?B?aS93MHRadVA4MDFvUTJZbXN6NHZOaEJwZ3JOL1k0cTJ6dTRUY3Y3L1ppTW5t?=
 =?utf-8?B?eGtXUUh0ZGt2bWZKMWUwVkxobEhBVHc4bWhMNWkzNlVqeHpnaExMODlZMjl6?=
 =?utf-8?B?Uk9oZ1VtcXpsVGVtNXV3ZVU1Q3RFTmtwSzlHL21ZY3g2YlUxNWtuOHp1L05L?=
 =?utf-8?B?clV3QURVbHVPZkNBRUpPVTZEaDBaS2VlSXhFbzRYRDBKcFUwaGJaUHRwSXE5?=
 =?utf-8?B?VCtoSS82RlFnUHA0VDdvYVJNZXlpMGxIRU1GZmQ1QjhRK2U4OFJjcDFtZlQ1?=
 =?utf-8?B?MmtlcFRQenczR2pTS1NMMFI5VGMwemZtSzY5YnRmUlo0dDBJaVRTWHdOWEdP?=
 =?utf-8?B?YURWYzN1UjZwOTExQlNpVHo5U2F3QVcvRlllNHRhUk94clVYajBiYWlrQ052?=
 =?utf-8?B?S1RLRlVzYThoeG82RWpyNHVVWSs1ZTNKMnRVTENFUjEzZUZEQkJ1M3BEOTNR?=
 =?utf-8?B?Y1JKWkRsYVZxN1JuVDdvaHFla2pzMVZ0ZTdIV3V3VGpwNERNN2JNWWN5c2FW?=
 =?utf-8?B?cTZHNkJKRVQyKytISVNNOWRtR1lXbCtGaVkxakRlWHV1WUFzMUxZYXRQeXlx?=
 =?utf-8?B?RWZMWE5JZEI4YnFSbVlRWGdLTjlmQUNmZmVwNFU2a2QyR2c4UXlNUG1GelpM?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc072beb-71af-4ffb-0678-08db9941ac95
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 01:32:35.1770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffM1chCK71RjGlBUhbTSA9WD8+7H1qSZ/yGtEWLjkXXak0V5zggNa8axsYPUxcaXV5PlvmXukBesIUbNCZF/IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7180
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/23 03:34, Ryan Roberts wrote:
> On 09/08/2023 07:11, Yin Fengwei wrote:
>> It will be used to check whether the folio is mapped to specific
>> VMA and whether the mapping address of folio is in the range.
>>
>> Also a helper function folio_within_vma() to check whether folio
>> is in the range of vma based on folio_in_range().
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> ---
>>  mm/internal.h | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 154da4f0d557..5d1b71010fd2 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -585,6 +585,41 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>>  				   bool write, int *locked);
>>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>>  			       unsigned long bytes);
>> +
>> +static inline bool
>> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
>> +		unsigned long start, unsigned long end)
> 
> I still think it would be beneficial to have a comment block describing the
> requirements and behaviour of the function:
Definitely. Thanks a lot for reminding me again.

> 
>  - folio must have at least 1 page that is mapped in vma
This is typical usage. 

>  - the result tells you if the folio lies within the range, but it does not tell
> you that all of its pages are actually _mapped_ (e.g. they may not have been
> faulted in yet).
Exactly. Something like following:

This function can't tell whether the folio is fully mapped in the range as it
doesn't check whether all pages of filio are associated with page table of VMA.
Caller needs to do page table check if it cares about the fully mapping.

Typical usage (mlock or madvise) is caller calls this function to check whether
the folio is in the range first. Then check page table to know whether the
folio is fully mapped to the range when it knows at least 1 page of folio is
associated with page table of VMA.

> 
>  - I think [start, end) is intended intersect with the vma too? (although I'm
> pretty sure sure the logic works if it doesn't?)
> 
>> +{
>> +	pgoff_t pgoff, addr;
>> +	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>> +
>> +	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
>> +	if (start > end)
>> +		return false;
>> +
>> +	if (start < vma->vm_start)
>> +		start = vma->vm_start;
>> +
>> +	if (end > vma->vm_end)
>> +		end = vma->vm_end;
>> +
>> +	pgoff = folio_pgoff(folio);
>> +
>> +	/* if folio start address is not in vma range */
>> +	if (!in_range(pgoff, vma->vm_pgoff, vma_pglen))
>> +		return false;
>> +
>> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>> +
>> +	return !(addr < start || end - addr < folio_size(folio));
>> +}
>> +
>> +static inline bool
>> +folio_within_vma(struct folio *folio, struct vm_area_struct *vma)
> 
> why call this *within* but call the folio_in_range() *in*? Feels cleaner to use
> the same word for both.
Good point. I will change folio_in_range() to folio_within_range().


Regards
Yin, Fengwei

> 
>> +{
>> +	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end);
>> +}
>> +
>>  /*
>>   * mlock_vma_folio() and munlock_vma_folio():
>>   * should be called with vma's mmap_lock held for read or write,
> 
